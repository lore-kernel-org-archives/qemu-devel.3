Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929B3C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 05:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz69L-0005FP-0X; Wed, 26 Aug 2026 01:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wz69J-0005F7-Jn
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:26:09 -0400
Received: from mail-northcentralusazon11010013.outbound.protection.outlook.com
 ([52.101.193.13] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neal.frager@amd.com>)
 id 1wz69H-0007uN-11
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 01:26:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uM+teSsEmwMJ3j/lpRMKgxFiy3b6UJH6v5d3SfppwyK779SRzgRKJOEDAKv1FUQKOz1j4XiBmNJusYU9UozvXI3ozLUlCwDY+PFO6WlSQpUxSJ7ckmk0eZUM1HSQCNEusi2bJvfOwpxvBLoH7XKFAYPpndowGX4mDnAB7f8dC0w18ciyMQjUiSyh54+y420bumMf3Xutwa8P3+NNvYYbKxsZegOs03z3hON81BB9LtgRk0H9ZAZY1aIcWup3ZpbF6eubaalz+akGuz0lgG8y1+5SVTynyxFi4DMce054Jp9GjUScmF/t/du2kX9NJghBImLar4T8QEa40C2cXRrUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qeph0ERCuFewIyge3tZoQqMVmcwLOq8YQEGPliQsyaQ=;
 b=EvFPdjnbFeTNoBULv7ODpBm7dFuUcNyAfOWV2yOvJfsmOFTgFHlnXUTbHmb4/d7WqWL+1WMYqu9pkJf5F+Or5reE8NjnBMuJadcVIzhBzPwKC3Nfv7/Y2NmU9olw3y7DDinXJ7TT4v32UHv38s/sPAkaC6dqdKW3MzgrCIIwxjqtc4BT+MnL7TRfMeVehWsCicQIduR9Ub71ai01utTsZa6/II9zGFrQ2TIpad1pRLT+PUOdSxIf/eOBbduo9jNddIe117byvGYukakGY+vctsUYIUGNVQBv9CfvdYdua4GEzg+SJQbEADzILY+TPJn4fxvZS6OuqTHpl67Oe1C8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qeph0ERCuFewIyge3tZoQqMVmcwLOq8YQEGPliQsyaQ=;
 b=e7zuJ2N6p1jyyy5VfmQi2QKFSAejiON3n5XmxvAS8Ktgv58jPvF2wwpbzFdllFwU4Ab+1beI8I1X1LVLLNIW91hEwhB8ZBvC71s7wnQk1ORd1gaL4BwIyCotJfbI7flUGs+QJ9UMX361DZMU0jw7DiJeA7riH+sj14RQgcwbHNg=
Received: from BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 05:21:00 +0000
Received: from BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d]) by BL1PR12MB5032.namprd12.prod.outlook.com
 ([fe80::3c13:eeb6:d9ef:c95d%6]) with mapi id 15.21.0360.005; Wed, 26 Aug 2026
 05:21:00 +0000
From: "Frager, Neal" <neal.frager@amd.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "sstabellini@kernel.org"
 <sstabellini@kernel.org>, "anthony@xenproject.org" <anthony@xenproject.org>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>, "Saleab, Micheal"
 <Micheal.Saleab@amd.com>, "john.ernberg@actia.se" <john.ernberg@actia.se>,
 "matthew.l.weber3@boeing.com" <matthew.l.weber3@boeing.com>,
 "vincent.stehle@arm.com" <vincent.stehle@arm.com>
Subject: RE: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
Thread-Topic: [PATCH v1 1/1] include/hw/xen/xen_native.h: downgrade
 include-order assertion to warning
