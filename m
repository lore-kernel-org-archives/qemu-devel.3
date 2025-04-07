Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F153C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 07:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1hIr-0001ZV-W2; Mon, 07 Apr 2025 03:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1u1hIT-0001Xv-2G; Mon, 07 Apr 2025 03:53:33 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1u1hIQ-0005gK-Hd; Mon, 07 Apr 2025 03:53:32 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-ad51f427054so2666375a12.1; 
 Mon, 07 Apr 2025 00:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744012407; x=1744617207; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cf+kAUA+YjpZvAnjsn7Us7xiQdIDLEdxWEeNxR7m0Cw=;
 b=Jgqk5n2H9acVzv/NRzFpL5SLvgxXedVi6zhzAUBwOLmjscbw20zvXVulfC7vuDYWsM
 DymaOD3bPqz6CfDUuA1O/x9ThSwroFsRGGY0IFyf9NBsU0Gei7kytJ7zJOJperqh8kfC
 b5YRBhPa2J37mLKuJjEJGIicQDR2JawAzk1ZwhNH4mqgJa4t3+W5QjqXwGjsN1XYXcLS
 ffsR+Cmb+XddTnHPT5+te3zw5qqrNVUD6IR8AxVeKYYyXE3N4sR66CKLE8lUlunHR5kA
 s/RAcU9jkgdXwl+6vu+PmHascMefVSJuikD5mY2ZejYL+7T6LUw9DCP+J6Y2F9Wq76f7
 hHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744012407; x=1744617207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cf+kAUA+YjpZvAnjsn7Us7xiQdIDLEdxWEeNxR7m0Cw=;
 b=M2ifo3w8PK8Sin5YyofLyWETb6sbBijHE44E0eEqrcNRQc/TxkvUTqI83Pvb2Rlk22
 u1waJmHy3bDDLdn8YQUvvjq5Eya4qFCxMh61OFGdV5Yr5XMwnuF5q0/85DkGfORlqB0E
 DwQpUe3U1eQ9o/Bzcqcm7cPPVEj9infq47usnqVWBtU1cLJode+tdc5YaLu5oSNyDONF
 wwj2ZCljRN3H4Cpr/b+sygLZqmNluVNBybycbjikEauOR/1sbi9mpIbP2dLJP+q4g0HO
 y+/3n2t+jtta2KL4Mhieg/crtXo3pXOXWZD1tTrqALVI/G3jboAXPrm6k1aYRetyFVQS
 uU7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFRxtbREMRR3VWf/bZewuNFLc8eYKQbDJKauKepSDM0bb5pG6aDc7X/cu/RTjwEPYp0ibXgvG4MuIiRbA=@nongnu.org,
 AJvYcCVpcxVojXv+jMR7vID4UTgue0bXvdmIV97VtlMf3MvLtbd1T1MfItZjtWHrD4/2sKKZnD/0SMr0Cpda@nongnu.org
X-Gm-Message-State: AOJu0YykplIqzdx8OnPzXDG46hPW9N3IMjNc1lAryGs6s8+4MZ5wpyW0
 8b8N+Fni7A/1ZQ60flBabckWw4HHMUrd4HFVZcezRdt/P6WFCx9dnxK1LeuZmRyMwhMObL5+lna
 PlNGd95lytB1siWSrcIRGTVcZUHE=
X-Gm-Gg: ASbGncsqOYtKiX2ioE0IsQ0oTJTBDmcpIqboWmmRmJNs1V1Xz04rIm8KaRZJY9tyc5Q
 VzMPnf8er94LXFCzO51lht4jgJI/jAR0pkst/FNLET10Kys5XBHJ6hCQrFlj4DRPGjHWCLRmwbI
 SsVVWIaR3n4frOa2r1AYVIWpjnpPIBD1uVRvFW3wTL00zNUBrA
X-Google-Smtp-Source: AGHT+IFGRCDl0yoE5pZnqM/KXEQbucT5Tw8aJr2kfs7Pr21D1Tc4dymtPg4g8RyuO8PRfrJ0Ofac9VBJw4cRF6DJhgo=
X-Received: by 2002:a17:90b:2704:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-306a4b86db2mr15720076a91.35.1744012407324; Mon, 07 Apr 2025
 00:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250326082537.379977-1-hanht2@chinatelecom.cn>
 <rqx2ixzzd3vnxirsyone67udq6xjztpp2jihwa7r44ffmdtjol@lpao7euzvcvj>
