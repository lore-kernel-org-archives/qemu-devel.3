Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E597C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:14:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWia-0000Kj-RK; Tue, 18 Mar 2025 09:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWi7-00081M-2B; Tue, 18 Mar 2025 09:10:30 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWi4-0003e1-Iz; Tue, 18 Mar 2025 09:10:22 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so956510866b.1; 
 Tue, 18 Mar 2025 06:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303418; x=1742908218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SozXszkG31YRNwyf2TrQDfv+7hb5ByzoAPkFEtmPEVA=;
 b=Ki3i7akrX7Os+sHwPf7hIrZvBjXarg+dYvowIMkpdG866zLCfQhFqzJtk85PE3Zt3q
 v4bXHGBh7qilquy8K7bgYiXZSq31zWLvrmg3BRlVFzKuOXlHVCHzMR4KtP9iY0nePzZU
 nDbM3/Bfnyg7wG1cPDLSwN/votqsFkcTmYc+h6mZAuZoRuRt3FIyYf6yTMtFSJg7C0PU
 R0D5KzNuoOToSEMIsy6ZJPGz1Y65thwwY28fnZqwtIQvxXh17U9RlqxHDuqh7GY+0iv5
 HR1H/vGn0ChGpivsI48sFVSaU8MibESlFvja2Vxk49FenhMILTzITpxR/8x16n/Cu0Zr
 rhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303418; x=1742908218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SozXszkG31YRNwyf2TrQDfv+7hb5ByzoAPkFEtmPEVA=;
 b=ibS6fictacpLKXf9ANoRbzUl8mAr0nw7a1CdhBB3DzGmA5zeUYQOYbC6IHC1xmHk4B
 gnoeBS5eqNp8K5/dNNWlBq5VwWDA3W4z3hrXPApD3QgfbpXkVMiZvXhT1T+sxlDLHdsK
 xTJJtWD3+cboOnhdVERwcQjCwtVymGoDlHgfsQbrIHaP/yGyfvM11ju7TQaDYk2nGvrg
 1Ulhg+wT+KXaJCqU3Bb9pr2e1JHM3I0GN0yuBK5Nj58ftNiUcL+tAs2TMm2VbY2IRaJm
 K5Q5nZYpaHAjT9VGKIv35TbkqcYcMXQ+z5GM1Q2hPfm3g6MUnD7KJtJ6UkyC2gI1My8f
 JkdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU284TvZorRllxx/gfk0KfjHdocxNOy9LjRz9WIHuYQ+fm1bfw2l4CFD0JPZggfZ1T/pZznIx/NxA==@nongnu.org
X-Gm-Message-State: AOJu0Yxp08slqXq0Rn1AiBz0fU9IKwRfb4di9rA0+iLzBlMHcyLbEzA0
 EZO4C+NDmekfU1GCHkrgxX1syiXZCgxDJZCgzUC1+4LFhpNBsdsQuc119tDI
X-Gm-Gg: ASbGncslFs081OuhQN5jvRlV3Np+OSAcOAfRXI/x7sWNMfXblyiHGGOjm8YApZDeLg9
 dIZOBlQInoFb+33aeHRDo4Pd6oQafgAAStKqsEOP8oMvwAD9yFGONVM1RJ9EqYx6QCzbwQ8n9nb
 NcLgmJGxU1nP5jenZLTu4e22nZI2ZF9PlqGnjxkDbbFrceEhcfm+sEN7kXgfL9ZGHqCuerOkoG7
 CupWFRG2icK2aBe81AQE78ra4aAEx9k60aREgmtZqyhAUDHh9rte7luCVM8wfu7hG6hmU+Z1CDl
 qEWXR0jQiTlZbT3lnteOTeR5yvr35i3JoVsb6uRam4bLTBouGWzN1X1winBCtOGiQYo=
