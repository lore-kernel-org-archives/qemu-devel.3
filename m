Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9453DD42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvNc-0007YO-91; Tue, 12 Nov 2024 13:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNO-0006uK-OG
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:30 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvNM-00022H-NX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:12:30 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d518f9abcso4331882f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435145; x=1732039945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vGBo3n6UAnKrx1s/4bgTSsf0dXQKvd5mL1bf1mP4VKA=;
 b=qBkdv6jyWCtN8zjpBJWyuWiJX8yGSfdNNvIj9VLOoCk+sxL7ADaniBmSLhIEa5DQ1/
 Vypk9eUNaBhsCgj3aagxVVPuJuQFvk4SXo0kVZTtNxm59phJfY8TZyOCGOToQckUET5U
 mWWf7vCydBRjY+XhosN6ikG3Cv6FeQiic7vDk+yT3E/Nm3x/FRQq5sytVx+BhRfwaF/N
 JrjIhh7P+Qj2/A2l5M3VBkSeG82108Qx5qJ05Ae2MmGRUZRCSTvT9nQxN7QXbhTxVrPJ
 LRvTVyqCw/iDYlNBoOsm+4BnZ0wib39+5N64e7BEn8H0+8izT3NGnq0nNAM2bAN7Id+Q
 A9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435145; x=1732039945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vGBo3n6UAnKrx1s/4bgTSsf0dXQKvd5mL1bf1mP4VKA=;
 b=oT+OVxxj/LqxrFOMiNVbxTxfwN3BW/h8UGpwqxXTF+A5uP4uGvYmgFRLe5HGTlJe9y
 cLB1ytuZw2f7pwU5GHmjgL4jMndwMp3lCrXISaDuKhqxJiDEISZ5hTkuWhG0rAoElKWC
 79Qb1/hzGj0pAe9eG8xhr6JM+eWwXRlLolQhhJ5Zo229H//eGLvdtqJ/ZZyRDBIqTFsb
 lG+elwWZQvF1KVSmf+U5ifKopD27n10lJSZrTxl19jdjZPeSyOQPCUXC2hy5qsm+MF3B
 GQbNk8uB/T54mxzFVtO1FYJ98wou+KJnSy1z69Ca6ounb1XX0pD+SeVkMObzibCxKdp/
 P6zw==
X-Gm-Message-State: AOJu0Yw4GT253a3vqVyV9DPLMdhVM3bUWWMSbZcSNK4sSEbfQKvjM9yS
 ddQ8H+I2AGFz3JlIA3FS+iAZKxAm8TRm+U/AsU7Ag73HN+oEhanQ++AQ03GPkXAidRrj/0SfPR3
 x
X-Google-Smtp-Source: AGHT+IHAM2pwkgrLR2TnCGdm16wR68240SOagncYTL8Mt//7CKDK2CJti6oNBn9nOlRjKlJhFwVZBw==
X-Received: by 2002:a5d:6484:0:b0:37e:d92f:c14a with SMTP id
 ffacd0b85a97d-381f188583bmr13802823f8f.42.1731435145331; 
 Tue, 12 Nov 2024 10:12:25 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381fc0f5f91sm7530136f8f.62.2024.11.12.10.12.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:12:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 16/20] hw/net/xilinx_ethlite: Map TX_LEN as MMIO
Date: Tue, 12 Nov 2024 19:10:40 +0100
Message-ID: <20241112181044.92193-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Declare TX registers as MMIO region, split it out
of the current mixed RAM/MMIO region.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 71 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 12 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 161fd97f06..159b2b0c64 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -38,11 +38,11 @@
 #define A_MDIO_BASE   0x07e4
 
 #define R_TX_BUF0     0
-#define R_TX_LEN0     (0x07f4 / 4)
+#define A_TX_BASE0    0x07f4
 #define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
 #define R_TX_BUF1     (0x0800 / 4)
-#define R_TX_LEN1     (0x0ff4 / 4)
+#define A_TX_BASE1    0x0ff4
 #define R_TX_CTRL1    (0x0ffc / 4)
 
 #define R_RX_BUF0     (0x1000 / 4)
@@ -53,6 +53,11 @@
 
 #define RX_BUFSZ_MAX  0x07e0
 
+enum {
+    TX_LEN =  0,
+    TX_MAX
+};
+
 enum {
     RX_CTRL = 0,
     RX_MAX
@@ -125,6 +130,51 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
     return &s->regs[rxbase + R_RX_BUF0];
 }
 
+static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+    unsigned port_index = addr_to_port_index(addr);
+    uint32_t r = 0;
+
+    switch (addr >> 2) {
+        case TX_LEN:
+            r = s->port[port_index].reg.tx_len;
+            break;
+        default:
+            g_assert_not_reached();
+    }
+
+    return r;
+}
+
+static void port_tx_write(void *opaque, hwaddr addr, uint64_t value,
+                          unsigned int size)
+{
+    XlnxXpsEthLite *s = opaque;
+
+    switch (addr >> 2) {
+        case TX_LEN:
+            s->port[port_index].reg.tx_len = value;
+            break;
+        default:
+            g_assert_not_reached();
+    }
+}
+
+static const MemoryRegionOps eth_porttx_ops = {
+        .read = port_tx_read,
+        .write = port_tx_write,
+        .endianness = DEVICE_NATIVE_ENDIAN,
+        .impl = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+        .valid = {
+            .min_access_size = 4,
+            .max_access_size = 4,
+        },
+};
+
 static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
 {
     XlnxXpsEthLite *s = opaque;
@@ -187,11 +237,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
             r = s->port[port_index].reg.tx_gie;
             break;
 
-        case R_TX_LEN0:
-        case R_TX_LEN1:
-            r = s->port[port_index].reg.tx_len;
-            break;
-
         case R_TX_CTRL1:
         case R_TX_CTRL0:
             r = s->port[port_index].reg.tx_ctrl;
@@ -237,11 +282,6 @@ eth_write(void *opaque, hwaddr addr,
             break;
 
         /* Keep these native.  */
-        case R_TX_LEN0:
-        case R_TX_LEN1:
-            s->port[port_index].reg.tx_len = value;
-            break;
-
         case R_TX_GIE0:
             s->port[port_index].reg.tx_gie = value;
             break;
@@ -330,6 +370,13 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
                             sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
 
     for (unsigned i = 0; i < 2; i++) {
+        memory_region_init_io(&s->port[i].txio, OBJECT(dev),
+                              &eth_porttx_ops, s,
+                              i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
+                              4 * TX_MAX);
+        memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
+                                    &s->port[i].txio);
+
         memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
                               &eth_portrx_ops, s,
                               i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
-- 
2.45.2


