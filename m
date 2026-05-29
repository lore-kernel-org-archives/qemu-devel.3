Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8ACCD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpxA-00022d-P5; Fri, 29 May 2026 01:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwf-0001rB-AV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwd-00025k-F3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:44 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49048e043e5so57060165e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033182; x=1780637982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oNbzeuHYqzJqPXTvToeml5tO5atWiLWRWSbBqwaggo=;
 b=KfLh/HJWt+oSNJfX4ACa0wG9t5CGaZe7FHyhB+df0EGMdCCA57uu1hjd3Xa66FEyn3
 8mT3Mlbxr1/UOnYhMi0xs3zsbCkD6aQfBejX2WkuIxjr0etRjng7ny5+8ksK70nm+39w
 XK+N6fqKV0tfzjqeCwduHvX5WCA4lUC4W/ENg4dhNk3pDTYww1fadaarRrib4eREfW03
 2+9s+dyCddy7BT9bZdYbiGwXHLbSqn9jxtdpHXQi4M/s5rIrxssXyJxo3oKUojGHrxa3
 t6eLC+Sbd9yrKWVoET7oqxjQ3iF5cA1la4aDcQaDaEVy+O+Wbn+q0b467rtRkCwcX20H
 naNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033182; x=1780637982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6oNbzeuHYqzJqPXTvToeml5tO5atWiLWRWSbBqwaggo=;
 b=hkDsJqMIG60YRGbgnPd/8LopXCn85PIUDolgpEb+RjzvNuHri8de1sBvG0CzXXCt0w
 4+cfZX5h3ZtfLBuFRVh1H5FfzDEK0wyCT/b2oWpUkJVnyeoy0ESfsOXcJ08dS4HSrwoC
 9uAf9FfCk+1Rx/XaNOL97Fm3rtdP97R/quYCaU0vptEsM4TptCy7bGCHGgXSlZehQDTn
 Oh1EnFRD9rTvoRGacTgePXvT0MlYF9SrecpAb0cQcogChi0HNOto2C87/HNvCsQWPzJI
 ObNLyn7QG7r45R/rLrTNlwAFiGkqzdIy6vpUMLKZUGicNmANRhUzFp381s9HxGz9dHQz
 lFQA==
X-Gm-Message-State: AOJu0YzvJGuK85SlkNJo5FS7gyIADYBYcVMxiAKJo4P9pTbYoc3WYHyk
 a6CCKZvhdaI1i0baiO/EGzheA346jRut4sumU4n4MC7/POuzyo3bB43oySG/Zui4lvI=
X-Gm-Gg: Acq92OHZQ/lL3QnqRCRNcFsSoyK17OfyFFqhDI7wdYm6Vy27cwIcPoZ8ig8HGer9Nx2
 vchhlQ/AYrFC8wVfZIt9uybMQd1rnB7PxCpNNjAhcefNhrZsxh9EsO0K/u2dndKbKhZt0LiUNhv
 qQU1HuLQohmkpzct4sGkIw3TQKpyuKtCRHu3kuqHmZRQy0gBNqPMu4rRaPWYtBllG275z110cLi
 9IYaWFdKP33Acg0UctxO293by5TwsIFr583eWlanaXDcsY4LdnY4bl3jECJB6DcTulXGa4yPVKX
 MwldH4LTqPOdOHhx2FWHyxcPAzdTyN8g1DuMcrVFPTSTChITQ+hMdfRj0GPnOwjLelDn9Pfka2s
 zHRo72E8u0hhtXoDgeAZ+u/a4aQ8Kmz8CmhZOCnVQnyZM+ukfh2tZvlsTptwDswtDpIIuIwYY5/
 jQqmx5h8tOMS+t/VvAM+lRQAo1Pp0FI0YwYg==
X-Received: by 2002:a05:600c:c0d2:10b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-4909c0b34e3mr15162905e9.25.1780033181971; 
 Thu, 28 May 2026 22:39:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d696f25sm20156885e9.5.2026.05.28.22.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 94902604BD;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/13] gitlab: add MacOS 26 job on gitlab runner
Date: Fri, 29 May 2026 06:39:25 +0100
Message-ID: <20260529053931.283970-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

gitlab supports 3 MacOS images with 15 and 26 being the current
supported ones. To get ahead of the curve lets enable 26 as well.

It re-uses the same brew list but also attempts to work around python
configure failure by setting DYLD_LIBRARY_PATH:
/opt/homebrew/opt/expat/lib/

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260526110243.470002-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index c93bf12a294..f61750a3f4a 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -45,3 +45,19 @@ aarch64-macos-15-build:
         --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
     TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
+
+aarch64-macos-26-build:
+  extends: .macos_job_template
+  image: macos-26-xcode-26
+  variables:
+    NAME: macos-26
+    DYLD_LIBRARY_PATH: /opt/homebrew/opt/expat/lib/
+    PATH_EXTRA: /opt/homebrew/gettext/bin
+    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
+    CONFIGURE_ARGS:
+        --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
+        --cross-prefix-aarch64=aarch64-elf-
+        --cross-prefix-i386=i686-elf-
+        --cross-prefix-x86_64=x86_64-elf-
+        --disable-plugins
+    TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
-- 
2.47.3


