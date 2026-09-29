Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA848CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfh-0000ES-PT; Tue, 29 Sep 2026 06:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfQ-0007iD-08
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:33 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfO-0008HR-Bv
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:31 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-486e1a044c5so3341447f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676149; x=1791280949; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ayjoUrnJB8+6eCvUDlGJ0HMq5uKuRuZnb9QqnQ5jH2c=;
 b=xMt0KY5SAdzl+DA1crHYvchTX/cxzgilkMiMrBXEQlVEbxJIVu3xWyH9pwhs6Fizye
 /D0xfewNYih1Er3pO8cHYkA8zI9xhTe3bR/m+Q9MJBDfisZn+qQNoN7lE8kOzGfd+t2z
 hs+1vNNsgClOItUSoHTWv55mvCIfAK2ahxprK4BK4JkNccdNl+ZVE36pAwQBQXH7Xy+e
 nnww1xocwUVX59VIyuxmyHF4zRl8FgFIcLtQYf0qXfe7KVu3nvw4BARdOSKceEcjyJRd
 om7z8sHmmG8+BMv3rF7vlXLa6qGZev8eEvC/XWER2TQ4JLYF5jgM6JVgB4bExJuzz4pW
 s7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676149; x=1791280949;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ayjoUrnJB8+6eCvUDlGJ0HMq5uKuRuZnb9QqnQ5jH2c=;
 b=mhKC+QGydFS9FVjat45qeZCH4Tk+iiC+/BYHGsU+KooubqeDAB6DMeh5awzSlHoeKV
 B+ZvUxQiVDC147Dk1huw+kL6cxyLqtaBravyDeZXwzDGWDZtOHaFaEAvI+w909x6MMpt
 oheFbgJA3mgUuR7CGJ5Ct7oWt23XWAYXk1xWOrrMPMuvH22SrexLewRM9MqsocwIwmwW
 penn6dggsKO5dhvm1p9TPHvpN0G2d65mEWOGdh1azx1L1TdIwEcKXVP/6HBynTtPGhiX
 7lJjJt4mi7n/6bt1E75vvAjhgnTb95COA9q41c3CNMIgvb2elho9K3b5TutHjS7lfqtL
 GZQQ==
X-Gm-Message-State: AFq9FYJ1coclb/nlXylKZYnrD1sHR5ISD5VdfiaYip0Lwz3oOqaiVaqX
 7h73hBR9dpWBZM0BSRu4l/hnsLyJF4+oB1ktOEByHqkCVgf8X974yBRMTsOzZ8F8HigMTQDG9Jc
 5t2Ag
X-Gm-Gg: AYBFou14nAtULutgvj6TY6G+KGyVdEO2uraZ1pFrwBX+2T6rVfstyNlFiQqzYSDd/F5
 Wf9IQ+3spTawCyAujRYNlWvkbDJKKX2I3fN+rroneiywqt28IraZQuK2GBHWQ8G0uAs95gm8O5A
 s+Vz2hIVT5E5x5DAdKXBRbVnXTgc1XfbqxKOlrTDK9PevM1AB7FR1BlW92b2oxR9TAz79Ow7LdA
 aZBGOa2QKCW0eTh6B8aTgSjCT7VRc42nJdiXSouiOAseabYvMw41AxJyU1MyMGX4TIrgiKLApxd
 OUc6QKtgpxR1+csnxN+AG+HVMUBPMtCeyqg3oU2Mr+bpdWTszPUKNrFR7LboqZEyASwJF04KETz
 0chU8tuBOK42cRTsDCo7CnQCPWy8eTCbtTcTGypI5jNJsWd235rduIryPncTcINy6XoUPNTXplU
 P9z3BtrPVIfLVvlzeYUZ9yFtGLMCbMpJqWfYL6/Ba1s5DyQD1ttGcw+tChU6nZk8tMsiHNspRyt
 AJXOS9t0dFSSwyK0rkuk2gaL9JL0TGDgHG5DMUfTR7MelzgapbSolue6qRIykC4b2EMsTHeQiDM
 bko=
X-Received: by 2002:a05:6000:25f2:b0:487:2443:7526 with SMTP id
 ffacd0b85a97d-4887197ba03mr26911054f8f.55.1790676148536; 
 Tue, 29 Sep 2026 03:02:28 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/37] target/arm: Honor PSTATE.UINJ during translation
Date: Tue, 29 Sep 2026 11:01:29 +0100
Message-ID: <20260929100133.2598676-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr2-x10.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260925215004.456336-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.c     | 10 +++++++---
 target/arm/tcg/translate.h     |  2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7f858654c43..5d5b11e2da9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -11174,7 +11174,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     s->fp_access_checked = 0;
     s->sve_access_checked = 0;
 
-    if (check_il(s)) {
+    if (check_il_uinj(s)) {
         return;
     }
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index fbacc3b7574..6983153ffc6 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1164,12 +1164,16 @@ void unallocated_encoding(DisasContext *s)
  * must be checked after reading the instruction.  They have more priority
  * than the AArch64 BTI exception.
  */
-bool check_il(DisasContext *s)
+bool check_il_uinj(DisasContext *s)
 {
     if (s->pstate_il) {
         gen_exception_insn(s, 0, EXCP_UDEF, syn_illegalstate());
         return true;
     }
+    if (s->pstate_uinj) {
+        unallocated_encoding(s);
+        return true;
+    }
     return false;
 }
 
@@ -6167,7 +6171,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         return;
     }
 
-    if (check_il(s)) {
+    if (check_il_uinj(s)) {
         return;
     }
 
@@ -6737,7 +6741,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     dc->base.pc_next = pc;
     dc->insn = insn;
 
-    if (check_il(dc)) {
+    if (check_il_uinj(dc)) {
         return;
     }
 
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 7eba9b764ce..57e45ea8724 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -382,7 +382,7 @@ void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
 void arm_gen_test_cc(int cc, TCGLabel *label);
 MemOp pow2_align(unsigned i);
 void unallocated_encoding(DisasContext *s);
-bool check_il(DisasContext *s);
+bool check_il_uinj(DisasContext *s);
 void gen_exception_internal(int excp);
 void gen_exception_insn_el(DisasContext *s, int64_t pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
-- 
2.43.0


