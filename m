Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2D9C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romFo-0002lp-NU; Mon, 25 Mar 2024 11:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFn-0002lD-6K
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1romFl-0000Fr-Pb
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:28:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-414859830f2so10021835e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711380527; x=1711985327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egg5Mtyn99cCwmy/P18xKwdXOjmaICInZ6LaE2Awphc=;
 b=QAoft+ZpjFuEqdkyjeyCnyG/tB7/55Q5ZnGyqVwppwa2xdKm+ZDMzSxhIXs8t0o4SB
 yUmzcikKumFABwufuHZO/6db4qZNk7pD3rPHt0BA2AVDn+rqTewJ7Fh0dj3AQC488KhB
 aapV0dojbhBoXFZ6n9Y5GvlwR6SflnOmSOa5IF7iTsn6yk8704K9QwjrS3fTEQKXl1nm
 xrn/cBfMV7JALe7RtABz+s8ewZbLHVKd/5Evpk7gp72vxa8B61kqZJodjDX6U1d8iIZV
 eWSicqIk+1DJxVtzkMw5PGlqbz0BrspjgsRfdxm2sK+TCKaU9CD0UdGrED3Oo3WZA3Ow
 00Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711380527; x=1711985327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=egg5Mtyn99cCwmy/P18xKwdXOjmaICInZ6LaE2Awphc=;
 b=tLwqkSfKBv5Jbfq0Z7Hhe3B/xcocxiQ/xDQe1vNE4Ke/Ze2z5cFEJPRk4SMvF0Xn/V
 inTg5HvFkazUGkRzt2qR/WtVu32jAgpihr1L3+Fj433tx3psON+8Yw8Kc1LfcHnw5iAt
 eLtOks39QZZetio/cTO9E/nrMdPGtNC2TYNah/Hx4McMW5E1nX/kzoRtiPuc+NzibPZx
 pB8hxWSkEqSMlvy+WbAqErOQLVEDJqpQo1eFulCfs+X5Rh7ub8x4oCSsxYnLNHhuA4Vg
 XgH+COiPvh0blZZ1vU+WB/pElRAJ6DqwVDNtP6LA9UtYkajLAQJqJBl2mkTxNbUSCN3/
 Fe8w==
X-Gm-Message-State: AOJu0YzuP5XtvSzh8i7WTWugGuBJXJkga7POOWvXZauXtQ8vTW0Po4R+
 ijV1Kxq2s8wKxxBEZkuN/AfDi5EkBqY7uZGmAtfjPhcAOjB2CphcT0I5GxULztD4Y43owIVcsFw
 ozi8=
X-Google-Smtp-Source: AGHT+IG71BRPXIOaH/SLJY22g2op8AV25bdPmej/JuI/NnWgTbSgHved3Vg5LXS0t6W/jJanYTzpaQ==
X-Received: by 2002:a05:600c:4f01:b0:414:8948:621c with SMTP id
 l1-20020a05600c4f0100b004148948621cmr2566601wmq.8.1711380527317; 
 Mon, 25 Mar 2024 08:28:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 j28-20020a05600c1c1c00b004146c769c79sm8799861wms.0.2024.03.25.08.28.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 08:28:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v3 3/3] hw/misc/stm32l4x5_rcc: Propagate period when
 enabling a clock
Date: Mon, 25 Mar 2024 16:28:26 +0100
Message-ID: <20240325152827.73817-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325152827.73817-1-philmd@linaro.org>
References: <20240325152827.73817-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Arnaud Minier <arnaud.minier@telecom-paris.fr>

The "clock_set_mul_div" function doesn't propagate the clock period
to the children if it is changed (e.g. by enabling/disabling a clock
multiplexer).
This was overlooked during the implementation due to late changes.

This commit propagates the change if the multiplier or divider changes.

Fixes: ec7d83acbd ("hw/misc/stm32l4x5_rcc: Add an internal clock multiplexer object")
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-ID: <20240317103918.44375-2-arnaud.minier@telecom-paris.fr>
[PMD: Check clock_set_mul_div() return value]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 49b90afdf0..ed2dbd9dc3 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -61,7 +61,7 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
         freq_multiplier = mux->divider;
     }
 
-    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
+    clk_changed |= clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
     clk_changed |= clock_set(mux->out, clock_get(current_source));
     if (clk_changed) {
         clock_propagate(mux->out);
-- 
2.41.0


