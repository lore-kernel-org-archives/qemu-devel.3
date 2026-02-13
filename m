Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF94EEA860
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpnd-0006Ec-Rm; Fri, 13 Feb 2026 04:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpnc-0006EJ-HH
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:49:20 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpna-0006zO-UX
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:49:20 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CMKUhd684214; Fri, 13 Feb 2026 01:49:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=5SbD9nytLkEiqLrdctwRW+sBRcdAng0CYApPP3SI2
 uw=; b=JxsCoAa4agWoey92U1UkDaLp17ixRdvLhPKfQe5Y0utGJtdTYeykerL2J
 N7jh47QGIZsKsu8zJ9tTVQ/+bok7lAC09w2Gz4b97xZcB3lek7jFmcJRLUCiYRYU
 g/sqdbwCXCoMpA/md5gzSAdr8W7DzXJT4tDS7o//tgr1NjdKJTMha3YjzbSObcgA
 bxDUg7jKKGjwkd7cPc8VGhwo0eFHyMvLGPxwBXqFOR7AoXwojekxsX+zmlOsqqfZ
 c5QwdVyNHwHrFXST1uip87CMymLUkC28LRjPB6iJKnaq//oUuVVwQT2PWcjvxN6P
 q6m3HchWyuOZ4u67Uj+9a676ujPDw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023095.outbound.protection.outlook.com
 [40.107.201.95])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8n7q7aq2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 01:49:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmPLs+PeRM/nElDJODbbBW4ZLu78Vic/57XUqRVi9d2EdieHCd3Faj0alWuNLMINkCCijz1OXinXMpjkiD6jhXYSOGsaTF26nEOKBUymmSlsYC6VmWl/8ZhHNK29CwO+fxHQvGe/WkbgX1s7t/c/AUZTLNBUKFlFNMnSMbo80McgsFemzviux+sW3kH207ALIr9hrQFow0rQG8XOp/9qt0rFDiHw7oGbeYkT1qomtWMQzYawcmrQbAv+DWmxIGMfzBq76AoE55Qrasioi8qVWHetxsMcErdSlA+NDfDTqh67jW2WF6gT/Zb41qo9DLKVgyUc/K2/EIyLlDMv4Lo8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SbD9nytLkEiqLrdctwRW+sBRcdAng0CYApPP3SI2uw=;
 b=wugkpnkLJ0PVO1qSNV/IEwE4va1XqxScEb0KkoHGTevAdG96ivaHi/iRh8PZ7hvYNqJpORUADi4tTrF8hSOixv1YZYqEikKlpsd5ObUbBs+MxrFKhXvUguR8LoVNSNcaVFJUyk1PGz2AtLIfmG/Ui2PwGCl/UBxrULMC51z/xwtIDF1cZTIzn1cAGAc9KOCAOn/zxDQ7bjgKdPECBkVMihnOK2FpCMg2C3hqWIroauc/qCWtM+gsT9N5x+yXlq4sMatscoD8sybdgVFHIeUcfMoqy+rSBVBiI1NcD8FTJqKQH+dp45g5r/kXaqC3EkdhUV2r6N+CNHVO9BF9wusGKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SbD9nytLkEiqLrdctwRW+sBRcdAng0CYApPP3SI2uw=;
 b=N9cgLtSidGOe+k/qeSol4hR78f7dmCz+xHEM0SSKJTq333h5PaaJLSVGRmoBEmqfqj5I5kRTKqHxm2wyM6WPyj/xznVTwWq4VnK8s9nyAHO/iWG/+EYrlzaEU+5ML/wrYlch8WColK6WpUD4wFBGAcmvjP6qYbzeBLad9v98h664EPY1NP6/wXc+w82Rqg3FzAAOU6D+LKBoWHkDkxq9YgrVPzG54pSxJ9BrvZeI+kTDeY4eqNK8g1SwY/Fz0gZx2miVQAqIwBUItTlQ2i7qikuvRtkf8zgOgwHzkEOH5RN00vDziWKACJ7zXAJtsyueI0yY67MV+OrfOgbUh1ZDyA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8852.namprd02.prod.outlook.com (2603:10b6:806:1f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:49:10 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:49:09 +0000
Message-ID: <65532fa7-4c12-4fd7-a7f1-47ac0210927e@nutanix.com>
Date: Fri, 13 Feb 2026 09:49:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/43] audio/wav: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-4-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dec9722-7158-4f61-1d7d-08de6ae522d7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TStFeE1XYzBGamsrOTloUk5vdWNwK0VWenNHazBYNDNrbmhlWmNxOEVmQktM?=
 =?utf-8?B?NnFwY1VxVVQ1dXhGaTBMY2x4VkIxeEhnY3FEeDN5UlFEcWV2TW12REtuTlBS?=
 =?utf-8?B?V2ozdmVDcnFvVTZ4RHZ2Uy9pSHY3WVNVVm1QcWNhR2NpWUpiSnFFV0xmaHFT?=
 =?utf-8?B?ZXVPTzVJZXFoblg0Vy9zaEd0ZVdlc2EzVGdkemFGUXY3SDdqUUFTQURCMVcx?=
 =?utf-8?B?N1EwaVlaWDJlbmliS3h1ZjFldElkNXcreFMwT01icEdzdGU2d2xucnBaajlm?=
 =?utf-8?B?dVRJemhOQkY5Rm15RkVIcVdjY3lOdE0vc0htUm1WODYzY3RZKzhOdVFjbnhk?=
 =?utf-8?B?bzJmYmg3TElWbU1ZZTVhUjJITnh2V0ZGQktrZ0NQcCtxejVNUWFpaGh1QW5z?=
 =?utf-8?B?MEpVN21mdjRzL29Fb1NZQnhvQStvWWhuWGdnaDFZMVNEYlk5S3ArYTJtQlNv?=
 =?utf-8?B?YmxjK2dPTDM2c2lHaGErOXplSkluQzBmM090NEpwZFA0bkdOZ2Q1aGx4aHJa?=
 =?utf-8?B?VXVKVmpzTnFabDhOQTdSWS9JQkhINEl3anJ5WFg2VmZ1bVN2WFoyM3ErTzlQ?=
 =?utf-8?B?c1FmNmZCZlcwbXVjVXJkN3JiS1N6TGI0SVcrTVFjVExsRjFiUXN2dW53QU82?=
 =?utf-8?B?RkxPNWpnZUEyM0s1enRKN3hFMXQrdU1EQVFoM0lsVFFmYVhlN3NzTitaT3VX?=
 =?utf-8?B?TmNhOWNoeWFza1JyNUZUYm1OUVV2ZmtEY0xkSFgxeitMY3FBTWc1UVVrK1dI?=
 =?utf-8?B?TnUwNHZNaG92cW1wR1lreU1qbVphR1VlRC9hc3kzWGFvRFc0a24wM3I1WmNR?=
 =?utf-8?B?UTN5alNzdDd6YW9TeDRzblZTdmZ4SXV1VmFKakdwUmdaUDEyZVdDRTU0Mm5M?=
 =?utf-8?B?dVRQZVBPb21xd2V4aHdMZ1RSdmNGRFJkU3JpMWNqTlM3RkQ1bkxrQ2YwN051?=
 =?utf-8?B?dERGYzhRMndZbmxLL3MzM2lOUE5tMFEyVXpwUER5OTgzVTg5UGlaaFpMdHpn?=
 =?utf-8?B?WHEvUkF0cXFHdzRQUVZ4UkdtSHUxTVVuY1VyMXF3YjBiYWUzRms2MzI0UlZT?=
 =?utf-8?B?ZHNmNXhNdGdDRVB5NjNDcS9va241bFhXVE9vUythYVB4RGxoeTQzL1FsMzBC?=
 =?utf-8?B?eW15L3FGRWhIcXBlSlMrdGR5OEg0RkFXVFJUUXY4SHZFcnlYYndMTnZtdHpn?=
 =?utf-8?B?SXRmYUgzMFM1SHBZYlI0bzlyOVVKRlFFQVdqZlNscVRFNzlXWVpwUkpnQzhq?=
 =?utf-8?B?cVNFcFEzeXhJYkdudjVCVFArTG5xcXd6Z08zVERtNllWbTY1bk5uRjFFQ2x0?=
 =?utf-8?B?dmRFT0JuQUNneFhVNnZPL3hGQ0V4U2RkZXZzNms1VXQ1eEpqWkl0RU4vRTRs?=
 =?utf-8?B?L29Tb1VJVm5uamRYNjlwNjRhVS9LS1pobFpqQ1NGUll2Z3ZTTmM4a2RXc3BR?=
 =?utf-8?B?Sk0vdDJUOTJQVlFzWFdET0hkaE1ETWZZMUJycXgxMUFHS1JwY1N2N05kVVk2?=
 =?utf-8?B?VGFOajd3eWcrdDEyZ25iVzd4V0F6MTV3YWY2MkhMZzhLME9WRWhqUHVNUmdV?=
 =?utf-8?B?bVJtMFhMUmd6TWRwN1pNYzUyNnU2R25xdWx6TTRtajN4c1FXSkdiSWVGM2dz?=
 =?utf-8?B?WXU3NUZXaHNVcWFsczNUTnBSR2U4VmJ4Q1AxbWhmZkJPY1NRNWhIMEpoa2pY?=
 =?utf-8?B?RzNqUW8vWFpIUW8zVjJJcXBQQ045TU5XWm1PbmYyU3RLbFRkRnNrSEJydjNJ?=
 =?utf-8?B?MnpOeU9ScW41RUR2ZnBZRzUxM3J0Zk9nYzlXbVpSOVZlcUVJWTZoWTJRaWVM?=
 =?utf-8?B?eG01MFc0M1R3NTNkUS9QdnRpaElOSCt4OWRjamxRZ3V6VlpjaDZTdDFqdzNR?=
 =?utf-8?B?OVVMODFjR2ZCV050ZitpOEQ2aTZ1SXAveVpQTjZ5QTd3dTBvcURkTkRjV1l4?=
 =?utf-8?B?ek1RWHNuWkJraUR6NnVaSDd5SjFYMVJHMU9ZalRheG1sWE1nUmhQdFRGMXh0?=
 =?utf-8?B?aVpoeUxjRDR5Zmg2NFV5bXhPalFrNUNzUFJzWnVVZ3V0dHFDQlQ5UzZFQmJv?=
 =?utf-8?B?UHBhME9EN242NkxCenQ4ektNcDJtbFd5ODEzZDNYdkE4bVh6aTZtTUhkWUFr?=
 =?utf-8?Q?393I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDlFM3NsYW5INlJzdExoaE1MVGpxVHMvSnFzWTdERVFOTVExVmlHK3A0VWZU?=
 =?utf-8?B?TVNUNVRJRDhaTDl2d2Y2MkRHTDF2ZnJpWVR3T0J6azl4MXE2c3FVaDRSeFU1?=
 =?utf-8?B?Z0VFSGE2NmVETlhhcEs0cm5ZTWpqK3YrOGp5R1llNnk2aDhhUXcwOFpTcHZx?=
 =?utf-8?B?WWJNUGo0YkR1VFpKZkZlRkJyNlFwNktITVhGM3V3UTNDSGFkcGt2V29wOUZZ?=
 =?utf-8?B?Ti96NENIM2x6OWgxdkx4aGxjY3hRM2VpRGtnYTJueDhvVitQbVp0RnYvM1Za?=
 =?utf-8?B?NDRJbGVLZDlkZXRlMGRjZDZjNkZIa2pZS2lLVThGRHBhbHp1S2ZHemE0aXli?=
 =?utf-8?B?cWI2dTljQlhIcTdUWjVNVXZlMG5QbnM3QnBQVzU2K25yZFRVNDNKbEQrZ1ZG?=
 =?utf-8?B?QTFNbG9lWGxON1d0R2tYaldJTC9TWnhwMXhwMlZqU0lCejRGc2FrRXcxeWgy?=
 =?utf-8?B?MWgyM1JLOHpPVUkrRllUTWtHaktGdFdsQkdocmFRTTBFTXEzMy9xVnYxN0JL?=
 =?utf-8?B?blZYd0FkVGI1UlNXMnlqZHZmcHFoMi9IY1BtKzRWTXA0NDExbjdrY0ozMDBz?=
 =?utf-8?B?bEljN21UKzVQSEU2RGtlNExmaElJRFhIZ3I4Mjg1WnRib01uR1NBZWZ6TDNm?=
 =?utf-8?B?ZUdsK0xLQjAraG1pUGE5Y0JwUjkzbWZoQWlIa3d1aHF2M2tGOGRkaDJwdlFa?=
 =?utf-8?B?WVI5ZWtyTXU2dWZzRW5JZGxneDdoOW55U3BqRDZqdUhEMEttWVhWRFkyVTdx?=
 =?utf-8?B?eEVzMk1ldVZycFg4bTdIck0weFBCTnIvUjRlRW1odXVCMzJKTkxXWittQW9G?=
 =?utf-8?B?L1NKZEYrdEZxMkNWNEM3aFM2VDc0ZVFacFFaOGhPcW1Jakt2ZDhMdkRtWHFV?=
 =?utf-8?B?MkY5VEQ5T0pXTjR1MEZFU1ZqTmk4eEt5R0w1eEgwQlk2T0xDNUtCVjhDNi9k?=
 =?utf-8?B?YkcyWVpMNGJhUGVtaTZ2a2xVZ2MrQVVrSWR5SVI3b2U0M1Jpcjd6NTUyK2dz?=
 =?utf-8?B?YlZQeXhBYUV2a0Rsc2FiY2g0T0hSYnQ1T1VWN09kNkhyS05uZk9HakYxSWRK?=
 =?utf-8?B?R1g1SDMrdzZYVW9QRGpnaFdqY3FFTG1sMTJvZ0hnL2UyaGxzKzN2V3JSVnlz?=
 =?utf-8?B?RjYydkRNZFF5R1NzWlMvRjB6cDJqaVYrZTIrWDA4RkNVYm96RkdxZUV2RVIx?=
 =?utf-8?B?ZEU5eFE0aC9KYmxabWY5V0RsTjlNdDltWEV6RE0zWkdxRnZwWVdHelUwUHhC?=
 =?utf-8?B?K0l1SUxtT20vSVVzenZ4TWdFRXd0Y3cxL2JoQUpuMVdRd2pjWm5ERmZZZjlp?=
 =?utf-8?B?d2FsYytmSUJWYVUyVmlCLzVjMm50dk82RWVtZjh2b1ZKUXM3RXE5ZitvU0Q2?=
 =?utf-8?B?Z0J3MmFyeStkcjJYUjBEMFJEY2tacWpXbzF0SUl0V3JWVEttM2EzQlE4a2FF?=
 =?utf-8?B?MVRzSWdJanVyWjZxb1pTUnc5bC9IY0RYYXcvTDBpQllWeTZvMW9XSE5hNUZO?=
 =?utf-8?B?a1JTQXZHVnppQkZuUk42SllCS2Q5Z3o2VzdwbEJBbUZHRnAvbmJ1MUpKRkNJ?=
 =?utf-8?B?bEJCajZIWmlOQkdiOWxoU0lybkNOcnc3elE3UllxMjl0bVRSclcxL0g4b0ho?=
 =?utf-8?B?aWhLMzVTUEkxbTEwdm9jOS9IUlFiUkd6RWdsMEZhREtwNVhadXkwKzU5RG1q?=
 =?utf-8?B?YXVpMWZwZkpDazRaYU9OZmo1Q0ZJaE1jbHNwTHNRQldqOWJMcUt2UU5hMkpW?=
 =?utf-8?B?U1dqbFVxNmMyK0JIYzM1MXZ4NmwwbXBhQngxdEVramFSVnlYR2FEb2F0RTZQ?=
 =?utf-8?B?c3ZJaFl3RWVDSzlqeHhUWlE4TC9iZWRrRkNSQW9CZENwRU5odWVkWjNGUStS?=
 =?utf-8?B?MUZGd2JOZ3hQMFFxNEZDQnlnVHM2eitFZzhZZjF3YTNtM0ttWkpnWUM0WVMr?=
 =?utf-8?B?bVZiemJtVldabDdGNnp5d3h1cFpkZGcwTTNuY2N3ZUFjcEtvNWZ0OGRRbFdS?=
 =?utf-8?B?bFNwQWdKSWx4ZExTbGthUlZjZUVHakZlNVB0cVJoK3dIZVhXTW52c0l1UXQx?=
 =?utf-8?B?VnJXYjRldlh0Q2s3Ty90SmQ3dmlabmdnVTM0aGZoMnc2TXljSHBFRUt4ekZM?=
 =?utf-8?B?Zmo3eEZHZDkyczFHb1BJRlZXa0oybE5QdU52ZFFFQUZGeS9Xaktsc1l4Znpv?=
 =?utf-8?B?cFBjcmN2Wlo2UTR3b2EveWtlRHpkNnk3V2NRNmxIdG8yeWZ0KzJBeHZnS3l1?=
 =?utf-8?B?Wmx5dk9vSll3bnd3OTRjN3ZyQTB0SzNzVjluSndicHlkMUp2NXJRVVl0ZW9F?=
 =?utf-8?B?dmo3SVFRZFhiVVlSU1hQZ3Q3cHROZzVNSGVkU2RwVHF5Y3c4MkZHUm5HZStq?=
 =?utf-8?Q?b+bO2UY35eOTS0TY=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dec9722-7158-4f61-1d7d-08de6ae522d7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 09:49:09.9277 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hC98RSV5yKblnIJOZGkr0MaDPSr3FeTw4U/OVGP5rpk42LmGUGX/KQBnfdBnR1silK0RSv9oKkjYQTUEoSiGo6+TGgnfrny/WyVV77bBJaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8852
