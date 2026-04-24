Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B738CFE51E6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 09:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGCWs-0000Vw-3G; Fri, 24 Apr 2026 05:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wGCWp-0000VZ-SY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:08:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1wGCWo-0000Lv-89
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 05:08:51 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O1dn5X1914471; Fri, 24 Apr 2026 02:08:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=oFB0GMciXysYURV
 qI6pbY/GfvpzLr2eKPMrLR4fnaf0=; b=aMVCWNM9tS3FHfaZkkkKhI9ppMF0VTQ
 FCP5GBUslZFeki5xr63kMzoD/Thb3naudWGO0xQ6tY3PqsqqzE/UmqFC2KDtRkVj
 Q7agrX+hN6Da8vpSDavhmCWDtwBh/8LyzRRNO6/9j2MThJNuQEp8nI6rolGef5ZT
 wFux4vSCMrYAJTNttszJDCJIeIgWTmEIycHZ5CiVHS/jnjQYCSpjLZpalcMkJo7R
 1Du7XQJEfP9RMIQ/lr8aJwoTjxdo5oKb/75VlRPvlrmP+rsAXX84Ae+BRDMd8RWF
 j2QqdBEBFs63hY/5IE3yJk1wgVTjUJvt/UMrVrJ/HmTuRMVuNhEKoiQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020116.outbound.protection.outlook.com [52.101.85.116])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4dqy20gucq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 02:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooNQ9T0fEXQo8H/iT6j8BBVLzovkjaQ60OOf38n8p7Kal21GX5SS6llqx4k5c6CXVCrut803EO/DtTLyujJKeYCfFC40g9InaHSXCMkuWyJ/CWiqun/Cp+WjFasUbSoLYT+V6Yf3RalFJ3d/mCnF1wczo0FgD1YFDCx/pFQtBlnyn+itukIyGhlFy9mvTgY7mZnzL3l2ZADXKRHCqatWBxU3Ha+/oNzU5iq0RI8Apx5wJSp0NKNj9oD4/HwcbG2ohQTgaXp0a4+e0UxuiEapZK4Hfc/p7ChN05P7bbDPKkpKqS4Uu2v1WS1sW1fgMHZ/ZSBXFK+EVD8dAqRWcD9Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFB0GMciXysYURVqI6pbY/GfvpzLr2eKPMrLR4fnaf0=;
 b=eYYvN/pw4lfOwJ5g5P52P6JT5dUq0FuL5/ReqCtQHNLuytlFIuZPtvDarvUv29sA5G2Un9zdfTx1EPUbGuaBizE6F4JXLoQtyGYZ6K0/pWUGqP3Clrcb09YA6TbOx85ne9WvO6SMvCoRowzYY4VfUEzjTofgtxi7s+OfceHq0RFnkHMAU2k8B7FsRdfTAJ2kyLJrZZcpBTBBfNSZkeWhC7rlJp9wvT+rpACNAfECckkiMdk08GgFgI4OxM6agSO0KPnQ3HtUnMaYSevsXY+cI4+yBSwhOVd6xyHsPsKWNyktGVYDP/SvTNtPmAyhUyQquhdbuGJfHqDsaCEefwhBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFB0GMciXysYURVqI6pbY/GfvpzLr2eKPMrLR4fnaf0=;
 b=dz+gk0DLX12tlgJwyGkdjX6hTSIYOdDKAhj49PCNO6VodvDMM/UYV2mMcnb3WVnJDUAt2eQWjF28wVLWHWgNv/g+vkMj6+kI9rg1aNWEXy7cxd9ac6d2yx255NaL17pqLVbyhp/JnxFfUN85Qf2pPFOJMGXSPq71lg7kh1lNTmjWboTb625McdzWGPJiDS3irkxnd2Tq9L9/VYzN63UlSIuNV9CG7Edv5E+JIkeTKUXhPMdRbvI7uEn9EFvGPhuKFhKhHL6FsfWZNlYxXY3ie3fVeQ648helI/pyPbeGEsbq3ilqkTuPqOitp+y34b6+BKGr7RW15Fbx2yklDmciJg==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by LV4PR02MB11003.namprd02.prod.outlook.com (2603:10b6:408:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 09:08:43 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::dbc1:9766:c58d:4887%6]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 09:08:43 +0000
