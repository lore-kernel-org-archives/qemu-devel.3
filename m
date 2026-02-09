Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0982BEE20BD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 08:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpMVm-0007r2-Da; Mon, 09 Feb 2026 03:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpMVc-0007qV-7f
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:20:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpMVa-0003RO-6l
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 03:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770625236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2tj37+zWtlUvsymJAzKAOZD4uyurQbHW9wAllGRNydU=;
 b=WkdHK7jjns7d6mJoyr4p9I7V/Fe1nLrplasbb7uF0+MLkFCziZMB2g4simtZjGz4ulpJvI
 XQbuSJ+Vd7yA0g1RDZsFyi5bjC/UmJmNuj8/huZf4noHbkr2aTr6GmGLQEYjITCA81bhC2
 rKhMu6xI7RHoVz2+eMliIzQTsgoJliw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-dtOiOJ-4MXifBOBstDrvnA-1; Mon, 09 Feb 2026 03:20:34 -0500
X-MC-Unique: dtOiOJ-4MXifBOBstDrvnA-1
X-Mimecast-MFC-AGG-ID: dtOiOJ-4MXifBOBstDrvnA_1770625234
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-353c9d644b0so2111563a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 00:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770625233; x=1771230033; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tj37+zWtlUvsymJAzKAOZD4uyurQbHW9wAllGRNydU=;
 b=PqV0WFQx1fNKbbYIhfE/CHqoeRhC7l0SBaCFFW4B7lRQrqBPfDV0MXrJcjd8YZU8Nq
 kW3zl59wTuIM2HooRRsIeLyPjDi0tyJGXgSnB+1eJ3KTUzw7+zj8TlvVbf4z+cHuQmN4
 HaxdCVqsPva9aVuDeRwDL9WBUeIUXWtQ7/y51chtOWp//bSHz10USy7CftklDKrVhw/z
 mnKw5IygtopVMJBGi9y+V7UmFfCgZyewjwsM2eaep0MxeJvaSp/kAsQulX78YUkUJc/I
 /vETAGpYyziGJKKZJ10B040beIIkNvcNvLptJwUwx8TxHeZZDcpuwnzrocp+a1dYSo/R
 ronw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770625233; x=1771230033;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2tj37+zWtlUvsymJAzKAOZD4uyurQbHW9wAllGRNydU=;
 b=TpQOwKw3FD5xXuNkLig3uANCxWhURCB591obO2ZA6wzBO5ZVNj7dfQ3lnQ07kJofCV
 JslnwVMEJ1/1o4FhOKFC1rb2YiPBsVg27EtHVDdkto2IjbJ4zd3CL2vWBCsM4lTwMSrc
 Le0vy9rCOX8d/Z2etYbO/TgtKLXhvahJHiwY1nLQY7d8t2p/ZRSKeEprxM9co+qfT2qn
 +PZYjisYi48diZjE0RKo6kNKs6z3t6LW6Wa/Ch5T4yFmWyIElQX6Bhx4fjoL8xYELOYu
 7peS13SbF1+iWfX51uNt7Low5DP3gVfECDmYYdcgIfTgoH2Rp4fi5gQw6sD3QMIplKEY
 KwkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXFr1hL0A8JKCCzlve31JTpSzzlZdZyxopYRa4PzY9zs8NJMxngHCsQLpSzCUfnwxRJRHcCTmt9HLt@nongnu.org
X-Gm-Message-State: AOJu0YxZ4gF95YZPlpKmFNfQOssY1+FykaGLUjszCjjV+90QuTV7vgQ1
 J+LPr9pUzykv/1dyV2Diw1/vtHNbkAyLKsIQsR8Yj9jnI/7G2cgQ6P4RUA1N2zIUxtdutcWPI04
 0YUkhjULnZJWmczftl/PiC2n3XCxXhIzFf7evAA1E8Q5DkXiYCiF3I1uh21TV/8pb
X-Gm-Gg: AZuq6aLJA+FHPEk6zB1K7x0wYff6XQb0dJ6QFswuVJ/3gCwnWiVyGaiNpoUiSHsZDua
 aTnYizM2FaN0bpb7UEpEwGVcsCeD7cIDT2TIInkEnz7DUfRWFgIiN/2F3ACR/wCD2B4uw62JX0K
 BIxC80NLuIg1uPCCDoucUSWgYJHWbB2l8Vpccgp4g7ri9Mb7J8sgZorqOl133VQ6SQGiMzE/A90
 fDn+Hem8vJF6sITe/KuqfWBYVtrOPzqL0EHpNi1XI2Eu1zXOb3AAYN92kI+Aif1l0F7Qo6H8mZW
 mdON2Z2D3ZYYhZRVzhNFV95jKzWKio+FhspPHxkbb77ZKUfZIBn5crPhCq896lMgLgGwEIbn+JC
 vK4xpwkNoGPPzAuqm9Mz4Dp7fNXpif90ITy/E/PNZLj32sHkDT1HlNLq+4eU=
X-Received: by 2002:a05:6a21:7748:b0:393:fb81:ac66 with SMTP id
 adf61e73a8af0-393fb81b858mr1667833637.5.1770625233456; 
 Mon, 09 Feb 2026 00:20:33 -0800 (PST)
X-Received: by 2002:a05:6a21:7748:b0:393:fb81:ac66 with SMTP id
 adf61e73a8af0-393fb81b858mr1667810637.5.1770625232970; 
 Mon, 09 Feb 2026 00:20:32 -0800 (PST)
