Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59375C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cpi-0002ze-4r; Sun, 28 Apr 2024 18:17:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpS-0001iB-Jk
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:03 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CpP-0005lb-P8
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:17:02 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso513924066b.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342617; x=1714947417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RHFpScpX3RBz3SndWvBFhPouPtIMynd6+ol800GYZ0=;
 b=PQosyhLwrUJQFw01doa4zBCubWS7sveYWpp4LU4PUcHrajtJrajymsHrWcGcafuTyL
 Q29c1MylxnA+H+4rY3THl7j3cKPLYKQH4qssxo7q35otlPZghoNNMyY3RV2knd7H1NJd
 1f2senut0CBmij0aWfYobLayFKLUJ52USWq0PtZsmC6cARxKWckzm2RhdsW0Ow9q3bWw
 o9mg98anh0DsXy/xd+jTB3XqA8u5GOfSuvNmCaSkGpF74wg7LDjcNf2qzuFyP9i50Jqd
 n3peO6jYEWTa9Guvo5Sxk4GM5Y/Wpg5lhoKabJ5G527sz5j1HRkwccUCX1qzdwCIv/5L
 FbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342617; x=1714947417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RHFpScpX3RBz3SndWvBFhPouPtIMynd6+ol800GYZ0=;
 b=kYRLSVUKHsS35e9odez6MsHHMrJj7ZDjmK9y23Jl3xnD/LmdxWqgNMC76riYkmT0xJ
 /IjDPEYMVfIR9U2LZftcuy7B4TuJbv2aOQNYfw1WFyHf9OjOSAehmsyv5Vs/ps6Mv0oc
 NsnV71cvOC096G8yr13k5MvxdrsFL6sJS1JAbn0T22vKyBdIWaKmTXPqb57JU2TzYUpx
 xsAHqCBCwFkxx5lfftNfKhFVmJdcCQtH67UW2qdg2uvoZCPuK1ridOvG6avaIuwWsY6L
 CFkHHq48GOy51MqnZRYyPA3j38cfZVSvuzRI6Loeo4k++cZHc+8TRNp83QreyUWnvx44
 wy2w==
X-Gm-Message-State: AOJu0Yz0V/szhKMiot3XzXoAOcCeYXxmZthDeupWpnfNmbOkLeYw8frk
 NuUjizWBG6rL6vPcR9tCgCN+N9geNQ6Mlvm7ujKj251CUTSk1D+wq63vYkb1T7lTs5kriC9z11X
 s
X-Google-Smtp-Source: AGHT+IHYO16h3itZP6zi2uze0HAJDei4v+HVQ9W1kzrCz0v4oqTJACpQpcJuGf6KbTSMMxLTXvbthw==
X-Received: by 2002:a17:906:2bcd:b0:a58:cd39:d154 with SMTP id
 n13-20020a1709062bcd00b00a58cd39d154mr4272888ejg.11.1714342617110; 
 Sun, 28 Apr 2024 15:16:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 p2-20020a170906614200b00a588e0e0d9bsm5903912ejl.93.2024.04.28.15.16.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:16:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 23/24] accel/tcg: Restrict icount to system emulation
Date: Mon, 29 Apr 2024 00:14:49 +0200
Message-ID: <20240428221450.26460-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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


