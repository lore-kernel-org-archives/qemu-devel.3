Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA4ACD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNu93-0003ds-9E; Fri, 15 May 2026 11:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7o-00038A-Ro
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:53 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wNu7n-0006ZX-0W
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:06:52 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64F9m0X2106655; Fri, 15 May 2026 08:06:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=S5J6pS8D9GJ29ObVVLcfSU8t+TKinT01oSmbRqRzV
 pc=; b=ZMK+b4TKtUEuOyWhUA0xtaOytiqkiZH1DvJg1Hlhm+vUXyIBVKGtEtEX8
 sAYA6/Y2QAiHHMedFS88J1X0sHQiXdH+YN1Dte0e1bxEIzOVPfuqphmr6I59nC1d
 dB0gR3O3CSKlALYuMPZ/nPpcoqHyTlp9wOir06MSWlfw1ZLyeZDetyYZyPX1XX3m
 qB4lAYJKp51f8QeMXWXK5Df/lQBFbJJZKkeD1o56905jaelURhjn4usTCRqtgrbz
 jQibamSbOJphSaItUtTPMubEJpQNHq+ExzmXfSPa1cs0qiSZlKUZ8tOtWw5zPI2g
 Yll8gw12LYlkgWOc/TWZW0nESn+cw==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021109.outbound.protection.outlook.com
 [40.93.194.109])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4e5m222asp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 15 May 2026 08:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZblYB4AJ1XcOS8LVy/oH1b/OWthZmUdI+8O+XJUM79miuSQFUvKmK6u2puviCH9k9p4rIvjg4ll2l9XgudjuQel22xtTAjG5mRvoLEW5860gHYiNC+dUxnVOR3WBPa+QgzZUzuclYOd65kSxsetd7QRsLKrC/NEiIBM1o/VyumSp/yuKbE5sHR6NfYD9yJcj8ZnSMojIxP5qqdf3/3Up/PSaOXinqGD7QsMCZbYzT27+fCR4L38zfqwQuXa6tZJ/gJb4anidLhaz69DqvMBc6RPd8QhxH+cTI695wrEry5SVWO52ZZobqCOeAWvtrleOeq9Eoarebi78Ba+jeCu2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5J6pS8D9GJ29ObVVLcfSU8t+TKinT01oSmbRqRzVpc=;
 b=STzZBX18OpLxVtUbaCg+EByyv5CkJtDWLvhIK8D9BLI1hitFo8QGfGtQQdV5oQlWEQ8zduS1hN2NVJ8h/YWUQeFQw2L3WWpZvuh6xVYImK09zdxYJOlUOsOHWpfbFKC/6DuLN7LxDws6gEqkZq13aJQphyfciSy1891d2UXifzRvckM7JKfmBw2nnKN2NYEmvZ90vHt4YqxIhaQnFQS/xdGq10026jzxe+XPMHvPORAmx44VSqZgGc2JbYV1I8rPGasS7MhginfBfPTy1Uxn5H8oCs1Orx4l2xYV2C8PIpkIbuVuJuu9lQlOGwy8xuPrrMxYk8sz/oL49JKjCa6xew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5J6pS8D9GJ29ObVVLcfSU8t+TKinT01oSmbRqRzVpc=;
 b=TKbQ4ZFj953Pmn99jRe83KgW37oIIJqnC0aKYI9FpBEbrFlbhmDMxAheJCpIf7c0NgF/K7FvdRoh8dwhg8jgAIv9Q4wvM0mmq2Iuqrvaotm8OSWda78oftO4e/fCERU0te/0hwt35b1X9Sw1xv/v1F0zKjVhyqIjOO+C+/KrgFVTjllwEiIh9DJUINibBL1jcRRY434Vcq+/fcKevALihX313vMeiC+20G56zHxXw248NPvCwiqPv5lgm4QmMF16S12kYNnrwrwBtQa4U8rUYnDHH4nRc5yM9jsfJ0YyoCaYzsAP8dWckgHCpouHpk20/CCRRnNd1D6t0PHiF4Mddw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6517.namprd02.prod.outlook.com (2603:10b6:a03:1dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Fri, 15 May
 2026 15:06:47 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.21.0025.016; Fri, 15 May 2026
 15:06:46 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v4 2/4] tests/acpi: allow DSDT acpi table changes
