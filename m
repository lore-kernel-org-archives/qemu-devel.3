Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E16C369D9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JR6-0001Kq-CI; Tue, 22 Apr 2025 15:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOu-00056c-9v
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOr-00072K-Ey
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224019ad9edso79433685ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350520; x=1745955320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMFyoxMcqEJbFer+UYr/caW6q12pnT/2IbFSElSLN88=;
 b=vJOUbklyUaKrxu8l4g7ryZZToxLP0MVHxV+dLN/Bl2vJD82TVrA3K8fn1gL74sWhiy
 s0eoP1WPiQb4E/02emxh2bdFESJ2EU1CBHBejM3GTIt3VKG06ws7oqn5EvnjRrpKEgq+
 wGJol84pP4pBDwFdGuHOCERkq78ujhWqDDUhcD/KkpImS7xdogbCJxa2fmJHI/Bdgl8q
 4OJdmpcs/1XN+xxocM3PUJijEjN8AcriVY3RKIrohcds31LbRnbkLbjqdMRtvc1FGmiX
 ynvc/OldMJZpxFxw3zmwZUrWikHgZOkV0Oqigb7bAPCt+414W2cXW7vEFaw3bJCIy3pd
 hPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350520; x=1745955320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMFyoxMcqEJbFer+UYr/caW6q12pnT/2IbFSElSLN88=;
 b=iaCeaKtuG8w6Sw0MqLOKVIbq9dN/4gbx2I8IKN0l3ZsatQ/CPruSi7/FfWXcu2HgWi
 f40pi2yvqpTp+Rlek3bdLFv/e1iGfacNboew5syfSNJ7NL5niwP46crUkqdgO2i6ohAI
 J5Zrgbh44gIKPsxDbI8DDJlU1leZYSA4oz5FmBZdLzapEK00jF52qUnJWxbP8AvJrI1E
 556sfy38iLzQlxGM/2wyTxC/kM5OOhvT4kvxHNa5dVagvKbaO3Dd+mSPWLxd3P5tBwJK
 3dQ1gAsgdF9YGUrFxqLG1jr1GGe4w/jrJ285Saty/oe8edCuJ5u0beofVKD+m2se3VUT
 tEMw==
X-Gm-Message-State: AOJu0Yy/jpLpSZ8ckY/YghlvjdYEtGs1s8FELAenUN3azXhspSTJLWFZ
 V5KmIFO6VzN22f77V3AHnbeFIFHT5MZc2rLWaVx0prM0UU85sMLE8z0QLS7AGLEXRbxzISd9tTl
 y
X-Gm-Gg: ASbGncsUB/ReBL9E3v08XLikj9586gM+Gi/Ptzw9ZIlpYWiT+NqftAs/977cwFoB1F3
 D+M5+qOO1XKDOkLuJgnDZgBtKQxu23BFOT5zl32r9pLg/edgDiWJ28PAftz1IDYvmpiPPt7nSXu
 DdXkLSFDfmqxRKNAZ2iutGNw62hikvv5CJ/9gaBxsAvpyzjGEdyB1NNr4TrkvATDo9iC/yx5jvk
 /TZVzJKpw7hsrDaN5r25MNu4eHz3E4JBLkHsbe2d7jLyPgQwuTJ/mq14HZrXP6W9CvxEiFYtI03
 o0x5J9jqgY7YWE7wCxPyMToruOMjXjoZPd0g2HoT3wVzouYJGnYEjRqGw/VgF4Xylak6hhGi5Tj
 G8MmS08UTfg==
X-Google-Smtp-Source: AGHT+IH/njQiuPVn2t9vrXBxjt09Ufpazzz3w7kPNMdxVZYmCroH6QaALm+usW9y4uViTBHYqewLDw==
X-Received: by 2002:a17:902:ce82:b0:223:6455:8752 with SMTP id
 d9443c01a7336-22c536420c6mr235413155ad.43.1745350519759; 
 Tue, 22 Apr 2025 12:35:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 090/147] target/sh4: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:19 -0700
Message-ID: <20250422192819.302784-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-20-philmd@linaro.org>
---
 target/sh4/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ce84bdf539..df093988cb 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -266,6 +266,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .translate_code = sh4_translate_code,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
+    .mmu_index = sh4_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
@@ -291,7 +292,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->get_pc = superh_cpu_get_pc;
-- 
2.43.0


