Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C170C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDW0-0005DI-3l; Thu, 06 Mar 2025 10:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVR-0004UH-Vo
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:30 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDV1-0006kN-Um
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:05 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bd45e4d91so5740715e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276262; x=1741881062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bf3FLmQWt6m/eDrfCAkJInffVWLTlLumKHQCoX3JudU=;
 b=bbcD+Q8K8r1jL5YMTCRzRV9RLh8BlIKkBFAp00y67Rr/MxUSkyaULYTEcf/rFL9U+R
 0x+yczHTHvLLVoT+lJkTfU+983z6SFHbP5mrtohTFPaANh9NU3784wWr8YNu26wJU58E
 eu1gJy+N8jvv7MB1XFUdDM6RBAOxhJcAmuvsKPnBe5X5zAGjjtSsOPSGo3+uuBzu3w0n
 6HKkWD2yHKrUS8VihWx1zsxKOtfRYnIMkNvfK20gXbk+ri8Q75vbshOsfX+IUlrtixw1
 Bk10Xgou3orru10Pa1syzX5QUqweCC2FN/uJ65Ep3lanWYnjnxmhuPiOtacNHAw4zrlQ
 hFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276262; x=1741881062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bf3FLmQWt6m/eDrfCAkJInffVWLTlLumKHQCoX3JudU=;
 b=Fbbo6OLap9v7vEqisbbRyNV5AoWd8h3H1P5eu9sqHiWjlsPlrae+4P5vP7otTeH7h3
 0bceV3q6dpV8+AZPCn+rrZL6teQmJKA8FqhxOOf7hW+yAtUPPnaQVbO64S8DKX05zoW2
 0wM5zMpzMGPvIxVsUzKEoBRokoL45+2TfcziFDs19D7ozstYonZa82y8SWX95EnUmu9z
 ykJ67Drw5BX9xdG3SqViZQx9axPIn498kOFUD1P3gN9RLuLhEGw/kZlrvU+l2iPksaVD
 m7Z4esZQ4pnHHGRsNWbHF+rJgqewQi3eLeqWD/Q6MWdpem74nt5FG6v+e2jUzqT2aLy9
 JHhg==
X-Gm-Message-State: AOJu0YxhSDTZpdSvnXWdX76Nvo1ACpTOqggrGo0usOxn+72hMzzjW8gP
 kYjOFbZSH/6fC8y4UzsJhGgOsFir/YD0zWiGSF39EjThIHaEWzkgmBVhqDTaYvKlxw/QxiZ19sV
 C7YA=
X-Gm-Gg: ASbGncsT1wkAOWub69NZ9m7krx8sZSNl8TSKtdHvcN8Nk+kmIETvA5K0Lj1Ei0BpTss
 rZ6V6tggqAukt2g7fxmsrlG+1aLFtH+/StBN1jeQBFOq8vRtW9F80tvmyiLkuv3YEqw2k9dEUOV
 KYCdzDoa9pyQ7YcGi1MvhY3WERrhVn/V99OZM/qzgfkfbVMJVa+cgkzmm0kHadFo1MWG6gIiG6u
 SgZkO+kGG8INy9lLDrI0FaKUMttqAshJT9fLufycL+toFZSEiHszzHKnuzSuPnRUYNHlOYc+eMa
 IOToUqbQKkIa0VEZ7+Ks3lsa0s9+q60yW8z/bCKi941O7rRXV2En+piXC9wfIEBWr84/dkAwI/7
 C0M//O4/uDNx1yJurXMU=
X-Google-Smtp-Source: AGHT+IERsjFAlz8667LvQTZUhasD3RUEObvtRqveDvOEut8I8189maJQgi2i6Ngzi0qgTeeDXn0elg==
X-Received: by 2002:a05:600c:4384:b0:439:8490:d1e5 with SMTP id
 5b1f17b1804b1-43bdb37b516mr31049205e9.4.1741276261968; 
 Thu, 06 Mar 2025 07:51:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e1d67sm2400812f8f.74.2025.03.06.07.51.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:51:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/54] disas: Remove target_words_bigendian() call in
 initialize_debug_target()
Date: Thu,  6 Mar 2025 16:47:27 +0100
Message-ID: <20250306154737.70886-46-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

All CPUClass implementating disas_set_info() must set the
disassemble_info::endian value.

Ensure that by setting %endian to BFD_ENDIAN_UNKNOWN before
calling the CPUClass::disas_set_info() handler, then asserting
%endian is not BFD_ENDIAN_UNKNOWN after the call.

This allows removing the target_words_bigendian() call in disas/.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250210212931.62401-11-philmd@linaro.org>
---
 disas/disas-common.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/disas/disas-common.c b/disas/disas-common.c
index de61f6d8a12..ae3f9e46ea1 100644
--- a/disas/disas-common.c
+++ b/disas/disas-common.c
@@ -7,7 +7,6 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
-#include "exec/tswap.h"
 #include "disas-internal.h"
 
 
@@ -61,15 +60,12 @@ void disas_initialize_debug_target(CPUDebug *s, CPUState *cpu)
 
     s->cpu = cpu;
     s->info.print_address_func = print_address;
-    if (target_words_bigendian()) {
-        s->info.endian = BFD_ENDIAN_BIG;
-    } else {
-        s->info.endian =  BFD_ENDIAN_LITTLE;
-    }
+    s->info.endian = BFD_ENDIAN_UNKNOWN;
 
     CPUClass *cc = CPU_GET_CLASS(cpu);
     if (cc->disas_set_info) {
         cc->disas_set_info(cpu, &s->info);
+        g_assert(s->info.endian != BFD_ENDIAN_UNKNOWN);
     }
 }
 
-- 
2.47.1


