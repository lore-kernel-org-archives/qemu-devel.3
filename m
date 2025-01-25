Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E2C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYD-0007co-D0; Sat, 25 Jan 2025 12:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXj-0006pJ-Jl
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:59 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXi-0000Qg-18
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:01:59 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso3056584f8f.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824516; x=1738429316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GbKJhiOZPCKm4Y+qVPyi/qaA7c9EbLbN3OgEPNHS5s=;
 b=e1Tc8tNoOTeCnd/u9/HFJDTsybTDnHn/yyGJbMHwFb+lNdKPUKWcAC3bCvfuoxldZ4
 aJiZK3JaLwFDBu8McLN/YsJAhFV/HM8OTZPa7h4ZsOvvxPUned4IF56KD3YMRwTIObk/
 R3O/cvPHPE8x1znH5BN/TY69luo2/rt7+wtot+ues91YaUKUitFnMguJ9mR7UdsNEl6H
 Uey+ehrV9O8nG1me9bZvBBKRza8uBFkB0xUiAVdWR4Dejg7Sd5PtFLR+3P64O4nbHNWY
 T86fpKADdcGUCIWI+7KbpJQSfNL3ETtkYrlxuU1z1dMKdqHGQqOAvFM2qmqh83pObdQ+
 8X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824516; x=1738429316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7GbKJhiOZPCKm4Y+qVPyi/qaA7c9EbLbN3OgEPNHS5s=;
 b=vEU+Nkp0vSKL8wfpBWT1R4pmelq5dxpZO2MTpih01hfA/5UYW+Son9GQbGRFA52vTd
 VufKXXmvi5FKEZ9pdknR+jY/Sjbxow/fEfYB0nUZNRAYCWxuJoBwZl9rWNIN4ZPz1gH5
 c78t7ZYpNS1bWse3PLPxJp3lsnr3HjAMVbx9pLXvVuFsH8wCAAu3n3gUfqqD5NQ+Ku+A
 fZ2ssbicnnz2Ot4DJMKftpFjkiWnI11MxYuw444Vz09NCZx34RNk1p7w62lmMD7ddL+r
 3gj82Mg/g0Si8QWzTJfolbjWhRQopQT8qqlAs2dW4nfEUdEUPxma+gKmOrFwppkhLID/
 bZ4w==
X-Gm-Message-State: AOJu0YwZSQzw7ddukdE1rG87iUn2bjXeRusDnrv0RrpLw2NY5YL/2RXN
 Sw2/Mhu6tRGco09iECs/QEB1OmRgzOfR2Ck3h+rH2kjiwOHN9HYTBaH2ByygV91EuUrvP2/u1Nt
 NlrM=
X-Gm-Gg: ASbGncuNQldbt1YhZ9Bd96kn40vTPl7uY5GAo8QUracxXvECFq/cBMzlNg0ZhafoZ2o
 Aj0EPxrxRSDftn3I/B5jQnq/RYon7/DUwdUkM7Rla19ALXl8YxP0gZq4RXNegK6/cDJ8hvkXwGI
 XBMf217ZfFB8FJ8qknyfwcPlJCgDukWSKETIHEF8CjZTkwZW4wRygnmCM2w1k+u36aVzGGEE07+
 lesbn+3pXbHs96Y/QaQ2UWGvkHIa16fGCm9xdC6zFqLfDDBlLNFWW0jBZGpqOPkOgVBduZvmxMM
 nsxK5+N95+cGnlbmCGKKakdLHq/6YMkjQq+xHZGIW8iJPH2eZM+Pj1g=
X-Google-Smtp-Source: AGHT+IFI1/dNfB2zz/1zhMIHM17h8eY3fXVfhA6e4qvV60L9QiB5SP9SZb5JpvoG5y/U4mB7x3rgAA==
X-Received: by 2002:a5d:6d0c:0:b0:385:e88a:7037 with SMTP id
 ffacd0b85a97d-38bf564966fmr33455673f8f.6.1737824516047; 
 Sat, 25 Jan 2025 09:01:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188d5dsm6196482f8f.55.2025.01.25.09.01.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:01:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/24] target/avr: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:07 +0100
Message-ID: <20250125170125.32855-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8a126ff3222..8712813f3e2 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -200,6 +200,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
+    .has_work = avr_cpu_has_work,
     .get_phys_page_debug = avr_cpu_get_phys_page_debug,
 };
 
@@ -232,7 +233,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = avr_cpu_class_by_name;
 
-    cc->has_work = avr_cpu_has_work;
     cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
-- 
2.47.1


