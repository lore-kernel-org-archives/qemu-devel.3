Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBF7F436AE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkVb-0004um-9x; Fri, 17 Apr 2026 10:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVZ-0004t0-Cn; Fri, 17 Apr 2026 10:49:25 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDkVX-0007DI-3w; Fri, 17 Apr 2026 10:49:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N4NalR/flrCpkuD1Fw9k7eA3bJ1kQ79CIHWSHIRuLkzmT+VIf8VFjv7QUpEBAl9j9KOmKU3g0ZvFnjhiMFI+WZk0HDHX57VDKvZ5sq5d+qJHpZzjkFkgcWoliPc6mTJ7cnfHDEvROKV9sPi7SNJijrID3gNM+OG6WH1IIl5iQVXb6bJU8qr4usZ+5/4oWqf7xqrFYr4xk31ffy8M8ncuS0XeR3NcBUsvwAVu3gr/PSiTBcja9GKxYautq784e0nG498QqPe+5RWlDRrjJMSR4DJXrHUNW/faMC0nvZVr8XFkez9FuDl8P60AxIX+hmvKFoKZ2Z7VQiTD6vijY+UGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLAw7E1uzOHIJoqM0jhNr6YgtQVVa/bzupNMV5yl6HM=;
 b=wZb85LgMYWSaq6rk4fOwYG1QI7IPisjaCWh6yMmZa+y4KA5EPLG/QN30FrfwANRvc3cXe4F5iEJJQKyOUAMe/dNm1rgr4fnvmqSzJ8kdh+G535W8emoMy8FEr2FYn6uynR6sVnCijl9yBT7MUsj6RHNbIbLRzKqm2W0ztjWWLevKHL8/TaC2VGuLu3pvr4XdGw6i38yD/hSTECRFoqL31yP2N2qSkA/3sPR73BIucs95JFObKPqxpLvRV7kZVnGvoQNGydQo/iPNgUP3rUA7NpYYoPsZ8G02wsu4kQUAC6917khGdLqr37c5ZJ6a8aVgP13Ykj4PDnHxxeqsrpEDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLAw7E1uzOHIJoqM0jhNr6YgtQVVa/bzupNMV5yl6HM=;
 b=u+cuk7TLkRFyEOoqiML3wLG6fWAouXDIxD846W36apoM+MS8yBd0w0xBJV+2A66J2CM4hwbPpElEnuY8KW9A78+/UD1vHUO0pl9OjM34R4CHBnaXJQNsyj/2Bgf7wDA/RtXAcoAU1h4V+BEqlKaEqvovep7CGCfxa04u5rz7Ib4cc3BPJQZJpmKfvOdje1GaCHfzEpSlNR3lZHdsopoV0q8m1ZECW0B8MQvlrOppX7N4afsdQyh+0cQQw2waCQAT7s173wqhgvqncQeutzKdQEmj8EMSpuom40h/2DFxmX7pPtvpTIyRb8Oy0+i44sLQHzjYbEkKLdrdlnycOI4HJA==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by VI0PR09MB8150.eurprd09.prod.outlook.com (2603:10a6:800:2ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:49:12 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 14:49:12 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v8 0/7] Add RISC-V big-endian target support
