Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1535CD5BDE
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS9gZ-0001HJ-7c; Wed, 27 May 2026 04:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gU-0001Bn-Hn; Wed, 27 May 2026 04:32:15 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wS9gS-0003xv-O1; Wed, 27 May 2026 04:32:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V60gGDQZitvI+eaIVQ+P/8O9XyfWWPRRI9tFTWQdGV7QvqQUy6AWx4LkyRIS73Zswi3AEbjtI+NQntSIwovBcebnCeAius6NwAI4RK+B/G/pFNmg39Z/fxE+eF1lEVj1nT2G/SuzSOGTFRgutH82RqbC403EZ1ReJQEf7qwOaFxmmBRwk6cmM2mdJg5bSmFJMv8iJxWCCiFfZU2i/JPqPAC6Tefg9zKm/nwDcArqiObj7QmV39foloyPZiqLvg1LNIGD7yrXEBRs/zNf7QOZm7KFvqkd5GiEZm77o4rnDoLIJTdVuH395T/QoHglHdOgByp03ephguBkf2i2sQBY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnMdg879MLQmlrTDWV1ZatqlH8cLuWshdwJGs9NbBIU=;
 b=c1vAiWSz4MuvNqQokkCTl4qnxRA9FCJOgCZAe0vn81TyBSajrbhooM7PQnEZvrM81NzLQedGemCyHu1TD9NGQ3TSs60Ekrk+GWQzaYLAyZt8t6B+grK6qiak75MPFgUDnLszDgyUHdSLyV9stVwdD6T7EzWTqIuqStw/kqvRCWfn/UROQkrC9x6l8u8P9TxopitmpN6o0ZwFy/WHkv2kxOTpnwTr7s8MnE4UscuM/eGLibt0ODfqtCqvPBxEGUZkg+zzwtgP9mGO3nAdNkyI5ynzIYFw++MdFjIaZTOlKgXlKR/8dPpku/ZgwuIEcPT2bl40RtJWlAHkS+SV3iVvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnMdg879MLQmlrTDWV1ZatqlH8cLuWshdwJGs9NbBIU=;
 b=jym+VqQ4QGHuSAC9eTCk+dOXh/egVTExe3802Z4pLpncHR2Jz70LiUL28e5YLVmW4/GamT3XhePQQy0Ppce3LtAATDt1tUKSTAI0RzXhE6vHKs862oJWx1ORUp0b247HkRLthsBMJkRzNYKgGCU/wN0TPpRQ8ej0ZCbQkEmsU5II42qb/+RtO6ECpe6n959JjmAiL61xhAjWVSHNR5qA7brOS63KQp34cI1L3cT2NbRKGNgFp5rFvXZ+qmHj0O8XauNQAtaUw+VEWeUcDxu2FZkKcyXeFni8LXVFlhtJMByAuoSvF7kGpscU9mUfDQWL7SyxGPbK+x1QUT908j8uMw==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AS8PR09MB6314.eurprd09.prod.outlook.com (2603:10a6:20b:57d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 08:32:00 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 08:32:00 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v10 4/7] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v10 4/7] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHc7bNJQZ2iILPDA0e98+ih4NeshQ==
