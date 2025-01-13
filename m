Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FEBC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQXU-00061h-T9; Mon, 13 Jan 2025 14:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXE-0005zP-Uy
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:41 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQXD-0007RN-FC
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:55:40 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso33338415e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798138; x=1737402938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTM7kJDrHWUpg1IPISR4zuSM03kjMUv0Xm2Dmwxq0M8=;
 b=HhcYBZ+fip5IfMoZUxtCsWmT/X0rsu88e5w5H8JVP/3SEk7r8kvdY4DpcHxbupcgYK
 CUGrxryGCGiFfDpalD3eLCf5v81wsC9/J+flnt5Ec3ZbDcr6jFgyl+yCJSsDErfOBOVO
 lMSF4tTAhiSXe3w9HAuEKW9oZLEA2NUbSIKy2ZQLllcMsttBhmnN/h/gNgcfqBObgG1B
 NBY/wWfXiXYzMYIrQkArQn6BGQVB71TDKF3NVpF537EGclGUJSSaUW71aEcSPxjiueAX
 faAw43rSg4uwr+Xnx7PuVNCZkZLwJI1YKAjbdqYEclNAdKBI0ACEf24tRkvUdeuSC/bY
 qoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798138; x=1737402938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTM7kJDrHWUpg1IPISR4zuSM03kjMUv0Xm2Dmwxq0M8=;
 b=OyF6fyFgcZf3GX3cprniLC+0f5tSyTGntG/P6VfaVu+goYfKkjDN9TdLmKMpstBuoR
 f0jFJ7+KAwEbhqsGBHPWuG4TWCmr6nBJ22txpcxxUKybuZwLVO1yxCyU/A4aEB4qAotm
 qk9jfaMtaf0IYa4LAAtx4tHcwbXRyv2N9abaGV0sCeb3QAJlbnuXrk8ujxY8KkbTIc3Z
 IZa3q75AeED1V9rs95Aj0OzGD7z4s8NZ+hOoCKDtKNsvnLEuyDOHMgZE4ABDKBMnjI5l
 zFu0Tz720AEbmV7dTuxoxM1fiUi6ecW9ZQDe7qXavs1D4pzEnKMA6BH13Tc0DB9rDka1
 FiOw==
X-Gm-Message-State: AOJu0YwHZ488PRJXX/E0E0mc1CIZndvLv6rW64BVN15sO4AjtFJ4Q/kd
 e8MRbj8/3IiLu3xMGMoo7PArxPm0EnAJ/rvHYF19pp3vmkAMhhxEl3W5B2DsjhOSxCajkmpd9Lr
 fGhY=
X-Gm-Gg: ASbGncswC22mm8mBZjZdamj/bsAm6b6p85Esoju+/nk/Jky1OhRS1k8HXQARjg0zbWd
 tWzRcoFys9zIFV90DN2vuCEA++jPKD6JeaqiqGN4ArkB8mTSPCuqTSS8hO7DzNJJ4vO8+1+KacQ
 FYAaF1dc28xPJJt9FgxpEjFsQ5KSzs9BdY05V4E14YAtfpU6QlrJJ3elVWcKF+pkMuB79VCiO3l
 mT/PoIKV93TWFNvBM/2eBA1FnMNSSj8AJOax7sbRA6vx3qPa5/hENlmpB2vj4zeQAnE6FXSQDaQ
 aNdGnCQ61PionoY2KzrlnMek+GjLXxM=
X-Google-Smtp-Source: AGHT+IHmfpUKzw+43t3kqzIxojFJ6+ldOYJHd/HTs8v8XsCIEs8f6Rkdrv2t/3jymrQ5C6WWFS01hg==
X-Received: by 2002:a05:600c:468a:b0:434:a968:89a3 with SMTP id
 5b1f17b1804b1-436e26a78a5mr162452325e9.9.1736798137700; 
 Mon, 13 Jan 2025 11:55:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc67sm154645675e9.8.2025.01.13.11.55.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:55:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 02/19] hw/mips/malta: Check CPU index instead of using
 &first_cpu
Date: Mon, 13 Jan 2025 20:55:08 +0100
Message-ID: <20250113195525.57150-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Since create_cpu_without_cps() creates the vCPUs iterating
up to the machine SMP count, it knows the first CPU is
created upon the first iteration, at index #0 :)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/malta.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 4e9cccaa347..37be2330eda 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1042,12 +1042,13 @@ static void create_cpu_without_cps(MachineState *ms, MaltaState *s,
         cpu_mips_irq_init_cpu(cpu);
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
-    }
 
-    cpu = MIPS_CPU(first_cpu);
-    env = &cpu->env;
-    *i8259_irq = env->irq[2];
-    *cbus_irq = env->irq[4];
+        if (i == 0) {
+            env = &cpu->env;
+            *i8259_irq = env->irq[2];
+            *cbus_irq = env->irq[4];
+        }
+    }
 }
 
 static void create_cps(MachineState *ms, MaltaState *s,
-- 
2.47.1


