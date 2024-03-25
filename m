Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9477CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:34:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokSP-0003EG-FE; Mon, 25 Mar 2024 09:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokSN-00037Y-J5
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:43 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokSL-0007QQ-QT
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:43 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513da1c1f26so5469475e87.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373619; x=1711978419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECmMULAo7ez5jaBxa5Wjvt8SfPbxgHkevNpFi8ZZgIM=;
 b=LWZt6tpq8WlS3qrd9yC0vjOon2RtjlV/kpiGcYDPto/i2m2brHGJYw4bnoswlYEVTh
 i+nPU8Arb5RumI6cvT9qkkZSnjfgLPALq+b6mWQmC7LSTSkn95EkhBRNngOLNeG+xSBh
 VmGi1o7tj9Ncx1rfac3AdHc7yaNSjTD+mGPTk4eC2telqYrf/XITDa44N/5ksWn6/1g4
 tpQ1kUTGaunJyxoc5l+oBTXORBr27DqD/DFWIwTFZ76WLBhO1X6hGXG1H7qamxmJRo6x
 Uh4vhysIPFnv+UBsuJcZJp55Aioas82JoP1Def3hnMlnNjmB1vBlmYxAGwG//6HL/LLw
 v7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373619; x=1711978419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECmMULAo7ez5jaBxa5Wjvt8SfPbxgHkevNpFi8ZZgIM=;
 b=vif7BbbHss7hu6uCPp2ZMK7mseSWCul8xs9oWaNMlJP2xF6aME8hm8K3yoE7bAYTh1
 54sgtavMvfP26dnjpEfCFaoZKc6gV9CqEjcwV5ku4iAtFWcY9fDeQVGbYAmeSLaWBaos
 P1V3he4+SYUYZj05Op9IvFgVfkFdbPD1n+77+anbswywXkiWg98p6pEs0+P8yPf/eQxi
 g3q47UxRfPOujug1CIRfx/efgvsqx7xzuueD8yS5y4B0AeMOAl//rBNMj0opLaTKj6yY
 N/VdDeYLgJtDQPzGQerM3SdRM1alTwG3nitdv7F1OcGrgQ451DBBBvysnEi6laslh90+
 d+NQ==
X-Gm-Message-State: AOJu0YxzN6U/qqGkH1/3TzZgdtYpIpeLjcVHkUVP4My6ugSN6fVneAsz
 FxoyhEHcMBjID1W6B4gKWuxEfjyo5yu9f21nCakWSS4RPjefgNfR4A+uH0BKeTKfDGR9i4w2LIE
 UeIE=
X-Google-Smtp-Source: AGHT+IH6CHH2Ug5XOiOcGGqC8V40tsHZUYTmdpaG/s0RshLAk2eF6vsXi826Go/fuPXbyA/5ziDcoQ==
X-Received: by 2002:a05:6512:55c:b0:513:184a:ff5f with SMTP id
 h28-20020a056512055c00b00513184aff5fmr5010410lfl.50.1711373619372; 
 Mon, 25 Mar 2024 06:33:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 en7-20020a056000420700b0034174875850sm8133536wrb.70.2024.03.25.06.33.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 06:33:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 6/8] hw/misc/stm32l4x5_rcc: Inline clock_update()
 in clock_mux_update()
Date: Mon, 25 Mar 2024 14:32:56 +0100
Message-ID: <20240325133259.57235-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325133259.57235-1-philmd@linaro.org>
References: <20240325133259.57235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Trivial inlining in preliminary patch to make the next
one easier to review.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index f01113308a..8852b434db 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -48,6 +48,8 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
     uint64_t src_freq;
     Clock *current_source = mux->srcs[mux->src];
     uint32_t freq_multiplier = 0;
+    bool clk_changed = false;
+
     /*
      * To avoid rounding errors, we use the clock period instead of the
      * frequency.
@@ -60,7 +62,10 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
     }
 
     clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier, NULL);
-    clock_update(mux->out, clock_get(current_source));
+    clock_set(mux->out, clock_get(current_source), &clk_changed);
+    if (clk_changed) {
+        clock_propagate(mux->out);
+    }
 
     src_freq = clock_get_hz(current_source);
     /* TODO: can we simply detect if the config changed so that we reduce log spam ? */
-- 
2.41.0


