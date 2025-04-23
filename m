Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A3C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 10:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7XHq-0003dH-B3; Wed, 23 Apr 2025 06:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7XHo-0003cK-8P; Wed, 23 Apr 2025 06:25:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1u7XHk-0004PS-Ai; Wed, 23 Apr 2025 06:24:59 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N9dS3N000957;
 Wed, 23 Apr 2025 03:24:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=sfi73rD5S40Is1/3xOkTlR+Jjw4LRpyMKiWFwAzCI
 C0=; b=d0INExvVg9wdOslIVOys/eofltxT9mPAZxzb7FzL/OuMA/Ni3XWtCPUsL
 5PRu/rReBa0gBEZy88xAclabO8cNy27emZRCNFDyGQaG6OLalrRdxZM70S2/PuVc
 WprGgEaw47p2dIq2iIHnb59wEVzJkmfSL+LblHBPMBRWBQSYFzbNy2DtjQetH/Be
 LIeovvB14Qtle/y49PM9JnTe9G2Z7e9GNqH2AoFEekE8+Vpp1BoAIe34J+HiG1fv
 /CYtJvdjmMqv7SDVkynod1yqAfbaKjMFJdrEUMoRCweP61c5S+y97O5DM5ns8DVs
 49ubgNBOU3GrSYCs0k3aQ+q9fyCig==
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 466jhtsfpu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Apr 2025 03:24:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsz8QvETf/E0XeLz2ydio3jeMrQXrKbi1kxWyAd2xc/pNwPtTXXCFcBeG0yWwAio5FQFkAyRJCu9EUsFuZsqD0hTGRtyemN7s8+SNATCdqEQDusRcvkckmweM/wETwW8QQZGIv3K8gWhbEs7KEJ7rgrbTkT5O20PjKC+69wcKH+Fs8GW6y+NV0hFot0LWEBMTI1+6kCClrYKmFUCNt0OKa/AVJLXRFej1Vce4XLPRQLHml6WUwhjI5nkvrNx8E7o9bG2h2BorwlNlsyDY9AOpdd6UxIVyTAX27M0PWLtlhAYfCiClfONy6ynn0W3LBQJVqdei8I9k1/XMyNhE+k1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfi73rD5S40Is1/3xOkTlR+Jjw4LRpyMKiWFwAzCIC0=;
 b=GQdXgfaTLJWAfXGAmgCJnTQVlqERJiUdHeXCdbTXiiz8wOj5KSA9n6ipa2AAiCJMo1olJOuOPPIuPJwK37E/gbs6OKrjtYFmm1T+ydIpT4O9DZtIvVO8Q2VVf6dWOmmesWBeTnsjyzW961UQgJOhkLTFD8wAUnTlXrY3GTJHSZzcPA/nDwq/r7enfdxAHa2HYl8/G5GTqF1uBdL6XMjX7KJK4UzI9HiOiGAAyZRfvRkSnknzanvk0sJbmccY49AkhysP5R9bw6qCxEFRMqJx8DWIAvcALeVdDPyIdiQbr/qDRnhGGsOjVzv+y5/SoDB69MUEr/4splUXQSS3NTrglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfi73rD5S40Is1/3xOkTlR+Jjw4LRpyMKiWFwAzCIC0=;
 b=VCp30w665vinHmoCPhqyWHoZhEvcJawdlK982SsH5uml/r4KDU26wfq35MjAlCGI07TpupEkfN6qbOFvrD7bCOJEc9qamSRykX8rjkfdXTMEXi8JHC55mYfubUWCBbGILyEFZ9yf5Rg6RXWhvweJfJBKTxmiF9ipGTnlMVcKErl5foq+F1dEbELg+YMnC2s4fxkOEXwMr0oQwItHczJx+75qovho+6qGu8L3KMMO52l/my7KDpbB7+3DvBFJ8Y7B5vZeeVfkOg4wwiPhHpRyeFIc5V9sVibPPG4LKw6451fIvshNC0TaooUZcL+fqNcZcs31lYoaF//piuBVhoP2gA==
