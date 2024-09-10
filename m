Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7713BEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 11:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snzPk-0004Ko-9A; Tue, 10 Sep 2024 07:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPf-00049Z-2e
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:52:05 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snzPZ-0006Zg-IY
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 07:52:01 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5356bb55224so6337792e87.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 04:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725969115; x=1726573915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZEFHfdoFuJdil5ozNrrm6kEBkj4W+e0/TKkIV2iBRM=;
 b=q1jAivPidWNeONIrCNL4kuOmEwwRlHFciSZ9PGzbvcTPd73bm8Ohvl7Lb2b8UOkjju
 5+EohLB+hJouB7V+wrGD4um5CumamuInShZQFob4sdpfZmPLR14gZPkDMbOBgcqpH2E/
 i0j9JSZ/hLgWWS60YQtApLOGjfFOInDD8SPiwEc7UVe6zbohqjCKseX8VYxjxFoutvxU
 ggz/7qrdLESXhR9kL/OnvyYVXGaWIH9z+RP6Ogsv0oa1d8tJ1RW8d+JI9KnWMCEPMArc
 1dcufLS0k0aZF99kZjb15WRQ01exj+1ULFs38nrIJvxbm3ZtGU45DZmSQwtXVXAu077O
 I4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725969115; x=1726573915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZEFHfdoFuJdil5ozNrrm6kEBkj4W+e0/TKkIV2iBRM=;
 b=IFZ7Q6saLZyKcHtb+ndZg0G8H3gPSzLG0zgvEdrXOtmEE2eIR5LAe5ErEnnaToVG7z
 eHueVBkSzIG6Nn5KpX2nC/cYOUdXqfewLywcZcqmvFN5evrH2JJnBF4jQOC/bqlW+nZo
 vMCukcQ/1eW10P8ocISNKvqz85XmJc76g47vhCdCokrxH2au2UsLFGQNsuvrP+/+fhE8
 S6V6pyoh2Y/r1ub5FCdgYmPChjnVoUxrKaipifaRE6fzpByhdHwHWsIcEtzq18WydYSy
 oqLvsNNoo9NzI4pIFAafUY9JqEN4T71PL5Qm1HvQi7FIxLMx1zUMq5mElluRhQdsoQRb
 KdBQ==
X-Gm-Message-State: AOJu0Yz3Xq7ESRWair0Yo/6gjItEdS35dpVD4vbS0Ep2rZay4694/Aw/
 /ws8UdZhK3pHZBu1AmTRy4pdiIxYAXT64XPJ9GrOBUX4pJLj56JBTlgv8gYgiO4wdQBaxxtzRHw
 L
X-Google-Smtp-Source: AGHT+IFrgdSOpCVqzP3YT7tQ09FilbjSG4RvtMsoQEw7MfC9e+QPmaBTHH7K7xUG5hjIN2hyTKnPEA==
X-Received: by 2002:a05:6512:4028:b0:52c:d905:9645 with SMTP id
 2adb3069b0e04-536587aaf0cmr8487141e87.13.1725969115099; 
 Tue, 10 Sep 2024 04:51:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c727a5sm478245666b.141.2024.09.10.04.51.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Sep 2024 04:51:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] license: Update deprecated SPDX tag LGPL-2.0+ to
 LGPL-2.0-or-later
Date: Tue, 10 Sep 2024 13:51:29 +0200
Message-ID: <20240910115131.28766-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910115131.28766-1-philmd@linaro.org>
References: <20240910115131.28766-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
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

The 'LGPL-2.0+' license identifier has been deprecated since license
list version 2.0rc2 [1] and replaced by the 'LGPL-2.0-or-later' [2]
tag.

[1] https://spdx.org/licenses/LGPL-2.0+.html
[2] https://spdx.org/licenses/LGPL-2.0-or-later.html

Mechanical patch running:

  $ sed -i -e s/LGPL-2.0+/LGPL-2.0-or-later/ \
    $(git grep -l 'SPDX-License-Identifier: LGPL-2.0+$')

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/syscalls.h    | 2 +-
 include/gdbstub/user.h        | 2 +-
 target/alpha/cpu-param.h      | 2 +-
 target/arm/cpu-param.h        | 2 +-
 target/cris/cpu-param.h       | 2 +-
 target/hppa/cpu-param.h       | 2 +-
 target/i386/cpu-param.h       | 2 +-
 target/m68k/cpu-param.h       | 2 +-
 target/microblaze/cpu-param.h | 2 +-
 target/mips/cpu-param.h       | 2 +-
 target/openrisc/cpu-param.h   | 2 +-
 target/ppc/cpu-param.h        | 2 +-
 target/sh4/cpu-param.h        | 2 +-
 target/sparc/cpu-param.h      | 2 +-
 target/sparc/insns.decode     | 2 +-
 gdbstub/gdbstub.c             | 2 +-
 gdbstub/syscalls.c            | 2 +-
 gdbstub/system.c              | 2 +-
 gdbstub/user-target.c         | 2 +-
 gdbstub/user.c                | 2 +-
 20 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/gdbstub/syscalls.h b/include/gdbstub/syscalls.h
