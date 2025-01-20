Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133CEC02185
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 04:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZjZG-0004AB-0H; Sun, 19 Jan 2025 23:39:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZE-00049o-DN
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tZjZC-00004q-Ki
 for qemu-devel@nongnu.org; Sun, 19 Jan 2025 23:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737347953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sSec4nsvGyIYNNvt6WzLxqj9VgTUaOKwIDlDunuoFmY=;
 b=LkXEMDh3IIpR2v9FyV9udCgEdzvM9/S+ej5c2h4hxbD0S/kykCd/njF7dlkj5zZ6mPrNjn
 0foOc94GD6XX/R5qBt1l0WIhSBIAKeI2qVEtewHE8BvAlOTjmQgBDD5Lh9x9RZCG7emVdc
 WUjWS0Bq21HlZDE4fkBIPEd1M1Q0Z2g=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-2zwWEMf1MpG9Vgl-RFb0aw-1; Sun, 19 Jan 2025 23:39:10 -0500
X-MC-Unique: 2zwWEMf1MpG9Vgl-RFb0aw-1
X-Mimecast-MFC-AGG-ID: 2zwWEMf1MpG9Vgl-RFb0aw
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2163c2f32fdso125233265ad.2
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2025 20:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737347950; x=1737952750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sSec4nsvGyIYNNvt6WzLxqj9VgTUaOKwIDlDunuoFmY=;
 b=Dn8sWgJeYa1ZGZOK+lhfI12Y7Q4+tHfNXwlVU6bj9UN2xuD1huOwvv2IAiWwVZqt/2
 bxbIv16Wd2AzEg0bd7GnVDbwMAHuXtN8rQx2AUmNt5FUBx1/SFBdhVGrDyD83ekbjfvL
 YTqWcrtnE0d6zF5GvdoavXwWIxZEAYCiwLbLAKZhK9Ldhk6pKzpi9iaaEgcj2JmG9g9K
 zbKMnRWIOcC4FF3DxCjUzpodVsKjBSSTWcJkAQRqDRU8ZMX3GrbuS29mHsFoG1nRhH2S
 ngkLq27a32k7Og9Nau7A478vaGL8rlTj34neBHDPklozWF+1aJUgHdSd00Vy2bljZ9AL
 o94w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU81GAW+bsJ6QhMWFgo/guXYzZ1myybJoah25Cg2k2oBCFSQqvR/XbxkjiHMWNMFWZUB7oWK/+rL6Ai@nongnu.org
X-Gm-Message-State: AOJu0Yz9PN4+H1BwactW2MXWylvZkM9dxiq+zWI8dAo+vudOSl7TqIu7
 01xiG8/a12uXKRc/0uP7D36+i2WFN4l8v90xliE4DAm6fIsLO4p/uJ3sKTiZCDPHIDlOsC6YRZc
 s39gi3RugA7OjH9owfHXdwZvTzYINzwJ8ZMw5LJwWqJLkYBKvxJtD
X-Gm-Gg: ASbGnctPGZQsUPx5dhitD3gTt8L87VsEt+mVxurU0v/MqiUZSx20yErrJORoBoeZ4aS
 Us3CW9N7p+x+3G/WsSXCXTfv9vlOMZaigFhGLgbLCCVweapHxbAsqiRxCYWVw8lW73+gFDLPUdl
 OERLTBC9kt4W4LLz+rRAZBj79OkpMXlWIKC0USqvFCSENQA5+FKjAj0NgsYbyqLg2GkrQtwc9r5
 aTkbzh91KwkJu1eICBN1zo6j+ZxK2SXPibXqvyPGYxqjopr684xtUXTism86KB5x5b3NJx9zbNs
 TippjvSsnpIWyGMX
X-Received: by 2002:a05:6a21:100c:b0:1e0:d575:8d4f with SMTP id
 adf61e73a8af0-1eb215dadc7mr16970018637.37.1737347949696; 
 Sun, 19 Jan 2025 20:39:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF3hR9DRVG31HrdNWEGrggpE4g11WqV4Tf1iUTnuWcyBpMok+ZLQvnhbd9GQZNlkM93dWW2Q==
X-Received: by 2002:a05:6a21:100c:b0:1e0:d575:8d4f with SMTP id
 adf61e73a8af0-1eb215dadc7mr16969998637.37.1737347949369; 
 Sun, 19 Jan 2025 20:39:09 -0800 (PST)
Received: from localhost.localdomain ([115.96.115.34])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-a9bcc3232a4sm5889604a12.30.2025.01.19.20.39.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jan 2025 20:39:08 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v6 2/3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Mon, 20 Jan 2025 10:08:33 +0530
Message-ID: <20250120043847.954881-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250120043847.954881-1-anisinha@redhat.com>
References: <20250120043847.954881-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At present, the libqos/fw_cfg.c library does not support the modern DMA
interface which is required to write to the fw_cfg files. It only uses the IO
interface. Implement read and write methods based on DMA. This will enable
developers to add tests that writes to the fw_cfg file(s). The structure of
the code is taken from edk2 fw_cfg implementation. It has been tested by
writing a qtest that writes to a fw_cfg file.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/libqos/fw_cfg.c | 139 ++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/fw_cfg.h |   6 +-
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 22435873d9..0ab3959171 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -14,6 +14,8 @@
 
 #include "qemu/osdep.h"
 #include "fw_cfg.h"
