Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD932C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGS6-0000bX-N2; Mon, 30 Jun 2025 11:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRZ-0000PN-Gm
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:17 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0008DE-Ew
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:17 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2db2f23f174so3177689fac.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297347; x=1751902147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84zKQCvKoHSWIwpx/K6wMVzmeocb04Rl/dJUtZLC5CU=;
 b=pP+PW3mvkGQO4MIJhzeGIibMI9F+BH1ln3geLy6l62EUhLwqPQtxQly+KluTQsRapt
 UpRIZdn2071J5FqfKsPv5/dTtl3zCtgS7v3au16qJDxygwB8WYiCmU727enHhyb7sgo8
 7+HGccBGQGRfF4DtkJiK5GgWVPqQVzoA1XbSm553E0qEqlCLM6XeiA/VeaMmRJB0wNf9
 IX7nDQkuPpnK0rVDrCi7q6XrtVYknIpy3OxECvr41URJN1891KeDdFtg4mPxC2lbgT47
 tAUcyx1i8Z3aJV+5/pGO0r5AcC9qgWCoMBLJ3BJ1yr/RX9Db4sjYMKfuiq+vIgESVbQA
 /1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297347; x=1751902147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84zKQCvKoHSWIwpx/K6wMVzmeocb04Rl/dJUtZLC5CU=;
 b=MyeRR4BW8HzeSi2vB52gMpnxAyU9SmG4ON5vnqmbOlo9gMDjLcBMB1UQzhVdhxeVAL
 f82txyMO0jMYfl2Cr7PA8FYIwhMwGEGYmJqkqq1nfGWbkAgwqYT6jhn8y/JKgcmpjvlR
 XqIXNgA8SJD0EL2uc58zXWUJpje1OoPN6ntUeddcTEAKBBMBKPP1VUzSTT5/sYUsmsHA
 MLSdgIccmXih5RQzMxqSpYEBinv59ujYQTVQ87AjBF8tGN9574Q4iQqbM+Pgt/lyOUBG
 7hFMrLQ2jv1RdIMaHCPIkI6HFdpvM8LeC9FghvSabBkuBANhh0Zn9GWwUEnbsrMye0yF
 oz0A==
X-Gm-Message-State: AOJu0YwrJZFPGapZXofEkrPVCgpvl3rgZQ3mkc8sxJXsFZKCI+8Uu0JU
 27KEA1Jb1GbiY0aBC7hN4tBfqNYM38za5FCrCake3fBJQ0GPdccFyKpqJv5RBvhCsEEO/gG8uEn
 TiOCN
X-Gm-Gg: ASbGnctv7QNRjc03iqe3g/2i827m8R04Bqtg38qbly/SHIzlTB4vzdbB8wvTE/+JM82
 9X0h+d+nkQETyKEvWsfWecXA61K3TNQCuJxPFwj/7434o7oTZu8BDE8GrFveFYQdDlAi3vqQwHq
 /+G03n4qKw43GsrsJb8mdQKZY0TTo+oMDRyR66ClIqG1i5OesnxxyrV5KvPa3LZ7ZQ0HPUZlkCg
 IZwWv3LtXvpZfeu1lqTi87bJbgNkKbdun3qX8+JS9z9a+e5TiFqe1SS+eaqjyRhK4HUCfi5/Qhg
 Y1AxjoRVO/Rj82r4slzQICNTKgSWSRA7HZLX16n6IlVGj/MsNwhXYXDVOySS4GT6QTX2OwNhpwe
 IHj2N
X-Google-Smtp-Source: AGHT+IFoKniVh+6fObNxOIkEMKc1YTSkW7rCpHZaxH8NLrWE3ditynHgUEArmSKHvaRO2FqERRvDVQ==
X-Received: by 2002:a05:6870:9496:b0:29e:3c8d:61a0 with SMTP id
 586e51a60fabf-2efed44d8fdmr9096424fac.8.1751297347027; 
 Mon, 30 Jun 2025 08:29:07 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/29] tcg/optimize: Build and use zero,
 one and affected bits in fold_orc
Date: Mon, 30 Jun 2025 09:28:37 -0600
Message-ID: <20250630152855.148018-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index ce065d0e22..795f1c900e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2287,7 +2287,7 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask, a_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -2318,8 +2318,15 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     }
 
     t1 = arg_info(op->args[1]);
+
+    z_mask = t1->z_mask | ~t2->o_mask;
+    o_mask = t1->o_mask | ~t2->z_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+
+    /* Affected bits are those not known one, masked by those known one. */
+    a_mask = ~t1->o_mask & t2->o_mask;
+
+    return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
 }
 
 static bool fold_qemu_ld_1reg(OptContext *ctx, TCGOp *op)
-- 
2.43.0


