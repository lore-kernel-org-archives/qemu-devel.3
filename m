Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DC4C88E42
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIx-00049i-PQ; Thu, 10 Sep 2026 14:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIq-00040c-Ix
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIo-00074q-F0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so1258445e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064113; x=1789668913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ym8BIau/MjTomAUFJ1gLexl30aQ1Mplhoosuj8Tqg0M=;
 b=q61DqRv8WWiynSjmyyRcCRPaYQnp4q/t+YFO/0fYuKqYiukF0ZKtw1dew7kvqgIJQw
 jHZS3kWaHykKdei4eCxvbXj/rqIOgZZKWthgskZgGQhHT8qWqzCX0AJz0yWyB3xnrM7z
 iBkou9un/MzCWdE1AmtbARsoy1Um257hz2US0XO0PEmu31Odbc4IKKBJocRvY1QArVGx
 9E+ySdMJrGHSR9zgWVepPZpGRAeiFmXvFR0IxHqjJXn/yD6/5MYNZRtxe/4H8HZ3hp8j
 2Mvgx2ibYUTGBsY95dMDikSZi/AnEJC9y6SgCNDjqdDiii222NgdznBH/nPjZB/2N+sJ
 LsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064113; x=1789668913;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ym8BIau/MjTomAUFJ1gLexl30aQ1Mplhoosuj8Tqg0M=;
 b=rd0MuJj3d213T3ZAoVLck4mNatKz2X5z6rSoP6A3waH+trXBVqUNkWv/qlS9BKI1vw
 Pc6JLbm1112S1mJmayhb7ccJrAdn9al34XM/88VILKxfh1ugHFebp+4LMHizSMfuHqZM
 9i2mYV0+c93Akmy1QUAcLv8tcadMpCteoujcmZ5g3Tpex11lOq2OHUIDbcHUGajt9C/d
 mSxiIp7CoybA6CaivRkl5hh6Nzwpnw4McqppXjkqyDRPEI0mFMR6oXrBg81aD+XXRe4r
 qOPhfOqSunNXmOglxA6ztdE694wWuDHGgwF2zeAbs6cZCfjF0rxnXmvH6tjUY0c1wf8Y
 mHqQ==
X-Gm-Message-State: AFuF++mo3t8m/XP3UVXlLEQxAy1f56/I8xnuh+4KBIAgewonsq16sALx
 g08WlJxsywYVbR583qs99+6yiNOR42lnGXjmkW89iKRf+3WQVsPfNaL1JQ90WYh17Wk=
X-Gm-Gg: AYBFou3/xPrqg3eUG6V1KlU7vzzS1Fit7QQfZsMFIUtsKvUonmJizU9Dg89H+ZrwDO1
 EXtaC9uZeNX960r8DIjBBpxkasZ8uhHJr73XqxycUE8FLg63gatvsjm5dgz16ER6f+3XVjdDvT8
 JD4Dj47oIoMKD83nq6aZZCFgttQN5IEsyuAjTPVL+7+y+fU0nhxiBBTKXL+vuFnLQEYPqe9ibxK
 mnjF82FbXeOu6/JTEMYzYUaIj8NkdNVmfug+MngmLkhxvzGlnFEibaTMQGTmI8yfbi0Qs+YtZaX
 JFIctKDkViY0hJnmiY1aQtu5MgiryDM8BHX+NapKkPwfQ/q5bWPkDnepCI8H1sppygGca/EEel6
 8D9nPAWDMazH/ekSg1OpLKc4FU6DvbjnAzsfTV/esmvWJOr2MKKfsrfOccgXqG+cqjbKxxaSRS5
 Lm5C+ltQaGVvSouJnRTMV9xlnnL2jS5WLA8lqz6H6jmeFrC0b3OhC9V6HFDXYoWAJ7x83NUvA=
X-Received: by 2002:a05:600c:4714:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49e61988ce5mr3642095e9.12.1789064112993; 
 Thu, 10 Sep 2026 11:15:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a82317sm1309925e9.3.2026.09.10.11.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B68125FCF8;
 Thu, 10 Sep 2026 19:15:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 7/9] tests/docker: strip remaining caching logic from docker.py
