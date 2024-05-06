Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F90BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 05:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3rBu-0007yW-Kg; Mon, 06 May 2024 01:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s3rBW-0007nD-JA; Mon, 06 May 2024 01:46:56 -0400
Received: from mail-sh0chn02on2071d.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::71d]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1s3rBQ-0005oD-1v; Mon, 06 May 2024 01:46:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRbF6h+Pv01o4u8Xbq9T7C87+wFwG/aBBYLX2Qoc15TrB5QQJcVyMUNceh2QMK8Hoa1zir0JiSsBgXndzQ38vfw70NqPDW069+7hioLBhWuN5azRSDvoD4YC8gWbYo8ZyHYRrFsxXoRz80c4JFFROPiFkp2OKF2q77i6WdXOdioKjYFY40EzEtNE6eTpTDuJyXpq8zs/R8o0O1UWi3VDArLLv89+/jEOhWREJHkoZrmv1Wc+pQ8uWnBce39nSfdyRvEbF7xCoL1Fs8ahx2bOWPzHrbenAUc2LMGmpjGrnKSr1saHTdQu4YcYswZriPetkzv2Y0oJ/5qKKmyy2k0bIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soINnmFFapw1a4ZiYQ4Op3sbyioJxy1Oo/jJBkWGxco=;
 b=C4467Ed4yJfiaUDtZ6fBu4oqwoBQXAKYXIhntjXXooJUBKLMVMzgLANtM9F/KRJehqn/zV1/UYdi23+s4qllCIqOM/KFE21DgluYNn2Ty2XHrZ3PU/WnThPOBJYFRr9CCO0tRklY3ZaGzXLys84pre4rrp4dOoZTzG+IUJHhSEFqf1DGRGSura75Y3de74850a8dDOMD4rMNuyroWqW+Mr+TC5YKcPZZW7nBeEa+mLWuylym/aTBv6zl50p5aIjZIlTQTR8rvnU5UHJQUb1U9QiBGHB3/qGElpxgJNW5PkdX6tMlEmbTja57eIDaoLsyBflmQSr+GpM29X0atgzniQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:12::10) by NT0PR01MB1040.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Mon, 6 May
 2024 05:46:24 +0000
Received: from NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
 ([fe80::e604:661e:e939:4c87]) by
 NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn ([fe80::e604:661e:e939:4c87%4])
 with mapi id 15.20.7472.044; Mon, 6 May 2024 05:46:24 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v1 0/2] Upgrade ACPI SPCR table to support SPCR table
 version 4 format
Thread-Topic: [PATCH v1 0/2] Upgrade ACPI SPCR table to support SPCR table
 version 4 format
Thread-Index: AQHanE9f4TY4Mv2Vj0W7wml1LjpFr7GDqtWAgAYLrAA=
Date: Mon, 6 May 2024 05:46:24 +0000
Message-ID: <NT0PR01MB12781A762B996998AF0B7FDD9C1CA@NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn>
References: <20240502051233.50749-1-jeeheng.sia@starfivetech.com>
 <CAFEAcA_FO7BvUDbnJdUTkuatFse7bWR2mjL2OQ_vsB_dLdKbow@mail.gmail.com>
