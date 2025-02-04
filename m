Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96413C02196
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQrv-0001Ya-WF; Tue, 04 Feb 2025 16:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrs-0001Xk-L7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:05 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrq-0008TH-ST
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:04 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2f9da2a7004so672541a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706041; x=1739310841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3Or1wgFVASFFVytdJJvjX+H/PUVd1NdLdYjQo0f1Ts=;
 b=badPjuL+pLqE7BgR3VCD6yDGnW8CLfGvLdtJBDqZmygcI6FI1ABoBMbPlMwApidpED
 NnNWtwc/FTomufTcXYr1x3EsOupLSQcqsmjOzIxARogUenZR9mwR7YYbsy+83oku73l1
 Mxkm4IzxrjgJ6XaD5CWg/QmGyL1JS/wLAhyHVrOLUiCpcgGDf8XaxkiiiBr8/eCCn2lk
 ZzYxCdxoIDQQJ9sYJ3pn0FSicXF3e6hgwnD6/2imPY04f4/V1m2VBn2UDE/3FR2gkp+J
 0LKXjX3d7NVPZ7pyKHxFMpbnOsFwdDjNdFP8GpnzQd5K7DGAyI90yXyAtaJ/WurkN2bg
 6SVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706041; x=1739310841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3Or1wgFVASFFVytdJJvjX+H/PUVd1NdLdYjQo0f1Ts=;
 b=Dk/J9qsygjUtbHRX7IHm4F63n4FV4QHyoD+f6bGfdMjSkjt7C8wSlD8eiwwX9MqTm8
 K46iWtdp4b0BAAZAYVAEgaC7m0W/PvZb/v51zjV8pVo0FViYAF2nzx6ZqQCGhPcZ1A24
 enWmOq11+BuMGkJ4xz0hPNY7q2+7cbBkiDHIRcCWrZy7q1GbE/9qA9I9q9bVZUjaWpSr
 RltpTkG33zYvJo+41D+O7sbybIsxIWw3MnsEpZ+nHVDezAtzrZ4t5JBiUcCopIHxqhfq
 O+QhF9VeE+aQX1Szghifd+foX/hZvL0ZmsjpjIy4FQAsrPvqawqLitIj2KeVLPK847lm
 9lTg==
X-Gm-Message-State: AOJu0YxOwSGyM/e1cl8sRh2PGCinlWtfq1jj9QMI3Ss9e6Z+cZKtawPK
 QQT1biLwAl7LniQAnU2TBlUs55MNqFT9YUt8eySR+lDiG/WsplWEuvUySi4Am4kfkcJ7qymHPVV
 Q
X-Gm-Gg: ASbGnctwljDRQNWwoKUbVInif23EIdNtnAIcrgB2x26Yv1Sm0HxRz/oiGT+DGUY97+e
 2qoMmDjU+lXgPSRWJS+YuNw7jGA5w7KpOps0pu5W2W7EWWEzlQgnS1r4bNzj/6YdtuMeCXUT4fZ
 e1meA5Y/f/1WKGDFYX7jCr5wXLDfZJZcUm9PCyMtiBmTghPtoX+jrHH3H3rxd/AaAUeD+TA//7t
 jvdtcnJ4nzTcNSPKlAMKyNnTBtHyNEr1CQTriGyx8ITEv+333q+rUz9B+OLhQW3qrKB9otkP7jN
 oyOBXHybAf6vjS8jB8KpIttQT2mSL1ocdKffhGWlqHHeUv4=
X-Google-Smtp-Source: AGHT+IHCzlkQRKpXADS815BZGKS0ZizQCD+CRpRz3Mf7jGuDjWPIvKzoQyVWv5YMI4HOmo5Ni+sBFA==
X-Received: by 2002:a17:90b:194e:b0:2ee:b2be:f390 with SMTP id
 98e67ed59e1d1-2f9e07ff94fmr531845a91.28.1738706041312; 
 Tue, 04 Feb 2025 13:54:01 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 01/12] meson: Drop tcg as a module
Date: Tue,  4 Feb 2025 13:53:48 -0800
Message-ID: <20250204215359.1238808-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This reverts commit dae0ec159f9 ("accel: build tcg modular").
The attempt was only enabled for x86, only modularized a small
portion of tcg, and in more than 3 years there have been no
follow-ups to improve the situation.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 11 ++++-------
 meson.build           | 18 +-----------------
 2 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index aef80de967..69f4808ac4 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -21,16 +21,13 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
   'watchpoint.c',
+  'tcg-accel-ops.c',
+  'tcg-accel-ops-mttcg.c',
+  'tcg-accel-ops-icount.c',
+  'tcg-accel-ops-rr.c',
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
 ))
-
-tcg_module_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
-  'tcg-accel-ops.c',
-  'tcg-accel-ops-mttcg.c',
-  'tcg-accel-ops-icount.c',
-  'tcg-accel-ops-rr.c',
-))
diff --git a/meson.build b/meson.build
index 2c9ac9cfe1..b72114819b 100644
--- a/meson.build
+++ b/meson.build
@@ -322,12 +322,6 @@ if cpu in ['x86', 'x86_64']
   }
 endif
 
-modular_tcg = []
-# Darwin does not support references to thread-local variables in modules
-if host_os != 'darwin'
-  modular_tcg = ['i386-softmmu', 'x86_64-softmmu']
-endif
-
 ##################
 # Compiler flags #
 ##################
@@ -3279,11 +3273,6 @@ foreach target : target_dirs
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
       config_target += { sym: 'y' }
       config_all_accel += { sym: 'y' }
-      if target in modular_tcg
-        config_target += { 'CONFIG_TCG_MODULAR': 'y' }
-      else
-        config_target += { 'CONFIG_TCG_BUILTIN': 'y' }
-      endif
       target_kconfig += [ sym + '=y' ]
     endif
   endforeach
@@ -3642,7 +3631,6 @@ util_ss = ss.source_set()
 
 # accel modules
 qtest_module_ss = ss.source_set()
-tcg_module_ss = ss.source_set()
 
 modules = {}
 target_modules = {}
@@ -3803,11 +3791,7 @@ subdir('tests/qtest/libqos')
 subdir('tests/qtest/fuzz')
 
 # accel modules
-tcg_real_module_ss = ss.source_set()
-tcg_real_module_ss.add_all(when: 'CONFIG_TCG_MODULAR', if_true: tcg_module_ss)
-specific_ss.add_all(when: 'CONFIG_TCG_BUILTIN', if_true: tcg_module_ss)
-target_modules += { 'accel' : { 'qtest': qtest_module_ss,
-                                'tcg': tcg_real_module_ss }}
+target_modules += { 'accel' : { 'qtest': qtest_module_ss }}
 
 ##############################################
 # Internal static_libraries and dependencies #
-- 
2.43.0


