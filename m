Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F04BCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWcs-0000ND-E1; Tue, 16 Sep 2025 10:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaT-0005t3-KN
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyWaN-0008ON-D4
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:23:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2445806e03cso61708725ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758032586; x=1758637386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wb3ffh10yt9XUqD1An7QFUP22NN64A7VcTxbgqStNMo=;
 b=aCVDze3z+PBa0jDbMg+sEvQb1SIxrUIDURzQsx/N59v9t4+fXQx05PydCjDMUYQLb8
 1lEmUUxAhkitZ9X8pVQqiDmTFkICucwpMP0vPu6hg5Rnc31wmoLSSAfO9Ch+MeE7P6aL
 Y43NUaX+xGZhTxnAQ0CTiX7IdLyYu47saagS5Hcsvamat/EoeCeC7e5702FFU/J5X/k6
 dxXrWjfjOxg/qoDf88qL/xLJA+gurvHEG/NlXbDJLNfoGoWzDQOEwPnYdSohbBemaf4f
 NkSc+RjD0kymcyJ0C+m7GKUeAyLqE83988u6mnvPBnfsYJm2o44t0n5i4f09Qtx8kH6W
 09LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758032586; x=1758637386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wb3ffh10yt9XUqD1An7QFUP22NN64A7VcTxbgqStNMo=;
 b=ITFj6pWSQyZSn24qHVIZZA7kcETutB6Q69VqZRBYl6Jj9LMKvP1D4xJIaFNNs6gLEm
 hfpUjVPlOAkg0gSqfN5UNCeUxQQg/q+BkN8vZc6blUZNdzAV88tYqOrK5zjdxasdCfKy
 RPJ0ce8KHvrR9fWsmsx8LE5TAF1rUAX4L/Bc/MfJCj+y4LVZTwHCV+LHWQvJk3ZGvyZx
 BRM2fhfqsHf9Sn/fVF9pfbS+TFirVz2k0bsbHI7A7S5MD9N81aNl8/loibsbTUDSHlnq
 3ZbSwz9Ux1wxesdwJ0HSfri2UQKL3IrpekoHrb9o43l4jXv7ne54kA4uLWLeBsC0yO5j
 tUYQ==
X-Gm-Message-State: AOJu0Yy1cCVX2h5nT7wtiInIekDJoYs5TZ3V50KwZUYG1t3k+xOFKUVz
 H4A+9wC4aXHvuwtEiSncrY09icDy4JBVQFTdavx1vXr7lQY/COxIHtDQykffclR5FqLDho/Ahlq
 DJhX3
X-Gm-Gg: ASbGncuAcuw4uuwBc1odqOjcZ0zTTiZjwOWnN6xv0AWrqpWsx4+lAmmjgQNxjEj0Idv
 ezJXg9XHiQgU1yDROy6mfQQc+wxN8CkbVii9FhNHJvBsjGo0xmyXI9WcmwBR5Dw7qJ/FJBCMV7N
 K+pm7zHNvo8MKUrRJ48kV+44UuMWUP8mt9bsL07mRjBUp1p1NynaOHlurPXqoyAbFg18WuuJp2Z
 su30ATgSM5q23xkC/KZCsn6kk2BA2e/QM0qInc2vJSEfWLhtrAhNaqgES4GDqtaAvGm4/uVkjUY
 N+P1fMcRfUyNKOajuZjWldQr+vUHOBGazTMs7JvrnqhJZ+RssyUl/h26BGblDvyJCq55vNQ2osA
 b8McwHIQ6wffWH8n+JifHYt/w+B2F
X-Google-Smtp-Source: AGHT+IFBqlLhGvaJsPq8Rxtju66bht8SxRdLYRlVcl/FbieGskugGZ8iLrC7mlGbgyQNZZeHIHI7Zg==
X-Received: by 2002:a17:903:fa5:b0:265:47:a7bd with SMTP id
 d9443c01a7336-2650047b6fbmr106083045ad.4.1758032586245; 
 Tue, 16 Sep 2025 07:23:06 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2651d2df15esm73459905ad.45.2025.09.16.07.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:23:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 33/36] target/arm: Redirect VHE FOO_EL1 -> FOO_EL2 during
 translation
