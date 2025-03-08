Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46086C28B2F
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr27C-0003OB-24; Sat, 08 Mar 2025 16:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr273-0003Ip-9d
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr270-0000wf-Pg
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:40 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso25129535e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470817; x=1742075617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRYf8YYeSE9eCvOULdmo+k8kd7hCBr9xRw5oUZbhPJE=;
 b=AM17UxRrDVk4wpASsYVdOi5xEqkoqukmKFUbGhvcPEgKm/oot1bkChCSLhG72F8Hsp
 r5Q2Cqi47ffcyEmlTy9GgeybojQok4Ti1u2GBpuyyAaXLH4PIq6ol329W7qJkt569g+i
 KOQZA00bxPpGWOYRsdXLiQ8oFcmfJJPTB4FFA0I6QUIWaKnmX3JkU/3kf45StcmZSthf
 LmClPHI7qEtQAkJI36yB6XRD7XEYAxRx3qJ/6DdWCuwJqtCBSFj3Bj2WU7mX553byWdD
 EFvnOqAQpuxTXEL/Qu1frf9U10wfBF4DlNGyoAbcGI29ZSRN82DgATuBhccpcm7+oss8
 M61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470817; x=1742075617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lRYf8YYeSE9eCvOULdmo+k8kd7hCBr9xRw5oUZbhPJE=;
 b=aiLrLA9dSjjdx/J5JQVMuFjb86R/bp1wlfZ3F5KrpyJdBFRtamYI2utJwlY+XP5UPu
 oISfrfshWbiFlGS5Nv0kHO8SNPjmZIDZMTxTzQn8OfSW62dXrvyiZNySYMg0f4AAPSSp
 VBQBMkJD1Z314W7dOmmLvCmg3T50ufO04Rf9M/oZ/oCetHgSmXvM44LShrzMHq0wyjtd
 IE1QWNQUncp36q9tsItiF/s+UznvE26pFpWEUx1276/3iL1VLtP2qaY6bhAZH5nJO3zx
 j+rCPIfuutJerRrt7WX6tFisgb8ZQXctm8BK/r9cR9d6/1yuEckVh+9UGhfjp7O9rbQR
 aN3w==
X-Gm-Message-State: AOJu0YyXDS3N8NEPHNLwj7WSdDBxDj+DzBvJG1YPKgsfNekCE6Qi2hE4
 PUmg7aW+T8NvtSjwX4va+w0oSbkfPSIv0LvE9Sd/b52b34n/K/TCFK3Kau0zQYY=
X-Gm-Gg: ASbGncvHixbfeqRLqsQVb30HRM0OPulPnGEQqPjqzgqKPnP5JLLrmMOlmLZ59DhZXGD
 pxK6zFpkcsTGCrAOtX3+Wy54gMV/RlIVG1ou3M89ZvzgKsPz/athub9eZkgWCwEn26ldheTL44N
 pO16GoFaEsaZLf0TmdxDVBza5uyWmIO3uZ5NFna7aB2wDvb90VIScfmki5iDAND1cogW1T8/dQD
 j4HKLEOrBwcW9apt535W4f2EJ0neLT3Mu+GF40X3RsmzXycT4an2HS/wWjMrJIm2m9SG1kFb7DZ
 nbyS2vuyHKs9efgCGU8zSXO0dBWfyDZqtG+blEMHeGcD6s8=
X-Google-Smtp-Source: AGHT+IGe/EYAehbFZW1N5uJzxV51jiw9QnByjdeY4XcatuqrWKvTSI8sQE9tVva1XKKXYVI0WPGTRQ==
X-Received: by 2002:a5d:6d84:0:b0:391:65c:1b05 with SMTP id
 ffacd0b85a97d-3913aef5f15mr2387373f8f.11.1741470817143; 
 Sat, 08 Mar 2025 13:53:37 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0195bfsm9841620f8f.48.2025.03.08.13.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 38DEF6056D;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 17/31] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
Date: Sat,  8 Mar 2025 21:53:12 +0000
Message-Id: <20250308215326.2907828-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

GCC versions at least 12 through 15 incorrectly report a warning
about code in sha1.c:

tests/tcg/multiarch/sha1.c:161:13: warning: ‘SHA1Transform’ reading 64 bytes from a region of size 0 [-Wstringop-overread]
  161 |             SHA1Transform(context->state, &data[i]);
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a piece of stock library code for doing SHA1 which we've
simply copied, rather than writing ourselves. The bug has been
reported to upstream GCC (about a different library's use of this
code):
 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709

For our test case, since this isn't our original code and there isn't
actually a bug in it, suppress the incorrect warning rather than
trying to modify the code to work around the compiler issue.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2328
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250227141343.1675415-1-peter.maydell@linaro.org>
[AJB: -Wno-unknown-warning-option for clang's sake]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-18-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 9efe2f81ad..16ddcf4f88 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -83,7 +83,8 @@ test-aes: CFLAGS += -O -march=armv8-a+aes
 test-aes: test-aes-main.c.inc
 
 # Vector SHA1
-sha1-vector: CFLAGS=-O3
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+sha1-vector: CFLAGS=-O3 -Wno-stringop-overread
 sha1-vector: sha1.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 run-sha1-vector: sha1-vector run-sha1
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 99a953b667..6189d7a0e2 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -61,7 +61,8 @@ endif
 ARM_TESTS += commpage
 
 # Vector SHA1
-sha1-vector: CFLAGS=-O3
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+sha1-vector: CFLAGS=-O3 -Wno-stringop-overread
 sha1-vector: sha1.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 run-sha1-vector: sha1-vector run-sha1
diff --git a/tests/tcg/hexagon/Makefile.target b/tests/tcg/hexagon/Makefile.target
index e5182c01d8..4dfc39bc98 100644
--- a/tests/tcg/hexagon/Makefile.target
+++ b/tests/tcg/hexagon/Makefile.target
@@ -18,7 +18,7 @@
 # Hexagon doesn't support gdb, so skip the EXTRA_RUNS
 EXTRA_RUNS =
 
-CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal
+CFLAGS += -Wno-incompatible-pointer-types -Wno-undefined-internal -Wno-unknown-warning-option
 CFLAGS += -fno-unroll-loops -fno-stack-protector
 
 HEX_SRC=$(SRC_PATH)/tests/tcg/hexagon
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 688a6be203..c769a7d69d 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -45,6 +45,14 @@ vma-pthread: LDFLAGS+=-pthread
 sigreturn-sigmask: CFLAGS+=-pthread
 sigreturn-sigmask: LDFLAGS+=-pthread
 
+# GCC versions 12/13/14/15 at least incorrectly complain about
+# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gcc bug
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
+# Since this is just a standard piece of library code we've borrowed for a
+# TCG test case, suppress the warning rather than trying to modify the
+# code to work around the compiler.
+sha1: CFLAGS+=-Wno-stringop-overread
+
 # The vma-pthread seems very sensitive on gitlab and we currently
 # don't know if its exposing a real bug or the test is flaky.
 ifneq ($(GITLAB_CI),)
-- 
2.39.5


