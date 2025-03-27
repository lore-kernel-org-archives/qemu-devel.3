Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B758C36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 13:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txnY8-0002es-OP; Thu, 27 Mar 2025 09:45:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txnY5-0002eg-Rp
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1txnY3-0007WU-Gb
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 09:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743083130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CU1k3+tK9hxEpxqrwaC64uM7WXJN1gJrXruzIWDb7hU=;
 b=iee+z3ATCYSxQxnKFEOvI+4STLXz+APHcQ8+whIuuOSxFI4imAVhQSqTelxezYv6/vPxLb
 FA3OAjrP4ymyMVKYv4FxjvSHDColWchL5v8SNqxmG+Ej4g6+SA1rmIKYNPFD6BGnPsw1GB
 mAY4javZWqnB+cqKYhY7Dg/rAGc32TI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-lTmvxEwaOs6s_fGcTx9GAA-1; Thu, 27 Mar 2025 09:45:27 -0400
X-MC-Unique: lTmvxEwaOs6s_fGcTx9GAA-1
X-Mimecast-MFC-AGG-ID: lTmvxEwaOs6s_fGcTx9GAA_1743083126
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so522037f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 06:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743083126; x=1743687926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CU1k3+tK9hxEpxqrwaC64uM7WXJN1gJrXruzIWDb7hU=;
 b=pOy7sZY5LnzG7WGdQSe2aiKyYAnWZ7Cw2ZZrxX0vY3vSytdtpqbG73SW+NrS9DInt9
 WfbwwC4pqq3FoFYsBdrlK578fxB5kpy4DeC9PL8KPvmRgNOXBwmikXVYsHL6JzTYEq8c
 PcRVQvWTdkkcQgWsZKEZ9B4tM79wkQ2BIDpRUW+Ah/1UT9SY+JKaQJ0p1wlQAT2kjEvf
 dnDiuuHbUk9jKVWhc+l2X3XL2DfJgLADa4wO1utZvCbkiAsFMAa5v3y01H3CxT5aoseu
 m0I1bqghPLD7p4moYO/a2alFn4FOjECgd20ECY6EiTY4IAxzdT31CZkpWlAPx4gECbrB
 CDVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCeBn23kgxJRNrCPIs26OthBNji2rtgBuzHQGlfpFTcua1BrEzi1G7dUlmfoR16bnogKHF9fyu/T0C@nongnu.org
X-Gm-Message-State: AOJu0YyLn78oCp5nQDmqEQN0LX+PGQE0H30+7szQ+MWJhGF4GdGg+COl
 6ZfK72tqMcCZbrK4g9z1gqa/C0WQRHnzeKduIUX8XkDYYTBKrnd1g8Z7CH9rtKo/DnUPLB9qYnk
 oZl8XYMB0xQKqYM1V0BrHuJ69PVXFd4SUYIku/vnX4z2BRA0h7KjB
X-Gm-Gg: ASbGncvRtuecGQiiUyyqbt/kmYdIur7b6S7Sms7zvW5o58jemG8/G8UalCxbxfClIna
 Y4iK5v8ZV97L1uqS2P4MdBIlIm25M92yWoxhgGbkCRcFDvnLq8Rvhoz2U69eLHRiqeiEFPSLDcH
 gPEf5mwBuUglpVX/JLFZxdxhRHOWFTg+cOGdGqDx3VNc34tIdhtjxvTKDHsFotQyLUQTVhUC4ka
 6RzPHn9OetskBm7fB3AlIboO8ou6Y2h01hMDrGejLHhLCvcgsVNO1eH1msnPwAFMrXN6A+ysxwr
 fwfOQsm6BCOCcL3XY+gdhoBuUjmGFrdFCL9Ewe0Z96Y8jsD8X+eJzY3GSltu8dYzEUPqyaQq3u3
 yjeytExB7N35zRu1nl18Mv3NSp799Th+P0v4pX8ylYD2z
X-Received: by 2002:a05:6000:1847:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-39c0999d45bmr373871f8f.2.1743083126160; 
 Thu, 27 Mar 2025 06:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGScoSqDby/WG0mgv/KqN7n4/JsV+evTmq2WkfJeST18pGndHpzfmNsZtejZVYAO0fBhR6q0Q==
X-Received: by 2002:a05:6000:1847:b0:39b:32fc:c025 with SMTP id
 ffacd0b85a97d-39c0999d45bmr373846f8f.2.1743083125675; 
 Thu, 27 Mar 2025 06:45:25 -0700 (PDT)
