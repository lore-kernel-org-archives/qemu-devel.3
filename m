Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12B3D6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGzI-0004pE-Ki; Wed, 27 Nov 2024 07:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGzE-0004kK-Bi
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:40 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGGz9-0008Qg-9f
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:17:40 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38232cebb0cso5056382f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 04:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732709853; x=1733314653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovAf/aTwQanZ1kaeaRGXJq0cBfq7fMpiWo8HJEdNw9k=;
 b=Sig+/wagaILiRJzycMgR6DtH0UL/joDCaryq3xNdU9QhXlRlAyODOe4lkeIdCy890u
 2a7qSWLoC8vnaHxJtNdA5CsIWGgLqZcSswJepU6dXMngAZy/b1B1hBpZ8EjReDlcL5ti
 C0zIjHrJgS6WzmGHzsBRB+tfH8BjBLLJFEqX8bJHlmN9ISBPyXkgT7Q8pIwkY1xzFVe/
 ZoA+XLa8BLDsjZHbYwvQE59fg68OArB9l+ySYJgaokfSFcue9Ba1eVZ7qAT8ch4UDgk3
 J5+2N+n4l1SMlfLUn8g3TiVc8aWTgIIiXbbOgqyqskU7W4BTsimE1Zg84U0yNo1Z0jGz
 /xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732709853; x=1733314653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ovAf/aTwQanZ1kaeaRGXJq0cBfq7fMpiWo8HJEdNw9k=;
 b=SjTtDF2pVqNhVcdBzdZy1pT8GzSbR6DJIYA2S1FjkAtizv7TnUv35hCyhzQeaEDQl0
 r0Stz4+L19sA3hwu7sNURkhbJRaKUKSTKVl9iLJ5L8i2PjkYH8RiBAGbHEcpIiRQwSiz
 YKfLb2s0d+UGnLh3X+t5cCmaoX4RBBjcxazxHE2xN+ad7h+fmtWP5yC2Qt2ZyIfD3Y7n
 uLYXAYxxGQ8QPXNZnySoHmHzjF5UfuoCotlh92YphUooVGwGptrCW2gErVen4B+PhADQ
 rXeieX1V/jeHAdoojwrDT6w20635NOEO+Ef7hIF66Fdb4+Cc1y/wFMoLs0u1suFPQ5Iv
 qH2g==
X-Gm-Message-State: AOJu0Yz4rqR/abE5ui+msnqaJXWv485tubSS58v/WygfYoKgBa+5QYDP
 qlRrE6yFn6OeDZw3Z3iNSav1ECaxIaxtOt3A1QIZDJesP6IUjqupywVOxCc4snhXVFnmy3zB1Mg
 X
X-Gm-Gg: ASbGnct3SSqlXV0uL5ulT8TiLCGYps5rw005SyI170rDLbxHKCTDmuDZEQfLWZf1vz8
 LrPnllDCunc9AQMRBLzU05uI92/X/9dQ1hrrOoNSZ/yRap6n+ZbTV/FliLg5OeiYZMBnju8QwbQ
 khuRtNN7Ks/1MyYW3KhbdohnCNmTZvyrJALNWP74ah4Z1rFz0WMh9oioTZWDdFTFGKtycB9inSp
 Y0W3xSaBYHP8OelI/X8MC3IEWDdknMckE/ctfsHLTBcYqwJ6ujgXD4tBwEvYsIemkRxb2Y9eaju
 rvhZYcdZg4MSskcwaULVLrbFQJeOtJPMjg99f4RSgl4=
X-Google-Smtp-Source: AGHT+IHOJHvX5ELxrj8ghxXxVQtSf5N6T7rzcyPR2TLVAKchEbTgMNhWBsNNnGV5czQYy1r0WU6vMA==
X-Received: by 2002:a05:6000:144c:b0:37c:d4f8:3f2e with SMTP id
 ffacd0b85a97d-385c6ee0f54mr2231083f8f.55.1732709852760; 
 Wed, 27 Nov 2024 04:17:32 -0800 (PST)
Received: from localhost.localdomain
 (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr. [176.184.14.96])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fad6270sm16075120f8f.14.2024.11.27.04.17.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 04:17:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 6/6] accel/tcg: Allow tcg_exec_realizefn() initialize
 multiple frontends
Date: Wed, 27 Nov 2024 13:16:58 +0100
Message-ID: <20241127121658.88966-7-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127121658.88966-1-philmd@linaro.org>
References: <20241127121658.88966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Rather than initializing the first random target architecture
and ignore the following ones when a global boolean is set,
use a bitmask allowing different frontend targets to be
initialized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ab77740c954..b37995f7d0c 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1070,16 +1070,17 @@ int cpu_exec(CPUState *cpu)
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
+    static unsigned initialized_targets;
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 
-    if (!tcg_target_initialized) {
+    if (!(initialized_targets & tcg_ops->arch_id)) {
         /* Check mandatory TCGCPUOps handlers */
 #ifndef CONFIG_USER_ONLY
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
 #endif /* !CONFIG_USER_ONLY */
         tcg_ops->initialize_once();
-        tcg_target_initialized = true;
+        initialized_targets |= tcg_ops->arch_id;
     }
 
     cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
-- 
2.45.2


