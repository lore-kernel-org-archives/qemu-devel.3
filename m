Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271EEC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgmA3-0006iJ-5k; Mon, 06 Jul 2026 12:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgmA1-0006i1-QF
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:27:09 -0400
Received: from mail-wm2-x02.google.com ([2a00:1450:4864:31::2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wgm9z-0001bP-Nm
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 12:27:09 -0400
Received: by mail-wm2-x02.google.com with SMTP id
 5b1f17b1804b1-493b9643ab5so1743695e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783355226; x=1783960026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j7nCdURakMK7yz0wZotBlI/Ct7/odgpIFhQJ36VOfIc=;
 b=dooV+HGFvFj7nFKcBPvw5kxvBzdf/rQnSrwWGf+Bqe+H9rwffLVua2Uk/B+0/MR3Px
 wMyTmVfdB5BpGxgM/m44RGvRvx4DYL71SFSH1TqsmkQZbCUVESHa1Xryf57JMKrn76lt
 cu8s/TQlMzYxAS8cASIBIgC8oOmfr8hEZNSSjj24u3VESTo3lecicVxy5NbPcgIfrJCj
 eAU5kld54+ElWbfGnKBoIsHA4j/WMfOXs617DwQJ8IqBU6CktBIMygv0jfgGdxzVGEVR
 i522l6u+q4/0VA3pDk9Xe7v8qjlv3u8dSGc3WQMKYvaZkHRNyz5uhhVlnrLLhcmeCJXk
 xKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783355226; x=1783960026;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7nCdURakMK7yz0wZotBlI/Ct7/odgpIFhQJ36VOfIc=;
 b=aTr4TVTHWAswBRo5Ecee72ZrY5pOClaJ66S9zJnX7100T8k+j/8jl2yuK94yqTLmJ+
 8b2ifbyaOYcaRgi4eSI1Y97njtQgsFj2of9lJLkMUV4Y4LtALaEHZVcJk7FXMxeLiz7z
 +Y+mVGHOIOdwJO741SgnTKi0Z1sxsdgZtyESKXvamidX6vI+V7AfmM93ai3Zklm8ZoFo
 Qs5coNWgo+wGb4zK17kAfS6hloGRyRpBebzbr7Q2/YQSuyIVzPP/FOh29T2IXVwSY8Ah
 RbnY9jW3iNcZDAWCI6cK4uvblOCREAiMZDI5wGWoZ+j301NGB3i8tqOMCAdHwWwrgNzi
 uP7Q==
X-Gm-Message-State: AOJu0YwfCXYhSdAPHVy9M4vaBLhWQzWSbgENpSXujE6tYAS4UXj0oz9h
 JIuAQnXynJG43VJKgbnwldED2XYWsNDE0bD+CptRi7nj5FOoe9212ed6i42SlO71SKmh7RN0UT7
 WY91PptwlTD+u
X-Gm-Gg: AfdE7cmvjC48ZKC4s/+L0IKU+2HDjrQGEjhnNACFMjHhI4kQVghV05/wdEWRY3Udb/B
 FZ4pFlGIiTD/3kZdXBJrQht13eLoxvvQijakRPUMy8pA2J/PP1xS8MEa8CtL9zRPKoPmOn//rww
 /7c88p3ZSivg9BCgf+NFeeG1HUEvjC8NqzJQ3DGOJxWg8Sznc0+FT4xpJNRziCbyYBImtGiatEk
 INdIcNJ5QqnyyWut+yvIM/Xdo4pIPls7XKhq6dkh16ZegguDoteDTwFJPLnDJZe8/4VRTCaORu6
 3ip4SCWfHUePCMmZrJaRL9VTP0wVGGbPyftOryVfiaYmjM8dSMMPjnnCW6IPda8bBYbUVmBOhHS
 AK6UOj7tieX1zFyI3WW2fNhH0mRnH8R9AUqdzk9CwLXDEzYU60KLXVc5ATaD1mQ7F5103KCgjuf
 j0taSQzOqhXbAGcdV0OarirCX1oBhvvS2J0zsiV/2HyGlqU6egEEZvZimYF4cssyM9s2MkSrD+A
 w0plqOQElHDxLH6fhTGEQ==
X-Received: by 2002:a05:600c:8286:b0:492:4911:8a with SMTP id
 5b1f17b1804b1-493df040410mr15779435e9.12.1783355225925; 
 Mon, 06 Jul 2026 09:27:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae4fsm26804105f8f.18.2026.07.06.09.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 09:27:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PATCH] hw/net/xilinx_axienet: Don't write checksums off end of packet
Date: Mon,  6 Jul 2026 17:27:04 +0100
Message-ID: <20260706162704.787495-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::2;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x02.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The xilinx_axienet device has ethernet checksum offloading, with a
mode where the guest provides the offsets within the packet where
the data to be checksummed starts, and where the final checksum
should be written into the packet.

We don't sanity check the TX_CSINSERT offset before writing the
checksum data into it, which means the guest can pass us a value that
is larger than the packet itself and cause us to write the checksum
off the end of the buffer.  We also don't explicitly check the
TX_CSBEGIN offset; this doesn't currently cause any problems because
we will pass a negative length to net_checksum_add() which does
nothing, but it's a potential trap for the future if the type
used for the length gets changed to be unsigned.

Explicitly check the offsets.  The datasheet doesn't say what happens
if the guest misprograms this, so we choose to log an error and send
the packet as-is.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3599
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/xilinx_axienet.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 970732b162..a44dda5385 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -919,20 +919,27 @@ xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
     if (s->hdr[0] & 1) {
         unsigned int start_off = s->hdr[1] >> 16;
         unsigned int write_off = s->hdr[1] & 0xffff;
-        uint32_t tmp_csum;
-        uint16_t csum;
 
-        tmp_csum = net_checksum_add(s->txpos - start_off,
-                                    buf + start_off);
-        /* Accumulate the seed.  */
-        tmp_csum += s->hdr[2] & 0xffff;
+        if (start_off > s->txpos || write_off + 2 > s->txpos) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: offsets outside packet, skipping checksum\n",
+                          TYPE_XILINX_AXI_ENET);
+        } else {
+            uint32_t tmp_csum;
+            uint16_t csum;
 
-        /* Fold the 32bit partial checksum.  */
-        csum = net_checksum_finish(tmp_csum);
+            tmp_csum = net_checksum_add(s->txpos - start_off,
+                                        buf + start_off);
+            /* Accumulate the seed.  */
+            tmp_csum += s->hdr[2] & 0xffff;
 
-        /* Writeback.  */
-        buf[write_off] = csum >> 8;
-        buf[write_off + 1] = csum & 0xff;
+            /* Fold the 32bit partial checksum.  */
+            csum = net_checksum_finish(tmp_csum);
+
+            /* Writeback.  */
+            buf[write_off] = csum >> 8;
+            buf[write_off + 1] = csum & 0xff;
+        }
     }
 
     qemu_send_packet(qemu_get_queue(s->nic), buf, s->txpos);
-- 
2.43.0


