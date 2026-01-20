Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B84D2628B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGfc-0004iT-75; Tue, 20 Jan 2026 13:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfZ-0004J3-41
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:37 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGfW-0006WA-0D
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:41:36 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso20747215e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934490; x=1769539290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G8NbjUAXkrEVgPJyYlYat3VGaOk50clmb92i6sZEIyM=;
 b=PlHNELlZAlfuHLazql2MDL+0rSkneupSGBJKKtYA7A37aGhgHs4raOyMaaw8Yek4aj
 6Sba5U7BptY/PoXT4Cc8cllXA5qcifI1B9n2FRJ4U2oRocbScWwAffxqNRxaBb+KoYQ7
 PLeKS83dITzJqWF4BkILb1FhmyE1njU+peiBFbj5qlgjssT0zDUZSTi0hyij3T2ziRcv
 xkEFrdt+m6nxjILyopHSdhuGZn3FF4S8mnQ1snf7vPhXn6ZoASw3RlR48CvFihpILnog
 LLpTg9mOC1Y0UH2rDRUW8gG7wbKbalic5y66W/s6pAVhv0rnDLKlKSH8/ehVa5BbKsdc
 /WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934490; x=1769539290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G8NbjUAXkrEVgPJyYlYat3VGaOk50clmb92i6sZEIyM=;
 b=VKtnZBedFYLwE1xUkQtBLsXqV1Qm+h64N+U92kQEtnAw0W2GXIURH8mwkTZCX5V+B9
 /Iytiy0f1bstM1lWdbqWTwTzAENVFDMM+GSVY3PRcLVJNDFTIZ/YzYqOtbyjtx0IT9qN
 eNWGimlWOk17RiER3htCpAPcAWmyiVwsUvyeb7oCfWaGxYeFB1wk3h63wjZ9eW04nPrw
 krD9GoxL+hXv9xcYjO4r59iPg9E0K7CmSfWhKGY57K240WMHuPFySzZ5RVtqffPc82q1
 xKTeF3KW/pljcXOdDn4LrfwpNY1qrM7ARNcFwCNc8Djf7ZQVvyAhWglgQQfhqHRt6dUq
 /zRA==
X-Gm-Message-State: AOJu0YxTWWdFTMvCu83OIpnp02vexbIfRiItg1aI768iKXIwBEeOlQ2v
 64r+EUB57WOQupt9JiY5n54lOS+xgTU/sPHRuDGeL3KWyooptCwLd/woFTS+6lt4Auo0UJkIwig
 JZVV9n74=
X-Gm-Gg: AY/fxX4wxu0Pox+ChY/ZkNrikBeD4EK2W6bX9zuilKWPFdt2wpeSg0SbSRBEUW98shQ
 zg/pljstfwczq78haHZ7SU4X+TjDpy+zJT7lN1PLlRx7aiV9zqhzHl+N0jEfphRYXh6ikcfJODX
 4FjjiIut3o5/erUqOIJB9EXG3iWCixxeelvv4F89qAnvSJSUKEqhzVZeTUtKWJT+aNrrAkzeI5o
 02gr1g9zkTZBargc0ETsz1LZi9PrWUfrPmpL2mX9Ua+eYbxSi70lHkiOVaiutBnGHUGhHdPRWM9
 vmKn+GoJiA2Hic6do6rYDc5+xMwZUhsg2s+zj0GpDpIgZkL52P4d043rm3gf+QwXMSdwNJGlrLu
 zZSgHiohiGo4IlI6A6VCBuB2zi77U3LTIYMkcmFFYcxfeZ+9fDKzl+zNenfJvVLYFtzvrjSnaR6
 CvaPx5sr3Us5N13Wf+oxnp8agJVPmkGLGOD03kxbm4XumexYGzOan/zgUXdUxX
X-Received: by 2002:a05:600c:474a:b0:477:5897:a0c4 with SMTP id
 5b1f17b1804b1-4801eab5647mr200823895e9.4.1768934489782; 
 Tue, 20 Jan 2026 10:41:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43597bda41esm1044942f8f.28.2026.01.20.10.41.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:41:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/29] hw/sd/trace-events: Remove redundant "SWITCH " command
 name
Date: Tue, 20 Jan 2026 19:38:54 +0100
Message-ID: <20260120183902.73845-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

"switch" is already part of the function name. No need to repeat it.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <20260112145418.220506-15-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/trace-events | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index d30daa21431..4ec52d2a819 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -58,7 +58,7 @@ sdcard_write_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t
 sdcard_read_data(const char *proto, const char *cmd_desc, uint8_t cmd, uint32_t offset, uint64_t size, uint32_t blklen) "%s %20s/ CMD%02d ofs %"PRIu32" size %"PRIu64" blklen %" PRIu32
 sdcard_set_voltage(uint16_t millivolts) "%u mV"
 sdcard_ext_csd_update(unsigned index, uint8_t oval, uint8_t nval) "index %u: 0x%02x -> 0x%02x"
-sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "SWITCH acc:%u idx:%u val:%u set:%u"
+sdcard_switch(unsigned access, unsigned index, unsigned value, unsigned set) "acc:%u idx:%u val:%u set:%u"
 sdcard_rpmb_read_block(uint16_t resp, uint16_t read_addr, uint16_t result) "resp 0x%x read_addr 0x%x result 0x%x"
 sdcard_rpmb_write_block(uint16_t req, uint16_t result) "req 0x%x result 0x%x"
 
-- 
2.52.0


