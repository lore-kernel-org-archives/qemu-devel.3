Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B0C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 03:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7RwK-0002kZ-NL; Wed, 15 May 2024 23:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7RwH-0002kM-7U
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:37:53 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1s7RwB-00016K-IV
 for qemu-devel@nongnu.org; Wed, 15 May 2024 23:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1715830667; x=1747366667;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lPZAskWm9JlqIZr+cTgnSWPGcsgCFUzXB4AqTSmIF4g=;
 b=qwbGeoIdDshzH5tPl/7//RkIpCHqI/78mYBZ3oSqNEPvUz82/9tLgxV8
 Gn1JkRUjBVmpHwyjwYJaBRi1Nta94uaGGUuu8jlvMOSNNtP+flDgMP9Po
 PzBf9l8Xnfbm6OSqVTdWSvvXSmSjtHZrFyr2ELuPidDXmEC0ATy0zs9Rs
 TKXmhhuM2Rxvdnd0fZ1Vds/8kyDwEk57IGZ4iPU4A2px4L/YOowDEr7YS
 5FrCE7wLyv1t+cOErs7Z8vLEcnFHPEb6fSCRIf5f/ubIPvN5PSx+SRUl8
 cVBSAovJpIgTk0+J/dt9N9IGWexB1CBAu1SzYICeeJFasYbq0KAX3KLAX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="119497524"
X-IronPort-AV: E=Sophos;i="6.08,163,1712588400"; d="scan'208";a="119497524"
Received: from mail-japaneastazlp17010000.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.0])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2024 12:37:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EreaJ0dn+uDAvbaQUJZC4r5/Nw4lKUPBLex6sKLWd7gKD4NbKxuVvl/B/baZYeFcPjAPnfEPQjYs6z9WYxyonpijObDVYxkB7z8/Gtw5WLOZuf5IhxOFh6GZQrcMAXNawesW6pGsGE8XsKyfvwNYDw0753s5Y1LEkOj0p3sP3r04x+y85MR64EczsQ0IB/RgMllDZ800RRI00AgHbzMqwlO8e3ETFheN0JWEIezSkWdymX2ytx9nYgVIRWUEr1lFyZz5Pl7NKeHeHX7RTpUab85bWfIm/ykj/OFS1JoWKab4c78XcRMhEYZwDfxYiqinUqTyTpD/ptZlIn+M49YPWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPZAskWm9JlqIZr+cTgnSWPGcsgCFUzXB4AqTSmIF4g=;
 b=UiWofTY/hehSzj0K3VcT6NAEl5zsah5WFirX4ELaEOtUF98yKB9LlhaPZa5n7nNkSUs1NLVVmsfzCIMAltGwyYTCw3pTn38HB2qAytTYtwg0zXIYRlM1HivZxixssIOW3QCQklJai1TmE+EgELL8enPAhpDEXLbsGXN96XhaLnkpP0CqYJIE2+bD2lryig+hySAImGwUo/THt0Jc2CyQTxYh3u03SHsjXGcoM9cXhWz/j6sZFCzBg+bFxWH0WV5Q8quiu8MuQzLN35LzVnbY74+C52g849Y2ZsLraudUFaJKLGPmv4tk+UEOYSAwkg4Aamsn8kizBmZmVWZIQaSFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYCPR01MB10276.jpnprd01.prod.outlook.com (2603:1096:400:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 03:37:36 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%6]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 03:37:36 +0000
To: Fabiano Rosas <farosas@suse.de>, Li Zhijian via <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>
CC: Hailiang Zhang <zhanghailiang@xfusion.com>, Zhang Chen
 <chen.zhang@intel.com>
Subject: Re: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
Thread-Topic: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
Thread-Index: AQHaocDb5ERluuIX9U+1Isr8/bpCqLGYsfSAgACPUQA=
Date: Thu, 16 May 2024 03:37:36 +0000
Message-ID: <29c24cce-18b6-4f3a-b62e-96e2cf31b239@fujitsu.com>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
 <20240509033106.1321880-2-lizhijian@fujitsu.com> <87le4aew1m.fsf@suse.de>
