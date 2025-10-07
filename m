Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F39CCA472
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Io-0002lx-Sm; Tue, 07 Oct 2025 07:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IR-0002Y5-Qk
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:01 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IA-0001Jh-Vo
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:55:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so61954205e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838137; x=1760442937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mko4K0zkdxia3qhWvOZZbpi+U6tsddkCZqMxkCCGGX8=;
 b=lJjMSQMXqIsG+qBPPjaTZN76jZjnl56+4bDfEYfg6usZ5XkpMmo0ilnRIxmWXkYmEL
 5Gcr0PmOKVy6Jt773QpBPQL3pS4Y+A4jKowf/cfsMAw6octu1wDWZHDuVoyVbBLytgv4
 LkSbQOAyoxyzBdulQNISnSqgcXmK6N5fsJrWA0PdvGd664NHm/BNagzMPdXAIJOTe/Bx
 W2Yc45cJKmMeVKVrXKElFd+vkrRqRQczXIiorbQYSO2PFMGUBCWU/O/SGJzz+dw4GrYs
 Z9UOSPePdXXrFiBpaDf2VXcqS9BXNdKe4p6JXlDXna24HYwcH4iO4KlV1BNJWLH0ca7i
 +AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838137; x=1760442937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mko4K0zkdxia3qhWvOZZbpi+U6tsddkCZqMxkCCGGX8=;
 b=Pmzvks1/rhy9h1Jq1qY2nxtY8bdQ7u8jMHV1R/NGyEMqQVsI8MrqOEQlrQRSa7Ibc9
 iuG/KUcwzClZ6n6bu3EIJKMf0j59gI2ZQ5jQZPyAulI3bml6IcmmDo3b6qgnCCGbOu3+
 x4NnkAAZ6EXxShboMFA912oEweX0ZiX/AJu60LAkT4eBymfFtN/MW2Mt75LUnXo77g2W
 1ycS2FcnlY+M52Ao5TAmMmi5E/+S6BwS5DkioPeM4ddeVCce6A/yF1QM5bdpO+9dWsA6
 feYjO2frCBNHwaMxE7tx0w9Wcx1qWcDAoOKUHhjtE/+fy+21PPxoAdYWmGuVx3CARD4m
 HrRw==
X-Gm-Message-State: AOJu0YyzHEz9khRigeAkxIVxWsXK/YsB0D6l2pXG0Axd/qt9Flah+ebj
 GVwlT6Qd5MdglqmTyjztqbFGQY/bzu8EX1Cd6kPJaUgetytkzSia4M39xZlTDYz/nMVM07FHP4+
 E38RM
X-Gm-Gg: ASbGncv294qJO7E0bq8ezlED3938jG7mxrbgJ38MhdJ1yx76UTAeyeqUMKpS4/snJbd
 HeiJ0nxHwh5+HrApnmkx7I47C8+uSAFueUFclp9WS/Ifcwtt07AzkenO6kIRRXQN2WKbvRkT8EP
 /3EQTF3VQMeqO5CJnnan4qf2nOtA8ykZx+yg5etRdpIC4eM/IGevmrWBRrPdvJusHnqIBQqqTNZ
 F72Ibnyw4g4Pf04xDQXV48WENyOeEPqscOXBTOMBx7W+XA0BeOu7GyUk6KWJ1eyvzU5GTOjboA6
 omxl08sQa4kHVc0baJdSr1bAIjgYv5YWYv0Os5pzRG2IcPMt4FQKz2ymUZuIX0Co+fgpOuYgZSm
 7ihHYRb7Lv4XmmBmq630CEaIxhtZ+GpBIPlEm+yEPG/R6J4aQue0=
