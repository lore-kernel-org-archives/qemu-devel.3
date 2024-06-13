Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B502C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 10:44:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHhwU-0005b7-4O; Thu, 13 Jun 2024 06:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHhwS-0005aa-MG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:44:28 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sHhwR-0003lL-1l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 06:44:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f11a2d18aso112848166b.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 03:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718275465; x=1718880265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bb2eJ+cyDtCSIGPEF3KqVqxXfOihaXK/Jl7Nmci3es=;
 b=IEm7m0QKwNqRAdgGf3g3MU9fwjH3MuZ1czncmcUUHrtl+pibdz5852pyqrei6GouKL
 tlBPvOe8lHFjNvIN5oPCuSBeCJHN5ww6SN4v6qCh6bCYxRNbuzs3fykJdvxXtstP0Fcx
 esWPiBP69LKyq87j2HHm5lDYyyz22Hn3bEeJnmYN1Mtw2KnsnjHOMU2zh8xLR6zQtRjL
 FpApOqg0gNzjRBnkhuY6S+qGMlx4+NG373mq194HIoUzUFAXIuRhLZLj02COpbhTiEeR
 CvDQU7H0wOCXrpBohmyZG3aftIxskUwJIsNKfU260cbcUcTKs9pCotTg3mCc18jiRLr5
 6wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718275465; x=1718880265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bb2eJ+cyDtCSIGPEF3KqVqxXfOihaXK/Jl7Nmci3es=;
 b=dgBoRKKV+macyE7uwSbE+E/yFcT9FS5/8WwWMx36W+YPbWHUyDKhV/Gu8ECEy3zUnx
 P3ZsyQPeCKHFwYwiwJuYHQrAgCGAsS8d9W2Yyv+vuH5YIE5FjUsMgmYRjM8QnFWj7ndy
 RSzcSNMfuHFNTC2gVlDAQ2jg+PpyXtw/kjsat3o2toMYUwUp4pH883zBNJe3r+x4SJOq
 V+YhsnBl0ikbKf56m55WKN7MJS1nyGHq6BjKNy1DrAu0GDluZsWPzjRXyvZXJJt5A9SN
 NkBkLNhEgAAn1AuBrUXPp3Nz/mdWgM+N4nW7LkLqOFOzdgueY+Ma8RtrJ/2waJP71Chj
 jRKg==
X-Gm-Message-State: AOJu0YzP4G2qro7nBfy0YVQomRyqfVzNBFZUulARQYNxK0xDMZUo89Y1
 Hp+9sWbcRauO70Q6OTQWi91ALzd0SthgUfeYVD1H7/vZKS952W/MdCAu5Kmz9evQkG61G/HQf9y
 7
X-Google-Smtp-Source: AGHT+IGZ6xpjrNhtT9l7cPXGVpT5vjAg82p6f9Xb846jzqNgGBq6FmSOr/UP4Nlu3zW00w6mRerzuw==
X-Received: by 2002:a17:906:489:b0:a6e:7e1f:2eae with SMTP id
 a640c23a62f3a-a6f4800b167mr270427666b.74.1718275465210; 
 Thu, 13 Jun 2024 03:44:25 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.148.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56ed0f2asm58863566b.131.2024.06.13.03.44.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 13 Jun 2024 03:44:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/2] hw/s390x: Introduce s390_skeys_get|set() helpers
Date: Thu, 13 Jun 2024 12:44:14 +0200
Message-ID: <20240613104415.9643-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240613104415.9643-1-philmd@linaro.org>
References: <20240613104415.9643-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

s390_skeys_set() dispatch to S390SKeysClass::set_skeys(),
and s390_skeys_get() to S390SKeysClass::get_skeys().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/s390x/storage-keys.h | 10 ++++++++++
 hw/s390x/s390-skeys.c           | 27 +++++++++++++++++++++++++++
 hw/s390x/trace-events           |  4 ++++
 3 files changed, 41 insertions(+)

diff --git a/include/hw/s390x/storage-keys.h b/include/hw/s390x/storage-keys.h
index aa2ec2aae5..976ffb2039 100644
--- a/include/hw/s390x/storage-keys.h
+++ b/include/hw/s390x/storage-keys.h
@@ -111,6 +111,16 @@ struct QEMUS390SKeysState {
 };
 
 void s390_skeys_init(void);
+/**
+ * @s390_skeys_get: See S390SKeysClass::get_skeys()
+ */
+int s390_skeys_get(S390SKeysState *ks, uint64_t start_gfn,
+                   uint64_t count, uint8_t *keys);
+/**
+ * @s390_skeys_set: See S390SKeysClass::set_skeys()
+ */
+int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
+                   uint64_t count, uint8_t *keys);
 
 S390SKeysState *s390_get_skeys_device(void);
 
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5c535d483e..bf22d6863e 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -23,6 +23,7 @@
 #include "sysemu/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
+#include "trace.h"
 
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
 #define S390_SKEYS_SAVE_FLAG_EOS 0x01
@@ -54,6 +55,32 @@ void s390_skeys_init(void)
     qdev_realize(DEVICE(obj), NULL, &error_fatal);
 }
 
+int s390_skeys_get(S390SKeysState *ks, uint64_t start_gfn,
+                   uint64_t count, uint8_t *keys)
+{
+    S390SKeysClass *kc = S390_SKEYS_GET_CLASS(ks);
+    int rc;
+
+    rc = kc->get_skeys(ks, start_gfn, count, keys);
+    if (rc) {
+        trace_s390_skeys_get_nonzero(rc);
+    }
+    return rc;
+}
+
+int s390_skeys_set(S390SKeysState *ks, uint64_t start_gfn,
+                   uint64_t count, uint8_t *keys)
+{
+    S390SKeysClass *kc = S390_SKEYS_GET_CLASS(ks);
+    int rc;
+
+    rc = kc->set_skeys(ks, start_gfn, count, keys);
+    if (rc) {
+        trace_s390_skeys_set_nonzero(rc);
+    }
+    return rc;
+}
+
 static void write_keys(FILE *f, uint8_t *keys, uint64_t startgfn,
                        uint64_t count, Error **errp)
 {
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index 34da5ea323..4e74bf4484 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -36,3 +36,7 @@ s390_pci_unknown(const char *msg, uint32_t cmd) "%s unknown command 0x%x"
 s390_pci_bar(uint32_t bar, uint32_t addr, uint64_t size, uint32_t barsize) "bar %d addr 0x%x size 0x%" PRIx64 "barsize 0x%x"
 s390_pci_nodev(const char *cmd, uint32_t fh) "%s no pci dev fh 0x%x"
 s390_pci_invalid(const char *cmd, uint32_t fh) "%s invalid space fh 0x%x"
+
+# s390-skeys.c
+s390_skeys_get_nonzero(int rc) "SKEY: Call to get_skeys unexpectedly returned %d"
+s390_skeys_set_nonzero(int rc) "SKEY: Call to set_skeys unexpectedly returned %d"
-- 
2.41.0


