Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F331BC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tjv-0007r4-F2; Thu, 24 Apr 2025 06:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tjm-0007nn-8R
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:23:22 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7tjf-0006Rw-I9
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 06:23:21 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O8uSW5017255;
 Thu, 24 Apr 2025 03:23:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Mh6tGoplck9OKQHEKLO8i6hH8kOIOiGcM1K86mSEp
 6w=; b=h32X6I/Ca/28V4at/d2yENjcfQgch5qFTFawWwVsmwX9iDxy2N2v04LlD
 T9metXZr+nVrxsHzBnyO+mQMeYesrqDBM6R09IjaWianRt4IK++nZF5hErPPVnfE
 Y60KbFpve2l9xkrpNurz73cbZY7lMKpa+nyvAnGVbfWzAQ3CN21cUpWMA4EArRaU
 dPKGDgxHZNqIOM4qIA0al00K2c73HrgwmXAN8pUwSVgDgTWkH8GuGMYcjN9lzrET
 M0tNww7a89pVrYV+aht5XFhYnQb81xr7EiwRs1prH1NUtxCDuedUn8MvGxHsqVxq
 LQiE46Ka+Ui8TjvoeCv6JQNEfAmPw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 466jj1v5ku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 03:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0xytSf3XRlCiPqfBlymSNo8lgF7j0vw7nhZvF+OE48h0bj/NLjNhiR5nzqnr4kUKOAF56BcIS7LPrYxygDEHXud5B7o+s4XH1HtWayd04k0wxxvHwQoSR7SCg2AxG/rewGj5CRltkNKZ5CnRQPbjMCQOxEK6/BpqsMniiwPnflKSDxKKGCvgjoGmbWuVO9IKNl3g2dIoDalU3JynEL8aHctGIu0bDpW+EHoSI3R60F+YPJVF7TqVsXhEh3Qb/1SEZJnIg1UOAvy+ux46BIiZMVT7Zjfjb351IimJSOXJdqZH32HZj07v6tlAgjprFYq0RcD3P3jXd3StBjc0kpiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh6tGoplck9OKQHEKLO8i6hH8kOIOiGcM1K86mSEp6w=;
 b=jxvvn6ctQj2xVeMLQNa7/ijFi1bmDd7qCKnKevaNm4Nv4XQSGDVYgQTTMU0iE5OVOhgtdhKTgevs5IQzs2n4VGtvNf9G3OTBw4QNp95nM8h3CahvOm+4gYb25dKtR5zWXjcSVfWPsKkw83p0tC9HlefEuaToH1AGOa1FdNhZeIhtjlzBeXN1jrSLGEyheH4u3Fti5GzIOnFQYWwTzvxeRKDVfkufoNEQkbi/15QBXrZog7/8Noxk0wr3aZtq7kXL3OnQCljKdyY9xYSSq+6N3/knVpB0X8wRj6o0SHK5ANDNLKPPkIYunCTxVaCH6zmmIyUBRubNHK4LmyToK/Gvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh6tGoplck9OKQHEKLO8i6hH8kOIOiGcM1K86mSEp6w=;
 b=Pwx3Y0Zy4lTSenPlCn/Ezp0Rwuu8uchRAu/vjHypcH+hQk26JGMUbSrpbCZVK6SIZXoFRDjbsOR+gsUri1fuL1oaxRnJuQ8mJFh46kdd/TTCWaq7v87yywj452J4383JCEIClekTA/9ZVHd9tlHPTbsLOVReZ7Gi4M7DKBV00gEdQWIhYebbewN54XdR046dKVzTWI3T0PLvirMfZWsRkVmUfY3erxFR0t4GZ6+kGEHfO1fUrtlFgYFK3syoEr/AHpbWaqLpieZiYlRr4aZ3yu6fxwPY0M2dTxuyajOgHMqhpD0mN4Y4wm20ILPPR9mOaUAIUzunbMTjqps3IQVsSg==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 DS0PR02MB9175.namprd02.prod.outlook.com (2603:10b6:8:13f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.9; Thu, 24 Apr 2025 10:23:09 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Thu, 24 Apr 2025
 10:23:09 +0000
Message-ID: <0f8c2173-193f-4225-a7c9-d2968c205666@nutanix.com>
Date: Thu, 24 Apr 2025 11:23:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] physmem: Move TCG IOMMU methods around
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250424094653.35932-1-philmd@linaro.org>
 <20250424094653.35932-11-philmd@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250424094653.35932-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0086.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::39) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|DS0PR02MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 61992709-f9a1-472f-2387-08dd831a02c9
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZVVsQU5OUzh2NWpnM21qb1hMLzdxV0ZSYjFkNnJYTFNMNjFOLzRFbWJocFBN?=
 =?utf-8?B?Y2NPRC93b0x4Q042QnNNWUFPNXlLVUIrSVgvdHM5U2E2MUE4RlpRVHplMXdj?=
 =?utf-8?B?S1Z2ZDVpOE4wMGhaZi9uKzZHTktEWXRQaGpaRzRJY0F4WTVMSTlaTUFvbk9D?=
 =?utf-8?B?QnUyRi9xWlIwanR2ZkZndWxuaVg3K2kySThickpNUElYOGxjVXU4eU1mK3g4?=
 =?utf-8?B?N2JCV2VQT0pjSmdwOFlab1pidUk3b3kzemtrYXBTa0JZRkFySk1VZmRwMWwx?=
 =?utf-8?B?OUhQUEhyb0tCditBaE5SMXoxRjNoRjFyckdVeG9CdzkwNVBpTndzU0RKZnpp?=
 =?utf-8?B?OXhVSlorUmhqaEdVVjBWelhFTXVFbEJINURlQXdUUm1GSFJQK1crZUd3Z1c1?=
 =?utf-8?B?QWVraGxCV1J0c2w4Z2YyZkRTN1ZOajEvcEs1T25kWnQwTWJsYUZGWXNDRVc4?=
 =?utf-8?B?RXdGSkQza1BMK2pXd3RnYkliNkJ3bmsxQkpkcTVXRmRVaGtnbVM3VnRBc2Fa?=
 =?utf-8?B?b3ZNdXlaaUxCemVTTVJ5Y3NPY005L3lvQ3lBR1FHR0ZFR1htMk1zZnFkUzM2?=
 =?utf-8?B?OFdKRnBBTWRSRFZRQURhTHMxNHZIRGZPek1xd2JzNXdLVHNrdnRjQ0FyUnRD?=
 =?utf-8?B?UmxucXpZZkhLamlqUlpEWEZsRmxOMGlVeTI4Qlp0VENFVkNIZVRWMEJEcG90?=
 =?utf-8?B?blRuaG4vNGlXWWlHWkRqSEt6NGQxcVBReEhIRmtOYmFxWnYvWWtiTHJuYUdH?=
 =?utf-8?B?a090NjE3YzhpZWFMOXlQMlVrSTJwaVIyMTBPaTNVRU9nK2xGT3lTOTF2Z2Ew?=
 =?utf-8?B?a2dNVGJwOVRhcG00VUJnLzhOUy9URThxbk41aERzSmdmTDl6UGljc21EU0Vv?=
 =?utf-8?B?YXJ5ZG1ZU2pURGFjOHM2WS9VQVNwYWlJMHNKVUZqaFlTOWVQdFRvazIrUUtt?=
 =?utf-8?B?ME9RMGF0TTNHR0xWbFlpVnVnWmFRb2dobU1PUHI1amVqT2pOWkRvZVovZXNw?=
 =?utf-8?B?MDNKdjV1YURGWHlORklsdTlJQ1VLVmU1YkxuT1pteFpYS3JWL3o3N2p0YjUv?=
 =?utf-8?B?VzZ0citHcWN1Zis0V3JZMGhoTXR6Y1BHd2xUZ1NNN2djZHRpYWdnQ1d3L2dm?=
 =?utf-8?B?aEVFV0FXYWVZRlJvVGl4eER0T2Jwd0dzSk1qTjZTS093MlAvWklEdTlVcmZC?=
 =?utf-8?B?S1J5akFHZHZmR0c5bjB3ejlPbU5HZy8wRXJjVDNkOWtYNEhKTjB1bHZvQ0dP?=
 =?utf-8?B?ekxQSnh6RWlxbUdNVHNRVG5zZGtHcVFldGVyaWNVT3l5cGNWMHBJb3BKOHVW?=
 =?utf-8?B?WWlMQy9BaWhtTGhRQU02Tk4xWHdoWnFQbTNsNVFqMWYyTStWU3QwR3o5dXhR?=
 =?utf-8?B?QnNZVDVpUER3d0gxWGhvNlFTVnN2amZLam83YU40VDAvT0pVSGJIbTI4RmdF?=
 =?utf-8?B?TG9zWWNqNWdWRm5wa0JrLytML2tMcWdJYnJ0ZTMzV0hKREZzUlUwMkpxM0dV?=
 =?utf-8?B?Titpc1JWVHZkajM2VW9ob2hnbXl0bkNobDNCbHpXODN5bGRxQmhJN0I1c0Vu?=
 =?utf-8?B?QVkrSXNSckFzZnRiQ3E1Z0dBMk5oMWRnbGhXRklJcUNLa043aDUvK0hFNTF3?=
 =?utf-8?B?cDVCTVluNm1hVWhnY2JwbDF5bDN0ZTdZa2YvTFZza2VscVZZbitndmVVWFJm?=
 =?utf-8?B?NGJUYzB1MVFjOHprZHA1MUZnSXFzRnNnRjlqUHhEVXg4K3dOa2JMbE5CUGlk?=
 =?utf-8?B?Q1p5SUlwbW9XSkZYTVV5VkpmQ212U0ZWVHVRZmtwVTU5ZSt2am5MeE52UVJR?=
 =?utf-8?B?MzNVaUxuZEF2TVFuUWM1Q3BtZGsyMGlmU2JXS0VuUk0zVzN1bTUzQzh0M3Er?=
 =?utf-8?B?VmoxUmk2a1FGYjBTbmRhQnJDVE01SFFnMnFPRDZHYjJxZlh2MjdyclBSM0hv?=
 =?utf-8?Q?kTl3dDCRH/s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkI5OHU3STc5MGRFNk52UHpCelVSRWRGcWxUenJ1M05paHNvdXpNTkNLYldR?=
 =?utf-8?B?c0Q3WmdZSlNJekQ1ZC9TamZEdVR2NUtTTmlLa1JlRnV5NlcwQ3NlMkNyczVY?=
 =?utf-8?B?cVowYzlBQTlDcmtvUW1nU2xESndKQndrWmJ5ZE1FMngwamtUcU05d0xGK3Bj?=
 =?utf-8?B?T0FNSUtWQnVKVEpuR3I5dDFqWmhmQXJBS1FWYzhwemNWa1dNQURPKzFieitl?=
 =?utf-8?B?akZZczhLcXEwQkVqY2tjMHhzSllCTk8yMkRwZHRnQXEyMGcvczdRVzdsZGs5?=
 =?utf-8?B?VTVrbDhjUW85VzZ6TWJKNlhDNExsOHdFQlovWmpjVGFiSndIVXZIZ3l6Zkg1?=
 =?utf-8?B?clQ5REpFcHR0MGtJUkZkSmNWRzhmZnJSQ3hnVnNiRDRzYWJxeTZ1SnFQOEpo?=
 =?utf-8?B?NzlIcENESUFDRElkQ2Y0ZTNKSGJNT0RObWR0czd1MmFzSVZrOEZmejJXdUNw?=
 =?utf-8?B?bndQNnB0b3V0Qm5hemt1UXdScENSeTMyNlgyL0JkNTRMNlM0K1B2UFdhZkI4?=
 =?utf-8?B?M2ZzR3hFTUVqelYzTmxud21FS1pYZGxqem1wMFdVNWwwNkZaN0RubHAyeHZy?=
 =?utf-8?B?Zk94QlB0bU52ZnpQNGwyeEw1Mmt6Z1E0c2l6VEQyMC9MQnl3UE4wRWZNc01j?=
 =?utf-8?B?TUJlRC9EcEd4VE5iMUdUQjQycy9TRjZwV0lpU3Z0ZExidkxQQ2VxUnMyS24v?=
 =?utf-8?B?dHpObGdHZE5POU95UXNQYUZYUXl1RWZoQ0FSeElRMkV0YkhqL3luRmFiUlVa?=
 =?utf-8?B?cElwSDlBZzR2M2sxTUNIWjN5WjYveTJkNE5SSnZySnNpN2crOXY4cGhqc295?=
 =?utf-8?B?UW4wRS9BU1NCVVg3WHpqU0pVNi9tcTE5dEJwblRKd2I2WU9yV0pqaHlwUTBa?=
 =?utf-8?B?UUcrNkc0dEExbmVvYjIydVRtNVM4RWdwM2ROUG9FWDBXWjhQLzRPcXRLc3dG?=
 =?utf-8?B?Q3ppbVo3Q2hObWRicUs1UC9qUE5SZmFoUjRnUUs0d21jTjVNZVBEVXdESEl3?=
 =?utf-8?B?THNheng2OWgvQ3M4YWFSbVZUSkVINktneE5UbWdmWS9JekRGYTlpTFBkTFpn?=
 =?utf-8?B?a0pkNmszaXhGSW40TjFqbFN2ZFRWWkFaWGJyR1RneXNQcWlNVkh1R2phRWtE?=
 =?utf-8?B?a1VwZ3ErR1lFNG9XM1BRbjJNMWhCVEprbUtaK3I2M1pGTXAvRzdFVVorMTds?=
 =?utf-8?B?cWxNSVJUUDRjVDYzMTBEQnFtdWpwM0FvaTV0Lzl6YlhSQXNMQTBwclVpTDdt?=
 =?utf-8?B?cG5wbTg2djlGdjI2bmhkRThXeWdkMElZMk1aOGx2WjlEN241bEpoQldtSXls?=
 =?utf-8?B?MkJUZ2w1VzlyZ09ob1RZR2xURkdoTW05OXhqWWxyeHR1cHFDdzEzQWh2M3dK?=
 =?utf-8?B?UDlWOGUrRjJBTGlTdHMrVmZ5V0dPNEdUV2NsQ2wxdmYyZ1pTZlJvSm1TbDJ0?=
 =?utf-8?B?WThpRk8wbU9Ya0NYRzlCODhMR1doWExiblVOR3RGd2MweXIvZW4vbStRT09p?=
 =?utf-8?B?V1VwMUNPOVVHdkNnUmxhdURyRUZHMUZFTW05ajBpakNRYStZL3hEQjRxYTVm?=
 =?utf-8?B?MTFBWVAybE5jYmlQTlZvOFdvWis4bmlzTzVTMHNFUzV4MExvb2NiNGswSEVn?=
 =?utf-8?B?ZXlHUFpQeGk3WEQ2MWxod3o3bHl6UWNVV29yWEE0clplQTZFLys5T0lJWFF3?=
 =?utf-8?B?Tjkxa1ZWRGhNV2drZUdsc213TUNFRldWWUsydXM5d2tNQktpb0JmV1hsL2Ew?=
 =?utf-8?B?OU82RGkvUzBLNEVUb25sSWZhWGk5eVpveUVSZjV5NHJnc2FFVlVFbUxzbkxT?=
 =?utf-8?B?UmVjOTBsVWNSQ2k3NEFPYy9QNFEzcWZNV3JhYnQwMUxVS0tROUp0WGlwVG1S?=
 =?utf-8?B?dWxkYm43S3dKRW9YL0w4bHMxY1ZpVldaNXhFd0wxWlBaaWlGbUxvNGhGbTJL?=
 =?utf-8?B?RmcrbU1GWllEd0J5V3EzNTRiK1lnNlZ6Q3ZqVHlRSWc5cG5UeWF0WXdRVWZ4?=
 =?utf-8?B?c0JpVFpGOUlxSDJ0SXcvUW05aHphWk9RbngvelNBWFFuZkZHSGdvZDhXaEpp?=
 =?utf-8?B?V0thb2pVMDc5L1lEYVhROEl5clNrb09UdTEybzhGaFZjV1YxdFBwWCs0TEFQ?=
 =?utf-8?B?dFpLejYxUTJGKzlNcG9laGsyQUd6MkNMSnZGSVNsa0s5Qnh5UkdTaU9PdWVX?=
 =?utf-8?B?bU92dm9aU0EyZ2loOTk0TTZhWmpWZ09QMEpKU0FVelY2a04vS3FVYTY0VnFX?=
 =?utf-8?B?bXlTV0JaNFdZckQ2Nlc3S1RkbldRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61992709-f9a1-472f-2387-08dd831a02c9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 10:23:09.7462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aaZvksE1aoPHGcGScIpYW5NJuQpE6BqZ9ABpq9UyWt3Qz9BmPFjDJueqd3pluGUK+dR9J9okAfW0f259nXf8auZpaaHFdwe8DotonRAGzWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9175
