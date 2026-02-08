Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAF7EF06E8
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 22:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpCxX-0008N2-FY; Sun, 08 Feb 2026 17:08:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpCxV-0008Mk-J1
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 17:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vpCxR-000491-5c
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 17:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770588518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NwbYADL6MT1Ns+eXoHM9YTlkIi8iUUztxiW+7hQXfDU=;
 b=Afc+Dj3hWWP+uSB56m3a5KhSznSpU5XPMQ1E7cjAGaB066OnQ2MBi1hkA7aQ48A4gsKNki
 JQf9JZQg+X47+nL1/GOKAZfEpoqwWXePOZZZB4WtkY3TnRIDzCxoiCdDSUOBRu99RKsTFy
 2lEpK1HLD8ZiEGLEPUvIn5ZJF7dFpVI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-cme60POtMvOeCi3h24AwBw-1; Sun, 08 Feb 2026 17:08:37 -0500
X-MC-Unique: cme60POtMvOeCi3h24AwBw-1
X-Mimecast-MFC-AGG-ID: cme60POtMvOeCi3h24AwBw_1770588516
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so20899285e9.2
 for <qemu-devel@nongnu.org>; Sun, 08 Feb 2026 14:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770588516; x=1771193316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NwbYADL6MT1Ns+eXoHM9YTlkIi8iUUztxiW+7hQXfDU=;
 b=tnXtzr0kkVS8WbB0DWbl2BJMiVdfmKEUADopjKR10lK4uHa3KRPe8rNKzgnJs3dsWK
 7q2j59AXL1GGjjVl/LNs7t/W+aM/ImDKqiM3DxBXfNf/KcPaMJZvw+QJAJ3C51HXJdrm
 kY/3T0e9ypL1o4S2N9S/MmwDpDvc0RsLhvWldDOJ39NFt2mjjPwZjhQhSL7etSWBj77o
 BykgdO/lBuUrI9U1FmC2erZqV71MeSQpckQcCVoCd18kLOQ2BmAYzM2Yx9ufaSTbdUzR
 Xbq0S3GXk6g3PMEdxz5YOt10A6uXv5zRhqo2xVm4i+cWYxIEEWFGT1lw1ywhVmCgGVPc
 wy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770588516; x=1771193316;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwbYADL6MT1Ns+eXoHM9YTlkIi8iUUztxiW+7hQXfDU=;
 b=gOcwqwc9YgOpXJECug94b64agyxiASPOwfcUMwilLLlplMkJwpTQVMXbKuo7Sx/nhs
 Z7SrN++3PZ7V0RYLdK7CavXI8zvbWBwCBhpx2Bky6UgD2oHKTyncHXubsvWhWfXEZ9zd
 sDn+VIQYc/fNRs5LC0Ill/26EJ5qwyawuw438bG0hH/BOW7FSmUawdco4QXaT3IRQre6
 SGO8Np61JZxKhYT4BCP4xVafW7rOL1dnAHHjI0HAyCP//I3N2MyLAbXQ6CACl7vJuH7v
 QxSnRNsLWEwdyRyWl08DDQek0EJIs8a8EELbJ6CWLG7vHjNEb/liR02oPCem3zdJC0+0
 srNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8CrRR0h2HofkIkozgjZ9MDKhotIW6A5CwBOYdvaYjF9KD5Xnb0imhBig9cZlgCKLSP6TfUY8lbe95@nongnu.org
X-Gm-Message-State: AOJu0YxXgFAuMC67yNmg6JBMdd6QFTrhYXUit7WkcpIcY3fc+uh0oIeg
 yHwUukfgYgZ8FyFTo5FOTOrrne+bmHtTdFyqbwA7HvjQafKyOhBtVn5TEbaTSPUkmIs/Y+CFXhW
 ebgOMFz6ijI6DFE6KUWlzSOYgH1AxQbpnk5o5Q1h2nA0avEOLaHUW4pcf
