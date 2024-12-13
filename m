Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2295BE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Zq-0007kF-7n; Fri, 13 Dec 2024 12:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xy-0008Gc-5M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:53 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xs-0001iU-AU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso985759f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111223; x=1734716023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B0zNMUMDgnHepXnqq3jWRGeUDsJcd/C9LjIYSZ/w5Ro=;
 b=hucGFG8osqO6K24tCo/4k7NM8x2Rmz45TQG9gzWTdn8vktLfTCTXA8NX8hHcfchkyD
 T8eoXftAvoIRWGqJ3F5m/eNfE+eQpBzLkuiMMtGh5YnscWb7J/quMrviMzKZ16EGk2z6
 twYuuXBsO36QBOOFRuIsjQuxDvUzB04OnwhdCPyK25acjN5oyG3ESaxVpbYNSqHZq14O
 +oj17mVV99FBx71w9kBDnMDrYNpUpJChvv9MCvKB7+wsvEbVbwJ51UpomWJZYOM00XAG
 xHbOmoapIsL7kEWtdWg0/ZkPr4Q33s1+cNjf7aUqg3lv1oc5dX2pvGtBfz6CoDbMHktP
 Hlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111223; x=1734716023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0zNMUMDgnHepXnqq3jWRGeUDsJcd/C9LjIYSZ/w5Ro=;
 b=V9HcxkLKZKMZ2G/mOirU9XoItYQQvgTVlP8ZcdsCFt1zi+bD7ty3GtxbH64NAV8b17
 xlt6wO4AIyYZVtYBFlQmSM9qQX01zI/5aJI3Ks2/ouj4Cl5VP2wE9GC6LCeKzgOpcByk
 WNYp39L7M24rrNsLqnUknIP4xSDpZiD0j96Gf4S3YmDeEHyHFa4ObVf5+CspPSCz2MuU
 MVjeBtcFyHzokGke39C43TVpdw5nVLrWy8CWmVGMZTgRLZwcXzVQRp08asHCl2JlHCn/
 ONFDWgzO49GTto3UG+F424Jefql8AHauXzWcfpTOgi+Y26IK1wGR6sUjnszNKDX6E8DL
 h8eg==
X-Gm-Message-State: AOJu0YzwGDXvaW14BzkiiJhxomm54GKMpIn1qeR/pJQ2DSEjXLWb+oMI
 qneaEhdq4AVO+cfOIY1dl8TqfXNGs9Vhkt0mswzC2k1Bi/aDVhqP9qExRb7ulNlxGAf83J2PYqb
 V
X-Gm-Gg: ASbGncsnE+jw+UJXhRav9oqJR1RhrI+Yxo/9ivs1cm2Xnf8DxJjEQBCzVSFHVnBFe1u
 Nr2TdavGqJeS0fcEpR+pvufeKmPMCxCFtli21KuwLTd0xTuhjQ9Qqh50ISdYyUkUQBUZPpRD9Kr
 zIQMKQLsaWcapPPL5ddnZ2oru8ry9d6SkQRro/JMLaOHmFhRGWXQErgLC1aXjCJ3326rZaVGuuv
 U1O0iFWRbIGUTYw1j5h8sylaWDEy51PenbY/R+YINzCRm7ZsfUFB6stNxR8eg==
X-Google-Smtp-Source: AGHT+IFDkRbSn3VSbfMsOaMEvr6Htch4P/CJUGo3YW+3gfLniRkFoJNEhIpXj0d5r9jV/ukI1FCcdg==
X-Received: by 2002:a05:6000:4025:b0:385:f1f2:13f1 with SMTP id
 ffacd0b85a97d-3888dcd4796mr2654489f8f.22.1734111222829; 
 Fri, 13 Dec 2024 09:33:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/85] target/arm: Introduce gen_gvec_urecpe, gen_gvec_ursqrte
Date: Fri, 13 Dec 2024 17:32:11 +0000
Message-Id: <20241213173229.3308926-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-68-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  3 +++
 target/arm/tcg/translate.h      |  5 +++++
 target/arm/tcg/gengvec.c        | 16 ++++++++++++++++
 target/arm/tcg/translate-neon.c |  4 ++--
 target/arm/tcg/vec_helper.c     | 22 ++++++++++++++++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 1132a5cab61..9919b1367b7 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1121,6 +1121,9 @@ DEF_HELPER_FLAGS_4(gvec_uminp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uminp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_uminp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_urecpe_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_ursqrte_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b996de2c156..9b9abf19925 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -608,6 +608,11 @@ void gen_gvec_fabs(unsigned vece, uint32_t dofs, uint32_t aofs,
 void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
                    uint32_t oprsz, uint32_t maxsz);
 
+void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz);
+void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 01c9d5436d4..01867f8ace3 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -2711,3 +2711,19 @@ void gen_gvec_fneg(unsigned vece, uint32_t dofs, uint32_t aofs,
     uint64_t s_bit = 1ull << ((8 << vece) - 1);
     tcg_gen_gvec_xori(vece, dofs, aofs, s_bit, oprsz, maxsz);
 }
+
+void gen_gvec_urecpe(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                     uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_32);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_urecpe_s);
+}
+
+void gen_gvec_ursqrte(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                      uint32_t opr_sz, uint32_t max_sz)
+{
+    assert(vece == MO_32);
+    tcg_gen_gvec_2_ool(rd_ofs, rn_ofs, opr_sz, max_sz, 0,
+                       gen_helper_gvec_ursqrte_s);
+}
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index f9ca889beca..c4fecb8fd6c 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3070,7 +3070,7 @@ static bool trans_VRECPE(DisasContext *s, arg_2misc *a)
     if (a->size != 2) {
         return false;
     }
-    return do_2misc(s, a, gen_helper_recpe_u32);
+    return do_2misc_vec(s, a, gen_gvec_urecpe);
 }
 
 static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
@@ -3078,7 +3078,7 @@ static bool trans_VRSQRTE(DisasContext *s, arg_2misc *a)
     if (a->size != 2) {
         return false;
     }
-    return do_2misc(s, a, gen_helper_rsqrte_u32);
+    return do_2misc_vec(s, a, gen_gvec_ursqrte);
 }
 
 #define WRAP_1OP_ENV_FN(WRAPNAME, FUNC) \
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ee847745173..768f7458285 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3099,3 +3099,25 @@ void HELPER(gvec_rbit_b)(void *vd, void *vn, uint32_t desc)
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
+
+void HELPER(gvec_urecpe_s)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_recpe_u32(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(gvec_ursqrte_s)(void *vd, void *vn, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint32_t *d = vd, *n = vn;
+
+    for (i = 0; i < opr_sz / 4; ++i) {
+        d[i] = helper_rsqrte_u32(n[i]);
+    }
+    clear_tail(d, opr_sz, simd_maxsz(desc));
+}
-- 
2.34.1


