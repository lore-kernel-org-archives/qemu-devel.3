Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46476C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 05:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdNoa-0001o2-Dp; Mon, 12 Aug 2024 01:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuping24@outlook.com>)
 id 1sdNoV-0001mk-Cf; Mon, 12 Aug 2024 01:41:51 -0400
Received: from mail-maxind01olkn20801.outbound.protection.outlook.com
 ([2a01:111:f403:281b::801]
 helo=IND01-MAX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuping24@outlook.com>)
 id 1sdNoP-0007nZ-RI; Mon, 12 Aug 2024 01:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqS72waBZTOG+1e/myY2Nw6bY7MjHydwdiHZwm/yo1WnmtY/sB2aMlZo+lnJKSR6j5M88M873vOEuw1KeJjG0onUd4OpwuyMmFoGiTAVvP3Gt/u2pO7Q/03lCwI7zwwKJx8MwYwTp71LMmlSKHiMsrvD8etb4MzpmGHnka14tMezIbdTfLm+aTmtukzYA0dYcILBrUkFR4TMb0poQ/+1x7UOeDM5Nx2y/CWSvrAOo8RHA1JKD7a3VDrAqO51Pycikck26Cin4+YigLrRvz8vJC8PAwS/2u4k/tgpKOH7xXoJ/W+fQLVHCJRjRx3uH83HaJbeeXnYyCV30JIZFNdRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+TUBDwzenCoiVNuuH5X9rpQva74QRGoTo0DBljvSAs=;
 b=B0W4qeEu7FBAZGlHUEu71/2BPUm59l1XGDJ+w/aGl9Vzn1heaOqIRYTQHA0R4mPe6ubeW+EGsJ5mIliLAEsKgYDEHQJG+UJQ0I0bKPnsBBPF2Bm8bWXeoYrOKQT68Jn9l5ehW1r5RCrqHNJQ/khjKU4iIjdst7gyAUvbl4zKKnsnYgWmtXJDFM4duP7t74NVCqDZp7edKWvwxlEuwjNeDe2gYL/JsfHZDXQ3dbGqqbe8ZmgA6MPVIWsbcMMgkfQTQEf1eOMXF61Q4DuQ0NW6XQ826yVogm0tU539aSPZuPmpIwS6LkRz0U5l26i6L8y1AZPGufH+a2xj0cwtAymU4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+TUBDwzenCoiVNuuH5X9rpQva74QRGoTo0DBljvSAs=;
 b=Q96gzgjtTpxQkcKlRK47yK75dpeWS9yPKb2eh12iAIDp8BSlT63lLmTph8V3wyOZ2Garq/+5z7WRZtXN00PdCxwcirqyToX8Q8fa3yBFwA4aUEOYGVUCjsJ7NwTdvTZNwdD3UQlj/qUiGonuBOqbliXpBwIlRMHkAeN5fgz4uhoyBeokBWNO08RcKcZ3dfmGBTcFbkF8KRTlkx1vas5zx4DJdo5GmBcg2PZDPFhu5sQDIEkS8QKUcf+R6kDl+cbDEbijQN8xqAEUjBifDVsxTeFy1Apph+P5cJoNrpSuiBnU7VddRLSfPXEkHMM/zi5G4oc+jxS3w0x/AgV/4nrbhQ==
Received: from PN2P287MB0414.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:118::14)
 by PN3P287MB0834.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:17b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 05:41:23 +0000
