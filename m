Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B496CC28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 17:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKqk-0007pV-RW; Sun, 09 Mar 2025 13:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqL-00072C-Gs
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKqJ-0004wF-PF
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:53:41 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cef0f03cfso3867225e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542818; x=1742147618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dVTT7M29UlhbWD0hltalGhxOvIP53FS/q90YZtgLw04=;
 b=A5qEXC6ZE61r50xlDOAz1TwJfnzgcy300Oqu+fb/kyS5pRJCr9Bb/d6r6nRu4KreBK
 kXd+7WD3jJy0598puHNAOX2oDN/y+YPqlJ6As3Ba6XNRE5YUphOvHYEVsTec7QXaX4iL
 2+eNiCVopFHdOtYMk3OUomFq0lNVvOR922P0mpLiOZLSpolGCel5/axSeIxKznvGx9rD
 2cs6xPgwIb/8JbK5uRBTrN0P5v8+ViwbLG094FMfIi00ff4Cjp5hOvtXs1uk2wvsNOeo
 38aGwXhFUl49wvjfVQiv5ZE824jbRKH9ZJKvG9ezhNy5npL76h+WmT0SmtYmX4rk7EqO
 lJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542818; x=1742147618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dVTT7M29UlhbWD0hltalGhxOvIP53FS/q90YZtgLw04=;
 b=HM/yGi9c7G8fro4PERHAAJySUxYE2TlgviKUew1GmOOPSNrvPSnzox1hDNspDzDrTP
 fp4ewnOnd8k0i/VQ+2t8pHEdXyEJ3THYRg+94GjZIdjrONq614PRyc1xTQ9kYTBr/1Ab
 1RlOVxTTIE4SOjgrfUHlfxax/ZOaoFIlW3pNLNlZXqJAKeC1HZAo9Yfrl9QJAUxotEoG
 5i31uG4d1z0Aw+UUKhQUGEj3Uejj5Lpr2IzN0QvKev0rlFN6lT9i5ASf2FPaBPOowR4e
 4p7z7fJwQ5d9M3RRsUr/oumdcv0KjrCGGI5QlggIk4ugrDw7bvT1j0GcDJDcaOsMoDHw
 RIjA==
X-Gm-Message-State: AOJu0Yw6TrYSL0VA99YKbICk2gb2iquuYH42XPMsnf12r9uemSGjxjzI
 NzhBHoKUdM2p9sIp2Vc/uLsivTt+R1T8wy8rRkqkHh6FkUTsoxyjvsJrAnedGOsrLhRib4tA03B
 +ISE=
X-Gm-Gg: ASbGncv2FWhADiD/sF4sjBueIwludmE7mPefuYkpvpVIyMvwwIHQTilH7lqOIMdkHC0
 QmfOxTzDBf+MIX6lSJ+xir6oXmOmP3frOW4lAAtWXq6cZiDkjfkgDEECp9soiLmLBT5+ffj0aCn
 c8Gikducy9Ic7RRrs+OzKUcexjKApvLLk4ypP2d9ZtJZp6zFgG6LVNpyIgsAJNZXRmLRdPS9ZQ3
 pO9cfdmZ6iEWwO8cGl14EWiUzbwtWhDXgJqQRp5UX6Iii9YvOtKt6D2IlrD0c9mgmTLpQsIxRty
 ip1FjF91ePtUZuQXkAydTMo94xb0grYZ2Q+/z+MmD1haiDceniVYiiWoUDsrbb2CYlirJwtfScK
 c1qSQ6EBuJImmXfh1WbM=
X-Google-Smtp-Source: AGHT+IGxPlVF+MyLqO0d8ETQ7lZfMnH7568/JcXh4jW+GIYRLBnGpvGY8U3GRH8uL28F4dQ91TyoAg==
X-Received: by 2002:a5d:59ae:0:b0:390:f5e3:e833 with SMTP id
 ffacd0b85a97d-39132d379e9mr6153424f8f.23.1741542817979; 
 Sun, 09 Mar 2025 10:53:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01957csm12401591f8f.47.2025.03.09.10.53.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:53:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/38] target/avr: Move has_work() from CPUClass to SysemuCPUOps
Date: Sun,  9 Mar 2025 18:51:48 +0100
Message-ID: <20250309175207.43828-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-7-philmd@linaro.org>
---
 target/avr/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 2871d30540a..834c7082aa7 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -201,6 +201,7 @@ static void avr_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps avr_sysemu_ops = {
+    .has_work = avr_cpu_has_work,
     .get_phys_page_debug = avr_cpu_get_phys_page_debug,
 };
 
@@ -233,7 +234,6 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = avr_cpu_class_by_name;
 
-    cc->has_work = avr_cpu_has_work;
     cc->mmu_index = avr_cpu_mmu_index;
     cc->dump_state = avr_cpu_dump_state;
     cc->set_pc = avr_cpu_set_pc;
-- 
2.47.1


