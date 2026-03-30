Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6911061B1A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 18:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Hcw-0004Ta-HI; Mon, 30 Mar 2026 14:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1w7Hc2-00047S-G3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:45:26 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1w7Hbu-00019O-Aa
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 14:45:21 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62UGK1s31679045; Mon, 30 Mar 2026 11:45:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IoIlSPmrVyHqGpyyLzLuLHlmUCz8lP6uSqXCaGiy6
 MM=; b=k0X9m+KeaKAv6WR3t8R4dgmOmNbLoGNe6z4lF5tRyXcPPSaUbaEWf8lDq
 GtHQJkIRPlqolYDFuzJBFOAQgC4KGlWVpqzhVd9F6CZ6QRX+qeBjW7XKR7gkIg4x
 1QwjhmoTVx+y04DDFx34U6uy9J3CGC1k5GNj4nWhksO7hwh1AWuyreQEAiN5tQUb
 pMeFwKQxKRq2s+vvCn7e6NvSAQQnA0wWD9fok+weM3fCmMlqKah7UyvgrJxY98Hv
 OcgiMTjxXNkhSfMg3nC6E0pGW8gkFP9HwSonGRJYl7KTQ+Bu6ODRTdQgGQlK4ZcI
 8sagKk5eXra0CsIiH8Sv/oNbfm8PA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023127.outbound.protection.outlook.com
 [40.107.201.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4d7vku8c73-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 11:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4vSM2MjW6MAxBknOv0R+dGpjA3biBNsKdbFhEtTRXzuOZnhn5nUeM3emGC6CVetWrANcbF+3hQ2oSKFYXhWr8+l8gPwd+z0LwcFOdpGXEGhDZaISZh82iU3r9UitKEtTUUAT2P5K8PmwcLAAMdVrTbd0bnM+kGJca6KOwPtoa5t+xt/JA9DPzq9qq3vJtw0v2fe3mkpB5mJSIs8mvBX448TB8B/y6UxeXCrzSOfzudzlPpzkcJ3S/En4X9xJvGpGBWS8UYZpNJLBuEWAB4r0B1O07qtAmo5V8ADQWq7twuitOO8il1AxoD2GLXCdGX/FY28AK2ugQks1cGSb33DOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoIlSPmrVyHqGpyyLzLuLHlmUCz8lP6uSqXCaGiy6MM=;
 b=gvLqMm6PZdlTFkgoZCVijJCvSpBeRIH53R1FIOd4Avnk2PWxMI+Homv63Q9jOjJXcfmFSlzr6qGjK8voRPxkUBeJBih+jVpppmIRrfUtVHo/ZxBHh4HusVlx4UW2B1glSo3b+2qsNznLwk0txC9RWCOD1voPurmLfHFxRWKtphZFgkEyFr56zz6WwdkxjIJDcUo3IBSLPfAJatKxG5ixPxhyFY2TKo5wEt0RzUGKMZip788qB2lrJ/ixuKuMOmtAiRc5vfoWqVECdaTu/2em4zE5ud0uJYCfDPuT62xS9EWMR3vNeeK44jMtMlxeUI/F8wUGOY7C9tLlnu5BRLsZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoIlSPmrVyHqGpyyLzLuLHlmUCz8lP6uSqXCaGiy6MM=;
 b=hQHbtqbfzvLQrSG/XgxqS+6ShArXKaGyUcCaqUXefV7C1ZvXT+MVut4dCMmYMXS21xydgkGvsUelQcGJC+gYJJZj2UKSVCYS27CEHDs8Zs99KQA3igmCzW7GmgNw8lLJpRq/5rUdv4CwUfA4lwHPz6HhdDHWvDcRP2y9NvSOB7ODcCKwlHSiJu0Q7ZQNXuDOAUAk9H4H2hBLRcSIxFGvt1ssthKtuor0PHrWP5ietcbOGZuv3g1grXG8UFNUtLDcIMDeC06KfS2Ihe2qmnHlfkilZy9dD459Yr3zC3mrn6/XKG6jWN3z/9Sb2amCZAS13pms2ftwqwnxgQkMUrF89Q==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by CO6PR02MB7618.namprd02.prod.outlook.com
 (2603:10b6:303:a9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 18:44:58 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 18:44:58 +0000
From: Jon Kohler <jon@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Jon Kohler <jon@nutanix.com>, Babu Moger <babu.moger@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>
Subject: [PATCH 1/3] target/i386: add new AMD EPYC models for GMET enablement
Date: Mon, 30 Mar 2026 12:34:26 -0700
Message-ID: <20260330193428.1663253-2-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330193428.1663253-1-jon@nutanix.com>
References: <20260330193428.1663253-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:610:cc::33) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|CO6PR02MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfee992-cd45-48f0-a5fb-08de8e8c714f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|1800799024|56012099003|18002099003|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info: hyZvpmfdtsluvlKDwMLwILO26CPxAvb7m69DJK1FfHzoVe0e/wTAqDOilrCrtQwLjOtmTs2g+EBNfsgYrZR0hr0gVl+hzHtGqrUoCE8X1eC8iQrfOYOVJNAlLsMqXdIxK/oCnP5AFh88IAoO/CIQ8gSAqZIZLjuVotpao6OYKKsc2S2aUqksvavMuNRa6d5I3vXUYrncTDmSJMEuv+OIzUEt10ISiwENGhYyFu0Y1isOYpv2XaIkbYzuK0taNslx5jDMrsZdnBrGMCuligiropID01oG6v0TrbSJBgD0yvbq8eyzw4UhNsUTq2AQjJ+lbGUhJm4ziKvhHdr/S3wB730hc1TkpTABCgdNglMt6sFLsk6FRJimhCPEaCtR14TFp4KDdqLxrLGehuwnzZa4OxZmvD6WmdF7nhpPNY0ISMNtnbJrePlPL8OEHk7OfA0ABYu96a1Ogyfv1Z5Z6CGtOMZDHYvzUXCzLtrH7nhrqaEwpnHeYGxLGqakPB/ONIQ0kO1rZCG/pRcvkIXq/bWS3aSnyXGmvF/TZotcwkQz6QSJ6FmJx6qBnYrV2ArSc3R7yvujGv4rLj+YPZFE5I6dlQA6qjhNMIER0f7bKEfry0NUColOVejpyzM2b05IaMiHH1TS9WDZDcdyK4HvqaY3x+Zzx93tiz5ZMvuuVrXACA5U0O9lzIOXiwD1a4XGce72gIyhm0ErgrenBpfIqlRfOCOnk5HVmRVd7Lb7krbs6ynZy6F7zRbvM1i8MS8/ifM38XKlhjLdmsjB8K7rrX7bCjpozx3zCpEzFjkdqOrjeiw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(1800799024)(56012099003)(18002099003)(38350700014)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ydsJFmDSTskkV3+sIlO5teEHCp/Mc7Lgnu+qWg46FAgyozg3AuMPaQsmXBk5?=
 =?us-ascii?Q?JVWCTwZ0qAHKNn7s6V6FYIyC/3hk9x8wk7BnJXVYZqrcpmGEvjk3h/QqWIon?=
 =?us-ascii?Q?jMOagG5fjl/92ZRkrDyXcHSePC9i0Y88y98NZIyK/FvB7eDTLQrGzyX+47IF?=
 =?us-ascii?Q?V//Hq2MQ2FTQgyD+kPZQenJEuaItmfaZ6xrDyncsjj88nzCkT9hkUw9rOAVL?=
 =?us-ascii?Q?CmW10oxZl9uVEdAP4TwWLWAX02xV0HH0q6TSdb7pucnFqHy5g4CuZ9Gvbm/0?=
 =?us-ascii?Q?hhtusyu7GTaLTI83Twh/EIFGia11hNBVPQ1/hvXk3GX9axuHSWLslDLKpsdB?=
 =?us-ascii?Q?QXeTKhvfY+eZ0yCoZZrLz8rk502rlIcHYQ39aWubnB3avVqz4nUYZGu+BCNe?=
 =?us-ascii?Q?ZBCUa03f6MEVQgV17p7wmfPGpFqiIMfrt0hDDo+W0LNKkX+4Uj3tdRsW+AC+?=
 =?us-ascii?Q?N0zedCH98t3CEKsN3PZ6387etb9SApz78aidFUvYj2RV1dcdDtp8nYtdJhcS?=
 =?us-ascii?Q?esp/YE9HQH8cjRRrQkxAC4Jwbm/L7GN/r4pdAe+hRcjsCQyyWUsd/oSsQN5Z?=
 =?us-ascii?Q?DfR+J+xxwvNWkbLUe56pbfvF1YoGAwiKVzTlRi0GT6fSgtw5GpRZqqmsc50L?=
 =?us-ascii?Q?Q0dCPSwsWkBNaQ9F4BsqqYCWjNeMQXOCscF2aRLWFf59pOjli7RpSsCugZuJ?=
 =?us-ascii?Q?jWUH3J2G0NIjJOS/ltAkIVH71XINXX1GDX0G9Xm/A2R36SOcrJ6qc3tnZEPj?=
 =?us-ascii?Q?r0NlyJIoz419GAFBMw572PtG0fk2LW3ETJJ07n0C5GfkzmfpeASNAWhhAX4w?=
 =?us-ascii?Q?rPI8IEMg/wwuUQqeEaBk6NJ7AYw0vSpLSUtYbVxdI/qSQeols+j7jS0vyMvL?=
 =?us-ascii?Q?i7qMa82S8pHLSSImh3VD2kZ1b02aOkhNsqKvQ3luQ1kdZmJ/Zy4Ui013DEdY?=
 =?us-ascii?Q?rTaFTdyCt4E2CZm4M7xt+awGajE+i9kizui2BEbHhEphWPJLPqafHsScbOFC?=
 =?us-ascii?Q?9T+XXHr6CKSN4VyRc4Nv6bQqLSEyNJuj0to4ZKRUjsV2QPmvZlSXGstxhVtw?=
 =?us-ascii?Q?9jSPnMIdcftnkCo9MdkPLoinAguEK4cCBpT+KD8rxtu1KNg2MWvmrbNqO7Us?=
 =?us-ascii?Q?3vNSs4oAt8ouXA+qDnw4Nalwy9fwXQYJQCvLYvuRcsi8WAPkZnSv41qg7X3m?=
 =?us-ascii?Q?ZByMAYU5Q3A+3SB0E5Tl4NnL8qxkhvHThF0FXP1jjiaP8+UEwF3M1tPc8avm?=
 =?us-ascii?Q?dLQgGha4eDM7SYYpYNrfELBBdg8RQXyFJbPmrWNyGYB7FFQBd6JfAfN32VQ1?=
 =?us-ascii?Q?Y7iHM7016b7s7jqp+dyYeB9PaqC3Aa30RM54ZWI/j+7cReET8Px7LaAvCNOF?=
 =?us-ascii?Q?vA3ZFbfLdis1+PMOz66XRT1L6L3OsroxQ2qmQEUudU9vOfeTCWYhcPjsTtb1?=
 =?us-ascii?Q?YLaxRTvMco8Zu9Yqy3S0ACLPrNtQRDPArYbEY0yHbHTeqDKCZnvBCWgfaGH9?=
 =?us-ascii?Q?81TSbf8I/nqmGw42PtccpPqmiuD2cCxGzB97scogMOiFsxAi8DAAitgm7R5d?=
 =?us-ascii?Q?2KKAJoyVeqxd8iz3FCtxBRCuGnsBaeU+11LiVQNlebSEq+JO0ux7FK1BQUYJ?=
 =?us-ascii?Q?BvMcfadMAhOGX+hbZh6a4ZxamXAxwLrpPHtZx62gYP6oHrITgvkGhyAXT1h/?=
 =?us-ascii?Q?ASNByLRYrfObjDPi6n3tysAOvnzfXpostSeqG1kC2bNpdsa21oxLfyX6GUYx?=
 =?us-ascii?Q?3hf3vXCxuJkmaMD8WlA6wQ6kUvUS9nE=3D?=
X-Exchange-RoutingPolicyChecked: T/eFfTifDjv4T8erbM0AVJ+iRGjWumXL4T7eAPHgCN8eoILhPCSvCylmDSIKrn5BQh3ZbfeCOECQS8cRb/UweHBbBoXzxcsNQ4m8EqXn5l4XkPKOZQ18akV7M6mciTlND8iUt5KYmlWxsIQcHpBB4OiCaexHhGp79r6E2cPbs17H4s8hwnnj27DuLt+MltI4uuGrG94kmCQUBzm5AocWBh6UahkQbFeg+2grk3xxc1ieV8HyOE3+HLIKWrizjIRoaTu49YUk0xOklf9igKHBzY3piMoEPeFRpPi4M1JpIGlngIgyaJ1MqtiRUzrNN/2El5oSH6Pfnari59XVL46WFg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfee992-cd45-48f0-a5fb-08de8e8c714f
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:44:58.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+ZF5q8GjkbcObBS2/nCSeCzGyDLOkHtO/EwS+9AcFKPGpn52PEJto9lJ4jm6KuZhqnIBYh1JGXL+FN6nhFnkSgmWv5+nTT1NEVNZdk1tQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7618
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE1NSBTYWx0ZWRfX89zci9+H0ZLv
 aPvsPSp2qgmCpXaeAE3ogGy7+BQSQhAA3aPeIB6vSrcSi7S7zV6DRLRmROTujYKVl+xUOkt55+B
 BPVu58slxE0XCzORNqAUy+1LWXHvbzkG+JpbfuGlWCV9RISK2LtC6eUhzChH26f5uH9bbcE0A1P
 Vz2zMRkUR6Q5P0ncHVyTQV0euI/PpugK3Vw8pxRPP59kofhFkP94kMHY3ghJVki9rsqcfl8X3uB
 hX77GQoNussu4txSq2mSJs8S187RdG9iNkStXRiWbGtm+ifczxtHWV32KJ6rMnGQ2Rh6mabuCzN
 ZJ1K19lVbwypBAK0E0Z5/P+PHrA1lh5QGaMaXkoPEgJq79+/Qoo3GHIvDPiIuF2GD+rItQTNyep
 mzouyS6iKTv3PPVA4e4lW0j6wt1kh8Pb7kJ52hPuyvcKM7fYykNftsf2C5AkYEKuExuCwlInItV
 Zsve+elpHXt2jTFS69w==
X-Proofpoint-ORIG-GUID: UuUrYICCyfraMvtkLv7Dj5PhewICYce2
X-Authority-Analysis: v=2.4 cv=AIht02iE c=1 sm=1 tr=0 ts=69cac4ac cx=c_pps
 a=MP9y2KnavyzKo3MGO/hTew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=zd2uoN0lAAAA:8 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=fZWor0mvRFvbE3IwMMoA:9
X-Proofpoint-GUID: UuUrYICCyfraMvtkLv7Dj5PhewICYce2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add models to expose Guest Mode Execute Trap (GMET) support,
and add CPUID_SVM_GMET header definition so that future EPYC
models can easily add default support.

New models are:
AMD EPYC-Milan-v4
AMD EPYC-Genoa-v3
AMD EPYC-Turin-v2

Cc: Babu Moger <babu.moger@amd.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 target/i386/cpu.c | 34 ++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d02f6f0653..6b1a3a9b98 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6836,6 +6836,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_milan_v3_cache_info
             },
