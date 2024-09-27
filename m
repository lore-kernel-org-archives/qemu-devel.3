Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D70CEBF83
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 08:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su65k-0007Gh-QE; Fri, 27 Sep 2024 04:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su65h-0007D7-Qm; Fri, 27 Sep 2024 04:12:41 -0400
Received: from mail-eastasiaazlp170110002.outbound.protection.outlook.com
 ([2a01:111:f403:c400::2] helo=HK3PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1su65f-00010h-4t; Fri, 27 Sep 2024 04:12:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSgpx2qczmeKBtUBcFdjR4NSrfPmNq9V8YxVH/BriWVkipePCzS/AMA5FKibgC89f64DRXLc+7RN95H1PhCW3uaG+ypaJqvSAK1mwe7oWdza91XOkKcVUPbXfHD8zW0YQPGl9iui4ZXnsq6knWaNjyTaI+gzaB47yS+1xA/8aeKco6W+MiLJDG4Yl0vPmOUWcnmcEvvwOCx272CvcbMrETkAoAP4ejSnlNR1//zT7HDhxwc6IpvvXxvMCq79rSX07DEtk4VmbQCWe3dzzZJJwztLXIAAsBb/AriJYtriBGek4yszUQh4meV0S4qMlEUpV96vBiQ58+4wjOaio3sT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2K22qyGT3xU/Yr+zML8b/qWGjRNPYWPflxnnWGix9WU=;
 b=gF/WlKxq1YWCb3Dimupm2ifBjKF2o7ViWLbJT+TAwBilPM72KpvP8E6oYLSp1vZg9WYwWXK5DxxSYoAW660Y9YZSuMq23QFsbwHX45rfheQPYBJnyvv34d/pEjUHCeN31GmW25fQ3sKYGbRJ0fHo4uqA4hL+RnojBHXAlQG9zcWMVCs3VxglFqCZEZ30SwhuCmmQUeP4I9EPkC17Eu+iDQatc/PkoB3trKsLgtisMHzYbTaWh0Io6cWg3gwtfYELnOMVq0Ih7eSibPMWJNjXvYT4uKEhN+5NT9XqGgjps7UCR0As27FDQknLGU2LkWPlso9G/h08EnEfysUjMlDKbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2K22qyGT3xU/Yr+zML8b/qWGjRNPYWPflxnnWGix9WU=;
 b=rdDN133te7NEvBtzgPNWII8FpdnSzphKTdNY7isq/XRV7aQ5v90CPFScmNYLKlyGbWNTefjFdufp0lEdTnhQgLVKypgOmIyY4ubchS3OLlz9TX+BxI9H6sb4xd0naqlhR+vogwEfjIAZGkBQ6u63liWQkf3Vn37CRDRVgAgm7feqcBgX9upezxFrFpbfkbq7fumCiVyGylXpgyR89ngF/8xUthxxBtDgBzOhU9GWLL9rby7UploZ3f6NO48/qze5ljquA1o2paMgIFeLPLp88p7Y+V7fCFPrfo/STFtmP/J2F1L7WQKsdHX1IUoi59gAEqVZBdUBpCNK1qt0G2Ufew==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Fri, 27 Sep 2024 08:12:30 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%6]) with mapi id 15.20.8005.017; Fri, 27 Sep 2024
 08:12:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v4 7/7] hw/gpio/aspeed: Add test case for AST2700
Thread-Topic: [PATCH v4 7/7] hw/gpio/aspeed: Add test case for AST2700
Thread-Index: AQHbEK9VteKxfxxBFU2cL/77vJlmzbJrRybg
Date: Fri, 27 Sep 2024 08:12:30 +0000
Message-ID: <SI2PR06MB504163D471738C1A07960F7AFC6B2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240927073144.2303522-1-jamin_lin@aspeedtech.com>
 <20240927073144.2303522-8-jamin_lin@aspeedtech.com>
