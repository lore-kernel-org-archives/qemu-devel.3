Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B126EF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmwP-0004YI-1E; Wed, 04 Mar 2026 09:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxmwN-0004MH-Ew
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:11:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1vxmwL-0004aq-5Y
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772633463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFYA4ajU3TENwATn1xfHwwf1hZNKIqDQQQ0OVNE47E4=;
 b=RwyRAV07AdGa5WWJRUgregjcEKfHoXUlaHYoQs9RWJW49W4+c4x1dZ+VYER4OZEvkIVZSs
 hnDIF8PHpQGTSKGaaXXiEr9Mjrn4n6utcdkRuQJjvLvM/hBc49J6T+eHpwCyC2z2nY06X9
 preROYsi2ZqHtDmi7mqHBKXqZS028zY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-tZawWTeEOHyBXfUnc0fqRg-1; Wed, 04 Mar 2026 09:11:02 -0500
X-MC-Unique: tZawWTeEOHyBXfUnc0fqRg-1
X-Mimecast-MFC-AGG-ID: tZawWTeEOHyBXfUnc0fqRg_1772633461
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-794b74a8b2bso95757197b3.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 06:11:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772633461; cv=none;
 d=google.com; s=arc-20240605;
 b=BFY80a5tzibCvzN35x5fWeV9U4fFYmIKkYwiwulNScXDuGEQs5Faid8vKmPi2sPGv3
 n2lVAZN+Vw3sE7uIRQ6rRKZcs8/qADQncPMrQurUwretutBwynHbAwrJv3+n0x1O45Up
 IiU5+JoHmahVYcuH5yIwvgHB4lgm3gRi94MK9rZkyYy2HM8oLzuxq3iSgsEM/FJPTifz
 +5TDhwqlLrxOdNLPIbs51EAg2v/FTyz2x7ibBnEUOSVma0EZt9PQPZ9tTiyW/+7DBbdi
 GNZSp456K9lUGJ+Mih6sCgWciwCY6WdANFjFKV3y4se4dqK+2QvpNzFKuIcfMLIEn8Ml
 SUqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NFYA4ajU3TENwATn1xfHwwf1hZNKIqDQQQ0OVNE47E4=;
 fh=4ut0VWvdeFwSfmTm/Ki/2jEZaA5lSfo5qoMDWVqAkBs=;
 b=Fk38LksEJL/GSv3/W7676YxXkBwK3nJItulbSDhBAHZ3rIXpYlQ3Ksa6gW+EOGIPdI
 VWxFAfCk9D+4xuHl2Ih9SyY2mKlwN1V78qTrc6qdICym5GJaD9uZDeem0FkcArCd2uW/
 IeRC5yz/uPVWb8/1EuvypLuf2c/8GoHwnLIyDnu4ag7RDMnQX/+x+4uaT1PUAgktwMfU
 7lCbwbxiNil4iEy7hT1D3kE9eE9vN+AZK1wuV7yjggQygR/NhKrAxaw+nIHe2QufDF8S
 Yy5m7aX3kE6MBLomfOZdHLcHi5NgvigMcmYpgTUWH473D3ITk0roKinwZVgjMBKLb4Ed
 leyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772633461; x=1773238261; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFYA4ajU3TENwATn1xfHwwf1hZNKIqDQQQ0OVNE47E4=;
 b=NurL/52yxiTMTXq2DCTHF0Qn05j6SydeVAbTUbos0NRjOIye1h3SiumqsG0DC3w1+y
 tbf16xnQsjk6mjHYpM/+7+vJdU1Gha6MStYeQQ4eVuYOgRXeodOvgt3wNOJ3PJQMBUGT
 LORaO4sL8VRYP9PBFmqpzB03EmIZ3HUjIPtC9Vr4OxLOdzfs8wCBpsoFctWBRTtfnUBA
 8rx91GK/eaYxreLFNc8L/NgFW8N5DhWg8XJ+FCZbhul0/jK/cRWmKAuE8s7XvsZIUcQC
 pkZgDykRa5qDduRAAav23JWsF3brK6mp3S1gW75OlN0JVnOlEjpBWkWYl6aWwnrI/ROf
 U9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772633461; x=1773238261;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NFYA4ajU3TENwATn1xfHwwf1hZNKIqDQQQ0OVNE47E4=;
 b=OmHNM7cvpAYzNGEGCB0cYzL/zA90TSSTJhvUkg3UQ+YsrzyvrJrAie/MUDV9v10Alz
 P8Gf3r4cRvRVPLXo7g1dJ7dO3u7+8HRoqiFDydaCVprP7jWB94ouPaaEz0/h3Wg+tukg
 jIVigmKM7gBAkIMa4Cl4wMEnIA952c0Z3YmHHMhSdk07OQS2Szvd1XwJy62wwhOvF0X3
 FhPRnbr20/KSt4hYwg1i+PMQs6kwK0ou8p0SXXxxVSUIkeHtfDR644JkZz6AsBG06hVQ
 zsyhXLQGmupytAQggnuzYcUlijEZVQLgMuxfcs/5OETWniLxZL+o9n5hTGpvDIm2ukq6
 bCDA==
