Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE92CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU5M4-0007uk-Fd; Mon, 01 Jun 2026 12:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5M0-0007k6-51
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wU5Ly-0002R7-Bh
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 12:19:03 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490acbb0f89so5502775e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780330740; x=1780935540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMnpq0n9C5upTOfyyP7BckpHsmDt5zcCCTHsolAePQQ=;
 b=H5FFaYLOvZQ4TmbvcOXPThbmT2UvEtjY/nA+jwX+rVtWZq3X6YDdcgN0kCftiPsHKg
 cD8j5A3uzsklr4xgTDfn7hyOWe+X5zV6iaXvZ+alvqf2kGLeSL2oDbOFqximicui9YcY
 2Sx5KKCXmiDjD09dv26eaf/6c7kbBMFknMJUKp8SBmM3MGteDOpNUaZbw7N32C5UCySq
 8OzDIl9aVhrOkK2daDgxZ+YEUii9x57yKlw+igMDPQ29x12Q/hO2hW1Q8i+W3L1eaNKa
 o3sMRkfEr32wC4FS2YfdPjJfRSqc3N6WRq8J2/THwZq/hdM5r3Exq05JdSHa7R045RB+
 HOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780330740; x=1780935540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CMnpq0n9C5upTOfyyP7BckpHsmDt5zcCCTHsolAePQQ=;
 b=NHk563Ar1luXeBWppla39LbaFtXJE1J2fW4+3JUebf50ARsgCn9qXU+NvnEQb3/FNy
 ha33wfSYVBGc/GPBVlDT+nlRrFkuMknBbACxJRyYzGLKG9zzYUjMmCF13U9ii/nsyd9s
 7NsJ17Ydk3zJlDp+yL6jRsn9bubv3NcbLK3BCoIc2Skn5qeEff7LItK9cYZ1s9cKBD0g
 qyJxr+8cQKFvkfhH6svGG1BQtBCmB6yLpyn+bnR28MpzocO1sW4ESKvTvjE6SlCgfP8Z
 k8k/4QNaIS60urKFOkSeIJ6bQzEh201JonJnFKwtNtPT/xap+hBZ0qVRzpQlJEFKJB3y
 Pl/w==
X-Gm-Message-State: AOJu0YwMrYtgL1+iIkVnp2rZ09flpdORdYUhQM+S0a7I8V/fTXo0fb/J
 dUz6xkuHUitSByOkNVv2NC2GpIusgTpFUR/nZo7MYSrocmrU1wL4Gxcjitia4JRuIlQm7cJLfph
 SZmRt
X-Gm-Gg: Acq92OFq0xFzAFty5t6HZuFLUXQ3XG5jhhF1AnBKpkNbGMla7taZjRcp3vGI0dYGUZy
 e9pdEUa+hfr+xIVU09nfpTR2f3E3LwCvQFksn8bpPr+J3VgX8iwkaMYqfv3befNfVPMbywH5eub
 b/dPuVWpgNtgAa/dVLsPF0Q3kTF8O2kZO+/L+OEtKcxAQdkvcPiphKD9wbyxmyshnhPhXVoBi3R
 3fTxes/sIlj9oqr7BI/CDvnB/4yzdr62k8eYNWJa3ckBTawAkagk/Y4n1ctFsl0CeBAWR4vEtTo
 6o6pC8oiunKvDDAqodnYEyvEEI0F7h0q5xmL24e7TU2a+Z6ycEc86tZl/gdeQCgfzRrSdkdV7TP
 PbBMT837H+VVWQstJTuFLdGnsyIq3DkC+6vFzHpg4HXEwPuL72olFfktXK8Aqwot6eplDUWTYrk
 4315XPeS9+GCTz0jshvZM3Psq8+a7dqhH02frK1ch8NnU2
X-Received: by 2002:a05:600c:34cf:b0:490:5e2a:f924 with SMTP id
 5b1f17b1804b1-490a2900e81mr189474235e9.7.1780330740538; 
 Mon, 01 Jun 2026 09:19:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b0e823f7sm2381685e9.13.2026.06.01.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:18:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9391B6016A;
 Mon, 01 Jun 2026 17:18:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 2/3] gitlab: work around the inability to build targets for
 MacOS
Date: Mon,  1 Jun 2026 17:18:57 +0100
Message-ID: <20260601161858.182286-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601161858.182286-1-alex.bennee@linaro.org>
References: <20260601161858.182286-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> # running tests on an s390x
Message-ID: <20260601143129.144786-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


