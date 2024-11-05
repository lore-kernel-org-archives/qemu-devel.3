Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C82D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 11:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8HbY-0004fF-OP; Tue, 05 Nov 2024 06:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbX-0004dC-64
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:11 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8HbJ-000784-40
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 06:20:10 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-539e3f35268so6499189e87.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730805591; x=1731410391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FBJ7C4+ClTBlCUSOBe+gLo7sz1EnjPStvDm17hGVx2c=;
 b=izdKyItZepj/PE6PIHB6b5aO6fCmI8Smaa1yxLF2ous9gzF8zWIflmYUmywi/32tW5
 0HtU1SCAsNNgoHch39zRquHNdha2Q+ZUdxXKSKSqa44zWqs++7voyQmBXn2MTTjOj9xU
 U1nHdaZMoZyXE6OgCAN4An2nschVXgjb+DVf/Xb/M0fnszIrKdM4S6xY4N8lGbrIJh0Q
 viE9OlCw8pQXbB1ifIRx6f4qhEdXA1H5krqsMe0s7gc/ehOPuq2k55llKDbh0FAJQC1J
 zWE8NMhjkLc/Nvle+WF2QUrLn+Lj6PwTbJ+uumKjTu3MQgetEkvxpsS7DS/+RA/uAM3H
 LmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730805591; x=1731410391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBJ7C4+ClTBlCUSOBe+gLo7sz1EnjPStvDm17hGVx2c=;
 b=ocEq19ErcDRTCn6vHLfgFmO+Sv9zWSCBRw0cxpr9qQRDAbebVG3D+u00YQ9xWtfuzI
 HmAc+HV/QWeRI4jsNyePaAKgZWsJ8DVfwbzlSBwmnWzQ6E54db9HD6ioNP0jZU8k9WuH
 M/jYddYzX7ss1Fa2+3Rlr3ZNv3drQsQtmDYR+En7noAHDb9RD29Rae08i5s0/P4d2ini
 DRer2dPa26/XUqzeFAN/otFX8FjYPEjPx5+jMHxdNWvr+YDsTpxEZl4l9HtRd7FqBBBk
 4KcHkyNcivfoySbSMOsGTusfWoUZEo4ju0sm6mEJc1X7y+J7w3/nSaARDbeNHutW6ty3
 Wx5A==
X-Gm-Message-State: AOJu0YzUWCZZc1tvXMHwDhbQ86EM+kuUph6waQdFllkWIHmeEZaXjTRv
 HVrqp+S5Qy/iDNj61AzjximQ43fqELy4KE2Yp+M2mm0ekE4LM+Hhhq6zPCSuBLVNqZF6JZLPA4p
 a
X-Google-Smtp-Source: AGHT+IFhXyu+hyXj6A5Fxf5mjkvhfCpgRVojTyQ10HTgI6jCTXxofr97SSuvS18BsOUgHRMxVhgKuQ==
X-Received: by 2002:a05:6512:1193:b0:539:e436:f1cc with SMTP id
 2adb3069b0e04-53d65e264e8mr7159660e87.52.1730805591459; 
 Tue, 05 Nov 2024 03:19:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a3688813sm16354555e9.1.2024.11.05.03.19.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 03:19:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/31] target/arm: Fix SVE SDOT/UDOT/USDOT (4-way, indexed)
Date: Tue,  5 Nov 2024 11:19:28 +0000
Message-Id: <20241105111935.2747034-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241105111935.2747034-1-peter.maydell@linaro.org>
References: <20241105111935.2747034-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

Our implementation of the indexed version of SVE SDOT/UDOT/USDOT got
the calculation of the inner loop terminator wrong.  Although we
correctly account for the element size when we calculate the
terminator for the first iteration:
   intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);
we don't do that when we move it forward after the first inner loop
completes.  The intention is that we process the vector in 128-bit
segments, which for a 64-bit element size should mean (1, 2), (3, 4),
(5, 6), etc.  This bug meant that we would iterate (1, 2), (3, 4, 5,
6), (7, 8, 9, 10) etc and apply the wrong indexed element to some of
the operations, and also index off the end of the vector.

You don't see this bug if the vector length is small enough that we
don't need to iterate the outer loop, i.e.  if it is only 128 bits,
or if it is the 64-bit special case from AA32/AA64 AdvSIMD.  If the
vector length is 256 bits then we calculate the right results for the
elements in the vector but do index off the end of the vector. Vector
lengths greater than 256 bits see wrong answers. The instructions
that produce 32-bit results behave correctly.

Fix the recalculation of 'segend' for subsequent iterations, and
restore a version of the comment that was lost in the refactor of
commit 7020ffd656a5 that explains why we only need to clamp segend to
opr_sz_n for the first iteration, not the later ones.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2595
Fixes: 7020ffd656a5 ("target/arm: Macroize helper_gvec_{s,u}dot_idx_{b,h}")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241101185544.2130972-1-peter.maydell@linaro.org
---
 target/arm/tcg/vec_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 22ddb968817..e825d501a22 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -836,6 +836,13 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
 {                                                                         \
     intptr_t i = 0, opr_sz = simd_oprsz(desc);                            \
     intptr_t opr_sz_n = opr_sz / sizeof(TYPED);                           \
+    /*                                                                    \
+     * Special case: opr_sz == 8 from AA64/AA32 advsimd means the         \
+     * first iteration might not be a full 16 byte segment. But           \
+     * for vector lengths beyond that this must be SVE and we know        \
+     * opr_sz is a multiple of 16, so we need not clamp segend            \
+     * to opr_sz_n when we advance it at the end of the loop.             \
+     */                                                                   \
     intptr_t segend = MIN(16 / sizeof(TYPED), opr_sz_n);                  \
     intptr_t index = simd_data(desc);                                     \
     TYPED *d = vd, *a = va;                                               \
@@ -853,7 +860,7 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)  \
                     n[i * 4 + 2] * m2 +                                   \
                     n[i * 4 + 3] * m3);                                   \
         } while (++i < segend);                                           \
-        segend = i + 4;                                                   \
+        segend = i + (16 / sizeof(TYPED));                                \
     } while (i < opr_sz_n);                                               \
     clear_tail(d, opr_sz, simd_maxsz(desc));                              \
 }
-- 
2.34.1


