Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68E4C27C55
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExyr-0000c5-Je; Wed, 05 Jun 2024 17:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyn-0000bB-NR
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:33 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyg-0003NU-NP
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:31 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7024cd9dd3dso194825b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622124; x=1718226924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jmQ99CuVUixUPYiVE7xGV4zGNIbhyMF+JitbLNxBw0o=;
 b=WNQ2F0iaOcHO3J6nVUQmpSJ1/rGj2cy1IJECvqZ1jtjl6uF9OWpPJyj8KUmcMKyw/x
 XZ4ib6+S7yd3rowQCl7HNJrbG3x43SishYVna+r4kZgjHeUp1LSJcn5I5K4pC4/1HOhe
 5xBGI9Sqo+h8aDkoqw3qf6D8VMyBeGejGKgJUTsm5jfl6tb4n8AOm1g7MpjKdPBgjgAF
 B9FzohcuSriVGDu9UNfuHRT7junD2sJDAeYOaWBv6+UBD3iihQuZ7o5hDfYf8MSRdqX9
 P2N1+5johABXt3c3LdqQY33Ch5kJEL1uw0VzT1yaw8sMWi3N60deRu5nvzqBq32JlBTW
 jUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622124; x=1718226924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmQ99CuVUixUPYiVE7xGV4zGNIbhyMF+JitbLNxBw0o=;
 b=Q8OaNkBLGiP3nE+hSbpOYzGsJ8OV7RvsvUbpJlev9XM+dI4Vkiuw6B71y/iFz5KgyX
 x/XayN0ZJj+Uuf+y03OoMRIFP5E3869saNuECWHi3UyqgZTM7RAfm2yE97sbEwHmnfs8
 4KydIfA2bmsRV5rWBLAw3Mrj5z5fM9iyRWECfKj1wd9YQS6m1R/Q4bkiw24er1f8l1O2
 JKZh+/O9Cww8Y1x1/A+f2dRKlWznA8iXWYoEgbUwVYyg14eS6PShRvsxeoNl4JHWU6jm
 aAejjRQOjCE15vSVSsgtIloOdnzcqKEpaMoZlmU3uxPldtQsz3m5lhgmaPbXrfGfeiLM
 lyQA==
X-Gm-Message-State: AOJu0YzLYLAyji9YJ+pri9zNFCOwt7jo8G/E+EBSm/C51asCRMjQ75Ru
 dyybmgUCJbgEPk0CB8D8g36KwaCGTnE9UMb+e6WBDB47zriePwKloCu0SVoZKo4ACnl+JU0b2EB
 k
X-Google-Smtp-Source: AGHT+IGnUYR1pKcUw6T1UD3/2+H5BQ2PS1iNxhLHuN3VwcMyfhrzkXk0HJm7dRFaDpOmSz3lY6QUNA==
X-Received: by 2002:a05:6a00:194b:b0:6ed:4288:68bc with SMTP id
 d2e1a72fcca58-703e59bb6aamr4140262b3a.19.1717622123610; 
 Wed, 05 Jun 2024 14:15:23 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] util/hexdump: Use a GString for qemu_hexdump_line
Date: Wed,  5 Jun 2024 14:15:06 -0700
Message-Id: <20240605211521.577094-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Allocate a new, or append to an existing GString instead of
using a fixed sized buffer.  Require the caller to determine
the length of the line -- do not bound len here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240412073346.458116-4-richard.henderson@linaro.org>
---
 include/qemu/cutils.h  | 15 ++++++++++-----
 hw/virtio/vhost-vdpa.c | 14 ++++++++------
 util/hexdump.c         | 27 ++++++++++++++++-----------
 3 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index c5dea63742..14a3285343 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -282,12 +282,17 @@ static inline const char *yes_no(bool b)
  */
 int parse_debug_env(const char *name, int max, int initial);
 
-/*
- * Hexdump a line of a byte buffer into a hexadecimal/ASCII buffer
+/**
+ * qemu_hexdump_line:
+ * @str: GString into which to append
+ * @buf: buffer to dump
+ * @len: number of bytes to dump
+ *
+ * Append @len bytes of @buf as hexadecimal into @str.
+ * If @str is NULL, allocate a new string and return it;
+ * otherwise return @str.
  */
-#define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
-#define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, const void *bufptr, size_t len);
+GString *qemu_hexdump_line(GString *str, const void *buf, size_t len);
 
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7368b71902..419463c154 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -944,13 +944,15 @@ static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
 static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
                                    uint32_t config_len)
 {
-    int b, len;
-    char line[QEMU_HEXDUMP_LINE_LEN];
+    g_autoptr(GString) str = g_string_sized_new(4 * 16);
+    size_t b, len;
 
-    for (b = 0; b < config_len; b += 16) {
-        len = config_len - b;
-        qemu_hexdump_line(line, config + b, len);
-        trace_vhost_vdpa_dump_config(dev, b, line);
+    for (b = 0; b < config_len; b += len) {
+        len = MIN(config_len - b, 16);
+
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, config + b, len);
+        trace_vhost_vdpa_dump_config(dev, b, str->str);
     }
 }
 
diff --git a/util/hexdump.c b/util/hexdump.c
index 0f943e31e5..521e346bc6 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,22 +16,25 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
+GString *qemu_hexdump_line(GString *str, const void *vbuf, size_t len)
 {
-    const char *buf = bufptr;
-    int i;
+    const uint8_t *buf = vbuf;
+    size_t i;
 
-    if (len > QEMU_HEXDUMP_LINE_BYTES) {
-        len = QEMU_HEXDUMP_LINE_BYTES;
+    if (str == NULL) {
+        /* Estimate the length of the output to avoid reallocs. */
+        i = len * 3 + len / 4;
+        str = g_string_sized_new(i + 1);
     }
 
     for (i = 0; i < len; i++) {
         if (i != 0 && (i % 4) == 0) {
-            *line++ = ' ';
+            g_string_append_c(str, ' ');
         }
-        line += sprintf(line, " %02x", (unsigned char)buf[i]);
+        g_string_append_printf(str, " %02x", buf[i]);
     }
-    *line = '\0';
+
+    return str;
 }
 
 static void asciidump_line(char *line, const void *bufptr, size_t len)
@@ -49,24 +52,26 @@ static void asciidump_line(char *line, const void *bufptr, size_t len)
     *line = '\0';
 }
 
+#define QEMU_HEXDUMP_LINE_BYTES 16
 #define QEMU_HEXDUMP_LINE_WIDTH \
     (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
 
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size)
 {
-    char line[QEMU_HEXDUMP_LINE_LEN];
+    g_autoptr(GString) str = g_string_sized_new(QEMU_HEXDUMP_LINE_WIDTH + 1);
     char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
     size_t b, len;
 
     for (b = 0; b < size; b += len) {
         len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
 
-        qemu_hexdump_line(line, bufptr + b, len);
+        g_string_truncate(str, 0);
+        qemu_hexdump_line(str, bufptr + b, len);
         asciidump_line(ascii, bufptr + b, len);
 
         fprintf(fp, "%s: %04zx: %-*s %s\n",
-                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, line, ascii);
+                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, str->str, ascii);
     }
 
 }
-- 
2.34.1


