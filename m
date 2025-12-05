Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77629D33995
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 16:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRYs9-0005U9-Pd; Fri, 05 Dec 2025 11:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs8-0005TA-7v
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:32 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRYs6-0005jR-Dw
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 11:41:31 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-42e2e671521so1528989f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 08:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764952889; x=1765557689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQLx+6d6Ez6DsIvWmne01CEnlhyk4EppoX8NoUOZaGM=;
 b=zzzhzrspZBaUOEL7UEGWz2NUWaqQLhj16KlD7dfVh8JAPwvmmHCxg5VtIGPKiAJ+se
 fFch/dZzoKqOvoJOUrrXGWnrkou7wYXy9g4tdK8e9NUETt2hZ9rPU/5XlsZ0o4shw2+r
 hucmHBqVg2pEyJlDcc2fChTyw6Ajv/UUjfeg3dayIZIvpG58Y/2DpDrwbi6TL3R36Ueu
 yIR4jeCSeg2cTji7GWpVq4+y7OvBlBG06ihLrhohSOHzyHD4yfIYOBI0zTT3Lkhx7yce
 3IkOnSVWjOKSZCZE/XC1V1DHtXc8P2eSdAeg7dbVff+vkcGlpXbx8Ok5Fb07ppzLOJJT
 l06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764952889; x=1765557689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yQLx+6d6Ez6DsIvWmne01CEnlhyk4EppoX8NoUOZaGM=;
 b=VVzX3Q4jqj8dKuG1RBVp5D66EYpzODwmFw+xbM/hfaw99bMrzZEhVazR3MII5IWwft
 g2xcjVsFgoqbfCVb591QTrQ8cm2a6Iqy1ZW9UkADF2P7ngawUS5T2GItcU3u7+WwC4FK
 kOnYQN0XICin2ONOOJc/N5wp9Z2fiuLhhVZlyfwsHrTFoOuS0Ns5VF+hZOZk2IPIDJ+/
 qVSBpx7F5YQqdEA7K9lVZ6IT6SHLYghTIoMF3HSXAFVBJZqqfCgHfJcd5100x/ktkOfn
 ApT8qDGIsEtFJaG/3qo36cOmPBXt/SUp85hEOp3PAKqeilE0NL1wOK1Tfv+9VOMmAgTb
 Za8Q==
X-Gm-Message-State: AOJu0YzYgtPBll060FttP3HBgdrHrTOePrLWVH95Huu6Pecolv+L2e6x
 o5/R0+433llCWdYYyIvxGzHlFvMNpKw3MgZ3d8uKnXVrXnwX/Z+TgV7dP3Vyue/NXuM=
X-Gm-Gg: ASbGnctZNt/6aZJ/X4RFWahezYtG6A8tZ8wDL7Kg8aOXrYAJpNq2j3KblElC61k9N56
 nnMZqFeUQ9vcnIOzL8YCnLXKcVJS9Mhqnz3SKhnmZFz+ymoUmjWQViPG8rDnNwK1AfbZ+c2bT+P
 2zofa9vOtzvobMMJoqVUHKG7kO1orbpeR+/H4W6BsoFTWtUCBhPTY5BZJjarJuyDFu8hUCyixV7
 c9cccfHa7Ykx2dhzM+Ohvck4KPcUi/HXJhap5h0JFvflhTcuARF2bQn5KF7cEjH8WgqHaGvwcms
 8t/9mknPJs4rGeHcVwPMqNd3B8RiAeuY7fsCIPqRjnrbO8nqhfrrB7Wc3IEhP4QLPlVJ4audnZh
 0QFJCruXCxYg96Zk9z5jigvSyPveRi2b1OkqpqM5HOgu2hV17VQ0nwUUhtZ13sCKTa2QTCcBXEz
 kovvzIer7tvmc=
X-Google-Smtp-Source: AGHT+IEfELTYmQxf01Zxqee+JZZIK1xmmHzaYsOBFzGvBRLyY1gKEJ5j8gvI3Y+c6GrLEEAV7cUybg==
X-Received: by 2002:a5d:588e:0:b0:42b:3220:941e with SMTP id
 ffacd0b85a97d-42f79800e4fmr7657135f8f.19.1764952888625; 
 Fri, 05 Dec 2025 08:41:28 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe9065sm9601141f8f.8.2025.12.05.08.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 08:41:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 56DBE5F874;
 Fri, 05 Dec 2025 16:41:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/14] tests/tcg: honour the available QEMU binaries when
 running check-tcg
Date: Fri,  5 Dec 2025 16:41:15 +0000
Message-ID: <20251205164125.2122504-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205164125.2122504-1-alex.bennee@linaro.org>
References: <20251205164125.2122504-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Message-ID: <20251204194902.1340008-4-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


