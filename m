Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B24CD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoVl-0007Vn-IK; Wed, 06 May 2026 22:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVU-0007Sj-5s
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:32 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVK-0000V4-Ew
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:23 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so316242a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121021; x=1778725821;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqvWmLbjmlBIF1ObHpc6uVNCAxesbDWMi6ixpyg9t3o=;
 b=IW+o/yU+fzRXu4CuACwaY5UFisYmnVTfVoDtqRF4JV2CGSIi8FxGirmRqny/M0+0IW
 Miz98s/Rjlcct+FL7Cj846aqsvTl1/x6OkGnaDDg//dybnbNkKxKM9GwCv6+RJGcEYxn
 400fXZvBOoX1xIXyNFg2jUArn2OPEbI3MCS+XNa+5Y/lNR9w6N36Be4I/zPeCKDZ9x+s
 TZpMSSagsfIdgqMtw9MljntT3GvEj1R+PitoERyb9kl2vqsbLzu73GR+xTxRuYngeWqA
 2frAqa24a9rL9ff1mS+ZLRuF8g3cvW+bZZBHtAySodJxf7+0GehaFeD7wvu5iRvqrihw
 p+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121021; x=1778725821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JqvWmLbjmlBIF1ObHpc6uVNCAxesbDWMi6ixpyg9t3o=;
 b=bp+X0vQhLYu01UI9PXWCx0ZUxJVJSM4G1CZkLIjukzh3KcWYobLojPElS9DqBJc64Z
 BWkSB6IjWScl82vPObQBwbclONtMhftbMixFiDJWSAE7ufvkHpR0d/ZZmwoWyqKnDt1D
 fmaUbJc4+J1knJEivRgvtNfQVn4DTdsS/QUFh6ZSNyJW7TSGwpgNaNeEPc9C3E2BawpB
 oZmoDsQxUnvu3WVFY0VgY1ytKqneoW78PCp709jn+oFeyiufq22JANd1CAlq2R8hrEuO
 c2NrkhRW4v3ggJowGlkmeDjzv/ndyv4eqKnzzoip3YghTvcb7G2zKb+4iWbTJ3lok6Xs
 wm6A==
X-Gm-Message-State: AOJu0YxzKCztHSh4h2Rnqc/HKUhEmBk5EqFmpsS/XXlbJGT5UrT1S1I3
 mPQ6uL2POH1LIN3SmUH+xSIrwZqT7aYhIgy7ErVRn05YOEdPekY3Z1CCmCEznPNfW2a57VfWzIy
 445zaMPM=
X-Gm-Gg: AeBDietA/STZAOwRBFJ5z9QgzCoTEaYt2h1bn1ZKnME5eILMyRJ8O/AQAD3Tgeeoiq6
 FdHbc0vy9RASyGfW0uEFt0HNYKjXlV9nVblmtD8GdReLNWRmnZBDn2gmESfhxB2T41p58WmvSRq
 vgFEuZ+Qhu2p16w3sLxm2HbrjVo1c7F/1sePA4FsdOtPpcau4raYlv6MRl55uzOzR3RXvKt2x6f
 TaAzZZGHCmYKL5P7XijHZKyM77K8gxn8kDfD5sBHW8VIAQZ1D6kkqpoYC4a8XlWO9vqRIR3flxc
 o6SRpl5b3AvNrd8bS4w5htukMGxCqtXtVCVW/pa9dQH4yoHv7TAONciY1gSBTE6fIaWtfxgza85
 dFyA8nP8JPuH3ThPgiq9g2UHH2lZVdMLgS2uvwtNACO4gic1+MbfFf763cE3vQnK5l2HXww8pG9
 ZMGCNedd75SOBN2H6m9vsagJnWkNVQVCg=
X-Received: by 2002:a05:6830:3110:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7e1deec720emr3828690a34.6.1778121020959; 
 Wed, 06 May 2026 19:30:20 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:20 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 02/25] bsd-user: Add syscall header generator for FreeBSD
Date: Wed,  6 May 2026 20:28:04 -0600
Message-ID: <20260507022827.44499-3-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

Generate the syscall numbers from the installed header that has them.
Ideally, we'd use FreeBSD's lua infra for this, but that requires that
we have those files installed, and they aren't quite the same across
supported versions yet, so use this simple, but effective hack. Add to
meson build, but unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build           | 10 ++++++++--
 bsd-user/freebsd/scripts/syscallhdr.sh |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 bsd-user/freebsd/scripts/syscallhdr.sh

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 8fd6c7cfb8..38f2debf7e 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,6 +1,12 @@
+bsd_syscall_nr = custom_target('bsd-syscall-h',
+    output: '@BASENAME@_nr.h',
+    input: ['/usr/include/sys/syscall.h'],
+    command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
+
 bsd_user_ss.add(files(
   'os-stat.c',
   'os-proc.c',
   'os-sys.c',
-  'os-syscall.c',
-))
+  'os-syscall.c'),
+  bsd_syscall_nr
+)
diff --git a/bsd-user/freebsd/scripts/syscallhdr.sh b/bsd-user/freebsd/scripts/syscallhdr.sh
new file mode 100644
index 0000000000..fa38500775
--- /dev/null
+++ b/bsd-user/freebsd/scripts/syscallhdr.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+# Copyright (c) 2026 Warner Losh <imp@bsdimp.com>
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+in="$1"
+out="$2"
+bsd="$3"
+
+awk -v bsd="$3" '{sub("SYS_", "TARGET_" bsd "_NR_", $0); print;}' < $in > $out
-- 
2.52.0


