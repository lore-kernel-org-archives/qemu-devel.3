Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDC3FEFB49
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 12:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvx8v-0004v9-A5; Fri, 27 Feb 2026 07:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvx8t-0004uo-71; Fri, 27 Feb 2026 07:40:27 -0500
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvx8q-0000Nx-UW; Fri, 27 Feb 2026 07:40:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj9kHVfwUz50f0UFkEgeGYNX4w9j/zWgR03UlkHmb3th3RDT/eCOQEVZBC0d22Kfq6PXCRurIevGeqEf/pHFDQRRyJOn7ffz8l3ap2e0lnecqjlOlTEiiRUrdV5D+g6x+t3gdRCmHy4oxvxBC3whzpulLlX7y81XhdJ3jZKXAVPjMR33W3uTAhaN20iyhGlkp7jhk/kF2DQnkn7MwBpupLxdtftBraM/P4lK6xFNfYXm0qHX7qM+MVeRNGqN3NTdJzo/zIX7zAz+wDhwk5a19tPuJWFRmujlPu0iAiTUxq8q/IUboTvKeX0TvrnQdR8CWdizsjQAP3lQz57tVVm+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mI1+7p9AUC3CqwoyU/ZrCad8PDabagTaR2YKeHVL8wk=;
 b=U+GmaM148IJBMEvh7kmZYM/nwK2ixNdDyXyhHlUVeJfXDZUjTJrwkokAmVLVVCfBUyOPdJTHlAlchAH3eOgsg7z2dfhLwDi0g70g8vMJH80Z11g2eMD/0x5vZcZkgu9cWe3HAkB7IP20xX/Ws2I7Ca+HlC1QRVJnxPaEAHqGnPQIrIIyXXNgLBEwmOjzjnKUE5c9u/9gN9ifEUH90ifqeFbS6aUkzsTLfjhvbHlozUNmjft4NOGjGYEoevof9ilsahl13dbDgr5xFTuB3dtTTdlbvNseqDA8USwH9IzBnI55EUOOVJDmGAterbaGVGW5mh3xbVnO1lZbYlDjXLo/Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mI1+7p9AUC3CqwoyU/ZrCad8PDabagTaR2YKeHVL8wk=;
 b=BhHGTzagaZf5x41gT1vYdu3Uuf39+jlcQTDWgTFIT72x8ceEj3LoKn0zI//Tlsb7mVk+IArrEaqM0qC1M7y+m6vJrFwFIYt9Q6wLS1xehnFbDVsiUdSuZAGCRcsKyyuZuCuGBubXu8Eklfch3ij+XfGB4pWl/4zH409BTVHCS/qTUEP3WTqT9NntfMt+IkwqpsMgHej8ArJ24/NhW1GDFBtayR1QWjQj7HIhP0cdqVKb8/fC8wit5Qk0Wi0pnTcKjzGdRMW80Tjpb/+8iqhrB0GxcD7uv//gi5OPHwo7G1k4nNaVaG84tYGakgWZaKfj0BunLgybGdOEWkMf8YLXIQ==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by DUZPR09MB6704.eurprd09.prod.outlook.com (2603:10a6:10:4dc::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:40:20 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:40:20 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Alistair Francis <alistair23@gmail.com>, Mohamed Mediouni
 <mohamed@unpredictable.fr>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com"
 <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Topic: [PATCH v2 00/16] Add RISC-V big-endian target support
Thread-Index: AQHcpkBaA1l4l1CIU02NL47xpBxJMLWTSjoAgAJY6wCAANzQgA==
Date: Fri, 27 Feb 2026 12:40:20 +0000
Message-ID: <74977a25-e92e-46d9-b522-50b8fe2d00cc@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <A02120BF-779D-4B2C-B29D-A9CB044EA895@unpredictable.fr>
 <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
