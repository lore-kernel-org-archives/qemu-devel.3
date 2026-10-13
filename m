Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3496CC6B19
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGfFJ-0003Hk-J1; Tue, 13 Oct 2026 12:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGfFC-0003HP-6R
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:20:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1xGfF4-0003hZ-OX
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 12:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791908441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uPvf4ziYk2DaFiNS2mSx6qgLpW9GVLOjbbXe06Z/HLE=;
 b=MplUD0HdHd8BE9hUf9wKBTeO4Scy9ZnlcrF8+ms0g2RtoOimUsuCE+F9q70Ulrp/SwlUfq
 y4vrEqike3dVJW8NlL15w4gJ9xxEpaH/ArANkC3yp4F7LxymvDfQas8R7GynRUvXPeU94B
 tWhZ0yuCP+YxBrddfGrASpc+o9Lj+M8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-AXTw9fXVNu-u1j9Itwj2NA-1; Tue, 13 Oct 2026 16:20:39 +0000
X-MC-Unique: AXTw9fXVNu-u1j9Itwj2NA-1
X-Mimecast-MFC-AGG-ID: AXTw9fXVNu-u1j9Itwj2NA_1791908438
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48589603501so2269323f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791908438; x=1792513238; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uPvf4ziYk2DaFiNS2mSx6qgLpW9GVLOjbbXe06Z/HLE=;
 b=rJtcMyFyRbiSTcV/ceJ5JSjtVpIbni78q5jQZZQmyiCJcSEsWuldsozjTxtOfLAihZ
 2aJt5dcu4tcP2cSNybpxiyEgdbMNk21TauoBHs4N91LJpRWmnLX3HR8fzRDUYrIPp8lx
 6zcMraf9wRkO+IjvVVfHMP/vBM+yotM7SjwDHfLwcHtI1I0IrMx3prH4ygHJixkvzmo1
 KXNYDW9FSlAwAhx9N1HdZzejQfZ0LJvNdO0Iknkr12REnv9IKkyEnK9bFrVUAWxLFDJV
 Y45NxoSHWz1djmP+AncPqvPjEmbPgH3KYuKdQrZLUO1PbhAhoOJZjDdNjN5o8gGrAT+G
 9bQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791908438; x=1792513238;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uPvf4ziYk2DaFiNS2mSx6qgLpW9GVLOjbbXe06Z/HLE=;
 b=v5ScwEOJzUkBFb7KBnyNhLYINI2xMWoohInK6WAq9jeUFTTDD1XbpSOt9XqTfilYCH
 VZvU6sFNb8+mihKJ/wBJhNVv5y2kUrpM0x1H25bFuLVP+27zLEilLsY68ncOHmPY579T
 kTFRfktOsEoRLJZltV41n4QLT7ZAg2ZmLdvqRaEgzIWErZ0redM2gWECuKg3s29Eder4
 MyDLfPdhltYm7X1825j3m5KDlSn9NDoOKr8VVtJAVTRznmFFRrqaldh3kXg6UxB/UgWm
 +QsbHL/Ijk3r7NCehMyM4bv17fNPnTCkZ7IZ/5Lp7yEtFfKgtqV9XdGR0aMRA6QnS1vJ
 Z2FA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuA/maHoLyq5L5xIAxAXISU7UMSnzlFKCkKPwWCpNsv2F0pXs1uJ5YEqwhNKDLrGRfcTZPBnRHtEDM@nongnu.org
X-Gm-Message-State: AFq9FYLDK0sPh5Skr88FXscS4HZteIxnqfItyyv3BNCFCg5lCaSCW2/k
 YgBqsji/MTTBl0ZnbcKRLCSIWEAJUpAcssIrGalVZpamK2XX1bflBrhK0Sp7Z37tOZ5hO6x7Fo6
 Q3N51z/DvpfPoEo/rpyShX7NHS0jtoHKAorIg847y3zrrZdAtPkKtWE1F
X-Gm-Gg: AYBFou3r7wFLXSbSHm3XfyjlN5lY6ZwgvegdHHqI4WM/oaX/no1MFSrkcAPcCgnRROs
 Rr1YUReW0O3mbe3RsUgov3Z3O6uj0Jv89dDZOXHpiKvNeaPPK8PI454GqLszSEfcvkObzNBr+BZ
 WBHhofWsNfMA+P1ohR1Pzzgy2xkCxo1ZK0IYLLSqeQ6ZkwnmUK8tz2+25DhywUAuqGQzIe7eChD
 KLlW5SsR0GHQkn5F2O+8Dz4OjhObm4t3lyvz9acNaKWOWcKDUqGfXUeG2CcnoqbHU9IF+j1WMEJ
 Lv9leAA+z4VJNAM1IDm6ByBFCBnJgPzoAKQmcoZe8Qz864fxM0HKkBZ1Rgss2HoqgzsDM4HeTlQ
 MUtR04rQQFzuMA+QgFoFL5/3IiVL0FbR2MRuoUqHc
