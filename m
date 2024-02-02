Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A709C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvbB-0000it-Cz; Fri, 02 Feb 2024 10:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb3-0000L1-CI
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvb0-0004UZ-IJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:52 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40fc549ab9bso7537635e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888209; x=1707493009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I3JpUFeuz8JEq3ye2dfNhThlFiBiIs8gN5QDvvRsL0g=;
 b=yNXji4qhm1LYe/mx45v3f+8lbclOs/8GtxzTw3kGUrwI2zZdqDVbDr0V2ysr6NQWnt
 F+fQ9sSQEXrqNN6AgYICLai2lMI+ehcLsYHfLffJixza2TC64vFjm9gaFNB49uF1KNo9
 a6tXkDLxlhefk0rDpl7J2QIlbRMW/Zj9dOZd/JY6Pb7afWV1+ixHTa+Goqj9XIGloFAf
 YE2P0HlscVCfHF/rdzBwRBjHZEDpqN7T+2xW550rmn3l1NW82ES6JrtZc+Wr9TUjIxj6
 +2J967BPZ/oh+OJ5Xkpf5kbCF/f/Hc8IktqxAi0WRL3k4ehMAPwjEOcwu28es0pm054u
 g+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888209; x=1707493009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I3JpUFeuz8JEq3ye2dfNhThlFiBiIs8gN5QDvvRsL0g=;
 b=ECCQ+v1z6qInZne2SD/meu8U2DBAik799M+AxOKexXSCFYTyHc/ZEGpo9NqqUXwU0f
 TxHkRpFcJT8MCxiFzbVNEu5tYhGM7SSRuq8mmi0DzSNMSwG2JvARGY/DzI2zeqhbC3MD
 CIwd+B7QFDtoydU3MbTJDNWbDpV5mO2tYrRrD4K0QxOOfZjOMJu9IM0lD01jiGRmJKSp
 A0ddT5Aq8i9qTK7WsvTwLJ/hRjnJyQVTRQ0k66XqvDVFQhc67fFXXUcqJin/Fb3fAoIn
 Fx/1LQm5+9XhiQypnNpf6Z0JwBcdxlA+5PoaEQM3XPGzVroYzIWqoMY+mnxLa+9x9qpI
 e9uA==
X-Gm-Message-State: AOJu0YztOvwu/2FxG9exCEOTW+HcPxSwDs7rNbtkYjr8coOkHhTcxAhI
 /sukfBsMFL8XFITQhyQA1I5BvxToSlair+wjmuc3/9HL1ZewQioCB/YRhkvLSLT+EwSgW3MyqvP
 +
X-Google-Smtp-Source: AGHT+IHvijeREeWEfwB+wQk6zlSaRP9lSiacdiK9UNU9yVjX7IrcRZQDylI9zwfv1nq3G7xPTo7cLA==
X-Received: by 2002:a05:600c:524e:b0:40e:f222:9e52 with SMTP id
 fc14-20020a05600c524e00b0040ef2229e52mr1677514wmb.40.1706888209179; 
 Fri, 02 Feb 2024 07:36:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/36] hw/arm/strongarm.c: convert DPRINTF to trace events and
 guest errors
Date: Fri,  2 Feb 2024 15:36:24 +0000
Message-Id: <20240202153637.3710444-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on trace events should be able to opt-in to each trace event and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into trace events. DPRINTFs that report guest errors are logged with
LOG_GUEST_ERROR.#

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 39db71dd87bf2007cf7812f3d91dde53887f1f2f.1706544115.git.manos.pitsidianakis@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/strongarm.c  | 82 ++++++++++++++++++++++++++++-----------------
 hw/arm/trace-events |  3 ++
 2 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 7fd99a0f144..823b4931b0a 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -46,8 +46,7 @@
 #include "qemu/log.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
-
-//#define DEBUG
+#include "trace.h"
 
 /*
  TODO
@@ -66,12 +65,6 @@
  - Enhance UART with modem signals
  */
 
-#ifdef DEBUG
-# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
-#else
-# define DPRINTF(format, ...) do { } while (0)
-#endif
-
 static struct {
     hwaddr io_base;
     int irq;
@@ -151,8 +144,9 @@ static uint64_t strongarm_pic_mem_read(void *opaque, hwaddr offset,
     case ICPR:
         return s->pending;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad register offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
         return 0;
     }
 }
@@ -173,8 +167,9 @@ static void strongarm_pic_mem_write(void *opaque, hwaddr offset,
         s->int_idle = (value & 1) ? 0 : ~0;
         break;
     default:
-        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
-                        __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                     "%s: Bad register offset 0x"HWADDR_FMT_plx"\n",
+                     __func__, offset);
         break;
     }
     strongarm_pic_update(s);