Thread-Index: AQHdJJsckvnz/cO5N0ySs3v4A11/7LatQ5eAgAAFmcCAAAXOAIAAAMSQgAAMYwCAAD5WgIACUOOw
Date: Wed, 26 Aug 2026 05:21:00 +0000
Message-ID: <BL1PR12MB5032167D2EBD91C753110996F0AE2@BL1PR12MB5032.namprd12.prod.outlook.com>
References: <20260805052723.2823538-1-neal.frager@amd.com>
 <2383a98d-d88d-415d-9de1-aa68a5d215fe@amd.com>
 <BL1PR12MB5032F21E0E2A6F17398B6D76F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
 <CAFEAcA8sWn1vjm+OFYzwA-jko2vYkFcWPwT6g9=0AeO+JQo-JQ@mail.gmail.com>
 <BL1PR12MB50322B1D97569B5CADEC8E55F0A02@BL1PR12MB5032.namprd12.prod.outlook.com>
 <CAFEAcA9rWqo92nt1StDuBwUjbV0eqdAA921nozpjQHDF_ARJyg@mail.gmail.com>
 <ea290b1f-5d40-48e3-9a64-1799244c6e64@citrix.com>
In-Reply-To: <ea290b1f-5d40-48e3-9a64-1799244c6e64@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-26T05:18:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5032:EE_|CYYPR12MB8654:EE_
x-ms-office365-filtering-correlation-id: aa10cee5-8428-4d9c-c6b0-08df0331d0d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: WyspDGisBZzsmrrFHlSSS8l5bib9ziBKo4p7yF2DkXrFMIRmatz/gZKY2LqMIJWnK4CJ67jJZu0GzQSxwlu7Iz3texf0KI9uaGCLAp5TOl6veKI0V6ygGK/h42qV0A/oj7+b8ok4PP/EFHJ1SOWEstA80caGrNgTLykKsrfJzEK5GStZQXWYUuxf8hxGPvnOgMpVlGW1+B6MIkYQ71t+BUN+OUsUrGGnL2stC0K7xfjAwDIvnEADFJeJmnSKXwuMSAVNd1uQx/d9oclF4eIKFVwsv7Qfn32vH81+c4wzkKGW1FFnkeHXT+KDcv53MvN5g87DbQDyYncUnLmCsEzOpNHuSTgdz4UhDq5GwbCRh3Xh2fX+rumNTNA6pJCGC8KB11QkXGJtaovsmPEy//ZJCxj6nQTAmQxkoDMDlIOsiAeSEdbBswC2mpmjI/yYHakFq1utmh2Q4QHInmfPtu1g9L1RJ57gtiD/dQH85JpazTObEwMW8ErfmL3BWfpSNYmwlXSb+7EXwK0JYaEl2eM8/SqMVJgthb6SaxMN4Vfc+hnOO/WX2Fi287T/jZj3RhgzOqWYE6X0l82qC35BMaJXcZbt130/Iuo9KMz3fjtDbAap4VOgKIRrPiezEFXc8UsdRVqzQOwybgNCrDXz53rmmiCruDuLXE4ja7ets8QCVx3LlfUBe+i209V6MfpCgVo5fVicUTiVVcNpvxtHNv0qWCehxDfNnrBr6upcB5zhLgk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2o4enlFUGkrM1cvQzRaOWk1WXFwNmhoa1FYNW5PN0VGdkFYUzRLaUtaaENw?=
 =?utf-8?B?T25FaVdaUGlpc2F3ZG1tb3FlT3pLMW9zc1NUNFZrM3BUc1NxbmlZS3pJOU5a?=
 =?utf-8?B?NUFsSzZHQTNkeit6VUJCSktPVE9yR2ZoZDN3Z2VUa3AyQzR1RFpSYVloNHl0?=
 =?utf-8?B?UHBvR3poZ2xWSk5PTzg1SFo3R082UWZyemZnZTUyUzU4WXdBQXpzOVB1Mndm?=
 =?utf-8?B?b3cxZ2RTY1dya0Mrd3g3ZEg4TXpRemkxVlNBbTBISnhseE1Sb0VEMUtTMzNi?=
 =?utf-8?B?eXBxWm5ERFFKZVozMUp5SUUrbjFFVWF6emlaeTFQNHNNbkJSTUorSThmUStk?=
 =?utf-8?B?UEtjamtZUHFzRjFVaklxekRpQTgvTHBKeW5lbjRBdUhHdTF5WWI1cmQvV1pE?=
 =?utf-8?B?VWJtQ2p0MVg4K2RTcncvYjdNd2RJMTZSa05waDJHZ2ZQQThndm5nbGdZMzl0?=
 =?utf-8?B?VTJOS2tta3V0T0tiT0VORXV1c3NhNXpMWndWSm5admJyZzZYRkxkemlOb3B5?=
 =?utf-8?B?b3hYT2pqRTRJR1doOU14L2JSa2Z1SzZacWRqOXhqcTRua2RSRGowamVXNDRZ?=
 =?utf-8?B?d3RkUHFGR2t6cG5KdjkxK1ZjcEl5WGc4NUdrZUhkL1JtRm4zamZncGloSkdq?=
 =?utf-8?B?U3JHeldndHNCdjZ1eUhtRTkxUm52SGRKdUxrd2pwV0orSnIvNW1oUHp3aTRs?=
 =?utf-8?B?U1Vyd292dDBMTTRnNHFyMlIrWG9oVC96N1lyTTZtR1VVS2pUTEVHaE8yNUVk?=
 =?utf-8?B?cDh0aTNFV3E2alN5VTN2Uk0yb2VLd0lESmEvYlJzQitZZjRUYjU3TE1iczQ4?=
 =?utf-8?B?K0F3amlXK0tDRVBKbmZVRnRTYUdySTEwdnZjdTA2dk1WT1RVUXdZWUhFK05M?=
 =?utf-8?B?VGRha1I4ZnZiaTBIbXFzOEE0VHRmNERDTVQzb0dXTHJ2eVM0VitWNjM1c0dk?=
 =?utf-8?B?QnlvTENlUE5MR3IzOTlaQ1F6aTZ5ZGxTekUvWWh1ekNGVFNicGJwT3BIbzcx?=
 =?utf-8?B?N2ZZSmpHckZjREtyRnEzb3NIc1E3WGpCd1c3RWQrM21yU0Q4bEE4MEh2elgz?=
 =?utf-8?B?dVV4WmVlWlFmK3dIYld0blRBaEZIaFNLYzJXVTczVzdlL2FKSUNneHJ2VTF5?=
 =?utf-8?B?VmtBSEgrN3o0ODJLYmtLeVZkS1lONUN6Q3dwcnRrQVRMeXk0dGlrWkZkaSt5?=
 =?utf-8?B?aVdSRUhMVDdNRWN2b1k2ZmdvcUVnZVZIRHNOdkw5UWtzQVd6Q1pXdVptY2F6?=
 =?utf-8?B?Q2NiSXVSQ09GeFNKWGtNWWkxclROL0IySjJBVC83TDU0RVZXWDZwcXVzN21I?=
 =?utf-8?B?Z3Z5RndQQlYySjJxSVlqWGxaMEgzdVU0aC9RTWk1V2x0YjJvVmpnTGs4K3hS?=
 =?utf-8?B?Nk9mU3drOWZvVWIzQWUzMkhUNmRBYVBNWGZ5UVprN1VCMDI1cmhia1VlQ0FF?=
 =?utf-8?B?RmRkeVpWcXJvMUhKUytJRHZ3SVZydVpodXRYM0s1TDlZL2dLb0JQOWU4Rm96?=
 =?utf-8?B?WGl5QXVJQ0ltWkliV1BTYnFSK2NBMlpFcjZaNC9YUERjR04xc1UyRUlTQ1cr?=
 =?utf-8?B?N3hsdTdTY2UvbEttak5ZVGpuN1JEV25MTGlnMFNrT3pMeHRwNzlkRjFCbjNI?=
 =?utf-8?B?TmswYWxUOCtKam13YXpKYW5Ob09aNCs2c2ZIOE9nbkhxbGNpeVRUdDB4b291?=
 =?utf-8?B?NHJsMFcyaGkvQWlUbmxhSlhCRkgwSGNqSC9SVzlaNCtrWlRSd0E2S08zSTBL?=
 =?utf-8?B?eC9peWtCaG1TNDZnVXpyQzRleUFTT29HODJjMVBSMGZ1WER0elFRT2hkWjY2?=
 =?utf-8?B?bnJKTE5wQWJuUFdhV25yYTQzS29FOFRKaUVNeWtxVHJIS1B5V0p5eGlTamFC?=
 =?utf-8?B?NFpDeDQxWjlFUXFvdy8vUmdodWhLL2RBOUpBOTNOaHZLaXVPQW1BM1QzUHhZ?=
 =?utf-8?B?MDdLYnhEWi9VcjhUWjN2YVV5MDdOeHorTXFNQUJUYjl1T3llWExMN1I1RTB5?=
 =?utf-8?B?VVAyelJuUXE4YW9SNnZKMXNZOGU5WlI5Yk5sZ3h2TlR0SUpJTHgvOUkwb0pQ?=
 =?utf-8?B?TURCUFpwTmVwd3RiZXpCL25NbS9WOHBrSUxIUjQ3b2lrWEFyeW1hY0dpZ1hi?=
 =?utf-8?B?SVJFM0JUblJRL1ljZkVmNEQ3eFVHTHd3Z3h2WE5uRXRRaWllZC9JVnZmQVVy?=
 =?utf-8?B?R003MXZtdlBjaUxmMzdQN0gxOWJhSFRpOHdadzFKLzluWnhHQ01DeVlvL3c3?=
 =?utf-8?B?MG1IZG1OSzdyY3RzdVpVdjZaR3EzbkZJQllRVTlIZjFmaE1zaFQ2amJoSEFU?=
 =?utf-8?Q?tOR5fUoUDYmZFFo2XX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa10cee5-8428-4d9c-c6b0-08df0331d0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 05:21:00.1379 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0StR98g12Wy1tJ8RZOksFvwRMZoEtfmT3+bwLcBETRoI2XI6SZpHCuQJrXvHlseE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
