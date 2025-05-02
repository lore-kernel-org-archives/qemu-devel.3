Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD874C3ABA3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 09:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAmkg-0004cP-PQ; Fri, 02 May 2025 05:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmkf-0004c1-9V
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:32:13 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uAmkb-0006dy-QE
 for qemu-devel@nongnu.org; Fri, 02 May 2025 05:32:12 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5424624a023930;
 Fri, 2 May 2025 02:31:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0peJlC44qOrbO4ccqwfwIDWffQIPWS11TZNCdusNf
 wo=; b=RSXfvhZ1cNaDxidKgPQ/6tJXGL6Jz+jxHDh9FvCAntIR41dUmDMM7aT63
 bzXQGsWfFtNAue6yo7Q3dVSKlEXU9nEaQ0aerpKb9sZLlKoMNHXgeC2X4R4Oi2CP
 VhuFINBqJqjZqKiU4lSqVrcnul0UOnYpvebC+gWR/745ykCsk7YUHx1CzaiKEmp/
 fN2duPQXk5n2X4b9HRx6PIeBp9Or9fUrAgHjFnR+PTNZ8cs1RobpQhbsB/062kyU
 b7PGMh4hiy8os6P7OIO9B6uM/82sLoW3Im+fJuJ2M6drHvDlZndZZ4hGV35Wrcof
 gjroW079qq9jvk/5jRT6uwchOuFFA==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8nf6r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 May 2025 02:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8i8mB8WmIIZfq84MWKhY+t+pDdN6sMfVsjs/4PHC4I+x/abx48X+XgmSGQWh93/2o/8aE2DOcWl5xEHtwYxEgR5s5YfQjWoRgudfTAACfhQlzoiDsCnnhtP7F66m1olFJHPwjMfNFGk3he2P4IC3mwHZPwp+s+zOAbo1wuASaBXB4ML8M2E5EMfvvdCHbS7ryoJ4keKLUAhxS9FHmq0Jxa8gIonz4XnLHGVY1aRKuZBGXT+YjVYbBhMRZIAcW7T0G7wxK0lktFl0UxMF+MSCyLjcOPqmEO71i6Ar1u9B2l1ndZAtm6st/5Mwl2bJ/6wlFJjttRIzee6BaeKKlEJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0peJlC44qOrbO4ccqwfwIDWffQIPWS11TZNCdusNfwo=;
 b=b3ZPQREVTsGvFiXG4ga0LrdbgQK/RoVCltaMyGq8w03BIfIb7ds+YIofGnyQMZiSuUl1s2KvGvjcxbRRJ7YgqxbA+wGElJM1/H9aiHOzjxDdIxS1McNbwmxLRTzlQep1MgfkK+b/olPX1rYycr6GnJy7xwnTlZmAWAmElUCmUmEK4H2EjCpHL2RakKzChazF3tVC4Bv7FNDs8pOpGbhpo0a6oC42My207mUovH6wKddFSaykxcrX6RwskwaPSF35c44EZo1cStB4ucasAtG4Rlg1sNDChk8L1VEnJOUGeBIEg6BSJeh2d7I9LqfwQCJbeSyq6iAS1+Bv7zoDLwTLlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0peJlC44qOrbO4ccqwfwIDWffQIPWS11TZNCdusNfwo=;
 b=gDaQiTVq+lvKt6Ecl0oZ2X4HkydTqBDLi5SbsgFZmtVNQ3mS8tB8zo+O0aa75cEFTJ3BcJWmhxWK7qVhmBqsuB8CPNJfoojjJKwI/rQPlgJ4dAeiLFaHD3yYl7SEve1U1cA/zqxSTvPMHZR3NaSaWTi2PyECBaPx9iQyudJ0hf0W63i4n90o2Bh9bN2614Xf909W0+5fsb/WfKH8ifwRE97tOCrs8YCQe874kWavFptOwLnSPhpFNQKX1UMgG2t4VgOICLQB5UXoYCaBvpWbrMIi4yHtNmlcuJK7qkowCvcAtaXjFCV2mJkmHs3Ec7LDv5O7fpW8YNciUyz2mWE1mg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 CH3PR02MB9939.namprd02.prod.outlook.com (2603:10b6:610:1a1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.24; Fri, 2 May 2025 09:31:47 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8699.012; Fri, 2 May 2025
 09:31:47 +0000
Message-ID: <c72e80c2-264a-4b4c-a782-e02d9d96f608@nutanix.com>
Date: Fri, 2 May 2025 10:31:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] hw/intc/ioapic: Remove
 IOAPICCommonState::version field
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
 <20250501183628.87479-14-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250501183628.87479-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::30) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|CH3PR02MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e35357-92b7-496c-6439-08dd895c289b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnZxNGNMQm9oam9vTUtGMk1ZNWhkSk9vL3VLYVNiMTdsVXAvemFoY0FyM1lB?=
 =?utf-8?B?bExDdWZWZDYzTUdyeTdFZXpIazVkMTZlazY5M0JFZXNEWVd5Rno4WUljVFI1?=
 =?utf-8?B?R0ppZ21La09DN3JFdDFIUkgvQjJUV2pDTGo1WFdFazcrZGJONEVrNmV0dlRh?=
 =?utf-8?B?TUpSelArSXZYb0ZyOWdRVHErQ092NDZWSWVWazhGMEEwc3dEWmRpc2NZeGw4?=
 =?utf-8?B?WU5wbmxnZzF2b1VLRUkvSEhrR2FUWHc4ay9aZTNSU3haTU52QWdNKzE2NlhO?=
 =?utf-8?B?S1BibHdsN2FUZ1FQR25RNnN4dE9GWWJoYk1HYTkwOHQxTERPT1pTZFNaRGJP?=
 =?utf-8?B?NXpEbGx0TDE0MnNiMEVubVE3VmNJMUYxUm5qT0tjYmhUMENkUWg4R04zRU5Z?=
 =?utf-8?B?Q2pKOWYwaGdTRURpbXRPZStFVUZwNVFmVDNpdXpuajJncnVhTWsvQ2VlWTRU?=
 =?utf-8?B?aEhDNmgzeDVrRVJMMDF5L0g2TTVMaUtnQnRVZzBwQ2xYbG9nRW1wek5zSzJU?=
 =?utf-8?B?OThRajFoQzJDcVVxN0xoWHMzVjUrTGgvSEhnYWhrTEVDbVBTRXgra0IrSXJU?=
 =?utf-8?B?Wmo4ODVtNGpzTG5xVzhyUFFvZStJNDJOaVArZ1dWUFRWRHIwemRHSzM4NnU1?=
 =?utf-8?B?RWZ2SEd6eUxGMnNaUW9nem9PemlEbGcrRDVzM0t1ZHY1MnBsc2hld3lRZksr?=
 =?utf-8?B?K2xmV1RDQ0NoeG5NQjIvMGRpSGdqUXlBQjBGek5xK2ZCZlMvSnVxS2I4a1RU?=
 =?utf-8?B?QkdpUjFXa0ZncDdzMWhRZm9lWTg4Ykx6L1FONFNpckNpc0h3WGpxSURWMjBr?=
 =?utf-8?B?OTE1NVh1V3FvRk02aUdXYnNrTndCQnc5RGFvbVZ3UGhqVTFJRFF0OHBHM214?=
 =?utf-8?B?R2RKYjRCbStpUFlLdjlOVjZMMDJXcXB4UjNSa1JOYkl6TkZJNm9xM1c1cDl0?=
 =?utf-8?B?NVp3L3d6aEV6NDh0Z25rYVd6YTA4TTd3a2lYSitKL0Zwbi9wLzdCV0F2a0w0?=
 =?utf-8?B?SHA2VEJBV1grM2tKTlJLK1o5cmFmV2Y5SkI3eVdQcGhLZElUZXlWRWszOVh4?=
 =?utf-8?B?VVVYZVdpZnI2by9RY3Y4ZlFOQUlTbmtzTGZjWFZQNUFPMnhmZHdaekV0K3Ja?=
 =?utf-8?B?R2VkTHdlb1BUUUpGeUc0UWFXZFlJMjBZTE4rRVRUUnQwWVZTYlM3VXhubUsz?=
 =?utf-8?B?aTZBMmdIelkybjVtbDJiQWppZHByK1lkOW1JUVhCcmlkaElvNWtYcUIxdGEw?=
 =?utf-8?B?MUxpL1BsVVZMNmtoZUR2cHdPRVRQTUI4MEFxeE4wR0lra1FLdE9EMTVnYXdr?=
 =?utf-8?B?M1dBcTBtbCtydDJLaWlycVJDSVRiNEJoOUZhcUhrblZLaVhremxNSUhXSXV2?=
 =?utf-8?B?STBOTTR3RUMyVUthQWl2Y0xackhROGdSSGJFc1g0d3l5VzMwNWVRckVVMldJ?=
 =?utf-8?B?eHdKbDdJMXJablowMmt2c3hXRmJSNEFsVmNNQVJ4bk8wVDJ5MWM0NnE0cUEy?=
 =?utf-8?B?M28rZ0M3QnpoMVorczdkNkpLM21vYzVXWlN5M2ZaTzBqUTdTQWwrUWtYR1hD?=
 =?utf-8?B?WFMzUEErUmpjSXpiRjhyK3RkcWRBUHNvam95MlNvYmhpS2hndXB1SnJ6U0xh?=
 =?utf-8?B?RTZ6R1pZa3ZUREdrVElDUDNaM1dpWWs2TEJMSmJPYzZxY2xuS3RkbEFLNFNT?=
 =?utf-8?B?ME0zeVlwVEVicWdBZGxOMVRJN2N6eFVBYWppZHZTRUtkaVNPT21uZXpSRmhZ?=
 =?utf-8?B?UlZhd0syZXE4TzM3eVlXTHJDZFJsZlJzNGZZMEhjT0U4R1hGaEpKcmREaXRH?=
 =?utf-8?B?V1VFSVorcXpqb2tROXFEWmYya0Y3V2ZTejRnODliUkNDMGl0ZFNZRTh2U1pB?=
 =?utf-8?B?MVBiMlVjdCtCbW4zY3UvRXdJaHBDOHZtbHVpdGlnTk1JWWo5WlZrWjNHVWVN?=
 =?utf-8?Q?algFE5jXZao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2J4RGV0dHVXYXRhbXdQMmlUZ25Kek1UQllFTXB1blRzRFJoWkRiWnBYSUhw?=
 =?utf-8?B?V1NRcmQvMEExRk90bEtwWXlzQWhZY3JxUmplRGltVUV4bFRiY2FPdVFvRDU0?=
 =?utf-8?B?VVVxZ0ZaUklYY3BIdCtwYVg3M2xMOHdjMzRqdVdFY3BqNVRwQmhMNWw2LzZQ?=
 =?utf-8?B?N29UQWR6Yk9nZU9raG11ZnB6OVlZWUdNdC9hNDE5U2ZXSE1PeDZCTkNDYjB0?=
 =?utf-8?B?MkpkK211RXhYaUxpTmFBMWtKdldEcFJ2TXh1dFk1RnN3czBRSmZveVpOUXE0?=
 =?utf-8?B?QXVwZWIvYXNNTlQxQ3dQR2ovV0tvYi9qVU15U0tWUXQzTitRRUlwc1FWUEIr?=
 =?utf-8?B?YlJRRG4wNk5TZUNRcnRUTHZYNlVvQlNTS2tPRXNEc1lLcnB2OStieDVuVk9E?=
 =?utf-8?B?RVdCalQ0UFB1TncrMjljYjJEcXgrQ3AwL056ejV2d0c1QU4rMW5FNjFiZmJ4?=
 =?utf-8?B?czNpdEhQRENiZnpuUWRRU0VrQ2NnMHJEK0VRSnpOa2F3V0Y1dkt3cHk4M251?=
 =?utf-8?B?TFRZYjNLcTBtNlhJL2haWW96VW1NZllkNlo3cnc2WVBHY2pHRCtjazZGYVNp?=
 =?utf-8?B?Z3ZxUUhjOXlhckw3TVBzNWVUajhFeEQzR2VqMVJaanVIdWFoVHhxVmRVZVpz?=
 =?utf-8?B?Mi9DbmZzMEZUMmRTNTJXczE4V3hoTnNobXVaTXp5b2kvY01SMkg1N2Z2bHpO?=
 =?utf-8?B?emZpRDNEejNZTTJyZXVjOGdnRTVTYWdsWWtqaWx0WVJvdzV2Q1p3Q1hzWm5P?=
 =?utf-8?B?YmNtTmkzcFpWbTdhWCtlWDJKVVlzV3V5QWJUVTRTaWdYQWFaMmdZN2dBYXVW?=
 =?utf-8?B?U2lDQnc2QnVVOUU1RXRBR2dGMGdvb3lNd3hjbFJLb3c1YW9GVlJZcWRhUTVa?=
 =?utf-8?B?WWFWamNXRWRhVEk1emJqQXR6alB5YlRmakQ2NldaWnlVeUJUSzFENXlQUUR5?=
 =?utf-8?B?TDQwUTYxclJoTXdyU204SFRYc25UYW5aSHBwb3lPL2NpUFZESkZ0WkZIUXVm?=
 =?utf-8?B?TCt1dlU2cFh0NlVlcDVqaEtCSFVqakRQWWg4Q3F5a3Vzc1NPRHluQ1FDcy9a?=
 =?utf-8?B?RnRVSXNHYjJrM0VYQ05CbHVPZEExNDVsVm9RdzRmempUa1M5K0pBTzBpdEI3?=
 =?utf-8?B?d3YxYTAwemFjM2dKc1JvOEJENGJWOGFHN3lFQ2tFNU5lMUhDOWYxbjV6NE1W?=
 =?utf-8?B?VXpNMzhGWUppeEVOS0dyVSt5K2JNbkJudmpJK3JjMGg2UkoxSHN5Qlh3Vk55?=
 =?utf-8?B?MXBRWkxmOStQM1BkUUhPN0JtR1FaQmN5T2dBT2pnVHVlTnNKdXlyelFEbkE3?=
 =?utf-8?B?b0QyTjdSR0hMM0IwdXVLUDQ4SzhOYXBFYzUwRGMvSWU4dDZyTmIwV0tqUEFR?=
 =?utf-8?B?aGRUTnIrb212anZJdkdzajcrSVpibzNDcjdBMG1VeVF1UllEWXlCQWlETWR1?=
 =?utf-8?B?NFhFR2hDREt3NVFxNVlUcEJ5N0VLQjlTVmhWa0drVU91SE52TUtwZC9vUHNJ?=
 =?utf-8?B?T3E4SDlYVHZCOUNmajNreTE1OXovK2JuRjlHc3JTUnBLVVJEdTRLdnNFNVly?=
 =?utf-8?B?dWgzaHVXbU9IemEwbFdWYWhaZlJuT2krd3ZFaVNCRTJwbkE4T1hkSDBoRVZz?=
 =?utf-8?B?Nk5STWIzbWJTWmZGSHl5dzF5SlM1UlNjdFVEMzM0Y3NiaDFXeWpyWUZpb3h3?=
 =?utf-8?B?S011Z0grZE02ODdoSTE3dWo0ZUlseGRPbzdyUjJJWnZrWWl3NnRoQ3BWaWhj?=
 =?utf-8?B?MWNiVFdkc0RrWmJOSmlSY1M0REFYNkFZaDBjNE9hbVVlYm9HSVNPd291emF6?=
 =?utf-8?B?dUJEc0FVTFlvRFdUV2VnMnNKOVFsbExVVDFPRzViMG9hdUoxT3NSejBGa0M2?=
 =?utf-8?B?VFA1L2tRZ1crbCtYMVZmV01aV0Q1dHJnRDZHZ2g5cGFLUlN3c2IyMVNIVDFq?=
 =?utf-8?B?QVozNFNuQzk4Rk5NSVN2L3ZqcXFZeUh6ejBxeWpYQzU2TWxPdmVCMDZuL243?=
 =?utf-8?B?U2VsN0ViU0VhYVpXQjlvSkNJbU1qODA5LzNjNlllU0xSYWpIZTBpMUpzNkdt?=
 =?utf-8?B?UXdPRDJsMWp1L2FsMjdWeDFOazJqaWFpTzhITXo0RkVIOXlUaFZRc0F2WE41?=
 =?utf-8?B?TnNSRTNDUmowRmJJekVtZlB6WXNjK09OOHBFbERhOXk5SDJMWEc1ZDBsR0pp?=
 =?utf-8?B?eEpibFl3ZURReG1ZQjAzSS9VSnRNQ2MyVmlvVGQxdnJOd3ZCcUlqRFdKVjJY?=
 =?utf-8?B?bTB0TVVWaU4zK0wzRFlCQjVHak1BPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e35357-92b7-496c-6439-08dd895c289b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 09:31:46.9812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+2wQEWaI/iOhL6dYJoxudchL55CQ15Zrpwaln9k5MrAs0kuplgh7hcUAbCPG8L5UZesNgEFIVjp8ytyu4Pks6j04kTsxacoRxK/hJvVhb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9939
