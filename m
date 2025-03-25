Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E297AC36002
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 02:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twton-0006Qw-L0; Mon, 24 Mar 2025 22:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twtol-0006Pl-QR
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 22:15:03 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1twtoj-00031m-Dc
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 22:15:03 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c547932d2eso302243885a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 19:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742868899; x=1743473699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5s+eGcqGLEWy93+5hxt8OJGj9bNIEtCixDsFUdPg4DM=;
 b=jgvqCf2Df+Fit27CdulP+Q2N8fcQakNnk8cpoze3Hwoak2b4owC1as43/ew71NuPCa
 xgPbtgCQR42v203iuZbiKyHDxEpUdWWJsWPk2osc5bW4KNJy0IvPDHm/CyhTwba2oIzB
 UEBQ3Ku2UlnFKhzb+EBmByaioOnCVisUYxP0xwlW7Uro+NUdP2PxPqUBKejL2xTmyklz
 A0DwJhYkTk3XgquKyu+s1y11REyxQNFeQobe8aLy957JN7mDlc5HSLtVqeLgLYvyYsyl
 tU8MK+K01lZ73pMMHkdFqIaOwMDbi/1Wwo4dCh/A0VDc1+vq0u/UARMVkmoLi+bf90I0
 nWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742868899; x=1743473699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5s+eGcqGLEWy93+5hxt8OJGj9bNIEtCixDsFUdPg4DM=;
 b=LO/e5dpeFrz6nEy4Zx/ljXfHhFL3hbX+DwcsuiwjfmQWB3QQ5A+OSGZlTMMRUQfkSt
 FWhYH3dYQ2s7JpcsmFPg528B5KK+gAVxoiNIkHsTgdPd7qqBtI/s6t9uV6+eifLQ3fmv
 Jm60rLM/GvRnwq2KMHkhgyYY6VTSqfW8JoFA2PfSpws9mEZskwZ5CgmIyOYXIwjqm0vF
 vyxkt2unXSKBc3DhKmn1Mz5cKfRoXoBam8KpYKiytEMaSZoR5U2EPXQDzAJDR9y6DCMy
 06Iq0hRu3d78wgi80Hub7i+0I8pQ5xBlFPmpd1Jn8FuOcr0OhxUDcuG3IFAk0JQ1kafm
 sMVA==
X-Gm-Message-State: AOJu0Ywp5m0XsTRuGPtzJxeZ4ViByhgn8bv5V1RpaEXYg50RJJY4tjAF
 t5UKZ2BAm6mv9NmhbXecWyJ+1zbvtHb9fA3dOX2xesD+JXHTcyVIp2S//l82
X-Gm-Gg: ASbGnctDoBWAaAzQGkFMGeASMX2rTk6GPhobjvSirYWpN71THt/CEZPkoi6F5b08+XE
 r6Uu2RFqcWJ0XhOLSNrGzpeEN+yjSVFWE+tJ9sDX97EYCSA5ZUwiJ7m5vPpQOLML/Qwku0++PTe
 vPDFHW9ZFUlJMSxWfQvl0xbMrNmZ26HKqGUnbH/0gWVp6GCWtYipvzWkbDmTqL8yegm+tIZJ1Tf
 6zh4OEUCdo/Ee7beN6Nf6lB1WNRBIQ8fi0u0LAszs36dM7gqYmYe0yHx0jfUwsxkELYW1fpMKCp
 Ywb0hChXuAxcOS27FCjAR0oTzMFyN3oX4HX8t7pLl1BPubjqi8ts1z9xZd03mt/NtTvKvmKAK+v
 6e/o03sh6USZTfw1sfNpTrBMkHkn0jCLLEhlq
X-Google-Smtp-Source: AGHT+IGxCXQLdc/qqt5DZNIocK5Dp+zflPlnWHcVpZnu76xSyvMOfywc69L8/F0tVzHsCC7oZRz65w==
X-Received: by 2002:a05:620a:40c2:b0:7c5:6ef2:2767 with SMTP id
 af79cd13be357-7c5ba133ebemr1946478485a.2.1742868898640; 
 Mon, 24 Mar 2025 19:14:58 -0700 (PDT)
