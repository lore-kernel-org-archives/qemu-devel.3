Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFABC54E66
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 01:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkaDu-0003vq-Vc; Wed, 13 Mar 2024 21:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>) id 1rkaDt-0003vZ-SO
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:49:33 -0400
Received: from mail-he1eur04on2073.outbound.protection.outlook.com
 ([40.107.7.73] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.fan@nxp.com>) id 1rkaDs-00074Q-Bz
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 21:49:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdQslusHv5D4t4iRIC+JwLPz1MVOexFpNQ1UHlEvUN/8aCgwvwwq9oAUh8Hr/UrNqKJhnuHoUm9IdmxwUataZFn5KoOYb2IDeCFRnfZGQwDy/F/k3ynpKHrO7VxhCkSKJGscfOwkqqkaLUeeLWeLcpCxly5fmrKppOMYdCzjCrHv5Y2a+MUbnfoUuhYILbA3ackmcDcJ8oVlrNfmSDLzN+s5qGGvKuqJCc42ManiY6zKkbzROT9RwPo+SBDhiR4t8s+quRtwB0gZdCmJML5SFsk+9erp+EzpocpHsOaAQXDQkrd1BFpJtKTXpmNeqsjBIKKhBUKhvIWfYb8zvA8iTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3duGKF+VG/X1RGjTr1CwnoXh2r0IlYrHI2sFNYg8XoI=;
 b=FJfHtf1tqa3N4Pebk3lb954/DE0bwptJYzCyv1u1XYLbnB7Fh2M3cfgZyCgywB0ffMprajedjKWtX7mLWDSya6Rvb+Jo7DcIy9RC7bi3YQHm11bC+WOOvW3T1Ygi8ISUCx8SkesW9fqp4HuTnX1aOmHx6LxbJ87RjvdsxTN+Kn6flhRvhqNojU+UqSzkAAHBjTjraxq9z6YKncsHVK6YdOQHiG6vL2nya5EKawseZ5ossPxsq25b+Xx/y1F3yaZnQza+WYjdnPNi05QZ3lG2knCAeMKxEgtqhTRXppwYSYviq5ySu5milGyFMIxnQ4WjXvR2GghFphGeefZzSXrZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3duGKF+VG/X1RGjTr1CwnoXh2r0IlYrHI2sFNYg8XoI=;
 b=GVP83HR0OKwTDjpSk0IvbClp9ACmyf4RoAMlEu2l+UTjduHOOT7QosAS+WXlWTomtIbGsVRsq1hlDHjaK1XClO7C/4k7U7601AtcsfVi1E8Rjq6UrORXpn5tsR8MNlMoL63izmCRZu1T5ZmUlYg3gaWXPjRG54yp/ZZqQIauCx8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7887.eurprd04.prod.outlook.com (2603:10a6:102:c9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 01:44:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 01:44:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Anthony PERARD
 <anthony.perard@citrix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PULL 2/3] xen: Drop out of coroutine context
 xen_invalidate_map_cache_entry
Thread-Topic: [PULL 2/3] xen: Drop out of coroutine context
 xen_invalidate_map_cache_entry
Thread-Index: AQHadImCp+yb4nmvAky1lTzeN6un87E17MCAgAADZwCAAIhv0A==
Date: Thu, 14 Mar 2024 01:44:24 +0000
Message-ID: <DU0PR04MB9417CC545CE51B7EBA14DD9E88292@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240312142757.34141-1-anthony.perard@citrix.com>
 <20240312142757.34141-3-anthony.perard@citrix.com>
 <7f6ecc97-8c32-4929-8ae1-b296e874ced2@tls.msk.ru>
 <3b054ce9-3f4f-49f6-aa42-dea33264466f@tls.msk.ru>
