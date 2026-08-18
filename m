Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC8FC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKKG-0006Z0-Iz; Tue, 18 Aug 2026 09:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKKF-0006YZ-Cl
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwKKD-0004kZ-Ab
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:57:59 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IDueJO1379006; Tue, 18 Aug 2026 06:57:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SEX8wWQo6HpRc9xAQ15nkFFZsku2DEKUFr/6B30cW
 X8=; b=ygkDRPMQjlf1rpbyLlnznq4rbYkyJFt9agh52xZNxkgZ66B+eSzaZ1rDO
 mBRsfheXRR7ylv1IMIgJHD6SAxhRJ4J2hXCZoI3tDiJwyLmeardJTK32aMFMwhzt
 fcx53RWYS+TmoDlLhZDiYRJBMO6kJ5Jk7bOMoIq3NzXH8/L1oljop+jbfouRqLWt
 B2Aujby96emCDe6Lqsnn6EUbeJcYTiJWuLrEXbpRk1JD9AWOwLvQLvVtC0s5pHoB
 ybaVnwsmky9am82fRy7miaf8NLHrWRpcNHiFm8Oo65OvVh4691+SfeiZYZRtz5Kp
 k1gA2D/TNgslNxmpcD1tdS02wqwsA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020075.outbound.protection.outlook.com
 [52.101.193.75])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2meqxt7c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 06:57:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qqUHUblotreHCf2tSXUos8C1rUQ2tr1q2W4nT39ulSs2tl7oxi4KZvZtboHnxGAk6G836UnDtSHZxzvCrG36gARZPcS1tnYWmuUS5lKZoooINwa+06yivwmE/8cZu8tW5+AjWOus31D5VYKPUa/in7dp1uweH/4cGNJGq+Hx5dRJlk6km16zxhX47ZNwK6HhOUMHW08Qm0Uvno/0YGDtPKFqhnlXecP9gxd/C5XOwBwv3WBYkIFje48kSFI8UqcYHq1Gtps4t+/0vQFmqbDMnksOdTeQuRP+pXmPJbd99kfMKwuGbLWaWxGjnIzSFexr5Z6bGLTLDY6DxgDhJiP2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEX8wWQo6HpRc9xAQ15nkFFZsku2DEKUFr/6B30cWX8=;
 b=t5gI8QshJbANxKvPudA87GInkpgMAI7q+FyufpQdFld8h1AqBm40904ckR/xp6QOqJHMlbEymjbiWR9OW2ZhCmr/IdGAEdcKngeANbajYqaRT+rzUuwY3YmeC3+PXO31PSM9OklZnwpuAhh7KoVdjsXPc/v/CImUoR6E73RBZVTA4wrj08+kVOA+1IndUQsb4aafM32QkcmFUaqsXEnNSuioryvxD/2FeBeDJQbxcqkb4fiXBf741xiBckQ3uxuTMPnmQBrlFxzeG+qKA2muO/JKv9dHDJ4U16vCAn4bwEJ00pKl2gK6i5cJIKlackgVaS2kARc+Uy4LmRryEhUAPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEX8wWQo6HpRc9xAQ15nkFFZsku2DEKUFr/6B30cWX8=;
 b=YDTCJra1FYCUBs/YF+2mQbi2lGk5yAf+5RAv1hgVtkHarPg7o0kKoYmohjbDBIlgdiN0RHIiavJnoY2gsGQRwnROrgDgPqqkFfa/3wdISU/FSYDHXWZmTbhmFoimM19kWCu+Jxxi7X22XicW3vTqmc0uRhLBiL3EqwWcMT+jdTxNTLmyl2Brcc223tIpMKbeZwPLuKZ1hW02YakkItka5WKbwuOIgTsthagMv0dRQi+vQe+HZjZmVkcWLWu0WtAy0I7kP+xVo1wOym3CweeQfebkm8c+UQpFZiGHzTgDfme2vE5WoBdb69CDGCrJOmAm6QrOwBzSjDyoyK1YBRbziA==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by DS0PR02MB9103.namprd02.prod.outlook.com (2603:10b6:8:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 13:57:54 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 13:57:54 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 4/4] ui/vnc: notify client of clipboard peer status
