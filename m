Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8A5C71157
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRqyj-0001I8-2n; Wed, 18 Jun 2025 07:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyh-0001Hs-Eq
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:15 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uRqyf-0002Y5-My
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:29:15 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7nAAL012959;
 Wed, 18 Jun 2025 04:29:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gSn77C9x/auiRQJuuHWYjX0/vtBeTGAzLAkSeoNP6
 aA=; b=wSlFuIPRcC/DcQaSeKK1hZ+BK/YsoolO01Xtv53roooO6lMqHo3nfOmLi
 d45RE3PQfUVL+4nrBZO7gvPZdMLm/I8bTnUKkmO6fSs5ZTyyyHkRg1x5Di3ZZ3ZV
 VU90NMqmIOqSpWInSYPFLXHT6ExYBOs2HppB08Lc6O1C+GMcGbm7iNYzMcshmXHz
 d11h9UCcxLJyll+0DiSh8f0jdLl4cdpH4YbKVDq9BvdSS5wZmeqj8HhaQG2T/UYA
 YRMiAG9vapRbL5Dey+Nc8UU6zqPYSUadjzSjkrC/v4Rxts2RzxhpZvWZIDaQxBV9
 LIacQfR+l5x0vhZom3JyKWdLomEgg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4798mygsum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Jun 2025 04:29:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyPsL89gFV1JP+jw95tdzw014b+zxUCI3bnfPF/mSpxAUJpoh9VEyWSu8hEHJ1XIQFPn+jjfh4U7IaehY6u9p91vC4m2rztV5TC+RYiIjQCKZ4WihTS+QznWE+2QGx5QYg4veH7eCRBxKMV927X+UjmPempt484hvXDBkyHjw4gTLl3N9ZPrm5f4ZsnLM3i0X7QmYxsZAWWfagDbZf5/PwXbasW5VSPhjZ1ji/E9C7u4az1+0dfX+rpDI9sR6EdFwFjNkG7v+7GBsIuXwmQm8MJBgU/xxMFVGp7OFexGqFy/DjLljAUjCMDl0aM5LbRxINCacWI4D+1CDGpiolc2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSn77C9x/auiRQJuuHWYjX0/vtBeTGAzLAkSeoNP6aA=;
 b=ve3uswrWKjReUA0iNaE2ebI104To1dgz2zwQ6mTaF/FoxQQrBK/+xmqPgSeWQNpmOfbfG4VM1JDgpTRojuKyxDjnmMxvGBJG+tF7ZJ0137A6XJwmQZYYZKkq8Kgiygy1UJQ3P77IeBL1A/ASGCRkns24OznsNG4yn1fJiv9gV8MnhpBJinuEiBT4QOdQNBJWOld8X4/rRMBrlWYOmyEXT1rlzhj2oWM+mIemhzfHZzn01gRtaXBftE73ys+Jd2jEvqOeJAfvzRPJBdzgftZQQ0qSSrBLPUBpviCsb4QNjCvPwDKWH4ApvX+8vaignk1YhThZK9OAxbb7gSlN4Q6Q6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSn77C9x/auiRQJuuHWYjX0/vtBeTGAzLAkSeoNP6aA=;
 b=h6m1pAvQa3tBbBc7aTCLDP1nSNOzCtJtnKRP/eOFHwHtKUG+M1k2oU8EOjKw4G1lugTJA8Hd9apeQqQPr2Q1qbcO0o+Zo2FVJNseEK8XymAZ+gzLRZUdNIoaWxv3v0d9wTWssvDPyegc5HevlQH+iU1og4/ZZIo8/lxQvuQnr1xSXMP3NRGUsqMhyAKAA5DcTOPQc7IA+coy6Porvr1w4XNkireD0guBJNsg6xebyipN2/fyXlsVeQXqj1ul/tna7n83/VzVCEDiJXyTsN5HB09btRSjx6J+blA1+lYZDyLYtm+aQ0/1XFHJxcktpC8vTTleH7GmIeol83GY25KOVQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7295.namprd02.prod.outlook.com (2603:10b6:a03:292::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 11:29:08 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:29:08 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 10/12] hw/i386/pc_piix.c: assume pcmc->pci_enabled is
 always false in pc_init_isa()
