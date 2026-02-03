Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4106DE87845
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIwm-0006uD-4a; Tue, 03 Feb 2026 11:08:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIwk-0006tn-R3
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:08:10 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIwj-0002S0-8Z
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:08:10 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613E65Eq071693; Tue, 3 Feb 2026 08:08:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lxPWRu37DzlfDtI/QAT1GsVz6SKqMwxuhFbQiuQZn
 ec=; b=xGCkyS+Of9gEsjqx/t9vEKHx/AuNIeJjKcW1+qFwlBrVOW7mqg/nBYWLc
 Efjw59eWxieXaoWSau1M/Hm8J5x+3Oie+pHOZLIRgPbBv8CV07Pl82dP36onK28a
 P8JFgR2j1xxARZ5aFfMIwbbEzrlflCLQKZN74XSUtxzHOdhAMLH8Z+HZTkjZbeq/
 my241Idyx0kekfXb647V2KkSPmwj8a7LcmRa0++wh2o3kNXyZ4wiR7VrdMOoGzNi
 DZ7YOG4t37Hh9d2FTpyJA/wDXFmnnJtDtxXYqVuQxGr9r/W06vzZf9ckfqByQ1t9
 YDPPGx9RwgpKiNpVmUdsMXqjgeRcA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022125.outbound.protection.outlook.com
 [40.93.195.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1gqhf5jb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 08:08:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7A59cHjluIYI5tnJntDkH46lJ9CsXJIDJz+06qPH1verqQF1Lxd2lOFouq3g7dgjBO+HUl6aYHEq+ffNfGsO3ixtjFch0SQm66TWlwb9igxcS1rAvI9pjqEVLhpVrF302By8yxGeOPsvWBUX+W9LqaAq7EebHK6VtcwfcbiVKQ1xgXq76LsDf2tS5GeX4717Qt8FbiwAc9BimgxIVVt8k6vAwFTDqcDVA0jV0HQSEHfBLoRk0fij9gPY6tCWMRrrYVwbfSv/4CWUEjA3mjHoBR6R6dUypvWbDywqxViPG9hu7snuz78SASz8bkL9JQXLja0qyTiA3DrZbizGcqRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxPWRu37DzlfDtI/QAT1GsVz6SKqMwxuhFbQiuQZnec=;
 b=fa4gj6DR901TBz29SzMKunbzJKLc7BYqzGvWYstxlpJDck5f6WR7U2xYVQkM2RUtfkBOlGvM5Z026IxrwYOzpSdO1C/ksWCvKsy7bZewFXoLB1hmsEbSfUKB8axxtr1lHYWJeClEmlKOc5bFR/IfGssrLUPJWWC/Cj3Qhu2jpAKKIGoz+3sxI2cfeWfSINTDxogTa08VUnA4oWat6sYVNF6SUD/kE/etvqTbo5x+w61l+YOgQQUMVbyHrFQrzxRGuoz3SV5PXKpwRBLz2HAGM5R7EVeiJNgj6azt1CK+tFb6nS8ecP5q/AmbNH8mi+vUepHq1GYb/B59neGI8PTA1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxPWRu37DzlfDtI/QAT1GsVz6SKqMwxuhFbQiuQZnec=;
 b=CXu8l07x0vXXu4LkJIoktGyGaG62bZj0xw6SlAljJhn63qeDmoe4eYIuNZoRbm35x9NEXFtjcOuSgerdFzhoYNuiflePy8FMzlKELtLwsARDPZ9O+oW2IHLZQ2Ubf3adr2mcl2Z+N1jj7MYTMqUfcR6gePUfPW0tcrLpnXNZ2tKvKpeIpqpMEP0pDViOp90EWiWrjsSG1V2fYE4OgrJhtlWeyLqQXDGS24rsV/zWyvMDKm4xMdlVbTJUz4yNqo/lK5gfmbmsLXvl8kX6+arQzQeOFAH0YbhnOXy+OZhe9G8axgPDgIxo7C8AWQzy0tYsanzqPK9HltrIeVcfykhuFA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA0PR02MB7307.namprd02.prod.outlook.com (2603:10b6:806:eb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Tue, 3 Feb
 2026 16:08:04 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:08:03 +0000
Message-ID: <03b3459b-5e0b-49d0-a88c-ef589b8f871d@nutanix.com>
Date: Tue, 3 Feb 2026 16:08:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/37] scripts/modinfo: remove trailing ;
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-11-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0021.namprd11.prod.outlook.com
 (2603:10b6:806:d3::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA0PR02MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 0266e0ef-d708-4c5c-8d89-08de633e6920
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUVkQWF6YkUwQkdjblFUczJZTnZJZmlwTW1lQzdKU0w4WE95QXRvK2ZhSkdi?=
 =?utf-8?B?Y2FhNWxGRnhCVVJNWDRNUSt0anZvMHQrcFYyRU9RbkNCb0dQeUVwZERaWFd5?=
 =?utf-8?B?aGozQ01OeE03dFR0eWdLQ3l5RlppWUhFd0FGNGVhcGNDaWIwcXVZcjc3emph?=
 =?utf-8?B?ME1iQjRud1l3ZFJVSmkxSzBTQ1VHaUxON2NJYml5TnJKZzdMam1vd0ZXamZ6?=
 =?utf-8?B?S3ptL0J1aDNCNDhmemVqcjhXS2RsVld4MnB3cUJRaDloQzh0dWZkaE04bzdL?=
 =?utf-8?B?NmQ2cy9FdG5sbGNlQ2lLNVJhN3hsNkpFT25ac1diYWxvUUFrTUxuYTJoTkl5?=
 =?utf-8?B?SEd2NytzL1IxRW1TVjlFVGprcUU4czRoWnpyd1BTZW8wNEhDcG5UZC94bGhD?=
 =?utf-8?B?ZnBMbThaTjVqT0xxOHpuYjhjdTJKV3cxTnF2OWd2ZCtSbGFNcUdza2djS2R6?=
 =?utf-8?B?ZHBtSmJiQ25QZFArbTZEQVcrR2pjem01RHorczNwRE9vREdmeWkxaDdPbm9I?=
 =?utf-8?B?ZERVK1JFak1HOVhIMGtQR2M0TG45c2h5ODgvcXo1UVlBY2JPdW1JQThHOExo?=
 =?utf-8?B?N3lDR3o1RklmMk0yb01RVzFTWUROMTQ1RjV1S0JSeDJxaFFJY2NEUkRnYnBK?=
 =?utf-8?B?NUNDN0NsK0t2L0l2SU5NTWxVZjBkaXl4YTZPSlBDZ25LQUJzTDM2Sm5kTUow?=
 =?utf-8?B?cVU2Q2NTMmQzS0dHT2tLZTh1ZFV3emdvTUxGYitYQXBYTUc2ZjlFUGpGMURH?=
 =?utf-8?B?M09zMVl4RWJJTzQvVDJIZ3pOTmlXV2RySVM1cXB1YWNEZEN6NFRnMENobzhB?=
 =?utf-8?B?eldoQVRDRHFsQnA2bTVSSjFmUit4WUo2dGJGSENFZDJxNEdQRHg0N0tJNDFQ?=
 =?utf-8?B?R2FiZy93aU1CZUV0YnpVUldGRTI3bW9lTHhleStCdGZPdnBBdXNZOG1mZnVL?=
 =?utf-8?B?VGl6S1JVVGRxSlhZMHgrYTN5TjZsZ2pZUDFxbVBEM2RyMkxSZXZxR1NPMzNz?=
 =?utf-8?B?bTlYRUlOZ3p5N0JCTUpQY0FFUHVySlNrdG5xcVlmaHExMms1eEQyUzh5NStu?=
 =?utf-8?B?bUFkOXk2TFdzZ2lPY0NmRmdCNkFlaGtyaFRmZExJNWxCMHAybTlnY3hKMHlZ?=
 =?utf-8?B?OVBWN2F5Tkg1YWNnNitzeC9POElQSGFaY0pnSk9MbFhNMnZyRk84V2ZmZ3NO?=
 =?utf-8?B?ZVFsMDBQMklhdVdVY2NQMzgzbkFXOUVwQ1ArYWhIaS8zcmpPU2poZTl2cHhM?=
 =?utf-8?B?TS9NNlpDQjhCSHFUNTB4cTdtb2dYeVJra1RKRHQwa1NWSGhMbzM2aDNNMkw0?=
 =?utf-8?B?Snh0TWtvRGQrUGtENElZVWNHVTdyK1VxZVhPWlBYMEVzb0NIa0xVdjU0S1dl?=
 =?utf-8?B?THBoZ2NOUERMYmhMaWR2NWNXek01UGY3UW0wWTJCVGhJUHFndmZyY1k2bmhw?=
 =?utf-8?B?emFha2h3Q090c0hleHNMNVFWUFFjOTYzbVU3M1N2d2dDdkdQcVZuVGdyeDd0?=
 =?utf-8?B?azZ4TU10SUo3ZEFwd256NWlXK1Q2Q1REdlZkMlJuVmhId1l4NnFjVzJTTi9j?=
 =?utf-8?B?U1JrelM1ampYbW1kUkE1dG1ZQ2dCMjFPclJJZjBYS0dIalI2OXZwczcwN09P?=
 =?utf-8?B?dzIxOFhKdGxaeDR3N0VqTTRTOU1XWkJCYThkcXF6VFdEZUYrRnBqOTkrL2h2?=
 =?utf-8?B?UWc5c1NENk8vMlF4TW1zcWVuTmw5ZDhlTjJPQ0FRY3BMdHhqMkR1empIR3dv?=
 =?utf-8?B?WWtoTVdDOWJ0TTAyMXNWMjY5dzZKMGtKZThHRSs5RzVNa2lFVnlQWGZWVmht?=
 =?utf-8?B?cGlNN01hUGJESVgzYjNJQnNuM2ovSm44dUlFZTdySXJsdUZNY2ViWlFKbnBV?=
 =?utf-8?B?QVoxQ3FUMzBMTHdGQVNvbWNaVWM2VUIvMVR0NnJiVFFVTnE1bVBzSHhpdGRq?=
 =?utf-8?B?QXc0NXBSc0d2ZFZzeXJDMWFGTkUvSkZMRGJDODlnOEtGRmtCam1QRHhyeTlF?=
 =?utf-8?B?RjV4NkMvRkt4bDlYNnVPcElDWEpQSTZNSittTlM1RXFmbzM1VjB3RE04WHk0?=
 =?utf-8?B?aDdrMXJ4TkZ2U3E3a1FYYm9WbThhbWc0R2s3aU9wcGpXWlQ0NDFLaXoyUHZK?=
 =?utf-8?Q?qmqA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE42cGwrNEFFL2lEOVI4WVh0UC80UWlLZlQ1cFBMT29kT2VTRmE0ODAwWWtk?=
 =?utf-8?B?eW05cVpkZDNtU1poTDE5VUNWQzJjTzNIM0VSQzR5bXNiNWVVUERvbm9UTjla?=
 =?utf-8?B?cnIxL3pycHhjRm0xYjVFSWttZXhmWU5FQ3UzVjc0bkNraWMzdk5MajdUcEMy?=
 =?utf-8?B?Rjh5WVE2MzRxTkdnNy9INEN4a0liUUJTT1VITFRzU0lHVHV1R3Y3N2JaZWlP?=
 =?utf-8?B?T1NZTlNjaFVINnJTVUtkRjZyZDBzM09hM0t4aU05dU9xdk5QQnBvVFdvaFIz?=
 =?utf-8?B?U2dqWE5xNUVZOVhZUmdHLzBWenB5Z2c0ekhWYTN2Y2owa3NRdHVkZmxsYUg1?=
 =?utf-8?B?bDNrNGw5d29qcTB6NEtYY2VPNm5ZcFRRdFdsQkQ3VDZMdjdDTVl1bUsvUlVy?=
 =?utf-8?B?ZVVkWW53TkNOejFMeXNGd1dRRWQwOTJ0TzJLRGg2Umdva1RXcFRtU3RRNXYr?=
 =?utf-8?B?cHBhZmlZVEtWS3ZFNFFNeHJWRm5JN0dkWjYwNGVnQ1h5RTZ6UG50Zno2QVJY?=
 =?utf-8?B?SkFJdE5rR0haOEJqL1RZaFpLNURtNkh1VkNvZUdoenRBNnF5b0N4WjN3V2tp?=
 =?utf-8?B?NEhzTncrdDB1Ni82NVN1SFp4Zm1nOWVkajFzRGkxWTNuNHYrWnpXSG1Vczhx?=
 =?utf-8?B?THZvbnhtVkdLMktDMG55bTM4U1BEdi9JUkRzZ3ZmT1dtSGVIQzgzVUhLZnFl?=
 =?utf-8?B?dFJ0Mm9oS3IrbmRSM0pSNGk0RnY4dGZDTXc2aGxTbFZUN2VpM2JtaDA5NlM4?=
 =?utf-8?B?V3hwa1dMOHVXOGo1TndialRLWlg1eVRPMExDdGI4emZra1BEbFZybjFHSFMy?=
 =?utf-8?B?dDhSL3RZY0U5RThQRTZvK1JDOS9xS3o0R0ZYT3oxb0JFSFk2Z0hCWWFXNUY0?=
 =?utf-8?B?dTZWbXlmdEdJckRRU1IydGRlMjYvTUl3Sk5VeDRLbzJLekw0QkJUcHBDNENp?=
 =?utf-8?B?YzlySVBvZmp4TTdvdGRZMlpFVzFEOGYxdUIyR1k4WFNUeDhWcG4ySmxESnZU?=
 =?utf-8?B?UDY1N1dzV3JwREhuUHVRYUI0SVlrbWlmYTk2S1NrTnVpVlBkVEk4V1JLMm9N?=
 =?utf-8?B?VE5iaHRTc2twdXhCVlh1WEl4ZmZsZU1vZ2NhQ2ZkNGtucloxam9vVDZtYUdS?=
 =?utf-8?B?ancrcEw4NFFNdFZrTUtQSHBrWi96SUovRGRuc1pJT0ZkZUFoaDRlWDFUMDJ1?=
 =?utf-8?B?T1JGaHdxNWl2VUZ5SmxQNi9KS3JrM1dTTDY5MlVRVmx5QUR3Y0hPMmdLa2hI?=
 =?utf-8?B?M1JzS3cvWHVyT3BCNVU1OTNnTUM4RWhMNk13aUVqZ3A3WnoybkFBL2FFcm1r?=
 =?utf-8?B?TGRlbVpneGJpMnBaNm4veUZWc1cwLzNPMzNzcnlzV2hOTDN4S2RJcjRHMlIy?=
 =?utf-8?B?Z2EyL2FSeStUNTBLcENCdDQvNkZLVWI0MGhNeWpMaUVJbzNadU93TUd3K2Zh?=
 =?utf-8?B?ZDBveExYVHJ0R3FxaWdOZEFuYVlIRG51MnFjNVpGM0VjVHIzejVZWUdjWUU0?=
 =?utf-8?B?YklqWW1TS1orbU5JcHhWTCtOblVjUzU0M29MOWRTZUVrZW44a0xPZlJ3S2Nu?=
 =?utf-8?B?clBRQU91TFFRRlJRS0E0OEU1V2hKaEJqVnZ3bUQyVWtEUGswZzBmYzZibE1j?=
 =?utf-8?B?VlMwdUNLSUFPblJVT2xOWXJtcHpNNnZmWDd2RGJRZlVZSzFBMDkrWVZQdU5C?=
 =?utf-8?B?OUcyOElEa1VKMEo5eXBSejZVR09HaGZhZ3BUL2FyMnBWbTF6OFlsU3NmbklS?=
 =?utf-8?B?eEovcmJ0K2k2WGpBRjhCUVhLRjFpZFBBVEpDa3RLQnoreHBCWXBMMnFUZVBZ?=
 =?utf-8?B?UTBxSXV1Tms4dnNFaFBNSGhGRzVENW8reWVuS1pUaVlwVHB3RERieElYNTlp?=
 =?utf-8?B?VWg3NGwyZjQ5ZHJJeWtNYlZ3Q0tuWGxwRXMxaFlSSFV4bzVDMERLdTUrbmFO?=
 =?utf-8?B?bU5TeFk0YUxRYlZ5elZCR1ZnNllwWmFqRUlNN2YxUWNtRHRVbVBBbDkvalVp?=
 =?utf-8?B?Rk9OK3pmZjBNZ3ZjK0MzeFEzdjM5akRpdnltalNYZ1ZDV0ZBSkw0MUxoQXEz?=
 =?utf-8?B?dHEwWXNRT2dZNkdpaGxxVFJoTHF4WnZTZ09lNitKZTI0WUxZZ3NjcXZUOHRY?=
 =?utf-8?B?OWl6bXRDSmZMMm1Pamc3bjhHUFFJdzlwNHZrVEg4emRPd3lnQUZXNlBqT0RF?=
 =?utf-8?B?NVFNdy96L0VvakJjTVRZZkkwM0FQK0UrYUR6ZzM0NXllMEFhelY5RFlqd1BB?=
 =?utf-8?B?Nkw2Vm9wSnJ6REVPcmxBTDBkZElTWVBQYUFrV0NpOVhrMjdISVpBQ2lUbzN4?=
 =?utf-8?B?SjFvbnc1YytDYkpudjdoeUFPMzNyZEpHNnAvbEJFNzJUVUNZSFRhUDJBUG1o?=
 =?utf-8?Q?j7K1wl2ngVk+YnVY=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0266e0ef-d708-4c5c-8d89-08de633e6920
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:08:03.6959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuuJ4ebtmIEWZqdnDV79tOrHklc+tqeMCTFL+8HPHtLjZlbPzECrDfoFQglCPYNWMaP1Ib2HPwHm11nqNwUbihPGCDKc5YxOm7MvW7SJsf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7307
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyOCBTYWx0ZWRfXzORKvZtj2gcH
 rASda6c+V0oX9ZJNanU2eMyoO/DNEFiQHyWYpDsHFyQH2cTcOBGGIGpjMsCNCS8wpusZkSm87cF
 09WagIHPDG5QJvRs0x0304UrDcFHDCZc6zeuGQ2srm8lmuQgb7QF8UZg9HWUChJ0voMgtO756KO
 X1VjdEWzE2lmEs1oWx0zBUy4ZMjtqYh1rhAtw7vlzutP10zIns0DuX50disY076F3oGfAO04KW2
 fx3Qn7BnH9CvIL6Vnw+r17kq9TAjoFYegABzLlZMNIEo2T5Xf2fwKo4mJQIflpPzaZHKKicNeWr
 6LS13+tUPQ0pA9rdIP1uEMw1MxSK524WPPAQUqCgjiCVpiSPI90rxOUsjcj5UdAM+yy0p0yF2OF
 e47+fVCNpDgVkvitk6bEJtWVLvnUcI8uGex34+5xCcXKXssOWsv8se1CGRqy0YiTz5tdabmAzNm
 +1bWAPdLewdNDYyNMsg==
X-Proofpoint-GUID: KKJnbUkwYH-7sXDqNISpAr3tF5SxDXiy
X-Authority-Analysis: v=2.4 cv=aNX9aL9m c=1 sm=1 tr=0 ts=69821d67 cx=c_pps
 a=Cjv2mA+u7YWQeGlDvlytMQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=42nh69vz8BvXQphEEaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KKJnbUkwYH-7sXDqNISpAr3tF5SxDXiy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/modinfo-generate.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index 5a8abcae5d3..83ffa4a7c52 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -48,7 +48,7 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
>               elif kind == 'opts':
>                   opts.append(data)
>               elif kind == 'arch':
> -                arch = data;
> +                arch = data
>               elif kind == 'kconfig':
>                   # don't add a module which dependency is not enabled
>                   # in kconfig

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


