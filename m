Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD52C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjQ-0007GR-E2; Fri, 04 Jul 2025 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjK-000758-8t
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:42 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjI-0000Pz-NG
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:42 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6fabb948e5aso14966866d6.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648259; x=1752253059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjiUtqvP+4/zFmyjDONQhsfXC2sJWqJS+GXL0tZEYzQ=;
 b=LYsOL0GwNzt3n4T1iDHydq0WfpUojHKC8ATUAfsUCtwyBh12ws+4UHpk+p7HMPpxJT
 GVWgnhuFLTZOmmwzKn1H0fKduwOTcscEwpUBHCcF13h04SUxrwYI/IfFF+HhA1u8FzAc
 Tw4jBZiW78XyKs8o8mB6KlY+hKjpJ3flEC1e7/5BqstcaDDZmaWqwz5jzpk5kRLnZSMH
 A/PU8JlrqyesHA/8FwP2aOCaftkidgGfx5AACR/iix9kJ3T7tITeEviQBmRLA8eTvXd/
 ZcAsOFYhXpL1J6fNhbzb3nIeerkSKveZLk71Xk9Cv+AqvPBASFHdBk1IY9Fx3/Sa04PK
 WEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648259; x=1752253059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjiUtqvP+4/zFmyjDONQhsfXC2sJWqJS+GXL0tZEYzQ=;
 b=hrhT7CYt8XfEw+6T10BqGcQoQrMbANA0aEtDaVOB7eWhZ5+H6IMVhkzivyGNqHPmuX
 2aRJ+dHrxmjUQSOfm4aFItHW27s29jgnJ3OeoetAxhk4dplcPoCMavLbbex4/YKpw+ak
 UYp78ED70gimg6j1qyBf09oz1dH+ev2NTdE/YZn4ZQyDyQbWp8o+9AexiCwsKPke7Duu
 xOYh3dbV55Q4RanKBfyRUUbtLOgGRdE+xYJ8ZnWzbD23oe97Ftak8MQewepkQbDdCETm
 cEsjA16sK9ECLaD7ZlduNeOskhR8PQwyef8XPo9fvmVNUM0HoO8cYzk6zjyr4g+qcNfU
 n4Hg==
X-Gm-Message-State: AOJu0YylkS0WbFVBHu+rm8vz8kavzVK6oEw5DNFlTWgRqQUAAIY3JD0c
 jL9+NDI9Ur4BsZgoX8JHPFYM0iHKVImSdHk56KgA7kWN91x/KI6tPv2/rR6hlA==
X-Gm-Gg: ASbGncstbOc5BPHHbXsauNd4A+fx5k06Crc/Kt1B8b4rA/y0HgWTE3y3h+W1RyEZBKJ
 8umU5li8dGFZb1gc8QXWE/f81plYN9+4ARm0Aq0SlSU5kixScge/aP66mrOAEhPP+DMMbsqYVTD
 al9iXM98nMoevBzcTmaLPJhOIK9KF4aznmAvkPmuKa8R9UV3ysnxOAbmddSXDyzNqoMAaEd7kQo
 Ef60freJ2LlHvRjrAmtIAp69rKqNSwTWci/jnl4iAOoO2LygqLdGTW6PIfx7V9OfoqoyU5uYHTn
 3NMVB+5CyYcs0GW8QNFmFLXZu8G5vHafqAD4UvpqSDqUVh+Onu4/YwUmXLFWqZdo6ZEyjKE3bWq
 NJ1wW
X-Google-Smtp-Source: AGHT+IHqlVFc2AzVv67f6tS3qfcoSALnW+nw2bCVIhKGyN3CIN+P7qssqNWig/N5QZH0lfQm2HNdjA==
X-Received: by 2002:a05:6214:4e86:b0:702:c8e2:d218 with SMTP id
 6a1803df08f44-702c8e2d25fmr32020486d6.26.1751648259529; 
 Fri, 04 Jul 2025 09:57:39 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:38 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 11/11] MAX78000: Add AES to SOC
Date: Fri,  4 Jul 2025 12:57:29 -0400
Message-Id: <20250704165729.208381-12-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704165729.208381-1-jcksn@duck.com>
References: <20250704165729.208381-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf2a.google.com
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
---
 hw/arm/max78000_soc.c         | 14 +++++++++++---
 include/hw/arm/max78000_soc.h |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
index 074fb1da8b..39ae4e0396 100644
--- a/hw/arm/max78000_soc.c
+++ b/hw/arm/max78000_soc.c
@@ -45,6 +45,8 @@ static void max78000_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "trng", &s->trng, TYPE_MAX78000_TRNG);
 
+    object_initialize_child(obj, "aes", &s->aes, TYPE_MAX78000_AES);
+
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
 }
 
@@ -54,6 +56,7 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     DeviceState *dev, *gcrdev, *armv7m;
     g_autofree char *trng_link = NULL;
+    g_autofree char *aes_link = NULL;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
@@ -137,6 +140,14 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
     trng_link = g_strdup("trng");
     object_property_set_link(OBJECT(gcrdev), trng_link, OBJECT(dev), &err);
 
+    dev = DEVICE(&s->aes);
+    sysbus_realize(SYS_BUS_DEVICE(dev), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40007400);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(armv7m, 5));
+
+    aes_link = g_strdup("aes");
+    object_property_set_link(OBJECT(gcrdev), aes_link, OBJECT(dev), &err);
+
     dev = DEVICE(&s->gcr);
     sysbus_realize(SYS_BUS_DEVICE(dev), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
@@ -154,9 +165,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
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


