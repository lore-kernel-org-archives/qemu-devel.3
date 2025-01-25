Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F135C0218F
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjYD-0007dd-Dw; Sat, 25 Jan 2025 12:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXt-0007JP-HD
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:14 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbjXs-0000T1-1i
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:02:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43618283d48so21877965e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824526; x=1738429326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmGm+j3d/J7g6/EQrq3KxGWM+Wnw1Wpe1ViwwNVT0iA=;
 b=v/Zyj3jTbCsDKDzOfkzaoqUgRVOKkSLE6rmXrfJJBQYwZ9LfO2ZiLb0vRZoynvt7xZ
 ZtPiEkDi7g7zfRN6wRLAb8tkm+JP4cQY+X4BuVl26/F8UYJe5/O6d01VCPLEYAWmtzv2
 JjiT9AE+WTSwI4hAY5OzoLac7vIvV5QIDbkpeBYQkjRpmMASOpBhyAC6kXuCjkqBsePn
 fXzTWRL3DdvR+FizQsIlWguU4lnl48PMiFdmO9sap2Jd09TYlQQkfpDf4co0PKMj/mmA
 YvUOBSzWrpDHStNHsTQLRyCtUs+1ptOzv0vTGG9GZ4urz9ZIFn7kwe0zrM6tvT0Wc8g0
 uMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824526; x=1738429326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QmGm+j3d/J7g6/EQrq3KxGWM+Wnw1Wpe1ViwwNVT0iA=;
 b=tqbCJASGiEkkm6D6dFjSXIkxRRBZ9nWC3P1cluA9gL8UiQhhbRStf2jkZjM/JEFtz2
 Z51GDvBUZLeDsvZ7E2nXBQpJCc44TY6cFp/nHUl2A1BnY56Ls42eOHb4jfSWfqkHym44
 hpzk1YI6xUWKLJU+py1kr0T+q+lFi4ahZ3pmZEC7peTrgymLvsV/MeYa6co90UauRM/o
 a4Iud+Y6A/yj7I3RRhvadjy6oURFsVL2iPVzAN3c2sJ86uVmymW7U6C+HZDqrRMtKldo
 e21VThACojbrSAIeBLQzMftuEjYxCcyxezI1zQVJeeiC7XQ7rGKIWhsrvVFkQx4scC/N
 7MfA==
X-Gm-Message-State: AOJu0Yy+ET/fOHktQbk+gr3bWKNI3SW7x37Pf+RuWGRTyBCOdw0pbSW/
 jLF2eNLtfD29LRK45/aTW5pE5yQAf7DOVP+7ZMS21CoB+ipowas5+/jsRL/5AhX9952k3rvHxoD
 29Ao=
X-Gm-Gg: ASbGnctekY4S7tkrcUHD75QWthg0+2EY7wZ7HNAiGvSq4DOnCJq4EtquOqjs5sma6Mr
 YY9soQWagyJ0WB70p35etu62LsStFI3EEtOuiTWcwpzxe2tuwuI7uLz5rpduex+CNwB6VbE9I+y
 DP7EcgNRMmCF7QMdBhc6pJ8vG2jA5UhwEc0+5MQvSyHZfwSt4/Cj+UZfDlFrsejGAqi/6hSNABR
 f//Wq6VIf/f8u+RuF0NfvFJ/dq9jNLpE9tvJWRjfOuUKq1STY0bK9KPPvWZalxXEVi9K/yjEF6x
 pv6EKbemz2j539+x6EcLTfL3o4b/Qy6rfevz4y94uwJWrZeOu3dxPo4=
X-Google-Smtp-Source: AGHT+IHBxqlKPDDteW7e3O5pf1RUK1zajnEWSfOy34V2nr0deHId3Zs3363xPjCKhXD0uoz14Pq3OQ==
X-Received: by 2002:adf:f584:0:b0:38b:f3f4:57af with SMTP id
 ffacd0b85a97d-38bf57b4090mr31055140f8f.35.1737824526020; 
 Sat, 25 Jan 2025 09:02:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17d6e2sm5962579f8f.23.2025.01.25.09.02.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 09:02:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 08/24] target/hppa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 18:01:09 +0100
Message-ID: <20250125170125.32855-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125170125.32855-1-philmd@linaro.org>
References: <20250125170125.32855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 target/hppa/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index b0bc9d35e4c..d5a58a03cbb 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -125,10 +125,12 @@ static void hppa_restore_state_to_opc(CPUState *cs,
     env->psw_n = 0;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool hppa_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int hppa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -231,6 +233,7 @@ static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps hppa_sysemu_ops = {
+    .has_work = hppa_cpu_has_work,
     .get_phys_page_debug = hppa_cpu_get_phys_page_debug,
 };
 #endif
@@ -267,7 +270,6 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
-    cc->has_work = hppa_cpu_has_work;
     cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
-- 
2.47.1


