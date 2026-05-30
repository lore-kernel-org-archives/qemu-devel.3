Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9110ECD6E53
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 21:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTQzU-0005eJ-UU; Sat, 30 May 2026 17:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzP-0005dP-FD
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTQzN-0000fj-Oc
 for qemu-devel@nongnu.org; Sat, 30 May 2026 17:13:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso1210635ad.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780175580; x=1780780380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUSq6IOqb7CO9pe6Y/+VLE8O6WEqFDAtTZ5OhzrainM=;
 b=pN6Ws7EyO8bvDLOVtSON8uT7cNUMStJw+k92njIQ7lJaL3BD9Oey3E3fBH+waLaLlL
 Lv7mv9aj+uSMihXqG+LEvsYf+Ih1he9KRUTPuiOL6namqDAWnvlZtJMcmwXY5XesfwTR
 dcg6T3ruyjvYS3khLnlG6Nd21SOspJWY/C+0aDUDw2zfjqnj4QgxTpoYU/mKgBE5MKN4
 5MminZg7V5mSxEiof1Z3ZHWBMcRN/g2erDuldV3cERP7UKykvRTN4DEsKYJkDkfpl6Jw
 71QyyPR5Ko2GlI+Ljga9StMIznKJfr8Rv5azcgOJD13ytja9Dh50YSrVbaXrh67dV9go
 q9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780175580; x=1780780380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUSq6IOqb7CO9pe6Y/+VLE8O6WEqFDAtTZ5OhzrainM=;
 b=laJvYnrh3P/oNuWXVY26W8Kg234Qx+jhP440g2S91KiTjfB3OXcc7eqpKkpq9bmBbv
 5B47F+0ICrPgXFm2VbGyVgvoccnCqNmA8KkAUqVFa7YenDAiJAOtYGqNxUt6mfFgs1UN
 JquXumXY9bLt4QGR9nys3ibzJnJtKvXjPixOnDb1+MWBgJVxzr3cQfaG78kUQgt0EQpM
 AREi6BcatnUXvcP59Im5mEONvYNGQ1/2dAI5MppJcmWBS85JDd4I6xOxYI/YU5l/i3xo
 8nbP3wWU27H38riGzMdVtXjjCwVmop0r48ePd+8xYYJhWSSjU1twDZ7OeAmddNAOdFFq
 INwg==
X-Gm-Message-State: AOJu0YznSyDsuU14FDIb8h+0L4Jglq2g8lZzdLBOiOfQVJNWYsFTiM8+
 kT63kfhIitD8O+ZuGwKhw17BdPcuLp5gQAM7b5BydY4A6PzPUybDfR6UC3ywSvtn0RkJhTDdBKS
 z0ocMo3I=
X-Gm-Gg: Acq92OGizjTyKPaZMOdIY3LO8cbcnVtD0vEQS+UZF4VICVJklEIQNw79PYLl5SNJjE0
 G1WG58S8N6IJBdg41INNrhaM/xAR/I1buiPtV15oNPswGNHBUXIUt4fMUySyNS5Y7DmmkONXLMI
 8sJzJP9QLh5WYuq9KkqTuNzWrn8cJmN6cFpm/5Fm9L8f2V5Vel1p70DCmLQV5mfDfu3UTwU6Ul7
 1yVWGdEiJGmOApIvgyUVnAENiSuCjUqs0ZgXHFljVxArYETpvUsx8IRhQEaBvHmf55JLtJg/yib
 jyvI4ETUfOxV3caeqeiKLiap+sGECknyw3BCckKJEeIwsj1vBkRoDR/KnRojWCjt7sEGVdEpIBW
 1DUhaTQYcO9uS5OQL6YKJyGtx35vv3WQQHGM9LMp3ylyYPZZnpdzcTwHr+HrnEVGUEoSYluhH6V
 SSw3FXvPnhnVlINt0g5rlKoLxTlw5C8Hlg8r/XKFE=
X-Received: by 2002:a17:903:1c6:b0:2bf:82c:6322 with SMTP id
 d9443c01a7336-2bf367b1052mr57959975ad.3.1780175580243; 
 Sat, 30 May 2026 14:13:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf23c580c6sm59592895ad.82.2026.05.30.14.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 14:12:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	deller@gmx.de
Subject: [PATCH 09/13] common-user: Move selfmap from util
Date: Sat, 30 May 2026 14:12:43 -0700
Message-ID: <20260530211248.375318-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530211248.375318-1-richard.henderson@linaro.org>
References: <20260530211248.375318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
index 93ab2661e3..0450aa13d8 100644
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
index 7d7a7b489c..448f80b29b 100644
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


