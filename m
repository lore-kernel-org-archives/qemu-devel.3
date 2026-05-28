Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F114CD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 20:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wShJF-0003CS-2Q; Thu, 28 May 2026 16:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShI2-0001Pd-HG
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wShI0-0005QK-9d
 for qemu-devel@nongnu.org; Thu, 28 May 2026 16:25:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so86438685e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 13:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779999910; x=1780604710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U73T0WwDvouI7JUnn7GqDjLuee0qDIQnKq6EjhvcV/g=;
 b=TLEyuxmmq+LWAhhZTKr/HALnZjyvQNsSodgK1dO0onRHRATDvrXGqhuC0Kh2qphO0P
 bmin5HylvV8lqBAvllsWJzhsDkcKuYlmoL197JYpxojv5Dk5kXPBMiPzw+TnwcZvIZN8
 /wQFRKDDVqykfDe+UkWW/rg8RcD0GNuZuqQIzAkTaJPg1DpVFrMndmhcOT4EZnLxBD3M
 ZweboVNuETsk9daWe9r6zkDKT424d1LBPao0KXmeMGM5S8Q3GZxQoCCoNHdTM60IZYEK
 QMTbXn6EwWYA83wZbBK3Kdetym4PK6Wux8+jELcF/TiyeBjcqEStgfoUr6SFXgnha2F7
 09FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779999910; x=1780604710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=U73T0WwDvouI7JUnn7GqDjLuee0qDIQnKq6EjhvcV/g=;
 b=lcoedfW/urcw6ao2TmtEMNt9LNsm9TROlkFLqHY5KLv+xxRkbjOm0V3XacV9jPS3yj
 bbOJUn5wEHcDrkVc1mc1Y5FHDrsKImvaLMX+CBdMQTiPumaLn5bD48brsvB62Z/16CUB
 BnVi15c7jLoC904QRiW7VoA5cCoa/qyyDD7XbgLiLrntGBm7p3zXfxEn0sd7+5J54e+p
 N3Di53jFnQL0NlKql4PfnIdZADgHxpdmS4mFjcUXVAspx8SwQ+WVozWWqCBLi03rwkxr
 BVBYF0JmjuVNgtcdpZSJw8LNZChhTNdO/8qZ877wIa5fierKD9Ljmz2Ksvsrm8tlLvVi
 Z/1A==
X-Gm-Message-State: AOJu0YzGQHocKbJH2TMfsfxXx4TX3FpAxoz1pV8b6VsPedGofnzwWjXb
 ycqVitI0ozWLHt7yRSAJuDVdxmCAc78TqVOPIPw1tbpyPFr9WJQl0Wi/Q43Z5nPGv2qCRqIU576
 FLr4hsiUx2Q==
X-Gm-Gg: Acq92OEwoTlY4ZZ+JnSnT32VLa5hfc3HlP6yVeWg0SfKmFx4Qd9jX1Ixg1DvbzBeF72
 fvpN5jyKbkCY7MmK3S9jbV1+tk76EqXQsIbpUjKyrj+8fw6pGniiXD5CZuk+b06MEcqENSPnNyn
 b1qhpnNVf6mtq9kVpdIJXO9/WfaquG8/4N/h1D7vkTub5kkrpAJsak5wPgYvXUKhdCd2/fdax1f
 2TGOKT973sJNVm7TvPR6WJkhUrHm+cgiQTXLVbb3UkkFlIMP99+y1v/L/h8+TDOygvgpnTjRVbM
 LtNOXa95nP0j6lMYsodNrLkhViLf/8WENiVAEdBg5nZXcbSoF8lriW129dKmd8ZYcWqrmAy5FKF
 9zPPiOfHXH8JVY7Oadg4PQU+NfIGRqpJkBcW/oZ/fYlgO51ms+dtZPfv1KrJT6pVpO8OIgii3XV
 2iHwvJwT8g0YfGP+TRkyJgcbu66Us1dw8R9xsv2E+8f8bwlLlDuxksYTxjry0xE4Fy9IZBKV7Fz
 piY
X-Received: by 2002:a05:600c:4ba8:b0:48a:563c:c8e2 with SMTP id
 5b1f17b1804b1-4909c092130mr446635e9.3.1779999910469; 
 Thu, 28 May 2026 13:25:10 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092a82ea2sm106621905e9.9.2026.05.28.13.25.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 May 2026 13:25:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/22] hw/tpm/tpm_tis_sysbus: defer resource allocation to
 realize
Date: Thu, 28 May 2026 22:22:48 +0200
Message-ID: <20260528202253.49122-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528202253.49122-1-philmd@linaro.org>
References: <20260528202253.49122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Mohammadfaiz Bawa <mbawa@redhat.com>

Calling memory_region_init_ram_device_ptr() and
memory_region_init_io() from tpm_tis_sysbus_initfn() crashes
when the device is introspected without being realized, because
the memory subsystem has not been initialized at that point.

So running:
  $ qemu-system-aarch64 -device tpm-tis-device,help

triggers qdev_device_help() which creates the device object
to list its properties, calling instance_init, but never
realizefn. The memory region calls in instance_init then hit
uninitialized subsystems:

With CONFIG_DEBUG_TCG:
  Assertion 'target_page.decided' failed. (physmem.c:2524)

Without CONFIG_DEBUG_TCG:
  Assertion 'mutex->initialized' failed. (qemu-thread-posix.c:107)

Since realizefn is only called when the device is actually
used in a running VM, moving resource allocation there avoids
the crash without breaking introspection.

Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260528093123.55403-1-mbawa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/tpm/tpm_tis_sysbus.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 6bec30c36fc..f9cd1c8b5c6 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -100,19 +100,9 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
-    size_t host_page_size = qemu_real_host_page_size();
-
-    memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
-                          s, "tpm-tis-mmio",
-                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
 
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
-    s->ppi.buf = qemu_memalign(host_page_size,
-                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
-    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
-                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
 }
 
@@ -120,6 +110,7 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
     TPMState *s = &sbdev->state;
+    const size_t host_page_size = qemu_real_host_page_size();
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -131,6 +122,13 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    s->ppi.buf = qemu_memalign(host_page_size,
+                               ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+    memory_region_init_io(&s->mmio, OBJECT(dev), &tpm_tis_memory_ops,
+                          s, "tpm-tis-mmio",
+                          TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
+    memory_region_init_ram_device_ptr(&s->ppi.ram, OBJECT(dev), "tpm-ppi",
+                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
     vmstate_register_ram(&s->ppi.ram, dev);
 }
 
-- 
2.53.0


