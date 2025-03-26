Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB012C3600B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 13:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txRF4-0005ax-TT; Wed, 26 Mar 2025 09:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txRF2-0005SY-Ub
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:56:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txRF0-0002uv-Vi
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 09:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742997381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntKBuwLluRd1GODXXuiZBVYB3OiYHGCJibTrg5e+xjc=;
 b=Ayv/+m1avJOqm62WJXlIKo+NjubC4jcKnZDwiM+ghWm4c2AX9rUZWp30FVqpwPRqcuzmVC
 IylXa02BIQYmXqpetYtXW5ug8DcMKl7l6OU+aerekGwlZW/FpU8KfsNAVJYdTCyNsZFgmL
 zZfIL2VeEX8+6e1TFOkTW1Ft53dlpGQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-7URq6yYZMi-44mNG9_ZTfQ-1; Wed, 26 Mar 2025 09:56:19 -0400
X-MC-Unique: 7URq6yYZMi-44mNG9_ZTfQ-1
X-Mimecast-MFC-AGG-ID: 7URq6yYZMi-44mNG9_ZTfQ_1742997379
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cfda30a3cso4710105e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 06:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742997378; x=1743602178;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntKBuwLluRd1GODXXuiZBVYB3OiYHGCJibTrg5e+xjc=;
 b=uCWOSRkfyOHx8iyqvWxSvn+J/CosATF5qMbglkqPheU90NjS8GUMmKVJ8KNC6xVA03
 rIVzOAdG1jyB0M68VNgXAYYEc8lxSAmUt4bUTocD0TXbHpQxSbAoGh3oNSBQTqGtqUwq
 tRnlNSlM7/FtrSfzT+/7dd6IRP6AqJzaOGd1ib0wCdpblqy2HDqCQoV8qNZTHSdTocl8
 ZwZVEPZehSn5fiXlHzO81+lWDT9kP9kviNjkoNhBmmdUNN2WPzj7us3l7BFAqh9vinAY
 pONsfYGpSi6KF+7uah5QH8TYX2ULFqPQqRCLJIKhyOHJYedsxJphlNhJVwv7B5Omu5sR
 5hsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFWDDROkdBG8OzYbwvvysVQWyi7ohrKFkL+GD6rTNM0RI4vKMgTpunNKMC7K+0cRa5vmeMlwXSH2hr@nongnu.org
X-Gm-Message-State: AOJu0YznhI6FvapR32udOlP89JeZnIk9tukOOpWcIszWHaZhwfWYmqTb
 ck6C+rlVu3w4rDCPFYLZYnhQC0KE8rbOq5gDYvv1eF6tp02j2rvAQJy3R64kILzxooQfY44OalR
 wGvggpzkJq2HZwpo6V2dNAwzLSrJbGyeUnKuOlDDcuPZ5WYQQmEyO
X-Gm-Gg: ASbGnctsz5ui11uTrmEXnjFE4XRf+KrkGHaUSBVoXWJFEfE3Lt8Qq84nFIGxjrDTwsx
 Pi8TiOaZpEXpdyUM9vBqk6hY1k4IXDzDIVqxjXJtot32FJAnoNbjD8geCkN+kziwJH5H2/C/IsA
 ZsBHIgvTZS4BWLAZ0LwdEU036mgUBgehCE9ls7FvUpTTiyefanaTrWDi9UKlPBfgnbYdRnDVryU
 MNOP92G22GVLLUrLHOslyZ8bCjuiYmVDpMvEPBUJx36IODjcB4Dwj6fhXTjkT6XFHSYts3WkNst
 efQS6NRv8mQmmJ4+J6V5KXxsTj9kt2z+D2qW5O8a3NEzMeJFAC2/53UzU9EGRCKLzb/LxtwyguR
 uk8v27YJSyMeaZhoPdi0EawjLxv//HI3a+FWfn/0etu6J
X-Received: by 2002:a05:600c:1f92:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43d50a3c79fmr186481725e9.30.1742997378545; 
 Wed, 26 Mar 2025 06:56:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaLZvmCDcmI94XM3NVHV0PfuyDrYOTZysTtJO62EKvLvHxlcGC0TZKfxHclq6zxHtzneGaGA==
