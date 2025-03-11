Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4D8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2FG-0004IZ-R8; Tue, 11 Mar 2025 12:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts27x-0001sr-Vs
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:06:53 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts27u-0007NT-Cv
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:06:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3913d45a148so2268587f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741709199; x=1742313999; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Q8QVedxm0QWiWBXxIE9ibEXviU06zZ/BcHH2WYiD9M=;
 b=j+TlTIQbkr4h8iYXXYn8/E8vOeJ9iTj0e9N7M6jYdZsQdcI2UeiwBlsuizFgIPbyda
 giQ3ljBxjOI7YOehn/s03e57ZIfL+WWX3kSb9KaC4ccYK98cyRkrTNfsHT7LAqYtyOu0
 91d/KbSBnCxW4Nc4W6EniBKNsWYlnVRTxvBKZ8DyrfKMuoF0m8LiQZZ9y/JOS2v1eJGI
 2W2VjMt9/MaCb9A3LzSNO8KxdkYuznzttIJVB0aIc3oBnyZHXlgwmO/hTKjEdl2Wj9Re
 sNjGSPM6epV+6oJoDVkdC93XHggsD8kk4phHL5BfNqbagX+YrsL+aDezUyJLXhlfw2gy
 0oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741709199; x=1742313999;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Q8QVedxm0QWiWBXxIE9ibEXviU06zZ/BcHH2WYiD9M=;
 b=Cz/rvYPTiUGYXiDK1WCUKz6X1GNQzGw3aAnU1odbi/wnyjs4Kb5KWmVnG+2diVR+nV
 OQMjS/TBRcLn4WNZz3hsDXIYjO73I5hYqFQkILJVPECDq/uwfAlONjrr3DbhQcQjYjKG
 TTBKI1oWKS2/WbrP2Ywo+Kueraao9PrVFsFm1cDLOu5ZiJLh71X9oAIpOL+BmGNRfEgC
 7Ds3yg7IkQU2Tqf6OGVKFcr1en+YcnSvQg24U0Pt3ltJmXfyDAhdzF/3Y9pZfv1Vqz+n
 fYvhb+NwfJRpDlX/tTloVj2OoxgO0lScAhC+T/VJQSZritqXzs98GjSZaVAhzRYzMVFY
 UaOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnEvqEQM3ZkDkd1EeHztrpTS4rITtqgz8/21e45CuiDIQ+PzOCngKQc4ZNpN48n2y5ZAzSUm+yhdyi@nongnu.org
X-Gm-Message-State: AOJu0YzQIATulzQ9/3m9+LNESx3Oal9AhKxDfHpcEKq94axSF9k+Xgut
 T/O4jAx12BMuCli33oFxEs+v/dBkPm3eg4tVVK/kWj472jxNgCrzRwBAiIRl8IA=
X-Gm-Gg: ASbGncu9o2S6ShiY95ixCUmFo3V9FpMREKxtjFW6NTk8X51DpjeIWQ+eDfs3fJLD6OG
 SlHK3Dq4xUzPatKnLrb3BDxnmK3ctKx0SR+thNX9MGJCfejW0uagOURwPMd4mdvb7mWQ8XKn+3V
 2FnpKLFnYF7Ya+CJ17l/NMk7kIbsbrvIez/shj8UtwydKmxBkFa/brwaPa4zbjvlbXbH/L62Z7M
 VB7rmvhYBStknPNC/L5es4IUvihpUPs9MXLhE9KBSdHB3ygkA+R5sYAlQKGy5cK6muVnrkpH5hU
 3P39ra2A8LApvBsCmIjSNsNf0fuVzTLBhViuXXUPZ6PnyCHLLNC9sNoUCLQHpbA7R2zyn8KQi23
 vDSEu3H7a5BeB