In-Reply-To: <CAKmqyKO6ioRt+h_tZrudbriv-QDVsOG1LNJ+GFQJ3ZO-fEhjiA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|DUZPR09MB6704:EE_
x-ms-office365-filtering-correlation-id: b832f39a-560c-49e4-d710-08de75fd5e58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: ghlTY30OzyBJdWsfXCNPxi+MWIgnfISZYfnrA9oKE5HQZP1P2p5aptSmR+lmBsQXCgXj5OfdM3m80kJz/rJ4fVMEshW86pOvCl0Ag+OfxYVtBJTiUd2LbOiL34XcR0C/WsClRuQRD5UOG1ohE5a8PBlvFR6oxZ1FBJxBOaRQRwhyl8Sujow4yZrvFqokDj9Xsp0evb5GZdKCIpc/2LqllYyoEMx7ifDA0tETHfiuvK8CgmoKb9aMTi8T2vY11bh4Yysjm+trj1B7yMrzCWHMt6pkDDP/SYbH+LpOn3F+W+I/MQQlpwQGmGSsbYUUoYV/8Mg+965STm0U8rWPo9onhdA7zz/2szTDTVDSEQPkRI/wuR8t+iZ3y0BXqyamIZhnJ5orKc4FkrPRPnlOMamWlsz3lSQPSvVktBiaVjUOfDn5iz/lIT+af/YER84UiG3aACBowq47rYqzaMqF3/3cmU4gue5SPKyZfa23D2FGAGfZKM+ARmLYGY/0qrvvJ3LsoYMZalD9jMLoeNtKqcWt+ajCsKo/MtcAY5dhsvDKuqwYIG0+XiWm60J7XGXEQZqrEJ4ta72hrzus0wZ24UgylXjsNujernON+BXW+OTTTaSX3twSXRnnVgbDsImLrbQEKWjb9MyJ8Cm2AjMeYwcYgGGgFWWYWuI/ySZQ4fsWrZSrzxVr0U43d/cuqWTKg+4PBqhwah1Vc1BpkrRknJCtZDtpzTc1sRGzDEZUmDMwIDYLjRfq67+VkWofN/Ln0pkg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0xBYzlwdlJreVBuVzZRaEVQQ3padG50aXcyZkR4bDVJaFFBVndUeXFXMTY3?=
 =?utf-8?B?cVRDb3RiVWJDdDRCbnVxZnBuRlZ2RGlVMWZpL05ZMkRGL3NPSTBwV25HTmwr?=
 =?utf-8?B?aE5tSTlZVzlOb1FyYnFNazh3cGxrTlNKQlBac09KK0RCMStKUkZxMnloN2pC?=
 =?utf-8?B?ZDMyRlQrUGl4SGpRK0s2Nm9uL3pkamtpZHRvRmQvbmdIRHRKUW1odUxPVWpv?=
 =?utf-8?B?SUcxVGY0d21KZ0R3NFh0d1MwMWkwL0hnbE1jaWtLeDlxUUFSQVJrem92SGFN?=
 =?utf-8?B?R3k0dzZwaWlyMGZFNk9WZm9MWmpjNGdraWc0Z3gwdWQ5clF2NTNCWmVpZm8r?=
 =?utf-8?B?RkVFUXBvRGtieUdrZTVFUFN4NXRvOE1keXBqNjB2M0VjNkM5R0VmUEd2UFlr?=
 =?utf-8?B?b2t3ZTNJcnUxWVk4OGZSSElkTll6YXVuUXBxUjYydEwralZlLzg2U2krNzRp?=
 =?utf-8?B?M0V3WlFHV05hQ0JYQ0R3U2FEc2JiRW1wNWlMQ3ViUDVoTFhWS2g1V3d4cnI4?=
 =?utf-8?B?VlZuSTM3NFZZb0VKalErbmphcERvbFViOHRoVDVlVlRDUERVaWlnYmVBZC8y?=
 =?utf-8?B?MmlaK3JCRXdkTU00amVKdytVVXQrNlBWTDBsS2ZiVlpvMG8raXFZNEQyRlg0?=
 =?utf-8?B?Y1hkWndTMERyeXBWcEVsY3Jta3RkQTdUZGxTMlVkNWl6ajlZU1RtVEx6ZDR4?=
 =?utf-8?B?bDMwRUtGNWd4eVRxRlhLdVA4aThXbml4bENDaUVVMzJkKzdDVnBUaTZrRjdt?=
 =?utf-8?B?ank2SE14dy9qdmFRaTRhVFBXcC84UGVpV0VKV2NhMUF3c1JLUVYzWHNsdTcw?=
 =?utf-8?B?NmFWOUJadFU1KzRvdzZZa1dHUitjK2JCUS9YUjBPU242MWVvQ3h3TkUzeFE3?=
 =?utf-8?B?RTVsRSs0NVZHSUpJM080NWdhMHJpRG5NL1A2RkJtWHhtdmhBVUVSMzQwQnpJ?=
 =?utf-8?B?QmxaSzhUYTVZN001aGxQWVFsUEFiREpBVFlCR2lTQW5tazYydXdTK0RHckp0?=
 =?utf-8?B?bVF5clFXeGJNVUF2T1BianpWQ0p3MjJKem5zd3p4N2FlKzlvdGtaY25adzZW?=
 =?utf-8?B?RFBoOXJPdmZPdmJsWGJYMUdMTDJOMWNZci9tMnVmWVR6dGQwUkI1dFJKMGZu?=
 =?utf-8?B?M3ZVMXhJMkF4YXJHQXp3SUlJYWI1OWl3NWR6QWNYaDl4a1VZN21oM2ZYNDN0?=
 =?utf-8?B?UUlTZzJvazZMK2dpRG5PS2V3SVNXREh2Z2UrQTkzRWZQME83cDluMk50T2NH?=
 =?utf-8?B?V1duaHlmK2djSm4zN1NTbCtDaDdUSTBQZ3I0Zkt6NnBtVHZXSW5tSFNLTThB?=
 =?utf-8?B?c01YYlFjN0RYaG1Tck8wTk5yNnUvWmpVZXdMZW85N1F3WVphQm4yMGo3Y1lq?=
 =?utf-8?B?bm11enVCei9tV1FBYjMvTldXeTNiYTFhMFA2UVQ2SU5wS2prVC9TbVNyQXhx?=
 =?utf-8?B?YjJlSW5RM2RyYWdFQWIyR1NEczZSMGphTHFxS1Zucmpxdk9EMzVZQ0RFV05Z?=
 =?utf-8?B?KzgvQk5mcElBN3gyU2VIcm0vT1YveXQ0c3g1eUVJanh0ekU5M2F3SER2T3ZV?=
 =?utf-8?B?ZzJSakZWQWtnMlRNYVRXZHdOVERUcTVGRFVvQTg0RklXYkx2YW80cVYxNFJU?=
 =?utf-8?B?bDdVV3ZJaEtIckprZkMrbzVjQTdTdktEK1o3ZzdJZC9zMm9zNFpkMXlPODUy?=
 =?utf-8?B?TTc2SEVac3E4SGlQMWhoWlZjT1kvRzlDMGdoOEIvL1VqY2pMdjU0cFJyVUpO?=
 =?utf-8?B?RGRoNlR3S3F6RjF0MzNHVHRycjhLbzR4Z1F2MVRyN1I2MTN6MzdYNDRmVVMx?=
 =?utf-8?B?YXMycmxibHJ6RXd3OExCYml4RjR1NzFXemFuR20wcENLTERzbFRsSEJGbjJs?=
 =?utf-8?B?UFROQ01nOGpXc3QzZk5waThGYkdLTitHVmxIdzZPSG1scVFNZW05VjJuUUU0?=
 =?utf-8?B?WDVSbndZekRCMW5DQkJQM2Z2Q2NsMlV3ZUw4Z0tEdlBTRWxybThvSFg2cHVs?=
 =?utf-8?B?UXE2bVh4bUJibnZrVitZRi9OM0pyNEZkc1Zxak1EdVlGTWRibHdwc29pNDE3?=
 =?utf-8?B?cy9iL1VINDE3ZzdIdkRIZzdwZEVJdG1VdGJiN0ZZekR4cUFXb0RWMGF3eDkx?=
 =?utf-8?B?bklBVnRtbWhqamVnckF1M295QVQ3SGt3S2kxWXFoOVZSRTYxN0FiazROaU5i?=
 =?utf-8?B?SDk1ZmNVL0lGbmJGT21rekJSQitKWlZOL1o3WUtjOUN2dnhaYk84dFoyWW5n?=
 =?utf-8?B?Z0VTRmJBVEZtTVJCdmdiM3V3N3VhaDZNNHluZFhMa1F0MFRFdUZKWENmeC9q?=
 =?utf-8?B?VVZOZzFRS2dGOExrTkxReVNEblhJWkJBS1RwTzJUL3hZcm15ejVDWlZHYkQr?=
 =?utf-8?Q?SU5gMSt8xSTY311I0+kPya49jCtPDPs211VfT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1948D809C9333A46B3ECC3B49DF81CE1@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b832f39a-560c-49e4-d710-08de75fd5e58
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 12:40:20.3208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: biY/+NO8p8gr5VAAwJkae6DrgIBPM1J+tNobtgsS3ZtgXTBXXsLN5fdwe0+QQVrSzpn/JU1PC6dySN82vSMzbNHYnW3s/Rttv0I06NPgz9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR09MB6704
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQpPbiAyLzI3LzI2IDAwOjMwLCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiBDQVVUSU9OOiBU
aGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXpl
IHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gT24gV2Vk
LCBGZWIgMjUsIDIwMjYgYXQgOTozOeKAr1BNIE1vaGFtZWQgTWVkaW91bmkNCj4gPG1vaGFtZWRA
dW5wcmVkaWN0YWJsZS5mcj4gd3JvdGU6DQo+Pg0KPj4NCj4+PiBPbiAyNS4gRmViIDIwMjYsIGF0
IDExOjIwLCBEam9yZGplIFRvZG9yb3ZpYyA8RGpvcmRqZS5Ub2Rvcm92aWNAaHRlY2dyb3VwLmNv
bT4gd3JvdGU6DQo+Pj4NCj4+PiBUaGlzIHNlcmllcyBhZGRzIGJpZy1lbmRpYW4gKEJFKSBSSVND
LVYgdGFyZ2V0IHN1cHBvcnQgdG8gUUVNVSwNCj4+PiBjb3ZlcmluZyBib3RoIHNvZnRtbXUgYW5k
IGxpbnV4LXVzZXIgZW11bGF0aW9uIGZvciByaXNjdjMyYmUgYW5kDQo+Pj4gcmlzY3Y2NGJlLg0K
Pj4gSGVsbG8sDQo+Pg0KPj4gVGhlcmXigJlzIG5vIExpbnV4IFJJU0MtViBiaWcgZW5kaWFuLiBN
YXliZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8gaXMgdG8gbm90DQo+PiBzdXBwb3J0IGl0IHVubGVz
cyB3ZeKAmXJlIHN1cmUgdGhhdCBpdCBjYW4gZ2V0IHRvIExpbnV4IHVwc3RyZWFtIChmb3IgdGhl
IGxpbnV4LXVzZXIgbW9kZSk/DQo+IEFncmVlZC4gV2UgcmVhbGx5IG5lZWQgdXBzdHJlYW0gTGlu
dXggc3VwcG9ydCBiZWZvcmUgdXNlciBtb2RlDQo+DQo+PiBUaGFuayB5b3UsDQo+PiAtTW9oYW1l
ZA0KPj4+IFRoZSBSSVNDLVYgSVNBIHN1cHBvcnRzIGJpZy1lbmRpYW4gb3BlcmF0aW9uIHZpYSB0
aGUgbXN0YXR1cyBTQkUvTUJFL1VCRQ0KPj4+IGJpdHMuIFdoaWxlIGluc3RydWN0aW9ucyBhcmUg
YWx3YXlzIGxpdHRsZS1lbmRpYW4sIGRhdGEgYWNjZXNzZXMgZm9sbG93DQo+Pj4gdGhlIGNvbmZp
Z3VyZWQgZW5kaWFubmVzcy4gVGhpcyBzZXJpZXMgaW1wbGVtZW50cyB0aGUgbmVjZXNzYXJ5IFFF
TVUNCj4+PiBpbmZyYXN0cnVjdHVyZS4NCj4gSG93IGFyZSB5b3UgdGVzdGluZyB0aGlzPw0KDQpI
aSBBbGlzdGFpciwNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzIQ0KDQoNCkV2ZW4gdGhvdWdo
IHRoZSBTVyBlY29zeXN0ZW0gaXMgbm90IGNvbXBsZXRlL21hdHVyZSwgdGhlcmUgaXMNCg0KcHJl
dHR5IGRlY2VudCBzdXBwb3J0IGluIEdOVSB0b29sY2hhaW4gZm9yIHJpc2N2IGJpZy1lbmRpYW4g
YWxyZWFkeS4NCg0KR05VIEdDQywgYmludXRpbHMsIGV0Yy4gYXJlIHByZXR0eSBva2F5LiBJIGFt
IG5vdyB3b3JraW5nIG9uIHRoZQ0KDQp1cHN0cmVhbWluZyBwcm9jZXNzIG9mIHJpc2N2IGJpZy1l
bmRpYW4gaW4gTExWTSBwcm9qZWN0LCBhbmQgY29tcGlsZXINCg0KcGFydCBpcyBhbHJlYWR5IG1l
cmdlZCAtLSBhbG1vc3QgZG9uZSB3aXRoIExMRCAoTExWTSBiYXNlZCBsaW5rZXIpDQoNCmFuZCBM
TERCIChMTFZNIGJhc2VkIGRlYnVnZ2VyKSBhcyB3ZWxsLg0KDQoNCkZ1cnRoZXJtb3JlLCBJIGhh
dmUgYWxzbyBpbXBsZW1lbnRlZDoNCg0KMSkgYmFzaWMgbGludXggc3VwcG9ydA0KDQogwqAgaHR0
cHM6Ly9naXRodWIuY29tL2RqdG9kb3JvL2xpbnV4L2NvbW1pdHMvcmlzY3YtYmUtcHJvcG9zYWwv
DQoNCjIpIGFzIHdlbGwgYXMgc29tZSBiYXNpYyBDSSBzdXBwb3J0IGZvciBiYXNpYyBjYXNlczoN
Cg0KIMKgIGh0dHBzOi8vZ2l0aHViLmNvbS9kanRvZG9yby9yaXNjdi1iZS10ZXN0LXN1aXRlDQoN
CnNvIHFlbXUgaXMgdGVzdGVkIGFnYWluc3QgdGhlc2UgdHdvIGFzIHdlbGwuDQoNCg0KQXQgdGhl
IGVuZCwgd2UgZG8gc2VlIHRoYXQgZXZlbiBvbiBHTlUgR0NDIG1haWxpbmcgbGlzdCwNCg0KcGVv
cGxlIGFyZSBzZWVraW5nIGZvciBhdCBsZWFzdCBiYXNpYyBzdXBwb3J0IGluIHFlbXUgZm9yDQoN
CnJpc2N2IGJpZy1lbmRpYW4gdGFyZ2V0LCBzaW5jZSB0aGUgdGVzdGluZyB3aWxsIGJlY29tZSBt
dWNoDQoNCmVhc2llciwgc2luY2UgR05VIFN5bSBkb2VzIHN1cHBvcnQgaXQsIGJ1dCBpdCBpcyBu
b3Qgcm9idXN0DQoNCmVub3VnaCAoYXMgcWVtdSkuDQoNCg0KVGhhbmtzLA0KRGpvcmRqZQ0KDQo+
IEFsaXN0YWlyDQo+DQo+Pj4gRnVydGhlcm1vcmUsIE1JUFMgYW5ub3VuY2VkIGNvcmVzIHdpdGgg
QkUgY29uZmlndXJhdGlvbjoNCj4+PiAgIGh0dHBzOi8vbWlwcy5jb20vcHJvZHVjdHMvaGFyZHdh
cmUvaTg1MDAvDQo+Pj4NCj4+PiBQYXRjaGVzIDAxLTAzOiBCdWlsZCBzeXN0ZW0gYW5kIGNvbmZp
ZyBmb3IgbmV3IEJFIHRhcmdldHMNCj4+PiBQYXRjaGVzIDA0LTA3OiBDb3JlIGVtdWxhdGlvbiBm
aXhlcyAoaW5zdHJ1Y3Rpb24gZmV0Y2gsIGJvb3QgUk9NLCBFTEYNCj4+PiAgICAgICAgICAgICAg
ICBsb2FkaW5nLCBmd19keW5hbWljIGVuZGlhbm5lc3MpDQo+Pj4gUGF0Y2hlcyAwOC0xMTogTGlu
dXgtdXNlciBCRSB0YXJnZXRzIGFuZCB2RFNPIGhhbmRsaW5nDQo+Pj4gUGF0Y2ggIDEyOiAgICAg
U2V0IFNCRS9NQkUgbXN0YXR1cyBiaXRzIGF0IENQVSByZXNldA0KPj4+IFBhdGNoICAxMzogICAg
IEZpeCBQVEUgQS9EIGF0b21pYyB1cGRhdGUgZW5kaWFubmVzcyBpbiBwYWdlIHRhYmxlIHdhbGtl
cg0KPj4+IFBhdGNoICAxNDogICAgIENsZWFuIHVwIGluc3RydWN0aW9uIGZldGNoIHRvIHVzZSBN
T19MRSBkaXJlY3RseQ0KPj4+IFBhdGNoICAxNTogICAgIEZpeCB2aXJ0aW8tbW1pbyBsZWdhY3kg
ZGV2aWNlIHJlZ2lzdGVyIGVuZGlhbm5lc3MNCj4+PiBQYXRjaCAgMTY6ICAgICBBZGQgcmlzY3Yz
MmJlIGFuZCByaXNjdjY0YmUgdG8gU3lzRW11VGFyZ2V0DQo+Pj4NCj4+PiBEam9yZGplIFRvZG9y
b3ZpYyAoOSk6DQo+Pj4gICBtZXNvbjogQWRkIEJFIFJJU0NWIHRhcmdldHMNCj4+PiAgIGNvbmZp
Zy90YXJnZXRzOiBBZGQgQkUgUklTQ1Ygc29mdG1tdSB0YXJnZXRzDQo+Pj4gICBjb25maWcvZGV2
aWNlczogQWRkIEJFIHJpc2N2IGNvbmZpZ3MNCj4+PiAgIHRhcmdldC9yaXNjdjogRW5zdXJlIExF
IGluc3RydWN0aW9uIGZldGNoaW5nDQo+Pj4gICBody9yaXNjdjogRW5zdXJlIGJvb3Ryb20gaGFz
IGNvcnJlY3QgZW5kaWFuZXNzDQo+Pj4gICBody9yaXNjdjogRW5zdXJlIHByb3BlciBFTEYgZW5k
aWFuIGV4cGVjdGF0aW9uDQo+Pj4gICBody9yaXNjdjogQ2hlY2sgZW5kaWFubmVzcyBmb3IgZndf
ZHluYW1pYyBmaWVsZHMNCj4+PiAgIGNvbmZpZy90YXJnZXRzOiBBZGQgUklTQy1WIHVzZXJzcGFj
ZSB0YXJnZXRzDQo+Pj4gICBhcmNoL3Jpc2N2OiBTZXQgVUJFIGJpdCBvbiBCRSB0YXJnZXQNCj4+
Pg0KPj4+IGRqdG9kb3JvICg3KToNCj4+PiAgIGNvbmZpZy90YXJnZXRzOiBBZGQgbWlzc2luZyBm
aWVsZHMgdG8gQkUgbGludXgtdXNlciB0YXJnZXRzDQo+Pj4gICBsaW51eC11c2VyL3Jpc2N2OiBE
aXNhYmxlIHZEU08gZm9yIGJpZy1lbmRpYW4gdGFyZ2V0cw0KPj4+ICAgdGFyZ2V0L3Jpc2N2OiBT
ZXQgU0JFIGFuZCBNQkUgYml0cyBhdCBDUFUgcmVzZXQgZm9yIEJFIHRhcmdldHMNCj4+PiAgIHRh
cmdldC9yaXNjdjogRml4IFBURSBBL0QgYXRvbWljIHVwZGF0ZSBlbmRpYW5uZXNzDQo+Pj4gICB0
YXJnZXQvcmlzY3Y6IFVzZSBNT19MRSBmb3IgaW5zdHJ1Y3Rpb24gZmV0Y2gNCj4+PiAgIGh3L3Zp
cnRpbzogVXNlIERFVklDRV9MSVRUTEVfRU5ESUFOIGZvciB2aXJ0aW8tbW1pbyBsZWdhY3kgb3Bz
DQo+Pj4gICBxYXBpOiBBZGQgcmlzY3YzMmJlIGFuZCByaXNjdjY0YmUgdG8gU3lzRW11VGFyZ2V0
DQo+Pj4NCj4+PiBjb25maWdzL2RldmljZXMvcmlzY3YzMmJlLXNvZnRtbXUvZGVmYXVsdC5tYWsg
fCAxNSArKysrKysrDQo+Pj4gY29uZmlncy9kZXZpY2VzL3Jpc2N2NjRiZS1zb2Z0bW11L2RlZmF1
bHQubWFrIHwgMTYgKysrKysrKysNCj4+PiBjb25maWdzL3RhcmdldHMvcmlzY3YzMmJlLWxpbnV4
LXVzZXIubWFrICAgICAgfCAxMSArKysrKw0KPj4+IGNvbmZpZ3MvdGFyZ2V0cy9yaXNjdjMyYmUt
c29mdG1tdS5tYWsgICAgICAgICB8ICA4ICsrKysNCj4+PiBjb25maWdzL3RhcmdldHMvcmlzY3Y2
NGJlLWxpbnV4LXVzZXIubWFrICAgICAgfCAxMSArKysrKw0KPj4+IGNvbmZpZ3MvdGFyZ2V0cy9y
aXNjdjY0YmUtc29mdG1tdS5tYWsgICAgICAgICB8ICA4ICsrKysNCj4+PiBody9yaXNjdi9ib290
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCA0MSArKysrKysrKysrKysrKysrLS0t
DQo+Pj4gaHcvdmlydGlvL3ZpcnRpby1tbWlvLmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDIg
Ky0NCj4+PiBpbmNsdWRlL2h3L3Jpc2N2L2Jvb3QuaCAgICAgICAgICAgICAgICAgICAgICAgfCAg
NSArKysNCj4+PiBsaW51eC11c2VyL3Jpc2N2L3RhcmdldF9lbGYuaCAgICAgICAgICAgICAgICAg
fCAxMCArKysrLQ0KPj4+IG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICA3ICsrKy0NCj4+PiBxYXBpL21hY2hpbmUuanNvbiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMyArLQ0KPj4+IHRhcmdldC9yaXNjdi9jcHUuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAzICsrDQo+Pj4gdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggICAgICAgICAg
ICAgICAgICAgICAgIHwgIDIgKw0KPj4+IHRhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgICAgICAg
ICAgICAgICAgICAgICB8ICA5ICsrLS0NCj4+PiB0YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMgICAg
ICAgICAgICAgICAgICAgICAgfCAxNiArKysrLS0tLQ0KPj4+IDE2IGZpbGVzIGNoYW5nZWQsIDE0
NSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMoLSkNCj4+PiBjcmVhdGUgbW9kZSAxMDA2NDQg
Y29uZmlncy9kZXZpY2VzL3Jpc2N2MzJiZS1zb2Z0bW11L2RlZmF1bHQubWFrDQo+Pj4gY3JlYXRl
IG1vZGUgMTAwNjQ0IGNvbmZpZ3MvZGV2aWNlcy9yaXNjdjY0YmUtc29mdG1tdS9kZWZhdWx0Lm1h
aw0KPj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3RhcmdldHMvcmlzY3YzMmJlLWxpbnV4
LXVzZXIubWFrDQo+Pj4gY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3MvdGFyZ2V0cy9yaXNjdjMy
YmUtc29mdG1tdS5tYWsNCj4+PiBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy90YXJnZXRzL3Jp
c2N2NjRiZS1saW51eC11c2VyLm1haw0KPj4+IGNyZWF0ZSBtb2RlIDEwMDY0NCBjb25maWdzL3Rh
cmdldHMvcmlzY3Y2NGJlLXNvZnRtbXUubWFrDQo+Pj4NCj4+PiAtLQ0KPj4+IDIuMzQuMQ0KPj4+