Received: from smtpclient.apple ([106.202.227.239])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c50206sm94161125ad.19.2026.02.09.00.20.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Feb 2026 00:20:32 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <7feb4327-fbe6-4ed3-bfe5-e0f8adf8022e@redhat.com>
Date: Mon, 9 Feb 2026 13:50:19 +0530
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3E8E2592-AB5D-4A40-98B3-C2814E6746BD@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
 <7feb4327-fbe6-4ed3-bfe5-e0f8adf8022e@redhat.com>
To: Cedric Le Goater <clg@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
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



> On 9 Feb 2026, at 12:18=E2=80=AFPM, C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>=20
> On 1/27/26 06:15, Ani Sinha wrote:
>> Normally the vfio pseudo device file descriptor lives for the life of =
the VM.
>> However, when the kvm VM file descriptor changes, a new file =
descriptor
>> for the pseudo device needs to be generated against the new kvm VM =
descriptor.
>> Other existing vfio descriptors needs to be reattached to the new =
pseudo device
>> descriptor. This change performs the above steps.
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  hw/vfio/helpers.c | 86 =
+++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 83 insertions(+), 3 deletions(-)
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index f68f8165d0..d467875b4b 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct =
vfio_iommu_type1_info *info,
>>  #ifdef CONFIG_KVM
>>  /*
>>   * We have a single VFIO pseudo device per KVM VM.  Once created it =
lives
>> - * for the life of the VM.  Closing the file descriptor only drops =
our
>> - * reference to it and the device's reference to kvm.  Therefore =
once
>> - * initialized, this file descriptor is only released on QEMU exit =
and
>> + * for the life of the VM except when the vm file descriptor changes =
for
>> + * confidential virtual machines. In that case, the old file =
descriptor is
>> + * closed and a new file descriptor is recreated.  Closing the file =
descriptor
>> + * only drops our reference to it and the device's reference to kvm.
>> + * Therefore once initialized, this file descriptor is normally only =
released
>> + * on QEMU exit (except for confidential VMs as stated above) and
>=20
> Instead of changing this paragraph, I would prefer having, below
> the vfio_kvm_device_fd definition, a new section starting with
> comment "Confidential virtual machines"
>=20
>>   * we'll re-use it should another vfio device be attached before =
then.
>>   */
>>  int vfio_kvm_device_fd =3D -1;
>=20
> /*
> * Confidential virtual machines
>=20
>   <what is different from non confidential VMs>
>=20
> */
>  <Code>
>=20
>> +
>> +typedef struct KVMVfioFileFd {
>> +    int fd;
>> +    QLIST_ENTRY(KVMVfioFileFd) node;
>> +} KVMVfioFileFd;
>> +
>> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =3D
>> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
>> +
>> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void =
*data,
>> +                                  Error **errp);
>=20
> This declaration could be avoided.
>=20
>> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier =3D {
>> +    .notify =3D kvm_vfio_filefd_rebind,
>> +};
>> +
>> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void =
*data,
>> +                                  Error **errp)
>> +{
>> +    KVMVfioFileFd *file_fd;
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
>> +    if (vfio_kvm_device_fd) {
>=20
> May be "vfio_kvm_device_fd !=3D -1" ?
>=20
>> +        close(vfio_kvm_device_fd);
>> +    }
>> +
>> +    vfio_kvm_device_fd =3D cd.fd;
>> +
>> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
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
>>  #endif
>>    void vfio_kvm_device_close(void)
>> @@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>          .attr =3D KVM_DEV_VFIO_FILE_ADD,
>>          .addr =3D (uint64_t)(unsigned long)&fd,
>>      };
>> +    KVMVfioFileFd *file_fd;
>>        if (!kvm_enabled()) {
>>          return 0;
>> @@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>          }
>>            vfio_kvm_device_fd =3D cd.fd;
>> +        /*
>> +         * If the vm file descriptor changes, add a notifier so that =
we can
>> +         * re-create the vfio_kvm_device_fd.
>> +         */
>> +        =
kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
>>      }
>>        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> @@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>                           fd);
>>          return -errno;
>>      }
>> +
>> +    file_fd =3D g_malloc0(sizeof(*file_fd));
>> +    file_fd->fd =3D fd;
>> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
>> +
>=20
> Please introduce a helper routine.
>=20
>=20
>>  #endif
>>      return 0;
>>  }
>> @@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>>          .attr =3D KVM_DEV_VFIO_FILE_DEL,
>>          .addr =3D (uint64_t)(unsigned long)&fd,
>>      };
>> +    KVMVfioFileFd *file_fd;
>>        if (vfio_kvm_device_fd < 0) {
>>          error_setg(errp, "KVM VFIO device isn't created yet");
>> @@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>>                           "Failed to remove fd %d from KVM VFIO =
device", fd);
>>          return -errno;
>>      }
>> +
>> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
        ^^^^^^^^^^^^^
I believe this should be QLIST_FOREACH_SAFE . Will fix in next version.

>> +        if (file_fd->fd =3D=3D fd) {
>> +            QLIST_REMOVE(file_fd, node);
>> +            g_free(file_fd);
>> +            break;
>> +        }
>> +    }
>=20
> and a second helper for removal.
>=20
> Thanks,
>=20
> C.
>=20
>>  #endif
>>      return 0;
>>  }



