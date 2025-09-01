Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1050CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 14:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut59I-0005Id-Q9; Mon, 01 Sep 2025 10:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut59D-0005Hz-Dk
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:04:40 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1ut59B-0007TW-5R
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 10:04:38 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5817HIiA2223450; Mon, 1 Sep 2025 07:04:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=1hBa/mXt+2cZ4
 kl6Cwsmay0MKzjW4LTxqVwfHwGiaQM=; b=JBUBqvRDOq58GSU+hD90oESjF93gq
 celvUaqiJxm/jl6ik2BorQTrX6nbvZbbn9Zq13pUSqw1Ff6WZb7OaPe22mO0dImK
 FBS+U+ywOO3yHq04W9vFjmnKMVOHXm+cKHiT5ZGXb0a+BC7NepdFObwb86NTpjhG
 GAR6oB8EqyHCIgGt/rzmfj5nUlfpDfoxnrG54H94G/HFbJkb08DIy6A82fy79tuo
 27JRZJ6NGNdjU+RiMBSxr23nRYvfg9D9+zNPuzeUq5gKzjorjtHHTufvU1nPxINc
 0kKKuVEbh1AGRk3L3zwPG97lav/al24/UXWkQPp8xmLdzeHmsI0e04zlw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2123.outbound.protection.outlook.com [40.107.244.123])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48v0uwka4g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 01 Sep 2025 07:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIklczsI2vjeQvoX8F0POVsr3j3Yl39lGYwcAhQb1o2DU3lgl4FmyYB1oxPN84Zm7CXsZpjX7n+PIuLKGjG4FVhwpaEcSJiTFUGQ/rJ7uqBC0Wu8YGF3J7NDSsZSCarBQdcbHYd4llL58UqWKMPcSAA2gh1Uu6/oEkNNIMjrUidlwf8qge2n+0tSt9sFmB3bWlHzRIPShD61DOtEO5NBOrkmQP7vmteV2AYSWhCxOuMW/EyBs12AiTymZMDOAlkY+YtZHqOzjJO74DJkm05jQ5drJ6XTxK4QK4zULFG4TujZT0i/3sFewWiOnIyKMBWyuL+ieWUL6UyADECGH6vtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hBa/mXt+2cZ4kl6Cwsmay0MKzjW4LTxqVwfHwGiaQM=;
 b=O2yHSa6l8WghnOgIsV7KwCIiFon7A52o+44TbwR2ICdOxUDqks7Z5ZBBJeI+O+v2o/StpnPbX8HGpV9c+cZ1Es5G+I8XjsjnsTYFSQE8JqTM15L1hd4YoCeut2gcsStnUk3Yw5tBSHtWr8ADpgvDgUDLnIukeQHvVTnU3pr8L84m5hsQ7v6Y2ZWyjlVvreBdqcEA4RH/dH1VXg+3falPrsgACSnoyvpLblBzololFCFkICDPvM+cjzi6woF+7A0e/NfdCFGsZx9+037RtYvdZ2OqRRe0s5TCvinWWsH8xG8VSaq2iQMcUJyfBj9TXEDfAlqz7ad+DNqBL+aAXVw61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hBa/mXt+2cZ4kl6Cwsmay0MKzjW4LTxqVwfHwGiaQM=;
 b=jIl4V6eAyUujlyK68K8A1MOQNy5XGcZ9eaLCkfeD6u2t90AmwjHP85XIQ6bsSutn5Z2eBpgvasbFlBBGOWq1lvh5ijFM3scyonBmStVsxer284RtDgL6viOh2I9drttwd8L1rTrqNjZNIgHrJXrKLBdCckhtkFvLmfPuY6gDVV2zT3xY7LXQcekb+Z8dsSELrjTOl67Kf3lxpYuoEW05lRMHaJbUflW5er0s0YOb5/2thm9NfzCQ6gIIJWDKaOZ+XGww2l69w6831sqB4JKDtPzIf/1aQtQtrOORgM0ZD7RdH0R4o9C/m+GrMpYE1a9cBfXvO0+CjYUpqhhkJcts9A==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by SA2PR02MB7513.namprd02.prod.outlook.com (2603:10b6:806:136::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 14:04:26 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%4]) with mapi id 15.20.9052.025; Mon, 1 Sep 2025
 14:04:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: philmd@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/i386/pc_piix.c: remove unnecessary if() from pc_init1()
