Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14A31098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Zi4-00066z-LW; Fri, 20 Mar 2026 09:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhv-0005yi-6d
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:08 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3Zhq-0000MC-Bo
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:16:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-661d20c9787so3095486a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774012560; x=1774617360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s87AYFhMOGqqanPbizV73ZLyBsxi0YeGo2JAxp0jA8g=;
 b=e4iZXPAWmy/8LSznZuy2XW2pOUH6xyZQOWQHe3qsqFKZLXeUxhefTgxmtf+gUdvwVA
 bBmsbrmQz+h0gQttlF2Kek9/PbTHwyw4NmV1wuEh/ox0i+TqJCFIb3sSCxUsy/5eRcuB
 unRh61M85VmubY2IiZkeM961OM3glWv+NroIx8u0xx5ZWqqvS/4Df0w+DQTBur5bCBqY
 6Pk3gSR98gxaABayygmynNY9d4Fy12MLqd3AouPAsiphC3SZ2y2USO3GY45e5ofw3zJJ
 NlUnHEJ5tEf/xVQBwxF5NJx3tMpvNfBoTgmj5fiZ5mGYvjKPSjH9ccOjnERiD2cOKTXh
 mhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774012560; x=1774617360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s87AYFhMOGqqanPbizV73ZLyBsxi0YeGo2JAxp0jA8g=;
 b=tBp6onRMeZPT8oYWB8jLAY2/09jTjFc58WawEQikljrj9fUVNusbYWRFkWLClwK7k8
 QlRHXFBaWPs6kww1ZDhguxl95DOoxFMxGK6bG/xVjMJbYWL8fkf5BblnyYAS3y4OwPWy
 b14oKDt8VgRcVbjcNiN8aPTwc+Pyb3jSHgH6/pCITHPNXUsCJem++4VzSJZGWRBcxUad
 hqGz85SBCauiOHNfcAF9nBpU+tkSvQMN6SijGzKqPJm9vi4qpa1Tfcv6KT2OtCnMOizM
 EvjHNZVitTqb3+wL6+Lgho9S8AqkMzXxWxmyBEu0NWlbNHM4fz5SKPMh1SoAVmVLvg5n
 tGSQ==
X-Gm-Message-State: AOJu0Yzp1T8srx7h/tj12R8p1ygM3JJ4n+3KI9kar2jpff/Mfhd6oZrc
 2BsIuhcJT2DevIfMPDi+LBV2cw9+SuU4uuJlf5TLGn8MGUDbMZIgXvxE4zOmpc7NULs=
X-Gm-Gg: ATEYQzwewXRtXIZ4kvnWCJN3ImeEypP0LYY0+j5KmHLNWfNuPZFh96j4a7QQn5s9OZR
 2/wyuG+LuRfgSwgz5j4sXHXosja2ZdcB/1Pk/eUsUJtWOIIs9eX1G/RvflNK+vrTl5Cb8wDFzOj
 KZQ2JuTCsTeD04g2lrOsxk9ELywHhWPe6c1e8GLxzU7vz4RNDnyYa+2oQLatPzIByqPeIc3TfQ5
 cP863cr7USjHzl9jq2j3Ca6B5ZnA45jvVvoMvXYpX+UkB6NlGUJmrpKQCS8ktx3dNKhOWEbMhTY
 p0h8mbtgx26OXYolTYnTHOUmQ8NBFFT2DAOhERAl56sAfP+Yw1Ptc9exEgHAng3igxZxFvw/Gkl
 pbSu7yX8t/RlJlzJEJFHbGiV/3dUeoXr9AAYKgbovpfqo/YHtjF7HDyAXN//XDmSUxGo1jOPD4k
 /kePlUYJbNKNUCiOKOxKMi4oQ=
X-Received: by 2002:a17:907:3fa8:b0:b98:33c5:1bb2 with SMTP id
 a640c23a62f3a-b9833c56788mr155124966b.25.1774012560322; 
 Fri, 20 Mar 2026 06:16:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9832f8d3d0sm160464066b.19.2026.03.20.06.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:15:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3CE3B5F911;
 Fri, 20 Mar 2026 13:06:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 29/35] target/arm: implements SEV/SEVL for all modes
Date: Fri, 20 Mar 2026 13:06:00 +0000
Message-ID: <20260320130607.2071996-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
enable the instructions for all Arm instructions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/a32.decode      |  5 ++---
 target/arm/tcg/a64.decode      |  5 ++---
 target/arm/tcg/t16.decode      |  4 +---
 target/arm/tcg/t32.decode      |  4 +---
 target/arm/tcg/op_helper.c     |  4 +---
 target/arm/tcg/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate.c     | 19 ++++++++++++++-----
 7 files changed, 55 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
index f2ca4809495..d076681bf97 100644
--- a/target/arm/tcg/a32.decode
+++ b/target/arm/tcg/a32.decode
@@ -192,9 +192,8 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
       WFE        ---- 0011 0010 0000 1111 ---- 0000 0010
       WFI        ---- 0011 0010 0000 1111 ---- 0000 0011
 
-      # TODO: Implement SEV, SEVL; may help SMP performance.
-      # SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
-      # SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
+      SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
+      SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
 
       ESB        ---- 0011 0010 0000 1111 ---- 0001 0000
     ]
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 01b1b3e38be..dcb3099dd5c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -237,9 +237,8 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
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
index b5c8024ace7..d513045269c 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -475,9 +475,7 @@ void HELPER(sev)(CPUARMState *env)
     CPUState *cs = env_cpu(env);
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
-        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
-            target_cpu->env.event_register.as_bool = true;
-        }
+        target_cpu->env.event_register.as_bool = true;
         if (!qemu_cpu_is_self(cs)) {
             qemu_cpu_kick(cs);
         }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d79c8ab431b..c25ff9351b4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -562,6 +562,23 @@ static void gen_goto_tb(DisasContext *s, unsigned tb_slot_idx, int64_t diff)
     }
 }
 
+/*
+ * Event Register signalling.
+ *
+ * A bunch of activities trigger events, we just need to latch on to
+ * true. The event eventually gets consumed by WFE/WFET.
+ *
+ * user-mode treats these as nops.
+ */
+
+static void gen_event_reg(void)
+{
+#ifndef CONFIG_USER_ONLY
+    TCGv_i32 set_event = tcg_constant_i32(-1);
+    tcg_gen_st_i32(set_event, tcg_env, offsetof(CPUARMState, event_register));
+#endif
+}
+
 /*
  * Register access functions
  *
@@ -2032,6 +2049,23 @@ static bool trans_WFI(DisasContext *s, arg_WFI *a)
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
index f9d1b8897d2..3707561af0d 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3244,13 +3244,22 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
 static bool trans_SEV(DisasContext *s, arg_SEV *a)
 {
     /*
-     * Currently SEV is a NOP for non-M-profile and in user-mode emulation.
-     * For system-mode M-profile, it sets the event register.
+     * SEV is a NOP for user-mode emulation.
      */
 #ifndef CONFIG_USER_ONLY
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
-        gen_helper_sev(tcg_env);
-    }
+    gen_helper_sev(tcg_env);
+#endif
+    return true;
+}
+
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * SEVL is a NOP for user-mode emulation.
+     */
+#ifndef CONFIG_USER_ONLY
+    TCGv_i32 set_event = tcg_constant_i32(-1);
+    tcg_gen_st_i32(set_event, tcg_env, offsetof(CPUARMState, event_register));
 #endif
     return true;
 }
-- 
2.47.3


