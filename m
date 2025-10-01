Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A91CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v40M1-0008FX-VB; Wed, 01 Oct 2025 13:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40Lw-0008DO-Gh
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:56 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v40LA-00035k-Dj
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:10:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so42190f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759338595; x=1759943395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/US0p2hhA2GvxAL6/BREQXqwUIjr3fUWylgL4CnUZcc=;
 b=R52ARPOD82L238lSqAmTx3ToqVh7gaMruRLxUebKrJSSnWHGDrUgtu1TJkwF4K/RKV
 CdqUDSRhldVpLRbunujJYJUvi0Blx3J9ap00t7Tsl2DSlaShlhGKmVIXIggsAwn7MVWk
 GKp6av7ryN+IscxH/GWTUJyEDl4628n4GTyqIF9fbkj9ohvii3yarxlar4wSmL/mhzWj
 7eEcy8Y/On4wHpCjYKy3KLsku8mZHuH4EzM0RuMhHDkdpLKohSlwX2TPGD+CEVq1pRJv
 tkYjdo3UdNCAuZy2Bqh+Dci77apHk4jQamdbejhvYaSja+54bWWlOj7M4yXNAQxN9f53
 XO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759338595; x=1759943395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/US0p2hhA2GvxAL6/BREQXqwUIjr3fUWylgL4CnUZcc=;
 b=NedYP6VHbah1xmJKPyxUKgysfGm5cmOV0jLD5rn9CNEcirNyDJfNzZeFVZgQPtO6O8
 q968FN2YYNKtGgzlCRk24Qxom+8KoIOnDLiYLhtOpipMdxjwOGf3aXl30j11fzhfegK4
 ATgaEn+t45uMJjMxOzeTyf1fyfvlQO7LatG5/jcpr9j7cvQ83X8N2HNc2or6CfLcdLs6
 hTMcWIiOlrieLsKlHYRtbemf7KaLwRILFdGLtZmSGsHetUkFTiam8GUJ9ANf9BdFkshq
 /+SyLuHA7vb7LW3liMaXJtBoYomOyQN7nfC3WafN5seHTrCuEvb4lzGLvFg/FV1pzE5U
 nnIg==
X-Gm-Message-State: AOJu0YwGG3BYLP212uCSXfMF6BWr8JIy1ShPN0HEfmnwSreENzavdFn6
 41oVv7whouQrZtqxfFD8EnDR4MGiRhBqqTq07z9ln8fAB4fYpMeRsur3aE+Hgw0/ZsU=
X-Gm-Gg: ASbGnct9yVAZr+Hh3GBeX696B3pAMHopAMP2LTzwVretq0iuZLaNCFo6nsiUZTMseVD
 RUL2aXo0KiTkfQALRzHv2dwmmaksryus/QFGue5t8Z5b/cFdiUhDksFstBf4XvNJuPxd/qzc4El
 bGt5+rixkQQEtWkWlu1JimOBO+HJcvVZdQmhG/wC8NZRBFM/k3pTE65qriyHsvNgigH15KaXE2F
 Zj5X/hPU2RfEew3nrS9OEZuxU/tdrcV7cnCqLZyGwwFI//MNzxHg+167t+L9Stdlz2rCmsdN3hn
 i/TgYcq70JvhlQvYa+Z0b3S9rCC1U3zgGLZIz7/wLvXoPKh5IgpSYDfLhkZ3axaGJBVtCg4Ors/
 6wQi/5NEmjCnFjoFKCj3T50vbbtDp56qPCJDoVfd1zOYpo7piaX/SP7hQEA==
X-Google-Smtp-Source: AGHT+IEPB12wlU5H0rXR2dSO0LE7UwFkkLBX5oStLNiCYTsZmdsOUFA5p3xKqed5/q7UJ6WNDP34qw==
X-Received: by 2002:a05:6000:240a:b0:3e7:6197:9947 with SMTP id
 ffacd0b85a97d-42557a15b6fmr3397315f8f.53.1759338594596; 
 Wed, 01 Oct 2025 10:09:54 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e675c67f7sm9045965e9.2.2025.10.01.10.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 10:09:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC0C15F80B;
 Wed, 01 Oct 2025 18:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/7] tests/lcitool: bump custom runner packages to Ubuntu 24.04
Date: Wed,  1 Oct 2025 18:09:45 +0100
Message-ID: <20251001170947.2769296-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001170947.2769296-1-alex.bennee@linaro.org>
References: <20251001170947.2769296-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/gitlab-runner.yml                   |  2 +-
 scripts/ci/setup/ubuntu/build-environment.yml        | 12 ++++++------
 ...tu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} |  4 +++-
 ...ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} |  4 +++-
 tests/lcitool/refresh                                |  4 ++--
 5 files changed, 15 insertions(+), 11 deletions(-)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-aarch64.yaml => ubuntu-2404-aarch64.yaml} (96%)
 rename scripts/ci/setup/ubuntu/{ubuntu-2204-s390x.yaml => ubuntu-2404-s390x.yaml} (96%)

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