In-Reply-To: <87le4aew1m.fsf@suse.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYCPR01MB10276:EE_
x-ms-office365-filtering-correlation-id: 1e35e840-aae3-4b29-4588-08dc75598788
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|366007|38070700009|1580799018; 
x-microsoft-antispam-message-info: =?utf-8?B?UHViU3kzM2tSaGROamRYUjczTnU5ZEJnR00wSUtMck1TNElRWmpERHlKZU03?=
 =?utf-8?B?akhUbU1RQlEzYUxLQzdjUm92akt5WlcvRUlwOHpQZWE2MndVVVRvVnRjZEtJ?=
 =?utf-8?B?UE1MTlNHQWFDczBUMm0rRFNTWkR4MlZ0V1U4NmN6TzE4SlJMSWlPd2cxOWdr?=
 =?utf-8?B?L2liYXRUelNUSkhlTmF6MjRCbmtFbjZBeHhsWVFzU1lmd3VuMFdlKzlRZlZa?=
 =?utf-8?B?TExtVUVjT0piTk5HRnVxUTd6eURGdDBBMHdXZWRtbVF4UEJTSlp6MHdraXhZ?=
 =?utf-8?B?Sjh1WjVBYVJMVURNQXFzOVZLTWpvTlJFbE5KWDJuZkJGN2hyM0tia3JTWEF6?=
 =?utf-8?B?YzREV3pNZWw3QlVXM0dpaG5uRU5CUVBhc0h4Y2h5aDlJUUNFNzFVS0JMNzc3?=
 =?utf-8?B?WkN0RmpzWDY5M05pWnNHamJQbXk5aGI5T2k0NTh2ZGU4UTNjQ2lhRHU3bGVy?=
 =?utf-8?B?dDcyUllrb1JlcEZwMnhFRmhxTVd2UUFRRjJnS01PNlczWWJ4YzFJRWhoc2Uv?=
 =?utf-8?B?cys1K0pDdUdXVjk1RzhsYUdaMTdQWkJKK083aTlvalRmMFZWRFpNT2hIN01S?=
 =?utf-8?B?UUwrbTNUWmJ3YTN6MUJmTGdyTGU5eGJ4ZlRQaitGK25TM0Z3RnhTZldIRjV1?=
 =?utf-8?B?aWFJa2F2SXNuS2NXYnlMeTNrbndYbk9rTlhpMHZUNDlKWHNJVFI3QmJETTBw?=
 =?utf-8?B?R0txT253S3BaK2txZUx1QWNFSW80VlZTRGtXb01lOEV3a2VtMjlqdEZZWFVy?=
 =?utf-8?B?cFFkMjBkK1YxbmQ1WFdpQlI3M3hvV3ZrQkw4YXJvY1E5UnNHK2l4WXRHUG9Z?=
 =?utf-8?B?enpxRHR1cVQ0WFZzQ0xtWTFVc0dva01aUXA5R1NCb25CVjduL2x6OHNHek9r?=
 =?utf-8?B?REtIRHFocFN5T2lGZHRIazZDdzFuUnkxL0VDTi9jNDBZWm0zNWk5NlZCZkI2?=
 =?utf-8?B?WTJoUzdqczBMSTNYOS93cHJ3QUdrM2pGMjFFTFhQaTdzdi9BTXo4RkZ3eGVx?=
 =?utf-8?B?S1ZvRThPaEgybzZVcjNvK3Nhdm53bDlZYjRQbUV6TEdpVlROTVovWTNpZXQ5?=
 =?utf-8?B?RVp2ekdtU2NGR0hRRzBRdDUvcHFkQ1hhRSttZkJZUkxjejZVLzBRNGtOdzlE?=
 =?utf-8?B?UzZkZUZLUFE3eDVNd3lVYldxa21ydTduUEdwU2U3T01OK3BaTzN4a2VoMTF2?=
 =?utf-8?B?VzgwZFRoRUVWKzFjMk5rZVFnb2U2OWs1YlVUSkk1ODgwSURlTFRPRlVHTk5o?=
 =?utf-8?B?bHRpdmxVZDU1MjZPQ3NCbVhIY21RWVp2bUlMdk5PZ0hDZkJFMXdhY1NabzRR?=
 =?utf-8?B?amI1akUzK2xWcjZNRlFJNU5GQ2FXWUl0NkNsVlZjZ00vd2t2SGhsLzBibEdI?=
 =?utf-8?B?ZkhWcWYrOFlGSXg3LzYrNzIvYUN0WkIxdHR5azhDWWQwbUV3Qlc5QTNjU2c5?=
 =?utf-8?B?YkFGSytMZVptYmo5RDZZNlExck01WlBQRkdRdkNQZ0U3WDNHNnBHc0xHeDJa?=
 =?utf-8?B?cEdpRHJOQVltNHlhdWN6VXNVNC9DTWZ3WUVoRFhXWWxkbVVaZGpWUlk1bEtu?=
 =?utf-8?B?dmpyakxqdXhUUlRFNnVNUlZVT016S25taFlPYXZFZWF6NFJHUy9tZ3FjN00z?=
 =?utf-8?B?ZUNSbWdZVkgyVVJvVGJ2cTI2N1pSY2MzVE85SXF1UlZCQUEwMnM4WU52bG9H?=
 =?utf-8?B?eVBKTHlhUUQzTGc0ZE9kaXVOS2FXTUZzOW9uWlNEcWZ5UFdCcXdwbnM2VjRh?=
 =?utf-8?B?THNaVnNOQVdxTFpJdFB5SEtOY2RZNDZ3QkpIRHVsaStNdE52MHFzcG1ILzlF?=
 =?utf-8?Q?JhB3urjdqxg6hJW4BTZJNr/k3Pj6G8Mo2mygM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009)(1580799018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZStGWFRtZjExNlJuS2FYWFVQQTlWK2NwWkE2OW42YjFtTWY2VlhnZ2tWRWtX?=
 =?utf-8?B?cGJnSTJBNnBMcEhjZDUzaGxwWkl1a1VPWmx2dEhrN1hBZDRzVUpQWFRPZlZy?=
 =?utf-8?B?Q1pueXdINzM0cnBkd0F6a2ZBUzNnc2VzbERNb1R4UzliSUw2OUdhbnd1NEM4?=
 =?utf-8?B?VWMvQldnTnJWZDBiRWYwcTlZVUVCMTkyZVlUVnZxTUVZL3c4VHJLMkJZMFBF?=
 =?utf-8?B?YTdzNjQ3QVU2M01SbjF5Vm9Pa0JxR0h2b3lPa1pUclYxOTFON2lsUFNmQjkr?=
 =?utf-8?B?R3Zwd2ZvWWlWRUxTUFNJRUJjejF0c3NEaU5TemFoNzBpaXVta1NZVHFKL1pB?=
 =?utf-8?B?dmJpKzEyU0NpSzlqVUdOYURuTTY4dU90WDFsbHF2cmh2bXU0a0p0Y1liTkFs?=
 =?utf-8?B?ZTVlbkRUQ3NWbWVjK1lRdVNQYURQcnd4c2VEUlQ2RlptYXJJNjByaEdEOEJK?=
 =?utf-8?B?by9NRjNEeFJTbDRUaSt3cE5rTStmV1B3bFlBYlY3VnNSc1NXdlJKNEZxanFx?=
 =?utf-8?B?WCtmdVlsalUwdGpFN0pTN0hzY09mQ0JKdzIwZU83ZnQ2YVd6QTh2ZzdNbXE5?=
 =?utf-8?B?cHVWd3laM0pCVVY0OVJjYnB6VDFBSGtMMHNXdkRCbkVFenpCRWZmUXREUTl0?=
 =?utf-8?B?RHZiZ1ZWSXl2WXgreE1NU2hjQzU2akdQY29LWXN5eTdSekFKdkFRZXY4WDMy?=
 =?utf-8?B?TWRsVSs5bTIzQk1HRWJIOFZTZmg2ZWZybWluWWxra0I2WmdvekYxNmhHd2xX?=
 =?utf-8?B?VU9ZSEwyOFhoVWkyMXF0TUYvZW1pcUdhUktRaXpJS0lSYjZqUlR0dko2Z1Qx?=
 =?utf-8?B?WUg5b2ZRTXE3dllNRTJRVmczRnhGZ1REcVdWdHhjTTRpRTh6bXdidjljVlN1?=
 =?utf-8?B?Z0VZYUhubFVOQlNjSzBFRGFqc3p5aFhuNjlkMjN2TzBEVVl1ZlZ2SlBaKzdL?=
 =?utf-8?B?UHNmdkFxZE5XNDQrUFZram1XRmV4cDFYWDV1RkwrTjh1YzNIYmJpdWU1U1dw?=
 =?utf-8?B?U0E5dWgzS3l5bC9wYmYyMFhHRzN4Q0k0SGRDOXY1NFpCWkZlcitIR2VEU1Bk?=
 =?utf-8?B?VUhWZldKVjExUlhGMk82eEFiUWZhNUZTcmhxcWlGRDVRRUpXREFoZ1NXTjdS?=
 =?utf-8?B?NWYzbjNLN2MyU1AxRk5iYUtIdWNiQ2dGZFh5U0VoTUc3WnFvR1FuOXBKWDE4?=
 =?utf-8?B?ZEpIdG42bXpsT2FEVXBzNU5HMlpUQXRsUWFueFRGYXJqcGxWNms5aEtaZ205?=
 =?utf-8?B?TVpHdWZ0QXRpNUMxb0I3SUNiOTVPWnp6VENNTklhcU5teEZucmlFQ1QxM0hj?=
 =?utf-8?B?Wk8wOWVLOU1JN1lhMVllVlA5enhtN3A2QTBPcDUwcmpib1lHZlQ5b3E2S002?=
 =?utf-8?B?amF6eVp4Skt6NFlCTkRkaWtUaWFMQy84bVVqejhZUDZTWWtOeXFHUnV6ZWNI?=
 =?utf-8?B?OUxyL3puMEVCczVSc0pBSGdWTGl0T3MxNFBxWE1rRjl4UmZlT3hGdk9UbEcv?=
 =?utf-8?B?ZDlXdVRpaVp2RU5IdGI5QzR5dlBXcE83UVJnRVl6SFZnYVNFdFh2a2ErYzhE?=
 =?utf-8?B?ZWNiR1hjdFl2bUNWKzhIVGtUbEphSWY5UFdvS1lSd2lIWFV1Z0IzRVQ3bWlU?=
 =?utf-8?B?YjFJbmV6NXlvL3BkTHJWZWpPQVdwTXBFcnFYeFA2UjJudWZmUjRhT2NsSUd2?=
 =?utf-8?B?VUhDaW5mOE9NVWlOZ1REVVR4ZmN0WEJNaFJXOHV1bzJOSGhBVXFmNUI3N0dG?=
 =?utf-8?B?RGpzMEVYSDFjN09HNGJ3ZERsenZhVXRGS0JEVzBTb3UyM0N4dmE4QURWQUxl?=
 =?utf-8?B?b0tCZVh1VWlXcXY2bHFwZkJLdGZhWGpXN2VDNDhRNUNpZGxraUduSlRJRlVG?=
 =?utf-8?B?NExwK1JtWVNOV05GcS9vR0lCVExMSExRVEZxV2dUcmc0MXY0ZUhoa2Y1dG9V?=
 =?utf-8?B?TGZIWHhiM2lBSURoREh5dS80Um1NN2o2eStDQUl2bG5ueFBvKytzL1kzUFNj?=
 =?utf-8?B?NG5ZSnZIQk1wSE9KbG5CZGZONVBMZUl6Y1lvUXFFSHAzd0pXS3ZFR2Zsb0cy?=
 =?utf-8?B?VzBBR1poM2RuUWExNU54L1czbmVjckUwMmV6dG1BY2hXUVExV1RwY0dTbEIx?=
 =?utf-8?B?aXh4R04zbk9KRXFpemxqZUJYWnNoWWVyMVcrdE1jNTArTUdmT1hWZm5HbWtK?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <308A14F9EB53DB4F8ABBB5D597F599AD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GA9+tJnctLC7DfO4odIr34RKCq5R3VmZIetLMWbaZywcFR52YDiY+8avXpx8pHOwTQhsU+WNC1MkxvFFvnaAOO7Q8Q0r84xM3P9K01NccmLP1tOl9V1xez/o/aY8GITXlxIfwdTlOrkdvnBDO6ePcNUj/QGqLCxftyHMw6JUd04Ch+tC7y7GBW7aau/ubdcHVNVKWUI24RbRFgNGx7OIlX4lDXe7bAhgTaBYfj+2JIrskYA+Mj5+qjcQVMgzbI4EyZjtZc0VwwgoNCpr6Gi67McsTD7AG2ACC2nfXoru0YrMaATZNh8iNg2KKzTq6xR/I7TKuwH1PhEV+0VdoCcqUXzHxaLvj/sK0fyB46PkCEmug6v9MgZ58iUn+CQCgZC6VcZloO12yCjstlzycyUQFA9oPBadIfjmRNmKvHMLWKWtFlrSPHWYe50G5DaaRLq2mRoFQOEjcRIXizoxDRLyNPfdgW0N/V6gNd2h/a+x8RJy+e7ELEB++G/VXQkCB3/sbHksACazI7HFMe1CFIv03UgtfYoOAXEzLeMftS/T/5ibLXpNqSMtTJi7qQVsUCQPHzk8AQNNM/2AnilDHksZDdX4e+PkTtLpNWZ7SV2iRu+8J7b7cLOS/d3cwjj9Nb6r
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e35e840-aae3-4b29-4588-08dc75598788
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2024 03:37:36.5866 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpnH3UHfX51XZfTJgrHL5c36h0gfFUHSg3cN7FqEQvH7Yea+Ka4TazEBhq/PJBGcdt7ghlr2fIrq8+gHJgvwRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10276
Received-SPF: pass client-ip=216.71.158.33; envelope-from=lizhijian@fujitsu.com;
 helo=esa16.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDE2LzA1LzIwMjQgMDM6MDQsIEZhYmlhbm8gUm9zYXMgd3JvdGU6DQo+IExpIFpoaWpp
YW4gdmlhIDxxZW11LWRldmVsQG5vbmdudS5vcmc+IHdyaXRlczoNCj4gDQo+PiBDdXJyZW50bHks
IGl0IGFsd2F5cyByZXR1cm5zIDAsIG5vIG5lZWQgdG8gY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBh
dCBhbGwuDQo+PiBJbiBhZGRpdGlvbiwgZW50ZXIgY29sbyBjb3JvdXRpbmUgb25seSBpZiBtaWdy
YXRpb25faW5jb21pbmdfY29sb19lbmFibGVkKCkNCj4+IGlzIHRydWUuDQo+PiBPbmNlIHRoZSBk
ZXN0aW5hdGlvbiBzaWRlIGVudGVycyB0aGUgQ09MTyogc3RhdGUsIHRoZSBDT0xPIHByb2Nlc3Mg
d2lsbA0KPj4gdGFrZSBvdmVyIHRoZSByZW1haW5pbmcgcHJvY2Vzc2VzIHVudGlsIENPTE8gZXhp
dHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3Uu
Y29tPg0KPj4gLS0tDQo+PiAgIG1pZ3JhdGlvbi9jb2xvLmMgICAgICB8IDkgKystLS0tLS0tDQo+
PiAgIG1pZ3JhdGlvbi9taWdyYXRpb24uYyB8IDYgKysrLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
bWlncmF0aW9uL2NvbG8uYyBiL21pZ3JhdGlvbi9jb2xvLmMNCj4+IGluZGV4IDU2MDBhNDNkNzgu
Ljk5MTgwNmMwNmEgMTAwNjQ0DQo+PiAtLS0gYS9taWdyYXRpb24vY29sby5jDQo+PiArKysgYi9t
aWdyYXRpb24vY29sby5jDQo+PiBAQCAtOTI5LDE2ICs5MjksMTMgQEAgb3V0Og0KPj4gICAgICAg
cmV0dXJuIE5VTEw7DQo+PiAgIH0NCj4+ICAgDQo+PiAtaW50IGNvcm91dGluZV9mbiBjb2xvX2lu
Y29taW5nX2NvKHZvaWQpDQo+PiArdm9pZCBjb3JvdXRpbmVfZm4gY29sb19pbmNvbWluZ19jbyh2
b2lkKQ0KPj4gICB7DQo+PiAgICAgICBNaWdyYXRpb25JbmNvbWluZ1N0YXRlICptaXMgPSBtaWdy
YXRpb25faW5jb21pbmdfZ2V0X2N1cnJlbnQoKTsNCj4+ICAgICAgIFFlbXVUaHJlYWQgdGg7DQo+
PiAgIA0KPj4gICAgICAgYXNzZXJ0KGJxbF9sb2NrZWQoKSk7DQo+PiAtDQo+PiAtICAgIGlmICgh
bWlncmF0aW9uX2luY29taW5nX2NvbG9fZW5hYmxlZCgpKSB7DQo+PiAtICAgICAgICByZXR1cm4g
MDsNCj4+IC0gICAgfQ0KPj4gKyAgICBhc3NlcnQobWlncmF0aW9uX2luY29taW5nX2NvbG9fZW5h
YmxlZCgpKTsNCj4gDQo+IEZBSUxFRDogbGliY29tbW9uLmZhLnAvbWlncmF0aW9uX2NvbG8uYy5v
DQo+IC91c3IvYmluL2djYy0xMyAuLi4gLi4vbWlncmF0aW9uL2NvbG8uYw0KPiAuLi9taWdyYXRp
b24vY29sby5jOjkzMDoxOTogZXJyb3I6IGNvbmZsaWN0aW5nIHR5cGVzIGZvciDigJhjb2xvX2lu
Y29taW5nX2Nv4oCZOyBoYXZlIOKAmHZvaWQodm9pZCnigJkNCj4gICAgOTMwIHwgdm9pZCBjb3Jv
dXRpbmVfZm4gY29sb19pbmNvbWluZ19jbyh2b2lkKQ0KPiAgICAgICAgfCAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+DQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi9taWdyYXRp
b24vY29sby5jOjIwOg0KPiAuLi4gcWVtdS9pbmNsdWRlL21pZ3JhdGlvbi9jb2xvLmg6NTI6MTg6
IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mIOKAmGNvbG9faW5jb21pbmdfY2/igJkgd2l0
aCB0eXBlIOKAmGludCh2b2lkKeKAmQ0KPiAgICAgNTIgfCBpbnQgY29yb3V0aW5lX2ZuIGNvbG9f
aW5jb21pbmdfY28odm9pZCk7DQoNCk15IGZhdWx0LCB3aWxsIGZpeCBpdCBzb29uDQoNClRoYW5r
cw0KWmhpamlhbg0KPiAgICAgICAgfCAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4=

