Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C7EC25B79
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFj-00040x-Vl; Wed, 15 May 2024 11:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFb-0003wG-SD
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:04 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFW-00038U-Uf
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:09:03 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2df848f9325so87351321fa.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785736; x=1716390536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXRsFZySXvSqPrOv+ZAPgTOAgNl/fCJyejJjD81KENM=;
 b=vHZRRhiK5ZJPQVkd/qdRQTparGYylI6xjqRxT+SIGNYg1ZW92QRfSb9PLeT5QvETHw
 9+NbBTrL4RjQP0iGx1VqIsgVL3naL/n9hwvZ4LJ/DFtJFmdX0jEB9SLpZNyb21mIug4z
 pPA623Tg7ykH/OZ9LRuJ2MEiz0f3+LmpxKwcaZ/GQA2SKztWByk3XhnJpwfpFfo3lotp
 TQzg/8gR8YLdnnB5baDjmSpfHF6dfAOhvbgq8wjIkCv2n/cIkgSFmoXC9nUhVQkdWWpy
 fY6Iuf6Y+PgccbWsYKjcFYriq6tGT4rMlWyOqN4OjnD7QLJIwKbHTaEcNSMVYsz02Jxo
 4hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785736; x=1716390536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXRsFZySXvSqPrOv+ZAPgTOAgNl/fCJyejJjD81KENM=;
 b=dOl+W+qwWA9eav95b2qbPoopZrWV+oPcEbyJxavc2s98P0CHh7Ayeh9EmxGkdcqGcw
 GJAh3eaiASpyOAh3pPEkTZjV8hP5MvbasvT7XnhisFBxHnaK0x6MauTPKzAlA8RLyJqD
 kv/auwv/dtbKHi0to6lxYjhdVTODwsKfwLcWch1WiQ2/06hbnsqixzqRHJgoRaCz7pt3
 n3XXwq2kELwhhEwLaf781/CwROlmdsrXaIkitPq1Is2V9jekzPc3MG9doD/M6M5UozO1
 jXHaUAp9z6pFm34pmlk8LPHlO4rKL6hhwHBOk/1X3JfutEZAFeYmIFBZ3uGaObZ2micZ
 kLKg==
X-Gm-Message-State: AOJu0YzPJQmSxK/O8SZltU4wOxhpHMamcdh2byb6z85COnAvc6p8q3SX
 raEq1L3fkRC+siC9gqSLZDdwsPJeIAHjHTw4EAwl493LUfbGh7G3atbDSPtCg9jvPQ5goV6rI6A
 xAjA=
X-Google-Smtp-Source: AGHT+IHmrF5ihKcpvLTNRwCozhIbxkjzC8Cpktq2eLg9Q4BALgb66GS/F/XopQrwZ7zWKgfNZotE2A==
X-Received: by 2002:a2e:7e05:0:b0:2dc:bf5c:9648 with SMTP id
 38308e7fff4ca-2e51fd4b1f2mr115464991fa.19.1715785736240; 
 Wed, 15 May 2024 08:08:56 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 21/28] linux-user/i386: Return boolean success from
 xrstor_sigcontext
Date: Wed, 15 May 2024 17:08:30 +0200
Message-Id: <20240515150837.259747-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x234.google.com
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

Invert the sense of the return value and use bool.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 9e6d883ea1..03031ef9e5 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -530,8 +530,8 @@ give_sigsegv:
     force_sigsegv(sig);
 }
 
-static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
-                             abi_ulong fxsave_addr)
+static bool xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
+                              abi_ulong fxsave_addr)
 {
     struct target_fpx_sw_bytes *sw = (void *)&fxsave->sw_reserved;
 
@@ -549,19 +549,19 @@ static int xrstor_sigcontext(CPUX86State *env, X86LegacyXSaveArea *fxsave,
             && extended_size >= minimum_size) {
             if (!access_ok(env_cpu(env), VERIFY_READ, fxsave_addr,
                            extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
-                return 1;
+                return false;
             }
             magic2 = tswapl(*(uint32_t *)((void *)fxsave + xstate_size));
             if (magic2 == TARGET_FP_XSTATE_MAGIC2) {
                 cpu_x86_xrstor(env, fxsave_addr, -1);
-                return 0;
+                return true;
             }
         }
         /* fall through to fxrstor */
     }
 
     cpu_x86_fxrstor(env, fxsave_addr);
-    return 0;
+    return true;
 }
 
 static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
@@ -629,11 +629,11 @@ static bool restore_sigcontext(CPUX86State *env, struct target_sigcontext *sc)
         cpu_x86_frstor(env, fpstate_addr, 1);
         ok = true;
     } else {
-        ok = !xrstor_sigcontext(env, &fpstate->fxstate,
-                                fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
+        ok = xrstor_sigcontext(env, &fpstate->fxstate,
+                               fpstate_addr + TARGET_FPSTATE_FXSAVE_OFFSET);
     }
 #else
-    ok = !xrstor_sigcontext(env, fpstate, fpstate_addr);
+    ok = xrstor_sigcontext(env, fpstate, fpstate_addr);
 #endif
     unlock_user_struct(fpstate, fpstate_addr, 0);
 
-- 
2.34.1


