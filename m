Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E22CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:15:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuAI-0001F6-TQ; Thu, 23 Oct 2025 08:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8q-0008Ma-Fc
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vBu8l-0005F7-Le
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:10:03 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b6d345d7ff7so64546866b.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761221397; x=1761826197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7kEo0ehhrs7dmuoByZ33JGWoarerE4gA39Srxdfv20=;
 b=AfmamiMb59o3Gn6Dmxhc1kCwA2Yov0JwNN0ccy6f/dzMHqlEUw8zJzD5pNIt9SgclA
 SFGCy4yM2/EOy01hPCEKZ/5qTTVgcvpKw6wZCXfElZ/WIzblqoxaStJpcezSn2yef1Da
 KahjEcfEVRNxe4GIf0FTLIwdtmYFaAu9cqcTB0Ckv5eVbhvs9M6WLRgaqzAB7hV8V4Sp
 7qWv10qZSFvDbt5RMDiJP7YiX6YWhWOo/WR9DMF98VhXh2KUcyLlCfafXNYjcBC3HJzA
 x2Bi7CoDhqoP5xn59VDqz7+x/INYvNqj9vkJBxzhLpoOe9kJWH9K2cLHl1ltfwOxkj4k
 c1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761221397; x=1761826197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7kEo0ehhrs7dmuoByZ33JGWoarerE4gA39Srxdfv20=;
 b=JvJM82HMuR38OIcNB5rKqUzcVYEO0pmICITcf6SYZccgiR+r2BGVon8sgG8ZJ/bR2V
 SigTsHZfIAmT1i0KLXPFEfu52ak2lSsicc6rFsYRLOV/RCgdqBcyPMnzp3nWpVKdTlmu
 /ZOvYXY90gH3k7QRseJGnFWRe5BSH+89Q8shdM0EYutLvgMVkdFsbZwHhqJH7jayW5Rk
 EL5mRejJX8AYAd1+vsv6XhU7n514eJDfLXclMxSs2MBuw4VAtEn5MA4AtFOO3LkFAQAR
 j73aKhth1NySJqwQJixwpDW24ZDP+SzDIjWrdDhsF444Hd5xw2lDL3i0Z9DxImJ9eI94
 o1Hg==
X-Gm-Message-State: AOJu0YygABFYOOViF04JKkRBLfV2e0oJS6BG3khVPjQESc86vyWDRCvI
 C1X+n1CjiYpDL8EXeraCkeuRhAfokpwCxCDh74LftdcKyuci8zGet6wRqmQ8j0b2HZ8=
X-Gm-Gg: ASbGncubgGzbRYojns1q8c+I3JSctgq9+XYr9ye/ByKlfkfXQGgLhMF+LuWTBcL+OVK
 f6a3Ee73+e0QjyGvmrHkNKlOhDjGF68D0P9h/lGv+AarIyYh0l+22ayl+WGEhw/3A9iCBPHFszG
 KKzxFmIPdpKc9TBNr/qNgnYZpnI5whjtonVT5O9+RC1kowQr8ez9miX+Y4B17F921NHU3lNAcai
 BLuu84xpOZ+XpLhVBrebA4EmGnxD0foJjeqvTt2OwCMW/ddv2PtGJalKP2dGc9IDKZNN6CSsstF
 SOBJakbOkWe7BZ8Je46mnU4h9gJjRa2OCU9Z2tJWaUTzenNgswz7UXmYs7kMwpZs2T8ibjjjYq+
 gtpWNZQ6oz2AwrQ7a/rLj4Fdw0gVp9rusowQpOGKek+yaZBwVGapZf9wbfITTWhZkj6u1iQzupm
 n+OJz/+5s/4qM=
X-Google-Smtp-Source: AGHT+IEvpmRwqYVcJ2yk9kpI6I2lUqRkAZa0A2tps/HGJ0AODiU/o5oW1TZrDQT6d4myyT5ODqDlhA==
X-Received: by 2002:a17:907:6ea1:b0:b3d:d30b:39c0 with SMTP id
 a640c23a62f3a-b6d38b72161mr613298566b.21.1761221396305; 
 Thu, 23 Oct 2025 05:09:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3f316cccsm1562165a12.24.2025.10.23.05.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 05:09:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E3F0A5F8B1;
 Thu, 23 Oct 2025 13:09:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/7] ci: clean-up remaining bits of armhf builds.
Date: Thu, 23 Oct 2025 13:09:47 +0100
Message-ID: <20251023120953.2905297-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251023120953.2905297-1-alex.bennee@linaro.org>
References: <20251023120953.2905297-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing/ci-jobs.rst.inc            | 7 -------
 scripts/ci/setup/ubuntu/build-environment.yml | 6 ------
 2 files changed, 13 deletions(-)

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


