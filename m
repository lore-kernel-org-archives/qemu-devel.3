Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A187CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa42Q-0000yR-76; Thu, 18 Jun 2026 00:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42O-0000vd-36
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa42L-00046v-8p
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:07:31 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36ba285e98bso529712a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781755647; x=1782360447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3sDxn60tZijXHrH39BE9L+baesYT2v8cGj36MJTLIM=;
 b=ZnB9kiyz0TMlQjjPBbqQDEUzPRBsmYSMu7xqBUEvxJZ2eTjYK/MDCdNfgDwLbNlT5P
 idHebKdu9Rr5nrLmFdNdei83q2irl9rPcR08W2wfmB4JAvbb7f2/iQ9X+2PA97G78j0E
 tPvy/PwTA3We03lcT9NyLwnITl7892zaluEXj/+Gz9BB80efsXxa+kj58kEG2qoImbqw
 ibpiTbzhLOL62mcqFTiDfMo7rSN3PECCzTwLf1hJFjP/j34GRJQ84Ga0NUEhqNssromG
 TXj7nNLAVC0wMdRiu5xzkGR9HsSFDdA2LoSujezK/uKF6psWWB4Uy+TRF2W1LXI5QZlD
 +iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781755647; x=1782360447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t3sDxn60tZijXHrH39BE9L+baesYT2v8cGj36MJTLIM=;
 b=sE95HNGsloCAaOL/vvZ2jRSou2ZDNaO7qw1cJjcArYT0GuTfBwcuMjdtnV9QkNb0Zw
 j7JrYIBfwJiwg2cTfk+Fwhf9dZ9l6kVPZ6FupNGfdE4ebLW/Rr5EIlzZNPBs4eIbQHR+
 H833tgKvGO81LltcqrqEEdVeCEj+HaO8spbwercA2ROgy6jGV9ErM22kgUrkzO66o+VR
 R+8Wrqz/jkahCA8ChrYHPp6EKLHBTbj83Wp8Z/eg3TUA7vTI9wDTT8n+Em6r9zm0nueg
 JjToTxwOfdG/09Jn+0+KekG9cnWBomBaWIaNxeg4s7uI7O+0en64rdk36hpV0LiCA48v
 wGpQ==
X-Gm-Message-State: AOJu0Yx1Q6JdqLgbn8ogqKPiESVX3A2piNBSSc3E//K8CVc0+3+/IDVU
 INxnlaGi2whunS8vXAyzeBnhnJUsLNUo5hxnm5RafA3sUfnwCmXSng0gMHOx8AY7uxWyxBEaH3j
 cv8E0
X-Gm-Gg: AfdE7cmmquRs/9n8/U5VKdKNudo0oMFH8r+KhsfO7QyUQOQvIJB2YdAEEyyFnqO+yyA
 wb/jy5a47XiXizUJCbRiL58gfUN5Zjqdm1k5E22ugjlSJKTkiBBAadSKO3CPM9Mvu7iT3SNQ49X
 lsy1H0R5UezmCEvROoMEMB7d4P+R2OMYSZDG+bqulCRfhAusLhbp5ceDm+rRUjvjkTq+MsxRJde
 hvzGN0tCoOs73BDoZih3qWXAQodC1Wif4AVrT1Fp7yQOQLxLJGqUlC6has2jKa/+cLwd7y2yFU7
 n09Cyt7PfMo4UR9cYYwr0CihcLLuSRi6Ax0cBfgJH+qaZigXWOlxzEN+nZh7SsaRXb9UYBgBrHL
 tOvSbZSj3sGHV0oIZ3++d+zZkRsgKza+gdzJH6hQWIddemje3Raq+C2Ky3zZI1sLAD9zW7kd6Lr
 arIKSVIiKeW7ImHSQHAEDTjs8GfQXoRrCXv0lFJCu4qi+J75r89XTb8l87Cmap
X-Received: by 2002:a17:90b:3d92:b0:36b:2179:6d23 with SMTP id
 98e67ed59e1d1-37c9dbbc953mr6972616a91.7.1781755647054; 
 Wed, 17 Jun 2026 21:07:27 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5222e042sm8830476a91.16.2026.06.17.21.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:07:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 8/8] target/arm: Use expand_pred_N for helper_sve_not_zpz_N
Date: Wed, 17 Jun 2026 21:07:18 -0700
Message-ID: <20260618040718.572950-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618040718.572950-1-richard.henderson@linaro.org>
References: <20260618040718.572950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

These is a bitwise operation; with expand_pred_N,
we can always operate on uint64_t.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 43 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index b2875a559b..ac96b18784 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -917,12 +917,45 @@ DO_ZPZ(sve_ah_fneg_h, uint16_t, H1_2, DO_AH_FNEG_H)
 DO_ZPZ(sve_ah_fneg_s, uint32_t, H1_4, DO_AH_FNEG_S)
 DO_ZPZ_D(sve_ah_fneg_d, uint64_t, DO_AH_FNEG_D)
 
-#define DO_NOT(N)    (~N)
+static inline void
+sve_not_zpz(uint64_t *d, uint64_t *n, uint8_t *pg, uint32_t desc,
+            uint64_t (*expand)(uint8_t))
+{
+    intptr_t opr_sz = simd_oprsz(desc) / 8;
+    bool zeroing = simd_data(desc) & 1;
 
-DO_ZPZ(sve_not_zpz_b, uint8_t, H1, DO_NOT)
-DO_ZPZ(sve_not_zpz_h, uint16_t, H1_2, DO_NOT)
-DO_ZPZ(sve_not_zpz_s, uint32_t, H1_4, DO_NOT)
-DO_ZPZ_D(sve_not_zpz_d, uint64_t, DO_NOT)
+    if (zeroing) {
+        for (intptr_t i = 0; i < opr_sz; ++i) {
+            uint64_t p = expand(pg[H1(i)]);
+            d[i] = ~n[i] & p;
+        }
+    } else {
+        for (intptr_t i = 0; i < opr_sz; ++i) {
+            uint64_t p = expand(pg[H1(i)]);
+            d[i] = (~n[i] & p) | (d[i] & ~p);
+        }
+    }
+}
+
+void HELPER(sve_not_zpz_b)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_b);
+}
+
+void HELPER(sve_not_zpz_h)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_h);
+}
+
+void HELPER(sve_not_zpz_s)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_s);
+}
+
+void HELPER(sve_not_zpz_d)(void *vd, void *vn, void *pg, uint32_t desc)
+{
+    sve_not_zpz(vd, vn, pg, desc, expand_pred_d);
+}
 
 #define DO_SXTB(N)    ((int8_t)N)
 #define DO_SXTH(N)    ((int16_t)N)
-- 
2.43.0