X-Authority-Analysis: v=2.4 cv=Q9DfIo2a c=1 sm=1 tr=0 ts=698ef397 cx=c_pps
 a=iE0qjxSwE5SXcvk24aZtBQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=4RvK5GebNRGFAKOTwiMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0h07gGGSs9eymdJphRGVt0taskFYzi4K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NSBTYWx0ZWRfX7ztc6LkvyeCp
 TL3pRattAxW513nbkQtow0HaJEXtl395tyx2mrYya4/Uj6oyB5Xa/u+YF5IfQ0oCIOajhpJs4rU
 QmVv5T4RJ+M8Skpkdq/WOzkVPZjWEGEpc8bpuylhpImvzrT9kLJwn4BUw2/KsHP+P/+xXGgRDa4
 huhAAYBsjrTb/p/f4H9iybcNa+3oNp+q4JbZtq+nGYdeMi+4w946Iex5p96/j0uNJ1NW3Fxr8uR
 KnT+1gkPpHMh+aWQ2m39xsP9EpYqa0bZFITvK1PBUmcUdmWY3iq62X1yXRoI9PJy+Uf39LmKycl
 i7gyXIrSe78ln+EUxeLVdyUmNL45K7DGoNVTH1P0XdwiUbcwfXemBe3JdrCfCwUbD29T2qdjcAz
 oFvve69Bf09sY8lITF/I4Y6DJw4/x71gNKzBAyv6/CyEwsqFqLVCPiRoH4BJBtkrGG8wjwOSJa+
 Wnty4/+IbCdjjJ/3FcQ==
