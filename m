Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1073C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsF-0000dZ-9j; Wed, 29 May 2024 12:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLsC-0000aq-Jb
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:56 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLrx-0003IG-P3
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:09:53 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a634e03339dso279882966b.3
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998980; x=1717603780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMVF59L9ibXy7bBTe6+ECf11kLQqf1Mdij1G/dOwXd0=;
 b=CtC1rMtEHxCgYpgfyShq0qNLjV/xownJaHfZQfXCdO0yZd6D2IFkOS3t2qITg0OTgK
 RVIE/Z88yax2kJGGCH8RT5ah2Cu2BtKJIS837Sbe0yVES/pXIcbtBCPBzH0HVN8sUIeO
 z9NUpiFZ9NejL38OhF8whtMcIIf5m/R/P8TsbpXCkCmDB4y28oN8NVYz2ZGMHTMrg7m4
 gT+K8Q/zvzcwHw/T7z4ugujaEUjDFsIdy5j9VWocGfCAMkysBRGlhI66BWHOPlBjdDyO
 HelbVqWgy6hDJ8ykXptyVJasj+TSfUUdrX+k7Y59YlNpvNjmdBkYplM3xpow7qcPMgQa
 5CNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998980; x=1717603780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMVF59L9ibXy7bBTe6+ECf11kLQqf1Mdij1G/dOwXd0=;
 b=qDiMrRXc24hWtl6bkOI/SLQouUAlM6J5vLu9TR/JkBGXr26/YCyt8uxdT/ijcjjFbj
 Ra9y+CXndQCqfnxBf0b52KrQSbEHV3Sc5I2lVmILW+XsE6bb23+tJe8GmhMtmtS5gSYP
 w/qAbRaSOg/UJxpXToYV/OT/DqxBjUcZSVJGlo/fH1Q25/GEk1q2+PZxWW+hNAsIbE5t
 l11E9AlFTXIrRAhXIIFAEBmGmahpI6zr4SlcQ2lbu3WnGPzmZO4z7wKroBjgZYKudj/T
 QzGxFHGDqpJdVaPPWAUUljFybgceI/mf1HlumFjlYkWMOX0GzoBJ7dW+/Vt5mIqZzYN6
 XLMA==
X-Gm-Message-State: AOJu0Yw89CnJFO1JOml4cqiOXQB44i2VKJ1l4HCtuK9nMil25twcf7KR
 jVFfC5Lq0geRSvq3GwgHHRQAxbutsNYtDhuiEjp4dYJIhyiYcBffhWSsbwEVFnU=
X-Google-Smtp-Source: AGHT+IFbzDKxV/c9Ia5sYHtXk39yw4sS/mGtOFNvGdAr6IAie9nukAftRBfYtZRCRoBub635zWIpZg==
X-Received: by 2002:a17:906:adcb:b0:a62:8ee2:16c1 with SMTP id
 a640c23a62f3a-a628ee217f7mr816037366b.54.1716998979999; 
 Wed, 29 May 2024 09:09:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc500a1sm730713466b.125.2024.05.29.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B65815FA92;
 Wed, 29 May 2024 17:09:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 07/10] tests/lcitool: bump to latest version
Date: Wed, 29 May 2024 17:09:31 +0100
Message-Id: <20240529160934.982373-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We have to simultaneously update a few bits on our side as lcitool has
already deprecated fedora-38, alpine-3.18 and centos-8-stream. However
there is no change to the package list yet.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - fix typo s/lci-tool/lcitool/
---
 tests/docker/dockerfiles/alpine.docker             | 4 ++--
 tests/docker/dockerfiles/fedora-win64-cross.docker | 4 ++--
 tests/docker/dockerfiles/fedora.docker             | 4 ++--
 tests/lcitool/libvirt-ci                           | 2 +-
 tests/lcitool/refresh                              | 6 +++---
 tests/lcitool/targets/centos-stream-8.yml          | 3 ---
 6 files changed, 10 insertions(+), 13 deletions(-)
 delete mode 100644 tests/lcitool/targets/centos-stream-8.yml

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 554464f31e..b76cc2a35e 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-318 qemu
+#  $ lcitool dockerfile --layers all alpine-320 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/alpine:3.18
+FROM docker.io/library/alpine:3.20
 
 RUN apk update && \
     apk upgrade && \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 0f78711876..cce6739613 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-38 qemu,qemu-win-installer
+#  $ lcitool dockerfile --layers all --cross-arch mingw64 fedora-40 qemu,qemu-win-installer
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:38
+FROM registry.fedoraproject.org/fedora:40
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 098c894d10..bd51e1e149 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all fedora-38 qemu
+#  $ lcitool dockerfile --layers all fedora-40 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM registry.fedoraproject.org/fedora:38
+FROM registry.fedoraproject.org/fedora:40
 
 RUN dnf install -y nosync && \
     printf '#!/bin/sh\n\
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index cec6703971..a300a26c0d 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit cec67039719becbfbab866f9c23574f389cf9559
+Subproject commit a300a26c0d7f48544c40af268b3245ebd63c7351
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 789acefb75..ace4d08364 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -124,11 +124,11 @@ try:
     #
     # Standard native builds
     #
-    generate_dockerfile("alpine", "alpine-318")
+    generate_dockerfile("alpine", "alpine-320")
     generate_dockerfile("centos9", "centos-stream-9")
     generate_dockerfile("debian", "debian-12",
                         trailer="".join(debian12_extras))
-    generate_dockerfile("fedora", "fedora-38")
+    generate_dockerfile("fedora", "fedora-40")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204")
 
@@ -191,7 +191,7 @@ try:
                         trailer=cross_build("s390x-linux-gnu-",
                                             "s390x-softmmu,s390x-linux-user"))
 
-    generate_dockerfile("fedora-win64-cross", "fedora-38",
+    generate_dockerfile("fedora-win64-cross", "fedora-40",
                         project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
diff --git a/tests/lcitool/targets/centos-stream-8.yml b/tests/lcitool/targets/centos-stream-8.yml
deleted file mode 100644
index 6b11160fd1..0000000000
--- a/tests/lcitool/targets/centos-stream-8.yml
+++ /dev/null
@@ -1,3 +0,0 @@
-paths:
-  pip3: /usr/bin/pip3.8
-  python: /usr/bin/python3.8
-- 
2.39.2


