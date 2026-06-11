Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53FCCD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXYu8-0000HO-WA; Thu, 11 Jun 2026 02:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXYu3-0000GX-7L
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXYu1-0007MW-Hm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781159311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkhP95/9k0BZPj5NL0+y2NP7WD+y+fnS0gQDPmJiIXU=;
 b=Hb0PCHGOv8bXWQJqirBdwYzFEbH4hKUnP3NpuAzOg2wNfawqiBsCHvi+20z7i7JkJytykP
 nfAf3qqJuSx1ZpahNY21YneKmZZPyhDCvXMfZ1Xr4h9JkwgB3IXLzp/Ps7g8osOgCKn/Ub
 bkg1yAS4g5JopcUApy+gKeE5ThacKbQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-lP87QwHhNWaFMKi18LqgyQ-1; Thu, 11 Jun 2026 02:28:29 -0400
X-MC-Unique: lP87QwHhNWaFMKi18LqgyQ-1
X-Mimecast-MFC-AGG-ID: lP87QwHhNWaFMKi18LqgyQ_1781159308
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8428419982eso6610066b3a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781159308; x=1781764108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AkhP95/9k0BZPj5NL0+y2NP7WD+y+fnS0gQDPmJiIXU=;
 b=D0+XUm4iYkjxAPaNCh1nFnb1hmOJQ4noKIN1Gl+EoEerG/nYxz2yyqQTRgWS2PmDJg
 XRNE0Qte4cG7JaTG5AHr5Pl7O7vfdaA7vQwNJozefPPRXMEkAgzqgjivx5SL1anPTI9g
 VrWNW/qsLcqyPeUwpobmiyTEv1F/ILxcr239dacnZ00J/Lgo66SI1A7aSaQ2gVGzvyl8
 Sco2m9Q7xQdk9wjT3pgfA/Smxr5sxOBClbzt/mlN/bA5CLuRaPMnS3FIcw2mWlnAdkRl
 BXOOsjQ5YG29v8hUY/SG2E4qufSDU/sRahwG9qL5+LnHaGWFTeJU7hP2UZhbzMFunJGR
 aPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781159308; x=1781764108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AkhP95/9k0BZPj5NL0+y2NP7WD+y+fnS0gQDPmJiIXU=;
 b=YCg3cEO/g8+gJTu3JZfZUrqXYPSq9PO3ACtePf2S6l+R+dI7gPEKAqLhV7FswxmmeT
 bUEq87frUAczwnTqsYn/2XuUK+ZRP9BQ1bhseYm1zapBo6kZ+z26RZWcCpfpFajLWA/E
 tzjzS1OAiBzXvvgOeY3WFtiMC7lGFV+Ox1e2U8HOhLamgRAQVytyQlykKxeKAA0OILTi
 gZyIcDDGT7S2JjHcWYU79PXSe51Wa91r+i3UBYZZREbsgJ42JI27lNXdBkaWo4WOps8k
 zD2Be/ILn8q/bWR694D8t3h0HeV9bZluWJnSl2W58jyUY8IAbLuP886yj066xEMMJKYy
 aO+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/lafcE0l3YSu/GB3dUn2b5nxPuiqe/JyiSLVbzUp5dB4Y9QM2aJ5gX9vkxAjTo0gpXMYIpIJ2oI3oK@nongnu.org
X-Gm-Message-State: AOJu0YwDM4HYRZ4Dd/kWkZTaOVxilAmY4NAoEl84rrTdJJzZDShC7OXW
 TV+v4WM/nm6rZ8Vfbh2gnO86e5cKy1L9Eg41hFMZr06pwj8tJw6HSaB4WwqzkCT5NMx42aLSlST
 yIU/8ClWd4rwTRCpinI3f5NZfPgxMJE8kEi0OZvK7g8hfrNjPQAB9EEgj
X-Gm-Gg: Acq92OHW261bOaou9Xa8G7uTO34SR2t1OBRkF/9h3EL4ul8x/5eoj317pWWW+6nKvv1
 hOpQWiT3hiWS5elOPvSI9wdiybbkOcp0zxDcer/8q6dfIn0zyk+tMwuvzVqcZz6ykrge+C3bW6y
 zAg1cQgRVuNmp2msptUaU5hoPchRtx4xFc1J/3skS3xBfZ3S/MxkaPUU/+3eN5Y9vVKGGTC6jrK
 g/wqkRdgx1Zo96uYLTrR1d4USNSX9ombTNIwL4gKf8/QYK58AHKogODt992wsBPPXoRLloeZNCj
 ptf2XDGwYtzx5k4TV6HzHc+L1sYZJJGWZHDs1y5MPFMTHJmIdynER833vxqJ3x5yZeYIzcg7+95
 rM2ZpfrMTDTmLAjRRGpct0KVw0ddjiqFBwrr0fhljFGw8l6VGgkZEUX7XOlCZs5PUOgBTGIVc2r
 U=
