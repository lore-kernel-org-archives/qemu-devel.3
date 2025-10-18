Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFD1CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA95T-00049R-3u; Sat, 18 Oct 2025 11:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA95R-00048z-9T; Sat, 18 Oct 2025 11:43:17 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA95P-0001AB-AV; Sat, 18 Oct 2025 11:43:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4+KQ32LKompXaGfxCUDmkZNfXsEua7ip/HYY98IUphfKRb3KDYUmguNBLWAHWMSx7fvvTIClyHAR/5YD0DibPTcd2cVQ4vNxF3yk3dramsWGiJ52BkH2oOzJUA2/jFdPtgLx5mUXtMi5g7l88nQR+2mrMCf5C6MLe8bB5elzAMVzjEfoIvQqM0iGFU2bMOSir11GXIPf6dqtdbiXyeMYSgd/4p8x2XtmDEq7tTa8kHnwnaImPUdZAQok37lNHKioQMGesM9iysJrWTrapbTKO4RB8rOhFH5I1WxGKAofmXP9yk0o8KYOMNidwmq+lCN8bDv6E3Ixq8ZyXc05vjoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U14OZM1kJ7AD2cnW783Cy8NcWPaMITmDuZgzbQHzzFA=;
 b=oTjEncihqVsK79+ijZtMW+jU+XQvGGeUBsl7n4kyz0JS75px+CIpH+ya94OSzvdm7+0mayAPV2SoRrNr+Dm37dCPhXD2k/yH9M+efP+1O69ksmjSz0JfOb8VOcuZ/zSosoifcOABBR0qzZMsHo+Uilz82LAeU3hJiK+c7yYdYnCMSSwYW1vuUODR67w87ZsdFER1s7oLdBL5eBouKiaR1boQBHct/wN0UyOePef/Vc5+fE8/cOYfwV/2UeN6loB7LLZwSsQSL9JPEEDAyRgz9W/m+4Khnm8WoXkRA0YaOC7lnzhtEDVeX9z5QK2UdrIGxkXRCS6z821Jij1PHgUIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U14OZM1kJ7AD2cnW783Cy8NcWPaMITmDuZgzbQHzzFA=;
 b=AovaU2Ww7+/Hp4U6FDIX9lN8ZNBxKiRxQz9z5EMhRRPVU5ejPXbxcE+n+Gjdo6A5JNEeXABMZaxT9pQji5CYbPSxXiJv0CAAeKKdzsO/126VxhNMWbw7+ctyYWIotK1neUfzdPCG+Xfy613BTsR73M3MJxw9zFkVOfUQa7VUBgyGo+3OEtDgmex+Zy3ucsSydNUGKCkRDPVpGMm0rSyQ36u/ca5OiG1skazWrlOWizkQUcqxWvGJsN0gMJhd07KRAX5AaYM783FKWWRGU7bK/N6ah3wbkiac5aiW1H+/XJ9DFbnMDqYcI4s5h3nWW+TqBLO7g1U07Ulz6LAuGImefg==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:43:09 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:43:09 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v12 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v12 00/13] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcPdSZx7Sk0nq6B0O8p6a+ldjTnbTFhYWAgAKKoIA=
Date: Sat, 18 Oct 2025 15:43:09 +0000
Message-ID: <20d90961-59ca-4b4f-8d2c-fc0fe4d2ed37@htecgroup.com>
References: <20251015130657.571756-1-djordje.todorovic@htecgroup.com>
 <CAKmqyKNCNhRqS+5=sZ0Cg7PcV-ciqxWD4OxJgq1M0RaX8zbgrQ@mail.gmail.com>
