Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013A4C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFU-0003un-NL; Wed, 15 May 2024 11:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFT-0003tj-IG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:55 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFQ-0002sk-Gk
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:55 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2e564cad1f6so64578881fa.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785730; x=1716390530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHnvCE4341fC3oXgYRXMWSd0dFv09lREaQY4UssVvek=;
 b=iwHhNd3m5H55qU+OscEesgNzaB213f05a1EWr+PmiVjr13jI1VP4uH8Xp4QMAS53Vx
 VXmllyGzg09dTZVHraOleZuSLQNU8n/uqyjf/KKsJUC2cBUhu8NLCVTWTZtZtIKaOPj3
 eHmzMA3d83Ezmu71rVd6rqTawKfKwSNvC4KqLYq6YWpfJefBnY5arR2yyG1WO9wqqxb3
 f8wOGHHHkPe1yPcOZOl3AvJD0TbK8kglaRujQF2A8Aut6b+APeA5rfGyLpwZNxBB8aPZ
 XiqsshbjECy2jyCDSvHTJUsoX/beqm9Chz8oX11tpwrz1sjUvGpMHrt9sjrb/3mJHsFx
 PW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785730; x=1716390530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHnvCE4341fC3oXgYRXMWSd0dFv09lREaQY4UssVvek=;
 b=lN2W+oXRFFlmj17bj9deM21/a2vVsdylLNcj/kFymWG4vFp3+biVxYtl2NGN9ydhU+
 ynFKw2QXUBxyVOdQCg9PJZytDl0F764lPFEL8mB1xJJlW+h5vYter/u/Td+PMEOFZyTC
 tL4u0CZoYuoaa+TltjOFBJsxwQWy6/5hHOsgNyg2axklz0UIGpumErLPcpf+uVTUwrfx
 fRj1P6mdHAXONY/RJvNdZSdkI+KApYL+QgACLloOwpqTtL6wn9xbbmiEcJMpZLeWHWxj
 AL+X21+VB8hhTuR5d4iYCdzbQMeURO0mVElwDLlhVMPylA/VGOQP/+Me3MwSHJ809tdU
 eICg==
X-Gm-Message-State: AOJu0Yyuq5DnUc70gKBsaKyC3ZtnC8MPgXnzJcuumVBjj1lk1W0Mn9Y+
 T0sS2SZT0n2dbO1gPXEoPCTmamXn6X3mSp+QIIy1M2QrZY3PUjhp1sQuCZpqhCM+wFmtZwoKgVc
 j/FM=
X-Google-Smtp-Source: AGHT+IFILKOxJekJvgcvh1tZ9BIMxFXSVFw2XkL7CKtbL6/BDsmusOwjwWIQN7mSYiMk/1NoJQ6ADA==
X-Received: by 2002:a2e:602:0:b0:2e5:3ea9:8d26 with SMTP id
 38308e7fff4ca-2e53ea98d95mr83109231fa.45.1715785729966; 
 Wed, 15 May 2024 08:08:49 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 13/28] target/i386: Add rbfm argument to cpu_x86_{xsave,
 xrstor}
Date: Wed, 15 May 2024 17:08:22 +0200
Message-Id: <20240515150837.259747-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22f.google.com
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

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/cpu.h            | 4 ++--
 linux-user/i386/signal.c     | 4 ++--
 target/i386/tcg/fpu_helper.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ccccb62fc3..97014b14ce 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2232,8 +2232,8 @@ void cpu_x86_fsave(CPUX86State *s, target_ulong ptr, int data32);
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
index 990048f42a..824375d42a 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -268,7 +268,7 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
 
         /* Zero the header, XSAVE *adds* features to an existing save state.  */
         memset(fxsave->xfeatures, 0, 64);
-        cpu_x86_xsave(env, fxsave_addr);
+        cpu_x86_xsave(env, fxsave_addr, -1);
         __put_user(TARGET_FP_XSTATE_MAGIC1, &fxsave->sw_reserved.magic1);
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
         __put_user(env->xcr0, &fxsave->sw_reserved.xfeatures);
@@ -569,7 +569,7 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
                 return 1;
             }
             if (tswapl(*(uint32_t *) &fxsave->xfeatures[xfeatures_size]) == TARGET_FP_XSTATE_MAGIC2) {
-                cpu_x86_xrstor(env, fxsave_addr);
+                cpu_x86_xrstor(env, fxsave_addr, -1);
                 return 0;
             }
         }
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 6a319dadf2..a09d6aaf07 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -3047,14 +3047,14 @@ void cpu_x86_fxrstor(CPUX86State *env, target_ulong ptr)
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