Date: Tue, 18 Aug 2026 15:57:37 +0200
Message-ID: <20260818135737.2679311-5-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
References: <20260818135737.2679311-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0196.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::33) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|DS0PR02MB9103:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c036e13-eb5a-48c2-ef71-08defd30b323
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|3023799007|18002099003|22082099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: FYtnafDVifAvhfykIVl40HLQP/R2O6CCXH8wvpoA4hKhsy5STMXS22T5UA8uUNofj4cUTw2rJZq2I0XNd93Ixwzmjt/dkf5BzRw0TKs0Rh97LqK2+7F79QGKTS7xDDwxbthxC93xv0lFWuV/jY/l5Nlm7TOJHSAexEd22134foj68Eg4JR4Q1oZCHLM9EahawI0o8dTh6KjSvln8hN8k0VRkAhaCJJ1iIBmvuHQFjepOC9OmXvB2j7aAJAGmM7R93/+OwlsTJs8gOfHhnCXUk8n9qiOD1ufyGc7Eff6PJj6qqyNKoK26BxMDNEFN2jg2NjYoIfFzl3ZKeY6uB30K99iYHimljlHfdhrLoOJVANLuPSxCuGaJcNwuSQtK5IvHATNvN2vEbpvwnpm5HzvcnY0b1C+lgDG9+a2RqvKAOSiOtdaag2dpy/EIRhgbEmD3sQhYLLADbqLN0/G0aGXoK/gU80iJgPuly5fOZBqv/3dqS4QoIwjpB0jbZse4D8Jaev22r14TiC8nIBA8AgHm5W7+RPUZ/pFaDT5JnY2Ed3XoxJPEVUNkWevj5m3PCp4gmdFICusxSKl4vBm7/Aycx/hftPPnF9UB4DcbhsYz0EIgdnAw1ye8vl4jQixtfexSwvhHKYVdJhDM9FM6OaTBDhGbUweqiVchbRUHj3DCVbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(3023799007)(18002099003)(22082099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vEaA+oH+x7jCQ03tlo3ZRBteG4GcEhHqvKiYmxNO+rtBBqY0akpSsl3WLG+T?=
 =?us-ascii?Q?q+K+42yXhcw1EQ7eMA6/Lwu5GOaClQtW60s0/o7Q7bkvp68WsGTNK9802jyu?=
 =?us-ascii?Q?hYC2k/oxst6SGiyzVViXJVIt+WL9IJ94k9JYIfWNyZNSfC3sJmGvel68Tx0T?=
 =?us-ascii?Q?3UVRR93OK4qTLlqQ1ipwwWRhtvH7zBwWsC5zwXo9pXa1Id7HrBTE25BWmrau?=
 =?us-ascii?Q?euftDrzNbn9crlp05ZMW1kVfXm7/2YginNizC3yXhOsIVW0BrSIL/o+S7FBY?=
 =?us-ascii?Q?hZhNF8zUBCcmxleSH+PV5l8N/tceKksvt0V2SO+Y0A7Im9fIzKZT/bmDL3I4?=
 =?us-ascii?Q?5PtuaXsC5GfXQomkHsYeBclb/9IFIv4cC6nI5oLf7GQ9hkTdgYVcCs2Rlz+d?=
 =?us-ascii?Q?EXZkQujJaA/TQ0XgwDvN2Q2PGW50KhC6Db8xfzjV5gSVIdgTxWchPyaRxMU3?=
 =?us-ascii?Q?I071+N2RtpxgnX0k2cv4lZUjXqz8Y71LIQJw61m6Who9qppTkzfM93fMQJKu?=
 =?us-ascii?Q?YbKh+JMDpGmJaEp6WtV2tu2LSpftoQEe0Nd+CaU8LhegAlmrqEpqNwyfJpmk?=
 =?us-ascii?Q?UH/y44k8A8wC2O4I0GNo5Cm9ZeKl7sXgQIq63sUDnxT9dTqe8Zcp9S6+Foy8?=
 =?us-ascii?Q?VAsNH0C7fLblagGWmnr9j7Y6NlDkNtOrkXzOvdcQXh2CUnSFFYTQ0mXE237r?=
 =?us-ascii?Q?3iUNMMvxmUVC7PrylTEMoASJcGbFMFltcGIcOx8vc3naMvZBBLIVQQ9P3kZu?=
 =?us-ascii?Q?FADIj23DyUJreY/40sVuLI3s95wCVX5a1bF39jsw03CzNtRTej7OuFf3numC?=
 =?us-ascii?Q?Soru2P5g+UmeUUPS/NQpk4iY695GGvWXte5qGw704kHvbS+KjPf2xstrOIvZ?=
 =?us-ascii?Q?IlM5H7X/wA1c7e5wsebSJIG7mQhMcYc5o7FE7YnOUfd1a10edTQ3XlQWN98Q?=
 =?us-ascii?Q?bS87pQnbvHx9sY7aXMok7daAYLATcKiE7lZJh5tirnyqVITbdTD/TZMUeHZH?=
 =?us-ascii?Q?Q1VAIdrSaJmDpFgvQ4K5E2v2DUPx3JRHdNAHIFq7/BePpwL7BtdJmOmD3p1J?=
 =?us-ascii?Q?4hIqN63JBdootMJmH8yOGd/XxDzgP0QsokMjKwZBAyLRD/sl6mRBtizf3Pka?=
 =?us-ascii?Q?cgYOgBEKRRJEUVHs4jl9my9szoGi9zD5UFlc90VeCcvrJ/1QRy8ln6kS6/ST?=
 =?us-ascii?Q?1yx+GrZZOUGGJnASA0x6j+lLmMQvyF2XLMR31cbdR0FHzOFv+izejzqYmhJ6?=
 =?us-ascii?Q?SJ0L8594fzsB3ZhaW/mc3jEfi1ZoCSblEKExqq3+exG0VMFeyncO/Ye4I++7?=
 =?us-ascii?Q?E/qpbK2H0nyG2snkfWYDL172AvIfNV2xYse2MrXogn1oEAGH1NhAtUil+b2C?=
 =?us-ascii?Q?sdla3b1qBd0C+1icGHFrikUiMKtxxjzb6ZTRNXgfhr64d0f0iE8TiuDxDMWs?=
 =?us-ascii?Q?vQO0B/eypJE8jWv8H245grwTIZxd9HDaSSSxEkZv8MtCMmfljx7RUPwoBZ3T?=
 =?us-ascii?Q?mZFX6eHNXnpWE0/SAEohYXlWZnkCeimJXbMRADz/b7BvmfEDnIgIcFYbvv5d?=
 =?us-ascii?Q?a2jRK14U1PoU0VdrQyrDUCov3iZbb8vCEAZh0N6zlUSVmav91pBI6PtuUCoj?=
 =?us-ascii?Q?Llh6M0+uQ8dnqWrSd0cDnjzmVpldnQyx2RYMpRFGEe+9+92+7fcVkdMd9RLv?=
 =?us-ascii?Q?4YtHeS/d03dgr9KfnLfbIACfJfdSB4pLoJnQWOCcbBMQ/DCx8qE6PuGzP9a1?=
 =?us-ascii?Q?+9DkWXNX7XSrBLkm1jJ34/vxJhaWeyQ=3D?=
X-Exchange-RoutingPolicyChecked: T8gvGmzd9UkuQqGcSCH96NmZn4+c5NLEdmUEqvcGrmhUv3vX8HHs3R4iCIpORcTUS/AggoKNZmFY6vbsR1/3w+jaWsTfqYgsDIqc+d58bm3IXhgiaIASuDW8mZ49EMeRIsnga1HmZUVmqEjDwASdYbrv5D2XMakFzMbHfw2G7jbgo+X3iH3iU1AwI5Caf6/uXrp3XJQjrdj3kZ5VrMAXsLuetyDwJrBQbvEaKLAMA9bYg0e1V1d/zG3xDMXT0EVxO+og5+58tjAt2isib++MO9YdWShXAgDokHV27SiYYWOKKYI/6ATrHqeXaY9MtHmz/4QnWTKeljjFSAF/KLbIzg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c036e13-eb5a-48c2-ef71-08defd30b323
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 13:57:54.0252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqTK5GYuC+KMQNwA3+zXne/rRLjb/+7N2DowsmcnnKM6lnw/FZSf9M9MBfCdd4kZQZHmdPWihbz7E7R1V9hYfslPCqe5Apy4vuOWeOZ95X4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfX4LjiJdzzEm6W
 oqVTYk7mCeQiGbD13vq3s5NXUOmVd1KoWg/wCWpKxMm1zZJbzsct4pGtK6lfKOYmojqA+txGDjF
 NVghN+JdI5bRNRFm0eWUKA6bOzX5MfGOQiQUIk+4fROY91lTHDwd2NEG1F4HC/Q4fXIzDKy5sl7
 N8Fyqx17gHcKwZ8QjjrKaofpkFHNEG2Xd0KpWkPtGILQ8XfejVqq/UTqAj6/7b2U5EdeUZ7D2wE
 gEZNFwRqW/eDQMAHgkA4kddnchDwwgaMLT2sMEmfoxk0GQ+ZeoDwsIFLQKED9m0HRgJ1557AhRK
 +Dqj9kY9oEu8TeY8fU1WsyLn5yt7E/yuBIfNGyq3yv3Yl3qk/ivvuryne9Br7jYU9yGkSwCY86e
 HdRiFvJiTww/qq5eHC7J5KPIYydiGSSoShQbiPoJPAPmlFf5T0+36LoV1QDlmqvMf1BPYiO781Q
 vUBGblPQZoNBd99e2kQ==
X-Proofpoint-ORIG-GUID: tP-l9KzXrfcYzhs6rGoO-uPkhlV-r0rp
X-Authority-Analysis: v=2.4 cv=Us9T8ewB c=1 sm=1 tr=0 ts=6a8464e3 cx=c_pps
 a=dTGz0tuhMYfsSU3NwIzouA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=-3kcguB0CHop7p9IiFYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMiBTYWx0ZWRfX8T9Lx+2TQmXN
 2wkdl/wiO6K01qCuw9x/MfvQBz55TfuFtaKUJyBZujMOVaY/Ql9uFkYnyPgp9e3A1H4jMQ3IuR1
 tk/KELy3MW0lK+28vTXcMsaVRbP5Xb4=
X-Proofpoint-GUID: tP-l9KzXrfcYzhs6rGoO-uPkhlV-r0rp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

Introduce a new vnc message (VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS) and
the corresponding feature/encoding.

When a client requests this feature, the server will inform the client
whether a guest clipboard peer is present. The server will repeat the
notification each time availability of a guest clipboard peer changes.

This change enables the VNC client to determine if a guest side
clipboard peer is available for clipboard exchange and react to
changes of its availability.

Until now the VNC clipboard peer was only registered when
VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
can be registered just for the purpose of receiving peer status
updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ran
if VNC_FEATURE_CLIPBOARD_EXT was enabled.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
---
 ui/trace-events    |  1 +
 ui/vnc-clipboard.c | 31 ++++++++++++++++++++++++++++++-
 ui/vnc.c           |  6 ++++++
 ui/vnc.h           |  8 ++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/ui/trace-events b/ui/trace-events
index 917d116d90..d2fe153b7d 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -48,6 +48,7 @@ vnc_msg_server_ext_desktop_resize(void *state, void *ioc, int width, int height,
 vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg audio enable state=%p ioc=%p"
 vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg audio disable state=%p ioc=%p"
 vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int channels, int freq) "VNC client msg audio format state=%p ioc=%p fmt=%d channels=%d freq=%d"
+vnc_clipboard_peer_status_send(void *state, bool present) "VNC server clipboard peer status state=%p present=%d"
 vnc_msg_client_cut_text(void *state, void *ioc, int len) "VNC client msg cut text state=%p ioc=%p len=%u"
 vnc_msg_client_cut_text_ext(void *state, void *ioc, int len, int flags) "VNC client msg cut text state=%p ioc=%p len=%u flags=%u"
 vnc_msg_client_ext_key_event(void *state, void *ioc, int down, int sym, int keycode) "VNC client msg ext key event state=%p ioc=%p down=%u sym=%u keycode=%u"
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 67f710f6ed..4ecc4489e4 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
+#include "trace.h"
 
 static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
 {
@@ -224,6 +225,23 @@ static void vnc_clipboard_update_info(VncState *vs, QemuClipboardInfo *info)
     }
 }
 
