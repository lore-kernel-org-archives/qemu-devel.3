Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F6DD1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibP-00051a-VX; Thu, 08 Jan 2026 00:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibP-00050l-6p
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:31 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibN-0005HF-Ek
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:30 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7b9387df58cso3136485b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850228; x=1768455028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYS91EBDsQ/sdLMv8/i4RIFQxRMypQMw9CTeUZvycUY=;
 b=Kcrde59eoh7Anv9eDJ9U/+hmeJXUGePUsAs6DLjYJ7YSYY25Y6Tufbi53xygXPM5w6
 dh+v8r3rAF5DGx8THZNYYK7m273bwotkA5UJWbNwZar2KgrpF5a1329//WHpp45BP5pX
 ZiDlm7i1Gj41xZjjWRJaGg+UuZabpotFobxgY7QA1sbgOh+DBk7MnlEna4q9KqiY9Ybr
 gtDL7bfhlimA6hfg9mQkqv52c7sKOoII/GozSc9z6Fe23DqirEFTytd1ZORzy4eoR0VH
 xSLRYj3Ug70Rf1gJJrbgDt/0j7Z87SQhWwal4X7z0PdJkmr9UYrt2XtvCqyJUGFnBI6q
 PF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850228; x=1768455028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZYS91EBDsQ/sdLMv8/i4RIFQxRMypQMw9CTeUZvycUY=;
 b=kty60QbqWTxTEU26D6Ceyi0N2OIfdNcxm0XI+hcqo0yKzCKvi30zy8dJoJc+6AVi57
 hoDpGUVD7vI8tRnYPYukKGnx95tOyFWssrvQ7zbjnw7UkfxWzE1LA8BbgqGR+VhDdcSs
 lBJ5aLDvK4ilXdY6rCzVNLkq5E4ZGF4wbb5kRLxkzFu2Jyz519ZscXcpvxEAdFdtA5Hx
 GTVmZiHyfsQXp3xUF6fqE2F3lR3W8IUI7NNrbAWj6v1vgx4enfpDTA/27F+KhXUxG9hi
 mPxJql4An75Bhof5ueALmCIMNrPw5j5cBiSVbykOv72rDVXkwvKFwi3kfXmYdU5YsG+T
 kNPg==
X-Gm-Message-State: AOJu0YwVlz3BWaRngmMs8Oo6TxmYCS06BOXZ00B55kpVlrqXiT5QKWaM
 +bZUIP2JFDOFVY6qsQjyJDxLAUWjxCsQormCc/MRU1y3kq/OQNI2VlJbRavyaRVyZ5NXx0vjgcY
 XsFSooG0=
X-Gm-Gg: AY/fxX7rvryPOIJ1aALfLFm1I0bFoqrymUtI6VraOIEmPM9YNGJEkL+2hX5PN8c5jUG
 /pWYzn78DQD/vmTktOHSJMWn5BtVnuaiIG3na7UEeRBmBk3leP2DlBZpwKt7bHsTVFlaM8JlBmp
 jSRu6DWTA5SK3fUW+UHB5RC1+c1mMTzbMuSUK6OX7JbMtuo57x0Fm072OXYwQ3bI9YXyP7TUxfG
 WzrQS1TCnxVd2qxYSC6av0OMFiC+WDuJqBfP0hYCOWyVQClIJguaQiOvSjk3g3bjAd9NS5hmzy2
 zmseK48sQSVmhbSRLcV88djM25DaKN4Vxt9uyO3w7oeQB54o1Mwt8hw450Qdp8SrIpgiy7/7hlq
 yIXuev4tFvlUr9OUepbDEGbwLt2BG3NEN2U56KeiokQfZT/RLrnxCKTCqT1o5OeL2IihhaNjBHz
 iQA9NcAQyKpWof3iGqm0MO1A+4HWh7
X-Google-Smtp-Source: AGHT+IE0otYtJf1ChrJHfKfKUkQ6JCTsh9Z0+ZvPtwWpBv48kP+3A0nmjebXnCsAPEh3TjQntdhnew==
X-Received: by 2002:a05:6a21:328e:b0:34e:959d:e144 with SMTP id
 adf61e73a8af0-3898f9c5d2cmr4552938637.54.1767850227577; 
 Wed, 07 Jan 2026 21:30:27 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/50] meson: Reject 32-bit hosts
