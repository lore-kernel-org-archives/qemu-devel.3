Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D364C369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tcE-0004KG-Uv; Thu, 24 Apr 2025 06:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tc2-0004H2-Tf
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:15:24 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tc1-0005a3-6y
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:15:22 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O5ck0n023647;
 Thu, 24 Apr 2025 03:15:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PBplhyTywbsUdQJYQQvEafUMjq2xUAW2spUka2ncG
 dw=; b=OfzxZc8TeDod7MRhXMbQNsN1BjfvalbgZ42RgilGrnppDU68aYidjDfy+
 mGqxoVd3mIYON5I0U6/27J2Z7qKx3yT35LmJadyjiK/A4BwKDdBpjStkAteDJpEs
 a6ETYeyvR5QHcWn/uqQimEykpKmRu7jOz9xpLoWhbZ5Ck2LfX1yN3Nyd7sroWMdK
 yhXdkrJQb2Nz/Sbo9Y/pBarTGWDUnH+Zjh3BNETMNU8z5Bfq3FGIfRNpKchY93mr
 fQ2janrXC9K8Ue94vtgoX0oZstZSOiu9PyX4L+lUrU0lefc1HrvHveo5nLgBP1bI
 JTG3lZR8NdwlDx9ckMc7R5+xOT5VA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazlp17013062.outbound.protection.outlook.com
 [40.93.20.62])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhtva8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJD6+Rr1AmCkCiWIkh8ljZrVey6rQ2HVF4rwMyPB5m1DQ/JMPIpEhxcGsJeytBapPmyanjg1iDhDXBL7omzdQIKzTGk1XCutBEj/2TGN+J5K96ssAShMh+wByqHpZKVSEF8EANEMddVJkyD7xu2Dy863Y+MC21XjjJ7YYn0vTF+iPgtzLYhY0rqTAno5ILPtpoHCVeHEADCYt44B/ZvNC7kRNc4bm/w3TiBFDRMF+U0ml2ZmVKixy2k3KgTCNRTAipJKk7yMQepiKloJ9AeoZq1h8uNkYTIodSmFX8Ls/nTbowtGykqxO379GIBR3RHuoSVbZNqtu4u3tj5RwPeOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBplhyTywbsUdQJYQQvEafUMjq2xUAW2spUka2ncGdw=;
 b=EIcn2KGw3oZl5HQT+xEsQnelVvtqTyMp/pnMXnQtYsHUhNAna0B5EM++maGYz5ScXU/IhHd/EfKCbvzu9Q4c/JVWvWAHE4jOV05Lgfo5eG0G+TSNEbdg69uQXH/aljsj0joU2jm3qNcIYknVFpyJkiCXTn5SAlX/I/VmS4Cu2AS8FyP7fsXub96oLsvuUT5ksvquAiiJnxcjfHyw9l6hLBJZ8UVOq6OY7RB6pyjBZA8hTL/Gn3hswD84hAaDcOxXCzUk5wLH6eNnNKsL3j4LVf1M5Mt5ystGaSMkPM9VVTHI+q5MaFgOeqMGK20qw8Ud0LvJE2CPVQ43SPO8Z/dntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBplhyTywbsUdQJYQQvEafUMjq2xUAW2spUka2ncGdw=;
 b=WrJ9712WvCFwetECI6OqRC2QKyyLzRUDEM+JmTsk+GFqC2V96bCQjIIRplOgXyUQa3VndBmF/LLWaEJt3/oG8OElUTb/vrRP8/TrfFipEvNxtpNRD8nQ3508kd9tdTkVZb7OTQYLXIc/4t1txNkvK4x6kGy2blO/1LhFjktYVY3C+WUFDbig3RmuhzP/zjjACiACyqboFSdV7Si6GlqWz3paIv7krf3+BYFNSQsTQGwr5vrq15bhrjsDFqBcOOIOMde2qAe2EVDUc4N7P+zRPv3uZV5Ho4vx+uqW4k1hG7YSRlwqCK8rfmSgnS97RQ08S/Aw/d3TMjaCScyfBkSoyA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 SA2PR02MB7707.namprd02.prod.outlook.com (2603:10b6:806:136::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.8; Thu, 24 Apr
 2025 10:15:16 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:15:16 +0000
Message-ID: <3bf6cb03-87bb-4294-898f-f9c062b3b225@nutanix.com>
Date: Thu, 24 Apr 2025 11:15:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] target/hexagon: Include missing
 'accel/tcg/getpc.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-9-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::6) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|SA2PR02MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c2fc0fe-3ee2-4c3f-2507-08dd8318e88b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWMvQTlsejF2VnltL0diTGoxdXRBbEVubjlDemJMa01WNTlVK0NVRnhTSHBj?=
 =?utf-8?B?MG1YNXhoenBlV2l2UWNLeXlUSzJkMnpTQy81NGVBc3JDL0ZaVTBGVjduOVVn?=
 =?utf-8?B?amZta1VHTENZdzRreENmUEYyV1ZvZHNJUE8yL08zcC9pcGRMT0pLR3VjeXVr?=
 =?utf-8?B?UDdLdW9XZjRZMXk2VE5NNXpnb2lxMkM0TlJlWHdndU1NTThxY0hId2hSRjdE?=
 =?utf-8?B?NkRSYjJKeTZSd1pjMzAyc0IyK2xHZlIzSFp5cEVkYzMyYnlZcE5BR0lVeHhk?=
 =?utf-8?B?ckZ2QnlzeTIrTTJvWkU2MkhKMElFYnJ3WUpVMGJaOHFuci9BbGR1Z1RBZVJp?=
 =?utf-8?B?K1hwNGtZanVQUnNiV0h4cWxVQWFMM0d3Vmk0WFUremJGbVdUSTJOOUFRTGp2?=
 =?utf-8?B?UExvT1U3RThoNlR6d1owUmxsSUc1Mmc3V0prUGxkWFN4NnQ1N0JWQ2J0bTFS?=
 =?utf-8?B?YTZoTTlQWUlxWXhDN3lnaFZLaTNSRUpDSWNYaWpoaEYvMWRET0dpVTQ1eUVN?=
 =?utf-8?B?ZGJ0TWZMV29GdEo5UGJuZ053MUZCMEZOOU1FVm5XQ0pWdmpzUzFpUlhuSEFp?=
 =?utf-8?B?R2ZRb3c3OHNqdDAxZFJlR0s3dHJKbFd5QjdOamdJdkVCbmlCZVAyb1dPMC9s?=
 =?utf-8?B?R2k3Y1hpallJU3ZnNVBOWWdyb1dFSE51SHFMcVp1Yk11Qk9LMVo3bUh3OXZq?=
 =?utf-8?B?VFRkUElLdi9TTU9HMFRkQStRTVNsd1BzL2NCNWZzU3BzWW9VY1BvY0ZYclA2?=
 =?utf-8?B?bjl1N3hyNnpYaWl1Wk1teC9Qc2picVBwNWVlZnRVNGZSRjhzZmVtWlFLTTM2?=
 =?utf-8?B?SnYzWUh6WXVWNVMyZWwzWlAyK2piUWE1a2RwZjlzSDBBRCtUYSt5SnZ2aXdJ?=
 =?utf-8?B?Ny9UK0ZRRmd1eWZNZU80ZTNsZkN4TzE4bXg4KzNuT1hoTkcxZjZNV1lpa01K?=
 =?utf-8?B?QXhZeGoyWWUyT1ozYmpVOGtBU1lpN2lnTUpEd0hVSVo2UW4zUGFGQUlWVG1I?=
 =?utf-8?B?azhWMHFyQmlRbFlZRDM4V3o4MWlOeHp4QUFtd2xyNFgxVlVzN3FubTU4V2lK?=
 =?utf-8?B?UEtDNDE4dnZ4amFsTHY5M2VHdk1tRkxLTVdJbWxQZlFaK20wN1g5bGpVSEcw?=
 =?utf-8?B?ai9RSTk1Qy8rWm5ab2lYY3B0Rnd3YjdMYjFkeUZIajJUMnphTmROb0N3eTVr?=
 =?utf-8?B?anZNc1cyd2duQXVxcEJUZFc5eFNBVjJDRGtTTUpacFVoR3UrdGFwaVBvUEVN?=
 =?utf-8?B?NUhnUG5GSGZ3ZHl3U1FDN1VjR3BMTWUxK0ZwOC9aY0wwSW1Oa3hYRDJ3OTli?=
 =?utf-8?B?dzFBK0U0YTdnTVFkeEZUb0E2ZTVWRDVUYmVZWDExOWhjRUdFNmFaQkNMdU5k?=
 =?utf-8?B?bjA2elVOcmMyc1o0cXBFaDdRYmRkVU1LRlRXY2dVMFE0NnZkVWIxeFV0dzV5?=
 =?utf-8?B?bWdMVDNCZ09sOHdwQktscExmamR6SnZROWZxRnU3ZFd1QTNxVjZwYXFMRThp?=
 =?utf-8?B?K3JnSmdNSTlZcnU0WEpVWjE1T2czZE1XNGsvSmFYUFBtWWQrMFNLaHozMGdx?=
 =?utf-8?B?OFIxV29WelJ2djcwaXFRQ1RIS0RLWnM2T1FhUEl1RXJxaGdQeXd4Y2RSY0hN?=
 =?utf-8?B?MHg5UjBXT3d6OVh6WkMvSUVKS2htdHJKUTBSMEp3VG0wazh1WTBBSExNU1hQ?=
 =?utf-8?B?YUFJRDZKZkVLVnYyQ3oxR3JINE1KZVQ1cU9VR25wdEQxR3hSbjVFcjFlT0Z6?=
 =?utf-8?B?aVUyMnc1SWpSSWhEVG82TGZESXc2Nks5cENJLzRVQXEwTS9HV1NCWGtLbDhs?=
 =?utf-8?B?ODBmeTYvZDhNR3Q4RkVneURwVmlPcmNuTEE3MG91VlB5V2JiRmwrL2VNZXJ2?=
 =?utf-8?B?azZ4OVpuM1VvVWhvNlJkZlZ3ellQUlJmVlNwaG5oU0dZV1ZuZE94Q2twZjNN?=
 =?utf-8?Q?XpbqKPat31U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRrbmU5aUx5VHJlYlBIVThkZm41L2RXU3FwTyt0aHZJNUxlOHpFRlorTVJH?=
 =?utf-8?B?SE9kWit3RXVoWHBoQjlFcGtwOTR1QlJXYlhTaDNtU2x3ZUZTYUNDMHoyN211?=
 =?utf-8?B?OFdPMFNSU21BUEtsRnRHcW9rQnNET0xvTzVGVWRldDR0TktXMmVXQXVSdWl6?=
 =?utf-8?B?Y0swYnFoN3QvblZheXBCR2RQVTkvb3FoamRwZVZFZlkvYm1ET09mUnI0OVdX?=
 =?utf-8?B?d3NSenZUd21DWGNidlNjbXI5NDFiTG1HeDlTbmRSaWdBVWxiR2lvWEw2bXlt?=
 =?utf-8?B?dVRLek5wR2ltRVliSVRQRi9Va0tyWi85MXNlbG8zVS9IZUpPYVk1djhQQk1M?=
 =?utf-8?B?L3R4QjREZ0w5UmN5REJBaFUrSHNsb252ZTVJYTFqQ1puQURJM0JRQjBPb1dy?=
 =?utf-8?B?ZnUvcGt5akw5WU1qZGU4OXYrYUtxN2Z2ZHFldUpWQ0o0TjY3ZkVMVFpHd2Fx?=
 =?utf-8?B?Y1dUUTV1SlloYndoem55L3poeDhOQnhQWFhYNUJmVWNtU3JzSDBYeko2ZkNu?=
 =?utf-8?B?VDB2SzBCb1dsUUFnektXV3haa3pxenlveGMxL1NzRlFxYnNvbWM1YmxNdzEv?=
 =?utf-8?B?MmVpZTN3T3YwYjRGQVZQR0NvUGdyd05MUTlpU3owWEtQY01OQmFhQlM3VWo4?=
 =?utf-8?B?bS82RlY0VWcvWjROQVNsRnZvSTUvTXBuT0pmWmtWbXdnZW9TaDRaL0VRMjVS?=
 =?utf-8?B?WUVOVnFkaDlacDl3UkRYRXYrQW9ldjROekw4bVRTQTFKdjRjN3E0cERYbFRC?=
 =?utf-8?B?TnowRzhJQ0thbGVDSFlXWlFnNmVVTG9KcndZR0R4Q3NxRUluelJNa0RyTnhT?=
 =?utf-8?B?Vk9iZGV4aG9iTldIeTBQQkV0aEp2SEN6ejFPTkM3NzBPcWNTYjBqVjBsZ0pw?=
 =?utf-8?B?K2tPR1E1U3I4TFNMZlBQMmxNS0diMlh6czhjSWdJSUx1c05pd05leTNEZHNX?=
 =?utf-8?B?NHlDSTFEQjJQQTA2K1hGVDdQTXo3RjA3WE16dEVxYk1hNk1hU01nRUhybmE5?=
 =?utf-8?B?QmkzQ0l1UGZWNWJVQ2gyV1grSjdlZnhGMlViSTdDbGgvdzFoZnpQUUduaFJP?=
 =?utf-8?B?MTYxbUhOMEpMTU9QVE44MG9WaXZkS0w1ME1KclAzcXBXZlVTVVpxdWxhWnlT?=
 =?utf-8?B?Y3ZLcjc3Q3VCWFNXVFdqM2hydk9NcVdDMGRQZnFpbDZvbTZNU0FOb0t5azR2?=
 =?utf-8?B?Vm1RUnN1dWFUaGlFTzZkdDVpNG1EbUVZOWdNN2RkVTRueDVVOFl4cFg0VFds?=
 =?utf-8?B?K3BTdFBkN2pFMHRwa0ZpdHI2MmhHc0JMMStzK1cwUFVZV01yS015cjZPQ2N4?=
 =?utf-8?B?bGFxNEdoWlFpV2JiWnNORHMxZ0svR2FPSlg4M3NQQzEvZ3lWeEhTZ1g2Qmdy?=
 =?utf-8?B?Qk44UE43WE0xMVlyRERMOEszWDJhbE9kdCtFd2oyRHVkbUxhcUZYUGVzSXA0?=
 =?utf-8?B?TDJFSjVnelkzeXovM3MwbTJCYWg5RUlVUWp3SUJXV2FGaTZJeXI3QVNKR2pa?=
 =?utf-8?B?TVJ6ZHpGSEFneFNQREFKOHIyOFZ0NlZ2RE9OeTZOeXJBUmh2UE5OSFJLZlVB?=
 =?utf-8?B?N01MdURsblgrd2VLemJyQXhhanRPTG5zWUhQc21VYWNadnk1ZldMYXRjM0Q0?=
 =?utf-8?B?OFF1UXZSZzA1NGo2YkRRUW1CaS9XTjdBR2JqbGw0R2hCQk1kdVVjZ3VQSGJt?=
 =?utf-8?B?TWJUQmRBMFRqYlN4VlA4ZjdnRHFZWUk4MWFadGxsWmZvNkxPS09NT1dpdkpl?=
 =?utf-8?B?TFVzRVJkSC9zQk92VU8ybU52ME1sTnlhL1RuZCtySng3bm1NUXpaQkVNMWxu?=
 =?utf-8?B?RFlROUNXa2lWc2xNR29sV1p0M2tNS3JrdG9GcGRsREM1Q0tTMm5Gc1pqTmha?=
 =?utf-8?B?VzBoOWpsbFIvQkU0S28wVFcySHdCbmo0cndtc1hBOWN2N3BJbU9JNFppMEJh?=
 =?utf-8?B?eUVMWTNjTVFnRkk3TGE5amtOUXNxbTZrUk1yTVBIYXdJSlV0WGc0MlYzSmpY?=
 =?utf-8?B?aHR1QTZYOWcvZmpOMnk1YU9YeEUwMm9lQWpBRDJQNDJtTHI4Qm9jTVhUc012?=
 =?utf-8?B?eGhPT2Zya2puRFVWQW5ORUtTZ1hjZWYyRkI4L09oc2hmUXdWQVZWN01VMEgz?=
 =?utf-8?B?aHRLaWphNy80S2JJUHNUWWx5WFpYaDlxRUVYdGdjakRPS2F1TWJaamRCTmVh?=
 =?utf-8?B?UExUa0tpN2RDMkFkTzUwbW9sRzBLUS8xYlpqbkczb1UvYm1ERVFMY2xrUUhN?=
 =?utf-8?B?YUZZZmVUd01WUXN5Y25hb2lkOTlBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c2fc0fe-3ee2-4c3f-2507-08dd8318e88b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:15:16.2462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94is+Det/m/EHP12Vq3FqZ9+t4plXlrLzxFz6BiS7bLZ8bdrdBFF5CQQGnNkc297halUk+5Oku4P9lYOKxaNveVr+ctcilluZfs9AOOlb4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7707
