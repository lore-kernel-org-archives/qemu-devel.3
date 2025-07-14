Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0795DC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 07:54:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubE01-0002A7-IO; Mon, 14 Jul 2025 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1ubDaw-0004yO-3S; Mon, 14 Jul 2025 03:27:27 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1ubDas-0004Ej-Oy; Mon, 14 Jul 2025 03:27:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHGiCOnMKeOebYFT/NiGMSVlpf/gdCdjtgvl+1KbZLrqUj/hYJWkGOuejm4NbUVbB/cDgZjYhgr15+StW2GOnL+hdVH05n7/KUbhEmCB1nq57KtGV8Tyg0l8n4HjAeV5+mBru5FQ/lOeaeCL9pYUqxDRO7W8Gzbg2iHVN0Z1bqpTQmhFyE83IVePGeiloNRlZUJWXWJ25xcufbL+wQrK8W90ub49jXB2ys7c3tcmHpDP8uxRrhiHKdvkf3yr4N+IJBnEov5WKotkmYBKLTWDcHok27JCpXJvtnB5tVy1DQImjfo6nI4eReXVSLt8tvm4V3ZPtmTIYe5yV5GA24yFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A7ZzyBnc+hZBzSv2JBN0xLZq/OHZhEx+UeteyLWrbM=;
 b=LPOWp6XQ74wVKNIx9YtEBYoSr8tWk/1tG7SedeHV0WObFRR3xV7IiuxN8RUmKuq7jrzhsC6SljpaJg3+XOn4/znM8s5wWNy9ljnmBryALwMfV4PtQH0xMYydFrl65tU60sEr+sY1q+1r1zV5qHl406Al7aiquz/n73Cxj3x0dkn1EYdW2FrNoAk5b7L7k6T9wHWHd2sEOrs4Z2zleANpM4o7ykEdL8ZnUafF+5aaS4iHH571vcw+HjG2T6RARWmNCiZN4Jq69HLUiO5vJ2Sxz9NWU32NNFiN9wSJHE3RfAlPUZUEg1MVFzclpT5bOhpC1MlV0fe9+ra8UecxDM9SbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3A7ZzyBnc+hZBzSv2JBN0xLZq/OHZhEx+UeteyLWrbM=;
 b=OJXRId1/eXfJ8nkH074XDWQHDtkUcCGM+ulONj0IY5BDh54qG8If2zqVoHcrv5TFxJLKg45t5jYaMtQCH6Gr+Ge87g1XdlWh5fhN3eW7zfs76A8bYIabIvr1N8vEGzEMUU7Fv6MlxhbrpF59HcHm0VLn6B/u3CI6s4EolZU0uAu74l9MqZtyCdwGxgQCmJvyNyLjDqXEcD5yn1oosfju+qUNy7gDxnAaUNKI4SApObl7fsYrbcZzFjPr44zksrdSp9qOyryd4fDUMa5R5VMHWdKX1ZLHxnYCYbnt93jaCajx3fRJXjLdnPGcqod08IQndtWTCCx4VuAIuhiNuTgYew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB7305.eurprd08.prod.outlook.com (2603:10a6:20b:440::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 07:27:15 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 07:27:15 +0000
Message-ID: <3cf48a83-090b-48eb-9a8d-2456fcf42383@virtuozzo.com>
Date: Mon, 14 Jul 2025 09:27:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qemu-img: add sub-command --remove-all to 'qemu-img
 bitmap'
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20250707205822.614350-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20250707205822.614350-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0247.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::14) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 66666c8f-31bb-47d6-b160-08ddc2a7db42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZkRhTy9MZDZkNVRCQk83aEUzMTArczRaTWpRTUV3OGtVTnhkS0hhK1BhRUdL?=
 =?utf-8?B?dllvdFl0K09zMzdIOHR1b3RZQ2k0aWpOck9md0RzQ05MVG9IQ3Y3OWEzZ21y?=
 =?utf-8?B?T000Y2orZXpjWHFUZzI1b0lVc1MveWpZeEppMHF4MEVxTzhnc3g1RS9ZOWhh?=
 =?utf-8?B?Vzd6WjJic2FkTzJrTlRUUUlyU05Pc3JIWjNEc2tIc1VhVFRWN0RoQWtBd09X?=
 =?utf-8?B?TEpINytKV3UyYUJDeWljUXBqbXRoUzVxY09HbHNlbHlqczE0bG9ncmwrSktu?=
 =?utf-8?B?N1ZKSDJYTHdxdEpUL2YxYlNwRVRQY1VvZDZiUElMSEdpaWhxMVRVaGZqb0dk?=
 =?utf-8?B?ejBUS3IyY0cxV3Q1elQwZXl2dU53WXlOTTZOZGphd3JvbDNlWElOdmJLVlVx?=
 =?utf-8?B?TWc5bkJtdGVCK3ZjcjA2b1M0M1ZHOTBXeHdQRHpsNjZoS0pHdWhoYzl4Wkps?=
 =?utf-8?B?VHk3ZWlRdmk5YzlaR1ZLdzhGUWMzS1ZpVUc3LzNPSzhTdmFyVy9jUWJleEp1?=
 =?utf-8?B?U2dUanZib1VDb2VoQzIrUFJqVTh6aDNncmpvd3NoR1BLMDNBVUc3VlZEeU5H?=
 =?utf-8?B?SnVVeUNKZG83eEY4UnQ0anRadTNLa3pQZEZ0MXJyOGEvZ1NjWEt0NTFjSkpV?=
 =?utf-8?B?S2ViY3NTSUU1VThNYnBTMjRzQ2o4U0RiZ1YzcDZXbkpTV0EzVDJYTEV6elkv?=
 =?utf-8?B?SmtHYXlSbnZMNk9aRDNLVllRYzlEcWE2MVJ4UEJQc2xKb3JvbWM1cEthOUl6?=
 =?utf-8?B?eVFuZ3VrSnhCT2U0Qnp1WlJyK3pZRHRGd2lyRTk1dGt2VDI3SUd5TFRJZ0h1?=
 =?utf-8?B?akFGYXp5dlpWWVJZZDB0Ly94b3hMNUJWOHVlU21zalNvOFJ5TXZPcUh2TGxO?=
 =?utf-8?B?bVUwczlyUGlTVGJaQmlPbWFRa3dOY05HYzl2VStuTlczNHFpR083cnc2eWVC?=
 =?utf-8?B?bk8vUE1MZWhkSW5mcSt4MHVkZVNPV0J1RUNRSTc1MUpCNTcrM0ZQMU9WbjVW?=
 =?utf-8?B?UXpyQUVQRUg2WDBLd3puK25rbnlMUTFpTWNrRGl0ZWh2c0lTaEErZGZIeU94?=
 =?utf-8?B?cUFoaDViL0pPWlZmU1ljcXJ0R0RTNkFrei9ZQ1RrWGZkLzZxQkUzZlMwZ2dh?=
 =?utf-8?B?aUZoVStCMGRTQmg2cGltM2FkZmE5dnZocmhtZW5HM3cwLzJzRFA0bDJWcmdQ?=
 =?utf-8?B?RDBFczRjcTJ1bUVSOHNXVkVwSzNROGllQ2ZTcHVBNzFPMjBMMDd4UGxjWjNL?=
 =?utf-8?B?cU5ZUzlFUHhtUWVHNzluTThvYmhPeDRRb2JyNlpVYXlYSFRMVVNReGNXRVNQ?=
 =?utf-8?B?UW9zN01uN2piMllaRUxEOHBGSE1QZHhTYTBQVElMaHVBR1BRNjFZWmtNKzh5?=
 =?utf-8?B?Z2NMaGY0N1V0YW9WS20zSUVBMWpMNS93MEY1OWNJd3BHWkowWEkrZ1Z0MWFK?=
 =?utf-8?B?Z0UvK0NDMTM4MTZCODNuK2U4VXRuU3lzRTBXRVEzWC9ZMmdLampybk0xbEtT?=
 =?utf-8?B?bGZIakYvWUFuUlVycjhyVmtRNlZkNjFveHJrb25KclpzOGNnOEhTb2VnWTNO?=
 =?utf-8?B?U1RQK2Uxd3Z4RkFZeGZjamdpTjlsYnpaNGxxTEJzTHNjZk1xRi9oQ2lLNk5Z?=
 =?utf-8?B?cGx1RDV3Nk9lS1Z3R3o0SGVOMmlaNE1YckxBRlNlbkJEc3labkpkMHFMclRC?=
 =?utf-8?B?U1YwVEhSNTRvaW0yczZhODRmcWw5YjBSdUgxVzFZT1FTRFFaT3Q4czQrZ0s1?=
 =?utf-8?B?ajUrMWZ3aWFNK0tEUWI3ZkZVamNYdGg5NXBleEU2WkZWb1MzazkxU1NkenFS?=
 =?utf-8?B?VGg1SkhmZG8wQkJnd2s4c2cyUy96OGkzN0NjcU9rN1VoNGpOUERkenlMOGhJ?=
 =?utf-8?B?MUVvV29vbnBqZitTRE9XeWgrMkpUcVdNSndRVzJUNGN0MnYvdHcvMjd2K1Fl?=
 =?utf-8?Q?DfbT2ZZV5sg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2EwcmltWDY4TlFmTlRqVUliT1BwTkV4cUZBbTJvZUdGOWdlUmVrbWwwNmE1?=
 =?utf-8?B?SGNYak0yVmFlVFZyN0lWVDlEbE5SUnpBbk45a3BBanEyNGNrOWhyVldRcVlS?=
 =?utf-8?B?TndVTU9xczZMS2JOSTdDaXhBbW9VcDQyMkRIZitEbkV3UnlzWWdoSktvTnUw?=
 =?utf-8?B?RXpOUlZnK3pQNHk4Uk5OenVOSmxDbUs1NmlUT1dpODlkZ1lTT3hCZkh2RThL?=
 =?utf-8?B?aGs4dnJDZ0ZlU2JjYjhtaXhUeFdtSmxnOGtwaytuWTRpdWxLUXFnSGFvSDBQ?=
 =?utf-8?B?bE1nL0JlQi8wRkFXd0FwUnE4RXRQNS85Rzh5THE2VXpWVTYyczNzUTJCbDF3?=
 =?utf-8?B?L2FqN3p0TlNDeVdZSHkwZWtjMS9aRXhhaUtHSU9mbUdpUGR1L0J4WkowNlJ2?=
 =?utf-8?B?THhuOHFDdlF1V1FFZGJNSnQ5bXV3Z0lRZmx3UFJ1d2gxRlRLN2dYVy9lL0pT?=
 =?utf-8?B?REF6MlRqdmlUR3NybisyaUo1NnBHaXZFVmRUM0RwRkFYa1lMdHlGRUNUUnNR?=
 =?utf-8?B?UHAvZ2w2VWc1VnpFaUZNT0FCQjVGWW1rekllcSs2Y1dUTVFIOEE1Si9BWXFq?=
 =?utf-8?B?TVFHMGN4VFZ4Q2FTTXJOUjhVYkF0S0NFeVBTV3hMSlltV042eWxCNFFJRFVP?=
 =?utf-8?B?Q1l4TGRzWExabGprMkRUeSt1T0MxV3ZsNG5Zdi9VWDRWUUFDbGZPRnY1bVhR?=
 =?utf-8?B?Rk9zS3h4U3JGdFNzd0ZwaHY3NTYzS2lBdzRjd0dsdjZDdWsyK1F4VnpMa01v?=
 =?utf-8?B?dzVvWjllZzFEdGhud1FMc3VDb0pGcUsxRUR0VTVXNElkSEFOSXh5TXczZVhs?=
 =?utf-8?B?S1JnNm5kMFBvRU5oeG5CYXdacHZ4WVcxby9UcWRkUWxkMFNzLzdhaDJEampi?=
 =?utf-8?B?LzhoWGlzbiszWXd5eFVoVERsZ3ZmNkxZRy80aFhwb1Jnc0Zuc0k3aGlXZWJX?=
 =?utf-8?B?UDdzcnptRC9vcWd6cUUxN0wveXhOVlFOQ0wraVdFcE4vVjFjQzdBdUEybG5W?=
 =?utf-8?B?czN6RURTVDFNc0dMZDh1SGl4akMzN2RVdnlaWE8zWjV2dDJGVlhGQ3RwU2tZ?=
 =?utf-8?B?cFhidkZUdHM0WnRrSVIrSFlad0I3WjB0TnZ0NE8wVEJ0L1NxSEo5c3VtbEpV?=
 =?utf-8?B?N1F0QUxhRCtteExkMm1YdkdWeUgraHpxbHRyL1I4dU93ZzFESjJOYkZyUDdu?=
 =?utf-8?B?ZlBaYUN2aVRmYmE2bFdVcDVLc0piWWt3TGI4T1hLZnl5eTRla1lkVG1MdXZz?=
 =?utf-8?B?bHBiQ2JNc0NJdkI1Ny9pcnRqd2g1cFVlUURUUGdINGtPYWRXTU9IYlF2UDdD?=
 =?utf-8?B?LzNVOURtYVYydkcxQnYrbDI2c0xFeGZhY2l6WEQ5TThocmRYbEdZMVBnaEhh?=
 =?utf-8?B?bWhHMzdRT0l0U0dzUXJNdms3UjNhcTBLSGs4SmZCYVZmdFJnSDR1WVJSZWt4?=
 =?utf-8?B?RUlHZTBWb0E5TDJVR1BVY0ZmSFhRMjNnNzU1TlZVWG1QN3V5ZHV5ZXhsZi9R?=
 =?utf-8?B?L05xNXc3KzUrTUlERWFlMTZvb2dlbVA4M0RtMy9qSWxwMDVFbU82K2dmKzJm?=
 =?utf-8?B?T2VrY25pN0cxRDVUOEROY2NubkF5alBXdVlsQ0FCR1IwUExHOXR4SFZpZGFj?=
 =?utf-8?B?NEw1dWdiQmJFUVhDV1BrQUg5ZmpyRlE1eGkxQ0V3Y01qU2NNTkxxeFNQbXYv?=
 =?utf-8?B?d0lJSDlmM3VHOGdoSUNNaDNzVGpTbktOZklFUFRFcnhjc0hFWmpwc0YydDR3?=
 =?utf-8?B?WUlzOWN0R2ptUXRnalVKVlJ2K1drdWJ4citFRlFKVGZHN1kvQ1E0bkt1Z0sw?=
 =?utf-8?B?YzV1WXkxVk9GWElxR2NuaDNaUjNyN0lSaVBjbXpZYVNzSUVRVURSNkpkVjJM?=
 =?utf-8?B?Q3VFd0ltWlFmL2o4UE9IWmZ6TmVMTTRVemUvTlhSMElkbUxmd3hac2ZDYUdJ?=
 =?utf-8?B?VlZwTzAwcWk5MjBWSENaWHYxS0NzbjZ5YS81WS9sNk52Qi9LbW50TlBaek05?=
 =?utf-8?B?U0xuTW9wa2R4Qkg4dE5XZ0dyS0tsUHFQWjFWMDdhRjVQcEYxYU9tSUJSeHlq?=
 =?utf-8?B?ejR1YU95elhTZ2xMMm14OGJQZWNYOUdZWWhHcjhkbEFNeFVUVzM1SzNQMWY3?=
 =?utf-8?Q?1EaD5C0PVDK9+VUEP/X9cszvx?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66666c8f-31bb-47d6-b160-08ddc2a7db42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 07:27:15.2895 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAocIahGC7DuBQIVYeUftT7qXH8iKfG3+c4EeUWIN4LZElF3eP1WhDnWCHYQbFbAPXNJS0kmJD/+U0iTQhMNOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7305
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 7/7/25 22:58, Denis V. Lunev wrote:
>  From time to time it is needed to remove all bitmaps from the image.
> Before this patch the process is not very convinient. One should
> perform
>      qemu-img info
> and parse the output to obtain all names. After that one should
> sequentially call
>      qemu-img bitmap --remove
> for each present bitmap.
>
> The patch adds --remove-all sub-command to 'qemu-img bitmap'.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   docs/tools/qemu-img.rst |  4 +++-
>   qemu-img.c              | 43 ++++++++++++++++++++++++++++++++++-------
>   2 files changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
> index 3653adb963..a08fd6019f 100644
> --- a/docs/tools/qemu-img.rst
> +++ b/docs/tools/qemu-img.rst
> @@ -301,7 +301,7 @@ Command description:
>     For write tests, by default a buffer filled with zeros is written. This can be
>     overridden with a pattern byte specified by *PATTERN*.
>   
> -.. option:: bitmap (--merge SOURCE | --add | --remove | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
> +.. option:: bitmap (--merge SOURCE | --add | --remove | --remove-all | --clear | --enable | --disable)... [-b SOURCE_FILE [-F SOURCE_FMT]] [-g GRANULARITY] [--object OBJECTDEF] [--image-opts | -f FMT] FILENAME BITMAP
>   
>     Perform one or more modifications of the persistent bitmap *BITMAP*
>     in the disk image *FILENAME*.  The various modifications are:
> @@ -310,6 +310,8 @@ Command description:
>   
>     ``--remove`` to remove *BITMAP*.
>   
> +  ``--remove-all`` to remove all bitmaps.
> +
>     ``--clear`` to clear *BITMAP*.
>   
>     ``--enable`` to change *BITMAP* to start recording future edits.
> diff --git a/qemu-img.c b/qemu-img.c
> index e75707180d..920ede2a6a 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -86,6 +86,7 @@ enum {
>       OPTION_BITMAPS = 275,
>       OPTION_FORCE = 276,
>       OPTION_SKIP_BROKEN = 277,
> +    OPTION_REMOVE_ALL = 278,
>   };
>   
>   typedef enum OutputFormat {
> @@ -191,7 +192,7 @@ void help(void)
>              "Parameters to bitmap subcommand:\n"
>              "  'bitmap' is the name of the bitmap to manipulate, through one or more\n"
>              "       actions from '--add', '--remove', '--clear', '--enable', '--disable',\n"
> -           "       or '--merge source'\n"
> +           "       '--remove-all' or '--merge source'\n"
>              "  '-g granularity' sets the granularity for '--add' actions\n"
>              "  '-b source' and '-F src_fmt' tell '--merge' actions to find the source\n"
>              "       bitmaps from an alternative file\n"
> @@ -4770,6 +4771,7 @@ enum ImgBitmapAct {
>       BITMAP_ENABLE,
>       BITMAP_DISABLE,
>       BITMAP_MERGE,
> +    BITMAP_REMOVE_ALL,
>   };
>   typedef struct ImgBitmapAction {
>       enum ImgBitmapAct act;
> @@ -4788,7 +4790,7 @@ static int img_bitmap(int argc, char **argv)
>       BlockDriverState *bs = NULL, *src_bs = NULL;
>       bool image_opts = false;
>       int64_t granularity = 0;
> -    bool add = false, merge = false;
> +    bool add = false, merge = false, remove_all = false, any = false;
>       QSIMPLEQ_HEAD(, ImgBitmapAction) actions;
>       ImgBitmapAction *act, *act_next;
>       const char *op;
> @@ -4803,6 +4805,7 @@ static int img_bitmap(int argc, char **argv)
>               {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>               {"add", no_argument, 0, OPTION_ADD},
>               {"remove", no_argument, 0, OPTION_REMOVE},
> +            {"remove-all", no_argument, 0, OPTION_REMOVE_ALL},
>               {"clear", no_argument, 0, OPTION_CLEAR},
>               {"enable", no_argument, 0, OPTION_ENABLE},
>               {"disable", no_argument, 0, OPTION_DISABLE},
> @@ -4846,34 +4849,44 @@ static int img_bitmap(int argc, char **argv)
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_ADD;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            add = true;
> +            add = any = true;
>               break;
>           case OPTION_REMOVE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_REMOVE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
> +            break;
> +        case OPTION_REMOVE_ALL:
> +            act = g_new0(ImgBitmapAction, 1);
> +            act->act = BITMAP_REMOVE_ALL;
> +            QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            remove_all = true;
>               break;
>           case OPTION_CLEAR:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_CLEAR;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_ENABLE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_ENABLE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_DISABLE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_DISABLE;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> +            any = true;
>               break;
>           case OPTION_MERGE:
>               act = g_new0(ImgBitmapAction, 1);
>               act->act = BITMAP_MERGE;
>               act->src = optarg;
>               QSIMPLEQ_INSERT_TAIL(&actions, act, next);
> -            merge = true;
> +            any = merge = true;
>               break;
>           case OPTION_OBJECT:
>               user_creatable_process_cmdline(optarg);
> @@ -4885,8 +4898,8 @@ static int img_bitmap(int argc, char **argv)
>       }
>   
>       if (QSIMPLEQ_EMPTY(&actions)) {
> -        error_report("Need at least one of --add, --remove, --clear, "
> -                     "--enable, --disable, or --merge");
> +        error_report("Need at least one of --add, --remove, --remove-all, "
> +                     "--clear, --enable, --disable, or --merge");
>           goto out;
>       }
>   
> @@ -4904,10 +4917,14 @@ static int img_bitmap(int argc, char **argv)
>           goto out;
>       }
>   
> -    if (optind != argc - 2) {
> +    if (any && optind != argc - 2) {
>           error_report("Expecting filename and bitmap name");
>           goto out;
>       }
> +    if (!any && remove_all && optind != argc - 1) {
> +        error_report("Expecting filename");
> +        goto out;
> +    }
>   
>       filename = argv[optind];
>       bitmap = argv[optind + 1];
> @@ -4945,6 +4962,18 @@ static int img_bitmap(int argc, char **argv)
>               qmp_block_dirty_bitmap_remove(bs->node_name, bitmap, &err);
>               op = "remove";
>               break;
> +        case BITMAP_REMOVE_ALL: {
> +            while (1) {
> +                BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs);
> +                if (bm == NULL) {
> +                    break;
> +                }
> +                qmp_block_dirty_bitmap_remove(bs->node_name,
> +                                              bdrv_dirty_bitmap_name(bm), &err);
> +            }
> +            op = "remove-all";
> +            break;
> +        }
>           case BITMAP_CLEAR:
>               qmp_block_dirty_bitmap_clear(bs->node_name, bitmap, &err);
>               op = "clear";
ping

