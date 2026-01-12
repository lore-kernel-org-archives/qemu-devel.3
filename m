Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07171C9EC78
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 11:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfG9d-0002xO-9Q; Mon, 12 Jan 2026 06:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vfG9V-0002v6-CS
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:32:06 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1vfG9T-0002Jg-CH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 06:32:05 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60C9FUiJ2142740; Mon, 12 Jan 2026 03:32:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=L9yi1pQqUMZrqvYb89KgIKzE6gat+2ZHQ1oo8uvys
 ws=; b=ks5PIi+6PnBtsSKMnk9MG6yCj+Pu2wdAdAUo0D2o2mDS1AsXDZjkb1aXg
 OLN3wl9nFJIpcfYDku6Wug8HavyMZ60e4/9OnlhCvVQsjiGxG/nLrHqvLjDdFe4h
 PQ6QqpcYyCH/kIqo9l62DcyXZLI8Anh43QWw3EumTS/xcU3DCRFdAw1tSZgw/b+p
 UI+CUw0NYyvve/Zi0CJRK+5/JfeznZi3q8O5c2VbQqjEybeFkiIl4l9YlDL1HJow
 hLzPxfekqiRriOHs2OtS+bWzqvkGxG3G7z+MKK0etggE7VODMc51hcZAnWZFcgUI
 L3qKlBCY0LV5OsEwbqzXZOt57h7Ug==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021126.outbound.protection.outlook.com [52.101.62.126])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4bkpqgk4u3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Jan 2026 03:32:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uO8yHMAnKsaJPYusRp5u4cJeuGAmElu/TuOiYJfxUkr+KPi9pbdoFPMfcNS8nzfT4D0gPOD0Xoe2BX/d1XX+M7Dq0AjOt3BSxZnqAja5Ypb+6DFieoZqCejZ25ihmnJRhG/fiGufiSjoMHJbvZ31dHHUlTpB30I1C/q4cWaet5+Pbpw0QduwWwGajGuXIpxyWDYnOydz+Z2Mo/uSMQhFipaMmO9MDOdkfYWY7e5IybSqKTtZeHt1ifUJZ21zRb52SY67s8uez/rhPQM+0L3J4C/88pzPxMzE4pEtm6InYYz4Y9GR2tcNhY84phdPC6VhqCv/SMuoZJZROuNgXStCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9yi1pQqUMZrqvYb89KgIKzE6gat+2ZHQ1oo8uvysws=;
 b=NNcf4hq7CiCJRigzFy/MdT1Mb6T3/x/jOKzWXIcXEILdiAcgqgnlEv9nXp1YPoge3IdXC4ALNzn/mxcjfLNRL/N3bXojHVU3ohMUtvdIR9tShlH/EKSfp/xCQ22Zq7MBCszcdL2Wo8amECASCZPHNmy2hoiEUM9YNt3Jrn1balYF9ONfhYbnMWG/LRHfKOjcjXIyaeIGDJStduBjQlAI4QxPJIHHpUPg8ye6e5+kCJhQVe50YSW2syl2vJlzjFhP56v5GTDn11z6dM2cu9QmAlHQAnHcGlFkS0acu4t1sM3VcBQ+IihbIEgCUAW3/loHAOaGNFHGv9IsWv2TyfGobw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9yi1pQqUMZrqvYb89KgIKzE6gat+2ZHQ1oo8uvysws=;
 b=f1/QW3U+ixEh4jXbql9fvR0f4eq1KB/4qVUX717CI1483ZSAJbdtjtKPawXnmtOwLyA9z0F1h9imot85GECeRt3PMFt+KaUt956E8blUY9c3xvnHsOKJ9PLFZf9n+paWowzyrKkoF1Eutj8WAoW4g0HNNyErHMgNE3pDilpf2shYIBkv4LKaJoHhXN/hyW5OBTP9ZZQY/gVneplg+fc6gncHeSYwFA4KQF0FX1iLeqw6jCuDhOCfcZj8pjcIuocyVQs4Nknbhu3iiW24qj4LZIts+ySQfywXhuN5XcN4SeRv0exVyDzRn0HIv3YZ+iBgiw2ZY/G+h2gNtrIVNHQNqw==
