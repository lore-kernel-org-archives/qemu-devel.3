Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F543C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 16:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHwP-0001cB-3h; Thu, 19 Jun 2025 12:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvl-0001MD-VX
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uSHvg-0003fk-BO
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 12:16:01 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so48822b3a.2
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750349754; x=1750954554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97wbn1fyVd354+uZeRkmCwxgLDzBnsPU4MLpqSMDiPM=;
 b=ntBwG0mECUTJcAoMXhAHtBTNFR3wE7qyMIrhl335u4Ofrrto3tqIglqvtECgbKO5dE
 RqPI6f1/mphY11OfZ6y9TM2zKOWmejOXZdvCVYnIJP31bA/mTyQFjQU2pcjxvGW3q7wi
 80B1qPO+yLtLlywxbs3lIeZ6qe1jmGzBTDQK3N/Jn8fj6rLX6Ni+pbKR00rER9ugRkxm
 XRiCa/FOG0FhALxgoTxn8xZ7+e6wVrmKJoAGm6Y1Dz2gWYHAQoRnL4k94n2JDHPGZzoN
 6H/TZXvUjDRVtAr6Mk1IdAEMd+3QSA4WrTzd6G4QzdLSZdybUrp4OSJo5VEhEZNE0vrL
 IE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750349754; x=1750954554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97wbn1fyVd354+uZeRkmCwxgLDzBnsPU4MLpqSMDiPM=;
 b=T6J07D0hm3uNOkGb7eHnYcnFXskSwMpfZ4AwZE9prlJnDiINLlCXTz32A8ZncfsPT3
 ONMPMjFL8LIXpzLEBEyVgpP9joiLfEWjHKX3oJfy4SIRLjZKYTZ1HVQ4tXZJ9NBXBpj5
 7rvgvmOBaxLpH4ju0p+lmhb5oxaUzVIxmAYc6jUduBZpAelBSQVrUYowahrZdr+PtEM/
 ZToWPKNWv9JyuUKHQckIBY+i8Fb7PkOoJovQxetfeFPUVzXY4cnNEeFZzN7mmTyANncX
 gLsfo/+KuE3Ne79OUTcy5N5BSxB9w0NrDYFL+URKcFOWZinkeSwhECellLnJ726hjnwS
 YGIg==
X-Gm-Message-State: AOJu0YxludXeo7RIe3yYdlDhD1gSpXtPs7Fy+FLe76txj9f/shlOzTTE
 tKPQZtuO9ZZz2iiK55WEgxTTQ19EZOZuZZwZC4Si6WZEoMWVYgWrYXR5O4GGoeRL
X-Gm-Gg: ASbGnctGJx/8nwYAgTOtR2oRzyqpRz+6PdfYN5UtxvpLGW3cvirOkIrGoEGgheKKnEZ
 gddLWzKrR79jMsjUAnpTvyTy/eVCmQFCREe3mvSqaG0OsP5noJvMAu+GXjf3dIIy3957UUzABPg
 mKnpUu7SWD4fm5XXI2yS29mcq3VdCx8ao4ULG7bh9yRvfsewl2U+RjVJQauumwhyajsNG8UMwrP
 gOpnpK3kA4ksVpk1cux/Yi/EULl/ZAm3E+AW408hPqwSje72uAKyPpPg+BXpNx7NqmUilMTA3pU
 nmyKQnYXjIUpqeVf/Q62rzA/NJBGG8QQyTOuqX+3+g8z/9gR3lpVYuvBmfX5bQ==
X-Google-Smtp-Source: AGHT+IE3bTg77mYp0Gqg7dDcXaR17WMg/QLEhmadJTerTeUHFCXEHwP9priGGf7y7X+uOp+hVGTHow==
X-Received: by 2002:a05:6a20:43a4:b0:21a:eabb:ab93 with SMTP id
 adf61e73a8af0-21fbd495d38mr35657697637.6.1750349753997; 
 Thu, 19 Jun 2025 09:15:53 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2fe168a0f8sm13168683a12.53.2025.06.19.09.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 09:15:53 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v13 5/7] plugins: Add memory hardware address read/write API
Date: Thu, 19 Jun 2025 09:15:45 -0700
Message-ID: <20250619161547.1401448-6-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619161547.1401448-1-rowanbhart@gmail.com>
References: <20250619161547.1401448-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

