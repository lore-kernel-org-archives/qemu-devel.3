Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87EACCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIm8C-0000WO-Ar; Mon, 19 Oct 2026 08:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm81-0000Ee-Fc
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:11 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1xIm7z-00045c-CV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 08:06:09 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JBoEoZ3623171; Mon, 19 Oct 2026 05:06:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7wm8uo+H49sktKaMqKuuL2u6+/dMUEYN+P4+MkpQf
 Kk=; b=jag9bJ0vU967Z9vc7RHWSS9EX65WcbR30ynXsPmbN7VcNT9cho0tyxXP2
 h+5LS0caQyadGp6jQE1EHdYjKKGhzNi2Zlluj9g0Z28tTiuLPg7WQqFK5X2jsfU5
 r6HJgPs+tejtfL9ptXYxL6q+QeipMrDlPvLQaaCNw4+C2hAJxnOUhZbTQmV6lLFE
 oE8noZwzla0o4bwP7CqGhvnAcHv41pLCoBCQnjvxxTduU30BiQWO/IOmEMHxA+Or
 RgNMakK0ZoMM/yQ1cY/OuCwvEnoLzcce/Pphueocq8xE5yMO8lyEhXbGNRxYUE/U
 I/nKfQlN8Cp3Lr99QzdaQbAJ3kbyA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021099.outbound.protection.outlook.com
 [40.93.194.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hdjnwr1ex-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tpq81l+UKZToBu4f44cRRPJVI/WVqhYzHU8uAEuhyiwfeu5SS0kUBMSDZeBYbRmttINnfQ7xqgUxuvQDRR/f3GIrWvWn7DvK5jd6zjTRFsqxVglQjnQWUmN/kANq2RiuvDtpttPpkTL54h2/6upXTd9x7l1moS5Qy1zay4Cx53/PG+WNUtZ+g6nA03VuhBPH6MVsxDN77aCDh3iQZJDH8Tb/ZJTWtgK4QrKYCuljkEuYPGuZxdqz5g97ap2aNQ7Qt7DlELLSRWq1luXYNVs1mQU6FRuVuTsO5sQY6HlOkQpEyV8qXvFHbBeQ1yejX8RsKinBZsysktWuZLl1HMBzyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wm8uo+H49sktKaMqKuuL2u6+/dMUEYN+P4+MkpQfKk=;
 b=Q9pKBu8v7Q9trJyRMp5WOCRbxhTra4ZT4cXPp6aoNlAwT5vPQeHivTZYxIf2uXi4GcQqj64lFW0ZMt1iBXLeT0JYt2aKmOzLTtau0mis37tjZILoii64uuZLDjhX4cGxFWPq0txDZbP1fzEkyQ5kRpIm3Z0hdW2/crZFYRASfrCLRvmSRQwDLnoi6D0wU/n0ZSlzAZR71ceI5Aey60QPam0eLGjbAprbdV4PO0fWt4qvJOC8qqrOrTvTa96XmletLSf1yGQs15LxnENkxCjIGTE1MmR0si+tL3TGaAPG33lXBi2C+24kCSE/NEE5x/scUKoclnjrSGSU9tThbd3Uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wm8uo+H49sktKaMqKuuL2u6+/dMUEYN+P4+MkpQfKk=;
 b=TNOpvi8D1SV3ye6EI1xu2RYriJLEjzRCPSzcrgWLIWDn+8wAQ8cxOb3oVuieUhM92SyTHESbvkYDW9rsziiTyefa6po6yucbkVOEW5GDa3rzLUUmVsenBMmVn/MBOhztYeJagWVXc1xSV+rxp0lNLapt7DbXG9a7euN5kvZ9S2iRCld2W0Vo8KEKCdyi3l+R5DvbqJbmp9j5OI7Q8vJRkiFssag6nuakMIU+hl1RRg0g7MdAkKvFQBDaBc0QZQHMcnRGd8qHzUyQe9FhkRIZqN6NOkGCX0TRqVUQgK+4TA3ksypfIzkMvYbMBwbpj5xKObDffjsIuR7ZSJjNIE+SKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSWPR02MB11441.namprd02.prod.outlook.com (2603:10b6:8:354::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 12:05:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:05:59 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH v3 12/28] i8259_common.c: use i8259/i8259_common prefix for
 functions
Date: Mon, 19 Oct 2026 13:04:44 +0100
Message-ID: <20261019120517.1448687-13-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
References: <20261019120517.1448687-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSWPR02MB11441:EE_
X-MS-Office365-Filtering-Correlation-Id: 8364fc10-c0d4-4f6e-9baf-08df2dd95695
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: VXTayo2LC2Dh6JFikHKiqMNPTZ7ULVpMHQk+fR2TG7yNwHNQGBifb+mXCVBAASkw2kPwZDGL3vmdCT79xRjUwaeFuFoWkDZrc/AdhKSXvCHpAuY+VS2NJLh5zvOOZTSC1nzWTManDyVQKCSZPPeFcjGiuYjpnOvf9OGfoj1Cf23ptnXqldNJ8jaEQS3NzRliOoNJLH9PQIZEZxGvGMDLyWefie+jNStwPsayO1rrvF0EZPThQFUeoNKUjtBkDJDsF0tT3xLYuBVh0Gi5AJDF6y/d9L/h3aPADN3JCmXRbLsj0MjRZ9L7WrZMNV2iwajpRwqHFKcWn2hR2lb6TIE9WHrDtJYh9p48tRB6LyPDHx8Tkh5r2n/MFP1U2bClr8IcZDN61SkjhQptIXmphMvBicCgjoZ7nQf773kbaEdiaPGwaAHGR7+P7wdt8m44LtUhfN9khZLfhwCbxdbaOn2+Mjr1BLQxAImtvUQ8S4d72QdDk9bpuJ+e+qpzWZD9O7/H+a/sMXf783WdHciQSC7pCMJtgdSZ6k0V/Gu59O+J1IAQyc4SSXIRZWNt4Edsp5ORTZl1IaTP53EhZDVd0MeQdmKTCPmf5NyDWFHvBEbk3ujTYJGN09dDyD5j4q/xjet4DQC4th3t8inLMIGi2NqBhCYepyHM54fDsHRt/i3JSt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TFLh+bpJ68XynYMNos+Q8IT8s8TwdJiGomNvfYp+kVSOJcYGE3EIm2B+XfTJ?=
 =?us-ascii?Q?gskyzXv4ZAv3Vmw7WlTkpx6QAlIrUwiXeNkkWyQmPbEvb1m7Cln6lNefvbAk?=
 =?us-ascii?Q?DOiFfgu8mou2M9KOvXEk6ztk9bpfJDfdQ90e4fCT9lUX5VCP8TIKvotn0ILT?=
 =?us-ascii?Q?RMXuy69TRgZ+T9QXvZ+4EDQrobUJs66ypBI/lmy62jDgEf2jBepysqlZZOss?=
 =?us-ascii?Q?1lSk7GDFmK8EhCNuco+OS1M7uHXloHXikPK2x8Qc1afmx8mnk6kaex+QwuCU?=
 =?us-ascii?Q?JPEFwGgbaT/ZAXcJVFktM2Rt+Da0mgSUxpuGLB3lj2I0m7XAGeHePWRYUCiN?=
 =?us-ascii?Q?71zPbbP6EyyyFflqnC7VVN2Spngibx7gX7QULFxTkXLV7xIcGYWr2X3ejWL3?=
 =?us-ascii?Q?6WVCuUZCd6h92ByJPN0TIE3siRYRWtN/p1sp/+oX3Dn/c6sX4O+QWEZmN/p+?=
 =?us-ascii?Q?KVeyukW7Ic1VjZICsJqkr/jSQNm4IIMtM0N32CA72rkKrq1dFdaz57LViV8g?=
 =?us-ascii?Q?nhdQqh4h14asa6+4UPQP7OViEiSQz1G4YhcRYaeqcok+XCGr0Xs4AKIkHh7g?=
 =?us-ascii?Q?Q7pFxjBtRsH4EJCzKuuZkDsU1FWAQqU/zjykpakoIOQSDTpvH2iqXFJL4HAK?=
 =?us-ascii?Q?N8UzTSQKWsNqCtpJoPMful142LuC2U7q7IGd+G3MpG7nXAzENWSLikUbAMHR?=
 =?us-ascii?Q?847IkWHXKMr4VfZMAnSOA/QryCVjwdyqma8GLzWukW/LZtO150CpspOTpzUR?=
 =?us-ascii?Q?gxoNbgZoyPWs694ui2Y6/Memzajh9o/9OCkpDnpEqNVgcwjfa59GK3ZuUeA7?=
 =?us-ascii?Q?yWm5V5HQ0J+AMIaMaBi46AL4HrMpCmtCTwN7zANbGycrfMJn3qI5rXlYqLSN?=
 =?us-ascii?Q?2UaMeyLFOIkrYZ4tq/30cB5GcwGCQ1qkkRawhWHvUl/3bBxOZhgAfj7/xfuU?=
 =?us-ascii?Q?mJf9VQ9unUYa5ViZIt3pAY0czLAoKCi3OBpb9TP/zCkCdY/Z/pVASuCBc+Q3?=
 =?us-ascii?Q?Z8KqcdtR9wGnkORd3SjfDWDknshd69YeaE7TUobeq4rXNBJeUk7FUjs0n5A8?=
 =?us-ascii?Q?Si9QH2XzXAY7/Qooz1FtDPM0cq7+49XBaz3w7Xk0oaQ0KiZY2unXSufIgX0d?=
 =?us-ascii?Q?C//IN4ddPElIP1PdVjUC9MSAkNFTda8Zp7xwPRGnrS1Xe9aaVj3WkCjL9flx?=
 =?us-ascii?Q?RP+CU/Ks/kkepmSLnMT95bNUV/IOBOs4wSCnLw8A9fx4m5icB7yw1TZfU5GI?=
 =?us-ascii?Q?TYyWBUJ0Dsdinh9nBXYgpvl6oNZFK4DHnj/zNY4TOBQN7VJZYxsgaNoa/eB3?=
 =?us-ascii?Q?n/IAaHAjgvr94lEeSmdeBAVFNLVaBCiWJE3eMWFPNawF+kEXQMgH55fZq8ug?=
 =?us-ascii?Q?yt/ya6Uq57wChokwPACFSVimkrteXUnlMvLFp2PQEWfVYiUdvp1ECImfxSkk?=
 =?us-ascii?Q?baHiqC7GTIG4315c9+iKuCZ15eD45kKrtjaUumul1Od8nyzWR7D4UMLVmwYs?=
 =?us-ascii?Q?7y+KwcAoYABWnscfj5YlQew6kyckvEDGMc5kpch2bhe7lkZKk39NQQ5dHN/P?=
 =?us-ascii?Q?GK93Q6kb8cQBeAk0opGpB7wbTDQBwhPYdwOvu0cT4t0K5v5AdMavzY7uXTK9?=
 =?us-ascii?Q?n2bIphjxISb398ztfZ+e3tk2jdFVBP0PYMwoxiTModDMjGWNdltBXJ8XRR5y?=
 =?us-ascii?Q?1hQWJzN3l76/YuyljXpdQj4N5jACLp/Drpg6K0XS9k4jii8zMyDLD4zncHzc?=
 =?us-ascii?Q?0QT+U/5a2nJyUKIJiQlC0UMkgmbHCQs=3D?=
X-Exchange-RoutingPolicyChecked: pmBmlwJz7SrGAje8jvQaqxJ1CDaDt13NTxvguBDRQb6BrIwi0Qv0AYcUNocZ57D946zMG+P9dET+oUdmUzJ1xSxRZV/DMZxirTsARuuHgWLxMZDemYaF/u6y+TgEsffbe0lcCptbgDOMKLlOr2Mhjkap+SVwUJ/Um6TbccNPKvXebskY7BMnnUZlfSLivbO1nw6dPSKd7PQ5Nnn3rIsW+7qfmiLWq4Dn8SCnIKbpfTFv4SvPbs6f9e7meE5o/lti/ZVNhuUSFLEEZ30o1YBe7LChU95pe0qAizGCZwc2XcEPIdFkEP0+I5H1eANwbnZWXyS4Es18TXvr1744HCFdXA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8364fc10-c0d4-4f6e-9baf-08df2dd95695
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:05:59.5660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DFrkgKKzBbeH4ZoazcPvgjNPCGFIiUQycYXiiNiHqQlq+mrstBZbZHkNgXToCJml6QpYVL0Muy5PDD1sbUSYuVX0r/XtliZ3Xx2Y81VfVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR02MB11441
X-Authority-Analysis: v=2.4 cv=fqdJ914f c=1 sm=1 tr=0 ts=6ad607a8 cx=c_pps
 a=MAB4nyKqAzWELJb2TLvteg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=ox8dIxdxdu1w5TD4ToMA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: k3VY4p6MI4HvCUrdq4duavTPYNCJ6BiG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX+cb6+0sZxMf4
 ezWPWS6aPxGd/v+RIrCYxk8M+G9cGBk6x2DIhTfnI/qbgdwPw0Gl1UxPoypKCf+p903CFFtG69B
 DP7UEFAsS4jxT+4pK6rZDKC3P59uuKs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX8C4slN5M8l4X
 VSmO+08i6KnxaMksd68KZETrnqKPB2cKu5G1Uc3PvFqq7zivRCBb6xPSxpQQmFK1hr9NNr6sMnt
 h5vpvioOiXriOH0LeIwLx8HoRhAjQq30aCOCJ2ksgQG1FZ4p5uEa24yVnEzvylDfZ4zLHwUD7A0
 p8QT/d0Paq3lqQdrPey9Axr6037BmLFRLu7TaFo6ILgaSdnj09U94HwYD9tFLqiYTydVM04L1M0
 ynNMdumVht4lK7bL65f6Z1HnemqBqpaj37TIJtAAimPiQpgC7YHLfGSWfcMhnOdiktTlJ8d5+PD
 1jJc4Cmm+O6CbxC/JkxgAxl5GZgmNv4aaY9y+cV1cjmM8+LC8sGPIXQcuG5J5oNvJHMcv5sqVL+
 1jS8wijsff1MOLJtbwERayjTQ5TX+CZf4PwP7DpVHFR4JUlEABqGaW9P0nEhberR4A6GXitgNOO
 lvb52lrJwQ+ahiiWhyw==
X-Proofpoint-GUID: k3VY4p6MI4HvCUrdq4duavTPYNCJ6BiG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

This ensures consistency with our normal QOM-based naming convention.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/isa/i8259_internal.h |  4 +--
 hw/i386/kvm/i8259.c             |  4 +--
 hw/intc/i8259.c                 |  4 +--
 hw/intc/i8259_common.c          | 49 +++++++++++++++++----------------
 4 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/include/hw/isa/i8259_internal.h b/include/hw/isa/i8259_internal.h
index 71fdd74266..644508a44e 100644
--- a/include/hw/isa/i8259_internal.h
+++ b/include/hw/isa/i8259_internal.h
@@ -70,8 +70,8 @@ struct I8259CommonState {
     MemoryRegion elcr_io;
 };
 
-void pic_reset_common(I8259CommonState *cs);
+void i8259_common_reset(I8259CommonState *cs);
 ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master);