Received: from DM5PR02MB3356.namprd02.prod.outlook.com (2603:10b6:4:61::16) by
 LV8PR02MB10165.namprd02.prod.outlook.com (2603:10b6:408:191::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.9; Wed, 23 Apr
 2025 10:24:42 +0000
Received: from DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241]) by DM5PR02MB3356.namprd02.prod.outlook.com
 ([fe80::72bd:6790:f9e7:f241%3]) with mapi id 15.20.8606.029; Wed, 23 Apr 2025
 10:24:42 +0000
Message-ID: <f1e58101-66eb-4303-88c6-318da1aeeecc@nutanix.com>
Date: Wed, 23 Apr 2025 11:24:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/i8259: Remove unused DEBUG_PIC define
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Cc: "Michael S.Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250423101125.B243A55C592@zero.eik.bme.hu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250423101125.B243A55C592@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::13) To DM5PR02MB3356.namprd02.prod.outlook.com
 (2603:10b6:4:61::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3356:EE_|LV8PR02MB10165:EE_
X-MS-Office365-Filtering-Correlation-Id: 608e25db-7fa1-435b-fe6c-08dd82510f63
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWF3ODZaTXY1UjFHbkZZa1ZxNzlSaEFIZ0xrUVRnVkhXc0c3SldXSjVTclVY?=
 =?utf-8?B?cG80TGUzdkMrUytQeERkMTM1UzM0NGhJUlZIMm5qL1RxRHlkWnh6OVVqVUJ0?=
 =?utf-8?B?OTZuZWdVVXpUdVQ4ejVLcUZDOUhPczNmdEFFaEpyUFFXaC9rN2JlZStHOHls?=
 =?utf-8?B?YUJLSys2MlJIM3RXMm5IWUc3Y1oxNDRvVFJra0FXMXRwWHVXTGJKN0E1V29k?=
 =?utf-8?B?UTh6TTR1UUsvdDBnSWdsLzB3MEE1K3VpQnVJc2hDQVcwRml4cEQrWHpRTTFt?=
 =?utf-8?B?NUhFWFd5NDdWM0UwV1kxRnJmSFYwQ3JhRFBERGhvbmxYTXBtTTdvNVAwcGdS?=
 =?utf-8?B?bGNZNzVLbTErSURBN2RKV3NwZzkyNEJ6SGZWRittQ0g2VnZKejZXb0tkT1pN?=
 =?utf-8?B?S1BIVjVRaHRIbnlRNEFYaG9Ld3pJOXE3SnhHbE1vTml1RS9UK0s0U0NzT3J1?=
 =?utf-8?B?NFJsRTZTNkl6RWtoMnZUUVZoV0VwMkM0WUZCYnFENUNGVlNqUGxkRkl0ZE5R?=
 =?utf-8?B?M0QxZGIydk9kTmI3aHR2MHdwb3UzQSt0MW1Id3BCWFZxbDFmNXg2UzY5T1BC?=
 =?utf-8?B?QndGVDJTQnpMRXV0QTFOa2duVXRZR1NxQWU0WUN4SFZmT3BXeE9MYUZaaHhW?=
 =?utf-8?B?clZJVlNvWmtmVDlZNE9BWUxQTnE0UHFpSUoxSHhUamhDbFdoYldnSDQ2Q2N5?=
 =?utf-8?B?VVI1d3ZJeU50T2p2SUxFdndTbi9qZy9ZSnJibXkwb25pdG90UVEwYWRUcHNH?=
 =?utf-8?B?Q3FqMHNBbmpiL0lLT2hXYVF2OC8zclRxUE1KbnBxdVZqT3QveXFtSUFrajR4?=
 =?utf-8?B?WVlkNzhMZ2ZiSmJ1Z01JSUVYaFRyN2pEN1AxSnFmcHZWRDQ1SUlSRWVia05K?=
 =?utf-8?B?elRCdGNUMjJNRFFYTTN4U3RwRlk5L3dhcjFUaTBNaWJaNU52Q0ZZczZVQkNn?=
 =?utf-8?B?eXlYYi9rZ0d2YkYyTTJJN3JvZE93M1J0MERRVUdFQjV6MzN6K3RuUy8xY1lT?=
 =?utf-8?B?Ti9zVTBjOWUvTlJDQ3ZtUXdTOWFpWE51OWVoUE1LWUwxQXlNdURleENMbE5s?=
 =?utf-8?B?Ui9LZlJ2cHJPK0JHR2xEQmRoR0FmWjd0UkhXWnR3VEswdTVNOElUS1BKb2xj?=
 =?utf-8?B?SkZDbTB4UHFWYy8xejBkNWxGZHp3NHFtQjdQbFF4WUNUMTI3NHFLcVJTZzJ0?=
 =?utf-8?B?bWx1RmFCdXErSy9UWVFLbjg1ckNzY3FaWHgrSkJncFgxY0EwVDJnSVNmVEFM?=
 =?utf-8?B?UzVrTXMxa1RTVE15RCtoVXFHMjkwYngybWZ1ZHNZS2JaZnVGRjBIS2ZPS2dt?=
 =?utf-8?B?T1pzOXFKZ1ZNVWFuNnRBbGptc3hWcjBmVTJPNGVFdmlDQUlyYU9OY01qV3V1?=
 =?utf-8?B?d016MHk5TUF3TE1EdGlzRU10UElwb1RlZmw2bGp6YUVOV09hQjF3UnlOVHJx?=
 =?utf-8?B?d2xZMXlYdFBKMllSbzRHYmJxTzF2MnluWWppdkVoSUFCdTlkVzhtY00zUFRt?=
 =?utf-8?B?M1RJS2lWRzBoSC9uZ1c1Z0JlZUZRMWFUendOMEs0bjYrNDBzUGVDSVAxcjJ1?=
 =?utf-8?B?YjI5MUpwa3k2Q1p4enlDWFI4bW1uRmtXTlpqUkx1RGlWNlV0L2hRSGFDWFhv?=
 =?utf-8?B?UzNKZ2Mwbkt4eXRSbTFBZEZ4eDNMR2tkUlllNms4VkRwQy9meWQ0dnF3TTlq?=
 =?utf-8?B?NHM2NDZQNHhETUdjMXdMVXdUTngrS0pUYzl6ZFFEM213bklxSzk5dFZ2QXZF?=
 =?utf-8?B?RlNjK0daNVQ1OTBtUlNBL1h4WUtUZzloS281K2ZtUVFLa3N0YWVvc3grMEdT?=
 =?utf-8?B?UlVuUkN6T3hCaTZoS0FSZm1nR3dyNThOVU1Ud215S3dkTWErMEtjcDR3dDd5?=
 =?utf-8?B?cFhWN0JmYTgwc3hnVUJJNkxYd0JoUkE1UEd1VWN2NFNoWnpNVE5Kam5wL3Ru?=
 =?utf-8?Q?7XfCPsuVEX8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR02MB3356.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVVORTN4QmJXNmRaRXRRNERoNmlBT0NZMmw2aEVNV01TdjE1eVRhRU02MWZj?=
 =?utf-8?B?ZEw1Sll4aDJadnBKZzk1OUhvNEtCTkU4S1FxSk9RazZabkJiRXV3YWo4NUNB?=
 =?utf-8?B?eHZTVHczNmZST0NFRmQ5OFgxbzk3d0JSeGdWbWYvN0FoczFpM09nS0lOMU5P?=
 =?utf-8?B?TXpETlpqZGdkYTFSTTJBYTU1aFhRNTZUVzQrUEJGdUphTi96Yk5oT3FTb0ha?=
 =?utf-8?B?Y3lQMkxkT1RyRkxuQWxMVkVjUU9qS2pWeVozNEVHODh2NHBxTmVwVjV4OTRS?=
 =?utf-8?B?UkF5T3I4OWxaMDdCQWptZEpib21zdHEzNW5hQmg1UnRqbkxaRHVlaUMxNXMx?=
 =?utf-8?B?WDFzay9DQm0yZVJ5d0tEUkhrWmpCRVhtdWgzaWU1NTNnZHNTVXYzWGFrN2F2?=
 =?utf-8?B?RWh1VkQrb051QU5BR3ExYlN4ZzZxRThNdGljQVdzY2VjdWc2WUNNQWx6Sm5B?=
 =?utf-8?B?Q0Q4VEV5OHhyVU4yQXdNZCtzQXJJNnVmOUlVSUN6eFlVVGRKOCtkYnhJb1BS?=
 =?utf-8?B?bnlXLzFnYlZuSzk4ZEptUzhFK2k5a1h0WitpR2hzbHVaTVlIOThuZ0ZpL25O?=
 =?utf-8?B?Uk5ET2JkQkRCTHZXQVBlT09YdXc1SytLSmNiNlRnTnlPY0tDR2I4WnVhMVk3?=
 =?utf-8?B?TDV3aUVVRGpLZW5pRThRN2E2Z2ZDN0dVOEhTckR0YkszZWZRTVAxVlpYV1d0?=
 =?utf-8?B?SmhiY29xT2NMaFJ0Q0E0cDAvWGowdmRRMFY3S0ErZ0JlQlVOKy9JMzZWZmxp?=
 =?utf-8?B?TzNhdWd4UDRVNE0zRWpEZGJhSmNLUS91MFovdzVuWnUwWFk5TG8zeG1KTmh1?=
 =?utf-8?B?VmpnaENISGt3N3B3alpqWU5tcnNTemdTdSs1NEsyYnB0N2xham1nNEkzVVJj?=
 =?utf-8?B?Y2FVT2drL2tkUUVnRDkrNXI3MC9KVWRIbVBhdnZKWHhEdmV5Mms3QlB3TTVw?=
 =?utf-8?B?cSs4T1lHRmxqOXQybTNlOEpMaEY0K3ZqZncvVHpRTE9HWjRGTE1hS0dUd3E4?=
 =?utf-8?B?eVpVV0tpa1pPM0ZiZGYrbWRram1PL250U3JpcjROK0pDd1JiWGxiTGYzZ25E?=
 =?utf-8?B?WXlEUUtuSzVZc3lYZTRzRERlempkT3hQYVA3MUZMQjMzVkEzUEF2dlA1RFBO?=
 =?utf-8?B?M3FvYWFjQzlkNFE1NFAvZ1FxVUVtTVZ3UTJnMm5aN2FHVm13R1RIVmFGRjcr?=
 =?utf-8?B?d3NCeXhiazVFcDhpelZjU0VueGJJc0xJL3ZtdnhJVHRycWhYZ0hsZzd2elRt?=
 =?utf-8?B?U25pVWs4WS9iT1cyOXBhZHpsL1ZTVytSQmtDVldGZWIxaldBUFZ1bGZBT0wz?=
 =?utf-8?B?QUZnQ09YdHNCaysxaHh3cCsvNFZQZVlIZ3d6YnBJWFBwV3ZuME5IWkhoV1N6?=
 =?utf-8?B?NE5rVUlCaWpGN1lRSFNvMFd3ME90cHludEJjY1F0Q1NvaXdpd0xzWTVvaURl?=
 =?utf-8?B?V0dQWXZubGNsL1Y3L0dJVDVIUjI2SWZMOXl5S0UzVElkU1g2Nk5OeEZJdDFP?=
 =?utf-8?B?dU50aU5McEc4UEw4eUI0cWxxWWVzYmhzMUNkeEc2dHlnOGFoZ09xYVI3OVFv?=
 =?utf-8?B?bEt2dHcxZHlaakR3SFAzdGJKdHVDQWFaZEFEcWtRQkpTaG9yNEJ3MTFsdk9t?=
 =?utf-8?B?SzN0cndqSG5nYVRybmNiS1Z1MzRaSWVrbXQzOVh3VHF3ME1wTXlrU1Fibk0w?=
 =?utf-8?B?UU92NlBLZVg0Q2F2S1BCNDIyT0drQk1mVndwL2NQM25qSHRCMTJEYzBVUkw0?=
 =?utf-8?B?MWE1V210ZHZ4K05kZXlVVEtuYmNBV0ZoMVJmeTVjNGVvT0xiRXVLOTM3Rmgy?=
 =?utf-8?B?Yzdxd0pGK1BSZHJoOEtaem4yOU1qelcrM2lJSnpqeXBhdVlGQlFVTmxFd2JU?=
 =?utf-8?B?K0VYYk05SDFIMncwYkVGSWR0UGFYbDJmZzlqTE9OUW1Jcnk3d3hwQjRBdWtn?=
 =?utf-8?B?a1FEaHRQM0g5YUcydWRqTDV4elN2TkdPd3Y4bTlxYzY3dFNVclp3QjcxZ1lx?=
 =?utf-8?B?aDVjTlNIZS81K1I3aFI3NVhhSlVRTGUyZkdiM1ZnNFF1K3RuQmlZV2Z0UUdL?=
 =?utf-8?B?cHJEVE0yMjkxRWtmMUYvWWlBSDFnVFZZRjlQS1dQRDlOdWNHS2lMMEdRcTg2?=
 =?utf-8?B?QjlHY2RGRlZCSUVWRWpBbDB0RjU1Y2ovVWZzdUpEY0N4dFFHNjIwNnc0UVFQ?=
 =?utf-8?B?aHYvak0rWlVmUjhWejkzZU1Ta3lwenluRlJ2M2NsMU5RTFVscHB2N0VTbEVH?=
 =?utf-8?B?NllrUWxLSFU2UkdNaWdVcXVCb2Z3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608e25db-7fa1-435b-fe6c-08dd82510f63
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3356.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:24:42.0968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsuccnjfERLlCLxFtmvjMsr4sPqpSLfbuEoyqtRuvYwFmovrWJ5z7d2BcaQCfrwp9/c3/dtYn4JetNnkBVpkCHNJB15ZaXPphjXcacDU9Wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10165
X-Proofpoint-ORIG-GUID: TP3-00UQDqr4McDp7-jEyYho3hH1nfF7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA3MSBTYWx0ZWRfX03AV8/hECAr7
 8kFOZokYNVvH31AjAEEhtnbYbG102vlBLX4WMZG8KuIXmriRRBjK2DHqmCh/Aejo7VnTKrhZqIh
 vriTup4wjuT55LzMiV9Muo0Wm9FFxHAFzQeiNYfhA2tWwzVQIoDD3NabWUrbab/P0XlvGCGPxMq
 FkYYCI0WRDzbQZwVUm83EgbKI6FMsQ7uf09IdB8ntau2tUF6Rej+a3Vp69kc4VOci6WYqMmxGVw
 5DyvO7qSfDJHT9THybO9GYonU/Nl24uTgLJf0vt16wYC1Fngi9EgSk/V6BTeITmE7tks8ES8uNS
 SM0W0NC7GtNDc45KZPn4TvJvxHfFGAeDSNv+RLn6x9KHn/mC3Os+aP4exbtoUmFkqkxx52mlI+F
 4YharFgp/Ez92iHKjwnzWxLjzrx0+v0LrPOaZAWTc7tzKsOsHmsmXS4QgWoFzHIsMWIAXT52
X-Authority-Analysis: v=2.4 cv=KLlaDEFo c=1 sm=1 tr=0 ts=6808bfed cx=c_pps
 a=yZcDG7BW7OBBh6O1hU8nvQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=XDjT7n65s6PepbebdBUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TP3-00UQDqr4McDp7-jEyYho3hH1nfF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
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

On 23/04/2025 11:11, BALATON Zoltan wrote:

> The debug printfs were converted to traces so this define is now unused.
> 
> Fixes: 0880a87300 (i8259: convert DPRINTFs into trace)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/intc/i8259.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index d88b20f40b..6a204f7d21 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -32,10 +32,7 @@
>   #include "trace.h"
>   #include "qom/object.h"
>   
> -/* debug PIC */
> -//#define DEBUG_PIC
> -
> -//#define DEBUG_IRQ_LATENCY
> +/*#define DEBUG_IRQ_LATENCY*/
>   
>   #define TYPE_I8259 "isa-i8259"
>   typedef struct PICClass PICClass;

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


