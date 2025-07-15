Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C719C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc2P-0002jF-V6; Tue, 15 Jul 2025 05:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0o-0000Pw-IZ; Tue, 15 Jul 2025 05:31:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc0j-0005jK-Hl; Tue, 15 Jul 2025 05:31:44 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F6dBWa031489;
 Tue, 15 Jul 2025 02:31:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=jyJpmvXamneUeO7/OWzPyJ4r6C3Y5mEryoMgRrf3r
 3E=; b=xztNHo6V99AnccHlB+uD7SLa9Pb/mGsav8zz2Q8tsiPSOTMjNjq4LhouE
 VDIfLWoRdd6JEL72Ep3v8nP9MFSstex6+z8Ju55bj0IuPAI1DswbimGIwShqSznj
 dW1J7kG45RzwI0L7u4fC8b1vt8RhoM8qE/lQmmHnLgLW8da0xwhLQTb4ASDzYyEL
 AeACJoYZEOcejObMr69EowMxqczNTyvXtYh4kQ3fwtg+8n+S2gdn3zT8wambKAyO
 4Aljf02TVqTikPx5EhoquDzUK90iFnk9+C829VfoSsLLV6OyPYG/MFTm1KgiqPGe
 2QbsvDY0mRl7KMj3MzZBuezf0iNQw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2116.outbound.protection.outlook.com [40.107.237.116])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47uq1ddw74-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVbkrI9JwwV6Y6tR9/ZFrtFX0ZURn9ArcL4usPajFid9OiVv/xEt2pZYkr70jzSiJeMojBt/s5mGo4KNTK9S/E8yQWkNP+5VjrMPJtr71N9laJtW9CSGJdKjUUfFbMLH/1pKJNanaAttJIOw/o+njIzjsCNUoLjj2bI+wol9hodvTqWNF1sRYGrGol9ZqXA4+VqAuUCzEMfCunEAqMZk297C9feFlGGLXO5DR9IZEyGJOBtY7tzJ5AZKs6DYJbb+apRs6AerAvJHYa7VrRx/yz+82suECA4oJ+KvZD2Rv2FZFExn8yHUBqPQVKBZ6U2ydkth0C9QWYxuApauIX2ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyJpmvXamneUeO7/OWzPyJ4r6C3Y5mEryoMgRrf3r3E=;
 b=hZTVrermttNpVqqbb3RwzGTgyl2My/Ux8peVIPMvOmtez6BAehZj9ZKoMSQuLFQ+Zx7pDfuG3/+fKAdE7rEEvH5QRbiRkLr/AiygW8AteXZlsjGmNVyZF1supAPfX8Axo5/eHuod0Dglmh/5+gdOrQNJLNNCNmsiLdHgLCYC8O+m/CCX+v0nUaPwMwu3Jhwz+v17RFjVQteI2fJERqswJ2e7TrX8EWJFe96dtcXax1hqS0gW7D5FVZiBoHQiJ9pukDCNl1Z4iDVQlRaqz9ECx8fdi/NXSYQpahXPi3J1eviWnGqZx/G9ZHBwxwBOgXCE26nSUf8UZ6yKTzcJiwP5/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyJpmvXamneUeO7/OWzPyJ4r6C3Y5mEryoMgRrf3r3E=;
 b=ZgxzRe5tArZjpXUAgRmCWHQP0igOnCILgeEs5MLq9BkBRo2TPtyruBUmca2udZHeVkqxdu8YyM2IjDjDumg1YLzOFTXUFHdPubtrcPEVfVLuRca0SqKN4T9TrxJCqoweZ3HSuvAct2OX1EtHOBNYHq5BiacdP1vqKTlW9uXBjOsqpKNqlFaV7Gmtk96I4xcpTDjbJBhIS8rScSSqwajbKQN15xuBGdSaYO4lyJ5tV+siGEaUzR0TDnbiVeioVRt+TtQqxGVSG2kjWknOHSZKNmWjptz4b0vAEifYJO1gQb+o0tMSBAFbzWmdISuMWsmrPzyljHXDS+9mgoUlYfGp5Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:29 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:28 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 04/22] hw/vfio/container.c: use QOM casts where appropriate
