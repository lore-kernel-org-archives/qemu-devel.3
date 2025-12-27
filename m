Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA80E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQ3-0002UT-FY; Sat, 27 Dec 2025 04:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQ1-0002To-MV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPz-0002Lu-AP
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyFzvwWwzZP1cmLWJexrLce9Jt9k/RT/l754HFIGcZ8=;
 b=d4qOTyMGlBwM2xVJBVttnY+t2D7lNERV3IF8GQhFBvhDdgwoaKA9TCyhVHcp+AMBxvwdCF
 /ZFwJPd+dapZjhHSGqJOs3YUX/hF5IhDpLGy+ed5zQoztszfC1Sei9n8Tlb4nW4lF1qHT/
 QT4uKYVYj5E889LQnShyno2eeQlnqow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-nxeeyZ0bMPKtz2NbJdYyeA-1; Sat, 27 Dec 2025 04:16:56 -0500
X-MC-Unique: nxeeyZ0bMPKtz2NbJdYyeA-1
X-Mimecast-MFC-AGG-ID: nxeeyZ0bMPKtz2NbJdYyeA_1766827016
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43101a351c7so6156922f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827015; x=1767431815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qyFzvwWwzZP1cmLWJexrLce9Jt9k/RT/l754HFIGcZ8=;
 b=HqAQAuX6iXBqvVxxBrQMLZVnTfOssRwnxt0fG+SgvJp3rVO4CzkTvc7CFU8rqeXlCU
 /cZVlopAJIg/VA2MZA6R4b1Z0M7zZw/8y/6e++aYVgdiXQiSJNzGFBnuRm7LEnB9HtdJ
 pq/9tv2FGstTPmn8KE1cXoOO/42iVfCUP8mpLvn18u/j8+dA1y3sKL6o8uZ1v3cJXbeT
 w4YMHEllPuzZuLOO35mBRdJYHiPPzKLwGpRgKhln4Jr8B5yNgKJisXBikQ2Bz5DB9pAe
 ny6wW9BI8o9gfhUU6q0TE5LtWPtuYsi1coA4ZkxfTrmUyIl4PVnHyRa+pDtLmwX5ex1O
 S+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827015; x=1767431815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qyFzvwWwzZP1cmLWJexrLce9Jt9k/RT/l754HFIGcZ8=;
 b=YF1uoIDnlyDmwmKSL83FGnnGlwUmclPB94sDe/FiB1I2JJMLAyOgK3du7fO4wLt24z
 nG5KY7u9hgkO/aPlidGVDJ3SnAh5ULj3jbzt8oSj89QPPDJtG4fFeLv4Gs4C8gEIoqGK
 YudmY5/MjkpbHUUIpZfuntdFcmyUjEQFkSCq2a0nngdbmFZ5LGnHu+2mQTsxXAQq24em
 KBCIvBG/ki9j5mQS60s2l8GZwSMt0VOQ2PWTCVTQYK6kU8y4/dKx9tJRLNNA6f5/h2S9
 bIq0JtpYkhB3sN4FvG/JHC3qYRuHA5D1+LdZedRXp0LqzfLkJDvEctCSh2lI+uQodpBr
 el6A==
X-Gm-Message-State: AOJu0YwU2+h3m1ryrX+tculOlSTdKCHklsBo7WcNOuTkPn44FUZjlTuf
 mHTUd1kgxakRW6nohhLO9umfhg0D4CWpDQz+uAWveSSjgOCa6oTf9jx8b9rErILtOcWbPvv6NwS
 5exD1Xey1AFxBU6c+d91FUvv9hZ5W4JHxQ+2B8SUpmdaNWCzJGllPJh4v4wbof/3oDnoFerDWz9
 pZXQxE60MkO3JgI563eeSKU6EW8e/hxr6aNmL6BZk1
