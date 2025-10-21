Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3305ECCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJH8-0005q3-Kt; Tue, 21 Oct 2025 16:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJH7-0005nA-FZ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJH4-00018J-FZ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:48:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-427060bc0f5so2045030f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079684; x=1761684484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PCJUsmctVJ9G/52a/hBFRs7P+qmJ1PG9K4Gu5Uohdn8=;
 b=bHFfc174wW80NuiAztp2dnrO5vBLn3XlY2VUS970mNvUNTtaRszaVSq7SfVc1Bhi9Z
 n3H8jHyjKUdngyxtQCoWYL3wv0IkCaS4b192PVhs2dTpojGvuF/c4tztcP9TQtJSM6sx
 36drqZ9ZYiyc6bJ7YqHLbjFa/ncnmcLBSB+aHb/Q6OJoWS/SIvBIutXYV08oi8OxdKIO
 XkmjigENObWqXc2lUgXXwQwTzLBAWcG48UqqTD6Tj/awrODXFvjU6zcNgb3ZF7mmgb/9
 xb7VWQappjI4p4UnbG60IRIQYDveDMpdY5/O8PnnI80s90CqOorio9l8FZqK+YV5/POt
 q1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079684; x=1761684484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PCJUsmctVJ9G/52a/hBFRs7P+qmJ1PG9K4Gu5Uohdn8=;
 b=NvprgK6i5c5syVxEb0VwWsVi/jA2y9uNnACCbto2EhtJUc/VQn4ys6Hu6cQv1rMXoD
 r3IBu8LAErtb1aJcTD6Ch6+Vo4h/4+rdBgyDeGlfTESP9gBE3WkPrSYfcJmUZwKKAPBJ
 nx769aGOtfXcWuVT+ox4CpqPtfqmDYpTe98BtxC/W7ai9EkGDXtRBLotca3z7hhU/s2h
 KosGR1duwni9QWLYxqCB8uFic7tSca9CVcMo8BgcZijbaCphV/mYc626eWepAL9FM94k
 kDeTV1sMyf/P0pe6lLAzpqDmQj/guwl3ITOatwlr7YN4yOvkcm0fk7/nCGAeMbDtBbx9
 kqqw==
X-Gm-Message-State: AOJu0YymCG2JNA5Mbu+E16xZCYZybsPM3D3os0PWlFg7qWnjPL/zko7b
 QYFSqWxyV1gUmO2oE4XAxRtiASo+d+ufnNWrb8t9AgLGiG7Du3ZVzw+sH/GH9ijv4CmgyelOgD7
 vAWqo+fI=
X-Gm-Gg: ASbGncuMHtkBweGNnBq63NjICNQPcFzdqbU0LQ5ZXitEIJcKcdR1kcC+8hL3gxj3dk5
 dPDXWoRyKL2wRVQ6g/BHbs85EiajwCdT7izsMLw93o/SmwqvxiIYIT3Ts+EcpHqSutfA/4Q9wJh
 V3pg3MPH7teHLeKtS4pqF3gEWJe1J0y51saehQ6mspPNNaDWfgLsoFhde2RU4LhyNRLHE6DtFtu
 8NnpvI5ImPM0vAX2zw6kgCTCL3aOU0HbnEsIG/wyZpqMPGRCX77GMr4fY5H3EI86wtnHcSab7zN
 n35VVkldyGPM+YhSzXp7m/rLhFQO77N1k5+BFpNzHuSF/jmps/txFNkImvR3XZAcOnaKU5Qk8iQ
 rTYiGK0M+UgFvOEfSYZjp4fGe8SjDcgCUq876GyiCXYfNsurkFAt0KPQYw8xscIj3niemen9XZS
 Uj63jAS3SfeOfACuXUS7++rQwU2rmCl0GK5dF3TYZGcSklZhsqBvOMTKcExE73
X-Google-Smtp-Source: AGHT+IHPG1Enz8eZd8UMMAXbzzgM5jPGeK1RyxPZeLYslY1zOZ23jAeA6CZ02FitgRFXgLO7SW9+6g==
X-Received: by 2002:a05:6000:4718:b0:426:f10e:6b56 with SMTP id
 ffacd0b85a97d-42704db1df0mr13457479f8f.27.1761079683646; 
 Tue, 21 Oct 2025 13:48:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm22008525f8f.9.2025.10.21.13.48.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/45] hw/i2c/smbus_eeprom: Add minimum write recovery time for
 DDR2
Date: Tue, 21 Oct 2025 22:46:27 +0200
Message-ID: <20251021204700.56072-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This is needed for newer u-boot-sam460ex versions to pass the DRAM
setup.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251008122502.9DA8956F301@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/smbus_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 0a1088fbb0a..26e211b31ad 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -288,6 +288,7 @@ uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
     spd[33] = 8;    /* addr/cmd hold time */
     spd[34] = 20;   /* data input setup time */
     spd[35] = 8;    /* data input hold time */
+    spd[36] = (type == DDR2 ? 13 << 2 : 0); /* min. write recovery time */
 
     /* checksum */
     for (i = 0; i < 63; i++) {
-- 
2.51.0


