Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39057CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYD-0001xv-IL; Wed, 10 Jun 2026 12:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYC-0001vy-Hy
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:08 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYA-0005qF-W1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:08 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so43277145e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107985; x=1781712785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dgNe4qeau5gf9dgYjxgGzW9GrSqcbiaaaJG2kNHdFaw=;
 b=HLEQ8wVCWsIIro5sRUwXh2Awr84LKvKc4i08uS8QQgToucaASWvYFw+Wv5XoZ5iq4Z
 m+xHwi/jVcGiEBc2IMAW7M29HGe6NPT+nbCjv0dUaxUj+fwEXOAzI7AEd1nhIt7SllFz
 GOsME1RYU57XPlKKcPcNlh7BRJiUKsoF5bGFW/I5CQApuXqTAXG3umaWY/Iz8jIUQ5z9
 UJZyniXGzZpXF4s2koEKYrsR/V7xn+u0C/2BRB9vqpsIhy3g68JUnFyxm/8ClB7mxtfs
 lqzW820Wh5sW+uHoAHbZnJt4mhA1M39jHkKG7Jh2PxumASqwdA6nHPzyiZnRUHHu/7C8
 13/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107985; x=1781712785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dgNe4qeau5gf9dgYjxgGzW9GrSqcbiaaaJG2kNHdFaw=;
 b=I5M58lBh7qK8JszerjSEukqFC+w7DZKwZp5LTtWl/7+3qPje4bbnLdxYpM/CcTVRch
 Gr+oq05hBLt+7/Lmwy6iH+y0zldjYW3Oq5bQtMlmUu/PJGhQewrfn4rxSzuNd2nIPEOt
 h/cW7lCajGvaae8zJwyTJj7Tmw3saqRch/d7FFj4CVMfVrgWAAHurqinXgB3L1L6VrFp
 c+9YTvJUH1dAEXuz23x35Cj7hkFKWlH7LCE3DIRkYD7Kqcrejv7o1ZXsBIepM4q6K42k
 DI4o36YRxeEnLEEE7XRi7oHWl+JZPKPGnd9NiHpKXKNH/avRwfiK8GVOY/Ky1YgXjL+R
 dieg==
X-Gm-Message-State: AOJu0Yy/5CKd2IW2oes8N0CuY7Kxo//uNL7O9+HMciCoXqHnVPafwD+E
 pt4Yq1AZG6L6PFYFffJoEpbcDyvNZ7Z4nZARBN04xqNEqwmBsY2YdLexANp0lp4zHk3B5MQEvXj
 rUmdT
X-Gm-Gg: Acq92OGV96stuzZnfqEfpjGecu8MOXsQNXWcHnMweixziQqVEvqPdpB/SWj9UqkXtYD
 Tm+tnonIJBIzkhfM4Q7PmTtOt/kuGEoOEBG82yZyQi413fEBHFU/RdHUwC8MksvUoe2IGL5+i8O
 VgKg/MF4j1H8EuPhYP4YjgGkaE/JREvg/Lbp1p5HJrwWT1tLncizWLPPvjNbDvFwaECHjnsKSsZ
 fsXezmYfcLbVEcbCE3PNIIuIlXz+Ka01e2xOhAPafF33BW29whmUQTov8S/1o3FHPF+wLaJ8UhV
 c3oypQ+EF2nc6eQylRliY5n4ppPY+5IxZrM82yX0hYV/6OBHYvOVFAHhbKb0JmmAh6a7BbwQ+Sr
 A7u0NnV7zas5DjHZHOYWSC9NWw4IAAtfU5IGjePO/K7FBEnXjdL+Q2CtJECP5NqMcuTX5rsLYFe
 UKMTSIQh2KVtJXv+0WFA+bjBCc240psiizwLy5GVByFY6rgePvolR+oeqWwelGp2ANUSVd3QuyU
 vBs9M3LyuVcWd4MyBbTXdIH6XDGWiWZ9pICtXQVAGc=
X-Received: by 2002:a05:600c:3b19:b0:490:e190:38f3 with SMTP id
 5b1f17b1804b1-490e1903b3cmr20288815e9.21.1781107985483; 
 Wed, 10 Jun 2026 09:13:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/71] target/arm: Implement FCVT (FP16 to FP8) for SME
Date: Wed, 10 Jun 2026 17:11:36 +0100
Message-ID: <20260610161202.2235298-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      |  2 ++
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

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
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index c0fe77242b..49eee95d88 100644
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
-- 
2.43.0


