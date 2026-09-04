Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CDEC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJL-0006B6-4W; Fri, 04 Sep 2026 08:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ9-00067O-Qe
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ6-0006nn-5O
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso8391875e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525971; x=1789130771; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UNOH0UaIRqgspGP6aFoW2WW/YfZYC1hXCBrlkYsVaJs=;
 b=lhzVYb2g9jCTngkrCJpatYDev7Y6y1uk+FEZgOMmNW3ZGqFjKnl+oZc/5QjX+uTawT
 Ld6QeYf1nUx46OBObAW9aV9HTZIQ57EtDOyA6DMMmsD0tB3h3Najs60LVsNAQ2m0F73i
 D7Nb9gqtyhZxlr1pjvfEN+LDpRnbIB5nQlkr/C4yCQQyLUlIrNM1J4fjBRjrm44MQjlH
 SjcW6Kq+mCtGkH/BuUk5EAQXcOyoe3cqNldF6/zD398ElqbkSJASGml3/IPcswcIacpJ
 k29c0AYvvd6StRWhtTbRLaYdVUOJ4t2WCJtVTGyzGipD2gcAzPsn/UQV3dto4Ex3fXm8
 M5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525971; x=1789130771;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UNOH0UaIRqgspGP6aFoW2WW/YfZYC1hXCBrlkYsVaJs=;
 b=jWW+qKsa0w3uPzBXxAt9XMob5GmYD4KS7csKDQIk3nRVpWRSatJFrrbAOjjM62TeyV
 /QGh35Vqh4yeP5XjQqy8bcQSvUMcjb3lQfMbJd3rjVXo7D54S7T4leMjYVzFLf5sUbAO
 4iU4C5UHzEE6ZLq8/NiOWjngv+2T6NqBrCu00oEjKC6eHxm81OnEM5dlab2MyUjuHTKZ
 GdaVvojfUypXQS5FWPAfeOE4VT1lRrp/FAZdWsUfQbHbPK//LnPYMockCgtoRkXKvXKL
 E+6BBG/cJsa9CbLucCB5sgmhJeW7v6RD6wnMoFDJtnH0x6Vs7MNrTu9IRoKVaudGxkyK
 h9nw==
X-Gm-Message-State: AFuF++lvdCVGBdMmBtUftx/Nd0koI42f+udn4cXQRhvRoDoFj00ZYVJk
 k8h9eitI5yNKNRsY8V4HzkSSHBN5b2TzZjL/Ytkt3EPa5ZwyCs60ioefuzkVKIXBl7o=
X-Gm-Gg: AYBFou1FV8E3kihJNZ7ZRaW2K450KfS+7+ZqNLTqo/3d4yBW9EtFMSLUMlSSh7mWbBt
 c2oBbiJC5YOR5aFLJbEnddLeL2BRw/IrmeZgKIFo9fDihI+QJwl+irlv6xDdOZKw/NSTtod042Q
 uTHFxUd7Id+96F2xjS191ydRGguZFHvkZ5IRCW3bICveytjN/GB+z0EfuT+bUv3jOblqRPe9WRB
 83NPRo1wMTsRnFKS+T4Q4wn6+4ly4WK9jslaKCujPxrGipZHwyZq4jVeIIZ2OhIlcQafqiZdxok
 mFlzxd+ahaFD9pHpqvLSiMNgdaW19sZB33OxA/lz/vECBc0aJW/uTK/zfkGQkR7A5e8rinQ0dld
 rIl283kfWYCYUxrtRgcfRVuPquQMd7ubZYJvZQMAjEBYEnyAotZ1jqkRRxFftP2WCK1v/JGCyiS
 8DDt9uDg9Kx3uo0zS+WCmcu6Ua55rRCeZReCkkmK1E1+/5BTypNj9BLo68485y
X-Received: by 2002:a05:600c:138a:b0:49c:f13d:ffeb with SMTP id
 5b1f17b1804b1-49cf13e0642mr117722265e9.15.1788525970504; 
 Fri, 04 Sep 2026 05:46:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883c6ba4sm6883291f8f.25.2026.09.04.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EEA7B601D6;
 Fri, 04 Sep 2026 13:46:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 006/105] tests/tcg/meson.build: introduce exe_name
Date: Fri,  4 Sep 2026 13:44:20 +0100
Message-ID: <20260904124604.2207440-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-7-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 5758c7cc0b7..697b826a382 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.47.3


