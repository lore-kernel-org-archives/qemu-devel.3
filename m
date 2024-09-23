Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC26CF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPm-0003Bw-Un; Mon, 23 Sep 2024 05:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPl-00034k-1k; Mon, 23 Sep 2024 05:31:29 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPj-00070D-8m; Mon, 23 Sep 2024 05:31:28 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so504498866b.2; 
 Mon, 23 Sep 2024 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083884; x=1727688684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FkfWI02D70VtzWbR0yhpKcWeB0nhAn0RHoWdU2Bvhx8=;
 b=Z0aEFxLluermHTNH9TbKDeQjZMrIDk4GIoCo4GU+VmKgx+RqV1fX7nFtT/Ov3tky2V
 imosaai1ExCm5PUqakwXXT2LPLjB2WB9NkHqKi8QIRCohbr1VGzo3fFc+rHHk62YiN0M
 Fgv0LP8B2qrghHC8JPJNCE24GQon4+Uo+n2jjQHKqfhCANpCKZi2qwUwlCe19sRWcdmJ
 yNQNZ36Y9X5pREmdRuV/jKyeBh8g6E/AiuT6yaPoNEcrvIjSycOYYT0IGQDMqd27y2Cd
 PPRFkSWPzeh/UZZNiNgVE8AH+ykkm1gDmWEUwZolx1scNp/ovtxdD7AGpDrZcXg0R78J
 NMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083884; x=1727688684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkfWI02D70VtzWbR0yhpKcWeB0nhAn0RHoWdU2Bvhx8=;
 b=J85MbTf1Do24GvXNKs8vxvVzam1oMioO/eY8AKGrt3ctxvyvcUJP0xVcDvNrL+ffBa
 weSVPi9JsddJ+6Wicig6nTl7vYpe2LLETMu96p6A1t2RPivHtUspGUjopBJOh6eNb4+g
 51dDPCu4J+CpychfLceT6d0jyAx9o6iRZGfsaGZtl3iXtbrCUKuphsCYc2I4hPXi8Nui
 EEyuCFNOF7qR82ifrlYgfEgnoVd2YGPpCZtSTrFEPMTQZqGVuFT1kgc/kpo029OTVHZ3
 JqSYJjmue4bdXoSDTFhe6Ocir7E3goMnLGV46A9eya7GVVGxU8SuEuXEZVidg1InkCLV
 R1bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhVejjQy2g+HWUg/wdulwkPe5czkdKEgdiQm2Dl10Lv+9GVPFAsllS1ZLteGzapPTkMyyGsNLoXOzb@nongnu.org,
 AJvYcCVI0CLD69P6hVmiVa4Ip5nV9SXkfeerxMxwKwjEJbw9XLCzF/INEwFOQYZ3se0M8z4EB//RFtDxzPs=@nongnu.org
X-Gm-Message-State: AOJu0YwC88DqiYQb56BOj4zq7NHU2p0xkZt50SbOceaJGfUZuqaqeFAX
 gF21hGiq8IJ+EP6SU2A+BbjPx6ZCw+h4HBSkyMWJ4GosuUIRfHLxTsRKBg==
X-Google-Smtp-Source: AGHT+IFh8CFek9hxkLL6felu5Vk0iaQ0t1buQG+uvDFXzx6tJpapcMekUUu6CXC49EH5lOCdZ4cPCQ==
X-Received: by 2002:a17:906:c155:b0:a8d:6712:2ddd with SMTP id
 a640c23a62f3a-a90d549c063mr1162954866b.2.1727083884281; 
 Mon, 23 Sep 2024 02:31:24 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:23 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 14/23] hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:07 +0200
Message-ID: <20240923093016.66437-15-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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
2.46.1


