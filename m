Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D3ECCF2C3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHins-0001xh-5w; Fri, 16 Oct 2026 10:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHinn-0001ww-BT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:20:56 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xHinl-0006Zl-SY
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:20:55 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE4wu41681723; Fri, 16 Oct 2026 07:20:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFb
 Rs=; b=PII3KCEs6b9uknvsrQvvbUIKHz+uvKGaJ2OAIubyuTiqv4VtS4Gvi6MAh
 m011D6ad+VnPzP9uGgZtl6FHCiyv4tSqu0OjC6U2Blw9u78ey7THFmfpW/AujUTn
 wcYl84HwZyS5scuQrXJ39EJsgZuGFp4X4FZFcWFFX4moDWOLphmeR3lk0mh29D1K
 cen65hlna5HEvPCgfZuBjPfB+G3zcfs7qdEeNr0kcwMtD1xYjT7DPmMQvZxQOrdq
 9ov1Zdoj2Pc+wVjWYmMRmPVK6DJUeYew0x526X+CSIVGi/2VrQPw2tWC/S2dJghi
 ouFMTY/UgrCQ2drOjQ0QTxxqmjA7w==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020081.outbound.protection.outlook.com [52.101.85.81])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hberu10ea-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 16 Oct 2026 07:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2uZtbYRoNUMycwxNg1BURdihulFX69lRzD9kmcNqChVXMlydOQ9KIWcvz2SOQh5PCwYfabEb/+y/tSQN4BUbRu1GOSEXccGz2oypYejXGkikh03kLSjSIA14v9bR2E3tPbH9nrq7kgzK6AKgDo+IfS3dmD7UnCZUDofAKkqVo8FznbwLgnLFgSKBAteq9Xc3NXHTOE+kbcN3wuNKFCAek+TTQEu4UbJdlBei+E2KrCit+UvsnJ91OG+4+jAK4pJWMMtvJLi51W6GJ3knmxCE3oDlmW0PPSp9v0Hu1OvTP71zl/kIdP47L2Ii13zAUXHGHexyX5vqsPYV5yxv932kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFbRs=;
 b=OFbsDlbPP75OhbXl5H4RY71uqAZ991YUT1Z5GPE0YSdQtDCgEVEbIWYO5Z4pHM+MsPJqEgiWxdyxmjgN0ZA9CqSm2sfkHSt4Tif1wwb46LObHOo4hQuZprNGetmGc/hZfp+4vxm0uWez96KdJo2z4/zW4NguZi7onlUfAjcorjQfnnUovlBS6j6BTeGEb+4nTPv/ecURxNLcM5iou93c5eP/nY0nZ0jtjjUsdCVUJWo7GeLLiN4g1v5bIiqDhr8hOK/SPxEvj38LG/E8j3eDID4VmY4EEgELj1jfUfGWUkjEhj1UEkUJwpWy11kVRXirDyJEd3XYCcDisfY4/D525Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAOVXQJDaXE3btj5P/XXf0XEZfGBwKpBJnEaqxNFbRs=;
 b=hJCiK9Cu37zSMnMpbb+9XUzNa0PuSg0xEPnLi2AsNL1oc/ra2SBBftT26VBxc77AkaewNxEi0RrRdz5hXvhAucTzoApPEhSCeQHswR/RlPtnYOK3mnHtURNrhPS3/TRwpQ/TJ/mGwp5rrIQ9/fAxWS3Ph8YPHwpbewiHOD7HZrF/S4z+rmLAnwAZiJxsc2EPgsjlI3iKpk/MU8rcHbWhh79JzxzoEPSwdQILfKmOq6pXkFP7ghBPke9Ov6nVBSbb8xg9XvDlf/eA0snR5EJuivGeaze992F7hvn6PdpjOCKvg0ID90zLTPZe3yZYgs2wMksKj4D7ZmQMPJcyHuw1lA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL0PR02MB6547.namprd02.prod.outlook.com (2603:10b6:208:1c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 14:20:44 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 14:20:44 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 02/27] i8259_internal.h: rename TYPE_I8259_COMMON to
 i8259-common