This patch adds functions to the plugins API to allow plugins to read
and write memory via hardware addresses. The functions use the current
address space of the current CPU in order to avoid exposing address
space information to users. A later patch may want to add a function to
permit a specified address space, for example to facilitate
architecture-specific plugins that want to operate on them, for example
reading ARM secure memory.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 93 ++++++++++++++++++++++++++++++++++++
 plugins/api.c              | 97 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4167c46c2a..5eecdccc67 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -979,6 +979,99 @@ QEMU_PLUGIN_API
 bool qemu_plugin_write_memory_vaddr(uint64_t addr,
                                    GByteArray *data);
 
+/**
+ * enum qemu_plugin_hwaddr_operation_result - result of a memory operation
+ *
+ * @QEMU_PLUGIN_HWADDR_OPERATION_OK: hwaddr operation succeeded
+ * @QEMU_PLUGIN_HWADDR_OPERATION_ERROR: unexpected error occurred
+ * @QEMU_PLUGIN_HWADDR_OPERATION_DEVICE_ERROR: error in memory device
+ * @QEMU_PLUGIN_HWADDR_OPERATION_ACCESS_DENIED: permission error
+ * @QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS: address was invalid
+ * @QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS_SPACE: invalid address space
+ */
+enum qemu_plugin_hwaddr_operation_result {
+    QEMU_PLUGIN_HWADDR_OPERATION_OK,
+    QEMU_PLUGIN_HWADDR_OPERATION_ERROR,
+    QEMU_PLUGIN_HWADDR_OPERATION_DEVICE_ERROR,
+    QEMU_PLUGIN_HWADDR_OPERATION_ACCESS_DENIED,
+    QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS,
+    QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS_SPACE,
+};
+
+/**
+ * qemu_plugin_read_memory_hwaddr() - read from memory using a hardware address
+ *
+ * @addr: The physical address to read from
+ * @data: A byte array to store data into
+ * @len: The number of bytes to read, starting from @addr
+ *
+ * @len bytes of data is read from the current memory space for the current
+ * vCPU starting at @addr and stored into @data. If @data is not large enough to
+ * hold @len bytes, it will be expanded to the necessary size, reallocating if
+ * necessary. @len must be greater than 0.
+ *
+ * This function does not ensure writes are flushed prior to reading, so
+ * callers should take care when calling this function in plugin callbacks to
+ * avoid attempting to read data which may not yet be written and should use
+ * the memory callback API instead.
+ *
+ * This function is only valid for softmmu targets.
+ *
+ * Returns a qemu_plugin_hwaddr_operation_result indicating the result of the
+ * operation.
+ */
+QEMU_PLUGIN_API
+enum qemu_plugin_hwaddr_operation_result
+qemu_plugin_read_memory_hwaddr(uint64_t addr, GByteArray *data, size_t len);
+
+/**
+ * qemu_plugin_write_memory_hwaddr() - write to memory using a hardware address
+ *
+ * @addr: A physical address to write to
+ * @data: A byte array containing the data to write
+ *
+ * The contents of @data will be written to memory starting at the hardware
+ * address @addr in the current address space for the current vCPU.
+ *
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes place,
+ * so callers should take care when calling this function in plugin callbacks to
+ * avoid depending on the existence of data written using this function which
+ * may be overwritten afterward. In addition, this function requires that the
+ * pages containing the address are not locked. Practically, this means that you
+ * should not write instruction memory in a current translation block inside a
+ * callback registered with qemu_plugin_register_vcpu_tb_trans_cb.
+ *
+ * You can, for example, write instruction memory in a current translation block
+ * in a callback registered with qemu_plugin_register_vcpu_tb_exec_cb, although
+ * be aware that the write will not be flushed until after the translation block
+ * has finished executing.  In general, this function should be used to write
+ * data memory or to patch code at a known address, not in a current translation
+ * block.
+ *
+ * This function is only valid for softmmu targets.
+ *
+ * Returns a qemu_plugin_hwaddr_operation_result indicating the result of the
+ * operation.
+ */
+QEMU_PLUGIN_API
+enum qemu_plugin_hwaddr_operation_result
+qemu_plugin_write_memory_hwaddr(uint64_t addr, GByteArray *data);
+
+/**
+ * qemu_plugin_translate_vaddr() - translate virtual address for current vCPU
+ *
+ * @vaddr: virtual address to translate
+ * @hwaddr: pointer to store the physical address
+ *
+ * This function is only valid in vCPU context (i.e. in callbacks) and is only
+ * valid for softmmu targets.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr);
+
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
  *
diff --git a/plugins/api.c b/plugins/api.c
index 1f64a9ea64..eac04cc1f6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,6 +39,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
+#include "system/memory.h"
 #include "tcg/tcg.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
@@ -494,6 +495,102 @@ bool qemu_plugin_write_memory_vaddr(uint64_t addr, GByteArray *data)
     return true;
 }
 
+enum qemu_plugin_hwaddr_operation_result
+qemu_plugin_read_memory_hwaddr(hwaddr addr, GByteArray *data, size_t len)
+{
+#ifdef CONFIG_SOFTMMU
+    if (len == 0) {
+        return QEMU_PLUGIN_HWADDR_OPERATION_ERROR;
+    }
+
+    g_assert(current_cpu);
+
+
+    int as_idx = cpu_asidx_from_attrs(current_cpu, MEMTXATTRS_UNSPECIFIED);
+    AddressSpace *as = cpu_get_address_space(current_cpu, as_idx);
+
+    if (as == NULL) {
+        return QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS_SPACE;
+    }
+
+    g_byte_array_set_size(data, len);
+    MemTxResult res = address_space_rw(as, addr,
+                                       MEMTXATTRS_UNSPECIFIED, data->data,
+                                       data->len, false);
+
+    switch (res) {
+    case MEMTX_OK:
+        return QEMU_PLUGIN_HWADDR_OPERATION_OK;
+    case MEMTX_ERROR:
+        return QEMU_PLUGIN_HWADDR_OPERATION_DEVICE_ERROR;
+    case MEMTX_DECODE_ERROR:
+        return QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS;
+    case MEMTX_ACCESS_ERROR:
+        return QEMU_PLUGIN_HWADDR_OPERATION_ACCESS_DENIED;
+    default:
+        return QEMU_PLUGIN_HWADDR_OPERATION_ERROR;
+    }
+#else
+    return QEMU_PLUGIN_HWADDR_OPERATION_ERROR;
+#endif
+}
+
+enum qemu_plugin_hwaddr_operation_result
+qemu_plugin_write_memory_hwaddr(hwaddr addr, GByteArray *data)
+{
+#ifdef CONFIG_SOFTMMU
+    if (data->len == 0) {
+        return QEMU_PLUGIN_HWADDR_OPERATION_ERROR;
+    }
+
+    g_assert(current_cpu);
+
+    int as_idx = cpu_asidx_from_attrs(current_cpu, MEMTXATTRS_UNSPECIFIED);
+    AddressSpace *as = cpu_get_address_space(current_cpu, as_idx);
+
+    if (as == NULL) {
+        return QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS_SPACE;
+    }
+
+    MemTxResult res = address_space_rw(as, addr,
+                                       MEMTXATTRS_UNSPECIFIED, data->data,
+                                       data->len, true);
+    switch (res) {
+    case MEMTX_OK:
+        return QEMU_PLUGIN_HWADDR_OPERATION_OK;
+    case MEMTX_ERROR:
+        return QEMU_PLUGIN_HWADDR_OPERATION_DEVICE_ERROR;
+    case MEMTX_DECODE_ERROR:
+        return QEMU_PLUGIN_HWADDR_OPERATION_INVALID_ADDRESS;
+    case MEMTX_ACCESS_ERROR:
+        return QEMU_PLUGIN_HWADDR_OPERATION_ACCESS_DENIED;
+    default:
+        return QEMU_PLUGIN_HWADDR_OPERATION_ERROR;
+    }
+#else
+    return QEMU_PLUGIN_HWADDR_OPERATION_ERROR;
+#endif
+}
+
+bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
+{
+#ifdef CONFIG_SOFTMMU
+    g_assert(current_cpu);
+
+    uint64_t res = cpu_get_phys_page_debug(current_cpu, vaddr);
+
+    if (res == (uint64_t)-1) {
+        return false;
+    }
+
+    *hwaddr = res | (vaddr & ~TARGET_PAGE_MASK);
+
+    return true;
+#else
+    return false;
+#endif
+}
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.49.0


