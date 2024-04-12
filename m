Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AC4C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ4-0006zO-Ql; Fri, 12 Apr 2024 03:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ1-0006y7-Th
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ0-00075H-3C
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1e50a04c317so3846935ad.1
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907231; x=1713512031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QYzl2xtlupH583p6wNi2Q7esWD8H9kcrEe3HL6WSapw=;
 b=uDszS8zSHNzzM33hEt1IjGa3vNQ74URtC5Fx7HvDS3j7WfRTwarpkwGfYRULr/lr1Z
 vPumyb9ifl6X3LubvPWkmn5CEIf1UCo2lxl5BBwCQYA8QrF9hokpASM/w18rQnLLJlr7
 eXRMfSNrUOfv7bLwKHCLJtN3FPJpVW8HFci2HSQK47qmwOnk9hyDhpBQMzuDLEi/eHrD
 Ba6PFXjX6uhpWrypOldioR8o8zdMENhWxRg2ou0kdmaK+rNJ/uaXosL0Fqn+xbPOw771
 k9mtUCJG4T6UDnLaWMZNOOzLJ2zauLf0nljC56GmVkTpZjn1KXnogqHakVdFw+88/8B2
 sKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907231; x=1713512031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QYzl2xtlupH583p6wNi2Q7esWD8H9kcrEe3HL6WSapw=;
 b=CgBeT4JyOe/M9AW+nNUlIhftAi62lxWhHaeT9W1NBiH28amsKzn5js7NpsH/ksKtZR
 F1sdTSgg6iHLS3Vsmo6zOsSVFCMigPpMwKlZdpzKjWK5XQPCK4nNYwM6q2x8nBR2YAuH
 2tSvECOokg5p3QnBDh6F40AVu0dOx3pXnySbeQNnRha8tMA8ClGjeRSoIEwuqALNcqRX
 J+aioka5j9npL+290kOXYaI6rvyj6lmkggIoHl+neh0OqLmiMojGDZeqzhDrmZfnlBuH
 M+KoIowBANaB7L9sgbVx8HOSD8N+wwBlZ4p8PlgvkpF1h8+2yBLk+YdxXyACezb4llRM
 QM6w==
X-Gm-Message-State: AOJu0YwtnlDb6YHrgrLIhL49GXIbE5tRvzkIerwzVv7bPm9UrQFDIQ0Z
 xLDdbCqsfUSE6sxP+Ob6mvwMDYqk/vC5DgTfgVUyz/GHcMi0sasxOvTZHt1Cu3W+B8TK4CjfzgU
 t
X-Google-Smtp-Source: AGHT+IHZ/T0F5KwnB+Vg6m5eCq4OasCIEVgMQ4BZx9dyNu+CABfRw/gsMS8yUbCIrOqzPoYmYcOtaw==
X-Received: by 2002:a17:902:f602:b0:1e0:b2d5:5f46 with SMTP id
 n2-20020a170902f60200b001e0b2d55f46mr2241118plg.46.1712907230749; 
 Fri, 12 Apr 2024 00:33:50 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/27] util/hexdump: Add unit_len and block_len to
 qemu_hexdump_line
Date: Fri, 12 Apr 2024 00:33:23 -0700
Message-Id: <20240412073346.458116-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Generalize the current 1 byte unit and 4 byte blocking
within the output.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/cutils.h  |  6 +++++-
 hw/virtio/vhost-vdpa.c |  2 +-
 util/hexdump.c         | 30 +++++++++++++++++++++---------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 7311fb36ca..e28adedab9 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -257,12 +257,16 @@ int parse_debug_env(const char *name, int max, int initial);
  * @str: GString into which to append
  * @buf: buffer to dump
  * @len: number of bytes to dump
+ * @unit_len: add a space between every @unit_len bytes
+ * @block_len: add an extra space between every @block_len bytes
  *
  * Append @len bytes of @buf as hexadecimal into @str.
+ * Add spaces between every @unit_len and @block_len bytes.
  * If @str is NULL, allocate a new string and return it;
  * otherwise return @str.
  */
-GString *qemu_hexdump_line(GString *str, const void *buf, size_t len);
+GString *qemu_hexdump_line(GString *str, const void *buf, size_t len,
+                           size_t unit_len, size_t block_len);
 
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ab047d8ee0..911742e291 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -948,7 +948,7 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
         len = MIN(config_len - b, 16);
 
         g_string_truncate(str, 0);
-        qemu_hexdump_line(str, config + b, len);
+        qemu_hexdump_line(str, config + b, len, 1, 4);
         trace_vhost_vdpa_dump_config(dev, b, str->str);
     }
 }
diff --git a/util/hexdump.c b/util/hexdump.c
index 521e346bc6..b29326b7f2 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -1,5 +1,5 @@
 /*
- * Helper to hexdump a buffer
+* Helper to hexdump a buffer
  *
  * Copyright (c) 2013 Red Hat, Inc.
  * Copyright (c) 2013 Gerd Hoffmann <kraxel@redhat.com>
@@ -16,22 +16,34 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len)
+GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len,
+                           size_t unit_len, size_t block_len)
 {
     const uint8_t *buf = vbuf;
-    size_t i;
+    size_t u, b;
 
     if (str == NULL) {
         /* Estimate the length of the output to avoid reallocs. */
-        i = len * 3 + len / 4;
-        str = g_string_sized_new(i + 1);
+        size_t est = len * 2;
+        if (unit_len) {
+            est += len / unit_len;
+        }
+        if (block_len) {
+            est += len / block_len;
+        }
+        str = g_string_sized_new(est + 1);
     }
 
-    for (i = 0; i < len; i++) {
-        if (i != 0 && (i % 4) == 0) {
+    for (u = 0, b = 0; len; u++, b++, len--, buf++) {
+        if (unit_len && u == unit_len) {
             g_string_append_c(str, ' ');
+            u = 0;
         }
-        g_string_append_printf(str, " %02x", buf[i]);
+        if (block_len && b == block_len) {
+            g_string_append_c(str, ' ');
+            b = 0;
+        }
+        g_string_append_printf(str, "%02x", *buf);
     }
 
     return str;
@@ -67,7 +79,7 @@ void qemu_hexdump(FILE *fp, const char *prefix,
         len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
 
         g_string_truncate(str, 0);
-        qemu_hexdump_line(str, bufptr + b, len);
+        qemu_hexdump_line(str, bufptr + b, len, 1, 4);
         asciidump_line(ascii, bufptr + b, len);
 
         fprintf(fp, "%s: %04zx: %-*s %s\n",
-- 
2.34.1


