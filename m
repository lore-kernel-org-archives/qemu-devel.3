Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210FBC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 06:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnB07-0006BO-H5; Wed, 26 Feb 2025 01:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnB06-0006BF-B8
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:34:34 -0500
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tnB03-0002Uq-NG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 01:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740551672; x=1772087672;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4cYOYFyUVleVRZ6tF8YPS7BZd+6CwPGLIHwRb9acmwY=;
 b=jkP4YevvXXxKvNcz60WQC7/eye8iLEzCy2nsbrrqAXQ9q3cUlU0LGBxM
 V04Za7Kok3LhulTzR4ajS4/r8VAT4Q7pmp4MjRF+mfEgM8Y9wbKAt/l6/
 c0Gh2fh6hOccwBVzdwMYiW5KBYDkkR4dmYIEL3VI+eMapaoo2iT+qjsoH
 KDtxFZhXE8GdYTxkBcaMHfSIGKO3hxKEsWwN8u2gZoAQ6FWTHBsK/VJvy
 4VnjU8LZ/fdXL3quIQlxXYuKZq9uZBgWrT0+HSWwInzRZvKHWPErPMZ+t
 WYr8h4jENS/Ob724G7kzH7n4fyRGmiP72t9w/WqGSkrxHQ2C+qGeZIhpK g==;
X-CSE-ConnectionGUID: KE2PptETRKWxIzzLHmtAHA==
X-CSE-MsgGUID: zFnjivRIQvaCnYnsaIqD+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="147414295"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; d="scan'208";a="147414295"
Received: from mail-japaneastazlp17011026.outbound.protection.outlook.com
 (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.26])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 15:34:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfvihl8TRm1ZRrvzQOhPx1wQQwCR+EWd2wOgDj4OeQRefQowD9UpX99mC14oSb3mwRXW9T+TNTmFOmlvdj/Dh5y9XH/M94RR2Nb292zCpvyefMVqPgUxE8lKmN83FNLMUnOqSiKGlPNtKmPQ8LiCarU9rRed7LNm5gCEIZwsYMpbvcU6S5A9ebxt0LkScVOUAHo6hZFOO2M6wF4MH9m4KF0xEWRXpyjZaa4ANLTmiz1AsTzhJGIIyI5ZlVxoWR99BksJw/r0oL5Y3EeXEuHYOacshnerLHSwHGwAiwE7HQZpqA42SIdHo4eRehhl9sqkzQSaOeMHBUlCSJYpBfFOMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cYOYFyUVleVRZ6tF8YPS7BZd+6CwPGLIHwRb9acmwY=;
 b=LSBcwa0Ls8G/Q3JJWy5XdA2cQZA00dkw/fUWJ9JWhKUz9El64peaIO1IeCCGZ9TMRhOA4kR7wwCJpLrQBveMaEtFcmAMXzaphMRF0RGPGVLFyWSLfycy92xe+GfOFL4gxvgUewDY8kbHKUDqZ4VzwC9SVNHStu2d+X6MOUICxtKeSSbZWo4pxlZun5gyMHYB5E+l9S0Y6JCWFpI5dqhLmALfQl+4n/ib0xfMTD1jtDZ2eSioIKzf0PpTzu4i/DAE3+Vp5g/x0zC4neyzmzqpD6AWFjbflLbmXz2g3WKs7vDZPN3LipHh/Tr5hoZIlATJxzCTg/mkih45YmxP+er5WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS0PR01MB6337.jpnprd01.prod.outlook.com (2603:1096:604:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 06:34:20 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 06:34:19 +0000
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/8] migration: Add
 migration_capabilities_and_transport_compatible() helper
Thread-Topic: [PATCH v2 5/8] migration: Add
 migration_capabilities_and_transport_compatible() helper
Thread-Index: AQHbhCrAGTsslv7mgkOBXKbI2mkTBrNW5JiAgACyeQCAAIkygIABCFKA
Date: Wed, 26 Feb 2025 06:34:18 +0000
Message-ID: <164e58f3-cb66-4089-a8bd-501e02724cbb@fujitsu.com>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-6-lizhijian@fujitsu.com> <Z7zPYfWp2fLRB63W@x1.local>
 <8e363920-aafa-4991-b633-fa9473406b17@fujitsu.com>
 <Z73YL3VnrmxHxZ5M@x1.local>
