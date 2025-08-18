Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1B5CA0EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 11:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unxgk-0008RB-1Y; Mon, 18 Aug 2025 07:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxgh-0008QM-Dj
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:06:04 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1unxge-0001QG-En
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 07:06:03 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57IAOMuA052491; Mon, 18 Aug 2025 04:05:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YF3Hsb+jjK8ynrqHB+yugg947jpgbObP7CVyCp/Y6
 sI=; b=p3t3ZIxRI5FssjFiWHO/GfgoSjtEKeE4Y/SMApbiJtB9KY20Wo/rNnI5e
 iHa+x7trT/i1EmaUHaHjUsFgf9YvOmMYjpnBNGT8Nf+tUWpgarT9VH4YSN6sESOf
 9DQqdtUFhQvNTU3nPlip43wFMctAHDApmfikD3uhh97Dd94QStRH1x4jIim0ph7w
 oqd7jndfa8+gv0t87WEo1nxFsauaQMjX5ryOzVD7fqYWlMulqCUTcshxMvcpsAGz
 8weAatYzW+TQ3B/5bxEYpHuraDSOG3Tv4mpAzHVB+X4APLj++wySHbWFExuLW5AG
 n/NiFxObECF45W3vAvsqrGEpQS4Mg==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2114.outbound.protection.outlook.com [40.107.92.114])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48k9kn1x0a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 18 Aug 2025 04:05:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aB9Xv7DrnF+QZnB9S84ATVD8/7m0BmoMBftmw0OHLFCXcS7Lzpmia61uJhosBAMTfWC1LUvgGD528grg1T4gOvg+JO/6/QQ8FewSvrnHhI88Umw7+W0dQrmgViq6x6L7BQG92GLZzFjYJMhD909gHaKf4xn7WNwx7oeeIsVpYN+TcAwuB/1sM8WgkkkfpUnXvFfqiIapTpyUpa5VDlp+QUiTp5aV349HvW8bDDDt9w84mDkKEKx2tschP3EsFt/DNFQ6FtD6P/CL1uf2klWg353GH91iMJGXqpd1xcrhn58gZ5w2ToV1eMFHdNBwJ/fQTMfMwHfNYw1Dn4EG2yWF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YF3Hsb+jjK8ynrqHB+yugg947jpgbObP7CVyCp/Y6sI=;
 b=JQ4ePqFClJouTDdDbOUY+8Pgf41YAW6A7mTufi89+MCm146Wv0S7rcqnOahNoEPBIzLSxD3U5Pnfc/F00e1TiozNiK9PodW6T/BJp1YE1BtZibh2Hx/KHSDcphd6YApIZer6dkEvSBxbcxLUu8gfezoky7gfoymCWzPhR8reR0Y7tc+ts7WLopmZ0ZGaTHcGT5hQRqyCG1GzsYl+rcZtzq6if0dhw1ast6rfBRQXAN8Q1bgwHokhU1G16uxKUFDgyfnN2ZFHj31XJ3BYMo4sbYIGwz2BAjtLYq5km4N/QL+Y+aBNvdHZigHEFzepGVrKn1hQmrenrcPZ4xGABl9Qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YF3Hsb+jjK8ynrqHB+yugg947jpgbObP7CVyCp/Y6sI=;
 b=XqbW80DWyjjEpuRDIoBpXQC39kWubMLjf515ecMz0Rl8KDUuDA1pn4Lz9xwEpgjIOUZV3XUKMtVNNm7XUM/UXOjFWr718s7M2Ggw9RtR0mAxysds84d/EdlbPiiSXUTGJgKlFKj/m0GyPzjgXRK9qNTprNlzuSmNCrP8aBQeXgc8oyhBptwwpidH0INShtfJyWGx+cxbdQV26Sr2Z5O3PDlEXCizXFgXK0ADD4CZCa4A9WyNzxxQpt9JO8u48gZ52msgm/MlqmbV4rCSLrtrG6g5OY3Yxr3Y0wwRJn2GO6UspBgMbphpeHhTz0nuF1N1dJEEI3Vt2xQj1cGuZ/gRPQ==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by MN2PR02MB6814.namprd02.prod.outlook.com (2603:10b6:208:199::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 11:05:54 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%7]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 11:05:54 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Subject: [PATCH 3/3] tests/functional: add a vfio-user smoke test
