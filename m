Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED3DC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubc2a-0003RA-GA; Tue, 15 Jul 2025 05:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc18-0000pn-K9; Tue, 15 Jul 2025 05:32:07 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ubc14-0005me-0Q; Tue, 15 Jul 2025 05:32:06 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F3UBOl021997;
 Tue, 15 Jul 2025 02:31:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wwzok86sWX8lclmz74NDhJBVWN4Hjdfzou8gjHMtc
 D8=; b=YtADpRNkl7xF/ArGL38FyRCpAMPJ+URcMfjEZROcO0IPQKxsxl8Nb7y46
 MWM/fDEooY5GxemMnv0Gd3vd0jbosxH9YH8OGp5SMKxlfFAfoPnWjxXUY2uu0bBd
 qnh8sNhxbKJvFQqcLxTaWrlNdbCrnDtVqL+mPIsrw2QzBSkZVK9xPRPPj/yIW3ex
 vRarnBT/LvGgI16juNBj3R7LsGCF4mterPbq2XmO9EkbHdUDtsP6CZpEZZPZGjwj
 AxYsdYV0Mlk3PoCdaWfKwy/3IlLOvLWNf5nxjQrNPppndx5mVXa7NHH4JJCadZmL
 YSEZyy0J3SrOynmwNtXNcpnqAaLng==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2098.outbound.protection.outlook.com [40.107.244.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47untj5xad-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 02:31:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JULKYGZYTBfaiKseupMjlCjGX53dFSxZEWeUOQmrUupRReIpUctSXxv4wbjE2cQoUrfo5jTaehFAG0ok+bXEfpjWVhBmqNZT4x61J8nZ1LyuZ3G+rOOrJluNpQz7rVc0qqXsbTMQvQNcUNfnUblX/yA+ralxFEjHpf3W3ltZ/GA88gOHp4CwoBMZuIxZLbRZxoF/k8P2AXhe7lafcZsurOi5sAsX/qocROq8TnfjRhNOl6df3Lzz1HFL2kyYJYX7NpuSyEmOJULKzutJbFDM7z/Tc8P2fy2bGZfrviH7KGfEWR8peeP38VEilyoL5//++NSAMwVetnotyjMUhNHRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwzok86sWX8lclmz74NDhJBVWN4Hjdfzou8gjHMtcD8=;
 b=qRkg/ZrAH+3ymatSYjhSxjksqzSQN0+Q3N1TeOPvb7hsvnqBoPAeNnZzH3iSBqm0Eto5HaQ7Pk/95s4ztuvkH9tRcFCs+Aj6hMy1kPw2VRtEJMdpdaiPpSeRwvhJChWhnTIX+N+G6uaxE0Dtjks1sXTSQm9Y9u9pcDtlv8cL1so7xqzlqtQUT+nPpHkV3PisLqR1HNquBUA4uxuUpm0F82alQmr62jvzBBwpUxE2ZdLtoOoMePiw7k3xD0uqFxnErUThx7id5D+H/jXkQ/IihMBOFyre59ZS17KVpAysKXjkvZMz+Jdi6/PGLKEcphp4iYkgqhZgI0X2x/33iIUX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwzok86sWX8lclmz74NDhJBVWN4Hjdfzou8gjHMtcD8=;
 b=IaCHOKcgLWvSSK0VNfMOat2sNDrw6lST+Y8qRcrldNpFv/vUoqk8HN89IuubyuaqGyVXIzHOYBkZ1w+UzDz0/gthoVG3iX9aDwN1v0u326IaNGL729cxi+fL5cmdlS4VSGjU6KuLJTyS1PVi+BjGdkqGFJvSS38fONuB+U2EJfKlImTrNS47dQlV6fdx8F+/lIydp9MkrZsJXSPBThZjmGjp4zwBe8MPN2fmU2x0Uu3CBQI06lRme+KTm2zB47mmNzbgFClYVSwUTPGyKcICBYxzCDZj9jRtjkqgF4/jWnn75JUKqmVfl9XDaUYM7T/oHJqzNVPBxT3nqHjWuPrm0w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9770.namprd02.prod.outlook.com (2603:10b6:a03:548::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 15 Jul
 2025 09:31:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:31:54 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 mjrosato@linux.ibm.com, farman@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, clg@redhat.com, steven.sistare@oracle.com,
 tomitamoeko@gmail.com, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 11/22] vfio-user/pci.c: update VFIOUserPCIDevice declaration
Date: Tue, 15 Jul 2025 10:25:51 +0100
Message-ID: <20250715093110.107317-12-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715093110.107317-1-mark.caveayland@nutanix.com>
References: <20250715093110.107317-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0101.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::42) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fea0819-ae02-48f1-3258-08ddc3826fad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XpLbnMtnHnlrUXvPG4PUuwTD25YlizIq3IJsPm4jAOQWv1aIATY2gLaz+q38?=
 =?us-ascii?Q?dv1YxquiFOs1wFLejyy5lXED2qcKy7iwwJbKvRvO/K/ye7qSIhnGispbqbJN?=
 =?us-ascii?Q?C2GB5Ol48sTe848ZUWsJjJ16w0Vj3/XjNm7aCRSf5mltFHJhz8uUugabl1G+?=
 =?us-ascii?Q?vxVsynLU3yBwUpG4Nx08RS5fbkjs3cCLwnaNCHAMciHKinCauIrsDdTjbATQ?=
 =?us-ascii?Q?1vc72XVE7ZYUOnob/HVtz5cCM2iShG7EmFj+LuJYKRHz4lxa+Er6ykT4zWLx?=
 =?us-ascii?Q?fkRwPSe7DWEWb1TuG6g/7CMr0pSsc5OdjdzOztEmCpwQgrZJb91hXd/vKX2e?=
 =?us-ascii?Q?TioaPFZBUsDyDySVeHuaEyyOeBW5/FYS7p8xJtmdSOgjiRDUOddNK4Ek/hIP?=
 =?us-ascii?Q?t9k0aHcHJBErypLFmrcEpCpLY/nxaop2XlyY/n98fH6+0NroZABGykmUDxrV?=
 =?us-ascii?Q?gLh/f/kQyTAwGNNzaxAY7QPMBeULrWE9WUe6deqInG7A1O6OsFfqWWaIUmaX?=
 =?us-ascii?Q?9BGwAaTGZja6eQG+WIWDXfhaTavTrfyXDPBgDfAisRw2rSKOJ6r/BHDsN3lT?=
 =?us-ascii?Q?MXqeuhActuPu0mOYOBaS2kr4QgxcX1zjz0km4SaK24/vI0KmXm6lIOgwBpPz?=
 =?us-ascii?Q?tlVjliNCeWuADp5RdAQCKjzPRH0twvgdEAsbUyVsEoOtgv6ZxhC3fo0Z0ann?=
 =?us-ascii?Q?Iw3+I1RHrCEf1IxA9iHPyAPWwCnSgwjVsoRXhdV/5T3I+mq4fAxeIH2wNofC?=
 =?us-ascii?Q?XO1ixNBrbwXtLuzliHdNmZz6X29KiDVwZuU66w7k3Q48/phwmtRuLkCeDN35?=
 =?us-ascii?Q?31SYRxwI/WIRk6YaJ5jll68UWIwiO657BjS1tBTNKuLPHOIfHaNjQwwoBh2v?=
 =?us-ascii?Q?85niTkKQ93ZtRlK6T+gDtYcoXSHlnxBdWm1cU37rxJg31XwRc+RGx7RRUApa?=
 =?us-ascii?Q?DCP+9G13qENSmC3FU6HW1EQK+CaxUJAXMd5/BGUhzbX0Ucm8zT83jv3TIN3o?=
 =?us-ascii?Q?26kaWpJqcfP/Xm2YHCg1Kz7sW98gXHiONnwOBZUw/cwdFoh7WdUJNlCP3+Rj?=
 =?us-ascii?Q?khWtFmdyiIHhNxLhg47XoiF/KjLqv/VC+yIp5AhDSL8DWzA0I6VCxasbf/UJ?=
 =?us-ascii?Q?Zk+S3o58MMx4sSZCOoWcigUE6MZsz2fPCCwmFU8vKA32krDxtG36lEcTt7kt?=
 =?us-ascii?Q?1g2cUvaWTAXjS8liq2OU87iowM14XLHxDTmmG/dR57bHAtOpfL1IyNpoBNpA?=
 =?us-ascii?Q?ovP7/3exlPeNDWBlgeUI29qzKX71OQXJF2xnRC9IyCZ+LfNnyIxOJBwbUEaW?=
 =?us-ascii?Q?dYwMRc/PwtX/ic15WHNcrzcMb72pFhIhc8ao4tJMWI01kfPfZH+Q/5Sj2qPg?=
 =?us-ascii?Q?LLErtj+fyLehhrlkcXwPWT4KfDzwyGBoXXUo1dp4AlyclzmhscODLSaBAvx0?=
 =?us-ascii?Q?2xYXBCAcRuWFj0/7885rWwhPNVAInKDDKUxZKgJ1IBmS9YPoN389kw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iBuvTXaFRYYWSfoFzKDpX5u68z4vDHtRwZb+siESDD78y+lIw/C6lYaVTlMt?=
 =?us-ascii?Q?bJ4Ep5FLcBmzgWf3yLfbAZhkS0BoMYi09YIFjpOzX3mMaB39BbK5nSUoZ5Xj?=
 =?us-ascii?Q?B0xK8LHv0SLkkUnjmlBBmTFm1PpxP4xs7BNvCipZnN5w59nT17iAYlbXyXd7?=
 =?us-ascii?Q?AAzsVlGCpDKtgCINyUiVS9wGqcodwmnTQbbqIhvS0r9wSerlcnSrlubYi11+?=
 =?us-ascii?Q?Mlq4KLlEdzeGujafR9+cnlCUDlreaWLwlJmj9Pn/MC51tWLplESiNOsu8ARJ?=
 =?us-ascii?Q?hGxV26hz5y1N0mGxYiHlg8AZpscT9RBPIsvU1NirYaoZjDol+o4FMw7SPd8O?=
 =?us-ascii?Q?uAOavC+m1RmWP9qpbCKdHLWP/uS2jLvTDkNZmHG5rC5LEtVqoPXrQdTlm909?=
 =?us-ascii?Q?MXTIypjzBoWbQXD6pe126XylyZVExN+ZP0rR4B7den11+E9egrlk8kvbZAoI?=
 =?us-ascii?Q?8iaNSVtLYGpj+ceZIid7mhQTtrcaAx6sgghy/9NXwYi4YBpkEkz+l41Xd/TY?=
 =?us-ascii?Q?xenUARf88CKAX40l/xPrh/vanoBTtPa22YidXO+sgvdHkfr9ZxsttiHP4otv?=
 =?us-ascii?Q?aHKQb9x3dvXC/yuUGwEnYL17QtjR4US6IPQ0e3vEJA3RPQx1hPzBG5nq7Y9s?=
 =?us-ascii?Q?uD6tpE3/T6Zrv8P2ZmvIizScjIYm3Q/jDIoTINIO2vVFh1sv7bXWxbkzSVva?=
 =?us-ascii?Q?LGvYuVuOdhgipHvzSTCiSX65GBCFr9MIywqedJ4cfHuG/gcS8yo1qbvrw7lO?=
 =?us-ascii?Q?luKt8VNJyYhiifA9gbhsePGzgi8W/XI6l74zAMyjLdeM2y+KZjvSFrXhFMPL?=
 =?us-ascii?Q?OG5n8xyUEGUQd4SuBdHd/WDMqaw7NXmemg3/8UF5+JqUFmIigdHqDFZhJSqM?=
 =?us-ascii?Q?XuQafg2c4xOwZE+TdVlh2Ts7DIDn09ovjteBpFvDWIZg9r2zGE12InNF/Ow+?=
 =?us-ascii?Q?E/terIxQWafip16N/rmsqMtF2ab8xRdspgkbvUPOR0WErErbliDQ3wG80hg3?=
 =?us-ascii?Q?rfvCVRBDLo5GEPov+ExH7blIgPqi60Q6Xo1jR6UVv41jNhXk3ACweIq2u+Wp?=
 =?us-ascii?Q?AVVkjvTEZ1LkwfEP6gt9NvyK3/lP1fmD0yM6yv6cyt81jmfkyYMJMFbKm3Dp?=
 =?us-ascii?Q?YThqNd7C2yknVQjnM98pFJdbXLdDXKzPHVZzUBgeWbi+/dcbe7cboIK5BzpU?=
 =?us-ascii?Q?6tG2QFGY9GtD6CG7Vy8BArnC0QMgDc/JymIk1MPW6hs4f6IAYRZdiH6CMi7c?=
 =?us-ascii?Q?IY+ln4KFi0jiPtt5JEmgEOZAJqnVcEK2S1UZH+QwogHqlVOtnFcEcz7fCQuN?=
 =?us-ascii?Q?/4BssdUwDXMrKmEwXJhQFcM9HOpmSUOwccSUDDO2h2/6KDwzyK1mycZMGJuf?=
 =?us-ascii?Q?y3UUQOOmZond9ay/2AZTcphF+wlSY9aC1XUZJq73BAqXFin18ZTfxbh/YTGQ?=
 =?us-ascii?Q?Erfw5QT3Kgl8qU4zCgroXQ1THTuGJwzFIJKi9u6RLon9nmQVGcAzQEgmPHdP?=
 =?us-ascii?Q?1/Khvdh4r1PfQYa41h4nV/MLZT7z7L5xaBOIXNSo+L9ill1AAdgZtN/qLBo6?=
 =?us-ascii?Q?MtpHCaWFZC+ogYayOiBZ3pIgA/cpVXOZcCiTcoIESVwu2uJxRLdEewRFUZbt?=
 =?us-ascii?Q?fOD4Nv3m4Z3LuButmuaGUH3/ZGdJL5LZ08jJKmj8QdBWsjnvTBwFN6dgYQXZ?=
 =?us-ascii?Q?RM+snA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fea0819-ae02-48f1-3258-08ddc3826fad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:31:54.4055 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcKlCka/sp2cNh6E2U2c2c4ZfcpKFcgSUkB1hz9PXRTB9xcIrbfQfDu8DVorkcBip9fKsVzn/ac9e4mQu6SIqRJsavfy3fsxvRpgFFDOn/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9770
