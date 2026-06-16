Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E9ECD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQiV-0005Ko-Cc; Tue, 16 Jun 2026 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiT-0005DU-Gv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:21 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQiR-0003bz-Hp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:21 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36b9ec98144so3481243a91.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604498; x=1782209298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXqYnOvY3KwDuh3m0AauGU52HI7RWvVWxcP3+lQQkR0=;
 b=BEj4z/jF2/C88DBZ/aDk1CGYpFZK5ogBDajDE0U+ayZglcjS4t5ZcJiXBJN03pwvg+
 I89OSFfqPrK6ICkVNcVErjPOYOBVN/UWm3Uo3Px+XJ53DJ3zHDbchUevhUxXIuJK3H6H
 JiJO7mXwWJM6KE3BHfdyQXcnKRFOdDtRtvHGBb1i7obxRpawD9zRDaL5XL+l+lm8qwO6
 wZ1eg0ANXaW8XTAU+asL1yKeg2oVmZ7JyHC4fX/tU1zi1qTUgEmKnPNMeL0NaYnp0f7l
 sOhIxB9w5PGmw+J2AfpV9ohhjYSuH2TJT0cPYinGPuGJNH2g9CGkl+Iy8Xd1iAWupI+W
 WLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604498; x=1782209298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EXqYnOvY3KwDuh3m0AauGU52HI7RWvVWxcP3+lQQkR0=;
 b=lZ+F5UE/TwA2XTFFTSm02Hxy9l2vZhIH4vnNgO/u8Tx4huwzU0SrHR3nIUQ+gGsQuq
 ILw5A/2flPXPgTnFDV1qRhT3A0ZyvSv2YZXuQ2z2PzUpcqU49mw80X+lqJCWfBJ/D5iJ
 FK1izcwvakakt/UYzSGE5l5gAS/00u+8F0wwKAzLfD5Mo27hRqZu6JiA9tqBSwIaapS/
 vyadiWJH7FBhwNx0+h0YfrHI7lkbSJH0JEhKWljrbcuxTnmhaX74xhDQ/VUky4UmdhgJ
 dgyWcsYWTaiftt2C5trolR+D30/m8ORoyWdRKIcrZcijdQAIwaVlriAYWw+thBkVxeZK
 pYlg==
X-Gm-Message-State: AOJu0YzM3IH6eawISs1lwfaKG5WD8Um2Cl++S5zoLyc6Ge1g+HEIVHIx
 F4XpVikqiNEsR1DaMQSdLkpWtk7uePI1WXqKLI2Rxl7yPhyUMbqlj4HpBsn8Egp3
X-Gm-Gg: Acq92OHdmly52xt2aeK5Lhn2lxrKgCsBGTgLgfgEzu9DYN8CmM/Y1K3uFJ6IG4+n0gE
 QVwXtFCCDcgLKjt5OvvQl4ql4cZIysBuae9IM/cFe+hqrKi2dFUQxhTcGsrjYPl5sJKk6cQPqrA
 gl6nq8vVzHCsBysSJE5fVNRSlcZw4Q5YPDieE7g6mxyqNPbxpkaK2ecX1wzSBgHYXRNpu5Wu326
 PA6U5VoKfEm7CPJcbay0sLPYmCk2j/iKnZ9WYEdTkWPRTs3gRlqI4+2yw/lNjrnCqgA/NQtCLn0
 3Bytv/ORpnowHXplMg+Zv6CgjcrABbtHKyoyICHxNB34gQymj/bENQ3UTNn5wERQzJDdA9ILzbj
 sIf40Ro3U/22On542Pnqupkk2bc6+4mDtt0whwY/rK4nV2k2PqMYqCLJFXo4wsehC/7Wpa7RYg2
 XUYCmgwbeQsaIZFz7qeHB2BDNsZExZGsEFHqmQhCSmQ/sAabg8rkw=
X-Received: by 2002:a17:90b:5890:b0:37c:5453:8c3d with SMTP id
 98e67ed59e1d1-37c54538cd3mr2564394a91.3.1781604498245; 
 Tue, 16 Jun 2026 03:08:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 47/83] hw/riscv/boot: Rewrite setup_rom_reset_vec() using
 load/store API