In-Reply-To: <rqx2ixzzd3vnxirsyone67udq6xjztpp2jihwa7r44ffmdtjol@lpao7euzvcvj>
From: Huaitong Han <oenhan@gmail.com>
Date: Mon, 7 Apr 2025 15:53:24 +0800
X-Gm-Features: ATxdqUF8miOlB0KSZGTizFIXSnjbsMLLAn2FG8UAFSu-wcGPAeA4TizwINIYJsg
Message-ID: <CAAuJbeJCz8btAZCAcg6+7jmEGH-pfcK6Qo1CCo85sC92CXX+GA@mail.gmail.com>
Subject: Re: [PATCH] vhost: Don't set vring call if guest notifier is unused
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=oenhan@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2025=E5=B9=B44=E6=9C=881=
=E6=97=A5=E5=91=A8=E4=BA=8C 18:49=E5=86=99=E9=81=93=EF=BC=9A

>
> On Wed, Mar 26, 2025 at 04:25:37PM +0800, oenhan@gmail.com wrote:
> >From: Huaitong Han <hanht2@chinatelecom.cn>
> >
> >The vring call fd is set even when the guest does not use msix (e.g., in=
 the
> >case of virtio pmd), leading to unnecessary CPU overhead for processing
> >interrupts. The previous patch optimized the condition where msix is
>
> What would be the previous patch?
>
> If you're referencing a patch already merged, please add them in the
> same form you used in Fixes, for example:
> Commit XXXXX ("vhost: ...") optimized the condition ...
>
Accept

> >enabled
> >but the queue vector is unset. However, there is a additional case where=
 the
> >guest interrupt notifier is effectively unused and the vring call fd sho=
uld
> >also be cleared: the guest does not use msix and the INTX_DISABLED bit i=
n the PCI
> >config is set.
>
> I don't know this code very well, can you explain better what you are
> changing with this patch and why change the name of
> query_guest_notifiers?
>
There's the case where the guest uses INTx, but the INTx_DISABLED bit
is set =E2=80=94 meaning no notifier will actually be used either. This pat=
ch
generalizes the logic to cover these cases.
The current name might be misleading. It seems to imply the device has
notifiers enabled, but in fact, the check is meant to reflect whether
the guest is actively using any interrupt mechanism.  I felt renaming
it could make the intent more clear and reduce confusion. Let me know
if you think it's better to keep the original name.

> >
> >Fixes: 96a3d98d2c ("vhost: don't set vring call if no vector")
> >
> >Test result:
> >https://raw.githubusercontent.com/oenhan/build_log/refs/heads/main/qemu/=
2503261015/build/meson-logs/testlog.txt
>
> Does it make sense to have this link in the commit, will it always be
> accessible?
MST initially asked me to make the test result public.  I understand
that embedding a direct test log link into the commit log is not good,
I will remove the test result link from the commit log in the next
version, and instead include it in the email reply body.

