Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52365D1CA19
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8AdG-00062J-U8; Mon, 04 Nov 2024 22:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t8AdD-000629-Lj
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:53:27 -0500
Received: from mail-sh0chn02on20710.outbound.protection.partner.outlook.cn
 ([2406:e500:4420:2::710]
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <demin.han@starfivetech.com>)
 id 1t8AdA-0001mR-AU
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:53:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyteUxbKHq+TqFS9sybtIL5sUUqTL+9jGauT9xGKu4j5GjLqaaW1AkGTIKnoxoIBfwUZoq0IwyIZGUX26Y2lr4lt2WrhAhoU9vmtYvjavwS1iUk3s3T3y0RMR1EOaxEmBessW8BGbzbvQ/fFCLmeKxVaxbvmznmCRu5zlkmH3V+EUAgKVKmwgxxO/X3Bf9wa5ZSsMLlrcZn/bkOH65cyc3Fe0JbhJQoVyakjT85p55KpFaCSGhUiLKQ7u/RWCzSLyOUrtSx1hpVEKTHAeFaHM4+Pslrb0xsa1neCS8k94CtKrX0g4aaFYtDwfaNFsjoKwBH1f75QjR85SpktwXNxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fc7SDmYsd0VaYtRsqeTmidmZZ5LhnOj0KOv+EwSyMcg=;
 b=c1pUp+nUAsdMZ0qzr6biYdBtRlbRXP657vFz7Yo1VcSlBVF7WgpUvnoH5LLHnyzlzD8vR84h0FJroPpgF0D9qKnPFAdzeeX2q01QWJSFx/s5JLS/0oytu3KOwPa9bcC8o0V/k7m6UsQZFkwoi6Hy0khnzJlu+JP+O1YA8O5tuiRNZriFZQcYku/aYqtPuM27LKwb1AUZ0gmPPlof0oEdd0p5c4y5xSpzYT+BFte8oNRoFmXqKWuC8ApPfdngtgSAYDq0TWeByAINXKtL6twA1hvKR21xs2lemMcmA3M6jPQ6QDCw7cOaE6UY4GvvRfCg4YIsnfov3GHUKG+VNnPxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:d::13) by ZQ0PR01MB1125.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:53:26 +0000
Received: from ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
 ([fe80::7c03:71ed:a774:fa31]) by
 ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn ([fe80::7c03:71ed:a774:fa31%6])
 with mapi id 15.20.8114.023; Tue, 5 Nov 2024 03:53:26 +0000
From: Demin Han <demin.han@starfivetech.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: RE: [PATCH] plugins: add plugin API to get args passed to binary
Thread-Topic: [PATCH] plugins: add plugin API to get args passed to binary
Thread-Index: AQHbLDyPsgVEn9ocvUKmJf5ZUtvEebKivGIAgACzPfKABDb8gIAATDEQgAAPgoCAAATocIAACnOAgAAAf2A=
Date: Tue, 5 Nov 2024 03:53:26 +0000
Message-ID: <ZQ0PR01MB106328C5544D5AD7E3C00A2585522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
References: <ZQZPR01MB1057EB3713C55BC9F53ADE5785572@ZQZPR01MB1057.CHNPR01.prod.partner.outlook.cn>
 <ec546d66-0ecb-4294-b8c6-a7f2c2a6e534@linaro.org>
 <ZQ0PR01MB106322463E0A1A23E750901285522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
 <5fe9698a-33e2-467a-a1e3-111946dbe960@linaro.org>
 <ZQ0PR01MB10634725F7B08B6684EEB36685522@ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn>
 <dbd64940-c21f-44d2-9ba1-0bdf25f5391a@linaro.org>