Date: Tue, 16 Jun 2026 20:04:50 +1000
Message-ID: <20260616100527.1939565-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to make the following commits easier to review, do
not pre-initialize the reset_vec[] array, fill each word one
by one. Set the start and FDT load addresses using the load/
store APIs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260527201348.29511-8-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c | 55 ++++++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ae2f86c7ce..c6ab1cc8cf 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
@@ -444,6 +445,9 @@ void riscv_rom_copy_firmware_info(MachineState *machine,
                            &address_space_memory);
 }
 
+#define CODE_WORDS 6
+#define DATA_WORDS 4
+
 void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts,
                                hwaddr start_addr,
                                hwaddr rom_base, hwaddr rom_size,
@@ -451,43 +455,34 @@ void riscv_setup_rom_reset_vec(MachineState *machine, RISCVHartArrayState *harts
                                uint64_t fdt_load_addr)
 {
     int i;
-    uint32_t start_addr_hi32 = 0x00000000;
-    uint32_t fdt_load_addr_hi32 = 0x00000000;
-
-    if (!riscv_is_32bit(harts)) {
-        start_addr_hi32 = start_addr >> 32;
-        fdt_load_addr_hi32 = fdt_load_addr >> 32;
-    }
-    /* reset vector */
-    uint32_t reset_vec[10] = {
-        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
-        0x02828613,                  /*     addi   a2, t0, %pcrel_lo(1b) */
-        0xf1402573,                  /*     csrr   a0, mhartid  */
-        0,
-        0,
-        0x00028067,                  /*     jr     t0 */
-        start_addr,                  /* start: .dword */
-        start_addr_hi32,
-        fdt_load_addr,               /* fdt_laddr: .dword */
-        fdt_load_addr_hi32,
-                                     /* fw_dyn: */
-    };
-    if (riscv_is_32bit(harts)) {
-        reset_vec[3] = 0x0202a583;   /*     lw     a1, 32(t0) */
-        reset_vec[4] = 0x0182a283;   /*     lw     t0, 24(t0) */
+    const bool rv32 = riscv_is_32bit(harts);
+    uint32_t reset_vec[CODE_WORDS + DATA_WORDS];
+
+    /* .text */
+    reset_vec[0] = 0x00000297;                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
+    reset_vec[1] = 0x02828613;                  /*     addi   a2, t0, %pcrel_lo(1b) */
+    if (harts->harts[0].cfg.ext_zicsr) {
+        reset_vec[2] = 0xf1402573;              /*     csrr   a0, mhartid  */
     } else {
-        reset_vec[3] = 0x0202b583;   /*     ld     a1, 32(t0) */
-        reset_vec[4] = 0x0182b283;   /*     ld     t0, 24(t0) */
-    }
-
-    if (!harts->harts[0].cfg.ext_zicsr) {
         /*
          * The Zicsr extension has been disabled, so let's ensure we don't
          * run the CSR instruction. Let's fill the address with a non
          * compressed nop.
          */
-        reset_vec[2] = 0x00000013;   /*     addi   x0, x0, 0 */
+        reset_vec[2] = 0x00000013;              /*     addi   x0, x0, 0 */
+    }
+    if (rv32) {
+        reset_vec[3] = 0x0202a583;              /*     lw     a1, 32(t0) */
+        reset_vec[4] = 0x0182a283;              /*     lw     t0, 24(t0) */
+    } else {
+        reset_vec[3] = 0x0202b583;              /*     ld     a1, 32(t0) */
+        reset_vec[4] = 0x0182b283;              /*     ld     t0, 24(t0) */
     }
+    reset_vec[5] = 0x00028067;                  /*     jr     t0 */
+
+    /* .data */
+    stq_p(&reset_vec[6], start_addr);           /* start:       .dword */
+    stq_p(&reset_vec[8], fdt_load_addr);        /* fdt_laddr:   .dword */
 
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
-- 
2.54.0