Date: Tue, 15 Jul 2025 10:25:44 +0100
Message-ID: <20250715093110.107317-5-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0026.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da48a52-955c-4a0c-e60d-08ddc382603c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4XiDp+/Ezzb5qoEQN+lyhvdTNAWLyLrHIc366YLmH5Ba9g6wWOdYZ/siDTcF?=
 =?us-ascii?Q?d9Hq6bLMuf+WD19cL+bDslm+jMtJdzhIirBwGB4dngZ/PKSau2EDLhmkPjTP?=
 =?us-ascii?Q?68NK0qnzbO4cMScSonrFNzcPKEhT3tojXo/85NLyZ4Q2pW8C3dcbBaipv9bB?=
 =?us-ascii?Q?Gr8lI1ui6WlOVCxW3ucwRgE0lEnAQ/+0McD2stlIC4fI3rh8ZhL3iByDYZgI?=
 =?us-ascii?Q?tHMXnolvI2jkaAnMGCSyox18OH1wrL0kPvuObp6Qm7tQccESU8rF1Hxqir77?=
 =?us-ascii?Q?WJRsiwwnDSAWynp4QtiCOf1NS26QAkF1MDQmRUFeF2TGYb9uIP8NUCpRqU9F?=
 =?us-ascii?Q?aKCbHjLZjk9X+UxH8I7q9EsduYG4/MouvI9pm+Hr8RplR7ABJzOFza6Uf2b4?=
 =?us-ascii?Q?1IOo2VhO6NDKMkZyFr/HcVc8gSl2G0jYEJyD7A9GTsjyV7O5eCaol6aUoYRS?=
 =?us-ascii?Q?LDI57jp2aDPl4RmPPseLqZYmr0MdS6O3fUlap/jfiuQskLPX7atig+wAGn08?=
 =?us-ascii?Q?l9Hwpl5TfBcXjIbsLscE71prgutHpKDZKN5/+R1JOby9QU9TF2tpmgQR4agU?=
 =?us-ascii?Q?mP3fdmkDLMSOFh2G9NQTUDaXTFE0FZCvzYivkKKfwE9mkxjvnrAQnPDL3yAY?=
 =?us-ascii?Q?YX5XQ6mu0MWxvO18LNcIl+TcXu1m0mMJg0q2WoMS7cIqYXMSWYrVvDTf99FF?=
 =?us-ascii?Q?ObHM0xrr6ZHaKbQorRpZ6qkX+2iQzmPlPucokDBqvcMMZ38IbSiG7yOV50ki?=
 =?us-ascii?Q?8d23vMPc18WB2XxmIM4cenazifZ8hHt/9e398YhcF5rw0s4fB7TbAsigeaUR?=
 =?us-ascii?Q?aUBmEow52z8c14zPWWvUUFwbWMEy8jD8G0cZDp08wSbnZRql/zN3mD5RqGn2?=
 =?us-ascii?Q?npQT3Swv1oiIcGnyMX3KahJPxwQcvhUbwwEzp7HLuP9Jbgs0GO9tBqVmWC0l?=
 =?us-ascii?Q?qsZvHbySu+7R88zKeheKyatoBvsisSI6Ysv0lkgQjMRHyzNETLyQs2kW8wWA?=
 =?us-ascii?Q?7eUfiX0pUjBCoSW0jm87t/x6Q6qvfXmZX5dZd/9VJikXRBFPV2xp0VTu7ipz?=
 =?us-ascii?Q?p6ucHZFV0LFZ+RSWoHGbsjOFKu0zJDu5brAiWgYdSx2Mw5UbPDRNJT071cAX?=
 =?us-ascii?Q?ZpEAUpNV6c3iglfdx8bVRWdHbcXFezIDzb9BEUdQ/TBEneaS/GLVo41QPCF1?=
 =?us-ascii?Q?4pxgtjqXNcnCgKfVl/EWqjZpcS8ctBUhmZ5T3LBV0UZmPhUL3S+sDsdErQn9?=
 =?us-ascii?Q?GewNsIyoTw7vKtNFPB/q1Ptjr5dyKU6YB8r4uYxEgCw6fNlI92QnSGQpvvET?=
 =?us-ascii?Q?muF3K2HvA21r21HxXsM1kTgh0s8PNFcGjS/tM3d/mw5kWGVm7zHOmxE9zSGh?=
 =?us-ascii?Q?2wAc907oznbphZX5ftAx9suDyIO9rbnWVtzSeKpm0e1kVsEZDTjyp5AXOAME?=
 =?us-ascii?Q?+A4lsBwsFSlRfBKKQ3hAzotGJVdrRh4aoS7i+TtrMy036b67Zsz4Fw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OojaYmt/zv+wQdbfIcqQozgZLvHh44QZiQ6vtYPsU3wOKJ6sG4qYxfSS/TdE?=
 =?us-ascii?Q?CXhG9PpX/N7KUKU3Kib19jk0ylXdl89VR0UMDDreEZCalnMbrydqmyfMZa01?=
 =?us-ascii?Q?/HmRiZcmH7yC1du3yux26PSTjLcOQUEI7xcktlvg4/AJ+Bn0OFKBrJ1DmNdD?=
 =?us-ascii?Q?HiLve3XXf67hNq8WSKSLhvnOoXp/0+0LMa4Igvl20D8sSGNSCYYI48ZSCNt7?=
 =?us-ascii?Q?9EXLoPfBKMUbZwnow517eMlJXI48hoLeZtfDKIPi32aL6YlfDmxpbxB8YEGw?=
 =?us-ascii?Q?6KSf3A6FVjUQpPDl1dgkP2TsXxNU/YB8+HO6FvNFMb0w/iUNf8oPHnhGiuss?=
 =?us-ascii?Q?noGfcr8YmSxLv0AcvUKN812vLSUj0AIsqR256RVOrO/M4o3f9AMIZ+KcV1P/?=
 =?us-ascii?Q?mMJaIwQ8vsT+nw+x3tDor9tx3QX1SDe3cHFt8hsMERyQ9qQFl2sKNknHVi3u?=
 =?us-ascii?Q?5KEzNqI9sO/75PBIK67t0hQBZiTGJDLKQuLZGkkGndW8KH/xr4HveS2cVRbc?=
 =?us-ascii?Q?YenRlH4i48xKVVDyLd8fRS0UdoAYe7qMf5fxidoIcSBhgzu6lk0WLLZoeYPk?=
 =?us-ascii?Q?gmAMd9hV8d4VPPN968PsBVXNcM4Tf+c+Ju3z/5Bd/4qeD9NYQXynplSEIIlU?=
 =?us-ascii?Q?5PrAwmRxlifzFh0DsIiRosG5H5MK3qMZI5a8y5tuTbwlZPBUdXfb+pd5lnI4?=
 =?us-ascii?Q?GMClCqZAxbIxqI+j3k+1CCHf5gLyQ0+rQxPWeYhEgIXKOZW/vastxODaqYkk?=
 =?us-ascii?Q?+6Iql3gruRKq/g2q0o9re4Cx8q1fMHurQ92bxhQPIvqdZMCQ1IYX3qzq0S1g?=
 =?us-ascii?Q?nlz2KejEcrou0PWl3SmQsYiQNZ7agpSbzRBX5BEPqvULiE2FwUq3uAkJzEdj?=
 =?us-ascii?Q?iQoD4DQLw8RDgKN1EBGSbUdmXOxmddpk971zo6z04A7905un7T0bUVss2xAV?=
 =?us-ascii?Q?/1n6UXuRehfbJl3bGlpjecmHHtjp6MjkjlBM8r3LDVomlk27lExuuKmrttgb?=
 =?us-ascii?Q?1S8DL/+GmmShCT2duOIwJ/xikDngw95KmavzQQQL6OHYQGt9V0255g+CWWYU?=
 =?us-ascii?Q?9Fzw4x24pJlPDRH8Z+82DkcXBsALMMBzJzY2Bj1OWgKMY2ROgY9/tzjNrQWV?=
 =?us-ascii?Q?cPboKhk7aiq6wnO+CJuQkge8f+Dle932C4tHRX6DdtKK12W8TazJ6fp1Ud3x?=
 =?us-ascii?Q?b/htVEQAwHJq9e+if+Q3Soz8KDqE/NrE8zLr+JhzVdzZPX43zri9cpuDsWu9?=
 =?us-ascii?Q?ZNgdZAOHHBlAgIwkBZPChYJV/HHO+cat5Uj19os8uRNVAjyAspq1sI4R7uby?=
 =?us-ascii?Q?7XXsAcDvaex9nITW8Lhm3+gYfXEgK+TKs0vs4j0oj6ZwuLqwe+shXrslWcyl?=
 =?us-ascii?Q?9bFKixit8pSsqDQHpJ+Z1qxjzR6qKASgdp7IpgPQTL0tMVKF0GbKcyNjr3Mf?=
 =?us-ascii?Q?R1GIzw0siM33LFuURVILRBbjHGwoztlq164WDsSsnk4hKeHxUfsfRbQMRBAv?=
 =?us-ascii?Q?dD429ctfZ0KvbiPL9gBUxtoBHvrRgcmo0fdUqZJjPhv0cG6qhmRhQn2sgf9R?=
 =?us-ascii?Q?UtQwWajfL4hjuNOZ86twoRgoIxVfuFhobxe1DLNoZweOUbPZY8yy3PRHVgyj?=
 =?us-ascii?Q?F0uQzazctW3N1VMvJd7hBCU859TuN8Hkq67AsEOf474SdOFcYvaV3IbHYFTn?=
 =?us-ascii?Q?uavRFA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da48a52-955c-4a0c-e60d-08ddc382603c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:28.6985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TPJD27p0AXDtI8HRL2Stdf+ZTGfp4G4qMEsW6XRqYxDW2zhS8PCSG2QSIRGV417XN5viq/Mw/Hx5hdmD23qsYSozTFmxpudk2LG3o1MIp5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-GUID: XZB36kv_CUrrZbJzxcDSKXVj8NN_cMHG
