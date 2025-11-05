Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC049CCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 21:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGl13-0002RD-KE; Wed, 05 Nov 2025 16:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGl11-0002Pw-NT
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:26:03 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vGl0z-0002DH-Ua
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 16:26:03 -0500
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-94868b991easo12450539f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 13:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762377960; x=1762982760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/z+TNYYhCgAI/BfGtM/5w/zFoSuf4sdupwu/B7KwfM=;
 b=AUCCUdHaMsFJStrPJ1GVnvCOvV1dMsPbySnowqEeSyvVH292H3us2fVd/TT3B7tBVj
 zl75kl8tAxs8IkkUmNnHi0HqzN7vEvn3e/ybkT29trp6HEgAprDOsYzMM98kbUvmzjYM
 SVRKPint2Dnf6/hwYDWOSCWkTDQ0C0oq5/IBW03vUWlR2i/7nA9QGu7+AOoXMe6EFOrP
 1b4HmdOS24uBKAYUWbR2mcGjkBmVHl0yjXh1rTnQCzRtm7GBXHPK5hU2xjdVbFetGYCI
 2PyvqGjqFAKolAPAv54QtizXWqayXn07mtcNRvfosgjRLugL8lanliDWpCbZd3ggJTCM
 wq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762377960; x=1762982760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/z+TNYYhCgAI/BfGtM/5w/zFoSuf4sdupwu/B7KwfM=;
 b=jpm8LhKegcK+kms2fyqKstnBUQTN7ubTUEBvtuDkbE3JanNHGQORwZVs3q2Y+kNTdg
 6TUX7E1J3d29ypIZSYMgL3NEvTKZG4D69zJuXHlELsKDEPbB1t4nLa6MtfbJ0usXJyU4
 jK9i89wGewffC1i27GO3MKkjEl0Ep2TCiVQ/xFvEAOMz3lf94A6R8ZmxYzWVRTwj3+ug
 2bPM3H8cwwB9E5W0nk4ILoiJ4Meymk/FotvrEs5LJ8qpT/XLclvuVM5FUlUfbUAMgz3d
 Hm9kvWihCsS7ddSmpMjBI8GPxE+IUfClB6t43MsN0/1pKX41FW2hX7miFw9TX8Hsgrg8
 xVLQ==
X-Gm-Message-State: AOJu0YxusAS4NPDn6jAmc+slEbnn6EiPu80nXrTI/JFXaWsOiTKmh6u0
 yG+hQdvqnun+8nqqPEUpq3FtEWOtIAe5yEElb5CWLx/JNCG5JJFmzcoT0KPIau5Mf6I=
X-Gm-Gg: ASbGncsl1TVsGt0ZiTLH6GY/zqaE1eCjxGLJ8tB500RC8rm39bW3UZgtX8j449zDza+
 SzfKneszsDfiUXY3j604sEr5pf7M4LDIijpSnlc5bh12wCqclCAcnliIKF7iE0+3H4pw4eGkDQv
 rOW7MUOTeGaG1xMZ+UaN+zsaRPq269ITKBibJ4LH1C5Z4Hx8fVAIoaqlMEK3MZnXDTN0S9d6pzJ
 21QZkRExtiepgcQMgKdbyRjWurB1aqKl28naTAl8q9BUixf6v8v0u6tIvsKLPGIJBMwrk8z2OEJ
 bqTtL7HFVAEcfO1fWRT1Ss5ujTcTL17nbXg74QGeiKJVKoXRgTTT1VMhqqb74Gob3yV3oSVU5rg
 YwcefMKwxK5W61T8ien3aVb9Jdttn/OLAlFqbf5g2+7WxsrsESHr1fdyTPdU3bAC7q+fX+E1G2S
 9qk/hvgVGxibPe/wg8qn1pWeXIXHV0qdsjC84LIluM1iDNeVS/zz2thJTYteoQLSxgeA==
X-Google-Smtp-Source: AGHT+IEHFd/0/FtiPFmTJmda58ZN7FaagZN7Qv5pKeF0pi6sKCErkgY96ZByFDg7AIIg1xYw54aEmw==
X-Received: by 2002:a05:6e02:2141:b0:433:31a0:4e6d with SMTP id
 e9e14a558f8ab-433407af6c9mr71164675ab.10.1762377960087; 
 Wed, 05 Nov 2025 13:26:00 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-5b7467d5a0asm127785173.2.2025.11.05.13.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Nov 2025 13:25:59 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 2/3] Hexagon (target/hexagon) Implicit writes to USR don't
 force packet commit
