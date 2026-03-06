Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB76FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWel-0003we-QZ; Fri, 06 Mar 2026 09:59:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWek-0003tb-L6
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:58 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWei-0002Ki-N4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:58 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso85638975e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809195; x=1773413995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y9FYmM1iM3mMUsFWjuMRiz+BgnAGri/tKlfBQbVr1MM=;
 b=kCVVvaJsUdtWTVRdNaJTXZxQg914IxDT4qWo1+lLTw8tVM3p22IhqWY47TsINhWliw
 Owf+KXjdMzBtr7KL3D0suW8t/1Tr8jEE9aVjyl8Lm6clWh3+jQAiON3yTd/MHFLxlDjy
 yKmdPjqxY43MUt39FTm4ZkH/wYY1lfrKjPO9zq59w9cNQTuY29jvSEOU3T7AH3VeGLzD
 CVgmQihZvcsV3k9Xoyk52buLsVZKEq+SdJO+73fyRZ/UEUSexxuWVQ3NoaCjmEEWi2zo
 2RsI1lUNhYgLFl7V53cSXWm2vQi5pTZbEKT4Wwes0HYzNm0CS8u2n7AvAXHc5NxsHqc6
 3KBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809195; x=1773413995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y9FYmM1iM3mMUsFWjuMRiz+BgnAGri/tKlfBQbVr1MM=;
 b=HQy3LrIFMRdpjVP7xMhmGV3H5H5RLbdWSu+Z9d1ZlFwCpXbglE6fK6+BWPP7MfzJg4
 D+i+Ay+yVyv0hHD8rKfpxw2ExYINrWDlu5TFckjTobEwiNpXiRisZh5ORHYdWiBeDxpM
 bHqGUnQGZx5va7SsAVxjUn4Oq3pBffBysBVDIYcarRS95uGr7Q9M/Jwr4geEhSsPLQ12
 1jtPh/23kELb89uHm3k9m3w8w284G9rIHBRUup6qEGamuco2ORS1nUXnDA1AeDx5ppJf
 CIuGdiuBA1TAk6gJ+5dDLztZm10k4gCD5R9mFpjjgF4CdQ2RC1dsZ+bu5XUde0rRn81r
 HUyg==
X-Gm-Message-State: AOJu0Ywre8vWmWy8Y1HmW4pKEYvcMBV4sZ0sz6c59bvMrda7TjYEwKgY
 YCRIIjsqiI1jmAspUzKqwcSFnmgGo+11mQrFAnjiC3DeHnh+gaMbYIJSYCuFvpTDSo3yN6y6MGn
 nIvJW
X-Gm-Gg: ATEYQzw8so8RAYj0Om2iXxmiY7xy3j/J2Y6mAcc5rUjYy6Wh5mcmUp/AL2uCC1wO+4A
 66zh3dQgdg4XfqCndFFspHI0A5Xnc27DNPNkLfCxdpESSyEYo6SBjIGu1sJiZ0C+7rZmIe8VGUm
 BeYZ3LY3IvYegcl8AlLxi3xCuSFDEuxLe1Y8aS5dKjr0kcVoTE3OqhABGH4EJM3pdOUj3VYpklQ
 pLxPR0hT1YsnIzbOmq13naHctEycz2AHKz12avsdNtAauz/Q3WAUr3UowKkYGynJ9UOze26AyLt
 jvEdDKCI0gpIqsPjNYPeTFKPiOjQTqOaJPXrRl44i+38mqf794MDmazoNMHqS9P4d8KMHXSBhPY
 d5n88njleNLd/SAugYP6LGutLKaYTvgQS8NM1RIhxX7TnlM43uyrWasDFawjmRaAXBGVpuDYIf6
 t8F/scYYeE7mwR7glbOxoEX6XCkCeO1p5FkrXdU4e2ykYqVjefwsOWKmokrAyaJqMKM6dPU3eYV
 4RiSMTMR2LiUC+p22sEnXJy5n1aFZQ=
