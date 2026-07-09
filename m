Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B97C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whokM-00025N-Dw; Thu, 09 Jul 2026 09:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whok6-00021m-6o
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1whok2-0006gM-Ns
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783603476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5pyjm7iwdmAN/4ZHOH0vaZ+CuUe+tIMO3cbEQTLUT/s=;
 b=ZCgD/+613HWYDHGfy2bd37OZ8eTMQxfNnmFFLzRx1I+muPLXJN73e3bnCkNi0x7GxbPHhS
 4g0mthVHYQ89Kbf78H/8nES18/DmdrchBTh03nckoYp+7wFo1TbleEw1YLYf9bPpE1RM0K
 69uR+Ttoy2hklj1gF6DSM42Toi/7lCk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-YjUhNX5AMLm1-KpVJS0UtA-1; Thu, 09 Jul 2026 09:24:35 -0400
X-MC-Unique: YjUhNX5AMLm1-KpVJS0UtA-1
X-Mimecast-MFC-AGG-ID: YjUhNX5AMLm1-KpVJS0UtA_1783603474
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c15dfd34e4cso82401366b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 06:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783603474; x=1784208274; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5pyjm7iwdmAN/4ZHOH0vaZ+CuUe+tIMO3cbEQTLUT/s=;
 b=eaFZpCuzoUu3DOz9F5/UPFkDiwx0RvFeKugHLNrXyL2ATYUi9X3cCNxB/SFkC9WMgH
 3z5V6o3L+BibUyfARKK6fvyyZdy81bhBbYjq3p311x+k5OCoQwYa8R7U44TkvKZW672v
 So9TnJjCaNuU+sYONVKy4+/8PjlpPol8WZMbujrkfpNpEYBWq5n3juWJGrLgn9G+fFQR
 YSjgctYjuEzzoY2YKqDFU8n7XoHHP+J1EZSQPOnnuCwMFvdbS5TJWnSHuWr4S3M4nN9q
 m46octu/VrM8e4jVMXCEkV0jGdH7N9FyXTcN4Ial97n/sfhPh+HMdAp7RRoMAE+Nl3Yx
 4rdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783603474; x=1784208274;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5pyjm7iwdmAN/4ZHOH0vaZ+CuUe+tIMO3cbEQTLUT/s=;
 b=FelUG7YoBs7H/t/zTo4k+4MC+1WN2CJjVO0Ms+nJLi6EpTPrCQRQBbubjkaWOfQVe4
 p511WC83aYCLfPgB+aAU4rjxb/IeEIrw2kB2w1wd/X1Us2qGWqRy0gnNfI4evdCdMoOl
 OJAtcQispHdYASY+9icSf4P464zOUfju2k1cC/quXc3G+KVSjgfAORsV1xusf5Ci3wup
 tYAXu1O27h1ceN0NpVE5oYRs7X/S9l9oQp3clFi6eTePrKRggyCDlwtRohTvSNkeLzIG
 /Uz2mc0LP+26J2/YTyg5G3s1gZdxytTLsFfgVX0MnWpoiCgJnB/dlMLP462Xi9RZ8LyZ
 voiw==
X-Gm-Message-State: AOJu0YzrRI3c8iEm9QEXsBD7VMJzNTVtgpWsoHSsF7yOW+PbxzqCT1ON
 4iou/QVSLw748EYkX6ZttklnqPljTFPC3kAINNajW/9fFlbhRxsIX+SYRMxlnlGpLlBofr9mpFp
 rG4j4sx5pjQRbDueFi9bL8s77elWaJLojV/DjMN/XpfS9/4GkOX/zeOSl
X-Gm-Gg: AfdE7ck3GI5pnSggN4E6jDPCmGlpx1wwCSi7cy/xmHlRMDxUEusyipjoMM4xOzNuPup
 BSKTmrwrfAmBpfUQmJ6keQvT9DwOtQjmApmqPasyhnEsoJLimb4BajBCvk6R2EOUimVINdOodww
 rFOV5cC2Vw+f677rnptMp2G12KnkJE8lX2plbGi20iLnoC8Hsf0MflIbdA6HgpCb5V+3WMNo8uf
 p0X0Z7VAfn42qBJ1VPHg4kfUgTGRigK5epPUSnM9xnPZiOK79rRdnqmp0drpV+SREiWSDZfxCem
 7W5lmvRgIFB7/lwDKyk16kr5nJ4Fqu6r/7DeyhmyuKKE7rTMaUeniTjU7D6hFzXdBBm+ARg3/RR
 r9cJbsENE5Ae/i3UbU31TXegAVeoeTWiU1++Yo0g/CZgivhDGPQ==
