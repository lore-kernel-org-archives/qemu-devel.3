Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D62CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqp5m-0003IU-GT; Tue, 26 Aug 2025 04:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5V-0003Gl-TZ
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uqp5K-0007W3-6r
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:31:28 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57Q4mUBh052654; Tue, 26 Aug 2025 01:31:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YF3Hsb+jjK8ynrqHB+yugg947jpgbObP7CVyCp/Y6
 sI=; b=D7XSqqLdVunCPBswRVgLymmVTEfRnN9/tGw/9nlWuasng5TgRKEgYPC9U
 akqG4gibcKJW3TXMY6vHqTjO8Pbk3M6X2b6myHxuya/ZV0b7Cyf6E7eyzJpHV181
 ZxZAPt+Ttd3862FNkNPa//M2eV+Tav0C6uUiF/eqk0XisSkNZ75shSK7U4+bk5cz
 8VoWjMNwhm7C2xTYEekWekINa60cSUcXMdiEYEGBwuTu+as6fGo6Ek8wBbr67sF4
 G7wobrhG1nBBw3pxg4d1sH5iEGImFAH5nOWteR1q+5W5YZxi+GMRKn5gIbx9xeWu
 QQqLKko9gVh9+/+0Q6OJMNB7147tw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2094.outbound.protection.outlook.com [40.107.100.94])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48rub1sujk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 26 Aug 2025 01:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veZBKEyCfV2ohlwdl4vOqyt613SMt80EV03BQe/GHgoCv6s6ZynTmatzEaq3pG2tzytSxsvenGtlQ2N9V4TVAdTQA8jXyd4N/3d7gtIJjh3ZlKRKudPAWlNkp3LohRRoov2w4X/M2dqemGw8P/YTciCSS8AUThDsDIt1DHED25FgbzqCV9LtYvOExdIn57cm83tdKmKoK/n8V0W6V+lNEeJ1ptWdGYFb3ZdUd1zp3kow8BU1KJHzsFXF7nFULn9FPpHaSRq9R11x6977AJYPlcCrvoo4vcOKvAZpc9qvmOT9T4Qi+/6dfUfuUI09cyGycTM6/Y7NdW5h8ULb1e91Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF3Hsb+jjK8ynrqHB+yugg947jpgbObP7CVyCp/Y6sI=;
 b=kWmuLOmIgexWG5WF1i4WrN4SuNWBJEPB1mhpesqDOEkEt/AFniyMLfroxEImohFNxDXWi0nZzY+WWDD7GyLhVNZWnGSCXin/MeNz7qH8PzSXpNhpWAINa43uaZxvF1Ipt9vyUo0IOKZJ76FiIXIfLFZumYZZJQV3747q1qGH6VyE4axlPLJ/DhJjVXxmdxXU5XapvavtTk+qNqnbUeGXID773dRbzwsqO/D3esG80V6AB8jJdFA62WhTGyAeNjqjTGcLRF0ynHfjp3TK/H+OpjtWyCYL2WkO/LEqxhXRpIiCNsMFTHfA1yteFZvUpM0JJAnLtxCALoIPsMKjUakCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF3Hsb+jjK8ynrqHB+yugg947jpgbObP7CVyCp/Y6sI=;
 b=Ojhcq+5zYqSRXNG1U7wXKw4y7Kh3hWvSawKWYuNKgZhC64T+fRdWYq1d7YmrCvw0mhGRlCW2NbPEgg4Fv/bp2tyZ76bSnICtgQAe+hq7r5uaF+sQzxnrqrrKNWS0Xn+0LKavfUuEMwSywCps2DzmS/H2KOEHMTAqBnqZ4VGdCpz+eQ5eS02xpB4u0OMuQyo5hO+e1+nrbmgiq4Clrk4Bj23WfqzGlcKxpGh8gpB7PyQ7IkNT5hNh4YgDvAQJ2IDVxp4LSAeLluJNsOFipEfrHwx5dIAIYGbaU6k8YWjJW8OMMUpeeuSbRn1EzLoR6SmaiYszsfcYeajnqdq7Sdxt/Q==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA0PR02MB7404.namprd02.prod.outlook.com (2603:10b6:806:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 08:31:09 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9052.021; Tue, 26 Aug 2025
 08:31:09 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH v2 3/3] tests/functional: add a vfio-user smoke test