In-Reply-To: <CAFEAcA_FO7BvUDbnJdUTkuatFse7bWR2mjL2OQ_vsB_dLdKbow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1278:EE_|NT0PR01MB1040:EE_
x-ms-office365-filtering-correlation-id: be68fc63-9511-4cd7-87e2-08dc6d8fdd67
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Akt23vHCeXkjWHpbw5oaTGQZBIWup7ELBfE4CuyitYNiSuw8iMAQTfNjqBdgSQ4/cfHbwf1x8/PFbWdLHXU36XmFWNkGKdg4csYtgtbxPy/1keubpcoZKP5wRdxrw/P1Wwj0u9Uc55Kg25QSy569jH8ol/Eo6rJSBht10RDc8xSIuYZaMgQ+NB8Z8QlMT+SFa5ea1ooYj0e2khcagOmoQIDZJxOQp1wXPa6T2RJoATyaBDFYGHAy6WGml/O8ocAqH79Eb3OABwkqAEmb880nzqBh7irrUepxEJxau58O9DFfYcp8Wy5Ds+E3BN7mR2vT3W8vFxUJ1Zf2SDVy/hnv0SnB2qKrT472FePu86SHhar0O51LiP9nRRU/4PNAMITa6IJLUA6p5fitt5wVcO3lg2m4Grt5yZxBFAQcSXDUDBcpqmPUD5Hewt68z7DlWNEXeAKt8vp6TBcXit7+cEXVgwxZnZdJ2vMK4uFPFPQ0KN/PQiAYKNCEXg0/ALU7QMMydIaeC0VTA1z5vRfBVPx8vJrg08GztHV7I62wYdfNok5sMSo7cBMLLHPnxP1h6crESZ45osOXlFXiyCLbDzE/PfpSWLXnsU9xKnNhaHev5K/awvj2CxGeohVYfeDSOyxe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230031)(366007)(41320700004)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzRESDJkaTYvWWRVV1V3SDlKNTcwUm9iQ2tHOGgweE9yWFF5S0xXSlpRTEZY?=
 =?utf-8?B?cTVwNU91MU5BbFFaMzVDSGtyeTNTTG1zckZPaE1CUk9oTTlwQXZhR1lvTGtt?=
 =?utf-8?B?S0lmRTkyQURtL3Z3UzltLzBOdmNBS0NPc1F3Q0NIbEZDQ2NJRi9xTEo0L1R4?=
 =?utf-8?B?bmx4MXQrbi9KZTBZZStVdlBQeVZjYVZmcDdtT2M3U0VQc3dkSE40TWZlWUZZ?=
 =?utf-8?B?S004d00vcFQ0MnBpeXpSR0ZQSTl0SE9YeUhYQkV5Qy9aL2NReDVYZS9JUXlz?=
 =?utf-8?B?WUZGeGZyRjlzWkg2cm9acEVFNXBHTVdEcU05cmNBbldLc3VFZ1pyTms4U3ls?=
 =?utf-8?B?RjNpbHR3M1VUdzRyM1RXQ0NHL3VMSkRmQ2NqQ0RweWRwVUpYYU9jZ3JjZ1Y5?=
 =?utf-8?B?ZDBxWTQwWkV1ZTYzbTdjc1NuV0d1cFh5VE5sdFJuTENDOXFDZmZxRlJFQktw?=
 =?utf-8?B?bi90V1duQi9COFpRNEY5Qzg1TWIwWkhFY0ppSk5VYXh1V1YrRDlMQXZGNHRx?=
 =?utf-8?B?dmRwOHFnOEU4NnBVZUMzZ3VDYXZ2S0lLaWZZN0kzZDZOQ0FBRUhDSUhOS2h4?=
 =?utf-8?B?aDBma0V6VFREYk43L25aNlFmQVo3bTJzbFI5SElkSzJuRjlqNENDczdhSTJL?=
 =?utf-8?B?YTQyeTRzRWxrbnJKK3oxdzJIc1RUbmpZTGZKbCt6UVkrQ2lQWkFnc3VIUHcw?=
 =?utf-8?B?c09IQUl1aVp5cVUrUGtFTWlrVXlpczJwbHljelJCSCttN1dwTmkxdFJmbG1Y?=
 =?utf-8?B?L2FJVktjTWFUb1BCSUdrU0EwSHVPUVRxVzBUMitZb1lHNXdIejQ1OHpnaTIv?=
 =?utf-8?B?UUtGWklMaWRhSmlZQ2ZYTTBaT29rS0lPRU5LeHVRYlhMejhPb3JzNGRleWFh?=
 =?utf-8?B?OTBidXN6ejJNcXhKWkZGN1A0Zkk0eTRGUCtZbkhnNWgzbFdrbWp5bHBhdWlo?=
 =?utf-8?B?RTBXSWJWZHl6TW5KTlllN29Fd09RV0grQmRQSllUZG1SWDlWODZrV1lCWXVX?=
 =?utf-8?B?NkduQ1FRcVdmbk9Od0s0bUljbXAxYjNnODZIQ1NDU3RKbGNPK0VPYXVxZFNO?=
 =?utf-8?B?bjRoVGd4M25hM0ZRZkRCTTJnaVVvQ05lR0g5UmhPcjllVDR2UUYycW1iQUo0?=
 =?utf-8?B?alM3OEUwSHJPYktiK3NUcmx2NjJISkRMMFNpQVQrbk5QS1NLdmp1ais0QWd5?=
 =?utf-8?B?aFl6Rnd0dEtONnE4eDdoZm4rZ2E3eU1YNmRYUWZiUElPc05SNFo4N2hmTFpR?=
 =?utf-8?B?dTRGQ0VONFVhVTJ2b0J2OHd0TkRLY3A1aVpRQllpYVJtYVJrUnl4bitZSnIv?=
 =?utf-8?B?MjBURVV2akRvN21JSE5xVGYwQ0FiZWVkNllxMjRQMHRCUXRreENpQStRcmgx?=
 =?utf-8?B?S2laWmpwQnNLQlJmd3E3NG5VL21QMkVzc0F4b2NjUTVOaVNvWkVibVFzNkVY?=
 =?utf-8?B?bzVkcWtBbE0rQ3F4djNFaFZobEV2VnpmS1JhVFRBMmF5YkZHQXpUYmZQSFE3?=
 =?utf-8?B?ZGhQaEpNdWF1STNqemp5WHVTNUdZSm5Ca3V3VUN4bUlKV3FYTVFCbnRQeC9j?=
 =?utf-8?B?eC9TYmlFNExaQ0J2Vkk5SFdzWFFwelZiNXNoaDJPS21oaEpKZWJGUlJabU1p?=
 =?utf-8?B?djVzVlJvcTExVTJrdUxiYnVFMFRkNEJnVmg1aTB6ZUFHa1pWWEVHczBmK1NF?=
 =?utf-8?B?WEo4Nndrbnp5aTdiMTBjaFNRcVBFMElob1JFMkVGYUJReW0wa0VWempXVUta?=
 =?utf-8?B?a2RhU3VMdjhmdkdzY2V1SjNqeGpCQVp3K3hNWTdLTnhVQjJCeXVBZ3F3c2Q1?=
 =?utf-8?B?Q1F6TnUzQVhxaTVFNmFvRXZOUDBDcE5JTk1YakdwZFBkV1B4NTZsU2laZnp5?=
 =?utf-8?B?VXVaZFRhMWU5QzJ2eHpPcjdOT0QyMmdOTGlJKzdwbVZJcFRyUVpOUituR1ZL?=
 =?utf-8?B?UlNZUDJXYW5RNUkrMDAwWmpNY0RlUTRRUFFuOEJWT3Y2ZHRnc2I0OFpFdWtT?=
 =?utf-8?B?QzhvbEY2WU53Mm1ja1B6Qk1Cb0tFUm5GTGRZWUF1eGhzVTBWUGh1Sytaeklv?=
 =?utf-8?B?dmNiRklKMS83MWc5K0V6TFl0dFY0K0l2MVdYVFhRK0pYTTF4dmRUU2J6aWNs?=
 =?utf-8?B?V2Iyc0lHQWhsS3dTZHBiMzUvSDN3Y1htbkdOSmhISjV2ZzRjT0gzU2t4NjR6?=
 =?utf-8?B?R2cxUmtPRGpncWxPaW83dDN0WlVEZzRBS0RodE45SXF4M3FuSk15UE9yaTBu?=
 =?utf-8?B?U3R1cENBMU5PeHZLTUpSNjdtUlJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1278.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: be68fc63-9511-4cd7-87e2-08dc6d8fdd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 05:46:24.1499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOM9NZNqrPVvsVPe2nfHpqZZQowgHY/SDJjdIddawQscs8EDdnDDyoOKmE+wJwbJFVzZwjkh1SDQnSYQuJrvpPxW4tFKfQIvnvr2AdAwT1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1040
