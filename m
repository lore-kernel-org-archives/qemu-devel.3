Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5931AC83F2D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc1O-00019q-6C; Tue, 15 Jul 2025 05:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0g-0000Ar-PQ; Tue, 15 Jul 2025 05:31:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0c-0005i3-Tz; Tue, 15 Jul 2025 05:31:37 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F82SQ2012288;
 Tue, 15 Jul 2025 02:31:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=H1Ldus/d025BhajuLcod/ckEm1oCd6M9mBKbnJlho
 FE=; b=pKdQK/Vr1Rk82/ZA0p6VvfAkufDhMjE7dccDyV1enZXzNPNfskmesYw6n
 DlYWHRpAWHDUbQQecz/TD9sFo7aEUT9CAOL+kx9iecqruEyEWweC3jeq6lQB6iSd
 eg386TvlpZjfCQ5FcBf+joFxXJACuX67Fo6EXFJXDcjMM+jA7Qp7oZa9AqE9Vnx+
 GcKa7Kgc9MOlRbodw5jyGvzcQ1bgSfvf5i8uTxGtlnfJEggWyBVSKg3fMhfHqgdH
 UJeGRmJHreWx5l0n4GJZZD0uKrW4LoXkqdZ5ZWxATypRiZNqdJwuITpDtJf1Hr1o
 qFsXSq/r0/bNhnRHCs5Zx56iv1oyg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 47upsh5p0s-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqFstJGE6K/oU2zxAm4PsDqc6Mfm3TKjSl96oD7qrm7vSvEr0coxqHuUsx5C2eFyxn1ihfmmbqNfWI1gsACwE0pRoeVCXsgu5fGIC92WR68J+XusiCd7XGsewS0v17uHH36zz/mQkWpqi0nVSC59yNkRuRpN2u25wpvhvuLYM1x9/ECuoIgqdVYJBDVqkyj0qIdBScjku8w17b6wKJKgW7O4t5B+kmsYcXNNMvinsIUOjMjame7ua2Nhkh1wjpmQEekQdsO2T0h9alP1J5pJkCLlCul3/UNhX0sfci675dWJgPexLV7lVK0ujNQTXA2Z5sD91BsvEBkX3OirHnVW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1Ldus/d025BhajuLcod/ckEm1oCd6M9mBKbnJlhoFE=;
 b=HDK4fYewm5ttcCkM74QNVKOyRHznwhAi5VIa2/gFwqSulmeu7J9TErXirYCNAjZ2DIeWJ4Uppe9S8uwtwHw9+ntwsTv17dCM/dXc5dixS02BLBHRYILtZyyxwa3aAS647DtvBqC1fnRiuXGkZLN7agjda+DjAKzmSzyWxb0tT5VHdsrBIH7ebGQDJ/rTaswp3gtHCNFLdPy8ykWeWghY8fMnImm/iA7un/qtv5V2R0OFcBqhCK4G7k/EE+Rv59sH3/NacImsLIofYogEcVNxGj3kCXSJ5TfAGBLozLJOm+M8NN+BckKRTRx98j0KnwNr+gaTvB6TIq3sMCtzVOUy6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1Ldus/d025BhajuLcod/ckEm1oCd6M9mBKbnJlhoFE=;
 b=xXVDJfvfiGkRGboYgSc+xMqZYvqyU6wKdsMbX5mhNj1/4NDLghkvBR3S8s4uo7VuGNXNjq49K0wgZvhBXOxn984UJ2TKl54OhvTTBf1GWLWBIaoHx2CWFqyyolqWb5mIeFflorMmAcIAT2fonwkKBac1KIwD++xQa3qtbOf634vof+2qbUbOszigy6CJBTPFUGOgDm3T+NhA3S8jyj8s8+MDSfru4Rkl1cFFHrSpXzxNabJtePumrH3ypI5LhnwK7YvHL1osZAXRyzBnGbdP9u7PTKMs9+xVKK6/KLCpgXj7eH+HSRjULtOMotMkdhdVYz15eSEWEOaOhzTU6IDOIA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB9386.namprd02.prod.outlook.com (2603:10b6:510:27c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 09:31:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 01/22] vfio/vfio-container-base.h: update VFIOContainerBase
 declaration
