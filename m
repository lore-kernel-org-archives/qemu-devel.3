Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BB7D3B98F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 14:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFw92-00056t-KH; Tue, 26 Nov 2024 09:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8f-0004VW-EG
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:02:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFw8d-0005Sv-HZ
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 09:02:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314c4cb752so51592115e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629718; x=1733234518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZmg9SSUqn3wbgNzVxeGD6yfR8lfnz4sEk/idUsaPpE=;
 b=a9DGS45LqeFnIcFVThE/qF54yt9pEPfBg+96JgtTtup5TzwRLNjPxGn0T5lqs692R3
 xweDaCdy8UFwy/QTxRpx25Lv6Xm/9OH2eiptKyUPsdSpiUrbihw1yDBvFvw8CcYZPgvN
 /9JhbF1+h2RK+fg7u9wt164WnaqOWcTW4+8czj/uIA332V/qIdge7JKo6LyLqkEdBK3o
 9pdEAQobKYQBjBot7tpToefM9H+8xMYp2r9eriLBxtpLJvMCQAMoBJvoKjHbV4xbPIsR
 BLZXRntofDWnDiK2BSJeCJ0o3Q+a5R93ixCm5sQQgd9oBc4eYGg/LNWfWBI6bFn9Kov4
 xdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629718; x=1733234518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZmg9SSUqn3wbgNzVxeGD6yfR8lfnz4sEk/idUsaPpE=;
 b=DlH8pOFKwfC3QhXKoUDk6zZQ0JX4PTJWZhyFeohUQW8TZFo6UVB9AAQnwqMXi3iCPD
 OkAnMYtY/8sHREAHEiEEdsPC/1i1H6z7BgAsNLR0sK6REk88KBTdKu8JVKFLw2MQX7y7
 kr4RuyBTlNmvL0HBrJRgIt6OnJP6FrFGviR/gp6DWDBDqciagaY4rKHaE754tvizLZM6
 uDG1KLuFzQudbeJljjr+rClElDwrf7IcCYpANP58GUjJlAwfKQdoqpFwyJlNV+zJ+GAl
 e9RA8d0kj1tY/feIU3No2AveVtWJehaSrP5uLbvBg7XaBGp3w4Fu3Km81oH5+WFr8mJi
 8qXw==
X-Gm-Message-State: AOJu0YwgWwzSqjdKfJM4xsZyjXAcoOfU63C1qgTyUaQ2w/rmRwvopNYM
 HtgsFfWw3zOq4DQw9kt/bcrGTgUxHM+18k7okUTtE6BhRGpKZFbczLujlmeelCwPsV21YkWRr3o
 a
X-Gm-Gg: ASbGnctXFyIDzwxrEm4QY/ugQOU7grKfLXQ8hR7JbBB+9K4SCgdzxjtk50/JZoSgL7V
 VlBTMSWTxa1icEpJmSaM/KUXxllgIzLcCtS0JRKx4yhOokIGDfssHznfGjneqGnah+5pVtAkIp0
 lR+AuTWOcmHiDMWIqrueQI/GZpOEXpfk4QF5ELDw+lf98fatgZmuW0FqfD27IcT3RX557ZqyAGF
 2NoCubBkKhImE1mV9xxDwGvjhcyeQ3Bbgjr5P7+Yg6fH5xsvHGCWXVk4Xug1bH4VRL7/N9I
X-Google-Smtp-Source: AGHT+IFt7klQSqx4waeWCLInBxUQrAZ6ibuWpq8od+WhP7tPY0O/ted7r6zeXcresii6h7RjbdTJ5A==
X-Received: by 2002:a05:600c:5643:b0:430:5887:c238 with SMTP id
 5b1f17b1804b1-434872f5942mr136434485e9.11.1732629716784; 
 Tue, 26 Nov 2024 06:01:56 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e1046sm234743975e9.4.2024.11.26.06.01.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 06:01:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 16/16] target/mips: Convert nanoMIPS LI opcodes to
 decodetree
Date: Tue, 26 Nov 2024 15:00:02 +0100
Message-ID: <20241126140003.74871-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126140003.74871-1-philmd@linaro.org>
References: <20241126140003.74871-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/nanomips16.decode        |  8 ++++++++
 target/mips/tcg/nanomips48.decode        |  8 ++++++++
 target/mips/tcg/nanomips_translate.c     | 21 +++++++++++++++++++++
 target/mips/tcg/nanomips_translate.c.inc | 17 -----------------
 4 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/target/mips/tcg/nanomips16.decode b/target/mips/tcg/nanomips16.decode