X-Proofpoint-ORIG-GUID: 0h07gGGSs9eymdJphRGVt0taskFYzi4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Remove the legacy driver init/fini callbacks from the WAV audio backend.
> 
> The wav_audio_init() just returned the Audiodev pointer and
> wav_audio_fini() only logged a debug message. Access to the Audiodev
> is now through hw->s->dev instead of the drv_opaque pointer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/wavaudio.c | 15 +--------------
>   1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/audio/wavaudio.c b/audio/wavaudio.c
> index 50b0fb93936..2a7703831f3 100644
> --- a/audio/wavaudio.c
> +++ b/audio/wavaudio.c
> @@ -89,7 +89,7 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
>           0x02, 0x00, 0x44, 0xac, 0x00, 0x00, 0x10, 0xb1, 0x02, 0x00, 0x04,
>           0x00, 0x10, 0x00, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00, 0x00, 0x00
>       };
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>       AudiodevWavOptions *wopts = &dev->u.wav;
>       struct audsettings wav_as = audiodev_to_audsettings(dev->u.wav.out);
>       const char *wav_path = wopts->path ?: "qemu.wav";
> @@ -200,17 +200,6 @@ static void wav_enable_out(HWVoiceOut *hw, bool enable)
>       }
>   }
>   
> -static void *wav_audio_init(Audiodev *dev, Error **errp)
> -{
> -    assert(dev->driver == AUDIODEV_DRIVER_WAV);
> -    return dev;
> -}
> -
> -static void wav_audio_fini (void *opaque)
> -{
> -    ldebug ("wav_fini");
> -}
> -
>   static struct audio_pcm_ops wav_pcm_ops = {
>       .init_out = wav_init_out,
>       .fini_out = wav_fini_out,
> @@ -222,8 +211,6 @@ static struct audio_pcm_ops wav_pcm_ops = {
>   
>   static struct audio_driver wav_audio_driver = {
>       .name           = "wav",
> -    .init           = wav_audio_init,
> -    .fini           = wav_audio_fini,
>       .pcm_ops        = &wav_pcm_ops,
>       .max_voices_out = 1,
>       .max_voices_in  = 0,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


