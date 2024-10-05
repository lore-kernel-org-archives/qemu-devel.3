Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB12CFB42D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkd-0005q6-Dh; Sat, 05 Oct 2024 15:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkI-0005Os-34; Sat, 05 Oct 2024 15:47:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkG-0007hb-ND; Sat, 05 Oct 2024 15:47:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso31679955e9.2; 
 Sat, 05 Oct 2024 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157633; x=1728762433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T//dp0abStXeq6JWPfINCQ4KAUheGtCEJkAqcnHC/p4=;
 b=fgZh89fbPjL7LAL/+MgBM0pS+1bsjAoiRc1HZVLNw7VXmuMhe/lSBbL+KxtHqVD1+j
 uIuwCFY/OLM9CTyvZtEEgE+K/XwOjRvydkuzaS2cIelpn/5i4ItLLccDtYVlphbjYHks
 5T+7bko8fwqcHYlgk7gOxelSJUIjN+vhYR6yWWTXgtDz9ZBe9n/vq8+VKT48aV0NTI7U
 C3ROs6fZGoa8BlStLMDxWsD3hhcYPdbFabm+PsIP7RBDENXq6S+7QYD1RAK0AZIP2Smt
 otb2Xp9NwpZTjFe1JN2/S50S6+9tNEtXXEmu4EHqHvp6OtA8iHhU7Gq6jl3cNJr8V+Gn
 xC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157633; x=1728762433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T//dp0abStXeq6JWPfINCQ4KAUheGtCEJkAqcnHC/p4=;
 b=Kp4BQjLdhA0AVkzDSEQivnZeOW7iYXEV/oVrSsrI6fcufLR3A1/9lC/Vsdrzl4Z8qb
 OFmDb8t8BBBLUnTI/w5WUf3boTfTibIMCKm/PzS+k1oDPwr3jitYO0qKBLn4dUwW82BS
 7TQUT4lJcPXPid0JkG94IeRVwaXuOpe7MFwJbaW9Enb8mTB47bZx261l8d1sTjvH47xe
 7GEH/4XeKaFAgGY8z06xmPG5IxyJXoA7jtXkPl1YZmfJBMWFFM29pd6Wp6uS/TA07lsq
 Lw2MdLcgSOm01sncjCZfk4MwUVX5LUijCMaLDW/135AHsOXIFa8FwwHUOA0A5RVXo/CL
 LL9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE5uB2OqAYcA9gkApUdATjwkKOTOpch1JkOVILS8w/Jo6npvqvVpQysSUHVG+g8jkUhrAtDgbmRW4=@nongnu.org,
 AJvYcCVH9oblm+nGKqRjGP+MPOIfdAWTd6pgsYo+ZbFVWPGabWVfWEqlW78t4jVd228XdEESU+iTn/y3MUzl@nongnu.org
X-Gm-Message-State: AOJu0Yweg565sQUGgU+iEJ+UM8Z74rK6+ERyYVnGjfK7l/gmUhN5a8cA
 uEGcYxZ9cv6ByoVeUWR785arNCOYISyFKJKWrDctA4CO03RQ5oAgtKH8aQ==
X-Google-Smtp-Source: AGHT+IFv1FTU/3RqXKFQJGTMKuhsRJh0dALKvfSuzjEHKsGsNKSRsRZm37e8NFBfX5uMgYiQ3196tQ==
X-Received: by 2002:a05:600c:44d6:b0:42c:c401:6d86 with SMTP id
 5b1f17b1804b1-42f85aea06fmr47916805e9.27.1728157633228; 
 Sat, 05 Oct 2024 12:47:13 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:12 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 14/23] hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:45:54 +0200
Message-ID: <20241005194603.23139-15-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/gpio/mpc8xxx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 63b7a5c881..de183c3be5 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -23,7 +23,6 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 
 #define TYPE_MPC8XXX_GPIO "mpc8xxx_gpio"
@@ -208,17 +207,14 @@ static void mpc8xxx_gpio_class_init(ObjectClass *klass, void *data)
     device_class_set_legacy_reset(dc, mpc8xxx_gpio_reset);
 }
 
-static const TypeInfo mpc8xxx_gpio_info = {
-    .name          = TYPE_MPC8XXX_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(MPC8XXXGPIOState),
-    .instance_init = mpc8xxx_gpio_initfn,
-    .class_init    = mpc8xxx_gpio_class_init,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_MPC8XXX_GPIO,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(MPC8XXXGPIOState),
+        .instance_init = mpc8xxx_gpio_initfn,
+        .class_init    = mpc8xxx_gpio_class_init,
+    },
 };
 
-static void mpc8xxx_gpio_register_types(void)
-{
-    type_register_static(&mpc8xxx_gpio_info);
-}
-
-type_init(mpc8xxx_gpio_register_types)
+DEFINE_TYPES(types)
-- 
2.46.2


