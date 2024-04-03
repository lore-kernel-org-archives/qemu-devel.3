Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EC3CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 03:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrrWK-0004IS-FF; Tue, 02 Apr 2024 23:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrrWI-0004IF-TE
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 23:42:38 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrrWG-00027I-I5
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 23:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1712115756; x=1743651756;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2nkVLChPPoP62hBfbHObGOxYP2lw2oob7gXU2azBQu0=;
 b=Iw+9NwKP2jMEA2dAKYOLvZ/ahBLsz2lZS5dWR0kDnzQK8fWsgY7UF0OJ
 ooFBdZ1RmZWxXICvdnaML0o8CQmXVV7oDqAKH6DlPq0MPpdd5cQ4GABmW
 AlixinDCwb0Afn4jisKtFofoM1VWWSQ5L1CX+ZFUIo9ViKprsu7g9ML2x
 zqccv1KPk+RXh5mSFnCjF9OyhM3ofd40QviCNu5n6asKBCCzee0XHWvdu
 SSPagDpwxZFXF9J4bGXT6F/Ji234B9tTtRji/gR8TL2aQP1Jc089Is6/e
 ikj8/cRwbY4fkKqjW0aw5gM6Llinr869NIr1Gfj2NuMijKsgKPY78GTGc Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="115400731"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; d="scan'208";a="115400731"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 12:42:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9lfqgDAVoWt7ZiEY8iFrkTV3oBHUVWOF3iyXI77YbwP9qzI/dXxtAiile3EFqVbJpqhjcnm5FuwMGx4JYyEanF/LI0zeArWHH8DxJZClp8BOFy3HBI8LEuOr+u2ncsxJKVBCRz0G03Q4/TrqRkppl5MZhqw5BcKezHhdyzaj29QK7gfgb05pBK54p5GQ+9F2oU4pefpjkFrucfViKcWUATGKihKXXWM6R+6EmTDxqnlByZQ0ehwneI4KFS/VDfNwY+FWkYdMXikUcKGfezFbd78ZvXNi6dDYhPD3OlEJxpL1HXUvqao8yySNILanr1ohUXsVJai1GruWvNCT4ziDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nkVLChPPoP62hBfbHObGOxYP2lw2oob7gXU2azBQu0=;
 b=m0gXfIzpb6neDiiFYyV4wQh0uOHm8LXQNEEQr1eNllKJw2jtkl2SU+uOG/H8WTcBnBPYZ6FZEupiHfTKVJ3eLYw1QKQOsjVpKA1C4Ci8NjdFunqz90bcjoiLyho00HEFhOAuH3MlWLlSpJjMzk0nlxNEXYStUzmGF6PsZOJQBEo89C4iKkiUO1lOnI7LmIph7WeCtCHhPhYCN/ILNpwZMH2wCNjdUtrNafCdAoH9+dA745Q+H+u7xCk55ZjzA47vBRzkb+qN29QsKxwM2QfLsx65nPZRtiW29+2YD0EgMyoIjrtqw/JV+8NIm+eyR6DL/EbAjRL14wqoObWtGZg6QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by TYAPR01MB6490.jpnprd01.prod.outlook.com
 (2603:1096:400:94::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 03:42:27 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 03:42:27 +0000
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] CXL/cxl_type3: reset DVSEC CXL Control in ct3d_reset
Thread-Topic: [PATCH 2/2] CXL/cxl_type3: reset DVSEC CXL Control in ct3d_reset
Thread-Index: AQHahJ+oqGnlriIGK0KUT8BDpxjpqbFUs9AAgAE004A=
Date: Wed, 3 Apr 2024 03:42:26 +0000
Message-ID: <4fab02af-5528-49e3-96ab-57cb2446dc05@fujitsu.com>
References: <20240402014647.3733839-1-lizhijian@fujitsu.com>
 <20240402014647.3733839-2-lizhijian@fujitsu.com>
 <20240402101706.000045b2@Huawei.com>
