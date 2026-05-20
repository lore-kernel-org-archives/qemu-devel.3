Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A6BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgb-00018R-GF; Wed, 20 May 2026 00:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgZ-000175-0i
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:35 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgW-0003nP-8o
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:34 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dca4debedaso4640307a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251850; x=1779856650; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vlxXuOxT+NYJ7cIBM5cb2IVyDziWrmPqOCWZ9Z4002I=;
 b=bag9gsjonYQKvhNsQuTrLE4Z8XldlO8nXkjirBX8Lwd4PktNE/JznaooHuNYn6S+WO
 KVb3c6gHHBtgwaTLQabaMNYnmdBiIpE9tjrhNrjIu6Dc6nH9RQyPfJgwNfQccujlVio5
 Hz3ozrv6zGHXQujVLUdE9XnHatpZ72PJwGLWKQ4yFbofqAgsea+URVJchyhQQQBcxXOM
 PGboIBdR+JCZLi0rETdjY1394Vjw09bN2YS9YJ1SwDtY+yFjWP16QfiiZQK8BZDv+6iy
 98g7OMXV78ZwU251RTyVTccg2AuzytbYzY12e89/InlClLCYth83AFK2dGYrSN6SwM5w
 3uWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251850; x=1779856650;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vlxXuOxT+NYJ7cIBM5cb2IVyDziWrmPqOCWZ9Z4002I=;
 b=mPG9iqfDZx6Q8BMT54aRQTlF3KzVR3y9loqZmJNBb0ZtwrAc2cXwWvTPTLPamBcjLa
 858vPwABwv2On/KFTKWv8M1UNNnYmqdwh6b4FxOX1/LumEkMFV0vdFcOD2w5YYnGmaV0
 Q80Pva6D9NlLJCUNcuxVX3x85xrrVexevtAj5UBdVBeVaOdgwwmdhnN6cUhuR+KOFUSM
 vJ5r/EsuN/qbS1pCiHKP1RE0AnItCdlSwN9LOBTOS5YiaJbP/HJOnqi6IR4t+sbu1RTw
 B7Te2I32/8UxhCo4VIL/SLMTsQVcv0i1sJQVfeEiH4gwjbq4CnjntXy9xKUfvVLmXQyh
 zOHQ==
X-Gm-Message-State: AOJu0YxlSNXWijICG/QROLTjnwu/WfQ9+LdisR+QuGXH+jrreyQRXqAb
 m51zQPPY44eyx8pnZ9+zRZxyDNqgdm4aiZagWVuoiwFyRDtQNQTni8aw
X-Gm-Gg: Acq92OFbHZUAiC4GeiO305P6h8pIY+EOSlnF5wc8CPn4DbSOjq8JiEzZbtexKkzQRsR
 HQAoDWThj5FqNHtncJZv3Gzhsx+x+MNJsm/UYlAU+1qo2a+XoHW1MkSPZlAXGyTcBTSDOp76c9X
 WWNIOoSCDgIolUc6uavd+ZeblPp+rLDnWeE0ev754slPlGWmjK1zqFt8aKME9IxHZ5+HmwqSumM
 0iATXeOMmQPtrro3OIX3aoHkvNoUYKADP5AESiEGkFBQjBhMWTNIPWHEbg3W2LW6un042RRE/AS
 K4/NpAfc+1BD8VYxygVGDaWkE0JnW1nDTizvkMcMHV8MZNPMmdnwYKM3hs7l/LC8NXykGtoAUHM
 9yqMZd5gZSL+ldRVgA6eZKpqLUfLqyHu0aNOB1j4kpxFaZTJ/bec7rzJMeM0iuiXtz2X7w9kPBa
 sI7xkf4wzxoAh30kcC4g4VMnuXVGt00Z9BiuOVZmNtPT5elGfooFIzRTRpfoXxCsI0jFsO8H1kJ
 Og6h4gzHVmFfSFRHSABxnhRYNGYJD8wpKMp2jbG9u1LcELj+rnWumlVoW+54azwFc9l
X-Received: by 2002:a05:6830:498d:b0:7dd:e032:3cdb with SMTP id
 46e09a7af769-7e4f2bcf0e1mr15503726a34.18.1779251850137; 
 Tue, 19 May 2026 21:37:30 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:07 -0600
Subject: [PATCH v10 13/45] tcg: Introduce tcg_gen_addN_i64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-13-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32b.google.com
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


