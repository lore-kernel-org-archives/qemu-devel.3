Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324E6E9538C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbQ8-0005Ic-7j; Wed, 04 Feb 2026 06:51:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbQ3-0005IN-1v
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:51:40 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbPy-000650-BF
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:51:38 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145lvnw2991591; Wed, 4 Feb 2026 03:51:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FjqNcswDXnats5sb4e28SuRS8C0Fn3jZ0+fcJMwCh
 ms=; b=ZFsN0AicJh9c5A7zcCLD0TzIuA66LROZ/ApmsH6hcMiaA0nOjWOni7E/M
 uFFHVJH/G3iJ/qe2vMMrYOLQ7r1A6inM4RgBib5DybslqWGkfOlcTvhOJoMdeZaq
 WJHDHvlQ3JP5jNPZaR53e2mK2Xm0WnjvN6JEUPtghX+e4FWJsW7RnfJjIjl1mHjl
 SqEv6/LBND92DcQIaZUGrn0luhqRxDtnOrYZJrIwIfG5G7ikKZYbraiE5itXbQAI
 hLtpOTQChej2Uomn9pTQH3YUBamq6Qk0u4XQpvh12Mm6F2Irnq03oenE29D/Qvmt
 B4aJ3PFV5r7LQM0+7k+QxzMdg9B5w==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021083.outbound.protection.outlook.com
 [40.93.194.83])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3ntja6uk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:51:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+/13FPQrxZ2f9pHZp8db0wds3RVT8l54klafrRPNqNjUdVJVx5TG4Ps6JZvhuSvvqKTVhRQCxYxpvIkqxnBxbuz3EkNGQBaeqBmPD/V61QpHaQoxXtwHR6aRi2GCxcX9Knz9Y5jvORzNGkDcBFHmbk80C8PudNUzQhGkPsqjzm+uFAKDxSKMecdxvsnvC36UD/oapuIG0EXhplEiMBJP2/fasa949nGHby/olmstVM4ltn2SareWS5aM5Mj4OrHV8gWNHSMkNsN39li80nrwz1KFH8cAL7p7Q49eU3ezRH1JGYDxy1FjdqEGq0rsLKwEc0pgA2sqCHgWR0y3fbyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjqNcswDXnats5sb4e28SuRS8C0Fn3jZ0+fcJMwChms=;
 b=pZGHluHnSZLuB/C9Hb6JaG1HTkpf6A9DWek9QOEmU+VAtexEZOJC/pAdSOfBKsTu4DybUGjrCbAKBtdPho9B+me1u/LPtiF4oNCr7Xt6wj6AHcjNlYFmj4iV6apdXRMZrPR1bTXy4V1QuepKVnB58dlIcBSYBm4hXxOC73WzfMsd8fXLnaHtlfRZkIJRslcgaXH6bcfwtRMgrvbpP9ZdXN60mjvzvkycFNr4fyLN8e2EhIGbirXAHn1A7nTNbcbSCP4OlRDyf2xoPJMpKjNj7JzlUOCuFTGDwb8C9Qd/lkDztCEfkc5nTQudE5CeFWA5CKSnSdXJhEo7WDEFe/iFMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjqNcswDXnats5sb4e28SuRS8C0Fn3jZ0+fcJMwChms=;
 b=PbDymM0Uk5AoSKZQ1Q3uk5g5GOyOKp+dG87StKQYlmAHBeW8JXYPBR9oK/BoCcciKMdYE9oALdy6RPY3EAD6l+IwztprxoYFzt9FtW8plYFpAYROdvp3B+pxfuOfYd6pCGyzqdln4S+UTSzdHtGQEWPk23rsKzbQS7JnEdiNLnVYiOXa8cJ9POchjC78g/t3SWGUnz/E2iH0L8DAv5uj26TTvi9MBMs+S+edJVukGdgp5wO5HYBkbLNb8MOfwK3rKGStLz2BKxYuxsIc4tXQWqFgHw3V7qXdk2UqaVHO+Kuj1p5Eip/JFlM5dTA9nh3dnQnAvolfMOGqR92SuKOc4g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8096.namprd02.prod.outlook.com (2603:10b6:408:167::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 11:51:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:51:30 +0000
Message-ID: <2600006f-df87-4b9c-9cd4-944c1bbbc936@nutanix.com>
Date: Wed, 4 Feb 2026 11:51:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/37] audio: split AudioMixengBackend code in
 audio-mixeng-be.c
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-37-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-37-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:806:6f::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 165893e1-769d-4f95-4c10-08de63e3bc22
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MllraDBIclJSd3dZUk85a0hDemE3VnpsY0s1VmxsZTVyQlZxRHZWczBxSXlo?=
 =?utf-8?B?V3NlVlR1M3pES3d2Y2dlRGlaQkV5WUY0U0lXSW9QN0ZHNzBkZ2hhUlV5UVN2?=
 =?utf-8?B?M3d3RW1OejFaenJMSEtIY2didzVXQlVUdjRXQk12NmpCYldUWGZNWUt1eGFP?=
 =?utf-8?B?a1JiNldmZGFJR2lzbFNSN3BPWmlHSW1JTDdEeEFKMXdJK2FOZ0JSaFJiSjFN?=
 =?utf-8?B?THJyelBQcVRlY3JxU1lMSnpDckdFUHVwdy9YWXJqZ3Q5TmNCN1lvRkVaVGRy?=
 =?utf-8?B?UjlqeXVRVFNPOEt2V29SWnp2SG9HTEJBRFVnL1RYZ2hSZGhtTXorQW1zaFBR?=
 =?utf-8?B?QTZhVnN1WXRPRnhDQ3djdXp6NzRUeVRTcm4xdGxhSG8wRmlUaEM3WE9XWGlG?=
 =?utf-8?B?RGMzTDhTSUp4aGc2enpJYitRZ0MwSWRNbkVDOFJYeEJvdnNkWXJ5NDNLSGVG?=
 =?utf-8?B?TXFzdkJ2T2JlTmVxM2FxY1oyL2NMcHMzVTh6WFZ1YzJZckk4TzQ1SlhpNGMx?=
 =?utf-8?B?dkkrNHArYmtOY3VHNjcwVHdaTVVocnppWTc0ZUI4c1kwNmc2NVcwN2QxNHlB?=
 =?utf-8?B?RHk0NVpiUWdsUGFuNHg0Zk1lQTdFNjBiSDFYaVRSZzRkR1J4WG5EZTdQQVZa?=
 =?utf-8?B?VmFMT2JrbnVwbmZVTFFadFZ2TldMUkFhd0tDZkxwek1DQzlOMkJ1QXVET09E?=
 =?utf-8?B?bGFwRTFoY1h6V2pkN3BadVZ6OUE0TVdScUhqNTBEdjA5V1g0dmJqVHhrbmZG?=
 =?utf-8?B?TGFsZHJydmRoWVUzWEZqcnRkMlhJTzRucG9pU3ZVYXhNUEV3Zm1LSlN5TTNK?=
 =?utf-8?B?Mzlhcm5YbzhVdERwUG43OFE0WmlZT0dzNEwrWEpLaWRXN1o4V3ZER09GZCtI?=
 =?utf-8?B?TlplR3Y3V3ZmVllSc1pSSXV2Rkd2dncxVENoZUN6WEVnd3N0a1JtcSsyY0hm?=
 =?utf-8?B?VFZYSlZSZVk4WTVRbSswSUdVRS8zSXNOSEpPZkZWbHNsbjIrZEsySzd0dldu?=
 =?utf-8?B?VlhSNlZhMkUyQ3NWQkxEYjVsSkRzaXhveklWd0NQMHRJU1Zic0Zmc1hCK0ZN?=
 =?utf-8?B?NFBmUFBFcWxzNjBPQ3hQTzgwQ29VT2FybngzQXp0eWdmdklzcTlxRjZRSDY2?=
 =?utf-8?B?RkNrb3V1RExETkZNNVo0bWZQRVl2Wi8zY0lKS1FiZ080RTI5MkxqaEdmZmdl?=
 =?utf-8?B?M3hzWk9wNjVzdUltOGh5eDdpVkY2NmNWMUZiSzd3VzBtOGNlS01vTEdaY2g0?=
 =?utf-8?B?dGNuTWozSXBvc3ZOMS9RRUVpWXR5ZDFrakRLb2wvMnJvNEFZZS9Ca1l5dXdu?=
 =?utf-8?B?L2hueGR3bVM0WEVTVzA3c3hYdGZrVGZKVXZxUkhpQTJBcTFVYWYyNVBuTXBV?=
 =?utf-8?B?UGtuWG1Wb3ZQWlAyWTB2L3E4UFk5bnlaVnR1OTdHeDNvZHdMMWpQTk5YNmZh?=
 =?utf-8?B?bEV6UFJpejVkOEFxZXkyVlFIQyt4L0FxVW5wUWpWWlN1REpXSS9TQkRyR2xr?=
 =?utf-8?B?NWdXNDhybERxNlZ4TEV6bWRRQ2JqRTFpSlRINVJmbmszVFU4Vm1jZE96QlN2?=
 =?utf-8?B?RmRreC9idjg0Z1J4emx4ZkV6WGw2L2NYMlgrT0ZZd1dJMEVoc1Uvb05MOHBC?=
 =?utf-8?B?ajQyeG5scTc3czBLUTFPTEFIbmV5Zll5SkZNeEV5bjNkY2dXMUtnbEpMVWlJ?=
 =?utf-8?B?ZE51bGozYUJXVmVpNlI3S2M1aWFHZUtOaUluL0FZS1V4QXZrMFVqelhVSWlq?=
 =?utf-8?B?M2Vuajd4aUdsWU1PUVB4S0YxMGUxWGZydGYwMnhCdUdWaWtmY2pLb010R2Zv?=
 =?utf-8?B?OUtnb0VKMGlSSnVlemI3dDMydVdaVTVJYzVmRURtWmQ0YWg0RU04ZFVsRkVa?=
 =?utf-8?B?WHZ6Vm5OczlnT1BHUWNUOWFSclZCem5melg3ZkhDWWMwKzhNMTNmUjBuOXNt?=
 =?utf-8?B?VFdXUlNhYXhZMUswSUZ3U1FQajdGeFU1YVZrTGYxQmlxVzhzTTFrQndlYjlH?=
 =?utf-8?B?WFpwZzJmNFRHbExaTXNZWUtWanJVN2c3bFNiOVpuZC9UT3lFcDJ1aGpUUHRz?=
 =?utf-8?B?NjAwOStMeElTOCtsZHRSMlBQMVRpMG1LUDNNdHlIRUVyb3FnL0ZMaFhaTWJI?=
 =?utf-8?Q?+j5U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUh5bTBnMmJkb29WQVA4SGkvcG1adDRRd3NzSXRiTE83NzNsNFBUd2JEOEVD?=
 =?utf-8?B?QitDUjlibDR4QVZ5aDhHL2s4bURWVWZOZS8yRzQ4T0RpYjltcno0Sm93am56?=
 =?utf-8?B?VUgrWVJxemp5WDdNT3B6RHJjRzNReXMrMkY2QlNHdmFJajFvRjh0M2U1WG80?=
 =?utf-8?B?akE2THFkajdpSjhMUnFpVmh2NHp5dTdocmg3VERQT25mQ0RYQU5BZ3pOSVg1?=
 =?utf-8?B?c3NwaFpnNUMxd3VwUTVYQkxvK1ErVUp5c1ZMNGV2UjFkZzVrVDNrVi8yeldU?=
 =?utf-8?B?WCtxVjNjMUN2MVNhc3oySTVObTdLQk5sZFNlWFBLdkk1N1dRS1VLSDdMTzdE?=
 =?utf-8?B?NUFlVEtmMkFKNjYyaWEvVXg5WjJaNlVPRzBvdVZHQVEybVpvTEdKYk94OU03?=
 =?utf-8?B?RXhoc0lQcXBFTUtIZWRlZm9DMVM4UEFuR3NOUkhKYzVPOUk1NjhWanV0ZkFa?=
 =?utf-8?B?cG4rVGdCWHB4Mk5LeGRPdDZRVTQxTHpFbjlUVE05UklWSDBOaUdteE8xQ3RH?=
 =?utf-8?B?dzByME9vVjlrL0FkT2ozS0xKSnA2Y2pWL3hQSnJwSVJoVkVuNWN6bjI5dWcv?=
 =?utf-8?B?R25jb211V21WUWdKR3pGU2ZPZTVQdnFHOGsvbEFPYTdiTTVrV1pqS0NsZ3ZN?=
 =?utf-8?B?UE5xZGREYzVVc0R2UXNzZWNuaFZhSU9Sb1dmWUdqU2ZJN3ZhRHdGQXpiTTc0?=
 =?utf-8?B?WVdtRDlhZ0hOaXVWQVllYjVFUXhxR3REZWtFZ2g0bWxLL2lrZzRMSUxuR2Zs?=
 =?utf-8?B?MUU3MHp5NEwzOXJ0T2l1RnNqYUVyV2VZL3V1aDk5cVJRcHRkbGNscXFER2RZ?=
 =?utf-8?B?blNRVExKWTdhZzQ0RUJnQlQvbUpuSFVvcXd1ejQ4czJPTVZZRHMyMEZoVWZ5?=
 =?utf-8?B?bVBsdmpzeVdCQnU5UWhJcHVmV24vWDVTTGJrWCs3R2tzTmNiV0w5d0ZTT21y?=
 =?utf-8?B?MWVWQlhLMk16S3JpMVduWks4VlBMM29VUFVpbWNEYW45b1JBVkw5T1V5SUEw?=
 =?utf-8?B?cDF6VVc3TVJUZGY3QXd5NzE1VGU5K1BxQ1VUN1V3WUNZQ3hWaVVYSjNITlYx?=
 =?utf-8?B?aDFZa1JpcVpFSHlnRzRwdWg0NHRjQW5ab21EUmFRSVlPQStGYXJkdkVyN1Iv?=
 =?utf-8?B?QkhjOUpLZy9VTHZveDRYc20raWNzSEFGT3lBZjg5ZUhEWE9LUHNjN1FCcVBM?=
 =?utf-8?B?TDNObFRyS2ZqblU5U2c3WEcwWW5VdkNHOWx3Q2pVa1YzYWc0NlZMKytlL3pi?=
 =?utf-8?B?MkVaMTVFTHE2bnl3M0x6WWQ1Qy82SnZ2YnBidmpvRG9HdSsraTZMWWRTWTYw?=
 =?utf-8?B?b3dtcWRhcG04bWsyeEQ2Smo0Um9wWW9sWllzRWVtQzJuVktZenhBbkd0WXRR?=
 =?utf-8?B?VW9XSmtKNzJYVk5GL2d6aUNIeXVjNURCYXFrTUVCdkYrV1p5QUZPdllEUE5T?=
 =?utf-8?B?WEJkdFV4YjVQb1hrMG1KdCtwajF0M0YycmZHdVpXT1lmU3g5bGhuUTkyd0dP?=
 =?utf-8?B?alBmQ2NLRkxwUEtWWEpyY2lrYXdKWWMwMHRuS2VUT0JhYk5qZWp5TWtTZjY3?=
 =?utf-8?B?c2xwWDBYNXNWcjNISVFENXpwYXBncGkwRVRoTWNJb25XNVEwQUErK0dyYS80?=
 =?utf-8?B?RDNFYXRpbTZaQkhvSkd1U2hmd0RnbENMU1RnMHFkZ1I4LzcvRjMzaHhCKy9D?=
 =?utf-8?B?N0FOSXE3QWRYcGp4Nnp5bFMrNFhrcFJURTM2cC9WOGtxQml2ei9neitZa3ZX?=
 =?utf-8?B?R1pUVDIyNmVuNFpZYStxU1djZ3VNUzVFWmVPeFV4WDIxY2g5WkFuMVFPdnFi?=
 =?utf-8?B?L2g1dkhrRWhqMFVvZXpMOTZJN1JBNEhwZ0x6U0JIamZKcGlSajVSR3llY3V3?=
 =?utf-8?B?OXJnQlZRTjZDb1BMQVBQWTVvRGU3cGFwaks1S1k5UEJEdzBGRmFsZTVRSzZ2?=
 =?utf-8?B?RDd5Zit5b2JmMk15bjlVanhsaklIRFFrUW5pRGpjeXhxVHN0WS9hc0hNb0hn?=
 =?utf-8?B?Ly9pWlpKWTBTM2tDTmIvT2d4ODhuRmtyNFFZQ1pPMXBnSGNkL2c3bGx2TTU0?=
 =?utf-8?B?THNtYUlEZkNTZE1NbE5tTTg5dUJyeVcvQklxSHp3RzVnS21YWU45NVpJY1pJ?=
 =?utf-8?B?ZmxYZEticnROdGoyU3crUkRVcy9kYU1vVTcwbXdJQ3ZqNzEyVkxyUTBxWGo0?=
 =?utf-8?B?cUtic21BeENFV3VCNDVJMDZBUUpCaVcxeGlQd0NjYUxhOTd1RXo0YUsvVGwy?=
 =?utf-8?B?UisvR05yeVYvdWxlRHUvdzdmMGorNkpYQ09yUVVINWhEb1RPdWVaWU0yWVVT?=
 =?utf-8?B?SlA5MlNKMzg4SGpRWFVjME5yNGR6YkI5QzVVenhDV01XN1pFKzV6MkZRNHpl?=
 =?utf-8?Q?/5SU0i2LulbEHBmQ=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165893e1-769d-4f95-4c10-08de63e3bc22
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:51:30.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6amDS3YQT+jz8xAhDhwrS7QbCiAvgVdBMonjDQuUwDV0N/wiWkOBfghGJfvo5c0uMrIOxfXlUWQ20GPuB1u/RQO44TQ1uzK/CWPp+FcXS6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8096
X-Proofpoint-ORIG-GUID: QwBNacKFMHB5xf07CngOUG1pQcn1Dm1s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5MCBTYWx0ZWRfX4x8pL2NiqjKV
 xj7L7G7Jyjqpe3RXyj7Ixc3vJpqbQ2ljAvFgidMEB8eRGYPPrqYZTFdRR5lfCEvvxPI2p0OUo1w
 9ZRM1ELOwzakVUl2KiMgfV+/dTzt1KQXH0ZPGCVbcPcPUojaIaJR24Rsko0yqo1DE2I1LlLS2vn
 ZbpHKM14D5r8RlSqzK4bfEYSVNLNZp0EQwBgh9OOH7m51l9frMW+NqnbIVggnMNnaBbDFdaaKu6
 ZBLReC58yCm9Ih7FYymGqi3FyfjxjQXsfkM9QJdfAbjQieX2+MMCLoVrZ3tV47KFonK1pXdRG0j
 scovMT6wgIMDdM17qqARlLoXYMqVVdasoKR4t+7YMF84xpJOcwTqGAUzSBsWBROFWJ2ZxztUY8s
 j2VICkR1ZE5VzG6m0HGqsqq5pTIMOFKnY66As8szPK146UQ44WFAQB4zCdjYFcTThGgtEe/ar9+
 B+wjBdtWimFoaCPPVzg==
X-Authority-Analysis: v=2.4 cv=K6cv3iWI c=1 sm=1 tr=0 ts=698332c4 cx=c_pps
 a=IDYaL8Jh3K30OkZprGHyjg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=YhIK_WwhAAAA:8 a=64Cc0HZtAAAA:8
 a=j0s2LzSS5vV8jAQCtHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=BQ0tM26WixaHQjprNm4N:22
