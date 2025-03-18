Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7D6C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWil-0001Ns-98; Tue, 18 Mar 2025 09:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiY-0000Ar-D1; Tue, 18 Mar 2025 09:10:50 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiW-0003ho-Fs; Tue, 18 Mar 2025 09:10:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5b572e45cso10726380a12.0; 
 Tue, 18 Mar 2025 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303445; x=1742908245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAclm7ArIW59Xy/Sq2KiOGinq6EwwyMSaziuoXbOUS4=;
 b=aMoolKBGETVk2owJzWNIg6mFLZ9ppED7QK+4Cvrmpai16o2WprXEuZNqapp3OLiMig
 jxZP6AMBUttPnReLvFPHGFO95UwYxmZ2CEUyrLk4ugMoigMkvvnCvsQrjQ2nWLYkOgu/
 T0aJAmAn1joxIeWL7ig9s+2GZnYaYNlqKPCWAJ5AforIl/DE+SSxVbMDoQdFeOMRkzXU
 VlKDfqPXRb18EsuXJ6AbVGOk22lKzerrw+NWIkbIyjzAP/ch1GhiPf/kFfEUUzxGC90E
 qB8xVazrtvMYaldN++hX+lPGoGGg34ITTpfk5TH6ntDmPaKbH672Dlb4+rfgwwvNdFUY
 kM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303445; x=1742908245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAclm7ArIW59Xy/Sq2KiOGinq6EwwyMSaziuoXbOUS4=;
 b=r1pEcMCTHWchQ5/sh/xTXA2rQZjK98J5nEJfLlgChhCrDh+IzDAm+lDS0yzSNizD7T
 icDOoBsiKhzYQYypGMzOxZ0jsDZCwybaLo/u338vmTGMH2uBrQEZfyb5PEUt+cNSPOB4
 Ao1X04HM//HUxtNZbU9OCFMr1TKdhYQHNyja1Bk72gLkj1XaYiqUeWiGyDZKwIR2TECK
 uIZexFNESHJmfG0WEli0h1femrxHqA58XxOH1PruyaJeKZ776+9DCnXo6kX9DgiFJYUp
 PHnbwqprOhM9ZDc5IFxlXtG2Cy0vJvmyhuWDJfAhHCHK5w98aV/4Aw7gpE3IxO21Nh9P
 Bm4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqG4oUJIglqDLyyf6WcjRInw08qN9afBcJ2lqHLB7QCBZrCEXw+uoMW7ZWh4xcVyiqUFykx2sOcg==@nongnu.org
X-Gm-Message-State: AOJu0Yxo+V2iR8QX3PMXlqTM/aFghfBmWD3EOAjG24JvN2Wu1w6qq3Gw
 BRug2cr2ZiD3I5oFcGm2BuRFQg6QDN6VW/7ONmcRoX4IrpUqwaLHH/mPmGHj
X-Gm-Gg: ASbGncsC1iITHJipGNXkqbEqJHOAWMbGOiLy1kc/VZdjk3OVckFhOtp2AvYDzQZEdgU
 tHgxqLTnRtV1mPV7N2urSwAISFQc8kSCjuz1QNTsMhuufIXH11L7H1Xdxlt5pWc2x3AFyjaZHeo
 sr0a6EM55lGzt/IgtdNX4EBqQq6EU421T6KjmXQ3OOUWjqBmsVHY3z8qiLwdvmM0Efq/M8K9VEa
 8LsSq09RZPvdA+QAOVqVTy1Mzw3NsPqt8XPEveaG6R0ih+hKVjfliAOMilEpgsI85uzI9OcOHak
 1TzHtM47EUywmQYujPZu5tqtg2XEHCtoCWiGC4GGEdIohA9//dw+aEFy5C16cYUz5VI=
X-Google-Smtp-Source: AGHT+IEurEGe5xm5apxv19GIinDvN0XWKNZYuodTsHhOeJ0W9fyNWY1zJm0wgZquoe44UHYaqKwSNQ==
X-Received: by 2002:a17:906:6a0a:b0:ac1:dc6d:af30 with SMTP id
 a640c23a62f3a-ac330397d6emr1953535666b.39.1742303431629; 
 Tue, 18 Mar 2025 06:10:31 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:10:27 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 07/21] hw/dma/zynq-devcfg: Indicate power-up status of PL
Date: Tue, 18 Mar 2025 14:07:58 +0100
Message-ID: <20250318130817.119636-8-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ed1-x52d.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

It is assumed, that the programmable logic (PL) is always powered
during emulation. Therefor the PCFG_POR_B bit in the MCTRL register
is set.

This commit is necessary for the Beckhoff CX7200 board emulation
that has a FPGA implemented in the PL.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index c44b802b22..c595d090fa 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -339,7 +339,7 @@ static const RegisterAccessInfo xlnx_zynq_devcfg_regs_info[] = {
        /* Silicon 3.0 for version field, the mysterious reserved bit 23
         * and QEMU platform identifier.
         */
-       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | R_MCTRL_QEMU_MASK,
+       .reset = 0x2 << R_MCTRL_PS_VERSION_SHIFT | 1 << 23 | 1 << R_MCTRL_PCFG_POR_B_SHIFT | R_MCTRL_QEMU_MASK,
        .ro = ~R_MCTRL_INT_PCAP_LPBK_MASK,
        .rsvd = 0x00f00303,
     },
-- 
2.49.0


