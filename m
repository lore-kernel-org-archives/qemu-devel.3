Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AC5FF8861
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH2L-0003C1-KR; Mon, 27 Apr 2026 04:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2J-0002sh-Of
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH2I-00029A-2r
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:09:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso98648275e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277385; x=1777882185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pik3BU464hnFHYYfndKD9+oHzuH7HfW/xw+RI/N+w7I=;
 b=bSjpvvv7UM2GLcRF4dHVXuZ2kYxSqZ0BT7i0xGGYLMfq17tFZtYoXQCKoFIlYklmw2
 /gZtTnySIefvoPNAUdR4wMZmcllGSmC+2NY6nW+7jmXGn1j4tlleqTx27efroWvX3BFQ
 MZPcIT/Lfpq5D2XIb89+cI1NCRsD5irrUd1nbTpZKnHWQMSrj2HuPtSyIaYWqXTb4oQ2
 Bl6W3xoCdgFORB5anwTAHQA0Mn9HUTQVmY16xxcu8T1BajD/SS7L51wSMDT3/lMqO/Hf
 ELD2vkxTLDnUyi2E/6cilF3hwSuGj0t8lQLubL3Q71RAXN9gFFHaqpIj9MYlTyu7Pelp
 Iing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277385; x=1777882185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pik3BU464hnFHYYfndKD9+oHzuH7HfW/xw+RI/N+w7I=;
 b=o+3IpP7Hp3QxbASraIPFadtaCNUp4fgp7R58kTN9IlzuD3646K1NgS5FVaTqnFCeuT
 2b5DNaTlPawCHyDTfF9V3rJ507zvSXi2E21V4LzlbEC+EfsKcBotRSdkMkHa9Fz72XZ+
 5zh2Yjch/9hfkfnOPSpgnfJq7Qz4li1d46oUyyJioBXHN5PWgN9eESliL4n0QA1uPwD/
 01suneU4LVzTnvjh99nHU6IqmV+cyDlTbQfgGterXE9TVp3Jxopw47Gd3t55K/D5CoM8
 SS+wFABiBogG274gaL9HQi/IejTNStT6ZlfNxFMik/d3n13GXyokCVhXozZKYellPuY7
 3Sxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VkcAPuRJMszwKyNKDDiFoVK5YwwV3VvcBGF5ubXaLIZJeBG32IS5KkaO1sAulzBItVqOoAmJF1Jmi@nongnu.org
X-Gm-Message-State: AOJu0Yxw34d+cuMKyERZbKWyzLLk1K05iKmq1LQGnvoSEcFoqJeACter
 I/3aSNjuIYWm2Ks0jTTu3p21zFN+UANytZuauZfVvaWKldO+DKeV81JCNb3kC990IK4=
X-Gm-Gg: AeBDiesSONercqFo4gCC0y0o6yI6ArlAwVU18UFsdNpt38uX/Xc2u4ae6eCVLDV/wKO
 2JgdEbqmdeMBLSXaC0Q3v0xFEWOUnyZmH6lbjmuDuwmX9eaciwYOCrnGa5TzD3f9pVfXJQ0A8wN
 3nVjkV2GRQ90aGAL3f9XmOFdnI/1iUxTqVPhfg9BlqM0ztnF5eyFwueblCLqw/YtLJbCmpZ80TL
 a+MOPNTpTQi5Z+s9LNh07sgYqiHkyT33qHPnAH/dpCvAW/IW2FZOzXWWkN9MtE/9KSEz1hIk/wM
 3Y3kyWq9eR/YFC66i4rLiQI5b0rpBS8sriI4GEKFjVaWpoBj4bZgEweLdFZMXfamIyDzZ38JByi
 thQBwxUOvtfV7wKIZoaoTr8bM0+ASB92JGUXviY8o9zt87lBWIcdVVZTeatGpBh2HrsJ9mn6Fmj
 U65cDgmt+tQW5lzT8BkdkslhdVH0/beHw8G/26W1TqewKKyi+UpWR3yf06YVNDYwMFbGoli57A7
 i9yjHM61WM=
X-Received: by 2002:a05:600c:a416:b0:488:e7e4:8425 with SMTP id
 5b1f17b1804b1-488fb787674mr473342705e9.23.1777277384463; 
 Mon, 27 Apr 2026 01:09:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1249sm75288495f8f.5.2026.04.27.01.09.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:09:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 18/32] monitor: Do not check multiple TARGET_* to build
 'info tlb' command
Date: Mon, 27 Apr 2026 10:07:24 +0200
Message-ID: <20260427080738.77138-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
index 33053d932c8..2f4e1ab4300 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -89,6 +89,7 @@ if have_system
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
   stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
+  stub_ss.add(files('hmp-cmd-info_tlb.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
 endif
-- 
2.53.0


