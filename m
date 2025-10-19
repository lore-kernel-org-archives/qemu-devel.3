Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766B0CCD1A4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 21:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAaZ1-0007Om-4K; Sun, 19 Oct 2025 17:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYy-0007Nv-Gi
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:37 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vAaYv-00020X-Ln
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 17:03:36 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63c0eb94ac3so6390658a12.2
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760907812; x=1761512612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8oXWw/dktgNDXuS33Gpiga0QxIzazhu/qxi0riXcZ8=;
 b=l4Jvy26MOGYbnAbYUONnTEj9rCv2eYR98vQ1+Xr6wmViLyUlCCpZIC1UjzSKuAfIlY
 WHPsuiXON0hyw9///0ypX8Y2FKQybBK6gAAlJGBgRAhFNi/r082LvqsBm4y4uppix3Xc
 cYiPkzgvg2uO+mCft2QBaosHDcofQIUeRxB06GLv9pXOlJfv1hTwdeITY7DMXRh8lmgL
 1iCfiHv5S4SQ4lcI1JR+r0kHi4cfzlYzKVOQ3uilTqcNA+BVz/JZ9NbiIzh9n+WAyPn5
 7JTiCyLXvvSOGPSFiOB1LJAkLQLTKxkmRot50H/VYHCi9yPJEDfh7groFgFlkF86rnzO
 R5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760907812; x=1761512612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8oXWw/dktgNDXuS33Gpiga0QxIzazhu/qxi0riXcZ8=;
 b=N6+3ipwbk3aiMgudtLtUz6vFdCYDU9l2wuX3hD67/7cFguc2nLqHRaWbkMPasaXkGi
 wSrKZsC7z+H5zy5EhwZlt7g9OTBvMZnx45QwsVLqnIIkPhbAY2hRq79N1PB6c1O6Li1e
 CT0VBkAuMLd5120t+BI1hprHVp+hDyWZlcttjz26t8Jyzvd9JBm2kWnMzzFgf1YDEOlU
 teTIJmhwBNMHaw0notURInAnHBQEiLo8I4r3WmOes36B5aFeB7KVnTGFvN8Gf9QBETbG
 hafJFYmjDH3QxJ8eW1DFYvaL0Y7rh3GGqdzm12wyrXwP8mJ6AomIJRNM84Z2u2g1rdNJ
 +HZQ==
X-Gm-Message-State: AOJu0YwBIMczcd7f3UiTyM0UB3IrGx/6SsrSE55l26B/a3yt2bg0lWrp
 vAnnAvpPmK42fsqAC6Nqr5NQjOwA2kHWHrXSPApcZqjd9GNp9NkBWuuoRPwAQy4y
X-Gm-Gg: ASbGncv7OxRiuCx6s6N9aDLWMDvyDVk19jO+C7a5ZkKS1fM+fU/sARuBUog8Jg1bcr0
 FkuS9XL3cTmJOl+QVer0n1V/mBkgo804fBRiYVexmQVBpa7rjV/62oZkc9kn6QaVLMfaJWEcNKz
 MXgDPYx97X1c4comhqkOLQ/EZWQu/+/+gbRR7YF5NnRPAxCHgqPN4AXWqlFAUo2YT1lN2EadJ9s
 3j46oeoWSbQVc/MEfDrCGzGNkDDkWC9XRUhKCnxg3Xm4Vey68lXO7Chn5U/5qjd+yJfj++zbOCq
 QnaHkQQJXaPHgq8XPueu8nfi4IVsBQAavhCiDG4aNSCXwLW83EPzrswDtEmlA+cy6PxV3I+LwrD
 /zugFGtjsTaYAdsTndZLLhuSoVwYBWTT47ez/FDz9bOJC6wohNalUMleulnEG3ApWqOQS6eGvb/
 Z/imsk+UxFsQArN4u1FC5HGibd2HeT1xemIIPtXZSQNMTX4KL/SWloBMOKSOw7rrBMTvGcnR69P
 4IZ9MU=
X-Google-Smtp-Source: AGHT+IH6NwbtkR9KVaWZMruOH8E87GbFPMByc6ZZlCT4WKF8R8KBz5UNoPmnk9epw2Cnyh1bEEgmwg==
X-Received: by 2002:a05:6402:5247:b0:63c:4d42:9928 with SMTP id
 4fb4d7f45d1cf-63c4d429ba7mr5372081a12.7.1760907811673; 
 Sun, 19 Oct 2025 14:03:31 -0700 (PDT)
Received: from archlinux (dynamic-002-245-026-170.2.245.pool.telefonica.de.
 [2.245.26.170]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c4945f003sm5107655a12.27.2025.10.19.14.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 14:03:30 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 Cameron Esfahani <dirty@apple.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 03/10] hw/rtc/mc146818rtc: Convert CMOS_DPRINTF() into
 trace events
Date: Sun, 19 Oct 2025 23:02:56 +0200
Message-ID: <20251019210303.104718-4-shentey@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251019210303.104718-1-shentey@gmail.com>
References: <20251019210303.104718-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/rtc/mc146818rtc.c | 14 +++-----------
 hw/rtc/trace-events  |  4 ++++
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index f9f5cf396f..61e9c0bf99 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -43,16 +43,10 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
+#include "trace.h"
 
-//#define DEBUG_CMOS
 //#define DEBUG_COALESCED
 
-#ifdef DEBUG_CMOS
-# define CMOS_DPRINTF(format, ...)      printf(format, ## __VA_ARGS__)
-#else
-# define CMOS_DPRINTF(format, ...)      do { } while (0)
-#endif
-
 #ifdef DEBUG_COALESCED
 # define DPRINTF_C(format, ...)      printf(format, ## __VA_ARGS__)
 #else
@@ -439,8 +433,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
     if ((addr & 1) == 0) {
         s->cmos_index = data & 0x7f;
     } else {
-        CMOS_DPRINTF("cmos: write index=0x%02x val=0x%02" PRIx64 "\n",
-                     s->cmos_index, data);
+        trace_mc146818_rtc_ioport_write(s->cmos_index, data);
         switch(s->cmos_index) {
         case RTC_SECONDS_ALARM:
         case RTC_MINUTES_ALARM:
@@ -726,8 +719,7 @@ static uint64_t cmos_ioport_read(void *opaque, hwaddr addr,
             ret = s->cmos_data[s->cmos_index];
             break;
         }
-        CMOS_DPRINTF("cmos: read index=0x%02x val=0x%02x\n",
-                     s->cmos_index, ret);
+        trace_mc146818_rtc_ioport_read(s->cmos_index, ret);
         return ret;
     }
 }
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index b9f2852d35..d2f36217cb 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -32,6 +32,10 @@ m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx6
 m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%04x value:0x%02x"
 m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x value:0x%02x"
 
+# mc146818rtc.c
+mc146818_rtc_ioport_read(uint8_t addr, uint8_t value) "[0x%02" PRIx8 "] -> 0x%02" PRIx8
+mc146818_rtc_ioport_write(uint8_t addr, uint8_t value) "[0x%02" PRIx8 "] <- 0x%02" PRIx8
+
 # goldfish_rtc.c
 goldfish_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 goldfish_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
-- 
2.51.1.dirty