Date: Wed, 27 May 2026 08:31:59 +0000
Message-ID: <20260527083151.17876-5-djordje.todorovic@htecgroup.com>
References: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260527083151.17876-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AS8PR09MB6314:EE_
x-ms-office365-filtering-correlation-id: 2f9877d4-0b23-4a73-a725-08debbca6c0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|6133799003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info: 1oOLBoqv55vTKF0dO8C/TprQQ4qEQYMbYrnTUthDK7IWnUKnk6KFpaOd1NJt70nazKMOlhhxJFGmVpsd5G28bLGf+HmWF9otEk4meusA1RWLrM8/PUyyPAHykjWy/nwl7MMXtyHiOQLjQ9L0bV0mnfeNTPF7V9dhdkWccL3V7xC1kd3P5x/GWt48LaxcJNgNuUipLZdbHLd6ZlGqBE7gQ9IX+z0kkzsqfcCOOQuRnGoRE9nPi1d2GOoFqd0qOj6q5aO9jHrNNmyzzq3TGT32TqOlgh8oduyFd7CvAI2RXH0VCZN3dQDuLlcXBgiV+Rk2yyYL2jp8iMThHoSOG+12AlupQuo7iRQJoce8tzClCTlRgpNIIfJrjfbHYP6FVh7YqKw/ZhbUjOxaw+DIo/7kkC+X9MUmcVoNRbmC4RDvfPfv11d3BS65rBq9jO3hTobwZy08moDrFPV1hzo117sQRPlFtGudJLJY1S6daEvyku3YxnJOizvVqgZs85OZ5z0zkSPATDQ9Q9es+JflD2Di7+hgVNCxOllZOLfOjHHbBDwdVd6pympzTETL1Pa15dQklt25vz+E7jplpYzsBbw8Ur2R7DNUcDOXHUBhO/6yk+5PIbcFFtpUyR1jJA1Eomf5NayYNOyqHxsQ6zoIISFO7Mdj7XYeEOYmQsenY/w20vdzrUPHW9R0EvagnStnG1yBYbqHftHLjKL3xixmiyEtLCmH1oOZRpVD0WK1wIhU53T0fWlxossoE4UF86luUU1Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v+N2SpRG8zBuTGojqnwBSrHg78I5khJfioCj76gmQ8EnrrnuqltilkRNf1?=
 =?iso-8859-1?Q?WzS0dsQjNVM31W3nl6/fv+xxIdavR7+dBeqPC+3AgfZsd6AYkdhcrAHlq3?=
 =?iso-8859-1?Q?BNjc3jDodsO/9clu0vqslfTPljoe+2ZHQrfo5oUMVR/UmceTirEmCKR24t?=
 =?iso-8859-1?Q?/i83GyI95Ic9rnrn7d/sfovhGV/xOEsiKFLPGY2D/PHnDqIbZxy6T9n4ph?=
 =?iso-8859-1?Q?fe1vpU//wc3NlQNR6hqTd9cw/HvLBcbnpLIGfAZSJiPwpjm4SI6NYMTpFZ?=
 =?iso-8859-1?Q?iVAOeWDtln1s9RV5RHWxTvImSTn89suMk3ofFpo5kY6GG2nZkcs68PRzz+?=
 =?iso-8859-1?Q?5b4DWo64tMurnyCXYh7/CKxoJVx/+R/HE0fROzEsbcb1vnUbQhFxE2Yz3t?=
 =?iso-8859-1?Q?QQ6Yj+CWE3YqbH5dj8v6MFttLM0Qoh9uR/iVCUpkXc5OliXBgVDqxZhmC9?=
 =?iso-8859-1?Q?UoMH7A1noQ8wbuHeIBXe05uF8AXgI8OL7WqcNXYsy6LmdqTSDaRABFGOxr?=
 =?iso-8859-1?Q?OldeLaOb720g/LcpUuJL2gNmTi78736mfUPGf/6sfczLlb6hsBUMuFviQK?=
 =?iso-8859-1?Q?wMhqOlR9zO377R2KE7ag9rOCenS4c300rD6GJ94JtdREZkQNCcjzhx4RD7?=
 =?iso-8859-1?Q?CH0n2ii83ERdNdIa/FmkjjQ+3ef70R3anM5ctrh7zMfS+HhBa/NyUU94/q?=
 =?iso-8859-1?Q?NbHa0GAQQJZ7touiY6Mk2D/Rui78dH/rZTC2kZ5Drm1G2B5eaGvZJa7QP6?=
 =?iso-8859-1?Q?MDEXLVYgGbfs0g57X1eDy19LM2OI9MudUupGCs+J0uMpPuTxi3JmeiqelN?=
 =?iso-8859-1?Q?PdbpmTotr19fUYbceh6JPM2UDVCoOvWPMTaREPCznIKR7EktP98+vn9SjO?=
 =?iso-8859-1?Q?lirPJWIzZasFyIm0sW9C/b/Tq5Vo0m7eO2ZiMKLRh7dFenliH+4oC95a0F?=
 =?iso-8859-1?Q?kL/Iiv2wgy6gkKCxdmq7gLUKBxJ/6tTRI77HG2gnHxkF+GUZH3GP9Qv5X2?=
 =?iso-8859-1?Q?dZSNhHyApB7zHPnZX2kPXUAhTL3enHNZFoMyN26QeXrP0ofL6xU1m9sNJ/?=
 =?iso-8859-1?Q?OxIgmuFcJV/J5ArGmlgO1iGqrBeb+D07MMPrXh/34M0F4XXJMMLiWhBeh5?=
 =?iso-8859-1?Q?jNE71fAIw/rDe+FpePCiRLbjyxJPi8MULbDKmCFNLSsM9luZQ9mbsMW7PT?=
 =?iso-8859-1?Q?AVFpHlCJyJye5GLxuJKwpAVqp7s4Q2DxfRaQNSlTAdjoV0sm2HT4FB/7XZ?=
 =?iso-8859-1?Q?H4HYr731hgHFCLBwoeqFkgOi5/H32M5k3WX76l5iSyCi/FHCHMuA9wsVkb?=
 =?iso-8859-1?Q?ZJKbrmqgadZvquEeAmyMlEB81wfI8BPZ5IYg+yoGPZg2gncOW3+cMa+74k?=
 =?iso-8859-1?Q?0C39G0v//d+oV3ukDmhFDGnSdLUYZ6FwS/mKEnNoXEacOOxmCuH8yDFL9A?=
 =?iso-8859-1?Q?lwBIfNYX918l9lDRHZ6qCXc5tTnxliKu9TVlVY27JAZjQCpE0uJpsGjvHl?=
 =?iso-8859-1?Q?j1WwienYqBNrTVagzQdxk34lwrHrnOfF8X/9oKMpy/Ag2ACek6tUUs8jzF?=
 =?iso-8859-1?Q?9mPrGmp6lcJrNZnpraSv2IZJJyrKtbRQLbp1C5NjRfD9YIBa2IpUFrQUXi?=
 =?iso-8859-1?Q?GHtlzilt3pRTvzjm5JD/elBqWKguauxfx+PUThXj1c5eQkBxqFpLFy1Ksb?=
 =?iso-8859-1?Q?3KZc+XupLgxYAr0XxDxtoJp8uZlSc9iTMiheqQogUAhrY3VZvnBZUENF9E?=
 =?iso-8859-1?Q?Wqja1Cx0RtenlUfo1gSDmVrzv4TuArLbNul5yc2EvjyToS4afHUtotuPsR?=
 =?iso-8859-1?Q?kdeJrdRdnuMoCRy5EzH9/6VugDCajzEGpPae51ZTNEQNhbv8NVsb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9877d4-0b23-4a73-a725-08debbca6c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 08:31:59.9790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBGQX/NQcZ1l7XNs7+3/ro6EA/e7Ip9k29p3/nyQ5N7NMCYHfwIbBL+bmrWjcw+JMHxssAeKjaPflNhhFI+9CtG94DlZqqFGJ6wtSvIRHp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB6314
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
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

