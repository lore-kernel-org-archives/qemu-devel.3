Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C7AC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySa5-0007hv-Ix; Mon, 24 Aug 2026 07:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wySa4-0007hi-5J
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:11:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wySa0-0003C0-EZ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 07:11:07 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O97tbH2550391; Mon, 24 Aug 2026 04:10:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=JQGMU/95Ru81S
 5hU7DJpdrSSbew7Wo8CXt7t6BZTRKA=; b=0idSoXtzq4/7VX+TSjeYLJ7Xmu+IG
 HpAJBzCqdbG/ptSEuGl/xZHmRlQr3JOf/g8vB7Y5oXME3KiXB4dg8womwV7RtgsG
 toClW4rQVU7MsnaWi9tRf+JIviS2Cz2F3JMyLhxyfqBgGfcelc3vLaNa3dwi6qgf
 yInw+5L6bFvvbh3Ia7fRJQzmUn1aw7H2McXD409LUiJ7IspPHEQVa8kjGWRT/BV2
 0pZp011EWVHvbt7JPWe2Qq0FkSYunkX9iAFgaSqEVIZyRZL/8BVBbeoVsskpwPr5
 va3hEAR4r4INc4dWUN0FtFde/uMPX8gLXgmhbQ4f1sZ8nmuz+ICWMnO3A==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023087.outbound.protection.outlook.com
 [40.93.196.87])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7b9y328e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 04:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zzyr/F937xhXb/mZOc98iUkm0LBN3j+9965qxehMI/nvXVDaMHCRkOkk0n0S3fl6CjqWFRuG7kuLec67B1Ko+5hrybQEe3f67LNarufQMR8m1KYKt/S2gTJ9gG1p25Roe2S0HiyWQxOIBDXy/x/t++yUkDKdw5y9vpuuopKzpVJ1HnF5H+pVHdi56B4TLhRlXP3zLy35iLsEFpfNXVMkkqGrcW7Us0h5+W8jc1Eqr2OR/h0ZpC9cKdmW4v3nFseM+en11wpqzghNQrdIV/D/04T7vUHbsFHy1s8ijOQ3MYE1NJvww9EV1hWIgIaWJk4O8XVy33RXDpCfRp0mzgHVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQGMU/95Ru81S5hU7DJpdrSSbew7Wo8CXt7t6BZTRKA=;
 b=bepvY/crUMR8UqvSOlvTk6pqBj/K+EAikqAD2itJElatXj7rV/F0C+25nmv7pv2IXNrcRHQVDVIkJRU7hoT+GL1l3N8Vh/+YsW01ioMucWRAKzJf4Ne2HQr7BGTs1d0rpSHGN8rR1AbSVB/4/G36deD5Fu3BNmW38I8J3BZ3FistiaZWA37KgTlH8uq4oR3zk4sM1hHfeo3ce/pNpFa7D8QPdr2ifLC7eMyLbnclDrMxf4gMonrZYlmMkdyWVaeo/xJfunPNkG+i3r+hWeDuqAI/OHpo+Cn6A1xwfTv60k7VvQgt9C3pUgb4It8vZQSu66iG9Ww79GkMO1PGd9vlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQGMU/95Ru81S5hU7DJpdrSSbew7Wo8CXt7t6BZTRKA=;
 b=wjzXg0LmHrHvtlVt+oOTDDXvz0N0ro330+K/brfbnLZNIbdioWy2ta7MUJky/TLJg0nmXj0DXiF/vcx+yxDcbL/87Rnzh/U40G6MK64MVJbPq21yuED7PxMKJkFt9cIGzkR9v/uitupZGYoW1OENUczqpaMoWUZO7McQ50oCUwny63G/MduWpg76GXRwFgO1d3gxQ7TGEJ0gBlg2Tq4HXvg1ArZV09H5V3n6xK5db6HZ5dY0dM23A2gmP5VQI0dpdGAjDKos8/8RCwoxwQg1TRqC1Ms6Nsv+RSV4+p9CRGEi7iLC2Y6qn/jhjJlicakFxy1KgwAuspwD+E3OWY4Pdw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB9797.namprd02.prod.outlook.com (2603:10b6:806:376::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:10:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:10:57 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/isapc.c: reject modern x86 CPU models
Date: Mon, 24 Aug 2026 12:10:20 +0100
Message-ID: <20260824111054.575149-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0037.namprd13.prod.outlook.com
 (2603:10b6:806:22::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eaf8f8-d7d0-4353-0e75-08df01d05f7f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: Q9cp2HBbgIBhEix8U7J1FJ0dVd0RneGL7pN1yqRF7vhzb28JbINUktI3vb8jIoTJUMCd3zj4udDRRtXSzGCIPw3dyt5RxXrd0eLctwyT8WKral0EcDDCDUXMbCN+nzSZfggWgg4be6tHKHKJBPL/fIEeYbYEyPERZP9CCXyW6Fhxb4Q8UnyZb3lkpGCKOkbwwYjq/vyplS6megtVSBgYc6aKW3LHcZVtdDcxg8ElOMs/Smo8ig9GRejSnvn6N4cIXYm5GsPaTPMS1OxH7vGP9Dfh/e555BLDfutguOKGYlVTijBt33gzZYmMbVwQ6ygRlKf1etk++4lkUnvltuWM5CNbF/hbrGzjcBuB3RZsTpCFWheSIyhvPz7M0PmzNu0qHSIoXekW3fzFs51fkK6GavgVrbFT4qjWRY3nyveJNPfy9FjiLCrp1Xjv2dNO3TDSJJ7HGcydsxnk/IfdB0RRhXkVBfPZhhDP9vBfy0ylA13l6eTxbvjWjGwBWuIy7YnvhqfBhsj/pUoUGoAajeT0rTs1ZISMPToqP7zRZ0uOvcarLDsgpNAprWBm/JwZANkr3C3NkqvHEijaY6l9Typy9rkjffQovxHOqadUnQ/3IUl/5ZeWzfnC2nxutGPVUYbhBew0FvBNGk63i4NJVmmaC29yLRxBA21p6RRAV2+d874=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ScuD5AU6aRkHQfpkTCWinJU7f+4S4KteJZhbHur0Yn28rgRriYsuSQWSWPo?=
 =?us-ascii?Q?+tYqJc+bQBuSrJN87wOc3/hX5GPR1K/E8VPv1jtFRsMTKe43A80G+ICOAxYl?=
 =?us-ascii?Q?J2ZHM5CK3Ddv+XbK4e1hxhJS/MU/W9AycKCHgi2urGpddfB907GQsEsJZIwQ?=
 =?us-ascii?Q?gQBKiKqCYTb2wnGszVdfjrTYe0dPNzVvGbDxHtZ0TjwJ3KFz1D6WbVHSXF4P?=
 =?us-ascii?Q?Uma3Ug2cjhs4ka86/tKoEc+DzeRLT9G0zeIPX68Qe8uPLcK6yHJHFTYjIfq2?=
 =?us-ascii?Q?40hVRxgNMZxlbZXY8XxxuvEku1WKHYGAlIuyztcI3ehUESzMWUoKLPknMv4/?=
 =?us-ascii?Q?7EialHmLwnfdprKOOmkJO0RT98XRe089qHC3suj/cefHBHCOlfYbm7tBFZe0?=
 =?us-ascii?Q?zpO/f3kniT1f4vpEAxShqF/wGixQquBcqoI47NM82/b1CdREsnVbeESFLfYi?=
 =?us-ascii?Q?lXn34DUni7/tYfBKcR1oOs8HW44ZSTVLuMpI5UdBxg3lIRcfYER4VNLTI2Lx?=
 =?us-ascii?Q?hjIk2PKKZw26t76Mr2htoorib+e4XczTmHqJ3bGKfK8hhoXBdVVhwVD2cSLA?=
 =?us-ascii?Q?LUlG98dIAqhhAbWuSKTwIx5EQW6LfGaRWemqnnEofbmiSD2XBSV4/71Oms/G?=
 =?us-ascii?Q?mL2kb3WTbkHoLaVrhLeKvaUz4djCGXPsYFKe63F+LHie67ua97KmVg/SZ1gl?=
 =?us-ascii?Q?qZb0+YlPPsWMQsKoridroJbBpArs8bCCD70hJGFYtlWVw78en6KqV6+6b8Z/?=
 =?us-ascii?Q?jTX7lLVz6OBgb8RSH5xdZUbSb3n6SZQV2WsWNYFXTRbeiOiKmjdiFcgNrQSG?=
 =?us-ascii?Q?b87lCq8RS80XlsedH98/tTBr+g4z+NqKyW3kGivaCU4le1Rj6F6NhU3WmZRh?=
 =?us-ascii?Q?HNk160+upd+c27XKOJ+TlKcJCUV9QFKT5UhB4id+/jxv6H8hTfWuVs/BG2mW?=
 =?us-ascii?Q?3B37eqT3w7B+RPmeFIvUC9ZVU+eGu5s1vWPh+ABn1d2tBbEgORXBgJn2OCmp?=
 =?us-ascii?Q?N2hqvx/c1+GLrv7Ghr3NOAYsiaEzH4KCRZucaZnsQ9v53h54CXtnHKHsmYCu?=
 =?us-ascii?Q?citgBWyMRszCvBLuBsd87AWDebyISOXnbvCjEJa23MYz7ZWDrxW1QIMWe2hA?=
 =?us-ascii?Q?x4+q8ORrVTzpBbl5Uycksf216Sv8quMbRI3QsLVltI5qqYcMz8AIb6MeKoS9?=
 =?us-ascii?Q?F3rBvN9eTunRvTaMnvVc3TwyKKCv7X5YV9SrxeleLb2+0Mk2sx3wOhNRE9Mq?=
 =?us-ascii?Q?7KL8FHoddYzECyB3KGeo7euwOUyyuQOSCGJoIbzsF/OfKgLOpPrUV666ZG/S?=
 =?us-ascii?Q?JnogC49pgKaxRWNQKtoy1fKifzvWMAzcb9vKZ6gwsYyD2P6vY61q5SydxCDA?=
 =?us-ascii?Q?n5NVnh5kvjXTulqgIddWkvJ2U3V53XSY1VSKdrZROz2JOdUnNt85iDFtuoNo?=
 =?us-ascii?Q?G24yH+gzfKcV0cwPNGVqaYidvZGqs2Bu95WDMfSdo6ydqbZFXB+0YSCEpU6m?=
 =?us-ascii?Q?+i8wEKAX3vS+Pobwimtvf+Tu8d1rEEyCLhMxPfvsCgZW614N4ZtfxbbOnGV/?=
 =?us-ascii?Q?b185ji0Wsp7raOHF37YFgPfsA51kgmpr/JCX9k+beuLJqAJ1dkAKWEf3SFrZ?=
 =?us-ascii?Q?MzTBijqjZrjFV4Wkjn7I/onsY+CjwyPavxgW+Cw4CycVnAMzxHmrjwkCVysG?=
 =?us-ascii?Q?PcQhsTf4N7HcJ1PCliNs45bzJQRQbqBaSqM4Jzfl0mlQV4tzye3Nh5PSocIM?=
 =?us-ascii?Q?jj2o21ILfYadN4Bi8SYu5fytlu9dbJE=3D?=
X-Exchange-RoutingPolicyChecked: aRAYIA/mDi0jDNURHTC6ZbMUVxVCY/A8MIMAiy53dqPyAqT+YeUL3zsOynbWoUF8L64uztTBrB4u3o0o+124HBeQJnlc8TgKpaW+xIlL+CZGc1Jqd/y+4ED34NOzWi+gcB+u1ZQA+bL7qjqwxNvdNRMJrRFp1wQbbUQPgZk5il27RxpgshaSVzMBkIsFh88+oyt8CPOoO2BA7ycdxjnij9rqXnHC1b7F/57cqwuXVfhXX/kT3oGPv4ZkUnGi17PdE+AoN9uKswxTjBH9rWdrrjvoTiXLUd0UGJ+KdSD7uRKPV1DHs+CCPVNUlIJsknsms0GmDdycGhki1Y8jslrykQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eaf8f8-d7d0-4353-0e75-08df01d05f7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:10:57.8986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ng1+dpS0lf8vX1liGLM8EEGkDYRA6ZItlDPY7CHMaQ3nk5FX3/pFwXgvoIs+j+KkO+emCZfW8XRe9WUSLY8FpBTxa/DB42LK8Zflz1LSJUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9797
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MyBTYWx0ZWRfX1AFB7tt81muM
 3Bino8aL698mqjqnCmLA4Q0hf9xzTIVL4TAcVs122YSu1r1Iv2rBqOVvZCP8PB3RP7qJoR1WwhN
 ozDYwf0+Kfp/WAcopZ6skLwwVavSTOrQJWA/O2wBQB0ESXFAlGiXbhfUr52vn4pGmVUJW4+JyHK
 ZiXntZuSV89Ace9CPfg7dgTa+LW7caOo4OFuW6gchfzhyDwz/YqCaepiZZRlxcxaUhUqrjPfnjt
 W5urWCuyu2O5QHYREHnI1yimk2OAnA8WIMQXvf9UApOjgdrKFobyJZEVY900oehq4JIKO6dexc/
 tEbSXxwGm5c0LEAho0qN62bwjtpGiaCuOkhTcq0gBx5IJG3aCDsqqsGNClhQQ1/Uu8kAz8viHHm
 r6CR4VciU8d5yz/OWGV+XGRHa44Nq5omJ8AqRdHuzL8vTPK6lUnr/WjI5B95s6pA7PBsXYTBETC
 tpmBlRDZEZi88GkEa0g==
X-Proofpoint-ORIG-GUID: 4p__GwiDEktbM-Ie_itjA_9LrCI_t6e0
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a8c26c3 cx=c_pps
 a=DH6uOP27q4GouF/df79YRQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=zX-5KU0OjsM3FtIwGpUA:9
X-Proofpoint-GUID: 4p__GwiDEktbM-Ie_itjA_9LrCI_t6e0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MyBTYWx0ZWRfX3orndRQRiskl
 b46+hAxYOlgyaV+AEzPIOWOw2bBPf7hBckh8fMGGYBNYWl05HuElJ9efDHT+mkNpgacuZPOTGXd
 foXs7LgzALYoaMvzOyuKncfllYXDmPI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

It was originally intended as part of the work to split out the isapc machine
from the pc machine to restrict the isapc machine to using only 32-bit CPUs.
Before the 10.2 release it was decided in commit 329e36af94 ("hw/i386/isapc.c:
warn rather than reject modern x86 CPU models") to follow the official
deprecation process due to concerns this would have an adverse effect on users.

Now that the deprecation period has expired and there have been no reported
problems, update the isapc machine to reject modern x86 CPUs by reverting
commit 329e36af94 ("hw/i386/isapc.c: warn rather than reject modern x86 CPU
models").

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/isapc.c | 53 +++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 1ba9ae22cc..44f4a44672 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -41,31 +41,29 @@ static void pc_init_isa(MachineState *machine)
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
-    bool valid_cpu_type = false;
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-    };
-
     /*
-     * The isapc machine is supposed to represent a legacy ISA-only PC with a
-     * 32-bit processor. For historical reasons the machine can still accept
-     * almost any valid processor, but this is now deprecated in 10.2. Emit
-     * a warning if anyone tries to use a deprecated CPU.
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
      */
-    for (i = 0; i < ARRAY_SIZE(valid_cpu_types); i++) {
-        if (!strcmp(machine->cpu_type, valid_cpu_types[i])) {
-            valid_cpu_type = true;
-        }
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
     }
 
-    if (!valid_cpu_type) {
-        warn_report("cpu type %s is deprecated for isapc machine", machine->cpu_type);
+    /*
+     * Similarly if someone unintentionally passes "-cpu host" for the isapc
+     * machine then display a warning and also switch to the "best" 32-bit
+     * cpu possible which we consider to be the pentium3. This is because any
+     * host CPU will already be modern than this, but it also ensures any
+     * newer CPU flags/features are filtered out for older guests.
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu host is invalid for isapc machine, using pentium3");
     }
 
     if (machine->ram_size > 3.5 * GiB) {
@@ -156,6 +154,18 @@ static void pc_init_isa(MachineState *machine)
 
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        X86_CPU_TYPE_NAME("host"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     m->desc = "ISA-only PC";
@@ -170,6 +180,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.43.0


