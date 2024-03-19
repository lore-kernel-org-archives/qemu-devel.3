Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B2BC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 06:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmSya-0005Dx-QN; Tue, 19 Mar 2024 02:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyY-00059B-HL
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmSyW-0005e9-U0
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 02:29:30 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-414618e6820so5819905e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829766; x=1711434566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1MPot1rwOH2sHZ4KnXL6/xrTAyUEmTpRKdgwXMTPjQ=;
 b=owwEE06FNiM1zIBP72Rs2G0t0/gN4g4bRK+GvvWAg29woDcH9ua4qOphaS5MSdsSIR
 7NVr8JuTTX3OcH9CGZ/1kSCC2ZLbYjQZHfX4gCAKF2kRP+2thVlIQac/KS1KFvdiTxHj
 T/6Lodr+CUvICEtcDaQ1zUiT6fZNVnQsTK8D++3fUAg1s23CoMklEGChN1wO02fXsj4/
 XKyTS0x3h0gmFWoBm6xm/n04cz2HrU2F6MWtQgmgcZGzQnpcjbT0otRRLxKtTkI04soR
 ZNlOfIwQ5I6CHVKX8x2BQenvYfLA4Hz8k3oK6IGfdutunUeZpBYfoMSI8lXmixIaDUhW
 GI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829766; x=1711434566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1MPot1rwOH2sHZ4KnXL6/xrTAyUEmTpRKdgwXMTPjQ=;
 b=sO6HR+30Ln0h6q74QSYiPGE+GbnGzDFAhbZUhiMnoWd8tJ5KuFdJqIX6mHL8bW41J+
 5N/XhV1sYUFAtHrDGLp17lJt8en4vJFaoqh1t6jsL0mSmOGSFFaNkyjKl9Ka4SRcTzLe
 Q+XY0kbakOMUhuqyNvpsa+BFcpZGGpVEqI6zhXUpr5hKcEPZDsqpcZXWQfHny3AcmlXp
 qj2B0LHjkJ8+ZZZKGqBqUo4vQEQ1t/X4Ayn0hJc6IjaXpsz0c4uBRClm72qHh+RtIrN4
 DpqLcJzK/bS/7BFZGmTar+AEmH1NIBCLtpiqvxKKrhRlJRO8asGN6W4xQUeMq4p2esjS
 QpyQ==
X-Gm-Message-State: AOJu0Ywi07YiGDvodmwsPzY1q5WSqlDCshMHQr8MawEakEejmwDlnn9Q
 f5ADzF3ujxZLxOsoChiVdJIrAOseAtpKXhFYMdOxdW7KtRr/c0adZS7Jo3/JmSq/c1NrsJU9xZK
 e
X-Google-Smtp-Source: AGHT+IGyFHLXXW0HyzGyYV1/M1fhBfxn2ypbm2zCFU9F3y9AQOSSlXYYFkseD3Hg8quM0HV4dPJMAA==
X-Received: by 2002:a05:600c:4fc8:b0:414:6172:8366 with SMTP id
 o8-20020a05600c4fc800b0041461728366mr1300185wmq.15.1710829766185; 
 Mon, 18 Mar 2024 23:29:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c191100b00414659ba8c2sm650763wmq.37.2024.03.18.23.29.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 23:29:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 5/8] target/microblaze: Restrict 64-bit 'res_addr' to
 system emulation
Date: Tue, 19 Mar 2024 07:28:52 +0100
Message-ID: <20240319062855.8025-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240319062855.8025-1-philmd@linaro.org>
References: <20240319062855.8025-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

'res_addr' is only used in system emulation, where we have
TARGET_LONG_BITS = 64, so we can directly use the native
uint64_t type instead of target_ulong.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/cpu.h       | 10 +++++-----
 target/microblaze/cpu.c       |  2 ++
 target/microblaze/machine.c   |  2 +-
 target/microblaze/translate.c |  9 +++++++--
 4 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index c0c7574dbd..c3e2aba0ec 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -260,11 +260,6 @@ struct CPUArchState {
     /* Stack protectors. Yes, it's a hw feature.  */
     uint32_t slr, shr;
 
-    /* lwx/swx reserved address */
-#define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
-    target_ulong res_addr;
-    uint32_t res_val;
-
     /* Internal flags.  */
 #define IMM_FLAG        (1 << 0)
 #define BIMM_FLAG       (1 << 1)
@@ -286,6 +281,11 @@ struct CPUArchState {
     uint32_t iflags;
 
 #if !defined(CONFIG_USER_ONLY)
+    /* lwx/swx reserved address */
+#define RES_ADDR_NONE 0xffffffff /* Use 0xffffffff to indicate no reservation */
+    uint64_t res_addr;
+    uint32_t res_val;
+
     /* Unified MMU.  */
     MicroBlazeMMU mmu;
 #endif
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 96c2b71f7f..9e393cf217 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -193,7 +193,9 @@ static void mb_cpu_reset_hold(Object *obj)
     }
 
     memset(env, 0, offsetof(CPUMBState, end_reset_fields));
+#ifndef CONFIG_USER_ONLY
     env->res_addr = RES_ADDR_NONE;
+#endif
 
     /* Disable stack protector.  */
     env->shr = ~0;
diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index 51705e4f5c..4daf8a2471 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -78,7 +78,7 @@ static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT32(iflags, CPUMBState),
 
     VMSTATE_UINT32(res_val, CPUMBState),
-    VMSTATE_UINTTL(res_addr, CPUMBState),
+    VMSTATE_UINT64(res_addr, CPUMBState),
 
     VMSTATE_STRUCT(mmu, CPUMBState, 0, vmstate_mmu, MicroBlazeMMU),
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index d6a42381bb..493850c544 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1872,7 +1872,9 @@ void mb_tcg_init(void)
         SP(iflags),
         SP(bvalue),
         SP(btarget),
+#if !defined(CONFIG_USER_ONLY)
         SP(res_val),
+#endif
     };
 
 #undef R
@@ -1883,6 +1885,9 @@ void mb_tcg_init(void)
           tcg_global_mem_new_i32(tcg_env, i32s[i].ofs, i32s[i].name);
     }
 
-    cpu_res_addr =
-        tcg_global_mem_new(tcg_env, offsetof(CPUMBState, res_addr), "res_addr");
+#if !defined(CONFIG_USER_ONLY)
+    cpu_res_addr = tcg_global_mem_new_i64(tcg_env,
+                                          offsetof(CPUMBState, res_addr),
+                                          "res_addr");
+#endif
 }
-- 
2.41.0


