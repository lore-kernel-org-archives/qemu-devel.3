Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E22F531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRh1-0003td-8l; Mon, 13 Apr 2026 20:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgz-0003hX-H2
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:49 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRgx-0003HY-LV
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:31:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso52948945e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126706; x=1776731506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hdZYTb6QkoSaXIdFzLZ7MdrxJm++U0xBy0kLQ4+r/XE=;
 b=pk+WWLtsqk+ae+kSKDZ5KBhVoMx0Sqz9LsPPpAU67bFocm0108pb8hbwc5RXo4/xTa
 h7abJOxxH9lHRXsqxYfSvpdCup9Dqv867vH8QTJzXNP6QChJGiPisjTuBHKZ/NjIdvJ6
 BmB1MOAIr4nMdp9qbWBCxjcEjCvb2/PcvM3cAmz5HO+j+rInIUoXPKbk4VhAHisE2klK
 8+gREQlFR7lNCeVzCwNjS86NTGJUzL2UzVZmn05TEpbfEoWJsayApKYEmSIcKPDD4U2P
 MdzCHC+mefnJpa1xphnfbVosEemnKX5kVCvcopBsAXC9/Zxz1zWDkhp3NfD1zAg4PiT8
 seHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126706; x=1776731506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hdZYTb6QkoSaXIdFzLZ7MdrxJm++U0xBy0kLQ4+r/XE=;
 b=MidLA7p1JXySPWEetcqaE5/Icp1cGTljP4hZ5OfvlAXGfU8nbph4E+w+1iXVVAkp1z
 c+OHsaBjXEdaK2+NKkMrWa9TyOcWfK82wgpHHYjqH/sdrkOb4fmeUtvnkF6XQpWzZhSS
 uTy6FGGf35T91FOR8ed4bJac6n6Twe05R0F62+rmZIIVWophf/mRlL/HG9yr8/vJ54Wp
 Yd73nBE122WKO3Ng2wCYTIrEZMTEtT2fwSFuJENzrEOOmf/NRUbWVwDHHA/7Dl5mTX9Z
 +VUGjeNnaZEIJmNOOcQThRVVKpfMqCEIS+WUMwg4sq2f+DZtBcxE7kfutEj/v+FiO0+H
 e9Tw==
X-Gm-Message-State: AOJu0YxPSnlMDOIQ9i4dmnL51SnFvyEzuaxbGpeyqdXI+JxiRBAoxV6J
 0wtO1qj9qw+SYx73UrOZmDAi18aCkz/uN2kV7DWPNEjSmMMMRx/nj9SzElGT/NuandUgm6Gk0Xg
 9f34bSE0=
X-Gm-Gg: AeBDievVeKH5VKOhQQS+r8yl+9Z+kW7kCO/5a5W34F1U5S/mTUDFQ4y1wy9jcL90P7d
 HcaGLeulnJNo96CGzpwOU6GqAvXpeq0MRK5zMqnZgKz5La+h2Y4PxgLilU3zFekxOc/8Mk3c+rn
 nGaDhPRBIj9ssjCINAQ+LwDCrtoSdXxCbdg/PNx0JfxwK6COQB+b+JDZ7unXYQs446ETR72lIOK
 QRiQzCwLvMT+6iEvM8Zp+0yfMWrvNAx9PvOXMtBsuQR3hVBW9HKlxJ3usV+bhkVTwo/uaV9sM0S
 G06XKljFY44a6RxtHySE/lyjxF3VZptqerC0PaME/WvS3unalbJWc6pfxYP3w3vgFF/Hg0SVjvA
 aCCyK1ei1i5u9CAiX5+NfccFG+pLqcFTgmnVndZ/PS/MBCvpshKKUzrtL02QXU+H4tMvM62kMvx
 9z4WKzUUwrrQJYAERHPjSPSSXzuSjnQ9iFOJe+oidDTMn049GIAVEMJOeADkygHk0P3jIx/HKj
X-Received: by 2002:a05:600c:3ba4:b0:488:c6e9:1e0c with SMTP id
 5b1f17b1804b1-488d6847de9mr199741155e9.5.1776126705962; 
 Mon, 13 Apr 2026 17:31:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d703c1sm108817045e9.3.2026.04.13.17.31.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:31:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 14/27] monitor: Do not check multiple TARGET_* to build
 'info tlb' command
Date: Tue, 14 Apr 2026 02:29:46 +0200
Message-ID: <20260414003001.97571-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This command is filtered at build-time for a selection of binaries.
By using the recently introduced HMPCommand::arch_bitmask flag we
can filter them at runtime, making it possible to compile
hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 stubs/hmp-cmd-info_tlb.c | 12 ++++++++++++
 hmp-commands-info.hx     |  5 ++---
 stubs/meson.build        |  1 +
 3 files changed, 15 insertions(+), 3 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_tlb.c

diff --git a/stubs/hmp-cmd-info_tlb.c b/stubs/hmp-cmd-info_tlb.c
new file mode 100644
index 00000000000..a144e68c1c7
--- /dev/null
+++ b/stubs/hmp-cmd-info_tlb.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info tlb' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_tlb)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 2d0a8f7d48f..0898221a486 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -193,16 +193,15 @@ SRST
     Show PCI information.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_SH4) || defined(TARGET_SPARC) || \
-    defined(TARGET_PPC) || defined(TARGET_XTENSA) || defined(TARGET_M68K)
     {
         .name       = "tlb",
         .args_type  = "",
         .params     = "",
         .help       = "show virtual to physical memory mappings",
         .cmd        = hmp_info_tlb,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_SH4 | QEMU_ARCH_SPARC \
+                        | QEMU_ARCH_PPC | QEMU_ARCH_XTENSA | QEMU_ARCH_M68K,
     },
-#endif
 
 SRST
   ``info tlb``
diff --git a/stubs/meson.build b/stubs/meson.build
index 9aaf80e6c1b..398822f47fa 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -88,6 +88,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
+  stub_ss.add(files('hmp-cmd-info_tlb.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0


