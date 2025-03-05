Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D5EC28B21
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUO-00025k-FY; Tue, 04 Mar 2025 20:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTg-0000MS-TV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:18 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTe-00073A-G1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:16 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f406e9f80so4730969f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137792; x=1741742592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2IHjjPDhAlThC5AYDDLcqpca6XJWi3ImZ01k6AVQ1k=;
 b=h727yHxxlFu8IHv/fSPHUjGxf7eBGh8Gghj+BPPI/vJVqyuVizsyrbIdrEqf8oiSfI
 z8JzyUyl/FDcGrOMGfrW6FWo4xvgeDVt2qZEbZE4kNnrsSWDUKhKwC5fWPZV9u8zoPuO
 R2dgEu7MxatphqIcqMssuSjhPy58hTiFX8LqKeVdwuVXEJWyUZb4c2MRmbYdL97by2xl
 /lvJ2z6yh3tbVZwSjOeTE8A1mFyilVNs23rV6xGf9ziTjsLZ9EUWSNApa/HyTAjBIZ7f
 WBhVLzlFT9T05/trv3I4fuGvs3HS2SEbvWEqp1k+IG8PrrawxN3Mia6vA0dZpMda8hcj
 5fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137792; x=1741742592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q2IHjjPDhAlThC5AYDDLcqpca6XJWi3ImZ01k6AVQ1k=;
 b=N1TIpaVOoExgCTrdiV7lO2iksjUhQptSN+PJih02DY1XC2gC48/An8ShA3RcKR2Ygy
 MqzPwsMWm1THHazuvIkMx80x7x6MiTzlrGWIpD0KdzNq1R/TP0fv8ZrZjhCEoMJDroAe
 vC4E/v3FiviJ0/9O2hiW30WkDnUHdkN4UOJdAz5BFD8tz/aJ1M6Exe8mNX6zgGnh1ukO
 eNE89/w3QVC2ggHhf8n2tHjEZyt9MfRx8KjcYcnh2g84Eu/lVfwUJU0D+9ectlp3nfIw
 9HstJlnY24ipf0HB7gyakFNSQXO5/UY0MOXEtISQwXw5WgB8+KK0gJW/V5whncsjbjQm
 xBDQ==
X-Gm-Message-State: AOJu0Yzg99y6U2+EAxQ60lX7NciR/aoBLEY2p7MOgE+if85k3ts/qh7f
 cpHXapJ3WR76nhxcyW5CtvylLoiwPTAB11AiTuN+NT9K7SX1GX4UK/3LOkiW1y3v4gTljbXA7kS
 ofNY=
X-Gm-Gg: ASbGncsqDRsEllb9D37HeaF0wbEH2WWWZGZz0dHHw73GJibYpdObmm5lGwwVT0V0YpX
 DYuawkYeLT6J60CauSAGCJ5gteA1NRLwh1hV40jWvPyBHZpdJCHO0DRLUZSS8nGdRaXcDmgKUc5
 4GmMXY8DRIKn+W0qi3iuUSHhQIGAbI9BBOMoKd2817ROqyr2liZuMtEp/++q4FdgaJe84ZwaG0k
 WiCsccSVWWHcC7qKvzsWCyzXVSl94x5nhDUPUYbY5rDwLRbTn/Sy886/3ez0u1EpNfzFCZGyGOV
 9mlaIBKqYUBYuL/lz2dy1fwrylX2wiDA0p3ZH9HU2KfowywiR2MXGhq87xO4d0cTXyDGQTIiE9q
 SxndNqngSBSpHCVCtNy8=
X-Google-Smtp-Source: AGHT+IGmPJqNugJgMNTXD3BqXBJSRvxwid1ZabjiCa/EK9RyDTVAmdrleDK1M9LFNLm9SMi2A4P+uw==
X-Received: by 2002:a05:6000:4007:b0:38d:e584:81ea with SMTP id
 ffacd0b85a97d-3911f7c8308mr650163f8f.45.1741137792366; 
 Tue, 04 Mar 2025 17:23:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485d6cdsm19218804f8f.84.2025.03.04.17.23.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PULL 15/41] hw/xen/xen-hvm: Reduce included headers
