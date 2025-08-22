Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F77CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfs-0002Cr-IS; Fri, 22 Aug 2025 08:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfk-0001v6-KL
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:15:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfd-0000qd-21
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:15:04 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57MA7uhL2824419; Fri, 22 Aug 2025 05:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Kch221Ty1TNCyV8Np/NBxaD/6LyFYzy/nMX8c2x3+
 TQ=; b=VFVcnp5/yLPLhsSWo1z+2dg1ubBeUzgUx6CW2haae4hQnqG2UsuY+y2+T
 lc4mxkNjiYV1FjLwNyhelLEUVdYULk2ZYssTlXKnpp28HfnNQAJyRf5Uab5y19KI
 diJVmypC4bROmOOHPmp869/8bIxxSoKax6gYldhVqlYXkuND9pamzty4ddnC6Kyz
 LsqGRspDke4V3hPyPxAVVm1SaVKKlGhrBpwTVYAK4+QPdMpXT0b4OyV7PkIrIUPC
 pxi6zQ7cpS+Ksm4tDie5ZO2d42VHD+3lggBqgfe1H/1o8NnwsiB/IIjTSO8pdn10
 GZf3jZCV7d3QGqAnJ8MG/M+B6AK+Q==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48pphe080n-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dYEpSvpRShpdn6OjD39+uo/r2EhokV7FlYGnGYQeu7ltKJUgU/CEIGW5bvBPLAvEQZ6guAKGQbsRSFPF+6gPSRP4LyppFPBrol13BOkfHkPF6sW7PVl6cuV+IA3N12IISuhU+a8j64EYYlQqfxcyJBa5F0RLw3VUgwrjQOGfybBr9LuMEib3q6UEKwJGZ1OxKRepFeB+uC4EXaBiM3qPV+6uhooEEISLoUMLPLZROn9yObQqpH+edpnjHQdsAA3yU5Eo5FCeIbdCrobYeDOM9RuDC8EBMqlZyTLf5fMd5jAQ/8g86OMluz6tsBmyBjQF8U2Dzag6wH2HFdYFcbi52g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kch221Ty1TNCyV8Np/NBxaD/6LyFYzy/nMX8c2x3+TQ=;
 b=FekTCMFCywm8mBCS6tpl+JXxjLDUm9fxmhpLhvP0nSkWHYg7tIMgbNUDNAztGPHpGsZ3PoRBDMoNVcmdP/8p+Quj2NOnTFxDR5Z6uPxcw2WUkw0WxxgINTpBdmYjc/IBvkVEcoEZg81H0RtWZW8SbB8O/ZOXfZsHzq5JOxvFI7hFGEIiQvBg943YRFXUtpkv8qKTlGVtbAiBD9aPCoMo3+Nv2AhuOHgl32GVaXZ05JkzmIkI57kJXre/1WZQqSSbvMlG6eFRimXCkAeDoAX+9aPd1cEoMbtsDILtsXhrh7Am0YWUNBB+75d7Fl3Szz156/5BIcHVICxvwpo43l0Byg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kch221Ty1TNCyV8Np/NBxaD/6LyFYzy/nMX8c2x3+TQ=;
 b=UNiOVgEAQG+LVgZqDja2eJkJ2SRWdmxLc2M3l/vP1QTFwco7jBTHi4NhPD4eAdKH0rsxyruAHZ0OV4WGrBZBhd+moB9PPgkg4sl0Gho5ul5aqpRJGhkmc+9SaAnn8ZiglO6yKKRb5bqkcVk75JtPEZ6esySZjpFHDi7DMq/t57Ut1+NXdILK0JOiRYjAnn6IJxiterCYDJb036s3q4KUrMzBaxFW77SatDrYNDO0OSKW9mk2VnE0aWeILVLMoQINzGT02knbLIo1BCqn8kBGDQAjcmLdxu5u6nsOC5QghoWFkTGEhGhjGtR8/AnHAXjtEsROWdx8vXsr2vU2s0Hgjg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:53 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 19/19] hw/i386/isapc.c: replace rom_memory with
 system_memory
