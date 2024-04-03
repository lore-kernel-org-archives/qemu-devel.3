Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBCECD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrwkI-0005Fm-35; Wed, 03 Apr 2024 05:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrwkG-0005Fa-Bl
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:17:24 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rrwkD-0005pv-5Z
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1712135841; x=1743671841;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BzIRswGItT3lbQ5aIu07z/IIl3/KrtnTbbGySQ6BDIA=;
 b=K4YWkRfbwsGjVd0ft0YjS019mvbEtfl03WWEAHCzRY4mkHb4Dj7dDu0M
 o5vSTEbrI9xmuSLMQeiPSDUNPJwmmZ2n30419GcXpYa7IsdGp6DG/9WN8
 4m6WYsZ4+bKU28B/UPRq5bnMpnNzZ2rriESIZbEwPYdyen88lZWXvkllD
 Vqc+p1QfjsHRi9OGMZYrSLYh4t/5dej97zefX1niclcacs3rCdEQGjopV
 HsMe/GoSwTFxxjMqnuj8Z3PEBIB0GIWvVQKlMyH8hADq+++cIAkdhfFGZ
 DSnSYWJhgnsKcwAdligT224pfLkLhzRX4xryGXmQNQKVaH/pze7gVdSVW Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="115677259"
X-IronPort-AV: E=Sophos;i="6.07,177,1708354800"; d="scan'208";a="115677259"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2024 18:17:14 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHcpdXNq7FmjrJIvypFYYsXOKX111CGWThq4fUP8K8bC16xT6ukZy4mV/YUxo33I/gdVFRwnum2A60kkKR0916oQxq2r4wGQ85UudkYRHax+DRCVSvWlfo4Wns8auf1ZFjln5MtPCJfnKCgbTcOayqPbOchyzUQIezxem09COqkrJXlt1zuf86NFYYHEARoywaGN6gfN37JuEnlwiAHdJkYcimWXNxenS4w2Lz4DzSXFEy9E+vjWOxS7D0v//O8CCAi9vIMxjb2CQC88X3R3cxmB9gDzXxKFyFWfmZIjW2R8+6LqGP4TkPU5aNJW9cpb8hSMSLGNd88asUq6NIjObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzIRswGItT3lbQ5aIu07z/IIl3/KrtnTbbGySQ6BDIA=;
 b=Pq0hewYOfAFfigEUH5sVrj+qWnYPBA+8U9LrPmh60k9ZJp+3LaaV3HfFfi/qlIboDiLNY8dv/zmlcwHnXLwPY0SYpPgx0s9VLQKprxnhOSZClDlf+F5pyGSCvJbU5y4DwzsBsIv0myCNbV/9RRutfa+al4I6XfNGHWSj3K1qc9u9Fv4wdEWhHmb40Q6rHi+D3t5wXCD6Dy+RB6Rrh9m6Gapx/uz0+7vW4pKDZtTVy8jhaHAP6mPWynVVdw/MWAtHGM2xHd/KW1rTzctxcLCWQsJfHwjXMaE063C1+sdXJXK7uf9clFc6kE3RZ73Fc7lBiQzUvbQouEOFFwQv5LoG+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 (2603:1096:404:8059::10) by OSZPR01MB9411.jpnprd01.prod.outlook.com
 (2603:1096:604:1d7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:17:11 +0000
Received: from TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974]) by TYAPR01MB5818.jpnprd01.prod.outlook.com
 ([fe80::e69:40a6:944b:f974%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:17:11 +0000
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/2] CXL/cxl_type3: reset DVSEC CXL Control in ct3d_reset
Thread-Topic: [PATCH 2/2] CXL/cxl_type3: reset DVSEC CXL Control in ct3d_reset
Thread-Index: AQHahJ+oqGnlriIGK0KUT8BDpxjpqbFUs9AAgAE004CAAF2EAA==
Date: Wed, 3 Apr 2024 09:17:10 +0000
Message-ID: <00f8b5dd-a1a6-460c-9e45-37f691c13af9@fujitsu.com>
References: <20240402014647.3733839-1-lizhijian@fujitsu.com>
 <20240402014647.3733839-2-lizhijian@fujitsu.com>
 <20240402101706.000045b2@Huawei.com>
 <4fab02af-5528-49e3-96ab-57cb2446dc05@fujitsu.com>
In-Reply-To: <4fab02af-5528-49e3-96ab-57cb2446dc05@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB5818:EE_|OSZPR01MB9411:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ITKBC5maUqXSnr7yotxPanp1wvghfqRLgTBhrCjfQ9dL9xqdruSsT5FsKQmZJWyJVUjSn9M47h7lrRkbX9ZDDK34/3QLGqqUPdGgOWHgTWm52CnRICa+v+nKLOfCqOh1zmkqLSp3rABNDac/vPzHoubnifU+AhascwVxaqlnzL5h+obSwRU+62wlqXalZFMBnXXmarNijvQOKWc6yYQixA+43Y3R2Npkp7AzGjahmTgYfUJiB0klKQu5KoM4qJdEwJkNlBNWC0bXUi7W2Uh/vA4irLqrN2UCO+YRzKGLy4Cz9JUmpHSqsu0aEmFiN1ozcXFdIHiC3Ya8amIO7NCznER7CNKoXB74n7tpIQA/n/3HuXHsiYbWPUMJLYuRl6JSZQrEUH5eqQUWKauYjDU/ZBniqrdioUh+ObBZbE5Zi9ncEb+Xfm2x2flQwMkWdxtPqKFsjSSydqYqte197PD7tca1rzHJ+hk2H1cqEFJfwxrTKDknRFv8SdhRc6dw0fr26hdTZjp0je88KFFhxvDdAiiyB/r7mZND2ZtVTlj+vdFrdEMh+nHRVsW81utFz14drrTzbO6L3NvSITnDmAS412TJfj1Qc20y5MrKgo4cVbMr1gn5khr/KNDyksQYAJyRe4ZKZUzcXKqn2DNtnBjH67LehhfKQe31nebtP/6/yPL013ArhNz7JSuz22f0AsO1i7o2r02p1Kzh8NkkVtLrEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYAPR01MB5818.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(1580799018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWF3Z3RYMlpDV01ldmZnNXNWaVZQNjVKanFUTmxRWDkwMWZjVzROK01XcmQ2?=
 =?utf-8?B?cGllWUpUSGNLWjYvNmtQbmxaU0MzZHQyU3lpY0x1NHRFL2w1eWNCTXIvU0sy?=
 =?utf-8?B?Y2o5Yi9Vc2hUQUZYSXdrQ0ZaNUduQ3ZJMXlMSW0xVkVEeXp5MmxEMHp4WU95?=
 =?utf-8?B?YzN1N3l4S0dtTm5WdStGNC9nUXRzdERwOU5uRVMvWUhRUjlGQzVOUVpHSW1x?=
 =?utf-8?B?N0RoeFRRZUdLY3dtVkR6aE5zekZ1YjFSaWZaYmpWVzl3czZCNEd2aXVkUThE?=
 =?utf-8?B?cDRCWTQ5Q2UrSFhCOGpZUDc4TThjbDN2UEJoUWlOdS95R0VDWVJOYW5UZFgw?=
 =?utf-8?B?elppRm9ZMVoweVNOcTNOMEpmWHp0VTk1N1lZeGU5RWdQTFQ1TlBEcnBUeHFU?=
 =?utf-8?B?SE12YVQyakVWZzlDZ0lMQjYyVmdmQVE4RXA4ZmlOWWt6blFlczcyTCtzdGZC?=
 =?utf-8?B?WXduSWpabU0reVJGdVBINzZBUkd4ZzUyM091Vk1MeXFYQzl6elgxSW1EM3c4?=
 =?utf-8?B?eTM1V0xZbmtPbmN3K044L051dHZKTktvOUVmTUtMekNMZUROSGFmckpHZnhQ?=
 =?utf-8?B?TGhyYTljSVY0VUxCZVA4eGtwSm1LWUpyTkJWcWNFclRFZ2dvY1Vrc2w5OWZF?=
 =?utf-8?B?a2JDTmxGOTlkYXFiUkRoS2JMNmVkN2kvMTh3aEZuQTJkbFhSUzdjR0pjQmZx?=
 =?utf-8?B?RGxDZEhycnk0M0ovb1RDYTg1SkgxdHVmMkVkNU1vSlB6Mm50VWRoTVNwM2NU?=
 =?utf-8?B?Z05ORjQyaEVBdWxKTDJZSS95R2lCbk9HRCtpS2U0Uzk1c1lRVTRjR0RTakJZ?=
 =?utf-8?B?NjZyUy9Cd0VLSTQ1UGlCckl6TE5LNG5jQTVIVmVRWjhTTi92UDA0V0JLeEVr?=
 =?utf-8?B?QUpsbmNEKzA5VStCOVdWSkZRSUdYL2N6NlA3M2pkTFh3a0VzY3BkVG1jNzNZ?=
 =?utf-8?B?YnFwa0JDb0F2TVdubEhvMzU0VFhzeFU2U0RUbzFTZUhYRldKdTdWWm03ZmRP?=
 =?utf-8?B?MnNRMG5uaWloZ08wU1JqYmNiSkk2cE51N0JZeFdsU2Vhd1diV2NaUXU3cmRr?=
 =?utf-8?B?bU1DQTFPM0t2Uy96RVlIVjRkTEM4TnJBN1F6SzZXYVRnZ3RzNllMSjNBYVdY?=
 =?utf-8?B?SDE4UUJWckRWTUtlV1RBOEpJQzBUSXNkM0crb1p0WmdKWGlqMnJIWlp0V25B?=
 =?utf-8?B?MmxSdmFUeXZCVHhnWWd5Q2MyWVlUZUozdGdEMFI0Uy9mWUtZUzZ2ZkoxOTZV?=
 =?utf-8?B?SlpqU0k1djZtbXNQOUxWczViQkpJWThWR1NHWmJnTTlOcDhnMzRKZWhqWTBH?=
 =?utf-8?B?U1I3NzdEdDJMMjUrL0F4d1VLc25taTlFVGFaU1JPeXE0MFM1dlpBd09zN3lD?=
 =?utf-8?B?OHJBWUNIOGFFb0gydlNLQjdSOTRiZG1jSm1WVEdJciswQXJIOUZsYkcvTzJw?=
 =?utf-8?B?c1M2MVdkR3VhOEZzMldVRXFZTU0zOTNJZEVlKy9HMnBIMzRIN1ZzLzZKeXRS?=
 =?utf-8?B?dUpxMkdldWppM2VDRENvSFFnNjZwdnBGb2FTVDlONCtIYVg0Mm9jdjUwWFkr?=
 =?utf-8?B?RkdrZHBCa3B2MkV0akJ4aHRYeVV0bGpkYTJQRndaV1N1TmYvWGhRZ0ZwVnlP?=
 =?utf-8?B?WFZIWGlwcVZ1L3lPUzY1eUhwY3RkT3VMTmljVURSN2I0OGg3cUxBZ2xzSVE2?=
 =?utf-8?B?d2ZWSGxZVkxNMXJaTkphREYzOGphQnJXUVFtYzdNVVB2ZmgxeUN1a3hhNGNE?=
 =?utf-8?B?VmJjcERKVFJTQTIzTkVkVFJVZSs5cWNmdnJuMTd2TVNWa1YxSjluZVZIUncz?=
 =?utf-8?B?QTlaQlVzMGlnWk1jNTFVRjR0OHoyK2VpRHRjTjJXenZrbFJGemRWT1BnSjgv?=
 =?utf-8?B?ZG1DL1liZUlqMWlzYzRMWGtTLy9CNFR1N3U2ZVcwbzlVYkpOYnVZc281NWF5?=
 =?utf-8?B?OEFDZ05OenNNTnhQYTdkYUp0M1NNbjR3RmdOa0VvUVF4YUdUWU5ycXo2OGJ3?=
 =?utf-8?B?TlBHM014RWsvTVZqODZJRzJ2Zzc0R04zOS9peU9iaVlRcDRORnpVVzFEeEt2?=
 =?utf-8?B?Ylc2MDkyc1dGMXRIbU5EcE9NZ1F2TUMveXgweE5MWFVNSWtEcmZ5bU9aZXVL?=
 =?utf-8?B?Q3J0WDl4SlQ1UHFRWUlheHRpbm1XM0NSSkw1OFJWajRjYzNoVjcrTFhyOGd6?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DCC88119722A442ABD1F4D40FA2D76E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: B4TpYfM/qqEO5xmY0E+9GzZNfRKLRWQ+0l4zOYqE06dWXBYIG7NdR6DSclj+NO3n59pm4VtTqZIfx6wg6Dv2vpvthQ/Z3Le85HFTba29hXd9qCqFznQY/1qVgzWwvJBZjyVQq/CY+KErAHPViyErZS+IdvjVleFc3/Mx9NnKpOx+sHLUaXQjME+siWMqrzjlJfZL2eIuOSg1tqOaU2qHDraIv8lumlZg8+rfoydH61LBsNposG+jlcoH5NlZ8n4p/FPo5SByc1ZicfPSGgyhhRLHxvDpmbqmGFLd0WjfsfuKzujyE+3CBzLQeilFf2X4PEEjxN7MfPX88VZVA8yR2jhgAV1eThNTsJF2SEufGlokEI6mdf0s7A0d8gVrF8Zc1U8JI2eBqRt+6HOgO59iYJHZMb8zYWOsh4unOatq3KpNDVc3XZqYpV5hHEc7E/3XeoMGaNJ4p6saq06yj79ng05fy+PYW6CEWpwURFrMae6zqJhnSBJ0b8LGdsVziDRaRfbuuC84jqv6O5Tdq+I028zv2VMjApiYHk0r+XeL+dcUTonFr+IG+7LQ/SwZcGaSSe4CzS+WhneQPwmU39m+bLu9dnd3I7Z7pqzbLZuCd5KV3Q5RB2FLQ3bPtFYeZCTa
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def00751-87f6-47ea-7a6c-08dc53bed7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 09:17:10.9921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODJtWaIqWuF3EPDwVd3FaI3iKkNP2yJEU6twTcRSwpUpoRV1nvoPqqUxTmbV2SGAfMEoymXx7PCp0ZSzaiiN1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9411
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCk9uIDAzLzA0LzIwMjQgMTE6NDIsIExpIFpoaWppYW4gd3JvdGU6DQo+IA0KPiANCj4gT24g
MDIvMDQvMjAyNCAxNzoxNywgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4+IE9uIFR1ZSzCoCAy
IEFwciAyMDI0IDA5OjQ2OjQ3ICswODAwDQo+PiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRz
dS5jb20+IHdyb3RlOg0KPj4NCj4+PiBBZnRlciB0aGUga2VybmVsIGNvbW1pdA0KPj4+IDBjYWI2
ODcyMDU5OCAoImN4bC9wY2k6IEZpeCBkaXNhYmxpbmcgbWVtb3J5IGlmIERWU0VDIENYTCBSYW5n
ZSBkb2VzIG5vdCBtYXRjaCBhIENGTVdTIHdpbmRvdyIpDQo+Pg0KPj4gRml4ZXMgdGFnIHNlZW1z
IGFwcHJvcHJpYXRlLg0KPj4NCj4+PiBDWEwgdHlwZTMgZGV2aWNlcyBjYW5ub3QgYmUgZW5hYmxl
ZCBhZ2FpbiBhZnRlciB0aGUgcmVib290IGJlY2F1c2UgdGhpcw0KPj4+IGZsYWcgd2FzIG5vdCBy
ZXNldC4NCj4+Pg0KPj4+IFRoaXMgZmxhZyBjb3VsZCBiZSBjaGFuZ2VkIGJ5IHRoZSBmaXJtd2Fy
ZSBvciBPUywgbGV0IGl0IGhhdmUgYQ0KPj4+IHJlc2V0KGRlZmF1bHQpIHZhbHVlIGluIHJlYm9v
dCBzbyB0aGF0IHRoZSBPUyBjYW4gcmVhZCBpdHMgY2xlYW4gc3RhdHVzLg0KPj4NCj4+IEdvb2Qg
ZmluZC7CoCBJIHRoaW5rIHdlIHNob3VsZCBhaW0gZm9yIGEgZml4IHRoYXQgaXMgbGVzcyBmcmFn
aWxlIHRvIGZ1dHVyZQ0KPj4gY29kZSByZWFycmFuZ2VtZW50IGV0Yy4NCj4+DQo+Pj4NCj4+PiBT
aWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+Pj4gLS0t
DQo+Pj4gwqAgaHcvbWVtL2N4bF90eXBlMy5jIHwgMTQgKysrKysrKysrKysrKy0NCj4+PiDCoCAx
IGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4g
ZGlmZiAtLWdpdCBhL2h3L21lbS9jeGxfdHlwZTMuYyBiL2h3L21lbS9jeGxfdHlwZTMuYw0KPj4+
IGluZGV4IGFkMmZlN2Q0NjNmYi4uM2ZlMTM2MDUzMzkwIDEwMDY0NA0KPj4+IC0tLSBhL2h3L21l
bS9jeGxfdHlwZTMuYw0KPj4+ICsrKyBiL2h3L21lbS9jeGxfdHlwZTMuYw0KPj4+IEBAIC0zMDUs
NyArMzA1LDggQEAgc3RhdGljIHZvaWQgYnVpbGRfZHZzZWNzKENYTFR5cGUzRGV2ICpjdDNkKQ0K
Pj4+IMKgwqDCoMKgwqAgZHZzZWMgPSAodWludDhfdCAqKSYoQ1hMRFZTRUNEZXZpY2Upew0KPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAuY2FwID0gMHgxZSwNCj4+PiAtwqDCoMKgwqDCoMKgwqAgLmN0
cmwgPSAweDIsDQo+Pj4gKyNkZWZpbmUgQ1QzRF9ERVZTRUNfQ1hMX0NUUkwgMHgyDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIC5jdHJsID0gQ1QzRF9ERVZTRUNfQ1hMX0NUUkwsDQo+PiBOYW1pbmcgZG9l
c24ndCBtYWtlIGl0IGNsZWFyIHRoZSBkZWZpbmUgaXMgYSByZXNldCB2YWx1ZSAvIGRlZmF1bHQg
dmFsdWU+PsKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zdGF0dXMyID0gMHgyLA0KPj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCAucmFuZ2UxX3NpemVfaGkgPSByYW5nZTFfc2l6ZV9oaSwNCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgLnJhbmdlMV9zaXplX2xvID0gcmFuZ2UxX3NpemVfbG8sDQo+Pj4gQEAgLTkw
Niw2ICs5MDcsMTYgQEAgTWVtVHhSZXN1bHQgY3hsX3R5cGUzX3dyaXRlKFBDSURldmljZSAqZCwg
aHdhZGRyIGhvc3RfYWRkciwgdWludDY0X3QgZGF0YSwNCj4+PiDCoMKgwqDCoMKgIHJldHVybiBh
ZGRyZXNzX3NwYWNlX3dyaXRlKGFzLCBkcGFfb2Zmc2V0LCBhdHRycywgJmRhdGEsIHNpemUpOw0K
Pj4+IMKgIH0NCj4+PiArLyogUmVzZXQgRFZTRUMgQ1hMIENvbnRyb2wgKi8NCj4+PiArc3RhdGlj
IHZvaWQgY3QzZF9kdnNlY19jeGxfY3RybF9yZXNldChDWExUeXBlM0RldiAqY3QzZCkNCj4+PiAr
ew0KPj4+ICvCoMKgwqAgdWludDE2X3Qgb2Zmc2V0ID0gZmlyc3RfZHZzZWNfb2Zmc2V0KGN0M2Qp
Ow0KPj4NCj4+IFRoaXMgcmVsaWVzIHRvIG11Y2ggb24gdGhlIGN1cnJlbnQgbWVtb3J5IGxheW91
dC7CoCBXZSBzaG91bGQgZG9pbmcgYSBzZWFyY2gNCj4+IG9mIGNvbmZpZyBzcGFjZSB0byBmaW5k
IHRoZSByaWdodCBlbnRyeSwNCj4gDQo+IE9mIGNvdXJzZSwgdGhpcyBvcHRpb24gaXMgcmVsaWFi
bGUgYW5kIHBvcnRhYmxlLg0KPiANCj4gTXkgdGhvdWdodCB3YXMgdGhhdCBidWlsZF9kdnNlY3Mo
KSBhbmQgdGhlIF9yZXNldCgpIGFyZSBzdGF0aWMoaW50ZXJuYWwgdXNlZCksDQo+IHRoZWlyIGNh
bGxlcnMgc2hvdWxkIGhhdmUgdGhlIHJlc3BvbnNpYmlsaXR5IHRvIGtlZXAgdGhlIGNvbmZpZ3Vy
ZSBzcGFjZS9EVlNFQ1MgbGF5b3V0IGNvbnNpc3RlbnQuDQo+IFNvIEknbSB3b25kZXJpbmcgaWYg
aXMgaXQgdG9vIGhlYXZ5IHRvIGhhdmUgYSAqbmV3KiBfZmluZCgpIHN1YnJvdXRpbmUgZm9yIGl0
Lg0KPiANCj4gDQo+IEFub3RoZXIgb3B0aW9uIGNvdWxkIGJlIHJlYnVpbGQgdGhlIGFsbCB0aGUg
RFZTRUNzIHNpbXBseSBhZnRlciB1cGRhdGVkIHRoZSAqb2Zmc2V0KiwganVzdCBsaWtlOg0KPiAN
Cg0KDQo+IHZvaWQgcmVzZXRfZGV2c2VzKCkNCj4gew0KPiAgwqDCoMKgwqAgY3hsLT5kdnNlY19v
ZmZzZXQgPSBPRkZTRVRfVE9fRklSU1RfRFZTRUM7DQo+ICDCoMKgwqDCoCBidWlsZF9kdnNlY3Mo
KTsNCj4gfQ0KDQpJbiB0aGlzIG9wdGlvbiwgaSBhbHNvIHByb3Bvc2UgdG8gbW92ZSAnY3hsLT5k
dnNlY19vZmZzZXQgPSBPRkZTRVRfVE9fRklSU1RfRFZTRUMnIGluc2lkZSBidWlsZF9kdnNlY3Mo
KQ0Kc28gdGhhdCBidWlsZF9kdnNlY3MoKSBjb3VsZCBtYWludGFpbiBpdHMgb2Zmc2V0IGNvbXBs
ZXRlbHkuDQoNCitzdGF0aWMgdWludDE2X3QgZmlyc3RfZHZzZWNfb2Zmc2V0KENYTFR5cGUzRGV2
ICpjdDNkKQ0KK3sNCisgICAgdWludDE2X3Qgb2Zmc2V0ID0gUENJX0NPTkZJR19TUEFDRV9TSVpF
Ow0KKw0KKyAgICBpZiAoY3QzZC0+c24gIT0gVUk2NF9OVUxMKSB7DQorICAgICAgICBvZmZzZXQg
Kz0gUENJX0VYVF9DQVBfRFNOX1NJWkVPRjsNCisgICAgfQ0KKw0KKyAgICByZXR1cm4gb2Zmc2V0
Ow0KK30NCisNCiAgc3RhdGljIHZvaWQgYnVpbGRfZHZzZWNzKENYTFR5cGUzRGV2ICpjdDNkKQ0K
ICB7DQogICAgICBDWExDb21wb25lbnRTdGF0ZSAqY3hsX2NzdGF0ZSA9ICZjdDNkLT5jeGxfY3N0
YXRlOw0KQEAgLTI4NCw2ICsyOTUsOCBAQCBzdGF0aWMgdm9pZCBidWlsZF9kdnNlY3MoQ1hMVHlw
ZTNEZXYgKmN0M2QpDQogICAgICAgICAgICAgICByYW5nZTJfc2l6ZV9oaSA9IDAsIHJhbmdlMl9z
aXplX2xvID0gMCwNCiAgICAgICAgICAgICAgIHJhbmdlMl9iYXNlX2hpID0gMCwgcmFuZ2UyX2Jh
c2VfbG8gPSAwOw0KICANCisgICAgLyogZHZzZWNfb2Zmc2V0IHNob3VsZCBwb2ludCB0byB0aGUg
Zmlyc3QgZHZzZWMgKi8NCisgICAgY3hsX2NzdGF0ZS0+ZHZzZWNfb2Zmc2V0ID0gZmlyc3RfZHZz
ZWNfb2Zmc2V0KGN0M2QpOw0KICAgICAgLyoNCiAgICAgICAqIFZvbGF0aWxlIG1lbW9yeSBpcyBt
YXBwZWQgYXMgKDB4MCkNCiAgICAgICAqIFBlcnNpc3RlbnQgbWVtb3J5IGlzIG1hcHBlZCBhdCAo
dm9sYXRpbGUtPnNpemUpDQpAQCAtNjY0LDEwICs2NzcsNyBAQCBzdGF0aWMgdm9pZCBjdDNfcmVh
bGl6ZShQQ0lEZXZpY2UgKnBjaV9kZXYsIEVycm9yICoqZXJycCkNCiAgDQogICAgICBwY2llX2Vu
ZHBvaW50X2NhcF9pbml0KHBjaV9kZXYsIDB4ODApOw0KICAgICAgaWYgKGN0M2QtPnNuICE9IFVJ
NjRfTlVMTCkgew0KLSAgICAgICAgcGNpZV9kZXZfc2VyX251bV9pbml0KHBjaV9kZXYsIDB4MTAw
LCBjdDNkLT5zbik7DQotICAgICAgICBjeGxfY3N0YXRlLT5kdnNlY19vZmZzZXQgPSAweDEwMCAr
IDB4MGM7DQotICAgIH0gZWxzZSB7DQotICAgICAgICBjeGxfY3N0YXRlLT5kdnNlY19vZmZzZXQg
PSAweDEwMDsNCisgICAgICAgIHBjaWVfZGV2X3Nlcl9udW1faW5pdChwY2lfZGV2LCBQQ0lfQ09O
RklHX1NQQUNFX1NJWkUsIGN0M2QtPnNuKTsNCiAgICAgIH0NCiAgDQogICAgICBjdDNkLT5jeGxf
Y3N0YXRlLnBkZXYgPSBwY2lfZGV2Ow0KQEAgLTg5OSw2ICs5MDksMTEgQEAgTWVtVHhSZXN1bHQg
Y3hsX3R5cGUzX3dyaXRlKFBDSURldmljZSAqZCwgaHdhZGRyIGhvc3RfYWRkciwgdWludDY0X3Qg
ZGF0YSwNCiAgICAgIHJldHVybiBhZGRyZXNzX3NwYWNlX3dyaXRlKGFzLCBkcGFfb2Zmc2V0LCBh
dHRycywgJmRhdGEsIHNpemUpOw0KICB9DQogIA0KK3N0YXRpYyB2b2lkIGN0M2RfZHZzZWNzX3Jl
c2V0KENYTFR5cGUzRGV2ICpjdDNkKQ0KK3sNCisgICAgYnVpbGRfZHZzZWNzKGN0M2QpOw0KK30N
CisNCiAgc3RhdGljIHZvaWQgY3QzZF9yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQ0KICB7DQogICAg
ICBDWExUeXBlM0RldiAqY3QzZCA9IENYTF9UWVBFMyhkZXYpOw0KQEAgLTkwNyw2ICs5MjIsNyBA
QCBzdGF0aWMgdm9pZCBjdDNkX3Jlc2V0KERldmljZVN0YXRlICpkZXYpDQogIA0KICAgICAgY3hs
X2NvbXBvbmVudF9yZWdpc3Rlcl9pbml0X2NvbW1vbihyZWdfc3RhdGUsIHdyaXRlX21zaywgQ1hM
Ml9UWVBFM19ERVZJQ0UpOw0KICAgICAgY3hsX2RldmljZV9yZWdpc3Rlcl9pbml0X3QzKGN0M2Qp
Ow0KKyAgICBjdDNkX2R2c2Vjc19yZXNldChjdDNkKTsNCg0KDQoNCj4gDQo+IEl0J3MgcmVhc29u
YWJsZSBiZWNhdXNlIHdlIG91Z2h0IHRvIGVuc3VyZSAqYWxsKiB0aGUgRFZTRUNzIGJlaW5nIHJl
c2V0IGluIG5leHQgYm9vdC4NCj4gDQo+IExldCBtZSBrbm93IHlvdXIgdGhvdWdodC4NCj4gDQo+
IFRoYW5rcw0KPiBaaGlqaWFuDQo+IA0KPiANCj4+IG9yIHdlIHNob3VsZCBjYWNoZSBhIHBvaW50
ZXIgdG8NCj4+IHRoZSByZWxldmFudCBzdHJ1Y3R1cmUgd2hlbiB3ZSBmaWxsIGl0IGluIHRoZSBm
aXJzdCB0aW1lLg0KPiANCj4gDQo+Pg0KPj4+ICvCoMKgwqAgQ1hMRFZTRUNEZXZpY2UgKmR2c2Vj
Ow0KPj4+ICsNCj4+PiArwqDCoMKgIGR2c2VjID0gKENYTERWU0VDRGV2aWNlICopKGN0M2QtPmN4
bF9jc3RhdGUucGRldi0+Y29uZmlnICsgb2Zmc2V0KTsNCj4+PiArwqDCoMKgIGR2c2VjLT5jdHJs
ID0gQ1QzRF9ERVZTRUNfQ1hMX0NUUkw7DQo+Pj4gK30NCj4+PiArDQo+Pj4gwqAgc3RhdGljIHZv
aWQgY3QzZF9yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQ0KPj4+IMKgIHsNCj4+PiDCoMKgwqDCoMKg
IENYTFR5cGUzRGV2ICpjdDNkID0gQ1hMX1RZUEUzKGRldik7DQo+Pj4gQEAgLTkxNCw2ICs5MjUs
NyBAQCBzdGF0aWMgdm9pZCBjdDNkX3Jlc2V0KERldmljZVN0YXRlICpkZXYpDQo+Pj4gwqDCoMKg
wqDCoCBjeGxfY29tcG9uZW50X3JlZ2lzdGVyX2luaXRfY29tbW9uKHJlZ19zdGF0ZSwgd3JpdGVf
bXNrLCBDWEwyX1RZUEUzX0RFVklDRSk7DQo+Pj4gwqDCoMKgwqDCoCBjeGxfZGV2aWNlX3JlZ2lz
dGVyX2luaXRfdDMoY3QzZCk7DQo+Pj4gK8KgwqDCoCBjdDNkX2R2c2VjX2N4bF9jdHJsX3Jlc2V0
KGN0M2QpOw0KPj4+IMKgwqDCoMKgwqAgLyoNCj4+PiDCoMKgwqDCoMKgwqAgKiBCcmluZyB1cCBh
biBlbmRwb2ludCB0byB0YXJnZXQgd2l0aCBNQ1RQIG92ZXIgVkRNLg0KPj4=

