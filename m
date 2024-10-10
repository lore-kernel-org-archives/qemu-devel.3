Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CAAD2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz154-0003ar-GL; Thu, 10 Oct 2024 17:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14x-0003IQ-87
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:52:16 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14v-0004rA-KJ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:52:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b93887decso13215655ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597132; x=1729201932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FKivURGKdC6DPaBQQIskyUVxHkTiYj2NkLjEjmDT2qw=;
 b=XXW3NgsqkWjQr4H1DGVTdrVptCm9y/HoUyEtb5xQ9DzDLmhLUh6620yV4GpyBFEK7N
 GHE6AW5jf4+BJq0TYmHg78yLLu13z/yi3WAEb7xl0Y4vJ3EHnBlH0nhMPNK55nWCFkNS
 KfVkGJRxkxGoSEBEbcvzpcSEDVysZDmCT7qP9JlZnP9K+MosR8XHiRqLZTenpRiokOTM
 QiIAsImTtu4T+R+Ld0f++hbQskNZLuDOmBj8UNyk2HVQd7UN9D89Q5aE9x34M3NF+y4m
 NLHjdUVb0VZKtHxFXg0x51gjO9/40E3NtXTuOgZ8YYBuV8oG4+HOayk3X88Kc6DOgcLr
 bNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597132; x=1729201932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FKivURGKdC6DPaBQQIskyUVxHkTiYj2NkLjEjmDT2qw=;
 b=V81vWdAjskoojI5Kbmt2gtzeQXpTztS92lDDt8ZrVbTK0h0XFaKoYqVUdGAmSyyT6x
 nYJWsiCFdEJcnbhpARt6zZEWNn1MPRJ52hc0Rn4Jx2w9FStSs/vHK+9dnSgXItrZQfBm
 S6l8sF6yqnvN1oEpIKtoQPfeW00DX849z8VXWa/JcXqzIun0cT8qJfGZ+0KrVDyR7cBs
 tNgWXNd+6JJsQjxfYw/ufwbAGXJwKGxFmY7yqRZ+wh6TnPwG5xNOFhgEOT0HYguXG+M0
 vpDNZCAmzJWqZeN+9dJT0N3xpCzKX2Ir1OGedomXauaHyrBefIkic9WLBVlnvn8d6MBR
 aRZQ==
X-Gm-Message-State: AOJu0YwVuZBR+/WxOF+LvAx7EXv5DMk33YHabPxnm3HnJFIifO0S0uKB
 IrCJaVIbGAYoSYae3uFMl309Rq88Q4EVNSN/+2CRfg599eSoe6YwII6WuxzV00FIWRadcmPCx1g
 Q
X-Google-Smtp-Source: AGHT+IGD0WXHrbT5G72RE4OIpGOfTkgt1FTARFWUoy0pCXC9MR9lHgu6gt5Tsa7+SNAcqo4nkZMzIA==
X-Received: by 2002:a17:902:da8d:b0:20b:8bd0:7387 with SMTP id
 d9443c01a7336-20ca16d3988mr5136375ad.52.1728597132046; 
 Thu, 10 Oct 2024 14:52:12 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c36d723sm13656025ad.306.2024.10.10.14.52.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:52:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v2 14/16] target/mips: Expose MIPSCPU::is_big_endian property
Date: Thu, 10 Oct 2024 18:50:12 -0300
Message-ID: <20241010215015.44326-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the "big-endian" property and set the CP0C0_BE bit in CP0_Config0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/cpu.h |  3 +++
 target/mips/cpu.c | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3e906a175a3..070e11fe0da 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1209,6 +1209,9 @@ struct ArchCPU {
 
     Clock *clock;
     Clock *count_div; /* Divider for CP0_Count clock */
+
+    /* Properties */
+    bool is_big_endian;
 };
 
 /**
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index 89655b1900f..04bf4b11db2 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -200,10 +200,8 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
 
     /* Reset registers to their default values */
     env->CP0_PRid = env->cpu_model->CP0_PRid;
-    env->CP0_Config0 = env->cpu_model->CP0_Config0;
-#if TARGET_BIG_ENDIAN
-    env->CP0_Config0 |= (1 << CP0C0_BE);
-#endif
+    env->CP0_Config0 = deposit32(env->cpu_model->CP0_Config0,
+                                 CP0C0_BE, 1, cpu->is_big_endian);
     env->CP0_Config1 = env->cpu_model->CP0_Config1;
     env->CP0_Config2 = env->cpu_model->CP0_Config2;
     env->CP0_Config3 = env->cpu_model->CP0_Config3;
@@ -541,6 +539,11 @@ static const struct SysemuCPUOps mips_sysemu_ops = {
 };
 #endif
 
+static Property mips_cpu_properties[] = {
+    DEFINE_PROP_BOOL("big-endian", MIPSCPU, is_big_endian, TARGET_BIG_ENDIAN),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 /*
@@ -571,6 +574,7 @@ static void mips_cpu_class_init(ObjectClass *c, void *data)
     DeviceClass *dc = DEVICE_CLASS(c);
     ResettableClass *rc = RESETTABLE_CLASS(c);
 
+    device_class_set_props(dc, mips_cpu_properties);
     device_class_set_parent_realize(dc, mips_cpu_realizefn,
                                     &mcc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, mips_cpu_reset_hold, NULL,
-- 
2.45.2


