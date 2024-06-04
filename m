Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBD5C27C54
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQug-0005bg-Iy; Tue, 04 Jun 2024 05:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQue-0005aK-GO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuc-00026T-Iv
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:57:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42147970772so5079005e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495020; x=1718099820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhkkGO7UM5NempyNbZSpgeksE20VfiEa/+ho7bDGL5s=;
 b=x2FybTSz7/tPL2v1URKH5MUvy983gyExCh1IZcY6EQV2l2ldcvR762jzOnhEFcov+a
 z/yjS1D8yF9off+Q3gtf7wwl4fEW0S0Lr9AISMzC3KldscJDAf45pay9+32CDImWlKeH
 g1XDZrP+i/kDmNWFNfDiW55MoF2IxITsy9EkOH1NDnn+wBiiwjpgIbFvjIHHyn3g2qhO
 X+j8rrqptCR2LBWpHPYztrEXWwiV1Efp57RUTLzrpuqz0zkzQTzJcwvn9k8ggAntxmVj
 x9zM1PTYFt9KmO2gn2dLKXeSSJA+l4fCzA9sQz+72eq+xMndc53l/nYEUyZbxIE4qtB1
 FnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495020; x=1718099820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhkkGO7UM5NempyNbZSpgeksE20VfiEa/+ho7bDGL5s=;
 b=OPLELOgugaRifvThC2QgC/t7z9XZcJE5+NoUO35we3yoASBgvhv9HfrwyfAFmXm6tL
 bKxNy1nALl4c3N0219oSC35IQLtEE2Z6o/2edOgGGqhLQkzOm2nJCLURFFPMGpU7RK08
 ImkQcgGGAGXP53y4Se+8J3aZQNr+Qjn2+mDE/ZKOjE8Uym4uBnAmdU2MDDvudN94wLQx
 v7RimYG4nQZb/ksecDkgTRSuaeCu1Fb0bCpD9USo0kuETgz7KJsZFGMUojyOIFsDge4X
 DW7nD7qT2r/4TjWBADPEO6qefoGVnvPf3kmH7I7007vLEnc63LfmJg0sKmhUvM0JHqB3
 nMgw==
X-Gm-Message-State: AOJu0YzRObZo0bwX2bxaMcGuZ0nKy12AI1ADVbQCnTEYCW8x6sZw5LHf
 swosGQU3GLtniWvcJI4wmlvYHBK+66H9QMYN525ultlXbwRbA4ASAbU321RuWuI0adY3bQ5x91v
 H
X-Google-Smtp-Source: AGHT+IFZPX2h1ZqZMR4lee0UczZUEIRW+G+dZMUD4sX24NA2MkCPTPmOyItxhBCpXPLoRlezz0WykA==
X-Received: by 2002:a05:600c:4705:b0:421:2918:3d97 with SMTP id
 5b1f17b1804b1-4212e0add57mr103467795e9.30.1717495020665; 
 Tue, 04 Jun 2024 02:57:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212705692csm178091885e9.10.2024.06.04.02.56.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:57:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/32] util/hexdump: Remove b parameter from qemu_hexdump_line
Date: Tue,  4 Jun 2024 11:55:45 +0200
Message-ID: <20240604095609.12285-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Require that the caller output the offset and increment bufptr.
Use QEMU_HEXDUMP_LINE_BYTES in vhost_vdpa_dump_config instead
of raw integer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240412073346.458116-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/cutils.h  |  2 +-
 hw/virtio/vhost-vdpa.c |  4 ++--
 util/hexdump.c         | 13 ++++++-------
 hw/virtio/trace-events |  2 +-
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index 741dade7cf..d7715f7a33 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -287,7 +287,7 @@ int parse_debug_env(const char *name, int max, int initial);
  */
 #define QEMU_HEXDUMP_LINE_BYTES 16 /* Number of bytes to dump */
 #define QEMU_HEXDUMP_LINE_LEN 75   /* Number of characters in line */
-void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+void qemu_hexdump_line(char *line, const void *bufptr,
                        unsigned int len, bool ascii);
 
 /*
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index ed99ab8745..f3a86c1a8c 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -949,8 +949,8 @@ static void vhost_vdpa_dump_config(struct vhost_dev *dev, const uint8_t *config,
 
     for (b = 0; b < config_len; b += 16) {
         len = config_len - b;
-        qemu_hexdump_line(line, b, config, len, false);
-        trace_vhost_vdpa_dump_config(dev, line);
+        qemu_hexdump_line(line, config + b, len, false);
+        trace_vhost_vdpa_dump_config(dev, b, line);
     }
 }
 
diff --git a/util/hexdump.c b/util/hexdump.c
index 9921114b3c..7324e7b126 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -16,7 +16,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 
-void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
+void qemu_hexdump_line(char *line, const void *bufptr,
                        unsigned int len, bool ascii)
 {
     const char *buf = bufptr;
@@ -26,13 +26,12 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
         len = QEMU_HEXDUMP_LINE_BYTES;
     }
 
-    line += snprintf(line, 6, "%04x:", b);
     for (i = 0; i < QEMU_HEXDUMP_LINE_BYTES; i++) {
-        if ((i % 4) == 0) {
+        if (i != 0 && (i % 4) == 0) {
             *line++ = ' ';
         }
         if (i < len) {
-            line += sprintf(line, " %02x", (unsigned char)buf[b + i]);
+            line += sprintf(line, " %02x", (unsigned char)buf[i]);
         } else {
             line += sprintf(line, "   ");
         }
@@ -40,7 +39,7 @@ void qemu_hexdump_line(char *line, unsigned int b, const void *bufptr,
     if (ascii) {
         *line++ = ' ';
         for (i = 0; i < len; i++) {
-            c = buf[b + i];
+            c = buf[i];
             if (c < ' ' || c > '~') {
                 c = '.';
             }
@@ -58,8 +57,8 @@ void qemu_hexdump(FILE *fp, const char *prefix,
 
     for (b = 0; b < size; b += QEMU_HEXDUMP_LINE_BYTES) {
         len = size - b;
-        qemu_hexdump_line(line, b, bufptr, len, true);
-        fprintf(fp, "%s: %s\n", prefix, line);
+        qemu_hexdump_line(line, bufptr + b, len, true);
+        fprintf(fp, "%s: %04x: %s\n", prefix, b, line);
     }
 
 }
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 96632fd026..3cf84e04a7 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -50,7 +50,7 @@ vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRI
 vhost_vdpa_reset_device(void *dev) "dev: %p"
 vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
 vhost_vdpa_set_vring_enable_one(void *dev, unsigned i, int enable, int r) "dev: %p, idx: %u, enable: %u, r: %d"
-vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
+vhost_vdpa_dump_config(void *dev, unsigned ofs, const char *line) "dev: %p 0x%04x: %s"
 vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
 vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
 vhost_vdpa_suspend(void *dev) "dev: %p"
-- 
2.41.0


