Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50902CCD193
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 15:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA97x-0005Cb-W5; Sat, 18 Oct 2025 11:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97v-0005Ac-NW; Sat, 18 Oct 2025 11:45:51 -0400
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vA97t-0001QR-DO; Sat, 18 Oct 2025 11:45:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXuNADaGg+WwVY4RaOZki0YOPU4e9FGkGPDODhMtUMbGy67lJGpsOfgVFb9xNQ2aIdcO3yZOGEPwEESjJArKDWe+F+dI3wlOQYBxNi5q2XgMKf5QWM25iXQ2HicP989Y47b8qDliv43mjTVLULxmZhBHzxwruOUFQc5m+g78sjqnxByDh/jtXQnUsq7JuUTaULUmqTjVtvOg+z3eCEb8z/TM/phI6Yi/dT1DOIEqa3x8RG4yvZxMPJO4fkagkZjtgyDMCgt5bisXv8bMfKpVbd1Dxb7uX3DeLIjAS4vG6Tfd+XTL1EvN2qXkBxQjkiHa7vMZAMpwEAShwKlYF11Zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEibdGsjLGzjckGQcbWj3Q2Gu8N2//vLQZm8zCnKkJs=;
 b=ZrqS7jiLnKGcmmUjNQbqGYrFwmXux5M5TouSjF3Je3h5XEhU/sIh0kSxjDUQxvj9YJk3Rm4ZeudIIAZy8HcBNWFH9OjeLawBf4YFCZ8+pGra+qyI/Hu8af3mAs7BKid15kgjkdxTV3rvbzqBymVkYgYYDTGBIHwHp38FkoQw7r5dykC0qcta9bezLAdpgjoz4s3ss/XQe1FbE0VX5V9+mO3vX5D6UaKEyKq31Oq8lVUWfGIVgK8Ybg3GEl8w5ZWVDnXJ4x+u4/9qwm4wJSnmEZitdGJGY/LKl3NWjAvz8lfbyNuNf1pVxKBZLK5p9Av1TEZUVPkh2dphw20PAos0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEibdGsjLGzjckGQcbWj3Q2Gu8N2//vLQZm8zCnKkJs=;
 b=rijShlBk+8Vxq4mPjHvFpKWwhtUogZaxJ1vgOQu5dEmrfvUNNaenQqdHMvZ6LPlIBlXpbd0O2LfPuP6d53MlzedVUIfPossStj8chtaTHzyUBnMJyWMPl1o/ZMAMDcPrEUdOXqTjEnK7mJvyDv8rXMxkVvLYB/ESoeORVNtDCJwOxgHPBAGT6J/Ag1zZ8YujVLpOBVejXLWAo/Wr3cfIUjbARX2QXtYoKrtJngSJDHAbQT/Uo5BFGjsssoe8Jp75Velp7d076umPEYZg1ODPy4/GkvZYobPts7gQJVcdkQ6+BU44XahJoFz/3vc2sbFdtnxfbDe2Len6IdCErzu7DQ==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4360.eurprd09.prod.outlook.com (2603:10a6:10:154::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Sat, 18 Oct
 2025 15:45:32 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 15:45:32 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: [PATCH v13 13/13] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v13 13/13] test/functional: Add test for boston-aia board
