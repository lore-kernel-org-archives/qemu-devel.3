Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C394CDDE69
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 09:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3ua3-0001Ek-Uc; Thu, 24 Oct 2024 05:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZi-00017s-CI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:15 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3uZf-0003my-QT
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:56:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c941623a5aso3166406a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 02:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729763770; x=1730368570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuPv/uXk8QTOtd5rNfjJz9xPAaD3KPuwf7iO+KnrLkg=;
 b=wfQEW69eG+mQvNAazfIKrfp29Z6eUgqpHNt+Ja5vKBJPl636fk4UTNrEypeckAeQb7
 ZuGv39nm3voKUjXqA3MbLZ/KvZs5EW9//QU7gd2p3kjh2t/eFSCrcjQWVP/adH/4iey9
 1DTGm4FhxmsShQnQ6ZcuwGLNqMej40hqUtDO3MKDkXs6gNFxpMFfurYEPZBEbm2Pi7A3
 sUtEdwEw7Orm3shDURbhcETffCwHbwptakofW/+3e83i56H7oiCaCdJIFJ7qWi5kxC6m
 TS1XfDltaEPt/ClQiD93XOx4veSwTuVBmg7DxDS0/ph2Ciau7EvTzFu4gHUshGzBsN4v
 uyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729763770; x=1730368570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuPv/uXk8QTOtd5rNfjJz9xPAaD3KPuwf7iO+KnrLkg=;
 b=kg++Ilvfwt6tIYUimirsWXA5MFrJCKlWQPeXCHWXkgpEv9RXglECSMkW5DwqW0Ivo/
 5AdTMyug4sDYFe7ZhdamF92UAeFyafFl9eVI+xGfHkC+0ETJ+C/Se1e7NI8+vjVfly2i
 Cl7O5dc+IOB8CAsfcsSaBKfTWh1W5zDBd3p6GxDYZo+mnhOHOXMbyjr83m5b+f2kBkLL
 Xchu5okQbF2jQx5RadhWiodX4J6Z7vIzPpYO3SMaCIvLgEAQk6lDC6WwnFE26aMzipZA
 na58Z4OoVXKtGIqEQuITNLm2VLRPvgxZiPGxF6cHex+wR9v3mb+dK8l44ETg/Jbipi3f
 G6fA==
X-Gm-Message-State: AOJu0Ywsga7z/ro3qmQJviUL+urJRit0t8/tenIiOIwJSf56N/hB1qhc
 LKTUqGK2cg3Bjynrl+DhHFEi1E89/OrC6iasNSYdzh78h43oCoFkcRpFhJ8IVYU=
X-Google-Smtp-Source: AGHT+IGb+p8drTF+pi2SEgMn3a70w61fJDUo5Lty2W+rJpJ+ghEy9r0nwLvRtHhXrEVJlUdKE5VDNw==
X-Received: by 2002:a05:6402:2486:b0:5c9:7f41:eb1b with SMTP id
 4fb4d7f45d1cf-5cba2110569mr1905298a12.17.1729763770192; 
 Thu, 24 Oct 2024 02:56:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66c725dfsm5478729a12.81.2024.10.24.02.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 02:56:07 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 748805F913;
 Thu, 24 Oct 2024 10:56:04 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 05/17] docs/devel: update tsan build documentation
Date: Thu, 24 Oct 2024 10:55:51 +0100
Message-Id: <20241024095603.1813285-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241024095603.1813285-1-alex.bennee@linaro.org>
References: <20241024095603.1813285-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Mention it's now possible to build with gcc, instead of clang, and
explain how to build a sanitized glib version.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240910174013.1433331-4-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241023113406.1284676-6-alex.bennee@linaro.org>

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 09725e8ea9..91f4dc61fb 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -628,20 +628,38 @@ Building and Testing with TSan
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
2.39.5


