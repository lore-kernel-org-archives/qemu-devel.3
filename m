Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA175E78D70
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 09:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpNOL-0004pl-AJ; Mon, 09 Feb 2026 04:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOJ-0004nh-SJ; Mon, 09 Feb 2026 04:17:11 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpNOI-0007Kt-G7; Mon, 09 Feb 2026 04:17:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxMR791TPfZRMKnZrEz9Tf/P8kFnmaSqxFVM+13uzwbGwVYqIsQA0E/hUomqm+9A7tDgxRNxSzDM/qyDvK4r5/rDuXS6QEXrRLJXrSyxJSJMywyy6S06lLYjriNdH5E5Mb+T3XkW4NMqYrzyif1J4dhQnH3ScnMARBMBRnOSPKCTr1bu1QihEYXGCNikICZeb3jFuAN+7PWrCBCtosRkjmfLbhjHZrVzUtGAamOiOOxGh8BSvGqMKxCP4lhlP2a+ME0W5VZ3ncuqKoS7RTKPqLIUE84nMbzOHv7talky9yFNRjv5ENykJtwaCYatzusXOyI3x2yH+K8lncTpBgljhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giqncwyyzLfgkDjayct8Asn9gAj7iisRiJw3QrkHdvo=;
 b=WD2VOHz2jJHJiljL2qyfFSUajyb1QlO+goNMvaZb39iNwcscinFkrLWI9YY0kc2s9Ta1YFf1dxTJAtsAyKWGJiDNtV3e7CRaSx1K7jSmcUd55AxzEEwaWn98l0nm10+VNYpt12st5q5t1gau3uEYUmUJAFDEjbUr7gNgZ4P579/cc8eVzho2y/oNjxcLXDedYDYOrm9gvx++omMyUGsA9AFGXof3PxsZiDMNWDt7pV+ylHZnS71VJxEFSTw6liayNCsQTwoPsYeASqVYLRCizmAV6w+ZeVWck5fp9EjEVfygEAb33rI3vGMy7PgEB1ufM8ngsAaoF3gu6QlIuqK5xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giqncwyyzLfgkDjayct8Asn9gAj7iisRiJw3QrkHdvo=;
 b=UmZnw+SppQWZhTykYbDx0AGfn2itLB52itpU0KBkcazX571U0A2vMts67vDd5QoidDFQkoLF0ae6Ymsgzd+PKDMV/Ec82XIuVbwkgZGGbQs3XC6c8vBR44pWs8GmkNz4NEYQss4A+bR17riWK+TYY3buvMh7pA0QtZFWKc8P1aoMwEeo8eLCCQZ8BfeMA2DuxovNvtiepR1ZUAYnYvd90SPTQwuKocz7MBk6DO8Mfbh57Vvfcs4wnEwtTpryc7e/QmlLN37liOIN0lGsAFn738rhvx7ACeMfJpsS4Wd3KaIWq9Pjfx+jloQx/TVkyUbG27R61N0Pg0dlzeZA6QHzNA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by JH0PR06MB7031.apcprd06.prod.outlook.com (2603:1096:990:6f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 09:16:58 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 09:16:58 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v4 19/20] hw/i3c: Add hotplug support
