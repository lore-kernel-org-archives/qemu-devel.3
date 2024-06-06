Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D22EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFDks-0000VP-PX; Thu, 06 Jun 2024 10:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sFDkq-0000Uz-2H
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sFDkn-00046J-9U
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717682767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W/Iz5FC0OM2FypjZCTGxeuM//6hXCSVB4USV20GLapo=;
 b=Sr8JgrfOKRzd0aCkoKMLII9gHs1BMDLl0ictRmLOMhwZGEPP2CsTw5B2dCu/KqjO4wvE3R
 +Eh2A8WwDeupR3H6l7RGdp5xG5GbivwYpAWc71n46BU+Lus1ozyTa4Pj24YPqRtAemHEHk
 CGgHPfOD77XNUAxTE2akVp+0Gx51cRw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-PQ74uKxzPo2UTFX13Hv5LA-1; Thu, 06 Jun 2024 10:06:06 -0400
X-MC-Unique: PQ74uKxzPo2UTFX13Hv5LA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2eaa6f40ef2so7849561fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 07:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717682764; x=1718287564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/Iz5FC0OM2FypjZCTGxeuM//6hXCSVB4USV20GLapo=;
 b=mBYyIp2m5MqFC0sKlzE4GJIaaQvYpGrrfWbbpIXRTK5FSKA6e8kaMBfrdQPToDr0AX
 PT6GruwSNHPe3KKAADgqk9z8r825FJJ20QOIziEo+zjEsGUCXWCAWML0+C/OFmSPpX/E
 ALqkCRTybQ4jrRIyVEFhKdYrRlWeR6q4fJi6m6nGFW7GTgdSOw2D/GENpvchbfR9XWcO
 cFvbVaHvdSTsENAYQSHHSDSr70v4kYIFvSHen6z5Vc3vVfT9uP5llODJUVbioRCEZqui
 jPHZfsefmYwZ4AmLBLbb6uTMvTv4n4ADRhzr4NINdPW5HSkLVgaBPV0aKkXrFGyhFsZ9
 shMQ==
X-Gm-Message-State: AOJu0YzHbaoaJ8CBB9vsO9NkW+8Ykt9shGhYcjHR4VQ8vc42GD/clmtE
 m2mD9WMHL6Zey7wPLc2Fv3+N0x0Xc6UFBzRpx67BalJ0857rfw+Tn/OQUPo+fRep7mP36nYjWiX
 aTfnwe5zTOoBOp0VvZvsmDMtOQT4ZR6AGBBJB35pJXDrn1WFOyMxl
X-Received: by 2002:a2e:8415:0:b0:2ea:c0ad:f974 with SMTP id
 38308e7fff4ca-2eac7a95b1emr36427001fa.36.1717682763848; 
 Thu, 06 Jun 2024 07:06:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErovnroyRrAyOttgt8z8DMfIN6moTgk2krpF8xg3+3Kl7kcYDTJ4Z3++nIrVzWRdek7AyoHA==
X-Received: by 2002:a2e:8415:0:b0:2ea:c0ad:f974 with SMTP id
 38308e7fff4ca-2eac7a95b1emr36426881fa.36.1717682763498; 
 Thu, 06 Jun 2024 07:06:03 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-82.retail.telecomitalia.it.
 [82.57.51.82]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae13fff4sm1159888a12.53.2024.06.06.07.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 07:06:02 -0700 (PDT)
Date: Thu, 6 Jun 2024 16:06:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qapi: clarify that the default is backend dependent
Message-ID: <qeya66xsj6rs2p4qn4wuzhpyzzalkl7hs7kr2tj3b6wscawizn@ugmj6dfzevo2>
References: <20240523133302.103858-1-sgarzare@redhat.com>
 <877cf61ib1.fsf@pond.sub.org>
 <a5rtqdvsqevk2pobqipmfiv5eazr5koffe3tn372i7bojpshhg@q7uxoverycvu>
 <875xuo69g6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <875xuo69g6.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 04, 2024 at 04:58:49PM GMT, Markus Armbruster wrote:
>Stefano Garzarella <sgarzare@redhat.com> writes:
>
>> On Mon, Jun 03, 2024 at 11:34:10AM GMT, Markus Armbruster wrote:
>>>Stefano Garzarella <sgarzare@redhat.com> writes:
>>>
>>>> The default value of the @share option of the @MemoryBackendProperties
>>>> eally depends on the backend type, so let's document it explicitly and
>>>> add the default value where it was missing.
>>>>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> ---
>>>> I followed how we document @share in memfd and epc, but I don't like it
>>>> very much, I just can't think of a better way, so if you have a suggestion
>>>> I can change them in all of them.
>>>>
>>>> Thanks,
>>>> Stefano
>>>> ---
>>>>  qapi/qom.json | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>> index 38dde6d785..8463bd32a2 100644
>>>> --- a/qapi/qom.json
>>>> +++ b/qapi/qom.json
>>>> @@ -600,7 +600,7 @@
>>>   ##
>>>   # @MemoryBackendProperties:
>>>   #
>>>   # Properties for objects of classes derived from memory-backend.
>>>   #
>>>
>>>[...]
>>>
>>>>  #     preallocation threads (default: none) (since 7.2)
>>>>  #
>>>>  # @share: if false, the memory is private to QEMU; if true, it is
>>>> -#     shared (default: false)
>>>> +#     shared (default depends on the backend type)
>>>
>>>Note for later: the backends are the branches of ObjectOptions that use
>>>MemoryBackendProperties as branch type or as base of their branch type.
>>>These are
>>>
>>>    memory-backend-epc (uses MemoryBackendEpcProperties)
>>>    memory-backend-file (uses MemoryBackendFileProperties)
>>>    memory-backend-memfd (uses MemoryBackendMemfdProperties)
>>>    memory-backend-ram (uses MemoryBackendProperties)
>>>
>>>>  #
>>>>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>>>>  #     (default: true) (since 6.1)
>>>> @@ -639,6 +639,8 @@
>>>>  #
>>>>  # Properties for memory-backend-file objects.
>>>>  #
>>>> +# The @share boolean option is false by default with file.
>>>> +#
>>>>  # @align: the base address alignment when QEMU mmap(2)s @mem-path.
>>>>  #     Some backend stores specified by @mem-path require an alignment
>>>>  #     different than the default one used by QEMU, e.g. the device DAX
>>>
>>>As stated in the commit message, this matches existing documentation in
>>>memory-backend-epc
>>>
>>>   # The @share boolean option is true by default with epc
>>>
>>>and memory-backend-memfd
>>>
>>>   # The @share boolean option is true by default with memfd.
>>>
>>>I think "with FOO" could be clearer.  Perhaps something like "with
>>>backend 'memory-backend-FOO'.
>>
>> Ack, I'll do.
>>
>>>
>>>However, even with your patch, we're still missing memory-backend-ram.
>>>I can see two solutions:
>>>
>>>1. Create MemoryBackendRamProperties just to have a place for
>>>documenting @share's default.
>>>
>>>2. Document @share's default right where it's defined, roughly like
>>>this:
>>>
>>>   # @share: if false, the memory is private to QEMU; if true, it is
>>>   #     shared (default false for backends memory-backend-file and
>>>   #     memory-backend-ram, true for backends memory-backend-epc and
>>>   #     memory-backend-memfd)
>>>
>>>CON: we need to remember to update this whenever we add another backend.
>>>
>>>PRO: generated documentation is better, in my opinion.
>>>
>>>Thoughts?
>>>
>>
>> Maybe option 2 is slightly better and it's also clearer how to document the default for other backends.
>>
>> When I added a new backend, it was not clear to me how to define the default for an inherited parameter.
>>
>> I would go with 2 if you agree.
>
>I actually like 2 better :)
>

Yeah, I'll do it ;-)

Thanks,
Stefano


