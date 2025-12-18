Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE09D6E2D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:33:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIo3-0003wR-5s; Thu, 18 Dec 2025 13:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWIn3-0003nz-M3
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:53 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sergeev0xef@gmail.com>)
 id 1vWIn0-0007MM-Uh
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:31:53 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-59584301f0cso1076086e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766082709; x=1766687509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfraTUn3a2qoGbZSbxCtpfAGZXMUcHt2Eh4Hg4N27xI=;
 b=P1Yi1bAAloEMMvYJkyl2MbvDSMUMH2699fskMcJuaeFbbyMsn0MMcgA3827l5cnhCU
 JkIe89mUAcf7TVYaFFT3zinp9QaanrbbPDTOmHYXhwhwIkEn1kKRxt/+8i5cFPqzayUS
 POTo62Pwc1NCci4eKNMkjJTW+RdyStLaDOHe4yOgnKdwNjWfHpv+y2n4UvgX0cX7zG9E
 Z75BwJG8mJ1czPAAEgEQYMPDoRaDzqV5GrDJSyGvsuVgiGVGFtT/IQ/Zrx34KNCM7stS
 /DTI3iI+3PaFcOabwtJbPpcSmCy9glVzELK7hI9oqXUOdd3UluIS2xqSVddcbRJ+0Y4T
 rlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766082709; x=1766687509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GfraTUn3a2qoGbZSbxCtpfAGZXMUcHt2Eh4Hg4N27xI=;
 b=DgmzhwGR/U2AdEOr9m9y3vgwiKdFKE49pMh1GgT3uO6YX8vapXf7iaZSk0k+ta3PhN
 y6aPVAnc5t7PliHyTBWJdjc5J2L9DPdQleiZ4EGOWC0C7YCSxaHjwiHSL2/+ZcvnZzwV
 TKiuhlW+cF/GQXlLzgW3d6eZ5NE4RXn/HHrwSK3Tir6Puyy8A1i6Uv0kSP3Mkn3ZZAXG
 dLld1ARdZEUccSjk/RgJlofdG/kdL6wHUl3uDeW3y1yN9FW5nmKlCkcITKxxAzmSm/E4
 ZtZxfd7/Vnt3KMHSFyFOaUAvXC33wyVvmKJva9pcmtwpl9A0YfBHbUjyh2AiRnROWprZ
 /q3Q==
X-Gm-Message-State: AOJu0Yy+zVhp3VoQMcvlJ5HP4p4+XsxaECpfuJwN2zH5U7//jmzpb8Yq
 9JdqWKwKmQFv8Jj4Uo6hXFt3cyEuxL6Paz3trtBWP1OfAlv/uSC2Nn4NoMM3TaBz
X-Gm-Gg: AY/fxX4xePouAym0IEwOhWYc2oycZAcm7wWwQjRf3PY3MmN/+Q27Cym/1kbOw5xDbSI
 tit+FC09i9KjvOkWPdSy2JduEUJWuTYnWK6bpYt9tFPxd3xtBfn6XtyMLsBYHBH0FKC8DimEWUr
 t60uhKwJ0GDz8vomkDhKlz/xxLSYju209/PsSMTuG3bNQeQhh2XiJtTQLTKnn8nHxD+XHhsR/lk
 XLDi+DqOpbBqWInQpOwDq4I4N624y5nXDDvhXo6ko+cVVMLZCtAhH4yIIgDMLhn3pGWSp1Wa097
 xnz0Edk4kMOqCB6ZLgg93Vtbthp9zCfUxLvs5GG139xHIu0yoQAMF5XKId0opFNWyxN9HE3Cp6r
 4KNy5HgkoxHRoEXGJD/hEfIvT7YPMjt19CyBHLK3eROTFP5MJphG08xQnE+8j8iOVsngpt4zd7L
 LYakh5vfKx4o7W
