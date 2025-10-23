Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A662CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtn6-0006aF-9l; Thu, 23 Oct 2025 07:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmf-00060N-PJ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtmd-00022Y-Cr
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:47:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4710683a644so5866785e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220025; x=1761824825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NgDIx1+WcFxzjLnk5TEpP+lXGB26NdtGHoTw7EUXsBM=;
 b=erwlYu3tgYA8w7VxSgXk++1155piI7lpUKHP3cSTNhOPfC4dUf3g5XZi7n8oEFSPy4
 NEA/lDxgqMr3JXsRH5s81RAsF6bMr2/FxZm8yHeTXW8ydlwCxtYGVXTjBgDpPYR7W9g+
 ywkvQVu2lCYHy9xT4coyFLEP2dqlTlP0IC/41Vs6Vw5iTr9XfN0xyKbPBaYGYMd3Xe4g
 6Cdg1TR9manU4d8njmJkQ+WvQ+j99yaPZXGKcEnXoGplXqtjJPTA+shEg6kqf2E84gVt
 G7H0VU5HwZfSlFy7aH6LjaujkvATL/SHbLrm+1oCCbC/lXsCd11Rai7jINu/C3VqLAS9
 n43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220025; x=1761824825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NgDIx1+WcFxzjLnk5TEpP+lXGB26NdtGHoTw7EUXsBM=;
 b=LlNa/kj3730HWNJiVC80bFXkqTx83eA2tJzhsDj4sMMRWr3TxXUKjzr4ZIzAFwxApw
 tssda0/nBxGyzQNeRUwSAZEAow+c190OtcuLlQMLhZ3MZnHE55mu9mYRyknXQh7ACQ4T
 SOrlJEwvhEXsEfjJifUu16AKLk48LRttrDPm6j7mcg+2RRQIWKm7Kjnbgv3ZG2aQQwkY
 Me6n438FUHmjTE52QEoRhb1wxT523VrALiQtIKRhB2x2BEWx0W2YVXHNN3VWNB9bSpKr
 0cscq4UV9DUDI+HMNRKLFFjKSRqcqI3qkAF7mSWkekfli8bPmzDL3gUaBth59tjAETQf
 JYWw==
X-Gm-Message-State: AOJu0YxxqRCl+GUW2WCuzEjyNBo7Q8YpPdbEe0iv54jUpWXq7lFzJrBm
 /IeevENmSMJTY75pvT513L6DabnVV5O5537DCS+wTKA0zHVwsItqMxPLD2bSXreJU8d1Vs+9GMg
 oNtH/32g=
X-Gm-Gg: ASbGncutwfxP0VQHfZXlqVh7lGhI5Vr3+tD/VWSyrEwyqsI4+x047kXj48EIcqlyV7S
 iDt0DlzekgeBUxeU2M/xq1muI2lTgefq21j+kot+7eIcptUp+TcbwoyJhhjMT63gV0xTItC5YmQ
 /L+bb13oEaJ/vPg1XnLXzpaKmc6089TCQubSYQTzhZWf5jBSytn9li6k6ERapMOaWBItDh7+G6A
 zQZ1zU1RlDzpaIxFNaxA7TU8qjVNRnEMMlYvRKS0DASkCOA7jp1cxdpWeMgaFdit20361DzTrJB
 sH/aa9vlBg7q1eGUpA5X6z+cm1sqaTwqy1SMeI3ejrpJ2IUTHQ/SEsBBNl1Wzp4r5A0G/sm7lJC
 fB79UD2GsWha6+asnQpYwyWWOB1lh+1dQmNI9v1LrV8FgqndQmFgT8MkqSI1CX1MIoBe4dR3Ird
 kflue0ASaqCOnkdjWZqyta4DQEaUcbtHyeVGun+wOp4hyAPrtlWw==
X-Google-Smtp-Source: AGHT+IG7rmXOetjM/ycGc0DJG82ofEII35FjxrdyJN4zQyhDrYycLGkbcna1c9Y47mRGRSy+XMQN9A==
X-Received: by 2002:a05:600c:620a:b0:46e:5302:7751 with SMTP id
 5b1f17b1804b1-475c3fc0f5cmr49089985e9.9.1761220025396; 
 Thu, 23 Oct 2025 04:47:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae92067sm34443695e9.4.2025.10.23.04.47.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:47:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Collingbourne <pcc@google.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v2 05/58] accel/hvf: Rename hvf_vcpu_exec() ->
 hvf_arch_vcpu_exec()
Date: Thu, 23 Oct 2025 13:45:42 +0200
Message-ID: <20251023114638.5667-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

hvf_vcpu_exec() is implemented per target, rename it as
hvf_arch_vcpu_exec(), following the per target pattern.

Since it calls hv_vcpu_run(), mention it must be called
on the vCPU.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
---
 include/system/hvf_int.h  | 4 +++-
 accel/hvf/hvf-accel-ops.c | 2 +-
 target/arm/hvf/hvf.c      | 2 +-
 target/i386/hvf/hvf.c     | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index a3b06a3e75b..32b32e1d024 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -73,12 +73,14 @@ int hvf_arch_init(void);
 hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
-int hvf_vcpu_exec(CPUState *);
 hvf_slot *hvf_find_overlap_slot(uint64_t, uint64_t);
 int hvf_put_registers(CPUState *);
 int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+/* Must be called by the owning thread */
+int hvf_arch_vcpu_exec(CPUState *);
+
 struct hvf_sw_breakpoint {
     vaddr pc;
     vaddr saved_insn;
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 8b794c2d418..005e2bd891a 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -194,7 +194,7 @@ static void *hvf_cpu_thread_fn(void *arg)
     do {
         qemu_process_cpu_events(cpu);
         if (cpu_can_run(cpu)) {
-            r = hvf_vcpu_exec(cpu);
+            r = hvf_arch_vcpu_exec(cpu);
             if (r == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bbe0b24b821..9111c1d717b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1788,7 +1788,7 @@ static void hvf_sync_vtimer(CPUState *cpu)
     }
 }
 
-int hvf_vcpu_exec(CPUState *cpu)
+int hvf_arch_vcpu_exec(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 33f723a76a7..b2bf59cb483 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -721,7 +721,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
     printf("write msr %llx\n", RCX(cs));*/
 }
 
-int hvf_vcpu_exec(CPUState *cpu)
+int hvf_arch_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
     CPUX86State *env = &x86_cpu->env;
-- 
2.51.0


