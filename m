Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A05C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 00:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnRzC-0004Uz-3i; Wed, 26 Feb 2025 19:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnRz8-0004UU-ST
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 19:42:43 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnRz5-00012g-Pn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 19:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740616959; x=1772152959;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=gCoxv5BifRMLYzPj12fV0aDOJZIamygA+RsSqAp1mMs=;
 b=jRGZErRBC8+0GMhWV75X3kJPxMQP3TtqDvQcv7UcgcAINUELeo3vDxrt
 O2X0ReIMH92MfdKNuQ7CJ0EemV8cu5gJuZlVDYK5Kt5wPGm0FtIUxlHAf
 jvl55cNq8QHhXOX7aIksuVlq42uo3UvF2ZQ+lMBbH0Bwt8suOSJn3ySG5
 ZnKO6gjbIrao9bgZWThBku9PRNMsbnfWnFxmMK2+k2jNbd3cdTr6+lYK9
 CmG/JvLSZTaBEuznUqsXpVIU4iyu7i64isNo82UNISA9GXmIKZh4UaQmv
 eWgU5JnGCk6epjDKFcQdmMJoZS3yinmbMBtm5XCgVFBk7nPlefTXZ7+8m Q==;
X-CSE-ConnectionGUID: kq91xdLIT92DXS8595Cm2A==
X-CSE-MsgGUID: U3vyNY0URuubvw0A0Hzh4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="147783663"
X-IronPort-AV: E=Sophos;i="6.13,318,1732546800"; d="scan'208";a="147783663"
Received: from mail-japanwestazlp17011029.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.29])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 09:42:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xzX5fo6DzjBw92GsTh84DkOYeWF1DuUKsfituSo/47RZ9jRbdjURL3zUjowZy6SgNxv6/Ddz3l/ZmyZ2Ko9M4eneeQ1RAGJdcrs7LA+QmRc1TwM3d0yAZi3a05baFWe8M9dbc+8VBqOUXiQX8lQ/RFFrpLmN8uYmo3PzCFIgvPIEJCpSwyQBfltR64QjM7gxXmYEVnfFzZlY/rIi9OA/L/kJ7DQeCjwpL9haSvv6GX4QOGJ1EsQ9bh8nXxWTFLN4d3Yk5zvLmTf2MiYjNlqNyM4Xo3Tuvf9tSkmIdsCYqGHU+XtVsHf9jwIhnk5Tao7fHvCpgHaFQjmbIj68akVWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCoxv5BifRMLYzPj12fV0aDOJZIamygA+RsSqAp1mMs=;
 b=WXNwB+xasVOgNOBlIVT/Z8hxblZ3jrsDALBt71tgCujdZHK7EP//67dl38bN2ezWPFUbG7IQyVkU0yRVwWIIecUPT6o+YePKa3Q+LYeDnDSIWMRCnLtbUihqa82JmBfNVTJuc2+YwH53byfXhcj9Qbesw9RB7S6CBZ2qrtTHEHf9WrgrCgiYOLPrsBNqE1j/RVvfkU0j5/d162GYXum0CsP3A/zVFqY8yWGrXJZny1eOjUgJ6l+SKzyWJkQF4g7ibmkWKkiku75o6YoNw/TMuMmvwdkNnojHef/M5P4cfIF6iyP5EvEG9VTjCI0ppNL08WtFjA0PnMNCj9/VHpAa5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS3PR01MB7262.jpnprd01.prod.outlook.com (2603:1096:604:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 00:42:31 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 00:42:31 +0000
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/6] migration: Unfold control_save_page()
Thread-Topic: [PATCH v4 5/6] migration: Unfold control_save_page()
Thread-Index: AQHbiBfD0ERu5C23dk2y9w5blgX+YLNZvHeAgACUTQA=
Date: Thu, 27 Feb 2025 00:42:30 +0000
Message-ID: <fd138e06-29de-4ce2-8105-74a5c9f96f8f@fujitsu.com>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
 <20250226063043.732455-6-lizhijian@fujitsu.com> <Z784ja61Oh1cv0V0@x1.local>
