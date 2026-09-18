Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFD3C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7ZWc-00068z-OT; Fri, 18 Sep 2026 10:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW9-0005mo-7l
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:48 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x7ZW7-0007q7-Ka
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 10:24:44 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so4136385e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789741482; x=1790346282; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ASTm/YOo+kNQKpxTKvr6w86Tke+vQk9M5QNLP09G1mU=;
 b=T3AydBefiZ4JZP+jtsjFMcEAUa+RI8ybGYQ8rMagjIuZeh6EXQyKZZehjW5R6F/eV8
 PMFlAQ191OucXnwMU3NE7vqXb6vZriZ7svcVL9CH2TCZp2etu8spCTky8TbRZLIkpyy7
 Q1vhFddg966Y0sQ5UwlsKP/q1faFGW0XC1dY/3+cgVY2OvKQc0QamBmIZV+2ECrmV3/Q
 Hxdk6TZM4ERbzOXhTQLqrw2q8l/oP1+dwG7e/89C7iPKpaEqMdTiQePfwE10Vu54QbDm
 GeviywiNGQGfhh9wdR1w/XABE7iMWzDdB2vVBwfNvF9K0DqJO4XVoler+l5uHgsA6Eoz
 CGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789741482; x=1790346282;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ASTm/YOo+kNQKpxTKvr6w86Tke+vQk9M5QNLP09G1mU=;
 b=M5Wkt9x4EOREH3FdJjwhkkoPQc3ehEV6u6NrJ3JpdGOnHJx4Cu6BFRABgNw1O3Vz4V
 dsJINcLyVm+VqqgW6LQxILavg+rcKGsMjwGp6wQFQSBCcHlndEOF+/qD/63PsvtgnYAG
 nAWiuP3pVq+xvVo4i2R5FeTHlW8crUqQpAFnpsOeOuaVn1GfJNFcSyHzAtFkmtMxkp94
 rH1xQVMK9HS3Yr2H4AwNy8p5RPL++0bN2ubHgMigzjZAp4UeLrkw6DuZ7zfnnqIOVjCd
 9J5rWS4K1HXTIhrXOkQCYcdfqu3VTvHgUi71BtHJ4NcSnUpnm5qSBd+R0kljn3UsIlYq
 QPgA==
X-Gm-Message-State: AFuF++k33B8ekYOTawld7AQ3QjKewqLZQGZT4IeS151z3LFTgQbdJS0U
 EZSr85AA6y2RauhhtkbRgOdseeIm59JyjOe/Q82GvM2r3aPy++UeYP2vbeVs5FHRMj8=
X-Gm-Gg: AYBFou2g6+r8WIf2qneRx77DvMxgzKvPjV3lnq+49cMP17wqEkQ5gnbYKorDW0/LuBy
 /XIHhsFN5XVbHrK5FUBQNvLuTEcwSKtRrcCWIyCMm/HBPuGhLNPbDj7zp0LZsptjA0ccrj8HEQb
 jFuYc5NLMdQtlBg9UfBnfz45oevV98W5fOJO+3aUr8hTeNzCzyen1Nw9X3KzFFo4u4AC7mJy4ho
 W0OhuCxvqcDndix1wMuKrZY//n1TK42vDJata4g35hb8g8v9wq6nlV9ULGSahDqP69fLCam6oFO
 FQolnC9NKxJI1KTBhbjCOxMjEdybY5o02JemIT1lQBBAoAeMr1Krf8FK9LJIzEDKjBRl+9mBTEJ
 8KPaDMo6e9QZ55iyMhIWATiDL8v37fC/iQa1H2YPpRJx+q0dmZpQx/NcnQ1se5JXPenWD+aAJMp
 ICoAOiu4pTqxAoyjZVjSe4f9X4O7fD0HHaSjsznrdKjbKkR3KfhuISO8oTuhH0hGXw03D1GjQ=
X-Received: by 2002:a05:600c:1908:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-49fc56ad81cmr32759795e9.14.1789741482135; 
 Fri, 18 Sep 2026 07:24:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd2160c2sm166863355e9.6.2026.09.18.07.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:24:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 580625FBDB;
 Fri, 18 Sep 2026 15:24:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 07/17] tests/tcg: prefix meson built docker tags with qemu/
Date: Fri, 18 Sep 2026 15:24:18 +0100
Message-ID: <20260918142429.336497-8-alex.bennee@linaro.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260917165602.3405537-7-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d41a228fb3d..0604c4b90b9 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -255,7 +255,7 @@ foreach target, plan: tcg_tests
     image_name = 'image-' + cc_dockerfile
     has_docker = docker_host_arch_supported and docker_supported
     if cc_dockerfile not in image_targets and has_docker
-      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', cc_dockerfile]
+      cmd = [docker_wrapper, 'build', '-f', dockerfile, '-t', 'qemu/' + cc_dockerfile]
       t = custom_target(image_name, command: cmd,
                         build_by_default: false,
                         output: 'no_output_' + image_name)
@@ -270,7 +270,7 @@ foreach target, plan: tcg_tests
       here = meson.project_build_root()
       cc = [docker_wrapper, 'run', '--run-as-current-user',
             '-w', here, '-v', mount,
-            cc_dockerfile, plan['cc']]
+            'qemu/' + cc_dockerfile, plan['cc']]
       has_cc = true
     endif
   endif
@@ -279,7 +279,7 @@ foreach target, plan: tcg_tests
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


