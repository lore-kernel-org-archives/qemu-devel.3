Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F236C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JPl-0007g0-LK; Tue, 22 Apr 2025 15:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLV-000073-SU
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLT-0006ao-O9
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:53 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22c3407a87aso84187925ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350310; x=1745955110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3Y4je3GBLzid5tCgPTNk7pnHDm4dJMb3td8c19mugU=;
 b=ke/jja8jHIo8FHbDZPWrEQVapMgnLX+1vx1rgMplbkkc9oPWll+6aCbBp1tLf3QFXB
 rA7/rz92AL87L2Hvos9sDeej9HAthFyxFqJf2XezvuMcAcpzNk+V0RD2DXPeHjsqDjM+
 X2gOa6OktQ7wWPiFCazrMLMT2nSrlN4JInoMtiztRSe7NiHmJh62dfpAWw0A+WPiYhk2
 8Fc4MMaIzWfTJZLXl2YJcsPwi+mPG7zlxXnZ65eV9/mWR+icmyByKV+usZr7uC9bnBQT
 2XdW6kFk0Nm1PQ+tqPTaH1FiC7ekCMTXAd8kbCd13rpXOYAwtjaY5c+/ETJDakdsbU5R
 +Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350310; x=1745955110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3Y4je3GBLzid5tCgPTNk7pnHDm4dJMb3td8c19mugU=;
 b=eaMbReJAXLxz3oCWlmQt4ddZ5LO4bO98MZalmdCPVulTMDRfUW8QBW37GhVAxCtODh
 0EtzmKMdIEL87CVjWop/ECItVBBCg5rwQS8TxpTO/YVngopR/j50qEhz7ZDeb4ISP3LA
 DvHgSe6jn/McqhaVvtgnhxVvExxtPkgzMlKi5I0itJTbk5ReKQxB770Ve+EzarkTgHTd
 cRr/zAF5Ivgb3AMbN1M0X6lzMDPEciTvP0WGWX9rZFcQdkAXIkIPyYTzCFq5b78EiF01
 lrYjYWyRGQsUNJTAks1Z3NXJNfxnCVq/1Xtjppz0U8u4/iHiRjQnWaDlrG3wQY4UC4Sd
 Y8YA==
X-Gm-Message-State: AOJu0YxscZLscrlIqxqiQyi8UFVkrs1XdNQ3hQ617MZX3nOuliLHTnYB
 msBLBbrJGS3DufJIOIjxXANv6wJl5bwTJYjCY4SC9YPQIUHPXbaFkOTiTAb6o3RVe6sduFWh8ui
 1
X-Gm-Gg: ASbGnctrDbNMredoJabufpCSfIyoDKtYCWoTl5iNlG4i+yBhIpWVOfEoXJZg7omxMdS
 rI7UF/4V4CBxgZgJXomiafUdkjZ3nC3yaFbk6iGjZoRvT8h9T1Ofy/5hlqf03L9EqMAIgmQYpcf
 V97USO4lJpu3XJ6yNytNzOXQg6sjwE/ZMfYgCCkP//biDRXWGQBs/2lTm1uulgBoax7shGyG/Mn
 YkrsKkjCUYz3Zh/Z9JBw4QMM6r7QrSYM7OupOfdYAc+8csChE9nAXi6POJxRq9sNi10mF48yWRs
 IrwH5URELKt/GHsOJTQwhTQxzf9xfOUFZFQd1mSeqP3DM4ZP1EgUwhTCJOsA6e9ZUqeuZhH4lNt
 O32uXOy+SeA==
X-Google-Smtp-Source: AGHT+IE2ZhyzW8qkwsu70tTBrm7W2PTSbYkzFoWSaTSZlq5CkakDJvkT/VI3w6BbMqjfHg5+H+FIpw==
X-Received: by 2002:a17:903:2349:b0:21f:6bda:e492 with SMTP id
 d9443c01a7336-22c53607715mr256580485ad.35.1745350310078; 
 Tue, 22 Apr 2025 12:31:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 044/147] target/mips: Restrict semihosting tests to system mode
Date: Tue, 22 Apr 2025 12:26:33 -0700
Message-ID: <20250422192819.302784-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
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

We do not set CONFIG_SEMIHOSTING in
configs/targets/mips*-linux-user.mak.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index b207106dd7..47df563e12 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -32,8 +32,10 @@
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
-#include "semihosting/semihost.h"
 #include "fpu_helper.h"
+#ifndef CONFIG_USER_ONLY
+#include "semihosting/semihost.h"
+#endif
 
 const char regnames[32][3] = {
     "r0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
@@ -415,12 +417,11 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     restore_pamask(env);
     cs->exception_index = EXCP_NONE;
 
+#ifndef CONFIG_USER_ONLY
     if (semihosting_get_argc()) {
         /* UHI interface can be used to obtain argc and argv */
         env->active_tc.gpr[4] = -1;
     }
-
-#ifndef CONFIG_USER_ONLY
     if (kvm_enabled()) {
         kvm_mips_reset_vcpu(cpu);
     }
-- 
2.43.0


