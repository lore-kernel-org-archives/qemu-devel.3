Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7A7C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temym-00080O-Aq; Sun, 02 Feb 2025 22:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyj-0007yS-Jd
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:29 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1temyh-0002ec-T4
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:18:29 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-216728b1836so62817875ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2025 19:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738552706; x=1739157506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wE+iKDowkpEPg8wCdcVqa4FtJfGiWYCtzRF3aZf/Z+U=;
 b=JxnFg4CJC2E1r8S0r4c0Y3p8q3i39wBXHuQuMd3JEabGLl/jiahBJsIpLVEqjtPpcL
 3Pw/Xel8FrIUcVs26kRL7ppAWADbGGmyE+UcjYXHkchudgblvprAp9+hImm3tc+SNwQi
 AkrNhe/Y8oV73XekrzFpW+kh31ixElrdDaqfyQJLzbPFSXXoVNib7fuC8y/025RIaYPh
 TxTJC6igjwb9lj1KVtcb/HL+o5T4RlbDFl2iwgBtVB24+lXdz0TlbwfnnQ9kKvPl8CDE
 g9smIQVfXUgZu8sDaHxXAq5SYn6DFfNaOKu8nfujU/RlnPNS+RBihOrTFyfSnlq7zScB
 GEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738552706; x=1739157506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wE+iKDowkpEPg8wCdcVqa4FtJfGiWYCtzRF3aZf/Z+U=;
 b=Mrdu16uli/0d13cAPV5Cd+JodcW9QVJhPSiFXI4rG6i7WUsrd1q7Vd1RVCIGeZe+WX
 /s1STQlBaxbryJp1oz7bENxK9diGB9xNxNBRz4OUQrCK2a7OPJJZOzpMWmtiGpfMnn2x
 mbnbNW7Obw41K31G3+v0Pd9dyTueGMsuMBKep4yLP/gEUucKf9q0fjFUVVgCudHD6VvF
 a+ecOtdqJcg2f/5LFoPxW2la4omOrFeqSta7iO6VgxDg86VjzsDodQq4blOs/cxPlcx2
 A3Ae2hBB1tXKjHssta3AyeCqqo6rnn1VV0bf5Gg0chYv8Mmt5oEh0yD1e3joipvquUSr
 HCKg==
X-Gm-Message-State: AOJu0YynidvR24xsx12WHl7proXex4kptD1saf76Hy/lLVadSerkIOyf
 jjq8arj0P3wCAxS2XEncTsdo93i41IDXXjrKsg1tB4laiGWykvfjLH+JzB1R+jhv/rnyTe29yv2
 M
X-Gm-Gg: ASbGncurwSnommPm/CekFx7EpRlWrPpNF/6Fen5eKHdD7jExRZLUudsna4JYlK3J4FU
 6bziZR4A08LikwX/2kWEiqwfB6P92X9NE4Jwet16h7o8r75uI9BWyy1SZmapq4P7rLXGFwOhZew
 xo0bGstq4qAE3DTsRUSG/cPXrHf9onE0NzS5LXcBRhLz2sU71Oaqu4s7NGGlJNhtzf0oDiMUkyv
 NxLosMMGRVKEKupr0+M30PJBVnnvApNU9mGkWgFgETxi4vFnUPd8RwoQj8Auv3TaW2v0wVNPJsE
 VbSIjjeFp3KumK0pSaGyha+qIR2iwuGhR7c11kByREJIBds=
X-Google-Smtp-Source: AGHT+IF5u+q5KXDz/i7xuSfH/73HPW2zYlOFQRuVwwsPvJOTxYX6nW2eXjSSGCq6oeDWArpu+elPYQ==
X-Received: by 2002:a17:902:db04:b0:216:4c88:d93a with SMTP id
 d9443c01a7336-21dd7dd7356mr346151955ad.48.1738552706527; 
 Sun, 02 Feb 2025 19:18:26 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de32eb419sm65698135ad.145.2025.02.02.19.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 19:18:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v2 04/14] meson: Introduce CONFIG_TCG_TARGET
Date: Sun,  2 Feb 2025 19:18:11 -0800
Message-ID: <20250203031821.741477-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203031821.741477-1-richard.henderson@linaro.org>
References: <20250203031821.741477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Use CONFIG_TCG as a project-wide flag to indicate that TCG is enabled
for *some* target.  Use CONFIG_TCG_TARGET to indicate that TCG is
enabled for a specific target.

Within a specific compilation unit, we can remap CONFIG_TCG based on
CONFIG_TCG_TARGET.  This allows us to avoid changes to the bulk of
the code base.

Within meson.build, while CONFIG_TCG may be set in config_host_data,
it may not be set within config_target.  Thus all references to
CONFIG_TCG in source_set 'when:' need not be updated.

For the moment, CONFIG_TCG and CONFIG_TCG_TARGET are identical.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h |  7 +++++++
 meson.build          | 11 +++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 112ebdff21..1f6f73a148 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -34,9 +34,16 @@
 #include "config-host.h"
 #ifdef COMPILING_PER_TARGET
 #include CONFIG_TARGET
+# ifdef CONFIG_TCG_TARGET
+#  undef CONFIG_TCG_TARGET
+# else
+#  undef CONFIG_TCG
+# endif
 #else
 #include "exec/poison.h"
 #endif
+#pragma GCC poison CONFIG_TCG_TARGET
+
 
 /*
  * HOST_WORDS_BIGENDIAN was replaced with HOST_BIG_ENDIAN. Prevent it from
diff --git a/meson.build b/meson.build
index b72114819b..5ca3cc3f34 100644
--- a/meson.build
+++ b/meson.build
@@ -3270,11 +3270,14 @@ foreach target : target_dirs
 
   target_kconfig = []
   foreach sym: accelerators
-    if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
-      config_target += { sym: 'y' }
-      config_all_accel += { sym: 'y' }
-      target_kconfig += [ sym + '=y' ]
+    if sym == 'CONFIG_TCG'
+      config_target += { 'CONFIG_TCG_TARGET': 'y' }
+    elif target not in accelerator_targets.get(sym, [])
+      continue
     endif
+    config_target += { sym: 'y' }
+    config_all_accel += { sym: 'y' }
+    target_kconfig += [ sym + '=y' ]
   endforeach
   if target_kconfig.length() == 0
     if default_targets
-- 
2.43.0


