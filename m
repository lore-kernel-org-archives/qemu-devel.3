Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122F1D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgaay-0005Bc-AZ; Thu, 15 Jan 2026 22:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaaw-0005BN-K7
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:54 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaau-0005Mg-Na
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:33:54 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso1387059b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534431; x=1769139231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQmdwfgDw/OFvrU337kdzrrsEE2LGo0JQHmsETZmOYM=;
 b=JBljx8D5lEn4/rKeLlA+1cQJqCP4xDYrePWIIGyXm6QfnDUro9mQ01FshsgsQOoa/3
 vOosBcJX9oelPgShJLHGTNBSVK9WyCs8z58ar+nSp2MiKxt51IO1tJo7Y6eJVfwt/KJQ
 W4/SNGGaUp41V0ZBb2XrCMbludNx7UbD9JTQ5KBMruK5t/rlfJNdYU4DFPkKHN9fgglQ
 R2h95whjsiql0xASJrqa3Qn7tG43DCRG2H8FReB5or1EQ3bm4UTDSkKuhDj4D1GPuHlg
 gTABrFJmFb2hbDuHYh8AOFuilDxbTgL+d0mVQiFCWmXQ5hCdfdQJdtyz1TOzCVIXBF07
 KicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534431; x=1769139231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQmdwfgDw/OFvrU337kdzrrsEE2LGo0JQHmsETZmOYM=;
 b=Yj8zzLqXCymzJleinCslAklzr2EaKknqHUlfecQRJ0/+peTlu8io2yKanKVeFathrh
 wNh43dhkqqLRz9N1vOHSbkZ/D3dDZAgMS7AbY8MQGwu6D0XIQ56hjZqdRtgM+KgcRMlV
 3PPU7KsqaGTpPcpnSXbDJlcJot2y23E1HaAZGrbKGtDq1cWIsRe4Mzrm8JaM7c2GFbu2
 +OpNFG3HWkI4nIdMAInVjl2LALayNDSHdA/NnJaa05oR1oXPCWd5c96wXpcmCtwk1h0l
 FO6O8rpTkSgYdSD3w6ig3MG+0Rny6bquBa7MKclo+mfKKlKkOC4XP/BJojZor66oiAJH
 Pj3g==
X-Gm-Message-State: AOJu0YzNHTquRjXT0KdolMS/Lcd7A5uEJ5EJ6xsBgJBl+BVl2rUplgTK
 cj6WMIBvtdjigr1cKASmZXQv7h1s/l4kRFuj8bkC8SNTh1Dlkd75QLnlVDNndwtfp+w7hOxniRR
 tKW7n/53aPg==
X-Gm-Gg: AY/fxX5x0zu57EYGV57u8B9MutC83mLKezV80av4iiAVirLVSShoTt9W5opiI5Nekkb
 lTCUwebNMWPwqn+8gZ7eMpP11sSgvhoJllbdAmmav5YMIU/JbYSLHgznc2dxQUddQXh3JFC8Q+c
 CfX9ifygrJYfz78i9T276wFla4qSv3znVzCcv0jc6reRrhf6oT98E/hxI2/RpOFLYX/3wY/yE1Q
 q80O1t1bE81K4W42sJgSwSLsqvBKULV7Ib2RtJsZtSVKjgRwbJgzRlK04Kx7KW+SB81JU9PT8rP
 HdcbLAINcKb/gk1qG4WVGL+oeFBeAUi9w4urj8Lx8Q0ihbTPxScv5xPHVLCJwWDjsBOlGVcuNPd
 K21bVYP9oThE6WrlZc8z/ktlw530A0V5t7Y+mn6xjh85aH/tSajq9TVHElR8TLkeomnzXFk+Aol
 SnBcnPoHNz0GT0Z4RS2A==
X-Received: by 2002:a05:6a00:3020:b0:81f:4319:6a0c with SMTP id
 d2e1a72fcca58-81fa03a1fbfmr1450989b3a.51.1768534431304; 
 Thu, 15 Jan 2026 19:33:51 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:33:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 09/58] meson: Drop cpu == wasm32 tests
Date: Fri, 16 Jan 2026 14:32:15 +1100
Message-ID: <20260116033305.51162-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

The 32-bit wasm32 host is no longer supported.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure   | 5 +----
 meson.build | 6 +++---
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 326d27dab1..ba1b207b56 100755
--- a/configure
+++ b/configure
@@ -425,7 +425,7 @@ elif check_define __aarch64__ ; then
 elif check_define __loongarch64 ; then
   cpu="loongarch64"
 elif check_define EMSCRIPTEN ; then
-  error_exit "wasm32 or wasm64 must be specified to the cpu flag"
+  error_exit "wasm64 must be specified to the cpu flag"
 else
   # Using uname is really broken, but it is just a fallback for architectures
   # that are going to use TCI anyway
@@ -523,9 +523,6 @@ case "$cpu" in
     linux_arch=x86
     CPU_CFLAGS="-m64"
     ;;
-  wasm32)
-    CPU_CFLAGS="-m32"
-    ;;
   wasm64)
     CPU_CFLAGS="-m64 -sMEMORY64=$wasm64_memory64"
     ;;
diff --git a/meson.build b/meson.build
index 28f61be675..082c7a86ca 100644
--- a/meson.build
+++ b/meson.build
@@ -51,7 +51,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux', 'emscripten']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm32', 'wasm64']
+  'arm', 'aarch64', 'loongarch64', 'mips64', 'sparc64', 'wasm64']
 
 cpu = host_machine.cpu_family()
 
@@ -927,7 +927,7 @@ if have_tcg
     if not get_option('tcg_interpreter')
       error('Unsupported CPU @0@, try --enable-tcg-interpreter'.format(cpu))
     endif
-  elif host_arch == 'wasm32' or host_arch == 'wasm64'
+  elif host_arch == 'wasm64'
     if not get_option('tcg_interpreter')
       error('WebAssembly host requires --enable-tcg-interpreter')
     endif
@@ -4248,7 +4248,7 @@ if have_rust
     bindgen_args_common += ['--merge-extern-blocks']
   endif
   bindgen_c_args = []
-  if host_arch == 'wasm32'
+  if host_arch == 'wasm64'
     bindgen_c_args += ['-fvisibility=default']
   endif
   subdir('rust')
-- 
2.43.0


