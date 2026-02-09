Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B38EF06EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 04:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpIcD-00006I-6E; Sun, 08 Feb 2026 23:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpIcA-00006A-Cb
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:11:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpIc7-0002fQ-0C
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770610265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tEetrUBlkB8Tn/lDMt0WCdb6EjSMaTHpUMEeYDremM8=;
 b=TMkY+HyqfxlY5ps2BFPoGaTaI20FN+xXHV7FgdxnrjXT1g1pN/0cwYMLWgouXBlaVtKl6j
 kd/lphHm8rOPhXFjb5AMMlBM/SBZAgKECSfgb9obNaGd0rpaOv+gZ8I4KSqZEQYBCCP661
 j/pGcSv4DdgMgCHZ5mPA74u9wvAt31g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-MBNX1zW7Pb6KyCoXkvTENg-1; Sun, 08 Feb 2026 23:11:04 -0500
X-MC-Unique: MBNX1zW7Pb6KyCoXkvTENg-1
X-Mimecast-MFC-AGG-ID: MBNX1zW7Pb6KyCoXkvTENg_1770610261
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-897021ebe91so12448316d6.0
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 20:11:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770610260; cv=none;
 d=google.com; s=arc-20240605;
 b=L0HT60Uxaagyu3Qug0oj4rb1Dp2fBiUUd9wQYv7HLvWCQ3i2ot7Q46JC2JkVxCln+L
 AhYQkRDT7WnG1iCXPltM4vh7zX8ynu8mO7wtdmULPVRUYeUTdJSuThSKp0ohcGXVFfYb
 gWVuikEVMmMyVUzzZx6Z5i085mDuTI/tA5i58qwkxhp7qzbvO3kxBvLWqkL4eybNr0bS
 59lsBdOKzXpXh/Y4J3twGpr6Xzg9EOqF9pVsqGS9ECyu0E9ZnCmui3vRpDDKZdx/fhGZ
 4zBTYqS0QeFC2PPuquqZrn/kUkA3Eog6WpIpnOXtvmBoXLOq98tGv4TEjvUiT419d5gB
 RWyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tEetrUBlkB8Tn/lDMt0WCdb6EjSMaTHpUMEeYDremM8=;
 fh=p8qSrC4zsYUxwIXZh1XNNWBsa1TF1m7y8PYuK0/UXi4=;
 b=lBGIWn7hKiihGhPzYyrHNlixN1xAKw1kQUQuU/OFNfRsRUu/hlw+ccX7Vh+nHDinZe
 FlQiL2JsumiQJXR3lGlkCaMMRnjJ2WsgiVjR5IFVK1PuySnip4F5Y+mw0JIhqhEh4COk
 cp1QAX3jkodYEovkupcTANTiBABHjuimB8JjyqVKCSW++wlJCcVwgVDRZ4LQz7/cM9Oj
 DYdZS3U+HVI1p+VaKVq/NhVE9Pgy9pD6+q9JAqbrb0xE8qufVKasD0nTxHl85qq/isOK
 moMj3yv7d7RbSAIPucWgrBnDSjiyTuWYQZ7m564kQJAAtTpOMUUHbjjKXWYPfbnjiSc+
 l/bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770610260; x=1771215060; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tEetrUBlkB8Tn/lDMt0WCdb6EjSMaTHpUMEeYDremM8=;
 b=TTDicekO301zrC9st3VagMhA95Y4+bQFIedInK8DJEe1oaX1GGLZGc4n4gIurAMF7o
 mVTovBOEPC+LXbf1Hpft3Rb/VAKeGVTH1/MvxkQIiS1hWqvoIdBVqv8BIdI0kUmO/QiZ
 5qzHobgKQ51tMaOLqQJDFwrFXzikoASn4w0qs9c62iDWlsdtChmdYfTjMg4AVO6/4hvi
 9714PyViN6SS8TUxZ3eq3MSo2Fm3J96wLDC7RuKG9HJoaoDiQtFabVmg0zQ5zUT0qoum
 JJ5W8rwMi+bTcCKuw6xE0WDg4hH2gCchxmg+ReWXkla0ON7l0BoOkXJvs2WG4FruLpto
 P0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770610260; x=1771215060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tEetrUBlkB8Tn/lDMt0WCdb6EjSMaTHpUMEeYDremM8=;
 b=iyR0xdX4WcISrZNM/d8IRx7v9VlJm80kLVyJ7iOgXrvoH4G1akAzdW+D7cl99d64V4
 JvUATAdNphW/nUWnOe6HbUwnDCIT3D9TkeBhskl0LhcnT3kGbZ5K3RNsUNQdlcYfueYa
 jqu1qoSbtafol/w6rGvHDVvhA4qci3oVu4f4iMzaFoc+6+ackH19SGe0xaW8MTBh4PhN
 DWT5OUhd3xqKpcTAt0bhY6F/zi+qXZCYlk1axpkQrOCBGieftqlaE+gJz3WPaub1cgBu
 b0RoC4c24WiECF3ET+2mQMxXfbuGNJsDBuF2dmLdh04J6RuducilalRd0XgYD7D/BnlG
 a4NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM2SLyX2ctZB02+aDf8YjE8b+TYc3Co2j/0OghjY8h8oQLFBGckSfj7IvaHqpVWKd6uqAsDSvOQocD@nongnu.org
