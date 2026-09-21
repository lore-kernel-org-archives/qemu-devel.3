Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED984C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrr-0006R9-GZ; Mon, 21 Sep 2026 17:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrm-0006J3-5y
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:02 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrk-0000IX-2P
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:48:01 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912df756so24023245e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027269; x=1790632069; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dQ+y+HOgk2flqhRgS2Cprok52hJaeXGfKUopI52BI5g=;
 b=ICUwbzhg+vSGnAfOr63OVIXcLwCkMOcHnsyqMsnaXtOrBV7ZMkZkXF+MbacHp/2k59
 +Kl3gYFiJ90b2FXaH0jzQVupQT1RCG4MxB82KvL85Lxt8McHq2hSNmABn+JfqBVC/BVN
 DDBHCxx3G6ggl0fp4TiKaskVt8begj8lmNcUTo89hFB1sfkH/4b6T11Dmip5oFaUQum4
 IoVtMppnIjxbG++ZgDWCN+LFIDPiv7vpwIvGlWdSoItiS9FZ1iPxPaAbeMB1+sHODRhN
 mVpQdDpgxzsql3ZP5QRRzI8Ss+t3RmaTj/wB2D7W7wL6bdQMhyF8vxNNfeSVyvpBuq+x
 gWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027269; x=1790632069;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQ+y+HOgk2flqhRgS2Cprok52hJaeXGfKUopI52BI5g=;
 b=kGb66LuKc8HiQqjp48hLayP4Yvxg5Gjsd4+mfePvQLj1iOWQCuCV94qRoipFThl9FZ
 TU8nQBxxoXC5PG5c5rakovgPEPCyMEkiUU0AzueqH70Q3rz+4OSxywOu+bU2QH6KZTL+
 PZWR5QFnyMv/5I4qn0AE9IKRyk6rxPDZHiPTW1ErH7Qh2kIn9lBe0GiVlPKZUg2rGD/V
 zwENKhiwyYsH18CJsI+QQPIwvO6A05dS1Jz02qilW2UWE2IsA9CPbMNjvXgGnHpjXEi0
 UCliF+ONb2A09Ztox+re2/HxHk7DIv+JWXcWMh+Tjm0ExwvC8XSLyw0G5lkV/DktvysQ
 dRpQ==
X-Gm-Message-State: AFuF++kRFCM3Vw00cu8eaXeuVvyWl/y+MfioPlmNy6BwncqOMbTFp9Qo
 F5kCT/FZG5TiRPmJDubRJTL9YyqKI9U+ZLeLVu60LakuFgPfjg1HdeWDJmWmVQ==
X-Gm-Gg: AYBFou1Mwh+aLCwfqyWEHhR0PUso1JxK99lLwXga+AHHd5fdNrhMUcH2+UNx8TwUjYA
 i8zDf96qAS6rf7bjJV6lWB/+5gHkb479HXSXddFR2EUPolxsUsQjD2b+ELwD+vqSqj+ZlgDyFvS
 YWqpbZ5EzV5EUZKw0onf4f8zyi+J/qVbUBRxdBiQOvjTfngrCa/k6IZQsMp4sY9m1+LovIAzOzA
 1l3ZE/1vDPQVuY6Zlb19cFJoop69yEa4mZsNnD7ezIXqsQXkouKOH9oDIA3VAhOpmh7rVCgsr1v
 oAuGSJOjKMMSvVmNgjdsNU2R5Jd/2QtsHdvWCAde2pASmgfbxvVC3IfPPLQ5QN3oAz/pYjDbzNR
 NKh3YHtD4S8NN8AGLO8yV6+M6QzPbEMl2HR4krzWJMXnWrH5ZvSzGQufn/IbYX7ZWmh0LRJwkhh
 9vFut7Ah/tCU2pjnHfk6EgPzJSPvsiruvsY9gtlZxoKhv4Bh5hhx8/89Bx+iriNCnDigaiu8i9X
 a2QJ/Z0HRaaNnnMLAXrXSrziq2pASm8Mo4DPSDmGtF935r70hSoMcg1Nhuq9c7VoG2usTjJLGDS
 na8=
