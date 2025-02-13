Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5DCC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 19:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tifKU-0006OB-Ow; Thu, 13 Feb 2025 14:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tifKS-0006O2-Gu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:56:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1tifKQ-00022e-Sq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 14:56:56 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DGVKpi012373;
 Thu, 13 Feb 2025 19:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=MYSpuHB6p2wXxqB1PwKrBF
 Ft2rV8oewXRKjoXtiiDys=; b=JX4HrSQvDZakXDQiIiEnMNi7SsQ77c2mCrxhEw
 nA73GKHdLI558uJEfoyVD/BTfixeR612T/SNT7E9ZuBifQ2MHAJJcxuVAXYJime3
 JBUw+5Y/mTNcGuiauGfVEAyifmf0KV7hKit0OWrtpkZSqQFIA4iUz7pW9ayHKw26
 sIjmsSKo4wwyPdVMP9r3Js1lXheS4zyDNhP2lxx/7EHOiop1WZKDQySwmyY8kx1y
 pp+VCnf3Gwz1dbwySm3ej09lybH+E3SxaK0g6S4Jz5OgMmgnqtiUFft7qMM7dNrM
 1CZMPNVTtzbmIOCvg9SnnLVOTQVNVM8u2hZzI2REKdwhW59Q==
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sc5u9ycn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Feb 2025 19:56:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTxqwhDz1avqUhC2R5P0IDZIo0vnt7Hi+OX5Elbe2Q5xCekC0qT8fwCAVaLJdmv0Vl18FSr4x/FbW0VzqLMyxUuDbKDZgWEPkQv9UmUXMn86DX3+BeEZIVqkRoLDb3vKgDaXLtpr5T9vaBF9rxGgQNSj1r2kw4eMnG+92yV/UtGwcxmgdUXGjUjLVA9tkqi3LRtG52DgHApDcVUOMyhU1mkRkYnRWSpLguw7oVAeqfj/Ssn92DCdLSInX+ClMGTdqUOa9aQaRr7NlwsG5azUiMqSW8dLOavL+63afZmXEPMhpBNhG8auyUGEgm4IdOkJVawVszef+YTpl2Hfzqlqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYSpuHB6p2wXxqB1PwKrBFFt2rV8oewXRKjoXtiiDys=;
 b=OriGbBNec0hy1SaAvqTDA+gqMepHpICbyCjYfYQJ78L8Fc6SH/B6FP9medcj7Q2R6JleL6VH5X4LXawdoXv12Tcpk3upDhrMF6PJ5sJK57wDXvuxFgH+riUmhz6i32CNx4olckwWLY23SA6+5aNH/LoXOZB8HbC8lBRwX6SqNwpFSSTPKBOhCCoNQ+PgjH5co/aY6mm/9KWML7NF8Dx28YLARwYD3MYXrwT7TkVFN3E4nY24XWLUP3PAuBqkYJ8Q50huNOyCI9+TTwfFQP3HzTABnHcqlIH8/YXF+P11OSLAm5kpxHIbu0QZ4fvMKoxjwQAKrC/665+gnLVFwl7s2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by BY1PR02MB10379.namprd02.prod.outlook.com (2603:10b6:a03:5a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 19:56:46 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::ef24:407b:1d69:2891%5]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 19:56:46 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
CC: Sid Manning <sidneym@quicinc.com>
Subject: [PATCH 0/1] accel/kvm: set coalesced_mmio_ring to NULL after kvm_run
 is unmapped
Thread-Topic: [PATCH 0/1] accel/kvm: set coalesced_mmio_ring to NULL after
 kvm_run is unmapped