Thread-Index: AQHcQEY8nZPutW0+AEqbhXCTtCkpsA==
Date: Sat, 18 Oct 2025 15:45:32 +0000
Message-ID: <20251018154522.745788-14-djordje.todorovic@htecgroup.com>
References: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251018154522.745788-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4360:EE_
x-ms-office365-filtering-correlation-id: 3248dd7a-a54d-4bae-e04e-08de0e5d5f34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7esd3UxYvgzBnU84OvzT1kX3S+3PYtMbMzGsuXAIuxe40/SPkDHI/b7Ipy?=
 =?iso-8859-1?Q?Cb9UBbVmHLd41iaYF+BVdQzZlgH1I/kJLd6xb+cT8pVo/hHUh6fMZHLGHW?=
 =?iso-8859-1?Q?SHD18Kob3xOqTVpxyuOey3tCAr2vnrURf5xBFTi68eOsnwCJ6PI8Hba8cW?=
 =?iso-8859-1?Q?w1xrNxfUNCfhbX/g9JJZ5bHY7dRbXTVJEOqqZxG1oI8j6LjbyjAiTWc23k?=
 =?iso-8859-1?Q?m/GcYe5M1s82EN0UbKfpr6QRJNql17W0y9LMw49xJWlL55WavfZ2j/Fe1S?=
 =?iso-8859-1?Q?kaQ+ejwh7ZMWfF+LRETiCuyS/wlZAAyHzdFHi9dW7wxPdxsX4RM41PvPx/?=
 =?iso-8859-1?Q?YJX812DF6ZBzKvM7alxoFLUb0WxbMJ4xwG25G0ya5fplvZwHJ30nerGEE1?=
 =?iso-8859-1?Q?eP8MsHMn/XbeByrgrtdNOiIkBvOKuKBDW8ijk0/eG6jWwW1Y6sxsbjZXxs?=
 =?iso-8859-1?Q?20StcVD1Yxz2rqtAetPDvG14Ie+213WPlRCYguRzwdBj8kATJ5o+UNNyDr?=
 =?iso-8859-1?Q?2xo+Uy14fEftYTTtX02VCjrQWTVfPztSHLWOMbrxQf62T8/89cPrfNYgAP?=
 =?iso-8859-1?Q?REZi7RFM8jnKLzpM5E1rhJKJJ3KDTJp8F0ahfhVn9C9F7/7tgDOGSTQvnx?=
 =?iso-8859-1?Q?Yq7Ll+TDEWUN6KfTPCdCQSG6h+NiQOokBXx3LRZ4tAfeT0e0LRCQmWv8uU?=
 =?iso-8859-1?Q?NaWfFRKTWoLOIMKXRzxGykE/R4y4PUz6PpDNhbXZPL4wI9HIWatUXfijyq?=
 =?iso-8859-1?Q?u8boQonTBbxvaBab+aaQkz97ykx/e18vjPiKJUPp8/UFaORzTIBVE87bQY?=
 =?iso-8859-1?Q?osbUS2dsv7yx290B/uGG9uSQ23lnKoJmUSfk0uw0AMN8cg6V6SxHPUiqv6?=
 =?iso-8859-1?Q?cuks0j79AzkXvmesXdxyFnbsk4aL30KTCe/gwOyjDaZTjbUAquPPUhScm4?=
 =?iso-8859-1?Q?MTW56vk+dS7aUqffA9mHVnne+KJdmyICmy232ub9mdhwDJAz0Vj1dShtJX?=
 =?iso-8859-1?Q?lDIDDvriLVJ0cUToGYXqK+xHUApgiFpyJbBHR3VGTKmyo7W1NMe5GZNPa6?=
 =?iso-8859-1?Q?d5cHGNIsRSf2glEYGRQjL7J+Jm/Wco5dPqd9Oo9NhaFxv2agGVTPf1M4qA?=
 =?iso-8859-1?Q?71G6nXroToY9Y9qh8MHl29R2xpT0+WrxNCq2aD7MEKSOsnmaVq5Qvt7T2W?=
 =?iso-8859-1?Q?+9rsBje6kw3olP9o/LAoCmITOMqmNlRsOwUUENfTsa6Ytq01tbhzTFyt58?=
 =?iso-8859-1?Q?YPo3oP/9a8xVNJ33m/SEkh/v97D7PnNmyznLbls2j32Ni0JJLCPWsfCFO2?=
 =?iso-8859-1?Q?NlYTdMtfhjsCrF9ey3Hsm4x1PkNMiGISfzcGx1xlxofCEcD0k8l3MHyxIH?=
 =?iso-8859-1?Q?JCDKN2nT5QwbIbFY6aKykvUm8Iw6dQccC6isU4aXWHGccP5lxvEKTv2usx?=
 =?iso-8859-1?Q?/HXvDpFFV9t3E5yinEhowftlUsNnNmo+vA7Ow+UkR5BxorlXb8OhhSmmjd?=
 =?iso-8859-1?Q?AdTaRYnanKE7roce18StmNOrimW2PxxhiSOLgzJwmu4XFZEmw5ZdwXypbg?=
 =?iso-8859-1?Q?aW7+f3EULidakzpD3wZzx/uyEQLB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g0jx/F4DoS50Vf+PGDmTiuFMHvXNoWdtGflwkmXlZk9Swj5dNq4w/h+Ajq?=
 =?iso-8859-1?Q?JZHlfI40rq/KnTbwddfhkQursG+CC7Q/GB3Ne781z0XvuruU2GvSjExOID?=
 =?iso-8859-1?Q?4spKZ3e/9U4QDiPxi2DHqhDHe2VmkVfCinbB+GJrJh0buN9vbHoZsD8taz?=
 =?iso-8859-1?Q?++Yu0JbH32/jLfBEsTlD5lNLlyGE7NxmRYs71IICvxke8b2zpJct/2YVgV?=
 =?iso-8859-1?Q?97yLMKFqg2/uWLA5REWs8IgTLnGUT95Mspu8EvgleL+JtDFpl7SiX7yoLf?=
 =?iso-8859-1?Q?azj4+rjQfA3PgPIi5lTUOIosl/paclGfkgkae0y2hwHmNWLBf+9q5nIj/w?=
 =?iso-8859-1?Q?tpLt2HS+SeljXwO9uAK2FNA68f0X4lxznOQN0ycKFgqjHTnG4gxWLJdvNw?=
 =?iso-8859-1?Q?tEcnf2u9PfYa6Jwe6paqb9UKD6/cRtlsW55LeC9yhlrqyfDrqfyFW9oPgX?=
 =?iso-8859-1?Q?vPzQN/Fh7yvplIW00p1BsZgFREhO2eXRMfW9AaLUwhdxPLGqN1kv13eQLw?=
 =?iso-8859-1?Q?AAKyEJZYkVDzJ7LoYyt9ca1WTzd8c5s2ImiGxcM60sqqy7Ditf7RaOxdvU?=
 =?iso-8859-1?Q?5yzj7dhFRE71C02QETc7bVc0BBojuvw+5SvsiqQhmNsYzfhW5G0hg/ey68?=
 =?iso-8859-1?Q?kz0lm+8KzhG1S/LCOA6EIdltUJy8HSUXh6za7SL70X/FAalUNm/R0zAOQW?=
 =?iso-8859-1?Q?29YEk5kFqRHJQlSvhwflC7S2JBH4ayDxxZNMNmZZyehyAxaCNLSrGlrq7Q?=
 =?iso-8859-1?Q?caQ/lrT/8xZf29evlvqMV2gUHheFMEzSvsitb1Z9+ydMThPdpVXxSovZ2u?=
 =?iso-8859-1?Q?ROIWgd+suOFTE8s6vMipUY9aPnUGxHu5aO6oM7jyBNh1lBprqFwEHeRpFc?=
 =?iso-8859-1?Q?1aQdJkhtZpX8j1rs1lovdzeRmw9RKR1TNfQmKK4GSXNc/bT0l3f5LVkVXw?=
 =?iso-8859-1?Q?IJFpwGEr9JxssmaRowvZ042RPhQflv95gEY4x/SY8tTcm/uaKVdAknwEZk?=
 =?iso-8859-1?Q?1AjDBzXE0kPEZVWPlnO0pdlFRABXAB6kmr0P22KZijpQ3TuPCjvPZ9EF8I?=
 =?iso-8859-1?Q?mGttUtQkovvocBF3v6q5eyuS6FTR6WR8nmEP45yyYUzGRBhlXR794s7yKk?=
 =?iso-8859-1?Q?s9dI1TDLt/OICbHOz9Maqye1ClC1ULMS91yyxiAzXsq20AjYvCsudYDSKY?=
 =?iso-8859-1?Q?JLMH0oWTzgHPI7CT2gtQ2E6FCKL9x13nwfbrqOUlG2wgqvLiW4u00Jud/U?=
 =?iso-8859-1?Q?ucT9R+jutaPCtJijC3wf1IgKyYOFHSobIWp9WgaESYjZGHUoG9eJoUQ61W?=
 =?iso-8859-1?Q?BZxl528g9fkrKUjxJ/3tMRT5GSlJ4cIL/fmTNJ0/ko6wBSbUN9IdGmuJJc?=
 =?iso-8859-1?Q?jVYgR59ZxOBrh8r7BQ5xkeaZ2yrGhniA8UbRoWkagbkSQXzrU69Yz5npKn?=
 =?iso-8859-1?Q?4/hvqiXEu4Sz9f1OdCxmr/XyM75Hl5ZBhl674Hz1HWwqb3SmG5foR1llVa?=
 =?iso-8859-1?Q?Zmw8PYyoWi1+cHmei+gRDLvU8kd43jJTzKCxuXqCBKNkKhoVU5eTrJRfyZ?=
 =?iso-8859-1?Q?4+2qa42P43lTu9EhUxCkJ6XlKAQ8ZptuDjxGl49iZp4sPYXqeB44nVrxzj?=
 =?iso-8859-1?Q?8ybhvYEwfKSguQD7XKFxln6ggGApmxh/QvXBGPwZF2T3eFtpjIFE17DO0h?=
 =?iso-8859-1?Q?9OQlTfzMIZjpn8WfMP4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3248dd7a-a54d-4bae-e04e-08de0e5d5f34
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 15:45:32.5006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+53NBZuhrk/KVFWUk3+X3jpIZanI5yhpudBJkHTW2OcRFBoztiBf7LWI1IsPPhGTkbkyJtN9aUsk+5fkIdp+16OWFvG66xh5+AQyTcTduE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4360
Received-SPF: pass client-ip=2a01:111:f403:c200::5;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
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

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/riscv64/meson.build    |   2 +
 tests/functional/riscv64/test_boston.py | 123 ++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100755 tests/functional/riscv64/test_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv6=