X-Received: by 2002:a5d:5d83:0:b0:48a:efed:ac97 with SMTP id
 ffacd0b85a97d-48dba9d326amr25215011f8f.33.1791908438235; 
 Tue, 13 Oct 2026 09:20:38 -0700 (PDT)
X-Received: by 2002:a5d:5d83:0:b0:48a:efed:ac97 with SMTP id
 ffacd0b85a97d-48dba9d326amr25214952f8f.33.1791908437616; 
 Tue, 13 Oct 2026 09:20:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:578a:3c67:6721:1232?
 ([2a01:e0a:1292:d530:578a:3c67:6721:1232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc6ddcsm5991388f8f.52.2026.10.13.09.20.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 09:20:36 -0700 (PDT)
Message-ID: <c18f2fde-5dae-45c5-a61a-8cade3ae5286@redhat.com>
Date: Tue, 13 Oct 2026 18:20:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On 10/13/26 06:06, Kasireddy, Vivek wrote:
> Hi Akihiko,
> 
>> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating
>> dmabuf from multiple ranges
>>
>>>>
>>>>> In order to create a dmabuf associated with a buffer that spans
>>>>> multiple ranges, we first need to identify the VFIO region and
>>>>> index the buffer (represented by iovec) belongs to and then
>>>>> translate its addresses to offsets within that region.
>>>>>
>>>>> The qemu_ram_block_from_host() API gives us both the region and
>>>>> the offset info we need to populate the dma ranges so that we can
>>>>> invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
>>>> dmabuf.
>>>>>
>>>>> Also, instead of iterating over all QOM devices to find the
>>>>> VFIODevice associated with a memory region, introduce a helper
>>>>> to just use the vfio_device_list to lookup the VFIODevice.
>>>>> And, introduce another helper to lookup the VFIO region given an
>>>>> address.
>>>>>
>>>>> Lastly, introduce an enum to return the type of error encountered
>>>>> while creating the dmabuf fd.
>>>>>
>>>>> Cc: Alex Williamson <alex@shazbot.org>
>>>>> Cc: Cédric Le Goater <clg@redhat.com>
>>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>>> ---
>>>>>     include/hw/vfio/vfio-device.h |  22 +++++++
>>>>>     hw/vfio/device.c              | 109
>> ++++++++++++++++++++++++++++++++++
>>>>>     hw/vfio/dmabuf-stubs.c        |  17 ++++++
>>>>>     hw/vfio/meson.build           |   1 +
>>>>>     4 files changed, 149 insertions(+)
>>>>>     create mode 100644 hw/vfio/dmabuf-stubs.c
>>>>>
>>>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
>>>> device.h
>>>>> index 8472420d3f..c05430be8a 100644
>>>>> --- a/include/hw/vfio/vfio-device.h
>>>>> +++ b/include/hw/vfio/vfio-device.h
>>>>> @@ -41,6 +41,13 @@ enum {
>>>>>         VFIO_DEVICE_TYPE_AP = 3,
>>>>>     };
>>>>>
>>>>> +enum {
>>>>> +    /* The Guest passed addresses stored in IOV are invalid */
>>>>> +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV = -1,
>>>>> +    /* Guest or Host may be at fault for this type of error */
>>>>> +    VFIO_DMABUF_CREATE_ERR_UNSPEC = -2,
>>>>> +};
>>>>
>>>> Nack.
>>>>
>>>> As said a few times already : it's a VFIO-specific enum leaking
>>>> into vfio-device.h to serve virtio-gpu's fallback logic. The
>>>> cleanest alternative is to use standard -errno returns and
>>>> make the fd an output parameter.
>>> It looks like Cedric remains unconvinced about the value or usefulness
>>> of this error enum. Therefore, to make progress, I intend to adopt his
>>> suggestion to use standard -errno returns for the next version,
>> considering
>>> that this series has been stuck for a year.
>>>
>>> AFAICS, dropping this error enum means that we would not be able to
>>> clearly identify and log (or attribute) Guest vs Host errors in virtio-gpu,
>>> particularly the INVALID_IOV case. I am not sure if this can be
>> considered
>>> a significant limitation. However, if there is a reasonable middle
>> ground
>>> solution or an alternative that you can think of that does not involve
>>> using VFIO error enums in virtio-gpu, then I would like to pursue that
>>> instead.
>>
>> Cédric's comment is a reiteration of previous points, but his concrete
>> code suggestion is new and brings to light some challenges with errno
>> propagation.
>>
>> First, errno does not precisely match the required semantics. We need
>> to
>> distinguish lookup failures from the other errors. However, with your
>> suggestion, lookup failures become -EINVAL and
>> vfio_device_get_feature()
>> also returns the same value when the backend lacks the operation,
>> making
>> it impossible to distinguish them.
>>
>> Propagating errno also requires extra care to preserve it when
>> necessary. For patch "[PATCH v13 8/9] virtio-gpu-dmabuf: Improve error
>> handling with 'Error **' and err enum", you suggested to add the
>> "saved_errno" variable to save errno before error_setg_errno(). That is
>> redundant because error_setg_errno() preserves errno. Realizing that
>> requires careful attention.
>>
>> While we could spend effort fixing these issues, we can simply avoid the
>> churn by not using errno.
>>
>> In any case, I agree keeping this stuck is not ideal while I don't think
>> I can provide any further insights. So I'm inviting Markus Armbruster to
> Looks like you forgot to cc Markus. I have added him now.
> 
>> this discussion. This is an area better handled by him, who maintains
>> the error reporting facility, including include/qapi/error.h, which
>> extensively documents codebase-wide error-handling convention.
>>
>> Markus, could you advise on the appropriate convention for returning
>> this kind of classification alongside Error **? Your perspective
>> across the codebase may help us settle on a consistent approach
>> beyond the individual subsystems involved here. Perhaps you may
>> improve
>> the documentation according to a design decision made here.
> Markus, here is some additional context from Akihiko as to why there is
> a need to introduce an error enum in VFIO:
> https://lore.kernel.org/qemu-devel/09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg.ci.i.u-tokyo.ac.jp/
> 
>>
>> If anyone else has a clean middle-ground solution in the meantime, I
>> would greatly appreciate your input as well.
> I am not sure if it can be considered clean or elegant but one middle-ground
> solution I can think of is to have (and use) the error enum just in virtio-gpu
> only but associate EINVAL (return value of vfio_device_create_dmabuf_fd())
> as the equivalent of INVALID_IOV. That is, the relevant code now becomes:
> 
>          res->dmabuf_fd = virtio_gpu_create_udmabuf(res, &local_err);
>          if (res->dmabuf_fd == VIRTIO_GPU_DMABUF_CREATE_ERR_INVALID_IOV) {
>              error_free_or_abort(&local_err);
> 
>              res->dmabuf_fd = vfio_device_create_dmabuf_fd(res->iov,
>                                                            res->iov_cnt,
>                                                            &local_err);
>              if (res->dmabuf_fd == -EINVAL) {
>                  error_free_or_abort(&local_err);
>                  qemu_log_mask(LOG_GUEST_ERROR,
>                                "Cannot create dmabuf: incompatible memory\n");
>                  return false;
>              }
> 
> I think this is reasonable IMO, but is this proposal acceptable to you?

The return value drives control flow.

AFAICT, in virtio_gpu_init_dmabuf(), the only distinction that seems
to matter for control flow is : "should I try the next backend ?" and
that's EINVAL, which means "these addresses are incompatible with this
particular backend."

The guest-vs-host attribution for logging/debugging is in the errp
messages :

  - "IOV memory address incompatible with udmabuf" : guest gave addresses udmabuf can't handle
  - "No VFIO device found to create dmabuf from"   : guest addresses don't map to a VFIO device
  - "UDMABUF_CREATE_LIST: ioctl failed" + errno    :  host/kernel issue

The Error* object is designed to encode a human-readable attribution
in a return value. It carries the diagnostic detail and the return
code carries the machine action.

Now the flow,

   udmabuf
     ├─ -EINVAL ──► VFIO
     │                ├─ >= 0 ──► vfio_device_mmap_dmabuf ──► success
     │                ├─ -EINVAL ──► guest error: incompatible memory
     │                └─ other -errno ──► error_report_err ──► host error
     │
     ├─ >= 0 ──► virtio_gpu_remap_dmabuf ──► success
     │
     ├─ -ENODEV ──► error_report_err ──► fail (VFIO NOT tried)
     ├─ -ENOMEM ──► error_report_err ──► fail (VFIO NOT tried)
     └─ other -errno ──► error_report_err ──► fail (VFIO NOT tried)


The fallback trigger should be widen to -EINVAL || -ENODEV.

How's that ?

Thanks,

C.


