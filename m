Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA21CD3445
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 23:46:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL8Ok-0000if-AP; Thu, 07 May 2026 19:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Oh-0000fB-7Y
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:51 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL8Of-0001CR-Kq
 for qemu-devel@nongnu.org; Thu, 07 May 2026 19:44:50 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-479d4df9035so1750984b6e.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778197488; x=1778802288; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qClXpzIkhY6HXQLVy4Ou0WWe411jsSWReuNJ6IrI5vs=;
 b=pofbP3AFtoy5rpsVsQnNq2Hi7obSbVBlq5BX6PbLlsLncXg4Jk2Dzlie0uqlsYN7jZ
 thM3L9lh8yolz4xWrWfu2z/6ZAvotBTC9iHbBsXNplIHGy9U87oxua9RGxdDKTh9CQsc
 jUzcLo+OOqwOKTjpNqlORQRBaTnXASf4l9HPFHF3orrBrLP47RcX1N6e/d9x77+Be0CB
 n8qaAxKdhNjRpskewVnirRH9amDHco6C7aHh4OHOEpWF06IhABOz5K/U+EkFoRpL5iIr
 g0w2ykmjPTF9lbFBXjGrcTid3zI+gWFmhYGIbL9P6tbMR9tjprsg3nxjYE5y1SGEsAUA
 Gjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778197488; x=1778802288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qClXpzIkhY6HXQLVy4Ou0WWe411jsSWReuNJ6IrI5vs=;
 b=MOOdU6IahVJQ+upYmMSvrhoUVpQDydE75Rox1gKkj+7ilEjlZS/bRQm0oZD9huKb4Q
 9181eUODkSv5/Gt1ShufuNE8gE2OS7jzwvkqCGgWHeIMB0G5MZWDqDfo3o/9EdmYFGzA
 mhizUvW84RTfxfWa6aiNJCMR2leZfN+9St/vWMoSFiLM6Y+QOQNBJoKODc7MaoFv99Wy
 hpkBCIxkeWDZpYEP228P2qywi7lsl/F0GF4EsrwC1bidpcc6bk6ypCPqN4fFW0oQaV14
 7ZTD38lD/GD/NaLlXMhhgIs0paOCAFiS9s8ILEZ+mnX3uPxtTBuOV9HTjS52HJ8/SaQd
 64SA==
X-Gm-Message-State: AOJu0YwScNl0/QtbuCNawMnTaaYKbP8t192rvit1LtTe4wOaMrRksDoC
 slUk9IbO+2BemBNhwzVT3Pc9N0PlkJfquxJPkCfQf1VwFyBI/MvD7rDGFOybcFW1iOt8zJeqJop
 O03Ub
X-Gm-Gg: AeBDies/lDxQLlq36CZQB1VCnwUQAG/ioxVheOUM/eojrchqajpbIt1m6SGmNbW6b0u
 2IpKNebQTnKN3UD5+agimT0m3Otf2l1qMbs59MfT3w94JUzsnhwnrAjyEru1EDDPE+O22ZHRkyp
 f3OZxWJ7rkT3+8Kn+TH8PQFn305GuQRKHQNeP2CX3Ukpck2EEzO0fsSiWPdkkQzeukAaFFdYSTC
 baGC5F3UgKtsbA3njal2mk5QHzbQZFcD8gAPnmfa6S1EpqBx3adc4u6HnR6t+0375y9/nGmnaEy
 ZOxPkdzRwmKhDdYxZY7DBQ89FSRgkVXduSpG1By9RceWxLXGcneKD52JUD1J9CqvFsHnmRqKt3C
 5VYIweQHpC1YNeADsra108lwezKy4sgMql6abH8MHLxTWQcLs8iR5EiA984vKeALQPAwJvQ2+ls
 LZKOybGyEFIV/66SaUNTaYP753ANKEfShP2aJ15bxxZNANtQ==
X-Received: by 2002:a05:6808:c40a:b0:479:d372:b7d0 with SMTP id
 5614622812f47-48061ac2a0bmr3035813b6e.5.1778197487851; 
 Thu, 07 May 2026 16:44:47 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d8feb1sm84320a34.23.2026.05.07.16.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 16:44:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 34/60] target/arm: Implement FCVT (FP16 to FP8) for SME
Date: Thu,  7 May 2026 18:43:47 -0500
Message-ID: <20260507234413.643512-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507234413.643512-1-richard.henderson@linaro.org>
References: <20260507234413.643512-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++++
 target/arm/tcg/sme.decode      |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 0cbad3e006..050c3cfefe 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1556,6 +1556,22 @@ TRANS_FEAT(BF2CVT, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvt_hb, 1)
 TRANS_FEAT(BF1CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 0)
 TRANS_FEAT(BF2CVTL, aa64_sme2_f8cvt, do_f8cvt, a, gen_helper_sme2_bfcvtl_hb, 1)
 
+static bool trans_FCVT_bh(DisasContext *s, arg_zz_n *a)
+{
+    if (!dc_isar_feature(aa64_sme2_f8cvt, s)) {
+        return false;
+    }
+    if (fpmr_access_check(s) && sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_3_ptr(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           vec_full_reg_offset(s, a->zn + 1),
+                           tcg_env, svl, svl,
+                           FPST_ZA << 2, gen_helper_gvec_fcvt_bh);
+    }
+    return true;
+}
+
 static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
                         gen_helper_gvec_2 * const fn[5])
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index d6192eb59d..a02bcc0e22 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -863,6 +863,8 @@ BF2CVT          11000001 111 00110 111000 ..... ....0       @zz_2x1
 BF1CVTL         11000001 011 00110 111000 ..... ....1       @zz_2x1
 BF2CVTL         11000001 111 00110 111000 ..... ....1       @zz_2x1
 
+FCVT_bh         11000001 001 00100 111000 ....0 .....       @zz_1x2
+
 ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
-- 
2.43.0


