Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A7DC5DF88
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgVt-0001C2-16; Wed, 19 Aug 2026 09:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVq-00018s-Ti; Wed, 19 Aug 2026 09:39:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wwgVo-0000np-Us; Wed, 19 Aug 2026 09:39:26 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JCo4Ne453701; Wed, 19 Aug 2026 06:39:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7nLW4o5NIyHI7/2eX2T5VPZdkigFMgQsa1j/Ai9c0
 ic=; b=DJUBqI8EQqW95CHQT1+1ymjQE5L6GjIJZZisgT2aaQHpWZGi2GHc/Io0d
 iFkqIIlv1Sj8rmNoLAFjxa3ssgwiaAHfCLy50vudLCxKWzDeUjZelDqudGMY4HHa
 nZeYYzx0u4lqjGHiwGWWWbOWyyc3U+Th6uGtF9UM9por/DU5Qtm33YRAo9xMLrcl
 NIPQejGzcjbB9qc4lVmKbYjaCvluFjxtHb7OBpdtP41prH/PrK0+qCQnqQJ0BMSR
 SlMV7ymJx7iqGfFq2/e1AsXM4pN5Riba/Jd4rPG+YujZqZBacbeK60fvVREl42lo
 /X9c0Ds3/zoQaC8oPp8HakAA+0Z1A==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020090.outbound.protection.outlook.com [52.101.201.90])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g4rvhbby3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2026 06:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMbOxD9m1SBKoy/k/2LrfdTof6tbV8bvljSv0XdOg1BBLHL1P0auw5JRf8oYox0WaB5l9YtpBvauepFCvvzDRexJldGDKSRkdrylQ4XWVqNHqAlX1una7z0stlzkQHYuBJ1bNayFNrhThh3vyBPUj7BB6ikYefhKqvQGVvWALT73xEMaKCUMYFPKA4AQ42Ea2RIQcNlRkh9WeP4epVnfMowDQOFmWTslMgVC4//DhnkJ4WDhNrfJUR/I+gTcs5Pal8Bw3zU4i6sDQ5MCCnnkNgWH+Vq2yOXS1sD7hGOoRGx/eVBW9JrXBeSNtU++lz+cyZ0hVeqdgwdF1hwbvhjyYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nLW4o5NIyHI7/2eX2T5VPZdkigFMgQsa1j/Ai9c0ic=;
 b=H2gVwROBGhGKcwCik88hckOLcKFKYj6ZNYNnfA9g7sbfbLoQU2aWsUWDFlMOMaHnxBJZyWDsOoRlweWrngdSTm5posVCF+E+wHoFmrP5Z3e31LYrrPEL1R5wjZzKQuXZ9ovE+ItLCw7LtUzKhMnKpXR1+ghhJWLQiMnPjlcG+9RyZ7Swvy8/aXCxtgcsNo+AT/ho5FwG7t/WSMj/zwq66Iylkx7dlEfzj2c1jZiq+0OK1W2WCksOAH7HslPJgdqCoDQCS97pfxJBnxq5rgfN3VxzbPYR54GEJOg1ajXgSqkvuM6imNJQaFWUsd5TZ7KzFMOEbR58y8pKcGHNrrDSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nLW4o5NIyHI7/2eX2T5VPZdkigFMgQsa1j/Ai9c0ic=;
 b=Ld+UrXlf0WoK7DdwtGlzFx1GAHw3TLz3XYQxZ2xqtGVh6FRqzho7hL+UTJ+APuQZSlzaT716HYk+3fD0uuB/r9ANt85xOnO2VNRgx2YIL+etMi5Fyueuk2ofsQZV5vxq0YsTv40QdXKtBJm48IlvAKLMYAnOIVBqJt6TULxZjT6Krbcq49M4bZi/bQ1kMJctJgVScbyIn2My9sJG105UVMHcLCiLegqpKFhL23y/gxlNCPCUBJSal0UJ4ggN+LpsQiSul47CfldPHc6Pf0xJGw+XG/7GJVviYe/Nf1P09qZBwXL1UV5mQF+Rjw55G9ekdlJg3dmjihflVbuN06K3Dg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB10159.namprd02.prod.outlook.com (2603:10b6:510:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 13:39:11 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 13:39:11 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v3 14/15] hw/acpi/piix4.c: convert static variables to static
 class properties
