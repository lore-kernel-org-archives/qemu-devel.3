Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12094C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6nBs-0003LN-2v; Wed, 16 Sep 2026 06:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n91-0001Ky-3d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:43 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x6n8y-00033W-Uk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:45:38 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68G80eEf539594; Wed, 16 Sep 2026 03:45:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=KaJeHdK8X2+JKUmO1RyhHbFBbRUmyKqMfGaHwwjNQ
 Ek=; b=Tm40bbzjQBoWMoE5Ec8y137ts/ChyVPjJV2uSRGCixUz/MbUY6wu37Rju
 Oc51l4a78XXC2qru+8IQIs3+/KoTMy2qmzKAHKNdZAqVX1dBsZdU8XIv4EHLiR/P
 dE1rGLedcqRV64nQ9XEMiWBIuz7Rwayz5XdU9R2+rNgrltkb/y4JW1gWeQqIJQNU
 G4VoxM9CgSNSk503+7DMS6uPoS8/Rmib5JyvxRoezgjAHUQfw3VlbgF9TnFsjsli
 lSU/zng2NXqdYNv5SzxrxcXhkCzYCFhT2bu7XewaRkDJWwgUDi1/EUy9k/0J6ibe
 FZBQF3wO1/AzEN08gnvIHQyDbieeA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021111.outbound.protection.outlook.com
 [40.93.194.111])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gqa0pta0c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 16 Sep 2026 03:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8IQ9qs7agnm4IWI3NMGImwgAP6mT3rqEQyuXt+2NT+J9ZEOfnT5eGt6ycEc8ZNDmXGmoPpSa6Gij1zHRIiUJQDEPa4b4alFjaLy+2cMc++pH2nZ6GDTRJhRhl3904OG9EkGoL+OFWadMrhOeK7YwhQcIEHuPG214wgCZE6DxVlkfIu4O0cWf0O/3QErhfFcYBsZWh8pM1g+eHsMyiDFZ9b2cxUSNokEIE+n0ss9gB3ThPLC8tfkl6XyDkzsvrW3XKRyq+54/xQ0/ONrwLy/EGh8nfBKQWjn1cLaSI7agWHKTyQUM0GiY2D22LMX/ZE3zU6KnScfr+5zLN4zNxcPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaJeHdK8X2+JKUmO1RyhHbFBbRUmyKqMfGaHwwjNQEk=;
 b=Nk/cmRa5RpSMez6tt1FNz1MbS40EPnZuYVJwRm07sd1DKLIP3yEKkK6yrgPJiHfsvqfLi3+zTycJUVwden0Wpk+cZsZZaTSX5yQdgoZQcvbmKzyWvi0iRuJkz2ttiVMz/yzt+e6mc2FJR65aNFAQCLCIAHf/daC7iJrd8EbB4EvnFgN7i+0zkCzyQqDlvitC3vHcc5s7fXUGpmORoS4aKU4rGT/hKk3E/frRzT51FuAoQmBpIbHr0mDmL+cvRM9rgVLgGQr2A7nwyKzNDW2Y1uhay7JLs95LTm8SONkpEUEyBjVx3P87EjUnBB1dJ3ByRDhHyuHY3P3tSgJ9UAl9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaJeHdK8X2+JKUmO1RyhHbFBbRUmyKqMfGaHwwjNQEk=;
 b=gzfqlvcHFhjE52VrWGrIAv8QWvqdcyulBCConAVv3L9MGGRPzfWBarghMuRumULgINjNdzjZrX39J5tMuvTCLhYOx/32Nwt7iJBrFsCODb40SM1goh5rzB51xrwdr1BtvFVd2GyzM8di0m0nA/3R5DLGOZcssxMTn+GKtWuznD0wRpR58dYp07NXdLjVP3NOsF4/LF+GYgO9zdrPYWT4IGQhbdrcDFbKBuEmEiKMvnMXStOzYrAU4yY5mivPu+FwUM66zREH5bcbRTZf4HxU819H1ll7lPyVlyQ4p/NZ8/nNirMcTYlRlCo2s0bJNt4t4plxs4hDBlSr0WTaFOdZKQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PHXPR02MB11343.namprd02.prod.outlook.com (2603:10b6:510:3cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:45:27 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:45:27 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@gmail.com, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 14/22] i8259.c: properly cascade secondary i8259 from primary
 i8259
