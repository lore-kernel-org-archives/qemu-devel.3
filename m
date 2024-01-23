Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A67C47DDB
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPZy-00075Z-Hn; Tue, 23 Jan 2024 17:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZw-00073h-93
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:49:13 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPZs-0004NA-1d
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:49:12 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e800461baso57950015e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706050146; x=1706654946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbNjV/GRSEnvliPT0ZyleNqMAmiv0RWp/+WjhZ6DISw=;
 b=Wpwg7gCs1cH3Z7ff+0S09PwC9olTubUQFd81UOBYj3NRXI8hH0/bbZzuYXANXOEGZu
 QRCRYaVRZ8Mm0+ZFU6oCd84n70XgJ2QG5RhqPbamDtJ3daTX60D+giO7o+1mOyqHgVLz
 VBDOC1WfSWeS03p4154uHU8wYGH9QrWAG3nouyAe159xMvQo7pRMXo+2kXt3aRNbOavJ
 9EgSbbFv+MxuA6PAtKWqnV+SjXqMMGHFA8PPB7AXqgjUXkF0hZTOUpBPVcqnDJjs3U5w
 cvQgKvZkg68ZSQ21lEMpW46GpxDnn5dzaZisV310fXp5nwA2oQleKNa8l9QB03Lm/tW3
 A9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706050146; x=1706654946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbNjV/GRSEnvliPT0ZyleNqMAmiv0RWp/+WjhZ6DISw=;
 b=rGhyiJts+SYEbgLiVkyYQ2hoY27afTXGaO/sd41Pb7O0vOYrZgBr21HoRMyhwPzpeV
 /AyYGsDZ+On4UgZA6RV9+fJHZcMMwV0yqIsk/wr5HPNhA5NtFstUH9+EPfo/qP8hItf1
 hk0rZbz3iTv2Bm/WEF+h4ZybfnjteN65U6Wk9+mOFAHSQRVMwMMUpLej9TF2hz6ONJ6q
 zPIhAGL90BjWGoRSEAaUrOfKa8MdXIEBB4JGttRKQ8ZdzGBsxOWIt/nAvPDtavk+qzxr
 BPaVmD9YE30dDRAN+FN1hCxhVfXl6/ZJ0b6HUmxUf+HCU/VO1fhiqtsW1OqBnmSsDe81
 fGyA==
X-Gm-Message-State: AOJu0YwJl6uFrlqn1q0yoUtr8thFo3DkN++CZqaIpWELeFPzDDHvWmT2
 JjPCtXeEf1UKT4+EY1RE+uCGnPip0t9h8TWYO9dO2ol0LBltP3AUylDr2MkR7T2I2zDAFfP2F3r
 P
X-Google-Smtp-Source: AGHT+IHhENtLntBFmrZ6uyzvqIhXoKM15eqZVwkk2ZXb5h7bYxfRnH6B2QaaWWSMze6xfYuzQuAXzQ==
X-Received: by 2002:a05:600c:46c5:b0:40e:617e:412f with SMTP id
 q5-20020a05600c46c500b0040e617e412fmr491321wmo.150.1706050146214; 
 Tue, 23 Jan 2024 14:49:06 -0800 (PST)
Received: from m1x-phil.lan ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a05600c314500b0040e5e21cd7bsm43236968wmo.11.2024.01.23.14.49.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jan 2024 14:49:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] hw/arm/aspeed: Introduce aspeed_soc_cpu_type() helper
Date: Tue, 23 Jan 2024 23:48:41 +0100
Message-ID: <20240123224842.18485-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240123224842.18485-1-philmd@linaro.org>
References: <20240123224842.18485-1-philmd@linaro.org>
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

In order to alter AspeedSoCClass::cpu_type in the next
commit, introduce the aspeed_soc_cpu_type() helper to
retrieve the per-SoC CPU type from AspeedSoCClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast10x0.c     | 2 +-
 hw/arm/aspeed_ast2400.c     | 3 ++-
 hw/arm/aspeed_ast2600.c     | 3 ++-
 hw/arm/aspeed_soc_common.c  | 5 +++++
 5 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cb832bc1ee..a060a59918 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -143,6 +143,7 @@ struct AspeedSoCClass {
     qemu_irq (*get_irq)(AspeedSoCState *s, int dev);
 };
 
+const char *aspeed_soc_cpu_type(AspeedSoCClass *sc);
 
 enum {
     ASPEED_DEV_SPI_BOOT,
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
index 8becb146a8..dca601a3f9 100644
--- a/hw/arm/aspeed_ast10x0.c
+++ b/hw/arm/aspeed_ast10x0.c
@@ -211,7 +211,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
     /* AST1030 CPU Core */
     armv7m = DEVICE(&a->armv7m);
     qdev_prop_set_uint32(armv7m, "num-irq", 256);
-    qdev_prop_set_string(armv7m, "cpu-type", sc->cpu_type);
+    qdev_prop_set_string(armv7m, "cpu-type", aspeed_soc_cpu_type(sc));
     qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
     object_property_set_link(OBJECT(&a->armv7m), "memory",
                              OBJECT(s->memory), &error_abort);
diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index ad76035528..3baf95916d 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -156,7 +156,8 @@ static void aspeed_ast2400_soc_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", &a->cpu[i], sc->cpu_type);
+        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
+                                aspeed_soc_cpu_type(sc));
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 386a88d4e0..b264433cf0 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -158,7 +158,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", &a->cpu[i], sc->cpu_type);
+        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
+                                aspeed_soc_cpu_type(sc));
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index 828f61093b..36ca189ce9 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -18,6 +18,11 @@
 #include "hw/char/serial.h"
 
 
+const char *aspeed_soc_cpu_type(AspeedSoCClass *sc)
+{
+    return sc->cpu_type;
+}
+
 qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
 {
     return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
-- 
2.41.0