X-Authority-Analysis: v=2.4 cv=GewXnRXL c=1 sm=1 tr=0 ts=68761ff3 cx=c_pps
 a=AOHpgdKyObXj/ZeNOoJHqA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=ZDvX70TeSLQNQFwbTdsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX4HOogp539yww
 NlfGNfoZjK25eDAh4sUqGaDjL07prGwVN35pE0q8HMuAgz0fEXwnf9rsF3m8jaoTMXe5YJ3yt1v
 L3YwrFPaQGW0eXb7Qo4mLsiGQ/s9wnNt14RVSC/zc/VNv1IRW3akXVbqwp2qDBLcV+KNk7659kv
 4369pa49qjPphWZwDl4H1EQqSco7XtpigdfcPzJeueSu4mW++pwN2h5zscW5B7Qb5SqAbsh/+F1
 vZL9u1uuHX+Vh6q4tp7w5agCHwcXAU5VAT4p7m6LRy2sLlraFAdwOAXX+Jy2dfKmoH7K7fg5Er9
 A9O9Ki+VXp4Vi+oYEo4ZT9CYj/WaIUcoqAjPlSr4aHlNyI2ahh+4GxI1N9j/RtQSkEA0bQUBhvE
 VnCKXwUCx9JNjftZZLF/CtNnChZB8ya2cytzfh7Iajb52FWo9ZpeGQhz59gIx9pZ9VdrG1P4
