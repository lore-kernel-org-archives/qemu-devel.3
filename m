Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CB0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 10:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx2Aa-00067l-Pu; Wed, 17 Apr 2024 06:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1rx2AY-00067U-Fa; Wed, 17 Apr 2024 06:05:34 -0400
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Frederic.Konrad@amd.com>)
 id 1rx2AS-0000Up-2P; Wed, 17 Apr 2024 06:05:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJkpkI6SsLFQ7YzdcnNAPefqAdCCxqM4jwqFJTxEUlmNb6NNaWRt14mHsmII0oH5lfxu9t4fBPTR1fvUNRFDbJx2KOZaQJkDAEGtbhttCTlLNE55OdS3hAHKNnWrZr4JLgUWKSGHD6laa7QhX9qUQ+xuGLwaa5Zdj+NPT/0Kqk84QbkPNXpM2xX7Pf4ZNeCyNDdcOcBXVZJUfYOK5A+OTg5sjKcWu8Nlu2jVEqgVlcDUkXEQGiPWX8tKOLAINfELLfDTWN+fied+TDrmcDT/A0UYG8V6CAAohjvHxQuoKRMstcqRkgxVjvLCK31t28/np1ovOZq4H1KCm3Rv0B+FAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyY6LmOjawdAknZTNl6Cpf8/jm8c/JnuI+FHDcCXnOg=;
 b=iI+cWQxaYVbcj9RGrVSHWNIXqTrib+Om2ebC/jqiuptxfpSPnUmPWsUIV3KmzbmIsqBxrFsh+RJux30DgKy3187M5QWO1R6YMWK2wUQZQK0GHBD0alnvfOazcJveTM5jrCIxqDCv9dWoRGuDW/NKqIMyUpdkDZJHPVvNEthe846tAKCL+MAgdVgLYdk6u0UgTxTTQK34bPNe2r0ICg0F8VOY4kChwvPnlZRqjhf99SOUcUTjWoHWOBa38s8Fcx7vvIhqlvolBCZcrUPKm5iMGtNQoctJ/DKb/ahRu7e5CJbLmGtnTVloZb32Z8ROkQAn4X1X4sTRl3Efk92r5u9lEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyY6LmOjawdAknZTNl6Cpf8/jm8c/JnuI+FHDcCXnOg=;
 b=h6BajUf3xg5D3AVNgubbylVv5M3wl/+DQNbZZfyH7rGfhpVW8pL5zGmXyPtxN8+5DSsQN6h5Qk38HLm0db9GdGMNE94g0EPPRn0zz2uoywKdTegy1qROjBOkRSVouwRmM+bRLMSJqQOwoYePQeir0xS1jpwwOrfOA0PTe7XGGx4=
Received: from CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6)
 by LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 10:05:22 +0000
