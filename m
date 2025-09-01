Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF17CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszef-0008GD-Ig; Mon, 01 Sep 2025 04:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszee-0008Ew-5N; Mon, 01 Sep 2025 04:12:44 -0400
Received: from mail-northeuropeazon11022100.outbound.protection.outlook.com
 ([52.101.66.100] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uszeb-0004hy-2x; Mon, 01 Sep 2025 04:12:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=app357RUbDXmpjsQiPwJbgLExTExlYKSnONxan6f7kBcHyBuD4XTMaKaO50XPIVgAMcqEYHGkfh1oTtKXOFCnFd40wIkQ5QoeQwWXMY3O7hvkQ4yxMv3sw302ad4eY+maSNIPHYTz9XVKPwIZP4KedoGd11VWVh+vVoAPtLHVt0rGfKShoMHSnMGXaQ37QJMlOQXRYzveePnCT293t3pbTcW0yTYOt2iAYGkyrkM3vec4skgOEkUbRzYR1lymbHQsHBsjUBbibNsLDqqZGMfih7wFZRE5VlzXzp0xUu+i3sJfDI1z2Mqa8gdAPL40lhS6/WluaPAqa/00ewvaf4NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRTeymy2q9wPjMgP8t41/VkmUJb/wvKdhHpVZMqsIdU=;
 b=yFSc5Tw0U+AYJ+tURah86rJarKuPzqn9ec6855f0mQeDJm4TMe4/d4MiHjfPF5AMu4XoEu+U7ZyAhkoNODT4pwe1p4rW6KADFDPNJdC41t++GNQHkyzCou6xPFgN2DhEFG9tQ3BxLbCNVMWUq64KsrQ6y+7WddC3ruv2YGrrBCWdM/T5DcMWQQXHBHWfuIR8uiC8odGJWsWXpC8Vsp9fX+MPleQZl+SBo1W/mlm4xYA/Jd+GOatN9noyDIUV0T0fXpXy8H+y8zZZvioZJSnThX+efY7iXZrXqk+lZuXhVEvTyWKIrTDriuYNv2BVeqflA2bzwZQm2hZ6Wq9Hp1lSXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRTeymy2q9wPjMgP8t41/VkmUJb/wvKdhHpVZMqsIdU=;
 b=H0lYav2SwyF1oybtg7DrOw0O3BMFUixPb7EjCx3LZZiCHVNRDoABJj0kje2OLn9lkd/+xXB+hldaLnaxL8VWk1mLTg0gO3jZOJNI9qH4F6IWW081Waetb536VihtL7RAVRoCj8ORv+0G7/Vmi92x/coUDaV8rkbq7jhqUkeHw4kDoNHPVh1Bzh+DsWPu8jO+gziQ9kkPZqG4w/jnppogXCxdBOMAxmWN1XE1kguUXLUwOCftNOVvcFlRfpqA1buZgdCAWappX65q0hlI0oDiPBeSubfoj9nomE+BcDvcXWU/zyRbP+aPCI/53ESYuekOhLro1XzqLai748CkS3aa+Q==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GV1PR09MB7097.eurprd09.prod.outlook.com (2603:10a6:150:1a4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Mon, 1 Sep
 2025 08:07:28 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:07:28 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Subject: Re: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb9v6UGrCoAbtlqECp61EdLa3+x7RXphSAgCaa2IA=
Date: Mon, 1 Sep 2025 08:07:28 +0000
Message-ID: <5206c924-7da0-40b4-a28e-c3e778ddc67e@htecgroup.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <9a305b9e-98b6-4693-84c9-b506bd2b830d@ventanamicro.com>
In-Reply-To: <9a305b9e-98b6-4693-84c9-b506bd2b830d@ventanamicro.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GV1PR09MB7097:EE_
x-ms-office365-filtering-correlation-id: 0a03654f-442a-4488-290c-08dde92e980c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Nmg5T2hKdEdsb0ZQTjZ2VVp2WFp1ams4dDUxY0J6bFNFNVBWSWcyMGc5R29N?=
 =?utf-8?B?RWhUSmp3c0M5MEVDQUhobk1NWGVPVmsvNVIzOVQwTkloMStQbkNvUXM0Sm42?=
 =?utf-8?B?dFBUK1E4aCtxcFhuRVdjM3EvSWlXY0l3aytqaWIwallEc1A4Y2dWOWFPdWVn?=
 =?utf-8?B?ZXhTUSt1dENwQkIrOXFnUlh6THZXWFcza2lZVDQwbnNkNzNMVGpnQ3F4QVN4?=
 =?utf-8?B?R1dFVHdheUpocUY3UGZhSGdYRkNBK0x6dEh2dU1HOXJ2dTQyc3M4bzRWQWxU?=
 =?utf-8?B?K0Y5eXlSVHh0Y2M3T3FxZHRDcWRkeUNaWnA3VlZIQjN2STZ4M29taVkvSUIx?=
 =?utf-8?B?M3JaMVJPb0E1MEo2VDQreGdhMXFtc1dhcUFkY0hzREpHQisvc0RlNkd0QU80?=
 =?utf-8?B?Q3dPdkNDTWQwZngwMWNhRmxZeU81MmQ3SmF4VjNEUmU5ejJNeVpzZ0dhUTZG?=
 =?utf-8?B?Mnl1a2RWK3ZMV0lHTHdjdWxzaFFySkVTbG9ZZVlRcWdwd1Z3YjEwcktsTzVh?=
 =?utf-8?B?N3cwV1UyUTVPNjV5WlpYWGcrN2t4ZFpKcVRSWXdYNnpOcE5SUzZTSU5yRGto?=
 =?utf-8?B?bnIrUlhmN3Qyb2N2a3djNlNzZnFIQlp0WEpmbGVCZmFGdDBaVUIyUE9GRmlT?=
 =?utf-8?B?WHNQVGwzVDM3WlhnQnRoeUM1RFh5ck9jOTZneWdManJGdGZmWUN0UjFaWVNr?=
 =?utf-8?B?SDc2QzhzNUExWUVpWXR2ZkNpclV2bFNiOEQ3cUZYWlJSZTBtcmZSWWlSZHpN?=
 =?utf-8?B?N0pFRHpRcEE5RC9TM210aXYwQWpuWGNYeVNDZjdYd2NKVGVrMlJFeTZ5UWZJ?=
 =?utf-8?B?QmNvWGhPTGlHZWd0SjZONSs3RmxROUtEN3JZcjIzNndzVnRQR2ozZ2cxbWNw?=
 =?utf-8?B?eExuLzFSdm45bHdZNVppOE4xZ1A0ck1JVWQvTExIbTN2SFZreEFzUWUrZE1Z?=
 =?utf-8?B?ZkgxelFnTzlDUEpjY21oUlIyT1VDWWpXamJMTGU0RlU5QUZ3U1NyMVRuUE9D?=
 =?utf-8?B?TVVTMVBXVnh5dUE3bk5wSmJtOUJWWlQxRnhRVlYzOTNGWW43NWYzTDZJem5K?=
 =?utf-8?B?ZHh6Yy85dkpxbnZsMlhrbDQ5SFM1ODc2cTBoSGJUYnBHY2JzTlplbWl1WDdo?=
 =?utf-8?B?clFxK1ZrdFg3d3BtWFBuNkdld1QwNGJCT0RodVc1RXpPbFhoSnc2VXRINERF?=
 =?utf-8?B?amR2MkpYemhxZjQ2NzdqemJob2FkSWoyQWpkWWRQenpORjVrTWxCUDVuVnJh?=
 =?utf-8?B?cnAySzVoV1hjdVY0aFRjYjlMdHFNR3R1V2V1UnRRU2x1VHloSG8zWmJFWVA1?=
 =?utf-8?B?YmRMK2R1NnI2VS9ZUGlROXMyQ0FqdzBQaDI5amVJVkZpM085VFJkNjIvYS83?=
 =?utf-8?B?cmZlSkVnVDJHTitoMnNIclJUK0J4NEk3YmVzTnk3UlJZNVdhM2cwNkExMElC?=
 =?utf-8?B?ZXhxYm5FWC9qZUg1N3JlR0IzbEd1M1Nqb05jWWEzMnRRSHRVaHRaL2VLTCtm?=
 =?utf-8?B?QmR4U3ZncnVRTk1wQll5Vnhud3J0OWJvaTk5MjB0U295dTByR3hkS2VXczM5?=
 =?utf-8?B?YzdhekM1ZDltblBJd2F6UmwrcmhqUXY1SitWYnFVNHNaZ2FKQkdmTGRMcXRz?=
 =?utf-8?B?bWxxTG96VWRENExhRURBME80dnJvWEV6bVlZYUpUak02T2VjbzRJdStocUZl?=
 =?utf-8?B?M2VMeEYrQ0lxeUhrUEZ2UFVxN3lZcUVvK3RyNXdxL0MzQTQ0Q25TTi9FYVla?=
 =?utf-8?B?cERtcG9QempBVFFYV3o3cEY3UmhjRGtDaUdyNVk4MU82R0VpWW1VZ1VINEla?=
 =?utf-8?B?Zjg0MVBRbnRiT2x5dk5lc08weGZGUS9NVTRuTXkyMkJMYWtONWlzK2FOVE9O?=
 =?utf-8?B?T2VMbFFvR0Z6R1hCSFFHRkpRUmVMemlHR0dxY1pPVzZCMWpSVnNhRUZnV1V3?=
 =?utf-8?B?VTJRL3RMWmtEK3pGaU5tNEdMZGlMM0g4Y0xaeUNoYmFGL0dqdlkvOEg5elhu?=
 =?utf-8?B?czRSVm1GM3hBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajRCN1lZWlFrejExaU1nbnRIZm14emFhN0JsY2ZLTFJaeEx4eVAwRkZIMjBt?=
 =?utf-8?B?a1JKZ2dVY044UEZIWmQwd1lXMWhBdG5RMXArTmFxd1JSTkNHMU95akZXWXBU?=
 =?utf-8?B?ZldTbUo1OGJGMkRZNEI0R1NTdU5qQlQzOEVnUnlJVExxdjAzeUt2VS9EV05U?=
 =?utf-8?B?ejVaODkyc3c1WFpmOFF4SjdRd1FmKysyY2FKQUR6UGVsRnFXazloMzNldVY0?=
 =?utf-8?B?czRwV0IrWlQyMmhQRnFpZGhnZThLb3B0aGUxOXZ3cVhRcGFncGN2djljL1Rz?=
 =?utf-8?B?bStHWlFyTTFDbHpLQlRiMzhJWUVTcHFGRjB1RElEUDNTbXEzaENPeFI5M2hQ?=
 =?utf-8?B?Q0dDMHhNU0phUlJmRC9EQlVBTVBacTVIanZBR3NKSWZVWFFwcm54ZnZ6TWhp?=
 =?utf-8?B?TWlaaGtkQ0o2TnRnVkNHVERnVUxnZC9Vb0E0aTJxRW4xcGRSVjZQZkZXU24w?=
 =?utf-8?B?WmtYdS85UVFpb0lpK2E0QjNoZzc2RmFiZlF3SS9mb1ozblZDdVNrL3h0K1lj?=
 =?utf-8?B?KzZPRm9sYVZuRndLbjU0eDdHSExUcTFkTjdCMStPeTJYZEJpOTFMSlByYjdx?=
 =?utf-8?B?Q2gzcThFR1R3ZUozUXVVVHQxM0pXR1pXRXdqeXdydk4yOG9INk9TTmdGQVBK?=
 =?utf-8?B?MlB4Tk1CSll3RUUwcGV4Q3grWCsyZkJlN2pDa3RiWStrRmJMOWtuMHRjQTlr?=
 =?utf-8?B?RElDUGJOOHNwVHZBSUVUVDFvMWdPbW5VUHhxMmRDbmxPK1VMcWpaZmVFdHFY?=
 =?utf-8?B?M2ZkcHVjL0pIck5nZE9kaTg4WERWeURqTTNNVk1lK0h1R2NpKzZIMDVtNldn?=
 =?utf-8?B?SUVTdnkvZk1kWHZzdGFtYkJ5bllEcEJQekNkK3BQUzk5L3lYYWFuaFR5TXlh?=
 =?utf-8?B?blB4NGhMVDArM0pMUzhFQ0szak8wOUljNkM4dTF0M1lCbnNSQ1huTllKN0Q3?=
 =?utf-8?B?NU9yWEdSUGEzZjc3ZTVJNFlXUnBvZHVwcnlCc0pvVXJRNEZTYk1RRmZSeHdU?=
 =?utf-8?B?Y0Z2d3J6OWhsWFFUSFhRRS9ZekJWSlhSeUZCMHlrcnhhRm9lQTRKdHZ5MC8x?=
 =?utf-8?B?YWZFZXlsaU5yWC9wUytHYjFOL2E2KzZGQmxBMUNLaDluV0c3S2xwL0ZhSXIx?=
 =?utf-8?B?Z0lDLzNMSnFKUmw0NW9yN1BNODh5T3dya1IwdC95NHMrYTRUWDBqRFBwdXgz?=
 =?utf-8?B?Yisva2xxcWRiVGhUYVZZNEF0dnMwWHVOK1RIL0pDSGhJSmx6MEdmVkJFY00r?=
 =?utf-8?B?YXIwREZDTitiWnptUjlQOFhvNjJIMVR0ZlRvYWFZUXd4R3dJNlQvZitRT1RV?=
 =?utf-8?B?Z3p5UDgzbXNjRXp5ckErUU9SQ3JnN01PWEx0YUJ4YkkvVENJbVpaTFpIUU1a?=
 =?utf-8?B?QnR3ZWJSa1hyV0pWZkp0Sm9IeWpTV09NR05PV3ZHRDJacjJJZmcwUm9MKzZo?=
 =?utf-8?B?ZENJTkd6UEljL0lzekg5bTBtOVZVUnQrREZ2M0VSR09aZ3lNVU9DMDh0YUN3?=
 =?utf-8?B?UUZtL2xqV1A0SUkyQmJNM3R4dXRCVmU2cDhUdWxrNDBHS0I3c20zbzRBN05a?=
 =?utf-8?B?Mi9YalpRQk1YbS9vQVY4eE5iZkFlYTJiTHJEbGZaTE53dXdtdkVSU0twOXJo?=
 =?utf-8?B?ZHI5UnFXR1d1TkdsdGdjc3R5VE0venU5ZjRET0tQcmpyaDlhc0ZJOEhqc0RT?=
 =?utf-8?B?YWdQY0VBQ0JqbGphZkVxcHBtMzFyVXpVaFp1MHdsTFYxL2VscHhJQWtQZXNz?=
 =?utf-8?B?M2w0S2RyTjBPZ3hzaFgrSHZCTkQxSnRiYUJoV3lnOGptUlhmUXpGM1lZNW9l?=
 =?utf-8?B?STVVSThQN1BqeTErdlVLRENBbXBuR0V2aG5jSnFZQmFXRVIvWC9rM3VsaEhq?=
 =?utf-8?B?ZDFWcjFwNW9WdzVTVHdlaWZTOEVCekl6QjZYYXhCVDg1Ym5tby9hYlVVK2d0?=
 =?utf-8?B?a1RKdjJ4cTluOXNKZ25reHl5WFVlU2FyRVpYZFBpQnJ3aDVocVpOT1Z0eEJS?=
 =?utf-8?B?cjQ4cjBDMW1MMm9mMXlBaklpVlJDVkNJa2ZZNVpZYnV0UTlGcStyRzFlUGVI?=
 =?utf-8?B?T20vVTNXOFlZNXlMamNmOVF6V243RjdVRWJMNE5vSWwvT29aNXNPZFdJWXdL?=
 =?utf-8?B?RDZ2YUR3ckRRckQ5WWVIWjFKNVZYZFE2YzhaN3g2WEkydVJBMWc4VGtqc1hY?=
 =?utf-8?Q?vNMHBkEUU6hjkB+SVcS65uk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CCAD4AA17C9E5A449C0486B532614C7A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a03654f-442a-4488-290c-08dde92e980c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:07:28.4820 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E5lidZ+loCTNrHvfLZGcOpsvg5jOYv4ZC/os0aRISTvdz9sql7fzXTBWweRiluFgo+LWJPZmS9gnMiBMrNglWSP2fLJgWznGFu89uOUHjhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR09MB7097
Received-SPF: pass client-ip=52.101.66.100;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

SGkgRGFuaWVsLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMhDQoNCkkgd2lsbCBmb2xs
b3cgdGhpcy4NCg0KQmVzdCwNCkRqb3JkamUNCg0KDQpPbiA3LiA4LiAyNS4gMjA6MzUsIERhbmll
bCBIZW5yaXF1ZSBCYXJib3phIHdyb3RlOg0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0
ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0K
PiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBIaSwNCj4NCj4gSSBoYXZl
IHByb3ZpZGVkIHJldmlld3MgYW5kIGFja3Mgb24gdGhlIHY0IHJldmlldzoNCj4NCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1yaXNjdi8yMDI1MDYyNTE0MTczMi41OTA4NC0xLWRqb3Jk
amUudG9kb3JvdmljQGh0ZWNncm91cC5jb20vIA0KPg0KPg0KPiBJIGFsc28gZ2F2ZSBvbmUgYWRk
aXRpb25hbCBhY2svcmV2aWV3IGluIHBhdGNoIDggaW4gdjU6DQo+DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtcmlzY3YvMjAyNTA3MDMxMDQ5MjUuMTEyNjg4LTEtZGpvcmRqZS50b2Rv
cm92aWNAaHRlY2dyb3VwLmNvbS8gDQo+DQo+DQo+IEkgc2VlIG5vIGFja3MgaW4gYW55IHBhdGNo
ZXMgaW4gdGhpcyB2ZXJzaW9uLg0KPg0KPiBUaGUgY29tbW9uIHByYWN0aWNlIGlzIHRvIGluY2x1
ZGUgYW55IHJldmlld2VkLWJ5L2Fja2VkLWJ5IHRhZ3MgDQo+IHJlY2VpdmVkIGluIHRoZSBjb21t
aXQNCj4gbXNnIG9mIGVhY2ggcGF0Y2ggd2hlbiBzdWJtaXR0aW5nIGEgbmV3IHZlcnNpb24sIGxl
dHRpbmcgb3RoZXIgcHBsIA0KPiBrbm93IHRoYXQgdGhlIHBhdGNoDQo+IHdhcyBhbHJlYWR5IGxv
b2tlZCBhdCBvbmNlLiBVbmxlc3MgeW91IG1ha2UgY2hhbmdlcyBpbiB0aGUgcGF0Y2ggYW5kIA0K
PiB0aGUgcmV2aWV3IGdhdmUNCj4gYmVmb3JlIGlzIG5vdyBpbnZhbGlkIC0gdGhlbiBpbiB0aGlz
IGNhc2UgeW91IGRyb3AgdGhlIHRhZyBhbmQgYSBuZXcgDQo+IHJldmlldyBpcw0KPiByZXF1aXJl
ZC4NCj4NCj4gVW5sZXNzIHlvdSBjb21wbGV0ZWx5IGNoYW5nZWQgYWxsIHRoZSBwYXRjaGVzIGFu
ZCBhbGwgdGhlIHJldmlld3MgDQo+IGRvZXNuJ3QgYXBwbHkNCj4gYW55bW9yZSwgcGxlYXNlIHJl
LXNlbmQgdGhpcyBzZXJpZXMgd2l0aCB0aGUgYWNrcy9yZXZpZXdlZC1ieSB0YWdzIGluIA0KPiB0
aGUgcGF0Y2hlcy4NCj4gRnJvbSBteSBlc3RpbWF0aW9uIHRoaXMgc2VyaWVzIGlzIHN1cHBvc2Vk
IHRvIGhhdmUgMi0zIHBhdGNoZXMgbWlzc2luZyANCj4gcmV2aWV3IG9ubHkuDQo+DQo+DQo+IFRo
YW5rcywNCj4NCj4gRGFuaWVsDQo+DQo+DQo+DQo+DQo+IE9uIDcvMTcvMjUgNjozOCBBTSwgRGpv
cmRqZSBUb2Rvcm92aWMgd3JvdGU6DQo+PiBJIGFkZHJlc3NlZCBzZXZlcmFsIGNvbW1lbnRzIGlu
IHRoaXMgdmVyc2lvbiwgbWFqb3Igb25lczoNCj4+IMKgwqAgLSBzcGxpdCBDUEMgLyBDTUdDUiBp
bnRvIHNlcGFyYXRlZCBjaGFuZ2VzDQo+PiDCoMKgIC0gc3BsaXQgQ1BTIGludG8gYSBzZXBhcmF0
ZWQgY2hhbmdlDQo+PiDCoMKgIC0gYWRkZWQgZnVuY3Rpb25hbCB0ZXN0cyBmb3IgYm9zdG9uLWFp
YSBib2FyZA0KPj4NCj4+IERqb3JkamUgVG9kb3JvdmljICgxNCk6DQo+PiDCoMKgIGh3L2ludGM6
IEFsbG93IGdhcHMgaW4gaGFydGlkcyBmb3IgYWNsaW50IGFuZCBhcGxpYw0KPj4gwqDCoCB0YXJn
ZXQvcmlzY3Y6IEFkZCBjcHVfc2V0X2V4Y2VwdGlvbl9iYXNlDQo+PiDCoMKgIHRhcmdldC9yaXNj
djogQWRkIE1JUFMgUDg3MDAgQ1BVDQo+PiDCoMKgIHRhcmdldC9yaXNjdjogQWRkIE1JUFMgUDg3
MDAgQ1NScw0KPj4gwqDCoCB0YXJnZXQvcmlzY3Y6IEFkZCBtaXBzLmNjbW92IGluc3RydWN0aW9u
DQo+PiDCoMKgIHRhcmdldC9yaXNjdjogQWRkIG1pcHMucHJlZiBpbnN0cnVjdGlvbg0KPj4gwqDC
oCB0YXJnZXQvcmlzY3Y6IEFkZCBYbWlwc2xzcCBpbnN0cnVjdGlvbnMNCj4+IMKgwqAgaHcvbWlz
YzogQWRkIFJJU0MtViBDTUdDUiBkZXZpY2UgaW1wbGVtZW50YXRpb24NCj4+IMKgwqAgaHcvbWlz
YzogQWRkIFJJU0MtViBDUEMgZGV2aWNlIGltcGxlbWVudGF0aW9uDQo+PiDCoMKgIGh3L3Jpc2N2
OiBBZGQgc3VwcG9ydCBmb3IgUklTQ1YgQ1BTDQo+PiDCoMKgIGh3L3Jpc2N2OiBBZGQgc3VwcG9y
dCBmb3IgTUlQUyBCb3N0b24tYWlhIGJvYXJkIG1vZGUNCj4+IMKgwqAgaHcvcGNpOiBBbGxvdyBl
eHBsaWNpdCBmdW5jdGlvbiBudW1iZXJzIGluIHBjaQ0KPj4gwqDCoCByaXNjdi9ib3N0b24tYWlh
OiBBZGQgYW4gZTEwMDBlIE5JQyBpbiBzbG90IDAgZnVuYyAxDQo+PiDCoMKgIHRlc3QvZnVuY3Rp
b25hbDogQWRkIHRlc3QgZm9yIGJvc3Rvbi1haWEgYm9hcmQNCj4+DQo+PiDCoCBjb25maWdzL2Rl
dmljZXMvcmlzY3Y2NC1zb2Z0bW11L2RlZmF1bHQubWFrIHzCoMKgIDEgKw0KPj4gwqAgZG9jcy9z
eXN0ZW0vcmlzY3YvbWlwcy5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCAyMCArDQo+PiDCoCBkb2NzL3N5c3RlbS90YXJnZXQtcmlzY3YucnN0wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4gwqAgaHcvaW50Yy9yaXNjdl9hY2xpbnQuY8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMjEgKy0NCj4+IMKg
IGh3L2ludGMvcmlzY3ZfYXBsaWMuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAxMSArLQ0KPj4gwqAgaHcvbWlzYy9LY29uZmlnwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIwICsNCj4+IMKg
IGh3L21pc2MvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgwqAgMyArDQo+PiDCoCBody9taXNjL3Jpc2N2X2NtZ2NyLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIzNCArKysrKysrKysrDQo+
PiDCoCBody9taXNjL3Jpc2N2X2NwYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMjM5ICsrKysrKysrKysNCj4+IMKgIGh3L3BjaS9wY2kuY8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoCAxNSArLQ0KPj4gwqAgaHcvcmlzY3YvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICsNCj4+IMKgIGh3L3Jpc2N2
L2Jvc3Rvbi1haWEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgNDg5ICsrKysrKysrKysrKysrKysrKysrDQo+PiDCoCBody9yaXNjdi9jcHMuY8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxOTcg
KysrKysrKysNCj4+IMKgIGh3L3Jpc2N2L21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICsNCj4+IMKgIGluY2x1ZGUvaHcvbWlz
Yy9yaXNjdl9jbWdjci5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNDkgKysNCj4+
IMKgIGluY2x1ZGUvaHcvbWlzYy9yaXNjdl9jcGMuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCA3MyArKysNCj4+IMKgIGluY2x1ZGUvaHcvcmlzY3YvY3BzLmjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDc2ICsrKw0KPj4gwqAgdGFyZ2V0
L3Jpc2N2L2NwdS1xb20uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqDCoCAxICsNCj4+IMKgIHRhcmdldC9yaXNjdi9jcHUuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0MCArKw0KPj4gwqAgdGFyZ2V0L3Jp
c2N2L2NwdS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgwqAgNyArDQo+PiDCoCB0YXJnZXQvcmlzY3YvY3B1X2NmZy5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKw0KPj4gwqAgdGFyZ2V0L3Jpc2N2
L2NwdV9jZmdfZmllbGRzLmguaW5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArDQo+PiDC
oCB0YXJnZXQvcmlzY3YvY3B1X3ZlbmRvcmlkLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCAxICsNCj4+IMKgIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3htaXBz
LmMuaW5jwqDCoCB8IDE0MiArKysrKysNCj4+IMKgIHRhcmdldC9yaXNjdi9tZXNvbi5idWlsZMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDIgKw0KPj4gwqAgdGFy
Z2V0L3Jpc2N2L21pcHNfY3NyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMjI4ICsrKysrKysrKw0KPj4gwqAgdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5jwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArDQo+PiDCoCB0YXJnZXQv
cmlzY3YveG1pcHMuZGVjb2RlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCAzNSArKw0KPj4gwqAgdGVzdHMvZnVuY3Rpb25hbC9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4+IMKgIHRlc3RzL2Z1bmN0aW9uYWwvdGVzdF9y
aXNjdjY0X2Jvc3Rvbi5wecKgwqDCoMKgIHzCoCA3OCArKysrDQo+PiDCoCAzMCBmaWxlcyBjaGFu
Z2VkLCAxOTk0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4gwqAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRvY3Mvc3lzdGVtL3Jpc2N2L21pcHMucnN0DQo+PiDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgaHcvbWlzYy9yaXNjdl9jbWdjci5jDQo+PiDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgaHcv
bWlzYy9yaXNjdl9jcGMuYw0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3Jpc2N2L2Jvc3Rv
bi1haWEuYw0KPj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3Jpc2N2L2Nwcy5jDQo+PiDCoCBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9taXNjL3Jpc2N2X2NtZ2NyLmgNCj4+IMKgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MvcmlzY3ZfY3BjLmgNCj4+IMKgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L3Jpc2N2L2Nwcy5oDQo+PiDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeG1pcHMuYy5pbmMNCj4+IMKgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvcmlzY3YvbWlwc19jc3IuYw0KPj4gwqAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRhcmdldC9yaXNjdi94bWlwcy5kZWNvZGUNCj4+IMKgIGNyZWF0ZSBtb2RlIDEw
MDc1NSB0ZXN0cy9mdW5jdGlvbmFsL3Rlc3RfcmlzY3Y2NF9ib3N0b24ucHkNCj4+DQo+