In-Reply-To: <20240402101706.000045b2@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|TYAPR01MB6490:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ftKfdESya4EsMWdLkP7cTQZmtANOOVcbPOdsLKunblwPbA90MWbto1BRscPTqzOge9T9Z+3MVNVDqe6Zy4LjaB5X7y8bdsdB+U78ovTFIy52tKBZzSqK9WiOTdZ9puaRHUl8gIYp0jdOKrUpZFzgY9GVwIspFXx6The9PW+jH1yiJ4TA/nlAljc1t7NsZNYFWFFAjFbTLS+qeeAQCfV5CWXUK5lnGHaSDgygxmlmEyZoQ1ufKAZ5UzLW/xBLYzv000WN/x4614mmrcBcINm7FmGr2QEi5ilQD4jjzPE/ZeBcUuvcOSQ+f/I5J33cusz0NeR4NV0XPcO4rstrMA4Zq8V62eoNNkCwHqmYe43+NOqoweovt97H523hfEYemYRWmzCfNECTvWDP4z4KV/mv+3ixWVzhrkxg+moSllOltlVfm2OWMMcJnxBWk20yhEbubBCh7yzYqBl/jT9fBdJ4Xe+5Mr08i4uLYFvr6drTs0+jrgWxkNpNmiVB5Z0DaJ+OP41Hcnns+MKEDCFakHX+UjFFKfP8vxjmJSEKvOFbHV3f8o0psmRKj/7S2SbKBRZadLbiHcIv0z6Mi+7ESql+DS5UNrhLGI35aAUvtbU+/0sW08uUWLjyZcTfR4u2h1HdSAgFs4aBxFdS0W48k1d0qne4fL7A5f8mweZA235t2tu0QDOG10LLv+zoJJZTOLBlPylb8mFnbjwmtjRjx/N6og==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB5818.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(1580799018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWFjcWpEaXY1S2hxcWt6aldnWmI2cEtYc0FGNFBPdjdCcS8vdXR5ZnBwamtk?=
 =?utf-8?B?V21oamZFRmtwR2t5c1UzdTl5UTNKd3hxUkdwVzFCaTVEVkhBSzdLSzZLQzRn?=
 =?utf-8?B?UjEvK0JLNjBITzl4QmZtKzlmY3ZIZEV6ZmdhN3UrYkgxSHVLajBkYkRZZXRr?=
 =?utf-8?B?emRPTDVQTTYyejZCbkt3QjBzejJ4aTc0YUJoajltQVlRd0lSaTYxUVEwdE9n?=
 =?utf-8?B?SGJ5WklKTFAyZUhYaG1EZThuOXJ0ZktBSWJaSlBmSUpUN052Rk9sMlMwYTAr?=
 =?utf-8?B?bGJYdkFxcmF5emQ1VEVkN3BXcG1rL21VWG9lM2ptK1NQVGJDbVppY0RpNi9j?=
 =?utf-8?B?ZityaVVuM1JSM1BjRjNZRjFod25ya1JxbDRGTHdmZjJ2NDBBUE9lYndqWVlJ?=
 =?utf-8?B?aGpCd1FteTJHUU9VNm1jUDVKRVM2NGdxSFRuUXZwNnZDV3Zqc2U1L2ZqS2lx?=
 =?utf-8?B?eGc5N2cxSzZyZGFCVlN4RXV0cHdyYnZUUkhFODUrakhpNWJvd2NTUFF6QnBZ?=
 =?utf-8?B?V05kdjByRExHYWpmNXlOcHYyZDFIKzlmdjlSbHJWRzl5MU9EV3FTVUxwcDl5?=
 =?utf-8?B?ckNSSHhsNDV2aDU5RXRhOXY5MkVUNFJoeDFSUGc0Rnhmb0hid2FNRUczMmZy?=
 =?utf-8?B?d3hFRUs2RFdSVnZlZENndG9OK2VRTjl3NWsxR2x3VXJVNCs4bHRnU0dsMXZy?=
 =?utf-8?B?Q1UrOVRlQmdWcmJtSlJ6OVp0VE02RnV5Q2RUUFoyRVFWaERvNGowLzFaVHRS?=
 =?utf-8?B?MkZFUzN5ZWF3dUVnVjdBTnB4YzhmaWY2eFdleE1ZWXVoeUV6UDYxdDJrSU50?=
 =?utf-8?B?KytQYzZzNFl3azJWdE5KQjE0bXFiUERtL0pYWGI2dTltQWRFUllsNVhhTW0v?=
 =?utf-8?B?WGJraHZzdWVlbjREcGZyMVZLcW1VK2tSVkxSREFrakJJcWt1WmV3NnhQcFZq?=
 =?utf-8?B?QVhLcWlLZWRScnczbVZhVitrTzRuZkJjalpnUXFFclQ2UUxMM29MNitSamNT?=
 =?utf-8?B?OTlOUWRVVlZlN2M3Z3JyS082MXREa1ZaTmhOSHNCZG96b1BaNlhaa0ZqRVEz?=
 =?utf-8?B?VFFPNlIyTmhxTmJFVTRNMk0wcHRQdFQxcHIram1ic0Y4VVkwbUJNZUExUHRx?=
 =?utf-8?B?UlFrd09VaUtaSW8wN3EyL1doTklReXBBa1VtN2dIN1d1Q3QxVlJDc21nWkRI?=
 =?utf-8?B?TWU4WHVENlNxdm9DcE96VzcxdytCVUhSTEozTUlwVUpjeW1MOFRUay9XM2lW?=
 =?utf-8?B?cUIvMnFrSjFnWFBjTnltWU9zN1NCREZYZ2FCbGxmb3dJUUd0RjUzRytYYVZp?=
 =?utf-8?B?ZGpONlNJVUpPano4TDArTXYxZ0xkdE0yS0RVbDJIZjBEeFRUUi9jMjc5Mkxk?=
 =?utf-8?B?TEtub0djcDNMUkwzUmQvL3k2eldWc0NuVFhkUFdNcVF2bjR5YlFYNUVicmk1?=
 =?utf-8?B?WGVBcUl3eFdMblAxcFVOczZ1bEJjZkdSYWNWS1pmL0ZJZ1FJS1p0ekJkbE4w?=
 =?utf-8?B?NzQxaWpCQlNuZDJjRnRER0cxQjY5TFhCSmVZMDJEdkJWblYvWDRsanNENWJP?=
 =?utf-8?B?cDZTVC9GS2MxTXdoNjIwd3JKbUNZR2I1MkxTVys3R2F2ODAybTJqRWhCaXNC?=
 =?utf-8?B?NW4yQ2R3Ky9KdFpGUzRxVWFxeHR4K2QweVdsd1luVnlXc3JXWW02TitHeHNY?=
 =?utf-8?B?eml2cHpwZlpGd3oyN3BsVDFlY2g5d2RQQ2d1bXlvLzRZKytWZDJyK1piZ1RQ?=
 =?utf-8?B?K2xub24rckk4V3Bab3Rpa3RuWXp1dXJWUTA0WmcwQWRhc0RnOE01d0ljZGFJ?=
 =?utf-8?B?N2k5SWlVb3NFS01naExleUQzSkJrL3NadEpFQ0JHU2kyeENzU280Wm9RQ1Mw?=
 =?utf-8?B?d3FJYlJCMURVQXl6VG0ySW10RC9xd2J3eFd6dEJnWkJ3c3A4K1hpUkEzOUFr?=
 =?utf-8?B?YXJVZzRPcnZ4WEhNOTIzdjRaU2U5SmF1djdXWjNVYld2RTZsR0p5MlJtSStJ?=
 =?utf-8?B?UXhqbkx3eDJ6Vk8yRHludVpiWjFjUHZrVXF3aUhZMExRT3YrOEVycHAvNUVw?=
 =?utf-8?B?V0VoczYyTXkrOG1FY2YwdnlQalpOQzBmSEl4c2cwUXNRVVRQS1JPdGk0VjAr?=
 =?utf-8?B?YmpTaFlDREwrQ1MyUWNOb2VselVyWDkwMFcxWGpERjBZNEFFZkVmSG14N1B2?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3631011EF139BA45B7DA8B5673712EE5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sCKdGg+FU4TTpaW/GNKjGJf238Z/YQ3OJBzfrhhL8nTw2UfQpeeC9TIjLS/HEiwuZrFLJ5FjRqaAjxE3RbiDGKieEeRQ7hqhAAY9OHakTUuhPfZnmgvdXqe4pw+PZFNfrdDmnzegcsLi/POV5FTIAw4xNdOHJYhne7v1PFmw9UCXHGimCgWOUMFNY/x+Uj8BFxloT25+yL2ibWvSiNaxE/6jF932v0foTjBRyTT3Vw+BXY5ELUnYG5dNCHZ+4crabb7dUbI9AR+Rn8qGDb1B/uRdijvNZOoxG7+3eWwR4JmLzrbVfXuWur/Tst9KbkZe1TO1wybKiPP0Cwz7oU+IWZG6esWKLDskwENXqT1D7rZH7F2x4y3idog4rK42T2GGDoQse6GXfwUHyHYs4+34e1xI2Zc2xWprYmb5iiE4WACTolzukZepMpUjnEAVOS16MFYuq0tdn+o1ENLPp3d96mQDk/7oxDPf3FK/58PajWB9CtpB8hyAba8cOB+hjoG9VdaCm8DGAgdPK/jQ9ZMHGc+djtXCtQ/beZ+7sHhq5+GeVHE05n8c1ulv3N+Y2s/qn+8EZBU19Lboga0olua1CdBhLn8cS9Rhvw5cMkjyYPbnU5t4xWNBU3Ogukg77Jau
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68bb76b-0b83-4f23-3677-08dc539014d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 03:42:26.9317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2o0MgSmKdezZ5SUbKXyNwVbclMiO6fuzt0FnHjLZ0AAaJGxxlC3yBV1XgAHmFFUemjtOCWCuSUKkq3JoC9rcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6490
Received-SPF: pass client-ip=68.232.156.101;
 envelope-from=lizhijian@fujitsu.com; helo=esa14.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDAyLzA0LzIwMjQgMTc6MTcsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFR1
ZSwgIDIgQXByIDIwMjQgMDk6NDY6NDcgKzA4MDANCj4gTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPiB3cm90ZToNCj4gDQo+PiBBZnRlciB0aGUga2VybmVsIGNvbW1pdA0KPj4gMGNh
YjY4NzIwNTk4ICgiY3hsL3BjaTogRml4IGRpc2FibGluZyBtZW1vcnkgaWYgRFZTRUMgQ1hMIFJh
bmdlIGRvZXMgbm90IG1hdGNoIGEgQ0ZNV1Mgd2luZG93IikNCj4gDQo+IEZpeGVzIHRhZyBzZWVt
cyBhcHByb3ByaWF0ZS4NCj4gDQo+PiBDWEwgdHlwZTMgZGV2aWNlcyBjYW5ub3QgYmUgZW5hYmxl
ZCBhZ2FpbiBhZnRlciB0aGUgcmVib290IGJlY2F1c2UgdGhpcw0KPj4gZmxhZyB3YXMgbm90IHJl
c2V0Lg0KPj4NCj4+IFRoaXMgZmxhZyBjb3VsZCBiZSBjaGFuZ2VkIGJ5IHRoZSBmaXJtd2FyZSBv
ciBPUywgbGV0IGl0IGhhdmUgYQ0KPj4gcmVzZXQoZGVmYXVsdCkgdmFsdWUgaW4gcmVib290IHNv
IHRoYXQgdGhlIE9TIGNhbiByZWFkIGl0cyBjbGVhbiBzdGF0dXMuDQo+IA0KPiBHb29kIGZpbmQu
ICBJIHRoaW5rIHdlIHNob3VsZCBhaW0gZm9yIGEgZml4IHRoYXQgaXMgbGVzcyBmcmFnaWxlIHRv
IGZ1dHVyZQ0KPiBjb2RlIHJlYXJyYW5nZW1lbnQgZXRjLg0KPiANCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgaHcv
bWVtL2N4bF90eXBlMy5jIHwgMTQgKysrKysrKysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcv
bWVtL2N4bF90eXBlMy5jIGIvaHcvbWVtL2N4bF90eXBlMy5jDQo+PiBpbmRleCBhZDJmZTdkNDYz
ZmIuLjNmZTEzNjA1MzM5MCAxMDA2NDQNCj4+IC0tLSBhL2h3L21lbS9jeGxfdHlwZTMuYw0KPj4g
KysrIGIvaHcvbWVtL2N4bF90eXBlMy5jDQo+PiBAQCAtMzA1LDcgKzMwNSw4IEBAIHN0YXRpYyB2
b2lkIGJ1aWxkX2R2c2VjcyhDWExUeXBlM0RldiAqY3QzZCkNCj4+ICAgDQo+PiAgICAgICBkdnNl
YyA9ICh1aW50OF90ICopJihDWExEVlNFQ0RldmljZSl7DQo+PiAgICAgICAgICAgLmNhcCA9IDB4
MWUsDQo+PiAtICAgICAgICAuY3RybCA9IDB4MiwNCj4+ICsjZGVmaW5lIENUM0RfREVWU0VDX0NY
TF9DVFJMIDB4Mg0KPj4gKyAgICAgICAgLmN0cmwgPSBDVDNEX0RFVlNFQ19DWExfQ1RSTCwNCj4g
TmFtaW5nIGRvZXNuJ3QgbWFrZSBpdCBjbGVhciB0aGUgZGVmaW5lIGlzIGEgcmVzZXQgdmFsdWUg
LyBkZWZhdWx0IHZhbHVlPj4gICAgICAgICAgIC5zdGF0dXMyID0gMHgyLA0KPj4gICAgICAgICAg
IC5yYW5nZTFfc2l6ZV9oaSA9IHJhbmdlMV9zaXplX2hpLA0KPj4gICAgICAgICAgIC5yYW5nZTFf
c2l6ZV9sbyA9IHJhbmdlMV9zaXplX2xvLA0KPj4gQEAgLTkwNiw2ICs5MDcsMTYgQEAgTWVtVHhS
ZXN1bHQgY3hsX3R5cGUzX3dyaXRlKFBDSURldmljZSAqZCwgaHdhZGRyIGhvc3RfYWRkciwgdWlu
dDY0X3QgZGF0YSwNCj4+ICAgICAgIHJldHVybiBhZGRyZXNzX3NwYWNlX3dyaXRlKGFzLCBkcGFf
b2Zmc2V0LCBhdHRycywgJmRhdGEsIHNpemUpOw0KPj4gICB9DQo+PiAgIA0KPj4gKy8qIFJlc2V0
IERWU0VDIENYTCBDb250cm9sICovDQo+PiArc3RhdGljIHZvaWQgY3QzZF9kdnNlY19jeGxfY3Ry
bF9yZXNldChDWExUeXBlM0RldiAqY3QzZCkNCj4+ICt7DQo+PiArICAgIHVpbnQxNl90IG9mZnNl
dCA9IGZpcnN0X2R2c2VjX29mZnNldChjdDNkKTsNCj4gDQo+IFRoaXMgcmVsaWVzIHRvIG11Y2gg
b24gdGhlIGN1cnJlbnQgbWVtb3J5IGxheW91dC4gIFdlIHNob3VsZCBkb2luZyBhIHNlYXJjaA0K
PiBvZiBjb25maWcgc3BhY2UgdG8gZmluZCB0aGUgcmlnaHQgZW50cnksDQoNCk9mIGNvdXJzZSwg
dGhpcyBvcHRpb24gaXMgcmVsaWFibGUgYW5kIHBvcnRhYmxlLg0KDQpNeSB0aG91Z2h0IHdhcyB0
aGF0IGJ1aWxkX2R2c2VjcygpIGFuZCB0aGUgX3Jlc2V0KCkgYXJlIHN0YXRpYyhpbnRlcm5hbCB1
c2VkKSwNCnRoZWlyIGNhbGxlcnMgc2hvdWxkIGhhdmUgdGhlIHJlc3BvbnNpYmlsaXR5IHRvIGtl
ZXAgdGhlIGNvbmZpZ3VyZSBzcGFjZS9EVlNFQ1MgbGF5b3V0IGNvbnNpc3RlbnQuDQpTbyBJJ20g
d29uZGVyaW5nIGlmIGlzIGl0IHRvbyBoZWF2eSB0byBoYXZlIGEgKm5ldyogX2ZpbmQoKSBzdWJy
b3V0aW5lIGZvciBpdC4NCg0KDQpBbm90aGVyIG9wdGlvbiBjb3VsZCBiZSByZWJ1aWxkIHRoZSBh
bGwgdGhlIERWU0VDcyBzaW1wbHkgYWZ0ZXIgdXBkYXRlZCB0aGUgKm9mZnNldCosIGp1c3QgbGlr
ZToNCg0Kdm9pZCByZXNldF9kZXZzZXMoKQ0Kew0KICAgICAgY3hsLT5kdnNlY19vZmZzZXQgPSBP
RkZTRVRfVE9fRklSU1RfRFZTRUM7DQogICAgICBidWlsZF9kdnNlY3MoKTsNCn0NCg0KSXQncyBy
ZWFzb25hYmxlIGJlY2F1c2Ugd2Ugb3VnaHQgdG8gZW5zdXJlICphbGwqIHRoZSBEVlNFQ3MgYmVp
bmcgcmVzZXQgaW4gbmV4dCBib290Lg0KDQpMZXQgbWUga25vdyB5b3VyIHRob3VnaHQuDQoNClRo
YW5rcw0KWmhpamlhbg0KDQoNCj4gb3Igd2Ugc2hvdWxkIGNhY2hlIGEgcG9pbnRlciB0bw0KPiB0
aGUgcmVsZXZhbnQgc3RydWN0dXJlIHdoZW4gd2UgZmlsbCBpdCBpbiB0aGUgZmlyc3QgdGltZS4N
Cg0KDQo+IA0KPj4gKyAgICBDWExEVlNFQ0RldmljZSAqZHZzZWM7DQo+PiArDQo+PiArICAgIGR2
c2VjID0gKENYTERWU0VDRGV2aWNlICopKGN0M2QtPmN4bF9jc3RhdGUucGRldi0+Y29uZmlnICsg
b2Zmc2V0KTsNCj4+ICsgICAgZHZzZWMtPmN0cmwgPSBDVDNEX0RFVlNFQ19DWExfQ1RSTDsNCj4+
ICt9DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkIGN0M2RfcmVzZXQoRGV2aWNlU3RhdGUgKmRldikN
Cj4+ICAgew0KPj4gICAgICAgQ1hMVHlwZTNEZXYgKmN0M2QgPSBDWExfVFlQRTMoZGV2KTsNCj4+
IEBAIC05MTQsNiArOTI1LDcgQEAgc3RhdGljIHZvaWQgY3QzZF9yZXNldChEZXZpY2VTdGF0ZSAq
ZGV2KQ0KPj4gICANCj4+ICAgICAgIGN4bF9jb21wb25lbnRfcmVnaXN0ZXJfaW5pdF9jb21tb24o
cmVnX3N0YXRlLCB3cml0ZV9tc2ssIENYTDJfVFlQRTNfREVWSUNFKTsNCj4+ICAgICAgIGN4bF9k
ZXZpY2VfcmVnaXN0ZXJfaW5pdF90MyhjdDNkKTsNCj4+ICsgICAgY3QzZF9kdnNlY19jeGxfY3Ry
bF9yZXNldChjdDNkKTsNCj4+ICAgDQo+PiAgICAgICAvKg0KPj4gICAgICAgICogQnJpbmcgdXAg
YW4gZW5kcG9pbnQgdG8gdGFyZ2V0IHdpdGggTUNUUCBvdmVyIFZETS4NCj4g

