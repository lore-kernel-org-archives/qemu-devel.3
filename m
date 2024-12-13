Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1754CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2W-0003kR-T7; Fri, 13 Dec 2024 14:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB2J-0003Fo-1z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:15 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB29-0006c2-4Z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:09:14 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-71e3005916aso392507a34.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116938; x=1734721738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKW55J0w51PNOklb1SowP9V3cdDc2rdAjEh4kWiClk8=;
 b=fKXaCPhmkqmHJwS5CQpeLarPVoxe78RqbY99cLED4XPq2Ojf0nn/w8uoH8TYpIA/do
 P15pxGDGtJy3Y/f5UGj1TOo4yP/26CutqLuL3bzC5hqqYoc2FdcEk3L5K5YPJzUjIzgP
 HzPZ0sTk2tWggfMT8nVmltKony4N1DyQZimlTMC7RBK+QPf4pgCan4qeRRDl9171PWSX
 oJXX0X21lSbDWGEuOAXP/r30CP7sk10/oIum6SSw/u1thL5Yn0ZH9VYXFa+geMwOr9yf
 l2u8BhVWZUBwzxFWHexR1lF3S3WzjmsPsqFAKtSilMlrjrAiZrA0rNSSebNt3BPs+R1k
 eoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116938; x=1734721738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yKW55J0w51PNOklb1SowP9V3cdDc2rdAjEh4kWiClk8=;
 b=XhPBnbzgUS6T2wKQkZxKqOCD4WrZ2xhIYj8BeSG+JjHkSvqnOUQxV8ggq9bDyUdlYZ
 hvKgkdN4JG1cAnq7ft8pKk7qkw9PIYkn2llbzsGZPltLYdwZn2nhpxhJkyP+P0o2wQtA
 fQNIra6LWRHppdsXuB96za1UlvK3LwTnlizC3VDW3aqOb/l3rFvDjEWpYEdT7dc7OQbF
 22GBrZARY8fIYw15LNPh2DgrIiJVoP2zs1rQaUS9eVb9ZUvUuD9OsmCXwIplXMw/ELDM
 2WJP9LxHKNUkzfX+eu/MkprBkjggwIQBnJVUjR/D/IZGFIyWRY/EudJPaXoegdq0UEvM
 QOig==
X-Gm-Message-State: AOJu0Yzh5pcJrs5fL56dokMrlfnC2vL2eN5FDoLemdOdZTlf0x9mv9YT
 2X2qRzSnKN1lSUFbjm8FsnZLZQB0ScS9rYPiBMA5c9pdTZn2xOVHx0QpOARfiVaY6OX59SEi3Jo
 8YKUxdWpv
X-Gm-Gg: ASbGncvICS+po8ZK4f1ve4IAqkz70p7T9LVMSVY05KgZBsWesWYVUxWSsi47jrTLJxp
 ct/LdpJeQOgnEWWGexYfvPJ/urQ+MZAQWcyQuxZG5hRxoZP+H4eEnqX/5woPlHDnJUuYFeZreaz
 A9rvruoJzmKM5Y4sM42gr1RquPBg6misO59pLkwVvAStcQWpA8bGtUb3XKSFNQ83XWuElBFWPJ4
 4/Z5NDoBC7eU0CiKLYNOz8P9jpqH4YABcRMFgPDvkwia+V7T5FqMuDXP28EkC7o
X-Google-Smtp-Source: AGHT+IHTabqk9XfY2F1Hg2S4q9hkUEiti58oUoecZnbZxt8jYRhcbgA1BfWl6ZfG0eVePqf9Ii0z2w==
X-Received: by 2002:a05:6830:6e18:b0:718:9b8b:429d with SMTP id
 46e09a7af769-71e3b816757mr2008706a34.4.1734116938397; 
 Fri, 13 Dec 2024 11:08:58 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH 17/71] hw/avr: Constify all Property
Date: Fri, 13 Dec 2024 13:06:51 -0600
Message-ID: <20241213190750.2513964-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/avr/atmega.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index 31c8992d75..ce630ec572 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -355,7 +355,7 @@ static void atmega_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("avr-eeprom",       OFFSET_DATA + 0x03f, 3);
 }
 
-static Property atmega_props[] = {
+static const Property atmega_props[] = {
     DEFINE_PROP_UINT64("xtal-frequency-hz", AtmegaMcuState,
                        xtal_freq_hz, 0),
     DEFINE_PROP_END_OF_LIST()
-- 
2.43.0


