Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E0EC54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7L9-0000ko-JW; Fri, 15 Mar 2024 09:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Kq-0007pM-4r
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:56 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rl7Kh-0008OW-N5
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:10:51 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d2505352e6so23328061fa.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710508242; x=1711113042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J25HPqsyrmOQ1iioSn9g7nmBc+Xq8CsuJB3WGvQV87Y=;
 b=Vi27EO75DlJiqo/Ja2Yu1gvvOfJoqPZMmfBJWXQZ3xQJKEN6K9Z5xtpRzuOOApi9h+
 CQJkzAFktpzv/Fl9+xFPFNLFbdnZn9FLP95wbAXYGylB9/NMv+6c4tkbW0DgYPFr4Z4R
 2Jql/IoxdTqS9Wu/VRFxLwFBUKVdt3mTzQCQ8dMl88PBUm5XlaTy2NnwwmJ9BZF2QDT6
 WvBI4wJiwxcXMvcenhJChApo1Hsy403pKwo06V2fnRnEaMG4jXi/bCFredKo+aqrh5pd
 rGgITL0wuytDWPo04vs7YUdH7+t77tTkKnbaj6Z3KaADvwE+kWCeB3ACpq0PyT33VEM+
 jCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508242; x=1711113042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J25HPqsyrmOQ1iioSn9g7nmBc+Xq8CsuJB3WGvQV87Y=;
 b=hl/8wJX9axlKx3V/lWGGLIgcXUS59Zg39Zkv7XfW8Y8fW6azhdVZZ1yunWBSvQoa9k
 27Zhw3GOk8tP9qeK0zQdoVP2SBtZUqhz7r4aYDIGosrrPB4WI7BFqxTIuILSJNFOIHIw
 dAOoO1+/PgSvksaWfzIh+GRC62bHkZTbv53JnFjmthQKgL3K1UjClKzvf3BrGSUV8YmN
 qUwT/8Kkn3nZbKRKcDD60+IR5hFL5lmiJdbRNzMxfpKl1h1kt8OD/nBsja5cNgGVnvPZ
 V3kvUCPoXs0wWJ+thaJFtbZ9boga6G3sG8L0kJxwWasuVA3Trb0h3iTPFTND7ZvNBUoV
 sbVg==
X-Gm-Message-State: AOJu0YwAYoi6MYLeY97i1kh8wKVQKba8P7RpBnURRV7M0vSwWx0/FXpU
 Q49nZcoVn/RuGa0KByFIpeSAqHotv6Fpf3hmnaOgMknWlAaEYwiDFwX9yfq9t/1oMVL73eQnbhi
 Y
X-Google-Smtp-Source: AGHT+IEv3LwWoidfawbI4h9yAjYbFyjy4RfVu/IFC9ezcLGHzfJWoWogtJbH4nZ9k43Uxgvez5OUAA==
X-Received: by 2002:a05:651c:23a:b0:2d3:3b37:db78 with SMTP id
 z26-20020a05651c023a00b002d33b37db78mr2967826ljn.16.1710508241796; 
 Fri, 15 Mar 2024 06:10:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.145.26])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a1709065a9700b00a460040a102sm1670235ejq.124.2024.03.15.06.10.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Mar 2024 06:10:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 13/21] system: Introduce cpu_typename_by_arch_bit()
Date: Fri, 15 Mar 2024 14:09:01 +0100
Message-ID: <20240315130910.15750-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
References: <20240315130910.15750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Introduce a helper to return the CPU type name given a QemuArchBit.

The TYPE_PPC_CPU target have different 32/64-bit definitions
so we can not include it yet.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
---
 MAINTAINERS                |  1 +
 include/sysemu/arch_init.h |  2 ++
 system/cpu-qom-helpers.c   | 58 ++++++++++++++++++++++++++++++++++++++
 system/meson.build         |  1 +
 4 files changed, 62 insertions(+)
 create mode 100644 system/cpu-qom-helpers.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ed98814398..af27490243 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -148,6 +148,7 @@ M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: system/cpus.c
+F: system/cpu-qom-helpers.c
 F: system/watchpoint.c
 F: cpu-common.c
 F: cpu-target.c
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index cf597c40a3..1874f18e67 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -27,6 +27,8 @@ typedef enum QemuArchBit {
     QEMU_ARCH_BIT_LAST          = QEMU_ARCH_BIT_LOONGARCH
 } QemuArchBit;
 
