Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00787C2BA1B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKr3-0000IT-PN; Sun, 09 Mar 2025 13:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqk-0007pb-H8
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqi-0004zO-SW
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bcc04d4fcso20302765e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542842; x=1742147642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EZvFiK30N39QXumXvDCwk1WrhpzfFLfGAKWY9PgROns=;
 b=BBvMYFHY38x8cejshwllHWmu+H9BcBTW1/xhYX6khlICPpFCMPjvbcdIykVg5RW1wi
 CbUa5Je70LmM5Z7l3AjwvbrbEvd9QCMu2bn8M1wQZ2pHWfwj8aNVDs75HQ+Hwi05SA89
 NPyKECXapiFyi/62IyS2Br7brPccbgCG3nPjoi2v6b4ypdNrcRdADiJ7JM2O8IkycDWq
 kh+O/kUacK4il/M1cXB9CcfOO0kwPkpOuAIY0j7wyAxlN7CRrKzR1HE4V1BdKmIYKC5L
 DKTiUeXBTE+oY5srczbQsp1EdjNnKUXFN0hg8gvCHO9FHI89YGNzs8x/cH0PhbAW7xkP
 c3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542842; x=1742147642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZvFiK30N39QXumXvDCwk1WrhpzfFLfGAKWY9PgROns=;
 b=uJZ/4VqwxATCmP5uy+aZxrwSodTRzSPwCNZoBtMTV+XYHBZdWmYtRgkME0eZf0/ruh
 8antLVFPfQsZ97KiuOS9OsTREUCFF1PIhn9fMwoxu5xQBm1afFDOFSLl/pkODtstNE3i
 WtJc5ve7vTQGdmCLPNjIkpnoyzU857tD7KSPxc0yTNc4nhr7QjDc10kTkG3Nzbr68iuf
 zJLCBXPLKUgyZsYzGohjYfSrF0X/F84RFXG//V8p9l8lZ2UXofjanBqD2xiTGTmgzQ94
 BFkrJ0vrvdkfdkJ7A642AWAc1HoZEnhItSx8HjzaIbHFEgV9QfWMwjetZyc+/wUSzHaI
 Mjfw==
X-Gm-Message-State: AOJu0YwRDuZIO+rz0NJLtl82umellN2QBDO52edm+NiItIFlf9uG2S3x
 tawanYlVKePUUqeOY442V4b2zT/LxjxTUueeJbW0SaOUa+sMnuRykXDakfOh70/+eTocykpXmE0
 fW3I=
X-Gm-Gg: ASbGncvt8ZBNYuKEbFWCtSqBNGW8RYBT7RZlsfDg3sy2ytds5pbLLm/HZMjr2i15aTR
 EvJdRUQa4TwqxR0w5pQkgsCo6/kO5dRPBTIsYcMMRd0w3ywMR5rzBbIMQmP66WcCOwshNR35HG8
 eitFfj4YU57x/4Ei6H81XNMAwVYjceH22Nld2gx7PfngKipYc+kD/Vr6QTA9t8IVeNKT9xsHkYQ
 pjiLgx+DXEDQBQerncDEm50SyWxKUbMgo4BKNfHwFR2RXsZaaN0+LeC1pbYNbzREROU5xdH68sz
 OHZQu0+diT5aRWFkZlHXLuZvYc77j6NrsIRNsPc9hm+uKeCCMhC6NpJ0Nlc0Fs6e5Jic4z0RSex
 2q4T3v/CooBl7dkreHec=
X-Google-Smtp-Source: AGHT+IHl1QBXikP2rhymcW1T/1oessap/+xX3/cRIYRt6i2kpQXj1JgHvvFrVHT8Rdn86kmeiiqMCg==
X-Received: by 2002:a05:600c:3ace:b0:43c:efed:732c with SMTP id
 5b1f17b1804b1-43cefed7884mr15549825e9.28.1741542842483; 
 Sun, 09 Mar 2025 10:54:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf515c580sm19938565e9.15.2025.03.09.10.54.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/38] target/m68k: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:53 +0100
Message-ID: <20250309175207.43828-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
Message-Id: <20250125170125.32855-12-philmd@linaro.org>
---
 target/m68k/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index df8b9c53fca..0065e1c1ca5 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -51,10 +51,12 @@ static void m68k_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool m68k_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -579,6 +581,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
+    .has_work = m68k_cpu_has_work,
     .get_phys_page_debug = m68k_cpu_get_phys_page_debug,
 };
 #endif /* !CONFIG_USER_ONLY */
@@ -612,7 +615,6 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = m68k_cpu_class_by_name;
-    cc->has_work = m68k_cpu_has_work;
     cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
-- 
2.47.1