X-Gm-Gg: AY/fxX7ZyLPkW2XqAsvfI8pUAUX2NfEceAxIt4onfTW8g9SytqqG4nTt9eYBBuTVM3I
 KgvGFGBCoDye9zmtPPocjiZa1re5un7JyQrqVaoa8TA39dnPg+R+IIPU+Se3JQsVEbf/TSI7UwB
 gMTObdY5Mz2fWyDrKSuloDI5MnBLgS7qdmckWuJ9hIpvCgFAbNBlXa1dpTZexBV2SHHWXnhKOd4
 1xLZM/yBZrlJ4NXA3IQJWh1MpBgijmbMfOSDf+8aaWFeMxxr8uN+H2a7ilUb++VzONU09g6VNVH
 MuWxGhChaZhQG3Brf5p4KmRfkq2SdhQ05HZpzz69eoUPTmByupqS52MKk4eTdeeYXKflk/86LWN
 +XwtsSeR7GKd0Bo1+y5Bm1dLEukK4GEnVj4oOe61gspHcRH9sunDIMKOrA6ZVWmZWgLtIOSRgXb
 Pna7HCsHKnvX6ByGw=
X-Received: by 2002:a05:6000:200f:b0:430:f879:a0ee with SMTP id
 ffacd0b85a97d-4324e4c1259mr32288262f8f.5.1766827014523; 
 Sat, 27 Dec 2025 01:16:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP35zIqqUpm7CC+vVW5D4R27gd39sZVUljQ01LeOYOb2RKnripisqV74f3m6FbcfMQEVQTuQ==
X-Received: by 2002:a05:6000:200f:b0:430:f879:a0ee with SMTP id
 ffacd0b85a97d-4324e4c1259mr32288222f8f.5.1766827013769; 
 Sat, 27 Dec 2025 01:16:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea8311fsm50393044f8f.28.2025.12.27.01.16.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 016/153] include: move hw/ptimer.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:03 +0100
Message-ID: <20251227091622.20725-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 hw/net/fsl_etsec/etsec.h                 | 2 +-
 include/hw/{ => core}/ptimer.h           | 0
 include/hw/display/xlnx_dp.h             | 2 +-
 include/hw/dma/xlnx_csu_dma.h            | 2 +-
 include/hw/net/xlnx-versal-canfd.h       | 2 +-
 include/hw/net/xlnx-zynqmp-can.h         | 2 +-
 include/hw/timer/allwinner-a10-pit.h     | 2 +-
 include/hw/timer/armv7m_systick.h        | 2 +-
 include/hw/timer/cmsdk-apb-dualtimer.h   | 2 +-
 include/hw/timer/cmsdk-apb-timer.h       | 2 +-
 include/hw/timer/digic-timer.h           | 2 +-
 include/hw/timer/imx_epit.h              | 2 +-
 include/hw/timer/imx_gpt.h               | 2 +-
 include/hw/timer/mss-timer.h             | 2 +-
 include/hw/watchdog/allwinner-wdt.h      | 2 +-
 include/hw/watchdog/cmsdk-apb-watchdog.h | 2 +-
 include/hw/watchdog/wdt_imx2.h           | 2 +-
 hw/arm/musicpal.c                        | 2 +-
 hw/core/ptimer.c                         | 2 +-
 hw/dma/xilinx_axidma.c                   | 2 +-
 hw/dma/xlnx_csu_dma.c                    | 2 +-
 hw/m68k/mcf5206.c                        | 2 +-
 hw/m68k/mcf5208.c                        | 2 +-
 hw/net/fsl_etsec/etsec.c                 | 2 +-
 hw/net/lan9118.c                         | 2 +-
 hw/rtc/exynos4210_rtc.c                  | 2 +-
 hw/sparc/leon3.c                         | 2 +-
 hw/ssi/xilinx_spips.c                    | 2 +-
 hw/timer/arm_mptimer.c                   | 2 +-
 hw/timer/arm_timer.c                     | 2 +-
 hw/timer/digic-timer.c                   | 2 +-
 hw/timer/exynos4210_mct.c                | 2 +-
 hw/timer/exynos4210_pwm.c                | 2 +-
 hw/timer/grlib_gptimer.c                 | 2 +-
 hw/timer/sh_timer.c                      | 2 +-
 hw/timer/slavio_timer.c                  | 2 +-
 hw/timer/xilinx_timer.c                  | 2 +-
 tests/unit/ptimer-test.c                 | 2 +-
 38 files changed, 37 insertions(+), 37 deletions(-)
 rename include/hw/{ => core}/ptimer.h (100%)

diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index bd2de3f99c7..ca8ad5638a3 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -27,7 +27,7 @@
 
 #include "hw/sysbus.h"
 #include "net/net.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "qom/object.h"
 
 /* Buffer Descriptors */
diff --git a/include/hw/ptimer.h b/include/hw/core/ptimer.h
similarity index 100%
rename from include/hw/ptimer.h
rename to include/hw/core/ptimer.h
diff --git a/include/hw/display/xlnx_dp.h b/include/hw/display/xlnx_dp.h
index af859e477da..9ec5a90c342 100644
--- a/include/hw/display/xlnx_dp.h
+++ b/include/hw/display/xlnx_dp.h
@@ -35,7 +35,7 @@
 #include "hw/dma/xlnx_dpdma.h"
 #include "qemu/audio.h"
 #include "qom/object.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 
 #define AUD_CHBUF_MAX_DEPTH                 (32 * KiB)
 #define MAX_QEMU_BUFFER_SIZE                (4 * KiB)
diff --git a/include/hw/dma/xlnx_csu_dma.h b/include/hw/dma/xlnx_csu_dma.h
index 922ab80eb61..85b6b64e0e3 100644
--- a/include/hw/dma/xlnx_csu_dma.h
+++ b/include/hw/dma/xlnx_csu_dma.h
@@ -23,7 +23,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/register.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/stream.h"
 
 #define TYPE_XLNX_CSU_DMA "xlnx.csu_dma"
diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
index 396f90d6dc1..d2e582918fb 100644
--- a/include/hw/net/xlnx-versal-canfd.h
+++ b/include/hw/net/xlnx-versal-canfd.h
@@ -29,7 +29,7 @@
 #define HW_CANFD_XILINX_H
 
 #include "hw/register.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "net/can_emu.h"
 #include "hw/qdev-clock.h"
 
diff --git a/include/hw/net/xlnx-zynqmp-can.h b/include/hw/net/xlnx-zynqmp-can.h
index fd2aa777603..8262f11d33d 100644
--- a/include/hw/net/xlnx-zynqmp-can.h
+++ b/include/hw/net/xlnx-zynqmp-can.h
@@ -35,7 +35,7 @@
 #include "net/can_emu.h"
 #include "net/can_host.h"
 #include "qemu/fifo32.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-clock.h"
 
 #define TYPE_XLNX_ZYNQMP_CAN "xlnx.zynqmp-can"
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index 8435758ad68..623a1fec219 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -1,7 +1,7 @@
 #ifndef ALLWINNER_A10_PIT_H
 #define ALLWINNER_A10_PIT_H
 
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/armv7m_systick.h b/include/hw/timer/armv7m_systick.h
index ac7de0a43ef..fb73f78a7b8 100644
--- a/include/hw/timer/armv7m_systick.h
+++ b/include/hw/timer/armv7m_systick.h
@@ -14,7 +14,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
 
 #define TYPE_SYSTICK "armv7m_systick"
