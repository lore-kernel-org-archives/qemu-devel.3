Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B13CD4F25
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIdu-0005vN-UC; Sat, 16 May 2026 13:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdq-0005cG-PA
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:35 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdp-0008Ow-70
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:34 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so4346435e9.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951851; x=1779556651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PWZdLVhlhSLtHCNbbyN0ZgO/iZgjO8xlliAMjKdmLuw=;
 b=BsSK19C+ZMaM1rn5nUSGEevXEmn2h+INVQHIu5S0u+jIf6X7xL314mS395S+Av0oyN
 Mp++2Auxm7rQJsnoPysmdFtEUtlS/Qrz563Rw2bZgR0ODPugXMk/SY0xnsn4br712yH1
 N11Rgb6HfdQLop1QxqoKZmMnpuPVb5S63OI/8VlqT0VDjdMIPo6gIKjfLe5texsyOU+d
 nLP4oE1FKUMU5HWa0IMrhHDobDLWQVeOsp9e/S+XXjeQ+RCZA53dbF3eJAVKFclsCVPX
 v67qzCoKeGP+A2b2cqOmcrR/dZypPhmq+9zk63ItQ+4eTFlbrayhcH4qhV8/J8DPnBil
 yATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951851; x=1779556651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PWZdLVhlhSLtHCNbbyN0ZgO/iZgjO8xlliAMjKdmLuw=;
 b=IxhASFxTcXLTk7tkE+ckGsYQ2O56hlNtVPqZsilZK6S5HtMuW+3KhKpWkPmruonn1a
 cjUUphyO3KoeHZw373gIhXSOlHxgveNA1L93zfBQO03wYIHa0HnMvfEtbDzZVGgmV2Li
 CTYf7GopHDWpP9m4v9fo4SoGaPy+DV7A49UKkSaBPdrsDUzNv/6lwFLXtypdo1fEBkMg
 YWeDhtvK5My57Zn/cJAod2qPnVc2SnQ8p2bm15dFB8/Pq+GPiGnxlqgV++wQ7G9ub5p0
 jpYixZbSmiI8IhorTZh+BA/Z4Jdfn6yGo7CkAz3d6CQ34BGM1Or6Mu4DNQpeO9NJgrXg
 ev0Q==
X-Gm-Message-State: AOJu0YyU3RfjFP5COUGbENpZ3gGOVXc2UFrSfe0LImIDmkBVzX+94fCq
 O798cKFxN3MWbwPIFL7IYNtdm5DYql2X1srTd7C+qD5890drHkXYkw1oYKx91gYVJkehyoVv0Wk
 5VP1mYgk=
X-Gm-Gg: Acq92OHTrkYAC0p4ysHhX7sGXbGKeWJ8WhaVOnpIiYZl/z+7IX0gGzpik7Bc+d7CzyR
 vCxmLt4B//ZpT7E3trhzNagynDBctHQN65LZb95xMr+TWBmqz2Jmh3zegNogmVx3nksKqyudXJ5
 yy23juXPtczQIMUlGUGEYWMuvhD+rIXypPoI0NcRv1xvCn3W2VvITpYp0OOyEQuqIY8t68e93EC
 875CRIlxwqnaP7/q51DK9E0em1YNsMbef3YKO9zRy3OSd77KT06msOQaBXObXfHo0yV4emQz2dC
 +RfLLfc6b+jBSIQnP2n+pin4W1lmRboF23/vhg9ZYasLiA6EItlScgN/tXLito+IR3QY+fE8tgP
 GkqVrrbomoiMSrBxQVBA1UrTebMT2O4pLU7A1JVT04lwUQu6P8xasy//RiSgwgnq9lSg07B32pO
 gdooZMK+Fma8dM6xbELgsBJTkOvXZZ4tr4nvOib4gCDAc8DQ3PDoV2M/hJrU4sUATLAwyLfhVK
X-Received: by 2002:a05:600c:4fcb:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-48fe6613ab3mr115062185e9.28.1778951851393; 
 Sat, 16 May 2026 10:17:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c833fcsm138060665e9.2.2026.05.16.10.17.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:17:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v7 17/21] target/arm: Factor aarch64_aa32_a57_init() out
Date: Sat, 16 May 2026 19:15:19 +0200
Message-ID: <20260516171524.19184-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

In order to make the following commit easier to review,
factor aarch64_aa32_a57_init() out of aarch64_a57_initfn()
as a preliminary step. We only add a %aa32_only argument
to restrict AArch64 features.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/arm/cpu64.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 7b2f09cf8ec..7dce17fdb20 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -686,17 +686,20 @@ void aarch64_cpu_lpa2_finalize(ARMCPU *cpu, Error **errp)
     SET_IDREG(&cpu->isar, ID_AA64MMFR0, t);
 }
 
-static void aarch64_a57_initfn(Object *obj)
+static void aarch64_aa32_a57_init(Object *obj, bool aa32_only)
 {
     ARMCPU *cpu = ARM_CPU(obj);
     ARMISARegisters *isar = &cpu->isar;
+    const bool aarch64_enabled = !aa32_only;
 
     cpu->dtb_compatible = "arm,cortex-a57";
     set_feature(&cpu->env, ARM_FEATURE_V8);
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER);
     set_feature(&cpu->env, ARM_FEATURE_BACKCOMPAT_CNTFRQ);
-    set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    if (aarch64_enabled) {
+        set_feature(&cpu->env, ARM_FEATURE_AARCH64);
+    }
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_EL2);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
@@ -727,10 +730,12 @@ static void aarch64_a57_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00011142);
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
-    SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
-    SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
-    SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
-    SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    if (aarch64_enabled) {
+        SET_IDREG(isar, ID_AA64PFR0, 0x00002222);
+        SET_IDREG(isar, ID_AA64DFR0, 0x10305106);
+        SET_IDREG(isar, ID_AA64ISAR0, 0x00011120);
+        SET_IDREG(isar, ID_AA64MMFR0, 0x00001124);
+    }
     cpu->isar.dbgdidr = 0x3516d000;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
@@ -742,14 +747,21 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 2048KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    set_dczid_bs(cpu, 4); /* 64 bytes */
-    cpu->gic_num_lrs = 4;
-    cpu->gic_vpribits = 5;
-    cpu->gic_vprebits = 5;
-    cpu->gic_pribits = 5;
+    if (aarch64_enabled) {
+        set_dczid_bs(cpu, 4); /* 64 bytes */
+        cpu->gic_num_lrs = 4;
+        cpu->gic_vpribits = 5;
+        cpu->gic_vprebits = 5;
+        cpu->gic_pribits = 5;
+    }
     define_cortex_a72_a57_a53_cp_reginfo(cpu);
 }
 
+static void aarch64_a57_initfn(Object *obj)
+{
+    aarch64_aa32_a57_init(obj, false);
+}
+
 static void aarch64_a53_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -886,7 +898,7 @@ static void aarch64_max_initfn(Object *obj)
     }
 
     if (tcg_enabled() || qtest_enabled()) {
-        aarch64_a57_initfn(obj);
+        aarch64_aa32_a57_init(obj, false);
     }
 
     /* '-cpu max' for TCG: we currently do this as "A57 with extra things" */
-- 
2.53.0


