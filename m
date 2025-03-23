Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859BCC36005
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGY-0005r5-JQ; Sun, 23 Mar 2025 13:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGV-0005oL-2c
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:39 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGS-0002tA-DG
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:38 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22409077c06so60879885ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751454; x=1743356254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V9RNNm4TR2xsqepmbMUFAdeBIjBUZTQEvJCdv4fdD0o=;
 b=xhJ0pfPCGl+9yLLrA3VHzomnYTbiH3FyaWEzpRvA2LlI/gpOtM1hGsgSkTCFalheDg
 BF5019696gD88h0qQsbO1JwI9eWMvRdL7yrmoh00AHMUtY8c59Nvca5NnlTUdpGtEZs4
 FkiVZkVBX1ZAv/yuIp9VjxP2l/ITYfLOb0imZvF+V/0Ed3jSeltSvvuIhug5PbamoSAU
 JQrkYWG2nLMQREU0DbNgID78GaLNMM3wuh1AwpxjQutEgIV67cp/ur2/34iAt856FtT1
 t6lvLHyU5YHQkfEtqWpB9V60FMvBmI143Z9ejOAOsjSt3K50cylzN83IxlioekqchiO2
 CSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751454; x=1743356254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V9RNNm4TR2xsqepmbMUFAdeBIjBUZTQEvJCdv4fdD0o=;
 b=Nx4po2QjXhgF5OLyNswPbDt1xzlfcxFKfIMQ51hTYn4cB0RsUJcYz/KBZpFnqeBVQM
 lo2Kit9b/YNgKrhBzeIhvbNCDp4sC0xot189HqiqvaF9sf44RmpCgkJfElRgOx+7xwYe
 /5DhVsuo8RKcC3CJ2xoKIhVMiwDX7JEZ4sVzaUL2MTW+5eVHommeZ6n7uSTRVL7D2q4A
 02wMyieeeyBhhG+kZ1GwuLYrmJiLRTeeQ4dMPvvB2JXxMbYnaQUsGS/WycmiXNDrvYtj
 caYhq0Jt0lzxFe02qmNgNCRCQct9oVcKmllbiB9ozjRz4marER/yFFvUt0UGvokAwUlV
 x2/Q==
X-Gm-Message-State: AOJu0YwT+DozsKhFy6d3Q9nQBKv+NystaA+1E11UE1RxQOaolac5L+A2
 U3yyozKVUNljt8P4kH96qwPBx4HBxtvodXEyzeRw/193NZLCmfBR+kY63KjT3ZH43N8kkyeHnTo
 +
X-Gm-Gg: ASbGncvBF7hOsansr4zTcfrPKBjiMAHokA5rglVtojAiNRJwy31AyWPrOsOvHtBDBwZ
 7iz7DCWaPsW/9CbFb7/OGSIqUzoFuISvhKCafujpE3OSXjDeZ8PVmI9UnHbxF/56eFEVU550KDL
 s8I/8Ej73UJn5xSElDt8+Y7BETV7Z09wLE80DnrGQiRNJqXMvCuaJGWKd++U76Ij/MU7stzXVL4
 WKdgyU7mfgmPyUUODRvYbog+SOYUQm1d2ZNW9BTso+YKAdM0aWPfkEJJppk0eL9/4RmLXN0EXLz
 K4rSc+KgooMMMgDfwF5nOzSBJsNrlbFWYUOqAxpux8ARe0ljHl5AyzvOKE3YE28GvQeTtD0/P4u
 X
X-Google-Smtp-Source: AGHT+IHJwbawvtkRl9Vepfl4qgUR1ZVgOf+GDookb4VyjnUSRMyvAtK2V99s8r0BYOikNwCoiOz+2w==
X-Received: by 2002:a17:902:ea07:b0:224:179a:3b8f with SMTP id
 d9443c01a7336-22780d83b53mr135194645ad.23.1742751454304; 
 Sun, 23 Mar 2025 10:37:34 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 04/17] target/avr: Remove OFFSET_CPU_REGISTERS
Date: Sun, 23 Mar 2025 10:37:16 -0700
Message-ID: <20250323173730.3213964-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

This define isn't really used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/cpu.h    | 2 --
 target/avr/helper.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 06f5ae4d1b..84a8f5cc8c 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -60,8 +60,6 @@
 #define OFFSET_CODE 0x00000000
 /* CPU registers, IO registers, and SRAM */
 #define OFFSET_DATA 0x00800000
-/* CPU registers specifically, these are mapped at the start of data */
-#define OFFSET_CPU_REGISTERS OFFSET_DATA
 /*
  * IO registers, including status register, stack pointer, and memory
  * mapped peripherals, mapped just after CPU registers
diff --git a/target/avr/helper.c b/target/avr/helper.c
index 3412312ad5..e5bf16c6b7 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -340,8 +340,7 @@ void helper_fullwr(CPUAVRState *env, uint32_t data, uint32_t addr)
     env->fullacc = false;
 
     /* Following logic assumes this: */
-    assert(OFFSET_CPU_REGISTERS == OFFSET_DATA);
-    assert(OFFSET_IO_REGISTERS == OFFSET_CPU_REGISTERS +
+    assert(OFFSET_IO_REGISTERS == OFFSET_DATA +
                                   NUMBER_OF_CPU_REGISTERS);
 
     if (addr < NUMBER_OF_CPU_REGISTERS) {
-- 
2.43.0