In-Reply-To: <dbd64940-c21f-44d2-9ba1-0bdf25f5391a@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1063:EE_|ZQ0PR01MB1125:EE_
x-ms-office365-filtering-correlation-id: 94e5eebe-cdcd-4fef-f352-08dcfd4d6718
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|38070700018; 
x-microsoft-antispam-message-info: qvMg0EPnjd3Q7754DVoVzQsuBhsCDehf34P+giPSqe9pI/HchreNAU/x6h/RScPMp+jVfHU5aVPitxB0Gm3IvKXqJ+edfdMB4pjvR6jWyl34IiEOQk+zCbXNnGN5VzRxOroVSYFdo8Rv65eGTzte4htI8QVWq9h2jU6Mi/zf5R35mbz20EKjEIMO4VsQ7B3EroX96tWx8HbkSrvUFicsXhD+9afGdA2s/PZ4W+j0w1E0Hc2H5Z8PVcaTuUjH/o7qejAkkyuXZFQ/UI9aCdt4YGr41Zr5CsJqH+G78tXNF1CnOS8AKidGPATdbO17fnkk6H7DB4Z5oz1fiVk8/aYaJPs9JLuPKrPWTjka1fUFVE1uMadGREJ2Cn8K5S5Jc8pyxM5v7jeMBcTge/uvDK3o/HCMIvPjJVOjA9CDYJHPdtdSgAJDzMStfLN/tIUp9TJd9KnKguAy1/FqO+4fFuqQdRyhBmiZxZm3yIPIhxrm9fpP78HUlw85+2xRfMcSTZ1WnbiFf8T7L5kTvUQ9BWGsaJDf5IMTiX6sZr6jPuCzz5xNSZnAPkXi3wI4Lpj94JFqv0JlTVLMzvskMxAwg2qsssRGwp3clcERjYK+c2SwbXH/jBQsBMs7wxm0M0gCln7f
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zNhZgPp4ZWfNf7H/K44mG6HM2kcOznMHmPaeA/qDCCHUuNOMmNI97uyQ9Kbx?=
 =?us-ascii?Q?x5EjH2YBp/fln+i3+pHqw8AAZl698p8SZYA0DVTe1ghWKYCdISgX0fVr/5Kn?=
 =?us-ascii?Q?tdfcd+fdd/3fzDYNRaaoYAQtJQTm4UDFgGUSohmeodKpyLYOgS0vqk+YT47+?=
 =?us-ascii?Q?G/8ZGcyfIPZ6FsTSIIhml1N08sFCGhFJ0h4mWhwUnic5j/HB+tQMQJd39UcQ?=
 =?us-ascii?Q?ePxduZ5unmCq8EkvGxCzxgQebYbjngpUA3z6BmJGVDZO/f/odvpa3JQkVhjl?=
 =?us-ascii?Q?mkKFytLeHFTHDuucGAZ6TlGHOUy3AuXE1coWtxVfDQZAhCkyUXJGCXcFtXzD?=
 =?us-ascii?Q?22numfmlze1RXNcJ2rxbLucPaawbTBdDiJa81aFQwjW60LMy31fXCZGm/wVU?=
 =?us-ascii?Q?HdY82BKLeEFtKdeQgaTdhyh308R5IFMe/T0Y05y8QSyXtEEvkE2vt7/SIHym?=
 =?us-ascii?Q?QmIP0yIJCVW357NrCXdQz9gY7CdY3xa/0e8Cf98/RdHT0sbNrMvpi37f3yEA?=
 =?us-ascii?Q?iP+y+dFe0474jXPtzcjbjhRbUNha3dg3W+fSHiG2BPIGAJ59UOQSQ+FH/KmV?=
 =?us-ascii?Q?myHVbowiw8+Aj3U1y8gRth7fn49ajcqNS0Za8h36GxK1XKDmqBlphtgRDGRh?=
 =?us-ascii?Q?rtZdGmLJNAfrcjuZ2qlMkVMsQrrGo/MJU1R83gnvyhFDsJqbVTJcPEmH7pPf?=
 =?us-ascii?Q?mt3/y9amYg88wY1Wbt3fMul/pT2q4SJDWY3d1a9SbmAN8HIsC7Zml1iZkYh+?=
 =?us-ascii?Q?v7fmW19nT2j9k2m5qXsQnhKcVJL3JxF1iIYCoEf2IOYTGakFvYN4cL1UnSBU?=
 =?us-ascii?Q?iAE/v7U9sEZfGawekuXzAjl+jrOQzcM+Zb79pyu8XxpTqghFo5pFhxleaJ/3?=
 =?us-ascii?Q?EIvPx8QgYQPHt+wGdwoQ/PRBKIIK5/bMHuQOL3hvX7KhL1/OorjN+R6iR8Q3?=
 =?us-ascii?Q?C7tS9ln7QgBq/AtcK/TewAqwHYmT7JwyYRAo90hQdXCHIZSOfbq/eDuxpJYE?=
 =?us-ascii?Q?8wn+3CdIhhiwea+t9O0VciB+aH/CQudXg6V9yc5AhRNUGmRbDHRuhc+nBiUE?=
 =?us-ascii?Q?HfzLeN9bo3LJRaAfn1/RuSUPMTCAvFBHjh3hbaH0Lao5s12tiwNyuW8Oj34W?=
 =?us-ascii?Q?0cXCNIH5hTJbYGHxQoj6UXdtnzPeRt35aowROqs3mnIh2A8jp/t5JfB8ZynF?=
 =?us-ascii?Q?hQbFWjddd4+PHTyVCK08DcxFg0JWZ1lLaXkKTZqe0YsZOqCtwMdd3QdAKqH3?=
 =?us-ascii?Q?NFHj9dSwU87qg+XyH/PT/E9B2la73n7Fqk8UHYi8W9QOZdoR5Hy8T2CDnFBY?=
 =?us-ascii?Q?ixUR8MHuV1466swe3LvQpN1IFAu1mYB6QsdoMn564UTktC+bOCgmtJO8UKyd?=
 =?us-ascii?Q?209gjvCjnHnhiI9DR/igu6vLdoQyarLVxwyz8nfc0IcVcstxspsTABj7L7w5?=
 =?us-ascii?Q?+EJYScNJbrasq66ymT15DODeg5+EYDPRkwYoBuJPeWdds3IA8QwNUSqcsBY4?=
 =?us-ascii?Q?V6pTMPN91VeLO+j40FM2+Vn6vlmUuVRFPmf1ubgEC5A1YQLmDi56cxR4Jste?=
 =?us-ascii?Q?TZ9hzUs9SwpuX8B+kLwjeFushIim2/B9ISNBWK9Y?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1063.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e5eebe-cdcd-4fef-f352-08dcfd4d6718
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 03:53:26.3376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5j0k/yOfygHN+n2I7mmL8JRMPoj3GPLhLFNtGiT/4phww3Ml2qqdNCNXVKBpx4rNKMXGoG6mlRnQp23/bi21LE1eHDXx7qSNeFXytyQHXUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1125
Received-SPF: pass client-ip=2406:e500:4420:2::710;
 envelope-from=demin.han@starfivetech.com;
 helo=CHN02-SH0-obe.outbound.protection.partner.outlook.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

>=20
> It seems that you already have a wrapper script (qemu-risv64.sh). You can
> replace it and read command line from $@, which contains the command
> passed to it.

> >> In the case of llvm-test-suite, you can set TEST_SUITE_RUN_UNDER to a
> >> wrapper adding a specific plugin, its options, and generating the log
> >> filename as expected.
> >
> > We cant set TEST_SUITE_RUN_UNDER=3D"qemu-riscv64 --plugin
> /xxx/libxxx.so -L xxx".
> > We have no any information about binary under test even binary name.
> > We can get binary name in plugin using qemu_plugin_path_to_binary, but
> can't solve the issue mentioned in commit msg.
> >
>=20
> If you pass a script instead, calling the same command, you can get acces=
s to
> command line by reading the content of $@.
>=20

Thanks.=20
I think this can work.
Add a arg to plugin and pass the parsed $@ to it.

Regards,
Demin

