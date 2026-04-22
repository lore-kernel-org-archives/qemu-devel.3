Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD0EFA1FEC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdkY-0007BC-TK; Wed, 22 Apr 2026 16:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkP-0006gM-Ro
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:36 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdkM-0001vN-GB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:00:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so75000065e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888023; x=1777492823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JH1RhoT67ixQCInyH6yG0/xCY2TR3evf5THZqvNeLuI=;
 b=WGUlIyNkGUPMzAgGA8R33oZWiNtH+4IoTjF3FBt2PqkVeplx/bWQ8X53R1zO1yf6wI
 1VY3aiQjhudGFbZ9P8h+u8eD9qX0mDOFFv3eloT7NXklREIGyGCOgbF6RqFoGxLdXvDC
 Xg9O+gqo8MtPAvpVJfDxfQh5CzrmXV3tx1+M2YqP+2826pC7pNtANMhd+1jxEBp/2R45
 xmMdP4Ca6Pd8fCC99JhGadp56qgzBZKiimY5JQegJYo1iuNixe6iWB+fI8XE/sdkgm4y
 x5BCLYCR68znj9aaujsX0q+/ZnqerHRpZJnsJetFaco1hXfB5f2b6UrxtlN6f3FYMQbD
 rzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888023; x=1777492823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JH1RhoT67ixQCInyH6yG0/xCY2TR3evf5THZqvNeLuI=;
 b=iJaszDscwOBbSOFfDKSKLasOsAwfebNF2Kb/6Luu7jZALHgwO+LdSvIc+Gq7Uc6pGD
 WuIwDiaKUidi7FDeqFLhpZlzjs13jOz4NZ9untdnhsG0U9JsTmgprtwrbtUotTvDTth1
 sgnh6fQJM//bPOUzC+dARAO2+2apvuH9uN0EVPS9FMArvSw63NJkBBJDIDdrTTTA3tA9
 04pQE5rAg4gXPRfnTDYA62u7UcfKbvW8OSwDbp63IOEjyZj/mLi78PQj8PCotlqzQV5/
 o73GKAni43B+Ft8kFHyMBZKvjovVgvLjCmbpuSaszCTF+a1W8VewcTKLMjqBE+uLK832
 fAtA==
X-Gm-Message-State: AOJu0YzfKm+nSKH1pcKolqJiKN45Uw+G7jMPdTKkFSY81Kl0KXYpLmjM
 F/4vgEW5cuVKcNJrWNPhMtEYslMHYd5lBUztmAzLeBTUeLknn01WZ09yoTR4dwuO/brwXgH7PIX
 WuVpa/mw=
X-Gm-Gg: AeBDiesN9PI3Tp/4ZfrkNg767w8Y/999SROkfF21KIYY+PL+2yeDkL/CROFMkp34UPb
 h166rVD6IofdeGyj2EzzHBoYLLz8VYcayLOOFp+EzQH117IUIc3vukkYJqCJsIUI0kS1GiS00gE
 /oP5EVfQro7DNedmcZ+MCEh9tKlsFPc1Aip/QKCKPCHhgDiu6ALsOezRDom87k8njpTbVYQYpoJ
 1j43Ceyt/8OQKLGEwyrodLyIftL/MypvQN2PwcN9MYj5ni3ldoYzVE1VN0HPvJUx+30/6Yy2Wjt
 7CtkCcKoa8cSAM+Rnue8v17qynC5Qgo7FMvQpoo2xtPC+jmibiOT+mQOhY4/cJG2zdV+fiFzIVy
 T14+Mi38nuedMOItzfHMUw8vKAEj3ki1IrgU7I9tTWvkPPmxEpBnz0RVjmSkshX0Np6ZMTvJlbZ
 uPzje3HNPOX038hzru0gRNzybFzBlRSE9krTB00aVZT0FIKlkgnPmIY2+nsH3UXCE6C7dfiyx65
 f7J2OvnZ5g=
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id
 5b1f17b1804b1-48a56d5179amr116684295e9.7.1776888023054; 
 Wed, 22 Apr 2026 13:00:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc18bccfsm425786435e9.8.2026.04.22.13.00.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:00:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/48] hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and
 remove in TPMState