Date: Wed, 19 Aug 2026 14:35:53 +0100
Message-ID: <20260819133816.3497033-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:806:130::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB10159:EE_
X-MS-Office365-Filtering-Correlation-Id: 632cf37c-e1d4-4d63-5f68-08defdf74028
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|921020|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oBQ68auA7o+YlVq15kvUR68u9Z43QdPw9jQmETJunY4C6/5FZtVj801llKoZEF6Mq88C5JF9dM+ML5+hhux26MZjydVMmUVGvFRSMKMeGY+10AhMBsCA5uUe1l9eJ3h3pMXlbdx+9l6BlWUTTOHrM1fFFgSfUKf+kJ9fddYQN6kfOq8Lhk5PwBzTTsx7KhwX3v7MSO6m7MG3mWtP4++X1k/Pp5FeDhJfmyH+OlU+kzXkVNs9QuqemgDwesUP7NpMPa9aPfPDVM56WjM/WJbUXUPpu2P0N5sAcO7pglRa2y45GJkWXic8r9v0CK9+gLoPGRYSbNPQvRsjC5iGtjDEBBJvX5Q5UhkfNKJsaLemPl+47QNRovVDUXGwxNSe2qdgjhSUjpF09iaSQUGi3tOOt5QM5RFYMTQYeOSosUD8dPsArhDeB0++o+8slbLpg1pIQDAy9wUC4Rq3UV1B9cDqlSBNJ81vzZOO5UqGUJBLcqSzLBPXVRmfcjezMSBlfmkZxAqAy/uOUfHM1oQaf7cfE/7LClT1tyyO3qs9fy456Cjr2Y5pdebyx2eWcrK/Lr258VZaPs8HXniXqFNo2YE0Jv+cpZtCInwlkxF0V0Lcm5jZqCNMSSt+a6Jx7Sz5ODkEq4m32qCKQSPEC1loElHxQEe6ZgHx/0HoKgDPIdq9gEhuXHxW3MwbCFIK14pRMSD2n1ovrljiH8RoaqoiVB/k/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(921020)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Rg4VYtPxoz65yL6e6kG21LfE6obwbWRwzsKi97zhhA56ip9ybSMOW5l6hLm?=
 =?us-ascii?Q?tuJdh1J5LuKGdWso5+WWXPhC/BGNzR3pO0qOfGsyu6mmAkBAIKSHFLEeYB3d?=
 =?us-ascii?Q?g3sjB04BfuccESYTpMN7TpJGF3qY54eRkuVjXrdUwSZI+zCFzSsrXdzHzWR1?=
 =?us-ascii?Q?WozrepvHJBL6BDhF3Mt7UIsNz+yM6xhI7TaktG2QbC0ISntt9wn4tKJsD1hV?=
 =?us-ascii?Q?xt0CIkxjLTB75NbI26d2n6qnskcuDoQfLRsKeccfS0sZrVz/fmeSfuZCQl3Q?=
 =?us-ascii?Q?uibW3z1QGH7L0sxUZtg5+8xauSvfNAJRUfwScn3rdxpeH4WJ82E1X29ddlC/?=
 =?us-ascii?Q?shM//A1BWGyKzicVqXIk7nS9+RkKjz9udWVv90t81++Q+ntm5zxepGHQ2NOL?=
 =?us-ascii?Q?tVjvxWuYJbkcoLUHcXgziAAC5AnKMGw08dToddYRS2YqURZVLEPChwayuuhv?=
 =?us-ascii?Q?lwPk3Cil20OKw9aZ72RB/V/egJjNcieBrKpxRYcyFcXVsoTi8FB8ZukQnwas?=
 =?us-ascii?Q?+Y0xysZiV6UXjdMKgxM+LOwOvGXD4vrBaiQy5d33SKnqeb53sYKVgq6FAidb?=
 =?us-ascii?Q?GhFiD1wZXPYi+Vtkr4YAxDAZ58UX3S20C/Tqebf5dpbgM5CflFj1wDvGquF+?=
 =?us-ascii?Q?kadS0q3RNdcwAI33GXT60E2B/czumA0QvZPi/s40elFVHa7bsYGrSqumR1/d?=
 =?us-ascii?Q?mhY2Auw3BLdpDUul1g9L94zFoJZaaGx8gjLbX5NiOKBU3dPqCe4SfcvlIttL?=
 =?us-ascii?Q?8eBCZn+l6wWvoqadN6+D3srKMyIiSS5XcShEodebOxpHjmCdYkdNBOZ0TjSB?=
 =?us-ascii?Q?ebvm8ktZ5aYn7m+Pt96FPNQIpowuiilghEAiKWhRCYITlL73pSeN6tQSo+MB?=
 =?us-ascii?Q?C1WCdstmwn6Q35gzLdnwIqeoJchYon/O7PBm6gum+tOSDH/sNnvf1g4W2jG2?=
 =?us-ascii?Q?mkRLeO+1GIwgBsqEbDU/VRlN0+u1PjbtRJYFVqxVJd7aYyXs2STnhrd6QGhi?=
 =?us-ascii?Q?/BXcgvcKRkT7KlfT3LUVAMQJLT8tiCv5VlPDBpAyQMJUE8SsYr9cg/gczl7+?=
 =?us-ascii?Q?phkqUUVEhMPqRPbVjWiDI+q6yz884go8RZAiCUJYcr1Z10OIjO35WaSC5KAu?=
 =?us-ascii?Q?Gww0pzqtOVrvzOYb3QtYqF2zae6S8laBK4zUEuKY56+wuTROVH95/o3XFN3u?=
 =?us-ascii?Q?d5BmVzol9HlV0z3LmNHV0dbunbRyYy1g8V1OeRc9gcZrgiXMpfqWLtExnaXV?=
 =?us-ascii?Q?kufQYbKUbd7w+ptt8Y3wNZWH8mLQbbIbOAuhdV3koVagOjn/AmqpUMAHwI4M?=
 =?us-ascii?Q?nCPuiF1hFCmYz2XOuGfF3TrPUxBs+4oxt9tD9eZS+7lUrBGO0m650Yd/3lI/?=
 =?us-ascii?Q?DeYzpWWP+y74O/He/zDQJbqOhVhZG7ImN/FyB2XWtbF/aQNsDOJ1eRvg2s1R?=
 =?us-ascii?Q?U6e77smFjBvNw14OMMIESrWThL8i8vssci6P8MH0GbAmPQwuLYmZcHkpZyGB?=
 =?us-ascii?Q?fOujruNcPcPmRHn615vf1S+hZs4JPKenaqtVWmMnzbfJzetO6dtYVi+N7Cze?=
 =?us-ascii?Q?699lf5lAh73NGBME8NSileR3xd805+cdrnecCo2ceJRKKQyfHSPW54rwEaMn?=
 =?us-ascii?Q?KJcPD2zQLQk6HshRkn8+dotYlAYZAZ1yJ6EHEMLUEhd99upYF8n4DxltcdFt?=
 =?us-ascii?Q?aMAzUwrKWBh2OVs0fcoQn4sR2wwmsHjgij1cGLnVo1TMW2gyP6y/99RwvZsy?=
 =?us-ascii?Q?EvzDYL+TIwKWN7rZCeD4fb3fEjbK2yE=3D?=
