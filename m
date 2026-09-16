Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3ACC982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbI-0002UF-6L; Wed, 16 Sep 2026 11:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6raq-0002D3-5C
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:45 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ran-0001Sz-ME
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:39 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b965f447cso9945505e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572636; x=1790177436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XDBeIItyJVXMmWM9fFuyv25JigkWsWFtvmOqP+mqtyk=;
 b=vuDojsTOtpQDKzUm9WkWqIQEaiBPMPCzWcM2RGZ1aVNypa6OX6fNIcxVv4sJy4FsPO
 V34g9VGILaRvDGxMUk78a4tHtCm4OuvZEcpmKGDHL5ShiPRoG529OV0oGsmADQ3EDyf3
 JIxJjDbGpYljsmn3KYQTu8UlWgGPwknIMbIRosZ0LesEz79/ZIYgnK5ud9gsiVqmuW6E
 X+dHZTAWpsGrtrG9gmysug3elr2XR1v3uu+em5PQssiITH1TJNPXELbj51Of6M8k0zQ9
 rPijSXFkqe3oSbulj9+hVovzJx67+ilxYzORr6GPpycpBJa3tAfWOJ0F2KL8idAa6HhL
 3C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572636; x=1790177436;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XDBeIItyJVXMmWM9fFuyv25JigkWsWFtvmOqP+mqtyk=;
 b=dVh2Z9Kd9D946t9RVgsOamUxR/LjRPn+DEZmwXwprByWZDCj/nuaiJdYx2W7xkOmm0
 4ctVnn/VByIDwL4ypMvagtY+qBRG0b4xdlZckT00FY7z3n7l8/e3TwL8GlWt0kJLL0GS
 zHJgL8ViYb2UBhyVbGP0djCGtk25sousSXDYkHb2EdrSkMOuOMVLcoWf6mvUVqYzBeOX
 TFrjjslX64s0DKK3ea7UJY4WVQ9gOurdPlUQpirUqfakURIWKsNNAO3B5Kn7F8RKDgnH
 XOUEFuvxvcb4WCNP9197ux0z2Oe9AhgkauifsT303fE3R2tJ8h+kCQg8JRhOys/xKupL
 JqPg==
X-Gm-Message-State: AFuF++mkLKPel2f2HFVjy6++Dlfthj5PF1aF3ciI+q/ryfg6BZzw0CWb
 v4qtheE8UOJKDI4AMjI7ruyINz8IVPStlAE2dBrJd+y/dyChDY3f7vniUL5sLw+uDn2tuw57ZhQ
 bSSnpp+E=
X-Gm-Gg: AYBFou1+DqUdd865vhkg/M4NpFT0Lc7ppU2OzMx1Vd2HsWAdhGLzClo+b76q+5mNavx
 HbtMEn8QytxR4Q73FRc65y00R93AaVw4DncuBZBr6FAeJjj/NvzETxnQSO3oObcEvDE3ydcmZwG
 OS+Gh6VbViLcIx+OwH74010AjVojwPvGKb4Uygjxr70f7PV6QuBLgBOP5R2LLsBn7bYDoDhugNn
 sNW2I1owRsv4geMqPkRzqYbUva7nhBugs09+ArlzLApqB4kvxCjitJ57JqpMpa2QlqWFIJcdLsf
 faIMnDiU0VlQ4jU8rsUk4ZeYcOK3/5acEr434eEAgfopum8icQL9TZKnDVkKtzm66vR7at9+KD5
 sm150P3mfEdEe3IQWOJjp/pYcGusNg223ksiMoROGS/cNObzUspqcEhxedoy/sC2kROw/zxo/TY
 MuvGHTKpJ6cPlPAbk/KhGdaOjAxopluyqAndaEgijtKzOekx38RCVnRAxbcoz+viQ8bLnWgXs=
X-Received: by 2002:a05:600c:83c4:b0:49c:ff9f:f6b6 with SMTP id
 5b1f17b1804b1-49eac463960mr39184175e9.6.1789572636125; 
 Wed, 16 Sep 2026 08:30:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847ecf52sm61569685e9.2.2026.09.16.08.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EE64861926;
 Wed, 16 Sep 2026 16:30:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-arm@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Kyle Evans <kevans@freebsd.org>,
 Eric Farman <farman@linux.ibm.com>, Brad Smith <brad@comstyle.com>,
 Fabiano Rosas <farosas@suse.de>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 07/19] tests/tcg: prefix meson built docker tags with qemu/
Date: Wed, 16 Sep 2026 16:30:00 +0100
Message-ID: <20260916153013.2134555-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
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

With the meson changes we now build the images directly by calling
docker.py. However the Makefile.include builds prefix all the images
with qemu/:

  # General rule for building docker images.
  docker-image-%: $(DOCKER_FILES_DIR)/%.docker
            $(call quiet-command,			\
                  DOCKER_BUILDKIT=1 $(CONTAINER_COMMAND) build \
                  $(if $(DOCKER_V),,--quiet)		\
                  $(if $(NOCACHE),--no-cache,		\
                          $(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
                  --build-arg BUILDKIT_INLINE_CACHE=1 	\
                  $(if $(NOUSER),,			\
                          --build-arg USER=$(USER)	\
                          --build-arg UID=$(UID))		\
                  -t qemu/$* - < $< $(if $(DOCKER_V),,> /dev/null),\
                  "BUILD", $*)

So to ensure we don't end up building every container twice make sure
the naming conventions line up.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 890da7b81e9..d2a837f103d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -237,7 +237,7 @@ foreach target, plan: tcg_tests
     image_name = 'image-' + cc_dockerfile
     has_docker = docker_host_arch_supported and docker_supported
     if cc_dockerfile not in image_targets and has_docker
-      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile]
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
@@ -252,7 +252,7 @@ foreach target, plan: tcg_tests
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user',
             '-w', here, '-v', mount,
-            cc_dockerfile, plan['cc']]
+            'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
     endif
   endif
@@ -261,7 +261,7 @@ foreach target, plan: tcg_tests
   if has_cc
     summary_cc = plan['cc']
     if not cc_from_system
-      summary_cc += ' (from \'' + plan['cc_dockerfile'] + '\' container)'
+      summary_cc += ' (from \'qemu/' + plan['cc_dockerfile'] + '\' container)'
     endif
   endif
   tcg_tests_summary += {'cc for ' + target: summary_cc}
-- 
2.47.3


