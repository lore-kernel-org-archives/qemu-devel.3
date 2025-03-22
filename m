Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BD5C35FFC
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Mar 2025 06:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvsdm-0006V9-0u; Sat, 22 Mar 2025 02:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tvsdj-0006Uz-VC
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 02:47:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tvsdh-0006oU-OL
 for qemu-devel@nongnu.org; Sat, 22 Mar 2025 02:47:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224171d6826so25773385ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 23:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742626044; x=1743230844;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HlJaKT6chzFZB7kBHf/avw4HERGs/FORckTxDZzElJc=;
 b=kNf7tdpgHvEUlvtk2eTtJYjYamQK80T5BrzgHyaEZjwZU5+IrQdIn0i3Fe+U5O4Ltz
 YafNl49VVqUzoVJd/R5WQYcWsBRvi7Mn5BVKmNcspc+9fH/nyibXbfi6M3Jv9Qg3smFL
 e3I2yDcS5BMATn2u6yoRnTmRS6G+pwa9bspQwMXF2xE9qF7jbLXrqZWn8JO6D+wScrUe
 FfTygB0cs7N/FYG7OQ69rbPf46epS7GVnvmBG7iEhYgeY2afsPuAAIZiyaRdwryQXw5X
 Vdu6eYpim0rcO8HOuINeuzCSWaJoby56xG0f0MDxcyR0zMtRgRhW2e/PSiHKYe1fH2bI
 HCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742626044; x=1743230844;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HlJaKT6chzFZB7kBHf/avw4HERGs/FORckTxDZzElJc=;
 b=YPGXPMcRM1Dfb6RQfhu8KsaEsUiNRePYa8WVig67Q3+BpewxMmFtyzPjjbQQtn/r0k
 uRb57I45ZxHKNQYvTtXdKDPRwDcxqMwS3IYrwQYjbMCBajgU96AM5gOlviomwPlN+Vzw
 fvh7CXk/DX0vNH+b5S+RE+8+p+9vCJja1d2jE96OYpmnBIqFp48Lqc5r9GiRdTZkk0RU
 3bOTyvon1gtoKQzmJm6bQ9/z22lQqUe7f4xazsk5oViWiA0H1MdwsGzTH7K2hbPXD1l5
 968gTwzMOvANP6LXmJYAemMD7JazRxKUbYnt5ZjKXeqv0a7z3x3i61SKgN3aaH5cMLM2
 v6Ew==
X-Gm-Message-State: AOJu0Yzh5uKA/IVgKK6JOe8+hB+brepQrmBW00+2PraAl2/sxdwfD1rF
 BzrBJ/Bj+tXBjfisUK0TVwFMZjpS/DdiZthHnU1MCe4V6Ei1bgsrHK+968Dk+DY=
X-Gm-Gg: ASbGncufwXiWhv/FXEbUQxVHjAPtVNSpGtzv1Ta5zVa1TCC7/4XMKmWPtYJMyKBafNO
 ikKxbY8KEScU5NJkzjjjXDfEzvtBUIKtoYNrK1zYXvvy021la+c2C+h30hAL6jyM8fSHuhIyAQ1
 V6yLhVUhEsqg2C64rkl7y6yDKTcoaejDtd8vBQFCGvGuQWL012/HkJCiTVvaoLjxl/uL46vprwU
 rBCH+dxpKiaH/4eXW06mUJd2W0Rr2yDU0gMqKFyQrHh/Hbxfjydgg6UmbiTuS92mNvLeyBFcWnC
 glHxdnbe38RoAPGDIJVu0u6W0FCJAVlVpbojwrDEnMD2BsdsTSA=
X-Google-Smtp-Source: AGHT+IH0pOUAPbgFd4FMcrDI1tK9n700KatWZeeLVO/iHcWW0Pf/vMRE+FmcBvyhl0M7dumdUYAkow==
X-Received: by 2002:a05:6a20:a10c:b0:1f5:5614:18d3 with SMTP id
 adf61e73a8af0-1fe42f07bb6mr10954057637.8.1742626043788; 
 Fri, 21 Mar 2025 23:47:23 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73906159dd5sm3352274b3a.135.2025.03.21.23.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 23:47:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 22 Mar 2025 15:47:17 +0900
Subject: [PATCH v2] virtio-net: Fix the interpretation of max_tx_vq
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-vq-v2-1-cee0aafe6404@daynix.com>
X-B4-Tracking: v=1; b=H4sIAPRc3mcC/1WMQQ7CIBBFr9LM2jGFSm1ceQ/TBYXBzkKwYEibh
 ruL3bl8P/+9HRJFpgS3ZodImRMHX0GeGjCz9k9CtpVBtlK1nRSYFxyu2rmLU52YHNTjO5Lj9Yg
 8xsozp0+I29HM4rf+6VmgwN72Vg6KlJnM3erN83o24QVjKeULsaxuL5UAAAA=
X-Change-ID: 20250321-vq-87aff4f531bf
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

virtio-net uses the max_tx_vq field of struct virtio_net_rss_config to
determine the number of queue pairs and emits an error message saying
"Can't get queue_pairs". However, the field tells only about tx.

Examine unclassified_queue and indirection_table to determine the number
of queues required for rx, and correct the name of field in the error
message, clarifying its correct semantics.

Fixes: 590790297c0d ("virtio-net: implement RSS configuration command")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Handled unclassified_queue too.
- Added a Fixes: tag.
- Link to v1: https://lore.kernel.org/qemu-devel/20250321-vq-v1-1-6d6d285e5cbc@daynix.com
---
 hw/net/virtio-net.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index de87cfadffe1..afc6b82f13c9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1450,23 +1450,29 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    for (i = 0; i < n->rss_data.indirections_len; ++i) {
-        uint16_t val = n->rss_data.indirections_table[i];
-        n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
-    }
     offset += size_get;
     size_get = sizeof(temp);
     s = iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
     if (s != size_get) {
-        err_msg = "Can't get queue_pairs";
+        err_msg = "Can't get max_tx_vq";
         err_value = (uint32_t)s;
         goto error;
     }
-    queue_pairs = do_rss ? virtio_lduw_p(vdev, &temp.us) : n->curr_queue_pairs;
-    if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
-        err_msg = "Invalid number of queue_pairs";
-        err_value = queue_pairs;
-        goto error;
+    if (do_rss) {
+        queue_pairs = MAX(virtio_lduw_p(vdev, &temp.us),
+                          n->rss_data.default_queue);
+        for (i = 0; i < n->rss_data.indirections_len; ++i) {
+            uint16_t val = n->rss_data.indirections_table[i];
+            n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
+            queue_pairs = MAX(queue_pairs, n->rss_data.indirections_table[i]);
+        }
+        if (queue_pairs == 0 || queue_pairs > n->max_queue_pairs) {
+            err_msg = "Invalid number of queue_pairs";
+            err_value = queue_pairs;
+            goto error;
+        }
+    } else {
+        queue_pairs = n->curr_queue_pairs;
     }
     if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
         err_msg = "Invalid key size";

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250321-vq-87aff4f531bf

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


