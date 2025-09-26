Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709A2CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 03:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1zLl-0007di-SM; Thu, 25 Sep 2025 23:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1zLf-0007cz-Ix
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 23:42:21 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1zLK-0000UL-Ai
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 23:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1758858119; x=1790394119;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FutuAz5qmcEeDJBfb1vBf6cyetNsQqZpqJy7MPIy4Ek=;
 b=Ey0t8loqFQIr8snElBFGXmmRDvDpc5+tj/L2+8fFfFtlsrKfrDJzA7Zu
 1iPWzD5ILCOWIrEqluMjktXCTdUrejmN4wyWlD+WJCLbFA17cycWo6mWo
 pFp8opnUet8fFnw4h3UTyKmucqMewKRNbcA5cYe7JUfhGS/xOhJMQhmmu
 xQTiomb5orByPERBd5ip65UHTLsUlRsXijfSSpM1+qh9UeN+cDCyBl44i
 W0eAx+sO6D6eUV4i+KqkZjthwwgYkEwSBmcZEsgQmPbuZxMjOmjqVaL8c
 doaOYCiVI6iacv2u81F3GfKDyAoOfq0SeVVxdbNkWAwWsgLb6qKvsgEja g==;
X-CSE-ConnectionGUID: ztdLM0cORaWKnYzG81W6kQ==
X-CSE-MsgGUID: jRx34EAZSbCBWFnGFtYGqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="168412864"
X-IronPort-AV: E=Sophos;i="6.18,294,1751209200"; d="scan'208";a="168412864"
Received: from mail-japaneastazon11010065.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.65])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 12:41:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZUaY6cKH2sQF4hQrRK3bx4kJy1AGXhj2cw/QE+5gEuloAV2TDAxmVnc7gTU4Pv6T8pgFs8bXqnCiJLKSpm3X6qAiQgPruKNl6omazb4+rMYxGaDYiYxCnpwJHzzHTgwiD07Vd0izSp7bKs/0Mp6W6bgugKetZq0OIaOvZubulL0hQUG9jc6Gw+TPk+lCLoeurt2uRcgkQUYpISZd5CWH8HTdhm54aLnWbdPMbdq1PxJWIyiVOjbKj+3Lm3HCU8VlarXnvtNa5B3AM1wSLNNrOWoOMIG7NHtA6LgtTE2LsY25Q4TfigMMr4mzUG8KRrsP1bCCRdC6KUNyuzxqytbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FutuAz5qmcEeDJBfb1vBf6cyetNsQqZpqJy7MPIy4Ek=;
 b=x36c6Ypqfu+xw1+f3214xOqpX00cQNPMkBBPJkCVy0L4Yx6mtX8ulj22n1ZFa9rvppkP3Oi/wVABOTB8HbL5efB/+0f4LTlU01lCCfu1OqJAfe0Awb3myGjtzk3zbLUYrimzFtMkkHVQGOOL1Nuzhljf7EBLuwVEjUysQusdeV3p7VvCs8UKpoFPC7yQbdCCSwdt3SpEqeLPDGUY89ed1mvOHAPnIPDEeGTZhcUH9XgTWjZRUixkahvulOSdSyfwuHPfkCHYjn64srcKWpAjrfxBzLVSliyQ5D1uc0ODlzRlDHYJqDgEFBJrz7DrK4jg74N3j/olgE11ytYX67aMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FutuAz5qmcEeDJBfb1vBf6cyetNsQqZpqJy7MPIy4Ek=;
 b=K+3/uKdg0pQbSdv58tSUUi19wlxKIibOXD16t3gYZEuaPOSqItMekUSy3QUBmqM0ZGX3YI6ojQWm5KOP07fB1h/nj9bh4ECiNaQiudY/WpjJ8yVIKl8T9K01fCLQV+Ztb5wKAhRDs2u/ojFA6Ck5uXYowZxEMZDzcbKvipnqXKY0qZeb3WFRj7Bx7kWfTdwB/e6YzyOsuvi2ZJUID48gmEd4kUWjK8gXr9BoJOh7f4djFqH4o3wlOTxh5+t96c9Stu5x7eqe8UP+hqz5AabVlfBkV+Q8D6Ls1dvE1Br95kDFZbvNa7RXux14Uv3t8l3VnotPQ7ttJMcbbANUiSyQlQ==
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by OSZPR01MB9614.jpnprd01.prod.outlook.com (2603:1096:604:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 03:41:42 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 03:41:42 +0000
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
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
Thread-Topic: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load
 process
Thread-Index: AQHcF5WU8XXaZaJGSE+7ZHKFJnewV7Sk/8WA
Date: Fri, 26 Sep 2025 03:41:42 +0000
Message-ID: <ac9d95ef-f9c4-4cf8-bccd-6fce9e49e702@fujitsu.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
In-Reply-To: <20250827205949.364606-6-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|OSZPR01MB9614:EE_
x-ms-office365-filtering-correlation-id: 44910c0e-eb1d-47a5-e5e6-08ddfcae9bea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?aXpVTE1WMlh0VWovTzF4UW5ZNXZVdkFCWFFSOXIrMVZraWFlSjdXdDlCalh5?=
 =?utf-8?B?UjllaGpiVWpYQitYT1YxTWxKRGgrTWR1N2kzMS8zSm1BcmU2NitFcnBiMitx?=
 =?utf-8?B?Zm1LcU9NL1MzZWNXeUxrOXUzcGZTRURwWkg0VjlVOFFrMjFmbklyYUVKOVF5?=
 =?utf-8?B?Y2V4azhoWmhhVkFVS0FsMTRkcWhNT2ZINVJNbC9YcjdHT2J4bEhjRnJPSkI5?=
 =?utf-8?B?dHRmTzRMZTlFaC9SUEc0dkkzbUt2bjZCclYzVVh0azRvbzByV29nVHo0aDg4?=
 =?utf-8?B?TzlWZGlPb09ia3pyZXByMkpwVld3TGRGZEdKNUtSaFl1OE9IL0UrRDFTN29s?=
 =?utf-8?B?QStDTkVTdWRiQzdXb3NiYklMdjhSb2ZjZTlrb1J3NytRQjBrWGUwRUxnQ0Zi?=
 =?utf-8?B?RGsxc0lQVkFHVTZCQ3RkRU0zdDFoNDRXcDgzYStxcXZSanlCRUR4V3B5NzYw?=
 =?utf-8?B?QWRxRnc5cDQrYlQvVGdXNzd0Wlk5MWJRcmEyUTlxRnJOT3hXbFZUM0VmNXEv?=
 =?utf-8?B?eDMwYmlTQWhxTm9oY256bURPeE9lSCsyZVBsN0FaY1pCSGI4SThFRzZEY3Bt?=
 =?utf-8?B?V0ZLMWJNa3Njem1Zc0p5R1RncGdCUWl2RGRsMlRLV2dyaWdTUWt3Mnl2Y3hF?=
 =?utf-8?B?dFBYUGpyNjg1WjV3V0o4UVBWT0t5b2lsRkZJbWhsT0VkUHV5RUpoUStuTWtI?=
 =?utf-8?B?QXFtYm16dnd2WUIzM0RUT291ZitNSEh3MWh4bHlmb0pzZWNlWjhOWHZkV01z?=
 =?utf-8?B?Z291eXpGY2E5UHhSQmt4TEVSMUVHSnBpUkRwbmdSVVRHbVFVcm5DSURONk91?=
 =?utf-8?B?Z0FBTmZ4WmJ0WE9hRi8rMU53WUppNzQvbzdRRFRSSk8vcDlOK2xrZ09LdjVz?=
 =?utf-8?B?Z0NTUngxYkJmLzBzQ2xWVVZlNXlrc1dLMUNkSXhYMlMvOFJkOVBSc1k4TURy?=
 =?utf-8?B?LzFpUUxIanB6dUVRcW5NTmNnOWVvb01ob0kwYVBpR05LTTJWQXRZQ1Y2T2dO?=
 =?utf-8?B?OVVPNU5JamtFL3crMHZIZXFpNkdiNzQxWU5VQW9za2V3UnlRTkZUZE1GblVj?=
 =?utf-8?B?dUYyL2J1UEVGdUc4c2JzVHFwN21TZENLczl5ODk1ZXVZN3JlcUVlRkVBc0xa?=
 =?utf-8?B?Q0dRbFQ5eDR5dlY1U2laMHJPWFB3cWlONzBNNkVsWitqOXBpUlNZNExMZjBt?=
 =?utf-8?B?djFDWDNUTmhsK3hhbTZkRFpIMkt2UmF5L1l6WkUyTEZYeHRoYVlSM25FaC8r?=
 =?utf-8?B?VWZXVjAxdUpFOGVCU0RtNU8rdGNvYnhZOTNpQXhjenZwOG80bEsvemJ1VUpX?=
 =?utf-8?B?Q0RuWDgxMDFsdlNKenQ2a2lyWi9HTlppNUFsL3pxcVpXTWNoNjdndytWdDg3?=
 =?utf-8?B?ejZjN2VpYkpSWVpSOUREb3hySTdPRTlJQVBJTXBCa2RZc1RWcmFlNHVoVk9R?=
 =?utf-8?B?S0FROE5jSWZnVHViV1NUQTIwM0dhbmJBRnEzampQWVRHVHRiOFg4MnZnZkhl?=
 =?utf-8?B?QjhhUkQ4eHhHdmVISVB0eERKNVk1UVh3bjJkWm1WZ2xyeTFUVGczeE5kRitH?=
 =?utf-8?B?UlRVbnBhWUpjQXpHczUyR25iV0dPdzZoR3Q4UytJeVl2TEZpYnd3Um5Rd2Nk?=
 =?utf-8?B?MzVHNWZDL2RpLzlQRkJSNE4zV0lvdXQ2b3hBaUZxWmNwZm11LzVOaDVyaFR2?=
 =?utf-8?B?Q3JiMDEvWk1EcVo2Tk80c01RTUVFTGlNeEU2VEFpZURHTnVuSDdVYUFWY1VD?=
 =?utf-8?B?OEVSdlBFdnNjN3NnbjN2TS9pWnV6eWt2WnNCNkJTdGZ0OUx4RitGeFNNbnFF?=
 =?utf-8?B?ZDdsVE5Cb0c3VCtUNVU4TlkrbHVITTJjK3R5amMxbUVnTjE0UTJuUHZZeXRE?=
 =?utf-8?B?Wm52RklZSzJLb20vUkdlWlZPb1E1VXhGUXFEdzlMVER1emw0Uk5hMmF0UzA0?=
 =?utf-8?B?NFNpMUtISEp3MmRENi9DVnV6eDFUdEwxYjMrMDBrVnFXS3prNUl1QjQ1aXk1?=
 =?utf-8?B?NDN1TFdEMGxNNGdqbURldDNMUXlSdmdZaWE5YVZWZ3p5YTQ4UDlTOXMzWE1r?=
 =?utf-8?Q?5fhgaB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSCPR01MB13050.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUk4dmMzSkVaZkJOc3ZBd1gxNkk5OC9MVUJIYkZIYnQxYUkxM3gwcUk1Zi96?=
 =?utf-8?B?Y1ZXbG5jRm8xQnc4R0tmeCtXVHhIRFVzamV3QVFHZjYvT1dtL2xQVHY1Slkx?=
 =?utf-8?B?c0ttMEVRVHZzNjBMUDBTeDgrVXJFdWovcmpDeC9sYTlWTGhRbjFLUWhtUkUz?=
 =?utf-8?B?ajF3cno1YVhCVHU4c092TEFGTE5oSVhBc3plUlh0YVI3N2laT2VSSFZKaW9k?=
 =?utf-8?B?MFhYWlNvK0VPT0Z5alFqczVFcHgyMmhNZ05YUTBVU2hTT0hFQlAwZ3BIOVd1?=
 =?utf-8?B?RjNDclh2NWNUcmVZNTN0cjI1ZE13Q1lrTkQ1bVVZMzBWdWR3RjdjZ3VVMy9u?=
 =?utf-8?B?aHFZN216S2J4WWZvbTVldGcvN1NlVmI4b0s3bzc5QmluM0phZjNmZ2orN0Zq?=
 =?utf-8?B?ejgvWGNZNDJxNGlVczRmTmdZZ2dkMTZ4UTBKdUF2ZzFrVHRmT0szN1RxdWVW?=
 =?utf-8?B?cXFEUEx1ZGhXeHRTWDkvR1NuVW5QYUI4NTUzaEtsTzZzWUVGMUVhVGRGTi9Z?=
 =?utf-8?B?NGlwY0xIbnc5UVJ3UVp1Zmc1bTNmaE9zZUh6NG5WbHJpa1cxQm1kYms5d09r?=
 =?utf-8?B?OEdoaDJ6ZnBLeEtEb3RncG1ONjhMbVVNQkFTYVlzVHYvSmVuVWJYOFNwNGNG?=
 =?utf-8?B?QklZSUxjT0QzMVRkcmVqaC9pbUtheWNRSnRwM1ZjT3NQc0xoZGZPc1BqMDhB?=
 =?utf-8?B?RkJ1V1RnejJUY1VjZU1BeU9hdWVPd0VjTms0ZmcveGVrR3dGSVN1NE9KaDBr?=
 =?utf-8?B?OEZRTVZtNy9HeWxUNnFKYWgrWDA1WWt2R3J2Z25oemNvdHlBVVQ1eFdJUGRk?=
 =?utf-8?B?Q3lXcVJGa0NLTXQ0dnRjaHNOV3YxL0pvWWw2ZHJVUVBWM1BLMEVOZ0kzZ1NF?=
 =?utf-8?B?cmhmM2x4UVkwdVB3a082cG44V1BubFlwUU5HUW8zdXp1SVUveWNyTHRpOVFh?=
 =?utf-8?B?ZDBicktIRFBINmdmNzhBbTZiMUQ5bmtCTVdCLzFLR3hwYU9Ea1B3MUg1UjVy?=
 =?utf-8?B?M0plZUhEeDRiT1dtaWlzb0kvTzhzaTJMYmhSbGJwSExaRjlWMG1sZDZoMnk2?=
 =?utf-8?B?MUYzSWJiRFdRcGM0Vlpvc0dmMEVCcHg5dldJWWV0dFYvYWI1Sk9udS9xa0pl?=
 =?utf-8?B?djZlQ054cVFNZ2diUHBJb2NzaHorWEJScUFvRGtWenJidGdQZUVUOXBFSkJj?=
 =?utf-8?B?K3NHajIzdFJ0NGZOY2FDdWdBTDFlVU4zSTZFcUF0Q1REM29tVG1aWlp5bkFx?=
 =?utf-8?B?L1hKM3FnVkNKa2JDYXBqOTBoU1daVHZJN1VEYTVlRHNjRzE2SHZHZVV4V2lo?=
 =?utf-8?B?VHJCMTVKNmt6YlRLOVYvUUhSTi8xZ1I1U0VPb05iMVc1KzloQ20weGRHaXVx?=
 =?utf-8?B?K3k5V2dnQ1RLdVEwVXJwa3A4cmgxdW5sUGgzWEVldk5SZnpBeDIrTzVwRGpt?=
 =?utf-8?B?a1FZZzNRK2syNk1wVFdZQXF4T2RmM0g2aElnMWVaNDRWdEpBclQ5NzdWSTJy?=
 =?utf-8?B?WllSY2NNVkNpRFZoUE51d3Q3TENIQnFKUXpsbDI0UUZQOTd4WmJaYkN2Tkgw?=
 =?utf-8?B?NzloS1hTdVlZcXh1THdrakphY2NpdldPV2RQdHhibUhaK29IK2dMNUYzMEla?=
 =?utf-8?B?djUvSmoycnY3NjJqUXdPRzhNSGU5Wmt5bm5XaTU0Uk5qOVN2VzlhRlRteXNV?=
 =?utf-8?B?VEgyVnV0a0lMQm94bDV1MGhuMlB5eUM1Q0FDTDFuWU1URWI4Zk9pNktqMkI5?=
 =?utf-8?B?YjhPZUR6V29qOGJqWDhXeTFFZHdWTkU1Q0RjK0NXRm5jbnpZU0JFT0JWWUh3?=
 =?utf-8?B?WjJWcFozeU03Rm5vN3lheU9YV3MvdHhSNzJsWmVuUThtcGMyUUU1ZHhOZGVX?=
 =?utf-8?B?b09va0tTbnZTVm11Sk9ONGFKZ0RSWHlWVlRYMUJzcHAvQzl3OE5lZndjSm5o?=
 =?utf-8?B?L0cxTk15NGlucGNFZDJyU0wwaGluL0xSTTd2ZFY3cjNYRGFMWm15eWxzbmZj?=
 =?utf-8?B?YWdYMkZleis2N3hKRzBpMnB1R1hlYzNRRDd2aFRxc05HeTA4SG1CZm5OWFo0?=
 =?utf-8?B?Tmg4Z012dzA5MTlzRUVJVDhOczhWOXNoVlliWlQ4V0hoMkU1WWppdUIzdEVT?=
 =?utf-8?B?R3gzQ3hkeUJXWWpRbnlReHFNNmRsaUFVU3NqTDc2cTRJa1dLa20rM2d6aGpD?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <633E567759633F429016036024EBE884@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r8AEPO2YbWNkFrtqRryos35dyRm6nffE2kaJ9/Evsv427hM61Uu11/RqvisXvZ5WJM46XVzwMvuDYTpeaGuFhaQxGVasYX3PZdcgm7nWuaaC3mfRPUBIMzIj7iZs0zYvVD6KtPD5P7UQrxApqoLag9ReRJM6QtQ979Wee1g3jT8/+TXw2l+UKsPDftcGVosf0ul0SYLS8SeO9N2k4a9Ui2ghlLVjykza6QvIUfHlwhsMMlX6MCEaxyiNGaAvLihfO5JdkrgVkXP/6m3Y9eEVmYmIJZ40KPo4zuMavxrfqhmSzHmRn3iVfterUu17nrewcrmq1UvFzWIvpjI841oYua/agq3zGTzakdknYLZNgMQwmMlm752As8A0B55xx2267a4RZvOVBfzrRdMN87mGTU3sHRHDYKae7V60d8y3XeUg2FbLPgXAcTF2eP6K/mdQuyYnZsKA+jX4i1knUTBHdqndMWjZGc0Cm0srBNxdoP9XlseQC8seucGc0UcKB6LHP0Yg8hvzoC0WI5+6uNj12g8mZdoC3ja07DWbkLn8rEd0A3+nnXxHBukqTb5XWdbuIlE2LmpTo/oVRSSgn4kJg++oOdu3f7Ze7kjDDKLYugHw4iqzLqKdnkIQGRb56jhP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44910c0e-eb1d-47a5-e5e6-08ddfcae9bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 03:41:42.6407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGHEbC+EAv20Hhn55WWynfyM37KiTm+6bxfVxDIgjNlY/827A47Y22x5JyaKE5LE6Xlk3YOb5FD01m/sFrPEJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9614
Received-SPF: pass client-ip=216.71.158.62; envelope-from=lizhijian@fujitsu.com;
 helo=esa19.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDI4LzA4LzIwMjUgMDQ6NTksIFBldGVyIFh1IHdyb3RlOg0KPiBkaWZmIC0tZ2l0IGEv
bWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4gaW5kZXggYmNkN2FhZTJmMi4u
MmI5OTU1MTNhYSAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuYw0KPiArKysgYi9taWdy
YXRpb24vcmRtYS5jDQo+IEBAIC0zMDY4LDcgKzMwNjgsNiBAQCBzdGF0aWMgdm9pZCByZG1hX2Nt
X3BvbGxfaGFuZGxlcih2b2lkICpvcGFxdWUpDQo+ICAgew0KPiAgICAgICBSRE1BQ29udGV4dCAq
cmRtYSA9IG9wYXF1ZTsNCj4gICAgICAgc3RydWN0IHJkbWFfY21fZXZlbnQgKmNtX2V2ZW50Ow0K
PiAtICAgIE1pZ3JhdGlvbkluY29taW5nU3RhdGUgKm1pcyA9IG1pZ3JhdGlvbl9pbmNvbWluZ19n
ZXRfY3VycmVudCgpOw0KPiAgIA0KPiAgICAgICBpZiAocmRtYV9nZXRfY21fZXZlbnQocmRtYS0+
Y2hhbm5lbCwgJmNtX2V2ZW50KSA8IDApIHsNCj4gICAgICAgICAgIGVycm9yX3JlcG9ydCgiZ2V0
X2NtX2V2ZW50IGZhaWxlZCAlZCIsIGVycm5vKTsNCj4gQEAgLTMwODcsMTAgKzMwODYsNiBAQCBz
dGF0aWMgdm9pZCByZG1hX2NtX3BvbGxfaGFuZGxlcih2b2lkICpvcGFxdWUpDQo+ICAgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgICAgfQ0KPiAgICAgICAgICAgcmRtYV9hY2tfY21fZXZlbnQoY21f
ZXZlbnQpOw0KDQoNClRoaXMgYWJvdmUgbGluZSBzaG91bGQgYmUgcmVtb3ZlZCBhcyB3ZWxsLCBv
dGhlcndpc2UgaXQgd2lsbCBjYXVzZSBhIGRvdWJsZSBjbV9ldmVudCBmcmVlLg0KDQoNCg0KDQo+
IC0gICAgICAgIGlmIChtaXMtPmxvYWR2bV9jbykgew0KPiAtICAgICAgICAgICAgcWVtdV9jb3Jv
dXRpbmVfZW50ZXIobWlzLT5sb2Fkdm1fY28pOw0KPiAtICAgICAgICB9DQo+IC0gICAgICAgIHJl
dHVybjsNCj4gICAgICAgfQ0KPiAgICAgICByZG1hX2Fja19jbV9ldmVudChjbV9ldmVudCk7DQo+
ICAgfQ0K

