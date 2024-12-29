Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABF6E77191
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhJ-0006WD-2y; Sun, 29 Dec 2024 02:26:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhC-0006UV-Ql
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:42 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhB-00027u-Ep
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:42 -0500
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-aa662795ca3so1751980166b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457199; x=1736061999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBzddoYpBkIm07+U/ldCBxDCjZBVJD4vMlMTweT6GA4=;
 b=TbM0zpKQGY2brEmuQ1g8AR1ishzp0ST3gNAO4buT5YojKlmvS6tkhjNOZMOKsTW+T1
 OanMv9HzoyWh0X9gfkFkAQ1aIR6SbuVn9bPfMcMEGpsh5WnXOZQTWEqkUKKwspW0qnF8
 Vad3If2oXEKOwwRBtIF/WCgeYsysw4n/sOhinkRb0WnWI4eEBZg9f0WuPQDYyZTpqVSe
 GZvgZ2MZD55uF4Tevo8b1BcafYGT1Y8kraqNuYZsUhqg68mVnFUspfDyZyoRQaS8liBX
 TbqhIsqzGj0XDbD32hcmFcJTSGLu5qkUQAmLDx2hzbASYNjnrys2ICi2gjgKiyww4RSO
 SwEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbSw/i67yjQT3fba6gg72X4IrMBqIKx3JDkLzNLdo/nSBRSX0znumvQknDX0pfY2u4q3qJEr/SoDAh@nongnu.org
X-Gm-Message-State: AOJu0YxCU54Oa23clY0nx/4JWgCpCieScY+PRbzM4W5YvyDGc/1CE1xL
 ljosPrOeABd7Tzg/sg0ITBaiEOcRfmtr1DFN/NwE/zKJnl2uJ+eL
X-Gm-Gg: ASbGncuuFyoBblxrhhwjVnEwKEx8j2bPjyeFWOUpWm59LTSBtxNxJqZGccscA6cLJIY
 IBMoW57TZd1GllIRbWl33xeoLXyiKkrhoXANjBpUog9gsKXRxuBElLIW9JCKbFRi9j6dCWIZiQi
 KuWGWW6y5x6VfcNOA4b0PuvxFEmnGhXpknHtcCqJiE+ZWP+etWHSyxoMvDzf0pu0RqXaZMWmxmW
 BZMVec9x+9vPy7zgvr+mS4Eza6KrUOgrEDZvL+1wO8Zb7dsxJAMAOm/LNuj3F4BP2NHCuFuWA+j
 LN4=
X-Google-Smtp-Source: AGHT+IEVik0Twn904+owDuwl/g/GuvtBga164aXkQdlRuXBkE8szt4NaMyetIbywdg6JYQb0G5vLhw==
X-Received: by 2002:a17:907:3f19:b0:aa6:75f4:20df with SMTP id
 a640c23a62f3a-aac08126683mr2943414966b.9.1735457199026; 
 Sat, 28 Dec 2024 23:26:39 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:38 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 06/35] next-cube: move next_scsi_init() to next_pc_realize()
Date: Sun, 29 Dec 2024 08:24:57 +0100
Message-ID: <20241229072526.166555-7-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This reflects that the SCSI interface exists within the NeXT Peripheral
Controller (PC).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 31c0532aff..97dea45b13 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -908,6 +908,9 @@ static void next_pc_realize(DeviceState *dev, Error **errp)
                           "next.scr", 0x20000);
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
+
+    /* SCSI */
+    next_scsi_init(dev);
 }
 
 /*
@@ -1050,8 +1053,6 @@ static void next_cube_init(MachineState *machine)
 
     /* TODO: */
     /* Network */
-    /* SCSI */
-    next_scsi_init(pcdev);
 
     /* DMA */
     memory_region_init_io(&m->dmamem, NULL, &next_dma_ops, machine,
-- 
2.47.1


