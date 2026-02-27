Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40DFFEFB54
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 13:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvyLw-0006GI-IW; Fri, 27 Feb 2026 08:58:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLi-0006A5-Cu
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vvyLd-0007UU-Qp
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 08:57:44 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43992e14638so2055633f8f.0
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 05:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772200659; x=1772805459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6roZ6KUka4AvFndTl3oMOQCvPictd311jnL9XOZjvFc=;
 b=K9jQcCV07bVKJVzYWpqbTYkyb2YFtfVhaN1s24vFb+9kQmzWbKMiCpLfYRonhh1SXC
 mV4R9F4dOMUX15HoLnxFaD4ngphO1o1+uaLZWWbeVIT+Omjz3MPLVbHACk7Q6p1UDp50
 fcTDLbgLRryHGF6JPw1l+gmo8FrjOqGyFO2d5Nhg+Mv01UXRPjCQeArQ50tjKD/v2hEs
 IRDMWGGvzuXCmu31XL9rWJsffiEZx8O1itZTRl1gYj2BBgyjR88IEO48BvK7cR+jto/d
 6jYNOD+uMV+zRJoNpzdP4eGuf2jvlCSxEG/5nOUdFSoLHU3Q5KuhfkxlNoCs2OoJfRvL
 Wumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772200659; x=1772805459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6roZ6KUka4AvFndTl3oMOQCvPictd311jnL9XOZjvFc=;
 b=DUg5SXuvn5Q7aC/FaobXns7JZKsBdWSH96NzJguW7j20cuMbbSoAmodGn4PsrGEpYk
 A7+ywU28Qaaj4kXPrLFVNtmLKY2Wtde4HxeXsR/ePOCX9u+g3wY3uBemVeyIgvo0ud+i
 LsgeZtHwG7N53Jdxctzr0sOSAjJ2M6jBGXXtI5O7kzOkRoQpqn6jrJGblP8ZK/2sSucH
 iHRD2HT3+SGOQ0Pw67yrE55laE9md8GoniajSTqNQ//r1MhuVekafkSojUeu7OMRFEN3
 12azX1BeDUq4kJee8/lRJoeijxHe5PGQ3jtTNSr/3AXtLPmbcqdTaIF3LLKz4ezodWWD
 2vOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoOyajTZIxGngNGNsbPfDOxxgoNSJ6mZ8E8JG3TaFseBulKv4Lq/IAlqJS7aDJTMMWbwn8ElahXvIe@nongnu.org
X-Gm-Message-State: AOJu0YxQmRLTeYoEGDiW7sCcJP5/kS57KTpZaokHSnKk05TSWGvS34Dd
 TB0YuvuFS/Y/uL64/pmITMoPkYHMB3R6yXhr+HNw9ZTrMwnoBNUU0BFJssT1M0lFVpE=
X-Gm-Gg: ATEYQzy/yspOGsNLR5V+TMi/sRAizthzlDRh/6aNOLifoEc+VbyTfSlJkfAAt56VV/K
 WEi5Xgqcygn63G0FwKjX5WqVoiQRqb+9bHpTRUnP8mzzlrZ+hTgOK+3K2M5/pqINSuIkL5c3v+2
 Dx25QGphSjVPgVq1QXpYrig0U2Inn9bQAwXLJFdtF1FKJQwM/DYlv4MJr6YcbodL43R5WA7yk8a
 6Ek2vN4AQtox4dcPYgn6RCEOnyG4QBa/MueDkhy2NAGjAKx8J9rsi6f5XpwvktjGY2UaSqsCCbw
 dy/GYycq/64bAgJGwNG5bUhY6HUBOZRvp4ixjaGyLqXRxrA1gm4slroANQnE9NzroQSqLXXI9O1
 dsDfOsy3nqBkRqCDkgzMrfRv2xNG5QQEstKnXCgo/7ya8UWrZxlpD8nWZdqsgPmvmqCW0WTKch4
 7fFzv0jRAJJWpa3Uz+1q2IOYq2qWwMk2JroB0jCmoJHHkJC4hvvopgnaA1uLx737Ce8Sc0ZoqJW
 7JhAkBUKB6NswUiJuzghZLrL+8N6EI=
X-Received: by 2002:a05:6000:2485:b0:439:918f:f2ed with SMTP id
 ffacd0b85a97d-4399ddfc6a3mr5159550f8f.26.1772200659068; 
 Fri, 27 Feb 2026 05:57:39 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75b327sm7655163f8f.20.2026.02.27.05.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 05:57:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/4] scripts: Move lsan_suppressions.txt out of oss-fuzz subdir
Date: Fri, 27 Feb 2026 13:57:33 +0000
Message-ID: <20260227135736.2280161-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227135736.2280161-1-peter.maydell@linaro.org>
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

The oss-fuzz code uses an lsan_suppressions file to suppress certain
leak-sanitizer cases that are known issues or not our code's bug.
This is useful more widely than just for the fuzzer harness: if you
want to build QEMU with the leak sanitizer enabled and run 'make
check' then you will want to suppress some bogus leak reports.

Move the file up a directory, and add the usual SPDX identifier
and a comment describing how to use it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/buildtest.yml             |  2 +-
 scripts/lsan_suppressions.txt          | 11 +++++++++++
 scripts/oss-fuzz/lsan_suppressions.txt |  5 -----
 3 files changed, 12 insertions(+), 6 deletions(-)
 create mode 100644 scripts/lsan_suppressions.txt
 delete mode 100644 scripts/oss-fuzz/lsan_suppressions.txt

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1b656b9eb0..7548057c54 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -626,7 +626,7 @@ build-oss-fuzz:
     IMAGE: fedora
   script:
     - mkdir build-oss-fuzz
-    - export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
+    - export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
     - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
       ./scripts/oss-fuzz/build.sh
     - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
diff --git a/scripts/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
new file mode 100644
index 0000000000..ffade3ba5a
--- /dev/null
+++ b/scripts/lsan_suppressions.txt
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# This is a set of suppressions for LeakSanitizer; you can use it by setting
+#   LSAN_OPTIONS="suppressions=/path/to/scripts/lsan_suppressions.txt"
+# when running a QEMU built with the leak-sanitizer.
+
+# The tcmalloc on Fedora37 confuses things
+leak:/lib64/libtcmalloc_minimal.so.4
+
+# libxkbcommon also leaks in qemu-keymap
+leak:/lib64/libxkbcommon.so.0
diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/oss-fuzz/lsan_suppressions.txt
deleted file mode 100644
index 7d90c280d0..0000000000
--- a/scripts/oss-fuzz/lsan_suppressions.txt
+++ /dev/null
@@ -1,5 +0,0 @@
-# The tcmalloc on Fedora37 confuses things
-leak:/lib64/libtcmalloc_minimal.so.4
-
-# libxkbcommon also leaks in qemu-keymap
-leak:/lib64/libxkbcommon.so.0
-- 
2.43.0


