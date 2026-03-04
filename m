Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1871EF9001
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxojz-000499-Ja; Wed, 04 Mar 2026 11:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vxojr-00046D-K5
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:06:20 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1vxojm-0000oJ-8s
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:06:19 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46391e91e16so4925225b6e.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1772640372; x=1773245172;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3ucWcI7Gt05PCFCafzbKQ90QSy6aVm+Boqs3fkA8III=;
 b=kFwyoAkL9oRnsxc9Qgh5F3g+jp92YscFCVyWccdm1o8J9RaElGROKMt9BOUTx/tqyT
 xmQlNetsF0hATlvZxQejYJDRwLc7Wv9t8Z9WJwcgcQaKR+rJxyxE7WiQYOVTfBej0mOZ
 ox2S6DaELI2wPrcFGE0/2HpGO/k/4cfw+Z436p0JPYZJ3jX1HLKM5p5d3CG7zcy65bss
 dzsr+Hux06ik8f8bn07Y2pmWQu6FfBMncLz6INfXk/twX1ywuY/FFBKfMHtsn/FJgY8U
 IlM16Lj4muk/eyUW/bwXN4WWDYfVgTsG4PQXyWOSlUTCPXzJy3NJ/crd5WlOugoaTzdy
 1Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772640372; x=1773245172;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ucWcI7Gt05PCFCafzbKQ90QSy6aVm+Boqs3fkA8III=;
 b=bh0S1ahp5ikEqmnLuUK8tTe+0dclHi4vrqVKKJNCzcaxFTpis5YvjDgktOs3Aw4sDw
 HIv8hOqL7L2MeGM0tXUEbArxNMQvWymGxIpFbutMlELBc83tw/LQRdfYI/CkrLxYuxMf
 gBmQJobKGv2R6W8w1a3KuH4ngUzyvn4VGSFi5QN+mcH+e7+MkZSiztSd7h1HVwM37a6l
 Lo4Xle7LWmEB8GJlmQzLbQtU4rG2kihYRWITzij2RNtmQ+ombkrSuLADS7gD7Lz0Xx8G
 v3qzcx3rqsjWJvplb+z5Cjz1yUXE1x7cAFntGvPYgn1A82ICLCXoIK31/oRcDiDYxQ0H
 6Jnw==
X-Gm-Message-State: AOJu0YxS1dEA8QlRE7TTykDMhVh51yhxVcr7FCw76OPxPuYNNQRFhe+J
 k7Y0PvOsCOwm+1E3aaLx0o3+ZcuSLBE7OT49n1d9NQPyiYKpsmdDE7/NWSbdyrMDTpA=
X-Gm-Gg: ATEYQzyIRax1HdorBu5J3zaRulUZ/CsoT0997L0wfqwssfacJv9ej3Q1PAKvjZyDUbu
 9pswczG2vmfPTekMujENLkMKWI+A4uOKa04BSLD6BQ0HOa5lMfHtVAhw47t24eKCGVCJQzmeBMY
 o2+4Kbj+1FJl4XINBqBvo7brYZifWwBcCqHSw+9P5JHOTHP20vWlioRZUZeSVD4/pWhi8HsctkD
 jF0OAAHXE+GRVhTtK3bQ3eJTsLA7JPpcqWnonWJ1g6oLvHT7RnlEsw8YkJAFm1s+CZBjWJMkACN
 iUVK9dkiKTDQ3Pcxo7GqIb9eB9/TGL3TayGnnTj91QMOWwU9avALQzyXJ6UUlNQSMOQKp/K6JKQ
 /0NMCaIcbkVCh9pZ1DsPChekKcw+zLxMEyF3sUPo4ffNvpbZEEUedPk/iQBo8KU340sw6ZLiG/W
 88BKCRcfMBMQ==
X-Received: by 2002:a05:6820:1c91:b0:67a:1eaf:a912 with SMTP id
 006d021491bc7-67b0ffa67f8mr1501064eaf.2.1772640370628; 
 Wed, 04 Mar 2026 08:06:10 -0800 (PST)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2bec8a1sm14438211eaf.6.2026.03.04.08.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:06:09 -0800 (PST)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 04 Mar 2026 09:05:33 -0700
Subject: [PATCH v2] bsd-user: Switch to SPDX-License-Expression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-bsd-user-copyright-v2-1-173525ffa614@bsdimp.com>
X-B4-Tracking: v=1; b=H4sIAExYqGkC/32NTQ6DIBSEr2Leuq/hR9R05T0aFxZQ3kIxYEmN4
 e6lHqDLbzLfzAnRBrIRHtUJwSaK5NcC4laBduM6WyRTGAQTDZNM4CsafBcJtd+OQLPbUY51Y4R
 kLVcMirgFO9HnGn0OhR3F3Yfj+kj8l/6dSxw5TkyprjW8M7XtS4mW7a79AkPO+QvLC9WQtQAAA
 A==
