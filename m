Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E05CCDB475
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhCM-0006N6-Sj; Mon, 22 Jun 2026 12:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCI-0006Gx-Nl
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:31 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wbhCF-0006ip-Mp
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:08:30 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so2950752f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782144505; x=1782749305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HArTwgODQoYaXXWISLaGAP/t/ZOAHV1MrGfG2day6lw=;
 b=Va9c1W/HV3tgyFl0CN/eR199kC3qoqS/vdrWwAXyAXP9nXuHy+EBTpi+oC7IDXg2Mr
 sA18XKlGQgIk7z6/wb7sMNdjpzl+35bCIT+N8veVlQfK1q63Azg4xjeoIuxYrqXbJwAH
 MS8skOsS1I981JAHMSYkxEcGjLw1pY+Y13tVo43hOViN85IYhV5tuyr+KMkBqIBFSFzm
 YdxqQwK3JTgpWVGkajaheSieY9apBJlMVezSaRNFFfE18cpwD4b3kwRPazP3gy22LcOa
 nWohVzaOzOPuwv8n6CbSflb+LlMYa40YVq0fsEw3GuXA7Y3VJtLUfm6RwCbV7VnsLjVD
 kwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782144505; x=1782749305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HArTwgODQoYaXXWISLaGAP/t/ZOAHV1MrGfG2day6lw=;
 b=WLDDMktl0DodQEJdIekQcx8cd+5GCjQiMwFLU+WO/yv6hRLgFDkhgR0m00QWW3ac8x
 W/ZSozoKur7A0c+md9/KeqzhlGJZe/ctKRJ0odFq4Q5NIezR0JSsaEAECNtQaUv+df8W
 BfokHeYW4D5SbVe8UxGqKIeRk/3kwvFrp0GZR0D4DN43ivgc/0CNhdjTYy9LJfYUzPHg
 CNFNIQ8qBRpul0OdTfQe0dH+T+6y0IJCN7BsbOZy4I+iXNCcrHfTm4SNbU4kFRi6P0pd
 3qHJXrjGV/qA5Ocn5MyDDE4cIceX/ogXSOR0GQpGeqvEPGF4yAkVJLdoEoFWk2DG2Lej
 QOaw==
X-Gm-Message-State: AOJu0YxL/nBnGvgWdeNb8FLrZuzHZg/nePO7dtXLytFbREyQzq20hq2V
 qh/e8exy8jM0TYrpkq9XoWlGRUUiKMygTcWsDqkUkRu559UuWrbqDxkkfdOjuKEB
X-Gm-Gg: AfdE7cmj9MBImMFynnGn3LcoQrv7iLeDAY+litsHzHnINPnm08DU3HdJ9EwnY3MtSlk
 FFnaBT8E3+ttkuLn9PGE5KVCLi0yZ5VUfdnViAIwS8XJt+TkfsA9AQ3Ncs31BT7N8b62Avd7CLZ
 NlvBZQ2UVPgx0ScgkykktTmVaYpb76iMPbH/zcNZc1ajDfNTbDE9t5QgFRBExhaKjkADO9qFxdz
 WkMzvpbMRLEqQJrfCpr8+SbYxZ3rUUhEVQ/J0ahv7uyiDK+tGw4CVMJso60pvVh46cenPZsBuPh
 y9gRPlXAG9C/fKaCMpEZCQPYaeO8wRyza1iH/WcPLVyPLa5kuB7p+7UwSOaOqRnoS6MBFr3W+fj
 kaEjDcsBRyF2ZXD++JBLHmtK+7nElHEEmcLaUAg9ELvhdGvsRJVXHcFyU+yh+m2CU0XVnB/fqRx
 +joFn8Q8JGvLZ2dFFj8AyOgkuZ84N5Kuy6p3TbSRiDyeE=
X-Received: by 2002:a05:600c:203:b0:490:bf1a:ed04 with SMTP id
 5b1f17b1804b1-49240e20f3cmr192149825e9.1.1782144504592; 
 Mon, 22 Jun 2026 09:08:24 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm225062545e9.9.2026.06.22.09.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 09:08:23 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v6 1/7] hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
Date: Mon, 22 Jun 2026 18:08:06 +0200
Message-ID: <629d00a1d8712dbf293fb13ac1a02bf80f6334ca.1782140438.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782140438.git.matyas.bobek@gmail.com>
References: <cover.1782140438.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Open code the DEFINE_MACHINE_ARM macro in preparation of creating
SabreliteMachineState class.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 hw/arm/sabrelite.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index db5669c5c2..04484aaa14 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -104,8 +104,10 @@ static void sabrelite_init(MachineState *machine)
     }
 }
 
-static void sabrelite_machine_init(MachineClass *mc)
+static void sabrelite_machine_class_init(ObjectClass *oc, const void *data)
 {
+    MachineClass *mc = MACHINE_CLASS(oc);
+
     mc->desc = "Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)";
     mc->init = sabrelite_init;
     mc->max_cpus = FSL_IMX6_NUM_CPUS;
@@ -114,4 +116,18 @@ static void sabrelite_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE_ARM("sabrelite", sabrelite_machine_init)
+static const TypeInfo sabrelite_machine_init_typeinfo = {
+    .name          = MACHINE_TYPE_NAME("sabrelite"),
+    .parent        = TYPE_MACHINE,
+    .class_init    = sabrelite_machine_class_init,
+    .instance_size = sizeof(MachineState),
+    .abstract      = false,
+    .interfaces    = arm_machine_interfaces,
+};
+
+static void sabrelite_machine_init_register_types(void)
+{
+    type_register_static(&sabrelite_machine_init_typeinfo);
+}
+
+type_init(sabrelite_machine_init_register_types)
-- 
2.54.0


