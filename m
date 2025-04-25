Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87AEC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 11:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Hdg-0008Qk-Hv; Fri, 25 Apr 2025 07:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdf-0008QQ-17
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u8Hdc-0000QK-Jf
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 07:54:38 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PBn7qo009826;
 Fri, 25 Apr 2025 04:54:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+6UudWA7g1UlkyYSQEjdq083k1toq9cXzfwQzsXtQ
 48=; b=RtzWVtoyOP9m8E2B4B1DE3EvUHXbGEqGo+dyYQ0BthAItiuNpFd6iF2U0
 bdJth39987vPSdRGPyHdPtwyUGOFWsu5ZdOO2wHm/LLtFo6DEMj45gnso9+qw6Gi
 PG64aYnDQ+j5XNNhv+zDUfb94X3BNixbiFmibFEYsXJOUcCMX2T2uBwMaBgfFVlE
 fAGrxWPAM1flCQl/7G3zZ9dGM/b+p506GRgTgWHjOMf1dc1grY1hJENsVU5zLSA8
 wTWDIeDSRnnofQ4K1kPc6OHvtHD/Wbe4cgfvZjjB4xBV3hkzXLKm+yzFEuwLbRwC
 YRN0Psjh8ZVs0Nt+uRccubeY2Ul1w==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17012036.outbound.protection.outlook.com [40.93.6.36])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 467ww499ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 04:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTpN+7kjp0T2eYeiuM0YpcovR0lh5f4rgeP/4QzTBSUxj6eQEjYIwPaHvctQCXxbKSUtj8hlc3mAvpzgYLImZ/GUDyN1VEMI24aIpqGdochZn4u1msSit5zUI7bx+x5WSa9DbeHdF1/HQ4+cElbdz1hd4ajK6uefakInIftQq8sOzaUXhZH6WilEIZI8I5FgnlNxK9EUVqbDtcB8NhvkbeSAczDpg6aG1ICeVmKxs9A85xaNfPSUGDCk9Ef4QanqaQckYgY3xVlwigqnYFE+CNeHmDxg/ozcLPqdKXrO8eh+ePm53/y12HiZgjXAgO7IH1QnjxebNCm6JfWUXePUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6UudWA7g1UlkyYSQEjdq083k1toq9cXzfwQzsXtQ48=;
 b=HM7vJ8660+N8AiKvbegVHxl9X4tcoUHeWR7UUCr+xsTTejD/TFAVh6aLYbrDBxcdB6pd+xqCgud7ifV45WFIzvAfZpr384uZj1D2yH5tXy61uOjwcz5IaGM0RPcHopSp/XnxGo8Hl8DyCbQaVqeG3bVaKubXlVwUkVH5c1Kox++euWj3qLO+WVOgao5O1pH34falErHhwrGcTuS+0vfv5yrApETLIH6oSN4f5mRUsVVdMBwkLmanKO6sMdZrD8KdsyhLjw1QMmpugPd3K2i/Ix4XeI3AVld8eSGKD6eH9SlL/pp8ohyyKSU4NROEh4mCymb3YxnfisCw77do8yXYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6UudWA7g1UlkyYSQEjdq083k1toq9cXzfwQzsXtQ48=;
 b=fOCmvrHotwk5+bI5ztTmmEfGBtM9esaMOzb2/CVUyQX1qNDMjcKLoFpbgJ3dXwRm4lGw1yiRULU4vjt/3xWHBAdyroslmdffyEyScJzMMlU8mPWQ3v8F6ZpOVGIiylr42/a1TT7/q0fmrypd7v0WY5E3uKA0QOmVv7dCzY3AKsbQ9RDLvBavGKf1lW0jro7/IFVGcf4WPB6hhrK42W9qH4F8ZvXZ2zT1ZMkt/xqVz6/Bd6VroPQ5Bz4g7JD8Zfu4bK3iyn2e/5q2jI3vxjziDRMR+SpTvQh0SDuHjMjIL+6bJWslZXUwEbU2k8sN0l/ztUq35aJ0UUX5uDvpVl8H2Q==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 BY1PR02MB10337.namprd02.prod.outlook.com (2603:10b6:a03:5ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.10; Fri, 25 Apr
 2025 11:54:31 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Fri, 25 Apr 2025
 11:54:31 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 09/12] hw/i386/pc_piix.c: always initialise ISA IDE drives in
 pc_init_isa()
