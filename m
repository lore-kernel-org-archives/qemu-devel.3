Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A628C88E75
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68QJ-0003bv-O1; Mon, 14 Sep 2026 11:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68QH-0003bX-SO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x68QE-0001jj-4N
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 11:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789398999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xaQaNyymAKaKCe8NZv+/t9PaI8asE2lKCyCEiRXEsRQ=;
 b=bw0eJXbpvNeeuFLO/DDz2v4UF+voZ1RhmtZhc2TXUvJ4NcRkQHrhFSbV9q/hXlUnpfdJsM
 pR6pbB6AI76b/NH2lkVZyMXiEDI96CoR2hPRVOSWiCcLCmlREEZbwHMTYJdkYfWkUTNoNO
 fgqzyC8XfkerEguoYM2v71TtsjTzQXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-uq2EQKxcOdeJj52ydudWVQ-1; Mon, 14 Sep 2026 11:16:38 -0400
X-MC-Unique: uq2EQKxcOdeJj52ydudWVQ-1
X-Mimecast-MFC-AGG-ID: uq2EQKxcOdeJj52ydudWVQ_1789398997
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994d67d0e3so27789625e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789398997; x=1790003797; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xaQaNyymAKaKCe8NZv+/t9PaI8asE2lKCyCEiRXEsRQ=;
 b=rYsR0Z8Xb51o3vZWhDNnIeYVFND0JBhb8NJwPEBdGH/do4e8Db4b1DX1UcF/pnd2hH
 3n75QLupoLtXOjEdbToSgP3yWIBmyXiNzawTmr4ThSJ74Q8U/GWRD+M7wGdexkGxxh+1
 gzSBlRLBR5io24+qUqcOqb3StoPORq7d6SwTImfMKlmtfKmufu3ZvoWDB3AbQeB7TdKL
 BqgMV185cReOrJg3fzQGltetC1sgjQsIK2BVwuohHNum26YM8tdvNUUamnQBkyH4r/90
 EdhwxqVqFaa58LH8n6Dq754IQ37IXMJJI8iU8WGEYtNnD5HOKXfz9Ts/ifJlyqQvn93k
 1/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789398997; x=1790003797;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xaQaNyymAKaKCe8NZv+/t9PaI8asE2lKCyCEiRXEsRQ=;
 b=K3dr0Ip63clPL6DWxWk2jXSe3AQskYSu5QT4+msBzzQ75wZ7u9IDD195q7n9QWOo/m
 COM5otY1hqhhWrY8NXXmsLlM8BhwOGP4vCF2YK0IoBYYF9s3j1Kq0QzN7SXmhrZEoopQ
 PJzsakHBJRmEOlVQwX/EYPIwI//YalKgchJNe3EgLXiUJqoVDIUMJBGE0Jdtt8Za2WZB
 r4uTj30G3fgaCy26usKmwyp8TFQs0ld1HMqqQ2Ali6Tco7wHyNH4qmf6vzkzEao8+kzs
 p1aI6JVKAK/R2d0QxAcc8A9KeEsWOYJn+sXDF72m9mCLL+rJLVb1WlargxSwdtO3myXH
 EieQ==
X-Gm-Message-State: AFuF++mJiZsHGWI/65muUdQfLRac1XRTblg+ZysX05Sn2clvjwhic6iI
 P6vce0z+cgLqQ/wO0Mb4p0u6qLJxJz6XmgJlRjiCO2FKrDWDsmtlT1YlIHkHhM3OU92gL4YTBk/
 FgSHBRdu7yllR198ZwPqhkx5uyRGPPySTcGAKDJmkVnP5z9YoF83rsEbi
X-Gm-Gg: AYBFou0h4nEIjIvjg0Zrvtl/3wllWiLQKC+rd7mMxFI6lEiwSmKdntsM9TrC3/LVnyT
 qMLAHXdp6TP3IngXtFKGZTJ2jsfXFa0Rz3vf8eawafZ2atQLeS5qq2TOYxtArwk+4j+ntewPScj
 8dqAqU7H11XHOmuyPIqQB/8tmROEWHE8IBThVuQ6q7v6bbrz0nDZiJ+20hbbB/ucUxwlGwrHj2M
 TXgC+yBS4GC0OuMnzZpKxRzbXJ4dtorafpyjz0Zwaz5cvgdJ+Ok0GUSSrGiobkLs6Y5NcmQlZAV
 dNgUGo2Sln070aVS8QrX1yBnKCJQumelJUTQqhXEobkHNd3ZRym79YiTQDNPO7eBEGa+nleuZWX
 cmZ8/RQOOI1oxjNKL+l4jv7HovlDGuo7JImFqoxhLJn24hQ==
