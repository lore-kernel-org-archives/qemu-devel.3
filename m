Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070DBEDF176
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 16:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqvo7-0002ig-Gz; Fri, 13 Feb 2026 11:14:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvny-0002gx-Fb
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:14:10 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqvnt-00081t-3C
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 11:14:05 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7mXKY170468; Fri, 13 Feb 2026 08:13:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=an6rp/fuViRAoJAGGKva63hRo9OZtGOxFz5jvHh5l
 Cg=; b=cMXid1ip+EoYDGrPMnXJd4hpIVTJIN9pLGrlfJWdb1L4l9i+KPof6E3yZ
 nkb+EZPu/KFTJEWlUcifIWSdnRpGV4FVEaPMnhZ4aG7P4NtcB1n+7cuxynEYIfBW
 ax29PSXnLn85Iv+iPYVWIEqBOwjANnYbv2Js7vooVFFo8nWi6GCFw/DQlB50qIFB
 xYTOKx+vYrpXU7atxKqlh51OsWG+paDlc1G840aBpHv1u3J9NsSpV/VubtUkKywL
 nyZNpo2uqnL1A37SVs4T5vuybsBMhnFpdiAIZ31TTB2hc5NJfND9tfP99Cy6zzaa
 XuT8fE4msG98/JwYVs1WzVz5uL9dA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021120.outbound.protection.outlook.com
 [40.93.194.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9yvvs5je-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 08:13:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjv6lpHt0GoXD/mnB18hnj7I0MGgn3fC01hQTqHGkndZvW+wT0AnAnTVUhSM/DRLpTzprvF6YxC6/IjUyaklHWN48HuL93kMn48uD2Ou/m9Y0QX5uZPRU5PG5kg0wI7sPxeMVDshFYbmtrSnOT64b7j2qZQoO+m2l2hXdr53GoBiHh2uUZeIuU76Uo8555Dax5yUENcOw8eFzlmNuUapMDs5x8eaz/3f5tjqniLEkzhg5dhuLGDlcTyaO7ItR3519IjS7q696bjr0v2LVwBbwE6/b5x1t0CEMozjAHpczO2BpsvcGf3ZJUFp3rmDwAjyGwfDWd8N43AYBP1UCYzp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an6rp/fuViRAoJAGGKva63hRo9OZtGOxFz5jvHh5lCg=;
 b=vv+17VwTZ82DbSrzwk5jFP7jxnXq4LuWFjokbEi+OqpZy8KtUewB3MQ3/WcQflVxAsI3yyReAleRQRaQNvaTzv90izOg6yQGnzPs4dAMpHdDDkf/nE7izK7jBipPxYoCTOtD61Xn7PABPrnhi5n3JMnRdXteNgEA4erc+q3r8E/FnNfGlpwZNO+4N4+K+3uu1OsG67J86mQEEVOly6HV0En0B93Kf6LGc/zTZyAh8QU5PTDlQG83glbStdSpLMN+IZR3N7Bfc49d483epciQ9xmTGjutyxBnf+rAttDZYRYtVyQ8kuz/5Lk0XPpYk8iwXeX1xDJw2Vga9Ie/PJNd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an6rp/fuViRAoJAGGKva63hRo9OZtGOxFz5jvHh5lCg=;
 b=uZY8ch9hAY5TfyongceIyKbzMiavLVr9vAmZBQVn5tP7uvMiPOgFn8q2sd5k6/iZaZ7qxU9owjNKvuNJ5EZXt1C8OcEjfIBWOMuQh3uKzQnw2E/EJ8zgUMJ/li+krV4Equ/oB5mTJLbdIXQJihfxCZ6Y5UrWMtKsZNfZ0BAiI93W+5rgRLFc5f9YuWbFwrn4QT9KBuV4xcpMp+WvTTyUbf7TsSAiB4vRmzPXXuQJQrHhQbrNylltK6kXzN0LtdDZNPcNNUGjuaHXj7JZUpu4rcwpLwmA7QxZBCg7O4HwOtgYOtXR3LLgkU1dIAx/K5A1K5GCLNKFtPfZQXk5nzDp4w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10249.namprd02.prod.outlook.com (2603:10b6:8:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:13:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:13:49 +0000
Message-ID: <dc42208d-697b-4a5a-b646-f4b87b97f6fa@nutanix.com>
Date: Fri, 13 Feb 2026 16:13:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/43] audio: replace remaining dolog() and AUD_log
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-42-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-42-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:610:38::24) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10249:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4a7a21-e6a9-44d7-2d35-08de6b1adf3b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ak1RQTlXbkUxZThpZGxBaG5xKzg4cHByUnlHVXg4Syt3R1Nodm1wVVpqbURx?=
 =?utf-8?B?Y2Jsb1pnSmRTKzJUZFo0R0p3TFVlb3l6UGJUUTExV1F3RFVCZy8rV3A2eXNY?=
 =?utf-8?B?cmJGTHIzZWt0S3JBTmt2YUZ5RFJOYWVycWNaWnZHZC8wWC9pQWRmbC9pczFo?=
 =?utf-8?B?d1M3UUxSek5YTU1CVkdvb3FHQWtjWmphUDdQL2Rlb0dnc3ZYb0ZhUkRreTJM?=
 =?utf-8?B?VGhTdW1zQjIvQnp1U3JEUVEzbVpUSWdCNTd3WmRtN3pVUVhuTkhwd2xlc3NV?=
 =?utf-8?B?NnM0MlI2MzNjVkdHY0JYY0hlU041U2N2TmlkVE9mRHQ1RmVtSGplc1JuZHlB?=
 =?utf-8?B?MFpmdmNKeVRpNVFhR1Z2UnlIaXlEcWRSNEpUeU5mcXVvM0JkdUk2ZVNzTnZH?=
 =?utf-8?B?bFNWTStkK1RvY3ZTTGx1V2lHRGcramo3WUtNdnYzak85d0FPeC9EMHoxV1o4?=
 =?utf-8?B?UzM1RUJ5SDlCNVltSEVSalZVdVk2aUNFYXFVRjV3cUgvSis4R2tKMy9WZmdo?=
 =?utf-8?B?YittV0lOZjN3Q2p0VVNWWXJ4b0Y1L3RDYkcvamlhdGdtc2F6K3JOQndaQXhV?=
 =?utf-8?B?aWR4dDhHQk9URHRNNzMzL2ZZTjRWc3NJYm1UaDMvREJrSUdIR2kzWlZuWFNF?=
 =?utf-8?B?ZmtpQVhBQVdURVl5YjArN3I4SGRpWW9BWHVXaElPK1NOMlVPMnRReXJyZnRs?=
 =?utf-8?B?UVl4YzYwU0ErMHRua3ZDS3JpQ3luMm5WSmhRK3FaRFpRaG9hRjJyTkpCczcv?=
 =?utf-8?B?VGN5dG1TNWQ4dktCMmZzenJYTTF5czAwUG9TQzRQREtRWHpJVDZIK21YOGRw?=
 =?utf-8?B?aGZIT3hqS3l2aTRNbGJRblFkMktvM1RIUW1jdG5SWXB4QnNPVFdkVWpacVpa?=
 =?utf-8?B?TUxkQUhBZ2hVdXpyakFKM1A5ZVB0NnJkamR2WXFBY0ppRVp3d2FoZXFSajda?=
 =?utf-8?B?d1Mzcm1VaVVFZC81WjY4YjdkVk1GeVdxOGVqK2QxVGo2MmIvSWJWbW9xbmI1?=
 =?utf-8?B?b3JYNUpRODkxbnV6QU9vR2ZyTFltMGdvT2RmeTBJdGdvTEtFS2VmbGRqZmY0?=
 =?utf-8?B?NDZ2dWJKbTFndzBjNDNDZ0RUdXp1ZEZDMVdyN2JxLzRCK0doQmZVNHhZelZT?=
 =?utf-8?B?cno4c0wvUERzMkpYVnZoTUZFUGkySUhmRWtPajhsTmxwS3hnNWtYbUpZSlB2?=
 =?utf-8?B?Z1dwK3ZoeTQ1cElySmcvc1FTWFNjcjZGcnhDZml4WGM2ZFMzR1c1VlV5S3Va?=
 =?utf-8?B?eXh5TDE0QVc5VjFMbktNQ29kb3FoU2FzK2Y2a1RKbWUwaXdSbTkxWUFoZm9v?=
 =?utf-8?B?M2JjU2FOcEVXRzEwbnhlL3RUL0FueGNiMlRqbzg2cmtZdmlGazBpSGVVY0Zi?=
 =?utf-8?B?ZlhUaTA4RVNkUERxd0g4RStleWplSVFJT0dFa2FFV1cvSTNhSDAzNk1WaGhk?=
 =?utf-8?B?U2hkODJDU3Q3d3V6d1R5NDZHSFJSZGl3bm5iVlhCaFR1Y0N2R05BMFdzbUJ6?=
 =?utf-8?B?U1ZUMkFDMkhWbSs5ZjJoa0UxZ1Fudk9HZ1lvRFg3YnJZYkdwN0hNUURuM1Nx?=
 =?utf-8?B?SVRIcUMya1hzU3dOaTgzRGFCazF0dHpVQWFYZytjLzRLSEhGbnBmUCtNQlhk?=
 =?utf-8?B?VURxRVFKakVRU3ZRUTVlbWw5dnExZ09PQ1c1dFpoTjl4VDJObGJSOXV0TmU4?=
 =?utf-8?B?WEZaaDlVallNdlM5Qno4UVFkVXkrY2cwN3VsdmFjT2YzRmpZSkRsNHZneGtV?=
 =?utf-8?B?a1dhTjNxbXV6WGhjUklVNXJCVEZzbUg1R3BwSUpJcDBzVjRYZ2Z0bFJZcVVp?=
 =?utf-8?B?WExoTmd2Yk5TeDdUQ05FRkxoK1FUbWxNS2c3dlB2Y3oxRWxaaUtzUG53cTlG?=
 =?utf-8?B?Z3BQLzVFa1dRZ0JnTXM5ck1kUHZHa1JRdTRCbXhzTlBTZHdEOGdLNTc4bzFk?=
 =?utf-8?B?UUVtdEs4dm9PNjM1aWhNVXhZK1VRUmUxTDJWMjdXNDByTXBSRDhPaWltQmRv?=
 =?utf-8?B?NHgvc1B5Z0VtbTNHY3RVYUpvMlZ2MFVhY2lOMjJ1ZEplblRRd3FEbmRHQjVn?=
 =?utf-8?B?OFRzVnpNTzQzVHE2cmVUMU90UGIycStUY0dvRllGQ09zMWFCSW5xZnB3ZGc1?=
 =?utf-8?Q?6/fU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2YvNGJpMVZySkZiVXhOMjZwMGJWNDhXTFllczZEbUI3QTd5cHk3VklSekdD?=
 =?utf-8?B?dDNROHVBSUlmaU1zL2VtSWlkbk40MElRbUN4aUpETXVhZHR0NFV0SGF4Yzky?=
 =?utf-8?B?VmZwbndSL1JnUWl3WklpVjBzZWV6TVpVaUdkSCs3SlY5REpUQjR3TUNPa1p4?=
 =?utf-8?B?YktneTZWQWQvZ05SOVJOa2RlcnBGSzg4bFE2V04zNWthWkgzVlM0ZWttUEMr?=
 =?utf-8?B?THZEMGZjQXRrS2NDWWFQMWdEQ3BtOTRabGNLVVNvZ1pSQnRYRk1KbU1ZYzY1?=
 =?utf-8?B?V29FWXNpb2ltUnNlWTlOOEFNSmVzSTRWU3VwZE8vVHVmSi9lbUhoZk1hSktC?=
 =?utf-8?B?dGM1SE8zWG4zdTNNY2ZpcVBObTI2aEVMY1FzREExY0RpMmx1dFlCMWZtRllk?=
 =?utf-8?B?Rkl1cHlJWDE0ci9pbmFid0tsQUZPWUdlZW9ZT2hodkVUTHd1eGZEQThMMmNt?=
 =?utf-8?B?ZEtWdXZIRjZtYzR0R0pDMXJBY3lSdlZ5MStQUlQ2TFJsU25lVHZxQUJIL3Uv?=
 =?utf-8?B?SGt4a0xtL29KK2VJeUF6MTN5S0xNQklyL2VCVnYwSE02RnV1UExiTGdpaDg3?=
 =?utf-8?B?TGpqaDVHb3lucU11TEtlOXpIUFYwdWdDQTdCcGVNcmNZTXVDWkthcm53Mk9H?=
 =?utf-8?B?SXk4ZEtmZXNqdnhyNnA0ZUFLeUtxRkQ1QWdsSjhHeHZuYWxSMzU5UzRweU5x?=
 =?utf-8?B?d1ZYWTZCRzJEOXB2SVRSMmdxWEtmTDhkMlhNbFoycXVJZmlSczRzS2dDRjI4?=
 =?utf-8?B?QTdGSGhvYmdFVlN3aGVwTjdINkphMm9IRlZrd0h4MStCSTg0SFZLK0J4NHNu?=
 =?utf-8?B?VjRjQVBRN09ibFR1TkpJVnFVNWtmNzRJZ1JyVlo1OTJXWkRmek16OHVrYkxF?=
 =?utf-8?B?dkZkWnAzbEsxVkZScDcxS0tsT3ZlVEppOU1NbkI2MEEvMU9zd0dTVFFBSVZV?=
 =?utf-8?B?S0Z0OGRWSXEwQVcvcWFTdnVjUHFYUkxOWnRjNXo1anVTb0RSY1BHcnNsWC84?=
 =?utf-8?B?L3RKekxXK0tzN3ROTVV0cU8yNEN1aVVLd1VmY1BQM2RXQUh5Zm8wWStrT3FD?=
 =?utf-8?B?U3o4QldzSm11M2JCaXpQOXJXTVFZdEdISVkzRlAzQTkyUU43bnZmUWpONEls?=
 =?utf-8?B?RFBsRDhLN3l3QmNCUWpnYmdXYndFRmhsSnNpaTdpTjlaY25kV2hCR3VZeUtU?=
 =?utf-8?B?WVk0UVlEYWliMHM5M2NuRnJPYTlxSEZ1MVBYVjJUZE5pUjJrd3ZCWnZQMlQv?=
 =?utf-8?B?d2JnWTZ0eWk3dnY2d3pxa1ZrUGhlcFlOOGNXT0IvaVcrb3M5M3pzNkhMbU5U?=
 =?utf-8?B?ZHZnc2dSVmtnSjIxcnJQTzlUWWd0T3hjRldJdHV6NzhzOWpLNG5NY2x6WElW?=
 =?utf-8?B?YlZLOE1wbWtWM081UHZzNm9DNDA0bkxFSjZPWTAvT2dOQVlDaW03QXEwU0xL?=
 =?utf-8?B?b0QrWUlxL2dMNmV6NmNTRVdJbWZPTFZHVzF3bjFWaVlkaVVkNm5RL0pwSU9k?=
 =?utf-8?B?R2x0V1JlTkw0T1Y1VitqaGg1ZG5ObUVqTEJaRk1OSjgzc2xXcVRNWDNKcGw5?=
 =?utf-8?B?dG1CL2NZSEo1TUJvOHAwWStZSXhpbUY2Sjd3RlIrUThJRUdxSjA1c0NuVmJI?=
 =?utf-8?B?Ry9QYmt5VjFCU1EzYmFLc3FpSkw2M3MxNXNqQ2Z5T0pSQWREdlA1dEFsOHE5?=
 =?utf-8?B?QjhzRFpac0lpZkw2a0RGM2pSWWQ1MEdENVpTZjJobVpGQWlQc0V2cHdjRDZk?=
 =?utf-8?B?N2RCZ0cvaEMzSVpVVEE0OC9NeG1aU1NkVUtQbW1vcGxQUWljV3ZzNU5DbVMy?=
 =?utf-8?B?SS96ZndVNm53T0luVDNPRkFzWmZJT2V0MjcwbzBrcHBrbWdkWC9Ya0QxZFVj?=
 =?utf-8?B?YUJtQ2pDMlhaNjNibFVZY0pvQ1VLditZZDJjVk4zSGpoZk1JaGs1N1dKbHp0?=
 =?utf-8?B?d0I1VUc5TFU2TERzMzl4RThkMkVEWUc2bmtNeno0NlBidVd5UHdZR2dmaSt4?=
 =?utf-8?B?dU5lT0orU1NVL2pQdnFIbHRDU2pzZTlCMVRNSzNTMnFGZldCcWJYd2dGRVk5?=
 =?utf-8?B?ODFmam5OTXMwckdnL0hLRC9LYktjRVdNRzJhRG4vTlRWaXNCcSswTXVZanJj?=
 =?utf-8?B?V0hBTVl6UC9lTS85Z3hjbVpETWF0RnUwM2FuZHY1VlpPNmp4dUJZc28rV2Nt?=
 =?utf-8?B?d1ZqY0JLbHNIWXVEQSt1VzkrTCs4SVcrbTA3WkZLZ0ZoSlFhSnhtdU1DcGJ6?=
 =?utf-8?B?cHhrYVVhK2NiSjBaaTU4Uk1EVFk5NmdDWTEzcXRsdTlRMitTTlZHZkorY3RT?=
 =?utf-8?B?eTkya3B3Zzc2UUUyUGUzU1RaQXdzVWxFcklaaEd6TlZKS08zaTlCWk91RFgy?=
 =?utf-8?Q?mzeJcRKPPl/oonxs=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4a7a21-e6a9-44d7-2d35-08de6b1adf3b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 16:13:49.3309 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ki8Yg45Acu398QBOot0A9R3zXCsgVlx1BPF0aYj46S4p/aQ4Xva13HP8PbO0ytsBqjt/QD2NnvZW8X39sPk5P/ZBqBa2Syw3PhxInDe8kV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10249
