Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BE8E677FD
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E17-0003PR-Nz; Sat, 02 Nov 2024 09:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0j-00035x-VW; Sat, 02 Nov 2024 09:17:51 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0i-0001yw-8F; Sat, 02 Nov 2024 09:17:49 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cec7cde922so1376040a12.3; 
 Sat, 02 Nov 2024 06:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553466; x=1731158266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yd6NatUTxfChD+GNQ4/iAKaUKLh+xS235Qy81Xz/MlE=;
 b=Yo1Q0MdLZ+USu8AJ9WtcXUcxQh54iN8BHVQytpqTw9wbegk/sOzsUFc0e+o1BKPrgH
 1F5UasMc64mdf1WGAYRKDZnltDjyQluspXzpclAP1iu5hKIoTqLemhgsGuBfeVWh4hIY
 ZfhEH7aESJ2lekLCoFGy1CjrnbfyhCP5LIVcpEkacx7Qm0l+7qjHRXc0kM/73x0bJhSn
 N0MG8UlYOFhcvbJ7nnRfj3mDaI2YtqLndJU/3FwwKr6YmxUQp35SMedPxd+eUwHbHGeP
 BcjmBHQXiP7ngmAlXVC9yDGwwLuxkxJ2YcLly87JFGG/gTik/YT7Z+w8Xttb5Edq5LxJ
 o3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553466; x=1731158266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yd6NatUTxfChD+GNQ4/iAKaUKLh+xS235Qy81Xz/MlE=;
 b=G6ZSb9FLVOvB/3X4dT2OsrN0TNOKPXOrS5Wy48HRBJ7TXlQoe11CpVZqrFF+B3gY+q
 suHo1Q7QSut62taGy9tDhtCfn3rwTVpQMWSFll8VG6S8wzjgf3dHffB/VSYBkoKfqNj0
 cwvrAQ1LSZuTgX6pZtom1VAIulAidY4UJ6cI2+eZZQnx+L4qi0e1klSVVZRS01jaleV0
 oYKeu/V3akzWphPFbPgzPpQsFcZehc9IQ384843RC1aMmwlCzExjpW0TTyvK6Tw14IyV
 uSdSi17m9u6+tZ5Ib++xr6x7eZo1k0WT735wLhXLTLMKEiTtb+c9i+I5Eb6tmW3CsqJO
 /qYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEKreAm5Owb20V6WxB2NXPj2IosrGtOq7U7dR2Sz1hIERTejGTmrIucyu7yW3TEYqc5XzMCeSVIY4=@nongnu.org,
 AJvYcCUKidZ+DhZT8Bxrv5IrmeWph72wVfjrRg35ch3OCkujSgoSrqBAtfIJyYFjyVSyV6l+JUT+Fia+J2zr@nongnu.org
X-Gm-Message-State: AOJu0YxvV1Mjqfir7WYT7GsYKrzu7BLhrkHIyqHfkVT1cP+SRdzDysy+
 8I9ereT6p5bsyLrnWKjO4Eu4tdxsLLZu025Qjcft2BgWeCk/vr8Bd6/yTg==
X-Google-Smtp-Source: AGHT+IEWl/Y0wToQaGZaDT0jfnsKwHFZGduR+7+B9RESCEudX/YE6zwVb0e3dgILhCm+rJ2hMvua2w==
X-Received: by 2002:a17:907:3f09:b0:a9a:2d04:b577 with SMTP id
 a640c23a62f3a-a9e3a620e06mr1456125166b.32.1730553465517; 
 Sat, 02 Nov 2024 06:17:45 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 12/26] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:01 +0100
Message-ID: <20241102131715.548849-13-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
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
 hw/i2c/mpc_i2c.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 3d79c15653..16f4309ea9 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
-#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
@@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
     dc->desc = "MPC I2C Controller";
 }
 
-static const TypeInfo mpc_i2c_type_info = {
-    .name          = TYPE_MPC_I2C,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(MPCI2CState),
-    .class_init    = mpc_i2c_class_init,
+static const TypeInfo types[] = {
+    {
+        .name          = TYPE_MPC_I2C,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(MPCI2CState),
+        .class_init    = mpc_i2c_class_init,
+    },
 };
 
-static void mpc_i2c_register_types(void)
-{
-    type_register_static(&mpc_i2c_type_info);
-}
-
-type_init(mpc_i2c_register_types)
+DEFINE_TYPES(types)
-- 
2.47.0


