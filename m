Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E21C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjPfw-0006CG-Ke; Mon, 13 Jul 2026 19:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfs-00069n-Ia
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:56 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wjPfr-0005oe-1I
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 19:02:56 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ccf2360620so2529245ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783983773; x=1784588573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LQCl/R1yssx48UUucnUCgjegUycmuRreckK23eAbJps=;
 b=WOaBt+4pPj0DsSHIQs0N9OYlXfoAA7u5eSE0sgTJ8vT90tlEkKA2hj5pnYEhk9ToZ8
 wTg5nadc27g4WWWPu6dzmmoyntsYRKXtvKUjSVLvvuEp4m3pEn1xVhOJmgjfSMltmGqB
 Y+i2bcNZbk06WK0njzRhjYdZm2TuQD0os777OKNe6dCjhNkOa73WOU7TDD17peSH3px4
 RZwwbNzbknZxggFE/IiQttYictD0895gQnChwl03NBkr2PUSI9e/10ypVkeoILACAXDt
 ZaSL0kKGn7OmGt3Jj4aZlx5BoTh5etjlf8iRaEnsN3axfnLNsNiyOpecY+v3rw8OCPJB
 74bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783983773; x=1784588573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LQCl/R1yssx48UUucnUCgjegUycmuRreckK23eAbJps=;
 b=AD2jZJmbfsr4LAk3DvQsADt1KOlYg9jbzIAlz+Vg5wsXaYUnlcXvPeXbC85auhHGbs
 yQeJBr8dLkpzA/HvSDMSlUIrvOKMSxCOHt7Xhxq0MU/9q/MLYOGsmOPGkJuTeciYtuCg
 jLIAiXCxOCx0zH0fMX2TtHpXkQlEmdFjolc0WD7MOtppPFjmlqX3TMKkiMs7XSzfTPT3
 2axwRbj2Yfaj7jiwyHW35cuM83cr23C8jkvEyx9WJkqR/9XX12/1xXQU6Gp++Ed+vhqK
 45gQtpGsAEdQKN/pSgIzMi2e+LqCB7lN+28h3Ugtj6VWgDn3f36s+ePObxxHGmHePiAw
 ZLmA==
X-Gm-Message-State: AOJu0YxDkmOfAVrSHvpUTNHRkkU4RS4QS54JHFnwsv23AxWnmVNq6WFQ
 iJrEi5yXHbrObOjdvBPoK0Za+hhVdTuvbCxkGiUfr1VQjsnd6IMQoJxtnSEZgYU9QLmWXpfIcXn
 QkXeS
X-Gm-Gg: AfdE7clsIOdtUMhI+ajk/i70yvP1gZf8ZwF/PNh7V0Q8T1a06dhSA+/ZTKGr9sX+e4C
 mQCOS/yQYYfWfMhqfk4InMgnuQ1XfIZM6MkQW4sGyjnv/yrXvzrDW4ENoYzM+qrd4RMJQ5VBQtK
 0F/bS9ZG5QzT/bjtX3sgOL08avo2EsvVWAWfNARdNu9VJ9H5wtDdsJBTt+0bVSlQDHpfsZDioFt
 Ovi6Y1CnAYlgUaA9MiP0+5iJFOg20I6eqfsIh2inPZX+AKDolWpHOIuNWehxa1M6wVjKDGJr/R/
 922etA1mJAh3vAXvWsDtqq+zmE6U/yGbl3JQb9eOR5RlWa14EFlkG1Ofbx2P5EPpHlmF8Wr+56r
 sh4M0JXrp08kysAkVMx3DxiB7/iQDg0PsvCsl7nobng8pUTwkiRLJ5vTJHs0Bjlh7o9Y8FNa3Pw
 tUre9D4aHcHVvMqsLrVA==
X-Received: by 2002:a17:902:ce85:b0:2c6:a981:b591 with SMTP id
 d9443c01a7336-2ce9ee11b3dmr93941825ad.30.1783983773495; 
 Mon, 13 Jul 2026 16:02:53 -0700 (PDT)
Received: from stoup.. ([71.212.146.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf8e9csm106902965ad.24.2026.07.13.16.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 16:02:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/10] target/arm: Enable FEAT_SME_TMOP for -cpu max
Date: Mon, 13 Jul 2026 16:02:44 -0700
Message-ID: <20260713230244.70174-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713230244.70174-1-richard.henderson@linaro.org>
References: <20260713230244.70174-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 linux-user/aarch64/elfload.c  | 1 +
 target/arm/tcg/cpu64.c        | 3 ++-
 docs/system/arm/emulation.rst | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 64e25a04e3..48be49580a 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -177,6 +177,7 @@ abi_ulong get_elf_hwcap(CPUState *cs)
     GET_FEATURE_ID(aa64_ssve_fexpa, ARM_HWCAP_A64_SME_SFEXPA);
     GET_FEATURE_ID(aa64_fprcvt, ARM_HWCAP_A64_FPRCVT);
     GET_FEATURE_ID(aa64_sme_mop4, ARM_HWCAP_A64_SME_SMOP4);
+    GET_FEATURE_ID(aa64_sme_tmop, ARM_HWCAP_A64_SME_STMOP);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 8a3ebf6321..24f34947ec 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1384,8 +1384,9 @@ void aarch64_max_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64DFR0, t);
 
     t = GET_IDREG(isar, ID_AA64SMFR0);
-    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, SMOP4, 1);    /* FEAT_SME_MOP4 */
+    t = FIELD_DP64(t, ID_AA64SMFR0, STMOP, 1);    /* FEAT_SME_TMOP */
+    t = FIELD_DP64(t, ID_AA64SMFR0, SFEXPA, 1);   /* FEAT_SSVE_FEXPA */
     t = FIELD_DP64(t, ID_AA64SMFR0, AES, 1);      /* FEAT_SSVE_AES */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP2, 1);   /* FEAT_SSVE_FP8DOT2 */
     t = FIELD_DP64(t, ID_AA64SMFR0, SF8DP4, 1);   /* FEAT_SSVE_FP8DOT4 */
diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 4f413d69ef..a4ac2a2c85 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -176,6 +176,7 @@ the following architecture extensions:
 - FEAT_SME_I16I64 (16-bit to 64-bit integer widening outer product instructions)
 - FEAT_SME_LUTv2 (Lookup table instructions with 4-bit indices and 8-bit elements)
 - FEAT_SME_MOP4 (Quarter-tile outer product instructions)
+- FEAT_SME_TMOP (Structured sparsity outer product instructions)
 - FEAT_SSVE_AES (Streaming SVE Mode Advanced Encryption Standard and 128-bit polynomial multiply long instructions)
 - FEAT_SSVE_FEXPA (Streaming FEXPA instruction)
 - FEAT_SSVE_FP8DOT2 (SVE2 FP8 2-way dot product to half-precision instructions in Streaming SVE mode)
-- 
2.43.0


