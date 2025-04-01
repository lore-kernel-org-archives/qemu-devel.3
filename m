Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93724C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzWib-0000vm-OS; Tue, 01 Apr 2025 04:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiY-0000g9-Cd
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzWiW-00062U-CE
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:11:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so41348095e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495086; x=1744099886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8ZPKPo3p91JZQi+uwfwY+X5hjgCllMtU8DHnaPsIEE=;
 b=EYIJtxl6JdayMhTpn8bmT2FwJtKYRdbm59PHnjb+4oM297L0sTLbqjn7ya9NxV+P6u
 i/jTIO9MRC0GaNwF+ZG7/XKYCebgDV7DD3Q2NqAbdBKfSbuA0vndGjZn626SE8B/6nNo
 uEZ2O7lKzut086ipB9PQPGJbJb3UMxRelqYlClmwPAZNkDZamvNNGVwi5RFz8f4mNRgu
 wgU/TNZrb8vVnPpj4/Zx8CXEAB/og34BQtV/tHc88xgjsq3I7xTbgxnN3vrpe3WVv4oR
 00K7pnYCQQm5wlGxQeHLYAFNGeXcAChhWMdEcZpnHMext4hoqWFgRMFB36xoYMkyN2X3
 nQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495086; x=1744099886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f8ZPKPo3p91JZQi+uwfwY+X5hjgCllMtU8DHnaPsIEE=;
 b=WbVjVIAbU6XhYth3vREtw0t+K583zCdKJhOH7ZQKJfAPk/oSPmKYqBb+YXDfDyvDhE
 THw595/+EXQV17/5VQsb9NiPkaOwrUQX0Gw6Oof2/zFFgNcU7LCtGg9cO0WcnPAtMoxJ
 VrN7D7yCc1uJFWy5cA/Vq5X/PkLgdhGSL0d/LeOf2ja0UMUKV/RCws3hJQv2176EdJZ7
 1yCWoBcMOwOLr82X8eAIs6V2hdpppcZ0GW8lj5F5zrqZ+JGuQOUfWGbxEWtmD11eYa4m
 +AZ6PHVgOLtljXPj4JtgLw2eFwDc/dZHYmKZrzvRSIbyf0UZDmqe1zt9v5g+4yF620Hu
 jcjw==
X-Gm-Message-State: AOJu0YwLAXyqca/C2ttQp/WYcHYsiIn7uMrwEiNfkTaFKX5xAaALTlbC
 ol6Khtcl/JOUI0WceVqNDdbKwDPX6ZyVFvNttIyyLz1eePtMFBsNYwejPKatERzKBCvZOTuUP7T
 C
X-Gm-Gg: ASbGncsbJNDdP8cc7YA5WmOQG1MCAKe5H0nQ4Pgw0H8LnkXz/RfdrxufrX+0ve/6uuZ
 JLiIE4DYHfoEC4mKZNqC4GZADTEQ+nkNrEk5R1ZibDLJ8C37pIoJtu79SgTm8jh+2CU0JkI8e98
 niaONFy+qYIzItXUGbWw9bawNmpSsI6wJWmfF+v4K66Rm8uCiuKJiv7LeRDuKCHj6jHWb/j3dvV
 v/ZavTQH7HtZRx+g/bp4l1iJi2+2yRFzbfvHHCVeHMr9iJjCG8c2PbH3eCkVkuQlwAiDqgHIupL
 0Blgp1uTWtbTFhqMHIKlqU3i/ykJ64AlkK2e9Z8lSYL9MEoSgADhFY5us+4aiXYkmVuuUz55TTO
 /ee20iC5IISPaSNTB6ac=
X-Google-Smtp-Source: AGHT+IEz2squpomIK2wWsUmL66wB/yJpmZLW6x+Z3bzyLPK3tLHvT5aU4SrPOHt8x49okf1s0y6CFA==
X-Received: by 2002:a05:6000:2281:b0:39c:2688:612b with SMTP id
 ffacd0b85a97d-39c2688622amr760881f8f.7.1743495086475; 
 Tue, 01 Apr 2025 01:11:26 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6588dbsm13230327f8f.2.2025.04.01.01.11.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:11:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 22/24] target/xtensa: Restrict SoftMMU mmu_index() to
 TCG
Date: Tue,  1 Apr 2025 10:09:35 +0200
Message-ID: <20250401080938.32278-23-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401080938.32278-1-philmd@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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
 target/xtensa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ec6a0a8b662..51f9ee9e89a 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -236,6 +236,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
+    .mmu_index = xtensa_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
@@ -262,7 +263,6 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
-- 
2.47.1


