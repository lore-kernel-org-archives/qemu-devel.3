Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00924C636C5
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIY4-0002it-Uc; Sun, 22 Feb 2026 18:07:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXo-0002JU-N4
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIXn-0005yy-7b
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:07:20 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so34623295e9.1
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801637; x=1772406437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2DyknkZUpUrAhmdi1X/z4oFKPuWggB5s5lzC0L15D9M=;
 b=tjbUtH5RUqPhwgs56YQzbPd4nnXWcZCoMu6xroMd+Lc8y9whAA68vxdE5Q8+znXKXx
 oDhH7CWER4BREg4axJVDpcDdQF0QwvFCV2Q9r5DoPMb/824AvIsGshJY94Z64owOxGia
 MJESP/pi1++lzjyYC0PJW8hz2ro2il+PCZ4bMVFqOdPqq/e3oWwBJNZxp5ggA3Cu/rHn
 OTN4/D3sOqdEoq27dBLCWN4c5xaLxlbDqnLr6xb63l+vVwinpF82McSJO5xoud98YuQC
 okXVEQfcIvbB1g/bUgJkYLX00aPs91pvuJmn1XpBaq7zqVBYHGvWmqdlqppg+VlSfufN
 tD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801637; x=1772406437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2DyknkZUpUrAhmdi1X/z4oFKPuWggB5s5lzC0L15D9M=;
 b=dlzpagqyGdISWfxx/xnhcCJEAHidK8zflyiy4tbLYFfjvIfF/kmrCT6pBeX1GPa6G4
 SbbURlJTW91pq4KrWaZ3BkSA+bWu+8LQCudKAuum+ezD7lQZwZGpsm+uiAmQ00aq8QDg
 4wBLOVwO2Yy0Swt9y/e627tuU8PriA/6b8pbuxN/kIt+Ctsbu/eKfnthM29onFAAkBAd
 irY/SPo9uodZOAnlLDLb4hr8I1yVW+4+I5gy3KT8OHVNeEW+g6LOQ9W+LWv2tcJOwLhp
 esOe7PHjVTQw4FAidQOpBIkMredoUh8eHhsaDuMlC5j1RzugMyzwYYyILS/rkEKNEdDV
 oY2A==
X-Gm-Message-State: AOJu0YyDQusxIfOMBRgP9t8YBcYq3bh/tHTv5I70NNxXJgUsjqmFE48n
 Whq4AMR6r3XW079H+Txuc6gqOqmHblNfwnxpwGJ7ETWhIAZzkxrWlqZCyTw7Y0dzbbELeT7JH/2
 Otpn0Q+g=
X-Gm-Gg: AZuq6aKja01CRoBQ1xsff2sZklzBcs3pNnTfPZcHCgXm4SJ4FQshWE4lXmjVMqkp4nt
 if67V1YtO0stMKnWj4RjnDI5MxjKSOBqo0bv4aCFgTd4oyA9RI39s7i+Y1hMYfbRBh8CztRrO1o
 QrIcET7hiR2+zL48pK++6eF1aPeJ2dExVXiYW2YL1kDPbx/pNW2sAWLXmFpdp6bZk8qy2z7UYqu
 nYQdW23ER3amIoE1ksxm+OIXhkVmU1oWUIl6qorMuQ9Deag1hwfjRk1vZrN+f8MuS4UsvBoenwu
 npxfn4ZBfeMZ++SHb2LKRojInnpSMhDxjj35VA/aMIrtjqHJO1/n1yLQYXI6ge/A56T6tLcpGIG
 YdxEwrPHuK1vXVsi4xKw5BV8I19CCzujudmuXgrCF4CXX0FsItoc46HG3tiBSIductmYgqkmXZp
 n6u44kbXjvEYMD3Yee1+9f0Uc2sDH/DZSytzpsSs2dxWtI8CrOP0wMHleyPtRy6R+l4/0HkS98X
 oS+A9RotIM=
X-Received: by 2002:a05:600c:8b5b:b0:483:a352:b4e4 with SMTP id
 5b1f17b1804b1-483a949e600mr122205295e9.6.1771801637458; 
 Sun, 22 Feb 2026 15:07:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm85801695e9.19.2026.02.22.15.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:07:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/20] system/globals: Build as common code
Date: Mon, 23 Feb 2026 00:05:52 +0100
Message-ID: <20260222230602.5756-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Now than all targets have the graphic dimension variables
initialized the same way, we can move them to the common
file unit, having them built once. Remove the now empty
globals-target.c file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260216213121.47122-9-philmd@linaro.org>
---
 system/globals-target.c | 14 --------------
 system/globals.c        |  3 +++
 system/meson.build      |  1 -
 3 files changed, 3 insertions(+), 15 deletions(-)
 delete mode 100644 system/globals-target.c

diff --git a/system/globals-target.c b/system/globals-target.c
deleted file mode 100644
index ffa6c308b59..00000000000
--- a/system/globals-target.c
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * Global variables that should not exist (target specific)
- *
- * Copyright (c) 2003-2008 Fabrice Bellard
- *
- * SPDX-License-Identifier: MIT
- */
-
-#include "qemu/osdep.h"
-#include "system/system.h"
-
-int graphic_width;
-int graphic_height;
-int graphic_depth;
diff --git a/system/globals.c b/system/globals.c
index c33f6ed3902..34fd3ce9c72 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -49,6 +49,9 @@ bool enable_cpu_pm;
 int autostart = 1;
 int vga_interface_type = VGA_NONE;
 bool vga_interface_created;
+int graphic_width;
+int graphic_height;
+int graphic_depth;
 Chardev *parallel_hds[MAX_PARALLEL_PORTS];
 QEMUOptionRom option_rom[MAX_OPTION_ROMS];
 int nb_option_roms;
diff --git a/system/meson.build b/system/meson.build
index 4b69ef0f5fb..035f0ae7de4 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,6 +1,5 @@
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
   'arch_init.c',
-  'globals-target.c',
 )])
 
 system_ss.add(files(
-- 
2.52.0


