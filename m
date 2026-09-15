Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1687C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZbP-0007fP-CT; Tue, 15 Sep 2026 16:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZc-0006sN-Mb
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:18 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZZ-0003Hw-6k
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:12 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so1165915e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503368; x=1790108168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n037Ir9RlPxu5Jvv/I4vRtw1w6P183tFYwhqNEy4JVk=;
 b=QC8yCTLdcPgtHfTbF7MklQhgHjb44i8kV+EtXRc2cyT1QDCVmlhmNf5vnL9W8dFaVM
 6tJH8hHg5aizhpMJM3eCsFBV5GF/OGVdiD//sJu299Cb3cquX7X4pU6euZPDuNXPZzuE
 1TzamFvdxBgcq5CFox7zOEVZaS1QtB/NLZ2l98M2wGCmbOyzXJRJYK9zjutL31qBwOlq
 JmTVFTVNQMwp3ilZ3VbhiMu7hcKe0g7tnu30fyyph6XpIDXr6SwpliT8ANZkXsVbt9oK
 fxbj/d2ETw96GGL0520JGyHGSrakRAabPTgTHYPHwVba6tSkQq6IW4BpUJhoT0axVIi8
 6Y4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503368; x=1790108168;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n037Ir9RlPxu5Jvv/I4vRtw1w6P183tFYwhqNEy4JVk=;
 b=LBwb6qezD1LRYCEQOlygQ90MWhUqucJ09eHZ7REhEHdk5inWsWINhDTIr0bdwssf+6
 A5W9DOvX829eaEBq8EIAEhebkmZ/ZvBSGaLCCOIjRu4F5VfJJGzfSf1AYl/KRCUB39xv
 rGbwBecR+eE9qyO/7hj4sKs38jeUTO9/EOrnZKTw+kVdr4lfi3kR5UIHsNSRMGR2cU5n
 AW/6baViVygHmhkY+Ss0mTgqSOZbLD8STqSfmeNiiQIL8HNYSKrWROU8YZcxaefUpLcw
 2tuV8UbTPz0ino6A/dWCV+N033sXqt4tjotyNOc+aS3clFw1YX6fz1Dxtp0diGAcdvSO
 CoVQ==
X-Gm-Message-State: AFuF++lN5NEFu5Pb/4SWgJwDKoDWJUqKyC4/lGyY4LcRcUais9ne1F0o
 H8NrsRs1gHTekcEJF6onVkQQq6prl2Ioyqb+zsLhLwvC+2N6rJ2oe1+f3jALDTZhtVw=
X-Gm-Gg: AYBFou2NtvM4A6kDCEpG91Fn+4kv3RrDBO2Vqwqx3lfZ3Iyt0QKvpmTA8hofbiGQvK/
 7WfXSanH2odva0k8sCATDGLezK0vF7vUYuQ9nDaYSVR4JEo7TO8cvEnLE0kSpJ+pHUkzoE0sGcx
 oqRJqLzTppLErAzoBwxxoIrPIl81/BwTp2YwZGDlD65YFYNj7A5iYjwK+2+2Y5PkWgSLOmVN7ca
 VxoBXnA4B2eWnRa7zv4ppGUBclEL0uxhmD92zbuZI/GxqNzO2n86YdPCNTlXvdZEjLiYB9lAKcm
 eBNg9s3Q744VjxkX4oSxItQ1oZBAGwltI3I7XMGDKn6U3vTz8yd20yneBtQByr9lVsP00QdI6GU
 nNMxuNTngGB+fFboO/mblCafTRaE4E7VsxAvGVNbyBjLKCojnCpzYm4j7xGK1ZJrSs2Fq0LLkmp
 JggOwFlyXrtBbkYhMOjuYsHALsZFKpQZ3mN4AHY5q0lJn13pozXsd9dr5W7uQYud9qmxz1XUnWc
 v+Lg4Et8A==
X-Received: by 2002:a05:600c:5486:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49e7a66aaf9mr105862885e9.16.1789503367703; 
 Tue, 15 Sep 2026 13:16:07 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf43542sm1375171f8f.32.2026.09.15.13.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 770C4618D2;
 Tue, 15 Sep 2026 21:16:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v2 08/15] tests/tcg: use --add-current-user when building
 containers
Date: Tue, 15 Sep 2026 21:15:53 +0100
Message-ID: <20260915201601.1207839-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


