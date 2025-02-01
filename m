Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E223C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGYZ-00074j-2f; Sat, 01 Feb 2025 11:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYV-0006v9-NP
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:15 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGYT-0001HP-Oz
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:41:15 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so1894840f8f.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428072; x=1739032872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SCTbhiF3A7AJCYL2Q+XbQocI6/g0fpw4SDujjhwaC4A=;
 b=eXflEHYjr2pz07NrWAP06b7PEc4h/MJ04DVBrcqKWKOmcBzmDa4hPIn/MDoVTofB+M
 xnpRPqA2Tl5YUVzXpzqCnc3xH6DNsqFidYd8xBA96NneHj+wrezA1YpRpzav+5vzOtLG
 byMp8K/zGXoFtLN0Bi3Vw/Ser1wdv7NUfUQte6e+QHUOJA5HmEO/7TLh/Uel1KZkWkj9
 lwVqEOQlw/4Pm3rPqCHwEWAZE2HB4NvDST5TuaAVISNZx7RnBX2pT1h/7fTcrzXsX1qc
 tQ8GKU9LF+befBxxgzAIEexMpuLv46vTUZREeGG9SmAieiXgJKhK+5TDKdvgcwpgNqNK
 c6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428072; x=1739032872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCTbhiF3A7AJCYL2Q+XbQocI6/g0fpw4SDujjhwaC4A=;
 b=XGAQGbHUnQ6Gu80wVA93xZzzVAwRbqCp0IZezbEnQ+ZLfXevgfbQ1ihdxJxeljOtDW
 K/sf/XxAMqdfSrf/46raxy9HNczGSH4GC7CbCtGMu2iJxlS9NUszBhqipKYlxnaHEx28
 py4tR6k3kcmU1D9KCTGeDPGrpXRQoAj+pjjj2tRSJ1M/YwOZj07Z2AqA/Z/fbo1IIPdo
 KyhWfJgRRCRgtDhsg07oMsdoSCe68wnrj46C8o5kIQOs/Wiy1deXJtRoxwz17zuFNTqN
 p42OnweosS4vUtrR4yHnnVt0cjov4bSp9bICQJ+f7SyESF/XvzYKIOUafqnjiMe8JPC5
 wXAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhvDFRmxmmLo77i41bFmeXUxcW37LMsMq9WNAFINiDiD/RIBBgsrWf7ZmZIj/3ZJrZz/TYsGyfFVqs@nongnu.org
X-Gm-Message-State: AOJu0Yz59EKf5Bdaw/XlLDxLj6LzVeIqoa9ZzW+0EtYrXDqewNjVMj8d
 LmbrBS4DF8k5QccZAKGSEdK3k0VCcWPlQRUbTQPPI0tcXE6XgXFml+ZNaxwgxqnTZVhrCBEpRil
 M
X-Gm-Gg: ASbGncvjw3gdo2YIoQscu+RPJ0dVYRHKQzBiB0mn7W982k9OJl7jY29GVF2wgwQcyBz
 sSIVELFD2fvU5pGypzGYUHxirZxyNB0hYGu07maVFwHMP0gMBsj1/ytU/H28QAM6EguALoAzNlp
 avKEqB2zvipLMBtdM8IAEe3YJUF+EiUpt63mFfNdDkyksGY05DyTzsm/N0pYZePNgMIVrKOq9vG
 oNDlMc16xzzjD69/EDYDK3Ee0wRTh4L429yY16eSS7/SE5AX0fDUxUdTG+vgS016SWjSDnR5qSd
 cYGhnJEhPCME3sSEkt+Y
X-Google-Smtp-Source: AGHT+IHbPFn0rT/zXo5d67VK+6gatKvbETSA6R+FCx/789N5xqbLnnK0lHFKnOL4+cw4X9rjfab8vA==
X-Received: by 2002:a05:6000:1849:b0:385:dea3:6059 with SMTP id
 ffacd0b85a97d-38c52097553mr13333620f8f.49.1738428072304; 
 Sat, 01 Feb 2025 08:41:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:41:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 44/69] target/arm: Handle FPCR.AH in SVE FTSSEL
Date: Sat,  1 Feb 2025 16:39:47 +0000
Message-Id: <20250201164012.1660228-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The negation step in the SVE FTSSEL insn mustn't negate a NaN when
FPCR.AH is set.  Pass FPCR.AH to the helper via the SIMD data field
and use that to determine whether to do the negation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: squashed in RTH's fix to use float*_maybe_ah_chs()
---
 target/arm/tcg/sve_helper.c    | 18 +++++++++++++++---
 target/arm/tcg/translate-sve.c |  4 ++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 90d4defc0d5..bf88bde8a31 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -2555,6 +2555,7 @@ void HELPER(sve_fexpa_d)(void *vd, void *vn, uint32_t desc)
 void HELPER(sve_ftssel_h)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 2;
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint16_t *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i += 1) {
         uint16_t nn = n[i];
@@ -2562,13 +2563,17 @@ void HELPER(sve_ftssel_h)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float16_one;
         }
-        d[i] = nn ^ (mm & 2) << 14;
+        if (mm & 2) {
+            nn = float16_maybe_ah_chs(nn, fpcr_ah);
+        }
+        d[i] = nn;
     }
 }
 
 void HELPER(sve_ftssel_s)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 4;
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint32_t *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i += 1) {
         uint32_t nn = n[i];
@@ -2576,13 +2581,17 @@ void HELPER(sve_ftssel_s)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float32_one;
         }
-        d[i] = nn ^ (mm & 2) << 30;
+        if (mm & 2) {
+            nn = float32_maybe_ah_chs(nn, fpcr_ah);
+        }
+        d[i] = nn;
     }
 }
 
 void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    bool fpcr_ah = extract32(desc, SIMD_DATA_SHIFT, 1);
     uint64_t *d = vd, *n = vn, *m = vm;
     for (i = 0; i < opr_sz; i += 1) {
         uint64_t nn = n[i];
@@ -2590,7 +2599,10 @@ void HELPER(sve_ftssel_d)(void *vd, void *vn, void *vm, uint32_t desc)
         if (mm & 1) {
             nn = float64_one;
         }
-        d[i] = nn ^ (mm & 2) << 62;
+        if (mm & 2) {
+            nn = float64_maybe_ah_chs(nn, fpcr_ah);
+        }
+        d[i] = nn;
     }
 }
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 17016854d87..2dd4605bb2f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1238,14 +1238,14 @@ static gen_helper_gvec_2 * const fexpa_fns[4] = {
     gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
 };
 TRANS_FEAT_NONSTREAMING(FEXPA, aa64_sve, gen_gvec_ool_zz,
-                        fexpa_fns[a->esz], a->rd, a->rn, 0)
+                        fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah)
 
 static gen_helper_gvec_3 * const ftssel_fns[4] = {
     NULL,                    gen_helper_sve_ftssel_h,
     gen_helper_sve_ftssel_s, gen_helper_sve_ftssel_d,
 };
 TRANS_FEAT_NONSTREAMING(FTSSEL, aa64_sve, gen_gvec_ool_arg_zzz,
-                        ftssel_fns[a->esz], a, 0)
+                        ftssel_fns[a->esz], a, s->fpcr_ah)
 
 /*
  *** SVE Predicate Logical Operations Group
-- 
2.34.1


