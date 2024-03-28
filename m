Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D530FC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpkAK-0000Sp-Og; Thu, 28 Mar 2024 03:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpkAI-0000Rm-No
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:27:10 -0400
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2418::601]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Jiqian.Chen@amd.com>)
 id 1rpkAG-0005h7-9B
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:27:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRBR9LpUwjYJxqoy8ka+k5CLYTwSXzO7rqP//cloVCB/PeiJ0DfqR1a8MfYmKUAIMwQDhnksY40hHayGRArc9g2Z6xKmTzJoG15ZSErmU8Z227fXuQxRRc+rrjwmuR741P69f6oC420HoVcXk4/meUaAo5Nc9NF8i99uKHPXjFjUStIr3FJ1ZRCz5qD2SGs6c/t2MMRGBrZa8XhSEG++mR7pkyohvvpPIRAdCVMxawIowrysN963QznCGq3w4M/RF+3mqkYhhqZNwguxx3g5OhHhjTcegOZa9DIMqIzraWlVpFpBpPJHTWCDx6zraSORFjVRHZY82VsRtVWOWn29WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28gAWOjmCiKWO6Gy1MUkhzlyqWwSW3mz6VwLXhgUBIo=;
 b=Mo+XpIPfsAn/x4IizPmCBzpdv8A5+WMQXUQEnLkR+TaTGZwZ9mkD5h4Kiu97WmUcMw0OBRCEo4mnfT+Xo4tlgBYKi+c0arVrbVbaFh0goLDhSulZghn3ysCBQ1uKj0YubiK5jIvfa5O3ztKSRcRvi5J6w2BAc6JGBrj1Z9mMGvqKUlvSah92x5M0mMNP4FUfRb50ErqnHWPX53UW+X58X5+Mh2XO5yF4yjYtOuvGU4bUliLO6AMD7XGTwbv8CsBH5NLZRay8YEX0iRzAn5D4ayKD2/l2I1XN7I8Ud0p/XOXfkvFbeUgHWPWdCUXatVD0aYcgVc7jsPXtzRV9Mv9ETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28gAWOjmCiKWO6Gy1MUkhzlyqWwSW3mz6VwLXhgUBIo=;
 b=wkq0Iz4w2x8iRTPuC5hPtD7KUqu9e2mX9p5y/Mtg1X7l0tezRRaw6Hsf1MqJpZPeKFb4s1Y78WmSwa4w6pYhCPF5ZzBWfrpcZutrHg6ibkCVHRnfPeOuv3dWon/1mo3XF/yjEcdpA2FHZB1zKqKcjQS7NnX/qFNKaJLnlJMv5X0=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 07:27:03 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::debf:178c:f5df:5efa%6]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 07:27:03 +0000
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huang, Ray"
 <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC QEMU PATCH v7 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Topic: [RFC QEMU PATCH v7 1/1] virtio-pci: implement No_Soft_Reset bit
Thread-Index: AQHafoMhZ4XQd/U9wkqB2PJdFlPRUrFNSoAA
Date: Thu, 28 Mar 2024 07:27:03 +0000
Message-ID: <BL1PR12MB58499657696029DCFDA4EDE2E73B2@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20240325070724.574508-1-Jiqian.Chen@amd.com>
 <20240325070724.574508-2-Jiqian.Chen@amd.com>
