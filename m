Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589C4C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp8zk-0003q0-Ae; Tue, 26 Mar 2024 11:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zj-0003nN-1q
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zg-0001CO-SS
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:45:46 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33e285a33bdso3367640f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467943; x=1712072743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd+vMuVqiQfFDX5tDq7mwgsep0f8/HZ19ER+KJLjK2g=;
 b=nYUTXbzftBbnz39vmhFeITOPBmZR3OBT8VW3eTXivuz31s4KXPXsKqf0tGrNzbeE7u
 xqZSCpoIuml6KAW2Qe9z5jNezhSwzAflLYtqv53IRMb4nyJRjyyrD4IoCnvI6PHe8GFP
 JSv9u9gefjLYkEeOBkViKGzmdCYxRPBO3SrtyGkaYJuAzs2pM2xps0edXOom9/sZVlmk
 AyO+boVKBYkcsBixmc9x3UR5BAidimx7AZnRGyG/zDe0yzYWdAqX3ckFnx04bjXEGNEo
 w819Sy7tnuJHhuoBZAX6WqHzIIi/qTXu2LXz+uoxRa7j0p/11/FPKrQefonOPUSxWq/r
 ZT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467943; x=1712072743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nd+vMuVqiQfFDX5tDq7mwgsep0f8/HZ19ER+KJLjK2g=;
 b=hTmdvz0pHfXvPR6JekIiQQonW97QrkqJrxKROFN52bWCeLzegZY0YM4gkVDGTSmE67
 jkGkm2OPwuStE1Ob5VgF1ned07EIFRb/7fVp/9Oe89TwqTrWobkKL40AZ4oaYbdFtKKw
 uFbR9n7cVne5ln1Fy0+pQ2hu5kwqEYKEcXEm0fpioVGtBYK9qkwp8BRfaX3CC13/Pbpt
 5CXcuoBwZEX8IgFnyq8F8MuC1LlSqWp7KNOewR/L0cEkdJd/1pJgRlgM35O1Gii33jmM
 zkl5bA/0rp2d5DRIBnY67ysw76PKK2jyESFYIkaoaGeRhkVQfvywPUogsv09qaDllcJA
 XhUA==
X-Gm-Message-State: AOJu0YzJhMr6BLXh6iMsxidPqEj72VES3OEbhan8eCIN3mGiNUSNaFgc
 eQTl61zTeVo92A8DtG1d6UzGQwOt+vv9lZly4t5hdpHeOepSjjPqE0T8fJV+I8+xUR3fOftQfnu
 7
X-Google-Smtp-Source: AGHT+IE2GvDWOFjl+Lb0ZUPMSQOY1ieA1J21BH5JpIoP11zJmq8qAE6vB5grDx2AQ+RuJG2JsaUemA==
X-Received: by 2002:a5d:4c4f:0:b0:341:8efd:e206 with SMTP id
 n15-20020a5d4c4f000000b003418efde206mr1223655wrt.38.1711467942916; 
 Tue, 26 Mar 2024 08:45:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a5d5585000000b0033ed7181fd1sm12471970wrv.62.2024.03.26.08.45.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PULL 06/13] hw/misc/stm32l4x5_rcc: Inline clock_update() in
 clock_mux_update()
Date: Tue, 26 Mar 2024 16:44:57 +0100
Message-ID: <20240326154505.8300-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20240325152827.73817-3-philmd@linaro.org>
---
 hw/misc/stm32l4x5_rcc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index bc2d63528b..49b90afdf0 100644
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
 
     clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
-    clock_update(mux->out, clock_get(current_source));
+    clk_changed |= clock_set(mux->out, clock_get(current_source));
+    if (clk_changed) {
+        clock_propagate(mux->out);
+    }
 
     src_freq = clock_get_hz(current_source);
     /* TODO: can we simply detect if the config changed so that we reduce log spam ? */
-- 
2.41.0


