Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3886DCDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 01:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcZGI-0004vY-Bs; Wed, 24 Jun 2026 21:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGF-0004sn-F9
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:11 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wcZGD-0008VI-Tf
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 21:52:11 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-37df72c9984so146863a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 18:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782352328; x=1782957128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7sch0aXO9sSrSQo97ZaQHXFizG0XuXDtfv+0zk4Dj8=;
 b=peYgqFCMqnBLQXRxJFVjyICRoXX5H3Uww5Yodxxqer8wbPAJoUKjPxXMT0emh8bfJE
 raeUvimhkOB7dq+fjtc0+469g6gW2wlj/bRgtwv+VheIyL94P9GR8v+mfICkkuaKCU7Q
 BA7yaq/AMOdvmo3RPNUU8dezOwwIw/F4luZD2cCOaol0/3y601G9KDk4eynO/dgrh3oP
 f7gbwsgtiHSF7LOtnDwJVLnaPZAUvYGvvvAlg0dsYL7r7wI22QF25dNJx7KtG2ENUpRE
 O5gItNZ1kZum3ZOc6jQEdkQnODso11TtqplSPpbFzf3ovoi+aNIjDF825rHzPypSt5s+
 vjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782352328; x=1782957128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7sch0aXO9sSrSQo97ZaQHXFizG0XuXDtfv+0zk4Dj8=;
 b=RseIFBmDuv1GrULmzKTlOwS+AGX+b55atCr5MtYxeM4WWFawoHBYqfwJ//8naw8wqt
 tqOaMlLRswiLLD+Ne6xUHgpPAaSJpMJPbmN9U8TXtAQtTrUSVxV6G1IkM7TB96rU4zjz
 Ajs7zPnRqxz/gLEwuYa88T2ZvOkxUucG0qtrGMPVYGtLiYPOZJ1ETAFgKutuFdWmbSUb
 6VB1PlHjLh9xASjOnLRObq7m7W+fdDM//83iHDFCkzUZdzTvocuGadxEDqq9w7NanXSl
 JQZr107X5yiTHnrNmp3dozI9P/CyhupPLNXSJwUmhoE6GQj1zEooT+dRAu6LUoJlDc2e
 kI6w==
X-Gm-Message-State: AOJu0YxlQHahajIUke83cLOCv/yN0/NLBa4e97j6WlyAuBevI5AQCyFb
 m22jYUvjnsbaVW7bJTlUilRW5Bz4S/CPZatF5snKx0NZlyn3k4nK7Jt9VXw+l4VJWnEOQOCNjgW
 7LvOv
X-Gm-Gg: AfdE7cm1ZcQIZlImOsrLfhgHihqtsV4vV1hiCEsZl2jnyTAqI4Kwr2KR/uzIRSwx1JD
 HDd+U5SpNGlnI3fWOU2QC+hSo2iEmwhOzu3rwjq7rxuTTrOArqAtduibsgKrF3VQKZOwF67o+NC
 AY3xSCGIaFu10v1pukIZ+k7aMp/s5bTc1xELEon84+2FGIWKWoVq4Yc+MTdwHK2/p7t817gqDmM
 Q46cxPQLYIrzwb6kELzeu2voSQjFoIv37lGvKWWj+uDuxpXoaFu3SRAvhrV/KYxDNmSQbj6n2Hc
 FwmjNPjN0YlxTTPPGJ9+5BffFYWMpxlemnND9SGF8pzDRYfJoT6O8rYmR5LkaNlQ0xFQNwwr1rY
 ukf+zM1MhE+sxQdwzdaOj6gp8njJ73IVaqhADaGWDJKJ0pT6uk0j39Fy+30x1EPMsWUdkCE9CfN
 x4NFkLIzivBRrBDTKPj4oek/ceHJv9sx7V3zhkKQnS4BWnHUL3Qg==
X-Received: by 2002:a17:902:f644:b0:2bf:211c:4980 with SMTP id
 d9443c01a7336-2c7fc8b106fmr6662345ad.35.1782352328271; 
 Wed, 24 Jun 2026 18:52:08 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8908sm9060635ad.8.2026.06.24.18.52.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 18:52:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/10] target/arm: Enable FEAT_SME_F8F16 for -cpu max
Date: Wed, 24 Jun 2026 18:51:58 -0700
Message-ID: <20260625015159.719300-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625015159.719300-1-richard.henderson@linaro.org>
References: <20260625015159.719300-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 3 insertions(+)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 20b9838520..42aeb29306 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -236,6 +236,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
     GET_FEATURE_ID(aa64_ssve_f8dp4, ARM_HWCAP2_A64_SME_SF8DP4);
     GET_FEATURE_ID(aa64_ssve_f8dp2, ARM_HWCAP2_A64_SME_SF8DP2);
     GET_FEATURE_ID(aa64_sme_f8f32, ARM_HWCAP2_A64_SME_F8F32);
+    GET_FEATURE_ID(aa64_sme_f8f16, ARM_HWCAP2_A64_SME_F8F16);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index e9eda8fbf1..42bff58e76 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1393,6 +1393,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F32, 1);   /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, I8I32, 0xf);  /* FEAT_SME */
     t = FIELD_DP64(t, ID_AA64SMFR0, F8F32, 1);    /* FEAT_SME_F8F32 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, F8F16, 1);    /* FEAT_SME_F8F16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, F16F16, 1);   /* FEAT_SME_F16F16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, B16B16, 1);   /* FEAT_SME_B16B16 */
     t = FIELD_DP64(t, ID_AA64SMFR0, I16I32, 5);   /* FEAT_SME2 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index a3a1607ff9..7b85ec6146 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -169,6 +169,7 @@ the following architecture extensions:
 - FEAT_SME_FA64 (Full A64 instruction set in Streaming SVE mode)
 - FEAT_SME_F16F16 (Non-widening half-precision FP16 arithmetic for SME2)
 - FEAT_SME_F64F64 (Double-precision floating-point outer product instructions)
+- FEAT_SME_F8F16 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to half-precision instructions)
 - FEAT_SME_F8F32 (SME2 ZA-targeting FP8 multiply-accumulate, dot product, and outer product to single-precision instructions)
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
-- 
2.43.0