Date: Wed, 16 Sep 2026 11:43:42 +0100
Message-ID: <20260916104435.600211-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916104435.600211-1-mark.caveayland@nutanix.com>
References: <20260916104435.600211-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:254::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PHXPR02MB11343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e945ac3-1529-4c9f-2b1f-08df13df9f05
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|3023799007|10067099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: VcQ7Mb9r1OYyCbJryQGF2bel79bqeqHy6UyqrWN01MVDAlA8A6NAO0StdrHfNS5Z9yPwH2fLtAYYU7sPyCD1tNAW5JAZUrJBhJ/QYeKuXYxFAsJV7uzYyq+o9sdC5VrfrQ1iwBnfKfiW11g6Yv8sOPrTRcUmDXiSgnohucur9hNtEmiV6dHDEUCYBGAzbZEGw9v+Mx1SxkXvIES5QnXWLtyo+mxRf+ne6UhnteTvjZ2+Z8GaZyJzCIGKelUhYdcw69SubfMDDckcx7Y6leINO5uxNn89RhBUdvp/0YvUHbyD87zi6s1K4rgLtIg3un0XnOi+LXdMWQdo5cMW8YipWHXGwxgoN6Yd4c/lr8qaKsfyyDLfDnSJu4Peb+cVpDVSZftuG2ouGVPptrh99VewlIPJzOc2tHmzm+8UW4aMWm2JEBbez1f4468ZwKZfffHYITq+vMi3ErhiXAjGS8vUqw2t03w38ZiUYp3S2fORUBWWVrAmLL7c7+k5tKpLhdALW5Spm7toS1xXNsMOUt72UU+C+euGm4wb/Anrx/CpC+knADmZzE60OGguU447BYXCXnSBHTBbXgW/qA0dbq15keOkZAd6JMZKNEs0aFxW0+YpRt3epSjt+0Zt1NzFIcNW7/nHIAlD/rsrb1fua0EJ+LonL+UTIZGu5ZR9G8mnm6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(3023799007)(10067099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zPBqx7B0JlQ41uiY46E24Nav7YXDPvFEHEnVdXVoAmUiS+YJOgEKR35m+t3L?=
 =?us-ascii?Q?n3P67WVtVABEEMEntIosBtimT9MeSpaV3JmWBNw3yEpm6KPq7A/wcawDIlVA?=
 =?us-ascii?Q?m6qw/IE2eU7IM0e3diN9cV75AGiepSa0c0XpOjeUsXf2j44a+9xfFpkwNb/8?=
 =?us-ascii?Q?l+5Gi4SiLNZoL2486XSy6Q+2UevsdvEedB9rDMRuZeGWerWuxtqJIjciy/Yy?=
 =?us-ascii?Q?NmNLvhtaK4wNBcACHqGW8rtrTye9hYC7c7RtTsyyFJPGwb+jNuzH/MIT+nQD?=
 =?us-ascii?Q?mpADYQp7ghg9PwSPqRN3VzmyzER0MlgcEvzu8EsasmXJD3uZGDAfpXbmMQZR?=
 =?us-ascii?Q?mlBXKpiwPkiRlfPrWLxu78gJAWUyYxgJsUW+wPoxA8SKR20w4x5kZHAJLT69?=
 =?us-ascii?Q?32QVG5Xt4cJJxVeDocovqujxQlE6xOUGc/1nDO7vw1e2dFN8NNT4qvJUzBUi?=
 =?us-ascii?Q?dNaZ9aJa62djnjAHR1RxFlq0Yw8H4lnl4s7lTZIDO1jlYWnAJXtg12MHnxlj?=
 =?us-ascii?Q?KtWD7HDompwiHnjd+VKufHw8D2ocSKPUW6ju66B15xiy6dTRFlpgVJI6igZz?=
 =?us-ascii?Q?7HD+S7A029ceDSS7PRrZLTPUim3HnYIQz4tmr1mljRkB1eiiRY4/0HOTZJgh?=
 =?us-ascii?Q?ASjfRYUQMEXgNBfFXlV4bjk4nNUxA6xtTp3vKEEWJ6eGe88DwvlhxU+5irna?=
 =?us-ascii?Q?rXSkbZMKBdxxWt0ZwNcV2loJE+rKdBsZxd8BYgSeGla/0dayKrzU91RkKxb8?=
 =?us-ascii?Q?hxzvseKdrJu0Q53txhMQlJn3J2nk1iKQZJNtq53B6TS+RP74NJsz9tQyaD5w?=
 =?us-ascii?Q?mvbCB6dMhVk0FkebW4d83gaFL8BmmT8BMdyYsLNWITkC83sg0tp9HsXJjOJl?=
 =?us-ascii?Q?FBbRmLVq11t8R2C55VKTV1HusfM7PcBTRIhKJxi3ZmGDoUZ8nZemvxJPczsi?=
 =?us-ascii?Q?hPjunp4fS7GYsgBT+wt/4xVsNkfhPxcQN+x6Gr4Fd1/02g/1rxMZw/0lWQ16?=
 =?us-ascii?Q?k3yJlw6hTEWYSUfVdxy9XLQzNYAVfHtsnK6RTkIDKLcp8+wUe7cb60xM3ubA?=
 =?us-ascii?Q?2oWlAAr84lwb+XUYoHSDWC5+rOy5u8SI4edmLzKsaAtbv5lw2yRTKToGnEYu?=
 =?us-ascii?Q?do5Q+odWRZfCG0vpClGFoF0xrgmk5CXzn9WVp6PsZzMkFvuWnX3ezUFkuNsn?=
 =?us-ascii?Q?KRJIS9qduOOzqYtw8tFTnxCuU5VvuKiT9urh64RWvnlFGQwMVvaPtxXVYwY5?=
 =?us-ascii?Q?87WenBu6hpRU8bLsKRW2EfYLwMlPtRc6kAd6VEI/L0CiQY8U7e5S5e9aEHGk?=
 =?us-ascii?Q?wiZPifEEhz3Xz6Vl/8sRHu3fmjBOmtUG/aavT++o9RLxfIfN/0davziL+GB3?=
 =?us-ascii?Q?52nyTGxl8jr6hmKC++iGnmuVzGqqt7S+KllSwCxNhWBHcl04a4jiko/1QQHC?=
 =?us-ascii?Q?tf0XIV5McNE0YIWYDMZjMSdQP/T2Ay1L93Zf63pVIVsJscnQJ5D5eeWclE5Q?=
 =?us-ascii?Q?yhTQaB2Xs6XFupinD8hzOowokmpLvUSBKIWXPqK3q8EQpFiSoJaIQAsKVSIG?=
 =?us-ascii?Q?IiOuGm/3qY2qa8lkJcCsEHET5aZJaHaqBwFgsAzpANidfWnA33jVOeBFSc8e?=
 =?us-ascii?Q?KzplutZiHfZLEE3pDnM1+QP3HqfJ8pJnENrku3FSxWLhr1B4S2l8SzaMm/PD?=
 =?us-ascii?Q?JjhAY0V4Y/+5EVTGpoE63HpaunqQ1jJAD24/lkKpH0KBAJ1FQWrlHi8cZfFh?=
 =?us-ascii?Q?Nmbr8tcSE7CLcUA4qDxFX00OVR463NA=3D?=
X-Exchange-RoutingPolicyChecked: wSmWmZMeTDpYSvv9EF0gnp2ud/pkOe4oUMo67WOtpVcuNYbMtqVky9K2EvHM9pp+8i5UTOVkzoRQqsILswnACiY1t4q6u7V136dDLep66OgQyLzTsHfHEFmKxFDBPKNFhTWXFZVtLEKzLhJXcQazjiXJAuHVNHxBs8io6sUvT1kQSOcmvMD2iahY3ePfyfnrcNE+ttOfSFCsJ9KPjgvpYuYhvwcXEOjq3KaCF40huHvfmk+/Q5GXzicSx/9gfzHr7PJ7ugm2aQlF+2b64P5LLqAR+K3Qgt1QcrKrwpJmiLkgNdzp6WzPd3jj6Mf+h4ZtklDlLYvpywnHUGNGofKuig==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e945ac3-1529-4c9f-2b1f-08df13df9f05
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:45:27.7693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmaXQuMyb7DQQOPLaJc8GJ5Xl3dtUHrlyBfm2WnHsLiHi3v4Oq1kB6+9JUPjZ+7/VBRoDyNOmwXRDi+lse1BJst82W1HGrm3wEqeH9Oy64o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR02MB11343
X-Proofpoint-GUID: xXvIDoLSfYsO4AQT1nn-gGaJpLHEO11W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX6s2lHkCRWpUR
 SJSu+SZmpCPSDTTy25uzyD3ekb9G7GXS8tQMlB+01HbOrzirZ4uwdv5NahncRocLwu4gbYWzXOj
 TNDUM4JyKS5Tm6KF7GuGCZtgyCSJv2s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0MSBTYWx0ZWRfX9zgopvbNXKQT
 uZ/MMF0cjOCALNVE/xe/8t3aRT9lLGniY05Ocx6OG6YnidPO1PvWZS00KjUzckKQduzWN0JhGxT
 lP3LCzx0aBqJNUaDEfvqHe5LcGgvt8/zPl9njdPJuvrdXOJXUGkEb+ZZ5f78aSkTeXG6IeDTwW1
 0ChdzZvzocRznBb4bKhW8oLNdKsxE84dchxzx2Yjg2tWyGjzKtpGUb7gvujrPE2sHPGM/hiuxpP
 ow6C6pUp94Iz/mTrKNJPkiCGXJiGzQs54Ov733i6WvOxk4cZGDUaZK39AEP7tgA71Ku+rzTKnCH
 WFYLq2gYdZc/q5S+NgjamD+coXAnDyiLHVwUBFFNV8ZZ/wTvicuS1kS+uAbwdwuzL1Wkz+cSGsl
 zbBQkxxI+GyXQRGE/7NteloUCQymk/plVHQptLiDjYrepxTXRHHfGHMx0Wb4ezZc0qHy4kVtQ1n
 W9TQGuTzG6u4Hl8/hWw==
X-Proofpoint-ORIG-GUID: xXvIDoLSfYsO4AQT1nn-gGaJpLHEO11W
X-Authority-Analysis: v=2.4 cv=Ps4G/AM3 c=1 sm=1 tr=0 ts=6aaa7349 cx=c_pps
 a=Xow/CfGS+sd61STD3JSCXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=qb3w2fq3S_qpQCe-DwsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Currently the cascaded output from the secondary i8259 is returned directly in
the pass_irqs[] array, instead of being connected to the relevant input of the
primary i8259.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/intc/i8259.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index fcc94e12f8..964ceb04b2 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -501,7 +501,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
     }
 
     /* Wire up secondary cascade */
-    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+    qdev_connect_gpio_out(sec_dev, 0,
+                          qdev_get_gpio_in(pri_dev, 2));
 
     for (i = 8; i < ISA_NUM_IRQS; i++) {
         s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
-- 
2.43.0


