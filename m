Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4331C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKE5-0004NG-Ds; Fri, 10 Jul 2026 19:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDp-0004HU-3g
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:29 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wiKDn-00032D-BQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:01:28 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-384c94c9414so1481031a91.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783724485; x=1784329285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lXV/3VxX18wIW2SLNnjXt115rvibP+YsYCiK3fOT3AI=;
 b=kY7GIjGb79dLDA2y1uZNJHBvuuQ39sNgS082iNP0uhA0JyV9NZZc+gfX0SwmXr5TWZ
 VcOlgTMNp5dl1MHJQtl386WKEvsuQBNA3dbB/zw1CUGwdEXGQfT/SgM2ZJZaxhndsGhr
 boywDyJVBPlTHB3kf9oXWxE/xqHctTI0Gv/xiqL5Ti7NAPQ3pudP4jcFn6J80DHk86Eh
 f0xut/rW4/PAW+KZR35j6O03r8pa0rxrFwGqlvMyHlU3b6cYdaNUXLUOH60qZCJGV8ZX
 4N+0RRlAqBSux2fs3vk5Lu+Pj4F+JM8luAZ5JUHA/yRo/NPwoYX/ZmLhWTEuMTljeRk4
 ZlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724485; x=1784329285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lXV/3VxX18wIW2SLNnjXt115rvibP+YsYCiK3fOT3AI=;
 b=Evl4SmEQcdk/bhe3bwBkhYfkuFQfT+Yie99i2agsy/BjfNGO/wpCpe77l0CFK1Oz0w
 M5uB1upykvQ+4KkmvtVxxImGJuN7on3DH2L/W/sE5j9UPT/GEax6FYzzGA+/lCPVzedy
 eKco9bMi66gz847fR3MbJQvOUmXslCo6ZsTmKZ+NEwNZjHLzRihhFKA758pZKIr1mv1K
 yRs/wMgUmjnTeEAByi3uhvKK9Jq0zWEC/Nf+oF90EzDCeuhPbrYoRBOrX49picQ67PQO
 omeySV7j0JG0SfO/qluxPTtLZhiYG2DHAdR4BdFPxRO+UopBCaC1bv0MQ1GjZaaSnUuu
 gSVA==
X-Gm-Message-State: AOJu0YzZX4XrsSMtGBijeJ86YcMTp+iLwELlEagNWT4r7f023y/7LXAE
 qK2Uczkpzk+nVvXF09CPXd3LnwpgpMO5FA1+MUlwuVjNL5wYU91j5Fc69KMhUoAuEZGEFPAP47C
 MMv/L
X-Gm-Gg: AfdE7cneEYkgF382AQbzM2hcEd3q6XUMnDcC5ZMprW3fEdsFi0IbVSc2EYUhjDHyxiI
 18V2U6ld6Kdhvwbn6/8tksm2e/BSjM0oPUAblN0knW0K9W7RdyqAvuroZ7d2wvsyzgM/64878ET
 jOd/XPgAKuMQuBxzjiBFDH0DWAMAqbjT4Mx71XE1tnvMs5jOVkxv+TZCdvFI411OdErZWbWiZlI
 Z80FL4JBIZ903n+gv6v+hE3Zzr2NKppPVXZt1xQvGGwy905llN/o8gYa5/7Hkggn0tNTBS5+Gyl
 6EUIBTq/wTB5uU7iw3L9b7KIFYcefLFIQooQKzDHBFPqi9UZt0vPUPTCe17HDA2y0TnnL7C0q9I
 di553z6WZd97SFbcg2Vdr5tCxhMGW1QMNLP/wu+nanQlN/tdn3yUgNwmHKEQg/I7B+6bQaVmmXY
 eKR4FtvMkPPm2uTzq0iQ==
X-Received: by 2002:a17:90b:17cb:b0:37f:eaf9:4682 with SMTP id
 98e67ed59e1d1-38dc75f1d95mr770666a91.14.1783724484610; 
 Fri, 10 Jul 2026 16:01:24 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38a55b3c9eesm3426569a91.11.2026.07.10.16.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 16:01:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/13] common-user: Move selfmap from util
Date: Fri, 10 Jul 2026 16:01:12 -0700
Message-ID: <20260710230116.900171-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710230116.900171-1-richard.henderson@linaro.org>
References: <20260710230116.900171-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

This interface is only used for user-only.  It's more usefully
placed within common-user than util.  Temporarily add stub
implementation for bsd-user.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/{qemu => user}/selfmap.h | 0
 {util => common-user}/selfmap.c  | 6 +++++-
 linux-user/elfload.c             | 2 +-
 linux-user/syscall.c             | 2 +-
 common-user/meson.build          | 1 +
 util/meson.build                 | 4 ----
 6 files changed, 8 insertions(+), 7 deletions(-)
 rename include/{qemu => user}/selfmap.h (100%)
 rename {util => common-user}/selfmap.c (97%)

diff --git a/include/qemu/selfmap.h b/include/user/selfmap.h
similarity index 100%
rename from include/qemu/selfmap.h
rename to include/user/selfmap.h
diff --git a/util/selfmap.c b/common-user/selfmap.c
similarity index 97%
rename from util/selfmap.c
rename to common-user/selfmap.c
index 483cb617e2..a1b88dee66 100644
--- a/util/selfmap.c
+++ b/common-user/selfmap.c
@@ -8,10 +8,11 @@
 
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
-#include "qemu/selfmap.h"
+#include "user/selfmap.h"
 
 IntervalTreeRoot *read_self_maps(void)
 {
+#ifdef __linux__
     IntervalTreeRoot *root;
     gchar *maps, **lines;
     guint i, nlines;
@@ -80,6 +81,9 @@ IntervalTreeRoot *read_self_maps(void)
     g_free(maps);
 
     return root;
+#else
+    return NULL;
+#endif
 }
 
 /**
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0671aba537..207f814e15 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -25,7 +25,7 @@
 #include "qemu/queue.h"
 #include "qemu/guest-random.h"
 #include "qemu/units.h"
-#include "qemu/selfmap.h"
+#include "user/selfmap.h"
 #include "qemu/lockable.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d257fb9ca9..b3572a6e36 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -141,7 +141,7 @@
 #include "user/safe-syscall.h"
 #include "user/signal.h"
 #include "qemu/guest-random.h"
-#include "qemu/selfmap.h"
+#include "user/selfmap.h"
 #include "special-errno.h"
 #include "qapi/error.h"
 #include "fd-trans.h"
diff --git a/common-user/meson.build b/common-user/meson.build
index f9e2e83f9a..831a7273fb 100644
--- a/common-user/meson.build
+++ b/common-user/meson.build
@@ -8,4 +8,5 @@ user_ss.add(files(
   'mmap-min-addr.c',
   'safe-syscall.S',
   'safe-syscall-error.c',
+  'selfmap.c',
 ))
diff --git a/util/meson.build b/util/meson.build
index e29cbd948a..fa174c07a5 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -67,10 +67,6 @@ util_ss.add(files('memalign.c'))
 util_ss.add(files('interval-tree.c'))
 util_ss.add(files('lockcnt.c'))
 
-if have_user
-  util_ss.add(files('selfmap.c'))
-endif
-
 if have_system
   util_ss.add(files('crc-ccitt.c'))
   util_ss.add(when: gio, if_true: files('dbus.c'))
-- 
2.43.0


