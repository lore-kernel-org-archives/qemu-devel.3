Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F90C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4TX-0007q0-3A; Fri, 28 Feb 2025 12:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4TB-0007VQ-7t
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:17 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1to4T8-0005NE-7Q
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:48:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-439a4dec9d5so26072755e9.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740764888; x=1741369688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bK4QMP2l/mN25359h/sPhHBhlHOYz8CuG9/oUAWNxfg=;
 b=sw+Ks4yzndvavcUuaKIA8jcek9EtBFjwE2jeOYr9w0MdiwDFDExBkbGT++Ye1wsrRJ
 1x5TJSpyHZITrR6HX4ymq2qSxdcCOb9AXsIChXUKb3am99FCBzO8eO+rvflDrt31rl0d
 Lszhx3ytxBde4DZqXZ8MlRATkwL1gFrUaMtylIFO8GDV8YdCDF17RbVmxeEbDjVQFZdN
 MIaUZgqctt9FXQNOJd5M0MI2F+7UVf/5p0dsK1GX5W6UhLIE3C2QRkqnPqQ4q9nI1YR3
 q9lGTlnsW/zVutDosijHjMh9ohDmVXS4sHCeI1qHm0f/V4Shujnv77CXpSbkSdUTBjei
 m3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740764888; x=1741369688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bK4QMP2l/mN25359h/sPhHBhlHOYz8CuG9/oUAWNxfg=;
 b=bGBkFR8ajNVHkCo0COv+gjnLl38sS8//aQpfabTJEK8n9vrjpGBIU7g+2pLj8kA0qg
 iQ9SgULCQ5Ff/XiR99ntn030eP7JuHOlxT05zL3lW11oCf125jM69Wd7PVSE/GkNLqtx
 SKgOiNykBTcEehnaqK5nWebaSQwEMVwH0P2qWeyFs141BD84xb+vAm/rQXK1HA2liS7M
 MsLWZ82zII6SSqhquVRB6gO1KhEOSbSAKfGQpa8BXPx64O3pC6ep7wcLu2XOOYzJ7MpE
 YG2Mn3ydPnQZAGs2zPolDKIv5tQ6v93QQhe6Ik5Yld9718YNSDn63gBGdrlqKZavl82n
 sW2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUooZXYCLBp8bc6dte1g+PDEn8eELDyL483UhF3fcaPoCIF4DxQK0vsZEvYdDaPT93ahJZL1ExJlAE1@nongnu.org
X-Gm-Message-State: AOJu0YwO4TOE1GihLeqJicdNQaR6Z8syRVGszY0H4bZWCnJcKs+1evbR
 3EY6ixaUQ3Ly8qcYPnCuIEusH+mhsGvmvHS24jsKvFo/atSNCSqhF9FrMRSAC5M=
X-Gm-Gg: ASbGnctFxxu1tvazD6YoQPTfWpKZHLkYPaOgbuCJfT+7FtKySADuhrI8OORLx8Wp9Qt
 Yu3YitwymaZ6pvLK9Z2OljDVccsn0Dd2023RCJtOV83/2tN8GuRoQf8AUpc/W/KWcM40Ne1uyyx
 Wn40oM0ImNnBI08Om8kJ6vBqa4Gd6Zug2t1fmptDQ5x6Hhk8Viuqz4i0kQOEegqOmpw3ravbhGy
 hxbL3k9f15R6IbhQAFkf+9QKiLfOuupu/cDu5flkOCDgBKO7eU3jfF+mLHxDQVzBALkTsL3ysR/
 Z4Y/LkUK/8k0A5wjOTgpfu0Vc0fP2AQ9
X-Google-Smtp-Source: AGHT+IHq1JW4MN/qaVK8h6N8qk620ISXiqPkvDbAUfOkHkNVDvxLHznfCNMZDGcqjK/3rSvC3iNncw==
X-Received: by 2002:a05:600c:1c1f:b0:439:9eba:93bb with SMTP id
 5b1f17b1804b1-43ba67049b8mr48330735e9.18.1740764887948; 
 Fri, 28 Feb 2025 09:48:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795da5sm5979556f8f.15.2025.02.28.09.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 09:48:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/3] hw/net/smc91c111: Sanitize packet length on tx
Date: Fri, 28 Feb 2025 17:48:00 +0000
Message-ID: <20250228174802.1945417-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228174802.1945417-1-peter.maydell@linaro.org>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When the smc91c111 transmits a packet, it must read a control byte
which is at the end of the data area and CRC.  However, we don't
sanitize the length field in the packet buffer, so if the guest sets
the length field to something large we will try to read past the end
of the packet data buffer when we access the control byte.

As usual, the datasheet says nothing about the behaviour of the
hardware if the guest misprograms it in this way.  It says only that
the maximum valid length is 2048 bytes.  We choose to log the guest
error and silently drop the packet.

This requires us to factor out the "mark the tx packet as complete"
logic, so we can call it for this "drop packet" case as well as at
the end of the loop when we send a valid packet.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2742
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/smc91c111.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 2295c6acf25..23ca99f926a 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -22,6 +22,13 @@
 
 /* Number of 2k memory pages available.  */
 #define NUM_PACKETS 4
+/*
+ * Maximum size of a data frame, including the leading status word
+ * and byte count fields and the trailing CRC, last data byte
+ * and control byte (per figure 8-1 in the Microchip Technology
+ * LAN91C111 datasheet).
+ */
+#define MAX_PACKET_SIZE 2048
 
 #define TYPE_SMC91C111 "smc91c111"
 OBJECT_DECLARE_SIMPLE_TYPE(smc91c111_state, SMC91C111)
@@ -240,6 +247,16 @@ static void smc91c111_release_packet(smc91c111_state *s, int packet)
     smc91c111_flush_queued_packets(s);
 }
 
+static void smc91c111_complete_tx_packet(smc91c111_state *s, int packetnum)
+{
+    if (s->ctr & CTR_AUTO_RELEASE) {
+        /* Race?  */
+        smc91c111_release_packet(s, packetnum);
+    } else if (s->tx_fifo_done_len < NUM_PACKETS) {
+        s->tx_fifo_done[s->tx_fifo_done_len++] = packetnum;
+    }
+}
+
 /* Flush the TX FIFO.  */
 static void smc91c111_do_tx(smc91c111_state *s)
 {
@@ -263,6 +280,17 @@ static void smc91c111_do_tx(smc91c111_state *s)
         *(p++) = 0x40;
         len = *(p++);
         len |= ((int)*(p++)) << 8;
+        if (len >= MAX_PACKET_SIZE) {
+            /*
+             * Datasheet doesn't say what to do here, and there is no
+             * relevant tx error condition listed. Log, and drop the packet.
+             */
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "smc91c111: tx packet with bad length %d, dropping\n",
+                          len);
+            smc91c111_complete_tx_packet(s, packetnum);
+            continue;
+        }
         len -= 6;
         control = p[len + 1];
         if (control & 0x20)
@@ -291,11 +319,7 @@ static void smc91c111_do_tx(smc91c111_state *s)
             }
         }
 #endif
-        if (s->ctr & CTR_AUTO_RELEASE)
-            /* Race?  */
-            smc91c111_release_packet(s, packetnum);
-        else if (s->tx_fifo_done_len < NUM_PACKETS)
-            s->tx_fifo_done[s->tx_fifo_done_len++] = packetnum;
+        smc91c111_complete_tx_packet(s, packetnum);
         qemu_send_packet(qemu_get_queue(s->nic), p, len);
     }
     s->tx_fifo_len = 0;
-- 
2.43.0


