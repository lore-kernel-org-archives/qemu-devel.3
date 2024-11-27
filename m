Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E20D6ACD8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIY3-0003eq-F9; Wed, 27 Nov 2024 08:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIXx-0003dt-SW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIXw-0007hA-9W
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=toqdy82Y55iUyJz9RE8D3pVN23M/G0bs/onY8PVnesI=;
 b=I3FmuQA1gKseA51Lv3AMA8FLrpnRTDvAFIj07BM8noP/luC320BOgjSS1E31/vRqZLTYzB
 Gc5A410SEg7NAiyFmnxyEc0eQqE2tfHXNBjegTWtRevGNjrk5GRchT87zd9YBsj2JkdLDs
 DOq2gCLdLtyvViZF2lehmOcqTyG4Tjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-K4sLnw8HMiKCj0OYeTF8hA-1; Wed, 27 Nov 2024 08:57:33 -0500
X-MC-Unique: K4sLnw8HMiKCj0OYeTF8hA-1
X-Mimecast-MFC-AGG-ID: K4sLnw8HMiKCj0OYeTF8hA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4349d895ef8so35419465e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715852; x=1733320652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=toqdy82Y55iUyJz9RE8D3pVN23M/G0bs/onY8PVnesI=;
 b=poydHEOQw06pbEUqeSnYM6tubQeXEgiiSvzL5Ue73jkeceTM9sTtNY5GtcRJgrcgQw
 6JOz1jnGIsFSzH99auTu1oNZ3AdfWLGvMe75Z/CBzVUm6wtszdVm5T/0k9tQPFKg4eP+
 t0InmeXMQhpQzOebT0ZuarYwT+P1le141t7W4YLlzzLFJ8AS1HpxFtTkBy8mas5nJEFn
 cJ9cR6i0roUIkJH8Ilaa1SrzJoxodJ1hvEDBeliLYRRCz359GIF7k+dNbeOpCFMUCSGt
 VP2jKylsZg6sZUxCQK1xywN/yLAOYQdLrEeL2mHosvsph8KQ4W/1HA8TEA7fPUIsTRyc
 l5hQ==
X-Gm-Message-State: AOJu0Yw5EPJwEMjqkWItgeoMjK489Mq1zayUxHl0q3nLA4u3soR+WTxP
 xKkNNNIuj88wMkK5GlzCV5k4kWQ4L3kh9lYlUJiIAwoCGB6cc6pWQhk/doJyVAmJuBntLwMj/SJ
 HpC/ZcOzcjAaraCfBEX8ugoTrata6voIi0d9bM3qyAww6qFiZHJDaiLEafhkH/7HXAdSMrA55mt
 Vg73SWMmTKyo5Ho8Pbqtrw0f31AXysuEy8
X-Gm-Gg: ASbGncsRDZ17WHK+xMGeRChO642L7SCdmiJBCPeU10SlGJazmHSC6EJJoQxOwhrWfu8
 nzWqmig6Z7OPqJC9kkn6U8GwWZiLnfbteVA2VSMXAmhevWilv25GYcs+OKFZs80yTvCdl/AnE7C
 JH5Sljr3yeRYiwB1vqRmUSvXynUR49BKqmcBl7yBrLlqv3sGHLQDxyBnokWW9M/8+Wvw0dY0haZ
 A1Vvzpgmf64OkAqD0HdV0eZoyWL18R0sKaVrUfbOu68
X-Received: by 2002:a05:600c:4f12:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-434a9de8601mr27605775e9.22.1732715852326; 
 Wed, 27 Nov 2024 05:57:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNgjYU7nfRqAFwfmEvL9HfqW5GMuNiUVj84Jwzcu+4+Adu/CsUKRoQkpUS7aX3NNJJd3TN2A==
X-Received: by 2002:a05:600c:4f12:b0:431:542d:2599 with SMTP id
 5b1f17b1804b1-434a9de8601mr27605465e9.22.1732715851858; 
 Wed, 27 Nov 2024 05:57:31 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7fa3d4sm21961015e9.44.2024.11.27.05.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:31 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, zuoboqun <zuoboqun@baidu.com>,
 Gao Shiyuan <gaoshiyuan@baidu.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 01/13] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Message-ID: <16f6804c460109e8b126cc710a0072f9f83bd230.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: zuoboqun <zuoboqun@baidu.com>

When the backend of vhost_net restarts during the vm is running, vhost_net
is stopped and started. The virtio_device_grab_ioeventfd() fucntion in
vhost_net_enable_notifiers() will result in a call to
virtio_bus_set_host_notifier()(assign=false).

And now virtio_device_grab_ioeventfd() is batched in a single transaction
with virtio_bus_set_host_notifier()(assign=true).

This triggers the following assertion:

kvm_mem_ioeventfd_del: error deleting ioeventfd: Bad file descriptor

This patch moves virtio_device_grab_ioeventfd() out of the batch to fix
this problem.

To be noted that the for loop to release ioeventfd should start from i+1,
not i, because the i-th ioeventfd has already been released in
vhost_dev_disable_notifiers_nvqs().

Fixes: 6166799f6 ("vhost_net: configure all host notifiers in a single MR transaction")
Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
Reported-by: Gao Shiyuan <gaoshiyuan@baidu.com>

Message-Id: <20241115080312.3184-1-zuoboqun@baidu.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/vhost_net.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 997aab0557..891f235a0a 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -229,9 +229,24 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
     int nvhosts = data_queue_pairs + cvq;
     struct vhost_net *net;
     struct vhost_dev *hdev;
-    int r, i, j;
+    int r, i, j, k;
     NetClientState *peer;
 
+    /*
+     * We will pass the notifiers to the kernel, make sure that QEMU
+     * doesn't interfere.
+     */
+    for (i = 0; i < nvhosts; i++) {
+        r = virtio_device_grab_ioeventfd(dev);
+        if (r < 0) {
+            error_report("vhost %d binding does not support host notifiers", i);
+            for (k = 0; k < i; k++) {
+                virtio_device_release_ioeventfd(dev);
+            }
+            return r;
+        }
+    }
+
     /*
      * Batch all the host notifiers in a single transaction to avoid
      * quadratic time complexity in address_space_update_ioeventfds().
@@ -247,16 +262,6 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
 
         net = get_vhost_net(peer);
         hdev = &net->dev;
-        /*
-         * We will pass the notifiers to the kernel, make sure that QEMU
-         * doesn't interfere.
-         */
-        r = virtio_device_grab_ioeventfd(dev);
-        if (r < 0) {
-            error_report("binding does not support host notifiers");
-            memory_region_transaction_commit();
-            goto fail_nvhosts;
-        }
 
         for (j = 0; j < hdev->nvqs; j++) {
             r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
@@ -277,6 +282,14 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
     return 0;
 fail_nvhosts:
     vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);
+    /*
+     * This for loop starts from i+1, not i, because the i-th ioeventfd
+     * has already been released in vhost_dev_disable_notifiers_nvqs().
+     */
+    for (k = i + 1; k < nvhosts; k++) {
+        virtio_device_release_ioeventfd(dev);
+    }
+
     return r;
 }
 
-- 
MST


