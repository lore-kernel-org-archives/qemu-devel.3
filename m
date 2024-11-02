Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1072E677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:22:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E1C-0003jj-Vf; Sat, 02 Nov 2024 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0r-0003AJ-7R; Sat, 02 Nov 2024 09:17:58 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0p-00020Y-8O; Sat, 02 Nov 2024 09:17:56 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so414962966b.2; 
 Sat, 02 Nov 2024 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553472; x=1731158272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81MfAqqbp66dFfi7sHbuaRksnlomjizHjiUJECLfYTw=;
 b=LZRyGwOSfekWRcdmRPt/WQpFVCFJZM7lXRN0g8XnVWO2figG0tjqMdMfZQp7hzWMJY
 tLdeWmKKur/qt7j7mTyS20Wn+1atcakWL7/uXePqw4u9+IAoA94EQK76yGkeQDPZMbLr
 UJg07qCUHo0PJzq6YzpwrmDi5c62AXMMVjZwS15r19z2Qk9ZlLSeJJdm0b+kP5nNIjr9
 NN0bd5vSzwWpsj8Xzx8M1ybixkEGKZXzVfRrGlIBC+5cJoWox/bPBmDSbfI/SweNaBYR
 4jS1qQKV8SjloE37hkMttAAiCLwvMhtzjFAq4nBX/3AAt1HOuBVINqofisekWcE5vmF1
 oUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553472; x=1731158272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81MfAqqbp66dFfi7sHbuaRksnlomjizHjiUJECLfYTw=;
 b=dHcO8kKKD7mJNxlXHfTTwyW8dUHUZsxh1+DLIX2IyJOX1OqyU3hlLFy99LY+fLl84T
 f7Z3mSJSYFhJsHNgZrUg+faESaK2DbgMahz8RTGe51705tLNpnmt9VhAhy/VHa6OLzaP
 MAMTOCVftAPlxnM/xDtDPD04tj9w6LN+enJ7wPCv8nbFfSUO7ZjEoV9bVLlUZE530+2R
 /oOLhpqrs45F0X9jL5MmW6SPbBBavTOmtqzL3oGF89up0eDIjhKCVBeUmxOxsh4jI1k6
 vMLOigF2VQMr2ECwYQiufEHNNmztj48HDDzVOtEKPTkH9Mwb6RjlRP9zOS8NB8eSJOOu
 nagg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqXsBjOTQ9GWGsDf1wxdK1sehQ29P/cosxSDolMsc241uJaUeSIA9rvjfQ6L93NzU2IyrYsslWYhA=@nongnu.org,
 AJvYcCX7otU6dwiz91HB2Agec3eqRk4VTU1gHxk67Q93qmucuIbO0cgLof6xgKTvCcIToY3Lw5DXi3Buza4P@nongnu.org
X-Gm-Message-State: AOJu0YywQIwklGT5L19rJ6A5GM9YdKszxwud0x3soj6QoXvrxbl2mSLg
 AymNWlIN4HLlA+vdj8rra18aY9Ynr+/sSEssFJTKzbkJlvM2vd7gHoqqiA==
X-Google-Smtp-Source: AGHT+IGE+U9QLMZXheb9qhqDWZ0xMGD2baRMHOfNGy182m2Nn36MBGXMuDzpAjG7Y04w5uDblWgdfg==
X-Received: by 2002:a17:906:6a1e:b0:a77:c95e:9b1c with SMTP id
 a640c23a62f3a-a9e654f89b5mr586975966b.27.1730553472375; 
 Sat, 02 Nov 2024 06:17:52 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:51 -0700 (PDT)
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
Subject: [PATCH v3 17/26] hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
Date: Sat,  2 Nov 2024 14:17:06 +0100
Message-ID: <20241102131715.548849-18-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
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
2.47.0