Date: Fri, 25 Apr 2025 12:37:56 +0100
Message-ID: <20250425115401.59417-10-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425115401.59417-1-mark.caveayland@nutanix.com>
References: <20250425115401.59417-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0004.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::19) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|BY1PR02MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb4b512-5986-4d0a-b052-08dd83eff0aa
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TJtZpWGQepb992HZ1oluwnc1IjtLh+P2tNDIApfSR3NdEZwfsK6M9iFqnQin?=
 =?us-ascii?Q?2uXVSpvOCeMpWKtE+OPLyI2X0v/Wbvb9eK5+4+Dglfhb8ipqj60L6Rx9tTDB?=
 =?us-ascii?Q?z2jbFTxeicgGwlKF3alpBRx/wX40wWjhr8wga/2qLHaJ2HYTyaWdMedZB3rQ?=
 =?us-ascii?Q?I4zJ7rTcg9feUnT6HVGcbexxzmYdBaGOI79raXkT7zWeF3gifGmaicXEIHMu?=
 =?us-ascii?Q?yxmYu0TBs09JBDh+AvW3HMPY71qPtGN1ZCD5qU1h4wV7MAtNNnSOKvkfcb1n?=
 =?us-ascii?Q?JjDP8Oh8ATCWqwC1ythFPWXDFNH49SadSSNZkR1LPz9IcmF7aeedFpM7BzMi?=
 =?us-ascii?Q?8xL/1DisHj3KrepYEEzjDoV0xeOMy83S3YvKdtE10Hd7m0GoK/+V6GHhU36C?=
 =?us-ascii?Q?DMWeWSNWUVZOFvzOYpC+/JlGYyNXoMnEs3zqZBROO/2+us4NkQYninlEO/gs?=
 =?us-ascii?Q?p9nkJwPHcm3jydlrKhC2H1FawaT5443LljOLDxs1OaHymbI1QLxMaTffZF9O?=
 =?us-ascii?Q?tbN25FipjLInZV0MBlU4FosR/NRsXIuLxjPsb6q7PKH95EHSCXVVUqIkSdj/?=
 =?us-ascii?Q?XhexPjl2J99D1NdcFKUwTE78gT84o7q2pzvj81X0vXE9cynKzzxT1SS6TvFu?=
 =?us-ascii?Q?2ZK94p6pMiFCEzpsE9V1QnweUYf6+604nCaji3M+cELnRSuYfDl3kZsnWWCf?=
 =?us-ascii?Q?G6gwcAXzeDinu6IjLu25dME2O7FkBH2vdtHWRjNKleaWYpw917wm5OfSNDzq?=
 =?us-ascii?Q?ZMAElZp8pnR6S1ouasdA40ETU0yk/o9x7YCN4VlRLf8Z2prr1TqkiVIH9IjB?=
 =?us-ascii?Q?aUJXPtOb9WMNMhCkaUVkRv/3m9wqB5Ktz70ahYPRhUluM3ZCAcZlxneqpc/j?=
 =?us-ascii?Q?JB8QC7fireD3tEoGBpkTeWP7pROEW/J/Oq1GqC3ZjIKrt+vgU3Gd/wEyPXgO?=
 =?us-ascii?Q?nNA6kwQdD01cCy6fDcseNbl2ytrym/HNvWP/cF3uUqTjeEdZ4i6Xqou9KooR?=
 =?us-ascii?Q?/wt/CwEkRJsgZsyZ+j4BigI+3SrVoxdvGTzyvnxSMblknRCP2L0Yxf7udOu+?=
 =?us-ascii?Q?KV+ePIKD7EAHmFpIqCRY/7ccRU+6t6qO4Cdj2g0aUt9tqQIzkSb+iMaRreqy?=
 =?us-ascii?Q?PE2rAnvjYlvYx8qkFzVThAdwYlfaT6SXL5hQY2QvYs3mHgoikqmZwEIw2oB6?=
 =?us-ascii?Q?0X7qg4EIcjBwTY/+4vR3Cn9OIGBhshy6mtT33lGEPxNo3pjnQvbxDKn4Dnmh?=
 =?us-ascii?Q?IvlpZJ/JyfScJLt4fwz6NoWAhegjf7t6DPTosD9FIims7orjNO/10mbGFFw9?=
 =?us-ascii?Q?5dpLbc5ZRc7Zd+NNGRuPdivQqvmzie1ZcAT7z45+8IdMEswLLFEzKeVORADU?=
 =?us-ascii?Q?KPG+zmypix7h1feVoxg2c3wDygb76RSz3yrVDHSbWPm7lx/JmA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uTATEPuhNLQnu+VcECOQE1FOyImZxYCpzHuKkFQ9wdvmK5aC2aruRsVHWI0y?=
 =?us-ascii?Q?jyozlpLQR4TbEprLcLOz3/G3a2MHTXMrr4rm3yqTQAJ1THpIaBNiHNqrHfPW?=
 =?us-ascii?Q?4MwmQcrdHeym6CnUYEgBtazt1ioU99MBxAaQz+7ePaKkTbuE/btEfOSC2uov?=
 =?us-ascii?Q?dNGZ2bh1LQT4QxhGcsw14x7tmek4Zt4e6t+jFb60grvh135/v3+FmJOYFeKJ?=
 =?us-ascii?Q?3OG2WP8EH+COhowWp7FaOEZcOJeqBhDEYn6x+YrBf7e9WWiE+yMoonzyA8z6?=
 =?us-ascii?Q?8A9rlVIow/bPTKNu85ob0kYCe0tZGWEzX+naayPHSAtzjfhZ79bQDniUA0Qr?=
 =?us-ascii?Q?eD/DgKrnDeZ6i14iP96SqXzhflOuWni+5fjCudPRmkTkxmpUPHB/KMKDnnNJ?=
 =?us-ascii?Q?L59Aa+Fg8tpdv6IbHU7ctHIbGO7aJ49tLTFJqAL3iG5+Cn3hcbckD1PXqDIp?=
 =?us-ascii?Q?PfY/fxUL8Uq5eIrCuI+bag/rUf1ymrSWwKxO60sxPNgNTOm56aAs7x23VP+x?=
 =?us-ascii?Q?VBs1jaPCYhuDNEh/okAVs6imjczltjVs9KOnCICP9nhIrvPYCXpNDCZrsbmT?=
 =?us-ascii?Q?coWW4usLGXKUx9oIWYa/rC/Ojo0ogUMsT1G0ZpTFKm1OQL5i1pLDFjoLh26Q?=
 =?us-ascii?Q?x/AaOgVyEEFcjKATJkI0H4xqtVXjY5Gw3DKyfHYoBYBkH6kuILV6dRwIOu+A?=
 =?us-ascii?Q?hj7NqPpn01hF5RClKZharZmSnt+4NDj0CwE7l+1vkGAT0sWfTlK/Op+NrYq3?=
 =?us-ascii?Q?XVEWCAlUqmTFZONrfX0+KWmJB+CTIXMYLnV80CUZ37vn89JotqnUPQeD8uV9?=
 =?us-ascii?Q?rnLKnCevknpFU6t6PJDH260rSIJecB6VQrWhGktb1hdTxW5VJMB1uR+gzZ3g?=
 =?us-ascii?Q?Ym8CfQKB+YzR4bakzXb0FWHqCNF+RMe7oVDB3M4ktnxuWMguAMihjuASHX7e?=
 =?us-ascii?Q?nqd0E4lT7yqJpCk0n2owmvDsSlWtsuQJDA9J2N5/FEZRaQ+1csClmr3sL+5N?=
 =?us-ascii?Q?xIqx+M6rI58Pyzp9oy/UMq3etik7WVJIGXINyeJoDlgXJz+KB1U9vW1o7m0k?=
 =?us-ascii?Q?7gyihLxz/OO9J1kwiwErPSTe40ysGtRyi30ue/MQjDDZ1ZiDJl3cz7vtpzHz?=
 =?us-ascii?Q?/cjsv7JacFtMz6utM7BaVxu4aVt/rUJRxHui2Oy21BtjN2knMFq0kJTfrob/?=
 =?us-ascii?Q?SW+GbW8PgIEYqRfWEZDrYTvveDwt7GGH816Klvp5l/nS+zWqXcSYhXrWHmY/?=
 =?us-ascii?Q?jOgvdpdW0dwk1wGctw3MKQzALP4CcNv39OBq8SCfXdrMfjcQweycPE9k85Be?=
 =?us-ascii?Q?GaqJ/bA2jjAJKI77CmXoGJTyIN2F3BQu5+rQXZ4dciRgk/x5ys2Tc1xrcJLO?=
 =?us-ascii?Q?qNyVBTHIe1XO9GFlJIUTu4lR21ZIakQYfEWX+gdcPD/Uivs3muCKluAm4I0I?=
 =?us-ascii?Q?jlOOyO1dfimxWyCfjlDYgPD3eEgCee3/WAuFLkDs/B5/NtpvGZsZOeSuddfs?=
 =?us-ascii?Q?xHPgd9yCqLYyQqFlcYFEO5uZ8oxLXLVK4Ir98GGxEgM1uemcTnacgFrr3B4O?=
 =?us-ascii?Q?CyWvYpU9egbapI7HshpLFQyoPi9OXRgTuGYGzVJDNqZzGA3NeDwCGCNjHek/?=
 =?us-ascii?Q?3o1XX7bQP0UTwsp8W7xzG62lDFjQraAfZpT6rOVcN/DHrp1iJB/ERVYwEiP/?=
 =?us-ascii?Q?KMjb0w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb4b512-5986-4d0a-b052-08dd83eff0aa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:54:31.5518 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZ0F4t5vQu88pY3pYG1CR3apSN/S532dyuBLHOZ2z8alF+YIH6UV2aV3OIA/oJLwbvcT0O/mOcXFxcBazfxpjr8mhOp1BixoSj5oOk1UA+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10337