X-Proofpoint-GUID: W1BWyaAI0v6s9p7oGtz5EI00bY591HII
X-Proofpoint-ORIG-GUID: W1BWyaAI0v6s9p7oGtz5EI00bY591HII
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NSBTYWx0ZWRfX/Blld5u0Jm/i
 jWCxnWVEdYDp9DWLbAKSy99aKIAbn96+OxqqS1ZqKzu5R9MYnbcq8HvE9u98Aqug5xRGaaTvhDH
 CP/tuGeI2JIBGwWTDlC1b1Ygz3tXiPZwA1nnfelzjzjTRNsK8PSMII4cbXQ1CwOL6KaXQU8B9zq
 IYgrjjAfNHcktbl/SzvH51/dyBtikQnSOH4vkh9HcLhlsPbnMMmDjZGTtLol95EMluEWYA2Q72n
 q1LuuS1UjM6aZpjZQSyYEAGKylV070SMXQUBM8IhbCWd2y40BqJ/hAz1LnWGs4EHI5fYfafM+AW
 huLNcPOYiWnMY/flGn3j/kx7QWrbGaWFbdQHh356wEhsumTe1QrGj5k4yxK/Os109kxvIsTmr4S
 aOosgcmXGcWuBG//nfWR1c3Q2xo8dojFJ5Cs/oKC0RE7LNPbiYLWUtJYHs1Exev/Z6QRtMaB
X-Authority-Analysis: v=2.4 cv=PYb/hjhd c=1 sm=1 tr=0 ts=6876200c cx=c_pps
 a=FxXBCnfXph51YBDQzOwJNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=O4QFABfiTHIwT9Ek5cMA:9
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

Update the VFIOUserPCIDevice declaration so that it is closer to our coding
guidelines: add a blank line after the parent object.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/vfio-user/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index be71c77729..da6fe51809 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -21,6 +21,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(VFIOUserPCIDevice, VFIO_USER_PCI)
 
 struct VFIOUserPCIDevice {
     VFIOPCIDevice device;
+
     SocketAddress *socket;
     bool send_queued;   /* all sends are queued */
     uint32_t wait_time; /* timeout for message replies */
-- 
2.43.0