In-Reply-To: <Z73YL3VnrmxHxZ5M@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS0PR01MB6337:EE_
x-ms-office365-filtering-correlation-id: 7ee64f97-c973-484b-91ac-08dd562f9947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?OUE0OWQ5SWxmN1pHZjZ6SFJIRlVFL05KSE9rWW42TkF0UUNISXhUK0Eyc2Jl?=
 =?utf-8?B?QUhSSHI5Y1AyMU02NjFxRHdIWWJObzZzamJ1YzZIMmFuU3piSm5MeDdBL2lU?=
 =?utf-8?B?NUp0cTN4M1lENzEySFRWdHhIM3lMVTM2TS9NVmtHcS9RRTdscUhlWUp3K0pK?=
 =?utf-8?B?cDFWT2RjU3NUb09GMFlKZWZKNVNydFRYZzNqQ0Vod2RaYWVOYkx1dXJORzJZ?=
 =?utf-8?B?czhzZitFNFJ0RUtOdFFWaERUeXYxaEh5K2Q0Y1RWUmZZQ0x1ZFlqdWRlbnA5?=
 =?utf-8?B?UkFiejQ0TEYzZGtob0lpMjZ2SHZGaW9yWGdsUTZtWXAyaStHZlJ1WEVBUjdm?=
 =?utf-8?B?N3c1UU1wMHEzSGtYLzg4ZEJNaEtYNkY5YzJXdUIvOW1RZXoxN3Jycm5Ldm1G?=
 =?utf-8?B?MHlteEdETGFJQ0dFVVNObWFkbHNkblhUaWpnSlExME9rS2lvcWZCVk54cXZK?=
 =?utf-8?B?dFFSREpCOFVwV0xIWnJUSzMwM2NwMnVMNDg3UnNlMWJhT3FGN1B2S1J4WmxQ?=
 =?utf-8?B?aXY1V01OcFd6VmdhZFRGNFJQUkNtbGQ5b0d0a0cvMHJuaXNweGhmOHgrTmV4?=
 =?utf-8?B?bGFTLzRsam5qWTAvblZTd1pYa0M0WUNrMVBXVk03Yzd5NDZKb1k3d2w4aWts?=
 =?utf-8?B?c3c1M05kUTIzSExtV3ZFV0ZJM2hCY2JIYnFKWG43RmtOdFhES0NKc3pLcHRs?=
 =?utf-8?B?YXJtdW9YWUFHdkplRU8zVXdNWkJaR3lpRXF4WnpWcjZXakNuQzRLcEhwUWNy?=
 =?utf-8?B?MEVzaVRKUW9JNkE5cHZXeUdvTFhVdmYzdVZRSmNYTVpGWDNtRUttVFAwUWdP?=
 =?utf-8?B?NG5YYmJFRUNLRXE3UzhPQmdxY0VTM2FMNzV6b3IvTnl4dEdHdWdraWxtcDU2?=
 =?utf-8?B?YStlZkp3Qy8vMUpQQ0ZPemZOVFVoVVJ2dDkzV244UmNsNEp1TWVVeDRDeUlG?=
 =?utf-8?B?TXU4aDdsQlUxVkJlOXZOSi96Q1pIdzJBeDRXNzBBMjZNSmxQcDF6TzZZUUU1?=
 =?utf-8?B?OHhreEY4OU9RdE8vYkRPQWFLNjFacHdBV2tadnlMdEV1dDI5cytQdDhoVXJW?=
 =?utf-8?B?bXYvTS9HMVB4UmFkcWxLZlZlUnZMdnB2aTdYU2d3cVh0a2ZtTUY4VEp6R0ps?=
 =?utf-8?B?R3RCSUJqNnBXNkhKbVhzckhZUkJ0dDNDQjYrbWZpbVVsb0I1dTBZQ3VWS2xM?=
 =?utf-8?B?V0NtSzJTWUcvZURjN2RwZEh0WDEzQS9sWnpwTjZXV1haM01yZWdjcGV3TnF3?=
 =?utf-8?B?c3dpQ0MzMEl5NGxGNFlZVElVdGdMVXYrTkJsRnFuVzRsZXVVMzYraHY0VTFF?=
 =?utf-8?B?aEwyeFNtcjlUZEhmRGU2eEdJNC8zWkozL3IvYzZwMHJOMkk1T3AzZUdaaUhJ?=
 =?utf-8?B?ZlVRUHp6ZWtheEZBR1J5RnZ4TkYzWUxPUDB5OG01OVNZQTlyR1N4bzdSbjBK?=
 =?utf-8?B?MU1CRTd5NWV6VEVTZ3JRclpUTTI3TEl2eFBpakhscWoxRWxSZ1l2NkNSSjJy?=
 =?utf-8?B?eDlHbTZhQmU2cURiTmgwb3RqTE1GeU5mL2ZEdzRMcStBOWhGdkozYnhBQXJP?=
 =?utf-8?B?c3dIUXhzbnBwWnpjMHVGQy94MWdrRHhoRENYa0pUWXFKYlVvK09Nak8rM3F2?=
 =?utf-8?B?ZXFlanNnRTl1OEhDajY1eDd1b1prckc0RHlyT0hkQXp0TFpQSi9UdkN4eEY4?=
 =?utf-8?B?dk51SElFOWZkY1lQcXNONzNsZ1poblpWODF3aHg4bXMraXFaeWJoTDYwaXR3?=
 =?utf-8?B?ZHdLNEpuSFNFRjJmTjlDZ1AvNmV0aXMxMjF1WHdIcEREV1BTamZBNzVPdEpj?=
 =?utf-8?B?ZnhMcnNVWjJRNm91Rmw4cWFqVDQ4MGZaZmdLZkRETVJLWjRoSWNPZUd0Q282?=
 =?utf-8?B?cmxqWE9SU2o4NFJOeDB4SHpTVU15U2pnRVNGQnlFbExiQXVaVzc1emw4ZEhX?=
 =?utf-8?B?SUFnMlVTR0NMWWFCdm5HUXNuV2hBV1hwWjlFYW5iNWt5R3JZeGNnRHRjYXVm?=
 =?utf-8?B?TXRkVGJYK3F3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk9LNk1QV0g1OWYvWExmL0wwTStBNFJ6QzlWNThKM2VyVGhCNkpCVzBEeFRk?=
 =?utf-8?B?Z2YwNE9IYXBoRG9BT0ttUUlLMHlFSVBPUWV4ak5MdHYvQm00Wm8wNU92MmVm?=
 =?utf-8?B?SHJIaTRZa1k0MlU2NFhNU1laaEdlU05ON250TWh2eHZ5bTYyd3dteUZVSmFH?=
 =?utf-8?B?cU12QlNCTnYxaTR1MEE5ZHdHcUlOeTNiMXhxRE9kVkYwU0RDcjhxb0Z1dyt1?=
 =?utf-8?B?cXhPZU9ocHdnRC9tSEJRSUp4NE40MGZ1cm51d0x5dTJXeUd3b1I0cHY1YjFT?=
 =?utf-8?B?Y0JrVGNYVVB5MGtYaDhxcTl0UCtFVG5XREIxWC9mNXY5bFNIVXNJS3RRbE40?=
 =?utf-8?B?N0N0Z3hyZFZLSUJzSVlwN3ZvZ3NNVnRuQUdQL1Y1S2o0Yy80eEZKNkxhZjFK?=
 =?utf-8?B?dGlYazdBZUk0MWJXcUtZekd0OC9jczY1d21QZFhqcHpSNERyYmZTVlAvUmls?=
 =?utf-8?B?Q1k0ZWF2Z0ZqQ2Q3R0xPaEdVanlMbzdCdkZ5Rzg4OERXbllxc1cvaFMwM2hR?=
 =?utf-8?B?ODMvL1NpbmJ0UHRlamhKNWVIbk9PSy9NVTFFUFpxRDR0V2wwRVBZRnJvdzV2?=
 =?utf-8?B?WWoxS3d2WVRiTHp5c3FXRkQyaDd6NnBxbFBHczJIWU9YUjJiZDl6NkNkSG8y?=
 =?utf-8?B?UUU2SFY4djE0WlNZeGRaOE5nZUJCcEw4NnA1OE9lcHlEK3VoSnhYb1pudGc2?=
 =?utf-8?B?bUJtUWZDRk5XNUdobkVHZFJzY3Q1RUFwNVVDcTI0a1hobDdKN2Nscy90U1N2?=
 =?utf-8?B?L1RMUTExQkMwVTlUQ00zYWI5c0VTc2JPNHhuQ3NHQkU3MnN4MUo4SlR1M0d5?=
 =?utf-8?B?L2YxbWRBMGRBZE9YTDJwdjY5NFB4dHZrT3RyUkp0Z2xmWHZGRmV3YmF3WWM1?=
 =?utf-8?B?VDNWa0Z5UVMvci9weUpoWXQ1QllOQXFXYkRiUDlWYW1DSFB5QzJUeXFwQkp5?=
 =?utf-8?B?ZU1xV2I3OUIybk1zeWpRQUgvTW1jSmZaTGNRNERsZk96R242TE9GZXZJOEJE?=
 =?utf-8?B?eWo0cW9rNFVILzRPcE9obmw0OEszcFA0aW9kTXZDTE5yOCsvcDZOdi8vYndw?=
 =?utf-8?B?Y3dsNE5XRWtuZjdjT2gvMzFnKzRvSlNMWitIZHpEbFg2WTl1ejJ5QThwTjdF?=
 =?utf-8?B?NHk4TFdLTGV3eWNpQ1FmUDIxTWNYRmZkMmxLL01Vc2hpL2Rxa1o3WXR4d3Na?=
 =?utf-8?B?ZVgwcFBSZytHRlhET2E2REdPaER6MmV2dDB1WVVhMW9YQTdvQlZVajNtRjVH?=
 =?utf-8?B?QU04TnZIdTRFUnVzSmY2KzI1YU13akI4TjAxRE5vRmZEcnR1QnBNTUg3Y3l2?=
 =?utf-8?B?YXZOZkxlcGp4aWN0YnJvSU5HSG1DbEdjRzNwTnF0Tm9TQ0N5dXVwcTlkY0g4?=
 =?utf-8?B?SFJqZEJuY28wbVB2c1ZsZTVmVjFhK25mVmd6a3hKbVZibS9oRC9XdFhXVEh0?=
 =?utf-8?B?Y2o3cmtMS2gydXY3b2Myb2dvYXFjaXVOSkQwNmorcU8vUkhqY1ZnSUJsZUxv?=
 =?utf-8?B?aEU4NDd6WUJ5OXBoZWtRQTA1clZHcFFOVmQvUGZtMThUeFBJcDY4eGdTbWJH?=
 =?utf-8?B?eGQ2VStnZ2RvZ1JVQlp1bzZsQnBhNndkenJZMUN4eVVjb25xRXl1cFZPaWI5?=
 =?utf-8?B?RnlLczNma25CaHR3S0dYUUJ4WVd0ei9WR2ZrZG5FV0cvY3c5U3NIelVaTmNj?=
 =?utf-8?B?dXl2WTBNeXVxZ1kwVW1xWXdJUTQra0RhRHk5bk4vQ2V1U1hMWnozNk9BVjVn?=
 =?utf-8?B?WkhnZTJ4eVNVc0gwRHc0WVdOaEowR3lhK3NVVTJKZlJnMitNNXMwNHNQTktG?=
 =?utf-8?B?Uit6c3BkSWUzb0c1OEZHWXUwWUdxSUxpZDV5SjB3aEF5TFd6REdlQWZXZXQ2?=
 =?utf-8?B?eDE2T0JFRWp1QjZHM2NHL2xqcXhKTmZBS1ZlRmhzSmFqMFp1Vi80dzZPVHZO?=
 =?utf-8?B?eG1WUlRrczNlclptQnVybng2M21wZ3NiVFZaT0pEQTVoYXBTeFBRaGJzVlg2?=
 =?utf-8?B?ZjdSenBKWURVV1FiWkJ0SVNML0h3VmdEZmpKYXZjZnZwR0sycWNGY1NYZFk4?=
 =?utf-8?B?MjUvQkQ3bWdId1pqTHJocjBhSThhcXZpSldGUEdPSDhEaVJwb1lXYzRsbnJV?=
 =?utf-8?B?TUMyNjdEeHdJcVgxUVFoQ1R5UmxIUVI3Z0RaNkRacVhJSEJIZUhNVHMwb0pI?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B373A3F54510B4685CCB9B04823CA5A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7RznJDN5vd9v8K8s8Wds9AidcYNlZAS+DkymRtnq28cE+Rq3e1z6m+8CQuruhDD5xoKeOaa+TtOx2ipqUuv+1FvLsy2ngWh6//+3vtrjj6pUBmazy4rLa8KpSdUYxJi2n7LuM9a4i7ME8c58bLPpPm9VfoI9ua4NyzzdsiUsKEITPs0Q0BDh2fGh1ZYsIlhusBg2oanPLpA/c0MV0BlDzS7zLSehC/EZHVr3Da0HBNxE4AD61pD9ChXNSibx6vNGIjuCUsDTAYE7WJZ7gXg1C2Di4RWqnl/qtot+nP3jPLTnhALV/31PF8Ne+TS0dWA1/BIa3UcaIbqqIZzH7ILmclfmCgDyL7eHzkSoq+RQFzowF7rTEgnHB9QiVcAx8Q+qgNmFqJkapiu9WCcltWMC0xrXH4LTp6asD5pxNCKpGzyFWaTKXp1QyJFNa0uU0ITDLukIdN4+VPyN2/VK9gH4z+3yhXf70k0jwMct04QyFipA/pqDDQpDe7NiQVu1UDbyKeUHDKsSQvwQlBSL6Y1ITlyz/haNIq5uvRqKlL3iT9rBw7/o30HUW+g/Y1LG2ViOPQwhtxnQzAGEj/1CYTuWVtGv25nczr/aZk7VDdDLYAasyy1jghBoS1Obf9GEDG4h
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee64f97-c973-484b-91ac-08dd562f9947
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 06:34:19.1111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hy2DP+QBoF50FWFX3RLTJNKNhcmGLg/f112wuZKSr7rVDajPaKoqi8bgjxJKr99ii/AbXrlYmaTwpa9uIVHRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6337
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI1LzAyLzIwMjUgMjI6NDgsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUdWUsIEZlYiAy
NSwgMjAyNSBhdCAwNjozNzoyMUFNICswMDAwLCBaaGlqaWFuIExpIChGdWppdHN1KSB3cm90ZToN
Cj4+DQo+Pg0KPj4gT24gMjUvMDIvMjAyNSAwMzo1OCwgUGV0ZXIgWHUgd3JvdGU6DQo+Pj4gT24g
RnJpLCBGZWIgMjEsIDIwMjUgYXQgMDI6MzY6MDlQTSArMDgwMCwgTGkgWmhpamlhbiB3cm90ZToN
Cj4+Pj4gU2ltaWxhciB0byBtaWdyYXRpb25fY2hhbm5lbHNfYW5kX3RyYW5zcG9ydF9jb21wYXRp
YmxlKCksIGludHJvZHVjZSBhDQo+Pj4+IG5ldyBoZWxwZXIgbWlncmF0aW9uX2NhcGFiaWxpdGll
c19hbmRfdHJhbnNwb3J0X2NvbXBhdGlibGUoKSB0byBjaGVjayBpZg0KPj4+PiB0aGUgY2FwYWJp
bGl0ZXMgaXMgY29tcGF0aWJsZSB3aXRoIHRoZSB0cmFuc3BvcnQuDQo+Pj4+DQo+Pj4+IEN1cnJl
bnRseSwgb25seSBtb3ZlIHRoZSBjYXBhYmlsaXRpZXMgdnMgUkRNQSB0cmFuc3BvcnQgdG8gdGhp
cw0KPj4+PiBmdW5jdGlvbi4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+DQo+Pj4gWWVhaCB0aGlzIGlzIGV2ZW4gYmV0dGVy
LCB0aGFua3MuDQo+Pj4NCj4+PiBSZXZpZXdlZC1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQu
Y29tPg0KPj4NCj4+IEhpIFBldGVyLA0KPj4NCj4+IFRoaW5raW5nIG9uZSBzdGVwIGZ1cnRoZXIs
IHRoaXMgcGF0Y2ggbG9va3MgcHJvbWlzaW5nIGFuZCBjYW4gY2hlY2sNCj4+IG1vc3Qgc2l0dWF0
aW9ucy4gSG93ZXZlciwgb24gdGhlIGRlc3RpbmF0aW9uIHNpZGUsIGlmIHRoZSB1c2VyIGZpcnN0
DQo+PiBzcGVjaWZpZXMgJy1pbmNvbWluZycgKHdpdGggdGhlIHN0YXJ0dXAgcGFyYW1ldGVyIC1p
bmNvbWluZyB4eHggb3INCj4+IG1pZ3JhdGVfaW5jb21pbmcgeHh4KSBhbmQgdGhlbiAnbWlncmF0
ZV9zZXRfY2FwYWJpbGl0eSB4eHggb24nLA0KPj4gdGhlIGZ1bmN0aW9uIG1pZ3JhdGlvbl9jYXBh
YmlsaXRpZXNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKCkgd2lsbA0KPj4gbm90IGJlIGNhbGxl
ZCB0byBjaGVjayBjb21wYXRpYmlsaXR5LCB3aGljaCBtaWdodCBsZWFkIHRvIG1pZ3JhdGlvbiBm
YWlsdXJlLg0KPj4NCj4+IFRvIGFkZHJlc3MgdGhpcywgd2l0aG91dCBpbnRyb2R1Y2luZyBhIG5l
dyBtZW1iZXIgJ3RyYW5zcG9ydCcgaW50byB0aGUgTWlncmF0aW9uU3RhdGUNCj4+IHN0cnVjdHVy
ZSwgdGhlIGNvZGUgbWlnaHQgbmVlZCB0byBiZSBhZGp1c3RlZCB0byB0aGlzOg0KPj4NCj4+IFRo
ZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHdlIG5lZWQgdG8gY29uc2lkZXIgaXQgbm93KGluIHRoaXMg
cGF0Y2ggc2V0KT8NCj4gDQo+IFdlIGNhbiBkbyB0aGF0IGluIG9uZSBwYXRjaC4NCg0KT2theSwg
cGxlYXNlIGlnbm9yZSB0aGUgVjMgYW5kIHRha2UgYW5vdGhlciBsb29rIGF0IHRoZSBWNCB3aGlj
aCBpbnRlZ3JhdGVkIHlvdXINCmJlbG93IHN1Z2dlc3Rpb24uDQoNCg0KVGhhbmtzDQoNCj4gDQo+
Pg0KPj4gICAgc3RhdGljIGJvb2wgbWlncmF0aW9uX3RyYW5zcG9ydF9jb21wYXRpYmxlKE1pZ3Jh
dGlvbkFkZHJlc3MgKmFkZHIsIEVycm9yICoqZXJycCkNCj4+ICAgIHsNCj4+ICAgICAgICByZXR1
cm4gbWlncmF0aW9uX2NoYW5uZWxzX2FuZF90cmFuc3BvcnRfY29tcGF0aWJsZShhZGRyLCBlcnJw
KSAmJg0KPj4gLSAgICAgICAgICAgbWlncmF0aW9uX2NhcGFiaWxpdGllc19hbmRfdHJhbnNwb3J0
X2NvbXBhdGlibGUoYWRkciwgZXJycCk7DQo+PiArICAgICAgICAgICBtaWdyYXRpb25fY2FwYWJp
bGl0aWVzX2FuZF90cmFuc3BvcnRfY29tcGF0aWJsZShhZGRyLT50cmFuc3BvcnQsDQo+PiArICAg
ICAgICAgICAgICAgbWlncmF0ZV9nZXRfY3VycmVudCgpLT5jYXBhYmlsaXRpZXMsIGVycnApOw0K
PiANCj4gSGVyZSBJTUhPIHdlIGNvdWxkIG1ha2UgbWlncmF0aW9uX2NhcGFiaWxpdGllc19hbmRf
dHJhbnNwb3J0X2NvbXBhdGlibGUoKQ0KPiB0YWtpbmcgYWRkcitlcnJwIGxpa2UgYmVmb3JlLCB0
aGVuLi4NCj4gDQo+PiAgICB9DQo+Pg0KPj4gICAgc3RhdGljIGdpbnQgcGFnZV9yZXF1ZXN0X2Fk
ZHJfY21wKGdjb25zdHBvaW50ZXIgYXAsIGdjb25zdHBvaW50ZXIgYnApDQo+PiBkaWZmIC0tZ2l0
IGEvbWlncmF0aW9uL29wdGlvbnMuYyBiL21pZ3JhdGlvbi9vcHRpb25zLmMNCj4+IGluZGV4IGJi
MjU5ZDE5MmE5Li41OWYwZWQ1YjUyOCAxMDA2NDQNCj4+IC0tLSBhL21pZ3JhdGlvbi9vcHRpb25z
LmMNCj4+ICsrKyBiL21pZ3JhdGlvbi9vcHRpb25zLmMNCj4+IEBAIC00MzksNiArNDM5LDI5IEBA
IHN0YXRpYyBib29sIG1pZ3JhdGVfaW5jb21pbmdfc3RhcnRlZCh2b2lkKQ0KPj4gICAgICAgIHJl
dHVybiAhIW1pZ3JhdGlvbl9pbmNvbWluZ19nZXRfY3VycmVudCgpLT50cmFuc3BvcnRfZGF0YTsN
Cj4+ICAgIH0NCj4+ICAgIA0KPj4gK2Jvb2wNCj4+ICttaWdyYXRpb25fY2FwYWJpbGl0aWVzX2Fu
ZF90cmFuc3BvcnRfY29tcGF0aWJsZShNaWdyYXRpb25BZGRyZXNzVHlwZSB0cmFuc3BvcnQsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCAq
bmV3X2NhcHMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gK3sNCj4gDQo+IC4uICBoZXJlIGZldGNoIGdsb2JhbCBj
YXBhYmlsaXR5IGxpc3QgYW5kIGZlZWQgaXQuDQo+IA0KPj4gKyAgICBpZiAodHJhbnNwb3J0ID09
IE1JR1JBVElPTl9BRERSRVNTX1RZUEVfUkRNQSkgew0KPiANCj4gWzFdDQo+IA0KPj4gKyAgICAg
ICAgaWYgKG5ld19jYXBzW01JR1JBVElPTl9DQVBBQklMSVRZX1hCWlJMRV0pIHsNCj4+ICsgICAg
ICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJSRE1BIGFuZCBYQlpSTEUgY2FuJ3QgYmUgdXNlZCB0
b2dldGhlciIpOw0KPj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgICAgIH0N
Cj4+ICsgICAgICAgIGlmIChuZXdfY2Fwc1tNSUdSQVRJT05fQ0FQQUJJTElUWV9NVUxUSUZEXSkg
ew0KPj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlJETUEgYW5kIG11bHRpZmQgY2Fu
J3QgYmUgdXNlZCB0b2dldGhlciIpOw0KPj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+
ICsgICAgICAgIH0NCj4+ICsgICAgICAgIGlmIChuZXdfY2Fwc1tNSUdSQVRJT05fQ0FQQUJJTElU
WV9QT1NUQ09QWV9SQU1dKSB7DQo+PiArICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiUkRN
QSBhbmQgcG9zdGNvcHktcmFtIGNhbid0IGJlIHVzZWQgdG9nZXRoZXIiKTsNCj4+ICsgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgICAgICB9DQo+IA0KPiBXZSBjb3VsZCBpbnRyb2R1
Y2UgbWlncmF0aW9uX3JkbWFfY2Fwc19jaGVjaygmY2FwcywgZXJycCkgZm9yIHRoaXMgY2h1bmsN
Cj4gKHNpbmNlIFsxXSksIHRoZW4uLi4NCj4gDQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgcmV0
dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0KPj4gICAgLyoqDQo+PiAgICAgKiBAbWlncmF0aW9uX2Nh
cHNfY2hlY2sgLSBjaGVjayBjYXBhYmlsaXR5IGNvbXBhdGliaWxpdHkNCj4+ICAgICAqDQo+PiBA
QCAtNjAyLDYgKzYyNSwxNSBAQCBib29sIG1pZ3JhdGVfY2Fwc19jaGVjayhib29sICpvbGRfY2Fw
cywgYm9vbCAqbmV3X2NhcHMsIEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICAgfQ0KPj4gICAg
ICAgIH0NCj4+ICAgIA0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBJbiBkZXN0aW5hdGlvbiBzaWRl
LCBjaGVjayB0aGUgY2FzZXMgdGhhdCBjYXBhYmlsaXR5IGlzIGJlaW5nIHNldA0KPj4gKyAgICAg
KiBhZnRlciBpbmNvbWluZyB0aHJlYWQgaGFzIHN0YXJ0ZWQuDQo+PiArICAgICovDQo+PiArICAg
IGlmIChtaWdyYXRlX3JkbWEoKSAmJg0KPj4gKyAgICAgICAgIW1pZ3JhdGlvbl9jYXBhYmlsaXRp
ZXNfYW5kX3RyYW5zcG9ydF9jb21wYXRpYmxlKA0KPj4gKyAgICAgICAgICAgIE1JR1JBVElPTl9B
RERSRVNTX1RZUEVfUkRNQSwgbmV3X2NhcHMsIGVycnApKSB7DQo+PiArICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+PiArICAgIH0NCj4gDQo+IC4uLiB1c2UgbWlncmF0aW9uX3JkbWFfY2Fwc19jaGVj
aygpIGhlcmUsIG1pZ2h0IGJlIHNsaWdodGx5IG1vcmUgcmVhZGFibGU6DQo+IA0KPiAgICBpZiAo
bWlncmF0ZV9yZG1hKCkgJiYgIW1pZ3JhdGlvbl9yZG1hX2NhcHNfY2hlY2sobmV3X2NhcHMsIGVy
cnApKSB7DQo+ICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgIH0NCj4gDQo+PiAgICAgICAgcmV0
dXJuIHRydWU7DQo+PiAgICB9DQo+PiAgICANCj4+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vb3B0
aW9ucy5oIGIvbWlncmF0aW9uL29wdGlvbnMuaA0KPj4gaW5kZXggNzYyYmU0ZTY0MWEuLmNhNmE0
MGU3NTQ1IDEwMDY0NA0KPj4gLS0tIGEvbWlncmF0aW9uL29wdGlvbnMuaA0KPj4gKysrIGIvbWln
cmF0aW9uL29wdGlvbnMuaA0KPj4gQEAgLTU4LDYgKzU4LDkgQEAgYm9vbCBtaWdyYXRlX3Rscyh2
b2lkKTsNCj4+ICAgIC8qIGNhcGFiaWxpdGllcyBoZWxwZXJzICovDQo+PiAgICANCj4+ICAgIGJv
b2wgbWlncmF0ZV9jYXBzX2NoZWNrKGJvb2wgKm9sZF9jYXBzLCBib29sICpuZXdfY2FwcywgRXJy
b3IgKiplcnJwKTsNCj4+ICtib29sDQo+PiArbWlncmF0aW9uX2NhcGFiaWxpdGllc19hbmRfdHJh
bnNwb3J0X2NvbXBhdGlibGUoTWlncmF0aW9uQWRkcmVzc1R5cGUgdHJhbnNwb3J0LA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgKm5ld19j
YXBzLCBFcnJvciAqKmVycnApOw0KPj4NCj4+Pg0KPiA=