In-Reply-To: <CAKmqyKNCNhRqS+5=sZ0Cg7PcV-ciqxWD4OxJgq1M0RaX8zbgrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: 34790608-2c41-4fe1-bc45-08de0e5d09d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ekEwRTRFQy95a044UGVBWjBlRXp0TFVMdm1uMXJQN2hyeHJaQ1hLRk96UEo5?=
 =?utf-8?B?NlVEdVR4YitEd2ZSN1kvZ0VwdTEwSTZUK05PMkZHaXNhS0s1Lzh4RFJWZlRk?=
 =?utf-8?B?SjczUDFucE5KVk1UOVJEN2c0V2J1SEtaLy9UWU5VVGlEeSt5MTUwYUtBYnVv?=
 =?utf-8?B?TElZSEJ6ci8yOTFJUFBDVnQwK3FLdEN0L1hSY2xvL1h2dEJDU1c2a2FacDdW?=
 =?utf-8?B?ZXFqTzJrUENweGxIY3NpMWpVNi9QRUd2cGdjU1YvMnlEcm9NL0trZDVqOTQw?=
 =?utf-8?B?LzZCTUY5THdURmhGa0VFdHhqMjlaYUdvcHJneUg5QjhLTkUrd0N3MUxhUmZW?=
 =?utf-8?B?bmkvcGEva2ZKdkJXR3QwNnZhVHdpREd6cGRrOWprYWpxUmJmQ2pyTVR1Wkxv?=
 =?utf-8?B?bDlLTnp1RDcvNXlkbndnb1ZOVFZLUSs5dlVsbFBObHRNTTZpdVF3SVVOUHVw?=
 =?utf-8?B?bmU1cUVPSUpWT1EyL0VaOVNaYkhqZHF4Mk9GNmoxMTQ5TkhsajBZSkN2YVVu?=
 =?utf-8?B?bmwrQ2FWT1pGQ05kWVpYeXpCTGtwSGs0Z3B4TndkS1FYNGxtNmNxNUMwZlFi?=
 =?utf-8?B?YnozS2FYblZnOWJLVVpJdUhmdXFyYWlzNlE2UUNEemFtZ2QxbWJRWDdQdm1D?=
 =?utf-8?B?NGppLzRRQnc5bXp3TkxOMzFxci84SmFTT0tCK01oOWg2MGhsUGJmYXlXMS80?=
 =?utf-8?B?WkNvTXhMZW5Dc2dlOVVGV0dTZFd6c1B4c0dnRm11bXlrV3ZkM2RKS3FCMldD?=
 =?utf-8?B?eEFzbG1palB3WGhTdDBlOHU2SENnSzVZTXJwRjUzeUVaTUJZeThXRmkxdXpU?=
 =?utf-8?B?NFd3dERqNTVoMWczU2tOZUJ1cy9XeHVlbFdOTWlwS05hM0taWlYxKzZWQ1g0?=
 =?utf-8?B?VkUvVUpIa0NPVjVUSTZZNWxjTVBjOFpURWlPUWt1TXhoQno3NHNQSUlTWUcy?=
 =?utf-8?B?dWpMUlI0cDVPdzErNnNHaFdHbkcxODFSVTlHdnF4OWk5Zko4a0lVQVkrbDVZ?=
 =?utf-8?B?M2dSc3VKQXNpZHlKOEZCTjRJMk9YU09SVnp5SkJmcmhINWFtQ2l0Y1diVlV2?=
 =?utf-8?B?aXFqU1UzTkZLb2hsZ1h4ckFESmVUenE5ZWNyQVU5VHhaU2dQeUw3bTZUVmhI?=
 =?utf-8?B?TTFkcXdoWk41ZzJGUzN1TzVZZ05Jbk5wUnhhNFJTL2UrM1RDaVVFTGFJenRT?=
 =?utf-8?B?QllkaXNudC9QeWI3SlhLZVhWMDBnTysyUkkrUjBCQW1RY24vODFvU3MzOEFx?=
 =?utf-8?B?QXVIRS9VZ2hMQTRuaVlUaVkxRGhPS2w3ZTFSeExtRU4zeUZzancwM1VDMVFu?=
 =?utf-8?B?aFFtOFpDdHkzR3EyZ3M2bHdXcUpOc2pab2tuaHBLbXEyWmJWV0kwUlNNUFZ6?=
 =?utf-8?B?My8wRWxVNDJia3IrOXdnYllMVERlYncwb0diK044VUlyQk9DK0NvZndsTlBh?=
 =?utf-8?B?aU55cHYxdWd6OThTMy9LZ2N3bVRaSFBwR1ZaUlNWRTI0cmZ2UlFIeUkzRjZW?=
 =?utf-8?B?U1crNVdkTkFyWlZzOWx1dS9KeHg2Y0JFM21uWmh6Wko4d0hTMzV4UTVvdUZN?=
 =?utf-8?B?MWNERWkxWlJjb0dRQnI3L3NrZTVyUXlqVE9jbFIyeDVkcTVlWUNyQmRiWnZ2?=
 =?utf-8?B?djFVRm9GYnpZZzlpaWUvRUs1ZHVJR0ErQW9nVzJUWTNzSEkyV3o3SU51Yzhn?=
 =?utf-8?B?bDd2RmUrSjRJREVKZ2NldG42TmVGcjduLysvWmE5dWRkd3FpUXpsanlTeDZk?=
 =?utf-8?B?U3IzQlBSUEdqN2E4bzNXbXEyd29lRFlSM2V4WCtlaVV3eGdpRjYvdEd5TzlZ?=
 =?utf-8?B?bHFUaU1zZW1UVlpOeHlsZms5VHR2bmtxK2lQcHEvL1MySHYxYlhWS3p5Nmgw?=
 =?utf-8?B?SmpHa3owT1BkaElEdVRFSTM1Z29XQ0lNNXF1Qkl3bVQwZkJHc0RGUGtQSUx2?=
 =?utf-8?B?U2NYd09ka3FaYVBkbDBvaEN0Q1dBTnd2Y2M1N1ErSmcybWZuRDIrenBqMjFo?=
 =?utf-8?B?aXFadW1YODdrTkpaTGlSeklZODlOTE94bCtnQ21GSE4xNlRvK2hRTzJoY1ZB?=
 =?utf-8?Q?jwJQel?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXI2U1BBUUFGTE1KbndXNllJd2hGT1VvUkFJMGw5QWYxZ0FIZWd4bGFybFpL?=
 =?utf-8?B?UDEvVUs4dit5dFA3MXNXMDBJZ2Y4dVp2NEYyREhjTkFicFY1STBlQ1V5N3hu?=
 =?utf-8?B?K0JRaThIYnp2R0hzUzhJOUZtMU5WbzFobzhLcmZtajkxdlFrS0ppTytRTU9q?=
 =?utf-8?B?eUJjc2g1dkNCRStsOHlNMHBzQWN2UXZaRFZFbmh2aCtSTnBPTnRzZS9VMVFR?=
 =?utf-8?B?WTh3WnlrUGwwYThsN2tWUXJkLytrNitSQ1FoNW1jZlVUSEhzNUhRNEVJNS9Y?=
 =?utf-8?B?NURFeUsrMExjOW1hTUc4b3FpNjhDenZIdDRmMFhHNEE2eEs3MEhzeDliQWZ6?=
 =?utf-8?B?YzMvMmRnL0NNUU1MQnNGdHV5UnZuZ3p1dDNTalU3amc2V3VsaGxIeUZBamx4?=
 =?utf-8?B?M0hNVnVLc3RCNXNPeTFFMWJURGc4NDNzN1ZIRGhlcnowMjEvL3JJTXNRRWV6?=
 =?utf-8?B?QWttWGIxRHFJNUE0eTg4MU1uK243NlEvSjd0a3RuQjYyYzUzV0txUmFjVjZN?=
 =?utf-8?B?ek4zZm5UTU5WeHg0VlZLaWRmSFVkL1RLWXF2eFllYkJrVFNzN0xieHZ1R20y?=
 =?utf-8?B?ZmVpOTRMYXN5YXQ1cC85TWJVRFZwaWlZVlh5VWV4OEJKQ3VkTGx4SE10ZnZG?=
 =?utf-8?B?aE1oMTZJL0FxdkoxbVpaaWdRemtGdVJoWno2NVhqS1pFaWpRQW9vT05mSGJ3?=
 =?utf-8?B?WmR2RFZjdE80eVNoQXRiMFI4d1FnRGdpSThtMStDOHgySjc0b1hKWjVzOWZm?=
 =?utf-8?B?NXNqK0NEQThlUTR4TTV4UjlXcVM3cTlFYmhHdDd6T3Q2RU5yQlBlMU5hWmo1?=
 =?utf-8?B?WjI3Q0xkaWw5WWttb2t4OFRQaVNYcUxKcU5UWXVhZWx2dFpVN0NmY3laYSt0?=
 =?utf-8?B?WEJJOHRuQjhDNk9yNUxaUHdveEI4MXBhWTRHVXpKVVF5aFpvTmY3cFlhQUp5?=
 =?utf-8?B?S0ZDQ2ExcmEzU2hTRUFSRlgyd3E2QVdkZCtQK2l6SldtcHkxZXRQOHU0U3Nm?=
 =?utf-8?B?cjZnQlI5TVZuTXRnZzRITloyTzlXS3Y4dGZEZmR6QStaRmFmclFtVlhNZE95?=
 =?utf-8?B?Y3RMcmR6bGFzT3BuTjM2QmNJK2x4bmhkNkxWNXl6c3k5MmFLWTQrRE4xdFZ0?=
 =?utf-8?B?b3dsRnA5bjdiODVGcHBHZHc1NlZuUEtRUlhvdnlGUEhFeW9wMlJQdUE1MEFi?=
 =?utf-8?B?Tmo4bXloMW1EREZ0Ti9pWGtNcmRwUUVGbEl2VDVFem1YY3dvcE55L1ZpYUNF?=
 =?utf-8?B?NUxxay9RY0Fnc0hRd1paQW1OYkUxUldndUVaSXJ3SUtmZ0x4TmlzQ1Zzek5n?=
 =?utf-8?B?Q3kvWTFTYVRjWWNHUkRFeDBXOTNGU3BKNHZCY05hOG9NZGVpeHIva1A0Wmow?=
 =?utf-8?B?MDV6VFl1UVpBYW5zdDhBNUxERkdXT1hwcHRJc2xDMFpUclpTazZDWXUwbkEw?=
 =?utf-8?B?OXVsaDIwcnF3R0ZadzE5S25wdHh5UzRsdEkrZGFwZTZTRGZwREZvc2hST2ZK?=
 =?utf-8?B?cS9rcHBvWUNRQ1U4eVR2UVFMczhoaWd0eFFjdHp2NS9PaXE5K0Mvb0tRckFn?=
 =?utf-8?B?dCt4bDBHeFgvQnd0aE5EU2hmOVhHRTh6aEZ5RmoxUlQvR09ZeEtGS2hjNTRR?=
 =?utf-8?B?OUtCOWVzYm9OeXVkZGFEdlR2QUV6QmxwekJXb1Q4OTJESGNhVjdId0VLU1oz?=
 =?utf-8?B?MGtjcEcvTHZZb294ejl3RVRKTG5QZzUrdE1Nd1dFMDJKMnlBV3pSVzFMQ3pN?=
 =?utf-8?B?TmY1V0kzRDlyWm9OMUR0TjJoVmxMV3ppNnl6dTN0UVdGUU45QXNXSC9kMHZt?=
 =?utf-8?B?dlR5N1BjbVBsckpCNW1sVFI0ei9EbE1INUhWUTkrMlVpSUZWMnhlR2xRclVX?=
 =?utf-8?B?b3ZkZTlGU2xNRHErR1gvaEZMMlZTSEpwWFh5Y0U5QXl0bXgrMWlJOU13c2cr?=
 =?utf-8?B?Vm02cGpxTDNBbEgzYmx5SmFwc2o0MUx2MWVxTE9FOSsybFlpUlVRY3VkOFFa?=
 =?utf-8?B?Tjhxb2JoQ1JHK2UwcFo5bHNBa2tuRkQ3Z3MzK09OQmdOTWJwNXNydm9yY3o3?=
 =?utf-8?B?djM1ZkhjbGlscVVFZVVrcE1xSnBoWVp2YXRDMkVRRVE0R0dUNlEvUFFiU2R6?=
 =?utf-8?B?QkpMaFVhVjhjdC9nYlNhT2xIN3dPdEdwUVpmeDExV1FhbG9QWkJ5eWpLTElw?=
 =?utf-8?Q?qRtJUAMTOUbSc5Zvs6PldJs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <989D088B69E55D45BA477C491113E788@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34790608-2c41-4fe1-bc45-08de0e5d09d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:43:09.2596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h78jyEDzp/a5+Wrok4Rvqa1+5Q+O0uIfulyZi1+WiOPOLNrLQSuUlrmB7GxlyK/dC8QsZL707T0aXO0Pg1DQfeeV9exG/CPYHe/B2ITod0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
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

