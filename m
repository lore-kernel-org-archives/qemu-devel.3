Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C0FFD5309
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsHB-0006g3-FM; Fri, 27 Feb 2026 02:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvsH5-0006fV-Qm
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:28:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vvsH2-0004rv-6n
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772177309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNHrD9BMCM2KOuGIfSf3eU3LV+uLotVmAXakyskUl1g=;
 b=NIX0QBBhoDFJvFp7t/Dxx8tVXzSSDvQVVoF4PXZDYk7eLlrAGDZ6Uay3DpVsoq8N0LnAdZ
 2TGh9zvTX93B44CHpGjnSx+Pv/wm2N04/ii2lVD4F1GgXYz0rK5kaMimLILKOSThODGoLi
 EGfipJ2KILLhUD8SCESURdCOH+5j624=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-JdS460R_P4eNGvWaJpqQpA-1; Fri, 27 Feb 2026 02:28:27 -0500
X-MC-Unique: JdS460R_P4eNGvWaJpqQpA-1
X-Mimecast-MFC-AGG-ID: JdS460R_P4eNGvWaJpqQpA_1772177306
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aae146bab0so26849595ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 23:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772177306; x=1772782106; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNHrD9BMCM2KOuGIfSf3eU3LV+uLotVmAXakyskUl1g=;
 b=t21dN0JnB1vgYY0GiYoH6Ojokqd0CZU0lGpcPg83HUMJaQCutaUZ15rxjMKwfmPHRb
 2kTObi1KJbeKGl8d3EMv0Qvjq4cR06tsu7n0kIDxORlV49RqmiHOjjhmjm5kcvTp91IS
 rV/rzxpjrDzHokVtp60aCxFWEHCrbBeALFpGRsowZa7lp8IzCgz7ymZux7Mh/xoEIdqo
 mcsMOdoDKTuAOzp6jkOwBUBQPcwKJ2IBe286iXAqnB/cH8qJ/pNaFrmlR4tAkfCJIuk1
 +Owysf2I9J0xWyoRD7EmwSxUhmlzVCOPyYirD96tPSU+ON/Kx6aEw22b7w+xwgD3z9CT
 zQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772177306; x=1772782106;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BNHrD9BMCM2KOuGIfSf3eU3LV+uLotVmAXakyskUl1g=;
 b=qUBVHZ8YzEPojEJJ9tFHbGsP+bGAVSAq+GrsVMOOipDcfKB7ATOdFl9TbubobkK1JO
 453rumT0KiYq+8btFn7ID/8J0PbFBr9r24hX4pIVSzNAkSowg0tTyAdXimN0u8X56QH+
 7sSjeD/2+yDOtuvjd4Z6dqaSniifXcCY2bCjS/5rY5X22AGJEqVlhfiFuOJWFom+VPvh
 FeUE3xZrVODGdNqA8wUl0DV1vuhw1l5az54ufqPLNWL8qChWsjnKpgq2h4hLo47n0v8c
 mRdxLO7v48RgC6DPO3IR7ZOSEF+Q5GzRKPmpeGpXKviicmybfiZtPNXeOm0O92i1LjyM
 34gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZyJmr+mc0DYwlkqRA6R1bRnW79rB7UmawBSKKWtAqIZs4iPhyHlgOSYWhxGmiHkwX4qDgaoRuYKPj@nongnu.org
X-Gm-Message-State: AOJu0YysNN8+CUs14FLnxz4UxuSByqJJGbSQJyqBHG1BhdUEM6gxf+s2
 40blUUX4N3M+6Z0Rfb2uyvDp5yXqch4eaocxA5xtiEw/9zzFezrqs/16oVrilwIZAUdzanRdRz3
 e2Uh/xeRvLig3Yk7WVJrVZ7BElRdtOwGW6g7A9XdfTXP1bm1GTPNlaYF0
X-Gm-Gg: ATEYQzwATKQZPY6rHPNterZIQ6Xna5h3jlAMSh6ds0HPFuuDzi6ypUxK3wIKlvU/Czm
 3vVY94DHYb9b9NBeygOmAU67isWR2qbdywWcky32WJ45//Wna7N5fryyRiL8edeIFAQ/6mbxRda
 R7gdUDYTe9liDBnjefvxsKKD6mw+MyLG7/t/xUzHhpwY26cWqlr/oEIXUKoPaLUqn+Sc/aaP78U
 9YwoWwJbYFB/59oHE4wmx/KkgfcBmiBEPAPflp84wZHDfGb2Su/fCYSTZDaCd8S/rQLMsrOGxmq
 cXGZAgmL2hqd5fprzTKAHNrabdzMl0NLr+bow6lmt/lmj226/Ppuwt7s4LPInqRSWvBoWab+wQw
 l4Fh01JqUgJHIlydySymT+NyUglLaee+Wm/C+DTg9w2sgnuU9BsO+gSdUIEFVX9J7WVayHg==
X-Received: by 2002:a17:90b:3dcf:b0:356:21ff:623f with SMTP id
 98e67ed59e1d1-35965cad9a4mr1472639a91.22.1772177306495; 
 Thu, 26 Feb 2026 23:28:26 -0800 (PST)
X-Received: by 2002:a17:90b:3dcf:b0:356:21ff:623f with SMTP id
 98e67ed59e1d1-35965cad9a4mr1472631a91.22.1772177306114; 
 Thu, 26 Feb 2026 23:28:26 -0800 (PST)
Received: from smtpclient.apple ([122.176.129.56])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3593dcad237sm4592205a91.3.2026.02.26.23.28.23
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Feb 2026 23:28:25 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v6 23/35] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <7d74271f-0562-4a2d-92f8-f25854d82971@redhat.com>
Date: Fri, 27 Feb 2026 12:58:11 +0530
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <ani@anisinha.ca>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A4F0EC7-3CD8-4ECE-BDC9-9D08AB946369@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-24-anisinha@redhat.com>
 <7d74271f-0562-4a2d-92f8-f25854d82971@redhat.com>
To: Cedric Le Goater <clg@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
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



> On 27 Feb 2026, at 12:32=E2=80=AFPM, C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>=20
> On 2/25/26 04:49, Ani Sinha wrote:
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
>> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
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
>=20
> In case you resend, may be change this part to return -errno at first
> error. Seems best.
>=20
>> +        }
>> +    }
>> +    return ret;
>=20
> And return 0 here. Which means 'ret' is now unused.

Yes good idea. I have just sent a v7 for this patch only which I see you =
have already seen.


>=20
> Thanks,
>=20
> C.
>=20
>=20
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