X-Gm-Message-State: AOJu0YwyWGs3/f7SiEOn2Mj2oPlyOarA4ZBjOXyVFBPhtPKgjJHy/TaU
 i5G0qwhAKpZHu3B/4ZPRnI9+BygWy14W+E8OohwLS9y+N5EYRtWgrfxZfr8szxnfG+bOarIyR61
 E8l7qFT1OadqoPszjHxAwmDev4LtbUddYr8oTHn/4y4J/9TpfiRp0LzJ48X+Z/lMM0v6hffIbVl
 Nl8TQ8x8kxwZIDzaYCVnBr1ogcNfMPdfsJLveRDBo=
X-Gm-Gg: AZuq6aIwc6jE/QyAoe/i90nPxhZzsjq/GzG5xs9IdkSmXgTKCoqIiveeKuaCqiwCPMf
 Z7suaTOAJOVc2DRve27vaWjDxRKItFG+rkyxpCDDZugioqXdP2k5Ib1yYVScgkdsscbpxwSiJM/
 Mc5dEimC+PLiJyBee/brurX65RA7D0FpGwOTiqqHEGimi4MZoxuKpLg539RzQBJA2x4wDpWBojM
 ZZlkf29ct/1pjmGylv3DufLtXIS
X-Received: by 2002:ad4:5c89:0:b0:896:5114:200a with SMTP id
 6a1803df08f44-896511422famr70784526d6.8.1770610260554; 
 Sun, 08 Feb 2026 20:11:00 -0800 (PST)
X-Received: by 2002:ad4:5c89:0:b0:896:5114:200a with SMTP id
 6a1803df08f44-896511422famr70784376d6.8.1770610260213; Sun, 08 Feb 2026
 20:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
 <CAK3XEhOet2pFNT2PLOHuBZFNAbXtYq3Hghr0XNvd4FKyPPX7bw@mail.gmail.com>
 <76421356-de3a-4941-bd4d-7c362fbb228f@redhat.com>
 <CAK3XEhN6gbALmc4xewbh0FmsaZzwOzd1gYnP96WtfYfyD0g_pA@mail.gmail.com>