Add riscv_is_big_endian() helper that checks the hart's big-endian CPU
property and use it throughout the boot code:

- ELF loading: pass ELFDATA2MSB or ELFDATA2LSB based on endianness
- Firmware dynamic info: use cpu_to_be* or cpu_to_le* based on endianness
- Reset vector: instructions (entries 0-5) remain always little-endian,
  data words (entries 6-9) use target data endianness. For RV64 BE, the
  hi/lo word pairs within each dword are swapped since LD reads as BE.

This is part of the runtime big-endian support series which avoids
separate BE binaries by handling endianness as a CPU property.

Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
---
 hw/riscv/boot.c         | 81 +++++++++++++++++++++++++++++++++++------
 include/hw/riscv/boot.h |  1 +
 2 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9086793b7a..37b8f3dfa7 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -40,6 +40,28 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
     return mcc->def->misa_mxl_max =3D=3D MXL_RV32;
 }
=20
+bool riscv_is_big_endian(RISCVHartArrayState *harts)
+{
+    return harts->harts[0].cfg.big_endian;
+}
+
+/*
+ * Convert a pair of 32-bit words forming a 64-bit dword to target data
+ * endianness. For big-endian, the hi/lo word order is swapped since LD
+ * interprets bytes as BE.
+ */
+static void riscv_boot_data_dword(uint32_t *data, bool big_endian)
+{
+    if (big_endian) {
+        uint32_t tmp =3D data[0];
+        data[0] =3D cpu_to_be32(data[1]);
+        data[1] =3D cpu_to_be32(tmp);
+    } else {
+        data[0] =3D cpu_to_le32(data[0]);
+        data[1] =3D cpu_to_le32(data[1]);
+    }
+}
+
 /*
  * Return the per-socket PLIC hart topology configuration string
  * (caller must free with g_free())
@@ -262,8 +284,9 @@ void riscv_load_kernel(MachineState *machine,
      */
     kernel_size =3D load_elf_ram_sym(kernel_filename, NULL, NULL, NULL, NU=
LL,
                                    &info->image_low_addr, &info->image_hig=
h_addr,
-                                   NULL, ELFDATA2LSB, EM_RISCV,
-                                   1, 0, NULL, true, sym_cb);
+                                   NULL,
+                                   ELFDATA2LSB,
+                                   EM_RISCV, 1, 0, NULL, true, sym_cb);
     if (kernel_size > 0) {
         info->kernel_size =3D kernel_size;
         goto out;
@@ -406,21 +429,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
ne,
     struct fw_dynamic_info64 dinfo64;
     void *dinfo_ptr =3D NULL;
     size_t dinfo_len;
+    bool big_endian =3D riscv_is_big_endian(harts);
=20
     if (riscv_is_32bit(harts)) {
-        dinfo32.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo32.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
-        dinfo32.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
+        dinfo32.magic =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_MAGIC_V=
ALUE)
+                                   : cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VAL=
UE);
+        dinfo32.version =3D big_endian ? cpu_to_be32(FW_DYNAMIC_INFO_VERSI=
ON)
+                                     : cpu_to_le32(FW_DYNAMIC_INFO_VERSION=
);
+        dinfo32.next_mode =3D big_endian
+                          ? cpu_to_be32(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                          : cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo32.next_addr =3D big_endian ? cpu_to_be32(kernel_entry)
+                                       : cpu_to_le32(kernel_entry);
         dinfo32.options =3D 0;
         dinfo32.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo32;
         dinfo_len =3D sizeof(dinfo32);
     } else {
-        dinfo64.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
-        dinfo64.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
-        dinfo64.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
-        dinfo64.next_addr =3D cpu_to_le64(kernel_entry);
+        dinfo64.magic =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_MAGIC_V=
ALUE)
+                                   : cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VAL=
UE);
+        dinfo64.version =3D big_endian ? cpu_to_be64(FW_DYNAMIC_INFO_VERSI=
ON)
+                                     : cpu_to_le64(FW_DYNAMIC_INFO_VERSION=
);
+        dinfo64.next_mode =3D big_endian
+                          ? cpu_to_be64(FW_DYNAMIC_INFO_NEXT_MODE_S)
+                          : cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo64.next_addr =3D big_endian ? cpu_to_be64(kernel_entry)
+                                       : cpu_to_le64(kernel_entry);
         dinfo64.options =3D 0;
         dinfo64.boot_hart =3D 0;
         dinfo_ptr =3D &dinfo64;
