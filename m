Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B005BC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sZF-0001k6-UW; Wed, 16 Sep 2026 12:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6sZE-0001ir-33
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x6sZC-0006PO-43
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789576379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tnt2E8YmCEeSRGx1jrMTVF/lKQfGLKxf5RHzaXjel+8=;
 b=AEHCzZ9UdurGh1+xlbAHpKGWWWDYxuxkdNnxpqdoLAMZaCEJ1EQ5uw9qS0I9SaOL4RG4BH
 KbBG73tV8BDa5/KKdSunfbKpGWe2WcC4lMd4lz1X1Nk6bEN5xAEdPRawjxgmnFNkbgY8XY
 ZW1LKpRl5wvr1N0rahiVuFBcyLuvG8Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-jfXAZm1cOCC0JkoNPPiSQA-1; Wed, 16 Sep 2026 12:32:57 -0400
X-MC-Unique: jfXAZm1cOCC0JkoNPPiSQA-1
X-Mimecast-MFC-AGG-ID: jfXAZm1cOCC0JkoNPPiSQA_1789576376
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf9df1eadso57301525e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789576376; x=1790181176; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Tnt2E8YmCEeSRGx1jrMTVF/lKQfGLKxf5RHzaXjel+8=;
 b=rAuERocxpMwFZAe5+89bPcTqP9/zcqaStlN1n1XS9/za+h4C3hFEXqIkM8GAWWt+Hn
 CwnEKsSKCw2xorFgnwqC4x3DlVZarqOvEULFfBQwadwEp5jMWesOtj4OzRFOneWNols/
 BOQYBK5xixmBrV8KdxkQkMYDOYe2vKQecRV1KU6SxNh8ND2+TaE++WLJSxaySthEuQK+
 MKE+g5m2Xc0mwdqLhnmpUWWmPNi0NbBJ+7HNIEjnRnp7WBfyKAQcOSRx5lKcayexlmkZ
 +v3Uq49RgtJHhlwK4Spd7QxrXAqqXmrBiHsgwauLos5xCgMntXjt9LBknCSn2sTw1ZAl
 vXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789576376; x=1790181176;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tnt2E8YmCEeSRGx1jrMTVF/lKQfGLKxf5RHzaXjel+8=;
 b=Ev+lfKcRoxzlsM8iFWCZ+EIOCYEoq9h8DmkAmAffEseKFUJDtLez7NSWc3P6goP6c+
 xaq9cqkjD7y8caAJulo1k9WGXGYV2iYKsZcbAMPcTm6yYLCT5wnAF6QB0WP3thyFNufi
 AIlZeR40mN1Gy/+1pTckq3NmYG34HsERg38F9Pq+Biji86j3wOJs6WZLyXv/sXvDvDYw
 v3UcxUFp6629dICAv+hq8GtxsnPzUDNIp5z3hgReBH4PnxeuyshVHZGGpZycCrg1EhVm
 aXJpQz8wmFNjsVqzw61hOlj+VIeckZwsJWFq+P8VyTN4T89xPtVvhey919blw/X1qiMF
 M4rQ==
X-Gm-Message-State: AFuF++lrfNJvNX/SYHlDBKz8kxnRrBl1qzypW+adIhTb/C2j7vSUztXU
 0dLQ9ZDbwJQ91P6d3sfRahiexwGOfOZ/UDCx84Rr+bGNMWUx0OywQd8vfdL4MPDHysdBoqxA1SL
 cBBGzJl+kal1XWDD2o4tXsoBY6i/yrq+bLDykEeAJajogSW2hY1J3RE22
X-Gm-Gg: AYBFou0kBhlB9+lM0hHBGmA7UIPb0IC96XeLPU8sYjhZ1RnsTHzJvS6PViMp5M1Gwe2
 nbaPVGcmQBclHUVjGkT6eoDCi9E47edupL2OyNoVBgaORZSygYkMnCFauhXLNs1l+iyIxlaAVVZ
 kvM1Wx9rPbitbhlP9ntlBJbR/rptcLaXtLOJNENHBE7HknCQwqBrmrvMGGa0Jy3/nktuOhi7WDw
 sTsl4tt0oux1zXiQtNB0znSpv0TkUVuRv5R/SI7iRSE7NZ39OA57LUN6T0TVMBY4Gjj7ed9oalA
 AhoezHDUeTzBSIBacZwBJ7bNJZl1BjcqVs3JC1LgO0ajYyBoJ4EJ2AG2Ukn/X0LUNiPQs4leepy
 T2OLkgWlmKmhFmbXI7HROyEOQ6tdgHPMjGb2Gs0KuCOPZRA==