X-Proofpoint-ORIG-GUID: XZB36kv_CUrrZbJzxcDSKXVj8NN_cMHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Use QOM casts to convert between VFIOContainer and VFIOContainerBase instead
of accessing bcontainer directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio/container.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3e13feaa74..f4337741b3 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -71,7 +71,7 @@ static int vfio_dma_unmap_bitmap(const VFIOContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainerBase *bcontainer = &container->bcontainer;
+    const VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -124,8 +124,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
                                      hwaddr iova, ram_addr_t size,
                                      IOMMUTLBEntry *iotlb)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_unmap unmap = {
         .argsz = sizeof(unmap),
         .flags = 0,
@@ -213,8 +212,7 @@ static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                                ram_addr_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dma_map map = {
         .argsz = sizeof(map),
         .flags = VFIO_DMA_MAP_FLAG_READ,
@@ -246,8 +244,7 @@ static int
 vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
                                     bool start, Error **errp)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     int ret;
     struct vfio_iommu_type1_dirty_bitmap dirty = {
         .argsz = sizeof(dirty),
@@ -272,8 +269,7 @@ vfio_legacy_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
 static int vfio_legacy_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
                       VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp)
 {
-    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                                  bcontainer);
+    const VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     struct vfio_iommu_type1_dirty_bitmap *dbitmap;
     struct vfio_iommu_type1_dirty_bitmap_get *range;
     int ret;
@@ -495,7 +491,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_migration *cap_mig;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
 
     hdr = vfio_get_iommu_info_cap(info, VFIO_IOMMU_TYPE1_INFO_CAP_MIGRATION);
     if (!hdr) {
@@ -518,8 +514,7 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
 
 static bool vfio_legacy_setup(VFIOContainerBase *bcontainer, Error **errp)
 {
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
+    VFIOContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
     g_autofree struct vfio_iommu_type1_info *info = NULL;
     int ret;
 
@@ -634,7 +629,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
 
     if (!cpr_is_incoming()) {
         QLIST_FOREACH(bcontainer, &space->containers, next) {
-            container = container_of(bcontainer, VFIOContainer, bcontainer);
+            container = VFIO_IOMMU_LEGACY(bcontainer);
             if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
                 return vfio_container_group_add(container, group, errp);
             }
@@ -652,7 +647,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
          * create the container struct and group list.
          */
         QLIST_FOREACH(bcontainer, &space->containers, next) {
-            container = container_of(bcontainer, VFIOContainer, bcontainer);
+            container = VFIO_IOMMU_LEGACY(bcontainer);
 
             if (vfio_cpr_container_match(container, group, fd)) {
                 return vfio_container_group_add(container, group, errp);
@@ -672,7 +667,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
         goto fail;
     }
     new_container = true;
-    bcontainer = &container->bcontainer;
+    bcontainer = VFIO_IOMMU(container);
 
     if (!vfio_legacy_cpr_register_container(container, errp)) {
         goto fail;
@@ -735,7 +730,7 @@ fail:
 static void vfio_container_disconnect(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
-    VFIOContainerBase *bcontainer = &container->bcontainer;
+    VFIOContainerBase *bcontainer = VFIO_IOMMU(container);
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
 
     QLIST_REMOVE(group, container_next);
@@ -781,7 +776,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
     QLIST_FOREACH(group, &vfio_group_list, next) {
         if (group->groupid == groupid) {
             /* Found it.  Now is it already in the right context? */
-            if (group->container->bcontainer.space->as == as) {
+            if (VFIO_IOMMU(group->container)->space->as == as) {
                 return group;
             } else {
                 error_setg(errp, "group %d used in multiple address spaces",
@@ -895,7 +890,7 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
         }
     }
 
-    vfio_device_prepare(vbasedev, &group->container->bcontainer, info);
+    vfio_device_prepare(vbasedev, VFIO_IOMMU(group->container), info);
 
     vbasedev->fd = fd;
     vbasedev->group = group;
-- 
2.43.0


