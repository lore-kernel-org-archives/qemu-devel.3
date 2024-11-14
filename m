Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C370CD6A230
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgxV-0000LR-RP; Thu, 14 Nov 2024 16:00:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxQ-0000CL-9z
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:52 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxO-0007xz-M4
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:00:52 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d3e8d923fso778236f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618046; x=1732222846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtXVKpSIpZsJQkvyHDSbG39GxcMu+Qe8sXh7gatQ/Yw=;
 b=OcCip/nhNJYtRhxSs8lcP6uelVtv/Lp1HC1kFAx+utq7H1B25Yi8fSkkvfama6PNxN
 VrEUFU+dx/jsmixZ9MQhYvyaW4fUPHKxJt7d+rdtWKWwm4fSKb4i8V8ylkzZxZX7hm+A
 emNb7R1ZXfyj+m/GOGfb/ssNa7rmG5EButEMVS19TulhJ5enpG724L58ibx4bhpcp0l2
 S8RWIJ6zoDnU9d2pgThwvrS+KtM21B8L8csVYUJq3hpz9/bdgwPFGM/1aM+lkhd0fVyf
 x/lFAvCMDJngG/ghB20cxBv+/6hXH5ulJb0xNQNLOLlxeGX/Lqe0ieGBTiZ2u+MJYXu7
 INZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618046; x=1732222846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtXVKpSIpZsJQkvyHDSbG39GxcMu+Qe8sXh7gatQ/Yw=;
 b=GRRbkVb4cToqGEt9nfDyUvLrqGpfFRQaDl7zcikYHbGSQUAn5ICs+4zF+WqxkG1aU7
 OQoG9RKPf6EGZL3dsIfYCPCAzSj7qC54LQYWOKeMEUfEck3gNdMJlSc2nNDkGiBLIfgS
 km4r4J+5rmitq16vusGDZyVZG1kbxfaE4bIJphd7iSSBTV5I2IqDbscDclSVRh76bAWV
 hBAFeLAyg3XoTuA/0kU2W9XjxJ9C4R+2ky0gEkVTFCoIrif5zoTeS+PSO7TKzQT1xMve
 jiajSS4edFvFTmMADO+1vOiqQKfJ3Nks7qc+WrbkAwBf+gDFe4+GFwbp2+rldDEH7hQz
 zj9g==
X-Gm-Message-State: AOJu0Yx46Rj+7eFRw9iJycloPffBT/k2q6/Yk1JVFqRM5qaw7KCOEESi
 jT9XvWsyCTSJbASCrvs418ko8NuIQuY6UL2quAdCW5IQzgbf6IiKiLiBIlzs2ZMJWi2vI1vLXhv
 u
X-Google-Smtp-Source: AGHT+IHbqGTyAGVHsf4CAg0v83H6E0jzjKOlhu5BSnQO0WRW3ieZSQVwgHMcILsOA+LQ8sL0/3heaQ==
X-Received: by 2002:a05:6000:460f:b0:381:f603:73f2 with SMTP id
 ffacd0b85a97d-38225a4a6f4mr142215f8f.35.1731618046233; 
 Thu, 14 Nov 2024 13:00:46 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae311fbsm2403600f8f.95.2024.11.14.13.00.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:00:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 04/19] hw/net/xilinx_ethlite: Update QOM style
Date: Thu, 14 Nov 2024 21:59:55 +0100
Message-ID: <20241114210010.34502-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Use XlnxXpsEthLite typedef, OBJECT_DECLARE_SIMPLE_TYPE macro;
convert type_init() to DEFINE_TYPES().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/net/xilinx_ethlite.c | 48 +++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 2b52597f03..0f59811c78 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -53,10 +53,9 @@
 #define CTRL_S     0x1
 
 #define TYPE_XILINX_ETHLITE "xlnx.xps-ethernetlite"
-DECLARE_INSTANCE_CHECKER(struct xlx_ethlite, XILINX_ETHLITE,
-                         TYPE_XILINX_ETHLITE)
+OBJECT_DECLARE_SIMPLE_TYPE(XlnxXpsEthLite, XILINX_ETHLITE)
 