Received: from ?IPV6:2003:cf:d74f:9d6b:983d:4148:61b0:27c5?
 (p200300cfd74f9d6b983d414861b027c5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9d6b:983d:4148:61b0:27c5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82e83482sm39444815e9.14.2025.03.27.06.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 06:45:24 -0700 (PDT)
Message-ID: <cfad66d7-1ba1-440e-9a48-4d0c91eb5aa1@redhat.com>
Date: Thu, 27 Mar 2025 14:45:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] fuse: Implement multi-threading
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
 <20250325160655.119407-13-hreitz@redhat.com> <87sen0fj1j.fsf@pond.sub.org>
 <23f3bdae-c48f-4b23-9f6f-389625617a35@redhat.com>
 <874izg81dt.fsf@pond.sub.org>
 <4c2b5ab0-23d9-4ad8-9549-0ee2a9551b26@redhat.com>
 <87tt7eu0nt.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87tt7eu0nt.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27.03.25 13:18, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 26.03.25 12:41, Markus Armbruster wrote:
>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>
>>>> On 26.03.25 06:38, Markus Armbruster wrote:
>>>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>>>
>>>>>> FUSE allows creating multiple request queues by "cloning" /dev/fuse FDs
>>>>>> (via open("/dev/fuse") + ioctl(FUSE_DEV_IOC_CLONE)).
>>>>>>
>>>>>> We can use this to implement multi-threading.
>>>>>>
>>>>>> Note that the interface presented here differs from the multi-queue
>>>>>> interface of virtio-blk: The latter maps virtqueues to iothreads, which
>>>>>> allows processing multiple virtqueues in a single iothread.  The
>>>>>> equivalent (processing multiple FDs in a single iothread) would not make
>>>>>> sense for FUSE because those FDs are used in a round-robin fashion by
>>>>>> the FUSE kernel driver.  Putting two of them into a single iothread will
>>>>>> just create a bottleneck.
>>>>>>
>>>>>> Therefore, all we need is an array of iothreads, and we will create one
>>>>>> "queue" (FD) per thread.
>>>>> [...]
>>>>>
>>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>>> ---
>>>>>>   qapi/block-export.json |   8 +-
>>>>>>   block/export/fuse.c    | 214 +++++++++++++++++++++++++++++++++--------
>>>>>>   2 files changed, 179 insertions(+), 43 deletions(-)
>>>>>>
>>>>>> diff --git a/qapi/block-export.json b/qapi/block-export.json
>>>>>> index c783e01a53..0bdd5992eb 100644
>>>>>> --- a/qapi/block-export.json
>>>>>> +++ b/qapi/block-export.json
>>>>>> @@ -179,12 +179,18 @@
>>>>>>   #     mount the export with allow_other, and if that fails, try again
>>>>>>   #     without.  (since 6.1; default: auto)
>>>>>>   #
>>>>>> +# @iothreads: Enables multi-threading: Handle requests in each of the
>>>>>> +#     given iothreads (instead of the block device's iothread, or the
>>>>>> +#     export's "main" iothread).
>>>>> When does "the block device's iothread" apply, and when "the export's
>>>>> main iothread"?
>>>> Depends on where you set the iothread option.
>>> Assuming QMP users need to know (see right below), can we trust they
>>> understand which one applies when?  If not, can we provide clues?
>> I don’t understand what exactly you mean, but which one applies when has nothing to do with this option, but with the @iothread (and @fixed-iothread) option(s) on BlockExportOptions, which do document this.
> Can you point me to the spot?

Sure: 
https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#object-QMP-block-export.BlockExportOptions 
(iothread and fixed-iothread)