-void pic_stat_update_irq(int irq, int level);
+void i8259_stat_update_irq(int irq, int level);
 
 #endif /* QEMU_I8259_INTERNAL_H */
diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 86b1ffea4e..3a960e48e6 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -108,7 +108,7 @@ static void kvm_pic_reset(DeviceState *dev)
     I8259CommonState *cs = I8259_COMMON(dev);
 
     cs->elcr = 0;
-    pic_reset_common(cs);
+    i8259_common_reset(cs);
 
     kvm_pic_put(cs);
 }
@@ -117,7 +117,7 @@ static void kvm_pic_set_irq(void *opaque, int irq, int level)
 {
     int delivered;
 
-    pic_stat_update_irq(irq, level);
+    i8259_stat_update_irq(irq, level);
     delivered = kvm_set_irq(kvm_state, irq, level);
     kvm_report_irq_delivered(delivered);
 }
diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 700412df74..97ecb77407 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -124,7 +124,7 @@ static void pic_set_irq(void *opaque, int irq, int level)
     int irq_index = cs->master ? irq : irq + 8;
 
     trace_pic_set_irq(cs->master, irq, level);
-    pic_stat_update_irq(irq_index, level);
+    i8259_stat_update_irq(irq_index, level);
 
 #ifdef DEBUG_IRQ_LATENCY
     if (level) {
@@ -215,7 +215,7 @@ int pic_read_irq(I8259State *s)
 
 static void pic_init_reset(I8259CommonState *cs)
 {
-    pic_reset_common(cs);
+    i8259_common_reset(cs);
     pic_update_irq(cs);
 }
 
diff --git a/hw/intc/i8259_common.c b/hw/intc/i8259_common.c
index 705a28ecbf..31bd663439 100644
--- a/hw/intc/i8259_common.c
+++ b/hw/intc/i8259_common.c
@@ -33,7 +33,7 @@
 static int irq_level[16];
 static uint64_t irq_count[16];
 
-void pic_reset_common(I8259CommonState *cs)
+void i8259_common_reset(I8259CommonState *cs)
 {
     cs->last_irr = 0;
     cs->irr &= cs->elcr;
@@ -53,7 +53,7 @@ void pic_reset_common(I8259CommonState *cs)
     /* Note: ELCR and LTIM are not reset */
 }
 
-static int pic_dispatch_pre_save(void *opaque)
+static int i8259_common_dispatch_pre_save(void *opaque)
 {
     I8259CommonState *cs = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
@@ -65,7 +65,7 @@ static int pic_dispatch_pre_save(void *opaque)
     return 0;
 }
 
-static int pic_dispatch_post_load(void *opaque, int version_id)
+static int i8259_common_dispatch_post_load(void *opaque, int version_id)
 {
     I8259CommonState *cs = opaque;
     I8259CommonClass *info = I8259_COMMON_GET_CLASS(cs);
@@ -76,7 +76,7 @@ static int pic_dispatch_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static void pic_common_realize(DeviceState *dev, Error **errp)
+static void i8259_common_realize(DeviceState *dev, Error **errp)
 {
     I8259CommonState *cs = I8259_COMMON(dev);
     ISADevice *isa = ISA_DEVICE(dev);
@@ -105,7 +105,7 @@ ISADevice *i8259_init_chip(const char *name, ISABus *bus, bool master)
     return isadev;
 }
 
-void pic_stat_update_irq(int irq, int level)
+void i8259_stat_update_irq(int irq, int level)
 {
     if (level != irq_level[irq]) {
         irq_level[irq] = level;
@@ -115,8 +115,9 @@ void pic_stat_update_irq(int irq, int level)
     }
 }
 
-static bool pic_get_statistics(InterruptStatsProvider *obj,
-                               uint64_t **irq_counts, unsigned int *nb_irqs)
+static bool i8259_common_get_statistics(InterruptStatsProvider *obj,
+                                        uint64_t **irq_counts,
+                                        unsigned int *nb_irqs)
 {
     I8259CommonState *cs = I8259_COMMON(obj);
 
@@ -131,11 +132,11 @@ static bool pic_get_statistics(InterruptStatsProvider *obj,
     return true;
 }
 
-static void pic_print_info(InterruptStatsProvider *obj, GString *buf)
+static void i8259_common_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     I8259CommonState *cs = I8259_COMMON(obj);
 
-    pic_dispatch_pre_save(cs);
+    i8259_common_dispatch_pre_save(cs);
     g_string_append_printf(buf, "pic%d: irr=%02x imr=%02x isr=%02x hprio=%d "
                            "irq_base=%02x rr_sel=%d elcr=%02x fnm=%d\n",
                            cs->master ? 0 : 1, cs->irr, cs->imr, cs->isr,
@@ -162,12 +163,12 @@ static const VMStateDescription vmstate_pic_ltim = {
     }
 };
 
-static const VMStateDescription vmstate_pic_common = {
+static const VMStateDescription vmstate_i8259_common = {
     .name = "i8259",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_save = pic_dispatch_pre_save,
-    .post_load = pic_dispatch_post_load,
+    .pre_save = i8259_common_dispatch_pre_save,
+    .post_load = i8259_common_dispatch_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT8(last_irr, I8259CommonState),
         VMSTATE_UINT8(irr, I8259CommonState),
@@ -193,21 +194,21 @@ static const VMStateDescription vmstate_pic_common = {
     }
 };
 
-static const Property pic_properties_common[] = {
+static const Property i8259_common_properties[] = {
     DEFINE_PROP_UINT32("iobase", I8259CommonState, iobase,  -1),
     DEFINE_PROP_UINT32("elcr_addr", I8259CommonState, elcr_addr,  -1),
     DEFINE_PROP_UINT8("elcr_mask", I8259CommonState, elcr_mask,  -1),
     DEFINE_PROP_BIT("master", I8259CommonState, master,  0, false),
 };
 
-static void pic_common_class_init(ObjectClass *klass, const void *data)
+static void i8259_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     InterruptStatsProviderClass *ic = INTERRUPT_STATS_PROVIDER_CLASS(klass);
 
-    dc->vmsd = &vmstate_pic_common;
-    device_class_set_props(dc, pic_properties_common);
-    dc->realize = pic_common_realize;
+    dc->vmsd = &vmstate_i8259_common;
+    device_class_set_props(dc, i8259_common_properties);
+    dc->realize = i8259_common_realize;
     /*
      * Reason: unlike ordinary ISA devices, the PICs need additional
      * wiring: its IRQ input lines are set up by board code, and the
@@ -215,16 +216,16 @@ static void pic_common_class_init(ObjectClass *klass, const void *data)
      * code.
      */
     dc->user_creatable = false;
-    ic->get_statistics = pic_get_statistics;
-    ic->print_info = pic_print_info;
+    ic->get_statistics = i8259_common_get_statistics;
+    ic->print_info = i8259_common_print_info;
 }
 
-static const TypeInfo pic_common_type = {
+static const TypeInfo i8259_common_type = {
     .name = TYPE_I8259_COMMON,
     .parent = TYPE_ISA_DEVICE,
     .instance_size = sizeof(I8259CommonState),
     .class_size = sizeof(I8259CommonClass),
-    .class_init = pic_common_class_init,
+    .class_init = i8259_common_class_init,
     .abstract = true,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_INTERRUPT_STATS_PROVIDER },
@@ -232,9 +233,9 @@ static const TypeInfo pic_common_type = {
     },
 };
 
-static void pic_common_register_types(void)
+static void i8259_common_register_types(void)
 {
-    type_register_static(&pic_common_type);
+    type_register_static(&i8259_common_type);
 }
 
-type_init(pic_common_register_types)
+type_init(i8259_common_register_types)
-- 
2.43.0


