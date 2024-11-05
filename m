Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55083D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMm-0000Pb-2F; Tue, 05 Nov 2024 17:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMi-0000BV-N2
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:36 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMg-0004Qw-Rw
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:36 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so4524215f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846973; x=1731451773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RfsSAg28LXuScwoije6ppSHZyCgl4l8pk8ov2/9yx6A=;
 b=nkn/tfYcjUpPUAvSpGjMt9WRtLR0xRPd5eLYBukTeOf7uvhSHTybc3/LnV5iXnEE/S
 k4MIcrUHUXnCjaRByFxC36S6QM6zz+0/Zxk0H1ekXYbPfhOzNqBvJkR2Wc+PRL2AojRb
 dnJ5jgbGppIkmHMYuiYFQXmgJZlKd2te7lsmf5hBaMHPwNAtUB2s63X/Uuq69iuacEkq
 3lh9n090tJlMs4uiQM/idH9QK6XIkxBjGcQFbKuACRNtzmkAaCoJvAEKkmX1NMg+3sAs
 9l9X0LRh6aVS7cXF5x1up1IUwpV2MEYYjUnr3vHrChTWHM+vMrZm4c2gNOSVyIYyaTSg
 Cx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846973; x=1731451773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RfsSAg28LXuScwoije6ppSHZyCgl4l8pk8ov2/9yx6A=;
 b=Mk/tydvfFy36iMqGivvzYDUe7khJ6RJ59Tc70gjNspf8ToPafeNmrd0512M6fbehOd
 aEP3DLHUOxKCCXIgfcSSFDrh06CerqqsPthosaGyWuiec9Zb/CMnK8ydcleARzwUDGYg
 gbDbo/GFmMuafnWGqF/PlxHZFYLfgDbHAA593PlYlRREocmIKB+0y552Zo6oicgxCqP9
 pPhkHsz8mRychc7PtQXOk7O24NRPnLlr0/K1lethSmzkMbb8IXCIOh+ruOH+r1OhbNom
 Rljg6NCQKxPMn0smiXV5pZ77W1PMZMDFEJRtOdokPseKyQaCcgjCQfSKCDKeOLz90hYh
 zhgw==
X-Gm-Message-State: AOJu0Yyy/GpaTHz/j3Pzoqf03rNT2PCjiqWb308Y+Hlaiw7WEJhudZDL
 lht6GfpFprMyYHO1XZ2Mt9iXXcnYZvbRWAZjonmPmvaRA76T6qH/zJOJP62YlRMKh1whC03Imnq
 IEsQsrg==
X-Google-Smtp-Source: AGHT+IHbJoMmP6OzSS4qr9eurp7Nh+8iqhBqSHp2oyV1qS7LPCwpLm8dwI+Owg/6azbc640Pe2j7Jg==
X-Received: by 2002:a05:6000:e88:b0:37d:4f1b:359 with SMTP id
 ffacd0b85a97d-38061220a5emr29787052f8f.53.1730846973087; 
 Tue, 05 Nov 2024 14:49:33 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7a86sm17294816f8f.22.2024.11.05.14.49.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 23/29] hw/ppc/mpc8544_guts: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:21 +0000
Message-ID: <20241105224727.53059-24-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-19-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mpc8544_guts.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index c02b34ccded..e3c51458e69 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -18,7 +18,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/module.h"
 #include "qemu/log.h"
 #include "sysemu/runstate.h"
 #include "cpu.h"
@@ -141,16 +140,13 @@ static void mpc8544_guts_initfn(Object *obj)
     sysbus_init_mmio(d, &s->iomem);
 }
 
-static const TypeInfo mpc8544_guts_info = {
-    .name          = TYPE_MPC8544_GUTS,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GutsState),
-    .instance_init = mpc8544_guts_initfn,
+static const TypeInfo mpc8544_guts_types[] = {
+    {
+        .name          = TYPE_MPC8544_GUTS,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GutsState),
+        .instance_init = mpc8544_guts_initfn,
+    },
 };
 
-static void mpc8544_guts_register_types(void)
-{
-    type_register_static(&mpc8544_guts_info);
-}
-
-type_init(mpc8544_guts_register_types)
+DEFINE_TYPES(mpc8544_guts_types)
-- 
2.45.2


