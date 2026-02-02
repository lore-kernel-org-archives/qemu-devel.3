Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B7CE7DF08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxDp-0002uY-1J; Mon, 02 Feb 2026 11:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vmxDJ-0002ZL-9P
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:55:54 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vmxDB-0003yd-KI
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:55:45 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 612FR4hC3093003; Mon, 2 Feb 2026 08:55:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0Q0TH/KZ9PHR2kbLlbXjWEPNRQY7fC87o3HMNnLoy
 pE=; b=ozZ2peae2mx+qlJn2we6BKFVR2VBaCBGQtiWZA1RvxgFUzYdfJeiW4XE5
 6e/sSdwpo+iylwNOTWAzNAsf7EHft27iJ8YWwupRfDHUXz7vRk6OWxKK+oKESVue
 LRcMeQl0du97a60oCx/CWjKMTpIP+yjRka1/zRbg+UAYOPJNTErMdJ6BqEzBDCfY
 bg/gmbokrzrtodqqsVVobOXMekOWyXaSZi+K4I67j9r5P/DsjiO0kc562qytO/94
 4cXmMLVhL7AhL8i5e0LTxymzbH5dFCKSwX2B35u2QNLpli229+GRlgTuABdcFwlt
 TVkbFQT6fyFv+n9z2Ae95clJWDYBQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11022132.outbound.protection.outlook.com [52.101.43.132])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c1exs4asy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Feb 2026 08:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5XFfMRLmnb8l7DtSh2vq4ghXbnWxGweKT9X/vw8YG3wFwUoPbxYTPrrdCYd6PgpJuBRHeKZK+ZXiHHokph090KXJfzCepJ5yJDT8dhIaGp7AuBWBJ3+m0jFvIunsVFwUOh5ec3PacQdvUvTBr0sIQlimy8ksfEMmci7VJT1JXMAvaXjO634tl+aXNztxEpu73LIk56gQAStAR6l1V8ESMOq/atIUzE79zLqNYWT1Vz+kfctFt8ueDdpjuWPRissyqukeTccikX/tIGaVEMludnWf0cVdnxHeQD4Nvg48zm9dtKeX4vxz7uVmF2joQEkj3/GciHy0HjQhAwT7PRXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q0TH/KZ9PHR2kbLlbXjWEPNRQY7fC87o3HMNnLoypE=;
 b=RInBQeDGf/hUnehrLQ3zP97/BeFvpLLKCHDm2DAHJ/NRhohO9DVi4MSZVJH7nUPohJA/lloWMY2TDaPGh74zhqO33qUmWdre+I0tlMxFAW2RZj4+a3v6DcqzpxGkhso4Xg0zp3jAid0ggEA3wmszRdu/gOEVgsYh3KBLypdbOW8MS9pDwR5KpiDp4uEj1YI4o29w0WDpJtnqQgCdSb/N93w6SRtf4MNwikLpCkgyAbzAzNXael6lLzCGmy1QsKMXSuiVPNb6QM1k+Az3/gV+i47jDU5Cdxk+7z8abEPqQHr2zkLVWHemUva3k4Z3MWyoGy+bKtzg4QqpSG3aVO1JFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q0TH/KZ9PHR2kbLlbXjWEPNRQY7fC87o3HMNnLoypE=;
 b=WH8/qyHCSCwE76Jpc3NxpPvs/JxczT6ozZSKe0a9mlR1Ho840K6tz+5ePfbSU6fVYjXFb23v09dd795df8JLzia1k7IbB/DBkH86f3t8BY+UzD+nJE+jtd+mDoDRZFvq8OjyvrP+HMpI4wMrONIsWfIO1svCKqCf8Xq5EcI8qKn8Yy0LVQElz7mtKGLWeaw9HQjpvcb3b8a/tXlHfo/jhbMI/Y0NL3syl/I4CcwvzC4CgnbW65wxS1Nd2d07gbaeek4GRnRfcAvF2aajPw9ag6MXd+FGbyQdco7q13YLlWrwvG/S9mTc+5V7mF3ehUGgBv33+1ptU+wzSOxv7d0K6g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB8646.namprd02.prod.outlook.com (2603:10b6:510:10e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 16:55:34 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 16:55:34 +0000
Message-ID: <23be2c83-01ea-495d-b14e-496bd3e0a687@nutanix.com>
Date: Mon, 2 Feb 2026 16:55:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
To: Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
 <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
 <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
 <CAFEAcA_zghZeA0PzivCY9vCcFk6rVLwvP3in35rA=bF8yrdeyQ@mail.gmail.com>
 <878qdbtam7.fsf@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <878qdbtam7.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0105.namprd12.prod.outlook.com
 (2603:10b6:802:21::40) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB8646:EE_
X-MS-Office365-Filtering-Correlation-Id: b690fdd5-cd44-47b9-9084-08de627be1c3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjBBODlkei9xSVo5WGZCaHhJUUlRL1BnMGxuT1E1RHlnTUpWeXNFUVdVZnd5?=
 =?utf-8?B?djd2b3NFT3J1Y0h0cUx2ZFVwcUF6S2NWVWc1SlRGWjNJS0ZiTjN2bjZ5S0Jy?=
 =?utf-8?B?MVMyZEtMUUxrUnBHa3J0Q045SW5KMmRSZzFwcDgrdUJzYXJ6RTR2U1d2RXFn?=
 =?utf-8?B?WVREOUFCU0cwK2hkaFZ2aGhyNEhuSFc0UW11R25lRElpc2FSQVhDZEZTRGJh?=
 =?utf-8?B?aFgzSWx3QTFrcmNBa081RUZWNWxLd2hVWTlQOGxwUVo0R0I3cThxSEUvb2po?=
 =?utf-8?B?Q2p0OGx3eFlWMTc1Y2VRWmRQRmpqVDV2dXB0dGV0MU84NThGY25vdFlYNEFD?=
 =?utf-8?B?NWtWekt5K24rVjFqMHB2bkk3d0dDcDdMRHRxeUI5S0lBZFE0aHRLNFpiMzEy?=
 =?utf-8?B?a0ExczZjUmF4cU13TmtvN0VtWHRRZTBGdElsRDZFeUg0RzJiT0hkaXRPOVpI?=
 =?utf-8?B?R29Lc3VkMnNMSERqQU9nb0k2WVd4VGdwOE4yb0lrZUdjck5GY2cvMDVPVWpP?=
 =?utf-8?B?STlaNHZjYnpHWWxBTVF3ZStWN1BBcjY3UGVSaUc5K0dzam8vbW1XMzJrZG5k?=
 =?utf-8?B?SUxhSEc3TjJXaTRGQm9MSFQvR3RWV014azRvejIzckJ6RjhuUVlJYmczNDZH?=
 =?utf-8?B?NFhUTm5MVjVCYklvYndnTTZoanQyOVk0dmxMVGdVYzVLdjlINkNUdUh2dm5l?=
 =?utf-8?B?RVdGM2UxNHQwbFVPQTNsN2w4SG5iRVBSdVAxbWc3OWJQMUE0ZkNkZzJ6OWpJ?=
 =?utf-8?B?bDBwYjNKZGxLQ25Mb0dqNithdkdZVXkrb1gzRnQ3Mkd3Y0VGY3drNDFLY0xt?=
 =?utf-8?B?NE4rbVArRjhXdmVSdEkvU0JOVVdycENuV2FSZEV5UEM3SWhjUGZ0UUdWSE4w?=
 =?utf-8?B?bzdyYnN2eVFCbU13Y3c2RDE5NDhMWkJNSWllY2tTajAwZXBHSTlwc0JpK2NQ?=
 =?utf-8?B?Z2hpdnNhWTR2SkVVQ0Z6YlN6WE1nZXdxWGVTOGNaUWlUYTlQbnMwWmtuR2dG?=
 =?utf-8?B?NDI4WDU0bm9BSUE0UThZZVBUZEp2cEhEOHJiU0kyay9NMEx3RmZYeW5aVTZN?=
 =?utf-8?B?bE5CaU1TUHdmVkF5dWF6UnRsS2xETzFoS0dzNG9YdkY1bWt2RitrN2E4a2JR?=
 =?utf-8?B?L0xSR0kycmQxbCt5Wm9OYTN0bnNKek90VEk0ODgzTTBJMCtRZEJWcnFUVVdH?=
 =?utf-8?B?Y2JubVhBTEFxMUVjVmppTjlzenlLc08zM3kxcmdyZTg0YzVCU1VNVElUQWdq?=
 =?utf-8?B?Qy9QMzN3NlEvRStGOGtDQnhkUmFuVUoxSjNZbi85a3grcGJid1JDa0tkSnFJ?=
 =?utf-8?B?cnNiTTA0SmRiWUlwOWpDMUR3VG8rSCtmdHZ3L0xxSlFremhUdGs3NGNxMUFh?=
 =?utf-8?B?cG8rdndZcCtmVDRFcm9LRjlBclRQTmpOcVJRa042SWQvbkNobWl6cDFtaDNl?=
 =?utf-8?B?b3VvbEkrWi9lVTh5amhnNWVWWi9GVURFdjFJWDhFdE5odEtQbkROc1ZuSWN3?=
 =?utf-8?B?cWhrS29IZm96NjhqZ0p5NnRxL25xVUZ0YzZwVnhlZjZoazE5Yk5nK1lGcVB3?=
 =?utf-8?B?UzlFaVNkR21mMXBHRmV5b1JHUDh5bGwyeFlYMWpacDF0ZkdyYVZGTVdIUWMv?=
 =?utf-8?B?T2NqakJtWlh3S1JPN3U2TWlrQjdvVXBYUXFuNm5DejErOFh3ZmVUaHJ0QzdN?=
 =?utf-8?B?M2J0TW9aeGVvc2M4Y25PNy9VODlZK0p4Z0JObVZTMi9zSCtIV0Q3dW1jWDN5?=
 =?utf-8?B?SGpjbm1Ec09OTStRTTEwaXFaU0EzR0RVMlV2ZmVTMTNBOU9MMGM1NklUTnpt?=
 =?utf-8?B?amc5VXgrb0pDWUZtaVFqQzI4VWo3a0Yva0dlemxyTWUzUVdXUURqVk5ua3FG?=
 =?utf-8?B?QTNacE11Yklaa1VKd1JMOGl2aWU3ZGo2Ym1HelpSNytTSWZrL201TDZyZUV3?=
 =?utf-8?B?UmFaUHhQRTFaOVlPMkRCWlVzd3FadWYxQitDWkQ2YnVhRGh0S0I1ZitkSzJZ?=
 =?utf-8?B?QkN6cHZNanJJNHkzNEd4c3JzQzN4ZksrVVh4T1E1V1BENk1FTzhtd3JxQWNR?=
 =?utf-8?B?K05mTzRtaEllRTZCYkpQZFJ1dzZxRjBDYmJpZDFNKzhFOVJpZittamlKM1hC?=
 =?utf-8?Q?omKA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2hmRVdBOXB4ZmNkS2hNUTljVVd2Y1M0OVRFRVUwREF6TTVzM25KaEFQVThD?=
 =?utf-8?B?ck5nZENlRUVscW1HVHFqVnRXUGx2WGF6c0M0eTBtKzNxWmlLSlFjeU9Wd3lF?=
 =?utf-8?B?QTdWTnhCMHNXYS9aSk9vbjlXZ1FiNzkzckY1aFdqNXM1dWtWVEVJQUc4Y25J?=
 =?utf-8?B?SWJGa1A2REtTUElhVWtQS2VxMmcxTDQ4VmJlcVFOZmtzVWtpTFM2dXRQVlE5?=
 =?utf-8?B?NlhXUTdXMVM3QzdVcnpLRWhhbGw3eENFSUx4RzJCZjFvOEZadUFqYjByU2pY?=
 =?utf-8?B?WXVVSWt6WU8xczc1Nm9VOGNlVWUrU2x2QlA5cTZFN0dhR2JIaVFtcHZBWGNn?=
 =?utf-8?B?b2o5d3NxRDJEdUplV0VnOXp2ajBhN0FiYUhwSmw3Q2ZrSkxSZ3ZFVmhJYVFm?=
 =?utf-8?B?Y1ovd2ZSbkR4cklPZW5BVFI5cDlMcWlrcW50NE5GVHFKajByYVAyQ0VNUTBB?=
 =?utf-8?B?eGpLaDdCaE11SnREM0x2N3pPWjNaNWJRM3N0bUUwcFlKSmE5TXo4U09vWE1Y?=
 =?utf-8?B?ZEdOWkNmVGJ6WXE3dEZ2ajhWeit6ZWxicVRPRmZZT3NxZUF1cnMzb1dvdURE?=
 =?utf-8?B?SFpndnBIZTBCZ1lGSFBUczFCNFY0SmxBUjl1b0gzRjlOdmxxcFlNeVZscWVh?=
 =?utf-8?B?NDd2YWhyZUNLd29YYkZNZVpwQVBkQ3BOSFowaXlERks4ZUQ4MlJBSEJFTWxn?=
 =?utf-8?B?dTNEei9VdEVyM1dheWxuRzBOYmNsS1hjd0hCR2lTSjROV2hNVUU2WWxDak1a?=
 =?utf-8?B?eUFVaVp2bVRORnZyTE43dDhRTm9uMHMyTkduWTBEYUdmaVpnRTVBbHhtRXh6?=
 =?utf-8?B?VHdIUHllaXRRNHRoUGdYOUJ0RG03cCt1QktFRXpmYnkveWVKTllhYUloMGZo?=
 =?utf-8?B?Y0tRck5PZVlZcTVEajJ1RGNyazJOZisycFpWaE5IS3E2SlA5bTJFclJ0dkwz?=
 =?utf-8?B?R01Ea3NiQkI5M3NvemRmOGVkMUhTa1l5M3hFam1NTFVobHBjVStUQ1pPb2lv?=
 =?utf-8?B?bzhaQzVWN1ZSRUREeWRsSVF5QitiekR4MHhRZkdQTTZvTllkRjAwQUFpZEdO?=
 =?utf-8?B?dlJ6dGpsZnRvKzlpcDA0T0F0WFh5YUE4b3IwNUhwYkhRc2pTYzh6THhtV0tB?=
 =?utf-8?B?MFNYRUhtMVlYL2JOWTE1TWNreXg1TE90RklOeDVjalZJcUV0R012WUE1Ymlq?=
 =?utf-8?B?cUxOUDZTRnJDanFmMDF5VkdDYS9xdTZ0WnV4Z3d0M0xSd0orajBzbnJSZy9M?=
 =?utf-8?B?OXMrVElzazFBaFRPNzdVOVFDMndzRkZnc29WYmpZQ2hyQ1V6WFhjWlZ0U0NC?=
 =?utf-8?B?T3dlVjcvOEVLQlFDMWZ1TGlmdDI2dW9EbXlnODVtdTYwSGhGWjJENTlGcDFC?=
 =?utf-8?B?aWpsdzE0bmhZT1Q3Rm1sbjUxZ0F3UE1ROEwzNUFKbEZYa2lvaWxSVGN4Tzds?=
 =?utf-8?B?M1EyVXVEaElIMVVGM2VDWFE4SFdGajYzWmJaWFNwZDFHZVZ2YmNTSVQxRUh3?=
 =?utf-8?B?UG5oYjJlMWM5cTlJakdUbHBoWmc3NWhPY3NTMHUyVEZWZkVJNVVRa3RUZGV1?=
 =?utf-8?B?dFZLOTBpNDdPZnJUdStlTE54NjdnR2FSc2lHWDN2WTUxL3IxWGQ4a0ZPdnFa?=
 =?utf-8?B?b01kWWlMcjlaV1c2SkJVSG90N3hLTjJxMzZHNzNqbGFkSm91cklZTEVmemZE?=
 =?utf-8?B?NjJSWkU2Z2M2WU1xNG5FTHpwWmNEQk5YMzVtQzRLcGpzUGJ4NDk5STlHcW1S?=
 =?utf-8?B?V0lCNXpxYXFXc2ZuSWZxVGFDUW1QdlBWcXVLSHNucDh0MEMrOWl6eGs3L1RR?=
 =?utf-8?B?UXdibEdhMm8ydWJyQXNNSjNiSmFXVEZIV3o4enVrT0VQeGpyYXlhb3VERjlZ?=
 =?utf-8?B?cGZiTDVzRG1CZVFnbC82VjFkSUlMRzFHajYxbjBuUDBoMC83OTN0bG9HYXAx?=
 =?utf-8?B?cHpCSDdmc0ZuMGdpeTJ4a0xVYWlhWjZtRUI3U2JCNS93aTVXQ2F3dXBiVEM3?=
 =?utf-8?B?NG5LZ056aGZGcDZJUVEvOXhKejdVRzNXTFRiclp4SXd3VENuTFREZm1YQWtM?=
 =?utf-8?B?Y2p6Ly96enk2Mk0yU29CT0VLZlZMWUgzVzJobjl4WE0rV3dBREVBM244ZDRk?=
 =?utf-8?B?NWNIdHppME9vcXJSd3RScWFjQUxkVlhQRnFuVHpOaTlBMWFZK0xMWGdMVGxE?=
 =?utf-8?B?SDhNYkpaRDE2MGxBaklVTVJXMXVXSFJ6UzhzMEhUVDB2NGR6R1NXSTgyYS8w?=
 =?utf-8?B?YlZHTVZtWU43MWMxVlp1YWRGdjUrU3loakhKRmFBOUJMaDc4b3pzeVBnQ2lh?=
 =?utf-8?B?eE5iU25ma01wVzE2ZElhaXdRcnE3RXp6YXAydW9RQTc1Z0NyMDQxenNmTlFQ?=
 =?utf-8?Q?+Pnbh7Ck5QeZwoj8=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b690fdd5-cd44-47b9-9084-08de627be1c3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 16:55:34.4513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yum9hqhDAPjwAFMhodt1pw8qQwyzho3oluJeTnb7ULQJ92+ZdS9ULap0DkBDNz+RWER/juzB6yQ6TRaS78pvI+WO5vL6OAeDD87J1yc2O7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8646
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEzNCBTYWx0ZWRfX3EU2gCRr1C1h
 4yHoulUJm6TiM8kaKKQS0hPXsAJy73EeGLRlD/2M0xs9ksW9V1tuNGCpCySx7FOmXd3h5OPLfsa
 l3CTn+5CPUfya4BWr4aPd2GZIOpsgKPVmpoC+f8LgtEEFjJEBlm8Ky3cJuwuJwl2D9BgVOzYbaF
 TqMe/2moekUXOTWMkBiWweL1mle4Zb34fyWv9dMo5UrhMOV2SVRWWbMfUJx9tXyb+fZzDjzpKrU
 fZ9Cyufa3isY340GcXSlleZ+GRZUBe5zqrWp/MrfXZdvCnRuvnpP6j6bOB5ukIKAK1Mcr8rUl5D
 9iXMOjtoUKOJYvgo/RXNAU/NtUTObQPAN5OWtRzPlxsufMpi17/n1VMKmMQ9iSqc+e6Q4cnod89
 dJGRyja6D3wniUAYs08Sy7xiu8KF9+6QEFpRUf+EPYN5QOd+uv0AiP4ZVEbX/XNDuYUoGrlhcJ3
 sTZ3+tBVmtTGUtnLhnQ==
X-Proofpoint-GUID: Jm6tL0SyckQp75GnFWjoqX7jIiugJ7IZ
X-Proofpoint-ORIG-GUID: Jm6tL0SyckQp75GnFWjoqX7jIiugJ7IZ
X-Authority-Analysis: v=2.4 cv=G4YR0tk5 c=1 sm=1 tr=0 ts=6980d708 cx=c_pps
 a=T6DPE/DVwP9kL+SBve89ug==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=HfR73fzlSzAs9sQ50IMA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 02/02/2026 15:42, Cornelia Huck wrote:

> On Mon, Feb 02 2026, Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Mon, 2 Feb 2026 at 04:04, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> On 1/30/26 04:41, Pierrick Bouvier wrote:
>>>> On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
>>>>>         contrib/plugins: add empty cpp plugin
>>
>> Hi; this fails to build for me on Linux (Ubuntu 24.04) with clang:
>>
>> In file included from ../../contrib/plugins/cpp.cpp:33:
>> /usr/bin/../lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/coroutine:38:3:
>> error: "the <coroutine> header requires -fcoroutines"
>>     38 | # error "the <coroutine> header requires -fcoroutines"
>>        |   ^
>> 1 error generated.
> 
> Fails for me as well on Fedora 42 (x86_64) with gcc:
> 
> In file included from ../qemu/contrib/plugins/cpp.cpp:33:
> /usr/include/c++/15/coroutine:43:3: error: #error "the <coroutine> header requires -fcoroutines"
>     43 | # error "the <coroutine> header requires -fcoroutines"
>        |   ^~~~~
> 
> (It works for me on an aarch64 RHEL 9 system.)

Is this with a clean build? I had exactly the same error message 
earlier, but I was able to fix it by destroying my build/ directory, 
then re-running configure followed again by make.


ATB,

Mark.


