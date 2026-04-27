Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B4FFF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLQR-0002I4-PZ; Mon, 27 Apr 2026 08:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNq-00084l-9z
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNi-0005fk-Pc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso72841525e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294086; x=1777898886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xZm/AVvBxSU6qXvUjvzkb0G4oWQvQlYJBh6wWu9idMI=;
 b=ksd7aXotlHBPyGSTPBZMWOPn+sLvN/TahyURMMckZCDbaM5dC7W7JCUlvgJc4DgW8q
 tVnTUDauENSKr0iDgq5nNFZ8qj3rxaEcFSAQ3+Cp0Y31M+41wf1+IWL6zIQJTfRlsGjy
 0JQ7j6CCiKbikMFnpmSQk1G0Ci2d8usIWCo8U1ukGXA5WH3Hewud0Qx/8HKspXOxBYIu
 xa9pSeC6A1JH8cx9ojIezLuQuhJKlSiWPB+ScuKPfk9V/0kZarrZlZhD65www5smV1gm
 NXtUZQQnpibQDFmWqSu2OgIUO2loTRGYdFx5e8ne0bE5XhboEwyx9KYGJ/FNY76xBSRh
 s/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294086; x=1777898886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xZm/AVvBxSU6qXvUjvzkb0G4oWQvQlYJBh6wWu9idMI=;
 b=qIzswFa8wIl0ZHoI1GAU2urPwnVO1alNzwYcoCMUWP2ezjUx/nXLh68TWoWyKOkGvC
 t5HsNzXZkspIF0dhhUzIEu3c2oyviF1+bqtOFgJMgWmk0a2Wwbk8fzeIoant92/D5g1I
 rbF3u4ksq+7lKuS1USkVJGuYycZ/maFBrY2tt6YcARico9aopEMvTD/McEQbzjKLEpkx
 r46CaZNKYFNWxQxOyFQQecUY1K6kbSm9nEq0i7OcXLzWlkOohe3daZk+S7JuBrZ2gpa/
 piYTPHgnNGplt+E1XMSC9F4CTfSVvIXXucRl1tG7XEcc4SRKX0E0x8dEMhUU90hEbxj8
 X8oQ==
X-Gm-Message-State: AOJu0Yz2eHbr03Go8nGOmWIukrI3X5vZO70wHGuFfo3LQ+3VEyOCvUuK
 XQt4U1r9QQuqq5sZXhnrYMaoEPMLXYFNwuUnfjg+JWGZ0TvDX8dJKPFu+kK71Fjtx0NmBW6yTFT
 s4Tvp
X-Gm-Gg: AeBDiev7tYRRdQBM5T4rD6FRcncg7MNTrsN6XTir6ve6uSMlv9azQHhQDJVGiPHDEWP
 iWyhO5T/nFKEkn5/BwSb47dLcRaPEj25q2xwN6aiomr+SAm1WFkBryigB/9N0GPFPIwplaiMnHV
 eXjMzwB2wpP8JUdoBlHXDyNN5D/x2gHghTzSAY+aNi7gJDHdSRj+m1X6S2TBmR0ibIb8ApE9gVg
 LENdJD0myGxoejYbXmHkaqDxVeZBiq4zlGSxAStnQ+D5nZtp8G3Mssd5UpK2PQZ0uC846t8hQVz
 sP8fkxMgE4nWjm183YYfs9bLtpeJ4Q2Az42+NoSJ3jMfJVPEYtBviQTqB5fTa2JAeSWoaWkzs28
 wxKdvQP7YuDxsmoV+kR81Hu1hYKO+/92seCBKombr/gNMzzGT+l6U3iFmIuOa5VBhJKU/IIUjXH
 KiTpOg1YiulNstP87jHTg7rvQQ9ESp/Oey0bndwCSRghMaRfId5KL4ptSvhHYOLwKVWgkr65ozT
 eSYbKU5IzZDP/ogvWDGO/EY9QgT4OMJ//Rf2QGpuQ==
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488fb765ab5mr610889635e9.14.1777294086270; 
 Mon, 27 Apr 2026 05:48:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/63] target/arm: Allow 'aarch64=off' to be set for TCG CPUs
Date: Mon, 27 Apr 2026 13:47:03 +0100
Message-ID: <20260427124738.966578-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Allow the 'aarch64=off' property, which is currently KVM-only, to
be set for TCG CPUs also.