Date: Fri, 16 Oct 2026 15:19:08 +0100
Message-ID: <20261016142031.1204281-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0076.namprd05.prod.outlook.com
 (2603:10b6:a03:332::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL0PR02MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d1c3fb-64e5-4032-39f3-08df2b90aa33
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: YzyiWF3i3N6f8bFTTLDJjKuoDLjx/DZb2LGxkVg3hZERzXjQTOtgBuxPoXN3EhXNFaovswFni/zdI+kb4uszQmRWVZqoqQTTxf8nb2+k9qLv9NGo+cgiOu7U2jbIg/uhMkTszngb98F/aN2tlW0YyDCJzvEpZu/I3HQtXeSrAwVa6wfTCAMVhOQK7bWHI0NM+L0aRPIf6QiuIr1H9Src+lvku8/khZmMGZvgmdIRiHCTDi/kG9UmYRZ5Qar3hvy+JZlp3HfelYKPvoJgoZWiXTyHDHmtSMPJdfYyworghe5kNAB3bq2Rw4DbeDM1xyaqD1j13JcvJaYL892dhTrJ2tQ106RL7h70apfTiulUDWBzWQUNBuRmfTkedigiEiEqmF9kVL/vF7WGQGITQJsGHDY21951bhUR8C0oLCshqlG3RcL9IkbNbY9VmjuMgOOfFjCzn2bG4/JRD+dexFLnxKsxuoUmNAZ7vkk5OuHNdYhVrSTWsxZfrhk/7KoLpt+x+6Ov0p9VXFfrMq/QkJpDSAOQcnRmoQypiQBVfpMO3J9TR3jxYcNGseR5OO8hSq/dgP8vsdpOA8k9cU3JXTmDhRkhsaUFC0X6Mt0O/jSoxons86bAxqoV8VhO9L9THLkgGwREyQs+kEz59+veQLNpoWwnt6dd93cfbfmXhzGKDtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HAttB6FSeDceJrbHLuoI2B9VrdLnZFTlQVl+UuU77a8SrqF5xKQmpvXrz3j?=
 =?us-ascii?Q?D0ZilW8gY5Qwo2tXTXhSCpPflEb9ca6aj7iriQFIKLBFkYCh9mKH4BrPStfM?=
 =?us-ascii?Q?u099J6fgH2c6SbQPdoR/9tG4vFCcblqC9lNVE4TFfJ9DpJr6Qrvbtoo6Yjzb?=
 =?us-ascii?Q?Ca2+00Z/0VgLtErOlRwk1DInXuIi2F7HDA3X0QqwwQuQTxMDm9rIQxtEtTVb?=
 =?us-ascii?Q?CdZNrR7jX2qkCGvsOvbb59sGLs4qeBd63zYxWhw3xrxd3pkRyfv7hc1axrVM?=
 =?us-ascii?Q?CTbkRti6EODCZOzXixFf1OvIqp2bG3d9OJc2oTSIUnRS/dbNK+mxepufWFAb?=
 =?us-ascii?Q?WsXB+cwnjBn9GOAS5IQYobm3MQuoQauU8i9Q9R+qLxh1hXrDNKHNlKNStRbu?=
 =?us-ascii?Q?iU/S2hFs9WGbyCuD0/Es3qiD68CmdOJqN9qTH7oBTxcFcbG78kw6ob7EupzL?=
 =?us-ascii?Q?FNsNs9YXxR6i5lfin3eZJW7u0GTrKNMw5mK0Uivc1M420/C3Qy1kYqDLemRx?=
 =?us-ascii?Q?nGB7eWkP8EJDM7xifTB4Z937VuZyWnqSyDNqFPcZh7msSAnGIl8BGUCaWQJ2?=
 =?us-ascii?Q?LyhveSoK8Poya0ZNgYJut0VFQci6de9IOlv/YedLNgfU3+SzjC+eo7X/GrWm?=
 =?us-ascii?Q?88DqlwSm2YymHiDjXZwDHXgMkFphP5r3khE/3fJg663QmTID/HtIAB16G8CP?=
 =?us-ascii?Q?mkQa7b9z+M7ZlZ1wyBNZbGIES3Y5DURCbJ0KKWG5pTAQGcPeEynsCgUM0z40?=
 =?us-ascii?Q?nDldBpNZ39CD9JceFXTnYsb3fJmHr6vCEWk/97rLVZZu5DOGp09uF9qXNgLK?=
 =?us-ascii?Q?8C6qr3qNJn2ktUW9UKdMiiYoqc8bTvOGh/WDk57I6EOu5RBNbaxPx+kySnB9?=
 =?us-ascii?Q?pwry5QNZHaNPMFJu2M975cI+KRnxvqXkR9PruyXRwRtUWg8Ztw7PffzQ7yj4?=
 =?us-ascii?Q?Xc60Cp7g7h5vAMW20xp/zvOU+hLCXwanc4tY/IRiO7dSnFiOLqQkApVrcbkn?=
 =?us-ascii?Q?mp7KA3mqMrXcECfKw2rWEeHgQLCGjrfuoXMlWnC+1aCe3SwNOx/a1iSKsy8Y?=
 =?us-ascii?Q?y0z9/mXtAvTUFwCtfdhEtk7670sxqBzMhqPn5+eynoolzFzKJnPOK0GbCLTD?=
 =?us-ascii?Q?c41Oa2DmiTW/wlAV1vF6RKCKFvyMaog2UOxkUrFE1IAS9ZFF4fqjF8skwxmR?=
 =?us-ascii?Q?MLPUyBDHGcGK6ZCNT3bBtWNRGKvAbK2ozOwWe5Lzr98hzcoLKuBl4t20MUQz?=
 =?us-ascii?Q?4PjT229hJFAUPgu8LQAWIc2Kp33N9S213xJ+bD0QtHKkFPve2pX3/Rs88ZnD?=
 =?us-ascii?Q?GZCx/ZQn17cCgXcRXWbff2OAT7zOSPtzNqmFCqVb3kpxJ/yHOxIy8WHass2c?=
 =?us-ascii?Q?mzMyjOBIo2PXlw9JVBh7mMhPdYH47hFYSoO89HhHvgcfw0Spc+pz9g+Tb1/T?=
 =?us-ascii?Q?1OhIy21J0eH/VVaCeGkk7bWVES4v1iStrMGKTWiW74ZCd9Stf8pk3wCfB1+A?=
 =?us-ascii?Q?+d97sc9juI2buC205st4B8VZAiW7E5kVYARCWww3YWzkQNLw5t/Wo5tt+tG1?=
 =?us-ascii?Q?nm3/DH69wWJnqoAdFv4xamyHxqz2Yl5T7/FJnQ9jRjHbB6r5m4HgwNvPsgyu?=
 =?us-ascii?Q?WAZJd5M2BNiblIDUmc4X9Ppk043Q4oiQzxM4bzzulwVAVPG4q8cERef0W4tg?=
 =?us-ascii?Q?zqfyV60VqPhSsj44pvyR1+wcy5jHfPhdGLdQ/njaBk7dmVLTMdSrAiP2cZCD?=
 =?us-ascii?Q?FgW8p5Y+PNE+225BTocTzU6SYWMHbW8=3D?=
X-Exchange-RoutingPolicyChecked: yftx1Ge/yZ5I+i4VqgkKQs9luZGpqONkQA08MAoQa9uN/T8QAK6eymfmfJVr0IC521tzjVGAWnDKcHi04Y6KlaVPpsjAfzU2YuMO/PekpWD5mdO8u4z4luF9qiorx2+8iwW7uie5wKdOFPN1uk5FeEVe3+VpcW8ynPKF4yNvUnfKS5JRGS5rSZNOniM0OSaCr4eMP1/RQqeVaGF5nD/lkYOqS1dIEOM4krRX3PKJcFcNEbRIaoRGapnA8tIOJd5JVFL+GHIqbO1wnF5rq6rLiY7sxa2w0EMh1S+94e51NAHxGOTwFjoMTd9I8P5VNXc7bENRojgC1TJADjTbVKidLg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d1c3fb-64e5-4032-39f3-08df2b90aa33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:20:44.3820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFO74afNsbSXbyVnXIyOel+E/16QDQcShnDNiGWVrR1OBLaMYvHLd5VIgyvOnXoFjKYSs2aqq/BLEk5cjbHeGL7qh2g0PtjzoF/2+6HG9Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX8CLutU0OZCp9
 h7uuhKI03jU8xNnPS5jiOz4HwA2wnmcNE7eWeeryjOQFvx/PHj/ZZGTsLwbOn6dDYne2QJDXzkR
 tyl/kt29NgL1NCavyXU+1M7eDdVvrUdh7aNAbbsTevqf4Mjve3d/9jloOnZRkLWxo3xhFVkyW2d
 zd0Yhh8KS9bep5VolRRalqpd1C8K/7XlD6uORaqU5x19Hu2TRq7n3unD2aeIA6HU0xUvEn8f8Ac
 8PKg4362KY52b1iD1bBM4U2e9dCuxhFaGgalF+Osb0pdW5Pz+sa8OSczjAuInp+m08bJ/DzFfxD
 dl0MaB03fWqnyFUpiEYwjm/MScVWOpCQjRrOrPc3e6MfHRxhkO5dPmQ+2fp7prxHvSeiqysf6Bb
 XZ8T7TGrV5BdNIeYZohg/f3/RjcT5vRPLTxgpMFwmQGGCplcJ3shuBsiQGGocS3LHd6jOVOkbAM
 WkzFPHn4rLQU4n2YH1g==
X-Proofpoint-GUID: junzSLCiSfPbYzo3Yv0gyQBxQV95Ygor
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX42bjrWxLeqn+
 Cy3R0iDnohRKKzWTwT2O0f4klbJEXfAw/xfKuFYvDjemFFvDDddnTU2Io/1p1fWB5tFAHIHJ2R/
 3MJgkWnwgkycs7p+yHcfx3cqoAaM7WQ=
X-Proofpoint-ORIG-GUID: junzSLCiSfPbYzo3Yv0gyQBxQV95Ygor
X-Authority-Analysis: v=2.4 cv=KMLPn1Fo c=1 sm=1 tr=0 ts=6ad232bd cx=c_pps
 a=PrKk0R3FxLq9+u45pGB2Yw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=xWlEjtkXqD840QCPih0A:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

This is to emphasise that child types of PIC_COMMON are all instances of an
an 8259 PIC.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 54dc9036cf..289d08b7d7 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -31,7 +31,7 @@
 #include "qom/object.h"
 
 
-#define TYPE_I8259_COMMON "pic-common"
+#define TYPE_I8259_COMMON "i8259-common"
 OBJECT_DECLARE_TYPE(PICCommonState, PICCommonClass, I8259_COMMON)
 
 struct PICCommonClass {
-- 
2.43.0


