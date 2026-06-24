Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 148B4CDB47C
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKtF-00031R-37; Wed, 24 Jun 2026 06:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsm-0002a8-Ku
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:31:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcKsg-0007hC-Kn
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:30:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so732369f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782297053; x=1782901853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVIHfgvOBO+ct2EhyE9pq49O4xVF2moDOiCD7HY29ss=;
 b=potKPxtFHVcgengPH1VskApl+xR4htp5C4KQk1BRxqARrgOr6r6u8JS8qiJzq6MEYT
 abTFxipFfzxmCWBjG3momN93DqJ6v2QjF9HhKKNgReVatWJipr0pzBbADkXaMbpDDbPK
 tPMf1BMUsSiO2f4YsIqIl3ZwF8JuDz3hWAaz/ZKibXcUbVkuPaLHx/kyhETqewY6GufX
 eCDP/WHFG0KjNmeuN0JzEvbaG9i00oHK50tW+kFGf40dzgHfM0cV1fNDMkWhCCNz2KrF
 u0A6XrwcnSvMXCRVRQUxv1oBPt5D+/brpw1xBRVBymTYn1B1iFNTifyWOcuuupCLsyeE
 F42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297053; x=1782901853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MVIHfgvOBO+ct2EhyE9pq49O4xVF2moDOiCD7HY29ss=;
 b=ri/cXVOCKSAA5RlNa+vopK/4PuwLTH89Jfos/mUNaD3sEQOf8FtOXAtTV/Wt4U046c
 haTRWkUadfg0i/hjuQqo4D3zg9Y9Qk+hAa3venVL1IHk2ZEnDnB1BbhvOFu/UDgilkIV
 1YVsxyXXH/knwnpskFw0IEV23Uu99QbiZI2lfexfQY/Hi6BMjzkiwPvtQcXhSygEE2u+
 ct5v0s6IyaKbNMI8V4I9poXK3bHr/YYmA/D4YHPHcaAw7KHw5AyQ7R8utu52SKae+6FF
 BVxiXCprerOd1Sg8ddHs+sGplpAbrt7odvJpW4LNG4A+ceBJFzuwM1nNi+sq/VdMeWSV
 p9hw==
X-Gm-Message-State: AOJu0Yy58s48WKCYle4rO8qhIoDuBxzQ3WDzLjxq0GukgTK15WUJyC+S
 Fcq3v5zaE+JQoJ3bcdNVNqEN5dt7FyP/imIshBqfz1yQIfJ5nbOLsJ1V9KT5Q71Mvlo=
X-Gm-Gg: AfdE7cnZtZOhbCPOxXDYOuYiQ/QvOOiLlfrRsXhPpwpWqpRXXfqRO/rWM4ZlkLn73mm
 +fJslh+e59P4hg1+7N+nPEnNz0wkdUAXigT+lKm8Msrf6lTt3vR0F5m7HNa2CkQWp8tjEGdwhMX
 Pr2NvaNVmntuOtYBW1Kl1TpbNhr/0Nl9Dc5RuVE8oT/umcCDMz/wl+hQByERx+1Aa8lSntCrao6
 KaAqTIAynMhEdafMVprbwxy/84kF9YiN1X4lXKbFkm51ZijOOBWcfcXkxqOcwg4nfNJCCgp68xM
 Ig6hN1hSvzQ6naEuoUBjAlfpCBvZX2awKjhx1S2SfM5YTMBaPVeMdCgadtRgZg4wzBQsbXGuEyb
 rD2j11O3PY9VIXf44kTkqRkGRIDH0QvLZ6vZUDtG2kfAQY+VRoBh8C1rvUY/fcsKKz3B/lZ76OZ
 2jjzvzc5CjPllO
X-Received: by 2002:a05:6000:40e0:b0:461:d2ee:2fcc with SMTP id
 ffacd0b85a97d-46adb587753mr11075293f8f.43.1782297053119; 
 Wed, 24 Jun 2026 03:30:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22c680fasm5593358f8f.34.2026.06.24.03.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:30:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 374115FA5C;
 Wed, 24 Jun 2026 11:30:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Troy Lee <leetroy@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v9 5/7] target/arm: implements SEV/SEVL for all modes
Date: Wed, 24 Jun 2026 11:30:47 +0100
Message-ID: <20260624103049.884930-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624103049.884930-1-alex.bennee@linaro.org>
References: <20260624103049.884930-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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

Remove the restrictions that make this a M-profile only operation and
enable the instructions for all Arm profiles.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - restrict SEV to M profile plus
  - restrict SEVL to V8
v2
  - fix alignment in a32.decode
  - set bool directly, defend with QEMU_BUILD_BUG_ON
  - s/instructions/profiles/
  - share get_event_reg between translate/translate-a64
---
 target/arm/tcg/translate.h     | 18 ++++++++++++++++++
 target/arm/tcg/a32.decode      |  5 ++---
 target/arm/tcg/a64.decode      |  5 ++---
 target/arm/tcg/t16.decode      |  4 +---
 target/arm/tcg/t32.decode      |  4 +---
 target/arm/tcg/op_helper.c     |  4 +---
 target/arm/tcg/translate-a64.c | 17 +++++++++++++++++
 target/arm/tcg/translate.c     | 20 +++++++++++++++++---
 8 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 462d4c1c74f..83b413ee368 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -860,6 +860,24 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
     gen_helper_set_rmode(old, old, fpst);
 }
 