In-Reply-To: <20240325070724.574508-2-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5111.namprd12.prod.outlook.com
 (15.20.7292.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH2PR12MB4039:EE_
x-ms-office365-filtering-correlation-id: a7b250c6-82d0-4eba-d175-08dc4ef876cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 42H9vsk510l6/QyEbOz8eWt2NHUJYe9P7Zz2ixdF3uk2k3Zo2ZyaXhKxIMKVnm0LT2byuNp/rY0gYy5efHM8favrUKqv6bt2l79PMky2Pxo3+Nn9RYlamx44dA8btDPMmKs4d3lF08jkxYTiiAw1bXA1OXXQACwOa+DipyjMiudUf0e44kNvIw/DL7soWUb4IeuFyluvyyrpNoCdsgGqW2AgZEl8cfFSu6TMNZNwFVwBBTKoYzlWSSXdj79Xh+t8+v9MriXYGwi1SZvVq0lHNEVkW1djiPTsNwSzARWmeZhviQ5fL28eVaJFLvwkEUF/j/va65Q5JW/2VTIWlN2wrcjkvVCZYqselCR2swvzak8siwWQu7BS37LsN5ip+7ZwkCDOC6jbevCm5UqYluHsT0ZxKeCO2370fZedbw+3rc1pCJ5QxRoeMPgmF7EONB3bRHOIvFjOksmdLeqLJlfspnBpZeSV+WuHuJBKb49VAb9xwhM+cg+FfGaiUJAB4jEVBN2Cf9rYuL6y4SzHOm1l3u0fRKOS3EI2ujwzzi/qS1P1OHbeskS9Ji+rzg8f4PfrUly7jn936uM7WWU7zTPyKA1lGBvLFOpUuEIy1wxda6A+N080rncYYf5eMsx7NAJIO45+uBt8lsBMC8AgRooaWrHHyVlT+4hfu1rb1+NEyIxaWVNJNPj0yP/b20Ae8HEJChfFYJ0ISlG78DhLIHE7+iMINK0tYT7K6PWGRtpWbp4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5849.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aENWVVpiZkVFclVlNzVzWDBiNjJzSWJhaW84UldPTlpWdUxmUWJRby9aM3Ri?=
 =?utf-8?B?UHNzdzlXL2sweG0zVzJEOHJPT0NXMkloSE1jaXJIWkJNZWJKWVNpOVlNTk1Y?=
 =?utf-8?B?Mk1qRDh1ejRpMVVJb25xRkJjM0hOZDh3UTNvN2JaOThzUkUvNDI5c1lBdWZG?=
 =?utf-8?B?eHRISEFiNm03VndXbjlTWmRIWUFXZTVQbW1xTWtINEE2anBlcU82RVRJeFNj?=
 =?utf-8?B?eHdvVkd5M3h5Ly84K3R5eWZEUWxrZTd3TUNRUDFCZ1ZnbFZWQU9GWXpLa1JW?=
 =?utf-8?B?OFFLeTR1ZjlUcGkrZlA5THgyeUZpNHZLMTMwVVRTaWJnRzlwSmxybUR5MHRB?=
 =?utf-8?B?RHVCbWFOUjU2bzRFcCsyQnJFUm5xMzFLWVhzRlNVZ1dOcWNaRUxKU3IvdDh6?=
 =?utf-8?B?bXc4K1NPUWtVbm45Y2lERnpKRU9zUEdROU1NaHk5VWtmTVVrV3ZPNk5DTHlo?=
 =?utf-8?B?YTJjM1Q1K3VLZXlnMXp1RUd1MXFDTjZBVDgyUUtETTl6M0VpSGhsOFU5QlYy?=
 =?utf-8?B?bUp3VWhQNm15RlNXN2pPdXczWndsWmFhNkNDWno1MjMrUG1GMlBrWWcrL2pp?=
 =?utf-8?B?UUxQZFlpQ2pCaHNLSjFPa3gxZm1ZQXpaSEExNll5WE9FcmJSOFZUTksrY0NU?=
 =?utf-8?B?WGZjMGRDNFp1aS9KVEhPMmVRZ2NmVk1sMFl2Y2tzSjBOK1l2TUlUSVBnRDNn?=
 =?utf-8?B?amVsME54UGxlMGZVby9PNTFqajE0alRqdzNRNjJSbHBTbUt4SzVha0JkeWk4?=
 =?utf-8?B?UVB6SVRVc0NBWmNQZW9JZXpFTHBxSjBVZStwbEo1RUl1Q0hqanhVRDlObzhR?=
 =?utf-8?B?S2pjcXZRRWd2ZGFlR1drTzJqbFBXNjFoeDM1RFRPbTJHUWpWN3E4RWx0UkVh?=
 =?utf-8?B?Q0pYOUJvWmhIclRJWmNtZUtORFU2alIzbExMNytjZGk2d2p1QjBoS0RZczZS?=
 =?utf-8?B?U2JVOTZiR0RIdkxsWExTZVlWMTBxQmJzTC9Zc2RyU1gvWTMrdXBjRE5Bblpw?=
 =?utf-8?B?SC95aGc0QTRXUmdyVElvWmV1MWQ0N2xqeTNDZkYyUmlKZGhmRlh0dEExaEFq?=
 =?utf-8?B?UTJuY1pPdy9oRFM1d1ZKK3g4aHc1dUxMYnYweVdPOTB5TzNMWE5nckVLK1Jp?=
 =?utf-8?B?eWNVSWxXN2tDY01ZeHpYZHRoc3dwbTM3MCtYVzUvQU01KzRBcnBiQnNCdjJB?=
 =?utf-8?B?Z0pySGF4cEgxNExrM2c0NlBiWXlkWjd0RmovOTRLcDdrazk0YXJYa3NDRmw1?=
 =?utf-8?B?VWVjcGlOV2svdVppRXg3SlY1MEhwQzdjVXR1ejNxUnF4Zk9xd0VsSVJLMDAz?=
 =?utf-8?B?SGRVY2pkM0Q1eEFjVXRXUUlEYzJPZVpIK1NnMUVKYXVEbVZZQ1NRZTd3aGJE?=
 =?utf-8?B?OElpNDVhRnRvMlcyNERGVmlld0tVWXd4MXRTTUJyRm82bVdpbHNtdUc3aFJU?=
 =?utf-8?B?SkZQRjRUYzY1eHJFVEliK0o2M3NhVzdWQ0F3NUcxUUVQTk5NOWJCVzNkUnZT?=
 =?utf-8?B?OEhnQnNYaFhaMHdKV0thVkpyT2pZUFF5YldFK2IvZm93djNQbkF0S29IUEsv?=
 =?utf-8?B?alRRNmxMNHlvSnFRa2NHNHFacW41TElMQ0pyeGJ2K3ZTMFpjTDlGMktqMFlu?=
 =?utf-8?B?ejFxT01zS0lQYSsyem1HMEUzc2FFbXFVN2ZHN09GcSswWWFiVG40aUVCc3dy?=
 =?utf-8?B?Qk93RStqNnFUSWxRdk5qNS9jZHRocXdjRlNSNWprWHI3QmtsNEZyWENhcGdv?=
 =?utf-8?B?WUhPVXYrWHMxWUlEbWVQMUorb2pmWmJra2h6M2ZFQWhBQWlrLzNPbXRMeStx?=
 =?utf-8?B?bFR6VzdKcVFycktWMXJ5dTd0VFhvdFRUMTY3T0JoNWFVdmVIalZEVllkVjlL?=
 =?utf-8?B?YlBxRVdjOXA4TER0SVVjbUJyWExQclBqMXBZTHFwY1g5VTQ3YmpyZjhXMDln?=
 =?utf-8?B?R1BGa1AxZ1lMSnh6RUxmU0NaWVhaRmJaSk5ZS1cxazF4Vk1URVNPNnZxK2py?=
 =?utf-8?B?ci83YTJDWCtiYVEwOGFDdlptZDJZZ3RxYnNzSHlQQ1lGODlsRzEySi9NK3Jq?=
 =?utf-8?B?OHNaRlFXQTFVYU1iZUVzSlZHUEIyNGQ0Sm96QlRIaEZoM3JjYkRVbmlCTXFm?=
 =?utf-8?Q?uS/0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF08C9AF5CA13F4F91B9C6BA091606F0@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b250c6-82d0-4eba-d175-08dc4ef876cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:27:03.1373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0T4DR/V2JMDW55wrCH+qg6HZ1w5AXP8mM0isLPkblEM1xjbUvM/Xu20PD9hprc0+dYdbQ3a+S1KbmE1OjZ/M3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
Received-SPF: permerror client-ip=2a01:111:f403:2418::601;
 envelope-from=Jiqian.Chen@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgTVNULA0KSSBtb2RpZmllZCB0aGlzIHBhdGNoIGFjY29yZGluZyB0byB5b3VyIGNvbW1lbnRz
LiBEbyB5b3UgaGF2ZSBhbnkgb3RoZXIgc3VnZ2VzdGlvbnM/DQoNCk9uIDIwMjQvMy8yNSAxNTow
NywgSmlxaWFuIENoZW4gd3JvdGU6DQo+IEluIGN1cnJlbnQgY29kZSwgd2hlbiBndWVzdCBkb2Vz
IFMzLCB2aXJ0aW8gZGV2aWNlcyBhcmUgcmVzZXQgZHVlIHRvDQo+IHRoZSBiaXQgTm9fU29mdF9S
ZXNldCBpcyBub3Qgc2V0LiBBZnRlciByZXNldHRpbmcsIHRoZSBkaXNwbGF5IHJlc291cmNlcw0K
PiBvZiB2aXJ0aW8tZ3B1IGFyZSBkZXN0cm95ZWQsIHRoZW4gdGhlIGRpc3BsYXkgY2FuJ3QgY29t
ZSBiYWNrIGFuZCBvbmx5DQo+IHNob3cgYmxhbmsgYWZ0ZXIgcmVzdW1pbmcuDQo+IA0KPiBJbXBs
ZW1lbnQgTm9fU29mdF9SZXNldCBiaXQgb2YgUENJX1BNX0NUUkwgcmVnaXN0ZXIsIHRoZW4gZ3Vl
c3QgY2FuIGNoZWNrDQo+IHRoaXMgYml0LCBpZiB0aGlzIGJpdCBpcyBzZXQsIHRoZSBkZXZpY2Vz
IHJlc2V0dGluZyB3aWxsIG5vdCBiZSBkb25lLCBhbmQNCj4gdGhlbiB0aGUgZGlzcGxheSBjYW4g
d29yayBhZnRlciByZXN1bWluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxK
aXFpYW4uQ2hlbkBhbWQuY29tPg0KPiAtLS0NCj4gIGh3L3ZpcnRpby92aXJ0aW8tcGNpLmMgICAg
ICAgICB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIGluY2x1ZGUv
aHcvdmlydGlvL3ZpcnRpby1wY2kuaCB8ICA1ICsrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDQy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody92aXJ0
aW8vdmlydGlvLXBjaS5jIGIvaHcvdmlydGlvL3ZpcnRpby1wY2kuYw0KPiBpbmRleCAxYTcwMzlm
YjBjNjguLmRhYWZkYTMxNWY4YyAxMDA2NDQNCj4gLS0tIGEvaHcvdmlydGlvL3ZpcnRpby1wY2ku
Yw0KPiArKysgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jDQo+IEBAIC0yMTk3LDYgKzIxOTcsMTEg
QEAgc3RhdGljIHZvaWQgdmlydGlvX3BjaV9yZWFsaXplKFBDSURldmljZSAqcGNpX2RldiwgRXJy
b3IgKiplcnJwKQ0KPiAgICAgICAgICAgICAgcGNpZV9jYXBfbG5rY3RsX2luaXQocGNpX2Rldik7
DQo+ICAgICAgICAgIH0NCj4gIA0KPiArICAgICAgICBpZiAocHJveHktPmZsYWdzICYgVklSVElP
X1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVQpIHsNCj4gKyAgICAgICAgICAgIHBjaV9zZXRfd29y
ZChwY2lfZGV2LT5jb25maWcgKyBwb3MgKyBQQ0lfUE1fQ1RSTCwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKTsNCj4gKyAgICAgICAgfQ0KPiAr
DQo+ICAgICAgICAgIGlmIChwcm94eS0+ZmxhZ3MgJiBWSVJUSU9fUENJX0ZMQUdfSU5JVF9QTSkg
ew0KPiAgICAgICAgICAgICAgLyogSW5pdCBQb3dlciBNYW5hZ2VtZW50IENvbnRyb2wgUmVnaXN0
ZXIgKi8NCj4gICAgICAgICAgICAgIHBjaV9zZXRfd29yZChwY2lfZGV2LT53bWFzayArIHBvcyAr
IFBDSV9QTV9DVFJMLA0KPiBAQCAtMjI1OSwxOCArMjI2NCw0NyBAQCBzdGF0aWMgdm9pZCB2aXJ0
aW9fcGNpX3Jlc2V0KERldmljZVN0YXRlICpxZGV2KQ0KPiAgICAgIH0NCj4gIH0NCj4gIA0KPiAr
c3RhdGljIGJvb2wgZGV2aWNlX25vX25lZWRfcmVzZXQoUENJRGV2aWNlICpkZXYpDQo+ICt7DQo+
ICsgICAgaWYgKHBjaV9pc19leHByZXNzKGRldikpIHsNCj4gKyAgICAgICAgdWludDE2X3QgcG1j
c3I7DQo+ICsNCj4gKyAgICAgICAgcG1jc3IgPSBwY2lfZ2V0X3dvcmQoZGV2LT5jb25maWcgKyBk
ZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1fQ1RSTCk7DQo+ICsgICAgICAgIC8qDQo+ICsgICAgICAg
ICAqIFdoZW4gTm9fU29mdF9SZXNldCBiaXQgaXMgc2V0IGFuZCB0aGUgZGV2aWNlDQo+ICsgICAg
ICAgICAqIGlzIGluIEQzaG90IHN0YXRlLCBkb24ndCByZXNldCBkZXZpY2UNCj4gKyAgICAgICAg
ICovDQo+ICsgICAgICAgIGlmICgocG1jc3IgJiBQQ0lfUE1fQ1RSTF9OT19TT0ZUX1JFU0VUKSAm
Jg0KPiArICAgICAgICAgICAgKHBtY3NyICYgUENJX1BNX0NUUkxfU1RBVEVfTUFTSykgPT0gMykg
ew0KPiArICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+
ICsNCj4gKyAgICByZXR1cm4gZmFsc2U7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIHZpcnRp
b19wY2lfYnVzX3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmopDQo+ICB7DQo+ICAgICAgUENJRGV2aWNl
ICpkZXYgPSBQQ0lfREVWSUNFKG9iaik7DQo+ICAgICAgRGV2aWNlU3RhdGUgKnFkZXYgPSBERVZJ
Q0Uob2JqKTsNCj4gIA0KPiArICAgIGlmIChkZXZpY2Vfbm9fbmVlZF9yZXNldChkZXYpKSB7DQo+
ICsgICAgICAgIHJldHVybjsNCj4gKyAgICB9DQo+ICsNCj4gICAgICB2aXJ0aW9fcGNpX3Jlc2V0
KHFkZXYpOw0KPiAgDQo+ICAgICAgaWYgKHBjaV9pc19leHByZXNzKGRldikpIHsNCj4gKyAgICAg
ICAgdWludDE2X3QgdmFsID0gMDsNCj4gKyAgICAgICAgVmlydElPUENJUHJveHkgKnByb3h5ID0g
VklSVElPX1BDSShkZXYpOw0KPiArDQo+ICAgICAgICAgIHBjaWVfY2FwX2RldmVycl9yZXNldChk
ZXYpOw0KPiAgICAgICAgICBwY2llX2NhcF9sbmtjdGxfcmVzZXQoZGV2KTsNCj4gIA0KPiAtICAg
ICAgICBwY2lfc2V0X3dvcmQoZGV2LT5jb25maWcgKyBkZXYtPmV4cC5wbV9jYXAgKyBQQ0lfUE1f
Q1RSTCwgMCk7DQo+ICsgICAgICAgIGlmIChwcm94eS0+ZmxhZ3MgJiBWSVJUSU9fUENJX0ZMQUdf
UE1fTk9fU09GVF9SRVNFVCkgew0KPiArICAgICAgICAgICAgdmFsIHw9IFBDSV9QTV9DVFJMX05P
X1NPRlRfUkVTRVQ7DQo+ICsgICAgICAgIH0NCj4gKyAgICAgICAgcGNpX3NldF93b3JkKGRldi0+
Y29uZmlnICsgZGV2LT5leHAucG1fY2FwICsgUENJX1BNX0NUUkwsIHZhbCk7DQo+ICAgICAgfQ0K
PiAgfQ0KPiAgDQo+IEBAIC0yMjk3LDYgKzIzMzEsOCBAQCBzdGF0aWMgUHJvcGVydHkgdmlydGlv
X3BjaV9wcm9wZXJ0aWVzW10gPSB7DQo+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lf
RkxBR19JTklUX0xOS0NUTF9CSVQsIHRydWUpLA0KPiAgICAgIERFRklORV9QUk9QX0JJVCgieC1w
Y2llLXBtLWluaXQiLCBWaXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+ICAgICAgICAgICAgICAgICAg
ICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX1BNX0JJVCwgdHJ1ZSksDQo+ICsgICAgREVGSU5FX1BS
T1BfQklUKCJ4LXBjaWUtcG0tbm8tc29mdC1yZXNldCIsIFZpcnRJT1BDSVByb3h5LCBmbGFncywN
Cj4gKyAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRf
QklULCBmYWxzZSksDQo+ICAgICAgREVGSU5FX1BST1BfQklUKCJ4LXBjaWUtZmxyLWluaXQiLCBW
aXJ0SU9QQ0lQcm94eSwgZmxhZ3MsDQo+ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19QQ0lf
RkxBR19JTklUX0ZMUl9CSVQsIHRydWUpLA0KPiAgICAgIERFRklORV9QUk9QX0JJVCgiYWVyIiwg
VmlydElPUENJUHJveHksIGZsYWdzLA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8v
dmlydGlvLXBjaS5oIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oDQo+IGluZGV4IDU5
ZDg4MDE4YzE2YS4uOWU2N2JhMzhjNzQ4IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRp
by92aXJ0aW8tcGNpLmgNCj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLXBjaS5oDQo+
IEBAIC00Myw2ICs0Myw3IEBAIGVudW0gew0KPiAgICAgIFZJUlRJT19QQ0lfRkxBR19JTklUX0ZM
Ul9CSVQsDQo+ICAgICAgVklSVElPX1BDSV9GTEFHX0FFUl9CSVQsDQo+ICAgICAgVklSVElPX1BD
SV9GTEFHX0FUU19QQUdFX0FMSUdORURfQklULA0KPiArICAgIFZJUlRJT19QQ0lfRkxBR19QTV9O
T19TT0ZUX1JFU0VUX0JJVCwNCj4gIH07DQo+ICANCj4gIC8qIE5lZWQgdG8gYWN0aXZhdGUgd29y
ay1hcm91bmRzIGZvciBidWdneSBndWVzdHMgYXQgdm1zdGF0ZSBsb2FkLiAqLw0KPiBAQCAtNzks
NiArODAsMTAgQEAgZW51bSB7DQo+ICAvKiBJbml0IFBvd2VyIE1hbmFnZW1lbnQgKi8NCj4gICNk
ZWZpbmUgVklSVElPX1BDSV9GTEFHX0lOSVRfUE0gKDEgPDwgVklSVElPX1BDSV9GTEFHX0lOSVRf
UE1fQklUKQ0KPiAgDQo+ICsvKiBJbml0IFRoZSBOb19Tb2Z0X1Jlc2V0IGJpdCBvZiBQb3dlciBN
YW5hZ2VtZW50ICovDQo+ICsjZGVmaW5lIFZJUlRJT19QQ0lfRkxBR19QTV9OT19TT0ZUX1JFU0VU
IFwNCj4gKyAgKDEgPDwgVklSVElPX1BDSV9GTEFHX1BNX05PX1NPRlRfUkVTRVRfQklUKQ0KPiAr
DQo+ICAvKiBJbml0IEZ1bmN0aW9uIExldmVsIFJlc2V0IGNhcGFiaWxpdHkgKi8NCj4gICNkZWZp
bmUgVklSVElPX1BDSV9GTEFHX0lOSVRfRkxSICgxIDw8IFZJUlRJT19QQ0lfRkxBR19JTklUX0ZM
Ul9CSVQpDQo+ICANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

