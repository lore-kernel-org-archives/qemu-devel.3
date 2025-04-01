Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEC2C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWiV-0000LJ-Vu; Tue, 01 Apr 2025 04:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiK-0007pN-7I
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiI-00061Y-7v
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso2932191f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495072; x=1744099872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kZ68jkJKHUSlJFLDdqHLGwkdWKmmPizBUNUJXgNfK9Y=;
 b=zv1Vj+XykgklsoOmicx5186iHwv8FTd9B1wSzELVScHUPY7xELA0Jj44F2BCvFnQk0
 Llavjw40npZzGgsSTaWmbbqn4mZ2IR2ZhXsp17Zge/0Y4Kwiw10vLYN6vKbJkQ4yozBe
 Pgsk5JOCihVfLPRqloJ/ZZdLUPuMfRQyFAzI4lKkR66EZyoI8Aev7O7g2/CFIikEnsh7
 FWQYw2HpaNOBVxpzuqzrPoGXUKF9G4jfJXQkPmQKcBfQtAl6Skr9zuVV1T7bGIw2lLbO
 wb8Z2Gpa8lDJjOJ4QkYqyYu34AjXEFLRhK6/6CGVzl9zF1YN9lMpZhfOBo/TO2SWuD3I
 P0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495072; x=1744099872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZ68jkJKHUSlJFLDdqHLGwkdWKmmPizBUNUJXgNfK9Y=;
 b=HqEdnhtZrnA0RF2XdfLzdYvWw/HOeUEDcx0G911lrU6ssRShaV+cu5LZESxMy6G5rl
 pDnXPEMGMtisxBR3xn9i/1WC7o47ZPxy08adIZwgY18wtVA6uZMUasX30IoMF1itfm7Z
 GCmRpA1behh37CEW8LXUxusH+UZ8jP7yBhxPvR0tPZ23ntoY33NMbkrDVHGiDQwA/mvp
 gK/DAvcDk9PzG3F/nQoKOOxMmYWeFu8Lhb7UJZ6kXest6VqX0VKF6aMHbJlNKokqyaBt
 xrllBtrZKAq6ZlMrcS86HgUAr2YSZwSWggnzcvqFjxEI2KsTA4S0zMWOD6Phw86BWTfo
 kY5g==
X-Gm-Message-State: AOJu0YzeCnmJmCqDfgRuoibtT8nljhBLjeNQm2bWoMATBxjTdotfm6nR
 P1NjwvilJ0ON12pn61nMQ1vtXOCAZB6G3P5kr9gFkTOPbWTVpscltcwmZwYa+7R0U/CqW4QGqv/
 1
X-Gm-Gg: ASbGncsYuDopLbVW4JYjm3HFILrJ2Zr2FkZRqC7YinzSOfeoJzYPUHULXwUC0JpzGCV
 9EfQU2XR/4gBEOhYMqJ/taYk2UIojGbDdcnlMyE6gh8f64fIss/Q0ZYBQ6PqPxne7/LrYJkVWWY
 baEWfaoCqzfh6gbUNRE9wO32vyDiypDgBDNgFGpz/5FZVMSUfJZxSy8OQmr8xUTnbdIpcp6vYTj
 3anmyz9TGCGo7cGBKkqjEsfhFx5ArO79mNueWgx+wEpNnHoZIGfOUOljYUTN/t8eISTF5UCcs2f
 THst5FNiLpSs0wbu+aZ2LWHqzZpqkLlRfsoDtxychYIAVmPPd1GNjnV7KX66qQU2wLVlWJqOzsv
 6wowoJGHm3bozvgqSW0Q=
X-Google-Smtp-Source: AGHT+IEtPgU0orHpzb+TFo9tigZpDKIM50Fz+Jah7hrm0I/GivvaCYM0y4pQzYnbZ8h6obJgx+qgyw==
X-Received: by 2002:a05:6000:144e:b0:39a:d20b:5c25 with SMTP id
 ffacd0b85a97d-39c120e34ffmr8835414f8f.26.1743495072390; 
 Tue, 01 Apr 2025 01:11:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8314bbf1sm189148775e9.38.2025.04.01.01.11.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 19/24] target/sh4: Restrict SoftMMU mmu_index() to TCG
Date: Tue,  1 Apr 2025 10:09:32 +0200
Message-ID: <20250401080938.32278-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
---
 target/sh4/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index ce84bdf539a..df093988cb1 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -266,6 +266,7 @@ static const TCGCPUOps superh_tcg_ops = {
     .translate_code = sh4_translate_code,
     .synchronize_from_tb = superh_cpu_synchronize_from_tb,
     .restore_state_to_opc = superh_restore_state_to_opc,
+    .mmu_index = sh4_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = superh_cpu_tlb_fill,
@@ -291,7 +292,6 @@ static void superh_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
-    cc->mmu_index = sh4_cpu_mmu_index;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->get_pc = superh_cpu_get_pc;
-- 
2.47.1