X-Proofpoint-GUID: QwBNacKFMHB5xf07CngOUG1pQcn1Dm1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
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
> Allow to build the audio/ base classes without the
> resampling/mixing/queuing code.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h       |    2 -
>   include/qemu/audio.h    |    2 +
>   audio/audio-mixeng-be.c | 1979 ++++++++++++++++++++++++++++++++++
>   audio/audio.c           | 2226 ++++-----------------------------------
>   audio/meson.build       |    1 +
>   5 files changed, 2159 insertions(+), 2051 deletions(-)
>   create mode 100644 audio/audio-mixeng-be.c
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 250fd45238d..6ecd75c4fbf 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -266,8 +266,6 @@ int audio_bug (const char *funcname, int cond);
>   
>   void audio_run(AudioMixengBackend *s, const char *msg);
>   
> -const char *audio_application_name(void);
> -
>   typedef struct RateCtl {
>       int64_t start_ticks;
>       int64_t bytes_sent;
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index 42f97f732a6..dfe247ab8c4 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -183,6 +183,8 @@ bool audio_be_set_dbus_server(AudioBackend *be,
>                                 Error **errp);
>   #endif
>   
> +const char *audio_application_name(void);
> +
>   #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>       DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>   
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> new file mode 100644
> index 00000000000..8ebceb968ce
> --- /dev/null
> +++ b/audio/audio-mixeng-be.c
> @@ -0,0 +1,1979 @@
> +/*
> + * SPDX-License-Identifier: MIT
> + *
> + * Copyright (c) 2003-2005 Vassili Karpov (malc)
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/audio.h"
> +#include "migration/vmstate.h"
> +#include "qemu/timer.h"
> +#include "qapi/error.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qapi-visit-audio.h"
> +#include "qapi/qapi-commands-audio.h"
> +#include "qobject/qdict.h"
> +#include "qemu/error-report.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/help_option.h"
> +#include "qom/object.h"
> +#include "system/system.h"
> +#include "system/replay.h"
> +#include "system/runstate.h"
> +#include "trace.h"
> +
> +#define AUDIO_CAP "audio"
> +#include "audio_int.h"
> +
> +/* #define DEBUG_OUT */
> +/* #define DEBUG_CAPTURE */
> +/* #define DEBUG_POLL */
> +
> +#define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
> +
> +const struct mixeng_volume nominal_volume = {
> +    .mute = 0,
> +#ifdef FLOAT_MIXENG
> +    .r = 1.0,
> +    .l = 1.0,
> +#else
> +    .r = 1ULL << 32,
> +    .l = 1ULL << 32,
> +#endif
> +};
> +
> +int audio_bug (const char *funcname, int cond)
> +{
> +    if (cond) {
> +        static int shown;
> +
> +        AUD_log (NULL, "A bug was just triggered in %s\n", funcname);
> +        if (!shown) {
> +            shown = 1;
> +            AUD_log (NULL, "Save all your work and restart without audio\n");
> +            AUD_log (NULL, "I am sorry\n");
> +        }
> +        AUD_log (NULL, "Context:\n");
> +    }
> +
> +    return cond;
> +}
> +
> +static inline int audio_bits_to_index (int bits)
> +{
> +    switch (bits) {
> +    case 8:
> +        return 0;
> +
> +    case 16:
> +        return 1;
> +
> +    case 32:
> +        return 2;
> +
> +    default:
> +        audio_bug ("bits_to_index", 1);
> +        AUD_log (NULL, "invalid bits %d\n", bits);
> +        return 0;
> +    }
> +}
> +
> +void AUD_vlog (const char *cap, const char *fmt, va_list ap)
> +{
> +    if (cap) {
> +        fprintf(stderr, "%s: ", cap);
> +    }
> +
> +    vfprintf(stderr, fmt, ap);
> +}
> +
> +void AUD_log (const char *cap, const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    va_start (ap, fmt);
> +    AUD_vlog (cap, fmt, ap);
> +    va_end (ap);
> +}
> +
> +static void audio_print_settings (const struct audsettings *as)
> +{
> +    dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
> +
> +    switch (as->fmt) {
> +    case AUDIO_FORMAT_S8:
> +        AUD_log (NULL, "S8");
> +        break;
> +    case AUDIO_FORMAT_U8:
> +        AUD_log (NULL, "U8");
> +        break;
> +    case AUDIO_FORMAT_S16:
> +        AUD_log (NULL, "S16");
> +        break;
> +    case AUDIO_FORMAT_U16:
> +        AUD_log (NULL, "U16");
> +        break;
> +    case AUDIO_FORMAT_S32:
> +        AUD_log (NULL, "S32");
> +        break;
> +    case AUDIO_FORMAT_U32:
> +        AUD_log (NULL, "U32");
> +        break;
> +    case AUDIO_FORMAT_F32:
> +        AUD_log (NULL, "F32");
> +        break;
> +    default:
> +        AUD_log (NULL, "invalid(%d)", as->fmt);
> +        break;
> +    }
> +
> +    AUD_log (NULL, " endianness=");
> +    switch (as->endianness) {
> +    case 0:
> +        AUD_log (NULL, "little");
> +        break;
> +    case 1:
> +        AUD_log (NULL, "big");
> +        break;
> +    default:
> +        AUD_log (NULL, "invalid");
> +        break;
> +    }
> +    AUD_log (NULL, "\n");
> +}
> +
> +static int audio_validate_settings (const struct audsettings *as)
> +{
> +    int invalid;
> +
> +    invalid = as->nchannels < 1;
> +    invalid |= as->endianness != 0 && as->endianness != 1;
> +
> +    switch (as->fmt) {
> +    case AUDIO_FORMAT_S8:
> +    case AUDIO_FORMAT_U8:
> +    case AUDIO_FORMAT_S16:
> +    case AUDIO_FORMAT_U16:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_U32:
> +    case AUDIO_FORMAT_F32:
> +        break;
> +    default:
> +        invalid = 1;
> +        break;
> +    }
> +
> +    invalid |= as->freq <= 0;
> +    return invalid ? -1 : 0;
> +}
> +
> +static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
> +{
> +    int bits = 8;
> +    bool is_signed = false, is_float = false;
> +
> +    switch (as->fmt) {
> +    case AUDIO_FORMAT_S8:
> +        is_signed = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_U8:
> +        break;
> +
> +    case AUDIO_FORMAT_S16:
> +        is_signed = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_U16:
> +        bits = 16;
> +        break;
> +
> +    case AUDIO_FORMAT_F32:
> +        is_float = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_S32:
> +        is_signed = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_U32:
> +        bits = 32;
> +        break;
> +
> +    default:
> +        abort();
> +    }
> +    return info->freq == as->freq
> +        && info->nchannels == as->nchannels
> +        && info->is_signed == is_signed
> +        && info->is_float == is_float
> +        && info->bits == bits
> +        && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
> +}
> +
> +void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
> +{
> +    int bits = 8, mul;
> +    bool is_signed = false, is_float = false;
> +
> +    switch (as->fmt) {
> +    case AUDIO_FORMAT_S8:
> +        is_signed = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_U8:
> +        mul = 1;
> +        break;
> +
> +    case AUDIO_FORMAT_S16:
> +        is_signed = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_U16:
> +        bits = 16;
> +        mul = 2;
> +        break;
> +
> +    case AUDIO_FORMAT_F32:
> +        is_float = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_S32:
> +        is_signed = true;
> +        /* fall through */
> +    case AUDIO_FORMAT_U32:
> +        bits = 32;
> +        mul = 4;
> +        break;
> +
> +    default:
> +        abort();
> +    }
> +
> +    info->freq = as->freq;
> +    info->bits = bits;
> +    info->is_signed = is_signed;
> +    info->is_float = is_float;
> +    info->nchannels = as->nchannels;
> +    info->bytes_per_frame = as->nchannels * mul;
> +    info->bytes_per_second = info->freq * info->bytes_per_frame;
> +    info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
> +}
> +
> +void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
> +{
> +    if (!len) {
> +        return;
> +    }
> +
> +    if (info->is_signed || info->is_float) {
> +        memset(buf, 0x00, len * info->bytes_per_frame);
> +    } else {
> +        switch (info->bits) {
> +        case 8:
> +            memset(buf, 0x80, len * info->bytes_per_frame);
> +            break;
> +
> +        case 16:
> +            {
> +                int i;
> +                uint16_t *p = buf;
> +                short s = INT16_MAX;
> +
> +                if (info->swap_endianness) {
> +                    s = bswap16 (s);
> +                }
> +
> +                for (i = 0; i < len * info->nchannels; i++) {
> +                    p[i] = s;
> +                }
> +            }
> +            break;
> +
> +        case 32:
> +            {
> +                int i;
> +                uint32_t *p = buf;
> +                int32_t s = INT32_MAX;
> +
> +                if (info->swap_endianness) {
> +                    s = bswap32 (s);
> +                }
> +
> +                for (i = 0; i < len * info->nchannels; i++) {
> +                    p[i] = s;
> +                }
> +            }
> +            break;
> +
> +        default:
> +            AUD_log (NULL, "audio_pcm_info_clear_buf: invalid bits %d\n",
> +                     info->bits);
> +            break;
> +        }
> +    }
> +}
> +
> +/*
> + * Capture
> + */
> +static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBackend *s,
> +                                                        struct audsettings *as)
> +{
> +    CaptureVoiceOut *cap;
> +
> +    for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
> +        if (audio_pcm_info_eq (&cap->hw.info, as)) {
> +            return cap;
> +        }
> +    }
> +    return NULL;
> +}
> +
> +static void audio_notify_capture (CaptureVoiceOut *cap, audcnotification_e cmd)
> +{
> +    struct capture_callback *cb;
> +
> +#ifdef DEBUG_CAPTURE
> +    dolog ("notification %d sent\n", cmd);
> +#endif
> +    for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> +        cb->ops.notify (cb->opaque, cmd);
> +    }
> +}
> +
> +static void audio_capture_maybe_changed(CaptureVoiceOut *cap, bool enabled)
> +{
> +    if (cap->hw.enabled != enabled) {
> +        audcnotification_e cmd;
> +        cap->hw.enabled = enabled;
> +        cmd = enabled ? AUD_CNOTIFY_ENABLE : AUD_CNOTIFY_DISABLE;
> +        audio_notify_capture (cap, cmd);
> +    }
> +}
> +
> +static void audio_recalc_and_notify_capture (CaptureVoiceOut *cap)
> +{
> +    HWVoiceOut *hw = &cap->hw;
> +    SWVoiceOut *sw;
> +    bool enabled = false;
> +
> +    for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> +        if (sw->active) {
> +            enabled = true;
> +            break;
> +        }
> +    }
> +    audio_capture_maybe_changed (cap, enabled);
> +}
> +
> +static void audio_detach_capture (HWVoiceOut *hw)
> +{
> +    SWVoiceCap *sc = hw->cap_head.lh_first;
> +
> +    while (sc) {
> +        SWVoiceCap *sc1 = sc->entries.le_next;
> +        SWVoiceOut *sw = &sc->sw;
> +        CaptureVoiceOut *cap = sc->cap;
> +        int was_active = sw->active;
> +
> +        if (sw->rate) {
> +            st_rate_stop (sw->rate);
> +            sw->rate = NULL;
> +        }
> +
> +        QLIST_REMOVE (sw, entries);
> +        QLIST_REMOVE (sc, entries);
> +        g_free (sc);
> +        if (was_active) {
> +            /* We have removed soft voice from the capture:
> +               this might have changed the overall status of the capture
> +               since this might have been the only active voice */
> +            audio_recalc_and_notify_capture (cap);
> +        }
> +        sc = sc1;
> +    }
> +}
> +
> +static int audio_attach_capture (HWVoiceOut *hw)
> +{
> +    AudioMixengBackend *s = hw->s;
> +    CaptureVoiceOut *cap;
> +
> +    audio_detach_capture (hw);
> +    for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
> +        SWVoiceCap *sc;
> +        SWVoiceOut *sw;
> +        HWVoiceOut *hw_cap = &cap->hw;
> +
> +        sc = g_malloc0(sizeof(*sc));
> +
> +        sc->cap = cap;
> +        sw = &sc->sw;
> +        sw->hw = hw_cap;
> +        sw->info = hw->info;
> +        sw->empty = true;
> +        sw->active = hw->enabled;
> +        sw->vol = nominal_volume;
> +        sw->rate = st_rate_start (sw->info.freq, hw_cap->info.freq);
> +        QLIST_INSERT_HEAD (&hw_cap->sw_head, sw, entries);
> +        QLIST_INSERT_HEAD (&hw->cap_head, sc, entries);
> +#ifdef DEBUG_CAPTURE
> +        sw->name = g_strdup_printf ("for %p %d,%d,%d",
> +                                    hw, sw->info.freq, sw->info.bits,
> +                                    sw->info.nchannels);
> +        dolog ("Added %s active = %d\n", sw->name, sw->active);
> +#endif
> +        if (sw->active) {
> +            audio_capture_maybe_changed (cap, 1);
> +        }
> +    }
> +    return 0;
> +}
> +
> +/*
> + * Hard voice (capture)
> + */
> +static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
> +{
> +    SWVoiceIn *sw;
> +    size_t m = hw->total_samples_captured;
> +
> +    for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> +        if (sw->active) {
> +            m = MIN (m, sw->total_hw_samples_acquired);
> +        }
> +    }
> +    return m;
> +}
> +
> +static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
> +{
> +    size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
> +    if (audio_bug(__func__, live > hw->conv_buf.size)) {
> +        dolog("live=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
> +        return 0;
> +    }
> +    return live;
> +}
> +
> +static size_t audio_pcm_hw_conv_in(HWVoiceIn *hw, void *pcm_buf, size_t samples)
> +{
> +    size_t conv = 0;
> +    STSampleBuffer *conv_buf = &hw->conv_buf;
> +
> +    while (samples) {
> +        uint8_t *src = advance(pcm_buf, conv * hw->info.bytes_per_frame);
> +        size_t proc = MIN(samples, conv_buf->size - conv_buf->pos);
> +
> +        hw->conv(conv_buf->buffer + conv_buf->pos, src, proc);
> +        conv_buf->pos = (conv_buf->pos + proc) % conv_buf->size;
> +        samples -= proc;
> +        conv += proc;
> +    }
> +
> +    return conv;
> +}
> +
> +/*
> + * Soft voice (capture)
> + */
> +static void audio_pcm_sw_resample_in(SWVoiceIn *sw,
> +    size_t frames_in_max, size_t frames_out_max,
> +    size_t *total_in, size_t *total_out)
> +{
> +    HWVoiceIn *hw = sw->hw;
> +    struct st_sample *src, *dst;
> +    size_t live, rpos, frames_in, frames_out;
> +
> +    live = hw->total_samples_captured - sw->total_hw_samples_acquired;
> +    rpos = audio_ring_posb(hw->conv_buf.pos, live, hw->conv_buf.size);
> +
> +    /* resample conv_buf from rpos to end of buffer */
> +    src = hw->conv_buf.buffer + rpos;
> +    frames_in = MIN(frames_in_max, hw->conv_buf.size - rpos);
> +    dst = sw->resample_buf.buffer;
> +    frames_out = frames_out_max;
> +    st_rate_flow(sw->rate, src, dst, &frames_in, &frames_out);
> +    rpos += frames_in;
> +    *total_in = frames_in;
> +    *total_out = frames_out;
> +
> +    /* resample conv_buf from start of buffer if there are input frames left */
> +    if (frames_in_max - frames_in && rpos == hw->conv_buf.size) {
> +        src = hw->conv_buf.buffer;
> +        frames_in = frames_in_max - frames_in;
> +        dst += frames_out;
> +        frames_out = frames_out_max - frames_out;
> +        st_rate_flow(sw->rate, src, dst, &frames_in, &frames_out);
> +        *total_in += frames_in;
> +        *total_out += frames_out;
> +    }
> +}
> +
> +static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t buf_len)
> +{
> +    HWVoiceIn *hw = sw->hw;
> +    size_t live, frames_out_max, total_in, total_out;
> +
> +    live = hw->total_samples_captured - sw->total_hw_samples_acquired;
> +    if (!live) {
> +        return 0;
> +    }
> +    if (audio_bug(__func__, live > hw->conv_buf.size)) {
> +        dolog("live_in=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
> +        return 0;
> +    }
> +
> +    frames_out_max = MIN(buf_len / sw->info.bytes_per_frame,
> +                         sw->resample_buf.size);
> +
> +    audio_pcm_sw_resample_in(sw, live, frames_out_max, &total_in, &total_out);
> +
> +    if (!hw->pcm_ops->volume_in) {
> +        mixeng_volume(sw->resample_buf.buffer, total_out, &sw->vol);
> +    }
> +    sw->clip(buf, sw->resample_buf.buffer, total_out);
> +
> +    sw->total_hw_samples_acquired += total_in;
> +    return total_out * sw->info.bytes_per_frame;
> +}
> +
> +/*
> + * Hard voice (playback)
> + */
> +static size_t audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
> +{
> +    SWVoiceOut *sw;
> +    size_t m = SIZE_MAX;
> +    int nb_live = 0;
> +
> +    for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> +        if (sw->active || !sw->empty) {
> +            m = MIN (m, sw->total_hw_samples_mixed);
> +            nb_live += 1;
> +        }
> +    }
> +
> +    *nb_livep = nb_live;
> +    return m;
> +}
> +
> +static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
> +{
> +    size_t smin;
> +    int nb_live1;
> +
> +    smin = audio_pcm_hw_find_min_out (hw, &nb_live1);
> +    if (nb_live) {
> +        *nb_live = nb_live1;
> +    }
> +
> +    if (nb_live1) {
> +        size_t live = smin;
> +
> +        if (audio_bug(__func__, live > hw->mix_buf.size)) {
> +            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> +            return 0;
> +        }
> +        return live;
> +    }
> +    return 0;
> +}
> +
> +static size_t audio_pcm_hw_get_free(HWVoiceOut *hw)
> +{
> +    return (hw->pcm_ops->buffer_get_free ? hw->pcm_ops->buffer_get_free(hw) :
> +            INT_MAX) / hw->info.bytes_per_frame;
> +}
> +
> +static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
> +{
> +    size_t clipped = 0;
> +    size_t pos = hw->mix_buf.pos;
> +
> +    while (len) {
> +        st_sample *src = hw->mix_buf.buffer + pos;
> +        uint8_t *dst = advance(pcm_buf, clipped * hw->info.bytes_per_frame);
> +        size_t samples_till_end_of_buf = hw->mix_buf.size - pos;
> +        size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
> +
> +        hw->clip(dst, src, samples_to_clip);
> +
> +        pos = (pos + samples_to_clip) % hw->mix_buf.size;
> +        len -= samples_to_clip;
> +        clipped += samples_to_clip;
> +    }
> +}
> +
> +/*
> + * Soft voice (playback)
> + */
> +static void audio_pcm_sw_resample_out(SWVoiceOut *sw,
> +    size_t frames_in_max, size_t frames_out_max,
> +    size_t *total_in, size_t *total_out)
> +{
> +    HWVoiceOut *hw = sw->hw;
> +    struct st_sample *src, *dst;
> +    size_t live, wpos, frames_in, frames_out;
> +
> +    live = sw->total_hw_samples_mixed;
> +    wpos = (hw->mix_buf.pos + live) % hw->mix_buf.size;
> +
> +    /* write to mix_buf from wpos to end of buffer */
> +    src = sw->resample_buf.buffer;
> +    frames_in = frames_in_max;
> +    dst = hw->mix_buf.buffer + wpos;
> +    frames_out = MIN(frames_out_max, hw->mix_buf.size - wpos);
> +    st_rate_flow_mix(sw->rate, src, dst, &frames_in, &frames_out);
> +    wpos += frames_out;
> +    *total_in = frames_in;
> +    *total_out = frames_out;
> +
> +    /* write to mix_buf from start of buffer if there are input frames left */
> +    if (frames_in_max - frames_in > 0 && wpos == hw->mix_buf.size) {
> +        src += frames_in;
> +        frames_in = frames_in_max - frames_in;
> +        dst = hw->mix_buf.buffer;
> +        frames_out = frames_out_max - frames_out;
> +        st_rate_flow_mix(sw->rate, src, dst, &frames_in, &frames_out);
> +        *total_in += frames_in;
> +        *total_out += frames_out;
> +    }
> +}
> +
> +static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
> +{
> +    HWVoiceOut *hw = sw->hw;
> +    size_t live, dead, hw_free, sw_max, fe_max;
> +    size_t frames_in_max, frames_out_max, total_in, total_out;
> +
> +    live = sw->total_hw_samples_mixed;
> +    if (audio_bug(__func__, live > hw->mix_buf.size)) {
> +        dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> +        return 0;
> +    }
> +
> +    if (live == hw->mix_buf.size) {
> +#ifdef DEBUG_OUT
> +        dolog ("%s is full %zu\n", sw->name, live);
> +#endif
> +        return 0;
> +    }
> +
> +    dead = hw->mix_buf.size - live;
> +    hw_free = audio_pcm_hw_get_free(hw);
> +    hw_free = hw_free > live ? hw_free - live : 0;
> +    frames_out_max = MIN(dead, hw_free);
> +    sw_max = st_rate_frames_in(sw->rate, frames_out_max);
> +    fe_max = MIN(buf_len / sw->info.bytes_per_frame + sw->resample_buf.pos,
> +                 sw->resample_buf.size);
> +    frames_in_max = MIN(sw_max, fe_max);
> +
> +    if (!frames_in_max) {
> +        return 0;
> +    }
> +
> +    if (frames_in_max > sw->resample_buf.pos) {
> +        sw->conv(sw->resample_buf.buffer + sw->resample_buf.pos,
> +                 buf, frames_in_max - sw->resample_buf.pos);
> +        if (!sw->hw->pcm_ops->volume_out) {
> +            mixeng_volume(sw->resample_buf.buffer + sw->resample_buf.pos,
> +                          frames_in_max - sw->resample_buf.pos, &sw->vol);
> +        }
> +    }
> +
> +    audio_pcm_sw_resample_out(sw, frames_in_max, frames_out_max,
> +                              &total_in, &total_out);
> +
> +    sw->total_hw_samples_mixed += total_out;
> +    sw->empty = sw->total_hw_samples_mixed == 0;
> +
> +    /*
> +     * Upsampling may leave one audio frame in the resample buffer. Decrement
> +     * total_in by one if there was a leftover frame from the previous resample
> +     * pass in the resample buffer. Increment total_in by one if the current
> +     * resample pass left one frame in the resample buffer.
> +     */
> +    if (frames_in_max - total_in == 1) {
> +        /* copy one leftover audio frame to the beginning of the buffer */
> +        *sw->resample_buf.buffer = *(sw->resample_buf.buffer + total_in);
> +        total_in += 1 - sw->resample_buf.pos;
> +        sw->resample_buf.pos = 1;
> +    } else if (total_in >= sw->resample_buf.pos) {
> +        total_in -= sw->resample_buf.pos;
> +        sw->resample_buf.pos = 0;
> +    }
> +
> +#ifdef DEBUG_OUT
> +    dolog (
> +        "%s: write size %zu written %zu total mixed %zu\n",
> +        SW_NAME(sw),
> +        buf_len / sw->info.bytes_per_frame,
> +        total_in,
> +        sw->total_hw_samples_mixed
> +        );
> +#endif
> +
> +    return total_in * sw->info.bytes_per_frame;
> +}
> +
> +#ifdef DEBUG_AUDIO
> +static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
> +{
> +    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
> +          cap, info->bits, info->is_signed, info->is_float, info->freq,
> +          info->nchannels);
> +}
> +#endif
> +
> +#define DAC
> +#include "audio_template.h"
> +#undef DAC
> +#include "audio_template.h"
> +
> +/*
> + * Timer
> + */
> +static int audio_is_timer_needed(AudioMixengBackend *s)
> +{
> +    HWVoiceIn *hwi = NULL;
> +    HWVoiceOut *hwo = NULL;
> +
> +    while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
> +        if (!hwo->poll_mode) {
> +            return 1;
> +        }
> +    }
> +    while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
> +        if (!hwi->poll_mode) {
> +            return 1;
> +        }
> +    }
> +    return 0;
> +}
> +
> +static void audio_reset_timer(AudioMixengBackend *s)
> +{
> +    if (audio_is_timer_needed(s)) {
> +        timer_mod_anticipate_ns(s->ts,
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->period_ticks);
> +        if (!s->timer_running) {
> +            s->timer_running = true;
> +            s->timer_last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +            trace_audio_timer_start(s->period_ticks / SCALE_MS);
> +        }
> +    } else {
> +        timer_del(s->ts);
> +        if (s->timer_running) {
> +            s->timer_running = false;
> +            trace_audio_timer_stop();
> +        }
> +    }
> +}
> +
> +static void audio_timer (void *opaque)
> +{
> +    int64_t now, diff;
> +    AudioMixengBackend *s = opaque;
> +
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    diff = now - s->timer_last;
> +    if (diff > s->period_ticks * 3 / 2) {
> +        trace_audio_timer_delayed(diff / SCALE_MS);
> +    }
> +    s->timer_last = now;
> +
> +    audio_run(s, "timer");
> +    audio_reset_timer(s);
> +}
> +
> +/*
> + * Public API
> + */
> +static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
> +                                         void *buf, size_t size)
> +{
> +    HWVoiceOut *hw;
> +
> +    if (!sw) {
> +        /* XXX: Consider options */
> +        return size;
> +    }
> +    hw = sw->hw;
> +
> +    if (!hw->enabled) {
> +        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
> +        return 0;
> +    }
> +
> +    if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
> +        return audio_pcm_sw_write(sw, buf, size);
> +    } else {
> +        return hw->pcm_ops->write(hw, buf, size);
> +    }
> +}
> +
> +static size_t audio_mixeng_backend_read(AudioBackend *be,
> +                                        SWVoiceIn *sw, void *buf, size_t size)
> +{
> +    HWVoiceIn *hw;
> +
> +    if (!sw) {
> +        /* XXX: Consider options */
> +        return size;
> +    }
> +    hw = sw->hw;
> +
> +    if (!hw->enabled) {
> +        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
> +        return 0;
> +    }
> +
> +    if (audio_get_pdo_in(hw->s->dev)->mixing_engine) {
> +        return audio_pcm_sw_read(sw, buf, size);
> +    } else {
> +        return hw->pcm_ops->read(hw, buf, size);
> +    }
> +
> +}
> +
> +static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
> +{
> +    if (!sw) {
> +        return 0;
> +    }
> +
> +    if (audio_get_pdo_out(sw->s->dev)->mixing_engine) {
> +        return sw->resample_buf.size * sw->info.bytes_per_frame;
> +    }
> +
> +    return sw->hw->samples * sw->hw->info.bytes_per_frame;
> +}
> +
> +static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw,
> +                                                bool on)
> +{
> +    HWVoiceOut *hw;
> +
> +    if (!sw) {
> +        return;
> +    }
> +
> +    hw = sw->hw;
> +    if (sw->active != on) {
> +        AudioMixengBackend *s = sw->s;
> +        SWVoiceOut *temp_sw;
> +        SWVoiceCap *sc;
> +
> +        if (on) {
> +            hw->pending_disable = 0;
> +            if (!hw->enabled) {
> +                hw->enabled = true;
> +                if (runstate_is_running()) {
> +                    if (hw->pcm_ops->enable_out) {
> +                        hw->pcm_ops->enable_out(hw, true);
> +                    }
> +                    audio_reset_timer (s);
> +                }
> +            }
> +        } else {
> +            if (hw->enabled) {
> +                int nb_active = 0;
> +
> +                for (temp_sw = hw->sw_head.lh_first; temp_sw;
> +                     temp_sw = temp_sw->entries.le_next) {
> +                    nb_active += temp_sw->active != 0;
> +                }
> +
> +                hw->pending_disable = nb_active == 1;
> +            }
> +        }
> +
> +        for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> +            sc->sw.active = hw->enabled;
> +            if (hw->enabled) {
> +                audio_capture_maybe_changed (sc->cap, 1);
> +            }
> +        }
> +        sw->active = on;
> +    }
> +
> +}
> +
> +static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
> +{
> +    HWVoiceIn *hw;
> +
> +    if (!sw) {
> +        return;
> +    }
> +
> +    hw = sw->hw;
> +    if (sw->active != on) {
> +        AudioMixengBackend *s = sw->s;
> +        SWVoiceIn *temp_sw;
> +
> +        if (on) {
> +            if (!hw->enabled) {
> +                hw->enabled = true;
> +                if (runstate_is_running()) {
> +                    if (hw->pcm_ops->enable_in) {
> +                        hw->pcm_ops->enable_in(hw, true);
> +                    }
> +                    audio_reset_timer (s);
> +                }
> +            }
> +            sw->total_hw_samples_acquired = hw->total_samples_captured;
> +        } else {
> +            if (hw->enabled) {
> +                int nb_active = 0;
> +
> +                for (temp_sw = hw->sw_head.lh_first; temp_sw;
> +                     temp_sw = temp_sw->entries.le_next) {
> +                    nb_active += temp_sw->active != 0;
> +                }
> +
> +                if (nb_active == 1) {
> +                    hw->enabled = false;
> +                    if (hw->pcm_ops->enable_in) {
> +                        hw->pcm_ops->enable_in(hw, false);
> +                    }
> +                }
> +            }
> +        }
> +        sw->active = on;
> +    }
> +}
> +
> +static size_t audio_get_avail(SWVoiceIn *sw)
> +{
> +    size_t live;
> +
> +    if (!sw) {
> +        return 0;
> +    }
> +
> +    live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
> +    if (audio_bug(__func__, live > sw->hw->conv_buf.size)) {
> +        dolog("live=%zu sw->hw->conv_buf.size=%zu\n", live,
> +              sw->hw->conv_buf.size);
> +        return 0;
> +    }
> +
> +    ldebug (
> +        "%s: get_avail live %zu frontend frames %u\n",
> +        SW_NAME (sw),
> +        live, st_rate_frames_out(sw->rate, live)
> +        );
> +
> +    return live;
> +}
> +
> +static size_t audio_get_free(SWVoiceOut *sw)
> +{
> +    size_t live, dead;
> +
> +    if (!sw) {
> +        return 0;
> +    }
> +
> +    live = sw->total_hw_samples_mixed;
> +
> +    if (audio_bug(__func__, live > sw->hw->mix_buf.size)) {
> +        dolog("live=%zu sw->hw->mix_buf.size=%zu\n", live,
> +              sw->hw->mix_buf.size);
> +        return 0;
> +    }
> +
> +    dead = sw->hw->mix_buf.size - live;
> +
> +#ifdef DEBUG_OUT
> +    dolog("%s: get_free live %zu dead %zu frontend frames %u\n",
> +          SW_NAME(sw), live, dead, st_rate_frames_in(sw->rate, dead));
> +#endif
> +
> +    return dead;
> +}
> +
> +static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
> +                                        size_t samples)
> +{
> +    size_t n;
> +
> +    if (hw->enabled) {
> +        SWVoiceCap *sc;
> +
> +        for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> +            SWVoiceOut *sw = &sc->sw;
> +            size_t rpos2 = rpos;
> +
> +            n = samples;
> +            while (n) {
> +                size_t till_end_of_hw = hw->mix_buf.size - rpos2;
> +                size_t to_read = MIN(till_end_of_hw, n);
> +                size_t live, frames_in, frames_out;
> +
> +                sw->resample_buf.buffer = hw->mix_buf.buffer + rpos2;
> +                sw->resample_buf.size = to_read;
> +                live = sw->total_hw_samples_mixed;
> +
> +                audio_pcm_sw_resample_out(sw,
> +                                          to_read, sw->hw->mix_buf.size - live,
> +                                          &frames_in, &frames_out);
> +
> +                sw->total_hw_samples_mixed += frames_out;
> +                sw->empty = sw->total_hw_samples_mixed == 0;
> +
> +                if (to_read - frames_in) {
> +                    dolog("Could not mix %zu frames into a capture "
> +                          "buffer, mixed %zu\n",
> +                          to_read, frames_in);
> +                    break;
> +                }
> +                n -= to_read;
> +                rpos2 = (rpos2 + to_read) % hw->mix_buf.size;
> +            }
> +        }
> +    }
> +
> +    n = MIN(samples, hw->mix_buf.size - rpos);
> +    mixeng_clear(hw->mix_buf.buffer + rpos, n);
> +    mixeng_clear(hw->mix_buf.buffer, samples - n);
> +}
> +
> +static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
> +{
> +    size_t clipped = 0;
> +
> +    while (live) {
> +        size_t size = live * hw->info.bytes_per_frame;
> +        size_t decr, proc;
> +        void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
> +
> +        if (size == 0) {
> +            break;
> +        }
> +
> +        decr = MIN(size / hw->info.bytes_per_frame, live);
> +        if (buf) {
> +            audio_pcm_hw_clip_out(hw, buf, decr);
> +        }
> +        proc = hw->pcm_ops->put_buffer_out(hw, buf,
> +                                           decr * hw->info.bytes_per_frame) /
> +            hw->info.bytes_per_frame;
> +
> +        live -= proc;
> +        clipped += proc;
> +        hw->mix_buf.pos = (hw->mix_buf.pos + proc) % hw->mix_buf.size;
> +
> +        if (proc == 0 || proc < decr) {
> +            break;
> +        }
> +    }
> +
> +    if (hw->pcm_ops->run_buffer_out) {
> +        hw->pcm_ops->run_buffer_out(hw);
> +    }
> +
> +    return clipped;
> +}
> +
> +static void audio_run_out(AudioMixengBackend *s)
> +{
> +    HWVoiceOut *hw = NULL;
> +    SWVoiceOut *sw;
> +
> +    while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
> +        size_t played, live, prev_rpos;
> +        size_t hw_free = audio_pcm_hw_get_free(hw);
> +        int nb_live;
> +
> +        if (!audio_get_pdo_out(s->dev)->mixing_engine) {
> +            /* there is exactly 1 sw for each hw with no mixeng */
> +            sw = hw->sw_head.lh_first;
> +
> +            if (hw->pending_disable) {
> +                hw->enabled = false;
> +                hw->pending_disable = false;
> +                if (hw->pcm_ops->enable_out) {
> +                    hw->pcm_ops->enable_out(hw, false);
> +                }
> +            }
> +
> +            if (sw->active) {
> +                sw->callback.fn(sw->callback.opaque,
> +                                hw_free * sw->info.bytes_per_frame);
> +            }
> +
> +            if (hw->pcm_ops->run_buffer_out) {
> +                hw->pcm_ops->run_buffer_out(hw);
> +            }
> +
> +            continue;
> +        }
> +
> +        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> +            if (sw->active) {
> +                size_t sw_free = audio_get_free(sw);
> +                size_t free;
> +
> +                if (hw_free > sw->total_hw_samples_mixed) {
> +                    free = st_rate_frames_in(sw->rate,
> +                        MIN(sw_free, hw_free - sw->total_hw_samples_mixed));
> +                } else {
> +                    free = 0;
> +                }
> +                if (free > sw->resample_buf.pos) {
> +                    free = MIN(free, sw->resample_buf.size)
> +                           - sw->resample_buf.pos;
> +                    sw->callback.fn(sw->callback.opaque,
> +                                    free * sw->info.bytes_per_frame);
> +                }
> +            }
> +        }
> +
> +        live = audio_pcm_hw_get_live_out (hw, &nb_live);
> +        if (!nb_live) {
> +            live = 0;
> +        }
> +
> +        if (audio_bug(__func__, live > hw->mix_buf.size)) {
> +            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> +            continue;
> +        }
> +
> +        if (hw->pending_disable && !nb_live) {
> +            SWVoiceCap *sc;
> +#ifdef DEBUG_OUT
> +            dolog ("Disabling voice\n");
> +#endif
> +            hw->enabled = false;
> +            hw->pending_disable = false;
> +            if (hw->pcm_ops->enable_out) {
> +                hw->pcm_ops->enable_out(hw, false);
> +            }
> +            for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> +                sc->sw.active = false;
> +                audio_recalc_and_notify_capture (sc->cap);
> +            }
> +            continue;
> +        }
> +
> +        if (!live) {
> +            if (hw->pcm_ops->run_buffer_out) {
> +                hw->pcm_ops->run_buffer_out(hw);
> +            }
> +            continue;
> +        }
> +
> +        prev_rpos = hw->mix_buf.pos;
> +        played = audio_pcm_hw_run_out(hw, live);
> +        replay_audio_out(&played);
> +        if (audio_bug(__func__, hw->mix_buf.pos >= hw->mix_buf.size)) {
> +            dolog("hw->mix_buf.pos=%zu hw->mix_buf.size=%zu played=%zu\n",
> +                  hw->mix_buf.pos, hw->mix_buf.size, played);
> +            hw->mix_buf.pos = 0;
> +        }
> +
> +#ifdef DEBUG_OUT
> +        dolog("played=%zu\n", played);
> +#endif
> +
> +        if (played) {
> +            audio_capture_mix_and_clear (hw, prev_rpos, played);
> +        }
> +
> +        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> +            if (!sw->active && sw->empty) {
> +                continue;
> +            }
> +
> +            if (audio_bug(__func__, played > sw->total_hw_samples_mixed)) {
> +                dolog("played=%zu sw->total_hw_samples_mixed=%zu\n",
> +                      played, sw->total_hw_samples_mixed);
> +                played = sw->total_hw_samples_mixed;
> +            }
> +
> +            sw->total_hw_samples_mixed -= played;
> +
> +            if (!sw->total_hw_samples_mixed) {
> +                sw->empty = true;
> +            }
> +        }
> +    }
> +}
> +
> +static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
> +{
> +    size_t conv = 0;
> +
> +    if (hw->pcm_ops->run_buffer_in) {
> +        hw->pcm_ops->run_buffer_in(hw);
> +    }
> +
> +    while (samples) {
> +        size_t proc;
> +        size_t size = samples * hw->info.bytes_per_frame;
> +        void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
> +
> +        assert(size % hw->info.bytes_per_frame == 0);
> +        if (size == 0) {
> +            break;
> +        }
> +
> +        proc = audio_pcm_hw_conv_in(hw, buf, size / hw->info.bytes_per_frame);
> +
> +        samples -= proc;
> +        conv += proc;
> +        hw->pcm_ops->put_buffer_in(hw, buf, proc * hw->info.bytes_per_frame);
> +    }
> +
> +    return conv;
> +}
> +
> +static void audio_run_in(AudioMixengBackend *s)
> +{
> +    HWVoiceIn *hw = NULL;
> +
> +    if (!audio_get_pdo_in(s->dev)->mixing_engine) {
> +        while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
> +            /* there is exactly 1 sw for each hw with no mixeng */
> +            SWVoiceIn *sw = hw->sw_head.lh_first;
> +            if (sw->active) {
> +                sw->callback.fn(sw->callback.opaque, INT_MAX);
> +            }
> +        }
> +        return;
> +    }
> +
> +    while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
> +        SWVoiceIn *sw;
> +        size_t captured = 0, min;
> +        int pos;
> +
> +        if (replay_mode != REPLAY_MODE_PLAY) {
> +            captured = audio_pcm_hw_run_in(
> +                hw, hw->conv_buf.size - audio_pcm_hw_get_live_in(hw));
> +        }
> +
> +        replay_audio_in_start(&captured);
> +        assert(captured <= hw->conv_buf.size);
> +        if (replay_mode == REPLAY_MODE_PLAY) {
> +            hw->conv_buf.pos = (hw->conv_buf.pos + captured) % hw->conv_buf.size;
> +        }
> +        for (pos = (hw->conv_buf.pos - captured + hw->conv_buf.size) % hw->conv_buf.size;
> +             pos != hw->conv_buf.pos;
> +             pos = (pos + 1) % hw->conv_buf.size) {
> +                uint64_t left, right;
> +
> +                if (replay_mode == REPLAY_MODE_RECORD) {
> +                    audio_sample_to_uint64(hw->conv_buf.buffer, pos, &left, &right);
> +                }
> +                replay_audio_in_sample_lr(&left, &right);
> +                if (replay_mode == REPLAY_MODE_PLAY) {
> +                    audio_sample_from_uint64(hw->conv_buf.buffer, pos, left, right);
> +                }
> +        }
> +        replay_audio_in_finish();
> +
> +        min = audio_pcm_hw_find_min_in (hw);
> +        hw->total_samples_captured += captured - min;
> +
> +        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> +            sw->total_hw_samples_acquired -= min;
> +
> +            if (sw->active) {
> +                size_t sw_avail = audio_get_avail(sw);
> +                size_t avail;
> +
> +                avail = st_rate_frames_out(sw->rate, sw_avail);
> +                if (avail > 0) {
> +                    avail = MIN(avail, sw->resample_buf.size);
> +                    sw->callback.fn(sw->callback.opaque,
> +                                    avail * sw->info.bytes_per_frame);
> +                }
> +            }
> +        }
> +    }
> +}
> +
> +static void audio_run_capture(AudioMixengBackend *s)
> +{
> +    CaptureVoiceOut *cap;
> +
> +    for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
> +        size_t live, rpos, captured;
> +        HWVoiceOut *hw = &cap->hw;
> +        SWVoiceOut *sw;
> +
> +        captured = live = audio_pcm_hw_get_live_out (hw, NULL);
> +        rpos = hw->mix_buf.pos;
> +        while (live) {
> +            size_t left = hw->mix_buf.size - rpos;
> +            size_t to_capture = MIN(live, left);
> +            struct st_sample *src;
> +            struct capture_callback *cb;
> +
> +            src = hw->mix_buf.buffer + rpos;
> +            hw->clip (cap->buf, src, to_capture);
> +            mixeng_clear (src, to_capture);
> +
> +            for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> +                cb->ops.capture (cb->opaque, cap->buf,
> +                                 to_capture * hw->info.bytes_per_frame);
> +            }
> +            rpos = (rpos + to_capture) % hw->mix_buf.size;
> +            live -= to_capture;
> +        }
> +        hw->mix_buf.pos = rpos;
> +
> +        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> +            if (!sw->active && sw->empty) {
> +                continue;
> +            }
> +
> +            if (audio_bug(__func__, captured > sw->total_hw_samples_mixed)) {
> +                dolog("captured=%zu sw->total_hw_samples_mixed=%zu\n",
> +                      captured, sw->total_hw_samples_mixed);
> +                captured = sw->total_hw_samples_mixed;
> +            }
> +
> +            sw->total_hw_samples_mixed -= captured;
> +            sw->empty = sw->total_hw_samples_mixed == 0;
> +        }
> +    }
> +}
> +
> +void audio_run(AudioMixengBackend *s, const char *msg)
> +{
> +    audio_run_out(s);
> +    audio_run_in(s);
> +    audio_run_capture(s);
> +
> +#ifdef DEBUG_POLL
> +    {
> +        static double prevtime;
> +        double currtime;
> +        struct timeval tv;
> +
> +        if (gettimeofday (&tv, NULL)) {
> +            perror ("audio_run: gettimeofday");
> +            return;
> +        }
> +
> +        currtime = tv.tv_sec + tv.tv_usec * 1e-6;
> +        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime);
> +        prevtime = currtime;
> +    }
> +#endif
> +}
> +
> +void audio_generic_run_buffer_in(HWVoiceIn *hw)
> +{
> +    if (unlikely(!hw->buf_emul)) {
> +        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> +        hw->buf_emul = g_malloc(hw->size_emul);
> +        hw->pos_emul = hw->pending_emul = 0;
> +    }
> +
> +    while (hw->pending_emul < hw->size_emul) {
> +        size_t read_len = MIN(hw->size_emul - hw->pos_emul,
> +                              hw->size_emul - hw->pending_emul);
> +        size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
> +                                        read_len);
> +        hw->pending_emul += read;
> +        hw->pos_emul = (hw->pos_emul + read) % hw->size_emul;
> +        if (read < read_len) {
> +            break;
> +        }
> +    }
> +}
> +
> +void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
> +{
> +    size_t start;
> +
> +    start = audio_ring_posb(hw->pos_emul, hw->pending_emul, hw->size_emul);
> +    assert(start < hw->size_emul);
> +
> +    *size = MIN(*size, hw->pending_emul);
> +    *size = MIN(*size, hw->size_emul - start);
> +    return hw->buf_emul + start;
> +}
> +
> +void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
> +{
> +    assert(size <= hw->pending_emul);
> +    hw->pending_emul -= size;
> +}
> +
> +size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
> +{
> +    if (hw->buf_emul) {
> +        return hw->size_emul - hw->pending_emul;
> +    } else {
> +        return hw->samples * hw->info.bytes_per_frame;
> +    }
> +}
> +
> +void audio_generic_run_buffer_out(HWVoiceOut *hw)
> +{
> +    while (hw->pending_emul) {
> +        size_t write_len, written, start;
> +
> +        start = audio_ring_posb(hw->pos_emul, hw->pending_emul, hw->size_emul);
> +        assert(start < hw->size_emul);
> +
> +        write_len = MIN(hw->pending_emul, hw->size_emul - start);
> +
> +        written = hw->pcm_ops->write(hw, hw->buf_emul + start, write_len);
> +        hw->pending_emul -= written;
> +
> +        if (written < write_len) {
> +            break;
> +        }
> +    }
> +}
> +
> +void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
> +{
> +    if (unlikely(!hw->buf_emul)) {
> +        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> +        hw->buf_emul = g_malloc(hw->size_emul);
> +        hw->pos_emul = hw->pending_emul = 0;
> +    }
> +
> +    *size = MIN(hw->size_emul - hw->pending_emul,
> +                hw->size_emul - hw->pos_emul);
> +    return hw->buf_emul + hw->pos_emul;
> +}
> +
> +size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
> +{
> +    assert(buf == hw->buf_emul + hw->pos_emul &&
> +           size + hw->pending_emul <= hw->size_emul);
> +
> +    hw->pending_emul += size;
> +    hw->pos_emul = (hw->pos_emul + size) % hw->size_emul;
> +
> +    return size;
> +}
> +
> +size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
> +{
> +    size_t total = 0;
> +
> +    if (hw->pcm_ops->buffer_get_free) {
> +        size_t free = hw->pcm_ops->buffer_get_free(hw);
> +
> +        size = MIN(size, free);
> +    }
> +
> +    while (total < size) {
> +        size_t dst_size = size - total;
> +        size_t copy_size, proc;
> +        void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
> +
> +        if (dst_size == 0) {
> +            break;
> +        }
> +
> +        copy_size = MIN(size - total, dst_size);
> +        if (dst) {
> +            memcpy(dst, (char *)buf + total, copy_size);
> +        }
> +        proc = hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
> +        total += proc;
> +
> +        if (proc == 0 || proc < copy_size) {
> +            break;
> +        }
> +    }
> +
> +    return total;
> +}
> +
> +size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
> +{
> +    size_t total = 0;
> +
> +    if (hw->pcm_ops->run_buffer_in) {
> +        hw->pcm_ops->run_buffer_in(hw);
> +    }
> +
> +    while (total < size) {
> +        size_t src_size = size - total;
> +        void *src = hw->pcm_ops->get_buffer_in(hw, &src_size);
> +
> +        if (src_size == 0) {
> +            break;
> +        }
> +
> +        memcpy((char *)buf + total, src, src_size);
> +        hw->pcm_ops->put_buffer_in(hw, src, src_size);
> +        total += src_size;
> +    }
> +
> +    return total;
> +}
> +
> +static bool audio_mixeng_backend_realize(AudioBackend *abe,
> +                                         Audiodev *dev, Error **errp)
> +{
> +    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
> +    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
> +
> +    be->dev = dev;
> +    be->drv_opaque = drv->init(be->dev, errp);
> +    if (!be->drv_opaque) {
> +        return false;
> +    }
> +
> +    if (!drv->pcm_ops->get_buffer_in) {
> +        drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
> +        drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
> +    }
> +    if (!drv->pcm_ops->get_buffer_out) {
> +        drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
> +        drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
> +    }
> +
> +    audio_init_nb_voices_out(be, drv, 1);
> +    audio_init_nb_voices_in(be, drv, 0);
> +    be->drv = drv;
> +
> +    if (be->dev->timer_period <= 0) {
> +        be->period_ticks = 1;
> +    } else {
> +        be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
> +    }
> +
> +    return true;
> +}
> +
> +static void audio_vm_change_state_handler (void *opaque, bool running,
> +                                           RunState state)
> +{
> +    AudioMixengBackend *s = opaque;
> +    HWVoiceOut *hwo = NULL;
> +    HWVoiceIn *hwi = NULL;
> +
> +    while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
> +        if (hwo->pcm_ops->enable_out) {
> +            hwo->pcm_ops->enable_out(hwo, running);
> +        }
> +    }
> +
> +    while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
> +        if (hwi->pcm_ops->enable_in) {
> +            hwi->pcm_ops->enable_in(hwi, running);
> +        }
> +    }
> +    audio_reset_timer (s);
> +}
> +
> +static const VMStateDescription vmstate_audio;
> +
> +static const char *audio_mixeng_backend_get_id(AudioBackend *be)
> +{
> +    return AUDIO_MIXENG_BACKEND(be)->dev->id;
> +}
> +
> +static CaptureVoiceOut *audio_mixeng_backend_add_capture(
> +    AudioBackend *be,
> +    struct audsettings *as,
> +    struct audio_capture_ops *ops,
> +    void *cb_opaque);
> +
> +static void audio_mixeng_backend_del_capture(
> +    AudioBackend *be,
> +    CaptureVoiceOut *cap,
> +    void *cb_opaque);
> +
> +static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
> +                                                Volume *vol);
> +static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
> +                                               Volume *vol);
> +
> +static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
> +
> +    be->realize = audio_mixeng_backend_realize;
> +    be->get_id = audio_mixeng_backend_get_id;
> +    be->open_in = audio_mixeng_backend_open_in;
> +    be->open_out = audio_mixeng_backend_open_out;
> +    be->close_in = audio_mixeng_backend_close_in;
> +    be->close_out = audio_mixeng_backend_close_out;
> +    be->is_active_out = audio_mixeng_backend_is_active_out;
> +    be->is_active_in = audio_mixeng_backend_is_active_in;
> +    be->set_active_out = audio_mixeng_backend_set_active_out;
> +    be->set_active_in = audio_mixeng_backend_set_active_in;
> +    be->set_volume_out = audio_mixeng_backend_set_volume_out;
> +    be->set_volume_in = audio_mixeng_backend_set_volume_in;
> +    be->read = audio_mixeng_backend_read;
> +    be->write = audio_mixeng_backend_write;
> +    be->get_buffer_size_out = audio_mixeng_backend_get_buffer_size_out;
> +    be->add_capture = audio_mixeng_backend_add_capture;
> +    be->del_capture = audio_mixeng_backend_del_capture;
> +}
> +
> +static void audio_mixeng_backend_init(Object *obj)
> +{
> +    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
> +
> +    QLIST_INIT(&s->hw_head_out);
> +    QLIST_INIT(&s->hw_head_in);
> +    QLIST_INIT(&s->cap_head);
> +    s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
> +
> +    s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
> +    assert(s->vmse != NULL);
> +
> +    vmstate_register_any(NULL, &vmstate_audio, s);
> +}
> +
> +static void audio_mixeng_backend_finalize(Object *obj)
> +{
> +    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
> +    HWVoiceOut *hwo, *hwon;
> +    HWVoiceIn *hwi, *hwin;
> +
> +    QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
> +        SWVoiceCap *sc;
> +
> +        if (hwo->enabled && hwo->pcm_ops->enable_out) {
> +            hwo->pcm_ops->enable_out(hwo, false);
> +        }
> +        hwo->pcm_ops->fini_out (hwo);
> +
> +        for (sc = hwo->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> +            CaptureVoiceOut *cap = sc->cap;
> +            struct capture_callback *cb;
> +
> +            for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> +                cb->ops.destroy (cb->opaque);
> +            }
> +        }
> +        QLIST_REMOVE(hwo, entries);
> +    }
> +
> +    QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
> +        if (hwi->enabled && hwi->pcm_ops->enable_in) {
> +            hwi->pcm_ops->enable_in(hwi, false);
> +        }
> +        hwi->pcm_ops->fini_in (hwi);
> +        QLIST_REMOVE(hwi, entries);
> +    }
> +
> +    if (s->drv) {
> +        s->drv->fini (s->drv_opaque);
> +        s->drv = NULL;
> +    }
> +
> +    if (s->dev) {
> +        qapi_free_Audiodev(s->dev);
> +        s->dev = NULL;
> +    }
> +
> +    if (s->ts) {
> +        timer_free(s->ts);
> +        s->ts = NULL;
> +    }
> +
> +    if (s->vmse) {
> +        qemu_del_vm_change_state_handler(s->vmse);
> +        s->vmse = NULL;
> +    }
> +
> +    vmstate_unregister(NULL, &vmstate_audio, s);
> +}
> +
> +static bool vmstate_audio_needed(void *opaque)
> +{
> +    /*
> +     * Never needed, this vmstate only exists in case
> +     * an old qemu sends it to us.
> +     */
> +    return false;
> +}
> +
> +static const VMStateDescription vmstate_audio = {
> +    .name = "audio",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = vmstate_audio_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static struct audio_pcm_ops capture_pcm_ops;
> +
> +static CaptureVoiceOut *audio_mixeng_backend_add_capture(
> +    AudioBackend *be,
> +    struct audsettings *as,
> +    struct audio_capture_ops *ops,
> +    void *cb_opaque)
> +{
> +    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
> +    CaptureVoiceOut *cap;
> +    struct capture_callback *cb;
> +
> +    if (!s) {
> +        error_report("Capturing without setting an audiodev is not supported");
> +        abort();
> +    }
> +
> +    if (!audio_get_pdo_out(s->dev)->mixing_engine) {
> +        dolog("Can't capture with mixeng disabled\n");
> +        return NULL;
> +    }
> +
> +    if (audio_validate_settings (as)) {
> +        dolog ("Invalid settings were passed when trying to add capture\n");
> +        audio_print_settings (as);
> +        return NULL;
> +    }
> +
> +    cb = g_malloc0(sizeof(*cb));
> +    cb->ops = *ops;
> +    cb->opaque = cb_opaque;
> +
> +    cap = audio_pcm_capture_find_specific(s, as);
> +    if (cap) {
> +        QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
> +    } else {
> +        HWVoiceOut *hw;
> +
> +        cap = g_malloc0(sizeof(*cap));
> +
> +        hw = &cap->hw;
> +        hw->s = s;
> +        hw->pcm_ops = &capture_pcm_ops;
> +        QLIST_INIT (&hw->sw_head);
> +        QLIST_INIT (&cap->cb_head);
> +
> +        /* XXX find a more elegant way */
> +        hw->samples = 4096 * 4;
> +        audio_pcm_hw_alloc_resources_out(hw);
> +
> +        audio_pcm_init_info (&hw->info, as);
> +
> +        cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);
> +
> +        if (hw->info.is_float) {
> +            hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
> +                [hw->info.swap_endianness];
> +        } else {
> +            hw->clip = mixeng_clip
> +                [hw->info.nchannels == 2]
> +                [hw->info.is_signed]
> +                [hw->info.swap_endianness]
> +                [audio_bits_to_index(hw->info.bits)];
> +        }
> +
> +        QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
> +        QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
> +
> +        QLIST_FOREACH(hw, &s->hw_head_out, entries) {
> +            audio_attach_capture (hw);
> +        }
> +    }
> +
> +    return cap;
> +}
> +
> +static void audio_mixeng_backend_del_capture(
> +    AudioBackend *be,
> +    CaptureVoiceOut *cap,
> +    void *cb_opaque)
> +{
> +    struct capture_callback *cb;
> +
> +    for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> +        if (cb->opaque == cb_opaque) {
> +            cb->ops.destroy (cb_opaque);
> +            QLIST_REMOVE (cb, entries);
> +            g_free (cb);
> +
> +            if (!cap->cb_head.lh_first) {
> +                SWVoiceOut *sw = cap->hw.sw_head.lh_first, *sw1;
> +
> +                while (sw) {
> +                    SWVoiceCap *sc = (SWVoiceCap *) sw;
> +#ifdef DEBUG_CAPTURE
> +                    dolog ("freeing %s\n", sw->name);
> +#endif
> +
> +                    sw1 = sw->entries.le_next;
> +                    if (sw->rate) {
> +                        st_rate_stop (sw->rate);
> +                        sw->rate = NULL;
> +                    }
> +                    QLIST_REMOVE (sw, entries);
> +                    QLIST_REMOVE (sc, entries);
> +                    g_free (sc);
> +                    sw = sw1;
> +                }
> +                QLIST_REMOVE (cap, entries);
> +                g_free(cap->hw.mix_buf.buffer);
> +                g_free (cap->buf);
> +                g_free (cap);
> +            }
> +            return;
> +        }
> +    }
> +}
> +
> +static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
> +                                                Volume *vol)
> +{
> +    if (sw) {
> +        HWVoiceOut *hw = sw->hw;
> +
> +        sw->vol.mute = vol->mute;
> +        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
> +        sw->vol.r = nominal_volume.l * vol->vol[vol->channels > 1 ? 1 : 0] /
> +            255;
> +
> +        if (hw->pcm_ops->volume_out) {
> +            hw->pcm_ops->volume_out(hw, vol);
> +        }
> +    }
> +}
> +
> +static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
> +                                               Volume *vol)
> +{
> +    if (sw) {
> +        HWVoiceIn *hw = sw->hw;
> +
> +        sw->vol.mute = vol->mute;
> +        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
> +        sw->vol.r = nominal_volume.r * vol->vol[vol->channels > 1 ? 1 : 0] /
> +            255;
> +
> +        if (hw->pcm_ops->volume_in) {
> +            hw->pcm_ops->volume_in(hw, vol);
> +        }
> +    }
> +}
> +
> +audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
> +{
> +    return (audsettings) {
> +        .freq = pdo->frequency,
> +        .nchannels = pdo->channels,
> +        .fmt = pdo->format,
> +        .endianness = HOST_BIG_ENDIAN,
> +    };
> +}
> +
> +int audioformat_bytes_per_sample(AudioFormat fmt)
> +{
> +    switch (fmt) {
> +    case AUDIO_FORMAT_U8:
> +    case AUDIO_FORMAT_S8:
> +        return 1;
> +
> +    case AUDIO_FORMAT_U16:
> +    case AUDIO_FORMAT_S16:
> +        return 2;
> +
> +    case AUDIO_FORMAT_U32:
> +    case AUDIO_FORMAT_S32:
> +    case AUDIO_FORMAT_F32:
> +        return 4;
> +
> +    case AUDIO_FORMAT__MAX:
> +        ;
> +    }
> +    abort();
> +}
> +
> +
> +/* frames = freq * usec / 1e6 */
> +int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
> +                        audsettings *as, int def_usecs)
> +{
> +    uint64_t usecs = pdo->has_buffer_length ? pdo->buffer_length : def_usecs;
> +    return (as->freq * usecs + 500000) / 1000000;
> +}
> +
> +/* samples = channels * frames = channels * freq * usec / 1e6 */
> +int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
> +                         audsettings *as, int def_usecs)
> +{
> +    return as->nchannels * audio_buffer_frames(pdo, as, def_usecs);
> +}
> +
> +/*
> + * bytes = bytes_per_sample * samples =
> + *     bytes_per_sample * channels * freq * usec / 1e6
> + */
> +int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
> +                       audsettings *as, int def_usecs)
> +{
> +    return audio_buffer_samples(pdo, as, def_usecs) *
> +        audioformat_bytes_per_sample(as->fmt);
> +}
> +
> +void audio_rate_start(RateCtl *rate)
> +{
> +    memset(rate, 0, sizeof(RateCtl));
> +    rate->start_ticks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +}
> +
> +size_t audio_rate_peek_bytes(RateCtl *rate, struct audio_pcm_info *info)
> +{
> +    int64_t now;
> +    int64_t ticks;
> +    int64_t bytes;
> +    int64_t frames;
> +
> +    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    ticks = now - rate->start_ticks;
> +    bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
> +    frames = (bytes - rate->bytes_sent) / info->bytes_per_frame;
> +    rate->peeked_frames = frames;
> +
> +    return frames < 0 ? 0 : frames * info->bytes_per_frame;
> +}
> +
> +void audio_rate_add_bytes(RateCtl *rate, size_t bytes_used)
> +{
> +    if (rate->peeked_frames < 0 || rate->peeked_frames > 65536) {
> +        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n",
> +                rate->peeked_frames);
> +        audio_rate_start(rate);
> +    }
> +
> +    rate->bytes_sent += bytes_used;
> +}
> +
> +size_t audio_rate_get_bytes(RateCtl *rate, struct audio_pcm_info *info,
> +                            size_t bytes_avail)
> +{
> +    size_t bytes;
> +
> +    bytes = audio_rate_peek_bytes(rate, info);
> +    bytes = MIN(bytes, bytes_avail);
> +    audio_rate_add_bytes(rate, bytes);
> +
> +    return bytes;
> +}
> +
> +static const TypeInfo audio_mixeng_backend_info = {
> +    .name = TYPE_AUDIO_MIXENG_BACKEND,
> +    .parent = TYPE_AUDIO_BACKEND,
> +    .instance_size = sizeof(AudioMixengBackend),
> +    .instance_init = audio_mixeng_backend_init,
> +    .instance_finalize = audio_mixeng_backend_finalize,
> +    .abstract = false,
> +    .class_size = sizeof(AudioMixengBackendClass),
> +    .class_init = audio_mixeng_backend_class_init,
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&audio_mixeng_backend_info);
> +}
> +
> +type_init(register_types);
> diff --git a/audio/audio.c b/audio/audio.c
> index 1d948084e80..6f10ee470ee 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1,1750 +1,55 @@
> -/*
> - * QEMU Audio subsystem
> - *
> - * Copyright (c) 2003-2005 Vassili Karpov (malc)
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "qemu/audio.h"
> -#include "migration/vmstate.h"
> -#include "qemu/timer.h"
> -#include "qapi/error.h"
> -#include "qapi/clone-visitor.h"
> -#include "qapi/qobject-input-visitor.h"
> -#include "qapi/qapi-visit-audio.h"
> -#include "qapi/qapi-commands-audio.h"
> -#include "qobject/qdict.h"
> -#include "qemu/error-report.h"
> -#include "qemu/log.h"
> -#include "qemu/module.h"
> -#include "qemu/help_option.h"
> -#include "qom/object.h"
> -#include "system/system.h"
> -#include "system/replay.h"
> -#include "system/runstate.h"
> -#include "trace.h"
> -
> -#define AUDIO_CAP "audio"
> -#include "audio_int.h"
> -
> -/* #define DEBUG_LIVE */
> -/* #define DEBUG_OUT */
> -/* #define DEBUG_CAPTURE */
> -/* #define DEBUG_POLL */
> -
> -#define SW_NAME(sw) (sw)->name ? (sw)->name : "unknown"
> -
> -
> -/* Order of CONFIG_AUDIO_DRIVERS is import.
> -   The 1st one is the one used by default, that is the reason
> -    that we generate the list.
> -*/
> -const char *audio_prio_list[] = {
> -#ifdef CONFIG_GIO
> -    "dbus",
> -#endif
> -    "spice",
> -    CONFIG_AUDIO_DRIVERS
> -    "none",
> -    NULL
> -};
> -
> -typedef struct AudiodevListEntry {
> -    Audiodev *dev;
> -    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
> -} AudiodevListEntry;
> -
> -typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
> -
> -static AudiodevListHead audiodevs =
> -    QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
> -static AudiodevListHead default_audiodevs =
> -    QSIMPLEQ_HEAD_INITIALIZER(default_audiodevs);
> -
> -static AudioBackendClass *audio_be_class_by_name(const char *name)
> -{
> -    g_autofree char *tname = g_strconcat("audio-", name, NULL);
> -    ObjectClass *oc = module_object_class_by_name(tname);
> -
> -    if (!oc || !object_class_dynamic_cast(oc, TYPE_AUDIO_BACKEND)) {
> -        return NULL;
> -    }
> -
> -    return AUDIO_BACKEND_CLASS(oc);
> -}
> -
> -static AudioBackend *default_audio_be;
> -
> -const struct mixeng_volume nominal_volume = {
> -    .mute = 0,
> -#ifdef FLOAT_MIXENG
> -    .r = 1.0,
> -    .l = 1.0,
> -#else
> -    .r = 1ULL << 32,
> -    .l = 1ULL << 32,
> -#endif
> -};
> -
> -int audio_bug (const char *funcname, int cond)
> -{
> -    if (cond) {
> -        static int shown;
> -
> -        AUD_log (NULL, "A bug was just triggered in %s\n", funcname);
> -        if (!shown) {
> -            shown = 1;
> -            AUD_log (NULL, "Save all your work and restart without audio\n");
> -            AUD_log (NULL, "I am sorry\n");
> -        }
> -        AUD_log (NULL, "Context:\n");
> -    }
> -
> -    return cond;
> -}
> -
> -static inline int audio_bits_to_index (int bits)
> -{
> -    switch (bits) {
> -    case 8:
> -        return 0;
> -
> -    case 16:
> -        return 1;
> -
> -    case 32:
> -        return 2;
> -
> -    default:
> -        audio_bug ("bits_to_index", 1);
> -        AUD_log (NULL, "invalid bits %d\n", bits);
> -        return 0;
> -    }
> -}
> -
> -void AUD_vlog (const char *cap, const char *fmt, va_list ap)
> -{
> -    if (cap) {
> -        fprintf(stderr, "%s: ", cap);
> -    }
> -
> -    vfprintf(stderr, fmt, ap);
> -}
> -
> -void AUD_log (const char *cap, const char *fmt, ...)
> -{
> -    va_list ap;
> -
> -    va_start (ap, fmt);
> -    AUD_vlog (cap, fmt, ap);
> -    va_end (ap);
> -}
> -
> -static void audio_print_settings (const struct audsettings *as)
> -{
> -    dolog ("frequency=%d nchannels=%d fmt=", as->freq, as->nchannels);
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        AUD_log (NULL, "S8");
> -        break;
> -    case AUDIO_FORMAT_U8:
> -        AUD_log (NULL, "U8");
> -        break;
> -    case AUDIO_FORMAT_S16:
> -        AUD_log (NULL, "S16");
> -        break;
> -    case AUDIO_FORMAT_U16:
> -        AUD_log (NULL, "U16");
> -        break;
> -    case AUDIO_FORMAT_S32:
> -        AUD_log (NULL, "S32");
> -        break;
> -    case AUDIO_FORMAT_U32:
> -        AUD_log (NULL, "U32");
> -        break;
> -    case AUDIO_FORMAT_F32:
> -        AUD_log (NULL, "F32");
> -        break;
> -    default:
> -        AUD_log (NULL, "invalid(%d)", as->fmt);
> -        break;
> -    }
> -
> -    AUD_log (NULL, " endianness=");
> -    switch (as->endianness) {
> -    case 0:
> -        AUD_log (NULL, "little");
> -        break;
> -    case 1:
> -        AUD_log (NULL, "big");
> -        break;
> -    default:
> -        AUD_log (NULL, "invalid");
> -        break;
> -    }
> -    AUD_log (NULL, "\n");
> -}
> -
> -static int audio_validate_settings (const struct audsettings *as)
> -{
> -    int invalid;
> -
> -    invalid = as->nchannels < 1;
> -    invalid |= as->endianness != 0 && as->endianness != 1;
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -    case AUDIO_FORMAT_U8:
> -    case AUDIO_FORMAT_S16:
> -    case AUDIO_FORMAT_U16:
> -    case AUDIO_FORMAT_S32:
> -    case AUDIO_FORMAT_U32:
> -    case AUDIO_FORMAT_F32:
> -        break;
> -    default:
> -        invalid = 1;
> -        break;
> -    }
> -
> -    invalid |= as->freq <= 0;
> -    return invalid ? -1 : 0;
> -}
> -
> -static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
> -{
> -    int bits = 8;
> -    bool is_signed = false, is_float = false;
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U8:
> -        break;
> -
> -    case AUDIO_FORMAT_S16:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U16:
> -        bits = 16;
> -        break;
> -
> -    case AUDIO_FORMAT_F32:
> -        is_float = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_S32:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U32:
> -        bits = 32;
> -        break;
> -
> -    default:
> -        abort();
> -    }
> -    return info->freq == as->freq
> -        && info->nchannels == as->nchannels
> -        && info->is_signed == is_signed
> -        && info->is_float == is_float
> -        && info->bits == bits
> -        && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
> -}
> -
> -void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
> -{
> -    int bits = 8, mul;
> -    bool is_signed = false, is_float = false;
> -
> -    switch (as->fmt) {
> -    case AUDIO_FORMAT_S8:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U8:
> -        mul = 1;
> -        break;
> -
> -    case AUDIO_FORMAT_S16:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U16:
> -        bits = 16;
> -        mul = 2;
> -        break;
> -
> -    case AUDIO_FORMAT_F32:
> -        is_float = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_S32:
> -        is_signed = true;
> -        /* fall through */
> -    case AUDIO_FORMAT_U32:
> -        bits = 32;
> -        mul = 4;
> -        break;
> -
> -    default:
> -        abort();
> -    }
> -
> -    info->freq = as->freq;
> -    info->bits = bits;
> -    info->is_signed = is_signed;
> -    info->is_float = is_float;
> -    info->nchannels = as->nchannels;
> -    info->bytes_per_frame = as->nchannels * mul;
> -    info->bytes_per_second = info->freq * info->bytes_per_frame;
> -    info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
> -}
> -
> -void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
> -{
> -    if (!len) {
> -        return;
> -    }
> -
> -    if (info->is_signed || info->is_float) {
> -        memset(buf, 0x00, len * info->bytes_per_frame);
> -    } else {
> -        switch (info->bits) {
> -        case 8:
> -            memset(buf, 0x80, len * info->bytes_per_frame);
> -            break;
> -
> -        case 16:
> -            {
> -                int i;
> -                uint16_t *p = buf;
> -                short s = INT16_MAX;
> -
> -                if (info->swap_endianness) {
> -                    s = bswap16 (s);
> -                }
> -
> -                for (i = 0; i < len * info->nchannels; i++) {
> -                    p[i] = s;
> -                }
> -            }
> -            break;
> -
> -        case 32:
> -            {
> -                int i;
> -                uint32_t *p = buf;
> -                int32_t s = INT32_MAX;
> -
> -                if (info->swap_endianness) {
> -                    s = bswap32 (s);
> -                }
> -
> -                for (i = 0; i < len * info->nchannels; i++) {
> -                    p[i] = s;
> -                }
> -            }
> -            break;
> -
> -        default:
> -            AUD_log (NULL, "audio_pcm_info_clear_buf: invalid bits %d\n",
> -                     info->bits);
> -            break;
> -        }
> -    }
> -}
> -
> -/*
> - * Capture
> - */
> -static CaptureVoiceOut *audio_pcm_capture_find_specific(AudioMixengBackend *s,
> -                                                        struct audsettings *as)
> -{
> -    CaptureVoiceOut *cap;
> -
> -    for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
> -        if (audio_pcm_info_eq (&cap->hw.info, as)) {
> -            return cap;
> -        }
> -    }
> -    return NULL;
> -}
> -
> -static void audio_notify_capture (CaptureVoiceOut *cap, audcnotification_e cmd)
> -{
> -    struct capture_callback *cb;
> -
> -#ifdef DEBUG_CAPTURE
> -    dolog ("notification %d sent\n", cmd);
> -#endif
> -    for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> -        cb->ops.notify (cb->opaque, cmd);
> -    }
> -}
> -
> -static void audio_capture_maybe_changed(CaptureVoiceOut *cap, bool enabled)
> -{
> -    if (cap->hw.enabled != enabled) {
> -        audcnotification_e cmd;
> -        cap->hw.enabled = enabled;
> -        cmd = enabled ? AUD_CNOTIFY_ENABLE : AUD_CNOTIFY_DISABLE;
> -        audio_notify_capture (cap, cmd);
> -    }
> -}
> -
> -static void audio_recalc_and_notify_capture (CaptureVoiceOut *cap)
> -{
> -    HWVoiceOut *hw = &cap->hw;
> -    SWVoiceOut *sw;
> -    bool enabled = false;
> -
> -    for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> -        if (sw->active) {
> -            enabled = true;
> -            break;
> -        }
> -    }
> -    audio_capture_maybe_changed (cap, enabled);
> -}
> -
> -static void audio_detach_capture (HWVoiceOut *hw)
> -{
> -    SWVoiceCap *sc = hw->cap_head.lh_first;
> -
> -    while (sc) {
> -        SWVoiceCap *sc1 = sc->entries.le_next;
> -        SWVoiceOut *sw = &sc->sw;
> -        CaptureVoiceOut *cap = sc->cap;
> -        int was_active = sw->active;
> -
> -        if (sw->rate) {
> -            st_rate_stop (sw->rate);
> -            sw->rate = NULL;
> -        }
> -
> -        QLIST_REMOVE (sw, entries);
> -        QLIST_REMOVE (sc, entries);
> -        g_free (sc);
> -        if (was_active) {
> -            /* We have removed soft voice from the capture:
> -               this might have changed the overall status of the capture
> -               since this might have been the only active voice */
> -            audio_recalc_and_notify_capture (cap);
> -        }
> -        sc = sc1;
> -    }
> -}
> -
> -static int audio_attach_capture (HWVoiceOut *hw)
> -{
> -    AudioMixengBackend *s = hw->s;
> -    CaptureVoiceOut *cap;
> -
> -    audio_detach_capture (hw);
> -    for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
> -        SWVoiceCap *sc;
> -        SWVoiceOut *sw;
> -        HWVoiceOut *hw_cap = &cap->hw;
> -
> -        sc = g_malloc0(sizeof(*sc));
> -
> -        sc->cap = cap;
> -        sw = &sc->sw;
> -        sw->hw = hw_cap;
> -        sw->info = hw->info;
> -        sw->empty = true;
> -        sw->active = hw->enabled;
> -        sw->vol = nominal_volume;
> -        sw->rate = st_rate_start (sw->info.freq, hw_cap->info.freq);
> -        QLIST_INSERT_HEAD (&hw_cap->sw_head, sw, entries);
> -        QLIST_INSERT_HEAD (&hw->cap_head, sc, entries);
> -#ifdef DEBUG_CAPTURE
> -        sw->name = g_strdup_printf ("for %p %d,%d,%d",
> -                                    hw, sw->info.freq, sw->info.bits,
> -                                    sw->info.nchannels);
> -        dolog ("Added %s active = %d\n", sw->name, sw->active);
> -#endif
> -        if (sw->active) {
> -            audio_capture_maybe_changed (cap, 1);
> -        }
> -    }
> -    return 0;
> -}
> -
> -/*
> - * Hard voice (capture)
> - */
> -static size_t audio_pcm_hw_find_min_in (HWVoiceIn *hw)
> -{
> -    SWVoiceIn *sw;
> -    size_t m = hw->total_samples_captured;
> -
> -    for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> -        if (sw->active) {
> -            m = MIN (m, sw->total_hw_samples_acquired);
> -        }
> -    }
> -    return m;
> -}
> -
> -static size_t audio_pcm_hw_get_live_in(HWVoiceIn *hw)
> -{
> -    size_t live = hw->total_samples_captured - audio_pcm_hw_find_min_in (hw);
> -    if (audio_bug(__func__, live > hw->conv_buf.size)) {
> -        dolog("live=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
> -        return 0;
> -    }
> -    return live;
> -}
> -
> -static size_t audio_pcm_hw_conv_in(HWVoiceIn *hw, void *pcm_buf, size_t samples)
> -{
> -    size_t conv = 0;
> -    STSampleBuffer *conv_buf = &hw->conv_buf;
> -
> -    while (samples) {
> -        uint8_t *src = advance(pcm_buf, conv * hw->info.bytes_per_frame);
> -        size_t proc = MIN(samples, conv_buf->size - conv_buf->pos);
> -
> -        hw->conv(conv_buf->buffer + conv_buf->pos, src, proc);
> -        conv_buf->pos = (conv_buf->pos + proc) % conv_buf->size;
> -        samples -= proc;
> -        conv += proc;
> -    }
> -
> -    return conv;
> -}
> -
> -/*
> - * Soft voice (capture)
> - */
> -static void audio_pcm_sw_resample_in(SWVoiceIn *sw,
> -    size_t frames_in_max, size_t frames_out_max,
> -    size_t *total_in, size_t *total_out)
> -{
> -    HWVoiceIn *hw = sw->hw;
> -    struct st_sample *src, *dst;
> -    size_t live, rpos, frames_in, frames_out;
> -
> -    live = hw->total_samples_captured - sw->total_hw_samples_acquired;
> -    rpos = audio_ring_posb(hw->conv_buf.pos, live, hw->conv_buf.size);
> -
> -    /* resample conv_buf from rpos to end of buffer */
> -    src = hw->conv_buf.buffer + rpos;
> -    frames_in = MIN(frames_in_max, hw->conv_buf.size - rpos);
> -    dst = sw->resample_buf.buffer;
> -    frames_out = frames_out_max;
> -    st_rate_flow(sw->rate, src, dst, &frames_in, &frames_out);
> -    rpos += frames_in;
> -    *total_in = frames_in;
> -    *total_out = frames_out;
> -
> -    /* resample conv_buf from start of buffer if there are input frames left */
> -    if (frames_in_max - frames_in && rpos == hw->conv_buf.size) {
> -        src = hw->conv_buf.buffer;
> -        frames_in = frames_in_max - frames_in;
> -        dst += frames_out;
> -        frames_out = frames_out_max - frames_out;
> -        st_rate_flow(sw->rate, src, dst, &frames_in, &frames_out);
> -        *total_in += frames_in;
> -        *total_out += frames_out;
> -    }
> -}
> -
> -static size_t audio_pcm_sw_read(SWVoiceIn *sw, void *buf, size_t buf_len)
> -{
> -    HWVoiceIn *hw = sw->hw;
> -    size_t live, frames_out_max, total_in, total_out;
> -
> -    live = hw->total_samples_captured - sw->total_hw_samples_acquired;
> -    if (!live) {
> -        return 0;
> -    }
> -    if (audio_bug(__func__, live > hw->conv_buf.size)) {
> -        dolog("live_in=%zu hw->conv_buf.size=%zu\n", live, hw->conv_buf.size);
> -        return 0;
> -    }
> -
> -    frames_out_max = MIN(buf_len / sw->info.bytes_per_frame,
> -                         sw->resample_buf.size);
> -
> -    audio_pcm_sw_resample_in(sw, live, frames_out_max, &total_in, &total_out);
> -
> -    if (!hw->pcm_ops->volume_in) {
> -        mixeng_volume(sw->resample_buf.buffer, total_out, &sw->vol);
> -    }
> -    sw->clip(buf, sw->resample_buf.buffer, total_out);
> -
> -    sw->total_hw_samples_acquired += total_in;
> -    return total_out * sw->info.bytes_per_frame;
> -}
> -
> -/*
> - * Hard voice (playback)
> - */
> -static size_t audio_pcm_hw_find_min_out (HWVoiceOut *hw, int *nb_livep)
> -{
> -    SWVoiceOut *sw;
> -    size_t m = SIZE_MAX;
> -    int nb_live = 0;
> -
> -    for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> -        if (sw->active || !sw->empty) {
> -            m = MIN (m, sw->total_hw_samples_mixed);
> -            nb_live += 1;
> -        }
> -    }
> -
> -    *nb_livep = nb_live;
> -    return m;
> -}
> -
> -static size_t audio_pcm_hw_get_live_out (HWVoiceOut *hw, int *nb_live)
> -{
> -    size_t smin;
> -    int nb_live1;
> -
> -    smin = audio_pcm_hw_find_min_out (hw, &nb_live1);
> -    if (nb_live) {
> -        *nb_live = nb_live1;
> -    }
> -
> -    if (nb_live1) {
> -        size_t live = smin;
> -
> -        if (audio_bug(__func__, live > hw->mix_buf.size)) {
> -            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> -            return 0;
> -        }
> -        return live;
> -    }
> -    return 0;
> -}
> -
> -static size_t audio_pcm_hw_get_free(HWVoiceOut *hw)
> -{
> -    return (hw->pcm_ops->buffer_get_free ? hw->pcm_ops->buffer_get_free(hw) :
> -            INT_MAX) / hw->info.bytes_per_frame;
> -}
> -
> -static void audio_pcm_hw_clip_out(HWVoiceOut *hw, void *pcm_buf, size_t len)
> -{
> -    size_t clipped = 0;
> -    size_t pos = hw->mix_buf.pos;
> -
> -    while (len) {
> -        st_sample *src = hw->mix_buf.buffer + pos;
> -        uint8_t *dst = advance(pcm_buf, clipped * hw->info.bytes_per_frame);
> -        size_t samples_till_end_of_buf = hw->mix_buf.size - pos;
> -        size_t samples_to_clip = MIN(len, samples_till_end_of_buf);
> -
> -        hw->clip(dst, src, samples_to_clip);
> -
> -        pos = (pos + samples_to_clip) % hw->mix_buf.size;
> -        len -= samples_to_clip;
> -        clipped += samples_to_clip;
> -    }
> -}
> -
> -/*
> - * Soft voice (playback)
> - */
> -static void audio_pcm_sw_resample_out(SWVoiceOut *sw,
> -    size_t frames_in_max, size_t frames_out_max,
> -    size_t *total_in, size_t *total_out)
> -{
> -    HWVoiceOut *hw = sw->hw;
> -    struct st_sample *src, *dst;
> -    size_t live, wpos, frames_in, frames_out;
> -
> -    live = sw->total_hw_samples_mixed;
> -    wpos = (hw->mix_buf.pos + live) % hw->mix_buf.size;
> -
> -    /* write to mix_buf from wpos to end of buffer */
> -    src = sw->resample_buf.buffer;
> -    frames_in = frames_in_max;
> -    dst = hw->mix_buf.buffer + wpos;
> -    frames_out = MIN(frames_out_max, hw->mix_buf.size - wpos);
> -    st_rate_flow_mix(sw->rate, src, dst, &frames_in, &frames_out);
> -    wpos += frames_out;
> -    *total_in = frames_in;
> -    *total_out = frames_out;
> -
> -    /* write to mix_buf from start of buffer if there are input frames left */
> -    if (frames_in_max - frames_in > 0 && wpos == hw->mix_buf.size) {
> -        src += frames_in;
> -        frames_in = frames_in_max - frames_in;
> -        dst = hw->mix_buf.buffer;
> -        frames_out = frames_out_max - frames_out;
> -        st_rate_flow_mix(sw->rate, src, dst, &frames_in, &frames_out);
> -        *total_in += frames_in;
> -        *total_out += frames_out;
> -    }
> -}
> -
> -static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
> -{
> -    HWVoiceOut *hw = sw->hw;
> -    size_t live, dead, hw_free, sw_max, fe_max;
> -    size_t frames_in_max, frames_out_max, total_in, total_out;
> -
> -    live = sw->total_hw_samples_mixed;
> -    if (audio_bug(__func__, live > hw->mix_buf.size)) {
> -        dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> -        return 0;
> -    }
> -
> -    if (live == hw->mix_buf.size) {
> -#ifdef DEBUG_OUT
> -        dolog ("%s is full %zu\n", sw->name, live);
> -#endif
> -        return 0;
> -    }
> -
> -    dead = hw->mix_buf.size - live;
> -    hw_free = audio_pcm_hw_get_free(hw);
> -    hw_free = hw_free > live ? hw_free - live : 0;
> -    frames_out_max = MIN(dead, hw_free);
> -    sw_max = st_rate_frames_in(sw->rate, frames_out_max);
> -    fe_max = MIN(buf_len / sw->info.bytes_per_frame + sw->resample_buf.pos,
> -                 sw->resample_buf.size);
> -    frames_in_max = MIN(sw_max, fe_max);
> -
> -    if (!frames_in_max) {
> -        return 0;
> -    }
> -
> -    if (frames_in_max > sw->resample_buf.pos) {
> -        sw->conv(sw->resample_buf.buffer + sw->resample_buf.pos,
> -                 buf, frames_in_max - sw->resample_buf.pos);
> -        if (!sw->hw->pcm_ops->volume_out) {
> -            mixeng_volume(sw->resample_buf.buffer + sw->resample_buf.pos,
> -                          frames_in_max - sw->resample_buf.pos, &sw->vol);
> -        }
> -    }
> -
> -    audio_pcm_sw_resample_out(sw, frames_in_max, frames_out_max,
> -                              &total_in, &total_out);
> -
> -    sw->total_hw_samples_mixed += total_out;
> -    sw->empty = sw->total_hw_samples_mixed == 0;
> -
> -    /*
> -     * Upsampling may leave one audio frame in the resample buffer. Decrement
> -     * total_in by one if there was a leftover frame from the previous resample
> -     * pass in the resample buffer. Increment total_in by one if the current
> -     * resample pass left one frame in the resample buffer.
> -     */
> -    if (frames_in_max - total_in == 1) {
> -        /* copy one leftover audio frame to the beginning of the buffer */
> -        *sw->resample_buf.buffer = *(sw->resample_buf.buffer + total_in);
> -        total_in += 1 - sw->resample_buf.pos;
> -        sw->resample_buf.pos = 1;
> -    } else if (total_in >= sw->resample_buf.pos) {
> -        total_in -= sw->resample_buf.pos;
> -        sw->resample_buf.pos = 0;
> -    }
> -
> -#ifdef DEBUG_OUT
> -    dolog (
> -        "%s: write size %zu written %zu total mixed %zu\n",
> -        SW_NAME(sw),
> -        buf_len / sw->info.bytes_per_frame,
> -        total_in,
> -        sw->total_hw_samples_mixed
> -        );
> -#endif
> -
> -    return total_in * sw->info.bytes_per_frame;
> -}
> -
> -#ifdef DEBUG_AUDIO
> -static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
> -{
> -    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
> -          cap, info->bits, info->is_signed, info->is_float, info->freq,
> -          info->nchannels);
> -}
> -#endif
> -
> -#define DAC
> -#include "audio_template.h"
> -#undef DAC
> -#include "audio_template.h"
> -
> -/*
> - * Timer
> - */
> -static int audio_is_timer_needed(AudioMixengBackend *s)
> -{
> -    HWVoiceIn *hwi = NULL;
> -    HWVoiceOut *hwo = NULL;
> -
> -    while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
> -        if (!hwo->poll_mode) {
> -            return 1;
> -        }
> -    }
> -    while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
> -        if (!hwi->poll_mode) {
> -            return 1;
> -        }
> -    }
> -    return 0;
> -}
> -
> -static void audio_reset_timer(AudioMixengBackend *s)
> -{
> -    if (audio_is_timer_needed(s)) {
> -        timer_mod_anticipate_ns(s->ts,
> -            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->period_ticks);
> -        if (!s->timer_running) {
> -            s->timer_running = true;
> -            s->timer_last = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -            trace_audio_timer_start(s->period_ticks / SCALE_MS);
> -        }
> -    } else {
> -        timer_del(s->ts);
> -        if (s->timer_running) {
> -            s->timer_running = false;
> -            trace_audio_timer_stop();
> -        }
> -    }
> -}
> -
> -static void audio_timer (void *opaque)
> -{
> -    int64_t now, diff;
> -    AudioMixengBackend *s = opaque;
> -
> -    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    diff = now - s->timer_last;
> -    if (diff > s->period_ticks * 3 / 2) {
> -        trace_audio_timer_delayed(diff / SCALE_MS);
> -    }
> -    s->timer_last = now;
> -
> -    audio_run(s, "timer");
> -    audio_reset_timer(s);
> -}
> -
> -/*
> - * Public API
> - */
> -static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
> -                                         void *buf, size_t size)
> -{
> -    HWVoiceOut *hw;
> -
> -    if (!sw) {
> -        /* XXX: Consider options */
> -        return size;
> -    }
> -    hw = sw->hw;
> -
> -    if (!hw->enabled) {
> -        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
> -        return 0;
> -    }
> -
> -    if (audio_get_pdo_out(hw->s->dev)->mixing_engine) {
> -        return audio_pcm_sw_write(sw, buf, size);
> -    } else {
> -        return hw->pcm_ops->write(hw, buf, size);
> -    }
> -}
> -
> -static size_t audio_mixeng_backend_read(AudioBackend *be,
> -                                        SWVoiceIn *sw, void *buf, size_t size)
> -{
> -    HWVoiceIn *hw;
> -
> -    if (!sw) {
> -        /* XXX: Consider options */
> -        return size;
> -    }
> -    hw = sw->hw;
> -
> -    if (!hw->enabled) {
> -        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
> -        return 0;
> -    }
> -
> -    if (audio_get_pdo_in(hw->s->dev)->mixing_engine) {
> -        return audio_pcm_sw_read(sw, buf, size);
> -    } else {
> -        return hw->pcm_ops->read(hw, buf, size);
> -    }
> -
> -}
> -
> -static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
> -{
> -    if (!sw) {
> -        return 0;
> -    }
> -
> -    if (audio_get_pdo_out(sw->s->dev)->mixing_engine) {
> -        return sw->resample_buf.size * sw->info.bytes_per_frame;
> -    }
> -
> -    return sw->hw->samples * sw->hw->info.bytes_per_frame;
> -}
> -
> -static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw,
> -                                                bool on)
> -{
> -    HWVoiceOut *hw;
> -
> -    if (!sw) {
> -        return;
> -    }
> -
> -    hw = sw->hw;
> -    if (sw->active != on) {
> -        AudioMixengBackend *s = sw->s;
> -        SWVoiceOut *temp_sw;
> -        SWVoiceCap *sc;
> -
> -        if (on) {
> -            hw->pending_disable = 0;
> -            if (!hw->enabled) {
> -                hw->enabled = true;
> -                if (runstate_is_running()) {
> -                    if (hw->pcm_ops->enable_out) {
> -                        hw->pcm_ops->enable_out(hw, true);
> -                    }
> -                    audio_reset_timer (s);
> -                }
> -            }
> -        } else {
> -            if (hw->enabled) {
> -                int nb_active = 0;
> -
> -                for (temp_sw = hw->sw_head.lh_first; temp_sw;
> -                     temp_sw = temp_sw->entries.le_next) {
> -                    nb_active += temp_sw->active != 0;
> -                }
> -
> -                hw->pending_disable = nb_active == 1;
> -            }
> -        }
> -
> -        for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> -            sc->sw.active = hw->enabled;
> -            if (hw->enabled) {
> -                audio_capture_maybe_changed (sc->cap, 1);
> -            }
> -        }
> -        sw->active = on;
> -    }
> -
> -}
> -
> -static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
> -{
> -    HWVoiceIn *hw;
> -
> -    if (!sw) {
> -        return;
> -    }
> -
> -    hw = sw->hw;
> -    if (sw->active != on) {
> -        AudioMixengBackend *s = sw->s;
> -        SWVoiceIn *temp_sw;
> -
> -        if (on) {
> -            if (!hw->enabled) {
> -                hw->enabled = true;
> -                if (runstate_is_running()) {
> -                    if (hw->pcm_ops->enable_in) {
> -                        hw->pcm_ops->enable_in(hw, true);
> -                    }
> -                    audio_reset_timer (s);
> -                }
> -            }
> -            sw->total_hw_samples_acquired = hw->total_samples_captured;
> -        } else {
> -            if (hw->enabled) {
> -                int nb_active = 0;
> -
> -                for (temp_sw = hw->sw_head.lh_first; temp_sw;
> -                     temp_sw = temp_sw->entries.le_next) {
> -                    nb_active += temp_sw->active != 0;
> -                }
> -
> -                if (nb_active == 1) {
> -                    hw->enabled = false;
> -                    if (hw->pcm_ops->enable_in) {
> -                        hw->pcm_ops->enable_in(hw, false);
> -                    }
> -                }
> -            }
> -        }
> -        sw->active = on;
> -    }
> -}
> -
> -static size_t audio_get_avail(SWVoiceIn *sw)
> -{
> -    size_t live;
> -
> -    if (!sw) {
> -        return 0;
> -    }
> -
> -    live = sw->hw->total_samples_captured - sw->total_hw_samples_acquired;
> -    if (audio_bug(__func__, live > sw->hw->conv_buf.size)) {
> -        dolog("live=%zu sw->hw->conv_buf.size=%zu\n", live,
> -              sw->hw->conv_buf.size);
> -        return 0;
> -    }
> -
> -    ldebug (
> -        "%s: get_avail live %zu frontend frames %u\n",
> -        SW_NAME (sw),
> -        live, st_rate_frames_out(sw->rate, live)
> -        );
> -
> -    return live;
> -}
> -
> -static size_t audio_get_free(SWVoiceOut *sw)
> -{
> -    size_t live, dead;
> -
> -    if (!sw) {
> -        return 0;
> -    }
> -
> -    live = sw->total_hw_samples_mixed;
> -
> -    if (audio_bug(__func__, live > sw->hw->mix_buf.size)) {
> -        dolog("live=%zu sw->hw->mix_buf.size=%zu\n", live,
> -              sw->hw->mix_buf.size);
> -        return 0;
> -    }
> -
> -    dead = sw->hw->mix_buf.size - live;
> -
> -#ifdef DEBUG_OUT
> -    dolog("%s: get_free live %zu dead %zu frontend frames %u\n",
> -          SW_NAME(sw), live, dead, st_rate_frames_in(sw->rate, dead));
> -#endif
> -
> -    return dead;
> -}
> -
> -static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
> -                                        size_t samples)
> -{
> -    size_t n;
> -
> -    if (hw->enabled) {
> -        SWVoiceCap *sc;
> -
> -        for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> -            SWVoiceOut *sw = &sc->sw;
> -            size_t rpos2 = rpos;
> -
> -            n = samples;
> -            while (n) {
> -                size_t till_end_of_hw = hw->mix_buf.size - rpos2;
> -                size_t to_read = MIN(till_end_of_hw, n);
> -                size_t live, frames_in, frames_out;
> -
> -                sw->resample_buf.buffer = hw->mix_buf.buffer + rpos2;
> -                sw->resample_buf.size = to_read;
> -                live = sw->total_hw_samples_mixed;
> -
> -                audio_pcm_sw_resample_out(sw,
> -                                          to_read, sw->hw->mix_buf.size - live,
> -                                          &frames_in, &frames_out);
> -
> -                sw->total_hw_samples_mixed += frames_out;
> -                sw->empty = sw->total_hw_samples_mixed == 0;
> -
> -                if (to_read - frames_in) {
> -                    dolog("Could not mix %zu frames into a capture "
> -                          "buffer, mixed %zu\n",
> -                          to_read, frames_in);
> -                    break;
> -                }
> -                n -= to_read;
> -                rpos2 = (rpos2 + to_read) % hw->mix_buf.size;
> -            }
> -        }
> -    }
> -
> -    n = MIN(samples, hw->mix_buf.size - rpos);
> -    mixeng_clear(hw->mix_buf.buffer + rpos, n);
> -    mixeng_clear(hw->mix_buf.buffer, samples - n);
> -}
> -
> -static size_t audio_pcm_hw_run_out(HWVoiceOut *hw, size_t live)
> -{
> -    size_t clipped = 0;
> -
> -    while (live) {
> -        size_t size = live * hw->info.bytes_per_frame;
> -        size_t decr, proc;
> -        void *buf = hw->pcm_ops->get_buffer_out(hw, &size);
> -
> -        if (size == 0) {
> -            break;
> -        }
> -
> -        decr = MIN(size / hw->info.bytes_per_frame, live);
> -        if (buf) {
> -            audio_pcm_hw_clip_out(hw, buf, decr);
> -        }
> -        proc = hw->pcm_ops->put_buffer_out(hw, buf,
> -                                           decr * hw->info.bytes_per_frame) /
> -            hw->info.bytes_per_frame;
> -
> -        live -= proc;
> -        clipped += proc;
> -        hw->mix_buf.pos = (hw->mix_buf.pos + proc) % hw->mix_buf.size;
> -
> -        if (proc == 0 || proc < decr) {
> -            break;
> -        }
> -    }
> -
> -    if (hw->pcm_ops->run_buffer_out) {
> -        hw->pcm_ops->run_buffer_out(hw);
> -    }
> -
> -    return clipped;
> -}
> -
> -static void audio_run_out(AudioMixengBackend *s)
> -{
> -    HWVoiceOut *hw = NULL;
> -    SWVoiceOut *sw;
> -
> -    while ((hw = audio_pcm_hw_find_any_enabled_out(s, hw))) {
> -        size_t played, live, prev_rpos;
> -        size_t hw_free = audio_pcm_hw_get_free(hw);
> -        int nb_live;
> -
> -        if (!audio_get_pdo_out(s->dev)->mixing_engine) {
> -            /* there is exactly 1 sw for each hw with no mixeng */
> -            sw = hw->sw_head.lh_first;
> -
> -            if (hw->pending_disable) {
> -                hw->enabled = false;
> -                hw->pending_disable = false;
> -                if (hw->pcm_ops->enable_out) {
> -                    hw->pcm_ops->enable_out(hw, false);
> -                }
> -            }
> -
> -            if (sw->active) {
> -                sw->callback.fn(sw->callback.opaque,
> -                                hw_free * sw->info.bytes_per_frame);
> -            }
> -
> -            if (hw->pcm_ops->run_buffer_out) {
> -                hw->pcm_ops->run_buffer_out(hw);
> -            }
> -
> -            continue;
> -        }
> -
> -        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> -            if (sw->active) {
> -                size_t sw_free = audio_get_free(sw);
> -                size_t free;
> -
> -                if (hw_free > sw->total_hw_samples_mixed) {
> -                    free = st_rate_frames_in(sw->rate,
> -                        MIN(sw_free, hw_free - sw->total_hw_samples_mixed));
> -                } else {
> -                    free = 0;
> -                }
> -                if (free > sw->resample_buf.pos) {
> -                    free = MIN(free, sw->resample_buf.size)
> -                           - sw->resample_buf.pos;
> -                    sw->callback.fn(sw->callback.opaque,
> -                                    free * sw->info.bytes_per_frame);
> -                }
> -            }
> -        }
> -
> -        live = audio_pcm_hw_get_live_out (hw, &nb_live);
> -        if (!nb_live) {
> -            live = 0;
> -        }
> -
> -        if (audio_bug(__func__, live > hw->mix_buf.size)) {
> -            dolog("live=%zu hw->mix_buf.size=%zu\n", live, hw->mix_buf.size);
> -            continue;
> -        }
> -
> -        if (hw->pending_disable && !nb_live) {
> -            SWVoiceCap *sc;
> -#ifdef DEBUG_OUT
> -            dolog ("Disabling voice\n");
> -#endif
> -            hw->enabled = false;
> -            hw->pending_disable = false;
> -            if (hw->pcm_ops->enable_out) {
> -                hw->pcm_ops->enable_out(hw, false);
> -            }
> -            for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> -                sc->sw.active = false;
> -                audio_recalc_and_notify_capture (sc->cap);
> -            }
> -            continue;
> -        }
> -
> -        if (!live) {
> -            if (hw->pcm_ops->run_buffer_out) {
> -                hw->pcm_ops->run_buffer_out(hw);
> -            }
> -            continue;
> -        }
> -
> -        prev_rpos = hw->mix_buf.pos;
> -        played = audio_pcm_hw_run_out(hw, live);
> -        replay_audio_out(&played);
> -        if (audio_bug(__func__, hw->mix_buf.pos >= hw->mix_buf.size)) {
> -            dolog("hw->mix_buf.pos=%zu hw->mix_buf.size=%zu played=%zu\n",
> -                  hw->mix_buf.pos, hw->mix_buf.size, played);
> -            hw->mix_buf.pos = 0;
> -        }
> -
> -#ifdef DEBUG_OUT
> -        dolog("played=%zu\n", played);
> -#endif
> -
> -        if (played) {
> -            audio_capture_mix_and_clear (hw, prev_rpos, played);
> -        }
> -
> -        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> -            if (!sw->active && sw->empty) {
> -                continue;
> -            }
> -
> -            if (audio_bug(__func__, played > sw->total_hw_samples_mixed)) {
> -                dolog("played=%zu sw->total_hw_samples_mixed=%zu\n",
> -                      played, sw->total_hw_samples_mixed);
> -                played = sw->total_hw_samples_mixed;
> -            }
> -
> -            sw->total_hw_samples_mixed -= played;
> -
> -            if (!sw->total_hw_samples_mixed) {
> -                sw->empty = true;
> -            }
> -        }
> -    }
> -}
> -
> -static size_t audio_pcm_hw_run_in(HWVoiceIn *hw, size_t samples)
> -{
> -    size_t conv = 0;
> -
> -    if (hw->pcm_ops->run_buffer_in) {
> -        hw->pcm_ops->run_buffer_in(hw);
> -    }
> -
> -    while (samples) {
> -        size_t proc;
> -        size_t size = samples * hw->info.bytes_per_frame;
> -        void *buf = hw->pcm_ops->get_buffer_in(hw, &size);
> -
> -        assert(size % hw->info.bytes_per_frame == 0);
> -        if (size == 0) {
> -            break;
> -        }
> -
> -        proc = audio_pcm_hw_conv_in(hw, buf, size / hw->info.bytes_per_frame);
> -
> -        samples -= proc;
> -        conv += proc;
> -        hw->pcm_ops->put_buffer_in(hw, buf, proc * hw->info.bytes_per_frame);
> -    }
> -
> -    return conv;
> -}
> -
> -static void audio_run_in(AudioMixengBackend *s)
> -{
> -    HWVoiceIn *hw = NULL;
> -
> -    if (!audio_get_pdo_in(s->dev)->mixing_engine) {
> -        while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
> -            /* there is exactly 1 sw for each hw with no mixeng */
> -            SWVoiceIn *sw = hw->sw_head.lh_first;
> -            if (sw->active) {
> -                sw->callback.fn(sw->callback.opaque, INT_MAX);
> -            }
> -        }
> -        return;
> -    }
> -
> -    while ((hw = audio_pcm_hw_find_any_enabled_in(s, hw))) {
> -        SWVoiceIn *sw;
> -        size_t captured = 0, min;
> -        int pos;
> -
> -        if (replay_mode != REPLAY_MODE_PLAY) {
> -            captured = audio_pcm_hw_run_in(
> -                hw, hw->conv_buf.size - audio_pcm_hw_get_live_in(hw));
> -        }
> -
> -        replay_audio_in_start(&captured);
> -        assert(captured <= hw->conv_buf.size);
> -        if (replay_mode == REPLAY_MODE_PLAY) {
> -            hw->conv_buf.pos = (hw->conv_buf.pos + captured) % hw->conv_buf.size;
> -        }
> -        for (pos = (hw->conv_buf.pos - captured + hw->conv_buf.size) % hw->conv_buf.size;
> -             pos != hw->conv_buf.pos;
> -             pos = (pos + 1) % hw->conv_buf.size) {
> -                uint64_t left, right;
> -
> -                if (replay_mode == REPLAY_MODE_RECORD) {
> -                    audio_sample_to_uint64(hw->conv_buf.buffer, pos, &left, &right);
> -                }
> -                replay_audio_in_sample_lr(&left, &right);
> -                if (replay_mode == REPLAY_MODE_PLAY) {
> -                    audio_sample_from_uint64(hw->conv_buf.buffer, pos, left, right);
> -                }
> -        }
> -        replay_audio_in_finish();
> -
> -        min = audio_pcm_hw_find_min_in (hw);
> -        hw->total_samples_captured += captured - min;
> -
> -        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> -            sw->total_hw_samples_acquired -= min;
> -
> -            if (sw->active) {
> -                size_t sw_avail = audio_get_avail(sw);
> -                size_t avail;
> -
> -                avail = st_rate_frames_out(sw->rate, sw_avail);
> -                if (avail > 0) {
> -                    avail = MIN(avail, sw->resample_buf.size);
> -                    sw->callback.fn(sw->callback.opaque,
> -                                    avail * sw->info.bytes_per_frame);
> -                }
> -            }
> -        }
> -    }
> -}
> -
> -static void audio_run_capture(AudioMixengBackend *s)
> -{
> -    CaptureVoiceOut *cap;
> -
> -    for (cap = s->cap_head.lh_first; cap; cap = cap->entries.le_next) {
> -        size_t live, rpos, captured;
> -        HWVoiceOut *hw = &cap->hw;
> -        SWVoiceOut *sw;
> -
> -        captured = live = audio_pcm_hw_get_live_out (hw, NULL);
> -        rpos = hw->mix_buf.pos;
> -        while (live) {
> -            size_t left = hw->mix_buf.size - rpos;
> -            size_t to_capture = MIN(live, left);
> -            struct st_sample *src;
> -            struct capture_callback *cb;
> -
> -            src = hw->mix_buf.buffer + rpos;
> -            hw->clip (cap->buf, src, to_capture);
> -            mixeng_clear (src, to_capture);
> -
> -            for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> -                cb->ops.capture (cb->opaque, cap->buf,
> -                                 to_capture * hw->info.bytes_per_frame);
> -            }
> -            rpos = (rpos + to_capture) % hw->mix_buf.size;
> -            live -= to_capture;
> -        }
> -        hw->mix_buf.pos = rpos;
> -
> -        for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
> -            if (!sw->active && sw->empty) {
> -                continue;
> -            }
> -
> -            if (audio_bug(__func__, captured > sw->total_hw_samples_mixed)) {
> -                dolog("captured=%zu sw->total_hw_samples_mixed=%zu\n",
> -                      captured, sw->total_hw_samples_mixed);
> -                captured = sw->total_hw_samples_mixed;
> -            }
> -
> -            sw->total_hw_samples_mixed -= captured;
> -            sw->empty = sw->total_hw_samples_mixed == 0;
> -        }
> -    }
> -}
> -
> -void audio_run(AudioMixengBackend *s, const char *msg)
> -{
> -    audio_run_out(s);
> -    audio_run_in(s);
> -    audio_run_capture(s);
> -
> -#ifdef DEBUG_POLL
> -    {
> -        static double prevtime;
> -        double currtime;
> -        struct timeval tv;
> -
> -        if (gettimeofday (&tv, NULL)) {
> -            perror ("audio_run: gettimeofday");
> -            return;
> -        }
> -
> -        currtime = tv.tv_sec + tv.tv_usec * 1e-6;
> -        dolog ("Elapsed since last %s: %f\n", msg, currtime - prevtime);
> -        prevtime = currtime;
> -    }
> -#endif
> -}
> -
> -void audio_generic_run_buffer_in(HWVoiceIn *hw)
> -{
> -    if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul = g_malloc(hw->size_emul);
> -        hw->pos_emul = hw->pending_emul = 0;
> -    }
> -
> -    while (hw->pending_emul < hw->size_emul) {
> -        size_t read_len = MIN(hw->size_emul - hw->pos_emul,
> -                              hw->size_emul - hw->pending_emul);
> -        size_t read = hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_emul,
> -                                        read_len);
> -        hw->pending_emul += read;
> -        hw->pos_emul = (hw->pos_emul + read) % hw->size_emul;
> -        if (read < read_len) {
> -            break;
> -        }
> -    }
> -}
> -
> -void *audio_generic_get_buffer_in(HWVoiceIn *hw, size_t *size)
> -{
> -    size_t start;
> -
> -    start = audio_ring_posb(hw->pos_emul, hw->pending_emul, hw->size_emul);
> -    assert(start < hw->size_emul);
> -
> -    *size = MIN(*size, hw->pending_emul);
> -    *size = MIN(*size, hw->size_emul - start);
> -    return hw->buf_emul + start;
> -}
> -
> -void audio_generic_put_buffer_in(HWVoiceIn *hw, void *buf, size_t size)
> -{
> -    assert(size <= hw->pending_emul);
> -    hw->pending_emul -= size;
> -}
> -
> -size_t audio_generic_buffer_get_free(HWVoiceOut *hw)
> -{
> -    if (hw->buf_emul) {
> -        return hw->size_emul - hw->pending_emul;
> -    } else {
> -        return hw->samples * hw->info.bytes_per_frame;
> -    }
> -}
> -
> -void audio_generic_run_buffer_out(HWVoiceOut *hw)
> -{
> -    while (hw->pending_emul) {
> -        size_t write_len, written, start;
> -
> -        start = audio_ring_posb(hw->pos_emul, hw->pending_emul, hw->size_emul);
> -        assert(start < hw->size_emul);
> -
> -        write_len = MIN(hw->pending_emul, hw->size_emul - start);
> -
> -        written = hw->pcm_ops->write(hw, hw->buf_emul + start, write_len);
> -        hw->pending_emul -= written;
> -
> -        if (written < write_len) {
> -            break;
> -        }
> -    }
> -}
> -
> -void *audio_generic_get_buffer_out(HWVoiceOut *hw, size_t *size)
> -{
> -    if (unlikely(!hw->buf_emul)) {
> -        hw->size_emul = hw->samples * hw->info.bytes_per_frame;
> -        hw->buf_emul = g_malloc(hw->size_emul);
> -        hw->pos_emul = hw->pending_emul = 0;
> -    }
> -
> -    *size = MIN(hw->size_emul - hw->pending_emul,
> -                hw->size_emul - hw->pos_emul);
> -    return hw->buf_emul + hw->pos_emul;
> -}
> -
> -size_t audio_generic_put_buffer_out(HWVoiceOut *hw, void *buf, size_t size)
> -{
> -    assert(buf == hw->buf_emul + hw->pos_emul &&
> -           size + hw->pending_emul <= hw->size_emul);
> -
> -    hw->pending_emul += size;
> -    hw->pos_emul = (hw->pos_emul + size) % hw->size_emul;
> -
> -    return size;
> -}
> -
> -size_t audio_generic_write(HWVoiceOut *hw, void *buf, size_t size)
> -{
> -    size_t total = 0;
> -
> -    if (hw->pcm_ops->buffer_get_free) {
> -        size_t free = hw->pcm_ops->buffer_get_free(hw);
> -
> -        size = MIN(size, free);
> -    }
> -
> -    while (total < size) {
> -        size_t dst_size = size - total;
> -        size_t copy_size, proc;
> -        void *dst = hw->pcm_ops->get_buffer_out(hw, &dst_size);
> -
> -        if (dst_size == 0) {
> -            break;
> -        }
> -
> -        copy_size = MIN(size - total, dst_size);
> -        if (dst) {
> -            memcpy(dst, (char *)buf + total, copy_size);
> -        }
> -        proc = hw->pcm_ops->put_buffer_out(hw, dst, copy_size);
> -        total += proc;
> -
> -        if (proc == 0 || proc < copy_size) {
> -            break;
> -        }
> -    }
> -
> -    return total;
> -}
> -
> -size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
> -{
> -    size_t total = 0;
> -
> -    if (hw->pcm_ops->run_buffer_in) {
> -        hw->pcm_ops->run_buffer_in(hw);
> -    }
> -
> -    while (total < size) {
> -        size_t src_size = size - total;
> -        void *src = hw->pcm_ops->get_buffer_in(hw, &src_size);
> -
> -        if (src_size == 0) {
> -            break;
> -        }
> -
> -        memcpy((char *)buf + total, src, src_size);
> -        hw->pcm_ops->put_buffer_in(hw, src, src_size);
> -        total += src_size;
> -    }
> -
> -    return total;
> -}
> -
> -static bool audio_mixeng_backend_realize(AudioBackend *abe,
> -                                         Audiodev *dev, Error **errp)
> -{
> -    AudioMixengBackend *be = AUDIO_MIXENG_BACKEND(abe);
> -    audio_driver *drv = AUDIO_MIXENG_BACKEND_GET_CLASS(be)->driver;
> -
> -    be->dev = dev;
> -    be->drv_opaque = drv->init(be->dev, errp);
> -    if (!be->drv_opaque) {
> -        return false;
> -    }
> -
> -    if (!drv->pcm_ops->get_buffer_in) {
> -        drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
> -        drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
> -    }
> -    if (!drv->pcm_ops->get_buffer_out) {
> -        drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
> -        drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
> -    }
> -
> -    audio_init_nb_voices_out(be, drv, 1);
> -    audio_init_nb_voices_in(be, drv, 0);
> -    be->drv = drv;
> -
> -    if (be->dev->timer_period <= 0) {
> -        be->period_ticks = 1;
> -    } else {
> -        be->period_ticks = be->dev->timer_period * (int64_t)SCALE_US;
> -    }
> -
> -    return true;
> -}
> -
> -static void audio_vm_change_state_handler (void *opaque, bool running,
> -                                           RunState state)
> -{
> -    AudioMixengBackend *s = opaque;
> -    HWVoiceOut *hwo = NULL;
> -    HWVoiceIn *hwi = NULL;
> -
> -    while ((hwo = audio_pcm_hw_find_any_enabled_out(s, hwo))) {
> -        if (hwo->pcm_ops->enable_out) {
> -            hwo->pcm_ops->enable_out(hwo, running);
> -        }
> -    }
> -
> -    while ((hwi = audio_pcm_hw_find_any_enabled_in(s, hwi))) {
> -        if (hwi->pcm_ops->enable_in) {
> -            hwi->pcm_ops->enable_in(hwi, running);
> -        }
> -    }
> -    audio_reset_timer (s);
> -}
> -
> -static const VMStateDescription vmstate_audio;
> -
> -static const char *audio_mixeng_backend_get_id(AudioBackend *be)
> -{
> -    return AUDIO_MIXENG_BACKEND(be)->dev->id;
> -}
> -
> -static CaptureVoiceOut *audio_mixeng_backend_add_capture(
> -    AudioBackend *be,
> -    struct audsettings *as,
> -    struct audio_capture_ops *ops,
> -    void *cb_opaque);
> -
> -static void audio_mixeng_backend_del_capture(
> -    AudioBackend *be,
> -    CaptureVoiceOut *cap,
> -    void *cb_opaque);
> -
> -static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
> -                                                Volume *vol);
> -static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
> -                                               Volume *vol);
> -
> -static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
> -
> -    be->realize = audio_mixeng_backend_realize;
> -    be->get_id = audio_mixeng_backend_get_id;
> -    be->open_in = audio_mixeng_backend_open_in;
> -    be->open_out = audio_mixeng_backend_open_out;
> -    be->close_in = audio_mixeng_backend_close_in;
> -    be->close_out = audio_mixeng_backend_close_out;
> -    be->is_active_out = audio_mixeng_backend_is_active_out;
> -    be->is_active_in = audio_mixeng_backend_is_active_in;
> -    be->set_active_out = audio_mixeng_backend_set_active_out;
> -    be->set_active_in = audio_mixeng_backend_set_active_in;
> -    be->set_volume_out = audio_mixeng_backend_set_volume_out;
> -    be->set_volume_in = audio_mixeng_backend_set_volume_in;
> -    be->read = audio_mixeng_backend_read;
> -    be->write = audio_mixeng_backend_write;
> -    be->get_buffer_size_out = audio_mixeng_backend_get_buffer_size_out;
> -    be->add_capture = audio_mixeng_backend_add_capture;
> -    be->del_capture = audio_mixeng_backend_del_capture;
> -}
> -
> -static void audio_mixeng_backend_init(Object *obj)
> -{
> -    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
> -
> -    QLIST_INIT(&s->hw_head_out);
> -    QLIST_INIT(&s->hw_head_in);
> -    QLIST_INIT(&s->cap_head);
> -    s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
> -
> -    s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
> -    assert(s->vmse != NULL);
> -
> -    vmstate_register_any(NULL, &vmstate_audio, s);
> -}
> -
> -static void audio_mixeng_backend_finalize(Object *obj)
> -{
> -    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(obj);
> -    HWVoiceOut *hwo, *hwon;
> -    HWVoiceIn *hwi, *hwin;
> -
> -    QLIST_FOREACH_SAFE(hwo, &s->hw_head_out, entries, hwon) {
> -        SWVoiceCap *sc;
> -
> -        if (hwo->enabled && hwo->pcm_ops->enable_out) {
> -            hwo->pcm_ops->enable_out(hwo, false);
> -        }
> -        hwo->pcm_ops->fini_out (hwo);
> +/* SPDX-License-Identifier: MIT */
>   
> -        for (sc = hwo->cap_head.lh_first; sc; sc = sc->entries.le_next) {
> -            CaptureVoiceOut *cap = sc->cap;
> -            struct capture_callback *cb;
> +#include "qemu/osdep.h"
> +#include "qemu/audio.h"
> +#include "qemu/help_option.h"
> +#include "qapi/clone-visitor.h"
> +#include "qapi/qobject-input-visitor.h"
> +#include "qapi/qapi-visit-audio.h"
> +#include "qapi/qapi-commands-audio.h"
> +#include "qobject/qdict.h"
> +#include "system/system.h"
>   
> -            for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> -                cb->ops.destroy (cb->opaque);
> -            }
> -        }
> -        QLIST_REMOVE(hwo, entries);
> -    }
> +/* Order of CONFIG_AUDIO_DRIVERS is import.
> +   The 1st one is the one used by default, that is the reason
> +    that we generate the list.
> +*/
> +const char *audio_prio_list[] = {
> +#ifdef CONFIG_GIO
> +    "dbus",
> +#endif
> +    "spice",
> +    CONFIG_AUDIO_DRIVERS
> +    "none",
> +    NULL
> +};
>   
> -    QLIST_FOREACH_SAFE(hwi, &s->hw_head_in, entries, hwin) {
> -        if (hwi->enabled && hwi->pcm_ops->enable_in) {
> -            hwi->pcm_ops->enable_in(hwi, false);
> -        }
> -        hwi->pcm_ops->fini_in (hwi);
> -        QLIST_REMOVE(hwi, entries);
> -    }
> +typedef struct AudiodevListEntry {
> +    Audiodev *dev;
> +    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
> +} AudiodevListEntry;
>   
> -    if (s->drv) {
> -        s->drv->fini (s->drv_opaque);
> -        s->drv = NULL;
> -    }
> +typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
>   
> -    if (s->dev) {
> -        qapi_free_Audiodev(s->dev);
> -        s->dev = NULL;
> -    }
> +static AudiodevListHead audiodevs =
> +    QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
> +static AudiodevListHead default_audiodevs =
> +    QSIMPLEQ_HEAD_INITIALIZER(default_audiodevs);
>   
> -    if (s->ts) {
> -        timer_free(s->ts);
> -        s->ts = NULL;
> -    }
> +static AudioBackendClass *audio_be_class_by_name(const char *name)
> +{
> +    g_autofree char *tname = g_strconcat("audio-", name, NULL);
> +    ObjectClass *oc = module_object_class_by_name(tname);
>   
> -    if (s->vmse) {
> -        qemu_del_vm_change_state_handler(s->vmse);
> -        s->vmse = NULL;
> +    if (!oc || !object_class_dynamic_cast(oc, TYPE_AUDIO_BACKEND)) {
> +        return NULL;
>       }
>   
> -    vmstate_unregister(NULL, &vmstate_audio, s);
> +    return AUDIO_BACKEND_CLASS(oc);
>   }
>   
> +static AudioBackend *default_audio_be;
> +
>   static Object *get_audiodevs_root(void)
>   {
>       return object_get_container("audiodevs");
> @@ -1757,25 +62,6 @@ void audio_cleanup(void)
>       object_unparent(get_audiodevs_root());
>   }
>   
> -static bool vmstate_audio_needed(void *opaque)
> -{
> -    /*
> -     * Never needed, this vmstate only exists in case
> -     * an old qemu sends it to us.
> -     */
> -    return false;
> -}
> -
> -static const VMStateDescription vmstate_audio = {
> -    .name = "audio",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .needed = vmstate_audio_needed,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>   void audio_create_default_audiodevs(void)
>   {
>       for (int i = 0; audio_prio_list[i]; i++) {
> @@ -1816,15 +102,13 @@ static AudioBackend *audio_init(Audiodev *dev, Error **errp)
>           assert(!default_audio_be);
>           for (;;) {
>               AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
> -
>               if (!e) {
>                   error_setg(errp, "no default audio driver available");
>                   return NULL;
>               }
> -            dev = e->dev;
>               QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
> +            be = audio_be_new(e->dev, NULL);
>               g_free(e);
> -            be = audio_be_new(dev, NULL);
>               if (be) {
>                   break;
>               }
> @@ -1855,156 +139,35 @@ AudioBackend *audio_get_default_audio_be(Error **errp)
>       return default_audio_be;
>   }
>   
> -static struct audio_pcm_ops capture_pcm_ops;
> -
> -static CaptureVoiceOut *audio_mixeng_backend_add_capture(
> -    AudioBackend *be,
> -    struct audsettings *as,
> -    struct audio_capture_ops *ops,
> -    void *cb_opaque)
> -{
> -    AudioMixengBackend *s = AUDIO_MIXENG_BACKEND(be);
> -    CaptureVoiceOut *cap;
> -    struct capture_callback *cb;
> -
> -    if (!s) {
> -        error_report("Capturing without setting an audiodev is not supported");
> -        abort();
> -    }
> -
> -    if (!audio_get_pdo_out(s->dev)->mixing_engine) {
> -        dolog("Can't capture with mixeng disabled\n");
> -        return NULL;
> -    }
> -
> -    if (audio_validate_settings (as)) {
> -        dolog ("Invalid settings were passed when trying to add capture\n");
> -        audio_print_settings (as);
> -        return NULL;
> -    }
> -
> -    cb = g_malloc0(sizeof(*cb));
> -    cb->ops = *ops;
> -    cb->opaque = cb_opaque;
> -
> -    cap = audio_pcm_capture_find_specific(s, as);
> -    if (cap) {
> -        QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
> -    } else {
> -        HWVoiceOut *hw;
> -
> -        cap = g_malloc0(sizeof(*cap));
> -
> -        hw = &cap->hw;
> -        hw->s = s;
> -        hw->pcm_ops = &capture_pcm_ops;
> -        QLIST_INIT (&hw->sw_head);
> -        QLIST_INIT (&cap->cb_head);
> -
> -        /* XXX find a more elegant way */
> -        hw->samples = 4096 * 4;
> -        audio_pcm_hw_alloc_resources_out(hw);
> -
> -        audio_pcm_init_info (&hw->info, as);
> -
> -        cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);
> -
> -        if (hw->info.is_float) {
> -            hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
> -                [hw->info.swap_endianness];
> -        } else {
> -            hw->clip = mixeng_clip
> -                [hw->info.nchannels == 2]
> -                [hw->info.is_signed]
> -                [hw->info.swap_endianness]
> -                [audio_bits_to_index(hw->info.bits)];
> -        }
> -
> -        QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
> -        QLIST_INSERT_HEAD (&cap->cb_head, cb, entries);
> -
> -        QLIST_FOREACH(hw, &s->hw_head_out, entries) {
> -            audio_attach_capture (hw);
> -        }
> -    }
> -
> -    return cap;
> -}
> -
> -static void audio_mixeng_backend_del_capture(
> -    AudioBackend *be,
> -    CaptureVoiceOut *cap,
> -    void *cb_opaque)
> +void audio_help(void)
>   {
> -    struct capture_callback *cb;
> -
> -    for (cb = cap->cb_head.lh_first; cb; cb = cb->entries.le_next) {
> -        if (cb->opaque == cb_opaque) {
> -            cb->ops.destroy (cb_opaque);
> -            QLIST_REMOVE (cb, entries);
> -            g_free (cb);
> +    int i;
>   
> -            if (!cap->cb_head.lh_first) {
> -                SWVoiceOut *sw = cap->hw.sw_head.lh_first, *sw1;
> +    printf("Available audio drivers:\n");
>   
> -                while (sw) {
> -                    SWVoiceCap *sc = (SWVoiceCap *) sw;
> -#ifdef DEBUG_CAPTURE
> -                    dolog ("freeing %s\n", sw->name);
> -#endif
> +    for (i = 0; i < AUDIODEV_DRIVER__MAX; i++) {
> +        const char *name = AudiodevDriver_str(i);
> +        AudioBackendClass *be = audio_be_class_by_name(name);
>   
> -                    sw1 = sw->entries.le_next;
> -                    if (sw->rate) {
> -                        st_rate_stop (sw->rate);
> -                        sw->rate = NULL;
> -                    }
> -                    QLIST_REMOVE (sw, entries);
> -                    QLIST_REMOVE (sc, entries);
> -                    g_free (sc);
> -                    sw = sw1;
> -                }
> -                QLIST_REMOVE (cap, entries);
> -                g_free(cap->hw.mix_buf.buffer);
> -                g_free (cap->buf);
> -                g_free (cap);
> -            }
> -            return;
> +        if (be) {
> +            printf("%s\n", name);
>           }
>       }
>   }
>   
> -static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
> -                                                Volume *vol)
> +void audio_parse_option(const char *opt)
>   {
> -    if (sw) {
> -        HWVoiceOut *hw = sw->hw;
> -
> -        sw->vol.mute = vol->mute;
> -        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
> -        sw->vol.r = nominal_volume.l * vol->vol[vol->channels > 1 ? 1 : 0] /
> -            255;
> +    Audiodev *dev = NULL;
>   
> -        if (hw->pcm_ops->volume_out) {
> -            hw->pcm_ops->volume_out(hw, vol);
> -        }
> +    if (is_help_option(opt)) {
> +        audio_help();
> +        exit(EXIT_SUCCESS);
>       }
> -}
> -
> -static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
> -                                               Volume *vol)
> -{
> -    if (sw) {
> -        HWVoiceIn *hw = sw->hw;
> -
> -        sw->vol.mute = vol->mute;
> -        sw->vol.l = nominal_volume.l * vol->vol[0] / 255;
> -        sw->vol.r = nominal_volume.r * vol->vol[vol->channels > 1 ? 1 : 0] /
> -            255;
> +    Visitor *v = qobject_input_visitor_new_str(opt, "driver", &error_fatal);
> +    visit_type_Audiodev(v, NULL, &dev, &error_fatal);
> +    visit_free(v);
>   
> -        if (hw->pcm_ops->volume_in) {
> -            hw->pcm_ops->volume_in(hw, vol);
> -        }
> -    }
> +    audio_add_audiodev(dev);
>   }
>   
>   static void audio_create_pdos(Audiodev *dev)
> @@ -2103,6 +266,124 @@ static void audio_validate_per_direction_opts(
>       }
>   }
>   
> +static AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev)
> +{
> +    switch (dev->driver) {
> +    case AUDIODEV_DRIVER_NONE:
> +        return dev->u.none.out;
> +#ifdef CONFIG_AUDIO_ALSA
> +    case AUDIODEV_DRIVER_ALSA:
> +        return qapi_AudiodevAlsaPerDirectionOptions_base(dev->u.alsa.out);
> +#endif
> +#ifdef CONFIG_AUDIO_COREAUDIO
> +    case AUDIODEV_DRIVER_COREAUDIO:
> +        return qapi_AudiodevCoreaudioPerDirectionOptions_base(
> +            dev->u.coreaudio.out);
> +#endif
> +#ifdef CONFIG_DBUS_DISPLAY
> +    case AUDIODEV_DRIVER_DBUS:
> +        return dev->u.dbus.out;
> +#endif
> +#ifdef CONFIG_AUDIO_DSOUND
> +    case AUDIODEV_DRIVER_DSOUND:
> +        return dev->u.dsound.out;
> +#endif
> +#ifdef CONFIG_AUDIO_JACK
> +    case AUDIODEV_DRIVER_JACK:
> +        return qapi_AudiodevJackPerDirectionOptions_base(dev->u.jack.out);
> +#endif
> +#ifdef CONFIG_AUDIO_OSS
> +    case AUDIODEV_DRIVER_OSS:
> +        return qapi_AudiodevOssPerDirectionOptions_base(dev->u.oss.out);
> +#endif
> +#ifdef CONFIG_AUDIO_PA
> +    case AUDIODEV_DRIVER_PA:
> +        return qapi_AudiodevPaPerDirectionOptions_base(dev->u.pa.out);
> +#endif
> +#ifdef CONFIG_AUDIO_PIPEWIRE
> +    case AUDIODEV_DRIVER_PIPEWIRE:
> +        return qapi_AudiodevPipewirePerDirectionOptions_base(dev->u.pipewire.out);
> +#endif
> +#ifdef CONFIG_AUDIO_SDL
> +    case AUDIODEV_DRIVER_SDL:
> +        return qapi_AudiodevSdlPerDirectionOptions_base(dev->u.sdl.out);
> +#endif
> +#ifdef CONFIG_AUDIO_SNDIO
> +    case AUDIODEV_DRIVER_SNDIO:
> +        return dev->u.sndio.out;
> +#endif
> +#ifdef CONFIG_SPICE
> +    case AUDIODEV_DRIVER_SPICE:
> +        return dev->u.spice.out;
> +#endif
> +    case AUDIODEV_DRIVER_WAV:
> +        return dev->u.wav.out;
> +
> +    case AUDIODEV_DRIVER__MAX:
> +        break;
> +    }
> +    abort();
> +}
> +
> +static AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev)
> +{
> +    switch (dev->driver) {
> +    case AUDIODEV_DRIVER_NONE:
> +        return dev->u.none.in;
> +#ifdef CONFIG_AUDIO_ALSA
> +    case AUDIODEV_DRIVER_ALSA:
> +        return qapi_AudiodevAlsaPerDirectionOptions_base(dev->u.alsa.in);
> +#endif
> +#ifdef CONFIG_AUDIO_COREAUDIO
> +    case AUDIODEV_DRIVER_COREAUDIO:
> +        return qapi_AudiodevCoreaudioPerDirectionOptions_base(
> +            dev->u.coreaudio.in);
> +#endif
> +#ifdef CONFIG_DBUS_DISPLAY
> +    case AUDIODEV_DRIVER_DBUS:
> +        return dev->u.dbus.in;
> +#endif
> +#ifdef CONFIG_AUDIO_DSOUND
> +    case AUDIODEV_DRIVER_DSOUND:
> +        return dev->u.dsound.in;
> +#endif
> +#ifdef CONFIG_AUDIO_JACK
> +    case AUDIODEV_DRIVER_JACK:
> +        return qapi_AudiodevJackPerDirectionOptions_base(dev->u.jack.in);
> +#endif
> +#ifdef CONFIG_AUDIO_OSS
> +    case AUDIODEV_DRIVER_OSS:
> +        return qapi_AudiodevOssPerDirectionOptions_base(dev->u.oss.in);
> +#endif
> +#ifdef CONFIG_AUDIO_PA
> +    case AUDIODEV_DRIVER_PA:
> +        return qapi_AudiodevPaPerDirectionOptions_base(dev->u.pa.in);
> +#endif
> +#ifdef CONFIG_AUDIO_PIPEWIRE
> +    case AUDIODEV_DRIVER_PIPEWIRE:
> +        return qapi_AudiodevPipewirePerDirectionOptions_base(dev->u.pipewire.in);
> +#endif
> +#ifdef CONFIG_AUDIO_SDL
> +    case AUDIODEV_DRIVER_SDL:
> +        return qapi_AudiodevSdlPerDirectionOptions_base(dev->u.sdl.in);
> +#endif
> +#ifdef CONFIG_AUDIO_SNDIO
> +    case AUDIODEV_DRIVER_SNDIO:
> +        return dev->u.sndio.in;
> +#endif
> +#ifdef CONFIG_SPICE
> +    case AUDIODEV_DRIVER_SPICE:
> +        return dev->u.spice.in;
> +#endif
> +    case AUDIODEV_DRIVER_WAV:
> +        return dev->u.wav.in;
> +
> +    case AUDIODEV_DRIVER__MAX:
> +        break;
> +    }
> +    abort();
> +}
> +
>   static void audio_validate_opts(Audiodev *dev, Error **errp)
>   {
>       Error *err = NULL;
> @@ -2127,37 +408,6 @@ static void audio_validate_opts(Audiodev *dev, Error **errp)
>       }
>   }
>   
> -void audio_help(void)
> -{
> -    int i;
> -
> -    printf("Available audio drivers:\n");
> -
> -    for (i = 0; i < AUDIODEV_DRIVER__MAX; i++) {
> -        const char *name = AudiodevDriver_str(i);
> -        AudioBackendClass *be = audio_be_class_by_name(name);
> -
> -        if (be) {
> -            printf("%s\n", name);
> -        }
> -    }
> -}
> -
> -void audio_parse_option(const char *opt)
> -{
> -    Audiodev *dev = NULL;
> -
> -    if (is_help_option(opt)) {
> -        audio_help();
> -        exit(EXIT_SUCCESS);
> -    }
> -    Visitor *v = qobject_input_visitor_new_str(opt, "driver", &error_fatal);
> -    visit_type_Audiodev(v, NULL, &dev, &error_fatal);
> -    visit_free(v);
> -
> -    audio_add_audiodev(dev);
> -}
> -
>   void audio_add_audiodev(Audiodev *dev)
>   {
>       AudiodevListEntry *e;
> @@ -2189,65 +439,6 @@ void audio_init_audiodevs(void)
>       }
>   }
>   
> -audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
> -{
> -    return (audsettings) {
> -        .freq = pdo->frequency,
> -        .nchannels = pdo->channels,
> -        .fmt = pdo->format,
> -        .endianness = HOST_BIG_ENDIAN,
> -    };
> -}
> -
> -int audioformat_bytes_per_sample(AudioFormat fmt)
> -{
> -    switch (fmt) {
> -    case AUDIO_FORMAT_U8:
> -    case AUDIO_FORMAT_S8:
> -        return 1;
> -
> -    case AUDIO_FORMAT_U16:
> -    case AUDIO_FORMAT_S16:
> -        return 2;
> -
> -    case AUDIO_FORMAT_U32:
> -    case AUDIO_FORMAT_S32:
> -    case AUDIO_FORMAT_F32:
> -        return 4;
> -
> -    case AUDIO_FORMAT__MAX:
> -        ;
> -    }
> -    abort();
> -}
> -
> -
> -/* frames = freq * usec / 1e6 */
> -int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
> -                        audsettings *as, int def_usecs)
> -{
> -    uint64_t usecs = pdo->has_buffer_length ? pdo->buffer_length : def_usecs;
> -    return (as->freq * usecs + 500000) / 1000000;
> -}
> -
> -/* samples = channels * frames = channels * freq * usec / 1e6 */
> -int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
> -                         audsettings *as, int def_usecs)
> -{
> -    return as->nchannels * audio_buffer_frames(pdo, as, def_usecs);
> -}
> -
> -/*
> - * bytes = bytes_per_sample * samples =
> - *     bytes_per_sample * channels * freq * usec / 1e6
> - */
> -int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
> -                       audsettings *as, int def_usecs)
> -{
> -    return audio_buffer_samples(pdo, as, def_usecs) *
> -        audioformat_bytes_per_sample(as->fmt);
> -}
> -
>   AudioBackend *audio_be_by_name(const char *name, Error **errp)
>   {
>       Object *obj = object_resolve_path_component(get_audiodevs_root(), name);
> @@ -2268,51 +459,6 @@ const char *audio_application_name(void)
>       return vm_name ? vm_name : "qemu";
>   }
>   
> -void audio_rate_start(RateCtl *rate)
> -{
> -    memset(rate, 0, sizeof(RateCtl));
> -    rate->start_ticks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -}
> -
> -size_t audio_rate_peek_bytes(RateCtl *rate, struct audio_pcm_info *info)
> -{
> -    int64_t now;
> -    int64_t ticks;
> -    int64_t bytes;
> -    int64_t frames;
> -
> -    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    ticks = now - rate->start_ticks;
> -    bytes = muldiv64(ticks, info->bytes_per_second, NANOSECONDS_PER_SECOND);
> -    frames = (bytes - rate->bytes_sent) / info->bytes_per_frame;
> -    rate->peeked_frames = frames;
> -
> -    return frames < 0 ? 0 : frames * info->bytes_per_frame;
> -}
> -
> -void audio_rate_add_bytes(RateCtl *rate, size_t bytes_used)
> -{
> -    if (rate->peeked_frames < 0 || rate->peeked_frames > 65536) {
> -        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n",
> -                rate->peeked_frames);
> -        audio_rate_start(rate);
> -    }
> -
> -    rate->bytes_sent += bytes_used;
> -}
> -
> -size_t audio_rate_get_bytes(RateCtl *rate, struct audio_pcm_info *info,
> -                            size_t bytes_avail)
> -{
> -    size_t bytes;
> -
> -    bytes = audio_rate_peek_bytes(rate, info);
> -    bytes = MIN(bytes, bytes_avail);
> -    audio_rate_add_bytes(rate, bytes);
> -
> -    return bytes;
> -}
> -
>   AudiodevList *qmp_query_audiodevs(Error **errp)
>   {
>       AudiodevList *ret = NULL;
> @@ -2322,21 +468,3 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
>       }
>       return ret;
>   }
> -
> -static const TypeInfo audio_mixeng_backend_info = {
> -    .name = TYPE_AUDIO_MIXENG_BACKEND,
> -    .parent = TYPE_AUDIO_BACKEND,
> -    .instance_size = sizeof(AudioMixengBackend),
> -    .instance_init = audio_mixeng_backend_init,
> -    .instance_finalize = audio_mixeng_backend_finalize,
> -    .abstract = false,
> -    .class_size = sizeof(AudioMixengBackendClass),
> -    .class_init = audio_mixeng_backend_class_init,
> -};
> -
> -static void register_types(void)
> -{
> -    type_register_static(&audio_mixeng_backend_info);
> -}
> -
> -type_init(register_types);
> diff --git a/audio/meson.build b/audio/meson.build
> index 417670bd4c7..d2ff49280ba 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -2,6 +2,7 @@ audio_ss = ss.source_set()
>   audio_ss.add(files(
>     'audio.c',
>     'audio-be.c',
> +  'audio-mixeng-be.c',
>     'mixeng.c',
>     'noaudio.c',
>     'wavaudio.c',

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


