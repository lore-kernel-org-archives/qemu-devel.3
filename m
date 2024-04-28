Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DADC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 21:51:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1CPm-0003JF-Ql; Sun, 28 Apr 2024 17:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPi-00035W-PB
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1CPh-0001LN-65
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 17:50:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41b79451145so20747665e9.3
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714341022; x=1714945822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aIL7R4VGtGNdBMyw/v1blPKio2LEB3YtucwdrTq80BM=;
 b=HQcjzlnYXIoeQuq/qWlDatlGX5cdNEA7nTjv9+xJx8Q+5d1BE0Q2ezZhNemUhvEBZB
 g90hJg7bzgWX63ifZ2QJ048FipQOPZ4gD0ntktjhgMMPEoB7hTSgMia/WbiXrCqEw+o6
 5jB8+FgFY0midSVQjVeZwSES/fMIwFCk4lwCvCI8gNxG1YhGM2LbbBpaKXSAWA+7SXHz
 OJVq13iHAx85tWr5m+xY36lHWB00VyjIpDeM0fwlW5KX505NKxLzopQEgis5bpAJHM47
 hm3iGtSI7p279nmdtuMW+VNwt17Km0h9bp95nqG58LsAotbNLmUAmVPC8spxMGejCqnT
 PdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714341022; x=1714945822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aIL7R4VGtGNdBMyw/v1blPKio2LEB3YtucwdrTq80BM=;
 b=qo+756e65GNIftMJFwb/ekUMc6Eojp7IW/QOflMwmg2LZ4RSa8uQ7jE3WsfwUwC2Yw
 4/PXogT5AVwdLmjDQ/N3LpyhKeB8JNvCEQo9YU7tmQuvlk6FLRAvp9JvLQyn3EMGtnet
 UJMGhl3HAnOa3r8u3Xqhf1lCUHX2ACq6mL1pc5nBY1WYtNJ6j1aPMIVhM6RVU46OWteu
 Bv42JsK5dAk+y0eq++6eND5Tkax5T+vYZe1VgKHKe1Yny9MZD+f8NMZHoK5TtG4R9P+N
 gIBr1ZLi175dcCKYBtHRKaJU2hS1DAaKNCiOE37vUr/O9nQy6uq3YrdiUIYgTDyTBABM
 BAeg==
X-Gm-Message-State: AOJu0YyeL66YBCZ78HU9azKwxE/MGJ6NCw1+vAtAuaLODAF3n4qZ5n7g
 a4tlSimtwV0w5CCpL19tHA/Jp3sQcI0AIXIvDz4J11mHaBv9VjTDRtsge0TcfGR/oDBvD9frw2r
 v
X-Google-Smtp-Source: AGHT+IGNCOKUPTl4spT9MqfQOA0uWFRPoXWXNHVRZvvlXOd2jhglB2/GC7Wm2eboqrdPeGxtu/oLWw==
X-Received: by 2002:a05:600c:1d90:b0:41b:e55c:8e14 with SMTP id
 p16-20020a05600c1d9000b0041be55c8e14mr3589908wms.14.1714341021962; 
 Sun, 28 Apr 2024 14:50:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.142.130])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004169836bf9asm42844248wmq.23.2024.04.28.14.50.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Apr 2024 14:50:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 11/12] accel/tcg: Reset TCG specific fields in
 tcg_cpu_reset_hold()
Date: Sun, 28 Apr 2024 23:49:14 +0200
Message-ID: <20240428214915.10339-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240428214915.10339-1-philmd@linaro.org>
References: <20240428214915.10339-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Rather than resetting TCG specific fields in the common
cpu_common_reset_hold(), do it in tcg_cpu_reset_hold().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240427155714.53669-14-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 3 +++
 hw/core/cpu-common.c      | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 2c7b0cc09e..be99105ac5 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -85,6 +85,9 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
     tcg_flush_jmp_cache(cpu);
 
     tlb_flush(cpu);
+
+    qatomic_set(&cpu->neg.icount_decr.u32, 0);
+    cpu->neg.can_do_io = true;
 }
 
 /* mask must never be zero, except for A20 change call */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index c4175cc4b9..9b3efba82f 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -127,8 +127,6 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
     cpu->halted = cpu->start_powered_off;
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
-    qatomic_set(&cpu->neg.icount_decr.u32, 0);
-    cpu->neg.can_do_io = true;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
     cpu->cflags_next_tb = -1;
-- 
2.41.0


