Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5E7CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMtoS-0002Ua-Om; Tue, 12 May 2026 16:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMto8-0002Mo-8E
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMto5-0002Lk-Fe
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:34:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso54641545e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 13:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778618059; x=1779222859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cEpKJWK5V6JDGRyw7DYJPQ9RxwfD1fQlpX/kpuDU7mw=;
 b=uqHUhGpEllQQWFqohi2RbiYU6QYP6zZrqTXgF+hEnSdxzir3KHsmbZY7OWewweIe7D
 sdemjkjskauCuweR0eREzA/DKhDFc4N8Nk1e8iv86xwCRKX/b2NIInIbujSB30wxaa3g
 XwW1sDM7ax0d559YnzDwRVtSgPTS3jj3YHibBvkHuOvukouFcRem+TVhK3L5rmZiR9/1
 k0pzXZ2Kf4zW/nhjm/aXM8crdg9dXFERlTCK4nw2aw442N4LU1GYCynHta87CWzSxizv
 Ra0yAK3AANOanEH6q1h4Ij6xudUsUBlA6KtVVvFmQ0MF+/4NGl0k0r27MmADdpR+P/JJ
 QwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778618059; x=1779222859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cEpKJWK5V6JDGRyw7DYJPQ9RxwfD1fQlpX/kpuDU7mw=;
 b=fn2VTk0ZyGsgR95OrnH0Jccl5+tkKowJOpVH8+MKUYK9AdfM74b7BaJs3qn5nU4TCJ
 hUiQVIYtKgVO/0SeQBHYlttLTw/zTuSo7GOZnuDNw6YnDo+VnJRPF/juGCxQ8gRPNvDe
 dRNXqLq8XRbYirSI38GO59pAEQAo/0E85OjTGcWJG4cnPa3+QHrPJK2kxvcC4FnCVbCp
 s0mDYepkuKlAw9HFiSdxt+8i7gRt/i7V3sLlpnW+Z7TxjFnMafwbdkdr0niO2QCcJkma
 HmHR4pF/Q3usSirw3eXIAApbtvQfqJv4RXp6JQY22xqXJMi4SANJ5UXdX63OyS3hOJTg
 BRfg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9l6qcaQaEq+/heV8uJJ38MTxTUYKt8ybAYFe6AtnjhVNfAeAn0bOU77M062Be/wnwKqqmFZVspK9tS@nongnu.org
X-Gm-Message-State: AOJu0YzEK4hnnitCGbiThoyf92bb3YWvmJVwalGbJiS8VTgei2R7dxyj
 8mePGIxagYb9hG11r5HmzbKPkjj5rl7q0GdI9O1WwUCStfjxJdv3n/AIRdDsgCtKYHg5PMv81x1
 jCuV6
X-Gm-Gg: Acq92OENVBkKLJle8Tpt9/UBRbTwCIxpUGi6ZMtYNpg3Vc9DcFYoQRlv+bU4lFlNkby
 qHKnFOhArP98zXtcc668fudjdeCr/wFxuuRFvQd7d1jsU+avuI76nwgyTUPI4o9vdjjamdmUiFM
 T55vOn1OEn9v1V5dtkP5c4vjJIReAumVoEippPhk5KOnCXkyfZS+QKYpa3o+Gaxth7PsY8FG5+I
 6a4/Ju9tpb3uvDdrGwtGdCd/U4Mwx43RrdfNW7PR+pN78MifkDXs8jBPtXXoovtR98gs/1tZ9I7
 WBSxN1CsbZ305dk6f2tWTQSuf3r4ynjjBbcqtfYZ9UCuMrGXe0zbkdr5pCr3BbEAEQVXJmfIVvW
 wvmsrPI9mvzDEPKGzqRQ/x/mmwhKopa74eXIyeg3yJuq9GJ1ePQfcsRdI8IQJFETsB8CAeP6V4F
 NHS8ubCSzP36qlU2aLMjc/AYSE7s0ENCa+RRiFXw5WkHJ4lVqj6APsLA9QvRsBZb9liXLyctUHd
 hVeaSQQkgDWmbygIDOh7vv1NRLlaenJAhdCbpbpfQ==
