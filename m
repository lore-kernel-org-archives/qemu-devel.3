Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2766C624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJN-0006C6-Ru; Fri, 04 Sep 2026 08:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJA-00067X-Gz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ7-0006nx-AO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:16 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49b8f86c6deso6330725e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525971; x=1789130771; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=teGPBp6mPJUJs4TaZpHXhGv+0Qt5+TzsS+elK7wlTxQ=;
 b=YT0bOGN1q1Gu25bmhqpx8mwFj7Vmv9glQFJNtxuFFsKtbIvloMXPgLzMZ12Zt1fW+w
 nP0ID5utPVQjYfrp39XlpVftpfnBU8QHYI5lsbFJbg+IPmrFhZaWeJHpQIGrSaeWO2Tf
 1cpRhrN0JyMPgdq7P6/UvI1X4p+CsA0UOZA1CjsXcxRbElps+9/SvFzGzEXuVH21qEmY
 8IQ7/vc9Lrm3aAT/t6s4ZAHZPHycHw1GBYQTxzcwWdhaQTFvkXV4j4hcBtVWjC7b8TIl
 Gf5sQxeIsRPgayZ9SrzBJah7xGsnRTkuTobs00dHQCyMIAWRwqxWOIB5ENgdD0kEZfVJ
 uYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525971; x=1789130771;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=teGPBp6mPJUJs4TaZpHXhGv+0Qt5+TzsS+elK7wlTxQ=;
 b=ZnY35xXH/cxm8Q4yg+FWp1TNnplYep+TkcblfPdnJmkbVJZ8YB0GnrIheZCNcI3KQD
 vNXyp06tyyd+foj/Ikw/Y9NofxbiYFKAkj8BDr2mkuEGqOvGyEoCE1XokphqXhdJP18s
 VyBEdwuko+yR2+aNurVngkIBN5ivpUds329D92VKp05DxH6gYXzzsj2Z6th5QYlbKGYu
 uacW89fE4adtjfZHUUxOJen54o0nBCoFAxB9joCMudVFDz+pvJovFLqQwYE1kcPLsU9+
 7S4mR85LfeS4WjpC47RTgU6Ykck3o3U3Vkykk+1XI7QWVma1tmtpZMw8B32aWgFbxWsQ
 XMIQ==
X-Gm-Message-State: AFuF++l0PgFfixiUCQPorNSpEbSUy5ApfEt8qswr0vMt2T3GxnJoe6YM
 60Kl+cuJoD82/Vway6pWCCKdDDFAHGZsT7XxdBuqa1H0bq34WJybAA5wGEr2fmgrj3k=
X-Gm-Gg: AYBFou3jBPQkMeiT27sNXroDX6+IuJONeK0wrfiyacIixQpJOe6ratdPngL8Fh2HOGo
 qTQAVuT4l+1aJDjMDRayiuQ6b2bI6QAJom4cAno0cbGjlp9uiga8Geckcdi6UDEiS24AIxdAPss
 CUWrVMai0yGwHaWMCyMt0vIDlAlFxO7IWWrQx/BTefEYOaMj+WSCBkeGW+2wA2tQkXtn5C3RH6+
 BiYCf28CW613RCW0f5DQ7pyva1pFlVDVf/+lcq/58h8C+jn7VPnnjxe2AqEyBdzZmvZVZ4CcCD1
 N5L9Ia46Erv5HpXn7LpoyT1LKIztCS3EwIayTtFGxcc/IHa1H6Igbs8NIUjsux2yYAEePo8+6Op
 A0ngjqDJnfR1c/Oc8BiZ02xCQIohOLQ5EdD1qKN+bNRb44aeNaSM4UIeLn5KhSspKDf0FmljcRb
 swPdvoD9TL20H7GYqylAvUdp+k1cCP8JJw5kl2HaXROAO/huREtZZuvRKja+OZ
X-Received: by 2002:a05:600c:a01:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-49cf8222d53mr57595415e9.4.1788525971291; 
 Fri, 04 Sep 2026 05:46:11 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ab73c2bsm4689604f8f.22.2026.09.04.05.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3E19861378;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 009/105] tests/tcg/meson.build: introduce qemu_args
Date: Fri,  4 Sep 2026 13:44:23 +0100
Message-ID: <20260904124604.2207440-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

We add possibility to use custom arguments when calling qemu for a test.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-10-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index e8d8cfbcf88..a7699b7f62d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -14,6 +14,7 @@ tcg_tests = {}
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
 #           'cflags': ['additional cflags to compile test', ...],
+#           'qemu_args': ['qemu command line flags', ...],
 #         }
 #       },
 #       ...
@@ -56,7 +57,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'cflags', 'test_name']
+        allowed = ['exe_name', 'cflags', 'qemu_args', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -110,9 +111,13 @@ foreach target, plan: tcg_tests
       endif
 
       depends = []
+      qemu_args = []
+      if 'qemu_args' in setup
+        qemu_args = setup['qemu_args']
+      endif
 
       exe = built_tests[exe_name]
-      cmd = [qemu, exe]
+      cmd = [qemu, qemu_args, exe]
 
       # some tests expect QEMU env var to be set
       cmd = ['QEMU=' + qemu.full_path(), cmd]
-- 
2.47.3


