Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD34C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 22:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXoxw-0001ks-Sw; Fri, 04 Jul 2025 18:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxj-0001gL-R1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:58 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXoxf-0007Gv-9U
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 18:32:55 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4a589b7dd5fso25264871cf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751668370; x=1752273170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hotAB/ED0EAxC4E6VxD2YUk0GGx5OkOJzrkHwOKZueo=;
 b=D9mRoAtLXYswPMSz7Ltoh5w88EeF/1Dh7GnALdZNVH1MvCLS/nMEuw4/fGbx3J9zGS
 vJl94/LzOEnc/YPv6nPHDldmN+Gpi/3G70ik1hqLP+pdPp9qr5PybSyY9Akhwsk7dkcv
 iyY4Jk3LCyZwcYfSm6cFAnjl4+pmFE0TTI8KeN+bBjjAi2Sk4OdjwwYA1ORixQMzRXlx
 VmTWLEvfB7QfcbJiWI69l1LPDtBoFyPd5FvQSrWAcmejU6SyKwo7aNU7G6+Z80ANuJzY
 1/5lFfbn6FZtL8eBMBt280nNBgycvpxP4VuazdLl8wya4xoYBYdsa4udka42z3vFTRoO
 xquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751668370; x=1752273170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hotAB/ED0EAxC4E6VxD2YUk0GGx5OkOJzrkHwOKZueo=;
 b=UOSuUZYtFh7r2IotU/mCMr1d+8T+t7Uh4eAIBNn7Bf9pdwesoxYmge+dTgMCtSZcUR
 ydnuNu+Ps/ufIkWVFeaX1ofgmJM+1KM3AtNggzbtkfBYKxsZINeuxpfEAIbDZG3i2sOW
 qfBhTAIKkUrxOW0QHONLMasHS4CnOs6LmqDrvYQNpGWJ9MMxUUYP974LAB1mxluyKm9H
 E657VU8KePVMbSPPtq38ikpDUDzqzv7WznxoOZwYjLHcF+ftbtNYZLAw0+Ama0NQMJ8X
 9W2r3M/3Xiipp/mclpWTFbNdiPZqRtCw4rD3U8jhsBUzYHo0WeGe2OSQlTW8Sb179Avm
 lOhA==
X-Gm-Message-State: AOJu0YzXPA8kWkpaXZBHN8F4OvbLtxMf0WbrWGv1te2drnDOgeUQMJfT
 KhWAVhCYIgkm0aI+gdxsNmsBxHW5wcuF87zL4ZaAhQaRWYquetI6DRGJQIJNlw==
X-Gm-Gg: ASbGncsu8VIGTrR5z+XIIGSW9WVf4mTNtJKwvC3Fv8fJO0v7HWhJdM19yQuN0pqmw4P
 IoJA1XlGRBGSZPn/FLd3uitVK9ySgb6rayFr4wZJmBGaZ2hRCtoKXZETYjS+2DzUAlspZ8Up3p0
 kVq4MxMhbuOHMw2buFpOMceBsl7Egs0T4BGaNf1IDRj8H8Mklmn0Z9ullJX/7VzhP+DmF+e9yPh
 P3y2vmAitXJ+GdvnK7cxI+8Xdv84Asuspeoq6sxukd0RxrDw2iumuV5QsXG9N6vgMQCR1sKqgqg
 /ttbrneKa8ubaZUc+j/kToK+sPPX8gcPRiwJletxMhBO3NFGLqbvg5ZZXbO3EQHQa8ONC44loti
 jBhreWw==
X-Google-Smtp-Source: AGHT+IHjkrMZsan5iatA2ykyGODfJx7k02cHD3g4xn6tBNbcy5RNl9C+P9DDc3ozZjcgnthiFYXQgA==
X-Received: by 2002:a05:622a:4a89:b0:4a8:24fa:67db with SMTP id
 d75a77b69052e-4a9a68c185amr10330331cf.1.1751668369790; 
 Fri, 04 Jul 2025 15:32:49 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:7cf4:c69f:10f5:f5b9])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm21528851cf.36.2025.07.04.15.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 15:32:49 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v4 11/11] MAX78000: Add AES to SOC
Date: Fri,  4 Jul 2025 18:32:39 -0400
Message-Id: <20250704223239.248781-12-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704223239.248781-1-jcksn@duck.com>
References: <20250704223239.248781-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This commit adds AES to max78000_soc

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/max78000_soc.c         | 12 +++++++++---
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 3f2069fb03..7f1856f5ba 100644
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
 
diff --git a/include/hw/arm/max78000_soc.h b/include/hw/arm/max78000_soc.h
index 528598cfcb..a203079ee9 100644
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
-- 
2.34.1


