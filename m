Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6347E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQK-0002Zx-FG; Sat, 27 Dec 2025 04:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQG-0002Y7-Fn
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQC-0002Pp-1g
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAPNHDeDnVTBZPtsdYZ4vNsLhPqjrTIxBmnpOYzbcEI=;
 b=I5rYKOTuiO8jglsQCNkb4z4oHtdrOPAxnoAvFX+owYOCvpaBVWepc2Ss2mMsvennkKSD13
 l6m2Ujl4xyPlivO6l8fqFahf1zG2sJEVacd7+TZWzeezR3HNpJgbMQn6+izLXk1oTqV3/y
 y7Csjwa2LkjS74OVvqkeuuut7vN0JOA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-GEfQPRwEN_2Vd5mvd3U7JA-1; Sat, 27 Dec 2025 04:17:09 -0500
X-MC-Unique: GEfQPRwEN_2Vd5mvd3U7JA-1
X-Mimecast-MFC-AGG-ID: GEfQPRwEN_2Vd5mvd3U7JA_1766827028
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47d3c4468d8so15091925e9.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827027; x=1767431827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EAPNHDeDnVTBZPtsdYZ4vNsLhPqjrTIxBmnpOYzbcEI=;
 b=BNKHrVT58UoRXgRFLBYtiJBJHJ6jTC7RK6ySu630jLDfHH2fFaik75jM6Ceg/17838
 24RdG8p24+tZBL5vykbJOzM5F/26eVVLCYdOEKFlAJlTO2srI2ju65PtnMq4ms6lHUzX
 4S2EW3ZqKtxw8r/6Q3jmdS/u7iyk6ShjlABDSu1+ammLx0sNDEgNl6d8/m+Oh0l+Jbrd
 GH9BHRePM0gO2qBwDPsOb/myCzp5dzYTITj4jFRt2cfOL+KV3beJr4QnNqGpFpT8qUmx
 4TpK9Sv6hydQ7ARws7LudOZV/hvYVdicgvhaJnu3VkkJQSO7QO7gHWpETPh0P4Ie0Uiq
 UWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827027; x=1767431827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EAPNHDeDnVTBZPtsdYZ4vNsLhPqjrTIxBmnpOYzbcEI=;
 b=Vwuau8B6oQnuEiO3c92cCiK5JlNNSbdaLM9DVKCB1mOAhXDvdhOs6V6w4e6UdPpdF6
 DiWli88e6oFvNzLxsVVlETfkg6A7D4HBKZv8UQKp/vg4aQXh+a3pkIULma6XsQ05qrY4
 F6+x25ckPolmDmZrV+wdMqVGgx1W7rm9J0uZJ7jZDmSZGcO++cSumfbf30X8pXwaWvUA
 u1+1OMqzsMVATYcG/OxMIjHiigHkFU1DoZEDkVjvAfdDzA0awlChxtpop1X4trgf4n00
 ap74CODYf8YtsYMXq2fbKElkM1/X0vEEt0bNZevu7UbJvTEl4COpQ7vrdEtK8aJ6tMju
 0O/w==
X-Gm-Message-State: AOJu0YzwPWBkslmAR3MpvvegbYKXWbpyAoUegEpX6D8XyH/8nPMe5o2G
 B1ppG6Qk9fjrPFycDNpEMKXNxv7hevL0mLCmwYwn1lVhCMqyKNmg2elzl1Bx6LWBkvfd/UOmLvc
 r1Fn9d+vkzHh0Z93IM4B8xWQEDbVfHIy54CLE8UIdrvF8dMvYTY5tcPZTGiYvCeUZVSmj39gS9m
 CO5zjFw/oOGSnvV8UkBa4+8Z2Jmtbo9S1LXC5+q3oe
X-Gm-Gg: AY/fxX7266mIx6y2umj3DXp0wHrxWATJGeSnO1UDQU+RKPZ9fjIYaQ1sf4h1t9Ot4Ay
 4B+jY99TaeXWotm+71sh/zEpYjQPYJbsszGhdnoVqW96u3CVdYtOCRLlGfOwsyWrkGuvxzIOhYr
 IYkXjpIEXez1pGZseByoMoVvRBZAXByZ1qe9D+CGCCYtqa10EII7Mb/ldxyIuzMtqjkkV7Gv8G5
 9KKKHkmqaTKvuRKxR6rtlMN/h3rbW3cktifV3DoaPSYPX6k70Gyu8WVTEVLBcCEow3u3ruPjmTv
 Yd7nZFsj67J1lGkrCPDvFUQixypBN15Jrc9KWzY+BF1dzGSPIvF0T39quBXM+GbfnTAmS/lZDsz
 gPRZ55XLXZHBSvu2b8BveXi3RJRTR/6TJ6/POyyzjVJf9IaHmDVp6aLrMh3WhA2Alph5P6zOAqF
 /kmYhsNa7WPDFQEYM=
X-Received: by 2002:a05:600c:6388:b0:477:7b16:5f88 with SMTP id
 5b1f17b1804b1-47d1953345cmr252589575e9.6.1766827026394; 
 Sat, 27 Dec 2025 01:17:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFff8IBSuSqPPNoQrZWDyEaTRSd77kDMKbRx8xzM/I0jdqdVgK38QqqXn0DQFJ/zw9cFFIfvg==
X-Received: by 2002:a05:600c:6388:b0:477:7b16:5f88 with SMTP id
 5b1f17b1804b1-47d1953345cmr252589295e9.6.1766827025481; 
 Sat, 27 Dec 2025 01:17:05 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3a4651bsm191146895e9.7.2025.12.27.01.17.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 023/153] include: move hw/register.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:10 +0100
Message-ID: <20251227091622.20725-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
index e0904cc0cc7..b38215954a2 100644
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
2.52.0


