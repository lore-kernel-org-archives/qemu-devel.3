Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958DDC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 13:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaDub-0005RK-2t; Fri, 11 Jul 2025 09:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtm-0004P6-PD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:47 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaDtk-000312-N8
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 09:34:46 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-453643020bdso16147595e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752240883; x=1752845683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zCEHngMuEKAJlSIQienwre2JI7I+N6ggKt6meJEzMfI=;
 b=EnT1zqo+5WWz9UmA2/Ns/dhG0yWBcxC+t0f3NiAugqFRwQi/6TUDvKBCBsl8kinWID
 VE6EgIS3nvqpKKm9FjY0FOnbLm+HyOcGWzXzrT6ELFM0NP7UvF+BR4RLS8lt5EGulYS4
 akVLQtiWSZXnnnFBEseq5c5TyK2BNdlllQrd4WnTipzHLTcC8NG1XfXEse9Q5WHopnUS
 gFAUZKf7arXVffXMr75OlnCOV8UUtj47KyNkOJWw/AunkRvLPZDET/7zlxmyvAWejAru
 uPbZLlvi3+VmjdoGHT8GEDOajTe8lL/VF3fHm//7tIgzHOtnYExoBP/vwiPfY0nBbTad
 uCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752240883; x=1752845683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCEHngMuEKAJlSIQienwre2JI7I+N6ggKt6meJEzMfI=;
 b=SvIgmNA3SlNWs2Yn764c7gF11GzrWBAsk5kquEkkWWzcRMOLMF8da+Z+rsyXV3zLUe
 P3Octqu0J9jPulW4c+J9YjIvspRLahcJlCq+GKYZNa8Jief2ut/YAZILqIKbmb0jojKB
 WSnXXJEkjBvGWshwX2mnEmt61VlgOFc1W0b9u3mp/a8Txl7MtngeU9cxbfIFmeOZscon
 3m+7s9t9d4G7GsDTKA2OjPP9KJ8AqWfmcHe5zcsCTD1QYE7Bzt//MikyH6SRPlaiXfUW
 jaN7WW4PRVUgiqMHpcjFqKAc6epyxCZJPKdEUY6aUCt0oiEe+DI4FoTTK4B7XmLU8FbU
 RWeA==
X-Gm-Message-State: AOJu0YxAvPRvJi/HfWxZPinqGlqEZMf8oK+q/4FpUnTrbx3VoKWRyPpE
 eAODiFzd6Xhb6C0UVjOgyVkplcMv3CVNYmd4ow4ySVZeD//ID/pYP522AkbJRYBsTnm3tvshZOi
 2rMpZ
X-Gm-Gg: ASbGnctdCMvAAks77mcZg96oDBm5n/fC11b7CJM7oknGPlnAlgWLrD7MhAiqrHWmqxT
 EAAOf7QDnc6NPJx7VFMWuw5V7/d6PIWECzZW9YlTeRRox01VKXQsbxK+JgldroXNy8fpCFjejh2
 1RgatKCgGb1ry4sFrFHb62E4xnLq8q7d3+oF5pgCzk0nkoEB2FjoSLHw5sFJgrP5pwrqwo4Hfh+
 C2LhkDFNLT738217LDeCiNt7u5CMA2wv4dFFooe+5E6uKq29k0wsfASF2DMgLv0fyF6Pxzy9Pt9
 g/gujsYCbKG2ukPYRkiDLPsjO6PLSjKDyL8gLs6wcbsOa7DqJYASPlreWfaGE6+dpr3NXuT+IZZ
 luKjHWviFeNjRHDgwtmnQ2WtBgiDY
X-Google-Smtp-Source: AGHT+IFw9iz8Ys08C1N3M3LAAbJ7jMt/1HR0hixOL0zF87fHcXhqrVQtz9roarpJ5GgIDNZBbZbSkQ==
X-Received: by 2002:a05:600c:628e:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-454f42814bamr29962765e9.11.1752240883231; 
 Fri, 11 Jul 2025 06:34:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d50df0cdsm89734145e9.25.2025.07.11.06.34.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 06:34:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/36] MAX78000: Add AES to SOC
Date: Fri, 11 Jul 2025 14:34:04 +0100
Message-ID: <20250711133429.1423030-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711133429.1423030-1-peter.maydell@linaro.org>
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
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

From: Jackson Donaldson <jackson88044@gmail.com>

This commit adds AES to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704223239.248781-12-jcksn@duck.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/max78000_soc.h |  2 ++
 hw/arm/max78000_soc.c         | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 528598cfcbe..a203079ee9a 100644
--- a/include/hw/arm/max78000_soc.h
+++ b/include/hw/arm/max78000_soc.h
@@ -11,6 +11,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/arm/armv7m.h"
+#include "hw/misc/max78000_aes.h"
 #include "hw/misc/max78000_gcr.h"
 #include "hw/misc/max78000_icc.h"
 #include "hw/char/max78000_uart.h"
@@ -41,6 +42,7 @@ struct MAX78000State {
     Max78000IccState icc[MAX78000_NUM_ICC];
     Max78000UartState uart[MAX78000_NUM_UART];
     Max78000TrngState trng;
+    Max78000AesState aes;
 
     Clock *sysclk;
 };
diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 3f2069fb039..7f1856f5ba1 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -45,6 +45,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
 
+    object_initialize_child(obj, "aes", &s->aes, TYPE_MAX78000_AES);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -133,6 +135,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
 
     object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
 
+    dev = DEVICE(&s->aes);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40007400);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 5));
+
+    object_property_set_link(OBJECT(gcrdev), "aes", OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -148,9 +157,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("powerSequencer",       0x40006800, 0x400);
     create_unimplemented_device("miscControl",          0x40006c00, 0x400);
 
-    create_unimplemented_device("aes",                  0x40007400, 0x400);
-    create_unimplemented_device("aesKey",               0x40007800, 0x400);
-
     create_unimplemented_device("gpio0",                0x40008000, 0x1000);
     create_unimplemented_device("gpio1",                0x40009000, 0x1000);
 
-- 
2.43.0


