Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727DBCA0EE8
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXct-0002EV-Px; Thu, 14 Aug 2025 09:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcT-0001td-8o
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXcN-00055x-Ba
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:03:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-76e2ea94c7dso1332223b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176618; x=1755781418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=mBUhvRP4DAKA7pa1C+HJF/Uqh2PMDcHzBdQve9YWXjpQbo/36cqlZGRSDf6KhQEg7C
 1JZzi/dLCZc+j/HAVCPGqCphsvND/lH5kLVA4lsQ6CFvVB8K6Dp8G/1xAZH/DvTm2Ad2
 wS+J9yq3KAgAqPvOkB1dLmxKOZLrjbT6RGkoyZw6yQNW23Zz3RE/u92309qjfzH3qbO/
 aPvnrsZbv1DT9OICbjCKO804liJIGSgA5COnYNJtn8+nE7BRADklsgJ43ZgKHtFm/vof
 8r+o+KR/DLaSZK64Quey4dM8hNv8/hyVSsmLsx7Jp7iVqz+Fe/5yyawlQmhVifFSHDT7
 weaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176618; x=1755781418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnGv3gaWQ9shrmt0WGxn8YCEO4EdUIFI2jl/MhJPR7Y=;
 b=dsRefpUg35JT9PMvc6V4+cSRQrfldeE+Ki1qqB1legudLyCfPd9AZ4cTkJV54fk08e
 +bg1sKyEPNiFQz58rOM36iSO/mElKuV4y0Gaqn9+NTM+LWaw+GBhQvkikj/huHEmeXLQ
 qYKbvGfPppC82gDZznS5JjEZz6U3bAU184tQhGmKb8evMFRBBoAbG+nhTz/2yK4dkIZC
 Xjtj4NdYP+QR/d6e7p7W7Ptp50TQO3bJIM0jjZwrkybhCU34TLH6bqTZWMIhLATqYcb8
 lm4h1soLV60uODbveTLd9V/PWvgiGARuRU/u/n9jHcWhs4XLlbTQf3/Q8Np/aEH1Izmb
 iOqA==
X-Gm-Message-State: AOJu0Yz7TWENQWt9dwGzNsNvYifbZZlsxBbGcoW5nV6P5F12fT19fgaA
 JM51C23Jb4/CpVi72L99c/ZF0cU0WacVTzw4eGNUMGEBevlCsO7SPFuYOGsMUSnZDUoDo3zggnD
 Mw/wS5ZM=
X-Gm-Gg: ASbGncvGRKQ0hLMI9q8Kni7zRR41w7qFk2OWsuFWE15msNhVrxu+z1qBQrC6e+FBTMg
 xqyeCS/g4dCuU9uoWwo22WXz1A5iPs5NWvblUnQaxHcHWX6i5/RO9ObJ6s8V6miL0g5DTfTj8d9
 Jsj4OtH8I5jLNPavHaLa4QWWu3m05d8jBuljbs/g80kBdvXt+PvllxDI+kA2z+yTlf7grXLnIne
 BotIHk3fhIU+jrirgfVqroB1okLeo0BXKoSFhjbcgFcvXUBI75y8KDzi4jE5WIs/GkYIfDhFonY
 2FEiNp7V1Oi5xScWNVC2nmuwAVlJgrCTi+bPFlA7X0Aw+VZ7X04wm9cDaw++WqZ8yskrPhHcSxE
 O3qmc2n+2jSB4j3L55ZWXAXJvlOEQ3xDUYpI5UQngvV9z0LA=
X-Google-Smtp-Source: AGHT+IF/JNCY4v0x4Lk4N++1yMphTgYbY1dOTRMD8YFOhXWbC7eG2cXbUZREL/n5MSHYmFZ4BMh60A==
X-Received: by 2002:a05:6a00:4f91:b0:76b:f828:34e4 with SMTP id
 d2e1a72fcca58-76e2fc2629cmr3915200b3a.6.1755176618032; 
 Thu, 14 Aug 2025 06:03:38 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:03:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 46/85] target/arm: Implement gcs bit for data abort
Date: Thu, 14 Aug 2025 22:57:13 +1000
Message-ID: <20250814125752.164107-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index ae2acd6727..f1983a5732 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -28,7 +28,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
-                                            int fsc)
+                                            int fsc, bool gcs)
 {
     uint64_t syn;
 
@@ -78,6 +78,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
 
     /* Form ISS2 at the top of the syndrome. */
     syn |= (uint64_t)fi->dirtybit << 37;
+    syn |= (uint64_t)gcs << 40;
 
     return syn;
 }
@@ -252,9 +253,10 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
         syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
         exc = EXCP_PREFETCH_ABORT;
     } else {
+        bool gcs = regime_is_gcs(core_to_arm_mmu_idx(env, mmu_idx));
         syn = merge_syn_data_abort(env->exception.syndrome, fi, target_el,
                                    same_el, access_type == MMU_DATA_STORE,
-                                   fsc);
+                                   fsc, gcs);
         if (access_type == MMU_DATA_STORE
             && arm_feature(env, ARM_FEATURE_V6)) {
             fsr |= (1 << 11);
-- 
2.43.0


