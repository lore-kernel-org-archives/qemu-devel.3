Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C100C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzy7b-0002Tr-Pd; Fri, 28 Aug 2026 11:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7R-0002TQ-2i
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:49 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzy7P-0008Mp-57
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:03:48 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDTNDQ2742378; Fri, 28 Aug 2026 08:03:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=owX3GhHqQzZWIPji+2jZaF+ApLAhb6Y+c1RAmIV4o
 fk=; b=xneQ6KP42b3wYM5Ln+P2QmhMJ41dHg2qlvzYGVAv7/X4bXsZBUY0AStok
 DA4hyhdspQ/ESw4zheO0JwShVVa2vXE56I+pnVTGqzwEw0U6j0l39Ep6sU3geIVE
 VAdUM/1+4nt3uqb/jT/J98vDGKcOlWtdgGLhlWOCiCiNo9pV2SrqaX1smZK7B1Ex
 VgtA3hcKln74cJ1TDL6Dr4u3pUnUGvm5AlgZTXyR2T8ukNQrjCP7fmseHHT8/8SR
 7SPxm4h4b3pSWvzZTEQCEPYK+XhsommsbonaggkQAcr+mJQTirkeA22CQOL4UH0/
 iNA5rd2HZRQ9b2akFt0BJuH7wi34Q==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021130.outbound.protection.outlook.com
 [40.93.194.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gaq9uu6bf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 28 Aug 2026 08:03:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFR2AqMfTRRIZr4RMPpTn+fDA4u/auTBQSHnZclVkjeT28ft/bZx8jRrxCksjt8QDkDiyF5JXiy4pvdp2E7tTr1CW3+GC8cxXsYe5dA1wYVTvLlzwNHI61KMssuU/bbY8nahb44/Mfl1HBlIZ6i3FM9TRG3krb58wlkZssMhT2F+yFdAJODLvdC+TwXsmzc04CHDwzCa1keoBW4iUCFt77vobt+q7mmCmX2Je1eDm02EBmbP+/TBteyQ1azlx4BHH8yJNRJCxEPToc28HnHPLoJUUEi0fLGx2CV7hGtS1ODk960M5L4mnsad0yu9O6grSOT+HfYHv3AuvjVixcoKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owX3GhHqQzZWIPji+2jZaF+ApLAhb6Y+c1RAmIV4ofk=;
 b=luefj62XDi/5o9LKr+tlYP6lS+RhRsQvv52Mn+9cfUJdzvzOqu8V/3AIXEmEQJbM7hqsHC1+c4AiR2fhdaly6b8RbAJBDP1W8WomppeFuI7bnVHdtv+Gdnd/ArzS7r2CPnoeTcsRFwbtx1xoAH6bfLSvCZVTr3ABoGUDOSWAtlSn2pi2AeFrbQ0jGp6gstSed58ch1dYvHlf7pGtQ1S/EqdohrxAvbJNaXothTXuJHsRNVZA0A7O/+OuJPzQIQ3mQXZ4sx1m1cI3cf1tu/2Bu38HTSTpyhaV6KlwDX5ZwrVtkyL8OksdF5LYnLze9pqk+bBtPkVMkbb7F0NnEEQG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owX3GhHqQzZWIPji+2jZaF+ApLAhb6Y+c1RAmIV4ofk=;
 b=RFpYBbyiTfLN2WQIXyfeR+AD6lk4CI7Jvgag8OAGeAhi6KkmcFHAkeXDTvzE91U4l+KonaBhDXC+vdbxUFael66L9OHRDhHmtVS7vCjsuG551MolHUJi954TmXiBQY3IlxPvTUQlMdFNX5AfK2HX8aEhB8ocJjusQ/7Fn6cinRAO1UjAzYdFxe+5nWi3IaRwh3+/LR3WRjaOqihRJPXRwvopC1uu80uOuZhVxOS9mYpmFzkU+vRUQChQbZGE6waAJ/0Lo5qz2Kt8sYGPUCnRkWjGfVJLZi5CIAp4ApTTrj1FL5f4lmoHVF4NfTlGI+pH717uirlWG+LKL+Ydz5KBBg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM4PR02MB8909.namprd02.prod.outlook.com (2603:10b6:8:b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Fri, 28 Aug
 2026 15:03:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:03:37 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 6/8] hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from
 object prop to class prop
Date: Fri, 28 Aug 2026 16:02:02 +0100
Message-ID: <20260828150313.1883999-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
References: <20260828150313.1883999-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM4PR02MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f08be95-2df1-4969-17ec-08df05158a02
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qmGQ8a61UOhvHvIh659+t+YbcxuPqJDlcIHWwGepHJmDdsZjC5MaPCBmMVYfxn0pN43Tj0ySF41VGRtkpeJVcUhCrd3jsPsG9Jux1vRX3upu9XNBNOy/xVT2m0ZThM7ToNXVw6ZokCTRaNzjsr2kZ6OTX7Btmu+AHVIOdqETTHNjAmx5tn2ljMEZaxl3yX2+H/KmYc0dmvtqr9Ca4ZizttycHg41ad5xvw8g1mCdrHsUTWrGvNtolkcCSzEc8T08FfGrb3SHw73UDudTQ97gFwi5yfv5Je5pmYjcaBpQ4/z16cl+Jvn8Fy6yZ7EoRpMRptOFsDy4DrBKhlCh4ZWj+n9ULZIHgmYdtFvsJG7hAzze1bTpfBWWycqMY6LAzLQQLNmA0nche/A20ywQATMp9v/TqOyABLNzcCF1WGUJ9T0EUe+BTSNreoViQv4LaPUUyoCb/STFeVCBFCU14G19IkpI6D1nN2tgzHJp2V/Bs+K4kBuQpFxsCvlgxp/4nooWg9Vj3tcuLhpgzHeG63Cmk9E5jNVNdUXgQsG7QrMNspDqcf8a4KqVmoF6CIGOGL0oEKdFqAL9abQcQ2kfvKabdVavF0XJQC+iSSfP025XQ33WCv8Dj6byE9OJJ+uUvfBx6fx+JGZzIMk4Jm9N7QsjM6qhfW93r85PF4Mu6GSiBTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHk5M2pFNTB0aU1GRW9PNEVueWZhTjcyK05XQ1UwMk9MYklGQ2p5K08zTzJF?=
 =?utf-8?B?clNhelQ1bFU5Qll5bTR1czhMYWZBekZxTlhXK1l1TG1PWmw4L2RaVFBLd2NO?=
 =?utf-8?B?aDRBZHE3MVFWY3Fmc2Yra0NWWEd3a0RPc09uZDFCUEx2UDZhcFRvNXduQ2RP?=
 =?utf-8?B?elA5eTh0RjExNVlyQ2swUXF0ZkR1a0YwN3NnRmN5cXBZeG8zQ3l5d1MwTFcx?=
 =?utf-8?B?WlZrZU9rRktLMEI3NWJQQlNlakN0WmFaZnEzNUsycUF4UXk4MjBSNGFTYVg5?=
 =?utf-8?B?RFFUZ2Q3MHZSZUltakNweVVxaVJiR2Vsa0lnSlVWMkRqdG1GcktqTGp1Yncx?=
 =?utf-8?B?UzhuVng1M1hhR3NBaFdNL3NsREhhYm9ic1lHbXBJNm82c0xJbWNrM0pYSVNv?=
 =?utf-8?B?a2szU2hmaGxlQ3JhbThMa1NLM2MxR2hDdnppdy9PTkRZcWNrR2lpeVp0UktF?=
 =?utf-8?B?SThCMVMzME1GMFBhOUxrbzl0S3dSU1hzUFViUnBWRXlobTNEL0cvRGo3aUhY?=
 =?utf-8?B?R09WTVB0blhUYVRHNGN2aEd6MDd0TUF1a25rZ2x5eFlyZmtHOEFCeDNFV0d0?=
 =?utf-8?B?MC82b2lGNGNwbHpKVFdNTHNMZnFnUTkzL1UrMWJOSkRrS1M1eE8zZ2w4dlkr?=
 =?utf-8?B?ZnN2STRiWjRRbDZ1eCtCb3NpZVVqcGJEbTRDNlA2NGlIUzdrNmVPam1Deko0?=
 =?utf-8?B?RE8zUkdoNHRiOTQ0N3JsSFpDUU5qRU1odk1RTWNCOGxvRThRT1p0Mkh5RUVh?=
 =?utf-8?B?YjhVVC95c3BWTHVtQ29ncmZLWlBzK2c1NUtUdi9NWWtkWkV6K0JtZDNJUjk1?=
 =?utf-8?B?aG91enhlYXFmMkhycG9EUStRYVN6MTlqWVVORmRqTnEvMmtEMDRqRkxneThD?=
 =?utf-8?B?TDgvdWRhT3k5SVcwNGlHcUtVVVVpR0J0UWRPQkxzUVVIZFNJV3d3U0hMREgw?=
 =?utf-8?B?cnJqTVV2Z1gyVlFQemxsZGtxNUJMOGR6b1J0RUJ6YS9vNWlnQnVOS2NMbjlM?=
 =?utf-8?B?WER6YUc0clJVcHdZVVZ1VE9uVFM1Z29MMzV5NVFYdUJjSGhyZGRSeGNrSnRa?=
 =?utf-8?B?SjFXcEYwelNhRlo4M2JUQ1pTYzZBdVhIVlVsRmp5Z2dqTkVCK2o3OTRtTXpy?=
 =?utf-8?B?SGxQZk83bWV5SHg3SDBmcXRudGkyMGpFUitHUFR5R1lSeWJhN1N0M0xvY0ha?=
 =?utf-8?B?Tm9hcy9yQUNtV1VRbks0V2s3djM5Z2RyY2xtSVc5VDMweElDZkNMYXJFRjdv?=
 =?utf-8?B?aXdVdVpaMVUxR0NudlFZaFB3bTFwaFJrVll3WHc0aCtGZWJWdDBNT2lPekNv?=
 =?utf-8?B?aEVZS3ZzNVpZVk5ZanB3YXpQdnhuR0h2QlNUb0p4VVpIc3NKbXpVZXBPQmFV?=
 =?utf-8?B?K09CdW1SeUo4K1p6UkVBT2FjbU85SU1Vai8vYnBjWmhCK0pNT1BXUGZla01N?=
 =?utf-8?B?WW1tNEgrbEg2VE9xeHlBSmlrQjQzTG44SE05cUJlRTVCcC8yaDA3Qy9pOHkw?=
 =?utf-8?B?aVVSTm11ajA5VTdDTVY0OGoxL3ptNjVwZTVhWXlCVUlPTEJqaEl4eFU3djla?=
 =?utf-8?B?em84cWh0SmdCWEkweFNpTzNBWHZQNVNVT3o1VEM5ZWo3WU1GcnJIYjQ5VFl4?=
 =?utf-8?B?YmFnV3VuU3g4MzN6RFlVMkdhOFR6dVUxeFRpK1dFNStia2UxOWxFTnp1M0xj?=
 =?utf-8?B?SEZnYzNCR1pZN1I2cXlTVk8rNEM3cklrRERodkFVNDBZc2VYV2pocFNIeGEr?=
 =?utf-8?B?ZU5XYm9EQUpOQkw0bCtZcHFMZjhRUVo2YjhRakRiM2ozN2VSSW1lZmZaaVFI?=
 =?utf-8?B?dUhweStkK1dsWENoRTlGMFNYUHpqM0NwVHJBWnRWbncrMUsvUTRyaWZUNUJq?=
 =?utf-8?B?MkVSMGw5Qk1LSXlScUZlTG1QekZ6djg2WUx2M0tSa3BZR3JEeXF3OCtJSFh3?=
 =?utf-8?B?TDA3ZkJ0bWo2T0NFMVZvaWNpa2g3ZjhqRi9nVklzbko1WnhEb2plem0vRWEy?=
 =?utf-8?B?d3ZHTjZJcUxNek9pRzkwMWxkWlh4SlZOV0JDVmF5YzZYRjRid01WMnRQcmw1?=
 =?utf-8?B?RTBrREl5c3krT3k4MjdNQ3JuTFEwUVBxU3VkdEs5VW5QZjJ3ZzVjWVNnRXNG?=
 =?utf-8?B?UzZXc0Z6V1hqeGdxT1A3Rmdnb3JLK2xzajladHMwaXNucDZEOG4wUE1VNmJQ?=
 =?utf-8?B?NWpGNEFmQXVDaEUwRFFRUTR5TVp4cWZ4SXZiMUdxS0tjUnZPeUtmbXhqelVR?=
 =?utf-8?B?ckxZKy9qY2V3VXp5ZTE5cyt2TTRYWnZoeVNnUm9RT0JLNGg2MWtrS3ZaZzhW?=
 =?utf-8?B?WWszeU4ycnp2SGlqdVdxM0FFbnVLVHpxY2RCN2E0VkdMQXFkbGpFYVNRb3dH?=
 =?utf-8?Q?6QHV+ZkRa0IR9RbA=3D?=
X-Exchange-RoutingPolicyChecked: xXP7X/xD9GhS9CQneYXZ0OG1hDiDH6+IxaswZFGRz7h2g6h8gygwgL1LkoH2YC7T2XkYNQvOZCPF5qNa3u/oLxbRu4hgoNNhRPknevbA3r32+Lu5165jeTSyjZn0xV0M0xxOW22/ytDkSb6tz2RwEcoxgVzHW888ETy0cXQgkowqWF4Qw28QjfEqYd0CcHbBDxDxF2SpiRDyC85EO/hsX3JvAcLL/Jz7FvPyWmMEqJFxIKtiWnwuwrPhENWTBxUTZBTUwC9yIE2Ta8lGObJ9q71OM/J5Wt9IOzv9T9s6jKAcU3vN3Xd289hy2puDcI7dhg3OG3QBJibNnHNkaqnmLg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f08be95-2df1-4969-17ec-08df05158a02
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:03:37.8489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkId/Hne5iP6tWqllfauFWLv3od5YFIjlc54EoIAGUn7Q03SSqL12L5MLO9RT8mc2hxrxUxxsg256FjPUUjnNYhEmHers0QWrf4lUmooK+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8909
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfXwQrDbMm5nKru
 xsHkV+pmkCf/gRuCmo6sKRGNPuLzSOau+iCWPlr5eVrkg3AhOJ9q52fEqsUP0lZML5APJTrVDNs
 mrTBGyVdlnr8d/qNp1QfnqCAl1yTZSyi6lUHB8rQmwa6ObnilSbYI2ezDA/GF3oXWmR9pjSUNBF
 CggZ+D5Hn25urhoRq0LfRwkHKI6oFZQxe9XcKAv1PLGWc0mFlco7Vbo9VULcP1+HDWxq1kOGeWt
 xTnFf/j+M5d74sUr1qKUBgUoFovjGCvO0P6Cq0Ud4o94QiajTzE/2aXLSHXZ4hCN6MrV2XDZZ8W
 66nGuMRyQhABuLU0Keo5B0/18rjWuL2OlR1qZ+hgIA0aw+t3v50RkXFCbn60DyiMhXnl8qY6kSr
 h4kN1ba1KPmYQgIIZ5dkgTXNwtg5dpt9fd79QSct+OFWdJhNXlFNOmQmDH8nDfXvYsM4O2bVanY
 jpnJJfpW1QuqD8894bw==
X-Authority-Analysis: v=2.4 cv=ONQXGyaB c=1 sm=1 tr=0 ts=6a91a350 cx=c_pps
 a=Pb7wY1jdxbaV20HAOOqOTg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=UCpAsvFGFtcHmW4zG-sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Ay8b0LfLCVUqrQsKQmxVqte0NXoRODDx
X-Proofpoint-ORIG-GUID: Ay8b0LfLCVUqrQsKQmxVqte0NXoRODDx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzMSBTYWx0ZWRfXy6G1WWbbxBSx
 bcJkCAe5Ua3znMSF2fILdsuvstIt8F1tmGULL8Nfiivxps7t8mUaGxI2kde3S3H3OW8ECqlUyQ7
 6Z3BbByQP2vGoKp0Hg6XUEilEgE/hI8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc.c      | 5 +++++
 hw/i386/pc_piix.c | 5 -----
 hw/i386/pc_q35.c  | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f8969ddebc..876ebaadb8 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1795,6 +1795,11 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_rtc_time),
                                     TYPE_MC146818_RTC,
                                     "date");
+    object_class_property_add_link(oc, PC_MACHINE_ACPI_DEVICE_PROP,
+                                   TYPE_HOTPLUG_HANDLER,
+                                   offsetof(X86MachineState, acpi_dev),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a929cc4dec..63c4667ea3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -306,11 +306,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  piix4_pm, &error_abort);
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 94cd71124b..c3ce9c5649 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -247,11 +247,6 @@ static void pc_q35_init(MachineState *machine)
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-    object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                             TYPE_HOTPLUG_HANDLER,
-                             (Object **)&x86ms->acpi_dev,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              OBJECT(lpc), &error_abort);
 
-- 
2.43.0


