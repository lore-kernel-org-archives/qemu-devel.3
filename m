Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833F6C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2QA-0006or-0I; Mon, 05 May 2025 16:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Q4-0006la-JP
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pz-0000P4-F8
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-739be717eddso3973629b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476882; x=1747081682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s1YxZTFnyJUKlNufWpjlXpI0nvYQxw9kcPDoiVpqA7o=;
 b=RtFKw09HkiIEEiOvP/0LSS9GtrADflG2ITUEqGLsI5gug8fwNCXa4QzYoHUFKSuxVM
 zRpGF/+JMVIXJh4pYIlB6trGcoBc4A0toDBXp/5Wmpc277STAbLLL6vrFZ4IrJQN3rCU
 7Dkds1vGAzYdoMMTwA9ZNwKsvyWUkaOFL+a2CA5CfxxUuoM61B1JudN89Xy4tULPtXXE
 TM+xOXWSqgks+KLkhVMOYYv0MCTMIfz06dzODRq/kvZkxuv023Rbk/F56RuIBpsMirMT
 NUHBHWJkjq8gKHwVnZn+seEBs+SG8CWoNm7pAvDzsw0O/SuRl5+Zge88Ka2Pcxy5MRK8
 wkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476882; x=1747081682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s1YxZTFnyJUKlNufWpjlXpI0nvYQxw9kcPDoiVpqA7o=;
 b=pA9vQZUHwPtqcbBYcoC9tNml/8O061298FwlC/dcCDcM2+SRNs6a+UDY9YZMIEi4Qf
 /TVaclbpBNfB3SvvW4JPZPxuu+c0VQ8UWdpsW4+dVyK0LHPBsaMU7omIfX7Pq00FQF9z
 UMTYz+PLmDUiuNaFm241Kz8qxyfWFFGZxCsVmXIH6Thh/RLFoYNZTXC/avi0C0UaGtz2
 jGgjoksArZ6bc34JJsoE7BKfwSewcXn1Ex7qNc/2NoXAh7cYuEXLvqx2qB5zJer/oGpn
 /8/qgCYnG+OqOX+yUM3KejEvAa08Ld1i0VTHc3YIraHByDUKzIe9iIRoURVsMjez9p8e
 805Q==
X-Gm-Message-State: AOJu0YxmxAmaoGAP/9vGmbB0FkL3SpjaT5M/fx/kapRQB7XlgAy9ClQG
 4PP5Z5U/NsTSqGB5EFiMnaWNlSS5Z30snUwPDgcO0EaWjwhCVbcnR0wZzGBboJrlsgOFua5OmwI
 Y
X-Gm-Gg: ASbGncullq0TJlX2z16cu4oO1NPIs0LLFvKsjMA53j7KgmXBqNQrRjc1nvoNt3Ue3MQ
 N9cO5Sz++wjNti5cVZj5cJVP79eyJHPWuXuhfhuodQp6MivqEOBvXxmcoibqRR+XYAcPOblGEHl
 qJ6ENHeoNVlwyij+LmJ3BtrStZzZCB+bmZUzP679gIG3RI/tI1lE/DgJnxenpUoY24+mgbXHTRv
 C9Q9uiAfcUimsiWdiqWK+CChpnlvFrbp0UpVYfZr/OtQmW8M7W2Ie/dXVSbbbbGGnN+ty9fKjk3
 yfMJPD0wJMs3C1BI8yLF0IFzknAQPrZft835XeyuRiDkDnNs7n4H6y18YCkZYHi5NV+XCb9Zcok
 =
X-Google-Smtp-Source: AGHT+IH0S0Gl/YhVN6JmsvAH6TaoOCeSo7k0MKp4hUGUx6nKy5sFkgCI6qScNEYS55FOW6EiMmMXYA==
X-Received: by 2002:a05:6a00:8d87:b0:73e:2dc5:a93c with SMTP id
 d2e1a72fcca58-74091a3c859mr756190b3a.11.1746476882033; 
 Mon, 05 May 2025 13:28:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.28.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:28:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/20] tcg/optimize: Build and use zero,
 one and affected bits in fold_orc
Date: Mon,  5 May 2025 13:27:41 -0700
Message-ID: <20250505202751.3510517-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 22d302c9bf..5081e3db1f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2284,7 +2284,7 @@ static bool fold_or(OptContext *ctx, TCGOp *op)
 
 static bool fold_orc(OptContext *ctx, TCGOp *op)
 {
-    uint64_t s_mask;
+    uint64_t z_mask, o_mask, s_mask;
     TempOptInfo *t1, *t2;
 
     if (fold_const2(ctx, op) ||
@@ -2315,8 +2315,17 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
     }
 
     t1 = arg_info(op->args[1]);
+
+    /* Affected bits are those not known one, masked by those known one. */
+    if (fold_affected_mask(ctx, op, ~t1->o_mask & t2->o_mask)) {
+        return true;
+    }
+
+    z_mask = t1->z_mask | ~t2->o_mask;
+    o_mask = t1->o_mask | ~t2->z_mask;
     s_mask = t1->s_mask & t2->s_mask;
-    return fold_masks_s(ctx, op, s_mask);
+
+    return fold_masks_zos(ctx, op, z_mask, o_mask, s_mask);
 }
 
 static bool fold_qemu_ld_1reg(OptContext *ctx, TCGOp *op)
-- 
2.43.0


