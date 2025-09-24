Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B819CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 17:15:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1T3b-0004Yr-1c; Wed, 24 Sep 2025 13:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1T3Y-0004YP-Kw
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:13:28 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1T3O-00018I-GN
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 13:13:28 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso114996f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 10:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758733991; x=1759338791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6+6AtUZur1NPdjUlPWLWcuOZ/cGyT33WknrysXGizFw=;
 b=nUOaqxpV+a3ANfiLEQnPxi1kDyI/beZqrjENm+ke8NI6ydpq2qkZwSGshh/7gQIxN0
 5G0Zp43k958S0LVqlwoGEKzlOoYZpW0Ac4i1IDdzAM0+cCa6Izqpnlbm8pbT4jjxk/8d
 p3l2DkRNRiJy2c8ubwgzjxwE8FS77mp7Ujl97c2eJ0zzGoP4fxmx741fl3/iM4IVGQdo
 cdlHkICTTTKnfZnLFDHxfNgL3S8TtBsIXfjBKOVNIq7/j9cGwPNg2DKctIzGttRORoH7
 ZDPq0TGL+qzgMSKQkxS9/FnZO0RNbNAvoPfuoSYKfXojEbNafBB0Q6AInAYG4iqsuCtJ
 jpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758733991; x=1759338791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6+6AtUZur1NPdjUlPWLWcuOZ/cGyT33WknrysXGizFw=;
 b=vQg6Rc0u9y+MAVN6hGj1ciYUSX7Hs3RyaaF9frAeVfHUjlsS9BpZbLH4EiXTCYz4qF
 AWiPkODhC3MBAEF4PH0nb/qaY/ibwstzLh9xTPHAcC9BHJtxLH1gfvafkCePaJ45vN9g
 uFs40otHbcF7OccbYqjAZ10etMkyLlyB1R3E6TlsLx7Zts7s3Six2n9ong+zfqbqQAJH
 4rS6hiDzk47xMb/zHT+iMXQNXjuVl56hZ9KRsquGikHcrT5qaRzYBGzSXCIr2t+qf32L
 qmRyBMr97T2VDkSXTH/Ltms4zPzJzb4nbkQWv1kRvmgNZ76IpTlt+QghR9Hybvb61E1h
 0IxA==
X-Gm-Message-State: AOJu0Yzb4KZc/krGQL5WmqWTQCq8qVHFFruUw8nJ340etz44JeeD95T7
 9qraMZmTWeemGmgunxrc+yPvpFmjrgnvyFR+HcNyRaPaqCrYPP5+cCt461U0rck4JmKQeSXzj1O
 RyQw4a2Zgsg==
X-Gm-Gg: ASbGncvFFIYw7xjC3ltxo3dNEyGPWLoCzwMXzg+XD5pqMQQepfzq9qcwYGYDJvGdQd8
 5jdJbl70dhnkvew6wPpTN2BWTyyU5o9X9SOxL4HaOaZGIlsrY7FS7Oxig2PaNHZDqXHkbm0SD6B
 JOiyKsYcXEwz4IUw80DvmHC6kRJvE9H0WBt6m4Y3FvIRQE51gpdMsL+5bNg+sTcMpbKRkIcAEx+
 yANC/79Z7NNQcPW2pJS6RkTInVkLLQd3EQzx5+udFw2wV0Dqc6048AQNek7Ei/TpxWtRjbuNzNO
 l9JJEz2JccUSWc1Rw4jwgquNlsYzDxRwcaB6BF7qjsxHqU2M3NTnD8GaiKwMDuA26GBtqBFUyLq
 DbQhNxqmJJ7jV6z7KbWSgl6dHm0/GzLLMNkl3e39pwYZWbDT9rtcHAcvz0gf5Zj8oZjuY7ldE
X-Google-Smtp-Source: AGHT+IHJ8Dr1llVQN0xMcamzWkiwj61TfdGTIljDJyTDz97Hn3kPvYV985ZeBJMxAegAwf3uXdth5g==
X-Received: by 2002:a05:6000:26c9:b0:3eb:5e99:cbd3 with SMTP id
 ffacd0b85a97d-40e46514db2mr642531f8f.2.1758733991267; 
 Wed, 24 Sep 2025 10:13:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f88de2ced0sm17562455f8f.33.2025.09.24.10.13.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 10:13:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/m68k: Remove unused @cpu_exception_index TCGv
Date: Wed, 24 Sep 2025 19:13:08 +0200
Message-ID: <20250924171308.53036-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

When moving the @exception_index from each target ArchCPU
to the global CPUState in commit 27103424c40 ("cpu: Move
exception_index field from CPU_COMMON to CPUState"), the
@cpu_exception_index TCGv has been created for m68k target.

For years, no code ever used this register. Simply remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/translate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 97afceb1297..0cee54f4900 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -45,7 +45,6 @@
 #undef DEFO64
 
 static TCGv_i32 cpu_halted;
-static TCGv_i32 cpu_exception_index;
 
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
@@ -81,11 +80,6 @@ void m68k_tcg_init(void)
     cpu_halted = tcg_global_mem_new_i32(tcg_env,
                                         -offsetof(M68kCPU, env) +
                                         offsetof(CPUState, halted), "HALTED");
-    cpu_exception_index = tcg_global_mem_new_i32(tcg_env,
-                                                 -offsetof(M68kCPU, env) +
-                                                 offsetof(CPUState, exception_index),
-                                                 "EXCEPTION");
-
     p = cpu_reg_names;
     for (i = 0; i < 8; i++) {
         sprintf(p, "D%d", i);
-- 
2.51.0


