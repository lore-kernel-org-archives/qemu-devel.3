Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964C6CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 16:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vByLX-0007vy-Al; Thu, 23 Oct 2025 12:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vByLU-0007vX-TZ
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:39:24 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vByLS-0003QN-FD
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:39:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b3e7cc84b82so234046166b.0
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761237560; x=1761842360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=96IXKXR9VI35HFeQR3K/sf6rTcrhTZCDVdFjLZ8rVxQ=;
 b=KfrLpmbbgMpY0KecsKa9PmUMZmXQtjy/jd819KJiS4oBojMslb2bSK5F3O0ZPSyOyb
 ZgacT74JwpM/OQXnOS9y9VvfAikSLoGBY/R7W+fCbZ5HoVeY+SPjaCRmDw4J9kojvbkh
 v+gKT8ztrd7YNk026mTurehPOpXeoBlwEYibTXiQStjDopZgKHTytgaPS/Yl2avjGOBB
 C5oquFB9AA9HvZuVv5HGPeQY1L+i+SWFlabkBY3uZvofPGTJB1YRQXV5sHBIugBq0AAU
 PYNL0h17LndYQHR7v8PAH+MQsUMdkfy3u5ReYmjUYcAMEyu9qhdmJ5HaXMPXgTSesQr3
 pX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761237560; x=1761842360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=96IXKXR9VI35HFeQR3K/sf6rTcrhTZCDVdFjLZ8rVxQ=;
 b=iZnhHck/REzs66xS0YqLVgbMedxGxloa22SR38uQ/smvuA49EwcVzQGJUWxNtyU6G0
 a0/l6N+sUnQAjMLbO+q4gSnAsRab1QuudqCBSBwQ4KCJwPl/FTRcvYlDxQ5+DhZaBtjp
 g6JSVbpeGyrEvFlHivW6QTiMMoR3Mw8Ax4n8qgiiH81Zrqg3C4lYB8kbdLm0kywwiJqa
 7Jv33/4U9gS5n8jJvy1bzDh+YHh/lgQ/TAU1cK2V0JKcWn8MOJQJHa2kcPLdSxJm7i7v
 Jq1XzpYJMXPji3+qJhwNEd2OYtZMxCTef62xciNJ6qFBpYEMZJLNPN4laYoiEbFUwgc0
 XdwQ==
X-Gm-Message-State: AOJu0YzKa274i/0bFsJqr+NZmLYX7d37gaumb7fa234HkSiaoXaRsYeV
 i/EvInfDR64RBg5F5gCg4SBawvNwTOmZCuLrjlf90g0Bug7806Tw/AJqIaRkZduLH7w=
X-Gm-Gg: ASbGnctDE0YYNhiIbZsUJDVuRUGTEbnF6TyHRVKFVfKcqxfMRzZhvAPDSkwt2NNlQMK
 kdBXc+P0Q/2gGpTKV5XRSuVC60Zy8F9hAoAokJKffejFZ7jHZNN2udIWuJ+6Xh0LiIhsO7sPlgR
 NcuOe9ceJgSTKPDb8rKCaoqXa90xpOCGR9IPdbusLM5UMAYsS0wxcuB9wwaFeAR81IOge3+jfUK
 erD0QhGGOmT7GLnoRDTCMALE9PgN5TFmjgFzCBNirsU28d0lj8aIxAdP2fowr1FrO7QAwkl8ab2
 1TvIbAVt2WuXpbIBTpaFOYJcl1FSbdHg2o6VCEpb88DCQXtx1Pl/1CLqifb/7C13M0xKa0KlO0j
 5nRs8KNM1MrvZJRtea7PM60n0gEUbFk/5YUvQOJyHMbll8tn5JcPLv4nB/SJ/QZiv085E3CKOXr
 Fe
X-Google-Smtp-Source: AGHT+IHg0h5zeXeWcnnPrReRuvsvWD/jjOdSXUiwT9nYF59iFgWwwh39RIItutbEcILkRxQN+adiJg==
X-Received: by 2002:a17:907:3e9f:b0:b54:858e:736f with SMTP id
 a640c23a62f3a-b6474b365b5mr2925645366b.36.1761237560296; 
 Thu, 23 Oct 2025 09:39:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d5130d14dsm264596766b.27.2025.10.23.09.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 09:39:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E50D25F7F5;
 Thu, 23 Oct 2025 17:39:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH] configs: drop SBSA_REF from minimal specification
Date: Thu, 23 Oct 2025 17:39:15 +0100
Message-ID: <20251023163915.3199361-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

The whole point of SBSA_REF is for testing firmware which by
definition requires TCG. This means the configuration of:

  --disable-tcg --with-devices-aarch64=minimal

makes no sense (and indeed is broken for the
ubuntu-24.04-aarch64-notcg) test. Drop it from minimal and remove the
allow_failure from the test case.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configs/devices/aarch64-softmmu/minimal.mak          | 1 -
 .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 2 --
 2 files changed, 3 deletions(-)

diff --git a/configs/devices/aarch64-softmmu/minimal.mak b/configs/devices/aarch64-softmmu/minimal.mak
index 0ebc1dca561..3c8582e12cc 100644
--- a/configs/devices/aarch64-softmmu/minimal.mak
+++ b/configs/devices/aarch64-softmmu/minimal.mak
@@ -6,4 +6,3 @@
 #
 
 CONFIG_ARM_VIRT=y
-CONFIG_SBSA_REF=y
diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
index 46db9ae0138..ee13587d99e 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
@@ -107,7 +107,5 @@ ubuntu-24.04-aarch64-notcg:
   rules:
     - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
       when: manual
-      allow_failure: true
     - if: "$AARCH64_RUNNER_AVAILABLE"
       when: manual
-      allow_failure: true
-- 
2.47.3


