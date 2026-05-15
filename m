Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A444CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtFf-0005LV-SH; Fri, 15 May 2026 10:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFd-0005LE-HM
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:10:53 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtFb-0003hx-TN
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:10:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso8505425e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854250; x=1779459050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I4rD0JsU0v8sUryGuK5c/TpCd5rAdC8CkA0JDnYNcxc=;
 b=GySPiw56T4kE83p86/djrixAxURlrRWYr1sZcETyLPMDwMkBDhshdo5IzzNh8qXKoZ
 m8PCH0qWyzE3O2Eu4rvzitKiSx7/2If9meowFKeJSpcRWz3mmwOvHJwfuwleQoT3o8qX
 fGSBW6ySlUAvbfY05zvfsz6a2icbxXLmtbBwydp7OKl9tfPru9O3q6Vr/GsvKW5AE1Lc
 iIbBCaW6cBanHw7jZg8WazWY90ChkXr+rqxO+0avvDqFzHVWJ0bL7HNDHmK1Z0/9QtIc
 hFi/UAGfmwxqHVbxZQ5YfT0RAtxP7Stv/T+WlnVaD3sT0y5SbNtZSLCx6L5DDGRZ8n2v
 MNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854250; x=1779459050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I4rD0JsU0v8sUryGuK5c/TpCd5rAdC8CkA0JDnYNcxc=;
 b=KlWesVVM/QHPfnDLOu5kFi19GdjBd6I62MLP1A/CMF7GO7fL0kNFgwG82hWnvBBoha
 i10PY2WSFzrCGL1hxX3+t0Z0vcVjqHJLzjV7WB+LUQxLlY0bfDw9JrCl8uTzR1sBYDPH
 yTnhGZMg79UKbIaHzeT/3mv/PJNEs/jE5aAvB3A7f0vtgeXuz3yQcfgIruRBHEhjFfZP
 7nNy3NAgytojRCP/WUVkV/Mx181OICIANviHoDzOeqXLx00T4l1IugXFBVUc5N/IzLxo
 20UpUqyQzRX1e+zQKEwYa/3l0mCA7/vZCXO5gpTeY5kSI5odOmGKLGnc1pHHflPUIO21
 QJ5g==
X-Gm-Message-State: AOJu0YyvnPplEvZiLZn5LF/Zt02Tj5tZK2n4WaR2JueXsonTVU9FcYB2
 ncgb5GgF5Un0YBt51sR7IuRjeSu7z026D9dbr9fpf28LMBQ5p6T2oKzOrG5AoYe3b8IPTIoAUR+
 quNfqfg4=
X-Gm-Gg: Acq92OFA/CkmVH9fijfVhWDXAl/ZjqtCOLOS8I1oIyAMNrA5RFWfmMXKe8A0guZNzx0
 3ffUtUsjCzVIAWEv54TE94ZSU4m0IUWpw+Ys6cV6d4etGR1+IMIvIL+0JZlU/Hk76WQ1QLdwvgZ
 KA5XRbr0Buod3jAIA9RjeGavKNtp4aq3xHErPxE8v6dqfNTJ4eRkR9oxfAAyatj9gVfFHOX6AfQ
 1NAA5s92IFMjmsvIWf2VrczaW+qNR46c45V/pd/6Uyhq+tQQTEzDqMSUtL/0+3QQMp8bY4C3yiu
 2k7AHrj48gqO3BmHBjKRUKpk1qBcO70bBQOtoVo5VfKdxljwKvVIMaI7um145NFyUhGTVNLU2yj
 V2L3D/vDk8VWUNuP/RMlYN9lFzPZXS1wy3lVKYzfOw7dig29e/MiaZLSlMlt9Y5vFN6vJpydvXb
 sm6TCnw8Ls5qVrA+o9zAuzWwOm5s1dpFwf8DirT7VHpl3/DpAFx/yA6rXRP7f0xEYDNxmqvDqM
X-Received: by 2002:a05:600c:5010:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-48fe5388407mr53334305e9.12.1778854249776; 
 Fri, 15 May 2026 07:10:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febf8305dsm19915945e9.9.2026.05.15.07.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:10:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 02/20] hw/arm/raspi: Initialize 64-bit CPU types during
 DeviceRealize()
Date: Fri, 15 May 2026 16:10:13 +0200
Message-ID: <20260515141032.3271-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

bcm2836.c models 3 similar SoC: BCM2835, BCM2836 and BCM2837.
The BCM2837 is a 64-bit only SoC (Cortex-A53), only available
in the 64-bit binary.

If we build this file as common object, all BCM SoCs become
available in both 32 and 64-bit binaries; however when running
the introspection test on the 32-bit binary, the BCM2837 init()
method tries to init the Cortex-A53 type -- although not
realizing it -- which is not available. This can be avoided by
deferring the CPU type initialization to the SoC DeviceRealize
step (this is safe because nothing uses the CPU type before,
only the GIC access them, just after their realization).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bcm2836.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index ee2f44debd1..03825e69d06 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -25,12 +25,7 @@ static void bcm283x_base_init(Object *obj)
 {
     BCM283XBaseState *s = BCM283X_BASE(obj);
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(obj);
-    int n;
 
-    for (n = 0; n < bc->core_count; n++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
-                                bc->cpu_type);
-    }
     if (bc->core_count > 1) {
         qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
         qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
@@ -65,6 +60,11 @@ bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
     Object *obj;
 
+    for (int n = 0; n < bc->core_count; n++) {
+        object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
+                                bc->cpu_type);
+    }
+
     /* common peripherals from bcm2835 */
 
     obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
-- 
2.53.0


