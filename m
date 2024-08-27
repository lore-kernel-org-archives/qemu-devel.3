Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60523C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinE9-0004ks-0D; Mon, 26 Aug 2024 23:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinE8-0004kH-6a
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:40 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinE6-0003ox-MS
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:39 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7cd8c8b07fbso1847643a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724730637; x=1725335437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wk+JgzKewV+CFARJmd6jqKUe+kd2x4Dw9/QPuiXaePw=;
 b=bbO6JKYodYUuGdU6669+gkZvUdUGbznw4bBHvHd+jXkxA209s+qOTCzTHdCyC8DrVH
 rQlO98Xxy4ushM593SkNqWOu/Em+TV0lB7VReZBqwMm5l/XicE62vGzzmdm7yjt2mSHb
 nUzfQXNSlETwCwDQ5H9GZenTQfJYq5p4GLC8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730637; x=1725335437;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wk+JgzKewV+CFARJmd6jqKUe+kd2x4Dw9/QPuiXaePw=;
 b=M7mYM1b52czxlUUUIaT1quTu2xjwhrRfvdEyO5J0vDnuHzP7tAPXTI/+phD35w0xip
 l6//0a6O6L2mz4IP/IzTFprEJLBcmU/AG2FrJCaq4DLXViewVWHicH2hraKiJzNqbZ3y
 pQgZhuRsKfj5YntnvhcKIAOeO+fbk9VCT/1S1Sskq/UZXzpDIwZupfb65bfwgto4lgLD
 77uUe5z1MQ/5CI9xYiXyMpmNu5QeYaVot50wlo2487fQuIFUE01zTe4p0fkpstZjVCH+
 hVD8FB2gmsvWZJuy+e+z+y97dQ5fvP6jlEbMgxPNSs98zF/s4DChZEwY5XC1sVXIPfcy
 JCFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/qMBbvEpbLkxricAasgVd77+A0KyReqx/Y+GFMPVkymhWewEIhgTPoooDz87JaIczVjy+gNHLazVT@nongnu.org
X-Gm-Message-State: AOJu0YzZjUX5rM+tHp9UUa/NVE3IteOtyzx7tXNIXXE2mY2b2JPw9plK
 LNlUkqgYFqhwUt+dwT+M0n6ZbyLUMHbvAN6wxyuCt+FJQy17z+11YjOYegHShNE=
X-Google-Smtp-Source: AGHT+IF1J3IDrPSLThltx11K6C2AXX2CwrD7/nRQ1fhk28VZ5qoKOxBadJc9am5R9q/mX4BSGCIvHg==
X-Received: by 2002:a05:6a20:d493:b0:1cc:9f2d:85f9 with SMTP id
 adf61e73a8af0-1cc9f2d86a3mr8782921637.33.1724730636495; 
 Mon, 26 Aug 2024 20:50:36 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dd269sm74503625ad.135.2024.08.26.20.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 20:50:35 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 0/7] hw/net/can/xlnx-versal-canfd: Miscellaneous fixes
Date: Mon, 26 Aug 2024 20:49:20 -0700
Message-Id: <20240827034927.66659-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=doug@schmorgal.com; helo=mail-pg1-x52c.google.com
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

This series fixes several problems I ran into while trying to simulate
the AMD/Xilinx Versal CANFD controller in the xlnx-versal-virt machine
using Xilinx's v6.6_LTS_2024.1 kernel. With all of these patches
applied, everything works correctly alongside actual CAN devices.

- IRQs were accidentally not being delivered due to having a level other
  than 1. The IRQ count in /proc/interrupts in Linux was stuck at 0.
- Incoming CAN FD frames were being treated as non-FD.
- The CAN IDs were garbled in both RX and TX directions.
- The ESI and BRS flags were not being handled.
- The byte ordering was wrong in the data in both directions.
- Incoming CAN FD frames with DLC = 1-7 weren't handled correctly.
- The FIFO read_index and store_index wrapping logic was incorrect.

I don't have any actual Versal hardware to compare behavior against, but
with these changes, it plays nicely with SocketCAN on the host system.

Changes in v2:
- Added handling of ESI and BRS flags, ensured frame->flags is initialized
- Switched to use common can_dlc2len() and can_len2dlc() functions
- Added fix for FIFO wrapping problems I observed during stress testing

Doug Brown (7):
  hw/net/can/xlnx-versal-canfd: Fix interrupt level
  hw/net/can/xlnx-versal-canfd: Fix CAN FD flag check
  hw/net/can/xlnx-versal-canfd: Translate CAN ID registers
  hw/net/can/xlnx-versal-canfd: Handle flags correctly
  hw/net/can/xlnx-versal-canfd: Fix byte ordering
  hw/net/can/xlnx-versal-canfd: Simplify DLC conversions
  hw/net/can/xlnx-versal-canfd: Fix FIFO issues

 hw/net/can/xlnx-versal-canfd.c | 173 ++++++++++++++-------------------
 1 file changed, 72 insertions(+), 101 deletions(-)

-- 
2.34.1


