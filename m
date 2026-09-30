Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502A3CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxSi-0001Qb-6k; Wed, 30 Sep 2026 12:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSP-0001BH-1n
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBxSM-00032b-Qi
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:47:00 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so35382495e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790786817; x=1791391617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2qzhyyXoHGr2yM1D8JSzEFWAGi8kfk3KlB3Oj53o17M=;
 b=A4tL7bJqLu7XL8Rzh8n6o55oTP9XCG2gpRdbfWxQiP7wloPQNpgzflyGp86areuga5
 eSALMeCFzeCXfARt+JP3EBQXkcCnsbYaYW3IbRz/T3Uv/SM3bDkbGUbwvdYs69y4RVH5
 o8u5DEtHN8Z090FtlB6VUdXqhXH4bfqznNEmGbAMGcxuTHlBrP08AXSg8NVuekuQrdz4
 3B2hK+C3uGfyuZWyLbqOLNPT0ErRHWdr/P35t9BmfToKSzqnTUJrJCdRJTL1z+Z95fQ3
 Pt66AbypWRqImILXntb+SmM2SIk5iWkP6UO23+mej/3daGD20gtpE2f77KmuISJQ8ixS
 NB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786817; x=1791391617;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2qzhyyXoHGr2yM1D8JSzEFWAGi8kfk3KlB3Oj53o17M=;
 b=d9h1R3a8s+OU6BH1gChCChJClLtRpNJJ+8tpubsBADYgaMVWqfXda4gRvmcTRJEmNJ
 gQiOprFoYgqjqWpiZkHHFWK6ONySbo5386EFKDclDFHDw5d64qk6QVvlz79yxUglkWSy
 599rCJSw+91nbn74/4Y+JZou2YFQ/1SnhW0b1B+Snh6KpuyJasfHHs233ydDZMosGPnE
 xDgF+7RAVg1Ye5Gg/7LaxsR8/78Y2TD5IVKpCb9h6HWUYxywxs9ka5F1kKbiZsMlBCVr
 NluaoG+dERJUwSp43f2pPUiNA/0VMTWfKVVRFX/LtD9qKeb7IeLIlgStyzHQfVEYrVUi
 FWQw==
X-Gm-Message-State: AFuF++ktX2hHa3LQWRL1FPlpHu6hIk9G8cEAPYchTBAPh315NM5LGtFc
 IZF9SpeDMEj+JcE35xmAUPaMl4AtsYqJ6zRcf5CJLOdaldPIOA7ZHtwXCGA3Rws7o2k=
X-Gm-Gg: AYBFou04rh0fJkInFKiUsOt8CbWk057RnmBUXfOOkNHuQciz2Sx4+R7nzidY1ye6gTT
 njdIvUlxcrD6XKwu19duZXW0cUS9MKkM1dJvj0hI1Fu006rnNP5fKnZ5gp2OzaT2tPQhSMPf+8u
 rqw+c43uZ80DOgxIr2RIW1XZfMQ8LHp4I4/XxIR8Qpj8rHWQYo29crbU3n+jKEm2Jrm+4DFUJ+M
 TbtTsXJq7QZQFCbizRg6owcGLLZ2vJZnhLC4S39/Reckx5Wz4AZ2WZJK4jRj6G4l+k8wQOjN+vX
 11ar7ZqniPwfIzChbyBXNNoAqbE2iWIXdEpUFy0ScbMVQ97f7Kb7Sn3UhdCb8qKKKqgAsnJpVAK
 pd0juYOf8R8Zg8j4/31CegKDy5EmzfrtFO9OdfdCjUdXPAWnxRQ/WKv4fQjDzGVYWsVFc7EZmHa
 fnVgFagf62PLBf/If0DrRgoYcg2FPYeV2n30aD5VaCpeVwLUeIYjVQqupmV9MeEs18RVVhIHzpx
 11RicaU
X-Received: by 2002:a05:600c:19cb:b0:4a0:1c17:4fb2 with SMTP id
 5b1f17b1804b1-4a01c175025mr27208655e9.31.1790786816818; 
 Wed, 30 Sep 2026 09:46:56 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01eba6feesm2921925e9.11.2026.09.30.09.46.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 247885F9CC;
 Wed, 30 Sep 2026 17:46:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Ani Sinha <anisinha@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 04/13] meson: move gdb detection into the top level build file
Date: Wed, 30 Sep 2026 17:46:40 +0100
Message-ID: <20260930164649.433573-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930164649.433573-1-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
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

Currently gdb is only used by TCG based tests but hypervisors want to
use gdbstub too. To be able to test this case we need to always probe
and report the gdb we have.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 meson.build                  | 15 +++++++--------
 tests/functional/meson.build |  5 ++---
 tests/tcg/meson.build        |  5 -----
 3 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/meson.build b/meson.build
index cae1591cd28..ea97047362c 100644
--- a/meson.build
+++ b/meson.build
@@ -163,6 +163,12 @@ else
   iasl = find_program(get_option('iasl'), required: true)
 endif
 
+if get_option('gdb') == ''
+  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
+else
+  gdb = find_program(get_option('gdb'), required: true)
+endif
+
 edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu', 'loongarch64-softmmu' ]
 unpack_edk2_blobs = false
 foreach target : edk2_targets
@@ -4707,14 +4713,7 @@ summary(summary_info, bool_yn: true, section: 'Directories')
 summary_info = {}
 summary_info += {'python':            '@0@ (version: @1@)'.format(python.full_path(), python.language_version())}
 summary_info += {'sphinx-build':      sphinx_build}
-
-# FIXME: the [binaries] section of machine files, which can be probed
-# with find_program(), would be great for passing gdb and genisoimage
-# paths from configure to Meson.  However, there seems to be no way to
-# hide a program (for example if gdb is too old).
-if config_host.has_key('GDB')
-  summary_info += {'gdb':             config_host['GDB']}
-endif
+summary_info += {'gdb':               gdb}
 summary_info += {'iasl':              iasl}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 if host_os == 'windows' and have_ga
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c7362dd00ef..68c601d4036 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -83,9 +83,8 @@ foreach speed : ['quick', 'thorough']
                      separator : ':')
 
     # Define the GDB environment variable if gdb is available.
-    gdb = get_option('gdb')
-    if gdb != ''
-      test_env.set('QEMU_TEST_GDB', gdb)
+    if gdb.found()
+      test_env.set('QEMU_TEST_GDB', gdb.full_path())
     endif
 
     foreach test : target_tests
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 96d5d1249f2..5861ff5ed25 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,11 +1,6 @@
 env = find_program('env')
 
 docker_wrapper = find_program('../docker/docker.py')
-if get_option('gdb') != ''
-  gdb = find_program(get_option('gdb'), required: true)
-else
-  gdb = find_program(['gdb-multiarch', 'gdb'], required: false)
-endif
 prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
-- 
2.47.3


