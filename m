Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08018CD3444
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPZ-000659-Sf; Wed, 06 May 2026 22:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPY-00064o-It
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:24 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPS-0007b7-VV
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:24 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-691de293326so189607eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120657; x=1778725457;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4qZqxhOzngQmEvRDxcGHAbPP+n1V6Vsluq21YDlzvA=;
 b=W2QSXtLxxI57WIvtYPdrnH6WDhQb6tH2Z/P0GXVBukuYQbA079QA5Rc03BWoe+XvX7
 uNAr0FrEbtHtH1Uw+Qq4Z9SiK1wwPfIQoTLbFyGLnpq4pAYSrxYHcrEZ9KYfFe1VrV/i
 TnBgiIaa2aXx561ES/ZWMC9Gr4ntJqe+8oXnH+Yzdf0jUfsNQVfzndfIOK+hdriBPYWK
 1QpFTUVwANue2+xPbWQpv7QGvaYyvdK/nWfM+jf2w5zzDlF7ION4GlIE4SHnTamfr9NQ
 3AIxBCSH4trIctsLYDqLU5fe1MycVHmTvijr1ODEfD5Lifj7MMZecYSFWcpQwI1myt1p
 nsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120657; x=1778725457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a4qZqxhOzngQmEvRDxcGHAbPP+n1V6Vsluq21YDlzvA=;
 b=GUmjPeBqGzfNo/cmZx4Fhupb7/fvwzcL3mm/J9A/F12t10wjmsNpkUl/PYqri1dzvX
 hFXfzFSNMQ56l2PU9RpVk2SsF9eBjuI3Rfvbb/Q3LjLBqu3dsnQBE1siF9tXmBmfal7S
 rIdfOYWlPsPsOPGC9ImeQWjYNdE0qQUvG9Jkb9y3GF+odHj1iWcOalZA1xMz7jquZXe/
 okjw2mG3Ey5kgEHPg7pjh/Bx6oWl1sESAef0VjGDVMIotM5vyFeFJCop5dR8wGgvnAFx
 oOJIAx3cXtZ7sgxtxq6G8Fkj/5EUuH0ZlAAFXXpFBeazIitAU9yMN5wU1LPLOMnFnr0c
 CthQ==
X-Gm-Message-State: AOJu0YwbPTrsfbZc2IuZByLZ/PMSJdZZtoCUjMpwQ23onCBj6nWEiVSN
 xgVGByjyrTnu/L9+X9tHUudoYF7obeJ/xnNX/LqXTGZfyyTnQC7uh9IS8uwW2DD/gPuBp4yESNc
 NOyuQLzU=
X-Gm-Gg: AeBDievG1sOQZf0gKrikS0HgHXbvg5AzIP7bHg0PpnSSA8HDTJ/OJ8V1uLcduwwRq/A
 eeuYrHi64vZMbA6G939d/ivQIJWVJvF0DfHkDPlwLlNOcjsKdRaZRH8dH/+XizWbs5mTCip/d4K
 uJ5Hj5mkl3G6baIEer7BdNsL8JEJYxzhJxw5riVi/UTHGay6rpgfoAf94mmLrnDV+xGVKuEBy7N
 7yA1mV0MMuz5DBQZHAINWIFKOSsw2uwpi3IO8JW1WvEX6JxyrouPlyGlgV/pvk9hSzvn1ZbiUoL
 WFHRqnIlGMa1Aqu8F2E30/sqxn3dsvlCLcULTzEHWYba3ug6NtXXEoiianTlMsnGOy18HnbAAvU
 12EsxHnNim99lklz5y6RFAS2D9dme9vaZqARRbuCgNbNOtgJAQKTU+yrRBziXdVSu7rCfmKd7xQ
 6hp6wmgN5ieGnQuVjaPJsJ4F6572RzLi0=
X-Received: by 2002:a4a:e918:0:b0:694:8ed8:e59b with SMTP id
 006d021491bc7-69998d5c6d2mr3474102eaf.54.1778120655156; 
 Wed, 06 May 2026 19:24:15 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:14 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>, Sean Bruno <sbruno@FreeBSD.org>,
 =?UTF-8?q?Mika=C3=ABl=20Urankar?= <mikael.urankar@gmail.com>,
 Kyle Evans <kevans@FreeBSD.org>, Guy Yur <guyyur@gmail.com>,
 Alexander Kabaev <kan@FreeBSD.org>, Michal Meloun <mmel@FreeBSD.org>,
 Ed Schouten <ed@nuxi.nl>, Karim Taha <kariem.taha2.7@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/25] bsd-user: Switch to SPDX-License-Expression
Date: Wed,  6 May 2026 20:21:55 -0600
Message-ID: <20260507022219.44171-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Two minor changes to the copyright and license marking for these files:
(1) Stacey D Son is used instead of variations of his name.
(2) The GPL boilerplate is replaced by SPDX markings. No change to the
terms of the license are intended, and this matches current QEMU practice.

