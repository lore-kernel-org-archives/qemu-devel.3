Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A3DC04FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 14:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwNk4-0002mz-9c; Mon, 15 Apr 2024 10:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNjw-0002lY-JW
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:55:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwNjt-0002Tw-HC
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 10:55:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4187c47405aso2861755e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 07:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713192914; x=1713797714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBKvjyZHrA8if2PPwIeCgkhgbYs8MogwQPuCwsG2SeE=;
 b=P4S1nKySTLpYB6AJ3EFlhCwPGOAzdMXu74VtLZ1GgtSeuBkLKDyJb+XZs6VekU2vaD
 C7B6coLRymMSUtQHVcxUEnUqHKNOTCr1w01/D+LQ/gvvMOezWSRkYH8tJw08DW9jmaLx
 ZRvAGCdTZ5w+HZHHoT38bCQvx89iAhiA6pTtZ+QYdhxmsrtoHHLpIYvZ6v8my7GI38Jh
 QB2M6YKRSClZz/+yT86ejtDhUqFpG78PqEfNu9R1UsnJ524P5PUTC5PihKJzq+Nj04Fs
 LQMXhxnCrZr2JEQtLEmcHdRZhpUga5bpozyKMmlc0HpjQQmTjwofyIxsajTTQk2nOW6Q
 bn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713192914; x=1713797714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBKvjyZHrA8if2PPwIeCgkhgbYs8MogwQPuCwsG2SeE=;
 b=vIe1vkQ6KUv5r4FNNvoNyBt/6gjYANZKcBnFaLk5mrJ3J4xo7FUI8XaHmioFxzKrj1
 qXWZkmEf3hQWi6yKdaoxvCVWm8nb3wjfFRrgoRH5hBYA68h5IS3ENEjKT0Dxa5trp4lf
 Y4WAwIm97/6ktjoYjYphNFYjZytLyKNHgTTbIWC0vrfhz3ckSZow1m3BCDYTklmHqWAH
 hEHcm839CEBNojMuOs4poMkEpDk3w67UV47mMfTxaLulNq/Ad2F2Io+ct9/TC30kbOwF
 FIgxIraolcVPDcre9o31UqLjfy5tNitwsneGiMpcQFFgGmXYv+CtQ8Cfh8KemyOtW0Xm
 kZ4w==
X-Gm-Message-State: AOJu0YxzPS/Glpns1W3/oyAn6wXGtASIAvqu+39sC/1Fdi8GxNz/Xlh8
 JDilNM3m+COyjSqkMmHtBn6GCnAwrTiU+89SYDq153jOWrCPAKz24ERjtdY4n5eVFO1wIYmlMjY
 4
X-Google-Smtp-Source: AGHT+IFfPtjdg9SvpAyQMsi/x44alks2bOcBb0OS/XScqo+BKslr699DR4HQhrmbl3RIxAOxcK6zNQ==
X-Received: by 2002:a05:600c:4690:b0:418:6044:26cf with SMTP id
 p16-20020a05600c469000b00418604426cfmr1627759wmo.28.1713192914500; 
 Mon, 15 Apr 2024 07:55:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.132.126])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a05600c4f1000b00418729383a4sm2497829wmq.46.2024.04.15.07.55.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Apr 2024 07:55:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 1/2] hw/isa/vt82c686: Keep track of PIRQ/PINT pins separately
Date: Mon, 15 Apr 2024 16:55:04 +0200
Message-ID: <20240415145506.48179-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240415145506.48179-1-philmd@linaro.org>
References: <20240415145506.48179-1-philmd@linaro.org>
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Move calculation of mask after the switch which sets the function
number for PIRQ/PINT pins to make sure the state of these pins are
kept track of separately and IRQ is raised if any of them is active.

Cc: qemu-stable@nongnu.org
Fixes: 7e01bd80c1 hw/isa/vt82c686: Bring back via_isa_set_irq()
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240410222543.0EA534E6005@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/vt82c686.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index aa91942745..8582ac0322 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -658,7 +658,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     ViaISAState *s = VIA_ISA(pci_get_function_0(d));
     uint8_t irq = d->config[PCI_INTERRUPT_LINE], max_irq = 15;
     int f = PCI_FUNC(d->devfn);
-    uint16_t mask = BIT(f);
+    uint16_t mask;
 
     switch (f) {
     case 0: /* PIRQ/PINT inputs */
@@ -673,6 +673,7 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     }
 
     /* Keep track of the state of all sources */
+    mask = BIT(f);
     if (level) {
         s->irq_state[0] |= mask;
     } else {
-- 
2.41.0


