Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8309E87845
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnJ03-0008Sp-4y; Tue, 03 Feb 2026 11:11:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnJ00-0008SA-MV
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:11:32 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIzz-0004CO-10
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:11:32 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613EFG1k1438401; Tue, 3 Feb 2026 08:11:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+FysZLCZsH7nII7OfxyojTC0RFsmsg5eJcQoOoTH5
 bM=; b=MG4heWe/x34c4nnEIRMzdpJW57O92vm00ZGStAdTBeCoyodDN9LeA1V6s
 odeglGBrXxf+MDxRzpL4yQxAwWZtiv6K8NlxSyxiOQKYnQSSQtwPeNlsvuV4WvTJ
 dNeujVJcaETIjswo7huy1mIB2GuvKViTsmv1/r+nRqGzni0OFs5umBd8z3H2C0gV
 aKeel1MJA9LgTIIj8NpvgaCcWT4b8/lokK5mahu0kHaz6SH7N7I72sgf2h0yTXtu
 XBos7lew5i2f0Mh3IDaFTYaXlbYDqSzCe8fBteEs3kfSs651sBLobs1RbTTTUtP+
 TqGvidG/ofVzuslevjlE9jdawpgLw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023102.outbound.protection.outlook.com
 [40.107.201.102])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3aydhfd6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 08:11:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwDtGQc3NIL7W6mHVUav73yokYkmyIb2aooPcBPankMDUEpZckxXDVa1bPP0IgC3KuxG95vd7vG19Un1+iJrY0KAjgHM8FmQf/mkotq+677xU4rKzLmYvi6AsPmRig75AFXylUovNowUzQZ58iOx0WMgPex3iA3crPt3Gu9Ryz1+YMNwOZAlU5uG6OPi+N/ZcX7L4+AZ6MeC/4ET9zC82EvvSgeT6RbunIf8i6ksnJAZKfHDDZNtBCSvSbBHpWdNxiuqRPjmaj5SdxaiT48bm5OL2hpcebK2mqhdD7zrlO/RyD5YZPUjO5BwX0fq1ZvFkixs2hC0cZ6mkbJ1sQIy0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FysZLCZsH7nII7OfxyojTC0RFsmsg5eJcQoOoTH5bM=;
 b=sNgadwPBvvJ7azOYFBysENK2flvj05XVDUZ6XCqfA4LK6cnWeN1LspJ0M+aeBxA6ivdiUlghhyF3QyuHhvo5htlm3EjgyIYa419yFoHSrehg6HUmzsq4SzIgBQIZDaNABkhxwrpxDE40jTTNijiEHq5Bl4Qqk33umZG96ZI3X5sxGn5JdzTy8yWwlSZc3IGVTStddAwgaGvEE8JOtegKXSIoJCN1HX1Ujp5unVuv5+iERnnuqFeraQNuA6aaH+N19y1tW/LZooL4D6vRZIcezkXXAWtmBRSz680OZAMCmnPsPNlmCCxq2QKxGtN8b/T4alaJBPVGz46pNbqXkv0rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FysZLCZsH7nII7OfxyojTC0RFsmsg5eJcQoOoTH5bM=;
 b=fCB8mUX0x4ClWi3kcysuZJcau01rDmnGgKUNniWrVJEi8q+BQqrHhyYjUVv7zcEbHHD+IWIf+mkfRgzMYWM+1a2nTDl2ikB40hsSsoPMi5NFLrphM9N5uKqqQsEbN8rbYnRo0zmxHF4fMM98x+giQWKptluWYrdZiLoC/NI/o4GhE1l9JoMrealSAS/RLuSHf28UhnLMXpWw99/DWAi6wIerAay35vcAJ9+SZWKYeqZu1akmv54fBGTTHaKJPjuVLZQajMmQkQd+qu3bNz4oWwBIswAeNpHTK9HekEbZZ/R7TxtzoKDezqwZa/2y+SQgdVp1g3RhvlQlnXqS1yBBTA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW6PR02MB9669.namprd02.prod.outlook.com (2603:10b6:303:239::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 16:11:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:11:24 +0000
Message-ID: <817fbaea-0090-4349-b031-e63229c3607d@nutanix.com>
Date: Tue, 3 Feb 2026 16:11:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/37] scripts/modinfo: use f-strings
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-13-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-13-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0165.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::20) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW6PR02MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 21e89085-b339-47dd-8be6-08de633ee0bc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDFZS2tSNzFIY2VmVEc0Z1JVbEFsaWxVT0cxSC9yUis1MTVzWmdXWVhVTkVp?=
 =?utf-8?B?NnVxc0xDSTZxTmVZbDBMM2l1S0tybkI2NE5zaWpTNVBnaCsxQm1nNitRbzVR?=
 =?utf-8?B?dlRSeUpEQ2ZKQ3hjeU5HUThSRWoxNEk5NW9Qd1p0MlEwc3JodkVTNXIwcVZI?=
 =?utf-8?B?aGpLSkxpSThJUzgydXVvZjVyc1BPUWZXVTVmMGRXb0szNDNLM0J4Y2lzakVX?=
 =?utf-8?B?YjZrRWpZOXVJRnl2T3dWclJUdkdndmQxMlFrVkVxY0dySlJZNXNjSkl1bSt4?=
 =?utf-8?B?MFoxUDJpUVJBTDhQT3M2dU9LamlDYVUrUXlBUFpVM24xMk5HbHNnNmNtRGZx?=
 =?utf-8?B?SGhoKzVQOU1Wbkl4UlNDcEM3SlJrSDExT0F5cTNneFNGMEhqTzY5bWVjM3dH?=
 =?utf-8?B?STFGOXdGWEJmelNYaVlrV2tQOEwrd2Z4MVh5TnU0OHRSbVpGbFhKWFFtYXFN?=
 =?utf-8?B?S3dKNFRMYi80VnBuS3gzTEJuTlRYSlZXaUwyK1NnVEp5UzhKcW1OMXk5QUc3?=
 =?utf-8?B?aDRDd2I0YXRUM0N6MUMyY1FDWXJVbmRQYlZJZ0pCN2lxSTV5MG1ob05ldStv?=
 =?utf-8?B?L1NhQ3AxVkRYMXRFOEVaTFppRTNpV25rbHZ4cklwRUd0blB1L3A4U09PRTZk?=
 =?utf-8?B?RmM5VG11aVBEaEdZd0NRKytDV3V2eXFTb3RndStWWFJOa3Q2VVpwVjNrTHVo?=
 =?utf-8?B?dXVDRUpXYStGZDFmdE5EbEFnN1YrcmJRczAwVmlJMTJuQTRQSGdSNy8yeG1J?=
 =?utf-8?B?bGM2VHhjMlUxVjlJdllBa09sME00MzM3eW15Z3R4akUzMTJGSkNHbjJaSUFM?=
 =?utf-8?B?SDFvcGcwbmtJeGl3ZDcxaUVVZEhIazJqVmxCYWRwSFZRMm1zNCtiaXNoSGhF?=
 =?utf-8?B?TTcxUW04Z2pia1RSVVNMdm1EeVY1Q085cU5UR2NzMU5mQjNNQ1ZXYVpmWWVl?=
 =?utf-8?B?c1NKUS96MDlxamZWVjZYdHFzYkcwaE9iZVEwaEpYcis4RWY0NXZVNERmTS9E?=
 =?utf-8?B?TXY1TDRTS0VORy8yRWQwdHB3TklNVHh2NUR5U05DUTZ0RHNHbDVRbEZqUTUz?=
 =?utf-8?B?cGo5SVVZTDh1SncrYkhHdldNWlRyU0hEaHN6K3AzNEZXeVNsL2hEdklMUlRy?=
 =?utf-8?B?N3F5QlErS1p2MHpnTW9LbGNDa2cvazNEWDJxU09JbkZSQWcvNEVzNkZRci9T?=
 =?utf-8?B?NVV3WVhRZWVMREIvblF4TFRPbjIwQkdTTFBFZWhEVGF5WkxRMURDam5BYlhH?=
 =?utf-8?B?Q3QrQ2d1RWFKYjVIQXRIbXZtbVE2MzRabExuaVdvT0ZseTBzNC8wbXdqY1Y0?=
 =?utf-8?B?RVFuSHhtSWgwQzJaVVpNSWlESUtmd2Rhc2RYZDM2NWJmMVZya2JENjdDYnlF?=
 =?utf-8?B?UlprRWZqTXFydmthZGYwM2VhRHdtVDdITERHZ2x5YWZsT3BrZmdMcTYvdkhC?=
 =?utf-8?B?Zk5JWjNTU2Nsb2JkVy9zSlVCVHNJd0JaWXBNbGRtd0NxT0hsRmJJQXkwN0tw?=
 =?utf-8?B?TnBramZYelV3RHRaUUtLTmRrRklZSDZaYjR3cUppbHlZVkEvQ0t6a1FKY0NI?=
 =?utf-8?B?NkdxMDdzelBuQk9DRnFJWGJEdGJIVmxNSFBQZUVKRmVKZkl3SmVzc3BkaEpQ?=
 =?utf-8?B?azY1REZFQ01Gb2V2a2hVNExWU3BwdUNYTUFXbS9xN2xPVXVCNm9PWlRGYkQz?=
 =?utf-8?B?WTFQa3dBMnliNnFES2J1bC9FZXRmdW1iQXVqR3ErS3YrODFxc2x0SkNaTGNH?=
 =?utf-8?B?MnBGY2FQbFk0THpkamhETjVWZ1RSeG1PUG5HQUwxTzRHSWdjNzQ2emVUVUdz?=
 =?utf-8?B?d0x5STlpU2FxVzhUYVB0ZUh5aTg0TWxOK2R6cHFnbS9XK3ZZYks2SnJVY3JH?=
 =?utf-8?B?V2J6ZkI3azNQenRReG1RYnE2U3ZhZit3d3diZlM4cEFoUlNHWTNNeVRwSk8z?=
 =?utf-8?B?WEpiOUt4WGpyblNYRWJqRm9UU0RVYUFOMkxXanFJUm1RZUhTWEUyU1ljSnA0?=
 =?utf-8?B?dlR4UWI5bW1Mb3I2cVNURzROTDViS0ZPL2F6SlZTTDY1bVNCQU1IZXVJN2RO?=
 =?utf-8?B?Vk5JUHJZdnU0RG5EN3lqaytnOWwySFBDSnNYd3lPSGNDenVnUFlKTm9DczFq?=
 =?utf-8?Q?eQy4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YSs1eEdORExyTmJQKzgxLzhxOGpWQllnU0NVNWRTckRTN0E2L1ZSNDViVUE5?=
 =?utf-8?B?MUZxYkcvY1JhRFZGcVQxV3hZeDVvM2cyT1lUQlp1amZWaklxNm1JNDFMb3h2?=
 =?utf-8?B?TUJHMmE0TTRxTXB0RExrYUNyQVhtVGwxUElEVkZHQnV4Qkljb0tMUTVFc2dB?=
 =?utf-8?B?TVRtVzY3dm5ENCt1WE54WFl3ME5scUxpNWtBN3ZkMTJPWkYzbHliOGk2MFpu?=
 =?utf-8?B?Mjl5TFpaUWFJTnpYZDJGTVZYcFhTSkpmMUZpS0tpL0RSZzB3T2hmZDN2Nlhy?=
 =?utf-8?B?b0dNOTZYaW4rUHVVU3YwUEIzZVc1REhodnhXKzVvcDIwTzJnczgyMEtlQ0p3?=
 =?utf-8?B?ZVZQRWcwR3M3Q0JjSEZvOXBiS1FnWEVpQWhEc0NjZWdhMElZaUw4dytNVDho?=
 =?utf-8?B?UmE2QWh0OExIdlFBbGRkU3FqVk9IM2ZxM0NrWmN1ZysrZGs4WGhJbWdjWFZE?=
 =?utf-8?B?SGJYajFzK0g5aGlIWkhpenlrckl4MUs3U29JbmU3SjZUaGNKT0huNThWd05S?=
 =?utf-8?B?WmVvdnpBTmdibENDb3BMcWtPNjNKZXU4NU1CR3N2bCtjOExSVkt1QW9tNGg0?=
 =?utf-8?B?Rm9kRmFIYVZMeU5HTHN4ZVp1eEJGSmdBQXc2L2xxOXFHYXVGczRRUnVVS3lQ?=
 =?utf-8?B?TlVEVFkvQWhvV2N0ZVBNZllNbzdtQjhCSnRTVHE0aDFVaGlRdDBkczF3bVlh?=
 =?utf-8?B?UjA1V0RTYmFjeGpYTkQ2NzRnV2swSEdyQTVRdVorWFVvUG9saVJiSldWdm1L?=
 =?utf-8?B?dTBERWZ6S0xZUGFPbHF0dkkwSE5GNVY1KzdneGVsR1lpNXppTkE2Qjd3S3Yr?=
 =?utf-8?B?MUEzTGJZYmVFYi85SlBvaXJwV0Q2aStHVHplMVJMUm0vQkpCbjRTZUFCWjMv?=
 =?utf-8?B?bHI0U1VTUi9sZFdVeXhFWkJUVzI1S0VEMXRWMU5jamdhQmh3dFdZMFhBdVlu?=
 =?utf-8?B?VDNQbndyVndKQzQ3Q0dQTk5NZURKb0JSeGJHREJ0VlYrRnBCWHNCVXl4eE9N?=
 =?utf-8?B?MGVaUkRZWnBvQ3JMdndtazFsOERzWk4yaVFvWllBVUlzN0dtUUx0WTFLRjRH?=
 =?utf-8?B?cURSTEczVkl6Vlk2Q1dlcU9CQ05yRFEyd2RBSm8xUDZvblRJZkhSTW9TSVNN?=
 =?utf-8?B?dVN0QXpvdFB1SmFiUHJOSVhkeGdIZWx4bjBNNGdnejB0eGVFRjZuOHV5Vzda?=
 =?utf-8?B?WDlnRE1vUE5PcEQvQUExNjkrdVQ4VlR3UnlhVHdDQ2tOdERnSWJ1enJuVDAr?=
 =?utf-8?B?dk1la3hVSzJjai9nZDBJakN4b2FLNGQrbVBYSk5jSzZkdnA3ekNsdmRNYllB?=
 =?utf-8?B?Sk5FTVJvU1h1c0JGcUw1VE9SbVEzVnlHV2xXaklqcHJzU2lpY3pEeU95OHls?=
 =?utf-8?B?MEtpRDBhTDFoRlB3cWE2U2VBcm40UEhNSmQ1bGxha1B0UTFrUDRNZ3cxR2x1?=
 =?utf-8?B?TUIzT0FZVDQzNko0bTY2cVZ3cmVxVmllVis4Q1NCcVlMWmNEMUViZTNGbWxU?=
 =?utf-8?B?S2hySGNPak1SSFlzSXg2SE5uc2crZXpkbGFiMHBEcGZ0MzJ0cCtZK29KemVz?=
 =?utf-8?B?M0FFelJVaTZrWkFWWVJic25LR3JOVDZHbFdGdHR2a3U4UzQxYVI0SzNzYlZx?=
 =?utf-8?B?a21oSTJIUElWMzkyeFNIcjBHaUNadHV6ZjljRTQ2UnJGM01TdVlhdElXdUV5?=
 =?utf-8?B?aEg5d0EyaXlVMnFaN2hLSVJ4bllNWWlkUGhNdjhESG8wZFprYzhMeXFvNnVM?=
 =?utf-8?B?WGNjTWw5c2poY2pVQkVHTklENk1CVHFFVmtUNUtkcFZoQlJSRStSUk5iRmhn?=
 =?utf-8?B?ZExSRGpLM25ZS2VPWXU3MHNpRXhLb2xLb1R2SXpJSXkxdmlPZzl4SkpUanRK?=
 =?utf-8?B?amhNOUZPd2NZWTMyNVhBcEg0UGo5ZGlDOVErNFVMdk1hSll4bThOMjIzNFdo?=
 =?utf-8?B?U0JDMmFCNlZxQWxqLzRSUEtGVXJJZVpvN1BacWdGWmxKL0tsN3NBQ3UyNzU1?=
 =?utf-8?B?QStSQmRpTjdzMkN4dk9IYVJUWDltclI0SFRDTDdiSmNiQmo1bWNJZVhVU0tw?=
 =?utf-8?B?THFKWEVQMlVTZVlEY1B5ZnpJK0E0dmloNzA1YnptdjJjczFVM0dnOHYwMUha?=
 =?utf-8?B?N1BvWlJTb2dJZUdzSFB3c0FOVnBxMzR5cUMrZ1IvdVR5NlcrWFhPWmljUkIz?=
 =?utf-8?B?TFc5eUJwNEJIQUJYa2VNV2ZKOWQ0dGttTlNrbXdMM3pwaGdQQk0zYkZ0dnl2?=
 =?utf-8?B?ZmtiVDdmVTFTaEwxYVAvRFhEZmxCMUlYbW4wM1hxNHpXYTJIalJtMk0zbkk2?=
 =?utf-8?B?NW5EYUdIakw0YWxiRzdQMG1EMzl1MzhINkhTWHFwSnRjOWpTT1RBMnM1bmFx?=
 =?utf-8?Q?Yu27Y0GgVL2NVhug=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e89085-b339-47dd-8be6-08de633ee0bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:11:24.4221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6ymAjr4A08fM4p5cWa++r0QWjfjY2YFzAOLFrfc8VUSKZ9sNovTBwOPDeIEXBOn5OJVRqvsY4OkDiO/T9xWK2rxrkOkv3dOmx48hO1wMjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9669
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyOSBTYWx0ZWRfX1IHAzbJC5H+k
 0WGxW6yL3Oy/Nxh9trVISTqtJh8Ml6MSpBPRvIViX78lT4Y4Fmw6ZyzW7XrDydF4zHzMz2M9IsD
 HrQn//gaVgxVJOfnzrUrjV8QMqEnrrKSwqeUbV8R5SMVFntrVgMY8C3IciVTB021FkT40PNj5b1
 27XtieOmZEjlFtQnK30URqJB838F7Ta9bvlNmOXMXRVN/DeL/AYyAlgiH9zjFqDC5sViZX3xOuc
 j0gDiyi30Ihss1HIouDVhKJuaxKXYqfeHwz4AhYCH3XeF2acAylFB58qKnjvVuYXQ8v0Zakds91
 eNABTiqaOvh+zFEscCFGQ2FpdcL5ThSUivgNEn6axKaImDVIAyyu+Ov9JQrnpl4/2VyhXrfBovh
 pZa6tF2/XxBdizu6RVOCNVQ4VcPJ/kCLbilSXKSzagn4pzmSP6wvAhbAgkDwQMHEsFn/yj7yPLn
 EKE3gVAvlOB7bsh6z+Q==
