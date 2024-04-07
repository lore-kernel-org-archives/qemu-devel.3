Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209C9CD11C2
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 13:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtSVS-0006yW-GB; Sun, 07 Apr 2024 09:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtL9l-0001Yx-1B; Sun, 07 Apr 2024 01:33:29 -0400
Received: from mail-tyzapc01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2011::700]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gavin.liu@jaguarmicro.com>)
 id 1rtL9i-0008Iu-I4; Sun, 07 Apr 2024 01:33:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjDrtuWPaUZqV2jjQZLQDjXfxvnf+WpITAwprGOVzc7PF/afRIsyB0uShhTYtreOHFwVNDvInMJvV2alfahJGjSKyq50iVJ45/tVnHoiSSwytTpA+F6R/jJzuDR6PF+qKvyIKnqd6WLiFPzYTJ8v/f9Z9kRcDjGvOojgwIVkjGSBioXSVai86+203vjdN5hLRsM3fzq+lBQikPGGR2YsujSXoO4P8xGRftoXUeRyr+Bq8+AQwFDB0VO3ZMiBVywi/X6bx1anMocqyMhIQYk+cqaIeKbEqvvJvG2EcICfAkmeTSwwI8glg7lFiM/FTRP1jEvT95EJBVhJfUZ5RMsObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H13xEdFz+K4uFbFsuY1EyihJrz4h380nLiFySvKoKv8=;
 b=VY3+zIptvdfqFXHGWsD2GhFfECxP23XvvTKm3PoVkqHic4VhYeLhM6a6PSNIXNi3rPjYOxLmPdlGO7N7m4NM5Nm2glfHzIHi0e19xXurRyWhxGN7bi8PZQHHXYWk0U80P06Qy58thU9kio0n8sIy2TlY3NUGAnFqQGUAPvdpjd9/IzKFAsGZdSzDSzK72261J+2v8ikndlh064RPIsYhikfLqH+AqIYaJ7fxIKtsvSb8F09pkR+SVx8qSZG1f2e9RKGmyYK/fSTGV/7NkYe+SnLPwrDmfjGrPgD/qEdQohrHaHy+MBG9+C01vjhPQEU3549HJALZ1Tn2t2ailKzDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H13xEdFz+K4uFbFsuY1EyihJrz4h380nLiFySvKoKv8=;
 b=ULA5Zhmk0noQ/1WUkAWA83bnRE1uS6wH5P7IFFM2ltcjB4HKKWcxPMY8z3+a4SK7mcuSt+ZwdvwSK3Ho08clmlCdW1k2MscckVfx/2/Xr6RyQP7u03ychP57w4AYqcSPoPDBePHAQHHag6BBTzjw2ulS2Yxl9GKmNID/dM5F72q5hvxgmOdc2O3UfPupIehcClohQSn6yAfX6zn0MC987jvU3S6uvOR9RL1OkFWowhfdPAsTZlXsUpfo11j0x4tmZ+tzq6BxIyZPmvQKDTAOKevtlTyz/i/do+UxqkxQu5nSjplo6N3hr9wdpRIH8uV/hBODmzAyilulocWOmY49uw==
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by SEZPR06MB5644.apcprd06.prod.outlook.com (2603:1096:101:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Sun, 7 Apr
 2024 05:33:17 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::922f:a649:adbf:6634%6]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 05:33:17 +0000
From: Gavin Liu <gavin.liu@jaguarmicro.com>
To: Jason Wang <jasowang@redhat.com>
CC: "eperezma@redhat.com" <eperezma@redhat.com>, "sgarzare@redhat.com"
 <sgarzare@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>
Subject: Thanks! Reply: [PATCH]vdpa-dev: Fix the issue of device status not
 updating when configuration interruption is triggered
Thread-Topic: Thanks! Reply: [PATCH]vdpa-dev: Fix the issue of device status
 not updating when configuration interruption is triggered
