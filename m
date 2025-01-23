Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75316C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 23:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb6t6-0006yA-Cp; Thu, 23 Jan 2025 18:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6t3-0006rQ-Ho
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tb6t0-0004Gy-AK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 18:45:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f796586so16011755e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 15:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737675920; x=1738280720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLiVQy6/uYr9fS/vE5notUMei/mcFiOsSDRea34SIY0=;
 b=h6937nvEdYMeCIIS+GtLYVN4CwpFkVX0s57GdJkeLhjh6qm4EyFz3ODp0dXigT5pE+
 4ruophxsuGWTrolSobuDG+uQdjcQcUWFMTk8Ow1++nb/bAkLQwVvJPx/T85TmLswhoLd
 UzqRhZhOV+jQOKMk6C5a4VfsCOlH6bny9oW7DaBcadGneHg60FMSyjli7Z+n9DOiR5Cx
 goJpKtG6zv6gpd2AFGh02+Qgcl9cx3re08r+OuTRhijdQ86ipocS526+RScZmIBrwMye
 piSRPQGCRytBvPSK1H80S17NGwqn2mtzb+v9Sq0NPZAf6KoHpk435yCVqoNGi2gwYvDC
 +BeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737675920; x=1738280720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLiVQy6/uYr9fS/vE5notUMei/mcFiOsSDRea34SIY0=;
 b=VtQwZl8flg5t6RR+GYWBVj4WFH8fAO7F2mRmy/5rXF4ZZUmFyDY1MtcX6WkMkjciys
 hciwbUGlRYGfP4yPfZRkQ6pbJ5or89Y3oe5o8FabEwAd9/n8qP3IWDTVpeTuwhC/RV4A
 8WQT81dcIIQYf7lIdNRLohGsJk1/hnXswXDth3O+ENebJ9T+kRMJZeW52VgX41oO9qts
 k2h7Fc4asIfwQfQv+RTehpptmUWVhF1BqaO1/Bjn2oV9CRCH6//kzsjnvNRXOxWfZNj5
 BhycWaV4QijveQvzYqnpgeWWRofVWUD8xKd+NIsTpANPRADlDAyf4wMdO6U1tHx2+Hn2
 f65Q==
X-Gm-Message-State: AOJu0YwD4N1YopVn+mZ1w3W1AC2Xl6zWwgTVkzSOQkV9mV972eCsyl3w
 mDqUObYWQox/SM+UvUq4B2dhZQeK30+lTSyYJ3hbvY1f5eWLpl2moSXR9xbDusTed/C4xrIc2Sz
 WpE4=
X-Gm-Gg: ASbGnct8mNy3R8UqVqohvItEGJhWzFBEQ744ttX1Nd7E2fDp0bwCjj2a3nIlTMO3ky3
 Q960SZ0Ywc1gw1fQGCOVogEAnLoGlY1Gl8NV/mLMkliYKJ2SXpLidkVnSHwS9WO4xKRpO74tbx3
 Xjsw9yalaFInz7jerLQBcNO4nMG7z5XSEhgvVoU5hDjWpIj3zZjE2nUPbwQwqQAxImoHFoPaYL/
 jVYKkr7qNCkFP3mmbJNWdy7S6r7h45BUvfDefGqgLnigLhMMzB6h7f6N57SvTmti/RwI/jcKvRC
 wV7lMtz3nTdEeXHcDaRTJn2KHqoRv2vtGbkdBRhHKPi1eWowVLzFXdw=
X-Google-Smtp-Source: AGHT+IHCUhXEKn4F81kx6ZpXqs9faqGpJN5W9Mj/EUJJpXYvZE3+gYqYLTjnf0hJ5kDL6XLUxlFm9g==
X-Received: by 2002:a05:600c:1913:b0:434:f4fa:83c4 with SMTP id
 5b1f17b1804b1-43891453fa7mr280858325e9.29.1737675919693; 
 Thu, 23 Jan 2025 15:45:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd54c0f7sm6499935e9.28.2025.01.23.15.45.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Jan 2025 15:45:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 11/20] accel: Rename 'hw/core/accel-cpu.h' ->
 'accel/accel-cpu-target.h'
Date: Fri, 24 Jan 2025 00:44:05 +0100
Message-ID: <20250123234415.59850-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123234415.59850-1-philmd@linaro.org>
References: <20250123234415.59850-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

AccelCPUClass is for accelerator to initialize target specific
features of a vCPU. Not really related to hardware emulation,
rename "hw/core/accel-cpu.h" as "accel/accel-cpu-target.h"
(using the explicit -target suffix).