@@ -333,7 +328,9 @@ static uint64_t strongarm_rtc_read(void *opaque, hwaddr addr,
                 ((qemu_clock_get_ms(rtc_clock) - s->last_hz) << 15) /
                 (1000 * ((s->rttr & 0xffff) + 1));
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad rtc register read 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -375,7 +372,9 @@ static void strongarm_rtc_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad rtc register write 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
     }
 }
 
@@ -556,12 +555,12 @@ static uint64_t strongarm_gpio_read(void *opaque, hwaddr offset,
 
     case GPSR:        /* GPIO Pin-Output Set registers */
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "strongarm GPIO: read from write only register GPSR\n");
+                      "%s: read from write only register GPSR\n", __func__);
         return 0;
 
     case GPCR:        /* GPIO Pin-Output Clear registers */
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "strongarm GPIO: read from write only register GPCR\n");
+                      "%s: read from write only register GPCR\n", __func__);
         return 0;
 
     case GRER:        /* GPIO Rising-Edge Detect Enable registers */
@@ -581,7 +580,9 @@ static uint64_t strongarm_gpio_read(void *opaque, hwaddr offset,
         return s->status;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad gpio read offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -626,7 +627,9 @@ static void strongarm_gpio_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
     }
 }
 
@@ -782,7 +785,9 @@ static uint64_t strongarm_ppc_read(void *opaque, hwaddr offset,
         return s->ppfr | ~0x7f001;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ppc read offset 0x"HWADDR_FMT_plx "\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -817,7 +822,9 @@ static void strongarm_ppc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        printf("%s: Bad offset 0x" HWADDR_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ppc write offset 0x"HWADDR_FMT_plx"\n",
+                      __func__, offset);
     }
 }
 
@@ -1029,8 +1036,13 @@ static void strongarm_uart_update_parameters(StrongARMUARTState *s)
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
 
-    DPRINTF(stderr, "%s speed=%d parity=%c data=%d stop=%d\n", s->chr->label,
-            speed, parity, data_bits, stop_bits);
+    trace_strongarm_uart_update_parameters((s->chr.chr ?
+                                           s->chr.chr->label : "NULL") ?:
+                                           "NULL",
+                                           speed,
+                                           parity,
+                                           data_bits,
+                                           stop_bits);
 }
 
 static void strongarm_uart_rx_to(void *opaque)
@@ -1164,7 +1176,9 @@ static uint64_t strongarm_uart_read(void *opaque, hwaddr addr,
         return s->utsr1;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad uart register read 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -1221,7 +1235,9 @@ static void strongarm_uart_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad uart register write 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1434,7 +1450,7 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
             return 0xffffffff;
         }
         if (s->rx_level < 1) {
-            printf("%s: SSP Rx Underrun\n", __func__);
+            trace_strongarm_ssp_read_underrun();
             return 0xffffffff;
         }
         s->rx_level--;
@@ -1443,7 +1459,9 @@ static uint64_t strongarm_ssp_read(void *opaque, hwaddr addr,
         strongarm_ssp_fifo_update(s);
         return retval;
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ssp register read 0x"HWADDR_FMT_plx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1458,8 +1476,8 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR0:
         s->sscr[0] = value & 0xffbf;
         if ((s->sscr[0] & SSCR0_SSE) && SSCR0_DSS(value) < 4) {
-            printf("%s: Wrong data size: %i bits\n", __func__,
-                   (int)SSCR0_DSS(value));
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Wrong data size: %i bits\n",
+                          __func__, (int)SSCR0_DSS(value));
         }
         if (!(value & SSCR0_SSE)) {
             s->sssr = 0;
@@ -1471,7 +1489,9 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
     case SSCR1:
         s->sscr[1] = value & 0x2f;
         if (value & SSCR1_LBM) {
-            printf("%s: Attempt to use SSP LBM mode\n", __func__);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Attempt to use SSP LBM mode\n",
+                          __func__);
         }
         strongarm_ssp_fifo_update(s);
         break;
@@ -1509,7 +1529,9 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register 0x" HWADDR_FMT_plx "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad ssp register write 0x"HWADDR_FMT_plx"\n",
+                      __func__,  addr);
         break;
     }
 }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cdc1ea06a81..7c569432150 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,3 +55,6 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# strongarm.c
+strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
+strongarm_ssp_read_underrun(void) "SSP rx underrun"
-- 
2.34.1


