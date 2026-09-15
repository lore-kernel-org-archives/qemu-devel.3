Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5862C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ZaR-0006xc-PJ; Tue, 15 Sep 2026 16:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZb-0006sF-C5
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:13 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6ZZX-0003HU-Kt
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:16:10 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so2872385e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789503366; x=1790108166; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Oc6yr6zbpyTI1sBnf60D2N+15kHWjne7Pv8s7CbUCQc=;
 b=nRfvcP/Q17+u97qLF5BUbSfv+9qANozmW7G4OfaNzBH7S5NeYA6Lcxiluud/O/zr3g
 m+5seFw9hpqB8uIPPGFLntFD1zBHs0r5vWuZ9XXQ3CAafFThePyjthtKJpxEkZ19sCVz
 /BXoS5hZCysOmMZSRdmLIg8Me+w1rnZtbvkx66Zq9fagvZbrNJdJFb2CpXvSsj5bQuir
 idF0E7negfHywBzsBCUhbwByCBxCbfoHVT7/a33x1WoVxR8eY0kzmhoT7L8k0PZQsc3F
 Uz0SyLQeVBbmK0WGSIxdPYI0VJTSm/3lg8KzR8q4g3YFDcim2+0l08wJfyWK2okMBJVY
 RxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789503366; x=1790108166;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Oc6yr6zbpyTI1sBnf60D2N+15kHWjne7Pv8s7CbUCQc=;
 b=XRwpVN8rspWHXEXcYqSF+FxSbBZpqA1Xn3RGeu3CpukyUsYd7Yf79pzgXTmfpf/Mgn
 odjx4R+CaUdZCkKuJz6UxVYMHvQpx/owL1bH/zDi/UQBJJnEwZWZo5zfCQL274w/3lYX
 I9a1Fv1k8SWIZ2aGmyCLdgp92JKMUuwgCAey42jRsPHtRnxl+diJkivw3FLk12eIXPI+
 BAhp4tZ01qUX4RqP+EE39lHVRNrT/ICMjZK5iSG+91SbwlM/RmEWohqRHpLSB2V/OgJl
 z42DMhkP8nB8vFO92FWhyUUTd5OjiYWZTZUS6OD5/Fo+y2tIeuGGvEIQVAJ/ZibzBYNa
 G2DA==
X-Gm-Message-State: AFuF++mCnkhq7d31qrY/QW+b5cTAecSjqoBCVj9qeu/jsgLjMH4qMO+4
 HF+ZImSLON7Evb7jtTWudmZWEJBLOL9lE1mEZpI9R2d/Si46aKvoq7uwKEBXO/URht4=
X-Gm-Gg: AYBFou2EfDS8l+5hILpujIYcVk8fKG3dqwm9H+V9q6LB6Jkiulxx9jmFBk2ppeeWXuL
 M+37Apy/jsCv8nRnXJPHKwEi8N/bZSB+Ib1E7BTvLoj5vnCTvEscMdvtKe8iP7Jp3oTQD7pIiOS
 YI3urknDcp6KO8sxGA9llqbpFdarQeVRoIbcfURhI83fpXBofcahYQ726AU31tr5wfDVNaAmaCi
 DX+4Pmo4wYwTiCJu4rVB3m9U3kOL7g84PWmOk3vEUWGTC6VfXMonta8y1eA4owG2uF4xdeONKac
 TVzUSxOto7Xfj2tH0ztlghiyUf2KhJAdVcq8SnQngAtQo14je40jg/d+m452cov0w3AeHjZZRRn
 /L6l4uQ0dF6fNpbkFK5p//vuc3Yfrp/TglrOswXRCTxUO5AUBIQ4K2ERDrPWEyU6qO17mqOyuoJ
 PcNcjcaj9N31QqgyMQdGMKY59boPso6jtTJWfGaLdPyK6MsdHJ+MjBaJBUJH3bxwjTtVkPFBE=
X-Received: by 2002:a05:600c:4743:b0:49c:fe46:7219 with SMTP id
 5b1f17b1804b1-49e8227fd96mr36589545e9.20.1789503366100; 
 Tue, 15 Sep 2026 13:16:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d9e77asm14611505e9.7.2026.09.15.13.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:16:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5F28E618C3;
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
Subject: [PATCH v2 07/15] tests/tcg: prefix meson built docker tags with qemu/
Date: Tue, 15 Sep 2026 21:15:52 +0100
Message-ID: <20260915201601.1207839-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915201601.1207839-1-alex.bennee@linaro.org>
References: <20260915201601.1207839-1-alex.bennee@linaro.org>
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
index e966774c8c2..5e2ee3e6e3f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -217,7 +217,7 @@ foreach target, plan: tcg_tests
     image_name = 'image-' + cc_dockerfile
     has_docker = docker_host_arch_supported and docker_supported
     if cc_dockerfile not in image_targets and has_docker
-      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile]
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
@@ -232,7 +232,7 @@ foreach target, plan: tcg_tests
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user',
             '-w', here, '-v', mount,
-            cc_dockerfile, plan['cc']]
+            'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
     endif
   endif
@@ -241,7 +241,7 @@ foreach target, plan: tcg_tests
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