Thread-Topic: [PATCH v8 0/7] Add RISC-V big-endian target support
Thread-Index: AQHcznlapgkVN1gNu0qfz0cstgIj0A==
Date: Fri, 17 Apr 2026 14:49:12 +0000
Message-ID: <20260417144905.178056-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|VI0PR09MB8150:EE_
x-ms-office365-filtering-correlation-id: 25633a07-dd28-459d-e55c-08de9c907d65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|56012099003; 
x-microsoft-antispam-message-info: Ze5VQT6+Hsv6HxFWhAN2cvHubw1XvK/xWKdrQpO85A0dLcnzzQmx7fGTUdR9ULPRsKPOoKmOPhQnTJbBC3kuR2FEn5VI9qshLzLZwQd9Zx55hfc4BNaEj+YiRJK6B9e2PvvXD+71v1gzVFtZql5ZPPt1l1rJ/NcHW+NEPEIZ9tQJI1HKJ3MvQpA30mRrllzc/7JguTUc71ZvULlUHvuWV3bBne3o4f/XHlAE9nPwj9diaoZuTASEP43/72YLZSmz5dBzDN9/k0bFHyLvwtGn3qgzwKy4Py1bHCsSbqBZMcydQK9FqKE0MeMdLHQmLfssI77TKrjoVHDs+gYwS4G7s4L98USjgZbMO/dQIuDDkxZkGF5evrcyCO5icdMVFC4n+s2/xva5Eo7nMBaSXexqcVp0klFS5nhVAfTURM+WiGZEYVkksfulI3PRUjtmLlPQRpmUutg6rFCDDBcYisR8qIqQLpEOcq5qo0hxCy4CwU8VFrsLzeitk+pnacIV73717dAg+79k0gFgiQ6KPqN5WYBQJUSweZQDSsSx8I7P3ztPX6gqaQagtjKSjod6HGqQxcQfLOBMRBBBDTi9b/JfQ8VGbKAx1LLWBGVJzOEm0V+zC35gC7U9moX9d3LJpUqPjHlz4s/2M/YGMO88Ks/dJV4OXL5mjj6xpYAw390ke5nqAkNaZIMWbp2pfBKP7JfCjAAxn951nSRbtpRlC0eF/z7l2L/4EIzNcy4Of71VuHvAi1crxcfjmz6gMIrferGeEai9xnmNamIhLZDzXOABAIJJOJ3hETIGP6R3YcQ8T6c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2JKTVBVd2U4b3lZeU5oSFZCSHhzQXVQNmIzNFdtVStzcnBEODFnSGE4dUM2?=
 =?utf-8?B?SEVObTdvY1NjbWd0a1dvL1I5Sk9sb3NJbzhCR3drL2RTNGlPSWhSblIzazlB?=
 =?utf-8?B?WWtic1MrRWJ3Z0V3VVo3WEdleHRCWFlhNkJjeUdvMDhxQ3lHdFg2cXVSMmtu?=
 =?utf-8?B?aXk0UDVYMG1kemJRYVNBZDBHRFB6eVFzTWtVWS9uV0lqRitzYWFxblBycElv?=
 =?utf-8?B?QUdvUm54ZUNYQXFybEdBNExBU1FYMSt3Rzd1ajRCeUFGL3k0cWhxTDVkTFVH?=
 =?utf-8?B?TGUyS0pNQ1NsUytRNFNzR2lCM1hHSytyR1gzSVc2NllITjkyRVBUcytFWmtM?=
 =?utf-8?B?N05FSGhrMmM3OStmSjFyWnpxUWRBRFYxbjc5WW96cVRYYm9QYmhUZmlhM2xa?=
 =?utf-8?B?a2VTOFF6MSt5M1p2MGlFbEF1UG5vamRtMi9scytMcTlTZ3VuWmZIbjkzYVlm?=
 =?utf-8?B?UWM5RSs1dHdsVnY5akx0QVB0ZDd3V1BLbWhIQ21sRElTbnBJOEltYXh0QzEr?=
 =?utf-8?B?K0szbW1tSzUxMUg4WittVSs1Q0pDMTlodEVEbitYaGd4NmRINTd4VUJZRXpN?=
 =?utf-8?B?SnkzWXRRaEU2c3cyS1RnVllmMXdSLy9QZXlYQkNSb21abG5LMUNVeGdDQUJp?=
 =?utf-8?B?SFhrQjJVZDYvTDA4TEhyS0JxVHgyck1IRGl1U3JSOG1wWXhTck5McXRIUDZO?=
 =?utf-8?B?WEVVcmZZWXNreDQwc1p1Z0RDUzNScVZ2MUpJN0ZsMWoyUkFmZG02akpGTTFv?=
 =?utf-8?B?USt1eGw2emtIZ212VzN0SWJQN1VmK2piN2wxaDJPcWw4SnFXZmhHNDRaOXdv?=
 =?utf-8?B?NHRaY0tKWXlncjR0b1RZSnZHdHYrN2NZOHVJYmpzSDg4bWVyd3EwdGtncVhO?=
 =?utf-8?B?dkFLa1BVU0w1VkxjbkJ5bS80WU1WOHQrN2NRelZ1ZlRQQVdsWDFwdUk4c0Fy?=
 =?utf-8?B?TGdQVEQ1bkRYMmthVlVLblgyZHc4elNQTHc4WTlxcytMRkVsdGRmWWRWLytJ?=
 =?utf-8?B?TWZJR1JKdG1ZdTRsYmNhNmRkbWxrT3ZQRmZXRDhSU0ZESytjOWJBc3UvN0Va?=
 =?utf-8?B?RjZwNnpEQVN3N2JCWnFodU1BcDN0ZTZrZmZFWXpqQlo1WUVUMlZERmRVYTlU?=
 =?utf-8?B?UW0ydFF3RGlidFVhcWNMNlN1S0hJcG40SmQwWHE3VU1HZlNja1pja3RZa0pV?=
 =?utf-8?B?Skp3Z01iZXFYNlVFL2prQ2g3Sm9QVnRwd1BBNm9PdUIyV3RqMGpMRUdNWVVL?=
 =?utf-8?B?Y04vU3hxcElFSWFiUmpBMTdWM0NvTEF0MFA3M1R2M0NETURwdUVzcHdoZHRH?=
 =?utf-8?B?dmhEVDBLcVU0L3pheGcvVUNnUTVjN0NLQXpHMlhxM2xuWS9oVmxTZy9HOHRp?=
 =?utf-8?B?WFl1K3lNWjVJcW1wcWo1ZE81UU9hbDRlK2dYUUFvUW5wdFBGTTlZaHJUMXcy?=
 =?utf-8?B?Y2hpdGhER2dKT1UxQmhScVU4ZTcyMjlSMlZobDJVNk53ZFg0cmtDdEc1YWor?=
 =?utf-8?B?aERWV0JCeHY3Zmx6NEIrZnFyb1NCZWU5TTNmckVHdFBGN0JtNG5DTElhNUdC?=
 =?utf-8?B?Skt1WGdpZ1A4bUNYS0NrMFJHUGJEQ0ZiRGR1VHNpcVZpT2hkN2Q0K1dKdm5l?=
 =?utf-8?B?OHdwc3hzSHJuVDc0TUFhMGNKZXB1UkZxNHdmWVYyK0p2QVBmR2hkNUNtMThI?=
 =?utf-8?B?cTBVNHhXUHVRV1VyYzRNRk9KMGxMQndDZnNibWVkRmVaNGpaTFFRcmFhU0dW?=
 =?utf-8?B?QllZVHo0Qi9GTXB2b3RSUEdVcmdDaXhVK3RnMnRrd1JpWVI4Mm9nTWFIdjlE?=
 =?utf-8?B?RUpENklvU3VqbHhoZ1NLVUFaL0haOEttZ1picFZmdnNmUDBJUVpjRWlTbHhl?=
 =?utf-8?B?ZmU5WW95eHRLclZYVHc2b2g0QW5EMXRCMEhtb0J6UGZUdHp2YnljWm9wRWhQ?=
 =?utf-8?B?WXFETzdxRXJrQ0hBeXFwY3J0RjVqSEQvdld2cTRXZUFTYVNkdkVRSGZtRDVS?=
 =?utf-8?B?ZlEzUE5pK1BUOXBCamdhNVdzUDNhMlVNb0JCdXVZRWl6eDFIYjJzeGtJdmVl?=
 =?utf-8?B?R0l0SWtSbEl6TEVNVFFYUzNhNE5qSzR4eGpBKzQ5R3FaMnRZVHZxcXA1UVZx?=
 =?utf-8?B?ajdxREZXY2MrRjdLa0dBWTNlb01xMHQ5bGFCUEVFZ3pXRjRCVFExODhmcTZL?=
 =?utf-8?B?blRqcEZMTzNzRnhPMmYvSWJ5L3AxakVJSGRqVlRRcVJ0Sks2QTNIWWQxZXF4?=
 =?utf-8?B?b0R0b3NqK0JZNTdnNjBaK0ZSdy9hbEZCSTRYd3VsdUd1bWJMUml1YzhlQnd2?=
 =?utf-8?B?a0UxVWgzbmNuWittdVoyUVVDUzNQYnJycmU1V2xqRlF4U09NUU1XOFp5Rncr?=
 =?utf-8?Q?XPL15mXakDcVTRQLCiUY4/vVvc8SYFvqwT23M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37AB416E090460458C69C3AD3C08D6C6@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25633a07-dd28-459d-e55c-08de9c907d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:49:12.5724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKoue4/R5o+4eFrtlwIoeIzh38L7Y+hPWfwTUSelTXISfiUvMH4Pso864+5ixc83Gthro45ZNdmM5tkApcCTrHWlcoRYFbRRxBkLfKWM5C8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB8150
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VGhpcyBwYXRjaCBzZXQgaXMgYmFzZWQgb24gUGhpbGlwcGUncyAiW1BBVENILWZvci0xMS4xXSB0
YXJnZXQvcmlzY3Y6DQpGb3JiaWQgdG8gdXNlIGxlZ2FjeSBuYXRpdmUgZW5kaWFubmVzcyBBUEki
DQoNCkkgYWRkcmVzcyBjb21tZW50cyBJIGdvdCBvbiB2Ny4NCg0KLSByZW5hbWVkIHRoZSB0ZXN0
DQotIHNwbGl0IG9uZSBwYXRjaCBpbnRvIHR3bw0KDQpUaGFua3MgZXZlcnlvbmUhDQoNCkRqb3Jk
amUgVG9kb3JvdmljICg3KToNCiAgdGFyZ2V0L3Jpc2N2OiBEZWZpbmUgTVNUQVRVU19TQkUgYW5k
IE1TVEFUVVNfTUJFIGJpdCBtYXNrcw0KICB0YXJnZXQvcmlzY3Y6IEFkZCBiaWctZW5kaWFuIENQ
VSBjb25maWd1cmF0aW9uIGZpZWxkIGFuZCByZXNldCBsb2dpYw0KICB0YXJnZXQvcmlzY3Y6IElt
cGxlbWVudCBydW50aW1lIGRhdGEgZW5kaWFubmVzcyB2aWEgTVNUQVRVUyBiaXRzDQogIGh3L3Jp
c2N2OiBNYWtlIGJvb3QgY29kZSBlbmRpYW5uZXNzLWF3YXJlIGF0IHJ1bnRpbWUNCiAgdGFyZ2V0
L3Jpc2N2OiBGaXggcGFnZSB0YWJsZSB3YWxrIGVuZGlhbm5lc3MgZm9yIGJpZy1lbmRpYW4gaGFy
dHMNCiAgdGFyZ2V0L3Jpc2N2OiBFeHBvc2UgYmlnLWVuZGlhbiBDUFUgcHJvcGVydHkgYW5kIGFk
ZCBkb2N1bWVudGF0aW9uDQogIHRhcmdldC9yaXNjdjogQWRkIGVuZGlhbm5lc3MgdGVzdCBmb3Ig
UklTQy1WIEJFDQoNCiBkb2NzL3N5c3RlbS90YXJnZXQtcmlzY3YucnN0ICAgICAgICAgICAgICAg
ICAgfCAyNCArKysrKysNCiBody9yaXNjdi9ib290LmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCA4MSArKysrKysrKysrKysrKysrLS0tDQogaW5jbHVkZS9leGVjL3RyYW5zbGF0aW9u
LWJsb2NrLmggICAgICAgICAgICAgIHwgIDMgKy0NCiBpbmNsdWRlL2h3L3Jpc2N2L2Jvb3QuaCAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQogdGFyZ2V0L3Jpc2N2L2NwdS5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMTEgKy0tDQogdGFyZ2V0L3Jpc2N2L2NwdS5oICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMjggKysrKysrKw0KIHRhcmdldC9yaXNjdi9jcHVfYml0cy5o
ICAgICAgICAgICAgICAgICAgICAgICB8ICAyICsNCiB0YXJnZXQvcmlzY3YvY3B1X2NmZ19maWVs
ZHMuaC5pbmMgICAgICAgICAgICAgfCAgMSArDQogdGFyZ2V0L3Jpc2N2L2NwdV9oZWxwZXIuYyAg
ICAgICAgICAgICAgICAgICAgIHwgMjggKysrKystLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5z
L3RyYW5zX3J2YS5jLmluYyAgICAgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMv
dHJhbnNfcnZkLmMuaW5jICAgICAgIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90
cmFuc19ydmYuYy5pbmMgICAgICAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3Ry
YW5zX3J2aS5jLmluYyAgICAgICB8ICA4ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJh
bnNfcnZ6YWNhcy5jLmluYyAgIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFu
c19ydnphbGFzci5jLmluYyAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5z
X3J2emNlLmMuaW5jICAgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNf
cnZ6ZmguYy5pbmMgICAgIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19y
dnppY2Zpc3MuYy5pbmMgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3ht
aXBzLmMuaW5jICAgICB8ICA4ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfeHRo
ZWFkLmMuaW5jICAgIHwgMTYgKystLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3pp
bHNkLmMuaW5jICAgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2ludGVybmFscy5oICAgICAgICAg
ICAgICAgICAgICAgIHwgIDkgKy0tDQogdGFyZ2V0L3Jpc2N2L3RjZy90Y2ctY3B1LmMgICAgICAg
ICAgICAgICAgICAgIHwgIDcgKy0NCiB0YXJnZXQvcmlzY3YvdHJhbnNsYXRlLmMgICAgICAgICAg
ICAgICAgICAgICAgfCAyMiArKy0tLQ0KIHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC9tZXNvbi5i
dWlsZCAgICAgICAgICB8ICAxICsNCiB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRp
YW5uZXNzLnB5ICAgfCA1NyArKysrKysrKysrKysrDQogMjYgZmlsZXMgY2hhbmdlZCwgMjYxIGlu
c2VydGlvbnMoKyksIDgyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9m
dW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9lbmRpYW5uZXNzLnB5DQoNCi0tIA0KMi4zNC4xDQo=

