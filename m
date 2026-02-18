Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984A4E9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 17:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vslRC-0002mE-2b; Wed, 18 Feb 2026 12:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vslRA-0002m0-5P
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:34:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vslR6-0000Nl-09
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 12:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771436042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVBeXeeSNXXQOw4dXi+NZiCbSPLaUXvMZHFZdhVxegs=;
 b=X2KkHwARnAP+VnUbc4Y129VEzxOJSPFvXhXUzy9Ql/eJOGlI8LVQaVGoef0S0LLO1jTAIj
 i8a10LKX8aFZde9Ca3Cvx0Yvuqjc0ZU9rKEvYuUiww1OV84AxfmxOo/ujk6GWDv4te7m19
 njBu6yuG876kuZv9ZysbfQVYq3GOEQY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-M7N5LRmsNISnzDzd7-pVIw-1; Wed, 18 Feb 2026 12:34:00 -0500
X-MC-Unique: M7N5LRmsNISnzDzd7-pVIw-1
X-Mimecast-MFC-AGG-ID: M7N5LRmsNISnzDzd7-pVIw_1771436040
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-896f50f008eso4912226d6.0
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 09:34:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771436040; cv=none;
 d=google.com; s=arc-20240605;
 b=Ej4n2klntYBUUspuX4S5ZxcvivP1TBtEzbCNIoVEHbsPqLxzMyqkSXE09EvYm2RfTh
 SWArpv6UDUEQ5Uz5cDl9vXPOjzfZyY77x7mB03US+BekZ99XFN5PVrgptJ76VqvJBR1F
 uVKqCZrYdmFw95Zx0+xEPc1ZYzuQufhvk61hy4iaI33MA9o2kDfUJR78CVNIFPQfkSSy
 cSnl/SPAFVAVsitPvtZyfwX+Unjt5Aqh5vnrVQQ6u2zetJofy9D1K9oI6ODsi139CQN1
 2wseU+c7Jg+dH/Bx61JxcbuE0jhIN5mVaNQZmjRzNz40YVrKQdXOEeas0yF4ZjEM95dO
 3tHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uVBeXeeSNXXQOw4dXi+NZiCbSPLaUXvMZHFZdhVxegs=;
 fh=K9hDXqt75lcOezs+/G+xaAMwjOzFA0v0Zlzc/Y4scgk=;
 b=b4oziJnCvvypXuAzQ3Rtl3FWdOGqg1NmsD02nK+UMn+sCNsb3w5DO0TvBdHA5cybxY
 1JOWgZrzvVL0AjvAAmG2qLJR7TJggJ0ykLfI4H7b51nQQCVVgs5kXWM4WjHOIb2UPzTs
 DpzxsRgaXs2E0Mh0oEdPnauMlM7IGaAhpIFic5sQveIVpN4fxP/S4cIZH6V0Ej8dnJNx
 1HTTPm+eVSkiWtTqH37hpIWmIJX8k7G/9eNPRz9fsKo+VB9NKhT7jCHLzNs6nL5mBNiQ
 CBIOiSTCpZwSceOHh2eeOMqRqntlrJumr5HXgrePgHiTJZy09Dw3R7//4VuQcwcZrnuu
 3O3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771436040; x=1772040840; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVBeXeeSNXXQOw4dXi+NZiCbSPLaUXvMZHFZdhVxegs=;
 b=A4iaHWeiSjOUpKJzGdXk2/fPLb/FpSXJPYpE1xFNT/jbNYfIKrih4Gma0Lc/5APQPR
 HiRhA0V5vmd2TeqaJMpN9TA2Azonb2VzGERjp6yAVZfqPi9l40HAxZQiY7Raw+zD40hR
 iNE8CWQwLvEiIXCgwpNx7H1uoK7Rw3dGj8k2F29b1EDhH36JD2zlhk49qP1TB+5FCHXu
 aNn9xZZqE+b5PW68oeeYYDUN3Bh9q+441at3fiCjkCjlcUyyaUsopj13J9nL9HU5rI9Y
 BrO0OlN2wSo0FguUcs0fDGnaoxO4wviBQUBRuF9cj/aSQgRgBC6P4J4clwf84UYWiV8V
 wo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771436040; x=1772040840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uVBeXeeSNXXQOw4dXi+NZiCbSPLaUXvMZHFZdhVxegs=;
 b=HYaVvcZs0KsXkbeaDX6JU6H4lmVqAPijiTdnBm054HYUSqR+fQpdqggxqfmFTQyZFn
 6SE59Ju87efYthiA8tTeTLrpu5CdPkwqQucsj8O/W/8cGFtHleJvq1Mt6gtDpp//Cb9X
 uWhNGKSJd0ccrGlnUplMkUUj+uCbggH2qnauOZSFBSSos6xrRd+BCBBgdNGQSVGMwqrY
 DvnjNrfUDjlouvoq0c27PJaCsiBb2dgZLNW+KL09pNt/JdmOyG2/u8++vakD1nZ3y9g0
 h9MRo5DzwMCNK4rzRc9/7r42JqO59zsbmi8/3E6/HBHgw0ciPt65w9D/6qgVDRJ0clDJ
 CM5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWslcKL42QKPCx/cj5YIzhW78LKe4qgafKdGSDeEqMuuhqYZ0KCFieSmyKGfrNll45yOqKGIuMkyaq@nongnu.org
