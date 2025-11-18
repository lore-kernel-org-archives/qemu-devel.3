Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20492CEBF92
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 09:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLHXq-0008HX-Ns; Tue, 18 Nov 2025 03:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXp-0008GQ-3f; Tue, 18 Nov 2025 03:58:37 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vLHXn-0003VY-Bu; Tue, 18 Nov 2025 03:58:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0grOeQCKW8y/6DKPFhTLkGQiXZ70c+KNzE6yJ9h43uyvPRS4mvKRH84ZHoKz9mFopMcMXrUonbDfXXNlDORxZAhGL5cO6qtZeN/IdaajmCqlbM5UUcWBxSyIyksVvkubjuaYSnxM0OMZhxuz55N+mV7ozrQ1V1r/OHt3242L2sI8QA/e19GPAjwiFYYl/n398TbjMyCsIxZViVF2/q9lhkOVcz1MUEKx7zJO+Oo9a7CdCYLITBa45UBlay/wbaPU/V0+n3rrCoxJOCWrL6tmK5LzZzevur5IeqR6HrzHxOwCXJAKaX5yLa9VMbG5n06dRariNRK6p8b2RKDU/eOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE3+NKy0APkAID7+4k3ccrzlzMukSS4RW/9+sasbrMI=;
 b=ap2HOh5p0e/uUa1vzl4zxtw/VK2ANtZhcPDLuNM9iwNUpiOAcaNavkciJDuPDfwJ5WFo1gN31pNV1qOoON6VnK3ju9wUwuvQkxHKe4wvLMYGoQsEpbvn4ZbNOhbd5nmVPK50/UGNZpH8prrXfCIynunSd6NC6g0tOZgFBLRmjG3W8D3Kelg+0TkZeA2dzn6nRmFuQusMvsyB2N0/f/gc8dffY/V6ljPSS+rvK3uM2e1hJhaghIWtECSk7OTwv7yKpnufzkLVu2elsmm1WbPGSzB4Ot+yaxEtjHIHcT8Pmg4XjLOCaLHkqeCbYFEYX93D6/u52KN/HOYrqlWaq2OVQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE3+NKy0APkAID7+4k3ccrzlzMukSS4RW/9+sasbrMI=;
 b=PUf317s6+uZMsQD1ZgPBQ3xv646FJFQNisp66853N7IaYcMiVjI6D5EwHOEEAIbh841sJwOlALSP8/SaCv6EK5581nuoHnv5oiVi0/KI7G2G+5azPHmld+wNraeRLzgei8Vqtm8XGI29lA3Hdww+iSif6i9aTjat+mpdbhQVpdG64mpiLlxpsnXrXkfgilQEZDHzsah2SqRB0p6eZyn79uralLuylm/OlCPY4mFHE6CUs6RwjNqRO8ZRcscSxrJh0ghW+AKNe2dijF+KR/IirGmZiUOGmSYTdjaNhWTRmQxK9v0JcxWNxhYbPOl+/98CdJvRsodheOVHR+OzgLJAoQ==
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com (2603:10a6:10:303::20)
 by DB8PR09MB3612.eurprd09.prod.outlook.com (2603:10a6:10:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 08:58:12 +0000
Received: from DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2]) by DB9PR09MB6506.eurprd09.prod.outlook.com
 ([fe80::1eb3:5638:369d:24f2%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 08:58:12 +0000
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
Subject: [PATCH v14 13/14] test/functional: Add test for boston-aia board
Thread-Topic: [PATCH v14 13/14] test/functional: Add test for boston-aia board
Thread-Index: AQHcWGl3B9VTvOLmwUSiThGoKzzkZg==
Date: Tue, 18 Nov 2025 08:58:10 +0000
Message-ID: <20251118085758.3996513-14-djordje.todorovic@htecgroup.com>
References: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251118085758.3996513-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR09MB6506:EE_|DB8PR09MB3612:EE_
x-ms-office365-filtering-correlation-id: 15f165e2-cb1b-4afa-50fc-08de26809ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1XkPAczkFMb3vdOVOTd2cHXf/G+iMseT8PX6aZs8hvadLgB3vRJBGeVMH8?=
 =?iso-8859-1?Q?dm2cDNoSWQkZis+UBrW2TK8CGquRkww/Wy/CB4lUFYq6FlgpmeIzKC+4Qw?=
 =?iso-8859-1?Q?LnARCJAjEPCAY0KldLfdXQjs4YC0f9Kuv675IdFLiu3C36e6dCoUa/H9t3?=
 =?iso-8859-1?Q?zW2p3VfNMVN0b09S4vGrz3UD9dLd2wydW6+zImWiwsLQ++G+LUTxGTSfeb?=
 =?iso-8859-1?Q?CxBp3KKf+ipWRDiIrLuU6Kpd7di8poucG//OSdFDY3OAOLUioNezpdQ0h0?=
 =?iso-8859-1?Q?yH/AQespxT5byjjz7mROhI26TBGbFhIKvrwGHLd0Zi2YrqBaWcArcNnJoi?=
 =?iso-8859-1?Q?8lVvFe6HLqFLwVnPioKNXNb1svnwyAU5NQmhqrFnAkwL+YXdbTaRTOuP33?=
 =?iso-8859-1?Q?VZYmoipFoD5FeoThbc1QiJDNtT8+lfzK1ExGSiz3FfWBAEZXAw+ev75FnE?=
 =?iso-8859-1?Q?DQZ/POj7JsdAPIiPglvvfaf/J5kw8hjeDukDB65KiOhC7uAD8FqkniuXvI?=
 =?iso-8859-1?Q?GkAqxIczOa06WROVDVP1YcfJBu64ZPikx/ocyHV/f/8+aVLBjjWsEbuxlI?=
 =?iso-8859-1?Q?GcPu7WcuZXNA0qyOmpO5+DWsc9tQgSuBdHFpyd2HS+Fvrxe/9hBrqB1XSz?=
 =?iso-8859-1?Q?6perEsf4zxnap/EWXflQ4aoZ7yVoEY+k4T5PBbofI1Ll5JZ9FgvgFQPuXg?=
 =?iso-8859-1?Q?tPT7EnHCHg3Mhmwzs8lrmREEbCBOn/ShkGXCctszovsbxAk4RpF1Ui4uS+?=
 =?iso-8859-1?Q?GpT13SL1eyfcbIDrEo/r6CUXi4iR4QgNL72K1rXl1Ucx34RyhJFTLIv0d+?=
 =?iso-8859-1?Q?GohrbgbCYjM/Q4XBtNDMXypCoUCLMEWfCMAYXt48R5RVJQoLaDixqQS5b2?=
 =?iso-8859-1?Q?r9cCVewDtBe5RhzqiSlzs4ppevJEYiMlZ9Iylw3AdAivy9qEBrkIciMpcz?=
 =?iso-8859-1?Q?RyACPgmIGClawMSmUVkYAVaJeTSOUP3fBCW7kq+OOioo9ooaEhCBPgGrX9?=
 =?iso-8859-1?Q?xtAOQQ6589VEmbxyt/FtvCVDoAVOT0Ey+EYuCTZ0GWx785CJd2PFpDHveW?=
 =?iso-8859-1?Q?2SgKIdaiYn/+bwnkcdFtIjfax1QhKX8acO7a6qHcTY+gy9RkMZBYNECWOm?=
 =?iso-8859-1?Q?jqk/23SMhl81d7ucApkS8xUwuZJa3cVqB3N+le66sut70f9jh3mHjZ2ltG?=
 =?iso-8859-1?Q?1NUiQqosCl2o2wVzedYx7Pxy4Dr6kKfuiK0dArhDqsNHXCn9pOnlZlGvAA?=
 =?iso-8859-1?Q?cbT2gEEmaBVh9mNMvMDYLrrS7mTxPbeHlsFi5kMMgIrnPuKzJeKTKgwcoJ?=
 =?iso-8859-1?Q?wEZprshmZcCvSoVEjtUyDZ/3ByWJAG4mQnsUYtl3OVhA6qWFkg5A+lwjr9?=
 =?iso-8859-1?Q?rc9XuwpMC/2fGzGBPpe4KQbhjcLcqnKMm52HpRqb09siOCdeXJvW4VjKrX?=
 =?iso-8859-1?Q?0Fxlx2scQza4CzMSclbLWMhBe/sRIeC8OSBbky/GiTUlXsXRSkOKhzEU0m?=
 =?iso-8859-1?Q?7vBUE8R5hv3Ugn+wYQlhof7aT4vPcDXGeAgl/iFJsttdSDmLcg/yQ5fdpo?=
 =?iso-8859-1?Q?mKtrb5q3M/NzDmz/Ah1rYMU0khhq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR09MB6506.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TA3I5Jv/xt48N3VmF6cq/hWay5KZOtwQD8An+9I5waREMCglua2FjGIzE6?=
 =?iso-8859-1?Q?QFM6e4Lu9aYFc1R909UpnexNGmSCg16Uj9BEQvhcz8m+sJheHxYGLAuFSg?=
 =?iso-8859-1?Q?88gT7pK122+imLk2S10F9GMGZt0+ShuXJGU4yCvLqz9vAZMXAQp51WLCbV?=
 =?iso-8859-1?Q?ROhM4794spsZvAJhO1M9V19JkgvKHFGsXXm5gA++nvH0vkq+Z8beth8Jwc?=
 =?iso-8859-1?Q?h9+nMXxsphGame2i0xE+ApV6UM5lUGXjYMpaeKKEZOJgovlyograXyiLiV?=
 =?iso-8859-1?Q?UtVMblWG1Z4MK8Pqzh+6zmBClPBWDe6NAguJcRTtzu4gDgOvhrm6miPm4E?=
 =?iso-8859-1?Q?O/wXzfQ14MtbRxklOmc7fTdFjz4qMzrvBKVBtvTNTaE/iA1G20/T43Qejf?=
 =?iso-8859-1?Q?qejVrENfFwREME4+GYoJIY2knI71jtIf+L3ZmMYwaID88hKbhISsPSXWz8?=
 =?iso-8859-1?Q?sQGA+WvtTvfnsjT/QrvVPRK4JUgyaLKuCzw6NQXNaH/d3plnuARZlQHcWI?=
 =?iso-8859-1?Q?soi0iyBx5y3LfCJrmS2k3XfPCoe9ieVzpm8thSsx5/md8t++kRb03LGfVg?=
 =?iso-8859-1?Q?OfpxPceCCxwki8enmyRhYooiTIPOn0d6J3QPP58Cqb4VkC+NZZlpTW1rir?=
 =?iso-8859-1?Q?xLC8WCRx5SbSWCb1ZQYCbpqu80fzmQu/1r/dTb0fO8En/X5vNsz6E16KJH?=
 =?iso-8859-1?Q?Ab/NhnsIaFhzO/BzAyf4w+tNaVirit2w0D+A7NQeSbttZMt7kH8BzCaYka?=
 =?iso-8859-1?Q?inuMHp63k5JXn2fjJZ/90+z9gaoUEQxZrZNeK/5hkqSPjJH7G2GrXpgKGq?=
 =?iso-8859-1?Q?CA23bgjdV+W3Y84MV7LfsC0Vci16qd3tmoxSu5ZqWuGnfgMJ5RKbAlrks/?=
 =?iso-8859-1?Q?pc9oLwhYROuuUuis3+8NTI65ktzNUMbdROw3lSqhMuk5iAwU7TOEh9FR27?=
 =?iso-8859-1?Q?hbKTZTZkRT0UGPmGPsfvBeI0cG/bh3KoSvhnt3rJjUDvZ8+Sagu1hpzBTQ?=
 =?iso-8859-1?Q?s1tp+W+JV/XMghSfLaZ1ZizHTJ46jhllAEjLdxvRjBVyVJwDfJagW3+AiZ?=
 =?iso-8859-1?Q?gsjC4m3voUGfARs6kkfZ9xGpCKzTfA/uFfuzMGaF90p9iPreffcPnJt46N?=
 =?iso-8859-1?Q?0T1c8GLZpm3h2MbXAV2ZwitM9gLNh0M5b5Ddba5fltYaKcPg0B4biRyiQt?=
 =?iso-8859-1?Q?Cdp08H+WNvZjHPDIJSMI5w6cxeK4N6mzQzhZJCp9Jc9jHIr4yFT2cFHC4m?=
 =?iso-8859-1?Q?cqifG504hE229/zuz91M7JVRnpC/ZV3REbbr5/JtdtAQF+Twi7f7l5BUWE?=
 =?iso-8859-1?Q?iaK4LimpuZk8ebC2qOyJKoK+TncMG2Z/T86SEtELiXkHZlSuSWbevuK76x?=
 =?iso-8859-1?Q?d+CiAPu89kHHRkdVecEBq+rPA6Q1ySDXfeprTfprYdLLcrFk6AkdTFz/Y2?=
 =?iso-8859-1?Q?zbPBeLFg0fSXcSLYeHEA7pkyhkxFgr912YfvM0wcIVdIcwoeGbImZxRHSA?=
 =?iso-8859-1?Q?SM3FCxAkg7+n9PYmg5FJt+wIDhIydaz/umh94F/vC5r/jHUhA5FydCyN0s?=
 =?iso-8859-1?Q?YbRBzu0Zr/LeXD/Mh64wIyXujaU8AWf1t3CR1PK1h0DgDu104a7fuGECIF?=
 =?iso-8859-1?Q?aIobyyph1rO0Zw+FXLyRZFR1fsn/h/phiqdSeiIAPJQG1HASP3IqTVVEyk?=
 =?iso-8859-1?Q?CSVjGeCnMB37nF0xiXM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR09MB6506.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f165e2-cb1b-4afa-50fc-08de26809ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 08:58:10.8199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QPGIsU8S8KGbZ682bvOap7/I8aQpPZ0egXQfDImLD6Fa/ZF2OluxDTQJVEv6iYyCgk9TVQhUXLiwQPxOAIvXlwyNvrM9RBdGMKKytzmRu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB3612
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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
index c1704d9275..b996c89d7d 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
=20
 test_riscv64_timeouts =3D {
+  'boston' : 120,
   'tuxrun' : 120,
 }
=20
@@ -10,6 +11,7 @@ tests_riscv64_system_quick =3D [
 ]
=20
 tests_riscv64_system_thorough =3D [
+  'boston',
   'sifive_u',
   'tuxrun',
 ]
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

