Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDB3C88E40
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIw-000492-0C; Thu, 10 Sep 2026 14:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIr-00043F-P8
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:17 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIp-00075S-QJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:17 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48589798dbbso18584f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064114; x=1789668914; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HlUNZ7JGzsbO42Hhk0mF6bv3uGqsFUKiR49vVBrXMEE=;
 b=QBs0XPu1yMp5RMKTtxDgqwqczQQFKxRFTXeZBDoXwXtfMuhLjYXA9kfjCVtMGMfrqV
 zNIW3Owpjr3hZ5+k3Ly4XMTXrKSvtPKJvaV36ipcQYo+j/eojmCIZB90UFwZJdOYiAJ3
 BRlnM4INg+dzAMEWtzyvvUdjKT9tWONZwTIYnIReLslLEEe6a+yihatKEcmTBbFeJYgY
 5JmQEcjEDg5ljm5QFdCXcWLdMX9FvVbxeUObENqBRtgPVGroFVjThze9aNvgxKjV1o0V
 3M2g5kpgyq/oyXPQHwDs5gKJCJSkKToRh9pWc9q6/1EX3/lurVfD8+Jzjs7L5nyyLcHg
 ixqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064114; x=1789668914;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HlUNZ7JGzsbO42Hhk0mF6bv3uGqsFUKiR49vVBrXMEE=;
 b=HPUobW+uVaXE1mOh6/dn+Qcw/Jkm6JEw3/CJsgcByQDLnf0Kbo1gPBDPdqhPzIG3bY
 9CaprmUjDKMKuMjxBaJxviadZtT+W+v2d4DFCgKp4OA3zLTzCT7gqBQdOBHagmjtGyg+
 9dES074UhokF3WHtaib2db9NzjOcvz9iFNrQ5/66m+bemq1Jqqs+9szec/MTcKMEt00l
 Uqq8INctP7v6NsRQVc68M+XTY5TcyfkX/OaTzYZmOr7gIlIStTMinTU8xncWqgSntpIV
 kbwIrWowgUAFHRCKvg2T2VdPUdKe9jlcmgpd3xYXjpGX6ySrwLk6RGu+2kpNR/eBhbEP
 PNKw==
X-Gm-Message-State: AFuF++leGjtP4B/m1IA2fohwuU+ggRnlEY82dXQWSpL1xNI6UVBCqh+0
 7lr4w6m/AyWRVpKVzw9z9REj0W3x/CAuG+9pKkpqQbzUTSPDR3gc05r0zA5YP0Q86ZA=
X-Gm-Gg: AYBFou1IRhK4VT9VElE6xVla2HfshQP52PPPpn95fPo5a5RpnPaNDN82IXEly867UPR
 PTfhTFuTzTIO1JoT4JoNRFLNx19MfWYxI3Avzcy7mmMhWJY/+lzmMBm5beS2EXMA0MBKKRPuE12
 +5uiFGLx6Ajmf8fi7UJNbJMA6uWHR48KakvdkNFVqPX5BFyNNUj8EUfCXaf+RMUm1+Zjz50RVt/
 xAQxoKYegxjpjq8tnXMPhQlaPJMBeaAwrTRv/AA1dW7/7cFSh+3KCK0xGWxLxOM2ZhnP8ng5qIA
 bXMQUPCF8Nbp0eLB3/aDUkfcwVEPT0aqwvvmXwoRzZlkngPbyiPaQ6RgWkg7DeQAi2T9EO7xxD2
 N1jGmesAONuwjDShw6Vwa7wySJujmSF8egxQFf98QTDxXcey2BRdsA7Ccx5Su78vAmlXzPnkFfa
 fK+VcLBtNpIGy6CbjDemBtsJY499AVKekzvehaD2HH9cp5/JmaFP4x0KBTpbV3JFPbiurvAQw=
X-Received: by 2002:a05:6000:1889:b0:485:8be8:b2ba with SMTP id
 ffacd0b85a97d-486eb3538e3mr202290f8f.49.1789064114021; 
 Thu, 10 Sep 2026 11:15:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee8bsm187611f8f.15.2026.09.10.11.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EC4215FD0D;
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
Subject: [PATCH 9/9] tests/docker: swap --quiet for --verbose
Date: Thu, 10 Sep 2026 19:15:04 +0100
Message-ID: <20260910181504.1010916-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

Running the docker build in meson spams the output so default to quiet
and make --verbose the options. If we want to expose verbosity in
meson we can deal with that later.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 10 +++++-----
 tests/docker/docker.py        | 22 ++++++++++++----------
 tests/lcitool/libvirt-ci      |  2 +-
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 74bf471f171..85825d74dfb 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -72,13 +72,13 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			DEB_TYPE=$(DEB_TYPE) 					\
 			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
 			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
-			$(if $(DOCKER_V),,--quiet) $(if $(NOCACHE),--no-cache) 	\
+			$(if $(DOCKER_V),--verbose) $(if $(NOCACHE),--no-cache) \
 			$(if $(NOUSER),,--add-current-user) 			\
 			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
 			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
 			"BUILD","binfmt debian-$* (debootstrapped)"),		\
 		$(call quiet-command,						\
-			$(DOCKER_SCRIPT) check --quiet qemu/debian-$* $< || 	\
+			$(DOCKER_SCRIPT) check qemu/debian-$* $< || 		\
 			{ echo "You will need to build $(EXECUTABLE)"; exit 1;},\
 			"CHECK", "debian-$* exists"))
 
