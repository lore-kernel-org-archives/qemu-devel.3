Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60758C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ0v-00028Y-0O; Tue, 15 Jul 2025 02:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0l-0001xz-Gw
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ0j-0006zK-19
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:19:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3551299f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560367; x=1753165167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pNq5oOIokbsGMXuot2xEONo/kkTMB903Abh0CvL50U=;
 b=PE4lBAOJW6A3fbS3ssWB02D6RGKpkVKsWXkhyShjN0fIAMGzTHIm9wHH2lDqFDsASZ
 IVTxC1K9s1QzIN7GDEI2Vpb/j5bxi4XXY1KIxUvjaqSGT9kIIB+OhOIhKEqO6FF3FYai
 33I9dNMPHqVRiy+pjXIQ2Gi/jxiw+G4e36khdSvq7jhwW2kzh3PymmG3S4XwcdMLGZC9
 GtVD6Qah+o7u8mRS2Bw6NpB4HylRaM8Ksz7qwK6BLObRBBaHDhMqCsm8hKURT0lp61zM
 QG7ZpRz0lkIjIQnFPxoJlBgqpw7M6mc/uAondUsTbrPnLRmglrCtbDHFrVxANvG9Ctpa
 N5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560367; x=1753165167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2pNq5oOIokbsGMXuot2xEONo/kkTMB903Abh0CvL50U=;
 b=Zx9dCqpHDfeLukFdohAlQlAXK0CRpCCKk3bkJrkn13Q0JOMOdixiEl1dsw7mHY51cY
 EfVMilNLwM41hwxwKqdh7jfM6brs6LC6yCbNu/vNaGl1WLORkP6b+URvuyVK3HLA4wsh
 RAoO1LrNsJ4Ckc5KrQ0s7ozz5uSXIsqBCtmYndwB7uPtVtKFdvzRq/9N+bloqyD4Jc/D
 yfD5vv2MGc9nqG3uZBsg9tV5FUck3kLj32AH4aYYmtiW0uUIVbR8rMjQ5LTxD7qxANNG
 rH90ROvJD6Iown48UqrTc9ffYTJlK356BC2uG84yqF1hlVwCD1AxVm+vQk1Vklm7Avyy
 M4ag==
X-Gm-Message-State: AOJu0YygSusaT/lqV2sM3pteIkp73xUC3MptFWJ+0GDiSB/bHnGGIns8
 TMPlfFtZm/nO55wpsHYJF4ecoGD4R4W4OJ2LuVaa5Skx1U038xouJdVwujt1Hta0Vb4kQ5kM81a
 uPabn
X-Gm-Gg: ASbGncucdxXud5W2QA7ksa+2MXAs4+Q6LA6X3W5A9VAfUyiwnUS1FraFAvVLiz6sZYu
 Wby7Eety3qH39oNc450M8RGUeokm2GjmnxXIFEVYPVbnqAEEiczn4UPbCFxSkI897elk+nTfSSC
 Fdi8vjWKWTrd6mE5lOdI2rglqRUkIy8sH0C1h79J0IzQSB3wD3wi0Kd3SxGTYhEmz4018PywOfO
 4cO+Y6JXQnHK4m2iG4tpZdA/OWBurJqBBrC2aH5mjQChwXTcY3KdX57c9bYaAZCYiF2ARNFqVG6
 5Akm+IcPe8axQ31N0+1Xttb65qiXpgMo12UsYUmZSYjfcguV18QloRQw0/QuKEeOlmqCBrtjvDD
 oZeyKv2F1bEQDFtpxg+lSA7t2aj1naiDu3EV5Yn5SzAJxM2zpKXkedF6K9ESAPtukMruMbPWm
X-Google-Smtp-Source: AGHT+IFsbWuYSsedIzBCoffsoHKmCZnm42WbZw/1pbC/XN0V01soZCDtm/VdiVHUfXZtvfvfX/Et0w==
X-Received: by 2002:a05:6000:70f:b0:3a3:7117:1bba with SMTP id
 ffacd0b85a97d-3b6095339d4mr1782973f8f.24.1752560366730; 
 Mon, 14 Jul 2025 23:19:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1924sm14475399f8f.16.2025.07.14.23.19.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:19:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@mips.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 01/17] target/mips: Add support for emulation of CRC32
 instructions
Date: Tue, 15 Jul 2025 08:19:01 +0200
Message-ID: <20250715061918.44971-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
Reuse zlib crc32() and Linux crc32c().