X-Proofpoint-GUID: DgrXt2CAffT2irgiVvDu9KbTgwpI7QT0
X-Proofpoint-ORIG-GUID: DgrXt2CAffT2irgiVvDu9KbTgwpI7QT0
X-Authority-Analysis: v=2.4 cv=CegFJbrl c=1 sm=1 tr=0 ts=698f4dc5 cx=c_pps
 a=8gBNOmLjUAHmmJW2BE7dxQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=cbNkBh0BYkQAmlPUUX4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDEyNSBTYWx0ZWRfX3VItR5JEgx8j
 cARBDvF9pipBKTMWgWu0iSl2ZzEAD+THiRCgXe+iWl2bf8M3K+QOqBFEWPH8y+WhICnoA0F3gtY
 2o5wAV2LmWMwkZ6u4RZ7d6TCwq/vlt4LaubDlYnHpH/qGQJP63h+CZ7znmCl+6mLSDwlsX/lXYc
 w2TVpM/1CfM94QUyEvq1JWfKzLfPc6b3O90/NPG8ApHvH321WxhCXLVB+FtGjAtef/GD6B8xGIg
 egdtkc85WYFKBPt00YUdYtD70+e4KnTE0jYX7xRfr/EOJKFkfIcbryxKFiuErE55dVypFQy9FtG
 xGSdDH3PHgGovmi+3zoXGUq011yW45fW8fOZ33l3o2O0Yebtj4e5H5vwjuW5bW2AtKZr+YqbekS
 U07GFuwttxxya9IDTOFRZyoKhGQAPDoJcNKANzN0bY4tQi+gS2oyjEGuOyOh9oywhb0Gp+vl/W4
 iPOSWWHJAkTHXG7IHRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 27/01/2026 18:25, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Use warn_report/error_report and trace instead.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_template.h  | 19 ++++++++-----------
