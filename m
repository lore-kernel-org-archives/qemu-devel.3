Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAE0C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMji-0002WQ-L5; Tue, 03 Jun 2025 04:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMjE-00027H-IC
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMj9-0005kV-RD
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:10:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso1865082f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938229; x=1749543029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIiN8Y95z2H9yF0XmnL3s2gEm3tNlVfWIaOr6l2WCKI=;
 b=yLYrJJPYzXnxAwDSd5QgJ7/9NvKVEpTj141iFgnqaVZoza7mBIkuM9Bz30d3QfwUIE
 sTq9E65XEqLFKbsrsr8sTYo99ItrPNLgSKiJDuTVVRwtwAgKbzaSCAgqQfti5GfIwbus
 3/7tWch273sio8tN3eY0A3f9Cy9bmZwJ/XGwfnWqA8ca2Qu8c+P2rL7QsDRqsR0fcGpa
 w0V3I+N2cL6MsUCP9XmWO+g2BrHL0Pt+kbfd/osOND3hH/OdZXlxXZwD5sQ8trWKPgeb
 xHrfsUHae/KkiJ8EyfVEc0sBi3ikkSZx2UC7oK4SSauHzpFd5AjaREMk46+8m8WpydGq
 AiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938229; x=1749543029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lIiN8Y95z2H9yF0XmnL3s2gEm3tNlVfWIaOr6l2WCKI=;
 b=tA5r+AilWTjxXrmLlKxFuak4n+3SwRHrDZZH2Y4RI71s4RgDW7pCxzkC3rY9TYfFfH
 WqTUET3yVvMLBJW/sdOOJg9cO9chOeGeFbBJkI0bqhhnE5LR/3TUB6XDtG4EdiSM+Mzo
 wChn8HNB6HN2Tqw2r8fOTjCKJbfPP+NueK62rB7273j4B7tNGgClUjIYBgPkDAGSvwqU
 S67BANEB1TsNAbxsREHgB0C0UFagncPJRVzuxs9GhfWGVs1hT4ZQNS3NXm5auBkO7Zn6
 CK+JLc2C1rSlY9uqgG8YIHcZiHPO+5SOb9Bv1ZEpUBqCIt+feXD8TSUu0+6uSGIr3TcY
 OJWw==
X-Gm-Message-State: AOJu0YwQGCrgk0m9Sx49vvF+z9mJtkaUIVANdmuxOdMMEkAJtgfYcU2E
 SlMEu7gSOwSuTDUBcZVUIPdvjsQEmGn+md/G8WW+EIq42Pd7K4xW6FfOMSEGQ9fnPRPQbXjw6hF
 rFQYzbFE=
X-Gm-Gg: ASbGncvtfFZanHoH1CgljZxQ1pgRwQV2ZtzSacqJAJpMd34jr+hmV98bVjT8Co3CYcG
 jqjhqK3iMFJ6j1wJMjTcpwXFvfTtc8KT2c61lY0FFdM/L+bH1iR/9dArUoE+A7yY9EgJvfUJhqr
 n59afpzceG3mPBn8hMtv9b0GqWvDPwK4G0x5HwCDnNEmMTdBnQ43O9x/HWHtMZHrqMcngUcqj/K
 h6/KTSUS7oo3Vg6A0NKIMaI8RWMb6qksJjTAmQLoPwelOOWg6vQw+DSzanwGTfXqAllUejJhcNz
 l7NciIo4cE6RcRn/t/32fY1+X573c+CB5NnHWyRvGGJSPW6SrqTcpin0gQMtgjVMmKsBIJE/gtt
 Ffdn+Vr7YWqc5
X-Google-Smtp-Source: AGHT+IGpPD4G8zuq/W1++uKiqnE4ZiskG2lZTac2ZmcV6O+QE/Dz32Ft4fluzWGl4egh7F7VjO74+Q==
X-Received: by 2002:a5d:64e6:0:b0:3a4:e68e:d33c with SMTP id
 ffacd0b85a97d-3a4f89daad8mr12751583f8f.47.1748938229178; 
 Tue, 03 Jun 2025 01:10:29 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:10:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 11/27] tcg/optimize: Build and use zero,
 one and affected bits in fold_orc
Date: Tue,  3 Jun 2025 09:08:52 +0100
Message-ID: <20250603080908.559594-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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