Date: Wed, 22 Apr 2026 21:57:20 +0200
Message-ID: <20260422195746.88865-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
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

Of the TPM devices using FIFO mode, only the ISA variant has
PPI, and calls tpm_ppi_init() to initialize the PPI state.
Propagate @ppi_enabled to tpm_tis_reset() so it only resets
the PPI part when requested (ISA case) otherwise the PPI is in
uninitialized state. Remove the now unused TPMState::ppi_enabled
field. Set the generic TPMIfClass::ppi_enabled so ACPI subsystem
can keep checking its availability.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Message-Id: <20260317120241.16320-5-philmd@linaro.org>
---
 hw/tpm/tpm_tis.h        |  3 +--
 hw/tpm/tpm_tis_common.c |  4 ++--
 hw/tpm/tpm_tis_i2c.c    |  2 +-
 hw/tpm/tpm_tis_isa.c    | 10 ++++------
 hw/tpm/tpm_tis_sysbus.c |  2 +-
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 184632ff66b..1531620bf9d 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -75,7 +75,6 @@ typedef struct TPMState {
 
     size_t be_buffer_size;
 
-    bool ppi_enabled;
     TPMPPI ppi;
 } TPMState;
 
@@ -83,7 +82,7 @@ extern const VMStateDescription vmstate_locty;
 extern const MemoryRegionOps tpm_tis_memory_ops;
 
 int tpm_tis_pre_save(TPMState *s);
-void tpm_tis_reset(TPMState *s);
+void tpm_tis_reset(TPMState *s, bool ppi_enabled);
 enum TPMVersion tpm_tis_get_tpm_version(TPMState *s);
 void tpm_tis_request_completed(TPMState *s, int ret);
 uint32_t tpm_tis_read_data(TPMState *s, hwaddr addr, unsigned size);
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index f594b15b8ab..a134d5c2059 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -813,7 +813,7 @@ enum TPMVersion tpm_tis_get_tpm_version(TPMState *s)
  * This function is called when the machine starts, resets or due to
  * S3 resume.
  */
-void tpm_tis_reset(TPMState *s)
+void tpm_tis_reset(TPMState *s, bool ppi_enabled)
 {
     int c;
 
@@ -821,7 +821,7 @@ void tpm_tis_reset(TPMState *s)
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_TIS_BUFFER_MAX);
 
-    if (s->ppi_enabled) {
+    if (ppi_enabled) {
         tpm_ppi_reset(&s->ppi);
     }
     tpm_backend_reset(s->be_driver);
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 9f13e0ec120..b4f258c7bcb 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -523,7 +523,7 @@ static void tpm_tis_i2c_reset(DeviceState *dev)
     i2cst->csum_enable = 0;
     i2cst->loc_sel = 0x00;
 
-    return tpm_tis_reset(s);
+    return tpm_tis_reset(s, false);
 }
 
 static void tpm_tis_i2c_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 61e95434f5b..1ca403241de 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -88,13 +88,12 @@ static void tpm_tis_isa_reset(DeviceState *dev)
     TPMStateISA *isadev = TPM_TIS_ISA(dev);
     TPMState *s = &isadev->state;
 
-    return tpm_tis_reset(s);
+    return tpm_tis_reset(s, true);
 }
 
 static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
-    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
 };
 
 static void tpm_tis_isa_initfn(Object *obj)
@@ -132,10 +131,8 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
-                     TPM_PPI_ADDR_BASE, OBJECT(dev));
-    }
+    tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                 TPM_PPI_ADDR_BASE, OBJECT(dev));
 }
 
 static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -175,6 +172,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, tpm_tis_isa_properties);
     dc->vmsd  = &vmstate_tpm_tis_isa;
     tc->model = TPM_MODEL_TPM_TIS;
+    tc->ppi_enabled = true;
     dc->realize = tpm_tis_isa_realizefn;
     device_class_set_legacy_reset(dc, tpm_tis_isa_reset);
     tc->request_completed = tpm_tis_isa_request_completed;
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index e9372e73163..dd30344d5ac 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -87,7 +87,7 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
     TPMState *s = &sbdev->state;
 
-    return tpm_tis_reset(s);
+    return tpm_tis_reset(s, false);
 }
 
 static const Property tpm_tis_sysbus_properties[] = {
-- 
2.53.0


