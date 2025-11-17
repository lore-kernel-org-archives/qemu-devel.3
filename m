Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F989CEBF93
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 11:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKxqC-0000fa-B3; Mon, 17 Nov 2025 06:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpi-0008Vj-3K
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vKxpZ-0005lT-Fo
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 06:55:45 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so44804025e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 03:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763380536; x=1763985336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pLA117aLx8OKVEuzuGnq17EtRt0jncWZQKbHjbOJms=;
 b=DZypyh8ZLj5d2jZe/fWt7O0r0V7rYGVAsFDAeJQI1RWWJB5Z8pMb+ZPpJwlFU0IuVy
 lhCJKugFBqIQ9Ewt1LCDp3CihxDw5aM/ZBHEc0zUIYwjUsL+RBLwv4CHRumLq8BJ9XmJ
 M7qvyk/MNL3EpqYJHElZbx6gsvSN7C2nOSd6zPYfXMwVf3t17L/kZQmW7K/Q910C1RC8
 i733K/xim3SOxst1oGAPpEwrF9ZFIL+pteMHm7iZSdCGDTADOz2lbXPlijAATqwuytvr
 TZIuEdutDLEUaEeuwAgxp7z23Sp4p6PdWDKTedR08NPmLV96t++1HtfUe99zcJV0s8G7
 +4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763380536; x=1763985336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0pLA117aLx8OKVEuzuGnq17EtRt0jncWZQKbHjbOJms=;
 b=Xq76tV4LAjRUjGs09dWqvwhImhEo1fQMcLrbRfOgaHtbGyXaHOaAAabCKVLy535low
 iNbeqlI2REpZWpoXTXoXIc4L2afIPH5h5lRVJJg/ACxWicyzE8paGCjOo5BWhEhuZQ7g
 Q9MwmK6KPzMusOLkKe11fDkoqYcf3BId/XZUrKym5y+kQVIOvEUQq2f7xmWvSetpzeQ3
 SaPIPAbZjd8Ohga5z0p/2CPC4nZYZyShEAYI3Ld6STh/H0hkZkBEgiSVXoIYxHB9JFqp
 0g0ML8WsrVd8FsERBC4UUDcDIVYCPXRwcrQblEINpGYsnmThqUFC+QYQMI+YKX7/7b+f
 KEzA==
X-Gm-Message-State: AOJu0Yzc6DZfJE5zs6eUYCeAG4FpdQKutfISP6hFJ1ynUu2PI9TN3cm/
 afmhBeSzigz6wlUSmPZ338I5AilMLIqqb0tdf1R5kP+VHwKi+TxhhDXSULgzastHkpI=
X-Gm-Gg: ASbGncs9L/wwcym/JPiPXBVnN9eZwQpaH+hD0MU+4r4lTxYdUxWix06EK0fPqikC5l9
 5QWxwGno/FJZLF8z9bUQ0IIFHS7agBDad4b9PgON6fJ/YR35/SDDZwxgoRrgz5alBAONs/MuIoc
 8ODTmyx/HeCW6deJ9YVdhE//v/ScWh2HSSZ0Z96zlB7d8p5bCQrFHujjIM5WLC5qPtNF64oKW7o
 NwZBSZF0FAZzIojTeS9ntDs6pSlBB1RpGZyY3ZlyZImaNipcaXXjgWwm5Sm2gU7t5RpimZjbxD2
 zwud0tQxWrLMH3APmuMYcVosCpHdADp7XXTaO0Ff5NtNV5BSTMzH9OTYimcJfD+v+7A/qu8bzzh
 eifKsP/Hfhdcs9Nrgizeo5PPKk6xmaXQTbms3ePSmXaQ1L9hdNVf3yGAyynXIh3GUVi3GczhjJ3
 EU
X-Google-Smtp-Source: AGHT+IE7YgioKwfMhYCDyzcq02gmWYCc9GX4ehCIAAZ+KH4Uq9aGyHcTfizgT9lBJEikg1oQOPKUwA==
X-Received: by 2002:a05:600c:8b22:b0:475:dd89:abc with SMTP id
 5b1f17b1804b1-4778fe583f0mr109107985e9.11.1763380535691; 
 Mon, 17 Nov 2025 03:55:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779cec0f2fsm47031315e9.10.2025.11.17.03.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 03:55:32 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A55E25F886;
 Mon, 17 Nov 2025 11:55:25 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 14/18] gitlab: simplify the ubuntu-24.04-aarch64 rules
Date: Mon, 17 Nov 2025 11:55:19 +0000
Message-ID: <20251117115523.3993105-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251117115523.3993105-1-alex.bennee@linaro.org>
References: <20251117115523.3993105-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

We don't need to duplicate the if rules to get the allow_failure and
manual behaviour we want. Clean that up to keep all the rules in the
same place.

Message-ID: <20251113102525.1255370-15-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .../custom-runners/ubuntu-24.04-aarch64.yml   | 43 +++++--------------
 1 file changed, 10 insertions(+), 33 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index ee13587d99e..6f950baee0d 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -46,26 +46,16 @@ ubuntu-24.04-aarch64-all:
   extends: .ubuntu_aarch64_template
   variables:
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-without-defaults:
   extends: .ubuntu_aarch64_template
   variables:
     CONFIGURE_ARGS: --disable-user --without-default-devices --without-default-features
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-alldbg:
   extends: .ubuntu_aarch64_template
@@ -78,34 +68,21 @@ ubuntu-24.04-aarch64-clang:
   variables:
     CONFIGURE_ARGS: --cc=clang --cxx=clang++ --enable-ubsan
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-tci:
   extends: .ubuntu_aarch64_template
   variables:
     CONFIGURE_ARGS: --enable-tcg-interpreter
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-      allow_failure: true
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
-      allow_failure: true
+  allow_failure: true
+  when: manual
 
 ubuntu-24.04-aarch64-notcg:
   extends: .ubuntu_aarch64_template
   variables:
     CONFIGURE_ARGS: --disable-tcg --with-devices-aarch64=minimal
     MAKE_CHECK_ARGS: check
-  rules:
-    - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
-      when: manual
-    - if: "$AARCH64_RUNNER_AVAILABLE"
-      when: manual
+  allow_failure: true
+  when: manual
-- 
2.47.3


