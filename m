Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F02C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 03:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRO0O-0008Vk-3g; Tue, 09 Jul 2024 23:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0I-0008EA-CS
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:27 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRO0C-0003it-W2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 23:28:26 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-25e43dda1edso3116553fac.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 20:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720582099; x=1721186899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQDbI4dQxYEiVsf1Ot0F1qRfAVSgABx3q3P9I7cC36g=;
 b=DmIFafITphyLYyXsvtquB1jVCp5pxicObUhFIqTBofT1+CwuBxvWDCnPP6GDjFH7GN
 nY9IxStXU6vnBc2ihI7hRs226qPtcUT/gBXDjFJbIhV8OOlsr2VZQNzAC8XrXpriqwgI
 9dEZ8JZkiHJ4EGoGJ58HbUWY86WUCMyMjB95Qk3YYDkuaZXu7OcYA/t283zqfGq8KET2
 Cdx+qdD+DTDid/Y84EQUqKvkayCGdYq69fLtr4C7knLB0e9SlOQVx11OUjfko9zS3aTc
 xCrPhBWw1+4C6KY4aHRiZmRqmRoQsLgQnYMftejbQUzWF6ZhHI/0QIjbJofo7aOLf/e2
 se0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720582099; x=1721186899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQDbI4dQxYEiVsf1Ot0F1qRfAVSgABx3q3P9I7cC36g=;
 b=EhGQZMH3jCtuRpFfVl5FCNDzRgZskb+ws9l5mK6eXmI2AnttIeKcdd3EtIh1l3D/RT
 Royn26otDA6uWUwixxDZ5zUuQ6AvJS3BYKQ9aIHBLM0h5vnxslkGJavlzLB0SN8qcRwI
 CijmLE5DnY85NY8QU4UV3S5fvGfw30418GEdLqcRMKRHIXolPCzD0u3GADuCe6VZhyzD
 1tqNGuae+YfXVfF8NFqvzIPJ2L6Lmc3abQUF10Q2A3Pj6bfp5J7gXyID9z+R6KsF4UiO
 xS3jfM7aU+AIIkK2Ym9T+VhFge1uJp7xu4q/HkjY6vK10DUTm9h+S41TGUUDrafeGW9b
 gqZw==
X-Gm-Message-State: AOJu0YwQiMopT0SCNJFZFD0qkqRyUG4KiOavxCiphsV+I1A+4NONvibO
 2bFnlAuodYMl4UnQ+V5PdB7nvWowkGb5Db6hLl81k0LMW1CVn/J3YGRci+bBhh05/7RIGVslav9
 u/FY=
X-Google-Smtp-Source: AGHT+IFhWSFuP17FBVNgne4GduySXUU/b2J+3ZRTV0xsyDjzJNnzbm6PzbM31m6mZXHK+xG03NNa6g==
X-Received: by 2002:a05:6870:f71d:b0:25d:f28b:74b7 with SMTP id
 586e51a60fabf-25eaec16f3cmr3749063fac.40.1720582099181; 
 Tue, 09 Jul 2024 20:28:19 -0700 (PDT)
Received: from stoup.. (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438f5679sm2687280b3a.90.2024.07.09.20.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 20:28:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, max.chou@sifive.com
Subject: [PATCH v2 03/13] target/arm: Use set/clear_helper_retaddr in
 helper-a64.c
Date: Tue,  9 Jul 2024 20:28:04 -0700
Message-ID: <20240710032814.104643-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710032814.104643-1-richard.henderson@linaro.org>
References: <20240710032814.104643-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Use these in helper_dc_dva and the FEAT_MOPS routines to
avoid a race condition with munmap in another thread.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 0ea8668ab4..c60d2a7ec9 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -928,6 +928,8 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
 
 void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 {
+    uintptr_t ra = GETPC();
+
     /*
      * Implement DC ZVA, which zeroes a fixed-length block of memory.
      * Note that we do not implement the (architecturally mandated)
@@ -948,8 +950,6 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 
 #ifndef CONFIG_USER_ONLY
     if (unlikely(!mem)) {
-        uintptr_t ra = GETPC();
-
         /*
          * Trap if accessing an invalid page.  DC_ZVA requires that we supply
          * the original pointer for an invalid page.  But watchpoints require
@@ -971,7 +971,9 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
     }
 #endif
 
+    set_helper_retaddr(ra);
     memset(mem, 0, blocklen);
+    clear_helper_retaddr();
 }
 
 void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
@@ -1120,7 +1122,9 @@ static uint64_t set_step(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
+    set_helper_retaddr(ra);
     memset(mem, data, setsize);
+    clear_helper_retaddr();
     return setsize;
 }
 
@@ -1163,7 +1167,9 @@ static uint64_t set_step_tags(CPUARMState *env, uint64_t toaddr,
     }
 #endif
     /* Easy case: just memset the host memory */
+    set_helper_retaddr(ra);
     memset(mem, data, setsize);
+    clear_helper_retaddr();
     mte_mops_set_tags(env, toaddr, setsize, *mtedesc);
     return setsize;
 }
@@ -1497,7 +1503,9 @@ static uint64_t copy_step(CPUARMState *env, uint64_t toaddr, uint64_t fromaddr,
     }
 #endif
     /* Easy case: just memmove the host memory */
+    set_helper_retaddr(ra);
     memmove(wmem, rmem, copysize);
+    clear_helper_retaddr();
     return copysize;
 }
 
@@ -1572,7 +1580,9 @@ static uint64_t copy_step_rev(CPUARMState *env, uint64_t toaddr,
      * Easy case: just memmove the host memory. Note that wmem and
      * rmem here point to the *last* byte to copy.
      */
+    set_helper_retaddr(ra);
     memmove(wmem - (copysize - 1), rmem - (copysize - 1), copysize);
+    clear_helper_retaddr();
     return copysize;
 }
 
-- 
2.43.0