In-Reply-To: <3b054ce9-3f4f-49f6-aa42-dea33264466f@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7887:EE_
x-ms-office365-filtering-correlation-id: e9f2186e-4315-46b6-91f3-08dc43c84712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vv7ii5fzze8smCyBMFTTOWIUmpSsv9EEUf+gtD5WMCtDmP45adDWflNzDQzb297PKoOQ+t8aeOALvk/CAuwdVKwsozL42+fj1VNQE4CD92ZF/wX7e/ggr1SvaykeHIf/6hBghXvhMg6pzEJbo6Xbx86lNVs+MnrlXODjIiB46cZfMraPPina+Urw1HUARnM8z51oAlJQTGljC31R9GYTpHsRGHnwoXg+sQlnHZrvCIX83aP7wBgxbPudbfeuRk9i/wDi3feBYDpn0bqrSZOdev7ZEC5qQc1ITFwdmTtknRr/Xz4sqLNt+omKKx9jAJwa9JkbPYINK3C3QKi7Puv1nIfl/Cx8QCC7rvbiFx0T58yug7BinOEkWr26iuzPmyScO+JkOZ5MNoZktEetZUkZPJ878/OeXMmsA8DEPr8BEfqERkxZBWFX8m6zSXrDRbcfxT82onKut0yl1cBndsEusl6gNkPaHgSdC1GUKCjLjY3kicPErI84CoKJMm8O77h4dYkXNVrIdIqhJdARJ0vLRqqoZ0My5g8VKvzG2YIdjojCmE/ufOCwhfV/HQdLGbloFu5vDJAH1z6QHAz14OUfcGroJu4iPV/4HLZiSP7008l7idNGIaUvDWEt1IK4aNH6wRTiRIf9EbrQRI5tNANYZ3BDGExA/vL6KwqkmCWoKzD71vmwm2Cj4sbd7zbDY5SX3wzLacARE89KRJKaj3OS0dJqWSnx5oO/he4ehfLKg7o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWQ0dUxvNmhxYWY5czN0REF2ZVVsajM5NzNCbmV3L2tISzVQUlVBZFQxOG5v?=
 =?utf-8?B?dVppaVE2UFJneUlNY2NqV09IaHdUWFBERjZXd2JWbFIyNUQ5QkNSbTg1OVk4?=
 =?utf-8?B?WU5EUG0yVjhBS0k0SUtCMTNYV3Z0S0VNUGh0aWRjTU5wcGlySzFGSEUzN1c1?=
 =?utf-8?B?Z1pkQkh5QTd1WDU4TWNLZHp1RklFa29IYTZUc1VxM2FFcU5PSGNFSmdLUWwv?=
 =?utf-8?B?QktvTHFDUlFrakVtMExaODVYNmYrRllnZE1CcnJaNHpTOHFMa1U2RE1SbVpR?=
 =?utf-8?B?NjJ5OHI4ZlB5RUVQYndDcC9hRnhEdDVCN1RIaTRLYVg5UFVZbmJEM1dScHJk?=
 =?utf-8?B?NXMwd05mTlNTemJReUtSaGoyVjVrZVBzRC9RVWZ0alhnNDNLU1hBZlpndHN1?=
 =?utf-8?B?UVM4N1VxY21Bc2pWSnl3cnRvVWNobWJQUWRobDI0a0hXYWJjSW5HTm5sYmgy?=
 =?utf-8?B?L1Z6VGZDaEZFajhTcCtOdmJWS2xwWVNsdll4YkRWbjhuS25FNkVvWmRYU3Zt?=
 =?utf-8?B?MmZFU3hSQTZUaVJmeW41UDJOTjRjR3pPVDNaeHVLWjJVOWQzZEV2S1FnSFdJ?=
 =?utf-8?B?cTJTZ2J2NjdmcUc1VzBaN1dWOXh6b3pVSUMwdjJ5T1ZmWWloMWhxeXpNTXFP?=
 =?utf-8?B?TzdiNzNrckNJdVFWaFJMazJSdlhTbWxqelR1ZFVkbHk0RHVpWURidXcvaW9j?=
 =?utf-8?B?ZmFLVmgrVXYvSU9WcUY0aUZGRkswNStQNHYxV3E4NzNrVXdYN1BKUk8xcHNU?=
 =?utf-8?B?MEFOekpEb3N1elFaQll0NkJnNXJGNlZhREd4aE9ZWFh1RUprakRHeitncEl6?=
 =?utf-8?B?Wk81eGlmZ0pIbHFsVVVCSGRSSG5lT0tVMFpaQk9tNUdrZWpOSERremhURDJw?=
 =?utf-8?B?TUR0bkFoaDlaQjBXdWFjRHFyV1RZdXlVVEVoYWEwaDAycnNkVnJNVmRwSlVK?=
 =?utf-8?B?MnExT0RLSHQ5UDQyUjdzRjNpY2xJUGlRb0xnd0hYWDErQXhuV21jYUZReURU?=
 =?utf-8?B?QWNOS3JxQzRmSlY5VWprSld5dnMwREVsU2lxU21zbVZjS21yN0JoRi9MaHhx?=
 =?utf-8?B?Rjd4TjJFRU1hcUlDaEowQythd2w1dk1RWlIxclpqZENtRWh3aTE5YlZtMDBX?=
 =?utf-8?B?a3pxUWsvNjVjd1k2WUZaQ01FbTd3bEM0RmNPT253QitMVHZadEVnSVo5WHZO?=
 =?utf-8?B?b2ZDeHlrNDQ2a1I3bVEzdzFLZUlreHNOdFhPYmp0QU0wcmFQTUpkNDJPbE95?=
 =?utf-8?B?ZnQwSjRFcVo2b1FWVjJBVG9ZZXJveThTcmgzaXdWd2xZNXNTSnVCcXdrU1Fm?=
 =?utf-8?B?RU5ncHUvMk1IOTBXeVNsVkJwL3VHUmhDWUtoejN1bVNZWjV2emVWOW9aT1Rv?=
 =?utf-8?B?MWZvZWhJdnliQVpobnhndTBGSFlPOFFYZ05CTUU4aHdWU0FHZjdSZXdtRzlM?=
 =?utf-8?B?ZkRpczJwRUFUK0J5THM0YTZRNldrQnF0K3JIUUh4dng3VjErTlJ3eExCaXVi?=
 =?utf-8?B?bUhPSGtHYlBDWTBVUHZybEdyUm9nblNmb1cwS1pPZzB6N3ZwV0pSZ0N1NFZN?=
 =?utf-8?B?a2ZPYUkxS2sxdXR0RW9oRk5yYzcxTEhhZjdlWDRBVURwd3lvNXpVTkZjUThp?=
 =?utf-8?B?Yk1JOE84YXk2L1pvM2ZNcmJpeTNaanpOVDEwNjJmNXRIY0FxWVVyRmwzUjhE?=
 =?utf-8?B?dnFIcStwM2EwVkhvdWp0MXFyR3ZMVDNLNXdmUWNpOHp3bGU1YTRRWnE4SUJP?=
 =?utf-8?B?Q2RzZDc4QjZvU0NGdUx5VWpBWitlSlJBaU9aekdtNXJmTVlVd1JpWlhGLzJm?=
 =?utf-8?B?dkU2cGxsTkptWFg3WFZ0eWVGN3NWUy96Y1g2a2hieDVJL1ZwYkNvNmRPYzRu?=
 =?utf-8?B?ZlBzdWl2ZnlTUUVFSVhZeHFGanJwTDFzU1o2aEtQRVpmdWFrbzdQSzhWNDBp?=
 =?utf-8?B?ZG95d05XV1YxNGZGNWx2WTFZK3NuMmZyYm9UN0VzMGNYZGZ1THR6dUxBNHYz?=
 =?utf-8?B?dnU2U01GZ1p4bmR2RSt0WXVQcXd1UWZ6dEF1c1hvazQ2Umg0QzdqTGt6aFFs?=
 =?utf-8?B?NFhnUXBkNnB3a3NjRmhycGpiekZMa2VzTjdORVhIY0dHQTUvbDVKejlWazlR?=
 =?utf-8?Q?WBE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f2186e-4315-46b6-91f3-08dc43c84712
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 01:44:24.4649 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuNDNIjFOzaDzeKtNEiuuPlF6KJNrgiLcABmKNJj52F+ojeYLGzHQwg5f8kGb0/7snT8rY4rFNj+lWaHDjL00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7887
Received-SPF: pass client-ip=40.107.7.73; envelope-from=peng.fan@nxp.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

