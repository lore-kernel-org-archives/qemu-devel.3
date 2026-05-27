Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F7CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9gn-0001Kn-Uz; Wed, 27 May 2026 04:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gX-0001FU-Iy; Wed, 27 May 2026 04:32:17 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gU-0003yk-NM; Wed, 27 May 2026 04:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zdqzk5Cw0j5LIt5hiFZMM8Hz+uqYDpsYHYG0vJCHrMT69/ZYxu6f034Y10xEOPQ9aYyelzz/Md4DDaDz4YbtG1hAHoLHMxO/CbhEYMsspB21L1vjQqtfHO736pgbTW9evARoJDb8yLDEqB1aAfN2GZ0PQo12z1oN3PKhfzFoAf7INos1qr98rq29+MaYbyEsBuPQffIfXg7KulZ7Ii5DDFvQDiCgzgqqiM9H9E0zKrsYWAFJErRS1Aih/xAdoc9fUPBoAzMGvtorDucB/BjpLhBsObQ5xoty5/vZAETSM6Vdo8uUDtAInf2MyVLeq9Tb40I0fQmqKxoD+HQbPtCUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBjW1oJhftg8bgEbtsan9gmAdg3hteb6BLqkqe4Tq94=;
 b=F5l96DEwCuUX8vLB3Zg8u+4o7y6X5PEl2DQsLcKDq4Xw9xbu4ikLx5APp8WUDpPs/6zkLLMy6VwPnMgxEPJ5sowCSdiSWqMGtu+w3TPcC4SeqGxDHdQRqC66YRuQE8HWYzhzizVqUAGntgN5eHaY9UVM7/D91UVT34jJ7N+J588DoXXMYA2KlkWX26/NrzZ5YCiBuNsJxoYo+DzKcWxJCl+AynhI0NWg371N33Ms6NclMVB+amqgZUrLipeS0+ircMjZ8b9v+FHos4PRIwCtTN5cPGLlM7io0oIXcTQlTS7hdYShFx5UxF7WcElyWcDLHySugaazSZ7C75FzGd78bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBjW1oJhftg8bgEbtsan9gmAdg3hteb6BLqkqe4Tq94=;
 b=dP3x8ZzMJeSbzDCBCz748BrJvF9M1bF9DgSuq7KaofrgZGO3X4UN/owjlGq3Vtgb409t1dhEpMTQobkaniohPxG71Vb2E5aWH354Kb0vLFdf9IG8rzpGJpSyG3EgwutKCHEyM37dK7Vu2JouiCQ/BvNNamQbJT7X6EQ1M8w0eCA+QQ0taTFNpa6r6sUf1HHz/a/FTos3YSIjYDvBK7xbfSA/9A4bZ1sAS0EogExqvCH1iOYxDVxjgk2/+2yr8721Ofs5Z+VkXdRNyDJcxVByIzspl0UFcJg8GsPWsHx+ZEw78kYUJX1jhcFiPNAvEt0xz1G1+gvqaZy6Eu4ABAUpiw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:32:00 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:32:00 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Topic: [PATCH v10 5/7] target/riscv: Fix page table walk endianness for
 big-endian harts
