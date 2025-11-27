Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A0BCFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObtE-0006FR-QC; Thu, 27 Nov 2025 08:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr4-0002jv-Qd
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqx-0001IA-84
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QAcMOGF098GkVRo7S2wJ+dMzUkmSvgw+wyU7VGS9qHg=;
 b=MWL3G1XpWEEptSD+RGgtjR3k/4GFUSFR5YyiRMaSkhOKSjrofVX33FqvZmC5FlXFQvG7qQ
 wJS7qclKi0LLWJY6vdwXL6qlzQWxL40zf86tpGITwzhRf6UKnwTPK6QO6o5Z0CHnW8JjPD
 BovGbTZQitmS8btnCBb23M/rmE2ae5I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-M6KzBw2gMb-i09Qt7QO-Fg-1; Thu, 27 Nov 2025 08:15:58 -0500
X-MC-Unique: M6KzBw2gMb-i09Qt7QO-Fg-1
X-Mimecast-MFC-AGG-ID: M6KzBw2gMb-i09Qt7QO-Fg_1764249357
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-64097bef0e2so1312167a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249356; x=1764854156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QAcMOGF098GkVRo7S2wJ+dMzUkmSvgw+wyU7VGS9qHg=;
 b=F1DA08zaCr2TWWaiGm0n00CK4QM+T7IFAN+QaNna+tA8xDJJB7pd4foJBwKxbANIyK
 +tUmc7gZqXXvgyqGwa+ypj2L6OVebdTAnC5vpwJ3RcJbxXJc1gReRE4vmPR91fbLufrw
 gyLnBarnH1ppWNhyjPk8h8eBcRgj0XZkxZODW5i2XJ4H7qg1eMruUmO2axoowNoDYCwd
 ESD8jbu2qj9oUpjhHdgwW9w0FWVHgaB3c9kGy3antptO0T0OcWr3zQEelZcU+5BpO2Xl
 TTuG7b6HVyIUfglipdCqcekwXMKrL4uYPANHV65XYgmK+ZtPsy0u8vLXH9gscSmAQK4L
 Nprw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249356; x=1764854156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QAcMOGF098GkVRo7S2wJ+dMzUkmSvgw+wyU7VGS9qHg=;
 b=LdSoIwQ+9bU3KCzQpVTgG5CsBbTEtPR/gEJX6ybA7S2F2tqqo6pYTY8mi5hMB6w92D
 W5hkrDHgkKkOZpIyTkjSesqc7qJXPaOAZau3vnG2c+ilJ+PmS113KdSpUIdph2g68HX/
 roZmyTEH/kqjzIVqqn9h08iFkRHdgCPAbR6ojHimIITCycrJZCyZh1ipAT3ZpVQc3rOS
 kOJEcd6pw/3WyRrCXkfqewV33xm3+GK7ydUutN1peLZdH19h8eb8trQ7pBzhoUE15niP
 bBaxg1Qzm8qRaSNXeXEX/YZ9AckoY77afjvZ1nb+3h7fyVL6KJx0biolhnVU6aaL3Y3Z
 NC6A==
X-Gm-Message-State: AOJu0YysHYJOlRa7SgjdKscaL+uijfYgI3T7OBpKryH3TPwtbcUsDVVK
 p/dTgW1gq/hsKPDqLUmFXzvd0YxzW1r9wnQLhupLtmQUnYLyDoJma5PhOfCy/W9vmYHSpwIKF+J
 vjA2hNLIbfIIUkYtuN25Q8HjPhEDXzKMgzuiU8k5/9KT41QrJjvxqrcFZcOZ6hi0aYutVVB1EMV
 NXNj11k5kS4haWR0wmLHr9hOzamyI5KzUZ/UMYstqe
