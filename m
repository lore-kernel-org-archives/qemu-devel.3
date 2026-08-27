Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC167C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzbC4-0000LE-UB; Thu, 27 Aug 2026 10:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbC1-0008Rw-IO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:35:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wzbBy-00022W-M0
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 10:35:01 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RE8GXC2505491
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xTVJi1LqE5qAJEkj0mI1QSCIxymIyZydebM+BFMHt
 rY=; b=ds+Go4JQwQ1Ka7RxWx02Z/kcxnAsXwO7N+UZEVYPlhfjB3+SEBDSfqXkS
 jofr0ZEAjFHxggq58cV0FBce2QdvBPEG3i48W5a7CQa/eVRx/1Qb+xM8BHI6k23c
 x4jZsPuqa/1o8AAP4oTFhUvJJ7BdGL1EQauWEfLJJ3mN4u/nVAd+s2ryv9RFf2T6
 RTJEHvo06uhMaprlHkK+BExclml3VmiPcsHUGYFLm5IF0MbuumcHyo+vQ6Kb7P/V
 dCgSIBayAe6Akbos+z2wc8JFj8lxl1165louxE0gHCH3yBszZpW11tK870yrIeva
 FTBknYjD0TP7k+A915y/rnntJrxpg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023106.outbound.protection.outlook.com
 [40.93.196.106])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as73gc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 07:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3DPhMxYbJ+OvKI43t8a3clVKO+K1T5mTdyw1rDJFAO/lG2/u6BRj+psvfvxCAv7lFCx8nM+ggWSauyTSYe7wjRxXsj7PtH8E06CptreE7cjiQG85KqyhlyKp8JhvPdihGKQFg1bWAt6Wrt723ooXrKhla14Awh2+DnniPoxLtcg9DOQcRIYpteInk4DEu25n5JBui4cOeRAJQRBOH+vpRXyrHQ8HBXlRJSj6CxoY0vaFnMdUmUjWREdZRen2MjpQ60iFM/KC6p2lFpIJmmQYUIXoEW4N2ei8OBRLmUTrEibngdTM9YjyvPW5mbWxdFC86DN2oOhYqxhxSXrtx7sng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTVJi1LqE5qAJEkj0mI1QSCIxymIyZydebM+BFMHtrY=;
 b=AxQJvwCCEuf7nUpyhraz0YVU9fykb4lAZ6P7jlz5agRKvk5h18Mgcn9QUW/Fqo068iiYWgEE2cJik/gAhI0DLXrYInZ8b7UNRZBW2RGiaM3G/FbaqF/573Pu+EBlCjZjwhy4WbsJBtmIy3NWK3TTiZAiHrddCupRkeKPNkAopYMviqVeCF2p2rKuaLc9jEhZUSjHSjvIIu41u4aMS5sg+m5Yds/fNL8Fpuu8kp60zT6YfDHz7SCtlpWqRptP54bs7Ia3Bc8Lf2zt5PjiwT04SY75np9pjwPTXrv49txJHrD1w/Ly7m4YuSNlN+ikUmRJfkeMzpJrlcaHoIWcqup6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTVJi1LqE5qAJEkj0mI1QSCIxymIyZydebM+BFMHtrY=;
 b=qwCYWTnVbJpTwfz0pTFyGWiSeavyGA9coRqoHCNbioXgT2IQ+XtqlGbWcWsurFC2LEqJIoU2iRepLnJ0dm82glPavzd4FA08v237v2hcqx3frYyaV+qOhR9b4kF9mW0EcTJy5mQlwfdu/JXFNdBUrVcDghrx6Tiw0aMUv88jGkHjz1zS6WY+n6HpEOyCp18G2ZSSg581/n6RS8u9PlsvrQX8HM8Ub18BbHPq26ioDolNJkvsCk9aziV4RHD6DX6zlvKDiYmUVDoA263rbJ/f1VDgePYK4gRN4r+EFSL5283rNotX540qJhSAZP/l5I9UvSroCL9oOIBIN1XE+5F5rA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BL3PR02MB8114.namprd02.prod.outlook.com (2603:10b6:208:35d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 14:34:56 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 14:34:56 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL from
 object prop to class prop
Date: Thu, 27 Aug 2026 15:33:35 +0100
Message-ID: <20260827143404.1393166-15-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
References: <20260827143404.1393166-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:806:130::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BL3PR02MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: 74af5421-524b-47a8-ed98-08df04485d62
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qz5i+R7ZXVeL0ddDoqt3s9y/6fXijIRx7ALaPvGs7DtZGPGkbrXWxOYTF57eSyBZawUzT/X8LonUZAJ13K72+ZWM4HhDXDLwZ5mUR4F2hTPqGUiwrMLuSm3kHIOVuKSYH7fM8pWIQpkhXy3RzNujqqbZLoivR5gL2dxCOjyS64Pjwf4AJV/zWQy+h7FFj0scK8j/pkISS0mskS570koRLgRf/HYQaPJYj9LNpMf5AjVeRhLuEzquMBHIskZrPaT3yWfjY7z2eSHGczd6OAR5Et0b6Vn42lE1z+oCrkiSK9bc4tzA9JLJWBpYFBZCNOvnXEOHvk6UwpPUMwTHbmnF4Dg+XKMz0PWiqtav9way1EY5WFtlJ+vak2BQgda/cME6EPKWSKwfcGApW3zFNyOy8tguqqFodCGOSnFP6OFq0lz2rLOMNiE8C62SNFd24Gg5ZEe5F+JLqrGSHpJp4W+5E4F7OWogf0pcmTXjUWTSnYKAkUWpsnbfV44wv5whZzFfhpXTeFX5nlmuKWyLQhOG9JhPqJQI6eTcG5wH0CG2boHm9/Dgk8wtmYkBQO+LUGRIusr8brS5JSRjTW3hbzYFBXi7Ve454k+5dA6Ear2WqE89sjuITIzexqz+9D2FPr23GVTugYN8TFZvo0W9heN6FKzYtC5dsEdMnXZK/kep+hI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJqcEwwVXVIT2FKNW9tRGc4UE5LdzNuRVVVMVVrcVVPaDFsNSthbkkvdDZN?=
 =?utf-8?B?SkNmdXFlRzBMZlg3WVkwaWtMcmUxYjVabWdhZGVwZkVaNGltMmI3cWg1eGlv?=
 =?utf-8?B?R1czMWxVUWdzdzhUcGRUZ29RVjBxaWlDM0Y5NWxMc1hqNDB0aXRteVVRMXRX?=
 =?utf-8?B?dDh1RUoxMUpveFhmcnR2OGZCd3RwUU80OElXQmVtK1UyK2F0cjZLWG5Xb1hF?=
 =?utf-8?B?RHdTdXJBek5OT2pxazVwN25wazZmbDhGT2ZLYlZkc05mcWhZNGdERkVmN3M4?=
 =?utf-8?B?RkFKWlN6bkRLMzAyMzZkZ3JmZUJNZ2pMM2RpdUI0d3VUQVdZZDdqelRoZk9j?=
 =?utf-8?B?NThTWXEvcGlRdk9UbUk1aVdFaHc3ekNid2VUNitsdlBkbE9LR3lPN2ZPb2xD?=
 =?utf-8?B?RUdoODlkK0swY3l5WVQyeGNVTlhWTlA2NXpmcE1raUxzS3RLSG5JSDMrbXZh?=
 =?utf-8?B?ei9MMGdodVhRSWh2N0VFb1pEaXU5dXhMaDlQNTJYL28vbU1rN1dZdkVOOWND?=
 =?utf-8?B?RDJHTWZicnM5WDRnOUNQdG1MQVNkci8yYTZGWDFrR294c1NjeTNueWxkaEV6?=
 =?utf-8?B?V3JoWTB4cTBBTWZXRnFjVWJrbnVqTk9qeURtY0x6bjkzcG8zc0ZPVEJVNjNP?=
 =?utf-8?B?c0RzLy8zaCtaa21qd1N0NTV3UTJXNVY0ZjBLUHNXN2Vtby9mRW1laG9Gbit2?=
 =?utf-8?B?REFkK0lMVDVoVUtqWkZnSGlVc1Z6UWh4Z3lXYzJlU2NYZlROYTJ6VWRjNmxG?=
 =?utf-8?B?NG5kbklEUklVcTQvZ3NHdldJeE9lYnBqa0g4VHMya3hjYXRKTEVZRjJXSm1l?=
 =?utf-8?B?R1pabzdNcEdORkxqeGc5QlAvYnBlU2MrS2VBaDBRamRQU0p1eFVpTklWTUVz?=
 =?utf-8?B?ZXU1bHJoeGNEWmIvME00Sy9ycjllM2ZhbnQyNDJBaWVZenk2Y2lLRnFablhE?=
 =?utf-8?B?RG5WUUhBeTh3cFFrelN0eENWM2w5ekFZMHhMaFV3QXNHVjhmM0Y0ZUh0Z0FI?=
 =?utf-8?B?VENnWTcxelM0TXNoRU15dDNWa0FZdG9tUGxnMUFxNFJVZkhTd0ZDT1JwSDV6?=
 =?utf-8?B?aDFCREdyeW5qL3A0aTZtdmYzMjRFcmtka0FMeVBJYUJJWWRDa3hxVVNjREV1?=
 =?utf-8?B?eGRxa0JjUGZNazgzNHMyL2Z0Zm9zR3lrYnJabUFpTnVyd1puU25PdzJYZUVy?=
 =?utf-8?B?dXJWUklLR1NhU0hLR000bllrVTE5OUYxU3orT1dtN3p3dStVdTIzQ1BmUW1O?=
 =?utf-8?B?ZjNsT09rdU5IN2tGbm1vVjZjRmNmMmRKd3NVVGMzMTNhbFJYZ0pEb3FkSmJ2?=
 =?utf-8?B?VGsrU1JVdU83YUd4ak9VczFKWTRpZERmdWV2ejR0QXBDcmRodk9BYWpEMEVI?=
 =?utf-8?B?RGZEUnlDQ2lod0tnZmorN041NmZkTXA0OXBXQTNuZjNqUE5ydmNRSzRMSmxV?=
 =?utf-8?B?R2NiUE1qaXluMy9lZHU0Wjh0azRtSGFuVzBIaVJYN3V5eXppT3NSNGMyMHRj?=
 =?utf-8?B?SHkxWUI3NDdwWTUvWkhnU2RBTDgrOE5vd3RyZ2lQT2UyYU5RR0ZMUUZja0gr?=
 =?utf-8?B?UjFLWWtkTGtqMGhManlkM09zRG1idld3NDlpQmYwQTBTdjF3V0FLUGwrNVlw?=
 =?utf-8?B?WnlYY3hndmpld1hGNi9ON1FHRU80dTVPZXZZWVkxdVErZVQ3VmwwcVZhVEQy?=
 =?utf-8?B?eHltR25JbnF4dDhYWEk1dnNEY3ZjT1FkNWRSV0g5d2pSL1ZCODNCQmNBWFZR?=
 =?utf-8?B?TitwR2ZHU2VrdjZjWlMrUVdRQUEvTmJOL3Nwd21kU0lzNUNxcjhtRUtxdVJL?=
 =?utf-8?B?RSszTlZrNXBVQmZuVHFVSmVzS1YrbkprQjZ0QkZmODVsdlFGMENhSGpuMnBP?=
 =?utf-8?B?aWZmWEp5ZEpQSnp1SGE2bndMWVozenBoYlJZc0E5YWVJVTNZTUdOSWphVHNj?=
 =?utf-8?B?dERrMG5laUZtZElZaktaM3hsRUl5b0I4VThNSy9MczAzWlZTQWxXRWJOUXpz?=
 =?utf-8?B?Y3hOT1BHM1RjcjlDcjEzaUJIQ0VPLzIrWFdDaVBxeXRVbUovZjdUMG9ZOXRS?=
 =?utf-8?B?NmN0ZTA4M0srZitCcitac3owd29WS1U1VVVwb0xKeFJ3cjY4WVB2STBDaERQ?=
 =?utf-8?B?dU5VNWZWR3RuUGtnYytTTnBoejF1Y25kdXU1T2ErOUc3R2VhSGd6WCs5NGx1?=
 =?utf-8?B?WWl6NHRrZmpnRjU0b2dSUWRLaVVzV2RQa1Y0MWhMbGh0dE1sSlZPbzZLTkpJ?=
 =?utf-8?B?V1V3ZTdEQWwyKzU4WjdGS2JTbWxJSU9XZlNYd1N0NDBmczlZMFgweHlHTEtI?=
 =?utf-8?B?TElHSndVdVJ1UWtGdldUSm42c2pGSlRsTUM4eWZvbnJiUjdjaldKdFhGcjl0?=
 =?utf-8?Q?dojHui9ylGbgIbHA=3D?=
X-Exchange-RoutingPolicyChecked: IkaE90h/aK8LF1BW+mnpYFWDdZ15Eqqx0b2fP2mWeC9iwHaOdQpWAL0jyUd307vqJergtG/HYzu6uqhAXLfzqw9HIrg8hvEhU+n6zzAtExYgQANWEc48d0h2K2qD62wgTret55rfxBqI+iWoVk+hkdi/Xd1UobgtSuM2m0jkmeVXTJgf8mtiNAT/q76HyNin9PCmy4wklPP4EKF4wG+Gp/Udh92N+NH42YQkq20XG5U04YfhhZ0KolOvDSlRKg5IIAG20LtycoCysp6f00q5564Mb0JalkPPuB+J/mXIsOXQCbURN+P5MoFApJrf8jnF9yXnz/bKQ4Mu58RHjjtR0w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74af5421-524b-47a8-ed98-08df04485d62
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 14:34:56.2495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzrXLjqTFsDwKnNjuTq2iLdSRKud5qxt2BFhWDAmdgwBddeGtndtp+UZ/roTd/1Nquu+XjFSCAsHos7QWkpg3YixPOuAG1lTWgegxxGykfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8114
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a904b11 cx=c_pps
 a=glTcUGO0A6QcesvNX5ZrRQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=Yyzug1Ypeymz-iOESlgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX9Cxqcgf+zHNP
 BzDGWm/Px/Je6RMn7/Fx9EUTJ1NADPMPrjLHtqrwiJyDnWJEJgyBm3pE3rK+ph6HPa/BYrvU7aI
 sArF/McsalpOV4/2kUSmAMhn0ePQUjY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyMiBTYWx0ZWRfX4T0polXiobgn
 npwmB4Uqazpjr8QJTTS172Jx6vgfJtDhX+cTS322UeGpT0zC0itU0tBCWMpegoz4BaEWa/hsGn6
 w7UJ3ZWPeIqVHkNiqKIWfG/3cDKypamjKF9mLZPPlYgtrK7Az4y4/Lw7PvKBz5pP3PYLAB0ciTu
 SZNrd+Za2RrgSC28N5oooPEeqb/G60SZJjGUF97wQc1QJu1ORo1Mv5qGR32YZ/m6uff2U0g2NBY
 jPrKLBkoHgFF6XcGNE3yFlZtHc5M8Pl/nmxNElQzQn/c+e5e+7KSrpdHEg+FDwIX0LV0coHX+NO
 L4bxIcpwTy8irGurB0PafOOarKfwojNq0S5NI/WPvua0/P9g2shqg2TwowyNBsajeQJP5Tlk2ic
 VGgCsBWuXbxl29fEPDJ1mGvLk7bDCZ2clNVCYKlcgRM9c8a5nWddpmk/3VB2GXntcHJqbKDxW/w
 9PL0xgeZTG8A3FwiZLQ==
X-Proofpoint-GUID: amdt0V_pBpTXKkHU6DSUHqff20iscX7U
X-Proofpoint-ORIG-GUID: amdt0V_pBpTXKkHU6DSUHqff20iscX7U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update all
callers accordingly.

Since the existing logic checks for the existence of the ACPI_PCIHP_PROP_BSEL
property to enable the relevant ACPI changes, set the type of the underlying
variable to uint32_t with a default value of UINT32_MAX indicating that the
property has not been set.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260825134320.1039012-15-mark.caveayland@nutanix.com>
---
 include/hw/pci/pci_bus.h |  2 ++
 hw/acpi/pci-bridge.c     |  9 ++++++++-
 hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
 hw/arm/virt-acpi-build.c |  5 ++++-
 hw/i386/acpi-build.c     |  5 ++++-
 hw/pci/pci.c             |  7 +++++++
 6 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index c738446788..7ecb23d13c 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -56,6 +56,8 @@ struct PCIBus {
     int *irq_count;
 
     Notifier machine_done;
+
+    uint32_t acpi_pcihp_bsel_val;
 };
 
 static inline bool pci_bus_is_cxl(PCIBus *bus)
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 394a919479..1bfc5431f2 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
 
     if (!DEVICE(br)->hotplugged) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(br);
+        Error *local_err = NULL;
+        uint32_t bsel;
 
         build_append_pci_bus_devices(scope, sec_bus);
 
@@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
          * generate hotplug slots descriptors if
          * bridge has ACPI PCI hotplug attached,
          */
-        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL)) {
+        bsel = object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL,
+                                        &local_err);
+
+        if (local_err == NULL && bsel != UINT32_MAX) {
             build_append_pcihp_slots(scope, sec_bus);
         }
