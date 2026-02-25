Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAD4FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvO9J-0004Md-5X; Wed, 25 Feb 2026 18:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8Z-0003Sh-1X
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:50 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvO8W-00036y-6y
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:17:45 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso3588505e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061462; x=1772666262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OP5Mv3Wzkuhv98as4xw1IeO2sLMsxkiyChA8fkXY4KE=;
 b=BpuKwIJEOgT2ohrBdWUEcEv4qxHsKEWowaw2gYn0utzoJvFmE+LcAw2VV7+m3f5gIx
 HjC4ZbEuwfdObFBNO+1mHZ7Y92+iRo3AQomLuXyYJNNOuZIzJFu4HUp9Ty/+D5MG+8Bb
 WQqh9FxTOFYmzLZwDHSGoazWroKrK/MGgIJZTu46jTomNUlsE4O0jY9u85Zwlh8ut297
 JiC3W/nit34g1TPliaxyTqUIzFWm8OmwhZsUiVpYT5kVCAwk3VgFc+ttPDLym99uWGZl
 TkGhIFOxf4ENyhczEY/5abg6EKSQNYHNKNgXlE8K/GifptWs40ZMuMCIZqXW76107HOq
 YJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061462; x=1772666262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OP5Mv3Wzkuhv98as4xw1IeO2sLMsxkiyChA8fkXY4KE=;
 b=Xs9OTfMV2w9QmdKmaIGU0Ia+YyjwXVLlKSN9G6sbgW6K/YyCm7fJ4XKCqZK38p8o/N
 lo/vUisX5ANALc4YjbpUFRWYytHYu7LM4lHNuoIM8gTEh2cGbzWdWWUGBarRG4YY1VcB
 pV1WGlBKl6txuy7P0pvFyRPbmjYBq4MTsvdC4wzhLLWivnwMyiqOFez9zlnnkk6WWGPq
 vs/BpZq+0xTTmJjr/QUdE3ppAMIdV4xZ/OGplX4JZ9bRuvdIt+lwFnCmVlq1RqVg/csH
 K+/MUst/M7Q9yoK6lC0YTPgTk33lKXCDptDZERJROZFlOPUq4hCjlJvaOxl53U6/WYA5
 zylg==
X-Gm-Message-State: AOJu0YzIgjBucGJj+cnximSwQ9SyMccsg+ufqB/i7yccUHBU4Iunvp1h
 1toaIM998caYKdhbJZZbOfAtIfm3mc+RBO4gZ3MH2qAwamhN2vtEqbF3V09NYHgtq9BGvXe22xB
 bT6ZpiWg=
X-Gm-Gg: ATEYQzz7IkIYmjmBQBPstYhtDz9FS+BcX4mRDyxL84/u9nwz8QoYwMejNgb8jyfBYET
 lsJ98ixDPrqzkgWOpOvWo/CehegoMyYyjADhgxDvI11xKv6TovPeOD5+kaHq9rVla5pm2KO+gHS
 YL/vziguJUVxZliw4bG/NU6Tgd18BUDI3URatwAQXPAzfJvZwL0wb0sMTlXmK8fxfB2DutQkNqu
 XXNFpp+7ZHvEUW6ybTpbJrZnsNlSd9IkDYkgmM8g5LbPlTj5fqesnE9bbQn7xtbm2C17cBCHjR3
 pMUNmEP/lkTEnmyCBpiHE3th7WPJ+zDu+uBkjxMEKrCqwUu+iap3WrMS4ZOQZy2z/c0SIv4ABbN
 QxdwnbrAWaJ0gBn9m02pkmEDtDy5IYjjdmNWK74EQH41jHkecOYKknlNwsEEqImEa7zTQaXivjw
 lozz3jPAM5cJgDwdpQdzIcQqZ0fUTH5QVpWKwMBz+ckWfxq/6WXcUJRmDB9WZGUoEZZyJpAr1I
X-Received: by 2002:a05:600c:820a:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-483c3dd7940mr1324325e9.17.1772061462369; 
 Wed, 25 Feb 2026 15:17:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70e6c9sm78277195e9.8.2026.02.25.15.17.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:17:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/70] target/riscv: Remove empty target_monitor_defs() symbol
Date: Thu, 26 Feb 2026 00:13:31 +0100
Message-ID: <20260225231411.96482-32-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
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

Prefer the stub target_monitor_defs() symbol introduced in commit
bf957284006 ("monitor: remove target-specific code from monitor.c").

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-24-philmd@linaro.org>
---
 target/riscv/monitor.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index ccb7eb44d02..a9d31114442 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -244,19 +244,6 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
     mem_info_svxx(mon, env);
 }
 
-/*
- * We have way too many potential CSRs and regs being added
- * regularly to register them in a static array.
- *
- * Declare an empty array instead, making get_monitor_def() use
- * the target_get_monitor_def() API directly.
- */
-const MonitorDef monitor_defs[] = { { } };
-const MonitorDef *target_monitor_defs(void)
-{
-    return monitor_defs;
-}
-
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
-- 
2.52.0


