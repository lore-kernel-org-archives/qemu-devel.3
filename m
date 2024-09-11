Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AD4EE49BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:16:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soP2O-0008G6-Qj; Wed, 11 Sep 2024 11:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP1E-0003Mk-4l
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:12:32 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soP1B-0001Ir-Dd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 11:12:31 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7a843bef98so551052466b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 08:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726067547; x=1726672347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUs0kQTHYShzT3bcv8mwq67EYJLTHk6x1ciaWG3e2bs=;
 b=v9JB1gaUXkRnSSglDadiVTTPFsQdqXOWga4blH2PMLC6IZQiD6AZHdN75pZlpZiEhK
 eO7o7BHxWb+W1KmF+u72C3K7woDgSx+3iDmyXOwYSIZ/DYPP+qGR9EKPwpDbJ5F4Yhxd
 3kDPfbtqU9UXquMmvy6pwGT3PKn5w9F2QAc8e/qIpwR/ZHKui4+NKoV+OXZJKuXIWukG
 Wg9P5SvvZbJsykcDpZ/62+QoWzWWe2lJIrfrdqEQrCjbmhG8zuShCrr9XEGFw0U1yJu9
 edZj4G6TOURWeGZSIejP/4ibqzymBX50g2IipVvQ6OvwTAtUGAiuTVB6jzD6p7c8oM2M
 VxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726067547; x=1726672347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUs0kQTHYShzT3bcv8mwq67EYJLTHk6x1ciaWG3e2bs=;
 b=v71N1vb/vclIq9bxJirTdVEsand+F0CCL2wfU6ZaRayUPYuagd1MwFrjkcXCsg1YWm
 azyk7XZRNCyycs2q1KKt/SvLwAQ220Aef+lYjnX+gQSPOwwa6iSneXEZnr8DM4fV46li
 POaH2dLfm4Zg/fYqi4Dfz1wqcDllv/Vmi2IO3vX692CRpQJbikajWkYJjMs+MavlE6Q9
 cXxn8GC6pAzmE8MYSHR7F2IaMpy1FzWrGtwBiSlwEuMgyhkpScagfZv7Rnq1vxnymj5M
 5ShyaifpmI6JFLh3DuM8JsDUzFdXlRsklXmn+wnEpuEDP4esACE3TENxGFwV9cmPgzLJ
 bwUw==
X-Gm-Message-State: AOJu0Yy9NafnrUuI5yFKoVjZ+ZwJsT/4iRXMT+QtmFLFdU2tYqEIKz7v
 2AjvThMZKHqSud1LPT+346YbJPSLg6qTuRYrZTw9byKt0DosD8WzsXxgfVXepIW5dcasDwom1Ox
 M
X-Google-Smtp-Source: AGHT+IE7IXwoG0tqMjMOD9I9Ym1tp9oV4CIepw5IMfTfxBhKlvodW7DEUiPL44+yJFrqoOWFdX9lEA==
X-Received: by 2002:a17:906:dc91:b0:a8d:401b:db85 with SMTP id
 a640c23a62f3a-a8ffab944a3mr391658066b.36.1726067547186; 
 Wed, 11 Sep 2024 08:12:27 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d657fesm627207966b.221.2024.09.11.08.12.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 08:12:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH v3 3/5] license: Update deprecated SPDX tag LGPL-2.0+ to
 LGPL-2.0-or-later
Date: Wed, 11 Sep 2024 17:12:04 +0200
Message-ID: <20240911151206.60368-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911151206.60368-1-philmd@linaro.org>
References: <20240911151206.60368-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