Received: from PH7PR02MB9992.namprd02.prod.outlook.com (2603:10b6:510:2f5::16)
 by DM8PR02MB8071.namprd02.prod.outlook.com (2603:10b6:8:18::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 11:32:00 +0000
Received: from PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1]) by PH7PR02MB9992.namprd02.prod.outlook.com
 ([fe80::e2e9:fa4e:10d7:f7c1%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:32:00 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Florian Schmidt <flosch@nutanix.com>
Subject: [RFC PATCH 1/2] Add HvExtCallQueryCapabilities
Date: Mon, 12 Jan 2026 11:31:37 +0000
Message-ID: <20260112113139.3762156-2-flosch@nutanix.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112113139.3762156-1-flosch@nutanix.com>
References: <20260112113139.3762156-1-flosch@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0022.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::14) To PH7PR02MB9992.namprd02.prod.outlook.com
 (2603:10b6:510:2f5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR02MB9992:EE_|DM8PR02MB8071:EE_
X-MS-Office365-Filtering-Correlation-Id: e6a3c844-ced3-4b37-b74a-08de51ce334a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nx1O1+bYQP5h1CcNU4rBYFjAJc5hVacljHnZdpuXzYHcy+QjMntrO3y/9iNR?=
 =?us-ascii?Q?OeDEX/d6PVOqAwDAyIplZPukkLN/9mKcFhrr6hdievtVgv+UDASSDaoWG0CR?=
 =?us-ascii?Q?rtaNIgsekwVG31hfMshYnrCkz0RFgIYR4hkooyijYxaXjFv6zhSvdU2/7JfB?=
 =?us-ascii?Q?AjNjW3tbLbeIB4tylfTYPaqM5ypyuw00bVhivF06n0AJT6F7dVwEzYugo8PN?=
 =?us-ascii?Q?b31+Klp6hEVJaoR5pzerMGKNP7s7eKI3qlL7XTJ64ObWBVK5nJPliCnSMq1d?=
 =?us-ascii?Q?hs2BljwmC3fIqSCag/ad7QHrrfIeDYKkTOlyhwNtyT8ocXXUO0N2hWwLll4F?=
 =?us-ascii?Q?104ANrJN7RDrM2F+c60/a5ZFC++gVx5r2S4Iodc3XJNmeW5eBKN7On2QDl5X?=
 =?us-ascii?Q?Hy/THmxzNvcK/egyERYpIeyQ/NRZifV2IA9klfiblEUhmV7lxuguprsghPCd?=
 =?us-ascii?Q?MHaWLuuPToYLghx7wSbWjWUMpZqa25/NWYrD96sEA7wOtitnjJuaEK4Kx/zV?=
 =?us-ascii?Q?ykz2P9LlO8dmkijqX9V6PtPQdMOfIiKcprc7HBdDA9ZC2RzRXBQGekwopKB+?=
 =?us-ascii?Q?ZT4T2lqGl71kqXg+xCOKAt+dEyneGtsqeR+AHzNe5SF8ERak0wIZzUTJbPXV?=
 =?us-ascii?Q?h8LRRjpb2Y22ocer5Vn754oZrYBFa/gGn6is5b8eivv0mPdA396u0qLk8utG?=
 =?us-ascii?Q?DTPcQeH1Hh7D33bNJ19uRJFK5TnRm5ZysZYvZ/W9bCXRpGaaiYDqoOIP+Kq+?=
 =?us-ascii?Q?xtSF0zZxVtlrJFC1/opdt+xZSU7s6Sy+aEY+Dila5MY1ByjLm4syRvSv6Um9?=
 =?us-ascii?Q?A5cndgEZmgL4FXPmHt2XSed2VReNkl3lukJ06Hx75LC/WTowyTbEaVtBjzau?=
 =?us-ascii?Q?W6aCbR+IAT8ZLg7uhR9StUfWW/+sy+szSJUStPDIXjPybLIijPrXtR2+mFYJ?=
 =?us-ascii?Q?I0s8UFZjQGl2jYR/imwDwrSwj9cYM1H/wwcpXRSjJ0yCYJCfjUPNuJt9Pndi?=
 =?us-ascii?Q?fc79vjhu207MqnN+ABKojEztUyJJgVZEsE5MZ6AufDLgSHhFBQZf+ghJ82v0?=
 =?us-ascii?Q?wgBJVXZJPqDpJoKzD6yDJkE17FkfzD4gZC6r1PbHZHWT6Jn6rkANWiUaqa+V?=
 =?us-ascii?Q?+p29671Q7d6FVqwVKeEbXt21XRN5xBFZzitHioybjN4EFl68jhjgPlouuFfF?=
 =?us-ascii?Q?PbpkAMfsVw8G2A3uRt3HYKZ43V8KQ3LL0+LL3i1dOxBFqCIibfpfR0FWYud1?=
 =?us-ascii?Q?8VZW/SUjtuguKHP92bb8z9sJCqbGtRFSxKGKlHs2DmUIL3spx7/wDnIaBGcb?=
 =?us-ascii?Q?UV8agFLt2QQqxYGnnftvjl8kwVZswarNoGkD8ohbwkw4WemFYElHIRJZCXTH?=
 =?us-ascii?Q?Zz+4kzXnG24KNNPjjSJ7cr9rkP2sWazVgoz+UZIMGda+i+ndzw+v4eVR+2S4?=
 =?us-ascii?Q?67GiFCQmWmZeDxGutb6JSop2jAiEmK3dRDVw1a4UCpt+Y19Kq4ed7S40ns5V?=
 =?us-ascii?Q?h0fPsnr7BXZJPkWtn/DXumWf2Hh+IVvyTuZA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR02MB9992.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ExU1YavSKwZg5P/Kvzu5ov0oXE67+bquRo2nSeYcK2WMiItSmskxWbpFh/F4?=
 =?us-ascii?Q?69P3K0XN2uTCy72NFSYvT2prVzifUgDACTBGYCkgOVL62SLbQH5MIuftoqIx?=
 =?us-ascii?Q?hAlF/nX8zNeEwAU8N5kXbAQADlY0okoih5pO/kkIWKwLJc057olGvSYmogtP?=
 =?us-ascii?Q?mapLD4l8CTsWCul0jeAufOChiF35/c2mNHa1aPF35d53R20SHPYhlIOum7aq?=
 =?us-ascii?Q?el6RGm67Rj889jy23kqpvjd5Q7cfi0mxgdteRv1Rf6vstFlYqvCG6k5A7HYG?=
 =?us-ascii?Q?PDmZ/aKBw8lJlOYzBuZ2VgDIRzgHgVBdS5B0kVNAtxYviSMwPWIv8LMcsb+x?=
 =?us-ascii?Q?vJA13x/owm3S5DEyJ/YYWKU6462ptwfo4FQNcwFm0tTiL6XZlhktJri5fcgA?=
 =?us-ascii?Q?2u/1H7yrtqgRx5/e84D0jg06MqWunbJrDm33hfrc404knO7KbudpDi0Z8nWk?=
 =?us-ascii?Q?bT4507HD4Lw9cJsBVOgUxlaiIcRfsz0zwjwLYEVNgltOyt8ipvOvLR8hR/m8?=
 =?us-ascii?Q?Ra9HUbGYfdYp+5dnoR28NqM8K2tZummM/Nzo7X+PhbbOUhEm4KimGYK37auZ?=
 =?us-ascii?Q?vjfSh7e0rUTbjuAmQk/nYoR7IDTXelS3n8tzukkUavThPR43aXjosPgz5DM0?=
 =?us-ascii?Q?Vc5GEXMh9jV2M/eomyqfZef05RDdYCVHZT0amxloV5VkBd0jsPckZJ/z9026?=
 =?us-ascii?Q?hTrTHHaHqMJjvRJdoRXjxTO16s8K5puC0MDM32eT3aivR6XWzYsJEXfknw5m?=
 =?us-ascii?Q?MjPFhI0SFk2rAjpRV64MDEAfZ5bI1nFS1qz+uOXvvZkb/Yy09V4Dk5TRNeFK?=
 =?us-ascii?Q?KVAWQ8E0mJNnhtqIT9jJCmkhANB7/KOvnOfQNv5lwEnC8clJU+7J4CiTOGZt?=
 =?us-ascii?Q?+0z+hrtsvY/vjYk2Gk75ozuPCcoCOq9kE/CNkSeG+6Cpg+iycM7WxmJ/ZtRF?=
 =?us-ascii?Q?D+P+12B+GdA2pPHlz3Cje426P6hh+iVQnPXl0fhlqxTAtxrvH4bJ+5DSb4EQ?=
 =?us-ascii?Q?lkA5sZlQ8VPfPTJkk/Gzm+Jvjkq4eE9Ehk2gtfrAat/0yLYqcvPD4ZVQkM3P?=
 =?us-ascii?Q?EtTX9hxyJN5ZX2T9Tn24E4XHimERkfIzbOb5KJpB7rlDPvDpc9bB67/9x4pU?=
 =?us-ascii?Q?twBqRHrDq9pGy+haQnslrs0048X/MGb87xXGgC4fs9S+/NOGxBb6tTalcvG6?=
 =?us-ascii?Q?vfHi7WxmeHVxfCwfZzsq/HWlHkwwsWy/d/JB30wjfjG5uapz9hn7CN9s5mjL?=
 =?us-ascii?Q?ej07ssjG9qely1cgecgGuUR2wBXs1/MmkEwa0Ju0oAXLARhQ83LzIsWiIqI9?=
 =?us-ascii?Q?UtQfUjlDKK9en+y+nGua8uhzejcSSGMMYIATxmKlB2mogGeHkT+kogWmRiuO?=
 =?us-ascii?Q?GEU/YeGt5Rcq87Q/Ae0kHEVUs8mgabykqEqdYqs9Wyg5bYi9Dc2i/v0acyMF?=
 =?us-ascii?Q?/tVlrMO9sgNoqeME7wLAJIgPUabjmV80t4L3Pea1La9cEKkP3MwABuBcoGqH?=
 =?us-ascii?Q?fbEUBCzxefNHkte2QajV4ot5m9ONhmxxC/UTphlVFPElMClxBplCs2IAhty6?=
 =?us-ascii?Q?6HrBxaYcux6SYY8M9NCyxa45294DXDZklipGvO7tVOlc1K8yhYPpaW9q8O2c?=
 =?us-ascii?Q?5MxzxuvgaxJJNmv2pymUWw5yIns4O9QimF0tv6bJf2/dmf9OOe92GhPhNk5o?=
 =?us-ascii?Q?R0kBNk5wWdjJx9ojYhu+bZZdglAKobZczLdsAb3sI3xdGzVZR8JuN2jS8I9R?=
 =?us-ascii?Q?ZVRqUmPNEbBnx10uI4gVm4E66ci+g+w=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a3c844-ced3-4b37-b74a-08de51ce334a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR02MB9992.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:31:59.9621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwIGyejMsxl0ROLdoSeZtUx1wmt8T4UFr6XST98tBCsKjTz8SODEEYS7524GZpl9/jh8P2hlySBlhGl/X4eP4FqkYddnEjfU6k8WBOkcnYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA5MSBTYWx0ZWRfXyb+SKYl74OuY
 LJCr1MEt2ZnF+Fov2SSlncGWUqhA5cLr6J1wMlBPzFQ1sNY7j4O6KU8kJklVvT5GAvmf4ju3myM
 XZqfIXW97Au4QFH0bvEA33XeqFLIWbl34DskNQScoYU9bo7APB33E7Dfso6W7/zRmd5lIPBZ+Q3
 vrdCFfq65A4jeP65aQCJs3CvNsX+vszQyrfwtc+9CUxSMb5X+mL9Qd6ds8MjEYORO5ecdKlke7/
 BMe/4A1oHBkr0YtN/xKP3t5aV0zPNVSv9yPqIBbad9NPdKTPTAA7Brq0T+GgeHLF87TvdjV+7QS
 aAGfIDjNcro3vPI9ybE879KmmqfbDk4WCKhklE7xRdltRA74rpjFrgeD4zK2cSkWbkuuuN/ZtZ5
 F9iLbD1FHJQlhcwiVucgU3azrnff0kPRuYai7klmJ5YEx0p0WnsUDSQwwZSnub90ezbzlhEWu3u
 7/0eBpHhBRrGIO9tPbQ==
X-Proofpoint-GUID: Lb-McQRejPRn02vWRR99G7GY-XstCyES
X-Authority-Analysis: v=2.4 cv=TKpIilla c=1 sm=1 tr=0 ts=6964dbb1 cx=c_pps
 a=5b8Bh1zS2Xw7e9bM89c5zw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=gL5P_E_7iFiinnyR3ZwA:9
X-Proofpoint-ORIG-GUID: Lb-McQRejPRn02vWRR99G7GY-XstCyES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On CPUID leaf 0x40000003, EBX bit 20 signals that we support
the HvExtCallQueryCapabilities hypercall. This returns a bit field which
signals which further extended hypercalls are supported (as a way to
conserve CPUID leaf bits).

For now, we don't support any extended hypercalls, but we'll add
HvExtCallGetBootZeroedMemory in a followup patch.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
---
 hw/hyperv/hyperv.c               | 28 ++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  1 +
 include/hw/hyperv/hyperv.h       |  5 +++++
 target/i386/kvm/hyperv-proto.h   |  1 +
 target/i386/kvm/hyperv.c         | 14 ++++++++++++++
 target/i386/kvm/kvm.c            |  3 +++
 6 files changed, 52 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 27e323a819..13a42a68b2 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -699,6 +699,34 @@ int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
     return set_event_flag_handler(conn_id, notifier);
 }
 
+uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast)
+{
+    uint16_t ret;
+    uint64_t *supported = NULL;
+    hwaddr len;
+
+    if (fast) {
+        ret = HV_STATUS_INVALID_HYPERCALL_CODE;
+        goto cleanup;
+    }
+
+    len = sizeof(*supported);
+    supported = cpu_physical_memory_map(outgpa, &len, 1);
+    if (!supported || len < sizeof(*supported)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto cleanup;
+    }
+
+    *supported = sup;
+    ret = HV_STATUS_SUCCESS;
+
+cleanup:
+    if (supported) {
+        cpu_physical_memory_unmap(supported, sizeof(*supported), 1, len);
+    }
+    return ret;
+}
+
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
     EventFlagHandler *handler;
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index fffc5ce342..f1d1d2eb26 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -35,6 +35,7 @@
 #define HV_POST_DEBUG_DATA                    0x0069
 #define HV_RETRIEVE_DEBUG_DATA                0x006a
 #define HV_RESET_DEBUG_SESSION                0x006b
