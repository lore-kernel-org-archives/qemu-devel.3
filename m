Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861A8C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rbE-0002RM-9K; Wed, 16 Sep 2026 11:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rao-0002CX-8j
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6raj-0001R1-Fn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:30:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-495437bb891so15207065e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572629; x=1790177429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5VZ9WHBeOITZkYlGYis/Zw/ne4HgXN9leet0uUIp4tI=;
 b=hWQxGPpk0FmhdLTdAJ18uGd6lCs3JYCe+/0k3Oq7pu423VUCwFRnqJdjUSTMIbbAhd
 oMiEkYNepc9h70jqtnNxif5ExRX5woyApoZCCSXGJXX0bB7Yn/HsOrSWQRgmwpKFbAWE
 j9N8PeBLJYr+NdZFGbkqFGTI9qkm79l9wfV631zTE8DCNC8qSCfEpfEWrsssfNlB+oEa
 kwmOEWwTySGRBqMnSZktYU/ZXs3T9TvQ4v5rap/6e1/G9dyIV2n6l8NhyduqI28ijFNi
 qQxAl0rCCMw2hAziZuBM+UGYDVhtOmloHClb9/Jps1PQpUFI3fp64kezpedJP5RHQJ4A
 bS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572629; x=1790177429;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5VZ9WHBeOITZkYlGYis/Zw/ne4HgXN9leet0uUIp4tI=;
 b=PT+PeWCBaBxk4HSUWxpceLF60grok1l3Ovgm6a2yFafRtkwJ1Rgm/2UUqnMxQkAHM8
 QBmm7ZHjnH6L3yxVE6aPckjwpksVrEc8KTtH4gk3NHZqK9TTk6A6AxVjlaiVs7JFKpmy
 fsl8Ho9ciof0+bK5kli+7FDwGPFPdSHlTpqu02gMPYCfdYMYvk3X+0o/rej6XZM8w1gk
 40d8DpcIX6mH4/dlW11nPDh+EE388BInjFVeo0PKOC3kgAFal7negix9F3QzuCZLA5hj
 GTLz0N14MVf/IFr+Ip/NBAuEkVqLy4rwHeErGxM6V0qAxH6u6wTbEvLitRifj8eUrx1F
 nnPA==
X-Gm-Message-State: AFuF++k4P3aFjTDzAgdFzWSZbSx3mVk2Z4I1IJy7JZYXN6cHCWPjucul
 8npD/vyLFsW8cyNsppReJ2jXrJ2VGCW0Sl5l1SxhOmsrkR6wR1f/A6aeVt26z6rgeP8=
X-Gm-Gg: AYBFou2/LbRMDBlNPzBWN568MKHuGaDuzfht6YtYntKz+4aZXLP7RXuUAWs8cefbz9U
 yTZKIVEAkAxywB1ONHW8bDYaTxkfPZBMprdOj+CXYgcyVv4rDg/JJMgEDvG+XjpGBgiprMgZT60
 WYG9f3ByP7vI9qdAVkMxDhg00YOrN8mjNdO0nLJHoEnEe1PL/24ST7V8KWG3MIOkvOr14MoVo1G
 fGlKE6r+OoT3tdFNNUuP0iQ8aHkfRh5ajKMzzZYVFn92yDZusRoD5JNCTMVTrwzsw3mnChAJ4rI
 QM6SPFrXQWePfGs+KLdBdnVvanv1LbhD/ySQBhNiOubrczbzA12O5RpqvWilD9X6+Q9CMactXTU
 GbapTD/PgGebo9CLuqo9ulzK5mokDviYQo2eVa8chyScdmsTGFyS5uiJ6XzSwqEywVAnGBdAbgR
 mp2/l9wsLo4YvTUASLKvDUuO/EHYhfgaU7BjwQl5/L+BTFNfthEbOHtpVcTOE00RW3IcZulzw=
X-Received: by 2002:a05:600c:e555:20b0:49d:27ee:79c9 with SMTP id
 5b1f17b1804b1-49fbd1c4afamr22145e9.8.1789572629187; 
 Wed, 16 Sep 2026 08:30:29 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm7898928f8f.29.2026.09.16.08.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:30:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DFFE61971;
 Wed, 16 Sep 2026 16:30:14 +0100 (BST)
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
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 09/19] tests/tcg: don't define tests when missing compilers
Date: Wed, 16 Sep 2026 16:30:02 +0100
Message-ID: <20260916153013.2134555-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916153013.2134555-1-alex.bennee@linaro.org>
References: <20260916153013.2134555-1-alex.bennee@linaro.org>
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

Skip defining the tests for an architecture if we can't build them.
Otherwise we add a bunch of noise to the reported results. We still do
report when we skip because the compiler doesn't have the features we
need to build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/meson.build | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d317f0ee310..904a5a02242 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -264,8 +264,11 @@ foreach target, plan: tcg_tests
     if not cc_from_system
       summary_cc += ' (from \'qemu/' + plan['cc_dockerfile'] + '\' container)'
     endif
+    tcg_tests_summary += {'cc for ' + target: summary_cc}
+  else
+    # no compiler, skip this target
+    continue
   endif
-  tcg_tests_summary += {'cc for ' + target: summary_cc}
 
   folder = plan['folder']
   gdb_arch = plan['gdb_arch']
@@ -373,6 +376,9 @@ foreach target, plan: tcg_tests
           cc_has_feat += {cc_feat: avail}
         endif
 
+        # While we skip defining tests for whole architectures if we
+        # don't have the compiler we do skip individual tests where
+        # the compiler is missing a feature.
         if not cc_has_feat[cc_feat]
           skip_test = 'compiler feature ' + cc_feat + ' not supported'
           built_tests += {exe_name: exe_name}
@@ -380,10 +386,8 @@ foreach target, plan: tcg_tests
         cflags += cc_feat_cflags[cc_feat]
       endif
 
-      if not has_cc
-        skip_test = 'compiler ' + plan['cc'] + ' not available'
-        built_tests += {exe_name: exe_name}
-      endif
+      # We should either have a compiler or have skipped the whole target
+      assert(has_cc)
 
       exe_depends = build_test_depends
       if 'depends' in setup
-- 
2.47.3