Date: Mon,  1 Sep 2025 15:03:34 +0100
Message-ID: <20250901140422.1136949-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0010.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::20) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|SA2PR02MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: fca392dd-ec23-4e8a-ac35-08dde96075a3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDNBTUlkc0NTUXVqY2I3VGFjWDFSVy9DWklYRjMwMXVEcHhKYlhFWUQzK1Uv?=
 =?utf-8?B?MkwyTDkrcnBYaCtsSUw3WGtlMHN4ZFdyWmJjZUFpU1g1cXVXcXY1L1Rzblg4?=
 =?utf-8?B?cXV4NjJSRm91RzZTTmcvbjZCRVd0VUE3QnFLRzBobyt5cS9uYVUrRDNQc0VF?=
 =?utf-8?B?TFRtT1RqMEJrNUppL29BRDdHeDRJTVhDVllib3NyaWpQWmxoQTNZVU5FcG1T?=
 =?utf-8?B?Z0N6Nzc1L2JDWXVOQnRkSGRsaXBsZkNpenVTU2hEZTcxdENYQXU3M1V4TW1C?=
 =?utf-8?B?TzhYRE8zN281VUpxWHFiekFXRVErdjlYRUQ0SXZYTTdjYXc5TTRNazZZSmRO?=
 =?utf-8?B?dVZkd0xRdFpWQzNXRmlEYlU4b0ZXb3pwVzEvNHBSNVdVNDd5ZHdHWEl1aHV0?=
 =?utf-8?B?ek9mbTdsS3MycWpINS9tZHhrZjR0cFNhQkRkZG5SbGladnhiZnRRUFFwdkxW?=
 =?utf-8?B?N2JyRWo5UEdBWXVYTEEzZ3RKWjZWblFaKzZVUW5xaW9VNlNBV3hXbUpFTkZB?=
 =?utf-8?B?cDNGa21wT3I2R0s3eFJhRDA0VHZHc0Jlb2g4TS9vbjZUV1ppSXVqOTFveG5X?=
 =?utf-8?B?RUplVzZLRkl0L1FaNE1LTFJ0RURuWTJFWHNaMEVRbmcrNDBsc29oek0wZHBC?=
 =?utf-8?B?c2U5YWQ5NmRrUXJNcEJTaDd5d0I5TG90TDdpc1UyY1k5MCtrQ2JRM0h1TElZ?=
 =?utf-8?B?V0VVRVBHeUNCM201S0NUYlBUK3dpbzhNUDk5N1NMcTV1OE9ReUhhdXRVb3I4?=
 =?utf-8?B?VU0zdHBmcTJRNVJrU1pWaytCaVNoSGwwSVA2c3pUcHU3RW9BZ3NxU2hLSFFi?=
 =?utf-8?B?MXVDdUhMWHYyNGpIVmhJb0hqTm1PSlJGTGVmRURVZWQ2aS9PRFZwUndxM0JF?=
 =?utf-8?B?R2JObFdlMktjSm1NbE1aV256QW5XRzk0cWUrVmYyVGNSVmMrL085ajFFS1Zp?=
 =?utf-8?B?YU56V2hnU3Q0cjdQZndnSW1yQWkyM0QxSGNJcEdqTmQ1YVBCQXRONmtsVEpV?=
 =?utf-8?B?d3ZUbFJ3TzY3WVhZcTNTaVQvSVZVSVo0ZEpmZW1jbnI4L1E5alZzS3BQZldx?=
 =?utf-8?B?T0IwR0xIMVlNT0s3aDJPVTRmQ2NPREw2ejgrQ0RGMVBXMEZNTFdZZTV4SmRZ?=
 =?utf-8?B?RmhMSitBcGdUVnhuek9IUlluU3dSMVIxcnpuNlpTRnpVZE1xS0NRN3FGbXAr?=
 =?utf-8?B?eVlMbzJEK2xoM3RRb3Z2d2VxUlFMcnRHZ0tvZHVDSUprMGxsZ2ZnUHIzakZa?=
 =?utf-8?B?cTRKUDhRSnJxcC9tTHlJbVFlZkdDc0RSR3hIb0dTS0NCaWR2d3pibzNLL3Fx?=
 =?utf-8?B?a1VLMnVxZG1OVXcwcHh6dkNMa2ZJdXBmR2dUcXdQVDdHWlRjTHZYTkRMRUE3?=
 =?utf-8?B?N3BBcHpQaFExSmtqdGNvSlE3OGZpOEgyektuWXU3TGNidTZZQmt5Zkh1RHpR?=
 =?utf-8?B?R0I5T3NzaVlNa3d4MldrSmdydW9wRmFLeWs0VGxEdWxRc1dMU3h3ODFENFR4?=
 =?utf-8?B?elVSem9lMkt4eStINXRUZlNxSmRiT1pyMkZFWEtpTUZRRURMb0dEUDFtRmFl?=
 =?utf-8?B?bDRnZnZzTGFUR2F4aHRSYm8wNHZpTTlabjhCMkYrWUJsOUFES3JqaUlFOGxI?=
 =?utf-8?B?VXlaa2pUcEV2SHhXdXZxZ3hvNFd1REFXcHRXZGRiaDRRUXhKd1RBNzAwUE9H?=
 =?utf-8?B?ejlCQVlmRGlHYVYzNGd6elM4UTdSdzNHWjg1K3BoTUNYVS9oNHZTR2E2eEVy?=
 =?utf-8?B?QWNiOGdjSHVBeFFoQlZFWG0za05wOGFEY3pnL2prMFJhb0ZSN3d1UHV4bzNo?=
 =?utf-8?B?YnRXc1dDTHdkQWUyZm8xdUZjSHJ1SDkzT1kvcE55VXFBc1pHeWt4VXcxZ2Iv?=
 =?utf-8?B?VWZ2V1lMaXh6SWxoZXdPWSthbjE5M3l6RlM4SlNPOEd5dVNEY29ST2JJMmpY?=
 =?utf-8?Q?yJ3rRtSFxpU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3cxNDN0OVRranZ3NnFaWUtid0g1R3VkeWhBdzlJMVNleFd2bmRPMkFrNnhT?=
 =?utf-8?B?S1dPcDBWYzFNWG16THUrZXdmR1lFQnlUazhHaGtMZmdGZE9FajNJdm9wUElP?=
 =?utf-8?B?Zi91MU5aOTJKLzd2Q0xGelczcWVZMjZCTnRqU2wrZUNPYkRBWlpVV1FGOVM4?=
 =?utf-8?B?SW1NSVlMdUU5dWVTVjdCcWdUODdqWW5oWG9BcStQbmlBVGJ5a0NnUFpzZ3V5?=
 =?utf-8?B?UVVyTEllcjNyUU1BTUZVTlM1Sy9Jc20rcnkybTJsSi95QXRkRk91aVZraXJC?=
 =?utf-8?B?aFhYQnFZNmFEVlZPL1NtWHJIRmpIZE13MzFnWFMwRERkZUpaRTk5eThCSWps?=
 =?utf-8?B?cG4xcFNnekdUUDJVZm44ZXhCZ01wYUtVd0lGRUxDaHlVY0o3eGFKTmFJbEMv?=
 =?utf-8?B?T0k2Y3JDMW5rMGdRMFk0Z2ZuWkJCcE1XcEF6amdHai9RQVRXaE5ucTA5dEY1?=
 =?utf-8?B?SmJzMjFpcjBpUk5LRk41ZDFibXFLUmdCaE4wNStVeVRXWWhFWGJlUVNma1k3?=
 =?utf-8?B?SVJZakEwcmpQbGs5aTBjN1d5UUloWURmdU5NOGZ3V29oU3lPTUppK0pJdGk4?=
 =?utf-8?B?NVc0YWF0ZzZleGhyL2dxSVFoNkdaY3cxM0xBRjlpZUoxUFVxenBqZk11S2Fa?=
 =?utf-8?B?aGhvRk8vUWViSFgyYXBrMUJnR0IrdVRxNWhGTnpvOG5IN3I0LzBtUE9NOXhp?=
 =?utf-8?B?Q3FUdkxmeHI0Uk9UOFFwVHZ5NHdtQ0R1MG5aZkc5KzRWTVd1WmpJTFRwczZa?=
 =?utf-8?B?ZUZlcWIveVJVVWY3Q2hjODFGb1g3OFlVUzFqL3N5QmZRSHNodCs5OHFYZHIw?=
 =?utf-8?B?TVk1Y3Zrc0JseXM0cUF0RExYTFBTWUNQMXFFVUlLKzl0aVh0ZXF0MzZneHI1?=
 =?utf-8?B?bXRhZzA2akpNa1BUZG5JSGhoR3dXS2ZScU5VSVRqZnBkTGdSMWZ2cnJDRlFn?=
 =?utf-8?B?cFdLSzAyL2xHbTMzdE04blJrcXFuRkVUUGVIcWVPOUxRWWo2K05QUkxIOW5l?=
 =?utf-8?B?TUlDL3lkaUt2NDdlU2RzOE5YalFmUlNKTjBrcmtOMkJBSFM1dGV2aUh1NlZy?=
 =?utf-8?B?a2IwYjZrRUo1RG5lUGlGVGY5ZEJxbUdQYUxnMFJZM2lFUER2RnZEUFlTckVm?=
 =?utf-8?B?ZFczckNnNUJKVzBWMU5aQlh4Zkp3cTFySytidnNKVXFNWUJVenN1OHhQaWph?=
 =?utf-8?B?L1kwSWZsWHVRTWpITjFqSnBmakdMMzBoWnArSmY0UWNmTTJKYzFoVU04a1pW?=
 =?utf-8?B?c2RtL0hvVnBuSFV2RXhxTjkxeGI3cUIyMlpuUk5RUFprSVZKclNjbnFxMER2?=
 =?utf-8?B?NThBL1ZQRm9mV29CL1dPY0xaTmtmM2VjakpGZkpIUEE5clF5aVN6TnE2Y3o3?=
 =?utf-8?B?Ry9rZm5CamtnMW9vbVNvSUJtWEtDcGV1eWg5UVZ5YkxUcnN3T1A5RmNVL2hQ?=
 =?utf-8?B?L1VWOXYreTdra3AxNlhQRXNZQjBJWHpTMVAwV25kck5iR3loZHVrZVZ2alNu?=
 =?utf-8?B?UUFJd3I3Wjh0b09Mby9OWG5ZVDRzaUJrRzhCMFU5am5QWUhIQUNwVGNwVEI1?=
 =?utf-8?B?Y2xldjl5SjkwNmJVMFlUYWZIc3NJaDJBTzZFVWJNRndJUnR6TTBHMHROY0hw?=
 =?utf-8?B?MklDcDdSUlFrbnVBRVZuQ1V3ZFBEZkV1VjZTYjU1ZUp4TmdyM3dia0tObTFX?=
 =?utf-8?B?ZHZnVWhnSDRKYlM3YmdQUnUySUhyY2xiTG5NNzVwM3lVbDhUTk9zNU1pODZW?=
 =?utf-8?B?K0g5dHYzRVI1b1pmRm1QYVd0eURFQ2pIZjNnS1U4VVFFYWN0WmxjeTdmK3R6?=
 =?utf-8?B?Q3NkWnhWb2R4dURBcHQrMzNUSVBrOEs4U0VINGFzSkYvN1d0L1daVjlXYWZa?=
 =?utf-8?B?UFducVdTVjdXL3U1UHBucitIWVRnM3A5YXh3QW5qYUFxRDVUQkl6NkpOUU5T?=
 =?utf-8?B?cW5JNE1nL2JaNU9wczNPQjROVmdPTncyOW1hVG1acC9qS0tlc3Y1MXlWSDNw?=
 =?utf-8?B?MldlM2Rra01EaXNVdlV2K0xhTDF1RGE2dGNlL0JTYlRIOGdFcnNmSGZFTGtO?=
 =?utf-8?B?Z1lQOFdPVEI3N0VCa09jRW5rcXlnZElMWVNOcThXY0ZnTVJ0WkJvMnd1bjF2?=
 =?utf-8?B?d0NjcUIxT29Lakdab1lPWmZyYkZxSzlOd0ZiN0ZYOFdRaHVQVklBQVhEWE5a?=
 =?utf-8?B?T2pHSFlnb3ZuM01yZWsrQWhvRzZkdUtEYTV3L2FmRG1FTVdoM2VxMy9IVmxt?=
 =?utf-8?B?U2pOakpxek1yTnpveEU5dkg2ZXlBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca392dd-ec23-4e8a-ac35-08dde96075a3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:04:25.9977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPQC4q4MOKWj1Ea2rBzbzGnf2tmj0C18veW5hYoDFXyAUdyqUcdwWmCrkTMpCRVMTvg4FHlOiV5fcgMN5d4CUxzfK45A1LCZTmpO0Jf9r1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7513
