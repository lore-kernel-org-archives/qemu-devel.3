Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D785BCDD573
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 13:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwJ-0004dd-EB; Thu, 19 Sep 2024 09:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwE-0004Sz-Od
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwB-0000zw-3l
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:13 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cacabd2e0so6925015e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751469; x=1727356269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=He6YBSgRqmlZmIL7adkdTXMZx39goQaKpXwPEt+3grs=;
 b=xwJmh3L4Zc1scCPkauPp8ZiXEucFVL3SC0HDEeyHBk0+YjQVael30atiHQUctb1u2A
 Eyvo9YjW1W7vGZFLAuH+oylor1DPRVJwvuOI2UQXwHUO7PG1u/kwoUxyEdY5PhVS8kCF
 8rxMiWsscUSXEsVzwYO0kYfb71/DTnbpRZcHzK0CO1syauZdK4DKmOuTmzpI/r+QllaH
 cZhkefrrsrrgvki2ieaIfUXOLKkwJC+yKLTWGMA4qDnn4k+XtBOW57C4tyDcAPQRTFVm
 f6LEx+m7EF+4WaJChk8IqNIHaNI+4Ga485g6/Fy5rNPgLhG0noAbIKPAP1QHbscLSW3V
 D8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751469; x=1727356269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=He6YBSgRqmlZmIL7adkdTXMZx39goQaKpXwPEt+3grs=;
 b=OCpF0ewHGOS6VKq8n8BWSywI7xYCD5wJHHNa/fU2ZfMSKEStqRbbHSGyccOTuT9zg6
 XT3QeVFGB/aCMr8PynLHVrzFOf07V0FkKfWQzAus+2k/oNYhvVIXDHiRSXVYebxUbkmu
 gMmU11XLaEggaHawSPjmTWkd4iRC7adAP0ZTbumE3jB+V49Q5Pzg32xYsvYhuu3DwEa4
 hTGOdVqvMjJDVHYNnys/vFo7cprCqizSMaQmTw8p0Z93Eo7gbKggr/o3ubw+n/pwpxF0
 nV+pjDpNgaEXR2DwSvbX5nPMBJ/lwlI1d0K7Q4eCgYGagNTDmvX5S20jEKT0NZ9o5Man
 77tg==
X-Gm-Message-State: AOJu0YzwS0b81bJcNiDhia8TGTlLxKKfUf0ChG5XgknguHEmGASdTedt
 VKFe0+OWqMt6dmHQpXLwbQiobX388nftCdxF4ggCxvFpyaKsl7zmjbEnhp5j48NbcOfXfl0dEJh
 d
X-Google-Smtp-Source: AGHT+IER2pVl1DOF5lDjQlaRjzkLdS2cVqd0ABxVcRXdtERGdOUr1TgD9iTrqhPFFGDe21y+k5YESg==
X-Received: by 2002:a05:600c:3108:b0:42c:be90:fa2f with SMTP id
 5b1f17b1804b1-42cdb5662bfmr205865065e9.25.1726751469457; 
 Thu, 19 Sep 2024 06:11:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/38] target/arm: Use cmpsel in gen_ushl_vec
Date: Thu, 19 Sep 2024 14:10:31 +0100
Message-Id: <20240919131106.3362543-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Instead of cmp+and or cmp+andc, use cmpsel.  This will
be better for hosts that use predicate registers for cmp.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gengvec.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 726a1383aed..3edbf3a2627 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1041,7 +1041,7 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec rval = tcg_temp_new_vec_matching(dst);
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec max;
+    TCGv_vec max, zero;
 
     tcg_gen_neg_vec(vece, rsh, shift);
     if (vece == MO_8) {
@@ -1061,23 +1061,20 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     tcg_gen_shrv_vec(vece, rval, src, rsh);
 
     /*
-     * The choice of LT (signed) and GEU (unsigned) are biased toward
+     * The choice of GE (signed) and GEU (unsigned) are biased toward
      * the instructions of the x86_64 host.  For MO_8, the whole byte
      * is significant so we must use an unsigned compare; otherwise we
      * have already masked to a byte and so a signed compare works.
      * Other tcg hosts have a full set of comparisons and do not care.
      */
+    zero = tcg_constant_vec_matching(dst, vece, 0);
     max = tcg_constant_vec_matching(dst, vece, 8 << vece);
     if (vece == MO_8) {
-        tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
-        tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
-        tcg_gen_andc_vec(vece, lval, lval, lsh);
-        tcg_gen_andc_vec(vece, rval, rval, rsh);
+        tcg_gen_cmpsel_vec(TCG_COND_GEU, vece, lval, lsh, max, zero, lval);
+        tcg_gen_cmpsel_vec(TCG_COND_GEU, vece, rval, rsh, max, zero, rval);
     } else {
-        tcg_gen_cmp_vec(TCG_COND_LT, vece, lsh, lsh, max);
-        tcg_gen_cmp_vec(TCG_COND_LT, vece, rsh, rsh, max);
-        tcg_gen_and_vec(vece, lval, lval, lsh);
-        tcg_gen_and_vec(vece, rval, rval, rsh);
+        tcg_gen_cmpsel_vec(TCG_COND_GE, vece, lval, lsh, max, zero, lval);
+        tcg_gen_cmpsel_vec(TCG_COND_GE, vece, rval, rsh, max, zero, rval);
     }
     tcg_gen_or_vec(vece, dst, lval, rval);
 }
@@ -1087,7 +1084,7 @@ void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 {
     static const TCGOpcode vecop_list[] = {
         INDEX_op_neg_vec, INDEX_op_shlv_vec,
-        INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
+        INDEX_op_shrv_vec, INDEX_op_cmpsel_vec, 0
     };
     static const GVecGen3 ops[4] = {
         { .fniv = gen_ushl_vec,
-- 
2.34.1


