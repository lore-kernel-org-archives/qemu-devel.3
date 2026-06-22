Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4684CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbgmY-0004hq-Bo; Mon, 22 Jun 2026 11:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmL-0004fv-WF
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wbgmJ-000684-7K
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 11:41:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-462cdb88d01so8621f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782142897; x=1782747697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXzDY4utHKIBDOi85XqArdivahwjfqST0fCeGtTbvGs=;
 b=A+O9QqbdX4rBQvXp2AJIUKN0VY95wAdw28QSPi2hg6H7rizWvvzBiPxfArRgi7x8Ba
 YvxWw1rSkgQR2Hm+BkOVr+5azOr5QyIPspFngB2ARqxs5BS6u94P/8QMjjyt7lE6Zodm
 DiM2LZiDfd72AybgFJcQJ1t8Tt2ytUULKHfGWz/Qf6We7EYGcQTH0wJ37//4xJXRF0fa
 QKE2TyCTAjo7ooLP44HRZwm4A8AJNUZ6SwlvE4Lz1PZMgXpdGAS5iUvY+Oa0mKNgNqdZ
 Jdb85K64utjbgoS/6/OCsFMeHfDfb7vJyRMRGIUU1HFphNKgqxd45UenyeLXr5FvnDi1
 IWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142897; x=1782747697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MXzDY4utHKIBDOi85XqArdivahwjfqST0fCeGtTbvGs=;
 b=TznY72hIe40P7pyPIeybLNOFDjTvUYN/7Zphj5dK5JTZKOuzzsQhEMQY5oOhcJl9oa
 GLiRrwuPGmawLh/hZwCjG1Anb/9zATNu9NUHS9o0FCZuwpnM/+aSqHCVQbWPMKkHOTRC
 Ev8AaKG8ZlujHwWvucBGMlmOfXRBAI+Le6Gpqf+X8CGAyAZ2Q8dHxkFvWZHUY5Pt6YQi
 CBFvVypGHch5a7j/ZKHrWfEGEUru6jqJ/c9JmG7tEyRxW/HE5kPcU4QI1xB6YQBOQ1Jb
 zhcVAKl3yFAchn5yFQsTIa2iIDG2tzH0RegSZbwYkNQg/h+MbeVhcHLFhCaK/GlKcKGE
 o9Qw==
X-Gm-Message-State: AOJu0YzV5/jFooS8NjhHnyZE7ksjVx0vN0cEztHzwnzUcMpzV+ReOAJD
 8Hkl0/DZ6mToEIZ725lbqj3Lg7B54Qe0e7vD6JIUzgti1pxgr1XdavTgnAin0bpr0nj4mXLmiGJ
 u+/REHao=
X-Gm-Gg: AfdE7cmBQwgGFZ6GD4UrLCJVVD1lEh//fKyfEQtR1F0NHmIlwCLjWpoHLrN/E3tjfQu
 gTbmTiqSXICEL5cR3vK1Oom6X2EJEnbsgZVxddznShW4NNUNxdR+FKg8HoxQyrouqjPhxkJmx3T
 2Tv0/ZzO9nM6GWbI7UmiqYmmTrXsevPk7MPaf/658+xG0UvOCs+i9idZHWmEJsKDBVGfN8GuDZ8
 JpEa55b5JUka079ALxodMz2xwzd1fB0jUQPMg+Ylgb96mOdl3MV9qOgOCEdbpgOG3MKGS8BL+XR
 ylLqRlHo1XGj11oN20+QM1bCSLtS/7rHdEJ29e49w03V4BhvME8bVsc88qQno0NQavio9WvOYpw
 KgqElh/7eN7YstwY3eC6kVn0fDh3yCkWtlgKSn9RWa/gSJJk2KV1InifgLN9GLm8xPOQz7gXWka
 m/LdXgmTd48VC8fVaxiCw+sIk=
X-Received: by 2002:a5d:55d2:0:b0:452:bc74:b129 with SMTP id
 ffacd0b85a97d-46a800fcecemr21482f8f.16.1782142897447; 
 Mon, 22 Jun 2026 08:41:37 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c698dsm29662226f8f.16.2026.06.22.08.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:41:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD3645FA2F;
 Mon, 22 Jun 2026 16:41:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 6/7] gitlab: remove build target hacks
Date: Mon, 22 Jun 2026 16:41:30 +0100
Message-ID: <20260622154132.3166748-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260622154132.3166748-1-alex.bennee@linaro.org>
References: <20260622154132.3166748-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Since eef29e060dc (meson: build macOS signed binary as part of the
default target) we should be able to do a plain build and everything
just work.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260619155657.944220-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 8366b4ad564..efa0fb666e2 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -29,7 +29,6 @@
     - cd build
     - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
     - $MAKE -j$(sysctl -n hw.ncpu)
-    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
     - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
 
 aarch64-macos-15-build:
@@ -45,8 +44,7 @@ aarch64-macos-15-build:
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
-    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
-    TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
+    TEST_TARGETS: check-unit check-tcg
 
 aarch64-macos-26-build:
   extends: .macos_job_template
@@ -62,5 +60,4 @@ aarch64-macos-26-build:
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
-    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
-    TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
+    TEST_TARGETS: check-unit check-tcg
-- 
2.47.3


