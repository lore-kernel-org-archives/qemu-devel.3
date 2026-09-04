Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBC3C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:49:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJO-0006CK-7J; Fri, 04 Sep 2026 08:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJM-0006BH-67
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:28 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJJ-0006ub-BW
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:27 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so9168845e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525984; x=1789130784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dwaCZdsJYlqcxTKd4393FEZpoMWYHWUJsBFlxpnir8I=;
 b=gbm51yLwZ7y9Ld/s/f/kkoYgv3VkixghfuATgxm8es97712MBmRvIW9PCNhYFHX/We
 fl7dWxz71uUVBH3HMhnEvEJZ9oYb84p1oPyY2pft7Yeuuvu8jZxueojl+/pQIKAji0pk
 IcOcR4MuL3xdu+Y3Lz/iyNmYCcQrLNbBL7FZI53krmVkZREsTOTIGc6bdv1G9UD/O3Ah
 1Mo4qAao+JDfop2NBcYzy1rIAdl0YM/uTJzEbv0hbDbf9QPwikrDo3gDftdw3XsEDtQE
 EX8iBnBHJ7JFRkxPKbpieeIMNW/XtiareU/S5HnTi8DfpdcLvp8IBCustkZzCuuE689I
 QOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525984; x=1789130784;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dwaCZdsJYlqcxTKd4393FEZpoMWYHWUJsBFlxpnir8I=;
 b=et1jLYEq01bMwR1us/+7s4hwTJz5n9AAGNEBXaDV3uZOgpIx6CgLggC17SEzRU/ODC
 f5uvP+WLTZB4TMrV4zCxYggrGhJS4KoNmKktHu8RfOLWIGeiu9c3MQcsv/nTxw6+PisD
 iFqKF/hxzlQQfBRnGvsrtJitXJC+MysQPv4cmiIGZI0sxcypRtkreSKJVF/+X9GTmP8X
 RP8Ydtsb6cmYahiLmRl5NlxNCA8gjSwaQRkE7pZzMif2sBHeD2QfVSFBImUrj864aD8e
 r2YOJBK/I+RNsEf0sZpQA1KtSWR2uM3vhslcXSaVPqJHMpl4ediWGUY/1dcH41xo5lST
 ErBQ==
X-Gm-Message-State: AFuF++my/7BVe1g5En/fGp4nc8jn16w58s9GF397NR4vHnJU3y37npOB
 t3AnJJiMr0MesMQpnOh3pFs2NQ7gAlZKkVyuyirp5936qSHZqJgL3VPYexQyKabsK8E=
X-Gm-Gg: AYBFou3FNrEeUnQ3bSgolNCQU0AMmgag5z5cOX6CWAoSaQZmM5B4kPF591d8QoydIi4
 1fW/Ndwry651k7sGeQceZa3E5gjW+LcMOeBoFlDY7mqex9UzyoaTo4l8P7+oqr/9mfDts/tAoAW
 OEm8N9fvwLVot/6yLyf6DkXUzwm/Ri3G/YR4MbHtQw7LrmKYJV3TkI8PMtzVeMqahc645pXLvMS
 eAxbxFWW4afn7QEdb0xoYILS9ANX4CvX4j3BfstEafbHTlMSZ5p7KDTDA0HB1SHkVoRVLgRzuQ4
 A5pYP5j6SgUBMBIbtFies6n7HBWrU6N2LoHE6KtZDfq1MmZZ7v+oSkdwJeGPDWqarLbK20CrJTy
 MiAwJNlqVmWYoTxFT84uccgIX39UveM4JHHouCN40rzaCCM4GwCyv2hEf4Y/mo/e/Edd98ZTv+O
 Uu9SOP5TrvU+8w+56Za1WHDp7N6QJpIS/EITiBaXgwrXO+oSkdkF9Ung7CKa1h
X-Received: by 2002:a05:600c:a0b:b0:49c:cee2:1697 with SMTP id
 5b1f17b1804b1-49cf8262133mr65404605e9.16.1788525983764; 
 Fri, 04 Sep 2026 05:46:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885cb03asm6043070f8f.37.2026.09.04.05.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E147961E15;
 Fri, 04 Sep 2026 13:46:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 099/105] configure: directly pass gdb path as a meson option
Date: Fri,  4 Sep 2026 13:45:53 +0100
Message-ID: <20260904124604.2207440-100-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Move the remaining bit of the detection logic to meson. We can assume
gdb can be probed since gdb-9 has been published more than 6 years ago.
If ./configure --gdb is set, make sure the given program exists by using
find_program(..., required: true).

Also, using a proper meson option lists this at end of meson summary.

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-100-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/configure b/configure
index cb5fdfed221..cec6f18f857 100755
--- a/configure
+++ b/configure
@@ -263,8 +263,6 @@ skip_meson=no
 use_containers="yes"
 rust="disabled"
 rust_target_triple=""
-gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
-gdb_arches=""
 
 # Don't accept a target_list environment variable.
 unset target_list
@@ -737,7 +735,7 @@ for opt do
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
-  --gdb=*) gdb_bin="$optarg"
+  --gdb=*) meson_option_add -Dgdb="$optarg"
   ;;
   --enable-rust) rust=enabled
   ;;
@@ -869,7 +867,7 @@ Advanced options (experts only):
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
   --container-command=CMD  which container command to use [autodetect]
-  --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
+  --gdb=GDB-path           gdb to use for gdbstub tests [autodetect]
   --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
                                is to use the whole 64-bit range).
 EOF
@@ -1120,20 +1118,6 @@ if test "$tcg" = "auto"; then
   fi
 fi
 
-#########################################
-# gdb test
-
-if test -n "$gdb_bin"; then
-    gdb_version_string=$($gdb_bin --version | head -n 1)
-    # Extract last field in the version string
-    gdb_version=${gdb_version_string##* }
-    if version_ge $gdb_version 9.1; then
-        gdb_arches=$($python "$source_path/scripts/probe-gdb-support.py" $gdb_bin)
-    else
-        gdb_bin=""
-    fi
-fi
-
 ##########################################
 # big/little endian test
 cat > $TMPC << EOF
@@ -1734,7 +1718,6 @@ echo all: >> $config_host_mak
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-echo "GDB=$gdb_bin" >> $config_host_mak
 if test "$container_command" != ""; then
     echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
 fi
@@ -1930,7 +1913,6 @@ if test "$skip_meson" = no; then
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
-  test -n "$gdb_bin" && meson_option_add "-Dgdb=$gdb_bin"
 
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
diff --git a/meson_options.txt b/meson_options.txt
index d8f59cf92ca..a41ed64bc90 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -36,7 +36,7 @@ option('trace_file', type: 'string', value: 'trace',
 option('coroutine_backend', type: 'combo',
        choices: ['ucontext', 'sigaltstack', 'windows', 'wasm', 'auto'],
        value: 'auto', description: 'coroutine backend to use')
-option('gdb', type: 'string', value: '',
+option('gdb', type: 'string',
        description: 'Path to GDB')
 
 # Everything else can be set via --enable/--disable-* option
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 76f8f3e6e02..144577fd94e 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,11 +1,11 @@
 env = find_program('env')
 
 docker_wrapper = find_program('../docker/docker.py')
-gdb_progs = ['gdb-multiarch', 'gdb']
-if config_host.has_key('GDB')
-  gdb_progs = [config_host['GDB'], gdb_progs]
+if get_option('gdb') != ''
+  gdb = find_program(get_option('gdb'), required: true)
+else
+  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
 endif
-gdb = find_program(gdb_progs, required: false)
 prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
-- 
2.47.3


