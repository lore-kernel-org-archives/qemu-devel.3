Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B5CF9B609
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUXs-0006uK-Dj; Wed, 22 Apr 2026 06:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXj-0006oh-9u
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:51 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXh-0000iI-98
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:10:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4411e1eba51so1925930f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852648; x=1777457448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
 b=BWrMjJ72/kZoUl/0EVsS3S1mC1e3fB1a8afDzJPlXvymWoZbgekfmCet2zp6f1t53V
 hzDT7brJ/RZVfh9LrhjLBT8HwNWnRJTjffBHcoV0MSTwrMoMwTcDVt8TxueAc79a3jLV
 VnwXZWUVZ9EpjLbegxWg+pwHBUoIBmimWiHjV7nFHSfhGkN4TPhQoYwPuA2Ilumo55YB
 JV7Krl8gbGxRWVWSgPg0VWDs1duL62lIyZ/miSs5VGGZEtQPfEB3fRfAJsBijP8j+nav
 OckTmxomkEMQVadoSbAekeXXeloVebPFQvbRQ4i/jPs1kUd1SIprZKuI54qFIL95EUDE
 BWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852648; x=1777457448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K6n23oz7LRRQlFUUM3gTQS/rrKewMUhskSZOvSJMe4M=;
 b=WrKSxL2DL1gMjJst2B6YZxCTce+eJh7MSLTPoGRix5eUxxuhjDO1Kls0yM6G7QcjvF
 SvcWkDnLGXu4W+huUDvGSEDGeTRsPgNv+wjKdnh8kRF4zrRm8AV9B90a4UGN1Slj8ydK
 kCMqwnxhKyN6aGAHZAlnsBkutQREFHVAHhu1pWVcZvnzEZRep6l44ga2M1ON6e0LT78t
 gapVdaosEAQzLMZvjaScZqT2vrYtX3vQ1qQZnN1v5j0zl9/GXD/El6EKN5ubZepZ3HFT
 aGad/BbMSJyhbe6PPUG9TARmhMexfw68ulrxSaJFNNU4yM3xQ/nxjKCoQfmZEN09dKZP
 e9LQ==
X-Gm-Message-State: AOJu0YyFbvgLB6VqpnuzNFy8bem0GEfmXLgUXYOW7JS/I4wILL8sf5z3
 sXzxQb8Cn3L1uisORMYOq5upa4E+31k1F+uUEAJzpUkWGfp/EFTAqBcy2ZIpPgJFgD8=
X-Gm-Gg: AeBDieuyqgy4Xx84mm8afhmr6KsF1RPQ0eqLG43jqCyA/BqyoLrrFnifKbP25uluGjh
 s1J8Bwoi7a8mmTxWFkFEhEq1/AWZjtA9Gf30Naj6OMCfY+ZOSHdUbpRoyn1dOLjj9Dsi+9z2EAa
 Wv+06iZHm0cfMG27n7NPe8Pi5U7kULRwTuqEq+s2IsJEG8PUie71gZEULRUT7ZYY8f8iJo5hv8C
 NtIqfBvWeB2SW+6ypoMw1d7G9J/GwYiCdYrlfFeZe+KLlIjduoG/0PXgNeGms+QWHyXt4KAZk8H
 yYbRazusRd8wuRP2xxJrcv5NAkYXZVl2ScF5s59BYjIQB8bcOJtoeCLmRIjOQc1iLz1pIRGmDRr
 IAlGCXjRnDEynpUxuTQpWwfa6PiinA5nPSNnhnmzstLwmnxqb3H1P4csx+L97wdQKcNLkLhCKQR
 JZW8AOQKxdcDUeVnYq95tBi6pIZ08rLsl0+Q==
X-Received: by 2002:a05:6000:26ca:b0:43d:7883:87b9 with SMTP id
 ffacd0b85a97d-43fe3dc7b56mr33421360f8f.16.1776852647586; 
 Wed, 22 Apr 2026 03:10:47 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm48291163f8f.24.2026.04.22.03.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A99A55FC04;
 Wed, 22 Apr 2026 11:10:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 03/31] target/arm: migrate FP/SIMD trap syndromes to
 registerfields
Date: Wed, 22 Apr 2026 11:10:14 +0100
Message-ID: <20260422101043.1234229-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

The syn_simd_access trap was never used so remove it. We should only
see the COPROC encoding on v7 architectures.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is16_bit directly
---
 target/arm/syndrome.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 29462aa103c..72051443d59 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -337,21 +337,26 @@ static inline uint32_t syn_cp15_rrt_trap(int cv, int cond, int opc1, int crm,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an access to a register of
+ * instruction resulting from the FPEN or TFP traps.
+ */
+FIELD(FP_ISS, COPROC, 0, 4) /* ARMv7 only */
+FIELD(FP_ISS, COND, 20, 4)
+FIELD(FP_ISS, CV, 24, 1)
+
 static inline uint32_t syn_fp_access_trap(int cv, int cond, bool is_16bit,
                                           int coproc)
 {
     /* AArch32 FP trap or any AArch64 FP/SIMD trap: TA == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | coproc;
-}
+    uint32_t res = syn_set_ec(0, EC_ADVSIMDFPACCESSTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
 
-static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
-{
-    /* AArch32 SIMD trap: TA == 1 coproc == 0 */
-    return (EC_ADVSIMDFPACCESSTRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL)
-        | (cv << 24) | (cond << 20) | (1 << 5);
+    res = FIELD_DP32(res, FP_ISS, CV, cv);
+    res = FIELD_DP32(res, FP_ISS, COND, cond);
+    res = FIELD_DP32(res, FP_ISS, COPROC, coproc);
+
+    return res;
 }
 
 static inline uint32_t syn_sve_access_trap(void)
-- 
2.47.3