index 54ff7245a1..d63228e96b 100644
--- a/include/gdbstub/syscalls.h
+++ b/include/gdbstub/syscalls.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2023 Linaro Ltd
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef _SYSCALLS_H_
diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
index 3b8358e3da..654986d483 100644
--- a/include/gdbstub/user.h
+++ b/include/gdbstub/user.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2022 Linaro Ltd
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef GDBSTUB_USER_H
diff --git a/target/alpha/cpu-param.h b/target/alpha/cpu-param.h
index 5ce213a9a1..c21ddf1afd 100644
--- a/target/alpha/cpu-param.h
+++ b/target/alpha/cpu-param.h
@@ -2,7 +2,7 @@
  * Alpha cpu parameters for qemu.
  *
  * Copyright (c) 2007 Jocelyn Mayer
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef ALPHA_CPU_PARAM_H
diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index fa6cae0e3a..bed29613c8 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -2,7 +2,7 @@
  * ARM cpu parameters for qemu.
  *
  * Copyright (c) 2003 Fabrice Bellard
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef ARM_CPU_PARAM_H
diff --git a/target/cris/cpu-param.h b/target/cris/cpu-param.h
index b31b742c0d..4960e89d24 100644
--- a/target/cris/cpu-param.h
+++ b/target/cris/cpu-param.h
@@ -2,7 +2,7 @@
  * CRIS cpu parameters for qemu.
  *
  * Copyright (c) 2007 AXIS Communications AB
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef CRIS_CPU_PARAM_H
diff --git a/target/hppa/cpu-param.h b/target/hppa/cpu-param.h
index 473d489f01..ef3200f0f3 100644
--- a/target/hppa/cpu-param.h
+++ b/target/hppa/cpu-param.h
@@ -2,7 +2,7 @@
  * PA-RISC cpu parameters for qemu.
  *
  * Copyright (c) 2016 Richard Henderson <rth@twiddle.net>
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef HPPA_CPU_PARAM_H
diff --git a/target/i386/cpu-param.h b/target/i386/cpu-param.h
index 5e15335203..8c75abe141 100644
--- a/target/i386/cpu-param.h
+++ b/target/i386/cpu-param.h
@@ -2,7 +2,7 @@
  * i386 cpu parameters for qemu.
  *
  * Copyright (c) 2003 Fabrice Bellard
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef I386_CPU_PARAM_H
diff --git a/target/m68k/cpu-param.h b/target/m68k/cpu-param.h
index 39dcbcece8..5bbe623ba7 100644
--- a/target/m68k/cpu-param.h
+++ b/target/m68k/cpu-param.h
@@ -2,7 +2,7 @@
  * m68k cpu parameters for qemu.
  *
  * Copyright (c) 2005-2007 CodeSourcery
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef M68K_CPU_PARAM_H
diff --git a/target/microblaze/cpu-param.h b/target/microblaze/cpu-param.h
index e530fead1c..00efb509e3 100644
--- a/target/microblaze/cpu-param.h
+++ b/target/microblaze/cpu-param.h
@@ -2,7 +2,7 @@
  * MicroBlaze cpu parameters for qemu.
  *
  * Copyright (c) 2009 Edgar E. Iglesias
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef MICROBLAZE_CPU_PARAM_H
diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 6f6ac1688f..f3a37e2dbe 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -1,7 +1,7 @@
 /*
  * MIPS cpu parameters for qemu.
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef MIPS_CPU_PARAM_H
diff --git a/target/openrisc/cpu-param.h b/target/openrisc/cpu-param.h
index fbfc0f568b..6169ed9f55 100644
--- a/target/openrisc/cpu-param.h
+++ b/target/openrisc/cpu-param.h
@@ -2,7 +2,7 @@
  * OpenRISC cpu parameters for qemu.
  *
  * Copyright (c) 2011-2012 Jia Liu <proljc@gmail.com>
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef OPENRISC_CPU_PARAM_H
diff --git a/target/ppc/cpu-param.h b/target/ppc/cpu-param.h
index 77c5ed9a67..9c481b9f6c 100644
--- a/target/ppc/cpu-param.h
+++ b/target/ppc/cpu-param.h
@@ -2,7 +2,7 @@
  * PowerPC cpu parameters for qemu.
  *
  * Copyright (c) 2007 Jocelyn Mayer
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef PPC_CPU_PARAM_H
diff --git a/target/sh4/cpu-param.h b/target/sh4/cpu-param.h
index a7cdb7edb6..a30ba992b3 100644
--- a/target/sh4/cpu-param.h
+++ b/target/sh4/cpu-param.h
@@ -2,7 +2,7 @@
  * SH4 cpu parameters for qemu.
  *
  * Copyright (c) 2005 Samuel Tardieu
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef SH4_CPU_PARAM_H
diff --git a/target/sparc/cpu-param.h b/target/sparc/cpu-param.h
index 82293fb844..14105dc18b 100644
--- a/target/sparc/cpu-param.h
+++ b/target/sparc/cpu-param.h
@@ -1,7 +1,7 @@
 /*
  * Sparc cpu parameters for qemu.
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #ifndef SPARC_CPU_PARAM_H
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5fd478191a..d434a30106 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: LGPL-2.0+
+# SPDX-License-Identifier: LGPL-2.0-or-later
 #
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index d08568cea0..b1def7e71d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -20,7 +20,7 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
index 4e1295b782..4ddd5cae06 100644
--- a/gdbstub/syscalls.c
+++ b/gdbstub/syscalls.c
@@ -7,7 +7,7 @@
  * Copyright (c) 2003-2005 Fabrice Bellard
  * Copyright (c) 2023 Linaro Ltd
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 1ad87fe7fd..c9f236e94f 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -7,7 +7,7 @@
  * Copyright (c) 2003-2005 Fabrice Bellard
  * Copyright (c) 2022 Linaro Ltd
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index b5e01fd8b0..22bf4008c0 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2003-2005 Fabrice Bellard
  * Copyright (c) 2022 Linaro Ltd
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/gdbstub/user.c b/gdbstub/user.c
index b36033bc7a..0b4bfa9c48 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2003-2005 Fabrice Bellard
  * Copyright (c) 2022 Linaro Ltd
  *
- * SPDX-License-Identifier: LGPL-2.0+
+ * SPDX-License-Identifier: LGPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
-- 
2.45.2