X-Change-ID: 20260302-bsd-user-copyright-3a46d2307150
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>, 
 Sean Bruno <sbruno@FreeBSD.org>, 
 =?utf-8?q?Mika=C3=ABl_Urankar?= <mikael.urankar@gmail.com>, 
 Guy Yur <guyyur@gmail.com>, Alexander Kabaev <kan@FreeBSD.org>, 
 Michal Meloun <mmel@FreeBSD.org>, Ed Schouten <ed@nuxi.nl>, 
 Kyle Evans <kevans@FreeBSD.org>, Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=89546; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=J/P5+Rgi4b15xMDNtmltcINdFxTUamo1HTysqBDXbfw=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBpqFhV3nm/ZdafbmNnHhmt4cv9T5YIGyyE5fom7
 rUw4arcobiJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaahYVQAKCRBsHNEofbAR
 AGGXEACmVYRJJxeqlJ9umvKy5j2x0L7Te4xO11gKhwxOgY3cAibqwbrm4rwQP04thBBvHGal/Ok
 yFkMoRgFiNB/nf0ee+IB5MbwUyVrUyH3sM6XjZRhvP4ZlxOauBfxMmr5CRD9gl6hqv7g+uh0Vhn
 xW1+WGRbTV3wv0mo9P7rcuJYAJsAj7if5vYYjwKB9LWPqVpgGiPYFhXXBXpB9Ur2/86HffzeJ90
 g9Ql2HgS3eRCfjUG4m+RAwZaIUuTs0KroIAJusA5JSM+ptvgGZrlGkNDgz0SEDFmngP8wV+xUAT
 SjRE0OzAj3iYLQTfn7YEi1oKz/8i5mrDPXpJFp2R+7mXEuyJj9vXR6Z0HflNA5Q4ylQ/YsdzJKI
 v5/+1l5M+wLWXufcf8fMeHjtqhhVl+PeKAwNixCyVD4FFgwFCTrq7ca38ezmMHGZfkG6K39DWyo
 wMvh+Xvfs2ivqgSqV5M+ClzsgdP9hUGhqUIOyvBstn5PIn12e6KdlK+wzSc7O+zOFrGZL6F6ql+
 31mJ5dOS6UbGIUjWRYOEn7X4HSrxIPYwOqQE1vR+kUFgZo7d3OHBMdn1xwVDRs81gHMPXF18ZzX
 adsr2ZJds5yotqcw/11wDsn4Z99+pFmb+U3EYttOPOfzot5lpKvoaul+GEtwSlI7iC9RwIYgz2x
 l+V/RttRdV8wgSg==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22c.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
Adjust the copyright markings for the bsd-user project to the extent
that's easy and prudent. This removes the gpl boilerplate and replaces
it with a SPDX line, per QEMU standard proactice. It uses Stacey D Son
everytwhere rather than variations on that name. It uses full date
ranges as appropriate.

All that's changing is the markings. I have Stacey's explicit permission
to do this, as well as people cc'd. The history of bsd-user, first
copied from linux-user and then passing through several branches in
several repos as maintainers shifted make it hard to get a complete list
of authors. But to the best of my ability to determine, this list
represents the overwhelming majority of people who may have a copyright
interest in the files not documented with a Copyright line.

This does not chanage any intellectual property rights people hold in
these files. Nor does it change the licensing of these files in any
way. It's easy to revert relevant parts should an unknown-to-me author
appear and desire it. I believe it's legally defensible and would not
affect future legal matters, especailly given this explicit statement of
intent.

I'm doing this proactively so that all the files, with only few
exceptions, can be marked in a similar manner in bsd-user's blitz repo.
This will help in upstreaming as it completely takes the issue off the
table, likely saving me hours of future work in reply to why something
is marked the old way or realizing in the upstreaming process I have to
make the change in bsd-user's blitz branch first (or worse, during the
review process). Each individual change might not be a big deal, but the
cumulative effect can grow large.
---
Changes in v2:
- document permissions better
- drop a couple files that had others claiming copyright.
- Link to v1: https://lore.kernel.org/qemu-devel/20260302-bsd-user-copyright-v1-1-f05587d18d4e@bsdimp.com
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
 bsd-user/elfload.c                      | 17 +++--------------
 bsd-user/freebsd/os-misc.h              | 18 +++---------------
 bsd-user/freebsd/os-proc.c              | 17 +++--------------
 bsd-user/freebsd/os-proc.h              | 18 +++---------------
 bsd-user/freebsd/os-stat.c              | 17 +++--------------
 bsd-user/freebsd/os-stat.h              | 18 +++---------------
 bsd-user/freebsd/os-strace.h            | 19 +++----------------
 bsd-user/freebsd/target_os_elf.h        | 18 +++---------------
 bsd-user/freebsd/target_os_siginfo.h    | 18 +++---------------
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
 bsd-user/qemu.h                         | 15 +++------------
 bsd-user/strace.c                       | 16 +++-------------
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
 70 files changed, 194 insertions(+), 1010 deletions(-)

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
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 3bca0cc9ed..ddac272424 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -1,20 +1,9 @@
 /*
- *  ELF loading code
+ * ELF loading code
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
index 56affcd31d..64d4fbe3a9 100644
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
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 93388e7c34..c4ff1fb0eb 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -1,18 +1,9 @@
 /*
- *  qemu bsd user mode definition
+ * qemu bsd user mode definition
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
+ * Copyright (c) 2013 Stacey D. Son
  *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #ifndef QEMU_H
 #define QEMU_H
diff --git a/bsd-user/strace.c b/bsd-user/strace.c
index 6dc01d3be7..a015bfddba 100644
--- a/bsd-user/strace.c
+++ b/bsd-user/strace.c
@@ -1,19 +1,9 @@
 /*
- *  System call tracing and debugging
+ * System call tracing and debugging
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
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index cc4b484f3a..a2ded2fac1 100644
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

---
base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
change-id: 20260302-bsd-user-copyright-3a46d2307150

Best regards,
-- 
Warner Losh <imp@bsdimp.com>