X-Authority-Analysis: v=2.4 cv=boxMBFai c=1 sm=1 tr=0 ts=680b77f9 cx=c_pps
 a=dbnGGe82Z6Ok/5ez5STjcQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=jyrgWQ1ITgniNTwgz5wA:9
X-Proofpoint-GUID: NDlXRpFkSLYy8fmWZxNybZwF6xBR3irD
X-Proofpoint-ORIG-GUID: NDlXRpFkSLYy8fmWZxNybZwF6xBR3irD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4NiBTYWx0ZWRfX0PYR+cbtDiwc
 /qIGgNAWYOWLyYJ2P2i7Q0knB+DulbHNbTnrwaQ+Ac6SMmJCrkXn+jJecpmRGpTl+vjmarPlADE
 nLWdz0bbPHWKPFuV7Hx2EwnWEQAG9ywp1Vg/3TW3GviFJTb/aOYC8ubjygNK7nCs8W3vanT6lAj
 e+f9x9vI6FcQ7vGh45RWti7zVCcXvyUUpcup/RO12GdZTmvS1l9Z+rnUk+KB678EDfXoPUr5+n/
 HgiQzJtSdm/X6+QtoNM5drUKwagJMhZq6JbSLZxTOVrGzGh16K26xOH1h+PDKcy2ojPKQt7uOcX
 DyXVhAnSiOePfSBjxWP+EicbusEJ+gf1iipzvfiAZ+ucn2ouiCElrDL0Ia9Qff6jSf8O6XoBlmP
 3HW7x/AWJhSaypSrqRKdNxNIujlG1yR9vQhfqejOqNj2qizix3CZNsdY/WwHvZHPVuAaVAhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.314,
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

