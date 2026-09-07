Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2F7C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 14:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3al8-0002Gx-K6; Mon, 07 Sep 2026 10:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3al7-0002Gd-9c
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:55:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x3al5-0001hU-FA
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 10:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788792942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UrIp/UhYvOUwza7Hu26E8qqOx5ZCZd0tQLLdD/Y8+0I=;
 b=LPR+pnmtGUZKKv17bmkH0bn/FiAYvnCVaZ3BrSkAcOcgECWWmoJJ1e+gPmzyHcn7yqv9Va
 YaY70ZM8oXMI7CEpqUXIsg9zcaoJqTJuXqiJ40KNEMXe8VABdjhFBh5kq9Hkj7u4Lprnv4
 3ns4iFkU5if14phrJvJtdhreSBpCHMk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-I_UX49o6OsKEbPM9fzqyRw-1; Mon, 07 Sep 2026 10:55:41 -0400
X-MC-Unique: I_UX49o6OsKEbPM9fzqyRw-1
X-Mimecast-MFC-AGG-ID: I_UX49o6OsKEbPM9fzqyRw_1788792940
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48439eea716so2436115f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 07:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788792940; x=1789397740; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UrIp/UhYvOUwza7Hu26E8qqOx5ZCZd0tQLLdD/Y8+0I=;
 b=ZtuT5JrnkfS5/G09RexrvnjDlWxBIfi7N8YBWpzRlQtG2XG7/EHD+p7LpFL3TP05NY
 JNmwBmxxjk8HQpQnfW8Q077eW2PF2/iNjupUUKTcguG1HfEHHiMHNqZMnF6/EhvgvFyx
 LxgHHLKy4mMqQte6mKWajt60ph8Erw0PPWJRK7lPTRaOll9M+4zet54JazdxL5CaltHQ
 kYnpu2kpxXiTkdhE7By/OjXRUzcAJKIdckU7MMx5RfreuqQagoOGc1DHA+YcbGAXigge
 i/7af5qPFQ79bklUyJkkF2vTCWR/FOnJakGRD/hBh0e38R2lk81GnlanTf+yGkQAeFM+
 qvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792940; x=1789397740;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UrIp/UhYvOUwza7Hu26E8qqOx5ZCZd0tQLLdD/Y8+0I=;
 b=krCPzf64Ht+dJU7ufDPE2kR9gZfiui/UZ3+WeaEPPfMhmHBiGwy4g5FUSOqWeS4Irt
 cGpsrS4GMssJuy/J1rdusiX4Fp519DIayZk17xQ/795Cgkyn8QUByt1Q/6r2Mkp84bx2
 7rsKnqY29Cum27kg9HNXoUSDCHq+h3ja4fAS5K1MvbN6zpzk31yB7r/p9iMas0LMcU/5
 MNUHRCMVshJL+SAjfx8eW1lGY6027qTYUcubEInIX2Lhvk3EXBV2yrFCKrjZeGI38tai
 SA/jMDLipAXS9b5xZdL/GALaiPOXTan6dTR9QOmGHuxcgrZRkd90GkhvAxN7lFLsMr2p
 3BIw==
X-Gm-Message-State: AFuF++kqTfUP2tI8c6l7gSeIuWRz34JKichIgTHwTQAnRbOb4yHWECu7
 aBzaoiiwm1YbZt3GwYXgVRkbhkkR7hVWpo+n4sZGpIFKFD76lgalqwvoFQL47iL4syns0IbBNhp
 swLr/HDab5vQdvWFdmSibXIv8Ilvt944WCxszBQ3VgCFifItIr1j/f1EU
