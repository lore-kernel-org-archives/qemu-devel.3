Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8F2C36005
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0Y-0002fD-Tf; Tue, 25 Mar 2025 18:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0G-0001TV-ER
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:12 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1txD0D-00072p-0e
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:44:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223a7065ff8so65114635ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942648; x=1743547448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whE4tOIG14eY8JQ2gptqlrplDWnqt4RDL3Ybv6G0d7s=;
 b=sG/NaOzEaWpk7opPUEF4B3xv9qoNkqSWagSfDVvQx8MhZnv8StkWtd0LTKxQvdVsiK
 yVdRWmB778QuFxhC9q87NNkK2/F/tOwAA/hrjiPQFiZW6bcSnWC2B+bNPEmHSmZUR4zk
 3qvF3W5HpDcxZhRqsucRhCdxmGTKnmwgMOK5Dpf8fhHH/xH9msyqdi2KG6/vH1SLefxN
 O/XATIwPpL42qfgL2Dv0r4N2Hh7GXt0W5SDb21BkgkEtqIY/9UcFVqNIhbD8o3qYXU3h
 gc3V4QN8t91Q130LDZL26kwSTogAPjPuhVHOYePOMXbQ+sWg4rWH233DP3pY9xFNd63e
 jFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942648; x=1743547448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whE4tOIG14eY8JQ2gptqlrplDWnqt4RDL3Ybv6G0d7s=;
 b=KVNcrM5RXcKnaPq1lOxrrzPuVK03wLaW7sTgaUO1ieC1UHVKQqeiXWjRwP7UxXRRxl
 ry0/1CdC2xz3yYj+2YOwvzx6Eapano/0bfgcRnS5wv9qELp4yuLVvJMtwFlPPTN5yRWT
 QGFI+HwLMYVaCZ/k/fs5cAeG6mpo8s16E2izvv2z80wC97qKlTQSsTPDcCMFa/lDN/C1
 Tzw+cbzfvCepsra09tqubfIwNPIxRIvR8fqU/XpgSqQWdf5B4eLGVHH39SG8GDZ+bRUo
 FFTgpqrkcGVokF9+9GVpsgDJK+Q9PUgKsH8R9DVneBywzYBLR/1bqQmhiQ9/RUeFOqSw
 X5tA==
X-Gm-Message-State: AOJu0YxZd8ECkN/ZGo9N2/1bR3hTUalGtvZ0eEvUvVHiuvqB1O80734Y
 fpVg/94ATxgPXsDiHwy5qPPiXpu5sr/wM9uCBBu/qh9lEPXgDMTVVsb1+RyU9W2Nzvte2AMPbev
 d
X-Gm-Gg: ASbGncvkc74AC47V2qJCUC+MxDwT5cnLd9J8IoY7WTzktW2BsVRmRnBqMqOhBn7yjzN
 JAvX/se4fRissPY1iD636+i3tYaPj6OrdojE1rhS6f1gAbEsxxL1F/udPgA9wCTcrMQRssY2UBx
 +Lto7R49Mk48FN9HchX+JXMBAddk++lmu9d4CBIaqS1Tu1kpnyazN0ZmhbPifQnWKvJ6NvQQ1+O
 1CNwYfJOVWAMPd9S0PbrEQfdQdoc8tmUvk3pBCDVenOGAv4wxrbMjitWyK/JE0Goc8e2W3DzRae
 JyRhYOys6D2r3sm7Gbnw8VhsXFaupH8n/8nPRbK/1uRehzc4Qv2RrwyLRiDhj7Y+48f9esITtIV
 F
X-Google-Smtp-Source: AGHT+IEXffIXkKaM32i1wEX+euvVjlaaKwE1ovgiZkhgtiVM2mWY7BsVax9OA5jpwqtcKGfJClW2gw==
X-Received: by 2002:a05:6a21:9990:b0:1f5:679a:226c with SMTP id
 adf61e73a8af0-1fe42f07b0dmr29169962637.5.1742942647740; 
 Tue, 25 Mar 2025 15:44:07 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d3d6sm11111321b3a.94.2025.03.25.15.44.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 15:44:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 04/11] target/avr: Remove OFFSET_CPU_REGISTERS
Date: Tue, 25 Mar 2025 15:43:56 -0700
Message-ID: <20250325224403.4011975-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325224403.4011975-1-richard.henderson@linaro.org>
References: <20250325224403.4011975-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


