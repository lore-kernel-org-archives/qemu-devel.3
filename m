Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6037FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80b-0003Ok-4q; Fri, 13 Sep 2024 11:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp809-000299-Tk
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp807-0007nj-E4
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb806623eso20966345e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240462; x=1726845262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dcqXMxLjwWlPP6O8WmHKBKl3hhhcbk38Qfnbk5uacwc=;
 b=koen2+tUovz6PKNMtguqFw/H7i7YfxdJuEE/KFGDMlqerTvrtntFOtMK7SC0/2DeoH
 ZBlWHv7NvpbnbEgurIGvbOoVHEpD8OAKEnbqFJLQxY23tzP36wXPukM5fdlMxO9oeELS
 O2MdnLIvp+gZmBfo6eDUc3WvQinkatJWr1CumBlTWeJ5zYZlYLbGXocRvzXKhX3ifRXV
 0Nk1JQeHALBec39YFDRZZqYkKQ5Ju8WZkIaDVlfx9yefKFysPgUJlAWayeuWYSZdqYlA
 gRtML1LgGE48x8cy90LnetTTchMGdmhwlbx6pwN+aTSIk5dpFZsWxCcwtlCNMiCvFQij
 Nd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240462; x=1726845262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcqXMxLjwWlPP6O8WmHKBKl3hhhcbk38Qfnbk5uacwc=;
 b=f48eqFy4O0HV3PztRuxvVdP8MBvY55ExZITGVX6KmFBhHEbT1MajCtMS7VegcXdY0W
 jh0xisrjh6WCfRcZ0bkOJ0XWHbcG1gs/Fk0dB9rzDuyan7uIlNcjXo9/F8I2M2Yg4IUW
 VOtbLMJR+P3YUjUkDevK+87lukJutnIWzPzJNhCDnBOHIZXBOzmMlvUo/NgAeq1kISJr
 a1uhLovBiXbSDr/L2SUs4VL4e7Vnt/Fm8Dte4gfPInkpvwrTXtCItRQcWAO1CQ6Kk7DN
 wH+2SlFkoaEPTzbuVHHepPxPyoHX20gDzflkcc/gQCx4j6MzRshpviQghDRBMtm2OIe3
 Iqdw==
X-Gm-Message-State: AOJu0Yy+PB7isTiQBpnvhZCzZVzvhNnBMgvkjTePRRaH6Wx/vrJ07d6v
 DCubIEgUeizZfL5/Aho/J94pEPa3EQ39bqhq/4PTSZoTrG1KQZSmgJzGmF7HlPuAIzJxDdYwO74
 1
X-Google-Smtp-Source: AGHT+IGNHCfGwidw6zlDXf7OlsNh4WrTDGhpS6PdDMI5XdpKJgBbN5rbEqsSgoYYe2zB66Atu7jqxg==
X-Received: by 2002:a05:600c:1c1a:b0:42c:b037:5f9d with SMTP id
 5b1f17b1804b1-42cdb4e6a7bmr57568285e9.3.1726240461998; 
 Fri, 13 Sep 2024 08:14:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/27] hw/net/can/xlnx-versal-canfd: Fix interrupt level
Date: Fri, 13 Sep 2024 16:14:01 +0100
Message-Id: <20240913151411.2167922-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Doug Brown <doug@schmorgal.com>

The interrupt level should be 0 or 1. The existing code was using the
interrupt flags to determine the level. In the only machine currently
supported (xlnx-versal-virt), the GICv3 was masking off all bits except
bit 0 when applying it, resulting in the IRQ never being delivered.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Message-id: 20240827034927.66659-2-doug@schmorgal.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index b30edb83bf8..f89dfc565b5 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -682,8 +682,8 @@ static uint8_t canfd_dlc_array[8] = {8, 12, 16, 20, 24, 32, 48, 64};
 
 static void canfd_update_irq(XlnxVersalCANFDState *s)
 {
-    unsigned int irq = s->regs[R_INTERRUPT_STATUS_REGISTER] &
-                        s->regs[R_INTERRUPT_ENABLE_REGISTER];
+    const bool irq = (s->regs[R_INTERRUPT_STATUS_REGISTER] &
+                      s->regs[R_INTERRUPT_ENABLE_REGISTER]) != 0;
     g_autofree char *path = object_get_canonical_path(OBJECT(s));
 
     /* RX watermark interrupts. */
-- 
2.34.1