X-Received: by 2002:a05:600c:1d03:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48fc9a100damr6299365e9.10.1778618058987; 
 Tue, 12 May 2026 13:34:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d69d0bsm16350635e9.13.2026.05.12.13.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 13:34:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/12] hw/arm/omap: Remove omap_mpu_model remnants
Date: Tue, 12 May 2026 21:34:03 +0100
Message-ID: <20260512203414.3633237-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512203414.3633237-1-peter.maydell@linaro.org>
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

The omap1.c code has handling for an mpu_model field which is
an enum of which OMAP SoC model it is. We removed most of our
OMAP support some time ago, and now the only OMAP SoC we
implement is the OMAP310, which sets s->mpu_model = omap310
in omap310_mpu_init().

That makes all the handling for other settings of mpu_model dead
code; remove them.  This includes the omap GPIO device's mpu_model
property which we set but which the device makes no use of, and the
omap-id-e20 memory region (because the OMAP310 satisfies
cpu_is_omap15xx(), so never executed the old if() block).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/omap1.c        | 28 ++--------------------------
 hw/gpio/omap_gpio.c   |  6 ------
 hw/misc/omap_clk.c    |  9 +--------
 include/hw/arm/omap.h | 18 ------------------
 4 files changed, 3 insertions(+), 58 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 980959166d..c9f9c3ef40 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -948,8 +948,6 @@ static void omap_pin_cfg_init(MemoryRegion *system_memory,
 static uint64_t omap_id_read(void *opaque, hwaddr addr,
                              unsigned size)
 {
-    struct omap_mpu_state_s *s = opaque;
-
     if (size != 4) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
                       " with bad width %d\n", __func__, addr, size);
@@ -968,25 +966,10 @@ static uint64_t omap_id_read(void *opaque, hwaddr addr,
         return 0xcafeb574;
 
     case 0xfffed400:    /* JTAG_ID_LSB */
-        switch (s->mpu_model) {
-        case omap310:
-            return 0x03310315;
-        case omap1510:
-            return 0x03310115;
-        default:
-            hw_error("%s: bad mpu model\n", __func__);
-        }
-        break;
+        return 0x03310315; /* omap310 */
 
     case 0xfffed404:    /* JTAG_ID_MSB */
-        switch (s->mpu_model) {
-        case omap310:
-            return 0xfb57402f;
-        case omap1510:
-            return 0xfb47002f;
-        default:
-            hw_error("%s: bad mpu model\n", __func__);
-        }
+        return 0xfb57402f; /* omap310 */
         break;
     }
 
@@ -1022,11 +1005,6 @@ static void omap_id_init(MemoryRegion *memory, struct omap_mpu_state_s *mpu)
     memory_region_init_alias(&mpu->id_iomem_ed4, NULL, "omap-id-ed4", &mpu->id_iomem,
                              0xfffed400, 0x100);
     memory_region_add_subregion(memory, 0xfffed400, &mpu->id_iomem_ed4);
-    if (!cpu_is_omap15xx(mpu)) {
-        memory_region_init_alias(&mpu->id_iomem_ed4, NULL, "omap-id-e20",
-                                 &mpu->id_iomem, 0xfffe2000, 0x800);
-        memory_region_add_subregion(memory, 0xfffe2000, &mpu->id_iomem_e20);
-    }
 }
 
 /* MPUI Control (Dummy) */
@@ -3819,7 +3797,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
     MemoryRegion *system_memory = get_system_memory();
 
     /* Core */
-    s->mpu_model = omap310;
     s->cpu = ARM_CPU(cpu_create(cpu_type));
     s->sdram_size = memory_region_size(dram);
     s->sram_size = OMAP15XX_SRAM_SIZE;
