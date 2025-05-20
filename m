Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221CCC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHM7Y-00037U-Eg; Tue, 20 May 2025 08:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uHM7T-00037D-PK; Tue, 20 May 2025 08:30:56 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uHM7M-0004dk-TQ; Tue, 20 May 2025 08:30:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30e93626065so3314916a91.1; 
 Tue, 20 May 2025 05:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747744246; x=1748349046; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlR9VFYp0rVqtfOGzrIOOvHAi8/R+dlFOK2Zm4Gg5kE=;
 b=cc8SMmNTyaw3oowlHA2TkqwMWyrb7TVTCxdlYllobza+m/bHxhCuZue3E2KvEBo3zH
 DSvQSoTowoJcA2QjnHNY4fi8B+h/rlT269fEJr/sWEjv+vLbSNeLaEA+Ju4klkiW+nhy
 T4sS2R41XaZgMd36tkcT+gnEgE8X7nPP+H1o1PShkbepqcYbCO182IEx2HoUc/wpWNZA
 E4AWF1xEauzAAkFK3Xcl0P0AQwem186AZSkkuUTzUiSX8UkS/WnC2mP1kfk0ztIn9hhs
 Jab6NlQBSNPeUI6iHUjJRSNr9Jhcmmna0nQxud5PDk4V0Fur3j36uICtdp0uaIl0PW4R
 /uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744246; x=1748349046;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlR9VFYp0rVqtfOGzrIOOvHAi8/R+dlFOK2Zm4Gg5kE=;
 b=XZIA/Y3voX/MGb4PSbg1sGRgQY1FX/Xpa/hkeUJW7PjGpH04lQZUjt/boFRCDC87tj
 dq4zYwvJxOTQmm3XWC/a+imSGTP+EKzgz9nph2qP5TUUd4sfwCYMTAIGxhGotAIV0ojm
 aFMclD0c+7VrbL9+mzno6YsbVTAdFDnZSTvsSXLYIAdzogbICWwBCoxkxowtoGydUJ4q
 KkS/KWjoSt/4l0E2NsLkq9+d9HVQK/G3T2Mdmd/xdRH3QFTuDlr+SkvZrPNrqbD1Wdxo
 K9awFG73YLFQ2gwxAXA7GK2Okdj0Gtq5BWtFxCX4ndtYKje4NifqIiUwuS88K9VtvmGr
 6DZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJGe1dX0jhFvaZNvsE92jUCgT/+QOQh8gXAg7lvQlBSjnY6koA5VI1bs3zQkSBvp1UTN2p8WXlYiWf@nongnu.org,
 AJvYcCWq7N7JYMb2qBE9P5aFggRh1s+sp2ztf56B1yzuBqqxYow8G3fF7zDRx/tstUeH+pzioZrGLwppKO+W7bU=@nongnu.org
X-Gm-Message-State: AOJu0Yz5Jdvjs7usWhT5FHPBoLIWdyiSNz4uPxDENNDpYHgWx3j1ZMCY
 cjgpUq5t6ABZlUYFySvjmb2IUPPY7s3rPJ5XC+6vlKmr0/Hq/1u3nYONeZ7sMXVnlyJkQq10fQ4
 J+ZkDDTyFqh8eZFXW2Mum2r1nBUqO1ZSulQ+55sM=
X-Gm-Gg: ASbGncsqFoAGeihL3I+jSqIeOAZw4w7A35MAWPjzgUdfBG0MIkt3BdDyZcJlIoJqfCE
 Bw3LfRVfOaipkNRJNyF5qd2W2EGQUdnFeZcARHwtryeZpU/+Nu8XO1F0iXySs6zR/DHebe9S8Cz
 pjN8aTkVhy7/9dhDqWETcaYnnHOHb1w6aN
X-Google-Smtp-Source: AGHT+IHMgddAHtzDNwL8yWtHE1Q25qwZ/nYhKACJlh4ZfFIBfiKTucgTPvg7y8rA6xlqokj7pG6os4rZfSrclL/kF70=
X-Received: by 2002:a17:90b:3c90:b0:30e:37be:6963 with SMTP id
 98e67ed59e1d1-30e83228d1cmr24899547a91.29.1747744245668; Tue, 20 May 2025
 05:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
 <dmtvkhqkwdv7rzum6c4gs3uiekwckou3yp7w2ql6tijxshoiju@w4rplxvassk6>
