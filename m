Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B525E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 13:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVVgq-00029S-H8; Wed, 08 Jan 2025 08:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVVgG-0001xy-Nx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:01:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVVgE-0000nl-4T
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 08:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736341256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ppSLB3jimQ6+BATOek5pxkP9Z7kOydZOb/ezrFK1uM8=;
 b=f9kgPhXxoIK+HxOaluSd75VXm2pkILCSyluia5v3V5CG+KgLBC79dx9j6kkuZVh+RNKfNF
 uVBeM6LweMAFrK9eidxPJkOUJIwJrAwpiVHN02DFk6omJN10DZ05yazBJhXg1RrRtFkhbL
 ElF5HfR3GlifdiPBWtu5sWXFqSeGghc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-MOjYHF-IMf-rqAXtUYBMLw-1; Wed, 08 Jan 2025 08:00:54 -0500
X-MC-Unique: MOjYHF-IMf-rqAXtUYBMLw-1
X-Mimecast-MFC-AGG-ID: MOjYHF-IMf-rqAXtUYBMLw
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-21661949f23so403655025ad.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 05:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736341253; x=1736946053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ppSLB3jimQ6+BATOek5pxkP9Z7kOydZOb/ezrFK1uM8=;
 b=fRLaMc0xaweIJH/1OWWLhkgkflzNQ+FqlkFbk9prBSPeYaE6cVJw2wK3QfPUM2UyGc
 ZECIbKZnyuWXRZXyREO1oNBJ8moy3o3yl3TflMElIRzduyXO8iyU6rN5CzdpcS3ngePJ
 0aqQwnkVGeMWO9pvCVc+4ghq4phlnKtiFHYyrjeVYwcIgyyhDln3zShuYbA/r8RM3rKX
 8v9xbuWRxEJpVY7mBf0gA7qF+Bv9yW47LiDl6Ywo/HdMLEAwPRAqlBNm90qo1R/uDRZS
 HnNfapW1DCtilZFqa7Yugi9igdFX43Avwjl/1fb/svzfo2++N/9i3DKX4wvwcbOYq0kN
 z/9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzVttteLJ2CR/WQfSUdpbLDGixRPnQIfoC9SqNMkEXLvkSyaNrh7cFasXGorFLfAfS77Ka9a2yVchX@nongnu.org
X-Gm-Message-State: AOJu0YwAui6MwMoF13V7j7XRLAmkCCVFk/LOuJrLpg+EXG8zMUNV6wge
 I6OkpgEj/xwWgk9XPm+eaLuuf7CS5P7SUXQgc3x9oBHcdicNmO8pfU/tQTI5R30qXl6TrAMtEiZ
 d+O0lT36wyg9nTON2g5JZpCmKQ5YL2pgwokQv0jS+1NDWEc4WFRXD
X-Gm-Gg: ASbGncuB1VIA8PUqzk1UD/B3OMcKDnGHgmSjgXEE6FaCbip1/kiAhlRBimDKxF9PVgt
 SbeSyMD477lb1Tbr1altopu1Dj2Z+Q6q8iAVhKqaVn+xiAy/jzMgPeiA0A3goSNluj2j46FK9ri
 00ZMXQHRykq32OH4wSyvPwMBODLwbRfDDNJMKy96NlK4qLIL9wN4T4AyUBdmzP90jMLUh/wFhRt
 svd4e19Cetuo+HOsgX3PkeotOzWxVEz6d87EJYiAupuQ9aSqW2lnuxYm7tyQOk53ogt8svttesX
 wKZk
X-Received: by 2002:a17:902:c406:b0:216:7ee9:21ff with SMTP id
 d9443c01a7336-21a83fdf307mr40158365ad.49.1736341252844; 
 Wed, 08 Jan 2025 05:00:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiNTfZyOObhjRooGwqC/Rhos+CVqc82/uBDoVVvVN9p0gYtHzB/U5lzV8LcwmbZUBHXwXpgA==
X-Received: by 2002:a17:902:c406:b0:216:7ee9:21ff with SMTP id
 d9443c01a7336-21a83fdf307mr40157195ad.49.1736341252092; 
 Wed, 08 Jan 2025 05:00:52 -0800 (PST)
Received: from localhost.localdomain ([202.88.221.111])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-842abd5920bsm32151393a12.6.2025.01.08.05.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:00:51 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: armbru@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH v3] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Wed,  8 Jan 2025 18:27:50 +0530
Message-ID: <20250108125751.199929-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

