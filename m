Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61868CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qs-0005zU-JL; Tue, 07 Oct 2025 10:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QY-0005pU-1A
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QI-0002He-N2
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:27 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so49724485e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846326; x=1760451126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tGVyZTzYATyCeTWWOlBiNol/uabWyBP70eHig5Rs8QI=;
 b=HoCgklq8a7307Ym8pLYYHzbvjq6zQWh/Oi/Tu9l//Nh1TW/ntsqXuIqUHCGYv+Qgmp
 DN3/5lXvMm5ab+II2lsaAUsGhUZudmfJJlCzijGl8peQdSdZ6L8t+a5U89dUOTn47gJi
 dk2ecB444UkRKWuFULuFvAMhA7Ow2sEUgxAiDCWwiVJKWFtqDxbbt2BqfePaLdSef819
 a+UFZIqLPM4tuajOufWZjw44KQSMVJ+DhkD9KHrifU+2zUm7ZEaFdQTwW841TNj4/0RM
 IRxjxc2CjfjhAOyojOWsHoWNEa36IMJsgbFBe1DWzt+pEn7ae7xGiyGsDvc1CyFq1BDV
 I3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846326; x=1760451126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGVyZTzYATyCeTWWOlBiNol/uabWyBP70eHig5Rs8QI=;
 b=lSMLqXBWTpNauKU0cV1rcuJ8QnsfPE/Lqj4CTAisbhZQT/CVbj/rQOqhvpu5dTe/pM
 003xHzAq5IKV8TkkWlylHvSsRM2tA8GY5M3Z0D2pyWFZrxrz45r5SbOgeRjcRo/E8gE3
 X/g6YUB0BjovD93ERymFpgkWPMNklYCKMneIns26neS4VuxR6sPfm0a8fWPO1cZCB+s/
 JHZidY7+kV7QepXEAbUWNIgrZejrUAp2+CZBxWyKwocol8D70F4NzO6yvHu1ntXOh35F
 IrFqrgc76W2Rc1c2rivWMMYciN2QJs27Y+z9uuoUD7M7XPe0+asKX1Pyv0K6dgEBQemg
 MF/w==
X-Gm-Message-State: AOJu0YxtU+j60RhjbCJJt87B307RkXzSFg0uAw/6EDj8rD8SQtRl/Bzt
 Ib3G4Zuv0D+XPwHdVCoh2FaQd0DCpqz8XQoxyB7m0SoaVo+dmV3fG9WVNJhzWeGAhsIVi1vzK42
 WOv0d
X-Gm-Gg: ASbGncuV0jc5vzM2+MZZAkYF530tf3l5WD7npUWXZPaJxT67YThauxsdOhAu7vtvoNa
 X6yy9SE8ZubYUoVOgboUeqE0SO+6rzySJCeib+s0UBF19DFZrPPWFuF2ZdBDvf5bf/58n0KLSEX
 7LEvVdYbTimjQhx7Lq2Zxn6Eoaa8By3WywEkEwXCxOqCpi+LtCX/8XjNtk4nSTjfzOPDmt3GmL1
 YxIpRAntPnU1PaUJl6jIiVQB1rLA1uJN8XkdELZ3PSEeLfdZOwrVRAmN7i0Cnkr1P8U53hJ0rUt
 7vzscUlBelOcI9TmIOkqsu9P0XkKgnsbNGEH14x3uBwsUOgohhPpC8YOeNuiRsEHf1M1UnmpC3J
 6Ywg2hOlXhm641Btagfyb1p6YB2HjHHLnUrr1BN1bmp8l6/VZnflU3T3w
X-Google-Smtp-Source: AGHT+IEU+XmxM1GR470I57wyEdW+7hCSsORnDfRjMTipsgQMR5of7E/AyDgkgs6gEMgpno/mD/h/lw==
X-Received: by 2002:a05:600c:8185:b0:46e:3f6f:a8ee with SMTP id
 5b1f17b1804b1-46e7110c256mr98066035e9.13.1759846325934; 
 Tue, 07 Oct 2025 07:12:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/62] hw/arm/xlnx-versal: add a per_cluster_gic switch to
 VersalCpuClusterMap
Date: Tue,  7 Oct 2025 15:10:58 +0100
Message-ID: <20251007141123.3239867-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Luc Michel <luc.michel@amd.com>

Add the per_cluster_gic switch to the VersalCpuClusterMap structure.
When set, this indicates that a GIC instance should by created
per-cluster instead of globally for the whole RPU or APU. This is in
preparation for versal2.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-38-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 49b5b244403..3d960ed2636 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -88,6 +88,11 @@ enum StartPoweredOffMode {
 
 typedef struct VersalCpuClusterMap {
     VersalGicMap gic;
+    /*
+     * true: one GIC per cluster.
+     * false: one GIC for all CPUs
+     */
+    bool per_cluster_gic;
 
     const char *name;
     const char *cpu_model;
@@ -825,12 +830,18 @@ static void versal_create_cpu_cluster(Versal *s, const VersalCpuClusterMap *map)
             cpus[i * map->num_core + j] = cpu;
         }
 
+        if (map->per_cluster_gic) {
+            versal_create_and_connect_gic(s, map, mr, &cpus[i * map->num_core],
+                                          map->num_core);
+        }
     }
 
     qdev_realize_and_unref(cluster, NULL, &error_fatal);
 
-    versal_create_and_connect_gic(s, map, mr, cpus,
-                                  map->num_cluster * map->num_core);
+    if (!map->per_cluster_gic) {
+        versal_create_and_connect_gic(s, map, mr, cpus,
+                                      map->num_cluster * map->num_core);
+    }
 
     has_gtimer = arm_feature(&ARM_CPU(cpus[0])->env, ARM_FEATURE_GENERIC_TIMER);
     if (map->dtb_expose && has_gtimer) {
-- 
2.43.0


