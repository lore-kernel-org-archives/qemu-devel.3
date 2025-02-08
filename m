Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CA0C02198
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2025 20:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgrtL-0001s1-Hl; Sat, 08 Feb 2025 15:57:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtK-0001ra-6l
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:30 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgrtI-000579-JS
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 15:57:29 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21ddab8800bso44894185ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 12:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739048247; x=1739653047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkDk8OxqW6uxutlAZ9P73/1ySr9ma3Px3naV7Jdqb0w=;
 b=jZsdYdxzeUe+iFQVItZVD5YD/ocFTnWTdpMRSRXX6S/ETkzPcQGDRV+QgLytKj8azF
 om6zF0osN31egX2X+NOk5NhxU+Xjquapk+X3rYWIcRgj4OoCYdrKOqJ383vilBXLOVYO
 KA3bMhhutjdvF2591D+HFsvwFxGdJe+/PEeHIeTwUWSX54WP+IlugDFW/e4KF7gkg1pu
 TYatRgg+lF0jJPJZp+RhVuilbeUSFWhaYtKw9Mhz/xFtzO6uirPTrGKWeNIcRPut4I7Z
 MySpaQHv+6nQ9R6zldsgMGCeBJsB5DE8JM8Efn29U8RLWiMYJHfKSub6zri1m5i8YD+v
 pnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739048247; x=1739653047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkDk8OxqW6uxutlAZ9P73/1ySr9ma3Px3naV7Jdqb0w=;
 b=fmr8qlb+kzpOPyTlmuxf4Pai/kSRlGKojkNpzjILOT/IOYQFz2xlyuRv6xBVu4J2xQ
 QNAR7EX8BGL65Noe5aalqKY/72XxUivdHOpgE75pg6RVARqlgXUraiubWiwhL18gyioE
 B68/l7XLM5j3p05Dm+xerX6q3QDl0J17KPCiLDRKNVdHmYWsPit7YPXOkXlQSqCiGlnT
 V4mILe5Zn5zXSSuXWvNrxkU4lhkdDN3Y8r7NXw7gXnUyJySqcFafNcZB3il5EWQZQ2uO
 Cq0Daj+QxzlEjS/uYASSUJdRPnSsLD/K+v0ys7ePpi25hlucMcK5hmf8Wsj2C2c63eJU
 27RA==
X-Gm-Message-State: AOJu0YybE3p6JaDzOhoqI2hUJPSQbniMAFwikIlqXZSq4o68q6V4/yOE
 ImDIhL94iRwwNbJMkjUUbY83icgmJ/hZyLdvvag0GPcC+CkIgXQpzhfiL+294qIgHN/2JV7TmP3
 r
X-Gm-Gg: ASbGncuGiU+wNiZFopaAYOysTtGH3fHdJaCEOcl7tdlvBcGhT79dP1WHKa5o+IIQ3FU
 FkG+FWiinCFuQmdMpXWnysgjQBYn/OELDE5W6ds8HoWSYBPIQiSBdWegNoN1maJlaChrzIvVEZs
 f7bAdX3ufORNU//14uF40EHgWplMzz95wszIzVU6aHVBTTVFBWQNUvPLwjVLXA+BolZ0zo0ZMGH
 1zAzZXqzXCGDoFY6pQ11wrCAYhLtMVKcxnHCRovEDUJ+7Hj54HUEGv6TxF74fpGoaC2qxnLp+iG
 NVjI7Rvk1ezIdoIOPcLIZIv7SpH5zPsZjX0jNgphMuaernw=
X-Google-Smtp-Source: AGHT+IEL6zx/yVRpIa3pZczCgMftxb7mP3PrrrL2UvbSqxMYyckgnmNejr+t3pzUcjWZ9w8SWFWwRQ==
X-Received: by 2002:a17:902:e552:b0:216:2259:a4bd with SMTP id
 d9443c01a7336-21f4e76cfc0mr118520015ad.52.1739048247028; 
 Sat, 08 Feb 2025 12:57:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3683d58fsm50852685ad.122.2025.02.08.12.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 12:57:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/9] meson: Drop tcg as a module
Date: Sat,  8 Feb 2025 12:57:16 -0800
Message-ID: <20250208205725.568631-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208205725.568631-1-richard.henderson@linaro.org>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
index 131b2225ab..e50a103f8a 100644
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


