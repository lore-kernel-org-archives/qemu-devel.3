Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5713EE9A02C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 15:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsjVu-0005dF-8S; Wed, 18 Feb 2026 10:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsjVs-0005Xx-DA
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vsjVq-0007yH-CL
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 10:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771428648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E6a+MGATPrWxorShd6zBRxadLHBBTl/vKHV0XlueHGY=;
 b=Hz2CiiCKnYEiME3scMyfkSFTRZTeYez68nXSkahJvaTMxWObUKO7VmkCzswxWx4ZLzcgNc
 v/Wss1npGuzuF/DDpLW24/uK4v+9mXsAL7if0jnfQoU8b0v+isR2VWvYPmUJ1L3LSyoUun
 lvPl7T7/Ka7bTaGylJuDrdle3yWi10Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-3oYgxRMtMoW9rDIBuBuQ5Q-1; Wed, 18 Feb 2026 10:30:47 -0500
X-MC-Unique: 3oYgxRMtMoW9rDIBuBuQ5Q-1
X-Mimecast-MFC-AGG-ID: 3oYgxRMtMoW9rDIBuBuQ5Q_1771428645
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43768240a29so653119f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Feb 2026 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771428645; x=1772033445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=E6a+MGATPrWxorShd6zBRxadLHBBTl/vKHV0XlueHGY=;
 b=TfTnRwhAPWH/U5JGg7FFqpg1U8pY6/c0rwJcQm8iWE0ZBzH/qLoNd/sZKjj21i71q+
 KvDv2zVVz5eZFb8CH0jOoMQLd2JFM6X0lrMQFaDURPeuvmNoU5hha7NIFjAlRNiwFyQk
 OU6mX8Y1xpw2tk69BUeXjDQcPFz9KQqs4RsdudncAiGNCUjtdtv+UU/XbCYostbw3TvE
 kZfsPAHQAGUNRtcCtvZ4U2iuo9CR2PuTV1dL43saMUnCCS/kefd3pvZObdJPuos/oWnY
 Ek4JHb+7pC1xF8Owhnqqa621LPYl7451dMG+Aa6UuNgIE2WTB4+dhQsDGIkJw4QC/H5N
 EmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771428645; x=1772033445;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6a+MGATPrWxorShd6zBRxadLHBBTl/vKHV0XlueHGY=;
 b=nd1JdzGfpWTfG9T0wKUu2zbVsXCi5QVD5pKAk7conkc9ELjfDGDv1Y2DcEUFr7Go5V
 cAgBvDJ3PiY87S8cK7NW0iE/YhJwZ6t15cFsA1GRKFNEGXeutdWmLxFCBRSMD0QIB7XN
 AEDNmsWmZYfvVR9ecR+0qyUoWBKpcKZi2fRcL6ckCtjOWlR+8pp9b1M+cAWx5qmiEPBD
 Yzff63Fzl8bxW9g5macNPAM5AODjuQZtAI+Vwv1wR6+ttWuO+4zkAJEcAEoSm3nsCmyI
 mYG1+J85EkfWhuw6eyS3WFGBEOUrfes7jaVwCM0oU/1ckUCMsjvS8AoVaTimQks84axN
 gUbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUieRa8xFmAE0916ogaxuyuIRmvW2772cRYnc8hmzllgpLipp14PhHmRR/tLOEeLNAfw/kn9838E71L@nongnu.org
X-Gm-Message-State: AOJu0Yw8brlcmi6/D8lPzjWcpS/aC3hPB/rWr5KkK6hBtMEM3PpXlt+q
 bU/ba0kD/Osy2xOo2ZFHJFSnQrkmRhN1fdMKJWKs76sFMw0KvA5nxd0g0v9ephuop6s2Xxe7TbE
 S+OADoe7FabYGFSJx/LGH/W30d7d+9p21VYyYJNhUDLFBTAi4/VKCsnN/FrAnsLn+
