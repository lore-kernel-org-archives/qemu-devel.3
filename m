Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C71EC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJR-0006Dr-KR; Fri, 04 Sep 2026 08:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJJ-0006AO-If
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJH-0006tL-0U
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-499ae1c6471so8072505e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525982; x=1789130782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c+FJ/oOz1qV0GzxFUtglp+TOIxJt2Id0fG/QCO+m7Lw=;
 b=x8KDxio0+1rS0IIF4FSLn8TvNMc7I+EkNigkG5N5xTwDqaNdtx3PN3awWqZy2hMgA2
 p+TVtPjSGSFUFEHm/HqK3EQyLw+JYaKNTl06Wew+ACMN2VkOCSfPCjBsYkRY68YlEaV/
 zEZQXpOGG/XfIguVatDrKf028JjNJuofvC18xqsbwMemsU3D0fQ7Tv3/LShzo+wR7Lp3
 K38rI85ur2eFiY8ux81npLNs16PXNC8HUp/nnY7djOYYL+6AAmNE0NDNBPgTqBkg6J/6
 3RPnJWNRjUg8s2PnbPN9eKM95ELWuM28LUjnp0DSMeh3igVT2zlwsI46GzNvBbYZREdm
 morw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525982; x=1789130782;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c+FJ/oOz1qV0GzxFUtglp+TOIxJt2Id0fG/QCO+m7Lw=;
 b=fVACiG31E/6hBZu1FKeYSjVC9UMsJllC1vEXr4XXYEq0zpVuhkCDkjcHS1Cx27h159
 tXXGpeSluXip7JT/ay24dj7v1D9QLp2fJbuxPHCP40un0Yg6qyrzs/DtFhq2lI1sx+nF
 2s42J7d8DWlo2C2z66r+/wmZyTsIkR8vWbfX3zNW5pxRItuH/eXLGYqPMHP2ZxsYHfWn
 fVKRQzMz+e7XdF/9uRRTND0g529Z7LzJg9GaodYBk0tFRwpSoE8Y3fcRdZ3TkZj7S7Il
 WmXslhX09lOm3qCoyrt8LC4myV81x9DxspiDxrXuXkT3ceq1P/2SPNvACW5W7yj6AnAv
 13qA==
X-Gm-Message-State: AFuF++kLwki64Ra9IxVimqP+WBMCjmUuDWywTSEMPMGCH/vIRQdqVcN4
 M7cum1NiTwvoQaeRmfi1TRY4S9K8TJyGWWnY0n5AZUZsds7W2KVZr10JCtZFtLM54GU=
X-Gm-Gg: AYBFou2gg5OUNJ5LFVjRc9DzPHlVYzDNR69iLT7PGK5SFOuNamlt9adjvs++7YWVtgQ
 GS8a1rwvqk4OESKnKtA1txdZP99iWHJev8Tk1QCQz3vFuWYL3kAtWSbYVHE0C1s3gcLyl0NAxzw
 1kr13Z898kOztgB7ZV08M6q2BfrwPIQEGVIpcSrIAWbSirDz7RkVOXNpIDefbgaTpjx6Tvi/NYO
 YWwAs+8tuG8V8R62KUvaAWNWEkCgbqIvkj5v3mU0XOjaTeeBRS1KyBeZB6OwMDZLJVkg0+XgDFU
 u0NBu1PFCm8YXGZkeNclzzixBC58gTNkBxqli6ZmqtjESk2JSF2kS+VPB/KdYfA37Iu7T4FGohZ
 Z/nCIEKvCLpMN/2Id6xBjb6B6JBfRxyulMfNRP/31xTYBjaajPrMFKISs1jpBGcxOoAinzxPFs9
 q67a21TKrIze0LD/pp6UAtzWTc2tJissHK69TVVjuZeueLsmSN77jyPx/yrVer
X-Received: by 2002:a05:600c:3496:b0:499:b65d:1250 with SMTP id
 5b1f17b1804b1-49cf7fe62admr94148325e9.2.1788525976561; 
 Fri, 04 Sep 2026 05:46:16 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883959f0sm6565662f8f.10.2026.09.04.05.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4D5361511;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 016/105] tests/tcg/meson.build: introduce expected_output
Date: Fri,  4 Sep 2026 13:44:30 +0100
Message-ID: <20260904124604.2207440-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

A test can declare it expects a specific output on stdout. In this case,
we compare it to a reference file. We implement this instead of relying
on a wrapper because we need the flexibility to resolve name of
reference file per target.

For instance, multiarch float tests expect different ref files for each
target, which is something we can't express with a test wrapper.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-17-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0311b2432e4..f5fd9bee7bc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
@@ -23,6 +24,7 @@ tcg_tests = {}
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
 #           'qemu_args': ['qemu command line flags', ...],
+#           'expected_output': 'file_to_compare_output',
 #           'gdb_test': ['gdb test args'],
 #           'env_var': ['VAR=value', ...],
 #           'wrapper': [program_to_launch_test, 'args'...],
@@ -86,8 +88,9 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'env_var', 'cflags', 'gdb_test', 'plugin_test',
-                   'qemu_args', 'test_name', 'wrapper']
+        allowed = ['exe_name', 'env_var', 'expected_output', 'cflags',
+                   'gdb_test', 'plugin_test', 'qemu_args', 'test_name',
+                   'wrapper']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -201,6 +204,11 @@ foreach target, plan: tcg_tests
               ]
       endif
 
+      if 'expected_output' in setup
+        expected = files(folder / setup['expected_output'])
+        cmd = [prog_run_and_diff, expected, cmd]
+      endif
+
       if 'wrapper' in setup
         cmd = [setup['wrapper'], cmd]
       endif
diff --git a/tests/tcg/scripts/run_and_diff.sh b/tests/tcg/scripts/run_and_diff.sh
new file mode 100755
index 00000000000..3e51cdc9663
--- /dev/null
+++ b/tests/tcg/scripts/run_and_diff.sh
@@ -0,0 +1,15 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_diff: expected_output_file cmd [args]..." 1>&2
+    exit 1
+fi
+expected="$1";shift
+output=$(mktemp)
+trap "rm -rf $output" EXIT
+set -x
+"$@" |& tee $output
+diff $output $expected
-- 
2.47.3