Thread-Index: AQHc7bNJ7UAOLkUofEKf/bNON3MNrw==
Date: Wed, 27 May 2026 08:32:00 +0000
Message-ID: <20260527083151.17876-6-djordje.todorovic@htecgroup.com>
References: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AS8PR09MB6314:EE_
x-ms-office365-filtering-correlation-id: b0a3c141-3798-42f4-a93e-08debbca6c39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info: uQkeF8Re5D27if+06UVwQB2x0dhPR6G57jTfpaUTLWzJP/w76CQSRTOMcUa9LWquXMj2a0aQ1w1TbRwJzt92AIfEKo3oA/p6Edtkffyivh61veSudXdd7OSanW6XH4DXAU9MvsDtnu6DiH7nf4EHMnuO0TbKtRjuGp6hiKyjRfB8aDVLu93moLEdH3GhIKSs3Bk4aaVaCg8HScVopRVqDyWSc9n6THLXEF0b+jpzB5oWaWlw90VmbCrTJueqcoOgX95pNrhFUlQMhNKTEqB6PANxQ8syZSsHUnolJIc0K5zz1UEoMh7c4Qwu5ZqIt3OzpOP6WRKq6xHo5lgqlAtBvB5GJwjeisTKv7BMo9wVyZ66V8kgCm9mQ9w3cANER+4DEArX4rSSHX5VOj286s2SeSAo8BGhU6WHMHxVPg3erXQWcFV2oSPM87DjrUQ+IyExTZdl/58E7WAPWgRuh1WyPkwPRz5EeZi5q1mNB0xDbce3Md8wlZmFASpVYVvdmYE9Kj91XMpgsxP/Do4pyHQ39xOE9e45priyyVsh8QWbWsr5V061EbySB8LGGgUVhs3VruwWG642HahSNxRIjYO2JFt3Cz2zoObE2DCXpCGI+0r+JpipDtSScQVgQU8znQf3pJgJXvKJbM8dv8HxdGoZB77z9vmAg0kPWgjQ0MPl6FpKrBBAZFsoYVViFYFtjovxXGRqsFeAoqDdlxuGP2ob8hv/VZmlgzb4BLui/TyRTDRyh4J8boOnJS61WCLPTzK3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnkyUlFJQXJVMmdsTHRNdGFZY2pLNG5JUDJyM2lNVURFOWh3emdEanZDZDRx?=
 =?utf-8?B?djg1ZDBya0IvNnR1L2RpbHVKdE40UTA2VHE2b1A5MFpGZTVHQVdwbGgrQ290?=
 =?utf-8?B?Tm1YZWVmZXFkT3ZlUmpDYTAyUTdlNE5FU3ZTczRJakVRR1VvanRrSXZGa3Rm?=
 =?utf-8?B?NitaZWJJU1BqR1RDSTR3MGVlTFUrUXllbjVPSlFOSGtIVTJ5QzJpQXBZNno0?=
 =?utf-8?B?KzJEN0RqeHlyUFU4eVJzdHFkY1N5SktjNFhsQWZ5cEd6NEFBZ05yRmFWOURh?=
 =?utf-8?B?Y3pudFVkb1VwWmNFb0hOTzlQa29IRWh3MmlOL3hVb3p2SEdzbVlpTFdVZzE4?=
 =?utf-8?B?bnIxazlQSWRrVWNIRy9VVDlraVpZRGZNS1FPWHFIOHFJdHo1YU44YTU1R0hH?=
 =?utf-8?B?MjQ1aEd0NFF6MzVpTXRpQUFaWkxtMHNsNU9leVc0cHI2dGQ1cWxTU3l1Ti83?=
 =?utf-8?B?L3A1VDNGUGl5ZStzeTRDL1MzNkNZOEdaMDlTUmozbjBrbVZPOWFaRlZMTVFs?=
 =?utf-8?B?WEg4ZlhaNS9JTE5DRVlDaUc5YXE5RWM4ZFYzMWJnOUlNU2hrU0F0ZDFJNnc0?=
 =?utf-8?B?Y2pmbk5UL1dHNU5XbUJmZkZwc1dHTERNRmhsUzl0RGtZdFExMDA1cGdCL2p2?=
 =?utf-8?B?RzRvelkvd0piblBnalZnVU81akswK0RlOUpYbHdjcFJibEpKUnEvbUxtVElM?=
 =?utf-8?B?NjFpMUNLS0loVnA0Y1htUnNQYWxYL3RQVW1xZDB0QUMxZUh2TzBEWk40b2l6?=
 =?utf-8?B?SW4rYlBXeXREUnBjWlQ4c0hhU2xKeTZLd21SOUtSMFJlcU9pVndNWWErb3ZK?=
 =?utf-8?B?Vlo3cHhVZytmT2FwbHZCNkdISWRHRlhOLy83czk5RWI2Y1lJM1JvS0R0djRx?=
 =?utf-8?B?a3puUVJnUldiU0tJNHdQeWxqNUtWMGFaWkVQTjBnU2VOM3JabWQ3a0dUWU5T?=
 =?utf-8?B?eVNxRkxRSi9BU1RDZWpONVlnVHU0TTREOXJ4dzBFTG1WTGRSQ2cvdnVmSTIv?=
 =?utf-8?B?Z1JPUmQ2SCt4QjBFN1ZNbEFwdXNBNmluOTFyQXlxUzMyMFRHWmw3bTVGT1ps?=
 =?utf-8?B?aEVpODVLN2dPVmpVM3hoRVNMdUdvckhnNUJudXhoK0RrZVRBQkQxV2xkZGlR?=
 =?utf-8?B?NDRWb2t6TGozdGs2U0FabnZ0N1prVEZYWWNRSUVjUC9uMnNtcTBTL3JVZzV1?=
 =?utf-8?B?cXR5bjlvZFl6cWRuRVhLTkwrUWs4QTRpN0hFUWMxMis1aUlvZEtaczdXZncz?=
 =?utf-8?B?QWFYVEFjcWFnOHVweVJvcktJZC9BQzdEeE5Pa2lpZ2U0a3lDeFlQK3JSSyt3?=
 =?utf-8?B?d1ZuTUtCdmZUUHRoTXZFcEpIemxGQUJxSk5UK05mb2Q1UzlLaVNibzJUdXBi?=
 =?utf-8?B?WGdmNEQ2OUhVTWsyM011K29TYmNXaGNBQ0M3c0V2cWFSZS85NTV5SU1mOFoy?=
 =?utf-8?B?N3crRTU3MldSV3l5aTNMOWhNQUhqZWVYei96c2IyYmxiSVVBaDdlMGE1QWJw?=
 =?utf-8?B?SXMxRVZZRzFzRHpQZWZUTWpwamppR2c3RzZSbFBqMDFMVlNFcmRBSWtQRW0v?=
 =?utf-8?B?UVNvSk04OGk5bFJpK29TYy9JdFBHc0Q3cHgwYU5OSFliMElSZVp5NXk5empk?=
 =?utf-8?B?QUZGVVY3S3kxaXpEQWpUNnEwRkd6alhOMW80elVHUFNmOWtLYmRwQWl1bDVF?=
 =?utf-8?B?dnc2dGFrWFF1cm5DRWdwVzZveVlTajNTQVB6bTBFdWM4d2FlZ0RIZGtqWlRr?=
 =?utf-8?B?NEJiTkl3c0wrZzVLdlFCZkVrUkFkT0NoYXBGdGZ5ZGw1Y2cybFRId3YvbnVm?=
 =?utf-8?B?d0RjNm1Gb2lNeHJDVDRzSkxqMTNIK0RrVnZ4RU5Lb2h6Vm0waHVhdmdRZWh4?=
 =?utf-8?B?R3lyYU9UODdQL3BBa1VJK2NOdXZPTmdWajVKeThXM2pQUzE1cVlscUR1OUI5?=
 =?utf-8?B?RXh5TXRzN3VSY1hCZExaZXNJM3Z5ei9uUWc5T3l1dldEVTVLT0ZXcEtzN3Av?=
 =?utf-8?B?cENUeHlpWk5hUXJtZ1FNWm1jTkFRRm1GcDJGdTQ2bEw3ZWI4RUdxSkZ5bGdG?=
 =?utf-8?B?K0JGM1dvNUUzdUVXZGtRTFg0cXh1U3ZEb0lPeEV1dzZXZFh6VTVnZWFHNnFH?=
 =?utf-8?B?OGcxa1lha2hMODBWZENhUjRxNHhrbjBremY2TTBhcDRlTzRwT2ZlR0xkUGha?=
 =?utf-8?B?VzRMQXVSTDRLQ0VoZGJQN1NUUjUrT2s5SXhETldvSTF0YW5kWmRrU05veWt0?=
 =?utf-8?B?b2ttWG9WcXh3TnBPeG1PYzNqTGZML1Y0Y0hMeWhxOFg4WmhyU2d4TFdoa3o3?=
 =?utf-8?B?TFBhMmxFNGVpcWUyaU9HTjNZMkZCUmw2Q1JKQzBvMmFPTWcwYnlyT0FOZE9m?=
 =?utf-8?Q?/awYopf6DPhZbGhhhBo+NnhLQlBPXTu0NBMuX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDE5221C1F861C4ABA65C154B8D2C7DF@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a3c141-3798-42f4-a93e-08debbca6c39
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:32:00.2384 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wq5cRlbtIC1xdu9P1LvZLE6iunHXHIiaMnFdror7oWLOsYoKvpVx8LPD/eR1TRDBk0OBnPuorMdyi1sctUCy/IEt/8fPSWzha+jU5nlNckg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

