Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8FDC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb67-0005fp-Fe; Mon, 29 Jan 2024 18:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5j-0005Rj-R4
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:05 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb5g-00051A-IQ
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:03 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d73066880eso27121485ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571059; x=1707175859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XwFQU82n2x7rtRbW4qoRnV77APVvN1DWq124XDZ74k=;
 b=KCAlCo+uJJJB1y9wJIAh+Q4PHltIEYY4YuHigpmmYujRKlWPl5USb9tc6nr0O0eg4U
 sKH81+DT1ZCxrP23Jdk6n/k3MctumCHCvbQSa6dsvavqjIEWc10ymKtndRMzSMqFtdRI
 IDdVam/0Rq7BCVS2N8mctE7g/Lvr8e69xHMcmJcVhz9XjXDiEkYx3S531TqN5LCO8/aB
 2It6wnw1BrRK3jeoBG7uuB1zuldZsTEFXLJqMqrp5uqhVIvdCX2erMVu2I7x3kQ0TQtx
 AdXT2EHl8sQF7/P7y/bJPdo7GbkxoXJQrAIUxRkyJNWYgLL7mhnwswnxne7C+3B49I5a
 WGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571059; x=1707175859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XwFQU82n2x7rtRbW4qoRnV77APVvN1DWq124XDZ74k=;
 b=ZC8NqDrcGDh9ODNArGvII25rDbvMfU/uaBEEhrAnp8pQ97NEcaeNW3v3QMFZWBnZKx
 S466q5UpsEkRhHH6RLZQx6yLVKa+nYjR5FAyN70IGznwJnZkNYZ3cfvDSCmvm+rROxqV
 WnXbvEaOaEriTMO877HqcX5QILOna5tBj5DiBtR1VrQ6Cd0doM1PDTVxoNSNpQYl4NE4
 ZbKoc6IOpb0ZPn37xUaio4E525vJdEp0FXBPOmboZ0iuAcHO/QzoUIGlj9O1MBNKKQy4
 NvAd6mYneJnqXgorPx+iVdvyP6zmUCVqjS2jlT95yQuyLhsQ6W55l08JqJDLI1fRjTYu
 n4Hg==
X-Gm-Message-State: AOJu0Ywcz5sAgqY4C4UESpTi5AOFW/CA28uYSURsuazf9ofPnCaTCccA
 E6ttNSgT+AFvzxYzdq/s2CdZiZKMY7svfXfTdAkHkrzzSWGI9KX9BwnSqgJMCd/5tGRMsWFt0m7
 4UKQ=
X-Google-Smtp-Source: AGHT+IHJPRYA25RmPmIKf+ekd/WNqSL73noKmUyADa5tVA/sHvtEyiCB/VbEf8VWZizn00lK3Eg45Q==
X-Received: by 2002:a17:903:124a:b0:1d4:e0e:fa1b with SMTP id
 u10-20020a170903124a00b001d40e0efa1bmr7793715plh.57.1706571059449; 
 Mon, 29 Jan 2024 15:30:59 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:30:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 05/33] target/arm: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:15 +1000
Message-Id: <20240129233043.34558-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/arm/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 6a96b245f2..1f9ea622bd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -133,6 +133,11 @@ static bool arm_cpu_has_work(CPUState *cs)
          | CPU_INTERRUPT_EXITTB);
 }
 
+static int arm_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return arm_env_mmu_index(cpu_env(cs));
+}
+
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -2497,6 +2502,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = arm_cpu_class_by_name;
     cc->has_work = arm_cpu_has_work;
+    cc->mmu_index = arm_cpu_mmu_index;
     cc->dump_state = arm_cpu_dump_state;
     cc->set_pc = arm_cpu_set_pc;
     cc->get_pc = arm_cpu_get_pc;
-- 
2.34.1


