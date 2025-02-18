Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E46C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQu-0004xT-1m; Tue, 18 Feb 2025 11:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQs-0004vX-ID
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQQq-0000l4-Rz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso35566825e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739896007; x=1740500807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEWDgBTGZHQh8hQjrfZA2thbBnd3w2okAGpaFOGJy1M=;
 b=rCvvQdLV3S030l6Z1oSsog4abNdjiFuANzCIySt0DHb909m6qcgdUGAEtjnwsy4RBL
 eWCpL9mVM3mzP7MGzCV/YT4z2i4P/gvBEatD4vjUOKCS98PoWFZSml0qTBodmd358C25
 /UN6vIV3Q1z3ew7E27Qta18rJNlQv/FIR12uXWtDkqDmMxcwNLSMtRAYZvVI+sKCslXo
 T8ANcAOUKpM6j3bTQQBq0R5+LWjLJCatd7H85kS0j+t9ERskvK63A+I68zxBrO5NLWCi
 VHfkMi5UCzKveZKnpmi+LrzWDBKdSQ1In+ohRn8gwvvnUhJr4OMfn7gfidaTvfpOAZGY
 U/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896007; x=1740500807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZEWDgBTGZHQh8hQjrfZA2thbBnd3w2okAGpaFOGJy1M=;
 b=cOyEf/DIlYWL04R9TKpl5ZGgoS4fH2nI18Sa/4IbDhsyRIkZsweVCEr+kEuxMPWdqE
 5PHG/xeRkf8i3/IfjHSzo9t04/8yFj+PI0wgGlqrqe0w1VYiVLHJkplOvxoniR03IT60
 VCvglAsioA+TfSYKAJofrVIPSnglPYYSgueXWdX48hsFGnFdJ/LiCgS0V2uZ2S3ogLbt
 Ax02S4daG6jKoSNU5Qwivj45zkT8hWk34qIRbqwHNXwnyQ2YvhDJzkeufcfIlZ+ec5Sw
 NXLuVrETwvLHgM/steBjvQL3lIvK8BB3i45BT0yQ7IWPj78eRIoyt5lf7tZ4KQZy5v21
 aiCg==
X-Gm-Message-State: AOJu0Yyyqm74eARZWiHn45sN7tcU6dl/6kccUw+ycpQZlSfqM6GJowvb
 KGjL3ju0uyksuqQXJ1FY8QxpPs4IpgHTSP9vjX9MEsP5lqss6glrQN9mph3fnEjQBqTQN6jXNkv
 GwHg=
X-Gm-Gg: ASbGncuwXBnNGFxBWAWFsJLHtn0eSAnBSTlZVL2PUkEEPmNjcLTRy26VtTpu6mypTdW
 dSjd5s5MVQMlViWhhAtdff9WHVpPsNvas+pQKxCF4eZcoyKgeDC1zWfLgThT8ydPlxJHn2WD0VN
 xoMZ9IIXh5CCwN+An3DMLrBPDFXGTHFtU/Y5gFv/l+5OcYrrGQlhydnxWLz5hXjkvtfqke02NYl
 VxvoiMYZNKlK69oXizPWE8pLXKgocpXOFcFf5pwWpQcsBmegGmGtODq0HIL80K6DQgGfJk3jsuz
 X42e6jeH12l5QxlRvS+o4NUMZRfHTxw35YYbA/4tWojGbWTNoxootPETTeP1dGSdFA==
X-Google-Smtp-Source: AGHT+IHww/aPDqevZulOoXCapDkghHuR45jCHHx4aaEIx+GvA7aWlGWPRHehkaEbIQa+py8L6fjQlQ==
X-Received: by 2002:a05:600c:4e8c:b0:439:9274:81db with SMTP id
 5b1f17b1804b1-43999d76ddcmr3474325e9.5.1739896006891; 
 Tue, 18 Feb 2025 08:26:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f25a0fa2dsm15228567f8f.101.2025.02.18.08.26.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Feb 2025 08:26:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Thomas Huth <thuth@redhat.com>, Jan Beulich <jbeulich@suse.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 5/8] hw/xen/xen-hvm: Reduce included headers
Date: Tue, 18 Feb 2025 17:26:15 +0100
Message-ID: <20250218162618.46167-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250218162618.46167-1-philmd@linaro.org>
References: <20250218162618.46167-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 include/hw/xen/xen-hvm-common.h | 14 +++-----------
 hw/arm/xen-stubs.c              |  5 ++---
 hw/i386/xen/xen-hvm.c           |  5 +++++
 hw/xen/xen-hvm-common.c         |  6 ++++++
 4 files changed, 16 insertions(+), 14 deletions(-)

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
index d3df488c483..67b7c223aee 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -14,6 +14,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "trace.h"
 
+#include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/i386/apic-msidef.h"
@@ -24,6 +25,10 @@
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
index 7ffbbfea23b..3828105c95e 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,14 +1,20 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
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


