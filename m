Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533B0F43688
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg2h-0000Tn-2L; Fri, 17 Apr 2026 06:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2d-0000TE-8Y; Fri, 17 Apr 2026 06:03:15 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2a-0006gN-W0; Fri, 17 Apr 2026 06:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpA6l3ev0i9CFqb3Sh/UyiKwosaOu2zEPnp6pzDdaXk4RX/GtQ+mADQpDzVdfurE82KpqUrjNXgUzFCgrUmuVK1xjzLFamX9FzfxnRYz9C2rhLu8eft5W37IAmVge3TJR8u7HjdFsyWuUGnFLPRgHc1UDilLcS/jbeecPen4tMsQG8Lwa/NU2VmPRc2LLR1/JO2Eagef660j4XFWpviqzlA/OIB6L9Fk/6xap8nv7nhpv2sOp5VoKuWIogjEtnTkVdKaSijY2iNMpBKgBwrm7BYd/5L5GGWBJUnon0tT3er63syvo8De68y4/jpj0NLkBOR1tMGPcGketyUUrvNsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjMoXj092clrVspvdgAPusK4hBklP27P8dIVn6Voifk=;
 b=iIautEWnkutp8kt/FesJ7RVL3UwrmRhEvmewh0I1J9UxdlOpPJyyv4uk2we6xMmDID5ikse07R2b2IALWo2+tSAsvAAdJpPmF++3mDmnxe3/p9Na9TsLfWZbx+kPzVn6gkdAAPudn8MaBgecEa/9aCLgGWRtL7ceM2zr7hdlTVtcQ9Czm2tvmJXxHHcFgkMwXu9HQdrUdxj8CT5euAv8AQ16Kdjy+NtVeo1UO9zEIJ0+ltRXsCDTsOshSwWqLDEoTX1KlgKR5OFfQ9QgI3ovoWBsd38gefoayx5/1qa8QGgIxcQsOK/7Id24dO4KS1MjJzVZv4Pfo6j17Hv72YsxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjMoXj092clrVspvdgAPusK4hBklP27P8dIVn6Voifk=;
 b=jGbYmK+JmL7dqdVhS9szmewWDTpRydbFTI+NPgz7jq6+Z3StBHfcZgdJFKOUv0GKW7x57Hc/5ABog22EibyppNrQidA60aHiTrA3KV60fjPgbTSmasCUEYe8U54XIkTKGZinNsCYzXAuFcoU3k45wuxPapU8CMed/OhjBgIo5CS4lqxpEx04kJwzIMedTDRH2Tq9Y2Hd4ru78sKPhp+5itPjMDDK18AURa0o9h7Hd6+7n8TvoIvpOubTp5zNbBmoSxbRLdCzKzvbZnrMI/H0IWvzbzi8i0QRzJnbxsd+6FPhWJVDl6THSY9jJw/NaL3zvrGkffPTiVdsr0PQ28NE+A==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AM7PR09MB3736.eurprd09.prod.outlook.com (2603:10a6:20b:10e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:03:08 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:03:08 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 0/6] Add RISC-V big-endian target support
