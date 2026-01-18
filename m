Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CD7CA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhat4-00010X-Sl; Sun, 18 Jan 2026 17:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhast-0000Zq-45
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:35 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhasr-0000St-3L
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:04:34 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso23155215ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773871; x=1769378671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGuZe54UTmVFXsSluuX4OgQx2qkxV1BUhiRTAljGAWk=;
 b=SLFgLfRThw40taEt1cqeR8mSEVQY0+qp+hDiECdT3y5ex+s+0TOJG19KfGfBhvt/Vs
 7Gwq1UI9q31Tl82lwm0yRx1j0cmYRg2uPu+SiqBQTwtfHFUskq9bbDw4YwAHiWvVQFDo
 8apym/j5iv53ShxDsVVrQWOUo2tpkAhM98goH3jZWb8lxAnUDQPvRmiejlf6O5RKIqDO
 EGBo+pYn1ty7kW2M0xVbT3FRk4w3gtk0hpYQqd9FvHbGqYKoxE2VWgy0lOBnRhffS7L1
 pNLbcmfKoFzxvwiXn6oLPfFtm39WVFW3t5BKkVXuif9rp+O7FD9z6bDUi9BTAtrqcDPX
 HFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773871; x=1769378671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGuZe54UTmVFXsSluuX4OgQx2qkxV1BUhiRTAljGAWk=;
 b=GoWrcRot8bBIo7di+wz1z9dIEiqcfWD+D1dtiIXvxvOVuBt/0QT4qrClkr43t6rIvd
 Qz3SSFPV2M9p+lMjYn2DZChiPxxbpYXfaL2e27c1/aoF9UHp6BuD7j0qmpWm3RIRBoqm
 Zor1BEXcTI6WP7vFin7U0AlDXaMlenQ8M6XT1DpwM6/M7KquTxW/d2yPMwmRfAKhPnsO
 AVKvor+mevRs1q0pHr4M1Lnsf9ENPoGlQs/2R7QrTuYOR3tjVVG294w3Mj0uDP8JE0rg
 61Vf3Mjzinl98k6BqGOn1vEl2myOG/s70Sp/7i/mMapNJrKS81VFxYqNI2S5cxLWD7Jf
 6ldA==
X-Gm-Message-State: AOJu0YyeGiMH2gd6GuGhx+EQATplHUakidtFuN5hilpli3Ypik0DpbDq
 YwF28dwWjOE2R8Ypr2nh4ODVQDnGW9XQ5q9EmpuT9kQGCWUbVYokmlBp6rxFB2Slrra9JAJUZU2
 6NO0eUcFjjw==
X-Gm-Gg: AY/fxX6omhQzwwN680Y3oSx0sJkh1eek9Aam2pHboM89aOE/KO14GEgwQi4QEaiWotw
 CqWOii2NEuhVZwcW/106K2zJoSn2TXmZWwgtogFnjRjY1SuOKFwBpXs/p7gpMFXaK9ILCxzW35o
 ao1LilYnxT3Ic0FF7a71HNrIlrl0eh9HZ8OCcPGHzb8GdtRALZyCCOnxNpalB0rREhbUY7sfU04
 o49a7XjRK6PSV/ORwws0hSQNA2EzU45NB/SG+5dDWpRiMXSz3wL4N8w/RS5k6pJAMKzg/GnEwFp
 qJ/I+/njjlrTqtbYB65O80TpwMH5x2w0wjk4QKpp09ZmwKyql8T/oyZld/a9EM5QP1XwYWwCagH
 yfZ5ear1PvawglTD/HRMU7JnG3iZwtQBGQ/4Q8cDjQA+eEzecyuSbEJ2qtlxcVtMmtSosQ6gIn/
 jyxPglnJm6y1He/7KAcw==
X-Received: by 2002:a17:903:41cd:b0:2a0:afeb:fbbb with SMTP id
 d9443c01a7336-2a7174fa86fmr90420355ad.1.1768773870642; 
 Sun, 18 Jan 2026 14:04:30 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PULL 05/54] meson: Drop cpu == wasm32 tests
Date: Mon, 19 Jan 2026 09:03:25 +1100
Message-ID: <20260118220414.8177-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
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


