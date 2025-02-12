Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD7CC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 21:33:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiKMC-0002ym-Gs; Wed, 12 Feb 2025 16:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKM0-0002wN-58
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:09 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiKLx-0000Ti-JW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 16:33:07 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso1281105e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 13:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739395983; x=1740000783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R12M5ZnGbHACUNdYXBDvzARNitejWg7AX1PjTOT2rHs=;
 b=h5BOvduIUabF0YmI1kdFtUdUX2u1q/FKSKoHBg1avQb1wutbXYTFLiHgdGlOxOdVhp
 Nm40KLbz/lOtUW4buhS6J33ySoI56C66R7yG1NypNuJfFHwrep0KDWbHMLwQNjLKBNzR
 Su3YylQUM8SKflp6gwW6Dr8a0FHLZGjoOZKUa4g26xguQVcCkZE0ZzZPFCwdlSyMhnUU
 vqV8tu+i6Exbj8lGyl4sYQGPst0VnPSlvXKuGEqkVyOYJa9Uuf4VNr1iY9o43/gTaBeq
 wYr0ky/YKq6btPcW+SndMIQ90gWCHNIYpnpxXjFrxY8Q7iMMj3q/h07GkhW19jczdk/n
 Ei3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739395983; x=1740000783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R12M5ZnGbHACUNdYXBDvzARNitejWg7AX1PjTOT2rHs=;
 b=Cg+0OczlG1A25d7z29FvIG8cd4RfSKlSPC+cIKzdjXawR7hrwuBDp/fMzBO/8g2o3V
 lOZU4yOvG4I2FhzQpMnRYsF8PBzobZUejGOytn7Z5VM5BxBlKontyCXZlN+aD8lBPxP0
 76dzPXei1O3oJGg1wlX++om6Y9q140PmdSiuLSnsgpDCwKbU/eoRfAtjYKfaBvMv2ZVB
 ZQd4d/6D/6ANfiWgotXMYLVuShsTIcV1SAvBUowcHYxRnHsyovFjxB7u3vJKA2syd5S1
 YXoK1TBl8fPVITQHzVRCFMhUWAPcVH3QNb9RA1aadaT4vHzyrbwfArO9w4/ePc8n4AMk
 GZZQ==
X-Gm-Message-State: AOJu0YyB0eRBrUfMlYSbzExHgKMgPnEH8cpzVJyR38DXrIhYzjsiB2LI
 QfaYdqpCIIX6pgz7lAHdrPlvR4g1ND/QqflDGpKdo+MmZGC8GMAWnoDst1W2aj17F26lWI3GYYW
 4Cmk=
X-Gm-Gg: ASbGncssXNGpecMbxHW9Gkak6h+gavj7eqYHExx7CnDAGfCN1zy0yZe1AttEQ1PzoJN
 6TnNaFT92ZIunJWgRy9y85SEwf0qYQc+kQzxHjCflqhRIcl9X57MdKCfSZ3y+TmKnnS7vECpfCw
 8psudolttMw2aOcVb+Pw0NjFF440Emj3JndYoEmUm8jZ7XM+cuvK/yJPJ1W0BkMPQ/3KFZYFLMU
 mzKayN6B3dKqdxnMnGjZOJeEwuNV+jq6fYXvKJWkQcFOpPQaCcQRjwFNw7w5/ee09pJ4PdobzoA
 FsSxUA4oIQ5Ah6xk4ikukcwWUgigOm+NvzKbGppaxR9jKXoazGLor/O4Os4aihpZbg==
X-Google-Smtp-Source: AGHT+IHgUN4CZXfWbbrkjCjUMr5kAJGJfenS6riFNkGXKOUmBTQyflTDuhnzvLcgjs/r1pkynKgeUg==
X-Received: by 2002:a05:600c:3110:b0:439:35d2:ed2 with SMTP id
 5b1f17b1804b1-4395815f593mr46889855e9.2.1739395982803; 
 Wed, 12 Feb 2025 13:33:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a07867esm30728535e9.36.2025.02.12.13.33.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 13:33:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/19] hw: Make class data 'const'
Date: Wed, 12 Feb 2025 22:32:32 +0100
Message-ID: <20250212213249.45574-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212213249.45574-1-philmd@linaro.org>
References: <20250212213249.45574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

When the %data argument is not modified, we can declare it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sd/sdhci-internal.h   | 2 +-
 hw/sd/sdhci.c            | 2 +-
 hw/sensor/emc141x.c      | 2 +-
 hw/sensor/isl_pmbus_vr.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 5f3765f12d2..9f768c418e0 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -322,6 +322,6 @@ void sdhci_initfn(SDHCIState *s);
 void sdhci_uninitfn(SDHCIState *s);
 void sdhci_common_realize(SDHCIState *s, Error **errp);
 void sdhci_common_unrealize(SDHCIState *s);
-void sdhci_common_class_init(ObjectClass *klass, void *data);
+void sdhci_common_class_init(ObjectClass *klass, const void *data);
 
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 99dd4a4e952..1f45a77566c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1542,7 +1542,7 @@ const VMStateDescription sdhci_vmstate = {
     },
 };
 
-void sdhci_common_class_init(ObjectClass *klass, void *data)
+void sdhci_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index aeccd2a3c94..33c1bd330fd 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -265,7 +265,7 @@ static void emc141x_initfn(Object *obj)
                         emc141x_set_temperature, NULL, NULL);
 }
 
-static void emc141x_class_init(ObjectClass *klass, void *data)
+static void emc141x_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index 304a66ea8b0..c60282cfe77 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -233,7 +233,7 @@ static void raa228000_init(Object *obj)
     isl_pmbus_vr_add_props(obj, flags, 1);
 }
 
-static void isl_pmbus_vr_class_init(ObjectClass *klass, void *data,
+static void isl_pmbus_vr_class_init(ObjectClass *klass, const void *data,
                                     uint8_t pages)
 {
     PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
-- 
2.47.1