diff --git a/include/hw/timer/cmsdk-apb-dualtimer.h b/include/hw/timer/cmsdk-apb-dualtimer.h
index f098128a588..103ac228815 100644
--- a/include/hw/timer/cmsdk-apb-dualtimer.h
+++ b/include/hw/timer/cmsdk-apb-dualtimer.h
@@ -27,7 +27,7 @@
 #define CMSDK_APB_DUALTIMER_H
 
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/cmsdk-apb-timer.h b/include/hw/timer/cmsdk-apb-timer.h
index 74eaf611aeb..f8c8fb8ce55 100644
--- a/include/hw/timer/cmsdk-apb-timer.h
+++ b/include/hw/timer/cmsdk-apb-timer.h
@@ -13,7 +13,7 @@
 #define CMSDK_APB_TIMER_H
 
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/digic-timer.h b/include/hw/timer/digic-timer.h
index da82fb46637..f62242eaad3 100644
--- a/include/hw/timer/digic-timer.h
+++ b/include/hw/timer/digic-timer.h
@@ -19,7 +19,7 @@
 #define HW_TIMER_DIGIC_TIMER_H
 
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "qom/object.h"
 
 #define TYPE_DIGIC_TIMER "digic-timer"
diff --git a/include/hw/timer/imx_epit.h b/include/hw/timer/imx_epit.h
index 79aff0cec20..2947fad1069 100644
--- a/include/hw/timer/imx_epit.h
+++ b/include/hw/timer/imx_epit.h
@@ -30,7 +30,7 @@
 #define IMX_EPIT_H
 
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/misc/imx_ccm.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/imx_gpt.h b/include/hw/timer/imx_gpt.h
index 5488f7e4df5..5c12f686e1b 100644
--- a/include/hw/timer/imx_gpt.h
+++ b/include/hw/timer/imx_gpt.h
@@ -30,7 +30,7 @@
 #define IMX_GPT_H
 
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/misc/imx_ccm.h"
 #include "qom/object.h"
 
diff --git a/include/hw/timer/mss-timer.h b/include/hw/timer/mss-timer.h
index da38512904e..0cc376f945f 100644
--- a/include/hw/timer/mss-timer.h
+++ b/include/hw/timer/mss-timer.h
@@ -26,7 +26,7 @@
 #define HW_MSS_TIMER_H
 
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "qom/object.h"
 
 #define TYPE_MSS_TIMER     "mss-timer"
