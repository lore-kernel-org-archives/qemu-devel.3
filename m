Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC89C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2c-0000AL-El; Wed, 02 Jul 2025 06:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2X-0008WJ-PY
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2P-0002oH-Bu
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so3718700f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453398; x=1752058198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4wxQdFgaAl/kwo8ASXJ9vsmD0ZBYPLir6xKV4La3T8=;
 b=r/NsE/FEoLkYY1p/+97sekE3NLKOWpWgfSLcmvAOXXxrV1H+HZtfcQRm7po5Efi3hG
 kIDnp0p0azIxaN601tmoToZHUvVrWEwd68qAs3T9p/VDm4JbqkbATFaOO3C40DVblKPk
 PoEDbICy9gpTImy8QzdJ4sRsGW1r0uFaJM/vqEA40UuebP0Bag4TWPjiOzNAsG81LNwv
 +5JKU0sOSbNi+6cscfUgptODIQiKo3LloI4TEkg/VOal+pfhvDmO1wyDwiGHnyTjTbZU
 HYXOluCu6iQ/mrES0VyRuZgNJ8AJ3yr60kwFVrxuNg8zrWF5neYLgKeBiJtDcWlBq6dL
 Qedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453398; x=1752058198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D4wxQdFgaAl/kwo8ASXJ9vsmD0ZBYPLir6xKV4La3T8=;
 b=izB6WoNS7SycMCM0CpKJ7ltT9Thh79f0q9yPIdHPdn0i0PhY0Jzl3O8q5pkZqdzwz9
 kZbWXtJn5bNq7b9lc4ySr/1epbxWYppot/YtBFLph8apCvE5fCxTXtxWi7q9Z3W+mhDx
 qU+nwB+OFedZsYsvjfuFircg4LQaGdZtKnyTu4JVujaUuuy7pvky6D36yLSDh5c7gUfQ
 7mQXSSTKvURZKWd10X4Jniow/+lMI0d8mE7Jm2H0edRBZXuz54xpTYzuc5vag4YcpIHN
 +SR3PKGUqb/D1resTd3keA7qFEWTZt9d4/e4FIV9PpYn+aWxZ95CwoA5M4xF5imwPRuW
 DYjg==
X-Gm-Message-State: AOJu0YwgqPVCfCplyU8ot1n1Va8jfsrodU+sy9wgP38lGUW3cMmqhHpn
 kue73P6700AaxfguSwlLtkzHplat4nNPodUFuUb/Sf11kehacmLDCEznm3OxskGMzCY=
X-Gm-Gg: ASbGnctacQZ3WymhFS9GzErydWmsBMyh7PXd2OCtF+m1qG9ZP8Kapr9VVyR1NRmgb+3
 PQE0LkRTV1OSoLs3nxlbuHbI6tW4FNWHkHTOZxOi8XXksLQWT9e0IQ28BWMKeSKpfxDOKppzfmg
 uCi2QznqKS+vXo3MQXjvWJfEgtTC9csZmvr2vu3GF0gLSXljJpk4gzNQQzpqy1D7xOQHl6e6tog
 ceW77zDwcStJhm+sIMtpM07UYbwpyVEdZ/d1/H9nRVXqRlFDH1p/gMn744Zc2Dm2PVwU52sf9CL
 UnGjWszlit8wwpdpkKR9xWKlSHeQ4PI6hlL8Fbp0l330FJ1Iry2pOYRyMomxmnY=
X-Google-Smtp-Source: AGHT+IHiJmd1PHb0EgKL3rPDnUOVIqSxfmiwnBfb52dpavbdPWpjQmsbhlKFJuuYXfVHE1AzL3IA5A==
X-Received: by 2002:a05:6000:480b:b0:3a3:648d:aa84 with SMTP id
 ffacd0b85a97d-3b1fdc20ce5mr1758366f8f.5.1751453398332; 
 Wed, 02 Jul 2025 03:49:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c05csm225289715e9.5.2025.07.02.03.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:49:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D930D5F8CC;
 Wed, 02 Jul 2025 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PULL 01/15] gitlab: mark s390x-system to allow failures
Date: Wed,  2 Jul 2025 11:49:41 +0100
Message-ID: <20250702104955.3778269-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

The system tests (usually qos-test or migration-test) prove to be very
susceptible on the s390x runners. Although we have boosted memory and
virtual CPUs on the runners problems persist. For now mark test as
allow_failure so the its clear on the CI UI when checking test
results.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-2-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
index ca374acb8c..e62ff1763f 100644
--- a/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
+++ b/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml
@@ -31,7 +31,9 @@ ubuntu-22.04-s390x-all-system:
  timeout: 75m
  rules:
  - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
+   allow_failure: true
  - if: "$S390X_RUNNER_AVAILABLE"
+   allow_failure: true
  script:
  - mkdir build
  - cd build
-- 
2.47.2


