Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B77C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZbS-0007vu-Q2; Tue, 15 Sep 2026 16:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZl-0006tG-Dp
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:22 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZd-0003KH-Vx
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:18 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso95345f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503372; x=1790108172; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zGF8Zru9UFaw3tvZdLkb/lAyT4SI/GstcoOfFvkorMM=;
 b=tNhTFAvOomXLzFwDi5gbteLOcRJ10lt/48SeoIBzFMYxqiR0zRpoD8F4TsgemkMzOk
 NZuBOCnr5gwYYPxxCXrHuFojtQtzax3plbh3FQBHzxDUI5X2DBMyaXUBtKd494mhahgC
 N/i/toLHtK+/c9sZcpWirtldJNVgJpN1edUlEfI3A9JqK2rv9d4+SNOh7BPg5IW2Ak7E
 ilTvHvEcil30wcMbhAJna+l6vL+XGOljTVrPuTGQZemn35e6UBwj31OHiipZP05mqBfx
 XgSsrEphgmFfG4dM3FWYI9qQpk2LeUoV77yv5ijzuYwbSd7B/JNhVgc2c7+TFL8boIg1
 /ylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503372; x=1790108172;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zGF8Zru9UFaw3tvZdLkb/lAyT4SI/GstcoOfFvkorMM=;
 b=ULuzzFDuBisiTu2TnbB8pasLl2RAUbesuHY+uCDpjmD6Xn/H1vZFYFtVuJu1HGVJoz
 hCmrOV2T9jhN+yRtrbdjAh5xf10RWGENuYnrs7jl51+vbIZQzOWoVEw4Jk+fVYQdDHwo
 20YWo7l21loPhHSPTw2yzxjKhXGMPObhonhpFK22wNfMowlgme0piYyetmo6+l2fvanb
 bA0lhAJC378NM2+UsCciYS3OTsalxfgASq4cdtlbfwSUzk+CUWSx2xOGGKKxqKZZZMWT
 5pVEXwm2WEF7x8M+uKJlb9NPr3Iq+B+iKNDJYuPoju1WzuDiMedfT0i0mYwlZ0oWKy+c
 u7kA==
X-Gm-Message-State: AFuF++n1obPhaqPtSyUP2Eu2TCBvemQMJ8kTXaTg3m0G1MAN9oSSSZkD
 owXdlbSnmQ3eLdcSXqqig+HiWXGHY+BJrebk8+/xAy2pKS3BcU3kPVtxTFYINgUIffM=
X-Gm-Gg: AYBFou2c90GSYKnYnGtRo/XGvfvZx5lJgPS8A9t+bTss+zXzu5Zg6k+u2yVk3KBvqTB
 QMsNUGgHMOb00m5e+iHPwwewTeHv9io6AlOBpJPP4aEDxXlwwlv29LLwTgafMvS/REkcR3OuO+B
 MrhUHm0ZbY6ZHRcRd5o6/tcJm22OIOuBvdHHyKQqG2wmAeg8yklcA/PuV/OFkyo/yWjG7Ms/aA5
 sWCFiZwdlNO2pjNCXRvXTxSx/N+abgA7xMWQj1P8G4bTWN1obj7bM8MKCzDzARsUo9FdFoySN8Y
 3WbiPFTESzsqyxQr/QW+EEW4I0zrMjp5vAptgmRY8QIpSU5IEkKBeOnXMVjAqzcY0M2O+Va+0wm
 LlXVPlAhc9oAaQRhrnXMmdjpN3VUUjJUYWYEFPqtLOu0JD9nUtTlNSiQWVgl5q3Va9WlfXvaCAa
 SPiSdA2vbsyp1Kh18qu1PTaa/7RWiDS3xW8+xq/u6/erHJ/usge9LL8/kpw0VH6TJvTbpGO0k=
X-Received: by 2002:a05:6000:430e:b0:485:ac35:5c5d with SMTP id
 ffacd0b85a97d-4870cf1136bmr99464f8f.15.1789503372503; 
 Tue, 15 Sep 2026 13:16:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bef7659sm1685601f8f.3.2026.09.15.13.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1A596191C;
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
Subject: [PATCH v2 12/15] tests/docker: add specific command to parser
Date: Tue, 15 Sep 2026 21:15:57 +0100
Message-ID: <20260915201601.1207839-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
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
index fce70f8e56f..17974e4d15c 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -237,7 +237,7 @@ foreach target, plan: tcg_tests
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


