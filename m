Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8645BCAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 03:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1zIG-0006mu-1Y; Thu, 25 Sep 2025 23:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1zIE-0006mP-5R
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 23:38:46 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1v1zI5-0007yS-DQ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 23:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1758857917; x=1790393917;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0Sv8lcN8BhudlJqVKWZOhIxZCHASocYbRy2GNBEi8HE=;
 b=jHsZxRd/6LIpuwMvSgJVDDjD65Eybp6x7Sv0LI7zOjnGBsNsZ2KWT7Rr
 DjyKlnage3jFOpsy7wU1TG+iLuE7TkbETMiCnih0/oAQ+B+F6UFW5Txla
 xrCaW45+wJAypW1AwD3u50Yrgch77uhBuZzhrXnNU5Qa1X62n6sAaewCq
 pG/7PyQPHLFXEuroXU1oRkKzGELbavLR6K5r8ZAnVv0dm/lXMELKMPul/
 VIDnH/y+zwZGzH3TSpQ1hm5JwGWuQvX+njIXCSIxCReu5c2pO4anrdRwT
 nIvEB51ziTzIQ8JN46fFD6y6FDyHVTRhjaB4IrfLLDkEL/dWZVg5UJMvd g==;
X-CSE-ConnectionGUID: qTC1V7KxRZiSygkP9U3AUA==
X-CSE-MsgGUID: jKfkzSM/SdGO7BiUHc3l+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="168988321"
X-IronPort-AV: E=Sophos;i="6.18,294,1751209200"; d="scan'208";a="168988321"
Received: from mail-japanwestazon11011064.outbound.protection.outlook.com
 (HELO OS0P286CU010.outbound.protection.outlook.com) ([40.107.74.64])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2025 12:38:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7be7fUdvCFmaLFJqvKKuFHgVL6ou7/CouaB8k/6FxIDNaJW0QKI3XTQkNDoWcwJd2nhuKAxAEd3/GGLRIrJawX0d0ssH+DvcHcNxbp5qVHOMIagqfYFDFJPCCoyEVFR31cOyhRo9g5JM92Vm/7cRlE+8EhnV3DwUKRSu3rzUcfvUJr/EmTdu23c+f5iIsoqy1iCuhNNvI1HgBbHRBf5dYpLQMxg29Gq+i3sNWZKAC41BeZ+ILf2cuN6W26hf8PZgoNRGlUW4s/RV/R3xugNpC/6ULb4vtEUYFYzTbhy2xXNOwNSz9AoihOfaKSRT+aXHCylctfbLgDN+FFLZSCKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Sv8lcN8BhudlJqVKWZOhIxZCHASocYbRy2GNBEi8HE=;
 b=UfLJrgjHd5fOHHop8xCWdDZ0AcR2guOAvd5N1uBt8/rhsqy46opaMRcbD4VLl+hF85WQsphzBvbWp4kxGlC5Pjl1X3Y83p9zEDLZVICFaJqUszTSQtR3n3jYJyuH5g52IasBJWo3sX7Y6ZCYHo17LtEZu2jjqxxZvpv4X+f4ThuDhYM2eWZegsfMpywdsSu39yuGatOWWkx6M7nj1Sg+2yf9Ycp4fod/6p7zahBqE0blYxFd9qLaGJV2vyHFhysQsfGys3sBXg42EWSrdyvOydMaWdKpzDxlSynv2bn1FVwqokG5YlS70j8WAMxziTB81JXRiCnRDZgJ6HIV21H8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Sv8lcN8BhudlJqVKWZOhIxZCHASocYbRy2GNBEi8HE=;
 b=gPHthidOkDwXIwZHURxFPVta5HQuCt4OO8bAxypUKkzTl8QDLcSxstV/WitNuLbPVM4TiKUFlKCo7vIr+y946yHzv/RPSuRM6cHkpPcwrjVbZmvmSa/IkIygAEVB7ocHZ/551ENuRgb+z2X7vTI42J7H6cep15LBlW753qWdVFah8dczVEblR75QCGKfwuoWKi1GEkKBGVbtnhXWiAp7VULejQYrSEkedetC+k+YnK1ZPd7Uul3GKCDnShA6V9zMNauAB+RbN9IQsPIqjQirU0f3154wFgxTtAT/RKSZk2RQdcXln+kJHrKPI26uNYq6gkP0a97gCuWKxCxS+ZU7HQ==
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com (2603:1096:604:330::6)
 by OSZPR01MB9614.jpnprd01.prod.outlook.com (2603:1096:604:1d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 03:38:21 +0000
Received: from OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5]) by OSCPR01MB13050.jpnprd01.prod.outlook.com
 ([fe80::a874:ac57:8f02:c2d5%4]) with mapi id 15.20.9160.011; Fri, 26 Sep 2025
 03:38:20 +0000
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
Subject: Re: [PATCH RFC 9/9] migration/rdma: Remove rdma_cm_poll_handler
Thread-Topic: [PATCH RFC 9/9] migration/rdma: Remove rdma_cm_poll_handler
Thread-Index: AQHcF5Wa9i7HCGnZ1E6mi9jnU4B62LSk/tSA
Date: Fri, 26 Sep 2025 03:38:20 +0000
Message-ID: <0f24a1a8-42a5-49da-b528-7cec68063864@fujitsu.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-10-peterx@redhat.com>
In-Reply-To: <20250827205949.364606-10-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB13050:EE_|OSZPR01MB9614:EE_
x-ms-office365-filtering-correlation-id: 1168508a-2514-472e-2536-08ddfcae2395
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cVpmV0RNZ0laczNQS0RmajRnL3RrVm9wNS81RmtYVUVNeHRMKzgzZUZsZmZo?=
 =?utf-8?B?WnNIR3c5WkdSL0JQTEhPSENwcWxVRmxkNlZ4MDVSMHF2U0tjYnZOTjRERytw?=
 =?utf-8?B?bTBQMnUxZ0NQT1RjdjRDR2RhMUJ5SzVCcmxHOHZwOHFUUmhVbDFxMWVsdk9E?=
 =?utf-8?B?U2toVkNxSzY4SzNmY1VxdnhmVlpNam95dU1DTHNjek1VZnY3VnpGS2MvZ2F5?=
 =?utf-8?B?aVRmMjZMc2h5Y3YzUUlFZGg2eGZEZjJhMXNFcE1MWG9jMVhoVmVGSmI4RytV?=
 =?utf-8?B?WEwzcVRZUC9pSnpUYnQvZWRwVG9JWXpsY3FYd0pxbEFJUXNkeFJ2WmN0TGU2?=
 =?utf-8?B?QnphY0U3c0ZMQTFxdGtTc05XTStJTFRFektZc0hzRHUwakgyb0RkeGVGS0J5?=
 =?utf-8?B?TTZUUTFYdXhTKzVZby9aeEJKZXliZkVod0l1T0tyRkZhSXFRRWEzOW5iM2lO?=
 =?utf-8?B?aXlEVkhIY3g2SU1Sdm1sQ29HMFVtU0Ura0RsQjVaQWhjc2diWHcyenIydzRi?=
 =?utf-8?B?VkkrdkxZMkFBL1pnSGRIU1EraUVtWlFkTzlLWHlNYnh6MVNwcFVyQXpKQUwr?=
 =?utf-8?B?ZTdVQ1R6bU8xcW9kemF0T2c2dDY3L0duVHkrYjVZa2o3eVh4Wk5TTlZKM3VO?=
 =?utf-8?B?cS9ZcmY0RSt2YXpPSXRkZDhnZm5XWTlBMCsyNStHbVovZlBsQmdIL3M5VDMr?=
 =?utf-8?B?Z3lobFdPbzZsRUJ2MHM0eXdyM1JLMUw4UjcyZWtld1pCRnVsc05GWG94am5Z?=
 =?utf-8?B?VmVDY2xJa3dnSGxON2tsMzk2b2lhLytOQUFMWWZ0RUxDcnAvQUdDMkhJaEpl?=
 =?utf-8?B?Q29iRzYwWEIvTStzanF2bXMwUFp4TVJaQkEyemh2ZXVOM2JRbFI2d3hQKy9m?=
 =?utf-8?B?Z09yU0NnT0JxOEJRSlNpakxpRVVaOVA3aGl0dTY0TTBqcHZqNHgxb3FqSnZw?=
 =?utf-8?B?L0E5WlNmYUVpQTJWdnVGMGprM01Uay9reWNubk94MXhNZ2w5QnRhanNKM0hU?=
 =?utf-8?B?NklhcVZWOEZyRDJlYzhzek1mSldYek0wc3k5SXJpN2pGRVVHL0tYU0crd0Ra?=
 =?utf-8?B?ZUtOeWdkTjlGVkJHQ1Q5UUh5RURHczU3K2Vaa3JQSjdFdFVFZUhJV0V4ZEJB?=
 =?utf-8?B?TnZsM1IzRGN3S1ovVTh2R2lKam52QU91NjN2OVU0ekhDdnNtUVhmdjJLYm0r?=
 =?utf-8?B?cTZOT0tmakJ6Qjd1NjNIQnNvSzEySGpLMm9TS2FNeXFJZHkyUHlkdkNsWDlp?=
 =?utf-8?B?KzY1RUxveEtIR2RKNmtuVHpXUmw3N2M5TjBFNit5VFJtZEhtYWYyR2FFNkxG?=
 =?utf-8?B?RkNyUWR1TlRxVWU1Y0YwOVFIQWxFWW5rMUxUa05VUm55ODRMY0RPTHdpclVk?=
 =?utf-8?B?OGZYRDhaVE1JSHBVekhPRFUwM0FQNittZTJNM2F3USszV2twSG53ZkpFK2pL?=
 =?utf-8?B?ZldnUWthK3EvQ0tlVVVVN0MxQ2FtT3J3RlNVdEVjYWV6dWpDVGppY2grSHJv?=
 =?utf-8?B?RHcxNnk4VTFFdE85WDYxaVErQWFCV0plZjFKelJZamIvVTY3S2Q0TlE1OWIz?=
 =?utf-8?B?UTBYZHlSWjlkVzdtKy9kZ0hrKzdGU1hHMEZkTUN4d1NDMHNjNTZmWk5zUTRy?=
 =?utf-8?B?MkFlQUpPRFFsRnJVMzkyNWZsdGM3VGhCUDNlTFRsc0IxMVIrNW9zV3o1Uy92?=
 =?utf-8?B?bDl1a3lvazJkYVVHanlWbHlVNWpGd3dWcEw4RWQzWjI1WVJLRnJMdm9CRXZM?=
 =?utf-8?B?bE1rbVdDM1lhR0lObzAxNSs0N0dvWmV2b1YzSUtsS3RPRHZlSzNnUmhPcjVq?=
 =?utf-8?B?NWF5T3pPR2F6WHcxMlRPNktlaFFmdWN4b3h6QlkvOXNqUys5SVdnSjBERjZU?=
 =?utf-8?B?Tk8xZ2JXYXdrcGZ4eGMxb3JFbFZVeExqUExFSkdDYkl6VG82ZityMnViS1R3?=
 =?utf-8?B?ck9DTFNYZWVWaDlScERkZ0NoSXdVbEdRRzBBNWRJaTBxSDdpdzJVY0ZkbXVW?=
 =?utf-8?B?NHgvczFJRGppNXNyVUZoREhZMm1pcXlQb1JzL1IzakxFd1RDMzFPTFl2SWRI?=
 =?utf-8?Q?Y/An+W?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OSCPR01MB13050.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFBKN1JEOGZFck81S2JQVUZVaTkxa1k5Z0pIVHVEdkdSZ3MyTDg1eFNkcmIw?=
 =?utf-8?B?dTVVL215WlMwZXBzN0xUUjFIdHI3QXIxeWZsRE1sWjY3TERYSkRqV0Z2T1Zk?=
 =?utf-8?B?Q1Z5TlRiNFlFMU9hUnBBUm1WcXQ5ZHY2R0hHbkJtdS9PY3VWdTM5czFLUElX?=
 =?utf-8?B?WDIzRkFxaHVqK2t3aDJwcU9YQ2RIaGVzbzNWcHNuSW5QeHRPTUQ4TXZJakt6?=
 =?utf-8?B?aU1uTHpHOGZybUI1VlRIWVZZN0Z2RGJCWlZjbFd6aXJ3WE40VlpvL05nd3dx?=
 =?utf-8?B?TXpJRms0YloxZlJhZTYza0k4TWlnRW9hdFJwand3RWFzWXMvS1MvNVFTU0pi?=
 =?utf-8?B?UjM3d1NUNUowbFZ1bEhKcmszU29GWGRYb2c0ckpHVm9Zck9xd0JuUCtHVXRn?=
 =?utf-8?B?Qy9MTWRzYVkvVWVmRFhlb1lLRG5NbW91bFdibmxEa2xPVjNFbVlJZGFYczEx?=
 =?utf-8?B?RmZkU3lCMncxOHdDQVhKL2MyOHJPYXVoU0VpMXRjWnNjTUwyTzZubGNFZlZE?=
 =?utf-8?B?TzVXYklIeFJGSmJKWmxUZUMyWGZMT2FMM25KTDJuaS81V2R5aHZTSHl6ZDVN?=
 =?utf-8?B?cWZ6YnZqVEJKeTNyMThCeXJGdGI3aUVCaG8xeUdEelF2QXdSNmh5aWdrTVZK?=
 =?utf-8?B?OEtWb2MwYjJRYUt4VHhjcFhHSWd6WWlCTXpjSEFMZFl1WnNLWk9yV2xvYktk?=
 =?utf-8?B?bStMY1Z5bXdPSFByUjdZVGNOY1BuakgwU0hOY2RkRmh2UkNhRkM5Z09KKzRx?=
 =?utf-8?B?bDhmWS90M3QvVnRYejh3SUVEV0xqeHUzektGcHpuVEgramFsdmZva0FTTGlO?=
 =?utf-8?B?TkFKVGp5VVZhaUJUN3dYS0l0WkFGL3VpdWprU0d4cC9odXBUZ2FwUVVuaTh6?=
 =?utf-8?B?bE5ITnplMmtuMnVRZEtoWGpVdEtnZ1haaWlZeXZIUEpFOWR4TkpZZGJrUm42?=
 =?utf-8?B?Um1aVjN2T0NyWmlJUW8vVER5b0xRVzVWbTVZT1ZucXh0N3ZQNnNTRkxTYnRV?=
 =?utf-8?B?cXJxTGJPM1lQTnVEWnZnQTRWcUF4K3dHMkxDSFdIYmhRamRRcHZaTEJCZ1Vv?=
 =?utf-8?B?Z0h5SEdWcm5qYVlRUmhFbFE1dll1Y3QyUndXcXF6R3dMK3d2RjE1dEI1KzNF?=
 =?utf-8?B?UGRsTVJxbGtvMytwSmV2cFk2Q3ZvUkthM1VZNlh1bjZIdXlqMW01Wm5HRk1G?=
 =?utf-8?B?dVF3VCtOWUIrMzYyYVVNazF2S1dHZnI2WkhFWEhES2FEa2w2ZjcydytyekdN?=
 =?utf-8?B?VEovL2ZnVEE4NkNyTnhIVytXMlgwQ3Y1WEMvQnUxcE10Q1RQY09Wck53K3RV?=
 =?utf-8?B?N0VTRThkVTJzeWxPNmhKalErdW93eWdCR1FDRFlVaW5RbG5VMUZrRnUxcGc0?=
 =?utf-8?B?dUVDeFBWSFZGT1BCdzlBNDR0MFNmVVU2VGhRQnhhM2dWM292ZXorYWFuWHNl?=
 =?utf-8?B?QW82aUluS2xpbFFFRmZrcFpQaHNZNDVrSnFnb2ZhbDhQM3hpU0RhR01PRmlG?=
 =?utf-8?B?RHhzaElNbTZYVzNnbGZ1N01UVi80TkUrdll5enhlQW13eTFBVzlmOWY4OWo4?=
 =?utf-8?B?MHUxOFBZNlhYUzFwc1lSZlZud09ZbUR0bFhlaW13SEpDVm9pRlNKc1EvT2NN?=
 =?utf-8?B?c2hKSy9uWVlwa09zZkhSTWJVU2NHdGd6aGp0OEFTYUhYclUwOHpRWWYyZktq?=
 =?utf-8?B?Q2o5YWJVZG0vQ2RnSUVwbnNlbmh0ajV1bGIrdnJQQVUvN1ZGZUxzSVM5VlND?=
 =?utf-8?B?eE9ETVhpS25pQ0J1Rk5xamZGclNiUkNCNENVTHM0QmUzbW0xUGlUVTFhNFl0?=
 =?utf-8?B?cS9VQkRkU3BaaWJFeTM3SE52dmlTU1NNOElMa09hRHN1bTFSMWIvUUlYOUc1?=
 =?utf-8?B?Nng1aGtoYWlieFF3M0tGVnV5a0lWU2s3ai82c3JBOENnRmZodjFkcWdGZWxX?=
 =?utf-8?B?UENSRS9ncUdjcHpNZHhhQ0gzNkx6MjFCYjA1eWlVREQ2bHVhZmRXZmNyTmtV?=
 =?utf-8?B?Y0ppWmxldDR3V2hqNkhNc0VHRzZhQ2JNTWx0WEtuYWorQmtnRGdGaG0zVkFn?=
 =?utf-8?B?TlBxbUtER2JpVEhzN0hNemJUYmY0Y05ISWV5d1JUVGVaYjlyVFptWFM2T2Ft?=
 =?utf-8?B?Tzd2SUNyM1hCeUMwQnNLbi9jU21NMHhza241YVIzc3NhUGhNRjJ3VUdDRjBZ?=
 =?utf-8?B?aEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD528516990E264791C260658E9BEDD6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5wO5FCMVL+XPQBw+O9QH75onagJ+qm1FGTENYabGAix8WiCT8KRaCUiJy8x07mXJd6+78H0f2fBo1s+ng/1SNKOIuXGJxx1zJuhMQN4s0AS8495nCO+FX4kPzeXhbM15BI4NpDkeDjmolt0nFGCgbD+Y2j4LRRzKqP6DLL50ppxbxuk96IGzVpEX3Y6yWgkb27nHE1vsDCC7pkz2dUpqslJhubjrWbAdD6iFZM6Keb15fFSSJenwP9qjDoJ9iuoLE4UCsFIYCWbcBjI9l4hshXcX7BACQ6ncceRgUvbT409R6a8JQKFk/GdsWvw8EVoX5vq3Wc/dBozkLaDqaU7+oA+Gq/V2QoQJX34UZFT9WirBAhHcRtd6ebLp2WoDGEtRsoGOLmuTl6Gokuso0mzmNewssKc+n6qf0h2ey7xdF6u3lO7tsG8CcFBc8Py0AQkUiCJ+6K/sIGpDWjrKh+yYOws81jM/wdZg6LyoOLG9T5yuAZuZENtvcIbICOb2K6x/OxCEiDXtHMDSaZhbS+0xwDUOetqs4k7oTCa13soPrctsronhTmViqs7Y2TEZoTqWnmqSzIanE/l8DJjel/LGpSUoY/54qCE+PSyGVdeOBtpXvdtjCefOqczsnk5pYK+w
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB13050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1168508a-2514-472e-2536-08ddfcae2395
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 03:38:20.7516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtXpqfP8Yc51jsXA2hqYdsyiAKqEAhUo4YkydyB/rGQn99UJHBXB45o4EokDdrC9jVFirlvRKpTDDQLzj9M1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9614
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDI4LzA4LzIwMjUgMDQ6NTksIFBldGVyIFh1IHdyb3RlOg0KPiBUaGlzIGFsbW9zdCBy
ZXZlcnRzIGNvbW1pdCA5MjM3MDk4OTZiMWIwMWZiOTgyYzkzNDkyYWQwMWIyMzNlNmI2MDIzLg0K
PiANCj4gSXQgd2FzIG5lZWRlZCBiZWNhdXNlIHRoZSBSRE1BIGlvY2hhbm5lbCBvbiBkZXN0IFFF
TVUgdXNlZCB0byBvbmx5IHlpZWxkDQo+IHdpdGhvdXQgbW9uaXRvcmluZyB0aGUgZmQuICBOb3cg
aXQgc2hvdWxkIGJlIG1vbml0b3JlZCBieSB0aGUgc2FtZSBwb2xsKCkNCj4gc2ltaWxhcmx5IG9u
IHRoZSBzcmMgUUVNVSBpbiBxZW11X3JkbWFfd2FpdF9jb21wX2NoYW5uZWwoKS4gIFNvIGV2ZW4N
Cj4gd2l0aG91dCB0aGUgZmQgaGFuZGxlciwgZGVzdCBRRU1VIHNob3VsZCBiZSBhYmxlIHRvIHJl
Y2VpdmUgdGhlIGV2ZW50cy4NCg0KQWdyZWUNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IA0KPiBJIHRlc3RlZCB0aGlzIGJ5IGluaXRpYXRp
bmcgYW4gUkRNQSBtaWdyYXRpb24sIHRoZW4gZG8gdHdvIHRoaW5nczoNCj4gDQo+ICAgIC0gRWl0
aGVyIGRvZXMgbWlncmF0ZV9jYW5jZWwgb24gc3JjLCBvciwNCj4gICAgLSBEaXJlY3RseSBraWxs
IGRlc3RpbmF0aW9uIFFFTVUNCj4gDQo+IEluIGJvdGggY2FzZXMsIHRoZSBvdGhlciBzaWRlIG9m
IFFFTVUgd2lsbCBiZSBhYmxlIHRvIHJlY2VpdmUgdGhlDQo+IGRpc2Nvbm5lY3QgZXZlbnQgaW4g
cWVtdV9yZG1hX3dhaXRfY29tcF9jaGFubmVsKCkgYW5kIHByb3Blcmx5IGNhbmNlbCBvcg0KPiBm
YWlsIHRoZSBtaWdyYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4
QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCAyOSArLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MjggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21p
Z3JhdGlvbi9yZG1hLmMNCj4gaW5kZXggNzc1MTI2MjQ2MC4uZGE3ZmQ0OGJmMyAxMDA2NDQNCj4g
LS0tIGEvbWlncmF0aW9uL3JkbWEuYw0KPiArKysgYi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0z
MDQ1LDMyICszMDQ1LDYgQEAgaW50IHJkbWFfY29udHJvbF9zYXZlX3BhZ2UoUUVNVUZpbGUgKmYs
IHJhbV9hZGRyX3QgYmxvY2tfb2Zmc2V0LA0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIHJkbWFfYWNj
ZXB0X2luY29taW5nX21pZ3JhdGlvbih2b2lkICpvcGFxdWUpOw0KPiAgIA0KPiAtc3RhdGljIHZv
aWQgcmRtYV9jbV9wb2xsX2hhbmRsZXIodm9pZCAqb3BhcXVlKQ0KPiAtew0KPiAtICAgIFJETUFD
b250ZXh0ICpyZG1hID0gb3BhcXVlOw0KPiAtICAgIHN0cnVjdCByZG1hX2NtX2V2ZW50ICpjbV9l
dmVudDsNCj4gLQ0KPiAtICAgIGlmIChyZG1hX2dldF9jbV9ldmVudChyZG1hLT5jaGFubmVsLCAm
Y21fZXZlbnQpIDwgMCkgew0KPiAtICAgICAgICBlcnJvcl9yZXBvcnQoImdldF9jbV9ldmVudCBm
YWlsZWQgJWQiLCBlcnJubyk7DQo+IC0gICAgICAgIHJldHVybjsNCj4gLSAgICB9DQo+IC0NCj4g
LSAgICBpZiAoY21fZXZlbnQtPmV2ZW50ID09IFJETUFfQ01fRVZFTlRfRElTQ09OTkVDVEVEIHx8
DQo+IC0gICAgICAgIGNtX2V2ZW50LT5ldmVudCA9PSBSRE1BX0NNX0VWRU5UX0RFVklDRV9SRU1P
VkFMKSB7DQo+IC0gICAgICAgIGlmICghcmRtYS0+ZXJyb3JlZCAmJg0KPiAtICAgICAgICAgICAg
bWlncmF0aW9uX2luY29taW5nX2dldF9jdXJyZW50KCktPnN0YXRlICE9DQo+IC0gICAgICAgICAg
ICAgIE1JR1JBVElPTl9TVEFUVVNfQ09NUExFVEVEKSB7DQo+IC0gICAgICAgICAgICBlcnJvcl9y
ZXBvcnQoInJlY2VpdmUgY20gZXZlbnQsIGNtIGV2ZW50IGlzICVkIiwgY21fZXZlbnQtPmV2ZW50
KTsNCj4gLSAgICAgICAgICAgIHJkbWEtPmVycm9yZWQgPSB0cnVlOw0KPiAtICAgICAgICAgICAg
aWYgKHJkbWEtPnJldHVybl9wYXRoKSB7DQo+IC0gICAgICAgICAgICAgICAgcmRtYS0+cmV0dXJu
X3BhdGgtPmVycm9yZWQgPSB0cnVlOw0KPiAtICAgICAgICAgICAgfQ0KPiAtICAgICAgICB9DQo+
IC0gICAgICAgIHJkbWFfYWNrX2NtX2V2ZW50KGNtX2V2ZW50KTsNCj4gLSAgICB9DQo+IC0gICAg
cmRtYV9hY2tfY21fZXZlbnQoY21fZXZlbnQpOw0KPiAtfQ0KPiAtDQo+ICAgc3RhdGljIGludCBx
ZW11X3JkbWFfYWNjZXB0KFJETUFDb250ZXh0ICpyZG1hKQ0KPiAgIHsNCj4gICAgICAgRXJyb3Ig
KmVyciA9IE5VTEw7DQo+IEBAIC0zMTg4LDggKzMxNjIsNyBAQCBzdGF0aWMgaW50IHFlbXVfcmRt
YV9hY2NlcHQoUkRNQUNvbnRleHQgKnJkbWEpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5VTEwsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICh2b2lkICopKGludHB0
cl90KXJkbWEtPnJldHVybl9wYXRoKTsNCj4gICAgICAgfSBlbHNlIHsNCj4gLSAgICAgICAgcWVt
dV9zZXRfZmRfaGFuZGxlcihyZG1hLT5jaGFubmVsLT5mZCwgcmRtYV9jbV9wb2xsX2hhbmRsZXIs
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgcmRtYSk7DQo+ICsgICAgICAg
IHFlbXVfc2V0X2ZkX2hhbmRsZXIocmRtYS0+Y2hhbm5lbC0+ZmQsIE5VTEwsIE5VTEwsIE5VTEwp
Ow0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIHJldCA9IHJkbWFfYWNjZXB0KHJkbWEtPmNtX2lk
LCAmY29ubl9wYXJhbSk7DQo=