In-Reply-To: <20240927073144.2303522-8-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|KL1PR06MB6210:EE_
x-ms-office365-filtering-correlation-id: 35626adb-203c-45ec-b46e-08dcdecc21fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?y0mjgnxzMxQcLz1PaRxfa8IcC1pV0U7uS+JoVCUBk+B2d0cM4HapIagHIn?=
 =?iso-8859-1?Q?bnb1ypOGJoafCT15hU3LbWO9eRuU4kl80WBjJck2c3jR+VUlBUe7LsCYHB?=
 =?iso-8859-1?Q?8PX2W0+mDWiirWRp9iQ43d9YbbiSvdGj1Wj6OfaoaFiBuh1C6VWkbXYrk3?=
 =?iso-8859-1?Q?C8KnIb1nsa17nLDV7sVosnt9XSAfAODEB7KtHLUHiO/ym9SeX2NCzltRRf?=
 =?iso-8859-1?Q?A0A7qQYFGbbrYWMEZiowByJpbGM0+L7yQHxEyCU/YjRiWNIAU6UpRNwBG+?=
 =?iso-8859-1?Q?jlISwSk2QPjHop5MLo69uyXZP/XbbFXZwoAoxfyt33tnMOyDVNPCoA7wdO?=
 =?iso-8859-1?Q?YguMOMhek2MlOuzdHZOGOrui2orzR33004HjzBkQEBSJ2QR2dvsNbMfzuY?=
 =?iso-8859-1?Q?URDlCTXobPMJ1MKATjdqwIQX+Xt0aJA8WDRZe/Qc9Ja3EPOIHvGEJDwZ1z?=
 =?iso-8859-1?Q?px66dcnk4BvxpJES2vPea38FNkHkc1nPFEv8N7zvnCg6eB8mh8X1w/kLwF?=
 =?iso-8859-1?Q?+d6fyTvrdunsGLaABu+B+tI54pDjdb/hF583rTltQwWAfbBahSJuwKBSHc?=
 =?iso-8859-1?Q?94TwChKZCEAW7aYHbjYnLW1ZAOXzc159su3qEqed6kFVKnY5Mev9qZeGcl?=
 =?iso-8859-1?Q?/GDFo7mZ9bXhUlzlBOHy5uFDtfoMlcQHcpWGzE+sq4GwAZZxn5RiIBPMiL?=
 =?iso-8859-1?Q?F9sIViAXHB9i9lTv1FAOu+mS+QlFrUqOsjnmcnYI+bZECWw5qYpbFji5FM?=
 =?iso-8859-1?Q?0nyJLRSdLZexCdG6rzcHAIV8yBVB2e5uRjYDCZl62xLqVeEU2j31+fLfhs?=
 =?iso-8859-1?Q?j7p6KZv++/EB3ZygkOEWHpbB7/ZEei+F1kI/PUKmTDHhmrILPdhM6YZwMG?=
 =?iso-8859-1?Q?yLm+pFhQIxBWk8Rcoss+vM3Ccn+19mZjuCQSn0hySF1MSqx3cP31XqPfVY?=
 =?iso-8859-1?Q?vqzA1zFvtfyxWQwYyyx/SBYwWHbo7nYpaZoxjzO82J+CHJqHg3zHY72jXL?=
 =?iso-8859-1?Q?w15JxdD2Rrbh1vkdF5q6l6rYbX57YlfTgVDF8Zo2Nodz8Wh80ytfme/Uep?=
 =?iso-8859-1?Q?KnzACo/at759ZnsRB5IsZI/REZ+zKPH1B7tZsSh3NC+n0hH4NgKXa5oqbt?=
 =?iso-8859-1?Q?6gUZqcKZAtMCfR0K8T9rievbQmcVuD8tOsTxJehD5YOc2lsVEkbj/oqBtb?=
 =?iso-8859-1?Q?mJ7ADjGy5fWurzouK6MSC15ttpbddzEIfdxJKQgEMH5cdd6EjbWmlBCY4z?=
 =?iso-8859-1?Q?8itZ89M+hzxuc0uTmWpUFpTWQMWgvOIZLT9K4MDeBF/7Z2ZztA08SZ3AC1?=
 =?iso-8859-1?Q?GJjckoC5Bs5UrEcRYG7e2muW8pr8Cs3FwiHqWWAqJJjGM5FNHIbSx3cbla?=
 =?iso-8859-1?Q?v8keDMO3vKW8u3pt7iF/It69pzR0/yWhLwGoFDz0qkW6nYCLb0hF0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8OFHVgYIA2F8E/6qDUkIgqtR+XPeBZDxcIY/VLMkpB7Q82YUVpIJ/iPln9?=
 =?iso-8859-1?Q?9/yMyuNtB3y0DalnDU375l5NpqZ/ZAG75loQO1Ory6PEkr5SCObVja1YQr?=
 =?iso-8859-1?Q?Gqs1m6vfsBOs1mlvoZ41kFA8S56QIh/Mlp/yo8SroM8S4O9HpWmfs6PTbc?=
 =?iso-8859-1?Q?OUiyzXMtFCEEbzYLBsFxtMWz3jcK2xj+SBsVnzrKHqsluNbhfWrMPf6ewU?=
 =?iso-8859-1?Q?+ZzNU5nT0FtWuHoKrz/DD75cECGogxdjXKQ8gBUS/loyaOUR+z6pkYYY0S?=
 =?iso-8859-1?Q?K7yBIGUWpeEwoV/PPonnNgaiu3BmnIEv8OSIZCx0/OvZrx+IKSb6fuMR2O?=
 =?iso-8859-1?Q?HjdQ9CTYFnvuFE4s/BbnR5eOIptgEfuGj0aujJSKJjEd7czg62ALbfo4ZW?=
 =?iso-8859-1?Q?DKzM0WuX6M8oeGxKxt+LcdPn9zmR1iKsNBSXS2mg7xDh0RUDuuh4mU6Kx7?=
 =?iso-8859-1?Q?jLlBBugLy0YHVwxnvMvGg2ewTO8d3SBv+8X4ho4HjicAmy/9v68DfOwxBV?=
 =?iso-8859-1?Q?ekQGY/5NdS052Q+I+nzJeGjM3vCGHzRaPIdcnI1WPWf3a7O4zP2qugpl8o?=
 =?iso-8859-1?Q?6KoHfvQmicC9cKJ9BMkAjPXRAQj08v9qcl4olkgXDkvhcZcbkClgnmthe1?=
 =?iso-8859-1?Q?y3cAFpBYkuj5kLYdN82YOhp5q1K23YFCWNB2TOdyjhp8NniVGuYGgiFv2f?=
 =?iso-8859-1?Q?Q4Eu+av/K9Ygg5X0ZK+ZiL3TZYzSCOdqyAv1JXF9Zl/sP0WcHUvE18lFQ4?=
 =?iso-8859-1?Q?CAvESFUGU3sS7fFRY/IolmVIhBeB+I4rpMplpBZZJaP1j+S2kktjkBOx6y?=
 =?iso-8859-1?Q?8h4p9+/3WZReeA5SCwHo429EM+6bGOlZgs631mkZ9HOucyy6z0MoAOe0ep?=
 =?iso-8859-1?Q?phBuuWnCj7oVgLZYNrdfHAtdCvguQXt0JpVNxQ72R/Anju6NjqbQ54aVBi?=
 =?iso-8859-1?Q?L4q1XL9D/DEgjSmLMbAadV7c5GUsRqB2Ot47RRhmVbQwA6WX4McJpFX0Bb?=
 =?iso-8859-1?Q?qHwlh3PS9TowJgcqq/uQUcxEArq5tcvGDiHFg7kt2LGdFMZbCWWvvK2/ch?=
 =?iso-8859-1?Q?JfA+CMNg2nEpItXUdI/FnpyMBo8UsCcU1389piBG07flwTXlqRnlfxwIFN?=
 =?iso-8859-1?Q?aTvIKB6KxupK2vsuL2KhfJ3TRPyVZ6y9Fx/iY7krEL7OeR4H/hz0Mo/hOs?=
 =?iso-8859-1?Q?j5GPhUkODS19Lx5boZ12mht1QG9cqnP/zRYV1JboAjXYp6MKzZRTh1hntx?=
 =?iso-8859-1?Q?qLKNvBHvoVhHZVOjVQ6jEAXjKKrYAcW83bSpE9lBpLQXl+Se7fPIQUhiFG?=
 =?iso-8859-1?Q?hBpo2AbmiKsPqf3ufeNX1tOuOVXn4D1LqiZnHW+R5VDHTqwazVp9VNDWdl?=
 =?iso-8859-1?Q?Dxawdbt9ry+YSP/OMhHa3+GdZlM7kCSG7zfnzXHhRL7irfo+mWlFVYeACT?=
 =?iso-8859-1?Q?5IkStPwftOIHSfrp6RgAJ6oM31j3huxiqb9dePYvUF6WPoZ+o4fTDZbCZH?=
 =?iso-8859-1?Q?ZPqVanIPE/OjJHewz25OhiXnxe3pEjno9M48g1WlESiuNCviO/TgeFoAFY?=
 =?iso-8859-1?Q?+ZAbXixuU1HI36RNaUqrNTWRq76pXSUHdSzUwD7tPVrDlmkrX0WtmrIEUY?=
 =?iso-8859-1?Q?OXvPzYLQ5YSzozX8IRskVWcG6Gpl3qRiiW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35626adb-203c-45ec-b46e-08dcdecc21fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 08:12:30.4477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RUBiRcsgfr4CbnWE91NRMbYjdmD/+eAFD4cpxouzT1RelLkMMGbHI1P5HKgtjImZCC9J0xFHFHhwAHocGii6Xdqg3HDSaLsdaMDaSUKSmBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
