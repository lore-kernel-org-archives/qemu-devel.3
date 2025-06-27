Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60289C7EE32
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DH-0005Ic-1A; Fri, 27 Jun 2025 07:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7DB-0005DL-Ca
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D4-0007Bu-4m
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so1224445f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023528; x=1751628328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vROHPevQAjKQjmyvEQacY79ixj69L9SYFGqLI9RnS08=;
 b=h4aMOEA45hUtTpoE2tzQyHG7ytHYV81rVliLkLmIhBNQLWe7PoRU95B00CenKXCSP1
 j+O0lRFe8vAyeVDUrkwQmp+yiGznBn6+HxDhY8ovTYtkOnpDT0qK5+1EePRQfwHIoPd0
 i4R9oIi0FzUU4Blr2fT617bUEtVdmFWM3EodA7km/M3x9jOD94DUpz0S/z7P5JT2PRXE
 SLWOa5Zxefld+b8obZ5zQCvkbWpp8ZyytK5PNlLJaDHQJVXWaOa/WFquQdPqkJueaYOG
 q6/I4M6vya1X2V0xD5mJoGsAnQEYZpBAUSMy1IDIugcf3VZVMDx2yhyxixuIYojUxQxu
 t3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023528; x=1751628328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vROHPevQAjKQjmyvEQacY79ixj69L9SYFGqLI9RnS08=;
 b=Vzh9NmJqsg09ddzDJK9iW0J8CscY69F+M4/8jas13D/u7feZ8PDAQPvYFj6AxQ8zXN
 Lrgb+ZcE3CCncghYWE2eaB940LDlYg8Hi23DyklntH/vH64H+yrFB3Te7VsuAYWTWBHI
 Rl0iMzS8Qb4CvgM7Kq63fh4Gpd2aF148EIyWjbkZ8KyZPASziRzZ8VFDBUvmmYqfGRxv
 gCW9yCV5C/78BRl5ljC+AmBiASv8AYyE5v6NkXs9473qhkuN3DFh51VCcVt6Foh0/dfi
 BGBT3TiR8ysJOV2gKyTZgA9dSxKOwiUuapW0LYKh8iFpjG23Dritt/Q8CKZXMUQKtxIr
 QK+A==
X-Gm-Message-State: AOJu0YwAgjNadiBc3iRGBf+UwG2zba/77gIXB6FMWIaL7nLqkgSuMrdf
 wjo/+mFvvTJmNGu77ho5fCUvW/NSv3ELbaaSOL+00W3jWOwzX++lfVc7RJvAc+8Avd8=
X-Gm-Gg: ASbGncvdzHUhUZd3bNSOPO51VGRanVZ1HB6ZeROKKpJuLPmIcBreUoXS3IhXxi4wEyg
 fHE9CRc2CvVNG5pnknj5WfUq6/YHDJU6/nnZMUN/he8uV0E/RojMCmJIHxFKg+Qz1xNFUbg9RsZ
 fDshh7s2NVGsR/VsJ5XXJS7MkYUuHEsxxuPqY4PmC21TP5PFEwo8Nhsr2vbFZ7yh66OmNP5BIJY
 y+czCnIYRKkTHVFdQf4eiDObZt/pBOkVgaQASW9vlomVZQQTNmOQhlvQr4OasCUXBwxzHdmnjIu
 mydfmO4x3uTwYExdb6k0YGe4vpLZCFPIGmvcjB1HQvZrUCOX5zDdMgLRfcbI/ew=
X-Google-Smtp-Source: AGHT+IEwAfzzqBy7KuhNDa32EnUVIIAT2vi+TZdLoLd8lRBCG6hZAaH6DNZ48SNGDzgaUV8usSCQkg==
X-Received: by 2002:a05:6000:4105:b0:3a4:e665:ca5 with SMTP id
 ffacd0b85a97d-3a8fe89162dmr2206265f8f.23.1751023527484; 
 Fri, 27 Jun 2025 04:25:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f923sm2375104f8f.89.2025.06.27.04.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 141715F90D;
 Fri, 27 Jun 2025 12:25:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>, Rowan Hart <rowanbhart@gmail.com>
Subject: [PATCH 09/15] plugins: Add memory hardware address read/write API
Date: Fri, 27 Jun 2025 12:25:05 +0100
Message-ID: <20250627112512.1880708-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

From: Rowan Hart <rowanbhart@gmail.com>

This patch adds functions to the plugins API to allow plugins to read
and write memory via hardware addresses. The functions use the current
address space of the current CPU in order to avoid exposing address
space information to users. A later patch may want to add a function to
permit a specified address space, for example to facilitate
architecture-specific plugins that want to operate on them, for example
reading ARM secure memory.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
Message-ID: <20250624175351.440780-6-rowanbhart@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.2