X-Received: by 2002:a05:600d:4453:10b0:49f:cbf1:e77b with SMTP id
 5b1f17b1804b1-49fcbf1e9eamr101288265e9.10.1790027268631; 
 Mon, 21 Sep 2026 14:47:48 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 16/42] hw/timer/imx_gpt: Wire clock control module via link
 property
Date: Mon, 21 Sep 2026 23:46:44 +0200
Message-ID: <20260921214710.29422-17-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When wiring struct IMXGPTState to the clock control module, it is
currently necessary to reach into its private data. Moreover, when
forgetting to wire the clock control module, QEMU will crash after the
guest has already started. Fix both by letting struct IMXGPTState
expose a link property which is checked at realize time.

Inspired-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx25.c  |  3 ++-
 hw/arm/fsl-imx31.c  |  3 ++-
 hw/arm/fsl-imx6.c   |  3 ++-
 hw/arm/fsl-imx6ul.c |  3 ++-
 hw/arm/fsl-imx7.c   |  3 ++-
 hw/arm/fsl-imx8mm.c |  3 ++-
 hw/arm/fsl-imx8mp.c |  3 ++-
 hw/timer/imx_gpt.c  | 14 ++++++++++++++
 8 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index efb22359c5..0840c2d86a 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -138,7 +138,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_GPT4_ADDR, FSL_IMX25_GPT4_IRQ }
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index dd929c1085..b440ad6e28 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -105,7 +105,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                             serial_table[i].irq));
     }
 
-    s->gpt.ccm = IMX_CCM(&s->ccm);
+    object_property_set_link(OBJECT(&s->gpt), "clock-control-module",
+                             OBJECT(&s->ccm), &error_abort);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7ba9b85a2e..22deb72496 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -204,7 +204,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(gic, serial_table[i].irq));
     }
 
-    s->gpt.ccm = IMX_CCM(&s->ccm);
+    object_property_set_link(OBJECT(&s->gpt), "clock-control-module",
+                             OBJECT(&s->ccm), &error_abort);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt), errp)) {
         return;
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 84451c9909..2786889bda 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -245,7 +245,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_GPT2_IRQ,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index fc5d0efe06..9e206c59a1 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -250,7 +250,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_GPT4_IRQ,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), &error_abort);
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpt[i]), 0, FSL_IMX7_GPTn_ADDR[i]);
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpt[i]), 0,
diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 875e92bb34..37934d2951 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -420,7 +420,8 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
             fsl_imx8mm_memmap[FSL_IMX8MM_GPT6].addr,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index bcd91739d9..f855378dff 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -447,7 +447,8 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
             fsl_imx8mp_memmap[FSL_IMX8MP_GPT6].addr,
         };
 
-        s->gpt[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->gpt[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
 
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpt[i]), errp)) {
             return;
diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index cdc0257126..22fc8203bf 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -15,8 +15,10 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
 #include "hw/timer/imx_gpt.h"
 #include "migration/vmstate.h"
+#include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -522,6 +524,12 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
     IMXGPTState *s = IMX_GPT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    if (!s->ccm) {
+        error_setg(errp, "%s 'clock-control-module' link property not set",
+                   dev->canonical_path);
+        return;
+    }
+
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_gpt_ops, s, TYPE_IMX_GPT,
                           0x00001000);
@@ -530,12 +538,18 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
     s->timer = ptimer_init(imx_gpt_timeout, s, PTIMER_POLICY_LEGACY);
 }
 
+static const Property imx_timer_gpt_properties[] = {
+    DEFINE_PROP_LINK("clock-control-module", IMXGPTState, ccm, TYPE_IMX_CCM,
+                     IMXCCMState *),
+};
+
 static void imx_gpt_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = imx_gpt_realize;
     device_class_set_legacy_reset(dc, imx_gpt_reset);
+    device_class_set_props(dc, imx_timer_gpt_properties);
     dc->vmsd = &vmstate_imx_timer_gpt;
     dc->desc = "i.MX general timer";
 }
-- 
2.55.0


