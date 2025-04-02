Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60369C3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05H2-0006Bh-Pu; Wed, 02 Apr 2025 17:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gj-0005SR-2V
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05Gh-0006GV-DS
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso164055f8f.0
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627901; x=1744232701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CWC4luGIs4rwgDiOpPSKAfYrqZ1/3M59pzf9+63JVic=;
 b=PI+W9E7ol8ekdY42Jq5MccTtbNqtXkIGSNeLNu/zD/wJt+3xn15YaCTtR9y2RFiR2/
 zE8bUZSigKSowOFds8DKJR7XCZOU4bVFMEm1lwGWxkWDMC4SkFzYodplV4JX8M2v04MZ
 2T0GqOYtxSe8+7j2iAUP9holSFQwBOtkH7j9ahVjyhcdt4YDcemrat1pPNOnmDHqDlGi
 ORrRfOitSb26JN+Gv4hb0w5zaFgVCe40JItoF0LqFIqC7yIGB2JT8g4VC8HmBwVugEt2
 /mhlPfhjpHkKht4zkG/Vc+o2CZ6z/lv2kpY9FcWWV3/WJ7JNl44R7dtffDDgSDWGgydk
 HP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627901; x=1744232701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWC4luGIs4rwgDiOpPSKAfYrqZ1/3M59pzf9+63JVic=;
 b=p4uA1S1dFy5ZVwcyb7VeF4rCbGvcI7Za2nyuGvnJrlpLFWdkPVgEEza9hpZ/o9+xOI
 quqlU6x5XOd7ESe6q/LdFyBwUGXg8WTZ+q6ip7c/x50JDTePePOqlxRSG0x/2d3z26Ba
 pSaM25VlVBXcC2RJ6vuUB78dzDkmXg6+dFhPY8abjAYS7Sp9qYYL8bUNfQ5EFDYO7/sH
 YGJR5QFW0skhsh5PZzayrrLU5RuJzdgwVRq49s559GE9r83jbO7+rqYtIKJiwHA2SSv5
 bwNl66i4htxZWyCLFovscs/FgQ7wZvNS1+E1QCoRq/MlX5RIZlUnDltjVIS3JQstxkjL
 ku8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuId5hmQ7UbPwgYNoCt0yvopVDB8Lq8eVry/WL0b6DuVdy27BFXz1Dcvbo19ZCJAYTRGRYM6O64Zhh@nongnu.org
X-Gm-Message-State: AOJu0YwPPynE4mU8JQkfcR2KPZTftKcavGjkBxWkFl4GstPs6OYLJFK0
 LucsoKrRcZUFs/TJzflKsXo0hRGusCIQieFfL2gHzF8YJ+zPv2BwnZV9zJJ/L4Y=
X-Gm-Gg: ASbGncuQvQPi+oLGFQYipe+s9atsX/H+Hr2Z2VsM2uoMv5o/ucqVvyiQ26158KQeudp
 MqBh7OsyVheWHvyuI8qCZKyzUWhhbcTQVGL/xZJDU+p04Pia0WaHsUHR6bADx75NPIi73TI3Y/L
 qk1hMDd9XQRMYh8WNSjRx4aC+9pm7BTkYv1Ndm4ZNWT5KxRG2SWfr/IR2EIfuTpPsef7yVBioy3
 awZXu0LmwHbryj5jI4BR4VoxcjMXiGN2XzemZ+y53GzR7W26u8m/uO4mJiUGwcbULrt9rshpwUI
 L2zhhpjQyIc56hH87skoefNlcOMdoBMiSfB/QEKYj55OKrvA9iUsk36Y72rf6Bg7u1cJ5vQTKn2
 Oc6z2xcwNHH8NbfUg5mQ=
X-Google-Smtp-Source: AGHT+IEobvOrYKlo/wUoUy6KZ1O2vAfyvDc7dLRyrx7Exk7RoxVLlXAG/ThQUPmweJiHXk1at+AWMA==
X-Received: by 2002:a5d:59af:0:b0:391:40bd:6222 with SMTP id
 ffacd0b85a97d-39c2f8d3582mr128572f8f.22.1743627900788; 
 Wed, 02 Apr 2025 14:05:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0a3sm18136284f8f.71.2025.04.02.14.04.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 19/43] target/rx: Fix copy/paste typo (riscv -> rx)
Date: Wed,  2 Apr 2025 23:03:04 +0200
Message-ID: <20250402210328.52897-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Rename riscv_cpu_mmu_index() -> rx_cpu_mmu_index().

Fixes: ef5cc166da1 ("target/rx: Populate CPUClass.mmu_index")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 65e26e7a6b6..723262f4b54 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -67,7 +67,7 @@ static bool rx_cpu_has_work(CPUState *cs)
         (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR);
 }
 
-static int riscv_cpu_mmu_index(CPUState *cs, bool ifunc)
+static int rx_cpu_mmu_index(CPUState *cs, bool ifunc)
 {
     return 0;
 }
@@ -228,7 +228,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
                                        &rcc->parent_phases);
 
     cc->class_by_name = rx_cpu_class_by_name;
-    cc->mmu_index = riscv_cpu_mmu_index;
+    cc->mmu_index = rx_cpu_mmu_index;
     cc->dump_state = rx_cpu_dump_state;
     cc->set_pc = rx_cpu_set_pc;
     cc->get_pc = rx_cpu_get_pc;
-- 
2.47.1


