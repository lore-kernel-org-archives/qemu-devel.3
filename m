Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3E6C71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZIh-0002g2-54; Tue, 17 Jun 2025 12:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGF-0000n8-9S
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:15 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZGC-0000fT-SL
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:34:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so4913276f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178039; x=1750782839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GncEdQO/d7gOZ9LM+QxKenzRx6813cX2TxyJIAl7x3Y=;
 b=lwjeugSjNXojm8tIkAOD2mZRfEj7Ogkbcu/jJWH4hqFjJCL0caFeJctuezT8MUj6dF
 0c1MLdYt4no58+X1dsA4o9r7kuhzkWTZeCUSW5PJUoLjnI4z/U6IjYvI3GNoU/c+ZVMP
 FoD6N9BJDnvxnWst8ah/cmJpp2Mt2HLYFeoqAiDuAzIc4uMwnX+pN4RyGxlZND3gSJwO
 iIhVT4Hdh1gJ/2arD1VnjWx1xC43AdCZ72oqrYTocGM4puug5JqKG3vztUiPCMCuXEWp
 Oo9geWdyTHWfR0zq2Gc4qubeedDW6m9aqsijp5ecTHKTCntAt7FVn5V9hcvaQI31FSSh
 oh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178039; x=1750782839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GncEdQO/d7gOZ9LM+QxKenzRx6813cX2TxyJIAl7x3Y=;
 b=eEgGYSONAd8VlS2REvyzqqGbt4xczU1GgGZM/NotvKwfhM1atbF/DQT152w1G0EEIe
 fPJmV1rDY3Ee9gV9CgrJijMrYEYAeu7NyjyBMDt2k4a6iUAAP4B+1VGQGf8tIjZvLrHh
 yrkAWme4UU5xevGiEdmUvnWqaM1p7WXCmmdCcB5/ds9woLJ+jxaiKvTcp5RUxVdSCQ4J
 fjyU37dsa1VKc5W01z0CEvstER8IaPngm/Wk1XRUUz3gB2gnguVYe2U5w0qfX/xbY4GS
 mVsub3/KX6bWXD8zcEXrfWSYZoRfQVR0cSVMqIcMb6VbrdTfv0Jk6HhHcKMyYsoOPCcq
 1dXg==
X-Gm-Message-State: AOJu0Yynt8byAxnqh2B3BC7g9m/qr7rr9hs8FViqZdGs8vOGq4piGwmT
 bcVq7/ENcNffORFFyig+8JJI0k59MaTtJn8i71EAJiw+INCQAjEAexL8iu8vdd4Pr9Y=
X-Gm-Gg: ASbGnctprAGOG81EaTDpFlL2khrGhbTw22eljeh5tABlYru/woZnKLyje+xjUXRkn0a
 FJMxiDKbTzpBbwtW9QfHj5lPRK5zuj+v2YmoZr9R8kCer75JBZFZ9iBAq/mg8iKhMYrRGKgHlKv
 ZGFHvY0pe7eoLeIoVKlk8rTv+XDDaEJ113HF6KARYSAUmB3yj3yc9B0+KPnd6ThtWIMFTRx4VHx
 vaUc28ZC097DLufJMA1QURNiazE99ygbIaqoqQPzP8bIhgnB9Ql+W4ofE1g8peK0nuhS+BTVIlX
 54+7itsIIsOkwuQhJt5a8bCtlRuyQhSM+v3boKH410a17VKZ711ow9amWCa765U=
X-Google-Smtp-Source: AGHT+IEzrNJfJxccfvZ1/Dv81sv9ibMeIsZbIicjBJbFPPlnMb0UfYqycjSiQbPuRMjeJfXuxbG2YQ==
X-Received: by 2002:a05:6000:400b:b0:3a4:f2ed:217e with SMTP id
 ffacd0b85a97d-3a5723af786mr11907985f8f.42.1750178039291; 
 Tue, 17 Jun 2025 09:33:59 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b090b0sm14359958f8f.46.2025.06.17.09.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 01A2B5F929;
 Tue, 17 Jun 2025 17:33:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 11/11] kvm/arm: implement WFx traps for KVM
Date: Tue, 17 Jun 2025 17:33:51 +0100
Message-ID: <20250617163351.2640572-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

This allows the vCPU guest core to go to sleep on a WFx instruction.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/kvm.c        | 28 ++++++++++++++++++++++++++++
 target/arm/trace-events |  1 +
 2 files changed, 29 insertions(+)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 1280e2c1e8..63ba8573a2 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1544,6 +1544,32 @@ static int kvm_arm_handle_hypercall(ARMCPU *cpu,
     return 0;
 }
 
+/*
+ * It would be perfectly fine to immediately return from any WFE/WFI
+ * trap however that would mean we spend a lot of time bouncing
+ * between the hypervisor and QEMU when things are idle.
+ */
+
+static const char * wfx_insn[] = {
+    "WFI",
+    "WFE",
+    "WFIT",
+    "WFET"
+};
+
+static int kvm_arm_handle_wfx(CPUState *cs, int esr_iss)
+{
+    int ti = extract32(esr_iss, 0, 2);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    trace_kvm_wfx_trap(cs->cpu_index, wfx_insn[ti], env->pc);
+
+    /* stop the CPU, return to the top of the loop */
+    cs->stop = true;
+    return EXCP_YIELD;
+}
+
 /**
  * kvm_arm_handle_hard_trap:
  * @cpu: ARMCPU
@@ -1582,6 +1608,8 @@ static int kvm_arm_handle_hard_trap(ARMCPU *cpu,
     case EC_AA64_HVC:
     case EC_AA64_SMC:
         return kvm_arm_handle_hypercall(cpu, esr_ec);
+    case EC_WFX_TRAP:
+        return kvm_arm_handle_wfx(cs, esr_iss);
     default:
         qemu_log_mask(LOG_UNIMP, "%s: unhandled EC: %x/%x/%x/%d\n",
                 __func__, esr_ec, esr_iss, esr_iss2, esr_il);
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 10cdba92a3..bb02da12ab 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -16,3 +16,4 @@ kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is
 kvm_sysreg_read(const char *name, uint64_t val) "%s => 0x%" PRIx64
 kvm_sysreg_write(const char *name, uint64_t val) "%s <=  0x%" PRIx64
 kvm_hypercall(int ec, uint64_t arg0) "%d: %"PRIx64
+kvm_wfx_trap(int vcpu, const char *insn, uint64_t vaddr) "%d: %s @ 0x%" PRIx64
-- 
2.47.2


