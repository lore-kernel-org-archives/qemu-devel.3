Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E7C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDuA-0000EI-3O; Thu, 06 Mar 2025 11:17:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqDto-000077-Vg
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:16:41 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tqDtm-0001pF-DT
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:16:40 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e56b229d60so3824075a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741277796; x=1741882596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xjVTMoKE2YFpSamLuLdkjBohjXiM/7zwA6+1VeWKxpo=;
 b=oVBRreKYAWr5kwLywwVR1m77HyRW2FoVX+k7Mc8J71JqOYVrNypq8Ahsf/CNKtg/Fz
 nMl7Kcf91+t8txyfWpCM8g1bw0H0yPeQbJ0Isr31Ps+lfrA3ch1cElIveTD0O10NkFNJ
 DNb+4fymhKp+kfHutwua8uawmY9jqgGOlGoDepH7TXsDjeBnVZKYMPqJBzCY3u08yj6G
 ShQIijjOK57SRxjF82jFRc7GmePLjDowxHQXP6xL1iROlucvXV4NGo7GD3lEnVouW1cC
 hX95Ckk7d0JPhM03T92KZ1UF4UWzmoyN7mG6maAQ9ZBVhi/EagZXoQDFcrISSSCjzMHT
 H+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277796; x=1741882596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xjVTMoKE2YFpSamLuLdkjBohjXiM/7zwA6+1VeWKxpo=;
 b=nrbzZzQEpVuHvwLUjVBNbrhfcgGwMPuuEbGBtaUq2S8h8u/WMWOixTqp/us+dFD+To
 cZBxLTE05qMicA2Vj6tIuLJB2BMPJnvCyAmkjUO2wXW8DIFGtjcYKggrYPQ7nTjZgqZM
 J8mHh3pdHZcGHW/+SXHhP+u2qRDHBzCA3r8ZcjrXPirbm2j/Lalgs1YCFGWKlG2CuC/B
 Afu7O9GZpHVrbGMfxtX0UHhupp0Ky0Sb5hcWA021fmoNeJ0H8sWmNX4O/Cm5VJKMOPOo
 WCYN+KpMPxEz5/iVd9KyR2kejqNjglC9zIw0yK2NI99cbdczfA832w9vPV2L+cxAhA1N
 Gomw==
X-Gm-Message-State: AOJu0Yxldn/RL3fSqTG0eOW1q+ACZSSv2Z+ZdmpnNYJHAWZxzXDe+TOU
 /P32VeLJ12XJ835itYOqTRR1Asc0CBHCLPlsC+l+FT9/xKiNFfdd3XDhU0mxBJw=
X-Gm-Gg: ASbGncvcBHGAEGZepIdFaUfAFoCK7E/xoKkoXKAMSLKrPgGD1AX4vjsKvJWRsIl9Olt
 YQ6z2ndXxCViuYQFiVwGgmI5gHcOI4g84iWeaWcH+dApoxZ93wY7XrvvdzRVHhO/FxvDGx8Cm08
 kBF0AKxUq73fwJ3ezFLU1iSgLE3EsC9dzwOEsGe+o1vm5AK4IPMwLALH166xMiu+e9GKkofRwUq
 epZCu2KyoCv3bqeSEcEi9B06dTiSAKlFcV+ckwvP3FGDdyEVnIdUdfuPQhsKSJx3dlYytnwGM9G
 XUUdf6gp3WJ8e2yzv9g/5ui7icaLuAiCV/XlxddJGiQJ0GA=
X-Google-Smtp-Source: AGHT+IE2rweZda0aTyDW7H6qIDPPUb9oJwx8Du2H5900izeIF/3Nv4whjLksifvkrYUwNJrLHlZucw==
X-Received: by 2002:a17:907:3e13:b0:abf:6e9:3732 with SMTP id
 a640c23a62f3a-ac22ca6c386mr368387766b.3.1741277796388; 
 Thu, 06 Mar 2025 08:16:36 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2399d7de3sm117527066b.184.2025.03.06.08.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:16:35 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CB8265F9CF;
 Thu,  6 Mar 2025 16:16:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3] meson.build: default to -gsplit-dwarf for debug info
Date: Thu,  6 Mar 2025 16:16:31 +0000
Message-Id: <20250306161631.2477685-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This option is supported by both gcc (since 4.7) and clang (since
7.0). Not only does this make the linkers job easier by reducing the
amount of ELF it needs to parse it also reduces the total build size
quite considerably. In my case a default build went from 5.8G to
3.9G (vs 1.9G for --disable-debug-info).

The --disable-split-debug option allows distros to keep all the info
together for ease of packaging.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

---
v1
  - add --disable/enable-split-debug
  - move to option_cflags
v2
  - removed unneeded []'s
  - fix stray whitespace
v3
  - set qemu_cflags instead of option_cflags
  - move up to the rest of the qemu_cflag setting code
  - update build size numbers with --disable-debug-info
---
 meson.build                   | 6 +++++-
 meson_options.txt             | 2 ++
 scripts/meson-buildoptions.sh | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 8d0abe7f12..bba17c73f1 100644
--- a/meson.build
+++ b/meson.build
@@ -601,6 +601,10 @@ if get_option('tsan')
   qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
 endif
 
+if get_option('debug')
+  qemu_cflags += get_option('split_debug') ? ['-gsplit-dwarf'] : ['-g']
+endif
+
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
 # The combination is known as "full relro", because .got.plt is read-only too.
 qemu_ldflags += cc.get_supported_link_arguments('-Wl,-z,relro', '-Wl,-z,now')
@@ -4589,7 +4593,7 @@ if have_rust
   summary_info += {'bindgen':         bindgen.full_path()}
   summary_info += {'bindgen version': bindgen.version()}
 endif
-option_cflags = (get_option('debug') ? ['-g'] : [])
+option_cflags = []
 if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
 endif
diff --git a/meson_options.txt b/meson_options.txt
index 59d973bca0..3432123fee 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -362,6 +362,8 @@ option('debug_mutex', type: 'boolean', value: false,
        description: 'mutex debugging support')
 option('debug_stack_usage', type: 'boolean', value: false,
        description: 'measure coroutine stack usage')
+option('split_debug', type: 'boolean', value: true,
+       description: 'split debug info from object files')
 option('qom_cast_debug', type: 'boolean', value: true,
        description: 'cast debugging support')
 option('slirp_smbd', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 3e8e00852b..aca6e68830 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -504,6 +504,8 @@ _meson_option_parse() {
     --disable-strict-rust-lints) printf "%s" -Dstrict_rust_lints=false ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
+    --enable-split-debug) printf "%s" -Dsplit_debug=true ;;
+    --disable-split-debug) printf "%s" -Dsplit_debug=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
     --enable-tcg) printf "%s" -Dtcg=enabled ;;
     --disable-tcg) printf "%s" -Dtcg=disabled ;;
-- 
2.39.5


