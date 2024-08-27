Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF086C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinER-0005D4-6i; Mon, 26 Aug 2024 23:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEN-000553-Pp
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:57 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEJ-0003qY-Rg
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:54 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20230059241so40781015ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724730650; x=1725335450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0zsQlf6Fpb3LogkSdeHLWACnHhbNDLVL/P8RxdypHM=;
 b=emOTH1OSvNprDeGur9l+DepiM4vZ7VkUVv5X63f73hsn/eErEjxDNdRYOwhIywBIEc
 5aeDabqQbpjUkSSyoz2rSyOYpwc6ePpEjRpkkFZAQvIiJCsHOXqJ1Si7zwOy/dmVdWMU
 Jt2bcM+feFoOec+1LbFkouMrJL6WWHKQaqrrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730650; x=1725335450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0zsQlf6Fpb3LogkSdeHLWACnHhbNDLVL/P8RxdypHM=;
 b=Dzotwy4DUp9BXTpGkTrdmogXbP8nHeSRdP0KhcJuUMQ0s9IHjDHCLjTJEfVqgcouk4
 9xJ4jtlNRwtqWIDrRU+wzPfoDLHinNao4hdTjp63iLFOll4LF/3MaKw68Oi/KwPRDUSc
 UmIkqoZ6grlruX0rgXmND+/8opEGMOgNH8mFc1ktSqzegTdPFW6PZHioPytAh2WYjqKC
 Z85NTYf+DIo072m4SB9mDCRycz5XEAxKuz25hUGFAUtjQlrIqhS85LLrj1YTmUuftiVR
 sqJMSzbOFr6ysSqnCK4TSHLI8Yj9T8TWQLnXXjzKK6hO4lVJYdlOYLcUTz2tTTLH/5Ok
 KRcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIWSzuAN1V12lOnzC3H97RAjjLXa6RMcla0HG2tkcahq/kKkuVzVn6iFa0DnSgF/aI9vPJwXa+ik8s@nongnu.org
X-Gm-Message-State: AOJu0YwmpLgmcWllxE2N03grMJgL4cyZK+HLlfNHbKfiFwEhD9IX755f
 Zx0yBXB1YRbz3+Tlh3AIYrQ0qGwvqUZA9ibnIviXLNqjcDfnNIWz76nJEt3L+lo=
X-Google-Smtp-Source: AGHT+IEwuUQ3gLat4m6or9KyVLa/RrfyK5pIfIYJe9KC8cESOTG7v7uh7oE0g8/jcAIfTVwoHF6kEQ==
X-Received: by 2002:a17:903:2c7:b0:201:f1b5:24ac with SMTP id
 d9443c01a7336-2039e51279bmr139896365ad.54.1724730650264; 
 Mon, 26 Aug 2024 20:50:50 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dd269sm74503625ad.135.2024.08.26.20.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 20:50:49 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 4/7] hw/net/can/xlnx-versal-canfd: Handle flags correctly
Date: Mon, 26 Aug 2024 20:49:24 -0700
Message-Id: <20240827034927.66659-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=doug@schmorgal.com; helo=mail-pl1-x635.google.com
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

Add support for QEMU_CAN_FRMF_ESI and QEMU_CAN_FRMF_BRS flags, and
ensure frame->flags is always initialized to 0.

Note that the Xilinx IP core doesn't allow manually setting the ESI bit
during transmits, so it's only implemented for the receive case.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 1704b558d0..47631917ab 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -872,6 +872,8 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     uint32_t id_reg_val = 0;
     bool is_rtr = false;
 
+    frame->flags = 0;
+
     /* Check that reg_num should be within TX register space. */
     assert(reg_num <= R_TB_ID_REGISTER + (NUM_REGS_PER_MSG_SPACE *
                                           s->cfg.tx_fifo));
@@ -913,7 +915,7 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
          *  15                         49 - 64
          */
 
-        frame->flags = QEMU_CAN_FRMF_TYPE_FD;
+        frame->flags |= QEMU_CAN_FRMF_TYPE_FD;
 
         if (dlc_value < 8) {
             frame->can_dlc = dlc_value;
@@ -921,6 +923,10 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
             assert((dlc_value - 8) < ARRAY_SIZE(canfd_dlc_array));
             frame->can_dlc = canfd_dlc_array[dlc_value - 8];
         }
+
+        if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, BRS)) {
+            frame->flags |= QEMU_CAN_FRMF_BRS;
+        }
     } else {
         /*
          * FD Format bit not set that means it is a CAN Frame.
@@ -1058,6 +1064,13 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
                     dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, 8 + i);
                 }
             }
+
+            if (frame->flags & QEMU_CAN_FRMF_BRS) {
+                dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, BRS, 1);
+            }
+            if (frame->flags & QEMU_CAN_FRMF_ESI) {
+                dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, ESI, 1);
+            }
         } else {
             is_canfd_frame = false;
 
-- 
2.34.1


