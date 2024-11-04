Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772B5D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7koe-00077y-RQ; Sun, 03 Nov 2024 19:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7koc-00076W-QK; Sun, 03 Nov 2024 19:19:30 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kob-0002FM-7i; Sun, 03 Nov 2024 19:19:30 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-720d01caa66so1916223b3a.2; 
 Sun, 03 Nov 2024 16:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679567; x=1731284367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZ1z/XmFIN2JVjOsuU+EgbLKz3lUKwqpU7/B+luzQLU=;
 b=hYCnW4LUR8ie6C60ZRK/idHEya/dYjZl179kDNnWaSd0hSS6IZWdKb+gS9k+o3izni
 OGW5EZUQayS1EJKni2A8ePE0G4Bx0lCM8g7WUNPYc14+7MjU6BjyJkf+6IqoxEjj0pR8
 7qDOmeXzWuzdt+aRSwg0XyqZBF0S/Asex1S5KI0nxM84XpDCemG2re9UsjfPGh/yGf2S
 IZRbFCROVuemkhegL2Ji0SA6v+5OJd+MvXxphfK0uwtcaskUo5TL/frevFUxAPnDnwEl
 dFyvfTzUFR6lWGtlkAu+loU4sAr1Xal8cicsZKE96GY33ALPKVnVxqKXuKjSFgIVvT9B
 tn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679567; x=1731284367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QZ1z/XmFIN2JVjOsuU+EgbLKz3lUKwqpU7/B+luzQLU=;
 b=oTwtg3uNfwBx4nXadCg5vwYB7XCpw6P9HX70Ju/VgyPCmxqhwctwrflQiqdzx+Qorx
 /JckGq2STTpJXQPd7fjVO3SwjoHOjxWtQZps65W0MdVkUMLBOXKlzkB6odu91Xb3P4vF
 Ds1lkQHig852MQgRCYGtt+YAH0yPNraKNYS5j43tTeM0BdC4wqUucn0zGk3IXZq0ziY7
 3aWzFNZvMERlGZKDjdZ8hWhT51EsgNz3utOtinKFM7CJRHAoknPvhIc6d6GpiPPb14Ud
 bZt2rld3+YaeQ7kuABUD5I516NmwCYyahqTvR1pK9ktMJVzmT0AzdhagKg4xjqbGFbCJ
 ZxKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxDT4P9p28FbSq9Ur7woVGyJGzkd2RFwefDkUR2CXK0uY/u8WRnTrtnaneu1MXzutrw3jXdn4AfhRfL9I=@nongnu.org,
 AJvYcCVEI2qTDKH7LyXIfJtMcn26p/TBAxhd9NfiBNkkROhBTqD7dKV73AyIHnFX0WCLwACnJVbET99i+Q==@nongnu.org
X-Gm-Message-State: AOJu0YxS2b88pFQLU2JbexeGWvloiqow/rnMLiRKDxSSE0qKnu1YmlEc
 E5n/9on6OYhRmsBKD7Qvjk6CED2FZtj+hG5K14TUZdQ+cHPwkgD9aR+Abw==
X-Google-Smtp-Source: AGHT+IGoI4wHUNYirAtppX4AkD8+OrBlgOIJMJhZDWn8oidp5uGWB8yW3rmgzgOu4Q0zWyYPS/WLZg==
X-Received: by 2002:a05:6a20:a10b:b0:1db:dce8:c26f with SMTP id
 adf61e73a8af0-1dbdce8c29emr1648643637.33.1730679566857; 
 Sun, 03 Nov 2024 16:19:26 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:19:26 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-stable@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/67] ppc/pnv: Fix LPC POWER8 register sanity check
Date: Mon,  4 Nov 2024 10:17:53 +1000
Message-ID: <20241104001900.682660-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

POWER8 does not have the ISA IRQ -> SERIRQ routing system of later
CPUs, instead all ISA IRQs are sent to the CPU via a single PSI
interrupt. There is a sanity check in the POWER8 case to ensure the
routing bits have not been set, because that would indicate a
programming error.

Those bits were incorrectly specified because of ppc bit numbering
fun. Coverity detected this as an always-zero expression.

Cc: qemu-stable@nongnu.org
Reported-by: Cédric Le Goater <clg@redhat.com>
Resolves: Coverity CID 1558829 (partially)
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_lpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 80b79dfbbc..8c203d2059 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -427,8 +427,8 @@ static void pnv_lpc_eval_serirq_routes(PnvLpcController *lpc)
     int irq;
 
     if (!lpc->psi_has_serirq) {
-        if ((lpc->opb_irq_route0 & PPC_BITMASK(8, 13)) ||
-            (lpc->opb_irq_route1 & PPC_BITMASK(4, 31))) {
+        if ((lpc->opb_irq_route0 & PPC_BITMASK32(8, 13)) ||
+            (lpc->opb_irq_route1 & PPC_BITMASK32(4, 31))) {
             qemu_log_mask(LOG_GUEST_ERROR,
                 "OPB: setting serirq routing on POWER8 system, ignoring.\n");
         }
-- 
2.45.2