X-Gm-Message-State: AOJu0YwknXZHgrbipD8APO6gZJ3L9MZUgSODvcnAcHok6/+vY0ud8Jwb
 3K3KY64UhYG0nI2CdzQ+KK1NFlYIkRLL+4HM6qaAYsK8OmGtQeb1UCns1eMJNtU4Y0IdM5jcAyx
 o9gTeIsNU2AvhOqBrbLO52y8323rfhrOXnvX4WaBMMr5vRaxQiDkakW+XFi4Q8+V2SxthcaqWa1
 1yeWTvNwp4jyD90CX++vvLblywtxGxjq8=
X-Gm-Gg: ATEYQzy+MsuTfXh0g+bxmbGDrjXVU/QphkI1BjUmoKHRqBMEgCA/cdU1YZHcm/zdJIG
 pH5C6ueGW/VxDdPeoVOzFzM/mjMoV9tz9M001361ZhWQUdGCLoTk6hy9eGxG6hZg+qf/yuUv7CL
 Er4JVdOZRzb4IVJhCeWAVgQ06XTIs4iIzx8ow1NegUGhmU433Kp2H4ydweN8ogoW7u1VK9FR7mX
 g==
X-Received: by 2002:a05:690e:12ca:b0:64c:99d7:8d14 with SMTP id
 956f58d0204a3-64cf9b3173emr1938280d50.13.1772633461479; 
 Wed, 04 Mar 2026 06:11:01 -0800 (PST)
X-Received: by 2002:a05:690e:12ca:b0:64c:99d7:8d14 with SMTP id
 956f58d0204a3-64cf9b3173emr1938249d50.13.1772633461071; Wed, 04 Mar 2026
 06:11:01 -0800 (PST)
MIME-Version: 1.0
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-8-aesteve@redhat.com>
 <aagv94qy56VjyNba@sgarzare-redhat>
In-Reply-To: <aagv94qy56VjyNba@sgarzare-redhat>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 4 Mar 2026 15:10:50 +0100
X-Gm-Features: AaiRm51Z9ffkM-7Bv8XdG4R-ZZpOqlBu64qB-mcQJdK1fuGhRseDeOwwIN3FQGc
Message-ID: <CADSE00KjOmtNhAhAnFODtBLAPEAx5aS4q=PRMw_KEeW7ovV68g@mail.gmail.com>
Subject: Re: [PATCH v13 7/7] vhost-user-device: Add shared memory BAR
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com, 
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com, hi@alyssa.is,
 stevensd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 4, 2026 at 2:26=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Thu, Feb 19, 2026 at 02:03:34PM +0100, Albert Esteve wrote:
> >Add shared memory BAR support to vhost-user-device-pci
> >to enable direct file mapping for VIRTIO Shared
> >Memory Regions.
> >
> >The implementation creates a consolidated shared
> >memory BAR that contains all VIRTIO Shared
> >Memory Regions as subregions. Each region is
> >configured with its proper shmid, size, and
> >offset within the BAR. The number and size of
> >regions are retrieved via VHOST_USER_GET_SHMEM_CONFIG
> >message sent by vhost-user-base during realization
> >after virtio_init().
> >
> >Specifiically, it uses BAR 3 to avoid conflicts, as
>
> nit: s/Specifiically/Specifically
>
> Discussed offline, this should be BAR 4 IIUC.
>
> >it is currently unused.
> >
> >The shared memory BAR is only created when the
> >backend supports VHOST_USER_PROTOCOL_F_SHMEM and
> >has configured shared memory regions. This maintains
> >backward compatibility with backends that do not
> >support shared memory functionality.
> >
> >Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >Signed-off-by: Albert Esteve <aesteve@redhat.com>
> >---
> > hw/virtio/vhost-user-base.c            | 46 ++++++++++++++++++++++++--
> > hw/virtio/vhost-user-test-device-pci.c | 38 +++++++++++++++++++--
> > 2 files changed, 79 insertions(+), 5 deletions(-)
> >
> >diff --git a/hw/virtio/vhost-user-base.c b/hw/virtio/vhost-user-base.c
> >index 01ab9ca56b..e5e8abae96 100644
> >--- a/hw/virtio/vhost-user-base.c
> >+++ b/hw/virtio/vhost-user-base.c
> >@@ -16,6 +16,7 @@
> > #include "hw/virtio/virtio-bus.h"
> > #include "hw/virtio/vhost-user-base.h"
> > #include "qemu/error-report.h"
> >+#include "migration/blocker.h"
> >
> > static void vub_start(VirtIODevice *vdev)
> >{
> >@@ -276,7 +277,8 @@ static void vub_device_realize(DeviceState *dev, Err=
or **errp)
> > {
> >     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> >     VHostUserBase *vub =3D VHOST_USER_BASE(dev);
> >-    int ret;
> >+    uint64_t memory_sizes[VIRTIO_MAX_SHMEM_REGIONS];
> >+    int i, ret, nregions, regions_processed =3D 0;
> >
> >     if (!vub->chardev.chr) {
> >         error_setg(errp, "vhost-user-base: missing chardev");
> >@@ -319,7 +321,7 @@ static void vub_device_realize(DeviceState *dev, Err=
or **errp)
> >
> >     /* Allocate queues */
> >     vub->vqs =3D g_ptr_array_sized_new(vub->num_vqs);
> >-    for (int i =3D 0; i < vub->num_vqs; i++) {
> >+    for (i =3D 0; i < vub->num_vqs; i++) {
> >         g_ptr_array_add(vub->vqs,
> >                         virtio_add_queue(vdev, vub->vq_size,
> >                                          vub_handle_output));
> >@@ -333,11 +335,49 @@ static void vub_device_realize(DeviceState *dev, E=
rror **errp)
> >                          VHOST_BACKEND_TYPE_USER, 0, errp);
> >
> >     if (ret < 0) {
> >-        do_vhost_user_cleanup(vdev, vub);
> >+        goto err;
> >+    }
> >+
> >+    ret =3D vub->vhost_dev.vhost_ops->vhost_get_shmem_config(&vub->vhos=
t_dev,
> >+                                                           &nregions,
> >+                                                           memory_sizes=
,
> >+                                                           errp);
> >+
> >+    if (ret < 0) {
> >+        goto err;
> >+    }
> >+
> >+    for (i =3D 0; i < VIRTIO_MAX_SHMEM_REGIONS && regions_processed < n=
regions; i++) {
> >+        if (memory_sizes[i]) {
> >+            regions_processed++;
> >+            if (vub->vhost_dev.migration_blocker =3D=3D NULL) {
> >+                error_setg(&vub->vhost_dev.migration_blocker,
> >+                       "Migration disabled: devices with VIRTIO Shared =
Memory "
> >+                       "Regions do not support migration yet.");
> >+                ret =3D migrate_add_blocker_normal(
> >+                    &vub->vhost_dev.migration_blocker,
> >+                    errp);
> >+
> >+                if (ret < 0) {
> >+                    goto err;
> >+                }
> >+            }
> >+
> >+            if (memory_sizes[i] % qemu_real_host_page_size() !=3D 0) {
> >+                error_setg(errp, "Shared memory %d size must be a power=
 of 2 "
> >+                                 "no smaller than the page size", i);
>
> Is this error message updated?

It is a bit misleading indeed. I will reword it, the size must be a
multiple of the host page size.


>
> >+                goto err;
> >+            }
> >+
> >+            virtio_new_shmem_region(vdev, i, memory_sizes[i]);
> >+        }
> >     }
> >
> >     qemu_chr_fe_set_handlers(&vub->chardev, NULL, NULL, vub_event, NULL=
,
> >                              dev, NULL, true);
> >+    return;
> >+err:
> >+    do_vhost_user_cleanup(vdev, vub);
> > }
> >
> > static void vub_device_unrealize(DeviceState *dev)
> >diff --git a/hw/virtio/vhost-user-test-device-pci.c b/hw/virtio/vhost-us=
er-test-device-pci.c
> >index 7f6d751690..22678e3277 100644
> >--- a/hw/virtio/vhost-user-test-device-pci.c
> >+++ b/hw/virtio/vhost-user-test-device-pci.c
> >@@ -12,10 +12,13 @@
> > #include "hw/virtio/vhost-user-base.h"
> > #include "hw/virtio/virtio-pci.h"
> >
> >+#define VIRTIO_DEVICE_PCI_SHMEM_BAR 4
> >+
> > struct VHostUserDevicePCI {
> >     VirtIOPCIProxy parent_obj;
> >
> >     VHostUserBase vub;
> >+    MemoryRegion shmembar;
> > };
> >
> > #define TYPE_VHOST_USER_TEST_DEVICE_PCI "vhost-user-test-device-pci-bas=
e"
> >@@ -25,10 +28,41 @@ OBJECT_DECLARE_SIMPLE_TYPE(VHostUserDevicePCI, VHOST=
_USER_TEST_DEVICE_PCI)
> > static void vhost_user_device_pci_realize(VirtIOPCIProxy *vpci_dev, Err=
or **errp)
> > {
> >     VHostUserDevicePCI *dev =3D VHOST_USER_TEST_DEVICE_PCI(vpci_dev);
> >-    DeviceState *vdev =3D DEVICE(&dev->vub);
> >+    DeviceState *dev_state =3D DEVICE(&dev->vub);
> >+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev_state);
> >+    VirtioSharedMemory *shmem, *next;
> >+    uint64_t offset =3D 0, shmem_size =3D 0;
> >
>
> I'd add a comment here to explain this since it's not immediately clear
> IMHO.
>
> >+    vpci_dev->modern_mem_bar_idx =3D 2;
> >     vpci_dev->nvectors =3D 1;
> >-    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> >+    qdev_realize(dev_state, BUS(&vpci_dev->bus), errp);
>
> IIUC before this patch qdev_realize() was the last step in this
> function, so we didn't check for any error, but now should we return
> earlier if it fails?

Agreed.

>
> >+
> >+    QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
>
> Is QSIMPLEQ_FOREACH_SAFE really needed here? IIUC we are not modifying
> the list, so can we use QSIMPLEQ_FOREACH ?

Agreed.

>
> >+        if (shmem->mr.size > UINT64_MAX - shmem_size) {
>
> Same here about using memory_region_size().
>
> >+            error_setg(errp, "Total shared memory required overflow");
> >+            return;
> >+        }
> >+        shmem_size =3D shmem_size + shmem->mr.size;
>
> Ditto about memory_region_size().
>
> >+    }
> >+    if (shmem_size) {
> >+        if (vpci_dev->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
> >+            error_setg(errp, "modern-pio-notify is not supported due to=
 PCI BAR layout limitations");
> >+            return;
> >+        }
> >+        memory_region_init(&dev->shmembar, OBJECT(vpci_dev),
> >+                           "vhost-device-pci-shmembar", shmem_size);
> >+        QSIMPLEQ_FOREACH_SAFE(shmem, &vdev->shmem_list, entry, next) {
>
> Ditto about QSIMPLEQ_FOREACH_SAFE.
>
> BTW my comments can eventually be fixed with a followup, overall LGTM,
> but if you need to resend, maybe we can fix them now.

I'm already applying these, I will resend them shortly. Thanks!

>
> In any case:
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
>
> >+            memory_region_add_subregion(&dev->shmembar, offset, &shmem-=
>mr);
> >+            virtio_pci_add_shm_cap(vpci_dev, VIRTIO_DEVICE_PCI_SHMEM_BA=
R,
> >+                                   offset, shmem->mr.size, shmem->shmid=
);
> >+            offset =3D offset + shmem->mr.size;
> >+        }
> >+        pci_register_bar(&vpci_dev->pci_dev, VIRTIO_DEVICE_PCI_SHMEM_BA=
R,
> >+                        PCI_BASE_ADDRESS_SPACE_MEMORY |
> >+                        PCI_BASE_ADDRESS_MEM_PREFETCH |
> >+                        PCI_BASE_ADDRESS_MEM_TYPE_64,
> >+                        &dev->shmembar);
> >+    }
> > }
> >
> > static void vhost_user_device_pci_class_init(ObjectClass *klass,
> >--
> >2.52.0
> >
>