Thread-Topic: [PATCH v4 19/20] hw/i3c: Add hotplug support
Thread-Index: AQHcmaTX5FYEDR59VU+s7WZ9z4odYg==
Date: Mon, 9 Feb 2026 09:16:58 +0000
Message-ID: <20260209091629.823457-20-jamin_lin@aspeedtech.com>
References: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260209091629.823457-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|JH0PR06MB7031:EE_
x-ms-office365-filtering-correlation-id: fe0d336a-3ab7-468c-88a7-08de67bbfa1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/sPgJIRitWgos/Z+1LonQn5x3Gj4uq9ldHLCWhTJwKq4504CGUJKblhlpU?=
 =?iso-8859-1?Q?FmlZOqXMdsTzXvbVmn5TRDuR3XhDDIxke+1RG680SUVAebNmVClVMIkUN9?=
 =?iso-8859-1?Q?FGU4dJIXg2D/b/uP9zsbcgAtswxsOJbMiPSerPMkovAXGP6CtjibyxO05F?=
 =?iso-8859-1?Q?iL/yUMCKCdbXr5nLOKE9puzD/DX3WQ4kys43iCiXXKB8Mv2uOBOkLGg3DL?=
 =?iso-8859-1?Q?sp+h1Gmi3LGVWwbLzPpTa7XWjoHYFmV4Z793aYHwZot2LpIi2PS0WgWAJJ?=
 =?iso-8859-1?Q?rCFaspRrHDEXHxW1zJPt/AW9lZCe6GbOprgMRMdicRsNYhoyovaETem48x?=
 =?iso-8859-1?Q?7pzrZ8UYnHUvuVvTHWmxcSi1m/5IcjdaPgoIqXtHzTT/nqjX5I/70llnSb?=
 =?iso-8859-1?Q?Y6wSNPwsUAK6fUIeDHqcGUg+EsRDSvuPturxIwK9Sg1F2jJp7jL5EAVUJV?=
 =?iso-8859-1?Q?Zl3LRf0xuilzIDdtvLpMolHJiLD3OLaedBdISwvkR07O+1WxeF5CNuotrr?=
 =?iso-8859-1?Q?ctFrEAvIfpMj4zCbm1hsMqbj2trhGV4nAXEEdh6pOTnvlYQ5VuqwHkGan+?=
 =?iso-8859-1?Q?PpTWll++hHWybb4kZ3u+2uknTFZfOL/S6PatzNZDbRwfwYLeagSfrzINnO?=
 =?iso-8859-1?Q?+pXFl7Zu7X4c67Pj8kYYXs/rnIu4n35OawlHyATdSDXA7Vxc0z8BLNjvGs?=
 =?iso-8859-1?Q?4qzUXZusl/1TLyKP2CJN1uqsyyBo89rYbLbmY02SGdnySBbpoWxtr3ynvV?=
 =?iso-8859-1?Q?+5ve385PetIyeq2OxDw+C3wmxZJ77yav3MTMx4vJDW5n0k7x5PLndHHQv0?=
 =?iso-8859-1?Q?Xmy3YvHEf7FuE63JI4CIEUh+QvLatpOrSI7QSjIBzzP3JPfrdZfgIWEZtu?=
 =?iso-8859-1?Q?QW7hEAW9f5nO5Un3HWsUDDqeTCBNUw9ceOnjG3kg1n6wu15qrNVyU6WJEv?=
 =?iso-8859-1?Q?CJLfE0nGsEckWk5LSDeJvHrrIceLR46pBaKNwC6uwoln7s2hz3KbGYlKqd?=
 =?iso-8859-1?Q?AptY1O7Za4ifwAPC4/ERzaMoUCeFQ1UbjlU0rAfvDuC7wPCKmjNi88yrOH?=
 =?iso-8859-1?Q?TX9tGJi4caittlxXsBxCOrejQHm62Wq9ilUmyZxOIZsD/JW5oNNPzg7MWX?=
 =?iso-8859-1?Q?igGJxXNMJMBL/Ry6b83xP7B0uB6oxAYiUS8FtJ2DwI796EIc/XZcr5Mf2O?=
 =?iso-8859-1?Q?gAY7+0PAxYYB8V7LkwfO4X88b4iOVwP7bBqyTBTu1H1e+HN2JJ6i8FdkEv?=
 =?iso-8859-1?Q?1ftzG866Um2bkcMK3fFfLhG2R2AmSPZMKp0KL18EZ2TdfRdNsmZ+jk7PTV?=
 =?iso-8859-1?Q?mrkgPSVkraaCnaD0yXu4KeuD4TWIDmuufDCo++iwq9LqppOkqFFExmJgF/?=
 =?iso-8859-1?Q?DG895tzrGcElkKTAEZSsmgUWYJlBURYywtSVqpQjVuDNaGCeWV7uT29iUa?=
 =?iso-8859-1?Q?k+nQ13yJjO91M+mwM8JAeGOcl5c2X8G7r/NEdfKdgkjW2JbARuGryzbAJ1?=
 =?iso-8859-1?Q?/fKNazLCY+vp0rKPoipQiGAun9bX5X8GVWCuvFkR9BCeyZcxz3mrk4YqhA?=
 =?iso-8859-1?Q?x6Taiwsdd+ClXd7ACzIOV7Aqr1c+WoAKg46U7A9rF6Vn0d5fYjR7aq/OKW?=
 =?iso-8859-1?Q?vZjc/+SJeZYepqc22fvEM5YtZCSwGDL9bx/U9CyWIdcHF0RdBHf4KlvBcS?=
 =?iso-8859-1?Q?rOQ2LX7gEAfxemmppz5jg0Eal20IIxtM+SBFIuVG?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YVXn1d8mbe0GJdORVHSP6soQtS3FBpTp8BFGX446DpC8jN0S64bWfzWNqe?=
 =?iso-8859-1?Q?8plr+VPjnhQ8Wd1p3bjTzk+NBMI0PXcX5n7s6HCBLT5p9sU9+oTwI2y+Uh?=
 =?iso-8859-1?Q?cLLupe/5WCOYSnegYDhyIc5hMqbFK15VbbZrH7IiUkOhdhRH0+yWk3sk/D?=
 =?iso-8859-1?Q?QyVqhS0qeqUPZ09syBdRQG++gIQYAG+gusCZLXhAmJTujPAJ4fog3gJpPZ?=
 =?iso-8859-1?Q?9lzZ1/ou+rHTW88wIFYxqOszUyZqRXiTIVIHpPIlMtYFvTywusPZ2/0p/6?=
 =?iso-8859-1?Q?eQdrrGMZ/Iyppcel7Ji1gDbI+noDSq/rNbS7ANMhoZNjbiokPGNX1Byjwb?=
 =?iso-8859-1?Q?q9AnjL0lSc0qMv9Gg+V6Kza0gYoQOFLw1XcmcSAdBtlJFyZQRoM6Rv9OI3?=
 =?iso-8859-1?Q?O6nz8D6gXPOcXOcY8C6HZZwK1J/iSbgA/44no9CHbKiBATYbwHxdSp04DD?=
 =?iso-8859-1?Q?rTLv2ub2LZyYi459Lg6h8kbMHnGiChRh7RggocnCtKjUJKA3fEBc4Nqjgb?=
 =?iso-8859-1?Q?SFRhYqXmqgr5BWejDhARpam3wAN5aLwWBxjel6P/NclGampCQb8nRyBqr3?=
 =?iso-8859-1?Q?Hrt+UZNQmJon0V6UvbFuKYLODWQc/FuBhXi6s259Jxw5KMCQhiFmF0eWik?=
 =?iso-8859-1?Q?0DeQd/lnw483xcLXzh+auaPB8Ft2zTv38cF/9aqedAlmRDLjlUv4BNQUS5?=
 =?iso-8859-1?Q?BvGsuDTiv0xQ+i8P0xAJ+ZP59I+mGvs1MhXkCO2OGaAVpZYQajrji9S/pe?=
 =?iso-8859-1?Q?Xp80zhHWsms6yhmrd6CGrDWEAToNMKkPig1OCuWYp3X3eM96rgLBIUioEa?=
 =?iso-8859-1?Q?ReRASfSDZCsz16uOXdkM28oTG7n3hoy5NlubvvGbosWhtUWqW3wtiqEQ0W?=
 =?iso-8859-1?Q?1p9b8CbjHuHIEgQKbmGJ5dA2PQtRQCM9Ajjr7MoFFxZCNXM40/XqzuSd+q?=
 =?iso-8859-1?Q?XiDEATvARDU0QK4sjzKdx+uwgMGk3wspz+i7yVYK9OQQluUjSznnpkq6em?=
 =?iso-8859-1?Q?ayMIq1kWr4QdPSSqcnN7jYOoLheTrKZanhyXL4uOmIv6RfhTqhZUbKt8XI?=
 =?iso-8859-1?Q?AXUK+EAMSdtWyCx+Cl4Bth1nxXc3lDSUNm5990qSAwaukv8IQ0+wJSo2Ei?=
 =?iso-8859-1?Q?L8gUIavk0IafFJhSnw8ba3Sngsg3J1gcRaIq32uGIYUFTHA3Zjp6xWOCWJ?=
 =?iso-8859-1?Q?DAefM2SB9kuL9Cleog4OE81sHLerIO0O/vQplyZtPvtMjzjYpG/9YFNS/Y?=
 =?iso-8859-1?Q?X8LQbVP4qJbPoDLsSEkxAY9bfxYPCdXf/ULyXEvFoThZMBa7XNvNXpngdq?=
 =?iso-8859-1?Q?3JyWMU3Pq0yiinMBjiASNam5zKQFSMxKljCwhBvMkTW76fYHxpO4D+2GZI?=
 =?iso-8859-1?Q?uWrNFKeH6WocWqAMkD+wxq3eEYGhGSBPW03AMTuHKH8BrdGMKMOyEWOBS0?=
 =?iso-8859-1?Q?SwCyDjxXIOxo0q9TXn/PW6IwrKvnNUHfan1HWLk0aoZwq/UjXb/6Gtjuze?=
 =?iso-8859-1?Q?Q1T/fVI2uH+KqgI8VglKYmdcgKIF2VtFQ0QFusVTQf5gojX+3TTPfjE+tW?=
 =?iso-8859-1?Q?rn4vcMSsJlBg5qc0EXGdgzCDsOCig3lnlgKeEva+BrxnmUmg8VVFVQZqef?=
 =?iso-8859-1?Q?C1Sg/i1xcyq8Fy8CfC9Z1T+w3BRx7MLJyA6gsMieuzGa4Co4FDOzimRLbZ?=
 =?iso-8859-1?Q?HA7pn3i9qXqWxJTZ8at7rub9wZi2ctP6mw18A51O0KTX11h8ZGNZTSHfuT?=
 =?iso-8859-1?Q?cX9TTi7xSa9DcSs4wcZUTGfuLk+AufSWaFxmDzSFRoK6VHwsXmOj8DkVje?=
 =?iso-8859-1?Q?wv+J5np32A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0d336a-3ab7-468c-88a7-08de67bbfa1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 09:16:58.5704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFP+RkuRd2XvZWqEGgJVz2sudPegaDE3P3esn7MY5g3NNCrLYxU/pk/jnyAVkj6ZtZr7ZHYiMPwlGLalEIcfdgj4xniwaMejykxA0QTZKBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7031
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

