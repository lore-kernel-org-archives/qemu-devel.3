Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB49C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHOWp-0003OJ-Vp; Tue, 20 May 2025 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWn-0003Mr-SQ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:13 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uHOWl-0002hC-J8
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:05:13 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K7TJce016599;
 Tue, 20 May 2025 08:05:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qVmeUiR5OGlh/Pj2aaqY2wnRJ1E4eTbe1pR0nXs8x
 fs=; b=fwlljWC7j3uUzDS6sVKnEgof0+Qbj19RZ/oH/zvnBdSF5LDta2I38/48y
 pjxAG3fwEjBJgIQN46xhATPGkXJitINr7vB3Yao53C8yvBKlLWHbg/wQ0MHKGg8a
 ywxR89O9TjVYHgppg2E72NFOZ44lv5A2fSoOLnoNTLJIqTBWJDcwjw2qithGtofq
 HSn51nLWodhlXeEZdJ2XbSHHnFGzBxZHBDvJh0A9woOJRVBrve+etSP4G7RnRS/O
 BiU4AxVdAEZZGelToo5KYitZaA9nEuCWwp0wVocem+nkogXNf8pLdP70kpL6cWvh
 0raT6GevTfxOa+2xMFp9CqRTH/JzQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46prjheadj-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 May 2025 08:05:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ/NqIjGL40+XWzav3Dqd3Wur9WnezA2IM/EqOzdQc4Uw/xDnCvwlbUzlr3klQdNfO8knMWfN4LIcpKHE+u7lbm/M8WjCglBZ3benJVTEnVwqCtF2AUQr1nhmpVSser6XIDpHG9FGHh3z8FHsl/FZdilHg+MIiKdOWxQLPURAiTlASIwWatMsgQC7yEPIbK+FfL2ErWYzFI7AqCwyaHgtiyBI52flmUZNDSGtRyWVCUehdFDPbvfbm3VGUNXKnbnTysNw+NdJ7de3zO3niZeoLFPdcGBm4pS+w0frPi6v3pMtiQNnnI5CELIwfMUZAWnf6CAWyoyD6/1v9Tnx1tdeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVmeUiR5OGlh/Pj2aaqY2wnRJ1E4eTbe1pR0nXs8xfs=;
 b=XKeFVsTZLWBNi/SSKSwWJKSalLPCMmLasdNosZJd9ej0DJQM6hL2c1afXmJragGLRI+BWQPnpx4dgysZzonieKv0QnsWfSRTamkVf0klRzGD3vHxwT0ALMHzJK/+4qnVkARCch1tNshdqyM3jpBiMcx40AgPJFGH+aNvw34TmEZg/ieRAV0AqwlxoOqKstpTm4WgzPWkm+nMT7uJvJIXmvnPrplOg+CQkCB9fwfOz+Og7tkluT1YJvP4tqcLIn4QhkExG238V3aUWK69v4eu7UcPZCopGkNreo69Ti8XwOCeRFn1BOyL91DwwafqnKAi/q86/i2MxEWwRg+wSO1TdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVmeUiR5OGlh/Pj2aaqY2wnRJ1E4eTbe1pR0nXs8xfs=;
 b=n462GP0djX540HIqquxcsywqWK37pS7gKPih30QNUFJO9ddwyVZNT1eppiTDU20cXdb0/Yxg49MCzvdAylEnM8zB7/3icAkns7S9m9p0SwPuNp4iUd75kDOAGIGhMbBVF9SKJNS4sESKcuw4ZzcHxGct29RVWUZRBvk0bQ5xtVoDDFq5XwToxQxi9JcUtfJfyF4GNo6Ez6mNUo4gt3Nzh2sAG9S04TeXdsHH98oLdBLIN9wmoOYrLxEzJvQ36h9P7ZYfcevlMDPPLkOGtvPymgidR17x2TVHBXLZh8V7XHzgD4rrBYX4FpLEDHZm6fe10Q0D7t6RCQ7IGbi2zhLigQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.23; Tue, 20 May
 2025 15:05:07 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8769.016; Tue, 20 May 2025
 15:05:07 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v2 17/29] vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
