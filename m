Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48491C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 13:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rayUb-0001Na-Nu; Fri, 16 Feb 2024 08:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rayUZ-0001N5-51
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:43:03 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1rayUW-0000WY-Gv
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 08:43:02 -0500
Received: from mail.andestech.com (ATCPCS12.andestech.com [10.0.1.220])
 by Atcsqr.andestech.com with ESMTP id 41GDgahA020673;
 Fri, 16 Feb 2024 21:42:36 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from ATCPCS31.andestech.com (10.0.1.89) by ATCPCS12.andestech.com
 (10.0.1.220) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 16 Feb 2024
 21:42:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.26.109)
 by mail.andestech.com (10.0.1.89) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Fri, 16 Feb 2024 21:42:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJlA8lxF2DpWmN8+Rgw0y1PnhTp9dmx6h8qk1poLr0WSCn77Z4QMAl/zl4qAjQ8pVgA19traP3o0AXx8+LMS4gw5zgEOhsdtVolbqIaJYIm7JXSTo8oBFj3+HTgfWA/XRM+Nz4tJOSZH+BssAPWP7sNjLYtsom95H1Kkp9AcKdR7KSot4yZGrhjcP0Q/y21q4V6bwBdXRDEcRc4qSgVb6+piM1JBNOLcM2az1xrnt4ldvoyZ+x3bcevVzwJ4SApSjCno0PRpOYYrpYD55DvHemtNChDgTBwmAw9GFj2xCwm4VN2ozWBfJ5atM1MlhDy7y25E1cTQ5R6K9HD3/oGbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTp/3sBLpmwkV9Ht5+CB2d6K9YrRHDnT8Cs6ZRoDQqY=;
 b=a601Qvb+7Y7BNbm9RFGM2+4XW1nEae2AYJ4N6cSes56kxSi3dh3bdP53Jzj0VSObs0SGr8JBRK1WkvIujrgtWBn/LGfhInkz74mZVutbiIpAgHqdK3Q+ffB06pPUFKpqV24tLKiFy9/E9/rFHLc+6mm4ZcDTl6X9JkJ5WCjPsd6MK3lYq7B9sbGECzP3oRdhQgPqw3AUYs48glrjixN4bFK7qt9zgbRAVKFC/8IO31pl0ImYhsRytLbI5SryfZGXntf7PkpjOGNp8RIKnf0h2mynIfvDK2tpU4DU73/kNxmfOjgOWvxd2OUdUftk+r53geGRGWQk4z355e2sd83SsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTp/3sBLpmwkV9Ht5+CB2d6K9YrRHDnT8Cs6ZRoDQqY=;
 b=Th5Zq6rL6FRO8MxYnpGTAzKDGWe3tBEpVgCgxn/VDZDqSq5TLz2aj65giZkUFSDGZw+MhDbO/PM1UdBagP1OOKSrwbd6e/RtrVsdPkce/H0MiG+vJkGgCFvSjc8Ianu6Xv5+VXxpBG900xU4O0RBrR6BKpdQmEaViJfHkwIDC93bcS8AZNkUxhnvRIYJz6zXW0IIgiqgFP9KFKUfspKXlmkdJn+7+8zIg/tDghl7j8reFK9SRL6jYGGYBWDyML0K/PRboWldVbMfxZfeiuYyc72NurFGnhFMkq+SdoEWvdNzL7BDvYJUbVrBNz+8Ujh6lB68BsvYkDw8Q9hcSwXcWA==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by KL1PR03MB8374.apcprd03.prod.outlook.com (2603:1096:820:137::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Fri, 16 Feb
 2024 13:42:29 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::42e4:f684:dde2:fd45]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::42e4:f684:dde2:fd45%7]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 13:42:28 +0000
From: =?utf-8?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmco5by15ZOy5ZiJKQ==?=
 <alvinga@andestech.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH 1/4] target/riscv: Add CSR tcontrol of debug trigger module
Thread-Topic: [PATCH 1/4] target/riscv: Add CSR tcontrol of debug trigger
 module
Thread-Index: AQHaYJ9cWaqPFTDvMUyQPzzK8nPcHrEM7F6AgAAJ4YA=
Date: Fri, 16 Feb 2024 13:42:28 +0000
Message-ID: <SEYPR03MB6700D4EC6DE89B2265EE5F82A84C2@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240216061332.50229-1-alvinga@andestech.com>
 <20240216061332.50229-2-alvinga@andestech.com>
 <164280dd-0899-42c5-b6a0-eb561f257591@ventanamicro.com>
