Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B3D6AB16
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 21:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Q3B-00019v-1w; Thu, 02 Apr 2026 17:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2g-0000CZ-UD
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:35 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w8Q2d-0007Fq-O9
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 17:57:33 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c603ec2dfso58683966b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 14:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775167050; x=1775771850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyNt2FM/nxiaEh/tMXSTA/gNyXQ+MKhhy7At3qeZl0Y=;
 b=M9/eZLPomGtcsugBEFR1+Mu6ESEvHI4fZ71k3pydWdqRHlTM4HdgSl1yDb7cArXMY2
 u5QxEGvu9/r45rOxVTbeJ8+UCXsOI6hNM1LT80yEFWwHl6khPzaIl7jDyjO6E3iHn6rg
 leh6REH2EB8paeQqi9DCxKzlslvpGNE2+qLKw5pRlqNXf1IL5ZweFQyuTFmGXmnL+V5x
 +paEW+16BLGf5VEkEpDRpQVx/h0yRtnn52w4Y5x8rm6UroMzaOjZRTH++t6xbkGedDG1
 YiLheaIdL37hWSV9HwHz7OhPVnYFplcksKEroL0rbO6exIpkxGkWeyXAImp+iym/RurK
 u5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775167050; x=1775771850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DyNt2FM/nxiaEh/tMXSTA/gNyXQ+MKhhy7At3qeZl0Y=;
 b=XVXBV6wh+mYmXdQJt6XiB/OQPjKjEBWZDJr5qN9CJuYfzM9PJBxNf+Cq3mT3f/xAVY
 9OUNhSc8r1pWF390/cavNkIsL25SwR41ARgiDHlEcbfisLuxr9FjBDrNDhaYos3KAOvK
 RsBNR3ardHLqufJoR9guEfHIHikbAb42xBhE0dJVc0gveQWEVRonqoWaIasbXTrxBf2D
 +ezk0TzurDl1cbSqs7o9LnTVxMRl07Q7koKW3/oPrTXElp+qAPd56H2zc730mezcKtT6
 XknrTrPnwNWqxKbExH/lo2OFyT+q2HCZTGhH8ApnItZWEoHwGqjadbFFZAzbJOM2xYOx
 XMTQ==
X-Gm-Message-State: AOJu0Yx/XrBJ5p5AgA4m21ch6TnA6DYqqo+W4m6daUAVcev9sPyS0J8v
 JSWgllvnYYbIttfVq3xSHFyzQCTYHetOlteF1xpKGypy37nYEmu/uMH17ECIDdWM
X-Gm-Gg: AeBDieub1sDtnYBrXh4DdM1VG76we3YBWVykhWwTusNtB0KkMLrywjyJ2ZVDR2a9WWb
 JX4DOtfiOTgtYZ/xGRDWtrkpG1znJ0Uzz8XCvJWTL+C96BC9m96eTEoYbuEoAyaiTvRFNKi8iD3
 vwWftdPbijDqOO0MZ+2wRPfmKIMGLolp3q45ElXNIzomOLz3EdTNjUgBABEzGIdMlu6ZTONwPog
 eS1c2X63lnYZ6SZybyl2YgIR1ijfeqVJjBEFHBiH2wPj4UO1r1MLG4r8iuSm4nFIa+vCKDvuyy1
 zDuhWrhLe4RYWIWBFOG0M3pZyAgVLhe/1AHjT8wh3FmFTrIId3W0SmWnQ7josT34+98IGXmc4Qa
 a8A3ABEZbUUy+RDS6Knbp3R3n8BtSOngXPUOOZHbsbP7Xj5NjGParbvUntO3kv+cznXo/ACUd+u
 0Q1eIx53jKjp1ULp1c7qLruX1hDm35ZJhhrxmKtOA/y+e+MXxQV6Feo+hm9A1wH6P6fPEnOQ==
X-Received: by 2002:a17:906:6a1e:b0:b97:feec:5e82 with SMTP id
 a640c23a62f3a-b9c67b83920mr26615266b.43.1775167049656; 
 Thu, 02 Apr 2026 14:57:29 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-182-244.adsl.net.t-com.hr.
 [93.143.182.244]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b9c3cac0e1asm134009166b.27.2026.04.02.14.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 14:57:29 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v3 27/33] hw/core/fdt_generic_util: initialize serial devices
Date: Thu,  2 Apr 2026 23:56:12 +0200
Message-ID: <20260402215629.745866-28-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402215629.745866-1-ruslichenko.r@gmail.com>
References: <20260402215629.745866-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej1-x631.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

The patch adds proper handling and registration
for serial devices instantiated via FDT.

The devices with 'chardev' properties are
connected to serial backends, if corresponding dts
property serial id number is set.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index f3a47cbafe..c92b5c287b 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -37,6 +37,7 @@
 #include "system/system.h"
 #include "system/reset.h"
 #include "qemu/cutils.h"
+#include "chardev/char.h"
 #include "qemu/log.h"
 #include "qemu/config-file.h"
 #include "hw/core/boards.h"
@@ -721,6 +722,13 @@ static void fdt_init_qdev_properties(char *node_path, FDTMachineInfo *fdti,
             continue;
         }
 
+        /* Special case for chardevs.  */
+        if (!strcmp(propname, "chardev") && !strcmp(p->type, "str")) {
+            qdev_prop_set_chr(DEVICE(dev), "chardev",
+                              serial_hd(get_int_be(value, len)));
+            continue;
+        }
+
         fdt_init_qdev_scalar_prop(dev, p, fdti, node_path,
                                   propname, value, len);
     }
-- 
2.43.0