Date: Tue, 20 May 2025 16:04:06 +0100
Message-ID: <20250520150419.2172078-18-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520150419.2172078-1-john.levon@nutanix.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA1PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 00cb70dd-71b7-4272-1205-08dd97afb55e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGYHX+c4NhK76TSfpXSbj+ymAM9fOdSeNVnisb6f2XihI7lPsVkMUTsq89RE?=
 =?us-ascii?Q?Wu7uByjPIgGe2TSemXTbmp63KoNbm5NeTMwQvAsFax36aX/oDCytE4MMCoo8?=
 =?us-ascii?Q?antzPAiISPWN4MzEzJukeE+TlQo7I7g7R+Gx38ZAZqcC+DPBsNUy7xAfYyNT?=
 =?us-ascii?Q?iO278B2ewi18sWQucNNH+NTUYFBYFWe6H4rqCfvAuNx/30TCfplXi5XbjhiO?=
 =?us-ascii?Q?zxRUxxTtK2u1wZ1ELcrFPZapA3ROE9kb8dwwV3ixmy8zB9I34hf0UzhlUcVD?=
 =?us-ascii?Q?HlDUakw/SFR1s2sQo6/n8lyxHPbZlRZiyRPWtGLuq3oIYV5cppY8nJ9pCgs0?=
 =?us-ascii?Q?TYTbD1RoCioEWoYNOIpp+aDgQV/6VneQySGzgpLHmhJDhhodMR9EWXfuaKOC?=
 =?us-ascii?Q?JLdTuvDZGPvy/ZROwJ4w4fB8cAZyG+gEGd7B6M4ZC/jYjSwCTQc+MwmbZPES?=
 =?us-ascii?Q?pux3GfrO+QEBwBqtYetshxNZ5FJHGn9JZR7eCoPQITx/SbMMqAkKW2Y6TNZO?=
 =?us-ascii?Q?08YsH6B0BujHIyCPM2c/3MEZCtUh89QPm2/idhr/HwP7p4gXhsHUeMOn4N4M?=
 =?us-ascii?Q?9AblQHMH7LKklNNn88ulJ9FrcHTJ9YWCLzJEicrSZgOzqcy8FIDMFCYDj+Iv?=
 =?us-ascii?Q?P5YUvKLVvixiqjAl0bWSix5ojLb4PNnM7mzC33UurCqqtcdrmdlreOr7CU4u?=
 =?us-ascii?Q?y0aw3S3InJj6AYWH1Iz8V0iLWoutwZo+Zf4Wwb/5wwGg88b6zuaZf/1XsSDz?=
 =?us-ascii?Q?pGkLUeCa/qN2Z7fKqABJFeSGCDxDfqckIZivIxVqevG0S8Iz16zd99t6cEDa?=
 =?us-ascii?Q?btk+jfJbhXShslnNJjU16Q+QIlfhpsai6KwO1GSM40irfCGW9GMcIB7Op8Td?=
 =?us-ascii?Q?qh2lUFYdoJTkLMf0bHPKBy3y0DTI8xfsZZZ9HdV84Eyd3+VP2x6Aybfq6QRD?=
 =?us-ascii?Q?hPCUuI3LH9HHneOcaVEQCk8+BtvnLg+BqcDRIZH7M/DnIhBurlPrP/zjZFGj?=
 =?us-ascii?Q?n0Brh/ivlQ6GIr/F/j97TQt/7KnbHgW970WF2QM51jQJ6Jv+rK+R/FkYubC6?=
 =?us-ascii?Q?SzoEl1s++2pZf10mY2ppa+Cwlf7baT6Gycv+4IFGwjxO5YLXmDsGPBIKXFOX?=
 =?us-ascii?Q?A9/N7jbfSxnZ/+xWYp/VYzv998aAe2bVgQ+8DqRlCI388ivB6a9BtgfyrULO?=
 =?us-ascii?Q?OqUBY8pgPHw0BwmcQxkjEgrlSgdM7H/3kyW/3GVxbRwAvxbaaJKxqrvzhzrR?=
 =?us-ascii?Q?CXjcYybGEr8e0mqH7KhB1MxSp0d1yGIg+56I/kz8oN9qhTDQpNTZZCYKCUlH?=
 =?us-ascii?Q?jEaw2A/CKuCt97oNkDGMugrNXFBwleD/SufTrhR8JiE4SMmwb4zL5guR9f2G?=
 =?us-ascii?Q?dneQWHOLZPfQlwGzhZQrmbX4x16XSBS5lM5XZE85V4kTd2T2Jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DmuG6y71rgQiHLoy8pC2Ng1oZxlGp5V9pD91raQp74T7CFlrUY+i785Alntd?=
 =?us-ascii?Q?DdGQo2sS3rxjgpY65HXWOf9rd8+aaGwj+zbzy+6E/RTFhVzGnCmiSTUqqaBk?=
 =?us-ascii?Q?cijvhZjzWT138FZZdMePpBjsqmss3tQMa/9XVUrKT4mQsSBGWdV8mr+k58Tq?=
 =?us-ascii?Q?1aPHRiGylEJi0tEC8oitEdwfTFVZ/W5EQj6tiR4ohaSZlL/BN9mxVflSFPH4?=
 =?us-ascii?Q?mzEMldHQtUf5q5YYgk0AnSH8bLRxw7q0AzAJaST0OdXm9tjJSSlFKw4xuvjf?=
 =?us-ascii?Q?jv1P/Wm8GL5MSNCrczo7hOJPJCuHJXyRxoSRVZ9c6AVvv8drx5ARON7c1u9k?=
 =?us-ascii?Q?WVtqZtbmTRwsVTs+Mb0TGKJrsJWuE1wwkHDyBvkgr4plb1pHMk7RE7Hxhiyh?=
 =?us-ascii?Q?58IBMT5Lb1zWAlvFlzr6SOIADl7SA5/Z64XSg/SY22Fb4CBoTAPFmSwRpmt1?=
 =?us-ascii?Q?VSljN7qi4K9vW7VLLKbRhPg47qjXeI4DUV02kEpSYQ9KeF82maZ6+lLIacEr?=
 =?us-ascii?Q?sY0Z+zpH++wW97bdYKmIlz+caHNEXOUzvVp6U5tmRwiuv7EUaBJ9MXVl6IkH?=
 =?us-ascii?Q?xH0z05rSADbsOsvckzwZ5P3TXCPdNSoQZoPXQ6812tUzSOPopjx3VFoeiOkJ?=
 =?us-ascii?Q?Wh+NO+Ryp+064DXywvZKBx6UH7HXtflt8W7gBg3bD+myzJTd3MM8Zglhc4NF?=
 =?us-ascii?Q?Crp11vAXRoHrwJNrc/EUFiAyV/45ChwyU8N3/PUNK7no7TkhA1Ir7dQqxKQp?=
 =?us-ascii?Q?k9W7M7yT/QmeBZKOERegEynH5ueYomU/2gUB0DEpjQWihvoVPZ0V8q35w6wV?=
 =?us-ascii?Q?3WY65wlQXag/lGIsZUgS31i8MZ0OGDD3VQsIEuhzK71OH+EM2tamzjPc0F9U?=
 =?us-ascii?Q?heYFsX9COQv7gKqgNvSdd+/5I9quUzPNq9WipPYRRjOa4K7d8laS8eSd/Ye+?=
 =?us-ascii?Q?KWnbH6oy/3PRIHYgH1H9kLA6nzTE427DKXTPR0R4blUvSQwxQSvL6j+jV/mi?=
 =?us-ascii?Q?NJvGPQKWl8FwhmS4kjTkDwwcg448uidAJwzp3Mmw4duyJubVUE4ZEW15hteR?=
 =?us-ascii?Q?6mD8Nwiu4dRUJa0DEfAa8lkE7L3bIXrXUX7zHh8LHSd17eiYqx4lgV/ozDO+?=
 =?us-ascii?Q?JshXavyee4sjB947LzB/pU7rxOUf7RrWgF75giQJJNfdi6r0Zrd6vBxaRWWZ?=
 =?us-ascii?Q?S4ANUvofN2kVDOX8Sruq6eRvXdFQQxMQWZ7o0+LUm00wC2gMJoZeLPK9gKJ9?=
 =?us-ascii?Q?AB5TvduX+OuzmVJDlJMXOCETaK1xm50PKUdgNe6QyRnMdYzli9kUw4ygMFHw?=
 =?us-ascii?Q?Gc0PW62jJdJFKGNCudQYJrYjf45AzggZT4q9srrq/F1KtNff5nKvg+4ZxeEm?=
 =?us-ascii?Q?lNLmvrlKimqqt7ih8LKwDC0Zil1Qb1HnIhwJWiyYsghUCfiSeVkmClJmMMMg?=
 =?us-ascii?Q?mXl6j9ZaW+Jh8v/kzd40Ib7IsyC+vBjcowMfERbonUo89FaFjPBc5YRQFTAD?=
 =?us-ascii?Q?41cQRezr/HpdbkIPmKneWOgeQslrt2eFHHFTN2gTpHcmGpKqRPD2zwF3V/G2?=
 =?us-ascii?Q?QyV4JmOIvbjGo/G5v3c2hCZoLD3dR2EZwX75LlmK?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cb70dd-71b7-4272-1205-08dd97afb55e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 15:05:07.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohCzm6ExgTyuEfYX0Nn6Lw3bHAMD0e0jZRi0x+lWYuO6hRMgapb6bzNJT4ShQXeHhG04biJuHrk+6I0F/Fn+hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDEyMiBTYWx0ZWRfX2fAyHOlgp/p+
 tjJr1cNzs3jNaQyPiCNKTNOJe6cC/04C+R9P2gc2fT2qpYM/Czjn3kl2x8kRF9ap+fOHlzJni+T
 4r2hJQyXwRyPFJaUI+3DzgVOnj0iyGbSbRv6c4ujSqK0yjA1Zn3KJzvUFvccnDN5hvxrSofvpQv
 snHHsx+bp/ilR2J+F3vdVC9Xk/peAV2+3ZOVvM49BHq8FEx9ea0l5CV9/STFkRb0ejoO0so8Kfa
 L+sjgzC6YCI8MynQk4Dc10SXTcuBfz6PRs7kR1WEARHF3fUXDdasZ920V/qxt4BClFHUkV2IZpE
 TOAyP/O2paR8VsV/9U9Nb0CpU3W5FIqMLa7A11+NhvurRi06Vz08+mnuI90oi9jnCkR3z7ic5Kl
 qSt842u501T/B0UvQ47+OEth1gTRstWUQwDjCnnNZXC774ZM9399rkZDHP91mF/JLbP49AGQ
