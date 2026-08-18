Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308CEC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwIiJ-0000t0-FW; Tue, 18 Aug 2026 08:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIiC-0000qn-7b
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1wwIiA-0001ME-DF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 08:14:35 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IA5hRb1096263; Tue, 18 Aug 2026 05:14:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4+LDeRycqrI453zb1Xm10OmBkAbhWTgiISqq6MKhB
 mM=; b=XiFTyeby3y5WWB88dEeInTHTw2ysmhF+CR1f73Np/rZgdaNhCYYHzKGQh
 RcOAfHC48BcQXxO7e96a2lC1xg+e6FNNx7LuCUXH2EOQ70v5xuG6SKRnx1xSC9q0
 BrmRR+xqVD0AiQnnFBH9720e4ikqP0v63fYU4CgQ0RuKl54QCRr6lNmEZXpy+zzw
 NPxwd+98QxZ+G40hO68vAsFkGtEjzl2AOqXQP51vMAP8Js3UpRMHa6W1w7gH/Sxa
 faOHdod/H16oQbjFO+olJVd/grPf327byWgxVXLBCqFqObB1IyuMNw0CbXOkf479
 3DzM7isijxHJMHr66UyTManKDcUOQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022123.outbound.protection.outlook.com [52.101.48.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g2qmxpccq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 05:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdYJadsEW+fgX7lcarigtnxgLIZjLJkom/V8fJfYI/eKVFM8Su4UaSvr3dIjjvulZf0gH4xQL+u8nTGyiZCvfTrNY/S1VC+pHjnwTEarFxk1bX/M7WUthW53vFAS7DoSS3piuA9ItqeZk9AxuVzl1DQmfZq9jYg+gmGpEQNwnK0VrbPUFHaSODobSNY/mo4+XrdjOuH1c8FjdGTW9bbBaPzIgFUyrtPVAOGINeC0mVHnSIB9TzhF13v3zj95S08jr510J1uAMHg0S2WtaHkGn8irkhoCzPbbJEMFS5KZwYvbuYwmQkFwuBQF96b5TUAAz1B8J2mXGFIqSD8jEQs0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+LDeRycqrI453zb1Xm10OmBkAbhWTgiISqq6MKhBmM=;
 b=vPF0XSJ2HV2zaq36Y3vZB5OF0nb7BK22zA9G6ghkeFjXCu87d3IK9hv0xpp892jWAd/gd+3dJ1ObhtmszOUqNVUV61krCwz+TvM8wmF3wQD3BFMBUi+MLU8rg94s8PAMtmub0l/e1Ov3vTOFNSA5x04oKQTCIMQkl2EOcEnLcSlb8ZxKCgHXAAmK3z0U45wWIVxF4G1Wxb1gdKgF5kTx3rnEcrEnUEobwR77JuHMc/UjcMRk4NrVNtMVlZjT8hKyg2yLYl7OUZ//hmKCCC1cUgS/RfzCo/bV8Zf3MWRhjy0oH2khVjbMissscPhJwUiRZSxNxPcXJSSwAum9CcY/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+LDeRycqrI453zb1Xm10OmBkAbhWTgiISqq6MKhBmM=;
 b=hqy3bwPGWp/1zubkCApxqVkK+8O3+zvxdgxba8VmYdW1YxVM6AfUEyaX2soVVYcFBvXnldHk/EpkeqWc9JBGO+VjaOQCHS7LHsiqoTAj5AeZ9VFpSeNuUfMg1OkyNDvKDjEN1gUqRZLq6mlBhddXRlkWtif+CNsx/0BdKOwfYkKcI+T5D0J3m685tL5Df/HNkSyfwFjAE0zrhrzAIUQsydSW994fs6iB1aP+1CFUOEmudxyFy+hqQxP3L/qArjGq1iNiuckTDz3sTb7dskXyg2rhMTC701I7PVfpGBlyMPNc81irI82mKnWp3t5e63DZM1zcvCY/Mcz5PoZk626oFg==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by LV3PR02MB10210.namprd02.prod.outlook.com (2603:10b6:408:21a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 12:14:31 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 12:14:31 +0000
From: Lukasz Kornicki <lucas.kornicki@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/4] ui/vnc: notify client of clipboard peer status
Date: Tue, 18 Aug 2026 14:14:13 +0200
Message-ID: <20260818121413.2660786-5-lucas.kornicki@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::17) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|LV3PR02MB10210:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb2148b-334f-44c4-a32a-08defd224243
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: N5iGOh2C4IisfsVU7hLAY/yUjnuTJZCpn/Bl7SQPfKt3p/uoBDOzMMZ5UiOgCnhMrYVXlaZNWfNMTFvZwn+1u6hO1ufMhN2unCjt9fOwm6knjEb+V7sm2ZBDMTcnXXwqvUteW9Jh3ndMx6bDKGeeLl/S+wP5JuUXdA6Y+oi4OOUyc+e5LBdbMdhJ5C8DGZY9btXywmWfm9J9/F7qeUVi++cF4GPu1G53BwSxfKMWT/LRo+NUCZRp7XcUAEHiSTs4iY0IDo8iQQs+SbPAA11g9d+GaWOJKUwAQyrj+QOUQr+oMj5hy3NE6KEGOU2V55dkPtYO2Lm+Xw9PqJNnRKBp8ZHlOAqrDKNdL3LM+gU4t6tm089ZYK3dSR0ay2qqxMjCktzgjWepEiFl6fuMI9Sh1+QiT6jvkUGmZ/oMH2Z7VdWnyVPbI7zOLh4pRUbKcunTWyRxGOFaHdvQwJvGkeG7wEDB825RxA7twGeP0PSmFMpViAJCsjjH8xq2Y6wJQy1EtNoGWyLZjeBI6W3mYgHpjL+bKpehdJWsWyJ2KRutJesyS4O8TTdOBrQEEl4BX5fuoVprhT4sHI+HffP1oKprdo66l8zISjjA4D+A+51l9oXHB7xOw+2gVmuhVMW7muY5ou3dNCMNc7QvxaC0ni1vsRpd3Kv4H7lZQRD8I22VCCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0OSvRT1a2ciKzJ1TaRLKIViUorbapZYTJO9YUEdbH1PM5yLBv1NFfA8vAsH?=
 =?us-ascii?Q?eGDsz+AszQ8/HtFo8t8dxp8HLr/pKmLlmuzS4IvsruOhg3IjB15p3HmpA6j/?=
 =?us-ascii?Q?YT5eH2iADobsZGvcDd5NFiu8z5ljOyaR3lmcZ23UJQEqC8i1WA0XW7V0M0yL?=
 =?us-ascii?Q?PwefazX2QlaIAH9N0bHEuNECYobesubc7m/I4760d3KhhhfasLEhc3J/VtxQ?=
 =?us-ascii?Q?Ivw3XFPo0C+hX/yEYGYIw4ZxhV9/Ru255aUyzWHkQnbASy1vZp5p4Hm0Z9EH?=
 =?us-ascii?Q?WG5ms8DWl1gp4cli2hvUbYDdUrTufqkcRUXFVmDNtgF9qY49u0uud9H2wbVc?=
 =?us-ascii?Q?cmCDQwjx52CK7HBkmdUs7FF3yTGj//oOUQjUdLdEJKpcaTmjfzqidqf+eeo5?=
 =?us-ascii?Q?5Iwrv3LMaYwho36BONEAlXkTrkO2fV65+5aJvrR9y00/maC091pQ5PeLlzlV?=
 =?us-ascii?Q?grbya+UTp5/ueG6flzcUkaEObUCAHzCcjps8OQ3IpXPlq/K+S+n5Xm6NRoGx?=
 =?us-ascii?Q?V4G5hPgPrCzRXbRA5JuQgbYPUiQIhzLrJgd7mFm1XpZ35FSITv70qpRDM3IW?=
 =?us-ascii?Q?/ERNEGnC1YGKqY8u/3F2nC6mjjgCi3K0WQX9YuXDOGe8hE/3rTr3YxZvk5XE?=
 =?us-ascii?Q?U9f9woNkeSMB/DLC8/ie54y/DPQtQDr1dX35+PnQeR+Rpf1Ojewk24EaZ2tb?=
 =?us-ascii?Q?yRjD3trPjXBXorT7vtt7N+Kqq1GkHKjyRImReSpSkVJNxFp1/isM5pD6+TX7?=
 =?us-ascii?Q?FtY8zi5ZWSqdg7Sh9Q0lROD5ctxPoji7pW1xx6kwXmXfXXGionA7DyuSO+1j?=
 =?us-ascii?Q?0MNFsPUHE0FKMu54D0ge9jjOYT3UQSfj2GxBBIoxZ2yfpAMABV1E1dd4UI9H?=
 =?us-ascii?Q?PfS4yvwOLSPBJS+iSy0VxoAFg/DBH2gEmuY0MDQNntnNR342TpVcoIVyeyJ+?=
 =?us-ascii?Q?1qvuiLrruiBoEjwKv2bEpbJofUn9Eeql6Ynm4HaLkNp5jL2B/fqrqUNl0aDL?=
 =?us-ascii?Q?50kpNBUgO7x2NRXhjmrMICwnbC6cTKY8rflVVPqx8vIxr45jVSwjW7Au8maj?=
 =?us-ascii?Q?aKA6hZA9polStW8J5oWcWiDGOT3G/SIoo0GVNFrtEQQLpRd12u14/2P5X56D?=
 =?us-ascii?Q?WVHVc7YmAMBjRW8RKFVtkzSS299o1xzQA0Hg8/l6LoIVcpjKB88VsISzuLxG?=
 =?us-ascii?Q?7yWc2w6x5Zt2tAzBZgZOr26M6xHP100Nosi6N713RCBtLmlpNr8Wv4+70+Ty?=
 =?us-ascii?Q?sBk+VXw1FkWChLjqYl8JsItVEYQB2zgPdh2ASbrpk2tpjLZRazhUHEqyTjrL?=
 =?us-ascii?Q?oW7DUsd/fuHBPLr3Ew+v1FFPHsM/m3raII2FU9ntxdBkZFd9nqxdx6Yl/+y5?=
 =?us-ascii?Q?SXaggXKMf5qIq5G0MGlSn679BJkIOEEdjg2YGi1uD1EHQLCenSkKamLBYRJh?=
 =?us-ascii?Q?3e0f6TKq5BrI6+g/+tspqnu+e1730IBxCExlnlqd2BioDzLhWBTiEpLRxQfP?=
 =?us-ascii?Q?CB+vQkp5K+2kqWI/tfmdy1uIrTGo67iPMNQty+ff5RmFlVykBZ8O2UEs12kD?=
 =?us-ascii?Q?/uq0VTQWcwDEduVRITYSeJipLZTOehdXN7Oam8NzehIiOwNeaJwNS1DKCMlG?=
 =?us-ascii?Q?cyitnjj7Do0agym9Q2pPI2X7Wl67KqvKFR6rnUzTMH9boQdlNVHTBa/V+oX0?=
 =?us-ascii?Q?j2jKthjCzOKDK1Fapi7p496oV6n5guO7J86TKPiwHHd69RW7VaEm5yIGVmvl?=
 =?us-ascii?Q?JHL+mrIk0w=3D=3D?=