X-Proofpoint-ORIG-GUID: 8NKoyhba0voHn4yRjbfAMPl2xS0RNcq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2OCBTYWx0ZWRfXxw9TqgccycAm
 JXWCG0z2MQFdKsMsmRZhG1V94L2mdHFmcvQnqe5eyMOOO+qnoxH6mM1IybmpxU45YxgUjVO1Jev
 2/LscdT99YJDm6lNqnh3pCJxUzMqfmllBPXtw3VAOEWtiDnYI62zy/q/Ncy+p/bYaEpLMIEKyT/
 4j1yRSP8eqIhbgpRyM9SAStlh/vdLHI9h8HL06avKCBC3mfkl7JlxrZRjY1uO6C0u+xMPF8oCQY
 OykwNlAQVg00F8LRkRgbl2A8ox79TvclRHYZ5cWy1Gszp6aqYC8IhvmO6xK8X/8eriMwGIodyPS
 HHoWRatlmUBZG50dZL0O3XUHwSwjp6kUHTFXrrx9KcAO889ybKPZkFYa85UDFhQzERY4qyVxbSM
 R2BQ5xd7HN1BQEjE9ORdHUBPBJbXvAZHJxJwdCr7Dp0T5jwXiHic42lzA8e8fxWQ70qPiwEL