-struct xlx_ethlite
+struct XlnxXpsEthLite
 {
     SysBusDevice parent_obj;
 
@@ -73,7 +72,7 @@ struct xlx_ethlite
     uint32_t regs[R_MAX];
 };
 
-static inline void eth_pulse_irq(struct xlx_ethlite *s)
+static inline void eth_pulse_irq(XlnxXpsEthLite *s)
 {
     /* Only the first gie reg is active.  */
     if (s->regs[R_TX_GIE0] & GIE_GIE) {
@@ -84,7 +83,7 @@ static inline void eth_pulse_irq(struct xlx_ethlite *s)
 static uint64_t
 eth_read(void *opaque, hwaddr addr, unsigned int size)
 {
-    struct xlx_ethlite *s = opaque;
+    XlnxXpsEthLite *s = opaque;
     uint32_t r = 0;
 
     addr >>= 2;
@@ -112,7 +111,7 @@ static void
 eth_write(void *opaque, hwaddr addr,
           uint64_t val64, unsigned int size)
 {
-    struct xlx_ethlite *s = opaque;
+    XlnxXpsEthLite *s = opaque;
     unsigned int base = 0;
     uint32_t value = val64;
 
@@ -176,7 +175,7 @@ static const MemoryRegionOps eth_ops = {
 
 static bool eth_can_rx(NetClientState *nc)
 {
-    struct xlx_ethlite *s = qemu_get_nic_opaque(nc);
+    XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
     unsigned int rxbase = s->rxbuf * (0x800 / 4);
 
     return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
@@ -184,7 +183,7 @@ static bool eth_can_rx(NetClientState *nc)
 
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
-    struct xlx_ethlite *s = qemu_get_nic_opaque(nc);
+    XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
     unsigned int rxbase = s->rxbuf * (0x800 / 4);
 
     /* DA filter.  */
@@ -214,7 +213,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 
 static void xilinx_ethlite_reset(DeviceState *dev)
 {
-    struct xlx_ethlite *s = XILINX_ETHLITE(dev);
+    XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
     s->rxbuf = 0;
 }
@@ -228,7 +227,7 @@ static NetClientInfo net_xilinx_ethlite_info = {
 
 static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
-    struct xlx_ethlite *s = XILINX_ETHLITE(dev);
+    XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
@@ -239,7 +238,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 
 static void xilinx_ethlite_init(Object *obj)
 {
-    struct xlx_ethlite *s = XILINX_ETHLITE(obj);
+    XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
@@ -249,9 +248,9 @@ static void xilinx_ethlite_init(Object *obj)
 }
 
 static Property xilinx_ethlite_properties[] = {
-    DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong, 1),
-    DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong, 1),
-    DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),
+    DEFINE_PROP_UINT32("tx-ping-pong", XlnxXpsEthLite, c_tx_pingpong, 1),
+    DEFINE_PROP_UINT32("rx-ping-pong", XlnxXpsEthLite, c_rx_pingpong, 1),
+    DEFINE_NIC_PROPERTIES(XlnxXpsEthLite, conf),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -264,17 +263,14 @@ static void xilinx_ethlite_class_init(ObjectClass *klass, void *data)
     device_class_set_props(dc, xilinx_ethlite_properties);
 }
 
-static const TypeInfo xilinx_ethlite_info = {
-    .name          = TYPE_XILINX_ETHLITE,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(struct xlx_ethlite),
-    .instance_init = xilinx_ethlite_init,
-    .class_init    = xilinx_ethlite_class_init,
+static const TypeInfo xilinx_ethlite_types[] = {
+    {
+        .name          = TYPE_XILINX_ETHLITE,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(XlnxXpsEthLite),
+        .instance_init = xilinx_ethlite_init,
+        .class_init    = xilinx_ethlite_class_init,
+    },
 };
 
-static void xilinx_ethlite_register_types(void)
-{
-    type_register_static(&xilinx_ethlite_info);
-}
-
-type_init(xilinx_ethlite_register_types)
+DEFINE_TYPES(xilinx_ethlite_types)
-- 
2.45.2


