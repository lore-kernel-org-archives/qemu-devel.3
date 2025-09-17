Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1C5CAC59A
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 12:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyr2W-0006re-WF; Wed, 17 Sep 2025 08:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyr2P-0006nA-C8
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyr2L-0007QJ-Vg
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758111203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K3SFDb7DTmHn5qqWb3bX3+DOi6LGCCkRTLKkb8a20jg=;
 b=gFODWNW37ekY3VB+iWKtQXQjYVLuphvkYNZ4foV9jHeTGW5qTRDnoPprwPEi76m1vxUVhJ
 NQPL1bRQfGDwpoFfqmgnop4gKk25pve7rmfw0ncM0wWKsiQvWSstaZa4TMnE9FcBIxDW6D
 qrD0PMEDHlsmxSDwv7F9SCsCPi5nQiM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-mWKMZRJ4PMW55-vikcwGCQ-1; Wed, 17 Sep 2025 08:13:22 -0400
X-MC-Unique: mWKMZRJ4PMW55-vikcwGCQ-1
X-Mimecast-MFC-AGG-ID: mWKMZRJ4PMW55-vikcwGCQ_1758111201
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dd5c1b67dso38657725e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758111201; x=1758716001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3SFDb7DTmHn5qqWb3bX3+DOi6LGCCkRTLKkb8a20jg=;
 b=Vl1n0laVDL+y5dQ3XoX7bVnGQnJ+BMHpOcLV0EdZswQGv6OwFpSqKWTktrHwtVg8zv
 5mMXdT/SP1Hy3NdYfYKx6thCg6roKUk+2wo7BARz8I/HiWmQSR2ck+o7/MNMj7pdJPDB
 NHoJz4YIr9FmqNTMEFCnH2BXz5k0IXcmH6DdoG0ly7e3rGcTJwJmBYumP+bfQnyf4O2+
 Bv+MhOhL+dQtVHxgPsDpdnYkf0g0NHQIQEBaMoot0N/tXMs+tP4+5tOMUC/wyDKbSpyq
 86uopjVXupeHN75ACEmecAe7cDl1s5RUTOvTHKXWAWGVFvHY8JCWly+9OHO1vIUE9+88
 f+qA==
X-Gm-Message-State: AOJu0YxbHYA4A7134qkHaQva7nKR/G75tAmotKMlZynFMIIp2Zoao5QC
 oIhk6S+vcMeZn8vAEh+jJsRuClqPsmIuEhREZo9phsZ+5cLWKFIjFvYkVEjSYZol2Jr2wMcUzo4
 m0+Q90YDQsHJ9afCEl+dix40ckJ8b9jmAbiIGJ5kWrON0bqqMVclwAtub
X-Gm-Gg: ASbGncshB7WNv5rR+wqfDMo8qVMI/EXLUk5oIRtApQKC+tkOYGoJpNwrw9tJMxZyI6j
 CqeuJ9rbGq3RcO4VlDK4Djp74n2MPqVvMqqmhlDP80JtTsZMgG44HkDTMeQXKb2EJwXbB4HW6Cv
 KWGxJ2aEdz6mscbg5ZHuFMEjroco7bP5Afwa0hMprIudn7LLcDM4enoqB1sIW6afZqEYO9mlQsX
 h2iouiw6HuevoCw94HRm3XVCwa0e/Exf210PuBXeVZAy2x8rHLIcXWMt/ofUPrEC9Ga6B6m2Pjn
 axTTAwe/bQfRK56BOyJLDtK+uGE4vPum5odw/jJF9/ZO
X-Received: by 2002:a05:600c:3ba8:b0:45d:2ac9:4240 with SMTP id
 5b1f17b1804b1-46206842af0mr22530805e9.17.1758111201143; 
 Wed, 17 Sep 2025 05:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtibnqnvb9SNS6QH/9OkZI/3UXJRYKsejnhjqSpweOZZp+tH4zZYkEcwJnxZb0wnbYuH1Y/A==
X-Received: by 2002:a05:600c:3ba8:b0:45d:2ac9:4240 with SMTP id
 5b1f17b1804b1-46206842af0mr22530345e9.17.1758111200660; 
 Wed, 17 Sep 2025 05:13:20 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.183.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46136f985d8sm36374085e9.3.2025.09.17.05.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:13:20 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:13:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 05/14] virtio: serialize extended features state
