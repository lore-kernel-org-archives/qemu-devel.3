Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB4D68BCD
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 17:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC04P-0003zG-Oi; Fri, 15 Nov 2024 12:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC04O-0003yz-VD
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:20 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC04M-0001UW-GL
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 12:25:20 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3822ba3cdbcso366188f8f.0
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 09:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731691517; x=1732296317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Y0AMU/ttgRURqOnN0XPhkHG3hk3G+OF7iF0mZeXnJQ=;
 b=n8STFGwn/3EbTsIFfPrxlCpGz3g2Cab4bihNWvoGpv2uklYj6TLxsPptNw+iAnAyBc
 VgDVrSfv1oA/T1TgSnUR46yjqJ57jQaERu4+QkHroQen07PhgmsSBDQ0daBbqEy7JaPv
 ecGjZotU4cs3k7OIatfDNOm4esgSeguzRpFTUPpldtmlyJUiagk7EoGfb8pHRzeJ3Ci8
 3pTFHtrB/XJbgK3H40xJzLYI1CnkVPty3qVvJ35ed74Zzj2L0YQWU6QNdMzTCsYFdvWB
 BOAujlDl/b4epOtOzobvb3KFFJNCibiyLx6SVfxvZjdbCHUbPeXkUUKdDyul1t9yqCh8
 ANWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731691517; x=1732296317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Y0AMU/ttgRURqOnN0XPhkHG3hk3G+OF7iF0mZeXnJQ=;
 b=VLlil8B0m1/1nylhpZItTqj/12nEzNAF5orTmOr3jgdZe+QDUKtDrlq7CupHffo5lb
 ppNOFr4OBJIOQ3RiNSuuKkFs1tNPuI32rcrWAwqYfXuiSGod8G5M1Q0KpFlKuafJgs2H
 UZdSG/lrHy05e+Z2mLSwunr1sArh9ZXGO71dCTOQZhvsc8K2IzwD/dPIM8hirAur1/I4
 e71QIDSxCcRa+nQBdSVJrCL0mfy+W30XspjRqpuE0ionk1pl3rmmVfLdKkB9JXqH2gTJ
 FQ7dPTcLqjupHXzbHV27jNGbdnipUbyd6ipajs+v8+B941XhmA1uwsAjhvEN7YCNnuTm
 K5/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV78VMakTVoSqg2LtgjqLmNi6jiKrNGKPxOCnw0kd9i4L8YNQZcr78wy0GR6CEoofP48oTqxyFETm//@nongnu.org
X-Gm-Message-State: AOJu0Yxlg32PSAPs7rZozN9nZKb+K25Q/X4hrK9zOAg04KcsxMtgoQUt
 1Bl85/D9hdVIIHTqsMMYp16t+FKroKt5jFzvDEQT7ovMl9m121+FV6CNP7m93cQ=
X-Google-Smtp-Source: AGHT+IH9HnPAv5KKrsgFmQTe4yqyqyb78yONAyEmtd66mmIKkV71Oe6N98HEpriHgLuG1vBAsfbhlg==
X-Received: by 2002:a05:6000:1884:b0:37d:9476:45f6 with SMTP id
 ffacd0b85a97d-38225901ed5mr2721510f8f.7.1731691516759; 
 Fri, 15 Nov 2024 09:25:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae3128bsm4815080f8f.102.2024.11.15.09.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 09:25:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tcg: Allow top bit of SIMD_DATA_BITS to be set in simd_desc()
Date: Fri, 15 Nov 2024 17:25:15 +0000
Message-Id: <20241115172515.1229393-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

In simd_desc() we create a SIMD descriptor from various pieces
including an arbitrary data value from the caller.  We try to
sanitize these to make sure everything will fit: the 'data' value
needs to fit in the SIMD_DATA_BITS (== 22) sized field.  However we
do that sanitizing with:
   tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));

This works for the case where the data is supposed to be considered
as a signed integer (which can then be returned via simd_data()).
However, some callers want to treat the data value as unsigned.

Specifically, for the Arm SVE operations, make_svemte_desc()
assembles a data value as a collection of fields, and it needs to use
all 22 bits.  Currently if MTE is enabled then its MTEDESC SIZEM1
field may have the most significant bit set, and then it will trip
this assertion.

Loosen the assertion so that we only check that the data value will
fit into the field in some way, either as a signed or as an unsigned
value.  This means we will fail to detect some kinds of bug in the
callers, but we won't spuriously assert for intentional use of the
data field as unsigned.

Cc: qemu-stable@nongnu.org
Fixes: db432672dc50e ("tcg: Add generic vector expanders")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2601
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/tcg-op-gvec.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 78ee1ced80f..97e4df221a4 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -88,7 +88,20 @@ uint32_t simd_desc(uint32_t oprsz, uint32_t maxsz, int32_t data)
     uint32_t desc = 0;
 
     check_size_align(oprsz, maxsz, 0);
-    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS));
+
+    /*
+     * We want to check that 'data' will fit into SIMD_DATA_BITS.
+     * However, some callers want to treat the data as a signed
+     * value (which they can later get back with simd_data())
+     * and some want to treat it as an unsigned value.
+     * So here we assert only that the data will fit into the
+     * field in at least one way. This means that some invalid
+     * values from the caller will not be detected, e.g. if the
+     * caller wants to handle the value as a signed integer but
+     * incorrectly passes us 1 << (SIMD_DATA_BITS - 1).
+     */
+    tcg_debug_assert(data == sextract32(data, 0, SIMD_DATA_BITS) ||
+                     data == extract32(data, 0, SIMD_DATA_BITS));
 
     oprsz = (oprsz / 8) - 1;
     maxsz = (maxsz / 8) - 1;
-- 
2.34.1