@@ -3974,7 +3951,6 @@ struct omap_mpu_state_s *omap310_mpu_init(MemoryRegion *dram,
                                s->wakeup, omap_findclk(s, "clk32-kHz"));
 
     s->gpio = qdev_new("omap-gpio");
-    qdev_prop_set_int32(s->gpio, "mpu_model", s->mpu_model);
     omap_gpio_set_clk(OMAP1_GPIO(s->gpio), omap_findclk(s, "arm_gpio_ck"));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(s->gpio), &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(s->gpio), 0,
diff --git a/hw/gpio/omap_gpio.c b/hw/gpio/omap_gpio.c
index ee3ddb09e3..16da9a88d9 100644
--- a/hw/gpio/omap_gpio.c
+++ b/hw/gpio/omap_gpio.c
@@ -45,7 +45,6 @@ struct Omap1GpioState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    int mpu_model;
     void *clk;
     struct omap_gpio_s omap1;
 };
@@ -228,17 +227,12 @@ void omap_gpio_set_clk(Omap1GpioState *gpio, omap_clk clk)
     gpio->clk = clk;
 }
 
-static const Property omap_gpio_properties[] = {
-    DEFINE_PROP_INT32("mpu_model", Omap1GpioState, mpu_model, 0),
-};
-
 static void omap_gpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = omap_gpio_realize;
     device_class_set_legacy_reset(dc, omap_gpif_reset);
-    device_class_set_props(dc, omap_gpio_properties);
     /* Reason: pointer property "clk" */
     dc->user_creatable = false;
 }
diff --git a/hw/misc/omap_clk.c b/hw/misc/omap_clk.c
index e927ef22a0..dc398570ac 100644
--- a/hw/misc/omap_clk.c
+++ b/hw/misc/omap_clk.c
@@ -707,14 +707,7 @@ void omap_clk_init(struct omap_mpu_state_s *mpu)
 {
     struct clk **i, *j, *k;
     int count;
-    int flag;
-
-    if (cpu_is_omap310(mpu))
-        flag = CLOCK_IN_OMAP310;
-    else if (cpu_is_omap1510(mpu))
-        flag = CLOCK_IN_OMAP1510;
-    else
-        return;
+    int flag = CLOCK_IN_OMAP310;
 
     for (i = onchip_clks, count = 0; *i; i ++)
         if ((*i)->flags & flag)
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 66a435a3d7..6ea47293a6 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -542,24 +542,7 @@ void omap_mmc_set_clk(DeviceState *dev, omap_clk clk);
 /* omap_i2c.c */
 I2CBus *omap_i2c_bus(DeviceState *omap_i2c);
 
-#define cpu_is_omap310(cpu)        (cpu->mpu_model == omap310)
-#define cpu_is_omap1510(cpu)       (cpu->mpu_model == omap1510)
-#define cpu_is_omap1610(cpu)       (cpu->mpu_model == omap1610)
-#define cpu_is_omap1710(cpu)       (cpu->mpu_model == omap1710)
-
-#define cpu_is_omap15xx(cpu)       \
-        (cpu_is_omap310(cpu) || cpu_is_omap1510(cpu))
-#define cpu_is_omap16xx(cpu)       \
-        (cpu_is_omap1610(cpu) || cpu_is_omap1710(cpu))
-
 struct omap_mpu_state_s {
-    enum omap_mpu_model {
-        omap310,
-        omap1510,
-        omap1610,
-        omap1710,
-    } mpu_model;
-
     ARMCPU *cpu;
 
     qemu_irq *drq;
@@ -571,7 +554,6 @@ struct omap_mpu_state_s {
     MemoryRegion id_iomem;
     MemoryRegion id_iomem_e18;
     MemoryRegion id_iomem_ed4;
-    MemoryRegion id_iomem_e20;
     MemoryRegion mpui_iomem;
     MemoryRegion tcmi_iomem;
     MemoryRegion clkm_iomem;
-- 
2.43.0


