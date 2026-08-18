Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C02CC5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLkX-00037Q-Jr; Tue, 18 Aug 2026 11:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLkT-00033T-UJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:29:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wwLkQ-0008Eq-ST
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 11:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787066946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L8yLcLPCD9WdOWWdy+BOj+UNQxTixVQsyb3QsCFg0LM=;
 b=fuaYevhy9+sYx85rIdhqcQKJqqpnCvpfDBIZqeNFzAIDgi/dC3+u6mnOk97IKQ7/Sgg+qs
 ndyEa3td/8d6dUXtSyEXvGWdEdeTAGUQIXD1HcDImMCZJw7RWubMNsOMhiuObJi4I/TUIi
 043NW8aT3vVMQmy88zh30vyqpiSVsF4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-5eO-8s0pPQ2YZO1xywjyNw-1; Tue, 18 Aug 2026 11:29:04 -0400
X-MC-Unique: 5eO-8s0pPQ2YZO1xywjyNw-1
X-Mimecast-MFC-AGG-ID: 5eO-8s0pPQ2YZO1xywjyNw_1787066943
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so50525135e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787066943; x=1787671743; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L8yLcLPCD9WdOWWdy+BOj+UNQxTixVQsyb3QsCFg0LM=;
 b=Y9a2prISTjpAVcIX0SboLCYTa1Gec+fDf2hn37rGfa93E/iTTkVxb4z6EvfOUt+Unv
 hzJVuvFy4p5ojJY0s1M6RTVaM6GqD8kEP8ukeewkKG0+jJ3SHwAFAPwhG1ycnYQHF+Ff
 UBL089VKa4QEkc/d8RYmCE8BbMnrKXpvvTcwW0IKV3KT4OKt+++UhJDIR7lEU8iv+D48
 Dtp55xUVlCwjcJh97PXwIjWmIgFGMsPelja07Bp4VmvmpZJtrn4JNwf9QzhROjzXIpqk
 2iJcQJu36jeawySqBg644/ds0S577TvfhH4JPefpJ9DoFyLXCvlTVlbGUbpd0eHq25MI
 Bo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066943; x=1787671743;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L8yLcLPCD9WdOWWdy+BOj+UNQxTixVQsyb3QsCFg0LM=;
 b=BFYzUe7eem8eBDBCe0YEmYHB9FB8NB3WtOkx8/HtLkRawc2tBsAwUaTh/zXu+gXhrJ
 2qPBxn0UZeKODXSp0CGjFNP4xfa/34KmW0BrsU7RZbKgaDvts8GedHe64NcC2OFKm8Zr
 IRCKN59pdfv4V+AdyNAOwNh/4P98QAiIg2jEUwtR9vW4HTzCIddy499Iv835NmWGrtZ5
 tPEVIwb+V2Q5vIopmxag7F3YK671+8SWUGU3tDvld0gj8MlOb/6FdMmbzXedbQu9OrX0
 LJCFCh+XbvQwGsfLUxtsgOqMw40d8QZFQCOSG6tfjJTvcqK1hbCrpR2lm6a8enlZJxlp
 u9tA==
X-Gm-Message-State: AOJu0Yyr7nbzqrAHw5KZ6aqErV1yMdlh22fsuojRPM9ojhG2CqlPUMjq
 bWoZ+ERrbEQsZKH+ttt+L2o1EY2JsqmwJmq1bruDm6uLvt2bMjQxpB2Ur2UABjyBKFHlcNZHdS5
 TDDAZ4tx9QAnOu0fC0dFMxIKHy/bvPzYIbRSRuzARxDeplAO1MzCCt9M8
X-Gm-Gg: AR+sD115ykbY4FVi4DO4eERzZbW7PKH4QYn/HoxvQd7aAwmuMrCr4Vd9hH/ndCH02dA
 KfQsT1d+iDZ+np9A8zqsXwKz0L03rSRImfHg+O23OOTzLKDcOiwUdOAAd9+pysRQStqYR8bj63j
 z1O299GGYwQyMTwI9p83CqOXpMfhA8ihQOdCMZ0ggOk2eUHJBHhcXrPh0kZf0y8Pry5olWLtCa9
 NvJCKPUpRWLFhnugBaXj97a1FL5GHnGscf3OdVFbttbe8iK1aOVSCItkr3qzSe8I4T4bP9oGQpu
 Z4ykkhz26ILsprrtQxa5YmUyQK14TEDKKCtULxk/YVkY5bN93ns7U6YzHpTpCtYJbdibl32HtvW
 NONYYLdLyuZzRObwk1he5ySrBHKMsK1WobcUW9tmjOlBA8Poq3xeB
X-Received: by 2002:a05:600c:1d0c:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-4999fb3953emr155879185e9.7.1787066943381; 
 Tue, 18 Aug 2026 08:29:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0c:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-4999fb3953emr155878215e9.7.1787066942967; 
 Tue, 18 Aug 2026 08:29:02 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-154.retail.telecomitalia.it.
 [82.53.135.154]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d086c6dsm134749185e9.7.2026.08.18.08.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:29:02 -0700 (PDT)