+            {
+                .version = 4,
+                .props = (PropValue[]) {
+                    { "gmet", "on" },
+                    { "model-id",
+                      "AMD EPYC-Milan-v4 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_milan_v3_cache_info
+            },
             { /* end of list */ }
         }
     },
@@ -6933,6 +6943,16 @@ static const X86CPUDefinition builtin_x86_defs[] = {
                 },
                 .cache_info = &epyc_genoa_v2_cache_info
             },
+            {
+                .version = 3,
+                .props = (PropValue[]) {
+                    { "gmet", "on" },
+                    { "model-id",
+                      "AMD EPYC-Genoa-v3 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_genoa_v2_cache_info
+            },
             { /* end of list */ }
         }
     },
@@ -7163,6 +7183,20 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .xlevel = 0x80000022,
         .model_id = "AMD EPYC-Turin Processor",
         .cache_info = &epyc_turin_cache_info,
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .props = (PropValue[]) {
+                    { "gmet", "on" },
+                    { "model-id",
+                      "AMD EPYC-Turin-v2 Processor" },
+                    { /* end of list */ }
+                },
+                .cache_info = &epyc_turin_cache_info
+            },
+            { /* end of list */ }
+        }
     },
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 0b539155c4..6401028e70 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -879,6 +879,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define CPUID_SVM_AVIC            (1U << 13)
 #define CPUID_SVM_V_VMSAVE_VMLOAD (1U << 15)
 #define CPUID_SVM_VGIF            (1U << 16)
+#define CPUID_SVM_GMET            (1U << 17)
 #define CPUID_SVM_VNMI            (1U << 25)
 #define CPUID_SVM_SVME_ADDR_CHK   (1U << 28)
 
-- 
2.43.0


