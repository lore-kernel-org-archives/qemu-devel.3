Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA886C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 18:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWg8F-0001x0-15; Tue, 01 Jul 2025 14:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWg8D-0001wl-Rd
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 14:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uWg8B-0006JA-TR
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 14:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751396098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5/APklDuHUlsdRDanLmiTcf2GNQGu11tbs9gk8d9iEE=;
 b=g7rmEgwateDdUoG4OLFFe8SVoC6BR1qa5sCkUu0kpAiqe2u7yilhCi2wpQsX+2015Xrloh
 xeStQtjbkUiqp1GfmKhp1eSNWitbsuM+rdbgU3zSwYbaLpRWbFUpgibvIZcVVlNJ6XlYSl
 kKPzNVnIQbmB+DTady/t6G3CTvqdVYU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-CD7yivURNUWXgo3EG6PN5Q-1; Tue, 01 Jul 2025 14:54:56 -0400
X-MC-Unique: CD7yivURNUWXgo3EG6PN5Q-1
X-Mimecast-MFC-AGG-ID: CD7yivURNUWXgo3EG6PN5Q_1751396094
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-adb32dbf60bso587483866b.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 11:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751396094; x=1752000894;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5/APklDuHUlsdRDanLmiTcf2GNQGu11tbs9gk8d9iEE=;
 b=ky66rHGL/+aat8sVCAiTcOfOUxqLcF9TNKzeaPMAvsgh2aU+RnhIbMCzdrQdiv70Ev
 MzK4XJapg3+6sHMc5YYvoVC1n43tg1mI9fxDxNJbHb/DoRe0PyeqATOHg0447o9o8wat
 eR+ViGya3au7sdCz/0TlKKuSWn9VkozzW4Ws8RwjphhOb/WsMOly3HFfeVzRooS0QQ7x
 Qj4xeitulfrdpdYalS+FQrzLOTlq0822YA1xuTKDK9giFO8HEHK/W1y5q5UpSGX9YLch
 blXe84XIpLnLn5uU1B6urfqCxDf2WZkeRMY7jF+rJK4jN56vxu2NU8a7cduZ0vFGxn3P
 EFZg==
X-Gm-Message-State: AOJu0Yzo2YiZbfuL59NYDGoBs0szeGDI7/EBufysqRrs+flSrf2NhrZo
 grzBs5K+wYE5tbCUX3Q5QmmcM7GxoMA/YwK+3jMXZcFOdOYP6zmWqWHPv8KXU+Rq2Pde5bFkiUf
 dkUbr+HjPtCt+FlhN+xrAyhIj03kkHDg6T+4R9zUmEmrFOaVs/h879QlX
X-Gm-Gg: ASbGnctcXCWJ+tZ4UsvsmyAYOcw+K6oR7kE2ydTDnZ6uH4rDmfZiv/c6W1SJknjQ55Y
 7FFNrXQm67EdZ0BJdsrLv5k8EGXJ5JgI5AIYKYeYz5HYMpeJ92iP6mbEYkdjUP6stvUsAvI9p4M
 qTDchHyYTpp0uJneDj6aPj7X4kGrtNpQ9eSQACuczsFzLDPbspSFpfM43tnJ5CL7jaGz/aGHpSx
 JgPMvTh7YE6DxIV9s3MyPZQ/xijdhX8JCRI+gsB13Ma4IrJDStf7ip83eQMKEF0jGMUjsiFc0G4
 23+cq9AH/8zukXuutjb8RyTKS3nB+WGgEXHvH5O6PRK3ynDGIsZsOdA9V4dcgg==
X-Received: by 2002:a17:907:6d1d:b0:ae0:c0b3:5649 with SMTP id
 a640c23a62f3a-ae34fd0661dmr1675571966b.11.1751396094255; 
 Tue, 01 Jul 2025 11:54:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPUsQgGPCQbvrnzDZTlmof5WwhxHgDxUAPrHjPRfDnWeSCt4WHrdiWhRldjS83mqwxOGbXYw==
X-Received: by 2002:a17:907:6d1d:b0:ae0:c0b3:5649 with SMTP id
 a640c23a62f3a-ae34fd0661dmr1675569666b.11.1751396093685; 
 Tue, 01 Jul 2025 11:54:53 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-114-041.pools.arcor-ip.net.
 [47.64.114.41]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c0100fsm918640766b.88.2025.07.01.11.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 11:54:53 -0700 (PDT)
Message-ID: <ff3f37b2-97bb-4a54-8647-4a8963993d89@redhat.com>
Date: Tue, 1 Jul 2025 20:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] MAINTAINERS: fix paths for relocated files
To: Sean Wei <me@sean.taipei>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20250616.qemu.relocated@sean.taipei>
 <20250616.qemu.relocated.02@sean.taipei>
 <ff8a559e-f1d7-45a8-a292-20c9ab697646@redhat.com>
 <374597a7-94e4-45b2-9617-35183db3ea9d@sean.taipei>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <374597a7-94e4-45b2-9617-35183db3ea9d@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 01/07/2025 20.06, Sean Wei wrote:
> On 2025/7/1 1:24 PM, Thomas Huth wrote:
>> On 16/06/2025 17.48, Sean Wei wrote:
>>> Several files were renamed in previous commits, causing their entries
>>> in MAINTAINERS to reference outdated paths.
>>> This prevents scripts/get_maintainer.pl from correctly matching
>>> these files to their maintainers.
>>>
>>> Update the filenames to reflect their current locations so that
>>> maintainer lookup works properly.
>>>
>>> Related commits
>>> ---------------
>>>
>>>    c45460decbd (Oct 2023)
>>>      hw/input/stellaris_input: Rename to stellaris_gamepad
>>>      Rename  include/hw/input/{gamepad.h => stellaris_gamepad.h}
>>>
>>>    4faf359accb (Nov 2020)
>>>      docs: Move virtio-net-failover.rst into the system manual
>>>      Rename  docs/{ => system}/virtio-net-failover.rst
>>>
>>>    89857312f32 (Apr 2024)
>>>      hw/usb: move stubs out of stubs/
>>>      Rename  stubs/usb-dev-stub.c => hw/usb/bus-stub.c
>>>
>>>    f2604d8508a (Apr 2024)
>>>      hw/virtio: move stubs out of stubs/
>>>      Rename  stubs/virtio-md-pci.c => hw/virtio/virtio-md-stubs.c
>>>
>>>    2c888febdfa (Apr 2024)
>>>      memory-device: move stubs out of stubs/
>>>      Rename  stubs/memory_device.c => hw/mem/memory-device-stubs.c
>>>
>>>    d481cec7565 (Oct 2024)
>>>      migration: Move cpu-throttle.c from system to migration
>>>      Rename  {system => migration}/cpu-throttle.c
>>>
>>>    864a3fa4392 (Jan 2023)
>>>      monitor: Rename misc.c to hmp-target.c
>>>      Rename  monitor/{misc.c => hmp-target.c}
>>>
>>> Signed-off-by: Sean Wei <me@sean.taipei>
>>> ---
>>>   MAINTAINERS | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index fed8619874..0477e124d1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1002,7 +1002,7 @@ L: qemu-arm@nongnu.org
>>>   S: Odd Fixes
>>>   F: hw/*/stellaris*
>>>   F: hw/display/ssd03*
>>> -F: include/hw/input/gamepad.h
>>> +F: include/hw/input/stellaris_gamepad.h
>>>   F: include/hw/timer/stellaris-gptm.h
>>>   F: docs/system/arm/stellaris.rst
>>>   F: tests/functional/test_arm_stellaris.py
>>> @@ -2163,7 +2163,7 @@ F: hw/net/
>>>   F: include/hw/net/
>>>   F: tests/qtest/virtio-net-test.c
>>>   F: tests/functional/test_info_usernet.py
>>> -F: docs/virtio-net-failover.rst
>>> +F: docs/system/virtio-net-failover.rst
>>>   T: git https://github.com/jasowang/qemu.git net
>>>   Parallel NOR Flash devices
>>> @@ -2214,7 +2214,7 @@ F: tests/qtest/sdhci-test.c
>>>   USB
>>>   S: Orphan
>>>   F: hw/usb/*
>>> -F: stubs/usb-dev-stub.c
>>> +F: hw/usb/bus-stub.c
>>
>> I think we could simply drop this line now completely since it is already 
>> covered by the previous hw/usb/* wildcard line.
>>
>>>   F: tests/qtest/usb-*-test.c
>>>   F: docs/system/devices/usb.rst
>>>   F: include/hw/usb.h
>>> @@ -2469,7 +2469,7 @@ F: hw/s390x/virtio-ccw-md.h
>>>   F: hw/s390x/virtio-ccw-md-stubs.c
>>>   F: hw/virtio/virtio-md-pci.c
>>>   F: include/hw/virtio/virtio-md-pci.h
>>> -F: stubs/virtio-md-pci.c
>>> +F: hw/virtio/virtio-md-stubs.c
>>
>> Could be merged with the hw/virtio/virtio-md-pci.c line by turning it into:
>>
>> F: hw/virtio/virtio-md-*.c
>>
>>>   virtio-mem
>>>   M: David Hildenbrand <david@redhat.com>
>>> @@ -3187,7 +3187,7 @@ F: hw/mem/pc-dimm.c
>>>   F: include/hw/mem/memory-device.h
>>>   F: include/hw/mem/nvdimm.h
>>>   F: include/hw/mem/pc-dimm.h
>>> -F: stubs/memory_device.c
>>> +F: hw/mem/memory-device-stubs.c
>>
>> This could be merged with the preceeding "hw/mem/memory-device.c" line, 
>> too, by turning it into:
>>
>> F: hw/mem/memory-device*.c
>>
>>   Thomas
>>
> 
> 
> Hi Thomas,
> 
> Oh yeah, those suggestions makes sense to me, and make this patch much better!
> 
> Should I send a PATCH v2 to the mailing list, or just attach the fix-up like 
> this is enough?

Normally I'd recommend a proper v2, but this time I was also able to apply 
your inlined updated patch, so no need to resend.

Thanks, I'll queue your patches for my next pull request.

  Thomas


