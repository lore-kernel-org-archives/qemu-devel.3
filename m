Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F450CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTpM-0000y0-DS; Mon, 24 Nov 2025 05:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vNTng-0000Iz-CW
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:28:12 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vNTnX-0001vj-Af
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:28:00 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AO7J3e13368684; Mon, 24 Nov 2025 02:27:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=wDOtsCwawmr+DgL2zzNQollW8MQljymicxiKFhrkT
 sM=; b=gC16SDP5zzcPAkkz7GEQkQyQXwD5T6xY49rUY7APxRMz0YWqlXiCouyBF
 IjZbXeWobgAjqHZ/RE5ywN6v2aEQ8yb1YQbnBLV3pQOtF+tRk30xJfb0VjmC1huq
 tshVE9TuLBT9OpjZUSOmJeI9KiC1WEkZ3lcapc9QwlOzzFBRb97lQe3KOFefG+Sv
 ds5o14sIWwoejlLJRi2g7zGZODqJwJd7K1nYF5PM7IcRsui2IDTMlj+Extoc/Py3
 msmURTs74D3Hwyh6t09MQfASfbK6Kec/PegnblyIY8XXXh3jOaRv33lmJn1hZXV4
 isFFW948kfrpPXWW/YjUjQ/trDx9g==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11020073.outbound.protection.outlook.com [52.101.61.73])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4akacsk2wj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 24 Nov 2025 02:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsNqL1jUkl0UcwaR7JUWq6y8tWjlE9UTRzOujHrRtFR28PBvLzpJzVXsUJ56nGjsV/JKaeA0zIez7ZMWrPfRdEEc32tVrj2gJcdPqzfvB3IteeiMOqnC3ukVwhAH8FiRm/miNVZMh2sQ3uwk2bmxLeTQDtRqMgLCOeDK0tX9VJXYs0bqC+AkHKN1kE4eB9RqjyZjmfj9x0btBHmjG6QXwZyuk7LObGRW4wCfJ8hB334r7JNykrgvXbYBCNsBrgOsX/Nhi8mkHT7mVQhgaAgmp7nCfOrR99z5ygCniI4IUX8ZpGWH4QqmRmEa3K6xmzH2p7frR2x3to7rTu1d+nvT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDOtsCwawmr+DgL2zzNQollW8MQljymicxiKFhrkTsM=;
 b=JadvNieyDsny3oDafPdlBg0TedmQyr+WQjLnKFQwu6LiZhe4WPclYrOyXrVXSTTDBjdw8G7YtI9BPpgmJ3VUhlEKb3d02EfOlxq5/cKPCUSZRRSgQs3t1mnzGmSsRnrBX8IyoJ+yfJ96HNt3t528elx1FkvacT/CVDlDSq5rGjYSh7pgAX80wSw5VCJlKV/tsCBwZgM8/X7kyQ1lqQiooUKrh3eP1i4kEG87E0kgbCSMvlym8utgz2CZtLFpmepi8hltwKBWyxVvIL9lUUSrJcaDOQimYhxMo/WLvfpxsXM7T5uF65R1yuXJx2tnKp4QyEXINYsWIuDgJhq0/bgxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDOtsCwawmr+DgL2zzNQollW8MQljymicxiKFhrkTsM=;
 b=S/iCYNzyRH7p1QTZTnTVezKaDT9SxXDzDAE7kA53txo8aP3vmwuPlw6PXncmN5CYrYs8M+9j2V9DuwlTSg3FXi+PLolaVg4xE4uPlJ6qECi28/4njQ+db7PBazSbSs37uUXquoIjQ/rwz6bVyp1cD+AcgTNN9cvOnZ/aQwJWXyzfxyojGPgCb2cZVbQ4kabvxxXsdmrTSrVidy6X4Ll1afI6MGX59x7uNeL4gFxSuzBMoflvHf6Jo9Y1qR1AR/RmGe4TOltZznxzH8p1r+2l7hr9VhX4scsfSXsr8cdfkdliLJEiaKZLWYlajCZABHbwh/G3VamuNh+rtAnIek7/CA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH3PR02MB9422.namprd02.prod.outlook.com (2603:10b6:610:12b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 10:27:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 10:27:19 +0000
Message-ID: <066cb998-e89a-4cd1-a89b-865f4a6dcbbd@nutanix.com>
Date: Mon, 24 Nov 2025 10:27:14 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/isapc: Remove dead Xen code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Eduardo Habkost <eduardo@habkost.net>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20251123185832.53802-1-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251123185832.53802-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::34) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH3PR02MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: fb82b0af-1754-4fe5-dda7-08de2b440c1c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Syt2eXJxZ1k4ZFVJSWovQmo4Yyt4cHhRR2UxbVhkMVNaSEE4U1dqelhDTDh6?=
 =?utf-8?B?dEFpbXBkS2JHVGExMnJyWmZlWWY5OWM5N3hScXpIMGJIRFgxMGJwSnc0QnJm?=
 =?utf-8?B?bGFIYVpvTEtCU3ArTWFFYTNJSVZkV1hnTnRZZ1VoSmQ0Z2RLQjkyMXRTeXE4?=
 =?utf-8?B?dEl6SGFUelNUdkNiNWVBbURoSmxKSWdNb0hicERlcUkzZWl4d2FvekxSVXc2?=
 =?utf-8?B?a0JEQ2U0NXprUkwxZ0RDWkJkVUNzSHpJeWpCUXpiWkNWYjZIZWk5STE2N256?=
 =?utf-8?B?cXR4bkJDTlVNQU1GeVh0bnU5N2M3VExtQ1czTUNwY2JNWm00RWJYb0JBZG9i?=
 =?utf-8?B?dkNYMkh4ZTZCaWJLQm02cXZyWUk4OW5wdnVtMzJnNWlNalEwSFhzZzYyNUxR?=
 =?utf-8?B?K0RPSXNmSmVmb3JVM1VOQUtFVjllcFEyNXNrSGhHQVdwV3Y1bWZ6c001Qm1k?=
 =?utf-8?B?TVlhczJrb3BvWjBBTVRjSzNiZGNVNXZCZm5EQjNkb0ZZQ2dLenlkSFJtU1Z4?=
 =?utf-8?B?Y1UzcExkL0FDdlllMUN2TGM5VytETWtjNlJXMU5iY1J6NXBybjBpTTdMUmV0?=
 =?utf-8?B?eEtYRlZRV1Fxd29RL0tpdzhqTzFtNEJUR2NGa3d5UlJHdUk1L251UHhMdnJk?=
 =?utf-8?B?eDlMeGRoT3NqT1NscnZPaTV4ODY0QzRZUHRaSjJydGFZRE9vQk5zcHpCWWZ1?=
 =?utf-8?B?U0hyWWk5d1VhYUxHMGNDYWVTb25maHVDSmRBNmZLUGpFRVJVYlZBTWl1dXd0?=
 =?utf-8?B?K0lyckpaZ1N5Q01BQnpJU2dnUWgwRXpJTm1FdEVyN0JSemFXVktrWWFnVTNP?=
 =?utf-8?B?WGFVUVFEeFU1U1dONTR4SlRLalAraTU5MGhLMmRFaFEyNXByaDFLZXoza2Zp?=
 =?utf-8?B?bGdjSmJuRzBhejVSZ0Z2WWQ0MGozLzE4RThZWmRFNU1LWm5DOUF6Q1pmVWJx?=
 =?utf-8?B?YnhyUnJSclBtNk0ybDFqamNmSTBGZk5STWdSaWhETmFOTjcwenRXYVZsSkoz?=
 =?utf-8?B?aUtFREhDZDhkamxxWmJxSEF2eGlqUkJqeDJGeG16K0V0VlMvOW53SG9Jc3F3?=
 =?utf-8?B?TWxvT092V0crUjNJSVFwai8zZVltTU1obFd1NFRLajlYTmR1TVlick1TYUlp?=
 =?utf-8?B?WHFyVjN3aTViK1pkVHErb1VxZ0duaUFxYzZZOGJhVDZJTHR6UVZ0d3ZKaEUx?=
 =?utf-8?B?YkRjMFRCVlphcHBmRW9oM3dKV0FWdTAzSUdKNkV2NlUvYUJhcHZhYXJqanZ5?=
 =?utf-8?B?aEZ1MDluYnFhUFZMNi9IUTBlS2FyNjdRV3VRVUhCVmROUEVVT21IZjF3ekdF?=
 =?utf-8?B?SkpvU1hpaUowTXdZUW9ZQzdKSHZVd1M2aHBWeUVvUDF2NVBWZUw0dWYvSTVO?=
 =?utf-8?B?bkZ6aG9hVEhybHN0MWhFV0hqWmdpL1FBWGxPdVh1amE5dVoyWkRFRGJvTUth?=
 =?utf-8?B?QkhRTE1IVEZ1WUQ4bzdpcUhJdGRSZWdaTnF6UUhscTcvWVFvVkJmU1F6VVI1?=
 =?utf-8?B?cVptS2NJRVI4SHNsVjlsSW1zcWFNTU82NEVyVkYvc0krMFZsWEIrTFZ3MzQy?=
 =?utf-8?B?cThPdGpyMzlsRnRXUVZvL05kQWdrMUluV3RoTXpqd0ZUOVpzOWhraEFVWFBY?=
 =?utf-8?B?dG8yUGtSOTlteGJvczhrWDNqWHZraURRZjdqU0VuL2VzTWNGNGd0OVMyNnRX?=
 =?utf-8?B?SUw0dXhqUlIyVWM3VzFTRlNFWW9wL0FRL09HcnNYODExRUV1c2hXdC9NNEVk?=
 =?utf-8?B?MDdzT1dRSTBpaHdkSVIwVERlSzR0bTJVT3pKa1NHLzF3aDdLeU0vK1J1Zzdj?=
 =?utf-8?B?aWM5V2RvbGRJcjQ2VkZBRG9BbFEwZnVTejJGTFFWYWRXQkFGV1Y5WDVkZEpu?=
 =?utf-8?B?RkNxcWZVRHZ5Qjd2T2JXVzFNMzZtcWtsT2tYSlExZnpYOUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG9oakNTNFQwSEMwQ1hPRHdaRzRQc290WDM4ZDFaMmdkMGZCY085eU1sTkJv?=
 =?utf-8?B?cjNRRVBPdHMzV3QrRFo2aEU4MXk5MGpTU1FRRTY1eXVHem9rVURRTzljVEdD?=
 =?utf-8?B?U2pLSENGd2dkd0FHNDVJOGsyZXdqWkY1Q29ISjlGWWcva0FPbitQTzR3d3J6?=
 =?utf-8?B?aDF6MUZoVzFXUWx1SkN2S2prdDRwNEVrOUZZS2JtTXI2ejlZZjIrcDd3UHpS?=
 =?utf-8?B?U3NLOWRlZXhHdHlGRjZtVzFwVnBZQTdzU2tqYnd2U0dYdTRRZi93WHlkaUxs?=
 =?utf-8?B?UFB1NGgwSU9CaXZQWW9UUHNLNDBKTUFzZWhVNmIyYXpTVnlpcjVXVDVQd3BF?=
 =?utf-8?B?WnZhZ3lZMTdMRkVNVER1MFZZV0xYLzdlZFpkSWlmMkNUVXJjeHY3Qkx5TEJz?=
 =?utf-8?B?QzNubDNKUUpZUEw5L1Ywd1pBMlc4VEd6a3hWNFQrQjU2dDlOUmxMdlpBNnd1?=
 =?utf-8?B?c05yU2tDdFIrZjViQjVqbktZcDFWR2VvbndNR1lHcURVai9UTDlFOW1RM3Er?=
 =?utf-8?B?Y2piTEIreXJVU0E1Rm4xV2s3QW9tV3Q4bU8vOG9pVTdlMnNUMzc3a0ZGT1ow?=
 =?utf-8?B?Ly8wNzJXNkdNV2pqeVdBUW1aT3dvV2czN3lKVFVVejZrSzdENnIxVkh0NW91?=
 =?utf-8?B?a2ZLOEZiUlRXaFRFaFpjYm1HVTNYR1c2M0p2d3hJNHc5SnBlMUxFd3JQSG9T?=
 =?utf-8?B?dGxZYVR2Rm5Fb09zRGN1VFFGS3FvdmFlZU50SnNVZFc0U2s0MWVaVng3U1k4?=
 =?utf-8?B?SkF1VitDb0QxM1JrU0podktYZkxyRURtMUdpb2h6eHZ6YmFoV1QzOFFDMnBM?=
 =?utf-8?B?TE1sSEJwUEFFd0cvVXRjVmdZdjhJSFQraVpVcXowUERrOUx0Mm0xaU5yMFlF?=
 =?utf-8?B?MThtNktWZUZtckJKeDdiNEFLUDlRS1FOaU5ZOW0vWnBSSU4zWGxFWTdsYXBy?=
 =?utf-8?B?RGFMZ3BIMkNub3dGOFZCSVMvQ3NiNTIzN00vK0lUdnZQbnhFODNTdUNXQ2lQ?=
 =?utf-8?B?cGdXb2ROZis5aTVWeXVvb3JuYjVaZzUwd3lsMUtrVmxTUEpTWG12TW1MRXNL?=
 =?utf-8?B?K2pGNVdXTmpMdDJSYjdTeG53Q0k2S2VJSUd0bkRrOG93VlZjUE93OFJsVGVY?=
 =?utf-8?B?MDcxeXl2RkR1SnR5cVgwR2JTaWY3QmcwSVJnb0pUdFFMV01NVkE2SFI3N3Av?=
 =?utf-8?B?V1FkWUlhUUZJTTZSRjBPZEpQS3MzeER3SE5pNDk3QzE3dkJValJ6ZHRMWGFX?=
 =?utf-8?B?ZGxjdnAxc3R6SWZkQWVsMERtS1k3NzFiK2pUSHh6ZEdqTXRuU1V5ekhJMkZB?=
 =?utf-8?B?M1ROalNaU0gwUlhtbmhJOWhwMThiaVJvY3VXbXlSTTlmd0tIWlBwNW5aTDhY?=
 =?utf-8?B?cEt1RU1ZdWsyTko1TE5SaWh2Nmk0QzN1SGw1Vndob3N1U1VRc3ZtS3BSaUVW?=
 =?utf-8?B?R1Bwa0tibTF0SnRZa0lIT1A2M0pJdFlDZllqZjhIYis5alZxZGNKL2VDcEVh?=
 =?utf-8?B?c2NMZzA4YVlPb1NyZTgxRk9JK3pSaEQ0TXpZNmUzek1reFpybjFGc3E1UzZZ?=
 =?utf-8?B?blFoREx4VGRnanBVSzBrZHdFMG5ETitiSDExcU9FMElhN3F5U1cvckJ1QVBF?=
 =?utf-8?B?cEdYQUdsb0E1QVhlUDd4akUyY3RJOUVHOXpZQmdlUXZrMnlMajYwd1FxN0xq?=
 =?utf-8?B?OUNpb3BYcGdqdk1xVEZTSFplbk9lYlQ2WmJCTW1SWWhSaXVtMTdGR0QrR2la?=
 =?utf-8?B?RWZ0bkxUb2xMOG5OTjZoSU4zWUI1ODk4dU80NnFjblBqdy94Mll4c29haVds?=
 =?utf-8?B?T0gvYXcyZGFHQmVwYlRIbkRCbUdYSlVRajF1K0RldFRnc3FVOUYwM0I2VVdk?=
 =?utf-8?B?T1hLZjhLaU5XRjJKbnpDMHBVSlVsNlVWMWlvclNUaU1CVTF6YXhZR0JxNTho?=
 =?utf-8?B?ZUMydkRTZ0k5RkNkVHArMGUxdklES3JnUllrK3pFait5NUkvbVl3ZXd0VzVP?=
 =?utf-8?B?QzhINkdjdlB6MW9ic040dU5VYjl2VGtDUmdaQnArOWdvaGpBVE5QcnRJUE5s?=
 =?utf-8?B?aXBGc0YzN3BzaUtzWi9rOE1wR0FjQithNHVOVktuZkNra3lSb3JaUUpmQjJB?=
 =?utf-8?B?Ly9Jc3p3dS9hbEJhd0Zyc29QVXhYdklNd2RqUnFNMTdPeEFsTXZ3Uy9UWkh2?=
 =?utf-8?B?SlhVNkhTRUZiV05jTXBualRJTzNldDNUOXJsb1JDYWZBeHNCNXk3WlhEUk44?=
 =?utf-8?B?aEVqenJDYzY2UEU5UE00bTcvVmVnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb82b0af-1754-4fe5-dda7-08de2b440c1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 10:27:19.6444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdH4UDAn27+N2Akuc8SgsijlNKyDr+eXsH80UGhxnIlCdnoKHVn16pq9RzWSWvZUDjSoQENTQbPT3kyAsyk8s82ISOBSWzJxv/soFI+TPtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9422
