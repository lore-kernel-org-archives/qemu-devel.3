Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058BDEC1130
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 20:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vucyt-0006aV-Vs; Mon, 23 Feb 2026 15:56:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucys-0006a6-Hd
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:38 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vucyq-000811-UA
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 15:56:38 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4ba9abbecso4720227a34.1
 for <qemu-devel@nongnu.org>; Mon, 23 Feb 2026 12:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771880195; x=1772484995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IMYAT0UdSq0H7pvUQzIReqBF5jE1ZDXuCD8wUNNtE9o=;
 b=CMlASvLunkEByf3FaYURu76ThHSPqctte0VxZqAXcHrk3e0az87AJAXXM332VRlhKY
 MSN3Lf8ItgtznFt4pseOQFfrMUVZjP5FoD6OCOQPxBCYdKJGfyHU7wqjd3YsldZMIQvG
 yox5Ew/0ffhIuIeDnFQ1Wu8STJBUbyP42vyxJKlmDKDhPLyJrhQE4Ie7yKf2L6oYMdih
 q694D324ZCLsOYyf0f3bb5cubZ1OH/7ebdtSRzN3/v4ayxQ3X6b+qxXTlYX41cOXXOOk
 yzN3RG3q6V+6W6OZzHL7GPZpYKevo39D4T4z10d7bG8DljLwojTfNEadOemBtQbtPxwJ
 FIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880195; x=1772484995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IMYAT0UdSq0H7pvUQzIReqBF5jE1ZDXuCD8wUNNtE9o=;
 b=O0jIKrVVn59OUvet+0LYrmmryklZYeIJ4ucXoDla9eJQ+imJ71IGWUEZOJP8GRA7yF
 mDa6eyOOw7l7gGtrpuv4qKIOroquutTTrQsnAVKf941sZL/P6R7dcxG3KKC9pNGOouai
 SnLR40txPxtTbfDawYnVX5jRhsH9xkEwJNKdx78Ru9hXJVPO0lbBApHxlYqgP84yaRDs
 TiP0VSvSJSlp3c28Aj12nTNTC53ZAhPuvL4bxc7RJ8wK1p2wKw6hsZMlYnmof1Jruu/s
 BECYnwOTHy7FqUZuitd0OACy8OmEWpeXbDBWFJ0zlVDgjCfmp4R5extoysPKQMB9cunQ
 g1Lw==
X-Gm-Message-State: AOJu0YyximKuc7tTs0d9Mdf3i9A2prfavwlO132n4wHTIwPJWwV32B36
 6Nq1LfNaT4I1wGxFLoHXsSP3XILyK/vkz2WOjL1rFZXl1u9tW473SwGnDDuE5A==
X-Gm-Gg: AZuq6aIiM8PsSLVfsv3ybB8T5p1eT+Qlonu0F+OZQYG1Se2oCwUmPAvE8GtQZbSYiGi
 GS3NH6FibwS3KeZX9c4FEeLkjrZJE1yRyXM+4gv8U5Gb9m7bHqT1lpL5Wuxwr1V1s0E7MjvsyPZ
 /qBz3Y1hRUryBCIIa1EQoe5+AwHdZFiDbwW6qqSt/7p2GDyjCMLYg1NfEv5buMqHdQXifGt7/pI
 bEyp1mE2bxNAWix++JV6smiACkQMRav7v3+tzZZvrx4WhGpP0RjdYaZ5gsSrxVIZyjaG57vGRHQ
 b2dPMu5G9MrtsuUosHoFRSS+3QCKke287ouoZ3wa88uNh6bVHJcC7AP187uxsjaHUZW8T7yrt6T
 NbsWzUg2cgE3qQgfDNjh7SK0OdtaSfP6CpQ2pusbBo8wmU/93x+q0hyVnuBDE8lo6LU5N/x4zoK
 RrvpJyvdx6KHpOQAkz6gAE9iGoM15bKedq/jYaNGSetTvF06Zd0FAHTwoOVlF5NyL15OIJifSJ2
 LlxEgFJjqgqIaqS5Cq55N/hXri9maKTVb10Mg==