DQpPbiAxNy4gMTAuIDI1LiAwMjo1NCwgQWxpc3RhaXIgRnJhbmNpcyB3cm90ZToNCj4gQ0FVVElP
TjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9u
LiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29n
bml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IE9u
IFdlZCwgT2N0IDE1LCAyMDI1IGF0IDExOjA34oCvUE0gRGpvcmRqZSBUb2Rvcm92aWMNCj4gPERq
b3JkamUuVG9kb3JvdmljQGh0ZWNncm91cC5jb20+IHdyb3RlOg0KPj4gSW4gdGhpcyB2ZXJzaW9u
IEkgcmVuYW1lZDoNCj4+ICAgIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3Jpc2N2NjRf
Ym9zdG9uLnB5DQo+PiAgICAtLT4NCj4+ICAgIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0
X2Jvc3Rvbi5weQ0KPiBJIGdldCBhbiBlcnJvciB3aGVuIGJ1aWxkaW5nOg0KPg0KPiAuLi90ZXN0
cy9mdW5jdGlvbmFsL21lc29uLmJ1aWxkOjEwMjo0NTogRVJST1I6IEZpbGUNCj4gcWVtdS90ZXN0
cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9yaXNjdjY0X2Jvc3Rvbi5weSBkb2VzIG5vdCBleGlz
dC4NCj4NCj4gQWxpc3RhaXINCg0KDQpIaSBBbGlzdGFpciwNCg0KDQpPdWNoLiBJIGhhdmUgbm90
IGNsZWFuZWQgdGhlIGJ1aWxkIC0gSSB1cGRhdGVkIHRoZSBtZXNvbiBmaWxlcw0KDQphcyB3ZWxs
IGluIHYxMy4NCg0KVGhhbmtzLA0KRGpvcmRqZQ0KDQoNCj4NCj4+IERqb3JkamUgVG9kb3Jvdmlj
ICgxMyk6DQo+PiAgICBody9pbnRjOiBBbGxvdyBnYXBzIGluIGhhcnRpZHMgZm9yIGFjbGludCBh
bmQgYXBsaWMNCj4+ICAgIHRhcmdldC9yaXNjdjogQWRkIGNwdV9zZXRfZXhjZXB0aW9uX2Jhc2UN
Cj4+ICAgIHRhcmdldC9yaXNjdjogQWRkIE1JUFMgUDg3MDAgQ1BVDQo+PiAgICB0YXJnZXQvcmlz
Y3Y6IEFkZCBNSVBTIFA4NzAwIENTUnMNCj4+ICAgIHRhcmdldC9yaXNjdjogQWRkIG1pcHMuY2Nt
b3YgaW5zdHJ1Y3Rpb24NCj4+ICAgIHRhcmdldC9yaXNjdjogQWRkIG1pcHMucHJlZiBpbnN0cnVj
dGlvbg0KPj4gICAgdGFyZ2V0L3Jpc2N2OiBBZGQgWG1pcHNsc3AgaW5zdHJ1Y3Rpb25zDQo+PiAg
ICBody9taXNjOiBBZGQgUklTQy1WIENNR0NSIGRldmljZSBpbXBsZW1lbnRhdGlvbg0KPj4gICAg
aHcvbWlzYzogQWRkIFJJU0MtViBDUEMgZGV2aWNlIGltcGxlbWVudGF0aW9uDQo+PiAgICBody9y
aXNjdjogQWRkIHN1cHBvcnQgZm9yIFJJU0NWIENQUw0KPj4gICAgaHcvcmlzY3Y6IEFkZCBzdXBw
b3J0IGZvciBNSVBTIEJvc3Rvbi1haWEgYm9hcmQgbW9kZQ0KPj4gICAgcmlzY3YvYm9zdG9uLWFp
YTogQWRkIGFuIGUxMDAwZSBOSUMgaW4gc2xvdCAwIGZ1bmMgMQ0KPj4gICAgdGVzdC9mdW5jdGlv
bmFsOiBBZGQgdGVzdCBmb3IgYm9zdG9uLWFpYSBib2FyZA0KPj4NCj4+ICAgY29uZmlncy9kZXZp
Y2VzL3Jpc2N2NjQtc29mdG1tdS9kZWZhdWx0Lm1hayB8ICAgMSArDQo+PiAgIGRvY3Mvc3lzdGVt
L3Jpc2N2L21pcHMucnN0ICAgICAgICAgICAgICAgICAgfCAgMjAgKw0KPj4gICBkb2NzL3N5c3Rl
bS90YXJnZXQtcmlzY3YucnN0ICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAgaHcvaW50Yy9y
aXNjdl9hY2xpbnQuYyAgICAgICAgICAgICAgICAgICAgICB8ICAxOCArLQ0KPj4gICBody9pbnRj
L3Jpc2N2X2FwbGljLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICstDQo+PiAgIGh3L21p
c2MvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTcgKw0KPj4gICBody9t
aXNjL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsNCj4+ICAgaHcv
bWlzYy9yaXNjdl9jbWdjci5jICAgICAgICAgICAgICAgICAgICAgICB8IDI0OCArKysrKysrKysr
DQo+PiAgIGh3L21pc2MvcmlzY3ZfY3BjLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAyNjUg
KysrKysrKysrKysNCj4+ICAgaHcvcmlzY3YvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgNiArDQo+PiAgIGh3L3Jpc2N2L2Jvc3Rvbi1haWEuYyAgICAgICAgICAgICAgICAg
ICAgICAgfCA0NzYgKysrKysrKysrKysrKysrKysrKysNCj4+ICAgaHcvcmlzY3YvY3BzLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDE5NiArKysrKysrKw0KPj4gICBody9yaXNjdi9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgIHwgICAzICsNCj4+ICAgaW5jbHVkZS9o
dy9taXNjL3Jpc2N2X2NtZ2NyLmggICAgICAgICAgICAgICB8ICA1MCArKw0KPj4gICBpbmNsdWRl
L2h3L21pc2MvcmlzY3ZfY3BjLmggICAgICAgICAgICAgICAgIHwgIDY0ICsrKw0KPj4gICBpbmNs
dWRlL2h3L3Jpc2N2L2Nwcy5oICAgICAgICAgICAgICAgICAgICAgIHwgIDY2ICsrKw0KPj4gICB0
YXJnZXQvcmlzY3YvY3B1LXFvbS5oICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICAg
dGFyZ2V0L3Jpc2N2L2NwdS5jICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0NCArKw0KPj4g
ICB0YXJnZXQvcmlzY3YvY3B1LmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4+
ICAgdGFyZ2V0L3Jpc2N2L2NwdV9jZmcuaCAgICAgICAgICAgICAgICAgICAgICB8ICAgNSArDQo+
PiAgIHRhcmdldC9yaXNjdi9jcHVfY2ZnX2ZpZWxkcy5oLmluYyAgICAgICAgICAgfCAgIDMgKw0K
Pj4gICB0YXJnZXQvcmlzY3YvY3B1X3ZlbmRvcmlkLmggICAgICAgICAgICAgICAgIHwgICAxICsN
Cj4+ICAgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMgICB8IDEzNiAr
KysrKysNCj4+ICAgdGFyZ2V0L3Jpc2N2L21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICB8
ICAgMiArDQo+PiAgIHRhcmdldC9yaXNjdi9taXBzX2Nzci5jICAgICAgICAgICAgICAgICAgICAg
fCAyMTcgKysrKysrKysrDQo+PiAgIHRhcmdldC9yaXNjdi90cmFuc2xhdGUuYyAgICAgICAgICAg
ICAgICAgICAgfCAgIDMgKw0KPj4gICB0YXJnZXQvcmlzY3YveG1pcHMuZGVjb2RlICAgICAgICAg
ICAgICAgICAgIHwgIDM1ICsrDQo+PiAgIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5i
dWlsZCAgICAgICAgfCAgIDIgKw0KPj4gICB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9i
b3N0b24ucHkgICAgIHwgMTIzICsrKysrDQo+PiAgIDI5IGZpbGVzIGNoYW5nZWQsIDIwMjEgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3Mv
c3lzdGVtL3Jpc2N2L21pcHMucnN0DQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3Jp
c2N2X2NtZ2NyLmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L21pc2MvcmlzY3ZfY3BjLmMN
Cj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3Jpc2N2L2Jvc3Rvbi1haWEuYw0KPj4gICBjcmVh
dGUgbW9kZSAxMDA2NDQgaHcvcmlzY3YvY3BzLmMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvaHcvbWlzYy9yaXNjdl9jbWdjci5oDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL2h3L21pc2MvcmlzY3ZfY3BjLmgNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUv
aHcvcmlzY3YvY3BzLmgNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9yaXNjdi9pbnNu
X3RyYW5zL3RyYW5zX3htaXBzLmMuaW5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQv
cmlzY3YvbWlwc19jc3IuYw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L3Jpc2N2L3ht
aXBzLmRlY29kZQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25hbC9yaXNj
djY0L3Rlc3RfYm9zdG9uLnB5DQo+Pg0KPj4gLS0NCj4+IDIuMzQuMQ==