Date: Wed,  5 Mar 2025 02:21:30 +0100
Message-ID: <20250305012157.96463-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Have "hw/xen/xen-hvm-common.h" include the bare minimal set
of headers. Adapt sources to avoid errors when refactoring
unrelated headers such:

  include/hw/xen/xen-hvm-common.h:71:5: error: unknown type name ‘xenevtchn_handle’
     71 |     xenevtchn_handle *xce_handle;
        |     ^~~~~~~~~~~~~~~~
  hw/xen/xen-hvm-common.c: In function ‘cpu_get_ioreq’:
  hw/xen/xen-hvm-common.c:227:13: error: implicit declaration of function ‘hw_error’
    227 |             hw_error("Fatal error while trying to get io event!\n");
        |             ^~~~~~~~
        |             herror
  hw/xen/xen-hvm-common.c: In function ‘handle_ioreq’:
  hw/xen/xen-hvm-common.c:446:34: error: ‘target_ulong’ undeclared (first use in this function)
    446 |             (req->size < sizeof (target_ulong))) {
        |                                  ^~~~~~~~~~~~
  hw/i386/xen/xen-hvm.c: In function ‘xen_add_to_physmap’:
  hw/i386/xen/xen-hvm.c:298:22: error: implicit declaration of function ‘xen_replace_cache_entry’
    298 |         uint8_t *p = xen_replace_cache_entry(phys_offset, start_addr, size);
        |                      ^~~~~~~~~~~~~~~~~~~~~~~
  hw/i386/xen/xen-hvm.c:314:9: error: implicit declaration of function 'error_report' is invalid in C99
    314 |    error_report("relocate_memory %lu pages from GFN %"HWADDR_PRIx
             ^~~~~~~~~~~~
  hw/i386/xen/xen-hvm.c: In function ‘xen_log_global_start’:
  hw/i386/xen/xen-hvm.c:465:9: error: implicit declaration of function ‘xen_enabled’
    465 |     if (xen_enabled()) {
        |         ^~~~~~~~~~~
  hw/i386/xen/xen-hvm.c: In function ‘regs_to_cpu’:
  hw/i386/xen/xen-hvm.c:487:5: error: unknown type name ‘X86CPU’
    487 |     X86CPU *cpu;
        |     ^~~~~~
  hw/i386/xen/xen-hvm.c:492:15: error: ‘R_EAX’ undeclared (first use in this function)
    492 |     env->regs[R_EAX] = req->data;
        |               ^~~~~
        |               REG_RAX

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Message-Id: <20250218162618.46167-6-philmd@linaro.org>
---
 include/hw/xen/xen-hvm-common.h | 14 +++-----------
 hw/arm/xen-stubs.c              |  5 ++---
 hw/i386/xen/xen-hvm.c           |  6 ++++++
 hw/xen/xen-hvm-common.c         |  7 +++++++
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index c1ea2c0d787..19df5600a39 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -1,18 +1,10 @@
 #ifndef HW_XEN_HVM_COMMON_H
 #define HW_XEN_HVM_COMMON_H
 
-#include "qemu/units.h"
-
-#include "cpu.h"
-#include "hw/pci/pci.h"
-#include "hw/hw.h"
+#include "qemu/queue.h"
+#include "exec/hwaddr.h"
 #include "hw/xen/xen_native.h"
-#include "hw/xen/xen-legacy-backend.h"
-#include "system/runstate.h"
-#include "system/system.h"
-#include "system/xen.h"
-#include "system/xen-mapcache.h"
-#include "qemu/error-report.h"
+#include "hw/xen/xen_backend_ops.h"
 #include <xen/hvm/ioreq.h>
 
 extern MemoryRegion xen_memory;
diff --git a/hw/arm/xen-stubs.c b/hw/arm/xen-stubs.c
index 34beb8b08cb..5551584dc20 100644
--- a/hw/arm/xen-stubs.c
+++ b/hw/arm/xen-stubs.c
@@ -5,10 +5,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/error-report.h"
 #include "qapi/qapi-commands-migration.h"
-#include "hw/boards.h"
-#include "system/system.h"
+#include "system/xen.h"
+#include "hw/hw.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/arch_hvm.h"
 
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d3df488c483..d4516acec69 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -10,10 +10,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "trace.h"
 
+#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/i386/apic-msidef.h"
@@ -24,6 +26,10 @@
 #include "hw/xen/arch_hvm.h"
 #include <xen/hvm/e820.h>
 #include "exec/target_page.h"
+#include "target/i386/cpu.h"
+#include "system/runstate.h"
+#include "system/xen-mapcache.h"
+#include "system/xen.h"
 
 static MemoryRegion ram_640k, ram_lo, ram_hi;
 static MemoryRegion *framebuffer;
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 7ffbbfea23b..9a677e8ed74 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,14 +1,21 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "exec/target_long.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
+#include "hw/hw.h"
 #include "hw/pci/pci_host.h"
 #include "hw/xen/xen-hvm-common.h"
 #include "hw/xen/xen-bus.h"
 #include "hw/boards.h"
 #include "hw/xen/arch_hvm.h"
+#include "system/runstate.h"
+#include "system/system.h"
+#include "system/xen.h"
+#include "system/xen-mapcache.h"
 
 MemoryRegion xen_memory, xen_grants;
 
-- 
2.47.1


