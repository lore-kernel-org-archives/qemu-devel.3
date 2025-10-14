Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218DCCCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cW4-0004y5-Oa; Tue, 14 Oct 2025 06:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVL-0004UQ-7a
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:44 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVB-0003X9-QT
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so43610715e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760438606; x=1761043406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIbkSUzuy95fWVG2YehHRKZZn6Jn1DT3kGS2n9ZFy4w=;
 b=IGE/rHihEkInGV3zRR/3EmBs5uRD3jp+9AnpLu6j/YwsqafnOjN5pyVpYm+IAQEGuN
 EJthRSAZM9Zu7FA2R/a9Hw8PAoWaZjt7McCf0CNpAsKNj/pWVfBKvHRxgzpK63oh5GWz
 KOjeqAtZ6jCQ469qKPtz2rNIbmmbtws+L7xKqhg5c18fN34FvRxEsYaa/1AJg9tREMYB
 qE9MFvxJ0VfPfR0GNgXQyzeE5SBjJt/tU2nGQ/JfqJtB3+MKPFhmJaCDiUQ+MSwqBxj+
 piYUQD2GluVwkCQ3SubQm591onESZgSqVSMsmhi51nTMvNi3VE13S+cOUuUIZUzBpzYj
 ykog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438606; x=1761043406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hIbkSUzuy95fWVG2YehHRKZZn6Jn1DT3kGS2n9ZFy4w=;
 b=qK89toQcflCCGg0LVIskKADBCEQBVSOTzZ+lB6pxLKy68YzrGOqRh32dlkgdYNcX7Q
 mNVbviRokmfDJ1p7zbZorXw7Yd4R2J206fqbzjOsoTHc+Ep1/fGzmTVn/+HFlqmqgZMh
 vHG6COjNOGy4qxUfDXTU5EksaaHk4nB48gwmjLfZQG2aQf9Qkw+em9s60pFRDYUuKE5p
 GRzdEUAKfEr6XYNtKwqKYroCBBLJ5jDbiXxe1SwIfRmnedFXBNZNgQ+VXB7Szmc8T7Ry
 Gm0Z7s4yV8ZBJjmqSE1kIXvrVGI6fI8lVFzLUVMTT+OwDtLMYfOop3oMVD+vrIcoL75W
 8MxA==
X-Gm-Message-State: AOJu0Ywo0FhCgYbSeN0bH7fGH9k9sgH8RjrXt2cnk8Jx8f1J/9QfwLeQ
 mbMe5VtyGTVPmsxofxxZgu/KlQLpCuya1O3kxy6dVe1JmPrPnXeEZR/83Bcanu7XWbg=
X-Gm-Gg: ASbGncs6hIfUMUb/pusuZVbZy1nICiYFhj8f303FGW2Pz+F6AcnMyMnRBp+zehSiX9I
 aPzTwESDyATAEHHhSt+juIhSUFwY5V4rhwtilUpDADFzTG94cfwohSbr6KLqhyAevIY3sq9B5LE
 Yi7vHEglYfBREJ6YcZ7KRgQ2X2AohjlPi++7XlkhgVWrOXwVG02Upjng9YOFFEqlYsuWf5JASGv
 ZcOVKLIgP/89KUYRZcVCLrrae7x3ADXwjEn8kFnbMKcdyPl2JuV+VErEhZluoJePjw/jIRBszLx
 s6PbxLugzR54a7SnK+RSVjF5fYzc2VysWJgbjywbV0ZgLYcYqfd2lJzXa92qBgRq9B042qY2TQY
 viHrP/k+8i/kLVh+NfxZPAGM9ac6+mVZMGfPFlcKUBDC2bg==
X-Google-Smtp-Source: AGHT+IE5X7bSlEgQpG3QMyeIYGEdXpqE6l/mhSZdpcUHn6QYdxjN5qcU5j40aopNr0wL4Aiw2h6Smw==
X-Received: by 2002:a05:600c:608d:b0:46e:6d5f:f59 with SMTP id
 5b1f17b1804b1-46fa9a8b2aemr167346395e9.4.1760438606466; 
 Tue, 14 Oct 2025 03:43:26 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cf70fsm22221883f8f.27.2025.10.14.03.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:43:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B23725F83C;
 Tue, 14 Oct 2025 11:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-s390x@nongnu.org
Subject: [PATCH 3/5] gitlab: modernise the ubuntu24.04-aarch32 jobs
Date: Tue, 14 Oct 2025 11:43:20 +0100
Message-ID: <20251014104323.3023714-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014104323.3023714-1-alex.bennee@linaro.org>
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

We only have one job here so no point using a template but we might as
well update the JOBS calculation and use our fancy section markers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .../custom-runners/ubuntu-24.04-aarch32.yml       | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
index 75029c9187e..3e7fdc8fa98 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch32.yml
@@ -16,10 +16,21 @@ ubuntu-24.04-aarch32-all:
  - if: "$AARCH32_RUNNER_AVAILABLE"
    when: manual
    allow_failure: true
+ before_script:
+   - source scripts/ci/gitlab-ci-section
+   - section_start setup "Pre-script setup"
+   - JOBS=$(expr $(nproc) - 4)
+   - section_end setup
  script:
  - mkdir build
  - cd build
+ - section_start configure "Running configure"
  - ../configure --cross-prefix=arm-linux-gnueabihf-
    || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make --output-sync -j`nproc --ignore=40`
- - make --output-sync -j`nproc --ignore=40` check
+ - section_end configure
+ - section_start build "Building QEMU"
+ - make --output-sync -j"$JOBS"
+ - section_end build
+ - section_start test "Running tests"
+ - make --output-sync -j"$JOBS" check
+ - section_end test
-- 
2.47.3