>
> >
> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> >---
> > hw/pci/pci.c                   |  2 +-
> > hw/s390x/virtio-ccw.c          |  9 ++++++---
> > hw/virtio/vhost.c              |  5 ++---
> > hw/virtio/virtio-pci.c         | 15 ++++++++++-----
> > include/hw/pci/pci.h           |  1 +
> > include/hw/virtio/virtio-bus.h |  2 +-
> > 6 files changed, 21 insertions(+), 13 deletions(-)
> >
> >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >index 2844ec5556..503a897528 100644
> >--- a/hw/pci/pci.c
> >+++ b/hw/pci/pci.c
> >@@ -1719,7 +1719,7 @@ static void pci_update_mappings(PCIDevice *d)
> >     pci_update_vga(d);
> > }
> >
> >-static inline int pci_irq_disabled(PCIDevice *d)
> >+int pci_irq_disabled(PCIDevice *d)
> > {
> >     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DIS=
ABLE;
> > }
> >diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> >index 43f3b162c8..af482a22cd 100644
> >--- a/hw/s390x/virtio-ccw.c
> >+++ b/hw/s390x/virtio-ccw.c
> >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState =
*d, bool running)
> >     }
> > }
> >
> >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
> >+static bool virtio_ccw_query_guest_notifiers_used(DeviceState *d, int n=
)
> > {
> >     CcwDevice *dev =3D CCW_DEVICE(d);
> >+    VirtioCcwDevice *vdev =3D VIRTIO_CCW_DEVICE(d);
> >+    VirtIODevice *virtio_dev =3D virtio_bus_get_device(&vdev->bus);
> >
> >-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA);
> >+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)
> >+            && virtio_queue_vector(virtio_dev, n) !=3D VIRTIO_NO_VECTOR=
;
> > }
> >
> > static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
> >@@ -1270,7 +1273,7 @@ static void virtio_ccw_bus_class_init(ObjectClass =
*klass, void *data)
> >     bus_class->max_dev =3D 1;
> >     k->notify =3D virtio_ccw_notify;
> >     k->vmstate_change =3D virtio_ccw_vmstate_change;
> >-    k->query_guest_notifiers =3D virtio_ccw_query_guest_notifiers;
> >+    k->query_guest_notifiers_used =3D virtio_ccw_query_guest_notifiers_=
used;
> >     k->set_guest_notifiers =3D virtio_ccw_set_guest_notifiers;
> >     k->save_queue =3D virtio_ccw_save_queue;
> >     k->load_queue =3D virtio_ccw_load_queue;
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 6aa72fd434..32634da836 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -1341,9 +1341,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
> >         vhost_virtqueue_mask(dev, vdev, idx, false);
> >     }
> >
> >-    if (k->query_guest_notifiers &&
> >-        k->query_guest_notifiers(qbus->parent) &&
> >-        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
> >+    if (k->query_guest_notifiers_used &&
> >+        !k->query_guest_notifiers_used(qbus->parent, idx)) {
> >         file.fd =3D -1;
> >         r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> >         if (r) {
> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >index 3ca3f849d3..25ff869618 100644
> >--- a/hw/virtio/virtio-pci.c
> >+++ b/hw/virtio/virtio-pci.c
> >@@ -30,6 +30,7 @@
> > #include "qemu/error-report.h"
> > #include "qemu/log.h"
> > #include "qemu/module.h"
> >+#include "hw/pci/pci.h"
> > #include "hw/pci/msi.h"
> > #include "hw/pci/msix.h"
> > #include "hw/loader.h"
> >@@ -1031,7 +1032,7 @@ static void virtio_pci_one_vector_mask(VirtIOPCIPr=
oxy *proxy,
> >
> >     /* If guest supports masking, keep irqfd but mask it.
> >      * Otherwise, clean it up now.
> >-     */
> >+     */
>
> Unrelated change.
>
> >     if (vdev->use_guest_notifier_mask && k->guest_notifier_mask) {
> >         k->guest_notifier_mask(vdev, queue_no, true);
> >     } else {
> >@@ -1212,10 +1213,15 @@ static int virtio_pci_set_guest_notifier(DeviceS=
tate *d, int n, bool assign,
> >     return 0;
> > }
> >
> >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
> >+static bool virtio_pci_query_guest_notifiers_used(DeviceState *d, int n=
)
> > {
> >     VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
> >-    return msix_enabled(&proxy->pci_dev);
> >+    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >+
> >+    if (msix_enabled(&proxy->pci_dev))
> >+        return virtio_queue_vector(vdev, n) !=3D VIRTIO_NO_VECTOR;
> >+    else
> >+        return !pci_irq_disabled(&proxy->pci_dev);
> > }
> >
> > static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, boo=
l assign)
> >@@ -2599,7 +2605,7 @@ static void virtio_pci_bus_class_init(ObjectClass =
*klass, void *data)
> >     k->save_extra_state =3D virtio_pci_save_extra_state;
> >     k->load_extra_state =3D virtio_pci_load_extra_state;
> >     k->has_extra_state =3D virtio_pci_has_extra_state;
> >-    k->query_guest_notifiers =3D virtio_pci_query_guest_notifiers;
> >+    k->query_guest_notifiers_used =3D virtio_pci_query_guest_notifiers_=
used;
> >     k->set_guest_notifiers =3D virtio_pci_set_guest_notifiers;
> >     k->set_host_notifier_mr =3D virtio_pci_set_host_notifier_mr;
> >     k->vmstate_change =3D virtio_pci_vmstate_change;
> >@@ -2630,4 +2636,3 @@ static void virtio_pci_register_types(void)
> > }
> >
> > type_init(virtio_pci_register_types)
> >-
> >diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >index 822fbacdf0..de4ab28046 100644
> >--- a/include/hw/pci/pci.h
> >+++ b/include/hw/pci/pci.h
> >@@ -256,6 +256,7 @@ void pci_del_capability(PCIDevice *pci_dev, uint8_t =
cap_id, uint8_t cap_size);
> >
> > uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
> >
> >+int pci_irq_disabled(PCIDevice *d);
> >
> > uint32_t pci_default_read_config(PCIDevice *d,
> >                                  uint32_t address, int len);
> >diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-b=
us.h
> >index 7ab8c9dab0..de75a44895 100644
> >--- a/include/hw/virtio/virtio-bus.h
> >+++ b/include/hw/virtio/virtio-bus.h
> >@@ -48,7 +48,7 @@ struct VirtioBusClass {
> >     int (*load_done)(DeviceState *d, QEMUFile *f);
> >     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
> >     bool (*has_extra_state)(DeviceState *d);
> >-    bool (*query_guest_notifiers)(DeviceState *d);
> >+    bool (*query_guest_notifiers_used)(DeviceState *d, int n);
> >     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
> >     int (*set_host_notifier_mr)(DeviceState *d, int n,
> >                                 MemoryRegion *mr, bool assign);
> >--
> >2.43.5
> >
>

