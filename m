Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D71E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBE1-00025n-V5; Tue, 24 Dec 2024 15:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDO-00068D-EL
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:14 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDM-0002wl-Pu
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:14 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so64890985ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070951; x=1735675751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fPgLDQ23uWllVbCL/m78hDFOj9j1qZde0rBMxog4xg=;
 b=eVZOz8ayP3P+S9SGhNNn3g92F7bj3Awi/rm6h3036jvWdl5UBZ4hes7bQ/gZdBNopN
 4kxnl41VbW3mDn29LF4nOHe8qeft6d/HAzkfq97gZGq8yK6x7WNQhC1uzPZ3L+VqUYYC
 zOSiYe3VqZVopViJKzhdEo0NQaMdHJuXKpZ66+BlmYsy7QiJMeHBNyHvredF5BBgQnol
 q7i0Suk2qVK2Et9MNJjS5FPU4zvgJ1EDOFm0vTz4Pq9Ky24A7r7UnMKt1jbqxFUWBmNn
 OcP3x03Ca2Qw7eEvVxN+jbrO33/bSacyB2n1XVFK7zMcx/QFzD8tRjDAFAnjaByrJQPR
 1MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070951; x=1735675751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fPgLDQ23uWllVbCL/m78hDFOj9j1qZde0rBMxog4xg=;
 b=td7vfqMZmydzk4GyatNpljtMiNtRIW/4n4/lPnjIJqYCPqUWFtHge+QuhXgDrmNCHb
 K6t1RTU5B31SF4TsAwHwXrj17jVVAapuWv81mJoxQhFLWmxr4OjYgPms3pV/nMk7kbYE
 s2uBeEPKqls+EFt+ubUGKnIQnA4SkSiLb4QoumgGhqZFrrT8rzxooudn3RA/ypatO7Vi
 9i0bji50Y2Cmkg0/XRyx8t2+kBvxQAg+K/giRXr+ZFduF87xz1liCtj82yFQAwImawEp
 LuZ11viiubDiJ0gu1rPnZR1lmVuIYp7xU+PsVuxIzxxfPP2YRjLZmDZ47b5O3hGU9PHN
 iSYA==
X-Gm-Message-State: AOJu0Yx8SqcqmnML3950GiOWyiyh8AYewjZzjWtiYxhwfBUYTkegLrqU
 Ub63Lc4PdQGuMYPVPZVBe+pXrlbMJoORt9n5lGEsgJ8Sx7jINPgcTeDC4TXpzdPFz99HgSWXNuC
 HsmU=
X-Gm-Gg: ASbGncsy6ACh9u3Y4p6E02CgkYujc5obh3SjAoJOA+0Kv1ZY7MXGFnEcoAi3ZAQAnSr
 BfMjDn1nmEeZq1JJzyX6jsYHMBQKtl9AAAVdLb+ZODtCST9DAR+yospgsr83z+pwPTUIyuc1B50
 qEgaQBDpaTPeIhcASm8MuiZXZUnuxQ2DG3BceaYbWwmBBJV0ER6PuQUIwIUKCeTlKg0cxtyknPZ
 JEbnK/FxCLmkjUOMVXG3SAy73jjSvjc/k+5gLvzCnN9qm+oedsMwRbtCtn1GrJ3kGNSqbuEUkGC
 rj5gCSjKzyUN9xAKDBQlp/c0iQ==
X-Google-Smtp-Source: AGHT+IE4I3sn2Kd1wD+ddDkwyR4BSrFAoepUNxkv6NRJancqTj3y4x152NzQONxzUBXKrAsO298rhg==
X-Received: by 2002:aa7:88cc:0:b0:72a:a9d9:55ff with SMTP id
 d2e1a72fcca58-72abdb0170bmr25230924b3a.0.1735070951532; 
 Tue, 24 Dec 2024 12:09:11 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 51/72] tcg/optimize: Remove z_mask, s_mask from OptContext
Date: Tue, 24 Dec 2024 12:05:00 -0800
Message-ID: <20241224200521.310066-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

All mask setting is now done with parameters via fold_masks_*.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 51cfcb15d2..98b41975af 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -64,8 +64,6 @@ typedef struct OptContext {
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
 
     /* In flight values from optimization. */
-    uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
-    uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
     TCGType type;
 } OptContext;
 
@@ -961,13 +959,6 @@ static bool finish_folding(OptContext *ctx, TCGOp *op)
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
         reset_ts(ctx, ts);
-        /*
-         * Save the corresponding known-zero/sign bits mask for the
-         * first output argument (only one supported so far).
-         */
-        if (i == 0) {
-            ts_info(ts)->z_mask = ctx->z_mask;
-        }
     }
     return true;
 }
@@ -2879,10 +2870,6 @@ void tcg_optimize(TCGContext *s)
             ctx.type = TCG_TYPE_I32;
         }
 
-        /* Assume all bits affected, no bits known zero, no sign reps. */
-        ctx.z_mask = -1;
-        ctx.s_mask = 0;
-
         /*
          * Process each opcode.
          * Sorted alphabetically by opcode as much as possible.
-- 
2.43.0


