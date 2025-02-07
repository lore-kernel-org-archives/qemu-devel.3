Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FBEC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 21:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgVZ5-0007Y3-Ji; Fri, 07 Feb 2025 16:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVYz-00076G-0h
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:01 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tgVYx-00022o-Cu
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 16:07:00 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f40deb941so45578195ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 13:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738962418; x=1739567218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XkDk8OxqW6uxutlAZ9P73/1ySr9ma3Px3naV7Jdqb0w=;
 b=W0TujEVoyu+aBNYNd4Tm0byOPJKyuLgLBOIXxRfP4ECIXnEQlSMaAs7QzSMZPuoVFn
 WtVZ07Y87A6yPtRo3zER9fA3d8qtZE66TfW0FPim8xZDngHQewXyqtJk9j5IWTZLW1TX
 ix9k01TE+ot+rgJHuen7yDnK4knKSs539mGqfa+ZKBLSzvnUu76RvdgB54KRelk0MXpl
 wjXLOfIY5XpcKOc7k0C37Kz6QLPeohJF4K2mPYYIIHxEDs9l3ioXjt8vbGEiQAY0jgWf
 x6+pgT6pogeZGhDaKAeSFkGeBR5XbnM/TJtdwqsuwqAO8HGaZm6+bMYqDAhIqoAv73QX
 FbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738962418; x=1739567218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XkDk8OxqW6uxutlAZ9P73/1ySr9ma3Px3naV7Jdqb0w=;
 b=A36TmPo2GsVA/j+6ZjNCPN9BMIaQGjUDjTKXuXWDtHeAg/AlCOD+99JG3VYys1Vg2B
 MxqGAeOImNe7tS1232dmeYoFRfuAzEC/eZm7gNc9wUOHWU/0rnu8PtlC5FUWCrIR5UiV
 +3blED+mu4FixnKLVTEocRuiv56L9b7bCYnYHpPPGoLbRU1py8zw21F0P9epINvtUhRV
 Dcjh8yDRxxq8ikM/z3XAc3SxMPeOudVa3XvZgCySdCJmGAoyb6GUmiAErCyzYo8oST9V
 DD8znDbhVfBhlo9SL1bIh0fKJG+X0KfuEyvtu0vhEE5vPOaSNrnJNkmBzovWOICNfKeX
 rc+Q==
X-Gm-Message-State: AOJu0YxxaGQP//HUhzOuIqXWesqKbt8b+OK7aC7oGdTn3ZWv3WKysdOI
 BfPyYvzKqBOZMQuGM/gVaQNK/0mGqzwL2Q7r+JBXNZZJncw/D0GDjTtknr2GNi1bHPUg+ubxcZy
 x
X-Gm-Gg: ASbGncsxXm/k3eq9twyukVgwhcZTArVQrLjYv3NkDW5VSFtayVpOOSR2K6epL2FtcQN
 CNh6xYuXMrrJ9oa4VrlB0+TWexD5CpMjOHh1g1wbR5FCB4kAEMx1FwSL80r/YKnwnjo9IXm//I9
 rmVGLf+qBONWDw1CiBgb1g1jXg7LDSgJVfCfbgFTDGyObKtEU71Bj8iKme9zUYI+78s+j7vHV1s
 YbcwXgLVR4YJwFWjCfL5j8Q55ro+almahZepNf0jZHyl4njIRGv4qwNExNYkFWXrcic6lepHHvq
 35QVI701ncxcq1oZdYgDyNCGs4TCyjiu/HPgGEvTgdyf5W8=
X-Google-Smtp-Source: AGHT+IEtinUgtk10/LTZV5FVHk2UrDojrASWecB5wbv/sR24Of8udzVAoAd+hfvuLsXKIFG2e+Yq8Q==
X-Received: by 2002:a05:6a20:841e:b0:1ed:534e:38b1 with SMTP id
 adf61e73a8af0-1ee03b7618dmr8004619637.41.1738962417957; 
 Fri, 07 Feb 2025 13:06:57 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af64c1dsm3539043a12.52.2025.02.07.13.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 13:06:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 1/9] meson: Drop tcg as a module
Date: Fri,  7 Feb 2025 13:06:47 -0800
Message-ID: <20250207210655.16717-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207210655.16717-1-richard.henderson@linaro.org>
References: <20250207210655.16717-1-richard.henderson@linaro.org>
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


