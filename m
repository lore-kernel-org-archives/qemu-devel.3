Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7C7C25B75
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 00:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBOZM-0007HR-Nq; Sun, 26 May 2024 20:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZI-0007Cn-Ny
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:29 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sBOZ4-0003bj-7L
 for qemu-devel@nongnu.org; Sun, 26 May 2024 20:50:21 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-24ca0876a83so1543460fac.2
 for <qemu-devel@nongnu.org>; Sun, 26 May 2024 17:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716771013; x=1717375813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDDtUfw/mczHul15uHGYjteOGPBpu+USO8s2KogQRUY=;
 b=HoyXytj9WCZgFOFG/M+aGfS+1VXHTPPm0rZRZpOgL6Fs67FCC81CzWG7tYoZ2mlhsJ
 NNMlbhuuajZ4CzICywFFf5KFTLNhVFh6PFOZqV9eTqqnSV5wnhS8goy1b+08hRrq6vMA
 YuXNbb1REoq0JO0//gXsj1oEE/cP3vM2y36VtRO/AJL7TuNft0airRWIX67yR8zdKv6c
 /rc/eS/OBTcEdEgQb/ncniFMnImdr8zi5w09PV08kP04VaF82SVoNuFKUW7LzXVy6d3v
 5xjtjIyrqM4uZJdOo2MF0fsuR/tdR6Tb5UqbNjtUPe59+wstvBjiE3F+IvA2tY70djFu
 FE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716771013; x=1717375813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KDDtUfw/mczHul15uHGYjteOGPBpu+USO8s2KogQRUY=;
 b=VdbZxnEeAq9GPEGmUc7cAwejW5RQM0zj38DiOsudSjaCHVFSZx+qQlNxJv6F9uviBY
 IuCwA85kvcqI8Lm8q1MY73fMhNSTXzvcjDXYR/xmkfPUfrJJwjjNAi1eZJAPgJ7AP+5g
 jB8GLNz8VFNe2hJ3hhcn6Qcmm+rucoa789JcwHrp4C+VSqph2kevCBlYx/zKHylGpKp2
 Q0wSLop/CINLzNUda2jQdObCCZdC+qjtBANfiSOHWqoUNVq1esZGRn8SSF6cSz66o3ct
 KCWgQEmzVOwX+3ekZO37aafDTaVTHWt38WlblBABfKXs8M+MRjmkTfMsnJN2VHX8x0BZ
 uH5w==
X-Gm-Message-State: AOJu0Yz4eYe/dL6zKPmC6B1ip7LWUcUjb+V7dd41Cw//ixXU1FbVNRX1
 6KppuUKYSUdOzMh1WcBMgw/07D9u7v1R266/eEA7qgXm0VgsRw3+i4BfrXCHAXgnD85M/2jxfeJ
 x
X-Google-Smtp-Source: AGHT+IHcvxjoPG6RlxuIGkSqQOefTKWyBOWG9M7lPAXlszNIqFXmhhSRoWgU2+umFDxfuJIGCMMLSA==
X-Received: by 2002:a05:6870:472c:b0:24c:b2d9:77af with SMTP id
 586e51a60fabf-24cb2d9a877mr7671954fac.19.1716771012979; 
 Sun, 26 May 2024 17:50:12 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fd6d7598sm3942958b3a.220.2024.05.26.17.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 17:50:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 13/28] target/i386: Add rbfm argument to cpu_x86_{xsave, xrstor}
Date: Sun, 26 May 2024 17:49:46 -0700
Message-Id: <20240527005001.642825-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527005001.642825-1-richard.henderson@linaro.org>
References: <20240527005001.642825-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index c500a69a69..91170a088a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2262,8 +2262,8 @@ void cpu_x86_fsave(CPUX86State *s, target_ulong ptr, int data32);
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


