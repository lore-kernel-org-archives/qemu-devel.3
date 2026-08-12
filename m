Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D820C5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFpC-00043q-CL; Wed, 12 Aug 2026 16:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFoz-0003nv-D7
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:45:12 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuFov-0002J5-C9
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:45:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84e0688b7e8so29359b3a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786567503; x=1787172303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bbExbS5TImnPXe0ZEmZGgBmLPlCUZJyNs5IyQcxmzCQ=;
 b=M32uyqeYlGK0N6jQ5Xm6QaChdXpYPi2XOY8QX7zL+bJ7UJ6SpgTv2YWUWea/Z3ppgg
 xEpecLz37mQU+O5VWb6KrK9Q8nkPtdpSBfk2CeJUglljwmkAq+1mZunlvgSiNIyHuQ2O
 OSR1aol2hi4A5M1PG5HX9K6NJEdRqrlByOUgNdi7osCJbbLNDjVG20aGtp6xPsxgiEjB
 CGvd3Ghu2c31PDForTOJ71ejFZ68lyG/0eQssFmphTOA4elqCrS8ZhcAhjYapJP9U9dz
 6iD13CWdx03omvDyPjesxljSbmfMm4I+nF9ucxaMkOpMWL/VOv4HHUW8Wwr+7M0XQslS
 1cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567503; x=1787172303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bbExbS5TImnPXe0ZEmZGgBmLPlCUZJyNs5IyQcxmzCQ=;
 b=QF/lIN5aCwRmfP0Z/ioouw0YuuvbC4pPdWQ4QzHHKxSnT9KU6TX9opg/XtBQHCx/eC
 DtNuRaLwgkqLnh8dhFutEPHOKZ9KbBHbWx6j2vPKPlOsHGlR5JzwzfwjbSLQjQVFEc1y
 NGIPNoJjXq6DRc6Wc5dK1dPME9N8SddSXzIIddbqIMOQqTCymuNPPkCGnVITR9O/4KNO
 XUNd9nWBvOpGCuTvOSoCNnaAVwQ9IF09NhJ2HOgn4JnACSSzz1ZUswPSXui2yg91fhms
 VJ6BpHJGzjEq4b7/VsIeSg06DXfYw70ixuE1SksDnnMFn2l0MO5mzpr7MIoRb35Xd4K8
 h3rA==
X-Gm-Message-State: AOJu0Yz6PN6gvvehnP76x0tUR+n73OpALx9GCmVtjyf9sn/YzoQp6bLl
 gtjoDPxj2EmjMmKF869f8BIZbliL16l+1jnTByew0/SfjEljl41Rdi06zZa1ujrT5NNqLtPvRo9
 9S/4z
X-Gm-Gg: AR+sD11xvKbu5YuIx1dSIbcGm17gRuwNgQvQIY5NeO9zupsC+GheLk2AtcZxdw8ZWEo
 OJdNbdWynUf+ArcZQ8KIDmCJCLW+eqpXw92FFbCfNMTkmDAP6vLkWLfNm/YHzjt/FJaqAnUX2Yb
 w4e0hUOAca2qDcq8C2a5n5NLYVYNpnkvObvACqyAQ+XDlvwWJlHrWrIhU7a58Fi02TX0dWn93hj
 UmdrMGshlk64vd5syHeuzxUogZU4aqaBAEG0jERaJRuMTrUbadVyUVK2h0ZqZOS99K0fE6VNi6A
 ZLbyAT6BfJng0ULdjFlGAr7KDW9ZevpaB4b94hQyuzKHgz7f7uADro+I8alFsjoO92MyV8SEaLq
 gISTV0uAnIt4ngutJ0Dw6Zke8oc7ravmGEvEa0WVqbgUZCQi0+mBSJKcKsuHU0sJXLN0KghvGJh
 V1l4Km7yBeMat8NN/4nA574gCaEKLesb1DMGBaODxHaGEz7VThcAojP3aWOahE3Jki6kzshfXUW
 yexGIUFwrhyXvLqgKR6QgFHreNkKMxX
X-Received: by 2002:a05:6a00:3907:b0:847:99bb:b6d8 with SMTP id
 d2e1a72fcca58-84fc745d499mr532756b3a.26.1786567483877; 
 Wed, 12 Aug 2026 13:44:43 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fc4787325sm125308b3a.23.2026.08.12.13.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 05/10] target/arm: Split out aarch32_max_tcg_init
Date: Wed, 12 Aug 2026 13:44:30 -0700
Message-ID: <20260812204435.295067-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204435.295067-1-richard.henderson@linaro.org>
References: <20260812204435.295067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  1 +
 target/arm/cpu-max.c   | 16 +---------------
 target/arm/tcg/cpu32.c | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5e7f41a50d..f6b4e173a5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1838,6 +1838,7 @@ uint32_t *arm_v7m_get_sp_ptr(CPUARMState *env, bool secure,
 bool el_is_in_host(CPUARMState *env, int el);
 
 void aa32_max_features(ARMCPU *cpu);
+void aarch32_max_tcg_init(ARMCPU *cpu);
 int exception_target_el(CPUARMState *env);
 bool arm_singlestep_active(CPUARMState *env);
 bool arm_generate_debug_exceptions(CPUARMState *env);
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 93f24114a5..7df7d015a9 100644
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
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 8220d785f5..e1ff074b47 100644
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


