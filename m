Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 312D9CD11BF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbeC-00006K-5H; Tue, 19 Mar 2024 11:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdu-0007lK-Eb
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:47 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmbdo-0005LV-J7
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:44:46 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33fd8a2a407so1679310f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710863079; x=1711467879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBdrzyRnzam5C+4e/1m5S+T9al1+qhyfeKtl+AUinsY=;
 b=MKm7VdDHdGihdu4rM1Dq0+9DySDgqkW6/LnWgzQkCC3WbyrfNrkWjIChETeZlHh3jr
 1XCtMMB44C5CxFbHY2Y84zEMSNZPe6EezH5mslkjbEZ24t8+SF8LMasMbHSvOuoB2H+b
 AfKnlo4E+zeKATL/+owc+6i/F5dcx9/ZT10wau/p7JAByohpzS/VjXBN+Vsig0ndJjzo
 ny0creta1cmRk78ZP1cpF4pxEysm7mmSwKhYBA1BCD56cXAGHSdzrtjhRx/G64Mo38cg
 x+sgFME8wsKP1Aoia2WbDO7eh/VKKr1kXb48xUu2tGL/pXmQw8/ZBX1Fvo2BobI208I0
 3p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710863079; x=1711467879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBdrzyRnzam5C+4e/1m5S+T9al1+qhyfeKtl+AUinsY=;
 b=Kf/cKBBvVW8WOuU1PrEI64IIG1++RHeIWCMSlR0LWF+K420MRiww3BW8nBxwBzNm7t
 eMR7YVAyTG60pNHKEINi+JeU17aANLRnNQlGsey63++hyFLQtcxStph5ZcjKJscvpQDZ
 S6dpngaSzmH8guuMIUReHjxYCtM30vyY0IbN86aCy1k36+7kJCFYVlixuaYJNFknf4JR
 8E4jJP0YqfEeNLdG12ipMYCY1FCDK1raU9iZ59w+K+NzOLE3Z0I688x+GL/7JQJf2mAj
 2PHkVR7qcmtFUs/fnJJtBBWgdTiHN+cQSx7TYLSB1ND+/Vd4PsK4rGoiICaBVLpIYEuI
 C6Fw==
X-Gm-Message-State: AOJu0Yx47mGfVNS0QssPmgy8HuL8z1m4FpQsK/UvILfs5E2kvZstseWm
 UVgUwJXrqywVrEDo1TtlwTCkqcYzjbHAeVlqRg3GxWSRodxv0ZRQhIMcOg6YzZsMlVYKD7m5dpC
 f
X-Google-Smtp-Source: AGHT+IGHGqeP39Ra2YKnXUNQF8xSFS49G7XmPrSaqAxfHsk6uXyCi0s3MFUNZUcX2Sz+lVvGSvMuhw==
X-Received: by 2002:adf:f7c9:0:b0:33e:7719:325d with SMTP id
 a9-20020adff7c9000000b0033e7719325dmr13239459wrq.2.1710863079000; 
 Tue, 19 Mar 2024 08:44:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a5d4aca000000b0033e03d37685sm12668148wrs.55.2024.03.19.08.44.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 19 Mar 2024 08:44:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH-for-9.1 17/27] target/ppc: Indent ppc_tcg_ops[] with 4 spaces
Date: Tue, 19 Mar 2024 16:42:46 +0100
Message-ID: <20240319154258.71206-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319154258.71206-1-philmd@linaro.org>
References: <20240319154258.71206-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/ppc/cpu_init.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7e65f08147..464e91faa2 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7360,22 +7360,22 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
 #include "hw/core/tcg-cpu-ops.h"
 
 static const TCGCPUOps ppc_tcg_ops = {
-  .initialize = ppc_translate_init,
-  .restore_state_to_opc = ppc_restore_state_to_opc,
+    .initialize = ppc_translate_init,
+    .restore_state_to_opc = ppc_restore_state_to_opc,
 
 #ifdef CONFIG_USER_ONLY
-  .record_sigsegv = ppc_cpu_record_sigsegv,
+    .record_sigsegv = ppc_cpu_record_sigsegv,
 #else
-  .tlb_fill = ppc_cpu_tlb_fill,
-  .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
-  .do_interrupt = ppc_cpu_do_interrupt,
-  .cpu_exec_enter = ppc_cpu_exec_enter,
-  .cpu_exec_exit = ppc_cpu_exec_exit,
-  .do_unaligned_access = ppc_cpu_do_unaligned_access,
-  .do_transaction_failed = ppc_cpu_do_transaction_failed,
-  .debug_excp_handler = ppc_cpu_debug_excp_handler,
-  .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
-  .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
+    .tlb_fill = ppc_cpu_tlb_fill,
+    .cpu_exec_interrupt = ppc_cpu_exec_interrupt,
+    .do_interrupt = ppc_cpu_do_interrupt,
+    .cpu_exec_enter = ppc_cpu_exec_enter,
+    .cpu_exec_exit = ppc_cpu_exec_exit,
+    .do_unaligned_access = ppc_cpu_do_unaligned_access,
+    .do_transaction_failed = ppc_cpu_do_transaction_failed,
+    .debug_excp_handler = ppc_cpu_debug_excp_handler,
+    .debug_check_breakpoint = ppc_cpu_debug_check_breakpoint,
+    .debug_check_watchpoint = ppc_cpu_debug_check_watchpoint,
 #endif /* !CONFIG_USER_ONLY */
 };
 #endif /* CONFIG_TCG */
-- 
2.41.0


