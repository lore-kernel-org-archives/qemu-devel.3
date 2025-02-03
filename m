Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5087DC0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temyj-0007y8-H9; Sun, 02 Feb 2025 22:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyh-0007wd-O0
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyf-0002e2-Ov
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:27 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21634338cfdso93106985ad.2
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552704; x=1739157504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iM3D9a39pGGlsRoa9TrM2icjX42ZQQytV5dtn3gTX+s=;
 b=eK0wD26H2qSnSrPAVVTzyDGrbThjW6HS+gtLwYzPauEMC7PV7jJMGYWMw92jaL9lwH
 9ruxcFs3qtsW6l28xz47nGqinvXFWJxCSUAwK9Mc4qO0YqfcGzFxjE31X+s8WAKOzS0d
 q2vY3sb4r9H6rKq2zmaaZLhJhLlXsx3a2yMptKG4zuZtpTekaVXVycrRqnF+3QR2ozRJ
 feX6/g4dLJ6KDfG0TRUeIn1YYV7RIju5BHKpnXhXHldor5uPsbVMECngHJBqqM1AOJNx
 /0ER57NhkriFiNdk1tbrCbeVRwTicm3+Nair6O23nGSNJOXxkou4VX2Hn2p1+Dn2awn/
 QXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552704; x=1739157504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iM3D9a39pGGlsRoa9TrM2icjX42ZQQytV5dtn3gTX+s=;
 b=FXgIkEgY+4CdOQfoxNI55C0HP3Xt53UtE1zORjjpqf3xEyOBUjJujPFr4sxF1whCcb
 V43YDVnSMv2fXS+yzpALUkh6tXUbPWFIUq0GY6S/NqHcmuTwvxZBMZrnpKC+jH4cOaIH
 AC0ZDn22f1fWZeMxkHbXqBCTCqsEH0NqVmgL3eEexsUzY4Yoz10gBGSog5P8svPZ064V
 oOvAErrW34mCuNH3VLOsSb9ROYXpXC0jzjEqiE6mmirrUgd2Sna9xaplEnNqdjETBwdn
 2WefPMfbFQIntxMcAXpJqjtvaGzuNRGeuGOmPGxm0Octm72Jdm3RKFumtypN0Y5/P3jk
 0zRQ==
X-Gm-Message-State: AOJu0Yw9BRtGwXwrip2S1k6W+R6Is4nNl1eVCTSLh1obiAPW1Qz2B/q+
 +mt1gl9h3RtiEQgPrjCXdOihOuDz5WEWAXpdNGfTYD9lR24rRUNSShkjZmVv5UrrOEmj+ZqBkdn
 1
X-Gm-Gg: ASbGncszpRfa7aX41N0toUMt3P3J4dUvMiLQNpfo18DCc+WXDlI5TwhFuXIGh5rdRfo
 eAZehu6IQjoopzGMQvqXid9oYbvxZVXcnfh/vS54lO+dvWUfDj+7N+QFc9n+Jg40ykTpDR66eeg
 vQllC3M4SbnyMOnI9n8AZgdzBed2Uya1KlUDvevid7ZkWzkHfRI4FGI4OOL6PBu6Y4/r36DR/rJ
 mrM7BitAYfzzh3XCJ2DYG/QkxTgaBKtCNDNgkSEBZMtrMGRgZEDpTXryFzysUAVOM8g5ek6r/mk
 48HUzmJ6DCcIS/JJPuOFCVazWMPvcVLYu41B02Nw2eVR0yw=
X-Google-Smtp-Source: AGHT+IFe/FDSd3GJ8+TqxhWOQ+6qcLks6JjI7BJbr0T+ourkfniZBySVXkQKqqUDL748cXOlNlIUuA==
X-Received: by 2002:a17:903:244f:b0:216:1cfa:2bda with SMTP id
 d9443c01a7336-21dd7de1d37mr305133645ad.43.1738552703988; 
 Sun, 02 Feb 2025 19:18:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 01/14] meson: Drop tcg as a module
Date: Sun,  2 Feb 2025 19:18:08 -0800
Message-ID: <20250203031821.741477-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The fact that this is only enabled for x86 probably means it
was done incorrectly.  Certainly the set of files selected to
go into the module is woefully incomplete.  Drop it for now.

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


