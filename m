Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDDDC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 11:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raw11-00070D-JR; Fri, 16 Feb 2024 06:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0x-0006qt-F4
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:21 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raw0q-00010T-7z
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 06:04:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4124c3a7a75so2534895e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708081448; x=1708686248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xmVGPYBQPq46VUwxkc77izpk+jGAawySTXLarOn7Kps=;
 b=Gm+E4p3yblgCXSJ42IVeSIMR18y1d+Lb6ZpMjvT+QCmcvRshvJmEhOoo/o4pDsY1wn
 r5yyv16wHznHhFfrLrYAYL9QXyGuJbnAN1m4MC8ErvoN1W3niZyV8HZoyUrg/QAFABwV
 SIrsJDUuNLIH2Mf8QAqzjAqiqPHZXxUG7iUUkDBojPXOeTBn5Qf4eJMDv8QcTiPGj158
 u7ASomjPDNp0vGuHBf+c5yRutxzp6T3JkznIHTJ9pR1L7XjYk3EafMkG9SazH7020DXH
 NFxId7bTp9RAvrslOlmaV/pYOGIm/RozmERAU/P074z03TTUeg2NGPEpsmuNK9ScK+KI
 J8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708081448; x=1708686248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmVGPYBQPq46VUwxkc77izpk+jGAawySTXLarOn7Kps=;
 b=ZLZk0NDrINRpk+jgeGIVGcGG398U2Cj5QtP3mEqhn8af/mNYSrAUmubAze2Rkxbk7T
 maw48PddTW2xAVwtKXTOMfecQUt1xcR5yvl0bhnnNme9R6r0X3GktE8GYW2EZ5X7U7BY
 GZ1rzCPOhN2fbD7HU9j+TbgU56hgCzrY3XH42wfA+DT+9bbZEZYx/Lb0GSfFPwmtjhzp
 jh1EhTfW7YQTYyE3BpC4wQQCG+0393AUEpss7IiW6odmDg7DIDTyPgIqUSZrMl3NAIXy
 twWrOnL9jF2zrgo+lF+oM29vGxFw7n+SGunXiCWEpFGqJsv1gGFvBu9erA+ZdKtGb97D
 ax+w==
X-Gm-Message-State: AOJu0YzUwVHnZ0dXxGpfiBNbFqaEazxALQLmYWj1J87+OuOkODVZAMNC
 IXL/I67shsYHnonbk81/ufdohzMu539lE9UgiVhzlzEWa46glOPhRbQspgBqs4QfLt440hEbfOO
 7
X-Google-Smtp-Source: AGHT+IFYc/i1Ir9pKLSmlGbNdjfSEBRBEzSq0hh1UBG+3WXRxLK5PeNmhQ2gadtoi1VjBbeun9m3xQ==
X-Received: by 2002:a05:600c:3ca6:b0:40f:c404:e2d1 with SMTP id
 bg38-20020a05600c3ca600b0040fc404e2d1mr3937401wmb.19.1708081448655; 
 Fri, 16 Feb 2024 03:04:08 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 s1-20020adff801000000b0033d01fe1f04sm1881745wrp.55.2024.02.16.03.04.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 03:04:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 08/21] hw/isa: Inline isa_try_new()
Date: Fri, 16 Feb 2024 12:02:59 +0100
Message-ID: <20240216110313.17039-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216110313.17039-1-philmd@linaro.org>
References: <20240216110313.17039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Inline the 2 single uses of isa_try_new().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/isa/isa.h        | 1 -
 include/hw/net/ne2000-isa.h | 2 +-
 hw/i386/pc.c                | 2 +-
 hw/isa/isa-bus.c            | 5 -----
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
index 40d6224a4e..8475120849 100644
--- a/include/hw/isa/isa.h
+++ b/include/hw/isa/isa.h
@@ -81,7 +81,6 @@ IsaDma *isa_bus_get_dma(ISABus *bus, int nchan);
  */
 qemu_irq isa_bus_get_irq(ISABus *bus, unsigned irqnum);
 ISADevice *isa_new(const char *name);
-ISADevice *isa_try_new(const char *name);
 bool isa_realize_and_unref(ISADevice *dev, ISABus *bus, Error **errp);
 ISADevice *isa_create_simple(ISABus *bus, const char *name);
 
diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index 73bae10ad1..2440ac8621 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -22,7 +22,7 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
 {
     ISADevice *d;
 
-    d = isa_try_new(TYPE_ISA_NE2000);
+    d = ISA_DEVICE(qdev_try_new(TYPE_ISA_NE2000));
     if (d) {
         DeviceState *dev = DEVICE(d);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3c00a87317..e8130774ad 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1183,7 +1183,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     i8042 = isa_create_simple(isa_bus, TYPE_I8042);
     if (!no_vmport) {
         isa_create_simple(isa_bus, TYPE_VMPORT);
-        vmmouse = isa_try_new("vmmouse");
+        vmmouse = ISA_DEVICE(qdev_try_new("vmmouse"));
     } else {
         vmmouse = NULL;
     }
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index f1e0f14007..8aaf44a3ef 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -158,11 +158,6 @@ ISADevice *isa_new(const char *name)
     return ISA_DEVICE(qdev_new(name));
 }
 
-ISADevice *isa_try_new(const char *name)
-{
-    return ISA_DEVICE(qdev_try_new(name));
-}
-
 ISADevice *isa_create_simple(ISABus *bus, const char *name)
 {
     ISADevice *dev;
-- 
2.41.0