In-Reply-To: <Z784ja61Oh1cv0V0@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS3PR01MB7262:EE_
x-ms-office365-filtering-correlation-id: 09ff2ca0-568b-483b-5045-08dd56c79dd1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?VXpIVGZUbmdJam1GYVJXN0pKSEZhSkVqeERMODRMUW8xZHBJMWpUekFpRzN5?=
 =?utf-8?B?cDNGbld4aFVxdGQ2NURlOVlGN1g2VWtkYkkzb3hzekJSR0o5Qnc2eStEMjh1?=
 =?utf-8?B?SndjR1BOME1LSGlBM3p1bFJHOHVOR2l0RG9QcysrWDVkM1RlZXNMK0ZNS2Vk?=
 =?utf-8?B?dk9qZHFTeDFwOFhhL2NibTdiTVFZNEQ3N25OY2pDVnorZnA0M1BBVnRPNUEr?=
 =?utf-8?B?UW9BK3BJa0JXZGdUa2w0c0FBaTQ5aytWdFh4RXE4dDR6SXVjN2dyamZZYmk0?=
 =?utf-8?B?WmF2T3NGZ3RxOXQxbU9MczZicFdSMnJJZnlpNVJjejV2K3lTZWZvY2ZsZFZZ?=
 =?utf-8?B?SEFqa3lpd0NHQURnMTdFRklQcmpSbjJzQTNvR3N2QlNsVnh0bmZOc2FYcFls?=
 =?utf-8?B?cDFJQjZWS29aOTZnMjRsTXZrRUVXMExBQnoyMXg4b0V4ZVp5S3JmT0o5TmVo?=
 =?utf-8?B?YWxnaGthaFRtTUxlUjBxdWVZdXd3dEVrbnlvdnAwMXB0L0wxbEQyR2ZEOXhW?=
 =?utf-8?B?V25EZG5qWXN1emhxL3NRNFB1Q0pDVkJaekZqSXZOL2Q5WHExc1Y5NFJxcXlB?=
 =?utf-8?B?OEdkNmhNOWowS3h6M3N4MHlPUThqaU9STkRGeXNpMEI0Y2hDdVk1dXNxUkRr?=
 =?utf-8?B?ejlnaEFQbWxGUVYxNnY1Um1ZMmw1dnZlNmh0VGRCQ29kQlFaSUlWcFN6cVBq?=
 =?utf-8?B?ejMwdGF4b1A3MHJva1lubWltOTE5ZnZxaVVPcVlZT3dyTktYZWxRUERQV0Jl?=
 =?utf-8?B?ek1kTDlCTUJBbDhBbzUzZlVvenZtc2RVRmtnbFNCTXA0QjVlcTQ3bW1GWXpK?=
 =?utf-8?B?SVpFNkNHZUFiT2o1WC90bGE4Szk0d3VoRWg3b1puTnRZOE9PRXN0RzhFT1ZP?=
 =?utf-8?B?ellCbFlRdWxkZkFYTXZlTHpBaXdmNXFXMWlQOXczRTZvcWdLK2p0SXp1RWF3?=
 =?utf-8?B?YWEyU3hLYVQzUGZuNlhJU1hnbTB2czhBY1BTNTBlcS9QZTFzVUdHYWhzNEZm?=
 =?utf-8?B?eVY4WHNZb1g0UUpPcFYvNng5WHk3b21uNi9OYTBiT0lRcXFlN1daU2pMMklu?=
 =?utf-8?B?UjVwa3VWSFV6dWpyTitLYVB5SVlKTm5ubXVMT2xQWGFnNFhGZnp3a3FoVjds?=
 =?utf-8?B?V3dzb05HTk9jeHZ4NEY4Z0RJSEtyekFTY3lzb3o4T2h3ZG9DR2xQaGRPZ2JF?=
 =?utf-8?B?Q1VHcWltaWx5OW04ZXU5RVdzajhxaUxEZzlkYXlwZXpZMVl5YitQbktPNGd3?=
 =?utf-8?B?bDBXUmx3RStkZnlBeENtMXFOTmhZSm1yaE15aG1sK2JQSElkM0t2dTkrTExn?=
 =?utf-8?B?SnJNU25kV1RwNnU1S2JldUJvOGw3TEF6K2VETXpoVnlBWXgwVHYzanpmUTd1?=
 =?utf-8?B?UFZyLzRFd2ZvQ1BrZnJsNW9GZnFXd3E0d2UwYmJHbmVjVU1hWGxzdnZ4eG1F?=
 =?utf-8?B?aVY4UWJuaWJNNEhQdElFOCtzcmZJQ2hiRHhuZmh2TjFzOTdBZjhHMkdxOUF0?=
 =?utf-8?B?Rk91eDdzVHdOUGVGWjBUNWxPU0J5MzV5R3ozRkdON1hzbFVaWkpiTzNReEtP?=
 =?utf-8?B?WFVlbHdiNmdaZERydjZUdHRiZHAzc2N1QkZ1VHlpWnU4aHJsYkoyR2FXeHZ6?=
 =?utf-8?B?UE54MnRQdFcweGVvNEwyUy9wZS9rRmsrUktRNWxNaVVvTUVraHhJWUlmelZy?=
 =?utf-8?B?dDZOZWZBQjB6SGYxMTVKZ2E2WFVMNFNFSDc2NVZVYnhyczExcUY2SGYwc1VB?=
 =?utf-8?B?TFBBWFVwK01KWjNqR2VKci9tVm94VFpOMk1MblJnT0krRGtnVEhFUEJ2blFl?=
 =?utf-8?B?ajd2cldWNFJwTG8zUXZUT3luVmV1eWpkSlNNUDE0UkpUUlFtWUgwaVpIdlBG?=
 =?utf-8?B?NjB4QklBUjM0Mk16bytuU080Q2FHQ0I4QjNkdmxtbjFUN0lFY3BUcEd0aHgz?=
 =?utf-8?B?VDIrdGFjMFp5OWI1dU51bkowUE9mTFk3bFVaN2E5TkFiakdjQjJ2NnBQODNj?=
 =?utf-8?B?MzBxTjFJTk1RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clgzMmlISWgwdzFWOTI1dFdTOVlsbzcza3ptSEFUNG92T2YzZmZzdm5hTitD?=
 =?utf-8?B?VzEzczFGcHFFcWtZdGpmTythUFYzclF3TExLQVRTZHhRbXA2UWtLdkdUT2s5?=
 =?utf-8?B?bzNPQWNYVFVVT0dPbHhLTDFJOUlFK3J2em9jQkk5WEg1eDNMdEVLMmlMVUV2?=
 =?utf-8?B?VXk4TjRyMkxub2dvbDg1aW8vQVh1MDRkQUM1T2NmTDhVc3JjdiswajhpYkM2?=
 =?utf-8?B?RFBNTTdqUjJiQ1BpVEY5NjU2ZDRJSzhOdCtjZmVlTW9jTzkyTWgzNWRQbjRx?=
 =?utf-8?B?U1lxMW4zQVJOOHVkMTFZUkJOeThUVXQ0NTMwZWdRNk1LYm10WnkwOGdNaHR4?=
 =?utf-8?B?TjZjSVQ1NzI0SzdDSFdFUW0ybmZ0VWp6aHBKWXUxWkJXRXpQVGIvMVZaYlBv?=
 =?utf-8?B?TXdWZXBORHVNb1BDeTZqKzNyUnAyeVBUZUhBUmVpbHdLSWgzN3lkQUpjZXlY?=
 =?utf-8?B?OTJCaVFtU0cxc2dVd0E1RytONHd3WlV5cFJJMUJQMFVRc21FVG1pYzB5YnFI?=
 =?utf-8?B?WXlWdnBnUDFNaFNrZWZ3b0ZVRUh2VzlmaVAvOHhCcy9ueDQvdUM5cTkzTSs5?=
 =?utf-8?B?M1ExY29DVndvSHFVcm56UW0zMm96MXNZTStuSWlESDY5RlpzRSttdDBnaWpW?=
 =?utf-8?B?Z1JONEEvdHR0NVJGOWc0aFVLTjJpcUpFZzE4cWRwMDg5TW40WHRmY2JSZ0lT?=
 =?utf-8?B?MFMyR2xxS1N4dnJ4M0s2UjBMMW5tdFBTM0tmRkRhbnlZMnMvdDhXYzY5RVhB?=
 =?utf-8?B?Z3FLWm94OWYyV05oMUxYUHBEa2lrR2lIdGlwNmIvaWtwZ0w3ZWVRTjY5OWNV?=
 =?utf-8?B?ZkpLV2RkbXFpM0FsT2I4aktJbHR3WDNnZklPd1crTFNRZmQyLzdhc21Rclp6?=
 =?utf-8?B?YitNT1lJTERXUXVjbTFHVmhnUFdLeCtqRVBBeXpMYnNiWVRNWHRBMm9FbWU4?=
 =?utf-8?B?b3NHbllza0Q0dmVOUENrNUFsK1BnMlZZZkRydmdkcXhna29kOXY5eDdlZS9w?=
 =?utf-8?B?UDVzeGVhTENXUjdUMittUmt3UUxEMFNCM05aU0hFcFZoMnRnUDRLZE1qTFh6?=
 =?utf-8?B?WFRRb1A2YjFkV1ZpYmxFVXRraHJJaVM2c0VQZjdWb0xGenBraWF6TlkzOFJ5?=
 =?utf-8?B?Yll1K0hqSzN1SlJMMVI3R1NnUFdZdCttTEVqYlVHaXlVenh4QWpMSm5pbUVz?=
 =?utf-8?B?eDBZOGo5d2VjdDRUdDE3UW90S0R4MEtHNGdvRStVTXAwNkE1REpHNzlhTVlV?=
 =?utf-8?B?M24zZDVqYVJqWEFLL2xrRVYvOGtBc0ptWnJadWVYQytmUnduQzVUNUg4Q2VE?=
 =?utf-8?B?bGhiMHdGTGRqQ1BCSjZPT1k4TlBWWEdRbTNlWm9MZkxsMGdKZ1pSRG1JM2J2?=
 =?utf-8?B?QTkybXJRanl6cklac2pOVkdEUnpIRXZ6TmdQZ0FQV1NRV2VFUndsZnR4WXk1?=
 =?utf-8?B?ZXoyOWd0U0I1bDh0ZGpucDlPVXR6anBDZk1JVlZwL2ZlUVd1OGhIY2pFeThJ?=
 =?utf-8?B?MFlDbXBEL2F3d0N3TWlESU5LeVFlSHlvSE02ZTFZbnZEVXpCbGFLTTF4VmIr?=
 =?utf-8?B?aUFXMEJaaXVtRzQwd3ZGVlBJZzlIK2xvYkthL1BUQmI0WVpLU01RR0lzOFBR?=
 =?utf-8?B?YmpYSUZGTVFYMU9IYlY2SU5XYnZhSzd6VXRGTXd0Nmtpc09FYytrZFc2Znlz?=
 =?utf-8?B?MExadWhUOEF3MkUwTXpPMEtiSFBKRlBXK1Z2OU0rakhYZXFXVEM0QVlraVdO?=
 =?utf-8?B?bFZyU09JY1B1ZlRGTElGSmI2RHdSUzNLRDJuOWlmK1owRUhxVXVTVWZXZVhU?=
 =?utf-8?B?UVlFa1RYeUR4aG5qWTI1TFZ6VWNQWHB2cWJBdmdyWHBYVnhpNFFyNUlzb3lu?=
 =?utf-8?B?dDcrZGZJS2crc2tZU1JXTVAwNzJQRzN0d043VHBJdUlFM1N1Mm9MZmFZUTRl?=
 =?utf-8?B?TjRhSXdBOEVyZFh0RDNKZEtEU3hNYlF2S0lhYkMrWE1JNitzZjhUanVsUUhr?=
 =?utf-8?B?ZW02SlJwNHh2eTFjUlRaV25rTk5zWS9xcVdPekdka1lydEhGV3phVDgrWHov?=
 =?utf-8?B?S3lTeVdhcndGZWRWVUlYVGZxWk9SMEI4RGx5bEdXRmRvVGNES2pZc0lUTDlU?=
 =?utf-8?B?alhURTlWOEVmak52NmxwUkJZeXJXaGhsZ0txazlwK0hrVlJPRXV1a013TkZD?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D84453A2D96C7B4CB437B045EFCD6E03@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jQo+qFU1m0BFQTxHQrX14EAKjY/LnDwocS3f3OYcFbP8edb5ttUd6PDWFNlcjjaCBP+y20XN9v3AAe1ydIRc0W6rgkF0OqWSgmJKhXxGP/ZRXrFlJm/n0dragqD+vKW6hFRu/sydkjAEjDW2OaTq6Y1FgVZH2dxyBKliKkbRmFnpIf1LnKQQcsuOashNs4+zRc5brdFnhheuYckfdxR7Qoc/EXANQ1fWMDyoRecld1CWKvWaJKe9a/Dn+zZwzWlF+tm8or0X+L42X29HI7Wy9NWHs8VTOumrGIt7PZ61Jt+NAp7nrNY/J1tLgPLry3crqvhuUM3arrL4fHi3jXSHsv1jdbON3GAcvia7hF5jw2M/Ukdis7iyjukoe+M0CcB/OLfHPWXHKi5sYaO0hc4QALgxN2juSVlddoa69B2FV4DkTz3hQdWjzqgXEBSfy3oLLXm4LfC1Q33Fef5lw6x9fW4C9L3iyfNS9DYqR6EYU40TBwO16wjARsoSX6N9iVxS+SnA93hEabQh4ldYp1frZljhMCnHat0K1AsLtkHohR8XkaLHZviFhHbC1ZqW6pOn65HlEGhhwlVBsIpz8wl5Aa7jE6yz31b11rLy0zpSU3/tbKzbN5+vBjIQVV43ZS0l
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ff2ca0-568b-483b-5045-08dd56c79dd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 00:42:30.2098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iz8jSPBKhao/ZO53XG8IJuRx9jH2bIPr54n9GeybxcbX63EUqK3TFDQxR4awXa87OVWIEKxVTJq8bE6VvNLobw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7262
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

