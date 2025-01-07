Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD8EE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 12:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV9AH-0002gm-1i; Tue, 07 Jan 2025 07:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tV9AF-0002gS-Ly
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:58:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tV9AD-0005np-BK
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736254706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ng8RFocGVTOvADJ5kGqvR/jNKINXH+huDBiOymsbcFs=;
 b=KFe78zImhzEXUl53wvlgIem1DGOoBZ7KY5T0Fj4u/UODna8+c+3AB10PekkBIKXafFYtqF
 M9o1lC3IkGnZC58VMtK5yOImS7IyiTw6tcx92VSZYweSHykZddXqVCOHMr8KMsKvnF9qjs
 QCzJxPkzcajdmdfTexIm1Z+rAiDB+1o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-pPGZN9dvNM2xU3Ny1x8mYQ-1; Tue, 07 Jan 2025 07:58:24 -0500
X-MC-Unique: pPGZN9dvNM2xU3Ny1x8mYQ-1
X-Mimecast-MFC-AGG-ID: pPGZN9dvNM2xU3Ny1x8mYQ
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f46b7851fcso29988179a91.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 04:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736254703; x=1736859503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ng8RFocGVTOvADJ5kGqvR/jNKINXH+huDBiOymsbcFs=;
 b=HsvCgtGWpzw/EEXXZ6YpOaJMgsJ29I0ntpA5WbmSLXd+HZ0agkNRk0u6o5NKc90r+m
 To2OY0yQxOpwZDok8Im8NHQMSxFhVb/OsFqQu9CgB5xkmosgIRkchWuPPNg2vjpyPpEY
 uG7xFfPlBn84SHtDSH9u35xxDhbFw7NwaRelklRmJMPvx0QPi8EOBlfOOTzvyuG4O32v
 Yo03Z4NrgReD8lWMTbZMNmCCjbfobIyushzz6S3FZTm+nCbA/kAV76KCvPJdhqvE7pTB
 4NcFjvNuu3D6KSKEvq7E9AexUfm5raGbUg7qM0beqmSbF5YDrbbVKz1boMOYWzP9FyFw
 PjQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSl2ltG3z8RwVW2QhegotY7OkifKoGF9afWSxjbW/EpxCzUD8It9MW3lP5EMlIH36yyJLAAQHf9II2@nongnu.org
X-Gm-Message-State: AOJu0YzIEtcDID0W+2Zf8SFTcnkWcbVEiJFBsMyPURL9GJnwkASAlFDM
 8lBk2LNe2AfdO7mnJ4KI+vm2d5qozyC0cQS6lFSHTuULCAsMrSPdy9oWhwTUjeSpXS9OPnZRsyc
 Vncg05HvAK6vtsTcE8FjU6DYMbpgoHP9KBsB9+ae9MFPP9MiqTPbS
X-Gm-Gg: ASbGncuRsjIKQ6s8rOgtELTVYj0f+O/CVYd35vl40XBXiRyUD1Nh1KZFsItJlW+pf8z
 QbA1XSrPGmD9Z3E18lwVtly9ne4q++8U7LFaWTx77le3NoPiZZ9RifZNFEccIuzG/5PQ6Etb75r
 Yy8yakj3Vr3n86mJsVm//qY5Sjqh6MaFK+ZuhXci8enXZBqWswkF6duPgE+diDT4tA02F0GnYzv
 yOL/M6hSUNaHyK6mN5WRArnb8BvkyFhjDxDYGVxWHK3EBP38/e9e6WzYW4sA2RzSwIcip+UyF40
 Lv7K
X-Received: by 2002:a17:90b:524f:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f452e2259emr115337245a91.12.1736254703423; 
 Tue, 07 Jan 2025 04:58:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4BYFS+JRZ3ajxaqBN7ajDE0bdnrzyHGtR507lKc5ToPdI5199sfaKymIHddpv9+mTTRF4aQ==
X-Received: by 2002:a17:90b:524f:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f452e2259emr115337211a91.12.1736254703042; 
 Tue, 07 Jan 2025 04:58:23 -0800 (PST)
Received: from localhost.localdomain ([115.96.125.221])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2f4633df7c0sm31977199a91.18.2025.01.07.04.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 04:58:22 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: armbru@redhat.com, Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH] tests/qtest/libqos: add DMA support for writing and reading
 fw_cfg files
Date: Tue,  7 Jan 2025 18:28:02 +0530
Message-ID: <20250107125802.139479-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
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

