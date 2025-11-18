Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E20CCED634
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKXD-0000NT-GD; Tue, 18 Nov 2025 07:10:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLKX3-0000K0-0P
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:10:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLKWy-0002wN-Fy
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763467794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G+0+AluELcs66l3ffDaTDJ9StnESQWCMm/emfzclsuY=;
 b=UtmUG4ZDrrnhM6HzNZYxK7tfnGwwUWtTXpb9marfqW4IZpPewiNiw1QxUIitNFqGQGXjwK
 RPb19BsayZEqn/7aaUk6SHBp+eesGA/15qG4/neU9a4bvanoIpOeIC58zpGPI+GYw+ukQ9
 kErxue/QFb/0DlxNQU4XAH6O4o4hU9Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-4wtJLSx6NsChyll9nWHzgg-1; Tue, 18 Nov 2025 07:09:53 -0500
X-MC-Unique: 4wtJLSx6NsChyll9nWHzgg-1
X-Mimecast-MFC-AGG-ID: 4wtJLSx6NsChyll9nWHzgg_1763467792
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b3339cab7so4150985f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763467792; x=1764072592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=G+0+AluELcs66l3ffDaTDJ9StnESQWCMm/emfzclsuY=;
 b=bOKBgo5PLa9gzDz4y+popIvq/fIcgqIqzYLMIMWbz4b5SrNgbmarT0ygKBEqisUm13
 HFtCGSVp9may1re1xE1nHrbBnKzlINY1bgUJrvi3Bxwyzy9BTUOBuylGMmtsEAyKzSpg
 4Zw++XpCcZM9H4cT4IFueMf6zCy1Te6Fer5iMRsztPTnX2lJ74epw3LQ09mY4KzlKf1M
 ykS9lyKkvu3R9qDwi1dPTR94NCX9lvXjRSfjtMaC8KqsNyHenWQS9472yUPQR15JCTzS
 iF3/NoSTWoAs+ccg3Eirk2t/vryo5slErNQC634wDPgpVapFA/FJWbbtu2YPGF2ZWgoJ
 vBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763467792; x=1764072592;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+0+AluELcs66l3ffDaTDJ9StnESQWCMm/emfzclsuY=;
 b=VLdUISfdIwBLo9dDSasoGIuELZFu8tqond/5DlD6vBU45AsNUnHe3xp+LIHMKfgOOl
 sKa/H3+NTpIp4RRXVewp6DmVi516PNhSTl2WFlU02uXG7MTDY7K1Tsbil2o/7dFEgdsA
 AVh8NFnkgtq5RjNhRWmWoR88P95YaGJGyRA4+HnO0xiEU/Xy6lN63oqUFvBeV6iAXNcx
 yfD/HLIRz/grpkUTJY2FenMWLu1/RXQ0CnMb1fVYRqgUXTGoPL6/6HJX7k4KpxtmSlTj
 2G/4nTat4qQSD+MQm3hIhCKWm/z1epH6MYhBjZYq0jxJZkbgzvLw1SrHqUMeVRkM7qfM
 sSrw==
X-Gm-Message-State: AOJu0YyEyer8TUAPEgK+OVQEM2t0f6BkLuR38mMxEJENJSZWr86TOJ+1
 RvIH9XRNyV7RRBG21ygqqOW/AmVf/qggoYtQ3Ri0zY+bnSjWnA1OJR9TnfQlY+v6UUAu59K/uFZ
 gmpFaJnuXZJWYQIRJqJBNPKZVsfZ2qN43fL7/r2REPWzaKcKXe3paWtQE
X-Gm-Gg: ASbGncuyFdbhBqz9uiFYF8vAY6m/A6Pu7Z5gCJwFq45PZybSHWU5oWrnSCAkszr7w/Q
 MROcesdC5JQ5HwppA/1WwU1o2JYFFVWUhOQsXDma1G+K77svphJxWUDtQbsTRum9W5BlsNK+rza
 R8s3/036BCzsOpainog+4ZpOaQoinQHSjP3EUDjJkEG0rixSbsK1myhsctAomeUCarYISfXth32
 3cjadHnV4gtHqIgolPYY3YwcDqS9fnlGpctFFo5qhLDhtdRWZf8RqytluVd2FZTLp7nuQBbxs6/
 9cY4CN90A+j3GTe2ln1XCoY+niqtyZoa2d4ay2jn5PozA+PSQPoKddSp3aoV4doDiWe8VZxaXun
 oMeAr06E=
X-Received: by 2002:a05:6000:178d:b0:42b:32f5:ad18 with SMTP id
 ffacd0b85a97d-42b5933ce84mr14326274f8f.9.1763467791632; 
 Tue, 18 Nov 2025 04:09:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXl/+BGXZFaIXALk39nJP4povHboBUi9oktIe6kRGgHIIfoDUifNG/UyFKxuZWgv4azUkxWA==
X-Received: by 2002:a05:6000:178d:b0:42b:32f5:ad18 with SMTP id
 ffacd0b85a97d-42b5933ce84mr14326240f8f.9.1763467791189; 
 Tue, 18 Nov 2025 04:09:51 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e91f2dsm32605525f8f.19.2025.11.18.04.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 04:09:50 -0800 (PST)
Message-ID: <a2c82393-ccc1-4dfc-92b1-69e10dd6adcc@redhat.com>
Date: Tue, 18 Nov 2025 13:09:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20251118093945.35062-1-thuth@redhat.com>
 <87ms4jr20v.fsf@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87ms4jr20v.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 18/11/2025 12.52, Cornelia Huck wrote:
> On Tue, Nov 18 2025, Thomas Huth <thuth@redhat.com> wrote:
> 
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
>> refuse all devices that are not our own virtio devices.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Now with the required #include statement
>>
>>   hw/s390x/s390-hypercall.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
>> index ac1b08b2cd5..38f1c6132e0 100644
>> --- a/hw/s390x/s390-hypercall.c
>> +++ b/hw/s390x/s390-hypercall.c
>> @@ -10,6 +10,7 @@
>>    */
>>   
>>   #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>   #include "cpu.h"
>>   #include "hw/s390x/s390-virtio-ccw.h"
>>   #include "hw/s390x/s390-hypercall.h"
>> @@ -42,6 +43,18 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
>>       if (!sch || !css_subch_visible(sch)) {
>>           return -EINVAL;
>>       }
>> +    if (sch->id.cu_type != VIRTIO_CCW_CU_TYPE) {
>> +        /*
>> +         * This might happen in nested setups: If the L1 host defined the
>> +         * L2 guest with a virtio device (e.g. virtio-keyboard), and the
>> +         * L2 guest passes this device through to the L3 guest, the L3 guest
>> +         * might send virtio notifications to the QEMU in L2 for that device.
>> +         * But since the QEMU in L2 defined this device as vfio-ccw, it's not
>> +         * a VirtIODevice that we can handle here!
>> +         */
>> +        warn_report_once("Got virtio notification for unsupported device!");
> 
> Maybe also print which device ended up here?

You mean the values for cssid, ssid and schid ? Or which information did you 
have in mind?

  Thomas