X-Exchange-RoutingPolicyChecked: GuD3B+1NTSdKQj1As3Hbkc2eDn/+Enpvp+DOGCOVdcxrqhfHbDST/SIaZGAYlVRZTWrQK0fRQnmj5AdNBDgbjc0ZJ6FkFLgGR3MdogrUp67HN+PhxltgYAQe3zhVxNKHM+ELElyPvTQq1hNqKAP8Rdl5dlrJTaiypRQC0jHe5D79xwo+8ilmpdFumDaCBucUeF4xEemmHRdAF3esaSItLWfSX1T/Bo7XpTP75DVJDY3CVY/r/nWhOnDtrXThEKRgDQI1J82XpOhJwhmoKFtWvYXkG1TEwmfCfA0GHPWdkOS7sfZsh200Q30miUcEyXK7eXYtrWYbGBQV4X+SdeWY7A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632cf37c-e1d4-4d63-5f68-08defdf74028
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 13:39:11.0166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPHOI+W8Pt7kIxMIP6kov9oiv/N6uQwmAOBTxM87tgXOKjgcgLI209zIfn+WAh90DHALB/iYMsaj73HSjtSoosb4lsjXSoOmo0eQrc3Gg14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10159
X-Proofpoint-GUID: 8QusZM_mrwvktDu_bEN4oL0TJp8bvTuL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX9Tv27Oqqt+kP
 mEHF6Ugvq28zpPej8fkljgLfPMWtpFCapFXRNawoXVA7Iym80ueUA0AqjfPO9Zqb9+S+rxyqB/C
 Adl2e2EJ1ml2FqDqI68tPL+KjHsc90dBI3Gwfb3+YPEDf117+0xexCLFzYrjYyyyhJPDbZBUsyy
 g2KyC/QHz7dWgQp4nNNu2qW7f46elbg53r5Ez6Fbd84oUdUtzxXVuiydNaY30Zb1fzXRRuU5KxZ
 GEUOLneYn8K71WHHjy2AlEWW9Sgl0WuxxEO/mJd6AnOvDIrpJn0MQ0ws8fQ5hzTS+qldzGrMaMp
 xg01ftui7AnzFaITiQFnuZcT/x+E7Qd1PWH/hKMlfKRk9VxEnK63dLSJtnyUYdTnHEjyBl7XOyz
 TO6pHjR5+I5wUVmN299mvXHrksVLe4XdS9SriVRf5qcQoOCt7ip0tr6exzNFfMsvYrrHYHAI3Zt
 PAqq2Pg2uvqFpLTr6Tw==