At present, the libqos/fw_cfg.c library does not support the modern DMA
interface which is required to write to the fw_cfg files. It only uses the IO
interface. Implement read and write methods based on DMA. This will enable
developers to write tests that writes to the fw_cfg file(s). The structure of
the code is taken from edk2 fw_cfg implementation. It has been tested by
writing a qtest that writes to a fw_cfg file. This test will be part of a
future patch series.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/libqos/fw_cfg.c | 204 ++++++++++++++++++++++++++++++++----
 tests/qtest/libqos/fw_cfg.h |   5 +
 2 files changed, 186 insertions(+), 23 deletions(-)

changelog:
v3: fix bugs and code reorg. More testing to make sure this actually
works.
v2: refactor common code into a helper.
diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 89f053ccac..02d16b098c 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -17,6 +17,8 @@
 #include "../libqtest.h"
 #include "qemu/bswap.h"
 #include "hw/nvram/fw_cfg.h"
+#include "malloc-pc.h"
+#include "libqos-malloc.h"
 
 void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
@@ -60,6 +62,99 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static void
+qfw_cfg_dma_transfer(QFWCFG *fw_cfg, QOSState *qs, void *address,
+                     uint32_t length, uint32_t control)
+{
+    FWCfgDmaAccess access;
+    uint32_t addr;
+    uint64_t guest_access_addr;
+    uint64_t gaddr;
+
+    /* create a data buffer in guest memory */
+    gaddr = guest_alloc(&qs->alloc, length);
+    g_assert(gaddr);
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
+    g_assert(guest_access_addr);
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
+static void
+qfw_cfg_write_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
+                    void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_WRITE);
+}
+
+static void
+qfw_cfg_read_entry(QFWCFG *fw_cfg, QOSState *qs, uint16_t key,
+                   void *buf, uint32_t len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, qs, buf, len, FW_CFG_DMA_CTL_READ);
+}
+
+static bool
+find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
+                uint16_t *sel, uint32_t *size)
+{
+    unsigned char *filesbuf = NULL;
+    uint32_t count;
+    size_t dsize;
+    FWCfgFile *pdir_entry;
+    uint32_t i;
+    bool found = false;
+
+    *size = 0;
+    *sel = 0;
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count = be32_to_cpu(count);
+    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf = g_malloc(dsize);
+    g_assert(filesbuf);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
+    for (i = 0; i < count; ++i, ++pdir_entry) {
+        if (!strcmp(pdir_entry->name, filename)) {
+            *size = be32_to_cpu(pdir_entry->size);
+            *sel = be16_to_cpu(pdir_entry->select);
+            found = true;
+            break;
+        }
+    }
+
+    g_free(filesbuf);
+    return found;
+}
+
 /*
  * The caller need check the return value. When the return value is
  * nonzero, it means that some bytes have been transferred.
@@ -73,37 +168,100 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
  * populated, it has received only a starting slice of the fw_cfg file.
  */
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
-                      void *data, size_t buflen)
+                        void *data, size_t buflen)
 {
-    uint32_t count;
-    uint32_t i;
-    unsigned char *filesbuf = NULL;
-    size_t dsize;
-    FWCfgFile *pdir_entry;
     size_t filesize = 0;
+    uint32_t len;
+    uint16_t sel;
 
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
-    count = be32_to_cpu(count);
-    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
-    filesbuf = g_malloc(dsize);
-    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
-    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
-    for (i = 0; i < count; ++i, ++pdir_entry) {
-        if (!strcmp(pdir_entry->name, filename)) {
-            uint32_t len = be32_to_cpu(pdir_entry->size);
-            uint16_t sel = be16_to_cpu(pdir_entry->select);
-            filesize = len;
-            if (len > buflen) {
-                len = buflen;
-            }
-            qfw_cfg_get(fw_cfg, sel, data, len);
-            break;
+    if (find_pdir_entry(fw_cfg, filename, &sel, &len)) {
+        filesize = len;
+        if (len > buflen) {
+            len = buflen;
         }
+        qfw_cfg_get(fw_cfg, sel, data, len);
     }
-    g_free(filesbuf);
+
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
+    return (size_t) len;
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
+    return (size_t) len;
+}
+
 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
 {
     uint8_t *ptr = data;
diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
index b0456a15df..63c1ac59d6 100644
--- a/tests/qtest/libqos/fw_cfg.h
+++ b/tests/qtest/libqos/fw_cfg.h
@@ -14,6 +14,7 @@
 #define LIBQOS_FW_CFG_H
 
 #include "../libqtest.h"
+#include "libqos.h"
 
 typedef struct QFWCFG QFWCFG;
 
@@ -33,6 +34,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                         void *data, size_t buflen);
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                          void *data, size_t buflen);
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, QOSState *qs, const char *filename,
+                         void *data, size_t buflen);
 
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
-- 
2.45.2


