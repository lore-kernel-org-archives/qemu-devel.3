Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76020C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1Wx-00045M-KT; Fri, 16 Aug 2024 14:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwZ-00031K-Ff
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwX-0002K1-Op
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:51 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2d3f39e7155so89776a91.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1723826206; x=1724431006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=89/7hZF+8IhsBx3iy+MY5AfZGvKvI2UgmGN78UfgphU=;
 b=eo1VlpKgX9h2Q+vQDWXk2hi6ByxHmBfT2SEgtc2W6lTeQM4Xw+N8sKqlyNNGiYvIV4
 X2y9POVk7sQOLMIjj5JbVlDuJseoW4G8VGe+sgixmWtMkRMqoWHKRjjZeE030yZavcH0
 PA5eKot91l5Rxm+9xwsIGRHHckuTLo3TbrHaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826206; x=1724431006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=89/7hZF+8IhsBx3iy+MY5AfZGvKvI2UgmGN78UfgphU=;
 b=kZ7wzJAU8vux63zHNOvA5fkD/lrHqW7CGm6z1yaeWYQ58PFuFRFxcOUGwCTwwViwY4
 CSHC44anqN2cXefE1wAWkmMqfzGKWiRWE3VbT/y1bnh1v1nbHT+8TKGfRTcyzwegA45q
 0Avaj7BB7jlxD0LaJbv5OFj/Cw9MjrC27roMJZm0k85MtY7vfOnYCYRxhTDCMYGNfbGX
 ypsAPH4K1kXGQYaImAICoUns6aPF4Vb+9prPAp4mjVPJmOZY/2X9B4pV4P8sXMIBwDk2
 d3z/y6uVkZvRKT1s7WV+82wIZz8cfYqbQ/NGiRzy7O4Hrq0yN/Jw21AeKusW4p5VzjaP
 HDiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaf2AtBQlqGtiAUZDey5819phWro73ZY8RUZNqeFwwWazfBHuGt0R4aeX7sFrTxXxPpYiUDlxcSDLAylAQhKZfNSFYDbI=
X-Gm-Message-State: AOJu0YwzeX/3+2pu9nE6RijO9VJFY9WdAvFoHupawMRvtPw84v/ERpNt
 DmWu2bPw3sfSRsXOBn2NecsGn0FZ9mzOdz6JHJ23JStBGjZI9TAp64SBwQN31Ho=
X-Google-Smtp-Source: AGHT+IH09VAB6F42k1mnj0+F5rRqiCemyiTXjaWBuD0kcW53KDKQa40FRI8R/Nx/I3CnDPDZOrNiVw==
X-Received: by 2002:a17:90b:1055:b0:2d3:c37b:7681 with SMTP id
 98e67ed59e1d1-2d3e1dcc1d7mr2145031a91.5.1723826206272; 
 Fri, 16 Aug 2024 09:36:46 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2e6b201sm2134285a91.15.2024.08.16.09.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:36:45 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Doug Brown <doug@schmorgal.com>
Subject: [PATCH 0/5] hw/net/can/xlnx-versal-canfd: Miscellaneous fixes
Date: Fri, 16 Aug 2024 09:35:00 -0700
Message-Id: <20240816163504.789393-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 14:18:27 -0400
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

This series fixes several problems I ran into while trying to simulate
the AMD/Xilinx Versal CANFD controller in the xlnx-versal-virt machine
using Xilinx's v6.6_LTS_2024.1 kernel. With all of these patches
applied, everything works correctly alongside actual CAN devices.

- IRQs were accidentally not being delivered due to having a level other
  than 1. The IRQ count in /proc/interrupts in Linux was stuck at 0.
- Incoming CAN FD frames were being treated as non-FD.
- The CAN IDs were garbled in both RX and TX directions.
- The byte ordering was wrong in the data in both directions.
- Incoming CAN FD frames with DLC = 1-7 weren't handled correctly.

I don't have any actual Versal hardware to compare behavior against, but
with these changes, it plays nicely with SocketCAN on the host system.

Doug Brown (5):
  hw/net/can/xlnx-versal-canfd: Fix interrupt level
  hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
  hw/net/can/xlnx-versal-canfd: Translate CAN ID registers
  hw/net/can/xlnx-versal-canfd: Fix byte ordering
  hw/net/can/xlnx-versal-canfd: Handle RX of short FD frames

 hw/net/can/xlnx-versal-canfd.c | 82 +++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 15 deletions(-)

-- 
2.34.1


