Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE29C54E41
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 01:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ri2mL-0001vm-IG; Wed, 06 Mar 2024 20:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1ri2mH-0001v9-Dc; Wed, 06 Mar 2024 20:42:33 -0500
Received: from mail-sh0chn02on2071e.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::71e]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeeheng.sia@starfivetech.com>)
 id 1ri2mD-0005en-2V; Wed, 06 Mar 2024 20:42:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8JS2cI25kbxp+Yus7ql7mJeIRSkk+MoAsbx8EIqoL+stYBeldkNaosxStyxUa9O1PwvoMlMxD2Sx24v/VMPmWLGHuGevlGurPaE+uzICzVIR2RyGJJnIpSydWN21zakygjeOqK1vuKAFNNFkGTYNFnA+0X5Ym2ve5GeAdi9j+FlIlpurKj90JsTN2BBBMN95+rq8TmlrD/RcWQR1kCXDlIpxZD/OT4mEnSfbKgBfrpFKi61ymRTOjX+ZCD5olJSke0J7SZVEagEqoXo+XR9xKzpu91LzuQbIPLoLAKpKAtqpLbwv49p8/sqDE9gr+60n/0vgr2gaouCv7OoK4J6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjY8xjRgw1XKlpSFpSh8Rup8DuDr1aXKFtfBcvB29s8=;
 b=IrNwZ14B2StLFr2Xe1uHdZErwtfRW1uH6FD9r2uzsGFY9iljq+x5bl1PxSxWtBtOFgeWUzV3cX2cQ0QZjcO0uoCDdEiyWTKVhKVIliinZCpK0L7+JqzTbz0Sz18W8uUIztcqggoaqxhzmZq6XRsqpBL3s0f5ssNuEr1ftKMe0CXIMkTdSN+zCP+OYFBBVTh0nMTAtiu0T/N2fmdBW2r1WYZQxxEJdPl5JGKN6kVwJo6+q3Z/cJhU47RDg7DeQJU4sfRudQtvqJDfE85FbK723a1CNYYdVzVbGX9j+FZBGim/v0+R1ds80nQmMdMzh10bXSSrsGhWamvBmW25SsEguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0738.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.53; Thu, 7 Mar
 2024 01:42:17 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::fcfa:931b:8b1d:6af5]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::fcfa:931b:8b1d:6af5%4])
 with mapi id 15.20.7316.051; Thu, 7 Mar 2024 01:42:17 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Alistair Francis <alistair23@gmail.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "sunilvl@ventanamicro.com" <sunilvl@ventanamicro.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation to
 common location
Thread-Topic: [PATCH v2 1/2] hw/arm/virt-acpi-build.c: Migrate SPCR creation
 to common location
Thread-Index: AQHaSBizfyvzvOGo7kCqbD2U89wd5bErYCmAgABuioCAAAGbkA==
Date: Thu, 7 Mar 2024 01:42:17 +0000
Message-ID: <BJSPR01MB056197A3F4FAB9DC8C5BB9999C20A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240116010930.43433-1-jeeheng.sia@starfivetech.com>
 <20240116010930.43433-2-jeeheng.sia@starfivetech.com>
 <49d0d8d3-c7fd-4039-aeed-6c31ba16557a@ventanamicro.com>
 <CAKmqyKPE-ERHShmAJQH3VNc7XqOfOeKYYyCRswJSUwf7hqm1xA@mail.gmail.com>
