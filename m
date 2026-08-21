Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9610C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0L-00064d-Lv; Fri, 21 Aug 2026 07:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0J-000638-MY
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0H-0007GB-66
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:01:42 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so6726855e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310100; x=1787914900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lAm3CoHp6tv6I9Em/00oGQVINrsk1DrCP55iFmtTbGM=;
 b=KcN0QwjypYbmmeFCb2iTm1xz4rTzkJ8BFp4DclPuplitmWjz3uqQFkfcHVf0b2kXpC
 qIBzcvBmU+D4fniPt8k8Y8bemIxKcGTJLsqMxyTPp5l9Eq4sfO4YvKGZ1whBs5Jbu6UK
 O/CapSBXDou1U0YpONvYiuvTEgzjotArvHa94hAnf9sDM5htbrCWkZvJp3mTGYKp6gY1
 DamGyIbRlXLbKVUb45MSEu2hjh2wBdaBQ4NRd8IA5n0Ib4eYi9ljUX5MH0ehp3AzpbKj
 XDryeMnswoiRqImwQ7xNWPNwgle8u5gBKkRWGeyZ/jGjc2vchCqDdY1NObGgpjbjE2sF
 HvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310100; x=1787914900;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lAm3CoHp6tv6I9Em/00oGQVINrsk1DrCP55iFmtTbGM=;
 b=WrHxIr8yMAi53dJ4aOp4HF195BTp10KCN70k442+BwqJ028hxSeVRWRuBUrKyGOHC4
 WjBE5cPinLBlHIH943JP1joJjJWIanH1qyJ0qSww9LkFB7eyVE96iGZ/IzxXNSyK3E2y
 LvA49qT7rm8F0yh3apYyPhOB4KnH7BDwEWhGuWvoyVTeKVsrVg/M7GlIrzVzGU7w2um8
 Wwc3FNpG+enJN+nUK3MCZ/JPdkZSFaDVmif/D+VJNaGuw1cCB5JbrxX+HxU6BM+kbWjA
 Ok1c0uFZXhqaxoR99AmFIv+6wXZW8qDXTeSqgGJ2sXhP4JqMGVPuGeonRYkGIzP6UwQN
 pxWA==
X-Gm-Message-State: AOJu0YwkQ+wlq7fg6zQZXy0vCnqbdJYNeduEBYWoANV8IdT/J+R6G6cB
 RF2VlE9nP04FuXFNJSqyTH1piG7a64mia7jW/7CrM/GxfIlwSAiVz8q4+swvcfJH0py3cySdTtV
 04kd9
X-Gm-Gg: AR+sD13GCuwgNhGJ1ZbXAz0fuX77rW1WFznFJrEhN5+JAqQMWIVaiuOH2phXKYTeNrt
 J2xSyyWUF/WeMswguzYerw7+EO45/wigh0M0tWPg/aWknILc9gkOBaTiQ5WiH+K27figcyXX2bO
 NjrQxBI46ZAqAd9BbeNCIkXmyT9jNEplOBgSWfP1jN0OwboNnsHflWqI70KuFFejsOc0xwdH/6T
 3L1exqooI/KJg3xcaW7S5raDhIfqIYjwFgGLAtxVzwMBXHOSVIXcfG6U9YD4u+PD9UceeYQMSzS
 0JXRCj6ubcBN9lZXmX57IQ9stzpB8XoRRIuvYlu35GCG/IsYMmrJswCBvD5zp5zZI+uRmq0UQBh
 6dnZnGcL5p9beMUGSg9CtDPtm5yOh44GoeYaprvYGBEW5cIsQrd1hRq4pJ6T9PZsUAwoGDzRpEu
 uk4DHaizYEHUf7/Hs+iUuaDuULWEUJUr+l/idbLSQVF2cpoOVcUENQ66y2An+GiE08GEJUqvD4y
 SBHU667E3yWrbstpKEO9/HmRV8Meqa6rvjRRXVBbl4nhCEaWKtj/0cVWcWrdQhVANtpZg==
X-Received: by 2002:a05:600c:1d1a:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-499b8303b86mr76755995e9.4.1787310099717; 
 Fri, 21 Aug 2026 04:01:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/43] target/arm: Split out aarch32_max_tcg_init
Date: Fri, 21 Aug 2026 12:00:26 +0100
Message-ID: <20260821110101.3971391-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Message-id: 20260812204435.295067-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c   | 16 +---------------
 target/arm/internals.h |  1 +
 target/arm/tcg/cpu32.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 93f24114a52..7df7d015a91 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -202,22 +202,8 @@ static void cpu_max_initfn(Object *obj)
     }
 
     if (tcg_enabled()) {
-        /*
-         * '-cpu max' for TCG: we currently do this as
-         * "A57 with extra things"
-         */
         if (!aarch64_enabled) {
-            aarch64_aa32_a57_init(cpu, false);
-            aa32_max_features(cpu);
-#ifdef CONFIG_USER_ONLY
-            /*
-             * Break with true ARMv8 and add back old-style VFP short-vector
-             * support. Only do this for user-mode, where -cpu max is the default,
-             * so that older v6 and v7 programs are more likely to work without
-             * adjustment.
-             */
-            cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
-#endif
+            aarch32_max_tcg_init(cpu);
         } else {
             aarch64_max_tcg_initfn(obj);
         }
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5e7f41a50d1..f6b4e173a54 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1838,6 +1838,7 @@ uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure,
 bool el_is_in_host(CPUARMState *env, int el);
 
 void aa32_max_features(ARMCPU *cpu);
+void aarch32_max_tcg_init(ARMCPU *cpu);
 int exception_target_el(CPUARMState *env);
 bool arm_singlestep_active(CPUARMState *env);
 bool arm_generate_debug_exceptions(CPUARMState *env);
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 8220d785f5b..e1ff074b470 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -748,3 +748,18 @@ static void arm_tcg_cpu_register_types(void)
 type_init(arm_tcg_cpu_register_types)
 
 #endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
+
+void aarch32_max_tcg_init(ARMCPU *cpu)
+{
+    aarch64_aa32_a57_init(cpu, false);
+    aa32_max_features(cpu);
+#ifdef CONFIG_USER_ONLY
+    /*
+     * Break with true ARMv8 and add back old-style VFP short-vector
+     * support. Only do this for user-mode, where -cpu max is the default,
+     * so that older v6 and v7 programs are more likely to work without
+     * adjustment.
+     */
+    cpu->isar.mvfr0 = FIELD_DP32(cpu->isar.mvfr0, MVFR0, FPSHVEC, 1);
+#endif
+}
-- 
2.43.0