X-Authority-Analysis: v=2.4 cv=I8JlRMgg c=1 sm=1 tr=0 ts=68b5a7ec cx=c_pps
 a=iT0IPLB/rXRz/LGl7erAeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XtCmkCBAeyUS8WWN5DAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: QL5QibZxm-1ZMHIdgjM6iUvz1EAYi5zo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDE0OSBTYWx0ZWRfXwB0zX4UnnGa8
 mq79tPU+DtNW5B172WUTwr5pZ8LMUVIMZn9ApVzk9oIzvcrcaqCLCzKmCzcWPDcs03lsUasIryG
 i0E05gp7uBnUQR1cIWPw0ja5gvA9Vi6xJRGw0Rl6stYXNjJiyFqtU+FHAeun6daLrViFcAPkh6+
 jmrn52/+xf2YKwC+Byo0BAph/WtIcBUn1hpNQ5Il41dfD7jDYB3TEKPj1kvEy+lFKGo9p2e9inF
 kSp5fEcT64Ms+AE/pfPS4bi0yAzviajJfz+a78eaOLRB44vG/+ifXMcNsGkr0ZV14pt9lAc/4/p
 /pFw1SY2KREHezA8KnaZyJT3fFd8Po+Kn6JU20cK9TrCtZ2dCrj3f4MXPIuwwg=
X-Proofpoint-ORIG-GUID: QL5QibZxm-1ZMHIdgjM6iUvz1EAYi5zo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
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

Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
(phb) object is now always set in pc_init1().

Since phb is now guaranteed not to be NULL, Coverity reports that the if()
statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
(CID 1620557), along with the phb NULL initialiser.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

v2:
- Add R-B tags from Peter and Phil
- Remove phb NULL initialiser


diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 7e78b6daa6..caf8bab68e 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -106,7 +106,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     X86MachineState *x86ms = X86_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *system_io = get_system_io();
-    Object *phb = NULL;
+    Object *phb;
     ISABus *isa_bus;
     Object *piix4_pm = NULL;
     qemu_irq smi_irq;
@@ -284,9 +284,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
 
-    if (phb) {
-        ioapic_init_gsi(gsi_state, phb);
-    }
+    ioapic_init_gsi(gsi_state, phb);
 
     if (tcg_enabled()) {
         x86_register_ferr_irq(x86ms->gsi[13]);
-- 
2.43.0