Date: Thu, 10 Sep 2026 19:15:02 +0100
Message-ID: <20260910181504.1010916-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

The caching logic was a remnant of an older time when we had multiple
shared layers building that went into the final image. It was arguable
that it worked back then but it is definitely not needed now so into
the bin it goes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 148 ++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 99 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index fd0cbdfe856..a2e97061240 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -15,7 +15,6 @@
 import sys
 import subprocess
 import json
-import hashlib
 import atexit
 import uuid
 import argparse
@@ -27,7 +26,6 @@
 from tarfile import TarFile, TarInfo
 from io import StringIO, BytesIO
 from shutil import copy, rmtree
-from datetime import datetime, timedelta
 
 
 FILTERED_ENV_NAMES = ['ftp_proxy', 'http_proxy', 'https_proxy']
@@ -35,20 +33,9 @@
 
 DEVNULL = open(os.devnull, 'wb')
 
-def _bytes_checksum(bytes):
-    """Calculate a digest string unique to the text content"""
-    return hashlib.sha1(bytes).hexdigest()
-
-def _text_checksum(text):
-    """Calculate a digest string unique to the text content"""
-    return _bytes_checksum(text.encode('utf-8'))
-
 def _read_dockerfile(path):
     return open(path, 'rt', encoding='utf-8').read()
 
-def _file_checksum(filename):
-    return _bytes_checksum(open(filename, 'rb').read())
-
 
 def _guess_engine_command():
     """ Guess a working engine command or raise exception if not found"""
@@ -263,38 +250,15 @@ def inspect_tag(self, tag):
         except subprocess.CalledProcessError:
             return None
 
-    def get_image_creation_time(self, info):
-        return json.loads(info)[0]["Created"]
-
-    def get_image_dockerfile_checksum(self, tag):
-        resp = self.inspect_tag(tag)
-        labels = json.loads(resp)[0]["Config"].get("Labels", {})
-        return labels.get("com.qemu.dockerfile-checksum", "")
-
-    def build_image(self, tag, docker_dir, dockerfile,
-                    quiet=True, user=False, argv=None, registry=None,
-                    extra_files_cksum=[]):
+    def build_image(self, tag, docker_dir, dockerfile_path,
+                    quiet=True, user=False, argv=None, registry=None):
         if argv is None:
             argv = []
 
-        if not _dockerfile_verify_flat(dockerfile):
+        if not _dockerfile_verify_flat(_read_dockerfile(dockerfile_path)):
             return -1
 
-        checksum = _text_checksum(dockerfile)
-
-        tmp_df = tempfile.NamedTemporaryFile(mode="w+t",
-                                             encoding='utf-8',
-                                             dir=docker_dir, suffix=".docker")
-        tmp_df.write(dockerfile)
-
-        tmp_df.write("\n")
-        tmp_df.write("LABEL com.qemu.dockerfile-checksum=%s\n" % (checksum))
-        for f, c in extra_files_cksum:
-            tmp_df.write("LABEL com.qemu.%s-checksum=%s\n" % (f, c))
-
-        tmp_df.flush()
-
-        build_args = ["build", "-t", tag, "-f", tmp_df.name]
+        build_args = ["build", "-t", tag, "-f", dockerfile_path]
         if self._buildkit:
             build_args += ["--build-arg", "BUILDKIT_INLINE_CACHE=1"]
 
@@ -320,13 +284,6 @@ def update_image(self, tag, tarball, quiet=True):
 
         self._do_check(["build", "-t", tag, "-"], quiet=quiet, stdin=tarball)
 
-    def image_matches_dockerfile(self, tag, dockerfile):
-        try:
-            checksum = self.get_image_dockerfile_checksum(tag)
-        except Exception:
-            return False
-        return checksum == _text_checksum(dockerfile)
-
     def run(self, cmd, keep, quiet, as_user=False):
         label = uuid.uuid4().hex
         if not keep:
@@ -412,61 +369,54 @@ def args(self, parser):
                             help="Dockerfile name")
 
     def run(self, args, argv):
-        dockerfile = _read_dockerfile(args.dockerfile)
         tag = args.tag
 
         dkr = Docker(args.command)
-        if "--no-cache" not in argv and \
-           dkr.image_matches_dockerfile(tag, dockerfile):
-            pass
-        else:
-            # Create a docker context directory for the build
-            docker_dir = tempfile.mkdtemp(prefix="docker_build")
-
-            # Validate binfmt_misc will work
-            if args.skip_binfmt:
-                qpath = args.include_executable
-            elif args.include_executable:
-                qpath, enabled = _check_binfmt_misc(args.include_executable)
-                if not enabled:
-                    return 1
-
-            # Is there a .pre file to run in the build context?
-            docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
-            if os.path.exists(docker_pre):
-                stdout = DEVNULL if args.quiet else None
-                rc = subprocess.call(os.path.realpath(docker_pre),
-                                     cwd=docker_dir, stdout=stdout)
-                if rc == 3:
-                    print("Skip")
-                    return 0
-                elif rc != 0:
-                    print("%s exited with code %d" % (docker_pre, rc))
-                    return 1
-
-            # Copy any extra files into the Docker context. These can be
-            # included by the use of the ADD directive in the Dockerfile.
-            cksum = []
-            if args.include_executable:
-                # FIXME: there is no checksum of this executable and the linked
-                # libraries, once the image built any change of this executable
-                # or any library won't trigger another build.
-                _copy_binary_with_libs(args.include_executable,
-                                       qpath, docker_dir)
-
-            for filename in args.extra_files or []:
-                _copy_with_mkdir(filename, docker_dir)
-                cksum += [(filename, _file_checksum(filename))]
-
-            argv += ["--build-arg=" + k.lower() + "=" + v
-                     for k, v in os.environ.items()
-                     if k.lower() in FILTERED_ENV_NAMES]
-            dkr.build_image(tag, docker_dir, dockerfile,
-                            quiet=args.quiet, user=args.user,
-                            argv=argv, registry=args.registry,
-                            extra_files_cksum=cksum)
-
-            rmtree(docker_dir)
+
+        # Create a docker context directory for the build
+        docker_dir = tempfile.mkdtemp(prefix="docker_build")
+
+        # Validate binfmt_misc will work
+        if args.skip_binfmt:
+            qpath = args.include_executable
+        elif args.include_executable:
+            qpath, enabled = _check_binfmt_misc(args.include_executable)
+            if not enabled:
+                return 1
+
+        # Is there a .pre file to run in the build context?
+        docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
+        if os.path.exists(docker_pre):
+            stdout = DEVNULL if args.quiet else None
+            rc = subprocess.call(os.path.realpath(docker_pre),
+                                 cwd=docker_dir, stdout=stdout)
+            if rc == 3:
+                print("Skip")
+                return 0
+            elif rc != 0:
+                print("%s exited with code %d" % (docker_pre, rc))
+                return 1
+
+        # Copy any extra files into the Docker context. These can be
+        # included by the use of the ADD directive in the Dockerfile.
+        if args.include_executable:
+            # FIXME: there is no checksum of this executable and the linked
+            # libraries, once the image built any change of this executable
+            # or any library won't trigger another build.
+            _copy_binary_with_libs(args.include_executable,
+                                   qpath, docker_dir)
+
+        for filename in args.extra_files or []:
+            _copy_with_mkdir(filename, docker_dir)
+
+        argv += ["--build-arg=" + k.lower() + "=" + v
+                 for k, v in os.environ.items()
+                 if k.lower() in FILTERED_ENV_NAMES]
+        dkr.build_image(tag, docker_dir, args.dockerfile,
+                        quiet=args.quiet, user=args.user,
+                        argv=argv, registry=args.registry)
+
+        rmtree(docker_dir)
 
         return 0
 
-- 
2.47.3


