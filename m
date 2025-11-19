Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E3CF3189
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 10:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLfJT-0000Xv-I6; Wed, 19 Nov 2025 05:21:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLfJS-0000Wn-5B
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:21:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLfJQ-0001if-8Z
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 05:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763547679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0PkEgP7X8o0DGwJsSJe6LrP9GUBU+CmrYOcHFO4G9ok=;
 b=W3j4HHExjsof3u1wA8Y3M3wrBltPOJ3dfJi4YTrIVFuPw0qwAaZ4WJ4aUYo5pXt9RDzNWb
 tPuKJ3UegqmBPkdyUeHmlP/3BFweiHbEgXV6qSph3r5gq7MuEGFZ+jDx//3CKngK9xRdOq
 X3tbgCCOzropwu85qLLPDb026DJSwws=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-hHZ_wnkjPQ-6sbqfFwoDWg-1; Wed, 19 Nov 2025 05:21:15 -0500
X-MC-Unique: hHZ_wnkjPQ-6sbqfFwoDWg-1
X-Mimecast-MFC-AGG-ID: hHZ_wnkjPQ-6sbqfFwoDWg_1763547675
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a027877eso36326225e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763547674; x=1764152474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=0PkEgP7X8o0DGwJsSJe6LrP9GUBU+CmrYOcHFO4G9ok=;
 b=gTmRBMmd+9zeFqQ932tFGBwaU7U7KgEhEuH9yXa4VdJOG/Ugqs1C+EKJxuRHFK91Kz
 pcXibNlcppQpOfGdcYcYnaBMRWhGx9KYy62m4FVPB7T6NslS0YfOOPcU5V/XgQ6/Jp4k
 P39DGRfgXzXGgvFLr7CeHfpWc1nY+d4PyCYW+aP6niM2SPbuFjq94Le+j0rWAE6DoxTM
 PNUoDNPf//XtpmWh+DoxYGDi/lS/KReSQt/ohgs2iNSxojk1ZM9ET27nrbRVtDl8apjT
 ntxkMCQTNPwJji8W7m/dXUh2Dgi5rzXBmsXy2sdvo87Etrwih/+hBSCBsUotU3+G3Mo9
 Z7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763547674; x=1764152474;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0PkEgP7X8o0DGwJsSJe6LrP9GUBU+CmrYOcHFO4G9ok=;
 b=Kr5cVVgYT0Z+yLXtRtla3MmfrBjvzIlkXs8xmc0ArtRO59f9o17EtUx4tZgmIvID8l
 QqxfNw5ft74njdBrEYIDRF83LhEu+jg9JBvZpaahpCk2Fcx3QG+JF81SRVExINELYsv1
 Ouis6or86a9Mzkh76UhHoVmu1P+4dxyMvVWefudu28YkUOqNHFYuxtzlJte/Z6s1IGSC
 pq3z0jCp0vksq/w02A1uQSrCT4Vni2X81EECiqiKwxITVJpqHnlMytn7Vw9AbFttefg5
 Sqx2qMFhm9RW4PYCCqVocU2FpFrQPi0ze0tBy4OaeX09zYs8hHfg/q90LvlIVy4CeQY0
 aupg==
X-Gm-Message-State: AOJu0Yzy++PW2qoAmMmMog2KrKvbRr5hlWaGH754+utD5fwA+Hg5cEn2
 mat+zg2L7NRGO8aKJpJTgQZ0dglLi1yCehITdhLitaGuF35X0dmCi8jdYYcLeULBapFnW5rT851
 g7P0GXP8EoW727gz7KYY+R0ZR50OZKUpKv7sLdFMC9SbdUe5N1Qzzew9i
X-Gm-Gg: ASbGncvuBobDFS2C2VCQVNChMiixyYyUZ0VQiyYetXbu7BTdDmJiwASYQe26NT6dCUK
 bujstOifvvPw8BttXCZZqY1KaQWpR7Kpf6DkVlWXKb0dJxPN1cCxHGGVFIyyMO0Zwx2Rf8GAT9h
 wcimP9M7zggZyFjNI+t0MBI+IhkgmTlp3EqgmSfDA6P6u+RE8sn3UzvOshirTfM3ugR+EG7T/Kb
 N8RB0aGS5SaIU3opwb3ncqqbqB/FEai9IR2krF4inoCbo5So4k414OEdtYB7hvmDPUL/5a0o9FJ
 VHKyntF5MZFq7ix+tpdfSMMN5qMcYyEAj4g97BrS19ksHA8WEVQuin8HT1ebMsGUyKW+39bKwYg
 2y/J3vZA/EJfBimDbUrQO1VVouIiUhJxtfvA=