@@ -103,17 +103,17 @@ debian-toolchain-run = \
 	$(if $(NOCACHE)$(NOFETCH),					\
 		$(call quiet-command,					\
 			$(DOCKER_SCRIPT) build -t qemu/$1 -f $< 	\
-			$(if $(DOCKER_V),,--quiet) 			\
+			$(if $(DOCKER_V),--verbose) 			\
 			$(if $(NOCACHE),--no-cache)			\
 			--registry $(DOCKER_REGISTRY) --extra-files	\
 			$(DOCKER_FILES_DIR)/$1.d/build-toolchain.sh,	\
 			"BUILD", $1),				        \
 		$(call quiet-command,					\
-			$(DOCKER_SCRIPT) fetch $(if $(DOCKER_V),,--quiet) \
+			$(DOCKER_SCRIPT) fetch $(if $(DOCKER_V),--verbose) \
 				qemu/$1 $(DOCKER_REGISTRY),		\
 			"FETCH", $1)					\
 		$(call quiet-command,					\
-			$(DOCKER_SCRIPT) update $(if $(DOCKER_V),,--quiet) \
+			$(DOCKER_SCRIPT) update $(if $(DOCKER_V),--verbose) \
 				qemu/$1 				\
 				$(if $(NOUSER),,--add-current-user) 	\
 			"PREPARE", $1))
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index d7eb4cf6811..10cb4cbde11 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -312,8 +312,8 @@ class SubCommand(object):
     name = None  # Subcommand name
 
     def shared_args(self, parser):
-        parser.add_argument("--quiet", action="store_true",
-                            help="Run quietly unless an error occurred")
+        parser.add_argument("--verbose", "-v", action="store_true",
+                            help="Run verbosely (default is quiet)")
 
     def args(self, parser):
         """Setup argument parser"""
@@ -341,7 +341,8 @@ def args(self, parser):
                             -- to avoid confusion about its flags""")
 
     def run(self, args, argv):
-        return Docker(args.command).run(args.cmd, args.keep, quiet=args.quiet,
+        return Docker(args.command).run(args.cmd, args.keep,
+                                        quiet=not args.verbose,
                                         as_user=args.run_as_current_user)
 
 
@@ -390,7 +391,7 @@ def run(self, args, argv):
         # Is there a .pre file to run in the build context?
         docker_pre = os.path.splitext(args.dockerfile)[0]+".pre"
         if os.path.exists(docker_pre):
-            stdout = DEVNULL if args.quiet else None
+            stdout = None if args.verbose else DEVNULL
             rc = subprocess.call(os.path.realpath(docker_pre),
                                  cwd=docker_dir, stdout=stdout)
             if rc == 3:
@@ -416,7 +417,7 @@ def run(self, args, argv):
                  for k, v in os.environ.items()
                  if k.lower() in FILTERED_ENV_NAMES]
         dkr.build_image(tag, docker_dir, args.dockerfile,
-                        quiet=args.quiet, user=args.user,
+                        quiet=not args.verbose, user=args.user,
                         argv=argv, registry=args.registry)
 
         rmtree(docker_dir)
@@ -435,9 +436,9 @@ def args(self, parser):
 
     def run(self, args, argv):
         dkr = Docker(args.command)
-        dkr.command(cmd="pull", quiet=args.quiet,
+        dkr.command(cmd="pull", quiet=not args.verbose,
                     argv=["%s/%s" % (args.registry, args.tag)])
-        dkr.command(cmd="tag", quiet=args.quiet,
+        dkr.command(cmd="tag", quiet=not args.verbose,
                     argv=["%s/%s" % (args.registry, args.tag), args.tag])
 
 
@@ -513,7 +514,7 @@ def run(self, args, argv):
 
         # Run the build with our tarball context
         dkr = Docker(args.command)
-        dkr.update_image(args.tag, tmp, quiet=args.quiet)
+        dkr.update_image(args.tag, tmp, quiet=not args.verbose)
 
         return 0
 
@@ -532,7 +533,8 @@ class ImagesCommand(SubCommand):
     name = "images"
 
     def run(self, args, argv):
-        return Docker(args.command).command("images", argv, args.quiet)
+        return Docker(args.command).command("images", argv,
+                                            quiet=not args.verbose)
 
 
 class ProbeCommand(SubCommand):
@@ -574,7 +576,7 @@ def run(self, args, argv):
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
         cmd += [args.image, args.cc]
         cmd += argv
-        return Docker(args.command).run(cmd, False, quiet=args.quiet,
+        return Docker(args.command).run(cmd, False, quiet=not args.verbose,
                                         as_user=True)
 
 
diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
index 76b5dd5b5c8..5176e136ab1 160000
--- a/tests/lcitool/libvirt-ci
+++ b/tests/lcitool/libvirt-ci
@@ -1 +1 @@
-Subproject commit 76b5dd5b5c84511e2e799c2b3d6a2a9b9f6a081d
+Subproject commit 5176e136ab11e275eb9f57c3d5c80e77af6507cb
-- 
2.47.3


