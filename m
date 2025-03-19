Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667C3C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvEW-0000vL-EX; Wed, 19 Mar 2025 11:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tuvE6-0000p8-TW
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1tuvDz-0000m1-6t
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742397650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LzPJZRXwPSEGrmtDKsVbqJicpUi0eYwnAJzm0DhxO3o=;
 b=W1d4B9h9I53vXWkoGC9deZol5Zx95UC8fJFemtcF/h9d76TSV+sKiSKcryyAldG37TdIqY
 7EInmZ/pgqzMCjqov5KRYqxeNgk9yAGbfHSFQw+W+o2htICMx8zqTss5BzWKUQF7lHIvsz
 ZmWX6c0kOSUf7wwxR+FVVSyBwBkqyfw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-Lzh8UpVnMKKnwEey7I95Vg-1; Wed, 19 Mar 2025 11:20:47 -0400
X-MC-Unique: Lzh8UpVnMKKnwEey7I95Vg-1
X-Mimecast-MFC-AGG-ID: Lzh8UpVnMKKnwEey7I95Vg_1742397646
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac37ed2b99fso289982966b.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 08:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742397646; x=1743002446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzPJZRXwPSEGrmtDKsVbqJicpUi0eYwnAJzm0DhxO3o=;
 b=M7oUzVsnCK6Ssb/n9ZnkfNFA9L5qzky1fYwOvIuPwiW6wUcqqPvuBUpvHTh4searwz
 29fMDwpFzIkeE040V/DO16EFUeNcImEUBDAeINw9F8oMUsdhfmiJ3hptLV5tRxC3zWnf
 fwC/YkICo270kV2SqDPPmDlC1Q0oqe88y3qBIQLNfDXD5cxsLCZX4x4mdlX0MgBeb488
 wvT71hL/gIaGChdXp3msok2pjZv+DLazlFCprq9PV1DJhfQYU/i3YG5YXbQWdWdyAdA6
 GDadm05F7atsK/sprakaL5MyDhTaP2dktXYqxQeKlYifIHdSbIw/1AZA+B4f9kJZIdEN
 2lmA==
X-Gm-Message-State: AOJu0YwRvI9D3tIlYbl4H68MaKr93dTmNfkohAPWFxiLMEgF917fAjve
 ohLKgODPcaj+jAq8/z0LnpjCISsj341NG7Pe5vV/DJ5nfrkILNAJ1Qpm/cXdV384IsmzZ7VybPK
 AxVRjr8vtBZ8ite/WI/sGADD5sDkcb265SE3oIU2R6rvqNKZPsp/S
X-Gm-Gg: ASbGnct9g/hwFsmuD7naeRl1OOz/+NfF0ws1/TpYFznQ0p5H+6u6LgaP31CxeGJq/Aq
 9Lvb0fOK9vqd3Yrcs4kt/I4m/6o2QZiuJ+1skP6R79+1XBSgkIuM0OtORPfVHIxYjHBKrl6T8U3
 OhD94JLwLPQYZUfykMkOn5h1DDPC7VlZ3jK13S5vG3Y+57bs1m8QEHSNJKrP8DFoo6St+FlSDfw
 5IHeQEiNK4/rtlyU6TzZBLpwE6LMyQj3XVJZevpDRHHoD2RxXHpeMXE3brIA0MhN+7u8NXgJVbt
 lAWrxT7XHF74sXFsVurBrmNWRVPxEnU8nzgXNh9TMeHYTV0mXSf9GCkxjtubig==
X-Received: by 2002:a17:907:2d0e:b0:ac2:9a71:25ab with SMTP id
 a640c23a62f3a-ac3b7d90700mr401096066b.16.1742397646111; 
 Wed, 19 Mar 2025 08:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGchYcC4H19nPqGK/Lg3ITfBKo7Uje9SCng1//9afxKaD2xt+ZvYdUqMOHfrRdowsunCeRWmQ==