X-Proofpoint-GUID: 3MDzLdDYlOIdrLGeb8RiONtvcFzPFzbP
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=68149105 cx=c_pps
 a=WCFCujto17ieNoiWBJjljg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=KXqLCKoHUfAKD_JEayMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA3MyBTYWx0ZWRfX1CzAE+k8uRat
 WH83ZVxnOPrjDVe58L9ZIU5Gk1IfhSI12mZa3z2ZirbsRUkPuKfgF2RGC/MsORC1nHVOxZezx5h
 X4sciQhxsXrCn8VRSGSxZ279YbPAZYvGSo1AYzJikxY+AeYZw5eF2Pm6maDi8eLC/AKk7Fe7lM/
 n7nU2wzIGsJmSO/2YFotWmS/z7mRHloUGqvbA/OOeCSF9Ccd5QaQBfYaSLMcjjuu+6P7Jd/MQTZ
 XXuGsO8cGvu6JcpAA+5ZmbdFtuLotv1b7fh61/UCW1/9ged4Re9ydMjWbWtRgdfB2voeCPM7XZ2
 eQWCjt5IVUO8153zo4F67qGyVIyEenNTS1ZF03102knznPZes8LiJg2ahLXL0GBpIaqUotmhnh7
 wpKw8PKOVYzzqh4rA/xmnAslkjyaZ3Ui2V9KjrCRE81ThY7hcHMzHf49q8WtVkFw2Tenu41b
