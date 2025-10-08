Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD83CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCG-0007PY-8K; Wed, 08 Oct 2025 17:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAW-0004TH-Fc
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:58 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9L-0006kE-30
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:56 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b57d93ae3b0so165726a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960596; x=1760565396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbP0PhacBN6OOtL0crNE7p92W9z6GBnRnTHJYePdcJk=;
 b=AYmAyn1KTWLLBD67Ug//GiyMbYSa6Z6BMNbDxmOhWbF+KgVu9v0iMUlrBbqA8v1rGd
 cbt6pzI8p4QTvkVnlbOB5vo1kUyKHXjCGKQf/urSq0sV3t4qcjsC/wHRDdkWJif2ifpU
 UAf+uUMaeSuztcaTdbwnRC+oFnY1hSTlSt2X6fhORaxLeMRKIkFWDdwy0kVZNgqL9Kvb
 i0Q8/eq1Atx582e8mJcBbnIBukSWbdDIjyMbD+N921Tk/VhxQxlfA+w/VblTOQIMA4LO
 pL9tG4lzVouu3evi/ikvZMDTjlRMCHhzxJqz5ZPhI8D3d8bYRe7Pu7UMGj/0YzNwgmW3
 mbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960596; x=1760565396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbP0PhacBN6OOtL0crNE7p92W9z6GBnRnTHJYePdcJk=;
 b=GTCKUNLk9L6aZrr6ypquKBR3Lt2lZDw2PKxr3T7PGbbBSRCTmqAecH259SpwUt/47n
 W7LDTJ+2dpTCCmHlUsLGjOUVmI7jDuRlpXnkY+wmVfNPW16xE0tf8C+1YaJrpRePOPLr
 0bAx/B1jErDkTUu8uhKkFHajFb+Bw1D1aZb8JBMkz98zJooaV+IQywDEpqoaR3gLc9Fg
 6x8wub6//zknBQ8D/uUBaibPGxVo+lukTK8dKLAbK3qs0E4U5iZvwZUAX8Hv2v1FszuF
 m+3ZXVPVKtktLF1tgNPS2eFkWPMN/TWWldI22H8vrxjZa/8aIqYuJ90PtAGqNpXh0vrb
 YerA==
X-Gm-Message-State: AOJu0YxwASySe7hIkTaHZo+siw9zOw0hIZPt001aqRLma2/W55voucox
 o6VWeZPFnwOHeh0GIX87TP7JZLNHGWt+ngxxsxVPQIbTr0oPwyLRRPlVOU/cfNpOoUdfZpQUrY8
 VPFBz2o4=
X-Gm-Gg: ASbGncs5E0gsoW9/ShW2lweKbyL9h7E68mULLEiDdVoY54TuRsRKFkBr4MRA3mK6OfX
 ZxJK9KOLOZOA0o/aCO8bdgp0MF0897iaHVSjMETpSOCshdMWP4hD7tRZV6x9ZnPpXJZ/dgis1PF
 Ms8VZId0Lxo+LZott0g1xofXGZ345fY39z7liQ+HaZsCCzpUJpIIIaj2Et1O0tclH4c0BlBmkVI
 uLDSjvI1WmpdyqG4CrqTkhLXo0ROmh3OZLgMEhmLgirROpUlQOocuoc/FG+npX5CsuoIkR6KVI3
 e156Rf3NJ8RMERMEBgx+VtxiIqzdtmLGc6TMiH6iKaxrFB3LUFSvSQ3HN5z11qcB4gooHdAf/wH
 5onoX1YXe2T8q+D7KsoZTcrXSIgJh9mXWKepZhN3wXeKTcTAzLbnQmv1M
X-Google-Smtp-Source: AGHT+IEwSFGYKhI8k1o3/DKsm6yR54T04FqKgfCf0ZH43eTwtIpuxmPFY3WBV9oNcwUbrgi1WkGgqg==
X-Received: by 2002:a17:903:37c7:b0:269:8edf:67f8 with SMTP id
 d9443c01a7336-290272ff5b0mr65857895ad.52.1759960595839; 
 Wed, 08 Oct 2025 14:56:35 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 33/73] target/arm: Implement FEAT_CHK
Date: Wed,  8 Oct 2025 14:55:33 -0700
Message-ID: <20251008215613.300150-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This feature contains only the CHKFEAT instruction.  It has
no ID enable, being back-allocated into the hint nop space.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 14 ++++++++++++++
 docs/system/arm/emulation.rst  |  1 +
 target/arm/tcg/a64.decode      |  1 +
 3 files changed, 16 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 693eab1c01..78b2881a15 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2124,6 +2124,20 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
     return true;
 }
 
+static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
+{
+    uint64_t feat_en = 0;
+
+    if (s->gcs_en) {
+        feat_en |= 1 << 0;
+    }
+    if (feat_en) {
+        TCGv_i64 x16 = cpu_reg(s, 16);
+        tcg_gen_andi_i64(x16, x16, ~feat_en);
+    }
+    return true;
+}
+
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index c779a50570..68d9a4e734 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
+- FEAT_CHK (Check Feature Status)
 - FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 55ff6c504f..8283a9c83d 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -256,6 +256,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIASP     1101 0101 0000 0011 0010 0011 101 11111
     AUTIBZ      1101 0101 0000 0011 0010 0011 110 11111
     AUTIBSP     1101 0101 0000 0011 0010 0011 111 11111
+    CHKFEAT     1101 0101 0000 0011 0010 0101 000 11111
   ]
   # The canonical NOP has CRm == op2 == 0, but all of the space
   # that isn't specifically allocated to an instruction must NOP
-- 
2.43.0