diff --git a/include/hw/watchdog/allwinner-wdt.h b/include/hw/watchdog/allwinner-wdt.h
index 7fe41e20f2e..6f84dbd1a72 100644
--- a/include/hw/watchdog/allwinner-wdt.h
+++ b/include/hw/watchdog/allwinner-wdt.h
@@ -24,7 +24,7 @@
 #define HW_WATCHDOG_ALLWINNER_WDT_H
 
 #include "qom/object.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/sysbus.h"
 
 /*
diff --git a/include/hw/watchdog/cmsdk-apb-watchdog.h b/include/hw/watchdog/cmsdk-apb-watchdog.h
index 5bbf4979c9f..9bf95ba06d5 100644
--- a/include/hw/watchdog/cmsdk-apb-watchdog.h
+++ b/include/hw/watchdog/cmsdk-apb-watchdog.h
@@ -32,7 +32,7 @@
 #define CMSDK_APB_WATCHDOG_H
 
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/core/clock.h"
 #include "qom/object.h"
 
diff --git a/include/hw/watchdog/wdt_imx2.h b/include/hw/watchdog/wdt_imx2.h
index ddc49aaea4f..53a8360e906 100644
--- a/include/hw/watchdog/wdt_imx2.h
+++ b/include/hw/watchdog/wdt_imx2.h
@@ -15,7 +15,7 @@
 #include "qemu/bitops.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "qom/object.h"
 
 #define TYPE_IMX2_WDT "imx2.wdt"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 100a9f59b3f..a4ddc0d08f9 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -21,7 +21,7 @@
 #include "hw/core/boards.h"
 #include "hw/char/serial-mm.h"
 #include "qemu/timer.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index a7337f02b8d..e42e06fa4de 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "migration/vmstate.h"
 #include "qemu/host-utils.h"
 #include "exec/replay-core.h"
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 9b05080ae59..15da3fcbc2c 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -28,7 +28,7 @@
 #include "qemu/timer.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
index 0b1185325ba..92f445034e8 100644
--- a/hw/dma/xlnx_csu_dma.c
+++ b/hw/dma/xlnx_csu_dma.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/stream.h"
 #include "hw/register.h"
 #include "hw/dma/xlnx_csu_dma.h"
diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 4cf86d510b3..e17da4fd209 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -15,7 +15,7 @@
 #include "hw/core/irq.h"
 #include "hw/m68k/mcf.h"
 #include "qemu/timer.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "system/system.h"
 #include "hw/sysbus.h"
 
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b81305ae6e4..3a87e1f282c 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -25,7 +25,7 @@
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
 #include "qemu/timer.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "system/system.h"
 #include "system/qtest.h"
 #include "net/net.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 6ae8a1e1a3c..e6a29d9ec6d 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -30,7 +30,7 @@
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
 #include "hw/net/mii.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "etsec.h"
 #include "registers.h"
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 1c9bb4807d2..191fd8b421b 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -18,7 +18,7 @@
 #include "hw/core/irq.h"
 #include "hw/net/lan9118_phy.h"
 #include "hw/net/lan9118.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/bswap.h"
diff --git a/hw/rtc/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
index a7e17031ca8..a15b5274bd3 100644
--- a/hw/rtc/exynos4210_rtc.c
+++ b/hw/rtc/exynos4210_rtc.c
@@ -32,7 +32,7 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/bcd.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 
 #include "hw/core/irq.h"
 
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index cd1a03a5584..50f1cf91706 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -32,7 +32,7 @@
 #include "cpu.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "system/system.h"
 #include "system/qtest.h"
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index b2f66275182..5fa9bf965ff 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index ac6313039a8..adec87cc8d2 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -22,7 +22,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "hw/timer/arm_mptimer.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index e5ef28de6f7..8d8b250698c 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -12,7 +12,7 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
diff --git a/hw/timer/digic-timer.c b/hw/timer/digic-timer.c
index 355138d3547..12b79914df0 100644
--- a/hw/timer/digic-timer.c
+++ b/hw/timer/digic-timer.c
@@ -28,7 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 06524efca27..f6527a451b6 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -58,7 +58,7 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/module.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 
 #include "hw/arm/exynos4210.h"
 #include "hw/core/irq.h"
diff --git a/hw/timer/exynos4210_pwm.c b/hw/timer/exynos4210_pwm.c
index dc76932fdfb..1643fa39418 100644
--- a/hw/timer/exynos4210_pwm.c
+++ b/hw/timer/exynos4210_pwm.c
@@ -26,7 +26,7 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "qemu/module.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 
 #include "hw/arm/exynos4210.h"
 #include "hw/core/irq.h"
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 6218c255d2c..82d0d9d7622 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -29,7 +29,7 @@
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 
diff --git a/hw/timer/sh_timer.c b/hw/timer/sh_timer.c
index adc05715528..41ece9c6136 100644
--- a/hw/timer/sh_timer.c
+++ b/hw/timer/sh_timer.c
@@ -14,7 +14,7 @@
 #include "hw/core/irq.h"
 #include "hw/sh4/sh.h"
 #include "hw/timer/tmu012.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "trace.h"
 
 #define TIMER_TCR_TPSC          (7 << 0)
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 5bf94157ca4..f66b3aaa433 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index c1b6d2bdf2d..fbc10015916 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -29,7 +29,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/core/irq.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "qemu/log.h"
diff --git a/tests/unit/ptimer-test.c b/tests/unit/ptimer-test.c
index 08240594bbd..6de658812b1 100644
--- a/tests/unit/ptimer-test.c
+++ b/tests/unit/ptimer-test.c
@@ -12,7 +12,7 @@
 #include <glib/gprintf.h>
 
 #include "qemu/main-loop.h"
-#include "hw/ptimer.h"
+#include "hw/core/ptimer.h"
 
 #include "ptimer-test.h"
 
-- 
2.52.0


