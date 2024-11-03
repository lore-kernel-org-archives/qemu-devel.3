Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F832D11041
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7alB-0006cx-Ns; Sun, 03 Nov 2024 08:35:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al8-0006ZM-Vv; Sun, 03 Nov 2024 08:35:15 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7al7-0001Vf-6T; Sun, 03 Nov 2024 08:35:14 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a0c7abaa6so414514266b.2; 
 Sun, 03 Nov 2024 05:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640910; x=1731245710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r4Y0ToFbSGJ6R/Fpizvem6vSl9v+O4XUjL/gx4SiiIM=;
 b=gauLCXCEvS6vL+eTfQE+QurUodnbJaTcYhmRrwxzGmIl5EKu678FrOp1HGz3JY2LFq
 7zjwVJGe1UDZ6DlXVNmzO7rZ8XFeMRVRgks1a9uPaI98lf2DerXt0eUhU7o0/fjbDDT0
 4lXPVkRk/EGyP46GWdshnkWVVdoVB7e5ChI4PqqicFPYYr7AcTNfabDHfWRhOkxHA3Qj
 YYr14/o3HrfUHlVO466oF67mjM082/idz2rleqkn0/vvDsrKfUr57J7ooKH2JoYsrMqY
 aJWo8nSi4jTHCQNp9HqXFlmdF0ztIIofg72607kUSK/+B2ks8poKwUDy2QZv0AGgDV8N
 PQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640910; x=1731245710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4Y0ToFbSGJ6R/Fpizvem6vSl9v+O4XUjL/gx4SiiIM=;
 b=PzUhvQlJvZ0/IrV7AsPSEKQwhzlSiI1o7xs1PSIAOlSF+NEWJnVe8Xkm+/PA7FJs4g
 jr2PVtrSLCsVyD2cuTozbxVcDYwxFqa0dbIy4y0BANogQmTXo8TIqTSZZfFyoC+b/Bp6
 7bfXoaoMG611qKBua3bj8aJPrqzqpC6kuoEcMe7fTpzDxjOSSRVgSoi64kRmXQz+VPcw
 IBsv0+vDZ3JWVvTwfS1KtnrifwF7FZxJC4MDW4XBPkBSuWUDOzVLX3vGAiPW19f/VTfo
 oy1p+29f25/4pOEDw/kBpCwkQUUa9MXSbsjTvthHRaB2MVITuJ+Um3d2C7c7aSfmMljM
 sJWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0pBoHPnnDmW0UPmEADif4sRfvLVhdyj0R4RqCliYhH4ZgIUzaP5h33oz9qIc9+8UtpvA77U7QGH4=@nongnu.org,
 AJvYcCUf0ESPoCwPQaZek/p7RsDYFwm0udLMXQrpTeZY7lv/sHwUZOcstoQkRU9JAE1ed8E6WZA4EUDrrbgl@nongnu.org
X-Gm-Message-State: AOJu0YzLTGEawOEFAiIT/eH8eFp6Y7vLT6ylAHvhtgpH5Trm80eDBErU
 EhRGRySreMRQY3JMFdf4sDF4/jzUAVI/SLIwMp+ZwHuqMlJzSTT+tiR/lA==
X-Google-Smtp-Source: AGHT+IGu+MYgcCBmtvZjFR8NVm0lcOsatyIELmJVB+Bry5um3NRX2mp81Gjspb0KIJ02Jv1wivh2aw==
X-Received: by 2002:a17:907:2d0c:b0:a9a:714:4393 with SMTP id
 a640c23a62f3a-a9e6557deb8mr903306066b.23.1730640910370; 
 Sun, 03 Nov 2024 05:35:10 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:35:09 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v4 21/26] hw/block/pflash_cfi01: Prefer DEFINE_TYPES() macro
Date: Sun,  3 Nov 2024 14:34:07 +0100
Message-ID: <20241103133412.73536-22-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/block/pflash_cfi01.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 7b6ec64442..21a81b44f0 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -47,7 +47,6 @@
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "qemu/option.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
@@ -947,20 +946,16 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
 }
 
-
-static const TypeInfo pflash_cfi01_info = {
-    .name           = TYPE_PFLASH_CFI01,
-    .parent         = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(PFlashCFI01),
-    .class_init     = pflash_cfi01_class_init,
+static const TypeInfo pflash_cfi01_types[] = {
+    {
+        .name           = TYPE_PFLASH_CFI01,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(PFlashCFI01),
+        .class_init     = pflash_cfi01_class_init,
+    },
 };
 
-static void pflash_cfi01_register_types(void)
-{
-    type_register_static(&pflash_cfi01_info);
-}
-
-type_init(pflash_cfi01_register_types)
+DEFINE_TYPES(pflash_cfi01_types)
 
 PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    const char *name,
-- 
2.47.0


