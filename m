Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F119CD11BF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 08:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roJH4-0003YX-50; Sun, 24 Mar 2024 04:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1roJH2-0003YE-AD
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:32:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1roJGy-0007t3-0H
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 04:32:11 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e036b76725so25090385ad.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 01:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1711269126; x=1711873926;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g0enq4W44M6MdjsyHfcOnZ4DD9dK6N/N/JzR3bOOn5Y=;
 b=a6hOT4ocaHh7aCBWKTJburRQxSZ90NrrRjwhCrhLXw458SoHiA2ODZzTkEchL8t573
 jonOlka8n5oP7hdw+WjnIZlKvwc5JzvHFAH5GCUENNOuN775CcvYywmvG1ZA/gqnD4wd
 tvyZP6EIpa7vRNz98XGAFwTXNc62KvadqVUAPdsbcogCUqk17Hz73F0epGeE1ypdjOe1
 8PqxN8alYXFsvxfh1wE6iuXGbEalrMj+LZL1EyBaw972viOJPI4bu6N6CUlLpad1C2Zk
 /n1Lvx317BBNt7dUxFw9PmipAK8BLO0zDO/O2GpzC2VG5BkeBZ3lwd0vWxsQbp0Ve2wr
 2bpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711269126; x=1711873926;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g0enq4W44M6MdjsyHfcOnZ4DD9dK6N/N/JzR3bOOn5Y=;
 b=EI9SfpMEIpIOyxLB6+36sWCMgG2A2TVUoIHJsizM2w1vPRurDD65H2C6X9ocwH30ZK
 yLN7eS7jC1mvD0U2GIXZEv+9Tia1jzzHl4NCbsb4uZ20+EV4bjmoMXr93r+Hs4BwHojV
 2IfGFNHfY72rEh5xcnxZozcpt68Cr+bZ7TNmXLNpKgg9MJU+2I+/Hv89t0ugFaZg0zwN
 4RUsQXJEbVw+TChiLcd3YHGb5QSjGVQdpmQi4Jppx8oA/Qnfp0JaL/+7nYC9UQUIYgk5
 b329FyMqtBQ72m+WIODUE38oeD5VatK88bTi6u4Uj4hUSmQP9JJx//1gT0XDuZ7sblao
 PD4g==
X-Gm-Message-State: AOJu0Yy3RhDFQeo4wy5kEWHXRswMvsYM2JEuNi2fuSpWi2sK+lBpBclB
 gwQSikkzJa2q2wOJiD3rOWZf4ntEWhs2aJmAE3KEJ0jxfk/uyO7A7PqAepE35nM=
X-Google-Smtp-Source: AGHT+IHgrOgCln6bZGoMeVz0M7wS9laOFGF+ofBhoG2poQJdrOshs90gH5ECxcjZ3pWhYPSPGy3JYQ==
X-Received: by 2002:a17:902:e549:b0:1e0:b257:3261 with SMTP id
 n9-20020a170902e54900b001e0b2573261mr1501957plf.42.1711269126101; 
 Sun, 24 Mar 2024 01:32:06 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 kj5-20020a17090306c500b001dd59b54f9fsm2677855plb.136.2024.03.24.01.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 01:32:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 24 Mar 2024 17:31:56 +0900
Subject: [PATCH] hw/net/net_tx_pkt: Fix virtio header without checksum
 offloading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240324-tx-v1-1-a3b4135749ec@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPvk/2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMT3ZIK3WRT8xTjZCOjxBRzYyWgwoKi1LTMCrAh0bG1tQBFZ9a1VAA
 AAA==
To: Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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
checksum offloading is disabled so clear the bit. Set the
VIRTIO_NET_HDR_F_DATA_VALID bit instead to tell the checksum is valid.

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

The VIRTIO_NET_HDR_F_NEEDS_CSUM bit also tells to skip checksum
validation. Even if checksum offloading is disabled, it is desirable to
skip checksum validation because the checksum is always correct. Use the
VIRTIO_NET_HDR_F_DATA_VALID bit to claim the validity of the checksum.

Fixes: ffbd2dbd8e64 ("e1000e: Perform software segmentation for loopback")
Buglink: https://issues.redhat.com/browse/RHEL-23067
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/net_tx_pkt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 2e5f58b3c9cc..c225cf706513 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -833,6 +833,9 @@ bool net_tx_pkt_send_custom(struct NetTxPkt *pkt, bool offload,
 
     if (offload || gso_type == VIRTIO_NET_HDR_GSO_NONE) {
         if (!offload && pkt->virt_hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+            pkt->virt_hdr.flags =
+                (pkt->virt_hdr.flags & ~VIRTIO_NET_HDR_F_NEEDS_CSUM) |
+                VIRTIO_NET_HDR_F_DATA_VALID;
             net_tx_pkt_do_sw_csum(pkt, &pkt->vec[NET_TX_PKT_L2HDR_FRAG],
                                   pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1,
                                   pkt->payload_len);

---
base-commit: ba49d760eb04630e7b15f423ebecf6c871b8f77b
change-id: 20240324-tx-c57d3c22ad73

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