+void vnc_clipboard_peer_status_send(VncState *vs, bool present)
+{
+    if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS)) {
+        return;
+    }
+
+    trace_vnc_clipboard_peer_status_send(vs, present);
+
+    vnc_lock_output(vs);
+    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
+    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS);
+    vnc_write_u16(vs, present ? VNC_CLIPBOARD_PEER_PRESENT
+                              : VNC_CLIPBOARD_PEER_ABSENT);
+    vnc_unlock_output(vs);
+    vnc_flush(vs);
+}
+
 static void vnc_clipboard_notify(Notifier *notifier, void *data)
 {
     VncState *vs = container_of(notifier, VncState, cbpeer.notifier);
@@ -231,13 +249,24 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
 
     switch (notify->type) {
     case QEMU_CLIPBOARD_UPDATE_INFO:
+        /* ignore the update if client does not want ext messages */
+        if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
+            return;
+        }
+
         vnc_clipboard_update_info(vs, notify->info);
         return;
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
     case QEMU_CLIPBOARD_PEER_UPDATE:
-        /* ignore */
+        /* only guest side peers affect the status we relay to the client */
+        if (!notify->peer_update.peer->guest) {
+            return;
+        }
+
+        vnc_clipboard_peer_status_send(vs,
+            qemu_clipboard_guest_peer_present());
         return;
     }
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 656768f9c9..9e44a20311 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2191,6 +2191,12 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
             vnc_server_cut_text_caps(vs);
             break;