Date: Thu,  8 Jan 2026 16:29:30 +1100
Message-ID: <20260108053018.626690-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

32-bit hosts have been deprecated since 10.0.
As the first step, disable any such at configuration time.
Further patches will remove the dead code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst       | 29 -----------------------------
 docs/about/removed-features.rst |  6 ++++++
 meson.build                     | 17 ++++-------------
 3 files changed, 10 insertions(+), 42 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7abb3dab59..88efa3aa80 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -186,28 +186,6 @@ maintain our cross-compilation CI tests of the architecture. As we no longer
 have CI coverage support may bitrot away before the deprecation process
 completes.
 
-System emulation on 32-bit x86 hosts (since 8.0)
-''''''''''''''''''''''''''''''''''''''''''''''''
-
-Support for 32-bit x86 host deployments is increasingly uncommon in mainstream
-OS distributions given the widespread availability of 64-bit x86 hardware.
-The QEMU project no longer considers 32-bit x86 support for system emulation to
-be an effective use of its limited resources, and thus intends to discontinue
-it. Since all recent x86 hardware from the past >10 years is capable of the
-64-bit x86 extensions, a corresponding 64-bit OS should be used instead.
-
-TCG Plugin support not enabled by default on 32-bit hosts (since 9.2)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-While it is still possible to enable TCG plugin support for 32-bit
-hosts there are a number of potential pitfalls when instrumenting
-64-bit guests. The plugin APIs typically pass most addresses as
-uint64_t but practices like encoding that address in a host pointer
-for passing as user-data will lose data. As most software analysis
-benefits from having plenty of host memory it seems reasonable to
-encourage users to use 64 bit builds of QEMU for analysis work
-whatever targets they are instrumenting.
-
 TCG Plugin support not enabled by default with TCI (since 9.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
@@ -216,13 +194,6 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
-32-bit host operating systems (since 10.0)
-''''''''''''''''''''''''''''''''''''''''''
-
-Keeping 32-bit host support alive is a substantial burden for the
-QEMU project.  Thus QEMU will in future drop the support for all
-32-bit host systems.
-
 System emulator CPUs
 --------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e81d79da47..b0d7fa8813 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -572,6 +572,12 @@ like the ``akita`` or ``terrier``; it has been deprecated in the
 kernel since 2001. None of the board types QEMU supports need
 ``param_struct`` support, so this option has been removed.
 
+32-bit host operating systems (removed in 11.0)
+'''''''''''''''''''''''''''''''''''''''''''''''
+
+Keeping 32-bit host support alive was a substantial burden for the
+QEMU project.  Thus QEMU dropped all support for all 32-bit host systems.
+
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/meson.build b/meson.build
index db87358d62..0852c30aa5 100644
--- a/meson.build
+++ b/meson.build
@@ -332,6 +332,10 @@ endif
 # Compiler flags #
 ##################
 
+if cc.sizeof('void *') < 8
+  error('QEMU requires a 64-bit CPU host architecture')
+endif
+
 foreach lang : all_languages
   compiler = meson.get_compiler(lang)
   if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=7.4')
@@ -3238,9 +3242,6 @@ if host_os == 'windows'
   endif
 endif
 
-# Detect host pointer size for the target configuration loop.
-host_long_bits = cc.sizeof('void *') * 8
-
 # Detect if ConvertStringToBSTR has been defined in _com_util namespace
 if host_os == 'windows'
   has_convert_string_to_bstr = cxx.links('''
@@ -3351,10 +3352,6 @@ foreach target : target_dirs
 
   target_kconfig = []
   foreach sym: accelerators
-    # Disallow 64-bit on 32-bit emulation and virtualization
-    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
-      continue
-    endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all_accel += { sym: 'y' }
@@ -5025,12 +5022,6 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_long_bits < 64
-  message()
-  warning('DEPRECATED HOST CPU')
-  message()
-  message('Support for 32-bit CPU host architecture ' + cpu + ' is going')
-  message('to be dropped in a future QEMU release.')
 elif host_arch == 'mips'
   message()
   warning('DEPRECATED HOST CPU')
-- 
2.43.0


