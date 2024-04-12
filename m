Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1D2C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 07:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvBQ4-0006zB-77; Fri, 12 Apr 2024 03:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBQ1-0006xO-4u
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:53 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvBPy-00074g-DC
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 03:33:52 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so451629a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 00:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712907229; x=1713512029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+WtY4DsJRn2jEDsEW21TOMqrULwYncFBXOs9a6AYGRc=;
 b=efqxISQZfqOPZjn4MTPsnHQcAkoNh3ktYf1OveUy2/hMVh0RRqO6jwblvv/3JIU2eF
 xqBxUHyS/WZml8f427Mx0fo5KuzpM3vgRM828wuclKCgmyZFr+r2qxAmL6aY52fDxWAI
 OxuhKGyvt5DNhHaBGDHtVjW71ewJEJLxEbCHPGY5ix9bQCBe2FeH2nR+pEy9k7ygrcga
 Q0vrzV0le61GpptaqrKT1Cn5fq/48uqMVR+sxkfLoiHFo+z5JK75pbpdT7zzM6qCCj8b
 Zsv1aExQaPosk+DUD1Orb97M++FUTI+mX1kVcGNs9pneeULOmmLH67rfZifgt+dSYk87
 3jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712907229; x=1713512029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WtY4DsJRn2jEDsEW21TOMqrULwYncFBXOs9a6AYGRc=;
 b=tDLU1OSK886T52h6Ae8nmqyYHG5T4AtTtdMiCEiU96doNN0KbQEhUslfJNsiPcrcj7
 uCtPMAAVK9nNWH3fvEBom9S/1DC5xckKET6Vi89Ynv1SsgSPScAWgAkNYwQxwRTQ3Ksz
 +52ly/9fIOk/nWRp5w2nS3zCTSftCxqPgRe5Ik7SVI1AdDYUo5GPrqgi6olAqoXDbj/0
 sy3rSFdJaiJnbhbr3lovfU7lKymMVApJ8ErTmy7EjPUdjT8P66ngqQPxUgouRUp+iKB5
 sHL3w9CrBnwyghPQYl3omntCEV5stytGlji41yf95BuzfrA4CsDea9Uzn5kfEf5UH3S9
 kLmw==
X-Gm-Message-State: AOJu0Yyz09xBwnMvo8/zqrwCyjV3UNcBRp7pOHQ1n0UPrWVlioLy1PMo
 i55+lRzd9XRVHAENcLA2O8O8S41ZUEDQ8CMiidk5slxWvioMh1svIum/H7nv2uvrqS5kQvSJ9jZ
 O
X-Google-Smtp-Source: AGHT+IGv0uisfcQpQYJDOzdqbBY/pHSv+RBuKW6VvhCXjjWsXyt91vMbh+yWx9FYe+tZE0jeXplvqQ==
X-Received: by 2002:a05:6a21:151a:b0:1a9:b3e9:a62c with SMTP id
 nq26-20020a056a21151a00b001a9b3e9a62cmr307545pzb.48.1712907229154; 
 Fri, 12 Apr 2024 00:33:49 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a17090301c500b001e556734814sm2206099plh.134.2024.04.12.00.33.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 00:33:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/27] util/hexdump: Remove ascii parameter from
 qemu_hexdump_line
Date: Fri, 12 Apr 2024 00:33:21 -0700
Message-Id: <20240412073346.458116-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412073346.458116-1-richard.henderson@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Split out asciidump_line as a separate function, local to hexdump.c,
for use by qemu_hexdump.  Use "%-*s" to generate the alignment
between the hex and the ascii, rather than explicit spaces.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/cutils.h  |  3 +--
 hw/virtio/vhost-vdpa.c |  2 +-
 util/hexdump.c         | 54 ++++++++++++++++++++++++------------------
 3 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 3415f5d249..d0c5386e6c 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -257,8 +257,7 @@ int parse_debug_env(const char *name, int max, int initial);
  */
 #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
 #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, const void *bufptr,
-                       unsigned int len, bool ascii);
+void qemu_hexdump_line(char *line, const void *bufptr, size_t len);
 
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index b4afa142f6..32bad5ce68 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -946,7 +946,7 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
 
     for (b = 0; b < config_len; b += 16) {
         len = config_len - b;
-        qemu_hexdump_line(line, config + b, len, false);
+        qemu_hexdump_line(line, config + b, len);
         trace_vhost_vdpa_dump_config(dev, b, line);
     }
 }
diff --git a/util/hexdump.c b/util/hexdump.c
index 7324e7b126..dbc536fe84 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,8 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, const void *bufptr,
-                       unsigned int len, bool ascii)
+void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
 {
     const char *buf = bufptr;
     int i, c;
@@ -26,39 +25,48 @@ void qemu_hexdump_line(char *line, const void *bufptr,
         len = QEMU_HEXDUMP_LINE_BYTES;
     }
 
-    for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
+    for (i = 0; i < len; i++) {
         if (i != 0 && (i % 4) == 0) {
             *line++ = ' ';
         }
-        if (i < len) {
-            line += sprintf(line, " %02x", (unsigned char)buf[i]);
-        } else {
-            line += sprintf(line, "   ");
-        }
-    }
-    if (ascii) {
-        *line++ = ' ';
-        for (i = 0; i < len; i++) {
-            c = buf[i];
-            if (c < ' ' || c > '~') {
-                c = '.';
-            }
-            *line++ = c;
-        }
+        line += sprintf(line, " %02x", (unsigned char)buf[i]);
     }
     *line = '\0';
 }
 
+static void asciidump_line(char *line, const void *bufptr, size_t len)
+{
+    const char *buf = bufptr;
+
+    for (size_t i = 0; i < len; i++) {
+        char c = buf[i];
+
+        if (c < ' ' || c > '~') {
+            c = '.';
+        }
+        *line++ = c;
+    }
+    *line = '\0';
+}
+
+#define QEMU_HEXDUMP_LINE_WIDTH \
+    (QEMU_HEXDUMP_LINE_BYTES * 2 + QEMU_HEXDUMP_LINE_BYTES / 4)
+
 void qemu_hexdump(FILE *fp, const char *prefix,
                   const void *bufptr, size_t size)
 {
-    unsigned int b, len;
     char line[QEMU_HEXDUMP_LINE_LEN];
+    char ascii[QEMU_HEXDUMP_LINE_BYTES + 1];
+    size_t b, len;
 
-    for (b = 0; b < size; b += QEMU_HEXDUMP_LINE_BYTES) {
-        len = size - b;
-        qemu_hexdump_line(line, bufptr + b, len, true);
-        fprintf(fp, "%s: %04x: %s\n", prefix, b, line);
+    for (b = 0; b < size; b += len) {
+        len = MIN(size - b, QEMU_HEXDUMP_LINE_BYTES);
+
+        qemu_hexdump_line(line, bufptr + b, len);
+        asciidump_line(ascii, bufptr + b, len);
+
+        fprintf(fp, "%s: %04x: %-*s %s\n",
+                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, line, ascii);
     }
 
 }
-- 
2.34.1