X-Proofpoint-ORIG-GUID: yuNu9I4ZyNB-wUwSZ-YU9k5E8-X99ovo
X-Proofpoint-GUID: yuNu9I4ZyNB-wUwSZ-YU9k5E8-X99ovo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA2OSBTYWx0ZWRfX3Xh1ZJpBgZdP
 6uTxrOdhrFYIbTniG6HxoZH/t8w8Q9HthGsVc6AsWesQ5P711aZ+bBBDAtENW/p115ZBSt82RG8
 RDtFT6Nj8t4H8lXsAW62GcFj6Ps2gYhAJZGj+7tJ71nHC3uEsYRhavXUokbwoZxtL0tWSgQz5Di
 V96/fEyGosrkl8y1An2yA6yoHX90quVQX9MHe2vGI9XJc4zDrOYVaM1O2bxjyABDGHagT/yX3N5
 O5vQ3VrCW/TjgzowKhv0yOvZ4JcIsKhQoB806s2SoaqV+NjLN14Yd1t9zyq8wuoerP4f8v5i8n4
 kbANVda+TZA4UKegrLIrZrD4ZMCYF71B48zEvHo6pRNJzspAEGPqUJ9qkuFTUIvJsbyaPHkIqD0
 eGhee+ePkbhBrEGpTPUtkdC/Nnl1RVc+khuMaq+V0XtXofk6pk90iphEOiipJ1uTqSkAYPY8
