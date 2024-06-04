Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BD6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQul-0005mW-GT; Tue, 04 Jun 2024 05:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuj-0005c6-EG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuh-00026j-RZ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35dcff36522so775208f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495026; x=1718099826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKCb8LNXYSVbebdxNMftRVpPNmizlFVEcNh6n2gVUMA=;
 b=uVEsyXqtdFcCLy4mFlnKWY05yOTrMAbICi8yS5Syorty92KbKJjPj21R6Y9t7Z4gAr
 L+LQi4VgORgQ+VEHF3LfnwFZQdH4GmJkC3IfycVTHrDYJLfDsOWvSVVocwATVqvlftSJ
 4NCLciTEV91BHI+QZXJcfbsTrAHHfVZ1oi9QW3i7p3hkFvUZ/4PHkVBDEDfFwhBm2hFx
 kts5BWk9fFlengmvPzujjSnJusdSjSzb9HLNnkVxpgzF+yTJAjJ4rHvEwXq/l2z2fte0
 RvjlJUFiPkrYdgfTlWkCUIW5IlU/yuELqy28yLk1ofW9Li4Q8mXB4k3nDENdfXL4jdGV
 PKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495026; x=1718099826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKCb8LNXYSVbebdxNMftRVpPNmizlFVEcNh6n2gVUMA=;
 b=b3wXLGMtPLCXPlqwNQyQfMzmVUnep/x2Rw+SsylSS/jG4RUvPteJl7zdPtzliZJ54Y
 uOKyjrgNJaIvQy2lfdUx8tO9Ze34DAx4sYn2WZBbMhU9JVn31qAHytnGTk7Wij+2yKXe
 Tijs0RgL9v6iTShiibtzrywHwGDr3UxvPJXVRK5c/MAriMPciM5Lio5SP0XnktKmSpju
 QZSc9EnbRbFqJGJr2rLpy+i0ob//mMB4G5X52ckgS91weGl7NbhlRnqd56+lfajBDASZ
 vV9tl2gMteks64qPFh8joJoXsnbkM5IjCrU9eR9OFWn5ziNMbyEFz+w5b+GEQkIuaFot
 klxw==
X-Gm-Message-State: AOJu0YxcsC0p40rPR4blyzlAHBJxWwuPjvtTTeLgcfZ+ilt+4ZxV++dh
 +fDH6SGSbQBNApjtgm1lEqZdp46Kp7MlxkEBjDobUoj4An09TUaC79CmoRsOWdzWR00+2Jmgj69
 S
X-Google-Smtp-Source: AGHT+IE8KrpvqisRgdrcfUDOzvij0a2+1NWoxiD2NITeksUXozUz8Emny9VeMDiqSFyqgyrcql9gBg==
X-Received: by 2002:a5d:5f8b:0:b0:356:c47a:87d2 with SMTP id
 ffacd0b85a97d-35e0f25a5d9mr9190500f8f.6.1717495026208; 
 Tue, 04 Jun 2024 02:57:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d96f6sm11103296f8f.61.2024.06.04.02.57.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/32] util/hexdump: Remove ascii parameter from
 qemu_hexdump_line
Date: Tue,  4 Jun 2024 11:55:46 +0200
Message-ID: <20240604095609.12285-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Split out asciidump_line as a separate function, local to hexdump.c,
for use by qemu_hexdump.  Use "%-*s" to generate the alignment
between the hex and the ascii, rather than explicit spaces.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240412073346.458116-3-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/cutils.h  |  3 +--
 hw/virtio/vhost-vdpa.c |  2 +-
 util/hexdump.c         | 56 ++++++++++++++++++++++++------------------
 3 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index d7715f7a33..c5dea63742 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -287,8 +287,7 @@ int parse_debug_env(const char *name, int max, int initial);
  */
 #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
 #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, const void *bufptr,
-                       unsigned int len, bool ascii);
+void qemu_hexdump_line(char *line, const void *bufptr, size_t len);
 
 /*
  * Hexdump a buffer to a file. An optional string prefix is added to every line
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index f3a86c1a8c..7368b71902 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -949,7 +949,7 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
 
     for (b = 0; b < config_len; b += 16) {
         len = config_len - b;
-        qemu_hexdump_line(line, config + b, len, false);
+        qemu_hexdump_line(line, config + b, len);
         trace_vhost_vdpa_dump_config(dev, b, line);
     }
 }
diff --git a/util/hexdump.c b/util/hexdump.c
index 7324e7b126..0f943e31e5 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,49 +16,57 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, const void *bufptr,
-                       unsigned int len, bool ascii)
+void qemu_hexdump_line(char *line, const void *bufptr, size_t len)
 {
     const char *buf = bufptr;
-    int i, c;
+    int i;
 
     if (len > QEMU_HEXDUMP_LINE_BYTES) {
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
+        fprintf(fp, "%s: %04zx: %-*s %s\n",
+                prefix, b, QEMU_HEXDUMP_LINE_WIDTH, line, ascii);
     }
 
 }
-- 
2.41.0