X-Gm-Gg: ASbGncu1A7XJOKwL/vnz9DCwO/Y6PmEkkKuXhDWVEMIWoVTQQgxwNK9VZ2FNHDoVg8s
 88h0goYdese6Kfy0TQyD4AiyRHxIiNSe0uobjeZtrETWgiPdJchrXZig3owXbDQA7OUAG3r2hqS
 WSnnUa0deOhQgMuXhudxELl/4ABO3BSpSXCznnyxqx+SoysBpzeWW3NaLWVY49jik2bsZo8k6NT
 Fi2cQFBzksoDHsIHp//6q45SBB4uDTeGCv8626h3mTdsr6rVLNcuPb6FXFfg7iXBy/zf6qGu34e
 x2gqdPyCg4CKcy+Wk0EOetzzt4excK0nJJh1+2xMRRPmqKhXfxMjwET+O1/AtIeoxXfxqo3MPsq
 N/Z7E6i6gBnJsDOEr1KVUuIX7+v8Xign4PQldVIc26MsaSdse/pKP4PjoQ/4XNiuTEqDdj8TRIq
 jsWEZezbSCIP1Es5Y=
X-Received: by 2002:a17:907:9493:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b76715e6316mr2583653866b.26.1764249355983; 
 Thu, 27 Nov 2025 05:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF65nBaBHB3gWCott9eOMWbcJQFOlAWBPT14da6hVKkqIb1VDjrHgNMLt/faDZhZykq+Jz/Fw==
X-Received: by 2002:a17:907:9493:b0:b1d:285c:e0ef with SMTP id
 a640c23a62f3a-b76715e6316mr2583647766b.26.1764249355007; 
 Thu, 27 Nov 2025 05:15:55 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a7b4bcsm152993566b.71.2025.11.27.05.15.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/28] include: move hw/register.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:09 +0100
Message-ID: <20251127131516.80807-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                                 | 2 +-
 include/hw/{ => core}/register.h            | 0
 include/hw/cxl/cxl_component.h              | 2 +-
 include/hw/cxl/cxl_device.h                 | 2 +-
 include/hw/dma/xlnx-zdma.h                  | 2 +-
 include/hw/dma/xlnx-zynq-devcfg.h           | 2 +-
 include/hw/dma/xlnx_csu_dma.h               | 2 +-
 include/hw/intc/xlnx-pmu-iomod-intc.h       | 2 +-
 include/hw/intc/xlnx-zynqmp-ipi.h           | 2 +-
 include/hw/misc/allwinner-a10-dramc.h       | 2 +-
 include/hw/misc/xlnx-versal-cframe-reg.h    | 2 +-
 include/hw/misc/xlnx-versal-cfu.h           | 2 +-
 include/hw/misc/xlnx-versal-crl.h           | 2 +-
 include/hw/misc/xlnx-versal-pmc-iou-slcr.h  | 2 +-
 include/hw/misc/xlnx-versal-trng.h          | 2 +-
 include/hw/misc/xlnx-versal-xramc.h         | 2 +-
 include/hw/misc/xlnx-zynqmp-apu-ctrl.h      | 2 +-
 include/hw/misc/xlnx-zynqmp-crf.h           | 2 +-
 include/hw/net/xlnx-versal-canfd.h          | 2 +-
 include/hw/net/xlnx-zynqmp-can.h            | 2 +-
 include/hw/nvram/xlnx-bbram.h               | 2 +-
 include/hw/nvram/xlnx-versal-efuse.h        | 2 +-
 include/hw/nvram/xlnx-zynqmp-efuse.h        | 2 +-
 include/hw/pci/pcie_doe.h                   | 2 +-
 include/hw/rtc/xlnx-zynqmp-rtc.h            | 2 +-
 include/hw/ssi/xlnx-versal-ospi.h           | 2 +-
 include/hw/usb/hcd-dwc3.h                   | 2 +-
 include/hw/usb/xlnx-usb-subsystem.h         | 2 +-
 include/hw/usb/xlnx-versal-usb2-ctrl-regs.h | 2 +-
 hw/core/register.c                          | 2 +-
 hw/dma/xlnx_csu_dma.c                       | 2 +-
 hw/intc/xlnx-pmu-iomod-intc.c               | 2 +-
 hw/intc/xlnx-zynqmp-ipi.c                   | 2 +-
 hw/misc/xlnx-versal-cframe-reg.c            | 2 +-
 hw/misc/xlnx-versal-cfu.c                   | 2 +-
 hw/misc/xlnx-versal-crl.c                   | 2 +-
 hw/misc/xlnx-versal-pmc-iou-slcr.c          | 2 +-
 hw/misc/xlnx-versal-xramc.c                 | 2 +-
 hw/misc/xlnx-zynqmp-apu-ctrl.c              | 2 +-
 hw/misc/xlnx-zynqmp-crf.c                   | 2 +-
 hw/net/can/xlnx-versal-canfd.c              | 2 +-
 hw/net/can/xlnx-zynqmp-can.c                | 2 +-
 hw/rtc/ls7a_rtc.c                           | 2 +-
 hw/rtc/xlnx-zynqmp-rtc.c                    | 2 +-
 hw/ssi/xilinx_spips.c                       | 2 +-
 hw/usb/hcd-dwc3.c                           | 2 +-
 hw/usb/xlnx-usb-subsystem.c                 | 2 +-
 hw/usb/xlnx-versal-usb2-ctrl-regs.c         | 2 +-
 48 files changed, 47 insertions(+), 47 deletions(-)
 rename include/hw/{ => core}/register.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55cdcc46752..b9cc00a5582 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3559,7 +3559,7 @@ Register API
 M: Alistair Francis <alistair@alistair23.me>
 S: Maintained
 F: hw/core/register.c
