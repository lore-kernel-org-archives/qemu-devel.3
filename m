Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73133C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTca-0004U1-8o; Mon, 26 May 2025 04:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcL-0004Re-8M
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcI-00082x-RD
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4dba2c767so294282f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1748249729; x=1748854529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+yP9a/uVH74kLVGGvEGM7JayHygTFaXLhgBOX+A4es=;
 b=LJlLW1Fd8gDmeuHgY1x4X2r7hCQ/QM3U/SSpW+5jdIY86kUN85zJVXXEh+4hqaJpe/
 abDSH+mst0oviazV4juM8NBKuFr8tkpJRWQWo6n70PDZFc9tJuc2Et0UW0MX7I6ul0sE
 wkIdeLE6AanLjF+cfGR2MkqSvLK8IfTH0cPsthN80w4bR2ZBE3T1xxkOOj1+ijeued/i
 KeuI0T7GLpYN2/HPbTg5Zhlb3+qsdfX2MU8Hg+a44a4U1hMxmlVP/6E25lMfjtiEuyFk
 s/sxWSmEfm/pbSB8C98752jeoIZ46M1K1nqnvalhgBnPvlKBaKtLmWHTJfHX7JL+2Uw3
 7T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748249729; x=1748854529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+yP9a/uVH74kLVGGvEGM7JayHygTFaXLhgBOX+A4es=;
 b=iA9pEKCVas4YF0H48jQoAA0sdACp/kYcgL2KEhWwvngMr6r9vfKe33M62NyxOU+wlk
 ZYm/BhAbiXtoFK7Ypq4yDWmgpsIKXs9mj+D3RPmU8Kzkex9TJV22qQSxUBdxsb5t6fAN
 yr+lVfIkzZxdi37Qpifpq1y9F/WWxDE9Iz0ALxBwq23hSf3itVQLSJ//nEH1z86V4/m6
 44gDsmCULsDzMu6oZtVg8cub5S29OLWQ/H01uJJTn+kD1uqOYiQB/MExAzeNph5+nxu6
 a4jOjLiT3pCQAk0IfVClFuQAsJaNMWjuQLBpY2sUp9dm7rskhHIcO3PBTVnmSRsBQZh3
 AMbA==
X-Gm-Message-State: AOJu0YxhhCbp1gat5TizrOR4hg6ok3wESOzIb4YfVm672bY8yZB3mb8J
 7am0DlclCFZVEso1AX/mkoCud0oi1W18ADE20qjat7p9U+zp2fC24ymaBgkmVOt7ZA+IJ5Zq1ue
 Mkts=
X-Gm-Gg: ASbGncueQGR9eWDWLuA9xi+q0gb/lpzRgOXRfAHazx9+EA7ojN3LFheP6G6LZtBJIyG
 WlyaG0li+p4FAcGGUSE9dB2AjkgLyqpD5wYGR/2SNqDzRqz/iJGAScHsOF4G7zkeXeENU4i2Qop
 GrvR4gmbAluLBYnYuMjdpFMhGNuie/cQadmXiOIow5jg5LTTCaq7gabWBYTYKUa5ihapKMOzWHT
 +ReDpO7cu+zSXXtJPIs4AIOLt42YyjwPRIBZn+AFYuNIYikjsBkYc3mn66QyMPt0yhKJu2Oneem
 lhhzXuqDmjUaWoMxC640EkG7mewV+yVoerWl4QZqknh101gis5ZmE7ythy588WUb2oM6qpdx7ZL
 fMzgbpO90mkETxfld86JnNu5Jafhe9MQPVFyfGFiMvqRA65N1
X-Google-Smtp-Source: AGHT+IEen6/hOBkf8S82eHLxUE7jzmDqnS5MqqcRX9Onr/Vp4jcwYZiQeSIdN/OVLozcwmASEuFujw==
X-Received: by 2002:a05:6000:1ac8:b0:3a3:6f35:55e3 with SMTP id
 ffacd0b85a97d-3a4c14f798amr10911540f8f.7.1748249728955; 
 Mon, 26 May 2025 01:55:28 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfd54sm238911675e9.17.2025.05.26.01.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 01:55:28 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me, Frederic Konrad <konrad.frederic@yahoo.fr>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 2/4] hw/intc/arm_gic: introduce a first-cpu-index property
Date: Mon, 26 May 2025 10:55:21 +0200
Message-Id: <20250526085523.809003-3-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526085523.809003-1-chigot@adacore.com>
References: <20250526085523.809003-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=chigot@adacore.com; helo=mail-wr1-x42d.google.com
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
 include/hw/intc/arm_gic.h        | 2 ++
 include/hw/intc/arm_gic_common.h | 2 ++
 4 files changed, 6 insertions(+), 1 deletion(-)

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
diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 48f6a51a70..6faccf8ef6 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -27,6 +27,8 @@
  *    implement the security extensions
  *  + QOM property "has-virtualization-extensions": set true if the GIC should
  *    implement the virtualization extensions
+ *  + QOM property "first-cpu-index": index of the first cpu attached to the
+ *    GIC.
  *  + unnamed GPIO inputs: (where P is number of SPIs, i.e. num-irq - 32)
  *    [0..P-1]  SPIs
  *    [P..P+31] PPIs for CPU 0
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