Thread-Topic: [PATCH v7 0/6] Add RISC-V big-endian target support
Thread-Index: AQHczlFkyjaTdyqfYEiNysbF0W1uWw==
Date: Fri, 17 Apr 2026 10:03:08 +0000
Message-ID: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AM7PR09MB3736:EE_
x-ms-office365-filtering-correlation-id: 8638f1e7-929d-46f7-1337-08de9c688702
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003; 
x-microsoft-antispam-message-info: rhS1KutiXKuDdv6woOeFTXNzmT42yku3++5/02TQCsFBVFQ0qdOEL21DyBnCHd9EsroO6+FVx8R7X/pL01UUx/7cSfr7ccGjERKS4N0MvNwMYZdPgG0j2k553xTMwXIZEBbmwOp2Dbg+VF2tpufJOf7pnOXT7Gq3htvlUo/n/DLVOSGm6A13YPRVArsCzKbAa/eKRygZ+rfcWmoDtxSz3eIObYfjVwvKfxkN4PjIR1q2PFWillnDh4CFPirWFK7VSV1UeATzaB34J73YBuqNmFhyg8W7pFBCTigT3VZH8e997KAe15yKf/9BuvKM0hcK+Jd+gxvU9DE+8hsAGOYM8kMd8DpoOnGOfbvT/JbKk7sbil/1CPjYJobMgoYYoFcbEH+RhMxRj/KBTzQyYda8a7SG+XUM58iClYjdvEOxjloqEfPDO0bGK61ZR2TWUC5VLUumjU2/y2fjequSlY2eQld6t4XNBDzH7mgEWwArb7uIXfbEvqHxZQ8rCUrUmOftAeZYwUD1EGqdbDVi95hF6MWpdasaRbuzdA9EbvkezZFV4IHSOT4hyD9ww+MSXpMzSzgI3exokAelrx5H8szeig1BUaRfOYx5Ng5Sc2xlWaPVloogTgjCwj+Tbm+WZzoyq/USlGIh3BvWGnusMZFOrpCrAy9EfHVHSmi0rg2sd7ld8NeWKm+8qDOw9D7zYYtVXgsQUdN8WfU45JEQPHEryIWkzQ0v3u3mXgQttBY6fLrkLCuWFCe1EtexopdaEiGREhQesTy5wSxhlCH4Zr9a2fBUkffxn9dBAEYDhraHAEU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zks0c1hEVkROR2drc21tNmhnS2pYU3pRTGY4SG94cHpFL3M2Y0FYdTlwZEVX?=
 =?utf-8?B?Y2d0ZnA1dWhvOEt1WTZwZmd2ODE4aW45bGpqN0N2dVZzWVlYemFyN0tnVm9C?=
 =?utf-8?B?c1BEVjVlZkErampuNENQS2YxbDgvY0MwbERWalpFUUlJTTllaGpLNTZjc3VF?=
 =?utf-8?B?cmNZekZENTNvRSsvVmpDU0oreWZwMk5nbFROL20vcWZnWHpLQVRqcEo0UVpK?=
 =?utf-8?B?cjNLbzNuSFo4SzdXUm5MRVVieVlnVzhhckd6QVhEWFF3ZlpRLzY2QXlDdWlz?=
 =?utf-8?B?SGVPaHlNR3pMTWlTaFNkSVd2UFgyWjVPK1FoeXEvVklJVnJ2VEtWamRqWUNm?=
 =?utf-8?B?cHY3RHd5bHdsOE1DRUg0bXFsOWxmQ1VidVcvK0JCa2NOQ3MwM21pdHFpaVg4?=
 =?utf-8?B?VDhWcnY0NmhlSFNNdG8rY0hFcHNFYXJvd0xUN2VKcDVJU0luaXVtQlFDRFJI?=
 =?utf-8?B?ZXY5Tlg4N2dyT2JlWko0Vm9DZWt6MVZid2xmNmQ1aURLNEsyTnNDMkNxbWJj?=
 =?utf-8?B?MTNMZlhFUjRMQjlHaHZ6ZjgvK2lSeDJPTmNtVGVqU1RkQzZ5UzdTenducnlG?=
 =?utf-8?B?Smxyd0RBWmNVY09Ga0FObUQ1QTdMWTdSZnhlOUllaHZzRjRYQ0dQZ0JmdzhT?=
 =?utf-8?B?UE0vcHNucGxKWWpEdWZvbU1VSUEzc3lnSkRwMnBLdmlNOGY1eldLd0QydnFE?=
 =?utf-8?B?ZGxINkJvWGd3dU91eXJycmJrZkdQdmxJQVNtSmtLc0FMQmtSSWxYNk54Mldn?=
 =?utf-8?B?TkwrZXVZUTJKeHpKOHYwZXN2ajhlSitOdkdRSFk5VkpvK3E3TEVZV1N2N0da?=
 =?utf-8?B?UmduVktzbk9GRGZnd3o4NlFMSkxhOWF0NDZaWjVvc2tOV0xXWUk5Qk9GR0pG?=
 =?utf-8?B?em5DTmk0dy9MZktLMGFqeVhFWkdadldKcmdzSEREWmJLeG5Ebk9GdS9pcjJD?=
 =?utf-8?B?VnAzaHJIVGZiWDllZWNDUnNCTmZUa283NUEyZjE3QWNFcnBGbmUrMXoxVk85?=
 =?utf-8?B?MU93TkhQd3RmcHdUN1R2VUJJY0ZlVDhrQWFsanFOcEtsUzEyWnFCcEpTLzJj?=
 =?utf-8?B?aldENEhKeHUwMElFTVBPMWgvbUt3QUdpcXFOVTUvREt5Zlp0bFRPWU1xa1U0?=
 =?utf-8?B?NXdKN2FpS3BOOHJqM2FFelFOUTBuVThPdXZqTlF5bFVUYzU2bmY0VkFQc3E1?=
 =?utf-8?B?Z25jNWNMOTZZZ3RkL2wxdTVQK0ZnREpONzAwcGFFOE9RSkJiNEdnTkQ1S2hv?=
 =?utf-8?B?UEkyRkwxanc5YTloY09BWXptK2hWamFwVGdQRWNocWdINEJqY20yYmhLY3R3?=
 =?utf-8?B?djBRVk51VENuamZKOHZyb05zMS8zOTRZTGt2VHppV3IzdXd4Yk5weG1veXZU?=
 =?utf-8?B?bWc1ZUhkV0paRFNueXhQcTF5UHdIYUNYOHhmSU1vV3pPM2ZiTThEOVlTL2dN?=
 =?utf-8?B?YlcwY0gyd2lBOGI2ejQ0YXZLVmJuck9sY2EreDBncFBGbjlTSnZWOWRvc1Rj?=
 =?utf-8?B?ak5UMnFRZWtKWnhNRE1QOFhEcDFlaUNaK0tHQ0R5Uk9tMzVQUmx3b1luTUhQ?=
 =?utf-8?B?eEZENlFrdVRyTkJXNnZMenBZWm1hY0VLeFJuRHd6L29TQ3MwUlNXNzZkSURr?=
 =?utf-8?B?RW5WVFpGT2w1YnVjc3BtV2NPUmhLRXEvSEIyMGx5bktabVNoS3BxY1cyQVBB?=
 =?utf-8?B?cXBqUXFqL2dXSWhLS0MzUFRiQ1dyNmlxbXJpUHgxR01XejVDQXhCdm5tRVBK?=
 =?utf-8?B?ZzBVSW9EV3ozR3FXMWRBWHV1NDUzbjd3QThwZjFEaFo2ZW5JM3RlaVYxWmFr?=
 =?utf-8?B?U25UMTh0TGEzaGpxTGovQVZTV3pzTkVWUDhJb252UDQ4ZE5EWHlIampKY2J2?=
 =?utf-8?B?U3gzY0oxVld3c0ZSQk9jWmpWWERaWXRESGRlUFlJNmVLWVhwaHNManRodVJa?=
 =?utf-8?B?ZUhNQzYvRHR2cmtBR0N4dm9uN05uQjRidllTZm9yQnpraEFoUTJUYk9xaXNW?=
 =?utf-8?B?VXpRUXYzMDBkUjdTeUFrcXZyMis2RFFvOENJa1N5dzAwY0dHS2lrdXRIUFgv?=
 =?utf-8?B?bndYQmVxL05tb3hzd2EzaUJ3MlYxbUU2TjFVOW51TVhRbFVGT1JzR0t2Mk8y?=
 =?utf-8?B?RUZZRnFpVjVTdG1lN3RIeWNYeWtDUUV5MHZackxmd2N5N1J5Ly9nZzlvQUZY?=
 =?utf-8?B?bmtsRU9vYXcwYVoyYnpOWjE1djUvSzM3a3JHZDJUVmRiOUpxWWwzN25kWmdD?=
 =?utf-8?B?cXU0RktOTnFsTkJkRHNnL1ZKMXRTemdTbTNPOUJvQXcxdEd6TExqdGkyMTVo?=
 =?utf-8?B?SXg5aW5zR3RBOVNXNVVwZ1dzRDd0NTV5T2lZVVNZZnpVK1FnUmpkcnNUUWpi?=
 =?utf-8?Q?4tyhsLsG16qPewwvNeS1eR/zgeYFXUVCHW5RA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB5A0A1C895A0B45961CF6A2A1530035@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8638f1e7-929d-46f7-1337-08de9c688702
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:03:08.8154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xx3/10p9bAD26I7/pN5DWHm6+b/OxgFR8GU/WBfqJrS+G+h8v6nphV5Ts28kVj7nkGSkhNDFfefzMBra4W8X/al3LRi/IkAMm76d48jFiwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3736
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
DQoNCkkgYWRkcmVzcyBjb21tZW50cyBJIGdvdCBvbiB2Ni4gVGhhbmtzIGV2ZXJ5b25lIQ0KDQpE
am9yZGplIFRvZG9yb3ZpYyAoNik6DQogIHRhcmdldC9yaXNjdjogRGVmaW5lIE1TVEFUVVNfU0JF
IGFuZCBNU1RBVFVTX01CRSBiaXQgbWFza3MNCiAgdGFyZ2V0L3Jpc2N2OiBBZGQgYmlnLWVuZGlh
biBDUFUgcHJvcGVydHkNCiAgdGFyZ2V0L3Jpc2N2OiBJbXBsZW1lbnQgcnVudGltZSBkYXRhIGVu
ZGlhbm5lc3MgdmlhIE1TVEFUVVMgYml0cw0KICBody9yaXNjdjogTWFrZSBib290IGNvZGUgZW5k
aWFubmVzcy1hd2FyZSBhdCBydW50aW1lDQogIHRhcmdldC9yaXNjdjogRml4IHBhZ2UgdGFibGUg
d2FsayBlbmRpYW5uZXNzIGZvciBiaWctZW5kaWFuIGhhcnRzDQogIHRhcmdldC9yaXNjdjogQWRk
IHRlc3QgZm9yIFJJU0MtViBCRQ0KDQogZG9jcy9zeXN0ZW0vdGFyZ2V0LXJpc2N2LnJzdCAgICAg
ICAgICAgICAgICAgIHwgMjQgKysrKysrDQogaHcvcmlzY3YvYm9vdC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgODEgKysrKysrKysrKysrKysrKy0tLQ0KIGluY2x1ZGUvZXhlYy90
cmFuc2xhdGlvbi1ibG9jay5oICAgICAgICAgICAgICB8ICAzICstDQogaW5jbHVkZS9ody9yaXNj
di9ib290LmggICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIHRhcmdldC9yaXNjdi9jcHUu
YyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExICstLQ0KIHRhcmdldC9yaXNjdi9jcHUu
aCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI4ICsrKysrKysNCiB0YXJnZXQvcmlzY3Yv
Y3B1X2JpdHMuaCAgICAgICAgICAgICAgICAgICAgICAgfCAgMiArDQogdGFyZ2V0L3Jpc2N2L2Nw
dV9jZmdfZmllbGRzLmguaW5jICAgICAgICAgICAgIHwgIDEgKw0KIHRhcmdldC9yaXNjdi9jcHVf
aGVscGVyLmMgICAgICAgICAgICAgICAgICAgICB8IDI4ICsrKysrLS0NCiB0YXJnZXQvcmlzY3Yv
aW5zbl90cmFucy90cmFuc19ydmEuYy5pbmMgICAgICAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9p
bnNuX3RyYW5zL3RyYW5zX3J2ZC5jLmluYyAgICAgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2lu
c25fdHJhbnMvdHJhbnNfcnZmLmMuaW5jICAgICAgIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5z
bl90cmFucy90cmFuc19ydmkuYy5pbmMgICAgICAgfCAgOCArLQ0KIHRhcmdldC9yaXNjdi9pbnNu
X3RyYW5zL3RyYW5zX3J2emFjYXMuYy5pbmMgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25f
dHJhbnMvdHJhbnNfcnZ6YWxhc3IuYy5pbmMgIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90
cmFucy90cmFuc19ydnpjZS5jLmluYyAgICAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3Ry
YW5zL3RyYW5zX3J2emZoLmMuaW5jICAgICB8ICA0ICstDQogdGFyZ2V0L3Jpc2N2L2luc25fdHJh
bnMvdHJhbnNfcnZ6aWNmaXNzLmMuaW5jIHwgIDQgKy0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFu
cy90cmFuc194bWlwcy5jLmluYyAgICAgfCAgOCArLQ0KIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5z
L3RyYW5zX3h0aGVhZC5jLmluYyAgICB8IDE2ICsrLS0NCiB0YXJnZXQvcmlzY3YvaW5zbl90cmFu
cy90cmFuc196aWxzZC5jLmluYyAgICAgfCAgNCArLQ0KIHRhcmdldC9yaXNjdi9pbnRlcm5hbHMu
aCAgICAgICAgICAgICAgICAgICAgICB8ICA5ICstLQ0KIHRhcmdldC9yaXNjdi90Y2cvdGNnLWNw
dS5jICAgICAgICAgICAgICAgICAgICB8ICA3ICstDQogdGFyZ2V0L3Jpc2N2L3RyYW5zbGF0ZS5j
ICAgICAgICAgICAgICAgICAgICAgIHwgMjIgKystLS0NCiB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2
NjQvbWVzb24uYnVpbGQgICAgICAgICAgfCAgMSArDQogdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0
L3Rlc3RfYmlnZW5kaWFuLnB5ICAgIHwgNTcgKysrKysrKysrKysrKw0KIDI2IGZpbGVzIGNoYW5n
ZWQsIDI2MSBpbnNlcnRpb25zKCspLCA4MiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfYmlnZW5kaWFuLnB5DQoNCi0tIA0KMi4z
NC4xDQo=