X-Received: by 2002:a05:600c:1f92:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-43d50a3c79fmr186481415e9.30.1742997378098; 
 Wed, 26 Mar 2025 06:56:18 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d8b:10ff:7fdc:f53a:734d?
 (p200300cfd74f9d8b10ff7fdcf53a734d.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d8b:10ff:7fdc:f53a:734d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6767sm17290437f8f.66.2025.03.26.06.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 06:56:16 -0700 (PDT)
Message-ID: <4c2b5ab0-23d9-4ad8-9549-0ee2a9551b26@redhat.com>
Date: Wed, 26 Mar 2025 14:56:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com> <87sen0fj1j.fsf@pond.sub.org>
 <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
 <874izg81dt.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <874izg81dt.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26.03.25 12:41, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 26.03.25 06:38, Markus Armbruster wrote:
>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>
>>>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>>>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>>>
>>>> We can use this to implement multi-threading.
>>>>
>>>> Note that the interface presented here differs from the multi-queue
>>>> interface of virtio-blk: The latter maps virtqueues to iothreads, which
>>>> allows processing multiple virtqueues in a single iothread.  The
>>>> equivalent (processing multiple FDs in a single iothread) would not make
>>>> sense for FUSE because those FDs are used in a round-robin fashion by
>>>> the FUSE kernel driver.  Putting two of them into a single iothread will
>>>> just create a bottleneck.
>>>>
>>>> Therefore, all we need is an array of iothreads, and we will create one
>>>> "queue" (FD) per thread.
>>> [...]
>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    qapi/block-export.json |   8 +-
>>>>    block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>>>>    2 files changed, 179 insertions(+), 43 deletions(-)
>>>>
>>>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>>>> index c783e01a53..0bdd5992eb 100644
>>>> --- a/qapi/block-export.json
>>>> +++ b/qapi/block-export.json
>>>> @@ -179,12 +179,18 @@
>>>>    #     mount the export with allow_other, and if that fails, try again
>>>>    #     without.  (since 6.1; default: auto)
>>>>    #
>>>> +# @iothreads: Enables multi-threading: Handle requests in each of the
>>>> +#     given iothreads (instead of the block device's iothread, or the
>>>> +#     export's "main" iothread).
>>> When does "the block device's iothread" apply, and when "the export's
>>> main iothread"?
>> Depends on where you set the iothread option.
> Assuming QMP users need to know (see right below), can we trust they
> understand which one applies when?  If not, can we provide clues?

I don’t understand what exactly you mean, but which one applies when has 
nothing to do with this option, but with the @iothread (and 
@fixed-iothread) option(s) on BlockExportOptions, which do document this.

>
>>> Is this something the QMP user needs to know?
>> I think so, because e.g. if you set iothread on the device and the export, you’ll get a conflict.  But if you set it there and set this option, you won’t.  This option will just override the device/export option.
> Do we think the doc comment sufficient for QMP users to figure this out?

As for conflict, BlockExportOptions.iothread and 
BlockExportOptions.fixed-iothread do.

As for overriding, I do think so.  Do you not?  I’m always open to 
suggestions.

> If not, can we provide clues?
>
> In particular, do we think they can go from an export failure to the
> setting @iothreads here?  Perhaps the error message will guide them.
> What is the message?

I don’t understand what failure you mean.

>
>>>> +#                                 For this, the FUSE FD is duplicated so
>>>> +#     there is one FD per iothread.  (since 10.1)
>>> Is the file descriptor duplication something the QMP user needs to know?
>> I found this technical detail interesting, i.e. how multiqueue is implemented for FUSE.  Compare virtio devices, for which we make it clear that virtqueues are mapped to I/O threads (not just in documentation, but actually in option naming).  Is it something they must not know?
> Interesting to whom?
>
> Users of QMP?  Then explaining it in the doc comment (and thus the QEMU
> QMP Reference Manual) is proper.

Yes, QEMU users.  I find this information interesting to users because 
virtio explains how multiqueue works there (see IOThreadVirtQueueMapping 
in virtio.json), and this explains that for FUSE exports, there are no 
virt queues, but requests come from that FD, which explains implicitly 
why this doesn’t use the IOThreadVirtQueueMapping type.

In fact, if anything, I would even expand on the explanation to say that 
requests are generally distributed in a round-robin fashion across FUSE 
FDs regardless of where they originate from, contrasting with 
virtqueues, which are generally tied to vCPUs.

Hanna

>
> Just developers?  Then the doc comment is the wrong spot.
>
> The QEMU QMP Reference Manual is for users of QMP.  It's dense reading.
> Information the users are not expected to need / understand makes that
> worse.
>
>> Hanna
>>
>>>> +#
>>>>    # Since: 6.0
>>>>    ##
>>>>    { 'struct': 'BlockExportOptionsFuse',
>>>>      'data': { 'mountpoint': 'str',
>>>>                '*growable': 'bool',
>>>> -            '*allow-other': 'FuseExportAllowOther' },
>>>> +            '*allow-other': 'FuseExportAllowOther',
>>>> +            '*iothreads': ['str'] },
>>>>      'if': 'CONFIG_FUSE' }
>>>>      ##
>>> [...]
>>>


