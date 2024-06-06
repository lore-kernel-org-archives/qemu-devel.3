Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9CDC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBe6-0007ob-TT; Thu, 06 Jun 2024 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe4-0007mS-LP
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:04 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe2-0000u2-Fs
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:04 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a85cc2d96so1009315a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674661; x=1718279461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7e+DB9WxY9n4W+zWt8GKNJAuHA8yb0ZH9yWXDsgA2Xk=;
 b=LRhPB5P25pQPkgKrjpWWz0nuXWd5RBj3lP2A9TLmB5OmQfd+Q5OYqt1/038MgqtAJJ
 b6Mk5bJHZutjXYmPXMIS2yTEtR6g1iWgpKnZVla524e26SB6H1czX7PGVYG6/cauQDq6
 FNOyXn4rZQHPIxdObaCNrSQlrN4jbBqFMZbbdXdyg1Yuy/l+DpiJDP404ShYbmNGZgxl
 rut2X2Sv6iZ52KVdJXF+/qMEAjH1FFLebhR22y5hk3j5ll/1ZLVBL0syqj+/MdLj6ZXU
 RjoBE9bIWaLguPbEoKhHuIhRWgqBI+X2npNnAwFWs/kO5PWJ4BpISC0PiFuEP/FGAgAU
 NNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674661; x=1718279461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7e+DB9WxY9n4W+zWt8GKNJAuHA8yb0ZH9yWXDsgA2Xk=;
 b=Aid/mZtXvdjT0hoPMOo5YNRUEh0Ve9vjyyISA6QEfkmGa4sGq3rG+KAJv8UTSezyXw
 ggYrnakWj7U02vDzY+gM79nXmLVNZz7/s5kGyexP7RpFwtPG7Sbna4BsYuCHcObQJZei
 /LOiBubGaADDTrwE0JGykflrnNCoxdbGCuuDhAqd40MUGwNK267GheLGNS027VYPb1FY
 lzTaWN5NObQIODc+lj2g+D8TTHWnufg0SDYjNgSPNx3V4CFJPQfFAFCBfNb7ju9Lbh1O
 VLG9K0cBO4Z7bcUf3G38AfchUjODp9/BNqkmpPP6WK2WtJqeAK/YReC9cAYoPVmLf5CZ
 g82g==
X-Gm-Message-State: AOJu0Yx9wu5PKiw9tKQUpZW4w3mU/1CiuUOJz2RNZSIW5OV4e1f6rQlp
 lPzgBON7tBXJdtRgqiCxGto44oFIbRwMFBpVZzsNBOVNiJrz+bZTEvCD8GUawZw=
X-Google-Smtp-Source: AGHT+IEZuMw8/LXTcBbzpfFWqlggwSbAfa1k6FZrx3Bp1hDRv7Hoaa/SMYuagBktm55fUOFgPyWjpg==
X-Received: by 2002:a50:bac8:0:b0:578:6198:d6fa with SMTP id
 4fb4d7f45d1cf-57a8b6740a0mr3554123a12.2.1717674660395; 
 Thu, 06 Jun 2024 04:51:00 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0cc36bsm963017a12.26.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BFC4E5FA2C;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 09/12] tests/lcitool: Bump to latest libvirt-ci and update
 Fedora and Alpine version
Date: Thu,  6 Jun 2024 12:50:44 +0100
Message-Id: <20240606115047.421045-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Update to the latest version of lcitool. It dropped support for Fedora 38
and Alpine 3.18, so we have to update these to newer versions here, too.

Python 3.12 dropped the "imp" module which we still need for running
Avocado. Fortunately Fedora 40 still ships with a work-around package
that we can use until somebody updates our Avocado to a newer version.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240601070543.37786-3-thuth@redhat.com>
[AJB: regen on rebase]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-10-alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 554464f31e..b079a83fe2 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -1,10 +1,10 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool dockerfile --layers all alpine-318 qemu
+#  $ lcitool dockerfile --layers all alpine-319 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
-FROM docker.io/library/alpine:3.18
+FROM docker.io/library/alpine:3.19
 
 RUN apk update && \
     apk upgrade && \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 0f78711876..fef846d5a6 100644
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
@@ -51,6 +51,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-pip \
                python3-sphinx \
                python3-sphinx_rtd_theme \
+               python3-zombie-imp \
                sed \
                socat \
                sparse \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 098c894d10..44f239c088 100644
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
@@ -110,6 +110,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                python3-pip \
                python3-sphinx \
                python3-sphinx_rtd_theme \
+               python3-zombie-imp \
                rdma-core-devel \
                sed \
                snappy-devel \
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index cec6703971..0e9490cebc 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit cec67039719becbfbab866f9c23574f389cf9559
+Subproject commit 0e9490cebc726ef772b6c9e27dac32e7ae99f9b2
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 7511ec7ccb..070d7f4706 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -89,6 +89,7 @@ packages:
  - pkg-config
  - pulseaudio
  - python3
+ - python3-imp
  - python3-numpy
  - python3-opencv
  - python3-pillow
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 789acefb75..9d8e9c6a4a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -124,11 +124,11 @@ try:
     #
     # Standard native builds
     #
-    generate_dockerfile("alpine", "alpine-318")
+    generate_dockerfile("alpine", "alpine-319")
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
-- 
2.39.2


