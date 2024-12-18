Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B17BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuL1-0001yp-EI; Wed, 18 Dec 2024 08:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKV-0001Js-Nb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:12 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKT-0005fQ-8A
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:11 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3ea55a2a38bso3416213b6e.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529388; x=1735134188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2d/hWrSxehZt7xGreBWrCDPh5wzby7jHdOMpyWXISQ=;
 b=Y77KG8NXj0UuBsraKhbGihhWgCnl7NE+mj+1Mxlt7ngpNk2NFEImZIefWcOS/lsROn
 k4Hd8iiAUtSkYy5VI6jF8hHcUktklxBS5tdwtHjRzMXkZv6qAGy8ni465Cyra9zTDW4+
 eCWfCRTLMdODPAFdLNpo2bB9jl4ePHtUi/T9WJ6Y4gVFmL2/3jIp+qAmuE5ngf548hpM
 sjI5HxsaXXYdheCorZDcxfGkh+Z0T2397ctaVyPeu/RJdx0ykY3JNKvVJlU4GiLRJgtc
 HJpGKYefrf0ItxcMtpdKjF8uFKT5jJCJg3cU8jJ6cmEu93THFvQ9dLzuVqvLlAmqaKN7
 sSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529388; x=1735134188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2d/hWrSxehZt7xGreBWrCDPh5wzby7jHdOMpyWXISQ=;
 b=qMANxUXt4ceO1FtK8GwG77VHlN+Mc8OmpXrODwibPoB/bSfv9ZKwhCaz4TItYnumSn
 QCfRwtYi+/7NlrTBvqMrYXNjgkbQK07j3fmVmIC9/6XUgH3imC61lzrE6LuBOv2eMIxl
 xA7QPf/dOoNOHwZGGjrLPVCH18CAn49kCLa/jASjdOzAo5LUKA3I9p24SaCcqp8C37qf
 iNXOh4uO74dbj8hIljJLETRQIs44HoGXdKcFXuI2jUQuPOV3J0JtOQGI0kggdslRlkuq
 br2bGQmC4jHCbSVEKxAur3Ygsd5wmFC5KQSYXJGKlxzU7k/rt0Z523K6VeFV/jGoZUw1
 H7Iw==
X-Gm-Message-State: AOJu0YzIrEUsVfUpa3a8hBc+dQxya3ifdzk37uZLkvGEE8hhriR2x13Y
 Rk+872BXlHVs7eYbuQCnc6TWHKgCy0+6FSzKMfzRUPHwHBn6DuDl0J094yuUArQCXRBPxWgaIVC
 wFrrvJ1wy
X-Gm-Gg: ASbGncvh+aYJ67yhoR5V1lbSMUEByfecFhaTw9ecFaLpsWdz91Qx8vNhU+fb96A88Nz
 yGnlsCeRA5yYpnM/ahyAKRLb8StE4rdPoNH9hsh29Oeof/rO5NFcaR6o3Lej9IsA+Bb264z6ZYZ
 caGNPYmrqpMCb8/xBkQ/OWzmE0qpWXYjAc3CBBz5LI5KzvzZy6JjE0eK7SCjhP8Z3BWxnLSu8p9
 O9vM6WKX3Pz4tYtT5CXGaMlNS1KFlv73XFOIFQzhGUSPQftudTSAC/PyOfKRP2b
X-Google-Smtp-Source: AGHT+IGlen/OQSN86P6aUq0X2LC4OxKkwrM30aM5oQJHbDJAqrXolCPYBdNruo9MXAa9mYFPR0Whag==
X-Received: by 2002:a05:6808:3b5:b0:3eb:58b5:8614 with SMTP id
 5614622812f47-3eccc1b64e5mr1405527b6e.29.1734529388027; 
 Wed, 18 Dec 2024 05:43:08 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 10/24] hw/sparc: Remove empty Property lists
Date: Wed, 18 Dec 2024 07:42:37 -0600
Message-ID: <20241218134251.4724-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sparc/sun4m.c   | 5 -----
 hw/sparc64/sun4u.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index d52e6a7213..7ec346533e 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -732,15 +732,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
-    {/* end of property list */},
-};
-
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 7088ac273e..05b8c7369e 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -471,15 +471,10 @@ static void prom_realize(DeviceState *ds, Error **errp)
     sysbus_init_mmio(dev, &s->prom);
 }
 
-static Property prom_properties[] = {
-    {/* end of property list */},
-};
-
 static void prom_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    device_class_set_props(dc, prom_properties);
     dc->realize = prom_realize;
 }
 
-- 
2.43.0


