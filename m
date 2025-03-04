Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC9C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiV-0007IS-Rr; Tue, 04 Mar 2025 17:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpahA-0005Sc-Rc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:09 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah5-0006Yw-G6
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:59 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abf4d756135so606747666b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127093; x=1741731893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ll+J79NMjC+5QcVirstPzb5huPWXK0xa5gPo5OevAj8=;
 b=HjEuBsBxHJqkRjFNBveYKCBO+w4pYjc/VEZb+gL+QFB9aSkhujAbNdlKcKczHIixVI
 /7Qj4Co8RjTYxTpC3rxae9hVSFfj21cCVQb+iC/kmJVnPP2FXxGDk/I8lUQdJ0SKJdWA
 CWGNmfl9r6TVPmuqSEQqNQlmllb36WHZoylqVSF1ONrGg+k2k5wZBXubhnur0ammJaA2
 uIt5neYF6q2eBE99QPtO1K5yHerDBCOwF1EOY2xe0CsrtfO/vQ31mTB05BLA/bKJbUyA
 YG03aMonUh5s1yZKMRywCM3UOHoti3j760UJe6vzdD8i9j6Kjt3JP3kOWMG74Utiu8Pv
 iNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127093; x=1741731893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll+J79NMjC+5QcVirstPzb5huPWXK0xa5gPo5OevAj8=;
 b=Qs39BzuYDh474+q2l1BNvZ/tmLoaoTmLjLFX2PFdSSjLykC1LE/TrPCr2o3N8n3fv1
 1JUtF+/fKsOz64DWDdl5HwXV+0FOV41ha9vFJts+hTnpVqMqC6tGqgGb9Su/TIi7E9CP
 jqnq+jYLMhe5T/yNxFGFSCahcZlDeGAz4Lw9sQav67G48xhSa6k7yk/7FkcNo42GgUzA
 9b5MrCuU2ROXawEwptyNB9y01/DQyuD83tVFYIWHmLCimQoZ0N8wUiZszYbebJkkrBj3
 LWIdYzASYAEOkEBQV32GBc7zeWHvRhRdSg8uSeWJpt+T7ot/GY9Smn/pAyjPSKCGAx1/
 oFQw==
X-Gm-Message-State: AOJu0YzeplZ/xaZSbrBXck5rLZ0gybc2zZhsWSL93wvlezJM4ATXn0I0
 dmAS7TNU5HSYo+Q2FzunUU1/UT4MBTdZgWJnzSpuDU5UO+v1OZxAUjncsBe/K7Y=
X-Gm-Gg: ASbGncvqGOki6nHi9lcEgOXyPwNiytX1+HpspgMgFMZc3BgNEDyudEaCwNYjHv38VCs
 BZmsvBKs14meT8jXfBKRXsCfEOE/m+5Njyh5/x3mMu640Wgwmw9KF1IEqzXxsDJdu9ZgYXdZCrN
 p2h1BXAXbmpVwgkUL+y1a0PCDj8EPStci3L3/W4orRZt7n6fZLZwVVSG4MvBgCIwhh1Vb3MmlgW
 ULWy/Ld8wEhZHwgxN+Pm73pqIRXCJR0ZZGHIdFO8e3jZiBtpC1mGVioNTCqSphhbnRUZjKyOyc4
 QavZBaVB28Nwu21JUhKyDDQ+Anpsj+2Rm4x1GHCJb94wSmA=
X-Google-Smtp-Source: AGHT+IGIC4tSXetUPfBlOq14iNNWepsayQBWe7Wqd/hR2OREYogcVbsAc/AHMi3/lL/TfbUL7wh7KQ==
X-Received: by 2002:a17:907:3e13:b0:ac1:e00c:a566 with SMTP id
 a640c23a62f3a-ac20da97b7amr98887766b.45.1741127093456; 
 Tue, 04 Mar 2025 14:24:53 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf692b6b44sm523833166b.112.2025.03.04.14.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E28C5FCAA;
 Tue,  4 Mar 2025 22:24:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 17/32] tests/tcg: Suppress compiler false-positive warning
 on sha1.c
Date: Tue,  4 Mar 2025 22:24:24 +0000
Message-Id: <20250304222439.2035603-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 tests/tcg/aarch64/Makefile.target   | 3 ++-
 tests/tcg/arm/Makefile.target       | 3 ++-
 tests/tcg/hexagon/Makefile.target   | 2 +-
 tests/tcg/multiarch/Makefile.target | 8 ++++++++
 4 files changed, 13 insertions(+), 3 deletions(-)

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