Received-SPF: pass client-ip=2a01:111:f403:c400::2;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK3PR03CU002.outbound.protection.outlook.com
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

Hi Cedric,

> Subject: [PATCH v4 7/7] hw/gpio/aspeed: Add test case for AST2700
>=20
> Add test case to test GPIO output and input pins from A0 to D7 for AST270=
0.
>=20
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  tests/qtest/aspeed_gpio-test.c | 64 ++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/tests/qtest/aspeed_gpio-test.c b/tests/qtest/aspeed_gpio-tes=
t.c
> index d38f51d719..8ae42a8da5 100644
> --- a/tests/qtest/aspeed_gpio-test.c
> +++ b/tests/qtest/aspeed_gpio-test.c
> @@ -33,6 +33,10 @@
>  #define GPIO_ABCD_DATA_VALUE 0x000
>  #define GPIO_ABCD_DIRECTION  0x004
>=20
> +/* AST2700 */
> +#define AST2700_GPIO_BASE 0x14C0B000
> +#define GPIOA0_CONTROL 0x180
> +
>  static void test_set_colocated_pins(const void *data)  {
>      QTestState *s =3D (QTestState *)data; @@ -72,6 +76,61 @@ static void
> test_set_input_pins(const void *data)
>      g_assert_cmphex(value, =3D=3D, 0xffffffff);  }
>=20
> +static void test_2700_output_pins(const void *data) {
> +    QTestState *s =3D (QTestState *)data;
> +    uint32_t offset =3D 0;
> +    uint32_t value =3D 0;
> +    uint32_t pin =3D 0;
> +
> +    for (char c =3D 'A'; c <=3D 'D'; c++) {
> +        for (int i =3D 0; i < 8; i++) {
> +            offset =3D AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
> +
> +            /* output direction and output hi */
> +            qtest_writel(s, offset, 0x00000003);
> +            value =3D qtest_readl(s, offset);
> +            g_assert_cmphex(value, =3D=3D, 0x00000003);
> +
> +            /* output direction and output low */
> +            qtest_writel(s, offset, 0x00000002);
> +            value =3D qtest_readl(s, offset);
> +            g_assert_cmphex(value, =3D=3D, 0x00000002);
> +            pin++;
> +        }
> +    }
> +}
> +
> +static void test_2700_input_pins(const void *data) {
> +    QTestState *s =3D (QTestState *)data;
> +    char name[16];
> +    uint32_t offset =3D 0;
> +    uint32_t value =3D 0;
> +    uint32_t pin =3D 0;
> +
> +    for (char c =3D 'A'; c <=3D 'D'; c++) {
> +        for (int i =3D 0; i < 8; i++) {
> +            sprintf(name, "gpio%c%d", c, i);
> +            offset =3D AST2700_GPIO_BASE + GPIOA0_CONTROL + (pin * 4);
> +            /* input direction */
> +            qtest_writel(s, offset, 0);
> +
> +            /* set input */
> +            qtest_qom_set_bool(s, "/machine/soc/gpio", name, true);
> +            value =3D qtest_readl(s, offset);
> +            g_assert_cmphex(value, =3D=3D, 0x00002000);
> +
> +            /* clear input */
> +            qtest_qom_set_bool(s, "/machine/soc/gpio", name, false);
> +            value =3D qtest_readl(s, offset);
> +            g_assert_cmphex(value, =3D=3D, 0);
> +            pin++;
> +        }
> +    }
> +}
> +
> +
>  int main(int argc, char **argv)
>  {
>      QTestState *s;
> @@ -83,6 +142,11 @@ int main(int argc, char **argv)
>      qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
>                          test_set_colocated_pins);
>      qtest_add_data_func("/ast2600/gpio/set_input_pins", s,
> test_set_input_pins);
> +
> +    s =3D qtest_init("-machine ast2700-evb");
> +    qtest_add_data_func("/ast2700/gpio/input_pins", s,
> test_2700_input_pins);
> +    qtest_add_data_func("/ast2700/gpio/out_pins", s,
> + test_2700_output_pins);
> +
>      r =3D g_test_run();
>      qtest_quit(s);
>=20
It seems I need to check arch for AST2700 to fix the following errors.

int main(int argc, char **argv)
{
    const char *arch =3D qtest_get_arch();
    QTestState *s;
    int r;

    g_test_init(&argc, &argv, NULL);

    s =3D qtest_init("-machine ast2600-evb");
    qtest_add_data_func("/ast2600/gpio/set_colocated_pins", s,
                        test_set_colocated_pins);
    qtest_add_data_func("/ast2600/gpio/set_input_pins", s, test_set_input_p=
ins);

    if (strcmp(arch, "aarch64") =3D=3D 0) {
        s =3D qtest_init("-machine ast2700-evb");
        qtest_add_data_func("/ast2700/gpio/input_pins",
                            s, test_2700_input_pins);
        qtest_add_data_func("/ast2700/gpio/out_pins", s, test_2700_output_p=
ins);
    }

    r =3D g_test_run();
    qtest_quit(s);

    return r;
}

qemu-system-arm: unsupported machine type: "ast2700-evb"
Use -machine help to list supported machines

> --
> 2.34.1


