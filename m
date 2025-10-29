Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A193CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8S0-00040T-SQ; Wed, 29 Oct 2025 11:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Ry-0003zE-Pp
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:02 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Rp-0002rm-Fl
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:02 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b6d53684cfdso6934966b.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753048; x=1762357848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wg6+PT/hZIx0xGwf6Sxgv7SpSjwIGao1Eq5ccApyXa8=;
 b=N+FfwyUwIdrv8CW571T0zdaa/ARmKsWWq51S4AmR2uoB+zil001DzKRewTIZVPv5J+
 qBvK+BLQS9yQj2LQ5HToz67hiCqkYuaa3AhfyxsrwjlbvD/0SCpUCQKX91JDk/cewAGV
 mxAu0qlxA6hNlJMGg5t7LsR/uJEUFCmoVZHdiJ6ZyV1lpsuoGSwe6397FQfx8bYAsPx1
 vOW9Jk64uz042a9ZQmVzngYOaWrb8exwEHo+mxsezwDtNdC4VNxwkLXwZKqJIM3SqTil
 pdlOWKzyfCymsiYdTPqrAjDC+FlXN2pOxR24iN+W1Q1wS9DiSx4c4nHN+WJZIGEnloS4
 2oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753048; x=1762357848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wg6+PT/hZIx0xGwf6Sxgv7SpSjwIGao1Eq5ccApyXa8=;
 b=FJ0ow9DU/Lf1eb919wMN3v8PHQUe2iu95HG78eL3OvmNuyedObEi1v1xWLJZRJo50J
 Mch63GKjHTtdCyR7e2cz9m40vugC6wd0OGM0Sxkn0zzdMttyo1KbhQ54n6lgkh79nwu4
 PCNcOKqeWGEMPPbGIUDHWbKsVOgKwSKXJxDT+7w+Dmly8ZZzcKCoJGddnUeCckL9/BWj
 F8f9BEcKMaXP21dN4gn32dawnWYL5G8Tw3ZhjRTnLligX0DnA/kpFn4GhbtXIyOqnHg3
 0KNuBtDRbdz+j7hZGLF+ndVOVQUUBnWJvZ63Dbovbmp9/BvFlrbCaV68NtDYdVithPwH
 l6mQ==
X-Gm-Message-State: AOJu0YxSDAyukYEyWV7wV5u9j4AdFD7gDTot3Dsrzq4TqxrydprObeNA
 3EsAA/ELI3yuVT116NV3ABS7SOKtFvdIgDJOqRaFcxYLELGqpkbylEv5VlXzT/G3zss=
X-Gm-Gg: ASbGnctzstxN3R8O9a/M1zWAyd2nKKaOztNSObFWfoeccdHP3uzmaMkW3XzD7pPxQLd
 lFjeyA2r1qsdjkLTv3zGxYD/JqxLSdlfPd+Lq7XlYQQfvGsL+U3fuXUpe5wL1xMGJuEydC57J7X
 x1Zbrj6z81ncKKmvZV3SQ+lAb3QFFA1N+gTORaVD78xlg0mQi9FNWAWLtu/vBTXddtUlEr9ELjN
 tHWEY15dAI+Vx/QFfRen3ASTwWwcNm++3IMTsjqMawuVyOvqkcN18ZHys67RMzqfECiOlYaTWYb
 jGmZmO1Z0AJX3G7YIvlpiUCI4gkKH9p9pPmRHnZLEXOLrNGv8aivpOB4jK23X8xmt3DIuEpihty
 YWtXNKPVORRVwOXFaj7Rs2+Fob8iZz+7pVtLWvLnlENsihe2vEFFRgVkB6gZ8GTyBEtUELHWb6q
 JX
X-Google-Smtp-Source: AGHT+IETFUh2d3vD8OThvnMjx1hIP5HdZnugjt/d0SGX5H7cOvGE1K4zsZCRLkc9B6M5hMN7xsP63g==
X-Received: by 2002:a17:906:6a0e:b0:b6d:5f52:eee8 with SMTP id
 a640c23a62f3a-b703d33aa3fmr332009966b.29.1761753047799; 
 Wed, 29 Oct 2025 08:50:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6dad195456sm929565466b.72.2025.10.29.08.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EFD905F909;
 Wed, 29 Oct 2025 15:50:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 01/35] ci: clean-up remaining bits of armhf builds.
Date: Wed, 29 Oct 2025 15:50:10 +0000
Message-ID: <20251029155045.257802-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We no longer need to support 32 bit builds and we missed this while
cleaning up.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251027110344.2289945-2-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/devel/testing/ci-jobs.rst.inc b/docs/devel/testing/ci-jobs.rst.inc
index f1c541cc25b..b92d372a0a9 100644
--- a/docs/devel/testing/ci-jobs.rst.inc
+++ b/docs/devel/testing/ci-jobs.rst.inc
@@ -168,13 +168,6 @@ If you've got access to an aarch64 host that can be used as a gitlab-CI
 runner, you can set this variable to enable the tests that require this
 kind of host. The runner should be tagged with "aarch64".
 
-AARCH32_RUNNER_AVAILABLE
-~~~~~~~~~~~~~~~~~~~~~~~~
-If you've got access to an armhf host or an arch64 host that can run
-aarch32 EL0 code to be used as a gitlab-CI runner, you can set this
-variable to enable the tests that require this kind of host. The
-runner should be tagged with "aarch32".
-
 S390X_RUNNER_AVAILABLE
 ~~~~~~~~~~~~~~~~~~~~~~
 If you've got access to an IBM Z host that can be used as a gitlab-CI
diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
index 0f8ec5fab04..1c517c74f74 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/ubuntu/build-environment.yml
@@ -19,12 +19,6 @@
           - '((ansible_version.major == 2) and (ansible_version.minor >= 8)) or (ansible_version.major >= 3)'
         msg: "Unsuitable ansible version, please use version 2.8.0 or later"
 
-    - name: Add armhf foreign architecture to aarch64 hosts
-      command: dpkg --add-architecture armhf
-      when:
-        - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['architecture'] == 'aarch64'
-
     - name: Update apt cache / upgrade packages via apt
       apt:
         update_cache: yes
-- 
2.47.3