Date: Fri, 24 Apr 2026 10:08:39 +0100
From: John Levon <john.levon@nutanix.com>
To: zhaoguohan@kylinos.cn
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio-user: avoid leaking duplicate device name
Message-ID: <aeszF6BWBwb22GMu@lent>
References: <20260424032209.297458-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424032209.297458-1-zhaoguohan@kylinos.cn>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|LV4PR02MB11003:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4e238f-c98f-41b3-3098-08dea1e11531
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: poUrudGrWVdjTEp2Co2KagwIBSYq57OiiqRHLkZKlmUBkKlX2RZcPyKcOgxKTPgUx5BS4B08U4aTY7YE7NXSnInPTO0cxM6qf96+dsAbkJex7X3lJa28dEw94qXxBHGu1jzZDCMo47KVx+m4FfYmyZ6wF61Uo1cIcCZQESb1aCEZeTuOdzUWVXraEEJeXTTi8zbwLRENU+qShT4k0cX3FTIWUT/DGNnbjF2G9ZN47l1hy9jpqQcEnYvdGdmbyiPpqCoRKgCirwCSJ8NOXq/itJ2NdMVP8CBiUgIIbys+Kc2evUA7hEh4LeeB3NLOshr+YoK1ozYRZXuW+o7ZN179ybfgPVaiTW+aApfdCtsXiFnX6CKvE1WZ2QvmoKDc/H9go3I6RtuZNqI+LLPPauJnM+k2rRYHrphrTmUupIwqlLwnHTIraMO/kq2g68ooguENb6Nhr9Y8M5nS+IKXBemHUR2y1RY7wLi9e+IC1lKMZoeL68BlkT6Z8LP4qysoDEQoorL3UOxfvUTkyvc2g9aolg8FZoUphM58jbHAtRju4fZ79zuhNrCTC+f0jncUm3QiQ7f30bo5rqlYemIQaBHC7+S/ycImyOvtQKz0QaR1qq9HFjwpUE684UoH5mYvaXQ2hNxUDG6eKq3OpkonH0Rhk8tl+ho9zs+PvlGQONyVEHuP+mNVu1DA1QyYGtQdV2DXGR0gUsCmeutUk5WgRYpsn1rKVywhIoffXYi40QqqZdM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GG5b5Z5Nd+TRptSfy5rreUPbqsKfeh95pInkATjSFXAiPEjEB1wfbQPfzccZ?=
 =?us-ascii?Q?rxWVurSo/JlPMDPLAq92UZlc2CibtL/Z3wF5eadnAf0NNm1MqW5R+gzq113u?=
 =?us-ascii?Q?MhzMo7//r2rGswaqe237HhprIPUdwgXeibNcve/5t5Ok08bi2Hvto5JyOGri?=
 =?us-ascii?Q?LAfccmeyKj88nyup2JYCroTlFrLCMwtEjz3FiKbwV3wlooFvcNUp3blTdzjg?=
 =?us-ascii?Q?wrpKCo8ZNrzsXVX7W+52N72bAMwv7a8VsFuvwdKgOy4INW8ngMsf1Big4NBU?=
 =?us-ascii?Q?Cu2jbWMgwuHCr8TCyH8J/50fCGN3zEcurKcAkemBqkjNdFi0aEMS+aGWvCZr?=
 =?us-ascii?Q?cDPr46eX8ZOgDfiIRgFzvYGFcIpqX+oAHYWyrGbLTSSvW48jWljAI+pdvCbL?=
 =?us-ascii?Q?NSsgDSqjcxshLMFtZ739Q0ANKtpoyL1ib4UKN/9WjP1t5xwmWbEp0+nMVlm5?=
 =?us-ascii?Q?00IiYz5pDK0ncJWuFWfUu6RPB3uNiHMDNNI8offkPrh3oUxOH3cxRP0c+s5H?=
 =?us-ascii?Q?iiKl53f+tAwthyVZyI1C50ktw5dECGi1USj11SIOTaqFXNrCl68qwtbBHi0E?=
 =?us-ascii?Q?eZ8jtw4QcWusx/6iV87qnv/CeuGCkoZOoLyLlkiGlOfwk6UAXyvXtYVosU1R?=
 =?us-ascii?Q?VT+BIdm2iHxuMgVHPPN4QdG8IhoRLxaFQZtn5Owtm2xlLtO13YVkxYvv4tZO?=
 =?us-ascii?Q?G2TICHBWQ4oP8m85w5I9TGHZVO2Cvk677kksac3xG9WHPpS8ZcDke+M7J402?=
 =?us-ascii?Q?H9qOM8BIqbMssVYmpLddtLhRDepz6Y2y6CbH7DDNCs3cDlw/NDb8KD6JsjRF?=
 =?us-ascii?Q?RPHrGZvcfu+iKwhNBA9r16fIZOm1H30N+/b3mg+OafF7zzxkHqbkG7/3ueKu?=
 =?us-ascii?Q?rOxFlUts9Y9ZTnQpK6P4keUvVzm+WEdIpRNcJQfbCVEW/Vuqjxi/nxmdZfDf?=
 =?us-ascii?Q?D6NnMTLH6sVn505MAcFhQLX533c2NsOhWUKZ4vL468FUJawWHzS8jJzA4UDO?=
 =?us-ascii?Q?0BV8915zgc/2MP2MGxgPEgW/rPEZGZHncx+Gr8/wJLES+kU/L+lKwK/j0mQn?=
 =?us-ascii?Q?6Tg4Hhx/w9upyGqUG7qtfcRyYPpPy4aSORz6a36Spl6o/LUBeK7CfjeZN6T/?=
 =?us-ascii?Q?AK/SniJNCUHeuIzGcjKZZFe1PoNRP+XNEhnY7+GwDgYVHqHy1txUCq6hG5F6?=
 =?us-ascii?Q?fO2vq9k5sR5Wsf2cRmOulhghOPq+45W3zlIHRurXxhxpY0BmZTPsQNFa3GLQ?=
 =?us-ascii?Q?aRY12x3xd73T/A5+1fQDwIbG88JIEgX+ze0BpVuzYTT4ORbF9xBL8/Q72zjy?=
 =?us-ascii?Q?sBuohXOR/8FX7BePgjFqDl32lEzHN+96WmsofjYj3Qh1jtRel9DKi4Qk5GKn?=
 =?us-ascii?Q?h0F7wDjBDMiE0E9cAsOBQLe97a9MWeXSnBb0Gotf8GkpVtuqNiO7fqnUUoU1?=
 =?us-ascii?Q?lY6+xOfSjkGcYlShHum/GTyIWwBZXkq1jYGv413ftpDFgmskq1IQ2fTuYuVv?=
 =?us-ascii?Q?A2M+dWETTvXYnMNLvkXpxbwT001DZow9o/PtZaXfQTeLIX+TisKntHnuVtVH?=
 =?us-ascii?Q?5daNCfiDbpwCiXOqYFmn6zttxsPu5NIg6MCmhj86awR+r0ysz3vd1OyoHtHq?=
 =?us-ascii?Q?qMfQ3VV00U4IdrEiHNoE1sxV7DUpgl/YSdi/9rIMIT1LJmNCqBfcIrn82HMw?=
 =?us-ascii?Q?9YiLXFKCIRqq5pCRn7z7CDG5Vf6wwR7Op7HpgRqIjdzhHmotLBsqbYxapHuk?=
 =?us-ascii?Q?qP+zOEufkA=3D=3D?=