Date: Tue, 26 Aug 2025 09:31:00 +0100
Message-ID: <20250826083100.1058305-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826083100.1058305-1-john.levon@nutanix.com>
References: <20250826083100.1058305-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0016.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::11) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA0PR02MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 50b9aaca-c999-4344-9f6e-08dde47ae889
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AZUovSRy7Z+3hrB06pY196j7T/DdACm4QsJsUL0+NVY2FK3voeaYKv/AFk1s?=
 =?us-ascii?Q?ETquwlSOVheXtCyW2mZuZnq2ngJIaQ5Ht+qGVX9JJDFawNAuI0eK6n2PaltS?=
 =?us-ascii?Q?QwoUvOCTFAA8QVu0hgNtjyaJDHiYXu8En/0677dgZbPG+b0/gQLzarCOQvVz?=
 =?us-ascii?Q?rssIfFMq8eN6NfSyeQwZvRWOA8UaiibE6upzmlYQvp8pif6LMSnn7xIJimuh?=
 =?us-ascii?Q?VCZTlT5pLXvHOetG6i8SHi1yHkkrm938WGFF3qaMsluUivaWjI9V1F4+irjd?=
 =?us-ascii?Q?8qT5BrCY28uMGtb/nr1iXGor+jL4lWkn25WNrE6irZSCeDQ6nysGjYMDuHw1?=
 =?us-ascii?Q?L2YFH7eqDnju58ShXduSUqiHO0NQWB6U1259iDAvUMzcvMexGWq5wdq3qrWy?=
 =?us-ascii?Q?cwJIj1IwKqBOTA8PJKJX7eXn4NMfq8dwuslz95zqLmBeUx/WGzmJ7wC19SQc?=
 =?us-ascii?Q?WBA1WJ4YJn2H7BRK0dHqPzm3qo0Vr+jYZjaJbRxCLGsLUgpVbxdlXOiMCZnm?=
 =?us-ascii?Q?Ohe2sWYO5BJ14pEWInJB9hIjZHSTR7ZZyr3z7Wtkmr7Ou/9HATzytKRZak/T?=
 =?us-ascii?Q?Nmr27zmNPtz/V5NATEfiPviirS/DpHfEnmyECo5ZV+/FabWZszrozYWgBiTq?=
 =?us-ascii?Q?QIQ5przFhvFVpXwGjdzYX3DD1DoAvNui47ZDJZj7V+503X+6WK96v56QxXKW?=
 =?us-ascii?Q?dIQ/bMgECqnThXB8nwjSf/sJpb7LuHlbp6iCJcqv3nErATVXlM7k/n1lNijE?=
 =?us-ascii?Q?dVwQYuDKvvMqhcZ90z+AGSMLiX+Na35nho8b1IkwawxXI2TwvFkpKNWhdwPo?=
 =?us-ascii?Q?cuShOotVM9DqKVhLN+1YRtJamMfack8i4Hkfxvb76Zcgr/vEtQeWxWLOHTwU?=
 =?us-ascii?Q?Wo9zDlUNRSaXYCB6d1vsMOebS10BaerwSMm7kcopOelk0aiMk0t6Z9RdTb7k?=
 =?us-ascii?Q?ZuONnUFydjU5K8yhocKVjAOCU+B6CvA7dfsoltRD4hQUtx1XFeDjCzZk0vSK?=
 =?us-ascii?Q?EWYQFXehVz0DbEwi2NnKKW3age73cW/dlqSJRaeJFjPyoNhWVMm5/mVV686e?=
 =?us-ascii?Q?7RQsTYQW4T3U+H26uWIXYaeqfSCJehW6471/FMJXwqH0hipJdYDXHXmg1Ca6?=
 =?us-ascii?Q?bPZLsQueKFoO82maNueRAFhk6GJVGLxv2pGOK7tzm5BtcS4JepdWoBkODKkQ?=
 =?us-ascii?Q?AbrjroKcqxT+VnV5ywL8JFTawcdTduYAo1XsdPZrzL19NeMumPRQcaNvj0ul?=
 =?us-ascii?Q?6kYqG0BYH13xzOdHKNqMu4vU9ivRZWIkgHaWh/XF/h9DeEtP0uf1p+01L07Z?=
 =?us-ascii?Q?VfjWzdX500B1A/9gmQ5lNaHa2doS0aDXaHA9PTQBCkFx8QBsFqIVursO0oOU?=
 =?us-ascii?Q?lJPJu40OXOW3pWG4T295ZCmDv0Qr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vIBUQC+lnGyiXfdsx/naGCTLp5hj5PBz+26cfkPSem92W2OK0YYFkjm1NGc5?=
 =?us-ascii?Q?1qQWoKJNlji4sAoV4PmZ76kj0WuZvXAfYbLEEoRsYfOQxAFJ53ysw7HFMAhc?=
 =?us-ascii?Q?xv3xUxQ9965Ip0XvZTGXfOReaywJOe0rmlXsZstF5bigpF7lvBlyaAn80LHr?=
 =?us-ascii?Q?+wDZ66sDWtZNFlRaOFo4a+sg+nZJAktLMh37fBfEEXz47G7zGO00mzdub7Ka?=
 =?us-ascii?Q?owdDqOqgesVtgT9BNv1VKk/S6m+BYuvtxlDZMZSpQ63mjeOJxjHwqu4+s/dM?=
 =?us-ascii?Q?Vs2CWFreBoPCr8RS7uq8Z5fBKodjDkhvLgZEIu9lGjVIajVBJix1p+LMXnNJ?=
 =?us-ascii?Q?Z25H0azW5i64851EVCm2g9xgK3GR0YF6nF1MMcwEmkh9VUiF+F67cepBApF8?=
 =?us-ascii?Q?AurM6txdzpuWi8QwIhKAs1Y2o7UMX3oDHjO2WfEcVPiMGY6IyFRNW+DBaNQx?=
 =?us-ascii?Q?fYBAq3ToD0wfjsjQsqSroGC2F9dtUDgF1mfnWa9MTO2yr00lM87RTtD5l5TY?=
 =?us-ascii?Q?DMhTGjKs8u5FpOO91WgqRhBs0HcI5897NT+1i5sxYesBqNol625EF2aZe18s?=
 =?us-ascii?Q?tsiT3foisabv1JwzAL0H5uh3jNaCZqwY+szL+3c76CZiKr7zOfH8/KzvaY6J?=
 =?us-ascii?Q?uywszbKHxdWGLhEg21GKF9FbRaklNvio/UcyIElGyaPsRT8UlA8TH2JAO6n5?=
 =?us-ascii?Q?byLG6sNkKby4DpuhS++LrqdsdojFA3b6JU/xC8P4Oi1GrqNneyUXMLyEJPSM?=
 =?us-ascii?Q?btWPqfJLMmDtm5Ml3euLp+X47lr7iSIRehq1HqgNq83/1Czr41J5DEdy3v+H?=
 =?us-ascii?Q?QP7etWszh+VKbQkBtfIlfFQ++bg0poSPowIrDUnS3gTSse+3jC2253N7G/Ex?=
 =?us-ascii?Q?cCe8hlbBdpqYQEabb+N2STRWRUPFtxphtoB3QDMKi+9VqtQIIYuV+dwdKUAg?=
 =?us-ascii?Q?XxMVguQUcin6aT4Rqydx4fdqEUwL8t6Yub3EaPZ9Y+TaH4Ls1vnDuROAyDA4?=
 =?us-ascii?Q?bmVszPoKkb/0gS6y0eNiCjyjTtGIedInuRMeRE3i7GimVmEmbxJDzHTO1Acm?=
 =?us-ascii?Q?KMrdz9M7lsyZuAqgAEFUJx/QZaAmohuhk9L1Klya08myG0NNj3wln5Oi+u5i?=
 =?us-ascii?Q?bg+zGxRMrWslsDAAiASsbwH0fdnOR7QzE/hFkINZyNaD0ufLoIQULdXJ1qFI?=
 =?us-ascii?Q?5MYJl6TRXg3DV2PJVP01XXOZQ+tXAGcPc3PGjBVt9Vn4RX1AsXRO8bB0Z1Pn?=
 =?us-ascii?Q?iq1LlAdgmD/db4Z/PiC7r6okxQYpr1dawepmLnXFqIvq1YZGL+mUqwdAfZM2?=
 =?us-ascii?Q?gcErlo1X3W3UkTHBYQyo758Lhx/+wJIDms/BYxUsSv6bcYDtKG5ryEbnvxgb?=
 =?us-ascii?Q?DXV/+8A6XzHOfaVTDrRg4IerABJpjzVouoiH18bd+0RxIlY3rao4I86ZE8GV?=
 =?us-ascii?Q?0+OPUngSOi5NC9ZhT9UBG3PTlzLEeuHpyQZwQdoc7CdT14dGcTEcApv0bcXr?=
 =?us-ascii?Q?wMOTRTKIqin6ZlfG5Sm/wYmg52WGwvk9t4aT85lCiLUJ40ILtPnSyMA/SZBK?=
 =?us-ascii?Q?3hy0RmKsbPpVRXyygIWXnhL0xuoyyE5t3Nq4BfH2?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b9aaca-c999-4344-9f6e-08dde47ae889
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 08:31:09.7888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bc2aLzNb6TX+6xeLS0MjXmh+ETwI2S8R0/DBBPkz09D323X49C4rXMLCrwPcQsR3y8E28Z5GnpjYpM812+SEKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7404
X-Proofpoint-GUID: 7Pa2M4z_tbotDc3mfyOlWEQxg7Lhg9_9
X-Proofpoint-ORIG-GUID: 7Pa2M4z_tbotDc3mfyOlWEQxg7Lhg9_9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA3NSBTYWx0ZWRfX4ElKyhivDLw8
 d7nvG3b8n6002jCZmAREKHDpzVTzc5ZtT9GFeSrzKy+RQhnoiBE1AioO9T53yXXiacl1Qn3Jatg
 dqDwlq0otPd5OXyWkNfoKHpn0wLcfmwZfZWYI9ZHXNTUVYUuL86fWeeB3SZsackgcunz4RhgfbB
 Q5RAOu8K5wUT3Ly0Ab3Rs538EifzRtKpRihSAH8ryYxmmtIERcsuQWNBXPWt7c95lLTCmBtTwo/
 ueaUEUIGfjo3M91GX3+qz4ymHF8EyJqs4UjFiMh8IlvYqf/t7mGYUwz5zac4iANC+NfiSa5KfHc
 0mrCNGa4vHZ8cXhe1EILQfUBsHXeBUzadHIPrX6lSErJ4ZtTbrhQ7onjsaYet8=
