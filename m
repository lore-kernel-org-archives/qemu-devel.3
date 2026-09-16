Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E7C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6zQQ-00063F-2y; Wed, 16 Sep 2026 19:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zQJ-00062l-RT
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:52:20 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6zQ3-0006bC-P6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 19:52:05 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb74fso224376a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 16:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789602722; x=1790207522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AWO3deFtSiKyFUxh5UBV31HbQHuWjBkV/oJXPBrfIqI=;
 b=znaRktGUhuxZyYIK5K6F7VWZ2solhCguzdv73je9WQc1pRBDaJYhpR1t9WaFlGp/eq
 b+0dLMVfcsyP80j5PA1hForvg4sgC1TuEW/bOVJzKKFO8xQ0Ztohm/1HbOm/qM4MmZXz
 l1tff21Ej5Uudvc6l0NCpds/NELFvZoiqxoKWf4M4W8quin5Xk8LSpDHKZIDpe9YFgse
 f530rnihy/AMTuhVijAAgZTWUbGQol7vCwmm9SzObBkNcznHGbwwRuYZHsNVmpYD5upi
 uIqaJqWx+6+bKYtXDhXQLPkWfHaNgyZD3PtW4ao4wi4/IFD/WAlLhN2kJUusRudCSqX1
 VIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789602722; x=1790207522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AWO3deFtSiKyFUxh5UBV31HbQHuWjBkV/oJXPBrfIqI=;
 b=QikSmxxhqvszP8L3WtNP10bIuk7iNVCJZX3frq8eGAj8TQhMORfjR/ofBX2eyK+gM+
 LCwhLFDxQDAQ4eE7/cFC4hCvHvQ5hk51MO4ftzfqlpQmldHqbfkqX9YP3b31ElQZb378
 +9Zq5vIx6zVpcmQ+ElIDMO9c8OS2rZYi1Tg1/qRiR2fDLp+NBFPG2fwer+TEpcs6g3Nn
 RDYVPHOR1GT8b7PhXMrLe+PuWRXjtXStI0sDT29DCV63AdvIvWf3YcgeJvOiQ0vW3cLH
 DEEWJMQ+ISh5V7AH8KhtCRvJcWZzJlA1jH0BoIeb/Gzt2vAGRWpKTOPlWnbWS4OIWyY1
 OznQ==
X-Gm-Message-State: AFuF++mbeg7XwsIVjFdd+cbNE1g489IosgYGyMeekdus+mlrCbUuymN3
 JvHsNvCOrHrJV2Dh+De5SV6KKb6JuT/+b8yuw3j8BQ0lkOObKrFkuMeO+P3bj3gfEFO2oRitMNH
 xADDaLAI=
X-Gm-Gg: AYBFou3sxKicLwDUYk0W7+SmPwYNKVw4aHlWy40FocZhYIXrEDE6X/ZH7b6LWJemzP4
 Z7iKn/ixamqCtOOk5EuHqLaNtliDHr3FR7wbNz5d3ZzDCDE/kNBqlRKv+pTdYG4oYWtTCVu4Ids
 7gG1orJSx7ULOipq/QaOpd11o2QeI/fW380CBI0MA9mBAlmnbVTM1LamisJxcGqNVfcdDq+ocA3
 /aPghoNPfTQYcljWe7agx1v5kFmBjI2pfB44DoDMgDXLjk+0q0ZKIh0g9Eq5IH5RWsRMFVxg5c7
 7TZo63DaCCR2p1cITmBOoQaVwbI4SaRGPcmNVFidKEKQCsKUH/6112UWL9JYXB6d3NKewcNPp9U
 EDaH6TtfmfbIFKtSek56xG1PRgF5KQtxZykeVRbwWbN8JpZYn+F6UsuXHw3uVRg0m/R6c6sI+YO
 uojNmawnfZcXIq2F5rw8OSCvO7C7edc4yPW0w2QsrUJglx52Faxv5G0V/okNxWOQRtnrwPuM1/+
 FvgBpE=
X-Received: by 2002:a17:90a:a8f:b0:39e:234a:f071 with SMTP id
 98e67ed59e1d1-39e234af2a6mr8934514a91.19.1789602722314; 
 Wed, 16 Sep 2026 16:52:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bfb05e604sm9240454eec.12.2026.09.16.16.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 16:52:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: cui.tao@linux.dev
