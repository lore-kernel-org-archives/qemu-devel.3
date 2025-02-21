Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C37DC021B2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 01:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlHuH-0003gP-5S; Thu, 20 Feb 2025 20:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlHuE-0003ZM-KI
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 20:32:42 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tlHuB-0001uI-Kj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 20:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1740101560; x=1771637560;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=nmFKli6QsvwuYqbYFoMTHHfUHXLzHhVk1RBctsrbLhw=;
 b=zNHCDm9tms8K/X53gESf7XEunKkEsbMtOXyY+wHhE/xF8VhvxFxMy0Ga
 i35GF+42b7SKKVYSkks2T0r2wezMt8u0mr+0LQixhTHjYG1hZ6xcAKnQ3
 eJzQlD6yrWWBemMTfZPWJQx86hTZyFBgNLq4tDEpfOERPFu3PnOpYQWRI
 sXSK4LZ44cektf8nOPxaH/Es7RNDjXixq/73RJbase+jIn4jwXT7bBJBi
 dXWLPRayeiWdz69wXoj88LNfbPqCrHZNUHWHBEZpdr9lKVz3yvpOQaXEW
 ORaEPFwfr9lERyAB/osLSpX7+q14wIEZ3f5+dYkPkD8BmNuWxb+S6YLjJ w==;