Date: Wed, 18 Jun 2025 12:27:15 +0100
Message-ID: <20250618112828.235087-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618112828.235087-1-mark.caveayland@nutanix.com>
References: <20250618112828.235087-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0037.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b92beb4-1f66-4c7e-28ba-08ddae5b574a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MeMQJj5RRQcHxpbelYPddBW7cS1UQs8OAsPER3Qi2PTNbl2I/N5UBKtnmKQ9?=
 =?us-ascii?Q?Qa8vFthdNlyXBYFdPodOMnm4/hfscEn9xV3+E+uB4G480L9p7l/zM0iTTH3q?=
 =?us-ascii?Q?iPBpORPDwxFjvA7uLaN7Ex/O0ayrjyi8pNI3aHaz42Bha3UU9sfZ0Vpdz4Me?=
 =?us-ascii?Q?c2eya6bdrCFeysCFnNEphLSCWBO9t+HKqBYuX8JxxA/Tp4vpWK6hHAv/EtBf?=
 =?us-ascii?Q?AF0DGu9WH+blMHl1yrb0de2+gZJTH+NGRAksjLnzPs6+H1Ot20DV1ZWwzige?=
 =?us-ascii?Q?JZKQzEL8VnRcaod7Sb6zyUpIBeTQcskHdwc+OWoSEKeZ4AJ1o5C8e20siSKX?=
 =?us-ascii?Q?RVrDDHUS7FHRDhVHDgedCv2p3KXu6OojxJ/GwGeFMNWHL9V4HprKNlOWb1TK?=
 =?us-ascii?Q?labYSdIcsNkw4G3C5ksfLefxVxasudY1BKoH0VAs/W93KwfBq69YbzJveX+i?=
 =?us-ascii?Q?uJeF3O7Vpb2JsXnlQKHc2HEwr9BZgmFBJsMWsLmK6EX6TqpwCKWQFSqnNAMl?=
 =?us-ascii?Q?n7Cf9LEwpXGpYIspoeZUjztW/CysOw03xj6zsR8QZ7FsTTqRtdkmDsfYWFta?=
 =?us-ascii?Q?XsDoOgrxWeBNLDrLCOA+EiBxmcsMagEk40UfAUtKdE0q70lvtzAXsaIM+FZj?=
 =?us-ascii?Q?uNajkuTDi0IFbzonCasqR5AdUOlJFyiN3ik99ddteJaiXtDTKB/Etrf+h2um?=
 =?us-ascii?Q?ZxiR4lyiwLuku9YdPo8aAnjDev5kdvfxP2vVK8+5klr/31f15BXwjrkqms3e?=
 =?us-ascii?Q?6/4W27XR1v5oa7IB4SkStUGZ3toGoZpvam1x7OC84pSGljtm9kAx/qKDzkqt?=
 =?us-ascii?Q?II9vzFidS2yj7xFZtnsbwuGQDaf5hWeJjpcv8f2dgFR33waXqGyCDU662CUS?=
 =?us-ascii?Q?HXBimSYcmN8pDAaIS1JjDNn58ZT5VZKeynzQOnS+jZq3Liws52ggqbpa3YtG?=
 =?us-ascii?Q?yJje4Ekd6H1YJfzLoaWeHujUBahhjuIhLpQO5smVMcGoQod88jFz8EqRgnOI?=
 =?us-ascii?Q?YjhhQdVPHgIzhJJU0bOPJLN/Yvw7ymTdUjvJU4UsRHcE2TbqUE5auIAt/Zm4?=
 =?us-ascii?Q?mcxT/5pwfS9uhgBOFC4WSHgW/T8jaReTx4NU84Te4zkSPehFKxYRuAF2LcQT?=
 =?us-ascii?Q?J2zHDWyew5X2m1oY2H6XGumkgNZAFwGXYpE4hNsMVAhpgw/T/blUG/L72lfI?=
 =?us-ascii?Q?Ii8vmMXbwsDlmwNUd555VjlQhYhV2C6uzW/AGv65tK4CH93QtAoxx+ZURQft?=
 =?us-ascii?Q?WzWNhqDUQ0M4PkKCxRt5RyzBRoFq3xKxFHV2S7HpbuDdPIlKBfwB2L3fSNiy?=
 =?us-ascii?Q?R7lUKhyq78OD3TfsMUEMg0G+/wL0al92vDNewbv3jWQMt1AAkPtl9vsSm3K+?=
 =?us-ascii?Q?fSfVbUk1bKr+vhEu9fF4zSlJkJwBIxXuHProCUpBvqbfP6Y9AbdKsT7Mqkdc?=
 =?us-ascii?Q?1ddFNsmcu0k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQUbidhPZGqcrqRavGaPOtG4zfCIw6zsuTpPZBfXAmMpqZhcobR7wM3fkyPF?=
 =?us-ascii?Q?yuaZ1nJKt0FxGpzRuL5jtdBICz9O4Jl87K8rklYBmCOd641I3BqdJOsKwYC3?=
 =?us-ascii?Q?ch+Ipf4x/dbL6QWGLNld0aBixbEZLpShtPIyzscAko1RlKnwkkyUrh5VPbJ3?=
 =?us-ascii?Q?pczQgjJtpXLi0g37LSii1Bfp4S31Rkw92gw1FyTENoUI7CIvwVY1FKH2grWN?=
 =?us-ascii?Q?9hV+zGk2574E1MxCT45VY7lli4TwHJGJn9bggjWgc+5IEC94g7kIWIfqXogb?=
 =?us-ascii?Q?CoZolWVQCRzNLpaWw1S998empnsocNJ/P4y+JQZpl9JrTvIha71Fjy16Up+P?=
 =?us-ascii?Q?sGTvnsJ3aYN3bve5PWez5TSSMuFvJj0ruTcbzm+ERnXG3ogdpbH2htJvk2ZA?=
 =?us-ascii?Q?Vry6Q6jizFkjLvKWbE9q7Z+Bji+SPaVM6rEPKVCGqgIXBM533G2hDm4omuvw?=
 =?us-ascii?Q?tRZPs1Psx8/vloBKrCxgUfY/Q4mKMT7AZb+7ZhXIZO/9GhJ2IMPr2oI986tr?=
 =?us-ascii?Q?27nn51kFJCZZDIrLf2w8JmHdnanp8f3wG3Cdt2c+tUvVib+/Pr6Huwv9aHTD?=
 =?us-ascii?Q?m2eoMnFOHHQzt3O2taCS/v96h+71x45nBiA3nQ6JGxG4tF1JpkSgaqXtHPCJ?=
 =?us-ascii?Q?MdTCdXpZ3NmkZRkYqHiKJ6AFr2YQi7r+D1ODNh1v7xkeFQfNfV0V6fQImMXC?=
 =?us-ascii?Q?8+9zp7LQM8FX0zk9Wgua2oJKQN2fOvJ3N7u3DN++mTRyBE4F8/8WQoUTTyXs?=
 =?us-ascii?Q?JLqNgIRdgW1Lmk5DQvJ9JHp11OMpfEEURUZsr31xhAcbK5k+1sscWCeFf/FI?=
 =?us-ascii?Q?kWABjmGzUVV6av5tM4p+HsykUMcVpEf4+3ozLUFj8jXtD3mYCjsKX673Cvu6?=
 =?us-ascii?Q?rPuyAxZxw87vE0Hu4RPpeN1LJFidzTH3bBdZ0pstBqYbx4C6+Cb/M2T8ksom?=
 =?us-ascii?Q?EkprsOmVVDAI+1UPYDDfqiKzvOs0wu0GCi9QdyVIVVxdUSBZ+T373qoUOKuy?=
 =?us-ascii?Q?gtRZGi+gA1tRku4JyOSah0yB0/3oJCI2B0V+HR9GQAqC1r3ixwJF1x9tTZEL?=
 =?us-ascii?Q?NVHSuTCkYsxwl5XLLGH/BR3/xEtNO7+VsucejDRqHU+rJZ8hFfK9TXba38gU?=
 =?us-ascii?Q?lA/GJipp7aVPFdn2xlbxKlELe879rXusljDr9dcRZQysZ4XG4MC5fR5fAsHH?=
 =?us-ascii?Q?UhDhqpB4lRxEKS6SmBM35NOMJD0EUzcOCY/TisZIVzncMPNrP4kw04LqQ6uy?=
 =?us-ascii?Q?+Ru+jiNxHZswLCbO9ltIpc+zd70v0ZFfVzpTBRZq3U6jzZVmH0UaCNvlR3MT?=
 =?us-ascii?Q?Q6BC6NBgo0y/lIVYOlIdIpsO7MLwdGFDLbanGRN8ysrlo3GBI2VWFL27OVGa?=
 =?us-ascii?Q?Go5L5rtwN6K9nz+riuRuGzL27/U5Ogfneug6sGk4n54WzdQk3VuuTUv80S2n?=
 =?us-ascii?Q?qkNI4Q76sSJ0o/37UfrfeJMl8shTWBHQCfWDEM5aoSd6/5ALY4FuCdT6cuP4?=
 =?us-ascii?Q?NkaxZdfiLL32Itq05ISmoy3uCEJNSFtCWCR8NzhzGitYAxfI4ywI0Pc9n0JY?=
 =?us-ascii?Q?zbQqW9UHnfQW3OCk5lCXNl3/Ld3YhC2GrxYdLfQkWJI495qSQwcvm1rcHITf?=
 =?us-ascii?Q?cf9T5HKJZs0VsqshjRTctSC6CV7S6aMANSE7/NItMUV/UzfMjL8LdGa58kmZ?=
 =?us-ascii?Q?7uNUAw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b92beb4-1f66-4c7e-28ba-08ddae5b574a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:29:08.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmLKMbaIOp5tLdPFu+mQAIEe17hxsT4He4nrKfI+dZiQFbvAor9kvcyM5OVKgrrkORQzoEMsIRL8mWQzkiYcbjAefw+tC8iO4gqvrgyv0Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7295
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA5NyBTYWx0ZWRfX6O+THFY9EF2C
 tJEIsKkW1UJW1vQtTGpiimWh4TGKh30l3jNw+0ROnoh0bir3aHETEXpwDkzYG0z8RF1ftob8ggR
 7m9OZRt05s0VrqqsRZH4ehWTeLV1k08ZD0WfS2yG5x/L4b0Er62SRTGmP6Q6yOakidgrOcjXUuW
 ch2dBVV8SMuRjMbBK1dU02S1iMp1jAYhvEMJskbf4jB7sQgdCzhehwC09ABf6pQhv8tGh9BHP9e
 nh+dj/iNcFj6vbmYzp8jCfJegQQ/DTLxzcT3Zq8nFB75ZHCrQeY7i1+qd2CRE+y7M84hB5hSgc6
 AdezlmcFdAsLwfZD0l/+LJ4nYjSzuYr3mzRS7Q6Psjxeh/yQ0Y2nvMOl2Sg6y2b+8dbvfMqzbaJ
 WGjkTVnEwgnO6gwgVlZlTyuG0fRuPrHoPhAU9+HobRkJI0nwXHwVl8q+jFSPle9xhBzXN5Ea
