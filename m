Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CB7E9A047
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 15:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsj9p-0001J4-E7; Wed, 18 Feb 2026 10:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsj9o-0001Iv-0o
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:08:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vsj9m-0002xD-9F
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771427280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M+YhQT0gbq1eXwaTS6GyWhwJJ0Tom4TMrt47Lob5H2o=;
 b=Gfrwp+sqq8nUu5PJlGMwpoINrWKEM2+ObLePpm/6VYTC1AccNyVDXChEGwvUbbjh8RXIP+
 4/GVEGOPS9J0h2Go3XRPd8kqOQud4wBDDeMu8pvoTJqTv3GHqDL+qyXb2D07CXPNoof96G
 YXob4OIAxSOR975ODSDp1pwZASmjMRo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-We8J0r77O2GQNkqGO3-rGQ-1; Wed, 18 Feb 2026 10:07:58 -0500
X-MC-Unique: We8J0r77O2GQNkqGO3-rGQ-1
X-Mimecast-MFC-AGG-ID: We8J0r77O2GQNkqGO3-rGQ_1771427278
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2aad5fc5b2fso58415765ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771427278; x=1772032078; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+YhQT0gbq1eXwaTS6GyWhwJJ0Tom4TMrt47Lob5H2o=;
 b=B1JE3O+EZ5JmygRUejrir8Mxda+4xQKzZkejomn+WZ5U02aY4h8fIybfoY1cIIKXj7
 VrKyBf+nh+qzbongViCXXH35ZDyDW4MvElJmneB8lSXwuCxJN3rvnMvwfZ48juoaSTHS
 evrgTsx/mSrz/H+FbriZskdQC2X6kf/BWWltTGJXPO//TwEE/oKQ+Xq1wnnxiTTGpLCQ
 hgWQuLbaKzcxGq6Pv3H+AYdZ5UEfV4pJxZdf64SJBRXRI3f8dHiIt3fe0eN0X6M147at
 50kik67nEx+KQDF5YEPLF9IhxmUe8LuU5A5BXsddyBNypuVuDcoQLtXDI6RjUNyMaBU0
 Qm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771427278; x=1772032078;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M+YhQT0gbq1eXwaTS6GyWhwJJ0Tom4TMrt47Lob5H2o=;
 b=HUmi9JxjncBLqFjvWi18WGWo0O9vDE1YL4Ht3pkLlpbijbVoaKZgaaA6W2WyTBdtUa
 w9uB6GKVnnFnMhp4brsaj+Spy544UMPgwR0uzH7pMBdWRXYOM+elvWorphPsCVmR0TPg
 lhARVqq39WXawQgwkbq+Ric+HlrdpBsQiUSUPY6mtrvre+Cnu6g/WpxMeoiOtBAxyFez
 sWKtN5TyM4JVKjhQzBZYzf28XsxCQ5a9hwMk56C904HMtX6exewypcgkT32oHarQutTe
 xp4ZBzdXqQ3XORsypY+K6SVb7BZVQJAQCKOv+X+ly5jU86K3S9wKsnQOhJsut+Tpr59V
 +wiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6M3J3IEwblri17/Ynxk1ObbuPJXGuq89R7SDzxL5Lv2rW0+q0PLNDc+GqqEWzEWeYJ3+n/Y+iepSm@nongnu.org
X-Gm-Message-State: AOJu0Yxu2Tejhjzz9f6I9UgjgnCJvgRfOdcFoecf8EB9hhH3/lRCU0Ym
 s/DT02yqY7D02QLMYrxCDCFAQFL4MJfLWsMI+z05QvToXSZNgl2pEzUpHeDEXarnSzVSR35572G
 0juCaJZgOcQuRl+u0iyyZe2lItNzsixroEi1m0zX0YUTD0qMkr8FOOqd2
X-Gm-Gg: AZuq6aLS6XfMZBfWjTaoXXyFAzWsu0z6+jozDVfz5D0lN+Kw8j6ZrydIGayhg9QxRGl
 J7rjp5/cmCLt6mLoo/DK9a61zJFF7j1tcyh8JOF/eIg6m8Q+2oWn4RPimLR0kvcRMJvEHSnb6FD
 uWH5Ds1N3SIz1nhjCXMjEaR10NGIOZYIwY/YfvOliHWpjhecdGdYnnJ/WLglm2AS7Ebj5fDixCR
 UksikYxU3hmCEWTew2AVSvSYXt5/5rVRpnn91qUhGZHo1hBC7h1nWMkkdHklb8EjSY8AeTA4FEk
 JcjUl7i0IdH/kAkko+l5y62YmlFKHD1Dgq1BEZnXspPIYpfR5lWeRev0Qk1n8EcSF9/+tYeTK4J
 yLVYm9jLKIPXky/moPiZ43hjl7m3+9jbkQuCxuciqMa3CRWdunKMMvRDGkViXKVEbsl4=
X-Received: by 2002:a17:903:8d0:b0:2a9:5c0b:e5dc with SMTP id
 d9443c01a7336-2ad50fd1e8cmr20506035ad.54.1771427277731; 
 Wed, 18 Feb 2026 07:07:57 -0800 (PST)
X-Received: by 2002:a17:903:8d0:b0:2a9:5c0b:e5dc with SMTP id
 d9443c01a7336-2ad50fd1e8cmr20505725ad.54.1771427277198; 
 Wed, 18 Feb 2026 07:07:57 -0800 (PST)