Corresponding disassembly has been added in commit 99029be1c28
("target/mips: Add implementation of GINVT instruction").

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <PA4PR09MB486489692D843DDFC25F3CF1846B2@PA4PR09MB4864.eurprd09.prod.outlook.com>
---
 target/mips/helper.h             |  2 ++
 target/mips/tcg/translate.h      |  2 ++
 target/mips/tcg/rel6.decode      |  5 +++++
 target/mips/tcg/op_helper.c      | 26 ++++++++++++++++++++++++++
 target/mips/tcg/rel6_translate.c | 12 ++++++++++++
 target/mips/tcg/translate.c      | 24 ++++++++++++++++++++++++
 target/mips/cpu-defs.c.inc       | 10 ++++++----
 target/mips/meson.build          |  1 +
 8 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 7e400418281..b6cd53c8538 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -21,6 +21,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
 
+DEF_HELPER_3(crc32, tl, tl, tl, i32)
+DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* microMIPS functions */
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d1838..428b53a0dac 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -51,6 +51,7 @@ typedef struct DisasContext {
     bool abs2008;
     bool mi;
     int gi;
+    bool crcp;
 } DisasContext;
 
 #define DISAS_STOP       DISAS_TARGET_0
@@ -181,6 +182,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
 
 void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel);
+void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz, int crc32c);
 
 extern TCGv cpu_gpr[32], cpu_PC;
 #if defined(TARGET_MIPS64)
diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
index d6989cf56e8..7fbcb109b4e 100644
--- a/target/mips/tcg/rel6.decode
+++ b/target/mips/tcg/rel6.decode
@@ -16,11 +16,16 @@
 
 &r                  rs rt rd sa
 
+&special3_crc       rs rt c sz
+
 @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+@crc32              ...... rs:5 rt:5 ..... c:3 sz:2 ......  &special3_crc
 
 LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
 DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
 
+CRC32               011111 ..... ..... 00000 ... .. 001111  @crc32
+
 REMOVED             010011 ----- ----- ----- ----- ------   # COP1X (COP3)
 
 REMOVED             011100 ----- ----- ----- ----- ------   # SPECIAL2
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index b906d10204b..4502ae2b5be 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -24,6 +24,8 @@
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
 #include "fpu_helper.h"
+#include "qemu/crc32c.h"
+#include <zlib.h>
 
 static inline target_ulong bitswap(target_ulong v)
 {
@@ -142,6 +144,30 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shift, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
 
+/* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
+target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask = ((sz * 8) == 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &= mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
+}
+
+target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask = ((sz * 8) == 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+    m &= mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
+}
+
 void helper_fork(target_ulong arg1, target_ulong arg2)
 {
     /*
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_translate.c
index 59f237ba3ba..89335063977 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -33,3 +33,15 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     }
     return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
+
+static bool trans_CRC32(DisasContext *ctx, arg_special3_crc *a)
+{
+    if (unlikely(!ctx->crcp)
+        || unlikely((a->sz == 3) && (!(ctx->hflags & MIPS_HFLAG_64)))
+        || unlikely((a->c >= 2))) {
+        gen_reserved_instruction(ctx);
+        return true;
+    }
+    gen_crc32(ctx, a->rt, a->rs, a->rt, a->sz, a->c);
+    return true;
+}
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 8658315f938..5c80b030329 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13449,6 +13449,29 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     }
 }
 
+void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
+               int crc32c)
+{
+    TCGv t0;
+    TCGv t1;
+    TCGv_i32 tsz = tcg_constant_i32(1 << sz);
+    if (rd == 0) {
+        /* Treat as NOP. */
+        return;
+    }
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+
+    gen_load_gpr(t0, rt);
+    gen_load_gpr(t1, rs);
+
+    if (crc32c) {
+        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
+    } else {
+        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
+    }
+}
+
 static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -15095,6 +15118,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->abs2008 = (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi = (env->CP0_Config5 >> CP0C5_MI) & 1;
     ctx->gi = (env->CP0_Config5 >> CP0C5_GI) & 3;
+    ctx->crcp = (env->CP0_Config5 >> CP0C5_CRCP) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx = MIPS_HFLAG_UM;
diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 922fc39138d..d93b9d341ac 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -756,8 +756,9 @@ const mips_def_t mips_defs[] =
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XNP) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MRP) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
@@ -796,8 +797,9 @@ const mips_def_t mips_defs[] =
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
         .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
+        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XNP) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MRP) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask = 0,
diff --git a/target/mips/meson.build b/target/mips/meson.build
index 247979a2cfc..abf0ce3e8b9 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -7,6 +7,7 @@ mips_ss.add(files(
   'gdbstub.c',
   'msa.c',
 ))
+mips_ss.add(zlib)
 
 if have_system
   subdir('system')
-- 
2.49.0


