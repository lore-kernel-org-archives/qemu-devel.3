Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDAFEF99F0
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr5AL-0004NM-6i; Fri, 13 Feb 2026 21:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr5AJ-00049K-CF
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr5AH-0004dq-NZ
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:13:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48372efa020so9277655e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035224; x=1771640024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBfS1gwelZ2mj2qarZUPVGv4uT0cGemLv8DXYJc3eqg=;
 b=SEZtf8XFVgVTmh310w4BaWz+InFg8ztedq/p+g/dRvSrlfGmDzSCMymnq13jInehMR
 Lcm3wSQ/7khSNh+BixvAlrEz3PqFJfSgPH5gk9jVtWqV3fFmaqLGxxnCxcE7yJZQ9tCy
 Sw1qacHAcZWFSk4S3/y+5Wz1o9ys5+FfwYqZNNJTrZyC0KtZ64RVCQXs7+K4XL/tZdUA
 CpqOavz2K7LNG9GIYSbE+/pYzaFkdIQA4NiK+YKbStczH6+6Xsu9iflTnzBGqj8FE4Ts
 m1pHpq4DHwMzUS63m0Xbf7xw0BSInCrtGbkF9lBvoJPmgqUHOfR1zmTRUuCaYyCK23bp
 ktzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035224; x=1771640024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IBfS1gwelZ2mj2qarZUPVGv4uT0cGemLv8DXYJc3eqg=;
 b=clGIl1ssQ3Q25gmXgd6gWkAAAPdghMuUHVnsF4bJXDPa7ObxBXpjouEEjMCiryDo/o
 ZN7omIHtPe9wMS12RhHQSDz80nVENWZdtbP/pGYOGw6uoCaKvibm9OI/O8al9LbkeSpu
 OmYOWIMdUC0uQuDZgHNjcJShyM8Dd0NEKtaGlurkkMSFOVtUKu78S1qncHBKzAVY8uSS
 jbKq7m8sTVmVGaA8Yt2p0+HCGBQS3e5UfPd5Nh6gfWJoCJBJIdEIytpOAKue7z0l3KMh
 5A2e/2PzaGexglHLR1ni7+/q3g5QE7NjJOeuYk9OXxFLX6KgJkK0JQa97v6gutUeMOxC
 HNvg==
X-Gm-Message-State: AOJu0YwH8FUMJ5UqgQBC5tzRU76mB3NEqeSfHtdhPg7OLP40gZj8z6lQ
 Y1ds9gZYZOjNF39/V3fcZedc0l+vBzSi0IUtUMZqu/VQW6YYfP8qILLbWIzOO088iBbdKrBWFBm
 SPZ3QYJQ=
X-Gm-Gg: AZuq6aLuLBonv/MbsTOoD4HHMbhxZV33PnpCMfXpxVm5mPCDKJMt2bUvHR1SA0R1ub0
 ftmNLHjoWPaJYzgbcpj1wZSlbVHHzT4LoyLxUJv2u5wuSwx0Soge+y82AHaAMpCZRo4dg2ttlOM
 b7MOMajHqU2+RNFuPJo8vjDYw01k7Tb7FKDyDITnO6kUUgoUnZHHgRbe0mv30VfJHzYuF7jtpi2
 5n1zmZ0Ph/XLFA0JWmz9gi3HchMNQTGm6rhNDn3ed4gA8OxIYhuKZyXjRnSpdieOxji9PZccQO4
 IkGjTSIHlJSPcGH2Bviaw+gCvGyyMx6/sObS6kMddZNBTjzqw+yhG8RRjMfDehZRwvDpl8n1JJF
 u+j4PLUg16+O4dXd99cvS2heRJPmjsHyb94s9uHwXx7J72L2begUnhdIDYKfdJBYtd45m/XZwOh
 w+5t7r41sl2mjZsL2Ly4xp3Vd+sGZCtcvhaO2KetECk3/q7GujrE/YjByqTOksTNYvFEV9tktU
X-Received: by 2002:a05:600c:83c6:b0:480:6941:d38b with SMTP id
 5b1f17b1804b1-48379c1cde5mr13980735e9.30.1771035223809; 
 Fri, 13 Feb 2026 18:13:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8209sm9885016f8f.30.2026.02.13.18.13.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:13:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] system/globals: Build as common code
Date: Sat, 14 Feb 2026 03:12:39 +0100
Message-ID: <20260214021240.58657-9-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
---
 system/globals-target.c | 14 --------------
 system/globals.c        |  3 +++
 system/meson.build      |  4 ----
 3 files changed, 3 insertions(+), 18 deletions(-)
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
index d91703d3dcc..579e8353d53 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -1,7 +1,3 @@
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: [files(
-  'globals-target.c',
-)])
-
 system_ss.add(files(
   'vl.c',
 ), sdl, libpmem, libdaxctl)
-- 
2.52.0


