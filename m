Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D037EC61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJL-0006B5-3M; Fri, 04 Sep 2026 08:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJE-00067m-GA
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJA-0006p8-02
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so10110955e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525974; x=1789130774; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Bc/0OXJZ9G0Iq44/4dsbLI+wb7zd3BSOeEUd6MJIas4=;
 b=VZxRkidjNAc98iDI6x3cm4MGHiBe7c3IgPtKL8E/7LeoNUA0h+Wz3LNy0jC5hX9i+9
 O3wHNFZojIvn8bcKH1IZLvP3/75rdx5Hn7NJW5J5ZOcsS81RXQc4Ch1+a/6YS7K5F/4M
 wIFG8Q5NTJcNme1N7jpBH9QYrt0Kk/l7ih0iOChNCKkOSbryNcmTzJ5xF4oN46aHHVQi
 AI2j8Z3v1AKRkhI9BVUd2b8Hnj5U1o94gEii7ubLFWg3zKe81lqsFfDJRIkrw8p+cZpm
 gHpKoYzXASy5q9ZGETiXr51qz7icQS0obHruOww0xdqSGO90zybj4YbL8k2RrRIsLBPe
 gW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525974; x=1789130774;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bc/0OXJZ9G0Iq44/4dsbLI+wb7zd3BSOeEUd6MJIas4=;
 b=GZ2C3RqTrZFWZOJiTzxc54DUhA2AAWKqCzG5tg/wtBX3x/cwGSE/KdJF830I2pifVq
 gFYDR3235fRxEZLtuqI5zbt6vMMwIicpwCzkVWqYBUofmVafdp6e4iAQtW7THE7QINkW
 9+8176pukeuNxymZR9EHfAiQK2/rX62eNVEuqR9cOa7Cp2XHe+V4Bt696UfKcxwJH9nq
 BUdsQ62YvtrruaecbYc0ltqrRe8K8nRXe8dvQbRotqC24VNTQ6cNSRwROoAxRh5c/64P
 fWyEHBmclyY7/qazugowykk87fQwt98V08raC15C0SowLq4rOvQMd6KMVrWk84352uGG
 /Vtg==
X-Gm-Message-State: AFuF++lCpX2nF/8Ch57yrRCpoOLf4ppcmsz10N/FdQPgv0z0mfPOCdSs
 RtWpAcPpTcT4Z87gou5VDbGSWVdah6MuM7tAg43ORIX+5M76rKo1aY1qWw1qq6ZFIol9ciETk0U
 QhbKUG/c=
X-Gm-Gg: AYBFou0B3A84k7f6az+xVKjQ9UczsFEFPR/whDYt/riI1BEzo2oGCMJwBH1Lo6uGeOi
 wTtCgcpwI2yzhDDJp4nQgvk2gjXiSlUp2VxpYJoMpEBoiz6j2smEJRf+mNkx5/l63k1iXaIy5Ol
 b1CXeVLxbFO+Dbsede3wiZVv8O8dxJlMkdRcqqx+QQruqhCKymtDS2/2djt2aPtNWTLRp/ofUsz
 W9Jeu8K6/uBx8+YvgyK22dIjXYDZAR0g3Q4VE86K1AQjih7lSLD/KH+ou+7Ofk7NkUeMrEP+fJv
 wIOEH25c9WFCStmdP5vreAimK6mfCBS5fF27X71z7akmk7EL191rgqwSA4g/sJLgNkp4r2LP5JX
 IBZ9VHluEn4jryAGZX3EogU8m1v9NSJ4Bb2JXN1x2UsIx0vQkH4kNih4b+NBi15ATviLBt5WK1v
 1AyPopE405S1so8wLtbMy22+DUCPTsg1b0d0F8YSFEh22pwfyoDa2aBwhW6j3+13eOswkFnME=
X-Received: by 2002:a05:600c:3e1a:b0:49c:fc6c:bdff with SMTP id
 5b1f17b1804b1-49cfc6cc078mr33297225e9.22.1788525974195; 
 Fri, 04 Sep 2026 05:46:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7739b7asm64194205e9.13.2026.09.04.05.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6F3A8613B5;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PULL 011/105] tests/tcg/plugins: build list of test_plugins
Date: Fri,  4 Sep 2026 13:44:25 +0100
Message-ID: <20260904124604.2207440-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904124604.2207440-1-alex.bennee@linaro.org>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-12-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fbee86e6b4b..9940bae80a4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


