Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86306CA1007
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut1nC-00044H-Et; Mon, 01 Sep 2025 06:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mw-0003uQ-26; Mon, 01 Sep 2025 06:29:27 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ut1mt-0005KL-US; Mon, 01 Sep 2025 06:29:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofpHzOc0e3YAIn8PRCxdLpH+GzM1ghEeUE/NQWiYapZ/CgcGh2rRwyIvziFU5ai9zHQcY6ugYO4d1Py19afgQ1ar4wUjLQrecdZ8NaN4vgx7dF3mm/t5CBT4jqsjlfYKJPBAH1N1Pnp7SsKOynpnOpbYb2qCm6fzUPclhFHO/5UR0djiYjpiaddsLKc1C+4LOTm73rSMt1W225qcpxetRBOFD4PkPHG2qp61STXHfThkGEPDo20cx+xX7BQ5W1ur7zf0q/mGTU7wawUVr/YVx6LwNE3zo32WaFAHzLO6V/6z9pJGjp/zANW4bUWjhZjetLl8wdR2vIMNSp9ul8Gq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzhmDN8tg8WZWhwKcb/wOoNA/8+s7ZNtrQDbP75N+Fg=;
 b=BceMMO4/bjpO7YN52sE4T+Be5Bc6vhsL3VWlrsKYbk3OzGZzYPPNVZ0yOftM6L/DIqmYfpBaA7O3zYTB7nqJQlSA6iEWv+GN4mO4REZ2dRjK9lFIT23IEdvz2GM5zMEY5XFDaQBplHr4t6RDPexMppH43lK4FTn50VyRW9HTTiXa5XeVkdM32j+inoM+1fhf1vIMI7HnDNxgGjMincIOF5Vl4w77mcDnSKSprhT0NMovM2QSoS5Fl6JB76e5UEn9cVmZAx0lVPebKKMae5RJpc3UEFDT0BV6xPj7KBXlcOaAlB6SGxBeDhuf+VeDzynxliD2b6tDY0fqhnTKwMiIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzhmDN8tg8WZWhwKcb/wOoNA/8+s7ZNtrQDbP75N+Fg=;
 b=SYedbwgng5coYsgPWtd1eotYPVPUSYx5LMIXyKXWi1T2PSlvi8cje0g7vz7oNdSVi0rL8k4BJlxMHDwYi7JrFiFkUFopcUR3uaBkpPX/mCGSDBDKPnvVNSz6ZYovG9S2cn30HbjkmDZ8xscWGnAXHfo0m/r7J6owTy/1+0dX/aHSmSoFOkj0kBFTaNPKDZ78nBPz+urBDjWtf70ypbo8WixEGDoMDJwD/tlNUFMoT+euu1yM0W5Wzm46A5L253tVJM6jlSd4AC0Ff8M67NR23cu48sn9Ckv7cJB8PDr+sYrGI8cddQVo5u8tOQnvPaVYO5jzuZoDvelfHYjOKsVxlA==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by GVXPR09MB6894.eurprd09.prod.outlook.com (2603:10a6:150:122::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.28; Mon, 1 Sep
 2025 10:29:06 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 10:29:06 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 06/14] target/riscv: Add mips.pref instruction
