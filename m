Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1EDE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E19-0003R1-9a; Sat, 02 Nov 2024 09:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E12-0003HT-DD; Sat, 02 Nov 2024 09:18:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E10-00023w-UV; Sat, 02 Nov 2024 09:18:08 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a2cdc6f0cso397994866b.2; 
 Sat, 02 Nov 2024 06:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553484; x=1731158284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKFAh2MnjhZ1jF0dRDKV/YEAdE5+3y61mz+4DueAPJw=;
 b=SiSuRbGeGOC6u73/z7BYM9M2rPX2PsrI7EuocAZEdiJDF/T0/o+3BroTh7OZ5yvV7D
 /D7ZK6TOKsJczmG/3ufGv/1DJbb1IdW+XqgsB9Z+1RVD66AC5W1lnUVXAnxKXf9nhlRc
 D8HnbUJlRa5B4KJiW/RkqRFM/ZPe/ghhWEFfzFffYq/wCrMNYNmOgarPtMT2CZj3tjkH
 0Ku7dF0QQY6MHrZ6/WwTrPazlOEb+u8+Yiu5YYr5AlxXauBmaVtOoFgeu0Mjm4b6eXGL
 7Ydp/GdCkZMEC5PNQP7Ja7DA1cZAsD8jm/ihAqd3zQtRtY0qHXacGY1rHjZWtAW1Uh0m
 /N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553484; x=1731158284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKFAh2MnjhZ1jF0dRDKV/YEAdE5+3y61mz+4DueAPJw=;
 b=D8jZE2fUmIKsc3Cp1GbRfP31SQZd9pPacPYsW1H7YZ1LNsnD4OUksaVJidqsbZ+mRL
 dAnFvBjRwbpgnDhf0g+sWbNXootLMfABlkrB9Vc8tdNjfc9KnYAQHYCVrv1ZQX9Gds8J
 Yny5TAsvVZS75VtYxdZH8jqAsF7OZ2eYH0iwC40Zt0L1hCJ+t64h6/xGzCAppGkMs3Qg
 FbhRLBv2xKo4iPjW5WDFbvOUuvo01+38KBB43A3spprDtSdgoQ1lGGvyG8KdYFQnT/r1
 KE/ADQW2mRbnozlHJ3RUKKmba9qkI3tz6rLDi2NmJgsLx7kwUwoZEVc8JSS5CioXz60M
 SaAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkGBgOS65DCYgo0Hh3Ge49733ir4TohIBFEkzKZUjWT/IUyDhwjoMmG6aZyJsStyqnx1LZHrhDqNg=@nongnu.org,
 AJvYcCWLxU8RmY690kDOCtwJDwG9CU944Uegdggfxx2dtJmT4XOLLEanDmWpxegETmV9G4oj+bERB8scrum7@nongnu.org
X-Gm-Message-State: AOJu0YxAVC5Tayt08LeF8L/ne+IVM1Kuo9FF7eRL6K8BtDTooFH+z8mD
 24+Pg+tyrAfhjWk6mki6WHTk0Lhu0mdfdepd8kG+ffQCFOcq0mDYoKi7nw==
X-Google-Smtp-Source: AGHT+IFYwWYuRSHPcE/X4S/cTrh8u2hOfrffeR3dINDkdm1bHtWiGVWbKE6vZGcEzjkGcVuzykYvdA==
X-Received: by 2002:a17:907:9706:b0:a9a:5004:cecf with SMTP id
 a640c23a62f3a-a9e5089f85fmr965614866b.9.1730553484389; 
 Sat, 02 Nov 2024 06:18:04 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:18:04 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v3 26/26] MAINTAINERS: Add hw/gpio/gpio_pwr.c
Date: Sat,  2 Nov 2024 14:17:15 +0100
Message-ID: <20241102131715.548849-27-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

The device is only used in the ARM virt machine and designed to be used on top
of pl061 for use cases such as ARM Trusted Firmware. Add it to the same section
as hw/gpio/pl061.c.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8f39aeb6f..5dd35f87ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -651,6 +651,7 @@ F: hw/display/pl110*
 F: hw/dma/pl080.c
 F: include/hw/dma/pl080.h
 F: hw/dma/pl330.c
+F: hw/gpio/gpio_pwr.c
 F: hw/gpio/pl061.c
 F: hw/input/pl050.c
 F: include/hw/input/pl050.h
-- 
2.47.0


