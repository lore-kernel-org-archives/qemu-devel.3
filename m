Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DABAC982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWb-000681-Mp; Fri, 18 Sep 2026 10:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWC-0005nF-7G
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:51 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZWA-0007qk-9n
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:47 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912df756so6059465e9.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741485; x=1790346285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jxff3xmmsE6KuWRYrIIbIyGuz0FUO2yvzlzbuIVyHAg=;
 b=LFngSX3o09Ori48gZxKQymRxuEeV/h0toukwimZwb0BQItOjJ0EhYqls8y/q97U2Ay
 TTMg3hlDuT6mlf9aOQpKWoH6UrjrT8tTWftNk4iYe9d5pm+DSMzvx4UhjDBBGd2ZkFYf
 d41ph0lIrMDPPREPBLfIBmd2gi7X10fGZSUGGXgppoKVPz5p3nHezsennqH1u+F8Pwsk
 XMapg9DOT9miXAiE2IKYTOvTYkmdqnGh290YGXdWzi0fo6GCXzzVVh5ov1i17+AspUAQ
 TlIx7yhgYaUrFeD58C/nSIsgVEn2kK1fqOmh2mE4OPBOBOrHzZm3tjbr8AFcp6jNeak9
 pcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741485; x=1790346285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jxff3xmmsE6KuWRYrIIbIyGuz0FUO2yvzlzbuIVyHAg=;
 b=deP4/vOUWEJpM+jU02To5aWX+HuKwoUFzEc0dkIQhothvf1KngGUacT7ycihbiQPuq
 lcJAze62yiVpM1SYhE0xO4hap4LcgB+K1S4fDHxXqRiKd7oQVfl89h+yCXWyKgttCvMC
 FliSHrptLL5Za3iw57N5Jb576PGnRlFTVW9Ep5EW7tnWmKwOQ0RgWBsVWP/Hd7g/Izqc
 uFpCgFNLkMFUWyiYgZt2LVFV11CCKGiWgy9JG0G7QDogFqZG7/6AVVPiuT+hB3SiRZ8E
 u/phLUE/YpR2150Doy8NKIuInrYZOdmDTvtbcDnkPYfy3JhxEMtRSZJz7b5OS/l0yco1
 L41g==
X-Gm-Message-State: AFuF++kzNlIqqVK40GEXS9zybj3Mzz+DPub2vOWJbZgC0S3FY2TMh3Gu
 nzJFoaxOCbRtL4DFF44zNh/AnZ13O8PObr4ApvwBLuth1Txqa5WE3tbPoQTuRxk6uh0=
X-Gm-Gg: AYBFou3Kw6MHGdsS5030ukoNbH/JO9fES+8xbzvrnghjZQpJxkkiU7rPpatz1CwtWXq
 3rbdSawA0V9yVw4qsPXnSTbUEox1zfV4JzaMyUmrs665pvBJDGUdQTIJvkPBje2ZOMrD/VYTbYt
 Yi7qBcCKg8w5nuUiWEzKmPO8JaH/YicmNXBVp5dLgZ6krFI43ASWLH+F31Dz+LxoHFdmPyRZapC
 8r2KE5h9PPy7HrWLA1mQmNgvpA0Vf3NafUt0lQq7phZ3lyu4KE5ze/cCBliXdaQ8iSyM+q6NkKx
 gsNrIQ9cT4HcEdaD4wT2v6OP4KiXOXfOxfd5631rCujDIKf0ftUNhCDBgWGsWH3iHwDFXMn/0Bn
 2S57STzMc33UK0V++SAwFv5aX/ZTQ2FLeg0J3OSun1gTGJ85CzWKpkjvXyFnnu0UM+oaSSu+lHH
 ZTKzNSpDXbPtJUNSOBMiz72GU/bqTtkA89cmo8e5yHiEUKU6uH9WzkEoVNOTebNg3CG85oXh4=
X-Received: by 2002:a05:600c:6214:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49fc568129emr35618275e9.6.1789741484722; 
 Fri, 18 Sep 2026 07:24:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7b7a6e6sm65793945e9.1.2026.09.18.07.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 730085FC17;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/17] tests/tcg: use --add-current-user when building
 containers
Date: Fri, 18 Sep 2026 15:24:19 +0100
Message-ID: <20260918142429.336497-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142429.336497-1-alex.bennee@linaro.org>
References: <20260918142429.336497-1-alex.bennee@linaro.org>
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
Message-ID: <20260917165602.3405537-8-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