-F: include/hw/register.h
+F: include/hw/core/register.h
 F: include/hw/core/registerfields.h
 
 Rust
diff --git a/include/hw/register.h b/include/hw/core/register.h
similarity index 100%
rename from include/hw/register.h
rename to include/hw/core/register.h
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
index 945ee6ffd04..b0f2aa79143 100644
--- a/include/hw/cxl/cxl_component.h
+++ b/include/hw/cxl/cxl_component.h
@@ -17,7 +17,7 @@
 
 #include "qemu/range.h"
 #include "hw/cxl/cxl_cdat.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qapi/error.h"
 
 enum reg_type {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 89411c80936..165355baf9d 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -12,7 +12,7 @@
 
 #include "hw/cxl/cxl_component.h"
 #include "hw/pci/pci_device.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/cxl/cxl_events.h"
 
 /*
diff --git a/include/hw/dma/xlnx-zdma.h b/include/hw/dma/xlnx-zdma.h
index 9c57c499102..2d2d4aeefab 100644
--- a/include/hw/dma/xlnx-zdma.h
+++ b/include/hw/dma/xlnx-zdma.h
@@ -30,7 +30,7 @@
 #define XLNX_ZDMA_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "system/dma.h"
 #include "qom/object.h"
 
diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq-devcfg.h
index e4cf085d703..8d10553c22a 100644
--- a/include/hw/dma/xlnx-zynq-devcfg.h
+++ b/include/hw/dma/xlnx-zynq-devcfg.h
@@ -27,7 +27,7 @@
 #ifndef XLNX_ZYNQ_DEVCFG_H
 #define XLNX_ZYNQ_DEVCFG_H
 
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/dma/xlnx_csu_dma.h b/include/hw/dma/xlnx_csu_dma.h
index 85b6b64e0e3..63af4586dd9 100644
--- a/include/hw/dma/xlnx_csu_dma.h
+++ b/include/hw/dma/xlnx_csu_dma.h
@@ -22,7 +22,7 @@
 #define XLNX_CSU_DMA_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/core/ptimer.h"
 #include "hw/stream.h"
 
diff --git a/include/hw/intc/xlnx-pmu-iomod-intc.h b/include/hw/intc/xlnx-pmu-iomod-intc.h
index ccc8bd272a2..e36b5e17629 100644
--- a/include/hw/intc/xlnx-pmu-iomod-intc.h
+++ b/include/hw/intc/xlnx-pmu-iomod-intc.h
@@ -26,7 +26,7 @@
 #define HW_INTC_XLNX_PMU_IOMOD_INTC_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_PMU_IO_INTC "xlnx.pmu_io_intc"
diff --git a/include/hw/intc/xlnx-zynqmp-ipi.h b/include/hw/intc/xlnx-zynqmp-ipi.h
index 33eff1d4f68..53fc89084af 100644
--- a/include/hw/intc/xlnx-zynqmp-ipi.h
+++ b/include/hw/intc/xlnx-zynqmp-ipi.h
@@ -26,7 +26,7 @@
 #define XLNX_ZYNQMP_IPI_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_ZYNQMP_IPI "xlnx.zynqmp_ipi"
diff --git a/include/hw/misc/allwinner-a10-dramc.h b/include/hw/misc/allwinner-a10-dramc.h
index b61fbecbe74..a1ae621e217 100644
--- a/include/hw/misc/allwinner-a10-dramc.h
+++ b/include/hw/misc/allwinner-a10-dramc.h
@@ -25,7 +25,7 @@
 
 #include "qom/object.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 /**
  * @name Constants
diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/xlnx-versal-cframe-reg.h
index 83f6a077446..fe8788a7453 100644
--- a/include/hw/misc/xlnx-versal-cframe-reg.h
+++ b/include/hw/misc/xlnx-versal-cframe-reg.h
@@ -18,7 +18,7 @@
 #define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/misc/xlnx-cfi-if.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "qemu/fifo32.h"
diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-versal-cfu.h
index 3de3ee49231..3d7ca506de1 100644
--- a/include/hw/misc/xlnx-versal-cfu.h
+++ b/include/hw/misc/xlnx-versal-cfu.h
@@ -18,7 +18,7 @@
 #define HW_MISC_XLNX_VERSAL_CFU_APB_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/misc/xlnx-cfi-if.h"
 #include "qemu/fifo32.h"
 
diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index 49ed500acde..ace3d198bde 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -11,7 +11,7 @@
 #define HW_MISC_XLNX_VERSAL_CRL_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "target/arm/cpu-qom.h"
 #include "hw/arm/xlnx-versal-version.h"
 
diff --git a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
index 0c4a4fd66d9..d8f45bd94b2 100644
--- a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
+++ b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
@@ -55,7 +55,7 @@
 #define XLNX_VERSAL_PMC_IOU_SLCR_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 #define TYPE_XILINX_VERSAL_PMC_IOU_SLCR "xlnx.versal-pmc-iou-slcr"
 
diff --git a/include/hw/misc/xlnx-versal-trng.h b/include/hw/misc/xlnx-versal-trng.h
index 4e516216dbe..8de29104048 100644
--- a/include/hw/misc/xlnx-versal-trng.h
+++ b/include/hw/misc/xlnx-versal-trng.h
@@ -28,7 +28,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 #define TYPE_XLNX_VERSAL_TRNG "xlnx.versal-trng"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalTRng, XLNX_VERSAL_TRNG);
diff --git a/include/hw/misc/xlnx-versal-xramc.h b/include/hw/misc/xlnx-versal-xramc.h
index 35e4e8b91dd..e79941d8865 100644
--- a/include/hw/misc/xlnx-versal-xramc.h
+++ b/include/hw/misc/xlnx-versal-xramc.h
@@ -10,7 +10,7 @@
 #define XLNX_VERSAL_XRAMC_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 #define TYPE_XLNX_XRAM_CTRL "xlnx.versal-xramc"
 
diff --git a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
index fbfe34aa7e5..c0315720053 100644
--- a/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
+++ b/include/hw/misc/xlnx-zynqmp-apu-ctrl.h
@@ -12,7 +12,7 @@
 #define HW_MISC_XLNX_ZYNQMP_APU_CTRL_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "target/arm/cpu-qom.h"
 
 #define TYPE_XLNX_ZYNQMP_APU_CTRL "xlnx.apu-ctrl"
diff --git a/include/hw/misc/xlnx-zynqmp-crf.h b/include/hw/misc/xlnx-zynqmp-crf.h
index c746ae10397..df83034a988 100644
--- a/include/hw/misc/xlnx-zynqmp-crf.h
+++ b/include/hw/misc/xlnx-zynqmp-crf.h
@@ -9,7 +9,7 @@
 #define HW_MISC_XLNX_ZYNQMP_CRF_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 #define TYPE_XLNX_ZYNQMP_CRF "xlnx.zynqmp_crf"
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPCRF, XLNX_ZYNQMP_CRF)
diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
index 45cf0001c6b..7cadf3123b5 100644
--- a/include/hw/net/xlnx-versal-canfd.h
+++ b/include/hw/net/xlnx-versal-canfd.h
@@ -28,7 +28,7 @@
 #ifndef HW_CANFD_XILINX_H
 #define HW_CANFD_XILINX_H
 
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/core/ptimer.h"
 #include "net/can_emu.h"
 #include "hw/core/qdev-clock.h"
diff --git a/include/hw/net/xlnx-zynqmp-can.h b/include/hw/net/xlnx-zynqmp-can.h
index d272f40ea80..d23c1523caf 100644
--- a/include/hw/net/xlnx-zynqmp-can.h
+++ b/include/hw/net/xlnx-zynqmp-can.h
@@ -31,7 +31,7 @@
 #define XLNX_ZYNQMP_CAN_H
 
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "net/can_emu.h"
 #include "net/can_host.h"
 #include "qemu/fifo32.h"
diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index 63558dbc329..27423035d40 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -30,7 +30,7 @@
 #include "hw/core/qdev.h"
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 #define RMAX_XLNX_BBRAM ((0x4c / 4) + 1)
 
diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
index 37d09da4809..07f1000a851 100644
--- a/include/hw/nvram/xlnx-versal-efuse.h
+++ b/include/hw/nvram/xlnx-versal-efuse.h
@@ -24,7 +24,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/nvram/xlnx-efuse.h"
 
 #define XLNX_VERSAL_EFUSE_CTRL_R_MAX ((0x100 / 4) + 1)
diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx-zynqmp-efuse.h
index 6eb3fea8fa2..d4886943860 100644
--- a/include/hw/nvram/xlnx-zynqmp-efuse.h
+++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
@@ -24,7 +24,7 @@
 
 #include "hw/core/irq.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/nvram/xlnx-efuse.h"
 
 #define XLNX_ZYNQMP_EFUSE_R_MAX ((0x10fc / 4) + 1)
diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 9e1275db8ae..4bd49bb5ae6 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -11,7 +11,7 @@
 #define PCIE_DOE_H
 
 #include "qemu/range.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 /*
  * Reference:
diff --git a/include/hw/rtc/xlnx-zynqmp-rtc.h b/include/hw/rtc/xlnx-zynqmp-rtc.h
index f0c6a2d78a8..a542b87cb89 100644
--- a/include/hw/rtc/xlnx-zynqmp-rtc.h
+++ b/include/hw/rtc/xlnx-zynqmp-rtc.h
@@ -27,7 +27,7 @@
 #ifndef HW_RTC_XLNX_ZYNQMP_RTC_H
 #define HW_RTC_XLNX_ZYNQMP_RTC_H
 
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/ssi/xlnx-versal-ospi.h b/include/hw/ssi/xlnx-versal-ospi.h
index 4ac975aa2fd..e8709208caa 100644
--- a/include/hw/ssi/xlnx-versal-ospi.h
+++ b/include/hw/ssi/xlnx-versal-ospi.h
@@ -52,7 +52,7 @@
 #ifndef XLNX_VERSAL_OSPI_H
 #define XLNX_VERSAL_OSPI_H
 
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/fifo8.h"
 #include "hw/dma/xlnx_csu_dma.h"
diff --git a/include/hw/usb/hcd-dwc3.h b/include/hw/usb/hcd-dwc3.h
index dbdf12b21d7..e656532d6c0 100644
--- a/include/hw/usb/hcd-dwc3.h
+++ b/include/hw/usb/hcd-dwc3.h
@@ -26,7 +26,7 @@
 #ifndef HCD_DWC3_H
 #define HCD_DWC3_H
 
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/usb/hcd-xhci.h"
 #include "hw/usb/hcd-xhci-sysbus.h"
 
diff --git a/include/hw/usb/xlnx-usb-subsystem.h b/include/hw/usb/xlnx-usb-subsystem.h
index 40f9e97e093..b22e5d065be 100644
--- a/include/hw/usb/xlnx-usb-subsystem.h
+++ b/include/hw/usb/xlnx-usb-subsystem.h
@@ -25,7 +25,7 @@
 #ifndef XLNX_USB_SUBSYSTEM_H
 #define XLNX_USB_SUBSYSTEM_H
 
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/sysbus.h"
 #include "hw/usb/xlnx-versal-usb2-ctrl-regs.h"
 #include "hw/usb/hcd-dwc3.h"
diff --git a/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h b/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h
index 6a502006b07..c1470da4758 100644
--- a/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h
+++ b/include/hw/usb/xlnx-versal-usb2-ctrl-regs.h
@@ -26,7 +26,7 @@
 #ifndef XLNX_VERSAL_USB2_CTRL_REGS_H
 #define XLNX_VERSAL_USB2_CTRL_REGS_H
 
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/sysbus.h"
 
 #define TYPE_XILINX_VERSAL_USB2_CTRL_REGS "xlnx.versal-usb2-ctrl-regs"
diff --git a/hw/core/register.c b/hw/core/register.c
index 81316d48597..c3f3c936e70 100644
--- a/hw/core/register.c
+++ b/hw/core/register.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 650401614ed..ffe258cf31a 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -28,7 +28,7 @@
 #include "system/dma.h"
 #include "hw/core/ptimer.h"
 #include "hw/stream.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/dma/xlnx_csu_dma.h"
 
 /*
diff --git a/hw/intc/xlnx-pmu-iomod-intc.c b/hw/intc/xlnx-pmu-iomod-intc.c
index f3509efa0ab..b8bafe2f3f3 100644
--- a/hw/intc/xlnx-pmu-iomod-intc.c
+++ b/hw/intc/xlnx-pmu-iomod-intc.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/intc/xlnx-zynqmp-ipi.c b/hw/intc/xlnx-zynqmp-ipi.c
index 99566bc2e20..e69ea74ff74 100644
--- a/hw/intc/xlnx-zynqmp-ipi.c
+++ b/hw/intc/xlnx-zynqmp-ipi.c
@@ -28,7 +28,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
index a5a5e41f3e3..efacbe83abb 100644
--- a/hw/misc/xlnx-versal-cframe-reg.c
+++ b/hw/misc/xlnx-versal-cframe-reg.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/core/registerfields.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
index 13cd597da49..bdce0ce7475 100644
--- a/hw/misc/xlnx-versal-cfu.c
+++ b/hw/misc/xlnx-versal-cfu.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/core/irq.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index b0baabc1adf..072d6d98591 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -12,7 +12,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/resettable.h"
 
 #include "target/arm/arm-powerctl.h"
diff --git a/hw/misc/xlnx-versal-pmc-iou-slcr.c b/hw/misc/xlnx-versal-pmc-iou-slcr.c
index 84d474c38fc..0246167a5e6 100644
--- a/hw/misc/xlnx-versal-pmc-iou-slcr.c
+++ b/hw/misc/xlnx-versal-pmc-iou-slcr.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/core/irq.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
diff --git a/hw/misc/xlnx-versal-xramc.c b/hw/misc/xlnx-versal-xramc.c
index 6a86f6b5d48..f4f02c7680b 100644
--- a/hw/misc/xlnx-versal-xramc.c
+++ b/hw/misc/xlnx-versal-xramc.c
@@ -11,7 +11,7 @@
 #include "qapi/error.h"
 #include "migration/vmstate.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/irq.h"
 #include "hw/misc/xlnx-versal-xramc.h"
diff --git a/hw/misc/xlnx-zynqmp-apu-ctrl.c b/hw/misc/xlnx-zynqmp-apu-ctrl.c
index 93f0bedc48e..957043f01b9 100644
--- a/hw/misc/xlnx-zynqmp-apu-ctrl.c
+++ b/hw/misc/xlnx-zynqmp-apu-ctrl.c
@@ -15,7 +15,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 
 #include "qemu/bitops.h"
 
diff --git a/hw/misc/xlnx-zynqmp-crf.c b/hw/misc/xlnx-zynqmp-crf.c
index 841bce2231c..a2ebf6ce5d7 100644
--- a/hw/misc/xlnx-zynqmp-crf.c
+++ b/hw/misc/xlnx-zynqmp-crf.c
@@ -8,7 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 94d9178a540..3ceb1a8b912 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -33,7 +33,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/net/can/xlnx-zynqmp-can.c b/hw/net/can/xlnx-zynqmp-can.c
index 533ac854a2f..6c583cab8f5 100644
--- a/hw/net/can/xlnx-zynqmp-can.c
+++ b/hw/net/can/xlnx-zynqmp-can.c
@@ -31,7 +31,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "hw/core/irq.h"
 #include "qapi/error.h"
 #include "qemu/bitops.h"
diff --git a/hw/rtc/ls7a_rtc.c b/hw/rtc/ls7a_rtc.c
index 54943f60b80..b0c6588e098 100644
--- a/hw/rtc/ls7a_rtc.c
+++ b/hw/rtc/ls7a_rtc.c
@@ -8,7 +8,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/timer.h"
 #include "system/system.h"
 #include "qemu/cutils.h"
diff --git a/hw/rtc/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
index 18849340d62..49d48dc6782 100644
--- a/hw/rtc/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index e3c6035c169..a56a5e304dc 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -32,7 +32,7 @@
 #include "qemu/bitops.h"
 #include "hw/ssi/xilinx_spips.h"
 #include "qapi/error.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "system/dma.h"
 #include "migration/blocker.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/hcd-dwc3.c b/hw/usb/hcd-dwc3.c
index 74dff39fda1..4018d70f02f 100644
--- a/hw/usb/hcd-dwc3.c
+++ b/hw/usb/hcd-dwc3.c
@@ -29,7 +29,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "migration/vmstate.h"
diff --git a/hw/usb/xlnx-usb-subsystem.c b/hw/usb/xlnx-usb-subsystem.c
index 7193dd4cd2c..e0dfdfdcbd1 100644
--- a/hw/usb/xlnx-usb-subsystem.c
+++ b/hw/usb/xlnx-usb-subsystem.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "qapi/error.h"
diff --git a/hw/usb/xlnx-versal-usb2-ctrl-regs.c b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
index eb946b5dbd9..33a7d7fbca0 100644
--- a/hw/usb/xlnx-versal-usb2-ctrl-regs.c
+++ b/hw/usb/xlnx-versal-usb2-ctrl-regs.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/register.h"
+#include "hw/core/register.h"
 #include "qemu/bitops.h"
 #include "qom/object.h"
 #include "migration/vmstate.h"
-- 
2.51.1