Received-SPF: permerror client-ip=52.101.193.13;
 envelope-from=neal.frager@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

QU1EIEdlbmVyYWwNCg0KSGkgQW5kcmV3LCBQZXRlciwNCg0KPiBPbiBNb24sIDI0IEF1ZyAyMDI2
IGF0IDE0OjMxLCBGcmFnZXIsIE5lYWwgPG5lYWwuZnJhZ2VyQGFtZC5jb20+IHdyb3RlOg0KPj4g
QU1EIEdlbmVyYWwNCj4+DQo+PiBIaSBQZXRlciwNCj4+DQo+Pj4gSGkgU3Rld2FydCwNCj4+Pg0K
Pj4+PiBUaGUgLUkkKFhFTl9ST09UKS90b29scy9pbmNsdWRlIGFkZGVkIHRvIFFFTVUncyBleHRy
YS1jZmxhZ3MgY2F1c2VzDQo+Pj4+IF9fWEVOX0lOVEVSRkFDRV9WRVJTSU9OX18gdG8gYmUgZGVm
aW5lZCBiZWZvcmUgeGVuX25hdGl2ZS5oIGlzIGluY2x1ZGVkLA0KPj4+PiB0cmlnZ2VyaW5nIGFu
IGluY2x1ZGUtb3JkZXIgYXNzZXJ0aW9uLiBEb3duZ3JhZGUgdG8gYSB3YXJuaW5nIHNpbmNlIHRo
ZQ0KPj4+PiB2ZXJzaW9uIGlzIGNvbnNpc3RlbnQgaW4gY3Jvc3MtY29tcGlsZS4NCj4+Pj4gUmVm
OiBodHRwczovL2dpdGh1Yi5jb20vcWVtdS9xZW11L2NvbW1pdC9lMmFiZmU1ZWM2DQo+Pj4+IFRo
aXMgaXMgYSBidWlsZHJvb3QgaXNzdWUsIHNvIEkgZG9uJ3QgYmVsaWV2ZSBpdCdzIG5lY2Vzc2Fy
eSB0byBmaXggZnJvbSB0aGUNCj4+Pj4gcWVtdSBzaWRlLg0KPj4+IEkgYW0gbm90IHN1cmUgSSBm
dWxseSBhZ3JlZSBoZXJlLiBXaGlsZSB0aGlzIGlzIGEgYnVpbGRyb290IGlkZW50aWZpZWQgaXNz
dWUsDQo+Pj4gdGhlcmUgY291bGQgYmUgb3RoZXIgdXNlIGNhc2VzIGZvciBfX1hFTl9JTlRFUkZB
Q0VfVkVSU0lPTl9fIHRvIGJlIGRlZmluZWQNCj4+PiBiZWZvcmUgeGVuX25hdGl2ZS5oIGlzIGlu
Y2x1ZGVkLg0KPj4+IEJ1dCB3aGF0LCB0aG91Z2g/DQo+Pj4gQW5kIHdoYXQgd2UgaGF2ZSBmb3Vu
ZCBpcyB0aGF0IGlmDQo+Pj4gX19YRU5fSU5URVJGQUNFX1ZFUlNJT05fXyB0byBiZSBkZWZpbmVk
IGJlZm9yZSB4ZW5fbmF0aXZlLmggaXMgaW5jbHVkZWQsIGl0DQo+Pj4gaXMgbm90IGEgaGFyZCBl
cnJvci4gIEZvciBidWlsZHJvb3QsIHRoZSBxZW11IHdvcmtzIGp1c3QgZmluZSBpbiBzcGl0ZSBv
Zg0KPj4+IHRoaXMuDQo+Pg0KPj4+IEkgdGhpbmsgdGhhdCBqdXN0IG1lYW5zIHlvdSBnb3QgbHVj
a3kuIEVpdGhlciB0aGVyZSBpcyBhIGhhcmQgcmVxdWlyZW1lbnQNCj4+PiBmb3Igb25lIGhlYWRl
ciB0byBiZSBpbmNsdWRlZCBiZWZvcmUgdGhlIG90aGVyIChpbiB3aGljaCBjYXNlIGl0IG11c3QN
Cj4+PiBiZSBhICNlcnJvciwgYW5kIHdoYXRldmVyIGlzIGNhdXNpbmcgdGhlIG1pcy1vcmRlcmlu
ZyB0byBoYXBwZW4gbXVzdCBiZQ0KPj4+IGZpeGVkKSwgb3IgaXQncyBmaW5lIGZvciB0aGUgb3Jk
ZXJpbmcgdG8gYmUgZWl0aGVyIHdheSAoaW4gd2hpY2ggY2FzZSBpdA0KPj4+IGRvZXNuJ3QgZXZl
biBuZWVkIHRvIGJlIGEgI3dhcm5pbmcpLg0KPj4gRnJvbSBteSB2aWV3LCB0aGUgb3JkZXIgdGhl
IGhlYWRlciBmaWxlcyBhcmUgaW5jbHVkZWQgZG9lcyBub3QgbWF0dGVyLCBhbmQNCj4+IHRoaXMg
c2hvdWxkIG5vdCBiZSBhbiBlcnJvci4gIEkgYWdyZWUgd2l0aCByZW1vdmluZyB0aGUgd2Fybmlu
ZyBhcyB3ZWxsLCBpZg0KPj4gdGhhdCBpcyB3aGF0IHdlIGFsbCBhZ3JlZSBvbiBpbiB0aGUgZW5k
Lg0KPiBUaGUgcmF0aW9uYWxlIGZvciB0aGUgaGVhZGVyIG9yZGVyaW5nIGlzIGluIHRoZSBjb21t
ZW50IGluIGluY2x1ZGUvaHcveGVuL3hlbi5oOg0KPg0KPiAvKg0KPiAgKiBDIGZpbGVzIHVzaW5n
IFhlbiB0b29sc3RhY2sgbGlicmFyaWVzIHdpbGwgaGF2ZSBpbmNsdWRlZCB0aG9zZSBoZWFkZXJz
DQo+ICAqIGFscmVhZHkgdmlhIHhlbl9uYXRpdmUuaCwgYW5kIGhhdmluZyBfX1hFTV9UT09MU19f
IGRlZmluZWQgd2lsbCBoYXZlDQoNCj4gTG92ZWx5IHR5cG8gdGhlcmUuDQoNCj4gVGhlIGRlZmlu
ZSBfX1hFTl9UT09MU19fIGlzIHdvZWZ1bGx5IG1pc25hbWVkLiAgVGhpcyBpcyBhbiBlcnJvciBv
Zg0KPiBYZW4ncywgd2hpY2ggSSd2ZSBub3QgaGFkIHRpbWUgdG8gZml4IHlldC4NCg0KPiBJdCBz
aG91bGQgYmUgbmFtZWQgX19YRU5fVU5TVEFCTEVfQVBJU19fLCBhbmQgdGhpbmtpbmcgb2YgaXQg
bGlrZSB0aGlzDQo+IHdpbGwgbWFrZSBpdCdzIHB1cnBvc2UgYSB3aG9sZSBsb3QgY2xlYXJlci4N
Cg0KPiAgKiBhdXRvbWF0aWNhbGx5IHNldCBfX1hFTl9JTlRFUkZBQ0VfVkVSU0lPTl9fIHRvIHRo
ZSBsYXRlc3Qgc3VwcG9ydGVkDQo+ICAqIGJ5IHRoZSAqc3lzdGVtKiBYZW4gaGVhZGVycyB3aGlj
aCB3ZXJlIHRyYW5zaXRpdmVseSBpbmNsdWRlZC4NCj4gICoNCj4gICogQyBmaWxlcyB3aGljaCBh
cmUgcGFydCBvZiB0aGUgaW50ZXJuYWwgZW11bGF0aW9uLCBhbmQgd2hpY2ggZGlkIG5vdA0KPiAg
KiBpbmNsdWRlIHhlbl9uYXRpdmUuaCwgbWF5IG5lZWQgdGhpcyBkZWZpbmVkIHNvIHRoYXQgdGhl
IFhlbiBoZWFkZXJzDQo+ICAqIGltcG9ydGVkIHRvIGluY2x1ZGUvaHcveGVuL2ludGVyZmFjZS8g
d2lsbCBleHBvc2UgdGhlIGFwcHJvcHJpYXRlIEFQSQ0KPiAgKiB2ZXJzaW9uLg0KPiAgKg0KPiAg
KiBUaGlzIGlzIHdoeSB0aGVyZSdzIGEgcnVsZSB0aGF0IHhlbl9uYXRpdmUuaCBtdXN0IGJlIGlu
Y2x1ZGVkIGZpcnN0Lg0KPiAgKi8NCj4NCj4gLi4uYmFzaWNhbGx5LCBpZiBzb21ldGhpbmcgZG9l
c24ndCBpbmNsdWRlIHhlbl9uYXRpdmUuaCBiZWZvcmUgeGVuLmgNCj4gdGhlbiBfX1hFTl9JTlRF
UkZBQ0VfVkVSU0lPTl9fIGNhbiBlbmQgdXAgZGVmaW5lZCB0byB0aGUgd3JvbmcgdGhpbmcuDQo+
IChEaXNjbGFpbWVyOiBJJ20gbm90IGEgWGVuIGV4cGVydCwgSSdtIGp1c3QgYXBwbHlpbmcgQ2hl
c3RlcnRvbidzIEZlbmNlLikNCg0KPiBfX1hFTl9JTlRFUkZBQ0VfVkVSU0lPTl9fIGRvZXMgYWx0
ZXIgc3RydWN0dXJlcy4gIEl0IG11c3QgYmUgY29uc2lzdGVudA0KPiBhY3Jvc3MgYSBjb2RlYmFz
ZS4NCg0KU3Rld2FydCBpZGVudGlmaWVkIGEgYmV0dGVyIHNvbHV0aW9uIGZvciB0aGlzIGJ1aWxk
cm9vdCBpc3N1ZSwgc28gSSBhbQ0Kd2l0aGRyYXdpbmcgdGhpcyBwYXRjaC4gIFRoaXMgcGF0Y2gg
aXMgbm90IG5lY2Vzc2FyeS4gIFRoYW5rIHlvdS4NCg0KQmVzdCByZWdhcmRzLA0KTmVhbCBGcmFn
ZXINCkFNRA0K

