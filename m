Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3928AC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGMa-00086u-AN; Fri, 24 Jul 2026 09:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wnGMY-00086N-Q0
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:54:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1wnGMW-0002Tk-5p
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 09:54:54 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODfgR2414594; Fri, 24 Jul 2026 06:54:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=q0a44Nn4c4vXx
 /f7AZXwKnkbP7yEaczLWHGmNNU6nvU=; b=cmpfYFkELaS/M4d6TsyYh3OGYTY/o
 t/04VGE9HVFKu6rBWoxbPXtr5LuRsEWSHFXjuRt2ipr9usZL5EHhKeLyVLvol6HD
 SxC55g9l1JrzNwVTchwpf4E3VS42R3+fAZDV4/C/lAPnB8YVZFIc3cAQw9jJbp6c
 6z0N/8GzGQk96ryGaP6V7sQ5dSdLwGx6F1sCmQnGOgaJHtZX759yGD0OfR97lfzf
 Nas3RAsM5ZDGRs1E+Vdwje34AX3e5cn/20zdV01rD1dBCnsSGWbkg0bkQ6qtCq71
 ZeJB5Zjs/+HK2rXu97ljoefNIF5BxaFJYAS4xsIPdpFYnzyWMe13mq+PA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021118.outbound.protection.outlook.com
 [40.93.194.118])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fm824051m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 06:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Udo1E9gkEqnBIo+G8/hpNEytypS4iqwEmua9QA6KFmvwvqR9wYJAVl1pT1/m0w/kqhrT5bpdJBlTZLOxwjEs9+1Dotg4uv286pN7Lisxe/qLu+cBMs1LWVP4PwCs8dwyGe9iEbj6OrGM0SqJUPISz2I3N8XD8jsofmvjw7oDgba7QQitkeu4N4TIH2rkA/qGTfpksRiUbIlK+0qs/kvYbMkKgsmsoSNZ9PJgj/JRlDV7F/sgGmQAtlpT+UDXEmUVU17mAMZbprFBdZDGCcs/MAlWdYWmU0W820joZrVcEyLfdJhO9+nGTcA9Gc58aEMvw2J9SMhH4+od64i1Q9EwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0a44Nn4c4vXx/f7AZXwKnkbP7yEaczLWHGmNNU6nvU=;
 b=TKkDHc0EY9U3Eq7KUCzqtl+XEzvszTlq9BRh1ARZCeEH80ASaoOVy2w7JnPLJNG9J/5KJxoCa4KyL8Twvfyji4POqj2Y925wLjKggxl0Qay4yi+YHxYtLhzmSUZyguzWryr49FeTMr4w/MgvJwo66TLC93Xlt/qL7nHhFBNuUZtRJedvJ8X93h9MA/GBdXi8cyqi19WML/PHpzn0Zc/lEp4cNf0kRNqIoCs+NwEVblSYzSwlWrA1ZDLwdOeou+3aalauCAtSm9VsMH1sF9Tofil2KbtN0P4bBwbIOQnURllgeOi3Ke9J8d+M+2FKQWmpBbCTFroyOpoqlTmL2eNLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0a44Nn4c4vXx/f7AZXwKnkbP7yEaczLWHGmNNU6nvU=;
 b=sgAlNXdd7L82+SuSVid2YSjhGaB7YCKOaUPhPFq7o2Ba5PDCdHzjzCXSM+Z80S4tgrGxLqhPZL/aRj6PnEDaPtf3JKkf8uzbVg5K+er9R86Z2jEkYXEvEzHMJe2rHQEggxdf8tZMXqLTdnEaOoaHyIAoMFEdZFMSX0xPrU8s2F0ZcfMqRMYRupJ+CRZGbJlY0JBpNInIXixO7Q7Al+RlN3iz7SjlQ5Y4TYAYXxC/cwAlKCzur89pYpEr7ByMHLT05c8UIEKW3Sh8UB0UVVNoFEGHJvsbfSawt2byTOb3RI073n1IhidZXSrlMehHORC0qc14KugwKiJiYrY4iK9wdA==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by CO1PR02MB8508.namprd02.prod.outlook.com (2603:10b6:303:15b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Fri, 24 Jul
 2026 13:54:30 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0245.009; Fri, 24 Jul 2026
 13:54:29 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Florian Schmidt <flosch@nutanix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH] Add option to disable building tests
