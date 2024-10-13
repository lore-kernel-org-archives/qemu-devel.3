Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA15CF258E
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06pO-00075z-Av; Sun, 13 Oct 2024 18:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pM-00075c-RV
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:40 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pL-0000tJ-7s
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:12:40 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e2eba31d3aso1725591a91.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857557; x=1729462357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S3nhJScpyOxwK6cYED3CCWJGrT05YK1NUQh3o/GeSgc=;
 b=ZRkXYAATbzk5Z/ls0O8pt41gPwPhD8HTRwldmJDy90KhT57aqOih1BNdt9GLcdX9EN
 nxyr8G3q4ieuoeB5Oo0eKZ3ySo6W7D9YvYO7zX7CAUxYFq6D5s3WsjLqG99Zm/wyO/vx
 +7DaXp0nKO2jr8PeHLwB5jEIqrc2h/yvtDQXJI6j0imH6RoHtxjpi2Q36DmdVb0CyayY
 Auzklo8IzQTMMoCV/weMYwSXH7OCT6HlyDGX/cAzB0e62/HfHEV4OIa3kOsZxzI03QYW
 Tw4h/SZiffCjfG9E+D7c3sXsvogl9+Nos7FgYE3LjXVcwYb4NejhfS/1YKRjYuGcimvW
 5pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857557; x=1729462357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3nhJScpyOxwK6cYED3CCWJGrT05YK1NUQh3o/GeSgc=;
 b=gOtxc5neBUZ3WuW2xJPo8DqvYxampjpYLyChIIM5g7+iMP0af6kKNxZ9mP1SghFAaa
 yE/Pk+TZs6B1h7fKjzbvcFBK2PvCT8936hjtyZ2Uh/yDIupJc4F1W9e9Ds7VAAuAVcUT
 uRriOpI2H0uyryri3vEKljgS16C46ggzSqkqlKU9k8P/0F8ao2OMc9qVcVAfGXVySR4J
 34xm1gE6eAPP2vEDlnMt7ggcs4aIyW8PrrZe351TEGS1bnfUSb2H/vLt/iaxKihVUeoL
 Z7xS90N4VZC5NhWeAdP5OxEqxrpLzf9mZzs2de10VRVHIRQL9yjHtSS953zX5wvBH05c
 DzvA==
X-Gm-Message-State: AOJu0YyqYGsRtqAba1L9T6ggC/qEU1hDB1nV1hpSevpEc5CNqnQdowVQ
 4u+cO7zcDCyFrsoNihSJfkEVlfPAe5NqY3rd4cskoA8ppAzm2fhJ8/X5ZDrT0CnQ2FNFaTOKmpM
 H
X-Google-Smtp-Source: AGHT+IEXQyFHIY9JFPHVYpiYRRu0cES1eWI2ueT2X08k0LPuxzR3Bh2Ut2TUHWXYxoxX3tBCsUTZag==
X-Received: by 2002:a17:90b:46d4:b0:2e2:cef9:8f68 with SMTP id
 98e67ed59e1d1-2e2f09ee5cemr12735384a91.4.1728857557511; 
 Sun, 13 Oct 2024 15:12:37 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:12:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 01/27] tcg: remove singlestep_enabled from DisasContextBase
Date: Sun, 13 Oct 2024 15:12:09 -0700
Message-ID: <20241013221235.1585193-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

From: Paolo Bonzini <pbonzini@redhat.com>

It is used in a couple of places only, both within the same target.
Those can use the cflags just as well, so remove the separate field.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20241010083641.1785069-1-pbonzini@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h   | 2 --
 accel/tcg/translator.c      | 1 -
 target/mips/tcg/translate.c | 5 +++--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 25004dfb76..d8dcb77b5f 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -71,7 +71,6 @@ typedef enum DisasJumpType {
  * @is_jmp: What instruction to disassemble next.
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
- * @singlestep_enabled: "Hardware" single stepping enabled.
  * @plugin_enabled: TCG plugin enabled in this TB.
  * @fake_insn: True if translator_fake_ldb used.
  * @insn_start: The last op emitted by the insn_start hook,
@@ -86,7 +85,6 @@ struct DisasContextBase {
     DisasJumpType is_jmp;
     int num_insns;
     int max_insns;
-    bool singlestep_enabled;
     bool plugin_enabled;
     bool fake_insn;
     struct TCGOp *insn_start;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 113edcffe3..cbad00a517 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -129,7 +129,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->is_jmp = DISAS_NEXT;
     db->num_insns = 0;
     db->max_insns = *max_insns;
-    db->singlestep_enabled = cflags & CF_SINGLE_STEP;
     db->insn_start = NULL;
     db->fake_insn = false;
     db->host_addr[0] = host_pc;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 333469b268..50d8537a3b 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15362,7 +15362,8 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
      * hardware does (e.g. if a delay slot instruction faults, the
      * reported PC is the PC of the branch).
      */
-    if (ctx->base.singlestep_enabled && (ctx->hflags & MIPS_HFLAG_BMASK)) {
+    if ((tb_cflags(ctx->base.tb) & CF_SINGLE_STEP) &&
+        (ctx->hflags & MIPS_HFLAG_BMASK)) {
         ctx->base.max_insns = 2;
     }
 
@@ -15445,7 +15446,7 @@ static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
      * together with its delay slot.
      */
     if (ctx->base.pc_next - ctx->page_start >= TARGET_PAGE_SIZE
-        && !ctx->base.singlestep_enabled) {
+        && !(tb_cflags(ctx->base.tb) & CF_SINGLE_STEP)) {
         ctx->base.is_jmp = DISAS_TOO_MANY;
     }
 }
-- 
2.43.0


