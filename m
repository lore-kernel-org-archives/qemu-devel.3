Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0E0F43689
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDg3D-0000mf-Pl; Fri, 17 Apr 2026 06:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2s-0000Wr-J3; Fri, 17 Apr 2026 06:03:31 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1wDg2q-0006gN-TC; Fri, 17 Apr 2026 06:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSPSSiX8gh90j91E9t02jmVnqDSOpednSO7RaR2OwwXar1I1t6+XPHKhBQfaQCDCXzv4uafsKcd0UTc/jYqeBPNDyvFvpiHiNjA5hZwHIExOIgXbXM20hmq0tUDQCQ7d4os+gg5PdkRaHNRmfxiEqyWA7hkJmCoNtzHUWhj2AtGdcY0NntDaWPVJZuFs128HV13ZRkb21bmf6mpo942q749mjgIOrgO9+jP+JRAUdH2UmyAsNgpl50QXEWdrMMVYmNpPnWsvqdyWued63fqcGownOE0Oalr2mHx7ybIuGP+0yBT0RTb1UqM6RLo0I82cMQTl1NIT3QYKf9h51DuYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY1YGwQHj8EamZNz+VldBgGRJe54OJY4CKUosYVdpa4=;
 b=YwPVdMUz+xt2SZDfzsAv2PgOv9SdCZbEu4b2AqcKHPgpZ2jaawX+nQu0S0EAenDiYlRPqieHfiOAb6gPPW1wOJAp5hsDjlh6Li/RaWC98e16EFHTSS6F0kdCD+/I1aDhKyf9nmr54dWuI9UuV97Txltaz0AfXFIBNP9AnfbnzNM61P81W7lQD0rpPP2GpAIK9mhhq9InLgP3uV8y2suX0KYU3Gt5mp8KO5BWgbPN9xUy0x3WZdqFJJTiTNTVjLfB9moYyTsDUNelOl769wo7ikTjGDeFlUq/jxp5MGx1nJxHnQnHCovU3BeBB1CmezBN6tAFAqdcbyjDvutZ1mjn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY1YGwQHj8EamZNz+VldBgGRJe54OJY4CKUosYVdpa4=;
 b=mkQDTUH9os8DTlHfN2ZaIvtcqBTHoIxEaIAIVJeM+ev9bVoGqODtgZO4UjodlGN5R/mdY5rtaVTFKKr4VggYYkS08L8kycSx3EVRyj9WUqfX7aNeISmfXkt8qGzg5c6yD8bDmlyGutSbRx5Zyru5eeXU5YPVVZx/twbJgwWfgCiTr1OC7A7O3TR04q6MI6MkXNCchuNMbP8DqN/pyCMmVoGaWmmAAfnti7ziKMpdf2CQlK9jB56QXNOWd01yGf0szWz9P+EL91+94lyuyEfMwsOoXC+va7R2XHJU86PhKvc9dQ9TMT38XetKTzsKJrV9KV0RaQFGgVtUVVBK1s6DOg==
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com (2603:10a6:102:412::6)
 by AM7PR09MB3736.eurprd09.prod.outlook.com (2603:10a6:20b:10e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 10:03:11 +0000
Received: from PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442]) by PA2PR09MB7634.eurprd09.prod.outlook.com
 ([fe80::c461:b510:b6b9:f442%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 10:03:11 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v7 4/6] hw/riscv: Make boot code endianness-aware at runtime
Thread-Topic: [PATCH v7 4/6] hw/riscv: Make boot code endianness-aware at
 runtime
Thread-Index: AQHczlFmFPIHc5hQSU+ag6N5sRR99A==
Date: Fri, 17 Apr 2026 10:03:11 +0000
Message-ID: <20260417100302.162260-5-djordje.todorovic@htecgroup.com>
References: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260417100302.162260-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA2PR09MB7634:EE_|AM7PR09MB3736:EE_
x-ms-office365-filtering-correlation-id: 0ebc0b02-9d54-41bf-0f13-08de9c6888ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: mW0fWFiXQQSxPx4dUJixPrcrf+67aetCPQP0+za6Qb9km7Le+yrgqt051XalTPksqQNBwLpCwD6/jjYoYFA/P1Sk0wt3nu8yPfPsYRTF7g3Vf5mgiIrjtlU+nwmYoIMVtjYQIu5uUeLdviY1ZHcU2hs7ToHLl8t+12ojQ0kYtCbj1Y/lT/nzn3h05SuW1NrN5qmCXS0RyzUftQvnv5/5y2wPHVcEfvTQ3Bwlbiohu3YA0TK4YTUGmL/cKHmTGGTFFbf6AyT0pJOoGUuH6EOzIlknbw19KJ6SCyqtyYFxt25exOgEWMZuohCQISNhNRHzNnT5QTLdJRxWqFtgU6y/+EbhWVka7ufBsuR2NYiE4RZfkvdViccgOXrHOdk6Uz8T7ufjVOpf80n+mCqUOVtCEH3mu2YhjNoLSMtiSCgoOH0o3dWK9oVE+HToE9gXHMAT53ZM3TAzDoIugBRrHI7sKdvCX2u8Fc3R/KfN+HN3RBFewMJrAXf4IS+mK240RL9NN+a84BdRESAT8jEYMtwBVCm0BgiMyVAWKeN+P82FVQJq3Dz4n0250QFevSNqs+L5hMP+uC1e+Qln1UrrVVKCSXFz2e+rvuCN8W5mge98W4dmySzdclwP3bTglsqil9++7e93JnDvdBCiflQJyWgJFMzRM1U4j7kKPX6jYXjd9ltYjVs6UVKDcGTZRiU8uLwh7HHAoqLEE2Mw4+IFJEJNSLBIiOUF2mZQRZ4TWAsJYklSBoK2e+d/h9VtQ97ytZnN5iUzWgJo6V6DnQinZFRz2xuCzzl/KStNIdpnkQYt2nE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA2PR09MB7634.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Uq9vvdv4CjCPoxkFkhJpSSmQIVSepDoFqjSVGC7yY18FqHOXA8yFtXm1ZV?=
 =?iso-8859-1?Q?FZDFx80Q/oyi2n9nvj5z0W7mNlaesNI1jXuhLmeAWwpQ5SkPNotJjsSrlq?=
 =?iso-8859-1?Q?0lhMog69SGiHwDOshbsIKCNZRWIFhL0nr+uB7WM0MyoQpFTStWn+cIvFet?=
 =?iso-8859-1?Q?DMCWDYOXXMs6G1tx5p7l+ZPAshMuGC3OaJ8K4uIGEzKEpkxtmXvjaoQ+Bz?=
 =?iso-8859-1?Q?mLKpkh/cKMt9PWyIB5yqcF5MJFZABFNHJwITCZVqCbnMxVJnbvOZbB/pEn?=
 =?iso-8859-1?Q?yysNQVjP1DZUu9aJFbBpVXEJb55SyXbheaQSzXFdQPGdIJcXuyU6ozDVQA?=
 =?iso-8859-1?Q?KwSNI+N0gHSZeFayZ4yiRtX7IJQXQT35HdnQGUFAsrwUzd6VoRMIEeP3SX?=
 =?iso-8859-1?Q?6RHrXKZITSPuW976MTCcF+IWUOnrE0OkWYfmjMgRE6VIK1TEBc7XMXXr3a?=
 =?iso-8859-1?Q?pRSwkB5STxogZ8jmb5McYSCxftwEp1v17Zy/QdGsqSESwOR1QtW858g5lZ?=
 =?iso-8859-1?Q?lfDMfFePUON0+g/QcRGZrxo1t1hx/WHR+VTfM6rMK/NUliD5uimT+RRa3A?=
 =?iso-8859-1?Q?rQkRcEUrbT89fV/AqGw6L6yrTKzwCukRAeMyz5pKePEB3fefbuhdL4Qbbq?=
 =?iso-8859-1?Q?1Sx8ZAtoFcAiv/PSRwZYVS2UW/945VJyG4LPILQVnmUh1ixgpGA5fZDd5i?=
 =?iso-8859-1?Q?96fbrEPllavmrHL9sG98kkdaCsDwWkIiKYQYdxmZkcGwVNpvoAxC/qRbtH?=
 =?iso-8859-1?Q?B4Q+l3nYGwhlYzEjvEl+gAHc0Sj9XG1HgeAwMCQZScs13W9dSs4h/udc+Q?=
 =?iso-8859-1?Q?bS1fm5MgzxIsi4jTzU3zeAsi1fEaa0lVWBAdQZ34Ha94pjHEfL4Ta1GG0d?=
 =?iso-8859-1?Q?f1cMMOo/vpF+T+CGb0+bN0FlVsO1ohT+hCmchHepbXsZ4yLhaGQ3iuxc8X?=
 =?iso-8859-1?Q?iJCdbP2cCHFwxdPE/6GQKqMT1QbAhU/fvYc2QXcQfi8jzXPR+5HJDup5Tl?=
 =?iso-8859-1?Q?f6nbqG96W/XGuqGrr9mKQykKHvYgtB+SKj3mnMp5uPL0RLRY6i+Azgs9X7?=
 =?iso-8859-1?Q?m/yOgBPtddkXNutoSU+wzU+mUp1P8P9m9UcgvpB15XBXlZ669OCjiDYc1X?=
 =?iso-8859-1?Q?Vzv9R1weL+1ZU+2yfbOo0+Zx1DdCfXe0z8Fioak9N9uG7SZQiQkCvcx6WE?=
 =?iso-8859-1?Q?ZNnzbwrZucjv1OWgTenn/oCzC9CnvGu0LX3iZz73al0YI/1FQ1XQaMI4GL?=
 =?iso-8859-1?Q?ggHuk5H42nDh0ksyFii7ELGkf1pzUFm2RIqmUHTYjFmFTQCu6RfTPLvzFv?=
 =?iso-8859-1?Q?5PjJZE25D82tiUZ9atdIR+LPWAD83i7nELG3NCRDe7qWpaID+M/ucjbpy0?=
 =?iso-8859-1?Q?tjfqAx1VC6VnJnWIs7BQZNyJoY+Y08WcWybIsCunRvWsd1o2OGMFhYJvQ0?=
 =?iso-8859-1?Q?Znn6BM/05L6NOOQ1Q4XwdHg/uoHzNCR/2jEK0RQleh1dt8N3mfioovXSVc?=
 =?iso-8859-1?Q?s2Dhcxm7jNMCwDEny6tNI5HUeyPRV2K+qEsGg8C9R2gaxuA0zja57ba43c?=
 =?iso-8859-1?Q?JI4RmBic/uv4+ZcO27iHKUX1iXIwOpDBAsQf4RNDpWM8j/BFB8OlXOoCXb?=
 =?iso-8859-1?Q?H+83X1aAiQeBwNdEwMwq/IlYlGr9ZQKhf9EUq2RWns6ReBhIZl9meOiHnB?=
 =?iso-8859-1?Q?CjcBvfx0itWcUv4aQujPDuPp9sekKZJb96G3ahFaj93yCUTwzAr4KgNTFG?=
 =?iso-8859-1?Q?2aZCbKRDLoCcUHrEnclN3rShE9P1yYE/f03iLyIeoHNaKRXXAYTFYNk4j7?=
 =?iso-8859-1?Q?j79TNfgwfDOmVbe/mLOh2yKYoq0Vn85/+qZSzwT1aGHSb/BIgu+T?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA2PR09MB7634.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebc0b02-9d54-41bf-0f13-08de9c6888ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 10:03:11.7186 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AkDeC67HYHeuzIkyvvZtAykeFb1XETFqU4TMlZsIBbc15xDJ9Qm0u9m7AKdVloG3TyCdtjxvMqdX62fjv/It4nejtwh0WA62Ne+6pedoqtc=
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
index e5490beda0..03fb338d2a 100644
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
@@ -247,8 +269,9 @@ void riscv_load_kernel(MachineState *machine,
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
@@ -391,21 +414,32 @@ void riscv_rom_copy_firmware_info(MachineState *machi=
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
@@ -474,10 +508,33 @@ void riscv_setup_rom_reset_vec(MachineState *machine,=
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

