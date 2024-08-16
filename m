Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683B8C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1X2-0004LI-TI; Fri, 16 Aug 2024 14:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwe-0003GX-FR
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:56 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwZ-0002KG-7h
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:56 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2d3ed48c748so159303a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1723826210; x=1724431010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hpykp3v3nUS3no6XDt2FDZxaHDZOI6A5wRB8LlJUTdQ=;
 b=VqjC/92pQ54Pj0Mzn0kzAxfEQ8vMZgqMoxKEGM8NHas1Te9LJ782Jc26Iit+mpCJlw
 NZXlzFdsEu9FZBxeLWOC67oHdI/Hc9N/it/e45W/oEC5OyfN9qzbHio+55WheMWVo5og
 IU6eJu6OTJbcn+S0/0+brYUdc8Pl9vMNnwbYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826210; x=1724431010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hpykp3v3nUS3no6XDt2FDZxaHDZOI6A5wRB8LlJUTdQ=;
 b=NgiopPYQOz4Y1EutX65XKzKXwP7hSD/gqVecXZrC6ehQMo9ck334vleFacT2VCc4np
 I663NNIefw8hrr8SUNWLVgSrxfVFip/U09jd5Ee3ZaQ8wBlkyW8iTmmozpWRgSIOqJgb
 rVv5a9HPoJ8fbvxkgX4ty6U8CeL4qxNLp5AvOSJexuTHSTWIGnPFgDuYOLKoM2O80Cm/
 BSueFj2DwUwqYtCT/3Bjw9uy4Z+9YtrhvF/Ccjy2RJSf3xniDGC3WVclvaueFmzs3Qzj
 Ct//S6DGdIZN94CB4Zs5woz5m0BHkd7nVGWHz6yLLzXvdMEYfg05SDDHhAUsIUGp5QxE
 UMHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRAc+mgtRjqTKiMzyvnx1SKwdv15StKeT13t4L9Ny5ZdDUsffsjLpbJC6ZSpiZiKWs6jpT8uWWkVxL@nongnu.org
X-Gm-Message-State: AOJu0YzrcMhB7JZCTsJiIPhhkSZChZFaULzVC9csD7XCFd5QmWvAevVI
 TfUWiy/GAhjm4D+NZGrPeZDfe/VOUE7XNWsjnCXDMxugtWfzPXdfm8f0CmGg1UE=
X-Google-Smtp-Source: AGHT+IHtue1ofcS5v4Hx4+pAt9Dw9ZXebnre/TFnx2PeOqt8lj0qBsytmNORWwtiXFPBgWyZLAcGKg==
X-Received: by 2002:a17:90a:ad83:b0:2cd:1e0d:a4c8 with SMTP id
 98e67ed59e1d1-2d3e02ebd87mr2208763a91.3.1723826209538; 
 Fri, 16 Aug 2024 09:36:49 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2e6b201sm2134285a91.15.2024.08.16.09.36.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:36:49 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Doug Brown <doug@schmorgal.com>
Subject: [PATCH 1/5] hw/net/can/xlnx-versal-canfd: Fix interrupt level
Date: Fri, 16 Aug 2024 09:35:01 -0700
Message-Id: <20240816163504.789393-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816163504.789393-1-doug@schmorgal.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 14:18:34 -0400
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

The interrupt level should be 0 or 1. The existing code was using the
interrupt flags to determine the level. In the only machine currently
supported (xlnx-versal-virt), the GICv3 was masking off all bits except
bit 0 when applying it, resulting in the IRQ never being delivered.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 5f083c21e9..ad0c4da3c8 100644
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


