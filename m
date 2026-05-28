Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47ACCD6E45
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 17:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSeMl-0006cS-Db; Thu, 28 May 2026 13:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wSeMM-0006TR-PR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:17:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wSeMJ-00046Z-Pz
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:17:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso84192165e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 10:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779988646; x=1780593446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HArTwgODQoYaXXWISLaGAP/t/ZOAHV1MrGfG2day6lw=;
 b=Afp90UcRSByqxn8a3+HUxQt6poAfoY4iV3X4S4Jsia/AjU/yMZVeFEJV8dNarNpf8+
 tuN2hXtbVgyzs8Pw4sJWAMXb55HMTZfYba47UZCqnxz+Od2e2YcaM5fINwkOVTUYGYV5
 I1ZDvBHCrjbzz7XkbX5ZqXUDhMwCe16fMoBAisAAwEhxTMRFOuV3PxEdWeyhJo+O32PQ
 9arXEEKbZ7BGxG5LnerYjUHHhCRBn8bg/k4NLcM0xOH7rJYbkz4Cwm8FxAZMgoNJGu1V
 N2ojKSTfkTw1u7pXMSgSLT9wb88UK5JQmQRgugCPT1/IaOCjeN1YczZheQmpKWAwoBIq
 k3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988646; x=1780593446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HArTwgODQoYaXXWISLaGAP/t/ZOAHV1MrGfG2day6lw=;
 b=kf2mhX+1km7KuxwZP1HPiD6genpal5wwN5WRB4z1P/v7NpiDoZqsSmrud0Y6hDgCor
 RoT/zLYL/Z2abFUkvZNqHmwXOxO9wJqJ1BjhKWUKVGPlHoKwc2Njh6QryEhSU8+xQpIe
 6MkftlRZaU6CUX3QjXTQej1ug8v6uqU84+KCXUFAgImspdeVLdPTpEUjhNjknIdU+xGz
 /2HNV6hr2+LFN3Ejgmk0khbQunQ89oP7P7zZDS6YlFNEbC487lj7Qw7hhcrV4G5zZlN/
 xEFQEZEap7NFqOEcsWYctVBQPdNzU6y9ETN1Gc3Rjpbd8LEQw4Ofe7OZCi9DaAIyMfqw
 0iNA==
X-Gm-Message-State: AOJu0Yzcx7J1kqGOt5PnFMrYrNM3DYtUF+kcO4a7ua1nALf0zbtCMex3
 r88DcpPqNrpndlKyPMjG3DCmFNVWuTf/YKDN6LH9jrNjNFX2aeT0FoC9qFfq68Ek
X-Gm-Gg: Acq92OH+NltaXtDamzssI1IHzACGWUKDmDcFgxOxx+i5Ynry8R7mUQhXcm4UxzIv3tS
 Z1YdRCtM02n/a8jyJBqKJzF1Wa43q+4vBmtX4t3HO+O3aQkzJzPOe2PreqIfjPf/S66L/5G9591
 4ls3L9lNWEz6WvJ3KPn7IFgjRQsXNN0BU2EbNgdoK2d/MO5F1ovi87S/2HsqP2ygZLb+NZvgfoz
 RxywgJt4e7Rwybp/2iHblF1UF2+HTcZgfLO75pHLCFH4EpHQGoNthZhk1wY+jevTrsmzXJ6/NGV
 6KoX0scz2ZHthpUUFQx0hlxwxzT4UjL438ZutOWZThiGeMuX1ffAJgx603KdCuUoOKWhU3K1x5u
 LZCG/C51pW4Cyo8SprjsaSJ+EAT5ZjNhsurBGggaqsUcMB8woILipOQeQWJ2itgX2taJ3EvtTkt
 Jct4abtdTef0IQ/q/CoF6MUJZ9CIb1kkA1qpps2f3SZ1KhBg0JP70YE6TkyZN+hFpN
X-Received: by 2002:a05:600c:c3cd:20b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-490428c97a1mr328552935e9.16.1779988646074; 
 Thu, 28 May 2026 10:17:26 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092968066sm53774085e9.15.2026.05.28.10.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:17:25 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v4 1/7] hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
Date: Thu, 28 May 2026 19:17:11 +0200
Message-ID: <8c31da0ef6b6c49d9f43979040f0a723632c6c4e.1779986496.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779986496.git.matyas.bobek@gmail.com>
References: <cover.1779986496.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32c.google.com
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


