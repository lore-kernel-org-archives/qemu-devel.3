Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9182AC04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 15:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0Nfw-0001pI-EF; Fri, 26 Apr 2024 11:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nft-0001nT-L5
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:45 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s0Nfq-0003n6-J3
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 11:39:45 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso3616372a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714145980; x=1714750780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A1Ykyp8MSDEaXJw36chiMW0ZSsAFqE5MPorR7vu6DxU=;
 b=g92x21ZfL9Ij7Uh2MaCE/tq6GNuRnwcL8UBrSSuvSMYKWmTwgeOZEtA82Fg/Pz7V+c
 zi+M+lDAOO07sr+amFA1OVr3uPKcdSvb2MBqKQERBubLBU9MKV2N+zDemci+pKyeS0er
 bsCxQA7Ly0jYod4vPDPDztXvKNXuAE7+nfk+tEjNpL33+7VNuUmJsEEeiDRUBho0eZ3c
 FhNRNZ/T8dCgOST86xGQGdu9BW3+FJwO7QBHiRSlMqG+s91vyxjDm/5WzHGWGWFCd2YO
 TZOQjJY+/KRue+/IK9eAMApTINiXEqjRxCb7gs7JWkV33Fd28rx2lBPJtmCC7OrVoL9G
 9hQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714145980; x=1714750780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A1Ykyp8MSDEaXJw36chiMW0ZSsAFqE5MPorR7vu6DxU=;
 b=uqLgUuNdAOHUzBgRYylErUnMNE3+PzDFAAoCGdWUdsa18ez3cmYdXVISycQlZ9NWwG
 9hryu+YmAU4/mOUHQbNPkoIXVsNm8ng5HnyrMqf5nnfPZB9cAgzgsUAdWpGY/cgVRp9x
 qASh+C6qAVfDBoikspsr4Su1HsClpcNdipuCjMw5xMuxd62AMblnWFFH/aMbSAGXCJ8E
 2wU54p+XSwEhUuqcd1LtLiffLkgnGCFfKuW2YbWXe4j0oMLABBtrb63Akn50RNldbWJX
 sx2/RU2wmfHKSNbvzTLQM2VzswM1wbwGW2Sb35dc1D7nlTHSI7bI5IplgyHTGlceHXET
 7hmQ==
X-Gm-Message-State: AOJu0YwRgdg7fRkIHSuextNieFRVfFrrSL+dAmrkzxG3Ws5xLeQHcHmU
 uMnDh8yCMtnEeWBddvQCoL5lum685aE2fcSpQLNlGYeuahTZoURxhey7cqScaV4=
X-Google-Smtp-Source: AGHT+IH4k5ZHvgxBJYawDbPpnBYAR3qOl92dQCgAEsfhVNRvExBHYtw1LwD1Bwdm+0bY29aGG3hqdQ==
X-Received: by 2002:a50:8d1e:0:b0:56c:3b7a:632b with SMTP id
 s30-20020a508d1e000000b0056c3b7a632bmr2203670eds.29.1714145979910; 
 Fri, 26 Apr 2024 08:39:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y43-20020a50bb2e000000b0057000a2cb5bsm10547038ede.18.2024.04.26.08.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:39:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0670E5F8A9;
 Fri, 26 Apr 2024 16:39:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Joel Stanley <joel@jms.id.au>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 1/3] build-environment: make some packages optional
Date: Fri, 26 Apr 2024 16:39:36 +0100
Message-Id: <20240426153938.1707723-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426153938.1707723-1-alex.bennee@linaro.org>
References: <20240426153938.1707723-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Upgrading the s390x runner exposed some packages are not available for
it. Add an additional optional stage we only enable for arm64/x86_64
for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index f344d1a850..de0d866a1e 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -95,7 +95,6 @@
           - libpam0g-dev
           - libpcre2-dev
           - libpixman-1-dev
-          - libpmem-dev
           - libpng-dev
           - libpulse-dev
           - librbd-dev
@@ -107,7 +106,6 @@
           - libslirp-dev
           - libsnappy-dev
           - libspice-protocol-dev
-          - libspice-server-dev
           - libssh-dev
           - libsystemd-dev
           - libtasn1-6-dev
@@ -119,7 +117,6 @@
           - libvdeplug-dev
           - libvirglrenderer-dev
           - libvte-2.91-dev
-          - libxen-dev
           - libxml2-dev
           - libzstd-dev
           - llvm
@@ -156,6 +153,19 @@
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '22.04'
 
+    # not all packages are available for all architectures
+    - name: Install additional packages to build QEMU on Ubuntu 22.04
+      package:
+        name:
+          - libpmem-dev
+          - libspice-server-dev
+          - libxen-dev
+        state: present
+      when:
+        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution_version'] == '22.04'
+        - ansible_facts['architecture'] == 'aarch64' or ansible_facts['architecture'] == 'x86_64'
+
     - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 22.04
       package:
         name:
-- 
2.39.2