X-Authority-Analysis: v=2.4 cv=KLlaDEFo c=1 sm=1 tr=0 ts=680a0f37 cx=c_pps
 a=/rOuTbX+ZjzKyBIGvUmkrA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=Q7P2iFuO1-mnTp0IG7wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 8NKoyhba0voHn4yRjbfAMPl2xS0RNcq5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 24/04/2025 10:46, Philippe Mathieu-Daudé wrote:

> Since the macros.h headers call GETPC(), they need to
> include "accel/tcg/getpc.h", which defines it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/hexagon/macros.h       | 1 +
>   target/hexagon/mmvec/macros.h | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index ee3d4c88e7b..6f82277a415 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -21,6 +21,7 @@
>   #include "cpu.h"
>   #include "hex_regs.h"
>   #include "reg_fields.h"
> +#include "accel/tcg/getpc.h"
>   
>   #define GET_FIELD(FIELD, REGIN) \
>       fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index bcd4a1e8973..c1a88392c05 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -21,6 +21,7 @@
>   #include "qemu/host-utils.h"
>   #include "arch.h"
>   #include "mmvec/system_ext_mmvec.h"
> +#include "accel/tcg/getpc.h"
>   
>   #ifndef QEMU_GENERATE
>   #define VdV      (*(MMVector *restrict)(VdV_void))

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


