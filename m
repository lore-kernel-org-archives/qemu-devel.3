Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F714E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtKC-0002o1-K5; Mon, 06 Jan 2025 15:03:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtKB-0002n3-5y
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:43 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtK8-0003OO-QG
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:42 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-436202dd730so106003925e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193819; x=1736798619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQToL39oc1IIGRZ4x4DJpAbte9qYHUOsWxQUB+w3STI=;
 b=uOPJMAGRbEpVSEyPu+TgDMLOkZY6dP6K1EnZzyLTxMGgOQ57hyv9G3iIA0bMeFd+NW
 CO+Q4u4wgsWXovHffVu6upFJz68LJYjY0lub39tNj/R1NPPbIqS5VRk0yFbQXI6scy25
 zax/C/KQ1w6FMT3yzeiK7BgL7EBePqwne9LaSM71/RdDjHajJN5zrrwE1cnvToIK/1a0
 vctAOwotlyM3Yn0XKYN6wZ/xtOJf2mqcOWaPsltsykpRXtpemsver4mrsH/MoW5ob3Sd
 7cGebdQ8C+dbQCIN9LS2zz82/EXaTP3I27Is7WWEdukKskb8dvlpqpaa0hh40NCKYjQB
 /oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193819; x=1736798619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sQToL39oc1IIGRZ4x4DJpAbte9qYHUOsWxQUB+w3STI=;
 b=JR+NDKlVjf7pYEtF7sgkdoDed2+8XU3ke8PetwsEEf/Zi08ni6nBxlKNNG9srqOTy+
 rAcSU091dxpUc3FbcBjkxF818IgiQjDh5jIwrPTClJeYzcBom6fcwdfD6aODS8heVhLU
 a8OpEtYKeAfGbm6HG2TBm7SSyGs8z5tlsHAXDy8PhyiStu9cEuLzGo5Dul2wP7L/WFgw
 LpaGWxnL4NzyF/vLciUODoUes51ZcMRO80NUXBva6br8LTwumYXyFMABd7pl4x+eYGf+
 FiWo1BCyTK3TAIEGoczyHiw7XJ54XVT8MbhXIoonZlzeiIF3ntdwmtodJ9AgEWq5qc7V
 kK3w==
X-Gm-Message-State: AOJu0Ywsy+gsWfL2Wf+lWCMe/5M/+qqi/RT6URnHejS5qBiUFAhZEEiJ
 TdAGO5MJgR4uVL97gAJF+ly6kEaRIDMIKKFCQwfbG4ImDdDgaFcY/CWK4Pd5DQtOKWhdjtO6jNc
 wCXQ=
X-Gm-Gg: ASbGncuvDVwayRfsONpyS/fR0r7ELQlZDgtXFO1CVQ3nYC+pYCW3snEJVMp/e25IBMA
 XfwyE2regSX46AnU5/3ORWtqi8zFjKiYoeIeHLpChLCANV0e2guOAA3dKfh2tcWHQqf0TJZu92h
 qZxwJHn4ax2XZxAqoYiyMPlMgM8zvN0Nr4cK4w7Q20Zr+WsPGE/nZW37oYC4+qd5fJPp7QYDyRh
 M7Crrq/KWX1p9xQls8sRpKbXqOpgMPuyDqmihSMNcbV8sh1N5ywK1KoQGGAUG32QDm+zGcoshDM
 hUJJmaWhZ/kHVJDaMNItk9arCJJmGmw=
X-Google-Smtp-Source: AGHT+IFXiDdVgmnTH4sfktC8/xKNinP6K1bHXh0LE5bFlepNSrMiJFLvtHvHs4neclwfX3Zl5Vm/Iw==
X-Received: by 2002:a05:600c:5112:b0:434:faa9:5266 with SMTP id
 5b1f17b1804b1-436c2b5b491mr121041605e9.13.1736193818909; 
 Mon, 06 Jan 2025 12:03:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4367086e40esm543882975e9.30.2025.01.06.12.03.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 6/7] accel/hvf: Use CPU_FOREACH_HVF()
Date: Mon,  6 Jan 2025 21:02:57 +0100
Message-ID: <20250106200258.37008-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
References: <20250106200258.37008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Only iterate over HVF vCPUs when running HVF specific code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/hvf_int.h  | 4 ++++
 accel/hvf/hvf-accel-ops.c | 9 +++++----
 target/arm/hvf/hvf.c      | 4 ++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
index 42ae18433f0..3cf64faabd1 100644
--- a/include/system/hvf_int.h
+++ b/include/system/hvf_int.h
@@ -11,6 +11,8 @@
 #ifndef HVF_INT_H
 #define HVF_INT_H
 
+#include "system/hw_accel.h"
+
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
 typedef hv_vcpu_t hvf_vcpuid;
@@ -74,4 +76,6 @@ int hvf_put_registers(CPUState *);
 int hvf_get_registers(CPUState *);
 void hvf_kick_vcpu_thread(CPUState *cpu);
 
+#define CPU_FOREACH_HVF(cpu) CPU_FOREACH_HWACCEL(cpu)
+
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 945ba720513..bbbe2f8d45b 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -504,7 +504,7 @@ static int hvf_insert_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
         }
     }
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_HVF(cpu) {
         err = hvf_update_guest_debug(cpu);
         if (err) {
             return err;
@@ -543,7 +543,7 @@ static int hvf_remove_breakpoint(CPUState *cpu, int type, vaddr addr, vaddr len)
         }
     }
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_HVF(cpu) {
         err = hvf_update_guest_debug(cpu);
         if (err) {
             return err;
@@ -560,7 +560,7 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     QTAILQ_FOREACH_SAFE(bp, &hvf_state->hvf_sw_breakpoints, entry, next) {
         if (hvf_arch_remove_sw_breakpoint(cpu, bp) != 0) {
             /* Try harder to find a CPU that currently sees the breakpoint. */
-            CPU_FOREACH(tmpcpu)
+            CPU_FOREACH_HVF(tmpcpu)
             {
                 if (hvf_arch_remove_sw_breakpoint(tmpcpu, bp) == 0) {
                     break;
@@ -572,7 +572,7 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
     }
     hvf_arch_remove_all_hw_breakpoints();
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_HVF(cpu) {
         hvf_update_guest_debug(cpu);
     }
 }
@@ -581,6 +581,7 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
 
+    ops->get_cpus_queue = hw_accel_get_cpus_queue;
     ops->create_vcpu_thread = hvf_start_vcpu_thread;
     ops->kick_vcpu_thread = hvf_kick_vcpu_thread;
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0afd96018e0..13400ff0d5f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2269,10 +2269,10 @@ static void hvf_arch_set_traps(void)
 
     /* Check whether guest debugging is enabled for at least one vCPU; if it
      * is, enable exiting the guest on all vCPUs */
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_HVF(cpu) {
         should_enable_traps |= cpu->accel->guest_debug_enabled;
     }
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_HVF(cpu) {
         /* Set whether debug exceptions exit the guest */
         r = hv_vcpu_set_trap_debug_exceptions(cpu->accel->fd,
                                               should_enable_traps);
-- 
2.47.1


