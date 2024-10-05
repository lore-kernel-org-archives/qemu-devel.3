Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CC7CFA742
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 15:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx6fS-0001zz-Op; Sat, 05 Oct 2024 11:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fO-0001xd-OZ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:25:58 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx6fN-0002Ki-40
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 11:25:58 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20b9b35c7c3so32438885ad.3
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728141956; x=1728746756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js9k8IR/cEhAqGc5dKpCioG/n/UgV+piB56d5dg8Aiw=;
 b=UBDojHq+IY6hLn2Pm+jokXV1Vb/qHm2LRTVrgvpvQX78JPyAnXm2dcGbffMht2WRLp
 vwNZwf7SMtJxxDwr4h9oIIqgHHMTL5xF6bRHzg8iAgrdHD5iU9fc9IXLtOMPcgOkYPq7
 iHrbX+vflVajChWvcO2EkWphPMo84H1VONdNpl9/iDRQear4HoyMytycZ0Onc8uPOq3G
 M4zniZeE72I9IV/DrWBdS3bWXsZoTK+pwAIeHo0eG1b+DA2NCtlLCfmUPh3JEV8A47PS
 rnPaaHWWzlEzEywsthBqUZ7HET4z4D+GYL9tHQV+khOLumsRpxoM/PYQbUZyzygtZ7ws
 HyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728141956; x=1728746756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js9k8IR/cEhAqGc5dKpCioG/n/UgV+piB56d5dg8Aiw=;
 b=KoH9FL6+R+QW0NlY4XZ9xOqKDtxS4RqqTQJpGPt3aJDCO+7TtmyqKfjg+XaM3d3s37
 awrw9EYfq+bJ5hYYMfCYnDCTvlhuf29B6IFVUnzmFunDKmCcJUOuDwSemc8/Nbd64TN2
 brePe2v9W2GmGBYadTwzJgFqSLIZ+duweL0gPkwxptkouuNLsKOe1+OvtFALCo4S7Kmw
 po9oaV9CbGA2AEIZBpDT0Joq1x+0FhAKhg3C7lQjfnYCz5HGYlED/xbwxmiHLHDYMrt1
 wSgbylBg3hbf1HxMnyTiGnr6DtvgXHovNon7PjOrujZBMoFmPI9x2B9Hu4+/u3myxVml
 J8eQ==
X-Gm-Message-State: AOJu0YxQ0NFY+s+CL4+RLcnvw2514wNNQXGxcM6ZF6ywIrtynZrGMwpO
 if6FdDGkpXqupEDltngRAuAVzhnmMMzI616X4X+WJ5BgsT6F3Fi+7esjH0/LnIQEmoI5vnUkxcj
 x
X-Google-Smtp-Source: AGHT+IGIBBnYzSGfllOqeGB217gC39c6yX53tA6gs3EyjynpH2B/4NzPXZOQfYqQh+wbNxGsQ2aqKA==
X-Received: by 2002:a17:902:e551:b0:20b:4875:2c51 with SMTP id
 d9443c01a7336-20bfe024d5cmr107983235ad.27.1728141955681; 
 Sat, 05 Oct 2024 08:25:55 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c1396948dsm14351765ad.225.2024.10.05.08.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 08:25:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH 03/20] include/exec/memop: Move get_alignment_bits from tcg.h
Date: Sat,  5 Oct 2024 08:25:34 -0700
Message-ID: <20241005152551.307923-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005152551.307923-1-richard.henderson@linaro.org>
References: <20241005152551.307923-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

This function is specific to MemOp, not TCG in general.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 23 +++++++++++++++++++++++
 include/tcg/tcg.h    | 23 -----------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f881fe7af4..97720a8ee7 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -170,4 +170,27 @@ static inline bool memop_big_endian(MemOp op)
     return (op & MO_BSWAP) == MO_BE;
 }
 
+/**
+ * get_alignment_bits
+ * @memop: MemOp value
+ *
+ * Extract the alignment size from the memop.
+ */
+static inline unsigned get_alignment_bits(MemOp memop)
+{
+    unsigned a = memop & MO_AMASK;
+
+    if (a == MO_UNALN) {
+        /* No alignment required.  */
+        a = 0;
+    } else if (a == MO_ALIGN) {
+        /* A natural alignment requirement.  */
+        a = memop & MO_SIZE;
+    } else {
+        /* A specific alignment requirement.  */
+        a = a >> MO_ASHIFT;
+    }
+    return a;
+}
+
 #endif
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 21d5884741..824fb3560d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -281,29 +281,6 @@ static inline int tcg_type_size(TCGType t)
     return 4 << i;
 }
 
-/**
- * get_alignment_bits
- * @memop: MemOp value
- *
- * Extract the alignment size from the memop.
- */
-static inline unsigned get_alignment_bits(MemOp memop)
-{
-    unsigned a = memop & MO_AMASK;
-
-    if (a == MO_UNALN) {
-        /* No alignment required.  */
-        a = 0;
-    } else if (a == MO_ALIGN) {
-        /* A natural alignment requirement.  */
-        a = memop & MO_SIZE;
-    } else {
-        /* A specific alignment requirement.  */
-        a = a >> MO_ASHIFT;
-    }
-    return a;
-}
-
 typedef tcg_target_ulong TCGArg;
 
 /* Define type and accessor macros for TCG variables.
-- 
2.43.0