X-Gm-Gg: AYBFou2q8A0AjuXDNALP1tF2VZJBIC5470uMDFt+DrKnO7sESuTUTCA47d4E8+pMxf+
 P03I0mfLBOsOlhM9M83yzTeDkMol3ad7Yyf0Zk8M6MpiQKGeqdcCFMp4VWWlIfia69HyNdvxIQK
 fAxxZJEYOxwmxvl3qtW/wLP7GqXTvZ5BNmSxw/hDARfHJOvsHo5xFMPTPewJB3+Vjl/QaPBXJP6
 ICyBPWLp7j4HdFZ4gdJjoWHde3DUXsyeL+0nOL2yWM53bhCYRSYu6dXM8fkA7aCfnVqNZRXyzvb
 swwmzMTPMpUNQr2/Vx0asJhExQ1Os393JLVG4w+0tFeNkMjCXopNIFJvfqEyMvyxMlfDuSaj9AR
 05Hm3/SV4jT4ObL1FObhEPEVIzHSIsnq4oLUtpy8ykGdRZg==
X-Received: by 2002:a05:6000:1843:b0:485:8c17:975f with SMTP id
 ffacd0b85a97d-4858c1798damr22430835f8f.33.1788792939934; 
 Mon, 07 Sep 2026 07:55:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1843:b0:485:8c17:975f with SMTP id
 ffacd0b85a97d-4858c1798damr22430779f8f.33.1788792939360; 
 Mon, 07 Sep 2026 07:55:39 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be01bsm28527032f8f.31.2026.09.07.07.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:55:38 -0700 (PDT)
Date: Mon, 7 Sep 2026 16:55:36 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, g@sgarzare-redhat
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 05/10] vhost-vsock: preserve vhost FD during CPR
Message-ID: <ap7Gc_L0gYkAaZiV@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Aug 20, 2026 at 02:39:50PM +0300, Andrey Drobyshev wrote:
>During CPR (checkpoint-restore) migration the guest keeps running on the
>same host, so instead of reopening /dev/vhost-vsock on the destination,
>we should reuse the FD from the source.  The FD is saved in the CPR
>namespace (hash table) with cpr_save_fd() and then reclaimed on the
>target via cpr_find_fd().
>
>Since the key in CPR hash table is device ID, CPR needs a unique ID.

mm, are we sure the device ID is unique?

I just tried this whitout receiving any error:
qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=vsock0 \
     -object memory-backend-memfd,id=vsock0,size=512M \
     -device vhost-vsock-pci,id=vsock0,guest-cid=3

Stefano

>Thus we only preserve the FD with cpr_{save,find} if this ID is present.
>In a following patch, when we lift the CPR migration blocker, we're
>going to condition it on the presence of ID.
>
>vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
>Deferring the ownership handoff to pre_save/post_load is done in a
>following patch.  Until then CPR remains blocked, so the restore path
>added here is not reachable yet.
>
>Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>---
> hw/virtio/vhost-vsock.c | 24 +++++++++++++++++++++++-
> 1 file changed, 23 insertions(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
>index 3ec20d87606..cec2c31f0ca 100644
>--- a/hw/virtio/vhost-vsock.c
>+++ b/hw/virtio/vhost-vsock.c
>@@ -143,6 +143,7 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>+    DeviceState *proxy = qdev_get_parent_bus(DEVICE(vsock))->parent;
>     int vhostfd;
>     int ret;
>
>@@ -170,7 +171,19 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
>         return;
>     }
>
>-    if (vsock->conf.vhostfd) {
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
>@@ -207,6 +220,11 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
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
>@@ -223,10 +241,14 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
>     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
>     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>     VHostVSock *vsock = VHOST_VSOCK(dev);
>+    DeviceState *proxy = qdev_get_parent_bus(dev)->parent;
>
>     /* This will stop vhost backend if appropriate. */
>     vhost_vsock_set_status(vdev, 0);
>
>+    if (proxy->id) {
>+        cpr_delete_fd(proxy->id, 0);
>+    }
>     migrate_del_blocker(&vsock->migration_blocker);
>     vhost_dev_cleanup(&vvc->vhost_dev);
>     vhost_vsock_common_unrealize(vdev);
>-- 
>2.47.1
>