DQoNCk9uIDI2LzAyLzIwMjUgMjM6NTEsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBXZWQsIEZlYiAy
NiwgMjAyNSBhdCAwMjozMDo0MlBNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gY29udHJv
bF9zYXZlX3BhZ2UoKSBpcyBmb3IgUkRNQSBvbmx5LCB1bmZvbGQgaXQgdG8gbWFrZSB0aGUgY29k
ZSBtb3JlDQo+PiBjbGVhci4NCj4+IEluIGFkZGl0aW9uOg0KPj4gICAtIFNpbWlsYXIgdG8gb3Ro
ZXIgYnJhbmNoZXMgc3R5bGUgaW4gcmFtX3NhdmVfdGFyZ2V0X3BhZ2UoKSwgaW52b2x2ZSBSRE1B
DQo+PiAgICAgb25seSBpZiB0aGUgY29uZGl0aW9uICdtaWdyYXRlX3JkbWEoKScgaXMgdHJ1ZS4N
Cj4+ICAgLSBGdXJ0aGVyIHNpbXBsaWZ5IHRoZSBjb2RlIGJ5IHJlbW92aW5nIHRoZSBSQU1fU0FW
RV9DT05UUk9MX05PVF9TVVBQLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCj4gDQo+IFsuLi5dDQo+IA0KPj4gQEAgLTU2LDcgKzU1LDcg
QEAgc3RhdGljIGlubGluZQ0KPj4gICBpbnQgcmRtYV9jb250cm9sX3NhdmVfcGFnZShRRU1VRmls
ZSAqZiwgcmFtX2FkZHJfdCBibG9ja19vZmZzZXQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJhbV9hZGRyX3Qgb2Zmc2V0LCBzaXplX3Qgc2l6ZSkNCj4+ICAgew0KPj4gLSAgICBy
ZXR1cm4gUkFNX1NBVkVfQ09OVFJPTF9OT1RfU1VQUDsNCj4+ICsgICAgZ19hc3NlcnRfbm90X3Jl
YWNoZWQoKTsNCj4+ICAgfQ0KPiANCj4gTm90IHN1cmUgaWYgc29tZSBjb21waWxlciB3aWxsIGJl
IHVuaGFwcHkgb24gdGhlIHJldHZhbCBub3QgcHJvdmlkZWQsIGJ1dA0KPiBhbnl3YXkgd2UnbGwg
c2VlLi4NCg0KVGhlcmUgaXMgbm8gcHJvYmxlbSBpbiBmZWRvcmEgNDAoZ2NjIDE0LjIuMSkgYW5k
IHVidW50dTIyMDQoZ2NjIDExLjQuMCkgd2l0aCAtLWRpc2FibGUtcmRtYS4NCg0KSSBhbHNvIG5v
dGljZWQgd2UgaGF2ZSBhIGZldyBleGlzdGluZyBzYW1lIHVzYWdlOg0KDQoxNzA4IGJvb2wgcmFt
X3dyaXRlX3RyYWNraW5nX2NvbXBhdGlibGUodm9pZCkNCjE3MDkgew0KMTcxMCAgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsNCjE3MTEgfQ0KMTcxMg0KMTcxMyBpbnQgcmFtX3dyaXRlX3RyYWNr
aW5nX3N0YXJ0KHZvaWQpDQoxNzE0IHsNCjE3MTUgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7
DQoxNzE2IH0NCjE3MTcNCjE3MTggdm9pZCByYW1fd3JpdGVfdHJhY2tpbmdfc3RvcCh2b2lkKQ0K
MTcxOSB7DQoxNzIwICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOw0KMTcyMSB9DQoNCg0KSSBh
bHNvIGFza2VkIHRoZSBBSS9EZWVwc2Vlay1SMSwgcGFzdGVkIGEgcGllY2Ugb2YgaGlzIGFuc3dl
cg0KDQpgYGANCjMuIFdoeSBObyBXYXJuaW5nIGZvciBNaXNzaW5nIHJldHVybj8g8J+aqA0KVHlw
aWNhbCBjYXNlOiBBIG5vbi12b2lkIGZ1bmN0aW9uIG1pc3NpbmcgYSByZXR1cm4gdHJpZ2dlcnMg
LVdyZXR1cm4tdHlwZSB3YXJuaW5ncyAoZW5hYmxlZCBieSAtV2FsbCkuDQpUaGlzIGNhc2U6IFRo
ZSBub3JldHVybiBhbm5vdGF0aW9uIGVuc3VyZXMgbm8gZXhlY3V0aW9uIHBhdGggZXhpc3RzIGJl
eW9uZCBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpLiBCZWNhdXNlIHRoZSBjb21waWxlciByZWNvZ25p
emVzIHRoaXMsIG5vIHdhcm5pbmcgaXMgbmVjZXNzYXJ5Lg0KDQpDb25jbHVzaW9uDQpHQ0MgdHJ1
c3RzIHRoZSBub3JldHVybiBhbm5vdGF0aW9uIG9mIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCksIHJl
Y29nbml6aW5nIHRoYXQgdGhlIGZ1bmN0aW9u4oCZcyBjb250cm9sIGZsb3cgZW5kcyB0aGVyZS4g
VGh1cywgbm8gd2FybmluZyBpcyBlbWl0dGVkLiBGb3IgY29kZSBzYWZldHksIGVuc3VyZSBhc3Nl
cnRpb25zIGFyZSBhY3RpdmUgb3IgYWRkIGZhbGxiYWNrIGNvZGUgaWYgbmVlZGVkLg0KYGBgDQoN
Cj4gDQo+IFJldmlld2VkLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IA0KPj4g
ICAjZW5kaWYNCj4+ICAgI2VuZGlmDQo+PiAtLSANCj4+IDIuNDQuMA0KPj4NCj4g

