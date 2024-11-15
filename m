Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D88DD6DDEA
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 09:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBsEd-0007VT-Rg; Fri, 15 Nov 2024 04:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tBsEc-0007VG-8N
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 04:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tBsEa-00078x-EL
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 04:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731661376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CYJMK1OszraRPmrzpwll4GWxaAFIji1Ru37zmkBW38o=;
 b=c0pL0WMqZimbs3yQKaTLl1xZPdvvH5747N9mzsgusbt7YfdnBpGK9eKk3yL+2xEccVX0YB
 Q7zw7HXOVn+yGx6bIDoRdyoaMbjDVBN2dlmX221R+kZwBl6/oKAv9bUw6AmEiy+PXykRY7
 wJAxDB8c7uQp49VcpOIcY21ZqhaX/WA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-C5-E4awfO0iCPUPx0arnFQ-1; Fri, 15 Nov 2024 04:02:55 -0500
X-MC-Unique: C5-E4awfO0iCPUPx0arnFQ-1
X-Mimecast-MFC-AGG-ID: C5-E4awfO0iCPUPx0arnFQ
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d3f38a1e62so7907556d6.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 01:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731661374; x=1732266174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CYJMK1OszraRPmrzpwll4GWxaAFIji1Ru37zmkBW38o=;
 b=ZzRfZWfz+kzc/jk9XFSNVgD++5H8yfN2NFaC20YlEMCYU20kqZjoVKEWPJoKy6mqS2
 K4Q57z1b8uB7HOyN4UMcwz1xerWf4mzjncy7CzCJR5rZ5cYVgRz9WsuMsQPw84Rw1HgY
 HCo2zzWmMWFqbvN7b1fW4A49sQmiIuop03QvVCLnThbRyMgtRr/eTjRsiJDMrOT/ZO5q
 xmhf2OBkhEM/K4uJVDwEXbxt+ZwI4lFUCK9QXGkb0WzOfpem4vAIyMsHj0VZ5Ncf+5Dp
 0qEQR1e5T3TG5X1dVtmMqnNQGdJ6FcRmGzXvT9HBkPeTNGe6aGLVDMxAWeVGZps1q5js
 ccsg==
X-Gm-Message-State: AOJu0YyovkdzhuItzFz8hv85VrjtG/nHuL4p1eGjtPe6QbQqgJseEPdQ
 JqZQHAWKtOH/W96XBsPKyj6mc/TqpwOj8/KJ/zYr6Jl5eQb0LAsphsqc9i4ayUOI9cWn/Eg8ZsP
 j2UTXcX05QwKHjIoBvFGcpsf12dVGUZelT5h+kZfnE5A+IVDAMySs
X-Received: by 2002:a05:6214:2c10:b0:6cb:c5f7:719 with SMTP id
 6a1803df08f44-6d3fb82124dmr22989546d6.27.1731661374740; 
 Fri, 15 Nov 2024 01:02:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfsOrOddyxmhAzzyxMZqjwnYtUQ+4IyzHJyC2cJD/SNPRtJk8yAyKnmTS6s+Qdc5qxa2g2oQ==
X-Received: by 2002:a05:6214:2c10:b0:6cb:c5f7:719 with SMTP id
 6a1803df08f44-6d3fb82124dmr22989276d6.27.1731661374316; 
 Fri, 15 Nov 2024 01:02:54 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it.
 [79.46.200.129]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3ee7a9db1sm15764706d6.39.2024.11.15.01.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 01:02:53 -0800 (PST)
Date: Fri, 15 Nov 2024 10:02:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Zuo boqun <zuoboqun@baidu.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Gao Shiyuan <gaoshiyuan@baidu.com>
Subject: Re: [PATCH v2] vhost_net: fix assertion triggered by batch of host
 notifiers processing
Message-ID: <vyu4kppkvadv6xwbn3eabx3uim6b4skbxxsmywvdwg7c7lfiko@mkfqo3gcdek5>
References: <20241115080312.3184-1-zuoboqun@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241115080312.3184-1-zuoboqun@baidu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
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

