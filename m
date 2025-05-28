Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFCEC5AE59
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBwz-0000WT-92; Wed, 28 May 2025 04:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBwF-0008Aq-0M
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvw-0005Hi-9K
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:15:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442ccf0e1b3so54554035e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420080; x=1749024880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ax++RLEDlRrY1JJjLtw31k8EuTvopwPDgXmRKqROuTI=;
 b=CqMzu0b+DaVmgylJZgizMflka3+gdP+BWu5PajuTwgK6BUyXxqw9noG9RJjB3Ra4aq
 5QC4YFxaBxL98RDD4UIAiyiVhz46q/OnwyvVgauwObra7tZkC/HkURESGKPd+/+5HoNY
 2h1lKbxopkxA4tD6qZKVp+8+bqyfSVKx6mpINFA4suoaW3jxTNtdK+3LA3xSKAW+3Wjh
 3er7VJDB191V5xNBHPsjPTV3rwtoT2pltdhBQj4wcfqkg+ZxKZaZ9TqOlFx9RRvOrN1P
 mu56OB1ZKXxARn7FJ9NtoJJCOQelX2OAG9CU7HeTqDT+WJtc6zml2dlHTscJCM1JJN9X
 j6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420080; x=1749024880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ax++RLEDlRrY1JJjLtw31k8EuTvopwPDgXmRKqROuTI=;
 b=BrAvVdKanQFVnuXMUwO+fw2HYDS22MEz12iNJa4KmgM+weEWOpSWDbdWTM8ld1xkCR
 R+OnsHFhWrJb/rJScR42i+/hi6rTNCW4ZRzKJMsbch4uKZXm8UY6KUyf8z/xFux7nm8i
 Uo0TLBOBZTUTHOA1yN74AfLmnybIdCW1jFQfQ/AGCMg0JcBu3miqr1PuM8igz7XBLxMJ
 r2bqK8igeqv/gsaj0cWNF56lB6VZHz+2IMMVnnX/tqXKpKT4SeOkQ6ij0CC6FIoJMd+M
 l/1vDyZForz0z7SR2A1mIxbltW1shmZXepixg1y95XsJspM80NydsQTMzhTQ1EAmD1l2
 QbbA==
X-Gm-Message-State: AOJu0Yw/+w5s8Qt819Mmx/uHg6ymNlHg0AnWPHvSu4CzphpLfIHbbx6B
 Saa9zDNmWDJC4fgHUyUnCkGo59SO/JDyhfAYsQ8yYxvFrxOURErDPRahm6xQyHSdNL7CfKR7kbi
 A83SxYa0UNg==
X-Gm-Gg: ASbGncvG0XAcFvm4B5qlau4v71tPJHlIOBRiZrk/TJ15K2ruRARGiSD89C0PmLYuoyH
 HePgEt944T9hWBHHX511ESSx+km2dYhF9AjYeboR+jy1HxtjHVPCgrjB9DfGzzWnBaW8KjDRdzu
 TWSleUt94xkGEjIjrCCN6UL7NKH9qhH6Sn7gQJMEMtuf7U6EjwEdqX+dLM6P6DZDZt/TYNHkRtj
 AzrXnRYp4hpu8+/24Yb7dnRBYE+acX1msnMgovA9MKn3AmiUgjlVJGOMmUXyR0mCF5B4t66dxxg
 b3fbAtCyMl4AAHi2dCR27AfRFKnQQqRsUccqylJ6tNY6V0pHt0/pObDz
X-Google-Smtp-Source: AGHT+IEJ0IRtGgkd+PHdiVJNb2Q9qeUY63nP40JBnFHSo9M8yVvaJ16/JNM0cqJtUCNHEE/pFmAk0g==
X-Received: by 2002:a05:600c:6285:b0:43c:ea1a:720c with SMTP id
 5b1f17b1804b1-44c91dd127bmr146750765e9.18.1748420079588; 
 Wed, 28 May 2025 01:14:39 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 20/28] target/arm: Fill in TCGCPUOps.pointer_wrap
Date: Wed, 28 May 2025 09:14:02 +0100
Message-ID: <20250528081410.157251-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index ca5ed7892e..e025e241ed 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2703,6 +2703,29 @@ static const struct SysemuCPUOps arm_sysemu_ops = {
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
@@ -2722,6 +2745,7 @@ static const TCGCPUOps arm_tcg_ops = {
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


