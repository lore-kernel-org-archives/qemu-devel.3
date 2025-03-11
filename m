Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88F2C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5dr-0006uQ-50; Tue, 11 Mar 2025 15:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dj-0006tn-Nl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5dh-0007Rd-Pi
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:51:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d098af0ebso951025e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722704; x=1742327504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A64VE0HWwlabMJRt5vtnsFzNDdVP8Y0h5ubxHXceiq8=;
 b=gPK5yOVQJ/SyRHdI9zw3/3FhHEWS4cMLvH8qAF8JJgWWlkPAv+DJkCalxWow/69JIR
 p4Azww/q97/ExqyJE9skDbXIhMOFS91RT8A2R029xfgJu0VpfL4OTp01JoIKKfav46Hc
 qk3Qtb04mN7e0YeNBiNfQSmRdGRItSRM6b9XB4M0LBtUy2O+ys/k8QfXONVrGp78dEmX
 MzIUViIuGCMPHbTMzNMDKpFvQCzHRsTLZCeqLjcjpHqhS7PfDF1cHj3eVtp/RIMXyidA
 FqzuU6+jHrCsFjHaLEtwS/L2l0M7MZH+8BJwMgbSNe++M0dCLyZsDvTQ1LDZTvI8euil
 FyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722704; x=1742327504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A64VE0HWwlabMJRt5vtnsFzNDdVP8Y0h5ubxHXceiq8=;
 b=N/AGvTOB+v+tjN9B5utRE+luJysPpDT0HGZ98RVwCIi0mJd/PUplg0blf/wc45qzZa
 XkOsDGKY3HgJ/fHD2STFqBkDxXIpSKO9KFnY+o+BHtMzrSjnFDxw/YQWS7Zl/hBbcwaN
 Z6iAoOMotToknGcUA8o2QCyR33IVoeuJ/JJJ3SIzJTP3f6YD1Y22CggqSg7lxVKCD7j3
 9LuIGV1OCYet9ILaT7amaB50mr+l+2Z5trmPEvpdUff2RIHY390NPv+zlyg3fBZyZxTg
 RAvg3rfCZ+apN3O+8urwjMAlXvLHfKYseD9LkyypXx+xAnvAAMZg3/Hd+35hBLi20tKP
 Aplg==
X-Gm-Message-State: AOJu0YxxZCNvzoJYvTZi+aJHg6brxvGh9aV0GrsBEPPsUI6TNiqonQMh
 llvsh3al8z9uTnSR2DdvoZjXlVnx9Phtp1AJZeWEkIeU1dc/QFiODj77etKGgZWDzJfFHqC7SNJ
 1JLw=
X-Gm-Gg: ASbGnctryKRqdNo+j7+FjuT4YIzBhAcqTGIGEB8KVfuxFYv5uPCbELI3dd01K5TSaie
 g62fmk20xx/1NT1kDdPzEVBgjI7M68M+NzbPSWMFOyPuFI6bsxYTA1FeAOvvWV7EDDBUO9f6a6Y
 b4Mmmih5d+iQNn9w33xrAdol6Zzw6e8tzWa4escb4zlfoPwE+07oJyYD/Wb97Mooc4LvhT4t3I8
 WwCbUDo8a/6cACzxKyGdZwo7yGQ+3D6ZGQFEdEFEbGExvppL0KYIZKGb1ijb3poM45zCssPFhtA
 vMLCmHc+/jl9pEA9RIfEWt5RC0SFB3oXt/jNWMxrycOWzOwngFuTbzf32OERyRv8M87eDw6CdxW
 6gCq/vRqEOBAdbIlOdZ0=
X-Google-Smtp-Source: AGHT+IG5E28qnehI14LJApK2OQ2eqsACguVi82mAV4Zc2hjZiWuoxMI9saHEx4w5KP3IbBiLIipUKw==
X-Received: by 2002:a05:600c:474c:b0:43d:209:21fd with SMTP id
 5b1f17b1804b1-43d02092256mr60336695e9.30.1741722703772; 
 Tue, 11 Mar 2025 12:51:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7934sm19264407f8f.12.2025.03.11.12.51.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:51:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/14] hw/net/smc91c111: Sanitize packet length on tx
Date: Tue, 11 Mar 2025 20:51:13 +0100
Message-ID: <20250311195123.94212-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250228174802.1945417-3-peter.maydell@linaro.org>
[PMD: Update smc91c111_do_tx() as len > MAX_PACKET_SIZE]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/smc91c111.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 2295c6acf25..72ce5d8f4de 100644
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
+        if (len > MAX_PACKET_SIZE) {
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
2.47.1


