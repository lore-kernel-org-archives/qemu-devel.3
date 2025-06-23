Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD9C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg9B-0001SR-Jx; Mon, 23 Jun 2025 08:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg99-0001Rq-U9
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg96-0000XB-33
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so27903435e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681169; x=1751285969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyHQEfn6inWyZRMUVI/8b1HegzN318xDx/IKxFDD3c0=;
 b=w+7lIDEXJJ9rJK521KDHTfNfEQCRfzYIOg0mPz4rY2TY18C/BFb7DfVyy66J0wWIAk
 slg3m0mzrjyC3ehYq9COjUU+GhkH3/ohsHjj16twbAVqQvwjLHTpJ9GgbszNvtRd5T4x
 4Nm2C0qd8Be3E2lDqt6lL696sxAwQlckjnw2aTAP8IgNiPZFBVKovtHZDP9Y+UaWLMTh
 iHKUht+I/WVX1IzPqCaP1lR7bG7WwpZ8Pgkuhj+WQglGBHxOOnh4K3Lj96kItKBXbTXy
 XI9xdpmacdfpuEb4/tfC+VZ9zj6kVqSOFtv4CFhGLnkMWiJuRN+zRt3FD9u50Hb7wjUS
 VTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681169; x=1751285969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyHQEfn6inWyZRMUVI/8b1HegzN318xDx/IKxFDD3c0=;
 b=JqHdQCURgkUjeVr2HI38LjZ7gqw3yDSMkCEMECFhGv0a6EfMGEc5fxmSUzyfAAGZpq
 ctHxY65Rqe06Ua4YoArMcKTRmm2n/cOAEkVI+lCsk8feTih6nGoOD6zgn61Kuoq+dOkU
 ce3uGOzH9pzcGM2/RZ7w5/XyqcoDKw69TxkCsxKG0kip8Xi1rjVRlS+iJD+dPA1TIXV6
 Bkr4qkSKJIdVnnAGwzuEVvUFMHFOTmSOmT9d3GpMojEUJsOEm5L0AQYK46cs1Qxds6iF
 Y/udQ+a3ZAamNKJ70gKt0N1Xk7AVDvQfSYGIYMcGoYgkuuzACOylZqcSsn8pCd/125mZ
 cMWQ==
X-Gm-Message-State: AOJu0Yzi5Pdqvr5WhJzVoEZd0w1pM15dLbTYgO4pe5nrCep1XZdzblBn
 /2RoB500JRp+uU2JdkKiUyzclvj2YVsu61mW26VH7kfPaExG+b6SzPWXIfeCApr7ITc4hxZvrK3
 iL84Y
X-Gm-Gg: ASbGncvnjSeWTaNowqatd4xGbrriW7a/J9g2yQknfXfZ5Moug79mjs/1q/Q5hk4nXxL
 suQdnKW5LFMJ8xzeZfm3T7zt/VG1p3fPWNfGfRXzIz9y8Y/jwxllCs51/UUjbBATCW2o8px1Ma+
 8x0Ug95J07X2e/DVrip4r7aRzKpOFOS/hqGLqTnFSSzVNpcOrGPUSH75e2R4weKjM0vBo8fg3q7
 W2AYuvPeVWOzYj8YGwNc5WjipVkzaexrcCdG2qgBPhJFNwlxk5KaP2y8zdndoy3xb2CVgePV8eL
 G0KjCZ+2GiS/Psxi9RY+9xZlFAu3TE/sY1sGdVeeJ6tL1WhtRwlmp5c1gFm/39l3pzi//RhRfju
 VJgiEeihgrZKh7I32LcBI8i0u06uLKVuOIrx9
X-Google-Smtp-Source: AGHT+IG0jiUUTmeqAWUri6/ZJ6x4DVSBOfaEpfSa25gPf14UgQYKRFy2gTrbK23eOovRBdpzASNZQQ==
X-Received: by 2002:a05:6000:1a8f:b0:3a5:2d42:aa17 with SMTP id
 ffacd0b85a97d-3a6d12d53e2mr9880614f8f.31.1750681168848; 
 Mon, 23 Jun 2025 05:19:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd7aasm108552565e9.20.2025.06.23.05.19.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 08/26] target/arm/hvf: Log $pc in hvf_unknown_hvc() trace
 event
Date: Mon, 23 Jun 2025 14:18:27 +0200
Message-ID: <20250623121845.7214-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Tracing $PC for unknown HVC instructions to not have to
look at the disassembled flow of instructions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c        | 4 ++--
 target/arm/hvf/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index cc5bbc155d2..d4c58516e8b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2071,12 +2071,12 @@ int hvf_vcpu_exec(CPUState *cpu)
         cpu_synchronize_state(cpu);
         if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
             if (!hvf_handle_psci_call(cpu)) {
-                trace_hvf_unknown_hvc(env->xregs[0]);
+                trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
         } else {
-            trace_hvf_unknown_hvc(env->xregs[0]);
+            trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized());
         }
         break;
diff --git a/target/arm/hvf/trace-events b/target/arm/hvf/trace-events
index a4870e0a5c4..b49746f28d1 100644
--- a/target/arm/hvf/trace-events
+++ b/target/arm/hvf/trace-events
@@ -5,10 +5,10 @@ hvf_inject_irq(void) "injecting IRQ"
 hvf_data_abort(uint64_t pc, uint64_t va, uint64_t pa, bool isv, bool iswrite, bool s1ptw, uint32_t len, uint32_t srt) "data abort: [pc=0x%"PRIx64" va=0x%016"PRIx64" pa=0x%016"PRIx64" isv=%d iswrite=%d s1ptw=%d len=%d srt=%d]"
 hvf_sysreg_read(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg read 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d) = 0x%016"PRIx64
 hvf_sysreg_write(uint32_t reg, uint32_t op0, uint32_t op1, uint32_t crn, uint32_t crm, uint32_t op2, uint64_t val) "sysreg write 0x%08x (op0=%d op1=%d crn=%d crm=%d op2=%d, val=0x%016"PRIx64")"
-hvf_unknown_hvc(uint64_t x0) "unknown HVC! 0x%016"PRIx64
+hvf_unknown_hvc(uint64_t pc, uint64_t x0) "pc=0x%"PRIx64" unknown HVC! 0x%016"PRIx64
 hvf_unknown_smc(uint64_t x0) "unknown SMC! 0x%016"PRIx64
 hvf_exit(uint64_t syndrome, uint32_t ec, uint64_t pc) "exit: 0x%"PRIx64" [ec=0x%x pc=0x%"PRIx64"]"
-hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpu=0x%x"
+hvf_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
 hvf_vgic_write(const char *name, uint64_t val) "vgic write to %s [val=0x%016"PRIx64"]"
 hvf_vgic_read(const char *name, uint64_t val) "vgic read from %s [val=0x%016"PRIx64"]"
 hvf_illegal_guest_state(void) "HV_ILLEGAL_GUEST_STATE"
-- 
2.49.0