In-Reply-To: <CAKmqyKPE-ERHShmAJQH3VNc7XqOfOeKYYyCRswJSUwf7hqm1xA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0738:EE_
x-ms-office365-filtering-correlation-id: 4d8f4ed2-c71b-4f5f-9ac0-08dc3e47d268
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ZWRnMqkMQntK3Y8mivQm0+shlHaiwJBvBvpP47xN74ZGfMFlJ5uzKrKqSmxcz+cab+80aQFNU8zf/QPtp8x49bcdrXIS/G2baWFJN8UOsiwM3AGxoafBnKEyhA3ddNlQrkm79cGHjts6G7472S0TKavllxUpoMKtc/PZlK2jGmydYKkHkbywuLSvs9idWB4dICCFNyn0yZ24RppsGrvxnbDAZG08FWexiPMMBVFiMr14t7pLe253ZVSTANRkbpxt7bkgFJ8c59zd9mqbPBpy7jIJJmMaCgcb1i9hJw3MzYIyvbsSlvvyVJDbYScPq1kAFNszzDh6BGM9g3ofL8yndzuzIQXDfVdu324q+wVYi9fyOL7fAz/TS8KLvTwiGtwvu5yolahy7vZj99+0K+iyuOEDEP7D5GWn6hMuKhc0zA8NKssp6/WZoMXO5bN8rkcjG715OMqaZ33VbfKq2k2VAAJVYsPJxtcZeAE80edqcqa94s8bSngSobOPshI0R6x/GMVhyRl7gYMhn10mA08Sk4n7uFbIOJY+ZKk7mkHedajVL9ll99xbJR7+dRZuXOBvSDCUAIdmeEBieL1SMrUtMGf1xeJEXGGcctLm+fgh1JzNWKUwzJbbDv/49JpFpqL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230031)(41320700004)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWlqSWI1M1lvS1RaNzMvK0N4WTk0VFBTNzFreU1qN0VHVlBCb0NabGxtVG9K?=
 =?utf-8?B?Z1pXa0dWN3lzbzdwbkV2VzZ2MCtiMzQxd0dVMyttQnkycjBkSGNLZTVmU0Yw?=
 =?utf-8?B?YS9XUEs4dlRNSXpyekhxd05sSWxzSXF4M1NaeXFJOXpSckM5a2FUaFV0ZHNx?=
 =?utf-8?B?NmdMU0pISFRuWjZwWHAwTy9taVJwNUJQUXBPTlUyOXQvZEVoWkNEdDlTTWtO?=
 =?utf-8?B?Uk5pejJLb1RTY0lmRThMZTV1YTE5VlFnVHBJSHEyQzkzM1VVNXlPcnV4Z1NK?=
 =?utf-8?B?bGoxOTI5STF2UnRiZUdUT21ldWg4U1hWUkM1dGtaK2ppSjNOMnBsckVqWGtQ?=
 =?utf-8?B?WldFYy9xSkVJYmh4ZWMzZEhzSkk4eHA0KzRkeHJ3NWRjMjl2R0dDaEdLbjNQ?=
 =?utf-8?B?eTlmckRDd0dRdXRVVDZ5T0V3TVN3eG1PQVhQcWJMQTZ1SVpTVzZuNFVaL1pI?=
 =?utf-8?B?WHpsSVEwczRGVnRHL0U3M2VpY2x2WjBlb2k5NG05YStGMkFVTW5sY1cza0pR?=
 =?utf-8?B?VmFVblZjZXI0djZqMlNyMVh0WjM1MVhodmZPQXk2cGVLUko2N1pkUWJSNnJq?=
 =?utf-8?B?LytOMTIyc2Z5Z1dnaWFaTk9LSlhXakVKa05LT0NqWXVMTUExaE1IN0pBc3NK?=
 =?utf-8?B?T3VKVFJ2NUlnSzRaTitkTEFtTVN2YWZndkpnWGtrd0crQVV1a3NzUUVpc2w1?=
 =?utf-8?B?d3BJeDBCKzVZVlRoTzZyaExlUXlxTUwvTkVuT2pFanVKS0RCWDNxVy9QaE8x?=
 =?utf-8?B?NWhic25qRDVmOUR6bTIwOEdYalFOQUEvNnU2c3V1cUh2bmx1aGovTEQrMGZh?=
 =?utf-8?B?TTYyU0lOelpsa21YRlBUZmdRZ1lVc3JseThDa0M1ODRPVUVoa3lFZ3NSZ21D?=
 =?utf-8?B?VDErWDNtMG94ZmQ3Q0c0R2xOUGVXK1BKMkw5UERpeU5rdTkyNzMrTWNtMmdO?=
 =?utf-8?B?N09VY2NHTFFBL0xJamNyaWtSMnlnWGZOeFN2U3dUT2ZwZDlKNHlFMGJqejkz?=
 =?utf-8?B?WU5ZSEdoY01xUFVqTlpVMStaN2JrMjRMeVd4cTdwRThhcDlSRWxrVUxzcnU3?=
 =?utf-8?B?UzhSbDQ5THA2Ui85ODdoaW1mR3llelBzdkIvLzRWNXNkclZ0eEZkUmpNWHRP?=
 =?utf-8?B?cmhzaXFoZkRQTmpUWFpuTEJsSExrTXJOSGs5NVRlYjJJUG1VcHN3WWZteXc1?=
 =?utf-8?B?LzcrMkxEcS9JanVJelB1cnhwb1k1WXdJdVAvWDB6MWw0YVF5bmVSS0V3QnZI?=
 =?utf-8?B?WE9uRERna2cwRjB5MWVoa2lmSTYyRk5DanFxR2svYW40eVlhM1VTUndYS2Vj?=
 =?utf-8?B?aHZWRWxwKzllOGU1d094WjlJeVJtcDlNR0JyT2UrT1N3TTJ2YVBZTU1DeXdN?=
 =?utf-8?B?cGljZjZUc0JoVUVkbGxnZmU3Q25seEwzM1RGcTk3eEo2MnpLVE1CbGlZOXl2?=
 =?utf-8?B?MEozU2hheXdDTGp6MkdnMEtmcVExcFNCYzdyc2ZEY1F6QUE5am5XNDRlTENR?=
 =?utf-8?B?U2RlWnpLamh4WXVWT2srU0FIVmRta0QyT2lYNDNYVUFaTVVhNVBoSEtVWVYx?=
 =?utf-8?B?TlFTMlJrSXdtMmpwSnBCMG9VdGdvU3Z4VTByb2F5R1d4R3pHaXZyT1BvUTZ3?=
 =?utf-8?B?djZaSWpMZStXL3VJVXJldXcrRUdWQjd3cjZKVWY0cCtUMnVnZUl5aG5DQy84?=
 =?utf-8?B?Tk5zK0pkU2JhaUM5UzBDZEt2NWJ2UTMwRlZYRXJSWFNOeVBKdlZSb1NrWm4y?=
 =?utf-8?B?d2hNRWpyY3ZRc0pDN3NoZXV1TFh0SUF2MHRlYm1oNGtTVWt2Z240ZHRuYVZo?=
 =?utf-8?B?SGxyQmNtR2hidk8vNU9zUFhINXFyUmV5djRYRGdjYmxOc2FvWWpIM2dvR2tn?=
 =?utf-8?B?RmkvRENwNTN4U3NzRG9POEdxMjlQTGEyTDIvOEgyNTdqYmRib3FPU2pNSGtT?=
 =?utf-8?B?SDEvTVpmemtXR2djRWVreWpBU2oxOU5KN0JwT1hQRHFSNDdwY3R3aGo2R0Na?=
 =?utf-8?B?d2l4a0pwYkVWWE9ZOTF2ZU9EKzltcUZhNzdEM0hmWVk5R0VaRTRmMlkyU2k1?=
 =?utf-8?B?dmVYZlRKWUFpYzJocHVlRUJ5R1BMZzZvU0tOR3dTUkxTdm00RjNYZVRtMVM2?=
 =?utf-8?B?SDE4RFRpR0l6cGc0a1ByTnhJcEErVVB0RlM2ZnRydXBxYXQ0R0QvbkV6c1NB?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8f4ed2-c71b-4f5f-9ac0-08dc3e47d268
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 01:42:17.3030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pk4bVVlL7ySgxK3Rs2Fxr4OZnF4Kn+xdim0CzdwazBI1/J9KDhnAuD/Y6AWmqnSnmxkJiMPvgAnh+iLREmI4ZKiKKJuPNge4k0AqblwjciI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0738
Received-SPF: pass client-ip=2406:e500:4420:2::71e;
 envelope-from=jeeheng.sia@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIyM0BnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCA3LCAyMDI0