Date: Tue, 15 Jul 2025 10:25:41 +0100
Message-ID: <20250715093110.107317-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0010.eurprd07.prod.outlook.com
 (2603:10a6:205:1::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: c46b6f81-6a4a-4350-6d40-08ddc3825a02
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FT1Rq1Z3/xtwgigdbJmiDXmvaibW2IJ9uoZlsSoyXr2wp5y6UdV3QmWTX3wz?=
 =?us-ascii?Q?idkCovsahFOKbVNIJ56941ZMILvRlDSp/utNV+yFC2b1qhR2l1I2VsFO3PNW?=
 =?us-ascii?Q?n3BWtfU9FFgNlRp9thFoD9MS17shaNg4CmjUQYMIP5qRd8CGvmPtP6fZWM9U?=
 =?us-ascii?Q?c8tMoCHXAnI9BJ/u8fVw6GUUr8K4/nKuTvcOIylnT6Hg295FW0cGn/zj6KNf?=
 =?us-ascii?Q?2LRft1Jr2w/4wKWBMKPbq7DSD8WAuEfg0RZj8duQI3H7LiU7piHVrPDuRx8M?=
 =?us-ascii?Q?ZzQgziiVM+xfqRWDson6I1JeScEuciPhXf1bc2VLSvEN1pti07iYLfj8a0pc?=
 =?us-ascii?Q?UOuHGAWzw0EEBiL/ltCAsODVVQdZCuYq3Io1isguf6cVIET178MXCc3+Jb1+?=
 =?us-ascii?Q?e2VakcKHh2lyoFEcYo/dd+wppyBw6WbKYV4jjhj3B+hBfm2Bz4CPhyMJHlDz?=
 =?us-ascii?Q?fVJlb7DNNS7ZOabsvzYmP3vOgkkT46NFqFQxOzhwp2y+YoDmu2NxIoh8laMX?=
 =?us-ascii?Q?PyKQiSAVjeILQZTXS2A6maDma5vZIgXBtLEawy7OqVQyTT8Xj7NJ2RYoA7ko?=
 =?us-ascii?Q?wM0xIwkpGDaHhBnWCwkUmr44qNCuy+EhQHm3L/Dl1SQwc4mrGN7+XoAE6Szk?=
 =?us-ascii?Q?TelONC39KyIvlC8swXbxkF7LI67Kfo8nE/V7oDgfJ2sQa86vVpCYnq1m9wQ5?=
 =?us-ascii?Q?2wAuQ/AX2FWQ3xozrGAoKlcRFnNZvQf33X0qWvT4nKEKxFYNmInJErXLkWko?=
 =?us-ascii?Q?1DFlAJe4QKVBK+o5bPtVPpQv7VkJw8gRrPhGA74Xxe2F+AoNK/WA/V3QaoJT?=
 =?us-ascii?Q?tYSBzOM0hbDHQbV7B8LrQ0kouiBqjoAsTtfVEBVC/axkW3JCpwZBaCrDV+q4?=
 =?us-ascii?Q?8FYan6B1bqmM4tleHTxgzPP6k8XCRFkpjWkgY288emdbLzoOLt3NDWRysa7k?=
 =?us-ascii?Q?JT4M4cpHIlOjFl86e8T5y69aKLxc3132eJ9ioSOlxr/bslG/7dTVmuj7nnJr?=
 =?us-ascii?Q?L78gn4OGVGWSZstB/pShFwQmb/qsOLAPsb3kv0R/xpyTODRwOhHrreDh0sxX?=
 =?us-ascii?Q?+OdgD70tK0GQYQy7iElYx5rAp4ZOyT4s8rTW7x9qh/ctDKDnTjrg9u2gFOGX?=
 =?us-ascii?Q?XLP7n3tczIW/JNSUE3KpN3rc20e/JK07rMud41Wj/G7QbXAVy6G7ODL7WFOr?=
 =?us-ascii?Q?weUyOUcnAhBK5tdkdxO1hu4th7Yhbzztgm49wtnkZxP5XBoSxEku/sSL1tAZ?=
 =?us-ascii?Q?hiOfKVzwkYSXex/rCTITNz1bUJrx3IjxXVkFo0RYFfbVS6bq1RZC4zBxPz6q?=
 =?us-ascii?Q?M7VBLxBvzZfHEqvMegRRyvm07yeUK5T967UT4qbrC6siqEMeWU+Dw07nqmse?=
 =?us-ascii?Q?AKZAE+bbvl3Ivxj5ZqLABfJFKce1fz7ELszTPM6b6UgoTcTRIvl34cd6/V8o?=
 =?us-ascii?Q?+eVT5dieV2PRKrgMtjU9OHTlXSq+z0+Okz/x2N76RFg2JEv2ZsZlcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lgC1jKiqLWI1bCmN1+QYFxGe4Oi3mHlEAvGCYFJ9k2i99cNCWfjiCsTk3t62?=
 =?us-ascii?Q?ZJKkpnb8Y+o4Tz7YTrZQI17U4MsZ0GDABnrGFfgE1Uc2CY40K3DX/1tKNrXe?=
 =?us-ascii?Q?yLnJZG7g4mjG3UhjsfE4+k6VR4Jz3NKronMoSkT0jRk1lstEx/C4E/y3mqeT?=
 =?us-ascii?Q?/OVLsIOX8yrIlzWGr2uz5+gYwXgmGw388KXXwRg0/Q8bmz1QiABJS3nerYDE?=
 =?us-ascii?Q?Z+SzZYkK3Nh57t8Qn5Mg7B6W6K8LP+6N0jqKLrDAg8ItM9ksH/MIC1Zd3Wvz?=
 =?us-ascii?Q?FaCtyzMum8uGYxcK2FXd+zAH6OLuz5c9J0H845WaV852+itNbOfag9GpF2Yy?=
 =?us-ascii?Q?/Nk3B5tvucuWTceTQZ6ao3lzf908Fd3D0NcGwcJj4btJA5z9ARKL8JKNtv+h?=
 =?us-ascii?Q?LjbYsYY0A+Sa3pFOcmvYp79ZM4VQ8vuUyJ6qFv40Hxwf9ijf7fTQXjoSjw0N?=
 =?us-ascii?Q?WSepjjyDKzRW+4YrSRyY3xlqbee9GmdtUOm9tlhgJSo5L58L9HmwIi9kvlr1?=
 =?us-ascii?Q?xHR1uFVvwX676z2BEyABMXFeYEa288TApnJgAlxqQqznOG02r3OlSydozwSQ?=
 =?us-ascii?Q?sTt7J+j8TUAkohXgjlWvU6PEaQi2r83dwRssKwHyXVQygr5dVR5nmDU6ppCo?=
 =?us-ascii?Q?lGHlnVzn7XEuT1mU2wo/ziAB8ugF3xt5XufjGgVvl2oxmvALYP+tlevduBUQ?=
 =?us-ascii?Q?pHwA5qYPwPaFisdEf1Qh/WmzyWFn4v5RmI/wwxIdiV53d9xnW0khu18hjrml?=
 =?us-ascii?Q?nm/yMO26zmn4sRr7rjQoAav+RZxM9XK3K0TXFKCutvPEn9zTQCcnXWqlrNqw?=
 =?us-ascii?Q?uj20dpdKqHUhVfC6KLZ/tbaVUKIc2qBi0/qmlsxukW5DmnQYKtIVF1xPxOYS?=
 =?us-ascii?Q?UuQ591TwWNFm+bjFeriCbM4kjrS1A5lPudquoMfYEjwihqPxPQc9UznQqdQF?=
 =?us-ascii?Q?Y8PzFqSGAph7UykME7KZYTe/4Zw5cbMDEs/aKku4zNC3Uq9wah7bQmBffvhW?=
 =?us-ascii?Q?KOzg4goSliwHex3qKykZqWKEPa+pNPNwWFV9UTcGORX6B75a0IjK79idQcrE?=
 =?us-ascii?Q?T3rQTC/3Ick6J3GD5FlimVHNG/tlverI3eFANZayy/BsUErhx8mFMvqeK4k5?=
 =?us-ascii?Q?K3Pf8mzmMt7KcirRu4SPvV6R6st34DzD3V5dOS8fKSTv1mxSMygGaE/kSGiv?=
 =?us-ascii?Q?w/yu2BKJRAJbD3oYkHYwU3Uw0lmztgs5kVCT3cQ7CVMDA7X1swzhanBohMO+?=
 =?us-ascii?Q?55lMewsUXVXJ1M4uDoUQ51L9yNYYOO06kcQwoHUFt1RubgGG0V4yaSPj9R+p?=
 =?us-ascii?Q?L4INnru38mzUhQbT9bTKh0sXnIvno0X/frJt6Bf2Be0VRbOjBQQZM/l3oNf8?=
 =?us-ascii?Q?orrL+MlmzJ5q+/2VyZDeDdiXFVFCkjWuZr1HuLUOAZMdJ7exv6BNJ09nSF27?=
 =?us-ascii?Q?wGZpi4kDBD3/zExNJtWFXVAcq6jTF27W5/XcI2PXSoTjH8oNLJYtkh5u3xiC?=
 =?us-ascii?Q?r2FXQ4QzCqgBno67vPOAq141IP28IY3agbrqOAqiXxvYjLb24j9XWKRhFVIP?=
 =?us-ascii?Q?ckoCZaAq70OSQkaCe3sbOAW838Rzb5WkzdMdZM/b7vpa0l+8zSdSEhJOO9Hr?=
 =?us-ascii?Q?45NQCLeLlAR8CIhOJjxHz+v1iT10Ds2YKyDlAFLbw9buXtwZRc9Su0tRkV9a?=
 =?us-ascii?Q?Qgmz0A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46b6f81-6a4a-4350-6d40-08ddc3825a02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:18.0669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHqr9SUgMt7DsOhXGbzDaDoK68Z2boSxs3xHIESfSyWt2BK2ABbJzSxO9kcZEkoYBeoWlEX4i+iyaRBKjvuD0zb1Jiz9Hqw9GfxLSOon4Zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB9386
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX4ydMt8La1G1G
 pr6uby83Mc23eMqPD9yIw2ZXFnu4qdBxHsG3bRphYL25ufuDI1AKiPycnzPHG5WTKPfZLbzTtmq
 /dSDr90Y/AZ2MGA72YZtsiG+QLNiXNt8aOBjiATir47W6cnpWQM5bYQq98Caeg10PmENC9On2vw
 xvbxFlhegsghPugo1FGIj1hhQObBVGu+IUHjg1zXOpS94WbbER+RqCoYVtOnalEfII2zMWVDML4
 UGV8XHtc047j4IYsoHjTyp02N015rv6MBSxRwVXMRR5NvXurnvFCUpCnai7PgMnRfBp4c+veebA
 i6ANR07YL5EarOAPd0yOM13mgJ4uf4DDAB04AFb55HHtrNRQmpxnLdx+2oVcpBstuQ5IOGEgYq3
 eil++o7fSLjSUGaKoqqLqiuwoO32WbFjRRQN5YJg8fnYZtbGazdQ08LTbJeaBELDaefD/gmz
X-Proofpoint-ORIG-GUID: rB1nzWtr7ZqGTmQLKirUTMmpUqsx9S0M
X-Proofpoint-GUID: rB1nzWtr7ZqGTmQLKirUTMmpUqsx9S0M
X-Authority-Analysis: v=2.4 cv=AoTu3P9P c=1 sm=1 tr=0 ts=68761fed cx=c_pps
 a=hEWPytJkew9UMlV5tkGFJQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=JOCpvzhzRn51IxjAXVYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Update the VFIOContainerBase declaration to match our current coding
guidelines: remove the explicit typedef (this is already handled by the
OBJECT_DECLARE_TYPE() macro), add a blank line after the parent object,
rename parent to parent_obj, and move the macro declaration next to the
VFIOContainerBase struct declaration.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/hw/vfio/vfio-container-base.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index bded6e993f..acbd48a18a 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -33,8 +33,9 @@ typedef struct VFIOAddressSpace {
 /*
  * This is the base object for vfio container backends
  */
-typedef struct VFIOContainerBase {
-    Object parent;
+struct VFIOContainerBase {
+    Object parent_obj;
+
     VFIOAddressSpace *space;
     MemoryListener listener;
     Error *error;
@@ -51,7 +52,10 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIODevice) device_list;
     GList *iova_ranges;
     NotifierWithReturn cpr_reboot_notifier;
-} VFIOContainerBase;
+};
+
+#define TYPE_VFIO_IOMMU "vfio-iommu"
+OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
 
 typedef struct VFIOGuestIOMMU {
     VFIOContainerBase *bcontainer;
@@ -105,14 +109,11 @@ vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
     return bcontainer->pgsizes;
 }
 
-#define TYPE_VFIO_IOMMU "vfio-iommu"
 #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
 #define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
 
-OBJECT_DECLARE_TYPE(VFIOContainerBase, VFIOIOMMUClass, VFIO_IOMMU)
-
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
 
-- 
2.43.0