>
>>>>> Is this something the QMP user needs to know?
>>>> I think so, because e.g. if you set iothread on the device and the export, you’ll get a conflict.  But if you set it there and set this option, you won’t.  This option will just override the device/export option.
>>> Do we think the doc comment sufficient for QMP users to figure this out?
>> As for conflict, BlockExportOptions.iothread and BlockExportOptions.fixed-iothread do.
>>
>> As for overriding, I do think so.  Do you not?  I’m always open to suggestions.
>>
>>> If not, can we provide clues?
>>>
>>> In particular, do we think they can go from an export failure to the
>>> setting @iothreads here?  Perhaps the error message will guide them.
>>> What is the message?
>> I don’t understand what failure you mean.
> You wrote "you'll get a conflict".  I assume this manifests as failure
> of a QMP command (let's ignore CLI to keep things simple here).

If you set the @iothread option on both the (guest) device and the 
export (and also @fixed-iothread on the export), then you’ll get an 
error.  Nothing to do with this new @iothreads option here.

> Do we think ordinary users running into that failure can figure out they
> can avoid it by setting @iothreads?

It shouldn’t affect the failure.  Setting @iothread on both device and 
export (with @fixed-iothread) will always cause an error, and should.  
Setting this option is not supposed to “fix” that configuration error.

Theoretically, setting @iothreads here could make it so that 
BlockExportOptions.iothread (and/or fixed-iothread) is ignored, because 
that thread will no longer be used for export-issued I/O; but in 
practice, setting that option (BlockExportOptions.iothread) moves that 
export and the whole BDS tree behind it to that I/O thread, so if you 
haven’t specified an I/O thread on the guest device, the guest device 
will then use that thread.  So making @iothreads silently completely 
ignore BlockExportOptions.iothread may cause surprising behavior.

Maybe we could make setting @iothreads here and the generic 
BlockExportOptions.iothread at the same time an error.  That would save 
us the explanation here.

> What's that failure's error message?

$ echo '{"execute":"qmp_capabilities"}
{"execute":"block-export-add",
  "arguments":{"type":"fuse",
"id":"exp",
"node-name":"null",
"mountpoint":"/tmp/fuse-export",
"iothread":"iothr1",
               "fixed-iothread":true}}' |
build/qemu-system-x86_64 \
     -object iothread,id=iothr0 \
     -object iothread,id=iothr1 \
     -blockdev null-co,node-name=null \
     -device virtio-blk,drive=null,iothread=iothr0 \
     -qmp stdio

{"QMP": {"version": {"qemu": {"micro": 91, "minor": 2, "major": 9}, 
"package": "v10.0.0-rc1"}, "capabilities": ["oob"]}}
{"return": {}}
{"error": {"class": "GenericError", "desc": "Cannot change iothread of 
active block backend"}}

>
>>>>>> +#                                 For this, the FUSE FD is duplicated so
>>>>>> +#     there is one FD per iothread.  (since 10.1)
>>>>> Is the file descriptor duplication something the QMP user needs to know?
>>>> I found this technical detail interesting, i.e. how multiqueue is implemented for FUSE.  Compare virtio devices, for which we make it clear that virtqueues are mapped to I/O threads (not just in documentation, but actually in option naming).  Is it something they must not know?
>>> Interesting to whom?
>>>
>>> Users of QMP?  Then explaining it in the doc comment (and thus the QEMU
>>> QMP Reference Manual) is proper.
>> Yes, QEMU users.  I find this information interesting to users because virtio explains how multiqueue works there (see IOThreadVirtQueueMapping in virtio.json), and this explains that for FUSE exports, there are no virt queues, but requests come from that FD, which explains implicitly why this doesn’t use the IOThreadVirtQueueMapping type.
>>
>> In fact, if anything, I would even expand on the explanation to say that requests are generally distributed in a round-robin fashion across FUSE FDs regardless of where they originate from, contrasting with virtqueues, which are generally tied to vCPUs.
> Up to you.  I lack context to judge.
>
> Making yourself or your fellow experts understand how this works is not
> the same as making users understand how to use it.  Making me understand
> is not the same either, but it might be closer.

This part of the documentation would concern itself less with “how to 
use it”, and more “when to use it”: This round-robin distribution of 
requests across FDs means that even if I/O is run in a single thread, 
using multiple threads for the export may improve performance (as shown 
in the commit message) – in contrast to virtqueue-based systems.  So I 
think that’s important information to users.

Hanna

>
> If this isn't useful to you, let me know, and I'll shut up :)
>
>> Hanna
>>
>>> Just developers?  Then the doc comment is the wrong spot.
>>>
>>> The QEMU QMP Reference Manual is for users of QMP.  It's dense reading.
>>> Information the users are not expected to need / understand makes that
>>> worse.
>>>
>>>> Hanna
>>>>
>>>>>> +#
>>>>>>     # Since: 6.0
>>>>>>     ##
>>>>>>     { 'struct': 'BlockExportOptionsFuse',
>>>>>>       'data': { 'mountpoint': 'str',
>>>>>>                 '*growable': 'bool',
>>>>>> -            '*allow-other': 'FuseExportAllowOther' },
>>>>>> +            '*allow-other': 'FuseExportAllowOther',
>>>>>> +            '*iothreads': ['str'] },
>>>>>>       'if': 'CONFIG_FUSE' }
>>>>>>       ##
>>>>> [...]
>>>>>


