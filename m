Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2D2C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 18:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmFWn-00024t-5y; Tue, 21 Jul 2026 14:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUz-00017n-Ey
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmFUx-0006hE-4Y
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 14:47:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-848643382fcso12755648b3a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784659641; x=1785264441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NhK2v74jPl6sco11TVadwgtLgP0DbJfsGnTVqcg2MGY=;
 b=yZmVTpBX6UYp6hpvtMaBDacNy7UkDCt6xoAYXGnrair9GFmXc94NH4e56PvbII1ns7
 Yeh0xMbdH/UhynR9mUqfJYRBrBkxGGlcP7Z2fiwuLeybd60Lgp79qM50ZaoAP7hYIUB2
 V/tobroENv/qhtbSTd7EuWq3GccqhQ1Vlsgn/Jow1Uz3TRY/kEiaR8m1qUa4mk5iOYzR
 knjtOz7dVEruh4EfUQu8CcxiwzmP2NxLMFiA6dApc2+E6EPurYLOvoRxmPqAuvZlkegw
 TAYHjpWaqr3bixuml20oLpBWEYxwJ3LWne0jYCRC+PC58Ni/X2UAgPv4OvPbL0VaCxC1
 CSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784659641; x=1785264441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NhK2v74jPl6sco11TVadwgtLgP0DbJfsGnTVqcg2MGY=;
 b=LPYM/EYH4Wuho7qqmFCAw5NObcTRpP2Ra3765nDdObUEDNNtmK9D95yfL1u9yTLdkK
 5SZEbJXR01bEees3G5ZIQwN6VKUYyOVhJEYqKKFW4jXio586m4Uu7aW1kKr4qM0GLbLi
 J1dGCqCYEn3rCnNm3+2cogVy3ZW6VEilJKrWvHzfGSiByfxodi3dMx6Y320D3h5RF2rg
 6pr5ZwdWqG+2Vm/BOTGSDWBE4STc538EWjw9cDGykTs4Hn/qSA5A0t4zDs2nA6x0n7qz
 MxpSRHtYzof3Qs+3RSLX618lPFMvBwBl/qkESaQTQYoGE3UVeMttUXpuCXc2yEaqnFVG
 6Kgw==
X-Gm-Message-State: AOJu0YzLi1COQXTZN/G6Avxqa4JBYMGxGyKD8RkkrEaHCwVBlgrCnS/G
 Txt3lI2It/PGHVMUP23cLGhAeJ960YUPYPwdMTf3PUHCI+z8beIHCXpt9Av6JLAM5kTK2hcNlrS
 fJLoj
X-Gm-Gg: AR+sD12YvKdEq7fpoQ9rb+4CG0ul9u5lMufXzeRKNjwCuvPEuA4dKB75xA6S2qz3AP4
 +T+6e1cqLyhTJtVIpqEPa7yYUYEMUot/OCPmbaBoznaEjOYAF9MxxmEmDJYMnZd1nQat+B4d66p
 r45CpGt5mZsgS6U0Qfh7fbsz0jTO0+A8K70OO6u/b3Qr0K8V+0X3KkisjuH6/dEkNUAH/01MgSR
 e/4fr9xM65F4Fjn6aOYm2QQJAoPyyJF8AFEi7E4tqwPhF94/nj+uX85jW+kIj3G1NH6KdHjuga8
 hH5o1xAjRrVVAJY9/zHxA1CK5O0ApfUgBgcbZ+an1tr7Ntlbz4MqjZ+23XvJdmSUkEtzNlrx24e
 E4fYaw34So9+I6JQ+5jNDrOdC2mhPvraRR+KuIzrKu562fYiF03r32XzU0e/z/hANNOifgk9fc9
 /eRVQUxLU=
X-Received: by 2002:a05:6a21:a8b:b0:3c3:a024:1360 with SMTP id
 adf61e73a8af0-3c3ad7a88b9mr22226712637.28.1784659641326; 
 Tue, 21 Jul 2026 11:47:21 -0700 (PDT)
Received: from stoup.. ([32.140.233.50]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29e340esm41108094c88.5.2026.07.21.11.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 11:47:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 18/20] target/arm: Implement AESDIMC
Date: Tue, 21 Jul 2026 11:46:54 -0700
Message-ID: <20260721184656.530230-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721184656.530230-1-richard.henderson@linaro.org>
References: <20260721184656.530230-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index 5ab89dc886..1d1f290f6b 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -462,6 +462,7 @@ DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesemc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesdimc, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_aese_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_aesd_idx, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index ae677cdf20..07d008c1be 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -224,6 +224,37 @@ void HELPER(crypto_aesemc)(void *vd, void *vn, void *vm, uint32_t desc)
     } while (s > 0);
 }
 
+void HELPER(crypto_aesdimc)(void *vd, void *vn, void *vm, uint32_t desc)
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
+                aesdec_ISB_ISR_IMC_AK(&t, &t, &aes_zero, false);
+                ad->d[0] = t.d[1];
+                ad->d[1] = t.d[0];
+            } else {
+                t.v = st->v ^ rk.v;
+                aesdec_ISB_ISR_IMC_AK(ad, &t, &aes_zero, false);
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
index fb809b905f..14378cf066 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8338,6 +8338,8 @@ TRANS_FEAT_STREAMING_IF(AESD_idx, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesd_idx)
 TRANS_FEAT_STREAMING_IF(AESEMC, aa64_sve_aes2, aa64_ssve_aes,
                         do_aes2_idx, a, gen_helper_crypto_aesemc)
+TRANS_FEAT_STREAMING_IF(AESDIMC, aa64_sve_aes2, aa64_ssve_aes,
+                        do_aes2_idx, a, gen_helper_crypto_aesdimc)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5832e0190c..7030d81db7 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1991,6 +1991,9 @@ AESD_idx        01000101 00 1 .. .10111011 ..... ...00   @aes2_4
 AESEMC          01000101 00 1 .. .11111010 ..... ....0   @aes2_2
 AESEMC          01000101 00 1 .. .11111010 ..... ...00   @aes2_4
 
+AESDIMC         01000101 00 1 .. .11111011 ..... ....0   @aes2_2
+AESDIMC         01000101 00 1 .. .11111011 ..... ...00   @aes2_4
+
 # SVE2 crypto constructive binary operations
 SM4EKEY         01000101 00 1 ..... 11110 0 ..... .....  @rd_rn_rm_e0
 RAX1            01000101 00 1 ..... 11110 1 ..... .....  @rd_rn_rm_e0
-- 
2.43.0