+
+        error_free(local_err);
     }
 }
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index a91f523c93..b26ddf0a26 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -58,7 +58,7 @@ typedef struct AcpiPciHpFind {
 static int acpi_pcihp_get_bsel(PCIBus *bus)
 {
     Error *local_err = NULL;
-    uint64_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+    uint32_t bsel = object_property_get_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
                                              &local_err);
 
     if (local_err || bsel >= ACPI_PCIHP_MAX_HOTPLUG_BUS) {
@@ -78,18 +78,14 @@ typedef struct {
 static void *acpi_set_bsel(PCIBus *bus, void *opaque)
 {
     BSELInfo *info = opaque;
-    unsigned *bus_bsel;
     DeviceState *br = bus->qbus.parent;
     bool is_bridge = IS_PCI_BRIDGE(br);
 
     /* hotplugged bridges can't be described in ACPI ignore them */
     if (qbus_is_hotpluggable(BUS(bus))) {
         if (!is_bridge || (!br->hotplugged && info->has_bridge_hotplug)) {
-            bus_bsel = g_malloc(sizeof *bus_bsel);
-
-            *bus_bsel = info->bsel_alloc++;
-            object_property_add_uint32_ptr(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
-                                           bus_bsel, OBJ_PROP_FLAG_READ);
+            object_property_set_uint(OBJECT(bus), ACPI_PCIHP_PROP_BSEL,
+                                     info->bsel_alloc++, NULL);
         }
     }
 
@@ -730,14 +726,16 @@ bool build_append_notification_callback(Aml *parent_scope, const PCIBus *bus)
     /* If bus supports hotplug select it and notify about local events */
     bsel = object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BSEL, NULL);
     if (bsel) {
-        uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
-
-        aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
-        aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
-                                     aml_int(1))); /* Device Check */
-        aml_append(method, aml_call2("DVNT", aml_name("PCID"),
-                                     aml_int(3))); /* Eject Request */
-        nr_notifiers++;
+        uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+
+        if (bsel_val != UINT32_MAX) {
+            aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")));
+            aml_append(method, aml_call2("DVNT", aml_name("PCIU"),
+                                         aml_int(1))); /* Device Check */
+            aml_append(method, aml_call2("DVNT", aml_name("PCID"),
+                                         aml_int(3))); /* Eject Request */
+            nr_notifiers++;
+        }
     }
 
     /* Notify about child bus events in any case */
@@ -848,7 +846,7 @@ void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus)
     Aml *dev, *notify_method = NULL, *method;
     QObject *bsel = object_property_get_qobject(OBJECT(bus),
                         ACPI_PCIHP_PROP_BSEL, NULL);
