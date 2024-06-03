Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C04C27C52
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsg-0007EV-Ks; Mon, 03 Jun 2024 13:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsN-00072p-RC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:44 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsH-0000AT-SY
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:43 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2eaa794eb9fso29804011fa.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437216; x=1718042016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evivfxd//u248pB/wuxxX0v0kMcuc3vdhqbsfwPCZNI=;
 b=RyXIO6Y5e8KhEzltBeuuoMCmSYoE9Mcpemgqc9teOOt6z6Mr9ioGH8nOnl42JieRfe
 fIZNEb1gQJ1LwvcRv4wDxam/aVvIj27ufdV2TMwr71igV0F9bIgayhD3J+abXx6QwVMy
 uVFAtxEVmcQ/HFJUODFwMTd0tL6/WQfdOkeUKST7oA/3DGBlFxdhHtC70AEsBPskUa4P
 Drj8gC1/CAc4+wkc3czi8lNwwe1xjE7mRoxE5L8rv/TDzzZDfgBDB8xAV+kCqA5U9K39
 vibq8h7/3wnPWQHyaL3Ih/JQolNbHifNdXgdu7zNDjRkxQ5VufGYqFoHv8NzB9Kbn2OJ
 hMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437216; x=1718042016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=evivfxd//u248pB/wuxxX0v0kMcuc3vdhqbsfwPCZNI=;
 b=U+R1BVHI98I7+2690t01Xs8f8ZNQ3R5fAm72C5krwsA8heXaPMZpj0MGZtnVXc5hVF
 wxd1uVTlFiNM/vgodSsr5YHw5EX9oMuuVnnUGAa+5hKnUF2ylQXWi3h2bpyIATZwUnDD
 NSg2a88BSTiNhShbLAE0OSFTbOSM1BxbeomDoq6P+cUFNil7K+tn56Za9LjMQC2/MWTT
 W+oBVtAD5b+PjscsRc0bdew0ojrhlciTbf6EcvU3SnVza7+CdzWFHqRYcXX0gBcVAxpv
 USh+EQig+Dg4BERMPYKFl82zOntKQg+61q8WV8FIy+gR20/rZRZBQ6zwrM2YEphTICwT
 iLAg==
X-Gm-Message-State: AOJu0YwU1d4jZhNAh+hQeQd0LZASN8wzMbMkw5NYFFV0zecU5CISEa3W
 ZbZWHJgbCXYwv0fMJYdVPiqW4bzky/QVm4NdShL+n9ZYxyOfWSnHR7zHBZa03bA=
X-Google-Smtp-Source: AGHT+IFEIfuFuMp1xHbLpdG8zfFz9rbX1l/B55wAXshfTwRuhblQvD4KXsTwkty8ro1cRvZSpevneA==
X-Received: by 2002:a05:651c:1504:b0:2ea:b956:db2b with SMTP id
 38308e7fff4ca-2eab956e51amr10220441fa.7.1717437215945; 
 Mon, 03 Jun 2024 10:53:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04d943esm9298741f8f.47.2024.06.03.10.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 67B055FA03;
 Mon,  3 Jun 2024 18:53:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 09/12] tests/lcitool: Bump to latest libvirt-ci and update
 Fedora and Alpine version
Date: Mon,  3 Jun 2024 18:53:25 +0100
Message-Id: <20240603175328.3823123-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x234.google.com
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

From: Thomas Huth <thuth@redhat.com>

Update to the latest version of lcitool. It dropped support for Fedora 38
and Alpine 3.18, so we have to update these to newer versions here, too.

Python 3.12 dropped the "imp" module which we still need for running
Avocado. Fortunately Fedora 40 still ships with a work-around package
that we can use until somebody updates our Avocado to a newer version.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240601070543.37786-3-thuth@redhat.com>
[AJB: regen on rebase]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker             | 4 ++--
 tests/docker/dockerfiles/fedora-win64-cross.docker | 5 +++--
 tests/docker/dockerfiles/fedora.docker             | 5 +++--
 tests/lcitool/libvirt-ci                           | 2 +-
 tests/lcitool/projects/qemu.yml                    | 1 +
 tests/lcitool/refresh                              | 6 +++---
 6 files changed, 13 insertions(+), 10 deletions(-)

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


