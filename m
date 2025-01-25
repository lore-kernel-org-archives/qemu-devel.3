Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B215C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYZ-0000SU-JF; Sat, 25 Jan 2025 12:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYS-0008Rk-Sj
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjYQ-0000Y6-P3
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:44 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso34956635e9.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824560; x=1738429360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZVfXoDh+6S/jYxx141Eb2tmPZau06sCtOP0dQkqathI=;
 b=v96M/93Eomx9cfgh21DsjnTTuiTReirZMmfzeFEIBjuyApic/MLSBoQd9QLsXFRmP0
 4Tm7mOfRCbS08zKNv9ew8NxyhW0TW0UuNxXmhzISyGJHXC6eHpNREYwd2u614Nf8bRZ4
 TB9g1RMZNJAND3WPb6eE1xxd/xdzgoxkJpNBdOWlb1ag5sP/LlsKwpxHobHZ8c+t4X2m
 cgIj6RCyVMxWSuWgERSRopblLb4AQ3Ok5KzhGn0EhvgJ+tAVd9L/np7qTDPRvhqjxF7r
 gRdP95m8FOMgcwtyJGA/PJNNJEfzPk1qBLEV57qRPcNY98677rsW12krEtJOJpejAiuT
 Ns+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824560; x=1738429360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZVfXoDh+6S/jYxx141Eb2tmPZau06sCtOP0dQkqathI=;
 b=uxb3B3qwW1QVL4kjQGexG86jZo4DBshmpqdF/cW0IgOUNYGEpXyzckJWehtEJ7AABJ
 3N13r7s2r2eyfqCJVcp/BdQcOU3y9a6gSt+iVCxJwOx9vexYzGL8hOOSSe8u92sdCrie
 iAR13p/zEBxuiCqYC1nmrUcnbE3N93X0dkqHrY04gdT456aXin81u3FYVBvRU6F9FAhF
 jqHJxtMdDzpAWiXQ6wSUZ/j6Gs8jmAY8orzqLGX8SMOlTzulAKP3tk/wf2B4gEpG+9w/
 oxa8OyudKPMobfXt6ttYOz/ps8FnOBB0lzbZfAMRpduTvORwljk315s8+aU6Z8V1CFrh
 AoBQ==
X-Gm-Message-State: AOJu0Yz8a1rL7goeaJRrvbE6MGjoB1E4oaykt3VXT87BJ1hdZ1kIDmIF
 +nyXEnPtFV+D88HswQB9BuEbV/71IJwtsDrbhApq4f05zY0SCow99dOgwuP0zrD4J0WlcfJKght
 kk78=
X-Gm-Gg: ASbGnct1GvBcAUOqn4H7jQwHLPugj7AIiEg1hGmpVrn0gqYIP08ET+UrdHKUSR51p5I
 EWdq27Dj2mIBsDBrDHBbLo9vO+SgHYp7VVNLcIDICTFukLJ3UvxMnHwAyAqbjQWhNaS3cGt8Ui/
 vQ/w5yEtTNAL8+szLo8uNBjLDS5DX5lPPC4IeScyo0ujbr3J/pPacESXJ/exxHfrQBN7kddJ44P
 UVV00fxAwEHLRufBILPnlm4BF5KJFoePnbEE8XmrfWSioz0Cs0X9JFMjp5PJeddjUANbRbxO8IW
 +NxBPJdOaGBbEr+rMrJl91BMORVgc1fG08aDSz1XPM/mgaRMx4Jdz0s=
X-Google-Smtp-Source: AGHT+IEl6E4DF+gzk+WjAQZCYxxGc9gj0CROOdJ/Xi0h+oxmZQI1XCyPxfJqp1kkM2GyiDSUkKtG+g==
X-Received: by 2002:a5d:6d86:0:b0:38b:d7d2:12f6 with SMTP id
 ffacd0b85a97d-38bf5655264mr31626626f8f.2.1737824560275; 
 Sat, 25 Jan 2025 09:02:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1764c8sm5907359f8f.3.2025.01.25.09.02.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 15/24] target/ppc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:16 +0100
Message-ID: <20250125170125.32855-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
 target/ppc/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c05c2dc42dc..081fb5bd343 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7177,10 +7177,12 @@ static void ppc_restore_state_to_opc(CPUState *cs,
 }
 #endif /* CONFIG_TCG */
 
+#ifndef CONFIG_USER_ONLY
 static bool ppc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int ppc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -7418,6 +7420,7 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps ppc_sysemu_ops = {
+    .has_work = ppc_cpu_has_work,
     .get_phys_page_debug = ppc_cpu_get_phys_page_debug,
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
@@ -7469,7 +7472,6 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
-    cc->has_work = ppc_cpu_has_work;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
     cc->set_pc = ppc_cpu_set_pc;
-- 
2.47.1


