Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFE5CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMU7-0005zw-2H; Mon, 27 Oct 2025 08:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTz-0005n2-Am
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMTu-0006Oc-CG
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:37:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47103b6058fso33829755e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568666; x=1762173466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLGA4BsveaP6QGp7KSxxzZDoWLl4mtX/E9pHps71OHg=;
 b=oHzeYdLaXXzFGswXXYIhMH4p6KGLuGHQc51b6py1XKgHxw62yVlkmcMaZDM72hZRyi
 x+ccgFSDmReMlGk5Kd0kyA+9w9KF4lulL4x/yuK2D/SaNw5j+oucfof4ddrw5IgAkfbK
 jOze+XS2A99PmR6GQXJQm1tbgyvhkY5GjtvhxxVigi0HONKUboJxcR2Krqy/kM3EFpue
 q3sHNyQjdMMwqbUc0rByY2UzRBH56ac3ElE9ZF2hcI56Xv9UVrMrJBBFE2UYASS2eUok
 LGe7aOWukLW583IuFpBm4M91+bZwKTRHMzCcNknciSFwBlKjSVA866ga7UsWyr6KBf+y
 vO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568666; x=1762173466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLGA4BsveaP6QGp7KSxxzZDoWLl4mtX/E9pHps71OHg=;
 b=UB4916HeZmrZzrrpsEmjoSX3uZgyiUx6WOAgmaE3imAfq05AJyz567uoC3XgkkfE/y
 Ob4VBI4CWZekLQJte5235YKv/GLwFcEO0LpWunFZYcLhjYwwpCFkbIswYX6/eLQz0Bt8
 Le1W8qcyQSPNk3UOeMFVMDRsGtPmjKF9fZIn1iLGskflx57mV9TvvV5f9PeMQZgON+Pt
 wh/Hyhq00+jH4EmxthBcSdS1lVobE3FIvW1tPT7c1ef+KIBp9oDetU5Z/xViKPgYhgUJ
 5rEKIgbhSsy9TbCKMx/y7WObV1RHEEbp3DuL7MzUSstKcmOr0shplt8H/kEDzzDCpnDe
 SqAQ==
X-Gm-Message-State: AOJu0YwSe5PpM3T183cGMcJlgpSlPRnGTH1WNn2sD7cmCttimQizna0X
 63qu2FJ84B6pUjv61gxs4PMKdv99SUX3jusTOkrquXe/JXt/4Cr8Ruooju6VPNmYmdr9dt2kPhN
 jPiSMvwM=
X-Gm-Gg: ASbGncvlWyQgdubijTmFy/USY8eJyryZDsnHXuP4kvakHeB2ubw2xzXoXczqXDxvKSr
 xKHXPXpb4+ZCWZ/mqrImhjaPl+9GfuCBAjqIhF6Dov97S470ua/b4SClk/rdiQOMsJDxw46GL4j
 hQjN+a047HnCJtaWgsaBMB2q5kf63tIC+SLWRg4uowvUUbDWIyjxmMBH6kJkqMqNDiJDZ/7xf/+
 3AsXxmEZDWAoQU26JKrUms+ENlrpVSknf0YtbVIAJPlT/ibI9ERo+uEu3msAkuT7ps+1yCuBNmw
 jfHgF07/jFpvr0XYHjTveHIgBN42cOJ264DVIS2XVtJmAhrHsxjwUvlkKY1YzhzMsCu+V5Qcy3P
 rjPwiuUko12iTApgYxObN8wckqHwacESprGta+4fwZY59jJnJKxFqxlHd3IDsDKkSqcCNvG4iaD
 UPn81vHtWea7l6nLSrtSOmw4eKX5H+X5sEmxLXP2iTwc+CsFpVOA==
X-Google-Smtp-Source: AGHT+IHEsjQBidUqbm9SoVcLKCL74wb4/k68vdtmPYN/0xVUIfQZ2HSuA5jHkEqMEWb8ETCTTqVW+g==
X-Received: by 2002:a05:600d:4301:b0:475:de75:84c6 with SMTP id
 5b1f17b1804b1-475de75857amr35815515e9.12.1761568666613; 
 Mon, 27 Oct 2025 05:37:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd4e30f5sm135384175e9.17.2025.10.27.05.37.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Oct 2025 05:37:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Peter Xu <peterx@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH 5/6] hw/pci-host/astro: Log unassigned MMIO accesses with
 unassigned_mem_ops
Date: Mon, 27 Oct 2025 13:36:42 +0100
Message-ID: <20251027123644.63487-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027123644.63487-1-philmd@linaro.org>
References: <20251027123644.63487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Replace unassigned_io_ops -> unassigned_mem_ops to log
accesses as MMIO ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/astro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index 1024ede7b68..0bd66ab3de3 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -449,7 +449,7 @@ static void elroy_pcihost_realize(DeviceState *dev, Error **errp)
 
     /* Elroy PCI bus memory.  */
     memory_region_init(&s->pci_mmio, obj, "pci-mmio", UINT64_MAX);
-    memory_region_init_io(&s->pci_io, obj, &unassigned_io_ops, obj,
+    memory_region_init_io(&s->pci_io, obj, &unassigned_mem_ops, obj,
                             "pci-isa-mmio",
                             ((uint32_t) IOS_DIST_BASE_SIZE) / ROPES_PER_IOC);
 
-- 
2.51.0