X-Google-Smtp-Source: AGHT+IEOY3UAKtEKJJwOH9O/75J5rtspcTGIzPAy03x/oY4CQSVO8T4C+5mFQMX8bUN/zUo90H78dQ==
X-Received: by 2002:a05:6512:10d5:b0:594:2dbb:723a with SMTP id
 2adb3069b0e04-59a17d5da8bmr197282e87.39.1766082708424; 
 Thu, 18 Dec 2025 10:31:48 -0800 (PST)
Received: from NB-8855.Dlink ([81.201.19.27]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59a185dd229sm46777e87.22.2025.12.18.10.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 10:31:47 -0800 (PST)
From: Aleksandr Sergeev <sergeev0xef@gmail.com>
To: qemu-devel@nongnu.org
Cc: halip0503@gmail.com,
	Aleksandr Sergeev <sergeev0xef@gmail.com>
Subject: [RFC PATCH 5/6] target/riscv: Add PMU events implementation for `virt`
Date: Thu, 18 Dec 2025 21:31:20 +0300
Message-ID: <20251218183122.408690-6-sergeev0xef@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218183122.408690-1-sergeev0xef@gmail.com>
References: <20251218183122.408690-1-sergeev0xef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=sergeev0xef@gmail.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:32:45 -0500
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

Add PMU events implementation for `virt` machine
according to SBI spec.

Signed-off-by: Aleksandr Sergeev <sergeev0xef@gmail.com>
Reviewed-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/misc/Kconfig            |   3 +
 hw/misc/meson.build        |   1 +
 hw/misc/virt_pmu.c         | 142 +++++++++++++++++++++++++++++++++++++
 hw/riscv/Kconfig           |   1 +
 hw/riscv/virt.c            |   4 +-
 include/hw/misc/virt_pmu.h |  91 ++++++++++++++++++++++++
 target/riscv/cpu.c         |   8 +++
 target/riscv/pmu.c         |  53 --------------
 target/riscv/pmu.h         |   1 -
 9 files changed, 248 insertions(+), 56 deletions(-)
 create mode 100644 hw/misc/virt_pmu.c
 create mode 100644 include/hw/misc/virt_pmu.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24..099200f711 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -150,6 +150,9 @@ config IOTKIT_SYSINFO
 config PVPANIC_COMMON
     bool
 
+config VIRT_PMU
+    bool
+
 config PVPANIC_PCI
     bool
     default y if PCI_DEVICES
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..977a3ac620 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -34,6 +34,7 @@ system_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_E_AON', if_true: files('sifive_e_aon.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
+specific_ss.add(when: 'CONFIG_VIRT_PMU', if_true: files('virt_pmu.c'))
 
 subdir('macio')
 
diff --git a/hw/misc/virt_pmu.c b/hw/misc/virt_pmu.c
new file mode 100644
index 0000000000..afba06de0e
--- /dev/null
+++ b/hw/misc/virt_pmu.c
@@ -0,0 +1,142 @@
+/*
+ * RISC-V Virt machine PMU emulation.
+ *
+ * Copyright (c) 2025 Syntacore.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "target/riscv/cpu.h"
+#include "target/riscv/pmu.h"
+#include "include/hw/misc/virt_pmu.h"
+#include "system/device_tree.h"
+
+#define SBI_CACHE_EVENT_ID_CNT (SBI_PMU_HW_CACHE_NODE - SBI_PMU_HW_CACHE_L1D + 1)
+#define SBI_CACHE_OP_ID_CNT (SBI_PMU_HW_CACHE_OP_PREFETCH - SBI_PMU_HW_CACHE_OP_READ + 1)
+#define SBI_EVT_CTR_SIZE (SBI_CACHE_EVENT_ID_CNT * SBI_CACHE_OP_ID_CNT + 3)
+
+void riscv_virt_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
+{
+    uint32_t fdt_event_mhpmctr_map[SBI_EVT_CTR_SIZE][3] = {};
+    uint32_t event_mhpmctr_idx = 0;
+
+    uint32_t event_idx_low, event_idx_high;
+
+    /* SBI_PMU_HW_CPU_CYCLES */
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][0] = cpu_to_be32(SBI_PMU_HW_CPU_CYCLES);
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][1] = cpu_to_be32(SBI_PMU_HW_CPU_CYCLES);
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][2] = cpu_to_be32(cmask | 1 << 0);
+    event_mhpmctr_idx++;
+
+    /* SBI_PMU_HW_INSTRUCTIONS */
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][0] =
+        cpu_to_be32(SBI_PMU_HW_INSTRUCTIONS);
+
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][1] =
+        cpu_to_be32(SBI_PMU_HW_INSTRUCTIONS);
+
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][2] = cpu_to_be32(cmask | 1 << 2);
+    event_mhpmctr_idx++;
+
+    /* Other generic type events */
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][0] =
+        cpu_to_be32(SBI_PMU_HW_CACHE_REFERENCES);
+
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][1] =
+        cpu_to_be32(SBI_PMU_HW_REF_CPU_CYCLES);
+
+    fdt_event_mhpmctr_map[event_mhpmctr_idx][2] = cpu_to_be32(cmask);
+    event_mhpmctr_idx++;
+
+    /* Cache type */
+    for (uint32_t ev_id = 0; ev_id < SBI_CACHE_EVENT_ID_CNT; ++ev_id) {
+        for (uint32_t op_id = 0; op_id < SBI_CACHE_OP_ID_CNT; ++op_id) {
+            event_idx_low = FIELD_DP32(0, SBI_MHPMEVENT_CACHE, OP, op_id);
+            event_idx_low = FIELD_DP32(event_idx_low, SBI_MHPMEVENT_CACHE, EVENT, ev_id);
+            event_idx_low = FIELD_DP32(event_idx_low, SBI_MHPMEVENT, TYPE,
+                                       RISCV_SBI_EVENT_TYPE_CACHE);
+            event_idx_low = FIELD_DP32(event_idx_low, SBI_MHPMEVENT_CACHE, RESULT,
+                                       SBI_PMU_HW_CACHE_RESULT_ACCESS);
+
+            event_idx_high = FIELD_DP32(event_idx_low, SBI_MHPMEVENT_CACHE, RESULT,
+                                        SBI_PMU_HW_CACHE_RESULT_MISS);
+
+            fdt_event_mhpmctr_map[event_mhpmctr_idx][0] = cpu_to_be32(event_idx_low);
+            fdt_event_mhpmctr_map[event_mhpmctr_idx][1] = cpu_to_be32(event_idx_high);
+            fdt_event_mhpmctr_map[event_mhpmctr_idx][2] = cpu_to_be32(cmask);
+            event_mhpmctr_idx++;
+        }
+    }
+
+    g_assert(event_mhpmctr_idx <= SBI_EVT_CTR_SIZE);
+
+    /* This a OpenSBI specific DT property documented in OpenSBI docs */
+    qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
+                     fdt_event_mhpmctr_map,
+                     event_mhpmctr_idx * sizeof(fdt_event_mhpmctr_map[0]));
+}
+
+bool riscv_virt_supported_events(CPURISCVState *env, uint32_t ctr_idx)
+{
+    uint32_t sbi_event_type = FIELD_EX32(env->mhpmevent_val[ctr_idx],
+                                         SBI_MHPMEVENT, TYPE);
+    uint32_t sbi_cache_event;
+    uint32_t sbi_cache_op;
+    uint32_t sbi_cache_result;
+
+    switch (sbi_event_type) {
+    case RISCV_SBI_EVENT_TYPE_GEN:
+        return sbi_event_type <= SBI_PMU_HW_REF_CPU_CYCLES;
+    case RISCV_SBI_EVENT_TYPE_CACHE:
+        sbi_cache_event = FIELD_EX32(sbi_event_type, SBI_MHPMEVENT_CACHE, EVENT);
+        sbi_cache_op = FIELD_EX32(sbi_event_type, SBI_MHPMEVENT_CACHE, OP);
+        sbi_cache_result = FIELD_EX32(sbi_event_type, SBI_MHPMEVENT_CACHE, RESULT);
+
+        return sbi_cache_event <= SBI_PMU_HW_CACHE_NODE &&
+               sbi_cache_op <= SBI_PMU_HW_CACHE_OP_PREFETCH &&
+               sbi_cache_result <= SBI_PMU_HW_CACHE_RESULT_MISS;
+    default:
+        return false;
+    }
+}
+
+RISCVException riscv_virt_pmu_ctr_read(CPURISCVState *env, uint32_t ctr_idx,
+                                       uint64_t *value)
+{
+    uint32_t sbi_event_type = FIELD_EX32(env->mhpmevent_val[ctr_idx],
+                                         SBI_MHPMEVENT, TYPE);
+
+    switch (sbi_event_type) {
+    /* If we want to handle some events separately */
+    default:
+    /* In case we do not want handle it separately */
+        return riscv_pmu_ctr_read_general(env, ctr_idx, value);
+    }
+}
+
+RISCVException riscv_virt_pmu_ctr_write(CPURISCVState *env, uint32_t ctr_idx,
+                                        uint64_t value)
+{
+    uint32_t sbi_event_type = FIELD_EX32(env->mhpmevent_val[ctr_idx],
+                                         SBI_MHPMEVENT, TYPE);
+
+    switch (sbi_event_type) {
+    /* If we want to handle some events separately */
+    default:
+    /* In case we do not want handle it separately */
+        return riscv_pmu_ctr_write_general(env, ctr_idx, value);
+    }
+}
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fc9c35bd98..920b65d733 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -49,6 +49,7 @@ config RISCV_VIRT
     imply VIRTIO_VGA
     imply TEST_DEVICES
     imply TPM_TIS_SYSBUS