X-Gm-Message-State: AOJu0YyFTJcZ3LCTkpFAxrbkU0FyHOAjk6968PXS9g7IGZuVeEx6jRBg
 t7CpxwB6WIENtTzCkj9n7surjqif8bgGU0226MnA0xefiT5XdGzOzkDc9miGTNO5GT49Vx5qXgV
 q2/CeDlCHeeDDZQmXXwMMA4DwKyrl9aCIGWzfxgLv7+ixQZ1YYv8VGhlg3tR9nPTszQuAJ8TRBl
 q6+/dxxsaxRiakoQ2xAoMhvvVZkZ5elJs=
X-Gm-Gg: AZuq6aKg847cKmZcUtwY/UGkljnPREvFod7boCCHKO2ObQUz83Nr09FU5hutYC0dzEz
 Y5WnHTq8UqS/AJCBaEr5OcvkVY9Oe5uo8zvV7/X6vSGXjR8BasiO13H9ttFPOucWC4qkZuu8uCg
 wSMe9FINJPJLZLZLJ6zcov3wiWO6MeX2q3ETebF94K/ix0tS8eH+Sp5JrV4e4TmnFsi/hKByhEh
 1VEQ+Fol3RpjNV7vqBRSbWaAyJh1KaCF8ZbhlKaVfzGKxe4mLeYccCRhtj2OxOmQ9qzcg==
X-Received: by 2002:ad4:594a:0:b0:895:4b79:839c with SMTP id
 6a1803df08f44-89961fc138fmr3111016d6.7.1771436039646; 
 Wed, 18 Feb 2026 09:33:59 -0800 (PST)
X-Received: by 2002:ad4:594a:0:b0:895:4b79:839c with SMTP id
 6a1803df08f44-89961fc138fmr3110466d6.7.1771436039030; Wed, 18 Feb 2026
 09:33:59 -0800 (PST)
MIME-Version: 1.0
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
 <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
 <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
In-Reply-To: <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 18 Feb 2026 23:03:47 +0530
X-Gm-Features: AaiRm52lK2j6OL47iI0gYs536A5lsDYokcjncQJvlA9PwycL6NqwiWTrQtq64xQ
Message-ID: <CAK3XEhOFvXUEiO3z1MhGqjBQUH3hB_3u9suLpweBs9vaTr1zog@mail.gmail.com>
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 18, 2026 at 9:00=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> On 2/18/26 16:07, Ani Sinha wrote:
> >
> >
> >> On 18 Feb 2026, at 7:37=E2=80=AFPM, C=C3=A9dric Le Goater <clg@redhat.=
com> wrote:
> >>
> >> On 2/18/26 12:42, Ani Sinha wrote:
> >>> Normally the vfio pseudo device file descriptor lives for the life of=
 the VM.
> >>> However, when the kvm VM file descriptor changes, a new file descript=
or
> >>> for the pseudo device needs to be generated against the new kvm VM de=
scriptor.
> >>> Other existing vfio descriptors needs to be reattached to the new pse=
udo device
> >>> descriptor. This change performs the above steps.
> >>> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >>
> >> There is a regression since last version.
> >>
> >>
> >> 'reboot' from the guest and command 'system_reset' from the QEMU
> >> monitor now generate these outputs:
> >>
> >>   qemu-system-x86_64: info: virtual machine state has been rebuilt wit=
h new guest file handle.
> >>   qemu-system-x86_64: info: virtual machine state has been rebuilt wit=
h new guest file handle.
> >>   qemu-system-x86_64: info: virtual machine state has been rebuilt wit=
h new guest file handle.
> >>   ...
> >>
> >> and QEMU exits after a while.
> >
> > I have only seen this in SEV-ES with more than one vcpus. Never with TD=
X or SEV-SNP (single or multiple cpus).
> > On which host/guest type did you see this?
>
> SEV-SNP on a RHEL9 host. Same guest I used before and host says :
>
>    [1816531.409591] kvm_amd: SEV-ES guest requested termination: 0x0:0x0

Strange! I am not sure why KVM thinks it's SEV-ES. I have done all my
SEV-SNP and TDX testing on a fc43 host and for SEV-ES I used a fc42
host. I have not seen this kind of guest termination on SEV-SNP or TDX
on that host. I am sure there are some differences between the RHEL9
host kernel and fc43 kernel.

