Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D455E83839
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cs-0002Ec-LS; Mon, 16 Feb 2026 16:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6Ca-00017Q-IX
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6CW-00044r-V1
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so30819835e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277535; x=1771882335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+jMqivfnrcdUY1u8zHXwV1uu1QqH0rdk08fo1hOV0E=;
 b=pYOlXz/j7drTllQ9M6RbYVBWAt1MnxN2+npoJCGKlNPOUG36dxcfxSvoC6qhCbsHlj
 JXKoqN8aOWKfw2jtbM3l6Rc5Py8WvFXEefP8DMgLACmFJ8VE+vlmm7zcPglGvMIcUVgd
 rVY7T3OXvVv4QiNi4uGKwwZEsBkCvfF00jmWF7QExM1SHjypEnwIsRnQB2C1nzcswJtO
 a11l/0kqyFFfHQzUBhLBA9WEkF05RInNAB2JdYUWmvnRsT9bus9c/CgoIVPStiEFiHlt
 FZXFYw6+c3Za4Ms2ffsGJoZr3fmDKQjA8WXj7fq2sPT8j6oolchgsmKNFHElVUCf8xDi
 ttsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277535; x=1771882335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D+jMqivfnrcdUY1u8zHXwV1uu1QqH0rdk08fo1hOV0E=;
 b=ei3HxonPsdK3ZW2X9L374acPxwDRgdzMuvdqBUYCjUntHW4SKb2X0vIZQWH+TLSSP9
 i3lfAOWfCWe0+LfpI868XTc2Q8Zeg+lTxUm5vN2/BsowpA2Ab3IJm91AQaIcv37KHc5y
 k21JtuOphfxw/gc/0Mz++Rh/L7Ax7K7ZHvHgE9h2nf6BSlk3xkn3B+lwGn233t/WRLGy
 9BkIety7bhsqMTHk3S+t8ZCOSM4ZFORMGEYDF8Vm/QtYn1MZf55a/e7BtgoGEB5ehOhE
 9XIznxL4A5EI2Xn8QGrwmc2lQq3ZYnSKsfyU7aFMUHJYB5RCL0qVEJp7ostTl3xqa/S+
 1I2g==
X-Gm-Message-State: AOJu0YyJjigwn7PFoOZ19RipwvhQ1wNf3Kvb/eIw1d+Yd1sYmnG+SgNl
 3A1c21L4JxaGBhigJb1gQugxov28xMWgipjrbKjFvXZJYOLPkZ6DQfIA4xXYeLgeMn2NJKGQ5ZL
 titfc+Lg=
X-Gm-Gg: AZuq6aI+X04MUWhKrA8x4W7wh1rNB4R2nUn6rBI0SBsIwUDNPD0QNBSgEWuXoDwh1Kn
 bJacn3yJQAuHb5xXH99T9EeO05r/Mq4zIxBJKTZWmVK+3uiZSiokiThF6LFXuGhF0ZW4f/FtJKD
 ycgbpkEklwdD7dHnfParjUfJaNj52XwcfhTnW3pd9hQ1IgQ8lSsAzOLGB2l5SMz0++0BMzNSmfk
 IPcIbt5loVhvVzPebqz6q1K6h8NzUNJuxyJZoLe0YvkhE+bkQYKKpPz2PscCBCH2iOHWpE7LiYG
 e5AlkI63hKWrsXDj0ZWea3eDgGe8XobcWsGt29IwCn2/pXhk+aICEtg0sTL+DKuROgqkDal3u2Z
 QtyGuzc7YJiu6ZvShaO39gDrOO3/exCJZPGxYAqscd5lC6o493ZLr32davQnEDjN76cW7DNnTXc
 HOYMqjWjap03D/KUq7s5g83IVCvmpgqiwKk9kFREVksQjL+BzAKwPzVI259gQ1qb0pDaPZXzLe
X-Received: by 2002:a05:600c:6912:b0:483:456a:5146 with SMTP id
 5b1f17b1804b1-4837108fed4mr208785135e9.25.1771277535103; 
 Mon, 16 Feb 2026 13:32:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a4b63dsm95104645e9.32.2026.02.16.13.32.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:32:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/8] hw/ppc: Set graphic display dimensions generically
Date: Mon, 16 Feb 2026 22:31:20 +0100
Message-ID: <20260216213121.47122-8-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

If a dimension is not set, have the machine init code set
the default values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/mac_newworld.c   | 9 +++++++++
 hw/ppc/mac_oldworld.c   | 9 +++++++++
 hw/ppc/prep.c           | 9 +++++++++
 hw/ppc/spapr.c          | 9 +++++++++
 system/globals-target.c | 6 ------
 5 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 7275563a155..3680d96ed39 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -432,6 +432,15 @@ static void ppc_core99_init(MachineState *machine)
 
     pci_vga_init(pci_bus);
 
+    if (!graphic_width) {
+        graphic_width = 800;
+    }
+    if (!graphic_height) {
+        graphic_height = 600;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 32;
+    }
     if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
         graphic_depth = 15;
     }
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index e679d338985..24d9f2e3d5c 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -288,6 +288,15 @@ static void ppc_heathrow_init(MachineState *machine)
         pci_create_simple(pci_bus, -1, "pci-ohci");
     }
 
+    if (!graphic_width) {
+        graphic_width = 800;
+    }
+    if (!graphic_height) {
+        graphic_height = 600;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 32;
+    }
     if (graphic_depth != 15 && graphic_depth != 32 && graphic_depth != 8) {
         graphic_depth = 15;
     }
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index c4efd1d3908..e973b340992 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -412,6 +412,15 @@ static void ibm_40p_init(MachineState *machine)
     fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, (uint64_t)machine->ram_size);
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_PREP);
 
+    if (!graphic_width) {
+        graphic_width = 800;
+    }
+    if (!graphic_height) {
+        graphic_height = 600;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 32;
+    }
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_WIDTH, graphic_width);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_HEIGHT, graphic_height);
     fw_cfg_add_i16(fw_cfg, FW_CFG_PPC_DEPTH, graphic_depth);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 274f38785f2..0ab39dfea6b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1177,6 +1177,15 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt, bool reset)
         if (machine->boot_config.has_menu && machine->boot_config.menu) {
             _FDT((fdt_setprop_cell(fdt, chosen, "qemu,boot-menu", true)));
         }
+        if (!graphic_width) {
+            graphic_width = 800;
+        }
+        if (!graphic_height) {
+            graphic_height = 600;
+        }
+        if (!graphic_depth) {
+            graphic_depth = 32;
+        }
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-width", graphic_width));
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-height", graphic_height));
         _FDT(fdt_setprop_cell(fdt, chosen, "qemu,graphic-depth", graphic_depth));
diff --git a/system/globals-target.c b/system/globals-target.c
index 17a27a06218..ffa6c308b59 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -9,12 +9,6 @@
 #include "qemu/osdep.h"
 #include "system/system.h"
 
-#if defined(TARGET_SPARC) || defined(TARGET_M68K)
 int graphic_width;
 int graphic_height;
 int graphic_depth;
-#else
-int graphic_width = 800;
-int graphic_height = 600;
-int graphic_depth = 32;
-#endif
-- 
2.52.0


