Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209EACDD556
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 21:08:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr1tS-0004wM-A4; Wed, 18 Sep 2024 17:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tP-0004pF-Q8
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:19 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sr1tN-0001Zx-NE
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 17:07:19 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c2561e8041so178886a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726693636; x=1727298436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3/HyHbGcSckOdKLF1EYAUB114Xir6Orehr4YuOmz0iw=;
 b=beX/YI1uRf2Fq3xL4Hx3JAsIWDpcrwotDFB3I7zOIllamMB2KL5tk6BWMGTLcwn2A/
 3FBO7Hl4vmopvhhABsFP7VeeMgydZ+KSOOZd4kvSxtT9Gm+07l29ErHILZfipncyeIxa
 etmBnE4x3OYWi5UOYOyoAvxr4etTMugbkCXToi3hok/YP8lWyq7ya09uQi6MZ5TLYjhj
 sT53exyy4DMheuYmzJewDUIDbSF1uhmAUypjblfdjl+N7sdCAJ+Ifvzi8YYEmLVsYFyD
 +3+qeAvP3llTvYrG7LYpwGr25ile9yiXyI7oWvg1XFitao8yxufL1UMm9QYWR1AqhqqN
 3BOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726693636; x=1727298436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3/HyHbGcSckOdKLF1EYAUB114Xir6Orehr4YuOmz0iw=;
 b=LmXQfiQZdwSMYGKvgYmrN07JBsB3qImbzMBELcQvwVwvnA4shJecevtdFqARP25yrw
 nY7u4aLufXhqQrbfp9IpgJH89g/droszpigm42kRrYJVGhBaaO0r+oh5lph7WDnCOK1Y
 HZ3ETTdsy1GIPpAPzf0Vqgyx1BhJ5P/JoX78FtMiVRlPkkwm8VSAOE8JSfDbfmVIfibj
 Jt2ctytPREew0uFMAQotVEfrRGO0JKbiDutglqFLqBlr668AIOAUFqxnwiVj6S0CpHnl
 zDbzZpEUNR605zc/XzdMJEAsCwTW9FAsCG6d68ykW30TuHOyVCIBte8ZSRHhm5o1GLBZ
 1GEg==
X-Gm-Message-State: AOJu0YzLDXDyzNlgxWsLTEwX5bgCZP8LJIKf7/KRoQhozPLMVXs0gCV/
 Z/bIzIZVqR6tQh0WSc3qf8PiILAWjsNmv5RikyqufsyJ2hY5kQZUPQwXT61rMaM=
X-Google-Smtp-Source: AGHT+IHV58QftuvwXXi76HH8XPGKkDy1FaR5lmC5k3xJm23VXa7bFtHvHqFj0VNXwS2rCu/Nz9RQTw==
X-Received: by 2002:a05:6402:3551:b0:5c4:1c74:56f2 with SMTP id
 4fb4d7f45d1cf-5c41e1904edmr14275902a12.15.1726693635673; 
 Wed, 18 Sep 2024 14:07:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb89e07sm5328729a12.76.2024.09.18.14.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 14:07:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 536405F8A7;
 Wed, 18 Sep 2024 22:07:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org (reviewer:Incompatible changes)
Subject: [PULL 01/18] deprecation: don't enable TCG plugins by default on 32
 bit hosts
Date: Wed, 18 Sep 2024 22:06:55 +0100
Message-Id: <20240918210712.2336854-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918210712.2336854-1-alex.bennee@linaro.org>
References: <20240918210712.2336854-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

The existing plugins already liberally use host pointer stuffing for
passing user data which will fail when doing 64 bit guests on 32 bit
hosts. We should discourage this by officially deprecating support and
adding another nail to the 32 bit host coffin.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240916085400.1046925-2-alex.bennee@linaro.org>

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ed31d4b0b2..809b2b9b81 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -184,6 +184,17 @@ be an effective use of its limited resources, and thus intends to discontinue
 it. Since all recent x86 hardware from the past >10 years is capable of the
 64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
 
+TCG Plugin support not enabled by default on 32-bit hosts (since 9.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+While it is still possible to enable TCG plugin support for 32-bit
+hosts there are a number of potential pitfalls when instrumenting
+64-bit guests. The plugin APIs typically pass most addresses as
+uint64_t but practices like encoding that address in a host pointer
+for passing as user-data will lose data. As most software analysis
+benefits from having plenty of host memory it seems reasonable to
+encourage users to use 64 bit builds of QEMU for analysis work
+whatever targets they are instrumenting.
 
 System emulator CPUs
 --------------------
diff --git a/configure b/configure
index f3e7572afb..cc8e1ed5b8 100755
--- a/configure
+++ b/configure
@@ -516,6 +516,25 @@ case "$cpu" in
     ;;
 esac
 
+# Now we have our CPU_CFLAGS we can check if we are targeting a 32 or
+# 64 bit host.
+
+check_64bit_host() {
+cat > $TMPC <<EOF
+#if __SIZEOF_POINTER__ != 8
+#error not 64 bit system
+#endif
+int main(void) { return 0; }
+EOF
+  compile_object "$1"
+}
+
+if check_64bit_host "$CPU_CFLAGS"; then
+    host_bits=64
+else
+    host_bits=32
+fi
+
 if test -n "$host_arch" && {
     ! test -d "$source_path/linux-user/include/host/$host_arch" ||
     ! test -d "$source_path/common-user/host/$host_arch"; }; then
@@ -1028,7 +1047,7 @@ if test "$static" = "yes" ; then
   fi
   plugins="no"
 fi
-if test "$plugins" != "no"; then
+if test "$plugins" != "no" && test $host_bits -eq 64; then
   plugins=yes
   subdirs="$subdirs contrib/plugins"
 fi
-- 
2.39.5


