Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D3AE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnJ6-0002Yz-4d; Thu, 09 Jan 2025 02:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVnJ3-0002Vl-2e
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVnJ0-0003CI-24
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736409012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaRJxWcAFRAcR7btfli+8r+mFUekYuawowvU50+NEqo=;
 b=U+1qbaFfxarJOx1uZX0as8ftcKRvKDhgsBcQgpGqX7RRYbKXG3zjQ6M0GGC1ZNmfTK91px
 aJuvO/Y6SmUY1KLJRSI617RgMmIdpA0R/iewthahwp+2sG4nYG6Blxp+gAGlKXSqXxw98a
 30AiEkTtxnvEcjNYbSZJEKM903C4DqA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-Nvj5HpJkMU-cH7-uaVrWLg-1; Thu, 09 Jan 2025 02:50:10 -0500
X-MC-Unique: Nvj5HpJkMU-cH7-uaVrWLg-1
X-Mimecast-MFC-AGG-ID: Nvj5HpJkMU-cH7-uaVrWLg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef775ec883so1180055a91.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 23:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736409010; x=1737013810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uaRJxWcAFRAcR7btfli+8r+mFUekYuawowvU50+NEqo=;
 b=URYwT0RqaFk2geroB/xLOfstHNgEJyHQylXW9qXmKupgf6BkKCpruNXmGFYTXEm4m/
 8FeigBPPIrtg6bKrcF1B457mnepAfyBqCW91bP4jCf47qbNiaGzYcMUNNLKo++0W8K42
 2jpD10oPvPOhhDiLwdUnwU8kLd4Ou95w8PybvNt1C7c7Mtbo5Z6VGeUhTqmzZAsdsBV4
 HcXMC7lEDKBdvrmWme/lRmK1JRZ8TwyT4dRqG/3/Vi+GHC1gR6POknptJYQ3gcobPBBT
 PWTsCM0phhWi8d4KpieIAQ/C75JewT8gIcoNkCteqQna2g98tZHlqw6CfWhcBtYSjDwj
 7zGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1qBi9oqeHK1r4t2murIFx9U8Bw37J2qfYs1qS9L8ZMHJDOJgsbaX3YKW7oHnjxBM0Utg0b8whSgQ+@nongnu.org
X-Gm-Message-State: AOJu0YzongMaEU66+OXloCrk5AcmfRyRZx8bYYUDpELyJL/NyZ6oriej
 uWy293i5/ZnTDDekwIVvMU5b6BkcEM4qegMeGBQD4RoGpaZHnoEvKblYqAMhK2j7+EQikRs4SDt
 jJcwUXI2tq+h53tCocKjIHY8LJxAIEXDxij0HSKFNEJlhnDxicnWm
X-Gm-Gg: ASbGnctJkqm09EVklKX7sajKVvYE4EBREvevin3o0tci5L0gU8ba8AqzCI7TUP16gRq
 ySYSa9xALXGXl8esEeN4wtDa5RXuksdg5627bdZdexeISKI8/epCEhlPtvSwidALVHceA/nVLQa
 jp03ymOMT0x7j0svOw5VWJPeQHsxg0uOCvsP7i4y5h6BjmZnQEFYbC6o/plj89xYTbYa8lR9APk
 3oIqdYMb/nKr4qIjn+WpvAMPvCp4O3nEW6A8mrXIH8/xPVvGzs94nvP7gcMOSDlQ+Blm+Z+eEUg
 lU5y
X-Received: by 2002:a05:6a00:39a6:b0:724:e75b:22d1 with SMTP id
 d2e1a72fcca58-72d21ff524emr8218503b3a.16.1736409009560; 
 Wed, 08 Jan 2025 23:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwUZi4v3MmI8zuvxS64PeZ7KtQXKBNL59czfxZxU9+f3IzFl+L+5s6lys9ogJlaONGFdOfgg==
X-Received: by 2002:a05:6a00:39a6:b0:724:e75b:22d1 with SMTP id
 d2e1a72fcca58-72d21ff524emr8218463b3a.16.1736409009137; 
 Wed, 08 Jan 2025 23:50:09 -0800 (PST)
Received: from localhost.localdomain ([115.96.158.174])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-72aad8344desm36432128b3a.54.2025.01.08.23.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 23:50:08 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] libqos/fw_cfg: refactor file directory iteraton to
 make it more reusable
Date: Thu,  9 Jan 2025 13:19:28 +0530
Message-ID: <20250109074929.252339-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109074929.252339-1-anisinha@redhat.com>
References: <20250109074929.252339-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

fw-cfg file directory iteration code can be used by other functions that may
want to implement fw-cfg file operations. Refactor it into a smaller helper
so that it can be reused.

No functional change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/libqos/fw_cfg.c | 63 ++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 22 deletions(-)

diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
index 89f053ccac..f1ed4898f7 100644
--- a/tests/qtest/libqos/fw_cfg.c
+++ b/tests/qtest/libqos/fw_cfg.c
@@ -60,6 +60,39 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
 }
 
+static bool
+find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
+                uint16_t *sel, uint32_t *size)
+{
+    g_autofree unsigned char *filesbuf = NULL;
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
+    return found;
+}
+
 /*
  * The caller need check the return value. When the return value is
  * nonzero, it means that some bytes have been transferred.
@@ -75,32 +108,18 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
                       void *data, size_t buflen)
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
 
-- 
2.45.2


