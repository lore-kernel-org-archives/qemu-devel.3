Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A5DC5DF92
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxNET-0006ev-9I; Fri, 21 Aug 2026 07:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNER-0006dd-ET; Fri, 21 Aug 2026 07:16:19 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wxNEO-0002Bu-Rr; Fri, 21 Aug 2026 07:16:19 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67L9MgOU1901485; Fri, 21 Aug 2026 04:16:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=XbRMq8WO8dqALX1clmDnt0DDWsQAVfA6YE4mF6vhz
 UM=; b=f97S5k67qsySe5anTg6jdj234lmmrN7Hl9Zu2QNYDmTuY87/Yk55LkT4i
 jAEZBGxRkBIv348u0Hvg2QJaYCcrDYfa5vW2NzBGRO8jG3o97mdREWmu9s3TP8oO
 jVw4vDy2W0p7MO+BmJBIIP3mXllZaQTVmyP4lUXZVqDf84cpX53YPGsQh2vlb0rF
 91C5GmQ4xT0jBBqXY0Q0LnEsX7Nahftx0xC6KI83g5JMj5rnEHazDuidsa5NoWm7
 oMJaEZu56dvYntiRVZdTajX6aTi2HX1D4DvtP2RWtt1eo+X1dtacADCLwZnWE6mn
 4nYGr4zaE3DzHNXDdK3O2Gf5fSk5Q==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g6cm1s0sw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 21 Aug 2026 04:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2qF3z11uP0/waGC/tyht15AoxaaSjz4qFjvneuV61pvx+MG8FvaoyOIgpjgmlAiEKjm8JxZ7OFX1JHXsUW1HXaBq/RUVeWdl8H14JP1mQK1ioLqDrH/RudCXty3PCQuG9w++ZPMu8R3M32fZFEGPy8bJ0qMT6yF6KPEkPC3G3lPElxy7vWGZPUzbmgPESQD2j/vbfQXO3yBzrSUCVMz3AqIGXqzisx1r+0dqkR+s3SlZPV+AenWuTucsEmuYPdtkf+/5dfXqod/7jrBepiz9npJWv+MBte1xPMfwuuLMYYnAws5dL0O2t8CHZ1SKewPjcs9GE8DMpzyaVa+WbnVGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XbRMq8WO8dqALX1clmDnt0DDWsQAVfA6YE4mF6vhzUM=;
 b=t0uFO3k7OghXThJk3jChm2GhQjux1KVuck1A3MtxXOAa7W0oaygxMSjN4CFUQdM8u6KP8m7OZNUli7rDAnHrzx3ck+kfpTHYhAUeVfG5oQRapSmjfBxhFeGvt82IUwnKKCwGe0iaCFfFIgYTqMQSoex/nHKq4REFImci3df9/rhDhayHaFeOFC01wg1k5xB/gHs1d6JA/IV+/iFtHEGdAlNjFHbn+gG2a9zZIO0sHPGqYAuMDyRxx9ip/3eLq1kqHCCe1PgVDupgdMj2puSb4x1ylpikHytC7zktVAtCxfMbatoBSlPkF+q9YkVMZuGpkObXWJFJu6SfhI8MbnpfQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbRMq8WO8dqALX1clmDnt0DDWsQAVfA6YE4mF6vhzUM=;
 b=eekXyLET2+kCZyJZpz3FcwjuAHDMA4FmRNWTwRv3+b0cmw3QfOxpGlyoCkWl2atlyLHnikVoFE2KVTn8WmI/u+Oxi5d9a3Hzqa8EdX+GesUmi4HCBgw3szxLlloY/pl1LxYZuR09anYj35l/ij/DTJQZVskOM+msqgy/hOM1JVAmJfCtEcLFYxe8aMiNidMY8/egaEF3MTL8Do9DuO2kp2nEr7e6bX0+1zmPC61bC/W7OI0n3ivssx7pYou/H3FreDy7q1bcbco9cEjVyTNF/pqUuZsVGNSV0IJbElGeoyTEt532VZHM8mAWnyJtl33fIVoPWx+TSU0KyYn0TQ8M8g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY8PR02MB9524.namprd02.prod.outlook.com (2603:10b6:930:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:16:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 11:16:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v4 03/16] qom/object.c: introduce
 DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS() macro
