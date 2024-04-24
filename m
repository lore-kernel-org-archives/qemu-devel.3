Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 07:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzWsn-00009R-Ap; Wed, 24 Apr 2024 03:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rzWsl-00009E-M3
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:17:32 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rzWsi-0004KS-Uo
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1713943049; x=1745479049;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7UJhdPmb8rYfy6tbVTU9RXh4J/XXAv8h9pAA7SWuGUo=;
 b=FzAVZYvSYfO6RCuY3/e8g2sSfpiju2C6TOzmAAH1WMkRkDyqwzaK+bxK
 cFkctH+7fyjkdjDnhIO9AskaqZqw2MrjXS5XcZ5H5Dkne6iGEk0QF5lDt
 DteEyRCZrkbFVMSjDEp4h9fUZAxSmhKW+bp9CTX29O8sXocz4rJwM+9RK
 NI270BZljJqhqxrCf7LPzPykzt8MtxQ3rbbLTX0HA84Dn4NfwsIx9ESMO
 JkYKZ81k27GMMfQRz+0pvZMPg53lFLO128QAKOOZ8bH2YNxHhws6YKh8p
 9WOz+zUTGZOkycBIYiAvrD8+Ryz7sQXJk0dn48B3KLAi/W8/dE1s/eJ8T A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="117875061"
X-IronPort-AV: E=Sophos;i="6.07,225,1708354800"; d="scan'208";a="117875061"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2024 16:17:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+1bKiFHC40APHURiRfZx/EHFditSrHbTpBvj4HoDQj2dRc3uYjcmtSgq0oi2h3Vuoz09le4t4yxuKxz8dl2t0WQrlo1q8AI7398Vepngf1/KoQpZVNZTeY9Zi1OBeOeDoTtTKBJfAZCr3p7UhG01AKGAhPUPcUB8LWALcg+hyrzK9cTXhpr6Zae5v2RIcvCgeZ3POGG7rJoknmY5gBvIWyjH/0KdGuN5uA9gi7mCa9zzL7XWX4FKmTGvCyUQ++rTgTPauubUUjuhH/2mv2ENEYy66bjkJ9Hk7OV66uT9mGR81TLR9ryzNZCm5ZRjKRcMEcQPlL0a7u6YTqGQ82stg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UJhdPmb8rYfy6tbVTU9RXh4J/XXAv8h9pAA7SWuGUo=;
 b=PxtzOYn4W2DXMrXloiSVlrAABzLzYvAwo3RXnn0wX/qoBQVUXsaF3kWzvG0xMpS8qpS5kXVfsSX1nJzaBocNjZwJ/Ea6WGwiyiJ++nBfVEI22+8593P5mVU7hlfa248suB/OkbQHx0g1CYI6VEJ7OoNQr+EO6AeOEdjJNrxkK3+e31ipq1l3FVjWPYm8USxnKxRGbyrzkFI8NrMZdCQ3sa8nV+bVzg5Qyh2Btrz9eHEDmdYiyubBxk0Rx5FTFEFdB8Lx8v1CtpuHlRTn4rqv0t6q9yyr4Dmw6H2tD5hsWGlkxueOlIoXmH3Kfo3Iy0NVvVpbpsQwCuS3DVgnXUp9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB7994.jpnprd01.prod.outlook.com (2603:1096:604:163::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 07:17:17 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 07:17:17 +0000
To: mii <mii@sfc.wide.ad.jp>, Yong Huang <yong.huang@smartx.com>, Peter Xu
 <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v2 1/1] migration/dirtyrate: Fix segmentation fault
Thread-Topic: [PATCH v2 1/1] migration/dirtyrate: Fix segmentation fault
Thread-Index: AQHalX+BhynqBHYVOUWvY0/inm3+CLF12yoAgADHKgCAADj+gIAAKIyA
Date: Wed, 24 Apr 2024 07:17:17 +0000
Message-ID: <e5926adb-deb0-4b32-9543-ea453b44d785@fujitsu.com>
References: <20240423091306.754432-1-mii@sfc.wide.ad.jp>
 <20240423091306.754432-2-mii@sfc.wide.ad.jp> <Zie5Fr3m9BquVpp3@x1n>
 <CAK9dgmaOOgQ3i2Er5GWz0i0917puSj_4Wt+1KZdJyV2KoazyMw@mail.gmail.com>
 <9fa52b09-c0ad-4ff4-bd62-cd7b654bd65e@sfc.wide.ad.jp>