+    select VIRT_PMU
     select DEVICE_TREE
     select RISCV_NUMA
     select GOLDFISH_RTC
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 17909206c7..7b0e6869db 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -30,7 +30,6 @@
 #include "hw/char/serial-mm.h"
 #include "target/riscv/cpu.h"
 #include "hw/core/sysbus-fdt.h"
-#include "target/riscv/pmu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/iommu.h"
 #include "hw/riscv/riscv-iommu-bits.h"
@@ -58,6 +57,7 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/uefi/var-service-api.h"
+#include "hw/misc/virt_pmu.h"
 
 /* KVM AIA only supports APLIC MSI. APLIC Wired is always emulated by QEMU. */
 static bool virt_use_kvm_aia_aplic_imsic(RISCVVirtAIAType aia_type)
@@ -735,7 +735,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
 
     qemu_fdt_add_subnode(ms->fdt, pmu_name);
     qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
-    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
+    riscv_virt_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
 }
 
 static void create_fdt_sockets(RISCVVirtState *s,
diff --git a/include/hw/misc/virt_pmu.h b/include/hw/misc/virt_pmu.h
new file mode 100644
index 0000000000..ea9ace5f6a
--- /dev/null
+++ b/include/hw/misc/virt_pmu.h
@@ -0,0 +1,91 @@
+/*
+ * RISC-V Virt machine PMU header file.
+ * Copyright (C) 2025, Syntacore Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ * Also add information on how to contact you by electronic and paper mail.
+ */
+
+#ifndef RISCV_VIRT_PMU_H
+#define RISCV_VIRT_PMU_H
+
+#include "target/riscv/cpu.h"
+#include "qapi/error.h"
+
+typedef enum riscv_sbi_pmu_types {
+    RISCV_SBI_EVENT_TYPE_GEN      = 0x0,
+    RISCV_SBI_EVENT_TYPE_CACHE    = 0x1,
+    RISCV_SBI_EVENT_TYPE_RAW      = 0x2,
+    RISCV_SBI_EVENT_TYPE_RAW_V2   = 0x3,
+    RISCV_SBI_EVENT_TYPE_FIRMWARE = 0xf,
+} riscv_sbi_pmu_types;
+
+REG32(SBI_MHPMEVENT, 0x323)
+    FIELD(SBI_MHPMEVENT, CODE, 0, 16)
+    FIELD(SBI_MHPMEVENT, TYPE, 16, 4)
+
+/* Generic type events */
+
+typedef enum riscv_sbi_pmu_hw {
+    SBI_PMU_HW_NO_EVENT                = 0x00000,
+    SBI_PMU_HW_CPU_CYCLES              = 0x00001,
+    SBI_PMU_HW_INSTRUCTIONS            = 0x00002,
+    SBI_PMU_HW_CACHE_REFERENCES        = 0x00003,
+    SBI_PMU_HW_CACHE_MISSES            = 0x00004,
+    SBI_PMU_HW_BRANCH_INSTRUCTIONS     = 0x00005,
+    SBI_PMU_HW_BRANCH_MISSES           = 0x00006,
+    SBI_PMU_HW_BUS_CYCLES              = 0x00007,
+    SBI_PMU_HW_STALLED_CYCLES_FRONTEND = 0x00008,
+    SBI_PMU_HW_STALLED_CYCLES_BACKEND  = 0x00009,
+    SBI_PMU_HW_REF_CPU_CYCLES          = 0x0000A,
+} riscv_sbi_pmu_hw;
+
+/* Cache type events */
+
+typedef enum riscv_sbi_pmu_cache_event {
+    SBI_PMU_HW_CACHE_L1D  = 0x0,
+    SBI_PMU_HW_CACHE_L1I  = 0x1,
+    SBI_PMU_HW_CACHE_LL   = 0x2,
+    SBI_PMU_HW_CACHE_DTLB = 0x3,
+    SBI_PMU_HW_CACHE_ITLB = 0x4,
+    SBI_PMU_HW_CACHE_BPU  = 0x5,
+    SBI_PMU_HW_CACHE_NODE = 0x6,
+} riscv_sbi_pmu_cache_event;
+
+typedef enum riscv_sbi_pmu_cache_op {
+    SBI_PMU_HW_CACHE_OP_READ     = 0,
+    SBI_PMU_HW_CACHE_OP_WRITE    = 1,
+    SBI_PMU_HW_CACHE_OP_PREFETCH = 2,
+} riscv_sbi_pmu_cache_op;
+
+typedef enum riscv_sbi_pmu_cache_result {
+    SBI_PMU_HW_CACHE_RESULT_ACCESS = 0,
+    SBI_PMU_HW_CACHE_RESULT_MISS   = 1,
+} riscv_sbi_pmu_cache_result;
+
+REG32(SBI_MHPMEVENT_CACHE, 0x323)
+    FIELD(SBI_MHPMEVENT_CACHE, RESULT, 0, 1)
+    FIELD(SBI_MHPMEVENT_CACHE, OP, 1, 2)
+    FIELD(SBI_MHPMEVENT_CACHE, EVENT, 3, 13)
+
+
+void riscv_virt_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
+bool riscv_virt_supported_events(CPURISCVState *env, uint32_t ctr_idx);
+RISCVException riscv_virt_pmu_ctr_read(CPURISCVState *env, uint32_t ctr_idx,
+                                       uint64_t *value);
+RISCVException riscv_virt_pmu_ctr_write(CPURISCVState *env, uint32_t ctr_idx,
+                                        uint64_t value);
+
+#endif /* RISCV_VIRT_PMU_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..40853d7214 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -37,6 +37,7 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
+#include "hw/misc/virt_pmu.h"
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
@@ -1125,6 +1126,13 @@ static void riscv_cpu_init(Object *obj)
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
+#ifndef CONFIG_USER_ONLY
+    /* Default PMU implementation */
+    env->pmu_ctr_write = riscv_virt_pmu_ctr_write;
+    env->pmu_ctr_read = riscv_virt_pmu_ctr_read;
+    env->pmu_vendor_support = riscv_virt_supported_events;
+#endif /* CONFIG_USER_ONLY */
+
     if (mcc->def->profile) {
         mcc->def->profile->enabled = true;
     }
diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 5109fd14bf..899d5941bb 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -23,62 +23,9 @@
 #include "cpu.h"
 #include "pmu.h"
 #include "exec/icount.h"
-#include "system/device_tree.h"
 
 #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
 
-/*
- * To keep it simple, any event can be mapped to any programmable counters in
- * QEMU. The generic cycle & instruction count events can also be monitored
- * using programmable counters. In that case, mcycle & minstret must continue
- * to provide the correct value as well. Heterogeneous PMU per hart is not
- * supported yet. Thus, number of counters are same across all harts.
- */
-void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name)
-{
-    uint32_t fdt_event_ctr_map[15] = {};
-
-   /*
-    * The event encoding is specified in the SBI specification
-    * Event idx is a 20bits wide number encoded as follows:
-    * event_idx[19:16] = type
-    * event_idx[15:0] = code
-    * The code field in cache events are encoded as follows:
-    * event_idx.code[15:3] = cache_id
-    * event_idx.code[2:1] = op_id
-    * event_idx.code[0:0] = result_id
-    */
-
-   /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
-   fdt_event_ctr_map[0] = cpu_to_be32(0x00000001);
-   fdt_event_ctr_map[1] = cpu_to_be32(0x00000001);
-   fdt_event_ctr_map[2] = cpu_to_be32(cmask | 1 << 0);
-
-   /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
-   fdt_event_ctr_map[3] = cpu_to_be32(0x00000002);
-   fdt_event_ctr_map[4] = cpu_to_be32(0x00000002);
-   fdt_event_ctr_map[5] = cpu_to_be32(cmask | 1 << 2);
-
-   /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01) */
-   fdt_event_ctr_map[6] = cpu_to_be32(0x00010019);
-   fdt_event_ctr_map[7] = cpu_to_be32(0x00010019);
-   fdt_event_ctr_map[8] = cpu_to_be32(cmask);
-
-   /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01) */
-   fdt_event_ctr_map[9] = cpu_to_be32(0x0001001B);
-   fdt_event_ctr_map[10] = cpu_to_be32(0x0001001B);
-   fdt_event_ctr_map[11] = cpu_to_be32(cmask);
-
-   /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01) */
-   fdt_event_ctr_map[12] = cpu_to_be32(0x00010021);
-   fdt_event_ctr_map[13] = cpu_to_be32(0x00010021);
-   fdt_event_ctr_map[14] = cpu_to_be32(cmask);
-
-   /* This a OpenSBI specific DT property documented in OpenSBI docs */
-   qemu_fdt_setprop(fdt, pmu_name, "riscv,event-to-mhpmcounters",
-                    fdt_event_ctr_map, sizeof(fdt_event_ctr_map));
-}
-
 static bool riscv_pmu_counter_valid(RISCVCPU *cpu, uint32_t ctr_idx)
 {
     CPURISCVState *env = &cpu->env;
diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
index 283e311b04..e0603b7e33 100644
--- a/target/riscv/pmu.h
+++ b/target/riscv/pmu.h
@@ -26,7 +26,6 @@
 
 void riscv_pmu_timer_cb(void *priv);
 void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
-void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
 int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
                           uint32_t ctr_idx);
 uint32_t riscv_pmu_csrno_to_ctr_idx(int csrno);
-- 
2.51.0