Date: Fri, 21 Aug 2026 12:14:15 +0100
Message-ID: <20260821111550.276011-4-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821111550.276011-1-mark.caveayland@nutanix.com>
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0019.namprd21.prod.outlook.com
 (2603:10b6:805:106::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY8PR02MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: d4d0c683-0256-4364-3a38-08deff759694
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|18002099003|10067099003|22082099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: QrUvylJOYjSeFszrS3SxSRY8CLgkqRaM3KK/kNL7lXlXHsG7wOGK2rB+OGxQVmBj1GuW0NCaGmCFXL280h1yQBzNPsMIxPZn+46E7VoZrE+SJyiWzF7webQh5BVm0eKsRJUJWR3FRKKHehwZQwafe6yPqTKQWZ9od/wdbQmHaGoLHA2bXVtiDM9CrX14C+WSjb7VwVcGzEstr39IuID2LGMuGSnT6KigJj5MceJ6UGTxQ4ydQZ/CBeZ34ShNZRLLhfxQwNv8vV5Z1eIFOwniR5r4hdtPUpRmI/ITRdCQfLbRINCTAhaK+4qOU8WuT6Y/SQTMcNbFlHYPJy4OWBlr3H/5advqWFs01D2u1yEccLYA8bsCptA/JD2VJy0ksnxM44H333k5ZM7QeinCSdWcq5PwTMmSugOpO49wOD3EAkcgtZaBozaOX5OfCtSdGJQzKE1UJ90Co3giWDQkUguAbjPvrBP0727PQz/8XCKTbelf4jbr2aZNo5DUvACEMoVTJmlLtkcGheaDCWzhdMJzPix1NCDbjEm36NZFjJaEKvYdtN5GjjuL/UA+iCDoz21FRE/S1m4shNhGQ+KX0wLDKjvVRyEdWIYHWz70+dHpGY4yJDA4vuddS4Z77ytMr+0pq+tFk1cJDZNMEbxsIJsCabkDiKC1kKJqetBPuUNCeyrjxpnMzuc+hP1jzzre10u5dj7DOBHMzVLFp9+azktTOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(18002099003)(10067099003)(22082099003)(6133799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWhSQVpOa3d3eGptb3JKOU1hUC8yZW94NzZJdXlhNllQTWNyMTIyNTBKR3Ur?=
 =?utf-8?B?TUNZUW9YRnE4MnAwVWdqaGVBb0tTL0Zmb05Pbk5HekVrTUdiUEVSdDk4UE1P?=
 =?utf-8?B?RVB6dmpoWVRtU3lHNEFzLzZMajVHejc2cExwQktBQ3gwYXowSm5maXBsN1Zm?=
 =?utf-8?B?Q2NKdjUxdEEvU0ZxZ1U3cEgybGlvdVR2RS81MStpTnFRWWJrVWdiM0pmOEdh?=
 =?utf-8?B?RHRGZ1ZybzZJUjFneXQ1S3Nja1hiMk54aDFCY21FNE5zcXNRYlVMdFhWWnEv?=
 =?utf-8?B?RnBSRFdlS2JuVlR1MVNmTHRHUGdHc3RGNW9ldDFYREtldjRzN2s5WElCbUM2?=
 =?utf-8?B?N0ZLZldHVUFMWE9KZmR0dnBFZ00xbmZzT0RCdjdhSXp6TmVZVzFRQk9KUHZY?=
 =?utf-8?B?TEd6YWRkUHJDZmxoNlh0MDZkL0c5UHcxaW8raFZnNUU4d0hlUDdoRUpjQVJK?=
 =?utf-8?B?bzRZVWFZWFltMkMrSlVwZ2NTWTVtOEFSMDQwaXZYRUg2NmdNdElNMm9DYzBJ?=
 =?utf-8?B?SnNGUHEzNDdhRTk4eVMwZkNTeVR5QjMwcm1SL1JPeWRRd0MwRlVWNFgxMXZJ?=
 =?utf-8?B?S29hSzA3MllPdEl5WGJibXRtQ0xNMW9hS0V6VnJiWnBYcGtqcHBwQ0VRdVhu?=
 =?utf-8?B?ejNya2d2cmFxSm5CbWFYelR2UmxYS0JzZlpaNDVsSVJBVStKaGN6bzFrNWdx?=
 =?utf-8?B?NDU4aUdhUXlaWVZlOTZBalhjeENXTjFtRUFsbWVQOUJPaHBuZWZ2cEFOQVpq?=
 =?utf-8?B?RC9QaDQweXgzQndQVmVPMDlxRjgyV1dYOXVZeWZ6R2NVbFJMYkVDQUhXV25H?=
 =?utf-8?B?c05jVVdlRzBOR21TTG81V1cyMUZ5ZXJEaTFlYTlIemVvMjFaL2VOVFNaQzF0?=
 =?utf-8?B?YnNDbndaL3YrZldzWE1Wa1E5Zk5ibDdiMlFIUXp1QnRzV0ZCQmhTYkVZRmk2?=
 =?utf-8?B?c3F6djgrMlBEeXZNUWxoMy9DNE9wQzhhRFdtUWJzdFlEbE5KWXJQOXdkMDZZ?=
 =?utf-8?B?MWVCaGJheU1VSVk3SG9wYmNVQU1DdDBVNlpEVGZSbURoek0xclBPQ0wxbzNT?=
 =?utf-8?B?VFhNV2xSS2ZJbVdYMEI2eTc4V3Rwb1dzVVkwUCs0aWMzZVV2ekpsNVhJRkZq?=
 =?utf-8?B?enNRZ0lBSURrdWpyNG13bXFqZUExd2p2YnoySk8vWEc4bUZtMkYwYUxhZ0pj?=
 =?utf-8?B?Slh6dUNOUlBGekV5T0Y2azh6aWdwa3dlUGtTZFZYRnA4b2VoUG1PZFNseU9y?=
 =?utf-8?B?QkhCRnRzZ2NrS3hKUW05UGdINEtJaXAwMkRCd0FBMU9HMzZUZlNzTXNnNWhv?=
 =?utf-8?B?cythdEVTZG5JQzdZRzdHMXRXTmt1Z0JTcFdORUxrZGh6dHRSdmp2Q1hZclo4?=
 =?utf-8?B?KzZEQlIyczB6eS92b29GSm5yK2pQdHkzQXlWTmluVE9LV1E4Z0VrR0pIMGla?=
 =?utf-8?B?VktyMWhzN3lDOWE0a3hINVZSUm5HQjR4bFdGRUlibnQxcWRLYldXMHY4bnBU?=
 =?utf-8?B?ZTlXcFFDNVdhQzJhWklKeDlsVzRRRWFoUnlobUd2RHZuTFdaQXFZT3MwcDJk?=
 =?utf-8?B?RlpyaU9jZmFKdG1oM29wUzZ3UzdodUEyT2tOMXduaTJkd1RqcHQwZTBjNkJS?=
 =?utf-8?B?RDBhK0NKN3crTnM5dEZyc3RrYzhQS25xbUVGVUlQZzlZaUozQUNsckl6dUhV?=
 =?utf-8?B?bWwyVHA1MVlpU0hXYmI1UjBLTHR1ZkdKWGJ1aDZwNWtTS3pwOWZPSndTeFpQ?=
 =?utf-8?B?UitxVCs1blM3T1ZQQVRwS2Y2dlYxbjliajZlTWo2MkxKRUhVWnB4Z1VvaUti?=
 =?utf-8?B?d0FtMWU1QVBSZWp2RGVzSVNPSHhYaHFIUDhlU1JQSVd5Nm02dmNSZVhUVFYv?=
 =?utf-8?B?bVBUanM5OExtenlnZXJ3V085WFJXMzRYSXR5a3UrT2pSOXVreHl4SnlNcVpP?=
 =?utf-8?B?QmJzUmJVVEh0U0pGRWc0b0Fpa3JTa1I3WEYyRDR1QW12WllLUW50aUhuNmdl?=
 =?utf-8?B?WnU0ZXhIcDl3OVhPVllLZFh2UHZMZjgrdldmTkVMRUxQY1A5TmFvczVRM2Y1?=
 =?utf-8?B?amQrWmxmT2RIV3I4a2M2MzJnRlZuRUJQMldVcDNRY1ZKc0VVS3czVGQrRzZh?=
 =?utf-8?B?RXcxNlNGclVMWW1KV0JpdENhOEs0d3dRaGRiYVlIc3ppNUY2V1dRc3AzaHB1?=
 =?utf-8?B?OFR4N2ozRXp4d0RhV0JDRFNLMEZVTGFLRnh0Ym5JOWdyclRPVm5WZ2dPWlVt?=
 =?utf-8?B?eW1UMUdzSVFlaUY4eFIrYk1XY2c5bDU3ZHdaS3I2dHV4OW1lTmNuMWs2SUVL?=
 =?utf-8?B?M0lHRnBJNGNkZk93V3lVemdOMTBUWDM4YldXcldvNnlJMy9NODkvVU9DZDl1?=
 =?utf-8?Q?dUvqBLxfEG1fx+yA=3D?=
X-Exchange-RoutingPolicyChecked: mgZr3HeEr309TiplAGo8xm+s6kI7Ok1r+dIcCok3M6iy0+rIVp62BpAkLgoigFUvh0iL5Vt29SBPq/2RyGwM8KYH9BVyI6AqFHRF89IZd/NuL7vU65e7g9yC8R3ZSMzRGk2EQcpUaNI3kpPTeBvMyqSsFrPvDsyOAJX+uZMQn6MyV5klIREe75pliDzbBOBLpdZlje9C/7kC1D0E8slfHt3d89MccLSF50/1rxaQEXByTaCnb0S/ZNu+f5PL7M2xP7mcQvHNv/DDgyOBk1WS+UyZ1wEe7FC9NBqHkBcBP5R+VvW8/Fn3ar4MBYFxWqJ/PnXUEPUhkgjTt/zOWc/MXQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d0c683-0256-4364-3a38-08deff759694
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:16:03.7253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg/ZkduJ9ITVP3H0ajuuVP7M+VJcPLTtnYmXaNEV4KQuVmNC+sNjLHArRAet0DyMw8YTUUEKGqB5UGsyzsaJuwgsKOXvdcMS+vuf7Tf2qgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9524
X-Proofpoint-GUID: piPOummG42LqNsk7oomUlCZ2X5zo4luk
X-Authority-Analysis: v=2.4 cv=J/qaKgnS c=1 sm=1 tr=0 ts=6a883375 cx=c_pps
 a=KI7s4FTSNOfRXFB7i9gQ4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=UWV-rqafSl4XcmA-RNwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: piPOummG42LqNsk7oomUlCZ2X5zo4luk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX0ABDrnW5SIkv
 cydA9GKBFmmh2gBkEGwWXzVlVZgKk+pAanQ+Ja2hedVFnYqgGo/0TPcPz6mGo27oYm3taH+DIem
 jnvtijgR0eJi+tqAZv4L60vvg+IYROYKsizExNAXhiHw/ObciQrKSpVggJx3+oJslD144UCxAdA
 lJ3a+I6It4wHPuCnOQ7NUpBFSLuVcqDSs46KLOWLrxVbwWoHNTW7NMjHP3rrjurW56RQEbOsEr2
 UILe2ex+tpC/4sGK4rxT0vx3qShIgPCkK67E7rG+HWC1kwcLV42xiuzSAdtwYOTl+X6gGh6hu+8
 stlSVj2BLSAu9tMx+TQFWUJtohAAGap7yvsFL7jdF1g+dSJ6qkHBw4Q886Zo+gkKTpv5ou2VDPJ
 OZUYgHUAStmwAD1PxwzZ5MGac2OVNyGuI/PS14vEk61gBEHoOJw4Nq5PDtsOvRqLVdaRN6/8DDt
 pxXTAS0BAjG6Y8dDStQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA4NCBTYWx0ZWRfX0FCXlNKh7S6X
 Pgp1eKSg4AKgVC45ZqmfE/e3YMWl1Y4d4CFz+qoMnK8fO4e/2zYrdsngPeovt45Se9uRStWSt5o
 X9VepiQARra8da/tp1NczSOo5CoMArY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

This macro defines both the QOM get and set functions for the given scaler
type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index fe4e552928..9cb2cae4a7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2738,8 +2738,13 @@ static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
         *field = value; \
     }
 
+#define DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    OBJECT_CLASS_PROPERTY_SCALAR_SETTER(type)
+
 #undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
 #undef OBJECT_CLASS_PROPERTY_SCALAR_SETTER
+#undef DEFINE_OBJECT_CLASS_PROPERTY_SCALAR_METHODS
 
 
 ObjectProperty *
-- 
2.43.0