X-Exchange-RoutingPolicyChecked: r1TgYxX1UxwSZ3NzDpTf5OzZOVYoCMT5QbE5YjvR64dwQad1xeRz5896tr3lsbG3zehZ5wSirOJRxdHwhHAs2YDZgcJV+vocIOUno8b/TVJP+LokAhB44YUCE2B5Z0gPzChK6esadswY2z/wTdvhQioe5wJrnGrah93Nn7eVxuQL+Sx4qDWMEphFs+ZLkNMbZsLeHDzKUSouwMBf6hpmIpTzsltxySsaLMNgCDs25xfsLut2fa0vxnK9O4KkSflyxuj8DxsCTF/pRnawE5yn8NDuw3vSlCmulzGJFm7iyZMdpk/FPEiQRNSbsMH9vcigtxh9KYDWcGwVOMNmNs1pPg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb2148b-334f-44c4-a32a-08defd224243
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 12:14:31.6681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGb3SGCjChvvbRAUMj6T2TN93BA6P1Hklaa+AR+fupeXqPty9PBeghFjUO/1DN82rF8BuYX+JhIUsMX3K9vIefMEoUsgLDuScs5NVk3W0qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR02MB10210
X-Authority-Analysis: v=2.4 cv=Q+riJY2a c=1 sm=1 tr=0 ts=6a844ca9 cx=c_pps
 a=qHanueHLqd5GN4xLMHIYUw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=-3kcguB0CHop7p9IiFYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfXzCa38OWf3H+a
 BEIVaJ8pmmU8uR8QTXYHCA61OuzZ6tnPyaiYjdd/kzX7nRo2urFkVB6zgEVNqaC9asH6VOT5zol
 PSn7NzfP9lYqPoNkZTj0udEcZr8AJZUqwE3KmG7NFHiI/Q40uxTBLt5XMQUGlW7MXsDz1ZHiJPQ
 3Xm11tYLFEhUcdALi6aIjfISZMYp9nQbk1Q3VgTWZW/P29OZDQrjm6DIN4gRFc0ISmeYtP9Fe1s
 KuMeUcV/TvJ28huCPq//7xVOygYPNY9jIRPqFtHtOH3+13JzsZLWqavmnpybP2XRVAWBVLYR0Li
 BAKsb8TSWSeG2A11glfT4DBNC8G95LLVyYooDcQMSV99I6II1yHI2RjOQPF673eUkmR/hXvP4qV
 L8vDTXh04G0OsHgE0Ohdcq/Q5CC04TE+4TTGvESdHbuj3F/l6j8CMO1NEEsFGqawVYy5uMsisfh
 51/fX9bJ2eJP/JDdb7A==
X-Proofpoint-GUID: hM6ZpQBtEV5LjiqgXZuzgj2_XSXb8jXP
X-Proofpoint-ORIG-GUID: hM6ZpQBtEV5LjiqgXZuzgj2_XSXb8jXP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA5MCBTYWx0ZWRfX2iG5X//Br+3i
 LkqAbr0ntZo1RQCJEhJm9c+iS8jS7XUo5SLPRf4VMHZ42PRCPdbX7k0fx2AlGTEjRJSMSnDyyT4
 3An5OEe6491aX46hoP33KueaN9BuoKs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Change-Id: Id0897a24fae103288c399f73e808ed6c07018359
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


