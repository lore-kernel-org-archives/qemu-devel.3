Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE3AFCB60B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWes-0004At-Hx; Fri, 06 Mar 2026 10:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWeq-00049D-PE
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:04 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWep-0002T6-0C
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:04 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48069a48629so97900575e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809201; x=1773414001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mP1M5gBlVb0DOzqQFi7vxvIto0M97Lt8KwvwGVINUDk=;
 b=sV0hmDSsyfJA2+SBQicr9FJUbkv4ZuFebjvaOpnZlTH5jJeai3gvvHSsXt8eP8r4r2
 sYOG3s7/PueCvbgM18G97JyHOlV/zAP3Uscsqui5NoK+MKGlyLzwq85iy9xrfjjnH+29
 hCZGHsNEy/lkaNbnNPoNyZXbhaRi1pzHzEaBZvhhrizD0iSvWY6jOjNs0o73GLz9qqCG
 NfOeHz0UySNiGyuYv51USuu8um9RSZy+T4u6seBTsXrWQlaGzSYw7f7kE8oWXqn2GpmY
 sqq3IGpzkE1rAcnfOrosLS5aoxEdiz7IIsf2PDJpa75Chk5guCtkfCuLfJUZjutYX9YX
 9IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809201; x=1773414001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mP1M5gBlVb0DOzqQFi7vxvIto0M97Lt8KwvwGVINUDk=;
 b=b3RV3/kqXuHLhnVJNH262k9BjQRsgOP7omPw57QyLdpaVlyC2ynqqRO8rAINApEzQh
 /o2Z10LOkPvSylMyADLayP732NKfH1OKqOgPd/KHz35h5dqCTfCQOEzsA48rEQN3vMCm
 bTIUtAg2wz493SvBHSyhsBOCbeSsOiLBbb7ebnPinFbUJF5IWVVGjEQBidSrlyhcvvFh
 Okm3t9riByV3bXc247D7OsFP/96UJHdBXeCh+AKTHyjylYYDVVn/FfyUaIiGWFyF2qC2
 WKEHqjVBO6KU1rIXCkQVzAheV6Hx6Lto5sy6MRU2h/Wol2tOpVwv23gBNKJI8pF9tosb
 lFlw==
X-Gm-Message-State: AOJu0YwlD2cB0Z0kxW/IHGpHpaaK70N/3BYlGxkI1UaksVInBCeuqsLr
 MeSWq7fNBeGWJH0FAMzJ+jiitxUfD4g52YasgiqBCVhqMc8iJv4bqB+GF+I5Vet0RGui1n+eqEA
 3cYbs
X-Gm-Gg: ATEYQzzvE59jjwztWcUOpB08XQzMevd0MVWTMIH6ifDwXmhsnO++r7VHQ+4/QMbuCLd
 X5UMGl3ag+e/y6n7er+ox3NL21odUCulvyRb1iT+2IO84HViR0mdgBvegsBXVIZ4seg9L7HWqfn
 HJlGt9KbrELX/Dhg6xxWdDbw6cRM+xOlZErZ+vJLjSmDC+gNIi2jaTsEhuDxrt2bT1xKqrzeQlX
 zhJx+j8aqLz0Njx22M2Lu2b5VHItq011PK22wCjcL1mW6FmySB6aqJu8r81Hw2GhpgbBKYFhCIi
 kfThUOGkR6nyg7+fT9zXFDjaJgsV6+d0CefLYJMZ+7mAGu0h1+IsIujy1PxrfYAeFpvOo8FwkjO
 MZsXbpFlbYqt/awbYzVITkdkgFI3MoPe9GtWZ/UjuvPsFf5+0xanPZsSiCbbpA+nsr1fyKGwVvs
 uQYq7LQE/RicQVoAkXzwZ9p68od+IzJtwevChS7lJpvXpY/ggsie4kd4eaYi2FOEiqRVw9Vag6/
 A1wzHzDbM2znFaqF6va51zP+TbHt0k=
X-Received: by 2002:a05:600c:46c3:b0:483:47ae:7c00 with SMTP id
 5b1f17b1804b1-4852695aeaemr40385375e9.20.1772809201402; 
 Fri, 06 Mar 2026 07:00:01 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/49] scripts: Move lsan_suppressions.txt out of oss-fuzz
 subdir
Date: Fri,  6 Mar 2026 14:59:11 +0000
Message-ID: <20260306145939.2162189-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Move the file up a directory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Yodel Eldar <yodel.eldar@yodel.dev>
Message-id: 20260302092225.4088227-2-peter.maydell@linaro.org
---
 .gitlab-ci.d/buildtest.yml                   | 2 +-
 scripts/{oss-fuzz => }/lsan_suppressions.txt | 0
 tests/docker/test-fuzz                       | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename scripts/{oss-fuzz => }/lsan_suppressions.txt (100%)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 6ad3594522..4b1949a3a5 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -614,7 +614,7 @@ build-oss-fuzz:
     IMAGE: fedora
   script:
     - mkdir build-oss-fuzz
-    - export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
+    - export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
     - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
       ./scripts/oss-fuzz/build.sh
     - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
diff --git a/scripts/oss-fuzz/lsan_suppressions.txt b/scripts/lsan_suppressions.txt
similarity index 100%
rename from scripts/oss-fuzz/lsan_suppressions.txt
rename to scripts/lsan_suppressions.txt
diff --git a/tests/docker/test-fuzz b/tests/docker/test-fuzz
index 7e506ae1f6..d2bdc8afba 100755
--- a/tests/docker/test-fuzz
+++ b/tests/docker/test-fuzz
@@ -18,7 +18,7 @@ cd "$BUILD_DIR"
 cp -a $QEMU_SRC .
 cd src
 mkdir build-oss-fuzz
-export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
+export LSAN_OPTIONS=suppressions=scripts/lsan_suppressions.txt
 env CC="clang" CXX="clang++" CFLAGS="-fsanitize=address" ./scripts/oss-fuzz/build.sh
 export ASAN_OPTIONS="fast_unwind_on_malloc=0"
 for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f | grep -v slirp); do
-- 
2.43.0


