Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7763CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29AB-0000vh-Ha; Fri, 26 Sep 2025 10:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299O-000086-He
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:18 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298c-0005lb-Is
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1406145f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895762; x=1759500562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LZ/QhKuHG+ZNPC1QPIsb+KXLj/+hTqbEnRD9dR1HMkI=;
 b=aZeXF5SV+opWBq6MCCtjZpUyG1SpnhCAcgMVuijJg2bjxgHuE0ejhjFkNq9LVjKOfx
 D9c1MpeyP+fxxJDcDLq8QtYq0cVNZWqTKSKmoaDwjuwAVNRD90qcsaJmC0p07fPf5Kvk
 LXRwSdksj2f3eiE4igrIHj7/PPsHEuL8liKaNZ6+pligc0ArPhZNQM0qIw9zFwWNDqCm
 V+gfdIReVDjuTCt/3CvIbk326qddZKRzUHWnjpugzQNfuvXJffuN/am01+EeBwjIo1nK
 DRVgCO3tL5PNvCGjjjOml90FypvF91V1lvS3REFbUWiIB+6ZmMX2zz4xWOg1bFC80qAb
 hF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895762; x=1759500562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZ/QhKuHG+ZNPC1QPIsb+KXLj/+hTqbEnRD9dR1HMkI=;
 b=aoxVspS9V2uOnYG4vEMNfvecZLGUD6z2VG8PhL9ozZQmuk3SHbpO36s8Cjv2SGA/Hz
 BufHVuyIPNViwqKNj9msQDehY2zoy7LKHiEmKjaYbo4AnmfUE49L1b/MWgmL2WOLavN2
 8chEmrJWqsMV0eSsPbYU7mI7Q5xmoEgAAe+TW1yt6H5JnleXauvX2sK1w0VEaeMqCmxR
 qNtWxHdUTDX5S07e8MidTEztw89A7WCEE/YY7DXE1eutKraZ/P8p4BffmeuRKPRvmgUQ
 rn5VBBJQ6lMCoktY0v72hjAjZHl4Z0nURurubMILyCv4JqV6dmaDsyfoJV2t0mDFKt08
 YadQ==
X-Gm-Message-State: AOJu0YzT1q+U2YfvM3AvgtVaY0SKS1FFmJZE3XS9fPBzt2XPG983MGJ9
 AQvyNyV31UyEBJ/1jmLiuE8AFnyn/6nn95LWg+HkZdbHSDMccaajvnXzEX2UoRpxnjMJmSm+Sa0
 YPurp
X-Gm-Gg: ASbGncs626cR1yIlsB+e1HzpuInYIqJeFXut47xNeIX/ceZApydkFRHxzzxleiOuObu
 dzQ3kK012QXFT+Y7byULQTXKqVifnTwUbvqego5OW//wFnEKHVskhxUdll83JZ+7wxa3Y8M2QdI
 SfOWTHih3ByeiwtWpDhqOzCIr76UimrRoPEMJYG7yPonAOCnTEXUYXliSoniFaIfWdySbFa2fDM
 AUqcbP5UhOMuoSfN/3uCeiGBTLYFavZjiGggFbmzAtBM7kRN1qafh5KuugjyvVIIUQhxU2gr/jq
 Fa8uBaaO43BGSQIZnLtFx9sp5eW3gFRb0FhGxnHOZhrKGbiWU77VPR7cYKzIUB624cgvsHDyYY1
 eIOYT9c43chGUKD9EuWET5f77PQ2B
X-Google-Smtp-Source: AGHT+IHQLjvYQ2qG9B926kfpvWyEye1IHQUC89Xvx+/wROWOrVwm9RVc99Ryz0GHyOh+JlUQKAdelg==
X-Received: by 2002:a05:6000:2c05:b0:3fb:6f9d:2704 with SMTP id
 ffacd0b85a97d-40e46ad02e6mr6741729f8f.28.1758895761838; 
 Fri, 26 Sep 2025 07:09:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/44] target/arm: Redirect VHE FOO_EL1 -> FOO_EL2 during
 translation
Date: Fri, 26 Sep 2025 15:08:35 +0100
Message-ID: <20250926140844.1493020-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpregs.h            |  6 ++++
 target/arm/gdbstub.c           |  5 ++++
 target/arm/helper.c            | 53 +---------------------------------
 target/arm/tcg/translate-a64.c |  9 ++++++
 4 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index 08fc42ea571..eac0cb9ebf1 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -936,6 +936,12 @@ struct ARMCPRegInfo {
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
index 4e2ac49b6a9..87d40d4366b 100644
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
index 18066b0c5dc..87a32e363e9 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4417,47 +4417,6 @@ static CPAccessResult access_el1nvvct(CPUARMState *env, const ARMCPRegInfo *ri,
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
@@ -4632,17 +4591,7 @@ static void define_arm_vh_e2h_redirects_aliases(ARMCPU *cpu)
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
index c0fa2137b63..3ef24fb0c3d 100644
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


