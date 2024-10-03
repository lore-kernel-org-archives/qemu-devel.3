Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F3CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMGo-0002FU-L8; Thu, 03 Oct 2024 09:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMGm-0002F4-U1
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:53:29 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMGl-0001OA-4m
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:53:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37cc84c12c2so586920f8f.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727963605; x=1728568405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y21cd3Mlo1rSCOVF7OXO2uYDEWo70U3Lo9wLvPMq9f4=;
 b=txncFebg1qj+oesfbUlI0JoYhm0n5B4gjSdzdsK94OYpfeKX+KYHBwLAs0/5c0nV67
 wRdP8iySPCG7CeTINf5drHTZGJV9KLgao98+lOHI7jRoMycMIZ/4I6nfqlkNZVlWDNVC
 Pxn0sakdu98GuEj0KuVHCBm6DxGWWf1Hw3OeiO6sPtZHbSb5BcP8GGP6HCIgLLtnUewH
 03m5G2gScPJPUYw/n5xsDoG83Yo9+jzApP9ok5dh3d24Z3o0M/Pi+WM4QncA2RGsrbb9
 JbTCYwrCiNm47tMRF/ZZqblCaUSt+vUDDikc2z7fDTwahrn3y/x0C3wl3cH05bj/TiVG
 26OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727963605; x=1728568405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y21cd3Mlo1rSCOVF7OXO2uYDEWo70U3Lo9wLvPMq9f4=;
 b=l2pxvyVON3Cvzhi1Oy3Un7yEbvRTzOPGg6qBjzyp6cTnZCXcJLlBph+Iur3tJ+ATE2
 ZtsyOdiPBsmXA3HKgk5qMjJf4iCfVaCX7IZ7F8mjSD1FFvp41RHhK3GZHon3W4pENPUP
 rSxQlzgxU+lIlDn/332w1fxdwG8NEeLw7qVYo6i4qWIfoBy2iva/kLhmWHMO3rUTuv8o
 dpFe64kTquhmh5/hNhbSFdHuHl0AgcJE6l/AP9zXOa/a23hNTcJrqDv5rQRBtSarzd02
 1pYEMatKhvWqfRsjCEWO1tMm+gIGrrZKEcbZpf1Cx237daeow4oNNaj4mVifKNnmHIdH
 a+LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmLAfrBiGiqlCyLNst08R059lpL5YAGTlQiywdXC6izhqZg9hy8yFjz31SROjNnpY4TSKJv8SjKd6H@nongnu.org
X-Gm-Message-State: AOJu0YweFX2FlpuImAk4FqZFjub+u9GjT/Xg1Ff8Pi3pyMFIxtLtrJK9
 raG8/VkMIhOTj7kuKjdRAwYclTixqZmgEEUkJHaMexSPq8CsdURGi2w8yzUJPwo=
X-Google-Smtp-Source: AGHT+IHnqWKjWbo5b+j9jDs4mN7w7RaWF524s4MIPe7zWeGir3cfLdK8/BoDorLpMxXhBznzpdW+xg==
X-Received: by 2002:a05:6000:18a6:b0:36b:bb84:33e2 with SMTP id
 ffacd0b85a97d-37cfb9f9d0fmr4570817f8f.37.1727963605227; 
 Thu, 03 Oct 2024 06:53:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ead8d8sm45285905e9.19.2024.10.03.06.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:53:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/intc/omap_intc: Remove now-unnecessary abstract base class
Date: Thu,  3 Oct 2024 14:53:23 +0100
Message-Id: <20241003135323.1653230-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

The OMAP interrupt controller code used to have an omap-intc
class and an omap2-intc class, which shared common code via
the abstract class common-omap-intc. Now we have deleted
omap2-intc, we don't need the separate abstract base class;
fold int into omap-intc.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/omap.h |  2 +-
 hw/intc/omap_intc.c   | 13 +++----------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index cf5f0219a2f..4d28f391fb4 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -59,7 +59,7 @@ int64_t omap_clk_getrate(omap_clk clk);
 void omap_clk_reparent(omap_clk clk, omap_clk parent);
 
 /* omap_intc.c */
-#define TYPE_OMAP_INTC "common-omap-intc"
+#define TYPE_OMAP_INTC "omap-intc"
 typedef struct OMAPIntcState OMAPIntcState;
 DECLARE_INSTANCE_CHECKER(OMAPIntcState, OMAP_INTC, TYPE_OMAP_INTC)
 
diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
index a48e6fcd6d3..a98358d92e2 100644
--- a/hw/intc/omap_intc.c
+++ b/hw/intc/omap_intc.c
@@ -392,22 +392,15 @@ static void omap_intc_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo omap_intc_info = {
-    .name          = "omap-intc",
-    .parent        = TYPE_OMAP_INTC,
+    .name          = TYPE_OMAP_INTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(OMAPIntcState),
     .instance_init = omap_intc_init,
     .class_init    = omap_intc_class_init,
 };
 
-static const TypeInfo omap_intc_type_info = {
-    .name          = TYPE_OMAP_INTC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(OMAPIntcState),
-    .abstract      = true,
-};
-
 static void omap_intc_register_types(void)
 {
-    type_register_static(&omap_intc_type_info);
     type_register_static(&omap_intc_info);
 }
 
-- 
2.34.1