There's no changes to the license or additional claims to any IP that
others may hold in these files. All the S-o-bs in this commit have given
me permission to do this to the extent they may hold rights. git blame
over multiple repos and branches suggests that only minimal other
material is present (much of it likely not subject to copyright
protection). The project's long and complex history as well as tooling
limitations make it hard to be 100% sure. Any omissions are
unintentional and I will correct them as they come to light.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Sean Bruno <sbruno@FreeBSD.org>
Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Guy Yur <guyyur@gmail.com>
Signed-off-by: Alexander Kabaev <kan@FreeBSD.org>
Signed-off-by: Michal Meloun <mmel@FreeBSD.org>
Signed-off-by: Ed Schouten <ed@nuxi.nl>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/aarch64/signal.c               | 15 ++-------------
 bsd-user/aarch64/target_arch.h          | 16 ++--------------
 bsd-user/aarch64/target_arch_cpu.c      | 15 ++-------------
 bsd-user/aarch64/target_arch_cpu.h      | 18 +++---------------
 bsd-user/aarch64/target_arch_elf.h      | 14 +-------------
 bsd-user/aarch64/target_arch_reg.h      | 19 +++----------------
 bsd-user/aarch64/target_arch_signal.h   | 16 ++--------------
 bsd-user/aarch64/target_arch_sigtramp.h | 16 ++--------------
 bsd-user/aarch64/target_arch_sysarch.h  | 16 ++--------------
 bsd-user/aarch64/target_arch_thread.h   | 16 ++--------------
 bsd-user/aarch64/target_arch_vmparam.h  | 16 ++--------------
 bsd-user/aarch64/target_syscall.h       | 16 ++--------------
 bsd-user/arm/signal.c                   | 18 +++---------------
 bsd-user/arm/target_arch.h              | 16 ++--------------
 bsd-user/arm/target_arch_cpu.c          | 18 +++---------------
 bsd-user/arm/target_arch_cpu.h          | 18 +++---------------
 bsd-user/arm/target_arch_elf.h          | 18 +++---------------
 bsd-user/arm/target_arch_reg.h          | 18 +++---------------
 bsd-user/arm/target_arch_signal.h       | 18 +++---------------
 bsd-user/arm/target_arch_sigtramp.h     | 18 +++---------------
 bsd-user/arm/target_arch_sysarch.h      | 18 +++---------------
 bsd-user/arm/target_arch_thread.h       | 18 +++---------------
 bsd-user/arm/target_arch_vmparam.h      | 18 +++---------------
 bsd-user/arm/target_syscall.h           | 18 +++---------------
 bsd-user/bsd-file.h                     | 18 +++---------------
 bsd-user/bsd-mem.c                      | 17 +++--------------
 bsd-user/bsd-mem.h                      | 17 +++--------------
 bsd-user/bsd-proc.c                     | 17 +++--------------
 bsd-user/bsd-proc.h                     | 17 +++--------------
 bsd-user/freebsd/os-misc.h              | 18 +++---------------
 bsd-user/freebsd/os-proc.c              | 17 +++--------------
 bsd-user/freebsd/os-proc.h              | 18 +++---------------
 bsd-user/freebsd/os-stat.c              | 17 +++--------------
 bsd-user/freebsd/os-stat.h              | 18 +++---------------
 bsd-user/freebsd/os-strace.h            | 19 +++----------------
 bsd-user/freebsd/target_os_elf.h        | 18 +++---------------
 bsd-user/freebsd/target_os_siginfo.h    | 18 +++---------------
 bsd-user/freebsd/target_os_signal.h     |  7 +++++++
 bsd-user/freebsd/target_os_stack.h      | 18 +++---------------
 bsd-user/freebsd/target_os_thread.h     | 18 +++---------------
 bsd-user/freebsd/target_os_user.h       | 18 +++---------------
 bsd-user/freebsd/target_os_vmparam.h    | 18 +++---------------
 bsd-user/i386/signal.c                  | 17 +++--------------
 bsd-user/i386/target_arch.h             | 16 ++--------------
 bsd-user/i386/target_arch_cpu.c         | 17 +++--------------
 bsd-user/i386/target_arch_cpu.h         | 17 +++--------------
 bsd-user/i386/target_arch_elf.h         | 18 +++---------------
 bsd-user/i386/target_arch_reg.h         | 19 +++----------------
 bsd-user/i386/target_arch_signal.h      | 16 +++-------------
 bsd-user/i386/target_arch_sigtramp.h    | 16 ++--------------
 bsd-user/i386/target_arch_sysarch.h     | 18 +++---------------
 bsd-user/i386/target_arch_thread.h      | 18 +++---------------
 bsd-user/i386/target_arch_vmparam.h     | 18 +++---------------
 bsd-user/i386/target_syscall.h          | 16 +++-------------
 bsd-user/qemu-bsd.h                     | 18 +++---------------
 bsd-user/syscall_defs.h                 | 18 +++---------------
 bsd-user/x86_64/signal.c                | 16 +++-------------
 bsd-user/x86_64/target_arch.h           | 16 ++--------------
 bsd-user/x86_64/target_arch_cpu.c       | 17 +++--------------
 bsd-user/x86_64/target_arch_cpu.h       | 17 +++--------------
 bsd-user/x86_64/target_arch_elf.h       | 18 +++---------------
 bsd-user/x86_64/target_arch_reg.h       | 19 +++----------------
 bsd-user/x86_64/target_arch_signal.h    | 17 +++--------------
 bsd-user/x86_64/target_arch_sigtramp.h  | 17 ++---------------
 bsd-user/x86_64/target_arch_sysarch.h   | 17 +++--------------
 bsd-user/x86_64/target_arch_thread.h    | 18 +++---------------
 bsd-user/x86_64/target_arch_vmparam.h   | 18 +++---------------
 bsd-user/x86_64/target_syscall.h        | 16 +++-------------
 68 files changed, 192 insertions(+), 971 deletions(-)