More importantly, target specific header often access the
target specific definitions which are in each target/FOO/cpu.h
header, usually included generically as "cpu.h" relative to
target/FOO/. However, there is already a "cpu.h" in hw/core/
which takes precedence. This change allows "accel-cpu-target.h"
to include a target "cpu.h".

Mechanical change doing:

 $  git mv include/hw/core/accel-cpu.h \
           include/accel/accel-cpu-target.h
 $  sed -i -e 's,hw/core/accel-cpu.h,accel/accel-cpu-target.h,' \
   $(git grep -l hw/core/accel-cpu.h)

and renaming header guard 'ACCEL_CPU_TARGET_H'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                               | 2 +-
 include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} | 4 ++--
 accel/accel-target.c                                      | 2 +-
 cpu-target.c                                              | 2 +-
 target/i386/hvf/hvf-cpu.c                                 | 2 +-
 target/i386/kvm/kvm-cpu.c                                 | 2 +-
 target/i386/tcg/tcg-cpu.c                                 | 2 +-
 target/ppc/kvm.c                                          | 2 +-
 target/riscv/kvm/kvm-cpu.c                                | 2 +-
 target/riscv/tcg/tcg-cpu.c                                | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)
 rename include/{hw/core/accel-cpu.h => accel/accel-cpu-target.h} (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa46d077d30..e4521852519 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -499,7 +499,7 @@ R: Paolo Bonzini <pbonzini@redhat.com>
 S: Maintained
 F: include/qemu/accel.h
 F: include/system/accel-*.h
-F: include/hw/core/accel-cpu.h
+F: include/accel/accel-cpu-target.h
 F: accel/accel-*.c
 F: accel/Makefile.objs
 F: accel/stubs/Makefile.objs
diff --git a/include/hw/core/accel-cpu.h b/include/accel/accel-cpu-target.h
similarity index 95%
rename from include/hw/core/accel-cpu.h
rename to include/accel/accel-cpu-target.h
index 24dad45ab9e..0a8e518600d 100644
--- a/include/hw/core/accel-cpu.h
+++ b/include/accel/accel-cpu-target.h
@@ -8,8 +8,8 @@
  * See the COPYING file in the top-level directory.
  */
 
-#ifndef ACCEL_CPU_H
-#define ACCEL_CPU_H
+#ifndef ACCEL_CPU_TARGET_H
+#define ACCEL_CPU_TARGET_H
 
 /*
  * This header is used to define new accelerator-specific target-specific
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 08626c00c2d..09c1e1053e0 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -27,7 +27,7 @@
 #include "qemu/accel.h"
 
 #include "cpu.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 
 #ifndef CONFIG_USER_ONLY
 #include "accel-system.h"
diff --git a/cpu-target.c b/cpu-target.c
index 75501a909df..f97f3a14751 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -44,7 +44,7 @@
 #include "exec/tb-flush.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 #include "qemu/accel.h"
 
diff --git a/target/i386/hvf/hvf-cpu.c b/target/i386/hvf/hvf-cpu.c
index 560b5a05940..b5f4c80028f 100644
--- a/target/i386/hvf/hvf-cpu.c
+++ b/target/i386/hvf/hvf-cpu.c
@@ -14,7 +14,7 @@
 #include "system/system.h"
 #include "hw/boards.h"
 #include "system/hvf.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "hvf-i386.h"
 
 static void hvf_cpu_max_instance_init(X86CPU *cpu)
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 1bda403f88b..6269fa80452 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -15,7 +15,7 @@
 #include "hw/boards.h"
 
 #include "kvm_i386.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 
 static void kvm_set_guest_phys_bits(CPUState *cs)
 {
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index f09ee813ac9..b8aff825eec 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "helper-tcg.h"
 #include "qemu/accel.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "exec/translation-block.h"
 
 #include "tcg-cpu.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 966c2c65723..216638dee40 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -49,7 +49,7 @@
 #include "elf.h"
 #include "system/kvm_int.h"
 #include "system/kvm.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 
 #include CONFIG_DEVICES
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce7793594..7e4443c5bda 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -32,7 +32,7 @@
 #include "system/kvm_int.h"
 #include "cpu.h"
 #include "trace.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "hw/pci/pci.h"
 #include "exec/memattrs.h"
 #include "exec/address-spaces.h"
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e40c8e85b26..79345e4b89d 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -30,7 +30,7 @@
 #include "qemu/accel.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
-#include "hw/core/accel-cpu.h"
+#include "accel/accel-cpu-target.h"
 #include "accel/tcg/cpu-ops.h"
 #include "tcg/tcg.h"
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