+/*
+ * Event Register signalling.
+ *
+ * A bunch of activities trigger events, we just need to latch on to
+ * true. The event eventually gets consumed by WFE/WFET.
+ *
+ * user-mode treats these as NOPs.
+ */
+
+static inline void gen_event_reg(void)
+{
+#ifndef CONFIG_USER_ONLY
+    TCGv_i32 set_event = tcg_constant_i32(1);
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, event_register) != 1);
+    tcg_gen_st8_i32(set_event, tcg_env, offsetof(CPUARMState, event_register));
+#endif
+}
+
 /*
  * Helpers for implementing sets of trans_* functions.
  * Defer the implementation of NAME to FUNC, with optional extra arguments.
diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
index f2ca4809495..547aa2b1490 100644
--- a/target/arm/tcg/a32.decode
+++ b/target/arm/tcg/a32.decode
@@ -192,9 +192,8 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
       WFE        ---- 0011 0010 0000 1111 ---- 0000 0010
       WFI        ---- 0011 0010 0000 1111 ---- 0000 0011
 
-      # TODO: Implement SEV, SEVL; may help SMP performance.
-      # SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
-      # SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
+      SEV        ---- 0011 0010 0000 1111 ---- 0000 0100
+      SEVL       ---- 0011 0010 0000 1111 ---- 0000 0101
 
       ESB        ---- 0011 0010 0000 1111 ---- 0001 0000
     ]
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 28cd1faf61a..81070dac0a6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -250,9 +250,8 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     YIELD       1101 0101 0000 0011 0010 0000 001 11111
     WFE         1101 0101 0000 0011 0010 0000 010 11111
     WFI         1101 0101 0000 0011 0010 0000 011 11111
-    # We implement WFE to never block, so our SEV/SEVL are NOPs
-    # SEV       1101 0101 0000 0011 0010 0000 100 11111
-    # SEVL      1101 0101 0000 0011 0010 0000 101 11111
+    SEV         1101 0101 0000 0011 0010 0000 100 11111
+    SEVL        1101 0101 0000 0011 0010 0000 101 11111
     # Our DGL is a NOP because we don't merge memory accesses anyway.
     # DGL       1101 0101 0000 0011 0010 0000 110 11111
     XPACLRI     1101 0101 0000 0011 0010 0000 111 11111
diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 778fbf16275..9a8f89538ac 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -228,10 +228,8 @@ REVSH           1011 1010 11 ... ...            @rdm
     WFE         1011 1111 0010 0000
     WFI         1011 1111 0011 0000
 
-    # M-profile SEV is implemented.
-    # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
     SEV         1011 1111 0100 0000
-    # SEVL      1011 1111 0101 0000
+    SEVL        1011 1111 0101 0000
 
     # The canonical nop has the second nibble as 0000, but the whole of the
     # rest of the space is a reserved hint, behaves as nop.
diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index 49b8d0037ec..8ae277fe112 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -369,10 +369,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
         WFE      1111 0011 1010 1111 1000 0000 0000 0010
         WFI      1111 0011 1010 1111 1000 0000 0000 0011
 
-        # M-profile SEV is implemented.
-        # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
         SEV      1111 0011 1010 1111 1000 0000 0000 0100
-        # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
+        SEVL     1111 0011 1010 1111 1000 0000 0000 0101
 
         ESB      1111 0011 1010 1111 1000 0000 0001 0000
       ]
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 9f9ea39be5a..d15062e155f 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -477,9 +477,7 @@ void HELPER(sev)(CPUARMState *env)
     CPUState *cs = env_cpu(env);
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
-        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
-            target_cpu->env.event_register = true;
-        }
+        target_cpu->env.event_register = true;
         if (!qemu_cpu_is_self(cs)) {
             qemu_cpu_kick(cs);
         }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 227719ef25b..df5bac22acd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2142,6 +2142,23 @@ static bool trans_WFI(DisasContext *s, arg_WFI *a)
     return true;
 }
 
+static bool trans_SEV(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * SEV is a NOP for user-mode emulation.
+     */
+#ifndef CONFIG_USER_ONLY
+    gen_helper_sev(tcg_env);
+#endif
+    return true;
+}
+
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    gen_event_reg();
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFI *a)
 {
     /*
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c744b163453..9079458a297 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3246,17 +3246,31 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
 static bool trans_SEV(DisasContext *s, arg_SEV *a)
 {
     /*
-     * Currently SEV is a NOP for non-M-profile and in user-mode emulation.
-     * For system-mode M-profile, it sets the event register.
+     * SEV is a NOP for user-mode emulation. For v6T2 and earlier
+     * non-M-profile cores this encoding is a NOP hint.
      */
 #ifndef CONFIG_USER_ONLY
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_V7)) {
         gen_helper_sev(tcg_env);
     }
 #endif
     return true;
 }
 
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * SEVL only exists for v8A; for M-profile and v7A and earlier
+     * this encoding is an unallocated must-NOP hint.
+     */
+    if (!arm_dc_feature(s, ARM_FEATURE_M) &&
+        arm_dc_feature(s, ARM_FEATURE_V8)) {
+        gen_event_reg();
+    }
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
     /*
-- 
2.47.3


