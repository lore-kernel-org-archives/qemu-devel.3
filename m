Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D40C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 05:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru3dn-0003BF-Ge; Tue, 09 Apr 2024 01:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3dl-0003AJ-EI
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:25 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ru3di-0005Hi-SK
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 01:03:24 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c38eced701so3051323b6e.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 22:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712639002; x=1713243802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ty9Kcl8q8mjC0qYnkE9obh2ntk7k/Zh+tnhaLzpayq8=;
 b=Fo5sIzc0m1hhRYeo/htBiT9QnnlUxgrENlSwQjmQdNFBdt1pdVXyj8ZHKep8RZU4OB
 NyudmFqHM6cMZcJz4oBLnUC02/VYsdmdw0P5ioEqN8mnG2no1I9VoanYtEG0aRoBqoIQ
 JrgkGxuMgRa77b5PbF1TNccfT7sNSlAUKOhrh2t7a5V4xluHewuOeQ97L9DmN9U+YpyK
 VQJKOXBmvedtMVrVlqVx1VZ4QQuEE9YP9BbQVlQEsRV44rbwpJNAES/Ia0ghJfB0ynJ+
 OI6afWgKjMv7uG/v5hcTiIhO+6FJy+WVBVvEIW8glJRuwGQf+vrXXk2EF4AvSYmiskGQ
 Sz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712639002; x=1713243802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ty9Kcl8q8mjC0qYnkE9obh2ntk7k/Zh+tnhaLzpayq8=;
 b=jQODh7N36XhAsUJqbZRRWk46tumd8ca2JaNDxerCjafhZzLfakC7G0HuoUqVKgXTy5
 eVMFHT01iAvA329IX18WxG6vXHMzRetCeIJK33EmImEZhynER0w/+/F4o7ak8aL2zBPM
 08WpL39bNRB0D/V+ho0mtlyEKwEgrkAjxHhyC3hXGt3aSokbYS5dsMd1RMUFPeeWzXQ2
 b9cFQcD2dTAuuy2mzhUpxlgp1uCqhFSY6cw/A7D/40lkXWPWLurnqdOi+bJqzT8LXNE3
 LP5WD8aDiiD5g9EsPm/AOv0d/5+kM4rujQveqAl3JbqXdG/WYhV2aX3ETtAV43zRxI4o
 cpGw==
X-Gm-Message-State: AOJu0YxfNaqVrtjACd7OCwtqC4lwDLwYFRzMDbAepV7aj+dERMnNbpEd
 IVPwnjO6/J6V4N1w2Tx+WW2drfQngj/VfwAXyDKnnqS7OPeRWYmtYPpW0wwXZAvsZPA94GTAdo0
 E
X-Google-Smtp-Source: AGHT+IE3OVzZvIlwa9AAlcpph1K0rOlEL/mmpwIqj/RGuqFrVYhs182ysiVCkXT5UJ094sI/4H3Wiw==
X-Received: by 2002:a05:6808:13c6:b0:3c3:c17b:9e0 with SMTP id
 d6-20020a05680813c600b003c3c17b09e0mr14005822oiw.49.1712639001814; 
 Mon, 08 Apr 2024 22:03:21 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa785da000000b006e64ddfa71asm7654894pfn.170.2024.04.08.22.03.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 22:03:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/28] target/i386: Add rbfm argument to cpu_x86_{xsave,
 xrstor}
Date: Mon,  8 Apr 2024 19:02:47 -1000
Message-Id: <20240409050302.1523277-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409050302.1523277-1-richard.henderson@linaro.org>
References: <20240409050302.1523277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

For now, continue to pass all 1's from signal.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            | 4 ++--
 linux-user/i386/signal.c     | 4 ++--
 target/i386/tcg/fpu_helper.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6b05738079..5860acb0c3 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2223,8 +2223,8 @@ void cpu_x86_fsave(CPUX86State *s, target_ulong ptr, int data32);
 void cpu_x86_frstor(CPUX86State *s, target_ulong ptr, int data32);
 void cpu_x86_fxsave(CPUX86State *s, target_ulong ptr);
 void cpu_x86_fxrstor(CPUX86State *s, target_ulong ptr);
-void cpu_x86_xsave(CPUX86State *s, target_ulong ptr);
-void cpu_x86_xrstor(CPUX86State *s, target_ulong ptr);
+void cpu_x86_xsave(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
+void cpu_x86_xrstor(CPUX86State *s, target_ulong ptr, uint64_t rbfm);
 
 /* cpu.c */
 void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index cfe70fc5cf..68659fa1db 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -267,7 +267,7 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
 
         /* Zero the header, XSAVE *adds* features to an existing save state.  */
         memset(fxsave->xfeatures, 0, 64);
-        cpu_x86_xsave(env, fxsave_addr);
+        cpu_x86_xsave(env, fxsave_addr, -1);
         __put_user(TARGET_FP_XSTATE_MAGIC1, &fxsave->sw_reserved.magic1);
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
         __put_user(env->xcr0, &fxsave->sw_reserved.xfeatures);
@@ -568,7 +568,7 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
                 return 1;
             }
             if (tswapl(*(uint32_t *) &fxsave->xfeatures[xfeatures_size]) == TARGET_FP_XSTATE_MAGIC2) {
-                cpu_x86_xrstor(env, fxsave_addr);
+                cpu_x86_xrstor(env, fxsave_addr, -1);
                 return 0;
             }
         }
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 11c60152de..dbc1e5d8dd 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3046,14 +3046,14 @@ void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
     do_fxrstor(&ac, ptr);
 }
 
-void cpu_x86_xsave(CPUX86State *env, target_ulong ptr)
+void cpu_x86_xsave(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xsave(env, ptr, -1, get_xinuse(env), -1, 0);
+    do_xsave(env, ptr, rfbm, get_xinuse(env), -1, 0);
 }
 
-void cpu_x86_xrstor(CPUX86State *env, target_ulong ptr)
+void cpu_x86_xrstor(CPUX86State *env, target_ulong ptr, uint64_t rfbm)
 {
-    do_xrstor(env, ptr, -1, 0);
+    do_xrstor(env, ptr, rfbm, 0);
 }
 #endif
 
-- 
2.34.1


