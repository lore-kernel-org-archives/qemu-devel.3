Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5252C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UJU-0000bw-00; Thu, 03 Apr 2025 19:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJR-0000bV-Vm
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UJM-0000PH-VO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:49:30 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso10991845e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724165; x=1744328965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dx4NIP+q6gK1PYGs8UG7pypdnmjUfZxa4IekdB6BGgc=;
 b=NF6zbHKDyPPBVCYsbfWUhZA7grba/DnEr0WsaLlg+zogqvweXJFNi9NyfCckEZs2UB
 0WMqolRXfPtdyWdTUGykbznBlJPTQrglmwDeCM9ydp7u0Pg9MAHW365iPEPS0R2SiJCn
 Ob3W4KkdcCK0E+c6ASGKyEL0ZXf21HPOr1GzStVt/anJntAJ1f+RaC9z3swcg7ZHlqp4
 /o6g6FtywvEivrQSpWbe4p/oOmg40HfmUdl3lr7esFxxrImYSnjthNjWiiKPux0Ni6Ck
 dtIWGuLPDLQ6s+3M/rhiknP1cDq6Ma3efEL3+wX+rgPVwscX99C4rrE6b610P27EzJWs
 x+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724165; x=1744328965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dx4NIP+q6gK1PYGs8UG7pypdnmjUfZxa4IekdB6BGgc=;
 b=UEv33pWFR+B3Fvt/oFP41tynEkKcFja/fL62A7PGudhlRpDyQ3aUHbL5wT8PTvx0vL
 YgOloPbT8ufpJla4UCIXL0+bSjJJe9M48x5R53EA+adoYzI0ik8o7D/IDP5wMN4VKw0s
 81WU7gYfreh++0ytpzUolbr1uTIn29h4xX3afIYnGUNW1+ochuNGoiljDqijRJfS3Nxb
 vtxf4lUjTT/p9X/alakf1GdmnLgK/ApzDYY868hOm7XU4d2RhWEaNvhQu6iVkY0n0Hvw
 rNGzJZ07JmHOg/FkG1XII0G6+K8LHBJj3Ufb3QDMMsAp7w8fbmX1B4igJYELIy0bb+F6
 U1og==
X-Gm-Message-State: AOJu0YwX9P6xLbanMWNTO2rW0sUo/FNLPzCfcNgWKMNldFGji4+ic1Ul
 rjuSHJ7crMyrFio+/aLtKc5aSQrg9f6YKvURsYht2mpukoAKt48AvBT2oUXtuKnm0KLjKM3dmaW
 K
X-Gm-Gg: ASbGnctJGTNVp12sTXOxP/yZrn8S/W5Im9PkFZ2otwnhi4wwjQ320Kj8Zyk8wa/wzzW
 B5LuVRdaE2jx3QYzQFdjnaw3sZOLPdnVDKWcGIEO7VJiggRafMpZK5eU3x2tN2uCJ3fg/fGXZET
 Av2dztWFFm7kpWra0Xto2PUgsnmS4UnIi4PUOGmXyYf/fAfbnBgTNWwEhoMLl3yLWegFyrg/ATS
 pZvi4jre4mdE+E+uUQKA5J7miEKZOGNb3atpaSlRYpJCnvr0IRKRfW/Tj4kpnO1b+74P0qDYLj6
 fApSC2qYScQOTKUWKSZn31pcD0sCnwnnMF91ymC2MVIjwcpBKOJP236Of7cDGydf7m6uT/5iygj
 mu/ZnrJN2dR1yXcMaJ6s=
X-Google-Smtp-Source: AGHT+IEDEkkt/TosMfwTARFIzEOm7d8erqQBc8FSCNXwXHdU0PFAxSnP4+0M4Bh9g9wY50uot8/UxA==
X-Received: by 2002:a05:600c:4503:b0:43c:f78d:82eb with SMTP id
 5b1f17b1804b1-43ecf8eb2bbmr7242435e9.15.1743724165091; 
 Thu, 03 Apr 2025 16:49:25 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a76cesm2969306f8f.37.2025.04.03.16.49.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:49:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 01/19] qemu: Introduce TargetInfo API in
 'target_info.h'
