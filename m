Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC1EC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 12:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd8cC-00066D-6e; Thu, 22 Feb 2024 07:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8bw-000607-Px
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:39 -0500
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rd8bu-0004mm-27
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 07:55:36 -0500
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-512bce554a5so5254872e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 04:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708606532; x=1709211332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NITcCbTrMmjEc1uhZkNKiyfNNYFXJBPxx+OU8JE8tD0=;
 b=NiPFoOWxhJ0SaA3o8YgxJRYJ/wOrTw4etA1Vu+yYed4+zNwk8oOD9uWzpBvfTpSukJ
 QmJADSLv7mBNCMeyKN9Mi1AQQXlUpOubhNEDIxTj3grzxOdvk/h7rj9Zy+KhFegUrpTN
 4zl9NtKGbTXUUZEJ5f+yp/4L7h2TkbwvZmYoVhnXjX346grm76ntgIZF1kzzgLqJ62aE
 vWv/cA2qgvcyK//udiucbKpwc6sHLyKPju9fJj3rgF2c6Z39tiPxCqPLcFcbfi+b5u6k
 MOSna1OM2yG+JpeJhK23MwNXwUBtZIRJn/QtXc0OddVA0bGODYSqMC3NE4SM8dxy8ah+
 V0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708606532; x=1709211332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NITcCbTrMmjEc1uhZkNKiyfNNYFXJBPxx+OU8JE8tD0=;
 b=xL5zgXo1voAnxpAEurYsExbGmhVal+pQWpqL8f1xKMi92sRQGCRSAE43fp6U2mlV/i
 2253glNf1la3VH3XUOKIaxeO0yW0EHee8ZuuHjBtSAeiZKlUrxjQec034P1LawM6l1Qg
 SXMyWYm7kvJkZAybVJsU2B81o9tA3bKE0hbV8zE6IPXbUSpfEL6BVqFf0JJLhnsatCSL
 eSYc/Vvgd1mWBPj0VGh156jezWR7PolI5kToLwP+65KLTv0O8STXLItoANEK8xrynA98
 y5VPUel9Z3L7TgEdrCjTfqGCZYI4+/esVkfbMFXPkEqCavjRYnHv73dJcgvxGNAVxJvr
 bKsA==
X-Gm-Message-State: AOJu0YwEi7ci3Vnf+d7HBdS2zRd2EwQSCV5OSrLwnDJfQ0rW3NW34uHe
 /HpkycEiZgDksDI96PsphIdCRJ2IGw0QGlI9djxWiia7tXyOssReZ6xG3hqFnC85huka1B78WtP
 8JpY=
X-Google-Smtp-Source: AGHT+IHG+QRNzC8oqAzjDLjQuu1znhnWrUgxWO2it9ATLBa3XdjZNcwQ+ENk0FrHOaWEl0PsHCZbvA==
X-Received: by 2002:a19:650c:0:b0:512:a5c6:499c with SMTP id
 z12-20020a19650c000000b00512a5c6499cmr9291184lfb.12.1708606531957; 
 Thu, 22 Feb 2024 04:55:31 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c358100b0040fccf7e8easm6348704wmq.36.2024.02.22.04.55.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Feb 2024 04:55:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 08/32] hw/ppc/pnv_bmc: Use qdev_new() instead of QOM API
Date: Thu, 22 Feb 2024 13:55:10 +0100
Message-ID: <20240222125517.67131-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240222125517.67131-1-philmd@linaro.org>
References: <20240222125517.67131-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Prefer QDev API for QDev objects, avoid the underlying QOM layer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20240216110313.17039-6-philmd@linaro.org>
---
 hw/ppc/pnv_bmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 99f1e8d7f9..0c1274df21 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -269,13 +269,13 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
  */
 IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
 {
-    Object *obj;
+    DeviceState *dev;
 
-    obj = object_new(TYPE_IPMI_BMC_SIMULATOR);
-    qdev_realize(DEVICE(obj), NULL, &error_fatal);
-    pnv_bmc_set_pnor(IPMI_BMC(obj), pnor);
+    dev = qdev_new(TYPE_IPMI_BMC_SIMULATOR);
+    qdev_realize(dev, NULL, &error_fatal);
+    pnv_bmc_set_pnor(IPMI_BMC(dev), pnor);
 
-    return IPMI_BMC(obj);
+    return IPMI_BMC(dev);
 }
 
 typedef struct ForeachArgs {
-- 
2.41.0


