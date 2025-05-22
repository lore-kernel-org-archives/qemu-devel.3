Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C591C54756
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 03:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHwmP-0001mm-KI; Wed, 21 May 2025 23:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uHwmN-0001mZ-FP; Wed, 21 May 2025 23:39:35 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uHwmK-0004dD-Rm; Wed, 21 May 2025 23:39:34 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-30e9e81d517so4314596a91.1; 
 Wed, 21 May 2025 20:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747885169; x=1748489969; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0r8474/uFf9L2afzZJSh7NXtoD0nWscVfHcUK9TtLQ=;
 b=C3MDdWYaIcfkqyiRfu5WkSR0pjkITDjzi2XU/Re99Dy2sCSIwyX7I1nan5lXyKl/7r
 +V40C9Lm8bN9skZUkivTfqrqujAWydL+PfVYh2Bv1a6xBvxH7TduQ49Ue83lCkyDTKQ7
 lquzqm9QSaOVQAVWxnkbMv6j6UPQGtvma26Wx/OuTBwGMYTzKFZW/32j3R0W7hnrWIOm
 60U3gUNTrJfSDcqFk6rrz6WCO+b2Z6j2an1Sszl+TaAtcfp4BSuO0EpJcBbqtDP26i2K
 eAIhzhJawpkJmDDpfi0Wn90PpICpxHLH4VU3VUG/jDq4jQzBr02lpKNw0BJ7vutYZAVq
 Kh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747885169; x=1748489969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0r8474/uFf9L2afzZJSh7NXtoD0nWscVfHcUK9TtLQ=;
 b=ujg9GQoWas+RIPhYMTb+POQhSmr2389BSkxyeDfYbCMxrK0xZC2Q1RwdV/gHLr1NhO
 2Adz6e5f2/N1vdaJz6pSXRDa/+hs4WiqKwxfWQThw6QS072Tqf6xnYJZ/OaCxyE/qCCh
 VvzF7KYB6D1UdxXYL0W1JIqGgLifjl8Jw9sM6BwHOUlXx3DmabnjV8F8cyb7IDmu30VI
 i9qu6HK0phLZMdIQHrsCOeeDauM6YLs1pW4A+NGBH4nDcxrjlANH+8v/BCm7Ky7Tb5J9
 Zjamy8IWAVI2CewXlt9DDsWO1sG4x3XAQoWZnCks90FQUX3bt17n9sA5tCrzCeNwFGnA
 XEqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE3RQ9ZQkqrGt3cOAY0NcU+PdkQ8JJ8BPYVPUc2UIsAJf9Xh7vzgzuhgHq5/MPooZUFaF98nUbsX+Y@nongnu.org,
 AJvYcCXaj7vqcujZ4I9POz9Obrvh9RTv7fJe5ebV28hx5dKSmisxt7y0E58X90RcXx3BYc68t2bd7OKBgriLY+s=@nongnu.org
X-Gm-Message-State: AOJu0Yx+VwDYieqr3rS/evdBEzdo7P6LTY0DjU6p4nLLenbbPN2UHKoF
 /TXYkZIwDOkGgActHC9mpo7b0d5VlASyVCasrkVIUuIXrY1UtaWk3gPpvCGRqQCqde1OzY5Yq7t
 eKzYPEb5lXw6CySY/pKlOlObNwRq/Dag=
X-Gm-Gg: ASbGncuHoooVdY0xnx11n2eZiUBiUG919T6BsRbSBbklNJUFzvSlUvhYDosQbnnpjNU
 Ir5FSxV4SKAYBWP8fMoCUIHkQxziXqB8uoLXkG1TxC7ZTAKqyYy9nQSQtyrNld9TTgKXQ0jCL4h
 sscxE5n9Qs1wYw5QFFW92StQ2+GGfW3QlUaTnDxnSc+d4=
X-Google-Smtp-Source: AGHT+IEAF4I1qXZqF6nvdn7OBB19hIUoVQ/sH80gKld1+8jVtyfXb/+u0t4KEF9cVDMnMtDHvsBcHHasKRe4VUUUS/Q=
X-Received: by 2002:a17:90b:3f4c:b0:2fe:994d:613b with SMTP id
 98e67ed59e1d1-30e7d5be445mr33078104a91.35.1747885168666; Wed, 21 May 2025
 20:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250513112825.1731347-1-hanht2@chinatelecom.cn>
 <dmtvkhqkwdv7rzum6c4gs3uiekwckou3yp7w2ql6tijxshoiju@w4rplxvassk6>
 <CAAuJbeJ4+cop8m_9sy6VJtafADhxxmkwaFMZvfo_mmpmFU0Vxw@mail.gmail.com>
 <js757hz2wuwhjafk7z2gmfqxdb6d5hhjx3ul7bwqst5qdqa5b7@f2lhjb6itxo2>
