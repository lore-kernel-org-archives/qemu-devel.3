Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24158C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWj-0006Jb-QU; Fri, 18 Sep 2026 10:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWF-0005nS-E3
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:55 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWD-0007rP-Nt
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:51 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so4829855e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741488; x=1790346288; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bb+3yGL+ssGZS3JwUTq61gT9ppntoVMqPfYZY4KfhEc=;
 b=NugKNE7pIfLgtYXgi1nqujcxDXWo4G3FxpV8vPkbuK4jqbL/3XGOqLoxWd5lo2s425
 79C+QSIx9phuiYMMFha/Hw6l5pc+PQkbPyE30svHSHk7+nVfyID4EZniXtWRuN3aqtjK
 RkdPtVBdOFrHwqLh9MXVBEc12wtlrCmRPc2R96gtTNukgnkBVB0Rlg9ajWSVPG/b0URk
 PitjyY5E2k8WzAl81cU5JnrIpuRnfzrw8d/uxYoz5kYdpfzsPjPoCFt4kj/d5VMK72tB
 zwyhvxiZ6k2v7LryDs/mFmPD/ht74UBMOlooCyqSxs1v+EGkVYiWC5D0SICBoajdmwwu
 bA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741488; x=1790346288;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bb+3yGL+ssGZS3JwUTq61gT9ppntoVMqPfYZY4KfhEc=;
 b=FGBl189U2+zvVrh7C21WG7dtODWQ6mwkJR4Skv9zJNeAQRNDrtvFIZqTSa0R1QUH05
 P8kpMKuAd6UW0whXEs0aXgYCsuXgDmh0hZ4WvvqF/Ppmi7H4JU3nfwwo70F+TuccITqy
 nrt4pdSbOZGNoGGDhXLC9sGn9z6+N5rK5YD3hKDkWrd25QYskNu4blr86xCdAKrojxoZ
 BaIo3kaOP1+flLajz9UewIeICUeAdERPNLMC32xiZowRNnEwDULxX+lzNPieqoiKq/XC
 eNzr80rHEKj/VQ0ziDvtTDmc7jttXKVMY9jwEvnFyeptJr2bzLBmh4OluB3mwuZj3vUQ
 8Luw==
X-Gm-Message-State: AFuF++lhEzSaWa5/jxEXqNalESW9SrcnEFgD8PPX0nqxmmTVQ6vkUszq
 tWKfP70A3coNyGya97jgYCHBQ62OvIFY86HkeU320hkQ27iSqGOHvgpcFiIhUXRcxNs=
X-Gm-Gg: AYBFou2PRYymnlMYamm/ezw8eawRtmmUIqh1XBU2aDN6Kmjeo+642YgCxpd4IhSLpAs
 URts9eM9jF0oQ/6cPq+cCBF9ba7T9Yh16iP3fvrCRMBfaeXQrbexocUJFyeE7fKb4jU2pzp95Qc
 KqbudqGU+1b7OlOhFNwUzR/qtTRyKIjm0dt00jwYnfk6qxutFPuZNqMrIM1qKRLc8V/WfPyUKCG
 jWuRNSCtHB+Cj12fU473WKhDyUIzZ6Hyl/Ffkz8bqpnwsMngfoarXrEO26XkadpwRpVR3R2IPjy
 eiHA8JCWN36rdHBEjwvvFmqKzczqDM8nao/8aNS2lhfPWZoF85dcrZFXyf673ZPO00N1Zd4Q2xo
 cOR9iYkCuNvUdk1MaKhuWEDcH8nDcv4JaUF3ETkrLNydDI5HLUKTbL3Beu4CyZ5mrQdcnjSn/Aj
 lzQHFjeNYdk+LBrsLd3yi1PuU7G7Ec7vnLb2ofDKRxZJ+i9fftZqlR5iC+Md+9Gvw/dJtG71c=
X-Received: by 2002:a05:600c:4e53:b0:49e:715e:ec1f with SMTP id
 5b1f17b1804b1-49fc5757378mr36044745e9.30.1789741488074; 
 Fri, 18 Sep 2026 07:24:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1d0d0bsm158133615e9.1.2026.09.18.07.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D913E5FC99;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/17] tests/docker: add specific command to parser
Date: Fri, 18 Sep 2026 15:24:23 +0100
Message-ID: <20260918142429.336497-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
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

Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260917165602.3405537-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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
index fd0cbdfe856..d97dda26967 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -379,9 +379,12 @@ def args(self, parser):
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