Date: Fri, 15 May 2026 16:05:45 +0100
Message-ID: <20260515150634.2637533-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
References: <20260515150634.2637533-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0258.namprd15.prod.outlook.com
 (2603:10b6:930:66::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6517:EE_
X-MS-Office365-Filtering-Correlation-Id: 8480a0ae-f988-433a-2750-08deb29394c6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: QczWeNHLwNlQitjxExhoPiT/u/QxxgPf2hGQqcBpWsBRQ4/EKLOeMouUiLPzcZy0UWdx0pp9OopCc1lEn/3A6ABlVXi+fA8+tNVPHSqWUcqmi6C4HKuXcXm9w1SqwvpH40St3O5Uhn0sAM7IODoiRJtI3/N67cXdaqEeX7PyqTKW93C2rdl75WrDDbaJYdU22m/p6sGY5eKyV70cUsfGlT7IpC2s/u0oNKqxElw6sipW1B6hwQiXSreE3AazIB4/+BH/YqyDOtamlkQuJy+VnX0f70So8539MzeLnbmGnP3ko3uDpef4ckZDwjN93CW+qL9SKcDGgjEopVJteX7w5BLQaCZ9luba1wMk8llD7oudI6Jnaa4nKmeqvIwBCjJtSDiAlxufI/lsg6sphEO9VuV579okkOIFQX+3XZg0MzNhCnjGA4Dyh3pEFr1/Jb34TIBdBIzJfsPlR83iSkNn4A1H9UpPIQNLccNvaXfyRdLdItks58i1qqb4DE1YBILcWMXzRE6X0a9EOY7eKRolDLj2y0+h4Rhrdsvc3cxOZXU23HNLZ+cvqHuRRuFxE1pecrUmSOQKUcHLEbTLndTjjoTi5+LLQ+zg2ysm51WqNpB6f2wxpVK4xzAJEi9Mss5OLTO0+4ilRNmlZrb4j+Ugiruh9Skdr8fcdJBIngrS1bHsrKeKEqvOduPo6GynIewC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLlgWgAL4/aNRDxa0tWB0IwPJJvEVuZ4mjbd9lnzmt1zqlDDkwfsItAbxIZr?=
 =?us-ascii?Q?qhrlpZpMfh1G4e8QszRb+iZbWgcqau86yX11hoIJANHERckXmlyFHDesjYxT?=
 =?us-ascii?Q?aDSXB96TdClweCTgau5KqaJYd4vYtaXQVPmFxzp9prHPB3dI/2AqOcuzD2nv?=
 =?us-ascii?Q?Yq34sJC8rOLCojAkuTLZDGgW9WcEIht6HSdoGuuX8vU7/fR7i9FbgF/CJJgh?=
 =?us-ascii?Q?Rz0ENDgagie+/Md8bW8zmgsqUHxG4707/YmFLXsOIYw6Dglrfjs7z963H+sh?=
 =?us-ascii?Q?TQmXKWNmGIWKvHooaxz1NVu/HcmDR99N+CXScJu1zNUHtcVNogjvueECY7Gw?=
 =?us-ascii?Q?GsSdMl/tXtpIj+6sMOkbEDEGLzpcLtVdaL/QGrx+VExRsCX3XaH6+XB1LJ36?=
 =?us-ascii?Q?sL+r08qSgKl37pGeQl9NyiDcDK/qkxy5S2iWAwpyF4TMOZYjwmcsij0ey7Y2?=
 =?us-ascii?Q?xNi0uKz9WJbKWedRDR+4dsG6DtsCXTPeW3TSxZoW3mwl57HKHyUgxSciNCog?=
 =?us-ascii?Q?SMmxiYURzmJypRNkN8Sk1JpFOOFRObK7LPGkiOAdXwx7Gi0tBIaIYbiUqo79?=
 =?us-ascii?Q?pSJZUa9CKBRqE4eOPIG1pPVpvNjnjUaYHdFtRTd7mcx8MvYMf/vupoSWdFTz?=
 =?us-ascii?Q?Q3Hpmmz4FnLedb75Q2qXFuBBnSJ9PE38tUqtfOxq7TUAIRSWrtbDI/7MUyUd?=
 =?us-ascii?Q?ES/cQJUaPgiJrngxzmXCsVFBlYiYdAD+76oioITUfLduHR3D6C4wr1IbkiHk?=
 =?us-ascii?Q?sCI3ZGptUNs5cZXGF5RYNqplD1R0RKbctqRmrlZygaVYPx46ddEe/OrfReQk?=
 =?us-ascii?Q?gtuI6YhneJdd9h4+8gCVF7QEqg3mnABRCtuUkRu2Tok+wGToEy9em8B7m2e7?=
 =?us-ascii?Q?X8e/IoUuh7ngWSNFoL2/8+A5r70gZ5eaN5DTVu3G8i2p1ldJzi3RJpfC4oy5?=
 =?us-ascii?Q?iJDPUaBiuO6OZII42OWLhExLlvhgTdkbvX9NyHXst19HMKltuz47cx36eHKE?=
 =?us-ascii?Q?/vMdgqvmXkdI/I+kX3lC62o6qqNsGAkHOYJXb4RfY/TqXtDCoVxzGnWvcsQR?=
 =?us-ascii?Q?fY2vD5DhjhKbSDEDd4GUgCe3y2JeTcqm85JaQISXv5xDjCh1+8z23ziiXKD9?=
 =?us-ascii?Q?AXFDczqQBrMSQY+M6Ol0FvzyACuJyDGenQrwjEa/8N3n/l/YaGuxBtgHVLZl?=
 =?us-ascii?Q?avYdpcD9WB9ohmLLd9OzhPMeHkP6qUf5lgeunby+HNl45k+CgDD+0jMYUNre?=
 =?us-ascii?Q?7Cd2fVI3UBVKBXIUOJfr4ksNcZhEDNhUzrD491Z+1Us/X9aQH+dsL4Vslm7r?=
 =?us-ascii?Q?bXaw29pH7uw6/FU6rnD5eRVhcdhpjQqyqEAWV8d/L69ZGCyr7pYjZ1V7wAi2?=
 =?us-ascii?Q?YBXXLthMJNSjwrQej83jDLPQzNv/4CEnPF7TWCdTBPPs6PDSC3gUVP8U592K?=
 =?us-ascii?Q?S5pHu/v7wXEBtD8Y+csi7bay6Cn6rTjpe9wxQhJuCjzQvB9R75XNnKP5fz8S?=
 =?us-ascii?Q?ymcKpv6QbuVowrXsjvlxhHf9ZiGCiBwPpMtAzcfej8tnwdFCsrW0Z9FBaX/J?=
 =?us-ascii?Q?weWh+paCNvWVBrspo3MozMaeLyWkXh1Gns9QSbdWRrTZT5Rd+RwzYcuj5w/c?=
 =?us-ascii?Q?5Etyo2I0h4MWkXzXn2aPTXTLr3hAH4nxYHfsz4VaaCCiMBMrQy0Ef1W8LZHx?=
 =?us-ascii?Q?z9VEMGbKr0hoeTwnRkVFmMENFPjFQqyEyRd+HJZYwngvAOWubF6s2yKWJ9id?=
 =?us-ascii?Q?cWODliobgpw3liafCb0KJbp3HiDcnNs=3D?=
X-Exchange-RoutingPolicyChecked: yBj6cpj1ochJUUfrh9qtND9ucPlz92J/hrtm4A5KfwnWoJQsN8azIfaSUxSr1R4/dZl56yxCFm0N941BNbLwwZ3f2t3mmDAr/vcBPlHsCSgSmiWcet0ldo21BmxOF/om3dsVQjE1MBwS7ke8Q2hCk5ETrvLr2l+1LrhvgVdQIz8pGGSe4HTj/1aN9/Rm832YQExuh3u/oKT23JtM/gEvV+JU4zZgVf8Sg6gCC1hzHHsMjU9xsTOUoxK5AYblcFUQis3L+cAwwzAezCFtFq0iReiAI2EtQEhonW68tPSpq9/0+LyZgAX+fJy6XDxSmnBlLuwS92IeAK4+H0ShgJ/lnQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8480a0ae-f988-433a-2750-08deb29394c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 15:06:46.2471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuzW+wYj0qcqnGhMgtOokz+KTZPxogg5t/wCeU3EaliP/NLQK57CzrGDg/vLlyUvL6ojYJX5rewcSyWgEVOPdp1tuPphY5kTp782rxGVtng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6517
X-Proofpoint-GUID: 3tNuX1LdXrms1eyK6ANbkV6-xUzEqaGT
X-Proofpoint-ORIG-GUID: 3tNuX1LdXrms1eyK6ANbkV6-xUzEqaGT
X-Authority-Analysis: v=2.4 cv=LpCiDHdc c=1 sm=1 tr=0 ts=6a073689 cx=c_pps
 a=mU+v3NmKB8T18PSzrq+lTA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=tFLHknQyRQ44bDLlSQ4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1NCBTYWx0ZWRfX8zupwAovMdz6
 rlCBnYCM+OuCwW+obdgU7M14yPe/1ykRKb6wYWA0KseMnh31ZTPbM2yAcMtOXSbuhkctmlVjXgl
 O7nAGuY38kpwMzdNX5RgevW+PtsMHSgCgmz+V1/u+kSWxsMaQC/85CUYB+90lWmoD6j2nHQXAVn
 7R9jZJ44GR/E3w4hrd8QtxGluNSovYq065/yNE8hxYq+nCmXtK4QF7IczUJJmYB9zPHs8HmKbh3
 6n/c7fmZHxGBtjcPYvYp+8JOv1T5cCCl/nhnxb7DpgMIWPdoxpyZCYE39JYdxH834pN4mlYIFtO
 MtehGFtRKFZOJJF1ay1GVo49oWzxBqadV9O6D6HN4F9rdBhFm2u7O7km0/X81hSPx3FlMCC+ret
 4q2XUKurHUW/F233xS995pMHu2SONcTrV5rL59YAVKFgppTbT7ePNDpZjxEn90JbYGDKCijCygl
 pKddMI80AROKIRo4x1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Acked-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..cef44135bc 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,48 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/q35/DSDT",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
+"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
+"tests/data/acpi/x86/q35/DSDT.bridge",
+"tests/data/acpi/x86/q35/DSDT.noacpihp",
+"tests/data/acpi/x86/q35/DSDT.multi-bridge",
+"tests/data/acpi/x86/q35/DSDT.ipmibt",
+"tests/data/acpi/x86/q35/DSDT.cphp",
+"tests/data/acpi/x86/q35/DSDT.numamem",
+"tests/data/acpi/x86/q35/DSDT.nohpet",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
+"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
+"tests/data/acpi/x86/q35/DSDT.memhp",
+"tests/data/acpi/x86/q35/DSDT.dimmpxm",
+"tests/data/acpi/x86/q35/DSDT.acpihmat",
+"tests/data/acpi/x86/q35/DSDT.mmio64",
+"tests/data/acpi/x86/q35/DSDT.acpierst",
+"tests/data/acpi/x86/q35/DSDT.applesmc",
+"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
+"tests/data/acpi/x86/q35/DSDT.ivrs",
+"tests/data/acpi/x86/q35/DSDT.type4-count",
+"tests/data/acpi/x86/q35/DSDT.core-count",
+"tests/data/acpi/x86/q35/DSDT.core-count2",
+"tests/data/acpi/x86/q35/DSDT.thread-count",
+"tests/data/acpi/x86/q35/DSDT.thread-count2",
+"tests/data/acpi/x86/q35/DSDT.viot",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.ipmismbus",
+"tests/data/acpi/x86/q35/DSDT.xapic",
+"tests/data/acpi/x86/microvm/DSDT",
+"tests/data/acpi/x86/microvm/DSDT.usb",
+"tests/data/acpi/x86/microvm/DSDT.rtc",
+"tests/data/acpi/x86/microvm/DSDT.ioapic2",
+"tests/data/acpi/x86/microvm/DSDT.pcie",
-- 
2.43.0


