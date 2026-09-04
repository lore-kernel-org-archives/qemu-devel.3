Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CA8C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJQ-0006Dm-UI; Fri, 04 Sep 2026 08:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJN-0006C3-P6
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJK-0006uq-5K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso9440645e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525984; x=1789130784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tFpQ8psKfh/GfasFmr3B5G7VD9bDZo/cQLmAEF4vkwE=;
 b=cPNgP3MuOWIzIu66y2xO2ImizCFNbiy+l8e5KrzKHPRCaEHfCdHHIW6ICWGDMkjVdp
 H+8hTGaS9/ahMkxOId/FbSBufWte32eWPZoSHZds6SUjFSxjbeWqAtnRQsYfX3VoW6Q1
 kaZY6ARZkGsv6df+U2YIJjmUpMz6tgA/eS8Yf3L3GuAdzo3J814Kgs01I2/+rjZvYuQd
 JqWI2qZfojAFf8T2jqTOhdSQaPKkfdCL0gbzSnfMeYsIUnIGlAdrnIoGLCoED4jzkd+0
 kJ8Oy4oCR+HDqg+zF7v3Z85Z7o60WncbTz6LvAaA78ypvy2u6gWaQGAW4PxdKGvZMKGl
 y/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525984; x=1789130784;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tFpQ8psKfh/GfasFmr3B5G7VD9bDZo/cQLmAEF4vkwE=;
 b=mgtXbEu/eVK1BAy+St8q634qzw6gXXr95nEDZEgWc0t0KYqh7kIPSQiTA1v2vvq1EG
 A7UD/StlxKl7BhTRG6zjZ2RJVF+cvlg5KP6ieTyJ/xf/eqEylDFwsjadjPsoUqqfp6W0
 0keFJLnV45jnyN9DDKZQTlGUAWzsLdB0YPr0gyyZwFX2BQLwzDUy3wg094iMwmXF7IZo
 /Ieeagp9Lxmj7qBR1cGwMIICzC2uX/e/uyP6ikMgn4wu6OkOlqpMr9yPELi19XCrbxD9
 vfZiZ8cfrc4vIFKeF8g7kYwu4kfERuPQVxQDS41p3/6Yb8toGOH0nIaDloJPcwZII+cl
 AzrA==
X-Gm-Message-State: AFuF++mQiQx9bwN6HHNbNfY3wo5eh/S/JCT+GWedVqzW10iVp4vSP0mE
 vriQP4y+zCovQyJ1vtOZQZvR1taGzbSAQVlPIyYPu6DYHPaJomZrmX09+WEjKDK9idY=
X-Gm-Gg: AYBFou0nQ1oKmiAst3AjGPVMijU2BfEI+sTtGWywgMfhsRMFkbbCBo1UwSAIo57nKMj
 9eCpl9azwRlDNNF1PDQwJJYetB97lUi8Fy93vFv1F+Q265T4ZOmPOLO1BzpbE83LQ07wuLRSeUi
 0C7MuioyZ/rRMTCezQz73p/IqurATzIcjYSaY04ZCUtmiXBwhFQhBfXExng4yXeEruOnN0DASmT
 45d9ocvC4xD/U6FbdJKv83bFoTN9e2X0BEYTsVmFSL1tz5fknnBsR60jVeIaUAKBsE2G1bzGe4N
 p+mvsOqP2ykU4mGrXiowyxkFDjUT/ZzZUjeSdsk+RrFkbKgh2EmXNTeRCyknt9wXjxIP9ZbVM4x
 Rji3YnyFuvdA9XyE8Qvtoff7C2m6vyIb4lcz4D4e0Wrxx7qe18JoTyg6+MbexUqWg3CZ1S6y7Ei
 gg4t7T9hcyLTGmF8CC0Rh7xlg1CX0uMCczRA0tENTeCwDBpWBXD8KyqAlrHYTD3sj+jZmU9DMV1
 A==
X-Received: by 2002:a05:600c:3b01:b0:49b:4d64:bbc4 with SMTP id
 5b1f17b1804b1-49cf81f1592mr81758895e9.8.1788525984271; 
 Fri, 04 Sep 2026 05:46:24 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm117851625e9.1.2026.09.04.05.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A65261E24;
 Fri, 04 Sep 2026 13:46:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 100/105] tests/tcg/meson.build: implement ./configure
 containers options
Date: Fri,  4 Sep 2026 13:45:54 +0100
Message-ID: <20260904124604.2207440-101-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

./configure --disable-containers now skip containers build.
./configure --container-command "/path/to/docker" can be used to
override autodetection.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-101-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index cec6f18f857..aa98cf39584 100755
--- a/configure
+++ b/configure
@@ -172,7 +172,6 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
-container_command=""
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -260,7 +259,6 @@ ninja=""
 python=
 download="enabled"
 skip_meson=no
-use_containers="yes"
 rust="disabled"
 rust_target_triple=""
 
@@ -727,11 +725,11 @@ for opt do
   ;;
   --disable-plugins) plugins="no"
   ;;
-  --enable-containers) use_containers="yes"
+  --enable-containers) # enabled by default
   ;;
-  --disable-containers) use_containers="no"
+  --disable-containers) meson_option_add -Dcontainers=false
   ;;
-  --container-command=*) container_command="$optarg"
+  --container-command=*) meson_option_add -Dcontainer_command="$optarg"
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
@@ -1718,9 +1716,6 @@ echo all: >> $config_host_mak
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-if test "$container_command" != ""; then
-    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
-fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
diff --git a/meson_options.txt b/meson_options.txt
index a41ed64bc90..f9604a6c192 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -387,3 +387,7 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
+option('containers', type: 'boolean', value: true,
+       description: 'use containers to cross compile tcg tests')
+option('container_command', type: 'string',
+       description: 'command to build/run containers')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 144577fd94e..2458a231f5f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -78,10 +78,23 @@ if gdb.found()
   endforeach
 endif
 
-docker_probe = run_command(docker_wrapper, 'probe', check: false)
-docker_supported = docker_probe.returncode() == 0
-if docker_supported
-  docker_wrapper = [docker_wrapper, '--command', docker_probe.stdout().strip()]
+docker_supported = false
+if get_option('containers')
+  if get_option('container_command') != ''
+    # make sure command is working
+    cmd = get_option('container_command').split()
+    run_command([cmd, 'info'], check: true)
+    docker_supported = true
+    docker_wrapper = [docker_wrapper, '--command',
+                      get_option('container_command')]
+  else
+    docker_probe = run_command(docker_wrapper, 'probe', check: false)
+    docker_supported = docker_probe.returncode() == 0
+    if docker_supported
+      docker_wrapper = [docker_wrapper, '--command',
+                        docker_probe.stdout().strip()]
+    endif
+  endif
 endif
 
 # plugins come first, as we need to build the list
-- 
2.47.3