Date: Wed,  5 Nov 2025 14:25:53 -0700
Message-ID: <20251105212554.127017-3-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
References: <20251105212554.127017-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-io1-xd29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Implicit writes to USR are only to specific fields of USR to indicate
side effects (e.g., saturation overflow, floating point status).
In these cases, we don't force a packet commit. This will allow more
packets to be short-circuited (avoid writing the results to temporaries).

When there is a packet commit with an implicit write to USR, we initialize
new_value_usr during gen_start_packet and write to USR in gen_reg_writes.

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.h |  1 +
 target/hexagon/translate.c | 35 ++++++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
index d251e2233f..a0102b6cbd 100644
--- a/target/hexagon/translate.h
+++ b/target/hexagon/translate.h
@@ -39,6 +39,7 @@ typedef struct DisasContext {
     int reg_log_idx;
     DECLARE_BITMAP(regs_written, TOTAL_PER_THREAD_REGS);
     DECLARE_BITMAP(predicated_regs, TOTAL_PER_THREAD_REGS);
+    bool implicit_usr_write;
     int preg_log[PRED_WRITES_MAX];
     int preg_log_idx;
     DECLARE_BITMAP(pregs_written, NUM_PREGS);
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 8fce219c0d..f3240953b5 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -272,12 +272,7 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
 {
     uint16_t opcode = ctx->insn->opcode;
     if (GET_ATTRIB(opcode, attrib)) {
-        /*
-         * USR is used to set overflow and FP exceptions,
-         * so treat it as conditional
-         */
-        bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC) ||
-                             rnum == HEX_REG_USR;
+        bool is_predicated = GET_ATTRIB(opcode, A_CONDEXEC);
 
         /* LC0/LC1 is conditionally written by endloop instructions */
         if ((rnum == HEX_REG_LC0 || rnum == HEX_REG_LC1) &&
@@ -291,6 +286,14 @@ static void mark_implicit_reg_write(DisasContext *ctx, int attrib, int rnum)
     }
 }
 
+static void mark_implicit_usr_write(DisasContext *ctx, int attrib)
+{
+    uint16_t opcode = ctx->insn->opcode;
+    if (GET_ATTRIB(opcode, attrib)) {
+        ctx->implicit_usr_write = true;
+    }
+}
+
 static void mark_implicit_reg_writes(DisasContext *ctx)
 {
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_FP,  HEX_REG_FP);
@@ -300,8 +303,9 @@ static void mark_implicit_reg_writes(DisasContext *ctx)
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_SA0, HEX_REG_SA0);
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_LC1, HEX_REG_LC1);
     mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_SA1, HEX_REG_SA1);
-    mark_implicit_reg_write(ctx, A_IMPLICIT_WRITES_USR, HEX_REG_USR);
-    mark_implicit_reg_write(ctx, A_FPOP, HEX_REG_USR);
+
+    mark_implicit_usr_write(ctx, A_IMPLICIT_WRITES_USR);
+    mark_implicit_usr_write(ctx, A_FPOP);
 }
 
 static void mark_implicit_pred_write(DisasContext *ctx, int attrib, int pnum)
@@ -351,11 +355,6 @@ static bool need_commit(DisasContext *ctx)
         }
     }
 
-    /* Floating point instructions are hard-coded to use new_value */
-    if (check_for_attrib(pkt, A_FPOP)) {
-        return true;
-    }
-
     if (ctx->read_after_write || ctx->has_hvx_overlap) {
         return true;
     }
@@ -467,6 +466,12 @@ static void gen_start_packet(DisasContext *ctx)
         }
     }
 
+    /* Preload usr to new_value_usr */
+    if (ctx->need_commit && ctx->implicit_usr_write &&
+        !test_bit(HEX_REG_USR, ctx->regs_written)) {
+        tcg_gen_mov_tl(hex_new_value_usr, hex_gpr[HEX_REG_USR]);
+    }
+
     /*
      * Preload the predicated pred registers into ctx->new_pred_value[pred_num]
      * Only endloop instructions conditionally write to pred registers
@@ -587,6 +592,10 @@ static void gen_reg_writes(DisasContext *ctx)
             ctx->is_tight_loop = false;
         }
     }
+
+    if (ctx->implicit_usr_write && !test_bit(HEX_REG_USR, ctx->regs_written)) {
+        tcg_gen_mov_tl(hex_gpr[HEX_REG_USR], hex_new_value_usr);
+    }
 }
 
 static void gen_pred_writes(DisasContext *ctx)
-- 
2.43.0