@@ -489,10 +523,33 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
 RISCVHartArrayState *harts
         reset_vec[2] =3D 0x00000013;   /*     addi   x0, x0, 0 */
     }
=20
-    /* copy in the reset vector in little_endian byte order */
-    for (i =3D 0; i < ARRAY_SIZE(reset_vec); i++) {
+    /* RISC-V instructions are always little-endian */
+    for (i =3D 0; i < 6; i++) {
         reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
     }
+
+    /*
+     * Data words (addresses at entries 6-9) must match the firmware's dat=
a
+     * endianness.
+     */
+    if (riscv_is_32bit(harts)) {
+        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i++) {
+            if (riscv_is_big_endian(harts)) {
+                reset_vec[i] =3D cpu_to_be32(reset_vec[i]);
+            } else {
+                reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
+            }
+        }
+    } else {
+        /*
+         * For RV64, each pair of 32-bit words forms a dword. For big-endi=
an,
+         * the hi/lo word order within each dword must be swapped since LD
+         * interprets bytes as BE.
+         */
+        for (i =3D 6; i < ARRAY_SIZE(reset_vec); i +=3D 2) {
+            riscv_boot_data_dword(reset_vec + i, riscv_is_big_endian(harts=
));
+        }
+    }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
     riscv_rom_copy_firmware_info(machine, harts,
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f00b3ca122..93b9a37f03 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -39,6 +39,7 @@ typedef struct RISCVBootInfo {
 } RISCVBootInfo;
=20
 bool riscv_is_32bit(RISCVHartArrayState *harts);
+bool riscv_is_big_endian(RISCVHartArrayState *harts);
=20
 char *riscv_plic_hart_config_string(int hart_count);
=20
--=20
2.34.1

