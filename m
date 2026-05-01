Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA8F4CD13DA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIeFt-0004CF-Q0; Thu, 30 Apr 2026 23:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFs-0004Bb-Lo
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:28 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFr-0008U2-5E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:28 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dea1272943so922372a34.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604965; x=1778209765;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zXWcqieCQQGOx6uu0Rw2ijLJDJTmXXLiFYw3UPpcYgE=;
 b=xk/XkYek4qUa4Xd2E5ztU1G0tuwWXSBIRuP0GsN+y8elVOQPQkgCeMK/JVDWuriAmC
 +xKUTjZwYzxBy80vuf5qnpU6lO1kv5R+Qd+fRh38cEGruZWvKAq4p80jK+mdLEWCfPhL
 9lXevVJg8szjVLhgwUao5OU3YAzDfqznhgbolhZfzwqKZSPLSOGyANIxjvtniOC1TVeT
 FefqGAysXH5GY5C0L2pMis8klX7G9IYd3ewmcBSl59tpLyVY4gxIzMvVQujfcF54X7Vk
 w0kdcCEjarhIBT/74y2hOyMrwjlq3JmQ1tbDj3GQ0m78E7MwbRDOFrAZWD/+2PSC95Ug
 WnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604965; x=1778209765;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zXWcqieCQQGOx6uu0Rw2ijLJDJTmXXLiFYw3UPpcYgE=;
 b=TvLAWvFgzskRASBEiZrPFHymTJHoPXcQaAf24LJlRRnsxtDs//KCX+h4iYoVqdDrOJ
 JpWfuufwB6L/YhfkxHtNkx/6iEA/embI1x40epHlbw06mzrA5onDlR2Z81ac4rxJM/g8
 wG3yaPIMLIFbJEaD59rSJRuRgy4F9/NvdvVa3BgxVQh7d5XQ5EIsWG6Z4uhil0jO5iC+
 RrB8nz23RmIjo33qiY9q/rocZcwqomESpoFRfdHyLWn+WdXp/dQs1cDR5QT2ZgmtXCgr
 I0MHrZsz6X7aIF+SI/yXmb9T+t1PSBtjAFYXKYK0MoHR6WqrI5bObtg46xsKEAbuffsG
 ztkQ==
X-Gm-Message-State: AOJu0Yza3vZy6wbm5P6iMr/grdRTqhGzg3wxiBKvP3tYmceY/7Cv4JVK
 h5dBae6M6Aj7AiXqzcJ/uRCLzaTXnHpPZEfJoZZUWmcaGqmadQcnGN/rfjAzATgT36A=
X-Gm-Gg: AeBDieujqRPpGDC25mVUpG5uEO/TRIi2oEp5mp+9MIGYQsMnZgK4eatr9mKFU+OF48q
 siVSI7pBvjfPmRtbAA4kZRMaSoCyaXfXeX7POQvHfknLl6eiFGyBLm3s3R675bzewU5+RnNCuH+
 R/x7q9VT6lLq69aZfaSZOOC/oyclEanjRLYKhGdW4SJcne2kVLaJjgWbo4tiwNUEI/wkvCDZte3
 5PL7peqgQsqu69uBZbgkGOZsiAQeu0/yxbBm+AronZMfyHrfg4/L00shKt2o54YEj/h6UYGbsyd
 GB8wKRqkYNmxm6I7dzEDGoofVNEhAGzR2DI8NpxYfcq9C5cTnpefWgP4kn967zcgt8TY3wbvRJB
 6vaJQaHygz4AZGc0OLQiKP89TYJ9jFFRCmHHFDeT8MIVRB78QrZaeNb27t/RXWFXZPIIWx/CSSh
 nU/4LSkjZ2UTGDhzYc4GU1
X-Received: by 2002:a05:6830:640a:b0:7de:8ba8:ded with SMTP id
 46e09a7af769-7deba0d7ad9mr3868569a34.11.1777604965561; 
 Thu, 30 Apr 2026 20:09:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca278d0bsm1238476a34.0.2026.04.30.20.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:09:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 21:07:36 -0600
Subject: [PATCH v4 1/4] bsd-user: Add syscall header generator for FreeBSD
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-syscall-nr-v4-1-80f512079a16@bsdimp.com>
References: <20260430-syscall-nr-v4-0-80f512079a16@bsdimp.com>
In-Reply-To: <20260430-syscall-nr-v4-0-80f512079a16@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=xEPjNFAagt+hU6d3LgpAiHD/UMD+gdHHXHPFBAUagE4=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BkER8ir23qUf5DXT6hZSfl0kgOTJZjqzvmaM
 C1qD/TUrKeJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQZBAAKCRBsHNEofbAR
 AJ4hEADUaeEWWVcPsPCyl2k5PAMN0zfUCnQ3OiCp3114BQKFvuMJkelNHLEoEgRbmgPYHrFBIta
 1jIocXhS5kHLUA2KhrdSUkI9kETZzh+BoZj02JBgDXY5unxxEsSVrxUpZg0tQCwIuYdo1dFxdNT
 kZOcRwjKKBxqeJj1ggFp5GJiY53EzhDaTwQ3oBmBaYNtFiFiT1YlUf0FTZpXVGflyqtj4Gg5B+R
 IGvJegTMgkwsjtAaaTh68pizKPLn5ZljOKV7QtMtkpLBVkuErhsrVRXZUGIGU/A2fnZUHnVmi1X
 Y6by6IIA9KxTBl8+cI18JFBNtZUG9BSzlqUHbAgSFScb+yrjWpIfZCcEIDQKNGScWrzLKNsV34t
 /tMo7u8XGlv5ifVTZRVykD6QKlG/JOtkWZ1JxDwriDhyJtbJ/tmrWBQ0ssevu4l1qLLcbwgbkyz
 olQHR0BAre5qgIa+3W0tee1L42BC8Ht4jIUnDur0V4CGIQl1kbroZWfiKdHmusEeKEsxpRqucak
 eOC76nY/Q4l6+gRUxxGtHsx7OaiIRXAbshKJf8/rsB5RDJO3LedqhH4oIR59LqLJl4tCwPTDXKF
 Yt1MOMjMJTOh5ZuZS32iWmO8DaKbHdsha6xXOjd+RMG5z0SBzknPSSz78AEGMhQL4CXyN/vaWJn
 DdOPAGdpw4gUypQ==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
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


