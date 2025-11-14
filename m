Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7B9CE8D47
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJvnt-0008Qs-MZ; Fri, 14 Nov 2025 10:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc4-0006Rd-OM
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:25 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc3-0003vb-5e
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47754e9cc7fso13140965e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133682; x=1763738482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BWBLmsAkkYwVdETk16l9aBsdSyWo1bpWuw0Uuv+XzqA=;
 b=wiXzqnTR58xF8PItyUVkpVb//+2c6XcDt/RqxoVOOARQnuOoBNCgjvph3zrzFMFr9J
 1vZK60uslOk2DXhB1N/bTATVOCyRWqW5jfUD4Cxq7RrolxSx+5FuyGtK0GzWHn71EZPW
 CZZcSCkfKUKHOZa5WRbbFyxwAUrqVhEHjVKm2P3uPBAgHvWDbqpiETxRIb8awncPsize
 w7ND1bLjOioGDx+NdHuWOGq/UIkEgTStRNIcR3tw1zeEkVKetz3ljo/6zrekdukf3KA6
 D57U2w8wWtaAVQrfERbYxrECvDqBZf7+Z7Z/M12DbfxyGv8+iWy8fAnMlDfi/XzKCdMX
 j7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133682; x=1763738482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BWBLmsAkkYwVdETk16l9aBsdSyWo1bpWuw0Uuv+XzqA=;
 b=Becp6h3YBCR041dwevs8AZuX4+ulGhSN//u7Hq0cd3J+sy1Bc55dGNWgDyDbBuCqTM
 pWsAqQsflV2rnDdOQpoyic+C2qgjddrCwCtncXwWQzSv6gbK4/4goRd3ozrdlVeN4XsF
 mJ3+V7cQgRLG1HQi1AbEJI4eyKLgsWOqtwjoRFhTRAMJeeidK+iI/vlo5geJAQA8cNgN
 4zRhbuiOgatxUsXb8+MsC7WBerbw6HAO7gkn/0KJFuZX/1p8iM/HuVm4gBOe4hoYmXEU
 j4gZ2EoSaS/N/9FzBui/SgH2e7jnW320NbxKTArIyHAduAkNeIuCAydJC7RNBjrtwpkh
 EZOA==
X-Gm-Message-State: AOJu0YxqQ42ZuILtBCi+fSBqdzncxyoyTfnnHb6GC6AfVOKAYy+uch72
 qy0O6YboA5zazDVBJesCdeCRDAlE1MuTf7BmiNEtu+MVaC78Rz/E4KS706U3/Kvf3NZBQIhdAxM
 yew1w
X-Gm-Gg: ASbGncs/I4Ulp/LX73Go+ty9WUs332WWnaFXdFzG9cF7P15U/bayYQA60uEhLpjsfDJ
 PT9Xca32y62ekPuGRHiiQx/CBplqiyX4bKV96nXYzfjFEmellKK4QaBZkqPySErhF2awBKXLQU/
 H6fu3fRTkuyz0ffi7UYwTKWoMBxBDN2aJlD5XWgjd+FAIrMKhR78t00yqZ3xpqGWrde/Z9NDD/M
 Dz8nTwfGuB+F60olDKFXZnxx8n+fzpopgL6L9AFNMGrANRNTrFSComG+dn/z+aKZM7fnMU9BYU6
 y5lCfVP7neU/RwfKzfa31GW+5ByB3Jj/Bn3UMO759wCJ7Q5dzUyF/8aJcTGBz+w5PFLavUT2AuC
 bYbQScgXtvJSCr0BfX81OnGc/OHEKW+oPwPiyOqR+1PuRg8AGy1uNLurO/UspuxcZh9Q6GYp1jz
 w/JBx4T17X2qGaZmAq
X-Google-Smtp-Source: AGHT+IGbayNZbFMyj7Ja54BJBiZ5C9/fAxu+KUIEbzW/RwnqguBXdW7d4oN/oW6z6ZTk2erT6o1MDw==
X-Received: by 2002:a05:600c:45d5:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-4778fe59054mr32720115e9.14.1763133681665; 
 Fri, 14 Nov 2025 07:21:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] hw/misc/npcm_clk: Don't divide by zero when calculating
 frequency
Date: Fri, 14 Nov 2025 15:21:09 +0000
Message-ID: <20251114152110.2547285-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251107150137.1353532-1-peter.maydell@linaro.org
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