X-CSE-ConnectionGUID: r3mjb0tPSm6qifmhD9s+PQ==
X-CSE-MsgGUID: muC35j9HRIG01FZ77d/hig==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="147192652"
X-IronPort-AV: E=Sophos;i="6.13,303,1732546800"; d="scan'208";a="147192652"
Received: from mail-japanwestazlp17011029.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.93.130.29])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 10:32:35 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmASwJqRlHmWmzcbcE5NrI1njpBP6H+gKPZoX9moW2Se21UO4VzWqk9YDPUw8hAMzQHss4SiEr8mfjGIr9LJfusNOkF9ck44E/1zoIoeqLK0xXPKeOi9MEHYeI8eZ327/Cunqo9hRouqX64Sp3yNA3WTr51YXdTVTHKCeN7V4caN633YD6ohMvVePj/baV+sFB2GTfzTteR1BPRtyLQqbS43Vb7VvbD27JT+ZhJilKO9GsDql3G2e0G9C94VpYkM37v4BgHl+fPcUB1/Ujh76O8YpAm3WlnEdl0CfNZfQIlmrnGV3VNUadNcj+kYYhzQR9gV50kA4iHdcuLM4w7j5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmFKli6QsvwuYqbYFoMTHHfUHXLzHhVk1RBctsrbLhw=;
 b=nu4VJKugpxqjeUiFdUTmuk07tJlMynty97iherEIsKcNl2zx0Jpx5s1Iv34EMBm+VRoVBYiSFcw+Ea2rRNCH7by6aqQIluoSFunySMBcg28RyoZmHb4safurIk25hR0ItLM7ASKhuQukwETi3j7n5TYN4vW0ENS4j0W7xXx7ROQ1jRZikUFlHlyehDlkmUkYo+zlLn8VOMH9Vximg2DW6i5raBSQ7q6pM9B3l4JBlQE7fxvEK33novuZolytMoX7AudvCRrNtxR7Bd2HbgHAshT5FHALYGPH0KDPV5B/1hHdoQocqiio8JSi/etEBSeAhZLBP3/at/d1ec1Z3LDCJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY4PR01MB15587.jpnprd01.prod.outlook.com (2603:1096:405:28c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 01:32:31 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 01:32:31 +0000
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Thread-Topic: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Thread-Index: AQHbgdin9ucJjH+lxkGFy3eIGQ0wErNNjYMAgAAbGgCAAHNIAIAAeVoAgAAJHYCAAA5KAIABRqcAgABougCAAKE3AA==
Date: Fri, 21 Feb 2025 01:32:30 +0000
Message-ID: <436f91aa-e0b4-4c14-914a-5ae63676b59e@fujitsu.com>
References: <Z7Xmkq0nTmZ8TRXU@x1.local>
 <20250220094038.1382541-1-lizhijian@fujitsu.com> <Z7dQcBHIV0q6l4S6@x1.local>
In-Reply-To: <Z7dQcBHIV0q6l4S6@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY4PR01MB15587:EE_
x-ms-office365-filtering-correlation-id: 1b690bf6-c72d-411e-6eb9-08dd52179bfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?bzlPY28rWkw0WVVnOThvbmJzQ2doWmFoQUltbVNlazVvLzJseFk2ck4wZXpv?=
 =?utf-8?B?bkcxSVY1djR3SHkzSXFHZ2JIQkdITWNMQWxwdXFuYlVjdmk0bkMxQkFVbFl1?=
 =?utf-8?B?aCs1S2thQTJJbkpXRlpzUnFOVjFlbGk4T2doYTl5bW4rSzExR1JxNnRSdDlh?=
 =?utf-8?B?K1NzaWUwY3dyV21kb1hqY1RacWViTzRZUHp5dTI5d0VjWElQV01KSUlLQ01n?=
 =?utf-8?B?clRhS0NjRXBJVnFBeEVDN3o2bzdseUh5d1BSV1NXVlV4cHRDNTlaNWExd1l0?=
 =?utf-8?B?RGM5SU94aisyLzVHUGEwOHNKUFJaYTNpUyszVHdsRnZ0WnE3bkh3RytqdE5T?=
 =?utf-8?B?T3AwRHZQUGRZdEh1dVF0Yi90MEI2RXFIdkJiODB3U0xuMmpuQ2lGcHJ1aDkw?=
 =?utf-8?B?dlJpL0VLaEFCOS93Slg0TFVCTmkzN2dOZHI2b2VQR3lpaUpURW1vSnMvTkRO?=
 =?utf-8?B?Ymp5bDRwb3VsT1lmY1o0Sk1kaHd1N3NnZTZYZnZmUWpEdHM5amFXSlVtdWJ0?=
 =?utf-8?B?ZExZS1FhUEg0cnc2OUZtWitlallVR0lpMU1Ldm5PT0tOK2J0M1FLRm8wdmZT?=
 =?utf-8?B?WGIxTkNtZkRtaXkwRUMvbWdzS1hzaVltbGt3UmhXeTBlSFlsb29UUW9yeFNN?=
 =?utf-8?B?bGQ4MXU3cGlhUDRMOTdIK1lNU25VQXJxQ1hJV2NKM0VXUGR3ejZLTG5rOHpy?=
 =?utf-8?B?MWx5SC9qYnRaTk1JSEZrOHdOdVRDMVBYNEhlTkZZVW80RFFUQ29QSlNubHc3?=
 =?utf-8?B?TEY5YWpNRVUvUzEyMnVsQjRsTlV5eDJJNDEvczUxM3JYNW9LUWszdzZYVGVF?=
 =?utf-8?B?cUVneFFJNXRNV0ZUWFZiUUswWXk2eEY0TTRpUnorZWVsZDdEZVdlaTJTUkJq?=
 =?utf-8?B?MGRxWlZCb1pUaXlsYWZ5b0t2VTJnZGcvT211ekhsYXVwT05OOTlrVjBac3dp?=
 =?utf-8?B?RFZtMFZEQmNnTFRPZnljYVkrYXY1TEJTS0pHYnYzQ0xtM3ZCSXdBdkJaTERX?=
 =?utf-8?B?RFVIZ2hDYVNkU3hqbFVoQjMyNERYRGwyZjlpSWtFSGNGcE52b2JJazIyRWx6?=
 =?utf-8?B?bFBCRUwyM3JUSXJNd0Y2RitRYnF4eUZqbFpQNnB4bHpwb0ZXY0lEN2xCeUpI?=
 =?utf-8?B?dFo0bFFrdW5RRExtUHFRZ2o2cE5OUHhva0dId0t6SzR1Mno0UTVXQWVFWWpl?=
 =?utf-8?B?d25ncUhOU090OUhVZnlYa1pIVVdtSjZ0RVUwZ01LZ3JVUzI0Y05JTUdaU2Rp?=
 =?utf-8?B?bysrcUNXekhOWnNrL1RuUVRwWThnenpDTzhmWlpZakVYalo4MDNNZkhhcFdV?=
 =?utf-8?B?a1crTlZxZG9PcStMeXN2aVBKQWpHTlY2NCtraDBzeURiNU80NmxzZWdlZ2Uz?=
 =?utf-8?B?bCtvL04vakNnb2pxdzVmSis1UjFpejRERTN4Qy9KMkZZQ29JT21GRE9WUDBp?=
 =?utf-8?B?cmlUUUM4U2gxSzFGWnMydmFrRi9kYUErQ0xod0w4cFBaOThGTzVPaVE2M0Z6?=
 =?utf-8?B?dkcxWm1ZTnhBQndEeE1HcFl2YXdBVGJjbjRXclBJa2xKT3pqR1pZcVB3ZldF?=
 =?utf-8?B?bTdLdU5UVyt6OGFFZGMyK25lODVEUVllU3BsNTdsMHBVT0FxbkNkUTFlMkY2?=
 =?utf-8?B?dmxrbzFDQ3IxWDVjZEdMU0ZZbTZSM09Yam50ZHliVVU5YXBZcndxd3prREIv?=
 =?utf-8?B?WGFsNzk2U0ppOVgyWnNNZmhvdjc1S3JrR0E0TE14ZnlpSk1ld01oSm0vVHM0?=
 =?utf-8?B?UkxJNEw4VnFUVElDVTRVenZPN1RibDFlVUIwSHpQR1V6ekhLeUs0L096Z0Iz?=
 =?utf-8?B?Z1FQTWhaME5HZzB4TkdRdVBnTDE3dUtZdTFLKzNEaWZJVWhnMGM1OVBuVkNP?=
 =?utf-8?B?bW5rdWFvdTlWRUJWbXppZkJGVFM2emNSNEVZbW5vZm9GZ2c5QUQ5S01QUkpD?=
 =?utf-8?B?SkQ5Nkp4WCtzeVdiejUyRW5ScDA0YnZVL2pCMmRyU0hTNWVVUXFocHlPd24z?=
 =?utf-8?B?bnRRYnNXNjF3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjVjM1YyRVBZSUFLRlBnYW41OFJvYi83UVNONS9hWUZrVzFRMHpYanFpUmJT?=
 =?utf-8?B?RklEWEpMckUyOEhZZHU1dmV2MHBOeWhoNkxOWU9oalM5NEZkMVhDTWVhOWxj?=
 =?utf-8?B?bEdYSjFaMUVBUjdIMndEUTZ1WVFvQmduL25Oa1NGcCt6UlpLRXo2bTA5clRH?=
 =?utf-8?B?aHpHWE1DciswL0tuMkxsR2sxLzNHQzBJUVc2RGZuQTAwdmJDaEp1TnhqK2dG?=
 =?utf-8?B?VGhaTXNOTUJtb0o4YXZIeWgxZWV0UGd4ZXJrb1kvMU9Qeld4TEZSWFpKYkYz?=
 =?utf-8?B?Mk1YWTluRTJKTnpDQWsyYTFhM2hmdjEvblIrV2l3UWZ5a3I4dzMzblM0Y3RC?=
 =?utf-8?B?d3Bib3dsQzJuY1VzZnhSZ010ZERUZHdkN1hqWWZCbVVlRHJRQjBQd2tENThM?=
 =?utf-8?B?c2tXQUpwN0pKZFZDRDl6NEVHVGdXbVZCLzg1K1ZrdFFOcStpVmljRTVVRWJo?=
 =?utf-8?B?eVdJeW1IYVBXNWhaVG9zU3EzY1FHbVRCOG9RUUxHSDhuU2FuNGp5Qks1UEtE?=
 =?utf-8?B?eVR4NGtUNlVETDVJNlcxV29KY1dTSFE4dW9qRWIveC9rOTREU1R6czVuNVRx?=
 =?utf-8?B?THVIOEhjSVpIdy9GeDNWakllZkdCemNiTVNJY2VnMkl3Y3pSU0RaU2RnM1dB?=
 =?utf-8?B?YmlDbFkvclBXc3doMkhhOUEwSzFnUDhKaEZTSnZac2RGRDVDWW9XY2pWdHB2?=
 =?utf-8?B?UW1ocjdXSWRsbXhpTkxEVVZOakNNa3JoOXBkQWcvSWx3Uk5yMmVCQW1LMUhF?=
 =?utf-8?B?NEE0NU1ZMHM5TWlMS0ZuNnFxRDlkdUpLTGtVQkxMSlQ4eFJ1VjM1ZGZ4SXFn?=
 =?utf-8?B?QTZhaXBBNnhoZzkrVjhkTlhNODJ2cGwzcExoQmkwT0FDeFh1aW1qM2tsV01l?=
 =?utf-8?B?NFlibjFCL1MwQUlzQlpUT3gvdktJU0RWaWE1Y25xZXlqWTZhazlTR3RHczR4?=
 =?utf-8?B?Q3cya1l5dG84QXNTMlVTVlM3T1gyem5pbGxyVmZaNEh2bC9kNmlkcFlDSjJn?=
 =?utf-8?B?Q1BESTNaa1lEVVMrODVPNFFjTFBmNWRkWUNOdW9PSEFKNy9wS0M0K1ZaRENK?=
 =?utf-8?B?aWs2clYxcEZOQmJDOU1sZndvbXBSNTFpMmlIZUxWd3RuZ2pVcDhmMHVuaDB6?=
 =?utf-8?B?QS82WHU0ZTY0Mm85Qnp0Si93ZGxWaUJVVmVWOEtPM1hjT1hsN0lWaWVHSlVK?=
 =?utf-8?B?dnNha3N1N0RBZDloMWNycXh0RU95cTNRaWt3RG9FTTBTQXBwVzlIVnFPVllE?=
 =?utf-8?B?c085Z1lUQ3k4MVpaK0Q1T2hHR0orVXo4MjJRZ21sa0J3UjZaSzJ2MkxGYTls?=
 =?utf-8?B?Z09nYVEvZ1pyMFhrdWFNZ1RxWEFxTWQrTEhiTFlCZW1aZGY3U3NMejkzdWpw?=
 =?utf-8?B?aEQ4dDZBYzMrQ1ErVlhINm95ZHBKZk1ZTGN1R3l2RXJxaGM4T09zZHZRVGNQ?=
 =?utf-8?B?b0pyWjlUNmpVQ3ZXWW1Yb25KRVJESXNRSnIveUVpTHZUQnFSakU0Z3pobEpk?=
 =?utf-8?B?TzE2bit2aktldWJCa3ptUnJ0a00xRjVtc3dQRjRXU0cxc2lZU2Q3ZFJDYVhj?=
 =?utf-8?B?VVVtbUhmdDlsRE5RTDVmcE1mRmhQRVV6Yk5TNUlTMEtDTWVjdXNwb0JVcHht?=
 =?utf-8?B?Nks2VjNiUlpRN2tWdjFTMFI4dE5LdmhOUGwvZXpBc1AyMEdNVWhadi92bDI3?=
 =?utf-8?B?R0FxbC8vSU1qTGZScyt2Mk5obStycjlwSE9zeUNlclhaWDVpbXNQWk91blR0?=
 =?utf-8?B?UVZ6TUlTUVd0bnliOGJBSS9aaFZ3RGNqd0I4MUoxRXZGTUwyQVNsWVFjQXNC?=
 =?utf-8?B?cEJuS2w3TjR2M2ZEZDkzVFpiM3A0MEo4emoyNGF2YVQ5Smsvc24rSDZ5NUpD?=
 =?utf-8?B?NEx4S2JYNk9wSzFtbytFeDhkczFneXQ3cjk0MW1DRDNUZ1d2TTl0MDg0bFZM?=
 =?utf-8?B?cXpaSFhzN3AxYjZFM1JpRFU3dXlaNk9NcXc5dEJSM3ZyWDZ1emZHaVpuNmR6?=
 =?utf-8?B?Z3NueWErcHgxUGJSNVBwdUxkMzllNXplZk54OTY2dW1QWGpWbTNLRHhpQXBW?=
 =?utf-8?B?TWNpQ2dpcDlWNXhEaEk3Z0tXSTJ6WWFWdGM4b1MydkdxRll6TXVoN2MyN2E2?=
 =?utf-8?B?TFNSMmxpQXE0UW9PSzBUN0dBczFqYWxUdGtvRFEwT3RVTHM5UmlReVpQOE02?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C4FEF1800D2EB47876F7C9B69D7ABDC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: U3QK6QNdVEWfr+Nl84A42/opadpOe/T204RL2ARsF4qC7PXYnAoXFUhzFAmUIDWAJRfMrAK+y0J+IWzCtoFYx55JdOWidkra5Eu7RyKwx8hCuPEy7oASGjx1jPEmx2wm4ue4xcQ1LqEfdAR/FOr/xSMvNP3X9UVnwWtigJ6SwiqtcLDdnj1CUl/w+wa+V0Q0fDq9xqPdy0ECnPfUqKW5mBRxD/yuFGh04NaoZfUKbJc0TiXiXzrQC6hqTWIqBRc+4vnGNgeGqJ/VqaopzWvSLTzcBR+o+KUkiIAz9PuIlIztsFb5ZUYjbmu0G/4b0OlBFzYsB32XvelNahO/iN8R8d3Z/ceCM5laAGk8BO3LqfR6p5IfdsmfhTa0GVuFL70BWKHiQlIVf3bXJTOB7ihmZAL2K++jza2RCCxtpog3nfbe9BUdX6mFH4U7TddbwsPe2h9G6fANgwonpuIbv5g1fB43Bpx5wwN53nQX/hofbqV13GuaV5jWxC+q0Lkwe+oqoI/UKeHUZxrrcEvaCWoBaJ/x/+Ja8mECeOkWvHSGVq+eLvoZPFod0S81cko2djzChdWq9iafzXwe6HhpresO0JR1xuc5JIn+Du9/RpFJ2ax9D7+2Dm01TH6Sy7+s4T49
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b690bf6-c72d-411e-6eb9-08dd52179bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:32:31.0712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10mktzukYCF7wsRNA2+GMchxdgUlnfy/Ps4Yf2rgTP1vAmueuDwPWVguSvDyiQXsjLynXL7GyXxigC5PJOfRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15587
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

DQoNCk9uIDIwLzAyLzIwMjUgMjM6NTUsIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAy
MCwgMjAyNSBhdCAwNTo0MDozOFBNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gT24gMTkv
MDIvMjAyNSAyMjoxMSwgUGV0ZXIgWHUgd3JvdGU6DQo+Pj4+Pj4+IHRoZW4NCj4+Pj4+Pj4gaW4g
dGhlIHRlc3QgaXQgdHJpZXMgdG8gZGV0ZWN0IHJkbWEgbGluayBhbmQgZmV0Y2ggdGhlIGlwIG9u
bHkNCj4+Pj4+PiBJdCBzaG91bGQgd29yayB3aXRob3V0IHJvb3QgcGVybWlzc2lvbiBpZiB3ZSBq
dXN0KmRldGVjdCogIGFuZCpmZXRjaCBpcCouDQo+Pj4+Pj4NCj4+Pj4+PiBEbyB5b3UgYWxzbyBt
ZWFuIHdlIGNhbiBzcGxpdCBuZXctcmRtYS1saW5rLnNoIHRvIDIgc2VwYXJhdGUgc2NyaXB0cw0K
Pj4+Pj4+IC0gYWRkLXJkbWEtbGluay5zaCAjIG9wdGlvbmFsbHksIGV4ZWN1dGUgYnkgdXNlciBi
ZWZvcmUgdGhlIHRlc3QgKHJlcXVpcmUgcm9vdCBwZXJtaXNzaW9uKQ0KPj4+Pj4+IC0gZGV0ZWN0
LWZldGNoLXJkbWEuc2ggIyBleGVjdXRlIGZyb20gdGhlIG1pZ3JhdGlvbi10ZXN0DQo+Pj4+PiBI
bW0gaW5kZWVkIHdlIHN0aWxsIG5lZWQgYSBzY3JpcHQgdG8gc2NhbiBvdmVyIGFsbCB0aGUgcG9y
dHMuLg0KPj4+Pj4NCj4+Pj4+IElmIGhhdmluZyAtLXJkbWEgaXMgYSBnb29kIGlkZWEsIG1heWJl
IHdlIGNhbiBmdXJ0aGVyIG1ha2UgaXQgYSBwYXJhbWV0ZXINCj4+Pj4+IHRvIC0tcmRtYT8NCj4+
Pj4+DQo+Pj4+PiAgICAgJCBtaWdyYXRpb24tdGVzdCAtLXJkbWEgJFJETUFfSVANCj4+Pj4+DQo+
Pj4+PiBPcjoNCj4+Pj4+DQo+Pj4+PiAgICAgJCBtaWdyYXRpb24tdGVzdCAtLXJkbWEtaXAgJFJE
TUFfSVANCj4+Pj4gSSB0aGluayAtLXJkbWEgb25seSBtYWtlcyBzZW5zZSBpZiBpdCdzIGdvaW5n
IHRvIGRvIHNvbWV0aGluZw0KPj4+PiBzcGVjaWFsLiBUaGUgb3B0bWltYWwgc2NlbmFyaW8gaXMg
dGhhdCBpdCBhbHdheXMgcnVucyB0aGUgdGVzdCB3aGVuIGl0DQo+Pj4+IGNhbiBhbmQgc2V0cyB1
cC90ZWFycyBkb3duIGFueXRoaW5nIGl0IG5lZWRzLg0KPj4+Pg0KPj4+PiBJZiBpdCBuZWVkcyBy
b290LCBJJ2QgcHJlZmVyIHRoZSB0ZXN0IGluZm9ybXMgYWJvdXQgdGhpcyBhbmQgZG9lcyB0aGUN
Cj4+Pj4gd29yayBpdHNlbGYuDQo+Pj4+DQo+Pj4+IEl0IHdvdWxkIGFsc28gYmUgZ29vZCB0byBo
YXZlIHRoZSBhZGQgKyBkZXRlY3Qgc2VwYXJhdGUgc28gd2UgaGF2ZSBtb3JlDQo+Pj4+IGZsZXhp
YmlsaXR5LCBtYXliZSB3ZSBtYW5hZ2UgdG8gZW5hYmxlIHRoaXMgaW4gQ0kgZXZlbi4NCj4+Pj4N
Cj4+Pj4gU286DQo+Pj4+DQo+Pj4+IC4vYWRkLnNoDQo+Pj4+IG1pZ3JhdGlvbi10ZXN0DQo+Pj4+
IChydW5zIGRldGVjdC5zaCArIHJ1bnMgcmRtYSB0ZXN0KQ0KPj4+PiAobGVhdmVzIHN0dWZmIGJl
aGluZCkNCj4+Pj4NCj4+Pj4gbWlncmF0aW9uLXRlc3QNCj4+Pj4gKHNraXBzIHJkbWEgdGVzdCB3
aXRoIG1lc3NhZ2UgdGhhdCBpdCBuZWVkcyByb290KQ0KPj4+Pg0KPj4+PiBzdWRvIG1pZ3JhdGlv
bi10ZXN0DQo+Pj4+IChydW5zIGFkZC5zaCArIGRldGVjdC5zaCArIHJ1bnMgcmRtYSB0ZXN0KQ0K
Pj4+PiAoY2xlYW5zIGl0c2VsZiB1cCkNCj4+Pj4NCj4+Pj4gRG9lcyB0aGF0IG1ha2Ugc2Vuc2Ug
dG8geW91PyBJIGhvcGUgaXQncyBub3QgdG9vIG11Y2ggd29yay4NCj4+PiBMb29rcyBnb29kIGhl
cmUuICBXZSBjYW4gYWxzbyBrZWVwIGFsbCB0aGUgcmRtYSBzdHVmZiBpbnRvIG9uZSBmaWxlLCB0
YWtpbmcNCj4+PiBwYXJhbWV0ZXJzLg0KPj4+DQo+Pj4gLi9yZG1hLWhlbHBlci5zaCBzZXR1cA0K
Pj4+IC4vcmRtYS1oZWxwZXIuc2ggZGV0ZWN0LWlwDQo+Pg0KPj4gSGkgUGV0ZXIgYW5kIEZhYmlh
bm8NCj4+DQo+PiBNYW55IHRoYW5rcyBmb3IgeW91ciBraW5kbHkgaWRlYSBhbmQgc3VnZ2VzdGlv
bi4NCj4+IFBsZWFzZSB0YWtlIGFub3RoZXIgbG9vayBhdCB0aGUgY2hhbmdlcyBiZWxvdy4NCj4+
IC0gSSBkb24ndCBjb3B5IHNjcmlwdCB0byB0aGUgYnVpbGQgZGlyLCBqdXN0IGV4ZWN1dGUgdGhl
IHNjcmlwdCBsaWtlIG1pc2MtdGVzdHMuYw0KPj4gLSBJdCB3aWxsIGF1dG9tYXRpY2FsbHkgY3Jl
YXRlIGEgbmV3IFJYRSBpZiBpdCBkb2Vzbid0IGV4aXQgd2hlbiBydW5uaW5nIGluIHJvb3QNCj4g
DQo+IFRoYW5rcyEgIFRoaXMgaXMgbXVjaCBiZXR0ZXIuICBDb21tZW50cyBiZWxvdy4NCj4gDQo+
Pg0KPj4gW1BBVENIXSBtaWdyYXRpb246IEFkZCBxdGVzdCBmb3IgbWlncmF0aW9uIG92ZXIgUkRN
QQ0KPj4NCj4+IFRoaXMgcXRlc3QgcmVxdWlyZXMgdGhlcmUgaXMgUkRNQShSb0NFKSBsaW5rIGlu
IHRoZSBob3N0Lg0KPj4gSW50cm9kdWNlIGEgc2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIu
c2ggdG8NCj4+IC0gc2V0dXAgYSBuZXcgUlhFIGlmIGl0J3Mgcm9vdA0KPj4gLSBkZXRlY3QgZXhp
c3RpbmcgUm9DRSBsaW5rDQo+PiB0byBtYWtlIHRoZSBxdGVzdCB3b3JrIHNtb290aGx5Lg0KPj4N
Cj4+IFRlc3Qgd2lsbCBiZSBza2lwIGlmIHRoZXJlIGlzIG5vIGF2YWlsYWJsZSBSb0NFIGxpbmsu
DQo+PiAgICMgU3RhcnQgb2YgcmRtYSB0ZXN0cw0KPj4gICAjIFJ1bm5pbmcgL3g4Nl82NC9taWdy
YXRpb24vcHJlY29weS9yZG1hL3BsYWluDQo+PiAgIG9rIDEgL3g4Nl82NC9taWdyYXRpb24vcHJl
Y29weS9yZG1hL3BsYWluICMgU0tJUCBUaGVyZSBpcyBubyBhdmFpbGFibGUgcmRtYSBsaW5rIGlu
IHRoZSBob3N0Lg0KPj4gICBNYXliZSB5b3UgYXJlIG5vdCBydW5uaW5nIHdpdGggdGhlIHJvb3Qg
cGVybWlzc2lvbg0KPj4gICAjIEVuZCBvZiByZG1hIHRlc3RzDQo+Pg0KPj4gQWRtaW4gaXMgYWJs
ZSB0byByZW1vdmUgdGhlIFJYRSBieSBwYXNzaW5nICdjbGVhbnVwJyB0byB0aGlzIHNjcmlwdC4N
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+
DQo+PiAtLS0NCj4+ICAgc2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2ggICAgICB8IDQw
ICsrKysrKysrKysrKysrKysrKysNCj4+ICAgdGVzdHMvcXRlc3QvbWlncmF0aW9uL3ByZWNvcHkt
dGVzdHMuYyB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAyIGZpbGVzIGNo
YW5nZWQsIDk3IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNzU1IHNjcmlwdHMv
cmRtYS1taWdyYXRpb24taGVscGVyLnNoDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3NjcmlwdHMvcmRt
YS1taWdyYXRpb24taGVscGVyLnNoIGIvc2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2gN
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+PiBpbmRleCAwMDAwMDAwMDAwLi40ZWY2MmJhZjBm
DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9zY3JpcHRzL3JkbWEtbWlncmF0aW9uLWhlbHBl
ci5zaA0KPj4gQEAgLTAsMCArMSw0MCBAQA0KPj4gKyMhL2Jpbi9iYXNoDQo+PiArDQo+PiArIyBD
b3BpZWQgZnJvbSBibGt0ZXN0cw0KPj4gK2dldF9pcHY0X2FkZHIoKSB7DQo+PiArICAgIGlwIC00
IC1vIGFkZHIgc2hvdyBkZXYgIiQxIiB8DQo+PiArICAgICAgICBzZWQgLW4gJ3MvLipbWzpibGFu
azpdXWluZXRbWzpibGFuazpdXSpcKFteWzpibGFuazpdL10qXCkuKi9cMS9wJyB8DQo+PiArICAg
ICAgICB0ciAtZCAnXG4nDQo+PiArfQ0KPj4gKw0KPj4gK2hhc19zb2Z0X3JkbWEoKSB7DQo+PiAr
ICAgIHJkbWEgbGluayB8IGdyZXAgLXEgIiBuZXRkZXYgJDFbWzpibGFuazpdXSpcJCINCj4+ICt9
DQo+PiArDQo+PiArcmRtYV9yeGVfc2V0dXBfZGV0ZWN0KCkNCj4+ICt7DQo+PiArICAgICgNCj4+
ICsgICAgICAgIGNkIC9zeXMvY2xhc3MvbmV0ICYmDQo+PiArICAgICAgICAgICAgZm9yIGkgaW4g
KjsgZG8NCj4+ICsgICAgICAgICAgICAgICAgWyAtZSAiJGkiIF0gfHwgY29udGludWUNCj4+ICsg
ICAgICAgICAgICAgICAgWyAiJGkiID0gImxvIiBdICYmIGNvbnRpbnVlDQo+PiArICAgICAgICAg
ICAgICAgIFsgIiQoPCIkaS9hZGRyX2xlbiIpIiA9IDYgXSB8fCBjb250aW51ZQ0KPj4gKyAgICAg
ICAgICAgICAgICBbICIkKDwiJGkvY2FycmllciIpIiA9IDEgXSB8fCBjb250aW51ZQ0KPj4gKw0K
Pj4gKyAgICAgICAgICAgICAgICBoYXNfc29mdF9yZG1hICIkaSIgJiYgYnJlYWsNCj4+ICsgICAg
ICAgICAgICAgICAgWyAiJG9wZXJhdGlvbiIgPSAic2V0dXAiIF0gJiYgcmRtYSBsaW5rIGFkZCAi
JHtpfV9yeGUiIHR5cGUgcnhlIG5ldGRldiAiJGkiICYmIGJyZWFrDQo+PiArICAgICAgICAgICAg
ZG9uZQ0KPj4gKyAgICAgICAgaGFzX3NvZnRfcmRtYSAiJGkiIHx8IHJldHVybg0KPj4gKyAgICAg
ICAgZ2V0X2lwdjRfYWRkciAkaQ0KPj4gKyAgICApDQo+PiArfQ0KPj4gKw0KPj4gK29wZXJhdGlv
bj0kezE6LXNldHVwfQ0KPj4gKw0KPj4gK2lmIFsgIiRvcGVyYXRpb24iID09ICJzZXR1cCIgXSB8
fCBbICIkb3BlcmF0aW9uIiA9PSAiZGV0ZWN0IiBdOyB0aGVuDQo+PiArICAgIHJkbWFfcnhlX3Nl
dHVwX2RldGVjdA0KPj4gK2VsaWYgWyAiJG9wZXJhdGlvbiIgPT0gImNsZWFudXAiIF07IHRoZW4N
Cj4+ICsgICAgbW9kcHJvYmUgLXIgcmRtYV9yeGUNCj4gDQo+IFdvdWxkIHRoaXMgYWZmZWN0cyBo
b3N0IHdoZW4gdGhlcmUncyBleGlzdGluZyB1c2VyIG9mIHJkbWFfcnhlIChvciBmYWlsDQo+IHdp
dGggLUVCVVNZKT8gIA0KDQonbW9kcHJvYmUgLXIgJyB3aWxsIGZhaWwgd2l0aCBFQlVTWSBpbiB0
aGlzIGNhc2UuDQoNCg0KPiBJZiB0aGVyZSdzIG5vIG1ham9yIHNpZGUgZWZmZWN0IG9mIGxlZnRv
dmVyIHJkbWEgbGluaywgd2UNCj4gY291bGQgYWxzbyBkcm9wIHRoZSAiY2xlYW51cCIgZm9yIG5v
dyBhbmQgc3RhcnQgZnJvbSBzaW1wbGUuDQoNCkluIG15IHVuZGVyc3RhbmRpbmcsIHRoZXJlIGlz
IG5vIGFueSBzaWRlIGVmZmVjdCwgSSdtIGZpbmUgdG8gZHJvcCBpdCBpbiB0aGlzIHRpbWUuDQoN
Cg0KPiANCj4+ICtlbHNlDQo+PiArICAgIGVjaG8gIlVzYWdlOiAkMCBbc2V0dXAgfCBjbGVhbnVw
IHwgZGV0ZWN0XSINCj4+ICtmaQ0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L21pZ3JhdGlv
bi9wcmVjb3B5LXRlc3RzLmMgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5j
DQo+PiBpbmRleCBiYTI3M2QxMGI5Li44YzcyZWI2OTliIDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMv
cXRlc3QvbWlncmF0aW9uL3ByZWNvcHktdGVzdHMuYw0KPj4gKysrIGIvdGVzdHMvcXRlc3QvbWln
cmF0aW9uL3ByZWNvcHktdGVzdHMuYw0KPj4gQEAgLTk5LDYgKzk5LDU5IEBAIHN0YXRpYyB2b2lk
IHRlc3RfcHJlY29weV91bml4X2RpcnR5X3Jpbmcodm9pZCkNCj4+ICAgICAgIHRlc3RfcHJlY29w
eV9jb21tb24oJmFyZ3MpOw0KPj4gICB9DQo+PiAgIA0KPj4gKyNpZmRlZiBDT05GSUdfUkRNQQ0K
Pj4gKw0KPj4gKyNkZWZpbmUgUkRNQV9NSUdSQVRJT05fSEVMUEVSICJzY3JpcHRzL3JkbWEtbWln
cmF0aW9uLWhlbHBlci5zaCINCj4+ICtzdGF0aWMgaW50IG5ld19yZG1hX2xpbmsoY2hhciAqYnVm
ZmVyKSB7DQo+IA0KPiBOaXQ6IG5ld2xpbmUgYmVmb3JlICJ7Ii4NCg0KR29vZCBjYXRjaCENCg0K
DQo+IA0KPj4gKyAgICBjb25zdCBjaGFyICphcmd1bWVudCA9IChnZXRldWlkKCkgPT0gMCkgPyAi
c2V0dXAiIDogImRldGVjdCI7DQo+PiArICAgIGNoYXIgY29tbWFuZFsxMDI0XTsNCj4+ICsNCj4+
ICsgICAgc25wcmludGYoY29tbWFuZCwgc2l6ZW9mKGNvbW1hbmQpLCAiJXMgJXMiLCBSRE1BX01J
R1JBVElPTl9IRUxQRVIsIGFyZ3VtZW50KTsNCj4+ICsNCj4+ICsgICAgRklMRSAqcGlwZSA9IHBv
cGVuKGNvbW1hbmQsICJyIik7DQo+PiArICAgIGlmIChwaXBlID09IE5VTEwpIHsNCj4+ICsgICAg
ICAgIHBlcnJvcigiRmFpbGVkIHRvIHJ1biBzY3JpcHQiKTsNCj4+ICsgICAgICAgIHJldHVybiAt
MTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBpbnQgaWR4ID0gMDsNCj4+ICsgICAgd2hpbGUg
KGZnZXRzKGJ1ZmZlciArIGlkeCwgMTI4IC0gaWR4LCBwaXBlKSAhPSBOVUxMKSB7DQo+PiArICAg
ICAgICBpZHggKz0gc3RybGVuKGJ1ZmZlcik7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgaW50
IHN0YXR1cyA9IHBjbG9zZShwaXBlKTsNCj4+ICsgICAgaWYgKHN0YXR1cyA9PSAtMSkgew0KPj4g
KyAgICAgICAgcGVycm9yKCJFcnJvciByZXBvcnRlZCBieSBwY2xvc2UoKSIpOw0KPj4gKyAgICAg
ICAgcmV0dXJuIC0xOw0KPj4gKyAgICB9IGVsc2UgaWYgKFdJRkVYSVRFRChzdGF0dXMpKSB7DQo+
PiArICAgICAgICByZXR1cm4gV0VYSVRTVEFUVVMoc3RhdHVzKTsNCj4+ICsgICAgfQ0KPj4gKw0K
Pj4gKyAgICByZXR1cm4gLTE7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHRlc3RfcHJl
Y29weV9yZG1hX3BsYWluKHZvaWQpDQo+PiArew0KPj4gKyAgICBjaGFyIGJ1ZmZlclsxMjhdID0g
e307DQo+PiArDQo+PiArICAgIGlmIChuZXdfcmRtYV9saW5rKGJ1ZmZlcikpIHsNCj4+ICsgICAg
ICAgIGdfdGVzdF9za2lwKCJUaGVyZSBpcyBubyBhdmFpbGFibGUgcmRtYSBsaW5rIGluIHRoZSBo
b3N0LlxuIg0KPj4gKyAgICAgICAgICAgICAgICAgICAgIk1heWJlIHlvdSBhcmUgbm90IHJ1bm5p
bmcgd2l0aCB0aGUgcm9vdCBwZXJtaXNzaW9uIik7DQo+IA0KPiBOaXQ6IGNhbiBiZSBzbGlnaHRs
eSBtb3JlIHZlcmJvc2U/DQo+IA0KPiAgICAgICAgICAgICBnX3Rlc3Rfc2tpcCgiXG5UaGVyZSBp
cyBubyBhdmFpbGFibGUgcmRtYSBsaW5rIHRvIHJ1biBSRE1BDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgIG1pZ3JhdGlvbiB0ZXN0LiAgVG8gZW5hYmxlIHRoZSB0ZXN0OlxuIg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAiKDEpIFJ1biBcJyVzIHNldHVwXCcgd2l0aCByb290IGFuZCByZXJ1
biB0aGUgdGVzdFxuIg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAiKDIpIFJ1biB0aGUgdGVz
dCB3aXRoIHJvb3QgcHJpdmlsZWdlXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBSRE1B
X01JR1JBVElPTl9IRUxQRVIpOw0KDQpZZXMsIGl0J3MgbXVjaCBiZXR0ZXIuDQoNCg0KVGhhbmtz
DQpaaGlqaWFuDQoNCg0KPiANCj4gDQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAgIH0NCj4+
ICsNCj4+ICsgICAgLyogRklYTUU6IHF1ZXJ5IGEgZnJlZSBwb3J0IGluc3RlYWQgb2YgaGFyZCBj
b2RlLiAqLw0KPj4gKyAgICBnX2F1dG9mcmVlIGNoYXIgKnVyaSA9IGdfc3RyZHVwX3ByaW50Zigi
cmRtYTolczo3Nzc3IiwgYnVmZmVyKTsNCj4+ICsNCj4+ICsgICAgTWlncmF0ZUNvbW1vbiBhcmdz
ID0gew0KPj4gKyAgICAgICAgLmxpc3Rlbl91cmkgPSB1cmksDQo+PiArICAgICAgICAuY29ubmVj
dF91cmkgPSB1cmksDQo+PiArICAgIH07DQo+PiArDQo+PiArICAgIHRlc3RfcHJlY29weV9jb21t
b24oJmFyZ3MpOw0KPj4gK30NCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICAgc3RhdGljIHZvaWQgdGVz
dF9wcmVjb3B5X3RjcF9wbGFpbih2b2lkKQ0KPj4gICB7DQo+PiAgICAgICBNaWdyYXRlQ29tbW9u
IGFyZ3MgPSB7DQo+PiBAQCAtMTEyNCw2ICsxMTc3LDEwIEBAIHN0YXRpYyB2b2lkIG1pZ3JhdGlv
bl90ZXN0X2FkZF9wcmVjb3B5X3Ntb2tlKE1pZ3JhdGlvblRlc3RFbnYgKmVudikNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICB0ZXN0X211bHRpZmRfdGNwX3VyaV9ub25lKTsNCj4+ICAgICAg
IG1pZ3JhdGlvbl90ZXN0X2FkZCgiL21pZ3JhdGlvbi9tdWx0aWZkL3RjcC9wbGFpbi9jYW5jZWwi
LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHRlc3RfbXVsdGlmZF90Y3BfY2FuY2VsKTsN
Cj4+ICsjaWZkZWYgQ09ORklHX1JETUENCj4+ICsgICAgbWlncmF0aW9uX3Rlc3RfYWRkKCIvbWln
cmF0aW9uL3ByZWNvcHkvcmRtYS9wbGFpbiIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICB0
ZXN0X3ByZWNvcHlfcmRtYV9wbGFpbik7DQo+PiArI2VuZGlmDQo+PiAgIH0NCj4+ICAgDQo+PiAg
IHZvaWQgbWlncmF0aW9uX3Rlc3RfYWRkX3ByZWNvcHkoTWlncmF0aW9uVGVzdEVudiAqZW52KQ0K
Pj4gLS0gDQo+PiAyLjQxLjANCj4+DQo+IA==