X-Gm-Gg: AZuq6aItmyDCWXYNw3nLxUINNabEwB8nbW4lfgKK22FzQpo9UuwoyGtOLx2my/fMEXp
 Xcq1zMrJmwyLjwfohjR0gE7Z5wIXMfEuCZqbRgog2dC06L9tmsw3oQ8VDPbsrarx75/r45xHGoB
 9NPM+CZDWT9boL+aBGhlEl0WU36x24EHhG2OSC0Dk1QqfarwT5KZFWMUONWp1ezMKEcQZIcPmai
 XVIwCTNzb0rVPeypu4sJXWGZv3jr0fMo/QvUfS2+H1JrP2R8i7F5u6QACNGFFUXOju7ttAg9YUG
 t48k/ZoSBCanwiB7iyxvzDRQqKRfeAtXsob7inwgOidVO4OWPZ0GSsQYEngzqfZvBCL1E5T//mW
 GRJePtAxrPV6QU8RKFHr/BUGya57Hfs1G8dwEYyZc0pqnNJ42
X-Received: by 2002:a05:600c:468b:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48320229220mr138411715e9.31.1770588515801; 
 Sun, 08 Feb 2026 14:08:35 -0800 (PST)
X-Received: by 2002:a05:600c:468b:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-48320229220mr138411505e9.31.1770588515374; 
 Sun, 08 Feb 2026 14:08:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320719bd2sm180109805e9.11.2026.02.08.14.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Feb 2026 14:08:34 -0800 (PST)
Message-ID: <76421356-de3a-4941-bd4d-7c362fbb228f@redhat.com>
Date: Sun, 8 Feb 2026 23:08:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/33] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: Ani Sinha <anisinha@redhat.com>, Alex Williamson <alex@shazbot.org>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
References: <20260127051612.219475-1-anisinha@redhat.com>
 <20260127051612.219475-23-anisinha@redhat.com>
 <CAK3XEhOet2pFNT2PLOHuBZFNAbXtYq3Hghr0XNvd4FKyPPX7bw@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAK3XEhOet2pFNT2PLOHuBZFNAbXtYq3Hghr0XNvd4FKyPPX7bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 2/8/26 15:39, Ani Sinha wrote:
> On Tue, Jan 27, 2026 at 10:47 AM Ani Sinha <anisinha@redhat.com> wrote:
>>
>> Normally the vfio pseudo device file descriptor lives for the life of the VM.
>> However, when the kvm VM file descriptor changes, a new file descriptor
>> for the pseudo device needs to be generated against the new kvm VM descriptor.
>> Other existing vfio descriptors needs to be reattached to the new pseudo device
>> descriptor. This change performs the above steps.
> 
> I have not been able to test this change. Can someone suggest a way to
> add a functional test and/or test this manually?

Automated VFIO testing [*] is tough because it depends on a "real"
physical PCI device.

I have tested you series using a sev-snp guest with an assigned device
(SATA controller) and verified that the guest could reboot. The SATA
controller has no disks connected, so further testing is required.

However, a 'system_reset' command issued from the QEMU monitor leaves
the guest hanging. May be this is expected ?


> Otherwise I am going to add a comment in the next spin up that this
> change is not tested.

I will provide some more comments on the code. Please give me a day
or two before resending.

Thanks,

C.

[*] One way to address this constraint for VFIO testing would be
     to run the test in a nested environment using emulated devices,
     like IGB, attached to an L1 which would be assigned to an L2.
     But that's unrelated to this series.
