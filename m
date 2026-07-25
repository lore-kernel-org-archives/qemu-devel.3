Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F84C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmr-00022v-19; Fri, 24 Jul 2026 21:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTR-00071x-GQ
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:41 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTP-0000s6-R6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:41 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-74748e3a4d1so465127137.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940159; x=1785544959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HM14Foo5RtrgA0ZcKF+/SRI7Q8dbPL9zkcGGEEENP7M=;
 b=G/dY1iagjVBGhXVChe1ru5WUgKgZ+KDxfdfM8g89PnoZw60GhPiovrXPOtqS83IK6H
 UWoBpxSesivdHzhJs9Ywq2VuwEUoJxhgon7yVPISxBGxoKl3UsxsM85njEhPnmP2r1B/
 RnKrswkH17mT1PTC53WtMYq7vdVjmqEy44LrMnGqx516W60Y1tTDMYPqqtrzFsITnkO/
 4tmOV7NEb3PCUoG9rBgSyHQQ4LVZml+JzO4aUTwRC9YkdX4Dx9hm/u7X2ksLKZpbzGK8
 9qWbw1ccvIGwD+FFVw+Z3m9zBHytpuv5PJ5e06h+A/Ks2ZvGcJ2W9u1VapnpXKQjfMzJ
 rlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940159; x=1785544959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HM14Foo5RtrgA0ZcKF+/SRI7Q8dbPL9zkcGGEEENP7M=;
 b=g6DlOP4F2McG7Lt3gIn4ytENJnzd5l5msBaNbuKxGTMON8bhdFCABbyGQHw7cktRp+
 Gy50MdxMPi7FuTP6qmrO3uP74YgR6m5m45EGqLTA82CijEdtVUgsF69q8nLHDiSCNUjz
 v7kf5FU3235V0aMo1S5DwQV3tja9fo6b3pPwRH4j9Zy2kUz87TS6hgzA0A2fMY+/4Vbb
 9iOcJ4IWAqR2ip4h5StyK1aiJV2PjvuuwmS3MVSv6EFLDlllfTkzEAJb7IlwS8pOSbPp
 C27GV8+zyAwASt+ZJVyIvdsrty+tfktzmG9hrTGKq1ExKK5OAUHm2AEh2Y66zHloHT12
 tITg==
X-Gm-Message-State: AOJu0YwYZzoNcGHmbu/2uXXVqwjSxo1bldEn3HYu58RjY+0GK7+gIlSU
 YD651Mjz1UJk6fe7r/2yDq7ogwmiZm+ICwYzSrjYg8XMBs7jPf+hEn9SDx8/6AAV
X-Gm-Gg: AR+sD13nnPAvEklAecMfuhM6iT10CQs+0TH2pD+xH21pYwIbl+pho326MGRe5wcHW16
 //ZGAtKSrfs1mCBMQ/2ODgviAON+ENkSeiN+VwkZe2ZM3ObosORARe7LSEqbPKP9+A1UZtjX6US
 IA1NdO9XHBqazXAxodqU5yCCFA3MRXXAAw8gIreGoV5+CFCcOTfHiU8cCOd0wkoO7wawcx/cYEN
 HHA7KN6sv5RbG7goZMApscsF0x2nyCERRGYQB8fHNsGBYfiGsC+HJSqmLi2CRtIiySPr3lKg9vY
 RMgS2CxQjzLYxddhjBb1qdR9pViAN+jqWaph7iA6kDWBg5dmqyJJNC15eMRt7NPYR3tSPk2Zvdj
 /uXOT+P+5yIpgvNOVJD2VVI9WGukXCtreaokD51c+slWvaV1dvXZCYOow0yuggQXEjJIB0J0GQX
 cc8xfDFtXV7LHFzmB1xjlrUkcfZr2+Kr77
X-Received: by 2002:a05:6102:442a:b0:643:80f1:350a with SMTP id
 ada2fe7eead31-7503dc56890mr807652137.2.1784940158906; 
 Fri, 24 Jul 2026 17:42:38 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:38 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 16/19] hw/net/bcm2838_genet: fix bogus RX checksum reporting
Date: Fri, 24 Jul 2026 20:42:15 -0400
Message-ID: <20260725004219.66222-17-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

bcm2838_genet_rdma() reported the received frame's IPv4 header
checksum (in host byte order) as the descriptor's rx_csum value.
The guest driver's CHECKSUM_COMPLETE path expects a running checksum
over the L4 payload there, not the L3 header checksum, so the
mismatch made the guest reject otherwise-valid inbound packets
("hw csum failure" in dmesg, from bcmgenet_rx_poll()), breaking
DHCP and general connectivity intermittently.

Report no hardware-computed checksum instead (rx_csum = 0), which
makes the guest fall back to verifying checksums in software; this
succeeds since the packet data itself was never corrupted. Drop the
eth_get_protocols() call and its output variables along with it,
since isip4/ip4hdr_info were only ever used to compute the checksum
value being removed here.

Confirmed with the guest booted repeatedly: "hw csum failure" no
longer appears in dmesg, and ping to the gateway succeeds with 0%
loss.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/net/bcm2838_genet.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index e34c1810..6f8f4e5b 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -821,12 +821,6 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
         MemTxResult mem_tx_result = MEMTX_OK;
         uint8_t *frame_buf = dma_buf + sizeof(BCM2838GenetXmitStatus) + 2;
         BCM2838GenetXmitStatus *xmit_status = (BCM2838GenetXmitStatus *)dma_buf;
-        struct iovec iov;
-        bool isip4, isip6;
-        size_t l3hdr_off, l4hdr_off, l5hdr_off;
-        eth_ip6_hdr_info ip6hdr_info;
-        eth_ip4_hdr_info ip4hdr_info;
-        eth_l4_hdr_info  l4hdr_info;
 
         bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
         size_t buflength;
@@ -837,12 +831,6 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
         }
 
         memcpy(frame_buf, buf + len, l);
-        iov.iov_base = frame_buf;
-        iov.iov_len = l;
-        eth_get_protocols(&iov, 1, 0,
-                          &isip4, &isip6,
-                          &l3hdr_off, &l4hdr_off, &l5hdr_off,
-                          &ip6hdr_info, &ip4hdr_info, &l4hdr_info);
 
         len += l;
 
@@ -868,10 +856,19 @@ static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
                                          MULTICAST,
                                          !!is_packet_multicast(frame_buf, l));
 
+        /*
+         * Report no hardware-computed checksum. The IP header's own
+         * checksum was previously (incorrectly) stored here, but the
+         * guest's CHECKSUM_COMPLETE path expects a running checksum over
+         * the L4 payload, not the L3 header checksum -- and it was stored
+         * in host byte order besides. That mismatch was causing the guest
+         * to reject otherwise-valid inbound packets ("hw csum failure" in
+         * dmesg, tied to bcmgenet_rx_poll), breaking DHCP/connectivity
+         * intermittently. Leaving this at 0 makes the guest fall back to
+         * verifying checksums itself in software, which succeeds since the
+         * packet data itself is intact.
+         */
         xmit_status->rx_csum = 0;
-        if (isip4) {
-            xmit_status->rx_csum = ip4hdr_info.ip4_hdr.ip_sum;
-        }
         xmit_status->length_status = desc->length_status;
 
         mem_tx_result = address_space_write(&s->dma_as, dma_buf_addr,
-- 
2.47.1