X-Proofpoint-GUID: _BJg5Z4u386ajJshyWqbDsC8rJ_u5aVr
X-Authority-Analysis: v=2.4 cv=dIWrWeZb c=1 sm=1 tr=0 ts=69243309 cx=c_pps
 a=Tzn6lXVVKCRcblYJXTGjtw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GaQpPoNlAAAA:8 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8
 a=YcMYGtZFhfFnhVd9fs8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDA5MyBTYWx0ZWRfX7q0qEMUrW7tG
 0hVO2EGMMaN2xmGe6kwh0z8/RAA+RYIXs4OwZ368mKQgJYZ0MPxhvUR2NrrbEvA5/FnorYLZAT2
 M0JcXQE7tfS7XXM57vBkPGwvqaI7lN5b2ox2/Oqlb5LVI8kdeX9qaaLiSo19qO8RLxEl8iUTZGh
 DEmnxDCaH/Llx0fM4dxoHqODrUlVMJ8VHX12RHidytPUeNx2MxtsOCku29hJxNrMzfnCcPI3DmZ
 t0G48V0T2NM2yVrtxMP8pAz6LrDRL51IiLtxNg/FtlOmkLwUeUN9zQxnApu4i+uIO4kFaj8qR97
 RnXgIeZwHT5BZ4Dhu+RqOCnsbhILmLp7vmRjfxmXxPXTvyn1cSxMkY2PQ3CeVSkWjtg17tN69+R
 rdjLOXXWffZQs07kjVGNqgfZ98Au3w==
