Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD698C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jw-0001DY-4E; Fri, 28 Aug 2026 18:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Ju-00019W-0b
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:10 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Js-0004Zl-EM
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:09 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3969e82ff8fso1711736a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957107; x=1788561907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yXJmpQg5IQ+bnTObTQiSFuhs75H1FKJyV3yjSgBcfNk=;
 b=gz+TOR6UElV3seK7R1jVECmnuVshk6Z+g154xiEbJ6tv5ne1QZORBzhTtQTq7j+yaI
 uWZuFUK9FIFhpxZ0f60RRTD4/GfUi4vXLtWIKV/Tj+cu3yrCzwOpg4QrdbhZ7CahS/cs
 q6YwVGX7u82wC1vYFvaeNyzC/SUYWHqwuFX61eab06wNAQPynnZUB2ruxufJpB5Jsi0d
 dgeJLrqJspQKO+GXfan6YLq1dRlHdp+NMGwPmhoBJeGmCPrkN9FV3/OPivCtmUyzDqvG
 ll2iZZeyGCSgaMQxRIs2bSwAZA2inegbTqXJuADnxxmuealNa1ft6X+1F38hzfzKjxhe
 ab7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957107; x=1788561907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yXJmpQg5IQ+bnTObTQiSFuhs75H1FKJyV3yjSgBcfNk=;
 b=GgBGX3pXKfEqk4fipEnBXAvZ6gKLegPNEyls/4DMjKQ9QOJXXsnAEIOo/PxNJFw54P
 vrIkszIQVnCqVCcGXEk78aoBZ3Ey+iyZjD6yLQB4U1P0jBnfXWHT7RJesPKN4mthayEx
 3vhCvmKz7fQvZcK7wwDbGPHBxMtKjEQKzE0Ae7dC55VA6kWdj/WtuEW02dcaVe0bKCxY
 QH2S1yQVwSqiTvzdnWNT1JmGOvSdg/wbjABMpxVBNixYXau1+N2ZMS88dzXTPYQZxrv0
 0RW/hHG7DXftWlDgD4q/Y7dgpAU7wuQC3Tj7VMs0Eda5/owkit0Oc9/2kBADHMdu141r
 RqIQ==
X-Gm-Message-State: AFuF++nGNRhfTXq8Y9oka/oC4yRQUO284ymsR7PzCchEXc5ZYa2EdlmR
 R2yZnVamfi4+B1KJxMjms0Gx3coPPh43NwSgqkm+Gcl5X/rh3PUHk8HtEovNkz08SIVB+U2p4eJ
 ZgcA6
X-Gm-Gg: AYBFou3gv6mpZIbXMksvOVrKR1HNc4m6LQ8fsVUuw6kiGZyQFGtCiCRPgRolkjWVzRu
 UieRLco1zGIwZdnYYE9a6mGv0egreJSz0H9XsU5tHue0ffciXPfjBdXMT7mYK6Osf8mMn3xpq1H
 hS2ZBbq8jCCFroSwdPVmjodyO0Ueo2sB/sTjG0S27bEgDOMWPE5iNafrH7+P/Z+Pk+a+RrMELkN
 DV4nfLWr91F/vHTzBBnUZ1TfvpbuY95Az+u9Lo3QRO+oRHXfeoKnYX1Glag5r1dVFBLtVMwBqJ3
 KE2tkvki36yrFeZ4OxNqc8N9SoUogOA4EYJZd37TRh29dZKKzRoGS7xHuSoQvLAZZcVgq2+9QzF
 Kj0wlOVEl5xrNKgE9d0O9H2fFraYG/RQ/8Tv6cMnpkeCW7Yb5bmnclzzMQaGC7lFIQPipHkj+84
 MPI11wbkGat+k6t/RhTHSgOwov8iujlVTboR7pqlLvhwAMSGP/B/9Eh2wcpeCKsjWKsE7+TMn1v
 imgdELzOtiVzBqOiMok
X-Received: by 2002:a17:90a:157:b0:398:9bd5:4911 with SMTP id
 98e67ed59e1d1-3989bd54ccfmr2839078a91.24.1787957107021; 
 Fri, 28 Aug 2026 15:45:07 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:45:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 16/16] tcg/s390x: Implement INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:51 -0700
Message-ID: <20260828224451.1564072-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-has.h |  5 +++--
 tcg/s390x/tcg-target.c.inc | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target-has.h b/tcg/s390x/tcg-target-has.h
index 58e3afe5266..33a3b72318e 100644
--- a/tcg/s390x/tcg-target-has.h
+++ b/tcg/s390x/tcg-target-has.h
@@ -77,7 +77,8 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_sextract_valid  tcg_target_sextract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) == 0)
+#define TCG_TARGET_lea_imm_valid(type, imm)        \
+    ((imm) >= -0x80000 && (imm) < 0x80000)
 
 #endif
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 2fd7012d047..db3b2fc3c92 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3187,8 +3187,19 @@ static const TCGOutOpStore outop_st = {
     .out_r = tcg_out_st,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    if (imm >= 0 && imm < 0x1000) {
+        tcg_out_insn(s, RX, LA, a0, a1, a2, imm);
+    } else {
+        tcg_out_insn(s, RXY, LAY, a0, a1, a2, imm);
+    }
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out = tgen_lea,
 };
 
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
-- 
2.53.0