Received: from smtpclient.apple ([117.99.83.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1adef6e2sm133232505ad.2.2026.02.18.07.07.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Feb 2026 07:07:56 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
Date: Wed, 18 Feb 2026 20:37:42 +0530
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
To: Cedric Le Goater <clg@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 18 Feb 2026, at 7:37=E2=80=AFPM, C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>=20
> On 2/18/26 12:42, Ani Sinha wrote:
>> Normally the vfio pseudo device file descriptor lives for the life of =
the VM.
>> However, when the kvm VM file descriptor changes, a new file =
descriptor
>> for the pseudo device needs to be generated against the new kvm VM =
descriptor.
>> Other existing vfio descriptors needs to be reattached to the new =
pseudo device
>> descriptor. This change performs the above steps.
>> Tested-by: C=C3=A9dric Le Goater <clg@redhat.com>
>=20
> There is a regression since last version.
>=20
>=20
> 'reboot' from the guest and command 'system_reset' from the QEMU
> monitor now generate these outputs:
>=20
>  qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
>  qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
>  qemu-system-x86_64: info: virtual machine state has been rebuilt with =
new guest file handle.
>  ...
>=20
> and QEMU exits after a while.

I have only seen this in SEV-ES with more than one vcpus. Never with TDX =
or SEV-SNP (single or multiple cpus).
On which host/guest type did you see this?

>=20
>=20
>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>=20
> Anyhow this patch looks good.
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>=20
> Thanks,
>=20
> C.
>=20
>> ---
>>  hw/vfio/helpers.c | 92 =
+++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 92 insertions(+)
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index f68f8165d0..e2bedd15ec 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -116,6 +116,89 @@ bool vfio_get_info_dma_avail(struct =
vfio_iommu_type1_info *info,
>>   * we'll re-use it should another vfio device be attached before =
then.
>>   */
>>  int vfio_kvm_device_fd =3D -1;
>> +
>> +/*
>> + * Confidential virtual machines:
>> + * During reset of confidential vms, the kvm vm file descriptor =
changes.
>> + * In this case, the old vfio kvm file descriptor is
>> + * closed and a new descriptor is created against the new kvm vm =
file
>> + * descriptor.
>> + */
>> +
>> +typedef struct VFIODeviceFd {
>> +    int fd;
>> +    QLIST_ENTRY(VFIODeviceFd) node;
>> +} VFIODeviceFd;
>> +
>> +static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =3D
>> +    QLIST_HEAD_INITIALIZER(vfio_device_fds);
>> +
>> +static void vfio_device_fd_list_add(int fd)
>> +{
>> +    VFIODeviceFd *file_fd;
>> +    file_fd =3D g_malloc0(sizeof(*file_fd));
>> +    file_fd->fd =3D fd;
>> +    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
>> +}
>> +
>> +static void vfio_device_fd_list_remove(int fd)
>> +{
>> +    VFIODeviceFd *file_fd, *next;
>> +
>> +    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
>> +        if (file_fd->fd =3D=3D fd) {
>> +            QLIST_REMOVE(file_fd, node);
>> +            g_free(file_fd);
>> +            break;
>> +        }
>> +    }
>> +}
>> +
>> +static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void =
*data,
>> +                                  Error **errp)
>> +{
>> +    VFIODeviceFd *file_fd;
>> +    int ret =3D 0;
>> +    struct kvm_device_attr attr =3D {
>> +        .group =3D KVM_DEV_VFIO_FILE,
>> +        .attr =3D KVM_DEV_VFIO_FILE_ADD,
>> +    };
>> +    struct kvm_create_device cd =3D {
>> +        .type =3D KVM_DEV_TYPE_VFIO,
>> +    };
>> +
>> +    /* we are not interested in pre vmfd change notification */
>> +    if (((VmfdChangeNotifier *)data)->pre) {
>> +        return 0;
>> +    }
>> +
>> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
>> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO =
device");
>> +        return -errno;
>> +    }
>> +
>> +    if (vfio_kvm_device_fd !=3D -1) {
>> +        close(vfio_kvm_device_fd);
>> +    }
>> +
>> +    vfio_kvm_device_fd =3D cd.fd;
>> +
>> +    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
>> +        attr.addr =3D (uint64_t)(unsigned long)&file_fd->fd;
>> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> +            error_setg_errno(errp, errno,
>> +                             "Failed to add fd %d to KVM VFIO =
device",
>> +                             file_fd->fd);
>> +            ret =3D -errno;
>> +        }
>> +    }
>> +    return ret;
>> +}
>> +
>> +static struct NotifierWithReturn vfio_vmfd_change_notifier =3D {
>> +    .notify =3D vfio_device_fd_rebind,
>> +};
>> +
>>  #endif
>>    void vfio_kvm_device_close(void)
>> @@ -153,6 +236,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>          }
>>            vfio_kvm_device_fd =3D cd.fd;
>> +        /*
>> +         * If the vm file descriptor changes, add a notifier so that =
we can
>> +         * re-create the vfio_kvm_device_fd.
>> +         */
>> +        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
>>      }
>>        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> @@ -160,6 +248,8 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>                           fd);
>>          return -errno;
>>      }
>> +
>> +    vfio_device_fd_list_add(fd);
>>  #endif
>>      return 0;
>>  }
>> @@ -183,6 +273,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>>                           "Failed to remove fd %d from KVM VFIO =
device", fd);
>>          return -errno;
>>      }
>> +
>> +    vfio_device_fd_list_remove(fd);
>>  #endif
>>      return 0;
>>  }
>=20


