Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45D3C7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 08:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRoTA-0003iP-RU; Wed, 18 Jun 2025 04:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRoT9-0003i6-EF; Wed, 18 Jun 2025 04:48:31 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1uRoT7-0005ui-Po; Wed, 18 Jun 2025 04:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HaQVOdm8wIdkiSSIM2TiNPv7KWsTIoJ0eBUQANrFRy5mif/fU+xZrZQOW9gUD7V47eykP5WrAGTaGzBjQ1+r7ulnrtX8OToVqWzFsk960KfZ5o27CpHNB+8TvSHEWfbtvTDy//lVRRajSfKwWZr+AuXGiKIBMWTShiSktJOnQOAhr4ZqejBkVSQP28e9bCdbN5+WZm7ScaJKVe6zlqUzzOUkWblSIfjwAd54AtwI3ALzGfTa6uVldI4D7Y7TwuvyvYzX2xvUhAp+SrDzvfK++F2dfZDSr+oDXIykb3k/Pv4SA9xpMpaW9YI3M9TtQR8wBqTx3dhj4huW3SoVSkPhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z28QYb2LHwQQf9zNJkKc83/GQi7Q0a7pE6H8CgYU6vM=;
 b=c3B7cORUVLB1DlhqtW9KZm9BaXBSxAzt6isMe6hs60Rto2WYL5wkp5/lpu165Kr17Rm5/xCC38T2SQL0jDff1sx6G/vethdZORvF839dSLDBPvO5A1j90b0cnNgnOi0qwgyHCBdS/irEnplaLeG+YPJ0mU95PlGQ1af28FzkW31yN9VCRBaQ0pcIcRpqyAzgiHOEd7wXTqfbjwU2OJrN1adTtKmUOynPh9Vqse3UfAZVdYrpLAL4P38MVbCB+Ewh5tCEhpCzMCFe9JPS6snTqCEoS534Z6H7ZSK5zo0dPtN2TASxS1xIJBXBfm0MqSZpX8y7qThkCOTGgEg5m69o+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z28QYb2LHwQQf9zNJkKc83/GQi7Q0a7pE6H8CgYU6vM=;
 b=hFroP0NUdEhqv4YbI4t3H9hEZsZjLxg04i0rgPOr7XHOj28zMUifLQ9tNp4TC4B9AhjZOglskAsK+G1za2+/UssIUlwdr/gp/3M2jlslNnXTpQqlPJf5gXcTuVnYBSa64Wo2Z/So5I14fLgraQXRsYh63ZDbJ/GN1SeeMWV6OX8tLOF0wV5tgyte8caO65Ns0hA28ptO3xh+JEzZm+TTQfcYzDg53uK7ur4aKGCaOFcUzat9gUb3/LUvQxlNBQx+XDHTgbto487YFA9H+FJoZ/XBLJdvMdHELc5gsKy8Y9G7pBw+WcYo1veYDF4euyymBBZiOX34+rxAGQJEXxQj3g==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by PA1PR09MB7234.eurprd09.prod.outlook.com (2603:10a6:102:45a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Wed, 18 Jun
 2025 08:48:24 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 08:48:24 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>
Subject: Re: [PATCH v2 2/9] target/riscv: Add cpu_set_exception_base
Thread-Topic: [PATCH v2 2/9] target/riscv: Add cpu_set_exception_base
Thread-Index: AQHb08ABNSS0HB2yL0i6yLz6ZnvaMrP8D08AgAyksIA=
Date: Wed, 18 Jun 2025 08:48:23 +0000
Message-ID: <5c6a4e25-e1e0-4a46-9f05-e0140cc5bf7d@htecgroup.com>
References: <20250602131226.1137281-1-djordje.todorovic@htecgroup.com>
 <20250602131226.1137281-3-djordje.todorovic@htecgroup.com>
 <fb1aff3f-dd5a-48d0-a722-1eb4266dcde2@linaro.org>
In-Reply-To: <fb1aff3f-dd5a-48d0-a722-1eb4266dcde2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|PA1PR09MB7234:EE_
x-ms-office365-filtering-correlation-id: 026a94d8-1be4-4386-c30e-08ddae44e2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bk05cWZiSkdMRzgwZHF6SjhFUHBTWmFpYnJIWmtYWDFyTGVLUnN2VjdWTjgr?=
 =?utf-8?B?L3FuZEN3elJ4K08wWTVxeXRjTWpqR1Y2a3lBVVg3Qld2amRzVVphQzR3em91?=
 =?utf-8?B?UWFGSE9IQXVUS0NjYmZ1aG14b0FsKzJDMFFKZUNRRDJnZEhlUC9iZCtqL0tJ?=
 =?utf-8?B?S1RmdVFiVjIvcThDMWhvQmE1UlFBNThsSXkxb1RjT0s2c3lWTVJWamU3Z1pP?=
 =?utf-8?B?UU81V0krQ2pMWHlNOGpZTnIvNXFYaVBtS0JrK1k3VU9Rdk1wVDBjald4QUtR?=
 =?utf-8?B?SWRRNXdWME1FUnphSWdtSkJHMW1LVUhZNm96WmNDZENabzlpTzNJVlcxVmw3?=
 =?utf-8?B?RndsSWhnRENjUXh0YjdRczlHdXdGcTQ0NXVUNTR5QzZlNVl5dUs5ZTZ6VEZZ?=
 =?utf-8?B?MEdaY1FBdUtNdDhqR1NudWZVNXplRlBGQVVoREVyc3UzQjBqWEpFcDJOSjdP?=
 =?utf-8?B?RjRCZVR0dTBNdlRYZnZTSWVhTFIvT0dzcWJidnV0RTVHNDd2U2prSk9CNU5H?=
 =?utf-8?B?TVVPajc3SXRjZjAzK3p3S0FpYkNUMC95dTZoY2xOQzNRR3owVEZmaU9pbGVQ?=
 =?utf-8?B?RWN5TW8wZndqNVVzL0JpMEd0enRVejkzMHB3ZGtiUDV1b3g0WXJGb01DTGtD?=
 =?utf-8?B?TiswTERZMDg3aURSNC9pTytQQ1ozSkdzNnZqTG9TbEFORExGUENzNEQ4QWJo?=
 =?utf-8?B?aEk0UStZVGpiUnQ5cmpQT2RoU0JObDZhQnZHdlhwbnoxaFpIWXhqVnlKbVlE?=
 =?utf-8?B?b1pLYzg4dWZFQjZpcHpaK3NPVWpjZVVuQWV2M2JjaE9yY2MwSHljZzdqRnU3?=
 =?utf-8?B?OW52K3Q5WU9RUXVnenJXalRhT1FOWkZmN2RWTUF3ZkhBcVF1NHFUMkhTazF2?=
 =?utf-8?B?V2dWeWhvaTZNYWR4YVpLanNMaFZGT3lBTlFtWWVSL2NGei9yM0tZYXg0dDVM?=
 =?utf-8?B?ZVlLeXRLZFNtb3dNL0FaQm1lVThlM1ZzZFFPTWxlQksrN3JVeUJ4WE8wV1J2?=
 =?utf-8?B?VC9vUFRNbTVOMHBLV3JmQnJPOUpWQU94bjNmb2FtM1JxK0Nobk1kLzFOZTkz?=
 =?utf-8?B?TXZRMGFvcXI4Mm9pS2ZqQkNjb01XQ2NFc0k3emhOdS8wNm9rUjhtRnRDNUpu?=
 =?utf-8?B?YTJtUzVnQzB2bWdvTXBsZ05MYUdSQ3NxT1F0S0tQR0NGczRXdmhRRUJzeG0r?=
 =?utf-8?B?N1FJbTlVam93Ukhoc3lmdDlldW41WkZqK0FQY3ltcDJPVG5pWUp5YnlFOXo2?=
 =?utf-8?B?V1E2QUwyRjJuQlVVdHl0RVgxWlJUWTdPQ2xtWWhOLzA1WHovTjdDU1dVMU4v?=
 =?utf-8?B?Rkg2MXdRZkc3dXlTL2o5Z094Y1piQ3FhL1lOeFR0NDJvT2pheUoycS9xVWlT?=
 =?utf-8?B?UXRlN1gvRlFiK084VWZkcnJlVm1INUUvRTBKN21xaEdQV3NyL0M1Q3F2MlFX?=
 =?utf-8?B?VkU0aVRKL05raGdXajlpYnY3NC96d3EyUEgra2ZXV1BtQkdQcjNKWWxod0pj?=
 =?utf-8?B?UHF0QnNsdkZYbGdtSG90OFJVQTB0RHQvYkxUVk51a080T3NVS2NBWGtGU1Mz?=
 =?utf-8?B?YnJKUjZrb1ptOEVrVmNmYitXbDMxdGJvcHFFdGZZOHVlSHBNcS9oNnljcXVt?=
 =?utf-8?B?eWNwbXlHblFwYUlIU2huRlRXdnNNTnpwekpKUGxIcU5vSHQwdUJ6elVIQVlv?=
 =?utf-8?B?enhVdGhEOU1lMmFNaDdFaTFUWW5IR3N4STNVL1V0RkFoRDNJVXoxSjU1QWxQ?=
 =?utf-8?B?M2p3emk4aWxIWW1qekVUWGd3bmlwSml4S0VwUlduNXc2aHc2dlZRQTBWY2hl?=
 =?utf-8?B?UnpxTjhGeHBaK1hvVFVwWm5oUnZFNFpFRENSN0prTWNkOERDbytTaHUwMlZr?=
 =?utf-8?B?TmNuQkt2WkM4aUtSdkp5S09sUEJ0QTNWV0RRSWwzeFprZ3ZDZzlVNEwrT0Yy?=
 =?utf-8?B?cWdnQTltNHIydWZpVXlBaE1Uc3FMd2dUanB0VC84bjJVUTNsUmg2ajRXODh0?=
 =?utf-8?B?UEZJVUluSmVnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blRlOHRSNlRPVWtPUHlnbDdqY05jdzFJN0RsMDlUMU5yM3g0Y01qeHRsUTJJ?=
 =?utf-8?B?Y3ZBd2pNRFdCd2VTM3Nxd0ZsK2FqM2pCSm5EanZsa2E0a0wwSXZ1VUp0RmJh?=
 =?utf-8?B?d0RwOGY1Rjl1ZGlvMmdVemNRRXJKSkQzZlA1UGlpdEY3VERoTUJYT3kzNkJE?=
 =?utf-8?B?ZHpPRm5mTTIxWGZWTFFhbWh1ZEFHcEc2ck9mT3dFU1d6blE5VXNUNjEwUE9K?=
 =?utf-8?B?dzU2dXVRQ1RSekhiRFZnbFdrSmVyRGRURWNaWitFU29ycTFHbksxZzFlbDRw?=
 =?utf-8?B?NHp6Z05jcE9lbGYyUi9kUDZOdy85aTVrRmpHODhidDZYZE9vMUpYVFVtQXN6?=
 =?utf-8?B?NWtieG11WlhyWldEcmlWY0YrSTNsckJZbTFORGMvVm9sSmV3TlpJOHd0M2N3?=
 =?utf-8?B?ZVNETlZ3UzZ0MUcrcXNYR1d5dWZ0dXBSc1lIMytscTdjWVFRSytzMlZlRXdx?=
 =?utf-8?B?aWhtb1VFR2U2cDVqV0lTc3Y3M2JUOG1sakswdVRtd2pXOEZVdzFXaEp1dmpK?=
 =?utf-8?B?ckZJK2ErYjBPVGlMT1JIdzY0Wjd2eWxUeGZQZ0ZYMW1OaHJYOW9XZGw4cXpV?=
 =?utf-8?B?SzJHeFVMRmxPc1MrdTBJZ1N6dlN5SEFxbEF2S2d0NUowck55MzNHYm12cXNo?=
 =?utf-8?B?NGpZYzgxNjAvcUpDMEF1VUczTkN5NXRlVzV0MnlTUzFFVjB4R3dwbWpjSzlp?=
 =?utf-8?B?eCt5ZUhWYzhSQWNvRExwTkx1Wk1NUHRtSlVIY3VDUTUvUzdTMG02Uk90WkZy?=
 =?utf-8?B?ekxkT2RmcFlLSDJoSHg2UVg0TzJ6c0VBZjZKbUxVLytBMzJNQlU0bFJ6aVlT?=
 =?utf-8?B?SENqUzBuNVpzUTVPa1lWVUJsdmZSc04vV0EwMGJMYzFvRW04a0hqUjdvZ1I2?=
 =?utf-8?B?YklYOG90L2pWRWJwWlhaRW9hQ2pLQVpFbnhqNW9ibXM2MXRJV0dwZ1NNSXRl?=
 =?utf-8?B?bXlGVnpnWnVoRnEwREpnSzY5WXVkUDBBa3c3dGF5VWdSSGtZUkFzRjYxb1Nl?=
 =?utf-8?B?UXVHcUdJa1kvcWpobS9XYU5QbjVBbmNPZm9XOWU4WFdqclU4T1diakVzajBt?=
 =?utf-8?B?V3NjLzUrNkJDZVFaZmk0YTJmb0w0c2lhY2p3SXk1ajFxZ1FHL0FwcnEraENw?=
 =?utf-8?B?UHYxLzd5a09BcnNUTjVvWU1MRmZtM1hrUnAxc3VoT3kzekVKanNsa3hVdC9u?=
 =?utf-8?B?S24zT3F3STB5d25DWTBxbGlPbzlYUGpSaHorR2JBSzNobGwzSWtjdDNyYkxt?=
 =?utf-8?B?bUxtUFpjR1JLMnZOU2pGWUloTmpoT28wYmFja2VreXFuRXBIclplMFk5a05P?=
 =?utf-8?B?SnZURDNwSmFoaHcyYjBtZ2J3Q296TURGd3Zub2N6RkpNSENtR2NsbFlMNUFR?=
 =?utf-8?B?UVNVdjlKdXdDUjhIN3lReTJZZUVhN3VxajVsWEU5R2Y1S3lXU2EvZUFUaXdT?=
 =?utf-8?B?anJZemdBV0k5MFpjbHZmazZCV0taVmNBTlNMQzRKbldrZmFhZlg5OXcxb0I2?=
 =?utf-8?B?eVp6OEtNRForRGRoTDlSd3lWdm5CVG1ldmRBRndLNkRob0Vtd2Y5NktzRkpV?=
 =?utf-8?B?djZEeVAzS0pxdWFRNnAzS21KWWtUdVZHK1Rzelkrd2UwcEpFekxqT3FzM0tq?=
 =?utf-8?B?ejdRcmFuWEJHeHNSbTliQnMwdG1JZlhhNGdmazFubzU0Ujd5T2xYdjdNVkhO?=
 =?utf-8?B?OHY1anpkdUlRZ3dDRnk5NHVzKzRDQ0pYRGZNWDNXaGVBYmNHdEdPVVgwRzZJ?=
 =?utf-8?B?Y1lHYXJZcm9PV1VCcXVYUWMvRUt2RUJjZGlnZXdoaEFqZVhzNzZCdUY4Sk93?=
 =?utf-8?B?ajFSUWdxTGx2ZE5RdXl2Ri9LdS9Va1lHcCtDYUJWZVdyRTE0LzE5VHNaSmUv?=
 =?utf-8?B?OVBJODJvbjdvTWVJc0IxRmJqcm1lOTJycm8yU1B3T3pyblBvUm5UcldoODlS?=
 =?utf-8?B?RVFpSms2ZDZUSi9FVk9mcm5rSWcwbjVzNllsNHpTV2FxdXY3MEN2bFdCcHRk?=
 =?utf-8?B?d2JOR3RTZjErbnF2TlhDQm10NGNDMnRhV3lDaHRONVBYSEtiOEhKRSthTTdS?=
 =?utf-8?B?YVVTckJEVHdpN25nYjl2bG1MODRwS29UT3M5KzJwU29YVTBJVDlmRzV5MURI?=
 =?utf-8?B?cDUrcVVuaEM0RnRBaW9HZW5tVzBlYmNKZ3VmVnoyVHhBRG1OSlhmUTdOajF2?=
 =?utf-8?Q?rpzfGl0t2SCLKFlgrui2fQk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0B6071588A50144B7653AE345E8B619@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026a94d8-1be4-4386-c30e-08ddae44e2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 08:48:23.9771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iw44FiT1i3j2iXq0llutjZT/uejTIl+c0TkZZ/n+W6HFadQPCyrXJ/Xeg2b9O9BOiRioCGOAoUKHUWZVQLGiya818DGVkXZkgBBAcdtzt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR09MB7234
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQpPbiAxMC4gNi4gMjUuIDA5OjQzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4g
Q0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5p
emF0aW9uLiBEbyANCj4gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciANCj4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4NCj4NCj4gT24gMi82LzI1IDE1OjEyLCBEam9yZGplIFRvZG9yb3ZpYyB3cm90ZToNCj4+
IEFkZCBhIG5ldyBmdW5jdGlvbiwgc28gd2UgY2FuIGNoYW5nZSByZXNldCB2ZWN0b3IgZnJvbSBw
bGF0Zm9ybXMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5j
b20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpvcmRqZS50b2Rvcm92
aWNAaHRlY2dyb3VwLmNvbT4NCj4+IC0tLQ0KPj4gwqAgdGFyZ2V0L3Jpc2N2L2NwdS5owqDCoMKg
wqDCoMKgIHwgMiArKw0KPj4gwqAgdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5jIHwgOCArKysrKysr
Kw0KPj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9yaXNjdi9jcHUuaCBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPj4gaW5kZXgg
MjI5YWRlOWVkOS4uYzBlMDQ4YTY2ZCAxMDA2NDQNCj4+IC0tLSBhL3RhcmdldC9yaXNjdi9jcHUu
aA0KPj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+PiBAQCAtNjU2LDYgKzY1Niw4IEBAIEdf
Tk9SRVRVUk4gdm9pZCANCj4+IHJpc2N2X3JhaXNlX2V4Y2VwdGlvbihDUFVSSVNDVlN0YXRlICpl
bnYsDQo+PiDCoCB0YXJnZXRfdWxvbmcgcmlzY3ZfY3B1X2dldF9mZmxhZ3MoQ1BVUklTQ1ZTdGF0
ZSAqZW52KTsNCj4+IMKgIHZvaWQgcmlzY3ZfY3B1X3NldF9mZmxhZ3MoQ1BVUklTQ1ZTdGF0ZSAq
ZW52LCB0YXJnZXRfdWxvbmcpOw0KPj4NCj4gPiArdm9pZCBjcHVfc2V0X2V4Y2VwdGlvbl9iYXNl
KGludCB2cF9pbmRleCwgdGFyZ2V0X3Vsb25nIGFkZHJlc3MpOw0KPg0KPiBJZiB3ZSBuZWVkIHRo
YXQsIHRoYXQnZCBiZSBkZWNsYXJlZCBhczoNCj4NCj4gI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
DQo+IHZvaWQgcmlzY3ZfY3B1X3NldF9leGNlcHRpb25fYmFzZShpbnQgdnBfaW5kZXgsIHRhcmdl
dF91bG9uZyBhZGRyZXNzKTsNCj4gI2VuZGlmDQo+DQpXZSB3YW50IHRvIGJlIGFibGUgdG8gY2hh
bmdlICJyZXNldHZlYyIgZHVyaW5nIHJ1bnRpbWUsIHNvIHdlIGRvIG5lZWQNCg0KdGhpcy4gU3Vy
ZSwgSSB3aWxsIGRvIGl0IHRoYXQgd2F5IGluIHYzLg0KDQpUaGFua3MhDQo=

