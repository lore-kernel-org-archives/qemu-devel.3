Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C92ACD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:16:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ6EQ-0008N7-SA; Mon, 15 Jun 2026 08:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6EO-0008Mc-1y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:15:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wZ6EM-0003Tu-Gg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 08:15:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso42731805e9.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 05:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781525753; x=1782130553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HArTwgODQoYaXXWISLaGAP/t/ZOAHV1MrGfG2day6lw=;
 b=HWlCdG2WfI75B33giHrMFu5RaiOufVN5+uBoilNLBH+i2SV379LyyiJZEWL4sqdtyD
 0F75npzDviTSODi/85dJh3i3Q2PCil46ug339/n93yVtLYI3ZYaU3wq5pXn0ACcbH2H/
 gvU/4usjirD+VrlXBQ4wVz9034LuS+3YcIJXqzNvkfXo9niCHLBbVMZs3hPXxrdN/Qko
 6isiZV/luj6FU61jWRwE15wgwMTtk3/1h7YYLkrFloTZSjxtQU5P2LmXTTHkS1bRqsfF
 mahOBpAL+JqU92nlFoUGigviVpQNyBT981jyfMOQLMCOjWOJ8jWJLIroxBscDIVvAHN7
 Wy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781525753; x=1782130553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HArTwgODQoYaXXWISLaGAP/t/ZOAHV1MrGfG2day6lw=;
 b=mP0B0Gq+F15WcmWsHDOb1tCnPPdX/PhKTIq0TJsO66CvhOyYV3yI6fDQOjoI/LNEm2
 /cx+vhv9nYvKsaUQF+yVuBtqnePfgg5exQgz2fVdNZhKwtUu+PMBZF5gBB+kg80nxPua
 UETsA44IrcVsZ4yl4DhPe/SvRjKLT3umA2BBHHE5NzxHnwl1jMJn45qo7UFZJIN6Xl7G
 T5x51iwxOoRsuNSph0MMP1o2DETdC786rTfy0f8EZe+bMUTikpKV7tlLtd1Vt3Rzzofs
 dG/qi6PmaCfWOI6tFyvp2EkVk5oKaRWZJhaFDSl2SmVFxC1q7dJ8WlBs1eMmjKhFmd3Y
 Ehig==
X-Gm-Message-State: AOJu0YxcVbawfHR83Sk+By8u1SK/6lUH2jb97AuNDMDF193j/7VLVcvz
 DQ7dVohxh1gvkYUUSSv2WbcqAUl2nHLnd6++HNGaOSA+sigWGZyNxgUK2r4+b1De
X-Gm-Gg: Acq92OGsfj/HJLxOQZoEZn7pwnJN3xPkY+wVjqnDgZZIJcs47RqsD7183Ta6oRaObzQ
 CN7k2vSqVrhJHq04HCXK/FmxY9S4NBY4Vfdx00kfKLKUz4BFxe/jCs4UHPVyJ8FMkR2KReL4N/C
 lo0a6UFWFkoAZ92TQKbdIm//kpKZSRKmUx2KZuJv32OUIwUR0tvzhVGSXXIStzlKIMvKl/fePtp
 ICQD/EDNKEs7fsbKHk9QvjblIS1k6lO123ELT6XN5YVnqjw17cdbtLLVp/q4CpqONj7OFIRfiUT
 34GLFpyHAro4AR/E7MlIcyHiJ9X6WI7efKMkZrE+zaDzq/Q1DbQdp6meO/xFgveiskdNRhP4NjF
 nFA4SL++BrvNcAie6BcHNzJk3l1vdFIW9J8PNJdpsngLjHZSaJbOutBRstbWfRxdy2jLIV3jHlZ
 ZZ6oJSgahB2QUpWwuOJp1aVMzW9caVpC/E1s67hStQ2FadodWP5GGXig==
X-Received: by 2002:a05:600c:4709:b0:490:5057:f5f7 with SMTP id
 5b1f17b1804b1-4922007472cmr130246035e9.11.1781525752547; 
 Mon, 15 Jun 2026 05:15:52 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm338491345e9.0.2026.06.15.05.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:15:52 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v5 1/7] hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
Date: Mon, 15 Jun 2026 14:15:01 +0200
Message-ID: <55ed0f719d944a46a46350ce010503b30afe61b0.1781111270.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781111270.git.matyas.bobek@gmail.com>
References: <cover.1781111270.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32f.google.com
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