Received-SPF: pass client-ip=2406:e500:4420:2::71d;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDIsIDIwMjQg
NToxOSBQTQ0KPiBUbzogSmVlSGVuZyBTaWEgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+
DQo+IENjOiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUt
cmlzY3ZAbm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb207IGltYW1tZWRvQHJlZGhhdC5jb207DQo+
IGFuaXNpbmhhQHJlZGhhdC5jb207IHNoYW5ub24uemhhb3NsQGdtYWlsLmNvbTsgc3VuaWx2bEB2
ZW50YW5hbWljcm8uY29tOyBwYWxtZXJAZGFiYmVsdC5jb207IGFsaXN0YWlyLmZyYW5jaXNAd2Rj
LmNvbTsNCj4gYmluLm1lbmdAd2luZHJpdmVyLmNvbTsgbGl3ZWkxNTE4QGdtYWlsLmNvbTsgZGJh
cmJvemFAdmVudGFuYW1pY3JvLmNvbTsgemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYxIDAvMl0gVXBncmFkZSBBQ1BJIFNQQ1IgdGFibGUgdG8gc3Vw
cG9ydCBTUENSIHRhYmxlIHZlcnNpb24gNCBmb3JtYXQNCj4gDQo+IE9uIFRodSwgMiBNYXkgMjAy
NCBhdCAwNjoxMiwgU2lhIEplZSBIZW5nIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPiB3
cm90ZToNCj4gPg0KPiA+IFVwZGF0ZSB0aGUgU1BDUiB0YWJsZSB0byBhY2NvbW1vZGF0ZSB0aGUg
U1BDUiBUYWJsZSB2ZXJzaW9uIDQgWzFdLg0KPiA+IFRoZSBTUENSIHRhYmxlIGhhcyBiZWVuIG1v
ZGlmaWVkIHRvIGFkaGVyZSB0byB0aGUgdmVyc2lvbiA0IGZvcm1hdCBbMl0uDQo+ID4NCj4gPiBN
ZWFud2hpbGUsIHRoZSB2aXJ0IFNQQ1IgZ29sZGVuIHJlZmVyZW5jZSBmaWxlcyBoYXZlIGJlZW4g
dXBkYXRlZCB0bw0KPiA+IGFjY29tbW9kYXRlIHRoZSBTUENSIFRhYmxlIHZlcnNpb24gNC4NCj4g
Pg0KPiA+IFsxXTogaHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFy
ZHdhcmUvZHJpdmVycy9zZXJwb3J0cy9zZXJpYWwtcG9ydC1jb25zb2xlLXJlZGlyZWN0aW9uLXRh
YmxlDQo+ID4gWzJdOiBodHRwczovL2dpdGh1Yi5jb20vYWNwaWNhL2FjcGljYS9wdWxsLzkzMQ0K
PiA+DQo+ID4gU2lhIEplZSBIZW5nICgyKToNCj4gPiAgIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVz
LXRlc3Q6IFVwZGF0ZSB2aXJ0IFNQQ1IgZ29sZGVuIHJlZmVyZW5jZXMNCj4gPiAgIGh3L2FjcGk6
IFVwZ3JhZGUgQUNQSSBTUENSIHRhYmxlIHRvIHN1cHBvcnQgU1BDUiB0YWJsZSB2ZXJzaW9uIDQN
Cj4gPiAgICAgZm9ybWF0DQo+IA0KPiBUaGlzIGlzbid0IHRoZSByaWdodCB3YXkgdG8gbWFrZSBh
IGNoYW5nZSB0aGF0IHJlcXVpcmVzDQo+IHVwZGF0ZXMgdG8gdGhlIGJpb3MtdGFibGVzLXRlc3Qg
cmVmZXJlbmNlIGZpbGVzLCBiZWNhdXNlDQo+ICJtYWtlIGNoZWNrIiB3aWxsIGZhaWwgYWZ0ZXIg
cGF0Y2ggMSBidXQgYmVmb3JlIHBhdGNoIDIuDQo+IA0KPiBZb3UgbmVlZCBhIHRocmVlLXBhdGNo
IGFwcHJvYWNoLiBIb3cgdG8gZG8gdGhhdCBpcyBkb2N1bWVudGVkDQo+IGluIHRoZSBjb21tZW50
IGF0IHRoZSB0b3Agb2YgYmlvcy10YWJsZXMtdGVzdC5jLiBUaGUgcmVzdWx0aW5nDQo+IHRocmVl
IHBhdGNoZXMgc2hvdWxkIGxvb2sgbGlrZToNCj4gICogcGF0Y2ggMSB1cGRhdGVzIGJpb3MtdGFi
bGVzLXRlc3QtYWxsb3dlZC1kaWZmLmggdG8NCj4gICAgbWFyayB0aGUgYWZmZWN0ZWQgdGVzdCBv
ciB0ZXN0cyBhcyAiT0sgdG8gZmFpbCINCj4gICogcGF0Y2ggMiBtYWtlcyB0aGUgY2hhbmdlcyB0
byBRRU1VIHRoYXQgYWx0ZXIgdGhlDQo+ICAgIHJlcXVpcmVkIHRhYmxlIG91dHB1dA0KPiAgKiBw
YXRjaCAzIHVwZGF0ZXMgdGhlIHJlZmVyZW5jZSBmaWxlcyBhbmQgcmVtb3ZlcyB0aGUNCj4gICAg
dGVzdHMgZnJvbSB0aGUgYWxsb3dlZC1kaWZmIGZpbGUNCj4gDQo+IFNlZSBmb3IgaW5zdGFuY2Ug
Y29tbWl0cyA2YzFjMmU5MTJmY2Y5LCAxZWM4OTZmZTdjYTkzOCwNCj4gZWEyZmRlNWJjY2M1MTQg
YXMgYW4gZXhhbXBsZS4NClRoYW5rIHlvdSBmb3IgdGhlIGd1aWRhbmNlLiBJIHdpbGwgaW1wcm92
ZSB0aGUgcGF0Y2ggYnkgcmVmZXJyaW5nIHRvIHRoZSBleGFtcGxlIHByb3ZpZGVkLg0KPiANCj4g
U2lkZSBub3RlOiBpZiByaXNjdiB2aXJ0IGhhcyBBUENJIHRhYmxlcyBub3csIG1heWJlIHdlDQo+
IHNob3VsZCBhZGQgdGVzdGluZyBvZiB0aGVtIHRvIHRoZSBiaW9zLXRhYmxlcy10ZXN0ID8NClN1
cmUuIEkgd2lsbCBtYWtlIG1vZGlmaWNhdGlvbnMgYmFzZWQgb24gdGhlIFJJU0MtViB0ZXN0Lg0K
PiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K

