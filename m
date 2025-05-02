Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA107C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmYI-0007WV-TX; Fri, 02 May 2025 05:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmYH-0007WD-21
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:19:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmYE-0002ZK-OI
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:19:24 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5420lS1I013778;
 Fri, 2 May 2025 02:19:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=W9omTaAuCPyEdeekfNnpdB8vv1Sws0XiFLabIB2as
 OI=; b=eprCTF89ETMGQE11Sbd9NMYuUPCJxJpJDrkQgMet1jLz7jGLdJz8Ut4c2
 TEnEmakFCB7Wc4hcuVlZOjrdJhl0ojbv+7sF5Pa4wYNdWThrsZ6XS7M+gaMrRuO6
 7QW4oDJeFdZht9Kdm7x0G0Cf7wFoHMfuxSVhuHXhjkf5uoaSjomAoFeU8mSCZ70B
 +HsoZNOBlXAu4GgjLDQiR7JCjeBCb9VDUlHOqWylGxNk6cmqDaAnq+k0zQB9jncX
 E1KOD1Y/vJJfWRQX2WvoNAZcUwDIk1V3ZVpVksnqWp9zenQl2/gg6ROdGrByDDvj
 gminBwYdY+a5jt4HxMUTX5avtNdvw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468xjk59kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8ZJyYk16sPsHjZTSARIIMMzxM0E3DaybYNdshyUlqf1g6HaOXfyip9yiwzAAOthlhUUKWk5TEFz3Hewm60n0OPpm5I9PKi+6xYGdh8w083axE6rWpqY0nVdhz4VnCqg3S7Hy3Mi4z6bOqTNxTABEU5mlHcEMKhhC9+oIkNbivqncCPpEGbrozkvHTUdxWVq6KDIqynPMvtIyD3z3ZUQe8pBRw2Ge6LQwH6xZx2OdAnDV/ypDNbogg/iYDx6OzZTbkZ3m11Pfdyi5l+mOjEpjBWvffvrcaevxySTKnIuDBadbUZckZ7VRD/m+ZcavOiOO4B6RrHocP6gtWvli+iuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9omTaAuCPyEdeekfNnpdB8vv1Sws0XiFLabIB2asOI=;
 b=BV8vm0xUsgkBDBoSXSw5r2T22hR/pj3LS+C7rlqsnUPuWG6xRp7WI/1M9faj/ALDrNrRjIWkrdZ8Ekt2aCPFz23VS6AtCcNwcJ5xSE1ArX7d6R3oYP/hn9N7wAOtZI7Nvi2p97USBZoU26He3wgUi6LLHa7qztHrtbkYYD48patPsOCL8VbflGZE+7nmwI0OBEAsnCRNJXnxsmrf7IA71Af31PLPQoAth+8za3D+f7ABcuwDE4Wgij6QBfM4g0lVbQfQj8OP+ThyqixKg9lE8PAkiuKI02N7XvuMqDS41dnBZNBwkdEWvIHllzLWJa4hWM8WHjlOoelnbnWqEFBoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9omTaAuCPyEdeekfNnpdB8vv1Sws0XiFLabIB2asOI=;
 b=qLuZG1phO18yM3PapHcFpr9HvoOWk6gC/P7TfJTdAQ9Q6nRF7p5yCzZzo7xJN82x54DnAmvQ7GWFQXuF76EMawwCXK9bM0XfMbexeo7+zu4V5gPxRztHiOCYRRNfZ7LGQHwP6FcU/XbsoZl9Uwe8C8AGH6huynKj5cXZbk1h/7Ll1UU+aPFo5qJlzLXMLEzz+8ePpfhNeGxbu6rdn4c1RAv524sSz3g3Wnl/I3vtC2+O7q4b0TQqhT5hDC2kTRbOLPAfGhfc3KtcqMuDCkY75D3Da45fJe5eZ1n1VXdpD4+5pGlhzi1H+R9pYkwjccAyE02euyjMpRAfQAJiZ+V08g==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CY5PR02MB8893.namprd02.prod.outlook.com (2603:10b6:930:3f::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.22; Fri, 2 May 2025 09:19:02 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:19:02 +0000
Message-ID: <8eb79cd0-8b0d-47ad-a551-7b55da536768@nutanix.com>
Date: Fri, 2 May 2025 10:18:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/16] hw/i386/pc: Remove deprecated pc-q35-2.7 and
 pc-i440fx-2.7 machines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-9-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::12) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CY5PR02MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: d127fec6-a0ee-4376-baae-08dd895a6112
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1FXTFRnVGZGN0t2ektZUitHaXBXcVJ3TXZDQnkvdktCQWlHOGRDV1RoM1Jl?=
 =?utf-8?B?ZTVVcE10QkFDRGRGcDd6Tks5bWpKR3V2amNjamx3VzRXRzU4WjFUcDBEd2pC?=
 =?utf-8?B?cUVUN09FeG5weGNKMXNlZms5Q3kxU3UwMC9Kb2pnQWFlMkxqMmUyRlV5LzQ0?=
 =?utf-8?B?ZWh0Z0ZYamRwZXZqUCtxUkYvTFp3MWU4clFZdkVZTzJYTnVsNnhkYXVqeGx2?=
 =?utf-8?B?Z2VrRHBHM3gyV2ZlMktGdTZsbGgxZUtMN1YrZmk2R0ZXTzJKMTBOTGM4dXN0?=
 =?utf-8?B?MStBVVFIcVQvMDA2NVduYzhvSjJyaS8rRzg4MXZQSmdNSlhua0U4cW9JYThh?=
 =?utf-8?B?WHAxeXo1N2hzUGlLNndOK0ovck9KMW1wUXA4alRoci9yM0cwWnNLMUI4elJj?=
 =?utf-8?B?UjFPQmZTOVQrYUx2OVBFL2Z4QS9qbmNvZHhjc1UyQlhWQ295VExybk9NbXZM?=
 =?utf-8?B?M2hBMDdkN1gzeHFjNXdWcWN0NXN6VUgySE9nR1dPZlY5SDFPUG9MNHdqQzB2?=
 =?utf-8?B?dS82UUY1c3k4VUN6OUpCUUxUbkRYczZWdEpGdG5DU2xpVkNHcWhJQmY0cEQ2?=
 =?utf-8?B?UVh5cmIvVVc5eVNUYnpqeURBNGp1WGliZVdsZEFGa3Rrbk0yd0N2MUM0bytQ?=
 =?utf-8?B?WmNkc3VXL2xCWHd2NU1RR21rMWZRU3VRR0RIM3NyNWN2QjB6RDRvWFB2enhu?=
 =?utf-8?B?b3NydWlPb2FhNFMvZ3MzYVFqU0I5cmVvc3ptUGNvZFpsVE9ZNk1CRjZSNFFv?=
 =?utf-8?B?RDBPVXNtSGEvVkhXa245akM3SmM2R0pYOVBMSG0xb2RSenBYMWtxODhka1lH?=
 =?utf-8?B?TjgzSHZySlBDcWl0UTRwWlJiWjJkM3p6VS9uZGxQRlJXaUVpZFdXRzVlY2Rz?=
 =?utf-8?B?OFNrMi9nWXVGRDNoLzFoWmpNcjQwMCs4ZFlJVWVldGhJS0hyRXVyeVZJNXUx?=
 =?utf-8?B?amZxcDlEOStNRDZ6UXU1T2s5YVdPMWx1V0tnU1NnTDkwYVJBVlloY21OcUVn?=
 =?utf-8?B?L0JNZG5CNWpFWVAvZGppQWZEWW1nYzZqc1N1U1ozMzg3U2d4Z0lueHB1YUE1?=
 =?utf-8?B?L1BxSVIxQXpMcS9lcXo2L1d1OGM5RXBkSlR5LzJiNTh0NE1QQlFWemFrNitT?=
 =?utf-8?B?WGxpUlZCUStIQ1dmamhKNDk3QXNRbm1BbnZpRzFwWkpmalJPVXZnRlJ4bEMr?=
 =?utf-8?B?MGMwQ2JCNHZpanAreE91czBvWE9laHlzM0tuejJSYzVGN2M2eUc1a1hTZVJU?=
 =?utf-8?B?OC96S0xUd2NqaHFOQ3ZzZFh2VzI0c1p5cEFLVUtZNzlucnlUQ09WUXAxU0J4?=
 =?utf-8?B?a3pTeGovZUJnM2ljcFR4Q2Evc2QyWUgwUWZUTGZQeCtjakE3aXQ3aVdUdEh0?=
 =?utf-8?B?K2RrVzYvVHQ3T0Fpb2ZKYnpodnUvcWJJZDJtQWFxWXpCaHRuTHo5cGVFc3Jk?=
 =?utf-8?B?TVM0VTlpTVgwSkZiTEYzcWZMN0VGV1RONDJrVnpFSFpaN1FYREFpWXhETDlv?=
 =?utf-8?B?bjFhMVZYQTBZT1B4SkdDVldqOFFYNVB6N1djZENpSkpHMnk4MWxCYVhjZXp4?=
 =?utf-8?B?OEw2cGl5bzhsNUtoY21SU3BSZWNjNXdQVWMrdG9wUXNlWFZyQlArcnA1YTBE?=
 =?utf-8?B?RmpJVmtFT3NyQzB5UEZpWmRoMWxZYWFsNWQrQjBnMUN0MEorazhXeGNzTkZl?=
 =?utf-8?B?WUpzNUZNd2Rsamt6MWhKN0pFMUNGUnFlVHh4dWErMGZrRmtnSnBRVmFWc1Z0?=
 =?utf-8?B?OG9admxjYlRIYWp6WXE4dEZVM0IxemhhQTc2KzlwZk9LRFlQemVvRXlsak12?=
 =?utf-8?B?Q3VSSFV5b2JoQVVTV2VLRm96aitGWE5VWU43dnR3ejhUNHlIT0FuVTh0MDQy?=
 =?utf-8?B?UHZuTFk3UUxWSERHNzQrR1hMTDIzaVpCRzRqclZlbHRLRmVhSHRtV1VwckNX?=
 =?utf-8?Q?pnskq7hiD90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2pSL1VVd1F3NUxZcDdvMUd0RWNqSGlrZnVMQzJGZ0NCWDZ2OGxlNnp4Mk5y?=
 =?utf-8?B?VTZ3dmxpSlZ1YzBLTDJnS21xUXFxa2lNY08wSWdqWHhnWG5id1ovRUtnaWNP?=
 =?utf-8?B?bk5ORE9iWE94dTJvSEl3ZVA3bVFVYks5UUdhL25NYmZyOCtwQnUrL0FxeXk5?=
 =?utf-8?B?S0N4RFVLVElYQzBxUlNhb2ZEQ0UyMVBmaHo1c1czaGF3TXFES1d4UzJwUTEw?=
 =?utf-8?B?b1dreU1TalpZM29oUmQvdW01OXdGMHRJa0F3SW1tZE5LTU1mMEV0OEpHZTdX?=
 =?utf-8?B?REpvYjlnMXpjNFpyT0F4MnBXck43MFg1SkdRUnloejNvTlBjYmREVVdRbm85?=
 =?utf-8?B?ZHB0T0F2M3BvOUtodjBnZFhzTzZmSEl0T2phZVlDdGFKN0ZNR2pNSlJkbmF5?=
 =?utf-8?B?cHBCVjlYQjNPdGpMTkZtM0JaR1J1dHRnK0lVS3B4WE9jdUVNRlZZd1A1MWg3?=
 =?utf-8?B?TSt4eUFkU2c1clFYcUNOWmZaaWRnTWh1RnVOaEI1UXErYk8ya3h6RWRXUDhK?=
 =?utf-8?B?cVkwY3Z3TEkxMlFob1hCZjltRDFtc1BCdUtjdmJuMmlCUjVwMUZlaURGSndI?=
 =?utf-8?B?RVJNd2FXTUsxU0dtaG4rSjBqK3QvY3paZ0E5N3NBZjZHSnRxQnhrdm5rSERw?=
 =?utf-8?B?VzVBQlR0YkdQVHJGZVM4QzlWdklKL01oNGcyeVB1RjR5eng5WXVJbGk0VmE5?=
 =?utf-8?B?ZERVTUlYL1pDV0REdjh3dkxiekVlL3BZd2hRclNRTlFSQmtacjdJc0RWeXBD?=
 =?utf-8?B?eGM0ZjRCSkh0RFFtN2lZWUs3eDFmaGZRWTNFS1VUZ2tpR3ZKOG1NNmJ3MWx2?=
 =?utf-8?B?OEVveFNSSHBOUEovMlI1WEdKczBubjkzeFZoa2ttdUtHdVhlU2dUMWhtQldz?=
 =?utf-8?B?elFFMFMwQzVVcDB2MFhnN3d4bmlKWFFxZEl6aUlQOFpEUkZCTHlSUmNzeHda?=
 =?utf-8?B?WmhTeXkvSFYyT1hlY29rd01iNmREMjR4RmVnNDBaMjJZMS8xU09yamQwVVJw?=
 =?utf-8?B?UWJUamZ4OW9leTdJSTZReG5aZGxiQi9PQmtVNnVUNGlDR1VmMUlKSVFoRFhO?=
 =?utf-8?B?MFRtelBraW9yQ2dySFEwaWMrakE1bGVCck1tTUJMTUZ3ZkZzTEJ0TVM3SEI5?=
 =?utf-8?B?WEk0M0ZIcHNzR2NJVjN1d3l5WmtWSzhHTEFGbjNJNXhxYldlWTNsZmZKRFpG?=
 =?utf-8?B?TC9WMFVPSUVKZXhjczk3MkdSamhpZEJORlh6ZFM1WW5IRnRKNHpwZ1BRaFB2?=
 =?utf-8?B?QUVHNWtxejBzU2VoQXRkaXJHc3JLWVdPanBHb3BQcXRpTmZ5VVNUSFFsT3F1?=
 =?utf-8?B?WTBsdFo4UWNHaUM5Z2hLclFUcG5tZXZYMjFMUzdXQ0V5VkRDMFNSdzhlT3No?=
 =?utf-8?B?MTlSSVEwWmNCQ2VDMU9UNXdSbWtYR2Vtai9SZnl3Kzg1WDRrTGFpRlBGSXpv?=
 =?utf-8?B?aTNJQUtieXhHMm5SVVJHYjhXSnEwejREdUFGYXlDR0N6a2VOaHVIc1ZOV2Mv?=
 =?utf-8?B?akNvaVFsVnF6NCtCL0pqaGNlWW1VOFllTFQ4REVMRm9sMU5lRkFYdkR1K0Q3?=
 =?utf-8?B?dytpYnQ1ZkFPWkRWV0J1VlNGbTI4Ull3UnU3UElFZHZ4QjNWNXVCdWVlUXd1?=
 =?utf-8?B?b1RMclNLaGRLS3FIeEk0UWI3UlpaNXVHaUUvaktlc2lxeGk1cnF5a3ZxU0ox?=
 =?utf-8?B?ZFFENHcrYi9wVnZuRFRvSTlEc3l1NTZQMHY0Q1grYjJOK054N2hzV2U4UkJR?=
 =?utf-8?B?OGRnN05JN0NkTHR3WEt3aHhhampyQlBYcEUvN0RGU1I2VFFrR2FFSkNwZjNx?=
 =?utf-8?B?VjRJVkxKN25ub3NvOEpFekl1OHE5dmw4YklKVGVVOUdRQ0VITzZSem5zSzZ2?=
 =?utf-8?B?VWtxVVhyUzl3b2FKRzVhWDEwVXRKNmt0V1k3VXVVYkJvRGNsTmdXNERuSVNr?=
 =?utf-8?B?Q054N3Y5alY4YWpWS2pKVDJQMk9DeUJsdmo1ZXErRGJkQTF2eXZiOGZianRK?=
 =?utf-8?B?OEFYTGpPQmxIcFBCOHFXMVVYS0l6UTlGRks4ZFV4Q1BNb1g1SWpBcWJYbCtZ?=
 =?utf-8?B?M0M2N1NWQXgyRytsVi9KNGJlQW1WZlFaNUd1Y3RBSHIvN2lIaEg5ajhwZkQ5?=
 =?utf-8?B?bmpHZVRYaGdYUlRyTkNCS0FyNGlRdkh2NnpLVEh5VnZSTy9qTWhJaVZiRXJI?=
 =?utf-8?B?T01VSzdaaEErOG03UTZKNENtdGE0MmJFUmhmQ0hab0I0V3hpcDhtUFN3RkR4?=
 =?utf-8?B?cVRuM3ozRms0SXlwV1dvcFp4aHFnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d127fec6-a0ee-4376-baae-08dd895a6112
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:19:02.7355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTZcZ/q24FZ7MwakXi7BmImVveAx5aIH5w45nw0C0uDDmZtLsUlostaUEqGCivp+FswFd7lHW6RRDro1ZoyCRKd9Yg8IYOo9k5WxwcLIYOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8893
X-Proofpoint-GUID: E_XxppVwpXozVfu_tgC1-o_rukZLXgIM
X-Proofpoint-ORIG-GUID: E_XxppVwpXozVfu_tgC1-o_rukZLXgIM
X-Authority-Analysis: v=2.4 cv=RcyQC0tv c=1 sm=1 tr=0 ts=68148e08 cx=c_pps
 a=GbYsmhbcUJoGoLxTsnc7yA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=gwWK2axJZMUJILQfKI0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MiBTYWx0ZWRfXyhDeBqlLzadh
 IALz5v1jeNAGNRrjouhn8JmbTdQtMtYcsaPhIHC+VY2V4QhzTPiOhATVOdafbabA05Zid9uvBWg
 xcObbkqnxWsceK31cMVOY7dYwUniaN473J96ldh43bVNM7e5TePT7DtxVMF6oZRBBeqapj2SaWc
 udN8uOvinUkBzfycjZDLlHb+qMem2TXB3aRBQm7/QB3AEhSVmOyqP97hIu5jmDUwzId9OvenpgP
 y6+RaQjG8bok5eMLErKZNINYvfGL0YvACmnjZkWnZTbTdXbsbcqG0C920Jps4ovXIcSOb6zcRCM
 uKBew+4DMlvYGq1dDecExCMarc65tql7A+dv5Y3c0/oObQolHn1DZiZaL/QfGKVvxX+KsaZ1scs
 D2Td46zAZD3V4QKMlfIq4HYp0pYaSsjodQnOSp37T9EqjoGUVLE3LFxdeRGcWD9Q4l4YvUay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01/05/2025 19:36, Philippe Mathieu-Daudé wrote:

> These machines has been supported for a period of more than 6 years.
> According to our versioned machine support policy (see commit
> ce80c4fa6ff "docs: document special exception for machine type
> deprecation & removal") they can now be removed.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc_piix.c |  9 ---------
>   hw/i386/pc_q35.c  | 10 ----------
>   2 files changed, 19 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 98a118fd4a0..98bd8d0e67b 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -755,15 +755,6 @@ static void pc_i440fx_machine_2_8_options(MachineClass *m)
>   
>   DEFINE_I440FX_MACHINE(2, 8);
>   
> -static void pc_i440fx_machine_2_7_options(MachineClass *m)
> -{
> -    pc_i440fx_machine_2_8_options(m);
> -    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
> -    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
> -}
> -
> -DEFINE_I440FX_MACHINE(2, 7);
> -
>   #ifdef CONFIG_ISAPC
>   static void isapc_machine_options(MachineClass *m)
>   {
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index b7ffb5f1216..a1f46cd8f03 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -648,13 +648,3 @@ static void pc_q35_machine_2_8_options(MachineClass *m)
>   }
>   
>   DEFINE_Q35_MACHINE(2, 8);
> -
> -static void pc_q35_machine_2_7_options(MachineClass *m)
> -{
> -    pc_q35_machine_2_8_options(m);
> -    m->max_cpus = 255;
> -    compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
> -    compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
> -}
> -
> -DEFINE_Q35_MACHINE(2, 7);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