IDk6MzMgQU0NCj4gVG86IERhbmllbCBIZW5yaXF1ZSBCYXJib3phIDxkYmFyYm96YUB2ZW50YW5h
bWljcm8uY29tPg0KPiBDYzogSmVlSGVuZyBTaWEgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5j
b20+OyBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtcmlz
Y3ZAbm9uZ251Lm9yZzsNCj4gbXN0QHJlZGhhdC5jb207IGltYW1tZWRvQHJlZGhhdC5jb207IGFu
aXNpbmhhQHJlZGhhdC5jb207IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgc2hhbm5vbi56aGFv
c2xAZ21haWwuY29tOw0KPiBzdW5pbHZsQHZlbnRhbmFtaWNyby5jb207IHBhbG1lckBkYWJiZWx0
LmNvbTsgYWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tOyBiaW4ubWVuZ0B3aW5kcml2ZXIuY29tOyBs
aXdlaTE1MThAZ21haWwuY29tOw0KPiB6aGl3ZWlfbGl1QGxpbnV4LmFsaWJhYmEuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8yXSBody9hcm0vdmlydC1hY3BpLWJ1aWxkLmM6IE1pZ3Jh
dGUgU1BDUiBjcmVhdGlvbiB0byBjb21tb24gbG9jYXRpb24NCj4gDQo+IE9uIFRodSwgTWFyIDcs
IDIwMjQgYXQgNDo1OeKAr0FNIERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYmFyYm96YUB2
ZW50YW5hbWljcm8uY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gVGhpcyBwYXRj
aCBicmVhayBjaGVjay1xdGVzdCwgbW9zdCBzcGVjaWZpY2FsbHkgJ2Jpb3MtdGFibGUndGVzdCcs
IGZvciBhYXJjaDY0Lg0KPiA+IEkgZm91bmQgdGhpcyB3aGlsZSBydW5uaW5nIHJpc2N2LXRvLWFw
cGx5Lm5leHQgaW4gdGhlIEdpdGxhYiBwaXBlbGluZS4NCj4gPg0KPiA+DQo+ID4gSGVyZSdzIHRo
ZSBvdXRwdXQ6DQo+ID4NCj4gPiAkIG1ha2UgLWogJiYgUVRFU1RfUUVNVV9CSU5BUlk9Li9xZW11
LXN5c3RlbS1hYXJjaDY0IFY9MSAuL3Rlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QNCj4gPiBU
QVAgdmVyc2lvbiAxMw0KPiA+ICMgcmFuZG9tIHNlZWQ6IFIwMlNmMGYyZmEwYTNmYWM1ZDU0MGIx
NjgxYzgyMDYyMWI3ZA0KPiA+ICMgc3RhcnRpbmcgUUVNVTogZXhlYyAuL3FlbXUtc3lzdGVtLWFh
cmNoNjQgLXF0ZXN0IHVuaXg6L3RtcC9xdGVzdC01OTEzNTMuc29jayAtcXRlc3QtbG9nIC9kZXYv
bnVsbCAtY2hhcmRldg0KPiBzb2NrZXQscGF0aD0vdG1wL3F0ZXN0LTU5MTM1My5xbXAsaWQ9Y2hh
cjAgLW1vbiBjaGFyZGV2PWNoYXIwLG1vZGU9Y29udHJvbCAtZGlzcGxheSBub25lIC1hdWRpbyBu
b25lIC1tYWNoaW5lIG5vbmUgLWFjY2VsDQo+IHF0ZXN0DQo+ID4gMS4uOA0KPiA+ICMgU3RhcnQg
b2YgYWFyY2g2NCB0ZXN0cw0KPiA+ICMgU3RhcnQgb2YgYWNwaSB0ZXN0cw0KPiA+ICMgc3RhcnRp
bmcgUUVNVTogZXhlYyAuL3FlbXUtc3lzdGVtLWFhcmNoNjQgLXF0ZXN0IHVuaXg6L3RtcC9xdGVz
dC01OTEzNTMuc29jayAtcXRlc3QtbG9nIC9kZXYvbnVsbCAtY2hhcmRldg0KPiBzb2NrZXQscGF0
aD0vdG1wL3F0ZXN0LTU5MTM1My5xbXAsaWQ9Y2hhcjAgLW1vbiBjaGFyZGV2PWNoYXIwLG1vZGU9
Y29udHJvbCAtZGlzcGxheSBub25lIC1hdWRpbyBub25lIC1tYWNoaW5lIHZpcnQgIC1hY2NlbCB0
Y2cNCj4gLW5vZGVmYXVsdHMgLW5vZ3JhcGhpYyAtZHJpdmUgaWY9cGZsYXNoLGZvcm1hdD1yYXcs
ZmlsZT1wYy1iaW9zL2VkazItYWFyY2g2NC1jb2RlLmZkLHJlYWRvbmx5PW9uIC1kcml2ZQ0KPiBp
Zj1wZmxhc2gsZm9ybWF0PXJhdyxmaWxlPXBjLWJpb3MvZWRrMi1hcm0tdmFycy5mZCxzbmFwc2hv
dD1vbiAtY2Ryb20gdGVzdHMvZGF0YS91ZWZpLWJvb3QtaW1hZ2VzL2Jpb3MtdGFibGVzLQ0KPiB0
ZXN0LmFhcmNoNjQuaXNvLnFjb3cyIC1jcHUgY29ydGV4LWE1NyAtc21iaW9zIHR5cGU9NCxtYXgt
c3BlZWQ9MjkwMCxjdXJyZW50LXNwZWVkPTI3MDAgLWFjY2VsIHF0ZXN0DQo+ID4gYWNwaS10ZXN0
OiBXYXJuaW5nISBTUENSIGJpbmFyeSBmaWxlIG1pc21hdGNoLiBBY3R1YWwgW2FtbDovdG1wL2Ft
bC05RzUzSjJdLCBFeHBlY3RlZCBbYW1sOnRlc3RzL2RhdGEvYWNwaS92aXJ0L1NQQ1JdLg0KPiA+
IFNlZSBzb3VyY2UgZmlsZSB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMgZm9yIGluc3Ry
dWN0aW9ucyBvbiBob3cgdG8gdXBkYXRlIGV4cGVjdGVkIGZpbGVzLg0KPiA+IGFjcGktdGVzdDog
V2FybmluZyEgU1BDUiBtaXNtYXRjaC4gQWN0dWFsIFthc2w6L3RtcC9hc2wtU1I1M0oyLmRzbCwg
YW1sOi90bXAvYW1sLTlHNTNKMl0sIEV4cGVjdGVkIFthc2w6L3RtcC9hc2wtNFozM0oyLmRzbCwN
Cj4gYW1sOnRlc3RzL2RhdGEvYWNwaS92aXJ0L1NQQ1JdLg0KPiA+DQo+ID4gVGhlIGRpZmYgaXMg
aGVyZToNCj4gPg0KPiA+IC0tLSAvdG1wL2FzbC00WjMzSjIuZHNsIDIwMjQtMDMtMDYgMTU6NDA6
MjQuODc5ODc5MzQ4IC0wMzAwDQo+ID4gKysrIC90bXAvYXNsLVNSNTNKMi5kc2wgMjAyNC0wMy0w
NiAxNTo0MDoyNC44Nzc4NzkzNDcgLTAzMDANCj4gPiBAQCAtMSw1NyArMSw0OSBAQA0KPiA+ICAg
LyoNCj4gPiAgICAqIEludGVsIEFDUEkgQ29tcG9uZW50IEFyY2hpdGVjdHVyZQ0KPiA+ICAgICog
QU1ML0FTTCsgRGlzYXNzZW1ibGVyIHZlcnNpb24gMjAyMjAzMzEgKDY0LWJpdCB2ZXJzaW9uKQ0K
PiA+ICAgICogQ29weXJpZ2h0IChjKSAyMDAwIC0gMjAyMiBJbnRlbCBDb3Jwb3JhdGlvbg0KPiA+
DQo+ID4gKC4uLikNCj4gPg0KPiA+ICAgWzAwMGggMDAwMCAgIDRdICAgICAgICAgICAgICAgICAg
ICBTaWduYXR1cmUgOiAiU1BDUiIgICAgW1NlcmlhbCBQb3J0IENvbnNvbGUgUmVkaXJlY3Rpb24g
VGFibGVdDQo+ID4gLVswMDRoIDAwMDQgICA0XSAgICAgICAgICAgICAgICAgVGFibGUgTGVuZ3Ro
IDogMDAwMDAwNTANCj4gPiArWzAwNGggMDAwNCAgIDRdICAgICAgICAgICAgICAgICBUYWJsZSBM
ZW5ndGggOiAwMDAwMDA0Rg0KPiA+ICAgWzAwOGggMDAwOCAgIDFdICAgICAgICAgICAgICAgICAg
ICAgUmV2aXNpb24gOiAwMg0KPiA+IC1bMDA5aCAwMDA5ICAgMV0gICAgICAgICAgICAgICAgICAg
ICBDaGVja3N1bSA6IEIxDQo+ID4gK1swMDloIDAwMDkgICAxXSAgICAgICAgICAgICAgICAgICAg
IENoZWNrc3VtIDogQjINCj4gPiAgIFswMEFoIDAwMTAgICA2XSAgICAgICAgICAgICAgICAgICAg
ICAgT2VtIElEIDogIkJPQ0hTICINCj4gPg0KPiA+ICguLi4pDQo+ID4NCj4gPiAtWzA0MmggMDA2
NiAgIDJdICAgICAgICAgICAgICAgIFBDSSBWZW5kb3IgSUQgOiBGRkZGDQo+ID4gK1swNDJoIDAw
NjYgICAyXSAgICAgICAgICAgICAgICBQQ0kgVmVuZG9yIElEIDogMDBGRg0KPiA+DQo+ID4NCj4g
PiBBZnRlciBpbnNwZWN0aW5nIHRoZSBjb21tb24gaGVscGVyIGFuZCB3aGF0IHRoZSBvcmlnaW5h
bCBBUk0gY29kZSB3YXMgZG9pbmcNCj4gPiBJIGZvdW5kIG91dCB0aGF0IHdlJ3JlIG1pc3Npbmcg
c29tZXRoaW5nIGRvd24gdGhlcmU6DQo+ID4NCj4gPg0KPiA+IE9uIDEvMTUvMjQgMjI6MDksIFNp
YSBKZWUgSGVuZyB3cm90ZToNCj4gPiA+IFJJU0MtViBzaG91bGQgYWxzbyBnZW5lcmF0ZSB0aGUg
U1BDUiBpbiBhIG1hbm5lciBzaW1pbGFyIHRvIEFSTS4NCj4gPiA+IFRoZXJlZm9yZSwgaW5zdGVh
ZCBvZiByZXBsaWNhdGluZyB0aGUgY29kZSwgcmVsb2NhdGUgdGhpcyBmdW5jdGlvbg0KPiA+ID4g
dG8gdGhlIGNvbW1vbiBBTUwgYnVpbGQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2lh
IEplZSBIZW5nIDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiAgIGh3L2FjcGkvYW1sLWJ1aWxkLmMgICAgICAgICB8IDUxICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiA+ICAgaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jICAgIHwgNjggKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ID4gICBpbmNsdWRlL2h3L2FjcGkv
YWNwaS1kZWZzLmggfCAzMyArKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgaW5jbHVkZS9ody9h
Y3BpL2FtbC1idWlsZC5oIHwgIDQgKysrDQo+ID4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTE1IGlu
c2VydGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9o
dy9hY3BpL2FtbC1idWlsZC5jIGIvaHcvYWNwaS9hbWwtYnVpbGQuYw0KPiA+ID4gaW5kZXggYWY2
NmJkZTBmNS4uZjM5MDQ2NTBlNCAxMDA2NDQNCj4gPiA+IC0tLSBhL2h3L2FjcGkvYW1sLWJ1aWxk
LmMNCj4gPiA+ICsrKyBiL2h3L2FjcGkvYW1sLWJ1aWxkLmMNCj4gPiA+IEBAIC0xOTk0LDYgKzE5
OTQsNTcgQEAgc3RhdGljIHZvaWQgYnVpbGRfcHJvY2Vzc29yX2hpZXJhcmNoeV9ub2RlKEdBcnJh
eSAqdGJsLCB1aW50MzJfdCBmbGFncywNCj4gPiA+ICAgICAgIH0NCj4gPiA+ICAgfQ0KPiA+ID4N
Cj4gPiA+ICt2b2lkIGJ1aWxkX3NwY3IoR0FycmF5ICp0YWJsZV9kYXRhLCBCSU9TTGlua2VyICps
aW5rZXIsDQo+ID4gPiArICAgICAgICAgICAgICAgIGNvbnN0IEFjcGlTcGNyRGF0YSAqZiwgY29u
c3QgdWludDhfdCByZXYsDQo+ID4gPiArICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm9lbV9p
ZCwgY29uc3QgY2hhciAqb2VtX3RhYmxlX2lkKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgQWNwaVRh
YmxlIHRhYmxlID0geyAuc2lnID0gIlNQQ1IiLCAucmV2ID0gcmV2LCAub2VtX2lkID0gb2VtX2lk
LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIC5vZW1fdGFibGVfaWQgPSBvZW1fdGFi
bGVfaWQgfTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgYWNwaV90YWJsZV9iZWdpbigmdGFibGUsIHRh
YmxlX2RhdGEpOw0KPiA+ID4gKyAgICAvKiBJbnRlcmZhY2UgdHlwZSAqLw0KPiA+ID4gKyAgICBi
dWlsZF9hcHBlbmRfaW50X25vcHJlZml4KHRhYmxlX2RhdGEsIGYtPmludGVyZmFjZV90eXBlLCAx
KTsNCj4gPiA+ICsgICAgLyogUmVzZXJ2ZWQgKi8NCj4gPiA+ICsgICAgYnVpbGRfYXBwZW5kX2lu
dF9ub3ByZWZpeCh0YWJsZV9kYXRhLCAwLCAzKTsNCj4gPiA+ICsgICAgLyogQmFzZSBBZGRyZXNz
ICovDQo+ID4gPiArICAgIGJ1aWxkX2FwcGVuZF9nYXModGFibGVfZGF0YSwgZi0+YmFzZV9hZGRy
LmlkLCBmLT5iYXNlX2FkZHIud2lkdGgsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgZi0+
YmFzZV9hZGRyLm9mZnNldCwgZi0+YmFzZV9hZGRyLnNpemUsDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgZi0+YmFzZV9hZGRyLmFkZHIpOw0KPiA+ID4gKyAgICAvKiBJbnRlcnJ1cHQgdHlw
ZSAqLw0KPiA+ID4gKyAgICBidWlsZF9hcHBlbmRfaW50X25vcHJlZml4KHRhYmxlX2RhdGEsIGYt
PmludGVycnVwdF90eXBlLCAxKTsNCj4gPiA+ICsgICAgLyogSVJRICovDQo+ID4gPiArICAgIGJ1
aWxkX2FwcGVuZF9pbnRfbm9wcmVmaXgodGFibGVfZGF0YSwgZi0+cGNfaW50ZXJydXB0LCAxKTsN
Cj4gPiA+ICsgICAgLyogR2xvYmFsIFN5c3RlbSBJbnRlcnJ1cHQgKi8NCj4gPiA+ICsgICAgYnVp
bGRfYXBwZW5kX2ludF9ub3ByZWZpeCh0YWJsZV9kYXRhLCBmLT5pbnRlcnJ1cHQsIDQpOw0KPiA+
ID4gKyAgICAvKiBCYXVkIFJhdGUgKi8NCj4gPiA+ICsgICAgYnVpbGRfYXBwZW5kX2ludF9ub3By
ZWZpeCh0YWJsZV9kYXRhLCBmLT5iYXVkX3JhdGUsIDEpOw0KPiA+ID4gKyAgICAvKiBQYXJpdHkg
Ki8NCj4gPiA+ICsgICAgYnVpbGRfYXBwZW5kX2ludF9ub3ByZWZpeCh0YWJsZV9kYXRhLCBmLT5w
YXJpdHksIDEpOw0KPiA+ID4gKyAgICAvKiBTdG9wIEJpdHMgKi8NCj4gPiA+ICsgICAgYnVpbGRf
YXBwZW5kX2ludF9ub3ByZWZpeCh0YWJsZV9kYXRhLCBmLT5zdG9wX2JpdHMsIDEpOw0KPiA+ID4g
KyAgICAvKiBGbG93IENvbnRyb2wgKi8NCj4gPiA+ICsgICAgYnVpbGRfYXBwZW5kX2ludF9ub3By
ZWZpeCh0YWJsZV9kYXRhLCBmLT5mbG93X2NvbnRyb2wsIDEpOw0KPiA+DQo+ID4gSGVyZS4gV2Un
cmUgbWlzc2luZyB0aGUgIkxhbmd1YWdlIiBlbnRyeS4NCj4gPg0KPiA+DQo+ID4gVGhpcyBkaWZm
IGZpeGVzIHRoZSBicm9rZW4gdGVzdDoNCj4gPg0KPiA+DQo+ID4gJCBnaXQgZGlmZg0KPiA+IGRp
ZmYgLS1naXQgYS9ody9hY3BpL2FtbC1idWlsZC5jIGIvaHcvYWNwaS9hbWwtYnVpbGQuYw0KPiA+
IGluZGV4IGYzOTA0NjUwZTQuLjZkNDUxN2NmYmUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYWNwaS9h
bWwtYnVpbGQuYw0KPiA+ICsrKyBiL2h3L2FjcGkvYW1sLWJ1aWxkLmMNCj4gPiBAQCAtMjAyNCw2
ICsyMDI0LDggQEAgdm9pZCBidWlsZF9zcGNyKEdBcnJheSAqdGFibGVfZGF0YSwgQklPU0xpbmtl
ciAqbGlua2VyLA0KPiA+ICAgICAgIGJ1aWxkX2FwcGVuZF9pbnRfbm9wcmVmaXgodGFibGVfZGF0
YSwgZi0+c3RvcF9iaXRzLCAxKTsNCj4gPiAgICAgICAvKiBGbG93IENvbnRyb2wgKi8NCj4gPiAg
ICAgICBidWlsZF9hcHBlbmRfaW50X25vcHJlZml4KHRhYmxlX2RhdGEsIGYtPmZsb3dfY29udHJv
bCwgMSk7DQo+ID4gKyAgICAvKiBMYW5ndWFnZSAqLw0KPiA+ICsgICAgYnVpbGRfYXBwZW5kX2lu
dF9ub3ByZWZpeCh0YWJsZV9kYXRhLCBmLT5sYW5ndWFnZSwgMSk7DQo+ID4gICAgICAgLyogVGVy
bWluYWwgVHlwZSAqLw0KPiA+ICAgICAgIGJ1aWxkX2FwcGVuZF9pbnRfbm9wcmVmaXgodGFibGVf
ZGF0YSwgZi0+dGVybWluYWxfdHlwZSwgMSk7DQo+ID4gICAgICAgLyogUENJIERldmljZSBJRCAg
Ki8NCj4gDQo+IFRoYW5rcyEgSSBhZGRlZCB0aGlzIHRvIHRoZSBwYXRjaA0KPiANCj4gPg0KPiA+
DQo+ID4NCj4gPiBBcyBhIHNpZGUgbm90ZSwgaXQgc2VlbXMgbGlrZSAnYmlvcy10YWJsZS10ZXN0
JyBpc24ndCBiZWluZyBydW4gZm9yIFJJU0MtVi4gTm90IHN1cmUgaWYgdGhpcw0KPiA+IGlzIGlu
dGVudGlvbmFsIG9yIGEgZm9yZXNpZ2h0Lg0KPiANCj4gSSB0aGluayB5b3UgYXJlIGxvb2tpbmcg
Zm9yIG92ZXJzaWdodCA6KQ0KPiANCj4gSSB0aGluayBpdCdzIGp1c3QgYW4gb3ZlcnNpZ2h0LCBu
b3QgaW50ZW50aW9uYWwuDQpJIGFwb2xvZ2l6ZSBmb3IgdGhlIG92ZXJzaWdodCBJJ3ZlIG1hZGUg
dGhhdCBjYXVzZWQgdGhlIHRyb3VibGUuDQpUaGFua3MgZm9yIHRoZSBxdWljayB0dXJuYXJvdW5k
Lg0KPiANCj4gQWxpc3RhaXINCg==

