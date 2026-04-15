Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E38F433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 21:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8E5-0002kp-24; Wed, 15 Apr 2026 17:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8Dw-0002bC-Rc
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:40 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8Du-0002sm-Ju
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:40 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfd832155so5059383f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 14:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776290197; x=1776894997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuIqjkDFYw/UkV0TZBDvRk6uXE3wlZHhGyuhp0aPUMA=;
 b=RBKDgv7ximPB2GInQa14ECT1DEJGv4A/AdgyP+RbMjl8kGjtMnOc5X1JkqwqoQnmc6
 +KomiWK1hPZ2CfXcxesobPv0clIQ1niG0i8cXGcPg2FhSZw9z9/1oeRzTQkNmVA/akW9
 x8jvlEQEJYXX+V050irB8IiMOUEjQvxyQKLBwahmcTyKC7HKZI9mvDYPK2sgm98LPtz9
 znWuMexzUxjTzqL1W266+8PzjcBdn52vfOlU2kHH/O9Ao29LAIu42p9CS/rTcQZlNKT6
 8JNz/b/tr5op9VB5E6yOGcxe0rI22BtU+hlDAHpZtpA4GeJyhcCfXmzB45rAhcaWDSYA
 ni1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290197; x=1776894997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vuIqjkDFYw/UkV0TZBDvRk6uXE3wlZHhGyuhp0aPUMA=;
 b=N267g47wUdFpMVOfBFeNN1VFvKr8MNwl0oFnEHFrtUNM7T9dXzijaLzXDmMUBzecs5
 BzUyOQkkHYe3pFPRgKarF1gruBvxJELvf4+5HobRs5/IeUvUPbCepOe/3N9UBI25Wxsn
 cz4hutZHhFzjkq4R0+h++xAoWRjRBbbKiDuxcRuiK46zocCDU6sbS/O+AhKOPRdtunXU
 aTkj47HM11rylwVhuu2RUiSTAuV+jHMwJ/DpT1jeEXfjJARHNyczM0KxIAD9qSHhTmxW
 8jm77fMCAnjpzVf8x0FPBVvChKFsDuTFQ89F3mG2c5OjhLkEtpdWJn/YOtqokPDJm0CZ
 Vi/Q==
X-Gm-Message-State: AOJu0YyLmj7oyjUUl+kryNAXs7ULL24j8NlSlkNeYbM2WNHRBFDbh279
 fLhTbMBc7nb8t9dTi50hSuGlXQWrBS+FtBxf+2O5V4EUYOpvWmXyJOYO6WaVw4TAB81Yc/lXXBY
 DH/8yQ9c=
X-Gm-Gg: AeBDiesk/if4hqemWtTBFT5twtWI8x+0DKM//cf0OGF+p7+oVllvRWA/ZtMbiMQhbtv
 OHcTBa2mO3R4cMDqGe0QiIW1glZz1P5MDQ+wVY7D3tNg3eXSDXRxjJBdnPddkpZr7vxSEjf0CuO
 B/4loDuamKEnDJzoWkhUaq9paLNWxAEpL/vthhaR2grAhly+BEyMLUGZUjht2t6lR61jkEObUpy
 +dhl5K/sj7rcbtr+niYeZE5+dMWWrHzvDqbH9l6xGDkTzS+LrCI8m9EkFQDtry7kZOat2uwwiEE
 +MP7MQB6aAQos3DiJikiKZy3cIl6/Tn+RY4QkWzmnLO3PkQDq0aYweuyrlFtGp2ZDWCz7+/BX7p
 zP/fb/1cweO//bFFbifo1YFk7skpS9XHVM2J/xVneAuVaeBAWIA2nLDvPkd0xdrIdnZRx2u0WLG
 5fOq5weiJY9OB1Fwj3+0yJoHuJmxqdihyokAv4aNO3xz7jYki0GyIoyzMH3hZtSABFOv/CLcJo
X-Received: by 2002:a5d:5f92:0:b0:43b:60f7:2283 with SMTP id
 ffacd0b85a97d-43d64289753mr35084545f8f.22.1776290196656; 
 Wed, 15 Apr 2026 14:56:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43ead3dfff3sm7480881f8f.26.2026.04.15.14.56.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 14:56:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 8/8] target/riscv: Iterate vCPUs using CPU_FOREACH() macro
Date: Wed, 15 Apr 2026 23:55:39 +0200
Message-ID: <20260415215539.92629-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415215539.92629-1-philmd@linaro.org>
References: <20260415215539.92629-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Most code iterates over vCPUs using the CPU_FOREACH()
macro. Prefer cpu_env(cpu) over &cpu->env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/boot.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index e5490beda00..61e21678cd1 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -490,10 +490,11 @@ void riscv_setup_direct_kernel(hwaddr kernel_addr, hwaddr fdt_addr)
 {
     CPUState *cs;
 
-    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
-        RISCVCPU *riscv_cpu = RISCV_CPU(cs);
-        riscv_cpu->env.kernel_addr = kernel_addr;
-        riscv_cpu->env.fdt_addr = fdt_addr;
+    CPU_FOREACH(cs) {
+        CPURISCVState *env = cpu_env(cs);
+
+        env->kernel_addr = kernel_addr;
+        env->fdt_addr = fdt_addr;
     }
 }
 
-- 
2.53.0