X-Received: by 2002:a17:907:2d0e:b0:ac2:9a71:25ab with SMTP id
 a640c23a62f3a-ac3b7d90700mr401086166b.16.1742397645386; 
 Wed, 19 Mar 2025 08:20:45 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-53.retail.telecomitalia.it.
 [79.53.30.53]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3146aecffsm1017081766b.25.2025.03.19.08.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 08:20:44 -0700 (PDT)
Date: Wed, 19 Mar 2025 16:20:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Haoqian He <haoqian.he@smartx.com>
Cc: qemu-devel@nongnu.org, fengli@smartx.com, yuhua@smartx.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 3/3] vhost-user: return failure if backend crash when
 live migration
Message-ID: <5wblbg4qq7lmfrycksxo45ynh566gbzocwtim6yy6hiibus66a@fb75vbwpz5r5>
References: <20250309090708.3928953-1-haoqian.he@smartx.com>
 <20250314101535.1059308-1-haoqian.he@smartx.com>
 <20250314101535.1059308-4-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250314101535.1059308-4-haoqian.he@smartx.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Mar 14, 2025 at 06:15:34AM -0400, Haoqian He wrote:
>Live migration should be terminated if the backend crashes before
>the migration completes.
>
>Since the vhost device will be stopped when VM is stopped before
>the end of the live migration, current implementation if vhost
>backend died, vhost device's set_status() will not return failure,
>live migration won't perceive the disconnection between qemu and
>vhost backend, inflight io would be submitted in migration target
>host, leading to IO error.
>
>To fix this issue:
>1. Add set_status_ext() which has return value for
>VirtioDeviceClass and vhost-user-blk/scsi use the _ext version.
>
>2. In set_status_ext(), return failure if the flag `connected`
>is false or vhost_dev_stop return failure, which means qemu lost
>connection with backend.
>
>Hence migration_completion() will process failure, terminate
>migration and restore VM.
>
>Signed-off-by: Haoqian He <haoqian.he@smartx.com>
>---
> hw/block/vhost-user-blk.c             | 29 +++++++++++++++------------
> hw/scsi/vhost-scsi-common.c           | 13 ++++++------
> hw/scsi/vhost-user-scsi.c             | 20 ++++++++++--------
> hw/virtio/virtio.c                    | 20 +++++++++++++-----
> include/hw/virtio/vhost-scsi-common.h |  2 +-
> include/hw/virtio/virtio.h            |  1 +
> 6 files changed, 52 insertions(+), 33 deletions(-)
>
>diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
>index ae42327cf8..4865786c54 100644
>--- a/hw/block/vhost-user-blk.c
>+++ b/hw/block/vhost-user-blk.c
>@@ -204,7 +204,7 @@ err_host_notifiers:
>     return ret;
> }
>
>-static void vhost_user_blk_stop(VirtIODevice *vdev)
>+static int vhost_user_blk_stop(VirtIODevice *vdev)
> {
>     VHostUserBlk *s = VHOST_USER_BLK(vdev);
>     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>@@ -212,26 +212,26 @@ static void vhost_user_blk_stop(VirtIODevice *vdev)
>     int ret;
>
>     if (!s->started_vu) {
>-        return;
>+        return 0;
>     }
>     s->started_vu = false;
>
>     if (!k->set_guest_notifiers) {
>-        return;
>+        return 0;
>     }
>
>-    vhost_dev_stop(&s->dev, vdev, true);
>+    ret = vhost_dev_stop(&s->dev, vdev, true);
>
>-    ret = k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>-    if (ret < 0) {
>+    if (k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false) < 0) {
>         error_report("vhost guest notifier cleanup failed: %d", ret);
>-        return;
>+        return -1;
>     }
>
>     vhost_dev_disable_notifiers(&s->dev, vdev);
>+    return ret;
> }
>
>-static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>+static int vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostUserBlk *s = VHOST_USER_BLK(vdev);
>     bool should_start = virtio_device_should_start(vdev, status);
>@@ -239,11 +239,11 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>     int ret;
>
>     if (!s->connected) {
>-        return;
>+        return -1;
>     }
>
>     if (vhost_dev_is_started(&s->dev) == should_start) {
>-        return;
>+        return 0;
>     }
>
>     if (should_start) {
>@@ -253,9 +253,12 @@ static void vhost_user_blk_set_status(VirtIODevice *vdev, uint8_t status)
>             qemu_chr_fe_disconnect(&s->chardev);
>         }
>     } else {
>-        vhost_user_blk_stop(vdev);
>+        ret = vhost_user_blk_stop(vdev);
>+        if (ret < 0) {
>+            return ret;
>+        }
>     }
>-
>+    return 0;
> }
>
> static uint64_t vhost_user_blk_get_features(VirtIODevice *vdev,
>@@ -597,7 +600,7 @@ static void vhost_user_blk_class_init(ObjectClass *klass, void *data)
>     vdc->get_config = vhost_user_blk_update_config;
>     vdc->set_config = vhost_user_blk_set_config;
>     vdc->get_features = vhost_user_blk_get_features;
>-    vdc->set_status = vhost_user_blk_set_status;
>+    vdc->set_status_ext = vhost_user_blk_set_status;
>     vdc->reset = vhost_user_blk_reset;
>     vdc->get_vhost = vhost_user_blk_get_vhost;
> }
>diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
>index 4c8637045d..43525ba46d 100644
>--- a/hw/scsi/vhost-scsi-common.c
>+++ b/hw/scsi/vhost-scsi-common.c
>@@ -101,24 +101,25 @@ err_host_notifiers:
>     return ret;
> }
>
>-void vhost_scsi_common_stop(VHostSCSICommon *vsc)
>+int vhost_scsi_common_stop(VHostSCSICommon *vsc)
> {
>     VirtIODevice *vdev = VIRTIO_DEVICE(vsc);
>     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
>     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
>     int ret = 0;
>
>-    vhost_dev_stop(&vsc->dev, vdev, true);
>+    ret = vhost_dev_stop(&vsc->dev, vdev, true);
>
>     if (k->set_guest_notifiers) {
>-        ret = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>-        if (ret < 0) {
>-                error_report("vhost guest notifier cleanup failed: %d", ret);
>+        int r = k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
>+        if (r < 0) {
>+            error_report("vhost guest notifier cleanup failed: %d", ret);

The variable `ret` in the error_report() seems wrong.

>+            return r;
>         }
>     }
>-    assert(ret >= 0);
>
>     vhost_dev_disable_notifiers(&vsc->dev, vdev);
>+    return ret;
> }
>
> uint64_t vhost_scsi_common_get_features(VirtIODevice *vdev, uint64_t features,
>diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
>index adb41b9816..8e7efc38f2 100644
>--- a/hw/scsi/vhost-user-scsi.c
>+++ b/hw/scsi/vhost-user-scsi.c
>@@ -52,19 +52,19 @@ static int vhost_user_scsi_start(VHostUserSCSI *s, Error **errp)
>     return ret;
> }
>
>-static void vhost_user_scsi_stop(VHostUserSCSI *s)
>+static int vhost_user_scsi_stop(VHostUserSCSI *s)
> {
>     VHostSCSICommon *vsc = VHOST_SCSI_COMMON(s);
>
>     if (!s->started_vu) {
>-        return;
>+        return 0;
>     }
>     s->started_vu = false;
>
>-    vhost_scsi_common_stop(vsc);
>+    return vhost_scsi_common_stop(vsc);
> }
>
>-static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>+static int vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
> {
>     VHostUserSCSI *s = (VHostUserSCSI *)vdev;
>     DeviceState *dev = DEVICE(vdev);
>@@ -75,11 +75,11 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>     int ret;
>
>     if (!s->connected) {
>-        return;
>+        return -1;
>     }
>
>     if (vhost_dev_is_started(&vsc->dev) == should_start) {
>-        return;
>+        return 0;
>     }
>
>     if (should_start) {
>@@ -91,8 +91,12 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
>             qemu_chr_fe_disconnect(&vs->conf.chardev);
>         }
>     } else {
>-        vhost_user_scsi_stop(s);
>+        ret = vhost_user_scsi_stop(s);
>+        if (ret) {
>+            return ret;
>+        }
>     }
>+    return 0;
> }
>
> static void vhost_user_scsi_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>@@ -399,7 +403,7 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
>     vdc->unrealize = vhost_user_scsi_unrealize;
>     vdc->get_features = vhost_scsi_common_get_features;
>     vdc->set_config = vhost_scsi_common_set_config;
>-    vdc->set_status = vhost_user_scsi_set_status;
>+    vdc->set_status_ext = vhost_user_scsi_set_status;
>     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
>     vdc->reset = vhost_user_scsi_reset;
>     vdc->get_vhost = vhost_user_scsi_get_vhost;
>diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>index 5e8d4cab53..fff7cdb35d 100644
>--- a/hw/virtio/virtio.c
>+++ b/hw/virtio/virtio.c
>@@ -2221,12 +2221,12 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
> {
>     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>     trace_virtio_set_status(vdev, val);
>+    int ret = 0;
>
>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
>         if (!(vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) &&
>             val & VIRTIO_CONFIG_S_FEATURES_OK) {
>-            int ret = virtio_validate_features(vdev);
>-
>+            ret = virtio_validate_features(vdev);
>             if (ret) {
>                 return ret;
>             }
>@@ -2238,12 +2238,18 @@ int virtio_set_status(VirtIODevice *vdev, uint8_t val)
>         virtio_set_started(vdev, val & VIRTIO_CONFIG_S_DRIVER_OK);
>     }
>
>-    if (k->set_status) {
>+    if (k->set_status_ext) {
>+        ret = k->set_status_ext(vdev, val);
>+        if (ret) {
>+            qemu_log("set %s status to %d failed, old status: %d\n",
>+                     vdev->name, val, vdev->status);
>+        }
>+    } else if (k->set_status) {
>         k->set_status(vdev, val);
>     }
>     vdev->status = val;
>
>-    return 0;
>+    return ret;
> }
>
> static enum virtio_device_endian virtio_default_endian(void)
>@@ -3436,7 +3442,11 @@ static int virtio_vmstate_change(void *opaque, bool running, RunState state)
>     }
>
>     if (!backend_run) {
>-        virtio_set_status(vdev, vdev->status);
>+        // the return value was used for stopping VM during migration

Can you elaborate a bit this comment?

>+        int ret = virtio_set_status(vdev, vdev->status);
>+        if (ret) {
>+            return ret;
>+        }
>     }
>     return 0;
> }
>diff --git a/include/hw/virtio/vhost-scsi-common.h b/include/hw/virtio/vhost-scsi-common.h
>index c5d2c09455..d54d9c916f 100644
>--- a/include/hw/virtio/vhost-scsi-common.h
>+++ b/include/hw/virtio/vhost-scsi-common.h
>@@ -40,7 +40,7 @@ struct VHostSCSICommon {
> };
>
> int vhost_scsi_common_start(VHostSCSICommon *vsc, Error **errp);
>-void vhost_scsi_common_stop(VHostSCSICommon *vsc);
>+int vhost_scsi_common_stop(VHostSCSICommon *vsc);
> char *vhost_scsi_common_get_fw_dev_path(FWPathProvider *p, BusState *bus,
>                                         DeviceState *dev);
> void vhost_scsi_common_set_config(VirtIODevice *vdev, const uint8_t *config);
>diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>index 6386910280..c99d56f519 100644
>--- a/include/hw/virtio/virtio.h
>+++ b/include/hw/virtio/virtio.h
>@@ -187,6 +187,7 @@ struct VirtioDeviceClass {
>     void (*set_config)(VirtIODevice *vdev, const uint8_t *config);
>     void (*reset)(VirtIODevice *vdev);
>     void (*set_status)(VirtIODevice *vdev, uint8_t val);
>+    int (*set_status_ext)(VirtIODevice *vdev, uint8_t val);

Why we need a new callback instead having `set_status` returning int ?

Thanks,
Stefano

>     /* Device must validate queue_index.  */
>     void (*queue_reset)(VirtIODevice *vdev, uint32_t queue_index);
>     /* Device must validate queue_index.  */
>-- 
>2.48.1
>


