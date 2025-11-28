Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AD4D116EA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 18:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vP36t-000322-GR; Fri, 28 Nov 2025 13:22:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36k-0002zU-Dc
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:15 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vP36h-000372-JT
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 13:22:14 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b32a3e78bso2028675f8f.0
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 10:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764354120; x=1764958920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1DGGN972COszVw0XgwjUe95FT8j0aUdcqd6miQIJWy4=;
 b=PjBfgI6MomUQ+0+iSSGbsMIVC7tWelwRuuZ9C/99vBBwpyyNwRAB3FdNviWFgDY+3j
 3RBw34W+UDzIa93g07TgOMpMqCZjP+UzujBGgJ3dqjUdiQpTvOqxQ790E69z9KYb4eBQ
 2T3vUBItcdeIb4Sa1ZN3thwpFVQXpBercoj5owwE4rT+jfDSoz3ae2Ks3j0psLVB4Vxl
 n+zB/w45rmZxzMmxYH0/g0hzMFUnhl+NoSA7Nf004fBDBrp/8MHHFT43p8njBxUQ1jID
 xMQMolxbZTJtTrhsNFM7ANrpaa1WbdDu+23J1RXklzQdSWOP4Ttfj1633X8bpL1af+Sv
 OCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764354120; x=1764958920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1DGGN972COszVw0XgwjUe95FT8j0aUdcqd6miQIJWy4=;
 b=ugz/E6GMTwQGJognqgp+j8Wg6VduLkUa4lOtLURYmVlOAq0v6UiJWQrDb9KifgGjr6
 +Qxp9gkyRhXR0KXnYDF4EHdctozwh7u0yuTRyxH9JvWJl1XnJmsuMc7EYz4bfpDcerle
 DN183mrO3UJIwdJ3hIKSu3r/CqA+NUy6jbup+TRUopLDeuPusPpI55e2kffigf7Fc1UT
 JNTbvhhK4xMU0siCElHJ5Rjm32zFpim7Qffchc9+InqjjLCDWvu9HQCu02dFCyd2z76S
 KQ03Zm6YkJkfk6Eo9qLHhSnCmAGiIiN43jKyNbuSfXfIVRFy2lZ5tFtHOA7lLIqcwSph
 ZLDA==
X-Gm-Message-State: AOJu0Yx2/ZeYatGtWZjaN/P6zwU+/UW1Vy+if2T1ZWQuFs43mOsJuy/s
 aEc+9M167+lwkW7p8gP5Or/mv4qE7gK68E37XUD5PgA8QcvdYUfRbca+lGPdrQuvwtA=
X-Gm-Gg: ASbGnctWsCRFJzIs0PBrh2WzZDc0Tpl8wAEYfEv/RIJryvNp9PkrkSdu9CPTPyc1Jea
 bvvdxJdinycmrJMTWcVAEPk0IFmByLv9QRLoFiCKkDPMjYBwokWkPEkVek/WIL4g72dr1UgjPvf
 s3asTbYxrNsjzUXdqAFV+uOPfjL0Wq3Y7wpgXNl9Lgcw/0SNEtGkxlmd8xFDrNq4qWwyw+Nr4Zr
 VUOJujRazkPQO+WNBAXPsR+4qCJGtQ5q00Tzf1ZbNjfd7lCg2t2IZIS6XFkD77JmryfxuR/Tdgi
 w9SFnTijSC9KPJczKGpl19jDBqlWJeEjlmDNJq7HZbzgNYdnoxwMGqJ5VXZM/na7+r8N+nTzKmO
 PiH7hKH0Cf2f6fQUmT4P0c1pdo80qtW2vtCZLqfl35LiXkniuwwwMM8pA4AVQHzbgRPa+hnMuep
 CV5Thb0HQ0gNauQ/0tw9Tmiw==
X-Google-Smtp-Source: AGHT+IEnIZBfOdH7h0Hh53uTrnI3vcLTh3LFkAu9RTvy0bbzoYigwm2w+yYI28QOXog9Rkc5lWneTg==
X-Received: by 2002:a05:6000:22ca:b0:42b:30a6:9c10 with SMTP id
 ffacd0b85a97d-42cc1d22e12mr32401337f8f.56.1764354119628; 
 Fri, 28 Nov 2025 10:21:59 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1caa86d0sm10876989f8f.39.2025.11.28.10.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 10:21:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D6C6B5F8DA;
 Fri, 28 Nov 2025 18:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] tests/tcg: honour the available QEMU binaries when
 running check-tcg
Date: Fri, 28 Nov 2025 18:21:53 +0000
Message-ID: <20251128182157.4125745-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128182157.4125745-1-alex.bennee@linaro.org>
References: <20251128182157.4125745-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