Thread-Index: AdqIqwRu0oawkxatSO23NqrXHNs8eA==
Date: Sun, 7 Apr 2024 05:33:16 +0000
Message-ID: <SEYPR06MB675695B6843420C6DABFAF7AEC012@SEYPR06MB6756.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB6756:EE_|SEZPR06MB5644:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eq8QFs6VloFoYBVeG3UrsfeFzzMzbQumojL0ujmyg7r7qHjts2+f2YIkH4ZN+7BEWCG+fbqNHrwptwK4ctF8wTh2JZJlTv1m5XCBTIoE9cR0VVqfD/ErFmLtevtopF7sr21O4Qug4Zz8yttLFOodI6/qO62AtHErVlXiHeJiMSLrwcsdxzEZXaN4LADe80TzpNYLBeKyn3EupShxNmT3aC4YJ26rubXEPPYHldAhSPsAmb7r36FrMWDpOKq/mQkaE4xPKYuhURjk4UPxCWbcOpickTGe6lJdxGjkt8g7BBczDoDDhJ/29RrZttb6X6CAgoK63XrhLfDrIu4+p3fNLR9QLjkbTPUq6vpezdXBQS5EzxKsYtIsm8nUf5eQzMfI5m4gSIh6sF/xdiSs65sSKsKetPENoYDjrSXAouhO91RoRSAmQK0tJrfHkeAoICK/PSBoBkT7wV3DTvehIfnkFqeHlPRapE1MoNFM3hqJ+QgWC93XJuM40U68Y/XUfrRpfd5U4LFbq4wvMV4R5DYjoUv3RmEPwpfPSF9QH25vydzx6tLR50yIRoL5PoK2Ju+uNFuU71oC+z+/PnaWNYKADbmYSrj/rPFDM4s/VRGx01IHTxZpprmzBmFrrrT4E4Rhw+XccaW0yM7sFTm83evisAbYhyO3j5kZwgayvDlZKz8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR06MB6756.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTI0dGRDUkhWK3JLQmUrOFRvSGl5UEdTNE9ScjlIMUxhR3pybUM1KzZSN2xL?=
 =?utf-8?B?bnUzUHZQVlhyeCtqdmRvYlFwMmJQakgrbEpZUGJtTEJnT2tpaXNNWm0rRG4r?=
 =?utf-8?B?M2lEV2d6N2xNTnhDYjd6VGM3TERCeEt4eXd5NTZYK2xvV1Z2MGt5emQwTGNk?=
 =?utf-8?B?aGRHYVloUG1vc09vUEVkOHJzVkZxUWtseURZckZuQ082QlB3ejl6NzN2eHlm?=
 =?utf-8?B?Zk42MWFYRkMwZXJIaGlUZWlVS0RrN0hwN3p2NkhXdEVqdmg5dEM0aUF4NzRq?=
 =?utf-8?B?MWNYZ0dwbGxaM0svWkpXOE8rWllSNHhGWjdPV2VCMlpPR1dzeGVtK2VLdk4w?=
 =?utf-8?B?ZU1TOVREekpoNWdrdzVJN1FzRHlQT2RIS2p6NFFrSlF3Wm11MnVHOW13Qjg0?=
 =?utf-8?B?bGw5dkdTVjVTekZvL04zUWRIS3VTYzBkVVJlOVVycmhMVDJuQ2FVR0h0RUNi?=
 =?utf-8?B?L1o0MHp3dWsvZHZURnJRc3NuWTVRa0RIeGlDTlhRZ09XTXZPU01yemlOVHY4?=
 =?utf-8?B?OVpLMEJxSGRPdjM2RnJrbTl2ZWVpV0xkUFhudENJckhmakVuUmdDWk0yRXVU?=
 =?utf-8?B?eGlUSDFZTUF6dGpQajNKNUEvZVFURUsvNmR0UjhhMWFiOThKYVRxck1SOE16?=
 =?utf-8?B?L2J0TG1CK0p1T25JQlNkNHNQQU1IaUNUcG9rWGc5czBqOHowUlRzcVlxV01Q?=
 =?utf-8?B?cFE1NHdiTUZsRDZzcnBicWVoYW4waGs4VU12NHpacTNPRCtZWVlEUVoxRTRh?=
 =?utf-8?B?dXJkZTd1V2FKdWovZ09aTDZ0Vnp0UUVGdXNyTVFLN0E2bEs2Z21tSDg0Y0VT?=
 =?utf-8?B?SUNPU2NXOER1U0krdmY0d2kyYVpFZGpJNzRoUitHZWFDOEpwTm9WM1QyOUY5?=
 =?utf-8?B?dThRclY3MkdsZ3FBTlRtUkNpSFdnSitzS0pWclp2V1RZZ3cvcmJOL1RwVXVE?=
 =?utf-8?B?Q0tiSE80N2IyZ2RwTzZ0R1RyT2xxS3pzMEJZUFhwK1hSSDB2cVI3TG1tUzRj?=
 =?utf-8?B?YTRHZzVCVHhRRG9zK0pxbFl3SW1iWFFkZXZrSnZPMUhTWnpTNHVFUnFNUGdm?=
 =?utf-8?B?akUyaFg2WVJ2cnhveVhLUHpWbU15ZGZJMmRUQXFvemY3T3ZMaFJTSXNyU2tM?=
 =?utf-8?B?ZFV0cUdsVW8wVzdZNzVCRDkxMVVpZUhiK2hpZFRva2ZwVW1wUVVjYWdFdVNV?=
 =?utf-8?B?TjY1Zzl3MjZwSVdIRkp6NllHZkZqdTBHZVRYWWxqRXI0R0dRaE1DQVM5aTMw?=
 =?utf-8?B?Ky9XNFgraktVU2lRTHBickVOTWZFM1YyM3JTSlBFRTBacndEQlB0VDBUaEFK?=
 =?utf-8?B?cStQK3oycFdpeUpzK0JPVWw4biswNnE4bzJnMUhzR1l0cUVtdTcvY3VWNGRY?=
 =?utf-8?B?TkxzaE8zL0NVZ3hEUDlraVBQK3NwWWJpc1JZZG1HZ3RQQ0tDVnFVU0Vpei9n?=
 =?utf-8?B?dDdqNHRtMU4rbkFxcEVFQVNTaWhISGhVMll0ZWYzZkJqbitaUmh5UnBuZHBy?=
 =?utf-8?B?U2xQSzFIa3Bvc0NjSUdPeFJ4R3BPTURSTzNJOVNmTFE4U2tGdFVVeHIwV1Yz?=
 =?utf-8?B?SjBIR1pKdlcxNDhPbnBCMUxJOTBqZmNGYzQvLyszSi8ra2FoYm9JSHlERkdI?=
 =?utf-8?B?V3N3NVJVT2k1N0Y3Z0VydFc5TUpzQWNzS3VyUkRnc0kzQ1BFUitET0tVenBr?=
 =?utf-8?B?QzFyd0JtalI5aGZSTWdXTy92NlYzTVRHcDA5dWdTaDd3SG51M09UUHpuVVR6?=
 =?utf-8?B?cVNlNFlMRnBZa21QU3Q3YjhhRTJzQllEN3pkRjdEUGNnamFPMkVsT0Jyejdz?=
 =?utf-8?B?L1ZlRHlycExXai9kUFZReFcxSm9CMzRWQ0l1NUlMblduS3psRlE1M0VQMDdl?=
 =?utf-8?B?Rk4vZWNONkZ5czhXZTN2dWF5K3hmQVk3a3MzMUw0cVc5ZVhwS2VkUkV4UkQy?=
 =?utf-8?B?elpzWnE5UkZabkNyY3RXdkt5UWxMOE8rRXlxMDdVeWsvR2Fmelgwa20yc20v?=
 =?utf-8?B?N1F1UzRxbkd1ZXZGd3lEdDh3R2JoNnNaRkR4RXBWWWFZeDVCc29yWDFJTm85?=
 =?utf-8?B?Unk5QmNwaEk2aEhEM1VUZEpCQUEvRVRiMkY4WStVRkd2bGcwejQvVDEybS9p?=
 =?utf-8?Q?C/gAyMuiQsSzRA4Ju5FSIJuix?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a60e95a-c873-429f-ad93-08dc56c43a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 05:33:16.9930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfH7N8Bwfxw3s8ky6g2MAn/wudgcM927gf4Vbq0mzGU9RZmP13KIQtsB08e1Vfwo8DprKrqngyXVL5mneDgW5bNGQFe6BiQS9yC2k+Ma0+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5644
