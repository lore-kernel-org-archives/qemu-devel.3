Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E2FC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lP1-000840-Qk; Wed, 16 Sep 2026 04:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lP0-00082t-Qq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:54:02 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOz-0004zj-9w
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:54:02 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso416009f8f.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548829; x=1790153629; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n037Ir9RlPxu5Jvv/I4vRtw1w6P183tFYwhqNEy4JVk=;
 b=hHLfguxw5XuoagVL1NfFuiYYn/HXSkZdXHahDdIAhoTpO7CODbAsThw8T7p5ex92tn
 TMetXf8Zh8YgmYocQDmjNg7Hu66u1mqooG4CZutT0uvkV5jxlwDQdvNVii/wM8+FNrIo
 k43sU4PAzL9uWqlMky2FwrQP0zDHMT4VYjh6D54NnnHLr2a2qtzgdcYXEgpYLh7KX5hJ
 28DURgqpizXJsqX6LLpLjD6IlDM2nSlw7Fhp7SScIsYxLkxo/84qOIF1ZPDlkeI6NlD0
 kmz6p6SjUPvX9y1ZLKvLf9CNQK/faaHccBdCB6pAyYGEWqDnhFoRKnGo9NBCfwKHrBud
 VKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548829; x=1790153629;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n037Ir9RlPxu5Jvv/I4vRtw1w6P183tFYwhqNEy4JVk=;
 b=1KD6v+FSNFi+LNoTxjltm3Hh9NjskI9zr8okGOI4P9K2XCgcw+Y+p7AnoBXHeKFJhv
 KYbGRcBRFtBd4XQD/cXs7Qi8zDim9FkqPC0UzgZNUpnGGPMX7t1gs/MW0GnrCRnKfA5F
 h+9DsVq28aZqg8V5Oj+Hxeru1ghxBYKz2tnME4vl9L9f+20NM9rBgVniVCZmcXe/WYYZ
 6LurUgCWUd+k6EmdiNt1vdHtBnTqlUp6qNWOFDPPZEVSNzdymKfROh7r+Y9M3asc5aqt
 lwT6/steF+2icUyB6OZ9kX/LCjk/DSPnLvRXt5BM53YqXQipJ1z23CGmakXtsN3q88Hp
 F5aQ==
X-Gm-Message-State: AFuF++nrk3q/eAmh7BpHRXGh5gwcnxPxisZ6Xh856ygwZthOfoxBqphY
 8W7Qxv13MHvRdt39VxJ40clvtXHN61fLXhqRkR2+j5X1hYHLPub2InPTp2/Jh0YPHc4=
X-Gm-Gg: AYBFou0krERw/NYuZvdLyKAzCUWPhJ/KMOvgRxp1bXA4aO0l0ly8z33uF/QXPH5cB6H
 tDUlvvPx2H7rgVIvWzpgedslPWOxPOXLIx3AOLq+Qv0FDtfx1EQ49wpspOFN42nGWbKyW/Rftkf
 VfPuMd1u/cQDAH/CMBn0JCUgsKXv3E3+X5pA4goCnLFrLKrtjL/4giBsbqzJpf2AhBGyQX283xy
 BxLcFhqD3NkI9wntFaXYXDw5ZNmPcJ4ySvjeyZrk0piEawg17nFLywqTOVLe0bB0lD/Toea2orA
 voYL21ByyphzJfawz5eGcTgLc8ApbUVV2c6emXO2PIrl4Ybtd9j9PgjYdruCKI20k+ANi6rO1A+
 blOBRQ7qsluFhnUFY6Yapdkk7gdI2+UqYdUTaRpdnjTW7XndiBh+PHvHYqP65Q6wqG5QMbdKAOP
 me69qi/EXwM3h2FHOgHntXl+IMjjwLIBKunmGjTWmkLdcT9WtafCtF0fy+6h3+1ak/UOlsP6A=
X-Received: by 2002:a05:6000:707:b0:487:8ba:8b4e with SMTP id
 ffacd0b85a97d-4870cd87fd8mr2144955f8f.0.1789548829084; 
 Wed, 16 Sep 2026 01:53:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fad3sm4991867f8f.12.2026.09.16.01.53.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 473FB618D2;
 Wed, 16 Sep 2026 09:53:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 08/17] tests/tcg: use --add-current-user when building
 containers
Date: Wed, 16 Sep 2026 09:53:31 +0100
Message-ID: <20260916085341.1692742-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As the meson tcg build routes the container builds through docker.py
we can also clean up its hack which involved appending a RUN line to
the dockerfile. All the dockerfiles that care will work with the
--build-arg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 13 ++++++-------
 tests/tcg/meson.build  |  3 ++-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 315fa2ff848..6090a9dc957 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -297,13 +297,6 @@ def build_image(self, tag, docker_dir, dockerfile,
                                              dir=docker_dir, suffix=".docker")
         tmp_df.write(dockerfile)
 
-        if user:
-            uid = os.getuid()
-            uname = getpass.getuser()
-            tmp_df.write("\n")
-            tmp_df.write("RUN id %s 2>/dev/null || useradd -u %d -U %s" %
-                         (uname, uid, uname))
-
         tmp_df.write("\n")
         tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s\n" % (checksum))
         for f, c in extra_files_cksum:
@@ -315,6 +308,12 @@ def build_image(self, tag, docker_dir, dockerfile,
         if self._buildkit:
             build_args += ["--build-arg", "BUILDKIT_INLINE_CACHE=1"]
 
+        if user:
+            uid = os.getuid()
+            uname = getpass.getuser()
+            build_args += ["--build-arg", "USER=%s" % uname,
+                           "--build-arg", "UID=%s" % uid]
+
         if registry is not None:
             pull_args = ["pull", "%s/%s" % (registry, tag)]
             self._do(pull_args, quiet=quiet)
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5e2ee3e6e3f..28a8e7a0558 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -217,7 +217,8 @@ foreach target, plan: tcg_tests
     image_name = 'image-' + cc_dockerfile
     has_docker = docker_host_arch_supported and docker_supported
     if cc_dockerfile not in image_targets and has_docker
-      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile]
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile,
+             '--add-current-user']
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
-- 
2.47.3


