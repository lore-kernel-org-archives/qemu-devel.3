Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B5C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA37p-0004OT-Jz; Wed, 30 Apr 2025 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uA37n-0004Ns-IZ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:49:03 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uA37k-0006Ft-PE
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1746002940; x=1777538940;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=hRTyj0NoK/s/9+F3b5Ftcw9Z7XPKHy5GGP2xu8Od7rI=;
 b=liNdnLtde1gv8dB8jxC09XxSFvXtuu8c4ymQqghisrRYYPkBiLyBTtdq
 2l6lLg5L7Ru0JuCugJ9L245kGBAtQ278Zfd1DWvXJOugvs9I73uqkb6NP
 0AXYcMBwh7/VQCOjzbx3L1Z+6mX6hQcNlnS4gZ7gxykHhsZ0WLZ6pvGBB
 JsrQctuDDPnAQuGQBkjmsr6J0yyZRTrfTBNqPULFpIdYauqrXVh6PpeOv
 daqfOhDNd4e7zXysxiU/p6QSJ/ne0OF9xjnWZMVAHf8ZynT5ykIPNr8Nx
 Cer7IjTMu94b7fKWiNwzJlB4m6iLXnsm3VVVwU9w/3jblv+2R8QZAeu+K A==;
X-CSE-ConnectionGUID: y2cw3eyFRhiin5IzIA+iLg==
X-CSE-MsgGUID: o6KlJAR1RzqznIfSCLdebA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="65552155"
X-IronPort-AV: E=Sophos;i="6.15,251,1739804400"; d="scan'208";a="65552155"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 17:48:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uv3p053A8H8OTAEmT8mp3+BzRVI7g3d06pPsqawSBRhq8h7ffakFQA1XLzpUnlfyYzYXoH3cGl/YdMABsxCyVVqKlf4LADicLZp367Et6H6zGaD0j1g7CHtL9INnQLmCxSOK4rIPVadOiSBi6eSsJm728Myyww8oZ6UWrdeXwYgp4hGc/JFbPihW6fF/VJpQ2AoMHLq6M/wAjwgRAv63V4nzgzHSyA9jV/OS36uGjj6A0sEkKAQNIPWNKTG75BceIm8Q9EApbqgg4w8mbNoMo6+cMWx8B6pSE9m/lnDf6Ibomx5C11M5V1kshBkPL6YZv1WlAzb6RxoyzslwJGpZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRTyj0NoK/s/9+F3b5Ftcw9Z7XPKHy5GGP2xu8Od7rI=;
 b=ytnUDM7h416xvP/KhkOUKHSo2wc8NW8Nqn+Y/8HUXFBvYqVuB6rhZZIJCRNPLgAfb1YFW4BgBLozg6DQaH7KRK2o9rIoWJLrE/nBMvnHLstWN1eeU0+mM0piKozxWMey+I+ThnPO1X6yFngMAEKwGvvNpbg7XddP45aijAg+Lw8H2DL1Eb2+XAVSqulQMCUhkXVFyVsTPQ0iolOnPrD/oZ9rvLZradJGoAB14MM/gOnv+CRnk7fYtEyPMfFoMpMo6AurN6EzjP/yDiTr2z/oqElmrarAVsq9H7lghXcRywLAmB5lqLFoz3GqBnPeAw0RwljbQ0qt+KY711i/U3NtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OSZPR01MB7129.jpnprd01.prod.outlook.com (2603:1096:604:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 08:48:48 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8678.027; Wed, 30 Apr 2025
 08:48:48 +0000
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael R . Galaxy"
 <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Topic: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Index: AQHbnr3GPFM2rsTaa0SkDCwflcGbZrO7WJ6AgAC9noCAAAWmAA==
Date: Wed, 30 Apr 2025 08:48:47 +0000
Message-ID: <6aaafc7c-9876-45da-8cca-5b670b8ccc50@fujitsu.com>
References: <20250327021234.264161-1-lizhijian@fujitsu.com>
 <aBFAIflmJns_nVIm@x1.local>
 <78c811ed-d6a2-4811-9ac8-48c5c93a2fed@fujitsu.com>
In-Reply-To: <78c811ed-d6a2-4811-9ac8-48c5c93a2fed@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OSZPR01MB7129:EE_
x-ms-office365-filtering-correlation-id: a5a6dc77-17c6-4548-bd38-08dd87c3d2dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|1580799027|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Ry9ZdWlxamlVcm1hdGo2TUd5NzIrMC9TQlNCekpZazNObjMrTmFwM1FiWkF3?=
 =?utf-8?B?SVYxa00rZUx3QWtKL3dyZTlpeEQwTWVXRDFUQk1wdXVjVEwrUlkxcVVwS0l2?=
 =?utf-8?B?a1NXNnRPUGFlRnpXVjZndEZ2THNFSmh3dzV1N1FRMGlLbkFiRU9ZNC9FWVNC?=
 =?utf-8?B?cU5UU0FWZEgzUkZhZHQ4MHVrNm40VDA1NFQ2ZzM2cWVtYmhvRURQK3VxM2VM?=
 =?utf-8?B?MzNWSWdFUmJSK2FOWFlSZHJEeFNVcGpkUTlON3p6RkwxRHpaRHhjQlNpVTVn?=
 =?utf-8?B?YkdZTGhITHR4NlMzV2JqS1ovZnBaZFR0NUllRm05eDNobGVMS085b2JRektK?=
 =?utf-8?B?WDZwV0Fhdml6dld5RUdHSzM2QUlNSWxNRHdtTzVmeVlmSXJpRm9UTzZlR05q?=
 =?utf-8?B?TUxMalNpOExPMkdGdHE0elFlQk0rdkRxaWJXdXI5L0xqMS9qZm5qekpwU0N4?=
 =?utf-8?B?NWUveS9Eem5zTVo2QWs2TUF3aTlVOUQxMllETmg4dnBqOTNaNW83Q1pCY0l3?=
 =?utf-8?B?eTVQU2lhaWROczJoeTJoR2JNQWo4VU5EcHhFZW50RWhSUU9PTDZxTG9helk2?=
 =?utf-8?B?WlpxVEJIK1JrWlpKb1d1cHI3enp2UzNPaDRtdmN2OU00Rzc1V0VuaXFQUUlL?=
 =?utf-8?B?UkZyY1hjMWhnNjVxYzRLbW52cXpBS1NDZFRaUDZUNmJwMVMzaUQrYnBhMklk?=
 =?utf-8?B?VVplaUJlcmpzMEVIM2JaQ21nb3pPUms2SEk5Z0pGWVVYRkVwamlkZGtJcU9T?=
 =?utf-8?B?YW0rWGJnU00yV0J1N1VyaHRMNmVYZ0xVOHN3VjR3TmloaE1STHJnbnN0WXVX?=
 =?utf-8?B?T1lqVEp5Y1RuaVZaWE40Qm1tbVZPQkwvRkhHbk1vRS96dkdvaXl6c0JuZXZw?=
 =?utf-8?B?eW5iZERPSlY1c2k4MGU4RngxUkcwK2VkVlpVRVUvb0Q2UEw5UzlMZ0h6cUdJ?=
 =?utf-8?B?aDh0L2RSYXZaMkxoYnV3c25OUjNQZVZEeUkzNkZiUFJBQ0ZrVjlIVzNzcmZ4?=
 =?utf-8?B?bDZnUUZYNlpZODZpVmtoUk9ic2NjWXVRclZ1dVFLVytMcUpycEZITm4wSXor?=
 =?utf-8?B?ZjRkSXdKbTVORkVCMGJxWm1rTDFPTGdRZmRBYk9pVzZabzRrVE5SYU4vNysv?=
 =?utf-8?B?MlVVRXB5OXhBOW40WkxTTUk2bWVXcThkZDdjZWtONVFXN0xUVlg3a2dzVWpI?=
 =?utf-8?B?UzBkN2YwMVZGTlZhNHJCNnFRRC82YkorVGIvMmtqMlNBNU1aZG1zcFBSeTVJ?=
 =?utf-8?B?OUdMS1FkcUp2U3JoQjRZNjZoaExFZFlkanQ1by80Q1BXNEtrRmhsWWFCd205?=
 =?utf-8?B?dEtwZ3lUMzdjS0Z2bHBZd0RpTEJ2eXhqdUNiNEVVR1VWUkVHT1JKWjQ4UEMr?=
 =?utf-8?B?TUFWNXZYZW52c1ZOWXgxbHZaQW1LMmthcEZQTmJuSDB5ejU3S0p4bnpIcDYw?=
 =?utf-8?B?RHVSRGh6OFUwdEtuM3pKSXhJTFFqNFcwWlhFUy9xOWFYa3BKd3Qwa09EN0Vo?=
 =?utf-8?B?Tkp5UEhDeUc1V2RsT3lXNW9ENTA3TCtNVVFnVHBoRnp2NU9UUzdCK3ZSQmZN?=
 =?utf-8?B?UktqVWl1d1pWUjJtQzJZTVRXVkk1Tlg1Lys5akQ3d3VCeU84SzBoYzNSamdt?=
 =?utf-8?B?blY0cmhLRUkwamtDcHhWZHliejE3aGVYejNkMndJYTdsQ3hGNHdscmFWMFhv?=
 =?utf-8?B?RURCVmZuVFg3MkJ3dE1wOFRuWDlIWnNZZ0JQTWZFY2V0VWNocjZOdXZackl2?=
 =?utf-8?B?Q1JrV2JhUWxqSk5HWjBxSVYvT1FlMHVjdlJCeDY5SVpOS05sUjUxazlLWVdF?=
 =?utf-8?B?R3Jra1dkSkRLK2ZyWm9yNEZSTlhaeWZFVnlqZjd0RnJvd3hUWEt4Q01RN09i?=
 =?utf-8?B?dXFsYmwvNHQxL2NoRlkwL29QRWNIMmRxRXQ2ZW41bVArL29uQU1XWmhaLzFK?=
 =?utf-8?B?QTJFdjc0clcxcnRNb1V4OHhEZzlMMXM0ZmprVlJvRE5QSzRzUHc3TXdSMmRX?=
 =?utf-8?B?OEgvNmV6R01xNDIva0tKOCtQT1Y4a1JHY0svdXJaWWlORE4xWEErWGt0NHFz?=
 =?utf-8?Q?kKEzrP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(1580799027)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWlqekJ4SldIZ2xacDFvZm8zMTlhakZoYXJGR2s1NGhoUW9LNk5saFVoNFRR?=
 =?utf-8?B?SDZHZUN5T1JBVHAyTGhnZ2liT212M2J6Vk9lalVqWjErdmFpakxBTmJENmpX?=
 =?utf-8?B?RzhwK1FGNXNqZ3JrajlMMUM0SEszSVhUU0pkTmd6WnJnNkZZcXJETzFDU0Qv?=
 =?utf-8?B?a0IxbkhIaWFOczZhaEFlakREVER3MEVXQnNwdHlOWnZ3MEFCTWFXdjQxWEtB?=
 =?utf-8?B?bldXZXdOZGdjNExCaGxDYTJPRWxGQ0VLblVJdWd6NG84bndMbGI0Z0xLVzg2?=
 =?utf-8?B?c2ZpejZxeCtOem1RU3NxSzNIelJMT1lPR2d1Zkl0OHVUOGUyeUlELzgxT1JN?=
 =?utf-8?B?YTRhU2gzQTZySVA5SkJOS2JQM29WUXMrM2g5SGlDc0tCWm9mU1RpZm00cEJQ?=
 =?utf-8?B?TFR3RVczcEdCelFQMFFWRXNBOTdBRzZUSUs5eDloeXM0UFNkSkh5VUFvZkVw?=
 =?utf-8?B?eVNCT0xPN2FwTGE0Tnlxd1ZBSzdTU0pLOURHenRNeFAvanFNSjZkWWswQjkv?=
 =?utf-8?B?WVdCK01CSEFFcHVCK0Qva25nVTRHY0YyTnJUNUYyS1hQVklwNExPNmx5TGJX?=
 =?utf-8?B?T2ZydlNONEhnQzNJcVBja05zYUtzcTBRaHFuMTZKOG16MnJjVU44U2cxdENy?=
 =?utf-8?B?UWswanFnTms0ODEwVllPUStDS2lYb05VaUlzWVZ6MTRlcXFjd0dNRjh5UkpI?=
 =?utf-8?B?cnRZWjR5SkYxNWV5ckR2R3I2OTdlU3d0ZE92S0Q2bFhkSDlHT2dSclJxVVFv?=
 =?utf-8?B?Y3hweHdseGkvRGVNQmUzSXFzLzRHTVA4Q0F3Ynd4ck90ZEs0bzNXa2paaWVl?=
 =?utf-8?B?Ymd0ZjNnbTJjRnZLaHN0RjdCYkNjUmRRcG1NRFJ4SGlWdDdhOGY2VXFVaEFo?=
 =?utf-8?B?TkpKTUE0bW9JWkxsMXdZWWFXdytKVXpDU1ZCQUhGRDNnYXpLeE1WajFmN2Rz?=
 =?utf-8?B?V2x3a1Q4SldhRDJyRHZNQS9CZ0NabjY2dlIvVlV6ekcxOHpXb1dHRmdwYmMw?=
 =?utf-8?B?dm8vVFcvOHZyVnZMZzZVYmFXOWljWTg4TDdDU1BMVTJJcHRiVWlHTUZyeEdq?=
 =?utf-8?B?U2VoUGJteGRvd1RFZklMcktaaGErcUZudGNUaE10SnVXZ2l4L3U0S3RQOEN4?=
 =?utf-8?B?WVZOanZ4OEl6dHAxZ3BOcjR3bjR3dkY1bUZROHo4c0NQTTVtQ2xlRUE1L25R?=
 =?utf-8?B?dlVOKy9HNG1TMkNRVE9nWm9oODExK3dmZ0U1RHIxQVhmR1RabGhZQlREdlgx?=
 =?utf-8?B?REdNY1ExaGpMQjEyanZHMUxiazE3NWpqdEVzZDQ4OVJOSGEzU2JvT3RMbVdk?=
 =?utf-8?B?bElIbmFpUjlzZWIvc0RZMzVuc1ZCcjJDUVBMQUZTSFJYU01ZM3ZCVTlBNTBh?=
 =?utf-8?B?eXUrVnA1QkljcWZWSlIwZkdtSXJ4QjFEOXU3dldBdUJFbTc5OUVNZWZkZUhV?=
 =?utf-8?B?ZXBOT3lwVlVVaGhqZFNJeXovRjlwNkVOSnkxeXY4QXg0MEdMdU43QnZ6K0FD?=
 =?utf-8?B?bzM1SG9iMEF1c0dRTFd3SzdCckYrL2xiaXFWQ013dktuNDQyM3E5cG02bHJh?=
 =?utf-8?B?eTdzcDlyT1Iwc0hhdTRoRUdOYlhtQW9neEM5WnJjbU5HYU9XWHdxYW5DOFVl?=
 =?utf-8?B?UnYvTzBVVE1EQzA1M2MzdFFlWUlRR0hmSjZ2MUg5RXFhUHFhelc4aDRTUWFO?=
 =?utf-8?B?UjA1T3JFWVlxYWlrL3U2czAyRFZWeEtXMXFCRnZ5alV6MVVnTzBzdC83S3Nt?=
 =?utf-8?B?WXJpVmhqY3BkbksySTVHY0cweFVFRk1wTHhWcnhQTCs5VkF0dDlpT3lUM3Yx?=
 =?utf-8?B?UkV3NGxtSE80bEpicVZkRC9tZGMvZXhmUGlzL2JaTUluVi8vaDg3NlNvTnli?=
 =?utf-8?B?eU0wdUtDL3NlK0JkWlZ2ZDVVbUVYODdqYmpsKzFpblhpb0dWK2hPalhKNElS?=
 =?utf-8?B?ZVY1QW1yK2pZYytWdzZjTE1vMC9URTlhS0NBUkdUYUV5L3BtMzlza1FtbDNG?=
 =?utf-8?B?Q3crTWxyRmZKQzhlTS9FZTJrMktlb21UeDRDbHBxb2l3WUdFNVpCUmlvQTdQ?=
 =?utf-8?B?eVB4emlSR01ZTHFtUW94MHltMWJIank2cVg3NndtM3pReFFpa3NSSmw5UnN5?=
 =?utf-8?B?czRZMmo3K2t6aUx4UkliNGt3NEhKbGxGamhYaG90V0lkbXlxTDkvLy9TZmZU?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D85B6A1766C9CA4C8BA7C0A01A3A1031@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G/uNjAY2Be7lRVFC64FSzpg3wlVLyuwOsyH6VW41QENGiEI9KGDwvrUfUtUycwpRwLsZpfJl3njOn6JEb5Mx6fcXNOIP8Fmpqhko1gj9FIvncLZ9oGp5f769StEguXIdyPGdfLtO1C0hZHLpGm1Ib57txR9FLCVReKo33h1Om74aO0XWimkEw1rSjt1R0x7jDuLNf2+cWZEjB8n1Qyuet2ZW4y/EJUGlELGzxR9hUSj8m36evkn0kMdrTuMrzWhoymJVkdzUu3cjVGEGcw5XSjoFOM4lZcyUJpiZ/iisaRkT+eZ1ptY82i5Ap2Ro7fxSQa8kp4ce//AUeGldRqsTGJ6+7c/7Jhmfjzy2dt8hsMsUyU7ofj+0i1+aYEMTyPYTjL0dJEm24Qf/pMhv2ou2aq3Qw35eOL6P6p2SFIDqlEAgGAXzLMOtFoV+KE5x2tWoqWLUPBkBspDERuCnn66rSFAMP6e2GKTkhqAPusiJOPITZ7sncK8/24AJU5QNjUJ74dM1Cy07cwZUovaCFvF2oQrH8xk3fV+YJvXm0hnPLGu50y5V+Xr1yCFCPPk/yzXqGbyJNDuQtDT1sBcPNRczPtR+bVvvTMuWxgsIONla1kSBgv4TL05F4koIgywlAdgf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a6dc77-17c6-4548-bd38-08dd87c3d2dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 08:48:48.2510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GcfQs2cDpDbnEY89fHfzUnAYT4mxQokTSh/I4HVYLx09OnbTso5Ns23J2eIJ7F2djelQmWBVVo67TPKTDI+2sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7129
Received-SPF: pass client-ip=68.232.151.212;
 envelope-from=lizhijian@fujitsu.com; helo=esa3.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDMwLzA0LzIwMjUgMTY6MjgsIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPiANCj4gT24g
MzAvMDQvMjAyNSAwNTowOSwgUGV0ZXIgWHUgd3JvdGU6DQo+PiBPbiBUaHUsIE1hciAyNywgMjAy
NSBhdCAxMDoxMjozNEFNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4+IFJlY2VudGx5LCB3
ZSByZW1vdmVkIGlwdjYgcmVzdHJpY3Rpb25bMF0gZnJvbSBSRE1BIG1pZ3JhdGlvbiwgYWRkIGEN
Cj4+PiB0ZXN0IGZvciBpdC4NCj4+Pg0KPj4+IFswXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9x
ZW11LWRldmVsLzIwMjUwMzI2MDk1MjI0Ljk5MTgtMS1qaW5wdS53YW5nQGlvbm9zLmNvbS8NCj4+
Pg0KPj4+IENjOiBKYWNrIFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPg0KPj4+IENjOiBNaWNo
YWVsIFIuIEdhbGF4eSA8bXJnYWxheHlAbnZpZGlhLmNvbT4NCj4+PiBDYzogUGV0ZXIgWHUgPHBl
dGVyeEByZWRoYXQuY29tPg0KPj4+IENjOiBZdSBaaGFuZyA8eXUuemhhbmdAaW9ub3MuY29tPg0K
Pj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4+
PiAtLS0NCj4+Pg0KPj4+IFRoaXMgdGVzdCBpcyBhZGRlZCBiYXNlZCBvbiBbMV0NCj4+DQo+PiBI
bW0sIHRoaXMgY2Fubm90IGFwcGx5IGNsZWFubHkgb24gdG9wIG9mIHlvdXIgcmRtYSB0ZXN0ICsg
SmFrZSdzIGlwdjYgZml4Lg0KPj4gRGlkIEkgbWFkZSBpdCB3cm9uZyBzb21ld2hlcmU/DQo+Pg0K
Pj4gQXQgdGhlIG1lYW50aW1lLCBJIGZvdW5kIHRoYXQgdGhlIGN1cnJlbnQgcmRtYSB1bml0IHRl
c3QgZmFpbGluZyBpZiBJIGRpZA0KPj4gdGhlICJzZXR1cCIgcGhhc2UgdGhlbiBydW4gdGhpcyB0
ZXN0IHdpdGhvdXQgcm9vdDoNCj4+DQo+IA0KPiBUaGFua3MgZm9yIHlvdSByZXBvcnQsIEkgcmVw
cm9kdWNlZCBpdCBvbiBmZWRvcmE0MCB3aGlsZSB1YnVudHUyMjA0IGFsd2F5cyB3b3JrcyB3ZWxs
Lg0KPiANCj4gSSB3aWxsIGxvb2sgaW50byBpdC4NCg0KQSB3b3JrIGFyb3VuZCBpbiBteSBmZWRv
cmE0MCBpczoNCg0KJCBzdWRvIHNldGNhcCAnY2FwX2lwY19sb2NrK2VwJyAuL2J1aWxkL3FlbXUt
c3lzdGVtLXg4Nl82NA0KDQpXZWxsLCB0aGF0J3MgaW50ZXJlc3RpbmcsIHRoZSAuL2J1aWxkL3Fl
bXUtc3lzdGVtLXg4Nl82NCBpbiBteSB1YnVudHUyMjA0IHdvcmtzDQp3aXRob3V0IGNhcF9pcGNf
bG9jayBjYXAuLg0KDQoNCj4gDQo+IA0KPiBUaGFua3MNCj4gWmhpamlhbg0KPiANCj4gDQo+PiBz
dGRlcnI6DQo+PiBxZW11LXN5c3RlbS14ODZfNjQ6IGNhbm5vdCBnZXQgcmtleQ0KPj4gcWVtdS1z
eXN0ZW0teDg2XzY0OiBlcnJvciB3aGlsZSBsb2FkaW5nIHN0YXRlIHNlY3Rpb24gaWQgMihyYW0p
DQo+PiBxZW11LXN5c3RlbS14ODZfNjQ6IGxvYWQgb2YgbWlncmF0aW9uIGZhaWxlZDogT3BlcmF0
aW9uIG5vdCBwZXJtaXR0ZWQNCj4+IHFlbXUtc3lzdGVtLXg4Nl82NDogcmRtYSBtaWdyYXRpb246
IHJlY3YgcG9sbGluZyBjb250cm9sIGVycm9yIQ0KPj4gcWVtdS1zeXN0ZW0teDg2XzY0OiBSRE1B
IGlzIGluIGFuIGVycm9yIHN0YXRlIHdhaXRpbmcgbWlncmF0aW9uIHRvIGFib3J0IQ0KPj4gcWVt
dS1zeXN0ZW0teDg2XzY0OiBmYWlsZWQgdG8gc2F2ZSBTYXZlU3RhdGVFbnRyeSB3aXRoIGlkKG5h
bWUpOiAyKHJhbSk6IC0xDQo+PiBxZW11LXN5c3RlbS14ODZfNjQ6IENoYW5uZWwgZXJyb3I6IE9w
ZXJhdGlvbiBub3QgcGVybWl0dGVkDQo+PiAqKg0KPj4gRVJST1I6Li4vdGVzdHMvcXRlc3QvbWln
cmF0aW9uL21pZ3JhdGlvbi1xbXAuYzoyMDA6Y2hlY2tfbWlncmF0aW9uX3N0YXR1czogYXNzZXJ0
aW9uIGZhaWxlZCAoY3VycmVudF9zdGF0dXMgIT0gImZhaWxlZCIpOiAoImZhaWxlZCIgIT0gImZh
aWxlZCIpDQo+PiBxZW11LXN5c3RlbS14ODZfNjQ6IHdhcm5pbmc6IEVhcmx5IGVycm9yLiBTZW5k
aW5nIGVycm9yLg0KPj4gcWVtdS1zeXN0ZW0teDg2XzY0OiB3YXJuaW5nOiByZG1hIG1pZ3JhdGlv
bjogc2VuZCBwb2xsaW5nIGNvbnRyb2wgZXJyb3INCj4+IC4uL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0
LmM6MTk5OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBl
bmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQ0KPj4NCj4+IFNvIHJ1bm5pbmcg
dGhlIHRlc3QgYWxzbyBuZWVkcyByb290P8KgIElzIGl0IHBvc3NpYmxlIHdlIGZpeCB0aGUgdGVz
dCBzbyBpdA0KPj4gY2FuIGFsc28gYmUgc21hcnQgZW5vdWdoIHRvIHNraXAgaWYgaXQga25vd3Mg
aXQnbGwgaGl0IHRoZSAiY2Fubm90IGdldA0KPj4gcmtleSIgZXJyb3IgKGV2ZW4gaWYgaXQgc2Vl
cyB0aGUgcmRtYSBsaW5rIHNldHVwKT/CoCBOb3Qgc29tZXRoaW5nIHVyZ2VudA0KPj4gYnV0IGRl
ZmluaXRlbHkgZ29vZCB0byBoYXZlLg0KDQpJdCBzZWVtcyBpdCdzIGEgc2VjdXJpdHkgcHJvYmxl
bSwgSSBoYXZlIG5vIGEgZ29vZCBpZGVhIHlldC4NCg0KTGV0IG1lIHNlZSBzZWUuLi4NCg0KDQoN
Cg0KPj4NCj4+IE9UT0gsIHJ1bm5pbmcgdGhlIHRlc3QgdXNpbmcgcm9vdCBhbHdheXMgd29ya3Mg
Zm9yIG1lLg0KPiANCj4gDQo+Pg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4+IMKgIHNjcmlwdHMvcmRtYS1taWdy
YXRpb24taGVscGVyLnNowqDCoMKgwqDCoCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrLS0t
DQo+Pj4gwqAgdGVzdHMvcXRlc3QvbWlncmF0aW9uL3ByZWNvcHktdGVzdHMuYyB8IDIxICsrKysr
KysrKysrKysrKysrLS0tLQ0KPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygr
KSwgNyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9zY3JpcHRzL3JkbWEtbWln
cmF0aW9uLWhlbHBlci5zaCBiL3NjcmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoDQo+Pj4g
aW5kZXggMDE5YjlhZDkzMi4uYzM1ODM5MmI3MiAxMDA3NTUNCj4+PiAtLS0gYS9zY3JpcHRzL3Jk
bWEtbWlncmF0aW9uLWhlbHBlci5zaA0KPj4+ICsrKyBiL3NjcmlwdHMvcmRtYS1taWdyYXRpb24t
aGVscGVyLnNoDQo+Pj4gQEAgLTgsNiArOCwxNSBAQCBnZXRfaXB2NF9hZGRyKCkNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaGVhZCAtMSB8IHRyIC1kICdcbicNCj4+PiDCoCB9DQo+Pj4gK2dldF9p
cHY2X2FkZHIoKSB7DQo+Pj4gK8KgwqDCoCBpcHY2PSQoaXAgLTYgLW8gYWRkciBzaG93IGRldiAi
JDEiIHwNCj4+PiArwqDCoMKgwqDCoMKgwqAgc2VkIC1uICdzLy4qW1s6Ymxhbms6XV1pbmV0Nltb
OmJsYW5rOl1dKlwoW15bOmJsYW5rOl0vXSpcKS4qL1wxL3AnIHwNCj4+PiArwqDCoMKgwqDCoMKg
wqAgaGVhZCAtMSB8IHRyIC1kICdcbicpDQo+Pj4gKw0KPj4+ICvCoMKgwqAgWyAkPyAtZXEgMCBd
IHx8IHJldHVybg0KPj4+ICvCoMKgwqAgZWNobyAtbiBbIiRpcHY2IiUkMV0NCj4+PiArfQ0KPj4+
ICsNCj4+PiDCoCAjIGV4aXN0aW5nIHJkbWEgaW50ZXJmYWNlcw0KPj4+IMKgIHJkbWFfaW50ZXJm
YWNlcygpDQo+Pj4gwqAgew0KPj4+IEBAIC0yMCwxMSArMjksMTYgQEAgaXB2NF9pbnRlcmZhY2Vz
KCkNCj4+PiDCoMKgwqDCoMKgIGlwIC1vIGFkZHIgc2hvdyB8IGF3ayAnL2luZXQgLyB7cHJpbnQg
JDJ9JyB8IHNvcnQgLXUgfCBncmVwIC12IC13IGxvDQo+Pj4gwqAgfQ0KPj4+ICtpcHY2X2ludGVy
ZmFjZXMoKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoCBpcCAtbyBhZGRyIHNob3cgfCBhd2sgJy9pbmV0
NiAvIHtwcmludCAkMn0nIHwgc29ydCAtdSB8IGdyZXAgLXYgLXcgbG8NCj4+PiArfQ0KPj4+ICsN
Cj4+PiDCoCByZG1hX3J4ZV9kZXRlY3QoKQ0KPj4+IMKgIHsNCj4+PiDCoMKgwqDCoMKgIGZvciBy
IGluICQocmRtYV9pbnRlcmZhY2VzKQ0KPj4+IMKgwqDCoMKgwqAgZG8NCj4+PiAtwqDCoMKgwqDC
oMKgwqAgaXB2NF9pbnRlcmZhY2VzIHwgZ3JlcCAtcXcgJHIgJiYgZ2V0X2lwdjRfYWRkciAkciAm
JiByZXR1cm4NCj4+PiArwqDCoMKgwqDCoMKgwqAgIiRJUF9GQU1JTFkiX2ludGVyZmFjZXMgfCBn
cmVwIC1xdyAkciAmJiBnZXRfIiRJUF9GQU1JTFkiX2FkZHIgJHIgJiYgcmV0dXJuDQo+Pj4gwqDC
oMKgwqDCoCBkb25lDQo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMQ0KPj4+IEBAIC0zMiwxMSArNDYs
MTEgQEAgcmRtYV9yeGVfZGV0ZWN0KCkNCj4+PiDCoCByZG1hX3J4ZV9zZXR1cCgpDQo+Pj4gwqAg
ew0KPj4+IC3CoMKgwqAgZm9yIGkgaW4gJChpcHY0X2ludGVyZmFjZXMpDQo+Pj4gK8KgwqDCoCBm
b3IgaSBpbiAkKCIkSVBfRkFNSUxZIl9pbnRlcmZhY2VzKQ0KPj4+IMKgwqDCoMKgwqAgZG8NCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmRtYV9pbnRlcmZhY2VzIHwgZ3JlcCAtcXcgJGkgJiYgY29u
dGludWUNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmRtYSBsaW5rIGFkZCAiJHtpfV9yeGUiIHR5
cGUgcnhlIG5ldGRldiAiJGkiICYmIHsNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlY2hv
ICJTZXR1cCBuZXcgcmRtYS9yeGUgJHtpfV9yeGUgZm9yICRpIHdpdGggJChnZXRfaXB2NF9hZGRy
ICRpKSINCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlY2hvICJTZXR1cCBuZXcgcmRtYS9y
eGUgJHtpfV9yeGUgZm9yICRpIHdpdGggJChnZXRfIiRJUF9GQU1JTFkiX2FkZHIgJGkpIg0KPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCB9DQo+Pj4gwqDCoMKgwqDCoCBkb25lDQo+Pj4gQEAgLTUwLDYgKzY0LDEyIEBAIHJkbWFfcnhl
X2NsZWFuKCkNCj4+PiDCoMKgwqDCoMKgIG1vZHByb2JlIC1yIHJkbWFfcnhlDQo+Pj4gwqAgfQ0K
Pj4+ICtJUF9GQU1JTFk9JHtJUF9GQU1JTFk6LWlwdjR9DQo+Pj4gK2lmIFsgIiRJUF9GQU1JTFki
ICE9ICJpcHY2IiBdICYmIFsgIiRJUF9GQU1JTFkiICE9ICJpcHY0IiBdOyB0aGVuDQo+Pj4gK8Kg
wqDCoCBlY2hvICJVbmtub3duIGlwIGZhbWlseSAnJElQX0ZBTUlMWScsIG9ubHkgaXB2NCBvciBp
cHY2IGlzIHN1cHBvcnRlZCwiID4mMg0KPj4+ICvCoMKgwqAgZXhpdCAxDQo+Pj4gK2ZpDQo+Pj4g
Kw0KPj4+IMKgIG9wZXJhdGlvbj0kezE6LWRldGVjdH0NCj4+PiDCoCBjb21tYW5kIC12IHJkbWEg
Pi9kZXYvbnVsbCB8fCB7DQo+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi9w
cmVjb3B5LXRlc3RzLmMgYi90ZXN0cy9xdGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5jDQo+
Pj4gaW5kZXggYTEzN2VhOWYyYy4uOWY3MjM2ZGM1OSAxMDA2NDQNCj4+PiAtLS0gYS90ZXN0cy9x
dGVzdC9taWdyYXRpb24vcHJlY29weS10ZXN0cy5jDQo+Pj4gKysrIGIvdGVzdHMvcXRlc3QvbWln
cmF0aW9uL3ByZWNvcHktdGVzdHMuYw0KPj4+IEBAIC0xMDIsMTIgKzEwMiwxMyBAQCBzdGF0aWMg
dm9pZCB0ZXN0X3ByZWNvcHlfdW5peF9kaXJ0eV9yaW5nKHZvaWQpDQo+Pj4gwqAgI2lmZGVmIENP
TkZJR19SRE1BDQo+Pj4gwqAgI2RlZmluZSBSRE1BX01JR1JBVElPTl9IRUxQRVIgInNjcmlwdHMv
cmRtYS1taWdyYXRpb24taGVscGVyLnNoIg0KPj4+IC1zdGF0aWMgaW50IG5ld19yZG1hX2xpbmso
Y2hhciAqYnVmZmVyKQ0KPj4+ICtzdGF0aWMgaW50IG5ld19yZG1hX2xpbmsoY2hhciAqYnVmZmVy
LCBib29sIGlwdjYpDQo+Pj4gwqAgew0KPj4+IMKgwqDCoMKgwqAgY2hhciBjbWRbMjU2XTsNCj4+
PiDCoMKgwqDCoMKgIGJvb2wgdmVyYm9zZSA9IGdfZ2V0ZW52KCJRVEVTVF9MT0ciKTsNCj4+PiAt
wqDCoMKgIHNucHJpbnRmKGNtZCwgc2l6ZW9mKGNtZCksICIlcyBkZXRlY3QgJXMiLCBSRE1BX01J
R1JBVElPTl9IRUxQRVIsDQo+Pj4gK8KgwqDCoCBzbnByaW50ZihjbWQsIHNpemVvZihjbWQpLCAi
SVBfRkFNSUxZPSVzICVzIGRldGVjdCAlcyIsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBpcHY2ID8gImlwdjYiIDogImlwdjQiLCBSRE1BX01JR1JBVElPTl9IRUxQRVIsDQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2ZXJib3NlID8gIiIgOiAiMj4vZGV2L251bGwiKTsN
Cj4+PiDCoMKgwqDCoMKgIEZJTEUgKnBpcGUgPSBwb3BlbihjbWQsICJyIik7DQo+Pj4gQEAgLTEz
MiwxMSArMTMzLDExIEBAIHN0YXRpYyBpbnQgbmV3X3JkbWFfbGluayhjaGFyICpidWZmZXIpDQo+
Pj4gwqDCoMKgwqDCoCByZXR1cm4gLTE7DQo+Pj4gwqAgfQ0KPj4+IC1zdGF0aWMgdm9pZCB0ZXN0
X3ByZWNvcHlfcmRtYV9wbGFpbih2b2lkKQ0KPj4+ICtzdGF0aWMgdm9pZCB0ZXN0X3ByZWNvcHlf
cmRtYV9wbGFpbl9pcChib29sIGlwdjYpDQo+Pj4gwqAgew0KPj4+IMKgwqDCoMKgwqAgY2hhciBi
dWZmZXJbMTI4XSA9IHt9Ow0KPj4+IC3CoMKgwqAgaWYgKG5ld19yZG1hX2xpbmsoYnVmZmVyKSkg
ew0KPj4+ICvCoMKgwqAgaWYgKG5ld19yZG1hX2xpbmsoYnVmZmVyLCBpcHY2KSkgew0KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBnX3Rlc3Rfc2tpcCgiTm8gcmRtYSBsaW5rIGF2YWlsYWJsZVxuIg0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiIyBUbyBlbmFi
bGUgdGhlIHRlc3Q6XG4iDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICIjIFJ1biBcJyIgUkRNQV9NSUdSQVRJT05fSEVMUEVSICIgc2V0dXBcJyB3aXRoIHJv
b3QgdG8gc2V0dXAiDQo+Pj4gQEAgLTE1OSw2ICsxNjAsMTYgQEAgc3RhdGljIHZvaWQgdGVzdF9w
cmVjb3B5X3JkbWFfcGxhaW4odm9pZCkNCj4+PiDCoMKgwqDCoMKgIHRlc3RfcHJlY29weV9jb21t
b24oJmFyZ3MpOw0KPj4+IMKgIH0NCj4+PiArDQo+Pj4gK3N0YXRpYyB2b2lkIHRlc3RfcHJlY29w
eV9yZG1hX3BsYWluKHZvaWQpDQo+Pj4gK3sNCj4+PiArwqDCoMKgIHRlc3RfcHJlY29weV9yZG1h
X3BsYWluX2lwKDApOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0aWMgdm9pZCB0ZXN0X3ByZWNv
cHlfcmRtYV9wbGFpbl9pcHY2KHZvaWQpDQo+Pj4gK3sNCj4+PiArwqDCoMKgIHRlc3RfcHJlY29w
eV9yZG1hX3BsYWluX2lwKDEpOw0KPj4+ICt9DQo+Pj4gwqAgI2VuZGlmDQo+Pj4gwqAgc3RhdGlj
IHZvaWQgdGVzdF9wcmVjb3B5X3RjcF9wbGFpbih2b2lkKQ0KPj4+IEBAIC0xMTg5LDYgKzEyMDAs
OCBAQCBzdGF0aWMgdm9pZCBtaWdyYXRpb25fdGVzdF9hZGRfcHJlY29weV9zbW9rZShNaWdyYXRp
b25UZXN0RW52ICplbnYpDQo+Pj4gwqAgI2lmZGVmIENPTkZJR19SRE1BDQo+Pj4gwqDCoMKgwqDC
oCBtaWdyYXRpb25fdGVzdF9hZGQoIi9taWdyYXRpb24vcHJlY29weS9yZG1hL3BsYWluIiwNCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVzdF9w
cmVjb3B5X3JkbWFfcGxhaW4pOw0KPj4+ICvCoMKgwqAgbWlncmF0aW9uX3Rlc3RfYWRkKCIvbWln
cmF0aW9uL3ByZWNvcHkvcmRtYS9wbGFpbi9pcHY2IiwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdGVzdF9wcmVjb3B5X3JkbWFfcGxhaW5faXB2Nik7
DQo+Pj4gwqAgI2VuZGlmDQo+Pj4gwqAgfQ0KPj4+IC0tIA0KPj4+IDIuNDEuMA0KPj4+DQo+Pg==