X-Received: by 2002:a05:600c:5489:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49e7a662f07mr32693895e9.12.1789398996990; 
 Mon, 14 Sep 2026 08:16:36 -0700 (PDT)
X-Received: by 2002:a05:600c:5489:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49e7a662f07mr32693315e9.12.1789398996503; 
 Mon, 14 Sep 2026 08:16:36 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d52f335sm123235e9.0.2026.09.14.08.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 08:16:35 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:16:30 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, bchaney@akamai.com, mark.kanda@oracle.com,
 den@openvz.org, 
 farosas@suse.de, peterx@redhat.com, clg@redhat.com, dongli.zhang@oracle.com
Subject: Re: [PATCH v5 09/14] vhost-vsock: preserve vhost FD during CPR
Message-ID: <aqf9QkwF9J8SkHA4@sgarzare-redhat>
References: <20260914-up-vsock-vhost-v5-v5-0-d17423589f48@virtuozzo.com>
 <20260914-up-vsock-vhost-v5-v5-9-d17423589f48@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260914-up-vsock-vhost-v5-v5-9-d17423589f48@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 14, 2026 at 11:37:40AM +0300, Andrey Drobyshev wrote:
>During CPR (checkpoint-restore) migration the guest keeps running on the
>same host, so instead of reopening /dev/vhost-vsock on the destination,
>we should reuse the FD from the source.  The FD is saved in the CPR
>namespace (hash table) with cpr_save_fd() and then reclaimed on the
>target via cpr_find_fd().
>
>Since the key in CPR hash table is the (prefixed) device ID, CPR needs a
>unique ID.  Thus we only preserve the FD with cpr_{save,find} if this ID
>is present.  In a following patch, when we lift the CPR migration blocker,
>we're going to condition it on the presence of ID.
>
>vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>Deferring the ownership handoff to pre_save/post_load is done in a
>following patch.  Until then CPR remains blocked, so the restore path
>added here is not reachable yet.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c | 30 +++++++++++++++++++++++++++++-
> 1 file changed, 29 insertions(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index 3ec20d87606..203055354ae 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -69,6 +69,10 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>     return 0;
> }
>
>+static char *vhost_vsock_cpr_name(DeviceState *proxy)
>+{
>+    return proxy->id ? g_strdup_printf("vhost-vsock/%s", proxy->id) : NULL;

Sorry, I should have asked in previous reviewes, but is it okay to use 
the proxy in any case?

IIUC this will work well with `vhost-vsock-pci`, but what about MMIO 
deivce like `vhost-vsock-device`?

Also the "proxy" is used just here IIUC, so I think we can move that 
here entirly to reduce the diff, I mean pass `DeviceState *dev` as param 
here.


While looking better at the code, I found qdev_get_dev_path(), can this 
work fine for this scenario is some way?

>+}
>
> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
> {
>@@ -143,6 +147,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>+    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>     int vhostfd;
>     int ret;
>
>@@ -170,7 +176,19 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         return;
>     }
>
>-    if (vsock->conf.vhostfd) {
>+    if (cpr_is_incoming()) {
>+        /* Reuse the fd handed over from the source QEMU. */
>+        if (!proxy->id) {

IMO we should be consistent and check `cpr_name` everywhere to improve 
readability and reduce the diff moving the proxy in 
vhost_vsock_cpr_name().

Stefano

>+            error_setg(errp, "vhost-vsock: device ID is required for "
>+                       "CPR migration");
>+            goto err_blocker;
>+        }
>+        vhostfd = cpr_find_fd(cpr_name, 0);
>+        if (vhostfd < 0) {
>+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
>+            goto err_blocker;
>+        }
>+    } else if (vsock->conf.vhostfd) {
>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>         if (vhostfd == -1) {
>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>@@ -207,6 +225,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         goto err_vhost_dev;
>     }
>
>+    /* Register the fd for a future CPR after a fully successful realize */
>+    if (cpr_name && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
>+        goto err_vhost_dev;
>+    }
>+
>     return;
>
> err_vhost_dev:
>@@ -223,10 +246,15 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
>+    g_autofree char *cpr_name = vhost_vsock_cpr_name(proxy);
>
>     /* This will stop vhost backend if appropriate. */
>     vhost_vsock_set_status(vdev, 0);
>
>+    if (cpr_name) {
>+        cpr_delete_fd(cpr_name, 0);
>+    }
>     migrate_del_blocker(&vsock->migration_blocker);
>     vhost_dev_cleanup(&vvc->vhost_dev);
>     vhost_vsock_common_unrealize(vdev);
>
>-- 
>2.47.1
>