Thread-Topic: [PATCH v7 06/14] target/riscv: Add mips.pref instruction
Thread-Index: AQHcGys95I+sV5+n2kmz0KHDj5zI0Q==
Date: Mon, 1 Sep 2025 10:29:03 +0000
Message-ID: <20250901102850.1172983-7-djordje.todorovic@htecgroup.com>
References: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20250901102850.1172983-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|GVXPR09MB6894:EE_
x-ms-office365-filtering-correlation-id: c6ae265b-faa2-44b2-9662-08dde942612a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UXxPG26xoA8s+yQ0aNwgrXv1CTLAyW9SsbSfp4mW4go0pi1TcxhkQ2VK3P?=
 =?iso-8859-1?Q?KrbSPm0BPavWvVxePNi9TimybdRuk+c4hFmNcY/K4RrQJz8kT6hIHNLyye?=
 =?iso-8859-1?Q?2xUQgxOF16bg750scTvUkRbKUdF+VSOQnIiuxXzVpK3xQq5DTV0Yn5Djkt?=
 =?iso-8859-1?Q?XyO9N4eLsnsoiBb8/WHlZfTYZY18SUdJ/if9t5pSxdrFh/GOeSpch/6NJP?=
 =?iso-8859-1?Q?IB8eCVZFXPY3vEE6QRlaa7SFDYh1qBpDcpoPKrmtKUYy7e9B223j2fsyh9?=
 =?iso-8859-1?Q?I7rE6j9+NMIDMV4I668TEh2vTWA+8xm7h6Ht8JXMC1YZ6ca/R7Zu2F14hf?=
 =?iso-8859-1?Q?oEez6vlNs2cT4iLSIL48K6jBLqx63HtN0r3w1SvSGAor5vH+aE919gTFVC?=
 =?iso-8859-1?Q?Qzorm6X/APNhwKTR+N96nMtn5Lnz05hPVx+qSn4vwvS0MImlxUdlfNkAy5?=
 =?iso-8859-1?Q?c36vZiBlubhTjxpKf7A5DCDbcq87n/4KfFKgcTe1sGxCrm56HUEIQROA17?=
 =?iso-8859-1?Q?iIsIQxTMk2vOjn1nUMYEI2F9eJbrokfyr7L/6dCkBAGtCD851xtri2RnLK?=
 =?iso-8859-1?Q?J2FmrGHrqP2kHol7vMzEPK47cI2cwPHLVnx1RrMYMNgR7rkDa9H+QfivCe?=
 =?iso-8859-1?Q?/hVQ93x6nyBu1M6gl4Uapu7lcysCqKQv65gJbvX2gU4u/FC1IYWFuS2KnJ?=
 =?iso-8859-1?Q?JWCiY9v+h4Ba5+R1GR3eyC86dEBXssGvN3cBOnIIHmNFfpIxxpBacyBvg5?=
 =?iso-8859-1?Q?IRC6xfx320kvwqcQ5UiqtDM+LgH6wwiEC9w7cocY37WcpLKptkEJ2914z8?=
 =?iso-8859-1?Q?ETLHqgyGWxkDhyBmZPjwG/yxCpi02R4Ynv+lKsnB119SD0lryeaHKpFO72?=
 =?iso-8859-1?Q?ZWVb37Rom8Yz5SKh7Yqrq1IMozyeje+gDZxa7GIDeTDIDfP6D96ESGMXCY?=
 =?iso-8859-1?Q?tO357qtHNugqxwCpTNDh0b+oHedNhkVV41oiN/1ogzoLZJZI67lRwZ+A3h?=
 =?iso-8859-1?Q?nJnjOOEXhjkkwZclYDILTc1G/2ryKY7vxsV8Q4Tt0FgwleiQEFV5gGD0K7?=
 =?iso-8859-1?Q?KLlgFxYGM39sHU9mu3nmu2D42jxVHpzNhDqg9t1Km28hqh/NNNkzTT0jzE?=
 =?iso-8859-1?Q?qsNf05F3x06lyD5JuiPjT/tD1jBwjqUI66xN6ljM7vp+DLIA4I5r1FnQZG?=
 =?iso-8859-1?Q?PG20G4rMp7bnAIxkZZUilotgnQUd2TZXJab/c0IAZRnl84Fsu2gf9UHzP0?=
 =?iso-8859-1?Q?sl9MWGHmspvgf39h/1oB8dA4nFHIIFPYdHuVFDTwceRsWggWWuW4Lzlb3N?=
 =?iso-8859-1?Q?QbIf2uNV8INmLbBfUQZ/CIsLZhZZSgNz/pn1dMLUDiSiR0FfwCATj+4pt3?=
 =?iso-8859-1?Q?NB8Ry+FWkL7FIhtaF2sPF4jlw11oWFvUH5wWA6ZvlBfBlB8SxtS2a92ZMd?=
 =?iso-8859-1?Q?Fk0ivKZh70Etac3wRJyswxfCdjQdaz2flqxp1Fmw6NUljQEWfMDxvSoaAf?=
 =?iso-8859-1?Q?UZPKQnjBgRj2zSe0dVAwiDfxzQaPSYlqW0DnSb5vhNOKB5z5tEoc6hBd/s?=
 =?iso-8859-1?Q?0qauZ0A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T8DaQnYhcgb97h6kusOyCLtjbLfG5uKaLzJIvcd7Ms6EBBJ+si7zf3YG74?=
 =?iso-8859-1?Q?iFQHfhYjP3Gv5QwZQ7burNDYVEt5WbxeoPCyIqwolUk2nF6txRMcDPlqCV?=
 =?iso-8859-1?Q?3aahTTkY6J5uTqrPwiUN2bjFCi116CFbBIdomZZGF2+RofeB1oM5V8smGK?=
 =?iso-8859-1?Q?DNHc5STJQsTSy/Memd3v6ojvWIUj5s+qFVh77fCjRHdAn1Q3B9o+E0zdtk?=
 =?iso-8859-1?Q?2C3R4kHxj7sPLi5kilQFH3h0Hcvsgk0w029Mid6lH+cCQ6Pa24sTJUlc/L?=
 =?iso-8859-1?Q?3fk19pTaWhEJB4tbk/A7yJl4zMTPWyLXuKklhGL5ZRcH1JY5+0nK8zn7Ji?=
 =?iso-8859-1?Q?oTckoTYXc6d5Sq+Dk5JS0QM0NKMf/GcFZl7pIrEmoGpdrzQOLACGJ5jnm8?=
 =?iso-8859-1?Q?h5g7EemhKNy2SiTmf9Wvm6afhKTrhNZJgwo/3TydpghqIK1raZ1KxGCMR3?=
 =?iso-8859-1?Q?qvy3I35UfcF2Gg2yXPSFeQYVaxJM98PVoSq/unknRGkORhVs5O58VRy1fY?=
 =?iso-8859-1?Q?P5f7se8fozMRa16SAIw2roPuL02wXs/TvH2k4ohx+4wJAlYfKVynOfIRyk?=
 =?iso-8859-1?Q?Uwqc9H4No/+s99aJsTbqbkmIkgk87BnqD68nnx52U2G3WWBfjeOyyTV+Tu?=
 =?iso-8859-1?Q?W7VxMpb1GROrny7pt7zV/mckZ3O2x7m/O4j4wtznL4TDM5V8uMxICC02Yc?=
 =?iso-8859-1?Q?tx8Ow4ZXG8HyPQZilkDmrrbw/+tczU9LwNOIM/gGkvUIK0I+tJQTZXCZxX?=
 =?iso-8859-1?Q?/qi6oNg+G9AZHh1fWSRj0Yxoe0xF6PI0FPnt1W+rsEXm6OV7TFyNToY8Dj?=
 =?iso-8859-1?Q?Q+8iYbIeUdcK7d+EYX0XNQFsqvhcW4VgpfwIZxInoodloXaCh435XFFw8h?=
 =?iso-8859-1?Q?Nsyg6byiaRlqZOly1xs5evk9YcfxAAdZqxlOCb4hkJ0Yi5AzbtbI0xU5H5?=
 =?iso-8859-1?Q?4tdsAsqWOtqcndnF/pULrjPqpv1qHTJNleFZtWNsbtaqxvsLvpTsl5tM0d?=
 =?iso-8859-1?Q?q8ZUHyTDOmwjg1F5dxPj38vA/S0B+jRuDHAjr2qA1vojcEY1FasxScb8HK?=
 =?iso-8859-1?Q?OdrfjGfzuu5PODnxAcrV8DxH9L1ghfQSv3SsiJglRGJSXLcZvorcs9+BYZ?=
 =?iso-8859-1?Q?vZiGzdvQZAQmJ25Df0CREp5LM6BT3LzO2+Z0yG/P3hLyrKE7bNKJo35/oI?=
 =?iso-8859-1?Q?2vu6pgMgB+ZGSlJRNmepZ0a5w1J94btenUVHssGcDaJGS8uNm+pMnZ3nsH?=
 =?iso-8859-1?Q?VFiDnIzOVIShmBWxTZAFlzml6RsIP6Rki/T1E4BUXIRrD7SazUYgF+uWcP?=
 =?iso-8859-1?Q?Nx6TAf1HwuCRhdIMPPOkVY8BR8ix8V4h6WBsoct0SM3555ioYuxqa+S8/v?=
 =?iso-8859-1?Q?U6GS4lBCKIqWi+iKk8ggqnOyinMx7tzgx0sBGF9iZhYWKfGQD2Uzo+b3ER?=
 =?iso-8859-1?Q?8SZFogUcf0w91dOEIy3GU0nmu+ayzCjYEl3n+HwhYW+XD3vsaYMFL9apin?=
 =?iso-8859-1?Q?Q/OeWvQSk4nswsY9gLiYvdi3HqSRtET7xGaNUeyF5Cr8QbVxwYkR6+4U7H?=
 =?iso-8859-1?Q?ayH5iuJ96RHW4wZiQCzuaDyjq0/4g2QaredawmiCyhnrX39Y1XzpecSqZe?=
 =?iso-8859-1?Q?uU00KeDTVQcR9NLSFFQpNnNYkSpdyb+rgxI0eReScgwLIyDjNfTctkN6s7?=
 =?iso-8859-1?Q?Zv534eDuk+jX52olZlk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ae265b-faa2-44b2-9662-08dde942612a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 10:29:03.7196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syA9sUSvS3kIJL9TQ4dQLXXr9ZL4p5pmbnVSO0LYWH/zDrOQTct4TCBOl/C13feJzfpKNBCjdK49klM+dEtEbQSney29gRXFz0Mg2Cv7w40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6894
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

