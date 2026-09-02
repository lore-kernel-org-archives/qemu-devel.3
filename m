Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E75AC624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAg-0007pl-OM; Wed, 02 Sep 2026 10:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAe-0007p0-Cx
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAc-0002BP-Nl
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:36 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXVom1205835; Wed, 2 Sep 2026 07:42:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=BVN3ixCUuBQg3/d1alnuhiWbIv8kL6WoKGnbxL4uU
 bw=; b=130YJkoSKrUs30U76LXdWKjLuvnX3Ht9KvQ3AbhxSit5wxKofYaLxJPZ3
 gSqhvEleV0u7ut4Ys+m0gGM5gKKi5X7nMdoIdSrD3OP1+AblMPWJAetCjGvGC2s+
 3oP9p9xV4MypHu4oKf+K6E67HyWW1du7m0dcizTG6c7ACcX5PWzGz4+AyhnHBX65
 PmpZIvOzI28J5HHLPse/OBgNvEQZ4603H+KO6EvmScSdAVG+iCByYAVMJzP2XoVj
 l7+iYkqI0LYALgL978ZYMLRr/KzXHdLRJBtzuenxqktI2PKpvPoikMAnTseu1WQc
 2nRt43zcsdBfR2mSH07CuwbyHhrdw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022120.outbound.protection.outlook.com [52.101.48.120])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge100u3xk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGuLjtszdrUjwuFqrvQ3D69GAXZqF2qU+RM8IthYVDkGTnXGYljJTzkRBCZgKMHyQi57RZp/xVXoeBqX5X3qM6kA5S1BZtryc47TpmNyy0UdXyca3oHbW+kRrwbBPC7d1Gg942YU2PpjY5fcCour72amR/n+Xkc0l5IwfRgZf8E2dfiKsQJC+TTvRkmPMpKpwkxU/6D514FnVpEZ6K+s8994SzcU1Qww2kXTRrHasRVLYisPe7d2IllFUtFmtdCIwdqDT/ydgy2wMglmAabRQI6CQbX0AUAMj0JtG34nsLFkMxgwqTMiHtBziLatlmWyTQkyhKb7uRizdNOFMHlxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVN3ixCUuBQg3/d1alnuhiWbIv8kL6WoKGnbxL4uUbw=;
 b=Zjs0zqzguE+tzdYI8r206x13b9Y6AiON4X+RT/FicowxhpjhUiH2Vu5cNxKE5D3j0x+VPDuUyUhn8YCsmhmJ4/OHvOZPPp/oZW+2JzH9prak2xwYmRClhmrhdP3QFwAPPnaYPw4xjdA/9J0KyKVRGJVWqRC/9z/3JyExdHy9iEAbHuyhHh3Lzh9401cTa/fIWT5oiZ8QgO6zbYcfCMgT/FhJtYLvYrllThBoOyi/l87mmpZHwrkNNkatrLwjIIJdp0R44LRecFdsHNxHJ/GwlOgCndtQuGWvWVvu+/c+2WOMp6u3ku2qL6xdinN3M/vh8jLR/yGiJrZP6KuwSU1LMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVN3ixCUuBQg3/d1alnuhiWbIv8kL6WoKGnbxL4uUbw=;
 b=IOXoYqKXWmDYiSwaYHoYHyTflXlEeE1XbmjKBpnLjG9NmtG4+JFyXIxnTDZNSOKHVXh3dIPaFvBnL+IGYyTvymzxOPJqCcVqiLemS1Xd29BHvguSs/sJF+oW0EWSlwQe1xFJx8J9lN35CTK5nezDqrGpIHDJrr1usJ5mv+oaJD5MRTb3ypEGmm+Gk+hUFxUAFLXoXIDn1FKrIUE2P5Gj8/hoP3Rdb2QbWoTrSCoafOxLTM5fi8ehFqgTi8WXr6RGhYKbFkwGRwM0uoAshNbH7yrTGxbywqo+CubH2Ux1ey1OaTVFbxqQ1URnP2BQPgT7jL6FYq/+rzzg0AAQOf7vQg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BY5PR02MB6978.namprd02.prod.outlook.com (2603:10b6:a03:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 5/8] hw/i386/pc.c: convert rtc-time object prop to a class
 prop
