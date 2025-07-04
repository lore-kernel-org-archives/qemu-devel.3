Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0286C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhId-00065h-Br; Fri, 04 Jul 2025 10:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhI1-0004mu-7v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:22 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhHy-0005Fp-VS
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:20 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so1315367fac.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638878; x=1752243678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnYIgTjrefVXMIwRpQeonLtnboMU7zvlsKEAzjPk3zQ=;
 b=XUPdBFsIZgcI1RQ0v4Pvquhrc+FDhTHrTE8SHMGwMidO7EZjcthjz6+6Dev2zOP4+/
 ZgP6nVLqq371IurKzZ+ANt+WG8mi1UmCKsDJypbAkVcYfIeG3ecAXidVVAJkyQUO9wES
 7P/GQMTQnmCVGq/LP7x0P6heiSM7f0wZM0e01ENbOy86OzFod3kR4zGgT/C9DJ3PkbWt
 72NQOCBIT0ldn+m611DDSEQSv1as+PuVxbzic+blVv/Sj9Wb8EoChNGkC8RbyDLtozrg
 8hk9FzHdsSXNL7/Ps21XcDhTR0t7lkdxV4B+jKADws9X+Vq+4qyx50i8Nh2YpP1PlRiG
 8vNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638878; x=1752243678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NnYIgTjrefVXMIwRpQeonLtnboMU7zvlsKEAzjPk3zQ=;
 b=s1VQSytdZDrfOK8kXkQ32cusevKWamSWtbsxAeaPZEy91aVIOIn/Ece+t98hdneWcs
 2e0kvgA4klIrTcNVVN57AZmng/UsWq2hCSjn2uNe69mBK1hQwBYXu70I8L1UR4ANqxAS
 xAiYe5/hMvpSnk+smXQa5ZzXjKGEBkRvuE3pPy4QtrAhKVx7nB4Me/w+REyZ4SL1HNwE
 a2myDLt0WeK07Xp0TWmrcZWkIDFwIHhDXGTzE3d7msxL119zS5CItznlnSr7YJGK7FbE
 MaLRgv0fWtaoOTXinlO5NWqEFEYtcAjNfdO5lxU5QQxYAaODurO27fHQYB8xX17ZJyFi
 oEJA==
X-Gm-Message-State: AOJu0YyrXBErIj9JSAmyIHx4B2huHHiiMGzMzw/w0cQRDZuDGw+c/41O
 MLbtDx7qR7eqC6UJoCLRiKK47QWN3lw2Yp9kiOaHKxgGvOAEmh1+hrfFBLRxtt16t0srj7mCAfa
 FMqYvI14=
X-Gm-Gg: ASbGnctDqae1vJeSRg0qVL/ihIb/0G4gYCpMm17tIbd7m0JCG5/FDI5k6PCgw2gvKZ5
 G3U9gzoCy/oFp2wQNSPoRzU5m8KLnkTMOrzr7SvG/mDUgDDu6KjZ7MXhk2GtMBwxO/nXAum0Zbl
 ETepxFWOhmc0sRDaQQ6CK6/uGJz4DYLVNPdZWBrKsIaXcYbaYTbmsPPHIHMVqfW1Q8oozHHUPTr
 cJ4KML2zEjL22L6WhKLqzMjYd/uAkWAUCM2MA8vyy0DLl9p9L3zI5R8GXPAW5cCffts/3nRbbyp
 dNvZ1zxyGAgQmMhoWPPCt5bR6IipvdPYhRhlrjyHn/YXoRQtRYGl12eD6CD1YekyXf2iopeHxjW
 kW7uFXS+1fBLwyEuojhM5eox7xyFkEm7H9qDWHjwYbrfGX5Kd
X-Google-Smtp-Source: AGHT+IECMTo9kT0/+J+3spD012F8Uh1nRALyK20xNw/wxu1LHn0o9eurWMQITqJCgDTkqEAbVAbKXg==
X-Received: by 2002:a05:6871:e706:b0:2e8:755d:b4e9 with SMTP id
 586e51a60fabf-2f791d772e1mr2080947fac.1.1751638877650; 
 Fri, 04 Jul 2025 07:21:17 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH v4 003/108] target/arm: Fix 128-bit element ZIP, UZP, TRN
Date: Fri,  4 Jul 2025 08:19:26 -0600
Message-ID: <20250704142112.1018902-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

We missed the instructions UDEF when the vector size is too small.
We missed marking the instructions non-streaming with SME.

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 43 ++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f3cf028cb9..588a5b006b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2352,6 +2352,23 @@ TRANS_FEAT(PUNPKHI, aa64_sve, do_perm_pred2, a, 1, gen_helper_sve_punpk_p)
  *** SVE Permute - Interleaving Group
  */
 
+static bool do_interleave_q(DisasContext *s, gen_helper_gvec_3 *fn,
+                            arg_rrr_esz *a, int data)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        if (vsz < 32) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                               vec_full_reg_offset(s, a->rn),
+                               vec_full_reg_offset(s, a->rm),
+                               vsz, vsz, data, fn);
+        }
+    }
+    return true;
+}
+
 static gen_helper_gvec_3 * const zip_fns[4] = {
     gen_helper_sve_zip_b, gen_helper_sve_zip_h,
     gen_helper_sve_zip_s, gen_helper_sve_zip_d,
@@ -2361,11 +2378,11 @@ TRANS_FEAT(ZIP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(ZIP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            zip_fns[a->esz], a, vec_full_reg_size(s) / 2)
 
-TRANS_FEAT(ZIP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a, 0)
-TRANS_FEAT(ZIP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_zip_q, a,
-           QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
+TRANS_FEAT_NONSTREAMING(ZIP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a, 0)
+TRANS_FEAT_NONSTREAMING(ZIP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_zip_q, a,
+                        QEMU_ALIGN_DOWN(vec_full_reg_size(s), 32) / 2)
 
 static gen_helper_gvec_3 * const uzp_fns[4] = {
     gen_helper_sve_uzp_b, gen_helper_sve_uzp_h,
@@ -2377,10 +2394,10 @@ TRANS_FEAT(UZP1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(UZP2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            uzp_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(UZP1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 0)
-TRANS_FEAT(UZP2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_uzp_q, a, 16)
+TRANS_FEAT_NONSTREAMING(UZP1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 0)
+TRANS_FEAT_NONSTREAMING(UZP2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_uzp_q, a, 16)
 
 static gen_helper_gvec_3 * const trn_fns[4] = {
     gen_helper_sve_trn_b, gen_helper_sve_trn_h,
@@ -2392,10 +2409,10 @@ TRANS_FEAT(TRN1_z, aa64_sve, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(TRN2_z, aa64_sve, gen_gvec_ool_arg_zzz,
            trn_fns[a->esz], a, 1 << a->esz)
 
-TRANS_FEAT(TRN1_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 0)
-TRANS_FEAT(TRN2_q, aa64_sve_f64mm, gen_gvec_ool_arg_zzz,
-           gen_helper_sve2_trn_q, a, 16)
+TRANS_FEAT_NONSTREAMING(TRN1_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 0)
+TRANS_FEAT_NONSTREAMING(TRN2_q, aa64_sve_f64mm, do_interleave_q,
+                        gen_helper_sve2_trn_q, a, 16)
 
 /*
  *** SVE Permute Vector - Predicated Group
-- 
2.43.0


