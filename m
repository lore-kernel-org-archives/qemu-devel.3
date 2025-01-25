Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B25C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbihQ-0005NS-0c; Sat, 25 Jan 2025 11:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigT-0004nY-2e
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbigR-0000lh-Iv
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:06:56 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-436249df846so20390595e9.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737821213; x=1738426013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxDvorJyhEvTzUUQpDwPeiHnLMk9jCN8DN75q+YWX5k=;
 b=o6l7Ge5kfvblG8oywqGfAlCg1eMUnlHju2cg6j/2rj9a3FunwW4m1LfBSldI7w6giJ
 Rv4pFNTdlcjpg9yU6krFe8NqB+ZGxG1u1GHRwWPkPLFsxd4pvMMbGoM++OQMiGAZL2HX
 udgH/10uDZhogvr6JGIhzmSIGrNEf1qUy0LS4XdI5/6GegZi9MRx9XyrH0j+pQmbaYlY
 uOplNdSpONsM9gpcFduRbLPKV8HwfR2PKB7AqGAqukQwB4J0rc/y6Wg/DFR/hB7c76Al
 nXhvq+q0sPiN+8JkI/eBc0yILvidrsPAeoy7fUMxvNPgQrPCOOMstPfP4wFkvDkwzu+8
 TF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737821213; x=1738426013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MxDvorJyhEvTzUUQpDwPeiHnLMk9jCN8DN75q+YWX5k=;
 b=Rc/ayEyb3Y1KYUA6hgKueC9tBpUPBw93ZwnJ4BEP/v4082wMMMYeGgnn3l9oHOuoYx
 AdV2NV395wK90kyFX5jbEkCBJ+ac0ZgsJfMnNnhQUwXYKzdW/50bDmRvEebdmeGhIDQy
 sF37HbQ7Y+DOg/3PWU+aZp/0j1eOR3dEQpOon6VRNdGbE/JKwP/7fwBf4jDIRjWn1t60
 0p5KARHlMn+fUFRRrP+mk9gnq0qdpf6aHa8dOulXe7WUHVTTNZLYb0UE+XST04wutg4h
 XE+wGztqVR6qU4i0lYHxK8/WNotIxTMpY86qx4RQACbLb3Wuyxc4q4X8MNb58EZU3jyb
 t16w==
X-Gm-Message-State: AOJu0YxrRrC2Pt9npIg/Q3z9XxomTSy8AW5/Si8MqZeh1vPspmnqtXGA
 BCRjjmXMY/P6qiJ0FDXn2EEkIam+mNIrpEMs1KSk4gCiSPn0N+XF0pWkVGBpm6vMGAN7kSN3bpj
 Y/Ek=
X-Gm-Gg: ASbGncuft4a4QbCE+ml2s8fxk0wpv5v3JazwFtiFCoA+Esu7CntSVDkvpwC8bXOdWaD
 f+0D2Po4XvqsNePeMs6NJhWAFrUx9YK0DZxoTPpkqz9faAf5cMPJzXhg3q5kh9EgnI5jG11/DKM
 GvLCNbJdspmUxwEXU4HbQLBWUTStzVLYctjur4JJCkfs/2/0IOGdTy1b9/3CsUbwgXxtsCtyAxH
 A/KVMzWffhh7m84Oag/kei8BfUk9rQxZe18STzvF4fmhHftPKk4ePqsZHJaZwfDB9FR/OjWVG+7
 Z7+EAG69NdbtxpsGlruYRW33JA0/Q0idC+GQaa2faibvyTNNWsIB0+gQRrjL
X-Google-Smtp-Source: AGHT+IHILPplRaVUzHiCBheosdCq06cl7QoxsYc0bMu6B3+dnXkZGsjFj5elh0l8v6F3rhZ5LWpI4w==
X-Received: by 2002:a05:600c:4ed4:b0:434:feb1:adae with SMTP id
 5b1f17b1804b1-438913c8604mr317792555e9.3.1737821213570; 
 Sat, 25 Jan 2025 08:06:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd485007sm66492205e9.12.2025.01.25.08.06.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 08:06:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/24] target/microblaze: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sat, 25 Jan 2025 17:05:40 +0100
Message-ID: <20250125160552.20546-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250125160552.20546-1-philmd@linaro.org>
References: <20250125160552.20546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
 target/microblaze/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index f114789abd8..7a90cb3016b 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -115,10 +115,12 @@ static void mb_restore_state_to_opc(CPUState *cs,
     cpu->env.iflags = data[1];
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool mb_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -415,6 +417,7 @@ static ObjectClass *mb_cpu_class_by_name(const char *cpu_model)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps mb_sysemu_ops = {
+    .has_work = mb_cpu_has_work,
     .get_phys_page_attrs_debug = mb_cpu_get_phys_page_attrs_debug,
 };
 #endif
@@ -450,7 +453,6 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
-    cc->has_work = mb_cpu_has_work;
     cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
-- 
2.47.1