In-Reply-To: <dmtvkhqkwdv7rzum6c4gs3uiekwckou3yp7w2ql6tijxshoiju@w4rplxvassk6>
From: Huaitong Han <oenhan@gmail.com>
Date: Tue, 20 May 2025 20:30:39 +0800
X-Gm-Features: AX0GCFv94MaQlLjCAs36tnlLpY0M1GRSM4U8mm7Sug0ZkVYDXKQ4Bu5dgWDnGTs
Message-ID: <CAAuJbeJ4+cop8m_9sy6VJtafADhxxmkwaFMZvfo_mmpmFU0Vxw@mail.gmail.com>
Subject: Re: [PATCH V2] vhost: Don't set vring call if guest notifier is unused
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, cohuck@redhat.com, 
 pasic@linux.ibm.com, farman@linux.ibm.com, borntraeger@linux.ibm.com, 
 leiyang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>, 
 Jidong Xia <xiajd@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=oenhan@gmail.com; helo=mail-pj1-x102f.google.com
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

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2025=E5=B9=B45=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=BA=8C 19:41=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, May 13, 2025 at 07:28:25PM +0800, oenhan@gmail.com wrote:
> >From: Huaitong Han <hanht2@chinatelecom.cn>
> >
> >The vring call fd is set even when the guest does not use MSI-X (e.g., i=
n the
> >case of virtio PMD), leading to unnecessary CPU overhead for processing
> >interrupts.
> >
> >The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimi=
zed the
> >case where MSI-X is enabled but the queue vector is unset. However, ther=
e's an
> >additional case where the guest uses INTx and the INTx_DISABLED bit in t=
he PCI
> >config is set, meaning that no interrupt notifier will actually be used.
> >
> >In such cases, the vring call fd should also be cleared to avoid redunda=
nt
> >interrupt handling.
> >
> >Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
>                    ^
> nit: there should be a space here.
>
> If you need to resend, I think you can fix also the one in the
> description.
>
> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> >---
> >V2:
> >- Retain the name `query_guest_notifiers`
> >- All qtest/unit test cases pass
> >- Fix V1 patch style problems
> >
> > hw/pci/pci.c                   |  2 +-
> > hw/s390x/virtio-ccw.c          |  7 +++++--
> > hw/virtio/vhost.c              |  3 +--
> > hw/virtio/virtio-pci.c         | 10 ++++++++--
> > include/hw/pci/pci.h           |  1 +
> > include/hw/virtio/virtio-bus.h |  2 +-
> > 6 files changed, 17 insertions(+), 8 deletions(-)
> >
> >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >index 352b3d12c8..45b491412a 100644
> >--- a/hw/pci/pci.c
> >+++ b/hw/pci/pci.c
> >@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
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
> >index d2f85b39f3..632708ba4d 100644
> >--- a/hw/s390x/virtio-ccw.c
> >+++ b/hw/s390x/virtio-ccw.c
> >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceState =
*d, bool running)
> >     }
> > }
> >
> >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
> >+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
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
> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >index 4cae7c1664..2a9a839763 100644
> >--- a/hw/virtio/vhost.c
> >+++ b/hw/virtio/vhost.c
> >@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
> >     }
> >
> >     if (k->query_guest_notifiers &&
> >-        k->query_guest_notifiers(qbus->parent) &&
> >-        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
> >+        !k->query_guest_notifiers(qbus->parent, idx)) {
> >         file.fd =3D -1;
> >         r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> >         if (r) {
> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >index 0fa8fe4955..d62e199489 100644
> >--- a/hw/virtio/virtio-pci.c
> >+++ b/hw/virtio/virtio-pci.c
> >@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(DeviceS=
tate *d, int n, bool assign,
> >     return 0;
> > }
> >
> >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
> >+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
> > {
> >     VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
> >-    return msix_enabled(&proxy->pci_dev);
> >+    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >+
> >+    if (msix_enabled(&proxy->pci_dev)) {
> >+        return virtio_queue_vector(vdev, n) !=3D VIRTIO_NO_VECTOR;
>
> Why are we moving this check in every callback, can't we leave it as
> before in vhost.c and here return true?
>
> I mean here:
>      if (msix_enabled(&proxy->pci_dev)) {
>          return true;
>      } else {
>          return !pci_irq_disabled(&proxy->pci_dev);
>      }
>
> and leave vhost.c untouched.
>

Thanks for the suggestion =E2=80=94 your approach indeed achieves the same
effect while keeping the interface unchanged.
However, I feel it might lead to some misunderstanding of the intended
semantics of query_guest_notifiers. My original intent was for this
callback to represent whether interrupts are actually in use by the
guest, and in that sense, checking whether the queue uses a vector is
part of that definition.
By splitting the logic =E2=80=94 checking msix_enabled and pci_irq_disabled
inside the bus callback, and virtio_queue_vector() separately in
vhost.c =E2=80=94 the semantic boundary becomes less clear. While it works
logically, it can reduce readability =E2=80=94 particularly because the
virtio_queue_vector() check semantically belongs under the
msix_enabled() branch, and combining it with the pci_irq_disabled()
case (INTx) could make the logic less clear to future readers.
Additionally, the set_host_notifier_mr interface already includes an
int n parameter, so adding it to query_guest_notifiers is accepted.

Thanks.
Huaitong Han

> Thanks,
> Stefano
>
> >+    } else {
> >+        return !pci_irq_disabled(&proxy->pci_dev);
> >+    }
> > }
> >
> > static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, boo=
l assign)
> >diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> >index c2fe6caa2c..8c24bd97db 100644
> >--- a/include/hw/pci/pci.h
> >+++ b/include/hw/pci/pci.h
> >@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *ls=
i_dev);
> >
> > qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
> > void pci_set_irq(PCIDevice *pci_dev, int level);
> >+int pci_irq_disabled(PCIDevice *d);
> >
> > static inline void pci_irq_assert(PCIDevice *pci_dev)
> > {
> >diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-b=
us.h
> >index 7ab8c9dab0..75d43b508a 100644
> >--- a/include/hw/virtio/virtio-bus.h
> >+++ b/include/hw/virtio/virtio-bus.h
> >@@ -48,7 +48,7 @@ struct VirtioBusClass {
> >     int (*load_done)(DeviceState *d, QEMUFile *f);
> >     int (*load_extra_state)(DeviceState *d, QEMUFile *f);
> >     bool (*has_extra_state)(DeviceState *d);
> >-    bool (*query_guest_notifiers)(DeviceState *d);
> >+    bool (*query_guest_notifiers)(DeviceState *d, int n);
> >     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
> >     int (*set_host_notifier_mr)(DeviceState *d, int n,
> >                                 MemoryRegion *mr, bool assign);
> >--
> >2.43.5
> >
>