Date: Tue, 16 Sep 2025 07:22:34 -0700
Message-ID: <20250916142238.664316-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916142238.664316-1-richard.henderson@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h            |  6 ++++
 target/arm/gdbstub.c           |  5 ++++
 target/arm/helper.c            | 53 +---------------------------------
 target/arm/tcg/translate-a64.c |  9 ++++++
 4 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 7bdf6cf847..d34ed0d40b 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -911,6 +911,12 @@ struct ARMCPRegInfo {
      */
     uint32_t nv2_redirect_offset;
 
+    /*
+     * With VHE, with E2H, at EL2, access to this EL0/EL1 reg redirects
+     * to the EL2 reg with the specified key.
+     */
+    uint32_t vhe_redir_to_el2;
+
     /* This is used only by VHE. */
     void *opaque;
     /*
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index e2fc389170..3727dc01af 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -249,6 +249,11 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     if (ri) {
         switch (cpreg_field_type(ri)) {
         case MO_64:
+            if (ri->vhe_redir_to_el2 &&
+                (arm_hcr_el2_eff(env) & HCR_E2H) &&
+                arm_current_el(env) == 2) {
+                ri = get_arm_cp_reginfo(cpu->cp_regs, ri->vhe_redir_to_el2);
+            }
             return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
         case MO_32:
             return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0f681c15e0..49bb1e8365 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4456,47 +4456,6 @@ static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
     return e2h_access(env, ri, isread);
 }
 
-/* Test if system register redirection is to occur in the current state.  */
-static bool redirect_for_e2h(CPUARMState *env)
-{
-    return arm_current_el(env) == 2 && (arm_hcr_el2_eff(env) & HCR_E2H);
-}
-
-static uint64_t el2_e2h_read(CPUARMState *env, const ARMCPRegInfo *ri)
-{
-    CPReadFn *readfn;
-
-    if (redirect_for_e2h(env)) {
-        /* Switch to the saved EL2 version of the register.  */
-        ri = ri->opaque;
-        readfn = ri->readfn;
-    } else {
-        readfn = ri->orig_readfn;
-    }
-    if (readfn == NULL) {
-        readfn = raw_read;
-    }
-    return readfn(env, ri);
-}
-
-static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
-                          uint64_t value)
-{
-    CPWriteFn *writefn;
-
-    if (redirect_for_e2h(env)) {
-        /* Switch to the saved EL2 version of the register.  */
-        ri = ri->opaque;
-        writefn = ri->writefn;
-    } else {
-        writefn = ri->orig_writefn;
-    }
-    if (writefn == NULL) {
-        writefn = raw_write;
-    }
-    writefn(env, ri, value);
-}
-
 static uint64_t el2_e2h_e12_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     /* Pass the EL1 register accessor its ri, not the EL12 alias ri */
@@ -4676,17 +4635,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
                                  (gpointer)(uintptr_t)a->new_key, new_reg);
         g_assert(ok);
 
-        src_reg->opaque = dst_reg;
-        src_reg->orig_readfn = src_reg->readfn ?: raw_read;
-        src_reg->orig_writefn = src_reg->writefn ?: raw_write;
-        if (!src_reg->raw_readfn) {
-            src_reg->raw_readfn = raw_read;
-        }
-        if (!src_reg->raw_writefn) {
-            src_reg->raw_writefn = raw_write;
-        }
-        src_reg->readfn = el2_e2h_read;
-        src_reg->writefn = el2_e2h_write;
+        src_reg->vhe_redir_to_el2 = a->dst_key;
     }
 }
 #endif
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c0fa2137b6..3ef24fb0c3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2573,6 +2573,15 @@ static void handle_sys(DisasContext *s, bool isread,
         }
     }
 
+    if (ri->vhe_redir_to_el2 && s->current_el == 2 && s->e2h) {
+        /*
+         * This one of the FOO_EL1 registers which redirect to FOO_EL2
+         * from EL2 when HCR_EL2.E2H is set.
+         */
+        key = ri->vhe_redir_to_el2;
+        ri = redirect_cpreg(s, key, isread);
+    }
+
     if (ri->accessfn || (ri->fgt && s->fgt_active)) {
         /* Emit code to perform further access permissions checks at
          * runtime; this may result in an exception.
-- 
2.43.0


