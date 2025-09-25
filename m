Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1BECAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 01:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ajP-000607-NW; Wed, 24 Sep 2025 21:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ajM-0005zh-MH
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:25:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ajH-0004Gf-Fb
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 21:25:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so2294205e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 18:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758763496; x=1759368296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Aie0OLuSIdIpvYDmqaElLgHPkoh6x4WkPhhpalKHHj0=;
 b=NE6TsshZMjTUdlKblUKRJ7ps9QEVZBtJHIH+aNw8BZ+4jmMh+OXWblCHECWFe7Lk3c
 UeClCG8sThRWqjwh3rvfSDGjeNd8sRljixTjLrx+Vu+MDH5MQqgGyDml5+9Pil+eULMI
 gQgGddlgcRL0ZNMIFJLcCnAWG4hYwGR1cYrXcMiHGn0QWUyxfAH48TDFXSfX/avEv7z4
 h+MwW5h+Oww5YHhQR5qfRc4qULzwnkzO7kBFb0nu/gpm98o2ieQj/W0Asx20F5dUgN7/
 7v6iLiKRU282e/xEmzxnOnT6/09ckaZnLx8Jy8ofz21s1ou53rMTE9BoNcP1V1rVK/MA
 6tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758763496; x=1759368296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aie0OLuSIdIpvYDmqaElLgHPkoh6x4WkPhhpalKHHj0=;
 b=WqJBwDckA24MJpFVqlZo0+/0J4x+Bs5xFX1+2h4Zyz6aATa0/VeCt41IewquUwggCY
 uNz20k9OfbqwjaXZPonk3OPBOYIjUhSNiCKTJlwKqeW/7JgQvg0tWqEuPXdHjwUYGhr5
 RFPz3lUkfFfuGfdCBv8/hmH/ljb4CuQLUiGKblpRpqfNps0MEkntERJN7/+goH1vS6qV
 ARqgQxBe7e27V7z3KUgzZsJPmIGtZ2V87aP88Q9IUTRW1HzCJl0byaiQUS/MZ08kC5D8
 N6fOx9m2l7S1Vf8GNI/9guqnTn7tdzfl/ZUJgo4Aug5PpRUp/YKrjAwq0GoXSd/vqhkb
 44ZQ==
X-Gm-Message-State: AOJu0Yy7kFJ+kVusTftHdp5E+9F2m0BahH2hogPusPvysZJo9SxSWHQN
 S5nkCI9skIUUnmxpCwv27eHuCvjG3noM922HphxOwOhWr5yV78OvvvktiZ7jqwiqGg/gIZZ6hm5
 nuNXStG+e8w==
X-Gm-Gg: ASbGncvPcZCcRrIZ+l/YJPS/nsZA7D2eHdKyz4/8hmND7NnggH1tj/B8WCFbENX72bu
 RhDOmjLRonfsy6Oop4T/D1ALkqfFP8X0VC5lW8AjlEpJ13Cc+zzo7XD6T1Aeg+8XaWulJyM47Z5
 tvLMDwN4HyHvG7GiGb/GjRc4t6HzXxgOySxqm67MqCoUt/mFIhkYKmIwIfrMfRxdmv558aR3rHc
 a0GnYiGilVuq0q7NTQmSPp9BDOeyEKTM/MoJRpF8WnS3abX6L1/ZcqlrjN41efo0Rrto50641fz
 rtb10n3LP3H3maSqLxAXcQNZamz45fcjhW0Sqrtf6n+GvmieORXTUGbF6egXZQDJ+ja1vJtGjrL
 Zv9hryNFfUvgs25oKUApNs8+5DuU0NzVfDkB8t4HSGqzTTBxs4JL8T8F4kuSgnZHNYKo+r6aN
X-Google-Smtp-Source: AGHT+IG5QVDUAsgPwnhVWd/oYNkbgWZ1vbJhMd064VY2WjIPjQk/ZEiAJkRSf0MWW++cEto4BP5YDA==
X-Received: by 2002:a05:600c:4d18:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-46e32a1c5b8mr9038825e9.37.1758763496060; 
 Wed, 24 Sep 2025 18:24:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33bede39sm10502075e9.18.2025.09.24.18.24.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 18:24:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/m68k: Remove pointless @cpu_halted TCGv
Date: Thu, 25 Sep 2025 03:24:54 +0200
Message-ID: <20250925012454.60602-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Avoid registering a TCGv to write the generic CPUState::halted
field. Access it directly via @env in both STOP / HALT opcodes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20250924171308.53036-1-philmd@linaro.org>
---
 target/m68k/translate.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0cee54f4900..eb1ba150745 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -44,8 +44,6 @@
 #undef DEFO32
 #undef DEFO64
 
-static TCGv_i32 cpu_halted;
-
 static char cpu_reg_names[2 * 8 * 3 + 5 * 4];
 static TCGv cpu_dregs[8];
 static TCGv cpu_aregs[8];
@@ -77,9 +75,6 @@ void m68k_tcg_init(void)
 #undef DEFO32
 #undef DEFO64
 
-    cpu_halted = tcg_global_mem_new_i32(tcg_env,
-                                        -offsetof(M68kCPU, env) +
-                                        offsetof(CPUState, halted), "HALTED");
     p = cpu_reg_names;
     for (i = 0; i < 8; i++) {
         sprintf(p, "D%d", i);
@@ -4506,7 +4501,8 @@ DISAS_INSN(halt)
         gen_exception(s, s->pc, EXCP_SEMIHOSTING);
         return;
     }
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tcg_gen_st_i32(tcg_constant_i32(1), tcg_env,
+                   offsetof(CPUState, halted) - offsetof(M68kCPU, env));
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
@@ -4522,7 +4518,8 @@ DISAS_INSN(stop)
     ext = read_im16(env, s);
 
     gen_set_sr_im(s, ext, 0);
-    tcg_gen_movi_i32(cpu_halted, 1);
+    tcg_gen_st_i32(tcg_constant_i32(1), tcg_env,
+                   offsetof(CPUState, halted) - offsetof(M68kCPU, env));
     gen_exception(s, s->pc, EXCP_HLT);
 }
 
-- 
2.51.0


