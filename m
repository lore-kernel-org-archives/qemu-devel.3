Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7B6C4452D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFWq-0002Ch-SC; Tue, 21 Jul 2026 14:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUx-00017T-L8
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:25 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUv-0006gs-VO
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:23 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso4428717a91.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659640; x=1785264440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sL+rE8bzClQp41r4HP9i0GOM/CIvCebJMLV9vj+gMvI=;
 b=F9aOuu5xMvWGeVs0RIppG3LgYgGr7dzUAfrlWZYQIrNHwDJ2Zh1oOfi3nefff2mlcR
 DovDablKyLAjn9zzXvYUREHNFyNqtwDQRhGHa9ldbR1zGK11zUuo+eaUSY3vVVfox9Fh
 fWOjisA3WeAu7NfgvHyQ1GCfcJJTHZZ77RA72xJUhU9UnEh5xXVYKJKh0N3S0qyNlmVv
 739VxRXjtgdLuWvkU6y4iLVZWkJnDi1QEa+jbkbrdgN1pkWRQfS6tBrgUR6FTLpXI88t
 mTqsPYHkEBQ+u25PQnaS6A/J6UoRTZy0blcZrsUerl/hN5ecjQPihsm45jHuwdBvuR3f
 ecvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659640; x=1785264440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sL+rE8bzClQp41r4HP9i0GOM/CIvCebJMLV9vj+gMvI=;
 b=COSMsVKXyQqZWsXDUmCIXjhG8YJ6WZWB3tGb/AOcF9I+fT9344z33nZfCP6tZx2OXi
 36tC/PXRPJ7/DBlGwmo/DIJOmJCSVzz8HrJNoBId46i3WB0imZfALG5Na3kdjwaJK1ZQ
 6+cm+nkoii4euZC2dl3krz9pHOsYXnUPIjlQ7le6XuuAuoRcVXunIPymfyMmE18cfIy2
 zwnkNjDLcw4LUqFtT72JUKVvMjnDR6zAcgEm81Hc9GdNXjlyk/BpvW58PiCWgis0+ULR
 BMWFSmFjM+k/VMUYdPP455qfpPKtfUZXGWswcf3lyEe+er5CJCsOHGp8n1Fi4ofWibsl
 cS2A==
X-Gm-Message-State: AOJu0YxqCOF+Irr7vaeYD7eTC/8Z8sYARnoi3Ogo4GhJulWsXfNt0blR
 uA+g93ATEoMMEYDCIMq0jGp2Nl0LCyk+epCTYiY3Skz+7J3WAUeT57y4uP9iACMTQRxwFgJjVMr
 V4ZVf
X-Gm-Gg: AR+sD10i52R57pVV0YVOjnHQW6xkG/mtRDwMbl7BX8dOI2j2RLGRuyLk/n0Z249b9MM
 fZumAhQ2lRx4qNiQRR1OW5tRKV3sU7EClc/M8aRpB6CX0OLMtZyWbrSabBcrXt3gNpuzzDN0/vi
 VKgsIcQpGdvDi+MCglr3mniGdVjdCUF8bdw8Cm1Abwv3WM/mBVWiw1FMxBy79zVSsm/sX9hxfG5
 8zz97L5UjOGCYZmfKlhLam8Cew9CqVKnjk8yDqrWdzNOj7fbUUvKkQxEJtbCYRFpfYhY6nenA5R
 PawbNRQ36k+n4jBR+O+XWbHSacpKJKWzg4o5X4DnWpS77fIbYgkTV2Li5GB/bWhWpjrQ8v1He/a
 qEp2AE83c6PQiwKOXiLOpm35+IW0kT/kUhQCGIPzfe+6ffP/97lf9f/wOATxSfUgQfl2zhKA1qP
 abftx74jE=
X-Received: by 2002:a17:90b:2c88:b0:381:10a3:8b10 with SMTP id
 98e67ed59e1d1-38ea375f22amr660291a91.14.1784659640350; 
 Tue, 21 Jul 2026 11:47:20 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/20] target/arm: Implement AESEMC
Date: Tue, 21 Jul 2026 11:46:53 -0700
Message-ID: <20260721184656.530230-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/crypto_helper.c | 31 +++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c |  2 ++
 target/arm/tcg/sve.decode      |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 3719487754..5ab89dc886 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -461,6 +461,7 @@ DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesemc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 05f193b3d1..ae677cdf20 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -193,6 +193,37 @@ void HELPER(crypto_aesimc)(void *vd, void *vm, uint32_t desc)
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
+void HELPER(crypto_aesemc)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t opr_sz = simd_oprsz(desc);
+    intptr_t idx = simd_data(desc);
+    void *vm_idx = vm + idx * 16;
+    intptr_t s = opr_sz - 16;
+
+    do {
+        intptr_t base = ROUND_DOWN(s, 4 * 16);
+        AESState rk = *(AESState *)(vm_idx + base);
+        do {
+            AESState *ad = (AESState *)(vd + s);
+            AESState *st = (AESState *)(vn + s);
+            AESState t;
+
+            /* Like above: Arm AK comes first; api AK comes last */
+            if (HOST_BIG_ENDIAN) {
+                t.d[0] = st->d[1] ^ rk.d[1];
+                t.d[1] = st->d[0] ^ rk.d[0];
+                aesenc_SB_SR_MC_AK(&t, &t, &aes_zero, false);
+                ad->d[0] = t.d[1];
+                ad->d[1] = t.d[0];
+            } else {
+                t.v = st->v ^ rk.v;
+                aesenc_SB_SR_MC_AK(ad, &t, &aes_zero, false);
+            }
+            s -= 16;
+        } while (s >= base);
+    } while (s > 0);
+}
+
 /*
  * SHA-1 logical functions
  */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 340ed7d975..fb809b905f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8336,6 +8336,8 @@ TRANS_FEAT_STREAMING_IF(AESE_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aese_idx)
 TRANS_FEAT_STREAMING_IF(AESD_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesd_idx)
+TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aesemc)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 1ab1b4042b..5832e0190c 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1988,6 +1988,9 @@ AESE_idx        01000101 00 1 .. .10111010 ..... ...00   @aes2_4
 AESD_idx        01000101 00 1 .. .10111011 ..... ....0   @aes2_2
 AESD_idx        01000101 00 1 .. .10111011 ..... ...00   @aes2_4
 
+AESEMC          01000101 00 1 .. .11111010 ..... ....0   @aes2_2
+AESEMC          01000101 00 1 .. .11111010 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
-- 
2.43.0


