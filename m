Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0A3CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yNW-00085q-VP; Thu, 25 Sep 2025 22:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1yNT-00085S-N6
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:40:07 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com ([216.71.158.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1yNM-0007eH-4Q
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1758854400; x=1790390400;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=dpB2JEpfUrGMSbZ5Y5ZiKmhB/dRXbRzBZUqZKTDIpKg=;
 b=rj7LzShCX1sCd77lzQsTbvRQIuT0TtFLioGcK79oEXOKmz9GjTNmmMdo
 sfPY5BjtqBJDT/kJX9JqBHcfsrjSkMzHpvnGG8ilFPa9arJvIjH+BKagA
 zUiMaZHDevLToJ7WAYSRUuWrAkS0d8FF725YNUKD4y6mje+i4ojNyKbfH
 XXj7JnA2WYh3Ple0cKkGKx44VMNmwKt+SxW1fvW4SfnzvFRdsqWQpM8yM
 rT98W86tmblu/mCvLNcmr0uHKJOPYaUNSTCj41dqpgQDcWA47SopbIsVr
 YzFfxzB9uo6uwsagtiOVEB1vQBoYiMrECKVtmX/TZTtOzQfIba0w76Er9 A==;
X-CSE-ConnectionGUID: U0pW6tsTQgqikRfMrOf+0g==
X-CSE-MsgGUID: GJ/UZ4TFSb6eTOg/2x9+1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="168913298"
X-IronPort-AV: E=Sophos;i="6.18,293,1751209200"; d="scan'208";a="168913298"
Received: from mail-japanwestazon11010047.outbound.protection.outlook.com
 (HELO OS0P286CU011.outbound.protection.outlook.com) ([52.101.228.47])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 11:39:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C16hdHzyMSMIKNJTKqzIL6gLHa3YCzuuo9XDddM8R18cYXEyJNvhM0/MI5u+2p5ShoDUy4z4Bq+NQxGw53kg+kHMr4fxuxy0kWX43Tw2PyjS/7/41G+gLC/eze2g3aEY1XBpcBpP6w3xMbxIsKtD043MxG8TFQZbY6jmIHRimbeeYBsS14fGBI6FN7zHpPoBOJRN6z6HIb/Bdi6us4U0GHJ2RjoX5BvBgQgS8sDISxXV7RmG8yh2CyaCZR6nLnkfrRkSjb7CN3Int7OwRuwjUrEqe+HQ1dHIa4pfGKwFC+sbksWBoMAMzNmfaWunmyF/JBl3JGNiHejQj1+LniTLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpB2JEpfUrGMSbZ5Y5ZiKmhB/dRXbRzBZUqZKTDIpKg=;
 b=DZDAJ26MHxuwFZmWjiZf4ISlaACmFs9Zmy3yuvik0IkAHRllfBiL7+B33kIzyN5Nb2b0Ey4PYPLagtdMqXj3VJ7Cm9bHQfuNE8+kqMrobdtO5xZ8moOww5GunQc2b2RlpVk591TpmMZnelvZgVLnmgVFL21RinKQCZo8FIY8q3LtAoeZr6yld0546fhIOZn9C0d02W/N2cKZtzspJPqtRxtcZ8a8HC8VeadtWrPyHN+CU1nMbbEka9GhG3rgu1Fp+rR+uOYNlBWTjACCp5U7fmbkuTp8jN3X9k1OoO2k5VJzNxOhYXwHfEbgH/zo8K3zIhj7gq3WZS2JpoQu8UnR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpB2JEpfUrGMSbZ5Y5ZiKmhB/dRXbRzBZUqZKTDIpKg=;
 b=TUvtmJB5PsW3GXyod/cKzUwsYehjvLnRvEdfNQanne9AiC0sYFIAotCUjIgbPI9Lp0r5w9/ydL1doTYpfeA8Rv2tLNTrtrFM3vHExL7gxYjfSWGIn3n1Ze4TfjbTXAY1uF4XrH98mdNfdQPlpDU8WzrEj04dDVxum9XX+Xi/Zv17aATJVRtMPXmeoN63jzEksR1QFYFCaXHNYARFL3GoO4DGN414iqqrGLEaLZFvC2bacP1z2DYgb+sDxt6VD4awKdHHkK/m217m9ASBpss9pXVX7+EQZ0vXtXnIa0p98j9S7tmqiMyqMNzPL5c5F86eWm9KfOpyTBfI07pg98ni/g==
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by OS7PR01MB14786.jpnprd01.prod.outlook.com (2603:1096:604:39d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 02:39:43 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 02:39:43 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Dr . David Alan Gilbert" <dave@treblig.org>, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>, Yury Kotov
 <yury-kotov@yandex-team.ru>, Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 4/9] migration/rdma: Change io_create_watch() to
 return immediately
Thread-Topic: [PATCH RFC 4/9] migration/rdma: Change io_create_watch() to
 return immediately
Thread-Index: AQHcF5WT2MlR+n6qgUy1DzJ3xozfGbSk7nQA
Date: Fri, 26 Sep 2025 02:39:43 +0000
Message-ID: <a29ebbe7-008d-4d96-a2c4-825378055a28@fujitsu.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-5-peterx@redhat.com>
In-Reply-To: <20250827205949.364606-5-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|OS7PR01MB14786:EE_
x-ms-office365-filtering-correlation-id: eca3f8cf-bd27-4f0d-801f-08ddfca5f342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ckZHVXNMNk5Pb0R5bzVHSDRzUkhWN3FCWDdLUEdSdEV6SVRCblU5SlFVS1pt?=
 =?utf-8?B?cHFud1VHWDh5YllIRWYzVlpmRFlaRTRPQW1obFNLWHVjWFQyOHN3WngwYzFn?=
 =?utf-8?B?MVR2WTV6aEpSeDFmK1VKUlhHRk1YUHZ2N2Q4SXNYb3Fkd1RROWZQYXd0anlj?=
 =?utf-8?B?Q1oxRFN4ZncvbklvN0trV1Y3eFlFTnpGUG0yYkR5WSthV2k1YWZZeFZmK3hG?=
 =?utf-8?B?ZXNZTUFFNE1Bc0JHellCWUhmcE56WURldEQ3QVVhRHBIbkVXb3ZwSnh1Smxu?=
 =?utf-8?B?ZzdyVE5hNEk4TDIyYjVBMmVEb2FoYXhJUjZyMG5HVnVaVnAxa1NUeWpvTGNq?=
 =?utf-8?B?bmpJMGdjUTlWYlptRmxtemhmVVVuNkx3Y21mVGdweWNjOVd5YjhKM29SNDFI?=
 =?utf-8?B?aVNCS1piaS85S0xwKzhtYnJPcE1nQlN0ekJteU5jS2RrV0dEU0RabC9NZU9N?=
 =?utf-8?B?WGZ2bHJEeGx4cFQzcXJ5MWxrQlJtK01EK2tOUmIxd0lDVkJJRHh2YjQ3M0tD?=
 =?utf-8?B?bGRoV0VCeUNEQkZoQUhacnEzZUNxVWg1a2dxYnNMWS9LblgreXlHM2JPbkVo?=
 =?utf-8?B?UjBpYkd2L3dJdGwrVk5TRW0wa2twbjFNNVQ0cndCelNNTGpwaitYeDRzM3d5?=
 =?utf-8?B?TTlwR25QU00yLzQxMnVjd3l0RFJHY0ExbmpKaVJ2akJnNEFsUGtNZm5EVXgy?=
 =?utf-8?B?YktPMmNwNWlxNjlHRFhLM0hWRUZneTd5dVdnbU91WjJheGxFeVo1WCtRQ09T?=
 =?utf-8?B?NmdTa1E3SXRSR1U2T0JiU24vcFJpVFJEaFVLUmx5bDdnQmJFb0NYaElDNU84?=
 =?utf-8?B?NWhyTXl3eDBpdzlMUzJkWktXUmpwWCt3L1FSdnU4bHplakFVZUNwNjAyT1Nj?=
 =?utf-8?B?dXpwRlZrMHpkb3NVTWRUYzB2STFTUHFzekdTTnN4dzhvNE0xbVhlNmdyYWlQ?=
 =?utf-8?B?azZQZktlOW5lNXhZczMzQ3R4SFIwZzk1QnZYVjFvT2ZqZjd0ZzMwclNXdkVD?=
 =?utf-8?B?VmFEY1hON0E1S3dnOUJWeXE1SmJBeUVnbVlPR2JOa3lUV2dNMUorZTNpZVhq?=
 =?utf-8?B?RUlWRzZxM1BNeVpTdlUxMVhFNUtxTXRQdG9RTzgyZW1iMXR6akdQaDBLblFL?=
 =?utf-8?B?MWtaclZlQVVycndhaFpnUWQxakU1ckF3SldUbCtCZzg1bHpHbjBoUG56RUxX?=
 =?utf-8?B?YVdJb2h1eFB3cHZodFgwc0toUkVodW5jeDBrS0hSeDZUUkVxU3dFWGZIZlQw?=
 =?utf-8?B?bU44Y3JsT3lhekRMWXNnaEg5MlR0TFVsWkRIdk9hQ014bDc1QXVYQlExSTM4?=
 =?utf-8?B?dUVJS2hXR21DZUtJaHNLOWJuOWNSa1RNRXpLTGJ0R3U2cDV3QytQeEh1a2tz?=
 =?utf-8?B?YUwyTklUd0hybXZhQUFqZHI1TFQxUzMyVlR0aFBZM0U0TytTck01ZVhIT09n?=
 =?utf-8?B?T0JOQUZtMldRYnEvc3FGQ0JoL0lHYkNScjhtMHF3RjZuSkkrRVJxY0NBdFRa?=
 =?utf-8?B?dEI5YzA1RWNYcmhTVFBQeGx3V3l1K2VXaWZuZDFuNlVBV2tvOGd2a3g0a0ZT?=
 =?utf-8?B?Z2F3NzNVK3ZERDB0RHJCeC9CR2U1TDFoc25Mamt3RkxxMXgxdk1NK2NEemNG?=
 =?utf-8?B?WWh5NmU4RDJYUW1UNkdMMTZLVk1IczMvd2E3by9UWG0xeHZLM2JWK25LdXB0?=
 =?utf-8?B?TmxXQjhaNFRkUnFEVjFXclFQOWhkS2RyaHhMdTVQMkh1bFpodUUwRkpXU1gx?=
 =?utf-8?B?VDJRVGVCUGk4UW1BeWNFallPQm1QaUkvL054L21VUGRwR2FxcXZkWHJFVXBZ?=
 =?utf-8?B?ekxzenc2eVJRMU54OFFvUlJ3cDdSYStkUVFWQk43eHI0THVoY3g4ay9VQ0E4?=
 =?utf-8?B?YlhaS1piaHlwaFdhdkFRbnprTXRUYmtUM0VMRlNyL25EazFpa3NHdjFMN1Rm?=
 =?utf-8?B?WVhCbkRxbFhuSFVTc2E2djJlN2NJay95RFd5bVhFeGVZOVBDYmU0YkMyUmJP?=
 =?utf-8?B?SnpjVlVKT3ZzUG85ckNETUNVSytQbmhiUkhHMVlyaHZUdUcvYzNQclpvbmE1?=
 =?utf-8?B?L3M4V0J4eHprVW12OG4zWVNhNzg1UDcrTDkyUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSCPR01MB13050.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YitlcnFYOHlkZU9FY0lSd2JhZWR4M1o4aGtXREgwcXhDMStIblRsK0VKVVU1?=
 =?utf-8?B?cElkMVVXUmJVa3doQVA5c1R2NnkxemhJOW4xWVVMNHFNWThEbm1UbllQR0J1?=
 =?utf-8?B?UlhQMnBkUnpOVkhHUjFoZ0gvdkF5UStNMVRGMk9IbnMzWFpFZ2lWTnhJYjNm?=
 =?utf-8?B?WnpCR2Q1M0NvemUrMHBzYnlBRUp1TUV0TmNXbnhJZmNtZUxwdlNSWEFURVRz?=
 =?utf-8?B?dVZLcWgrR2wwUS9VUjNBS0J6MnZKUTBDY3ZadDA5ckdORHRaUWYyUEZuQXBQ?=
 =?utf-8?B?eWxzT2gyVUIvRDlVeTZjM0kySHBKSGd0cWVYOU1ONWE5dEpCZE1pMUU0bkZH?=
 =?utf-8?B?ajVNdGFMcW5QdERMNzRvRXJZb3FRdjIrWm1yVE1GU3JlR1YyM3Jhc3VwR3BW?=
 =?utf-8?B?aWYrV3pic1RtTmxad0V0MzRjU2RrQXRDY3ZKQ2pXVkNOUGxESUlPeVdWRmF0?=
 =?utf-8?B?clhOdkFydU5FQi9jMHhHSGNFY0JsOWpnUDJiUUV2bFlUSEtUMXVxYjZaaC9o?=
 =?utf-8?B?SDJFVXNkWUZ3RVkvUUdESVN0Rk85a1BhTm84Tnk5Y0xERnliVG5hZ1hFbERr?=
 =?utf-8?B?RENQdHR6akk0Q2NzV2U1QnRRTHE2MHNYNklpWkRrSnYreEhvUi9zQ29GaC9Z?=
 =?utf-8?B?YVZQYVhuVUF5NzlVa3VqU1NHVW9ybzVJK3lrNWJMMktXalQybXNnMXRJMDN0?=
 =?utf-8?B?N1hmYWpINDBJMy9PaWI5MFM1MHcxTW5TaXpCL1ZPcm10R3JZSmY2R3JaTUZP?=
 =?utf-8?B?MWRMS3pibVVXZ2VvRWlxaHg1bXpGczkvZkVzV3F6cmNwaWZGVzFycVpWdnQz?=
 =?utf-8?B?UHBKbUZpWTEyZEtsV1RRYnRvckhjTHJDdmtWdjZxOTdjRFYySE84Y3owZDVm?=
 =?utf-8?B?WWRxSUpERGVUZkpSU0IvbnRWbTh0dWd3b0ZhODhoUnlOK2NtdWlVYjRvVzdB?=
 =?utf-8?B?Y1k0VkxiYURxalcvTHdMYU9kaXo3R251c1krNHl3Y1VhNklzMmVBWTJvUmNr?=
 =?utf-8?B?TFRIQzcweW9lVWFDcW9lTnhDZVhMUUhxdGZSZ2JnTStYNEFRRUwyL0UwaU5Q?=
 =?utf-8?B?QW9Gc0c4aVVjNlBGYmFLdkRLcWtEcEd5YXFkVUVnK2RMSVpLQ052TEE0TVhM?=
 =?utf-8?B?aHVraVRPU1dEQnh3Q1hmNmZESXdaK0NJL0VjZUw5TnkzZVhDREVQanQ4UTh3?=
 =?utf-8?B?SkZHZzQ0alFSSzZ3dVYrdTcxRjk4TUsrVHRzMjVSKzlwUU1sYlRyLzVOK1NF?=
 =?utf-8?B?RG5MTVNueWRoU0d6TVFabUh4NXVnaWI2dCtZM1FTU3I4VHJERjlieTNjMm5Z?=
 =?utf-8?B?eHd3NWdnMmxjZzlsOUFUamgzQzArUnBrNzY0UnVEOWczVlRUZWFsV005aGdl?=
 =?utf-8?B?Z3V0UU1PZEdYdDN1YWkxWUh2bDlxaStqMWhiM25RUnlWeHVwc3Y5TUozNTVT?=
 =?utf-8?B?VVNTcDVIRWVFSDhvN1ZhL0ZTM2pCRzJiZU5GVWp3WFNTWVZrWlF0OUMrdkw4?=
 =?utf-8?B?bzZxZjdqK1NualM1RXpkSXhrTTB2bmdpWlJUWFRZeFozcWNtdGhvbk9ZckNx?=
 =?utf-8?B?Z0t1STJuUTJGbE5BSnFPNmpMZlBhVzhpcFcwdjgvN2p0amtSSHVKaFpZT1dt?=
 =?utf-8?B?cTVybVRXNlpWNDE4WXBEZzJnTlRlck9XOCtVM3M0RUpyZ2lvSzd2RlhXWjgz?=
 =?utf-8?B?eGdldFFpVWhtUSt0a1JoOUlybHRnaUE2QTJ0S3hpRGQrazVsMG94Skw0YmFD?=
 =?utf-8?B?c0lwRDh4dHBuTlVuRFo4aEU4Z0JWRmFraHY5WnArSkhZR3F1MldESXpUdk9y?=
 =?utf-8?B?Z01JODVGRE5mMXNZek52WlI2REFnbmZ3RG5yNnFkYmRxMC9iQXdCNXBjQW00?=
 =?utf-8?B?NjdqL0owWFAwc01nQ2pwZmgwMXBWQzJTdjE3UE9CYkpsOFJYMGcwaHNCVkRT?=
 =?utf-8?B?RXhlZW0zZlVRdFJVUFRKTE9ZeHhpTkMwRUJSZFNtUlhuTEtJS3JFUUh1L0Jy?=
 =?utf-8?B?QkJsRm9vV09TeGVKczl1TEpCVDdjY2JsNnRVMWdZdm9Jai8wUWtMZ29saFR2?=
 =?utf-8?B?ekw5YzBjc00wWUl4V2pMRlBBNEpCTjh0eE1GQlNNTXNGUHVoUVN0cEJWaHk5?=
 =?utf-8?B?eGR3eU04WU1NNU9FUTFrQ3VDQ083THV6VFZYaGQ0WmN4VVJQcVNnL2syNGFU?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56925F2959A90F4598DE4D353D063AA7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JdtlYOVAtcOqLeofmS/xrtQj0+QQmeXUtSN0/jA0/08YKoMZa3cEWt1B7q6ZvMtIchEDCZQ07NjoquQURN1iErIKaEMSBJPXjVAGADbICHxKyQRAeuui4ucfhZ/pnsJxyIF451+eu680tEpD9j0oFAE35phRLQ10mkCeoVQi4hXxNzExvz6CxyQCPb7HBXiynod2ze1t9U8cjR6C0qD6I3utReMyY+7tiMMTvS0e+TK75Jsu+789LzwFxcC7xojIgga3Bd4m0abkk65Eu4brSFdLSXnjz1EwelAoujUURO738hFynxO7sAE+VgHv9aXsl4f5xis2eYb+xanQIUyleaE8rry05wFbrAauMa8z+xMpgDh/ItwLFZWNghEGeyL5oyMK8ohobYZ9bYdqgFbsxor2oHVviM63ycUzTjpUFUUjxmHJlLlbnYbK4QB2tGGtdkey+4csQ9Kmht6QN2hOfeLpUJvnAfj+jU4KWMsiDDk1Bd/zhlU+snPm3UiyFFobjJ6SXXub0crj7UJnxUFEFI/UZzpu1Q9WkKEzb4rfV7m/BgYGVAfEYTaPTBUsRZzy3VGDAvjKsd2GmnmE48XNnsBwgrQ1clIpS0Jx1Lq6nqbQdPlJwk/HOyvTj29mcIIt
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca3f8cf-bd27-4f0d-801f-08ddfca5f342
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 02:39:43.7219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pSgXaMNiF85onwRdlmlmh2f3iNC7okK5hhyIyPr6PSv6DLwWVYRzi0vXQwH3x9t2mAGkmcYkd+QpWy3dk/iEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14786
Received-SPF: pass client-ip=216.71.158.34; envelope-from=lizhijian@fujitsu.com;
 helo=esa17.fujitsucc.c3s2.iphmx.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDI4LzA4LzIwMjUgMDQ6NTksIFBldGVyIFh1IHdyb3RlOg0KPiBUaGUgb2xkIFJETUEn
cyBpb19jcmVhdGVfd2F0Y2goKSBpc24ndCByZWFsbHkgZG9pbmcgbXVjaCB3b3JrIGFueXdheS4g
IEZvcg0KPiBHX0lPX09VVCwgaXQgYWxyZWFkeSBkb2VzIHJldHVybiBpbW1lZGlhdGVseS4gIEZv
ciBHX0lPX0lOLCBpdCB3aWxsIHRyeSB0bw0KPiBkZXRlY3Qgc29tZSBSRE1BIGNvbnRleHQgbGVu
Z3RoIGhvd2V2ZXIgbm9ybWFsbHkgbm9ib2R5IHdpbGwgYmUgYWJsZSB0byBzZXQNCj4gaXQgYXQg
YWxsLg0KPiANCg0KDQpGaXJzdCwgUkRNQSBtaWdyYXRpb24gd29ya3Mgd2VsbCB3aXRoIHRoaXMg
cGF0Y2ggYXBwbGllZC4NCg0KVGVzdGVkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRz
dS5jb20+DQoNCg0KSSBoYXZlIGEgc21hbGwgcXVlc3Rpb24uIFdoaWxlIHRlc3RpbmcsIEkgZGlk
bid0IG9ic2VydmUgYW55IGNhbGxlcnMgdG8NCnFpb19jaGFubmVsX3JkbWFfY3JlYXRlX3dhdGNo
KCkgZHVyaW5nIGEgY29tcGxldGUgUkRNQSBtaWdyYXRpb24gdXNpbmcNCnRoZSBkZWZhdWx0IGNh
cGFiaWxpdGllcyBhbmQgcGFyYW1ldGVycy4NCkkgd2FzIHdvbmRlcmluZyBpbiB3aGljaCBjYXNl
IHRoaXMgZnVuY3Rpb24gaXMgZXhwZWN0ZWQgdG8gYmUgY2FsbGVkPw0KKEkgc2VlIGlvX2NyZWF0
ZV93YXRjaCgpIGlzIG1hbmRhdG9yeSBmb3IgUUlPQ2hhbm5lbENsYXNzKQ0KDQoNClRoYW5rcw0K
Wmhpamlhbg0KDQoNCj4gU2ltcGxpZnkgdGhlIGNvZGUgc28gdGhhdCBSRE1BIGlvY2hhbm5lbHMg
c2ltcGx5IGFsd2F5cyByZWx5IG9uIHN5bmNocm9ub3VzDQo+IHJlYWRzIGFuZCB3cml0ZXMuICBJ
dCBpcyBoaWdobHkgbGlrZWx5IHdoYXQgNmRkZDJkNzZjYTZmODZmIHdhcyB0YWxraW5nDQo+IGFi
b3V0LCB0aGF0IHRoZSBhc3luYyBtb2RlbCBpc24ndCByZWFsbHkgd29ya2luZyB3ZWxsLg0KPiAN
Cj4gVGhpcyBoZWxwcyBiZWNhdXNlIHRoaXMgaXMgYWxtb3N0IHRoZSBvbmx5IGRlcGVuZGVuY3kg
dGhhdCB0aGUgbWlncmF0aW9uDQo+IGNvcmUgd291bGQgbmVlZCBhIGNvcm91dGluZSBmb3IgcmRt
YSBjaGFubmVscy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0
LmNvbT4NCj4gLS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8IDY5ICsrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDY2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlv
bi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IGVkNGUyMGI5ODguLmJjZDdhYWUy
ZjIgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3Jk
bWEuYw0KPiBAQCAtMjc4OSw1NiArMjc4OSwxNCBAQCBzdGF0aWMgZ2Jvb2xlYW4NCj4gICBxaW9f
Y2hhbm5lbF9yZG1hX3NvdXJjZV9wcmVwYXJlKEdTb3VyY2UgKnNvdXJjZSwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdpbnQgKnRpbWVvdXQpDQo+ICAgew0KPiAtICAgIFFJ
T0NoYW5uZWxSRE1BU291cmNlICpyc291cmNlID0gKFFJT0NoYW5uZWxSRE1BU291cmNlICopc291
cmNlOw0KPiAtICAgIFJETUFDb250ZXh0ICpyZG1hOw0KPiAtICAgIEdJT0NvbmRpdGlvbiBjb25k
ID0gMDsNCj4gICAgICAgKnRpbWVvdXQgPSAtMTsNCj4gLQ0KPiAtICAgIFJDVV9SRUFEX0xPQ0tf
R1VBUkQoKTsNCj4gLSAgICBpZiAocnNvdXJjZS0+Y29uZGl0aW9uID09IEdfSU9fSU4pIHsNCj4g
LSAgICAgICAgcmRtYSA9IHFhdG9taWNfcmN1X3JlYWQoJnJzb3VyY2UtPnJpb2MtPnJkbWFpbik7
DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAgcmRtYSA9IHFhdG9taWNfcmN1X3JlYWQoJnJz
b3VyY2UtPnJpb2MtPnJkbWFvdXQpOw0KPiAtICAgIH0NCj4gLQ0KPiAtICAgIGlmICghcmRtYSkg
ew0KPiAtICAgICAgICBlcnJvcl9yZXBvcnQoIlJETUFDb250ZXh0IGlzIE5VTEwgd2hlbiBwcmVw
YXJlIEdzb3VyY2UiKTsNCj4gLSAgICAgICAgcmV0dXJuIEZBTFNFOw0KPiAtICAgIH0NCj4gLQ0K
PiAtICAgIGlmIChyZG1hLT53cl9kYXRhWzBdLmNvbnRyb2xfbGVuKSB7DQo+IC0gICAgICAgIGNv
bmQgfD0gR19JT19JTjsNCj4gLSAgICB9DQo+IC0gICAgY29uZCB8PSBHX0lPX09VVDsNCj4gLQ0K
PiAtICAgIHJldHVybiBjb25kICYgcnNvdXJjZS0+Y29uZGl0aW9uOw0KPiArICAgIHJldHVybiBU
UlVFOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgZ2Jvb2xlYW4NCj4gICBxaW9fY2hhbm5lbF9y
ZG1hX3NvdXJjZV9jaGVjayhHU291cmNlICpzb3VyY2UpDQo+ICAgew0KPiAtICAgIFFJT0NoYW5u
ZWxSRE1BU291cmNlICpyc291cmNlID0gKFFJT0NoYW5uZWxSRE1BU291cmNlICopc291cmNlOw0K
PiAtICAgIFJETUFDb250ZXh0ICpyZG1hOw0KPiAtICAgIEdJT0NvbmRpdGlvbiBjb25kID0gMDsN
Cj4gLQ0KPiAtICAgIFJDVV9SRUFEX0xPQ0tfR1VBUkQoKTsNCj4gLSAgICBpZiAocnNvdXJjZS0+
Y29uZGl0aW9uID09IEdfSU9fSU4pIHsNCj4gLSAgICAgICAgcmRtYSA9IHFhdG9taWNfcmN1X3Jl
YWQoJnJzb3VyY2UtPnJpb2MtPnJkbWFpbik7DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAg
cmRtYSA9IHFhdG9taWNfcmN1X3JlYWQoJnJzb3VyY2UtPnJpb2MtPnJkbWFvdXQpOw0KPiAtICAg
IH0NCj4gLQ0KPiAtICAgIGlmICghcmRtYSkgew0KPiAtICAgICAgICBlcnJvcl9yZXBvcnQoIlJE
TUFDb250ZXh0IGlzIE5VTEwgd2hlbiBjaGVjayBHc291cmNlIik7DQo+IC0gICAgICAgIHJldHVy
biBGQUxTRTsNCj4gLSAgICB9DQo+IC0NCj4gLSAgICBpZiAocmRtYS0+d3JfZGF0YVswXS5jb250
cm9sX2xlbikgew0KPiAtICAgICAgICBjb25kIHw9IEdfSU9fSU47DQo+IC0gICAgfQ0KPiAtICAg
IGNvbmQgfD0gR19JT19PVVQ7DQo+IC0NCj4gLSAgICByZXR1cm4gY29uZCAmIHJzb3VyY2UtPmNv
bmRpdGlvbjsNCj4gKyAgICByZXR1cm4gVFJVRTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGdi
b29sZWFuDQo+IEBAIC0yODQ4LDI5ICsyODA2LDggQEAgcWlvX2NoYW5uZWxfcmRtYV9zb3VyY2Vf
ZGlzcGF0Y2goR1NvdXJjZSAqc291cmNlLA0KPiAgIHsNCj4gICAgICAgUUlPQ2hhbm5lbEZ1bmMg
ZnVuYyA9IChRSU9DaGFubmVsRnVuYyljYWxsYmFjazsNCj4gICAgICAgUUlPQ2hhbm5lbFJETUFT
b3VyY2UgKnJzb3VyY2UgPSAoUUlPQ2hhbm5lbFJETUFTb3VyY2UgKilzb3VyY2U7DQo+IC0gICAg
UkRNQUNvbnRleHQgKnJkbWE7DQo+IC0gICAgR0lPQ29uZGl0aW9uIGNvbmQgPSAwOw0KPiAtDQo+
IC0gICAgUkNVX1JFQURfTE9DS19HVUFSRCgpOw0KPiAtICAgIGlmIChyc291cmNlLT5jb25kaXRp
b24gPT0gR19JT19JTikgew0KPiAtICAgICAgICByZG1hID0gcWF0b21pY19yY3VfcmVhZCgmcnNv
dXJjZS0+cmlvYy0+cmRtYWluKTsNCj4gLSAgICB9IGVsc2Ugew0KPiAtICAgICAgICByZG1hID0g
cWF0b21pY19yY3VfcmVhZCgmcnNvdXJjZS0+cmlvYy0+cmRtYW91dCk7DQo+IC0gICAgfQ0KPiAt
DQo+IC0gICAgaWYgKCFyZG1hKSB7DQo+IC0gICAgICAgIGVycm9yX3JlcG9ydCgiUkRNQUNvbnRl
eHQgaXMgTlVMTCB3aGVuIGRpc3BhdGNoIEdzb3VyY2UiKTsNCj4gLSAgICAgICAgcmV0dXJuIEZB
TFNFOw0KPiAtICAgIH0NCj4gLQ0KPiAtICAgIGlmIChyZG1hLT53cl9kYXRhWzBdLmNvbnRyb2xf
bGVuKSB7DQo+IC0gICAgICAgIGNvbmQgfD0gR19JT19JTjsNCj4gLSAgICB9DQo+IC0gICAgY29u
ZCB8PSBHX0lPX09VVDsNCj4gICANCj4gLSAgICByZXR1cm4gKCpmdW5jKShRSU9fQ0hBTk5FTChy
c291cmNlLT5yaW9jKSwNCj4gLSAgICAgICAgICAgICAgICAgICAoY29uZCAmIHJzb3VyY2UtPmNv
bmRpdGlvbiksDQo+IC0gICAgICAgICAgICAgICAgICAgdXNlcl9kYXRhKTsNCj4gKyAgICByZXR1
cm4gKCpmdW5jKShRSU9fQ0hBTk5FTChyc291cmNlLT5yaW9jKSwgcnNvdXJjZS0+Y29uZGl0aW9u
LCB1c2VyX2RhdGEpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZA0K

