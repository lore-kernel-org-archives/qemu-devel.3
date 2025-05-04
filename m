Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CEBC3ABB0
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 20:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBgOx-0008PA-CI; Sun, 04 May 2025 16:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOo-0008LS-BW
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:23 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBgOm-0006wF-DK
 for qemu-devel@nongnu.org; Sun, 04 May 2025 16:57:21 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-224100e9a5cso51794745ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 13:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746392239; x=1746997039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=el8ZwnuFADKnWT5Jx67GSOlo5+a9PaEYQq8A/ViamLA=;
 b=UttDiJsLtPOGIV2Nk034IRbQb1wUNDHsuv1rmrapK0+kzKfbqmgGY3x13JndfNFtRf
 fOBne8X7dTHvTOj2+dJTJD7YhXGkFIgjT9gWS+zlEJ/bWX/7QFits31wanKC+ocGk0cV
 US3wiVaXdnfb7aAfpXPJtPMNrvxXL8kauolkEKdJPI7O1PXqDrZUHToNlgumHMQ+cgeG
 V/cVqxS0ePEVxaPrd9bcpumaCYJ38RfYWNia3PZFmPyEI98K2q6/A65S3n5WufDgD/CI
 YjpZHPNABGp9uoukgyGZN8kcyMfPI1fV/8yYAsvoFA5g7AiF3Sr62JXCssKyv91OX7IP
 O+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746392239; x=1746997039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=el8ZwnuFADKnWT5Jx67GSOlo5+a9PaEYQq8A/ViamLA=;
 b=Wm1AIhi1BOYwyUHBxIE3HArJDTGIDj2fzh8GJMgyVSuX7znHiNbYcFO6awZdy0tjsx
 B2B+Y82r+sV7p5/rSqQ8H/rSMyDpuWJTtWVdSZM6cNrA4bgGjeSHXF3VXlyA9EF6qcEs
 L/A/eCgBB5Dg46QtFyGGbd/U4wW0qUIk3YaYh/8sr4ZBrka8lmZVyP5CB/6dGmZNzm8R
 i22PYxdKdlZz6h0tWpZsi5IqeYx5wuiVA2/kJjhN5YvgU8Vp79oYld3fqtK4fEyzh54/
 zjhJaQ4IGUdLe55LZWOPuvr9o5fQcvzkaVze4kPvI+osF/UrxiIGEH1PfdU0hB/dA+BC
 9F+g==
X-Gm-Message-State: AOJu0Yzii+I9Kaebgt3Q1oil4izahOjTYbM9xe0AH5XQUHivzF5R5zYl
 Lbok3ggThEKALTJSJIQKyXmOaTcvXzes95bnB1IM9Mf3KfkUjh7lIKwprOF8dCoPAJFV1YXDi8D
 O
X-Gm-Gg: ASbGncsZeu7B+FxoD993IfzapZypqjNoHh4sUciCur37uy1YvThCexaHtWbf4MsjWjJ
 sDD9xqgmzr7CH6QSjKmB7UmZhgkeGWMVobLvUvyqgU2rq42vk1ShEqT9uEN8hZmuK84tDH20Gmc
 gxNwWI7nmFCCnpcwbI9154d3AMc8o576NRBimUC9J1FKvCou5pOPXXEvHdG9hb8XCo96oTyRsDM
 9cwVhHKl+RERqGUjboauMy/zR269HjvGVs9jhX+NXl5+MVsFJshM6EmcYi/NyUCbDjsW0ebr0Mn
 DlD3lxTbvWd01T2/rosgjo3QrSsYPf8TIhIzhkaLT+tP40UH5hE/PFEVoDxSA7dkJPMnZtoyx0M
 =
X-Google-Smtp-Source: AGHT+IHFqNOGFupG6vZZ04mTDkDLvR6mLVxc6zcIXa1r5VBpqbhjhIcrcaMe6SE/huYdsORxybyxRA==
X-Received: by 2002:a17:902:ec85:b0:21f:988d:5758 with SMTP id
 d9443c01a7336-22e1ea61942mr69746255ad.35.1746392238999; 
 Sun, 04 May 2025 13:57:18 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eadfcsm41346425ad.32.2025.05.04.13.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 13:57:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: foss@percivaleng.com,
	qemu-arm@nongnu.org
Subject: [PATCH 04/12] target/arm: Fill in TCGCPUOps.pointer_wrap
Date: Sun,  4 May 2025 13:57:05 -0700
Message-ID: <20250504205714.3432096-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504205714.3432096-1-richard.henderson@linaro.org>
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

For a-profile, check A32 vs A64 state.
For m-profile, use cpu_pointer_wrap_uint32.

Cc: qemu-arm@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c         | 24 ++++++++++++++++++++++++
 target/arm/tcg/cpu-v7m.c |  1 +
 2 files changed, 25 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 45cb6fd7ee..18edcf49c6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2710,6 +2710,29 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
 #endif
 
 #ifdef CONFIG_TCG
+#ifndef CONFIG_USER_ONLY
+static vaddr aprofile_pointer_wrap(CPUState *cs, int mmu_idx,
+                                   vaddr result, vaddr base)
+{
+    /*
+     * The Stage2 and Phys indexes are only used for ptw on arm32,
+     * and all pte's are aligned, so we never produce a wrap for these.
+     * Double check that we're not truncating a 40-bit physical address.
+     */
+    assert((unsigned)mmu_idx < (ARMMMUIdx_Stage2_S & ARM_MMU_IDX_COREIDX_MASK));
+
+    if (!is_a64(cpu_env(cs))) {
+        return (uint32_t)result;
+    }
+
+    /*
+     * TODO: For FEAT_CPA2, decide how to we want to resolve
+     * Unpredictable_CPACHECK in AddressIncrement.
+     */
+    return result;
+}
+#endif /* !CONFIG_USER_ONLY */
+
 static const TCGCPUOps arm_tcg_ops = {
     .mttcg_supported = true,
     /* ARM processors have a weak memory model */
@@ -2729,6 +2752,7 @@ static const TCGCPUOps arm_tcg_ops = {
     .untagged_addr = aarch64_untagged_addr,
 #else
     .tlb_fill_align = arm_cpu_tlb_fill_align,
+    .pointer_wrap = aprofile_pointer_wrap,
     .cpu_exec_interrupt = arm_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 95b23d9b55..8e1a083b91 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -249,6 +249,7 @@ static const TCGCPUOps arm_v7m_tcg_ops = {
     .record_sigbus = arm_cpu_record_sigbus,
 #else
     .tlb_fill_align = arm_cpu_tlb_fill_align,
+    .pointer_wrap = cpu_pointer_wrap_uint32,
     .cpu_exec_interrupt = arm_v7m_cpu_exec_interrupt,
     .cpu_exec_halt = arm_cpu_exec_halt,
     .cpu_exec_reset = cpu_reset,
-- 
2.43.0