X-Received: by 2002:a05:600c:8b43:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-4778fe6098dmr189282655e9.18.1763547674501; 
 Wed, 19 Nov 2025 02:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJUIvP1TBm+ZbLyT8QLkq+ZPpZ0lv2OStMomIts3lZmTtbWCXe2sjahgzwRrRpcYNzlzT60g==
X-Received: by 2002:a05:600c:8b43:b0:477:6e02:54a5 with SMTP id
 5b1f17b1804b1-4778fe6098dmr189282395e9.18.1763547674038; 
 Wed, 19 Nov 2025 02:21:14 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e982d6sm37349187f8f.21.2025.11.19.02.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 02:21:13 -0800 (PST)
Message-ID: <33d8e666-63c3-47a1-91f1-4e2bcf9cb7c2@redhat.com>
Date: Wed, 19 Nov 2025 11:21:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/s390x: Fix a possible crash with passed-through
 virtio devices
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20251118174047.73103-1-thuth@redhat.com>
 <521156ea-43f4-47cf-9e77-2310ff206ec1@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <521156ea-43f4-47cf-9e77-2310ff206ec1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/11/2025 11.02, Cédric Le Goater wrote:
> On 11/18/25 18:40, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Consider the following nested setup: An L1 host uses some virtio device
>> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
>> device through to the L3 guest. Since the L3 guest sees a virtio device,
>> it might send virtio notifications to the QEMU in L2 for that device.
>> But since the QEMU in L2 defined this device as vfio-ccw, the function
>> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
>> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
>> but since "sch" belongs to a vfio-ccw device, that driver_data rather
>> points to a CcwDevice instead. So as soon as QEMU tries to use some
>> VirtioCcwDevice specific data from that device, we've lost.
>>
>> We must not take virtio notifications for such devices. Thus fix the
>> issue by adding a check to the handle_virtio_ccw_notify() handler to
>> refuse all devices that are not our own virtio devices. Like in the
>> other branches that detect wrong settings, we return -EINVAL from the
>> function, which will later be placed in GPR2 to inform the guest about
>> the error.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v3: Print the subchannel number to ease debugging
>>
>>   hw/s390x/s390-hypercall.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
>> index ac1b08b2cd5..508dd97ca0d 100644
>> --- a/hw/s390x/s390-hypercall.c
>> +++ b/hw/s390x/s390-hypercall.c
>> @@ -10,6 +10,7 @@
>>    */
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>   #include "cpu.h"
>>   #include "hw/s390x/s390-virtio-ccw.h"
>>   #include "hw/s390x/s390-hypercall.h"
>> @@ -42,6 +43,19 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, 
>> uint64_t data)
>>       if (!sch || !css_subch_visible(sch)) {
>>           return -EINVAL;
>>       }
>> +    if (sch->id.cu_type != VIRTIO_CCW_CU_TYPE) {
>> +        /*
>> +         * This might happen in nested setups: If the L1 host defined the
>> +         * L2 guest with a virtio device (e.g. virtio-keyboard), and the
>> +         * L2 guest passes this device through to the L3 guest, the L3 guest
>> +         * might send virtio notifications to the QEMU in L2 for that 
>> device.
>> +         * But since the QEMU in L2 defined this device as vfio-ccw, it's 
>> not
>> +         * a VirtIODevice that we can handle here!
>> +         */
>> +        warn_report_once("Got virtio notification for unsupported device "
>> +                         "on subchannel %02x.%1x.%04x!", cssid, ssid, 
>> schid);
>> +        return -EINVAL;
>> +    }
>>       vdev = virtio_ccw_get_vdev(sch);
> 
> While at it, it would be good to test 'vdev' and return -EINVAL as in
> virtio_ccw_set_vqs().
> 
> In virtio-ccw.c, this needs some care I think :
> 
>     static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>     {
>         ...
>         VirtioCcwDevice *dev = sch->driver_data;
>         VirtIODevice *vdev = virtio_ccw_get_vdev(sch);
>         ...
>         if (!dev) {                <-- vdev ?
>            return -EINVAL;
>         }

I wonder whether this can happen at all? We check for a a valid virtio-ccw 
device
now, and all virtio-ccw devices should have their driver_data set up in their
realize function, so I think we should always get a valid pointer here and 
ifit's NULL, there must be a bug somewhere. So maybe an assert() would be the
better idea? Or just let it crash by dereferencing the NULL pointer...?

  Thomas


