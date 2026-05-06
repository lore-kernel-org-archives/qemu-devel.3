Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EF9CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcqb-0008KC-Vj; Wed, 06 May 2026 10:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpT-0007EV-80
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcpQ-0000tY-5M
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:02:21 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ad135063so61567775e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076138; x=1778680938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7kXWCWGQPYwwqBv/UVwNdK1EbhrE/SU047Bh0KrJsqI=;
 b=XLsMGXiJS/zya3q+YUsNQ4U33NmQUF177lINVfejrblzV/WOv78Le/Vs6Isydh4Mr8
 loiExrGWcwODCHRB0gLhSWntAKeeJwWirDAfkeUTWzNkja5NwQ80ao26kAuAzJvXAgJP
 CmGFu7/Hmf3QuRqEH9xqQKhsnOwJUM58jMBKnwQ4xrjuI7w85mlM9ctruwpqmznzhLh5
 rNBilD1hgLueI5HRUwbDpyV9KfH6rXMgBhfGOWUczJ/2a2kcvbyj+RczEvQnUDQXwcMe
 FMsp10Sh39dq6NhV7/Wnh/0q4XZWSOsyO/WWNy+2qfsCd3uuBgTcnTAIzZIcRYtz/8K3
 dB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076138; x=1778680938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7kXWCWGQPYwwqBv/UVwNdK1EbhrE/SU047Bh0KrJsqI=;
 b=UJjobjtNWIyFpQBtxP1Noap6z6ZPZZtq7fZ8/GEWB96GK7TkImbr6PTSkJxCl88xYO
 kAOAiLTmxFzhBzSaZD7yoAYEYcFItm57ItkEI0Is9BhYxAxFXHoIh4zcMSr+5GqfdC3n
 BE0Ad4NLuywtbhNVyU4X5Ws0C9OT5Y3PaI43nwzddGVpqvNCcxWzmY/e4qWQdywsqmh4
 kl6uxzX7vip22qFtU1JLiyIQPV5YXLzD0guMopdzUqozax+X6ccNRHIDVh89V/C4+c/U
 d82414OrOhvESxzpe8ks5lS8e6thg2OXzRUguMrsA7xA8gY9gJhy/hcvi6s6TMf2oHSO
 WwJA==
X-Gm-Message-State: AOJu0YztQEERe+wW8BRgqIekMZLBcc+/Fq52N3QIbbc1RoFuXx4enaws
 QPXQy0av0hV2Utnr1q1+NRkx1ebs2z7kQAY1J792Y3Dp2C4mpMFkd7BajzeYFNOxvHKfcOy0Xa+
 jT+KE/oQ=
X-Gm-Gg: AeBDieuHme79homwM8kNzbQxQhD6fACDYmB6LLCH4cpF4j3QNfMkjyHTyJnRH1qYgtg
 h1iNI5gtaVDwAENYw3476vPRmCp+4i/F8q/Yz2MOV1/jfZzzaPB4qSfduaYCu+AexF4JS06z72H
 hMjS5LkcGTc+baYD5CtMZbbVKR/qaPc4OXBQ6RzlhB4rrrAQObw3drJdjXbWhnVN6HNnGzexl1A
 3OZ80iecRhfqEYHdC+5t9xBXC+GOcLKgI1NcEkVrJtuOPmMmtpnBJAlRltyXFmSMmC5l2y9G/16
 AEAtY1EEJK1dH+aaNX7/awg8X4XLBZSU+FLoYC7i0yxP2i8j2spaXsP+ScAn4jtg5mpAXENS/09
 4BEL8BFQwUUsQQx6nrquii6kN5NYwArKdfB5c8YPYpXiF0z6lo1spDVcnMv7qrDh5bqyUZpDBdN
 pCuTQf/qPClK+D4qTKIck836lcZ+bihVadx8jT+ccrU43Fa4Xf88p8ZSFrZL44xPEeduHX3D2mW
 H4RQkMLpGc=
X-Received: by 2002:a05:600c:33a9:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-48e51e0bb9amr39512935e9.1.1778076137397; 
 Wed, 06 May 2026 07:02:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538a8159sm56606785e9.6.2026.05.06.07.02.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:02:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 053/110] monitor: Do not check TARGET_I386/RISCV to build 'info
 mem' command
Date: Wed,  6 May 2026 15:54:25 +0200
Message-ID: <20260506135524.20617-54-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

This command is filtered at build-time for i386/x86_64 and
riscv32/riscv64 binaries. By using the recently introduced
HMPCommand::arch_bitmask flag we can filter it at runtime,
making it possible to compile hmp-commands-info.hx once.

Since the method depends on a pair of distinct targets,
define it in its own stub file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20260427080738.77138-18-philmd@linaro.org>
---
 stubs/hmp-cmd-info_mem.c | 12 ++++++++++++
 hmp-commands-info.hx     |  3 +--
 stubs/meson.build        |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)
 create mode 100644 stubs/hmp-cmd-info_mem.c

diff --git a/stubs/hmp-cmd-info_mem.c b/stubs/hmp-cmd-info_mem.c
new file mode 100644
index 00000000000..8a53e367a9f
--- /dev/null
+++ b/stubs/hmp-cmd-info_mem.c
@@ -0,0 +1,12 @@
+/*
+ * Human Monitor 'info mem' stub
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+HMP_STUB(info_mem)
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 480a5a79ecb..c93c049daea 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -202,15 +202,14 @@ SRST
     Show virtual to physical memory mappings.
 ERST
 
-#if defined(TARGET_I386) || defined(TARGET_RISCV)
     {
         .name       = "mem",
         .args_type  = "",
         .params     = "",
         .help       = "show the active virtual memory mappings",
         .cmd        = hmp_info_mem,
+        .arch_bitmask = QEMU_ARCH_I386 | QEMU_ARCH_RISCV,
     },
-#endif
 
 SRST
   ``info mem``
diff --git a/stubs/meson.build b/stubs/meson.build
index f086521cde4..33053d932c8 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -87,6 +87,7 @@ if have_system
   stub_ss.add(files('qmp-cpu.c'))
   stub_ss.add(files('qmp-cpu-s390x.c'))
   stub_ss.add(files('qmp-cpu-s390x-kvm.c'))
+  stub_ss.add(files('hmp-cmd-info_mem.c'))
   stub_ss.add(files('hmp-cmd-info_sev.c'))
   stub_ss.add(files('hmp-cmds-hw-s390x.c'))
   stub_ss.add(files('hmp-cmds-target-i386.c'))
-- 
2.53.0