In-Reply-To: <js757hz2wuwhjafk7z2gmfqxdb6d5hhjx3ul7bwqst5qdqa5b7@f2lhjb6itxo2>
From: Huaitong Han <oenhan@gmail.com>
Date: Thu, 22 May 2025 11:39:18 +0800
X-Gm-Features: AX0GCFtBEZFP_xcet02IknTTRMMpaUxAbrMwbM4vxew1qpbGeFLijebsngc76ZY
Message-ID: <CAAuJbeL-yyigS8jE2xvvq84cUKmggrCPgc+ko3=Ks+JvokxF8Q@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=oenhan@gmail.com; helo=mail-pj1-x1033.google.com
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

Hi Stefano,

I=E2=80=99ve implemented the version based on your suggestion. The core log=
ic
now looks like this:
if (k->query_guest_notifiers &&
    !k->query_guest_notifiers(qbus->parent) &&
    virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
    ...
}

And in virtio_pci_query_guest_notifiers():
if (msix_enabled(&proxy->pci_dev)) {
    return false;
} else {
    return !pci_irq_disabled(&proxy->pci_dev);
}

Although this works and preserves the original interface, I personally
find the logic less intuitive to read.
if you're fine with this version, I=E2=80=99ll go ahead and send v3 based o=
n it.

