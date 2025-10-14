Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75D9CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJo-0002SG-KI; Tue, 14 Oct 2025 16:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJZ-0002Ii-B0
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:14 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJ1-0005MV-C6
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-28a5b8b12a1so52103705ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472451; x=1761077251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ml8IrqFS6Bp/u7C5UDkNEfubshsEhfFYuVLQAR5MCA=;
 b=ZJpfN1GmimFihjUFMNTEmOzopYz0+6uogVTbLiI63l797ifdX8Fq3y5g0W7T+YdOwO
 8ULPNHzn+6jkQF9PWTIbwiFJa3jPO0RrU54RJIQmaEe2KtVFxGxoFsDIHbEL6P3NVJxH
 xAe2mphyanTXJ+sd4FAcqnFvoPL6ermznM7qPOD/xqtA+rNWmGfxRuUig7T6SSzrRhdP
 fIjVDoHoK/GtmaeFlBjHRA0UHr1co/IsbXdsExUrFtXgXSbjjqhSxKtz+/J5bJi5NrNH
 tM/bF7aGvN4aG+k1yNLFDX1yULdp3RZ06eWAhiB4feFFVic7JlHi1621e0Y9YUusTTE/
 OPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472451; x=1761077251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ml8IrqFS6Bp/u7C5UDkNEfubshsEhfFYuVLQAR5MCA=;
 b=IxxvqsDIDzY0W/JNEw0uzN5PhBB6VnHor3TBGmOdyiRwhc4M9IofQeXDWjkIbYjRS7
 WeK2tWRhSAkTp6U7StR63hnUwmcBmUARB0F4sbkbaQIcU7oJMKOF2r2ch4EX82MTumbc
 x7a9Y6PpYE6OYLFvs3Fc2XxfzimMn6LqUxePXCPgvvpT1TIgKivXKXeySjJcMimy8twX
 Fcras/SQjA5Ui4BKLCUOmDXUJNTXCzu6P7vl3C1GxlVKfBRk7gchQCtveog+4DID+x39
 pZsI1G7DtKr5txD7tsP69W/Tu0ajrQxRRCxIOGYUoBl9doXLp4b3qnl6uTxyhtCLtzZp
 z/VQ==
X-Gm-Message-State: AOJu0YzqgDge5+4NLeSqvKSebbiP355+j0MkCNh64SMwJVPAxYosiqoe
 VQnEFnrRUb9h9HcfJZH7Qc7KtZU6BV9zDbgJCXC2R6Fms+qdJzD0nnCrGDvyMV9vHylnzWW62TX
 QPpLvxZE=
X-Gm-Gg: ASbGncsQUL7hgRCPNe3TMD3BEHzNzhV9udaR4UEQatvJhmmnetxOAZm/kjgg90RWlPD
 mRVf/rAkatJmKQOWTY7FZXKZHlF8lqaRxOCjxysPfXBLhPDkQCRUNYwbkbL37SLxoR2Ict/2UtD
 bxp0wraZsqgh0iMfxpOuj54lJCF7RBvs8oWVOZCQXqxNH7BrNaG/WOh8+Jj4JRlrZFb7w4qRMuO
 OSzWgoFHKUOssKJ0CmNnEJQDh4x28BkAEIl24Mt8Df2bNEa40ebgzY6PC92evn0EE6C2/hcR0jE
 povvKYDxg3AvmmKEZm5vOQLkeB1KRmJ2vtGkfFtbW3cmjj+x6HB4wISLVHNjNl+PtE1tMY9aDm7
 JzPvM6bzW2RVVCvCzw9XKdLGcMI9zI8Qwc/JbrizxicJRcTWUL2mXuglhTPcaNQ==
X-Google-Smtp-Source: AGHT+IGddwtrEJT9yctbOJQ5fnpwgPSu7nfi3Kncqa2YkkR8NuSG8e7a/PuiFQHaBD/FSYpAeAsUEA==
X-Received: by 2002:a17:903:2349:b0:290:56e7:8ca9 with SMTP id
 d9443c01a7336-29056e79048mr149323765ad.52.1760472451587; 
 Tue, 14 Oct 2025 13:07:31 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 17/37] target/arm: Add syn_aa64_sysreg128trap
Date: Tue, 14 Oct 2025 13:06:58 -0700
Message-ID: <20251014200718.422022-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
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

System register access with MRRS/MSRR use a different
exception class.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bff61f052c..2c7dc53507 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -45,6 +45,7 @@ enum arm_exception_class {
     EC_AA32_SVC               = 0x11,
     EC_AA32_HVC               = 0x12,
     EC_AA32_SMC               = 0x13,
+    EC_SYSTEMREGISTER128TRAP  = 0x14,
     EC_AA64_SVC               = 0x15,
     EC_AA64_HVC               = 0x16,
     EC_AA64_SMC               = 0x17,
@@ -187,6 +188,15 @@ static inline uint32_t syn_aa64_sysregtrap(int op0, int op1, int op2,
         | (crm << 1) | isread;
 }
 
+static inline uint32_t syn_aa64_sysreg128trap(int op0, int op1, int op2,
+                                              int crn, int crm, int rt,
+                                              int isread)
+{
+    return (EC_SYSTEMREGISTER128TRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL
+        | (op0 << 20) | (op2 << 17) | (op1 << 14) | (crn << 10) | (rt << 5)
+        | (crm << 1) | isread;
+}
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
-- 
2.43.0