X-Google-Smtp-Source: AGHT+IFzCYYGQkcWvKrenLGAnkBGnD0AAbkrbmEitQDDrRAscuj4usxvWsqHar0hoArdHa2GuSgurQ==
X-Received: by 2002:a05:600c:524f:b0:46e:2330:e959 with SMTP id
 5b1f17b1804b1-46e7115cb96mr123710545e9.37.1759838137530; 
 Tue, 07 Oct 2025 04:55:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa2cfa2dcsm16932865e9.0.2025.10.07.04.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BB235FBDF;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 05/17] tests/lcitool: bump custom runner packages to Ubuntu
 24.04
Date: Tue,  7 Oct 2025 12:55:13 +0100
Message-ID: <20251007115525.1998643-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
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

In anticipation of new runners lets move to a newer Ubuntu LTS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251001170947.2769296-6-alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
index 57e7faebf10..7350f6cff4a 100644
--- a/scripts/ci/setup/gitlab-runner.yml
+++ b/scripts/ci/setup/gitlab-runner.yml
@@ -103,7 +103,7 @@
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['architecture'] == 'aarch64'
-        - ansible_facts['distribution_version'] == '22.04'
+        - ansible_facts['distribution_version'] == '24.04'
 
     - name: Install the gitlab-runner service using its own functionality
       command: "/usr/bin/gitlab-runner install --user gitlab-runner --working-directory /home/gitlab-runner"
diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
index 56b51609e38..6042750cb4d 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/ubuntu/build-environment.yml
@@ -35,19 +35,19 @@
     # the package lists are updated by "make lcitool-refresh"
     - name: Include package lists based on OS and architecture
       include_vars:
-        file: "ubuntu-2204-{{ ansible_facts['architecture'] }}.yaml"
+        file: "ubuntu-2404-{{ ansible_facts['architecture'] }}.yaml"
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['distribution_version'] == '22.04'
+        - ansible_facts['distribution_version'] == '24.04'
 
-    - name: Install packages for QEMU on Ubuntu 22.04
+    - name: Install packages for QEMU on Ubuntu 24.04
       package:
         name: "{{ packages }}"
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['distribution_version'] == '22.04'
+        - ansible_facts['distribution_version'] == '24.04'
 
-    - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 22.04
+    - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 24.04
       package:
         name:
           - binutils-arm-linux-gnueabihf
@@ -62,6 +62,6 @@
           - zlib1g-dev:armhf
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['distribution_version'] == '22.04'
+        - ansible_facts['distribution_version'] == '24.04'
         - ansible_facts['architecture'] == 'aarch64'
 
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
similarity index 96%
rename from scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
rename to scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index 2ca4a5392f5..ce632d97108 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -1,12 +1,13 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool variables --host-arch aarch64 ubuntu-2204 qemu
+#  $ lcitool variables --host-arch aarch64 ubuntu-2404 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
@@ -92,6 +93,7 @@ packages:
   - libvdeplug-dev
   - libvirglrenderer-dev
   - libvte-2.91-dev
+  - libxdp-dev
   - libxen-dev
   - libzstd-dev
   - llvm
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
similarity index 96%
rename from scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
rename to scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 7198fbbcbb7..f45f75c9602 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -1,12 +1,13 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool variables --host-arch s390x ubuntu-2204 qemu
+#  $ lcitool variables --host-arch s390x ubuntu-2404 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
 packages:
   - bash
   - bc
+  - bindgen
   - bison
   - bsdextrautils
   - bzip2
@@ -91,6 +92,7 @@ packages:
   - libvdeplug-dev
   - libvirglrenderer-dev
   - libvte-2.91-dev
+  - libxdp-dev
   - libzstd-dev
   - llvm
   - locales
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 185a47cebe6..056cfb6e9d7 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -270,8 +270,8 @@ try:
     #
     # Ansible package lists
     #
-    generate_yaml("ubuntu", "ubuntu-2204", "aarch64")
-    generate_yaml("ubuntu", "ubuntu-2204", "s390x")
+    generate_yaml("ubuntu", "ubuntu-2404", "aarch64")
+    generate_yaml("ubuntu", "ubuntu-2404", "s390x")
 
 
     sys.exit(0)
-- 
2.47.3


