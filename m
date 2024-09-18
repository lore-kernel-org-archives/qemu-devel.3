Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78D8CDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tS-0004vC-0Y; Wed, 18 Sep 2024 17:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tP-0004oy-Kg
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:19 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tM-0001ZT-Iw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:19 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c43003a667so195811a12.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693634; x=1727298434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8PYdaTTNho7oFbmy/119cv/0Q+vgu2VyKL3FrL1OWo=;
 b=DAs5e9+LSK4IzqwVqOfWl3Co0XFAyFBlvztIlKmzpg3GOFwFUkHXNI9deOmtdrwlwn
 +xWxoO51PMB73cPQt6V2+zGv15kU4BjNp9Li8t+ofT7QGmEI4NBiPDXhYSXUxF+2nfhE
 OLEwQwmuhy3zU7NwnhPDKPpEIyPkkhBJCjR2DxRoL+kDQih5Su2fj82NOwVHA8RiZaRg
 CR3pN9QWJpNDcEW42mRZvRmoD5rw8Anr5lQCin6WDLgwkxJ+0sf9smR1CmosPzPRzrjg
 2rKfismxW8kWauHFmGOx4zDSDa4UZ8ejfqHXaiyjVdY7HBK8p2nQyL/I7y5aoz7WM2JC
 A/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693634; x=1727298434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8PYdaTTNho7oFbmy/119cv/0Q+vgu2VyKL3FrL1OWo=;
 b=OYqIidfF59hMFNGOEgaZ++gsOZDXXrYhoDF9/fp7AJ4fY750J3Z2H0qsZ0Ez0LJRsV
 lP109UUvLKRcGfx8uGVA0feAvd88U3IXDAP9Qc8KPMDX85jl7GJCYxGwYsUrNbL8g4tY
 fw6ZKDx5WNtVMwuqFSFv8vvRQn4AxMMUPpEzf3OnA9M6x3UGt/4ANByAy8KNq/Ui84Yq
 YeeaBgXfGXpY1nTp5Tx/zVvojC5rG1bi+vatL0cajW7vPMqjup/HioYn178VGwIEbW4u
 ANMn2XiBORuK2oaWt0h1cT6tHhuxGcekOt0eRgnG3CLA+YCdV3XUQTbTGu9Tulghrg4n
 LyhQ==
X-Gm-Message-State: AOJu0Yw39dISa/nmHjSzHWjfjY02dacN3zY6xmo8xI+38AqsNA3L0SuY
 nUIH8uablRExo2ETuUo1o6zXfWeJYY+KdxraI0Urr6ddrIKnDphEzx1zAGtYz7Y=
X-Google-Smtp-Source: AGHT+IHTdZsIWdnnS4bkrBdNFJUXjNP2PC7ITAztPPydpFpWb8uQlRw5M68rNLCWswq9yB4RH3G78Q==
X-Received: by 2002:a17:907:3d91:b0:a86:8ff8:1dd8 with SMTP id
 a640c23a62f3a-a9048044a21mr2014339166b.46.1726693633817; 
 Wed, 18 Sep 2024 14:07:13 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a908d2305e3sm397557866b.186.2024.09.18.14.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C6845F8C8;
 Wed, 18 Sep 2024 22:07:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org (reviewer:Incompatible changes)
Subject: [PULL 02/18] deprecation: don't enable TCG plugins by default with TCI
Date: Wed, 18 Sep 2024 22:06:56 +0100
Message-Id: <20240918210712.2336854-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

The softmmu memory instrumentation test sees so many more accesses
than a normal translated host and its really not worth fixing up. Lets
deprecate this odd configuration and save on the CI cycles.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-3-alex.bennee@linaro.org>

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 809b2b9b81..c0aa52def5 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -196,6 +196,14 @@ benefits from having plenty of host memory it seems reasonable to
 encourage users to use 64 bit builds of QEMU for analysis work
 whatever targets they are instrumenting.
 
+TCG Plugin support not enabled by default with TCI (since 9.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+While the TCG interpreter can interpret the TCG ops used by plugins it
+is going to be so much slower it wouldn't make sense for any serious
+instrumentation. Due to implementation differences there will also be
+anomalies in things like memory instrumentation.
+
 System emulator CPUs
 --------------------
 
diff --git a/configure b/configure
index cc8e1ed5b8..aa7aae70fa 100755
--- a/configure
+++ b/configure
@@ -629,6 +629,9 @@ meson_option_parse() {
     exit 1
   fi
 }
+has_meson_option() {
+    test "${meson_options#*"$1"}" != "$meson_options"
+}
 
 meson_add_machine_file() {
   if test "$cross_compile" = "yes"; then
@@ -1048,8 +1051,12 @@ if test "$static" = "yes" ; then
   plugins="no"
 fi
 if test "$plugins" != "no" && test $host_bits -eq 64; then
-  plugins=yes
-  subdirs="$subdirs contrib/plugins"
+    if has_meson_option "-Dtcg_interpreter=true"; then
+        plugins="no"
+    else
+        plugins=yes
+        subdirs="$subdirs contrib/plugins"
+    fi
 fi
 
 cat > $TMPC << EOF
-- 
2.39.5


