Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FB1C3ABD9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqQC-00044p-4F; Tue, 13 May 2025 10:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqQ1-00042I-CG
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:42 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uEqPy-0005aH-W9
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:15:40 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso37945255e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1747145737; x=1747750537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omIYyhjnPokjM8hDN/Na4Ta4HqneXcIGJ9F+NHfzW2Y=;
 b=N3RNAS/kcPvaRIMAwAHBFz/jmVa6PtPaMkvItl3pj3R2itmoIid0gCCU03iH/DP0dc
 uQYGjZtRcpnKu743TWIa/HfwbEbeRtHQPQKs0cdmyUtIOYrarhs640Ako2Aeyjz03gJw
 xUK2Kd8jBdi2RCRgQRyjrg28HjJI7aKGOmqXWVfo78paR3rpin7nFZZDFRkgvrkLz5/P
 rvf15z7UjdDSq2emgQMJMzd38xplHYO+XfIDlvTU0poItmuAsq9ZTwXc/2MhlNlQsC6e
 ukFM/a/syFYzZ6jYMB0mn0VV/Ywp5PJP2CxoRdoH4Z11TIwYAxRsYafvD7diz1z4PgVp
 1N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747145737; x=1747750537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omIYyhjnPokjM8hDN/Na4Ta4HqneXcIGJ9F+NHfzW2Y=;
 b=fSDuaDEM3Xpr5EFlSvbyvTZ+20UtqfpdmWAe327JGEtI/2O1O1fdcOk7fMgBPSbved
 8J/LY4CTI2wIVqz/0qJyGP6OdeolJ4xU1YR8a+9dFDew46wEiuza+q20/47Xb7IJN4ea
 kwbRpuR8yBRfhhaAasNRZX0rkOZd6Dl9Og4D/MYDigfTmjrRbm/Dd8dc4o15RZx4xbZm
 fxczl+ShL1tdIMIrHQAv03HebG1fsEvRoR9Iftv+8XdbYA8TkOV9U1f2i6dkhiE4wlKk
 UwnUc42qr9oUf5DOd3ho4+KF/fJVotC9ghmf4tTkvH5LDeuqsSLmAIzVKLIdWAdpWfuo
 tpUw==
X-Gm-Message-State: AOJu0YxkBktFvX6mtn7eG7hvUxUjBHue1i+K+9GNYMFQnqSy8soGp47c
 qqy+uUfH1BTTeqZcmEVeZ0gzqkQ9GK0K66BAipoiUarQMt6mm08apiTd98s76bQUCzIvhp1AG6s
 =
X-Gm-Gg: ASbGnct2dyHsf8nnRVSzT+kce+DKXY2Ed2pl3bRjtIkpfaGrB+4zD5hFBZkTdaEs1p3
 WJv5ky+1DDHpJPKVNXueiiZ4TAyrFpevfcNSgIpxdPYGihK7cNSGn55b/PNXWKQrR3uuK0LeR4A
 E7emvoSGV3yKDK56HDx0XM9y2fd5N+GGrRFNksJqQyMIX/64GUZEjaQnhAHw2YvZ2CVmElJB8hi
 zr29CH0k9VlfZ3gCEDSE1bBnc550Rlj/6OPsptb/KWX6+fHUpf9WHIwweI8cOy0cbpm6l2tyYyB
 n+qrl9385aOa1Qztu6vBk8LOxKm6nkeDDwzlLrMPcNrVfjggMyO9QuDhF9bmp7DevwzuAiwPuTK
 7NsFWUdOfF+qBWA54ZlgG3AtjOWPwbO4o5jVKO9t97LxOM35T
X-Google-Smtp-Source: AGHT+IHt0y8nmUC0Y4PYrR4A7wNXnR/5DJ6Mkxa6dbXXAZts3LxUiFYAlg42jDhzoxp2RSqeQ0xIpg==
X-Received: by 2002:a05:600c:37cd:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-442d6dd21e9mr122130445e9.26.1747145737182; 
 Tue, 13 May 2025 07:15:37 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3b7e7fsm213438805e9.39.2025.05.13.07.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 07:15:36 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH 2/4] hw/intc/arm_gic: introduce a first-cpu-index property
Date: Tue, 13 May 2025 16:14:46 +0200
Message-Id: <20250513141448.297946-3-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513141448.297946-1-chigot@adacore.com>
References: <20250513141448.297946-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32a.google.com
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

From: Frederic Konrad <konrad.frederic@yahoo.fr>

This introduces a first-cpu-index property to the arm-gic, as some SOCs
could have two separate GIC (ie: the zynqmp).

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/intc/arm_gic.c                | 2 +-
 hw/intc/arm_gic_common.c         | 1 +
 include/hw/intc/arm_gic_common.h | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index d18bef40fc..899f133363 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -59,7 +59,7 @@ static const uint8_t gic_id_gicv2[] = {
 static inline int gic_get_current_cpu(GICState *s)
 {
     if (!qtest_enabled() && s->num_cpu > 1) {
-        return current_cpu->cpu_index;
+        return current_cpu->cpu_index - s->first_cpu_index;
     }
     return 0;
 }
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index 0f0c48d89a..ed5be05645 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -350,6 +350,7 @@ static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
 
 static const Property arm_gic_common_properties[] = {
     DEFINE_PROP_UINT32("num-cpu", GICState, num_cpu, 1),
+    DEFINE_PROP_UINT32("first-cpu-index", GICState, first_cpu_index, 0),
     DEFINE_PROP_UINT32("num-irq", GICState, num_irq, 32),
     /* Revision can be 1 or 2 for GIC architecture specification
      * versions 1 or 2, or 0 to indicate the legacy 11MPCore GIC.
diff --git a/include/hw/intc/arm_gic_common.h b/include/hw/intc/arm_gic_common.h
index 97fea4102d..93a3cc2bf8 100644
--- a/include/hw/intc/arm_gic_common.h
+++ b/include/hw/intc/arm_gic_common.h
@@ -129,6 +129,8 @@ struct GICState {
     uint32_t num_lrs;
 
     uint32_t num_cpu;
+    /* cpu_index of the first CPU, attached to this GIC.  */
+    uint32_t first_cpu_index;
 
     MemoryRegion iomem; /* Distributor */
     /* This is just so we can have an opaque pointer which identifies
-- 
2.34.1