PiBTdWJqZWN0OiBSZTogW1BVTEwgMi8zXSB4ZW46IERyb3Agb3V0IG9mIGNvcm91dGluZSBjb250
ZXh0DQo+IHhlbl9pbnZhbGlkYXRlX21hcF9jYWNoZV9lbnRyeQ0KPiANCj4gMTMuMDMuMjAyNCAy
MDoyMSwgTWljaGFlbCBUb2thcmV2Og0KPiA+IDEyLjAzLjIwMjQgMTc6MjcsIEFudGhvbnkgUEVS
QVJEIHdyb3RlOg0KPiA+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPj4N
Cj4gPj4geGVuX2ludmFsaWRhdGVfbWFwX2NhY2hlX2VudHJ5IGlzIG5vdCBleHBlY3RlZCB0byBy
dW4gaW4gYSBjb3JvdXRpbmUuDQo+ID4+IFdpdGhvdXQgdGhpcywgdGhlcmUgaXMgY3Jhc2g6DQo+
ID4NCj4gPiBIaSHCoCBJcyB0aGlzIGEgc3RhYmxlIG1hdGVyaWFsPyAoSXQgYXBwbGllcyBjbGVh
bmx5IGFuZCBidWlsZHMgb24gOC4yDQo+ID4gYW5kIDcuMikNCj4gDQo+IEFjdHVhbGx5IGZvciA3
LjIgaXQgbmVlZGVkIGEgbWlub3IgdHdlYWs6DQo+IA0KPiAtdm9pZCBjb3JvdXRpbmVfbWl4ZWRf
Zm4geGVuX2ludmFsaWRhdGVfbWFwX2NhY2hlX2VudHJ5KHVpbnQ4X3QgKmJ1ZmZlcikNCj4gK3Zv
aWQgeGVuX2ludmFsaWRhdGVfbWFwX2NhY2hlX2VudHJ5KHVpbnQ4X3QgKmJ1ZmZlcikNCg0KSSBv
bmx5IHRlc3RlZCA4LjIgd2l0aCB4ZW4gdmlydGlvIGVuYWJsZWQuIE5vdCBzdXJlIHdoZXRoZXIg
Ny4yIGhhcyB0aGUgaXNzdWUNCm9yIG5vdC4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gYnV0
IHRoZSByZXN0IGlzIG9rYXkuDQo+IA0KPiAvbWp0DQo=