X-Google-Smtp-Source: AGHT+IGmZzSU37v1cJSEPDwzraMCy7qKeCYt1s/NiEPp4sykw39xgGCTQyycokvd6NKvByWJ6zNJgA==
X-Received: by 2002:a17:907:d9f:b0:ac3:8d37:b33b with SMTP id
 a640c23a62f3a-ac38d37b37emr358706766b.13.1742303411992; 
 Tue, 18 Mar 2025 06:10:11 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:10:06 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 05/21] hw/dma/zynq: Notify devcfg on FPGA reset via SLCR
 control
Date: Tue, 18 Mar 2025 14:07:56 +0100
Message-ID: <20250318130817.119636-6-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

When the FPGA_RST_CTRL register in the SLCR (System Level Control
Register) is written to, the devcfg (Device Configuration) should
indicate the finished reset.

Problems occure when Loaders trigger a reset via SLCR and poll for
the done flag in devcfg. Since the flag will never be set, this can
result in an endless loop.

A callback function `slcr_reset_handler` is added to the
`XlnxZynqDevcfg` structure. The `slcr_reset` function sets the
`PCFG_DONE` flag when triggered by an FPGA reset in the SLCR.
The SLCR write handler calls the `slcr_reset` function when the
FPGA reset control register (`R_FPGA_RST_CTRL`) is written with
the reset value.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c         |  7 +++++++
 hw/misc/zynq_slcr.c               | 16 ++++++++++++++++
 include/hw/dma/xlnx-zynq-devcfg.h |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index 03b5280228..611a57b4d4 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -138,6 +138,11 @@ static void xlnx_zynq_devcfg_update_ixr(XlnxZynqDevcfg *s)
     qemu_set_irq(s->irq, ~s->regs[R_INT_MASK] & s->regs[R_INT_STS]);
 }
 
+static void slcr_reset (DeviceState *dev) {
+    XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(dev);
+    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
+}
+
 static void xlnx_zynq_devcfg_reset(DeviceState *dev)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(dev);
@@ -374,6 +379,8 @@ static void xlnx_zynq_devcfg_init(Object *obj)
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(obj);
     RegisterInfoArray *reg_array;
 
+    s->slcr_reset_handler = slcr_reset;
+
     sysbus_init_irq(sbd, &s->irq);
 
     memory_region_init(&s->iomem, obj, "devcfg", XLNX_ZYNQ_DEVCFG_R_MAX * 4);
diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index a766bab182..9b3220f354 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -26,6 +26,7 @@
 #include "qom/object.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "hw/dma/xlnx-zynq-devcfg.h"
 
 #ifndef ZYNQ_SLCR_ERR_DEBUG
 #define ZYNQ_SLCR_ERR_DEBUG 0
@@ -576,6 +577,21 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
         zynq_slcr_compute_clocks(s);
         zynq_slcr_propagate_clocks(s);
         break;
+    case R_FPGA_RST_CTRL:
+        if (val == 0) {
+            Object *devcfgObject =
+                    object_resolve_type_unambiguous("xlnx.ps7-dev-cfg", NULL);
+            if (!devcfgObject) {
+                break;
+            }
+            DeviceState *devcfg = OBJECT_CHECK(DeviceState, devcfgObject,
+                                               "xlnx.ps7-dev-cfg");
+            XlnxZynqDevcfg *zynqdevcfg = XLNX_ZYNQ_DEVCFG(devcfg);
+            if (zynqdevcfg) {
+                zynqdevcfg->slcr_reset_handler(devcfg);
+            }
+        }
+        break;
     }
 }
 
diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq-devcfg.h
index 2ab054e598..f48a630c5a 100644
--- a/include/hw/dma/xlnx-zynq-devcfg.h
+++ b/include/hw/dma/xlnx-zynq-devcfg.h
@@ -56,6 +56,7 @@ struct XlnxZynqDevcfg {
     uint8_t dma_cmd_fifo_num;
 
     bool is_initialized;
+    void (*slcr_reset_handler) (DeviceState *dev);
 
     uint32_t regs[XLNX_ZYNQ_DEVCFG_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQ_DEVCFG_R_MAX];
-- 
2.49.0


