Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31930C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uN-0005EB-Bl; Fri, 14 Mar 2025 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uI-0005C5-1K
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uG-00018l-5i
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:57 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso19816495e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958214; x=1742563014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Xz+WIgazwmvy1y8Au0XPaRBReXruvnZWxhGag+Sxe8=;
 b=xwi+PJXk/D9dYcdmjv5cRa/fs0gfAYPU5i92eF69CZGUWaglId/fo5eaqw9LitMxcW
 mmXO5w448jAkQw698Jj0T3JEblGXmfWsSbqW6fFMSUWFqvGOaBie2I2aJQXdIM0xOW8Y
 6h6fGYDHWmMI2Ava1onEWo+hT9x0/5G0LwdiLLHS39RBr0LdW2BF/kGnqftHF6YoP0EY
 UlSXx4216OYFuxAYkgdaSFC/PA+dFxPmkoWnJuMrIQdU6Q1WfPf/5VqVuvWMBEKkxKwQ
 xu0cL9GgyhV3w3VU5WiuAEbCDaEHjn4Au/SPu9XPAm2hDVXDkhnX29WXA36x/y3tXgtg
 FDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958214; x=1742563014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Xz+WIgazwmvy1y8Au0XPaRBReXruvnZWxhGag+Sxe8=;
 b=dIIoTBe3eIZVCDrTcCh8VoDVgMh4KTQYHKDDQs08tBDYhppDQY7unFl/QdhA+gP+rT
 1GU8uuBlKfiNo4wDT3QfNkjmGiiUkS4ri9zJxkUC5Ww1WyM4/zjf+04vSLTdjH96X481
 wSBDY4vcEBRIWlB9i0E4ry3C5hAT6UcoVTyi3F2K5RR3ksMxNyRbRctqfaBe93KF7M3E
 D0wKJKoQBsm4E7H/XNhvX1Q6LFYNblFmbFNUuakGhYzn58ZjWlEiCKF3SWvPvRolx3oA
 bIBLqYblH0m+AHYEbCiB4g3TrrhrVz4/bVIqVExN0RgZze9iBzKf5daRBYACEw45APOE
 9ydQ==
X-Gm-Message-State: AOJu0Yw5FoB3JYic+cyWlt1+0mPRUbzl6dnY4qvGAEQm0lRSEjHZp4w6
 heezoDnbLzXn0IhnJDVnm9eDfDbto8KGHCmrpjijKKVkgURbHu+Hj6kd41C5yETFGkdxFuf00kz
 Q
X-Gm-Gg: ASbGncsQBxeh+e4EO5eYamM1+JGIWg8//3pHbqH8dJV5rQT6QfSSwbsuOmSFDSoz9qJ
 1a7N7cwBT9DEW9MmOEqvCQf94rGqDi0JXgygxRg4do5wU9ARwg1fhiPmOC3NuoTEN4YjiNHlhep
 O5McKiFNHf3o0Sg4dX6ShtUJsb2LmQ1l1pUQDGUPvqap1uLIUitpihZtSPiCXmKs8ocQVZBYcI7
 1HDE7M0xF9IaNVoiB3FSnAlNUP4pn7rxIH73jtHgNizFoH3griBQ6bx11GB8k3EZ2qatiPDavQK
 nyosSKVo+3ukPyeIAVhWhI5rSW5VNSDVrKVZ3Lx/U3OCHpRGcgE=
X-Google-Smtp-Source: AGHT+IGAfqG4TvXBlNanHC31pZQrVcAjKu/fvtAOZiO6oHkLIyKp84hnGCVfziBuyVc7aIHa8hCHyQ==
X-Received: by 2002:a05:600c:350b:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-43d1ecd10c7mr29063705e9.24.1741958214575; 
 Fri, 14 Mar 2025 06:16:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/17] target/arm: Make DisasContext.{fp,
 sve}_access_checked tristate