Date: Wed,  2 Sep 2026 15:40:52 +0100
Message-ID: <20260902144207.2553037-6-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BY5PR02MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbd4991-fba9-4059-e50a-08df09006ac0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 4wrOQXx0rpcXCemst0L2tQ+c4uYhsbk0ryMVI+FP3qM9lbgKEt+noTIx6Wwmq7+u/iG5fWTaK4l7Px+ruffBT1NCM3V1cu1aVBw4uauEwb+RB/quh94E4vGZhDuBQqTyn3uKu7Owc00vjcKjS0oVgzfuj4PPSBJGnIjdUkS6ERmx63CTjao3n1PykDtCwOTpg0nGLZ3Yt9cS1uKTqEq/GP4SPRIufGgm/jUh1bRDh/dD5LDtGfsN4mBC2QlczGmKEI9e6VqButyQss1sqrBrN2fZQ4/niRAuByACKq049RrMZWieGcK8eG6pjj/lft1fbETKnAF6JIES/hC/MjRWFbfckOgoi+tgVCMHzEnD9HEO3xSR7DC88PzcCtKkqrwKQgP/j+wSEsRtqSNAooWaOPafhRrNF0Dy9QP6zfYqumaCVVfuYKgoSXdTH2j1RgBC8N52rt4J6xdWtFx/M6SdSHCZraQZGtA4zzvSgotLcXbLgSzlSG9jxyMWfNiF1CScN+XkgGBk3lcVKP1T7eNrb43Z3EL7MRYq7auim2jlJLmFcjoGqllXp3DS7ESeufedWyAH9XxM7JeRUoZZyACk29Z94wYKBBILAyNRvlSWWMsI/7Uf9G4V1qZTOua8C6tGjThIdhNXirmUh3TYt26ulaMtGhNEVZgmgLW4pbeLx8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlVbFl4KytwYURYcW5Va2FmY0p0bFR4T3VQSnlDYk1LWWRvNzQrWWdiTlBr?=
 =?utf-8?B?aUMvWm0rOVZDcnBsWWMwK2g0WS9UQ3VvRXlENXNGYWVKZXE0RnZkNVNUNjNV?=
 =?utf-8?B?VElVWFZjRU5ueXBQSVJxOWZReDhENW5NcWtrbXJMUExCcnR1MTZwODN4WUZj?=
 =?utf-8?B?Rnd3TEVmcldvMzJMdWwzSmRDMkNNSFhxQTRlQ1c1RGZzVmlQT3NMVXdVS3NC?=
 =?utf-8?B?cjVweTF3TUdIUmh5YU1BbmsyZzVaa0diQVZjajJkaWVtbFhLd3ZZNWtwd1Nt?=
 =?utf-8?B?UDREamFRb0laMUFIYWc5ZUd3VFRhSmIwMFhzQTQ0dVBRS0pNQTRzQ3g1U0dl?=
 =?utf-8?B?TndDV21ncEJmaFFseDFGNHBOS29PbFZVY3hMY2lzZk13MjRldnZLWmszUmU2?=
 =?utf-8?B?NWhJQkl5aHNmQUtEMVN0WnNHV1k3UkRvb09IZlkxVEZ3Vm52cWRIVU90U3pJ?=
 =?utf-8?B?TWZieFVZeVRFb2kyZEkxYXRaNGViV0hDQmx0M3dRbHRydnNZWnJaWTB4WlFp?=
 =?utf-8?B?R2h6c3RuaXRVOXFURUJETUtpRGxpN2t5TkphTXdsUFpNcVZIT2xwbEN0NmFI?=
 =?utf-8?B?SDVTdzlxYzhpWm0xL0NYSTdWUzRGWExpekhSQUtSS1BSdit5cE9PcldvSlVs?=
 =?utf-8?B?SjRRMUptM3I1cVVnMXRrRFluaEkxa2JQMXlMSFhLeWZPVW9TeDZ5SitMb21K?=
 =?utf-8?B?WUNRWGJiTXFqS2podG5HeDB2U3gvdFN0bzFONW5KVUtkZzFGZXViQ0dhOHYv?=
 =?utf-8?B?eTBZb3VzbmZzb0NMZXJnMlkxRTdDRlZkNkk2M2k2NFNiUEc5Z3l5U1pnaGl0?=
 =?utf-8?B?Q0kzdzI4S2wvZFN6REo3aWRqNjJpY1hVSmRkSnNVZnZWN1ZCMGhGSUhnVTBl?=
 =?utf-8?B?bFVHU1BSNFNRU3oyR2JlYy9MbHFEOUdNNHFqbTI1TWhYUU16aVRKcUdzUVdz?=
 =?utf-8?B?eUN6VStzbElTMHR3ME1xYTc5L0JnZHNBUXlMd0I1QlUycE5zZStvdTF5ajVp?=
 =?utf-8?B?bFBqMm8wYnpIK2UzVDdYZmZVbGV5TnhaczdmKzNGb0ZqNUgwdVlabHd2dHJn?=
 =?utf-8?B?MmVHbC9XR0QxbVVCTWd3TEdLY2xjZ2ZwZ2lYdjRkaC90NUViZ3dFRTIveDVC?=
 =?utf-8?B?NmpGNnpCYnM2a3krV0pnK2p1NU5rVDYzWEFxeVVrSFJKVFBUTHE5TzNwWExI?=
 =?utf-8?B?WGNucUVDd3pCYVh6c2YyM3RCMGhoL0pzTm5hdjRFTkhnd0U2SHZiZVNVS25a?=
 =?utf-8?B?b0llRlozSFE0VmNmQVRXREMyaFloaWJhb1pmQmNMUUVWK2NXczhBdUsrMi91?=
 =?utf-8?B?TVo3YlRmVk5zWHFNSnFnTVpQZ2xFKytzbUsxRnRPbUFjUnB5S29TdWhYOFBO?=
 =?utf-8?B?RUhvQ3dlbUNpV1B3WU9rOU1yc1JGaDJrV1NCMEU1VkJxUUlNejA3dnVsSHNE?=
 =?utf-8?B?SW5rN1VNUlFCOUc4ZTJEUFhzUS8vaTlLK3BCckVvL214dkZaUDhFSGpaN200?=
 =?utf-8?B?VVdhUVQ4Y3RzOFNtL2puR1U3NThBblJ0VWFUZU11NnVLSUE3aFdLK0pNYy9h?=
 =?utf-8?B?d1h2OG1Vc0RDWVNMNXRSbC9DNFVFSE5ralN5aDZOTmR4bDlRUWhVclhPU3NX?=
 =?utf-8?B?a05id0FicDFjN0VjZmY1eE53MHA0aGl1cjJrK3hGREI5Rk82U1dxeXNodjJO?=
 =?utf-8?B?Mk9QQ2t1Z0JZZG5NUnpjRWtuaGI3cFVLK2NIRWNqNzFnTEk4a3Q2aFJobXhY?=
 =?utf-8?B?Tm52ZlFSTWZBR2NZUnNuTHluZTFMMXVkQksxZlFsTTVRTkN6RDN2Qklqblln?=
 =?utf-8?B?VS82cU1EZzJ2SDNRaHJPT2puVm1NOWU2T3AyUVZmZWJtUGZkZExSRFY2V0RD?=
 =?utf-8?B?OXpnWEtpU2VldWNxSmdMVW9CcjBtNVV3eWRNalRZM0JtMmFoRTh5Q0xhUFUr?=
 =?utf-8?B?OHBlUnNXUG41bFR3RUQ0bTRqVVpwVmdrbVg1Q2pwcGNqT1ozOC9oUzFuZkNr?=
 =?utf-8?B?WWEvcDlISCtvZEtsa2I1U2V5OXFzc2ZhNkI0djVURnpObVJ6bEJobGMrQmxY?=
 =?utf-8?B?SzNvbTJmT2F4TUpHM1BHODVHZEo3SVZXdHEyNUhQMEh4WHZkWGdmTkVRVXB5?=
 =?utf-8?B?cnhPQ2RPc052TXlKWDFHZHdCK0VBZmROQXVPaUlPWlhPUXQ3SWdnYTM1QVBE?=
 =?utf-8?B?ZUZ1T3dEMDFFbmcrb1BESUdjYmMxRGhvaWppR2VlUVYvZHlLYmY1ZzBab0lh?=
 =?utf-8?B?c2NEQm4rTVpiVTFjVHoydVk4MXFLb2wwNTBUUUY0RmVEWFlhRUd4MTdIcW5T?=
 =?utf-8?B?WjlZNjZDVG81RnBEbW5mcCt4V09NMnFJbGFVWVVsV1RGT1NsY25BSFVWLy9C?=
 =?utf-8?Q?23kYTOUdpwegKMPc=3D?=
