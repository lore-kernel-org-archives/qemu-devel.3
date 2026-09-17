Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE667C982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FPw-0007zQ-7o; Thu, 17 Sep 2026 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPB-0007e5-9S
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:14 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FP9-0000a1-HK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:13 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so8366385e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664170; x=1790268970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Za3IBRxsCVyA6CkYVC7ysWM1r0DTtcSs0KC0+G3mThQ=;
 b=CJxntfZrOejS/ZASLH2RrucrrhXcA2oFkbCuQgWh/YlQH8zE002/AGUJUOMswGr7Dr
 D65xfIsfAvgDVZBVT7I3z3/v065wQoTMpboZzAmbsM7f5h/JFDxKHpEwIMLwFurdTsx4
 rocO5I46K9lpZs8FQKPKlzStDWzHxWvSuKhLgqQixDtT4TCo8IsALlElRvQJSUh7wjvm
 jpdLct/TzSTF2Z38SCrW3iQMqapm2P62BJaiY0Pmeo8xjNQ6o2kAXHjYeO5lf2wKAl7F
 eLesPlcL2W6Ex0QajTYR1wK1jKB1Owuyzd2SSotFqxlDIWsuVY/aFrN+f+u/89zIEwwj
 4gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664170; x=1790268970;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Za3IBRxsCVyA6CkYVC7ysWM1r0DTtcSs0KC0+G3mThQ=;
 b=K8z03ricIXK036pIDJ5aTkpW/I02zOV49eIuF4//t7HNnyEntulcwhHK+vi9ua8FyQ
 P7NAtg8PzwrWitf3tmXg2C/vSTerwmyHlSvEPiPUZL3n1r48YQ2q1JpPfgQh/5GyfH5g
 Y38kvFk+gtb+Vey7bODcbxJOxTdStWsouqZ7TZZ1qtAbGsAab6GRGjXVGDaXJkqg4dy+
 49q2hVTpf23Wa5ZgUbt2h35m+ivqN0JnlmnEckR8sHCsUDha+B5EDvkqiS2wQeQBgcq3
 fcpRjVIiGf2xM5s2TR+FzMEJsJfwdKUw91arsCYXwff8V274V/rV/Rt/yO+x84ZQx8mN
 mq4g==
X-Gm-Message-State: AFuF++mymFqNCTtgZ4/6aBaGPVk+PRyaV/dLVXX73VCLgD/EoPsEdPEu
 JxmB21SY5sXrGapJZ2yMtZ8zIEOqvFoxW6saKW4gCmrGax8XRBCRBZi/8x7EISicH/w=
X-Gm-Gg: AYBFou2l2b7jZWPKEyraR10NIEE8YpvAv989aYHNyxe2G2x5WuWr4HOFWSayxaIJrNO
 QgQJWTSLkZXmWFUr6rdp/tODpknDKFX72WnIHq47w1Vs/H+Cw7NqclUdqbRi/fv2UaT1E6hLCRW
 bt7FnGkBNnGgde9+CoMtVJczlYgnbj0+776OjMjKGR6KFPqsV0RXk9RAk4Cd3R7jjx47ntWVAOW
 DfjXyi4tIPMPIjL7EaEiArFFH0WaGAfY1LOUO5scaRR/5N3oCVqFbjb51C6Wg+j/z8W2AzjXCiN
 fihQTRiWJo+E4xeJakv3o8UYQ0D8K4jtHf5OVHRkuZlmB+o/7x3ARmEezapSJRC5m/a5dwL1oup
 fkQ2AaWu2dx7F4YHtJ1xdK4LT15W78sB1ccl90SYOsUZtLAL8EEUJGEZLUW3H4xIx/dF2LCGgGE
 f7jjWKEGVR+KDoLsQeUlpu59UTgvy6Q7SQ6gunusoxqIDamUmtcmbq6OhGwWFH8vJdmBoRiT8=
X-Received: by 2002:a05:600c:5486:b0:49c:fc6e:a3d2 with SMTP id
 5b1f17b1804b1-49eb732cc30mr89424965e9.17.1789664170089; 
 Thu, 17 Sep 2026 09:56:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd24774esm142172045e9.10.2026.09.17.09.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:56:06 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF4775FBDB;
 Thu, 17 Sep 2026 17:56:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Brad Smith <brad@comstyle.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH v5 07/17] tests/tcg: use --add-current-user when building
 containers
Date: Thu, 17 Sep 2026 17:55:51 +0100
Message-ID: <20260917165602.3405537-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
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
index 0604c4b90b9..814f2f8cd8c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -255,7 +255,8 @@ foreach target, plan: tcg_tests
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


