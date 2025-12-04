Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239DAD2A521
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKB-0006wL-8h; Thu, 04 Dec 2025 14:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK9-0006vS-Uu
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFK7-0007Ks-Na
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:09 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so10628215e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877746; x=1765482546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DGGN972COszVw0XgwjUe95FT8j0aUdcqd6miQIJWy4=;
 b=Tg6Y57zSqIVuaQSyRDpmqUlRc9U9F2GC8jxoceipJgQm1cgfBfaHns4CKrfPuu+kws
 Do/GxUz047v4HbTt48RaSbxSS5awrC/nRkVhmoH8pWGNBmqRyGVzz4DWTCaVV00Ry76t
 GtqvMtWbIKpM0PRj+PG79lRJNmOy8ikgGrFifX/9PGqw1rli/jmKEBnxO/6rWQ7lR1hI
 vLTjwq+01jCDaXAmTmT1ltSciHzsKC4q5WFOlzFe12gEUbTuR/fy+OBV2SpEZXV40LXI
 apasJJdcNTd+eltxyLd0rvsHbyHs1fzvObJBj8MiF644ndd+3qmiqB80tKkdofq6Cnx7
 f6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877746; x=1765482546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1DGGN972COszVw0XgwjUe95FT8j0aUdcqd6miQIJWy4=;
 b=C4SwUbz9+kJMGGIAL4T8PGcBLjQ8LVDlpFyvQiiUie8v/PSNj47Jm91JG1xVt0CwpA
 1O5SMssIsheLosJr1QPe04yiQdd/RhWbh/AG2NamqKt81stvv28A0gzJn+Gpi+SNgEdg
 tW4JfhsMrrAYQNAbVvOX9/H7aLfh20g324kJgn7RpxRbEs12LCt348E/kDqsrZU0VN3T
 ibaFyXbo9IzWYrAP0OSpo+dmXkFulrjtzHmg0Z5xDwpMY8WUoo4xjPTF/3UrmCm9o+8Z
 EWvBpKqOkcNUVh2wpQFFnMzYpIq4+FVf2zO5pBfN8yIwzRtXlfvYnebQPxrdSVci/kkd
 h79w==
X-Gm-Message-State: AOJu0YyQMCsc22c8ilf459qFtr28whuR9qgPlJGeJuv36tPTY66DJiFK
 epZ/MRnEXlse9P5OXi6UU42knz2wJNL4sBNfbtMrfFiBmFyjvxgdWozHNz4o5Zt69dU=
X-Gm-Gg: ASbGncuN9x1ysNqMkcidNJbeqoSyu7QJZIcprgbGroEiyg7by3hNGHoGXhHAkwc7bfL
 hpNtetlWH/jRzQqRKFkY1n8HmtOb2Mqoysy0azRksND9rmPQnf1IqCEA/vZN13/PWocrQKtNAL3
 CiKIX/aZwgtrSOWAPIu1pNRVF2PVqajTGtuHzshB1emFR+2d3sPswfQH136gt6I6E+W+RBefTKF
 FcTvwDprrTP8/yKfIXFrExEkYnN80aJPkYP0UvGH/y/qOdyCzPDKyu0v2vZE6FKB/IU+h+p+uLt
 U9vl98h889i4Y4Ku7Cha0sfdGRWHi8544YPjtunk2HVV7RX4fQwaPy2cO8Sjd+gh/vylb/elqO3
 7bMOfApVoOy65uw7BTnxEkYTNXlVQF1k2Z+BOG5vtX0ypYdUy2rZso8ZMTRp/CvfyYvSZYIei2M
 1ocOdHMVzKD64=
X-Google-Smtp-Source: AGHT+IFurzqHPekD+t4qf+2sW7hU2drF4k8ieyoKPzyxMEU3eNqA8rhmYcE8dfftpa1ZnK1aWosa7w==
X-Received: by 2002:a05:600c:220c:b0:477:a53c:8ca1 with SMTP id
 5b1f17b1804b1-4792eb72df2mr34162845e9.14.1764877746192; 
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm4976216f8f.22.2025.12.04.11.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:03 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E993D5F861;
 Thu, 04 Dec 2025 19:49:02 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 03/11] tests/tcg: honour the available QEMU binaries when
 running check-tcg
Date: Thu,  4 Dec 2025 19:48:54 +0000
Message-ID: <20251204194902.1340008-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Currently configure can identify all the targets that have
cross-compilers available from the supplied target-list. By default
this is the default_target_list which is all possible targets we can
build.

At the same time the target list passed to meson is filtered down
depending on various factors including not building 64 bit targets on
32 bit hosts. As a result make check-tcg will erroneously attempt to
run tests for which we haven't built a QEMU.

Solve this by filtering the final list of TCG_TEST_TARGETS based on
what actually was configured by meson. Rename the variable that
configure spits out to TCG_TESTS_WITH_COMPILERS for clarity and to
avoid larger churn in the Makefile.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure              | 6 +++---
 tests/Makefile.include | 9 +++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a2f66f7ff9c..82cace1bc95 100755
--- a/configure
+++ b/configure
@@ -1801,7 +1801,7 @@ if test "$plugins" = "yes" ; then
 fi
 echo "PYTHON=$python" >> tests/tcg/$config_host_mak
 
-tcg_tests_targets=
+tcg_tests_with_compilers=
 for target in $target_list; do
   arch=${target%%-*}
 
@@ -1852,12 +1852,12 @@ for target in $target_list; do
       fi
 
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
-      tcg_tests_targets="$tcg_tests_targets $target"
+      tcg_tests_with_compilers="$tcg_tests_with_compilers $target"
   fi
 done
 
 if test "$tcg" = "enabled"; then
-    echo "TCG_TESTS_TARGETS=$tcg_tests_targets" >> $config_host_mak
+    echo "TCG_TESTS_WITH_COMPILERS=$tcg_tests_with_compilers" >> $config_host_mak
 fi
 
 if test "$skip_meson" = no; then
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d4dfbf3716d..7728098981d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -37,6 +37,15 @@ export SRC_PATH
 
 SPEED = quick
 
+
+# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross compiler
+# support for, CONFIGURED_TEST_TARGETS it what meson has finally
+# configured having rejected stuff we can't build.
+CONFIGURED_TCG_TARGETS=$(patsubst %-config-target.h, %, $(wildcard *-config-target.h))
+
+# This is the intersection of what tests we can build and is configured
+TCG_TESTS_TARGETS=$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WITH_COMPILERS))
+
 # Per guest TCG tests
 BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_TARGETS))
 CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_TARGETS))
-- 
2.47.3