X-Authority-Analysis: v=2.4 cv=T+SMT+KQ c=1 sm=1 tr=0 ts=682c9a25 cx=c_pps
 a=6L7f6dt9FWfToKUQdDsCmg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=u1fsugoMv0NfKDGiTLIA:9
X-Proofpoint-GUID: nbUbChhwrvkW1Rm1jWVfHpVLW84Pobfe
X-Proofpoint-ORIG-GUID: nbUbChhwrvkW1Rm1jWVfHpVLW84Pobfe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-20_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Add support for getting region info for vfio-user. As vfio-user has one
fd per region, enable ->use_region_fds.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     |  2 ++
 hw/vfio-user/protocol.h   | 14 ++++++++
 hw/vfio-user/proxy.h      |  1 +
 hw/vfio-user/device.c     | 68 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c        | 11 +++++++
 hw/vfio-user/trace-events |  1 +
 6 files changed, 97 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index f27f26b479..a5a2aa9ba6 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -20,4 +20,6 @@
 int vfio_user_get_device_info(VFIOUserProxy *proxy,
                               struct vfio_device_info *info);
 
+extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
+
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index 648badff46..1878d44c51 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -127,4 +127,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 9c6b2cdf35..e2cfaeead8 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -18,6 +18,7 @@
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index e081033ff1..57793e6b2b 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -48,3 +48,71 @@ int vfio_user_get_device_info(VFIOUserProxy *proxy,
 
     return 0;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    vfio_user_send_wait(proxy, &msgp->hdr, fds, size);
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
+                                               struct vfio_region_info *info,
+                                               int *fd)
+{
+    VFIOUserFDs fds = { 0, 1, fd};
+    int ret;
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+/*
+ * Socket-based io_ops
+ */
+VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .get_region_info = vfio_user_device_io_get_region_info,
+};
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 391864412c..3dfbc33c52 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -14,6 +14,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
@@ -92,11 +93,21 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
 
     vbasedev->name = g_strdup_printf("VFIO user <%s>", udev->sock_name);
 
+    /*
+     * Use socket-based device I/O instead of vfio kernel driver.
+     */
+    vbasedev->io_ops = &vfio_user_device_io_ops_sock;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
     vbasedev->mdev = true;
 
+    /*
+     * Enable per-region fds.
+     */
+    vbasedev->use_region_fds = true;
+
     as = pci_device_iommu_address_space(pdev);
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index 6b06a3ed82..1860430301 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -7,3 +7,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-- 
2.43.0


