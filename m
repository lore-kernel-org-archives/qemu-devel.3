Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15B5C79FBF
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jIq-000413-Qb; Thu, 10 Sep 2026 14:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIo-0003vj-8W
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4jIm-00073s-CW
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:15:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-485850cf499so19714f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 11:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789064111; x=1789668911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9MW90oGAbR9WHWcrlDpW8JaDJbwZUQc2gAp7qxtBJUA=;
 b=mT4FqnXfIcQ6/d2bga0M4zweLVmrk2V/diA7FyvlpdiGNVXhOhGcjHEf14AT4oO6Hk
 hJhNeHnngK5bOtGKSRvwgkdkhiqi0HYdM9YT5DkCIJ0JUSpV/qWzEtN1gw0Bqfp9otq8
 28pRgE7+YHWD7/bGt4V3sSjgn/trssIVzEIsGGnLLKnGZFaLz/cvjBtNX2NAybAl3QAj
 N/yjqKYcEftlSCFH4wzzodbvSSUo5dxUOnGmT0OrdMAxLh4rqjpK1Cs4a7yMvQfv5gEU
 +KuQxWJsfWGyxMvrcBSdYrqdR2qRW8YYe+3duhuRzrcu4upyjauDPMUh5SdzadYKyE84
 s0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789064111; x=1789668911;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MW90oGAbR9WHWcrlDpW8JaDJbwZUQc2gAp7qxtBJUA=;
 b=ot0Rzdd3k9r5kyPbe50Do5c+Lz5kjQ9WOc4kcOZnUkkazMxJFbjBElf0W8/3hAwNK0
 lJj99k3/DslhkE4c0xr1Siunamndx7YNQQ1QbjvdaOQWkMT/tlySqsSt/73mNC3vvKQE
 r5KIDA2vYQ2pVPckaMGP+0xRuSuMj3Il9j7hT+VnwmzY9fR3qrfSOcseHpLvoqLnQY3o
 qqy0nGsumEb0u20msaB1TFTukpTZkm0qbobKrQFw1X4oJoD9UsscFam9dnSbVYw/2Jqk
 R2N1nFQFmuaZAkfDW/5NRmwJvSoys0MRHvro8DpwSbgnv9eenFF7qVNBtdglq8F0wGx3
 D/qA==
X-Gm-Message-State: AFuF++l2aucZpxotiuDvdjOH2loGahWwfI6WEha3PWrr4mum56F/DpWv
 mHU2pYQchsuqBU4qY7GtuZQlHDJXdh9NIqtcjdPHn6a1ZsF0vtwSLZvx4ldjRJUuXIU=
X-Gm-Gg: AYBFou0NI0b5IjwfSG/qzBdq9KW3zaqK0zEaGHvHvoE5vqJHPXACAI6hlH9whLImr/X
 qJ0xrspqCnYxvZ3hDA2BX8bndyYipv9yKJbw4XwtDCjQ9vevpXuwYiLqMltbcQ49LeePj82Tt5n
 6tH9z5DHmuHMgkfai1o4bL3AmvV6WVBpqX8nZ/B2WvU5THpePqW7h01hmfT+0ArZunO55pO5kaV
 YzILlJHJxpX/SqwBFsBYjQN9CNAqdIInjdu7zALGmIR3/04c3rFDI6d11/IRgUic5PouNlFWgey
 B8RIgnLdrPZuAYDPrDhUpdJ9zcD7kNNZZgaA1Vgz5W6AxnqZgYcp4l/0DkSSt/yeS8sfWxG68RC
 BRxS6yAK0I5IPRgK5Vo0exwmBKDXaem/qRQLbIgjo3wjAE876Bf3jCAYYg7G4kWL3cOlQru4ZAH
 bMBqzup9ZfUU3t5ow2vAncqCuzPAovgtzid6iWXsCvcBgVlgFCANGaIJkr6HzfV9Btb1W/nkQHA
 n/Gp3yRYG0=
X-Received: by 2002:a05:600c:a016:b0:49c:ffe3:2b3f with SMTP id
 5b1f17b1804b1-49e619a0458mr3963935e9.3.1789064110793; 
 Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32d3c7sm220139f8f.10.2026.09.10.11.15.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 11:15:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D13D65FD00;
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
Subject: [PATCH 8/9] tests/docker: add specific command to parser
Date: Thu, 10 Sep 2026 19:15:03 +0100
Message-ID: <20260910181504.1010916-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910181504.1010916-1-alex.bennee@linaro.org>
References: <20260910181504.1010916-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

A future change will want to use additional flags which clash with
docker/podman command lines. Currently they would get snarfed up by
argparser. Make the pass-through commands explicit to avoid this.

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
index 22157a47c96..57e3870ac8a 100644
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


