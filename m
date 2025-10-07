Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB91CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62sD-0006vU-0G; Tue, 07 Oct 2025 04:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62sB-0006u6-TA
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62s9-00022M-Ef
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4060b4b1200so5139651f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759824995; x=1760429795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcrQ/BRDK8jh9DN0RScPMJskWDfOgmoQpJ709DYAp4w=;
 b=Dm9X94ckzfx2f41jJslAvAvrI4pE1gaOXx4VZaExrKGmkpfNuSsdU2H05gEJsh5xYk
 73b4fKK0eMp+sn2NvKuOzAefqXtrCAkb+SlpL7v1uCsjlJPaUbjmQFfPk+oCDdL2kO4q
 35kZjFxg4K4D+h5LyhV0WxRiokJO6jmhtGIRlrpgCvonhJU50mZrDvTDeaMLyLBLo6/W
 bigO3MfG+RTmVjwBsFVxtXaNPrtUf+fwg6wuW2wy66tRY4JjQBR+Bk1tIGL6I7pNU8M3
 cUKsdyYcBMYUwNyh9Rt95WrgW4pOWSphWk7BxCzTth99y5TxlAKRhNBxn+ITPy3yA25N
 AQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759824995; x=1760429795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcrQ/BRDK8jh9DN0RScPMJskWDfOgmoQpJ709DYAp4w=;
 b=RD+YwhYOLiNzjBOopU+y9G3f3Ir58EiEeXca2waP9n3gOBXF8bih36uVZn9L+QDL6z
 2Ypqe6KirQLOF9Rot5hlzGgMG57QKgfMGT7m9EwVnziAoU/4WwM+otJPD66YmbE6T8y5
 WBjfecuYaC//VjD2j1A6JFUx0xHcmiiLI0RQaK1CSwqmrNmmqhDdURhjORA358cLtfzf
 l5ag0C/64lAzdZ1gPU2pr0CI1wpOPXIJ3nAuIhER8PYD+lQSnDJM4Yr5tFPLXS3V8bMO
 S45RxstTlwugCPrRdPVTZTRe4DcNFO/Nr1/QBWQCW03gUduxwLx3xA+gH6ZzwhfikcN7
 1UXg==
X-Gm-Message-State: AOJu0YxSouYc6JDB+jk8ZzOPCABoXByCsolu4ak2jvtWDIBUO+k4y0+m
 lE5XfmfMsE8tF8BgR5g3Da1kru2GZDTW9cOdXSBNXaUpDpLQoyY+xARFZhBXDRkbrQDMEaBmJUM
 22zqQbHT1jw==
X-Gm-Gg: ASbGnctm7LbjEYQel6j9zbrzB6hDz0RydPhayLE5dJCckGy5fkkq+BO6BCXtqlhCOh0
 9BgioNwumIMY3IX0Q3BTo8yTWmmnOTz149AHSi6SWdy2HZYSyxtVyBTuvu7tiHAdpY2fi4+J9Jh
 KeVYF8mcc1QHq0tFWqEdNHjiwiX6DyYc+tdHHezyIaYAhZJd6/zeTpyHHPo1rAgyqtmmj2oISLw
 k+ceObgL+wMFO7o8Tes3Ov74/dE2va07ov2RBEZ2/7l0fWGl1M9ILB1Z/0m55tPYEpLTgWaWV8Q
 AxetCVdeFQwfa9mz+4/CH9WwzKy1fbMEQYrnbhatqEBrwJwkMZvq0C/g09OYqcB4TfptKtJCHWL
 aeZ6jYymga9blgEYqXyGL6hGTGh7pA1HS/0wn2igaAspMKB42XJAwKH4sjErk6NWscaZUdgaDEt
 8kqMUGFt+15zjPT1cjZi23rr8U
X-Google-Smtp-Source: AGHT+IFHWOG5U1yMfKEb7WzpHpJ5SLy6VLBCW53DXs+72dWbVVXkRnGeB+r0iTL/l/vZ87owsiQaLQ==
X-Received: by 2002:a05:6000:659:10b0:425:73c9:7159 with SMTP id
 ffacd0b85a97d-42573c9773emr6459560f8f.33.1759824995064; 
 Tue, 07 Oct 2025 01:16:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f01absm24198783f8f.44.2025.10.07.01.16.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 01:16:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] accel/kvm: Factor kvm_cpu_synchronize_put() out
Date: Tue,  7 Oct 2025 10:16:16 +0200
Message-ID: <20251007081616.68442-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081616.68442-1-philmd@linaro.org>
References: <20251007081616.68442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

The same code is duplicated 3 times: factor a common method.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 47 ++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9060599cd73..de79f4ca099 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2935,22 +2935,32 @@ void kvm_cpu_synchronize_state(CPUState *cpu)
     }
 }
 
-static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+static bool kvm_cpu_synchronize_put(CPUState *cpu, KvmPutState state,
+                                    const char *desc)
 {
     Error *err = NULL;
-    int ret = kvm_arch_put_registers(cpu, KVM_PUT_RESET_STATE, &err);
+    int ret = kvm_arch_put_registers(cpu, state, &err);
     if (ret) {
         if (err) {
-            error_reportf_err(err, "Restoring resisters after reset: ");
+            error_reportf_err(err, "Restoring resisters %s: ", desc);
         } else {
-            error_report("Failed to put registers after reset: %s",
+            error_report("Failed to put registers %s: %s", desc,
                          strerror(-ret));
         }
-        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
-        vm_stop(RUN_STATE_INTERNAL_ERROR);
+        return false;
     }
 
     cpu->vcpu_dirty = false;
+
+    return true;
+}
+
+static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg)
+{
+    if (kvm_cpu_synchronize_put(cpu, KVM_PUT_RESET_STATE, "after reset")) {
+        cpu_dump_state(cpu, stderr, CPU_DUMP_CODE);
+        vm_stop(RUN_STATE_INTERNAL_ERROR);
+    }
 }
 
 void kvm_cpu_synchronize_post_reset(CPUState *cpu)
@@ -2964,19 +2974,9 @@ void kvm_cpu_synchronize_post_reset(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
 {
-    Error *err = NULL;
-    int ret = kvm_arch_put_registers(cpu, KVM_PUT_FULL_STATE, &err);
-    if (ret) {
-        if (err) {
-            error_reportf_err(err, "Putting registers after init: ");
-        } else {
-            error_report("Failed to put registers after init: %s",
-                         strerror(-ret));
-        }
+    if (kvm_cpu_synchronize_put(cpu, KVM_PUT_FULL_STATE, "after init")) {
         exit(1);
     }
-
-    cpu->vcpu_dirty = false;
 }
 
 void kvm_cpu_synchronize_post_init(CPUState *cpu)
@@ -3166,20 +3166,11 @@ int kvm_cpu_exec(CPUState *cpu)
         MemTxAttrs attrs;
 
         if (cpu->vcpu_dirty) {
-            Error *err = NULL;
-            ret = kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE, &err);
-            if (ret) {
-                if (err) {
-                    error_reportf_err(err, "Putting registers after init: ");
-                } else {
-                    error_report("Failed to put registers after init: %s",
-                                 strerror(-ret));
-                }
+            if (kvm_cpu_synchronize_put(cpu, KVM_PUT_RUNTIME_STATE,
+                                        "at runtime")) {
                 ret = -1;
                 break;
             }
-
-            cpu->vcpu_dirty = false;
         }
 
         kvm_arch_pre_run(cpu, run);
-- 
2.51.0