X-Proofpoint-ORIG-GUID: AY9tJJJqkYYyCE2_Ltf-BwEHyUTCoenI
X-Proofpoint-GUID: AY9tJJJqkYYyCE2_Ltf-BwEHyUTCoenI
X-Authority-Analysis: v=2.4 cv=LIxmQIW9 c=1 sm=1 tr=0 ts=6852a306 cx=c_pps
 a=bSwf5PjAXtVgaDY3/5TY7Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=Hus2Nip8kLtf5UjimwgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_04,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.895,
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

By definition PCI can never be enabled on an isapc machine so hardcode the relevant values
set via pcmc->pci_enabled.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 03bd09f680..279eab10ce 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -462,7 +462,7 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 
-    gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
+    gsi_state = pc_gsi_create(&x86ms->gsi, false);
 
     isa_bus = isa_bus_new(NULL, system_memory, system_io,
                             &error_abort);
@@ -483,7 +483,7 @@ static void pc_init_isa(MachineState *machine)
         x86_register_ferr_irq(x86ms->gsi[13]);
     }
 
-    pc_vga_init(isa_bus, pcmc->pci_enabled ? pcms->pcibus : NULL);
+    pc_vga_init(isa_bus, NULL);
 
     /* init basic PC hardware */
     pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
-- 
2.43.0


