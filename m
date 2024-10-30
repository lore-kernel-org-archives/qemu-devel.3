Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533F0D5CCA1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 12:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t67aI-0006FT-Uh; Wed, 30 Oct 2024 08:13:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1t67aH-0006Es-98
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:13:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1t67a6-0001yP-3p
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 08:13:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso5359385e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 05:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1730290422; x=1730895222;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NEtNNRhk3oARf+NZZV/gSBCAAapOZPq/h8+CAdpnQDU=;
 b=zKTt1p7M1aZ4sjn5PMKS+4nBOoNMsMeVckzHRbR4fR7CxHfJIZnQgZEathJgIAAnCE
 6Xdk0Rr/xE39t+aMFsGUIK1JaEujup8Kpn7E7C/vzOAOQkCjnAdZDBQ+bVulnwK/70Ol
 LR8JX3DsK5Z3niBDbtIYFO1QOO/cVDnDg8+HBqcBuwEO2KPrAlSYUWRCpYX0vu93zKWs
 g2a3p1OOGate0QMTMiYa/nQlctaNbXQbAC2l47oC2Hks10AU9cEqoIS3FCmIEL8g6/dF
 4enESA2LRVc2H5eirJKB3Owxy+cubf8AA9ggwXCKSPMzcPyGmkc1k16Sa0yA0U78S4j3
 4Q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730290422; x=1730895222;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NEtNNRhk3oARf+NZZV/gSBCAAapOZPq/h8+CAdpnQDU=;
 b=PIQLo8YQSm4cgU1VIJh4e0S5+SB+QeLFKPfJziyMN1zFBKQ5VB2AeyX/X9G5nGEMSM
 rdmlsKMfdt3DcYzaQeqMogSPtS5xFjO40JDsGHWVQOAW54/JKGZOSHwnGL6ufPfzQhUw
 Tde1Wqy+gOyvAV8a/JIalB1NMRIJhG/kUM+jZ2K5DdrLjc3x9ObbmXo4Q+/QNjpb5L5V
 4rG1OCrSEcB1yDl6M9D2w5whroIW3h0tPKJvGbbiLKlgAT+j/1loU9JWPuS71HosAnzh
 3kDwxCu35Y1CleV99Wc6g+X6bN139E5B7C4NE2a+VcYrE3v+7y6LdJfQgynBOsjANMhM
 1WhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa/4AVzdGU69tCzrmdc7fzEdv2B9PTcrmT4M/iwr/vKmUL7+nP3FRsGHknwM14PgfK3RpqZwMt5XUV@nongnu.org
X-Gm-Message-State: AOJu0YxyRwYn0mDyH2jNMjKbn+ll66E4MQbEin+wf17uq8GK3uEjUuKi
 434sjv+0s3JRNIjcGkY59jW6kp1qTI7lrWu67eg/RE+dJv8/hOEd+UeCp7yuaRE=
X-Google-Smtp-Source: AGHT+IEy8MNqgKoK4/7QbROaR5vuBLPIbPjbJxS6pIUDPd3HLEc4qj+7FHKFhx1yuN4q8BDbQc4wwQ==
X-Received: by 2002:a05:600c:3110:b0:431:5475:3cd1 with SMTP id
 5b1f17b1804b1-431b583b3e1mr44934315e9.17.1730290422090; 
 Wed, 30 Oct 2024 05:13:42 -0700 (PDT)
Received: from rhel9.redhat.com ([2a06:c701:46c8:3f00:ea9a:3189:41ff:b349])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e8471sm20144845e9.4.2024.10.30.05.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 05:13:41 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, akihiko.odaki@daynix.com
Cc: yan@daynix.com
Subject: [PATCH] virtio-net: Fix missing hash type and hash value
Date: Wed, 30 Oct 2024 14:13:34 +0200
Message-ID: <20241030121334.134794-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::333;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wm1-x333.google.com
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

virtio_net_receive_rcu does not populate hash value and
hash type in case it needs to change queue number from the
initially defined by tap/tun to one calculated according
to the packet hash. Earlier commit a4c960e places the hash
value/type into local extra_hdr structure but the extra_hdr
is not filled in recursive call to virtio_net_receive_rcu.
Current commit discards the recursive call and just continues
execution with changed net client state and uses correct
virtio-net queue for the packet.

Fixes: a4c960e ("virtio-net: Do not write hashes to peer buffer")

Jira link: https://issues.redhat.com/browse/RHEL-59572

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f2104ed364..ed4e33b48c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1898,7 +1898,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
                                       size_t size, bool no_rss)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
-    VirtIONetQueue *q = virtio_net_get_subqueue(nc);
+    VirtIONetQueue *q;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
@@ -1915,12 +1915,13 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
-            NetClientState *nc2 =
-                qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
-            return virtio_net_receive_rcu(nc2, buf, size, true);
+            /* change nc to proper one */
+            nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
         }
     }
 
+    q = virtio_net_get_subqueue(nc);
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;
-- 
2.43.0