X-Gm-Gg: AZuq6aLGzja8ag0eBPI6X3c9knpDXKMo41BuPZslDnAAeLpsepR9xbwqRThtvN33i7v
 Slbm36Hs9xrVmRRBdx1Uva2iVFy959+oSkOB4IOuSwvZJXKJ8zLe1zpfr48VXElUqwjYv0ogSxe
 KoEVXFU9NjkuM5G/nzW6gv6hPp7g59/YHn9C5FZBicxNqrQcrgSJ5UA44cL/hXDCEwBO4PgrFm2
 NmU3/grLBNOS4qd+j1dJ0gvIRdaBN4YhiYzuqSGBmk64Vud7YwzhtNYmRV60h+kCDH3fqTt1NiI
 e/fjHn9oRpYtzQ/5sHFMAjD1vudJNo5tWZquYpemMtcWb8XKIk9GdHBZn7dDRUPV8Fdy7WnGYIj
 mkbvQLB8tMEN9HPtuvZF3t41xFkp24gAfUCz7elcxIde7Imbi91P8BhfYzExc
X-Received: by 2002:a05:6000:220f:b0:436:42fb:153c with SMTP id
 ffacd0b85a97d-43958c5b04bmr4710405f8f.30.1771428644587; 
 Wed, 18 Feb 2026 07:30:44 -0800 (PST)
X-Received: by 2002:a05:6000:220f:b0:436:42fb:153c with SMTP id
 ffacd0b85a97d-43958c5b04bmr4710330f8f.30.1771428644012; 
 Wed, 18 Feb 2026 07:30:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a5b2d1sm45421230f8f.4.2026.02.18.07.30.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 07:30:43 -0800 (PST)
Message-ID: <0f5f1157-1ac4-472b-9c30-5e0c61d18f83@redhat.com>
Date: Wed, 18 Feb 2026 16:30:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/34] hw/vfio: generate new file fd for pseudo device
 and rebind existing descriptors
To: Ani Sinha <anisinha@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260218114233.266178-1-anisinha@redhat.com>
 <20260218114233.266178-23-anisinha@redhat.com>
 <96665575-c28c-43fb-af7b-41be109dc959@redhat.com>
 <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20472A29-B096-4407-B144-74C3804CC315@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 2/18/26 16:07, Ani Sinha wrote:
> 
> 
>> On 18 Feb 2026, at 7:37 PM, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> On 2/18/26 12:42, Ani Sinha wrote:
>>> Normally the vfio pseudo device file descriptor lives for the life of the VM.
>>> However, when the kvm VM file descriptor changes, a new file descriptor
>>> for the pseudo device needs to be generated against the new kvm VM descriptor.
>>> Other existing vfio descriptors needs to be reattached to the new pseudo device
>>> descriptor. This change performs the above steps.
>>> Tested-by: Cédric Le Goater <clg@redhat.com>
>>
>> There is a regression since last version.
>>
>>
>> 'reboot' from the guest and command 'system_reset' from the QEMU
>> monitor now generate these outputs:
>>
>>   qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
>>   qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
>>   qemu-system-x86_64: info: virtual machine state has been rebuilt with new guest file handle.
>>   ...
>>
>> and QEMU exits after a while.
> 
> I have only seen this in SEV-ES with more than one vcpus. Never with TDX or SEV-SNP (single or multiple cpus).
> On which host/guest type did you see this?

SEV-SNP on a RHEL9 host. Same guest I used before and host says :

   [1816531.409591] kvm_amd: SEV-ES guest requested termination: 0x0:0x0

Thanks,

C.