At present, the libqos/fw_cfg.c library does not support the modern DMA which
is required to write to the fw_cfg files. It only uses the IO interface.
Implement read and write methods based on DMA. This will enable developers to
write tests that writes to the fw_cfg file(s). The structure of the code is
taken from edk2 fw_cfg implementation. It has been tested by writing a qtest
that writes to a fw_cfg file. This test will be part of a future patch series.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/libqos/fw_cfg.c | 150 ++++++++++++++++++++++++++++++++++++
 tests/qtest/libqos/fw_cfg.h |   4 +
 2 files changed, 154 insertions(+)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 89f053ccac..1b855fbb15 100644
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
@@ -60,6 +62,59 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static void
+qfw_cfg_dma_transfer(QFWCFG *fw_cfg, void *address, uint32_t length,
+                     uint32_t control)
+{
+    FWCfgDmaAccess access;
+    uint32_t addr;
+    QGuestAllocator guest_malloc;
+    uint64_t guest_access_addr;
+    uint64_t gaddr;
+
+    pc_alloc_init(&guest_malloc, fw_cfg->qts, ALLOC_NO_FLAGS);
+
+    /* create a data buffer in guest memory */
+    gaddr = guest_alloc(&guest_malloc, length);
+    g_assert(gaddr);
+    qtest_bufwrite(fw_cfg->qts, gaddr, address, length);
+
+    access.address = cpu_to_be64(gaddr);
+    access.length = cpu_to_be32(length);
+    access.control = cpu_to_be32(control);
+
+    guest_access_addr = guest_alloc(&guest_malloc, sizeof(access));
+    g_assert(guest_access_addr);
+    qtest_bufwrite(fw_cfg->qts, guest_access_addr, &access, sizeof(access));
+
+    /* lower 32 bits */
+    addr = cpu_to_be32((uint32_t)(uintptr_t)guest_access_addr);
+    qtest_outl(fw_cfg->qts, fw_cfg->base + 8, addr);
+    /* upper 32 bits */
+    addr = cpu_to_be32((uint32_t)(uintptr_t)(guest_access_addr >> 32));
+    qtest_outl(fw_cfg->qts, fw_cfg->base + 4, addr);
+
+    g_assert(!(be32_to_cpu(access.control) & FW_CFG_DMA_CTL_ERROR));
+
+    guest_free(&guest_malloc, guest_access_addr);
+    guest_free(&guest_malloc, gaddr);
+    alloc_destroy(&guest_malloc);
+}
+
+static void
+qfw_cfg_write_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, int len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_WRITE);
+}
+
+static void
+qfw_cfg_read_entry(QFWCFG *fw_cfg, uint16_t key, void *buf, int len)
+{
+    qfw_cfg_select(fw_cfg, key);
+    qfw_cfg_dma_transfer(fw_cfg, buf, len, FW_CFG_DMA_CTL_READ);
+}
+
 /*
  * The caller need check the return value. When the return value is
  * nonzero, it means that some bytes have been transferred.
@@ -104,6 +159,101 @@ size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
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
+ */
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
+                         void *data, size_t buflen)
+{
+    uint32_t count;
+    uint32_t i;
+    unsigned char *filesbuf = NULL;
+    size_t dsize;
+    size_t len = 0;
+    FWCfgFile *pdir_entry;
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count = be32_to_cpu(count);
+    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf = g_malloc(dsize);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
+    for (i = 0; i < count; ++i, ++pdir_entry) {
+        if (!strcmp(pdir_entry->name, filename)) {
+            len = be32_to_cpu(pdir_entry->size);
+            uint16_t sel = be16_to_cpu(pdir_entry->select);
+            if (len > buflen) {
+                len = buflen;
+            }
+            qfw_cfg_read_entry(fw_cfg, sel, data, len);
+            break;
+        }
+    }
+    g_free(filesbuf);
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
+ */
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
+                          void *data, size_t buflen)
+{
+    uint32_t count;
+    uint32_t i;
+    size_t len = 0;
+    uint32_t id;
+    unsigned char *filesbuf = NULL;
+    size_t dsize;
+    FWCfgFile *pdir_entry;
+
+    /* write operation is only valid if DMA is supported */
+    id = qfw_cfg_get_u32(fw_cfg, FW_CFG_ID);
+    g_assert(id & FW_CFG_VERSION_DMA);
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count = be32_to_cpu(count);
+    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf = g_malloc(dsize);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    pdir_entry = (FWCfgFile *)(filesbuf + sizeof(uint32_t));
+    for (i = 0; i < count; ++i, ++pdir_entry) {
+        if (!strcmp(pdir_entry->name, filename)) {
+            len = be32_to_cpu(pdir_entry->size);
+            uint16_t sel = be16_to_cpu(pdir_entry->select);
+            if (len > buflen) {
+                len = buflen;
+            }
+            qfw_cfg_write_entry(fw_cfg, sel, data, len);
+            break;
+        }
+    }
+    g_free(filesbuf);
+    return len;
+}
+
 static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
 {
     uint8_t *ptr = data;
diff --git a/tests/qtest/libqos/fw_cfg.h b/tests/qtest/libqos/fw_cfg.h
index b0456a15df..62221a9500 100644
--- a/tests/qtest/libqos/fw_cfg.h
+++ b/tests/qtest/libqos/fw_cfg.h
@@ -33,6 +33,10 @@ uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                         void *data, size_t buflen);
+size_t qfw_cfg_write_file(QFWCFG *fw_cfg, const char *filename,
+                          void *data, size_t buflen);
+size_t qfw_cfg_read_file(QFWCFG *fw_cfg, const char *filename,
+                         void *data, size_t buflen);
 
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 void mm_fw_cfg_uninit(QFWCFG *fw_cfg);
-- 
2.45.2


