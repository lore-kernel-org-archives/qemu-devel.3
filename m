Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A3CFF887E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI66w-00018p-QE; Wed, 29 Apr 2026 10:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66o-00016d-G6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:50 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wI66j-00039D-6A
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:41:47 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d55b97f358so8326095a34.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777473704; x=1778078504;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e8KIdnTwYtNFVsEx8h9MdN25QSua/BCoHhRi0Q+Ks7k=;
 b=TRVk41fzuCnm4WmxC4ziX0XYUfFcnur4P771qg0l+cFqTQZRZWpi0CmHA08Gt/7B9a
 LIerCNxcdxrZp4rbBgDfDT+V2f88XX+ZqyXsGGmDvp5gtQMN0iE4nb60ypeDbDCuxXrd
 381YEUQzVzgHNCe7uG/JA9bX4o7Md7iUraBs5vdAyO3bcgitO9yONb5xXvDClmgZpAq0
 1IEWS8BUYfW4WYQrk9rAUiIaB71WgQnLs0QuQtVbs5/ZRQJsPwWN4eDucsxPk0AlVupY
 azglq1AAmuQcluEcKFetzse7lVvZJeRabRM5Fqav+mEzMsEE26bJF9C70fItW3L5J7df
 3z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473704; x=1778078504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e8KIdnTwYtNFVsEx8h9MdN25QSua/BCoHhRi0Q+Ks7k=;
 b=DmcV0j8mqd+T0MCoN4Tl0Up7taWBNpwFbU4xLdWL2HdxZEUUl8HuPIfbojEJePQUjX
 LPrpdTFI4YEtoX8hMIMDwOjnXwlQyyGwuQtW/iEczxAWGkss63ZavHp5TZqv6qbxMXE6
 oUaNIfJ3HjrX1oqsowDGQRUTwEZDOs2DARpBCi66sIvu8fMsbwzUYaqptcsmylBvdsQa
 LpiHzUwliFQIC/Ct4tH52b1imiUJzWIKnslc1AzTIdISdIU1ufao7z1maSENAiXRqIKv
 1hMFK1dQGCSDgE5QS/eY82SUkle8kWnFKXXFtF1E2EZt52kBElqkUh0UBFlmXru0z2+l
 3raQ==
X-Gm-Message-State: AOJu0Yxjj/mBBApbXFPsZWO+BL4MxYoKCifO2ivydAt7KJ1Mb2hzr8uz
 CP16A0B7OsPmVCRQiDN+vq7Jb9QU2+Saazyl2Kdbr1kUYKZV0MCPs7HxCmuNPKULH8E=
X-Gm-Gg: AeBDietv4AnSGRbVeaa36bVDt/+k9ptxr9TQwZhyAtcWXF5ncVpLKRQpsK+QjlUZyXH
 5d7uHfJnYk0yGwuAAjrE5QKRzSZfbD0zaIDR4HHgZJ3NDTgQU72EdDYwpIvRzVKtrvEYvFuEu5L
 8+T19o5sjtQn4+4D8idRGF3BQOqC9xX8aLjmH7U9zqHoV6Nuyq/h+joRm7mSAbqXI3HsgZjVjOQ
 BWkwATP3zWaeKiP+zNoJmOy9Bq+DRCu7U/JIgHZVpmAPUeODNLhKtB3p3H/h+Dd84stfFk2MFNJ
 unaq9n5yjblOS4MxiH6wG/8VAt5DebYMXmKbrW0gMdppkuMW4qfaWcATEU+ezbxnKtpae2i39hQ
 RXBpgufEhZA6J3t2wm28UD3XMCSlUG0LPlOSHOXNe2c6hQ0InJx1SG031lfgcAmtbcRL0YZmpBO
 TJUWPGcxnQlDGX7zmsOPGVY7MbmCyVHdE=
X-Received: by 2002:a05:6830:8294:b0:7dc:c338:d23d with SMTP id
 46e09a7af769-7dea6766a2cmr2603125a34.14.1777473703755; 
 Wed, 29 Apr 2026 07:41:43 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab9d6067sm1553377a34.22.2026.04.29.07.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:41:42 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 29 Apr 2026 08:38:51 -0600
Subject: [PATCH v2 1/5] bsd-user: Add syscall header generator for FreeBSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-syscall-nr-v2-1-67a8d09dc13e@bsdimp.com>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
In-Reply-To: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=3XoBJXbOdvqqw9q6JlzdV6sPkMXP3U/powv+ddwUj+k=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp8hhKNoBAyvy++wvYRehUnn8ur4R7/WkJlZC1+
 JHD6VjKzeSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafIYSgAKCRBsHNEofbAR
 AMdzD/9A0rkmaO4am0rO8vPue1rCKO7o9YeOVAklg8YKeHvxx7d9+VkWHzolRtsQqv1gH/OeKhP
 3HCdOVlHkSYw/WeVp7mgWkVyXPqlqYmnwV12MauMZyxU03+vq3gWJ0f9ZB5C14cd1SwuU1U86FC
 6MjumhsVQeum5Fu//0AbBBQPJ/l4xCVN/EWqYwzrsR5eAFRzE6TNDMK6DW80ySjdJM0XuWCoTN6
 p8OwMPQdHL+DgHR35VvB+U8A/+Iv92LIzX0Y2ZO6sgI7H2aK6Q9UVODOphVZKU0QXSVBr/nJpca
 KZOOgqDEuIElvZpRY2yUs251FVqQ99T6Bd1x3XtuYm8rz/V3F3AhXcSU+H692ZjNQRKc9MfXj9/
 ugdCrF95YRJC5J9Ej2vX91ttbxMw3/AABpW+ILLrHoY1AYkG6f+jhdpZ21iMvsP0LUZEx2Qim0W
 2OPtY8BKrZeV8qiT3/+vU7aoQxXA27YFd6aWhs7HIa+OjJJzE4tM0Tkt87GZaVLflhDD+fwSGfa
 EB87wNNW0VWx8ZGEuTvt9MPgp4KehxWAmVAEgxiFWNwX7qnnaDWpINiWXBQtpLWLssjyjREYRHJ
 vaexJpIFUCJoc0ie6LhHpnh1nRs03skGaI9ydyJs8us7c/DPgV49PHpr18nOsy0Jm9bgaIXA/81
 6JjzzW3AvXe5DFA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build           | 11 ++++++++++-
 bsd-user/freebsd/scripts/syscallhdr.sh |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index 8fd6c7cfb8..fd55d84d3b 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,6 +1,15 @@
+bsd_syscall_nr = custom_target('bsd-syscall-h',
+    output: '@BASENAME@_nr.h',
+    input: ['/usr/include/sys/syscall.h'],
+    command: [sh, meson.current_source_dir() / 'scripts/syscallhdr.sh', '@INPUT@', '@OUTPUT@', 'FREEBSD'])
+
 bsd_user_ss.add(files(
   'os-stat.c',
   'os-proc.c',
   'os-sys.c',
   'os-syscall.c',
-))
+  'os-thread.c',
+  'os-time.c',
+  'trace.c'),
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