4/meson.build
index c1704d9275..f30d583a29 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,12 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
 test_riscv64_timeouts =3D {
+  'boston' : 120,
   'tuxrun' : 120,
 }
=20
 tests_riscv64_system_quick =3D [
   'migration',
   'opensbi',
+  'boston',
 ]
=20
 tests_riscv64_system_thorough =3D [
diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/ris=
cv64/test_boston.py
new file mode 100755
index 0000000000..385de6a61d
--- /dev/null
+++ b/tests/functional/riscv64/test_boston.py
@@ -0,0 +1,123 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    ASSET_FW_PAYLOAD =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_pa=
yload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa'=
)
+
+    ASSET_ROOTFS =3D Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootf=
s.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565'=
)
+
+    def _boot_linux_test(self, smp_count):
+        """Common setup and boot test for Linux on Boston board
+
+        Args:
+            smp_count: Number of CPUs to use for SMP
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', str(smp_count))
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file=3D{rootfs_path},format=3Draw,sna=
pshot=3Don')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_boot_linux_min_cpus(self):
+        """
+        Test Linux kernel boot with minimum CPU count (2)
+        """
+        self._boot_linux_test(smp_count=3D2)
+
+    def test_boston_boot_linux_7_cpus(self):
+        """
+        Test Linux kernel boot with 7 CPUs
+
+        7 CPUs is a special configuration that tests odd CPU count
+        handling and ensures proper core distribution across clusters.
+        """
+        self._boot_linux_test(smp_count=3D7)
+
+    def test_boston_boot_linux_35_cpus(self):
+        """
+        Test Linux kernel boot with 35 CPUs
+
+        35 CPUs is a special configuration that tests a non-power-of-2
+        CPU count above 32, validating proper handling of larger
+        asymmetric SMP configurations.
+        """
+        self._boot_linux_test(smp_count=3D35)
+
+    def test_boston_boot_linux_max_cpus(self):
+        """
+        Test Linux kernel boot with maximum supported CPU count (64)
+        """
+        self._boot_linux_test(smp_count=3D64)
+
+    def test_boston_invalid_cpu_count(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path =3D self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path =3D self.ASSET_ROOTFS.fetch()
+
+        cmd =3D [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file=3D{rootfs_path},format=3Draw,snapshot=3Don',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result =3D run(cmd, capture_output=3DTrue, text=3DTrue, timeout=3D=
5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP cou=
nt")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count=
")
+
+if __name__ =3D=3D '__main__':
+    QemuSystemTest.main()
--=20
2.34.1

