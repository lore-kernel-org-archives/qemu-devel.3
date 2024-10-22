Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF8AD1CDD5
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 10:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3CZX-0001x8-H2; Tue, 22 Oct 2024 06:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYy-0001oN-6I
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:32 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3CYw-00023U-2N
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 06:56:31 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c96936065dso5865766a12.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729594588; x=1730199388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZZo1oPZPqzjBeoixQ7wpptFRyTvJhgIff9wczeHXgQ=;
 b=Z2AcBfUK05G7uwVw0Ce5CGgywzYhxEZWHLZ8EXh3cTbgSQE8DgBj1lr6JiPSh6iAuL
 W2hYP/JCZtbrnZUy3zijpWDrpdP+Ni91hwBFFnSNUQZnEX26EUbkFSy2Av1LEKsxh6q2
 cSwlzvoZi73sKy5OYva+l+xvcMsZTut9oHzDZNz3Rq4RTCN2+j2/GxRz2/VJ66/m3hPp
 JsSH8XY9PBfXhdLwFQpGrxAGERlEd8BSTXvSOmhqFm8kay/jaQGmvIafww+k9Dwq7HnX
 ePg4Jcp+U6kpPJqwFsBZZXIM0D2rHuQyZ9f7zjBWz9vs17KRtXsZJE4ZnD4ELT63itJ4
 ZXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729594588; x=1730199388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZZo1oPZPqzjBeoixQ7wpptFRyTvJhgIff9wczeHXgQ=;
 b=dsDYJGK7uzHgRBnnVXRmy45AOV2MY5WJZqK1a4M2C7HT9E6OBn7o3zdsJJ2caKGndE
 erleX20AJEuwJisVpwOqWrPzsFtsIc3GYG3QLa5Xhwb5UGuJyG4ITSogO2DmE0IIazGz
 i2l6TjFocTuuIMvuSxangrHoEfvUmJaChrWmPu7zNwa9DFVMDHgK3kQEOA71cUYslf4O
 wNKzZZH9duId/M4uvlpyatzD+ANhgJ7px3bbL3WFD+1a6uK0vZ4w6/JaZ5ry6ehX4LXz
 RjaWPptiHD/YMcN0WfiuwyQNRI++tg5/hu4wSbblb7GZ3akuwrPqyImKY0GZBDbP/MJ9
 pgAA==
X-Gm-Message-State: AOJu0YwYxXXVBMKbIQTbsma63vn/8QDho86b3ZDt05PKWFB9idPRi3KR
 lbJFBD8fl6v2PYngYZVII4e9hIQlXXUEOT8UKRIEVyxR1eHOoTaSzX0DFAXqTh4=
X-Google-Smtp-Source: AGHT+IFRsXwXWWZ+1iUXj/NDdR1zmIgl8xhujNIEkYhFmxY8XSoNScTyD+Rf8wUGR1kAm8G1SujWGA==
X-Received: by 2002:a05:6402:3514:b0:5cb:7594:9ece with SMTP id
 4fb4d7f45d1cf-5cb782e16e2mr2678552a12.17.1729594588142; 
 Tue, 22 Oct 2024 03:56:28 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a657bcsm3124198a12.23.2024.10.22.03.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 03:56:19 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1AA775F925;
 Tue, 22 Oct 2024 11:56:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, devel@lists.libvirt.org,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 05/20] docs/devel: update tsan build documentation
Date: Tue, 22 Oct 2024 11:55:59 +0100
Message-Id: <20241022105614.839199-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241022105614.839199-1-alex.bennee@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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
---
 docs/devel/testing/main.rst | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

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


