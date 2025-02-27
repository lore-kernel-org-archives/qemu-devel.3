Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFF3C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnee9-0000t9-63; Thu, 27 Feb 2025 09:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnee7-0000lm-Ai
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:13:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnee4-0002Ss-9H
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:13:51 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38f3ac22948so515163f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740665626; x=1741270426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qzJpewvz9X+JB4NWBVhEFyUkbwWtvrwjCE7+wIb8f1A=;
 b=rxUWWu5JYnjp9BmJIrQa946+XjF+1JVXS4ohI3k1gXnaE5MSIVrxUgyJRWf/WYTBo1
 qN4XqQIq00kE8GtyGtJ5daRDyTwGFfgvj1HVP9xglDqZGLfZKXZnPrLhIJVhMiJv8Twf
 LhCL3qNYTblWlWKBHE/bV8qPCx4SlEcvQaqXZRojPduKPWwPJL9L728VvLmcERU5We0f
 ymYWxCkgjrCxA8O6APLtCHNR0ngicpzV7vRCCfjhdr26Jd9/yB7t+PgcTwTMlYl8Yrh+
 2tWd2oFfPvSD2WKVtnA77mlF/6IbnBOwDdB0fvvoJ5iUkA+VdDTC/xvm8SjDjk0AgRL2
 IycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740665626; x=1741270426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qzJpewvz9X+JB4NWBVhEFyUkbwWtvrwjCE7+wIb8f1A=;
 b=NQzpgFaeO6As34YM8s8mHa5MTOgbfUlp4DCTyWZCAw7zIISYwI5d56XD+8GMBY1RtJ
 4f1dMsd8PPdxlNdj7Ab4iL5UZjml3hLp94sNxkJPXSuCC40AgXhc4sfULVBYjJVNtJfU
 cEczzJ/HWyWi22KbOEshg7CwbM3qUQ6kgc7i3d8pee3tCU66tZS0luBojOLfyzum8HMj
 srXZARlz3B6RyMs4kG1RSZIcPPg8ATWJGg4wz1vtCthdTd84Tgwwx5l8mv/nFH1SMrp1
 ZIxEJvIGz6y2RuX/qnmyi3XpYvaRYxP8mbJ/67pEadgCXh/1EhPVxadfCwWwu94aeKxH
 dJLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJyc34D4e30zzdpxkJOgOSL+wHBL6k2vBZJxfjd/LJnWkpl36oooAzbf26ViTPfhiclp8+wK3ZU7Bw@nongnu.org
X-Gm-Message-State: AOJu0YygyLktDv1+bvXDmb/005diGLNTFM2+/7cQfmv/cfuOGe0y7Q0r
 tkAfq/xmoz+c7qc1IjCAPwVYFUatn/hNTHaOM81HSA01ZW81WNeTwxr/kHqC150=
X-Gm-Gg: ASbGncsLSEKdDIkU+w2MDv7ritU6Cyig2+0ihk/sXdNZwrENpP9hlNWgoXPBJo5LYsM
 MBv+MsSX7GHzlDZ9R2MzNWj4JpThWtZYgoBnWFJNik3ZBwmMiLMaevn66zDz81q9IOccj2jeF9L
 WBtiy28hyv/TfLdx2YoMn22CFoUyQRz37Zq+Q7kX6+fw6fPew74QJnydxvi5yZE/9IOJpIN8KKn
 xDe/QmekxyE3b+7LANF3NEHMQZL7vZ7+Y0u9/oK1SXsz9dBzvSrYP6fn4e/ErD4AfowLoDnw8j/
 zYblk20FaraveJ6FfCgOxSxTSQGXxLn2
X-Google-Smtp-Source: AGHT+IEC3HLDlTAUEEd5q4LK4EsKjzPSas92qirYxdC5mCLGqvWQZlB7Y4+IazefhaaoW0UDCOaxSw==
X-Received: by 2002:a5d:4b51:0:b0:38f:2bd2:45d0 with SMTP id
 ffacd0b85a97d-390cc638d9emr7952897f8f.51.1740665625906; 
 Thu, 27 Feb 2025 06:13:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a9fsm2219764f8f.36.2025.02.27.06.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:13:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/tcg: Suppress compiler false-positive warning on sha1.c
Date: Thu, 27 Feb 2025 14:13:43 +0000
Message-ID: <20250227141343.1675415-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
---
 tests/tcg/aarch64/Makefile.target   | 3 ++-
 tests/tcg/arm/Makefile.target       | 3 ++-
 tests/tcg/multiarch/Makefile.target | 8 ++++++++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 9efe2f81adf..16ddcf4f883 100644
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
index 99a953b6671..6189d7a0e24 100644
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
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 688a6be203c..c769a7d69d9 100644
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
2.43.0