X-Received: by 2002:a05:600c:870b:b0:47e:e8de:7420 with SMTP id
 5b1f17b1804b1-48526957c7bmr39167335e9.22.1772809195017; 
 Fri, 06 Mar 2026 06:59:55 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/49] target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC for
 cpreg arrays
Date: Fri,  6 Mar 2026 14:59:05 +0000
Message-ID: <20260306145939.2162189-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Eric Auger <eric.auger@redhat.com>

This removes the need for explicitly allocating cpreg_vmstate arrays.
On post save we simply point to cpreg arrays and set the length
accordingly.

Remove VMSTATE_VARRAY_INT32 for cpreg_vmstate_array_len as now
the array is dynamically allocated.

Also add a trace point on post_load to trace potential mismatch
between the number of incoming cpregs versus current ones.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260304101625.1962633-3-eric.auger@redhat.com
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c        |  5 -----
 target/arm/kvm.c           |  5 -----
 target/arm/machine.c       | 45 +++++++++++++++++++++++++++-----------
 target/arm/trace-events    |  3 +++
 target/arm/whpx/whpx-all.c |  7 ------
 5 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6bfab90981..7389f2988c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -265,15 +265,10 @@ void arm_init_cpreg_list(ARMCPU *cpu)
     if (arraylen) {
         cpu->cpreg_indexes = g_new(uint64_t, arraylen);
         cpu->cpreg_values = g_new(uint64_t, arraylen);
-        cpu->cpreg_vmstate_indexes = g_new(uint64_t, arraylen);
-        cpu->cpreg_vmstate_values = g_new(uint64_t, arraylen);
     } else {
         cpu->cpreg_indexes = NULL;
         cpu->cpreg_values = NULL;
-        cpu->cpreg_vmstate_indexes = NULL;
-        cpu->cpreg_vmstate_values = NULL;
     }
-    cpu->cpreg_vmstate_array_len = arraylen;
     cpu->cpreg_array_len = 0;
 
     g_hash_table_foreach(cpu->cp_regs, add_cpreg_to_list, cpu);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index eaa065d726..555083e7aa 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -864,12 +864,7 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 
     cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
     cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
-    cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
-                                         arraylen);
-    cpu->cpreg_vmstate_values = g_renew(uint64_t, cpu->cpreg_vmstate_values,
-                                        arraylen);
     cpu->cpreg_array_len = arraylen;
-    cpu->cpreg_vmstate_array_len = arraylen;
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
         uint64_t regidx = rlp->reg[i];
diff --git a/target/arm/machine.c b/target/arm/machine.c
index bbaae34449..d3d4f2ddc1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "trace.h"
 #include "qemu/error-report.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
@@ -984,11 +985,14 @@ static int cpu_pre_save(void *opaque)
         }
     }
 
+    /*
+     * On outbound migration, send the data in our cpreg_{values,indexes}
+     * arrays. The migration code will not allocate anything, but just
+     * reads the data pointed to by the VMSTATE_VARRAY_INT32_ALLOC() fields.
+     */
+    cpu->cpreg_vmstate_indexes = cpu->cpreg_indexes;
+    cpu->cpreg_vmstate_values = cpu->cpreg_values;
     cpu->cpreg_vmstate_array_len = cpu->cpreg_array_len;
-    memcpy(cpu->cpreg_vmstate_indexes, cpu->cpreg_indexes,
-           cpu->cpreg_array_len * sizeof(uint64_t));
-    memcpy(cpu->cpreg_vmstate_values, cpu->cpreg_values,
-           cpu->cpreg_array_len * sizeof(uint64_t));
 
     return 0;
 }
@@ -1001,6 +1005,9 @@ static int cpu_post_save(void *opaque)
         pmu_op_finish(&cpu->env);
     }
 
+    cpu->cpreg_vmstate_indexes = NULL;
+    cpu->cpreg_vmstate_values = NULL;
+
     return 0;
 }
 
