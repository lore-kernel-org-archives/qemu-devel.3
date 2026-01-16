Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B29D4A5F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaau-0005Aa-If; Thu, 15 Jan 2026 22:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaas-0005AB-P3
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:50 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaar-0005LJ-23
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:50 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-bc09b3d3afeso639442a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534428; x=1769139228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I83QPWtH9U5iWC7LMp+ajrhWMXwe0PAlGrhYN4kn3j8=;
 b=Kwnm6L324etuBadmEaRMbWAYL8Dv9EoipDCj/tlSE8MG9g2gQRbdsnng8TAG+6XXXB
 4YKhcvlir3wild1mCSyszhHERZKS1+izAgbUwX9PQ96cWEOFytHcHvWq7cjASjHSlhHB
 5jCesxDYD8YooMHnXqsDnwsmi0MB+dGkO1a/fXPJ5iwm4l2YzYTT4yYnlmMFy+K/aRoN
 aiAOJSg/fuX+XnjwX5iU2gMpT3Is/y1H3LFzH9KxmMdXzJQr6vo5azk7chga4lL5GsuI
 piPCpsKo2O2PdnsZ8tYSbXkEZBfY7cedhr2bERGgUc1gmcd7NfKOOVFHinFbutjrBQz2
 +XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534428; x=1769139228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I83QPWtH9U5iWC7LMp+ajrhWMXwe0PAlGrhYN4kn3j8=;
 b=Z5lpI2LZ5HZZVi/pyTdg0DAZ9mVVKmcif/ZQSgUKxTfRvEROPqGnUwUGLMDsrmPtwV
 W2jl8IYF05TX7OuaJScYoU6joGaW4wWDqcnB1Rmpy3qAN22sbVYukZIjCC+9fmSfWxGL
 nsbxB8gA5rusOCetfl5+1ktQlSLdUmm6u0zlfQSUeYmukRYxtPH0OQacKHRNEtRwzRGL
 4TYMGR85pMmGBMSvGAGh8iojO/mJdnDVCVFYr3KvqF74AfVbuc4EU49amFQ+qQGgiidq
 INLyfMidqPh6Tz4i3PMxbJ1eblCd3E0twoJ3hNE422N6uU4TiqvC+rU0QH92zKS36ZH0
 6OdQ==
X-Gm-Message-State: AOJu0YwCuQ+iqjrWMYQbPoVKltYvxqCgAgRmUktiau5DQpK2u8gkuj9s
 HSLfSMV7j7rIFsjaAd2eIFpMB2hDCxJlg19aMa8RRYR2/4JthCxlsAtkd4Ol3E+tWCTrf13FFIg
 QlVHR2mOHWQ==
X-Gm-Gg: AY/fxX79Q5Ohp7iv1lEvqyK4saTN9ECwfXj3UOSTpPL5H4OCpDaBeZwSIjHSTIO8l6V
 6xyodE2aOlBdH5Gc/g7n4ecMMb3/e2RGUjRTg5RIcGKPlK8wdz5bWLeRHTcJ+hCsEdPX6s0aoF4
 R37Cz4BN/qnICsiIKyqft3HoTZixJdJAw1JbdrDiYOXQXwvOSy9MHfJK5tHowXlL42nm53DnhUk
 GD+ZNSYVk2h28knsKp1zVR37s81y9WUQGT8vISU446pNOxKoRD1BpokHzxWfbbnLay58X9A/RGf
 uhUv5UEZzRkKzMpKpUyb/SOO+AdJ3Vr4fTchi30IDiR5ICZz2Ze/f1iN3EMVA4eaEOAiopoMbog
 fiBmOfNyYRSVQUtqNC+n5qCosakgosH2Sora0vTOlNhklq40IkeRt0MhWqgkkbkfAFEPO1fowuy
 t2fmWfNwsOPCWCWZjlug==
X-Received: by 2002:a17:90b:3dcc:b0:34e:5516:6653 with SMTP id
 98e67ed59e1d1-3527315b15dmr1136231a91.8.1768534427532; 
 Thu, 15 Jan 2026 19:33:47 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 08/58] meson: Reject 32-bit hosts
Date: Fri, 16 Jan 2026 14:32:14 +1100
Message-ID: <20260116033305.51162-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

32-bit hosts have been deprecated since 10.0.
As the first step, disable any such at configuration time.
Further patches will remove the dead code.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 600c50007d..28f61be675 100644
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
@@ -3247,9 +3251,6 @@ if host_os == 'windows'
   endif
 endif
 
-# Detect host pointer size for the target configuration loop.
-host_long_bits = cc.sizeof('void *') * 8
-
 # Detect if ConvertStringToBSTR has been defined in _com_util namespace
 if host_os == 'windows'
   has_convert_string_to_bstr = cxx.links('''
@@ -3360,10 +3361,6 @@ foreach target : target_dirs
 
   target_kconfig = []
   foreach sym: accelerators
-    # Disallow 64-bit on 32-bit emulation and virtualization
-    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
-      continue
-    endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all_accel += { sym: 'y' }
@@ -5036,12 +5033,6 @@ if host_arch == 'unknown'
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