In-Reply-To: <164280dd-0899-42c5-b6a0-eb561f257591@ventanamicro.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|KL1PR03MB8374:EE_
x-ms-office365-filtering-correlation-id: 3102fef2-24c1-4207-9e6c-08dc2ef51e16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWIlZ1Hko8tqfbNYplJVAyy7v2pcnjVqlBp6TMaYN/AlAoZmbv7Xw93lYHKXbnA34FqTZdPt0ioV4ptrM8ePusYC4m1PsUCXOp/1t8QZm+HA7a2hpNPQswbxUjsOYutqD0S9t/PfguD5iSGQvDFEZXxFGxzVwIjoRjKM6WNipwcjlyaQQkBs2w9J+h7XcYsYe+7SUAW6zzEzdEPfHJdluprvoy3Ubpyufz65UaBn2PnIh1yYVwk/lzUCtlR55vrIVZVhMVQnCxaxn2dPwQnSEPM6wyZKTRuzeqjlFZ66BwPwr/+asomw4Xi6DxNetcMrI+4tBM+uYQiml28b6JmH/i2ciINmWrOjhhyAknQHCR/SbVNK5jmVeAEiwa7HWQy0zfoKaIyzRlTBcWiHY6nLZzP3ot5ywrqU99MD5yOi2/FIQeJSLcxpiVTarLcprRqMEscUzp49x7wAr69cae0edsL/BZNb1U+y9VvOwTiPZ/kjDd2qnyYwlw1kliOqVs0E6XqCC1JZraG03wcZncysloNfjIlD69B0iKGvae4ADCCP/1J3uOSHryLVEuMaszesKO0ZpGIYldGP848zeWdd9x4ngaIbfrPsk2EnbhsBwVo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(396003)(346002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(83380400001)(26005)(122000001)(53546011)(8676002)(66946007)(8936002)(66476007)(64756008)(478600001)(52536014)(66446008)(66556008)(5660300002)(9686003)(6506007)(966005)(7696005)(2906002)(41300700001)(38070700009)(316002)(71200400001)(54906003)(110136005)(85182001)(76116006)(4326008)(86362001)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTNJK3NhdFdvYkJoN0hISkp0VGwrTkxPbEZROE5EVUJ1L2VERkQ2V0ZFTGt6?=
 =?utf-8?B?TnFXYjcvZCtNaDVxQytlVmwwMXhpa3ZLdjREZ0QxQW1mNTJ5cFFSaHpzQWg1?=
 =?utf-8?B?WmpCNXdwMlJyWnp0RzBVM1FqaHhWbUc3U0pxK3FiN1ovaVo1cDFhSUErYldD?=
 =?utf-8?B?UXRiTlBZVFVldUFpWXUzekJYN3VqRVJ2NSt3T2VweVZiQktPUEpjSzNjN3hy?=
 =?utf-8?B?cEMwZC9Ta0NKMXpESko0enp5RnlMMWYwQXczclRYZDkxWXdOZllUZTBITHhB?=
 =?utf-8?B?SlE4bkdwMUlYTFJUZWNocEpwcDBDcXpZWDNLTHF2WDZOeUtaSjNvMDAwbjJY?=
 =?utf-8?B?ZDBQRmhCbXJhUmNvek43bVVEaE4za09Xb1FkZmtJSEoyTWFLL3BmUVFzTnRV?=
 =?utf-8?B?TUIyZ244bnBNV2p0QnZNY0ZSb29iS3dBd3NoM3d3UFVVSytCM3kzeGlTempS?=
 =?utf-8?B?SENOeWdFcnNLQ0cxbEVDa0UwSWpkQ2tDU3c3VUk5Z2lySmZOWkJGcnA4aG9B?=
 =?utf-8?B?NzJxdUQyb2g2WTREYkRvTytZOWZTbkY2dVNMalN5cUkvQVFsZ2RYZGNQVUFY?=
 =?utf-8?B?MHVWOWU3UHdjdDBIT054cEh3NTY3Z3llR1l6dGpiSXBtSE4ycnVEdHFuY1Zv?=
 =?utf-8?B?ejFJWHh3NW9zdDFOY20wUUUxR1lIUk1tRGZhNHpyaHA1cDVJVVczckJoRTNh?=
 =?utf-8?B?T3R2Q3ByVWVMeEpYVUlQSWNTYXBjNHFEMHZ5VW1DU0thaVJOL2haY2dpbmpu?=
 =?utf-8?B?RGdVZkFPNVMyNEZYRkJUMWg0Y1B1UjcyR1JOc1hTWDNWR1FCUkR6VktsUHBh?=
 =?utf-8?B?MmVkcDVpWkJMZnA4R3lFQzRQeXdlSmRmcTltclZPNmZSSjJVRW1xeW1MV1or?=
 =?utf-8?B?NERkOU1CM3BNbm5DM1p4d2hlVnp1bXBzWFpUMnp4ZDdnYmU0b05oVGd2TzVL?=
 =?utf-8?B?UDgzQUw0dm43L2ZtdjluVVpXVkR3dXllZXdIYlJRR1AyWUlzcnFFMGtCVXB4?=
 =?utf-8?B?d2gwY1NpQkVlem9qZVZiL2dTbGZ0VVFpdHdTbjRDSEJWNDlxc0E4SjVmcUhX?=
 =?utf-8?B?NVFUeExEdkNVbjN6VUpXLzlmaWxJSTVsclRrL1BuaFVscUdjRFdqNDlYMlFo?=
 =?utf-8?B?V2FhdGVBcHBMUVVqR2RCTnY4amNKcnpVSkNwdW9HRkVjRWVndEZkMHhvb240?=
 =?utf-8?B?TDVRM2w2QzFlNnB3bVNPWTJ2eFBrQ0pvUEdra2hIUzA5YkN0dVVpWVEwcjlU?=
 =?utf-8?B?VU9CMFNjdmpHdkZUMlB2d0Qyd3pYY3lpT29tNFFJR1lKeFdOTU5IbG1STUsx?=
 =?utf-8?B?QlIzZ0hVVm1DRUY1Nlk2dXRpQWVqVERSbGwwTTFoTjNrdjBTaVRPZFdMNlF2?=
 =?utf-8?B?Wm9jYUtFUU5oZUd1TlVOYmIra3JXS2g0MWtoeGJZWkVUb0FvWGIvTTlNRDFv?=
 =?utf-8?B?T3pWUkxxN1MyNmU1M1QwUEJZczVSUjhhVFNwcVhSWjJtWldCRHBYTFZ0SVRN?=
 =?utf-8?B?TWJLZW13blFzeVMxSnBpc1kxRWtrbVlsZ3VoWkNWZTZXQWRXZlMzVzM3c0pi?=
 =?utf-8?B?OWNka3RGd2JUaDJIQzFEcDFrMXQxSllYYXpWSzdEZjdDZHJtdVVENDArYnRv?=
 =?utf-8?B?Q09neXlGYWdkUnI0akN1cGhsc2g1cGxNbWtJTVQvbFU5NWlpSW9scjMyb1lK?=
 =?utf-8?B?VWlGYmQ5L25mNllLczBmWXJEbm5VL2pBcVNUaW82bWcwWElibmNxelJNSTBW?=
 =?utf-8?B?UFhIQy9SRnZUVmMrbTR2M28ybFFKTG1wd1A0Z2w5U1hTVEFsMUQ2dWhBaFpF?=
 =?utf-8?B?QUNvelVmSE9hWm9UbmpWSVd6WTBUV2VVV1lBOGVwVDJnRkR6R1MrMHBSQ0FM?=
 =?utf-8?B?ZUNhYkg5b1VXR05UTFMxRmhDMzAvUVIyd0NJbzZSbFplNTREWHNVSzRVNnBy?=
 =?utf-8?B?OS9FY2VzUXlUQUdFTFNtY25LTzV2QStOQjlvdUxRVHNFTlM1Y1BTRjlURGxO?=
 =?utf-8?B?RXBWcW9LTklxVWpqRVN4ZVg4Z2JJVmdPS09EYnBVT1drcnNzTi9NVjBhaTh2?=
 =?utf-8?B?RmFwaXJwMmRGYjNOdjNya3RKNEh2U1ZoSjMveXFxRm41Y3FMSFdPcCtobmhW?=
 =?utf-8?Q?xuJvlydZkh8GOq2LNq7vPXv9Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3102fef2-24c1-4207-9e6c-08dc2ef51e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 13:42:28.6170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hfVfChBVrc61C5okgQqAuCaP0IJ6kWFrtYOVpxJ0OaWe2uOvL0mPEuryi6aVj+KGROw1GkvlFJ6+b/cFuvEdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8374
X-OriginatorOrg: andestech.com
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 41GDgahA020673
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

SGkgRGFuaWVsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmll
bCBIZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50YW5hbWljcm8uY29tPg0KPiBTZW50OiBG
cmlkYXksIEZlYnJ1YXJ5IDE2LCAyMDI0IDg6NTEgUE0NCj4gVG86IEFsdmluIENoZS1DaGlhIENo
YW5nKOW8teWTsuWYiSkgPGFsdmluZ2FAYW5kZXN0ZWNoLmNvbT47DQo+IHFlbXUtcmlzY3ZAbm9u
Z251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBhbGlzdGFpci5mcmFuY2lzQHdk
Yy5jb207IGJpbi5tZW5nQHdpbmRyaXZlci5jb207DQo+IGxpd2VpMTUxOEBnbWFpbC5jb207IHpo
aXdlaV9saXVAbGludXguYWxpYmFiYS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzRdIHRh
cmdldC9yaXNjdjogQWRkIENTUiB0Y29udHJvbCBvZiBkZWJ1ZyB0cmlnZ2VyIG1vZHVsZQ0KPiAN
Cj4gDQo+IA0KPiBPbiAyLzE2LzI0IDAzOjEzLCBBbHZpbiBDaGFuZyB3cm90ZToNCj4gPiBUaGUg
UklTQy1WIGRlYnVnIHNwZWNpZmljYXRpb24gZGVmaW5lcyBhbiBvcHRpb25hbCBDU1IgInRjb250
cm9sIg0KPiA+IHdpdGhpbiB0aGUgdHJpZ2dlciBtb2R1bGUuIFRoaXMgY29tbWl0IGFkZHMgaXRz
IHJlYWQvd3JpdGUgb3BlcmF0aW9ucw0KPiA+IGFuZCByZWxhdGVkIGJpdC1maWVsZCBkZWZpbml0
aW9ucy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsdmluIENoYW5nIDxhbHZpbmdhQGFuZGVz
dGVjaC5jb20+DQo+ID4gLS0tDQo+ID4gICB0YXJnZXQvcmlzY3YvY3B1LmggICAgICB8ICAxICsN
Cj4gPiAgIHRhcmdldC9yaXNjdi9jcHVfYml0cy5oIHwgIDMgKysrDQo+ID4gICB0YXJnZXQvcmlz
Y3YvY3NyLmMgICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCAxOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2Nw
dS5oIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oIGluZGV4DQo+ID4gZjUyZGNlNzhiYS4uZjlhZTNlMzAy
NSAxMDA2NDQNCj4gPiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCj4gPiArKysgYi90YXJnZXQv
cmlzY3YvY3B1LmgNCj4gPiBAQCAtMzY0LDYgKzM2NCw3IEBAIHN0cnVjdCBDUFVBcmNoU3RhdGUg
ew0KPiA+ICAgICAgIHRhcmdldF91bG9uZyB0ZGF0YTFbUlZfTUFYX1RSSUdHRVJTXTsNCj4gPiAg
ICAgICB0YXJnZXRfdWxvbmcgdGRhdGEyW1JWX01BWF9UUklHR0VSU107DQo+ID4gICAgICAgdGFy
Z2V0X3Vsb25nIHRkYXRhM1tSVl9NQVhfVFJJR0dFUlNdOw0KPiA+ICsgICAgdGFyZ2V0X3Vsb25n
IHRjb250cm9sOw0KPiA+ICAgICAgIHRhcmdldF91bG9uZyBtY29udGV4dDsNCj4gPiAgICAgICBz
dHJ1Y3QgQ1BVQnJlYWtwb2ludCAqY3B1X2JyZWFrcG9pbnRbUlZfTUFYX1RSSUdHRVJTXTsNCj4g
PiAgICAgICBzdHJ1Y3QgQ1BVV2F0Y2hwb2ludCAqY3B1X3dhdGNocG9pbnRbUlZfTUFYX1RSSUdH
RVJTXTsgZGlmZg0KPiA+IC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmggYi90YXJnZXQv
cmlzY3YvY3B1X2JpdHMuaCBpbmRleA0KPiA+IGZjMjA2OGVlNGQuLjNiM2E3YTBmYTQgMTAwNjQ0
DQo+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2NwdV9iaXRzLmgNCj4gPiArKysgYi90YXJnZXQvcmlz
Y3YvY3B1X2JpdHMuaA0KPiA+IEBAIC0zNTMsNiArMzUzLDcgQEANCj4gPiAgICNkZWZpbmUgQ1NS
X1REQVRBMiAgICAgICAgICAweDdhMg0KPiA+ICAgI2RlZmluZSBDU1JfVERBVEEzICAgICAgICAg
IDB4N2EzDQo+ID4gICAjZGVmaW5lIENTUl9USU5GTyAgICAgICAgICAgMHg3YTQNCj4gPiArI2Rl
ZmluZSBDU1JfVENPTlRST0wgICAgICAgIDB4N2E1DQo+ID4gICAjZGVmaW5lIENTUl9NQ09OVEVY
VCAgICAgICAgMHg3YTgNCj4gPg0KPiA+ICAgLyogRGVidWcgTW9kZSBSZWdpc3RlcnMgKi8NCj4g
PiBAQCAtOTAwLDYgKzkwMSw4IEBAIHR5cGVkZWYgZW51bSBSSVNDVkV4Y2VwdGlvbiB7DQo+ID4g
ICAjZGVmaW5lIEpWVF9CQVNFICAgICAgICAgICAgICAgICAgICAgICAgICAgKH4weDNGKQ0KPiA+
DQo+ID4gICAvKiBEZWJ1ZyBTZHRyaWcgQ1NSIG1hc2tzICovDQo+ID4gKyNkZWZpbmUgVENPTlRS
T0xfTVRFICAgICAgICAgICAgICAgICAgICAgICBCSVQoMykNCj4gPiArI2RlZmluZSBUQ09OVFJP
TF9NUFRFICAgICAgICAgICAgICAgICAgICAgIEJJVCg3KQ0KPiA+ICAgI2RlZmluZSBNQ09OVEVY
VDMyICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwM0YNCj4gPiAgICNkZWZpbmUgTUNP
TlRFWFQ2NA0KPiAweDAwMDAwMDAwMDAwMDFGRkZVTEwNCj4gPiAgICNkZWZpbmUgTUNPTlRFWFQz
Ml9IQ09OVEVYVCAgICAgICAgICAgICAgICAweDAwMDAwMDdGDQo+ID4gZGlmZiAtLWdpdCBhL3Rh
cmdldC9yaXNjdi9jc3IuYyBiL3RhcmdldC9yaXNjdi9jc3IuYyBpbmRleA0KPiA+IGQ0ZThhYzEz
YjkuLjgxNmM1MzA0ODEgMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2Nzci5jDQo+ID4g
KysrIGIvdGFyZ2V0L3Jpc2N2L2Nzci5jDQo+ID4gQEAgLTM5MzcsNiArMzkzNywyMCBAQCBzdGF0
aWMgUklTQ1ZFeGNlcHRpb24gcmVhZF90aW5mbyhDUFVSSVNDVlN0YXRlDQo+ICplbnYsIGludCBj
c3JubywNCj4gPiAgICAgICByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOw0KPiA+ICAgfQ0KPiA+DQo+
ID4gK3N0YXRpYyBSSVNDVkV4Y2VwdGlvbiByZWFkX3Rjb250cm9sKENQVVJJU0NWU3RhdGUgKmVu
diwgaW50IGNzcm5vLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0
YXJnZXRfdWxvbmcgKnZhbCkgew0KPiA+ICsgICAgKnZhbCA9IGVudi0+dGNvbnRyb2w7DQo+ID4g
KyAgICByZXR1cm4gUklTQ1ZfRVhDUF9OT05FOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMg
UklTQ1ZFeGNlcHRpb24gd3JpdGVfdGNvbnRyb2woQ1BVUklTQ1ZTdGF0ZSAqZW52LCBpbnQgY3Ny
bm8sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0YXJnZXRfdWxv
bmcgdmFsKSB7DQo+ID4gKyAgICBlbnYtPnRjb250cm9sID0gdmFsICYgKFRDT05UUk9MX01QVEUg
fCBUQ09OVFJPTF9NVEUpOw0KPiA+ICsgICAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiAgIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbiByZWFkX21jb250ZXh0KENQVVJJ
U0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdGFyZ2V0X3Vsb25nICp2YWwpDQo+ID4gICB7DQo+ID4gQEAgLTQ4NjEsNiAr
NDg3NSw3IEBAIHJpc2N2X2Nzcl9vcGVyYXRpb25zIGNzcl9vcHNbQ1NSX1RBQkxFX1NJWkVdID0g
ew0KPiA+ICAgICAgIFtDU1JfVERBVEEyXSAgICA9ICB7ICJ0ZGF0YTIiLCAgIGRlYnVnLCByZWFk
X3RkYXRhLA0KPiB3cml0ZV90ZGF0YSAgICB9LA0KPiA+ICAgICAgIFtDU1JfVERBVEEzXSAgICA9
ICB7ICJ0ZGF0YTMiLCAgIGRlYnVnLCByZWFkX3RkYXRhLA0KPiB3cml0ZV90ZGF0YSAgICB9LA0K
PiA+ICAgICAgIFtDU1JfVElORk9dICAgICA9ICB7ICJ0aW5mbyIsICAgIGRlYnVnLCByZWFkX3Rp
bmZvLA0KPiB3cml0ZV9pZ25vcmUgICB9LA0KPiA+ICsgICAgW0NTUl9UQ09OVFJPTF0gID0gIHsg
InRjb250cm9sIiwgZGVidWcsIHJlYWRfdGNvbnRyb2wsDQo+ID4gKyB3cml0ZV90Y29udHJvbCB9
LA0KPiANCj4gVGhlIHNwZWMgcmVhZHM6DQo+IA0KPiAiVGhpcyBvcHRpb25hbCByZWdpc3RlciBp
cyBvbmx5IGFjY2Vzc2libGUgaW4gTS1tb2RlIGFuZCBEZWJ1ZyBNb2RlIGFuZA0KPiBwcm92aWRl
cw0KPiAgIHZhcmlvdXMgY29udHJvbCBiaXRzIHJlbGF0ZWQgdG8gdHJpZ2dlcnMuIg0KPiANCj4g
ImRlYnVnKCkiIGlzIGNoZWNraW5nIG9ubHkgaWYgd2UgaGF2ZSB0aGUgJ2RlYnVnJyBjcHUgb3B0
aW9uIGVuYWJsZWQ6DQo+IA0KPiANCj4gc3RhdGljIFJJU0NWRXhjZXB0aW9uIGRlYnVnKENQVVJJ
U0NWU3RhdGUgKmVudiwgaW50IGNzcm5vKSB7DQo+ICAgICAgaWYgKHJpc2N2X2NwdV9jZmcoZW52
KS0+ZGVidWcpIHsNCj4gICAgICAgICAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gICAgICB9
DQo+IA0KPiAgICAgIHJldHVybiBSSVNDVl9FWENQX0lMTEVHQUxfSU5TVDsNCj4gfQ0KPiANCj4g
DQo+IEl0IGxvb2tzIGxpa2Ugd2UgZG9uJ3QgaGF2ZSBhICJEZWJ1ZyBNb2RlIiBtb2RlbC4NCg0K
WWVzLCBjdXJyZW50bHkgUklTQy1WIFFFTVUgZG9lc24ndCBoYXZlICJEZWJ1ZyBNb2RlIiwgc28g
SSBqdXN0IGlnbm9yZSBpdCBhbmQgb25seSBjb25zaWRlciBNLW1vZGUgaGVyZS4NCg0KPiANCj4g
U2VjdGlvbiA0LjEgb2YgdGhlIHNwZWMgbWVudGlvbnMgdGhlIGZvbGxvd2luZyBhYm91dCAiRGVi
dWcgTW9kZSI6DQo+IA0KPiAiMS4gQWxsIGltcGxlbWVudGVkIGluc3RydWN0aW9ucyBvcGVyYXRl
IGp1c3QgYXMgdGhleSBkbyBpbiBNLW1vZGUsIHVubGVzcyBhbg0KPiAgIGV4Y2VwdGlvbiBpcyBt
ZW50aW9uZWQgaW4gdGhpcyBsaXN0Lg0KPiAgIDIuIEFsbCBvcGVyYXRpb25zIGFyZSBleGVjdXRl
ZCB3aXRoIG1hY2hpbmUgbW9kZSBwcml2aWxlZ2UsIGV4Y2VwdCB0aGF0DQo+IGFkZGl0aW9uYWwN
Cj4gICBEZWJ1ZyBNb2RlIENTUnMgYXJlIGFjY2Vzc2libGUgYW5kIE1QUlYgaW4gbXN0YXR1cyBt
YXkgYmUgaWdub3JlZA0KPiBhY2NvcmRpbmcgdG8NCj4gICBtcHJ2ZW4uIEZ1bGwgcGVybWlzc2lv
biBjaGVja3MsIG9yIGEgcmVsYXhlZCBzZXQgb2YgcGVybWlzc2lvbiBjaGVja3MsIHdpbGwNCj4g
YXBwbHkNCj4gICBhY2NvcmRpbmcgdG8gcmVsYXhlZHByaXYgKC4uLikiDQo+IA0KPiANCj4gU28s
IGlmIHRoZSBvcGVyYXRpb25zIGFyZSAiZXhlY3V0ZWQgd2l0aCBtYWNoaW5lIG1vZGUgcHJpdmls
ZWdlIiB0aGVuIGNhbiB3ZQ0KPiBleHBlY3QNCj4gZW52LT5wcml2ID09IFBSVl9NID8gQXMgaXQg
aXMgbm93IHRjb250cm9sIHdpbGwgZXhlY3V0ZSBpbiBhbnkgbW9kZSwgc28NCj4gZW52LT5jaGVj
a2luZw0KPiBmb3IgUFJWX00gc2VlbXMgcmVhc29uYWJsZS4NCg0KVGhlIHJpc2N2X2NzcnJ3X2No
ZWNrKCkgZnVuY3Rpb24gaGFzIGNoZWNrZWQgdGhlIHByaXZpbGVnZSBsZXZlbCBieSB0aGUgYWNj
ZXNzZWQgQ1NSIGFkZHJlc3MuDQpQbGVhc2Ugc2VlIGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3Fl
bXUvYmxvYi9tYXN0ZXIvdGFyZ2V0L3Jpc2N2L2Nzci5jI0w0MzYwLg0KSWYgdGhlIGN1cnJlbnQg
cHJpdmlsZWdlIGxldmVsIGlzIGxvd2VyIHRoYW4gdGhlIGFjY2Vzc2VkIENTUiwgdGhlIGlsbGVn
YWwgaW5zdHJ1Y3Rpb24gZXhjZXB0aW9uIGlzIHJhaXNlZC4NCg0KQWNjb3JkaW5nIHRvIHByaXZp
bGVnZSBzcGVjLCBlYWNoIENTUiBhZGRyZXNzIGhhcyB0d28gYml0cyB0byBlbmNvZGUgdGhlIGxv
d2VzdCBwcml2aWxlZ2UgbGV2ZWwgdG8gYWNjZXNzIHRoYXQgQ1NSLg0KU2R0cmlnIENTUnMgKHRz
ZWxlY3QsIHRkYXRhezF+M30sIHRpbmZvLCBtY29udGV4dCwgYW5kIHRjb250cm9sKSBhcmUgZW5j
b2RlZCB3aXRoaW4gMHg3QTB+MHg3QUYsDQpUaGVyZWZvcmUsIHRoZWlyIGxvd2VzdCByZXF1aXJl
ZCBwcml2aWxlZ2UgbGV2ZWwgaXMgTS1tb2RlLg0KSWYgZW52LT5wcml2IDwgUFJWX00sIHRoZSBj
aGVja2luZyBvbiB0aG9zZSBDU1IgZmFpbHMgaW4gcmlzY3ZfY3NycndfY2hlY2soKS4NCg0KSXMg
dGhpcyBlbm91Z2gsIG9yIGRvIEkgbWlzcyBzb21ldGhpbmc/DQoNCg0KU2luY2VyZWx5LA0KQWx2
aW4gQ2hhbmcNCg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IA0KPiBEYW5pZWwNCj4gDQo+IA0K
PiANCj4gDQo+IA0KPiA+ICAgICAgIFtDU1JfTUNPTlRFWFRdICA9ICB7ICJtY29udGV4dCIsIGRl
YnVnLCByZWFkX21jb250ZXh0LA0KPiA+IHdyaXRlX21jb250ZXh0IH0sDQo+ID4NCj4gPiAgICAg
ICAvKiBVc2VyIFBvaW50ZXIgTWFza2luZyAqLw0K

