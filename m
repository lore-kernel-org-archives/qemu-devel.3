Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82526CFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAkP-0005TV-Ku; Sat, 05 Oct 2024 15:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkE-0005O7-Hu; Sat, 05 Oct 2024 15:47:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAkC-0007fr-GL; Sat, 05 Oct 2024 15:47:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so31529625e9.0; 
 Sat, 05 Oct 2024 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157629; x=1728762429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qh7tx41xIteOcANyWopZzt4/cC1snPfQD4qcl5bcIW8=;
 b=JizyVPHXJ8gfwrx0ppujRkwojUdBfXY9ICsITIWEs+/4/W6j90OmsloonvgAqfOxNz
 hDplGd/NksBsuxbU7UdRqr9GHceF2oQdsCKRtCRnwIPb5x0TxjlE3lfSBAc7xBqrwJxD
 XHfRcn4df+BYgrua8Mv85xGeGe2cEutvf4/ZbOW0VpOz7pha0HgBbUpYcNyEK7jyeCol
 XiYi3dlobOUY6FcoXknkVWBNrwKCo4al45/Wl/8PLxWryUmdGpobk5WYWbAFFbs8L3cv
 u98QI3CoD1pdZl28egtAUybd1+8p0XVtR3SfUmpdf0bdmWz10PeJ+ZBdBM+cOHeNKCo+
 4+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157629; x=1728762429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qh7tx41xIteOcANyWopZzt4/cC1snPfQD4qcl5bcIW8=;
 b=qgyFcA0FKnlkPKOjZ9raZ4ZST/69OO/YgGpTK9bzuVaVNwKWc6dwJZNpbIiBMTxz0J
 8BdkZ9jDKTZ85+HG5oLOcpi2xgE9Dc1OgePD86Q8FGriMATR4fCn5xoAIk0HnS8u87rD
 Hd3AjBMsb4uV6rODNJGMpS6/Qf7MYSGqJStsagTenVoq1S4Pkm7bcl7aVUJDP3LVPGc/
 sjNDSL66mBFxz28CpkY3Tsj3XjkL0/c97Leg64HRsna85pbZc4+JQpVtpVX+Fuxi1u3V
 E60rutksMMUM5YAE/QR49GsoRpwNKlT9wjuNRpb17svnpgw1f5I0eCCwuVisJ6M+AWQj
 laCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb3Qjz+Tm69Gjo5FmgdCsMVKU/8RFDp+6J9FrNbmNoRC/Ns6z+PsHhgtXKNHF2/zTKCwNq15LWTnfD@nongnu.org,
 AJvYcCWKxjBYupjMywDbz04ut8lhvqWUXlKMukjlEkvMDNtH5F6hBpmmFR+EW++O5LHXPk/PiKL8YbEVjdI=@nongnu.org
X-Gm-Message-State: AOJu0YyCYSrdy4PrrUGs/9aMnU7c9cDoBmAfWtTWjdOT+7Pn/l7/u03E
 vZGJyQGl5jSxAgX2277lTqb3HcOCP/Bj90GUD6A8RS0I+pYeiAfw7PJyyw==
X-Google-Smtp-Source: AGHT+IGoOikjyZCfqd9MKVTNZdx0xQAGHh5DrtmXeoQjDG5qgsCI8Y8L0BBW+aqYvNZZf/70UbBTZQ==
X-Received: by 2002:a05:600c:5246:b0:42f:4f6:f8bc with SMTP id
 5b1f17b1804b1-42f85aa6a64mr57467415e9.9.1728157628878; 
 Sat, 05 Oct 2024 12:47:08 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:47:08 -0700 (PDT)
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
Subject: [PATCH v2 11/23] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
Date: Sat,  5 Oct 2024 21:45:51 +0200
Message-ID: <20241005194603.23139-12-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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
2.46.2


