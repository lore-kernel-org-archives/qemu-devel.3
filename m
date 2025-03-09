Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380ECC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKsf-0003Xd-Gc; Sun, 09 Mar 2025 13:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrl-0001qc-F0
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrb-00057q-5S
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso36475135e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542897; x=1742147697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sppGnK7gq8hW+5sYH+c2kdETQLMRVDeaVClIKxwTfDI=;
 b=o/B1LwR8n2EmPV0L3EE3ewrFonn0eBkt4xvojpVkaL1bXc8zvn42DkZZ6fGtx16/ep
 icoquEsAjNo/vvLRBUsjSnugdt7Z8bnjog7mp6meIiEXqPKWYmxkGFl5TJd5l+blJsb+
 65J/5mALSxJ+hG0fF307RkYcJs0cC5F8hOhFSmatHl6Xw9h4kNsC/74gItqEGE3i6tZ5
 5/rmAAhqGG6NnvzHftOMDooO4nv9Un4AWsKWQDe+TWgUHt1fmwHWhmOSJeJsfHcYZnGS
 D05MtHwTgVQZIya5cS5gC9VARZR+kfPMlMjDKxyToDFcmzTswj58/isgClVP1NahCr8s
 ntnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542897; x=1742147697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sppGnK7gq8hW+5sYH+c2kdETQLMRVDeaVClIKxwTfDI=;
 b=T9RZ3zRLsxQdQxgk8fIKVFYbvERSS4JAxOFXuilP7Uj1/m51H4MkxHngXr89TGBcvl
 lZpo7wOImymnJF46+C2o9of+IeVIQr/fgpfxBktk4J8QhCDaZ1NTw62e2szRu8vT5GEK
 W+7V7biT4nBgeUikohap+KO0KTENVBj3ateiP817SCq3BuC19RVsW0J7z2YiNwpN7U6S
 7Ub0qVJZE8q/kIF4psUpaINuRpDG2+1vkRToUAW3a/tZCpgWBjWWWiPN1En0KqDssvd5
 LSpSa2L8+l7hO0IxamGG2fES5PGYePi7v/zWV/i5eacy1PjBizfRzYU1HxuVuWZ6Sjpc
 HIfQ==
X-Gm-Message-State: AOJu0Yx6cogOXjmv/Y+NgOFfEbxqLeNOr00NpzIFxAU//HGPuUUvNlts
 mfGZhyUBEbIrCQrc4xeC5oS43IL3jayvbOQUjZLDdzvdZCRKX0x3QE9tW51hCJIW1rV5822C1wf
 RZQE=
X-Gm-Gg: ASbGncto37tawSKjoqUvn3SxysTbHesRTO1PNT2EaGehM8OPQG9L5FDWSfv+nctSr6D
 lL7yMrNs6EaVMLxE69TB2D+lGPtuiM3Sit1HQ1lduQg/NG+QLT0FGKxrB+eUVejiX/lmoEN4RKj
 p95bNC5erjou1Yffxgejss4u37K/N1LdgjeMeU4xcLZnJjNhzhWSx6RERKtkjEiiViOSN5FpS+o
 adtmqBznPJnnehyvnN6K3YKHnThO3EiwVzBRo2YLYm1cbJ8YpT393JltmawYPb38DxaJdAgK5bT
 NRk15kVkhkQP8Zdo2ejnj2QOw18FeR4gYtZqW1N/CQTvMPZaGkYT+DO7Q18IMamAsK2RafNWXVE
 3fRFVfRZVCJSlian7ea+KOOdL+R47Vg==
X-Google-Smtp-Source: AGHT+IHHrmjEb1PzTO3ZBcnNZSWa8+jISTfcKZwuSQdT5re9VrPAf1Qc+KD+P6zp0vOLRYJwt1d2zQ==
X-Received: by 2002:a05:600c:3b0e:b0:43c:f575:e305 with SMTP id
 5b1f17b1804b1-43cf575eac0mr10816255e9.8.1741542896875; 
 Sun, 09 Mar 2025 10:54:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfbab43sm12633687f8f.15.2025.03.09.10.54.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/38] target/tricore: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:52:04 +0100
Message-ID: <20250309175207.43828-36-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-23-philmd@linaro.org>
---
 target/tricore/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index eb794674c8d..16acc4ecb92 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -165,6 +165,7 @@ static bool tricore_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps tricore_sysemu_ops = {
+    .has_work = tricore_cpu_has_work,
     .get_phys_page_debug = tricore_cpu_get_phys_page_debug,
 };
 
@@ -193,7 +194,6 @@ static void tricore_cpu_class_init(ObjectClass *c, void *data)
     resettable_class_set_parent_phases(rc, NULL, tricore_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
     cc->class_by_name = tricore_cpu_class_by_name;
-    cc->has_work = tricore_cpu_has_work;
     cc->mmu_index = tricore_cpu_mmu_index;
 
     cc->gdb_read_register = tricore_cpu_gdb_read_register;
-- 
2.47.1


