Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0483C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKrA-0000Ou-25; Sun, 09 Mar 2025 13:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqy-0000B2-GW
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqw-00050s-JB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:54:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43bd03ed604so29851405e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542857; x=1742147657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5EUWAiewtfRh08yxfu3LWHBkVUDBiRO2vbKbcT61Kuc=;
 b=v/HvF4tVkWRYfjdrS3h3B5Hj349w28V1U1EvZkbL6a0wjyAYszvoKqQ7Fhjtgdmscj
 G26qF0ssvaItusWTycS4BoxpAAcvHZucP6CHktHLzdepVaKfoORugwZ/3tb2I+32eksH
 5hyiFOt6IUHvTQYO4fvhpyd2MhZhKtzHXgvCtXWPVhO9NMaMPlqJ4KuU/pHnPTSyh9m9
 kcxX+bopG6Bvawq6uUzreMCtjq15CCBLF9fXJH0Gf9/CYlBrKmvVc0XcEliomZPg7N03
 1XMKGiqsIEplN2TRJ5SqCCrlBQJ9PzM+SelW/vDmSkQxYkWUQVvNrjXpWoChYLBZMTt0
 GDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542857; x=1742147657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5EUWAiewtfRh08yxfu3LWHBkVUDBiRO2vbKbcT61Kuc=;
 b=MriRF/mE/XbJ53JgCROVlzKG8vPdz7nbAPlvzTJyWoQ5Zshj36BO56gSiV+ke8Fq3a
 Fjrk2ch5ZWOWowCU/gnGBwJYb3YK8KpFDpDyc1Etd4YyoJVb7NgYd6uVBfp1IIdeX6rY
 PnLaG+0GWNXt468CjVljAJbwhhV9QG4vTNDN/Nsd/XEGXoNg81kYx1p0V6Ox3QXjZVm7
 x3WlJaWnKz7Yr5czQwbqhxsrIzYbOErZGe0dckSVkh4lxmOaYhEbWzwluoAubuNE+c0p
 MQFC2kLMGC+1CX5JpGMi1cvPOD0Uw0cTT31WlSkwVAd6SSpd+Us0BRvhqvsAr60r/U4n
 lplg==
X-Gm-Message-State: AOJu0Yzfg2NSfOdrTY1OUuJ5mhz6YvYpEwKC0aYR3TLQilo8qV3FjCSa
 Og9FFJdBMFxUv1UesAXzB8N5A2vuTnSdj5D0I3v3hbX81fJWBh5WdtSe83qv0T2koBA6okay+/5
 SKHA=
X-Gm-Gg: ASbGncsyv774DoKdkYbcioOjq1a9CTMiHbW5bZcHuk+WLLoypkyS1jVpH3Yo+dbH7kh
 3ygU1vHmIcjwshmOHUPv+K1U4lhj8RQrKV3I9UIIW4a5VQUTp4lN4LtUrt+dasX6obhWj3RPKuv
 /rEzJzSfjekCkDseXbJ5Trj3u3PMWBM0sVUC5vWjBMp3QQW8vCiSETkho03NeN+qjl51naCHl2g
 HlaMkBtBpNaxD/y7DRdPVwCDFeN15EW4WR4tOo/3VXX44ypRNstHFGopn0liQXKX5GKvV89Lrop
 altMm0IW1Oq2ArC2SuTOfItOoDgWzEf2nYqWulWKZ2lDnkfoURf9wL3Gv1SCUsKRDNKOYRocaPa
 HjEo+rFwm9OEKgvKV0ao=
X-Google-Smtp-Source: AGHT+IFTdVkTKhqOY1yXfCcaUp98wmE7hgMIyQxQpQh2iq8MoehNQo7nN+2gel2cBk1RY8zpDdokhg==
X-Received: by 2002:a05:600c:450d:b0:439:7c0b:13f6 with SMTP id
 5b1f17b1804b1-43c6872e1ffmr77332915e9.31.1741542856644; 
 Sun, 09 Mar 2025 10:54:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f57sm12480089f8f.91.2025.03.09.10.54.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:54:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/38] target/openrisc: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:56 +0100
Message-ID: <20250309175207.43828-28-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
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
Message-Id: <20250125170125.32855-15-philmd@linaro.org>
---
 target/openrisc/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e8c357ae836..e8abf1f8b5c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -63,11 +63,13 @@ static void openrisc_restore_state_to_opc(CPUState *cs,
     }
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool openrisc_cpu_has_work(CPUState *cs)
 {
     return cs->interrupt_request & (CPU_INTERRUPT_HARD |
                                     CPU_INTERRUPT_TIMER);
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int openrisc_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -233,6 +235,7 @@ static void openrisc_any_initfn(Object *obj)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps openrisc_sysemu_ops = {
+    .has_work = openrisc_cpu_has_work,
     .get_phys_page_debug = openrisc_cpu_get_phys_page_debug,
 };
 #endif
@@ -266,7 +269,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
-    cc->has_work = openrisc_cpu_has_work;
     cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
-- 
2.47.1