-    uint64_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
+    uint32_t bsel_val = qnum_get_uint(qobject_to(QNum, bsel));
     qobject_unref(bsel);
 
     aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)));
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index f6386088b6..d368913e76 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1207,6 +1207,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
     Aml *pci0_scope;
+    uint32_t bsel;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -1269,7 +1270,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     aml_append(pci0_scope, build_pci_bridge_edsm());
     build_append_pci_bus_devices(pci0_scope, vms->bus);
-    if (object_property_find(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL)) {
+    bsel = object_property_get_uint(OBJECT(vms->bus), ACPI_PCIHP_PROP_BSEL,
+                                    &error_abort);
+    if (bsel != UINT32_MAX) {
         build_append_pcihp_slots(pci0_scope, vms->bus);
     }
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 8837b69687..1696821048 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1198,13 +1198,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     sb_scope = aml_scope("\\_SB");
     {
         Object *pci_host = acpi_get_i386_pci_host();
+        uint32_t bsel;
 
         if (pci_host) {
             PCIBus *pbus = PCI_HOST_BRIDGE(pci_host)->bus;
             Aml *ascope = aml_scope("PCI0");
             /* Scan all PCI buses. Generate tables to support hotplug. */
             build_append_pci_bus_devices(ascope, pbus);
-            if (object_property_find(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL)) {
+            bsel = object_property_get_uint(OBJECT(pbus), ACPI_PCIHP_PROP_BSEL,
+                                            &error_abort);
+            if (bsel != UINT32_MAX) {
                 build_append_pcihp_slots(ascope, pbus);
             }
             aml_append(sb_scope, ascope);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index d3191609e2..e8e8a3b767 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "hw/acpi/pcihp.h"
 #include "hw/core/irq.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -187,6 +188,8 @@ static void pci_bus_realize(BusState *qbus, Error **errp)
     bus->machine_done.notify = pcibus_machine_done;
     qemu_add_machine_init_done_notifier(&bus->machine_done);
 
+    bus->acpi_pcihp_bsel_val = UINT32_MAX;
+
     vmstate_register_any(NULL, &vmstate_pcibus, bus);
 }
 
@@ -302,6 +305,10 @@ static void pci_bus_class_init(ObjectClass *klass, const void *data)
     pbc->numa_node = pcibus_numa_node;
 
     fwgc->get_data = pci_bus_fw_cfg_gen_data;
+
+    object_class_property_add_uint32_ptr(klass, ACPI_PCIHP_PROP_BSEL,
+                                         offsetof(PCIBus, acpi_pcihp_bsel_val),
+                                         OBJ_PROP_FLAG_READWRITE);
 }
 
 static const TypeInfo pci_bus_info = {
-- 
2.43.0


