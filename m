Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DB0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 03:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwvip-0006Hu-AE; Tue, 16 Apr 2024 23:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwvin-0006HP-EW
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 23:12:29 -0400
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rwvik-0004a7-NP
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 23:12:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddCGcZR8lHDyisqnykWmzVck3PJS/g46DPnZZYRbm87YUu5erqm6ymonIqj20VLNNAWw+vZIdF9GWgMDVGvk7Pt03taVfhlhCd5H1kjFW+WnBhvSgI+EFKVoHhT9r6YG/4GIjVXWDxfByVbXWjohILIDqlA0RJ8u52Y2QQyItn5KYOcmR7ZcdIQshIjv/VHZMlWQOwVTmu4ouIqsKPADdL6YfEvE4OrxPMebknnsLHWszQ6O6wo0ZS5upf/TPzQxDYV3u0s1hvNkPOS95C0h8s/81cwfuPpJsH0qPAPJ3FopULPHmpWRuDq8aT920MkAtzr9RjeZFKZRs5gmaVXn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Udm0ZU72JiKawgWBICCrtICrP06UJGin0g6FQekFLsE=;
 b=XJwc906hfW4hZ0BCRYR/0u86Sjw94wp+Q17pTQ7Im5alLjUOIWs+4A14iEGHlEfj6GDhbS4XBrnrnfyBHOh5FhnzeRrQEkZoF8nUIMtepbJrmckZ7sfz+B1WAzT8d12JOosdENp+gqde+adTxf7zr0uRv89au3w6Jw0/io7XFTjWBxmBh5h7ep8mwg8b74THDIssr1jzfUTZXssg5anjK8YEuUULbl9JFu5SquU5Owq0J0ZSweAx3cJAVtvQ6uy3Dtj/rOVFtD2onTVLH97coFB2ENvx3MSs5weXC3BiMi9QEfvcuOoHOKcVwfZh7mitcZazEPshHksbL73ndfYt4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udm0ZU72JiKawgWBICCrtICrP06UJGin0g6FQekFLsE=;
 b=nZxsvMLi4etnD2wEXY8HoGYNnr1IqoT/w70K6egwRbykrcrxvxHhRIj6CkFFoobitldC2eFbvVV9mQjhOX5RO/oZ2N3LetwcQxuAbP+NZLSzjgMy7r9RBpHLfkHLdM8XUENhLTXIySa8PZRyfvdySfjNcQLRbK4pDJwfTjhqcDI=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 03:12:19 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::b77f:9333:3a5a:d285%6]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:12:19 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v9 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v9 2/2] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHaj8v0vhbSJoQeWk+O1EoAWaQkZLFrCqGAgAE6pwA=
