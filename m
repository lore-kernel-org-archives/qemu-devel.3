Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49756C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 18:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnj68-0000jH-Ty; Thu, 27 Feb 2025 13:59:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tnj67-0000j8-Ct
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:59:03 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1tnj64-0006Xg-ND
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:59:03 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RAFAfM019703;
 Thu, 27 Feb 2025 10:58:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=HKnVrLNlZaX5LX4ptRkEscymag7dMkzAZGSN1pgpx
 vY=; b=B50e8KFbJBMr9Wap6VCI88eLi5NOPST/pCk2gW4Qjd9N18+4qQPf2tuuk
 8Ysc78XdRNtzSTDR+p+km/C3VyRXp8J7h2tvW076v444R4NomSHGDiT+lHWSa7LG
 5NLvyTt7MGerms5mQarkKroKLeghHuqu+yW/WsKpc2kvIvUtCItkyOjytS82t1Bi
 J6yYBzR1SR9PTCX9qw+BTWrejgygkHBwKKxAvEXUJO1swl/sHRRZGywkK8c8vZO/
 +eL9Z7bivxj3GcvlyrUhyB8okWyTABuFo8I9YLA53SFw5OYGLIVQcLsqSD/T8caJ
 HMPt0fL+Xrw4txCmLHcy51MGk9zVA==
Received: from bl0pr05cu006.outbound.protection.outlook.com
 (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.9])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 44ybt06nfc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 10:58:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So3WI1Z3Ryk2BqpaHA4rC4qM1KKlzO/CY8bkTf06L1Va+jgRK68GNr7A0c4LePL2ndt73adjyTy4c6zF6INQKhBkQ0scfJ3UZoscNnJCFVANjM1ZLyoLnxIFdbJDRrB7c6aBS+t9HV8lKmf01hsCWImEBBUpwhXZ/40v0WN9+2etaggm7gM2zg+DGY/eR5U9tfH39CEBMapAeROo3mqrsZsRIeVhsyfwtz8BhWpQo8V9Adjqc7pkWcgZIEoylLCwVxtsa0Z/mDU1VOQvaXZLndo4beKmqvSAJGFnMwuEnxehyieuwnPCppbeQ3bewl/XKXKrBFvroJ/sdNipNib9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKnVrLNlZaX5LX4ptRkEscymag7dMkzAZGSN1pgpxvY=;
 b=Jf6xErDARNDfNCb4KotdECyt5vRt+TFmd4TDQkWZIhAwyvq3xB0YkoThNxcyplbwq+/JsglFiiO/N/Q24rmP1zB3JQ/tIJcuNBVPUf2iN9bssO43qph3AhMnmt/aZBOaky1JSqnWHmMXKG1kxtaEMd9g/xT+EEUP9L3upNxvwkU20X5L/OXhlny1x65irhBEkvJYqqbgV2T1O5U9WlzSHWgxtEwnYLM8vonl6PVp5Ui98W97Ztthyhsv7Ci3EUKigiFH6hs/XSRzA6iedqrp0lZRmdFjA7N9Zpv/VgfK0aHwZTynVTyZBINjiMIsaiYmo8LP4dSZJMSphOeNkBcpjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKnVrLNlZaX5LX4ptRkEscymag7dMkzAZGSN1pgpxvY=;
 b=Pg0QYvKVHRNvi/gnRbO77Ax6hsHjQJZ0Y4riSMaBQmQu/OoqpznN5Hk9HKTFIySDyQnA8EOoPHVQESekaL+GQ0pJPixMzlG8yuX/V6r1rGbKO4O6DGAGMrzCbJnBj6tKonOMWNQQP+g9I5GGqmjbg3PDT9YU98KG7hpcRupTbU8Gc4HO5SKJcr86CjYXgaX2qJFMs3IhCEo70SCWVnn00852zAKgqEQIiTJnqOPPQzENRs6ad3Ed7zdgOT5PqqY+jQgCyOqoY3Wb5JIiRLkGrMXPCWYoVgO2C0OHqdrJIXRekaF+Hy5jqVEoJI5OgX8ct87KjEsYPlzoih6uo65ogw==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by SA1PR02MB8528.namprd02.prod.outlook.com (2603:10b6:806:1fb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 18:58:54 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%6]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 18:58:53 +0000