X-Authority-Analysis: v=2.4 cv=LpaiDHdc c=1 sm=1 tr=0 ts=6a85b201 cx=c_pps
 a=onnDVuI42kX/OVeLv55qNg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=zWFTgipdAxScIl1IxHgA:9
X-Proofpoint-ORIG-GUID: 8QusZM_mrwvktDu_bEN4oL0TJp8bvTuL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEwNiBTYWx0ZWRfX/85haT5hpIay
 6lWACI82J0ooD6aU1GJH6u9P5/8pqdiedLqJxQfy9pbu8qlZH6ABnxz9mho4EzflYieE+7qcPj7
 YH8sG9CgRBxv99zKtvCE5OWuWx7959M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-19_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

The majority of the properties in piix4_pm_add_properties() are assigned to
static variables and so can be converted to static class properties. Introduce
piix4_pm_add_class_properties() to hold the static properties and soon all
other class props after they have been converted from object props.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 hw/acpi/piix4.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1d209ac96d..6462ba970c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -406,6 +406,12 @@ static void piix4_pm_machine_ready(Notifier *n, void *opaque)
 }
 
 static void piix4_pm_add_properties(PIIX4PMState *s)
+{
+    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
+                                   &s->io_base, OBJ_PROP_FLAG_READ);
+}
+
+static void piix4_pm_add_class_properties(ObjectClass *oc)
 {
     static const uint8_t acpi_enable_cmd = ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ACPI_DISABLE;
@@ -413,18 +419,26 @@ static void piix4_pm_add_properties(PIIX4PMState *s)
     static const uint32_t gpe0_blk_len = GPE_LEN;
     static const uint16_t sci_int = 9;
 
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_ENABLE_CMD,
-                                  &acpi_enable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint8_ptr(OBJECT(s), ACPI_PM_PROP_ACPI_DISABLE_CMD,
-                                  &acpi_disable_cmd, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK,
-                                  &gpe0_blk, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_GPE0_BLK_LEN,
-                                  &gpe0_blk_len, OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(OBJECT(s), ACPI_PM_PROP_SCI_INT,
-                                  &sci_int, OBJ_PROP_FLAG_READ);
-    object_property_add_uint32_ptr(OBJECT(s), ACPI_PM_PROP_PM_IO_BASE,
-                                  &s->io_base, OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_ENABLE_CMD,
+                                               &acpi_enable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint8_ptr(oc,
+                                               ACPI_PM_PROP_ACPI_DISABLE_CMD,
+                                               &acpi_disable_cmd,
+                                               OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK,
+                                                &gpe0_blk,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint32_ptr(oc,
+                                                ACPI_PM_PROP_GPE0_BLK_LEN,
+                                                &gpe0_blk_len,
+                                                OBJ_PROP_FLAG_READ);
+    object_class_static_property_add_uint16_ptr(oc,
+                                                ACPI_PM_PROP_SCI_INT,
+                                                &sci_int,
+                                                OBJ_PROP_FLAG_READ);
 }
 
 static void piix4_pm_realize(PCIDevice *dev, Error **errp)
@@ -616,6 +630,8 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
                                          offsetof(PIIX4PMState,
                                                   acpi_pci_hotplug.io_len),
                                          OBJ_PROP_FLAG_READ);
+
+    piix4_pm_add_class_properties(klass);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