On Fri, Nov 15, 2024 at 04:03:12PM +0800, Zuo boqun wrote:
>From: zuoboqun <zuoboqun@baidu.com>
>
>When the backend of vhost_net restarts during the vm is running, vhost_net
>is stopped and started. The virtio_device_grab_ioeventfd() fucntion in
>vhost_net_enable_notifiers() will result in a call to
>virtio_bus_set_host_notifier()(assign=false).
>
>And now virtio_device_grab_ioeventfd() is batched in a single transaction
>with virtio_bus_set_host_notifier()(assign=true).
>
>This triggers the following assertion:
>
>kvm_mem_ioeventfd_del: error deleting ioeventfd: Bad file descriptor
>
>This patch moves virtio_device_grab_ioeventfd() out of the batch to fix
>this problem.
>
>To be noted that the for loop to release ioeventfd should start from i+1,
>not i, because the i-th ioeventfd has already been released in
>vhost_dev_disable_notifiers_nvqs().
>
>Fixes: 6166799f6 ("vhost_net: configure all host notifiers in a single MR transaction")
>Signed-off-by: Zuo Boqun <zuoboqun@baidu.com>
>Reported-by: Gao Shiyuan <gaoshiyuan@baidu.com>
>
>---
>
>v1->v2:
>    *To explain why the for loop to release ioeventfd starts from i+1:
>      1) add a comment in the code
>      2) describe it in the commit message

Thanks for that!

LGTM, but I don't know vhost-net enough so I'd wait for a comment from 
Michael and Jason.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


>---
> hw/net/vhost_net.c | 35 ++++++++++++++++++++++++-----------
> 1 file changed, 24 insertions(+), 11 deletions(-)
>
>diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>index 997aab0557..891f235a0a 100644
>--- a/hw/net/vhost_net.c
>+++ b/hw/net/vhost_net.c
>@@ -229,9 +229,24 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
>     int nvhosts = data_queue_pairs + cvq;
>     struct vhost_net *net;
>     struct vhost_dev *hdev;
>-    int r, i, j;
>+    int r, i, j, k;
>     NetClientState *peer;
>
>+    /*
>+     * We will pass the notifiers to the kernel, make sure that QEMU
>+     * doesn't interfere.
>+     */
>+    for (i = 0; i < nvhosts; i++) {
>+        r = virtio_device_grab_ioeventfd(dev);
>+        if (r < 0) {
>+            error_report("vhost %d binding does not support host notifiers", i);
>+            for (k = 0; k < i; k++) {
>+                virtio_device_release_ioeventfd(dev);
>+            }
>+            return r;
>+        }
>+    }
>+
>     /*
>      * Batch all the host notifiers in a single transaction to avoid
>      * quadratic time complexity in address_space_update_ioeventfds().
>@@ -247,16 +262,6 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
>
>         net = get_vhost_net(peer);
>         hdev = &net->dev;
>-        /*
>-         * We will pass the notifiers to the kernel, make sure that QEMU
>-         * doesn't interfere.
>-         */
>-        r = virtio_device_grab_ioeventfd(dev);
>-        if (r < 0) {
>-            error_report("binding does not support host notifiers");
>-            memory_region_transaction_commit();
>-            goto fail_nvhosts;
>-        }
>
>         for (j = 0; j < hdev->nvqs; j++) {
>             r = virtio_bus_set_host_notifier(VIRTIO_BUS(qbus),
>@@ -277,6 +282,14 @@ static int vhost_net_enable_notifiers(VirtIODevice *dev,
>     return 0;
> fail_nvhosts:
>     vhost_net_disable_notifiers_nvhosts(dev, ncs, data_queue_pairs, i);
>+    /*
>+     * This for loop starts from i+1, not i, because the i-th ioeventfd
>+     * has already been released in vhost_dev_disable_notifiers_nvqs().
>+     */
>+    for (k = i + 1; k < nvhosts; k++) {
>+        virtio_device_release_ioeventfd(dev);
>+    }
>+
>     return r;
> }
>
>-- 
>2.42.0.windows.2
>


