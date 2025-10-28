Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172EFCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 18:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDoVn-0006Ty-7H; Tue, 28 Oct 2025 14:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoVW-0006N6-Nh
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:33:26 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDoVO-0004CA-PK
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 14:33:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee12807d97so5893799f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761676385; x=1762281185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7j5BIJP17+UqRO/W8Lo+TNqHDVnZzxsQi9DL2cIQNS0=;
 b=uUSZq0AZ2+NE+FjHjxXlJPjfvrdR9V5t0OUJQvQqNjGbOWmMRlH4OJ9+ytdatimHjl
 tt53IUpylOvKrcq1orPIVFtN82oM390AsP/Ddyflngw1vv65v9b+hXHRBJMEYlFFGPiT
 +JVDF3Ja38+yuVlv4s5Od2vcfh6+5J49W65bU/672MzlJd4wr6ydVV8l1WtqIffdm/if
 W4JR23oQ/N6+SeC+FTRkAGRDt/KxEh4RijhPEM3XI4edArJ4PRRobPURjqqTX551LwhK
 255B1361Jy41nUJxd6gXlIiF0BPqozgl5o1Y3SWGgdvbQqHq7ERhGj4ofQsB6T/b86bP
 qoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761676385; x=1762281185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7j5BIJP17+UqRO/W8Lo+TNqHDVnZzxsQi9DL2cIQNS0=;
 b=S5+abAgN23JwfftP+Dy1BnI0bClssMqvqVma5XBSwqZuNzuIS9lsG6P6kWkOcB1JMx
 z7ZVHYRgx40oo5bqN30vJiQ//PMJEOjqoOUrX+bQXnb9N3ghy16fBDdmlooPQDqUjSwd
 LNlvbB+4IGC0pB1lUh4qopmbChfcX6aeGntYmGdhqMrAuVxIAlZNUHmoX80ezQpS5p3E
 z5n35eRbbubwEanOqaRPFDhPR0RfBn8YO/ekpW9zz6sd2VMe4GG+1MeOaHPZHPraBLPZ
 TGJQEzgsXhEQ2aaZ16tgb3NUZaRlNIWxRkERs9GXcR1MnMpeSs1LdtC5QGWPVRmrqELu
 FNqQ==
X-Gm-Message-State: AOJu0YzMZaR57PqzHusG9SeWA9nMXjAcvyE7IYuKIY8aIpTYNi99SDag
 3v8mCNFb1zlM6HCe7LZBS6xlln+pzxgyC5FrPfWoJQG9pl26afiviWfAm/4PVIm64qzbSNd8nSX
 czcPv5xw=
X-Gm-Gg: ASbGncvKGrwNvXdmpycOuOAUodzJk93egO9UeZVo09Yh6e2WBn7gfzSlYkc8Q1ZmZpR
 lqQNhQI8O6utANq1cKqNsXI5vFgci1ycMskWJzsKQIr29DzNbtBMrnSpuqDx+ujbFEHCsSqmc8V
 Hp9fJA8uC0262Bffhv+sCRBwTnV2fv3s8jGNBaoswxL7lxpRAl1iCU1jpsunD9TM1ez465wgMXU
 ThyzN98n8Zxs/NeHyPJWSbA2LNlmNHAoAAwv3fvgGZ/GFiuBH9FJc4+7b91HMUZpj7t+hnR5b5x
 jzB5HQEf5R8aj7EcwN/13OhYQ/5f3a5Wp3hlLgvZQHr5gndbJtpRMLoybboRLcsTgojk4pOF8VN
 3bXWcWbeU7r63o+7Wcz0koVqwgm6kf7NM7sGVOt8UphUgbcx8jDTW6xff5etGKyEyQ57ZP/yEsA
 MuBKZwu8wL/05UWGyv4rqSWnHzNPVvdmM1Z7jEGNX9xS2FIgMlgnO2m5CHD4JX
X-Google-Smtp-Source: AGHT+IHGiWmEGr7Mocg3dTC4g97uHTSqAkS1iH5OLYhopZsv0+nhnWDP5kXiVjZvDYeQlZsSjlXfNw==
X-Received: by 2002:a05:6000:2313:b0:429:8d21:572a with SMTP id
 ffacd0b85a97d-429aefbdb9amr35337f8f.34.1761676385531; 
 Tue, 28 Oct 2025 11:33:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7b43sm22092394f8f.6.2025.10.28.11.33.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Oct 2025 11:33:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 17/25] hw/timer/hpet: Use memory_region_get_address()
Date: Tue, 28 Oct 2025 19:12:51 +0100
Message-ID: <20251028181300.41475-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028181300.41475-1-philmd@linaro.org>
References: <20251028181300.41475-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

MemoryRegion::addr is private data of MemoryRegion, use
memory_region_get_address() to access it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/hpet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index c1b96d0a89f..e2cd0c9cccb 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -677,7 +677,7 @@ static void hpet_reset(DeviceState *d)
     s->hpet_offset = 0ULL;
     s->config = 0ULL;
     hpet_fw_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
-    hpet_fw_cfg.hpet[s->hpet_id].address = mr->addr;
+    hpet_fw_cfg.hpet[s->hpet_id].address = memory_region_get_address(mr);
 
     /* to document that the RTC lowers its output on reset as well */
     s->rtc_irq_level = 0;
-- 
2.51.0


