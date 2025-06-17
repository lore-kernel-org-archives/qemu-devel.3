Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93F0C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZHa-0001tP-Ae; Tue, 17 Jun 2025 12:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGC-0000mF-QN
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:10 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG3-0000e4-2K
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso4061571f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178037; x=1750782837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=08AiNc4t9QnXpXVjsIzl22ewoa/Tdv5ZaJHW+qjaXxo=;
 b=dZ2Xvev7DErfPQpq1ef2zHiuMhYP3G4/18/9sV5vMq5nfEP29ytS2gtR4xmZGijIfK
 WZJZDFWGxEVwjDGsEMVEWegCa4h2MzWnCgzHCjU5WAckF/PpcqArWG4RtKuv+Iu83SWN
 xaOQs6ePl4xcmua/c2iWPi5gUOClCJjaqENd+KCROXuX/MWJzy56OjMnNsODNp09xyFo
 6Kf2jlry3SgqM1Fh3s+Cg77KSbBAnjnxX0Xhm9euQ13uhMWJJfSwv/irULrSZc+vwMAB
 Hl/eD6p//HK8JP9Ky/PEvKScHeP6n4LSydOh+n4nh22N8kE0CinRDPiWxEDbyLYN0wyW
 XNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178037; x=1750782837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=08AiNc4t9QnXpXVjsIzl22ewoa/Tdv5ZaJHW+qjaXxo=;
 b=inmYPsuuj8bjqnRHeODPeKHD9WOGI1V9ReQY/CdiXRTLQGCobuIIIs1jRcMdMazn1V
 aLNkN+qB7WJqXl6cjK2QqhCDQiHOKWIiSFqZTpdYn77SGjwS/qHZTESvzF1zNpDw2cl3
 SLC4CnVMSbUjcpwdvDjoVV3ZVdCQVrtxTVdzvmte2UFsHyPll8jM04oQKEfrwlL7mfwQ
 WvVbo5gewaZbNFOj21I9DjafEIcTQYu0ho7aBBEcZvN1avYmHZ2ARoawELyfH0uDCJv3
 +9gT0ZjPIoP6TVaVpTlQiDWxRsZ3dyYJ/Sx73nulqD0on1J5woy27PRrt1iwRlxSWHwi
 eQVg==
X-Gm-Message-State: AOJu0YwZykp3b4jpdFjt+YEYRlWIFiqBR1W52ecTiRc7xbKDrI8dvF/e
 10646YOFCZn5HIHGA/YyDA1Cmt2NIkRn6QoDFA9VoPpHN96zCuVUS2SCPZMIGjBYeXY=
X-Gm-Gg: ASbGncvoULdG8lxBXdWN9oYv9VQPqhF+0iuVGZF8hPpO112R8F4mHujyselhm5fChCR
 YB8J5ChK3xs7n4HJ0f9qDR6g3Yl1wZQ4L2OaUJDQxCOdNAubn42tjUoNlD1XPako34TcGv6wtZz
 2/IN2YBjWPnQMHX0EFPf1yEs5qbt62g4dNzcb9su4rjLmMXCh/c8lt0QyPiT6DEh/luNv9JZTtF
 Kwd1bnDEpx0KMJvCvohId27VKRikqXKPNysoCDdbn1UxtVx2D+Bvma0GHCDcGH1DkZZkw6A88On
 gzIxCI6IGEpsTBgAArcTqzignXgycZVO1LVBaSigzPV/XXGUs61DtIAqHRWhe3Y=
X-Google-Smtp-Source: AGHT+IEN9d1okWsq/8zsxuLsJHKVkJr9o41irpI2tw2DJJ8y8sNzt8REZAmA1XvhJWVvCccTBndiHg==
X-Received: by 2002:a05:6000:708:b0:3a5:5278:e635 with SMTP id
 ffacd0b85a97d-3a572367577mr10901001f8f.3.1750178037072; 
 Tue, 17 Jun 2025 09:33:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a68b0esm14233217f8f.29.2025.06.17.09.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A920F5F914;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 08/11] kvm/arm: plumb in a basic trap harder handler
Date: Tue, 17 Jun 2025 17:33:48 +0100
Message-ID: <20250617163351.2640572-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently we do nothing but report we don't handle anything and let
KVM come to a halt.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h |  4 ++++
 target/arm/kvm-stub.c |  5 +++++
 target/arm/kvm.c      | 44 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 3244e0740d..29b95bdd36 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -88,6 +88,10 @@ typedef enum {
 #define ARM_EL_ISV_SHIFT 24
 #define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
 #define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
+#define ARM_EL_ISS_SHIFT 0
+#define ARM_EL_ISS_LENGTH 25
+#define ARM_EL_ISS2_SHIFT 32
+#define ARM_EL_ISS2_LENGTH 24
 
 /* In the Data Abort syndrome */
 #define ARM_EL_VNCR (1 << 13)
diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 34e57fab01..765efb1848 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -60,6 +60,11 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+int kvm_arm_get_type(MachineState *ms)
+{
+    g_assert_not_reached();
+}
+
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 {
     g_assert_not_reached();
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c5374d12cf..f2255cfdc8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1414,6 +1414,43 @@ static bool kvm_arm_handle_debug(ARMCPU *cpu,
     return false;
 }
 
+/**
+ * kvm_arm_handle_hard_trap:
+ * @cpu: ARMCPU
+ * @esr: full exception state register
+ * @elr: exception link return address
+ * @far: fault address (if used)
+ *
+ * Returns: 0 if the exception has been handled, < 0 otherwise
+ */
+static int kvm_arm_handle_hard_trap(ARMCPU *cpu,
+                                    uint64_t esr,
+                                    uint64_t elr,
+                                    uint64_t far)
+{
+    CPUState *cs = CPU(cpu);
+    int esr_ec = extract64(esr, ARM_EL_EC_SHIFT, ARM_EL_EC_LENGTH);
+    int esr_iss = extract64(esr, ARM_EL_ISS_SHIFT, ARM_EL_ISS_LENGTH);
+    int esr_iss2 = extract64(esr, ARM_EL_ISS2_SHIFT, ARM_EL_ISS2_LENGTH);
+    int esr_il = extract64(esr, ARM_EL_IL_SHIFT, 1);
+
+    /*
+     * Ensure register state is synchronised
+     *
+     * This sets vcpu->vcpu_dirty which should ensure the registers
+     * are synced back to KVM before we restart.
+     */
+    kvm_cpu_synchronize_state(cs);
+
+    switch (esr_ec) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unhandled EC: %x/%x/%x/%d\n",
+                __func__, esr_ec, esr_iss, esr_iss2, esr_il);
+        return -1;
+    }
+}
+
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1430,9 +1467,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_arm_handle_dabt_nisv(cpu, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
+    case KVM_EXIT_ARM_TRAP_HARDER:
+        ret = kvm_arm_handle_hard_trap(cpu,
+                                       run->arm_trap_harder.esr,
+                                       run->arm_trap_harder.elr,
+                                       run->arm_trap_harder.far);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
+        ret = -1;
         break;
     }
     return ret;
-- 
2.47.2


