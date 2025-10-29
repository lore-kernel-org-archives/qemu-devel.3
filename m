Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769D8CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE9w-0001rA-Fn; Wed, 29 Oct 2025 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE9t-0001nu-UJ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:56:46 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE9l-0008JS-T5
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:56:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so9067545e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774993; x=1762379793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zG/Qnb38xympFyj6CMDqOivPUjIexpytFtgM6ZeeyWk=;
 b=rnXSLzcyGQFGDOlaHAPbJLUqxb/BjprQe2ljPTKEouKXB68gNoAiNGjHPqru5zsQMg
 HQO3QhQauOfDMBYAdW6usZ0EtUadMoo3vunlUp52BMgH2VkVqRp+VyfSUeCGSp0A3miN
 jDSBhEHiWICmc7IrDGurslWkOXThgXw0OvVt9nVnb8eRYDIdsRZtXBfq9CgOj6Zw2/Go
 wT6/CwHwNGi5pjvk5k9wITdsR258VQtYfne8TcTsWdfoiPeIB1SKAkM5F5XFk39FWzmr
 VJYV0eNwNAItfQJEYfHz1UCVVF3BKKtw0o9ccP0cAAoaiTtnG9VU5HMzgw/50WRXy0+U
 gRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774993; x=1762379793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zG/Qnb38xympFyj6CMDqOivPUjIexpytFtgM6ZeeyWk=;
 b=oHibLQBEwfSIrsGfe88dieYjOeR/P1CKeZmYhVkT9VmpkmRMjrL7X5Nl6nQk5CwyAG
 oJW3EvHrwdZrEnkxVelK+CLbCoNSTg8qxvvWdiWqM5CoclADUjbdASNwloK2lLSJ/X2j
 QRT2VXitRpYJIwxuWcd8cWPHs5lKBjyIkSakp6R5BtsrZ6FPT/EGvIc1yAzQ2HYq6RQ8
 rZDunxwxopPaaH9kUNu1dWIw8bK0wuuDHX2FFNHagGqt1lVmW8xqR+uip5/xX+/SyuaZ
 m7fNBhX/Zt3SmM5Di1x6+CJaPb5MhvFH3jnCaUfIYl1PL1gO/fW2sbmN157cP+gGr3NC
 Aqqw==
X-Gm-Message-State: AOJu0Yzifer2CPRbgxG9HrhFfZy2wjgAXf1JvADKTGKirxGP+tAlgHFs
 +2yLq/n8C7xNnXivBJR6aFrdYdKrjGMQkpFqqvQZMQmuXvr5KK7YWMf/36/mjpXFys8pzNs8eer
 WdqZnD/g=
X-Gm-Gg: ASbGncth1F9pTMVqjlhCiYx7Yg8nHPuAggO/q+qJ99JdtUw+93/epNCUVeNMLLk/amq
 bBfEzWK4eUTkKTZVOVdeFcbtXgubn5qCtjUV7eWzGbHtTsbxzKOBZXzXC6xDBAvH0vlWzHp9DNw
 8hcTXId30gZk05WbP52QmLVhNY/IN1QT7ZPYnu+YJQpAB2eMApmaX4yIE4HndRzkEf0RZ4AkhoR
 6u8h56mzAPIZMb+L2wWxBnunhbcaFcGbd0pAd4VxBnVz+lB2PQUJcQOmh7DI2heeaRa19KyHfCE
 cr9kRJmy0FHQnAiD2mAVu717fNtcTmDHPjWw6W2ev453lvN5Kok7mpoMw39Ma3Vzr7AaZWe9YxX
 yWzOtVfuh1HhgWGiMsn8xSsRxV944ZqemTqhtOrO+fFbPmBqNs04xMn2vrJzEGNVPYp1J37P/w9
 ykRctPytXt9f9vCtCncl29MEQs0x6DVA4lwWwEzdQ5vRBT97QWRQ==
X-Google-Smtp-Source: AGHT+IEgYXAiNqbgrYwZxHxjm0MWEUHv/nwLsIkcUaY8N0ly4tQPUx/xK+zoagSb96myG2MM2QSJ/A==
X-Received: by 2002:a05:6000:24c4:b0:429:8d74:4b16 with SMTP id
 ffacd0b85a97d-429b4c81dc6mr919430f8f.20.1761774993159; 
 Wed, 29 Oct 2025 14:56:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b2dsm28162128f8f.2.2025.10.29.14.56.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:56:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 16/23] hw/arm/virt-acpi-build: Include missing 'cpu.h' header
Date: Wed, 29 Oct 2025 22:39:53 +0100
Message-ID: <20251029214001.99824-17-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

"cpu.h" is indirectly pulled in by another header. Include
it explicitly in order to avoid when changing default CPPFLAGS path:

  hw/arm/virt-acpi-build.c:903:34: error: call to undeclared function 'arm_feature';
    903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
        |                                  ^
  hw/arm/virt-acpi-build.c:903:53: error: incomplete definition of type 'ARMCPU' (aka 'struct ArchCPU')
    903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
        |                                               ~~~~~~^
  include/qemu/typedefs.h:30:16: note: forward declaration of 'struct ArchCPU'
     30 | typedef struct ArchCPU ArchCPU;
        |                ^
  hw/arm/virt-acpi-build.c:903:60: error: use of undeclared identifier 'ARM_FEATURE_PMU'
    903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
        |                                                            ^
  hw/arm/virt-acpi-build.c:993:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_DISABLED'
    993 |     case QEMU_PSCI_CONDUIT_DISABLED:
        |          ^
  hw/arm/virt-acpi-build.c:996:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_HVC'
    996 |     case QEMU_PSCI_CONDUIT_HVC:
        |          ^
  hw/arm/virt-acpi-build.c:1000:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_SMC'
   1000 |     case QEMU_PSCI_CONDUIT_SMC:
        |          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210144.58108-8-philmd@linaro.org>
---
 hw/arm/virt-acpi-build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bb6b605154..200e2a1da70 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -62,6 +62,7 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 
 #define ARM_SPI_BASE 32
-- 
2.51.0


