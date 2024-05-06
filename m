Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C797C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xcW-0002SA-KR; Mon, 06 May 2024 08:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbz-0001KQ-AZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:31 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xbr-00020O-Mo
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:38:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so12608155e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999101; x=1715603901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xKUlJq4altC6gXgMzk8h7ZuMjWZxGoEWR8S+Y8f728=;
 b=uR1rA6Ba6NGMxIpkAdx2yWzANPGRl/9JGOYUIoccvpKV4eaEuoCszad4gxByHItzyh
 LWfXBoMmAlwD6ukzkzxGDnhN2paOp2o2AIndC/mSnNJaa4cZ11jrelZo2vjD0zKgoEie
 PQEjNSuGB42XChxly+3lTz6ocOZqM100FhLznMESKjoayF2JyTyBjciwAhpjMKz+ITVu
 UYIGpai87y7C7/u6tF5QztokE6KPn+VJ8b0Ft6jmVGpvMsyVVRbvKyihNTktZ/oyEYVe
 GRGQNNir8JGvRtAS2dY/x/oyWbhxkYiGiXHp3D5yRKiSyIA569shvtz/vID0bu/ESept
 h4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999101; x=1715603901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1xKUlJq4altC6gXgMzk8h7ZuMjWZxGoEWR8S+Y8f728=;
 b=I3VGreDmyDe4D96GL67DbW320nKr6su+MBddhohmRJDc7txbhZNAd1dANt3Vk9S3Nf
 s6zdYHC5UOobkOMRfb+rst5cCS7FXT61D8C7mDLrQRR0GOeXRFUSVlZdXVSs5eJyFQjd
 aGyNgjpqdRlPJKrYIG3PyPuC1mBEIUeTo9bhC3gekJEOT92ALtH3EPMUOEM5MDmicjsT
 ahNTB6wFuiq5E1p5FeMTKjhTqBEP7ouWe2F7vp+bXJrA/lsa3jqWmU4X+x+1q1+Gu0qa
 q/FeO+3U/GU+4Lbg2dhUfdFSLB1TgwCLDVblWofWynucsVw89n2ENtfJE2Ytdj8g6l3q
 EDWQ==
X-Gm-Message-State: AOJu0YzWOH58T2m93wRDd6xXNOwUp1LAEvtgfGPYAAr6BgpXYSvILcBa
 gBTKeDmSKgpNYwNExD+aDTNQrlXi++iwygZLGAhMJzhqG8vbkzRg7soNdTBKJ2arNaXWsZO2flS
 G
X-Google-Smtp-Source: AGHT+IELGqsBkmf75yiyELsUowxoTaPMzb/Vwq+fEs8tiwUvnuNKo/riL+WXxb44mOibW/urZnxXJQ==
X-Received: by 2002:adf:f6c6:0:b0:34d:963a:12cf with SMTP id
 y6-20020adff6c6000000b0034d963a12cfmr9146299wrp.50.1714999101595; 
 Mon, 06 May 2024 05:38:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.211.4]) by smtp.gmail.com with ESMTPSA id
 c4-20020a5d5284000000b0034b1a91be72sm10608400wrv.14.2024.05.06.05.38.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 May 2024 05:38:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/28] accel/tcg: Use cpu_loop_exit_requested() in
 cpu_loop_exec_tb()
Date: Mon,  6 May 2024 14:37:06 +0200
Message-ID: <20240506123728.65278-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Do not open-code cpu_loop_exit_requested().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428214915.10339-9-philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 225e5fbd3e..c18a7e2b85 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -900,8 +900,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
                                     vaddr pc, TranslationBlock **last_tb,
                                     int *tb_exit)
 {
-    int32_t insns_left;
-
     trace_exec_tb(tb, pc);
     tb = cpu_tb_exec(cpu, tb, tb_exit);
     if (*tb_exit != TB_EXIT_REQUESTED) {
@@ -910,8 +908,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     *last_tb = NULL;
-    insns_left = qatomic_read(&cpu->neg.icount_decr.u32);
-    if (insns_left < 0) {
+    if (cpu_loop_exit_requested(cpu)) {
         /* Something asked us to stop executing chained TBs; just
          * continue round the main loop. Whatever requested the exit
          * will also have set something else (eg exit_request or
@@ -928,7 +925,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     /* Ensure global icount has gone forward */
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
-    insns_left = MIN(0xffff, cpu->icount_budget);
+    int32_t insns_left = MIN(0xffff, cpu->icount_budget);
     cpu->neg.icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
 
-- 
2.41.0


