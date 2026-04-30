Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612DDCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIW6a-0006ol-Au; Thu, 30 Apr 2026 14:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW5i-0006WD-A3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:34 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wIW5e-0005UF-B3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 14:26:25 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso10979865e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777573580; x=1778178380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjrEUWzgQ3jtROLjE/XI5eJeSsceU5zngdQg8kP4PY8=;
 b=j+4uKgOlC+cTVRPwmjYT1KX5p49QyGP4pNrVXyC0CPV3I2j6kfGQe1rH8x+r5pRibl
 vZQWv1Is4YH1ZU87kLu0tc/qJbTDvinMF6lRZ9lx9P2PHxAS4n0CNikwVpyOB4RvAGGi
 TC0C5K+zioczhtnHuW4fg6gmMNgRJTKp6qQWtznNU54lgxqR+H8BvYVlSi6fJyuaU5tG
 l/rO0IMcXGUaX/FHZ8338lN2S1cVgE/BtA2qo47J4XrdSnjzsDp0FDKNzr/VctiLmL6m
 /jvQscTiJghdBTiSqYl9NROThwduqHY+bsFNENwkv/qSHkHt81ZJ4I5tRFxQJUsBA3WX
 DGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777573580; x=1778178380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cjrEUWzgQ3jtROLjE/XI5eJeSsceU5zngdQg8kP4PY8=;
 b=VdKY/KKoKxPn6TQ9RtG2Fa1QdsCOYx10evBOkXdcK7173EuhVjJT6ymVAHE9zwkLHf
 0t6C4XpmdmfP6vY/0q1aMApbZuP4n5mcniS5QnCPE4FqeBxhjY4odKwClrvwVEUwEAv3
 vfq3D1GDj1jUaGenOT/uwiARYqVTqxJnP0mCYkgjYQ24EqzfNPXEn7YI+Y7zKg6gEBGL
 j/3PSF4RhblUrarcL73E89SINpoGx3SWlngu/HNsZIZlw7nDd4EnQB2BYwZNdDySZrx2
 +dZMK01eVeEprwVIp1qBTjgeARroiNjupHGSh19TAezAtm//nIscBAmxrGbo56XhNYaf
 0Bhw==
X-Gm-Message-State: AOJu0YyaEq+81OZ+JsUYTKYjZ1OKiT5nLbCZJKyttW/oxroU9qtTYuQ0
 Z4s2NJVADEeJZoAV8fgAZ7rJk2XeVqymUV8bfkKK7aE2iEqVECkBB7N/NtXaxgRE
X-Gm-Gg: AeBDieshihInslV/Wkz6z+PphsWfS0hnR4KzftqPsFCzsv7XoesAFVNV9B6ojsDKVlS
 zKemodFOiBnVRcHblAs7vM/Q9HotVPF+mXh4itGu5T78bqIItfRPzWauZKOCV1jn2QPgQS8cDZ9
 +VlpVPqSa5v90YXxqiMKKHk4TkXpmM9rK9jwVQpAZtadJyQXZQfqERUvRDSuQGd8NSc7BE/I7zN
 N7+9KHCGatOyfmfPouVC0+Rb1UxpvT/b0jzHWDcO7wzJd8/MkGXJ7KlfA5kxhvMjU+GwO04qiwP
 XsV/KAR9touUzQ/5fFjyvwxH3GX8mzSl5rEd+fMS1mpNWjbkH3mc8Vd8Y7tYSN3DzadWhKloXQA
 Gr/Br7aETibMK295TZdpSj8cwpFWvM1CwcmkdDE5nlKUBEPBdjHTKUvS1LEh1b/sWbHtKB/o04F
 cSJXOkI2GkS4CHGmdjGaTB7TXV0Dhid0WRRfVKLwWNBAudGIlm8ElciX+DdmglDocfSfEQbIBYn
 RI=
X-Received: by 2002:a05:600c:4e55:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-48a83d62fdbmr73935545e9.4.1777573579959; 
 Thu, 30 Apr 2026 11:26:19 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c00sm14674925f8f.25.2026.04.30.11.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 11:26:19 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v3 1/7] hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
Date: Thu, 30 Apr 2026 20:26:03 +0200
Message-ID: <369e80856c6c25fc1b1f7f41362026990d2c2c24.1777571962.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777571962.git.matyas.bobek@gmail.com>
References: <cover.1777571962.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x332.google.com
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
2.53.0