Received: from PN2P287MB0414.INDP287.PROD.OUTLOOK.COM
 ([fe80::42e:6c01:d988:a843]) by PN2P287MB0414.INDP287.PROD.OUTLOOK.COM
 ([fe80::42e:6c01:d988:a843%7]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 05:41:23 +0000
From: liu ping <liuping24@outlook.com>
To: Gavin Shan <gshan@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>
CC: "maz@kernel.org" <maz@kernel.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>, "david@redhat.com"
 <david@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "will@kernel.org"
 <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>, "miguel.luis@oracle.com"
 <miguel.luis@oracle.com>, "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 "zhukeqian1@huawei.com" <zhukeqian1@huawei.com>, "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "lixianglai@loongson.cn"
 <lixianglai@loongson.cn>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIFJGQyBWMyAwMi8yOV0gY3B1LWNvbW1vbjogQWRkIGNv?=
 =?gb2312?Q?mmon_CPU_utility_for_possible_vCPUs?=
Thread-Topic: [PATCH RFC V3 02/29] cpu-common: Add common CPU utility for
 possible vCPUs
Thread-Index: AQHa7HSj9Z6tGL4PEUyoYiQsabZvcbIjGy7V
Date: Mon, 12 Aug 2024 05:41:23 +0000
Message-ID: <PN2P287MB0414CF9DE5FACC5FCE9EB854BA852@PN2P287MB0414.INDP287.PROD.OUTLOOK.COM>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-3-salil.mehta@huawei.com>
 <8fcb7441-bb5c-4dd8-a9c2-9d73b6176240@redhat.com>
In-Reply-To: <8fcb7441-bb5c-4dd8-a9c2-9d73b6176240@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [Ou/QFKNm3GS1xyN+pJiwSB3FH5QBuDgS]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB0414:EE_|PN3P287MB0834:EE_
x-ms-office365-filtering-correlation-id: 9b85bfe8-1dcd-4800-2607-08dcba9166b4
x-microsoft-antispam: BCL:0;
 ARA:14566002|461199028|15030799003|15080799003|19110799003|8060799006|3430499032|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info: tJVVFlGg+kEECYoToWTR9wxorT36GSfcEGxPvrUy8wxtYNjYtRVeHSDApKY6EJIY6VJLmsYxH/d3UhIh5/nxztxvlVtZRgev27MkUxJQtl/2zrfXu/LIyw2k/+VRMYBPoM96UircFsdXO0Icpx+7ykUozwI+Xkv+FhovXOizlemTpFadhPLsIAsB3oZIY59Nq++AMwfWQAXr8slMt0HCLRozh9Iunwb1+e8gFZttIWaeeMaABKyzI8kZl1YJTJMKRzozjzFX0ftUrVf81JiTwgE+2t0o7VpFQTe4/3Zr/0EnrstoFk/TMjfowmzxEM03m+hzHuOG2FZ6WVTltu33JPDg+8a9asMbsQOQH5jdlGS7PPyb8D14q7B9oRzXcfO0iKWPX1KI8R7M05gHLBc/W5yt0JVNuz0b9UNPb5Ly8tF6NsNAHqLChjQ18nK8Sn8XnY/sFsyu+ut/sfr7YUiQOHuLlF3kQ7hohEh+JS93CUngqv9pYiDm4nP0ohgxi3pha6JyLi+o+9kpwTTrpvlt6gTUZcQKujNqLkSnjl4QCYDvxKUr9mV5MVHsnnmXpBwxbQfNeAnRV5W+yx+UrRbzVjvl1+nqJ7HvyE5w8hxhHgVOKrbG1AgXgqV/0pUW3GA8HuMPt4krm+CUPLd6eGF88tsprw3Tc+Xs6uEarSbr3e2NhL4w5tdfSJt7HUmUPxAV3Q11mt4G0i6z/UIZNvUccw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dkRkRkJlR1ZnUno3clp1VklkUk1xSTdLWE9Za1BqdFN1NVFPS1lUUXdDVElm?=
 =?gb2312?B?dWp1alE5S3lQZHRNaUhRSjI4TzhISmN0VEtVbHEyYWFhNjNPamxoQ0U5MWZO?=
 =?gb2312?B?SXBOczdqbDlNaFMremFIbEozaUZJejBkajdjK3dsclhlWHJuU1U1bk9rMG03?=
 =?gb2312?B?UEJYdEdEOUw0aGkzVTh3WDZZMDc2eVpucGFoOGRzODJHZ1hUblE1U2FZZmlw?=
 =?gb2312?B?endhbGJLZ1NwODRmZzlsWjNuZ2t6NENhUXJzaXg1TlVIa1g5MVVhL0U5Sk9i?=
 =?gb2312?B?ZUI1OE9hNjFLcmpwZVRVS3dYaU5qaHI2SVBINVd5RGRXY3pITDlLVkY2OFd1?=
 =?gb2312?B?TnIzbnU4dTk1SDV4NHlZMTVGRkNRYncrQkJ0NnNpbUJGTW54alEzOFdJUFJ6?=
 =?gb2312?B?alY4dzhWczB3TXdhek5qb09OSWhMazhWMXVrbG9WYzNuRnd3QVF1YjM3Wktm?=
 =?gb2312?B?WU81M21wWXNPMEdWb2N3bVNuS2srR2V5dDRWaVdVeUp0UVlqQStaaFBPVWps?=
 =?gb2312?B?TnpreDRhVDhteTdpRGM4UDRUN2JWUStOT0twZjBlbmRDUkRxaVFPbk9sc0Fh?=
 =?gb2312?B?bVQxNVZ2clNZenR4SExtZUNRUWZKL044Vno5akgrY2dILzMwNDQ5SURtWWhx?=
 =?gb2312?B?S2lvbjZ6UDhIN2ZzdzhoRm5KdUVQNCtsdFozNEZjVE1TYU0xQXlDcU84NEhY?=
 =?gb2312?B?MmtoL3JkdGRjS1h1L2xUdExuV3RjR2RMQWx4cG41UzVqMytjTkxUeTF6M1dG?=
 =?gb2312?B?citDbjFuaHRWUE85UWVKTXNsK2tLS1RYeTBPSlZKUVA0U2tTQTJiY1Z2YXBB?=
 =?gb2312?B?UlFUcC9pek1lSmFrTkFjdGQ0ZkZWRDVOYU9tRk9SaENHTXB3QUxDSGNJNjl1?=
 =?gb2312?B?eWJTb3B2aXFHSkErMHhyTDMwV1lHTmJQVFpSemU4RlJiWmloOTN4UHlwRjFu?=
 =?gb2312?B?TUFpUDBVVlBaZFEzUXQ3V2VhemRSTlZtU3czNGZ6b1hkaEVJM0F6dmYzUWRT?=
 =?gb2312?B?ZkVGL2p1SGlPWm5pUHRvaWFoZmF4VG9rTkNSSjFqdnRiNEsrS0hjRWZhNTV0?=
 =?gb2312?B?VmwvYmM2VGk3TkdISDJwVzdnUWV4ZjAxdFF5bFE0eDZXZ1J1b1RpWVVIcFZI?=
 =?gb2312?B?a3FGMmRxNmhKcisxSEFmZnZ5VUxtbFc0cEQzVWVheEdMMGEyZ1NUUklNUFVU?=
 =?gb2312?B?NjVyaDhuNytsS1UxQ1I1U21GYXorQUg3K0o5TnFqOXdobUROUlN2aGgzQkNE?=
 =?gb2312?B?UlJBYi9OYSsrcTQ0cDJEd2VaSmppbGIvSWhTLzl2ZTIxeFZEVGZUb1lCU3Rl?=
 =?gb2312?B?VGZIOW9NampQS3VYdFRFZFNCOExiTmF2eHQybmRrQXN5bXFvcUtKeHBuQWcy?=
 =?gb2312?B?VFhXUm5NNFZueDZyRVRaME9obXJlcTdINENyVU1wUUFGOFRWbDhOaUg4RGpp?=
 =?gb2312?B?Rzg0VDVLNnZpUEZuZktiVUxzVlhweElmZHFlbkE3aXlIUmtBa2ZZWGJnWE15?=
 =?gb2312?B?RUFSRit3azJpQmVvYWhaU0oxeTlCb1pjSW5mYzBCVU1md3VXaktkbXkrNXdL?=
 =?gb2312?B?WGNjUlkyVDc0VE1pVVBwOXlraU1NaFRrRlV5WDR1Tzh5b1FkaEorNXAzVVVq?=
 =?gb2312?B?bHF3VXBwT1RvUmhXNGNVU294WGt6OVE9PQ==?=
Content-Type: multipart/alternative;
 boundary="_000_PN2P287MB0414CF9DE5FACC5FCE9EB854BA852PN2P287MB0414INDP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB0414.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b85bfe8-1dcd-4800-2607-08dcba9166b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 05:41:23.5498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0834
Received-SPF: pass client-ip=2a01:111:f403:281b::801;
 envelope-from=liuping24@outlook.com;
 helo=IND01-MAX-obe.outbound.protection.outlook.com
X-Spam_score_int: 38
X-Spam_score: 3.8
X-Spam_bar: +++
X-Spam_report: (3.8 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--_000_PN2P287MB0414CF9DE5FACC5FCE9EB854BA852PN2P287MB0414INDP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

dW5zdWJzY3JpYmUNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IHFl
bXUtZGV2ZWwtYm91bmNlcytsaXVwaW5nMjQ9b3V0bG9vay5jb21Abm9uZ251Lm9yZyA8cWVtdS1k
ZXZlbC1ib3VuY2VzK2xpdXBpbmcyND1vdXRsb29rLmNvbUBub25nbnUub3JnPiC0+rHtIEdhdmlu
IFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+DQq3osvNyrG85DogMjAyNMTqONTCMTHI1SAyMTo1OQ0K
ytW8/sjLOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgcWVtdS1hcm1Abm9uZ251Lm9yZyA8
cWVtdS1hcm1Abm9uZ251Lm9yZz47IG1zdEByZWRoYXQuY29tIDxtc3RAcmVkaGF0LmNvbT4NCrOt
y806IG1hekBrZXJuZWwub3JnIDxtYXpAa2VybmVsLm9yZz47IGplYW4tcGhpbGlwcGVAbGluYXJv
Lm9yZyA8amVhbi1waGlsaXBwZUBsaW5hcm8ub3JnPjsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWku
Y29tIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmcg
PGxwaWVyYWxpc2lAa2VybmVsLm9yZz47IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZyA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPjsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyA8cmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IGltYW1tZWRvQHJlZGhhdC5jb20gPGltYW1tZWRvQHJl
ZGhhdC5jb20+OyBhbmRyZXcuam9uZXNAbGludXguZGV2IDxhbmRyZXcuam9uZXNAbGludXguZGV2
PjsgZGF2aWRAcmVkaGF0LmNvbSA8ZGF2aWRAcmVkaGF0LmNvbT47IHBoaWxtZEBsaW5hcm8ub3Jn
IDxwaGlsbWRAbGluYXJvLm9yZz47IGVyaWMuYXVnZXJAcmVkaGF0LmNvbSA8ZXJpYy5hdWdlckBy
ZWRoYXQuY29tPjsgd2lsbEBrZXJuZWwub3JnIDx3aWxsQGtlcm5lbC5vcmc+OyBhcmRiQGtlcm5l
bC5vcmcgPGFyZGJAa2VybmVsLm9yZz47IG9saXZlci51cHRvbkBsaW51eC5kZXYgPG9saXZlci51
cHRvbkBsaW51eC5kZXY+OyBwYm9uemluaUByZWRoYXQuY29tIDxwYm9uemluaUByZWRoYXQuY29t
PjsgcmFmYWVsQGtlcm5lbC5vcmcgPHJhZmFlbEBrZXJuZWwub3JnPjsgYm9ybnRyYWVnZXJAbGlu
dXguaWJtLmNvbSA8Ym9ybnRyYWVnZXJAbGludXguaWJtLmNvbT47IGFsZXguYmVubmVlQGxpbmFy
by5vcmcgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBucGlnZ2luQGdtYWlsLmNvbSA8bnBpZ2dp
bkBnbWFpbC5jb20+OyBoYXJzaHBiQGxpbnV4LmlibS5jb20gPGhhcnNocGJAbGludXguaWJtLmNv
bT47IGxpbnV4QGFybWxpbnV4Lm9yZy51ayA8bGludXhAYXJtbGludXgub3JnLnVrPjsgZGFycmVu
QG9zLmFtcGVyZWNvbXB1dGluZy5jb20gPGRhcnJlbkBvcy5hbXBlcmVjb21wdXRpbmcuY29tPjsg
aWxra2FAb3MuYW1wZXJlY29tcHV0aW5nLmNvbSA8aWxra2FAb3MuYW1wZXJlY29tcHV0aW5nLmNv
bT47IHZpc2hudUBvcy5hbXBlcmVjb21wdXRpbmcuY29tIDx2aXNobnVAb3MuYW1wZXJlY29tcHV0
aW5nLmNvbT47IGthcmwuaGV1YmF1bUBvcmFjbGUuY29tIDxrYXJsLmhldWJhdW1Ab3JhY2xlLmNv
bT47IG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20gPG1pZ3VlbC5sdWlzQG9yYWNsZS5jb20+OyBzYWxp
bC5tZWh0YUBvcG5zcmMubmV0IDxzYWxpbC5tZWh0YUBvcG5zcmMubmV0Pjsgemh1a2VxaWFuMUBo
dWF3ZWkuY29tIDx6aHVrZXFpYW4xQGh1YXdlaS5jb20+OyB3YW5neGlvbmdmZW5nMkBodWF3ZWku
Y29tIDx3YW5neGlvbmdmZW5nMkBodWF3ZWkuY29tPjsgd2FuZ3lhbmFuNTVAaHVhd2VpLmNvbSA8
d2FuZ3lhbmFuNTVAaHVhd2VpLmNvbT47IGppYWtlcm5lbDJAZ21haWwuY29tIDxqaWFrZXJuZWwy
QGdtYWlsLmNvbT47IG1hb2JpYm9AbG9vbmdzb24uY24gPG1hb2JpYm9AbG9vbmdzb24uY24+OyBs
aXhpYW5nbGFpQGxvb25nc29uLmNuIDxsaXhpYW5nbGFpQGxvb25nc29uLmNuPjsgc2hhaHVhbmdA
cmVkaGF0LmNvbSA8c2hhaHVhbmdAcmVkaGF0LmNvbT47IHpoYW8xLmxpdUBpbnRlbC5jb20gPHpo
YW8xLmxpdUBpbnRlbC5jb20+OyBsaW51eGFybUBodWF3ZWkuY29tIDxsaW51eGFybUBodWF3ZWku
Y29tPg0K1vfM4jogUmU6IFtQQVRDSCBSRkMgVjMgMDIvMjldIGNwdS1jb21tb246IEFkZCBjb21t
b24gQ1BVIHV0aWxpdHkgZm9yIHBvc3NpYmxlIHZDUFVzDQoNCk9uIDYvMTQvMjQgOTozNiBBTSwg
U2FsaWwgTWVodGEgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggYWRkcyB2YXJpb3VzIHV0aWxpdHkgZnVu
Y3Rpb25zIHRoYXQgbWF5IGJlIHJlcXVpcmVkIHRvIGZldGNoIG9yIGNoZWNrDQo+IHRoZSBzdGF0
ZSBvZiBwb3NzaWJsZSB2Q1BVcy4gSXQgYWxzbyBpbnRyb2R1Y2VzIHRoZSBjb25jZXB0IG9mICpk
aXNhYmxlZCogdkNQVXMsDQo+IHdoaWNoIGFyZSBwYXJ0IG9mIHRoZSAqcG9zc2libGUqIHZDUFVz
IGJ1dCBhcmUgbm90IGVuYWJsZWQuIFRoaXMgc3RhdGUgd2lsbCBiZQ0KPiB1c2VkIGR1cmluZyBt
YWNoaW5lIGluaXRpYWxpemF0aW9uIGFuZCBsYXRlciBkdXJpbmcgdGhlIHBsdWdnaW5nIG9yIHVu
cGx1Z2dpbmcNCj4gb2YgdkNQVXMuIFdlIHJlbGVhc2UgdGhlIFFPTSBDUFUgb2JqZWN0cyBmb3Ig
YWxsIGRpc2FibGVkIHZDUFVzLg0KPg0KPiBDby1kZXZlbG9wZWQtYnk6IEtlcWlhbiBaaHUgPHpo
dWtlcWlhbjFAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogS2VxaWFuIFpodSA8emh1a2Vx
aWFuMUBodWF3ZWkuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWxpbCBNZWh0YSA8c2FsaWwubWVo
dGFAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICAgY3B1LWNvbW1vbi5jICAgICAgICAgIHwgMzEgKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvaHcvY29yZS9jcHUuaCB8IDU0ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDg1IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2NwdS1jb21tb24uYyBi
L2NwdS1jb21tb24uYw0KPiBpbmRleCBjZTc4MjczYWY1Li40OWQyYTUwODM1IDEwMDY0NA0KPiAt
LS0gYS9jcHUtY29tbW9uLmMNCj4gKysrIGIvY3B1LWNvbW1vbi5jDQo+IEBAIC0yNCw2ICsyNCw3
IEBADQo+ICAgI2luY2x1ZGUgInN5c2VtdS9jcHVzLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvbG9j
a2FibGUuaCINCj4gICAjaW5jbHVkZSAidHJhY2UvdHJhY2Utcm9vdC5oIg0KPiArI2luY2x1ZGUg
Imh3L2JvYXJkcy5oIg0KPg0KPiAgIFFlbXVNdXRleCBxZW11X2NwdV9saXN0X2xvY2s7DQo+ICAg
c3RhdGljIFFlbXVDb25kIGV4Y2x1c2l2ZV9jb25kOw0KPiBAQCAtMTA3LDYgKzEwOCwzNiBAQCB2
b2lkIGNwdV9saXN0X3JlbW92ZShDUFVTdGF0ZSAqY3B1KQ0KPiAgICAgICBjcHVfbGlzdF9nZW5l
cmF0aW9uX2lkKys7DQo+ICAgfQ0KPg0KPiArQ1BVU3RhdGUgKnFlbXVfZ2V0X3Bvc3NpYmxlX2Nw
dShpbnQgaW5kZXgpDQo+ICt7DQo+ICsgICAgTWFjaGluZVN0YXRlICptcyA9IE1BQ0hJTkUocWRl
dl9nZXRfbWFjaGluZSgpKTsNCj4gKyAgICBjb25zdCBDUFVBcmNoSWRMaXN0ICpwb3NzaWJsZV9j
cHVzID0gbXMtPnBvc3NpYmxlX2NwdXM7DQo+ICsNCj4gKyAgICBhc3NlcnQoKGluZGV4ID49IDAp
ICYmIChpbmRleCA8IHBvc3NpYmxlX2NwdXMtPmxlbikpOw0KPiArDQo+ICsgICAgcmV0dXJuIENQ
VShwb3NzaWJsZV9jcHVzLT5jcHVzW2luZGV4XS5jcHUpOw0KPiArfQ0KPiArDQo+ICtib29sIHFl
bXVfcHJlc2VudF9jcHUoQ1BVU3RhdGUgKmNwdSkNCj4gK3sNCj4gKyAgICByZXR1cm4gY3B1Ow0K
PiArfQ0KPiArDQo+ICtib29sIHFlbXVfZW5hYmxlZF9jcHUoQ1BVU3RhdGUgKmNwdSkNCj4gK3sN
Cj4gKyAgICByZXR1cm4gY3B1ICYmICFjcHUtPmRpc2FibGVkOw0KPiArfQ0KPiArDQo+ICt1aW50
NjRfdCBxZW11X2dldF9jcHVfYXJjaGlkKGludCBjcHVfaW5kZXgpDQo+ICt7DQo+ICsgICAgTWFj
aGluZVN0YXRlICptcyA9IE1BQ0hJTkUocWRldl9nZXRfbWFjaGluZSgpKTsNCj4gKyAgICBjb25z
dCBDUFVBcmNoSWRMaXN0ICpwb3NzaWJsZV9jcHVzID0gbXMtPnBvc3NpYmxlX2NwdXM7DQo+ICsN
Cj4gKyAgICBhc3NlcnQoKGNwdV9pbmRleCA+PSAwKSAmJiAoY3B1X2luZGV4IDwgcG9zc2libGVf
Y3B1cy0+bGVuKSk7DQo+ICsNCj4gKyAgICByZXR1cm4gcG9zc2libGVfY3B1cy0+Y3B1c1tjcHVf
aW5kZXhdLmFyY2hfaWQ7DQo+ICt9DQo+ICsNCj4gICBDUFVTdGF0ZSAqcWVtdV9nZXRfY3B1KGlu
dCBpbmRleCkNCj4gICB7DQo+ICAgICAgIENQVVN0YXRlICpjcHU7DQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L2NvcmUvY3B1LmggYi9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4gaW5kZXggNjBi
MTYwZDBiNC4uNjBiNDc3OGRhOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9ody9jb3JlL2NwdS5o
DQo+ICsrKyBiL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0KPiBAQCAtNTI4LDYgKzUyOCwxOCBAQCBz
dHJ1Y3QgQ1BVU3RhdGUgew0KPiAgICAgICBDUFVQbHVnaW5TdGF0ZSAqcGx1Z2luX3N0YXRlOw0K
PiAgICNlbmRpZg0KPg0KPiArICAgIC8qDQo+ICsgICAgICogU29tZSBhcmNoaXRlY3R1cmVzIGRv
IG5vdCBhbGxvdyB0aGUgKnByZXNlbmNlKiBvZiB2Q1BVcyB0byBiZSBjaGFuZ2VkDQo+ICsgICAg
ICogYWZ0ZXIgdGhlIGd1ZXN0IGhhcyBib290ZWQsIGJhc2VkIG9uIGluZm9ybWF0aW9uIHNwZWNp
ZmllZCBieSB0aGUNCj4gKyAgICAgKiBWTU0vZmlybXdhcmUgdmlhIEFDUEkgTUFEVCBhdCBib290
IHRpbWUuIFRodXMsIHRvIGVuYWJsZSB2Q1BVIGhvdHBsdWcgb24NCj4gKyAgICAgKiB0aGVzZSBh
cmNoaXRlY3R1cmVzLCBwb3NzaWJsZSB2Q1BVcyBjYW4gaGF2ZSBhIENQVVN0YXRlIG9iamVjdCBp
biBhDQo+ICsgICAgICogJ2Rpc2FibGVkJyBzdGF0ZSBvciBtYXkgbm90IGhhdmUgYSBDUFVTdGF0
ZSBvYmplY3QgYXQgYWxsLiBUaGlzIGlzDQo+ICsgICAgICogcG9zc2libGUgd2hlbiB2Q1BVIGhv
dHBsdWcgaXMgc3VwcG9ydGVkLCBhbmQgdkNQVXMgYXJlDQo+ICsgICAgICogJ3lldC10by1iZS1w
bHVnZ2VkJyBpbiB0aGUgUU9NIG9yIGhhdmUgYmVlbiBob3QtdW5wbHVnZ2VkLiBCeSBkZWZhdWx0
LA0KPiArICAgICAqIGV2ZXJ5IENQVVN0YXRlIGlzIGVuYWJsZWQgYWNyb3NzIGFsbCBhcmNoaXRl
Y3R1cmVzLg0KPiArICAgICAqLw0KPiArICAgIGJvb2wgZGlzYWJsZWQ7DQo+ICsNCg0KVGhlIGlu
Zm9ybWF0aW9uIHRvIGRldGVybWluZSB2Q1BVJ3Mgc3RhdGUgaGFzIGJlZW4gZGlzdHJpYnV0ZWQg
dG8gdHdvIGRhdGEgc3RydWN0czoNCk1hY2hpbmVTdGF0ZTo6cG9zc2libGVfY3B1czo6Y3B1c1td
IGFuZCBDUFVTdGF0ZS4gV2h5IG5vdCBqdXN0IHRvIG1haW50YWluIHRoZSB2Q1BVJ3MNCnN0YXRl
IGZyb20gTWFjaGluZVN0YXRlOjpwb3NzaWJsZV9jcHVzOjpjcHVzW10/IEZvciBleGFtcGxlLCBh
ZGRpbmcgYSBuZXcgZmllbGQsIG9yDQpzb21ldGhpbmcgc2ltaWxpYXIsIHRvICdzdHJ1Y3QgQ1BV
QXJjaElkJyBhcyBiZWxvdy4NCg0KdHlwZWRlZiBzdHJ1Y3QgQ1BVQXJjaElkIHsNCiNkZWZpbmUg
Q1BVX0FSQ0hfSURfRkxBR19QUkVTRU5UICAgICAgICAoMSA8PCAwKQ0KI2RlZmluZSBDUFVfQVJD
SF9JRF9GTEFHX0VOQUJMRUQgICAgICAgICgxIDw8IDEpDQogICAgIHVpbnQzMl90IGZsYWdzOw0K
ICAgICAgICA6DQp9IENQVUFyY2hJZDsNCg0KSW4gb3JkZXIgdG8gZGV0ZXJtaW5lIGlmIGEgQ1BV
U3RhdGUgaW5zdGFuY2UgaXMgZW5hYmxlZCBvciBub3QuIENQVVN0YXRlOjpjcHVfaW5kZXgNCmlz
IHVzZWQgYXMgdGhlIGluZGV4IHRvIE1hY2hpbmVTdGF0ZTo6cG9zc2libGVfY3B1czo6Y3B1c1td
LiBUaGUgZmxhZ3MgY2FuIGJlIHBhcnNlZA0KdG8gZGV0ZXJtaW5lIHRoZSB2Q1BVJ3Mgc3RhdGUu
DQoNCj4gICAgICAgLyogVE9ETyBNb3ZlIGNvbW1vbiBmaWVsZHMgZnJvbSBDUFVBcmNoU3RhdGUg
aGVyZS4gKi8NCj4gICAgICAgaW50IGNwdV9pbmRleDsNCj4gICAgICAgaW50IGNsdXN0ZXJfaW5k
ZXg7DQo+IEBAIC05MTQsNiArOTI2LDQ4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBjcHVfaW5fZXhj
bHVzaXZlX2NvbnRleHQoY29uc3QgQ1BVU3RhdGUgKmNwdSkNCj4gICAgKi8NCj4gICBDUFVTdGF0
ZSAqcWVtdV9nZXRfY3B1KGludCBpbmRleCk7DQo+DQo+ICsvKioNCj4gKyAqIHFlbXVfZ2V0X3Bv
c3NpYmxlX2NwdToNCj4gKyAqIEBpbmRleDogVGhlIENQVVN0YXRlQGNwdV9pbmRleCB2YWx1ZSBv
ZiB0aGUgQ1BVIHRvIG9idGFpbi4NCj4gKyAqICAgICAgICAgSW5wdXQgaW5kZXggTVVTVCBiZSBp
biByYW5nZSBbMCwgTWF4IFBvc3NpYmxlIENQVXMpDQo+ICsgKg0KPiArICogSWYgQ1BVU3RhdGUg
b2JqZWN0IGV4aXN0cyx0aGVuIGl0IGdldHMgYSBDUFUgbWF0Y2hpbmcNCj4gKyAqIEBpbmRleCBp
biB0aGUgcG9zc2libGUgQ1BVIGFycmF5Lg0KPiArICoNCj4gKyAqIFJldHVybnM6IFRoZSBwb3Nz
aWJsZSBDUFUgb3IgJU5VTEwgaWYgQ1BVIGRvZXMgbm90IGV4aXN0Lg0KPiArICovDQo+ICtDUFVT
dGF0ZSAqcWVtdV9nZXRfcG9zc2libGVfY3B1KGludCBpbmRleCk7DQo+ICsNCj4gKy8qKg0KPiAr
ICogcWVtdV9wcmVzZW50X2NwdToNCj4gKyAqIEBjcHU6IFRoZSB2Q1BVIHRvIGNoZWNrDQo+ICsg
Kg0KPiArICogQ2hlY2tzIGlmIHRoZSB2Q1BVIGlzIGFtb25nc3QgdGhlIHByZXNlbnQgcG9zc2li
bGUgdmNwdXMuDQo+ICsgKg0KPiArICogUmV0dXJuczogVHJ1ZSBpZiBpdCBpcyBwcmVzZW50IHBv
c3NpYmxlIHZDUFUgZWxzZSBmYWxzZQ0KPiArICovDQo+ICtib29sIHFlbXVfcHJlc2VudF9jcHUo
Q1BVU3RhdGUgKmNwdSk7DQo+ICsNCj4gKy8qKg0KPiArICogcWVtdV9lbmFibGVkX2NwdToNCj4g
KyAqIEBjcHU6IFRoZSB2Q1BVIHRvIGNoZWNrDQo+ICsgKg0KPiArICogQ2hlY2tzIGlmIHRoZSB2
Q1BVIGlzIGVuYWJsZWQuDQo+ICsgKg0KPiArICogUmV0dXJuczogVHJ1ZSBpZiBpdCBpcyAnZW5h
YmxlZCcgZWxzZSBmYWxzZQ0KPiArICovDQo+ICtib29sIHFlbXVfZW5hYmxlZF9jcHUoQ1BVU3Rh
dGUgKmNwdSk7DQo+ICsNCj4gKy8qKg0KPiArICogcWVtdV9nZXRfY3B1X2FyY2hpZDoNCj4gKyAq
IEBjcHVfaW5kZXg6IHBvc3NpYmxlIHZDUFUgZm9yIHdoaWNoIGFyY2gtaWQgbmVlZHMgdG8gYmUg
cmV0cmVpdmVkDQo+ICsgKg0KPiArICogRmV0Y2hlcyB0aGUgdkNQVSBhcmNoLWlkIGZyb20gdGhl
IHByZXNlbnQgcG9zc2libGUgdkNQVXMuDQo+ICsgKg0KPiArICogUmV0dXJuczogYXJjaC1pZCBv
ZiB0aGUgcG9zc2libGUgdkNQVQ0KPiArICovDQo+ICt1aW50NjRfdCBxZW11X2dldF9jcHVfYXJj
aGlkKGludCBjcHVfaW5kZXgpOw0KPiArDQo+ICAgLyoqDQo+ICAgICogY3B1X2V4aXN0czoNCj4g
ICAgKiBAaWQ6IEd1ZXN0LWV4cG9zZWQgQ1BVIElEIHRvIGxvb2t1cC4NCg0KVGhhbmtzLA0KR2F2
aW4NCg0KDQo=

--_000_PN2P287MB0414CF9DE5FACC5FCE9EB854BA852PN2P287MB0414INDP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
unsubscribe</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> qemu-de=
vel-bounces+liuping24=3Doutlook.com@nongnu.org &lt;qemu-devel-bounces+liupi=
ng24=3Doutlook.com@nongnu.org&gt; =B4=FA=B1=ED Gavin Shan &lt;gshan@redhat.=
com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2024=C4=EA8=D4=C211=C8=D5 21:59<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Salil Mehta &lt;salil.mehta@huawei.com&gt;; qemu=
-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; qemu-arm@nongnu.org &lt;qe=
mu-arm@nongnu.org&gt;; mst@redhat.com &lt;mst@redhat.com&gt;<br>
<b>=B3=AD=CB=CD:</b> maz@kernel.org &lt;maz@kernel.org&gt;; jean-philippe@l=
inaro.org &lt;jean-philippe@linaro.org&gt;; jonathan.cameron@huawei.com &lt=
;jonathan.cameron@huawei.com&gt;; lpieralisi@kernel.org &lt;lpieralisi@kern=
el.org&gt;; peter.maydell@linaro.org &lt;peter.maydell@linaro.org&gt;; rich=
ard.henderson@linaro.org
 &lt;richard.henderson@linaro.org&gt;; imammedo@redhat.com &lt;imammedo@red=
hat.com&gt;; andrew.jones@linux.dev &lt;andrew.jones@linux.dev&gt;; david@r=
edhat.com &lt;david@redhat.com&gt;; philmd@linaro.org &lt;philmd@linaro.org=
&gt;; eric.auger@redhat.com &lt;eric.auger@redhat.com&gt;; will@kernel.org
 &lt;will@kernel.org&gt;; ardb@kernel.org &lt;ardb@kernel.org&gt;; oliver.u=
pton@linux.dev &lt;oliver.upton@linux.dev&gt;; pbonzini@redhat.com &lt;pbon=
zini@redhat.com&gt;; rafael@kernel.org &lt;rafael@kernel.org&gt;; borntraeg=
er@linux.ibm.com &lt;borntraeger@linux.ibm.com&gt;; alex.bennee@linaro.org
 &lt;alex.bennee@linaro.org&gt;; npiggin@gmail.com &lt;npiggin@gmail.com&gt=
;; harshpb@linux.ibm.com &lt;harshpb@linux.ibm.com&gt;; linux@armlinux.org.=
uk &lt;linux@armlinux.org.uk&gt;; darren@os.amperecomputing.com &lt;darren@=
os.amperecomputing.com&gt;; ilkka@os.amperecomputing.com &lt;ilkka@os.amper=
ecomputing.com&gt;;
 vishnu@os.amperecomputing.com &lt;vishnu@os.amperecomputing.com&gt;; karl.=
heubaum@oracle.com &lt;karl.heubaum@oracle.com&gt;; miguel.luis@oracle.com =
&lt;miguel.luis@oracle.com&gt;; salil.mehta@opnsrc.net &lt;salil.mehta@opns=
rc.net&gt;; zhukeqian1@huawei.com &lt;zhukeqian1@huawei.com&gt;;
 wangxiongfeng2@huawei.com &lt;wangxiongfeng2@huawei.com&gt;; wangyanan55@h=
uawei.com &lt;wangyanan55@huawei.com&gt;; jiakernel2@gmail.com &lt;jiakerne=
l2@gmail.com&gt;; maobibo@loongson.cn &lt;maobibo@loongson.cn&gt;; lixiangl=
ai@loongson.cn &lt;lixianglai@loongson.cn&gt;; shahuang@redhat.com
 &lt;shahuang@redhat.com&gt;; zhao1.liu@intel.com &lt;zhao1.liu@intel.com&g=
t;; linuxarm@huawei.com &lt;linuxarm@huawei.com&gt;<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH RFC V3 02/29] cpu-common: Add common CPU ut=
ility for possible vCPUs</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 6/14/24 9:36 AM, Salil Mehta wrote:<br>
&gt; This patch adds various utility functions that may be required to fetc=
h or check<br>
&gt; the state of possible vCPUs. It also introduces the concept of *disabl=
ed* vCPUs,<br>
&gt; which are part of the *possible* vCPUs but are not enabled. This state=
 will be<br>
&gt; used during machine initialization and later during the plugging or un=
plugging<br>
&gt; of vCPUs. We release the QOM CPU objects for all disabled vCPUs.<br>
&gt; <br>
&gt; Co-developed-by: Keqian Zhu &lt;zhukeqian1@huawei.com&gt;<br>
&gt; Signed-off-by: Keqian Zhu &lt;zhukeqian1@huawei.com&gt;<br>
&gt; Signed-off-by: Salil Mehta &lt;salil.mehta@huawei.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; cpu-common.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 31 +++++++++++++++++++++++++<br>
&gt;&nbsp;&nbsp; include/hw/core/cpu.h | 54 +++++++++++++++++++++++++++++++=
++++++++++++<br>
&gt;&nbsp;&nbsp; 2 files changed, 85 insertions(+)<br>
&gt; <br>
&gt; diff --git a/cpu-common.c b/cpu-common.c<br>
&gt; index ce78273af5..49d2a50835 100644<br>
&gt; --- a/cpu-common.c<br>
&gt; +++ b/cpu-common.c<br>
&gt; @@ -24,6 +24,7 @@<br>
&gt;&nbsp;&nbsp; #include &quot;sysemu/cpus.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;qemu/lockable.h&quot;<br>
&gt;&nbsp;&nbsp; #include &quot;trace/trace-root.h&quot;<br>
&gt; +#include &quot;hw/boards.h&quot;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; QemuMutex qemu_cpu_list_lock;<br>
&gt;&nbsp;&nbsp; static QemuCond exclusive_cond;<br>
&gt; @@ -107,6 +108,36 @@ void cpu_list_remove(CPUState *cpu)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_list_generation_id++;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; +CPUState *qemu_get_possible_cpu(int index)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; MachineState *ms =3D MACHINE(qdev_get_machine());<=
br>
&gt; +&nbsp;&nbsp;&nbsp; const CPUArchIdList *possible_cpus =3D ms-&gt;poss=
ible_cpus;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; assert((index &gt;=3D 0) &amp;&amp; (index &lt; po=
ssible_cpus-&gt;len));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; return CPU(possible_cpus-&gt;cpus[index].cpu);<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_present_cpu(CPUState *cpu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; return cpu;<br>
&gt; +}<br>
&gt; +<br>
&gt; +bool qemu_enabled_cpu(CPUState *cpu)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; return cpu &amp;&amp; !cpu-&gt;disabled;<br>
&gt; +}<br>
&gt; +<br>
&gt; +uint64_t qemu_get_cpu_archid(int cpu_index)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; MachineState *ms =3D MACHINE(qdev_get_machine());<=
br>
&gt; +&nbsp;&nbsp;&nbsp; const CPUArchIdList *possible_cpus =3D ms-&gt;poss=
ible_cpus;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; assert((cpu_index &gt;=3D 0) &amp;&amp; (cpu_index=
 &lt; possible_cpus-&gt;len));<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; return possible_cpus-&gt;cpus[cpu_index].arch_id;<=
