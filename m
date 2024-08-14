Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3108C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 17:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seHXm-0000Pe-GO; Wed, 14 Aug 2024 13:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXg-0000BP-Qs
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seHXe-0006DL-CI
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 13:12:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201d6ac1426so646545ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723655529; x=1724260329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUn79WU14zqlH0c8ZH40FfQUSvZAWtp5MDwWi4t6xwQ=;
 b=JmphD9tMByaiGwa4V/M0iw0DqnZtFtQr1qGtn8E/v7q/7BFiGheQKVwirWqz82DW6H
 sFbl2ivpjGLLiiseWjDklVHJ9ofD+DpXtyK0TGNZXfJATtdugo7i+sqTajoNlJJ6QBGK
 HwBbZNoHdUzLc6DBdFWeq+FV6p6FiU4HDM08Zq4GL9jhvMRWhKRpgJqblazeb8oJi0w1
 k1jo6r9PqakI9qcYCfFkwiCcL/fr/ZemnaPZQONAO26kjYMJxSI1VYa85tcYc6/tqrKc
 JBLHoMu9e5tBWkhWLAgKMZFFBpRLhINBEVOmlOc9MxJrHfZ1yxRTH3iOvNmDwphGBn8M
 iHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723655529; x=1724260329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUn79WU14zqlH0c8ZH40FfQUSvZAWtp5MDwWi4t6xwQ=;
 b=Q6nQbZ5uGKJOM3JbRoWXCMRl1Tny+TH9rmxBHKElVNZB8aK1BBcuLfQsAOiXo+L6ZV
 bXB3Ggb4dEDf54EGiMQgVac05DNgW+nKHFbwtZ/IScP76qEmOSwjLn0dXF1tTNrdlNYd
 wzdeacxx8Eangj26anAn0YuEoXAfJYZL58ttDDjkzKltP4KGusRmLT7EMwNfWwK/FibF
 BTuW/YMdyM4rIvGY9UwoXjIFB/JVf/mWewlnZ4gwVSZJPRhzV3DDZW9Nnxt3heQ1KyDl
 uQTtko4K3fCNK/eB1kvE0mUSgGGolTfPwgVOFnRA1KYw6SQACKm6qXXpQsRH8v6DxH7r
 VtpQ==
X-Gm-Message-State: AOJu0YzaevXKnpmA8xWL+20ZPLzoEuoPE4KW2rS/ugXvfSjtmRpoVBV+
 U4kliRMh6FiYKFh+Ut3VC2fm0gZHy28qnJH482+E6LfM73Del0B0a5wwhiya4UGc7gbyB+randj
 YT0s=
X-Google-Smtp-Source: AGHT+IF+qUN2vveY66Ij/WyYMf+GIVFkloNhj3V93djFOJp9OQYrH4QfFyL2zD6FZH+F77yZjz45FQ==
X-Received: by 2002:a17:903:11c8:b0:1ff:49c:1562 with SMTP id
 d9443c01a7336-201d64d8afcmr37992915ad.56.1723655528927; 
 Wed, 14 Aug 2024 10:12:08 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1c8783sm31813895ad.245.2024.08.14.10.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 10:12:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 4/4] docs/devel: update tsan build documentation
Date: Wed, 14 Aug 2024 10:11:52 -0700
Message-Id: <20240814171152.575634-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
References: <20240814171152.575634-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Mention it's now possible to build with gcc, instead of clang, and
explain how to build a sanitized glib version.
---
 docs/devel/testing.rst | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index af73d3d64fb..f10cfc3f786 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -634,20 +634,38 @@ Building and Testing with TSan
 It is possible to build and test with TSan, with a few additional steps.
 These steps are normally done automatically in the docker.
 
-There is a one time patch needed in clang-9 or clang-10 at this time:
+TSan is supported for clang and gcc.
+One particularity of sanitizers is that all the code, including shared objects
+dependencies, should be built with it.
+In the case of TSan, any synchronization primitive from glib (GMutex for
+instance) will not be recognized, and will lead to false positives.
+
+To build a tsan version of glib:
 
 .. code::
 
-  sed -i 's/^const/static const/g' \
-      /usr/lib/llvm-10/lib/clang/10.0.0/include/sanitizer/tsan_interface.h
+   $ git clone --depth=1 --branch=2.81.0 https://github.com/GNOME/glib.git
+   $ cd glib
+   $ CFLAGS="-O2 -g -fsanitize=thread" meson build
+   $ ninja -C build
 
 To configure the build for TSan:
 
 .. code::
 
-  ../configure --enable-tsan --cc=clang-10 --cxx=clang++-10 \
+  ../configure --enable-tsan \
                --disable-werror --extra-cflags="-O0"
 
+When executing qemu, don't forget to point to tsan glib:
+
+.. code::
+
+   $ glib_dir=/path/to/glib
+   $ export LD_LIBRARY_PATH=$glib_dir/build/gio:$glib_dir/build/glib:$glib_dir/build/gmodule:$glib_dir/build/gobject:$glib_dir/build/gthread
+   # check correct version is used
+   $ ldd build/qemu-x86_64 | grep glib
+   $ qemu-system-x86_64 ...
+
 The runtime behavior of TSAN is controlled by the TSAN_OPTIONS environment
 variable.
 
-- 
2.39.2


