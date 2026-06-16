Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280C5CD98EF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDk-0005cB-Jv; Tue, 16 Jun 2026 17:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDd-0005aA-HZ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:13 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDb-0007Qt-Rt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:21:13 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-36d6bb38b44so3307431a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644870; x=1782249670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7GHFTTSlEJLnE9T7yYuDnYDdVUjyGwFwEw2Q41F1gE=;
 b=npyvCtnKjGsokaZjOz+jibHBmeJTr1yU5Pu+/QpYpckVuAtApIcrhDFO+00CTXw2sk
 DbhQD5FTtaCkvkM+rHn6fVzZaAU+Vu91ddULqMsbr/w2XA31T1yRtNTyZAcvIJ1zOpNO
 ovQ9QTEDPxWKsSbSOFUszsjCkv6fcih66lgPLi5GSgDsLQ2NQuE50V+Xs6nbDUlk3/UX
 8QC+yuY5yriTy7q+CfVDD3E7mDYRZq4hu1O8CCDaCxuFAlfOUDKSnqUva6n+H/lLZRDL
 Zz21HAkgRb3EfkV5w+rCmbJdswubQVS2vnCH+bMuLHeWkGQoEEmWm514YJ1LMqCn5c6Y
 AVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644870; x=1782249670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7GHFTTSlEJLnE9T7yYuDnYDdVUjyGwFwEw2Q41F1gE=;
 b=X1gT8cTkejYvuqLUK5BeNfmITFu8HbzQpK2hzobHnPvnV0ZKQjtrL58qbC4HMu5tVr
 fOrGEZAdXEcT3AgtsugdQxrU7uYAc4wmaOaHs/V4kU+N/IBSc+NKAFh4zSIPfcUV72bD
 75DRm4h5CBNqk/MHogSGlt8s8mB1bqiRNrBTV0Zq/3fbBFmjUDtruT2WHIHnKqCg44vJ
 vcHJ8QFnABCpfz66dJemtUZwSy62imkIqs4RBfXTEt9XP/uE5/lsVETaxkkMx88uSgD6
 J7Sgmh5Wzxblu+MZjMLeeLAv4MBPVhFjgvxILdl8UskLn0rCvxaeFtoGlJ86RnfiJXeb
 5jpQ==
X-Gm-Message-State: AOJu0YwkJXYYIobsZsbOe5jHLl40JFxy8Ww1Y48LA1NTirV8q52QtDZx
 u97BF7DssqAbPd2JKdja/HSpvHXICaDbcfNEKvMwYFgB/aVZJGKyL5gyNbAztidJ1GeBcStRmpA
 HUT8M
X-Gm-Gg: Acq92OF+VxDRfHQHO+igssCIn/PoNXcNchDjvy21k3kSKHjiFiW1XEJc534Eevvb+hs
 4ZapQEtns7whWWQ88A45PUszNCshjYj6hUsbpd00iHUxdhxGQH3JMMvN5I75q98cG/te1TuifhV
 lsAu7fI1tZyUy+jJ/fPYAvXvBAr/okKQm05LgApsNHVztCIwZV9TDB3iftfFinkSWxpnvKakv03
 zo4sIZTBwKmGm0VSAmgF2vQ0fiWXgNSlrSGZjtjIHwZJq1w/NqiXIA2e0dmCHopP7SyqSdJq16A
 ra0+b8pWfDcyXzwM7HIMHxvNn/mW/2+Meobe6zjykwlRxkFGO9bzBAIP11LpuArMAe678FbYg3S
 HWhf9LerjJeNEBOByOd40oFjBjfsNDgVMjHYE+SpT4QGZV+WlZgzOAnujaTIyCiEOu+PCAnVLWI
 JOkHUGnlTAn1H+OOAO2TlptJgZ8VGtTx0IUIQRRFohbcpEHTbxN5f+YAiMk+bw
X-Received: by 2002:a17:90b:5107:b0:36a:a16b:5f65 with SMTP id
 98e67ed59e1d1-37c9372863cmr1095562a91.11.1781644870422; 
 Tue, 16 Jun 2026 14:21:10 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:21:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/13] common-user: Move selfmap from util
Date: Tue, 16 Jun 2026 14:20:50 -0700
Message-ID: <20260616212055.334466-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616212055.334466-1-richard.henderson@linaro.org>
References: <20260616212055.334466-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
index f32c52a968..ee2df35aa8 100644
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
index fbe357b7e0..dc4fb72385 100644
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


