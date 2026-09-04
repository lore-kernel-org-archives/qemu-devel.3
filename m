Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A30DC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TtF-0005Tu-J9; Fri, 04 Sep 2026 09:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtD-0005Se-1H
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:31 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TtA-0008H2-IX
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:23:30 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48436216a98so640913f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788528207; x=1789133007; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xBL1dwIo1O3Rm3Uk0d8syVkzhoSlMuc41jFN/JAGooo=;
 b=K9KJHXf/EGwPytvCgdx0JmJgNLHOWX7Z3bytIDtWmJ4bhzXezaHE9miRgNyK4UwvfF
 WkJzEUSK8auwmYVAzCk00Ycoj7BCl9mqcekWpR4bonCARwQF13mmQhltgpiT5TBPNs39
 MoU7Q5lsgEJf4oE+ajhM7KG5DH6mLM2BlUvWrq3gektFQpBaKTFDsAUNX34kDZQGXSA8
 nz0uyApXdZRt/CZjZnxcA3n8D9299UQIQ3HLZX8AuV+Dh98zafTjpe+hwaZxYe1WYkur
 70EUoAK5orJUlKocQ2jIe3wE63bdh36Cuj2srAn/7Wcu5/j+AtjxuIehcu4q+0GIf9Ow
 eLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788528207; x=1789133007;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xBL1dwIo1O3Rm3Uk0d8syVkzhoSlMuc41jFN/JAGooo=;
 b=hAJrG0FwxD8bdv6QqbNM4mqsY3yVEBQiFkM+T1AoFdREZI+8qVIRm4yB2+h8+8Ovn2
 WY3aL8ZCoC7e+q4tz4uyzJa8T5neduHmvac6hW5oGfpAFwTN+Oduw9l5via0yTCgXPB5
 YAYUTjP7/C2USWAie20TfQ/c9et/Nc84aE4vhsgHkd8MSCoqHB+CWTwWyXsDISI/cTJp
 hO6Y+LOf+9JUQ6g01jjxRxE+AfCfHAbcpGl+ptcl7i9U3d04NxMbGJdkKaXMjlG1VvXD
 mc1W4Vt5PIIelAwcoHYl+eOxqqHmQ7wo4OOkrgzASGvYx7DWikFp2eYOTuQtXjbhofp6
 9c9g==
X-Gm-Message-State: AFuF++mcHVshaZF7ljzxx24qYy1ikgr1h61mkT+uO8rxaWKdHYIVU3wX
 s2w5n9Dz1HZs80jVs5bQfkn0i5qNvONuq6fiKnZiD472FDrboKmXS0KP3ipYLK4dejY=
X-Gm-Gg: AYBFou3PoG6h5CVXMwcNhLCwkG/63w0KhVadnRHmCNgJlbQUx5DPFI/Fju3Wu/+nAxG
 wYfSCAysv2no74gVoQZfDTYA+PR2Zj8krYjbdq/qDgsOTEvs+7a2xIbwEF8AQV550VEgWsDU3gC
 P/sxTFDgNB78xj098BhwKcm4YshKO4fUrJLuxIyZzljVFHKzyLyzVlwAjqw8hnZAZihmnlqi59M
 bXkJZAngFeAVNlp67t+C7zSb1WES+oLv/UTgBAqqlI/Fsfm5pNJFIhG5cqo7KSZvYiYdCvIH/FR
 vjFc6bdrpIDJxIxJHK1idI14YuLnaeax0h2wGDVoxAG3UZzElbYTWHumCU331x+0pSTUfNO2vIN
 mC9tr4ae/9KIDN3Bqxc3agYC/KzV63FpstMrEZNCqbp3NewzvtGWa4dQR/Gd3QzukN9uOURXeTn
 RS1nnoKgkXOMOUHatFFE7CR97nW2vfO7faDbYm9B4gAHEcCNdANhS4hWScr6nnNgwktHU8YkN++
 g==
X-Received: by 2002:a05:6000:1843:b0:485:8c17:9767 with SMTP id
 ffacd0b85a97d-4858c179a7emr3481808f8f.41.1788528206504; 
 Fri, 04 Sep 2026 06:23:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883953cfsm5413268f8f.13.2026.09.04.06.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:23:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6FDA761E55;
 Fri, 04 Sep 2026 13:46:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 104/105] docs/devel/testing/: update documentation
Date: Fri,  4 Sep 2026 13:45:58 +0100
Message-ID: <20260904124604.2207440-105-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We document how to build and run tcg tests with new framework.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-105-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 71331e64ac8..c64d40b42af 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -447,8 +447,8 @@ these sub-Makefiles, the resulting build is largely non-recursive.
 Tests, whether defined in ``meson.build`` or not, are also ran by the
 Makefile with the traditional ``make check`` phony target, while benchmarks
 are run with ``make bench``.  Meson test suites such as ``unit`` can be ran
-with ``make check-unit``, and ``make check-tcg`` builds and runs "non-Meson"
-tests for all targets.
+with ``make check-unit``, and ``make check-tcg`` builds and runs tcg tests
+for all targets.
 
 If desired, it is also possible to use ``ninja`` and ``pyvenv/bin/meson test``,
 respectively to build emulators and run tests defined in meson.build.
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index c6821a36d99..fadb376eaf0 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -13,7 +13,7 @@ Most (but not all) tests are also integrated as an automated test into
 the meson build system so can be run directly from the build tree,
 for example::
 
-  [./pyvenv/bin/]meson test --suite qemu:softfloat
+  ./run meson test --suite qemu:softfloat
 
 will run just the softfloat tests.
 
@@ -1035,29 +1035,40 @@ See :ref:`container-ref` for more details.
 Running subset of tests
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-You can build the tests for one architecture::
+You can build the tcg tests using::
 
-  make build-tcg-tests-$TARGET
+  make tcg-tests
 
-And run with::
+And run them for one target with::
 
-  make run-tcg-tests-$TARGET
+  make check-tcg-$TARGET
 
 Adding ``V=1`` to the invocation will show the details of how to
 invoke QEMU for the test which is useful for debugging tests.
 
+Tests can also be run using directly meson test::
+
+  ./run meson test --suite tcg
+  ./run meson test --suite tcg-$TARGET
+
+Tests can be listed using::
+
+  ./run meson test --suite tcg --list
+
 Running individual tests
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
-Tests can also be run directly from the test build directory. If you
-run ``make help`` from the test build directory you will get a list of
-all the tests that can be run. Please note that same binaries are used
-in multiple tests, for example::
+Tests can also be run using directly meson test::
+
+  ./run meson test $TARGET-$TEST
+
+For instance::
+
+  ./run meson test aarch64-softmmu-hello
 
-  make run-plugin-test-mmap-with-libinline.so
+Test command and output can be accessed by using verbose flag::
 
-will run the mmap test with the ``libinline.so`` TCG plugin. The
-gdbstub tests also re-use the test binaries but while exercising gdb.
+  ./run meson test aarch64-softmmu-hello --verbose
 
 TCG test dependencies
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.3