X-Exchange-RoutingPolicyChecked: DSD/1joS++1zmMHcf2bSsPiOVEsfd2L4lS8qn9tZqCZLjqwcqD8cBsvHqMjfkyLkUPvUK0zzapxrEY+SoT06oWIp12UUGQEBl4VLYZwBjXlxHXLIRMA0vcvYtQ+tHwHGqL6TXv7Os9SICNv72kMDtWQgcIx0h92qqLpTqeSaY8TslOieYEH+wGQ9ERDgUmrEKcfI8AUJR3KpASHcG63cZ7ge471lULBhj09/aOZ18abWT/vxXhIvIOFtT5wrhs5ap45Fo2BewkMcanqG318joa9c7lBdhie/atldOwnhP/b34qw1943lV/3Dv54cXVUzzlB7e15g2w3cp9YVl7HDlw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbd4991-fba9-4059-e50a-08df09006ac0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:30.6559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX0N7ztWQCHescSQWxqZukybQzvgJPNv59HtXXXoXRaRWyKDElyh6uV3oBCzqJfKG4LvisYRf7B0EydFBVKZH/zNb5OILeSTW8uS6ivbDG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6978
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX8S6JhMT6JNJ/
 VJXZP9FPTI0HqFyZKJiEpiWbrw+YAwPV3CqeB7HfYjzg3Dvf8D7WvaZK/S1gbsV34UQjLb+12U5
 iKmCt//KkQQY4XQmcVCGm3znMYTmCwI=
