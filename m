Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECE8C021A1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiB6C-0002P8-8k; Wed, 12 Feb 2025 06:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB6A-0002OK-Ht
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:10 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiB68-0000tF-8B
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:40:10 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43955067383so11603365e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739360405; x=1739965205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrLx9pNp+bcF8pLwNwFLoW2tChA85mu49fL7NOiZcbE=;
 b=ztBtrTrAWdqQeqFFfExL47NvaOhvJ7JzKIs5VJJGEGvhT11fMGMigzYR67qqPQ5ZHw
 bIo5l5nsK5wRoLXfxaR/gVNgOfUbcyOSHo+kJ0jkdAbCVKm8tuFphqTom70YhB7Ya1ZX
 aCkyz5VCtIe7C3Cwgu4gZovfIAtMI1tGAUcx9RnX2DjaHkF1Zxju+AwFLuigFHwJw9H+
 zJmmsizmszYHMPhYyEhVeuBLNR/JKyfjZAhCjTNpGzH+MwimheeIsV2RovD8lWJMtXqr
 zbtk4FV2GH+RKu2CtY29hVVWlRuIlQLUkJhe25dHq3hgJX5n/OPBGeS+PT05fk0+w1Tr
 MZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739360405; x=1739965205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrLx9pNp+bcF8pLwNwFLoW2tChA85mu49fL7NOiZcbE=;
 b=nJL3d3FT0rAi30lAMhJA6rEAuooEnADfCwBKeWBxvbG+Vl5tU5ux1DkvtzEFIChV6r
 8rs9LwWL4y73DZmKBI+hLbKac8djmeRHy2JUkjJWTaKJPhSNc5+DUQbJQOw92eccWZMA
 sfRYgCdYYzDIZPQoYIKa/O833aPKrRFgruZb+M0v7AsJCept8ImTye12zqLF3SkYblzs
 AuBMb9LlR7UdS/lQyzaTBgymhAYOZ32BqWISb7I6E6btj4+vSTIG5LRJXwGHkfzJlzJV
 /UFMdPAWBurg/AhffOjRfWWC4jpgip4YsWrhiehPDiBWAvkWPjL5Gqr3pHcMxrrDEJmC
 0xJA==
X-Gm-Message-State: AOJu0Yy6mwHq9JZadsnkSZZAtKHzNTTUNfkTjJSB2FZkLm0apaEosqhM
 2uGc3M1uMcmE5FfcVsARENQqtotHNncZcdyTaKBPefpPo/P3/E9RIusFx49TJpVvbl9ZgOqjrcn
 PhvE=
X-Gm-Gg: ASbGncs/E2+ZcLp6NamvybhiqLIs6qAdbiK8L3+wPSSLTCRFAGb4mEDRB3tHAg8fq1s
 wjA93AaE2X4YKk2V0Grk+5aEgiykG7IVIW1V+n4FV9vd2T6MOFUbmlt2vj1fAgpZVed6CFJXlXE
 O4prYi92G8LfRFwz8OWxshW8HnokZOUZXDfoONAeAHivOdawR0fAWZg/IKe4xh+IFFYEWWKBdwf
 KLmohkWDXrRTaSezi8yJpB5r7EeOKGtCrzrL4ltb/bnvkgdZlv1mkrCY+Ut+td3YMGNbHHRPOnV
 8q3xkjey3WjZWHZ4vmZOUlBBT01UZgkxiF9lTWjh84W/ERwGFOapqtwVYzZDb1x5kA==
X-Google-Smtp-Source: AGHT+IHWbI5Wn++OZurfVX4trzPGkHJ2T1NXwqfqY3j8rN2XFQUHCu0MHKP7OKfYNRqTJZu8iHGNjA==
X-Received: by 2002:a05:600c:1548:b0:436:1b08:4c78 with SMTP id
 5b1f17b1804b1-43959a997a5mr21481265e9.31.1739360404731; 
 Wed, 12 Feb 2025 03:40:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc3a10fffsm16386020f8f.12.2025.02.12.03.40.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:40:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@kernel.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowang@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 5/5] target/i386: Mark WHPX APIC region as little-endian
Date: Wed, 12 Feb 2025 12:39:38 +0100
Message-ID: <20250212113938.38692-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212113938.38692-1-philmd@linaro.org>
References: <20250212113938.38692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

This device is only used by the x86 targets, which are only
built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_LITTLE_ENDIAN (besides, the
DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
using DEVICE_LITTLE_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-apic.c b/target/i386/whpx/whpx-apic.c
index 4245ab68a27..630a9616d71 100644
--- a/target/i386/whpx/whpx-apic.c
+++ b/target/i386/whpx/whpx-apic.c
@@ -231,7 +231,7 @@ static void whpx_apic_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps whpx_apic_io_ops = {
     .read = whpx_apic_mem_read,
     .write = whpx_apic_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static void whpx_apic_reset(APICCommonState *s)
-- 
2.47.1


