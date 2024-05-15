Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B70C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 15:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7GFW-0003vT-Ek; Wed, 15 May 2024 11:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFU-0003uu-Qy
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7GFQ-0002x3-Ug
 for qemu-devel@nongnu.org; Wed, 15 May 2024 11:08:56 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-420180b58c3so24013275e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715785731; x=1716390531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E9ppc4CUToY/h7916Bi0wG7cWa/ImlZUPMW1khZFpk=;
 b=jPRg41Ye0GTS8oRQNmoA9gjxBKVITCjyOIFnUejiK2Ll/k1PUchiPo7rqC8j5zj4/i
 6pBgIb8Bnyl8Qe3pa/VMRA4N85RuCI/x2blFDbKKoZNbb5NM7a4Z9b2TiA3iuN5n7xK4
 IJYM7/32a1Btk9jQkQbohyIHFASp5BupNlCUOzHzcw9tAtsBjUef53qqWHy9t21HpAMl
 fb5twZmxgeSJ+jw1mQAD1HhJIdRBHGXBbhmDBOb084ik6I6wWQbQfmL3Rxz9uKFK8b3G
 FkjpiZAYa31JELBwFZK8STvH/JGhftoVWSILMFxTOeoRUSP2N1lJCwO/gy8SUL7ddae7
 eC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715785731; x=1716390531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E9ppc4CUToY/h7916Bi0wG7cWa/ImlZUPMW1khZFpk=;
 b=F1drADk93vIv2Ix/qNbrpTe4bgOKIM8YccXSRCnKY3He0UezVl0SQmsMcM3IlZSniT
 iirc6bn+Sh0g7IrtkmzLADPtCnzKLalHTlnAQBnsYFLPhrIh9oAzVMgfRgxGo6UbFp0Y
 xSxIFPX//if5YZTe5u+4USzSTX5EZi5vZvGn72Gyr1gKwI8ABv4ALkkdagz4Ot91DthS
 P5q8MFTIc/FMc1bDuLSDX0gkoKhU/MP97IcvZM4UPZMY5Dag4GvF89CI9ks2AfaSB0zh
 7UQr4tyVI7vt3N+hlqmpsHvxRYS/Eyh8i/pAwQ5moOiNzWzKfS9Aq3h/XpOs65VmsUGX
 hwzQ==
X-Gm-Message-State: AOJu0YweHjeH3xZzcJoe7x9mc3KyDq7pR+rtnHkK/42g3XGEuqemvz3g
 smjn8eYBoUT8jBeXyD6isAel+0kH8uRPq9a1y75XiWXCSWv50uxc1ck3rJvNH94R3oFA/jX5JdU
 YkOs=
X-Google-Smtp-Source: AGHT+IGD9eih2imN3ghIC5d4YPyESSWR1V85KAODBDmqb98vnKksL/uNJC4gB0gKDY5rFxk0fhJ9pw==
X-Received: by 2002:a05:600c:4f42:b0:419:f241:632f with SMTP id
 5b1f17b1804b1-41feac49273mr132397645e9.31.1715785731570; 
 Wed, 15 May 2024 08:08:51 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42013c5fa61sm132080825e9.40.2024.05.15.08.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 08:08:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	laurent@vivier.eu
Subject: [PATCH v3 15/28] linux-user/i386: Drop xfeatures_size from sigcontext
 arithmetic
Date: Wed, 15 May 2024 17:08:24 +0200
Message-Id: <20240515150837.259747-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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

This is subtracting sizeof(target_fpstate_fxsave) in
TARGET_FXSAVE_SIZE, then adding it again via &fxsave->xfeatures.
Perform the same computation using xstate_size alone.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/i386/signal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 824375d42a..89048ed069 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -253,7 +253,6 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         __put_user(0, &fxsave->sw_reserved.magic1);
     } else {
         uint32_t xstate_size = xsave_area_size(env->xcr0, false);
-        uint32_t xfeatures_size = xstate_size - TARGET_FXSAVE_SIZE;
 
         /*
          * extended_size is the offset from fpstate_addr to right after the end
@@ -273,7 +272,8 @@ static void xsave_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
         __put_user(extended_size, &fxsave->sw_reserved.extended_size);
         __put_user(env->xcr0, &fxsave->sw_reserved.xfeatures);
         __put_user(xstate_size, &fxsave->sw_reserved.xstate_size);
-        __put_user(TARGET_FP_XSTATE_MAGIC2, (uint32_t *) &fxsave->xfeatures[xfeatures_size]);
+        __put_user(TARGET_FP_XSTATE_MAGIC2,
+                   (uint32_t *)((void *)fxsave + xstate_size));
     }
 }
 
@@ -559,7 +559,6 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
     if (env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE) {
         uint32_t extended_size = tswapl(fxsave->sw_reserved.extended_size);
         uint32_t xstate_size = tswapl(fxsave->sw_reserved.xstate_size);
-        uint32_t xfeatures_size = xstate_size - TARGET_FXSAVE_SIZE;
 
         /* Linux checks MAGIC2 using xstate_size, not extended_size.  */
         if (tswapl(fxsave->sw_reserved.magic1) == TARGET_FP_XSTATE_MAGIC1 &&
@@ -568,7 +567,7 @@ static int xrstor_sigcontext(CPUX86State *env, struct target_fpstate_fxsave *fxs
                            extended_size - TARGET_FPSTATE_FXSAVE_OFFSET)) {
                 return 1;
             }
-            if (tswapl(*(uint32_t *) &fxsave->xfeatures[xfeatures_size]) == TARGET_FP_XSTATE_MAGIC2) {
+            if (tswapl(*(uint32_t *)((void *)fxsave + xstate_size)) == TARGET_FP_XSTATE_MAGIC2) {
                 cpu_x86_xrstor(env, fxsave_addr, -1);
                 return 0;
             }
-- 
2.34.1


