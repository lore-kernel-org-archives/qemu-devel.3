Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26709EF06E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 04:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpIYf-0007xe-0t; Sun, 08 Feb 2026 23:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpIYa-0007xN-Np
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:07:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpIYY-00022T-8F
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 23:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770610044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjh+y1ecyveoofJnxzsjBDgdgusxQqADBoOtddOlNz8=;
 b=RDym+rx5Z+PbKMpu06MnZwb/slH7hvtL2xP7zM4+Rv7gkk881HUOQBTHPzzWey5YMYxFZT
 B0H5R+uf31xmwOpcp+4sQ/+7znNxRwSuHSId3AHD8pb4vAq6kMTQBOulImR+dv/FHjNOvg
 RvKkFLuVzciYcUE+RdCtgKr7TUmYkbA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-ie57CvMKMImlMEd5b4qrRA-1; Sun, 08 Feb 2026 23:07:23 -0500
X-MC-Unique: ie57CvMKMImlMEd5b4qrRA-1
X-Mimecast-MFC-AGG-ID: ie57CvMKMImlMEd5b4qrRA_1770610043
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-896ff58f17aso22204106d6.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 20:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770610043; cv=none;
 d=google.com; s=arc-20240605;
 b=klasHivjkgIhDMTPK6dL1re04a4UgiVnWgd0wq1vslwwXlW4JvsWmKKSECTvrSdPqp
 b2EZx2u94wQnEsXr6OjbN0w7BMmVwpT2zFuTqEXQfDOE33LPAnOHG2HBE2LIQicHwvz5
 15ZN0uVY31YGLX1a0YlmjaLygja51F5iPUer2vbJlfPTJXgR1JGqhLxsjUFOFTtZLiN8
 ZSuQOr2hfHUOcGGrYefvGi/V/zB6yeNlOdwWLOJhA07gb87mu+yMDQNd5bZJw3sDJNVn
 U9XlX5N97DEr2hB6pS9FOT+8zdCIo924IrS8xl10HBws+hN+l28M9pF+VjmbYdupJ6jo
 xQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fjh+y1ecyveoofJnxzsjBDgdgusxQqADBoOtddOlNz8=;
 fh=3rxxPA1WVDARFQoijw+9pLzZwFWcfhUE6kC0WUak5ig=;
 b=RpzbLtc8z3exby9ai/TPgaC0lTEeA93ADyWBUMmGKzESxtDSUlcwNm/NPtEolLZUJ0
 qefKxzxf70tLywUAQzkc4AbXOTpyN/Xal+hi54PT3RQss0e9QfF6DzwUUZAWn+hZR5QT
 3ZPIB5HQiEcwxiGA3WQSyeIHJqCX0Vl4qQGUHKmFYZAK01FKkOjmTAgqRUgSsIJxqsSP
 GM/mpq7vc3NUp+2DLVHlPitsQ2iLiO+B77qUNTqhMRdGNfF99plWAb8rvyOrWj8bsrx2
 r15vkxUWIO6SOAXXRK07VM3zNiq6T4erze8NeMiKVotZ2syQFp8vWVysBbsr+4WMpo1C
 LSJw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770610043; x=1771214843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjh+y1ecyveoofJnxzsjBDgdgusxQqADBoOtddOlNz8=;
 b=edOFyaIW17c5pI7MLMNWx9HEcavb0LEb+Um7QXDYVxGEUMpeREfTbmcqNdVdNTW3NH
 c7yIievkxzDw6QF9IvX183zGqSggtb5FQ58k4mk83HsKRtrnAPdvuYUEylrxiJEVCGDI
 rR1uINR5/CIhkuXEBP84wEWKArTWDL/92ThEQzIn6s/ZOqse4y+cm8+9GhhquU5QJ1Yp
 HWy6A3GrnGp+EWUqa8CfNyDK/BvT5C6hr3NHNEyWqenOzuySYMRdSjCzO2HSaON9QS0U
 Xtcou4I/Dvi/1paetnVWVxD9p8VsqH6HELPwii2vVzglCP2RDXKQ25SviUQimU2VvUxv
 Cljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770610043; x=1771214843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fjh+y1ecyveoofJnxzsjBDgdgusxQqADBoOtddOlNz8=;
 b=q7ETHxQMEZCSb5ASTztTIlw3Qb2lpb6hcrlxMNSRt7V7wDP/N+oW9A/GHINhZDT4CV
 AOLFCYTTCLnELLWP0Kf59a5xlsHMd0a9fXZCsbvytwj6yzcaAoT1QcKf7vp/bX8MJ2YI
 Jy6EkW1yy9EjtGwkNPiwewlIv1cVttC8EE/buNH3XgkYbBOS2Mjj8Fs/DUIBiLRsnJHd
 Moc0x/FVLjNen76PiA+bynOl4VIXun5L/DewxPWqDpHAyfJfFfrWoXBl67nScA6VL8kG
 BDhZk6SAkhtAK//7Yj4PvBA9JKpMXQS2g0bBPx+H3WJbgkFVsu164GWqhPboVDZFDg+w
 VgZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwzc5HIQJhvmCPMSJcEhZihZQwOhX9eXgMgJxNdbRWnpbGVIq1vqVQx+Mt+kiVyi5cAiBuMARTDMof@nongnu.org
