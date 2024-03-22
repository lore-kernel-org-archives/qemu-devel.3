Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7E1C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 15:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhHt-0001Cj-GC; Fri, 22 Mar 2024 11:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhHq-0001Av-TH
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:58:31 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhHo-0005eQ-E4
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 11:58:30 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d228a132acso31043861fa.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711123106; x=1711727906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UxjY8qQEnjtbAhkgYiOeCHJsc+3HFQ5wgndLMK/z5QQ=;
 b=R8r5hRY6gwbZVFB1TBsELt667RJ6iOqB98kN5CMLlnMD5ufnNEOZArHovNoWw7R63I
 wO9L/NLD0TNQSiE/lGgYYwH8D5IXPMyu3wT8yhPj0Qffl96HmY5E3rMo97+wmY+8oyqS
 RCInRUQNNJoUuBxyfmkRL503TD1fcSoTVmjwRrZmheak9oq84i2nJzGFbjPtOSeCdgIi
 +VeThnHK/yL8Mui08oaJui16LH1ROUnxT8NRnXEsaaC3pQJ9ftZUKbv33wHQnYJTaS0U
 wSkjynO3Vk2z2MujaDaaWP3M8NeAtNCEAtlyk6/I4itHa4fuSv4R5Rb+5TecmGKoU1Xm
 aIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711123106; x=1711727906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UxjY8qQEnjtbAhkgYiOeCHJsc+3HFQ5wgndLMK/z5QQ=;
 b=Vp2BoLZM6gzbFXRJKd1piwyh2NkSsRECoEqN7IyZWzeUeXG4PnDHRNlsWIUMT4kE/v
 q4en2dvuCmgarkcBPEbP1k+NEZpI3lQMTgJXbIfbzED6fZyJr354gNo+OK1iGp8E3bSe
 0W9sc7I6BWDHpzE/D1+HPet2rbWdvjDxJTi9DqKaz9a5Axmv7VpW9vyjaLX1YmQLHUxN
 KSklVWTimC+M/66JY+6aJxzVDvmaagwWC0wA7jWQUpHlnZFQqr963nGs14XXGHJvukEO
 X6LFpjT38XuG297VTJgWQK/mw5kFeSw79KyxG5GIuRy7XTdjXOCR4cpd+1YmxdNhEfQR
 OH2Q==
X-Gm-Message-State: AOJu0YyrIU/RGfaVLzvNwUA7NnI9BfarlEjoQeGAeBZLY7UfdiWml0ny
 CHbkXOkSIhdaiX8wHmKAHZ+EYMUn0jMKd+0TGFcDNp0omjf2fLlB7NpYilp9iXmAITmml+kPDFu
 G
X-Google-Smtp-Source: AGHT+IHXhS4889qWr4Ii6oVGUkJJ0++U/LkjLyALa8fhLMG3pbP0sG9Iip0qsRNrN5JEjBH4KFdiNg==
X-Received: by 2002:a2e:8ed1:0:b0:2d4:74c5:2cd3 with SMTP id
 e17-20020a2e8ed1000000b002d474c52cd3mr2166352ljl.41.1711123106159; 
 Fri, 22 Mar 2024 08:58:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0041477e76ec6sm3486777wmq.2.2024.03.22.08.58.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 08:58:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc@lmichel.fr>, Luc Michel <luc.michel@amd.com>,
 Damien Hedde <damien.hedde@dahe.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 2/2] hw/misc/stm32l4x5_rcc: Propagate period when
 enabling a clock
Date: Fri, 22 Mar 2024 16:58:10 +0100
Message-ID: <20240322155810.5733-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240322155810.5733-1-philmd@linaro.org>
References: <20240322155810.5733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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
 hw/misc/stm32l4x5_rcc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index bc2d63528b..7ad628b296 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -59,7 +59,10 @@ static void clock_mux_update(RccClockMuxState *mux, bool bypass_source)
         freq_multiplier = mux->divider;
     }
 
-    clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier);
+    if (clock_set_mul_div(mux->out, freq_multiplier, mux->multiplier)) {
+        clock_propagate(mux->out);
+    }
+
     clock_update(mux->out, clock_get(current_source));
 
     src_freq = clock_get_hz(current_source);
-- 
2.41.0


