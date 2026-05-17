Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EFACD4851
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPq-0008Tn-SJ; Sat, 16 May 2026 20:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOy-0007J1-In
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:44 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOt-0005AJ-Cj
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:38 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c80227c9572so381251a12.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977834; x=1779582634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qClXpzIkhY6HXQLVy4Ou0WWe411jsSWReuNJ6IrI5vs=;
 b=oTZKghgmrYUgjlkIqErIauTm67yQssFtUpf0ICBhsgj1UupZVkc6RlD2aYfr97jjer
 ZgyoL22zntOgzDnvF1c7Ihw0yvjb6unhRxlkDr1fxL4A++sGa5VXRqGWji6Ld1PFyOmP
 XVRg/xCB3N/iGYkuDHNqyT0uEU0zOxA1xRThWoZdfwusjv6h554TCGHGsg7Bt9z9OQAX
 9hLJHDwEOadnAqBI87A0mU591AUpKkhUbDEUnMxxkkcBbtznbx1/bDNixMmlUWMljOxA
 l1hdM6+ece5+6ms18dX4XErb299dHzOBBQkCtuqf+yMKCNbTPEFg8AYyy8OuUgtkzIB7
 eGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977834; x=1779582634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qClXpzIkhY6HXQLVy4Ou0WWe411jsSWReuNJ6IrI5vs=;
 b=QpgblUrKBwYfvFA9q36JKnXCEnjuC86qIkJBP1UppCEfrD+u2VEY56aNpPEvHUfBuF
 VBbl1rO8Gf5ZEJ3yUGtHt6b9ls5TjkLJMFfaMIY2gQHt30AfC08HgV8us84BLZvR2hLA
 oxFHeSh4we4QrL9i/IYF2i8WXB6kNQxhHJUbfMB8Kypfc0YW0BjSJp66tR5fWvC+Uw2V
 vbgCOBaJXW3jwkU8En1prihikcSV2siOppQeIji9wiJfndFpAHr9yMrfA0lZbzSwxEj8
 HbEmp0qHbXUBAV5wO53Zi5X6Rw42l1ysiV1S3MTf4tREyeBtGNvGEXSoMAk/ylmnEStE
 0pfQ==
X-Gm-Message-State: AOJu0YyzpU3BjPZgbDUXw3MmDO8pUKe3xapmTmvT862Lnd9rLISAWL88
 jHkFzcgCwkB3fsxoJOQtqB3Fs0FXOHEphFeZ8exGeP/jWZ5ovTwsQ3zQKKpS204FyFbqvCKDdng
 azL/u
X-Gm-Gg: Acq92OHk7Vbrw5DlpNZsQt2//tx2M7I0X3eVteeCw5WCSpnPfEgHI0tjGQExzp27uOh
 SSXflQxa71wNpze6nHe4YHUU3ar+f41yHbZWvLTe6f6WlQPXAOEEn6L9KiEiA39GRyP6pO80Zc4
 BVOMGVpYRjlBScUo5W4ageEdSKdS1Pw2YuEHKL/7Z2qSP42511lIDaxlxRhBJJBfmYhgjSwwvMx
 3mBPSJpS+xoPROdyKiZfDEqZCd9r3MxGpjRDojpFiip4TIhuBAZREoSSCYTyl+X/iEuOsGOqPZT
 55ftkG6gD/26pITOR79yasXw/qZF+F6KJ1azC3DURrTtS/iszMOGt4T4vDradPNiXkDoXbiQjUO
 HUwO+sQv9mJ5QTrvaWHKJY1odwmiGmX2kkk8YurYCaGbI9Trx8j+GBWn2r7Zhq5fNTlv3FO7zWk
 Ql27LAFrzvMvlB+E1EHuF8IlNdsDCZdZYEH5y4EIg=
X-Received: by 2002:a05:6a00:3a01:b0:837:80a:5abe with SMTP id
 d2e1a72fcca58-83f33df536amr9778544b3a.37.1778977833638; 
 Sat, 16 May 2026 17:30:33 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 35/63] target/arm: Implement FCVT (FP16 to FP8) for SME
Date: Sat, 16 May 2026 17:29:34 -0700
Message-ID: <20260517003002.321430-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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


