Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0138C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ksb-0000XF-PK; Wed, 23 Apr 2025 20:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015h-TO
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqI-0004kZ-0x
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7399838db7fso510884b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456008; x=1746060808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BPrUJL2Wwt5H6m+qbEougiZhbCqsapatk+AvGECCLZ0=;
 b=ks3eqvYUZMzCcUt3RbE4Q3zsn4ikueg8qpG71AE0O1is3ObmsxzzyP8MaBOZhq1iJV
 qUegXNSS4U+/6kjpxvbx0EVBbiRy87Rd4ygcChGKiMw+8SDpRhbdUBojDQp9p/tH56jt
 i4a/CjWr57gGvJNefke7XrNPZ1d3JXiyQthsBuF8Uf0r/iWfZb0SDaqBMDHmwBXENlgZ
 FLb9Fhjpcy1UOpNRV6M/zAQUxPyyUozaY6vtxDT/5fB3Kx9lzuIarx9uPti0XFLMyaA0
 jhSE+k6kd3V42cJwmndLmbW6GNBFIpOVQUFOpUj6k/fhGhKwbsip4P39bOhfP3olQyG9
 Shvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456008; x=1746060808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BPrUJL2Wwt5H6m+qbEougiZhbCqsapatk+AvGECCLZ0=;
 b=RCiDSDWrCCs77QZkOG6iZi1l5NNFvgUYfaqDYsqG28jDiZs6wWWduj34tsqHEpGOOM
 O4MqukATRQObh5bPFaNpwgEL9/KuB9z+f1SjfT2iUnOpXM0YZV9uFFBjVUrZ/Qwwwte5
 uofSopH7/Sh7bI13eCLSUFrWiJdfkkqeWg/zMN8VBrugnUyeKz9Ihbc4lniwlmhSbH21
 xIaEqZlc4l0PtMbYVJUbtDit6wDroTY6+dCmWiP5UJFXzc10/jyKBRgv2kRRGEoSF6di
 tlbbo2MHhzPTcUssIez6ti1iKvdpR/fhlQenGODOiHYaLJaT0CAl33M4HNj3uOmooert
 zdYg==
X-Gm-Message-State: AOJu0Yz3is8Rmra8txGiuJSJCsHOZmVYt6vjry+/ka6HatkCZbXhWvrO
 FtamSiMzS9KUhB7swKgXadQ1EGWOh1Dt2CdsewPO4o0BmkUyIfmwPnpgu8K0FhgajcDpyL9pi8t
 v
X-Gm-Gg: ASbGncv4NRLr43p17/D4KiskSCizCv4jzUceNjWwPSFOWNl47tHDXdOaSO2kEBRojqV
 afU3NfQ41UKNnL2v7yR12FiiEnRIyt0vd2HuO6rJAae/g9WAg8TeosGP/ZMBisl2/M1YDo5zE8T
 koUiehq0tA+9cNOnfHTLqjwlTEipVURny5CNFTq+ToIoQLx8P8q55DBb2I6gkM35KmMmy5jRQvM
 AAjXvt4P00O7t1eFVQ6E2JfxRbkuC6OEcmCd2sD/lLqpntm2iAFIoh2mofKJWgSRvu7/QWSWztC
 UAmyP/bTqSEAXgsY/VldnPQZJ9jwpTLdVVQE88M+Lec555NRUpOMpIBnpHH8JbE3nqZ2dxuvGbA
 =
X-Google-Smtp-Source: AGHT+IEg6iAh4fg9h91L94lkTjQ90ZEwNRuzu/7L0nmwWfAJH9bmVxm2zEUCo/03jhAw6Tmia9pigQ==
X-Received: by 2002:a05:6a00:23d5:b0:736:4d05:2e35 with SMTP id
 d2e1a72fcca58-73e267c393amr618511b3a.3.1745456008322; 
 Wed, 23 Apr 2025 17:53:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 071/148] target/rx: Fix copy/paste typo (riscv -> rx)
Date: Wed, 23 Apr 2025 17:48:16 -0700
Message-ID: <20250424004934.598783-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rename riscv_cpu_mmu_index() -> rx_cpu_mmu_index().

Fixes: ef5cc166da1 ("target/rx: Populate CPUClass.mmu_index")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401072052.25892-1-philmd@linaro.org>
---
 target/rx/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 0ba0d55ab5..a240b3b3ce 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -66,7 +66,7 @@ static bool rx_cpu_has_work(CPUState *cs)
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
+static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
 {
     return 0;
 }
@@ -227,7 +227,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = riscv_cpu_mmu_index;
+    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.43.0


