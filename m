Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B421ED3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvS5-0001ei-U9; Tue, 26 Nov 2024 08:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvR9-0000Hr-GM
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:17:13 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFvR2-0003kN-S2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:16:59 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38248b810ffso4258656f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732627014; x=1733231814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHnU5YARdhLWfnC/0qXuXZ7xJ6VXbn/8tQex+fQr1RU=;
 b=FA/cOxfj+YfkntvepQ8IcexJjA5L/cA2+J1/cQVrK9y+T4jUSgyzWQEWOCUNzvZK16
 C2khvgTvsXJfkDU+gkuY5VNV3GsD5e87GpcagdPMRa5pYpw5AC6UmU7KZRKcvVl3JFWA
 IByWxfoX35/2M1wSPexX1+7wuB5XODyBqX5k7v3QFKS6XmKog9A7WaMBm2EIlfFbI3s+
 tE5H1MsXVFcBdMtOWQRlm0MYylowbY759xu89l6ICLBO+jxmOXVDPU3cdHAUyw2wqs+T
 P1E21fnXnLAxU5+ouiaclN6YgYg+Hn55K/85vuQP6dLskSPWRVcWXf8G/RwM+1kGr6mX
 EAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627014; x=1733231814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KHnU5YARdhLWfnC/0qXuXZ7xJ6VXbn/8tQex+fQr1RU=;
 b=Bzoley3HQL3ys7/DaNPCNLSt+Qxc1WAgBcsKJOTClssRz7bFGeeHN2jp+kQDGmqGdx
 WCSh23FsTVIWcLqXtUf6N47G+7y746vpcUA+ySMr/r5jpglJ3KHAafqf5sSGEaCzq7fl
 dBlD6wYVZ4Md5+wgn2F0NWoTxUoHF93878Sb4IE9ROotvp216DkQVTb0w1zQMrSwFY1q
 kIPunJj5JW6Z0JByylYqdkGAeSORL2exsZratiTQhBzBwahqUN7uYDHKegqaQydicYzJ
 BuVnoTPtWXmZTgGqtVXZB+sdpQvz9wXwgqeA5XYn+HETFFaeRjnb4odKESyzE0mOyzbz
 74Lw==
X-Gm-Message-State: AOJu0YzK0kUYedlnftfJyZbmZ1P1cjVu4hqn1881dBDeQSS4YIDU9+Sg
 X7oKH1L8B/xnFQqMZPZNTKrdOWQ2EZpKYaPD+8t0VOlF5P1PAsBzFy7Iiycz2YavTptEO6v6z7F
 Y
X-Gm-Gg: ASbGnct/+EUhGRAq9JE/GcoPmqFGpGPLp0onUae0CHNZy4TtyEtP789pZyaVazPjuOZ
 vD3Ae+zY9vksZ2TImYPyg6PyeBcWuk+0PwOp0SdLc8t9nfwWMwH5jKnqLOvcXT3y6GUj5uk0yKq
 ALFS7bUoLIF6rrCqdpQvKyy/hnBGTrXUjy67w63rPPtTXpyHYWNjBG5CXBzqept8lvgHOkIkBM/
 I/PjkXJRYrL80D1Dx9p5nAIEfUz/ibPHT8pfc4H11JOfgLHXz0ZZqbG7T2FEjXicOQspsHe
X-Google-Smtp-Source: AGHT+IEoIUAo6mK1MLNka4pOqD1gZUNOgI7Xxf8gMQmI0tfAqXx490OBQkrCvBO+mYV8VXUWYkifHQ==
X-Received: by 2002:a5d:6d03:0:b0:382:495b:7ed7 with SMTP id
 ffacd0b85a97d-38260bcb1e3mr16417879f8f.39.1732627013777; 
 Tue, 26 Nov 2024 05:16:53 -0800 (PST)
Received: from localhost.localdomain ([176.176.143.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a5dda11fsm15252735e9.1.2024.11.26.05.16.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Nov 2024 05:16:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 11/13] target/mips: Declare MXU registers as 32-bit
Date: Tue, 26 Nov 2024 14:15:43 +0100
Message-ID: <20241126131546.66145-12-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241126131546.66145-1-philmd@linaro.org>
References: <20241126131546.66145-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

MXU extension is only built for 32-bit targets,
so the MXU registers can be directly declared as
32-bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h               | 4 ++--
 target/mips/sysemu/machine.c    | 4 ++--
 target/mips/tcg/mxu_translate.c | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index f6877ece8b4..f80b05885b1 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -514,8 +514,8 @@ struct TCState {
     float_status msa_fp_status;
 
 #define NUMBER_OF_MXU_REGISTERS 16
-    target_ulong mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
-    target_ulong mxu_cr;
+    uint32_t mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
+    uint32_t mxu_cr;
 #define MXU_CR_LC       31
 #define MXU_CR_RC       30
 #define MXU_CR_BIAS     2
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 8af11fd896b..823a49e2ca1 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -98,8 +98,8 @@ static const VMStateField vmstate_tc_fields[] = {
     VMSTATE_INT32(CP0_Debug_tcstatus, TCState),
     VMSTATE_UINTTL(CP0_UserLocal, TCState),
     VMSTATE_INT32(msacsr, TCState),
-    VMSTATE_UINTTL_ARRAY(mxu_gpr, TCState, NUMBER_OF_MXU_REGISTERS - 1),
-    VMSTATE_UINTTL(mxu_cr, TCState),
+    VMSTATE_UINT32_ARRAY(mxu_gpr, TCState, NUMBER_OF_MXU_REGISTERS - 1),
+    VMSTATE_UINT32(mxu_cr, TCState),
     VMSTATE_END_OF_LIST()
 };
 
diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 20b8314b478..ee70ae96c32 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -606,8 +606,8 @@ enum {
 #define MXU_OPTN3_PTN7  7
 
 /* MXU registers */
-static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
-static TCGv mxu_CR;
+static TCGv_i32 mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
+static TCGv_i32 mxu_CR;
 
 static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
     "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
@@ -617,12 +617,12 @@ static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
 void mxu_translate_init(void)
 {
     for (unsigned i = 0; i < NUMBER_OF_MXU_REGISTERS - 1; i++) {
-        mxu_gpr[i] = tcg_global_mem_new(tcg_env,
+        mxu_gpr[i] = tcg_global_mem_new_i32(tcg_env,
                                         offsetof(CPUMIPSState, active_tc.mxu_gpr[i]),
                                         mxuregnames[i]);
     }
 
-    mxu_CR = tcg_global_mem_new(tcg_env,
+    mxu_CR = tcg_global_mem_new_i32(tcg_env,
                                 offsetof(CPUMIPSState, active_tc.mxu_cr),
                                 mxuregnames[NUMBER_OF_MXU_REGISTERS - 1]);
 }
-- 
2.45.2