> 
>>
>>
>>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>
>> Anyhow this patch looks good.
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> Thanks,
>>
>> C.
>>
>>> ---
>>>   hw/vfio/helpers.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 92 insertions(+)
>>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>>> index f68f8165d0..e2bedd15ec 100644
>>> --- a/hw/vfio/helpers.c
>>> +++ b/hw/vfio/helpers.c
>>> @@ -116,6 +116,89 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>>    * we'll re-use it should another vfio device be attached before then.
>>>    */
>>>   int vfio_kvm_device_fd = -1;
>>> +
>>> +/*
>>> + * Confidential virtual machines:
>>> + * During reset of confidential vms, the kvm vm file descriptor changes.
>>> + * In this case, the old vfio kvm file descriptor is
>>> + * closed and a new descriptor is created against the new kvm vm file
>>> + * descriptor.
>>> + */
>>> +
>>> +typedef struct VFIODeviceFd {
>>> +    int fd;
>>> +    QLIST_ENTRY(VFIODeviceFd) node;
>>> +} VFIODeviceFd;
>>> +
>>> +static QLIST_HEAD(, VFIODeviceFd) vfio_device_fds =
>>> +    QLIST_HEAD_INITIALIZER(vfio_device_fds);
>>> +
>>> +static void vfio_device_fd_list_add(int fd)
>>> +{
>>> +    VFIODeviceFd *file_fd;
>>> +    file_fd = g_malloc0(sizeof(*file_fd));
>>> +    file_fd->fd = fd;
>>> +    QLIST_INSERT_HEAD(&vfio_device_fds, file_fd, node);
>>> +}
>>> +
>>> +static void vfio_device_fd_list_remove(int fd)
>>> +{
>>> +    VFIODeviceFd *file_fd, *next;
>>> +
>>> +    QLIST_FOREACH_SAFE(file_fd, &vfio_device_fds, node, next) {
>>> +        if (file_fd->fd == fd) {
>>> +            QLIST_REMOVE(file_fd, node);
>>> +            g_free(file_fd);
>>> +            break;
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static int vfio_device_fd_rebind(NotifierWithReturn *notifier, void *data,
>>> +                                  Error **errp)
>>> +{
>>> +    VFIODeviceFd *file_fd;
>>> +    int ret = 0;
>>> +    struct kvm_device_attr attr = {
>>> +        .group = KVM_DEV_VFIO_FILE,
>>> +        .attr = KVM_DEV_VFIO_FILE_ADD,
>>> +    };
>>> +    struct kvm_create_device cd = {
>>> +        .type = KVM_DEV_TYPE_VFIO,
>>> +    };
>>> +
>>> +    /* we are not interested in pre vmfd change notification */
>>> +    if (((VmfdChangeNotifier *)data)->pre) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &cd)) {
>>> +        error_setg_errno(errp, errno, "Failed to create KVM VFIO device");
>>> +        return -errno;
>>> +    }
>>> +
>>> +    if (vfio_kvm_device_fd != -1) {
>>> +        close(vfio_kvm_device_fd);
>>> +    }
>>> +
>>> +    vfio_kvm_device_fd = cd.fd;
>>> +
>>> +    QLIST_FOREACH(file_fd, &vfio_device_fds, node) {
>>> +        attr.addr = (uint64_t)(unsigned long)&file_fd->fd;
>>> +        if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>>> +            error_setg_errno(errp, errno,
>>> +                             "Failed to add fd %d to KVM VFIO device",
>>> +                             file_fd->fd);
>>> +            ret = -errno;
>>> +        }
>>> +    }
>>> +    return ret;
>>> +}
>>> +
>>> +static struct NotifierWithReturn vfio_vmfd_change_notifier = {
>>> +    .notify = vfio_device_fd_rebind,
>>> +};
>>> +
>>>   #endif
>>>     void vfio_kvm_device_close(void)
>>> @@ -153,6 +236,11 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>>           }
>>>             vfio_kvm_device_fd = cd.fd;
>>> +        /*
>>> +         * If the vm file descriptor changes, add a notifier so that we can
>>> +         * re-create the vfio_kvm_device_fd.
>>> +         */
>>> +        kvm_vmfd_add_change_notifier(&vfio_vmfd_change_notifier);
>>>       }
>>>         if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
>>> @@ -160,6 +248,8 @@ int vfio_kvm_device_add_fd(int fd, Error **errp)
>>>                            fd);
>>>           return -errno;
>>>       }
>>> +
>>> +    vfio_device_fd_list_add(fd);
>>>   #endif
>>>       return 0;
>>>   }
>>> @@ -183,6 +273,8 @@ int vfio_kvm_device_del_fd(int fd, Error **errp)
>>>                            "Failed to remove fd %d from KVM VFIO device", fd);
>>>           return -errno;
>>>       }
>>> +
>>> +    vfio_device_fd_list_remove(fd);
>>>   #endif
>>>       return 0;
>>>   }
>>
> 