Received-SPF: pass client-ip=2a01:111:f403:2011::700;
 envelope-from=gavin.liu@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 07 Apr 2024 09:24:20 -0400
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

VGhhbmtzDQoNCi0tLS0tIE9yaWdpbmFsIE1lc3NhZ2UgLS0tLS0NCkZyb206IEphc29uIFdhbmcg
amFzb3dhbmdAcmVkaGF0LmNvbQ0KU2VudDogQXByaWwgNywgMjAyNCAxMTo0NiBBTQ0KVG86IEdh
dmluIExpdSBnYXZpbi5saXVAamFndWFybWljcm8uY29tDQpDYzogZXBlcmV6bWFAcmVkaGF0LmNv
bTsgc2dhcnphcmVAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IHFlbXUtc3RhYmxlQG5vbmdu
dS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsga3dvbGZAcmVkaGF0LmNvbQ0KU3ViamVjdDog
UmU6IFtQQVRDSF0gdmRwYS1kZXY6IEZpeCB0aGUgaXNzdWUgb2YgZGV2aWNlIHN0YXR1cyBub3Qg
dXBkYXRpbmcgd2hlbiBjb25maWd1cmF0aW9uIGludGVycnVwdGlvbiBpcyB0cmlnZ2VyZWQNCkV4
dGVybmFsIE1haWw6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIE9VVFNJREUgb2YgdGhlIG9y
Z2FuaXphdGlvbiENCkRvIG5vdCBjbGljayBsaW5rcywgb3BlbiBhdHRhY2htZW50cyBvciBwcm92
aWRlIEFOWSBpbmZvcm1hdGlvbiB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQoNCg0KT24gU3VuLCBBcHIgNywgMjAyNCBhdCAxMToy
MuKAr0FNIGx5eDYzNDQ0OTgwMCA8eXV4dWUubGl1QGphZ3Vhcm1pY3JvLmNvbT4gd3JvdGU6DQo+
DQo+IFRoZSBzZXRfY29uZmlnIGNhbGxiYWNrIGZ1bmN0aW9uIHZob3N0X3ZkcGFfZGV2aWNlX2dl
dF9jb25maWcgaW4gDQo+IHZkcGEtZGV2IGRvZXMgbm90IGZldGNoIHRoZSBjdXJyZW50IGRldmlj
ZSBzdGF0dXMgZnJvbSB0aGUgaGFyZHdhcmUgDQo+IGRldmljZSwgY2F1c2luZyB0aGUgR1VFU1Qg
T1MgdG8gbm90IHJlY2VpdmUgdGhlIGxhdGVzdCBkZXZpY2Ugc3RhdHVzDQoNCm5pdDogbm8gbmVl
ZCBmb3IgdXBwZXIgY2FzZSBoZXJlLg0KDQo+IGluZm9ybWF0aW9uLg0KPg0KPiBUaGUgaGFyZHdh
cmUgdXBkYXRlcyB0aGUgY29uZmlnIHN0YXR1cyBvZiB0aGUgdmRwYSBkZXZpY2UgYW5kIHRoZW4g
DQo+IG5vdGlmaWVzIHRoZSBPUy4gVGhlIEdVRVNUIE9TIHJlY2VpdmVzIGFuIGludGVycnVwdCBu
b3RpZmljYXRpb24sIA0KPiB0cmlnZ2VyaW5nIGEgZ2V0X2NvbmZpZyBhY2Nlc3MgaW4gdGhlIGtl
cm5lbCwgd2hpY2ggdGhlbiBlbnRlcnMgcWVtdSANCj4gaW50ZXJuYWxseS4gVWx0aW1hdGVseSwg
dGhlIHZob3N0X3ZkcGFfZGV2aWNlX2dldF9jb25maWcgZnVuY3Rpb24gb2YgDQo+IHZkcGEtZGV2
IGlzIGNhbGxlZA0KPg0KPiBPbmUgc2NlbmFyaW8gZW5jb3VudGVyZWQgaXMgd2hlbiB0aGUgZGV2
aWNlIG5lZWRzIHRvIGJyaW5nIGRvd24gdGhlIA0KPiB2ZHBhIG5ldCBkZXZpY2UuIEFmdGVyIG1v
ZGlmeWluZyB0aGUgc3RhdHVzIGZpZWxkIG9mIHZpcnRpb19uZXRfY29uZmlnIA0KPiBpbiB0aGUg
aGFyZHdhcmUsIGl0IHNlbmRzIGFuIGludGVycnVwdCBub3RpZmljYXRpb24uIEhvd2V2ZXIsIHRo
ZSANCj4gZ3Vlc3QgT1MgYWx3YXlzIHJlY2VpdmVzIHRoZSBTVEFUVVMgZmllbGQgYXMgVklSVElP
X05FVF9TX0xJTktfVVAuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IFl1eHVlIExpdSA8eXV4dWUubGl1
QGphZ3Vhcm1pY3JvLmNvbT4NCg0KVGhpcyBhbGlnbnMgd2l0aCB0aGUgdmhvc3QtbmV0IHN1cHBv
cnQgZm9yIHZEUEEuDQoNCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
Pg0KDQpUaGFua3MNCg0KPiAtLS0NCj4gIGh3L3ZpcnRpby92ZHBhLWRldi5jIHwgNyArKysrKysr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9o
dy92aXJ0aW8vdmRwYS1kZXYuYyBiL2h3L3ZpcnRpby92ZHBhLWRldi5jIGluZGV4IA0KPiAxM2U4
N2YwNmY2Li42NGI5NmIyMjZjIDEwMDY0NA0KPiAtLS0gYS9ody92aXJ0aW8vdmRwYS1kZXYuYw0K
PiArKysgYi9ody92aXJ0aW8vdmRwYS1kZXYuYw0KPiBAQCAtMTk1LDcgKzE5NSwxNCBAQCBzdGF0
aWMgdm9pZA0KPiAgdmhvc3RfdmRwYV9kZXZpY2VfZ2V0X2NvbmZpZyhWaXJ0SU9EZXZpY2UgKnZk
ZXYsIHVpbnQ4X3QgKmNvbmZpZykgIHsNCj4gICAgICBWaG9zdFZkcGFEZXZpY2UgKnMgPSBWSE9T
VF9WRFBBX0RFVklDRSh2ZGV2KTsNCj4gKyAgICBpbnQgcmV0Ow0KPg0KPiArICAgIHJldCA9IHZo
b3N0X2Rldl9nZXRfY29uZmlnKCZzLT5kZXYsIHMtPmNvbmZpZywgcy0+Y29uZmlnX3NpemUsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7DQo+ICsgICAgaWYgKHJldCA8IDAp
IHsNCj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJnZXQgZGV2aWNlIGNvbmZpZyBzcGFjZSBmYWls
ZWQiKTsNCj4gKyAgICAgICAgcmV0dXJuOw0KPiArICAgIH0NCj4gICAgICBtZW1jcHkoY29uZmln
LCBzLT5jb25maWcsIHMtPmNvbmZpZ19zaXplKTsNCj4gIH0NCj4NCj4gLS0NCj4gMi40My4wDQo+
DQoNCg==

