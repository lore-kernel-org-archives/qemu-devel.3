Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF649CCF2DE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhufN-0006pb-D2; Mon, 19 Jan 2026 14:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufL-0006nd-3q
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:55 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vhufJ-0001UO-4W
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:11:54 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a07f8dd9cdso28782935ad.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 11:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768849912; x=1769454712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wfknli3tDQs/F7BIkzAI6JhFur+SyPp89eslEi0dJ30=;
 b=ZzkB0jcwvP0d3GaS2THjaNcA3v9SfkzXRG5TrICB+EgsnMYjKoT8T40LQLo1FxBlFe
 w3WNzUnk5cEEz3IANOpuPYFJJ/4gG5KJz6iWfRmP/Sa3AZPym0RP9WuG+NxrtAfXSlLc
 C4t6eC1beEHutxf1m386y+opoyXHpnMQjboAiJGHjnN9ToRCcErudO4k30E6VdNTbyxu
 oNj2V90eDJ/Ot2UnS7ikBjfIjy16p/juh9Z3gCW1OzZ7claQ9Pfixf2tAfNiHHdkSwFJ
 30flIi85yCv2VMGnAcsHCbvQzv2pqz/SN68vuRLbs79wNYSKDkiocuaV67IDmNfNJssA
 nNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768849912; x=1769454712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wfknli3tDQs/F7BIkzAI6JhFur+SyPp89eslEi0dJ30=;
 b=vFZhetpZgfW62gQdS1Xjlt9kc9eb7s+1RODfSUSde83oGS7HjzP8fcHzhP5QOTEQV5
 O/cKVuBQTxYB2GqfNpzIH44hJTssF60PyxsdGMV8Fa1TvARsNjRhJwWf2GXjlSPNo4j3
 e3hPXs+vsPre2EmI/gGd12sL/ZQXyTCbVUlFKnqlqFT3LddXP6BSiSswjWgktkBaGn+w
 2/JZzD05suYJ2xBJNJtsm5vsNKnBm+GRMvVTfDk4sC6WF7al2kZQtpKsi2KMD957HZ9R
 iEg9j3xIG1iO9+eX3bbnpsewqQQ4qHyLSRrgNjw+eP3GCNquzKb+HVa/5+0jERkDnOuW
 t07Q==
X-Gm-Message-State: AOJu0Yz53NkByxbdi+c0uaR2RY4r0RGbnq9V3R6rfpXsFE2kI69ItGM8
 F4iYSdhfTGJ0J1Cfz0DHlGx201CQmY4okjey2jAIcGn+7pRBwhpvq6grFqNBtsbOnLoiFTK2Ia4
 neAVC
X-Gm-Gg: AZuq6aLa5nN9QMmWFsvNOdSDkz+nUjP4sOLpqTBlm8PZ39Phl8rRHv2TA+Lsn8iEHXr
 Liu2ZXOBxj7CNoEY6wRXajAtLNyQWgImbySGb3OW3MWSpzny/julQLOxs2UnmI3LfVDs19XYSlH
 nzZf33gKLKLb4kC8uiaS5wcD3la9scmnMIQGq8Lnt4BV5XHPjJbfoRFlLLsZDe5bYPZNJW35wJo
 z+57VJynL94fOH32byTmyldWLkB+abglb/R+0vpqihJWV1d4E2rMkiLEbygaWy7RCr0RR3cpWQT
 4mr8mhZqXTrVqxylswyrsYvtCC+7HR8pTT1crbUnKwWeljc0XYgdXHXNeemAgk7hwaOhKnSKR/r
 /hdOUhCHuk5gUg8h48PUmCCVlVLqUxW7KjBzLdE/ov95+JaOcT9cElYvoOZjtFlcfBduitKTkXh
 bYe0aNCRyFp1DunRiSKLFUwxC8NKbHWv7v+wvfkyZ3iWkF1QusbV3qAN3KKvhiSrgAP1IRKVZXD
 aU=
X-Received: by 2002:a17:903:fa4:b0:2a0:fb1c:144c with SMTP id
 d9443c01a7336-2a71752af9cmr103997285ad.5.1768849911690; 
 Mon, 19 Jan 2026 11:11:51 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719415f0asm47011795ad.89.2026.01.19.11.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 11:11:51 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 07/11] meson: fix supported compiler arguments in other
 languages than C
Date: Mon, 19 Jan 2026 11:11:33 -0800
Message-ID: <20260119191138.811069-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
References: <20260119191138.811069-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

qemu_common_flags are only checked for c compiler, even though they
are applied to c++ and objc. This is a problem when C compiler is gcc,
and C++ compiler is clang, creating a possible mismatch.

One concrete example is option -fzero-call-used-regs=used-gpr with
ubuntu2204 container, which is supported by gcc, but not by clang, thus
leading to a failure when compiling a C++ TCG plugin.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 meson.build | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/meson.build b/meson.build
index 3ed62a406b7..8820a9832c0 100644
--- a/meson.build
+++ b/meson.build
@@ -682,10 +682,7 @@ if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }'
     hardening_flags += '-fzero-call-used-regs=used-gpr'
 endif
 
-qemu_common_flags += cc.get_supported_arguments(hardening_flags)
-
-add_global_arguments(qemu_common_flags, native: false, language: all_languages)
-add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+qemu_common_flags += hardening_flags
 
 # Collect warning flags we want to set, sorted alphabetically
 warn_flags = [
@@ -744,15 +741,19 @@ if 'cpp' in all_languages
   qemu_cxxflags = ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
 endif
 
-add_project_arguments(qemu_cflags, native: false, language: 'c')
-add_project_arguments(cc.get_supported_arguments(warn_flags), native: false, language: 'c')
+add_project_arguments(cc.get_supported_arguments(qemu_common_flags + qemu_cflags + warn_flags),
+                      native: false, language: 'c')
+add_global_link_arguments(qemu_ldflags, native: false, language: all_languages)
+
 if 'cpp' in all_languages
-  add_project_arguments(qemu_cxxflags, native: false, language: 'cpp')
+  add_project_arguments(cxx.get_supported_arguments(qemu_common_flags + qemu_cxxflags),
+                        native: false, language: 'cpp')
   add_project_arguments(cxx.get_supported_arguments(warn_flags), native: false, language: 'cpp')
 endif
 if 'objc' in all_languages
   # Note sanitizer flags are not applied to Objective-C sources!
-  add_project_arguments(objc.get_supported_arguments(warn_flags), native: false, language: 'objc')
+  add_project_arguments(objc.get_supported_arguments(qemu_common_flags + warn_flags),
+                        native: false, language: 'objc')
 endif
 if host_os == 'linux'
   add_project_arguments('-isystem', meson.current_source_dir() / 'linux-headers',
-- 
2.47.3