Message-ID: <9b3499b0-67b6-430a-8aef-3afad44d9d32@nutanix.com>
Date: Fri, 28 Feb 2025 00:28:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] QIOChannelSocket: Flush zerocopy socket error queue on
 ENOBUF failure for sendmsg
Content-Language: en-GB
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, leobras@redhat.com
References: <20250221094448.206845-1-manish.mishra@nutanix.com>
 <Z72ITCJlkz9711bU@redhat.com>
 <d87fa87c-46c0-4620-9741-fafb3b522e67@nutanix.com>
 <Z8CnRGOA_hxu39TN@x1.local>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Z8CnRGOA_hxu39TN@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|SA1PR02MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1f3cbd-e4be-4466-f16c-08dd5760c792
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|10070799003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0tSeDdKK1IxMXROZXBzMHNmL1lGdlZsWHRZR2pUa1NjVTQzVU5tOUhHUU9w?=
 =?utf-8?B?WkU0OXFKdDkyZjR3eTFHbzU2bjYxdWNyaVY1TllqSW1LMHBmTytmR3RmYi9w?=
 =?utf-8?B?Ylg2RnMzaENYK1BBeVBQNWlSTWV1Wm9SN3lUUlJoSlorYmhFN1JMOXlDcDRM?=
 =?utf-8?B?MkFGNW9mS2xiVDAvMldxWnZnVUl5YldxdDlYZUQweFBkb1ZkS1lXeU1YZHEx?=
 =?utf-8?B?SXJOTXlVUWREVUF3d1FRNkVBVWFvdFZicXhHMnRzQkJ2ejJXSE9NTGo2aTl3?=
 =?utf-8?B?TlRWd3QwMU04N1l5VGRBZTZBbWIrcVprUGJ6cW9ITG9aT3NXdjlZOE9DbGV6?=
 =?utf-8?B?eHJ5TGlOMTc1L0ZvRHBrY21YTFNhbkZCMlBOa3JxWHVQYklyeXl5cmwwdUFL?=
 =?utf-8?B?UkxaZ0pjUXMzMThaQWQ0M2h1NTRvSFd2Z1NPaWlCVjBIVERUakgwSUhIRUtL?=
 =?utf-8?B?VGZOaXBYTVVnaWhGNm5Fa3EzSVJDVHJIbUFNNGFCQ0pITTVGaUVWcW1oOWsr?=
 =?utf-8?B?QzJmYjVwWmp6NUF2THRqVlVmbjJaT1hCQnBqdGYrTzBscU1JSm1zcjVNVjU2?=
 =?utf-8?B?RTB0a0d0Z3FWR0gxaWtRRm5BZWtjUkxZZmJqaWFGV0toeXZRYy92YU1JSjNW?=
 =?utf-8?B?OWRsbmpyUGdXZ2tUbmpRM2o0Snpucy9JVUZhMW0yMU0vMWF1SE16R2V6T0tH?=
 =?utf-8?B?VDViWFpVQXVGdjRuM3ZXY1RHZXdraTF2TVI0ay8rcUM1My8yU1VkSGRQTXZ1?=
 =?utf-8?B?SktoNU4veEJsdDVKVnczUFl5dnBSZTVLTDI2WTJMalRhUWVvM2VFOEtnUnBo?=
 =?utf-8?B?TkRuMlNBRFJQSFNIallaZVBWc3JSQUVIRDBmN3dTLzVQVER6UjB3ekFFNGsv?=
 =?utf-8?B?UGF3KzBPM2g2cEdtK3M5aUU3NnVGL0VGUEQ3OFpYVTdGRkFIeDNFUklYeFFF?=
 =?utf-8?B?TlhYWlZSUGZqbTUrdDVXWUp1dkg4VUdXQS9OR2ZZSDUzWVdaYkRTOWJrYWFI?=
 =?utf-8?B?bWRudkFyRHplNWdDYzhLWXNVZE5IbTA4aGtsT1FMWXpPRWl5RlMvWk90QVRm?=
 =?utf-8?B?L0FJRGFxeGdxN1pyOVVVSWsrYlRGTEczbW1USmRNaVRhUjBmcHBOcWpYYk9P?=
 =?utf-8?B?eUI2QTh0b0ZpK2srQ0U4Z2o1UW1HZG5tNmF4NElGZGZkRzlBS2ZZUGtteHJs?=
 =?utf-8?B?L1VnckFCc3JNTmNKRGYvelczS1p2K0syTk9hNXVnam95ZXpGVzlDNnZWcnNl?=
 =?utf-8?B?eWNOT0RvanBqRk1sQWZlR2w0NllFOXpBVklhU3ByZkdEaWtOYmx2K3FuZXdR?=
 =?utf-8?B?eUpaOEtmRm9mTjZ2NU15WGU5V1E3QlB1UVVucnU4c0ZtajVwOWsxWlhtSk41?=
 =?utf-8?B?Zi9YOFdUdlRoWCtvVFd4YWh6WFhIUlg3ZHpRV2NWWFdJeUVnRlRxNU9NQWlP?=
 =?utf-8?B?SkU2TUNTS2l4RXdMMHQxNWFzckNnNkpKS0Q1RUtXM3NKSWF1MkJncldsekor?=
 =?utf-8?B?SkwxdjZQeWVBa1gwLzZVT0JwbiswbmQvQ3BtTmNMTjZyeERhbGdYR25lYlU5?=
 =?utf-8?B?Wjl1aUYzYmlwZGdDSUFVOCtaRlY5VUY3QTJsWnN2YnFCTW9FOTF6cTRVbmNk?=
 =?utf-8?B?N1BJQ0twOWw0cXlkdVNCUDR6UDRaT0R1R04vR1QvQjQxa09KQ3o4NlRBYlhY?=
 =?utf-8?B?amczeG1TRlR4K202ektNZ0ZXZDJLOUlHdDV4dEFEdWFMckprdWhGSnZTY1Vp?=
 =?utf-8?B?dUg0dng5UTliL0s4UDZxSFNqWXdlMEJzdE4ybUxmYm9YMjA1WGM2enB2RExS?=
 =?utf-8?B?KzRQYURDWm5hSDdndjRiQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(10070799003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUlsdFVvaGFMQ1cyb2FFOENCL3Ard3FlT0JrS3NYQktkS1BQdVRQMG54bjlV?=
 =?utf-8?B?Wm5HK2Vldndja3FNNWUzZHdkeXZacDBmQ1plQVVtM05hTTcxOC9iZU9sSGhY?=
 =?utf-8?B?eURNVUk4SkhhbDJtZm5wdTJwaW8wOEtSMkVLVTVsaXZWcUR1cFVLcXJ4eG4v?=
 =?utf-8?B?UUEvTjlDN1RtbFg3MVdGOHJhdGdiYjZzME85SDdIME4rMWx3eEdwYkp6VmZZ?=
 =?utf-8?B?bzVZeldDKyt4a09MaVJZNlJkOWhMZmM4RGdOcFlzdm5qaEJkNEFUZlFva2E1?=
 =?utf-8?B?N3o1VkVFZmVBVU5hV2J0Nzl1d281ZWplUm9qbHlDMFNKSCtqNDNUVStDc2Rk?=
 =?utf-8?B?OTYzS0EwN3J1NkxubmVrUmw3QXdNUEUvWUl6YlFLeGhUbkVybkJnYXlTK0F0?=
 =?utf-8?B?eUhHTy9QWDFsNWRaUXlnaGRIdE5vS2Y3OURVSFQ4SVV6a1FrcDJYbmhlSytF?=
 =?utf-8?B?RjYrRlJJTC9UTkxWNVhmMTAxMXVpUHlqdzhRdTBkUHAzZHYxSHVNQ0JPSllo?=
 =?utf-8?B?a2QzT0VJeXpVS25EMzNqbFE1c2h6aW9Zc294dHBqV29tQnFNcGVGbC9iRjM0?=
 =?utf-8?B?Ti9PL1BnNmhXUS9Gb2xucGFTVDhHVzdVcXpPZ1JOa2V4VFEwNE5UTk9yOE5v?=
 =?utf-8?B?WHVKb0JBQ1NQN0w1eWwvTFA3REJ5b0x2KzN5SEp2WHBIRTIrdjMzallYODJj?=
 =?utf-8?B?b3RBMXY4c0dXKzk3YzZOQlRoWWpwTDdGTzVFQUJ3TEdvNTl4bnlIcGREQkt5?=
 =?utf-8?B?VzFaeS9PV3I5cTVaQTlmdDFXSitsb0RsaTR4a0VYaG9GQllEcnR6eVlTV1A0?=
 =?utf-8?B?a1JrTGFxTjY1NFFGcTJMa2FTVkZNc3JVdHYyU0JpYWRVa2ZSMnJwZHgyeUxi?=
 =?utf-8?B?YjF4SHZzNzIzVjhmWStoYTRsSVF5V2tTL1pxNlVWenpOZ0lZTG9Kd3R3UUZX?=
 =?utf-8?B?bHNkN0l5cTlxKzQ5OXFmOGdQcDRMUjk2U2FOcDVDSWo1S2FVMGN2OUE4Y25l?=
 =?utf-8?B?R29mWUd6UU1NQVp2ait6Zzg5V0J3b3NoeHhvZ0wzakIrRDhXL0FkcHpjb3ds?=
 =?utf-8?B?blRpUzlIN0Q4MVF5Zm1TanQyWWZxd3dXNjVFMnMrUE83VktnbXIwWDRMWTVr?=
 =?utf-8?B?WlhGTlVIcGVEUEZIT2U1d3JVNGFMWEFwU0I4cGtjdUYxYzc4TEtndzBrTlA0?=
 =?utf-8?B?WUxicmRDMGVyeGpONlFoUkpOaGRKZzdxMXZmK05NQmN4ZU4yRGwzcjdmRVFU?=
 =?utf-8?B?QUF6YlIxcE5EQWJzMXROdU41MFIwUkRzcHZVZHRqRkFxdzhpRCtjUmx5VGFI?=
 =?utf-8?B?alhZTStsSC92S1FnNkVsQk5OaUF1ZStzcVh5bXRleTU4R3ZIblFKbFJ1V0dB?=
 =?utf-8?B?QkhSbFlBbjNyRzB0NHUyMjN1c2pYa3Bnb3pnVVJYeUMvL0d0ZWJXWEdmd3R3?=
 =?utf-8?B?eTRsclUvaDhMZHVIQkE3V2hRcFkzK1lISWk2L3BDTElaU3BxUTBwRE55aHBT?=
 =?utf-8?B?L1MrTnc4RUY1djBiWkJwSU9saWRpQ1d3eHZwMnM1MUtvNVN2MWsyYzExbnF4?=
 =?utf-8?B?U3RaK0RCR1pOTExJcFdGR2t4VFhWUllyQ1h1NWg0ZEVVdm5wa2tXMzR4T0ov?=
 =?utf-8?B?b1N4SzlDRXkzUTNQZUw3aFBKaVFEWlZkaDQzdmRTOTJkOUxUbG1GelhLOXBI?=
 =?utf-8?B?WWNORE1GN0ZITVE1bXdGdHVuQVp4SG5rWFJrRU8yT1V0eEFiT1Y1dmEwMitu?=
 =?utf-8?B?VUpWeVA0TlVQelRhcVVlMy93SXVISExHS3BPRTdJdmszMmdCRDczdGYyYzBq?=
 =?utf-8?B?bzZwaGdBMXFzaWZmYlkxUm0yL28va2ZDVC81UXFKS1JsS3hxTzhQTm1FSWQw?=
 =?utf-8?B?TUVicE15MDlLNmRRZ0pyOFRLTzZZVm9iaFBadnFyZW0yS2I0R21vTEZwNWVV?=
 =?utf-8?B?RGJCVHpRU29vYUZYSWRkK0UyLzIyUUFpQ1FVQktYZ1hEVkVLcjZZaGgyT1Z2?=
 =?utf-8?B?N2N1Zzd6Um1nbTVvNDdoRzB6ZGs1YmVhVTJVZko3cHdXTTM3OTgxTTgwVmZl?=
 =?utf-8?B?bUFid2s0U2wvdzU5VlowdVUvNmllck14Z3NwZVpveDhncDFTMUY3dlhvbE1k?=
 =?utf-8?B?T1lQNWxIWnhHc29Fdk5QMEtCcXNYZU9FdUdBTFBQUVFNNjZpbnB3eGdYQlF4?=
 =?utf-8?B?bWYzWE5kc3RuZFJiQnBSQ3hYTDF1dlRqajdBY3VuWXpVTTNBVjBiVzZYUGxT?=
 =?utf-8?B?ZDFZRVRtelhXYUlvZ3AvTStYSkxRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1f3cbd-e4be-4466-f16c-08dd5760c792
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:58:53.6663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qktfS9lzNzd+e91evP2YFz9cyjpgg8qdmqAIZkjZ+cF/CKT9M1qEkQJD1hLL2nM8ORvslSx3ZZBzeKihWJ6Dc95MdCfJPwUFcB8S6lCiYSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8528
X-Authority-Analysis: v=2.4 cv=U6JoDfru c=1 sm=1 tr=0 ts=67c0b5f0 cx=c_pps
 a=yfQ+ne3pfVgCfke9fm/9IQ==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=T2h4t0Lz3GQA:10 a=0kUYKlekyDsA:10
 a=NEAV23lmAAAA:8 a=64Cc0HZtAAAA:8 a=qMzcSQ7Z0iwal5H37twA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xjj0GC5SL0ELW4ibpBgG:22 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: ZbrQBNxXWaYkwlgrEK_JmgHRSgB8I4ug
X-Proofpoint-ORIG-GUID: ZbrQBNxXWaYkwlgrEK_JmgHRSgB8I4ug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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


On 27/02/25 11:26 pm, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Thu, Feb 27, 2025 at 10:30:31PM +0530, Manish wrote:
>> Again really sorry, missed this due to some issue with my mail filters and
>> came to know about it via qemu-devel weblink. :)
>>
>> On 25/02/25 2:37 pm, Daniel P. Berrangé wrote:
>>> !-------------------------------------------------------------------|
>>>     CAUTION: External Email
>>>
>>> |-------------------------------------------------------------------!
>>>
>>> On Fri, Feb 21, 2025 at 04:44:48AM -0500, Manish Mishra wrote:
>>>> We allocate extra metadata SKBs in case of zerocopy send. This metadata memory
>>>> is accounted for in the OPTMEM limit. If there is any error with sending
>>>> zerocopy data or if zerocopy was skipped, these metadata SKBs are queued in the
>>>> socket error queue. This error queue is freed when userspace reads it.
>>>>
>>>> Usually, if there are continuous failures, we merge the metadata into a single
>>>> SKB and free another one. However, if there is any out-of-order processing or
>>>> an intermittent zerocopy failures, this error chain can grow significantly,
>>>> exhausting the OPTMEM limit. As a result, all new sendmsg requests fail to
>>>> allocate any new SKB, leading to an ENOBUF error.
>>> IIUC, you are effectively saying that the migration code is calling
>>> qio_channel_write() too many times, before it calls qio_channel_flush(.)
>>>
>>> Can you clarify what yu mean by the "OPTMEM limit" here ? I'm wondering
>>> if this is potentially triggered by suboptimal tuning of the deployment
>>> environment or we need to document tuning better.
>>
>> I replied it on other thread. Posting it again.
>>
>> We allocate some memory for zerocopy metadata, this is not accounted in
>> tcp_send_queue but it is accounted in optmem_limit.
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_torvalds_linux_blob_dd83757f6e686a2188997cb58b5975f744bb7786_net_core_skbuff.c-23L1607&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c4KON2DiMd-szjwjggQcuUvTsPWblztAL0gVzaHnNmc&m=YA3zea2x_8HvvhQTYxsrstDnnR6I9dBTpwab3ZA3sSlAG5-8Yx7-xXYWLbe97cTe&s=3Wy9sMKSYoYsFN2cMzzIoa-C-wu4Uz8EHwizX5bGHaw&e=
>>
>> Also when the zerocopy data is sent and acked, we try to free this
>> allocated skb as we can see in below code.
>>
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_torvalds_linux_blob_dd83757f6e686a2188997cb58b5975f744bb7786_net_core_skbuff.c-23L1751&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c4KON2DiMd-szjwjggQcuUvTsPWblztAL0gVzaHnNmc&m=YA3zea2x_8HvvhQTYxsrstDnnR6I9dBTpwab3ZA3sSlAG5-8Yx7-xXYWLbe97cTe&s=rF8-LBBR4gvzKz2mE7dopv2uUYJavJuF2wmKUDmeFgE&e=
>>
>> In case, we get __msg_zerocopy_callback() on continous ranges and
>> skb_zerocopy_notify_extend() passes, we merge the ranges and free up the
>> current skb. But if that is not the case, we insert that skb in error
>> queue and it won't be freed until we do error flush from userspace. This
>> is possible when either zerocopy packets are skipped in between or it is
>> always skipped but we get out of order acks on packets. As a result this
>> error chain keeps growing, exhausthing the optmem_limit. As a result
>> when new zerocopy sendmsg request comes, it won't be able to allocate
>> the metadata and returns with ENOBUF.
>>
>> I understand there is another bug of why zerocopy pakcets are getting
>> skipped and which could be our deployment specific. But anyway live
>> migrations should not fail, it is fine to mark zerocopy skipped but not
>> fail?
>>
>>
>>>> To workaround this, if we encounter an ENOBUF error with a zerocopy sendmsg,
>>>> we flush the error queue and retry once more.
>>>>
>>>> Signed-off-by: Manish Mishra<manish.mishra@nutanix.com>
>>>> ---
>>>>    include/io/channel-socket.h |  1 +
>>>>    io/channel-socket.c         | 52 ++++++++++++++++++++++++++++++++-----
>>>>    2 files changed, 46 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>>>> index ab15577d38..6cfc66eb5b 100644
>>>> --- a/include/io/channel-socket.h
>>>> +++ b/include/io/channel-socket.h
>>>> @@ -49,6 +49,7 @@ struct QIOChannelSocket {
>>>>        socklen_t remoteAddrLen;
>>>>        ssize_t zero_copy_queued;
>>>>        ssize_t zero_copy_sent;
>>>> +    bool new_zero_copy_sent_success;
>>>>    };
>>>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>>>> index 608bcf066e..c7f576290f 100644
>>>> --- a/io/channel-socket.c
>>>> +++ b/io/channel-socket.c
>>>> @@ -37,6 +37,11 @@
>>>>    #define SOCKET_MAX_FDS 16
>>>> +#ifdef QEMU_MSG_ZEROCOPY
>>>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>>>> +                                             Error **errp);
>>>> +#endif
>>>> +
>>>>    SocketAddress *
>>>>    qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>>>                                         Error **errp)
>>>> @@ -65,6 +70,7 @@ qio_channel_socket_new(void)
>>>>        sioc->fd = -1;
>>>>        sioc->zero_copy_queued = 0;
>>>>        sioc->zero_copy_sent = 0;
>>>> +    sioc->new_zero_copy_sent_success = FALSE;
>>>>        ioc = QIO_CHANNEL(sioc);
>>>>        qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
>>>> @@ -566,6 +572,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>>>        size_t fdsize = sizeof(int) * nfds;
>>>>        struct cmsghdr *cmsg;
>>>>        int sflags = 0;
>>>> +    bool zero_copy_flush_pending = TRUE;
>>>>        memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>>>> @@ -612,9 +619,21 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>>>                goto retry;
>>>>            case ENOBUFS:
>>>>                if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
>>>> -                error_setg_errno(errp, errno,
>>>> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
>>>> -                return -1;
>>>> +                if (zero_copy_flush_pending) {
>>>> +                    ret = qio_channel_socket_flush_internal(ioc, errp);
>>> Calling this is problematic, because qio_channel_socket_flush is
>>> designed to block execution until all buffers are flushed. When
>>> ioc is in non-blocking mode, this breaks the required semantics
>>> of qio_channel_socket_writev which must return EAGAIN and not
>>> block.
>>>
>>> IOW, if we need to be able to flush at this point, we must be
>>> able to do a partial flush, rather than blocking on a full
>>> flush
>> sure
>>
>>>> +                    if (ret < 0) {
>>>> +                        error_setg_errno(errp, errno,
>>>> +                                         "Zerocopy flush failed");
>>>> +                        return -1;
>>>> +                    }
>>>> +                    zero_copy_flush_pending = FALSE;
>>>> +                    goto retry;
>>>> +                } else {
>>>> +                    error_setg_errno(errp, errno,
>>>> +                                     "Process can't lock enough memory for "
>>>> +                                     "using MSG_ZEROCOPY");
>>>> +                    return -1;
>>>> +                }
>>>>                }
>>>>                break;
>>>>            }
>>>> @@ -725,8 +744,8 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>>>    #ifdef QEMU_MSG_ZEROCOPY
>>>> -static int qio_channel_socket_flush(QIOChannel *ioc,
>>>> -                                    Error **errp)
>>>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>>>> +                                             Error **errp)
>>>>    {
>>>>        QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>>>>        struct msghdr msg = {};
>>>> @@ -791,15 +810,34 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>>>>            /* No errors, count successfully finished sendmsg()*/
>>>>            sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>>>> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
>>>> +        /* If any sendmsg() succeeded using zero copy, mark zerocopy success */
>>>>            if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
>>>> -            ret = 0;
>>>> +            sioc->new_zero_copy_sent_success = TRUE;
>>>>            }
>>>>        }
>>>>        return ret;
>>>>    }
>>>> +static int qio_channel_socket_flush(QIOChannel *ioc,
>>>> +                                    Error **errp)
>>>> +{
>>>> +    QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
>>>> +    int ret;
>>>> +
>>>> +    ret = qio_channel_socket_flush_internal(ioc, errp);
>>>> +    if (ret < 0) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    if (sioc->new_zero_copy_sent_success) {
>>>> +        sioc->new_zero_copy_sent_success = FALSE;
>>>> +        ret = 0;
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>> I don't see the point in these changes adding new_zero_copy_sent_success.
>>>
>>> IIUC, you seem to be trying to make it so that qio_channel_socket_flush
>>> will return 0, if  qio_channel_socket_writev had called
>>> qio_channel_socket_flush_internal behind the scenes.
>>> That should already be working though, as the first thing we do in flush
>>> is to check if anything was pending and, if not, then return zero:
>>>
>>>       if (sioc->zero_copy_queued == sioc->zero_copy_sent) {
>>>           return 0;
>>>       }
>>>       ....do the real flush logic....
>>>
>>>
>>> With regards,
>>> Daniel
>>
>> yes but current logic is, if there was any successful zerocopy send in the
>> iteration, return 0. I did not want to change the behavior. Now
>> qio_channel_socket_flush_internal() can be called at any point of time and
>> as many times depending on when the optmem_limit is full. So we may or may
>> not have any data to process when actual qio_channel_socket_flush() comes.
> IIUC the whole point of that flag was to guarantee the current stat counter
> (dirty_sync_missed_zero_copy) keeps working. That counter looks like pretty
> much for debugging purpose.  If we want, I think we can drop that but
> replacing it with a tracepoint:
>
> diff --git a/io/channel-socket.c b/io/channel-socket.c
> index 608bcf066e..bccb464c9b 100644
> --- a/io/channel-socket.c
> +++ b/io/channel-socket.c
> @@ -791,10 +791,9 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
>           /* No errors, count successfully finished sendmsg()*/
>           sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
>   
> -        /* If any sendmsg() succeeded using zero copy, return 0 at the end */
> -        if (serr->ee_code != SO_EE_CODE_ZEROCOPY_COPIED) {
> -            ret = 0;
> -        }
> +        /* Enable this tracepoint if one wants to track zerocopy fallbacks */
> +        trace_qio_channel_socket_zerocopy_fallback(
> +            serr->ee_code == SO_EE_CODE_ZEROCOPY_COPIED);
>       }
>
> Then we deprecate this entry in QAPI:
>
> # @dirty-sync-missed-zero-copy: Number of times dirty RAM
> #     synchronization could not avoid copying dirty pages.  This is
> #     between 0 and @dirty-sync-count * @multifd-channels.  (since
> #     7.1)
>
> I doubt any mgmt consumes it at all.  Probably we shouldn't ever expose
> that to QAPI..
>
Sure, I will send a updated patch early next week.

Thanks

Manish Mishra


