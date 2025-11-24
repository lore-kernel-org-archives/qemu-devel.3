Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA6D9CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTIE-0006P5-MQ; Mon, 24 Nov 2025 04:55:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEj-0004UW-Jw
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:52:06 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTEg-0001bR-LM
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:51:56 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so34811145e9.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763977913; x=1764582713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eh6MHRib1ellMghl3+SNmWwKGGVxvwx21luylnyRog=;
 b=mr5SxW4CPblrjpnydCuLRf1m8DKAHQ+PFdxsDHq3Zub1IBOmoccv/6Rn31enB8T28G
 pUAG3isjUj6dqlbSSmep075XuqOlbTzUoUIM1k0C/jtEXo38r6qY7bJnMFtvw6JdUmD6
 NniEcwuRN0YYz7r1PdrCU6t/VR1yDDArKM+ZqGDYw7JN4NwmGXZlIEWAidtyRwIwEZfL
 hbGpfVE7eEQDLav9ib75d+n8wCzdGVmVM0Ja8dM47qEDogQJPaktR0Lay0O2lMgucMm4
 nAAsMhAqESr+f2u1g0BjF85MQOD2jF/BUab9igvfM1/mHIwuIwckvjN5ita+P8RhQWgl
 P/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763977913; x=1764582713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8eh6MHRib1ellMghl3+SNmWwKGGVxvwx21luylnyRog=;
 b=Z/Mej+09ptYIn960YAPCZvFWkhfbjWj2XrCj7clvbiAZbz1xDP7zLSre2mYD5UqQNz
 T2MBEmhY81Mk0RX8ThXVUyVTzadxwJ9yRqZLgxTQ3BCegLMSr2tMm+WuQmfhGBG0QUAj
 k2GGyA1QwYRusKkjFmiMOibm7GMvmX1NkdLBFhUo3bTGH2SyR5bf7ryeFZ3WtzVihLQ/
 BdNSbuiyTrk79B0KZq/iBIejTrm1NuwDc2O+RrgHT3gCyhRhz75kqtTryz8uBGCCEzwb
 34AIn6c1BcEQP8uC1WFYcOn1po0qBRLdmX+ErT7GPUEN/1BOseJJk92mt9O+uh4hTANV
 vewA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeX64J3I4TwtxO+86t/WoxLrx3p6w0WpqIDt/8pLXrrnOjv7IuS80uMj6KrLrN8sr8piUOR0oOmwAH@nongnu.org
X-Gm-Message-State: AOJu0YyDY58T0svISy33GuRpt0Y0DDb6H5ljsyRD+efrMivto0AjL36P
 J3F2ON6DSdIbsLaNOmE/Mh0qR6climKcs3/JkA+MsmElaNTTZmg8ogbXSFLfSXYb5To=
X-Gm-Gg: ASbGnctpuX79+I+/qyAyOKhaZCBU77qTDC7ofbNP/MbHhXjAtnzgk+ynC3Z2S8A9tSl
 NReWm+QJuqEG82YutoVGfZalZjl/RV4IMe/ewuHLTybWMxXeFxPzRNgdwcCcTtkovWBfUrsv1Gu
 BAdY96KoDLcS4U8P5OotqYu2lbl3Sv0GGBGqz581yWrJhviINivyKlKJQv2z3KyoURsW7A2basv
 Fee8rPU3jIhNtSlyFODIhw4PTnZNQ6Mmq92lI3ug0ZGzwJz/8aUFhlGSWWUrA6r1b07xWVClbfb
 ULRSAHpiGLepeRkkYizHCpCZ+dqMuUy2NTw6NVlb7LdCT5ftIy5xap0Jv/L5WW34glsPxm6CcTW
 PwQGJMhxPOHo7tlzoBYRInXuuon8wR2iS+TnasDmUWN5+U8/9GRDmBxtdK/R9W06h7ifHgOJbSF
 xEcveaTbt1CG9l9oQwgoLlLJQpMSsgU/4zCsZh6pnjdupBGI/BwLyB6netJydh
X-Google-Smtp-Source: AGHT+IFRUPXz9O97zT7tTvi8FfCO8H57dP7njZ+Jy9z/qALg7vYF3PusT8921QsTwHRlo/IuG9ZcXg==
X-Received: by 2002:a05:600c:1c89:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-477c01fc60amr119087025e9.34.1763977913012; 
 Mon, 24 Nov 2025 01:51:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm27301138f8f.34.2025.11.24.01.51.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 01:51:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 qemu-devel@nongnu.org
Cc: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.0 06/13] hw/sh4/r2d: Configure flash (CS#0) as 16-bit
 accessible
Date: Mon, 24 Nov 2025 10:51:01 +0100
Message-ID: <20251124095109.66091-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124095109.66091-1-philmd@linaro.org>
References: <20251124095109.66091-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sh4/r2d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 9de4944ecee..12232fabbdf 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -355,6 +355,7 @@ static void r2d_init(MachineState *machine)
                           0, MEMTXATTRS_UNSPECIFIED, NULL);
         address_space_stw(&address_space_memory, SH7750_BCR2,
                           (0b11 << 2 * 3) | /* Area 3 Bus width is 32 bits */
+                          (0b10 << 14) |    /* Area 0 Bus Width is 16 bits */
                           0, MEMTXATTRS_UNSPECIFIED, NULL);
         /* Start from P2 area */
         reset_info->vector = (sdram_base + LINUX_LOAD_OFFSET) | 0xa0000000;
-- 
2.51.0