X-Received: by 2002:a05:6a00:3390:b0:842:5da3:9b84 with SMTP id
 d2e1a72fcca58-84336df7ec5mr1505297b3a.34.1781159308376; 
 Wed, 10 Jun 2026 23:28:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:3390:b0:842:5da3:9b84 with SMTP id
 d2e1a72fcca58-84336df7ec5mr1505242b3a.34.1781159307850; 
 Wed, 10 Jun 2026 23:28:27 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84337b8fd4dsm872509b3a.2.2026.06.10.23.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:28:27 -0700 (PDT)
Message-ID: <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
Date: Thu, 11 Jun 2026 16:28:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Pavel Hrdina <phrdina@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
References: <674d5e21-88fa-4a10-a83c-eb6f7ce7032f@redhat.com>
 <20260610080947-mutt-send-email-mst@kernel.org>
 <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org> <aimEl9QQ_LTRPLtd@x1.local>
 <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260611012217-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Michael,

On 6/11/26 3:31 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2026 at 02:33:05PM +1000, Gavin Shan wrote:
>> On 6/11/26 2:18 AM, Michael S. Tsirkin wrote:
>>> On Wed, Jun 10, 2026 at 11:36:55AM -0400, Peter Xu wrote:
>>>> On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
>>>>> On Wed, Jun 10, 2026 at 11:54:47PM +1000, Gavin Shan wrote:

[...]

>>>>>
>>>>> I do not think it has anything to do with host endian-ness.
>>>>>
>>>>>
>>>>> This is the change that broke it I think?
>>>>>
>>>>>
>>>>> commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
>>>>> Author: Alex Williamson <alex@shazbot.org>
>>>>> Date:   Mon Oct 31 09:53:03 2016 -0600
>>>>>
>>>>>       memory: Don't use memcpy for ram_device regions
>>>>>
>>>>> Maybe Alex has an opinion on what to do.
>>>>
>>>> I can offer one idea here..
>>>>
>>>> IIUC the major issue was vector ops but the mr ops might be too heavy, then
>>>> another way to fix it is in memory API instead of using memcpy()/memmove(),
>>>> we always use a helper (say, memmove_no_vector()) to do the split and
>>>> properly aligned IOs as what ram_device_mem_ops does right now, this should
>>>> only applies to ram_device.
>>>>
>>>> With that, IIUC we can remove the current ram_device_mem_ops, then in
>>>> Gavin's case mmap() will go through and guest will not need to vmexit at
>>>> all.  Best perf, issue solve.
>>>>
>>>> We just need to be careful to trap all possible memcpy()/memmove() used in
>>>> memory core.. if I didn't miss any, IMO below four should needs to be
>>>> replaced by memmove_no_vector():
>>>>
>>>>     flatview_write_continue_step()
>>>>     flatview_read_continue_step()
>>>>     address_space_read()
>>>>     address_space_write_rom()
>>>>
>>>> Thanks,
>>>>
>>>> -- 
>>>> Peter Xu
>>>
>>> First, this is a nice idea.
>>> Second, the ideal thing is still just allowing direct access.
>>> And I think VFIO actually knows it's regular RAM.
>>> So something like the following small patch in linux, maybe?
>>>
>>
>> If I understood everything, Peter's proposal seems to move the logics covered
>> by ram_device_mem_ops to the upper layer.
> 
> 
> I think the basics of Peter's idea are really simple: if guest is doing
> DMA into a region then that access is treating that region as RAM and so
> any vectored etc instructions into it are fine.
> 
> So we can fix specifically DMA into RAM DEVICE to bypass bounce buffering.
> 
> It's at the low memory level, not the upper layer.
> 
> He also apparently feels bounce buffering isn't needed
> generally and can be replaced with memmove_no_vector? And
> somehow virtio DMA can be done without kicking host? I'm not
> sure I understand these parts.
> 

For Peter's idea, I believe there is something I missed. Lets take our specific
case as an example where the DMA request is handled as the following calltrace
indicates.

     virtio_blk_handle_output
       virtio_blk_handle_vq
         virtio_blk_get_request
           virtqueue_pop
             virtqueue_split_pop
               virtqueue_map_desc
                 address_space_map
         virtio_blk_handle_request
           iov_to_buf
             memcpy

In address_space_map(), all RAM DEVICE regions treated as directly accessible
and the buffer (RAMBlock::host + offset) is returned. The buffer is passed on
to virtio_blk_handle_request() and iov_to_buf(), the data is then copied over
using memcpy(), which we're trying to avoid.

Thanks,
Gavin



