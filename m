Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BA5EF070B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 05:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpK4i-0003Dn-7a; Mon, 09 Feb 2026 00:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpK4g-0003DZ-2e
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vpK4b-0007YZ-93
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 00:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770615875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6MZWyiZqKOwnVELgJVmJsgV5eB4OjkUhoa5pjoael0=;
 b=DjpR9M4vM83Kw+7qC6b7IAer06uWKBKFu7ruRy8nxLP1UWp5Z6hewqxXHBHowVAtIeefUc
 By3BAlPJWCaC4mDcZ2vj8SwqhVz1vvGoJIj2LQoX0Wm/VZL//4Z0sxeaDORM6wijTyjnlb
 139uJx8I2GD2HqjwLDn73l4z5MXWMEk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-HE17rg2UOUi06T6cuBiTZQ-1; Mon, 09 Feb 2026 00:44:33 -0500
X-MC-Unique: HE17rg2UOUi06T6cuBiTZQ-1
X-Mimecast-MFC-AGG-ID: HE17rg2UOUi06T6cuBiTZQ_1770615872
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354e7e705e3so1319375a91.1
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 21:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770615872; x=1771220672; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6MZWyiZqKOwnVELgJVmJsgV5eB4OjkUhoa5pjoael0=;
 b=Sqzrp1it0XDGC501C2munAfUjUP1dJ84Tl2RWuZyFBSWyb3dxUEGe5uTjk7qLNPClb
 XeWjAuiwMvyipRkCIevFGMzYDCMsDnWX9hkl97p0lRCduWtQ7WI7M5uTQpnApNdJdpHV
 35t/KgRs/U4QKuHo74rYaKh2Lg8bmHe3FmqvD1+6pX470c1pcUC2SK5iq36OGxpMbhu9
 VFeqWhNUwH4mGfA8jUi8Gt1ZeWIiBkKrMZhEuPS/j0z4WCoMuRDnSlkiQCxnfLcRT0Ws
 ylYoRQ5zLye/rwc++vMFr9wf1nd1Rp5YKF4v/XGRcPPoUWjtfT4auzDXSeJBWhK/zIGW
 0FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770615872; x=1771220672;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W6MZWyiZqKOwnVELgJVmJsgV5eB4OjkUhoa5pjoael0=;
 b=sGQLPNv5srhhZTLtZ2xRE9v7Z0Br8QzvpgMCa63PiGRH1oUHyE3j3BFRxCijmFiCgS
 ZbsFWRYBbTEbR5JlWjQD0qqLFp2de4DXaoV4/q2aF5IjHxqZDaK+1eqEFk3sAhD34hlq
 cn1twaMh85viRvZfU5P2BCeqUEV1vtEvGY1SUtc5Ja11iilHU8KQPppuabElui9TcYln
 oc5VL5qF8JsUhq/S/Pj5jLkjOGIL2xaw343R4T8h+AELAiIfDXzmivTVde9Z0k2pr2JB
 hboTs/QjXW/xNw9J2hxy26O29FJZT6+Qlf5ezETEDLyXZ0kwt4lsQBhYDJW9iDMrmd6H
 79Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk2jIzeHrNZinknwwVxfdd0eESyjmVOZokaBRMxRSQJeUeg0vNiF+aTi4dlywpXVBMCRz1GtTtUim9@nongnu.org
X-Gm-Message-State: AOJu0YxI+/GMV+ow7jB9f12jzhtdoDWdCVc0SjY2Fqzpi85XauCd4ah8
 NhITtdl8+ceStkFddX+L6b+BfAVZxHfAaUF4RHrGgijZT6pjZ3agt/s3Nit0vdxeDb4GrY/q0TL
 3Zdoxxc2DO69ga5zqKgqRq+/YVMxA4IMFwAUbZqFYIP6U5vdooWjF+L02
X-Gm-Gg: AZuq6aL3i6MUWWx75Nq8bPo3/heVGUw7tH7n+hocw6WKn8MaFLvdB0X+Sr41C2jtrbf
 mtSadrz6gLBxkE8sbc8cpF2m2IrEZ4ltB/uifUk5ZTfDAICIhV5ChBD5nEVKyz+P0VyNMndVtPJ
 PTPNoytsasS40aYvz9quUjj428E+AWSS6nx0c0Y17TIQYA9vT/QSocWoS+4rPuG0jnwlIPluidD
 ung7IIrNP5rmTV9FMY74p5ZEPuRzQMzcJh8BxnQu4ii8mm7IC2IHc6ziP5L39x88vDlfP95KBuR
 SFROh/mojqBcFt7J2QTrMpx2q8woJU5cQjyNpmh7Dxa0bh2ZVH9xITUPf/roZOH7i4b7rY3GJS3
 3vzyuuQoiJgJcrX0ciEDUheRMNBi8txHJKAXBq7yST6/97wkOc71pUxF0nHc=