Subject: [PATCH v2 1/2] accel/tcg: Allow some address space wraparound during
 translation
Date: Wed, 16 Sep 2026 13:51:57 -1000
Message-ID: <20260916235158.294901-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916235158.294901-1-richard.henderson@linaro.org>
References: <20260916235158.294901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Allow the two pages of translation to be non-contiguous.
As long as the target translator wraps pc properly, this
allows address space wraparound to function correctly.

This avoids an assert on a valid i386 system-mode test case.

Reported-by: Tao Cui <cui.tao@linux.dev>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  3 +++
 accel/tcg/translator.c    | 45 ++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 978dee25add..104e6d4f361 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -55,6 +55,8 @@ typedef enum DisasJumpType {
  * @pc_first: Address of first guest instruction in this TB.
  * @pc_next: Address of next guest instruction in this TB (current during
  *           disassembly).
+ * @pc_second_page: Address of the beginning of the second page of this TB,
+ *                  or -1 if the TB does not yet extend to a second page.
  * @is_jmp: What instruction to disassemble next.
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
@@ -69,6 +71,7 @@ struct DisasContextBase {
     TranslationBlock *tb;
     vaddr pc_first;
     vaddr pc_next;
+    vaddr pc_second_page;
     DisasJumpType is_jmp;
     int num_insns;
     int max_insns;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 57daded60ff..52e605708f3 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -134,6 +134,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->tb = tb;
     db->pc_first = pc;
     db->pc_next = pc;
+    db->pc_second_page = -1;
     db->is_jmp = DISAS_NEXT;
     db->num_insns = 0;
     db->max_insns = *max_insns;
@@ -285,16 +286,18 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
     /*
      * The read must conclude on the second page and not extend to a third.
      *
-     * TODO: We could allow the two pages to be virtually discontiguous,
-     * since we already allow the two pages to be physically discontiguous.
-     * The only reasonable use case would be executing an insn at the end
-     * of the address space wrapping around to the beginning.  For that,
-     * we would need to know the current width of the address space.
-     * In the meantime, assert.
+     * TODO: This doesn't handle address space wraparound properly for
+     * multi-byte reads, as we don't know the size of the address space here.
+     * But if the target translator wraps pc to 0 itself, and issues aligned
+     * reads, then this can work.
      */
-    base = (base & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-    assert(((base ^ pc) & TARGET_PAGE_MASK) == 0);
-    assert(((base ^ last) & TARGET_PAGE_MASK) == 0);
+    if (db->pc_second_page == -1) {
+        db->pc_second_page = pc & TARGET_PAGE_MASK;
+    } else {
+        assert((pc & TARGET_PAGE_MASK) == db->pc_second_page);
+    }
+    assert((last & TARGET_PAGE_MASK) == db->pc_second_page);
+    base = db->pc_second_page;
     host = db->host_addr[1];
 
     if (host == NULL) {
@@ -372,16 +375,24 @@ static void record_save(DisasContextBase *db, vaddr pc,
 {
     int offset;
 
-    /* Do not record probes before the start of TB. */
-    if (pc < db->pc_first) {
-        return;
-    }
-
     /*
-     * In translator_access, we verified that pc is within 2 pages
-     * of pc_first, thus this will never overflow.
+     * In translator_ld, we verified that we touched no more than 2 pages,
+     * but we did not verify that they were virtually contiguous.
+     * Here, reimagine the two pages as virtually contiguous.
      */
-    offset = pc - db->pc_first;
+    if (likely(((db->pc_first ^ pc) & TARGET_PAGE_MASK) == 0)) {
+        /* first page */
+        /* Do not record probes before the start of TB. */
+        if (pc < db->pc_first) {
+            return;
+        }
+        offset = pc - db->pc_first;
+    } else {
+        int first_page_end_offset = -(db->pc_first | TARGET_PAGE_MASK);
+        assert(db->pc_second_page != -1);
+        assert((pc & TARGET_PAGE_MASK) == db->pc_second_page);
+        offset = pc - db->pc_second_page + first_page_end_offset;
+    }
 
     /*
      * Either the first or second page may be I/O.  If it is the second,
-- 
2.53.0