Date: Fri, 24 Jul 2026 13:54:13 +0000
Message-ID: <20260724135413.1716872-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::34) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|CO1PR02MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f599e60-cca7-4bcf-8fa3-08dee98b1502
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|52116014|18002099003|3023799007|10067099003|56012099006|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info: 1eLmw9B0cnhkQ2TbVA03Led4ldbK0lfiTv2hYQ96PGJFvjKbFWFKcsCHMQqL4u+BXMygFIkwYWEqBAnQsVQfTaDT1h7EuTR4rafuSQ4hmCeeRiqsBa1hVyP55I8OAe8O8MVFaln+Wy2eFLwT7IWv0Q3XJtjPSeTpCu/iMoEX+FFCQwQlw+Q0jvlc96q/qk+On36vJa3e0ojCyz0iWJfOCQ17BWUVubEa+0AJZEVckwi5wRphGhpsBPDH2tHYe3B6rPY/Vu8XZQJ81vRCVcrm3ef9jxxaAqzl0R1ZH6Oz4+WXdwkxBAg0STPB0R0tTOLH16xH1S89a3shK8UNjvd7huejH5VEs6TqV6OUb9dIpsev23gV/cQ0ZklmJV74Oufv6cnWMTmsWunNy5aoITXCrTjeqDi6f8gKjCOlr5JOxydTfcnyYxzfPOO1bZopkXU+GDtYCpx2VqlY905h0ub6PRZmMzHgsAtFhjrM+DSppMSGmgGH/+jAnsOhL8FWqWtQmEPEA1BJhte++HODmZ4tFqt2v2eufOuIqOB6Rmiz3JiVnjIvyDPX7P4BRFTyESzmuf0f54d5hOAI7hm2d2T6333F8HLH2HddMBj2kyMOh4ZZibZs7FTmQlbpsofLNrd9ukFGPItbn9nT/XTzufTQ45h3u7RxH7NPRW6t3qklIr6nsP+OL7igDf2DmBNNSpWvHjJuWLb00p1erRYKkTOcFySwqDrvNZAWZaETnsTW1Rc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(52116014)(18002099003)(3023799007)(10067099003)(56012099006)(6133799003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9bqtPAc2U5s7mu1v4MDOhXVxBFlYyKWguzMoEOtVDHPISErCoH/LVasZwM/g?=
 =?us-ascii?Q?oH204TAIrYef6M07D+0dBCKqTCn8gVF8NaO49+WT5+nzuCAZrRKo9cbz7u4Y?=
 =?us-ascii?Q?jIEgIcsbumT9qPekwKWDf3PPaK1BEn7i0Qc9hXw7jSQaLvVPwsKj1yBYNcs5?=
 =?us-ascii?Q?5XbYg/+8+kzmoUl30Q3+R/a8YFeKgRAv3iZPJk/heGKTXDb1bRKK7rdwh9as?=
 =?us-ascii?Q?ZDIYBTUsH4BYKAefBo22iE565od7mKM2U3qw6WJYwgqgslXjw9ejkyqs6fFW?=
 =?us-ascii?Q?1CdRgDln2aTMBg7m+SMcIBebQYwguZwmbsfv/3AWs5ee0BqjjGuO3xtTzjy0?=
 =?us-ascii?Q?EtowS8jOpn9PTlWoCn+KC0Ve/CdlqqMQKnswVyhoShVqw19ZVgNH2e5ZlUg8?=
 =?us-ascii?Q?rBKFiDSoF/F5GQYidaHmnNVmIXDsqxjZz+VfuDMfxBXzj+BO9opIz4Bhpv36?=
 =?us-ascii?Q?+JXSl1BaCcW8nr7WCrGDJ93TPMZjG9NF2jKagSLsq9nUAhqPWTlKkFqGO/wd?=
 =?us-ascii?Q?fGl94ww9FTt7VUpLJvcGEJKhE3I3deo5b+q41IRrPqMbO7aHuTAuF5Mwq/28?=
 =?us-ascii?Q?oq09oZPHQ2GZVGMn5oo+7d5f125NyIT1Q2BguaeFU967Ws0A1sOkVjOlNzZj?=
 =?us-ascii?Q?9+TcLmPILCHHrb9qzvs8ek15RtrEgWVPv2J5bnYpGhWdDtWuLJ6a09xi+AHR?=
 =?us-ascii?Q?sOsyoKRxF5pJpvix++aKFm/UxwNMC3AV8YYo6kLxVpY8N75iL2OamIR2EX5/?=
 =?us-ascii?Q?WI5lh4UCf6958V7tNZaPUW+2gshwgmuNXUsh/ihpExWB06i9oJAgk9dWdDzj?=
 =?us-ascii?Q?drh1E+wrqDFymR+NdckBiOsE37D+Kl/U5Uxz6bfI10QkDA2mELk7obw8i7/l?=
 =?us-ascii?Q?C4Ow+UTXq4kykfb5P2/DpLiRZyhxBoxzTIiDuLvjMYVibMjMHmWRmxVqO9qr?=
 =?us-ascii?Q?2aBlTvd6+jKU7vwXkWMo+1I5VEMBE5XqT5SfZ5hAm4MRhb9PrqmjekobF7Jn?=
 =?us-ascii?Q?2rRrMTVrmumVSJj6ilHFGnUMd8Wm9QaZ522vfm5MhuSweBV/5kw/7peHQ63O?=
 =?us-ascii?Q?fGB8/lNRmvmFiHI2T20TNgfgjQvI+enz8EnJNHoj1clR5GMOIF3I4B2uT9lq?=
 =?us-ascii?Q?DAzTnlFyhWzDaAG++J3UTczs/u/lWNKgvymiIIbQoAkUiiEXcEZM0oBVj7rc?=
 =?us-ascii?Q?joWwF2MMh+30guDwPqfRES+kP5/YopbQ9cKIAgblYEJrQfZZzT225tiJdLVA?=
 =?us-ascii?Q?C3B5Ep1GExwa+sjAbaUzaSZEkum7tjkWjYYw72X4gA0RLaD5z8sbtQUjzu/J?=
 =?us-ascii?Q?kQ1NT9q3FRrCZuSzOY6++oxEDh2ieO/iHhQKlMiNbGgmQf8BdrlEUfyaf8PH?=
 =?us-ascii?Q?NHC7rR9ZCIjVhF4x6vN6sacFQzM2jcx2LYQbVhPhJ0YnoPRBjDl2l0J4zyuN?=
 =?us-ascii?Q?1bojW6xYOj8em2KVSmde1LXjHVnVdj1zv/D0LbQyV71wzxWZiDcby6xtIyeM?=
 =?us-ascii?Q?WKvnisfFyQw/z7yTJbVRBcOnmuN9khftSo/q18wSRQgXvYZdAjZ9nACOFaSv?=
 =?us-ascii?Q?tjBuyHZkq+9GGiqvJnfMBBMSQLejNuiZsGrzuhDg/Rq/OcSt8dWMiehs46Fn?=
 =?us-ascii?Q?VpBxdotlmM+BjaQkE412kurqc1DPeRrbmNkSnQR4lPoimidTHawE/V5lxa5z?=
 =?us-ascii?Q?J18lkuigrElezSSUBT5x92btkJzB2HjWEbvIGHaIoz3w2CVD897xrJKVgeg7?=
 =?us-ascii?Q?IXtenHZhielGGuGknLpmrtZ2Tui/zPk=3D?=
X-Exchange-RoutingPolicyChecked: R4EC/3nGKl1oK2gSfW/ersaVbFi49GFifH5cbY8BpFdhK6X5qnzk/v3oPnIbr2WZXhVPreW2n4+GXJgPDnbUMkJn7WIizT72Jt5FKeTQEMqRF3pQn7Rh34FVo22bRf6bkrMiUMOS0ad3BPVINkgS23XsV3O8zaN6w/ZE6pBJ1S+SOU8FwcgcljIjECGGWhF2EmvS17YTXdZ5VJeJw6wu0pjSZANUO/fsWMC0/aG5KSQsLnTrFGgHDYosOOTfZnKv1M4uaTJSt8VQBOfsDI5rgEWtfKk1z81MZGNCUT6pozz8TAMdinHmXu/tbwx4iKHLlgtv0aVIRV8uy/crZIvE1A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f599e60-cca7-4bcf-8fa3-08dee98b1502
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 13:54:29.6476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFpEg+OWZX2f5KJYgVUcWXh4Iz1D0t/3LWbO969HVIo0m9MTppWESjYFSGRWwxSnJlLlzhDrT4p8PIEqBmdHeRu1fsDV8CDPnebdfU/xzAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8508
X-Authority-Analysis: v=2.4 cv=T+28ifKQ c=1 sm=1 tr=0 ts=6a636e98 cx=c_pps
 a=SIO/v8SSfaR8RXaXrLdUYg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=TVaxJAd7enWfR9znI-MA:9
X-Proofpoint-GUID: d67jK6rfWIWjrhThhk7xBPUc6DQ_vNYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyNSBTYWx0ZWRfX2oHL0bR/YE0K
 uqgy8yqhl4Ca7v6E/WjpSwmzZKxb8elNabZ4TPuPp4I0kyI4NT51CxkKlRWmNfcK3wurWfFVcsm
 XATVwpxi9RHBLgS5MePllm1qPRADXOEhsXEgSWQuUP+QybVCVDm6CyXgMFkB84Ek43xuh26fHnU
 1ixovZeHQA+Gx7y+e10fIDMRk83eF/SCz+85lyEmViSjUkOLwMo3WiMOfdm/y8GPYm1fU5Vhuso
 +Gos+KOhpepx9hJbcMf8Q8QjUoxFaIbpCXXDmnQ6Cn+yxt+AdDNCx+sq26QA322NFV518HC/r0q
 xVg91vE7Cs5grcBLEAP1YReysI9kJuvNHhsZMEvXVDmqC8b7DVUWNOPhMGCRBz5K1aRnkVab3Gp
 C1RzwQtm2WLDzxgDNUbj0c4K5Bpokb5ulHFCFENgtvbwTUwKZCdsBADrfyaAaWsYWklGVotPa2H
 DUCXYUt0gTvqkY6OSVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyNSBTYWx0ZWRfX/nlJB9bpX2/7
 sNnug7owutIqsXrpSAVG7T07GmuDHLH9q8SYRIB0dV3eKWEdfi7lSVFwHtEC+zi03lVaqjmdk8F
 /17P9AcMBvTSW0sJwbtWsC6PqRpiCu0=
X-Proofpoint-ORIG-GUID: d67jK6rfWIWjrhThhk7xBPUc6DQ_vNYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
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

There are situations in which you might want to build QEMU without
building the full test suite, which in some configurations can take a
considerable amount of time to build. This is especially true when using
LTO with clang. For example:

$ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu
[...]
$ time make -j8
[...]
[3078/3078] Linking target tests/qtest/qos-test
real    6m43.250s
user    101m15.967s
sys     4m3.813s

$ ../configure --cc=clang '--extra-ldflags=-flto=thin -ffat-lto-objects' '--extra-cflags=-flto=thin -ffat-lto-objects' --target-list=x86_64-softmmu --disable-tests
[...]
$ time make -j8
[...]
[2024/2024] Linking target qemu-system-x86_64

real    3m14.277s
user    33m13.174s
sys     1m36.642s

Add a toggle to optionally disable building tests.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 meson.build                   | 2 +-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 49a5baf5b5..ad728c26ec 100644
--- a/meson.build
+++ b/meson.build
@@ -4605,7 +4605,7 @@ subdir('docs')
 subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
-if host_os != 'emscripten'
+if get_option('tests').allowed() and host_os != 'emscripten'
   subdir('tests')
 endif
 if gtk.found()
diff --git a/meson_options.txt b/meson_options.txt
index a07cb47d35..68333ca402 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -43,6 +43,8 @@ option('gdb', type: 'string', value: '',
 # on the configure script command line.  After adding an option
 # here make sure to run "make update-buildoptions".
 
+option('tests', type: 'feature', value: 'auto',
+       description: 'Build the test suite')
 option('docs', type : 'feature', value : 'auto',
        description: 'Documentations build support')
 option('fuzzing', type : 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index c003985047..3fec13a336 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -194,6 +194,7 @@ meson_options_help() {
   printf "%s\n" '  spice-protocol  Spice protocol support'
   printf "%s\n" '  stack-protector compiler-provided stack protection'
   printf "%s\n" '  tcg             TCG support'
+  printf "%s\n" '  tests           build test suite'
   printf "%s\n" '  tools           build support utilities that come with QEMU'
   printf "%s\n" '  tpm             TPM support'
   printf "%s\n" '  u2f             U2F emulation support'
@@ -515,6 +516,8 @@ _meson_option_parse() {
     --enable-tcg-interpreter) printf "%s" -Dtcg_interpreter=true ;;
     --disable-tcg-interpreter) printf "%s" -Dtcg_interpreter=false ;;
     --tls-priority=*) quote_sh "-Dtls_priority=$2" ;;
+    --enable-tests) printf "%s" -Dtests=enabled ;;
+    --disable-tests) printf "%s" -Dtests=disabled ;;
     --enable-tools) printf "%s" -Dtools=enabled ;;
     --disable-tools) printf "%s" -Dtools=disabled ;;
     --enable-tpm) printf "%s" -Dtpm=enabled ;;
-- 
2.47.3


