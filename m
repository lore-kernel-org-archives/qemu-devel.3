Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60D5E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 18:40:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWgMh-0007JC-3J; Sat, 11 Jan 2025 13:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMe-0007GW-VY; Sat, 11 Jan 2025 13:37:40 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tWgMd-0003xs-CM; Sat, 11 Jan 2025 13:37:40 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so4131132a12.2; 
 Sat, 11 Jan 2025 10:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736620656; x=1737225456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xvmtujobjZispI604dErPVBv97hCzWiTfq+q42+nT0=;
 b=dgngqmYcYtRgMM9REUGVUxRC6NY1mCs1Nn3fNEyM4PUz5YxLphS4HSpNfzxRzRbGV0
 Pof7G5ClzD/fgOHywQehXsm59xDuV+aGTYc74JLS/vrfa/h6b0+HNAqrk8BvhrfGsObb
 gjyhp95XmUvAG/C7gahfo0Db23teAaXjd+S0fY/ddGpxxLlp28HQ4ie7XBDKKrriqM15
 sxG1GVpjCg/J2vitOkXs2TyQ0yVOhrEBPaBfesSLqUp67lYTo6SIuRjR+ISeUTZ5lTZ1
 YTaGCzTYqsHN6pmQg4RePEx9gyBwLcjgh0wC8YEY6hyYr/3yF/mRk2ZaSltgYiemBjaX
 sRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736620656; x=1737225456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xvmtujobjZispI604dErPVBv97hCzWiTfq+q42+nT0=;
 b=td/gUojvgFoKwQoW/URj14lTNxsTHgN4KAIJSsDfDHkOfVSxg7B5DHI2mXAMfkHTAj
 U024oyK6BtFvaQjSqguWmKIBzs4r/HbxTe4L295h+LaGyYpA/WVW+gfTkfrTXUQYS7Ci
 8Xl3UTYtKRAEridDvyxqTM/1JylputMEjCwLKL74L41uz1xPAZjDFAGczEbr4SzXeLy9
 qncc1XHw9JBCM/TTldCxq5cL8fg5zU/MWni7PVv16d1NGtbNTrYikA4CiNu1M+G8AQhh
 RhhvpOprwZK8Jt/zgPCajrnatsl4IJNvA0O+m5LmrUYY2HSnFLZHUQhB+AiXEoBy27HP
 gXMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaQTZSPLc5/uIEyMWmeFYlPIdLw6gpL11ScadtFazWWihdLOn11g0sMrww9aFB2P0vOc/G/JOFz8QNXg==@nongnu.org,
 AJvYcCWNLQ6hAmIvwOQMiHx6xYuvuFcV113+TzL6eKsX/ohw7JWYmVmjehSPog1H9FoDNBCQHSJL2sG1ZQ==@nongnu.org
X-Gm-Message-State: AOJu0Yx7ZI4W9eCRcgJ4G9MEp66sR98zGZ6fE6rAY1sV4wfqPv+0GIWv
 F83ezgTO/mu2nuFhK2idIyXezoXHbgEQ99+xGdBeMx8/FXpDFHzMoOuyVw==
X-Gm-Gg: ASbGnctW8T1PB+UoJhHdXFIP70nnQLIx1OUoLvhkEeaeNgsphknlwZUVg/eVbtGsOv6
 LO5GrpFNaKSXh9XAfezW+OhTrOloIev1zlLKqkFu3esidSn9nXSEVczS5YIIxHfsiyxn3Gr0fdJ
 +PCL4fufeV9D2qdgSJcrKAk38wXNtF8GpbThOgwCRdo8oFm9a8PQ/MGyOsaSr6UYxe1Co424fRh
 xiAT+LvxCeS1aitoTpL9HrEj4dYqKQTnJbe+gB3MMOhqmTBxMNwBjLS3zSaXR1EQvtjOmzz9urY
 dO9xRqbWcHd1CYgDw7yYg0faONyyIsLdC5ztFoKodXw=
X-Google-Smtp-Source: AGHT+IHjV16YCML3Tl66MTXSDU83MiXb3upN6plnK4Syhc3FSmWYq28fciiOOTILjaie8mgTzuVLuw==
X-Received: by 2002:a05:6402:5109:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d972e7110amr32181787a12.32.1736620656035; 
 Sat, 11 Jan 2025 10:37:36 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-078-054-101-099.78.54.pool.telefonica.de. [78.54.101.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95af187sm299026666b.142.2025.01.11.10.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jan 2025 10:37:34 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 12/13] hw/misc/imx6_src: Convert DPRINTF() to trace events
Date: Sat, 11 Jan 2025 19:37:10 +0100
Message-ID: <20250111183711.2338-13-shentey@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250111183711.2338-1-shentey@gmail.com>
References: <20250111183711.2338-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/misc/imx6_src.c   | 23 +++++------------------
 hw/misc/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index dc6a2b92ba..06cc46292e 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -17,18 +17,7 @@
 #include "qemu/module.h"
 #include "target/arm/arm-powerctl.h"
 #include "hw/core/cpu.h"
-
-#ifndef DEBUG_IMX6_SRC
-#define DEBUG_IMX6_SRC 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX6_SRC) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX6_SRC, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx6_src_reg_name(uint32_t reg)
 {
@@ -87,7 +76,7 @@ static void imx6_src_reset(DeviceState *dev)
 {
     IMX6SRCState *s = IMX6_SRC(dev);
 
-    DPRINTF("\n");
+    trace_imx6_src_reset();
 
     memset(s->regs, 0, sizeof(s->regs));
 
@@ -111,7 +100,7 @@ static uint64_t imx6_src_read(void *opaque, hwaddr offset, unsigned size)
 
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx6_src_reg_name(index), value);
+    trace_imx6_src_read(imx6_src_reg_name(index), value);
 
     return value;
 }
@@ -134,8 +123,7 @@ static void imx6_clear_reset_bit(CPUState *cpu, run_on_cpu_data data)
     assert(bql_locked());
 
     s->regs[SRC_SCR] = deposit32(s->regs[SRC_SCR], ri->reset_bit, 1, 0);
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n",
-            imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
+    trace_imx6_clear_reset_bit(imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
 
     g_free(ri);
 }
@@ -173,8 +161,7 @@ static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
         return;
     }
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx6_src_reg_name(index),
-            (uint32_t)current_value);
+    trace_imx6_src_write(imx6_src_reg_name(index), value);
 
     change_mask = s->regs[index] ^ (uint32_t)current_value;
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0f5d2b5666..cf1abe6928 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -253,6 +253,12 @@ ccm_clock_freq(uint32_t clock, uint32_t freq) "(Clock = %d) = %d"
 ccm_read_reg(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
 ccm_write_reg(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 
+# imx6_src.c
+imx6_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx6_src_write(const char *reg_name, uint64_t value) "reg[%s] <= 0x%" PRIx64
+imx6_clear_reset_bit(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
+imx6_src_reset(void) ""
+
 # imx7_src.c
 imx7_src_read(const char *reg_name, uint32_t value) "reg[%s] => 0x%" PRIx32
 imx7_src_write(const char *reg_name, uint32_t value) "reg[%s] <= 0x%" PRIx32
-- 
2.48.0