Received: from CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef]) by CY8PR12MB8411.namprd12.prod.outlook.com
 ([fe80::b636:ea75:6169:bcef%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 10:05:22 +0000
From: "Konrad, Frederic" <Frederic.Konrad@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>, Alexandra Diupina
 <adiupina@astralinux.ru>
CC: Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "sdl.qemu@linuxtesting.org"
 <sdl.qemu@linuxtesting.org>
Subject: RE: [PATCH RFC] prevent overflow in
 xlnx_dpdma_desc_get_source_address()
Thread-Topic: [PATCH RFC] prevent overflow in
 xlnx_dpdma_desc_get_source_address()
Thread-Index: AQHajLF1oJmPIDGPOkGnLE2+wkwuzLFkaOcAgAfZqrA=
Date: Wed, 17 Apr 2024 10:05:22 +0000
Message-ID: <CY8PR12MB8411CAB26257B5974DAE2CA2E60F2@CY8PR12MB8411.namprd12.prod.outlook.com>
References: <20240412081328.11183-1-adiupina@astralinux.ru>
 <CAFEAcA9wfzpc74iA_2G-YbtQtwGCA9VPQuXagg-Q0FwC92tg+w@mail.gmail.com>
In-Reply-To: <CAFEAcA9wfzpc74iA_2G-YbtQtwGCA9VPQuXagg-Q0FwC92tg+w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8411:EE_|LV8PR12MB9081:EE_
x-ms-office365-filtering-correlation-id: 2a7bc9ed-99d2-419b-d486-08dc5ec5e51e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryUWzbTDPVjMAlb9ZT+qnt4QFQGjL03+y0bR6gs5ErCvXgdzOCNfRGjUT1eK9egSJgDjI143G2aRypkjL97oYClvaYYfV1Fb+2k8hqIoN38c+N6VukKapyrLkPYd7rHGF1GfC2doW8FD0HY2GeXQNxAb7tKQofGXJe/o+48BJbduqM5W949XRM3olVkuFKkufC2ej5okpBXPG4x/+CDeLjXPmeBgpXNbDs7waKL2ILKW4Txo5f0gqSJHBWnu1ThRb2uhYold8i+MiCVn775xkGgz/TJ3rCi2TCif3XzFWdw1EEaCFQ148ZRvhA0nbmpIvGBvWETzzxo/3rVpGr6SfVtLWR0UbsNJtsih25nqpIMgwrKZOnpWvsvawNiIVEFAhw8fy7FHPTdLs3UDqcB8DOVBf/EkAEt6icaU0ucPb6loKtUKFPUYvK6hymnzh9SvVQxMfguOzBO8M/YMH002jaZeYgL6m3VkaFFRnOXvYMwPve/+8YS+QcOld6nBAIyne4UeX9I+Fz2X3uCoZqtHex4QtuOeG3ApRv75/C0Xeq4LUU54Zqga9HrSBQTmSWfePk0llohoznJxw4MAO5zQV6e8DW3JFVzqtGRXUosba2r5xMrWJg2Sz/UUSGXyeaH0VKwFAV9JysR7QTSvo7s3N3QiUjSoMFZqV2eu9JXP1f4bK7DtA1sEWQTOmAx++KTU4uHT55FcJ8wlE4jaJqIjrjhvwlOwiGIbSk2SF3zWLdo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEh6VHFTTUMvTDZvaExycnhNYkZ3bWpkb0IyNXVPc3JZRzVxZWx0MlNxU3pV?=
 =?utf-8?B?NnB4U2ttRWZQNURrc0Rtd0dVQnlCNFZ2cXlMWFMrQ2xrWkFiUUR0UTFjTUor?=
 =?utf-8?B?ekUvRFY3T2ZLWnVkUDErMXhzU0N4SzlIQWFPYzE0dWVmdjdPVlRrVDQ1bXpq?=
 =?utf-8?B?YzVYREV2eUtyR3NvRm9WODRSN1gwQzh1ZTVVZTMybStVeWNDVjZlUGtjZjMv?=
 =?utf-8?B?aWkvdWVxMGtCQ0xJL1hjWStkbFQ4RXFxMFR6VCtiL3JsbWo2cWRhWEdIUGdk?=
 =?utf-8?B?UE1YbE9rbEFyWnEwdC9uYlZ2c0pOcEFiOUJrZ2dTZE5tTXUvdHRnMEU2TDVk?=
 =?utf-8?B?eDV6T29nVzVjRGtzNFM2RU5UZlNXb0VLZ1JIcTk4MERDUDJvMVM3SktqWUdy?=
 =?utf-8?B?bllHeDk1dlhOdlJYSmFsQ2g5Um5oaE52ZXAvNjN2dWhkSzFxZlRxcjJMQUFO?=
 =?utf-8?B?SnhUTjczZWQ0QXY5aTI3WVBNWHluR3Q0SEI5N01MQTZoczRENXZxeWliVnlK?=
 =?utf-8?B?QU9nb0hacWZUbUMzK1pKYXNCbDRrVjljYWx2Nnp6NVFrZHZkVzlCa0ZlMzJm?=
 =?utf-8?B?NXlTd0QxSVpFN0dkc3pwMjdSaFF1aDhoYjBudkRCWlMxRjc2Wm9KRXpYakR3?=
 =?utf-8?B?OVdSaTBFbVEwczl2YWNSbTdiK1lUYWM0ZjhhM0ZRZ3N6M0x5TW14V1BCTHlS?=
 =?utf-8?B?S3pwcmtyc1lyUmNJQlhiSm1RZDFnSzRlWUdHMnFiMFRIcDliZjNrcEtydlhl?=
 =?utf-8?B?KzVUYUkySHE5S2NmUUJjYlQ3UktvbDBoZ0wzL2JXREhRVTVNSGFFdkM5N2tG?=
 =?utf-8?B?RnlreEZTRFpTZ1dpV3UwN1VPbCtTYlpEQnNycE9Db2doc21DRzMzT3AxMFF2?=
 =?utf-8?B?RW9odFlCYnh6KzA0VDlndkEzalJjZGhCSjVSbVUxclVRNnp6VmFpL05Ickov?=
 =?utf-8?B?clpkUjNTTE9OSGtqUFdabXg1WWxEYTVrb0dRZm5lTEM1WjhOWVNSUlptMXR4?=
 =?utf-8?B?OWgwU3ZzdEhscFdqMUJRQlAzRG93alNaUVRkK2RvWkxnUGNvNVVFMjRuYnpN?=
 =?utf-8?B?eVhzY3g5OTFldUt4bm9vTW9qdUpqVVN6c1l4K0phMHBjbGRIR3pXSlRQakJG?=
 =?utf-8?B?U0pmRU85VmhaeWNMUGZablp3UkMveDFQOGF6QktSTDc4bU5PakI2L2VZbFdJ?=
 =?utf-8?B?L3dMYUcvZDV0WitjRTRPQWFsdnlhRG50MTZwV2NYRkEyNElsY0VNSzRRUWsy?=
 =?utf-8?B?dUc4dmFVbm92YThLNyt5aDE4N0J2Y01IZ1BkMlFvWi9ibGwzeWsxaDdRN3hQ?=
 =?utf-8?B?bm43clhpQjZNcjNNZHJIamJNdDQ3ZjNJTWlianZqWDlncEN0UlNJUy9ET1hj?=
 =?utf-8?B?RHVSdUtFMzhKdGd4UTBPdEhHeUJMRnpkU0x4cHhNb1JUOEp0Mkt1eng2V3BV?=
 =?utf-8?B?UVBQOWNLKzJRVDFSeEY1bmdmbG50MEpvUnU2WEFNcGY5eVpyKzMvdWNLYlV2?=
 =?utf-8?B?eUZETEFURU81UEJEWThDTnBINUVodEJOWk5xbk9OM0hYSkFHOHlvdDY1NjU1?=
 =?utf-8?B?amRmb1FaYmhJeHY2cjJYVG0vNmlsbWVYYnR1TEVkMk9ZZnJMSWV0aWZORXNw?=
 =?utf-8?B?cng2RnNiR083Q243MkROZVpIaGpWRldFVndnb1ZQUkNJNzVZaVdNZ3R4MGl5?=
 =?utf-8?B?UmczMUhGZ2dmWS9GUi9QdkpOMXZQc3ZvWlM3TVdiTUJLN0pkazN1eSsvaUtC?=
 =?utf-8?B?cmFxYkdCQ2hlOWZpeXNDVVJGUzlQY0dSR1hIVUdTU1I3L2xnbit2ZE9tVnE4?=
 =?utf-8?B?QlgzdTJkYXFCTCtOckFzSElud1NyN2U1blVSV05LWHoxTXk3Q0laQWtWc014?=
 =?utf-8?B?R29NRE5MTSsycWc0VGlhMUI1ZWtYUVBJcUhRTE8xNS9vZ0QyWVVxZWJFWm1M?=
 =?utf-8?B?YjJwK2xUekJmL1VHV1hNazhHQkk4NUthRVJOUHNBTjV6dGpQUFErZ25XSkNS?=
 =?utf-8?B?RXVMUXBBVVdpR1JTM2g2OXNsa2dxc0t4VStSQS9rMHBRMElUVVRsWG9ZSmxh?=
 =?utf-8?B?WG1NcjEzWjV1TGNEUW9keCtjZXgyM3gxalQzOUFjTWpPVkhKV3JCNVFZVlBN?=
 =?utf-8?Q?WCR8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a7bc9ed-99d2-419b-d486-08dc5ec5e51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 10:05:22.5125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AqES0pPCDzmtr4x1UzlihQBnbRcYRXGSdJBAiFGct8ezTtoXEC9L4LqCKMAkxrdZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
Received-SPF: permerror client-ip=2a01:111:f403:2418::601;
 envelope-from=Frederic.Konrad@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogcWVtdS1kZXZlbC1i
b3VuY2VzK2Zrb25yYWQ9YW1kLmNvbUBub25nbnUub3JnIDxxZW11LWRldmVsLWJvdW5jZXMrZmtv
bnJhZD1hbWQuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFsZiBPZg0KPiBQZXRlciBNYXlkZWxsDQo+
IFNlbnQ6IEZyaWRheSwgQXByaWwgMTIsIDIwMjQgMTI6MDcgUE0NCj4gVG86IEFsZXhhbmRyYSBE
aXVwaW5hIDxhZGl1cGluYUBhc3RyYWxpbnV4LnJ1Pg0KPiBDYzogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXJAYWxpc3RhaXIyMy5tZT47IEVkZ2FyIEUuIElnbGVzaWFzIDxlZGdhci5pZ2xlc2lh
c0BnbWFpbC5jb20+OyBxZW11LWFybUBub25nbnUub3JnOyBxZW11LQ0KPiBkZXZlbEBub25nbnUu
b3JnOyBzZGwucWVtdUBsaW51eHRlc3Rpbmcub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZD
XSBwcmV2ZW50IG92ZXJmbG93IGluIHhsbnhfZHBkbWFfZGVzY19nZXRfc291cmNlX2FkZHJlc3Mo
KQ0KPiANCj4gT24gRnJpLCAxMiBBcHIgMjAyNCBhdCAwOToxMywgQWxleGFuZHJhIERpdXBpbmEg
PGFkaXVwaW5hQGFzdHJhbGludXgucnU+IHdyb3RlOg0KPiA+DQo+ID4gT3ZlcmZsb3cgY2FuIG9j
Y3VyIGluIGEgc2l0dWF0aW9uIHdoZXJlIGRlc2MtPnNvdXJjZV9hZGRyZXNzDQo+ID4gaGFzIGEg
bWF4aW11bSB2YWx1ZSAocG93KDIsIDMyKSAtIDEpLCBzbyBhZGQgYSBjYXN0IHRvIGENCj4gPiBs
YXJnZXIgdHlwZSBiZWZvcmUgdGhlIGFzc2lnbm1lbnQuDQo+ID4NCj4gPiBGb3VuZCBieSBMaW51
eCBWZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRlc3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPiA+
DQo+ID4gRml4ZXM6IGQzYzYzNjlhOTYgKCJpbnRyb2R1Y2UgeGxueC1kcGRtYSIpDQo+ID4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJhIERpdXBpbmEgPGFkaXVwaW5hQGFzdHJhbGludXgucnU+DQo+
ID4gLS0tDQo+ID4gIGh3L2RtYS94bG54X2RwZG1hLmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvZG1hL3hsbnhfZHBkbWEuYyBiL2h3L2RtYS94bG54
X2RwZG1hLmMNCj4gPiBpbmRleCAxZjVjZDY0ZWQxLi4yMjQyNTkyMjVjIDEwMDY0NA0KPiA+IC0t
LSBhL2h3L2RtYS94bG54X2RwZG1hLmMNCj4gPiArKysgYi9ody9kbWEveGxueF9kcGRtYS5jDQo+
ID4gQEAgLTE3NSwyNCArMTc1LDI0IEBAIHN0YXRpYyB1aW50NjRfdCB4bG54X2RwZG1hX2Rlc2Nf
Z2V0X3NvdXJjZV9hZGRyZXNzKERQRE1BRGVzY3JpcHRvciAqZGVzYywNCj4gPg0KPiA+ICAgICAg
c3dpdGNoIChmcmFnKSB7DQo+ID4gICAgICBjYXNlIDA6DQo+ID4gLSAgICAgICAgYWRkciA9IGRl
c2MtPnNvdXJjZV9hZGRyZXNzDQo+ID4gLSAgICAgICAgICAgICsgKGV4dHJhY3QzMihkZXNjLT5h
ZGRyZXNzX2V4dGVuc2lvbiwgMTYsIDEyKSA8PCAyMCk7DQo+ID4gKyAgICAgICAgYWRkciA9ICh1
aW50NjRfdCkoZGVzYy0+c291cmNlX2FkZHJlc3MNCj4gPiArICAgICAgICAgICAgKyAoZXh0cmFj
dDMyKGRlc2MtPmFkZHJlc3NfZXh0ZW5zaW9uLCAxNiwgMTIpIDw8IDIwKSk7DQo+IA0KPiBVbmxl
c3MgSSdtIGNvbmZ1c2VkLCB0aGlzIGNhc3QgZG9lc24ndCBoZWxwLCBiZWNhdXNlIHdlDQo+IHdp
bGwgaGF2ZSBhbHJlYWR5IGRvbmUgYSAzMi1iaXQgYWRkaXRpb24gb2YgZGVzYy0+c291cmNlX2Fk
ZHJlc3MNCj4gYW5kIHRoZSB2YWx1ZSBmcm9tIHRoZSBhZGRyZXNzX2V4dGVuc2lvbiBwYXJ0LCBz
byBpdCBkb2Vzbid0DQo+IGNoYW5nZSB0aGUgcmVzdWx0Lg0KPiANCj4gSWYgd2Ugd2FudCB0byBk
byB0aGUgYWRkaXRpb24gYXQgNjQgYml0cyB0aGVuIHVzaW5nIGV4dHJhY3Q2NCgpDQo+IHdvdWxk
IGJlIHRoZSBzaW1wbGVzdCB3YXkgdG8gYXJyYW5nZSBmb3IgdGhhdC4NCj4gDQo+IEhvd2V2ZXIs
IEkgY2FuJ3QgZmlndXJlIG91dCB3aGF0IHRoaXMgY29kZSBpcyB0cnlpbmcgdG8gZG8gYW5kDQo+
IG1ha2UgdGhhdCBsaW5lIHVwIHdpdGggdGhlIGRhdGEgc2hlZXQ7IG1heWJlIHRoaXMgaXNuJ3Qg
dGhlDQo+IHJpZ2h0IGRhdGFzaGVldCBmb3IgdGhpcyBkZXZpY2U/DQo+IA0KPiBodHRwczovL2Rv
Y3MuYW1kLmNvbS9yL2VuLVVTL3VnMTA4NS16eW5xLXVsdHJhc2NhbGUtdHJtL0FERFJfRVhULUZp
ZWxkDQo+IA0KPiBUaGUgZGF0YXNoZWV0IHN1Z2dlc3RzIHRoYXQgd2Ugc2hvdWxkIHRha2UgMzIg
Yml0cyBvZiB0aGUgYWRkcmVzcw0KPiBmcm9tIG9uZSBmaWVsZCAoaGVyZSBkZXNjLT5zb3VyY2Vf
YWRkcmVzcykgYW5kIDE2IGJpdHMgb2YgdGhlDQo+IGFkZHJlc3MgZnJvbSBhbm90aGVyIChoZXJl
IGRlc2MtPmFkZHJlc3NfZXh0ZW5zaW9uJ3MgaGlnaCBiaXRzKQ0KPiBhbmQgY29tYmluZSB0aGVt
IHRvIG1ha2UgYSA0OCBiaXQgYWRkcmVzcy4gQnV0IHRoaXMgY29kZSBpcyBvbmx5DQo+IGxvb2tp
bmcgYXQgMTIgYml0cyBvZiB0aGUgaGlnaCAxNiBpbiBhZGRyZXNzX2V4dGVuc2lvbiwgYW5kIGl0
DQo+IGRvZXNuJ3Qgc2hpZnQgdGhlbSByaWdodCBlbm91Z2ggdG8gcHV0IHRoZW0gaW50byBiaXRz
IFs0NzozMl0NCj4gb2YgdGhlIGZpbmFsIGFkZHJlc3MuDQo+IA0KPiBYaWxpbnggZm9sa3M6IHdo
YXQgaGFyZHdhcmUgaXMgdGhpcyBtb2RlbGxpbmcsIGFuZCBpcyBpdA0KPiByZWFsbHkgdGhlIHJp
Z2h0IGJlaGF2aW91cj8NCg0KTG9va3MgbGlrZSB0aGlzIGlzIHRoZSByaWdodCBkb2N1bWVudGF0
aW9uLiAgTW9zdCBwcm9iYWJseSB0aGUgZGVzY3JpcHRvciBmaWVsZCBjaGFuZ2VkDQpzaW5jZSBJ
IGRpZCB0aGF0IG1vZGVsLCBvciBJIGdvdCByZWFsbHkgY29uZnVzZWQuDQoNCj4gDQo+IEFsc28s
IHRoaXMgZGV2aWNlIGxvb2tzIGxpa2UgaXQgaGFzIGEgaG9zdC1lbmRpYW5uZXNzIGJ1ZzogdGhl
DQo+IERQRE1BRGVzY3JpcHRvciBzdHJ1Y3QgaXMgcmVhZCBkaXJlY3RseSBmcm9tIGd1ZXN0IG1l
bW9yeSBpbg0KPiBkbWFfbWVtb3J5X3JlYWQoKSwgYnV0IHRoZSBkZXZpY2UgbmV2ZXIgZG9lcyBh
bnl0aGluZyB0byBzd2FwDQo+IHRoZSBmaWVsZHMgZnJvbSBndWVzdCBtZW1vcnkgb3JkZXIgdG8g
aG9zdCBtZW1vcnkgb3JkZXIuIFNvDQo+IHRoaXMgaXMgbGlrZWx5IGJyb2tlbiBvbiBiaWctZW5k
aWFuIGhvc3RzLg0KPiANCg0KWWVzIGluZGVlZC4NCg0KQmVzdCBSZWdhcmRzLA0KRnJlZA0KDQo+
IHRoYW5rcw0KPiAtLSBQTU0NCg0K

