Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0F9CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cW5-0004zO-F5; Tue, 14 Oct 2025 06:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVL-0004Ud-8m
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cVC-0003Xr-RI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:43:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so61306725e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 03:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760438609; x=1761043409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r45X5ko4sE/c2FtYGn13TPAX2fRw1g2ckflTuGJ2jhY=;
 b=GWTswMGChT0bXaqk2l8yXpsVIJ5uOKsm18oyE4bWZU071aGcx3GG0PHb1lCI2THERd
 o9V46qRSifrsiRIXTgmizVOqCG+puFl9yfNjdWjeASalf7LmVE0eZ1isbzwd9Y4DOycJ
 cGZVr0/eE8Xn9qw/AKiGN4BC2vBFfOgz8T2MUGfXQNS3A9ELVZufcx7/hunKrYLEinE1
 4DAyIFlBlR+V3B7LDDq4A+I4hNv0ixmS9SpdOv8BmHjhYWeRK7ng5tcDCz5tZdXfKf1C
 xLtNRhRJ4fO97eEv1Sg+FByRhpXdIVfQPOkW611FK4dmU/16U8kNK0xvVtWfEYdDVcnA
 Df+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760438609; x=1761043409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r45X5ko4sE/c2FtYGn13TPAX2fRw1g2ckflTuGJ2jhY=;
 b=GPwGqq4MssqFRC0yiQlt3FwSSmwwoMHPKANTPZ52vHA/zNTwBGQZHZyphsWIpP8pQV
 Bm6v+RaxLJg8h9/E8W2ofE7/FgCBm8GF25c2op0VdajGR6mKczaUdzkSpjsOBeKRQp+L
 mXKmSeEHGby/gEymG0BrSjEIstOrAM+cpo0mSfbjURfSCBnMooieKvmlFDofpqjynKsj
 SuNsLB0pVTQFk1b3CkHRyCSsB6SyIA5e29QgKiHI146hDjYZPPlyzm0M8v2Ksvb6YIgd
 FPJp+VsKG8WNOn477c19mOULQJHcx5Y8UUg97WHp900bMPOlCT8UbuAoYpqrGnMf1YWM
 7Erg==
X-Gm-Message-State: AOJu0YxADk+Ga3P06ZRiHV8x5FwjBDgoPFLnQIPzwVCgCjtqh3lAHZPF
 zT7oPeFUpQwIgSeLAWrCOr9oTO9OZzS9lFq57udgqxJXtsB0CPg09Xoy+BkGQKUoY1pp4Ztv6Pg
 LEtX3
X-Gm-Gg: ASbGnct3vYLx0HY3TWA6/Oe2GRMl9dR2BZb2KbrFFU7/ino68sHpVG19QMGrPflksO/
 AudWj7XqdcyXPyRanIQsQakYC0tUjcfBSek1h9SIOYsaz9ZVq+GB6JvDtezWqyo+zJTcSJsvAoF
 VzC8gzQ/sdKnLOI5lumpOGmjn54CrDX+5QGekdzFwBzUexhf20NtUDrdZadMDnpxYyJWuP0v/BZ
 SOTWHKpMDbTN3GEfxxbvjLlbtA9rmvc8wcf6Ke44Iu7638KUqTQKyBdUuFdGN+yvE95zWVrG0pN
 il7yTLYa9TlJARDeSUSO0v6t1WE9rW8BPbsm1oiorc+GngfqOKmH8sspui4KnnELHsUhP1ujGFW
 VHW4KuQ1eYa86fbH/ZyPvQcozp/ceRibogz+dFWO9XCDGJtM7C3NdgHjF
X-Google-Smtp-Source: AGHT+IF/Rdi0wyw5+KNsYZKCKc+EZcPxPF1mNI0UCjz4hllr7itM2TSi0FYDswTvI+LN/7l1fNmn3A==
X-Received: by 2002:a05:600c:6287:b0:46f:b42e:e395 with SMTP id
 5b1f17b1804b1-46fb42ee4f3mr103004735e9.38.1760438608987; 
 Tue, 14 Oct 2025 03:43:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fc7abca48sm51133185e9.5.2025.10.14.03.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 03:43:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF9865F9F7;
 Tue, 14 Oct 2025 11:43:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-s390x@nongnu.org
Subject: [PATCH 5/5] scripts/setup: update build-environment to use armhf yaml
 (!WIP)
Date: Tue, 14 Oct 2025 11:43:22 +0100
Message-ID: <20251014104323.3023714-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014104323.3023714-1-alex.bennee@linaro.org>
References: <20251014104323.3023714-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Now we have properly updated our yaml to contain just the cross
packages lets injest that in the build-environment script.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
TODO
  - currently I hand hack some packages that won't install out.
---
 scripts/ci/setup/ubuntu/build-environment.yml | 22 +++++++++----------
 .../ci/setup/ubuntu/ubuntu-2404-armhf.yaml    |  2 --
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/scripts/ci/setup/ubuntu/build-environment.yml b/scripts/ci/setup/ubuntu/build-environment.yml
index 6042750cb4d..f84157dc655 100644
--- a/scripts/ci/setup/ubuntu/build-environment.yml
+++ b/scripts/ci/setup/ubuntu/build-environment.yml
@@ -47,19 +47,19 @@
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '24.04'
 
+    # the package lists are updated by "make lcitool-refresh"
+    - name: Include the armhf package lists based on OS and architecture
+      include_vars:
+        file: "ubuntu-2404-armhf.yaml"
+        name: armhf_packages
+      when:
+        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution_version'] == '24.04'
+        - ansible_facts['architecture'] == 'aarch64'
+
     - name: Install armhf cross-compile packages to build QEMU on AArch64 Ubuntu 24.04
       package:
-        name:
-          - binutils-arm-linux-gnueabihf
-          - gcc-arm-linux-gnueabihf
-          - libblkid-dev:armhf
-          - libc6-dev:armhf
-          - libffi-dev:armhf
-          - libglib2.0-dev:armhf
-          - libmount-dev:armhf
-          - libpcre2-dev:armhf
-          - libpixman-1-dev:armhf
-          - zlib1g-dev:armhf
+        name: "{{ armhf_packages.packages }}"
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
         - ansible_facts['distribution_version'] == '24.04'
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-armhf.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-armhf.yaml
index f06f95514bd..e361357a0ea 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-armhf.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-armhf.yaml
@@ -19,7 +19,6 @@ packages:
   - libcapstone-dev:armhf
   - libcbor-dev:armhf
   - libcmocka-dev:armhf
-  - libcurl4-gnutls-dev:armhf
   - libdaxctl-dev:armhf
   - libdrm-dev:armhf
   - libepoxy-dev:armhf
@@ -29,7 +28,6 @@ packages:
   - libgbm-dev:armhf
   - libgcrypt20-dev:armhf
   - libglib2.0-dev:armhf
-  - libglusterfs-dev:armhf
   - libgnutls28-dev:armhf
   - libgtk-3-dev:armhf
   - libgtk-vnc-2.0-dev:armhf
-- 
2.47.3


