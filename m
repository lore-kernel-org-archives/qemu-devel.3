Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CE2C3DA61
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 01:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUc6n-0006D3-AD; Thu, 18 Jul 2024 21:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc6D-0003xA-NM
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:53 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUc6A-0000sO-5h
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 21:07:52 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so944884a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721351267; x=1721956067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Aw83kLLuGjCQHx2MdR2LGZJ7cF9lloOkwjusYN+Kq0=;
 b=Xnq1hW9U8AKohHX1kvqaD9LobrReHnOJ2YqtRWPqzKSs5wf8RcSywsG83TOfNa2YvO
 7OY2p2Ma9au4xVzohyukefYYfrvm5suQ1aAET8T/ZB2bnXjaXWoeP1PxLxIt90whmXrG
 l11PjIZPsWsVK40JaMY8m0UxddI/RulehRKdokvQFFglprgiDP4HXSR+mbxgGcnikkGJ
 rf3L1hDd8cgM7d4c2b5yWCscCJdCfAzOTm9CisDT6KgqK0tc5at76y35efAHsqtR9lJq
 L1OJfxyujNh5rbTZFGLa2jYv2cIPqc7cDkGRwrhUq5hBxcxT9olSIPnfCxG/fkm0oPED
 UVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721351267; x=1721956067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Aw83kLLuGjCQHx2MdR2LGZJ7cF9lloOkwjusYN+Kq0=;
 b=sygcxegZnd6dhQt/QTGMX09YYUine9N1m30OCtbuzlj4Gr7F0Z44tri+bBV/HqKa7H
 MRNCv2tHPvgYsSOpgngBcFbG0+UCSXy6YotcuYWV+EQE4g4YfYVg3sYdmSZ3WZKcxTmH
 EwOWr4gjP859ly9amSq6FOzCvzJF8JZDWRo86PsyoXkP6CupqVTMKZLezyD1fF7OHDIz
 CGkcVhWXU5t4w3pZoVQtybOXN9mOsG7YV0mzW6Jrbfv+xGNlQoMpkma8ciK7Or3rH2BP
 +C4WG7cXk3dfQKkJgcqcAJdnAWeNchG1JI4laB3qS+QRALRjG3ZEW9JoEg9Y5kLMhNDB
 1p6g==
X-Gm-Message-State: AOJu0YzgoTjRI5ylVgugWIgb0Eeq0XwbxbfEyOClCruRs8hb+jiLXgsP
 GhjAxmYbVyBErn4uDRpoTnfthgYvlvcyMkP54fJ3Vkx9LD+4yqIOCUszSYRFvHeKUFkaKY3JpgI
 MlD+QNA==
X-Google-Smtp-Source: AGHT+IFSyPl69oz/xs+PHCm6FusTx0aEAUtFuiEuArzuXkqzmMGVp1fpiQTiM4eVikaIxUjJJayEqQ==
X-Received: by 2002:a05:6a21:99a0:b0:1c4:17e1:14df with SMTP id
 adf61e73a8af0-1c417e116f0mr1350522637.48.1721351266616; 
 Thu, 18 Jul 2024 18:07:46 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd64d07ad9sm2067415ad.177.2024.07.18.18.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 18:07:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 09/12] target/s390x: Use user_or_likely in do_access_memset
Date: Fri, 19 Jul 2024 11:07:04 +1000
Message-ID: <20240719010707.1319675-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719010707.1319675-1-richard.henderson@linaro.org>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: 37
X-Spam_score: 3.7
X-Spam_bar: +++
X-Spam_report: (3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Eliminate the ifdef by using a predicate that is
always true with CONFIG_USER_ONLY.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/mem_helper.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 6cdbc34178..5311a15a09 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -225,10 +225,7 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
                              uint8_t byte, uint16_t size, int mmu_idx,
                              uintptr_t ra)
 {
-#ifdef CONFIG_USER_ONLY
-    memset(haddr, byte, size);
-#else
-    if (likely(haddr)) {
+    if (user_or_likely(haddr)) {
         memset(haddr, byte, size);
     } else {
         MemOpIdx oi = make_memop_idx(MO_UB, mmu_idx);
@@ -236,7 +233,6 @@ static void do_access_memset(CPUS390XState *env, vaddr vaddr, char *haddr,
             cpu_stb_mmu(env, vaddr + i, byte, oi, ra);
         }
     }
-#endif
 }
 
 static void access_memset(CPUS390XState *env, S390Access *desta,
-- 
2.43.0


