Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8348BC41513
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 22:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Cnt-0005zT-7A; Sun, 28 Apr 2024 18:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cnr-0005wN-Gm
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Cnp-0005WY-SB
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 18:15:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-572229f196cso3881194a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714342520; x=1714947320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8v4uzifmPKK2kwYtF4RlyiCCqgElOLg1I89Ov9YYN+0=;
 b=C2cmvPTuRfq81zmyBIQduUjo+HBntyMzxFZsmZGgd1qrfKayaLxLsJiG1H1WzO3twq
 QDpPewKItEjMzok8lKjhnuIt3o7yyCv5aYtSgDF2EC6WZ4+nS1ULIpLcSt32+uzwWZq3
 jyR5vvfv+jie8Wwzghenws4FrZvQtmkPafxQFVPKOccwqUkEaH1FS6kdE5Nkg8tjYLi1
 yPO2s9WW8dDDBN4VnLxITxL4zhOKhU+/39x4bzkpCZ7PyozgY50mcuhI6I/iCHGhb41g
 qneyNpVXRAH7bSHblwdBfStI16f3OGGUOEP7mdK1dYYf7FPzmOR98Y17tBCh0bs452eR
 lN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714342520; x=1714947320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8v4uzifmPKK2kwYtF4RlyiCCqgElOLg1I89Ov9YYN+0=;
 b=UdXJQ/g8Xxjo7NOVNKF6lnMpUPQ0BPW9jo6LB9Br8AMrOtLnpSy4p6eW6MphEonc56
 0K6gwX6VhhRFLCpQ7bQQqPLeb2WbSP6nONaJl0G1a6DYHSj/7SqDWlZuyGgtB0lWi6TL
 SOaBFspPFaFrQGzZurUOZiWCWLGeOtEkNnp0f4doyMbvzXI/fOUhe0fjOpGesmmsQQP1
 PvYbhsT2nBhqckmXyeHIfB/iISSc7OYqJqxyP396JeCNU38cOWMmGfjNrRF3+N5d/s6B
 0UwBBTFQz3NiHienAeRJ086d9qbHOpX4wNxSLERSxh1Gas6RNU/OWHNxBMtcIFVpp0G6
 UyuQ==
X-Gm-Message-State: AOJu0Yws1rDAaVZLcx8P1vCbc+v69GgznIQWYSS9bxRHWsBG/PXMboGR
 dIlwKgxa8e0bcCXjG1xzF8sdHOTOIfU2f4J6pPMQmEj9N5dAebBScrZjc0jj8m0SNN/+RwoTepy
 A
X-Google-Smtp-Source: AGHT+IH7wyuEY8vgm9so5UxiG2GqL6VIKzDQlxV0Jk6TST/x0CA6wJhC+A1XiNsoP0BJM3IPJ/Rwtw==
X-Received: by 2002:a50:f68f:0:b0:571:be31:500b with SMTP id
 d15-20020a50f68f000000b00571be31500bmr5553084edn.25.1714342520316; 
 Sun, 28 Apr 2024 15:15:20 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 fg4-20020a056402548400b005727e798b5bsm759122edb.63.2024.04.28.15.15.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 15:15:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/24] accel/tcg: Extract tcg_cpu_exit() from cpu_exit()
Date: Mon, 29 Apr 2024 00:14:31 +0200
Message-ID: <20240428221450.26460-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428221450.26460-1-philmd@linaro.org>
References: <20240428221450.26460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Extract tcg_cpu_exit() from the user cpu_exit() implementation.
In few commits we will re-use it in the system one (via a
per-accel handler).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-common.h | 2 ++
 accel/tcg/translate-all.c   | 7 +++++++
 accel/tcg/user-exec.c       | 4 +---
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index ead53cb8a5..df317e7496 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -24,4 +24,6 @@ static inline bool cpu_in_serial_context(CPUState *cs)
     return !tcg_cflags_has(cs, CF_PARALLEL) || cpu_in_exclusive_context(cs);
 }
 
+void tcg_cpu_exit(CPUState *cpu);
+
 #endif
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index fdf6d8ac19..b67adce20e 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -663,3 +663,10 @@ void tcg_flush_jmp_cache(CPUState *cpu)
         qatomic_set(&jc->array[i].tb, NULL);
     }
 }
+
+void tcg_cpu_exit(CPUState *cpu)
+{
+    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
+    smp_wmb();
+    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+}
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 404d8a145c..d7e5f00c97 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -49,9 +49,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
 void cpu_exit(CPUState *cpu)
 {
     qatomic_set(&cpu->exit_request, 1);
-    /* Ensure cpu_exec will see the exit request after TCG has exited.  */
-    smp_wmb();
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    tcg_cpu_exit(cpu);
 }
 
 /*
-- 
2.41.0


