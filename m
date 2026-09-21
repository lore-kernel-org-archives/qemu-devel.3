Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4127C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8b8k-0002Xf-6B; Mon, 21 Sep 2026 06:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8j-0002XK-5R
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:49 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x8b8g-0002hT-By
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 06:20:48 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 46e09a7af769-7f4f0dd550aso671063a34.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789986045; x=1790590845;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0uaPHiYfyBVWUyfdgETnVEUJy9A5Gq5oT9ril64GUCI=;
 b=l56AqutmI6r3s8vY9qYGKLuH5kTL8ONseXvrsi1oGx6wzEbxYFqH2fG9ExEBeG/FO0
 SsuQ/L/Gqv3oFMYxRXgZem31t0PdaoxVGndf7IwSUOJDyXLOvb0kA+YXJE95KRUAHJDC
 KfSaqtRBrF0+tpVSE0/bCTVQ5pCsyOyS5WyNysgRUmvKQJ9EXUyZMqt5egSDQsTWCF6A
 E4BRkajK7Y8BSSBHBZxTVlscIBsr6d7CtDg1XU5U1ZXTvOJip22tA88lhl9ukBYQg8mZ
 0Szi6R7Z+Fjcl+n3U22zI54Gu5KpEhCgXDJEymLH8hQLlVrUMHcZIKjQyBZboVpj1mGI
 0FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789986045; x=1790590845;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0uaPHiYfyBVWUyfdgETnVEUJy9A5Gq5oT9ril64GUCI=;
 b=MPqEvqcqGHFU1psk4fxfU5oXcNbIDa+QQ53tdK7AeUjGMdYmf2R7p/QZaBQDPOmZnX
 dTrCmFIw0lXZh/HKhvSGPcmb0IG7PjCdgLQTeO/XVUq0wMomo+4wNys1fGbPTHzFveZz
 OmdDRERdg2W3X33PgtQ5v/ru+MhMVsj3Zba5ZQcrwjuKzjdY/8fOaCI4LxCEhEMy2dM+
 oxHd3DaWTEDpr7HP3oKRVs+RpxP+txdkSeyxG7Ct4QpMOE/gfaQhMuQF6WjROayT79Zl
 gBmI/Zo1oa9YO6qVyYqlFxgmvPMBvl0kxVB54KDLd/zOsWNnLXSOt8AC1s8UYbLin2TE
 kb2w==
X-Gm-Message-State: AFuF++mD44ZRy6gE2Y/aRM4R+5mRxSuWfd6W3jDvE3ehU01So4HaHgnl
 LfkrrnFOPOO9IdJLnk3X5OsraPpJEvN01WNBwSiDDnZRa+dMW8b1o6wCPrLoNYU9QEE=
X-Gm-Gg: AYBFou3kQ0MgXO52a1FtAx71YpsiaeZHC2U0/FYVG1oRgWtOXKSOhM2MelXu3+ZYHgC
 0dZmldwEVf0LuhL6qcNYiH2r0SmBO/8w7HvI4upcPPm7iJ1RGRymh/DVUOovgdQW6hR/tYF/W3u
 VBnQAcflbt3alBLO+9popuJA5CmqF9IZ2qcAI52WXmPfMyt3ZixXk/ch2plfX8s85KJIYaDeVZA
 uUOZ3LyiKN1ylOljATbX6WbGjXEC0968AkRn0zo9Crx7Qm4ByQMWvI5rnXus74r0Hz6S6IXPZmk
 42orX3SnKj4XdzbdXVASvvOVK6nbsTD0Dsqx/50ghhvy64kSI7cG1+W9z5tmeqjZLvy6IftRSp4
 febY6OlxHa3oqjxB/ubFiA+SH7KaLPv8m8+aSGjWgnV/VmI2k0kjWgJS2J1RLeoltWptpB1RIdV
 ls3EDRma/RDiFy1B45e3Hek0ftnQuFdJxQA7hPgW5LJViGYCFLfO4tJL8PdYFPkUgbJ03r