Date: Fri, 22 Aug 2025 13:12:05 +0100
Message-ID: <20250822121342.894223-20-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0180.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::49) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b9ca9a-8130-4e0b-085b-08dde1758016
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dExNWm8yVzdOSm85Sk1yT3pDMEtlWFh2U1BUMnowSjVEdWRZZUp5YmF6NUEz?=
 =?utf-8?B?ZEc3dW9PR1had2lxelhGU1RoajhXZ2VlVVVxcUNzbERoT2lQTzFPa2NRWloy?=
 =?utf-8?B?ak1WMnN3dFE5eTd6VzZFUmNabDhvUWpuaW1WNlBMcFJiVExyaktkNTljcFBR?=
 =?utf-8?B?UGZsUGRSbjBPQ08xWm1vN202ajV6RElRT2ZuTkxJU1FXc1RhaldTc1NJZlBs?=
 =?utf-8?B?ckVMUEtwbXlpTzJYbnpmeC9SZnRDRW5hV290LzN4cnRNYnk3WStIeExLa0Nw?=
 =?utf-8?B?TGlnWHNtNU9wNU55WWlkbi9Pem5iVFhPZU1xUGJNcW9nWFJJTjNQa3BHcXVS?=
 =?utf-8?B?WXR1bklNdFpjNHJCNUkxdHlHTTBHTGVMSkxXNlpvcDkxRkNWN3VydXBuUjFO?=
 =?utf-8?B?SkQ4c2ZEYVppTTNneE1lWmpMZlhxdUZWVkxDOS8rVEZLaVNYTlFWSXRnaTcw?=
 =?utf-8?B?UmUwenVjNndVL2RaR2tGWEkrNXJSZUxlQUUwZUxnUUhxZVpDOWJpQ1RyWWwy?=
 =?utf-8?B?RE41dU40NGVLRFJ3eklPYmlVdDk1cHdpZ2lwdFNKU1c3cVZwRGlITDg3djVt?=
 =?utf-8?B?YmhZWDB0UkhqbDFJR29XVFRMcnB0YlR4bElLVjFFV0FiTk9yeERZWFVLUkJW?=
 =?utf-8?B?WGRuK2RuQVRiTWJiamxJMjllaU9GSjFDYm1QbGNHNGczZFBjcHRidnEzOXRJ?=
 =?utf-8?B?Q1ZjZWl2cTUzRlZvd0NGc2gyQWpZaVZsbFFRRmMxejJVV3REQTRwUWh1WGJ6?=
 =?utf-8?B?UzY0YlpuNVY1MFUwT0JrOUI5Q0lVcmVycVFnUHFsdUV0YkhxMXUxNVpVZk01?=
 =?utf-8?B?empHZDhxVjRFZFoxd3I2NE9UVGE0ZUp1c3k5bTRhQ0lOUDdaTzJwNFNkOFUx?=
 =?utf-8?B?RjdNZnB3SDlmRGdSUE9Kb2JscHVGYnp0TDVRZEFMU1czby84eE1OLzRzbHhZ?=
 =?utf-8?B?bHpsNXpDUjhmdDVtTHpSQzZlS1RlQ0l2d3ZyUUx3UHNrOGJ5dmpBc0RYVHh1?=
 =?utf-8?B?eHJqRWwzQjNTREowcHpjeGV5V1RQZFRxUDNsc2IxVVM1cS9IeWZJT2pqMkpi?=
 =?utf-8?B?LzZJSGRpU0dPSGprT0FOQmx5VUpDVS9NNjR0UTBCZDZVM0xJS2NwclgwQ0hh?=
 =?utf-8?B?VEtQckRxbFB1cXgxWkIrb3ZSUnVIRHhDMzVQWjJxaHZIL0tHaWlsYjJQQnhG?=
 =?utf-8?B?U1lkN3BVSHNsdjdrTG5YQlNZOU40SkpjS0ptdlBrcEo0ZWlVQ0oyV2VvV3NP?=
 =?utf-8?B?eWtnQ1dLSWpCdndPQXhsbndDTjAzOUE2VUJ1YjNTdm5CNnhzak9DTGJLNG5q?=
 =?utf-8?B?UldYOU8vOW44VXpoaDZqaDVKN0NaWktZS3grWGlDUVcrS1Z6bHNXYStJZ0Rx?=
 =?utf-8?B?bFlyWWtZbDV2NVhtblhZMXRzVVNxM2xyUzNqUUZDWG9iZVpLV2RqTjdhbTl2?=
 =?utf-8?B?Qzh5Q1hXYmh6Y2g1Snk1YUREMEJRNGo5TkRveDVvM1Q0dDBlV1B6c3hQMG1T?=
 =?utf-8?B?dXlMUnlxTldtOFNmTmErYjVaTzNCQ3NGM2g0N0N1L1ExYnBkMWVYQUNTRTR6?=
 =?utf-8?B?bFdpalY2YWEyREdxTFhyZ1BGbGw5R1dVc1RXVzBBTVdOcW1HaktGMVp2bDNv?=
 =?utf-8?B?Q1M0d1BHK2JHb2lNaUI0VTZ5Y2VkVllpTmVwOFZRQWFoekt1WVJiZkZPK3cx?=
 =?utf-8?B?QURlTExmOTNrR3FROFZleE4wTGRWVTJhM2NlZUVaYjFVVDAvVzJPMkpiZEhU?=
 =?utf-8?B?eTdvdEpnRXJOa1VYZE9odHdWTFJmREp2bjdneW9rdFJ3RXMvam9jV3kwK0lG?=
 =?utf-8?B?anhxWTBrM0xzaG5aZ05zVnRQeWtXQjBxbENFaFJpVDlEWmRBbWFCWGFQMXlo?=
 =?utf-8?B?RktpL296elZvVWlOTVA3RTJacmo5bmltMUJ5MitvODgvOFFBMU9rVElOajRV?=
 =?utf-8?Q?5FTocXbeGDw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BzdGdzdW5lYXBaakRHQ28zVGYyaEZwTFpuSE9ISmpINE5nNzVURFRpVjE4?=
 =?utf-8?B?MSt0S0loaTkzRDFYb24zeEY2NzJGOEJiMWNwSzVMbFVzZ3BCUGF3ZFBTanZk?=
 =?utf-8?B?dENBT3VpM1ZqUGh2MFEwWW1PWHVLdGpJeE85V3M2akRkN3piY0FuUmtYNmIy?=
 =?utf-8?B?RmVZaElmWmgxbFNqT1NOYnlITjBzZTRrdWl2MG8zQ2toUDYxYnp1WUFwaGlI?=
 =?utf-8?B?VHFWSFFZeWlaR3BoQThFZWRFcllhVXZEcTdqbFhvVTgrWTJJZXIxMmZPWnk0?=
 =?utf-8?B?ckJJZFA0OG9hRk5wNXpneUIrZHk3eU40NGZ4eVc4SC9HRjJveHlVTGljUWRk?=
 =?utf-8?B?MWVab3UxV09BbG56YVNkMjdmUU5DbmEyQ1JzajBtRlYwQ3RUbmhiVmtWTkRu?=
 =?utf-8?B?Q3E4VXgzaGFiemdBbmJMejZiWHFGT0dPQjhjK2RIT2c2VTFQdnhrOUtDT3U2?=
 =?utf-8?B?dmxZMGZHQmo3YmhubXJMNmJJVWlyRGk5RnF4emlGU0lUaTVNdUZGazAzYkhh?=
 =?utf-8?B?OUdTQ0h6R2RYcVd2Qm45dVVtYnFkbjBJRlkrQms5VHJmS0dtSEtiZmdMOS9l?=
 =?utf-8?B?cE1ZK1JKcWxxTDh3bzNaR0lJMm1RU2tkK2xtSC9yVzhzTXRyL0E4OSt4N3Ir?=
 =?utf-8?B?ZFd2b0pjbjF5MmREWFVZOGQ1c204SlQ0NVJwUXJCamJUckJQTHlQa2lSSERG?=
 =?utf-8?B?bmZzQ1MyUE5PM3QxRHh0Y21uTzhpeGg1TWdueGRsdDMyaGlna0RSY2pmcXo0?=
 =?utf-8?B?ZkRsSFFkZU5ONmNJWk1xTjQ3c251UFI1UE16ZHkvOTZScTRRRDN0a09XMG5h?=
 =?utf-8?B?cHVoQXRKeFVaNGtkMG53Y1d0emlmNktNOEkrQlFyTnlLYlJQWVZ5NnFuaEhV?=
 =?utf-8?B?czRuMDhWSG0xOTBKanFDWHZtaXprL1U0cTlaaHd0eWdoMTRweG01UEtCZDVw?=
 =?utf-8?B?K1ZiSnRuMUNycklaYmlWdmNNVTZ1N2k1SHgvNUJHeFlyVjJINmo5KzBHOE85?=
 =?utf-8?B?aGtJa2NUMXl1WGxEbi95UjBpL0FGaXJSdGVZd0EwaFFZdXNQdkxKQUFLMHVD?=
 =?utf-8?B?ZXoxa1p3UHhjaDlnN21PSVg0bFd3QllUYTBSVCtmRndPdmczM3F5Q0ppclc4?=
 =?utf-8?B?SU56L3hVN0xVTmZMR1c3WTBaVC9pell2VDkwczAyc2FQbVdEUVNhSmdrK3RV?=
 =?utf-8?B?NjJMZGZuTGpqdEd5RHB1Uzl5aThBNVFxaDRaUm00SXY4eHdsZE8rRGQrMjRy?=
 =?utf-8?B?eXh4RzVKY0tJSnRTM1F3MjlhQzZCNGdrY0loM0NZOXFoZ3B1UmhyTHVBNzVw?=
 =?utf-8?B?KzVUL1R6L01UUU82R0NjaFRnOWhtanhCN0lBajNmc2JwNmFqeFRkdncweFpi?=
 =?utf-8?B?UUJiVUlsK3hId0ZJV1pabHlUdFVrbVp6WTQrRkdmb1c0dHZaclVwOWJjbUxQ?=
 =?utf-8?B?M3NIRXMvVU85VFYrWXdDbnVDWmhrUlRISGdsRzFDeWFtR2psamR4QzF1Q2hK?=
 =?utf-8?B?NDlnM2lTS0crdHptbWpzZitONTVFdzNEeWdrQ0FTTUpCUVFYK1pXMlNXY2RN?=
 =?utf-8?B?eHNRR2hWMWNIQktOQjRKb0thcFhLSmtXNkhFa0JJNUpGVE5mMHkvR0tRQjc3?=
 =?utf-8?B?WFFEV0lpQ1c2d1IydFdLaDV5VXJwRGlsM1F2VXYwNDFwbUlxODlHTGVJdzla?=
 =?utf-8?B?dnFLNWR2WGpDaVhmOFQ1OVJ4Vm5TZVYrWTZ1YjhuV2o4SXFEdG95d2FNK2R2?=
 =?utf-8?B?SzdSajgwUGxrV2JZSHBMK3hjVEtRVmhiTU5yQkJQRHlaUzVsa2Eva3daUisv?=
 =?utf-8?B?L1J4M1IrSUMwT1V4YlcwK1Jid1BERGJ2UFBUbjZpalE5R0xJbitIS0E1Rmpm?=
 =?utf-8?B?ZG0vWWpWRmpHNzNpSGxzS3NjZHhSditwVmIzTjh3OHV1QXpzMXpWQytGenRU?=
 =?utf-8?B?OGVIZ0xISmp0VWJOTS8xUmdYOSswT3BnRUhaeHkwa1dVcHQ1c1U0MFV0d2ZK?=
 =?utf-8?B?K1Y4WGNzdFliWVhmWklGZFNzaGtxOUNsRXlKU1VpNFcvS21JbjZxczN3Rk0v?=
 =?utf-8?B?cEJmeWkxb2ljWTVOd2NQaElWUk1HRm96YkVMNEFCZ21qdkFZSElpQmVlSHVw?=
 =?utf-8?B?NWptSDRoTGZMdHFjaEc4L2wvK054ai96MytiYU01OTJodGgycktrY3JPdzlx?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b9ca9a-8130-4e0b-085b-08dde1758016
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:53.5503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIeM7zBJlcOokkLebJaCdGL9Z7BmIIoK6k0/RN3Dho9tAwSlUhta9pnnaiVKQ8N5I6yA64N0Y5BSOCFZypQk2/uAIX+qiLVIYRITYbe4OKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Authority-Analysis: v=2.4 cv=PvLKrwM3 c=1 sm=1 tr=0 ts=68a85f40 cx=c_pps
 a=YKE8LuPMBYZ6rjMuwm3XPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=k_ivhQKdL2eqRxG3LxMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: srxCYTzWeqSoLtx7c1WFURb1LhnJ9_Oj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX/UL+wEFplASw
 6gg4p+F/4JvLbcdsrTABju2K1oJOhIPXNVn9ZnvAMeFt/aJY+tMVK8bJXkKPzj7D3ePNxPWJkBx
 GE9xw9LBaavt7PnJGpGTI5EorqY0h4FYh9HGfOZTTEA3ylz5jxvcmk8LZe/s/xAXD3RvgRaJsGK
 LSKMpe+vP+Sk382Fe2i++kaHTs+lPbVBEvFtbGiSZwpeFgGGAkqySaHqg9VtAknMYtghrXFppyM
 U7UFw38reCQcDLrDl9qmDKXMTsLuocilutT9zZ7B3ls/MxU9CYmvlc8OzyOBWVxEbzWxadUiDig
 dVCT3OMPpsY6egFXd0II9TJLa8S/Pd1UvuRd4AYZ2yAKy2b9K+dufl7eh1Y4UIbZ69BnaSwzpdp
 BFKzSIo3famMRAn9k8JNKwPVkO9Bug==
X-Proofpoint-ORIG-GUID: srxCYTzWeqSoLtx7c1WFURb1LhnJ9_Oj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

Now that we can guarantee the isapc machine will never have a PCI bus, any
instances of rom_memory can be replaced by system_memory and rom_memory
removed completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/isapc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 62acdada3e..87193beb44 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -37,7 +37,6 @@ static void pc_init_isa(MachineState *machine)
     ISABus *isa_bus;
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
-    MemoryRegion *rom_memory = system_memory;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     uint32_t irq;
     int i;
@@ -76,7 +75,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, 0);
+        pc_memory_init(pcms, system_memory, system_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