diff --git a/bsd-user/aarch64/signal.c b/bsd-user/aarch64/signal.c
index 6bc73a798f..ad19e5144e 100644
--- a/bsd-user/aarch64/signal.c
+++ b/bsd-user/aarch64/signal.c
@@ -1,20 +1,9 @@
 /*
  * ARM AArch64 specific signal definitions for bsd-user
  *
- * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 
diff --git a/bsd-user/aarch64/target_arch.h b/bsd-user/aarch64/target_arch.h
index 4815a56ae3..7861233889 100644
--- a/bsd-user/aarch64/target_arch.h
+++ b/bsd-user/aarch64/target_arch.h
@@ -1,22 +1,10 @@
 /*
  * ARM AArch64 specific prototypes for bsd-user
  *
- * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_H
 #define TARGET_ARCH_H
 
diff --git a/bsd-user/aarch64/target_arch_cpu.c b/bsd-user/aarch64/target_arch_cpu.c
index b2fa59efaf..6e9519e1b0 100644
--- a/bsd-user/aarch64/target_arch_cpu.c
+++ b/bsd-user/aarch64/target_arch_cpu.c
@@ -1,20 +1,9 @@
 /*
  * ARM AArch64 specific CPU for bsd-user
  *
- * Copyright (c) 2015 Stacey Son
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 #include "target_arch.h"
diff --git a/bsd-user/aarch64/target_arch_cpu.h b/bsd-user/aarch64/target_arch_cpu.h
index 15df84fda2..09d942b040 100644
--- a/bsd-user/aarch64/target_arch_cpu.h
+++ b/bsd-user/aarch64/target_arch_cpu.h
@@ -1,22 +1,10 @@
 /*
- *  ARM AArch64 cpu init and loop
+ * ARM AArch64 cpu init and loop
  *
- * Copyright (c) 2015 Stacey Son
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_CPU_H
 #define TARGET_ARCH_CPU_H
 
diff --git a/bsd-user/aarch64/target_arch_elf.h b/bsd-user/aarch64/target_arch_elf.h
index cec254f88b..5ea5232a57 100644
--- a/bsd-user/aarch64/target_arch_elf.h
+++ b/bsd-user/aarch64/target_arch_elf.h
@@ -3,20 +3,8 @@
  *
  * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
diff --git a/bsd-user/aarch64/target_arch_reg.h b/bsd-user/aarch64/target_arch_reg.h
index b53302e7f7..9cca3c0ea0 100644
--- a/bsd-user/aarch64/target_arch_reg.h
+++ b/bsd-user/aarch64/target_arch_reg.h
@@ -1,23 +1,10 @@
 /*
- *  FreeBSD arm64 register structures
+ * FreeBSD arm64 register structures
  *
- *  Copyright (c) 2015 Stacey Son
- *  All rights reserved.
+ * Copyright (c) 2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_REG_H
 #define TARGET_ARCH_REG_H
 
diff --git a/bsd-user/aarch64/target_arch_signal.h b/bsd-user/aarch64/target_arch_signal.h
index b72ba7aa50..6085217546 100644
--- a/bsd-user/aarch64/target_arch_signal.h
+++ b/bsd-user/aarch64/target_arch_signal.h
@@ -1,22 +1,10 @@
 /*
  * ARM AArch64 specific signal definitions for bsd-user
  *
- * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SIGNAL_H
 #define TARGET_ARCH_SIGNAL_H
 
diff --git a/bsd-user/aarch64/target_arch_sigtramp.h b/bsd-user/aarch64/target_arch_sigtramp.h
index 8cdd33b621..38a447fc25 100644
--- a/bsd-user/aarch64/target_arch_sigtramp.h
+++ b/bsd-user/aarch64/target_arch_sigtramp.h
@@ -1,22 +1,10 @@
 /*
  * ARM AArch64 sigcode for bsd-user
  *
- * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SIGTRAMP_H
 #define TARGET_ARCH_SIGTRAMP_H
 
diff --git a/bsd-user/aarch64/target_arch_sysarch.h b/bsd-user/aarch64/target_arch_sysarch.h
index b003015daf..5569c996cb 100644
--- a/bsd-user/aarch64/target_arch_sysarch.h
+++ b/bsd-user/aarch64/target_arch_sysarch.h
@@ -1,22 +1,10 @@
 /*
  * ARM AArch64 sysarch() system call emulation for bsd-user.
  *
- * Copyright (c) 2015 <sson at FreeBSD>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SYSARCH_H
 #define TARGET_ARCH_SYSARCH_H
 
diff --git a/bsd-user/aarch64/target_arch_thread.h b/bsd-user/aarch64/target_arch_thread.h
index 4c911e605a..06676980c9 100644
--- a/bsd-user/aarch64/target_arch_thread.h
+++ b/bsd-user/aarch64/target_arch_thread.h
@@ -1,22 +1,10 @@
 /*
  * ARM AArch64 thread support for bsd-user.
  *
- * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_THREAD_H
 #define TARGET_ARCH_THREAD_H
 
diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64/target_arch_vmparam.h
index 0c35491970..ea32f5b56d 100644
--- a/bsd-user/aarch64/target_arch_vmparam.h
+++ b/bsd-user/aarch64/target_arch_vmparam.h
@@ -1,22 +1,10 @@
 /*
  * ARM AArch64 VM parameters definitions for bsd-user.
  *
- * Copyright (c) 2015 Stacey D. Son <sson at FreeBSD>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_VMPARAM_H
 #define TARGET_ARCH_VMPARAM_H
 
diff --git a/bsd-user/aarch64/target_syscall.h b/bsd-user/aarch64/target_syscall.h
index 08ae913c42..a574edc429 100644
--- a/bsd-user/aarch64/target_syscall.h
+++ b/bsd-user/aarch64/target_syscall.h
@@ -1,22 +1,10 @@
 /*
  * ARM AArch64 specific CPU for bsd-user
  *
- * Copyright (c) 2015 Stacey D. Son <sson at Freebsd>
+ * Copyright (c) 2015 Stacey D. Son
  *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef BSD_USER_AARCH64_TARGET_SYSCALL_H
 #define BSD_USER_AARCH64_TARGET_SYSCALL_H
 
diff --git a/bsd-user/arm/signal.c b/bsd-user/arm/signal.c
index 9734407543..35cedeba06 100644
--- a/bsd-user/arm/signal.c
+++ b/bsd-user/arm/signal.c
@@ -1,22 +1,10 @@
 /*
- *  arm signal functions
+ * arm signal functions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #include "qemu/osdep.h"
 #include "qemu.h"
 
diff --git a/bsd-user/arm/target_arch.h b/bsd-user/arm/target_arch.h
index d80cb85c64..e0add162e8 100644
--- a/bsd-user/arm/target_arch.h
+++ b/bsd-user/arm/target_arch.h
@@ -1,22 +1,10 @@
 /*
  * ARM 32-bit specific prototypes for bsd-user
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_H
 #define TARGET_ARCH_H
 
diff --git a/bsd-user/arm/target_arch_cpu.c b/bsd-user/arm/target_arch_cpu.c
index fe38ae2210..6a4f5cec0e 100644
--- a/bsd-user/arm/target_arch_cpu.c
+++ b/bsd-user/arm/target_arch_cpu.c
@@ -1,22 +1,10 @@
 /*
- *  arm cpu related code
+ * arm cpu related code
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #include "qemu/osdep.h"
 #include "target_arch.h"
 
diff --git a/bsd-user/arm/target_arch_cpu.h b/bsd-user/arm/target_arch_cpu.h
index 9a952ef0ff..faef3ea17a 100644
--- a/bsd-user/arm/target_arch_cpu.h
+++ b/bsd-user/arm/target_arch_cpu.h
@@ -1,22 +1,10 @@
 /*
- *  arm cpu init and loop
+ * arm cpu init and loop
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_CPU_H
 #define TARGET_ARCH_CPU_H
 
diff --git a/bsd-user/arm/target_arch_elf.h b/bsd-user/arm/target_arch_elf.h
index b54bf5fbc6..fd13bc87f4 100644
--- a/bsd-user/arm/target_arch_elf.h
+++ b/bsd-user/arm/target_arch_elf.h
@@ -1,22 +1,10 @@
 /*
- *  arm ELF definitions
+ * arm ELF definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
diff --git a/bsd-user/arm/target_arch_reg.h b/bsd-user/arm/target_arch_reg.h
index 070fa24da1..9d23dda27d 100644
--- a/bsd-user/arm/target_arch_reg.h
+++ b/bsd-user/arm/target_arch_reg.h
@@ -1,22 +1,10 @@
 /*
- *  FreeBSD arm register structures
+ * FreeBSD arm register structures
  *
- *  Copyright (c) 2015 Stacey Son
+ * Copyright (c) 2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_REG_H
 #define TARGET_ARCH_REG_H
 
diff --git a/bsd-user/arm/target_arch_signal.h b/bsd-user/arm/target_arch_signal.h
index 10f96b8bfc..dfaefa25d1 100644
--- a/bsd-user/arm/target_arch_signal.h
+++ b/bsd-user/arm/target_arch_signal.h
@@ -1,22 +1,10 @@
 /*
- *  arm signal definitions
+ * arm signal definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SIGNAL_H
 #define TARGET_ARCH_SIGNAL_H
 
diff --git a/bsd-user/arm/target_arch_sigtramp.h b/bsd-user/arm/target_arch_sigtramp.h
index 06198045ed..8a2d34aafc 100644
--- a/bsd-user/arm/target_arch_sigtramp.h
+++ b/bsd-user/arm/target_arch_sigtramp.h
@@ -1,22 +1,10 @@
 /*
- *  arm sysarch() system call emulation
+ * arm sysarch() system call emulation
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SIGTRAMP_H
 #define TARGET_ARCH_SIGTRAMP_H
 
diff --git a/bsd-user/arm/target_arch_sysarch.h b/bsd-user/arm/target_arch_sysarch.h
index 5cb7864197..5f7c421e11 100644
--- a/bsd-user/arm/target_arch_sysarch.h
+++ b/bsd-user/arm/target_arch_sysarch.h
@@ -1,22 +1,10 @@
 /*
- *  arm sysarch() system call emulation
+ * arm sysarch() system call emulation
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SYSARCH_H
 #define TARGET_ARCH_SYSARCH_H
 
diff --git a/bsd-user/arm/target_arch_thread.h b/bsd-user/arm/target_arch_thread.h
index fd257f313d..d22619a845 100644
--- a/bsd-user/arm/target_arch_thread.h
+++ b/bsd-user/arm/target_arch_thread.h
@@ -1,22 +1,10 @@
 /*
- *  arm thread support
+ * arm thread support
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_THREAD_H
 #define TARGET_ARCH_THREAD_H
 
diff --git a/bsd-user/arm/target_arch_vmparam.h b/bsd-user/arm/target_arch_vmparam.h
index 3fb69aff51..c973fcf7d5 100644
--- a/bsd-user/arm/target_arch_vmparam.h
+++ b/bsd-user/arm/target_arch_vmparam.h
@@ -1,22 +1,10 @@
 /*
- *  arm VM parameters definitions
+ * arm VM parameters definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_VMPARAM_H
 #define TARGET_ARCH_VMPARAM_H
 
diff --git a/bsd-user/arm/target_syscall.h b/bsd-user/arm/target_syscall.h
index 5804a53541..deab3baebf 100644
--- a/bsd-user/arm/target_syscall.h
+++ b/bsd-user/arm/target_syscall.h
@@ -1,22 +1,10 @@
 /*
- *  arm cpu system call stubs
+ * arm cpu system call stubs
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef ARM_TARGET_SYSCALL_H
 #define ARM_TARGET_SYSCALL_H
 
diff --git a/bsd-user/bsd-file.h b/bsd-user/bsd-file.h
index 6fa2c30b4d..dca1518cb1 100644
--- a/bsd-user/bsd-file.h
+++ b/bsd-user/bsd-file.h
@@ -1,22 +1,10 @@
 /*
- *  file related system call shims and definitions
+ * file related system call shims and definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef BSD_FILE_H
 #define BSD_FILE_H
 
diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
index 2ab1334b70..8c6c4081f7 100644
--- a/bsd-user/bsd-mem.c
+++ b/bsd-user/bsd-mem.c
@@ -1,20 +1,9 @@
 /*
- *  memory management system conversion routines
+ * memory management system conversion routines
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 #include "qemu.h"
diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index a118e57260..8c0b0b6919 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -1,20 +1,9 @@
 /*
- *  memory management system call shims and definitions
+ * memory management system call shims and definitions
  *
- *  Copyright (c) 2013-15 Stacey D. Son
+ * Copyright (c) 2013-2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 /*
diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 8dcac9608d..7fb46046c7 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -1,20 +1,9 @@
 /*
- *  BSD process related system call helpers
+ * BSD process related system call helpers
  *
- *  Copyright (c) 2013-14 Stacey D. Son
+ * Copyright (c) 2013-2014 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 
diff --git a/bsd-user/bsd-proc.h b/bsd-user/bsd-proc.h
index 8b1c2deea3..b1d4446ff1 100644
--- a/bsd-user/bsd-proc.h
+++ b/bsd-user/bsd-proc.h
@@ -1,20 +1,9 @@
 /*
- *  process related system call shims and definitions
+ * process related system call shims and definitions
  *
- *  Copyright (c) 2013-2014 Stacey D. Son
+ * Copyright (c) 2013-2014 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #ifndef BSD_PROC_H_
diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index 71145764a4..d9979b2a8b 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -1,22 +1,10 @@
 /*
- *  miscellaneous FreeBSD system call shims
+ * miscellaneous FreeBSD system call shims
  *
- *  Copyright (c) 2013-14 Stacey D. Son
+ * Copyright (c) 2013-2014 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef OS_MISC_H
 #define OS_MISC_H
 
diff --git a/bsd-user/freebsd/os-proc.c b/bsd-user/freebsd/os-proc.c
index bf993f1b66..0309036178 100644
--- a/bsd-user/freebsd/os-proc.c
+++ b/bsd-user/freebsd/os-proc.c
@@ -1,20 +1,9 @@
 /*
- *  FreeBSD process related emulation code
+ * FreeBSD process related emulation code
  *
- *  Copyright (c) 2013-15 Stacey D. Son
+ * Copyright (c) 2013-2014 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 
diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
index cc53215138..72ccf23e17 100644
--- a/bsd-user/freebsd/os-proc.h
+++ b/bsd-user/freebsd/os-proc.h
@@ -1,22 +1,10 @@
 /*
- *  process related system call shims and definitions
+ * process related system call shims and definitions
  *
- *  Copyright (c) 2013-14 Stacey D. Son
+ * Copyright (c) 2013-2014 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef BSD_USER_FREEBSD_OS_PROC_H
 #define BSD_USER_FREEBSD_OS_PROC_H
 
diff --git a/bsd-user/freebsd/os-stat.c b/bsd-user/freebsd/os-stat.c
index f0f9e609c3..10870430fe 100644
--- a/bsd-user/freebsd/os-stat.c
+++ b/bsd-user/freebsd/os-stat.c
@@ -1,20 +1,9 @@
 /*
- *  FreeBSD stat related conversion routines
+ * FreeBSD stat related conversion routines
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
 
diff --git a/bsd-user/freebsd/os-stat.h b/bsd-user/freebsd/os-stat.h
index 3bdc66aa98..ea95aa6344 100644
--- a/bsd-user/freebsd/os-stat.h
+++ b/bsd-user/freebsd/os-stat.h
@@ -1,22 +1,10 @@
 /*
- *  stat related system call shims and definitions
+ * stat related system call shims and definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef BSD_USER_FREEBSD_OS_STAT_H
 #define BSD_USER_FREEBSD_OS_STAT_H
 
diff --git a/bsd-user/freebsd/os-strace.h b/bsd-user/freebsd/os-strace.h
index a222f093b5..ad48e99db1 100644
--- a/bsd-user/freebsd/os-strace.h
+++ b/bsd-user/freebsd/os-strace.h
@@ -1,25 +1,12 @@
 /*
- *  FreeBSD dependent strace print functions
+ * FreeBSD dependent strace print functions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #include "target_arch_sysarch.h"    /* architecture dependent functions */
 
