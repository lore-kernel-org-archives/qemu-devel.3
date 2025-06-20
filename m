Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BDBC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4X-0000tO-BK; Fri, 20 Jun 2025 18:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfc0-00081d-Nc
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfby-0006eQ-Qc
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so19974525e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440784; x=1751045584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hN1JtRTCerNnjO9no3SYtbEkkfImhiND1eA7k0roPkM=;
 b=Egd+suXdfNAUAr1YhlKSr6q4JL85663lZ4gxrL4UsXeMSj4Gn86rBla5UM/VtdMx1u
 Lf4wAP1Ars2aNpIrhlH7pAhocBHg/fODi1ePXBlRN8VOCqBsviWMEoKxrCm21lRVRF5W
 W6eewnpHr7FU37nJXWZng08++acL1QZam7ptbbmzW76p4L1Q6uP45bU5Uf36ZL0x2lMS
 t0oEgMneGaZ1d7L7EDOPT87OYia9miWYMZFSQmremn64QWEBuMDp/c+PGUYbP88TdFw7
 OWmrdRq078rQSHGh2GXBaDs4+gBeje4AsZK8gnBdUTX7fMCYsVtsgnkGFtwWcxZ4/f2Y
 uGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440784; x=1751045584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hN1JtRTCerNnjO9no3SYtbEkkfImhiND1eA7k0roPkM=;
 b=AERCC/1fVxQEYaPQInbm8OUeFXyVMXf2wP2yKOpaDA7LeKG/i9cilUXgYUP3jp/Lmf
 IsXC4dkHEBN9Pc63YQSMPd0v7vg00YeWLhZDbwCneey3sUAd9JgZiRsY7+l4O4uF65FB
 glPdlsbB1AomX6eaYlIIjno5fKHT5vgIxnynXNZdhpJDjMfHks9cmZOERBqT0oqsoI0l
 iJchAQ6uDwouX2fUgQf6gcKNx3OQvQ2MCiGbm0Cv4DraLq7qXaVP7HhaAu7ztFoG9g4G
 zpRlpDNR2ov2aVQ3ul4Wlw4dmvEuMIE56/Vqe2wLFYGwd73kaJefOeGLCpAztz4cpMll
 Enig==
X-Gm-Message-State: AOJu0YzkBAxFdqKIy0aqmFmRJzNlt5X0U/Rp9bZ60urTfID6uaiJOUyv
 /lOE+wukBJrdi7+QdBHNEiFta+M6wtd4ahFl6XGkWAimwlrHeiBOY1CgquW+O4SMBGCRi9NNTCr
 vettp7meJgQ==
X-Gm-Gg: ASbGncuwK/LQVKDZBM70ANsYkBAFEJ033LGmZdLVNh5JBnXk5yjFXTCoK60B7O33StA
 TbIIdpmsyWzxFVicgnrDhwif1rsh82D+jI+PTqMHTp68Twk7reVaM9yiO1SG97qsfzx2sUzj6HX
 bJ9zX9iPI1bk/ljRuuR3eqGTSNL8Wvvys0fTvQufkkNr3s9WUZ3+Esid2RyuMGtXi/iAlBPM1he
 2AgThteJtEBVgb9+IZYlC/OcefqPD6pQjkcw4reN4jiRpoBg1XranLp6xB1gy/KhzLCC0sfZLes
 evJJ9Tvwor+ZNfEjN7lMw1TLKBZSMKWjA3sWm2WtBOpvCRxegyaWztXQP3TDCkac698CTCH9G6u
 3CdW8ZMycmVk7H3SBDQT8vXGuNih1YEeb1pmrTmfkmMWNJXW/E1J1w/I9
X-Google-Smtp-Source: AGHT+IE3atK2pRVb35gZUr7SsRFIJ25e2SxVnzGga6woXTZiKjW++Wo/G70UtF8boQXlSlWUP/kM0g==
X-Received: by 2002:a05:600c:458b:b0:43c:ea36:9840 with SMTP id
 5b1f17b1804b1-453659ef74bmr36392285e9.22.1750440784183; 
 Fri, 20 Jun 2025 10:33:04 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ef6edbesm63351955e9.20.2025.06.20.10.33.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:33:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 36/42] target/arm: Have ERET switch to hw accel for
 EL0/EL1
Date: Fri, 20 Jun 2025 19:27:44 +0200
Message-ID: <20250620172751.94231-37-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

When hardware accelerator available, use it to
directly run EL0 and EL1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/helper-a64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 4f618ae390e..5962cff4e7a 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -29,6 +29,7 @@
 #include "internals.h"
 #include "qemu/crc32c.h"
 #include "exec/cpu-common.h"
+#include "system/hw_accel.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "accel/tcg/probe.h"
@@ -761,6 +762,14 @@ void HELPER(exception_return)(CPUARMState *env, uint64_t new_pc)
     arm_call_el_change_hook(cpu);
     bql_unlock();
 
+    if (new_el < 2 && hwaccel_enabled()) {
+        CPUState *cs = env_cpu(env);
+
+        cs->exception_index = EXCP_HWACCEL;
+        cs->exit_request = 1;
+        cpu_loop_exit(cs);
+        /* never returns */
+    }
     return;
 
 illegal_return:
-- 
2.49.0