> 
>>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>   hw/vfio/helpers.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 83 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index f68f8165d0..d467875b4b 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -110,12 +110,71 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>   #ifdef CONFIG_KVM
>>   /*
>>    * We have a single VFIO pseudo device per KVM VM.  Once created it lives
>> - * for the life of the VM.  Closing the file descriptor only drops our
>> - * reference to it and the device's reference to kvm.  Therefore once
>> - * initialized, this file descriptor is only released on QEMU exit and
>> + * for the life of the VM except when the vm file descriptor changes for
>> + * confidential virtual machines. In that case, the old file descriptor is
>> + * closed and a new file descriptor is recreated.  Closing the file descriptor
>> + * only drops our reference to it and the device's reference to kvm.
>> + * Therefore once initialized, this file descriptor is normally only released
>> + * on QEMU exit (except for confidential VMs as stated above) and
>>    * we'll re-use it should another vfio device be attached before then.
>>    */
>>   int vfio_kvm_device_fd = -1;
>> +
>> +typedef struct KVMVfioFileFd {
>> +    int fd;
>> +    QLIST_ENTRY(KVMVfioFileFd) node;
>> +} KVMVfioFileFd;
>> +
>> +static QLIST_HEAD(, KVMVfioFileFd) kvm_vfio_file_fds =
>> +    QLIST_HEAD_INITIALIZER(kvm_vfio_file_fds);
>> +
>> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *data,
>> +                                  Error **errp);
>> +static struct NotifierWithReturn kvm_vfio_vmfd_change_notifier = {
>> +    .notify = kvm_vfio_filefd_rebind,
>> +};
>> +
>> +static int kvm_vfio_filefd_rebind(NotifierWithReturn *notifier, void *data,
>> +                                  Error **errp)
>> +{
>> +    KVMVfioFileFd *file_fd;
>> +    int ret = 0;
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_DEV_VFIO_FILE,
>> +        .attr = KVM_DEV_VFIO_FILE_ADD,
>> +    };
>> +    struct kvm_create_device cd = {
>> +        .type = KVM_DEV_TYPE_VFIO,
>> +    };
>> +
>> +    /* we are not interested in pre vmfd change notification */
>> +    if (((VmfdChangeNotifier *)data)->pre) {
>> +        return 0;
>> +    }
>> +
>> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
>> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
>> +        return -errno;
>> +    }
>> +
>> +    if (vfio_kvm_device_fd) {
>> +        close(vfio_kvm_device_fd);
>> +    }
>> +
>> +    vfio_kvm_device_fd = cd.fd;
>> +
>> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
>> +        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
>> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> +            error_setg_errno(errp, errno,
>> +                             "Failed to add fd %d to KVM VFIO device",
>> +                             file_fd->fd);
>> +            ret = -errno;
>> +        }
>> +    }
>> +    return ret;
>> +}
>> +
>>   #endif
>>
>>   void vfio_kvm_device_close(void)
>> @@ -137,6 +196,7 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>           .attr = KVM_DEV_VFIO_FILE_ADD,
>>           .addr = (uint64_t)(unsigned long)&fd,
>>       };
>> +    KVMVfioFileFd *file_fd;
>>
>>       if (!kvm_enabled()) {
>>           return 0;
>> @@ -153,6 +213,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>           }
>>
>>           vfio_kvm_device_fd = cd.fd;
>> +        /*
>> +         * If the vm file descriptor changes, add a notifier so that we can
>> +         * re-create the vfio_kvm_device_fd.
>> +         */
>> +        kvm_vmfd_add_change_notifier(&kvm_vfio_vmfd_change_notifier);
>>       }
>>
>>       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>> @@ -160,6 +225,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>                            fd);
>>           return -errno;
>>       }
>> +
>> +    file_fd = g_malloc0(sizeof(*file_fd));
>> +    file_fd->fd = fd;
>> +    QLIST_INSERT_HEAD(&kvm_vfio_file_fds, file_fd, node);
>> +
>>   #endif
>>       return 0;
>>   }
>> @@ -172,6 +242,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>>           .attr = KVM_DEV_VFIO_FILE_DEL,
>>           .addr = (uint64_t)(unsigned long)&fd,
>>       };
>> +    KVMVfioFileFd *file_fd;
>>
>>       if (vfio_kvm_device_fd < 0) {
>>           error_setg(errp, "KVM VFIO device isn't created yet");
>> @@ -183,6 +254,15 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>>                            "Failed to remove fd %d from KVM VFIO device", fd);
>>           return -errno;
>>       }
>> +
>> +    QLIST_FOREACH(file_fd, &kvm_vfio_file_fds, node) {
>> +        if (file_fd->fd == fd) {
>> +            QLIST_REMOVE(file_fd, node);
>> +            g_free(file_fd);
>> +            break;
>> +        }
>> +    }
>> +
>>   #endif
>>       return 0;
>>   }
>> --
>> 2.42.0
>>
> 