This adds support for hotplugging in I3C.=0A=
Conceptually this can be thought of as an I3C target being physically=0A=
socketed onto a board.=0A=
It is then the target's responsibility to go through the hot-join and=0A=
DAA process so it can participate on the bus.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/core.c | 17 +++++++++++++++++=0A=
 1 file changed, 17 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/core.c b/hw/i3c/core.c=0A=
index fb4bfe5aec..1ab95c4866 100644=0A=
--- a/hw/i3c/core.c=0A=
+++ b/hw/i3c/core.c=0A=
@@ -11,6 +11,7 @@=0A=
 #include "qapi/error.h"=0A=
 #include "trace.h"=0A=
 #include "hw/i3c/i3c.h"=0A=
+#include "hw/core/hotplug.h"=0A=
 #include "hw/core/qdev-properties.h"=0A=
 =0A=
 /*=0A=
@@ -26,11 +27,27 @@ static const Property i3c_props[] =3D {=0A=
     DEFINE_PROP_UINT64("pid", struct I3CTarget, pid, 0),=0A=
 };=0A=
 =0A=
+static void i3c_realize(BusState *bus, Error **errp)=0A=
+{=0A=
+    qbus_set_bus_hotplug_handler(bus);=0A=
+}=0A=
+=0A=
+static void i3c_class_init(ObjectClass *klass, const void *data)=0A=
+{=0A=
+    BusClass *k =3D BUS_CLASS(klass);=0A=
+    k->realize =3D i3c_realize;=0A=
+}=0A=
+=0A=
 static const TypeInfo i3c_bus_info =3D {=0A=
     .name =3D TYPE_I3C_BUS,=0A=
     .parent =3D TYPE_BUS,=0A=
     .instance_size =3D sizeof(I3CBus),=0A=
     .class_size =3D sizeof(I3CBusClass),=0A=
+    .class_init =3D i3c_class_init,=0A=
+    .interfaces =3D (InterfaceInfo[]) {=0A=
+        { TYPE_HOTPLUG_HANDLER },=0A=
+        { }=0A=
+    }=0A=
 };=0A=
 =0A=
 I3CBus *i3c_init_bus(DeviceState *parent, const char *name)=0A=
-- =0A=
2.43.0=0A=