X-Gm-Message-State: AOJu0YzxK+oIpJFaO/itbrv0eQuacaDvvlyhQxOYgP6LCXX7H43OGyhG
 cLJ9qSGL4S/CXAM/+im36SxkVr0oS5v8d1iuEbiM2fGgllvV973jHRWism39oQJ9XpMGEgEwGt2
 G5GqDSU6TSqQlvO+5VZion8BGKzlGpCzkK32BAG+g4KUJZF5WR42QnGFk3yZiRMi12rQpQHwaNC
 w8FvFQWKZbIBw22D50N6OhsLfhycqYf7uU4y2NtNrPLQ==
X-Gm-Gg: AZuq6aLyjMyG/TF5T4b8OZt4hUJMMdGlTFNDHI/J98j6wxGJcDL652OCliMrJ3tvSkZ
 E+i2+QIczJBoe/dTvokJWdUne7wUj0jGmco3zNrcWlsa+S8WeDwGFiPJcKQDAcR2C65uvC/qGcc
 mPeDb3BRWF0XuNNB7SFNnSdjIE9+ZgpwFxjcWUYLgClo3IjGnWi08O2Cnik4aK3i7/B7bvTbPV7
 tXkMOWcBYMcpOGCzpQyaw3T8ZAZ
X-Received: by 2002:a05:6214:2466:b0:896:fc72:f92 with SMTP id
 6a1803df08f44-896fc7214cdmr41826616d6.67.1770610042679; 
 Sun, 08 Feb 2026 20:07:22 -0800 (PST)
X-Received: by 2002:a05:6214:2466:b0:896:fc72:f92 with SMTP id
 6a1803df08f44-896fc7214cdmr41826386d6.67.1770610042274; Sun, 08 Feb 2026
 20:07:22 -0800 (PST)
MIME-Version: 1.0
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
 <CAK3XEhOet2pFNT2PLOHuBZFNAbXtYq3Hghr0XNvd4FKyPPX7bw@mail.gmail.com>
 <76421356-de3a-4941-bd4d-7c362fbb228f@redhat.com>
In-Reply-To: <76421356-de3a-4941-bd4d-7c362fbb228f@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 9 Feb 2026 09:37:11 +0530
X-Gm-Features: AZwV_QjUBH2rRKXs2GlLHorTl6np4jcxUvtzYNwfFzR6dqTqYYrYuS0bQIesFN8
Message-ID: <CAK3XEhN6gbALmc4xewbh0FmsaZzwOzd1gYnP96WtfYfyD0g_pA@mail.gmail.com>
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

On Mon, Feb 9, 2026 at 3:38=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> On 2/8/26 15:39, Ani Sinha wrote:
> > On Tue, Jan 27, 2026 at 10:47=E2=80=AFAM Ani Sinha <anisinha@redhat.com=
> wrote:
> >>
> >> Normally the vfio pseudo device file descriptor lives for the life of =
the VM.
> >> However, when the kvm VM file descriptor changes, a new file descripto=
r
> >> for the pseudo device needs to be generated against the new kvm VM des=
criptor.
> >> Other existing vfio descriptors needs to be reattached to the new pseu=
do device
> >> descriptor. This change performs the above steps.
> >
> > I have not been able to test this change. Can someone suggest a way to
> > add a functional test and/or test this manually?
>
> Automated VFIO testing [*] is tough because it depends on a "real"
> physical PCI device.
>
> I have tested you series using a sev-snp guest with an assigned device
> (SATA controller) and verified that the guest could reboot. The SATA
> controller has no disks connected, so further testing is required.
>
> However, a 'system_reset' command issued from the QEMU monitor leaves
> the guest hanging. May be this is expected ?

I do not think so. On non-coco, I just tried it and it reboots fine
with x-change-vmfd-on-reset turned on.
I tried a RHEL 10 guest image as well as a simple UKI kernel.
Maybe there is some bug in this patch, not sure. In QEMU the code path
should be the same for both.

>
>
> > Otherwise I am going to add a comment in the next spin up that this
> > change is not tested.
>
> I will provide some more comments on the code. Please give me a day
> or two before resending.

Sure, please take all the time you need.

