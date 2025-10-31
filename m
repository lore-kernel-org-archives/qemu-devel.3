Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1695ACCFA03
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxH-00051h-22; Fri, 31 Oct 2025 14:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxD-0004xb-L0
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwc-0006IF-Dw
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-429be5d31c9so924110f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935624; x=1762540424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aJP0Xy5bRdKAuM7fuA4ZOsjvPlOrGecSG1KNmEjQLLs=;
 b=FjtYGcxN/du47dAulf13dVHRmXdyrBm+x1seWZGhmmKAEW4R/O3Tg+66pTYW5M0L0r
 ajnLEIXM1xF8329kfa3aefw6/PMJuJ+hTuH5wOUg7G9AkzSWl/c6RPZJcAe4fG6kmA9S
 Foc288IZ6MXYDWzfvPQ2BlMB7EfsvPpBt2/VQbRF7nWyfoZQHk8vKdpqM4GW0lNkIszO
 ZlVA7HV/UH31eQsuKEx3kACzo47QjkXkYT8T6k69zY6tddggBOwC91lBwNg6v/dkcEvX
 1ECW8Ri4QBt+FRCCBhNmqQ2xutbbrRffJ2EF7GlLzsw+0pDCa0IDK+a25huionOH0VF5
 WpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935624; x=1762540424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJP0Xy5bRdKAuM7fuA4ZOsjvPlOrGecSG1KNmEjQLLs=;
 b=dgXSbZ+yTizIzvqLbl+CZ8Idy4CkiKwhm2fTMEUy5ROJLzQvGOwzul5txb3IPVttzW
 zEp9lQjW52nmezLVLIGUcy9gPmZIEAL0Eo+Dy2GEN1hRG2sWFllFnfVQKQ5jhLl6x1gg
 Cxh75IGakG5vM+sEKVBchYQvLvGxC5i4ogcGpRAHTGRxGe48k0q8vNPfeUrdSPCQdmG/
 XfOFhi5px5lspvXp2WFd7p8tWgJb0LnahyoVSfiPlXv0ohtTvVh+Y9e/HZ1nFToQUBvI
 uUVY5Jz7JyHENDK+NkRLhvIlM12esPcUQehxj0urIF0Nx5TtIJCmr1jRdMqGps9TtzSg
 KHTg==
X-Gm-Message-State: AOJu0Yz1bizt73YHjG5+RdsxLXIAEB881pzud02HCehFLeoq4VZc/9ww
 3EjT2UNRrQ4Fy33BzsuYpTvoxze5+s8qCYWlRT1WVJ2YP4CGYtD0TNiwrwjplu33qCRBBLkS16h
 CCYTx
X-Gm-Gg: ASbGncsUVEtRw1PKiqcayvj1AdYzRzihcyIoG3E7RnN3/V02SxYqaPb7/K/EpdvhK/2
 KSL4lfTkv+0bnRJe6TP5dJ1MoeT0Mh9jueOxxT90c7vDRM+GCVhGgRsqgEL1bX3aDoK/y8mhrLb
 ruVeb+fjGdqRkIN4mU/yRV15pj0gNgJK9QJDzfdrmUuCvNdtIDUHZXdduGdIYkNuIcERdSSM7mY
 p1FAq3Sfa54b12q/f9kUMn2hGpj8ssWxagHOxgzTsQWeeewQaDIfe79Y5yfOUIzYTO1j+m+kXGf
 LE+D8MiyHNlxAFVjNXGXqyPHeka6QorhabTZmiHmtebl+FkoL6r+zbj9c/vTeCFXTfPTJfQNrr8
 6WJwQ0eh6I0M+R9IJBn638C/pIFEjs0EnxsGcY5RHol3or7pNHPw+7mF2Q5evdLW1jB3FRFOxE9
 hYi7rMLQ==
X-Google-Smtp-Source: AGHT+IFRAFia8sfDpXZNWWq5QfVlXCLoli1h/W9k12lHWJ2HqX4dFgS8peo7X1Ns75yg2zI1dzDOXw==
X-Received: by 2002:a05:6000:18a5:b0:427:a34:648c with SMTP id
 ffacd0b85a97d-429bd6efbbdmr4282560f8f.58.1761935623984; 
 Fri, 31 Oct 2025 11:33:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/38] target/arm: Rename init_cpreg_list() ->
 arm_init_cpreg_list()
Date: Fri, 31 Oct 2025 18:33:05 +0000
Message-ID: <20251031183310.3778349-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Prefix init_cpreg_list() with 'arm_'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/cpu.c       | 2 +-
 target/arm/helper.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4c0fa28ef84..75677945af3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -377,7 +377,7 @@ void arm_cpu_register(const ARMCPUInfo *info);
 
 void arm_do_plugin_vcpu_discon_cb(CPUState *cs, uint64_t from);
 void register_cp_regs_for_features(ARMCPU *cpu);
-void init_cpreg_list(ARMCPU *cpu);
+void arm_init_cpreg_list(ARMCPU *cpu);
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d2fc17eab63..39292fb9bc1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2141,7 +2141,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     arm_cpu_register_gdb_regs_for_features(cpu);
     arm_cpu_register_gdb_commands(cpu);
 
-    init_cpreg_list(cpu);
+    arm_init_cpreg_list(cpu);
 
 #ifndef CONFIG_USER_ONLY
     MachineState *ms = MACHINE(qdev_get_machine());
diff --git a/target/arm/helper.c b/target/arm/helper.c
index ef6435c3efb..27ebc6f29b8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -253,7 +253,7 @@ static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
     }
 }
 
-void init_cpreg_list(ARMCPU *cpu)
+void arm_init_cpreg_list(ARMCPU *cpu)
 {
     /*
      * Initialise the cpreg_tuples[] array based on the cp_regs hash.
-- 
2.43.0