X-Authority-Analysis: v=2.4 cv=beJrUPPB c=1 sm=1 tr=0 ts=680a110f cx=c_pps
 a=ur2hu7Zt/Tb0cWAHmjvzJg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8
 a=m5ZlAcRkSiyeMRatShsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

> The next commit will restrict TCG specific code in physmem.c
> using some #ifdef'ry. In order to keep it simple, move
> iotlb_to_section() and memory_region_section_get_iotlb()
> around close together.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   system/physmem.c | 50 ++++++++++++++++++++++++------------------------
>   1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 637f2d85324..ccbeae241c4 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -746,6 +746,31 @@ translate_fail:
>       return &d->map.sections[PHYS_SECTION_UNASSIGNED];
>   }
>   
> +MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> +                                      hwaddr index, MemTxAttrs attrs)
> +{
> +    int asidx = cpu_asidx_from_attrs(cpu, attrs);
> +    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
> +    AddressSpaceDispatch *d = cpuas->memory_dispatch;
> +    int section_index = index & ~TARGET_PAGE_MASK;
> +    MemoryRegionSection *ret;
> +
> +    assert(section_index < d->map.sections_nb);
> +    ret = d->map.sections + section_index;
> +    assert(ret->mr);
> +    assert(ret->mr->ops);
> +
> +    return ret;
> +}
> +
> +/* Called from RCU critical section */
> +hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> +                                       MemoryRegionSection *section)
> +{
> +    AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
> +    return section - d->map.sections;
> +}
> +
>   void cpu_address_space_init(CPUState *cpu, int asidx,
>                               const char *prefix, MemoryRegion *mr)
>   {
> @@ -1002,14 +1027,6 @@ bool cpu_physical_memory_snapshot_get_dirty(DirtyBitmapSnapshot *snap,
>       return false;
>   }
>   
> -/* Called from RCU critical section */
> -hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section)
> -{
> -    AddressSpaceDispatch *d = flatview_to_dispatch(section->fv);
> -    return section - d->map.sections;
> -}
> -
>   static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
>                               uint16_t section);
>   static subpage_t *subpage_init(FlatView *fv, hwaddr base);
> @@ -2669,23 +2686,6 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
>       return phys_section_add(map, &section);
>   }
>   
> -MemoryRegionSection *iotlb_to_section(CPUState *cpu,
> -                                      hwaddr index, MemTxAttrs attrs)
> -{
> -    int asidx = cpu_asidx_from_attrs(cpu, attrs);
> -    CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
> -    AddressSpaceDispatch *d = cpuas->memory_dispatch;
> -    int section_index = index & ~TARGET_PAGE_MASK;
> -    MemoryRegionSection *ret;
> -
> -    assert(section_index < d->map.sections_nb);
> -    ret = d->map.sections + section_index;
> -    assert(ret->mr);
> -    assert(ret->mr->ops);
> -
> -    return ret;
> -}
> -
>   static void io_mem_init(void)
>   {
>       memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops, NULL,

Shouldn't that be IOTLB rather than IOMMU in the subject line? Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