-
 static inline void do_os_print_sysarch(const struct syscallname *name,
         abi_long arg1, abi_long arg2, abi_long arg3, abi_long arg4,
         abi_long arg5, abi_long arg6)
diff --git a/bsd-user/freebsd/target_os_elf.h b/bsd-user/freebsd/target_os_elf.h
index 01124979f7..c67e5a0f8e 100644
--- a/bsd-user/freebsd/target_os_elf.h
+++ b/bsd-user/freebsd/target_os_elf.h
@@ -1,22 +1,10 @@
 /*
- *  freebsd ELF definitions
+ * FreeBSD ELF definitions
  *
- *  Copyright (c) 2013-15 Stacey D. Son
+ * Copyright (c) 2013-2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_OS_ELF_H
 #define TARGET_OS_ELF_H
 
diff --git a/bsd-user/freebsd/target_os_siginfo.h b/bsd-user/freebsd/target_os_siginfo.h
index 6c282d8502..e7cf76b9bd 100644
--- a/bsd-user/freebsd/target_os_siginfo.h
+++ b/bsd-user/freebsd/target_os_siginfo.h
@@ -1,22 +1,10 @@
 /*
- *  FreeBSD siginfo related definitions
+ * FreeBSD siginfo related definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_OS_SIGINFO_H
 #define TARGET_OS_SIGINFO_H
 
diff --git a/bsd-user/freebsd/target_os_signal.h b/bsd-user/freebsd/target_os_signal.h
index 5030abb52b..c571b41693 100644
--- a/bsd-user/freebsd/target_os_signal.h
+++ b/bsd-user/freebsd/target_os_signal.h
@@ -1,3 +1,10 @@
+/*
+ * FreeBSD signal related symbols
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #ifndef TARGET_OS_SIGNAL_H
 #define TARGET_OS_SIGNAL_H
 
diff --git a/bsd-user/freebsd/target_os_stack.h b/bsd-user/freebsd/target_os_stack.h
index ac0ef22cd7..262f33d839 100644
--- a/bsd-user/freebsd/target_os_stack.h
+++ b/bsd-user/freebsd/target_os_stack.h
@@ -1,22 +1,10 @@
 /*
- *  FreeBSD setup_initial_stack() implementation.
+ * FreeBSD setup_initial_stack() implementation.
  *
- *  Copyright (c) 2013-14 Stacey D. Son
+ * Copyright (c) 2013-2014 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_OS_STACK_H
 #define TARGET_OS_STACK_H
 
diff --git a/bsd-user/freebsd/target_os_thread.h b/bsd-user/freebsd/target_os_thread.h
index 1b32cebd26..ff88679e40 100644
--- a/bsd-user/freebsd/target_os_thread.h
+++ b/bsd-user/freebsd/target_os_thread.h
@@ -1,22 +1,10 @@
 /*
- *  FreeBSD thread dependent code and definitions
+ * FreeBSD thread dependent code and definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_OS_THREAD_H
 #define TARGET_OS_THREAD_H
 
diff --git a/bsd-user/freebsd/target_os_user.h b/bsd-user/freebsd/target_os_user.h
index 1ca7b5ab17..9703b9a61a 100644
--- a/bsd-user/freebsd/target_os_user.h
+++ b/bsd-user/freebsd/target_os_user.h
@@ -1,22 +1,10 @@
 /*
- *  sys/user.h definitions
+ * sys/user.h definitions
  *
- *  Copyright (c) 2015 Stacey D. Son (sson at FreeBSD)
+ * Copyright (c) 2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_OS_USER_H
 #define TARGET_OS_USER_H
 
diff --git a/bsd-user/freebsd/target_os_vmparam.h b/bsd-user/freebsd/target_os_vmparam.h
index 8457dd3913..9feec5296d 100644
--- a/bsd-user/freebsd/target_os_vmparam.h
+++ b/bsd-user/freebsd/target_os_vmparam.h
@@ -1,22 +1,10 @@
 /*
- *  FreeBSD VM parameters definitions
+ * FreeBSD VM parameters definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_OS_VMPARAM_H
 #define TARGET_OS_VMPARAM_H
 
diff --git a/bsd-user/i386/signal.c b/bsd-user/i386/signal.c
index a3131047b8..742032090d 100644
--- a/bsd-user/i386/signal.c
+++ b/bsd-user/i386/signal.c
@@ -1,20 +1,9 @@
 /*
- *  i386 dependent signal definitions
+ * i386 dependent signal definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/bsd-user/i386/target_arch.h b/bsd-user/i386/target_arch.h
index 9595e60f09..74c8e7fb47 100644
--- a/bsd-user/i386/target_arch.h
+++ b/bsd-user/i386/target_arch.h
@@ -1,22 +1,10 @@
 /*
  * Intel x86 specific prototypes for bsd-user
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_H
 #define TARGET_ARCH_H
 
diff --git a/bsd-user/i386/target_arch_cpu.c b/bsd-user/i386/target_arch_cpu.c
index 2a3af2ddef..fa8ad4b385 100644
--- a/bsd-user/i386/target_arch_cpu.c
+++ b/bsd-user/i386/target_arch_cpu.c
@@ -1,20 +1,9 @@
 /*
- *  i386 cpu related code
+ * i386 cpu related code
  *
- * Copyright (c) 2013 Stacey Son <sson@FreeBSD.org>
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/bsd-user/i386/target_arch_cpu.h b/bsd-user/i386/target_arch_cpu.h
index f147d5b6f8..c6e8bfd8ca 100644
--- a/bsd-user/i386/target_arch_cpu.h
+++ b/bsd-user/i386/target_arch_cpu.h
@@ -1,21 +1,10 @@
 /*
- *  i386 cpu init and loop
+ * i386 cpu init and loop
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_CPU_H
 #define TARGET_ARCH_CPU_H
 
diff --git a/bsd-user/i386/target_arch_elf.h b/bsd-user/i386/target_arch_elf.h
index 4ac27b02e7..99cff66a22 100644
--- a/bsd-user/i386/target_arch_elf.h
+++ b/bsd-user/i386/target_arch_elf.h
@@ -1,22 +1,10 @@
 /*
- *  i386 ELF definitions
+ * i386 ELF definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
diff --git a/bsd-user/i386/target_arch_reg.h b/bsd-user/i386/target_arch_reg.h
index 8123109697..cebf2fd5cc 100644
--- a/bsd-user/i386/target_arch_reg.h
+++ b/bsd-user/i386/target_arch_reg.h
@@ -1,23 +1,10 @@
 /*
- *  FreeBSD i386 register structures
+ * FreeBSD i386 register structures
  *
- *  Copyright (c) 2015 Stacey Son
- *  All rights reserved.
+ * Copyright (c) 2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_REG_H
 #define TARGET_ARCH_REG_H
 
diff --git a/bsd-user/i386/target_arch_signal.h b/bsd-user/i386/target_arch_signal.h
index 2c14153ab6..070ba4357a 100644
--- a/bsd-user/i386/target_arch_signal.h
+++ b/bsd-user/i386/target_arch_signal.h
@@ -1,19 +1,9 @@
 /*
- *  i386 dependent signal definitions
+ * i386 dependent signal definitions
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #ifndef TARGET_ARCH_SIGNAL_H
 #define TARGET_ARCH_SIGNAL_H
diff --git a/bsd-user/i386/target_arch_sigtramp.h b/bsd-user/i386/target_arch_sigtramp.h
index ef94cc864f..ace243b6f5 100644
--- a/bsd-user/i386/target_arch_sigtramp.h
+++ b/bsd-user/i386/target_arch_sigtramp.h
@@ -1,22 +1,10 @@
 /*
  * Intel i386  sigcode for bsd-user
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SIGTRAMP_H
 #define TARGET_ARCH_SIGTRAMP_H
 
diff --git a/bsd-user/i386/target_arch_sysarch.h b/bsd-user/i386/target_arch_sysarch.h
index db8fee6380..7b128dfab1 100644
--- a/bsd-user/i386/target_arch_sysarch.h
+++ b/bsd-user/i386/target_arch_sysarch.h
@@ -1,22 +1,10 @@
 /*
- *  i386 sysarch system call emulation
+ * i386 sysarch system call emulation
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SYSARCH_H
 #define TARGET_ARCH_SYSARCH_H
 
diff --git a/bsd-user/i386/target_arch_thread.h b/bsd-user/i386/target_arch_thread.h
index cee2148d94..8ef4f6b648 100644
--- a/bsd-user/i386/target_arch_thread.h
+++ b/bsd-user/i386/target_arch_thread.h
@@ -1,22 +1,10 @@
 /*
- *  i386 thread support
+ * i386 thread support
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_THREAD_H
 #define TARGET_ARCH_THREAD_H
 
diff --git a/bsd-user/i386/target_arch_vmparam.h b/bsd-user/i386/target_arch_vmparam.h
index 79db420e59..cdf6ab0a49 100644
--- a/bsd-user/i386/target_arch_vmparam.h
+++ b/bsd-user/i386/target_arch_vmparam.h
@@ -1,22 +1,10 @@
 /*
- *  i386 VM parameters definitions
+ * i386 VM parameters definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_VMPARAM_H
 #define TARGET_ARCH_VMPARAM_H
 
diff --git a/bsd-user/i386/target_syscall.h b/bsd-user/i386/target_syscall.h
index 940c687a52..a52851f635 100644
--- a/bsd-user/i386/target_syscall.h
+++ b/bsd-user/i386/target_syscall.h
@@ -1,19 +1,9 @@
 /*
- *  i386 system call definitions
+ * i386 system call definitions
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #ifndef TARGET_SYSCALL_H
 #define TARGET_SYSCALL_H
diff --git a/bsd-user/qemu-bsd.h b/bsd-user/qemu-bsd.h
index b98d1d76b2..756425d18e 100644
--- a/bsd-user/qemu-bsd.h
+++ b/bsd-user/qemu-bsd.h
@@ -1,22 +1,10 @@
 /*
- *  BSD conversion extern declarations
+ * BSD conversion extern declarations
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef QEMU_BSD_H
 #define QEMU_BSD_H
 
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4dbd90c2f1..90ec3c048d 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -1,22 +1,10 @@
 /*
- *  System call related declarations
+ * System call related declarations
  *
- *  Copyright (c) 2013-15 Stacey D. Son (sson at FreeBSD)
+ * Copyright (c) 2013-2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef SYSCALL_DEFS_H
 #define SYSCALL_DEFS_H
 
diff --git a/bsd-user/x86_64/signal.c b/bsd-user/x86_64/signal.c
index 46cb865180..823d7217ad 100644
--- a/bsd-user/x86_64/signal.c
+++ b/bsd-user/x86_64/signal.c
@@ -1,19 +1,9 @@
 /*
- *  x86_64 signal definitions
+ * x86_64 signal definitions
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/bsd-user/x86_64/target_arch.h b/bsd-user/x86_64/target_arch.h
index 09bd974889..177e6b442a 100644
--- a/bsd-user/x86_64/target_arch.h
+++ b/bsd-user/x86_64/target_arch.h
@@ -1,22 +1,10 @@
 /*
  * Intel x86_64 specific prototypes for bsd-user
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_H
 #define TARGET_ARCH_H
 
diff --git a/bsd-user/x86_64/target_arch_cpu.c b/bsd-user/x86_64/target_arch_cpu.c
index 1d32f18907..aeeb1235c9 100644
--- a/bsd-user/x86_64/target_arch_cpu.c
+++ b/bsd-user/x86_64/target_arch_cpu.c
@@ -1,20 +1,9 @@
 /*
- *  x86_64 cpu related code
+ * x86_64 cpu related code
  *
- * Copyright (c) 2013 Stacey Son <sson@FreeBSD.org>
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
 #include "qemu/osdep.h"
diff --git a/bsd-user/x86_64/target_arch_cpu.h b/bsd-user/x86_64/target_arch_cpu.h
index 1fa71d87f1..f12a8ab49e 100644
--- a/bsd-user/x86_64/target_arch_cpu.h
+++ b/bsd-user/x86_64/target_arch_cpu.h
@@ -1,21 +1,10 @@
 /*
- *  x86_64 cpu init and loop
+ * x86_64 cpu init and loop
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_CPU_H
 #define TARGET_ARCH_CPU_H
 
diff --git a/bsd-user/x86_64/target_arch_elf.h b/bsd-user/x86_64/target_arch_elf.h
index e51c2faf08..020533904e 100644
--- a/bsd-user/x86_64/target_arch_elf.h
+++ b/bsd-user/x86_64/target_arch_elf.h
@@ -1,22 +1,10 @@
 /*
- *  x86_64 ELF definitions
+ * x86_64 ELF definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
diff --git a/bsd-user/x86_64/target_arch_reg.h b/bsd-user/x86_64/target_arch_reg.h
index 7a766de918..c0c766ac1a 100644
--- a/bsd-user/x86_64/target_arch_reg.h
+++ b/bsd-user/x86_64/target_arch_reg.h
@@ -1,23 +1,10 @@
 /*
- *  FreeBSD amd64 register structures
+ * FreeBSD amd64 register structures
  *
- *  Copyright (c) 2015 Stacey Son
- *  All rights reserved.
+ * Copyright (c) 2015 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_REG_H
 #define TARGET_ARCH_REG_H
 
diff --git a/bsd-user/x86_64/target_arch_signal.h b/bsd-user/x86_64/target_arch_signal.h
index f833ee66ce..2b63048f8b 100644
--- a/bsd-user/x86_64/target_arch_signal.h
+++ b/bsd-user/x86_64/target_arch_signal.h
@@ -1,21 +1,10 @@
 /*
- *  x86_64 signal definitions
+ * x86_64 signal definitions
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SIGNAL_H
 #define TARGET_ARCH_SIGNAL_H
 
diff --git a/bsd-user/x86_64/target_arch_sigtramp.h b/bsd-user/x86_64/target_arch_sigtramp.h
index 01da614098..cab22fb7e8 100644
--- a/bsd-user/x86_64/target_arch_sigtramp.h
+++ b/bsd-user/x86_64/target_arch_sigtramp.h
@@ -1,29 +1,16 @@
 /*
  * Intel x86_64  sigcode for bsd-user
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SIGTRAMP_H
 #define TARGET_ARCH_SIGTRAMP_H
 
 static inline abi_long setup_sigtramp(abi_ulong offset, unsigned sigf_uc,
         unsigned sys_sigreturn)
 {
-
     return 0;
 }
 #endif /* TARGET_ARCH_SIGTRAMP_H */
