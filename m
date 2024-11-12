Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325C8D42BBE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 18:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAvMS-00052O-WC; Tue, 12 Nov 2024 13:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMF-0004zL-N6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:22 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tAvMB-0001tm-TC
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 13:11:18 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38207c86695so910310f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 10:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731435074; x=1732039874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vHIdtfs7hylvYAHt1fb/5wAWL2WHXc3GjbNq8ajJe0=;
 b=bcaPTC0VbWlVEW0pXDWB13g7nGlvX6bgmgfe1P3veS0eq8291p9oHTJKZftonxWekT
 TTy87ZtdW0OEeJO/kyH+5P80K7TXTs7FVsJvjFXquKsz0BLCEX1HTPFeZoVmiJ9N6Cej
 6tfLUK1Qd+3hEU88JsyAHRKya2cVRCp17KkFTJCESnfW5lWy/gj9EWxrGrOppTmH5N0P
 ydPld5W/kAGs+VP/sy/3P/gjIsxsR685l76pOxU6PcUHdIOB3P5NbE4kyMEiVS5tVV+n
 KPzEvqbIiIuxf8hmqxNAJpspZXroeBonNqMucvp5ef19omrSXx6oyMnJbK/Y2ishAEL8
 sV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731435074; x=1732039874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vHIdtfs7hylvYAHt1fb/5wAWL2WHXc3GjbNq8ajJe0=;
 b=rRdkWLKBdqDgjUvr4jCsrG1Y8izFqsnnlue8OD57ZHVOU0Xt/6e6Tx64N+m6Kyq1ME
 sBRP0vztKsIFh1RXheNN8FnJJ6b794gaOaJzN/sjlKXIZO98gsrHgqirxcw+82zBqmWE
 8boYcXt9U3GfVrweBM7CXL/vZEmECrE0xWIbZDOVno/BmRS44ntj/6xKsJRAAQnkkyjo
 6+cPxA76cEBKAMjcqWf14OKII9JZGvaezzvcL2/alKzcrcyivCeVL5h2bMuP5Xmrifu2
 8bfSaGZsQ29dfaKEEmlwzpEfeUAVF1poyZ9UhTmhhowOr5qY/NdSG9iMpZT/kpNNIrvY
 br3g==
X-Gm-Message-State: AOJu0YwK+kpm6WKZNbFaHsDw+Sdb1l8jb6Ut506QssnieZ5CoN4LCR5u
 PZZU+x+s6SFIWTcWEJ5sm8o5krxiRbav2gUcajj31/haG2DnorHPvL+R9fSojCFVxeC293ZiX0q
 M
X-Google-Smtp-Source: AGHT+IEa9eolNpml3bWXBu/wVzVylLcVLUzgMqxXd3ZeArJKM+zjODJkM2l2qX9oNER3+BKsvDJ5mg==
X-Received: by 2002:a05:6000:2588:b0:381:c8fe:20b1 with SMTP id
 ffacd0b85a97d-381f18855b8mr14253688f8f.42.1731435074007; 
 Tue, 12 Nov 2024 10:11:14 -0800 (PST)
Received: from localhost.localdomain
 (cnf78-h01-176-184-27-250.dsl.sta.abo.bbox.fr. [176.184.27.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda03e8asm15986444f8f.90.2024.11.12.10.11.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Nov 2024 10:11:13 -0800 (PST)
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
Subject: [PATCH 04/20] hw/net/xilinx_ethlite: Update QOM style
Date: Tue, 12 Nov 2024 19:10:28 +0100
Message-ID: <20241112181044.92193-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112181044.92193-1-philmd@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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