In-Reply-To: <CAK3XEhN6gbALmc4xewbh0FmsaZzwOzd1gYnP96WtfYfyD0g_pA@mail.gmail.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 9 Feb 2026 09:40:49 +0530
X-Gm-Features: AZwV_QiBQrjs1yOpz9ChK7_bWwIcMvllsuxYMDq6TgiEIWt6ICyyoP_8lzHMOYc
Message-ID: <CAK3XEhPmDsPePd-e16WNXh8U_FChdstWyije3XeruqGtM5O+AQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kraxel@redhat.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Feb 9, 2026 at 9:37=E2=80=AFAM Ani Sinha <anisinha@redhat.com> wrot=
e:
>
> On Mon, Feb 9, 2026 at 3:38=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.=
com> wrote:
> >
> > On 2/8/26 15:39, Ani Sinha wrote:
> > > On Tue, Jan 27, 2026 at 10:47=E2=80=AFAM Ani Sinha <anisinha@redhat.c=
om> wrote:
> > >>
> > >> Normally the vfio pseudo device file descriptor lives for the life o=
f the VM.
> > >> However, when the kvm VM file descriptor changes, a new file descrip=
tor
> > >> for the pseudo device needs to be generated against the new kvm VM d=
escriptor.
> > >> Other existing vfio descriptors needs to be reattached to the new ps=
eudo device
> > >> descriptor. This change performs the above steps.
> > >
> > > I have not been able to test this change. Can someone suggest a way t=
o
> > > add a functional test and/or test this manually?
> >
> > Automated VFIO testing [*] is tough because it depends on a "real"
> > physical PCI device.
> >
> > I have tested you series using a sev-snp guest with an assigned device
> > (SATA controller) and verified that the guest could reboot. The SATA
> > controller has no disks connected, so further testing is required.
> >
> > However, a 'system_reset' command issued from the QEMU monitor leaves
> > the guest hanging. May be this is expected ?
>
> I do not think so. On non-coco, I just tried it and it reboots fine
> with x-change-vmfd-on-reset turned on.

Please try this way on non-coco. If it works, then we need to assume
that for the CoCo case, some extra steps are needed during reset for
vfio which I missed.

