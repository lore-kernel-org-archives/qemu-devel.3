Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E749CFA441
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 20:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMB8R-0004oY-FM; Thu, 20 Nov 2025 15:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8P-0004nx-Lu
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMB8O-0001VR-5U
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 15:20:05 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477aa218f20so8667605e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763670002; x=1764274802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gX9jGmeu+KwJPxY0MI+9o8DmOfeDSzlJfBVH4f7ccoo=;
 b=x7gbxKhN+0D5AumKI5gqxYDszawSbEZ7B4LgwRAKJ7O0hSkyDQOYaDDfYExJpaSQ7t
 TB39BuhiGiH1s4qk9hjG0DOac6Wzcen08sFPabpTcd+q9ohWnzKTKiXBHX4GUclRD/oe
 mW08jKem66y3z3ofYWZpWH322z4dM+QoM1CbfDwS0wMY9gfZD8j8a4i1paRb0QGtUcrB
 Vj6U5XwUi/nvwvlegX4tz1DgjG4ZyhhhyxxqZM6msqzq8oIXx1OmA9WCBa5fl/8vCSA1
 KsGUMv3uGbqHv+6gwGCwYLj8ru9CirjhUTYZG35mBrMtB70ORDWFnrfCvt/MCRboMkYc
 BDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763670002; x=1764274802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gX9jGmeu+KwJPxY0MI+9o8DmOfeDSzlJfBVH4f7ccoo=;
 b=ADhOxJ/BN/oXvULmXCjtTWEQ3uYAxXSvAwJpQzsygz/1ylBZh38nBITMoC4CSDyD0g
 qpI/ahfgiiJ/JuUybU3UXxHenfgFTZ2eBdTipERiP7DMdn71HZxHuzOt1QqhCMlC4e1i
 LFpynYdMIurL/n5no8JnCU2Wu/zg9gqcgOR4PfVb1rSujoPQl4NeiTaAoNLRkwNyaivm
 Kbib7+z8fDrfuJyhZrWdgWtwdt4ITxrbMtbUb+DucXyfuNEYEX8V7tEvIQMISfO8EAcn
 4z7F7TwaDCZNFxSNP3c3YiKpy4u3LDnKCJ/myYSreE/XYsG/0HayEquIcfV7m5eopmk0
 rusA==
X-Gm-Message-State: AOJu0Ywhqu9vJmn+dz6n6PJaQqtvsgY5b9PMAy3d93bjgtXZnCg+bpfy
 Vk7CBE96ZK123Ng+110HKDbTOnWBSLYBjlbQdT9eYDvao785HuuLGXM7jcg/1dv1ov4OTs0FWpq
 SbiqOQ8hYRw==
X-Gm-Gg: ASbGncsMf1G8Qa2wFbXn02Mkmo/XwIQuAPbJIuNpWiwhkVph9xF66jUgIk4qHj8gVaL
 BVY6rLa1LONXHhvNHnVp7W2IL7VqNcexHTbhZzdXWVTo/bktgpHuOwC5xBpsFLXUg/5RkrsXJwq
 XnAeDb5/gRE/DzCfMJt8mmYzPNGZGGPEat11mNXVTi0e/ybfeHYtOyoP7+pqq3sGwmCDaVeNqx2
 u+D9ZVsfRMWdy5VrlT13t6m0eo691UbMWbyY2m+KXfuTyUu2QeyCQWp/srB5TwJg6aKXqjJKXnU
 zxuVZNNO8QYkKEdwnKHyao2FNOwK0ZPOfUWLQUACtDNKlVfPGv8E9Zhyc7PXC2szw0gm8Lm3lAu
 59ZyV0rqESH0nL5hza0FzP3g/291KB567R78Mcf7MnPwHGBVPGr0+AK+oe1mkqQzqXiY1DVvaK3
 H5GOvQKjw2t60uiKz0AI+M8iIgfZMZgIAFob0l66USgw6XtPXUJeUCU5KBJKe9
X-Google-Smtp-Source: AGHT+IEgRh2WzW9puMcn9L7Dayst+plw1+PoZJs39NQMANt5Cj3iX4RlK7Rl2iN304JfDaAfoyyIrw==
X-Received: by 2002:a05:600c:4443:b0:46d:a04:50c6 with SMTP id
 5b1f17b1804b1-477bf12126amr8079285e9.30.1763670001888; 
 Thu, 20 Nov 2025 12:20:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1e868bsm6943635e9.4.2025.11.20.12.20.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 12:20:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 v2 6/8] target/riscv: Use little-endian variant
 of cpu_ld{l, q}_code()
Date: Thu, 20 Nov 2025 21:19:17 +0100
Message-ID: <20251120201919.8460-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120201919.8460-1-philmd@linaro.org>
References: <20251120201919.8460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

RISC-V instructions are always stored in little-endian order
(see "Volume I: RISC-V Unprivileged ISA" document, chapter
'Instruction Encoding Spaces and Prefixes': "instruction fetch
in RISC-V is little-endian").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/translate.c  | 2 +-
 target/riscv/zce_helper.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd0..847481a9b41 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1182,7 +1182,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
     CPUState *cpu = ctx->cs;
     CPURISCVState *env = cpu_env(cpu);
 
-    return cpu_ldl_code(env, pc);
+    return cpu_ldl_le_code(env, pc);
 }
 
 #define SS_MMU_INDEX(ctx) (ctx->mem_idx | MMU_IDX_SS_WRITE)
diff --git a/target/riscv/zce_helper.c b/target/riscv/zce_helper.c
index 55221f5f375..992e2f964e0 100644
--- a/target/riscv/zce_helper.c
+++ b/target/riscv/zce_helper.c
@@ -44,10 +44,10 @@ target_ulong HELPER(cm_jalt)(CPURISCVState *env, uint32_t index)
 
     if (xlen == 32) {
         t0 = base + (index << 2);
-        target = cpu_ldl_code(env, t0);
+        target = cpu_ldl_le_code(env, t0);
     } else {
         t0 = base + (index << 3);
-        target = cpu_ldq_code(env, t0);
+        target = cpu_ldq_le_code(env, t0);
     }
 
     return target & ~0x1;
-- 
2.51.0