@@ -1034,6 +1041,9 @@ static int cpu_pre_load(void *opaque)
         pmu_op_start(env);
     }
 
+    g_assert(!cpu->cpreg_vmstate_indexes);
+    g_assert(!cpu->cpreg_vmstate_values);
+
     return 0;
 }
 
@@ -1043,6 +1053,9 @@ static int cpu_post_load(void *opaque, int version_id)
     CPUARMState *env = &cpu->env;
     int i, v;
 
+    trace_cpu_post_load(cpu->cpreg_vmstate_array_len,
+                        cpu->cpreg_array_len);
+
     /*
      * Handle migration compatibility from old QEMU which didn't
      * send the irq-line-state subsection. A QEMU without it did not
@@ -1094,6 +1107,11 @@ static int cpu_post_load(void *opaque, int version_id)
         }
     }
 
+    g_free(cpu->cpreg_vmstate_indexes);
+    g_free(cpu->cpreg_vmstate_values);
+    cpu->cpreg_vmstate_indexes = NULL;
+    cpu->cpreg_vmstate_values = NULL;
+
     /*
      * Misaligned thumb pc is architecturally impossible. Fail the
      * incoming migration. For TCG it would trigger the assert in
@@ -1167,16 +1185,17 @@ const VMStateDescription vmstate_arm_cpu = {
         VMSTATE_UINT32_ARRAY(env.fiq_regs, ARMCPU, 5),
         VMSTATE_UINT64_ARRAY(env.elr_el, ARMCPU, 4),
         VMSTATE_UINT64_ARRAY(env.sp_el, ARMCPU, 4),
-        /* The length-check must come before the arrays to avoid
-         * incoming data possibly overflowing the array.
+        /*
+         * The length must come before the arrays so we can
+         * allocate the arrays before their data arrives
          */
-        VMSTATE_INT32_POSITIVE_LE(cpreg_vmstate_array_len, ARMCPU),
-        VMSTATE_VARRAY_INT32(cpreg_vmstate_indexes, ARMCPU,
-                             cpreg_vmstate_array_len,
-                             0, vmstate_info_uint64, uint64_t),
-        VMSTATE_VARRAY_INT32(cpreg_vmstate_values, ARMCPU,
-                             cpreg_vmstate_array_len,
-                             0, vmstate_info_uint64, uint64_t),
+        VMSTATE_INT32(cpreg_vmstate_array_len, ARMCPU),
+        VMSTATE_VARRAY_INT32_ALLOC(cpreg_vmstate_indexes, ARMCPU,
+                                   cpreg_vmstate_array_len,
+                                   0, vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_INT32_ALLOC(cpreg_vmstate_values, ARMCPU,
+                                   cpreg_vmstate_array_len,
+                                   0, vmstate_info_uint64, uint64_t),
         VMSTATE_UINT64(env.exclusive_addr, ARMCPU),
         VMSTATE_UINT64(env.exclusive_val, ARMCPU),
         VMSTATE_UINT64(env.exclusive_high, ARMCPU),
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 676d29fe51..2de0406f78 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -26,3 +26,6 @@ arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
 
 # tcg/psci.c and hvf/hvf.c
 arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
+
+# machine.c
+cpu_post_load(uint32_t cpreg_vmstate_array_len, uint32_t cpreg_array_len) "cpreg_vmstate_array_len=%d cpreg_array_len=%d"
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bb94eac7bf..c5b108166a 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -783,12 +783,6 @@ int whpx_init_vcpu(CPUState *cpu)
                                      sregs_match_len);
     arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
                                     sregs_match_len);
-    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
-                                             arm_cpu->cpreg_vmstate_indexes,
-                                             sregs_match_len);
-    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
-                                            arm_cpu->cpreg_vmstate_values,
-                                            sregs_match_len);
 
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
@@ -807,7 +801,6 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
     arm_cpu->cpreg_array_len = sregs_cnt;
-    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
     assert(write_cpustate_to_list(arm_cpu, false));
 
-- 
2.43.0