X-Received: by 2002:a17:90b:3901:b0:354:a57c:65dd with SMTP id
 98e67ed59e1d1-354b3cae0d0mr7931026a91.24.1770615872049; 
 Sun, 08 Feb 2026 21:44:32 -0800 (PST)
X-Received: by 2002:a17:90b:3901:b0:354:a57c:65dd with SMTP id
 98e67ed59e1d1-354b3cae0d0mr7931013a91.24.1770615871577; 
 Sun, 08 Feb 2026 21:44:31 -0800 (PST)
Received: from smtpclient.apple ([106.202.227.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3549c38fa4fsm14345035a91.13.2026.02.08.21.44.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 08 Feb 2026 21:44:31 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAK3XEhN6gbALmc4xewbh0FmsaZzwOzd1gYnP96WtfYfyD0g_pA@mail.gmail.com>
Date: Mon, 9 Feb 2026 11:14:12 +0530
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9A3531C1-1A3A-4D03-9B8C-E2E40B349C75@redhat.com>
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
 <CAK3XEhOet2pFNT2PLOHuBZFNAbXtYq3Hghr0XNvd4FKyPPX7bw@mail.gmail.com>
 <76421356-de3a-4941-bd4d-7c362fbb228f@redhat.com>
 <CAK3XEhN6gbALmc4xewbh0FmsaZzwOzd1gYnP96WtfYfyD0g_pA@mail.gmail.com>
To: Cedric Le Goater <clg@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



> On 9 Feb 2026, at 9:37=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> On Mon, Feb 9, 2026 at 3:38=E2=80=AFAM C=C3=A9dric Le Goater =
<clg@redhat.com> wrote:
>>=20
>> On 2/8/26 15:39, Ani Sinha wrote:
>>> On Tue, Jan 27, 2026 at 10:47=E2=80=AFAM Ani Sinha =
<anisinha@redhat.com> wrote:
>>>>=20
>>>> Normally the vfio pseudo device file descriptor lives for the life =
of the VM.
>>>> However, when the kvm VM file descriptor changes, a new file =
descriptor
>>>> for the pseudo device needs to be generated against the new kvm VM =
descriptor.
>>>> Other existing vfio descriptors needs to be reattached to the new =
pseudo device
>>>> descriptor. This change performs the above steps.
>>>=20
>>> I have not been able to test this change. Can someone suggest a way =
to
>>> add a functional test and/or test this manually?
>>=20
>> Automated VFIO testing [*] is tough because it depends on a "real"
>> physical PCI device.
>>=20
>> I have tested you series using a sev-snp guest with an assigned =
device
>> (SATA controller) and verified that the guest could reboot. The SATA
>> controller has no disks connected, so further testing is required.
>>=20
>> However, a 'system_reset' command issued from the QEMU monitor leaves
>> the guest hanging. May be this is expected ?
>=20
> I do not think so. On non-coco, I just tried it and it reboots fine
> with x-change-vmfd-on-reset turned on.

Sorry I had some issues with my testing. Neither non-coco reset not coco =
reset was using vmfd change path when the QMP reset command was used.
In non-coco, it was the normal reset which obviously works.

I fixed it. See =
https://gitlab.com/anisinha/qemu/-/commit/c5514dbb2b52d474397220cfa3a0b8fa=
a26cda0c

Please use this patch and test. I have tasted this on SNP and seems to =
work. I will make it part of next spin-up.

Thanks for testing.

> I tried a RHEL 10 guest image as well as a simple UKI kernel.
> Maybe there is some bug in this patch, not sure. In QEMU the code path
> should be the same for both.
>=20
>>=20
>>=20
>>> Otherwise I am going to add a comment in the next spin up that this
>>> change is not tested.
>>=20
>> I will provide some more comments on the code. Please give me a day
>> or two before resending.
>=20
> Sure, please take all the time you need.
>=20
>>=20
>> Thanks,
>>=20
>> C.
>>=20
>> [*] One way to address this constraint for VFIO testing would be
>>     to run the test in a nested environment using emulated devices,
>>     like IGB, attached to an L1 which would be assigned to an L2.
>>     But that's unrelated to this series.
>>>=20
>>>>=20
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> ---
>>>>  hw/vfio/helpers.c | 86 =
+++++++++++++++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 83 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>>> index f68f8165d0..d467875b4b 100644
>>>> --- a/hw/vfio/helpers.c
>>>> +++ b/hw/vfio/helpers.c
>>>> @@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct =
vfio_iommu_type1_info *info,
>>>>  #ifdef CONFIG_KVM
>>>>  /*
>>>>   * We have a single VFIO pseudo device per KVM VM.  Once created =
it lives
>>>> - * for the life of the VM.  Closing the file descriptor only drops =
our
>>>> - * reference to it and the device's reference to kvm.  Therefore =
once
>>>> - * initialized, this file descriptor is only released on QEMU exit =
and
>>>> + * for the life of the VM except when the vm file descriptor =
changes for
>>>> + * confidential virtual machines. In that case, the old file =
descriptor is
>>>> + * closed and a new file descriptor is recreated.  Closing the =
file descriptor
>>>> + * only drops our reference to it and the device's reference to =
kvm.
>>>> + * Therefore once initialized, this file descriptor is normally =
only released
>>>> + * on QEMU exit (except for confidential VMs as stated above) and
>>>>   * we'll re-use it should another vfio device be attached before =
then.
>>>>   */
>>>>  int vfio_kvm_device_fd =3D -1;
>>>> +
>>>> +typedef struct KVMVfioFileFd {
>>>> +    int fd;
>>>> +    QLIST_ENTRY(KVMVfioFileFd) node;
>>>> +} KVMVfioFileFd;
>>>> +
>>>> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =3D
>>>> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
>>>> +
>>>> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, =
void *data,
>>>> +                                  Error **errp);
>>>> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier =3D =
{
>>>> +    .notify =3D kvm_vfio_filefd_rebind,
>>>> +};
>>>> +
>>>> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, =
void *data,
>>>> +                                  Error **errp)
>>>> +{
>>>> +    KVMVfioFileFd *file_fd;
>>>> +    int ret =3D 0;
>>>> +    struct kvm_device_attr attr =3D {
>>>> +        .group =3D KVM_DEV_VFIO_FILE,
>>>> +        .attr =3D KVM_DEV_VFIO_FILE_ADD,
>>>> +    };
>>>> +    struct kvm_create_device cd =3D {
>>>> +        .type =3D KVM_DEV_TYPE_VFIO,
>>>> +    };
>>>> +
>>>> +    /* we are not interested in pre vmfd change notification */
>>>> +    if (((VmfdChangeNotifier *)data)->pre) {
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
>>>> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO =
device");
>>>> +        return -errno;
>>>> +    }
>>>> +
>>>> +    if (vfio_kvm_device_fd) {
>>>> +        close(vfio_kvm_device_fd);
>>>> +    }
>>>> +
>>>> +    vfio_kvm_device_fd =3D cd.fd;
>>>> +
>>>> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
>>>> +        attr.addr =3D (uint64_t)(unsigned long)&file_fd->fd;
>>>> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) =
{
>>>> +            error_setg_errno(errp, errno,
>>>> +                             "Failed to add fd %d to KVM VFIO =
device",
>>>> +                             file_fd->fd);
>>>> +            ret =3D -errno;
>>>> +        }
>>>> +    }
>>>> +    return ret;
>>>> +}
>>>> +
>>>>  #endif
>>>>=20
>>>>  void vfio_kvm_device_close(void)
>>>> @@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error =
**errp)
>>>>          .attr =3D KVM_DEV_VFIO_FILE_ADD,
>>>>          .addr =3D (uint64_t)(unsigned long)&fd,
>>>>      };
>>>> +    KVMVfioFileFd *file_fd;
>>>>=20
>>>>      if (!kvm_enabled()) {
>>>>          return 0;
>>>> @@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error =
**errp)
>>>>          }
>>>>=20
>>>>          vfio_kvm_device_fd =3D cd.fd;
>>>> +        /*
>>>> +         * If the vm file descriptor changes, add a notifier so =
that we can
>>>> +         * re-create the vfio_kvm_device_fd.
>>>> +         */
>>>> +        =
kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
>>>>      }
>>>>=20
>>>>      if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>>>> @@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error =
**errp)
>>>>                           fd);
>>>>          return -errno;
>>>>      }
>>>> +
>>>> +    file_fd =3D g_malloc0(sizeof(*file_fd));
>>>> +    file_fd->fd =3D fd;
>>>> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
>>>> +
>>>>  #endif
>>>>      return 0;
>>>>  }
>>>> @@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error =
**errp)
>>>>          .attr =3D KVM_DEV_VFIO_FILE_DEL,
>>>>          .addr =3D (uint64_t)(unsigned long)&fd,
>>>>      };
>>>> +    KVMVfioFileFd *file_fd;
>>>>=20
>>>>      if (vfio_kvm_device_fd < 0) {
>>>>          error_setg(errp, "KVM VFIO device isn't created yet");
>>>> @@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error =
**errp)
>>>>                           "Failed to remove fd %d from KVM VFIO =
device", fd);
>>>>          return -errno;
>>>>      }
>>>> +
>>>> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
>>>> +        if (file_fd->fd =3D=3D fd) {
>>>> +            QLIST_REMOVE(file_fd, node);
>>>> +            g_free(file_fd);
>>>> +            break;
>>>> +        }
>>>> +    }
>>>> +
>>>>  #endif
>>>>      return 0;
>>>>  }
>>>> --
>>>> 2.42.0
>>>>=20
>>>=20
>>=20