Date: Mon, 18 Aug 2025 12:05:46 +0100
Message-ID: <20250818110546.2159622-4-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818110546.2159622-1-john.levon@nutanix.com>
References: <20250818110546.2159622-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0036.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::7) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|MN2PR02MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 497270d7-53cb-463f-023b-08ddde473363
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AQ/LrDE5MdgW9QHItW2scbpTCxQKWh8GlHgbRmiYtJPb/4pk27sZ27eqzVes?=
 =?us-ascii?Q?o+j36J6JGjERLpZxM25LtyR5yc9SUIvJ2qwhqXiCCT9gGltG/BPkpNIDlqWL?=
 =?us-ascii?Q?tLgaZUNxGDhygA4W5ABnlxIXbW6Ch9l7qbcisO6+mZSMvcQwrK07Oy7/ouXv?=
 =?us-ascii?Q?wfCrDdOgwtvDnzriaGDE140EiFinuGjaeGUtPvBQF4YVwyCvIXhaNKLep+e2?=
 =?us-ascii?Q?Q7FcIGAq3kkhv6ChIParud92u2MHfmBDxbowUjexw3Z8wxzTM68NwMiJZYzP?=
 =?us-ascii?Q?cx4VnPGZpkHnzLxlWe5wBBtqKp1mUgUvFFNWN8heDID8LVkklomNoX3ZfdWt?=
 =?us-ascii?Q?oy3el2b8FG6bn/OGpOo58z7FxP3fpoSzqE1EJI6Uyzecj89Vi8U+2EaPzJOG?=
 =?us-ascii?Q?PFgldOfnS4cniJAX4xQVK306gJTPLnPTlhrqIiTQgXCopxiOE3UQfDAD7bgp?=
 =?us-ascii?Q?meiUJNjQRBGuB5hBU57nFvkiPzvG5ky+YAMX/dSmJgeBwwroXqNjnzEZktP9?=
 =?us-ascii?Q?YUxtzrpNz+zmdpxe0LQ7mwX7+M2Ma20yEpWszVx2qMReLLrjCuq4LW+a21af?=
 =?us-ascii?Q?jGmTEkIi0cmBYyn1R+3ZlNqoPR5cgV1M3NTv1phPgnEfxNOpx1wZJojddKU9?=
 =?us-ascii?Q?XNT/Lss0lUicPbpHRL8heJMUutoPlkjgwmug+1pshJhg3eDp3nlHhiAQeiuq?=
 =?us-ascii?Q?sreKVdcxtumb4y03zOtwIQ5QAoEJ6SpVs+maWn/0VM5Cisidz2EngdqU/4WM?=
 =?us-ascii?Q?whx4aIHaOqqCHAjkjGmuz/BxHjpD0BoyF1BVxmK5tE3VkObhEC6ou0BeXh85?=
 =?us-ascii?Q?mU7OjPAC0mUwFhNKQWNZvxktenaSWrruAUOIQMmh6b6n2wuYg6TzxB9fy7NC?=
 =?us-ascii?Q?O5l5XJChWfuCY4/S9eDxYt0Zz3cHifw3VV6nO+L6GK3Cz+QIAvX/oIUKdHXt?=
 =?us-ascii?Q?jW765/keyRMMeaD6qFgfqRPEAGe5GhKVh11I85z9O7qlHh9cUCmB3PKorTQl?=
 =?us-ascii?Q?BfQHS46aOz/YLM8/Xp1FAzX95FXJa4MHAddJKDdQVcIjKu6g8suaam2/Rpl9?=
 =?us-ascii?Q?rHRfpFYAqk3ohZanJ67tlJRrCkOYtaYAvG41hHlptC7eKRmyq+MR9Bthv7p/?=
 =?us-ascii?Q?myaIBhng7psUgD66aZbRC8K+rJb2uSnAI9jlnlcqFveRUxMz5UWEY5HSZ5Xq?=
 =?us-ascii?Q?UPZefnR5VpbDjLioOTuOqFAhzlp7JCOKI0gmi1J2G76dJw+ng7pbQXG7Wyyu?=
 =?us-ascii?Q?k3opbkOfqPSFeE+No01ynVqiqebdVwBiX+0btmSUxxo0Tkr6pKifrr//Th5+?=
 =?us-ascii?Q?+jgDyMXBaG7BEPLP+dy0PBPXTaH1XvL56YuWbZmUMDk/Ifxd1KSfUBhOrvIE?=
 =?us-ascii?Q?+PfmRVIGESXp+j9yaIm/Y3OryLWr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jFQVPzX+Mj5f2UzSiF0j5nifIHm3R5YogOtO465fERtwmRsuA2DoLmRlWlgq?=
 =?us-ascii?Q?xBQpU8uYM7WxjG+1lOLPgIBsb3kHKslZ4XHwjlbDyFFKWmK/uKQcpyhX74/9?=
 =?us-ascii?Q?kapNVdPnUgETYhU+HNjDCc15+U6H4PZhUyHD0ivLykaA7UFP4iqTeRVGoyjR?=
 =?us-ascii?Q?W1X5Kh+i3fU3JpG4ZoIG9syeDG6vG+TW39omETVNk8TubjK1fpsPGfsOQhgE?=
 =?us-ascii?Q?Y7W2xqhJMGbQQqoAfDJYlVJ6mve1r4SBwNQ2d2rfkfkXn0CLLv2P3a0DWaUI?=
 =?us-ascii?Q?SPw3MMxSDs8hOvzJ7VWuyqcKE67pWAIzUGEYALFcfayWLUTUzx+LnGtUudmg?=
 =?us-ascii?Q?eEnEyeB5wtbgeOENm3WJUSlslFPwkUXiHoK+slX2aIar/fvHJkfat1acjwId?=
 =?us-ascii?Q?s3jWaSNZjo6Dfjmiz6WlL3/93zOVuCAG11o3A1Kx0fhP3fPmfrLL5iL6nlSD?=
 =?us-ascii?Q?7TqJIGr6NBJDEKs3Zmh2K3DjRSybc764ke+liBy3oHlYlVMfIM5TE0yw+o8S?=
 =?us-ascii?Q?Ktm1pymEjK3MGA7lAZnUY7Jkz8eNjJADrsXNNPKYwq9HyEUgXjsY6aV4uwAW?=
 =?us-ascii?Q?woXuakm0DIeIkFqKurvlVKFLqLiwMSL8b3vt0nlqJLylLWo7T3V1TJEXu0nf?=
 =?us-ascii?Q?p5t/oBwz4Fr6ZfQPnezgNGfwT88ya3sXJJWDqMsNR0fchbyn66wclNCxcQ07?=
 =?us-ascii?Q?8uiX9pvO7ODHpdcMVaKdrZBZHdabSGh9Vz9YcNErshtVqDXSD7FAtlWJyJ+i?=
 =?us-ascii?Q?fFwgg7IOWjuU+2rgdsx1vgU8ySYQo1ElbOGTe1zYuZ4xt47Fr9uO56i5NkqJ?=
 =?us-ascii?Q?PfEHmTF8E5S4XyypmfnwAppxILjOQHHrRwh9LRROtwC/FtiD8Y1dwRIU1kqW?=
 =?us-ascii?Q?j6Bip+bQJnyW3Q0uETmnPPIgry4dKNO0ZHYB/eCOBLHXlSif/OjcUPacrvAb?=
 =?us-ascii?Q?rJ+dh9MTS3Dq8z8l4DID54/1+4Z1/beqZrZ3yWgk0mRS8C1WdRwkN23ZfE2+?=
 =?us-ascii?Q?UFqJSHk08rkElqfSlhdvfvDx6mzXLMvuqKitLPSiORYdBx87hcaNuVoVkf5q?=
 =?us-ascii?Q?tZstFasOpsvzg+eSDmWnSUdL8OWgDa5iK/ZsJE50RTaWbCmAvRzUYoVs+M6E?=
 =?us-ascii?Q?C/OMweEwJY9HBTx/L2/nRMuhymY+2mk7UxKtK27+jlPyybFXbj9BcIGCqeN6?=
 =?us-ascii?Q?IF17G5fgcYzLzKciGWbtxNF2OEpwxc4tnxosZ+vXK4ELzFt9X37+IF0SZ1de?=
 =?us-ascii?Q?QZbeh/dntTQPysvfjYQwgNvE+kPfYLXOCz6sgdhqMUligQ4DjvuF9I3z7U0s?=
 =?us-ascii?Q?Nd50YnE6EtpfqKpVnfzoCE9Vx2SCcC+tBLVZdp6gLV3m41iRyvN2tPKMcrLM?=
 =?us-ascii?Q?nyoiRm6AlWDLLXAkV1JQyrCEaMPsResNmK3LOhCq/Jym0si6/9qwss0+lQqe?=
 =?us-ascii?Q?frIp8WjgDup66eXH2iwccdYX4JFq74h40NY7VEaIS5L0Ny6KjVbREFSvFCv8?=
 =?us-ascii?Q?PzDUPFiJlV/Q9zi55PlXDJBtAOXCYWdcpGwYOf3qe5N829sN/yl6m76m4ACg?=
 =?us-ascii?Q?zNgAZkfDMnE0oY2da5TQPU5+7iWJMBGq5xe2QjiI?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 497270d7-53cb-463f-023b-08ddde473363
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 11:05:54.5298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bBy7ABsSFfMU1F1ZevXdVO1O3spuzfQLIbIc8BgppVIGF7ws9jGNc9mBnJcwYonoX+IZCZqdIVW4hpN6LjHsTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6814
X-Proofpoint-GUID: jNCY-dxTOTLqX4n7eSK6s0s9G_GrqG0D
X-Proofpoint-ORIG-GUID: jNCY-dxTOTLqX4n7eSK6s0s9G_GrqG0D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDEwNiBTYWx0ZWRfXxU+oeqOWs9xI
 OXZoCG0Gah0rtCz+vDJtVS2u3+AmDL6id1NZ3emD5re7x4jOwjndxf3fDyGzValR1nkZaIrbYs/
 remibcimSJIMBl2yJV1qLCeiiPaNeGL7S94lYtLXcf0UoRyv+UYasTR6uH+1OpbQz+Kbr8TRZuz
 VsteCXmOyCZ/AtQgEK8aeyQnttMFCG93hvrmq9mxHBcCvvf94MugBpa0xzBHOcBQlFKLzTcbKhB
 oMR9hq//14VcNLgo+uXTN32fNHYXwcWzykdW/3ttWj7KIU4PXpMQzszn18tuq0dySdKyZ/ZrARn
 5y8KhVwRLFhobiWhD572xtqEE077Gj8WCdqeUPiXsOlNHb1ZMjrJ1wtuJaYSws=
X-Authority-Analysis: v=2.4 cv=H8nbw/Yi c=1 sm=1 tr=0 ts=68a30915 cx=c_pps
 a=1agHWDAk2Ff3ek/eqE8klw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=NEAV23lmAAAA:8
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=bGJ7yUH-iEoZGlg0rpsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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


