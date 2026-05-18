Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE1BCD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYX-0007AL-UD; Mon, 18 May 2026 01:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYE-0006w0-7R
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY4-0003U6-UG
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:57 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-47cba53479aso1447119b6e.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082175; x=1779686975; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vlxXuOxT+NYJ7cIBM5cb2IVyDziWrmPqOCWZ9Z4002I=;
 b=dwMUillsuHFh8ye9x03t/CpYLjDVFPCEMDOzzMKTojvbCgmSd002/P3XTDs00yXrbG
 wPcvgEIDmsNGlW+yqegISSB0tdsjVrOtPym/LdqQ2IIId2McIwTucUhidDZNxO1PQ6M8
 NPKkf8QYuMG4ogY449UpAsTeaJr400zkvPGNlorJWRrgQ+zH0CrEuO7Lhsp0TZQe4bnT
 t1ihIlQ2beIg+uBV5AoyR/kdL2ZNZNdXJg6zhwq8uklwAb58bHx/ry3X7kYHk5wqxYE2
 ChGiRcOXnKQOwUu9dkSHTsQiMTqzrwWJaDfPzTZFVa30OOeJqHlj8P18xtYw4AHDnPnM
 AWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082175; x=1779686975;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vlxXuOxT+NYJ7cIBM5cb2IVyDziWrmPqOCWZ9Z4002I=;
 b=RCs27H4F2U4S0ACWm2HxG9noouYAN1JOXuNRR6m3piKRvMpMcydO2cnUCLW5l7RS0W
 DO1ILmMHJ2MSC7/WzfR7SoQ0BqNfiqfDxIMNTfdmTNchzWKD2GuQ2K2Jur8/3rDNc7x9
 SzZFeEQNyOYrSjpHEMOuos7jfa+TUCeC9GERf7fXwRs6XpoHIKpi1lmXz6Ag+V1+x4na
 HEoK0IFUwIeX+9pvJmQRPzbukA99MWNVS3Eqotax6DJ7282OlUdnH3JFaFBKRuvbH16B
 5Uyvt8DJAAtJpF9PSPx5NLh+kcGr8oFZvIhwW/46dFCgYMiXa+1S5cyATQnv9lfYpx8Z
 cI8A==
X-Gm-Message-State: AOJu0YyMqHM1MOtmhZ7TxPWLf4ZTSCo1tjkX/kMrqPlvxowzgtcGfo2v
 0xvZLITaqUzNTTqhrccox8B+XdaXGQxPe8OadMySQB+DJm1bn8yHIzL6
X-Gm-Gg: Acq92OGeRkNmIwi+DIzC4alO5K3QOOJEElapsoEvXkYBfDGAxYHFrtPQw+qo9NHItq4
 ubDazn4GqE6FWMVQY5z7+00vVyvbnmTgQudPMhZJgPz5XDou9TcxHul6TWomXOQJO4/Tn2gsIQX
 A2/Qb3Yap9mWNohrPS3ad705B7llFvh3ttNIH6L/w4M+yqodkjjZ/yHu0YEvjqAA4Zb5NRRHlDn
 kJddTQ3YdNtLBNwRTzXtRtrAX7Wew4pIDCQl9LfnOJQN1tpN+XQes1WQH8vnEj+TD6ni6pe4Xng
 gBuImoRlEVWvHKJdLtIlm3+4WWq+6yYePcE8zLndaNeac9vw60rWPVC+vyxwfkg5u9/2ygd4tO1
 uDoVqweItY6wJqbtR6hXg/BjQetwG3HMbXhpnutn4qVFutMeA63ZOdX8V7Y2CJ4SMihmw6BkrLm
 42Xm2xoFW/StrbTQzCWT6vF8GFzYVkaf5lHNhmRdxJxU60RzWi0x4311wkzHv4eo2+PAlXYF9Fn
 JnnggD3/nOrd0bu6HElgXXtJICtQ/kmwgu51Q859wLRR8uKTDOQ0M4BnLKa9Vv8XAUKQLM=
X-Received: by 2002:a05:6808:124e:b0:47a:ae7:b604 with SMTP id
 5614622812f47-482e5630bacmr9006732b6e.21.1779082175617; 
 Sun, 17 May 2026 22:29:35 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:10 -0600
Subject: [PATCH v8 13/35] tcg: Introduce tcg_gen_addN_i64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-13-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Add a helper for multi-limb 64-bit addition. The helper emits native
carry-chain TCG ops when they are available and falls back to explicit
carry propagation otherwise.

This lets target translators build wider integer accumulators inline
without open-coding the same add-with-carry sequence at each use site.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v7 -> v8:
  - New patch from Richard Henderson's v7.5 multiplier rework.
---
 include/tcg/tcg-op-common.h |  1 +
 tcg/tcg-op.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e02f209c09..ee0ad5f6a3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -251,6 +251,7 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
                         TCGv_i64 a, TCGv_i64 b, TCGv_i64 ci);
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d8ae57d604..28ef5bacfd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2275,6 +2275,48 @@ void tcg_gen_addcio_i64(TCGv_i64 r, TCGv_i64 co,
     }
 }
 
+void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
+{
+    tcg_debug_assert(n > 2);
+
+    /* ??? Don't allow overlap for now. */
+    for (int i = 0; i < n - 1; ++i) {
+        for (int j = i + 1; j < n; ++j) {
+            tcg_debug_assert(r[i] != a[j]);
+            tcg_debug_assert(r[i] != b[j]);
+        }
+    }
+
+    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_addco, r[0], a[0], b[0]);
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_op3_i64(INDEX_op_addcio, r[i], a[i], b[i]);
+        }
+        tcg_gen_op3_i64(INDEX_op_addci, r[n - 1], a[n - 1], b[n - 1]);
+    } else {
+        TCGv_i64 t = tcg_temp_ebb_new_i64();
+        TCGv_i64 c = tcg_temp_ebb_new_i64();
+
+        tcg_gen_add_i64(t, a[0], b[0]);
+        tcg_gen_setcond_i64(TCG_COND_LTU, c, t, a[0]);
+        tcg_gen_mov_i64(r[0], t);
+
+        for (int i = 1; i < n - 1; ++i) {
+            tcg_gen_add_i64(t, a[i], c);
+            tcg_gen_setcond_i64(TCG_COND_LTU, c, t, c);
+            tcg_gen_add_i64(r[i], b[i], t);
+            tcg_gen_setcond_i64(TCG_COND_LTU, t, r[i], t);
+            tcg_gen_or_i64(c, c, t);
+        }
+
+        tcg_gen_add_i64(r[n - 1], a[n - 1], b[n - 1]);
+        tcg_gen_add_i64(r[n - 1], r[n - 1], c);
+
+        tcg_temp_free_i64(t);
+        tcg_temp_free_i64(c);
+    }
+}
+
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {

-- 
2.54.0


