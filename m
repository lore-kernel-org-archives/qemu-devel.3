Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809F0CDDE6E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 11:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Zd8-0007Gl-J0; Wed, 23 Oct 2024 07:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd6-0007FK-3g
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:20 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t3Zd2-00036f-DL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 07:34:19 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c99be0a4bbso8927524a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729683253; x=1730288053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZZo1oPZPqzjBeoixQ7wpptFRyTvJhgIff9wczeHXgQ=;
 b=yhM5LlpbxVrKpaZ7j0kBjMf/AA4sCMkxvuFc3nDTuxMZNNBz1K3mAr1iI7YW6XEyKv
 2DkM+GyvCsARQPQJtf8Mjm8lD7gDsOrKOPPDgT5OrKeeBcylh+ZHgb/tror04VOHOCIp
 1gbliV4jQ7xvpyjVmXl9m/W7XN3b69HJthivczcGr7e55w2VvAb6Uck3WN+JaZ2HWnOK
 pAnhh49/feiFSInIlk80Pvpq2u6wJ7MeIbqdejpxQm6mGeQRX6askXWmkmVrIL7rrdq9
 VZaccBQ0MvFkyjZBR1i7f8z6Ad1GIqu9pcTn0AdxT8i/oqcZVZqDr3NG/WvYjdOTv3zS
 N46Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729683253; x=1730288053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZZo1oPZPqzjBeoixQ7wpptFRyTvJhgIff9wczeHXgQ=;
 b=hkkHbWOOB+wg4BSGxwqyRNN2E7B1wcBDkmfc4AIhmj1OI3Y+mkNq/SaV+dxLgb6CRY
 ZrP/YsXF52G8KY1tBTybYtm93qBMNAtVHoyov5AriV8S6NMXA+6hHXVMkVKctiCAqfxr
 jA3vZXGjAlndShspSxkVdK1A6qu+aZY9BB4Y/lO5QSeOJvvjbgGhPTudidkhQq3EmOm/
 5t9maTL+4HPA6EgudmSQHeElhU+yryROWxUJa8NN5fGN9EZOy4Wa7Ew5VQoxDI6wL2CA
 dQK0eSDHoDPBwTIS8s4LE2lT/hkrPX5DuZMBgJQ5imriUdYqCGH4mpcfIZHeiLIDkM7p
 Y1Vw==
X-Gm-Message-State: AOJu0YxuBZaE3mVMdGhQONwyN1kkQSNBDut617yNxsPa/DNtboGSaMVE
 lJGsY6uv+f+JYn0a+YwZk0Z+Yd5cq6VzPPS9IGRcvNnZxe0C0CXRVPRJbae/jUg=
X-Google-Smtp-Source: AGHT+IFA0UaPGC8xcZ4LXhrZOMA5j/aP5IXRqvhXDz6QfMISSlPCIVK4HHHGWxBkVlt2kvmppngmEw==
X-Received: by 2002:a05:6402:1955:b0:5cb:6718:7326 with SMTP id
 4fb4d7f45d1cf-5cb8ad0734cmr1936187a12.21.1729683253220; 
 Wed, 23 Oct 2024 04:34:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cb66a654b9sm4351143a12.34.2024.10.23.04.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 04:34:10 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C4CE5F913;
 Wed, 23 Oct 2024 12:34:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Marcelo Tosatti <mtosatti@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 05/18] docs/devel: update tsan build documentation
Date: Wed, 23 Oct 2024 12:33:53 +0100
Message-Id: <20241023113406.1284676-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023113406.1284676-1-alex.bennee@linaro.org>
References: <20241023113406.1284676-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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


