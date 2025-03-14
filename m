Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BACC35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 13:21:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt4uL-0005DJ-AQ; Fri, 14 Mar 2025 09:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uJ-0005CX-T8
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tt4uI-00019g-5e
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 09:16:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso2094571f8f.0
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741958217; x=1742563017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/05C1vvU/DoLYE8zWXHa7Rwl5AjnIHXhCOg3oKo2xKA=;
 b=Fn5iP6ehHqQbIUeKrcX4cYUjtSAKu3Vu5jLh60kCuMRpqxVURGY2T9+mFvvlEa5Y4r
 Ew4RpH3tc3Oq9yMn7kuAxsGDOb/gAXj9tEdk/FVPa51ZgdItCYx1KKMc/oLqbqUo6KsO
 U4rzFsoYtqhTqmlthtIXg2BPXudIPhur8egBiBCbQMf/lG8rvJzNe5PXsAPePuFUamm0
 UWM2cQpxFwqZwNgMa+s+gbAmgFJyRnypnrALwUsp6TISGadhjv0X+NR+GmOW0jiI8IOu
 ncpMgHXJ5wEFqj2/36PoNixUNoz5azy+mxD0/bFuhh4nuuO/xDYX24cc1KkEsWNxj7m4
 jm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741958217; x=1742563017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/05C1vvU/DoLYE8zWXHa7Rwl5AjnIHXhCOg3oKo2xKA=;
 b=TnTms4slGaa7LVo1AgZE20C7gIxaVUazoWnSlxZ0dcwnr8azuFL7aSxKInt179op6d
 Iatg5VlisyYcEKRqcQDNMAGm5t13o6EG9v+vP4HFazq4BLzY6uXvPARDOlbL3FyoJomf
 znHX4QUtsii9sa+9yud/d750CUjvql0PVq1J7hGmEk+J0gbs3M8iTEEpwUpOIx/9b3Dz
 BKUFCjeA0U8lZbGOwGyJom/dzDZnwNmmXkHVffDpptUThuevQOLnPInHot74BpzloE2K
 uFUKLLh/JYqrj3JcEIAFw3ZL8DoG4ZVX4iG9TkmlhQ8qHIOMvTKT9ASuxyAD7bBqLoAO
 jUHA==
X-Gm-Message-State: AOJu0YxQEvV8vYKxPVi1fszRQD6M3rRMu0yaoBK7s1PRE+jDUG2K8agF
 7LRSwqevlrbz8ewK/9fpKPMLOfXLtLboEL9/2dbDjx9J2waTRTCMoq36pca6lD6H1VqWVQ0A22+
 +
X-Gm-Gg: ASbGnctYc67pd6/DZTQTjosbJM74sK0hy3fOPu0J6600mS7I9KcmYiWutI6r1u03/Aq
 zoUzYC44aLBCHB5Q6NVwZcFwnXC/MziME1v8dMpJCfppCkkMpj2GaO6oAcfkVWtRMkBHxhI39iT
 J7UQ43hJDyx7AZRPfM8pCKaZ3X+WCff4MK+AHb2qa0q5QIQ3b2rl2VOgPR25T5SyKlFf5UoIniw
 LiQVMcqV+sGhqA1bHSTDOdz/OJ47/fckClbl3N2giBL7H/CBhnKQMkeAYGVojvoIRXKQRC2M53m
 iNKo+6IOIcw9n1WXBxmVZMJzLiRTRchI+F7t8+rfjyuiwYwoB0m1yM/+vhaVEg==
X-Google-Smtp-Source: AGHT+IHTjGzNVfksiRLcPDDbILfdE84iU+WTabXG5d/HM7QUbUozKX86KpDRd0iGQBnOd8jkv83g8g==
X-Received: by 2002:a5d:6c62:0:b0:391:952:c74a with SMTP id
 ffacd0b85a97d-395b758f7d1mr6653490f8f.8.1741958216681; 
 Fri, 14 Mar 2025 06:16:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb93csm5437923f8f.86.2025.03.14.06.16.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 06:16:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/17] meson.build: Set RUST_BACKTRACE for all tests
Date: Fri, 14 Mar 2025 13:16:37 +0000
Message-ID: <20250314131637.371866-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314131637.371866-1-peter.maydell@linaro.org>
References: <20250314131637.371866-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

We want to capture potential Rust backtraces on panics in our test
logs, which isn't Rust's default behaviour.  Set RUST_BACKTRACE=1 in
the add_test_setup environments, so that all our tests get run with
this environment variable set.

This makes the setting of that variable in the gitlab CI template
redundant, so we can remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250310102950.3752908-1-peter.maydell@linaro.org
---
 meson.build                         | 9 ++++++---
 .gitlab-ci.d/buildtest-template.yml | 1 -
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 2f43fd81bf4..7f75256acf9 100644
--- a/meson.build
+++ b/meson.build
@@ -5,9 +5,12 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
 
 meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
 
-add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
-add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
-add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
+add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
+               env: ['RUST_BACKTRACE=1'])
+add_test_setup('slow', exclude_suites: ['thorough'],
+               env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
+add_test_setup('thorough',
+               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])
 
 meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
 
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 4cc19239319..39da7698b09 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -63,7 +63,6 @@
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   script:
-    - export RUST_BACKTRACE=1
     - source scripts/ci/gitlab-ci-section
     - section_start buildenv "Setting up to run tests"
     - scripts/git-submodule.sh update roms/SLOF
-- 
2.43.0


