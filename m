Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FFBC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 19:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mG2-0007mo-7z; Tue, 15 Apr 2025 15:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m2p-0004rM-A0
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1k-0002vs-DP
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:03 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2255003f4c6so62457105ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745567; x=1745350367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d+Cq5dbLnJd6hOWUgmUjB0Xm4SgGbIkaG92dvcfgQB8=;
 b=tkSMkwS0C9VjGDu18affKsOpSHNfa7GufBHQ1MNjuGa34f6asprRU+H7Tjd9Ht+tx5
 gFDrm80nXfIJNIxxmSu/86pZMRX5fUqhAnuHRfj/LBCweRx78qvLe6IgYM6rkyparSGT
 75u7jPjXQ6TLCh75Pjj4UVKkYOx+yZtfcRcAb5wlMwDTAJJxTPvVH2Ob0Jqtm/Zuyqgj
 2KxIXvwneQbzV19/dPvHiue4ccWE18v6bbxz0xGozCzfFtmoycT0Vm6Isyvwe6QGQzpJ
 Puj5Poqt53dJyFKtp0RhF+X5uPo4KxpgkHalC4RmFJxc00htaR10pdra3Q9RudHg5Suq
 TRYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745567; x=1745350367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d+Cq5dbLnJd6hOWUgmUjB0Xm4SgGbIkaG92dvcfgQB8=;
 b=wkBF7EZfyG7IDa5Hyv70UzO/qmU5ppMZJrjFREDZQq2uDxs8sh7aHYBzaigeiCQFmS
 G+jA9tcgX5iECelNRl0Cnu7Ju11Nxu8PT5Amrj9L4yGEOFPdOMog/AxZiHopeLCmZZDE
 9h+lBWNtt+HrYyJZr8zET1jdgJyhFfw1pCvh7ugD8oggT1u3pgKeMkxi2h5v3By3FsiH
 Nyl1z2kEINbfAM4p1/S3xOY0jU0CTcZlG+u3GMWCPEo6wcysi2dZzSzleyycdu4SXFQL
 gwgwK11M0iblPapl+ThQAjy12xfDwXhlxYgWMNZ8nGR/TtT22Ur+80sv5FkyDBG9at0u
 JoMw==
X-Gm-Message-State: AOJu0YyJCiVibeMEr7y104aI4SuOXEDNO4lvzbH8pS7RdUWfCYEchyiY
 unfvLbj9CtTpRY9f3JI+eM/81PanvO2dEA0lfeiJ3ZVmxy7MrF08BK4P3QTbNUIGbUthwJky3hy
 m
X-Gm-Gg: ASbGnctBdzSdu46zV2+eY9ZeKNAI4QUQkdMmvODA8JK6Cg6TXpmTc9WekClAncgdoTx
 x6oQCy3shpIPTnbwOVMyHxoLUqgeww0KM84pBRadLhQ1BPY1A16zIMGflCF+k9ZBrLbFxSqcG/A
 NXbvAQYHdXNl8pvp0AANkLzJjZyPTZcjXWXgPwhHwa8NdEuCN8bsHSA60WsP0G+TpgUdYvjWKGn
 XH7TqgNgS0TAfP/1dS1wtgmnnAmL+/H8ttChP1XHHrv6H18EOaDWlTXRK7Y+sY9eUNHcTHkDNUi
 vBaJ9VL1hYj66ptKvkr+g8bsojmXRsVBDJ5qxiR91/2RcMaO9bWDgEB7ZP419ae3Ipk+DALscRo
 =
X-Google-Smtp-Source: AGHT+IHsurKHHxGILfEoPtVCcQi1MWSic7vxjYCEcX30AdmnfjrroRYzsPn8PPrOio9BrqjKulsmlg==
X-Received: by 2002:a17:902:db0b:b0:224:255b:c934 with SMTP id
 d9443c01a7336-22c31abf758mr4333665ad.51.1744745567091; 
 Tue, 15 Apr 2025 12:32:47 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 107/163] tcg: Expand fallback sub2 with 32-bit operations
Date: Tue, 15 Apr 2025 12:24:18 -0700
Message-ID: <20250415192515.232910-108-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

No need to expand to i64 to perform the subtract.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8b1356c526..127338b994 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1123,14 +1123,15 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
     if (TCG_TARGET_HAS_sub2_i32) {
         tcg_gen_op6_i32(INDEX_op_sub2_i32, rl, rh, al, ah, bl, bh);
     } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_concat_i32_i64(t0, al, ah);
-        tcg_gen_concat_i32_i64(t1, bl, bh);
-        tcg_gen_sub_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
+        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+        tcg_gen_sub_i32(t0, al, bl);
+        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
+        tcg_gen_sub_i32(rh, ah, bh);
+        tcg_gen_sub_i32(rh, rh, t1);
+        tcg_gen_mov_i32(rl, t0);
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(t1);
     }
 }
 
-- 
2.43.0


