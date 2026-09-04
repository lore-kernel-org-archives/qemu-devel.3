Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E563CC624DE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TJK-0006Ai-8W; Fri, 04 Sep 2026 08:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJB-00067Z-7e
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:20 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x2TJ9-0006ok-8R
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:46:16 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso8047555e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788525973; x=1789130773; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uvZ1jTXR0wR7UEV2V2bz8d2L3SPLjIhoXhqkU7B3Bog=;
 b=MWIQSuXQF8k/3dFwG4EN80h8EQdU/ojRz5AVvMOfH6dY87Z8l+qtY+3kxw7Zs2uZPP
 Ue/pCH0/JqtGulJ4BnwO5/Wt6JC0hFY44YeLjUsig/vhbzkzcw6r5yzsQirnGG7B6OUq
 IJzS1qaRZOKlM96SofUVcxpD15zx4oQ/JC+p0NayItpAmLLHyJyMukITPc4BV6qWmBwA
 ywUAPYPxXes5ifm41alwSrkgNqw6tuh+O53tyqmR7wWU/GQS/6mnIA/paY29x4BygH2N
 INe9KRlJ5BkVZVXWuvjPY511KdjN9xU86yys2eFfKYEqwavhTawALNtoS0zAXyOwt4ub
 pplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788525973; x=1789130773;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uvZ1jTXR0wR7UEV2V2bz8d2L3SPLjIhoXhqkU7B3Bog=;
 b=fVvHtzOIGmSk0iQWXvfo6TgoFuKXN90JUtsbQV+oiE3KTR/PoMNNTSNReUZHwGXlOW
 fHF/hiGl21Xx0ix9OR8QIDZqj2+K1Ze16MSoyTcPuhTTUtr62MNpnEE4qdkz8AEpdldJ
 u8RaX5IM75PHzjK61wFPaBODV7d1fBpJXaIVHKJf73hufAdtGEGfHM7xVd5zbwI45OaR
 KsGhC39K+b0vh6Ypg7ZSOwmRKiMO7nb3bkAH8fZK7+s1vvEBcXSWGSvEFoUwyLbkL3T7
 qklyF823K7zFPYRg1s4CG0XXkKvDZu3eZOs5iV3vTc3peSAKsJV0SCgNvOkvywBxOLHf
 IQrA==
X-Gm-Message-State: AFuF++lBtxqI//HvYPxXuCoq3as86fqUQB1pJ72Lr3bAaB2wxriDX6zy
 8QtT7QybnBF5H1d/zE9e0iDpDHMWm+Pjn48CH/MlX/oWCjVzzOVaOmCqBBvrtnExwkM=
X-Gm-Gg: AYBFou06k8r8+R3PqBFT0QIkPcoQ1xwA7ALizOthG0UAhAMMCMrzfdYIw91A33BcCPE
 vXti1RF8X0L7YPIAqKxYhhouxD36KHeMezHPdsW8dEsWWwJNDe4c+Z2cFUGFRBD/XZP4oRUFJuy
 lZECSO/+H2sYyWhQhIfHEKps5YUda8JWgCkbJlFb+MYyN4gkIjJTJ5L31GZuBX5NK1ZKFcMY15q
 n9mlpKeP1gihCk+Ktp1NwP4KxG1xC6eaoKvypIjXuXiE6MzFy74QZphCQKMZmoOmKzRWYx2rO0+
 L0OK72XV3wwN7y/hw3muMZVZ+mqIX3IEH4qvyijUWEO4w2lxnacBljpwJK74jGOxUqFbig0OGQD
 8Z3SXhei0Cub+mOAefReni0ru8WD+d5K8OgbzS0npsMHMzKUZ/Hl3tPEvAF7x4wNs68n1YPrCs0
 df1lcARhWygBn7Um5ulF/X1tmPJAEGR21m/+7ifZRB89QuWWGeRATJaefcum+R
X-Received: by 2002:a05:600c:3b0e:b0:49c:eb04:1c49 with SMTP id
 5b1f17b1804b1-49cf8254d53mr53446845e9.13.1788525972882; 
 Fri, 04 Sep 2026 05:46:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f815bsm21881695e9.4.2026.09.04.05.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:46:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 26CA161377;
 Fri, 04 Sep 2026 13:46:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 008/105] tests/tcg/meson.build: introduce cflags
Date: Fri,  4 Sep 2026 13:44:22 +0100
Message-ID: <20260904124604.2207440-9-alex.bennee@linaro.org>
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

We add possibility to declare cflags for a given test. Since we want to
preserve the uniqueness of test binaries, we prevent repeating those
cflags later, for an existing binary.

This ensures one executable == one set of cflags, and if dev needs
duplication, they can use a custom 'exe_name' to override this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260827221506.91574-9-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ae7ec998f63..e8d8cfbcf88 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -13,6 +13,7 @@ tcg_tests = {}
 #         'src_file': {
 #           'exe_name': ['provide an alternative binary name'],
 #           'test_name': ['provide an alternative test name'],
+#           'cflags': ['additional cflags to compile test', ...],
 #         }
 #       },
 #       ...
@@ -20,7 +21,8 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, identified by 'exe_name' is built only once.
+# Every test executable, identified by 'exe_name' is built only once, and we
+# ensure cflags are specified only once, on first declaration.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also. Several tests for the same executable can
 # declared using 'test_name'.
@@ -54,7 +56,7 @@ foreach target, plan: tcg_tests
     foreach src, setup: t
       # return a clear error if user misspell a setup entry
       foreach key, _ : setup
-        allowed = ['exe_name', 'test_name']
+        allowed = ['exe_name', 'cflags', 'test_name']
         if key not in allowed
           error('unknown tcg setup entry \'' + key + '\' for test ' + src +
                 ' (possible: [' + ', '.join(allowed) + '])')
@@ -82,6 +84,15 @@ foreach target, plan: tcg_tests
               'specify a different \'test_name\'')
       endif
 
+      cflags = []
+      if 'cflags' in setup
+        if exe_name in built_tests
+          error('test ' + exe_name + ' was already built with cflags: ' +
+                'remove cflags or set \'exe_name\' (if cflags are different)')
+        endif
+        cflags = setup['cflags']
+      endif
+
       # build executable if needed
       if exe_name not in built_tests
         exe = custom_target(exe_name,
@@ -91,7 +102,7 @@ foreach target, plan: tcg_tests
                                       '-MMD', '-MF', '@DEPFILE@',
                                       '-Wall', '-Werror',
                                       '-O0', '-g', '-fno-strict-aliasing',
-                                      ],
+                                      cflags],
                             depfile: exe_name + '.d',
                             output: exe_name + '.test',
                             build_by_default: false)
-- 
2.47.3