X-Received: by 2002:a05:6000:29cf:b0:486:e707:42eb with SMTP id
 ffacd0b85a97d-4870d06792cmr3005801f8f.33.1789576376485; 
 Wed, 16 Sep 2026 09:32:56 -0700 (PDT)
X-Received: by 2002:a05:6000:29cf:b0:486:e707:42eb with SMTP id
 ffacd0b85a97d-4870d06792cmr3005765f8f.33.1789576375880; 
 Wed, 16 Sep 2026 09:32:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf438fbsm8340504f8f.36.2026.09.16.09.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:32:55 -0700 (PDT)
Date: Wed, 16 Sep 2026 18:32:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, mark.kanda@oracle.com, 
 farosas@suse.de, den@openvz.org, clg@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dongli.zhang@oracle.com,
 peterx@redhat.com
Subject: Re: [PATCH v6 09/14] vhost-vsock: preserve vhost FD during CPR
Message-ID: <aqq-9QeEXkZ8EISA@sgarzare-redhat>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <20260915-up-vsock-vhost-v5-v6-9-4d31b2dc6afd@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260915-up-vsock-vhost-v5-v6-9-4d31b2dc6afd@virtuozzo.com>
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

On Tue, Sep 15, 2026 at 11:59:45PM +0300, Andrey Drobyshev wrote:
>During CPR (checkpoint-restore) migration the guest keeps running on the
>same host, so instead of reopening /dev/vhost-vsock on the destination,
>we should reuse the FD from the source.  The FD is saved in the CPR
>namespace (hash table) with cpr_save_fd() and then reclaimed on the
>target via cpr_find_fd().
>
>Use the (suffixed) device path as the key in CPR hash table.  Device
>path is obtained with qdev_get_dev_path() and is essentially the
>device's address on the underlying bus.  As any vhost-vsock device is
>attached to a virtio bus, whose .get_dev_path() forwards to the proxy
>device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
>always be getting a unique non-empty path with qdev_get_dev_path().
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
>index 3ec20d87606..34eed2ea997 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
>     return 0;
> }
>
>+/*
>+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
>+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
>+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
>+ * which guarantees us a unique CPR name.
>+ */
>+static char *vhost_vsock_cpr_name(DeviceState *dev)
>+{
>+    g_autofree char *path = qdev_get_dev_path(dev);
>+    g_assert(path && path[0]);
>+    return g_strdup_printf("%s/vhost-vsock", path);
>+}
>
> static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
> {
>@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
>+    bool cpr_incoming = cpr_is_incoming();
>     int vhostfd;
>     int ret;
>
>@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         return;
>     }
>
>-    if (vsock->conf.vhostfd) {
>+    if (cpr_incoming) {
>+        /* Reuse the fd handed over from the source QEMU */
>+        vhostfd = cpr_find_fd(cpr_name, 0);
>+        if (vhostfd < 0) {
>+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
>+            goto err_blocker;
>+        }
>+    } else if (vsock->conf.vhostfd) {
>         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
>         if (vhostfd == -1) {
>             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
>@@ -207,6 +228,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         goto err_vhost_dev;
>     }
>
>+    /* Register the fd for a future CPR after a fully successful realize */

mmm, but if `cpr_incoming` is true, we should skip this, no?

>+    if (!cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
>+        goto err_vhost_dev;
>+    }
>+
>     return;
>
> err_vhost_dev:

Should we call cpr_delete_fd() in the error path?

Maybe with patch 14 both are fixed, since it seems there is an early
return, and also the delete in the error path.
So now I'm thinking if it would be easier for you to squash them...

Not a strong opinion here, but if you want to keep this patch, I think
should be fixed.

Thanks,
Stefano

>@@ -223,10 +249,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
>
>     /* This will stop vhost backend if appropriate. */
>     vhost_vsock_set_status(vdev, 0);
>
>+    cpr_delete_fd(cpr_name, 0);
>     migrate_del_blocker(&vsock->migration_blocker);
>     vhost_dev_cleanup(&vvc->vhost_dev);
>     vhost_vsock_common_unrealize(vdev);
>
>-- 
>2.47.1
>


