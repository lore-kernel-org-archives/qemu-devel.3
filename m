Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD28ACA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4cl-0004zC-4B; Tue, 26 Aug 2025 21:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cV-0004WK-GL
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cR-0007Mq-2P
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-771f3f89952so406191b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256777; x=1756861577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hk62+AS/e7MZO34KLEc7CJ5dvld6WhuGbXC/O1uT0s0=;
 b=xK82WJiEy7nUknFkakkRX+1mr0JBJVUdNEwcPS4/cR9jzUgZA9am1q2OM1Ck2egm2n
 gXA+33amxUeKRmv7D3S5Ogm+7IZAcC6Wuv7JuTx6Kg2rce/yFUTbjz4V1MF+BKICEgkt
 hx8Ic23eXw2V7TTVcclYp/cOW3/91vb+FkN/IcctkeyplPKLG+1LOMNcqslEm/iOAbp8
 qvNTuS3zX8TFAkUj2D5khvczr8mbIN4C4lHZyUqyiDJML8LKRXAUsRSE9vgf6mSHU+X7
 2VOmMqDPLixn0wbm8/IXcixrQxR4vqYbC/A/HIQIQvuT410YDAak1+tgt6jC/iG25cxm
 a3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256777; x=1756861577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hk62+AS/e7MZO34KLEc7CJ5dvld6WhuGbXC/O1uT0s0=;
 b=UhtHYFMVC4EJEjueSFiiJ5laQZWOFXpZoMPnQmih4PTJHRQUzuCtOwLZUcLjmesZZV
 vxCjy8Q50U6oJEwecHjXPMk7xjJp+ntvmmc6ptCjUHzPn8UxgjOLJQUc83LRT6coeoDv
 ok5rbODGB2IefZkQsnFlfzDIcZHBEqkB44nE0FClEIqHoX97WFLavnJT50ZH+1MIS8Ix
 Z68FbP0JmCCrjGSwdBEcZN4UpRdFHiSrDwJ+JO2WYPda1Z19qatXIPXdmsS1b4u7W66f
 G57kCb4brblZAEEYGVqnkgz3Gw10AMicR6otNJ7JSFVZRLXHNqlOKgU0Wp+l0iNB3rQH
 Jy0g==
X-Gm-Message-State: AOJu0Yzg/UZ5y90EDfWsNJYaNw89bniREIFxhp58vDyjW2qU/CZEVLTq
 CFGGHnhPJ7Hvfa3KpX5tZiOHqSTbaDGUgLTqbDZV7q4pSmAVp5G67SNrif0mlMCo7/8zcGlM9dg
 YgXLCTDg=
X-Gm-Gg: ASbGnctTP299f/L7MyK3duptHkQdEx6V9kGrewBWGXK9dCwMaoIorlEkjZnB6YteDEa
 PQQ4DWdJcymVeu6BZ7ol+0w6CQ2k5ou5odEw29dZtX5dMQoYFjfcbwrjrY3dWN99ZhXb2neJrJi
 +pesfsuQPK0YXmSXDZcHjKTd+Cl1H7bfMhYSkpVxS61X35AMp1Ba+AThAZTk7qNAadqk5DqGdiY
 RvddVwIB9FTFvi5sWyCGVMHin6dRbMiASxeuXw8p3f1Dh/MpPOyk/aAbuNAlty7DjzM+x9m+/Ix
 H9bNRX+Z4lYQP0Tm/G9Bkwa3NQQP1sgI2T17lv9DUBCWR6CORcDbV0rRw/A8EcrQmZiZbtp3B0n
 7nR0ySa45uz0QUnWoBN+7GxG7YWCExRCD28ko
X-Google-Smtp-Source: AGHT+IF2e4b3sa0OjR59rnjuDsbCx4wW2b7oLRUX2W40oZ6u87rwJ4jKBc/9JCyG5FarrMKhzKXgMA==
X-Received: by 2002:a05:6a00:4f83:b0:770:57b9:c99f with SMTP id
 d2e1a72fcca58-771fc293bfamr4653914b3a.9.1756256776924; 
 Tue, 26 Aug 2025 18:06:16 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:06:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 13/61] target/arm: Restrict the scope of CPREG_FIELD32,
 CPREG_FIELD64
Date: Wed, 27 Aug 2025 11:04:04 +1000
Message-ID: <20250827010453.4059782-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h |  9 ---------
 target/arm/helper.c | 12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index b610716c24..812fb1340a 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -991,15 +991,6 @@ struct ARMCPRegInfo {
     CPAccessFn *orig_accessfn;
 };
 
-/*
- * Macros which are lvalues for the field in CPUARMState for the
- * ARMCPRegInfo *ri.
- */
-#define CPREG_FIELD32(env, ri) \
-    (*(uint32_t *)((char *)(env) + (ri)->fieldoffset))
-#define CPREG_FIELD64(env, ri) \
-    (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
-
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs);
 void define_arm_cp_regs_len(ARMCPU *cpu, const ARMCPRegInfo *regs, size_t len);
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 35a176ea3b..3a9d8f0ddc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -51,6 +51,15 @@ int compare_u64(const void *a, const void *b)
     return 0;
 }
 
+/*
+ * Macros which are lvalues for the field in CPUARMState for the
+ * ARMCPRegInfo *ri.
+ */
+#define CPREG_FIELD32(env, ri) \
+    (*(uint32_t *)((char *)(env) + (ri)->fieldoffset))
+#define CPREG_FIELD64(env, ri) \
+    (*(uint64_t *)((char *)(env) + (ri)->fieldoffset))
+
 uint64_t raw_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     assert(ri->fieldoffset);
@@ -71,6 +80,9 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
     }
 }
 
+#undef CPREG_FIELD32
+#undef CPREG_FIELD64
+
 static void *raw_ptr(CPUARMState *env, const ARMCPRegInfo *ri)
 {
     return (char *)env + ri->fieldoffset;
-- 
2.43.0


