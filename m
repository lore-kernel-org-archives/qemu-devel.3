Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969ADC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinET-0005K2-0H; Mon, 26 Aug 2024 23:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEN-00055j-Vj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:57 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEL-0003qs-LW
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:55 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7bb75419123so3264053a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724730651; x=1725335451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JnP3Mz0YCYvkvuQOeow8f8X6KYRPaGRZd1rCOK6MrJs=;
 b=ezn6Jw5yIk/p1LxOfuLXUfwN2RNBV1E5lO5T4x/exItkNiWPnpWTeOiKue205tDyAS
 t/WSe3abnQJYnUNlf+BDU1lWz+WhODlMp/6eNvjY+ZzzuiyExYhqZoG7McIZdrz+cMoA
 oyXA+8jtShnR870yNeGLGphSbxHT1a1a2qvLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730651; x=1725335451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JnP3Mz0YCYvkvuQOeow8f8X6KYRPaGRZd1rCOK6MrJs=;
 b=S4wFOiqZXhudGhyn07Ja53JG0+R5ZqNSce5+bAaCBkLFSEMBifAu2ZGtWXO3chSNGo
 m5a+5nsmlQ+7lDHEgG4FoB6njih91pUM97uTn+TPOXqt5ddk4H9vbUBN7K2Kifi4bx4Z
 xL4L4CQwiL6F6bq7wkjlkxkHUl1qAKtBw2xZlG2xCzDHKhVbe81nHM4DnaMWBxBQ7xRs
 pakM826h7o3csM6ehfhxf+/QXImiE58VbXWYflwxaO8bZyFt4h4ONJvZn9smc3Mub7I0
 82kQ/tfzUkPfN7dRbHGcjymYn9UmCABK96Kka5DKbso8b7f9DV6yD75tqmLt64MmTJhm
 VeBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtnXuYyzB2o8WTrpaZmePQYsN2FZ40WHoIXpOxKFoU8e6tFE/APxuMgyQk6ZD37KrDND+VRfYat8Nl@nongnu.org
X-Gm-Message-State: AOJu0YyceIiirmmae5XyWTa/ztir6vri3TOC0afoYcuX/r6Uqoj5Rp31
 25YlmGypbNq718cHcJgSzjiex0bwt/8rcqMn0YCC3edVgSAqhTRfnntv0B5yifk=
X-Google-Smtp-Source: AGHT+IGe3PUZEYCSgJsKiA6gmmK50hNyHr7QOk853mSIwidN4JmobSoIwlgaGyUk6yU8I4xAs38q6w==
X-Received: by 2002:a17:902:d2c6:b0:202:2cd5:2085 with SMTP id
 d9443c01a7336-2039e4b4b90mr96999355ad.32.1724730651632; 
 Mon, 26 Aug 2024 20:50:51 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dd269sm74503625ad.135.2024.08.26.20.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 20:50:51 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 5/7] hw/net/can/xlnx-versal-canfd: Fix byte ordering
Date: Mon, 26 Aug 2024 20:49:25 -0700
Message-Id: <20240827034927.66659-6-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=doug@schmorgal.com; helo=mail-pg1-x52f.google.com
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

The endianness of the CAN data was backwards in each group of 4 bytes.
For example, the following data:

00 11 22 33 44 55 66 77

was showing up like this:

33 22 11 00 77 66 55 44

Fix both the TX and RX code to put the data in the correct order.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/net/can/xlnx-versal-canfd.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 47631917ab..5d7adf8740 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -951,7 +951,7 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     }
 
     for (j = 0; j < frame->can_dlc; j++) {
-        val = 8 * i;
+        val = 8 * (3 - i);
 
         frame->data[j] = extract32(s->regs[reg_num + 2 + (j / 4)], val, 8);
         i++;
@@ -1093,19 +1093,19 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
             case 0:
                 rx_reg_num = i / 4;
 
-                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
+                data_reg_val = FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
                                           frame->data[i]);
                 break;
             case 1:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES1,
                                            frame->data[i]);
                 break;
             case 2:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES1,
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES2,
                                            frame->data[i]);
                 break;
             case 3:
-                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES0,
+                data_reg_val |= FIELD_DP32(0, RB_DW0_REGISTER, DATA_BYTES3,
                                            frame->data[i]);
                 /*
                  * Last Bytes data which means we have all 4 bytes ready to
-- 
2.34.1