Note that we don't permit it on the qemu-aarch64 user-mode binary:
this makes no sense as that executable can only handle AArch64
syscalls (and it would also assert at startup since it doesn't
compile in the A32-specific GDB xml files like arm-neon.xml).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Clément Chigot <chigot@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260416165353.589569-3-peter.maydell@linaro.org
---
 docs/system/arm/cpu-features.rst | 10 +++++----
 target/arm/cpu-features.h        |  5 +++++
 target/arm/cpu.c                 | 36 ++++++++++++++++++++++++++++----
 tests/qtest/arm-cpu-features.c   |  8 ++-----
 4 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
index ce19ae6a04..10b0eff27e 100644
--- a/docs/system/arm/cpu-features.rst
+++ b/docs/system/arm/cpu-features.rst
@@ -23,10 +23,12 @@ not implement ARMv8-A, will not have the ``aarch64`` CPU property.
 QEMU's support may be limited for some CPU features, only partially
 supporting the feature or only supporting the feature under certain
 configurations.  For example, the ``aarch64`` CPU feature, which, when
-disabled, enables the optional AArch32 CPU feature, is only supported
-when using the KVM accelerator and when running on a host CPU type that
-supports the feature.  While ``aarch64`` currently only works with KVM,
-it could work with TCG.  CPU features that are specific to KVM are
+disabled, enables the optional AArch32 CPU feature, can only be set to
+``off`` on the TCG and KVM accelerators, and it cannot be set to
+``off`` under KVM unless running on a host CPU type that supports
+running guests in AArch32.
+
+CPU features that are inherently specific to KVM are
 prefixed with "kvm-" and are described in "KVM VCPU Features".
 
 CPU Feature Probing
diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index b683c9551a..6e5212ff6c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1071,6 +1071,11 @@ static inline bool isar_feature_aa64_aa32_el2(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL2) >= 2;
 }
 
+static inline bool isar_feature_aa64_aa32_el3(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64PFR0, EL3) >= 2;
+}
+
 static inline bool isar_feature_aa64_ras(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64PFR0, RAS) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6705ee9db7..9b80dda140 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1244,10 +1244,38 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
      * uniform execution state like do_interrupt.
      */
     if (value == false) {
-        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
-            error_setg(errp, "'aarch64' feature cannot be disabled "
-                             "unless KVM is enabled and 32-bit EL1 "
-                             "is supported");
+        if (kvm_enabled()) {
+            if (!kvm_arm_aarch32_supported()) {
+                error_setg(errp, "'aarch64' feature cannot be disabled for KVM "
+                           "because this host does not support 32-bit EL1");
+                return;
+            }
+        } else if (tcg_enabled()) {
+#ifdef CONFIG_USER_ONLY
+            error_setg(errp, "'aarch64' feature cannot be disabled for "
+                       "usermode emulator qemu-aarch64; use qemu-arm instead");
+            return;
+#else
+            bool aa32_at_highest_el;
+            if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
+                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el3, cpu);
+            } else if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
+                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el2, cpu);
+            } else {
+                aa32_at_highest_el = cpu_isar_feature(aa64_aa32_el1, cpu);
+            }
+
+            if (!aa32_at_highest_el) {
+                error_setg(errp, "'aarch64' feature cannot be disabled for "
+                           "this TCG CPU because it does not support 32-bit "
+                           "execution at its highest implemented exception "
+                           "level");
+                return;
+            }
+#endif
+        } else {
+            error_setg(errp, "'aarch64' feature cannot be disabled for "
+                       "this accelerator");
             return;
         }
         unset_feature(&cpu->env, ARM_FEATURE_AARCH64);
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index bbdd89a81d..cb4d01fd46 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -493,12 +493,8 @@ static void test_query_cpu_model_expansion(const void *data)
         sve_tests_default(qts, "max");
         pauth_tests_default(qts, "max");
 
-        /* Test that features that depend on KVM generate errors without. */
-        assert_error(qts, "max",
-                     "'aarch64' feature cannot be disabled "
-                     "unless KVM is enabled and 32-bit EL1 "
-                     "is supported",
-                     "{ 'aarch64': false }");
+        /* TCG allows us to turn off AArch64 on the 'max' CPU type */
+        assert_set_feature(qts, "max", "aarch64", false);
     }
 
     qtest_quit(qts);
-- 
2.43.0


