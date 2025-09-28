Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1725CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 16:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2uK3-000383-CL; Sun, 28 Sep 2025 12:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uK1-00037f-IH
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:26 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v2uJl-0005yR-Br
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 12:32:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-27eceb38eb1so45226525ad.3
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759077120; x=1759681920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cAY2ArchBWaMGfIbT8UhS815gAC6ZiBScneQAdyyaew=;
 b=zWXQ8anG0mjAYgRN/IhcQWwIFQ0dsr9A3KhXlPI3jVZ1lsHf4cEb2JMzUmntmS7mUX
 0AWSTFmS4fhL9Ox90o4PDmjG7wimn9V2GJ4kzA5CP2nSTLC7kut80isTkn758uwx1DWA
 EmWEM1ZjgZnPwXsLYhgyMob+i7SggSyQwpjYu2MGNfRqmIuk9AnBPicNMvgKJtDlh8fe
 k/sq8sUryzB7iVKEB5r3ZZMTbtWSsqWhjRyqO1MHP541hehMiQEKXxv5i40B6eL5wh8V
 z9VRgWK5h7GgI6KpvRa0q0h+efF1cN9BsofYoILfj10+YO/YgnUf+m0ilYkhio26xyJZ
 CslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759077120; x=1759681920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAY2ArchBWaMGfIbT8UhS815gAC6ZiBScneQAdyyaew=;
 b=HVIuTQokGgl4Rno0/vqD/n9EmYzzNEH/75IFCK2RxO/YG2eQw7+w7LHbpXFhdh2vL/
 QWhE8X2IfymaKH6dCGJn96PPlCsJ/c8VQwpDvmKPpUrY87/xkbZakJU3ZJE7OReg5fCx
 KuUOfOF6azCnyYMMHUBwv5mW8KFsJWZHj60/D2Ow8rb3Q4P4wcQ06SUTTY7TdA6uKtfn
 XCrjwph3OAiPXtMlKki9GxlxJIKyj7qRjjC3juRaAUMo3K2kkUSCKYZ4tj/f1TjbWjUk
 pZ6+8j4XCt+lqekIBBkYmrFbOwt97ByHycvuZELz6Zk6I1WAETTk0bMoqJ/zXSuIz1Ux
 mFOQ==
X-Gm-Message-State: AOJu0Yx3fCE3jkwyKFOIaRF9RkxABO5li5pLHw9zd/lURcU1WKWLMGIm
 seNstO37ZJvf1qw5xSJKavzm3lW7vvudcPQz2S0EMvt0p1R2JgzU54I0yue5fOmINdPi86AnrAc
 6KQFTbV8=
X-Gm-Gg: ASbGncvfhnmqPjWTle9GeNmLjsXK/cobm1iLR+31Cevgl55j2XH+fdYb3Vv09OFiugo
 3Hlk5sz6oYC3d1KuaMC/vwUsLrewvuaAMmVHkOLnYYjJ1RwU86Hb/h5mvrLf+SB/+8P1sFQ8zxq
 tC0/0R2rLSnXzKWsb/yxnGg4pBtrud1TFf4pMXIm5JwYdlzqOBUEG3vyG8LAXsZJzjMk2/v56bk
 tuWvX7mDruGx37UBWSosu6dxTBKdgIWxtCMIjIhuknlnMfuGvSflqi/ISXWnLaMcy10Ns77itXm
 hZ1TGV8qzdJWa6Nh9ullX/8N3TYOteEwFlvqsJiOD5deoucfC4qFy0x9WA+ULX7v34HIFuZklcG
 4UTj7rK+/TdCVeaFvo7cZIuUYy+DM
X-Google-Smtp-Source: AGHT+IEE5mozXDqAViE7IhpBsaVkoYCovfCCSV79N+qbASh5UTEOsdUIivhEsArUFLsF04U+NIHLZQ==
X-Received: by 2002:a17:903:2c0d:b0:250:5ff5:3f4b with SMTP id
 d9443c01a7336-27ed4a3e0afmr171125435ad.15.1759077120099; 
 Sun, 28 Sep 2025 09:32:00 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6996963sm107236335ad.104.2025.09.28.09.31.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 09:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] tcg: Expand extract2_i64 with extract2_i32 on 32-bit host
Date: Sun, 28 Sep 2025 09:31:55 -0700
Message-ID: <20250928163155.1472914-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250928163155.1472914-1-richard.henderson@linaro.org>
References: <20250928163155.1472914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3e10a3ad16..6c697905e2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2721,10 +2721,23 @@ void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
     } else if (TCG_TARGET_REG_BITS == 64) {
         tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_shri_i64(t0, al, ofs);
-        tcg_gen_deposit_i64(ret, t0, ah, 64 - ofs, ofs);
-        tcg_temp_free_i64(t0);
+        TCGv_i32 rl = tcg_temp_ebb_new_i32();
+        TCGv_i32 rh = TCGV_HIGH(ret);
+        TCGv_i32 t0, t1, t2;
+
+        if (ofs & 32) {
+            t0 = TCGV_HIGH(al);
+            t1 = TCGV_LOW(ah);
+            t2 = TCGV_HIGH(ah);
+        } else {
+            t0 = TCGV_LOW(al);
+            t1 = TCGV_HIGH(al);
+            t2 = TCGV_LOW(ah);
+        }
+        tcg_gen_extract2_i32(rl, t0, t1, ofs & 31);
+        tcg_gen_extract2_i32(rh, t1, t2, ofs & 31);
+        tcg_gen_mov_i32(TCGV_LOW(ret), rl);
+        tcg_temp_free_i32(rl);
     }
 }
 
-- 
2.43.0


