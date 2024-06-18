Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A26C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbMT-0001YD-8P; Tue, 18 Jun 2024 12:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMR-0001H7-4u
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbMO-0007uG-VW
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:07:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35f236a563cso4389520f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726822; x=1719331622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkNlA20kHSDOIhmvlUTbRhNSgQ9/ouK3bJTAy3+65gs=;
 b=K7mxt/1dw2SasnYObYDz1LqPBxiGDT7KbiimwIS9whMbTdkxl2hhvWLpZ8ug2nujR9
 KTnU5mhDCyCIXF1mEzDKdBhSOxgi01gGHrwWMIVuda/m0tLkoiLnw+ZFGnmqFLhsHifK
 tiBJ4+NRNcP3WK4X22XhO8C5B1lMKo5a4S3vVtKcOthpIz4wOxG25GxL1fJ//fMy1Xt9
 +bgqMN0wyJRI65LFEmRKCuDPQCgZzdjOuRFE93XnoFeYThKdu13XYnaLeD5xirmEKIZG
 xBVsAaVda7EwZn4e8oWRwseG+bC+osD3VKm5ee0ZOI3hRIVxga5jt7eQcQBm4XtWylvx
 Nz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726822; x=1719331622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hkNlA20kHSDOIhmvlUTbRhNSgQ9/ouK3bJTAy3+65gs=;
 b=mOhDDsJv5cutSfpq0ydJeyBpjjprXT2XyRZBIZ7omzrTfccddVcfSf9E/9MPyMC7M7
 X7VGf/BhOZy5JjE9cEQnp9x3kofcseD3wZxmlEvM4HxyBv9Fa2L9Amkn/f1jmWrkoE+6
 tOKBH5/YtugpGo/XDAQomZ+4C+j64esfSQ77xlfOF2daJ750OFi/uMEACJcueIIXWJ1d
 h/qOBN0no1Wht2kIUR81WDFuZfy/kcV8ahao73Wzt0PsY/tN4bQhrwQmPUMr0t7p4Ac7
 z3oZ4guHeT6CxTrmxuCjZJxk4mhV+fTbGiNpwVhWjVqo9RxsclfFC1mCzwudF7QycUoz
 AcAg==
X-Gm-Message-State: AOJu0YxuHucdRsftwQsvMX6zcui8glP28TdWLtx6W+6vKLJjdV8HdvVs
 C8T9nkzEVad+wDt/9fF3wZTyLOyFVtncsczH4aEi9Zn8xpVVTUWucwt2jNWl2TDpweRZafuv0jb
 8
X-Google-Smtp-Source: AGHT+IEbB83dKIxOCyLw1c7xPw+Anhge64bGApGjYqbe7gAShJ/ZUxrDlWsDHtrlPDLfyJohzUjJOw==
X-Received: by 2002:a05:6000:104:b0:35f:2774:9c2f with SMTP id
 ffacd0b85a97d-363192d07bcmr16723f8f.49.1718726822753; 
 Tue, 18 Jun 2024 09:07:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607a43eedfsm12693341f8f.78.2024.06.18.09.07.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:07:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 66/76] hw/s390x: Introduce s390_skeys_get|set() helpers
Date: Tue, 18 Jun 2024 18:00:28 +0200
Message-ID: <20240618160039.36108-67-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240613104415.9643-2-philmd@linaro.org>
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


