Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8341BC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbTn-00039R-M6; Fri, 20 Jun 2025 09:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTl-000390-SA
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:25 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTj-0004fH-Mf
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:25 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45310223677so15215415e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424902; x=1751029702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAt1PQLrHnO21M2Y87z2Ba1KRbOWR+1s+ZX+rYgrLRA=;
 b=T+wTcnvzlfqB1H/TlIvqDpxFOwy7x+JdNO8nqiDxTJarKLSYsOIqFLRcbIahgsjUNL
 8ffItHZWkF/q6v912+ttjweTr9DPfPeRvniolpAqUPFkwhhZNIy5GwCC95CgTamEMK0c
 oMCumrLM6W9Ywu+hKVFKZ6qLr+bhq7O5jjH1O805RPfpBWZYh2ru1UbhZifnvKgUcjUm
 X8yTmHok2CA4uWzemUZx7OaE7KfGy+L6RKmO50ClrbfYPwNE7rG4jXZEcecjBTbyX80l
 qrOt7p7H4VeqFxy9Hv38MHNZdWkcpeXPd5VyDtBQxr5AmqtIrS17XopDGNE8Yt6bpb06
 tgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424902; x=1751029702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oAt1PQLrHnO21M2Y87z2Ba1KRbOWR+1s+ZX+rYgrLRA=;
 b=RoMMpMRHWTeR8K3bWxflByvjckLEbs7CLsjm7fvvc2WcxcRG8/ehz9ag5RpxRbb2Bk
 5Ue/nBxY9cpG2u/VhYldTWbXY4b6JB27ooHge6h8QQAbCzInO5YftaKPfOfRWx47upcF
 joHZLUqti+xDiwz5CANlgEfLsfwqRmNpDCZh6aCeiH9NtHKwPBnYfW9ZZ6UU/j/VGsZ7
 /FhBmOBh8Fgpt4CF8TLZlZ3pdV8cwflU7VyyTo4CdUJsOjWpvHMA8pLWkjOP1bKYRmkO
 cwXouF/Kf20tZCIQ4hE7QT+tIGCdR622ll9bWNL4yt1UTKdehzFCsCGawRw8s6idhcNh
 aCZg==
X-Gm-Message-State: AOJu0Yx2Ody9auNlrKH76A5dS8iY4p+CXVXuh4V56kHlSidCis6h7Rqz
 1BF3INcflG0xx+okK4h0j5dTykRP32m+IPTih0k0RHTM/wr0I+cMJswELfpav9Te9eLLBKCujD7
 BseozSpk=
X-Gm-Gg: ASbGncv7PmMOEm2EXsJqX7yENl8YvUwOlm53Xb3ZB0OsSsenEg5dkbUCmF8Dyeae6ur
 b4vkmVQnq8aiMb/3MywhtmZUg3r0ja/JGpBWqZ65AwQ7+d1mMcYsB2aD480urxJZ2iwcRIl6d7g
 4ZIQGtDkt/MYlcZNEcJFwpPeqIsqBza96dtYzz444zkmjwKqYy/RqCgBobesCmbwMM2/yiqJyO+
 QdHp/SGKEqr/b9ZBdZ2Ttg1DxtXY8be9vctbqo79Lgyf6IEm8LRFYnnyGcwi9CKS18Fup+E6t2O
 QSuVNCXjifzLJRHZEbQgLS8AvwJxt4YyhQ0/236ME5VPZrsAdN3gLH0HnnRkuwp49QvhiuNeJsK
 NzdVV5YgDXp0FDEcqEAFGNEwjEZUoo2ZWVtKQ
X-Google-Smtp-Source: AGHT+IEGmchw+a0k0hX0S9KobjryclE57uq2sgKFzkmMvuxn/d4B/I66wfS6mkzaJen5FMifqGqbXw==
X-Received: by 2002:a05:600c:37c5:b0:453:5c30:a1d0 with SMTP id
 5b1f17b1804b1-453659dcd62mr23896155e9.21.1750424899969; 
 Fri, 20 Jun 2025 06:08:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb57fsm25578125e9.1.2025.06.20.06.08.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 12/26] target/arm: Restrict system register properties to
 system binary
Date: Fri, 20 Jun 2025 15:06:55 +0200
Message-ID: <20250620130709.31073-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Do not expose the following system-specific properties on user-mode
binaries:

 - psci-conduit
 - cntfrq (ARM_FEATURE_GENERIC_TIMER)
 - rvbar (ARM_FEATURE_V8)
 - has-mpu (ARM_FEATURE_PMSA)
 - pmsav7-dregion (ARM_FEATURE_PMSA)
 - reset-cbar (ARM_FEATURE_CBAR)
 - reset-hivecs (ARM_FEATURE_M)
 - init-nsvtor (ARM_FEATURE_M)
 - init-svtor (ARM_FEATURE_M_SECURITY)
 - idau (ARM_FEATURE_M_SECURITY)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index eb0639de719..e5b70f5de81 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1500,6 +1500,7 @@ static void arm_cpu_initfn(Object *obj)
  * 0 means "unset, use the default value". That default might vary depending
  * on the CPU type, and is set in the realize fn.
  */
+#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_gt_cntfrq_property =
             DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
 
@@ -1509,7 +1510,6 @@ static const Property arm_cpu_reset_cbar_property =
 static const Property arm_cpu_reset_hivecs_property =
             DEFINE_PROP_BOOL("reset-hivecs", ARMCPU, reset_hivecs, false);
 
-#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
@@ -1532,6 +1532,7 @@ static const Property arm_cpu_has_neon_property =
 static const Property arm_cpu_has_dsp_property =
             DEFINE_PROP_BOOL("dsp", ARMCPU, has_dsp, true);
 
+#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_has_mpu_property =
             DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
 
@@ -1544,6 +1545,7 @@ static const Property arm_cpu_pmsav7_dregion_property =
             DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
+#endif
 
 static bool arm_get_pmu(Object *obj, Error **errp)
 {
@@ -1731,6 +1733,7 @@ static void arm_cpu_post_init(Object *obj)
                                         "Set on/off to enable/disable aarch64 "
                                         "execution state ");
     }
+#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_reset_cbar_property);
@@ -1746,7 +1749,6 @@ static void arm_cpu_post_init(Object *obj)
                                        OBJ_PROP_FLAG_READWRITE);
     }
 
-#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
         /* Add the has_el3 state CPU property only if EL3 is allowed.  This will
          * prevent "has_el3" from existing on CPUs which cannot support EL3.
@@ -1818,6 +1820,7 @@ static void arm_cpu_post_init(Object *obj)
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_dsp_property);
     }
 
+#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property);
         if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
@@ -1854,8 +1857,6 @@ static void arm_cpu_post_init(Object *obj)
                                    &cpu->psci_conduit,
                                    OBJ_PROP_FLAG_READWRITE);
 
-    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
-
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
         qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
     }
@@ -1864,7 +1865,6 @@ static void arm_cpu_post_init(Object *obj)
         kvm_arm_add_vcpu_properties(cpu);
     }
 
-#ifndef CONFIG_USER_ONLY
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) &&
         cpu_isar_feature(aa64_mte, cpu)) {
         object_property_add_link(obj, "tag-memory",
@@ -1882,6 +1882,7 @@ static void arm_cpu_post_init(Object *obj)
         }
     }
 #endif
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_cfgend_property);
 }
 
 static void arm_cpu_finalizefn(Object *obj)
-- 
2.49.0