X-Proofpoint-GUID: W3DYbpW23dtyw8tG_Ds_kl41TDFzkTp2
X-Proofpoint-ORIG-GUID: W3DYbpW23dtyw8tG_Ds_kl41TDFzkTp2
X-Authority-Analysis: v=2.4 cv=AeC83nXG c=1 sm=1 tr=0 ts=69821e30 cx=c_pps
 a=7YB+2G0If1l7sHkNSTuqNQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=cEo3GkVnLjV8wW4lT9AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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
>   scripts/modinfo-generate.py | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index 63093a0f820..8011c842caf 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -9,7 +9,7 @@ def print_array(name: str, values: list[str]) -> None:
>       if len(values) == 0:
>           return
>       list = ", ".join(values)
> -    print("    .%s = ((const char*[]){ %s, NULL })," % (name, list))
> +    print(f"    .{name} = ((const char*[]){{ {list}, NULL }}),")
>   
>   def parse_line(line: str) -> tuple[str, str]:
>       kind = ""
> @@ -53,17 +53,16 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
>                   # don't add a module which dependency is not enabled
>                   # in kconfig
>                   if data.strip() not in enabled:
> -                    print("    /* module {} isn't enabled in Kconfig. */"
> -                          .format(data.strip()))
> +                    print(f"    /* module {data.strip()} isn't enabled in Kconfig. */")
>                       print("/* },{ */")
>                       return None
>               else:
>                   print("unknown:", kind)
>                   exit(1)
>   
> -    print("    .name = \"%s\"," % name)
> +    print(f'    .name = "{name}",')
>       if arch != "":
> -        print("    .arch = %s," % arch)
> +        print(f"    .arch = {arch},")
>       print_array("objs", objs)
>       print_array("deps", deps)
>       print_array("opts", opts)
> @@ -100,7 +99,7 @@ def main(args: list[str]) -> None:
>       for modinfo in args[2:]:
>           with open(modinfo) as f:
>               lines = f.readlines()
> -        print("    /* %s */" % modinfo)
> +        print(f"    /* {modinfo} */")
>           (basename, _) = os.path.splitext(modinfo)
>           moddeps = generate(basename, lines, enabled)
>           if moddeps is not None:
> @@ -110,8 +109,7 @@ def main(args: list[str]) -> None:
>   
>       error = False
>       for dep in deps.difference(modules):
> -        print("Dependency {} cannot be satisfied".format(dep),
> -              file=sys.stderr)
> +        print(f"Dependency {dep} cannot be satisfied", file=sys.stderr)
>           error = True
>   
>       if error:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