X-Google-Smtp-Source: AGHT+IFJkvXIsGvNNNw50bVU1YJX1MiLCwvlQTtwjxpr+XmZNVwZVOuW+zOluq/G2r/ntU07YMhIJg==
X-Received: by 2002:a5d:588b:0:b0:391:3f64:ecfe with SMTP id
 ffacd0b85a97d-3913f64f09cmr11610190f8f.10.1741709199539; 
 Tue, 11 Mar 2025 09:06:39 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e344esm18533400f8f.73.2025.03.11.09.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 09:06:39 -0700 (PDT)
Message-ID: <f79ea97c-f583-4afd-adc0-f3c411255b49@linaro.org>
Date: Tue, 11 Mar 2025 17:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 05/10] Add Hyper-V Dynamic Memory Protocol driver
 (hv-balloon) base
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <cover.1699279190.git.maciej.szmigiero@oracle.com>
 <0d9e8c0b670b7856d36ed155d43548d2491230e7.1699279190.git.maciej.szmigiero@oracle.com>
 <a140cfae-261e-4d78-985c-efbad93b7a9d@linaro.org>
 <b5325f88-0f04-4989-8b2c-2a23456ae6b9@maciej.szmigiero.name>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b5325f88-0f04-4989-8b2c-2a23456ae6b9@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/3/25 16:11, Maciej S. Szmigiero wrote:
> On 11.03.2025 16:00, Philippe Mathieu-Daudé wrote:
>> Hi Maciej,
>>
>> On 6/11/23 15:20, Maciej S. Szmigiero wrote:
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This driver is like virtio-balloon on steroids: it allows both 
>>> changing the
>>> guest memory allocation via ballooning and (in the next patch) inserting
>>> pieces of extra RAM into it on demand from a provided memory backend.
>>>
>>> The actual resizing is done via ballooning interface (for example, via
>>> the "balloon" HMP command).
>>> This includes resizing the guest past its boot size - that is, hot- 
>>> adding
>>> additional memory in granularity limited only by the guest alignment
>>> requirements, as provided by the next patch.
>>>
>>> In contrast with ACPI DIMM hotplug where one can only request to 
>>> unplug a
>>> whole DIMM stick this driver allows removing memory from guest in single
>>> page (4k) units via ballooning.
>>>
>>> After a VM reboot the guest is back to its original (boot) size.
>>>
>>> In the future, the guest boot memory size might be changed on reboot
>>> instead, taking into account the effective size that VM had before that
>>> reboot (much like Hyper-V does).
>>>
>>> For performance reasons, the guest-released memory is tracked in a few
>>> range trees, as a series of (start, count) ranges.
>>> Each time a new page range is inserted into such tree its neighbors are
>>> checked as candidates for possible merging with it.
>>>
>>> Besides performance reasons, the Dynamic Memory protocol itself uses 
>>> page
>>> ranges as the data structure in its messages, so relevant pages need 
>>> to be
>>> merged into such ranges anyway.
>>>
>>> One has to be careful when tracking the guest-released pages, since the
>>> guest can maliciously report returning pages outside its current address
>>> space, which later clash with the address range of newly added memory.
>>> Similarly, the guest can report freeing the same page twice.
>>>
>>> The above design results in much better ballooning performance than when
>>> using virtio-balloon with the same guest: 230 GB / minute with this 
>>> driver
>>> versus 70 GB / minute with virtio-balloon.
>>>
>>> During a ballooning operation most of time is spent waiting for the 
>>> guest
>>> to come up with newly freed page ranges, processing the received 
>>> ranges on
>>> the host side (in QEMU and KVM) is nearly instantaneous.
>>>
>>> The unballoon operation is also pretty much instantaneous:
>>> thanks to the merging of the ballooned out page ranges 200 GB of 
>>> memory can
>>> be returned to the guest in about 1 second.
>>> With virtio-balloon this operation takes about 2.5 minutes.
>>>
>>> These tests were done against a Windows Server 2019 guest running on a
>>> Xeon E5-2699, after dirtying the whole memory inside guest before each
>>> balloon operation.
>>>
>>> Using a range tree instead of a bitmap to track the removed memory also
>>> means that the solution scales well with the guest size: even a 1 TB 
>>> range
>>> takes just a few bytes of such metadata.
>>>
>>> Since the required GTree operations aren't present in every Glib version
>>> a check for them was added to the meson build script, together with new
>>> "--enable-hv-balloon" and "--disable-hv-balloon" configure arguments.
>>> If these GTree operations are missing in the system's Glib version this
>>> driver will be skipped during QEMU build.
>>>
>>> An optional "status-report=on" device parameter requests memory status
>>> events from the guest (typically sent every second), which allow the 
>>> host
>>> to learn both the guest memory available and the guest memory in use
>>> counts.
>>>
>>> Following commits will add support for their external emission as
>>> "HV_BALLOON_STATUS_REPORT" QMP events.
>>>
>>> The driver is named hv-balloon since the Linux kernel client driver for
>>> the Dynamic Memory Protocol is named as such and to follow the naming
>>> pattern established by the virtio-balloon driver.
>>> The whole protocol runs over Hyper-V VMBus.
>>>
>>> The driver was tested against Windows Server 2012 R2, Windows Server 
>>> 2016
>>> and Windows Server 2019 guests and obeys the guest alignment 
>>> requirements
>>> reported to the host via DM_CAPABILITIES_REPORT message.
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   Kconfig.host                           |    3 +
>>>   hw/hyperv/Kconfig                      |   10 +
>>>   hw/hyperv/hv-balloon-internal.h        |   33 +
>>>   hw/hyperv/hv-balloon-page_range_tree.c |  228 +++++
>>>   hw/hyperv/hv-balloon-page_range_tree.h |  118 +++
>>>   hw/hyperv/hv-balloon.c                 | 1160 ++++++++++++++++++++++++
>>>   hw/hyperv/meson.build                  |    1 +
>>>   hw/hyperv/trace-events                 |   13 +
>>>   include/hw/hyperv/hv-balloon.h         |   18 +
>>>   meson.build                            |   28 +-
>>>   meson_options.txt                      |    2 +
>>>   scripts/meson-buildoptions.sh          |    3 +
>>>   12 files changed, 1616 insertions(+), 1 deletion(-)
>>>   create mode 100644 hw/hyperv/hv-balloon-internal.h
>>>   create mode 100644 hw/hyperv/hv-balloon-page_range_tree.c
>>>   create mode 100644 hw/hyperv/hv-balloon-page_range_tree.h
>>>   create mode 100644 hw/hyperv/hv-balloon.c
>>>   create mode 100644 include/hw/hyperv/hv-balloon.h
>>>
>>> diff --git a/Kconfig.host b/Kconfig.host
>>> index d763d892693c..2ee71578f38f 100644
>>> --- a/Kconfig.host
>>> +++ b/Kconfig.host
>>> @@ -46,3 +46,6 @@ config FUZZ
>>>   config VFIO_USER_SERVER_ALLOWED
>>>       bool
>>>       imply VFIO_USER_SERVER
>>> +
>>> +config HV_BALLOON_POSSIBLE
>>> +    bool
>>> diff --git a/hw/hyperv/Kconfig b/hw/hyperv/Kconfig
>>> index fcf65903bd05..41dd827c841b 100644
>>> --- a/hw/hyperv/Kconfig
>>> +++ b/hw/hyperv/Kconfig
>>> @@ -16,3 +16,13 @@ config SYNDBG
>>>       bool
>>>       default y
>>>       depends on VMBUS
>>> +
>>> +config HV_BALLOON_SUPPORTED
>>> +    bool
>>> +
>>> +config HV_BALLOON
>>> +    bool
>>> +    default y
>>> +    depends on VMBUS
>>> +    depends on HV_BALLOON_POSSIBLE
>>
>> Where is HV_BALLOON_POSSIBLE set?
> 
> In meson.build:
>> host_kconfig = \
> (..)
>>  (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=y'] : []) + \
> 
> Then meson passes this as a command-line parameter
> to scripts/minikconf.py, together with other similar
> config values in host_kconfig.
> 
> See build/meson-logs/meson-log.txt for scripts/minikconf.py
> complete command line.

Right, thank you!