>
> Thanks,
>
> C.
>
> [*] One way to address this constraint for VFIO testing would be
>      to run the test in a nested environment using emulated devices,
>      like IGB, attached to an L1 which would be assigned to an L2.
>      But that's unrelated to this series.
> >
> >>
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >>   hw/vfio/helpers.c | 86 +++++++++++++++++++++++++++++++++++++++++++++=
--
> >>   1 file changed, 83 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> >> index f68f8165d0..d467875b4b 100644
> >> --- a/hw/vfio/helpers.c
> >> +++ b/hw/vfio/helpers.c
> >> @@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_t=
ype1_info *info,
> >>   #ifdef CONFIG_KVM
> >>   /*
> >>    * We have a single VFIO pseudo device per KVM VM.  Once created it =
lives
> >> - * for the life of the VM.  Closing the file descriptor only drops ou=
r
> >> - * reference to it and the device's reference to kvm.  Therefore once
> >> - * initialized, this file descriptor is only released on QEMU exit an=
d
> >> + * for the life of the VM except when the vm file descriptor changes =
for
> >> + * confidential virtual machines. In that case, the old file descript=
or is
> >> + * closed and a new file descriptor is recreated.  Closing the file d=
escriptor
> >> + * only drops our reference to it and the device's reference to kvm.
> >> + * Therefore once initialized, this file descriptor is normally only =
released
> >> + * on QEMU exit (except for confidential VMs as stated above) and
> >>    * we'll re-use it should another vfio device be attached before the=
n.
> >>    */
> >>   int vfio_kvm_device_fd =3D -1;
> >> +
> >> +typedef struct KVMVfioFileFd {
> >> +    int fd;
> >> +    QLIST_ENTRY(KVMVfioFileFd) node;
> >> +} KVMVfioFileFd;
> >> +
> >> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =3D
> >> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
> >> +
> >> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void =
*data,
> >> +                                  Error **errp);
> >> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier =3D {
> >> +    .notify =3D kvm_vfio_filefd_rebind,
> >> +};
> >> +
> >> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void =
*data,
> >> +                                  Error **errp)
> >> +{
> >> +    KVMVfioFileFd *file_fd;
> >> +    int ret =3D 0;
> >> +    struct kvm_device_attr attr =3D {
> >> +        .group =3D KVM_DEV_VFIO_FILE,
> >> +        .attr =3D KVM_DEV_VFIO_FILE_ADD,
> >> +    };
> >> +    struct kvm_create_device cd =3D {
> >> +        .type =3D KVM_DEV_TYPE_VFIO,
> >> +    };
> >> +
> >> +    /* we are not interested in pre vmfd change notification */
> >> +    if (((VmfdChangeNotifier *)data)->pre) {
> >> +        return 0;
> >> +    }
> >> +
> >> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
> >> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO devi=
ce");
> >> +        return -errno;
> >> +    }
> >> +
> >> +    if (vfio_kvm_device_fd) {
> >> +        close(vfio_kvm_device_fd);
> >> +    }
> >> +
> >> +    vfio_kvm_device_fd =3D cd.fd;
> >> +
> >> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> >> +        attr.addr =3D (uint64_t)(unsigned long)&file_fd->fd;
> >> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> >> +            error_setg_errno(errp, errno,
> >> +                             "Failed to add fd %d to KVM VFIO device"=
,
> >> +                             file_fd->fd);
> >> +            ret =3D -errno;
> >> +        }
> >> +    }
> >> +    return ret;
> >> +}
> >> +
> >>   #endif
> >>
> >>   void vfio_kvm_device_close(void)
> >> @@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
> >>           .attr =3D KVM_DEV_VFIO_FILE_ADD,
> >>           .addr =3D (uint64_t)(unsigned long)&fd,
> >>       };
> >> +    KVMVfioFileFd *file_fd;
> >>
> >>       if (!kvm_enabled()) {
> >>           return 0;
> >> @@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
> >>           }
> >>
> >>           vfio_kvm_device_fd =3D cd.fd;
> >> +        /*
> >> +         * If the vm file descriptor changes, add a notifier so that =
we can
> >> +         * re-create the vfio_kvm_device_fd.
> >> +         */
> >> +        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
> >>       }
> >>
> >>       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> >> @@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
> >>                            fd);
> >>           return -errno;
> >>       }
> >> +
> >> +    file_fd =3D g_malloc0(sizeof(*file_fd));
> >> +    file_fd->fd =3D fd;
> >> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
> >> +
> >>   #endif
> >>       return 0;
> >>   }
> >> @@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
> >>           .attr =3D KVM_DEV_VFIO_FILE_DEL,
> >>           .addr =3D (uint64_t)(unsigned long)&fd,
> >>       };
> >> +    KVMVfioFileFd *file_fd;
> >>
> >>       if (vfio_kvm_device_fd < 0) {
> >>           error_setg(errp, "KVM VFIO device isn't created yet");
> >> @@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
> >>                            "Failed to remove fd %d from KVM VFIO devic=
e", fd);
> >>           return -errno;
> >>       }
> >> +
> >> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
> >> +        if (file_fd->fd =3D=3D fd) {
> >> +            QLIST_REMOVE(file_fd, node);
> >> +            g_free(file_fd);
> >> +            break;
> >> +        }
> >> +    }
> >> +
> >>   #endif
> >>       return 0;
> >>   }
> >> --
> >> 2.42.0
> >>
> >
>


