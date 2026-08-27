Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FCAC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:48:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzeCp-0000mu-H1; Thu, 27 Aug 2026 13:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wzeCo-0000mP-5n
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:48:02 -0400
Received: from mail-southcentralusazon11021077.outbound.protection.outlook.com
 ([40.93.194.77] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wzeCm-0003nv-8Y
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:48:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVpy44dViicC0HLmCBVk2BiABNHgcxRFYiH8L1gazENHQbvZl0KMYkY0u7Z9vp2lAp9NgJf480CcbytxO7s1Cu1LBRv9F4MEqQn/G0w6SOLH471okxF2DNIR2Ciy5kCYKqW/REZWEho6hDmsKvOc47+1RaUGtJq2BJbrF1U/jjaVuBUF50OlaxdyyDEYxWhkhcOJw85u4WYJIXUe/kmME+8Qa5kAyfw2oHQ6iOy1lhS0n4JLAlD+uD4nKq1EYwQNUde9QhzKvIxqh0cMUvpT0bWDeKw3KJje69awaahRQLDM9nBEgGl/FT/c5yIRdiGk3T5ZrcN4A1EVHpXbN8EPdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHpWwIqy/KrogLeHN+Ev3oxAIe3X/of/ctzzAWoQBEg=;
 b=V1wwlgRNiUrrjnMRSw2Yg6fC1m8mW7bdJl4HeCoH15kYRxCnb/HtkFCC4XKmxUVHtbiUTfMLzp1RppclDD1XnXAag0Uhgdx3ZmuET8tbgu3eVZz6pgG5vbgcoCu4qXCsdrVipZMJiBrSIGwjgu9RSkm2Zp639cNnKV1eIrlND8RmDwAp4KBjUbQX4CrT0P7NTaJLDhMk/rxNP+ObbsXW/Riiois9nrt46kJ6BZJpvI8ss9bZuguXEy3wKmIUW56eQeBDPFDsUYHm52cIW8BC7MBr5Ir5lGgZfUv+77N3DNABVQi+OoVcpWAHSxWt/Elg/ASYNm26EzISMj4a0UQDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHpWwIqy/KrogLeHN+Ev3oxAIe3X/of/ctzzAWoQBEg=;
 b=je7QAsD1Ed7gM36oIzWGb1PFvcUEFydUTrwblEj0ezIgvQPgdrG7Kwh4SJ/WSxm5tJKgZmeAwlbVBNZLkeSheqPDB4qgUHYafMkReX0NHFG3BI+R+cQliOZtKsQLlESTyB1F8MrJ08nquGts7jLy8CmSRbpymah0Z2JIUB3PE4I=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV0PR21MB5871.namprd21.prod.outlook.com (2603:10b6:408:325::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.8; Thu, 27 Aug
 2026 17:42:48 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Thu, 27 Aug 2026
 17:42:48 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pedro d'Aquino Filocre F
 S Barbuda <pbarbuda@microsoft.com>, "mohamed@unpredictable.fr"
 <mohamed@unpredictable.fr>
Subject: RE: [EXTERNAL] Re: [PATCH v2 1/3] target/arm/whpx: Don't try to sync
 ARM_CP_CONST registers
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/3] target/arm/whpx: Don't try to sync
 ARM_CP_CONST registers
Thread-Index: Ad0wOvX2qf7SkON1Qpqx4e66jheGCAF67s0AAAkKEaA=
Date: Thu, 27 Aug 2026 17:42:48 +0000
Message-ID: <LVXPR21MB7009D2EAFF7713ADBB41E543ADAD2@LVXPR21MB7009.namprd21.prod.outlook.com>
References: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
 <CAFEAcA9h98dHUim+rsaebTtmbpD3LLPKenyD8U07+vxwqASxfw@mail.gmail.com>
In-Reply-To: <CAFEAcA9h98dHUim+rsaebTtmbpD3LLPKenyD8U07+vxwqASxfw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e4ece581-14d4-4b9e-82f0-36ad9d8b311c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-27T17:38:19Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV0PR21MB5871:EE_
x-ms-office365-filtering-correlation-id: d7c7f93e-66c4-42f9-2fde-08df04629c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7146999003|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: ZnZQQ4mdon1InVkDHPpiBi9mQbffZqeV9tDeqFC8YJxIVHrnKmf/oDoeLhyv5e11OVFGUeKLrcvYhaExMJhV4l9mbft/efyrv3XCFBDKXY3jD19f2Ls2xhhShL65mmhrg0jbKS2HhXxpS9u2e6dR659JCaTGib8kS/WfTzjf8rLGtfWrz5bMAa4eKriKHVW1Lz+Ft15PjfQx1uxfW7aGwjppM0jspho7/0wj0JbuUP264Vw5Dk1swmS3rWMb0p53nyEJqRlFaDrT1OeE4TKpnkkDbFnH5P2ijRJXqqi7gYkk9eytEO/dMcCNFSma9UmfibZ9/bgBZijh3d3IeYNaFeKca0ReYizAGc8SXWI2o54po1Bsu3kTGgG6/kOPSVLQbnhxhZ8t+o0vmDafK9hbbsRbnfL2AfEVWjb6LJJxbPaksfQZiiU6bOnwuWWXb6UWtM5LS7eBOR63G+PDdMAzoJm9oUuwe3EPesqPDUsBiOQ0Z4Xn9AIPN8Q6j5meMVqqkPURSS+BNkHYQ8XMOSq8dkPTfLA8WVDw2RoAkXihR4vIpnIlLqvFHHCscYK9dEeoizkLx5FYcBezVCYbbdot62nHh/HnpIw0eDC/QdSsNbQMHvMmdyTOjxLd38saDGBDLi2xw2g3n1j2HU0m6+QZps5MZXhZ9qrEjVtk0+xeru8ONAEMfLuiCojGz4tno6oy8qcXGJ7nbnWNZi+FO9HrjjDytZhqkU1VzRMlz5BRSX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7146999003)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTFvbTY5OUowaXpQSlhJYlNMYzVrcGFmU29lSVFaMjlJV2ZKN1JuSlJvdkgz?=
 =?utf-8?B?TDIxWlU2Z015VVUyMTBQaFdHM28vY0hhbVhXbkFLNnZZeHdWbnZGTWZGR1d6?=
 =?utf-8?B?RXV3RWxVeGtJMjI2OC9SeUkxSmd5ZS9jTWpXeEJHZkRJUUdYTjVDelpoNi9o?=
 =?utf-8?B?NXFRTlVwSWRqV0xtcmNnN3FBeWJ1am1ERXIwRFcvcEdhY3Z5bVhOUkhua1Ev?=
 =?utf-8?B?QkhhNEVrZU0xSzd5SndveXkrSmJkYm5sVGRnYkN3WG9Gcmkrem40a0pJVTlt?=
 =?utf-8?B?Q2FENFc3eGpwVW9vdTVwZ2FHcVB3ZWpEVnZ4dFZseGZ4STFFMWRGZjNXZFRG?=
 =?utf-8?B?Njh4KzJPZGI0U1BWUnMveGhqaDVWeFhZTHJCME1IZzRxV254azM0cXl3QTBE?=
 =?utf-8?B?ZGpDSXVnWFY4KzZMOXkwcTg2ZXZxVjV4SnpseW1zMGE1eWF3ZDM4UVVQbWd0?=
 =?utf-8?B?QzhEbStGSkErZTdmb1dnY1NpNEdYYjJCbVE5YTJYZXU3ckp6ajVZU3Q2VzM2?=
 =?utf-8?B?SmtoUWRxcWgwLzljMFEvYmR2eGJ0R1JMN3I1SWs5dnQ3ME53MjVOMmoxTDBm?=
 =?utf-8?B?eEY2RUR5SmJRZ2lYdzZNd1dGOXZNb1ZUYVJ0d2JObmI4ckVkTGxNWWxZZlRL?=
 =?utf-8?B?OGk2b1haR0kxd1JWZVNJS0xhNy81eUp4QmszTVpyNitMRi9xZUpXTVZkZkpD?=
 =?utf-8?B?clY2QzMwcmtETDg5QXh6K0gvSFAvVFJRcjJpZ0VDdHNmaURUWHQyTTljQTlQ?=
 =?utf-8?B?K0VoS2d3bFJRUm0yYkVMazVnWEVjb3pBb0xaVUllYkxCZEZQbTlsN2dzNHJr?=
 =?utf-8?B?VmhGQk83TjNYVFNTUWNnblNUY2pNQllFQjU2WC9aSThpdDliOHFiK2l2NENC?=
 =?utf-8?B?UXIvVWR4cEdpNkNkVFVKNzhONUZYeTBRQ1pLNDBRUmVZQm45ZmdEemJsbTh4?=
 =?utf-8?B?T3hrZTU2ditYeVpKeHVha0MwWTdIdVVqYkgxa25nMVlCQkdvVGJqd1dmbGIr?=
 =?utf-8?B?a0UrVC9XUVIzZHhTZ0dGb1JKUE03eGl0a0c4SXRCbzdBSDh1aGVOZmdtZldF?=
 =?utf-8?B?MlI3T01IdnQ2bW5JdUxtQ2MzZGxmTVdnRUN3c3UxWUJTK3VQQjNCZS9SMnRF?=
 =?utf-8?B?VWxXcXcvL3NOcjJzV2VWaHFlQkkwWEhxajgvOHprZkwvU3l6WXN6SGdBa2Iv?=
 =?utf-8?B?M1ZLUG9jcE5VWXJjN3V6RCsyaU9UaEhzT3RWY1lKdGdQTFNOcm4xZVk0TEcz?=
 =?utf-8?B?T1dEcTZta2tleVozUWI5d1RWSGpCbjd5STZNLzJaVjZ1TCt5R2kzU2djREQ0?=
 =?utf-8?B?UjZPbzlmaysyZkZJc3pvVGZoOW1CeHFjdUM4aVRvTTRHYWdZMyszbDlHZ2Z4?=
 =?utf-8?B?Q0tRcHJmVXpsbXd5RmhFT2QzTG4rRS9OTU1FWVN5M0tMOGU0UVpweFYzSVEv?=
 =?utf-8?B?eDl6YjREVStqQXJQMlVPVk4vdFVENTdPU2RQMWRibEt1RzJ3RGQxSGFtT0Rl?=
 =?utf-8?B?M1NVb1daMklyeHdQY1pPUzZvWWFxanFVRDZsVjdkL1drTEsvRVJ2VzY5MFJR?=
 =?utf-8?B?aDBPSWlmS2orWm1qZkNGWUMwbE96c1RZenVoVHA1ZC8vbFBkL3ZwVUJnV3lZ?=
 =?utf-8?B?K1dkbXRJaDltSk9DTGRySHRjZ0Y2QVg3Wjd6Y3lXbVVGWDNxU3g2UFowamVs?=
 =?utf-8?B?L1NCQVZna2FuRjk1RkQwUDRxZGQwQTBlbnNTbVlnWVM0dWk3VU5xUTJQbkJN?=
 =?utf-8?B?MnpZTjd2dTRQdlordlk5VklWWEFoVzBoNlNzUnBQdk5Jem5GV2xwRk9nYm90?=
 =?utf-8?B?R0t3VEFmQjRKV2JPemFTcWlUZU9QeEdwdUJLcDRJSmdUTW01cWdXQlRrSFN2?=
 =?utf-8?B?OWpxZGgvcFo1YUYrQllJRlp6TDA5TGQvWXUyK21ZZ0dMeFFMVWczRk1pMGRo?=
 =?utf-8?B?U096NVNSZ1c0REsrQ2QyeXNBTjRqa2FrK1NhcitGTjJMV01nd2tJclN1dHg5?=
 =?utf-8?B?TzhMd25pYVd5N2ZRN3JVSEFNbkhEeVNuemtteWZObWtuZzdBV25LbWlnWUNJ?=
 =?utf-8?B?bjIwZ3lFRDNCejV5OVdlcFRtbmJzaEM2QXdXV05ZaGtoY1lObnpoNlJDc0o4?=
 =?utf-8?B?c2dwaGM3Z0g4Y3JJVTFjNk9YSW12TWVoaDkxWnJ3ZGdPbm5qMjgwVVMrMUs3?=
 =?utf-8?B?TnFZbDA5OTg3d1I1Y3hSVXJkZ1pwTXBzcy9vdmhEWGxLNlRaSXBoL01DczRU?=
 =?utf-8?B?aVV2M043N29WUEZ4MnFQbHJrZXNDT3ZBZXdzVVIyTmx2dC9pdEpiMXIyMTNr?=
 =?utf-8?Q?XKhJYVezklay+4KG8d?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c7f93e-66c4-42f9-2fde-08df04629c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 17:42:48.5283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6j5KYF/015VpY4ohv3vDh5CiCHUH02dGs25c08jx0iTAeF6qOHUg0D/jFA2WLRjzDH4fQZE6KYZDnMybmcQNaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR21MB5871
