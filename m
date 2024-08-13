Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A767C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:34:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdm23-0000BZ-Nr; Tue, 13 Aug 2024 03:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdm20-0000Ax-RQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:33:24 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdm1x-0006RK-D3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723534401; x=1755070401;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=a68m/xfK6+HlJm4A0W11jRqslkKywWoSxlEtxo8iU5E=;
 b=T4OZMZuS6Ils/1JBa4uZqJbzkN5ky2klpNfL6HKuQoBh+lrJoZmPB7id
 +o0mEhhrCqvYpAihYetsWIdsNHJs7szX9zkQhEGGo8CD8pr09ezUQemUK
 xODj1xkq9KK8mLajG12stCk1p1F/7WUo1GBrlZpWzxjqDyG0U22JnefhB
 hxEoDPPm7HjIz2EeUJYGARRxztjg/EGw5bZ3yblJQQA7u62eor47ZrAZi
 alha9Q5M4YJA8LTPvCHDNXqaCjCyYVt1+9/3cvdAK+/Cl1/tRZqrLeelR
 +WLwrYtRCWUq4aJOUFa+pqVgLqkeqfOifBCA2KQuk3KRvViFFfb7T+yMW A==;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; d="scan'208";a="18253601"
X-MGA-submission: =?us-ascii?q?MDEWjf8wKdBWSLsOgUxPi2+TTFNzl4VRQdZY4J?=
 =?us-ascii?q?XFesVvyT6WCjAl3P06kKNrrgiKPVL/AUhDQrPPjJnHth69qp/4ZI2O50?=
 =?us-ascii?q?SilM59E2o0I14hFGYIFF/lIBEvhZJYSjee7hBvVd5d6b07xaNX+mEO+e?=
 =?us-ascii?q?Jt+FRYaU/GRYEMf3hbTRn1sA=3D=3D?=
