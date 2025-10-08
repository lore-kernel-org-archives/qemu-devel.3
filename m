Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19687CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9j-00045d-US; Wed, 08 Oct 2025 17:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9g-00043d-Iw
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:04 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c95-0006ep-IZ
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:03 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b6093f8f71dso156933a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960584; x=1760565384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=y5GICm7YjWuLVFzNDqZE3wNbcZS9BUmDQcjzbBLiBbxZqVcqog/mXdDApVz7MA5aqa
 37X8AlQiM0IfhEWeoyvV9YYf7v8QNRoULD+PT0rA0D6T9T+qlp6J3PLE1DeDjskNNubg
 vKBuQfm5TmUwOsLUxnMGT5HkSGz7gYUIiiK29zJwkLyfhBXs0yBKfbym1y2Oo4HnOQzH
 My4iiBwa3+jwlngBLvNw0Zj30H3bZvUXFv1gCQuoCKk3l6ZzSSk9PyT2vjuSMTmt1WFU
 88CLqRTRsQ4LRsAZMg5+eWpHgs3PlkYdFjkOGVFXP6vApG/MPO7NXS8A6zCD3EKKxgRW
 58mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960584; x=1760565384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHDom8RqSvFBhHj/9Q/rXAoVV+sGpC/X8GRYrjCGKNI=;
 b=WgJamBkEQBHICATszWQcwgMIDlU4rqLfTxrVEdVuMJhPX2NA7/DRoEhrvFbIMpyExS
 Avu6sRJlepaPB+TXXV+i1beZ/vNXaCLT7vnvbfjYzowTsnYfrJHJOHyk0w9BO5WB98Cs
 gdVQyXzN5sgIH5C0BhBcDcg8Zu/cYlzgOZsjlRvjzLFJLnJHdJZBg8Nf5Ies5c+jl6PT
 Ms/lFKhXXUWZHE/teYIrUp4oqdO7cQA8ufqJhBgufZZC9pWTXqQRh06lvdhHVZ39pTrF
 D5jtC98VCqLMY2isaucZquyukvEGfPtslNjS7N+MR5YDRatuWENR+tbmqcGk/PWRt2T0
 KNhg==
X-Gm-Message-State: AOJu0Yz6ZPsP1kkeSIajSDDSZ/3IMFR8RgdO3A+FUCnv4v9YfLximVOs
 4GNLrEQoNCv0QjKm2Pisp6IhTVyyHVohk44KnKbg0EnItEgugc1JDBjKJzLP8Ys3BIooArGa/pR
 p21lBmZU=
X-Gm-Gg: ASbGncudVLsrl5kwWiM6ljDS1raZmdajyrtfn7/bZnZJOgRsrGrIxgGw0BbnLtjSZHH
 vEXQ4gYbSFAxJmKMAnEpBRdXqezhoredp20+jnrI26RJjVLr3lkRuKYhJgNE0SG+snNRZSlRgly
 +tZ+wy1JMwdvCBGssO5oUSfBuk/yhsEsCh6kjriglMYXQQHQaKrg7nXc+sJvNSbXGNeX3C4eahg
 52NSWKmX35CX6PClcojqi+mWXqMhQu6DkHHWjakXZxkAZMgc6rY1ACKvXNbLZq6rJbk2Y5z7B2D
 VL7vC44oNuwrU92WwAA4SUc3nd401GXYg28iyagyPST3ThQKIi07/RpKCh2ujz1DJJuazK1Sy0h
 pP5UmKjpUFBIPrFeyWCuC5/2ws6XeQsMWR5/CwtrFGJBPOPPoxMgW7qwqBZHQ/+zo1/o=
X-Google-Smtp-Source: AGHT+IHZUNxr5tyFMX/LVvuxMwWa8eNnPnV1fPRZuNPVG/xlk1ZDyJuYtBvPVWcvjyu6UvgO8ISt8A==
X-Received: by 2002:a17:903:1670:b0:28e:cb51:122f with SMTP id
 d9443c01a7336-290274191d9mr66167255ad.52.1759960584167; 
 Wed, 08 Oct 2025 14:56:24 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 14/73] include/exec/memopidx: Adjust for 32 mmu indexes
Date: Wed,  8 Oct 2025 14:55:14 -0700
Message-ID: <20251008215613.300150-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 include/exec/memopidx.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/memopidx.h b/include/exec/memopidx.h
index eb7f1591a3..66d9c58b3a 100644
--- a/include/exec/memopidx.h
+++ b/include/exec/memopidx.h
@@ -25,9 +25,10 @@ typedef uint32_t MemOpIdx;
 static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
 {
 #ifdef CONFIG_DEBUG_TCG
-    assert(idx <= 15);
+    assert(idx <= 31);
+    assert(clz32(op) >= 5);
 #endif
-    return (op << 4) | idx;
+    return (op << 5) | idx;
 }
 
 /**
@@ -38,7 +39,7 @@ static inline MemOpIdx make_memop_idx(MemOp op, unsigned idx)
  */
 static inline MemOp get_memop(MemOpIdx oi)
 {
-    return oi >> 4;
+    return oi >> 5;
 }
 
 /**
@@ -49,7 +50,7 @@ static inline MemOp get_memop(MemOpIdx oi)
  */
 static inline unsigned get_mmuidx(MemOpIdx oi)
 {
-    return oi & 15;
+    return oi & 31;
 }
 
 #endif
-- 
2.43.0