diff --git a/bsd-user/x86_64/target_arch_sysarch.h b/bsd-user/x86_64/target_arch_sysarch.h
index 152cb8bcb8..3a6f74161f 100644
--- a/bsd-user/x86_64/target_arch_sysarch.h
+++ b/bsd-user/x86_64/target_arch_sysarch.h
@@ -1,21 +1,10 @@
 /*
- *  x86_64 sysarch() syscall emulation
+ * x86_64 sysarch() syscall emulation
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_SYSARCH_H
 #define TARGET_ARCH_SYSARCH_H
 
diff --git a/bsd-user/x86_64/target_arch_thread.h b/bsd-user/x86_64/target_arch_thread.h
index 7739bb2154..176c347037 100644
--- a/bsd-user/x86_64/target_arch_thread.h
+++ b/bsd-user/x86_64/target_arch_thread.h
@@ -1,22 +1,10 @@
 /*
- *  x86_64 thread support
+ * x86_64 thread support
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_THREAD_H
 #define TARGET_ARCH_THREAD_H
 
diff --git a/bsd-user/x86_64/target_arch_vmparam.h b/bsd-user/x86_64/target_arch_vmparam.h
index 6797623a6b..8919c5e6e5 100644
--- a/bsd-user/x86_64/target_arch_vmparam.h
+++ b/bsd-user/x86_64/target_arch_vmparam.h
@@ -1,22 +1,10 @@
 /*
- *  Intel x86_64 VM parameters definitions
+ * Intel x86_64 VM parameters definitions
  *
- *  Copyright (c) 2013 Stacey D. Son
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-
 #ifndef TARGET_ARCH_VMPARAM_H
 #define TARGET_ARCH_VMPARAM_H
 
diff --git a/bsd-user/x86_64/target_syscall.h b/bsd-user/x86_64/target_syscall.h
index a8e6274b76..5adced9bde 100644
--- a/bsd-user/x86_64/target_syscall.h
+++ b/bsd-user/x86_64/target_syscall.h
@@ -1,19 +1,9 @@
 /*
- *  x86_64 system call definitions
+ * x86_64 system call definitions
  *
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #ifndef TARGET_SYSCALL_H
 #define TARGET_SYSCALL_H
-- 
2.52.0