Thanks.
Huaitong Han

Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2025=E5=B9=B45=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=BA=8C 20:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, May 20, 2025 at 08:30:39PM +0800, Huaitong Han wrote:
> >Stefano Garzarella <sgarzare@redhat.com> =E4=BA=8E2025=E5=B9=B45=E6=9C=
=8820=E6=97=A5=E5=91=A8=E4=BA=8C 19:41=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Tue, May 13, 2025 at 07:28:25PM +0800, oenhan@gmail.com wrote:
> >> >From: Huaitong Han <hanht2@chinatelecom.cn>
> >> >
> >> >The vring call fd is set even when the guest does not use MSI-X (e.g.=
, in the
> >> >case of virtio PMD), leading to unnecessary CPU overhead for processi=
ng
> >> >interrupts.
> >> >
> >> >The commit 96a3d98d2c("vhost: don't set vring call if no vector") opt=
imized the
> >> >case where MSI-X is enabled but the queue vector is unset. However, t=
here's an
> >> >additional case where the guest uses INTx and the INTx_DISABLED bit i=
n the PCI
> >> >config is set, meaning that no interrupt notifier will actually be us=
ed.
> >> >
> >> >In such cases, the vring call fd should also be cleared to avoid redu=
ndant
> >> >interrupt handling.
> >> >
> >> >Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")
> >>                    ^
> >> nit: there should be a space here.
> >>
> >> If you need to resend, I think you can fix also the one in the
> >> description.
> >>
> >> >Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
> >> >Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
> >> >Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
> >> >---
> >> >V2:
> >> >- Retain the name `query_guest_notifiers`
> >> >- All qtest/unit test cases pass
> >> >- Fix V1 patch style problems
> >> >
> >> > hw/pci/pci.c                   |  2 +-
> >> > hw/s390x/virtio-ccw.c          |  7 +++++--
> >> > hw/virtio/vhost.c              |  3 +--
> >> > hw/virtio/virtio-pci.c         | 10 ++++++++--
> >> > include/hw/pci/pci.h           |  1 +
> >> > include/hw/virtio/virtio-bus.h |  2 +-
> >> > 6 files changed, 17 insertions(+), 8 deletions(-)
> >> >
> >> >diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> >index 352b3d12c8..45b491412a 100644
> >> >--- a/hw/pci/pci.c
> >> >+++ b/hw/pci/pci.c
> >> >@@ -1712,7 +1712,7 @@ static void pci_update_mappings(PCIDevice *d)
> >> >     pci_update_vga(d);
> >> > }
> >> >
> >> >-static inline int pci_irq_disabled(PCIDevice *d)
> >> >+int pci_irq_disabled(PCIDevice *d)
> >> > {
> >> >     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_=
DISABLE;
> >> > }
> >> >diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> >> >index d2f85b39f3..632708ba4d 100644
> >> >--- a/hw/s390x/virtio-ccw.c
> >> >+++ b/hw/s390x/virtio-ccw.c
> >> >@@ -936,11 +936,14 @@ static void virtio_ccw_vmstate_change(DeviceSta=
te *d, bool running)
> >> >     }
> >> > }
> >> >
> >> >-static bool virtio_ccw_query_guest_notifiers(DeviceState *d)
> >> >+static bool virtio_ccw_query_guest_notifiers(DeviceState *d, int n)
> >> > {
> >> >     CcwDevice *dev =3D CCW_DEVICE(d);
> >> >+    VirtioCcwDevice *vdev =3D VIRTIO_CCW_DEVICE(d);
> >> >+    VirtIODevice *virtio_dev =3D virtio_bus_get_device(&vdev->bus);
> >> >
> >> >-    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA=
);
> >> >+    return !!(dev->sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA=
)
> >> >+            && virtio_queue_vector(virtio_dev, n) !=3D VIRTIO_NO_VEC=
TOR;
> >> > }
> >> >
> >> > static int virtio_ccw_get_mappings(VirtioCcwDevice *dev)
> >> >diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> >index 4cae7c1664..2a9a839763 100644
> >> >--- a/hw/virtio/vhost.c
> >> >+++ b/hw/virtio/vhost.c
> >> >@@ -1341,8 +1341,7 @@ int vhost_virtqueue_start(struct vhost_dev *dev=
,
> >> >     }
> >> >
> >> >     if (k->query_guest_notifiers &&
> >> >-        k->query_guest_notifiers(qbus->parent) &&
> >> >-        virtio_queue_vector(vdev, idx) =3D=3D VIRTIO_NO_VECTOR) {
> >> >+        !k->query_guest_notifiers(qbus->parent, idx)) {
> >> >         file.fd =3D -1;
> >> >         r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> >> >         if (r) {
> >> >diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> >> >index 0fa8fe4955..d62e199489 100644
> >> >--- a/hw/virtio/virtio-pci.c
> >> >+++ b/hw/virtio/virtio-pci.c
> >> >@@ -1212,10 +1212,16 @@ static int virtio_pci_set_guest_notifier(Devi=
ceState *d, int n, bool assign,
> >> >     return 0;
> >> > }
> >> >
> >> >-static bool virtio_pci_query_guest_notifiers(DeviceState *d)
> >> >+static bool virtio_pci_query_guest_notifiers(DeviceState *d, int n)
> >> > {
> >> >     VirtIOPCIProxy *proxy =3D to_virtio_pci_proxy(d);
> >> >-    return msix_enabled(&proxy->pci_dev);
> >> >+    VirtIODevice *vdev =3D virtio_bus_get_device(&proxy->bus);
> >> >+
> >> >+    if (msix_enabled(&proxy->pci_dev)) {
> >> >+        return virtio_queue_vector(vdev, n) !=3D VIRTIO_NO_VECTOR;
> >>
> >> Why are we moving this check in every callback, can't we leave it as
> >> before in vhost.c and here return true?
> >>
> >> I mean here:
> >>      if (msix_enabled(&proxy->pci_dev)) {
> >>          return true;
> >>      } else {
> >>          return !pci_irq_disabled(&proxy->pci_dev);
> >>      }
> >>
> >> and leave vhost.c untouched.
> >>
> >
> >Thanks for the suggestion =E2=80=94 your approach indeed achieves the sa=
me
> >effect while keeping the interface unchanged.
> >However, I feel it might lead to some misunderstanding of the intended
> >semantics of query_guest_notifiers. My original intent was for this
> >callback to represent whether interrupts are actually in use by the
> >guest, and in that sense, checking whether the queue uses a vector is
> >part of that definition.
>
> Okay, but IMHO these should be 2 patches, one that fixes the problem you
> mentioned (to be backported to stable, so with the Fixes tag),
> minimizing the changes. And another patch where you change the
> semantics.
>
> >By splitting the logic =E2=80=94 checking msix_enabled and pci_irq_disab=
led
> >inside the bus callback, and virtio_queue_vector() separately in
> >vhost.c =E2=80=94 the semantic boundary becomes less clear. While it wor=
ks
> >logically, it can reduce readability =E2=80=94 particularly because the
> >virtio_queue_vector() check semantically belongs under the
> >msix_enabled() branch, and combining it with the pci_irq_disabled()
> >case (INTx) could make the logic less clear to future readers.
> >Additionally, the set_host_notifier_mr interface already includes an
> >int n parameter, so adding it to query_guest_notifiers is accepted.
>
> I'm not sure that delegating the call to virtio_queue_vector() to each
> bus is an improvement honestly. But we can discuss it on the patch.
>
> Thanks,
> Stefano
>

