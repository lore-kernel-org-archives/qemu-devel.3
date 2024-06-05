Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DB1C41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExyq-0000bg-VH; Wed, 05 Jun 2024 17:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyn-0000bA-NN
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyh-0003PB-8M
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:32 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-70260814b2dso170306b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622125; x=1718226925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXrzk8wYIq+rswdQhA3YXFWLO6A516BGL94YqrvehJo=;
 b=tLWVGEFcmkPuQeLPS498yUhqhZXKb4+MiiblCrqAyfRjGW4vIrd8GCxBqts6RtUw6s
 2apYz6d7f8JL2Qv98PPCFU6loZdKCMC5zl6wmLcpC7q11J5/RWzWzjib2S1MJ9CU93Zm
 /E+M0oB9EW0W62ZgiWCvdfwTneGbZHMphzf6Y5QEW8iLhoun+NXib2VMPU6aL7dA2GNF
 2RnzeDyiNqU8JaUcM2spKZVjQD76wZIKSrHZnV/cQuZVWsrF+WseFfdMj8lk75rX77f2
 J3wDkSK5E15HcpRfWV5mQkTSRgLuTTkh/58RtIKPgOzdHflB90ZM6ZXv0JFF6NmM4Lfr
 FSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622125; x=1718226925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXrzk8wYIq+rswdQhA3YXFWLO6A516BGL94YqrvehJo=;
 b=KgTiFyBGw4aef3gE9RUmMK9wcKrQODOTf1lZp7L2L3OzUVkv3yW3sIyLvRiGGxRi/J
 ZEZsJxY/eVnszZWQS8+QFq+ozAKK1VwCAnqXBBE85SM1oreUZdBIF4rOVM8/2c6Ln81C
 /lgoM+Xa7FSUz9x2VU6KBiMBQoPKFAwsn+x3qus9AQj6Cr2I0bdLavZvXKWWE6uZVUey
 YicEG8xuqV4liHsgojZ2wzUV6JRU+zdQbdTsRCe4y0uAA9VC4C3JdLa2imkBkAK4V5zb
 M16o1LqqgsLVnLUo1AgucmseFSpru4Gg3NcTC5OrYq/2CcGpA5meBNbu6ACfbDwYTOEN
 g0vA==
X-Gm-Message-State: AOJu0YxVKt5lNUgjnIqfB+GReO2jHhdvhz+5+zuWcNJUntEgsi46bzu6
 KZOi4sUgTVURx+j2U4ILGc/auOphmrZUPWoUmb9VdcsVAbRm4YOY8pbCrxIXIStJImuoSkw24bT
 c
X-Google-Smtp-Source: AGHT+IFv8vEzY1vGmI7K8azhFY/xc85oJ3OtlrbPUM/sT0bW+D0Im3e5c081hi5PC9pAW/HWKHd2Cg==
X-Received: by 2002:a05:6a00:4fd4:b0:6f6:76c8:122c with SMTP id
 d2e1a72fcca58-703f88a3f75mr997990b3a.16.1717622124539; 
 Wed, 05 Jun 2024 14:15:24 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/16] util/hexdump: Add unit_len and block_len to
 qemu_hexdump_line
Date: Wed,  5 Jun 2024 14:15:07 -0700
Message-Id: <20240605211521.577094-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Generalize the current 1 byte unit and 4 byte blocking
within the output.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240412073346.458116-5-richard.henderson@linaro.org>
---
 include/qemu/cutils.h  |  6 +++++-
 hw/virtio/vhost-vdpa.c |  2 +-
 util/hexdump.c         | 30 +++++++++++++++++++++---------
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 14a3285343..da15547bfb 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -287,12 +287,16 @@ int parse_debug_env(const char *name, int max, int initial);
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
index 419463c154..3cdaa12ed5 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -951,7 +951,7 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
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