X-Exchange-RoutingPolicyChecked: jZ8XZ5JTxRm5eygg0DzOnucErUuWh4wFee/fOjr6UteGCtPd9wDX7iakavMdCm+SjEnp1fvqJZX9ZH/evu78HiT5LAiPZ2rshIUJ/+oJr3mYUwLxl+IgbAJguJzhTWY5ErNXZihVqRoQAHMbml8zdjc696BdqFyyACaQpkC8dR2HVP8cR+79nARQGqXh/KezXXa1wPVelEws5LosQ9lc3QRL95tpC16rAHS97PdMXufIsZ4yk7+Ezyp7yWNCeXd2r9OFB6ZRHR/MT7DMRWXCfCRLCyybTnNLazBfe413Hk34DpvoapnnCLwsozQfNCxyCEUqwhBKHhr636/VzCxiGw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4e238f-c98f-41b3-3098-08dea1e11531
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 09:08:42.9918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rqsmDL+e2+l8IuvkZ+9nXm4dRgnBcI5xM06tImhIma95Ay7T5sw9MokBYVvVgf3BLlV6Q06gKdstcvYIlTKrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB11003
X-Proofpoint-GUID: slJtqu1jOImn0-FagFzUUrbmamoIUN9r
X-Authority-Analysis: v=2.4 cv=QdJWeMbv c=1 sm=1 tr=0 ts=69eb331c cx=c_pps
 a=/2nJIMlxEBAz38jMsEt+9g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=3UIb4C0ZQzBStYY6MP0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA4NSBTYWx0ZWRfX3uB+cbiS6H1Z
 +kctN8sWweVzmW8NO5O5FTtvIfTcm2BIzjSJO119W9oPDpNT4yJp4Dyxe0GCT2cBW+rkDwg5b+K
 j4Q0KfV5IbgCWDkfUsQENhUVseaIZPYMcSuDNhC4e6URfl6OWD120oMSiRuctybZCyOGd5O0px7
 2Evt2kTCj8oGwj0Q8lSc4nF0b+Sy//Y4jEiUep0NjtIo6K/al3P15olTP3MNTQzaHIVnckCF+v/
 KotwW3+N4B2c2YZMofOg99tA5UCNFVosyii6w0Q4/kFKbsnH6WtJ7GH7ioi1IqCXJeEao2+2a4f
 vfEXLyUt5o9Af5/UwnQTx/EHGSQkcG/4WTTFFuo1pEw5FoOxNp7NMB+bb/ZFG91yn9DoqF220/N
 2KmpOMy9QsEgHmvrK9ewrVPvUXoJOgRifElY8J7GAeQ/D7Z2gfOtFXNMllZwXf0xYGStLSDzciv
 ogkgCIQWor4TssqIvaQ==
X-Proofpoint-ORIG-GUID: slJtqu1jOImn0-FagFzUUrbmamoIUN9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 24, 2026 at 11:22:09AM +0800, zhaoguohan@kylinos.cn wrote:

> vfio_user_pci_realize() assigns vbasedev->name before connecting to the
> server, then assigns the same name again after installing the request
> handler.  The second assignment overwrites the first allocation, so only
> the second string can be freed later by vfio_device_free_name().
> 
> Drop the duplicate assignment and keep the first name allocation, which is
> also available on connection failures for error reporting.
> 
> Fixes: 36227628d824 ("vfio-user: implement message send infrastructure")
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>

Reviewed-by: John Levon <john.levon@nutanix.com>

regards
john

