Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5D0C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 17:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlAwJ-0001GC-Ll; Fri, 15 Mar 2024 13:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rlAwI-0001Fg-8q
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 13:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rlAwF-00027F-Th
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 13:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710522106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=51gZPswrSDaQk9IYQ7R3kkrfwI8XZ27bVNubmGvHZVI=;
 b=byFqdsMgo0Np6RvikxyzIkkH29byhn8OeiISAanjCFSoPp1HT5IHR9VqK7qUCpUnjrt78q
 Fhr7cG2zAvr5u1M1s4O5khzJS+uOA/st966VVmXX5aTOV+I4y/n8l7UGkEBOHT+JhSa6yk
 fDoAdu82CuauC2SqLVbpoUQBTUISqYY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-rj2ACDy-PeaLDksqpaalBA-1; Fri, 15 Mar 2024 13:01:44 -0400
X-MC-Unique: rj2ACDy-PeaLDksqpaalBA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7876cf4554eso215129285a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 10:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710522104; x=1711126904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51gZPswrSDaQk9IYQ7R3kkrfwI8XZ27bVNubmGvHZVI=;
 b=RQlO2reb9QdmtzkwFgFeaNSi1YNvhiojutVXdgnMAi8hvDZNLuWzq+T+FKRCUCHVCY
 fN6vfdfrCDZFfjlVr5++s/FvxMWWis2mutZKubWTA554tgrsICNaxwcItyhUhXXLeQLR
 MRbEPezaB+reNBQbCig5fEgGv+KzSn1JieMGxSqQsogTI4DoJBK1rPKDwG7MfrpTd7/x
 UYrGwyI3lcNV3jWJJ4ybRiz8iGE7tq1GcPnbFS5hMQTrNc1utq+4hy4Bh9BBsjR8VLqA
 DtQv34kJkf14LZQrqwIumV8o5fIQeczv/hyYDDj1H4dgxA3oHXo0gk7uyshcpEOWratD
 5A2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnH0HPX57SVq9m3f5OtbYjJ6GnxKxjtWw2GHmUxkMgib51KxP0VFfdR1pa6X1OGvYdqFOA8uBVZ5QD7UJXl/P0LQwrtYs=
X-Gm-Message-State: AOJu0YyKp15YFTECG27GW/H4Avj9dBzlXZCxzXwZMm1pFkDBGOqog7BM
 E0d0CZ07Epu5yKy4RkT+wsl1Frma6UPEBmBwLSrRazMeluR0hFZqfiEbGfmqQleZjj1Wmd6XQ3s
 V7KhG2Tu9lnxmhGmVXdLQGdMwx8S4wO3QorWHsX1NRafK7GpkmvLFhdx3xW0d
X-Received: by 2002:a05:620a:8422:b0:789:c8b0:1fe1 with SMTP id
 pc34-20020a05620a842200b00789c8b01fe1mr5074929qkn.13.1710522103957; 
 Fri, 15 Mar 2024 10:01:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgCSk/dw9p4A0fEomSlVTe2oEppkrOqdUBQ9r9Zl5FCjF5x/uzcP6xYdrXiE6pq6e5pGJ69Q==
X-Received: by 2002:a05:620a:8422:b0:789:c8b0:1fe1 with SMTP id
 pc34-20020a05620a842200b00789c8b01fe1mr5074897qkn.13.1710522103611; 
 Fri, 15 Mar 2024 10:01:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 vq4-20020a05620a558400b00789e2b68cf2sm1170222qkn.44.2024.03.15.10.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 10:01:42 -0700 (PDT)
Date: Fri, 15 Mar 2024 18:01:39 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mst@redhat.com, eperezma@redhat.com, 
 jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0 v3] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
Message-ID: <vt3h6njmyzkg35tmbsvkcw2n3udqovgjoby27vuacm2kas7wh7@c77t4oqy6bgx>
References: <20240315155949.86066-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240315155949.86066-1-kwolf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 15, 2024 at 04:59:49PM +0100, Kevin Wolf wrote:
>VDUSE requires that virtqueues are first enabled before the DRIVER_OK
>status flag is set; with the current API of the kernel module, it is
>impossible to enable the opposite order in our block export code because
>userspace is not notified when a virtqueue is enabled.
>
>This requirement also mathces the normal initialisation order as done by
>the generic vhost code in QEMU. However, commit 6c482547 accidentally
>changed the order for vdpa-dev and broke access to VDUSE devices with
>this.
>
>This changes vdpa-dev to use the normal order again and use the standard
>vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
>used with vdpa-dev again after this fix.
>
>vhost_net intentionally avoided enabling the vrings for vdpa and does
>this manually later while it does enable them for other vhost backends.
>Reflect this in the vhost_net code and return early for vdpa, so that
>the behaviour doesn't change for this device.
>
>Cc: qemu-stable@nongnu.org
>Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
>v2:
>- Actually make use of the @enable parameter
>- Change vhost_net to preserve the current behaviour
>
>v3:
>- Updated trace point [Stefano]
>- Fixed typo in comment [Stefano]
>
> hw/net/vhost_net.c     | 10 ++++++++++
> hw/virtio/vdpa-dev.c   |  5 +----
> hw/virtio/vhost-vdpa.c | 29 ++++++++++++++++++++++++++---
> hw/virtio/vhost.c      |  8 +++++++-
> hw/virtio/trace-events |  2 +-
> 5 files changed, 45 insertions(+), 9 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