Add MIPS P8700 prefetch instruction defined by Xmipscbop.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c                        |  3 +++
 target/riscv/cpu_cfg.h                    |  3 ++-
 target/riscv/cpu_cfg_fields.h.inc         |  1 +
 target/riscv/insn_trans/trans_xmips.c.inc | 14 ++++++++++++++
 target/riscv/xmips.decode                 |  1 +
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a725f4e366..a22a5578dc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -246,6 +246,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
     ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b),
     ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
     ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
+    ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
@@ -1379,6 +1380,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] =
=3D {
     MULTI_EXT_CFG_BOOL("xtheadmempair", ext_xtheadmempair, false),
     MULTI_EXT_CFG_BOOL("xtheadsync", ext_xtheadsync, false),
     MULTI_EXT_CFG_BOOL("xventanacondops", ext_XVentanaCondOps, false),
+    MULTI_EXT_CFG_BOOL("xmipscbop", ext_xmipscbop, false),
     MULTI_EXT_CFG_BOOL("xmipscmov", ext_xmipscmov, false),
=20
     { },
@@ -3294,6 +3296,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
         .cfg.pmp =3D true,
         .cfg.ext_zba =3D true,
         .cfg.ext_zbb =3D true,
+        .cfg.ext_xmipscbop =3D true,
         .cfg.ext_xmipscmov =3D true,
         .cfg.marchid =3D 0x8000000000000201,
         .cfg.mvendorid =3D MIPS_VENDOR_ID,
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2db471ad17..9734963035 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -22,6 +22,7 @@
 #define RISCV_CPU_CFG_H
=20
 struct RISCVCPUConfig {
+
 #define BOOL_FIELD(x) bool x;
 #define TYPED_FIELD(type, x, default) type x;
 #include "cpu_cfg_fields.h.inc"
@@ -38,7 +39,7 @@ static inline bool always_true_p(const RISCVCPUConfig *cf=
g __attribute__((__unus
=20
 static inline bool has_xmips_p(const RISCVCPUConfig *cfg)
 {
-    return cfg->ext_xmipscmov;
+    return cfg->ext_xmipscbop || cfg->ext_xmipscmov;
 }
=20
 static inline bool has_xthead_p(const RISCVCPUConfig *cfg)
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_field=
s.h.inc
index a290303ee7..dd3ee7ba2b 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -147,6 +147,7 @@ BOOL_FIELD(ext_xtheadmemidx)
 BOOL_FIELD(ext_xtheadmempair)
 BOOL_FIELD(ext_xtheadsync)
 BOOL_FIELD(ext_XVentanaCondOps)
+BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
=20
 BOOL_FIELD(mmu)
diff --git a/target/riscv/insn_trans/trans_xmips.c.inc b/target/riscv/insn_=
trans/trans_xmips.c.inc
index f5aeacc6fd..620c59cc28 100644
--- a/target/riscv/insn_trans/trans_xmips.c.inc
+++ b/target/riscv/insn_trans/trans_xmips.c.inc
@@ -21,6 +21,12 @@
  *            (https://mips.com/products/hardware/p8700/)
  */
=20
+#define REQUIRE_XMIPSCBOP(ctx) do {              \
+    if (!ctx->cfg_ptr->ext_xmipscbop) {          \
+        return false;                            \
+    }                                            \
+} while (0)
+
 #define REQUIRE_XMIPSCMOV(ctx) do {              \
     if (!ctx->cfg_ptr->ext_xmipscmov) {          \
         return false;                            \
@@ -42,3 +48,11 @@ static bool trans_ccmov(DisasContext *ctx, arg_ccmov *a)
=20
     return true;
 }
+
+static bool trans_pref(DisasContext *ctx, arg_pref *a)
+{
+    REQUIRE_XMIPSCBOP(ctx);
+
+    /* Nop */
+    return true;
+}
diff --git a/target/riscv/xmips.decode b/target/riscv/xmips.decode
index cb334fa4bd..697bf26c26 100644
--- a/target/riscv/xmips.decode
+++ b/target/riscv/xmips.decode
@@ -9,3 +9,4 @@
 #            (https://mips.com/products/hardware/p8700/)
=20
 ccmov          rs3:5 11 rs2:5 rs1:5 011 rd:5 0001011
+pref        000 imm_9:9 rs1:5 000 imm_hint:5 0001011
--=20
2.34.1