Date: Tue, 18 Aug 2026 17:29:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v3 4/7] vhost-vsock: preserve vhost FD during CPR
Message-ID: <aoRyAqduT4FRj9NV@sgarzare-redhat>
References: <20260626164643.2526-1-andrey.drobyshev@virtuozzo.com>
 <20260626164643.2526-5-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260626164643.2526-5-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 26, 2026 at 07:46:40PM +0300, Andrey Drobyshev wrote:
>During CPR (checkpoint-restore) migration the guest keeps running on the
>same host, so instead of reopening /dev/vhost-vsock on the destination,
>we should reuse the FD from the source.  The FD is saved in the CPR
>namespace (hash table) with cpr_save_fd() and then reclaimed on the
>target via cpr_find_fd().
>
>Since the key in CPR hash table is device ID, CPR needs a unique ID.
>Rather than make it mandatory for every vhost-vsock device, we add CPR
>migration blocker which only fires once we attempt CPR with ID-less
>vhost-vsock.
>
>vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>Deferring the ownership handoff to pre_save/post_load is done in a
>following patch.

So will this patch be bisectabale?

Thanks,
Stefano

>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c         | 50 ++++++++++++++++++++++++++++++---
> include/hw/virtio/vhost-vsock.h |  1 +
> 2 files changed, 47 insertions(+), 4 deletions(-)
>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index fd7ffa88990..7eacb608d07 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -21,6 +21,8 @@
> #include "hw/virtio/vhost-vsock.h"
> #include "monitor/monitor.h"
> #include "migration/cpr.h"
>+#include "migration/blocker.h"
>+#include "migration/misc.h"
>
> static void vhost_vsock_get_config(VirtIODevice *vdev, uint8_t *config)
> {
>@@ -141,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>     int vhostfd;
>     int ret;
>
>@@ -155,23 +158,49 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         return;
>     }
>
>-    if (vsock->conf.vhostfd) {
>+    /*
>+     * Having a unique ID is mandatory for FD preservation during CPR
>+     * migration, thus we add migration blockers for CPR modes.
>+     */
>+    if (!proxy->id) {
>+        error_setg(&vsock->migration_blocker,
>+                   "vhost-vsock: device ID is required for CPR migration");
>+        if (migrate_add_blocker_modes(&vsock->migration_blocker,
>+                                      BIT(MIG_MODE_CPR_TRANSFER) |
>+                                      BIT(MIG_MODE_CPR_EXEC), errp) < 0) {
>+            return;
>+        }
>+    }
>+
>+    if (cpr_is_incoming()) {
>+        /* Reuse the fd handed over from the source QEMU. */
>+        if (!proxy->id) {
>+            error_setg(errp, "vhost-vsock: device ID is required for "
>+                       "CPR migration");
>+            goto err_blocker;
>+        }
>+        vhostfd = cpr_find_fd(proxy->id, 0);
>+        if (vhostfd < 0) {
>+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
>+            goto err_blocker;
>+        }
>+    } else if (vsock->conf.vhostfd) {
>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>         if (vhostfd == -1) {
>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>-            return;
>+            goto err_blocker;
>         }
>     } else {
>         vhostfd = open("/dev/vhost-vsock", O_RDWR);
>         if (vhostfd < 0) {
>             error_setg_file_open(errp, errno, "/dev/vhost-vsock");
>-            return;
>+            goto err_blocker;
>         }
>     }
>
>     if (!qemu_set_blocking(vhostfd, false, errp)) {
>         close(vhostfd);
>-        return;
>+        goto err_blocker;
>     }
>
>     vhost_vsock_common_realize(vdev);
>@@ -192,6 +221,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         goto err_vhost_dev;
>     }
>
>+    /* Register the fd for a future CPR after a fully successful realize */
>+    if (proxy->id) {
>+        cpr_save_fd(proxy->id, 0, vhostfd);
>+    }
>+
>     return;
>
> err_vhost_dev:
>@@ -199,16 +233,24 @@ err_vhost_dev:
>     vhost_dev_cleanup(&vvc->vhost_dev);
> err_virtio:
>     vhost_vsock_common_unrealize(vdev);
>+err_blocker:
>+    migrate_del_blocker(&vsock->migration_blocker);
> }
>
> static void vhost_vsock_device_unrealize(DeviceState *dev)
> {
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>+    VHostVSock *vsock = VHOST_VSOCK(dev);
>+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
>
>     /* This will stop vhost backend if appropriate. */
>     vhost_vsock_set_status(vdev, 0);
>
>+    if (proxy->id) {
>+        cpr_delete_fd(proxy->id, 0);
>+    }
>+    migrate_del_blocker(&vsock->migration_blocker);
>     vhost_dev_cleanup(&vvc->vhost_dev);
>     vhost_vsock_common_unrealize(vdev);
> }
>diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vsock.h
>index 84f4e727c70..5ebc63afc5a 100644
>--- a/include/hw/virtio/vhost-vsock.h
>+++ b/include/hw/virtio/vhost-vsock.h
>@@ -29,6 +29,7 @@ struct VHostVSock {
>     /*< private >*/
>     VHostVSockCommon parent;
>     VHostVSockConf conf;
>+    Error *migration_blocker;   /* set when the device has no ID */
>
>     /*< public >*/
> };
>-- 
>2.47.1
>