br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp;&nbsp; CPUState *qemu_get_cpu(int index)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPUState *cpu;<br>
&gt; diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h<br>
&gt; index 60b160d0b4..60b4778da9 100644<br>
&gt; --- a/include/hw/core/cpu.h<br>
&gt; +++ b/include/hw/core/cpu.h<br>
&gt; @@ -528,6 +528,18 @@ struct CPUState {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPUPluginState *plugin_state;<br>
&gt;&nbsp;&nbsp; #endif<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * Some architectures do not allow the *prese=
nce* of vCPUs to be changed<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * after the guest has booted, based on infor=
mation specified by the<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * VMM/firmware via ACPI MADT at boot time. T=
hus, to enable vCPU hotplug on<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * these architectures, possible vCPUs can ha=
ve a CPUState object in a<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * 'disabled' state or may not have a CPUStat=
e object at all. This is<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * possible when vCPU hotplug is supported, a=
nd vCPUs are<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * 'yet-to-be-plugged' in the QOM or have bee=
n hot-unplugged. By default,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * every CPUState is enabled across all archi=
tectures.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp; bool disabled;<br>
&gt; +<br>
<br>
The information to determine vCPU's state has been distributed to two data =
structs:<br>
MachineState::possible_cpus::cpus[] and CPUState. Why not just to maintain =
the vCPU's<br>
state from MachineState::possible_cpus::cpus[]? For example, adding a new f=
ield, or<br>
something similiar, to 'struct CPUArchId' as below.<br>
<br>
typedef struct CPUArchId {<br>
#define CPU_ARCH_ID_FLAG_PRESENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(1 &lt;&lt; 0)<br>
#define CPU_ARCH_ID_FLAG_ENABLED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(1 &lt;&lt; 1)<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :<br>
} CPUArchId;<br>
<br>
In order to determine if a CPUState instance is enabled or not. CPUState::c=
pu_index<br>
is used as the index to MachineState::possible_cpus::cpus[]. The flags can =
be parsed<br>
to determine the vCPU's state.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* TODO Move common fields from CP=
UArchState here. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cpu_index;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int cluster_index;<br>
&gt; @@ -914,6 +926,48 @@ static inline bool cpu_in_exclusive_context(const=
 CPUState *cpu)<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp; CPUState *qemu_get_cpu(int index);<br>
&gt;&nbsp;&nbsp; <br>
&gt; +/**<br>
&gt; + * qemu_get_possible_cpu:<br>
&gt; + * @index: The CPUState@cpu_index value of the CPU to obtain.<br>
&gt; + *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Input index MUST b=
e in range [0, Max Possible CPUs)<br>
&gt; + *<br>
&gt; + * If CPUState object exists,then it gets a CPU matching<br>
&gt; + * @index in the possible CPU array.<br>
&gt; + *<br>
&gt; + * Returns: The possible CPU or %NULL if CPU does not exist.<br>
&gt; + */<br>
&gt; +CPUState *qemu_get_possible_cpu(int index);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * qemu_present_cpu:<br>
&gt; + * @cpu: The vCPU to check<br>
&gt; + *<br>
&gt; + * Checks if the vCPU is amongst the present possible vcpus.<br>
&gt; + *<br>
&gt; + * Returns: True if it is present possible vCPU else false<br>
&gt; + */<br>
&gt; +bool qemu_present_cpu(CPUState *cpu);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * qemu_enabled_cpu:<br>
&gt; + * @cpu: The vCPU to check<br>
&gt; + *<br>
&gt; + * Checks if the vCPU is enabled.<br>
&gt; + *<br>
&gt; + * Returns: True if it is 'enabled' else false<br>
&gt; + */<br>
&gt; +bool qemu_enabled_cpu(CPUState *cpu);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * qemu_get_cpu_archid:<br>
&gt; + * @cpu_index: possible vCPU for which arch-id needs to be retreived<=
br>
&gt; + *<br>
&gt; + * Fetches the vCPU arch-id from the present possible vCPUs.<br>
&gt; + *<br>
&gt; + * Returns: arch-id of the possible vCPU<br>
&gt; + */<br>
&gt; +uint64_t qemu_get_cpu_archid(int cpu_index);<br>
&gt; +<br>
&gt;&nbsp;&nbsp; /**<br>
&gt;&nbsp;&nbsp;&nbsp; * cpu_exists:<br>
&gt;&nbsp;&nbsp;&nbsp; * @id: Guest-exposed CPU ID to lookup.<br>
<br>
Thanks,<br>
Gavin<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PN2P287MB0414CF9DE5FACC5FCE9EB854BA852PN2P287MB0414INDP_--