Message-ID: <hitycqljplv6nj5ypghgdxclvmgcbxtukagvgjpv7s5xwof6ae@2nm5n3zssar3>
References: <cover.1757676218.git.pabeni@redhat.com>
 <0c96908c9129d7377727f9b6490d5fe7a3aeac41.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0c96908c9129d7377727f9b6490d5fe7a3aeac41.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 12, 2025 at 03:06:56PM +0200, Paolo Abeni wrote:
>If the driver uses any of the extended features (i.e. 64 or above),
>store the extended features range (64-127 bits).
>
>At load time, let legacy features initialize the full features range
>and pass it to the set helper; sub-states loading will have filled-up
>the extended part as needed.
>
>This is one of the few spots that need explicitly to know and set
>in stone the extended features array size; add a build bug to prevent
>breaking the migration should such size change again in the future:
>more serialization plumbing will be needed.
>
>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v3 -> v4:
> - move the build bug before vmstate_virtio
> - use new virtio_features macro names
>
>v2 -> v3:
> - 128bit_features state load/stores only the high bits
> - consolidate the load implementation to use a single set
>   helper for 128/64/32 bits features
> - _array -> _ex
>
>v1 -> v2:
> - uint128_t -> u64[2]
>---
> hw/virtio/virtio.c | 88 ++++++++++++++++++++++++++++++----------------
> 1 file changed, 57 insertions(+), 31 deletions(-)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>index 9a81ad912e..bf53c211e5 100644
>--- a/hw/virtio/virtio.c
>+++ b/hw/virtio/virtio.c
>@@ -2964,6 +2964,30 @@ static const VMStateDescription vmstate_virtio_disabled = {
>     }
> };
>
>+static bool virtio_128bit_features_needed(void *opaque)
>+{
>+    VirtIODevice *vdev = opaque;
>+
>+    return virtio_features_use_ex(vdev->host_features_ex);
>+}
>+
>+static const VMStateDescription vmstate_virtio_128bit_features = {
>+    .name = "virtio/128bit_features",
>+    .version_id = 1,
>+    .minimum_version_id = 1,
>+    .needed = &virtio_128bit_features_needed,
>+    .fields = (const VMStateField[]) {
>+        VMSTATE_UINT64(guest_features_ex[1], VirtIODevice),
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+/*
>+ * Avoid silently breaking migration should the feature space increase
>+ * even more in the (far away) future
>+ */
>+QEMU_BUILD_BUG_ON(VIRTIO_FEATURES_NU64S != 2);
>+
> static const VMStateDescription vmstate_virtio = {
>     .name = "virtio",
>     .version_id = 1,
>@@ -2973,6 +2997,7 @@ static const VMStateDescription vmstate_virtio = {
>     },
>     .subsections = (const VMStateDescription * const []) {
>         &vmstate_virtio_device_endian,
>+        &vmstate_virtio_128bit_features,
>         &vmstate_virtio_64bit_features,
>         &vmstate_virtio_virtqueues,
>         &vmstate_virtio_ringsize,
>@@ -3069,23 +3094,28 @@ const VMStateInfo  virtio_vmstate_info = {
>     .put = virtio_device_put,
> };
>
>-static int virtio_set_features_nocheck(VirtIODevice *vdev, uint64_t val)
>+static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
> {
>     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>-    bool bad = (val & ~(vdev->host_features)) != 0;
>+    uint64_t tmp[VIRTIO_FEATURES_NU64S];
>+    bool bad;
>+
>+    bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
>+    virtio_features_and(tmp, val, vdev->host_features_ex);
>
>-    val &= vdev->host_features;
>     if (k->set_features) {
>-        k->set_features(vdev, val);
>+        bad = bad || virtio_features_use_ex(tmp);
>+        k->set_features(vdev, tmp[0]);
>     }
>-    vdev->guest_features = val;
>+
>+    virtio_features_copy(vdev->guest_features_ex, tmp);
>     return bad ? -1 : 0;
> }
>
> typedef struct VirtioSetFeaturesNocheckData {
>     Coroutine *co;
>     VirtIODevice *vdev;
>-    uint64_t val;
>+    uint64_t val[VIRTIO_FEATURES_NU64S];
>     int ret;
> } VirtioSetFeaturesNocheckData;
>
>@@ -3098,14 +3128,15 @@ static void virtio_set_features_nocheck_bh(void *opaque)
> }
>
> static int coroutine_mixed_fn
>-virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
>+virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
>+                                     const uint64_t *val)
> {
>     if (qemu_in_coroutine()) {
>         VirtioSetFeaturesNocheckData data = {
>             .co = qemu_coroutine_self(),
>             .vdev = vdev,
>-            .val = val,
>         };
>+        virtio_features_copy(data.val, val);
>         aio_bh_schedule_oneshot(qemu_get_current_aio_context(),
>                                 virtio_set_features_nocheck_bh, &data);
>         qemu_coroutine_yield();
>@@ -3117,6 +3148,7 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev, uint64_t val)
>
> int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> {
>+    uint64_t features[VIRTIO_FEATURES_NU64S];
>     int ret;
>     /*
>      * The driver must not attempt to set features after feature negotiation
>@@ -3132,7 +3164,8 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>                       __func__, vdev->name);
>     }
>
>-    ret = virtio_set_features_nocheck(vdev, val);
>+    virtio_features_from_u64(features, val);
>+    ret = virtio_set_features_nocheck(vdev, features);
>     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
>         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
>         int i;
>@@ -3155,6 +3188,7 @@ void virtio_reset(void *opaque)
> {
>     VirtIODevice *vdev = opaque;
>     VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
>+    uint64_t features[VIRTIO_FEATURES_NU64S];
>     int i;
>
>     virtio_set_status(vdev, 0);
>@@ -3181,7 +3215,8 @@ void virtio_reset(void *opaque)
>     vdev->start_on_kick = false;
>     vdev->started = false;
>     vdev->broken = false;
>-    virtio_set_features_nocheck(vdev, 0);
>+    virtio_features_clear(features);
>+    virtio_set_features_nocheck(vdev, features);
>     vdev->queue_sel = 0;
>     vdev->status = 0;
>     vdev->disabled = false;
>@@ -3264,7 +3299,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>      * Note: devices should always test host features in future - don't create
>      * new dependencies like this.
>      */
>-    vdev->guest_features = features;
>+    virtio_features_from_u64(vdev->guest_features_ex, features);
>
>     config_len = qemu_get_be32(f);
>
>@@ -3343,26 +3378,17 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>         vdev->device_endian = virtio_default_endian();
>     }
>
>-    if (virtio_64bit_features_needed(vdev)) {
>-        /*
>-         * Subsection load filled vdev->guest_features.  Run them
>-         * through virtio_set_features to sanity-check them against
>-         * host_features.
>-         */
>-        uint64_t features64 = vdev->guest_features;
>-        if (virtio_set_features_nocheck_maybe_co(vdev, features64) < 0) {
>-            error_report("Features 0x%" PRIx64 " unsupported. "
>-                         "Allowed features: 0x%" PRIx64,
>-                         features64, vdev->host_features);
>-            return -1;
>-        }
>-    } else {
>-        if (virtio_set_features_nocheck_maybe_co(vdev, features) < 0) {
>-            error_report("Features 0x%x unsupported. "
>-                         "Allowed features: 0x%" PRIx64,
>-                         features, vdev->host_features);
>-            return -1;
>-        }
>+    /*
>+     * guest_features_ex is fully initialized with u32 features and upper
>+     * bits have been filled as needed by the later load.
>+     */
>+    if (virtio_set_features_nocheck_maybe_co(vdev,
>+                                             vdev->guest_features_ex) < 0) {
>+        error_report("Features 0x" VIRTIO_FEATURES_FMT " unsupported. "
>+                     "Allowed features: 0x" VIRTIO_FEATURES_FMT,
>+                     VIRTIO_FEATURES_PR(vdev->guest_features_ex),
>+                     VIRTIO_FEATURES_PR(vdev->host_features_ex));
>+        return -1;
>     }
>
>     if (!virtio_device_started(vdev, vdev->status) &&
>-- 
>2.51.0
>


