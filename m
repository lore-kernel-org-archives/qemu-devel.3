Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45A5CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4dq-0000T9-TL; Tue, 26 Aug 2025 21:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dd-0007pE-Tw
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4dW-0007cL-MD
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:07:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-770d7dafacdso3339156b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256856; x=1756861656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXUdqCkF+LYn22BhLyzjofcSNfXOcqV3+XqLF12lMmE=;
 b=nKcdtVmPJA+Dlh4W96IBj0DTKeJOWi3jetSUC6V87hA+97cSDYO+NCTXIS1ywrJ4YQ
 7n7deoZzuvS2XlGGOFILNfbhyOEY/v60cHGe+CrSMmL1QWYZzzTd3yeQAbOwqiOGQwEI
 tf3RYdBuSiiPBXBlypfbinM+5G9oZTKqvC1w0YBZt8F27YqgR0Tgv/qSr7W1dAWWikXf
 dOGwuZXDzJ0EQwdPej89h0Tc+20m6rgFmkV0ip60gLRvQ215/DqIcw2Y+0dO/WzOKcDp
 qnOem1Vw3roiRLHATIi4vB5K7jZruGkUvEbC8kZ15QEQWvMgYLA/uU9cSnOP4Nm9kK6a
 vEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256856; x=1756861656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXUdqCkF+LYn22BhLyzjofcSNfXOcqV3+XqLF12lMmE=;
 b=FQ+nwoHBe0EnnLPSmW5UDxGrqdkqhAjRN711e7EheqzueNVwRtmMl+PBPuouT5fO+p
 0d87CSleHbWhHb5f0rxZLmoIQQhAKqUGrTX6HvXggoNlJeVgfvwhnGicVz/qW81XAT7E
 H7qNOkiSGR5gYdWMaXvAAbCUfC6Q/rjtTMSsr6zVRGn+wPmKqBVXR0+FYNx0I3lY2fPI
 z2WGtL/j+auXrRD2kRrPrZMRIpr1ZhgOeoFsNo9BFQPXEQS4jQbkbgbgs/OLf8JnHKlV
 Lxd6ydZwbQ2LmfDN/XQYLZCHvEJ4gCknkOx9bkIOId5Dg6Dvo+HaEdzfpXCq65LzAECX
 7V8A==
X-Gm-Message-State: AOJu0YxviVi/suYoQh0o7b0cRH/FBfG7LJZJqnSst1JYCipldZDfQBVO
 +cpWsDdFzh+D4su6zxwzC6p4cuF502h2fDJubGcWPQHmyW86PKNdJAPxWWmVF1eUXrcJJHcbji6
 1HhPU7q0=
X-Gm-Gg: ASbGncuXj0t26t1biuuiToRZVOmFjE5Ip7C8TWiR+zhpOK/9rfHeVc/jFD5BpSCidXn
 a57XYvTDXfI5I5NmPgNEOJ+1I4Q6RxKRYGRDRajPfOh1OZdOizeDD9Du0oNPuwLZmvj1qqToqO7
 0lmby0Z4FR3tephB0NckXVJDz7fAfyztmngNi92TVrCVYvf5BqJST1JqRJjyxjjMvd+dj+I6D4P
 cFT2a6+u5ytOhWrHZeVuKQkC2IoFpbLAIiPHhn7ZiXKYuAAKBEvNpEJALYhJfzvHDJtd5RppgAQ
 RriFCLHstcv60zA8nDr3NLV0TyyQW2fNsKxnXUMtkZoGhLQvDuj3l8PyGi+rUE6WdmWtQU0Ghzy
 U42ENGsXnsd7eA5UyIEAPBP3vJd7jq00iclBm
X-Google-Smtp-Source: AGHT+IFf7ecdlminGXOBAydYbtK4duI+sSVUcfD5+Urj5l/NAJlkvs0mcElP4ltd85I9IUgbbqoCsQ==
X-Received: by 2002:a05:6a00:439b:b0:771:f8b5:d88 with SMTP id
 d2e1a72fcca58-771f8b51015mr6428666b3a.22.1756256856477; 
 Tue, 26 Aug 2025 18:07:36 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:07:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 28/61] target/arm: Move alias setting for wildcards
Date: Wed, 27 Aug 2025 11:04:19 +1000
Message-ID: <20250827010453.4059782-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Move this test from add_cpreg_to_hashtable to
define_one_arm_cp_reg_with_opaque, where we can also
simplify it based on the loop variables.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3cd4546494..1a321ad181 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7349,20 +7349,12 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
     }
 
     /*
-     * By convention, for wildcarded registers only the first
-     * entry is used for migration; the others are marked as
-     * ALIAS so we don't try to transfer the register
-     * multiple times. Special registers (ie NOP/WFI) are
-     * never migratable and not even raw-accessible.
+     * Special registers (ie NOP/WFI) are never migratable and
+     * are not even raw-accessible.
      */
     if (r->type & ARM_CP_SPECIAL_MASK) {
         r->type |= ARM_CP_NO_RAW;
     }
-    if (((r->crm == CP_ANY) && crm != 0) ||
-        ((r->opc1 == CP_ANY) && opc1 != 0) ||
-        ((r->opc2 == CP_ANY) && opc2 != 0)) {
-        r->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
-    }
 
     /*
      * Update fields to match the instantiation, overwiting wildcards
@@ -7665,6 +7657,16 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
                 ARMCPRegInfo *r2 = alloc_cpreg(r, NULL);
                 ARMCPRegInfo *r3;
 
+                /*
+                 * By convention for wildcarded registers, only the first
+                 * entry is used for migration; the others are marked as
+                 * ALIAS so we don't try to transfer the register
+                 * multiple times.
+                 */
+                if (crm != crmmin || opc1 != opc1min || opc2 != opc2min) {
+                    r2->type |= ARM_CP_ALIAS | ARM_CP_NO_GDB;
+                }
+
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
                     add_cpreg_to_hashtable_aa32(cpu, r2, cp, crm, opc1, opc2);
-- 
2.43.0


