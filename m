Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DE8C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJJ-00069K-KN; Fri, 04 Sep 2026 08:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ7-000678-Lz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ4-0006mk-SH
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:12 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so10846025e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525967; x=1789130767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jXn9DJwqTpAKUyrG+DQesDqCOm3NZekdhJQD5j6wRLw=;
 b=CreVU+r2TxkYJlq6qRlWEwjp6hjQ/wQ5Rqe8Eo0WT1ds+LcDOfCyvex8DCaUMYR9u0
 wn3Bbl/2x8wWmNS+NlLLwpPgdR1ADS+VJyBiyFi1PHvsKepU9qy9nq5ZUC1eRQMsKqHK
 g0YuRYLTHWUplZ3eP7aLcKtAy4QYBE0msk/0LbFKku+El4qQQYVCHuitJtmEE8wYLp/0
 oX/PipqtxlEsF+cXRXlAf8LFwgPKZq2/DiXPUr/Ha70BrW1dUpm59DidMUkFUQJ2Vesk
 1Kg/iM4fBX8UGa6oMcAo54xBXcOS31PZdyp7rMqBYonzFc7XZvQQYxrWD4UWPCrLvj1z
 t0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525967; x=1789130767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jXn9DJwqTpAKUyrG+DQesDqCOm3NZekdhJQD5j6wRLw=;
 b=a44FDK7DXvyHZW8QpFEdE0KnP2ZeJGL41F86P4aVL4VpZhG+aElMve7Dkasv0F5YOW
 ClESJmMPmJJd1MS9fS5LV7tlF27K9GbNUf/E5KnBtekZZmxVffR3UHB0JqP2i1wHrYcL
 yMq07j1DoEVeYOYPuvpz4e/Lykc2sC0BiveNRxPQZLilN2B9z185p6bXmCClHI/UwExW
 EZwu6w18SLapPTzXSkdiX4jNpU2B8jX8LJ/TQhj31tx2X+5HjQUbMMxZVm8KmxMLV8sG
 KBNklzE+4WINqDfvnTwHxhAtHu1ryfTnctvKaMLLCeY3UBsE8/C8HW5OzQqbCJuw7nbd
 3qyg==
X-Gm-Message-State: AFuF++lSKqbbPUnS+ZbKYkMth1gQe4sXGCk0ATyV70Fi8uJf+m2GXVxG
 9DmP8c6L0C/7SuYKlNG8991Kw7HKSsPiysD5W3WpsP4TJFfigZVDwWKmLYWjy+khzzc=
X-Gm-Gg: AYBFou3cmWQy/sC5baLavKrlCC/FyDlYGyO1YieX4Ahqg26oRQBSgE5JQHclTGRtLSY
 Ypr/noarCwbqsp2CLBvmoPovUkCKs9iqXp9ImzgXeTmCcvagGCANn+Ssm/F3hvnDLYzqo7rUYv4
 dwwt+ebHuBwre9AZD3tUvBDkM5y2Gb2iXBrGokPL/1biq7UFo8KYf6C4+TlYLhInG/x5pjCQwoL
 N6YK/6siYsfYpVwZENBWNAXKmxMESmL5Zdd7kybYFxgcelTZ5LhIswQpR5xE+Bytzk3pzwo5yST
 sfwA1z+PYNhQ2eTmfbPGoFjMl83npYk5Z+51XOjxDzTLzf+sOEJOg9H3Y/Hy4ItbpRVnANFDJ+B
 jz+8KKn/1UZyEBHTCgek1ddazI96Ezh+YxdYM/yH4jmhPHhJAghieEwldpSg8Qpm3bbK0RLieCW
 jc6FlleCqpxpx8nZtVcSpPUN93dWcYHfWmHqUZmS81CheW4kVOF0gdUUbtyLML
X-Received: by 2002:a05:600c:34c9:b0:49c:f729:d757 with SMTP id
 5b1f17b1804b1-49cf824f757mr65173725e9.11.1788525966866; 
 Fri, 04 Sep 2026 05:46:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf771de2fsm69746845e9.8.2026.09.04.05.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9ADFE5F9DA;
 Fri, 04 Sep 2026 13:46:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PULL 002/105] tests/tcg/multiarch/plugin/check-plugin-output.sh:
 take test output as input
Date: Fri,  4 Sep 2026 13:44:16 +0100
Message-ID: <20260904124604.2207440-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Instead of executing test, just read it's output from a file. This
allows to standardize how to call check plugins scripts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-3-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index ab4bf9c5d53..9bcbbb11286 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,8 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh \
-	$(QEMU) $<
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/check-plugin-output.sh
index 80607f04b5d..338c9ced23e 100755
--- a/tests/tcg/multiarch/plugin/check-plugin-output.sh
+++ b/tests/tcg/multiarch/plugin/check-plugin-output.sh
@@ -1,8 +1,7 @@
 #!/usr/bin/env bash
 
-# This script runs a given executable using qemu, and compare its standard
-# output with an expected plugin output.
-# Each line of output is searched (as a regexp) in the expected plugin output.
+# This script checks that plugin_output contains line from test_output.
+# Each line of output is searched (as a regexp) in plugin_output.
 
 set -euo pipefail
 
@@ -19,18 +18,11 @@ check()
     grep "$pattern" "$file" > /dev/null || die "\"$pattern\" not found in $file"
 }
 
-[ $# -eq 3 ] || die "usage: qemu_bin exe plugin_out_file"
+[ $# -eq 2 ] || die "usage: test_output plugin_out"
 
-qemu_bin=$1; shift
-exe=$1;shift
-plugin_out=$1; shift
+test_output=$1;shift
+plugin_output=$1;shift
 
-expected()
-{
-    $qemu_bin $exe ||
-        die "running $exe failed"
-}
-
-expected | while read line; do
-    check "$plugin_out" "$line"
+cat $test_output | while read line; do
+    check "$plugin_output" "$line"
 done
-- 
2.47.3


