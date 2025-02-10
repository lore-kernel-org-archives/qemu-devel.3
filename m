Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F419C021A2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thacj-0007GI-6y; Mon, 10 Feb 2025 15:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacZ-00076S-V3
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thacY-0003fS-7b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:11 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso53845365e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220188; x=1739824988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXLAth+OcKN5qmuSWCVnQNPPe3Rb89yPkhZvLN1aBKY=;
 b=KvFD17cNrPOqMmZJYsD60HwSgeRhJDZAd+UXjBoUrXzi+oNdi7YMZdebeHPcOiNtbT
 nIvsw1M+fTmnXKr7VSnxjr7g3NPNd5gn9pEwHAIzmCqbYP2ZXLqNmlW9fIyhwEG6TgAW
 SEm4/wMtKyXbajhidTi6mtI1LlnF3d3xzTdzlACAyZWqMij85xWo40X245DdIDX7JaT1
 hExWE6GQHBQLLqVwzOBaYPjHsj5p2GGLJFY8FKI8jJeN/eYllURtYQQfd9pkPu7in4wQ
 LN+TXHKOh1+NIxWeWBaR3Wlj9YyBxktmlaf78B6+XUPATr8NNaikeSv7m0vePF2FzjPo
 uZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220188; x=1739824988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXLAth+OcKN5qmuSWCVnQNPPe3Rb89yPkhZvLN1aBKY=;
 b=Yi8KmnjtkAIhI00s7dqqwIfz/Xug2SI2ophSx8SSEmQfGtWhCZAyIAH5ly6+a0BEnH
 MCJPqv+gdVrV50z6L0ijBzJTjzpe1dstPn92paz7HC7xkRR7zM1gF8ToxdqHNK/JBF8a
 J8nXc8GftLrSYyPhzdhJWlNoGj/QstckyHMD0gsv3iHHGmbHbhIzUeoSVYoZG+oaQc7I
 8PWyNHZlpSlt7KXU+2srmVQSh4G5euD3kmawB1zX0kk5/KedU/eKplfGTS1nS/gt+oes
 AGITQyvC70NaeH9F7cJPdYc72o+Aw3UzonuXmlILG/cMLqEOZUmqyj2D6S49IyZVs8jm
 DQNw==
X-Gm-Message-State: AOJu0YzCY42iJWbWkruZktz9f5IbMTMv7P5uv5q32REtD+kT373e2r5v
 bgjMrZOgPrieDXKX8brzl0qJk47fhpOIJYR4ZEs6uAoAH47FVzTj5uIj6ZGfFG9C2VmroajtTF7
 KVXM=
X-Gm-Gg: ASbGnctOOiuTXbwZ7Cu+FuFNEm1Rx6GwHPmEkaEF1XfD75VLQJQhNQteAqf0J8LpHMb
 xQ64Qvf/f3frTZzuX2hlhlo7zhELbDhpeOktF+3gUSFyKm02oM0vMGh2i2+KLd9J0AHC3mW5PLk
 w3JM7KHU++je+rJReYNvp7sHIqyGi+I9ArDevSb6fwLkjNuqedXboU/YoHQa/BytjFcMv7i9A46
 WHQSZxH+1y7gdvDU95edrSihWXHvUvZD9s3OS4qZjr2SK6IFtGMs8jMvfde//+oafeTMQx69GzQ
 Vw9nPW6RTON4YxHbwRazQC0vNbVXTmvJb45DYaEEUIoCIUs49frvkB8hIhWc3lAVTA==
X-Google-Smtp-Source: AGHT+IGqPvLQBUPqZS5TXrez2wdmzGmggoSATI1VtcxfCzH/A1GkW9bsZC4N2d7B1HSnpy7mS6RgpA==
X-Received: by 2002:a05:600c:4e89:b0:439:45ce:15c0 with SMTP id
 5b1f17b1804b1-43945ce18d2mr33383405e9.25.1739220188332; 
 Mon, 10 Feb 2025 12:43:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc5839877sm11545288f8f.3.2025.02.10.12.43.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>
Subject: [PULL 12/32] hw/sysbus: Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE
Date: Mon, 10 Feb 2025 21:41:44 +0100
Message-ID: <20250210204204.54407-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Some TYPE_SYS_BUS_DEVICEs can be optionally dynamically
plugged on the TYPE_PLATFORM_BUS_DEVICE.
Rather than sometimes noting that with comment around
the 'user_creatable = true' line in each DeviceRealize
handler, introduce an abstract TYPE_DYNAMIC_SYS_BUS_DEVICE
class.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250125181343.59151-4-philmd@linaro.org>
---
 include/hw/sysbus.h |  2 ++
 hw/core/sysbus.c    | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/hw/sysbus.h b/include/hw/sysbus.h
index c9b1e0e90e3..81bbda10d37 100644
--- a/include/hw/sysbus.h
+++ b/include/hw/sysbus.h
@@ -19,6 +19,8 @@ DECLARE_INSTANCE_CHECKER(BusState, SYSTEM_BUS,
 OBJECT_DECLARE_TYPE(SysBusDevice, SysBusDeviceClass,
                     SYS_BUS_DEVICE)
 
+#define TYPE_DYNAMIC_SYS_BUS_DEVICE "dynamic-sysbus-device"
+
 /**
  * SysBusDeviceClass:
  *
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 075c7dfd69b..98819d5dc61 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -320,6 +320,14 @@ BusState *sysbus_get_default(void)
     return main_system_bus;
 }
 
+static void dynamic_sysbus_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *k = DEVICE_CLASS(klass);
+
+    k->user_creatable = true;
+    k->hotpluggable = false;
+}
+
 static const TypeInfo sysbus_types[] = {
     {
         .name           = TYPE_SYSTEM_BUS,
@@ -335,6 +343,12 @@ static const TypeInfo sysbus_types[] = {
         .class_size     = sizeof(SysBusDeviceClass),
         .class_init     = sysbus_device_class_init,
     },
+    {
+        .name           = TYPE_DYNAMIC_SYS_BUS_DEVICE,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .class_init     = dynamic_sysbus_device_class_init,
+        .abstract       = true,
+    }
 };
 
 DEFINE_TYPES(sysbus_types)
-- 
2.47.1


