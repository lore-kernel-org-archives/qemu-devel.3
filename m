Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8D8CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3g1-0007fh-Jd; Mon, 01 Jun 2026 10:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU3fz-0007eg-7K
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:31:35 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU3fx-0005v0-IW
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:31:34 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bebde89cfd3so220240666b.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 07:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780324292; x=1780929092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCtNsjmQslyB0RdDx/tiQHHKKU/KczkMtBa9QQ2aWcs=;
 b=atYn4rX+a1Kz40rdwn/o2Vzd9WemPZNxFaXdh+UV+qF3J5DNKZqOzHenRUTt4ijnHd
 YGUKtexdGTIJY4/ZMgsIWkF4RFrJftEWUcmsndAXY2qXG01gfV6efgw3H8ENXkSJslgj
 KU19B5CCC9iOVEdWeCWQDCKIZshHzYeLcagZepYhywb72kNMgeVZp+q3QNZLADaLeArL
 z7g/Fg5PNUtE/GCS9Ohq/caU4i1haAIz2io1GflkOXZuIJ2jx65gq25jSep3zIRNP4rG
 /T2BVaEl8anxzsbR2setFOrUq/q6z+uYLcdS/uAV6mQQJvdYTCwZaDizvYZRkuEXumi/
 YaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780324292; x=1780929092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCtNsjmQslyB0RdDx/tiQHHKKU/KczkMtBa9QQ2aWcs=;
 b=tPKg4ArQp4Wh5vHEYh0PSMbleMudZMeMkSXv+LQnrjB8WT1ByG9sypm210jHMlyAON
 vvAacc+lgYcuuMIU4ZrftqMDBWXY6cwK1dDmQ/0F8oOKrKI+LUn8/2rvF21vI5I9516T
 hzMxtOqUJVjnLJm+sX7i6lmsoX4Fn1LK9S2zBD0/Lux5f9b/EukFHDrGc+JI+Ioo66e9
 cJxbN+vwxfpqVPcNRMM/6gNLDKPoBwcMHHe1s+q41kPucA81fxpbGuPvK9/36CTAv50q
 AGi3yOiky2PQbQh4VjgdBgeAMukdYyRaP4eSq1rMiN4udspzES1DkBxywCsmtnDmHA5G
 5JMA==
X-Gm-Message-State: AOJu0YyYlZ7oqCp21wq0Z2me2x1vtz4wKIybgqGlBfdjk9OTxBxAYsp/
 RaqviRnSEifUpO4nQqGycosecaSAdhtAzVzVMY6wRRx8XX05yqErKAOJghikRdnO/yU=
X-Gm-Gg: Acq92OFutuZoSXCwgkFZJLCGrVVKHnm9OCWlwWCUptE6+xneoEUPFYPwL2O2HDccU1W
 GALlJMYJtdt8aaGw4cXCfgq+jGDaZXgVjnLpseQG7p+5VMCW4Ptj3GNXvq+EOqCIAnHFqMKT71g
 dDvh4Bf6UPBTS/6Lx19x5ixaE1uI4mn4BNXNxhrJ1/Mn5pK3h+AfQUiZQo/qRQrsCCaMMZPXV0B
 mgPNfflzDSdI3yX5K8Jmprf0qOzbGZPrkoQBITtv5VPhaGMlmiWopPd3OETlHcA61XvL5IEcGCu
 /UEqAa7CmA2DobtX5NO+2znilAoT+UI5VWEoILDh6flUUjEKZqytT9H9yO48J/B3KNotWXvkdRZ
 VZX9vseyeNmMaSsuEk9wrQCfp84+TzJmNjz7Vu4te59nSoq0pxGVtI3AKbHXzXGIZSkyme6d6ut
 VvcuZiyJVsbMhHY2qwtla3wakmWmE+ENGqLQ==
X-Received: by 2002:a17:906:fe41:b0:be8:c839:3c4f with SMTP id
 a640c23a62f3a-beab2081b53mr639855566b.23.1780324291536; 
 Mon, 01 Jun 2026 07:31:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25510759f8f.18.2026.06.01.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 07:31:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0D7926016A;
 Mon, 01 Jun 2026 15:31:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brad Smith <brad@comstyle.com>, Warner Losh <imp@bsdimp.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 2/3] gitlab: work around the inability to build targets for
 MacOS
Date: Mon,  1 Jun 2026 15:31:28 +0100
Message-ID: <20260601143129.144786-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601143129.144786-1-alex.bennee@linaro.org>
References: <20260601143129.144786-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Unfortunately a previous fix to ensure .ninja-goals was set for the
TCG tests broken the ability to run check-functional-FOO. As we have
now reverted we need a solution for the MacOS gitlab run. The simplest
is to add an explicit make invocation to build the signed binaries
before we run the tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/macos.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index f61750a3f4a..8366b4ad564 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -29,6 +29,7 @@
     - cd build
     - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
     - $MAKE -j$(sysctl -n hw.ncpu)
+    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
     - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
 
 aarch64-macos-15-build:
@@ -44,6 +45,7 @@ aarch64-macos-15-build:
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
+    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
     TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
 
 aarch64-macos-26-build:
@@ -60,4 +62,5 @@ aarch64-macos-26-build:
         --cross-prefix-i386=i686-elf-
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
+    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
     TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
-- 
2.47.3