>   audio/audio-mixeng-be.c | 14 ++++++--------
>   audio/trace-events      |  1 +
>   3 files changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index 9dde36738bc..760aaf5f31f 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -47,21 +47,19 @@ static void glue(audio_init_nb_voices_, TYPE)(AudioMixengBackend *s,
>       if (glue(s->nb_hw_voices_, TYPE) > max_voices) {
>           if (!max_voices) {
>   #ifdef DAC
> -            dolog("Driver `%s' does not support " NAME "\n", k->name);
> +            warn_report("audio: Driver '%s' does not support " NAME, k->name);
>   #endif
>           } else {
> -            dolog("Driver `%s' does not support %d " NAME " voices, max %d\n",
> -                   k->name,
> -                   glue(s->nb_hw_voices_, TYPE),
> -                   max_voices);
> +            warn_report("audio: Driver '%s' does not support %d " NAME " voices, max %d",
> +                        k->name, glue(s->nb_hw_voices_, TYPE), max_voices);
>           }
>           glue(s->nb_hw_voices_, TYPE) = max_voices;
>       }
>   
>       if (glue(s->nb_hw_voices_, TYPE) < min_voices) {
> -        dolog("Bogus number of " NAME " voices %d, setting to %d\n",
> -               glue(s->nb_hw_voices_, TYPE),
> -               min_voices);
> +        warn_report("audio: Bogus number of " NAME " voices %d, setting to %d",
> +                    glue(s->nb_hw_voices_, TYPE),
> +                    min_voices);
>       }
>   
>       if (!voice_size && max_voices) {
> @@ -443,7 +441,7 @@ static SW *glue(audio_pcm_create_voice_pair_, TYPE)(
>   
>       hw = glue(audio_pcm_hw_add_, TYPE)(s, &hw_as);
>       if (!hw) {
> -        dolog("Could not create a backend for voice `%s'\n", sw_name);
> +        error_report("audio: Could not create a backend for voice '%s'", sw_name);
>           goto err1;
>       }
>   
> @@ -537,8 +535,7 @@ static SW *glue(audio_mixeng_backend_open_, TYPE) (
>           HW *hw = sw->hw;
>   
>           if (!hw) {
> -            dolog("Internal logic error: voice `%s' has no backend\n",
> -                  SW_NAME(sw));
> +            audio_bug("Internal logic error: voice '%s' has no backend", SW_NAME(sw));
>               goto fail;
>           }
>   
> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
> index 4988627279e..6799b7664b8 100644
> --- a/audio/audio-mixeng-be.c
> +++ b/audio/audio-mixeng-be.c
> @@ -654,7 +654,7 @@ static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
>       hw = sw->hw;
>   
>       if (!hw->enabled) {
> -        dolog("Writing to disabled voice %s\n", SW_NAME(sw));
> +        warn_report("audio: Writing to disabled voice %s", SW_NAME(sw));
>           return 0;
>       }
>   
> @@ -677,7 +677,7 @@ static size_t audio_mixeng_backend_read(AudioBackend *be,
>       hw = sw->hw;
>   
>       if (!hw->enabled) {
> -        dolog("Reading from disabled voice %s\n", SW_NAME(sw));
> +        warn_report("audio: Reading from disabled voice %s", SW_NAME(sw));
>           return 0;
>       }
>   
> @@ -874,9 +874,8 @@ static void audio_capture_mix_and_clear(HWVoiceOut *hw, size_t rpos,
>                   sw->empty = sw->total_hw_samples_mixed == 0;
>   
>                   if (to_read - frames_in) {
> -                    dolog("Could not mix %zu frames into a capture "
> -                          "buffer, mixed %zu\n",
> -                          to_read, frames_in);
> +                    audio_bug("Could not mix %zu frames into a capture "
> +                              "buffer, mixed %zu", to_read, frames_in);
>                       break;
>                   }
>                   n -= to_read;
> @@ -1561,7 +1560,7 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>       }
>   
>       if (!audio_get_pdo_out(s->dev)->mixing_engine) {
> -        dolog("Can't capture with mixeng disabled\n");
> +        error_report("audio: Can't capture with mixeng disabled");
>           return NULL;
>       }
>   
> @@ -1754,8 +1753,7 @@ size_t audio_rate_peek_bytes(RateCtl *rate, struct audio_pcm_info *info)
>   void audio_rate_add_bytes(RateCtl *rate, size_t bytes_used)
>   {
>       if (rate->peeked_frames < 0 || rate->peeked_frames > 65536) {
> -        AUD_log(NULL, "Resetting rate control (%" PRId64 " frames)\n",
> -                rate->peeked_frames);
> +        trace_audio_rate_reset(rate->peeked_frames);
>           audio_rate_start(rate);
>       }
>   
> diff --git a/audio/trace-events b/audio/trace-events
> index ed04792d508..222e73c7e88 100644
> --- a/audio/trace-events
> +++ b/audio/trace-events
> @@ -70,6 +70,7 @@ audio_sw_write(const char *name, size_t size, size_t written, size_t total_mixed
>   audio_get_free(const char *name, size_t live, size_t dead, uint32_t frontend_frames) "%s: get_free live %zu dead %zu frontend frames %u"
>   audio_out_disable(void) "Disabling voice"
>   audio_out_played(size_t played) "played=%zu"
> +audio_rate_reset(int64_t frames) "Resetting rate control (%" PRId64 " frames)"
>   
>   # audio_template.h
>   audio_open_out(const char *name, int freq, int nchannels, int fmt) "open %s, freq %d, nchannels %d, fmt %d"

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


