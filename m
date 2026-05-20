Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFDBCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkZ5-0001Pm-Tq; Wed, 20 May 2026 13:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYy-0001Li-Py
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:33 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPkYv-0001uH-OM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:18:32 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3665a90bcd3so5404899a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297508; x=1779902308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFuftV4ssvx9bSSs5jnFr2ka5o9L8dvlbwyKZe1RxvE=;
 b=kj8+x92AyOKbSJX2QXiHlCpo+7K5tO4XuM8Wtgzf4W1/6HBcR+wCoWrxJ++Ii9n/WN
 oSQXUDmXw7kQOcNrN7E+W/+GKxu30bp5MwXE6JCens5gAdIb7MLC5pMvgW4WG60Zz9nK
 cgIZ7GdrdKYe8uDT4qmj7ZzPnmNX8O3lPezvRSiZTNJQF7VCbsRcgh64KRu76HDMp8S6
 A/nSvKEEZRirO/ghuWzBOU+F12MDsHJBtWHFptEwu2NdDXupaBgatnHzlr9aXGE9YftD
 dLQb0dlZLbfmkhvedNDgUpZZo6RZAFBtwJDebVxRkYZaPxXdNokvIQxx7uVdV0YRAJ4D
 ftlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297508; x=1779902308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eFuftV4ssvx9bSSs5jnFr2ka5o9L8dvlbwyKZe1RxvE=;
 b=jccWCzWOKfthA4zyTgeq29dYVeMAzUGVAGS54dcgjFAHXwHeLsGi23dJb2mRUrr271
 VCdpVISgKdG8ZnENZSxIxNDcx5VUAFgq1tdYh3zCdr2He1f/35Loz8ASLZ/TXns2zVtR
 EXXUDoh/DtAJoKVtC/c3px0ojUcd5cTvrT/UjkfZXdicRAVm7wYe6HOrhEBMOD6+j+/t
 Ct/nXTeQnhcgW2WGeDVd4ZBDIzkO6SXgbbpTgLR+KUmLJALvl3H70a0kO0H5ry47EWPP
 RFqWnmYFTt1ekIFoYYn2Hj2h+7p0nZ1FGNB5/yT8h5K7JDI+Q7gNNklXWTHwL2I6tNRA
 BStQ==
X-Gm-Message-State: AOJu0YzljtEp8Kx/TwzMNBdF9gXQ3l1g9FSGXo6BlOcrn8jacou8v0NV
 5MrlpPECyFXi2IbIUxq1Xif08HF8k8UcTLkyhqibVJVpFx/Q6oc7BIqZ8fSwyKwbacmN3txs6ZJ
 aYqV3l+g=
X-Gm-Gg: Acq92OHgKsCtqwoxVdYRS/At9CgE5k/iCE77oBN2EvblYNbG9WBb+JDJAHpHEFv92u3
 FS1rDJ4tUQiNTloSZpUTuCStNLOH6pj/otdf3Bk5aHSMDQG9qLDlEaPiDkQO3LbP2bYxsRIP2AI
 ct+DHDFpZ11+6FeTTskZ4KYR4sAhceBe2r0HT4+02Hl+bPT5K3sPhZN6fPQk41ahjaKUHtxNoRj
 J6oxarHvb+cBKHxet8IaRiYKoi4NEPclZ2hEuiCUSYXH+V0voxtYvXrIwkWRvl4UryS2a5O2xI9
 8odKXQFffLOhbe3/oOsO+IJfz54Zmc47IbsP4pXCs5sjGmZFQq7daEulmPpr6jvVYjYpmAtYj/P
 ItCWJXNPzlEuCc9mqYAWtqo/G6bg6k9vb0+dnk5uS47l5SvyWsHTCqq0u/2yM9gkOjV3zcwgX8r
 /yI/KfFbr8jDTZYxqfdPnxbU3biPsy
X-Received: by 2002:a17:90b:5385:b0:369:de03:29c8 with SMTP id
 98e67ed59e1d1-369de033084mr12519454a91.23.1779297508269; 
 Wed, 20 May 2026 10:18:28 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm254416a91.0.2026.05.20.10.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:18:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 09/30] target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
Date: Wed, 20 May 2026 10:17:59 -0700
Message-ID: <20260520171820.848839-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171820.848839-1-richard.henderson@linaro.org>
References: <20260520171820.848839-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Don't peek into float_status internals.
Fix the helper calls that were missing an argument.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index d2d1467a81..c66e3f9c14 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -34,7 +34,6 @@
 #undef  HELPER_H
 
 #undef ALPHA_DEBUG_DISAS
-#define CONFIG_SOFTFLOAT_INLINE
 
 #ifdef ALPHA_DEBUG_DISAS
 #  define LOG_DISAS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__)
@@ -578,15 +577,7 @@ static void gen_qual_roundmode(DisasContext *ctx, int fn11)
         break;
     }
 
-#if defined(CONFIG_SOFTFLOAT_INLINE)
-    /* ??? The "fpu/softfloat.h" interface is to call set_float_rounding_mode.
-       With CONFIG_SOFTFLOAT that expands to an out-of-line call that just
-       sets the one field.  */
-    tcg_gen_st8_i32(tmp, tcg_env,
-                    offsetof(CPUAlphaState, fp_status.float_rounding_mode));
-#else
-    gen_helper_setroundmode(tmp);
-#endif
+    gen_helper_setroundmode(tcg_env, tmp);
 }
 
 static void gen_qual_flushzero(DisasContext *ctx, int fn11)
@@ -609,12 +600,7 @@ static void gen_qual_flushzero(DisasContext *ctx, int fn11)
         tcg_gen_movi_i32(tmp, 1);
     }
 
-#if defined(CONFIG_SOFTFLOAT_INLINE)
-    tcg_gen_st8_i32(tmp, tcg_env,
-                    offsetof(CPUAlphaState, fp_status.flush_to_zero));
-#else
-    gen_helper_setflushzero(tmp);
-#endif
+    gen_helper_setflushzero(tcg_env, tmp);
 }
 
 static TCGv_i64 gen_ieee_input(DisasContext *ctx, int reg, int fn11, int is_cmp)
-- 
2.43.0


