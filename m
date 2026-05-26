Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90659CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmD-0008E1-4T; Tue, 26 May 2026 10:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm9-0008Ch-DG
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm7-0001CO-9L
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490686877a1so14847225e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805734; x=1780410534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=me2XmrRjUesDxOInqcpkPUtfa6VUQxT18GPxCVrkirY=;
 b=E7bLW1mQ5QK5XbFaEOLSxJTnak5hH9bBx06nU+ZLmxR1dHSA/CgKj8+SIowwX0p9Ob
 RXoBzaRC/pMi08qz7P7Ku0ezMCDFgRcsIoSTjgKVfOc0OadiolDEdFa3TVfTQWX/atmD
 3oyIYlRv0CKiIM8N0io39Pd8vm22yNJe/EmkYf9xMyhHyEkyP1jCikJAQElGdONcPCI/
 4kosxePclMOFzu3zbAVF3xVOiS4WNjVSbyZDtUqpcJotZ/zaqrGEoKzHMTKoItTQl44D
 RAETivXhs2rqq37Fiv7K7GvvpwnfsXUOPx4yFZkZLKtTUme+1XgYtqHINHj2iKcRXCK6
 rC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805734; x=1780410534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=me2XmrRjUesDxOInqcpkPUtfa6VUQxT18GPxCVrkirY=;
 b=KOWUKIS5n2VAapC0NQSUyGBQO4I60no7ObGuNYen8f4BjdM4N4b3lQrKKB0rX/ZRY/
 kjIB5LyxSqP3j2Opqz+5moPNwqpSF2PpfIndAoxxhkntF4lD6uVg3Cf22sgtc/XclK0F
 xf7eJ6TsDLUWsJdt/FyZ7zX19d04hlc9dzZgYKzHfAMufv0WJu4oG3tHSw9rDHShakoE
 m7cmC4DLzRYE8hTVZ7jH6oA2tWsWLq/KZfR9LlGIMI8ttYOq2J++2yvtGZHi9dCBAuEX
 zXX9tWpZDgxvGL2wQ2YQiZ8A/beQ/soSpVNNnB/2BCSlOxEo8bYOSJKOD3wNBTF0yMtr
 tk1A==
X-Gm-Message-State: AOJu0YyDvW269C9kkrbgfKK5FmwAiDF764Yf6fqa1xxLvi7YHbi2+lYE
 j9MKdOiOlpk+L/H1hkVKEHkwurwfE7Unw3gZe1kQlVrF/+OIOdQk8N9iP8T17/k4YYRQU/iq2OM
 Ip69q
X-Gm-Gg: Acq92OFugvNPrkgYp6rmX8re9sRYBqFlC1lMEmC9dceiwnBzQRPFbWURpztQPsyk2n/
 IUPxfvZmYIDwmg92Awjiz564OR+5oUWhkXsCZ53+jSPPLN23D3qeUlllASqIoj54khI0iYMI14l
 Vh48I3zFN26psPevSZenov7q2MaGkB78eTsskYsC7xHfp3Nn082nKQZMbuMknslNb5DHHS5JrNN
 VoVLEcabw9YBjbDzncxnFP+SL5Gp2ECNA4dWXwkp9Ni/eKAYjJOFUoNhNVg94NraZgFWE8K4M/6
 pUjJD9vVnPpOpT1QYbxFmmyrB0o8EwUeZ3EAt85lWaiB4ec52zlLjMt/SWmBINgLwJaSKEpHHmn
 2J/1QePQ/+1fRRrxIIWKgAMziwunD238FqUmrv7TCwfVtPHOlqPElZkOJ2IknL6zIMWC1KkRQiy
 N8DY9b0CP/uTNl/Kye8knnlMCTrFE6CDeiunQNVvmxVlpLS8n7r6RmfmT5EBWJy2kkVqIHRm2ks
 qmx/21J2UPPb+SPBBFWfL1kCgHtxG9RPy0nGiy/+A==
X-Received: by 2002:a05:600c:4ec8:b0:490:3b8a:b0c with SMTP id
 5b1f17b1804b1-4903b8a1c34mr308971585e9.3.1779805733791; 
 Tue, 26 May 2026 07:28:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/54] hw/arm/omap: Remove omap_mpu_model remnants
Date: Tue, 26 May 2026 15:27:58 +0100
Message-ID: <20260526142850.2326589-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-2-peter.maydell@linaro.org
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