>
>diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>index e8e1661646..fd1a93701a 100644
>--- a/hw/net/vhost_net.c
>+++ b/hw/net/vhost_net.c
>@@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
>     VHostNetState *net = get_vhost_net(nc);
>     const VhostOps *vhost_ops = net->dev.vhost_ops;
>
>+    /*
>+     * vhost-vdpa network devices need to enable dataplane virtqueues after
>+     * DRIVER_OK, so they can recover device state before starting dataplane.
>+     * Because of that, we don't enable virtqueues here and leave it to
>+     * net/vhost-vdpa.c.
>+     */
>+    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>+        return 0;
>+    }
>+
>     nc->vring_enable = enable;
>
>     if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
>diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>index eb9ecea83b..13e87f06f6 100644
>--- a/hw/virtio/vdpa-dev.c
>+++ b/hw/virtio/vdpa-dev.c
>@@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>
>     s->dev.acked_features = vdev->guest_features;
>
>-    ret = vhost_dev_start(&s->dev, vdev, false);
>+    ret = vhost_dev_start(&s->dev, vdev, true);
>     if (ret < 0) {
>         error_setg_errno(errp, -ret, "Error starting vhost");
>         goto err_guest_notifiers;
>     }
>-    for (i = 0; i < s->dev.nvqs; ++i) {
>-        vhost_vdpa_set_vring_ready(&s->vdpa, i);
>-    }
>     s->started = true;
>
>     /*
>diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>index ddae494ca8..31453466af 100644
>--- a/hw/virtio/vhost-vdpa.c
>+++ b/hw/virtio/vhost-vdpa.c
>@@ -886,19 +886,41 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev *dev, int idx)
>     return idx;
> }
>
>-int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>+static int vhost_vdpa_set_vring_enable_one(struct vhost_vdpa *v, unsigned idx,
>+                                           int enable)
> {
>     struct vhost_dev *dev = v->dev;
>     struct vhost_vring_state state = {
>         .index = idx,
>-        .num = 1,
>+        .num = enable,
>     };
>     int r = vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
>
>-    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
>+    trace_vhost_vdpa_set_vring_enable_one(dev, idx, enable, r);
>     return r;
> }
>
>+static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
>+{
>+    struct vhost_vdpa *v = dev->opaque;
>+    unsigned int i;
>+    int ret;
>+
>+    for (i = 0; i < dev->nvqs; ++i) {
>+        ret = vhost_vdpa_set_vring_enable_one(v, i, enable);
>+        if (ret < 0) {
>+            return ret;
>+        }
>+    }
>+
>+    return 0;
>+}
>+
>+int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>+{
>+    return vhost_vdpa_set_vring_enable_one(v, idx, 1);
>+}
>+
> static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
>                                        int fd)
> {
>@@ -1514,6 +1536,7 @@ const VhostOps vdpa_ops = {
>         .vhost_set_features = vhost_vdpa_set_features,
>         .vhost_reset_device = vhost_vdpa_reset_device,
>         .vhost_get_vq_index = vhost_vdpa_get_vq_index,
>+        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
>         .vhost_get_config  = vhost_vdpa_get_config,
>         .vhost_set_config = vhost_vdpa_set_config,
>         .vhost_requires_shm_log = NULL,
>diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>index 2c9ac79468..0000a66186 100644
>--- a/hw/virtio/vhost.c
>+++ b/hw/virtio/vhost.c
>@@ -1984,7 +1984,13 @@ static int vhost_dev_set_vring_enable(struct vhost_dev *hdev, int enable)
>     return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
> }
>
>-/* Host notifiers must be enabled at this point. */
>+/*
>+ * Host notifiers must be enabled at this point.
>+ *
>+ * If @vrings is true, this function will enable all vrings before starting the
>+ * device. If it is false, the vring initialization is left to be done by the
>+ * caller.
>+ */
> int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
> {
>     int i, r;
>diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>index 77905d1994..3f18536868 100644
>--- a/hw/virtio/trace-events
>+++ b/hw/virtio/trace-events
>@@ -48,7 +48,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "dev: %p features: 0x%"PRI
> vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_id %"PRIu32
> vhost_vdpa_reset_device(void *dev) "dev: %p"
> vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d vq idx: %d"
>-vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx: %u, r: %d"
>+vhost_vdpa_set_vring_enable_one(void *dev, unsigned i, int enable, int r) "dev: %p, idx: %u, enable: %u, r: %d"
> vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
> vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
> vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev: %p config: %p config_len: %"PRIu32
>-- 
>2.44.0
>