X-Received: by 2002:a05:6820:2909:b0:6b7:8396:f3c6 with SMTP id
 006d021491bc7-6ca9c05bde7mr9088365eaf.40.1789986045100; 
 Mon, 21 Sep 2026 03:20:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8107dd8f425sm7613601a34.4.2026.09.21.03.20.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:20:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 21 Sep 2026 04:19:53 -0600
Subject: [PATCH v2 11/11] bsd-user: Remove host-os.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-misc-2025q4-v2-11-5eae157d31d3@bsdimp.com>
References: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
In-Reply-To: <20260921-misc-2025q4-v2-0-5eae157d31d3@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1815; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=uYHJvnrFuD2Ozs5LUh/1bahAK5/VveRwnebgq/TMqaY=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqsQTeqJEN9C2Cd80SVydR5XURwOV1R8WSKc1sM
 kpyt76IVUyJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCarEE3hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDjIQ/7BkTEOIP7hzmC0L0xPmvJbNc7gZVnp2v
 ONjVdtQu4wbvjlNiDDldJ4B1vylfnXWp5Fk6c+8OdI1SiIhUT154/qTUsJPx13Jbz4Ie23whuUw
 Tf4wuTiZ5xCe6Md00bUGQnYDGBPZTBskaYNNHd5ilO1aaro5d+A9n8wrfzbMbBfnMGopYv1UMoi
 3n0KmZfoFXe5tFuRhdPQ3PLawb4Xff5Ss8GrE98B4dAQ51xks/Z7B3C7xOMTwqMLXba+29UNanV
 mAA2yWVdWwf2gfk8Dr1Q4ZheCpTctT33voaYk31GXJT0hNsLDmE/4qBgEPOv8MmkWpOUMyaj2qn
 myiAUdBQxeZoSOFDrwZoftCIHde3Mne4H392dJL3WlDHzUkeJh+cSYDhWs7m6hdkcOyZlEfNC7H
 ZFKrYJWfUhR+ao6igTMoreaYQ778Dfhn3tATqCk7aqdCm+Bc/S6VfJyB4ySPNPA59GHk9fRr2HA
 37m+svyNfTQhaDpFV+rrQgy/anz0VEy1Ya6OBjjs2uFFDxVL+905gKANLwBbKcIj87OVtt+N2Kn
 6veNSevPxMWe1mtsd1+L0RfIT0p2pmZJz54SiviCqHzdWCeP8A2UJiG93Ruoo+mj5ClTnRJeLYH
 0vblcStwWVLnKZfz8pW/pJ5vtvE0qc+svHnAQS4EC3whC7tQEPHw=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:32::10;
 envelope-from=imp@bsdimp.com; helo=mail-oi2-x10.google.com
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

host-os.h was used to just set the default bsd flavor, but it's no
longer used. Retire it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/host-os.h | 25 -------------------------
 bsd-user/main.c            |  2 --
 2 files changed, 27 deletions(-)

diff --git a/bsd-user/freebsd/host-os.h b/bsd-user/freebsd/host-os.h
deleted file mode 100644
index 40cae72ec9..0000000000
--- a/bsd-user/freebsd/host-os.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *  FreeBSD host dependent code and definitions
- *
- *  Copyright (c) 2013 Stacey D. Son
- *
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
- */
-
-#ifndef HOST_OS_H
-#define HOST_OS_H
-
-#define HOST_DEFAULT_BSD_TYPE target_freebsd
-
-#endif /* HOST_OS_H */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 13cd752b99..29ee59de2c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -52,10 +52,8 @@
 #include "exec/page-vary.h"
 #include "exec/watchpoint.h"
 
-#include "host-os.h"
 #include "target_arch_cpu.h"
 
-
 /*
  * TODO: Remove these and rely only on qemu_real_host_page_size().
  */

-- 
2.55.0


