Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15849D24456
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz14c-0002Dn-4H; Thu, 10 Oct 2024 17:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14a-00022V-AV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:52 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sz14X-0004m4-DV
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:51:52 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7e9f98f2147so864865a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728597108; x=1729201908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cUPr4DTqSfAaJIzrvGr1QFjVaKv5zKA6xtabhx9yB5c=;
 b=kh0ziPtasf8GJlOTTdJ3tYGNYHByKXVq8j81ahZHjDGRPVimI59gNSb3wIvfnZbUNz
 uF6yVayFs+WFGdQABvbJWxckA2g75J7BHl3RgfRaRE8Mpv73I0ELBpvCz4UZ055/J/69
 zXWy+XbXKzedzdCa4Bz241VW3KSQJG2+JMcFyvSpVYtX0HYeKjzCUODKZbC3/cx+zpwb
 qmzc+rSZ5ynMt2DNpG9eHkHxMNZodRz+DkaXk7SoCs6S+DUhOTX9fADPetILbxgzYbQg
 HyecC96m8QbUDxSXgdi56+v1nO5bDVG1NkUvLHPtL1RrYycQ5d+jJE+AYslnWy97I9gu
 P7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728597108; x=1729201908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cUPr4DTqSfAaJIzrvGr1QFjVaKv5zKA6xtabhx9yB5c=;
 b=ICazwv90JXmP0ssx/5tVwifZK3+P3yijBVnIENTzBvcT3Jg0H+lXFxT4ZC9Oesvr3r
 MxM6QzkYbCY2wkBvVfHFXLrQWPGA1gpys45nfLdi1z8l3Raxhtp5NSqVvv8Odd0LGSWf
 wlLpqTA09/tQ1hxB9CzhR0XHcHvTGJgD7jbXMK1jN6EJNZcOxkLWVE51AbNouDQX1m8w
 jJMYLWcrErvGEXdalANbr3Bl4khV3PncDMCyXUlpe1FrqJYfSsNFs20JTBfA6OrtoKHt
 E1vmdAnPYS8TBvqgORwzp2sS6bquDivp23N2387hDv8bgqdcuqtVqGibWWN1OUjWSkHq
 rV4A==
X-Gm-Message-State: AOJu0YwHIIw0B8IL49Vsb0kyAQ3DxLUlzLB2TXuD/UElezBlWZW5v0Xc
 JcbexEVOKyRwZq4tPFARhcWnUWvqXmvyGFnrggTg+j8/quwPhbf+JpacKxmj4+1fkFCDA8X348z
 C
X-Google-Smtp-Source: AGHT+IEEa2JNCAmG0q2TkQ3ImGPZCD2j1/SIbrzz7JXLpro9somwHFtSJSD5mJz0ACGCXecKf5Gv+g==
X-Received: by 2002:a05:6a21:3946:b0:1cf:3677:1c4a with SMTP id
 adf61e73a8af0-1d8bcf2bfa2mr679719637.16.1728597107776; 
 Thu, 10 Oct 2024 14:51:47 -0700 (PDT)
Received: from localhost.localdomain ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea4496b1afsm1430264a12.94.2024.10.10.14.51.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Oct 2024 14:51:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 11/16] target/mips: Have gen_addiupc() expand $pc during
 translation
Date: Thu, 10 Oct 2024 18:50:09 -0300
Message-ID: <20241010215015.44326-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241010215015.44326-1-philmd@linaro.org>
References: <20241010215015.44326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/translate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 4802a6a1d87..41f25c938de 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -11428,20 +11428,18 @@ static void gen_compute_compact_branch(DisasContext *ctx, uint32_t opc,
 void gen_addiupc(DisasContext *ctx, int rx, int imm,
                  int is_64_bit, int extended)
 {
-    TCGv t0;
+    target_ulong npc;
 
     if (extended && (ctx->hflags & MIPS_HFLAG_BMASK)) {
         gen_reserved_instruction(ctx);
         return;
     }
 
-    t0 = tcg_temp_new();
-
-    tcg_gen_movi_tl(t0, pc_relative_pc(ctx));
-    tcg_gen_addi_tl(cpu_gpr[rx], t0, imm);
+    npc = pc_relative_pc(ctx) + imm;
     if (!is_64_bit) {
-        tcg_gen_ext32s_tl(cpu_gpr[rx], cpu_gpr[rx]);
+        npc = (int32_t)npc;
     }
+    tcg_gen_movi_tl(cpu_gpr[rx], npc);
 }
 
 static void gen_cache_operation(DisasContext *ctx, uint32_t op, int base,
-- 
2.45.2


