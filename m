Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F5BC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinES-0005Hu-EY; Mon, 26 Aug 2024 23:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEQ-0005Be-SU
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEO-0003rb-6E
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:57 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d1fa104851so1296907a12.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724730655; x=1725335455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/zRMYEmVpTZe+R3MyadGyIt4py5ThMYbf+0okcx+mC0=;
 b=QpA5tWvCkSXOg27uO5imHcmghXAVKSvRVvpzBuU0J4t4163gJG1G7z1LCm0QRO2tZG
 IONY35LECB8YO6q5VEyI3I/K4jyCypKV+0qAI8zqoMmUn0/xNGfvZ+NA/bwGnXr3E3h8
 kV47F5dy9v/HUAq/bJz2x83PHwNfRrABLnng8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730655; x=1725335455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/zRMYEmVpTZe+R3MyadGyIt4py5ThMYbf+0okcx+mC0=;
 b=W1XKHrJxrURFqpGH9tfDF6YLGnNLZwepGjUpamJXU7rOgCo1LLSz7ZbLW5riz07gVZ
 jxPLfBOQAgy9Ur+HzcKGzo66/N1EGkKng4F36drtAyu+yYIMTB3CJpM/rXUCqwrXZOYh
 FOi7BLM4jBKraaYnEoTzMCXBkLBKUj5VHM+0s5PW3F+q3+n14Zls0nN45ktG115ZIuUl
 fungJ85ZFdfQUYRiRDRAJhkAm08FoV9GPHekJFU90uU9qf6VCdEQANvtxcphMxXnur6S
 1m58FFNOaqa+wfnHjySDUsQZfZmKxfTcz+oZDtCh3Zhgc5uWiyQvIaZnroyJgvRA1s7D
 WI8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUAG1RF+brc+MQoyXEOXDq0mvLVwHQVJjzRpwqKSExalNR1LZpJRkhJWcC3re4XydqoazPuFO7a0fm@nongnu.org
X-Gm-Message-State: AOJu0YxC35z33y2NTGlLKW4Di2BVYoXUMT2fqCSPj/vzNoUya5fL1kBK
 CIi80NUqtgl5RhRc4LY4egkVxNLcFGRbSjrZ70DXllPMcTh7rcr6GLy5vChEiLs=
X-Google-Smtp-Source: AGHT+IGCevETHQsx4Ox8kx8Mvkuq5YUp3/5bmIZZFBi8ZndXG3W00PUxyF2V0DzCIYvEnnx9BwUS9A==
X-Received: by 2002:a17:902:cf4f:b0:202:1db8:d9b0 with SMTP id
 d9443c01a7336-204df4803e0mr15259535ad.34.1724730654755; 
 Mon, 26 Aug 2024 20:50:54 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dd269sm74503625ad.135.2024.08.26.20.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 20:50:54 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 7/7] hw/net/can/xlnx-versal-canfd: Fix FIFO issues
Date: Mon, 26 Aug 2024 20:49:27 -0700
Message-Id: <20240827034927.66659-8-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=doug@schmorgal.com; helo=mail-pg1-x531.google.com
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

The read index should not be changed when storing a new message into the
RX or TX FIFO. Changing it at this point will cause the reader to get
out of sync. The wrapping of the read index is already handled by the
pre-write functions for the FIFO status registers anyway.

Additionally, the calculation for wrapping the store index was off by
one, which caused new messages to be written to the wrong location in
the FIFO. This caused incorrect messages to be delivered.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 36 +++-------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 589c21db69..c291a0272b 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1144,18 +1144,8 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
             read_index = ARRAY_FIELD_EX32(s->regs, RX_FIFO_STATUS_REGISTER, RI);
             store_index = read_index + fill_level;
 
-            if (read_index == s->cfg.rx0_fifo - 1) {
-                /*
-                 * When ri is s->cfg.rx0_fifo - 1 i.e. max, it goes cyclic that
-                 * means we reset the ri to 0x0.
-                 */
-                read_index = 0;
-                ARRAY_FIELD_DP32(s->regs, RX_FIFO_STATUS_REGISTER, RI,
-                                 read_index);
-            }
-
             if (store_index > s->cfg.rx0_fifo - 1) {
-                store_index -= s->cfg.rx0_fifo - 1;
+                store_index -= s->cfg.rx0_fifo;
             }
 
             store_location = R_RB_ID_REGISTER +
@@ -1172,18 +1162,8 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
                                           RI_1);
             store_index = read_index + fill_level;
 
-            if (read_index == s->cfg.rx1_fifo - 1) {
-                /*
-                 * When ri is s->cfg.rx1_fifo - 1 i.e. max, it goes cyclic that
-                 * means we reset the ri to 0x0.
-                 */
-                read_index = 0;
-                ARRAY_FIELD_DP32(s->regs, RX_FIFO_STATUS_REGISTER, RI_1,
-                                 read_index);
-            }
-
             if (store_index > s->cfg.rx1_fifo - 1) {
-                store_index -= s->cfg.rx1_fifo - 1;
+                store_index -= s->cfg.rx1_fifo;
             }
 
             store_location = R_RB_ID_REGISTER_1 +
@@ -1265,18 +1245,8 @@ static void tx_fifo_stamp(XlnxVersalCANFDState *s, uint32_t tb0_regid)
                           " Discarding the message\n");
             ARRAY_FIELD_DP32(s->regs, INTERRUPT_STATUS_REGISTER, TXEOFLW, 1);
         } else {
-            if (read_index == s->cfg.tx_fifo - 1) {
-                /*
-                 * When ri is s->cfg.tx_fifo - 1 i.e. max, it goes cyclic that
-                 * means we reset the ri to 0x0.
-                 */
-                read_index = 0;
-                ARRAY_FIELD_DP32(s->regs, TX_EVENT_FIFO_STATUS_REGISTER, TXE_RI,
-                                 read_index);
-            }
-
             if (store_index > s->cfg.tx_fifo - 1) {
-                store_index -= s->cfg.tx_fifo - 1;
+                store_index -= s->cfg.tx_fifo;
             }
 
             assert(store_index < s->cfg.tx_fifo);
-- 
2.34.1