VGhlIHBhZ2UgdGFibGUgd2Fsa2VyIHJlYWRzIFBURXMgdXNpbmcgYWRkcmVzc19zcGFjZV9sZGwv
bGRxIHdoaWNoIHVzZQ0KY29tcGlsZS10aW1lIG5hdGl2ZSBlbmRpYW5uZXNzIChhbHdheXMgTEUg
Zm9yIFJJU0MtVikuIEhvd2V2ZXIsIHdoZW4gYQ0KYmlnLWVuZGlhbiBrZXJuZWwgd3JpdGVzIFBU
RXMgdmlhIG5vcm1hbCBzdG9yZSBpbnN0cnVjdGlvbnMsIHRoZXkgYXJlDQpzdG9yZWQgaW4gYmln
LWVuZGlhbiBieXRlIG9yZGVyLiBUaGUgd2Fsa2VyIHRoZW4gbWlzaW50ZXJwcmV0cyB0aGUgUFRF
DQp2YWx1ZXMsIGNhdXNpbmcgcGFnZSBmYXVsdHMgYW5kIGEgaGFuZyB3aGVuIHRoZSBrZXJuZWwg
ZW5hYmxlcyB0aGUgTU1VLg0KDQpUaGUgUklTQy1WIHByaXZpbGVnZWQgc3BlY2lmaWNhdGlvbiBz
dGF0ZXMgdGhhdCBpbXBsaWNpdCBkYXRhIG1lbW9yeQ0KYWNjZXNzZXMgdG8gc3VwZXJ2aXNvci1s
ZXZlbCBtZW1vcnkgbWFuYWdlbWVudCBkYXRhIHN0cnVjdHVyZXMgZm9sbG93DQp0aGUgaGFydCdz
IGVuZGlhbm5lc3Mgc2V0dGluZyAoTVNUQVRVUyBTQkUvTUJFIGJpdHMpLg0KDQpGaXggYm90aCBQ
VEUgcmVhZHMgYW5kIGF0b21pYyBBL0QgYml0IHVwZGF0ZXMgdG8gdXNlIHRoZSBleHBsaWNpdCBf
bGUNCm9yIF9iZSBtZW1vcnkgYWNjZXNzIHZhcmlhbnRzIGJhc2VkIG9uIHRoZSBoYXJ0J3MgcnVu
dGltZSBlbmRpYW5uZXNzLg0KDQpTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpv
cmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NClJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQotLS0NCiB0YXJnZXQvcmlzY3YvY3B1X2hl
bHBlci5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L3Jpc2N2L2NwdV9oZWxwZXIuYyBiL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMNCmluZGV4IDM5
YzM0ODZhZTAuLjQ4NTliOGRkNWMgMTAwNjQ0DQotLS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBl
ci5jDQorKysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQpAQCAtMTQxOCw5ICsxNDE4LDEz
IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0ZSAqZW52LCBo
d2FkZHIgKnBoeXNpY2FsLA0KICAgICAgICAgfQ0KIA0KICAgICAgICAgaWYgKHJpc2N2X2NwdV9t
eGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nfc3BhY2Vf
bGRsX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAgICBwdGUg
PSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAgICAgPyBh
ZGRyZXNzX3NwYWNlX2xkbF9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykNCisgICAg
ICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkbF9sZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRy
cywgJnJlcyk7DQogICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAgIHB0ZSA9IGFkZHJlc3Nf
c3BhY2VfbGRxX2xlKGNzLT5hcywgcHRlX2FkZHIsIGF0dHJzLCAmcmVzKTsNCisgICAgICAgICAg
ICBwdGUgPSByaXNjdl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudikNCisgICAgICAgICAgICAg
ICAgPyBhZGRyZXNzX3NwYWNlX2xkcV9iZShjcy0+YXMsIHB0ZV9hZGRyLCBhdHRycywgJnJlcykN
CisgICAgICAgICAgICAgICAgOiBhZGRyZXNzX3NwYWNlX2xkcV9sZShjcy0+YXMsIHB0ZV9hZGRy
LCBhdHRycywgJnJlcyk7DQogICAgICAgICB9DQogDQogICAgICAgICBpZiAocmVzICE9IE1FTVRY
X09LKSB7DQpAQCAtMTYxOSwxMiArMTYyMywyNCBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9h
ZGRyZXNzKENQVVJJU0NWU3RhdGUgKmVudiwgaHdhZGRyICpwaHlzaWNhbCwNCiAgICAgICAgIGlm
IChtZW1vcnlfcmVnaW9uX2lzX3JhbShtcikpIHsNCiAgICAgICAgICAgICB0YXJnZXRfdWxvbmcg
KnB0ZV9wYSA9IHFlbXVfbWFwX3JhbV9wdHIobXItPnJhbV9ibG9jaywgYWRkcjEpOw0KICAgICAg
ICAgICAgIHRhcmdldF91bG9uZyBvbGRfcHRlOw0KKyAgICAgICAgICAgIGJvb2wgYmUgPSByaXNj
dl9jcHVfZGF0YV9pc19iaWdfZW5kaWFuKGVudik7DQogICAgICAgICAgICAgaWYgKHJpc2N2X2Nw
dV9zeGwoZW52KSA9PSBNWExfUlYzMikgew0KLSAgICAgICAgICAgICAgICBvbGRfcHRlID0gcWF0
b21pY19jbXB4Y2hnKCh1aW50MzJfdCAqKXB0ZV9wYSwgY3B1X3RvX2xlMzIocHRlKSwgY3B1X3Rv
X2xlMzIodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9IGxlMzJfdG9f
Y3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCBjbXAgPSBiZSA/IGNwdV90
b19iZTMyKHB0ZSkNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9f
bGUzMihwdGUpOw0KKyAgICAgICAgICAgICAgICB1aW50MzJfdCB2YWwgPSBiZSA/IGNwdV90b19i
ZTMyKHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA6IGNw
dV90b19sZTMyKHVwZGF0ZWRfcHRlKTsNCisgICAgICAgICAgICAgICAgb2xkX3B0ZSA9IHFhdG9t
aWNfY21weGNoZygodWludDMyX3QgKilwdGVfcGEsDQorICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY21wLCB2YWwpOw0KKyAgICAgICAgICAgICAgICBvbGRfcHRlID0g
YmUgPyBiZTMyX3RvX2NwdShvbGRfcHRlKQ0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
OiBsZTMyX3RvX2NwdShvbGRfcHRlKTsNCiAgICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAg
ICAgICAgICBvbGRfcHRlID0gcWF0b21pY19jbXB4Y2hnKHB0ZV9wYSwgY3B1X3RvX2xlNjQocHRl
KSwgY3B1X3RvX2xlNjQodXBkYXRlZF9wdGUpKTsNCi0gICAgICAgICAgICAgICAgb2xkX3B0ZSA9
IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KKyAgICAgICAgICAgICAgICB0YXJnZXRfdWxvbmcgY21w
ID0gYmUgPyBjcHVfdG9fYmU2NChwdGUpDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA6IGNwdV90b19sZTY0KHB0ZSk7DQorICAgICAgICAgICAgICAgIHRhcmdldF91bG9u
ZyB2YWwgPSBiZSA/IGNwdV90b19iZTY0KHVwZGF0ZWRfcHRlKQ0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOiBjcHVfdG9fbGU2NCh1cGRhdGVkX3B0ZSk7DQorICAgICAg
ICAgICAgICAgIG9sZF9wdGUgPSBxYXRvbWljX2NtcHhjaGcocHRlX3BhLCBjbXAsIHZhbCk7DQor
ICAgICAgICAgICAgICAgIG9sZF9wdGUgPSBiZSA/IGJlNjRfdG9fY3B1KG9sZF9wdGUpDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA6IGxlNjRfdG9fY3B1KG9sZF9wdGUpOw0KICAgICAg
ICAgICAgIH0NCiAgICAgICAgICAgICBpZiAob2xkX3B0ZSAhPSBwdGUpIHsNCiAgICAgICAgICAg
ICAgICAgZ290byByZXN0YXJ0Ow0KLS0gDQoyLjM0LjENCg==

