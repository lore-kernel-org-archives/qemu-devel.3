Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0589BC61CE7
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 23:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOP7u-0005tW-2E; Sun, 08 Jun 2025 19:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7r-0005sU-W2
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uOP7q-0004be-0e
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 19:08:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-234f17910d8so35828185ad.3
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 16:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749424104; x=1750028904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dtNoXEYVk3QMlsCC8PNx5YghUZ6uaFkDa7CndlnIrec=;
 b=DO06OLYzFwkOJ19F447QcFeqdfgTf0B6qHC5KBzBDZgZ9LMFagRv6mtOijs4ioOT1W
 kJDB1A3CY6yVcotx4TfjitmvflpMhBz+B95yplYq7g1qckZY2+g5i4fPMMWtW7g+5TkF
 3Z2rt7vS4sKORbeMQXa1UYawXvg+I4k1km1B+Fl1BxRF28bo897Z1DsQgyBuAGxwz29G
 rAuyP08I2qhhRf4tuVRnxbSMhuQ/hddPUXtYZpL0OtVAAFWVuzI6RaO0vA8vj5HfFYNb
 lwh+wCHSTchxAiGGXisbZMHplT62o84qLj12SP9zlXuJvVig0nWZ1aYNRMQoccFSPdxf
 oQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749424104; x=1750028904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtNoXEYVk3QMlsCC8PNx5YghUZ6uaFkDa7CndlnIrec=;
 b=MshgxSeeu2J5LWXkjfGAj/Zl5T8lO+CCD5prtBDDDdt5QIC/xJwpEFHT5Gd5OnQBIk
 YmezaIERkGtnopbtdI1KLOp4HibKgps3B8XX8RTsZA4GRoiZw2FHLRV/LjEjDmgQRiw6
 BRvi7l8c+hrkqcPQqiq+Mi66sFBFENbXGGg+PZinZvWZFBdH1nVRKpSrqroY2B1INzj8
 6GPO/BcRDimiBaYvlTgcX1sw1rHFdmWXi9RSa83U/QET2sQ4aOQAjoE6gUZay/OHKTqW
 1aHRE9PTD0Zej78Ut1KKXFD73uXXwGeYpKlgRtQlmgL2Vwy1R4gQWfwSfgvT2YokGS2p
 gffQ==
X-Gm-Message-State: AOJu0Yy7lkcw4higEdixdrnwLjrsbeLx4AytauAKYTOCc1+hxW3uOyn6
 +Iy8eI/Tnet7hBUa9fu8QX+ZowATaJM7tfMIZAvhXhpjsKTwIG0uVzvEFSFfOVDSzXQ=
X-Gm-Gg: ASbGncuJhzWS79Mr1/A+is/SxuIGNI87/wBeGMpZ4wq+fQAbyfUaTWEUDeIKBOJ/5Hl
 uCYQs+f9/nqmaTUcXnO5ERpJsD7s5PU2MjDntwbKyRkTsYQ1RfuxFhNlniNBQwnt3SmGWhwm7bM
 XgMSkcfHYVpY0+6aVkcfp5hbwXta6En4aTKxgER/swk1itdjP/d3Sw+zyZWNIqj1E2Vm0AjX5kt
 DfqV0F50qegGffojlTO4zuX8PEKOz5vUpKeDc/0720zufH0RWIkMsVTogtsyy9NBDmXP4Km9B+x
 06Ed2zNq/coVDuT412Xdyn0LUvnw8mupVVHQRpvmoCtugwiO1TqvmQ7sXAiDYQ==
X-Google-Smtp-Source: AGHT+IFo50zQSfj39GoNY+RzVNvfsq4lhw5mFpyLyjZCR6tPW/CR/GsW+6PBu7DVhgN1Jl1yYr2Aqg==
X-Received: by 2002:a17:903:1cc:b0:234:a992:96d9 with SMTP id
 d9443c01a7336-23601d24825mr147297435ad.17.1749424104325; 
 Sun, 08 Jun 2025 16:08:24 -0700 (PDT)
Received: from shemhazi.lan ([50.46.174.34]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603504f09sm43421325ad.223.2025.06.08.16.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 16:08:23 -0700 (PDT)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH v9 5/9] plugins: Add memory hardware address read/write API
Date: Sun,  8 Jun 2025 16:08:15 -0700
Message-ID: <20250608230819.3382527-6-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608230819.3382527-1-rowanbhart@gmail.com>
References: <20250608230819.3382527-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=rowanbhart@gmail.com; helo=mail-pl1-x632.google.com
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