+        case VNC_ENCODING_CLIPBOARD_STATUS:
+            vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS);
+            vnc_clipboard_peer_register(vs);
+            vnc_clipboard_peer_status_send(vs,
+                qemu_clipboard_guest_peer_present());
+            break;
         case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
             vc->worker.tight.compression = (enc & 0x0F);
             break;
diff --git a/ui/vnc.h b/ui/vnc.h
index d8b0070396..6e8fa66e9c 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -422,6 +422,7 @@ enum {
 #define VNC_ENCODING_DESKTOP_RESIZE_EXT   0XFFFFFECC /* -308 */
 #define VNC_ENCODING_XVP                  0XFFFFFECB /* -309 */
 #define VNC_ENCODING_ALPHA_CURSOR         0XFFFFFEC6 /* -314 */
+#define VNC_ENCODING_CLIPBOARD_STATUS     0XFFFFFEC5 /* -315 */
 #define VNC_ENCODING_WMVi                 0x574D5669
 #define VNC_ENCODING_CLIPBOARD_EXT        0xc0a1e5ce
 
@@ -466,6 +467,7 @@ enum VncFeatures {
     VNC_FEATURE_LED_STATE,
     VNC_FEATURE_XVP,
     VNC_FEATURE_CLIPBOARD_EXT,
+    VNC_FEATURE_CLIPBOARD_STATUS,
     VNC_FEATURE_AUDIO,
 };
 
@@ -507,6 +509,7 @@ enum VncFeatures {
 
 /* QEMU server -> client message IDs */
 #define VNC_MSG_SERVER_QEMU_AUDIO                 1
+#define VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS      2
 
 
 
@@ -541,6 +544,10 @@ enum VncFeatures {
 #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
 #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
 
+/* guest side clipboard peer status */
+#define VNC_CLIPBOARD_PEER_ABSENT  0
+#define VNC_CLIPBOARD_PEER_PRESENT 1
+
 VncDisplay *vnc_display_new(const char *id, Error **errp);
 void vnc_display_free(VncDisplay *vd);
 
@@ -637,6 +644,7 @@ void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
 void vnc_clipboard_peer_register(VncState *vs);
+void vnc_clipboard_peer_status_send(VncState *vs, bool present);
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
-- 
2.43.0


