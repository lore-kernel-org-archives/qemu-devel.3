Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29C4E65D26
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 05:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tELpS-0005uS-92; Fri, 22 Nov 2024 00:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpH-0005gT-Fj
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:28 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tELpF-0006Sb-Pe
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 00:03:27 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3e5fbc40239so1022579b6e.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 21:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1732251804; x=1732856604;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aydS1nIFZysizdq/nBxIGIRe/Qf80XxmCfhRmPTZ8i4=;
 b=wOk1FlECEOpwgWB5zEGdZCYTcNAYz5WkGFFGmSlsKHBSIVOgqzRD/QEIFNqMvRFINw
 ZZAr3lJC96PVDUW2apoYltcj0TPqJMlOPlQGF25cyAYhArDU2FyOsKV50Iw2fqcg7mc9
 60qjlelSd5iWRzAVVEoq0PvziXj2A/5ycfe2/235X14vQ7XUcoWUD5QhyWUjhOwExGmA
 RDJR3ftllGZ5d5L1Dl49z3AcXmHzqVzID/isVbw6Snea3TFGGqFn08UtpKXU/AdEB7ze
 LwppqRZprHcTz17WTgp6oHlgZ/rPEkLvKYr+R31mkTPxyTvNmhLvUv78VHcs7j/Ks+bC
 PXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732251804; x=1732856604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aydS1nIFZysizdq/nBxIGIRe/Qf80XxmCfhRmPTZ8i4=;
 b=ebmDam8+hZTvYHlA3I4m2FnzKQkl+ouuWfrizBrNxO8JJpx3eeTzW6txgW4poN5u5s
 p34VBBvSpd7GdOpj6jdHlWIyolnAtfHAdwdlV0l5T1x7B5HwNaSFCJ2hYQ4oVzm5hX4F
 asdg4qei/p8XXU8FavzWn3J1e8wnu9YindF07+8eXn+apBLN2LvImRhTu48AP+mKSpzF
 8o4bK218m/LnrqwNZ6vm5OLEKqXcv1yM08G9xCL6rVM3kc7J3Jv72wGHf372M3AFIm3D
 2jQ/nNjgmHmrKg9bUaQ+Pjv5eFHjw+znXX2M51XB+Wn9zZ6RxJafHqFFVnuidTE/U/Oz
 akRA==
X-Gm-Message-State: AOJu0YwGIWEUqlWyvw12GrqN3pBhRfRL3xbEDKVIOyrakf82xOxKMTkd
 SFkwoBlFrXo7XmWHcSsQq1QKrZMoGMWODdn8UJHrjp2OwSwgNUlLgbFPBRqzfivmk0AjGfFJkQu
 jF18=
X-Gm-Gg: ASbGncuSGe7pW0JbpkV2k2DbwSwlZXfCTiqAYSugoEyffknqHdTR+LLnDrT3c1hdYH7
 04+Hr/CZlv5wk+v2muGF8KSE9CJBLv9nj4q2C0d18zkNAoc5fB2out1gj+Y0SiEAckueQisxeGp
 HHZoXk0ZY4JpiVkrPCkcJLgIgEug9wGqSfKeNlU8vduwL29brzY3u+MPMDhTaY+Yro+v/ja2que
 jRWYRLHWJzrmJyh3mPPe/fdhw/Gxi8zL8viAGAJgjefCT4eUWdboQ==
X-Google-Smtp-Source: AGHT+IHpQmyuEUl7ZY7IQgoZ44mIjfwxuXcIKwAs/YISw8GDNwPYV1qaN8Vf7okuxWynyJunmfUp5A==
X-Received: by 2002:a05:6808:1210:b0:3e6:5f5:5e25 with SMTP id
 5614622812f47-3e9158395a3mr1914216b6e.19.1732251804221; 
 Thu, 21 Nov 2024 21:03:24 -0800 (PST)
Received: from localhost ([157.82.207.167])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-71c03790782sm286676a34.40.2024.11.21.21.03.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 21:03:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 22 Nov 2024 14:03:10 +0900
Subject: [PATCH v3 4/6] virtio-net: Fix hash reporting when the queue changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-queue-v3-4-f2ff03b8dbfd@daynix.com>
References: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
In-Reply-To: <20241122-queue-v3-0-f2ff03b8dbfd@daynix.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22d.google.com
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

virtio_net_process_rss() fills the values used for hash reporting, but
the values used to be thrown away with a recursive function call if
the queue changes after RSS. Avoid the function call to keep the values.

Fixes: a4c960eedcd2 ("virtio-net: Do not write hashes to peer buffer")
Buglink: https://issues.redhat.com/browse/RHEL-59572
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d4aaf362b70f..b544d2e91a77 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1898,10 +1898,10 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
 }
 
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
-                                      size_t size, bool no_rss)
+                                      size_t size)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
-    VirtIONetQueue *q = virtio_net_get_subqueue(nc);
+    VirtIONetQueue *q;
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     VirtQueueElement *elems[VIRTQUEUE_MAX_SIZE];
     size_t lens[VIRTQUEUE_MAX_SIZE];
@@ -1911,12 +1911,10 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
     size_t offset, i, guest_offset, j;
     ssize_t err;
 
-    if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
+    if (n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size, &extra_hdr);
         if (index >= 0) {
-            NetClientState *nc2 =
-                qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
-            return virtio_net_receive_rcu(nc2, buf, size, true);
+            nc = qemu_get_subqueue(n->nic, index % n->curr_queue_pairs);
         }
     }
 
@@ -1924,6 +1922,8 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
+    q = virtio_net_get_subqueue(nc);
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;
@@ -2049,7 +2049,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size, false);
+    return virtio_net_receive_rcu(nc, buf, size);
 }
 
 /*

-- 
2.47.0


