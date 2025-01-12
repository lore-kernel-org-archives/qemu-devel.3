Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BFDE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6K8-0004IK-Rc; Sun, 12 Jan 2025 17:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jb-00034N-6C
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:16 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JZ-0006oW-IQ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:14 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so1885273f8f.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720412; x=1737325212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c4IJJIqOzzzNLl0UmDXFVSLVyGwrdjjTtkcnLuHaGvM=;
 b=NHoju27vwIkWLI9DJPePVEhKbcn8oV6o6LBaVUoyEdpLn8l1awmafn2pPNLsA1H7Nz
 0eJJXh35sRWgzC6sxKKZhhp71N1BDXaPToV7baz6bePcuFhSzHNs7cwUtCYd9UkaQXUe
 UzrAAlgveP5mG6sCIvvaAOjzB/1gE3XAhXAw2UbS31+ZK8Xcoy3Qy76/iBG7DlhX9KzU
 uqrBi2Vqkag9a9T96DI0BlvOoSVN3Nr7cuTwBI7p7RdSwHKJAkMRwn0ea3Y25A10kByP
 +n1Hl2/IJyK2/MKHNaKdWtHiZv1BzAgF+zOZlOgu+WtJ/5wkiOA07xR0/w+CWNwcKDv8
 dnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720412; x=1737325212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c4IJJIqOzzzNLl0UmDXFVSLVyGwrdjjTtkcnLuHaGvM=;
 b=EExf9hAEi+NVOD3KRU539b7VdaSu6HcqTZn4VULyovlaNYxUcMKYH2GfDKcE+fxlaB
 4FQMJktoRHXVD3qCCQaEW0SUPrZRwlcil1QtYg2HQDlrlP91JwrbN3683H/eeiG4tghT
 RuLuJn4Y1ywmjF++Rch3nu49nh4v2ZUJqaHsz+AsdemEF11zxBrfUpDGLkxyMRmRRc6o
 EnOvCBO4N7BB9pfHKnM3rfKGIONLuwVDSU5wjmXpterADFIvWAPWEKHvd1cZNlXayJP8
 U/tJFJYvehdgDHFDr/T/SZKhvkrI0WKCbZjv1hzD4azODmuM2Q5HlrJb6l9wOJqpNBSu
 YP2Q==
X-Gm-Message-State: AOJu0YyGmD8Idf6f+wJw2S9y5KUvkKu3DKU7vP7a5434/WJ1DnlxMWno
 exXCabNzRV8M2ucU0Sg/jKiON4QZO+HTRcE/R5spVEJRevPum3tae59fqpeBvRCc/DJY90SO1nJ
 B28U=
X-Gm-Gg: ASbGncujMunN/2HQuWTOkBHtdaVGU2GsRahRwp63BcaNoddYS40U55Y+4cHSu7bPFia
 z6Eat0vcsfbml+eZwLBrgFVJeCNfEYIqr6AOkrt1GbTA379uWwSEmSI+uHsxxs4sca/VHCQGzw/
 7Tlm9vPr2Yqab92/zCZYngGOE5rZ82PGU9LN2ilE8KDBUXQ6vo5w+K5sTznepqtFoQlichY31fu
 YmeB5E6llwxZVJPtTCws/TBjMs0KVUvOkN5g2R2R0rE486jccnEX5JzdLoV29xxiC/pc14kR/qe
 FHMpqOR3e+B01+vB5BZBo8Ii5yOtNL4=
X-Google-Smtp-Source: AGHT+IG7l0glCbY5ZAJHmNIR9e2TaGCiAZFtMeLcWmRZtncVfBQtBUnd8bxyMfxfXWyF8zna7tKmAQ==
X-Received: by 2002:a5d:5848:0:b0:385:f7a3:fea6 with SMTP id
 ffacd0b85a97d-38a872da434mr3776732f8f.13.1736720411752; 
 Sun, 12 Jan 2025 14:20:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c697sm10783886f8f.52.2025.01.12.14.20.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/49] hw/i2c/imx_i2c: Convert DPRINTF() to trace events
Date: Sun, 12 Jan 2025 23:17:09 +0100
Message-ID: <20250112221726.30206-34-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Also print the QOM canonical path when tracing which allows for distinguishing
the many instances a typical i.MX SoC has.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20250111183711.2338-12-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/imx_i2c.c    | 21 +++++----------------
 hw/i2c/trace-events |  5 +++++
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index c565fd5b8ab..d62213b9e0f 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -25,18 +25,7 @@
 #include "hw/i2c/i2c.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-
-#ifndef DEBUG_IMX_I2C
-#define DEBUG_IMX_I2C 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX_I2C) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX_I2C, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx_i2c_get_regname(unsigned offset)
 {
@@ -152,8 +141,8 @@ static uint64_t imx_i2c_read(void *opaque, hwaddr offset,
         break;
     }
 
-    DPRINTF("read %s [0x%" HWADDR_PRIx "] -> 0x%02x\n",
-            imx_i2c_get_regname(offset), offset, value);
+    trace_imx_i2c_read(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
+                       offset, value);
 
     return (uint64_t)value;
 }
@@ -163,8 +152,8 @@ static void imx_i2c_write(void *opaque, hwaddr offset,
 {
     IMXI2CState *s = IMX_I2C(opaque);
 
-    DPRINTF("write %s [0x%" HWADDR_PRIx "] <- 0x%02x\n",
-            imx_i2c_get_regname(offset), offset, (int)value);
+    trace_imx_i2c_read(DEVICE(s)->canonical_path, imx_i2c_get_regname(offset),
+                       offset, value);
 
     value &= 0xff;
 
diff --git a/hw/i2c/trace-events b/hw/i2c/trace-events
index f708a7ace18..1ad0e95c0e6 100644
--- a/hw/i2c/trace-events
+++ b/hw/i2c/trace-events
@@ -56,3 +56,8 @@ npcm7xx_smbus_recv_fifo(const char *id, uint8_t received, uint8_t expected) "%s
 
 pca954x_write_bytes(uint8_t value) "PCA954X write data: 0x%02x"
 pca954x_read_data(uint8_t value) "PCA954X read data: 0x%02x"
+
+# imx_i2c.c
+
+imx_i2c_read(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] -> 0x%02" PRIx64
+imx_i2c_write(const char *id, const char *reg, uint64_t ofs, uint64_t value) "%s:[%s (0x%" PRIx64 ")] <- 0x%02" PRIx64
-- 
2.47.1


