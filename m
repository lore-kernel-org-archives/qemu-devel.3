Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15805C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYPJ-0002On-Bt; Mon, 10 Jun 2024 02:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPE-0002NF-01
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYPB-0004Jt-JZ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:21:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-421d32fda86so5119205e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718000479; x=1718605279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRaRL501WvQ0swv15S662THilyXH6kAx9FOW+Jx2/Sg=;
 b=Nn1nfKPYP3NxM3yM9Bj+MrQkjN+nMPYUgVfeDFkfOQBinbItZ87y8WdBc86g2U055G
 6hVhPv7Alp+mlEoZb4aHwDHa03bS34xg0lKMkRoYdvWhV98BLpbaAPd0kxWvMf3+VhGs
 kVy/zHmJ5qVR/EN9e0jifUAsGKVc1cH75iBpBbLWY5NDwG8lTokg79mvgniUPlU28tXq
 zFEk9Ws0lPJQq4Ry0tAXdUEib5kvXCNi+1fVe2vyNnVdqhif2Oq8GSLsikXw+BPivIyx
 1OlA+1Pd7m/4MS3lHSvDbmPNgkVV8htH+cSLWA4Em/N5eR/Vdpr5O1t7544p+xPg4Y9T
 u8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718000479; x=1718605279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRaRL501WvQ0swv15S662THilyXH6kAx9FOW+Jx2/Sg=;
 b=C8Y8o3wtT8iz4snk74XKWkKX+0owbX/tL6cVDsXdqOWTQQpcA3JWhpzu2Si1SpmgzQ
 T4XnYy08lFW3DByh31vgm1aBEg25HZQIIr6g5g2NMzUNo95jw4xCC9MEnd4CCC6/yUUR
 CjWucg9eUT7v9p1BXJ1h4OM7jzWANenV5TEuJ54aKqQbPqL0NIDMi+nyLLxi+mAwiQvi
 Upgub+cvTUz4dUVmYeAsWVH2WXyelj9j3whz+lCTWuA/wLKhhULonU0OTxKg3ND2Llrl
 8OMvqr9iQBj2DHtTjurHNaTRiVDak9gTNGywPQMorUSrot2t7KVwqYX0yw6jbjFL3W33
 E+1g==
X-Gm-Message-State: AOJu0Yz7iMvYsTB8m0yI7k36hC9YcqpvCH4WBP+aMOxB/abfdh/ZWrnV
 yk2YccaO3dR2GovP+sTUD7j1dIjx80vVOzU4lbQOitAhA20VQe6LTb9DGFstvd3ML+Obwf9IBdP
 Z
X-Google-Smtp-Source: AGHT+IGXahQu6Ire2QhvShbLmCnau8V3spova81KSa+anV/bghdlUEtQmmDUEN8WeNpfR6+mH0kp5Q==
X-Received: by 2002:a05:600c:510b:b0:421:5a2d:b7d9 with SMTP id
 5b1f17b1804b1-42164a0adf6mr87329745e9.20.1718000479680; 
 Sun, 09 Jun 2024 23:21:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2c7396sm130025655e9.33.2024.06.09.23.21.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:21:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 02/26] hw/ppc: Avoid using Monitor in icp_pic_print_info()
Date: Mon, 10 Jun 2024 08:20:40 +0200
Message-ID: <20240610062105.49848-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610062105.49848-1-philmd@linaro.org>
References: <20240610062105.49848-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/xics.h | 2 +-
 hw/intc/xics.c        | 8 ++++----
 hw/intc/xics_spapr.c  | 8 +++++++-
 hw/ppc/pnv.c          | 8 +++++++-
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 95ead0dd7c..1116aa6953 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -171,7 +171,7 @@ static inline bool ics_irq_free(ICSState *ics, uint32_t srcno)
 }
 
 void ics_set_irq_type(ICSState *ics, int srcno, bool lsi);
-void icp_pic_print_info(ICPState *icp, Monitor *mon);
+void icp_pic_print_info(ICPState *icp, GString *buf);
 void ics_pic_print_info(ICSState *ics, Monitor *mon);
 
 void ics_resend(ICSState *ics);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 9b3b7abaea..039e10a0e4 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -42,7 +42,7 @@
 #include "sysemu/reset.h"
 #include "target/ppc/cpu.h"
 
-void icp_pic_print_info(ICPState *icp, Monitor *mon)
+void icp_pic_print_info(ICPState *icp, GString *buf)
 {
     int cpu_index;
 
@@ -63,9 +63,9 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
         icp_synchronize_state(icp);
     }
 
-    monitor_printf(mon, "CPU %d XIRR=%08x (%p) PP=%02x MFRR=%02x\n",
-                   cpu_index, icp->xirr, icp->xirr_owner,
-                   icp->pending_priority, icp->mfrr);
+    g_string_append_printf(buf, "CPU %d XIRR=%08x (%p) PP=%02x MFRR=%02x\n",
+                           cpu_index, icp->xirr, icp->xirr_owner,
+                           icp->pending_priority, icp->mfrr);
 }
 
 void ics_pic_print_info(ICSState *ics, Monitor *mon)
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 37b2d99977..bab9d88218 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -34,6 +34,8 @@
 #include "hw/ppc/xics_spapr.h"
 #include "hw/ppc/fdt.h"
 #include "qapi/visitor.h"
+#include "qapi/type-helpers.h"
+#include "monitor/monitor.h"
 
 /*
  * Guest interfaces
@@ -399,12 +401,16 @@ static void xics_spapr_print_info(SpaprInterruptController *intc, Monitor *mon)
 {
     ICSState *ics = ICS_SPAPR(intc);
     CPUState *cs;
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
 
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
 
-        icp_pic_print_info(spapr_cpu_state(cpu)->icp, mon);
+        icp_pic_print_info(spapr_cpu_state(cpu)->icp, buf);
     }
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 
     ics_pic_print_info(ics, mon);
 }
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5356a4e295..fa23b27a2b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1130,7 +1130,13 @@ static void pnv_chip_power8_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
 static void pnv_chip_power8_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
                                             Monitor *mon)
 {
-    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
+    g_autoptr(GString) buf = g_string_new("");
+    g_autoptr(HumanReadableText) info = NULL;
+
+    icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), buf);
+
+    info = human_readable_text_from_str(buf);
+    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
-- 
2.41.0


