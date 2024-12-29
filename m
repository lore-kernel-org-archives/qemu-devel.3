Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AA1E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhA-0006Tr-Tb; Sun, 29 Dec 2024 02:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnh4-0006TJ-L2
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:35 -0500
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnh3-00027K-31
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:34 -0500
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-aaee0b309adso766589566b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457191; x=1736061991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dogHZq8IreSzSR1AAe+dCE7TE8hDuQ0Bzq/9Cj2rhi4=;
 b=pN4ilznvhlxdVzrMXgefzM7FtQDxqj7XnN+5/hfV6IF4T0zhh+SjwWxyHk2hL0w8kJ
 odU2Y8/Sn1HDnUv8IA90Kc5OuJY5wBhLd7y3xqWprd6qr1yh2raibkabhDRWfKDdYbcA
 Lkp7ItuRSGjGhVozEFISaBhFKZ0ZD4dYLCfLOdOT2iMZAjwwznDavzA8PorN8Ns8bqNW
 ekWWC3U5LRLHR+2059TrYFbRfk1Q2CmQOZ9E0Px4ItloCN++HvF4e33q09MuS0sV7Ah1
 yXnm1Lg5cxMLySZl/iQOO8ebMsjwQcPNMVHpZT8UICg21HzRPN99P5X9JydkfSROfqfc
 Bcxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqnkDpJlEnF/JersZ+DqyUo3puYPNpYbi99fp2CaZ187EJRm/FRf6a+Oca/5sibwnM8KCD6GZRMTkU@nongnu.org
X-Gm-Message-State: AOJu0YyOhx4vbxDhSD5h3zTRf8wY+T7DQrQUNoxvHbY1WAXZ2u5Q5LE5
 AH/aSjamUaBq332eNNg+Vy0HSwZ/AT05IuMPxkoY3y79lX2IuYez
X-Gm-Gg: ASbGncv9ZMO7hKAZdG5EdIGKFIkWOaiUWu0c16J/5k+osw8ahg//1aNOVMhAZfsSaov
 nLmdx/fvq/MzskNTxpzmV0bnyZelkW8Z5thqmbiPKFzJGKR5YGUivV8qsmKHvFKntIcuWFspazU
 f5PMEjmW03udniJwaykN+3sGbaHPouqCSOIZGPsvcLcWdY7KdWMrHN8OQ9rGSOPtf8tdcPedpmv
 P2FEYuIIa36fiFDX4qRjqdt2IuyL0oBusrO/Ztw9RYJdPHjcRLXuK4q4Wx88F//t3wF2oBA/+D2
 f6s=
X-Google-Smtp-Source: AGHT+IF0oznSzs0JoCCY2EXckf3PWwVJwHtwqUr7Ow2dvDrKC5sleI8MC43yfcQTvFgjbCHQcvUkDA==
X-Received: by 2002:a17:907:2d27:b0:aa6:7470:8efe with SMTP id
 a640c23a62f3a-aac2ad94a1amr2846525666b.13.1735457191346; 
 Sat, 28 Dec 2024 23:26:31 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:30 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 03/35] next-cube: remove 0x14020 dummy value from
 next_mmio_read()
Date: Sun, 29 Dec 2024 08:24:54 +0100
Message-ID: <20241229072526.166555-4-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.54; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f54.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a dummy value for the SCSI CSR which appears to have no effect when
removed. Eventually the reads/writes to this register will be directed
towards the WIP implementations in next_scr_readfn() and next_scr_writefn().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 94d56b4654..243d9e7e66 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -286,10 +286,6 @@ static uint64_t next_mmio_read(void *opaque, hwaddr addr, unsigned size)
                         size << 3);
         break;
 
-    case 0x14020:
-        val = 0x7f;
-        break;
-
     default:
         val = 0;
         DPRINTF("MMIO Read @ 0x%"HWADDR_PRIx" size %d\n", addr, size);
-- 
2.47.1


