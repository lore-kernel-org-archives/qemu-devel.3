Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2554DC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZJC-0003n7-Fn; Tue, 17 Jun 2025 12:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGD-0000mN-PP
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG5-0000ek-Dd
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450dd065828so48835875e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178038; x=1750782838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoMza4IYUrQ4pKhizFEWSlqdn80g7ODuwHDUZB6a5Mc=;
 b=vN0DXITT142R1G1HVYRZagx6SjIaDNtzCoLXWkYwCXFZ7CF3w1mIOYMFawT0JN5zLo
 ui1sOMnHfFb4nz86Ma17pN1K/8Vnv4/4/3q3p/eWe0NYBfXZd9t53E5S1R2EVSZyxIC0
 1Pjme7CMArdwLIl3omtOoTl+iFQG+2BjCO7kpmJnhV7KTVPjY+ae+HHwnW3daAU0ACN/
 64J1KJfgnxv4M7XRa/iD2SQrTvo0B47oXDAbY0mPPl8jnH6s0PD6ovN++RL+KjNbofMy
 SnjohHJdLFm1nILdU7QUIho0ij0Chi3mP7e72UuCdnFvBHURjMXk9bH8YAlCKTkPnAwR
 KdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178038; x=1750782838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoMza4IYUrQ4pKhizFEWSlqdn80g7ODuwHDUZB6a5Mc=;
 b=e/glX/QxJiOxgy1jO7IEnMMycUDMshvYqp1RKNhD4GFwDV94Giwn68TlVTPB/sNXBy
 Bgwq/nOYsPEq+QAA2lhymKWWiMSpZJMuQcZND10472kVR0HRHn3UYvoYFRFEX6FYgRoU
 eXUBE0Vwf5CemQNMlxUrnkmSHkss8dhGvfWu5gC/QGrPVdHgdXdWu439j2c2bHc4ghgd
 9siSeJ0P/anNagxdhwI82rmRLAfUS5sFyyWYKKgsa2akVWVXe5pdD6XwxdxF/gFv28kg
 kXa1S6pqZYNWhFjnbvG/IXaeQP+Z/Poc7YEB93Mk29FU1+UriDe7Og+FSVRV+H8D2/hf
 smGg==
X-Gm-Message-State: AOJu0YxGJ3cbj9iLr8S9I7KOM9BYJbYRhX8fxCm5CBCCGsOx0og2ieyJ
 DI3wNLsM9p/qgmIXx2G0Q9Of6jw+iVqo1Q8ye5Ky/CClniYW+nVTtOjJeJd6PgZZzgU=
X-Gm-Gg: ASbGncuCBipdKuX2glhbt4KTWtpNLeKqc92Y9TdTM2z0EilUHauocbzSeBzlgGtSb6w
 1gJZwj/KDG/4V2LpRZ+3VQzwWKyVoetLXzt1ZQSlJw/Hb0TnN4ABOQlre88trxQWwBe0z/T7Vzl
 HJPba3GcoZ49Pm5F8b+1/ELcrHgGdxqj2r5IooLSinojuhfN+xGgfoDMSIs2d4YYgLR3E+7JXVB
 0jOKTms+Z4lzJ3I6xToec9KEjxxGLIrQGwbPojUdF/AlTUo1PP+2MgEQ7ahI0UBB1hEnVvFk7Ym
 nf2PyDewlw2UdBOgCWF7Nsn/l5a3TSXFIes9HyQgfLdwFmHTv4M04nVHytdvWUA=
X-Google-Smtp-Source: AGHT+IE6pt33ke9xpxkXCz0wErJ6OWj9AV5oeVpKv/9/pglk58bJEG+5/55asfXJBldZuJtVgP7Iyw==
X-Received: by 2002:a05:600c:6095:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-4535627dbe5mr19855865e9.8.1750178038202; 
 Tue, 17 Jun 2025 09:33:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e232e4asm178682015e9.11.2025.06.17.09.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC5DE5F924;
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
Subject: [RFC PATCH 10/11] kvm/arm: implement a basic hypercall handler
Date: Tue, 17 Jun 2025 17:33:50 +0100
Message-ID: <20250617163351.2640572-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

For now just deal with the basic version probe we see during startup.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/kvm.c        | 44 +++++++++++++++++++++++++++++++++++++++++
 target/arm/trace-events |  1 +
 2 files changed, 45 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 0a852af126..1280e2c1e8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1507,6 +1507,43 @@ static int kvm_arm_handle_sysreg_trap(ARMCPU *cpu,
     return -1;
 }
 
+/*
+ * The guest is making a hypercall or firmware call. We can handle a
+ * limited number of them (e.g. PSCI) but we can't emulate a true
+ * firmware. This is an abbreviated version of
+ * kvm_smccc_call_handler() in the kernel and the TCG only arm_handle_psci_call().
+ *
+ * In the SplitAccel case we would be transitioning to execute EL2+
+ * under TCG.
+ */
+static int kvm_arm_handle_hypercall(ARMCPU *cpu,
+                                    int esr_ec)
+{
+    CPUARMState *env = &cpu->env;
+    int32_t ret = 0;
+
+    trace_kvm_hypercall(esr_ec, env->xregs[0]);
+
+    switch (env->xregs[0]) {
+    case QEMU_PSCI_0_2_FN_PSCI_VERSION:
+        ret = QEMU_PSCI_VERSION_1_1;
+        break;
+    case QEMU_PSCI_0_2_FN_MIGRATE_INFO_TYPE:
+        ret = QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED; /* No trusted OS */
+        break;
+    case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
+        ret = QEMU_PSCI_RET_NOT_SUPPORTED;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unhandled hypercall %"PRIx64"\n",
+                      __func__, env->xregs[0]);
+        return -1;
+    }
+
+    env->xregs[0] = ret;
+    return 0;
+}
+
 /**
  * kvm_arm_handle_hard_trap:
  * @cpu: ARMCPU
@@ -1538,6 +1575,13 @@ static int kvm_arm_handle_hard_trap(ARMCPU *cpu,
     switch (esr_ec) {
     case EC_SYSTEMREGISTERTRAP:
         return kvm_arm_handle_sysreg_trap(cpu, esr_iss, elr);
+    case EC_AA32_SVC:
+    case EC_AA32_HVC:
+    case EC_AA32_SMC:
+    case EC_AA64_SVC:
+    case EC_AA64_HVC:
+    case EC_AA64_SMC:
+        return kvm_arm_handle_hypercall(cpu, esr_ec);
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unhandled EC: %x/%x/%x/%d\n",
                 __func__, esr_ec, esr_iss, esr_iss2, esr_il);
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 69bb4d370d..10cdba92a3 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -15,3 +15,4 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 kvm_sysreg_read(const char *name, uint64_t val) "%s => 0x%" PRIx64
 kvm_sysreg_write(const char *name, uint64_t val) "%s <=  0x%" PRIx64
+kvm_hypercall(int ec, uint64_t arg0) "%d: %"PRIx64
-- 
2.47.2


