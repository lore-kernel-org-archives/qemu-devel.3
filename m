Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D9EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyXG-0005OX-FN; Mon, 02 Jun 2025 02:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLQ-0006dD-Tp
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:41 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uLyLO-00026Y-Lg
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 02:08:24 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-747ef5996edso230741b3a.0
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748844501; x=1749449301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZm+6Hf7yjTndCGJAZXhWR9OV/ex2x6ZVedPPTJsqTo=;
 b=eEQOAlM260eeyLl8+vkofeDCnbulysURFn66eF6+e52cdRoZTQpHOeUj9GhPGTYx1A
 /ejeunai7zUXqAh44xT/tZTdcT+iBJ/MCgAFuJ84Ky4r7vy0LHFBxgGJLp4osO4zOg+5
 Ik2lzCASeQ/1YlmuDNM+UjbLrilBgPCjTO0rwMv5KgQS46SaPianwz5huEyC38hmFPOB
 Hxi6s35hPluHR32IOtoPg2rWp/DxTEsPAIaUEaGZKkf4MgwJs5KnIPmCmkNS7QzmS02E
 /XYyuqWGvm+S64jXD4TyA5aZ1o2nplbud/lZf5spDAckvrGjShpd3UAc/m9dcFhD6h14
 +rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748844501; x=1749449301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZm+6Hf7yjTndCGJAZXhWR9OV/ex2x6ZVedPPTJsqTo=;
 b=WL9Dfcr293ms/0JFbrTY+mEflYSvG/SlSl4aZCGMXQVStkLRQehQFGbZghUdCBSM3W
 5ol749GQGFDWAyu4rQqgcpj71DwmHNEhEgRo43IXohTf/co+pVUBPuuskpL/ri0lSUPd
 xN5YzStl+OibiZWc4TxXH5y5mR0PNh7D56u8JkZXk0fsLtEZg7k/BWJtg+IzLWPAc9F0
 PF2ea2Q7wutbxRdgntDLCi1FDu7XiaOL8dLde5+edYUQ+wSp2k7hkX8LTzyjWvQYIVHw
 5dEK3n5zJA503nOkpbujcGqfMwFnojIuH+DD/eN+1l/KG2kpQuUOvMKG66X5sqpi/9wa
 Pvgw==
X-Gm-Message-State: AOJu0Yx5Fz4+8vVw5oqvc86SowvaYaajg0O/aYKEijwAqfQY10vrKFok
 9ZF3i1xGk4/WrteCLrz7EiPGDARj0bgx+i3mQt7/6ZDb3a+wUxLhEfntYxDx701Bk9k=
X-Gm-Gg: ASbGncu2ATz8KQS1hTcgHRR9UzxsoMg3UVaKuQV7I6IdgFbIiL6SPj+xawm9zo10k9P
 H9fypZXJoTiN1xTW+AifNjJArCtiuxTa1vjlLO5Cr3mu8yzseBi5Fehx3ib4I2tL9OKhGUdfJyC
 6oYHhTEDvMwk496HMvFQyWORcELW8+zl3bRMwaTw9B1ge/DzsABe3ryT/PrflMDA3SsbQ0+ByHJ
 CM+JzcJA+vcu9TqMisGjJg7xw4sEsqe0LrMHBshL87KMTbHbwBkFs9UAJEqO0KBMdI7cWKT9+Z+
 w6tCo9xgUwnc7NajIjYTxELsPG1AKpNaxb4PD0lRqAztSTT2nXM=
X-Google-Smtp-Source: AGHT+IEC6qZ8YU7uvsXEGUm1BYyb2TPBYQKcvVTFoi9WK/UylpvWoPY0UTxl5Aer289D8luuECXZYA==
X-Received: by 2002:a05:6a00:3d56:b0:73c:b86:b47f with SMTP id
 d2e1a72fcca58-747c1a4931dmr16315395b3a.4.1748844501002; 
 Sun, 01 Jun 2025 23:08:21 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afff7388sm7036966b3a.171.2025.06.01.23.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 23:08:20 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 novafacing <rowanbhart@gmail.com>
Subject: [PATCH v6 5/9] plugins: Add memory hardware address read/write API
Date: Sun,  1 Jun 2025 23:08:11 -0700
Message-ID: <20250602060815.328261-6-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602060815.328261-1-rowanbhart@gmail.com>
References: <20250602060815.328261-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x42a.google.com
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

Signed-off-by: novafacing <rowanbhart@gmail.com>
Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
---
 include/qemu/qemu-plugin.h | 93 ++++++++++++++++++++++++++++++++++++
 plugins/api.c              | 97 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 8ae7758b95..2cb5de9f64 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -969,6 +969,99 @@ QEMU_PLUGIN_API
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
index 7258b6590b..a0d980e113 100644
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


