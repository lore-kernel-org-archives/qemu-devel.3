Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F918C71159
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 05:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS7in-0003KF-TT; Thu, 19 Jun 2025 01:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r9-000703-Cp
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:11 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uS1r7-000675-QJ
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 19:06:11 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3ddff24fdc4so2034525ab.2
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750287968; x=1750892768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWk8Nnabsk0USBLXKPI1hm//HSAUsckOEqxWoXg2fp8=;
 b=cZJifoL6QzkBRwaS2t5vme2xiMa5lsQ8SOy/h9/KJWN0lRTvULnk21tgvRA2u/NjFF
 wQ75Gf5rjia+cef1A52W4s9K20YgFUQqhJbiwzN/3BRQwSMHmiVvs4ozOKXwrq9gOrAa
 4bK2p41ta7uNCM4sEF0Wvdj2tjCv+QAxYCP1Ut2RHLHcp0/fCsKu33o4PpyOWOW1dnBl
 ZEZGnaYz0hxDOJFtkdNHx8X93rnARqTy4HwJg18ILujgnrmzV2hm/2Hqv4hv8qN2SJGT
 L+padKIDw2fTgs2IFRhUAAraluRRT3bxq8kvAnUhqHheCwh80lUEKTNGarF4JHB7TviY
 tOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750287968; x=1750892768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWk8Nnabsk0USBLXKPI1hm//HSAUsckOEqxWoXg2fp8=;
 b=XaVhTDgJE9U0cfsUAmOd/4ijT1Pmv6nNXVnnhjbc5q0Mw1eGIbNtUfQ+G4rYDcIc3c
 uEr7PL83TH98unzBrz9fyUUY9a/VGjQQxUHJfX07yuzNuGVjGJF/PE07mjCyN5GRztVi
 ea8hi1/mGf5UqzrnHIU/BZX36qYvKd7Oa6ptiX/N40jWZZYIJrQhH8wsymKDzkSLNhdC
 9E3404a5oCUbcUoEf68TGmUVbDtJ3S2EXsS/UhX31/L7jrpHTeCykjj66lzsjPyfJVrr
 J3lDSujP4l1+nGL1YBiM49S4M0Pq678wzt5rCdthuUa6IF5hqTs4NqbngZEpbqVRzj/7
 iSEA==
X-Gm-Message-State: AOJu0YwgCBNGk2RdvElbmIppQfQWaGY4bQAvn77pHrrojoYrcDfYLW4f
 A3jRrwSZBXRhxqtGJ3IvE4YEMj1wAu5nmd+0dXJywfVE7aHJW8B3ixx5emxUrjDiXB4=
X-Gm-Gg: ASbGnct8YLvGM3xWA/nESTfltxVt7+5POd8q9wROvyo4csrl6Rp1nx6E9jdNyg38jAD
 2bcB8Qy/aV5yrURVDiWcJlTqjFze9CsXDccax+A6zL7Rlyd9g6cc9Cp4hpdxsv4Sf+sn6GG3m9/
 SayK2w+VtTP1LqMlLG+3JQJxH27Mo28Z01U8ys/Zx/I9ZVelyU4vFMsKW4+6ZyJmwB7+GjEz/Ks
 cERKi1K//2C6T9X2+FSGHsR3Ml/xWNgiq8KiJZojxhxyuIKNythiF4JRRUcfZa9qu8CoyGlxuxM
 Cfve6yL97TYaOOPBuKY4Y4rZxrI5UqdfuquIaISMJHiWga1QRnNojPlZL75q/P5b1fwue9I1R4g
 2Mvyd
X-Google-Smtp-Source: AGHT+IFieuf5sOL1KzNPOF91LCTlJYI5rqBGN9oXaFP+ajX1KcZZQFeVdVT69vbv5ssczzpd/khjNw==
X-Received: by 2002:a05:6e02:1c05:b0:3dd:f813:64c5 with SMTP id
 e9e14a558f8ab-3de07cd451emr244538825ab.22.1750287968459; 
 Wed, 18 Jun 2025 16:06:08 -0700 (PDT)
Received: from user-jcksn.hsd1.mi.comcast.net
 ([2601:401:101:1070:b57:773f:14d7:807b])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50149b9df11sm3036915173.54.2025.06.18.16.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 16:06:07 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 11/11] MAX78000: Add AES to SOC
Date: Wed, 18 Jun 2025 19:05:49 -0400
Message-Id: <20250618230549.3351152-12-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618230549.3351152-1-jcksn@duck.com>
References: <20250618230549.3351152-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=jackson88044@gmail.com; helo=mail-il1-x12a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Jun 2025 01:21:43 -0400
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
---
 hw/arm/max78000_soc.c         | 12 +++++++++---
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 09667b578c..f6d599a62e 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -43,6 +43,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
 
+    object_initialize_child(obj, "aes", &s->aes, TYPE_MAX78000_AES);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -133,6 +135,13 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     dev->id = g_strdup("trng");
     object_property_set_link(OBJECT(gcrdev), "trng", OBJECT(dev), &err);
 
+    dev = DEVICE(&s->aes);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40007400);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 5));
+    dev->id = g_strdup("aes");
+    object_property_set_link(OBJECT(gcrdev), "aes", OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -150,9 +159,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
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


