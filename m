Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9CDC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 08:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpOsF-00064V-D6; Wed, 27 Mar 2024 04:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpOsE-00063c-6R
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:43:06 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rpOsC-00028p-Ba
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 04:43:05 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso3881193a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711528983; x=1712133783;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wbkgDXFeXsPmaZBtfcWwcpqjP0ZmogyH1OIRJQCRsN8=;
 b=RGeEmteZPlMrSjDL1qQC0ZeOgY/ujCZAFakKAXD7cm8Zn3zx6iqhx1LVHsB0x5QKmu
 E7p3HlVC32lEQKwr0YYafxmxoXU31oxxKUpon7ZCF2Co3nV0D1lg0F6KQf8zp9DcDNjS
 XD+gXaboqGvn7chEy3TU7zPS4/YYiETtQ/egYbFSUmiT4NxeGG+YMyEIiZNBiO+68hTl
 fPd9hpNShnrCQgx5HHrjEWfVSZnuHA/G6wHS35Ypf1N7qfGjf66x/Q2hXInu++7dj9M0
 lXdkGdRM/pI4q+daxZ/p8WbzGM/ct3O0RwO96iGT9lIQnOrfigWP05gAFqW8pI9CKayp
 49Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711528983; x=1712133783;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbkgDXFeXsPmaZBtfcWwcpqjP0ZmogyH1OIRJQCRsN8=;
 b=aNQ0JGaaHXYoNCNJLBBGlrPFMNMQiH2VOXo4+UIEuq0JPk5laCD3lt5FgUDYbAR/0N
 k9b3fg5oaveujRnVsABAyWyXnr6j75K08+OVooqZiIMd6r6N875+1TBXvtggGjznbaJd
 CLR407CscIOpzfWyxLFidlxYfA7KMmqLdKxSstn3OmdYXtprn6YS0tnF+r+TFzlPiqJ9
 ZYorUhi1TrYsrZGkDE6+bIYrZ/2oHvfJ5NtuOb/bdbqjIo/cCMymdDalVd4Ds1gNyK40
 QdugFcuZQnM8vJrV5k4zFAYcpHPg4ToFYPoSGkP2xVaMvfcY7Bp0Jn79OW8rnbFwySY8
 GhIw==
X-Gm-Message-State: AOJu0YzfSmtMN0XiM66CsINDOkVW6UgCQ6RMNIHcpcQCb1J60l2JkEMG
 r5wSOtabeM2LL/K6h/TQN87BkEyXku0J6lGgQGPC8FxeIXxuu7Q6eRQVMzrxNoU=
X-Google-Smtp-Source: AGHT+IHinlMP7bQ+Me7uhFyzYP8xG9NxGgKPjHddsxbIrHV/0415ovfKf9FoTjOld8TW9wgWlFf+/Q==
X-Received: by 2002:a05:6a20:a781:b0:1a3:a039:d11b with SMTP id
 bx1-20020a056a20a78100b001a3a039d11bmr1848275pzb.24.1711528982762; 
 Wed, 27 Mar 2024 01:43:02 -0700 (PDT)
Received: from localhost ([157.82.202.248])
 by smtp.gmail.com with UTF8SMTPSA id
 s8-20020a170902ea0800b001dc3916853csm8290173plg.73.2024.03.27.01.43.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 01:43:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 27 Mar 2024 17:42:56 +0900
Subject: [PATCH v2] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-tx-v2-1-b69ad4e434f1@daynix.com>
X-B4-Tracking: v=1; b=H4sIAA/cA2YC/1WMQQ7CIBBFr9LMWkwZaIiuvIfpAmG0sxAMNISm4
 e5idy7fz39vh0yJKcN12CFR4cwxdMDTAG6x4UWCfWfAEfWoUIu1CjcZrxyi9UZBP34SPbkekfv
 ceeG8xrQdzSJ/659epJDCqoeWajL6Qu7m7Ra4nl18w9xa+wJEtuwIlQAAAA==
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is incorrect to have the VIRTIO_NET_HDR_F_NEEDS_CSUM set when
checksum offloading is disabled so clear the bit.

TCP/UDP checksum is usually offloaded when the peer requires virtio
headers because they can instruct the peer to compute checksum. However,
igb disables TX checksum offloading when a VF is enabled whether the
peer requires virtio headers because a transmitted packet can be routed
to it and it expects the packet has a proper checksum. Therefore, it
is necessary to have a correct virtio header even when checksum
offloading is disabled.

A real TCP/UDP checksum will be computed and saved in the buffer when
checksum offloading is disabled. The virtio specification requires to
set the packet checksum stored in the buffer to the TCP/UDP pseudo
header when the VIRTIO_NET_HDR_F_NEEDS_CSUM bit is set so the bit must
be cleared in that case.

Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback")
Buglink: https://issues.redhat.com/browse/RHEL-23067
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Dropped VIRTIO_NET_HDR_F_DATA_VALID. (Jason Wang)
- Link to v1: https://lore.kernel.org/r/20240324-tx-v1-1-a3b4135749ec@daynix.com
---
 hw/net/net_tx_pkt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 2e5f58b3c9cc..2134a18c4c90 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -833,6 +833,7 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
 
     if (offload || gso_type == VIRTIO_NET_HDR_GSO_NONE) {
         if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+            pkt->virt_hdr.flags &= ~VIRTIO_NET_HDR_F_NEEDS_CSUM;
             net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
                                   pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1,
                                   pkt->payload_len);

---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240324-tx-c57d3c22ad73

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


