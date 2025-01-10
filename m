Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E054E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTo-0007gi-DQ; Fri, 10 Jan 2025 11:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSq-0007GB-3W
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:26 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSl-0004C9-5L
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436345cc17bso17025165e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524935; x=1737129735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1SHV4ouwmWCxa4hls/VEliYDrrRoOnyygtn8mgw1kM=;
 b=YCW5VyiDAxjhZbB1P6jmdgoxRqXchg1SqeLkZLeiikLr9RIxth2PgjYd3Nqi+6skwn
 pUS6ZA9WZD06I1Ku3+actb+fwPPZep+b5mBC5QYR9kOmGUGSIvmJF4Dh8fIOt2710Cbd
 u1Z57J2694spJhLJnXwyvth7Tm0GSSb8QpgFNz63agok4JOqpynyZHLGoMxfEqfWVqYC
 5+rLOjNCV9i6h+GqgdKxumRwKHYO5y+Hu2Gi6/JgEkzPAxCPIHkbyRaoIzSmLJLqKwgT
 bLSGNMPzT/bz4zokIkfYmMOmJwwAhpDlftvdN/sizW3L7KmVPA0yMi/2wPaEBZyLoXdD
 /4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524935; x=1737129735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1SHV4ouwmWCxa4hls/VEliYDrrRoOnyygtn8mgw1kM=;
 b=KB8ESEzDYAalAr8B6wwlYOo8eoKOIqOKnTmOeH9Z1hJOnabmpPKhGbZPT3ZxpahgtK
 iKJYe1iA1/OCRs0M8vnfJOruBNzF/vSG7eS63WAjw1y4HRCSmQKC3nHbELnjyBRpeWYf
 dd6mEHPtm/JmWfW2CaesKBqE4wCoYJdlR76dzv/AVuYfYG/Qn7sfEMo5oaCOHKDJ0h85
 V23UQXj3I9AbVo386sJQqaCvNLFTgNPZjH6GE4guSgvOH0LInNqSkzb9SYDM8/7iqxxD
 zfkMmPBteQv2wuq6KceqMnjALb76BEuZrpXsPmWjcqsJzuiUY6W4ogy+wYJ5K6zbDsjK
 Dp9A==
X-Gm-Message-State: AOJu0Yzo32gyASCXJqFPSbl1nRt1tTSWP4UFtW5f054NKsYZF/BMdxQS
 4dGjTmwoAXgarsMUn+XMC2QmTk84LkhM4BSHHNTuyfnkBAI7jp+v922O/ccmq64DWjkf/Nga+p+
 oFCs=
X-Gm-Gg: ASbGncvhBH9lxRq5QFltYHhe+qyf5Xpw/9k4veWthY5nqAXMrWWsMsy3mmAJIYcxBgx
 955133eGKRTzsJ/VUztx76o8SmigBz3/sWqVXIpC/58Q4uqcaql5kpAXWjdywMkMhilCeVhjnkz
 euI+SFn+2MoaopEd8FXYRWl8TMzv6wVIeNHBaApuBYvjgFEJxsUIHszS4Nc7gIjJysYaQlYrASh
 cYmwBD7ZY6y17qimwVHRzo02pvG5Qz3B1Fab58LISy7uQht3LwfD3B6KQtTJ6bH4p4Sqazbra08
 Au/u983c1ZsjaBIUqRxFfBLbkU2KcXM=
X-Google-Smtp-Source: AGHT+IETBxk9KKLClJ71WnVoUuEQGWiXXoZtd+FAn7yhk7Yw5zxx/Y/+I57SN8/XWwTMBQdcLIPgig==
X-Received: by 2002:a05:600c:3b0c:b0:434:fbda:1f36 with SMTP id
 5b1f17b1804b1-436e26e51a0mr99968965e9.20.1736524935062; 
 Fri, 10 Jan 2025 08:02:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d69sm55675815e9.30.2025.01.10.08.02.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/9] hw/arm/stellaris: Constify read-only arrays
Date: Fri, 10 Jan 2025 17:01:57 +0100
Message-ID: <20250110160204.74997-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 9b414ff9069..7c9e7e6c15b 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -101,7 +101,7 @@ static void ssys_update(ssys_state *s)
   qemu_set_irq(s->irq, (s->int_status & s->int_mask) != 0);
 }
 
-static uint32_t pllcfg_sandstorm[16] = {
+static const uint32_t pllcfg_sandstorm[16] = {
     0x31c0, /* 1 Mhz */
     0x1ae0, /* 1.8432 Mhz */
     0x18c0, /* 2 Mhz */
@@ -120,7 +120,7 @@ static uint32_t pllcfg_sandstorm[16] = {
     0x585b /* 8.192 Mhz */
 };
 
-static uint32_t pllcfg_fury[16] = {
+static const uint32_t pllcfg_fury[16] = {
     0x3200, /* 1 Mhz */
     0x1b20, /* 1.8432 Mhz */
     0x1900, /* 2 Mhz */
@@ -964,7 +964,7 @@ static void stellaris_adc_init(Object *obj)
 }
 
 /* Board init.  */
-static stellaris_board_info stellaris_boards[] = {
+static const stellaris_board_info stellaris_boards[] = {
   { "LM3S811EVB",
     0,
     0x0032000e,
-- 
2.47.1


