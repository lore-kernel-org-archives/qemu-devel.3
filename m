Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6246DCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGB-0004pK-Nx; Wed, 24 Jun 2026 21:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZG9-0004ni-Mz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZG6-0008Qd-Og
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2c6be9cd89bso7070975ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352321; x=1782957121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eQncSFZsFgVseAuhiRF3eFkhO3t/hu3jVm0WVWbPxQ=;
 b=EWHxEnoRLhJl+4jikAxh3eVoMgYK9eH+WyCeMFxZPoiY11KoaIUlrLDPyU3rnzkjS8
 X9ylb68MO2UoQZSmeuWLRlxIa7mGXKEyIqPXppItsqxbZg72f7L13DapAH5hBmYqkuwo
 8lfYQ+obyPczRuBKpdOgIxS2lfBJy/wvJHanw38iPTtl8dNpee+FvPAYL7tLGvnXdv35
 +WecckKER0Cl/PN0YgVVIiAxfx7R1IL7i1XLBVmeAu643xKRxln+HdqM40lRKX+3vX1M
 S7FK19ItpQU9beoxI7Np6Z04Iu10Q87si8xyqrLC3zE1+AaST0RhGvCm7BbId16Sax4m
 jqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352321; x=1782957121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2eQncSFZsFgVseAuhiRF3eFkhO3t/hu3jVm0WVWbPxQ=;
 b=HwFFuGywogTuIcomlnDV+EbNN6SKVY2lnjGhfR6U6mnuq6sI3PbgQsJpy4i97ScoSB
 Y2Ko74vAw10/f/vG2HYQOfe+hBX6C0MP20Lombn+LY6/kwaD6HW1rPe7jqvGmHkl2Sob
 gnGZfKK2yJu5Kuk5e3Cu4/7DmTvY63MJh/PvernxQ7zEatlQgbPPXGyKQIoJP7KLuPgb
 M4hxQLvZJPVxS8noAjJDooxFF/AqY5m8kpx3RbkE+QGwhvGN7lfYCyPA9l1KZn5xcdGK
 XyAfd4CO8WkhRYVDqy2nCtM8zWb0FdlRga+gl1F0eA5RQ/nsZa4SDzNgVSZ2inZs/kj4
 hLXw==
X-Gm-Message-State: AOJu0YxtGmn2JS4S1w3Qw/JV95TG0RFe03HUrQeIfyE5c/Xnq3CYsMNs
 lFWVokJMwFC5uPscdvfNazuQ4L8ZN7MNBI/fbIRc2VOYRgNOp/suZts50zo4ddbeEgtxBbnExXw
 1F5Lj
X-Gm-Gg: AfdE7ckzwHdajwOQ51m2Qe34jhcsjuGrYdqm7TFNVgUSSf1o5EcdZ0Ck3C0DSsrPB3Z
 bmBoX9gL7MIgNtfXi6HcLzZ+OP/t+vf4hAXpHsl5E408elt/gx0MJ0VNF6Vqva5vsK04C4Gvbfc
 grTz4wNcQXaPniiKKLBswxYjBGEDqBhq5NxmNwcDG+9dtJ6G19q9TT8iaKb0DgC8Bbyg0u432v/
 9E4/R2IuyEus26asZ32kuuPiKG9HKYyRKnY07+t5TCVz5fnslWJcBOTMPgpMdM+zXdJZ9R6n+Gk
 XQGetWyHVlCSr+2rR4K+KKFcOd1OqxDNNTVaCYwoVqCiVSQiswphZXfG/KIgLRWiGUrARnIWO5E
 Mnf68P+XglDDDOWDrNoDHonFWE/G5oRT6r8099gs8vqc5wXFKKwO1nq3gl2ULr5zkp7/UgOzvdL
 9VKvjv4qLauhrBVYyxQyg3aDE0/Jx3k91ia7+udQuYuMBzbL4Fpg==
X-Received: by 2002:a17:902:e78d:b0:2c7:f12d:5d37 with SMTP id
 d9443c01a7336-2c7fca15751mr6766505ad.17.1782352321096; 
 Wed, 24 Jun 2026 18:52:01 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:52:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 01/10] target/arm: Enable FADD/FSUB (half-precision) with
 FEAT_SME_F8F16
Date: Wed, 24 Jun 2026 18:51:49 -0700
Message-ID: <20260625015159.719300-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
References: <20260625015159.719300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

These two instructions can be enabled with either
FEAT_SME_F8F16 or FEAT_SME_F16F16.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h      | 11 +++++++++++
 target/arm/tcg/translate-sme.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 45213f71ab..cd78353609 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1605,6 +1605,11 @@ static inline bool isar_feature_aa64_sme_f8f32(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F8F32);
 }
 
+static inline bool isar_feature_aa64_sme_f8f16(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F8F16);
+}
+
 static inline bool isar_feature_aa64_sme_f16f16(const ARMISARegisters *id)
 {
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, F16F16);
@@ -1776,6 +1781,12 @@ isar_feature_aa64_sme2_or_sve2_lut(const ARMISARegisters *id)
     return isar_feature_aa64_sme2_or_sve2(id) && isar_feature_aa64_lut(id);
 }
 
+static inline bool
+isar_feature_aa64_sme_f16f16_or_f8f16(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme_f16f16(id) && isar_feature_aa64_sme_f8f16(id);
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index a79b0a9b80..b8dde80c20 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1335,9 +1335,9 @@ static bool do_faddsub(DisasContext *s, arg_az_n *a, ARMFPStatusFlavour fpst,
     return true;
 }
 
-TRANS_FEAT(FADD_nn_h, aa64_sme_f16f16, do_faddsub, a,
+TRANS_FEAT(FADD_nn_h, aa64_sme_f16f16_or_f8f16, do_faddsub, a,
            FPST_ZA_F16, gen_helper_gvec_fadd_h)
-TRANS_FEAT(FSUB_nn_h, aa64_sme_f16f16, do_faddsub, a,
+TRANS_FEAT(FSUB_nn_h, aa64_sme_f16f16_or_f8f16, do_faddsub, a,
            FPST_ZA_F16, gen_helper_gvec_fsub_h)
 
 TRANS_FEAT(FADD_nn_s, aa64_sme2, do_faddsub, a,
-- 
2.43.0


