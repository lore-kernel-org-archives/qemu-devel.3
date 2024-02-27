Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1171CC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaU-0000mR-3y; Tue, 27 Feb 2024 08:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaG-0000iR-Uc
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:25 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaB-0002ps-I3
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:24 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ddebaf810so959238f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040798; x=1709645598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kMD34DyY/ZeshF/T8UgjYoZ3X8l62qcwB00+lmo6Dxg=;
 b=W7wBwB57cKwhUnYBCPkkBhW+n6NlCVzuyctRhBlYKsaOUw4QVLVIN5TzSl5ij8pZtF
 EYosPDW4kmVZooqShY1ac7tuA0ynqrLPFQSLZ/rvOh863OtIbeCGjhBZFP0Af6WT8PvK
 iWe0gwNZtlP9Cw3JIvWbvG9irL0awaqtm1G1z8C0Z/5XtkfFRKNUy6pfsFoAZZbfaPiA
 6gaV2rDws0HNMilvB2TQmZENDEyd4/h7aEiMFqqO2Y9K8IA5mGHIbS7/ey7LkhyvaAlB
 fr5Lv2xb/ZEX/+xjfN/8+Fq2y8p87HXlPFopWP/wvN8FqSSBbPrZnOV0KL9fpAiFbrSe
 ucTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040798; x=1709645598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMD34DyY/ZeshF/T8UgjYoZ3X8l62qcwB00+lmo6Dxg=;
 b=T7dZQWEIt6/WgfNDk9WkF38wAAKE8Blg6wHSn66sUmNL+gzc6A3kutXWIjPsk9d9SM
 pwuxA7HtedvA3ROaWF8+kl3V6tFi1IeMwbNCEssSzkRfSYfpjTdpXOC8T+6FN5gOFpVU
 knun/iNJIth2pOlPpiT4d5AtS93zk0uHF91rzufQiINYMbkMSPHbqljJgpUtwWBfeAgg
 SZPmW18NtAoKqw/lHzbgCGqGsMjG4PH+hHfKaEGtPTHEKumD/jqXb1HBQfc2MMCWsXgB
 ovyPbVnt6lnTnU7B5oNcy9QaawdQzUL9PUIMbcOcSO9tBQyZP5NSNG/0qYGaE8O1Keqj
 mObg==
X-Gm-Message-State: AOJu0Yy3f1SYEMdrkAGfJvdBjwc4TSD8aQK+sB3Ne8m/LTtIs5fQJR+B
 MJGRlxxLpp/DfZnY1PYlWgHgiCbXWr0pYcrr+mhMFrrJvsCR4tcaUtKMTmpVsW3brD0a5SrxNhn
 e
X-Google-Smtp-Source: AGHT+IHjbiuYdtu3lygV/5G9omkcvmGC3JIbKCRPobvNyMaMYyl/Ov1L/WZa9RNA+jeFebYEfiQ4Rg==
X-Received: by 2002:a5d:658b:0:b0:33d:2848:79b6 with SMTP id
 q11-20020a5d658b000000b0033d284879b6mr7204218wru.45.1709040798218; 
 Tue, 27 Feb 2024 05:33:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/45] misc: m48t59: replace qemu_system_reset_request() call
 with watchdog_perform_action()
Date: Tue, 27 Feb 2024 13:32:33 +0000
Message-Id: <20240227133314.1721857-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Abhiram Tilak <atp.exp@gmail.com>

A few watchdog devices use qemu_system_reset_request(). This is not ideal since
behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
to reset when a watchdog timer expires, let watchdog_perform_action() decide
what to do.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2124
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
Message-id: 20240216192612.30838-4-atp.exp@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/rtc/m48t59.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index aa44c4b20c4..1585a2d3997 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -36,6 +36,7 @@
 #include "qemu/bcd.h"
 #include "qemu/module.h"
 #include "trace.h"
+#include "sysemu/watchdog.h"
 
 #include "m48t59-internal.h"
 #include "migration/vmstate.h"
@@ -163,8 +164,7 @@ static void watchdog_cb (void *opaque)
     if (NVRAM->buffer[0x1FF7] & 0x80) {
         NVRAM->buffer[0x1FF7] = 0x00;
         NVRAM->buffer[0x1FFC] &= ~0x40;
-        /* May it be a hw CPU Reset instead ? */
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        watchdog_perform_action();
     } else {
         qemu_set_irq(NVRAM->IRQ, 1);
         qemu_set_irq(NVRAM->IRQ, 0);
-- 
2.34.1


