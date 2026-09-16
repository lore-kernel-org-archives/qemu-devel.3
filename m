Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1FFC982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rae-00027p-4V; Wed, 16 Sep 2026 11:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rac-00025G-Bt
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:26 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6raY-0001MZ-Cg
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:24 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so6595825e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572621; x=1790177421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=A8yhkYrv3xvM3F7NcGJheQJxr1oV0vuUzhu9GRaxQgc=;
 b=DZLiSTK57q6yUhozdz7jVZ3bTx3BlkbcXxPXvKZhtflpapT6711uwNuqFoeJNjl3V7
 5oSGtm21agiDiEvrli9TUbsP9c2HwXhIkwFkaHKQ2wMq3zEdZ4GCYbUteYhSC8JaJlsP
 dODtdsu8jSeuhlufBaf2CJwa4MuATiQCt6YyJSHZWmPWBRBwxwXVe0trm/CfkgdmifXT
 RuDpeN4eBnUARvTyPU1ARpW7uFKXxMWr0O2uYFRrVC2LvKxuOqdVCKJJou+EJupGaLzi
 su/vTmmb4D50dB30wTmp6crvle6kBFEcYy2qAGvL/1CrWXMaPpyrM/R5sNKISGVXFsVd
 R6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572621; x=1790177421;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A8yhkYrv3xvM3F7NcGJheQJxr1oV0vuUzhu9GRaxQgc=;
 b=0Vw8t6LSEMlP53HsgIGTtE6tTgPQ/FQSMFnTvjW+9djaxUcLjhsyH/LtPlb8x8twZs
 TEPoRLDQWa9KyIM4vqsDEHIu98Wsbdsfu74O8LMy+O61dlTrVFBMEX1hs44y3Ji1Crcp
 I1G/yk04Y9xtBe8l94l2u1hVC2vwYBZtUiW1ZJGgep+/5mweRFy11rINuA6cJmh50+I+
 JP8f11nBe+wh84KnyS0XRXV1RK6NYD9rag0pvqibCUZ7LtGh6H+oKzpRzHs1IzUJep+N
 rXQ+URFEvOfoseHjMqkkd1azzXFH2/ePRT8dwkywVdU2BYNMXCzKhdJ5NzeNeTFcxe2V
 ZtUA==
X-Gm-Message-State: AFuF++lJEZeGVvHdX3bwKuh4elMAMvwsUqgdNEHeEG8DpqiUVA3jMvTg
 1oxh1JjVTXIytUR2tRMRTrymST6tDKUK3P4Wn4jTgiZyS0pxSq4s06hlj/CZ+LPkZYo=
X-Gm-Gg: AYBFou0HsGjdboAIT2zsXIv9cOWAkQq6avWme/v2DjaLGJ6SgkHke33p7XO1orQRpBO
 l3xvDrsVMnV4h7DQ9HqLVGrb8HoiHFBa0/YKfMAaO91YIJtmzeyuINsrH5GEApXH0BmO95EdDTN
 4hpB8op/nfmJqC2czm8NHhbEjP2c6vOAtw00c0+gx1h3+Bae9j0KODyaabF1aBEMQKcHYXoIxzl
 uH1lrUtkwM4YC/UV99lnwlDPtW+hAZA0K6Lf0tCjEoLHAxrmJS+bgxg8NqzkSda10d5Q44/AxP8
 23873TPrSPtJdiEr5Q1lION+kTM126MatFwHc8hyXOJGppM77HDy9dmHDf0REhOUKqHB7QvS11B
 3+WiF5kVgwmScN0RFekPwDt/KLX3RSH0cGl2HSMNOsJGUjlOOkeZaTrGdbZmeSutyI2MENLJxVl
 avYlh9oGrsnhT1QhVegvELrcZV3Cq7p+WytuvynB7lAt8c24Y8CCnI9odCfs0hBHP0PCLFL7Q=
X-Received: by 2002:a05:600c:4f49:b0:49c:ed94:cdd8 with SMTP id
 5b1f17b1804b1-49fbca1a8ddmr15963845e9.6.1789572619617; 
 Wed, 16 Sep 2026 08:30:19 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd1b147asm135475e9.10.2026.09.16.08.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82668618D5;
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
 Richard Henderson <richard.henderson@linaro.org>,
 Jared Rossi <jrossi@linux.ibm.com>
Subject: [PATCH v4 03/19] Revert "tests/tcg/meson.build: implement ./configure
 containers options"
Date: Wed, 16 Sep 2026 16:29:56 +0100
Message-ID: <20260916153013.2134555-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
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

We want to keep the container configuration inside configure for the
firmware builds.

This partially reverts commit 522b299ca4316d8cad57f9496ffcba87dcc20719
while keeping the plumbing to disable containers within meson.

Tested-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
[AJB: untangle changes since]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Jared Rossi <jrossi@linux.ibm.com>

---
v4
  - tweak revert to keep disable reported
  - update commit msg
---
 configure             | 14 ++++++++++----
 meson_options.txt     |  3 +++
 tests/tcg/meson.build |  3 +++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/configure b/configure
index bedde58b8cf..6084a7a065e 100755
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
 
@@ -727,11 +727,14 @@ for opt do
   ;;
   --disable-plugins) plugins="no"
   ;;
-  --enable-containers) # enabled by default
+  --enable-containers) use_containers="yes"
+                       meson_option_add -Dcontainers=true
   ;;
-  --disable-containers) meson_option_add -Dcontainers=false
+  --disable-containers) use_containers="no"
+                        meson_option_add -Dcontainers=false
   ;;
-  --container-command=*) meson_option_add -Dcontainer_command="$optarg"
+  --container-command=*) container_command="$optarg"
+                         meson_option_add -Dcontainer_command="$optarg"
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
@@ -1718,6 +1721,9 @@ echo all: >> $config_host_mak
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
+if test "$container_command" != ""; then
+    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
+fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 echo "PYTHON=$python" >> $config_host_mak
 echo "MKVENV_ENSUREGROUP=$mkvenv ensuregroup $mkvenv_online_flag" >> $config_host_mak
diff --git a/meson_options.txt b/meson_options.txt
index 66d3689d14c..daf301ed48a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -389,6 +389,9 @@ option('rust', type: 'feature', value: 'disabled',
        description: 'Rust support')
 option('strict_rust_lints', type: 'boolean', value: false,
        description: 'Enable stricter set of Rust warnings')
+option('container_registry', type: 'string',
+       value: 'registry.gitlab.com/qemu-project/qemu',
+       description: 'container registry to cache from')
 option('containers', type: 'boolean', value: true,
        description: 'use containers to cross compile tcg tests')
 option('container_command', type: 'string',
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ce208e686ff..890da7b81e9 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -101,6 +101,9 @@ if get_option('containers')
   endif
 endif
 tcg_tests_summary += {'container command': container_command}
+if get_option('container_registry') != ''
+  tcg_tests_summary += {'container registry': get_option('container_registry')}
+endif
 
 # plugins come first, as we need to build the list
 test_plugins = {}
-- 
2.47.3


