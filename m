Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6A9CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbs-0004rB-28; Mon, 22 Sep 2025 14:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbp-0004ph-AX
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:57 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbh-00048t-Hg
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:57 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77f2c7ba550so1514539b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566987; x=1759171787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRoS3UC8ynsEV5t3sfVyTe2E9WbHdc5gfYPgW1+H1wE=;
 b=agncZOIFEXRV6BoZVmNDjFhystcd57uVpRQlwVbbLzZxWu8dxYQQv7whCQMdP5SZAs
 m8dxYTyHjpF0+Mjy6wKDfzxMDMPgRE8+CU+v9LrtJDIP7N39sYajTKd3w1k44CxPd5ie
 SDPgg8x3pIDpHr8VwlskpsljMG8LxxpRYtzTqMjvR/aokm9/kr2Xbi14TG3bUrZf3Jrw
 mVwoyhyoqTXHF7GGfOqvd5mBU34qdAvhj2USHhV+7rQQICZVu4BXSpTyvBU1T/yoQZuD
 5Oe9WGr5JLn4F5XaAKC/A/osiWp4L2q9d65EUa71e/Ii7Xa22Oy9/q5L/7RDiUB2aRxq
 7ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566987; x=1759171787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CRoS3UC8ynsEV5t3sfVyTe2E9WbHdc5gfYPgW1+H1wE=;
 b=bbh9vfPz0UBh0auKtzgDPNuEwXH+4M7/rYAEb4q8xJo6DNoVxWIsWGxcFGxs6ImpUI
 4nfDKxlXy0YIAy2BkKQDPNGTlUbnNpng3hXEIAgi9+WFpf4dzpoUO/nB9In2LA56BujZ
 HfLLIGSLPNDzRoMKBhMDQCvBqcD/AQ74jy2H5Dba65OjH5g6BtdmRgRsV1VLDeKNFJkB
 M4P7eK73eWuX758KnzgKMC1jY545EfihJ69C+mRSEtHxxcLC1agDZQBv03OiaZrhS/Ju
 k9u9AM4+itlkUxPyb/xVMNFc+yeRmUbFN4wdgR4f2gb7Ien5pzgF7Ich0xqSBuna9YI5
 0dOA==
X-Gm-Message-State: AOJu0YxNpshqqcVWa44kuShaq4rHzHJBrR04i6Upzqf8uhaPBgFoeZ1v
 cG7btpyxWxsyRmsOO3qy7AkgUV7aN++TR7gZW5R77BlpwiAAueNsnJX1G3FHPfmhIA1/Su6QgNN
 bBYPk
X-Gm-Gg: ASbGncsTWc6Iy9xR1E1Xx+3I0qze8WJbgpCqe+ehwEY+gOSiVR5w0bJnupcF++VTeDE
 AkcSym5yq73LMhAiKWbYEbclXYdOumwimpvKonpEmfQRm/FjYNNUmZV2iVV02Jbx88QYwiXHBSQ
 L8etVg5ERjJSDQwkC8dBHGURBUZbz0IL3X4L6TPfdQ2LtWeAyCK7VOgy2eyrExy8VVb+EqIpbj8
 VKDVLljKWs4IEgoPXefcSEWGHVvU1GTzu/n8XDIZkBj0niOwMqxE914K4pjtF24sgcI0VhX43Fe
 lLtwsWlLlHWrPT8NCQPoIyzFp3U+YUKeg0TVWnFUCGS3bOVASt+7PZtOnf+qYPg+K+ZfRpx2pV1
 ZMFXImOqFaqq49bznOY6FRb/dDbJT
X-Google-Smtp-Source: AGHT+IFQNqhco4itF03EKjOw3uvmKZWs6kr/zNFfVaHpdJUJzD/Uzstne/WFCk/fAKveIeRR+rWxrQ==
X-Received: by 2002:a05:6a00:2190:b0:77d:52a1:ac6e with SMTP id
 d2e1a72fcca58-77e4eac6e2fmr16198998b3a.19.1758566987601; 
 Mon, 22 Sep 2025 11:49:47 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 15/76] include/hw/core/cpu: Invert the indexing into
 CPUTLBDescFast
Date: Mon, 22 Sep 2025 11:48:23 -0700
Message-ID: <20250922184924.2754205-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

This array is within CPUNegativeOffsetState, which means the
last element of the array has an offset from env with the
smallest magnitude.  This can be encoded into fewer bits
when generating TCG fast path memory references.

When we changed the NB_MMU_MODES to be a global constant,
rather than a per-target value, we pessimized the code
generated for targets which use only a few mmu indexes.
By inverting the array index, we counteract that.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 11 ++++++++++-
 tcg/tcg.c             |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 30e335d7d0..89fe937a6f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -595,9 +595,18 @@ static inline CPUArchState *cpu_env(CPUState *cpu)
 }
 
 #ifdef CONFIG_TCG
+/*
+ * Invert the index order of the CPUTLBDescFast array so that lower
+ * mmu_idx have offsets from env with smaller magnitude.
+ */
+static inline int mmuidx_to_fast_index(int mmu_idx)
+{
+    return NB_MMU_MODES - 1 - mmu_idx;
+}
+
 static inline CPUTLBDescFast *cpu_tlb_fast(CPUState *cpu, int mmu_idx)
 {
-    return &cpu->neg.tlb.f[mmu_idx];
+    return &cpu->neg.tlb.f[mmuidx_to_fast_index(mmu_idx)];
 }
 #endif
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index afac55a203..294762c283 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -425,7 +425,8 @@ static uintptr_t G_GNUC_UNUSED get_jmp_target_addr(TCGContext *s, int which)
 static int __attribute__((unused))
 tlb_mask_table_ofs(TCGContext *s, int which)
 {
-    return (offsetof(CPUNegativeOffsetState, tlb.f[which]) -
+    int fi = mmuidx_to_fast_index(which);
+    return (offsetof(CPUNegativeOffsetState, tlb.f[fi]) -
             sizeof(CPUNegativeOffsetState));
 }
 
-- 
2.43.0