Date: Fri,  4 Apr 2025 01:48:56 +0200
Message-ID: <20250403234914.9154-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                     |  9 +++++++++
 include/exec/poison.h           |  1 +
 include/qemu/target_info-impl.h | 21 +++++++++++++++++++++
 include/qemu/target_info.h      | 18 ++++++++++++++++++
 target_info-stub.c              | 23 +++++++++++++++++++++++
 target_info.c                   | 16 ++++++++++++++++
 6 files changed, 88 insertions(+)
 create mode 100644 include/qemu/target_info-impl.h
 create mode 100644 include/qemu/target_info.h
 create mode 100644 target_info-stub.c
 create mode 100644 target_info.c

diff --git a/meson.build b/meson.build
index bcb9d39a387..de9c9dacd35 100644
--- a/meson.build
+++ b/meson.build
@@ -3262,6 +3262,9 @@ host_kconfig = \
 
 ignored = [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_ARCH' ]
 
+target_info = [
+]
+
 default_targets = 'CONFIG_DEFAULT_TARGETS' in config_host
 actual_target_dirs = []
 fdt_required = []
@@ -3368,6 +3371,9 @@ foreach target : target_dirs
       config_target_data.set(k, v)
     endif
   endforeach
+  if target not in target_info
+    config_target_data.set('TARGET_INFO_STUB_NEEDED', 1)
+  endif
   config_target_data.set('QEMU_ARCH',
                          'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
   config_target_h += {target: configure_file(output: target + '-config-target.h',
@@ -3807,6 +3813,9 @@ endif
 common_ss.add(pagevary)
 specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
+specific_ss.add(files('target_info-stub.c'))
+common_ss.add(files('target_info.c'))
+
 subdir('backends')
 subdir('disas')
 subdir('migration')
diff --git a/include/exec/poison.h b/include/exec/poison.h
index bc422719d80..00aedc41d82 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -38,6 +38,7 @@
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
 #pragma GCC poison TARGET_HAS_PRECISE_SMC
+#pragma GCC poison TARGET_INFO_STUB_NEEDED
 
 #pragma GCC poison TARGET_LONG_BITS
 #pragma GCC poison TARGET_FMT_lx
diff --git a/include/qemu/target_info-impl.h b/include/qemu/target_info-impl.h
new file mode 100644
index 00000000000..b340e192fce
--- /dev/null
+++ b/include/qemu/target_info-impl.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_IMPL_H
+#define QEMU_TARGET_INFO_IMPL_H
+
+#include "qemu/target_info.h"
+
+struct BinaryTargetInfo {
+
+    /* runtime equivalent of TARGET_INFO_STUB_NEEDED definition */
+    bool is_stub;
+
+};
+
+#endif
diff --git a/include/qemu/target_info.h b/include/qemu/target_info.h
new file mode 100644
index 00000000000..fab3f3153ea
--- /dev/null
+++ b/include/qemu/target_info.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef QEMU_TARGET_INFO_H
+#define QEMU_TARGET_INFO_H
+
+typedef struct BinaryTargetInfo BinaryTargetInfo;
+
+const BinaryTargetInfo *target_info(void);
+
+bool target_info_is_stub(void);
+
+#endif
diff --git a/target_info-stub.c b/target_info-stub.c
new file mode 100644
index 00000000000..d683a05977d
--- /dev/null
+++ b/target_info-stub.c
@@ -0,0 +1,23 @@
+/*
+ * QEMU target info stubs
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+
+#ifdef TARGET_INFO_STUB_NEEDED
+
+static const BinaryTargetInfo target_info_stub = {
+    .is_stub = true,
+};
+
+const BinaryTargetInfo *target_info(void)
+{
+    return &target_info_stub;
+}
+
+#endif /* TARGET_INFO_STUB_NEEDED */
diff --git a/target_info.c b/target_info.c
new file mode 100644
index 00000000000..cb17d29b86d
--- /dev/null
+++ b/target_info.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU legacy binary helpers
+ *
+ *  Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/target_info-impl.h"
+#include "qemu/target_info.h"
+
+bool target_info_is_stub(void)
+{
+    return target_info()->is_stub;
+}
-- 
2.47.1