X-Authority-Analysis: v=2.4 cv=JZuMa0KV c=1 sm=1 tr=0 ts=6a9835d8 cx=c_pps
 a=MceEdFpa07MrPAxPau0EtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DDMMZ6NTPqBClWpVUZEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Kt0FcYlphsP_4YpujNhA18BBUiOex_J_
X-Proofpoint-ORIG-GUID: Kt0FcYlphsP_4YpujNhA18BBUiOex_J_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfXzGrCzsJKyB8u
 1sAeaf3wAVt2JZJ9mMy8k5ErtZ5gOBCHau6Olb8DbGK4Y0NMMlfvtAaeIZRRHX8byw3DdBDCqzD
 R/e6of504KLdi5RqLxZRNjGEoyVP9xx5QdN8IHLyvUyEHWs490tlDgOO6AXvZybnGEg9JoRd/UC
 YKnDkTUdyNVG36H7FJLyqTAWfggXcqdfOBgfhf3Q/KqAygD3axfbWgLClxqfc1PVBfNJHNk5Mef
 XlwL4cbf/D1dUhsCeaNYlqmgKzybcDZIsRpFE1UjGkR4r9am6eB0EgelI2jow/iHk0mmz1jOZGC
 vBJPsc048HMaCzZe61tK0noiefOuSM5G+zhOeYVp/4LZaYWr/Gn2UNiAs4UPSHVJH2O+qnbtBv+
 gBIrslD289fVbOX2bSMuJe29bvG4giXOBXiCwlKbfE2aJoNU2azI7H5AHmuxkIANGpT6znHKNH0
 YCL9fHQxSqihcCIFbBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bd800e7ff0..0b925ccd8f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -39,6 +39,7 @@ typedef struct PCMachineState {
     BusState *idebus[MAX_IDE_BUS];
 
     Object *alias_pcspk;
+    Object *alias_rtc_time;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5293c59d66..f8969ddebc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1097,8 +1097,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     }
 
-    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
-                              "date");
+    object_property_set_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state));
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
@@ -1792,6 +1791,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_pcspk),
                                     TYPE_PC_SPEAKER,
                                     "audiodev");
+    object_class_property_add_alias(oc, "rtc-time",
+                                    offsetof(PCMachineState, alias_rtc_time),
+                                    TYPE_MC146818_RTC,
+                                    "date");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


