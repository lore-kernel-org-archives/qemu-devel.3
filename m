Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4858EE77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSimB-0003Hk-Pi; Tue, 31 Dec 2024 15:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSim9-0003HI-U1
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:37 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSim7-0000st-Vd
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:37 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso67542355e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676613; x=1736281413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBx+XgL3+wHjk0kADMiKJc0p/3jViH600fZFb8NkyI4=;
 b=NDRicbFqHJLNsVS86qJfOk0KGab2o0ltuDpiELI/FuGWnOQxAF606BO9umtQgfTSJq
 TYAapaX0JHWIAtE0exi8snZkh0Lfouk/iSaD2Ac66K5YO6TVS8yNQhOg/vT40O5vCaZa
 ZsKE61+phMkjgZgwMn2JnQxAmyyvvJ7PpDeg9D8GGyxzPMMtUy2MQxYKCeOaeNkEKJiM
 D661Zy6XNnjW1MBa4BJwoXU2B3GOLpq5He1ssbAIKVdLSGcJHoqGZcCMV7il0hPT6eMw
 VQydszWiOvSUeL35gZilpX+aKDHY1Fewn7Vir2LMSd7z1W/tr13opabVJAlV0VW0FMei
 c0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676613; x=1736281413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBx+XgL3+wHjk0kADMiKJc0p/3jViH600fZFb8NkyI4=;
 b=GIeW0dZj6G/t0uQOpWM0nMlb8C6NQrqPmyXYgg7xkr0iJqQKmMkXKYEE6DeqtDQPhp
 A62CjIe5udRg5OstD8S0N6ryg2fAwnSG+70RTZ/iEfFbSDEpT3xJaK/ierw41ag301fE
 ggR4NGIaTtEak43laOgTmDLLBgKqcQzU5jxm64kHyp7FbEpmu3jTNN+8hjYNUuWGg+m1
 holum7g+6cGr1bdOdeUuW/7FcCufFfJR3Lwc1V48xavanNyGhBTNfFgEjSlwXyxrNxUx
 0vhLSpVtDj3Unv+UOlTT5ihUjzWd4QA2E1l7czH4qpgrlRTGW/owpbv9UUMapVyfaYsF
 m84g==
X-Gm-Message-State: AOJu0YyZ3sYz/yT3N5+aOLJgIv+J6gwktxycJOl65islE4ipHte/jPY0
 bBpLW3Wd5uPv1kWyx6d1J4HWqS95BZX6ZyYkPkMXprJ+e3BNxbCMfMZd/RFVmdFbGHDxEMvOC1O
 ueZY=
X-Gm-Gg: ASbGncv9zRNyjshsMw1ZGLZXVy0MYRtF4AiMlFyoRRL+M/YN/lyswOKCQ4nA/vGrPhi
 JT4K0kdgrSiEfG1KYpIZkkBWPmuDSNZ7hA2IuorDktXqkCGg58lGC3TpUpIjHw+TguDTtYE0G9E
 k/jQjiI5bZfOpVHAFPecofN8RHj9KzvVgJEz/OGtcnoeDsMcwcHLTlRS6VOZw4lWUFFZTm3U+cl
 GgnrwyjGYCU59++11qEpqEf14sXX/HmTPyHAkpOZS4mCfGVHatiXXU3wv3wajKs3jqaG16MDLWm
 y8M0pn1ZCe77+7n/FqfjWVOfAnmDA14=
X-Google-Smtp-Source: AGHT+IHELpf1i8MPcNSQADaHf1P41hWRcS9t08EJBfcvQ/EeH99GZEKTx0Y5v1ASwcQWhochAgZbWA==
X-Received: by 2002:a05:600c:138d:b0:434:a4fe:cd71 with SMTP id
 5b1f17b1804b1-436686439e6mr363755435e9.12.1735676613458; 
 Tue, 31 Dec 2024 12:23:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a71sm395623055e9.26.2024.12.31.12.23.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 13/29] hw/net/xilinx_ethlite: Update QOM style
Date: Tue, 31 Dec 2024 21:22:12 +0100
Message-ID: <20241231202228.28819-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Use XlnxXpsEthLite typedef, OBJECT_DECLARE_SIMPLE_TYPE macro;
convert type_init() to DEFINE_TYPES().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20241112181044.92193-5-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 48 +++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 4626a55b069..330dccb83df 100644
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
 
@@ -172,7 +171,7 @@ static const MemoryRegionOps eth_ops = {
 
 static bool eth_can_rx(NetClientState *nc)
 {
-    struct xlx_ethlite *s = qemu_get_nic_opaque(nc);
+    XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
     unsigned int rxbase = s->rxbuf * (0x800 / 4);
 
     return !(s->regs[rxbase + R_RX_CTRL0] & CTRL_S);
@@ -180,7 +179,7 @@ static bool eth_can_rx(NetClientState *nc)
 
 static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 {
-    struct xlx_ethlite *s = qemu_get_nic_opaque(nc);
+    XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
     unsigned int rxbase = s->rxbuf * (0x800 / 4);
 
     /* DA filter.  */
@@ -210,7 +209,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
 
 static void xilinx_ethlite_reset(DeviceState *dev)
 {
-    struct xlx_ethlite *s = XILINX_ETHLITE(dev);
+    XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
     s->rxbuf = 0;
 }
@@ -224,7 +223,7 @@ static NetClientInfo net_xilinx_ethlite_info = {
 
 static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 {
-    struct xlx_ethlite *s = XILINX_ETHLITE(dev);
+    XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
@@ -235,7 +234,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 
 static void xilinx_ethlite_init(Object *obj)
 {
-    struct xlx_ethlite *s = XILINX_ETHLITE(obj);
+    XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
 
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
 
@@ -245,9 +244,9 @@ static void xilinx_ethlite_init(Object *obj)
 }
 
 static const Property xilinx_ethlite_properties[] = {
-    DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong, 1),
-    DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong, 1),
-    DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),
+    DEFINE_PROP_UINT32("tx-ping-pong", XlnxXpsEthLite, c_tx_pingpong, 1),
+    DEFINE_PROP_UINT32("rx-ping-pong", XlnxXpsEthLite, c_rx_pingpong, 1),
+    DEFINE_NIC_PROPERTIES(XlnxXpsEthLite, conf),
 };
 
 static void xilinx_ethlite_class_init(ObjectClass *klass, void *data)
@@ -259,17 +258,14 @@ static void xilinx_ethlite_class_init(ObjectClass *klass, void *data)
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
2.47.1