X-Received: by 2002:a17:906:6a1a:b0:c15:db3a:c105 with SMTP id
 a640c23a62f3a-c15db3ac262mr202390766b.1.1783603474005; 
 Thu, 09 Jul 2026 06:24:34 -0700 (PDT)
X-Received: by 2002:a17:906:6a1a:b0:c15:db3a:c105 with SMTP id
 a640c23a62f3a-c15db3ac262mr202388466b.1.1783603473489; 
 Thu, 09 Jul 2026 06:24:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15dfda815dsm147703566b.36.2026.07.09.06.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 06:24:32 -0700 (PDT)
Message-ID: <2fe112be-4caf-47cb-b554-57ebaa1d76fd@redhat.com>
Date: Thu, 9 Jul 2026 15:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio: return NULL from qemu_get_virtqueue_element()
 on invalid state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Amit Shah <amit@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
References: <20260709100644.1878369-1-lvivier@redhat.com>
 <20260709083651-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260709083651-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/9/26 14:40, Michael S. Tsirkin wrote:
> On Thu, Jul 09, 2026 at 12:06:44PM +0200, Laurent Vivier wrote:
>> qemu_get_virtqueue_element() uses assert() to check that the in_num
>> and out_num fields deserialized from the migration stream do not
>> exceed VIRTQUEUE_MAX_SIZE. A crafted migration stream can set these
>> fields to invalid values, hitting the assertion and aborting the
>> destination QEMU process.
>>
>> Replace the assertions with a bounds check that returns NULL on
>> failure. Update all callers (virtio-serial-bus, virtio-blk,
>> virtio-scsi) to handle the NULL return and fail the migration
>> gracefully.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 6bdc21c050a2 ("virtio: fix up max size checks")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3802
>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> ---
>>   hw/block/virtio-blk.c       |  4 ++++
>>   hw/char/virtio-serial-bus.c |  3 +++
>>   hw/scsi/virtio-scsi.c       |  4 ++++
>>   hw/virtio/virtio.c          | 11 ++++-------
>>   4 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>> index 6b92066aff4c..42c0f2553f18 100644
>> --- a/hw/block/virtio-blk.c
>> +++ b/hw/block/virtio-blk.c
>> @@ -1384,6 +1384,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
>>           }
>>   
>>           req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
>> +        if (!req) {
>> +            return -EINVAL;
>> +        }
>> +
>>           virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
>>   
>>           WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
>> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
>> index c1973f0248fc..879df158608a 100644
>> --- a/hw/char/virtio-serial-bus.c
>> +++ b/hw/char/virtio-serial-bus.c
>> @@ -763,6 +763,9 @@ static int fetch_active_ports_list(QEMUFile *f,
>>   
>>               port->elem =
>>                   qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
>> +            if (!port->elem) {
>> +                return -EINVAL;
>> +            }
>>   
>>               /*
>>                *  Port was throttled on source machine.  Let's
>> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>> index 6c7376801190..8dd0b88a30c4 100644
>> --- a/hw/scsi/virtio-scsi.c
>> +++ b/hw/scsi/virtio-scsi.c
>> @@ -274,6 +274,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
>>       assert(n < vs->conf.num_queues);
> 
> 
> I mean just above this we have this assert.

Sure, I can fix that too.

> 
> 
> If you are really want to be nicer about handling
> malformed input, pls do this systematically, not just
> at random places for no apparent reason.

I don't do this randomly for no apparent reason, see
https://gitlab.com/qemu-project/qemu/-/issues/3802

But I'm going to check if I can remove more assert() in the migration path.

Thanks,
Laurent

> 
> 
>>       req = qemu_get_virtqueue_element(vdev, f,
>>                                        sizeof(VirtIOSCSIReq) + vs->cdb_size);
>> +    if (!req) {
>> +        return NULL;
>> +    }
>> +
>>       virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
>>   
>>       if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index f4d86a365530..7bccfdde33e7 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -2167,13 +2167,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
>>   
>>       qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
>>   
>> -    /* TODO: teach all callers that this can fail, and return failure instead
>> -     * of asserting here.
>> -     * This is just one thing (there are probably more) that must be
>> -     * fixed before we can allow NDEBUG compilation.
>> -     */
>> -    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
>> -    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
>> +    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
>> +        data.out_num > ARRAY_SIZE(data.out_addr)) {
>> +        return NULL;
>> +    }
>>   
>>       elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
>>       elem->index = data.index;
>> -- 
>> 2.54.0
> 