Received: from taylor-ubuntu.lan (syn-174-097-131-055.res.spectrum.com.
 [174.97.131.55]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92d0069sm585518285a.26.2025.03.24.19.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:14:58 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: bcain@quicinc.com, quic_mathbern@quicinc.com, sidneym@quicinc.com,
 Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [RFC PATCH] Hexagon (target/hexagon) analyze all reads before writes
Date: Mon, 24 Mar 2025 20:14:40 -0600
Message-ID: <20250325021440.81386-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qk1-x72e.google.com
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

I noticed that analyze_packet is marking the implicit pred reads after
marking all the writes.  However, the semantics of the instrucion and
packet are to do all the reads, then do the operation, then do all the
writes.

Here is the old code
static void analyze_packet(DisasContext *ctx)
{
    Packet *pkt = ctx->pkt;
    ctx->read_after_write = false;
    ctx->has_hvx_overlap = false;
    for (int i = 0; i < pkt->num_insns; i++) {
        Insn *insn = &pkt->insn[i];
        ctx->insn = insn;
        if (opcode_analyze[insn->opcode]) {
            opcode_analyze[insn->opcode](ctx);
        }
        mark_implicit_reg_writes(ctx);
        mark_implicit_pred_writes(ctx);
        mark_implicit_pred_reads(ctx);
    }

    ctx->need_commit = need_commit(ctx);
}

Recall that opcode_analyze[insn->opcode](ctx) will mark all the
explicit reads then all the explicit writes.

To properly handle the semantics, we'll create two new functions
    mark_implicit_reads
    mark_implicit_writes
Then we change gen_analyze_funcs.py to add a call to the former
after all the explicit reads and a call to the latter after all
the explicit_writes.

The reason this is an RFC patch is I can't find any instructions
where this distinction makes a difference in ctx->need_commit which
determines if the packet commit can be short-circuited.  However, this
could change in the future if the architecture introduces an
instruction with an implicit read of a register that is also written
(either implicit or explicit).  Then, anlayze_packet would detect
a read-after-write, and the packet would not short-circuit.  The
execution would be correct, but the performance would not be optimal.

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.c          | 18 +++++++++++++++---
 target/hexagon/gen_analyze_funcs.py |  4 ++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index fe7858703c..5271c4e022 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -37,6 +37,10 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+/* Forward declarations referenced in analyze_funcs_generated.c.inc */
+static void mark_implicit_reads(DisasContext *ctx);
+static void mark_implicit_writes(DisasContext *ctx);
+
 #include "analyze_funcs_generated.c.inc"
 
 typedef void (*AnalyzeInsn)(DisasContext *ctx);
@@ -378,6 +382,17 @@ static void mark_implicit_pred_reads(DisasContext *ctx)
     mark_implicit_pred_read(ctx, A_IMPLICIT_READS_P3, 3);
 }
 
+static void mark_implicit_reads(DisasContext *ctx)
+{
+    mark_implicit_pred_reads(ctx);
+}
+
+static void mark_implicit_writes(DisasContext *ctx)
+{
+    mark_implicit_reg_writes(ctx);
+    mark_implicit_pred_writes(ctx);
+}
+
 static void analyze_packet(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
@@ -389,9 +404,6 @@ static void analyze_packet(DisasContext *ctx)
         if (opcode_analyze[insn->opcode]) {
             opcode_analyze[insn->opcode](ctx);
         }
-        mark_implicit_reg_writes(ctx);
-        mark_implicit_pred_writes(ctx);
-        mark_implicit_pred_reads(ctx);
     }
 
     ctx->need_commit = need_commit(ctx);
diff --git a/target/hexagon/gen_analyze_funcs.py b/target/hexagon/gen_analyze_funcs.py
index 3ac7cc2cfe..fdefd5b4b3 100755
--- a/target/hexagon/gen_analyze_funcs.py
+++ b/target/hexagon/gen_analyze_funcs.py
@@ -67,6 +67,8 @@ def gen_analyze_func(f, tag, regs, imms):
         if reg.is_read():
             reg.analyze_read(f, regno)
 
+    f.write("    mark_implicit_reads(ctx);\n")
+
     ## Analyze the register writes
     for regno, register in enumerate(regs):
         reg_type, reg_id = register
@@ -74,6 +76,8 @@ def gen_analyze_func(f, tag, regs, imms):
         if reg.is_written():
             reg.analyze_write(f, tag, regno)
 
+    f.write("    mark_implicit_writes(ctx);\n")
+
     f.write("}\n\n")
 
 
-- 
2.43.0


