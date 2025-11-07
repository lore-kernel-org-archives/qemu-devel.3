Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F209CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 15:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHNyQ-0000Oi-BS; Fri, 07 Nov 2025 10:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHNyL-0000Mh-Ng
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:01:54 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vHNyJ-0003eF-Jh
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 10:01:53 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47114a40161so8895215e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 07:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762527709; x=1763132509; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JsPXanOwycMd+Uo8/scp5eUByokzkxKqyckKoyuUOUU=;
 b=YHAwaf0/0YbqIjJeasScvztE3mKxn6/uRFKxFvuI3HMSzGer7A7/gkfa6VZIMivaKL
 W1ShoQu/8yPhOAGsEbWODD3JPDhzn/CnaW9zG0ugtPIzl4Ivy4mG0BpsCA/w85Mp6A3W
 sLjGC6jnE+BszBSCbfOkVCnlp8ovsBYfhTJS8OTc78rG/lGn/4TykhVfjuGlMxbKt+tq
 145vKhYyGZgQFGivJgeSqOTsPlCBqnLOdVFzNFroe5DTL+h/h1jtcAkVsYKHWoiUHq6h
 iHS9wuL5m+06JpOKInByCQtU8toePsYxv3p8HypTdYjcZrPQ07iqbJeUehCMheRi0Vbs
 XCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762527709; x=1763132509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsPXanOwycMd+Uo8/scp5eUByokzkxKqyckKoyuUOUU=;
 b=vwWSSpbVHwT668R6yStMB3Qdv/zSduc7SEZoN+Ry76uCTZHpeXDEdcMcnpJ8pc6wns
 kOab7az8W4p2EyfPDgoEsYZqETH6o035TmXQftM2mPL7wcnhtV+TEuUDg/j6AebnXV1x
 StaMb+Hh3/h8qVZKSTfodF1lEfw4PjHGodcvHFiFhqoJj6bDIvQUxWh9DjeXLkBAkLeX
 YGT/Rr9PwNvSYg4vwTRN93Ss8YCnLhLcg6RMZliol8UW1Ktfi03kQUGa5AWMvb8GHbCX
 J4CjLOO9aiueibxom8sf084oYs/t/i50TVV++yugUD8Uwc504eWfWAwlJidB/yaHITcA
 80kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1r9uqMoxBDDOMHwS5glMeA2P7UUZ3UCfpd0+jzpzqWDD5uqn8iK6+uIt+CKn+/a3VBEW04v9R2/k+@nongnu.org
X-Gm-Message-State: AOJu0Yy1gNr5SWxwcmYSg+AJeOfXWWONc7AdZBHhD5eBgkzIek+QMQaT
 Mmo5SXNpR1vbca046fzIHFOSkNLVf8Y/rPbnjViDnuC7Zj/q9BMNCIDVgDqOuXKdCnc=
X-Gm-Gg: ASbGncv/+hCwqIE0FBfDA2IFvSKXojCMb0Wt8QG0qAKPASE7XrhZtiZAsjSjqu5juYw
 BBsRtXyr+W1cgKVWyuTQ+GGo1hBDTg2sWhx7/ltks7h0d7dudutH+ea3emFJldOb8j098yQiRbb
 VRN8fCdIpQxSXbMC0v25vX3cJ+HIBux4Zf3c/gaOvmurMfm/tPxGpPNtXlXuJhNMECwme3Uaia0
 E+tjz9o6+4SvztIXvWstluva2dymyTFqT5xiVp/pQ52mEVSIShyFcwpht03o0H40lPhFgnNbV3c
 bpBmfdvQLguGJ2eQnpvXLUAlBaNaTm2vBBmGplR55domSOj/gRDgDgNTnT1BZLfBy7VeNX5libo
 yfAAirz4MSviWuaFyIdL26xJnG4x4UsAwiok6FwmnP0ju38ILV7y4cLdq3Gm0msj0cPS4ggP0vs
 5DeMcYHDxV3pq9rWKN
X-Google-Smtp-Source: AGHT+IF6WqeitVxy78B0zzlLzVCq7C354pTOimGANN5r9APaHnVC7D10CTJbWt6OyjZLq25qFTXWvA==
X-Received: by 2002:a05:600c:c4a3:b0:46e:436c:2191 with SMTP id
 5b1f17b1804b1-4776bcb9cbdmr27706775e9.25.1762527707959; 
 Fri, 07 Nov 2025 07:01:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac679607esm5794652f8f.43.2025.11.07.07.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:01:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>,
	Hao Wu <wuhaotsh@google.com>
Subject: [PATCH] hw/misc/npcm_clk: Don't divide by zero when calculating
 frequency
Date: Fri,  7 Nov 2025 15:01:37 +0000
Message-ID: <20251107150137.1353532-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

If the guest misprograms the PLL registers to request a zero
divisor, we currently fall over with a division by zero:

../../hw/misc/npcm_clk.c:221:14: runtime error: division by zero
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/misc/npcm_clk.c:221:14

Thread 1 "qemu-system-aar" received signal SIGFPE, Arithmetic exception.
0x00005555584d8f6d in npcm7xx_clk_update_pll (opaque=0x7fffed159a20) at ../../hw/misc/npcm_clk.c:221
221             freq /= PLLCON_INDV(con) * PLLCON_OTDV1(con) * PLLCON_OTDV2(con);

Avoid this by treating this invalid setting like a stopped clock
(setting freq to 0).

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/549
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/npcm_clk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/misc/npcm_clk.c b/hw/misc/npcm_clk.c
index c48d40b4468..e202a8a2998 100644
--- a/hw/misc/npcm_clk.c
+++ b/hw/misc/npcm_clk.c
@@ -212,13 +212,14 @@ static void npcm7xx_clk_update_pll(void *opaque)
 {
     NPCM7xxClockPLLState *s = opaque;
     uint32_t con = s->clk->regs[s->reg];
-    uint64_t freq;
+    uint64_t freq, freq_div;
 
     /* The PLL is grounded if it is not locked yet. */
     if (con & PLLCON_LOKI) {
         freq = clock_get_hz(s->clock_in);
         freq *= PLLCON_FBDV(con);
-        freq /= PLLCON_INDV(con) * PLLCON_OTDV1(con) * PLLCON_OTDV2(con);
+        freq_div = PLLCON_INDV(con) * PLLCON_OTDV1(con) * PLLCON_OTDV2(con);
+        freq = freq_div ? freq / freq_div : 0;
     } else {
         freq = 0;
     }
-- 
2.43.0