X-Proofpoint-ORIG-GUID: _BJg5Z4u386ajJshyWqbDsC8rJ_u5aVr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_04,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.161,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_MXG_EMAIL_FRAG=0.01 autolearn=ham autolearn_force=no
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

On 23/11/2025 18:58, Philippe Mathieu-Daudé wrote:

> We don't use Xen on the isapc machine: let's remove
> pointless code.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/isapc.c | 27 ++++-----------------------
>   1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
> index 1ba9ae22cc3..1e13a30c505 100644
> --- a/hw/i386/isapc.c
> +++ b/hw/i386/isapc.c
> @@ -17,8 +17,6 @@
>   #include "hw/ide/ide-bus.h"
>   #include "system/kvm.h"
>   #include "hw/i386/kvm/clock.h"
> -#include "hw/xen/xen-x86.h"
> -#include "system/xen.h"
>   #include "hw/rtc/mc146818rtc.h"
>   #include "target/i386/cpu.h"
>   
> @@ -37,7 +35,6 @@ static void pc_init_isa(MachineState *machine)
>       ISABus *isa_bus;
>       uint32_t irq;
>       GSIState *gsi_state;
> -    MemoryRegion *ram_memory;
>       DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
>       int i;
>   
> @@ -77,15 +74,9 @@ static void pc_init_isa(MachineState *machine)
>       /*
>        * There is no RAM split for the isapc machine
>        */
> -    if (xen_enabled()) {
> -        xen_hvm_init_pc(pcms, &ram_memory);
> -    } else {
> -        ram_memory = machine->ram;
> -
> -        pcms->max_ram_below_4g = 3.5 * GiB;
> -        x86ms->above_4g_mem_size = 0;
> -        x86ms->below_4g_mem_size = machine->ram_size;
> -    }
> +    pcms->max_ram_below_4g = 3.5 * GiB;
> +    x86ms->above_4g_mem_size = 0;
> +    x86ms->below_4g_mem_size = machine->ram_size;
>   
>       x86_cpus_init(x86ms, pcmc->default_cpu_version);
>   
> @@ -94,17 +85,7 @@ static void pc_init_isa(MachineState *machine)
>       }
>   
>       /* allocate ram and load rom/bios */
> -    if (!xen_enabled()) {
> -        pc_memory_init(pcms, system_memory, system_memory, 0);
> -    } else {
> -        assert(machine->ram_size == x86ms->below_4g_mem_size +
> -                                    x86ms->above_4g_mem_size);
> -
> -        if (machine->kernel_filename != NULL) {
> -            /* For xen HVM direct kernel boot, load linux here */
> -            xen_load_linux(pcms);
> -        }
> -    }
> +    pc_memory_init(pcms, system_memory, system_memory, 0);
>   
>       gsi_state = pc_gsi_create(&x86ms->gsi, false);

FWIW I did contact upstream about this (see 
https://patchew.org/QEMU/20250618112828.235087-1-mark.caveayland@nutanix.com/20250618112828.235087-13-mark.caveayland@nutanix.com/#91b96b24-af60-4a89-91ec-d0e660a76a0a@nutanix.com) 
and they mentioned that it should work, which is why I left it in.

Unfortunately I don't currently have any way to test it here :/


ATB,

Mark.