+#include "malloc-pc.h"
+#include "libqos-malloc.h"
 #include "../libqtest.h"
 #include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
@@ -60,6 +62,60 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static void qfw_cfg_dma_transfer(QFWCFG *fw_cfg, QOSState *qs, void *address,
+                                 uint32_t length, uint32_t control)
+{
+    FWCfgDmaAccess access;
+    uint32_t addr;
+    uint64_t guest_access_addr;
+    uint64_t gaddr;
+
+    /* create a data buffer in guest memory */
+    gaddr = guest_alloc(&qs->alloc, length);
+
+    if (control & FW_CFG_DMA_CTL_WRITE) {
+        qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
+    }
+    access.address = cpu_to_be64(gaddr);
+    access.length = cpu_to_be32(length);
+    access.control = cpu_to_be32(control);
+
+    /* now create a separate buffer in guest memory for 'access' */
+    guest_access_addr = guest_alloc(&qs->alloc, sizeof(access));
+    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, sizeof(access));
+
+    /* write lower 32 bits of address */
+    addr = cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
+    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
+
+    /* write upper 32 bits of address */
+    addr = cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> 32));
+    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
+
+    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
+
+    if (control & FW_CFG_DMA_CTL_READ) {
+        qtest_bufread(fw_cfg->qts, gaddr, address, length);
+    }
+
+    guest_free(&qs->alloc, guest_access_addr);
+    guest_free(&qs->alloc, gaddr);
+}
+
+static void qfw_cfg_write_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
+                                void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_WRITE);
+}
+
+static void qfw_cfg_read_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
+                               void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_READ);
+}
+
 static bool find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
                             uint16_t *sel, uint32_t *size)
 {
@@ -121,6 +177,89 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
     return filesize;
 }
 
+/*
+ * The caller need check the return value. When the return value is
+ * nonzero, it means that some bytes have been transferred.
+ *
+ * If the fw_cfg file in question is smaller than the allocated & passed-in
+ * buffer, then the first len bytes were read.
+ *
+ * If the fw_cfg file in question is larger than the passed-in
+ * buffer, then the return value explains how much was actually read.
+ *
+ * It is illegal to call this function if fw_cfg does not support DMA
+ * interface. The caller should ensure that DMA is supported before
+ * calling this function.
+ *
+ * Passed QOSState pointer qs must be initialized. qs->alloc must also be
+ * properly initialized.
+ */
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                         void *data, size_t buflen)
+{
+    uint32_t len = 0;
+    uint16_t sel;
+    uint32_t id;
+
+    g_assert(qs);
+    g_assert(filename);
+    g_assert(data);
+    g_assert(buflen);
+    /* check if DMA is supported since we use DMA for read */
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    g_assert(id & FW_CFG_VERSION_DMA);
+
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        if (len > buflen) {
+            len = buflen;
+        }
+        qfw_cfg_read_entry(fw_cfg, qs, sel, data, len);
+    }
+
+    return len;
+}
+
+/*
+ * The caller need check the return value. When the return value is
+ * nonzero, it means that some bytes have been transferred.
+ *
+ * If the fw_cfg file in question is smaller than the allocated & passed-in
+ * buffer, then the buffer has been partially written.
+ *
+ * If the fw_cfg file in question is larger than the passed-in
+ * buffer, then the return value explains how much was actually written.
+ *
+ * It is illegal to call this function if fw_cfg does not support DMA
+ * interface. The caller should ensure that DMA is supported before
+ * calling this function.
+ *
+ * Passed QOSState pointer qs must be initialized. qs->alloc must also be
+ * properly initialized.
+ */
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                          void *data, size_t buflen)
+{
+    uint32_t len = 0;
+    uint16_t sel;
+    uint32_t id;
+
+    g_assert(qs);
+    g_assert(filename);
+    g_assert(data);
+    g_assert(buflen);
+    /* write operation is only valid if DMA is supported */
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    g_assert(id & FW_CFG_VERSION_DMA);
+
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        if (len > buflen) {
+            len = buflen;
+        }
+        qfw_cfg_write_entry(fw_cfg, qs, sel, data, len);
+    }
+    return len;
+}
+
 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
 {
     uint8_t *ptr = data;
diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
index b0456a15df..6d6ff09725 100644
--- a/tests/qtest/libqos/fw_cfg.h
+++ b/tests/qtest/libqos/fw_cfg.h
@@ -14,6 +14,7 @@
 #define LIBQOS_FW_CFG_H
 
 #include "../libqtest.h"
+#include "libqos.h"
 
 typedef struct QFWCFG QFWCFG;
 
@@ -33,7 +34,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                         void *data, size_t buflen);
-
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                          void *data, size_t buflen);
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                         void *data, size_t buflen);
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
 QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
-- 
2.45.2