Date: Fri, 14 Mar 2025 13:16:35 +0000
Message-ID: <20250314131637.371866-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The check for fp_excp_el in assert_fp_access_checked is
incorrect.  For SME, with StreamingMode enabled, the access
is really against the streaming mode vectors, and access
to the normal fp registers is allowed to be disabled.
C.f. sme_enabled_check.

Convert sve_access_checked to match, even though we don't
currently check the exception state.

Cc: qemu-stable@nongnu.org
Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250307190415.982049-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.h |  2 +-
 target/arm/tcg/translate.h     | 10 +++++++---
 target/arm/tcg/translate-a64.c | 17 +++++++++--------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 7d3b59ccd96..b2420f59ebe 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -65,7 +65,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
 static inline void assert_fp_access_checked(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
-    if (unlikely(!s->fp_access_checked || s->fp_excp_el)) {
+    if (unlikely(s->fp_access_checked <= 0)) {
         fprintf(stderr, "target-arm: FP access check missing for "
                 "instruction 0x%08x\n", s->insn);
         abort();
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index f8dc2f0d4bb..53e485d28ac 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -92,15 +92,19 @@ typedef struct DisasContext {
     bool aarch64;
     bool thumb;
     bool lse2;
-    /* Because unallocated encodings generate different exception syndrome
+    /*
+     * Because unallocated encodings generate different exception syndrome
      * information from traps due to FP being disabled, we can't do a single
      * "is fp access disabled" check at a high level in the decode tree.
      * To help in catching bugs where the access check was forgotten in some
      * code path, we set this flag when the access check is done, and assert
      * that it is set at the point where we actually touch the FP regs.
+     *   0: not checked,
+     *   1: checked, access ok
+     *  -1: checked, access denied
      */
-    bool fp_access_checked;
-    bool sve_access_checked;
+    int8_t fp_access_checked;
+    int8_t sve_access_checked;
     /* ARMv8 single-step state (this is distinct from the QEMU gdbstub
      * single-step support).
      */
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8bef391bb03..48e0ac75b11 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1381,14 +1381,14 @@ static bool fp_access_check_only(DisasContext *s)
 {
     if (s->fp_excp_el) {
         assert(!s->fp_access_checked);
-        s->fp_access_checked = true;
+        s->fp_access_checked = -1;
 
         gen_exception_insn_el(s, 0, EXCP_UDEF,
                               syn_fp_access_trap(1, 0xe, false, 0),
                               s->fp_excp_el);
         return false;
     }
-    s->fp_access_checked = true;
+    s->fp_access_checked = 1;
     return true;
 }
 
@@ -1465,13 +1465,13 @@ bool sve_access_check(DisasContext *s)
                               syn_sve_access_trap(), s->sve_excp_el);
         goto fail_exit;
     }
-    s->sve_access_checked = true;
+    s->sve_access_checked = 1;
     return fp_access_check(s);
 
  fail_exit:
     /* Assert that we only raise one exception per instruction. */
     assert(!s->sve_access_checked);
-    s->sve_access_checked = true;
+    s->sve_access_checked = -1;
     return false;
 }
 
@@ -1500,8 +1500,9 @@ bool sme_enabled_check(DisasContext *s)
      * sme_excp_el by itself for cpregs access checks.
      */
     if (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el) {
-        s->fp_access_checked = true;
-        return sme_access_check(s);
+        bool ret = sme_access_check(s);
+        s->fp_access_checked = (ret ? 1 : -1);
+        return ret;
     }
     return fp_access_check_only(s);
 }
@@ -10257,8 +10258,8 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     s->insn = insn;
     s->base.pc_next = pc + 4;
 
-    s->fp_access_checked = false;
-    s->sve_access_checked = false;
+    s->fp_access_checked = 0;
+    s->sve_access_checked = 0;
 
     if (s->pstate_il) {
         /*
-- 
2.43.0


