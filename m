Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B89C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLz-000199-VA; Thu, 01 May 2025 17:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLg-0000su-JV
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:40 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLd-0001X1-Kz
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:40 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2255003f4c6so16095775ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134496; x=1746739296; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8QQZQVqZoC308ckvLV+kB4d6m4SiPb0nD+im6xT08U=;
 b=bBR5pTaPklAFTSeqhvwxmhJqXETNUx99e1KxccQYM4O3pkHCWEqKozCvallLddv7S2
 YAsQ75PhmObD4p5FPu46bSjzQZkKxnXb5Hp92vE8Uc57FMdr9W6oX3ZdvxhaBKqUuReU
 ldopkDeQBbxcBz0kKHYgzuQilgONkNRyXlgkxe6wMyFpA9MYI4u5Sl/pBVg4Fd3DADXx
 zjmUS1G/ea0DZw+27KfUFjnMqpYdW6WF8oF8nQl5Cf10Z2tbMrQC+8e4cN8ygsReJ557
 9vkOv8Yw7/KqMoKWmrIsIU6q3JahtbicaW8qNsyBwOq4aYgNRJj/ki6/af12mc2DM1F6
 QFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134496; x=1746739296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8QQZQVqZoC308ckvLV+kB4d6m4SiPb0nD+im6xT08U=;
 b=if55K+0F3LMIFZaDZRXc/jzvHIR4ECU5AE9XFzdhbtpzbN7N09iiXhjIS9CxmuElur
 ypyF0X54CixbKC/W85l9CEmPJBppE7y7zzMcUO4mt51ez64WAsrd8q0DSybIGgVCdszy
 B/Isa1HGenHtEtKx0qqMkGaofhAoL148dQaAf5UaRpLqzTm+X/wJYJvZpGoAlSV5fVBZ
 LiG1qU5VtDL0x2M0o6p4NWB9g0Gl7khDlKDzWlulsvCPFB4Jw3WIc7EZBwbO8lEz7GHz
 ACo8mP7QuZni4bIZuqzLUmKGiuoTsyt5Tpxy0Bo+YwirFfGsF4fgTb239Fq6hFzXFmIe
 3nEw==
X-Gm-Message-State: AOJu0YwIe62bIH4QhNKZFRosHBHFuACZWWHKrD8Ob2bekWHqg5yZlUGi
 qvjmWkT7ud2eKrGr7W84J9bQtZPeuKnHvuDPJFpDlwDY81+cJpmOypuARVbRxvqAyxVnLNjPpLM
 +
X-Gm-Gg: ASbGncvB1trOhyMEZJtL7NdKN6x7rnKbgUEwxQhAlakfD88FKixHqUV+0fFMgGLn40y
 ysANgQQVuGRFmoOR74VH+j4l5Nv7LRLBLahTChay4fGVgifKeNFAWq1WzdZceH/EGxDSUf1AZDP
 4m8XMwtuKh3uqis8WtotiwmH8dIxLJfAkI6l0IMtaC7yKOm9gFKFFTcNKxRKZCWzJZErGu3kcrJ
 tVYnR5ggsSUE9PCt8VDCMr7F+0HMnBC5x8qSO8hJ23+QTrbrNfpD5MlD+7a72aWZwJtmnXKHX7b
 oDrG2VxACJDe+r6AtUQr+2+NC9JLCdYz0pyhIakXIi0y61hNNX3kICVz1a2lUMGyyyVl8rc8Cro
 =
X-Google-Smtp-Source: AGHT+IE2Je6TOyUj1Ps8jcs+GxwZNZ3gBJNCU78c+en3/Qz8ff7rx7Piw7Wn+yKEc7trkRfeixJdDw==
X-Received: by 2002:a17:902:f682:b0:216:410d:4c53 with SMTP id
 d9443c01a7336-22e1036be29mr7415225ad.41.1746134496052; 
 Thu, 01 May 2025 14:21:36 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 25/59] accel/tcg: Unconditionally use CPU_DUMP_CCOP in
 log_cpu_exec
Date: Thu,  1 May 2025 14:20:39 -0700
Message-ID: <20250501212113.2961531-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

This flag is only tested by target/i386, so including this
makes no functional change.  This is similar to other places
like cpu-target.c which use CPU_DUMP_CCOP unconditionally.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8ff4a34509..ff979a2c57 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -285,14 +285,11 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
         if (qemu_loglevel_mask(CPU_LOG_TB_CPU)) {
             FILE *logfile = qemu_log_trylock();
             if (logfile) {
-                int flags = 0;
+                int flags = CPU_DUMP_CCOP;
 
                 if (qemu_loglevel_mask(CPU_LOG_TB_FPU)) {
                     flags |= CPU_DUMP_FPU;
                 }
-#if defined(TARGET_I386)
-                flags |= CPU_DUMP_CCOP;
-#endif
                 if (qemu_loglevel_mask(CPU_LOG_TB_VPU)) {
                     flags |= CPU_DUMP_VPU;
                 }
-- 
2.43.0


