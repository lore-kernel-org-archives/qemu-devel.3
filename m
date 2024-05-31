Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAE2C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zd-0004KT-Bt; Fri, 31 May 2024 08:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zV-0004Ir-Q0
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:14 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zQ-0003OR-Ol
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-420180b5838so13348715e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157045; x=1717761845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iToqgJBir2tKfGUgEzI3mc84Rqmrk6uHFx118L//EbU=;
 b=k9aG1sxEfuBArdQ5KOWSWdJQbhl5CiSkL+i1z9YXb9/rE6tpzN8LmXK2F1b7bK65RB
 HXxETFdi45OXE1Vnfj46MSkjcLT8tY/ZjX1fB+AXeu82fXZW0H/53BpHi5D6s0F+jRu/
 UAWonD+/RVn1cPDq9YN9luQbCUBb3l4a9eQuvaX0KsKg8whbG8+DPkupAwk5G3axoclV
 qr/G5ifMlsqcq+NJDO1JQRETwIm5/h8WDfBEpIFR430uNxl7TijnKc3JMQHg+Fi/LrCe
 5nF9nK1R9v4LvHosfjwwZICE3TvCKxHg4KAQznrPmHagQzIa5ukQeqWvS1Ceao8P/fg8
 hD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157045; x=1717761845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iToqgJBir2tKfGUgEzI3mc84Rqmrk6uHFx118L//EbU=;
 b=VGPSRFzGZum2ODzlR6iHcgiyffukQFsn0StLz3PbvDapfA1rM1VTpYbH7sznTqZbVi
 WOvBcslWFfhnlAnN5YtW0bOY0wiA5NLpxWmWtvV4YnaevjnufNvx34FHRZGLe+iTDHqe
 PKbOUoleGrcZZPyXj5LmZWfFB6tZKr/r+ttxouESvtYXw74b94jLjFSYxs19488gBt4n
 rnGSQjONq9CQPg3C2Rn7jX07I2hhHiglFAef6HFpo/zZj6uCp6b5K/T8ZPtsdWW7GPEZ
 G1I15fvO9HBaZRldq60jFuVWD4CoAclyQi7Rn0wddpWmXSdvK60JsKK/EdGR5tvVYigX
 sP9Q==
X-Gm-Message-State: AOJu0Yz3h8tGHpScbjAoh5ujtyGzrNyck9MM/tj8ou+QdjZ1C4SiHqYu
 gHFECa3A1iD3yJYTeyxa6M1hFTmcNN0a1Yn/Cio49poAL6v4OSyJFHMW7/u5Gp2253XL4N8lLFN
 y
X-Google-Smtp-Source: AGHT+IE2cjSBhxmmOSjgyf9Ks8g4esvSDitDLGqconC7C+Smh9BjEyoVF+twv7cu4ujz0gSgHtWHmg==
X-Received: by 2002:a05:600c:19c9:b0:41c:12c:aaa2 with SMTP id
 5b1f17b1804b1-4212e0c03d9mr13752675e9.33.1717157044596; 
 Fri, 31 May 2024 05:04:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/43] hw/intc/arm_gic: Fix set pending of PPIs
Date: Fri, 31 May 2024 13:03:19 +0100
Message-Id: <20240531120401.394550-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

According to the GICv2 specification section 4.3.7, "Interrupt Set-Pending
Registers, GICD_ISPENDRn":

"In a multiprocessor implementation, GICD_ISPENDR0 is banked for each connected
processor. This register holds the Set-pending bits for interrupts 0-31."

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Message-id: 20240524113256.8102-2-sebastian.huber@embedded-brains.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index e4b8437f8b8..04e5a11660c 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1308,12 +1308,15 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
 
         for (i = 0; i < 8; i++) {
             if (value & (1 << i)) {
+                int mask = (irq < GIC_INTERNAL) ? (1 << cpu)
+                                                : GIC_DIST_TARGET(irq + i);
+
                 if (s->security_extn && !attrs.secure &&
                     !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
                     continue; /* Ignore Non-secure access of Group0 IRQ */
                 }
 
-                GIC_DIST_SET_PENDING(irq + i, GIC_DIST_TARGET(irq + i));
+                GIC_DIST_SET_PENDING(irq + i, mask);
             }
         }
     } else if (offset < 0x300) {
-- 
2.34.1