index 81fdc68e98b..12815161d9c 100644
--- a/target/mips/tcg/nanomips16.decode
+++ b/target/mips/tcg/nanomips16.decode
@@ -6,3 +6,11 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&rd_imm             rd imm not_in_nms
+
+%s_eu               0:s7 !function=s_eu
+
+@rt3_s          ...... rd:3 .......         &rd_imm         imm=%s_eu
+
+LI              110100 ... .......          @rt3_s          not_in_nms=0        # LI[16]
diff --git a/target/mips/tcg/nanomips48.decode b/target/mips/tcg/nanomips48.decode
index 696cc15607a..778bff4ec06 100644
--- a/target/mips/tcg/nanomips48.decode
+++ b/target/mips/tcg/nanomips48.decode
@@ -6,3 +6,11 @@
 #
 # Reference: nanoMIPS32 Instruction Set Technical Reference Manual
 #            (Document Number: MD01247)
+
+&rd_imm     rd  imm not_in_nms                                       !extern
+
+%imm        16:16 0:s16
+
+@rd_imm     ...... rd:5  ..... ................ ................    &rd_imm imm=%imm
+
+LI          011000 ..... 00000 ................ ................    @rd_imm not_in_nms=1
diff --git a/target/mips/tcg/nanomips_translate.c b/target/mips/tcg/nanomips_translate.c
index 3e77fcd23d3..aee0606e4d4 100644
--- a/target/mips/tcg/nanomips_translate.c
+++ b/target/mips/tcg/nanomips_translate.c
@@ -9,14 +9,35 @@
 #include "qemu/osdep.h"
 #include "translate.h"
 
+static inline int s_eu(DisasContext *ctx, int x)
+{
+    return x == 0x7f ? -1 : x;
+}
+
 /* Include the auto-generated decoders.  */
 #include "decode-nanomips16.c.inc"
 #include "decode-nanomips32.c.inc"
 #include "decode-nanomips48.c.inc"
 
+static inline void check_nms(DisasContext *ctx, bool not_in_nms)
+{
+    if (not_in_nms && unlikely(ctx->CP0_Config5 & (1 << CP0C5_NMS))) {
+        gen_reserved_instruction(ctx);
+    }
+}
+
 static bool trans_LSA(DisasContext *ctx, arg_r *a)
 {
     gen_lsa(ctx, a->rd, a->rt, a->rs, a->sa);
 
     return true;
 }
+
+static bool trans_LI(DisasContext *ctx, arg_rd_imm *a)
+{
+    check_nms(ctx, a->not_in_nms);
+
+    gen_li(ctx, a->rd, a->imm);
+
+    return true;
+}
diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 0627f01c19e..e3d81d9e15b 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -57,7 +57,6 @@ enum {
 
     NM_POOL32S      = 0x30,
     NM_P_BRI        = 0x32,
-    NM_LI16         = 0x34,
     NM_SWGP16       = 0x35,
     NM_P16_BR       = 0x36,
 
@@ -86,7 +85,6 @@ enum {
 
 /* P48I instruction pool */
 enum {
-    NM_LI48        = 0x00,
     NM_ADDIU48     = 0x01,
     NM_ADDIUGP48   = 0x02,
     NM_ADDIUPC48   = 0x03,
@@ -3664,12 +3662,6 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
             insn = translator_lduw(env, &ctx->base, ctx->base.pc_next + 4);
             target_long addr_off = extract32(ctx->opcode, 0, 16) | insn << 16;
             switch (extract32(ctx->opcode, 16, 5)) {
-            case NM_LI48:
-                check_nms(ctx);
-                if (rt != 0) {
-                    tcg_gen_movi_tl(cpu_gpr[rt], addr_off);
-                }
-                break;
             case NM_ADDIU48:
                 check_nms(ctx);
                 if (rt != 0) {
@@ -4620,15 +4612,6 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
             break;
         }
         break;
-    case NM_LI16:
-        {
-            imm = extract32(ctx->opcode, 0, 7);
-            imm = (imm == 0x7f ? -1 : imm);
-            if (rt != 0) {
-                tcg_gen_movi_tl(cpu_gpr[rt], imm);
-            }
-        }
-        break;
     case NM_ANDI16:
         {
             uint32_t u = extract32(ctx->opcode, 0, 4);
-- 
2.45.2


