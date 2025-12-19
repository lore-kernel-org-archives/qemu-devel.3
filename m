Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE11D78770
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 19:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWfr1-0000lO-1H; Fri, 19 Dec 2025 14:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqZ-0000ct-Bo
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:03 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vWfqX-0006rC-DY
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 14:09:03 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so1602263f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 11:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766171339; x=1766776139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNnO369o5RyODW40YP5PUoZ8MigxvrSBu+tgeyebTyU=;
 b=uCi57RPHJaxATgectNUY9mGSninUKVMOW9uk3FYTOxOIPMQMdacNUn3XujAgg4cQwm
 NjFVuV1/i/LIkmNbZSaU/Wg4RWsRZmF9Ws1BhjcnZBWQnMbBqeOaFuagLaGiYvrV7CC1
 kepTCh2TD7xzpsDrq5nxYxL6jHdq8zFVM6a76v1jkJbwuRLTeJaG6bK3IVXBo0dtFsWk
 DvsNQfDTKANOxZDqIhzPJ/zulogjDb2RRc7KQUJ0hgkYxWsSshm6Ha4MsqLYlATSw1du
 J0tgYvHJTHt0Hd8LT40Mqp+qI6QaBpCZXXH54bQYUmltHXm3WusOilGE6TuF8nNKrIRg
 oGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766171339; x=1766776139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TNnO369o5RyODW40YP5PUoZ8MigxvrSBu+tgeyebTyU=;
 b=Cvi0oRrYSfq0NTVpjyHGrPdTfBPNQDtuEWEonwegaW8nCqQCXbFASPUc2UYtRA+CE6
 +hKenmwlHthLT/hKRIJnkV9zSbcX9HFaUrogr+NmjQYjCuPmcXNE46k8ud+AYQML/ZZq
 PQuoNwVY0x3ZAV4TL7EZUivjXQFP8Ymb5QuBUk4vPRrQ2cHVXWZwa2ofrKGRFNf9OO+7
 VYBKyx0vT+bh/C+W414a9W5J9oRqvFfGE4P5NgVswXyJsgBOXmTtf4UQ7nmZ8VnUfAMP
 REh4KQDPxNIzFzcKIqhjNZzDmfhV9wwxXWRjl4jx3w5Z4aTgGDkob4B0k9WifVQc7LCp
 rOrA==
X-Gm-Message-State: AOJu0YyggXWMKVjDXCknfU6Mm8xAalydEfD19uJ1zKe/PflBto/s6uVV
 evN/2tsPUsM1FHt/wUzrhWJPpR7ZScYQ7Xjot9RUE5HLa3EU9fReYNkpPz0yFx+hB9E=
X-Gm-Gg: AY/fxX46EylDrHaYdo0ax575LUGG311AgaVVOgrMj0D1TE2hYPMprgVkTJ0t8q0ImF4
 88x/8CqgfUCCDfpZLQ6rkNNIQk9+Um1bEqtR1UDDkxCwSmayDGflagFtmXdH/K+48GvHB5oD70e
 qfkCQczvmAiHQcl0SdTVX/8d0uVgi8ukIEyNV2o+9BFNmUcyYNulgikqzz6XXm4IYaN4xDIl3Bu
 EOR5fZx+QgejIXXcHi35zcpgiFbBXpFfc8asODBVV+Z0eGgbcjblNqC+cPnBeAMNmbmXsePh4IX
 +iftj0mPTuR1u+r5Yk1r3+cWZ4Pp8Z5QbcfzG6Diqjn//mGnVymXwMMA+PXiAWuIcY5DUqtn5/M
 VDZJa8wLMDNA9FN3jZlUT3Gvurxhfju0xAPJAt2zFnqMCY7+qKvRvfrjD/kEGTiO04xeX+1vXJk
 BGPKy/8bSqMmc=
X-Google-Smtp-Source: AGHT+IE/djsvq7V5yPEwmnhCaYtBAJh0llME81JdJRIYDw/vscbT8puxC23HWIyG+lk4mLByaL1eLw==
X-Received: by 2002:a05:6000:178c:b0:430:f41f:bd5a with SMTP id
 ffacd0b85a97d-4324e709017mr4626110f8f.57.1766171338905; 
 Fri, 19 Dec 2025 11:08:58 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea2278dsm6612935f8f.18.2025.12.19.11.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 11:08:57 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2298E601D0;
 Fri, 19 Dec 2025 19:08:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alwalid Salama <asalama@qti.qualcomm.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Burton <mburton@qti.qualcomm.com>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 12/12] target/arm: allow gdb to read ARM_CP_NORAW regs
 (!upstream)
Date: Fri, 19 Dec 2025 19:08:49 +0000
Message-ID: <20251219190849.238323-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251219190849.238323-1-alex.bennee@linaro.org>
References: <20251219190849.238323-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Before this we suppress all ARM_CP_NORAW registers being listed under
GDB. This includes useful registers like CurrentEL which gets tagged
as ARM_CP_NO_RAW because it is one of the ARM_CP_SPECIAL_MASK
registers. These are registers TCG can directly compute because we
have the information at compile time but until now with no readfn.

Add a .readfn to return the CurrentEL and then loosen the restrictions
in arm_register_sysreg_for_feature to allow ARM_CP_NORAW registers to
be read if there is a readfn available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250507165840.401623-1-alex.bennee@linaro.org>

---
vRFC
  - this is a useful debugging aid but a bit haphazard for
    up-streaming. See thread comments for details.
---
 target/arm/gdbstub.c |  6 +++++-
 target/arm/helper.c  | 15 ++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 8865f27089d..205bab811da 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -292,7 +292,11 @@ static void arm_register_sysreg_for_feature(gpointer key, gpointer value,
     CPUARMState *env = &cpu->env;
     DynamicGDBFeatureInfo *dyn_feature = &cpu->dyn_sysreg_feature;
 
-    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
+    if (!(ri->type & ARM_CP_NO_GDB)) {
+        /* skip ARM_CP_NO_RAW if there are no helper functions */
+        if ((ri->type & ARM_CP_NO_RAW) && !ri->readfn) {
+            return;
+        }
         if (arm_feature(env, ARM_FEATURE_AARCH64)) {
             if (ri->state == ARM_CP_STATE_AA64) {
                 arm_gen_one_feature_sysreg(&param->builder, dyn_feature,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b8..1fbc45263d5 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3529,6 +3529,17 @@ static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
 }
 #endif
 
+/*
+ * Normally the current_el is known at translation time and we can
+ * emit the result directly in TCG code. However this helper exists
+ * only so we can also expose CURRENTEL to gdb.
+ */
+static uint64_t aa64_currentel_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    int el = arm_current_el(env);
+    return el;
+}
+
 static const ARMCPRegInfo v8_cp_reginfo[] = {
     /*
      * Minimal set of EL0-visible registers. This will need to be expanded
@@ -3567,7 +3578,9 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     },
     { .name = "CURRENTEL", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 4, .crm = 2,
-      .access = PL1_R, .type = ARM_CP_CURRENTEL },
+      .access = PL1_R, .type = ARM_CP_CURRENTEL,
+      .readfn = aa64_currentel_read
+    },
     /*
      * Instruction cache ops. All of these except `IC IVAU` NOP because we
      * don't emulate caches.
-- 
2.47.3


