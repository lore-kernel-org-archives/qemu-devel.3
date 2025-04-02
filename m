Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1BEC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Gl-0005YJ-8f; Wed, 02 Apr 2025 17:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GX-0005I9-Un
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GW-0006Ey-9g
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso1194245e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627891; x=1744232691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pbB4CFJDmD22y07GArVgbVV6vdrV8gqdTxdfpBMR95c=;
 b=WHrOp56ub8SqyP/Hv3rCR00t/rg/VGVqQImq5K6kMYc5xZr7Eszeppa0Taupr+gWMs
 RyIegwjXqGqT9JTXGFfeNLFs1eHcnCLYWejOac5dI3PrTqzxNy73o5z/9YnO342lG5b/
 GxAE++fsePEbtj4owxYVJY+A0caD9ukwHLd9a5ANbgDWBvgxtLTSkTdSMGP3d6zreK2r
 WmGXQxx+yVXF4SwWO7ol2isMXxEEejAB3NWD+flF4Fe+ogujCEMhHPhIB4yvMSV8E3Sz
 vWefzh8EaesoqHd+u0xOL2M60AWY5RZUjjgWS/rufTuH41bsNFXcKeLY997HS744ipQl
 PzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627891; x=1744232691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbB4CFJDmD22y07GArVgbVV6vdrV8gqdTxdfpBMR95c=;
 b=slwzDK0c9lHyVTWre9LD5W995EHG13Awf0gzX0zCCVh5GmFOlIE3dPVYStDfM7eThS
 RAgVYBYJN011swp6cgnSEClWNePKr2lS2xJD29RBiUZ5ERLuNjvVSxB1ePQ6CZZkjSqa
 TalS/cdcOw1Ye39qBEHNazNCBeYYcGwGB/4/DMsoJkVrHIYw46+tRZxI7xUELJoxpSlr
 c2YSXaJoJjpib9alxYc9HsmUal5dsQb70dsAS28KLYid85yTnV7E9lC1OwRXRJFmAbfc
 0kZl+ls8WjIXsWwHr+KUDBWSQwJJGySafe7IXMMF+FJYgO88UDVeauyssQBO0gblVFxa
 Tt1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOO52whbKYRIj5VqqjXiUyX2VEQMmqkQROKS+OVtsAL8HeUM0X/28VaUrpe4NKNbgsGqi2QmAf3zfz@nongnu.org
X-Gm-Message-State: AOJu0YzsPow6vBXn+usJ4YP+zQ/8/WKSi2mn8P16RSk+7rM7YUlu/ehB
 I/2ShwE+FLTxhdaCcjPZGeuh59VCZo/nKQxL8kLgTw6rAQLE2IHxNO0X7uIvOuRT8bOUdJNjHWR
 Z
X-Gm-Gg: ASbGncsNKqct7wDKXL+RXqUNJG6Xf1RAJyf1T6Y5ZG9FC1SBXj5kRKBbRd1+AjT2Akj
 3KADCi5ZcA7thYknIfvBZSHV8HU6viw19q27hRLPR+RMqqvcCrcJVaRKFM5WF7uDyuXefwBaFjz
 ZooAIDl1wNJEn7Rzxie2yzuEz4b4ZUqsEQkwD6+5dh4dl9oDKQ04psbv+e9zPHN4mzz5KXyQyRb
 2nNck98coCWE5Z78XvWAG5dbPnkQuaHVg/wv1RbR2BmIvU5p10NA7saFRFGo7egrKf/7I1ahk6B
 axlAz48Z+zhYhktmuJjzsWujrzd5+gzEsJQmkzUIkChtuTxpuQurZPHeKnPFmfqORfAemgPUIrJ
 9G+TMdPqtzspZIOc9L6Q=
X-Google-Smtp-Source: AGHT+IGvsdDDWl7mqlQfrpAb4mz9J5bSwx26AS6Q4PAEkedqJdNxykVEUt0/MiyhVXLfaiTPNWNISw==
X-Received: by 2002:a05:600c:4f45:b0:43d:4e9:27ff with SMTP id
 5b1f17b1804b1-43ec1341539mr1986955e9.7.1743627890787; 
 Wed, 02 Apr 2025 14:04:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d2bc7fsm31598945e9.0.2025.04.02.14.04.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 17/43] target/ppc: Restrict SoftMMU mmu_index() to TCG
Date: Wed,  2 Apr 2025 23:03:02 +0200
Message-ID: <20250402210328.52897-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/cpu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 3686bbc9380..30238e9a223 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7481,6 +7481,7 @@ static const TCGCPUOps ppc_tcg_ops = {
   .initialize = ppc_translate_init,
   .translate_code = ppc_translate_code,
   .restore_state_to_opc = ppc_restore_state_to_opc,
+  .mmu_index = ppc_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
   .record_sigsegv = ppc_cpu_record_sigsegv,
@@ -7517,7 +7518,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
     cc->get_pc = ppc_cpu_get_pc;
-- 
2.47.1


