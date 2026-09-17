Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E57C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 17:00:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FQp-0000w1-5L; Thu, 17 Sep 2026 12:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPR-0007kc-Ls
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:30 -0400
Received: from mail-wr2-x0f.google.com ([2a00:1450:4864:30::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPO-0000pj-Os
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:29 -0400
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-482f635552aso1008802f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664185; x=1790268985; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yF3Q8DY1Fq2eaMOIb8Tf19RPgSoGXcO86Z2LRqjolcY=;
 b=Sb9C1gKy+QUmto2ibex6hR6JPFqwhrlaM6FtVTJwRWCWYzb5+xJkMd71jSN250FdAt
 iN7eRV80b+cXuCnifVd4MLNwaUAKsvgTHtNXvnZyHMZLyvlJmsGNkY46junEEkwYzvAI
 0jYFDC9F1sBTL2pW0vLZy3UzvxjLViudW2wUsyvMNu+RcgQMi+udxZPugBcT646HncWu
 CX97Zyj4yvDmSDveGhESjnx+I7hLkEZtmAXZQtqgwvhztAiNkWSdwLDg4u45cu3zmQfq
 3oQNPhoLya6phaMOnEzVBLwaPvNlPgUTBl1DXWoblOkDfImrH3+sk/HXLhnjgxwtF8NN
 8pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664185; x=1790268985;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yF3Q8DY1Fq2eaMOIb8Tf19RPgSoGXcO86Z2LRqjolcY=;
 b=zp3iB2oG8WfDTJL7eS0dm1jGEOUG2lEJYqRHSiOOqStkABE8bAyCPTITy/I05yTDBO
 ELG7ECyybdtlPlQveEdacHiixuKxifM7sGJe0qylFM+paKQwaXgoJ06jsWPelnPLw8CH
 qI46NFXDebCPsoKPViv5gpgS/tj1ygF0yKhnNhO6T3mlv81Z6WVm5AHm+wVPkfhPIycW
 XZrtVoINRaP2bjuyW29v19l048HNIA2KUE1jtgJhsyNH9AaayBHRH9idWH6VW8ZiTa7z
 tiWWvOxa00impT9f5A25MJ8484AGMmh0238pJDdZER7Yfl9PZ9CL+k2LG9DQz1OaFraS
 j8eA==
X-Gm-Message-State: AFuF++mceefRWJTqjLFcG5W3ZY5tb0rjzrFx4IUm6CgzNggAsf8Z50Wb
 3nPTPqV2TzFN7uwEnDXUnRjH8XqqEaQeO9tRIbpifsL8KnnbPdeBekihEaHX80P20jM=
X-Gm-Gg: AYBFou3EaDm6XAEKQCyDgi1aorTbOolhOqdohSw6p1f3F6SSzbsQtZHsB0cRHqyuCme
 cqDhSCzYnDln+ZtsbvDLrMevub1EohVTCyKQYPCP8LbFCf+Iti61cLsY0inJW8gz9bAChNDrPCq
 wAX/Y080Gjw1iDeXqG2RwqauVp+K5aS5z9Zs4bC8KyOl42/sl3Oukjtcy7uex+PcLhQ0BkOE9GW
 pbvRF+xTBehLqjSU4Y2P4mAD7gEULCBHO0pWtjtwPOO7nr4AJtlD2rm6AnSzVS5Z8DaRqarxg+8
 voWBM0HvWjCtZj/obuURJLNGw0oW6pTSXhKipWf1CzyMDSf6IpuNwXuUCLpNoV5HsX/SJfvHSpK
 NEUNEvxgacoVB3g0JPgi6547g/U0mf5FT0BWyud5MTfciac0uTTV/EWiO28Ni2qabP/loC4DDYt
 +PdlGMYQVG+Zcj/Yn93cri8/ev+QZlCPXpZJe/qbmpSQqjsqjt6QBzGjuWaaeteUkNBwWjgrA=
X-Received: by 2002:a05:6000:40de:b0:485:8a46:7057 with SMTP id
 ffacd0b85a97d-4870d048028mr9338392f8f.41.1789664185069; 
 Thu, 17 Sep 2026 09:56:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf342a0sm16903654f8f.24.2026.09.17.09.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:56:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57C9C5FC7A;
 Thu, 17 Sep 2026 17:56:03 +0100 (BST)
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
Subject: [PATCH v5 11/17] tests/docker: strip remaining caching logic from
 docker.py
Date: Thu, 17 Sep 2026 17:55:55 +0100
Message-ID: <20260917165602.3405537-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x0f.google.com
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

The caching logic was a remnant of an older time when we had multiple
shared layers building that went into the final image. It was arguable
that it worked back then but it is definitely not needed now so into
the bin it goes.

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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