X-Authority-Analysis: v=2.4 cv=UshjN/wB c=1 sm=1 tr=0 ts=68ad70cf cx=c_pps
 a=/yzx4YhCC6VIZAnMM+cFoA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=bGJ7yUH-iEoZGlg0rpsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Add a basic test of the vfio-user PCI client implementation.

Co-authored-by: John Levon <john.levon@nutanix.com>
Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 MAINTAINERS                               |   1 +
 tests/functional/meson.build              |   1 +
 tests/functional/test_vfio_user_client.py | 407 ++++++++++++++++++++++
 3 files changed, 409 insertions(+)
 create mode 100755 tests/functional/test_vfio_user_client.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a07086ed76..5627a05f87 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4298,6 +4298,7 @@ F: docs/system/devices/vfio-user.rst
 F: hw/vfio-user/*
 F: include/hw/vfio-user/*
 F: subprojects/libvfio-user
+F: tests/functional/test_vfio_user_client.py
 
 EBPF:
 M: Jason Wang <jasowang@redhat.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 311c6f1806..b786f5e5cf 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -334,6 +334,7 @@ tests_x86_64_system_thorough = [
   'linux_initrd',
   'multiprocess',
   'netdev_ethtool',
+  'vfio_user_client',
   'virtio_balloon',
   'virtio_gpu',
   'x86_64_hotplug_blk',
diff --git a/tests/functional/test_vfio_user_client.py b/tests/functional/test_vfio_user_client.py
new file mode 100755
index 0000000000..51676dbf8e
--- /dev/null
+++ b/tests/functional/test_vfio_user_client.py
@@ -0,0 +1,407 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2025 Nutanix, Inc.
+#
+# Author:
+#  Mark Cave-Ayland <mark.caveayland@nutanix.com>
+#  John Levon <john.levon@nutanix.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Check basic vfio-user-pci client functionality. The test starts two VMs:
+
+    - the server VM runs the libvfio-user "gpio" example server inside it,
+      piping vfio-user traffic between a local UNIX socket and a virtio-serial
+      port. On the host, the virtio-serial port is backed by a local socket.
+
+    - the client VM loads the gpio-pci-idio-16 kernel module, with the
+      vfio-user client connecting to the above local UNIX socket.
+
+This way, we don't depend on trying to run a vfio-user server on the host
+itself.
+
+Once both VMs are running, we run some basic configuration on the gpio device
+and verify that the server is logging the expected out. As this is consistent
+given the same VM images, we just do a simple direct comparison.
+"""
+
+import difflib
+import logging
+import os
+import re
+import select
+import shutil
+import socket
+import subprocess
+import time
+
+from qemu_test import Asset
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+EXPECTED_SERVER_OUT=\
+"""gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3
+gpio: adding DMA region [0xc0000, 0xe0000) offset=0 flags=0x1
+gpio: adding DMA region [0xe0000, 0x100000) offset=0 flags=0x1
+gpio: adding DMA region [0x100000, 0x8000000) offset=0 flags=0x3
+gpio: adding DMA region [0xfffc0000, 0x100000000) offset=0 flags=0x1
+gpio: devinfo flags 0x3, num_regions 9, num_irqs 5
+gpio: region_info[0] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[1] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[2] offset 0 flags 0x3 size 256 argsz 32
+gpio: region_info[3] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[4] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[5] offset 0 flags 0 size 0 argsz 32
+gpio: region_info[7] offset 0 flags 0x3 size 256 argsz 32
+gpio: region7: read 256 bytes at 0
+gpio: region7: read 0 from (0x30:4)
+gpio: write mask to EROM ignored
+gpio: region7: wrote 0xfffff800 to (0x30:4)
+gpio: region7: read 0 from (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: region7: read 0x1 from (0x18:4)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: disabling IRQ type INTx range [0, 1)
+gpio: disabling IRQ type ERR range [0, 1)
+gpio: disabling IRQ type INTx range [0, 1)
+gpio: region7: read 0 from (0x4:2)
+gpio: region7: wrote 0 to (0x4:2)
+gpio: device reset by client
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: disabling IRQ type INTx range [0, 1)
+gpio: region7: wrote 0 to (0x10:4)
+gpio: region7: wrote 0 to (0x14:4)
+gpio: BAR2 addr 0x0
+gpio: region7: wrote 0 to (0x18:4)
+gpio: region7: wrote 0 to (0x1c:4)
+gpio: region7: wrote 0 to (0x20:4)
+gpio: region7: wrote 0 to (0x24:4)
+gpio: removing DMA region [0, 0xc0000) flags=0
+gpio: removing DMA region [0xc0000, 0xe0000) flags=0
+gpio: removing DMA region [0xe0000, 0x100000) flags=0
+gpio: removing DMA region [0x100000, 0x8000000) flags=0
+gpio: adding DMA region [0, 0xd0000) offset=0 flags=0x3
+gpio: adding DMA region [0xd0000, 0xe0000) offset=0 flags=0x1
+gpio: adding DMA region [0xe0000, 0xf0000) offset=0 flags=0x1
+gpio: adding DMA region [0xf0000, 0x8000000) offset=0 flags=0x3
+gpio: removing DMA region [0, 0xd0000) flags=0
+gpio: removing DMA region [0xd0000, 0xe0000) flags=0
+gpio: removing DMA region [0xe0000, 0xf0000) flags=0
+gpio: removing DMA region [0xf0000, 0x8000000) flags=0
+gpio: adding DMA region [0, 0x8000000) offset=0 flags=0x3
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0xdc8494f from (0:4)
+gpio: region7: read 0 from (0x8:4)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: wrote 0xffffffff to (0x10:4)
+gpio: region7: wrote 0 to (0x10:4)
+gpio: region7: wrote 0xffffffff to (0x14:4)
+gpio: region7: wrote 0 to (0x14:4)
+gpio: BAR2 addr 0xffffffff
+gpio: region7: wrote 0xffffffff to (0x18:4)
+gpio: BAR2 addr 0x1
+gpio: region7: wrote 0x1 to (0x18:4)
+gpio: region7: wrote 0xffffffff to (0x1c:4)
+gpio: region7: wrote 0 to (0x1c:4)
+gpio: region7: wrote 0xffffffff to (0x20:4)
+gpio: region7: wrote 0 to (0x20:4)
+gpio: region7: wrote 0xffffffff to (0x24:4)
+gpio: region7: wrote 0 to (0x24:4)
+gpio: write mask to EROM ignored
+gpio: region7: wrote 0xfffff800 to (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: BAR2 addr 0xc000
+gpio: region7: wrote 0xc000 to (0x18:4)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: ILINE=b
+gpio: region7: wrote 0xb to (0x3c:1)
+gpio: region7: read 0 from (0x4:2)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: SERR# enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0xb from (0x3c:1)
+gpio: adding DMA region [0xfeb80000, 0xfebc0000) offset=0 flags=0x1
+gpio: removing DMA region [0xfeb80000, 0xfebc0000) flags=0
+gpio: EROM disable ignored
+gpio: region7: wrote 0xfffffffe to (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: removing DMA region [0, 0x8000000) flags=0
+gpio: adding DMA region [0, 0xc0000) offset=0 flags=0x3
+gpio: adding DMA region [0xc0000, 0xc1000) offset=0 flags=0x1
+gpio: adding DMA region [0xc1000, 0xc4000) offset=0 flags=0x3
+gpio: adding DMA region [0xc4000, 0xd0000) offset=0 flags=0x1
+gpio: adding DMA region [0xd0000, 0xf0000) offset=0 flags=0x3
+gpio: adding DMA region [0xf0000, 0x100000) offset=0 flags=0x1
+gpio: adding DMA region [0x100000, 0x8000000) offset=0 flags=0x3
+gpio: removing DMA region [0xc4000, 0xd0000) flags=0
+gpio: removing DMA region [0xd0000, 0xf0000) flags=0
+gpio: adding DMA region [0xc4000, 0xe8000) offset=0 flags=0x1
+gpio: adding DMA region [0xe8000, 0xf0000) offset=0 flags=0x3
+gpio: region7: read 0x494f from (0:2)
+gpio: region7: read 0xdc8 from (0x2:2)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0xdc8494f from (0:4)
+gpio: region7: read 0 from (0xe:1)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x8:4)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: INTx emulation disabled
+gpio: region7: wrote 0x503 to (0x4:2)
+gpio: region7: read 0x503 from (0x4:2)
+gpio: INTx emulation enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0xb from (0x3c:1)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x10:4)
+gpio: region7: wrote 0 to (0x10:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x14:4)
+gpio: region7: wrote 0 to (0x14:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: BAR2 addr 0xffffffff
+gpio: region7: wrote 0xffffffff to (0x18:4)
+gpio: BAR2 addr 0xc001
+gpio: region7: wrote 0xc001 to (0x18:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x1c:4)
+gpio: region7: wrote 0 to (0x1c:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x20:4)
+gpio: region7: wrote 0 to (0x20:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: region7: wrote 0xffffffff to (0x24:4)
+gpio: region7: wrote 0 to (0x24:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: I/O space disabled
+gpio: memory space disabled
+gpio: region7: wrote 0x100 to (0x4:2)
+gpio: write mask to EROM ignored
+gpio: region7: wrote 0xfffff800 to (0x30:4)
+gpio: cleared EROM
+gpio: region7: wrote 0 to (0x30:4)
+gpio: I/O space enabled
+gpio: memory space enabled
+gpio: region7: wrote 0x103 to (0x4:2)
+gpio: region7: read 0 from (0x2c:2)
+gpio: region7: read 0 from (0x2e:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0 from (0x6:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region7: read 0 from (0xc:1)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region7: read 0x1 from (0x3d:1)
+gpio: region7: read 0x103 from (0x4:2)
+gpio: region2: wrote 0 to (0x3:1)
+gpio: region2: wrote 0 to (0x2:1)
+gpio: region2: wrote 0 to (0x1:1)"""
+
+
+class VfioUserClient(QemuSystemTest):
+
+    ASSET_REPO = 'https://github.com/mcayland-ntx/libvfio-user-test'
+
+    ASSET_KERNEL = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/bzImage',
+        '40292fa6ce95d516e26bccf5974e138d0db65a6de0bc540cabae060fe9dea605'
+    )
+
+    ASSET_ROOTFS = Asset(
+        f'{ASSET_REPO}/raw/refs/heads/main/images/rootfs.ext2',
+        'e1e3abae8aebb8e6e77f08b1c531caeacf46250c94c815655c6bbea59fc3d1c1'
+    )
+
+
+    def prepare_images(self):
+        """Set up the images for the VMs."""
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.server_rootfs_path = self.scratch_file('server.ext2')
+        shutil.copy(rootfs_path, self.server_rootfs_path)
+        os.chmod(self.server_rootfs_path, 0o600)
+        self.client_rootfs_path = self.scratch_file('client.ext2')
+        shutil.copy(rootfs_path, self.client_rootfs_path)
+        os.chmod(self.client_rootfs_path, 0o600)
+
+    def configure_server_vm_args(self, server_vm, sock_path):
+        """
+        Configuration for the server VM. Set up virtio-serial device backed by
+        the given socket path.
+        """
+        server_vm.add_args('-kernel', self.kernel_path)
+        server_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        server_vm.add_args('-drive',
+            f"file={self.server_rootfs_path},if=ide,format=raw,id=drv0")
+        server_vm.add_args('-snapshot')
+        server_vm.add_args('-chardev',
+            f"socket,id=sock0,path={sock_path},telnet=off,server=on,wait=off")
+        server_vm.add_args('-device', 'virtio-serial')
+        server_vm.add_args('-device',
+            'virtserialport,chardev=sock0,name=org.fedoraproject.port.0')
+
+    def configure_client_vm_args(self, client_vm, sock_path):
+        """
+        Configuration for the client VM. Point the vfio-user-pci device to the
+        socket path configured above.
+        """
+
+        client_vm.add_args('-kernel', self.kernel_path)
+        client_vm.add_args('-append', 'console=ttyS0 root=/dev/sda')
+        client_vm.add_args('-drive',
+            f'file={self.client_rootfs_path},if=ide,format=raw,id=drv0')
+        client_vm.add_args('-device',
+            '{"driver":"vfio-user-pci",' +
+            '"socket":{"path": "%s", "type": "unix"}}' % sock_path)
+
+    def setup_vfio_user_pci_server(self, server_vm):
+        """
+        Start the libvfio-user server within the server VM, and arrange
+        for data to shuttle between its socket and the virtio serial port.
+        """
+        wait_for_console_pattern(self, 'login:', None, server_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, server_vm)
+
+        exec_command_and_wait_for_pattern(self,
+            'gpio-pci-idio-16 -v /tmp/vfio-user.sock >/var/tmp/gpio.out 2>&1 &',
+            '#', None, server_vm)
+        # wait for libvfio-user to initialize properly
+        exec_command_and_wait_for_pattern(self, 'sleep 5', '#', None, server_vm)
+        exec_command_and_wait_for_pattern(self,
+            'socat UNIX-CONNECT:/tmp/vfio-user.sock /dev/vport0p1,ignoreeof ' +
+            ' &', '#', None, server_vm)
+
+    def test_vfio_user_pci(self):
+        self.prepare_images()
+        self.set_machine('pc')
+        self.require_device('virtio-serial')
+        self.require_device('vfio-user-pci')
+
+        sock_dir = self.socket_dir()
+        socket_path = sock_dir.name + '/vfio-user.sock'
+        socket_path = '/tmp/vfio-user.sock'
+
+        server_vm = self.get_vm(name='server')
+        server_vm.set_console()
+        self.configure_server_vm_args(server_vm, socket_path)
+
+        server_vm.launch()
+
+        self.log.debug('starting libvfio-user server')
+
+        self.setup_vfio_user_pci_server(server_vm)
+
+        client_vm = self.get_vm(name="client")
+        client_vm.set_console()
+        self.configure_client_vm_args(client_vm, socket_path)
+
+        try:
+            client_vm.launch()
+        except:
+            self.log.error('client VM failed to start, dumping server logs')
+            exec_command_and_wait_for_pattern(self, 'cat /var/tmp/gpio.out',
+                '#', None, server_vm)
+            raise
+
+        self.log.debug('waiting for client VM boot')
+
+        wait_for_console_pattern(self, 'login:', None, client_vm)
+        exec_command_and_wait_for_pattern(self, 'root', '#', None, client_vm)
+
+        #
+        # Here, we'd like to actually interact with the gpio device a little
+        # more as described at:
+        #
+        # https://github.com/nutanix/libvfio-user/blob/master/docs/qemu.md
+        #
+        # Unfortunately, the buildroot Linux kernel has some undiagnosed issue
+        # so we don't get /sys/class/gpio. Nonetheless just the basic
+        # initialization and setup is enough for basic testing of vfio-user.
+        #
+
+        self.log.debug('collecting libvfio-user server output')
+
+        out = exec_command_and_wait_for_pattern(self,
+            'cat /var/tmp/gpio.out',
+            'gpio: region2: wrote 0 to (0x1:1)',
+            None, server_vm)
+
+        pattern = re.compile(r'^gpio:')
+
+        gpio_server_out = [s for s in out.decode().splitlines()
+                                   if pattern.search(s)]
+
+        expected_server_out = EXPECTED_SERVER_OUT.splitlines()
+
+        if gpio_server_out != expected_server_out:
+            self.log.error('Server logs did not match:')
+            print("orig")
+            print(gpio_server_out)
+            print("second")
+            print(expected_server_out)
+            for line in difflib.unified_diff(expected_server_out,
+                                             gpio_server_out):
+                self.log.error(line)
+
+            self.assertTrue(gpio_server_out == expected_server_out)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


