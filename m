Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB650C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 08:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lOv-0007qx-Fl; Wed, 16 Sep 2026 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOn-0007kv-Tr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:51 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6lOk-0004yT-GS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 04:53:48 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912e4ad9so3474225e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789548823; x=1790153623; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ry2sd1z4lQEPz/cq12Fj5YfxjJ6T7+6xlmSJ+36c4vQ=;
 b=Su3DbH+YMF9MHUtwWRK9okXHUcedxttmBQp62bz5K7iUsnARpHU038beDNhem3i/u7
 b294vzLFsNeb6Opv0VHAVMvq1rbtDxZzMJ7ikiTqrzaWvWKf70Ll8l5BfD5vpgKlsIbt
 minZyG1ox6wOMy1Z6u+nPrkA0JoDoPIKQl+08NGhs5Z64g0+PnMLqSgRO/4rp2T3lJai
 sCGGZKXFe09kwNpnlt3A6TZ6CUeSbA4U58zwEsdpYTGJOfYOaqrZi4MJuuVubUUhGiVR
 rcUx02ak3z0ZsBTf27sGSv8FxO33VXG2le1xjFOtvSSN0LjSXQTy7AjquL8+UWAAfrLL
 P3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789548823; x=1790153623;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ry2sd1z4lQEPz/cq12Fj5YfxjJ6T7+6xlmSJ+36c4vQ=;
 b=tAK/75rzjujvyHDV1fOMUHcGXdVEXV7Yy3OGU1WX6Lem5xjSPJ42AqRl6QB8MU/MUP
 rC9DiS+VNT7FrUGHtMOMJcewXGchbAJ2HWWgxcnQ7C5VdU4vhxu+Iejvas2eauXksThp
 22z/WVLJqyXT1k57Nhn4Mr892JZCzZBBpf8hTFkngwNnYkmaOgYQwd2mTszE63RLd+cV
 20dNxwzRRR/mm+u+iCS10Yug629I/OJKWP+QUdiolnlXjlE2n3YRy6XYSZD1aolt9wJA
 Rwpz4/HZ94p7mU/jLmFCSAZMp/tz6/3zz6pOMnB1tp/F2bzWSg1GldE0axPL7xd2KZpN
 PM2A==
X-Gm-Message-State: AFuF++k3OvbeytvwdxCjZNMBTs4gYM+nuSNjwRpCNG3j9Ln9bTr92XcZ
 Gkq4B8aNtR511ZRLHw/RrvJdjK7srO8WR0HdAxGbbUQ776S8TzQCt62//E6qfq/lufs=
X-Gm-Gg: AYBFou04kLgF/K9xEqVAq4Ms2FESCH2+FlVwFAhRstdesBDhtRTdpJbC5qClXs0IFBY
 VsSN02GalrbpPBKdU58q0l8UeIvNGbhrWpct3eD2DTfKYJqYQI+z+4/gtf6UyZOUiIGn7JZoG3N
 cqm6stveHAyDRDnyjOS5MXaMudd5k8yCftrqMoTiJe9MIRNqbP9ZvSvL7IiDDvbqj4EJTsVjJuP
 1T8yZo8o/aQJPxqwq/HAShHF5OTqzrzGGR6IcqCrRtsXW6vtFoHQuI4PqSXyYMdnt8HTPZ02h0U
 8XDhxyyiwLSYp2bZ6oInRfoPFiInsMy5IH00fXOP1O50O6gBSUU6iv/7cZYxBrjMPj7WJkTtDwg
 9uH0C+OHiSdlaKRcg/gzQQ+qHWp7sstYcd49gFtY8fX9coEcMX4glX9ZB+2Lbu2hwG5oGCZLIaf
 4tnkwwYdP6t+d2C/REHgFcQHgUuAJxFTQS2V6IwBJQgygE9J+M4BvUezzntJf/N2rjc16/KoM=
X-Received: by 2002:a05:600c:6208:b0:49e:660a:935e with SMTP id
 5b1f17b1804b1-49eb7340978mr18023765e9.29.1789548823390; 
 Wed, 16 Sep 2026 01:53:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf462cesm5652880f8f.37.2026.09.16.01.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 01:53:42 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B9A286178D;
 Wed, 16 Sep 2026 09:53:41 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Warner Losh <imp@bsdimp.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 Kyle Evans <kevans@freebsd.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v3 03/17] Revert "tests/tcg/meson.build: implement ./configure
 containers options"
Date: Wed, 16 Sep 2026 09:53:26 +0100
Message-ID: <20260916085341.1692742-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916085341.1692742-1-alex.bennee@linaro.org>
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
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

We want to keep the container configuration inside configure for the
firmware builds.

This reverts commit 522b299ca4316d8cad57f9496ffcba87dcc20719.

Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
[AJB: untangle changes since]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure             | 11 +++++++----
 meson_options.txt     |  4 ----
 tests/tcg/meson.build | 25 ++++---------------------
 3 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/configure b/configure
index bedde58b8cf..25d26376f12 100755
--- a/configure
+++ b/configure
@@ -260,7 +260,7 @@ ninja=""
 python=
 download="enabled"
 skip_meson=no
-use_containers=""
+use_containers="yes"
 rust="disabled"
 rust_target_triple=""
 
@@ -727,11 +727,11 @@ for opt do
   ;;
   --disable-plugins) plugins="no"
   ;;
-  --enable-containers) # enabled by default
+  --enable-containers) use_containers="yes"
   ;;
-  --disable-containers) meson_option_add -Dcontainers=false
+  --disable-containers) use_containers="no"
   ;;
-  --container-command=*) meson_option_add -Dcontainer_command="$optarg"
+  --container-command=*) container_command="$optarg"
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
@@ -1718,6 +1718,9 @@ echo all: >> $config_host_mak
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
+if test "$container_command" != ""; then
+    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
+fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
diff --git a/meson_options.txt b/meson_options.txt
index 66d3689d14c..218d003a80b 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -389,7 +389,3 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
-option('containers', type: 'boolean', value: true,
-       description: 'use containers to cross compile tcg tests')
-option('container_command', type: 'string',
-       description: 'command to build/run containers')
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ce208e686ff..e966774c8c2 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -79,28 +79,11 @@ if gdb.found()
 endif
 tcg_tests_summary += {'gdb': gdb}
 
-docker_supported = false
-container_command = false
-if get_option('containers')
-  if get_option('container_command') != ''
-    # make sure command is working
-    container_command = get_option('container_command')
-    cmd = container_command.split()
-    run_command([cmd, 'info'], check: true)
-    docker_supported = true
-    docker_wrapper = [docker_wrapper, '--command',
-                      container_command]
-  else
-    docker_probe = run_command(docker_wrapper, 'probe', check: false)
-    docker_supported = docker_probe.returncode() == 0
-    if docker_supported
-      container_command = docker_probe.stdout().strip()
-      docker_wrapper = [docker_wrapper, '--command',
-                        container_command]
-    endif
-  endif
+docker_probe = run_command(docker_wrapper, 'probe', check: false)
+docker_supported = docker_probe.returncode() == 0
+if docker_supported
+  docker_wrapper = [docker_wrapper, '--command', docker_probe.stdout().strip()]
 endif
-tcg_tests_summary += {'container command': container_command}
 
 # plugins come first, as we need to build the list
 test_plugins = {}
-- 
2.47.3