X-Received: by 2002:a05:6830:2aa4:b0:7d4:9679:5797 with SMTP id
 46e09a7af769-7d52bf3759cmr7188003a34.28.1771880195074; 
 Mon, 23 Feb 2026 12:56:35 -0800 (PST)
Received: from taylor-ubuntu.hsd1.co.comcast.net
 (c-75-70-169-246.hsd1.co.comcast.net. [75.70.169.246])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52d04dbf1sm8011996a34.22.2026.02.23.12.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 12:56:34 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 1/8] Hexagon (target/hexagon) Move code out of gen_start_packet
Date: Mon, 23 Feb 2026 13:56:25 -0700
Message-ID: <20260223205632.223714-2-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
References: <20260223205632.223714-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x334.google.com
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

Move clear_pkt_ctx and analyze_packet out of gen_start_packet
Precursor to adding packet validity checks to analyze_packet

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/translate.c | 46 ++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 2fdc956bf9..6e32805202 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -407,29 +407,12 @@ static void mark_implicit_writes(DisasContext *ctx)
     mark_implicit_pred_writes(ctx);
 }
 
-static void analyze_packet(DisasContext *ctx)
-{
-    Packet *pkt = ctx->pkt;
-    ctx->read_after_write = false;
-    ctx->has_hvx_overlap = false;
-    for (int i = 0; i < pkt->num_insns; i++) {
-        Insn *insn = &pkt->insn[i];
-        ctx->insn = insn;
-        if (opcode_analyze[insn->opcode]) {
-            opcode_analyze[insn->opcode](ctx);
-        }
-    }
-
-    ctx->need_commit = need_commit(ctx);
-}
-
-static void gen_start_packet(DisasContext *ctx)
+static void clear_pkt_ctx(DisasContext *ctx)
 {
     Packet *pkt = ctx->pkt;
     target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
     int i;
 
-    /* Clear out the disassembly context */
     ctx->next_PC = next_PC;
     ctx->reg_log_idx = 0;
     bitmap_zero(ctx->regs_written, TOTAL_PER_THREAD_REGS);
@@ -458,8 +441,29 @@ static void gen_start_packet(DisasContext *ctx)
     for (i = 0; i < NUM_PREGS; i++) {
         ctx->new_pred_value[i] = NULL;
     }
+}
 
-    analyze_packet(ctx);
+static void analyze_packet(DisasContext *ctx)
+{
+    Packet *pkt = ctx->pkt;
+    ctx->read_after_write = false;
+    ctx->has_hvx_overlap = false;
+    for (int i = 0; i < pkt->num_insns; i++) {
+        Insn *insn = &pkt->insn[i];
+        ctx->insn = insn;
+        if (opcode_analyze[insn->opcode]) {
+            opcode_analyze[insn->opcode](ctx);
+        }
+    }
+
+    ctx->need_commit = need_commit(ctx);
+}
+
+static void gen_start_packet(DisasContext *ctx)
+{
+    Packet *pkt = ctx->pkt;
+    target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
+    int i;
 
     /*
      * pregs_written is used both in the analyze phase as well as the code
@@ -957,6 +961,10 @@ static void decode_and_translate_packet(CPUHexagonState *env, DisasContext *ctx)
     words_read = decode_packet(ctx, nwords, words, &pkt, false);
     if (words_read > 0) {
         pkt.pc = ctx->base.pc_next;
+
+        clear_pkt_ctx(ctx);
+        analyze_packet(ctx);
+
         if (pkt.pkt_has_write_conflict) {
             gen_exception_decode_fail(ctx, words_read,
                                       HEX_CAUSE_REG_WRITE_CONFLICT);
-- 
2.43.0