> I tried a RHEL 10 guest image as well as a simple UKI kernel.
> Maybe there is some bug in this patch, not sure. In QEMU the code path
> should be the same for both.
>
> >
> >
> > > Otherwise I am going to add a comment in the next spin up that this
> > > change is not tested.
> >
> > I will provide some more comments on the code. Please give me a day
> > or two before resending.
>
> Sure, please take all the time you need.
>
> >
> > Thanks,
> >
> > C.
> >
> > [*] One way to address this constraint for VFIO testing would be
> >      to run the test in a nested environment using emulated devices,
> >      like IGB, attached to an L1 which would be assigned to an L2.
> >      But that's unrelated to this series.
> > >
> > >>
> > >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > >> ---
> > >>   hw/vfio/helpers.c | 86 +++++++++++++++++++++++++++++++++++++++++++=
++--
> > >>   1 file changed, 83 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> > >> index f68f8165d0..d467875b4b 100644
> > >> --- a/hw/vfio/helpers.c
> > >> +++ b/hw/vfio/helpers.c
> > >> @@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct vfio_iommu=
_type1_info *info,
> > >>   #ifdef CONFIG_KVM
> > >>   /*
> > >>    * We have a single VFIO pseudo device per KVM VM.  Once created i=
t lives
> > >> - * for the life of the VM.  Closing the file descriptor only drops =
our
> > >> - * reference to it and the device's reference to kvm.  Therefore on=
ce
> > >> - * initialized, this file descriptor is only released on QEMU exit =
and
> > >> + * for the life of the VM except when the vm file descriptor change=
s for
> > >> + * confidential virtual machines. In that case, the old file descri=
ptor is
> > >> + * closed and a new file descriptor is recreated.  Closing the file=
 descriptor
> > >> + * only drops our reference to it and the device's reference to kvm=
.
> > >> + * Therefore once initialized, this file descriptor is normally onl=
y released
> > >> + * on QEMU exit (except for confidential VMs as stated above) and
> > >>    * we'll re-use it should another vfio device be attached before t=
hen.
> > >>    */
> > >>   int vfio_kvm_device_fd =3D -1;
> > >> +
> > >> +typedef struct KVMVfioFileFd {
> > >> +    int fd;
> > >> +    QLIST_ENTRY(KVMVfioFileFd) node;
> > >> +} KVMVfioFileFd;
> > >> +
> > >> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =3D
> > >> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
> > >> +
> > >> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, voi=
d *data,
> > >> +                                  Error **errp);
> > >> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier =3D =
{
> > >> +    .notify =3D kvm_vfio_filefd_rebind,
> > >> +};
> > >> +
> > >> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, voi=
d *data,
> > >> +                                  Error **errp)
> > >> +{
> > >> +    KVMVfioFileFd *file_fd;
> > >> +    int ret =3D 0;
> > >> +    struct kvm_device_attr attr =3D {
> > >> +        .group =3D KVM_DEV_VFIO_FILE,
> > >> +        .attr =3D KVM_DEV_VFIO_FILE_ADD,
> > >> +    };
> > >> +    struct kvm_create_device cd =3D {
> > >> +        .type =3D KVM_DEV_TYPE_VFIO,
> > >> +    };
> > >> +
> > >> +    /* we are not interested in pre vmfd change notification */
> > >> +    if (((VmfdChangeNotifier *)data)->pre) {
> > >> +        return 0;
> > >> +    }
> > >> +
> > >> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
> > >> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO de=
vice");
> > >> +        return -errno;
> > >> +    }
> > >> +
> > >> +    if (vfio_kvm_device_fd) {
> > >> +        close(vfio_kvm_device_fd);
> > >> +    }
> > >> +
> > >> +    vfio_kvm_device_fd =3D cd.fd;
> > >> +
> > >> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> > >> +        attr.addr =3D (uint64_t)(unsigned long)&file_fd->fd;
> > >> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) =
{
> > >> +            error_setg_errno(errp, errno,
> > >> +                             "Failed to add fd %d to KVM VFIO devic=
e",
> > >> +                             file_fd->fd);
> > >> +            ret =3D -errno;
> > >> +        }
> > >> +    }
> > >> +    return ret;
> > >> +}
> > >> +
> > >>   #endif
> > >>
> > >>   void vfio_kvm_device_close(void)
> > >> @@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
> > >>           .attr =3D KVM_DEV_VFIO_FILE_ADD,
> > >>           .addr =3D (uint64_t)(unsigned long)&fd,
> > >>       };
> > >> +    KVMVfioFileFd *file_fd;
> > >>
> > >>       if (!kvm_enabled()) {
> > >>           return 0;
> > >> @@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp=
)
> > >>           }
> > >>
> > >>           vfio_kvm_device_fd =3D cd.fd;
> > >> +        /*
> > >> +         * If the vm file descriptor changes, add a notifier so tha=
t we can
> > >> +         * re-create the vfio_kvm_device_fd.
> > >> +         */
> > >> +        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier=
);
> > >>       }
> > >>
> > >>       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> > >> @@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp=
)
> > >>                            fd);
> > >>           return -errno;
> > >>       }
> > >> +
> > >> +    file_fd =3D g_malloc0(sizeof(*file_fd));
> > >> +    file_fd->fd =3D fd;
> > >> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
> > >> +
> > >>   #endif
> > >>       return 0;
> > >>   }
> > >> @@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
> > >>           .attr =3D KVM_DEV_VFIO_FILE_DEL,
> > >>           .addr =3D (uint64_t)(unsigned long)&fd,
> > >>       };
> > >> +    KVMVfioFileFd *file_fd;
> > >>
> > >>       if (vfio_kvm_device_fd < 0) {
> > >>           error_setg(errp, "KVM VFIO device isn't created yet");
> > >> @@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp=
)
> > >>                            "Failed to remove fd %d from KVM VFIO dev=
ice", fd);
> > >>           return -errno;
> > >>       }
> > >> +
> > >> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> > >> +        if (file_fd->fd =3D=3D fd) {
> > >> +            QLIST_REMOVE(file_fd, node);
> > >> +            g_free(file_fd);
> > >> +            break;
> > >> +        }
> > >> +    }
> > >> +
> > >>   #endif
> > >>       return 0;
> > >>   }
> > >> --
> > >> 2.42.0
> > >>
> > >
> >