Thread-Index: Adt+UPrNTTvgGE8qQmKfsZQ6oh/NmQ==
Date: Thu, 13 Feb 2025 19:56:46 +0000
Message-ID: <IA0PR02MB948677B1A461BE2D0FB8481ABEFF2@IA0PR02MB9486.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|BY1PR02MB10379:EE_
x-ms-office365-filtering-correlation-id: 2eab6e8a-edde-46ad-313c-08dd4c688bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WuVdT7nwnu6Qq7MBTn6an7S5Vmj8L6S1sV27qJ6sRffhL3P5cLfqFUcV9ye9?=
 =?us-ascii?Q?zHUCoPMp2NE4NlWMfqC2qewdD6jdg2VFr8WI+Ob+MFLxT5weTzBXgaT+bnQ3?=
 =?us-ascii?Q?NIgWaX1PMlRKspsW+TXwTOtyIjZCXpCqkFr/yq/TSFjLu9CHqEtUR6o9aOTC?=
 =?us-ascii?Q?oD7pei+rRMcxJIPYqi01476cxZ1OCIykrQ0Rxk0sNcTwJrvsruWXIMyMz1N9?=
 =?us-ascii?Q?tx1aGhcbmKs5ldc/HKT2wX+xuUnJr+PyiXi+g3cJ0RJEB6qwlerrRbOHmjmn?=
 =?us-ascii?Q?zNVEuwNARCYfvCbYvmti3cxt/fry0I0FdjW+hYnvakJCAI1NcWxYH6NDjqtC?=
 =?us-ascii?Q?/NFUsAJlRqLzaQBN8AVsJQYVhrDZxzxXWP7bnK916bPGis6RWHZY1X4Iouli?=
 =?us-ascii?Q?IfRiDzqUqnIa7T1kX7mkR1v01PpwmM0i1Ggmf1U3VQItckavI3HJkuptaHXd?=
 =?us-ascii?Q?70/4KtDRGqvAdDBUfPZkdCpOH5eQYUuZd9ssf40LwOCIsKgq+cBH28LiDblo?=
 =?us-ascii?Q?23thmmeKWb9P9a2Jru88Nf2zzfxvQtiFpZO/3sceoSmdQfD/uBKil0dfltw9?=
 =?us-ascii?Q?RpQZJNv4vl37DpToEIuUJn+l4bGCEtTu1JYO94ZQwogKYIFctMxj5PjMnKKV?=
 =?us-ascii?Q?l6teyE/uOAZzIChqDoD5id9z9leQ6rN1uTSOGMy/VPRSopxM0tstQlzhvn+I?=
 =?us-ascii?Q?z/jGB8sF0wnTJ8bafUcx8xZVo7elxwSqdRchHYsuTlCaYnU9m5Giwt23/Fo4?=
 =?us-ascii?Q?0xSQPMJgJupesXVrERgd3v8d+od4jgPLavb+v/FR+WbkrQFh4HpXFh1Lg4LA?=
 =?us-ascii?Q?DQ4GnIeM2otCmD+js9jCVElnLW9OJRD5ta8EbRaTM/61uIEU2ddApmAKu/JM?=
 =?us-ascii?Q?hGsO0hJ3Nih1p/zNPU5pxgNIoEwrLlpZn7bVaA4lLrIt/m5Va2Ks8TZfD3d/?=
 =?us-ascii?Q?tUtiqT88xXVz7DUhFiwTAWlpAV4YvuUQnLA9taVPxNj/qKdESCpx8ywx+Mci?=
 =?us-ascii?Q?6k4SQN3X1Dfh3ZXCp1sZiZQfeOVMXU77NtMXOdL9A/5HURj4DQnJBpmiHsWQ?=
 =?us-ascii?Q?FN/ADh+/NI4R++WO4GQqT9Ov0cOnHOVLaJCNidqznlNJnUk7mPYXgAZ/JGns?=
 =?us-ascii?Q?bY35mJYOVS4CjWvdJw08iHnzbqmCsCLvwC0EAWZ0H5mpjGHEWIxePGkz2I1e?=
 =?us-ascii?Q?/UUCNoPrW+VFeqZwGBpCH3+59ACshrrIIKJdpAJTZ8hbCVPG/GTh7CPldpqZ?=
 =?us-ascii?Q?xCMY/szqs79FZgi/cnPtTch018yDXvZg0IvRXWBcw9tCrDjB6NgPRcbQRhy0?=
 =?us-ascii?Q?TZabcHvfSIDyeTgCIOTwF0MpbUZl3hCMu6BQb0/1DFRcTxoQWiKLcjFuuNrb?=
 =?us-ascii?Q?xdcBNhgzN9JMrK6J7SPJVy7bwlBU7qTwbQvZEV1ouFb87ZWCyU6xhyq/zu3x?=
 =?us-ascii?Q?hKBRDx+gfovaEV7igKqZ/d7gof4/aS44?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mb+S9w8zkECPPq98koGzJriG4XDgNKRlSpZnttLGWsrgQtNtS2JC9gejNKeU?=
 =?us-ascii?Q?jLtb6PeLNyNXImga2PVkousXHB9nmVgNqf6aPXb3JzAYEmx0Asxq9tVZ/eHm?=
 =?us-ascii?Q?XRFLzEgAIQPusGB7jf5IW8Pvcz6O3RsDnYUvJOyw+57NPZcIkYpzLQ5yqv5x?=
 =?us-ascii?Q?LfQFJVfXyXzmCrkmLh/UqmlP60vtTYXKBQMp+nxyTaKfpL+pfkzgv+8FG36F?=
 =?us-ascii?Q?Q5qwzEAt4ZV+z8UBdmbYzvaYpwD4vgLD3WbF2k1jPh7jM9+j4F9H4U138VWE?=
 =?us-ascii?Q?vV3nI+xh15/Cuan9NKBmWKlCZGKiMFDhugN2ocXWk9OAG0EBuCU8U9xEKR+K?=
 =?us-ascii?Q?PdmCCucZo32ZLpdXwev6kx+DDWSIb8mf2wOQB9SAwKr1RuLWKXvZ0+2niPgp?=
 =?us-ascii?Q?bSBgJcDe01vjwKWmYn+2yHQIQRtJtc4KO8XiA6ypZA9+LiFgnQI4uRxRBIzJ?=
 =?us-ascii?Q?g6k5j3P93Ght3fvWLL9rJIC9PzQSHkTKk5R1goE9DwgaVnrCY0OMTCbGQZTK?=
 =?us-ascii?Q?D3yQi2fDDXYmbDTMM/vhJ/E2qJPv+fkl077NTUj/wTFbX79EIuw34kNoxKwU?=
 =?us-ascii?Q?13xla32KivbQYgNWgsVznTUzKO7N0rXopo+tQzq6z0zdKpPxp1AV3kAKeGhY?=
 =?us-ascii?Q?EupHBwtUEWUXdwCU3kPw/3JjWDyLDy8v4OtVpty7mUT96PWJZd4JgTP2+BkA?=
 =?us-ascii?Q?W2Ck7Rr/xcwzXdSpo/SxD1ZcbkS1OL3ylHsajZaS4DrcSsoyTQVzUABqFkH7?=
 =?us-ascii?Q?7nzb/ca+VR8GnFVwFnhH+7i52KBZMB1SjD7uMzTX/RdhYGegP/ukX4inHaut?=
 =?us-ascii?Q?POKzk6w98WGzU/YYFV/rj3AXLxhXfog1/byU/ECgn3RXA9p0FDEoPivO7Yfi?=
 =?us-ascii?Q?PVOhOA2yZBH3gU3MQJTbRqQehOrzGxMNwdP9eq8X3S5wDgskX6IyuOOzqA7o?=
 =?us-ascii?Q?9GsUlMsJypKPOElNUlvFOmciC8r22pAC17OyLkg9K43NVMg9FByuDwm5AtHg?=
 =?us-ascii?Q?qokNewa7HaKDhMLOllTYHaA3Ttyvrgcita4JmW4vi9iTWWWJjplQYt1yJiPQ?=
 =?us-ascii?Q?AY3McrDjLGcXTSx0/5cCCATDDIm/8/skuX8UT45JrbsdA3QYWwUsjQjq6lCl?=
 =?us-ascii?Q?pGUkhoNhsnj9fsDOWCfA9kkaI0qzSVfbMo4nl/KTrBZ+EcFY8NeNXYd6+zbm?=
 =?us-ascii?Q?qXceNVH9nelUNGT1qX4dL0JJmyqb8pYU90Kpef/8ul3m1gi/FJXzVAUvL1SP?=
 =?us-ascii?Q?SBISLMg4ZNuw3NxsARP1ILZon8StJudYICcJd3kMViuVDWWCNdb6HV7a+5kH?=
 =?us-ascii?Q?veUJZm0IpiOV27kNph1Yw3XrE+rUKaagGY9Jz5o3WlJPqK0CvYGkz5HE4VJl?=
 =?us-ascii?Q?tq3B2quepZKOzdBkV9kmiNlRf7lrCO9tAy9rbmuXZ6WMj8kJzCydv7A97hRM?=
 =?us-ascii?Q?LXRVxnZEfOsEwzHx/vgpWzO4/+Je8IJbteeqmhIMaaDwgHoVQkCMNvTAm73w?=
 =?us-ascii?Q?Sorm25HvT3DRZ6mHoH2CGJc99nuAgE2kXUlrE6g5lv3KUZ9/u/ZoewupCvyo?=
 =?us-ascii?Q?NZWNEfO2E9vi71iaWH07DgHBEnaW4hJPTEhud0Jc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z44BZUfS+6K0yYcdaGr2Yk/7t/3lXBPM1XsTab/W4+1D2qFd8wx577F8iMWqlqA/vlUyVjbuu0qBpwQVMZ8CzVEVfz7L8cJzpZ82EHQPdWuoaRWaDlpQJGrRjpJEYM6OWTmGQV6uTeLAx0oQqQlUj7Oj36bq0rxv5Ce0JhmTs5MUXItWNEljSWwWIc/BTgiCtnzBUxZMAx+iKOductXZYaPpZx5PzdiOlRlNpBhe0fGnaEhbR3MIJIjw5ZfJGZoUZSPOU3uweBpOGzhcJcDMrISsT8jjaAWc2aYPC8/OcTEpRrAglMZH9mhFHSPl/o+BkKUkI5zBaAx4JXr9Cmnlj30YON7Q2iGoakEY5de83v37tkk3zSFSEc0zLNeW0mBIV8DWiJqTb9NAeLAifX1V4t2SMnAeLQNLIEjsQXelogUbjewbxkZjI67M5S0cWmFBKrzNg2FyTFxi/TPCAX0RsEu6bPX118QK4X1XdOtHzrU+Pd1MLWvcQBn1U810uasYBLnCMq+dVkb+5qGxjMqAkGHJklpBcKqIepFrYOSwVdNvPWq3ASkyzOKF4rFzCi+HuVUk5BBG6Oy0VSBWBjKF5ER7H5vmcs1CkKKYNI8OInpYK8F4WFr/vlmsQZCuskhK
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eab6e8a-edde-46ad-313c-08dd4c688bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 19:56:46.2379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9sUldRhqRG0yBoOYvAJV78Xb5oUilRFcmuwnrnwL9zhkIE186tSorEU+EsKvM8W3cYSJOVMCwuC+A0XDOIN0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10379
X-Proofpoint-GUID: 4T2sOCE5uk7WDTzSCY965aK4JZcn2OnP
X-Proofpoint-ORIG-GUID: 4T2sOCE5uk7WDTzSCY965aK4JZcn2OnP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=748 adultscore=0 phishscore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502130140
Received-SPF: pass client-ip=205.220.180.131; envelope-from=sidneym@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Encountered a segfault while exiting because kvm_flush_coalesced_mmio_buffe=
r
was getting called after do_kvm_destroy_vcpu unmapped cpu->kvm_run.

kvm_state->coalesced_mmio_ring is an offset from cpu->kvm_run so it needs t=
o
be set to NULL after kvm_run is unmapped to avoid getting dereferenced
by kvm_flush_coalesced_mmio_buffer.

Sid Manning (1):
  accel/kvm: set coalesced_mmio_ring to NULL after kvm_run is unmapped

 accel/kvm/kvm-all.c | 2 ++
 1 file changed, 2 insertions(+)

--=20
2.34.1