In-Reply-To: <9fa52b09-c0ad-4ff4-bd62-cd7b654bd65e@sfc.wide.ad.jp>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB7994:EE_
x-ms-office365-filtering-correlation-id: fd6d91a8-4611-4a26-9e03-08dc642e92bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|1580799018|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?MjNXZHJQWUg0MktOcUxueTlUWjhqMnNQaTZTQWw5UTgxdk5IL1NYc0pDUEVG?=
 =?utf-8?B?djQwaVhUcktaVHVhRncrcTh3WHZ4ekRmQ0dxMXRHNnFSTmpwbmpWZkJ4aDdx?=
 =?utf-8?B?L1dra1lLTU1LUzJETGljTk1CbHgwazlweE9lK1RZYVFxMWlVdXR6bzJZY2ds?=
 =?utf-8?B?WGxlNy9raTJ1bWMyRlkzdm9aWVJLdzZXdjdoWlBDYVppSWRXdjlHME9OMHBT?=
 =?utf-8?B?djJzL0hNSTVDQ0s3aFMzaGpQb1JiS0JPQk04VjVKQlVOejJrME5rMVlHY3E5?=
 =?utf-8?B?RGlUakNOQW5PL3pibU15REU3a0NyNkNUeGFsSWFmTXFmVzNiU1FFVkZCUm9m?=
 =?utf-8?B?V21kRWpqM3gyMlpzTUxFQXVQbzkwNDJLcWxmaStPNW9Lem4rSHBndXREeDE5?=
 =?utf-8?B?RExtWFYzRWRjdFV5ZkRaYW5GcURhUCsxdUVaTmM0UkhyeXZqVUd0cnh0Z1VC?=
 =?utf-8?B?cjhkUmU4M0o5WmU2L0kvOUVzYzBsYllKSy9QY0xQWXkrNCt4dFBXM3lxelZt?=
 =?utf-8?B?MU93eDJvMG9QSGJKNFlWVnY3MktPRVJDVlludFR4WmxSYWVMQ25EbFdJQ0Nt?=
 =?utf-8?B?U042M3pCUDI5UjdsbDQvczFOVk12bU5rQzcrLzY0V010WUdwN3pCWGxESjRk?=
 =?utf-8?B?K2E1czJtUUhHTmdlVU1ZK2NKS1MvTFhNcnR6V3FseDAvb0x3dVBiMHdhS3la?=
 =?utf-8?B?NkZLZEVvSTlqVDBIVTVnZzNMZjR2YXVZSEVoL1VqRFZseW1mZEdHZW1xL3hh?=
 =?utf-8?B?YmtQMUo0MW1JM3RaQXliNGtZa3ZYalpGV1E3OVdGb3lQa0d3UVZ3SEJRcDFB?=
 =?utf-8?B?MXZMSHhyUWdFd2wzRTJMazFCWkNXbVBEMDZFTEN2a3lXcHpqYmUwSndkR3R5?=
 =?utf-8?B?YVN4WDZ2UzJXUHAvWjZFczBhOEtwVkYwdTB5ZkpFUkt4eFFkNEduc1BMdS9v?=
 =?utf-8?B?RHFKMEtaVUhvaEZvU0FEdVBKNDQrZDBaYWc2WTVUa1NON3FkWVpnNG9vMnhJ?=
 =?utf-8?B?eFptRW8zaFVXM3o0bnVMN0YvanBhNDY4Uk9HNW13dzdpS0krYStKY2x5Q1p4?=
 =?utf-8?B?eEZGN0dUS3FHZThZRHAvanpybU9tVGF6eTk1Q3hUOFQwM1krWjRMbDVKNlhy?=
 =?utf-8?B?TjIzcjV6ajArL2Iwd0lhWnR2bml5VkhlMWdOYnJoMys4UEVqdUFlWXBjb1JH?=
 =?utf-8?B?aGNRS1kxSTFacklUUGg2akJvbXBqbTRLTU03VW51RHNIbkxwUGZyUU01dW11?=
 =?utf-8?B?RU9uTHVtbkNTdHVCUnBqb1JiVUZnT3BZdjczWmdsMGxSbi9DcysyMnlWQ3N1?=
 =?utf-8?B?OTJIUVl1ODJLZnVHZGZnL3dPV0Q0dWpCeVJpT3UvWEV1WnhNd1lvcmNzRW9E?=
 =?utf-8?B?L1BLS09kbEcrenRCdlhuUGk0U3RPcDRXR2dnREtVRThYOVAyRkNMNVkxc2Zw?=
 =?utf-8?B?cnVWWHV0MG5CcXZYWlRWeDZMUGlZMlpDQ05PMDFkU3I4TEliTVdzVEMwS0p5?=
 =?utf-8?B?ckkyUzBGRDFDWTFXUHFNZ21qZ21pSjFpb0plYVI0dWVNZzFaaU1Wa3c3UENr?=
 =?utf-8?B?YkYzSUhNODhJSUxBL0xBcFdFWFhkdWJMZ0NYSWI5OHcxck1Tbng2MHhxK2xV?=
 =?utf-8?B?MmJxTVozeGVZZDVMYnN2cGhKOVRGeHVxdXBrNTROaVhKYmordDVQZlZNcXNj?=
 =?utf-8?B?UkRNaytOQi91N3kwU2xEOG9nNnliaUYzc2MyZG1UM2F3ZHlVeUdwc2lZemNr?=
 =?utf-8?B?NEJCQVFJMm9pak5GZGtuQkFjVTNld2pGOWFWTlJyQ3ZkK0xuamRBeXAraWF6?=
 =?utf-8?Q?JEcwUdCPdgz/cA2e7aLzMwtjiPWgDoNPMiBfQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(1580799018)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXdMVjlmd0VaYXA1V0pQTXlxaXNYQ29OVS9sSEhvZHNYOU8ydVZld1pka2dD?=
 =?utf-8?B?eDFjSk1PQWFGTzNnV1VSSkZiOG1xb1kyU3BkeXNvNG80eWovTStvS0R4czRz?=
 =?utf-8?B?R1JLUzFpQTRvdi9rZFdwM1pRVk9MMGxBcU9vZHFRR3czQnIvdVF6RnV6WjJE?=
 =?utf-8?B?OU12NzR5R2kwQ0NHbkkyWjMxeWlZcUFRNytuKzdIbUh1RlBHSWlxVWl4VDF3?=
 =?utf-8?B?TEY1a1VkYjQ1WFhQMXRxTWxkNjZ3aGhXS2k3MnpTZ3U0Umxqd0Fkc0lBR291?=
 =?utf-8?B?WEdNaC9hSW1rV29nbnlTMGljWDlkeGs0bDYzTExRRmVqUHVyc29Ha3QzaEZI?=
 =?utf-8?B?UXJrTTFaSU5rSTVKak9NaHpUeEVwL3RuOXVlZEovYWF3T1hlUXo4NmRLVkZj?=
 =?utf-8?B?aVlKMVZDRDlIY0pPTzlZYk9wQklYK1VsNU5sUXdVekJZaDhiNkJLZ1lzTzhw?=
 =?utf-8?B?eTBUTkpPdVNBUVU4dEM1RDltWVlPVDJzVnJObW5RWVlLL3pMbHBFSThZT3JU?=
 =?utf-8?B?T1NQNGs1RGhXZnVIY1AyVHlwNmo4Z0doNjdQRE9zS3pLT3dYcVlTNXNlL1hj?=
 =?utf-8?B?N01jdnUwS1BjN0RtTTRYRTN3RytreFoyNGJCNjh6bWxnUVV6S0RSQ2dCK1lO?=
 =?utf-8?B?MWhnSk1rR1VHa0Ywck5LRXdGdFJDUVRsd09ZSE1ldEI2dThnWE9LSEZBRVJ2?=
 =?utf-8?B?ZUM2bHZFNTdobHZvakNIZ2UvUzBCS0VGMUFjcWVYVDBTblBKTkV6eU1kMTFy?=
 =?utf-8?B?Yzh4K3Q4cXNzQ3RWTlN5Z0tSWEd2SFliSFovcW03KzBYN25SL09INjg5YlBW?=
 =?utf-8?B?SjBRcEpaM01uUmRkLzNGZ0Q3Q3hCRVlEc0IrcFdsS3ZEQmM5YUpTMW42SUxH?=
 =?utf-8?B?NUFuU2JQK3NGL05XZjB0Y1pCTk9WdG84T1hIdlgrQW1VVFRNbzM1cUM1OHhm?=
 =?utf-8?B?R3huNE9lempwc2szYUdYTmd2TWVscjZENjhzUkZvNWhlUVRYT0xDUUNkTTVB?=
 =?utf-8?B?ekZsNGhCUkpRSmJHTXNJbmp2YWVoa2QwRlNxZEgzSjlkRW13T3ptNlo5K3U2?=
 =?utf-8?B?RXdMN1NZUkc5TVorMXdRVEQ5ZHdjRWpzSjZIQjF4T1djcHF0OEgrNHRGYWdh?=
 =?utf-8?B?SXJJSTZLaWEvWEpTV2pDbnF1ZTF3K0lQUmVSQUgrLzZaY25laDVFSGRlOEpN?=
 =?utf-8?B?ZHM0UmFsVElpd240QklHbFBOMVlkZWRZdHZxemp4bFYxK1kzL25kdDNncjlh?=
 =?utf-8?B?OUF6Z2c5T3I0ellWZVF6dmtkUFNTRmphS1ExU1BSOWpuTWYzOVcxYUlGVVMx?=
 =?utf-8?B?QXN2ZnVkMDZML2hqNyswS0tib3NPRXRKKzBpTXhQQmgra3h4aGdzS01lb1VL?=
 =?utf-8?B?NHdHRlNZc2Q0M1c3VGltQ1NaMHY5Y0FvUktCWGV2VVczblNTMUtYUmZubkNI?=
 =?utf-8?B?b2RHV0lNM0R0UmRScnpMWlQwOHFodzZHSmdoQWV3SVhZTHpMbm5IS1R1TjRi?=
 =?utf-8?B?RWpkdWRoWHIvZnZZcVhwQS9DNmNBc2VkSGY1ZkVDV0xUUTJNTkdja1V5eXh4?=
 =?utf-8?B?NzlvaGpBZzY3N2NUZFUrT2JMbm1yWVYybG05N3FHUDlGaDVPUjY4YnEySFFv?=
 =?utf-8?B?ck9ZbHNwRG5DeVpKdXk2SHowUkM1WXVLVldZaVNJVm5mZ3JtdUdud2Y2alZM?=
 =?utf-8?B?Z2o3dVlyZFpQZkhENE93a0Y4ZWRIYVVIWi8zK0V0c295ZGY4ajdUdkJkZHBR?=
 =?utf-8?B?WWl0a0ZsNlFacWxiVmdEN2IrWjVMUElFOWRiQ0c5WFpoWGF3eDBjTlFGUktE?=
 =?utf-8?B?WTVYY052MThTQ2VhWFhPVDRYM3UxeWE0cDgvUDNHNDJydGFNbmxZVkNZaWF2?=
 =?utf-8?B?K1luRzJDU3JvdkxPbk91ME9rbmpxT2JMVzNMVGhGaWxuVkdabFVwNW1uUzcy?=
 =?utf-8?B?alZKNm5kM0VUcjR4eXR0VFNnenlMQnRKaUF1WkhKTDA3VFFRNGtzQ0VsU1F5?=
 =?utf-8?B?ZitBUjY4UHJvaVp3OENuanJSMzY5SmxQUE9LZTdWanNyYUUwV1Zkc0VGWTBy?=
 =?utf-8?B?WlRJM3pjSzJURDBLV2NsZTF1dFVnVWhTRXM2UzN0eU5uN3QrSnl0enZWSVZF?=
 =?utf-8?B?aDl5SXExaGFOWkMzUk9jbXQxU0krWlJESzl4VEZHVlZCNlJTWmxkVWN1RXly?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12C607E0711C8A49B25F62E4C2B0865A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wA1pqOdJD96KDyaQYjgz3CnuSRFDvv8w+RG7BDnsh2w5xSJOoq40BDfHUKNQ/HkVO9jbozFAi/TaKS2/lSzLVwJqxGLD+0sShOUiqWJU9BQg6PJdbWEAAruI48JNh0jCOyeVUHGHvbRNbIlcMF/D9Oq6o4i/MhbnRms0fh0SdJSF6KUA0TdMo1Kpl4jFyMBAs4ptjFMJAd2bJ9VSe8ulz224W6SSviarwfrEYAkYG/wISGG7FD1jGe4Ul+AAhfZA5X1KrTUO3VNW3eiQFdpM8ZmjH190t0B6XfzuejifBUTq9vkRE13rQRs7H3bw33GNKKGmp2lmToHmwggQC74YaIsnrKXaMXDiwEJFDRrZnGMUEsx1HPVgOzEgFz16+eiVyTZlnVix57GjQ1uOYXYVab/3YSl0M1wk3EQ0BvEp+HpsHMCPnPsSPwziAgUnXmkX7TbwWtSQl4n9KgdU1u440dGS/tP+HIhlkf8UZ5gnlJ5nOpkJ/Ko9qRxAlPCcBou9NQK3YHMgypPGcxmcHwp//s0EHSOOewkzUCI/VmF6p5Gg6b+l7eoC/PuYmHCRtVekp3uvLxmIILRk9iJE/WgZkI/d7F7B2y3aeZIEz+MlqrB4UFiDRoj38959rlAmy/8S
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6d91a8-4611-4a26-9e03-08dc642e92bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 07:17:17.2245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ermOmz9qg+23nPWyKGbMhE1VzGmFk6B/XnJSQgeLUzuY249OEi5bAd8OMcNJ1P5EqGJnmrvYD8iCBogGrywuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7994
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDI0LzA0LzIwMjQgMTI6NTIsIG1paSB3cm90ZToNCj4gDQo+IE9uIDIwMjQvMDQvMjQg
MTA6MjgsIFlvbmcgSHVhbmcgd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIFR1ZSwgQXByIDIzLCAyMDI0
IGF0IDk6MzXigK9QTSBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+
ICAgICBPbiBUdWUsIEFwciAyMywgMjAyNCBhdCAwOToxMzowOEFNICswMDAwLCBNYXNhdG8gSW1h
aSB3cm90ZToNCj4+ICAgICA+IFdoZW4gdGhlIEtWTSBhY2NlbGVyYXRpb24gcGFyYW1ldGVyIGlz
IG5vdCBzZXQsIGV4ZWN1dGluZyBjYWxjX2RpcnR5X3JhdGUNCj4+ICAgICA+IHdpdGggdGhlIC1y
IG9yIC1iIG9wdGlvbiByZXN1bHRzIGluIGEgc2VnbWVudGF0aW9uIGZhdWx0IGR1ZSB0byBhY2Nl
c3NpbmcNCj4+ICAgICA+IGEgbnVsbCBrdm1fc3RhdGUgcG9pbnRlciBpbiB0aGUga3ZtX2RpcnR5
X3JpbmdfZW5hYmxlZCBmdW5jdGlvbi4NCj4+ICAgICA+IFRoaXMgY29tbWl0IGFkZHMgYSBjaGVj
ayBmb3Iga3ZtX2VuYWJsZWQgdG8gcHJldmVudCBzZWdtZW50YXRpb24gZmF1bHRzLg0KPj4gICAg
ID4NCj4+ICAgICA+IFNpZ25lZC1vZmYtYnk6IE1hc2F0byBJbWFpIDxtaWlAc2ZjLndpZGUuYWQu
anA+DQo+PiAgICAgPiAtLS0NCj4+ICAgICA+wqAgbWlncmF0aW9uL2RpcnR5cmF0ZS5jIHwgNyAr
KysrKysrDQo+PiAgICAgPsKgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4+ICAg
ICA+DQo+PiAgICAgPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL2RpcnR5cmF0ZS5jIGIvbWlncmF0
aW9uL2RpcnR5cmF0ZS5jDQo+PiAgICAgPiBpbmRleCAxZDJlODU3NDZmLi4yYTdkZjUyNTE5IDEw
MDY0NA0KPj4gICAgID4gLS0tIGEvbWlncmF0aW9uL2RpcnR5cmF0ZS5jDQo+PiAgICAgPiArKysg
Yi9taWdyYXRpb24vZGlydHlyYXRlLmMNCj4+ICAgICA+IEBAIC03OTksNiArNzk5LDEzIEBAIHZv
aWQgcW1wX2NhbGNfZGlydHlfcmF0ZShpbnQ2NF90IGNhbGNfdGltZSwNCj4+ICAgICA+wqAgwqAg
wqAgwqAqIGRpcnR5IHJpbmcgbW9kZSBvbmx5IHdvcmtzIHdoZW4ga3ZtIGRpcnR5IHJpbmcgaXMg
ZW5hYmxlZC4NCj4+ICAgICA+wqAgwqAgwqAgwqAqIG9uIHRoZSBjb250cmFyeSwgZGlydHkgYml0
bWFwIG1vZGUgaXMgbm90Lg0KPj4gICAgID7CoCDCoCDCoCDCoCovDQo+PiAgICAgPiArwqAgwqAg
aWYgKCFrdm1fZW5hYmxlZCgpICYmDQo+PiAgICAgPiArwqAgwqAgwqAgwqAgKG1vZGUgPT0gRElS
VFlfUkFURV9NRUFTVVJFX01PREVfRElSVFlfUklORyB8fA0KPj4gICAgID4gK8KgIMKgIMKgIMKg
IMKgbW9kZSA9PSBESVJUWV9SQVRFX01FQVNVUkVfTU9ERV9ESVJUWV9CSVRNQVApKSB7DQo+PiAg
ICAgPiArwqAgwqAgwqAgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAibW9kZSAlcyByZXF1aXJlcyBrdm0g
dG8gYmUgZW5hYmxlZC4iLA0KPj4gICAgID4gKyDCoERpcnR5UmF0ZU1lYXN1cmVNb2RlX3N0ciht
b2RlKSk7DQo+PiAgICAgPiArwqAgwqAgwqAgwqAgcmV0dXJuOw0KPj4gICAgID4gK8KgIMKgIH0N
Cj4+DQo+PiAgICAgTG9naWNhbGx5IGRpcnR5IGJpdG1hcCBzaG91bGQgd29yayB3aXRoIHRjZy7C
oCBTbyB0aGUgb3RoZXIgb3B0aW9uIGlzIHRvIGxldA0KPj4gICAgIGt2bV9kaXJ0eV9yaW5nX2Vu
YWJsZWQoKSBjaGVjayBrdm1fc3RhdGUgdG9vIGFuZCByZXR1cm4gZmFsc2UgaWYNCj4+ICAgICBr
dm1fc3RhdGU9PU5VTEw/DQo+Pg0KPj4NCj4+IEFncmVlLCBiZXR0ZXIgc29sdXRpb24NCj4+DQo+
Pg0KPj4gICAgID7CoCDCoCDCoCBpZiAoKChtb2RlID09IERJUlRZX1JBVEVfTUVBU1VSRV9NT0RF
X0RJUlRZX1JJTkcpICYmDQo+PiAgICAgPsKgIMKgIMKgIMKgIMKgICFrdm1fZGlydHlfcmluZ19l
bmFibGVkKCkpIHx8DQo+PiAgICAgPsKgIMKgIMKgIMKgIMKgICgobW9kZSA9PSBESVJUWV9SQVRF
X01FQVNVUkVfTU9ERV9ESVJUWV9CSVRNQVApICYmDQo+PiAgICAgPiAtLQ0KPj4gICAgID4gMi4z
NC4xDQo+PiAgICAgPg0KPj4NCj4+ICAgICAtLSANCj4+ICAgICBQZXRlciBYdQ0KPj4NCj4+DQo+
PiBUaGFua3MsDQo+PiBZb25nDQo+Pg0KPj4NCj4+IC0tIA0KPj4gQmVzdCByZWdhcmRzDQo+IA0K
PiBUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuIEkgYWdyZWUgd2l0aCB0aGF0IHNvbHV0aW9uLg0K
PiANCj4gVXBkYXRlIHdpbGwgYmUgbGlrZToNCj4gDQo+IGRpZmYgLS1naXQgYS9hY2NlbC9rdm0v
a3ZtLWFsbC5jIGIvYWNjZWwva3ZtL2t2bS1hbGwuYw0KPiBpbmRleCA5MzFmNzQyNTZlLi4wZjg0
OTkzNjVkIDEwMDY0NA0KPiAtLS0gYS9hY2NlbC9rdm0va3ZtLWFsbC5jDQo+ICsrKyBiL2FjY2Vs
L2t2bS9rdm0tYWxsLmMNCj4gQEAgLTIzMTIsNiArMjMxMiw5IEBAIGJvb2wga3ZtX3ZjcHVfaWRf
aXNfdmFsaWQoaW50IHZjcHVfaWQpDQo+IA0KPiAgwqBib29sIGt2bV9kaXJ0eV9yaW5nX2VuYWJs
ZWQodm9pZCkNCj4gIMKgew0KDQoNCkhvdyBhYm91dCwNCg0KCXJldHVybiBrdm1fc3RhdGUgJiYg
dm1fc3RhdGUtPmt2bV9kaXJ0eV9yaW5nX3NpemU7DQoNCg0KVGhhbmtzDQpaaGlqaWFuDQoNCg0K
PiArwqDCoMKgIGlmIChrdm1fc3RhdGUgPT0gTlVMTCkgew0KPiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGZhbHNlOw0KPiArwqDCoMKgIH0NCj4gIMKgwqDCoMKgIHJldHVybiBrdm1fc3RhdGUtPmt2
bV9kaXJ0eV9yaW5nX3NpemUgPyB0cnVlIDogZmFsc2U7DQo+ICDCoH0NCj4g

