Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F86CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swl4x-0005vL-Je; Fri, 04 Oct 2024 12:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl4p-0005hR-8k
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:22:49 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swl4m-0004OA-4B
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:22:46 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53993564cb1so2705909e87.2
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728058961; x=1728663761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLznYmz+P7vBJ8H0SWJD6m73dHSWXSUG/rbFskhTHcE=;
 b=aioN/uevlUgE3ioqzYydQ7BAzxp5k+EVy504y2/wi6XeF7jxiAIs1nImK/gD0g/GL0
 MV3ZxhK/V+P+91NcWyphMW3u/G4zlBAZn1R/6/JmkWdW6A+wtv06tus0vNSL6pZrjPOE
 WCuVMJ5htETLtfziJ7/m21quSjpJOXsSPjb732v0bkYth2HOUfDuQD0Jw5UDWjW+vKqT
 4bhtdDIUaBZmMS/LRksHJUqY+txsscTeGoUk5cEhb+TwOd7z4cbv3y2hoiEjcrO+TLii
 fiwDGKINSaHKDc5ua7ttqaT+6Mc29uvf4iX7qx6ITsYXZuBo3CaKK/jXnCAdlsba3x3p
 Xk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728058961; x=1728663761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLznYmz+P7vBJ8H0SWJD6m73dHSWXSUG/rbFskhTHcE=;
 b=phC+rJVSaxItPDdz+gyKO0xoHBla2dOKSYoBLqMyzoPl+xrDfvkozvtmn5Igjp2brQ
 8fJ1H1axXa7DB3c1AxeYOxSgkOirLM9+zZH4v1QmED4tVAIO+BF8mEcvvX24CtvX6JKv
 fzrSouDczXydPYwKkPPqyGud2EwkU46Gr674kthR9bu39RysTas5X08+MU7rQZWyKeHZ
 PPVn4rtS04gEaxbxZ8+pgqEgW9PJPzD52a/KVlnS01Sw0/8mLxcqkB86veAMTyJJJGV0
 khxij0PscUTWKEzEzL/nFWHUYhq4JI2QalEXZymkQKctd7/3B6ORBZjeOJHLvqTmnFEI
 +ShA==
X-Gm-Message-State: AOJu0Ywm+J3ICdnmMYTP4+W2goiOHpTBpD9kDxn7JEJiHVeOw/6CGyLn
 jVrk3HBVXdRIkUwfL2Pye31PAM52LhbM5JCZhkr8GY5vDICuEbW/BYHjj05ifXK9VK9ZBE7+KLy
 I9i9sYg==
X-Google-Smtp-Source: AGHT+IElSimH5oZLigLV434JMwrFehY55HhLGGCMlsd7shRaPHsnstY5dok1WJ0KheoDJAapYycJIg==
X-Received: by 2002:a05:6512:3d10:b0:533:4522:7409 with SMTP id
 2adb3069b0e04-539ab8c2165mr2174945e87.53.1728058961531; 
 Fri, 04 Oct 2024 09:22:41 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539a82973f7sm464073e87.120.2024.10.04.09.22.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Oct 2024 09:22:40 -0700 (PDT)
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
Subject: [PATCH 4/8] target/microblaze: Implement CPUClass::is_big_endian
Date: Fri,  4 Oct 2024 13:21:14 -0300
Message-ID: <20241004162118.84570-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241004162118.84570-1-philmd@linaro.org>
References: <20241004162118.84570-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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
 target/microblaze/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 135947ee800..93c0c6d36c8 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -119,6 +119,13 @@ static bool mb_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
 }
 
+static bool mb_cpu_is_big_endian(CPUState *cs)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    return !cpu->cfg.endi;
+}
+
 static int mb_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
     CPUMBState *env = cpu_env(cs);
@@ -433,6 +440,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
                                        &mcc->parent_phases);
 
     cc->class_by_name = mb_cpu_class_by_name;
+    cc->is_big_endian = mb_cpu_is_big_endian;
     cc->has_work = mb_cpu_has_work;
     cc->mmu_index = mb_cpu_mmu_index;
     cc->dump_state = mb_cpu_dump_state;
-- 
2.45.2