X-Proofpoint-ORIG-GUID: 3MDzLdDYlOIdrLGeb8RiONtvcFzPFzbP
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

> The IOAPICCommonState::version integer was only set
> in the hw_compat_2_7[] array, via the 'version=0x11'
> property. We removed all machines using that array,
> lets remove that property, simplify by only using the
> default version (defined as IOAPIC_VER_DEF).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/intc/ioapic_internal.h |  3 +--
>   hw/intc/ioapic.c          | 18 ++----------------
>   hw/intc/ioapic_common.c   |  2 +-
>   3 files changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/intc/ioapic_internal.h b/hw/intc/ioapic_internal.h
> index 51205767f44..330ce195222 100644
> --- a/hw/intc/ioapic_internal.h
> +++ b/hw/intc/ioapic_internal.h
> @@ -82,7 +82,7 @@
>   #define IOAPIC_ID_MASK                  0xf
>   
>   #define IOAPIC_VER_ENTRIES_SHIFT        16
> -
> +#define IOAPIC_VER_DEF                  0x20
>   
>   #define TYPE_IOAPIC_COMMON "ioapic-common"
>   OBJECT_DECLARE_TYPE(IOAPICCommonState, IOAPICCommonClass, IOAPIC_COMMON)
> @@ -104,7 +104,6 @@ struct IOAPICCommonState {
>       uint32_t irr;
>       uint64_t ioredtbl[IOAPIC_NUM_PINS];
>       Notifier machine_done;
> -    uint8_t version;
>       uint64_t irq_count[IOAPIC_NUM_PINS];
>       int irq_level[IOAPIC_NUM_PINS];
>       int irq_eoi[IOAPIC_NUM_PINS];
> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> index 133bef852d1..5cc97767d9d 100644
> --- a/hw/intc/ioapic.c
> +++ b/hw/intc/ioapic.c
> @@ -315,7 +315,7 @@ ioapic_mem_read(void *opaque, hwaddr addr, unsigned int size)
>               val = s->id << IOAPIC_ID_SHIFT;
>               break;
>           case IOAPIC_REG_VER:
> -            val = s->version |
> +            val = IOAPIC_VER_DEF |
>                   ((IOAPIC_NUM_PINS - 1) << IOAPIC_VER_ENTRIES_SHIFT);
>               break;
>           default:
> @@ -411,8 +411,7 @@ ioapic_mem_write(void *opaque, hwaddr addr, uint64_t val,
>           }
>           break;
>       case IOAPIC_EOI:
> -        /* Explicit EOI is only supported for IOAPIC version 0x20 */
> -        if (size != 4 || s->version != 0x20) {
> +        if (size != 4) {
>               break;
>           }
>           ioapic_eoi_broadcast(val);
> @@ -444,18 +443,10 @@ static void ioapic_machine_done_notify(Notifier *notifier, void *data)
>   #endif
>   }
>   
> -#define IOAPIC_VER_DEF 0x20
> -
>   static void ioapic_realize(DeviceState *dev, Error **errp)
>   {
>       IOAPICCommonState *s = IOAPIC_COMMON(dev);
>   
> -    if (s->version != 0x11 && s->version != 0x20) {
> -        error_setg(errp, "IOAPIC only supports version 0x11 or 0x20 "
> -                   "(default: 0x%x).", IOAPIC_VER_DEF);
> -        return;
> -    }
> -
>       memory_region_init_io(&s->io_memory, OBJECT(s), &ioapic_io_ops, s,
>                             "ioapic", 0x1000);
>   
> @@ -476,10 +467,6 @@ static void ioapic_unrealize(DeviceState *dev)
>       timer_free(s->delayed_ioapic_service_timer);
>   }
>   
> -static const Property ioapic_properties[] = {
> -    DEFINE_PROP_UINT8("version", IOAPICCommonState, version, IOAPIC_VER_DEF),
> -};
> -
>   static void ioapic_class_init(ObjectClass *klass, const void *data)
>   {
>       IOAPICCommonClass *k = IOAPIC_COMMON_CLASS(klass);
> @@ -493,7 +480,6 @@ static void ioapic_class_init(ObjectClass *klass, const void *data)
>        */
>       k->post_load = ioapic_update_kvm_routes;
>       device_class_set_legacy_reset(dc, ioapic_reset_common);
> -    device_class_set_props(dc, ioapic_properties);
>   }
>   
>   static const TypeInfo ioapic_info = {
> diff --git a/hw/intc/ioapic_common.c b/hw/intc/ioapic_common.c
> index fce3486e519..8b3e2ba9384 100644
> --- a/hw/intc/ioapic_common.c
> +++ b/hw/intc/ioapic_common.c
> @@ -83,7 +83,7 @@ static void ioapic_print_redtbl(GString *buf, IOAPICCommonState *s)
>       int i;
>   
>       g_string_append_printf(buf, "ioapic0: ver=0x%x id=0x%02x sel=0x%02x",
> -                           s->version, s->id, s->ioregsel);
> +                           IOAPIC_VER_DEF, s->id, s->ioregsel);
>       if (s->ioregsel) {
>           g_string_append_printf(buf, " (redir[%u])\n",
>                                  (s->ioregsel - IOAPIC_REG_REDTBL_BASE) >> 1);

Mildly curious that other than the reported version the version field 
doesn't appear to control anything else - was the original bug that QEMU 
implemented a 0x20 IOAPIC but incorrectly reported it as a 0x11 IOAPIC?

Anyhow the diff itself looks good so:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