+const char *cpu_typename_by_arch_bit(QemuArchBit arch_bit);
+
 enum QemuArchMask {
     QEMU_ARCH_ALL = -1,
     QEMU_ARCH_ALPHA             = (1 << QEMU_ARCH_BIT_ALPHA),
diff --git a/system/cpu-qom-helpers.c b/system/cpu-qom-helpers.c
new file mode 100644
index 0000000000..0d402ee3a0
--- /dev/null
+++ b/system/cpu-qom-helpers.c
@@ -0,0 +1,58 @@
+/*
+ * Helpers for CPU QOM types
+ *
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/arch_init.h"
+
+#include "target/alpha/cpu-qom.h"
+#include "target/arm/cpu-qom.h"
+#include "target/avr/cpu-qom.h"
+#include "target/cris/cpu-qom.h"
+#include "target/hexagon/cpu-qom.h"
+#include "target/hppa/cpu-qom.h"
+#include "target/i386/cpu-qom.h"
+#include "target/loongarch/cpu-qom.h"
+#include "target/m68k/cpu-qom.h"
+#include "target/microblaze/cpu-qom.h"
+#include "target/mips/cpu-qom.h"
+#include "target/nios2/cpu-qom.h"
+#include "target/openrisc/cpu-qom.h"
+#include "target/riscv/cpu-qom.h"
+#include "target/rx/cpu-qom.h"
+#include "target/s390x/cpu-qom.h"
+#include "target/sparc/cpu-qom.h"
+#include "target/sh4/cpu-qom.h"
+#include "target/tricore/cpu-qom.h"
+#include "target/xtensa/cpu-qom.h"
+
+const char *cpu_typename_by_arch_bit(QemuArchBit arch_bit)
+{
+    static const char *cpu_bit_to_typename[QEMU_ARCH_BIT_LAST + 1] = {
+        [QEMU_ARCH_BIT_ALPHA]       = TYPE_ALPHA_CPU,
+        [QEMU_ARCH_BIT_ARM]         = TYPE_ARM_CPU,
+        [QEMU_ARCH_BIT_CRIS]        = TYPE_CRIS_CPU,
+        [QEMU_ARCH_BIT_I386]        = TYPE_I386_CPU,
+        [QEMU_ARCH_BIT_M68K]        = TYPE_M68K_CPU,
+        [QEMU_ARCH_BIT_MICROBLAZE]  = TYPE_MICROBLAZE_CPU,
+        [QEMU_ARCH_BIT_MIPS]        = TYPE_MIPS_CPU,
+        /* TODO:                      TYPE_PPC_CPU */
+        [QEMU_ARCH_BIT_S390X]       = TYPE_S390_CPU,
+        [QEMU_ARCH_BIT_SH4]         = TYPE_SUPERH_CPU,
+        [QEMU_ARCH_BIT_SPARC]       = TYPE_SPARC_CPU,
+        [QEMU_ARCH_BIT_XTENSA]      = TYPE_XTENSA_CPU,
+        [QEMU_ARCH_BIT_OPENRISC]    = TYPE_OPENRISC_CPU,
+        [QEMU_ARCH_BIT_TRICORE]     = TYPE_TRICORE_CPU,
+        [QEMU_ARCH_BIT_NIOS2]       = TYPE_NIOS2_CPU,
+        [QEMU_ARCH_BIT_HPPA]        = TYPE_HPPA_CPU,
+        [QEMU_ARCH_BIT_RISCV]       = TYPE_RISCV_CPU,
+        [QEMU_ARCH_BIT_RX]          = TYPE_RX_CPU,
+        [QEMU_ARCH_BIT_AVR]         = TYPE_AVR_CPU,
+        [QEMU_ARCH_BIT_HEXAGON]     = TYPE_HEXAGON_CPU,
+        [QEMU_ARCH_BIT_LOONGARCH]   = TYPE_LOONGARCH_CPU,
+    };
+    return cpu_bit_to_typename[arch_bit];
+}
diff --git a/system/meson.build b/system/meson.build
index 25e2117250..c6ee97e3b2 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -10,6 +10,7 @@ system_ss.add(files(
   'balloon.c',
   'bootdevice.c',
   'cpus.c',
+  'cpu-qom-helpers.c',
   'cpu-throttle.c',
   'cpu-timers.c',
   'datadir.c',
-- 
2.41.0


