Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59E4C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raff5-0001JR-DB; Thu, 15 Feb 2024 12:36:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeN-00082F-Ba
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeH-0003yZ-Sa
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:54 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d066f8239so454849f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018548; x=1708623348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o3y6YUYAQdESHng1mrtNwKZAA53wIJnmasw8N4/0cpA=;
 b=pv+KMq3Kf5KlN70FTlTUDShhmpJRNZzLEgjurfVECZ63zH/Q8iNt0HD9gGkc/RN82J
 zFjC/kfWWC2XnyFV1fV3ZbFIWYUKSVm2ZK5jElevkmBwPgzgWvY2SCp085YjZtottgBf
 Oin/sEleWF0qXvgqW/Li6U0mt6Y/qtzG30A3GjWbNb2J6VVsOKMaDz3sRlWstBBcdqUb
 ryAYLiNrIfDFQPWo0GhyQXQ6N1lipxaWfUqpSpUScVI2yCFj0kSZtYCV0pZgulJh4PF8
 xcEwN4G2zcPVCihoISNCM22Id5vYh8pxdmMYjWzJR2btJoO9mzOdK0ZMLzqI9w1AvNuo
 QQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018548; x=1708623348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3y6YUYAQdESHng1mrtNwKZAA53wIJnmasw8N4/0cpA=;
 b=bcPWS0Ggp4io+86w1vLTXdBYJzNnmF1uW8tVaxec41zFVKe3yIjSCBuSXnNo/lImCE
 LA38coPvTKXpTIos64XYN4QOeuvnyWfzGIDa6wKEmmx9HHEzpkoFRxTKuQTSKLa4D94m
 uxBd3C5y7tU+7O9QnSBCRwCjUvM6ju8U23nc5ntnO/OHy60iFbE2Sw1yCD0T/g2kJTon
 DAvrzoqYkgpN85KSkGbTvlMzcWHtNsx7LT/b7uuMfdiKrPnf3xdlvr92XROG5CzQkRx3
 MknZtRn1zFAiKiKShiEG2bkmcTIigNHDaBUrCSd8huKSfDdcNBTEttOdQ5i6fafgxy1L
 bF4w==
X-Gm-Message-State: AOJu0YyFyeNGUr3ZzDUSMagY3A96kClVlXhnVN8PDb8OYf12hDunot66
 ppUjtk/DbPhXlYmsxo9KNgpoV6MFJJa3rp8Aj5vuddhFdke0plbnW78LdEbSbEq+OP8Ug5ro6sw
 Q
X-Google-Smtp-Source: AGHT+IHmf9i/hmJIbWn3eIIQ3st1bW3jb2ap5ahb1tuEVvOLY2ZQL3EX5BhjkDiDoxMBdcsNrsULHA==
X-Received: by 2002:a5d:5106:0:b0:33c:f574:3706 with SMTP id
 s6-20020a5d5106000000b0033cf5743706mr1864803wrt.63.1708018548354; 
 Thu, 15 Feb 2024 09:35:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/35] hw/arm/stellaris: Convert I2C controller to Resettable
 interface
Date: Thu, 15 Feb 2024 17:35:23 +0000
Message-Id: <20240215173538.2430599-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240213155214.13619-3-philmd@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 4fa857970b4..d3a12fe51c5 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -462,7 +462,10 @@ static void stellaris_sys_instance_init(Object *obj)
     s->sysclk = qdev_init_clock_out(DEVICE(s), "SYSCLK");
 }
 
-/* I2C controller.  */
+/*
+ * I2C controller.
+ * ??? For now we only implement the master interface.
+ */
 
 #define TYPE_STELLARIS_I2C "stellaris-i2c"
 OBJECT_DECLARE_SIMPLE_TYPE(stellaris_i2c_state, STELLARIS_I2C)
@@ -607,10 +610,17 @@ static void stellaris_i2c_write(void *opaque, hwaddr offset,
     stellaris_i2c_update(s);
 }
 
-static void stellaris_i2c_reset(stellaris_i2c_state *s)
+static void stellaris_i2c_reset_enter(Object *obj, ResetType type)
 {
+    stellaris_i2c_state *s = STELLARIS_I2C(obj);
+
     if (s->mcs & STELLARIS_I2C_MCS_BUSBSY)
         i2c_end_transfer(s->bus);
+}
+
+static void stellaris_i2c_reset_hold(Object *obj)
+{
+    stellaris_i2c_state *s = STELLARIS_I2C(obj);
 
     s->msa = 0;
     s->mcs = 0;
@@ -619,6 +629,12 @@ static void stellaris_i2c_reset(stellaris_i2c_state *s)
     s->mimr = 0;
     s->mris = 0;
     s->mcr = 0;
+}
+
+static void stellaris_i2c_reset_exit(Object *obj)
+{
+    stellaris_i2c_state *s = STELLARIS_I2C(obj);
+
     stellaris_i2c_update(s);
 }
 
@@ -658,8 +674,6 @@ static void stellaris_i2c_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &stellaris_i2c_ops, s,
                           "i2c", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    /* ??? For now we only implement the master interface.  */
-    stellaris_i2c_reset(s);
 }
 
 /* Analogue to Digital Converter.  This is only partially implemented,
@@ -1396,7 +1410,11 @@ type_init(stellaris_machine_init)
 static void stellaris_i2c_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.enter = stellaris_i2c_reset_enter;
+    rc->phases.hold = stellaris_i2c_reset_hold;
+    rc->phases.exit = stellaris_i2c_reset_exit;
     dc->vmsd = &vmstate_stellaris_i2c;
 }
 
-- 
2.34.1