Received-SPF: pass client-ip=40.93.194.77; envelope-from=dcook@microsoft.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

PiBGcm9tOiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+DQo+IFNlbnQ6
IFRodXJzZGF5LCBBdWd1c3QgMjcsIDIwMjYgNjoyMCBBTQ0KPiANCj4gT24gVGh1LCAyMCBBdWcg
MjAyNiBhdCAwMTozMSwgRG91ZyBDb29rIChXSU5ET1dTKQ0KPiA8ZGNvb2tAbWljcm9zb2Z0LmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBBUk1fQ1BfQ09OU1QgcmVnaXN0ZXJzIGlnbm9yZSB3cml0ZXMs
IHNvIHJlYWRiYWNrIGFzc2VydGlvbiBmYWlscy4NCj4gPg0KPiA+IE5vdCBhc3NlcnRpbmcgbm93
IGJlY2F1c2UgYWxsIGVudHJpZXMgaW4gdGhlIHdocHhfc3JlZ19tYXRjaCB0YWJsZSBhcmUNCj4g
PiBpbnZhbGlkLiBOZWVkcyB0byBiZSBmaXhlZCBub3cgc28gdGhhdCB3ZSBjYW4gZml4IHRoZSB0
YWJsZSBlbnRyaWVzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG91ZyBDb29rIDxkY29va0Bt
aWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQvYXJtL3docHgvd2hweC1hbGwuYyB8
IDUgKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL3RhcmdldC9hcm0vd2hweC93aHB4LWFsbC5jIGIv
dGFyZ2V0L2FybS93aHB4L3docHgtYWxsLmMNCj4gPiBpbmRleCAwMGE1ZGU4Y2RjLi45YTVhNTc1
YjVlIDEwMDY0NA0KPiA+IC0tLSBhL3RhcmdldC9hcm0vd2hweC93aHB4LWFsbC5jDQo+ID4gKysr
IGIvdGFyZ2V0L2FybS93aHB4L3docHgtYWxsLmMNCj4gPiBAQCAtMjIzLDYgKzIyMyw4IEBAIHN0
YXRpYyBzdHJ1Y3Qgd2hweF9zcmVnX21hdGNoIHdocHhfc3JlZ19tYXRjaFtdDQo+ID0gew0KPiA+
ICAgICAgeyBXSHZBcm02NFJlZ2lzdGVyTXBpZHJFbDEsIEVOQ09ERV9BQTY0X0NQX1JFRygwLCAw
LCAzLCAwLCA1KSB9LA0KPiA+ICAgICAgeyBXSHZBcm02NFJlZ2lzdGVySWRQZnIwRWwxLCBFTkNP
REVfQUE2NF9DUF9SRUcoMCwgNCwgMywgMCwgMCkgfSwNCj4gPiAgI2VuZGlmDQo+ID4gKyNpZmRl
ZiBTWU5DX0NPTlNUX0lEX1JFR1MNCj4gDQo+IFdoYXQgaXMgdGhpcyBpZmRlZiBpbnRlbmRlZCB0
byBkbz8gV2UgbmV2ZXIgc2VlbSB0byBkZWZpbmUNCj4gU1lOQ19DT05TVF9JRF9SRUdTIGFueXdo
ZXJlLiBJZiB3ZSBuZXZlciBkbyBhbnl0aGluZyB3aXRoIHRoZXNlDQo+IGFycmF5IGVudHJpZXMs
IHdoeSBoYXZlIHRoZW0gYXQgYWxsPw0KDQpUaGlzIGlzIHRoZSBleGlzdGluZyBwYXR0ZXJuLCBh
bHNvIHVzZWQgZm9yIFNZTkNfTk9fUkFXX1JFR1MuDQoNCk15IHVuZGVyc3RhbmRpbmcgaXMgdGhh
dCB0aGlzIGFycmF5IGRvY3VtZW50cyB0aGUgZnVsbCBsaXN0IG9mIHJlZ2lzdGVycy4gVGhlDQpJ
RkRFRnMgZG9jdW1lbnQgdGhlIHJlZ2lzdGVycyB0aGF0IGFyZSBub3Qgc3luY2VkIGluIHRoZSBu
b3JtYWwgd2F5Lg0KDQo+ID4gKyAgICAvKiBJRCByZWdpc3RlcnMgYXJlIEFSTV9DUF9DT05TVCAo
d3JpdGVzIGlnbm9yZWQpLiAgKi8NCj4gPiAgICAgIHsgV0h2QXJtNjRSZWdpc3RlcklkQWE2NFBm
cjFFbDEsIEVOQ09ERV9BQTY0X0NQX1JFRygwLCA0LCAzLCAwLA0KPiAxKSwgdHJ1ZSB9LA0KPiA+
ICAgICAgeyBXSHZBcm02NFJlZ2lzdGVySWRBYTY0RGZyMEVsMSwgRU5DT0RFX0FBNjRfQ1BfUkVH
KDAsIDUsIDMsIDAsDQo+IDApLCB0cnVlIH0sDQo+ID4gICAgICB7IFdIdkFybTY0UmVnaXN0ZXJJ
ZEFhNjREZnIxRWwxLCBFTkNPREVfQUE2NF9DUF9SRUcoMCwgNSwgMywgMCwNCj4gMSksIHRydWUg
fSwNCj4gPiBAQCAtMjM1LDYgKzIzNyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgd2hweF9zcmVnX21hdGNo
IHdocHhfc3JlZ19tYXRjaFtdDQo+ID0gew0KPiA+ICAgICAgeyBXSHZBcm02NFJlZ2lzdGVySWRB
YTY0TW1mcjFFbDEsIEVOQ09ERV9BQTY0X0NQX1JFRygwLCA3LCAzLA0KPiAwLCAxKSwgdHJ1ZSB9
LA0KPiA+ICAgICAgeyBXSHZBcm02NFJlZ2lzdGVySWRBYTY0TW1mcjJFbDEsIEVOQ09ERV9BQTY0
X0NQX1JFRygwLCA3LCAzLA0KPiAwLCAyKSwgdHJ1ZSB9LA0KPiA+ICAgICAgeyBXSHZBcm02NFJl
Z2lzdGVySWRBYTY0TW1mcjNFbDEsIEVOQ09ERV9BQTY0X0NQX1JFRygwLCA3LCAzLA0KPiAwLCAz
KSwgdHJ1ZSB9LA0KPiA+ICsjZW5kaWYNCj4gPg0KPiA+ICAgICAgeyBXSHZBcm02NFJlZ2lzdGVy
TWRzY3JFbDEsIEVOQ09ERV9BQTY0X0NQX1JFRygwLCAyLCAyLCAwLCAyKSB9LA0KPiA+ICAgICAg
eyBXSHZBcm02NFJlZ2lzdGVyU2N0bHJFbDEsIEVOQ09ERV9BQTY0X0NQX1JFRygxLCAwLCAzLCAw
LCAwKSB9LA0KPiA+IEBAIC03OTAsNyArNzkzLDcgQEAgaW50IHdocHhfaW5pdF92Y3B1KENQVVN0
YXRlICpjcHUpDQo+ID4NCj4gPiAgICAgICAgICByaSA9IGdldF9hcm1fY3BfcmVnaW5mbyhhcm1f
Y3B1LT5jcF9yZWdzLCBrZXkpOw0KPiA+ICAgICAgICAgIGlmIChyaSkgew0KPiA+IC0gICAgICAg
ICAgICBhc3NlcnQoIShyaS0+dHlwZSAmIEFSTV9DUF9OT19SQVcpKTsNCj4gPiArICAgICAgICAg
ICAgYXNzZXJ0KCEocmktPnR5cGUgJiAoQVJNX0NQX05PX1JBVyB8IEFSTV9DUF9DT05TVCkpKTsN
Cj4gDQo+IEdlbmVyYWxseSBzcGVha2luZyB0aGUgaWRlYSBiZWhpbmQgaGF2aW5nIElEIHJlZ2lz
dGVycyBpbiB0aGUNCj4gY3ByZWdzIGFycmF5IGlzIHRoYXQgaXQgY2F0Y2hlcyBjYXNlcyBsaWtl
IGF0dGVtcHRlZCBtaWdyYXRpb24NCj4gYmV0d2VlbiBkaWZmZXJlbnQgQ1BVIHR5cGVzIC0tIHdy
aXRpbmcgdGhlIElEIHJlZ2lzdGVyIG9uIHRoZQ0KPiBkZXN0aW5hdGlvbiBmYWlscyBiZWNhdXNl
IGl0J3MgdGhlIHdyb25nIHZhbHVlIGZvciB0aGUgaG9zdC4NCj4gDQo+ID4gICAgICAgICAgICAg
IHdocHhfc3JlZ19tYXRjaFtpXS5jcF9pZHggPSBzcmVnc19jbnQ7DQo+ID4gICAgICAgICAgICAg
IGFybV9jcHUtPmNwcmVnX2luZGV4ZXNbc3JlZ3NfY250KytdID0gY3ByZWdfdG9fa3ZtX2lkKGtl
eSk7DQo+ID4gICAgICAgICAgfSBlbHNlIHsNCj4gPiAtLQ0KPiANCj4gLS0gUE1NDQo=

