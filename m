Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1487EC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7FQZ-0000M0-88; Thu, 17 Sep 2026 12:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPZ-0007me-S3
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:39 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7FPY-0000pT-3A
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:56:37 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so6507375e9.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789664184; x=1790268984; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KnL6IKhM3dX41QqD22hf7RzeQ5QC61WVqJNh+BsXAJU=;
 b=zp5P1AfWH44Iy6wm9js6reEaV7xNv6pYV6mgtGOdI0uoRWXpJPEZEAIwAqRYhU8+Ga
 Bnkzi50EzYQ/0aNjBHa0FixgRBJ3sK/rH4NxUjtKJNUz/pkbZBj+MAJ+L8frrzxty6tq
 gfv6jgkF3azVivk6DOB+i2FuX1YhFRHzxBJ4hJRGqqcSbiuFh6R5bYJE5nAlKkhLAxCn
 bshB8octaEAl4pjZ9p9yUOzDRXM3l7+PabJpCGh5O7MKEuxQuqTB5zqJuxIR5HAP1geX
 AnEgta1LUm4vCiWFm/tS3LmH2gLIA+Ml851vfgodI850DCIjX6CkxSO2qLrABnKsj+5e
 xvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789664184; x=1790268984;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KnL6IKhM3dX41QqD22hf7RzeQ5QC61WVqJNh+BsXAJU=;
 b=kpRSoyq1tFrLW1ytjb1iB7wxwSvTor1DM7Tq3BpIprbtIaA+G+fsjgYFCL1yzRQ/H2
 5GuoFSr7F6mN0t8S8bOvazQXvyJxkuK8Wcep/PxaNU7tijI4EQqx2j4dVrBnSA5uLky5
 mTxkNs4aAykfeJE6Z9JEgsA48L/39VgjASJ0C3MDEtzcWk+5kqQ5uWlvuZksawUFh1WW
 LAaHo4e3KqQwJ/Yc1lnHNUHi1k6lPBf5lvCJBa8cRXLly5IYCD/FJ1bfNLfL4FqSC7rq
 Lr68Rw7bmatGdByVWFGZPey8hAOYfWUSsB76+OIUeLFGPnmS+z4K3PA/GxOzD8NIr1T5
 daMg==
X-Gm-Message-State: AFuF++l/nTSmAHrPfdf+kuAO0II+CyR1o9vZ+M2ZazMNI9q21bXWGzzV
 7TbBHzTefBF6XhhXtiU2U0ViSYOQtqBEX+pAxtJ9mMWHpKu4l2DsQqdVpVR3Gh8ZjWw=
X-Gm-Gg: AYBFou0nmy55una3J7Oi2NkBoqk5dU2Rja86obTJ+cHVjekTM/YACVRF064+T/6VGGK
 iUo7OgiPy4CKn8MNOHLg6TcQuAem1LFU1zhJfLnMhT9DDULio8Z9Yn5fMz3Vyg+1AOOJOZ7TZB0
 FKQVqs7RVy52lmK9xSAtQnEFDgOtlt5zXk/MWlRRbujIp8AF3Fb2Z9u71weF6fGeZl/wrbqrGRi
 R/nWoqibbFpgdUbcIfPkPZcwJjWxs2u7qZ/3jqglsmJPGuLv9Bm+fFUGEGAywmTx9c3nNEO1ubD
 XDflbem/zu0mqNT/WqeXdAaFkknKRBX+9YHKv94PH1nhX3yLcPgVYD2C9phRdaibJ6BlH3lzWf1
 MW9MnaTZ2KgmEYH49fcII8lfXGWNpj9rBYefFfBaYzfvJAGbdZ4XeL31qadRsM+KeA+m8HY166t
 cVeHfPfQYytWiSGf6Zwpno502dGZqgtnZ2/miftPfQYmXQVixaCZhGtB7Rs7ifbnDt/CteiK+VA
 qy+EwOHEA==
X-Received: by 2002:a05:600c:83c9:b0:49e:7caa:e7b2 with SMTP id
 5b1f17b1804b1-49eb733800amr77113715e9.29.1789664184110; 
 Thu, 17 Sep 2026 09:56:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd22dbf2sm82500085e9.10.2026.09.17.09.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 09:56:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7387D5FC99;
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
Subject: [PATCH v5 12/17] tests/docker: add specific command to parser
Date: Thu, 17 Sep 2026 17:55:56 +0100
Message-ID: <20260917165602.3405537-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917165602.3405537-1-alex.bennee@linaro.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
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

A future change will want to use additional flags which clash with
docker/podman command lines. Currently they would get snarfed up by
argparser. Make the pass-through commands explicit to avoid this.

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/coverity-scan/run-coverity-scan | 2 +-
 tests/docker/docker.py                  | 5 ++++-
 tests/tcg/meson.build                   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/coverity-scan/run-coverity-scan b/scripts/coverity-scan/run-coverity-scan
index 2f9ccd5e44b..0e1361606e0 100755
--- a/scripts/coverity-scan/run-coverity-scan
+++ b/scripts/coverity-scan/run-coverity-scan
@@ -381,7 +381,7 @@ if [ "$DOCKER" = yes ]; then
     # Arrange for this docker run to get access to the sources with -v.
     # We pass through all the configuration from the outer script to the inner.
     export COVERITY_EMAIL COVERITY_BUILD_CMD
-    tests/docker/docker.py run -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
+    tests/docker/docker.py run -- -it --env COVERITY_EMAIL --env COVERITY_BUILD_CMD \
            -v "$SECRETDIR:/work" coverity-scanner \
            ./run-coverity-scan --version "$VERSION" \
            --description "$DESCRIPTION" $ARGS --tokenfile /work/token \
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index a2e97061240..d7eb4cf6811 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -336,9 +336,12 @@ def args(self, parser):
                             help="Don't remove image when command completes")
         parser.add_argument("--run-as-current-user", action="store_true",
                             help="Run container using the current user's uid")
+        parser.add_argument('cmd', nargs='*',
+                            help="""The command to run. You should precede with
+                            -- to avoid confusion about its flags""")
 
     def run(self, args, argv):
-        return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
+        return Docker(args.command).run(args.cmd, args.keep, quiet=args.quiet,
                                         as_user=args.run_as_current_user)
 
 
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 482de73ac72..053ef147df0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -275,7 +275,7 @@ foreach target, plan: tcg_tests
       mount = meson.project_source_root()
       mount = mount + ':' + mount
       here = meson.project_build_root()
-      cc = [docker_wrapper, 'run', '--run-as-current-user',
+      cc = [docker_wrapper, 'run', '--run-as-current-user', '--',
             '-w', here, '-v', mount,
             'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
-- 
2.47.3