Date: Wed, 17 Apr 2024 03:12:19 +0000
Message-ID: <BL1PR12MB5849B0755AE7DFD07A9B253FE70F2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240416070127.116922-1-Jiqian.Chen@amd.com>
 <20240416070127.116922-3-Jiqian.Chen@amd.com>
 <20240416174531.6573af25@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240416174531.6573af25@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL3PR12MB6428.namprd12.prod.outlook.com
 (15.20.7495.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|MN2PR12MB4078:EE_
x-ms-office365-filtering-correlation-id: fd7f3094-bc74-42d1-3752-08dc5e8c317a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qc78Ok6XEa8jAJuAm2lUK/rBb+DIVLc0NMZW5MkE98MB6P4cTRQ678o1MkEbKdPK4dtcERI0nbbEo0Dr5XWnupdzRFM++7ee+JZUVI1f6yRt4P1hFbkjB7fup6V5oCrKXlDBX5aoG7BIU5NyVPoJBpITpFD+PQi9B2ufL0340aWObiGQZ8VSqioqQjM5V0jJRI/O4lFMHBcn0efO0Ey1e7MQpsZkiKvJXZ745MsGGHwINEv9GFpZe7uRu5L+hczm9ZWcaVAZrdAxhoLrFYMsuTFTqZH6ITc5Y1tq+8KHps2IaK+OHG5A0AMP5VEtS9jGfv80wrqzmIVy1kfw1lCzG1eHDYSM84JLCl92XDi6bh8UvAJ2APOF4cj8yeNFqdun+PUqfANWMD9xJvLEj08s+ej39eLRlM4H0lKwUaOhqUJgxJWVECbymx3PW3G1+4YL7oygQRbwCNpxh1YWFN/P9S6UHh3DvaVlicyVNUqO78AfpfwcXIdRhma13Civ1BgVoD9oGagPC0lt8PoUyD37HGNKRlSYn8osQ2GyZSMOSa40MjEtHBIWnqNC8MZ2kN1AGbe9gvE/1h6Oy+X3+QfEsECRk9GUN2rKbr8SnrKXRAPQQ6mAEOI5sEMK+XRjzv0M4Msnzs5VHPG3DkBLpkgcjWfxWnD4dlSDWv6hROutr4hhBBRHU/cQQbj3zZ9kf7hZkSdu4t8Ejd5alNvPebpRBCrLAMBjaj15m5nHrkF90A8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmNGL09TZ0dkSVloYWh0TU1SY3ZyVVQvZlNGWi9HUTE3K0lpU0swTWJTSmg4?=
 =?utf-8?B?cElWcDFndktERjVFNzhpd1g5eUtWUCtjLzRyQmxMOEVpYS9acWxkVUhpSVBt?=
 =?utf-8?B?MGl2Vm9JZnJ2WStmVWhQM1dhQnQvVHdMb2NPYWlEejdOVzFheEd4YUt2Vysy?=
 =?utf-8?B?ajR0S2JPWXR5TFNSMlh3VU5UZG1sMFBvVFJhanhVSmlscGJBd1gxRzUralZB?=
 =?utf-8?B?WkhFc3owVmh6OUE2WExyaTQ1K2JGMFliVDNlNFYxWHlZd3hLR3VtVEhUM1hO?=
 =?utf-8?B?ako1M1JsOTlNaG9LZGhyWTFiWkdOd2VVbmVQcURZbDY0bW5scmNBYkxBRWF6?=
 =?utf-8?B?SUswUm45VHYzalNIR01icHAyTDFnWUdldDVEVlJ3dVVzUWxSRHN6RUVKS2Yy?=
 =?utf-8?B?c2NQZUFnZzNaUk1TdkNLN3VVVjJsMlpNUkdOb1YxNmoxN0ZaK3BiRkpxbFpQ?=
 =?utf-8?B?R3Bmb3RFQm5HT2xmV21hbW9TZUEyK0dZUVNzSG5Kc0lqVEFabHZhaTZVZmNj?=
 =?utf-8?B?VkVweEtQZkZnOUVTQ29KZnVBSjNTRWtFOStaSlVpb1dFeHV4dVZjWW1GS0dN?=
 =?utf-8?B?QkcwME9vYng0cGl6NVJJVDFkRUxRYS9XTHNKQy9kTFN0SmNWTEFsOUhzYlpj?=
 =?utf-8?B?cTJyVktlb2lWMXRKTmIzN3NRb0I4SkJBdC9UaGxoZ2grcnhlNjdzRkowbTlh?=
 =?utf-8?B?MjRJSEZHK2lweTFyaGd6M1JPcTcralFlZjJyWHRGUXRVcTB3UFl5QVFPNHJq?=
 =?utf-8?B?MmJHL01JUGYxQUI2ZXBQdnZCUklqMHZmZlQvKzlvUTV3Mk8yRTdORUxaMWlB?=
 =?utf-8?B?Zi9yUGFJQXNtY250eklXdDMzcE41SkMwUUJza3FoQjF1MWo5UmhEM3FGRXk3?=
 =?utf-8?B?ZG9rV3NzUHExbWcrVjFkYktZUVRUOUFGSVNyQ2ZTcXFoNWdmL2pITThaKzVh?=
 =?utf-8?B?Y3JWZi92NFJlSW1VbGtYeDZINllndFpvM3ZXYS9DKzRlVy81WjNrUGdzcjQ5?=
 =?utf-8?B?KzE2aEFDM3hxV012QmlsWlBaQkdTS1NPdlBKQ0JiMlpQOStjNGEvSGYweVN5?=
 =?utf-8?B?T25uamhxbDlzclpSS3E3NFZDRFNQK3puUDJiZy82QVpHbGc2ZHdXQXJWcEZW?=
 =?utf-8?B?ZUMwNzEvdmJ5TWdOQjVYWXVPRXJiRHpVR0J4RW5nSS9mVXB4eHdMemRKSGZw?=
 =?utf-8?B?NGJGZlRLN1k5cDhRK0RMdnpZV0V3dDZJVjRyalIzSTBqSkMxQjNGalRJSmVa?=
 =?utf-8?B?dUpLWTFXZDVLTXlmams0L0huOXpMZTVKa0U3bG9KS2k2YWNOL2FzeFZpTlho?=
 =?utf-8?B?UE1Ka3hvaHExTlFLSlB5ZkUycUZvWG8xUkY2M1JCbE10bFU0aXc5cjVjL0pV?=
 =?utf-8?B?ZTFJak9tK09XaVI4a0tDQXBTcE56eklvWTZJKytTMmY0VGt1MWhZeFVpQUNV?=
 =?utf-8?B?UnQ2Vkh0Zkx5bVA4ajBiWW10bUxWdThZU25iRm9rOUZhZDkvcDJqYUpHZ3BY?=
 =?utf-8?B?QjdKandHQmpEbXRUbWUzYndlNGNCdEcwQ0tYOEVDcnBXT0xiWjNjS0ZGMHFN?=
 =?utf-8?B?RGFPNCs2K1NJclFJeTBGZ0I4MHNCejdLSmI2Y05nSHN0R1VicWs4akptREcv?=
 =?utf-8?B?TVpGZ3N0YUNBakg4eVBtN2grbTdLMk1lRHU4OTBIaHg2TGNhWEk1M3pabjh3?=
 =?utf-8?B?VndIcTdCcVgzNUtrNnJGUmx1UWVzY2VMQ25FMzVLcHdBRFY2RVQyUElHQXpp?=
 =?utf-8?B?bjFueGN2Q0puT2QvWlNWeHJMVU8rMXIwS2FnaTB6dlRjeWhZbFRZb3drQVpS?=
 =?utf-8?B?U1c0VkoyWGpNWUJNeVBPZGVrd0RTY1NJR2R5SExlQXphK3hFV3EzaS9Ta3px?=
 =?utf-8?B?TUNJQWlOeUE3RlZFV2sxZmY0aXlEaWZJa3Q2MEJGUkdwYVVLenprMllsSVBa?=
 =?utf-8?B?TlQyWG1ZaGdqTFFBMWF0N3NPL01wcTRTTmZaUnlCc1JMUE1KZUNoQmNOd2Uz?=
 =?utf-8?B?V3hPZWtPbFNoOXU2U2p2R0dVSzZjZXF2Lzl0U0tBM2s4YkFHRU9LOUJRaEsv?=
 =?utf-8?B?QjhrdVVjMjM3ZmFsK3V6SDFHVHpnZmdXZG9GZmRYQTRxOW51UVgvYm4vRGJm?=
 =?utf-8?Q?URBI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09D9AF10D91164479D19847C88923A1C@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7f3094-bc74-42d1-3752-08dc5e8c317a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 03:12:19.8240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPNzI1R9DgtoWfKUbWjZYy89B3KEVJ3YsSVskO7qH75fQfoJSqsOJmmdFhQ+T6dZe85NcMZRLJ9ko/BVeAu6sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078
Received-SPF: permerror client-ip=2a01:111:f403:2009::600;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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

T24gMjAyNC80LzE2IDIzOjQ1LCBJZ29yIE1hbW1lZG92IHdyb3RlOg0KPiBPbiBUdWUsIDE2IEFw
ciAyMDI0IDE1OjAxOjI3ICswODAwDQo+IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29t
PiB3cm90ZToNCj4gDQo+PiBJbiBjdXJyZW50IGNvZGUsIHdoZW4gZ3Vlc3QgZG9lcyBTMywgdmly
dGlvLWdwdSBhcmUgcmVzZXQgZHVlIHRvIHRoZQ0KPj4gYml0IE5vX1NvZnRfUmVzZXQgaXMgbm90
IHNldC4gQWZ0ZXIgcmVzZXR0aW5nLCB0aGUgZGlzcGxheSByZXNvdXJjZXMNCj4+IG9mIHZpcnRp
by1ncHUgYXJlIGRlc3Ryb3llZCwgdGhlbiB0aGUgZGlzcGxheSBjYW4ndCBjb21lIGJhY2sgYW5k
IG9ubHkNCj4+IHNob3cgYmxhbmsgYWZ0ZXIgcmVzdW1pbmcuDQo+IA0KPiBKdXN0IGEgaGlnaCBs
ZXZlbCBxdWVzdGlvbi4NCj4gVHlwaWNhbGx5IHdoZW4gc3lzdGVtIGdvZXMgaW50byBTMyBhbGwg
ZGV2aWNlcyAobW9kdWxvIFJBTSkgbG9vc2UgY29udGV4dA0KPiAoYWthIHBvd2VyZWQgb2ZmKSwg
YW5kIHRoZW4gaXQncyB1cHRvIGRldmljZSBkcml2ZXIgdG8gcmVjb3ZlciB3aGF0ZXZlcg0KPiB3
YXMgbG9zdC4NCk5vLCB3aGF0IHlvdSBzYWlkIGlzIGp1c3Qgb25lIHNpdHVhdGlvbiB0aGF0IHdo
ZW4gc3lzdGVtIGdvZXMgaW50byBTMyBkZXZpY2VzIGxvb3NlIGNvbnRleHQgYW5kIGZ1bGx5IHJl
aW5pdGlhbGl6ZWQgYW5kIGJlIEQwLXVuaW5pdGlhbGl6ZWQgc3RhdGUuDQpUaGUgb3RoZXIgc2l0
dWF0aW9uIGlzIHRoZSBjb250ZXh0IG11c3QgYmUgbWFpbnRhaW5lZCBzbyB0aGF0IHRoZSBkZXZp
Y2VzIGNhbiBxdWlja2x5IGJlIEQwLWFjdGl2ZSBzdGF0ZSBhZnRlciByZXN1bWluZy4NClRoZXJl
IGFyZSBzb21lIGRlc2NyaXB0aW9ucyBpbiBQQ0llIHNwZWNpZmljYXRpb24gaW4gQ2hhcHRlciA1
LjMuMS40IEQzIHN0YXRlOg0KIiBGdW5jdGlvbmFsIGNvbnRleHQgaXMgcmVxdWlyZWQgdG8gYmUg
bWFpbnRhaW5lZCBieSBGdW5jdGlvbnMgaW4gdGhlIEQzSG90IHN0YXRlIGlmIHRoZSBOb19Tb2Z0
X1Jlc2V0IGZpZWxkIGluIHRoZSBQTUNTUiBpcw0KU2V0LiBJbiB0aGlzIGNhc2UsIFN5c3RlbSBT
b2Z0d2FyZSBpcyBub3QgcmVxdWlyZWQgdG8gcmUtaW5pdGlhbGl6ZSB0aGUgRnVuY3Rpb24gYWZ0
ZXIgYSB0cmFuc2l0aW9uIGZyb20gRDNIb3QgdG8gRDAgKHRoZQ0KRnVuY3Rpb24gd2lsbCBiZSBp
biB0aGUgRDBhY3RpdmUgc3RhdGUpLiBJZiB0aGUgTm9fU29mdF9SZXNldCBiaXQgaXMgQ2xlYXIs
IGZ1bmN0aW9uYWwgY29udGV4dCBpcyBub3QgcmVxdWlyZWQgdG8gYmUNCm1haW50YWluZWQgYnkg
dGhlIEZ1bmN0aW9uIGluIHRoZSBEM0hvdCBzdGF0ZSwgaG93ZXZlciBpdCBpcyBub3QgZ3VhcmFu
dGVlZCB0aGF0IGZ1bmN0aW9uYWwgY29udGV4dCB3aWxsIGJlIGNsZWFyZWQgYW5kDQpzb2Z0d2Fy
ZSBtdXN0IG5vdCBkZXBlbmQgb24gc3VjaCBiZWhhdmlvci4gQXMgYSByZXN1bHQsIGluIHRoaXMg
Y2FzZSBTeXN0ZW0gU29mdHdhcmUgaXMgcmVxdWlyZWQgdG8gZnVsbHkgcmUtaW5pdGlhbGl6ZSB0
aGUNCkZ1bmN0aW9uIGFmdGVyIGEgdHJhbnNpdGlvbiB0byBEMCBhcyB0aGUgRnVuY3Rpb24gd2ls
bCBiZSBpbiB0aGUgRDB1bmluaXRpYWxpemVkIHN0YXRlLiINCg0KV2hhdCdzIG1vcmUsIG5vdCBh
bGwgdmlydGlvIGRldmljZXMnIGNvbnRleHQgY2FuIGJlIHJlY292ZXJlZCBieSBkcml2ZXIgYWZ0
ZXIgcmVzdW1pbmcsIGxpa2UgdmlydGlvLWdwdSwgd2UgaGF2ZSBub3QgZW5vdWdoIGluZm9ybWF0
aW9uIHRvIHJlLWNyZWF0ZSBhbGwNCmRpc3BsYXkgcmVzb3VyY2VzLCB0aGF0IGlzIGRpc2N1c3Nl
ZCBpbiBteSBwcmV2aW91cyB2ZXJzaW9uIGVtYWlsIHRocmVhZC4NCg0KPiBTbyB3aHkgc2hvdWxk
IHdlIGltcGxlbWVudCBodyhxZW11KSB3b3JrYXJvdW5kIGZvciBhIGRyaXZlciBwcm9ibGVtPw0K
SSB0aGluayB0aGlzIGlzIG5vdCBhIHdvcmthcm91bmQsIE5vX1NvZnRfUmVzZXQgYml0IGlzIGFs
c28gZGVzY3JpYmVkIGluIFBDSWUgc3BlY2lmaWNhdGlvbiwgaXQgY2FuIGJlIHNldCBvciBub3Qu
DQpBbmQgd2UgY2FuIHNldCB0aGlzIGJpdCBmb3IgdGhlIHNwZWNpZmljIGRldmljZSB3aGljaCB3
ZSB3YW50IHRvIG1haW50YWluIGNvbnRleHQgZHVyaW5nIFMzLg0KDQo+IA0KPj4NCj4+IEltcGxl
bWVudCBOb19Tb2Z0X1Jlc2V0IGJpdCBvZiBQQ0lfUE1fQ1RSTCByZWdpc3RlciwgdGhlbiBndWVz
dCBjYW4gY2hlY2sNCj4+IHRoaXMgYml0LCBpZiB0aGlzIGJpdCBpcyBzZXQsIHRoZSBkZXZpY2Vz
IHJlc2V0dGluZyB3aWxsIG5vdCBiZSBkb25lLCBhbmQNCj4+IHRoZW4gdGhlIGRpc3BsYXkgY2Fu
IHdvcmsgYWZ0ZXIgcmVzdW1pbmcuDQo+Pg0KPj4gTm9fU29mdF9SZXNldCBiaXQgaXMgaW1wbGVt
ZW50ZWQgZm9yIGFsbCB2aXJ0aW8gZGV2aWNlcywgYW5kIHdhcyB0ZXN0ZWQNCj4+IG9ubHkgb24g
dmlydGlvLWdwdSBkZXZpY2UuIFNldCBpdCBmYWxzZSBieSBkZWZhdWx0IGZvciBzYWZldHkuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+
PiAtLS0NCj4+ICBody92aXJ0aW8vdmlydGlvLXBjaS5jICAgICAgICAgfCAzNyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBj
aS5oIHwgIDUgKysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYyBiL2h3L3ZpcnRpby92aXJ0
aW8tcGNpLmMNCj4+IGluZGV4IGExYjYxMzA4ZTdhMC4uODJmYTRkZWZlNWNkIDEwMDY0NA0KPj4g
LS0tIGEvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPj4gKysrIGIvaHcvdmlydGlvL3ZpcnRpby1w
Y2kuYw0KPj4gQEAgLTIyMzAsNiArMjIzMCwxMSBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fcGNpX3Jl
YWxpemUoUENJRGV2aWNlICpwY2lfZGV2LCBFcnJvciAqKmVycnApDQo+PiAgICAgICAgICAgICAg
cGNpZV9jYXBfbG5rY3RsX2luaXQocGNpX2Rldik7DQo+PiAgICAgICAgICB9DQo+PiAgDQo+PiAr
ICAgICAgICBpZiAocHJveHktPmZsYWdzICYgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVT
RVQpIHsNCj4+ICsgICAgICAgICAgICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+Y29uZmlnICsgcG9z
ICsgUENJX1BNX0NUUkwsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgIFBDSV9QTV9DVFJM
X05PX1NPRlRfUkVTRVQpOw0KPj4gKyAgICAgICAgfQ0KPj4gKw0KPj4gICAgICAgICAgaWYgKHBy
b3h5LT5mbGFncyAmIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNKSB7DQo+PiAgICAgICAgICAgICAg
LyogSW5pdCBQb3dlciBNYW5hZ2VtZW50IENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4+ICAgICAgICAg
ICAgICBwY2lfc2V0X3dvcmQocGNpX2Rldi0+d21hc2sgKyBwb3MgKyBQQ0lfUE1fQ1RSTCwNCj4+
IEBAIC0yMjkyLDExICsyMjk3LDM3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfcmVzZXQoRGV2
aWNlU3RhdGUgKnFkZXYpDQo+PiAgICAgIH0NCj4+ICB9DQo+PiAgDQo+PiArc3RhdGljIGJvb2wg
dmlydGlvX3BjaV9ub19zb2Z0X3Jlc2V0KFBDSURldmljZSAqZGV2KQ0KPj4gK3sNCj4+ICsgICAg
dWludDE2X3QgcG1jc3I7DQo+PiArDQo+PiArICAgIGlmICghcGNpX2lzX2V4cHJlc3MoZGV2KSB8
fCAhZGV2LT5leHAucG1fY2FwKSB7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAg
IH0NCj4+ICsNCj4+ICsgICAgcG1jc3IgPSBwY2lfZ2V0X3dvcmQoZGV2LT5jb25maWcgKyBkZXYt
PmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCk7DQo+PiArDQo+PiArICAgIC8qDQo+PiArICAgICAq
IFdoZW4gTm9fU29mdF9SZXNldCBiaXQgaXMgc2V0IGFuZCB0aGUgZGV2aWNlDQo+PiArICAgICAq
IGlzIGluIEQzaG90IHN0YXRlLCBkb24ndCByZXNldCBkZXZpY2UNCj4+ICsgICAgICovDQo+PiAr
ICAgIHJldHVybiAocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSAmJg0KPj4gKyAg
ICAgICAgICAgKHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSykgPT0gMzsNCj4+ICt9DQo+
PiArDQo+PiAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9idXNfcmVzZXRfaG9sZChPYmplY3QgKm9i
aikNCj4+ICB7DQo+PiAgICAgIFBDSURldmljZSAqZGV2ID0gUENJX0RFVklDRShvYmopOw0KPj4g
ICAgICBEZXZpY2VTdGF0ZSAqcWRldiA9IERFVklDRShvYmopOw0KPj4gIA0KPj4gKyAgICAvKg0K
Pj4gKyAgICAgKiBOb3RlIHRoYXQ6IGEgcHJvcG9zYWwgdG8gYWRkIFNVU1BFTkQgYml0IGlzIGJl
aW5nIGRpc2N1c3NlZCwNCj4+ICsgICAgICogbWF5IG5lZWQgdG8gY29uc2lkZXIgdGhlIHN0YXRl
IG9mIFNVU1BFTkQgYml0IGluIGZ1dHVyZQ0KPj4gKyAgICAgKi8NCj4+ICsgICAgaWYgKHZpcnRp
b19wY2lfbm9fc29mdF9yZXNldChkZXYpKSB7DQo+PiArICAgICAgICByZXR1cm47DQo+PiArICAg
IH0NCj4+ICsNCj4+ICAgICAgdmlydGlvX3BjaV9yZXNldChxZGV2KTsNCj4+ICANCj4+ICAgICAg
aWYgKHBjaV9pc19leHByZXNzKGRldikpIHsNCj4+IEBAIC0yMzM2LDYgKzIzNjcsMTIgQEAgc3Rh
dGljIFByb3BlcnR5IHZpcnRpb19wY2lfcHJvcGVydGllc1tdID0gew0KPj4gICAgICAgICAgICAg
ICAgICAgICAgVklSVElPX1BDSV9GTEFHX0lOSVRfTE5LQ1RMX0JJVCwgdHJ1ZSksDQo+PiAgICAg
IERFRklORV9QUk9QX0JJVCgieC1wY2llLXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3Ms
DQo+PiAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQsIHRy
dWUpLA0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBmb3Igc2FmZXR5LCBzZXQgdGhpcyBmYWxzZSBi
eSBkZWZhdWx0LCBpZiBjaGFuZ2UgaXQgdG8gdHJ1ZSwNCj4+ICsgICAgICogbmVlZCB0byBjb25z
aWRlciBjb21wYXRpYmxlIGZvciBvbGQgbWFjaGluZQ0KPj4gKyAgICAgKi8NCj4+ICsgICAgREVG
SU5FX1BST1BfQklUKCJwY2llLXBtLW5vLXNvZnQtcmVzZXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxh
Z3MsDQo+PiArICAgICAgICAgICAgICAgICAgICBWSVJUSU9fUENJX0ZMQUdfUE1fTk9fU09GVF9S
RVNFVF9CSVQsIGZhbHNlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtZmxyLWlu
aXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICBWSVJU
SU9fUENJX0ZMQUdfSU5JVF9GTFJfQklULCB0cnVlKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQklU
KCJhZXIiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy92aXJ0aW8vdmlydGlvLXBjaS5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oDQo+
PiBpbmRleCA1OWQ4ODAxOGMxNmEuLjllNjdiYTM4Yzc0OCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby1wY2kuaA0KPj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmly
dGlvLXBjaS5oDQo+PiBAQCAtNDMsNiArNDMsNyBAQCBlbnVtIHsNCj4+ICAgICAgVklSVElPX1BD
SV9GTEFHX0lOSVRfRkxSX0JJVCwNCj4+ICAgICAgVklSVElPX1BDSV9GTEFHX0FFUl9CSVQsDQo+
PiAgICAgIFZJUlRJT19QQ0lfRkxBR19BVFNfUEFHRV9BTElHTkVEX0JJVCwNCj4+ICsgICAgVklS
VElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklULA0KPj4gIH07DQo+PiAgDQo+PiAgLyog
TmVlZCB0byBhY3RpdmF0ZSB3b3JrLWFyb3VuZHMgZm9yIGJ1Z2d5IGd1ZXN0cyBhdCB2bXN0YXRl
IGxvYWQuICovDQo+PiBAQCAtNzksNiArODAsMTAgQEAgZW51bSB7DQo+PiAgLyogSW5pdCBQb3dl
ciBNYW5hZ2VtZW50ICovDQo+PiAgI2RlZmluZSBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTSAoMSA8
PCBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTV9CSVQpDQo+PiAgDQo+PiArLyogSW5pdCBUaGUgTm9f
U29mdF9SZXNldCBiaXQgb2YgUG93ZXIgTWFuYWdlbWVudCAqLw0KPj4gKyNkZWZpbmUgVklSVElP
X1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVQgXA0KPj4gKyAgKDEgPDwgVklSVElPX1BDSV9GTEFH
X1BNX05PX1NPRlRfUkVTRVRfQklUKQ0KPj4gKw0KPj4gIC8qIEluaXQgRnVuY3Rpb24gTGV2ZWwg
UmVzZXQgY2FwYWJpbGl0eSAqLw0KPj4gICNkZWZpbmUgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxS
ICgxIDw8IFZJUlRJT19QQ0lfRkxBR19JTklUX0ZMUl9CSVQpDQo+PiAgDQo+IA0KDQotLSANCkJl
c3QgcmVnYXJkcywNCkppcWlhbiBDaGVuLg0K