+#define HV_EXT_CALL_QUERY_CAPABILITIES        0x8001
 #define HV_HYPERCALL_FAST                     (1u << 16)
 
 /*
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 63a8b65278..921e1623f7 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -96,6 +96,11 @@ uint16_t hyperv_hcall_retreive_dbg_data(uint64_t ingpa, uint64_t outgpa,
  */
 uint16_t hyperv_hcall_post_dbg_data(uint64_t ingpa, uint64_t outgpa, bool fast);
 
+/*
+ * Process HVCALL_EXT_QUERY_CAPABILITIES hypercall.
+ */
+uint16_t hyperv_ext_hcall_query_caps(uint64_t sup, uint64_t outgpa, bool fast);
+
 uint32_t hyperv_syndbg_send(uint64_t ingpa, uint32_t count);
 uint32_t hyperv_syndbg_recv(uint64_t ingpa, uint32_t count);
 void hyperv_syndbg_set_pending_page(uint64_t ingpa);
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index a9f056f2f3..4eb2955ac5 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -46,6 +46,7 @@
  */
 #define HV_POST_MESSAGES             (1u << 4)
 #define HV_SIGNAL_EVENTS             (1u << 5)
+#define HV_ENABLE_EXT_HYPERCALLS     (1u << 20)
 
 /*
  * HV_CPUID_FEATURES.EDX bits
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index f7a81bd270..1ac5c26799 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -51,6 +51,15 @@ static void async_synic_update(CPUState *cs, run_on_cpu_data data)
     bql_unlock();
 }
 
+static uint64_t calc_supported_ext_hypercalls(X86CPU *cpu)
+{
+    uint64_t ret = 0;
+
+    /* For now, no extended hypercalls are supported. */
+
+    return ret;
+}
+
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
@@ -108,6 +117,11 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
             exit->u.hcall.result =
                 hyperv_hcall_reset_dbg_session(out_param);
             break;
+        case HV_EXT_CALL_QUERY_CAPABILITIES:
+            exit->u.hcall.result =
+                hyperv_ext_hcall_query_caps(calc_supported_ext_hypercalls(cpu),
+                                            out_param, fast);
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
         }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7b9b740a8e..5d8553ef0c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1594,6 +1594,9 @@ static int hyperv_fill_cpuids(CPUState *cs,
     /* Unconditionally required with any Hyper-V enlightenment */
     c->eax |= HV_HYPERCALL_AVAILABLE;
 
+    /* No reason to not always support HvExtCallQueryCapabilities (?) */
+    c->ebx |= HV_ENABLE_EXT_HYPERCALLS;
+
     /* SynIC and Vmbus devices require messages/signals hypercalls */
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC) &&
         !cpu->hyperv_synic_kvm_only) {
-- 
2.39.5