Received: from mail-vi1eur03lp2104.outbound.protection.outlook.com (HELO
 EUR03-VI1-obe.outbound.protection.outlook.com) ([104.47.30.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 09:33:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+AmLeVkNHsksZnNicrWGF/aSnqOMBw+CynV5KzaGHfCQ9JXtLY70wh5rNWhQVXwo7Rr6ZoDs99CEFgsmC9Y063kgpTHv72oWF13REuhjVHq4uLYg1RQsg3dZVSqPmo24CDFj80lzKArtcj1u5XSpY9Kt5gyBoJ9pXFK8IgYYys8qxOKhe3So18QsGZJTQEVtmQzBVbu2fp9tngRUYlhwqI+1+59Oh5SL+w/NEXOmynOaw+6DnfKzt0SFhkQeiCmwR/zYSVYVJ5Ap+IFaJRWzBTWr/JINaEd+x98UfqcR91IDreWHw/0fVLAVrHJSeI2/FCT2muz+ehQgqmr33S4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a68m/xfK6+HlJm4A0W11jRqslkKywWoSxlEtxo8iU5E=;
 b=wPc7VUdZ97W7wl7YhRWKWKfDJMFhmB6Hk5Z3joGzqa2OFsKpLBqoZCr8hYYXy5Os6gOo87letDK99wvw/pE/x6d7ecjIwrEBxDEkopaNDQlCvcj1Di9RsAyC3C6noQdS+HZXyxwodZWfBSLWqJCeYVMxHYyDoF/+8lbTAwjI7s+rZD8SROEDtBaX1MeBXtn9598FykHtA36/HEZWVLyvwPJ+O3dZfEDXb1+FoRwhOkN6Gt1GyChIGSQZV/FNd1VztXfSKOCHdvHLfhRJ0Uk4JiRcydTV7SDjaup96EayW1wadpd4OIyDRbZvVo71j7Tsng7omR9B805kqdY5MOoong==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a68m/xfK6+HlJm4A0W11jRqslkKywWoSxlEtxo8iU5E=;
 b=Uwrh/VdAIYtkmEjA6P3/RedoWZGfRYpzsmWg4lR9lipYBqxUq5+XzPFm6sTS6B9SZBfrVW2+be9vKnchpbU7iuIAZjClQDkGVcEa8am9Sv7WjPdvihKzWzmkmSQVkpKSBZdnYTZ4ylcZbV2X7NYKwEv0yDwxwZWuIZ1JlShMxr1RY0Cc2M+6nEbL4s9i0ci0JGpZi+ZEUcpzPCmbCE3zh0Rj2J0h7VdlRN5le20GnfevTiGM4QpppuRmAfeSUhztfpMfoey37C1DfkEQ1gv9HwRTlf+KAEvBv/4XPsKzYxPve0yNOpKxM1eAyvgniesEZiViwbQOx1ksB5HNwQKXLA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB6307.eurprd07.prod.outlook.com (2603:10a6:20b:159::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 07:33:15 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 07:33:15 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.p.peng@intel.com" <chao.p.peng@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] intel_iommu: Fix invalidation descriptor type field
Thread-Topic: [PATCH] intel_iommu: Fix invalidation descriptor type field
Thread-Index: AQHa7UWicVLYQM2DUUmOUR+Y/zIWq7IkxCwAgAAHVAA=
Date: Tue, 13 Aug 2024 07:33:15 +0000
Message-ID: <ba607be0-8aed-42b9-a113-52e8d2f60233@eviden.com>
References: <20240813055354.2562736-1-zhenzhong.duan@intel.com>
 <9404c6b8-67ea-46bc-a702-85b3992a56f8@intel.com>
In-Reply-To: <9404c6b8-67ea-46bc-a702-85b3992a56f8@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB6307:EE_
x-ms-office365-filtering-correlation-id: 35eb6f85-649e-484e-a807-08dcbb6a319c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T0dYMU1MUUFtY0NRSEZ6ZlhFdnh6TGNSQWN6anRCYW8wLzlzcjJFTU56UkpY?=
 =?utf-8?B?WUZUZE1sdU4wUjJwdWpNZGNlRUhac0hlV0dWRnhQSUdLT0lhUTY0WTdRN0ln?=
 =?utf-8?B?Rm94SUtCNGtZMkgwSXBrdHFTTXNiK0o4bnRPWDAzbit4enppUDNCVU9SaXp3?=
 =?utf-8?B?anhkSWx1Vk43d2k0QTNXZXNTMUFHZUcvNWpxWjluKzhPZTA1YWdwRG9UUXB4?=
 =?utf-8?B?RVE2by9tQkoyeWRid0dZM1BLKzVweHRWOWhOUUpFMkdLSEZBc0EyZS9ZTkJl?=
 =?utf-8?B?VXZBanU2UkFZUGpERkt1cUtiMXp2RVczUFR4V2MxYUY2YXJPd3pGU05xKzli?=
 =?utf-8?B?cWpzUHFLZWUrVmMweExLcHc5VGhablRqUGFEcW5jNU9BcEc4Mk1VeDJaSE9z?=
 =?utf-8?B?S1EzWDdteC9UOStDU3c0eUJBaFp2SDlOSXFNcE81V0R4U1JSNFJ5OTBpQU82?=
 =?utf-8?B?SjVtRnRrR2UybDViNmpiNnpZM2ZZWlpURWJzcm9KbmdVTXlZN2RQZUNuWnAr?=
 =?utf-8?B?cHhlWkJqU25OVGl1cjY5akUzRWY1K1JlZTFuUTNvTkIxRnR6Sk5GUEtpNDRs?=
 =?utf-8?B?c20rWFJMMVczVDRkVERmK3N3K3B5ZktMRDJ2bW53WkZ2dFBlTnFER2s4Mk1B?=
 =?utf-8?B?eHNtdnUxbTVSZXJTaE1MaVFlMHIrbjJrQVlkS1VDMnlTanZzYWVMS0E0Z3JW?=
 =?utf-8?B?SUtJMVFKaFNuU3U2Y1RHZjJoampJQnphRVovWGxNV2paUWRTNm8vd2RxVU5k?=
 =?utf-8?B?Q21zc3hVbDZ6UGZjVk5teDZ2OVZCY3NJUVhtQVIwM2llL0pvZncxcUxDK3RD?=
 =?utf-8?B?ckVab0pGZHVRay85K2xnanhtK2hmQzRUNUhUam9VcUY1cm1NM3dSUnBRT3B2?=
 =?utf-8?B?bGxjMmp6eitTcFpxdlNGSzd1OXRwL212dGdIUXlXSlpONDZON1NhVWUvOEQx?=
 =?utf-8?B?TTV4RURPWS9nQnVVTXo0bVdFd2tsYzRTaEhCUzY0ZEZjQVNPNitFVUgrZmdz?=
 =?utf-8?B?UngwNy8wdlBFeFhNOGtkbzV4bXhUNnZacUdnbnQycHFlTUR5eHJycnBQb0pH?=
 =?utf-8?B?UXVUU09oemhYRXpRb09MSStCOHZVNzl1azc1VXF4UXo1ZWw4Y01VajJHTkxI?=
 =?utf-8?B?c1VJalMrdlVKbVBQSUZJK1h2eVVNOWNSNi9LQTlyZ24wQ3ptMWdOd29iSTF3?=
 =?utf-8?B?YWwwazJNMndRUWR6L0V3K1kvYVRsQ2luODVNM0J3YkJyVUpjVUVWdEYwYk80?=
 =?utf-8?B?dHovbkRXY3FQMWJsTFRmWUJ0dGM2b0FTaWxJYjNJM1dvdzB6MlNzZWppSit0?=
 =?utf-8?B?MlluSStLMGxuMjh6QUNjOEFWVERsSks5cGdYc3VnZGI1UENSbFVxTVE5bWo0?=
 =?utf-8?B?MnRoRjFKNkNSK25uUmI4TnREVnpRNWY5VkJDbXd6aXhUMUhZUFZHbGVTSHRN?=
 =?utf-8?B?cm1OU1hleXNWWCt0WjViUy93ZDB5V2pZMzQvVHBFZnh4SVJqZDhBcHdLWGRE?=
 =?utf-8?B?ZE53NkRpZEFQRzZHRGR1V2E2Y2xiWCtGR2hkZU40dHMwakY5cWF5ZnlEdzFY?=
 =?utf-8?B?dzRZRFVvUTVteFJVdmdyejg3UUVqRFBncGNsQjc1NkkrK3pxOFR3am9DdGJD?=
 =?utf-8?B?T2NWUU9Ydy90MTFPcmVOY2xtU1VNTDFQazdrcWZOTGhSQUhHeWVqRGh4SlRm?=
 =?utf-8?B?Q2FraUdWU3BHUys1SHhTUG4yRmNxQlVTKzNCcDJTazNWWThQZU9NanptWGFu?=
 =?utf-8?B?eGhMeUplcFo0c2VXWEkzU0VGRGJpZG1pZC84UkZORFFLWjJjV002ZFpvOENu?=
 =?utf-8?Q?2DJ7dDs6+IWnlxvAusOyHRAWbrNpisKi2YhDg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2tzUmRJZDltUGU5aFVncThQYkVHZ2NYTU5ZMGpORjNuczZicndWZTFxUzFX?=
 =?utf-8?B?MUNhVm5qTElTUmJkL2F6cmhiOEVNYmtMYmlmVVBvNkNGK0IvUEtYSG5rMHBv?=
 =?utf-8?B?Nmllc3F5dFE4V25NZE1kVFlZejBPMWJIVmNNekNIMVZVYktoc2lkejMxcEY0?=
 =?utf-8?B?c3EyMnd3VDF2ejQxbVdVTk9lMDREazc2emU5Unc4NjNQNWs2S25JdGd3NUtB?=
 =?utf-8?B?eWhrblVkbDFmRDBVZGhnSWdWeTMxQVVjYlQwdytueE5sS3RISDNjek95azlZ?=
 =?utf-8?B?dUhMTzV3UkhBZGcrQ2VTNE5ONEhaWkwrc1hnSmJRMFl2MHMzbGFrbVl6MUE1?=
 =?utf-8?B?YXRmR3Nna2h2M3ZmZ3VmNFVCT0E5UkFvQjFnek9mS3VBVTE2YlVDUG9zeVFF?=
 =?utf-8?B?alBGa3VSWHR0K2ZFN1RDUVhRWVVrZTVsUS9XR29DdXBJWSswaVdHRUlGOUYx?=
 =?utf-8?B?MFM5aDNRajRVSnQrSVl1V00rTHhZMEpxV0pVMXJDUkRieXlIQWcvOEs3MmNn?=
 =?utf-8?B?clZXTHFhbXQ3WW92a2RlNXhVVjdMeGlEVUxFN2ZsMDh1dmNtSjZZZG1ablUr?=
 =?utf-8?B?RkhmTVlIbFFPa3h6WFg5c3I4RFRqYlp0MHJrdGVoR2xkTkNkajI3Vlk5Kys5?=
 =?utf-8?B?MmJnbEgzMjh5S1N4STZpVDFFSHZuUllFak9RcEdqUmFlMFBpQ2ljM2dIaHVP?=
 =?utf-8?B?bmwvbjBWZVdIbG96ZmFxYjNDdXVVN1JSR2VPTUt4V09QSUxTV3g0TlF2Y1Qx?=
 =?utf-8?B?eWRuUjdFWndWbzdtZW9VWjNYZzJ1VkVOanJSMnpxd3VWQ3NCY015NnBaM0NN?=
 =?utf-8?B?emkvQ1JQSXdvVnZwaHl1c08vVnJsTWV6aEpLcTY2NkR3dnNPTkE1WE54Z0JT?=
 =?utf-8?B?MEFCWklzTXhZb3hiWnJldzBUcmFVZzlXZnJQckZUdTYyaWwrbks2eXg3SDF3?=
 =?utf-8?B?czhDY2xJbW5tTys4UGJVMS9DNi9ScjhzUjVYQ0pQWVJXaU0vcEFJSzhvbkxv?=
 =?utf-8?B?WEJnaFZwaVRLS0Rra1FhNE1ESEhPUmV2ZHY1OERqWDhXeEZIcmJNbWwwTHYr?=
 =?utf-8?B?M2o5cFpMdHJUdTFhZ01wcHpZVWZySzRJL2tZbWJEeDZENnMzMVJ1ZFpldDR2?=
 =?utf-8?B?Znlob1ppQWgrK3lIbXlpamJMYXYzcHJ3QzUzK2hQalBnaDlybDNmQlBuRkhx?=
 =?utf-8?B?VmFqZWY2enBRRXNOc2FJSm1iQWlDMi94ZUMrVDFMZXJoZTkvNXFvK0NoMHZJ?=
 =?utf-8?B?RytGZjV1MHhwU1piWVVGWmo4aGc3RmoycVZQLzFZWEtGNEUvMEt4cTg3VCtU?=
 =?utf-8?B?R1ViU1pZT3RpT1RGcUduK2ZSNlRHellCZ0JFZjRpVmV1Y1JrVHJNdThXcDll?=
 =?utf-8?B?aE5Dd1lZaVBnbXF2K25wZEJ2OVBmS2RtdTFORHV6VlNidVY2bFJtaXNURlgv?=
 =?utf-8?B?K2ZwLzlrbWd3UE5jcTRiR1lsNTdGMUpQd1NoSGcrVk5VOUkzbWM3aXU3RlVV?=
 =?utf-8?B?end6cDhtU0VCbHhkQUpDZndwR1hXSytMQTcwMjZHeUVDbkllQndTV3IyS25G?=
 =?utf-8?B?cmNZMnVVKzl5UzIzQUplSEU2RFJMMGdoVXlvRTVhWnIzTEhnc3ZZZ3FvMGtm?=
 =?utf-8?B?ZDJqYzFMZnpYRVlzWGpTMUR1SGJjeG4xZmE3VFpDaG9HTDdINjhGYlJWbE50?=
 =?utf-8?B?K3V1QnBKRjlWYXA2d2pKVGM2UVdtMmxDd2piYmhjQmJDTnc0eG80Y21FaXpL?=
 =?utf-8?B?MFBUWEVXc29hUEpEZDVtQkhqV05NZHFnS1BOOGxLblBKc0s4bkdMbm5XKzg3?=
 =?utf-8?B?Q0NxTEVNOUpVaXBaT3dVS3pRYVA2SC9GelErWWVvWXdhL042a2hkYjN4NzhC?=
 =?utf-8?B?M3h3TTJDRkhCYzFnV0QvbXZjeS9palJWREFYV3plSHMxdTdtNFFiN2FtWDFG?=
 =?utf-8?B?N3BQWVZvZ0Fud1RhL25nWmt5UjZpZWpXcmcxNDAycnB0YW5wVkVXaDJwN2Rj?=
 =?utf-8?B?ZHZvcFEwM1NVblJyeTYvTjN0THVPZTNFbTFUVzJ6aDBHdHFTTytvU050b05a?=
 =?utf-8?B?Rkd2djRMcWJ5ZjFBenQzeW5CMXhXWFBWMU1PaUxXMWtuMnFtWHdoSHovS3Vi?=
 =?utf-8?B?R1FabHZ0WXZYRmV6cXpaNlo5MEdoRWZsQ0NrSzZXMkgvZHNsZDg0OFZyN2RF?=
 =?utf-8?Q?lab60tY1xMigN1D14rJS9lk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E99C7CE02F65164CABF9CD736C78A77B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eb6f85-649e-484e-a807-08dcbb6a319c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 07:33:15.2749 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNYvUuSXCONzTG/q1aDBSOruN/8rPhuvu9tWglWbS+sUey7jIxORFHZ6vwzDCzDiQcaBUTpY23C5LhE1/5hrzXHCWxDUEM4NuRqmFtD6kcSqkjW2oM5X5FyDFgtLc5v3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6307
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEzLzA4LzIwMjQgMDk6MDYsIFlpIExpdSB3cm90ZToNCj4gQ2F1dGlvbjogRXh0ZXJu
YWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCANCj4gdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgDQo+IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDIwMjQvOC8xMyAxMzo1MywgWmhlbnpo
b25nIER1YW4gd3JvdGU6DQo+PiBBY2NvcmRpbmcgdG8gc3BlYywgaW52YWxpZGF0aW9uIGRlc2Ny
aXB0b3IgdHlwZSBpcyA3Yml0cyB3aGljaCBpcw0KPj4gY29uY2F0ZW5hdGlvbiBvZiBiaXRzWzEx
OjldIGFuZCBiaXRzWzM6MF0gb2YgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IuDQo+Pg0KPj4gQ3Vy
cmVudGx5IHdlIG9ubHkgcGljayBiaXRzWzM6MF0gYXMgdGhlIGludmFsaWRhdGlvbiB0eXBlIGFu
ZCB0cmVhdA0KPj4gYml0c1sxMTo5XSBhcyByZXNlcnZlZCB6ZXJvLiBUaGlzIGlzIG5vdCBhIHBy
b2JsZW0gZm9yIG5vdyBhcyBiaXRzWzExOjldDQo+PiBpcyB6ZXJvIGZvciBhbGwgY3VycmVudCBp
bnZhbGlkYXRpb24gdHlwZXMuIEJ1dCBpdCB3aWxsIGJyZWFrIGlmIG5ld2VyDQo+PiB0eXBlIG9j
Y3VwaWVzIGJpdHNbMTE6OV0uDQo+Pg0KPj4gRml4IGl0IGJ5IHRha2UgYml0c1sxMTo5XSBpbnRv
IHR5cGUgYW5kIG1ha2UgcmVzZXJ2ZWQgYml0cyBjaGVjayANCj4+IGFjY3VyYXRlLg0KPg0KPiBz
L3Rha2UvdGFraW5nLw0KPg0KPiBSZXZpZXdlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5j
b20+DQoNClJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmPGNsZW1lbnQubWF0aGll
dS0tZHJpZkBldmlkZW4uY29tPg0KDQo+DQo+IFRoZXJlIGlzIGFub3RoZXIgZml4IHlvdSBtYXkg
YWRkLiBJbiB2dGRfcHJvY2Vzc19pbnZfZGVzYygpLCBpdCBzaG91bGQNCj4gdHJlYXQgdGhlIHR5
cGUgVlREX0lOVl9ERVNDX1BDIGFuZCBWVERfSU5WX0RFU0NfUElPVExCIGFzIGludmFsaWQgdHlw
ZQ0KPiBpZiB2SU9NTVUgaXMgcnVubmluZyBpbiBsZWdhY3kgbW9kZS4NClBBU0lEIGJhc2VkIGRl
dmljZSBJT1RMQiBpbnZhbGlkYXRpb24gYXMgd2VsbA0KPg0KPj4gU3VnZ2VzdGVkLWJ5OiBDbMOp
bWVudCBNYXRoaWV1LS1EcmlmPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gVGVzdGVkIGludGVsLWlvbW11LmZsYXQgaW4ga3ZtLXVuaXQtdGVzdDogUEFT
Uw0KPj4gVGVzdGVkIHZmaW8gZGV2aWNlIGhvdHBsdWc6IFBBU1MNCj4+IC0tLQ0KPj4gwqAgaHcv
aTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMTEgKysrKysrLS0tLS0NCj4+IMKgIGh3L2kz
ODYvaW50ZWxfaW9tbXUuY8KgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPj4gwqAgMiBmaWxl
cyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCANCj4+IGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQo+PiBpbmRleCA1ZjMyYzM2OTQzLi4xM2Q1ZDEyOWFlIDEwMDY0
NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC0zNTYsNyArMzU2LDggQEAgdW5pb24g
VlRESW52RGVzYyB7DQo+PiDCoCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsN
Cj4+DQo+PiDCoCAvKiBNYXNrcyBmb3Igc3RydWN0IFZUREludkRlc2MgKi8NCj4+IC0jZGVmaW5l
IFZURF9JTlZfREVTQ19UWVBFwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweGYNCj4+ICsj
ZGVmaW5lIFZURF9JTlZfREVTQ19UWVBFKHZhbCnCoMKgwqDCoMKgwqDCoMKgwqAgKCgoKHZhbCkg
Pj4gNSkgJiAweDcwVUxMKSB8IFwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKHZhbCkg
JiAweGZVTEwpKQ0KPj4gwqAgI2RlZmluZSBWVERfSU5WX0RFU0NfQ0PCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAweDEgLyogQ29udGV4dC1jYWNoZSANCj4+IEludmFsaWRhdGUgRGVz
YyAqLw0KPj4gwqAgI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTELCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAweDINCj4+IMKgICNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAweDMNCj4+IEBAIC0zNzIsNyArMzczLDcgQEAgdHlwZWRlZiB1bmlvbiBW
VERJbnZEZXNjIFZUREludkRlc2M7DQo+PiDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19XQUlUX0lG
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0KQ0KPj4gwqAgI2RlZmluZSBWVERfSU5W
X0RFU0NfV0FJVF9GTsKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDFVTEwgPDwgNikNCj4+IMKgICNk
ZWZpbmUgVlREX0lOVl9ERVNDX1dBSVRfREFUQV9TSElGVMKgwqDCoCAzMg0KPj4gLSNkZWZpbmUg
VlREX0lOVl9ERVNDX1dBSVRfUlNWRF9MT8KgwqDCoMKgwqDCoCAwWGZmZmZmZjgwVUxMDQo+PiAr
I2RlZmluZSBWVERfSU5WX0RFU0NfV0FJVF9SU1ZEX0xPwqDCoMKgwqDCoMKgIDBYZmZmZmYxODBV
TEwNCj4+IMKgICNkZWZpbmUgVlREX0lOVl9ERVNDX1dBSVRfUlNWRF9IScKgwqDCoMKgwqDCoCAz
VUxMDQo+Pg0KPj4gwqAgLyogTWFza3MgZm9yIENvbnRleHQtY2FjaGUgSW52YWxpZGF0aW9uIERl
c2NyaXB0b3IgKi8NCj4+IEBAIC0zODMsNyArMzg0LDcgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZE
ZXNjIFZUREludkRlc2M7DQo+PiDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19DQ19ESUQodmFsKcKg
wqDCoMKgwqDCoMKgICgoKHZhbCkgPj4gMTYpICYgDQo+PiBWVERfRE9NQUlOX0lEX01BU0spDQo+
PiDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19DQ19TSUQodmFsKcKgwqDCoMKgwqDCoMKgICgoKHZh
bCkgPj4gMzIpICYgMHhmZmZmVUwpDQo+PiDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19DQ19GTSh2
YWwpwqDCoMKgwqDCoMKgwqDCoCAoKCh2YWwpID4+IDQ4KSAmIDNVTCkNCj4+IC0jZGVmaW5lIFZU
RF9JTlZfREVTQ19DQ19SU1ZEwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAweGZmZmMwMDAwMDAwMGZm
YzBVTEwNCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19DQ19SU1ZEwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAweGZmZmMwMDAwMDAwMGYxYzBVTEwNCj4+DQo+PiDCoCAvKiBNYXNrcyBmb3IgSU9UTEIg
SW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+PiDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RM
Ql9HwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoM1VMTCA8PCA0KQ0KPj4gQEAgLTM5Myw3ICszOTQs
NyBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCj4+IMKgICNkZWZpbmUg
VlREX0lOVl9ERVNDX0lPVExCX0RJRCh2YWwpwqDCoMKgwqAgKCgodmFsKSA+PiAxNikgJiANCj4+
IFZURF9ET01BSU5fSURfTUFTSykNCj4+IMKgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX0FE
RFIodmFsKcKgwqDCoCAoKHZhbCkgJiB+MHhmZmZVTEwpDQo+PiDCoCAjZGVmaW5lIFZURF9JTlZf
REVTQ19JT1RMQl9BTSh2YWwpwqDCoMKgwqDCoCAoKHZhbCkgJiAweDNmVUxMKQ0KPj4gLSNkZWZp
bmUgVlREX0lOVl9ERVNDX0lPVExCX1JTVkRfTE/CoMKgwqDCoMKgIDB4ZmZmZmZmZmYwMDAwZmYw
MFVMTA0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1JTVkRfTE/CoMKgwqDCoMKgIDB4
ZmZmZmZmZmYwMDAwZjEwMFVMTA0KPj4gwqAgI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUlNW
RF9IScKgwqDCoMKgwqAgMHhmODBVTEwNCj4+IMKgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExC
X1BBU0lEX1BBU0lEwqAgKDJVTEwgPDwgNCkNCj4+IMKgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lP
VExCX1BBU0lEX1BBR0XCoMKgICgzVUxMIDw8IDQpDQo+PiBAQCAtNDA2LDcgKzQwNyw3IEBAIHR5
cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4gwqAgI2RlZmluZSBWVERfSU5W
X0RFU0NfREVWSUNFX0lPVExCX1NJWkUodmFsKSAoKHZhbCkgJiAweDEpDQo+PiDCoCAjZGVmaW5l
IFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfU0lEKHZhbCkgKCgodmFsKSA+PiAzMikgJiAweEZG
RkZVTEwpDQo+PiDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9ISSAw
eGZmZVVMTA0KPj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRV9JT1RMQl9SU1ZEX0xPIDB4
ZmZmZjAwMDBmZmUwZmZmOA0KPj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRV9JT1RMQl9S
U1ZEX0xPIDB4ZmZmZjAwMDBmZmUwZjFmMA0KPj4NCj4+IMKgIC8qIFJzdmQgZmllbGQgbWFza3Mg
Zm9yIHNwdGUgKi8NCj4+IMKgICNkZWZpbmUgVlREX1NQVEVfU05QIDB4ODAwVUxMDQo+PiBkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+
PiBpbmRleCAxNmQyODg1ZmNjLi42OGNiNzJhNDgxIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9p
bnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0yNzQ0
LDcgKzI3NDQsNyBAQCBzdGF0aWMgYm9vbCANCj4+IHZ0ZF9wcm9jZXNzX2ludl9kZXNjKEludGVs
SU9NTVVTdGF0ZSAqcykNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+PiDC
oMKgwqDCoMKgIH0NCj4+DQo+PiAtwqDCoMKgIGRlc2NfdHlwZSA9IGludl9kZXNjLmxvICYgVlRE
X0lOVl9ERVNDX1RZUEU7DQo+PiArwqDCoMKgIGRlc2NfdHlwZSA9IFZURF9JTlZfREVTQ19UWVBF
KGludl9kZXNjLmxvKTsNCj4+IMKgwqDCoMKgwqAgLyogRklYTUU6IHNob3VsZCB1cGRhdGUgYXQg
Zmlyc3Qgb3IgYXQgbGFzdD8gKi8NCj4+IMKgwqDCoMKgwqAgcy0+aXFfbGFzdF9kZXNjX3R5cGUg
PSBkZXNjX3R5cGU7DQo+Pg0KPg0KPiAtLSANCj4gUmVnYXJkcywNCj4gWWkgTGl1DQo=

