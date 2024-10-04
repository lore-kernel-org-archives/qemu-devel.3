Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22DCCF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl5i-0000TT-Sf; Fri, 04 Oct 2024 12:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl5g-0000Og-W6
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:23:41 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl5e-0004WQ-Km
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:23:40 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5398b2f43b9so3174816e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728059017; x=1728663817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VYw3qJQ7kjnbHLJqdL2EvLbi+7yWM9GeS/O5plTTIVE=;
 b=pqBa/cjCptOFwkDGGZQzF4gpmYN7wFC8jnomAVv2DL4oLcriIcfy7G+HAXf52yxtXm
 lw3K/iWBrjGYGHO3tKXNr/vZVBVAzueIJnzW8gEx/Dn8O3Z9oHA7X/4ly3Urdq4n8wza
 8qje07EuTqqsN4hzM8R2oZ3Chqb+HgP8mSx26kv6dyZfnX48Puv4UwxU+vpKfuz0J1uR
 TIyJCCmfkINaN3Tn2XIBvxqIkIT4YKqCSsTKbNNbwmt9mx5/8eKRfMmvM7wunDHosaxD
 ItiJtmyWREecYNKPNaM4LUzS4Dl1iK5/OoEtkYa41mbhwrxEpXOCrumZikohWKXEwjBb
 B95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059017; x=1728663817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYw3qJQ7kjnbHLJqdL2EvLbi+7yWM9GeS/O5plTTIVE=;
 b=JnWgz13CxxuA/f9MbT7bMd3aKGO3KpWnCUe7KRYuEjVlEAX3vjfQty4QPDk/jaG84g
 lsnwQlN75nKdCCvjmJO/iLDoLQg70JSuCAOf1+Ffd9guyVZS1NRg6lweFpgg4fx8eG2a
 mX3gXZawDc/ipcB435uUSvxWaGUT/w4faHMMFz2C519si5V+/NGSbUAmO6Jp9Na6fK3H
 BDK1hBwpRzeWlmNZ99N8SRjDOhZE3Pd7LV02cAiJUq8UFtjMT3sUlBMGkIvwlwCo99K9
 ReuT3USkfbXcIK3H/0juDjs67nJ2S1uOVD88csOa/K12HDA2iF/+Uw7vYsWgEqk55yGh
 T8uA==
X-Gm-Message-State: AOJu0YznormquyWWPz3HDn0hZtUJGX7bv87+TPTcs37nIgedoGFMfrgj
 WTS7sGJ9pjhy2SuCIpBXg8bHl04/zyYY0zs/NrNTdQ2FAugJtrvDCpatyEEQ0WCD2ZhxljW+XtQ
 E2g0oug==
X-Google-Smtp-Source: AGHT+IEKurLqbxv67rMnOvrLmRo5/uDd4/TXW2NXlMq21DozZSL7E8WXl5bpdYXFcpUGPQkpldPYcw==
X-Received: by 2002:a05:6512:6c6:b0:539:9155:e8cb with SMTP id
 2adb3069b0e04-539ac0a9e01mr1184983e87.0.1728059016567; 
 Fri, 04 Oct 2024 09:23:36 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539a82a4f83sm458760e87.236.2024.10.04.09.23.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:23:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 7/8] target/ppc: Register CPUClass::is_big_endian
Date: Fri,  4 Oct 2024 13:21:17 -0300
Message-ID: <20241004162118.84570-8-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 target/ppc/cpu_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 23881d09e9f..39ec290cdc0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7341,8 +7341,6 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
 #endif
 }
 
-#ifndef CONFIG_USER_ONLY
-
 static bool ppc_cpu_is_big_endian(CPUState *cs)
 {
     cpu_synchronize_state(cs);
@@ -7350,6 +7348,8 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
     return !FIELD_EX64(cpu_env(cs)->msr, MSR, LE);
 }
 
+#ifndef CONFIG_USER_ONLY
+
 static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
                               uint64_t **irq_counts, unsigned int *nb_irqs)
 {
@@ -7515,6 +7515,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
                                        &pcc->parent_phases);
 
     cc->class_by_name = ppc_cpu_class_by_name;
+    cc->is_big_endian = ppc_cpu_is_big_endian;
     cc->has_work = ppc_cpu_has_work;
     cc->mmu_index = ppc_cpu_mmu_index;
     cc->dump_state = ppc_cpu_dump_state;
-- 
2.45.2


