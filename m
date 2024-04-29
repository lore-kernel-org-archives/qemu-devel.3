Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41832C19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ybf-0008QI-C5; Mon, 29 Apr 2024 17:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbR-000801-Gy
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:32:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbP-0003Qk-3e
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:32:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41bab13ca80so23217915e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426316; x=1715031116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfSxeazt7Q51HYWou2L26AE+iHM/oq4pGi/blYA/P4Y=;
 b=ICfY/fMgQzNBivJPUrXqqN5v25t0E0Nj7BgaJGGS7k9F/FZOc27jcF9nVbW/WphESH
 IEsArkkSSJuXteHG/bC23DU280ILCOMocLxNLrOCs7H1zWtFKIIw+Yc2nVQrHlmloOxK
 HorkdvPsfRt47ic6zUt2C9XCAO4r30kQ2YHKTpXwSBuwkYudwbtMNolpa6EfaPAe4UzW
 PmM2uPacIutAvXtO0nA9fReWnq3UVInoqT2IBgcba4J/o48sqVlJpwneIYtjtzFLUqF/
 OZiuNrwWVSIBIZf/BX6YIfSWyXXCVX5KH+2gMzn6cd++Ir58Efnytq/OS0brdZAscWNI
 T/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426316; x=1715031116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfSxeazt7Q51HYWou2L26AE+iHM/oq4pGi/blYA/P4Y=;
 b=QXX+iGgo+hoYIU5knbQIDBuVGn2cktugwxA+q37ZGpYTg2f5yIsQo2Gd48JE/FBTzs
 C1yiaIm7r3o8Mrw+K1HwMBAM+PWk+rtArrcP1WLKkdqyiL9YSqcQsnKIXCmTZ4Az79l0
 7HiiLrWWUf0FKphdgR7qdWD08z2MBW3eagfoZQIaBtvVZcsVTQZpdVYALA0IT/aul+PV
 jPvSyY2u5cZrpKzRhDwNIjGp+yZ69dxkN2WmmkdfdMdJex4+9zvmGpOFfNsy5jnUxasy
 5sI1theVhnMVpf4JQ8GeBUrRq5soGOOQZx/BgJNCN16Q3Jax1qyQ8bfrnkMvyzph/XQi
 Q+lg==
X-Gm-Message-State: AOJu0YyjHulAQWcGVk1wvTbPcyIFR415Ns4wpWpleWrBFOtdj4Vkkdet
 89vsVbAhKRpH3v308KjU800kklM9PXMOY4pOEvnz50c626D6LI6C6rOz6NBACSH+D6CsbkFYXjf
 RMps=
X-Google-Smtp-Source: AGHT+IE8iSh08CH90dVsvjuLVxjDAp5bMaQPzt39SOvA08+w543WKyWb09aubBDK4W0uM1zhUxh2NQ==
X-Received: by 2002:a05:600c:4ecb:b0:418:b9fa:43e9 with SMTP id
 g11-20020a05600c4ecb00b00418b9fa43e9mr10427431wmq.29.1714426316239; 
 Mon, 29 Apr 2024 14:31:56 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 e7-20020a5d65c7000000b00349eb6eae3esm30745100wrw.4.2024.04.29.14.31.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 12/13] accel/tcg: Restrict icount to system emulation
Date: Mon, 29 Apr 2024 23:30:49 +0200
Message-ID: <20240429213050.55177-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

So far we don't support icount on user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-24-philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 84fd041aec..1f618f6c2e 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -780,6 +780,9 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
 
 static inline bool icount_exit_request(CPUState *cpu)
 {
+#if defined(CONFIG_USER_ONLY)
+    return false;
+#else
     if (!icount_enabled()) {
         return false;
     }
@@ -787,6 +790,7 @@ static inline bool icount_exit_request(CPUState *cpu)
         return false;
     }
     return cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0;
+#endif
 }
 
 static inline bool cpu_handle_interrupt(CPUState *cpu,
@@ -801,12 +805,14 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         return false;
     }
 
+#if !defined(CONFIG_USER_ONLY)
     /* Clear the interrupt flag now since we're processing
      * cpu->interrupt_request and cpu->exit_request.
      * Ensure zeroing happens before reading cpu->exit_request or
      * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
+#endif /* !CONFIG_USER_ONLY */
 
     if (unlikely(qatomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
-- 
2.41.0