>
> Thanks,
>
> C.
>
>
>
> >
> >>
> >>
> >>
> >>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>
> >> Anyhow this patch looks good.
> >>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >>
> >> Thanks,
> >>
> >> C.
> >>
> >>> ---
> >>>   hw/vfio/helpers.c | 92 ++++++++++++++++++++++++++++++++++++++++++++=
+++
> >>>   1 file changed, 92 insertions(+)
> >>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
> >>> index f68f8165d0..e2bedd15ec 100644
> >>> --- a/hw/vfio/helpers.c
> >>> +++ b/hw/vfio/helpers.c
> >>> @@ -116,6 +116,89 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_t=
ype1_info *info,
> >>>    * we'll re-use it should another vfio device be attached before th=
en.
> >>>    */
> >>>   int vfio_kvm_device_fd =3D -1;
> >>> +
> >>> +/*
> >>> + * Confidential virtual machines:
> >>> + * During reset of confidential vms, the kvm vm file descriptor chan=
ges.
> >>> + * In this case, the old vfio kvm file descriptor is
> >>> + * closed and a new descriptor is created against the new kvm vm fil=
e
> >>> + * descriptor.
> >>> + */
> >>> +
> >>> +typedef struct VFIODeviceFd {
> >>> +    int fd;
> >>> +    QLIST_ENTRY(VFIODeviceFd) node;
> >>> +} VFIODeviceFd;
> >>> +
> >>> +static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =3D
> >>> +    QLIST_HEAD_INITIALIZER(vfio_device_fds);
> >>> +
> >>> +static void vfio_device_fd_list_add(int fd)
> >>> +{
> >>> +    VFIODeviceFd *file_fd;
> >>> +    file_fd =3D g_malloc0(sizeof(*file_fd));
> >>> +    file_fd->fd =3D fd;
> >>> +    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
> >>> +}
> >>> +
> >>> +static void vfio_device_fd_list_remove(int fd)
> >>> +{
> >>> +    VFIODeviceFd *file_fd, *next;
> >>> +
> >>> +    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
> >>> +        if (file_fd->fd =3D=3D fd) {
> >>> +            QLIST_REMOVE(file_fd, node);
> >>> +            g_free(file_fd);
> >>> +            break;
> >>> +        }
> >>> +    }
> >>> +}
> >>> +
> >>> +static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void =
*data,
> >>> +                                  Error **errp)
> >>> +{
> >>> +    VFIODeviceFd *file_fd;
> >>> +    int ret =3D 0;
> >>> +    struct kvm_device_attr attr =3D {
> >>> +        .group =3D KVM_DEV_VFIO_FILE,
> >>> +        .attr =3D KVM_DEV_VFIO_FILE_ADD,
> >>> +    };
> >>> +    struct kvm_create_device cd =3D {
> >>> +        .type =3D KVM_DEV_TYPE_VFIO,
> >>> +    };
> >>> +
> >>> +    /* we are not interested in pre vmfd change notification */
> >>> +    if (((VmfdChangeNotifier *)data)->pre) {
> >>> +        return 0;
> >>> +    }
> >>> +
> >>> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
> >>> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO dev=
ice");
> >>> +        return -errno;
> >>> +    }
> >>> +
> >>> +    if (vfio_kvm_device_fd !=3D -1) {
> >>> +        close(vfio_kvm_device_fd);
> >>> +    }
> >>> +
> >>> +    vfio_kvm_device_fd =3D cd.fd;
> >>> +
> >>> +    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
> >>> +        attr.addr =3D (uint64_t)(unsigned long)&file_fd->fd;
> >>> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> >>> +            error_setg_errno(errp, errno,
> >>> +                             "Failed to add fd %d to KVM VFIO device=
",
> >>> +                             file_fd->fd);
> >>> +            ret =3D -errno;
> >>> +        }
> >>> +    }
> >>> +    return ret;
> >>> +}
> >>> +
> >>> +static struct NotifierWithReturn vfio_vmfd_change_notifier =3D {
> >>> +    .notify =3D vfio_device_fd_rebind,
> >>> +};
> >>> +
> >>>   #endif
> >>>     void vfio_kvm_device_close(void)
> >>> @@ -153,6 +236,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
> >>>           }
> >>>             vfio_kvm_device_fd =3D cd.fd;
> >>> +        /*
> >>> +         * If the vm file descriptor changes, add a notifier so that=
 we can
> >>> +         * re-create the vfio_kvm_device_fd.
> >>> +         */
> >>> +        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
> >>>       }
> >>>         if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> >>> @@ -160,6 +248,8 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
> >>>                            fd);
> >>>           return -errno;
> >>>       }
> >>> +
> >>> +    vfio_device_fd_list_add(fd);
> >>>   #endif
> >>>       return 0;
> >>>   }
> >>> @@ -183,6 +273,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
> >>>                            "Failed to remove fd %d from KVM VFIO devi=
ce", fd);
> >>>           return -errno;
> >>>       }
> >>> +
> >>> +    vfio_device_fd_list_remove(fd);
> >>>   #endif
> >>>       return 0;
> >>>   }
> >>
> >
>


