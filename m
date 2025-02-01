Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B003C02192
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 09:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te9bR-00011P-4A; Sat, 01 Feb 2025 04:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bO-00010X-FL
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1te9bM-0000T3-Fs
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 04:15:46 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385df53e559so2012779f8f.3
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 01:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738401342; x=1739006142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8SVQMLAYnWYkem+1LN8L06NityQ8o7wifm7JnMwf0uI=;
 b=lPGuPTiJUKu+0n2cQOown33woOMIiMmBuU7XzF1PznHq+zbkkdhFVq+6IcKHawX8MO
 3n2xlRy+xGQja4os+9aejjAqp6P4E1jcrWeIyVX2BhKApaJm5QwUdoru7BoQ2dHr33sJ
 gf+KuUPyZYIOQUCWqsSgCnQdOnGxPpbFg5X8ygcFteVlgY0+r43FjK/0cUyrhG7nyZcO
 CbxpPtX+Ny8rfmY1bdsOkA2VEAKY6zxp0LhFsf4u0b8nfZIaobSe3PzXhPaKZuz5rKYk
 Zm7u+DHM4E8C+oRmg2DaNG4iapYy99NAr16+zj1A+fZZaE9Dbym+mWAdKuojdOGva4Nv
 HCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738401342; x=1739006142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8SVQMLAYnWYkem+1LN8L06NityQ8o7wifm7JnMwf0uI=;
 b=ICQoT1Hwjs+3NxzscjfmIBrnD0v5Yy73U+068z3Rz64NM5+/X5wenby29pGTfFulCm
 6m1NXxeG6LhE1D4Spwch1TaThaJwST+TRoikEF+ul9yyjhOIfpUY3vsVgihVhb85rZxW
 ot1OehW8zr3h/+JVuAGup/jrUN1tOr8SUGiT0ceuHNM3iWIHwSRB5ZMLgQPVs+pNHn9e
 352GOPDmHXbJafyNNCi/Gukq7oPMKBErZRXJw1EMk/XzFIAfI9CwomLqjS/LmC/JSC0B
 a9zsuX2daGRtRPkfbnvkVo5Zbq/cczW6qY0T6WY9FSaRg08AE5TmWmwJQFC6+mM2O8Ff
 IRNA==
X-Gm-Message-State: AOJu0Yw9nypwREG0rEm75zMDbZOMxiM6/uRdeneA3fC4r0zKjv5yevHu
 o+3LJ9Bxnvo3OgWDBl4ChW3JnTgZdlvB3AlM5djWlxeGu75DvUc/VytGFNnXaM7TrGNBsjEe8rf
 kQ54=
X-Gm-Gg: ASbGncsSjxXxJPpTxwOh6U8kv0JoRiuE+p9HRwb/5mrHw/IY+lD9Pmp6W0JQdjiKoYb
 zTyIDZAVmKTi7KdgY5GK84CXHe2QcQY6hMx8AltmOjxeZu24EGsukZ6gJNHYVTyyr9Nxe8jqzyE
 /3rMiLCreZSqOSwYHDyNXdIZQtXD0Nd0BOTUj+UXkYdMeVCDqHC38ihHFvYo9GZVchqJvce9CDv
 Q6IUXUYoBtyNHIlppMdymzGwx5kquG6Otu9S+t+0WIPSmYy82GC43Wg+6BpY0ZbAZAM5QjHr1QH
 CMXdpS0X0R+x4qJMqkvP6YiV5ZrTSpaas+21xcEr2zTzKKRLrVvgwZcbg4jkKGGCcg==
X-Google-Smtp-Source: AGHT+IHRXnkkbk0ZZQ6tl39QprkH5MxX2Z/uA6l3tQp41XDzBDESwm20wCvmraMaIqfRDq30jGNxmw==
X-Received: by 2002:a5d:5583:0:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-38c5196fd12mr9884961f8f.33.1738401342505; 
 Sat, 01 Feb 2025 01:15:42 -0800 (PST)
Received: from localhost.localdomain (232.170.88.92.rev.sfr.net.
 [92.88.170.232]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc13151sm115999295e9.1.2025.02.01.01.15.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 01 Feb 2025 01:15:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jared Mauch <jared+home@puck.nether.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/7] hw/arm/raspi4b: Introduce abstract raspi4-base machine
 type
Date: Sat,  1 Feb 2025 10:15:23 +0100
Message-ID: <20250201091528.1177-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250201091528.1177-1-philmd@linaro.org>
References: <20250201091528.1177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of adding more machines based on the raspi4,
introduce TYPE_RASPI4_MACHINE. Remove TYPE_RASPI4B_MACHINE
definitions, declaring the machine name in place via the
MACHINE_TYPE_NAME("raspi4b") macro.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/raspi4b.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 5c78d26f957..548059f6d69 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -23,8 +23,8 @@
 #include "hw/arm/bcm2838.h"
 #include <libfdt.h>
 
-#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b")
-OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
+#define TYPE_RASPI4_MACHINE MACHINE_TYPE_NAME("raspi4-base")
+OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4_MACHINE)
 
 struct Raspi4bMachineState {
     RaspiBaseMachineState parent_obj;
@@ -93,7 +93,7 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
 static void raspi4b_machine_init(MachineState *machine)
 {
-    Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
+    Raspi4bMachineState *s = RASPI4_MACHINE(machine);
     RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     BCM2838State *soc = &s->soc;
@@ -123,11 +123,15 @@ static void raspi4b_machine_class_init(ObjectClass *oc, void *data)
 
 static const TypeInfo raspi4_machine_types[] = {
     {
-        .name           = TYPE_RASPI4B_MACHINE,
+        .name           = MACHINE_TYPE_NAME("raspi4b"),
+        .parent         = TYPE_RASPI4_MACHINE,
+        .class_init     = raspi4b_machine_class_init,
+    }, {
+        .name           = TYPE_RASPI4_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
         .instance_size  = sizeof(Raspi4bMachineState),
-        .class_init     = raspi4b_machine_class_init,
-    },
+        .abstract       = true,
+    }
 };
 
 DEFINE_TYPES(raspi4_machine_types)
-- 
2.47.1


