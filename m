Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDDAC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinEI-0004vW-Qq; Mon, 26 Aug 2024 23:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEG-0004uU-HW
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:48 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEE-0003pi-WB
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-204d391f53bso12762775ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724730645; x=1725335445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHA6cw5duNChzRkisU1kblSnuYm9RTmHim2/vThBDEc=;
 b=chVk0xlDvyOdOmUlRvCGIJXwixDR0Ny6fdDNB71mY0BFLDIJlVMcHCGM/ntq3Lt37E
 enbaCWcXTDw66OYp1Gn1dzmZBwi1MaSOUmrZWkhnQFDeW2MLenZgPnYGxrHlrmVwHwQn
 vkfcQVGp2bKBhJ1mSmop1ArhhZdSqoOBZ8g2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730645; x=1725335445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHA6cw5duNChzRkisU1kblSnuYm9RTmHim2/vThBDEc=;
 b=YLYYg2AeEc/vbOxd2BrrUjv27d6O5PpLCzmosQ/kGMPRw7NT7vhhGHwdcC8PZ68iQk
 pkQvBMdlDuVwYSb+GTw5APbExqBLTJIte7j1H7DAyuqLKHWo6Lykw0CMgCACbv83r5oi
 qJthlMkvcTdrb9b8IzoeLCLLshkM8QIf2Rw++pKgtoypf2bUzrgHHrcq+/qYRrfJhJii
 h6MqHgmOpBoqmp7CKki8yHZP1gLcIorqgBiS1Qh2e5c2W5XNaWOSNw3c73Wz/q5nLxtz
 AVo3KA/YF47b3U0rnV5xsTxWqs2O7bg4Wii0Qy2UxRuNcJBFuGQqLI4ASGMFV6BGKCuw
 j9sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvu5yF6tFYJtTQ4f/bFWuB7cypJvlU9K3Bea3cpKMYM+ZEux4O1kV2BjEwiXGQfRb3c8BX+/Muu/JK@nongnu.org
X-Gm-Message-State: AOJu0YxDBUUHLtp5YpxYeETPSNDx7++yTexu4330SCNh5CRGcIiUUKbL
 rFLKvej+BEZajhHTpEY1ULc/T9VIFXDSteNUi1zzzubDZd5SYW8qREtcYTVs8VfcRTg9ZrWOSKW
 2PLmSVQ==
X-Google-Smtp-Source: AGHT+IFurwu+Jv5psvR4SfizAmgJWtpim4N3JALHfxN9irgZeiJuYfLBuJoEeLed+ZQQkiF5UeqTFw==
X-Received: by 2002:a17:902:c942:b0:202:48a6:c882 with SMTP id
 d9443c01a7336-204df4e337dmr17398485ad.52.1724730644936; 
 Mon, 26 Aug 2024 20:50:44 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dd269sm74503625ad.135.2024.08.26.20.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 20:50:44 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 1/7] hw/net/can/xlnx-versal-canfd: Fix interrupt level
Date: Mon, 26 Aug 2024 20:49:21 -0700
Message-Id: <20240827034927.66659-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=doug@schmorgal.com; helo=mail-pl1-x62b.google.com
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

The interrupt level should be 0 or 1. The existing code was using the
interrupt flags to determine the level. In the only machine currently
supported (xlnx-versal-virt), the GICv3 was masking off all bits except
bit 0 when applying it, resulting in the IRQ never being delivered.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
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