By definition an isapc machine must always use ISA IDE drives so ensure that they
are always enabled. At the same time also remove the surrounding CONFIG_IDE_ISA
define since it will be enabled via the ISAPC Kconfig.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/i386/pc_piix.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 28e5158f5b..ac9605c45d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -422,6 +422,8 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
+    DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i;
 
     /*
      * There is no RAM split for the isapc machine
@@ -484,27 +486,20 @@ static void pc_init_isa(MachineState *machine)
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
-#ifdef CONFIG_IDE_ISA
-    if (!pcmc->pci_enabled) {
-        DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
-        int i;
-
-        ide_drive_get(hd, ARRAY_SIZE(hd));
-        for (i = 0; i < MAX_IDE_BUS; i++) {
-            ISADevice *dev;
-            char busname[] = "ide.0";
-            dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
-                               ide_irq[i],
-                               hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
-            /*
-             * The ide bus name is ide.0 for the first bus and ide.1 for the
-             * second one.
-             */
-            busname[4] = '0' + i;
-            pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
-        }
+    ide_drive_get(hd, ARRAY_SIZE(hd));
+    for (i = 0; i < MAX_IDE_BUS; i++) {
+        ISADevice *dev;
+        char busname[] = "ide.0";
+        dev = isa_ide_init(isa_bus, ide_iobase[i], ide_iobase2[i],
+                            ide_irq[i],
+                            hd[MAX_IDE_DEVS * i], hd[MAX_IDE_DEVS * i + 1]);
+        /*
+         * The ide bus name is ide.0 for the first bus and ide.1 for the
+         * second one.
+         */
+        busname[4] = '0' + i;
+        pcms->idebus[i] = qdev_get_child_bus(DEVICE(dev), busname);
     }
-#endif
 }
 #endif
 
-- 
2.43.0


