Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F29BC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 08:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thPQs-00064W-Rv; Mon, 10 Feb 2025 03:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPQf-00062h-Iw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:46:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1thPQX-00041w-Ru
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 03:46:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739177157;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Yxw9wJ/eCV0W+yEwON0vaPP/3SiyUK8VOJ3gFn3Alc=;
 b=P0XJzBafk+NV5JTwY1MhuqYqYIIO0sYS2keuoZQ9Pa0Y6dv+ALxuqGi7kUiToJK3BKwe9E
 GQwgrXTUqETWB29isuvCOsJykQCKrCgov/sExPVM4mTpXGRrEOn6Z0zX3RKxuChZ1RAWgi
 1UvXzIWMIj8i16bisMW5Ygjux7EbcZ8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-r6Iw3iSRNhKwrPdyGxwVgw-1; Mon, 10 Feb 2025 03:45:56 -0500
X-MC-Unique: r6Iw3iSRNhKwrPdyGxwVgw-1
X-Mimecast-MFC-AGG-ID: r6Iw3iSRNhKwrPdyGxwVgw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dc32f753dso1368014f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 00:45:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739177155; x=1739781955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Yxw9wJ/eCV0W+yEwON0vaPP/3SiyUK8VOJ3gFn3Alc=;
 b=Z+FNsvcNGMvjm71KUN5an6hSMdzwVNfBDm86WCrlPoJmAtgJjpOgh2gXnqdJ/Y3umy
 Qua2X7K7NkzTasUHrLI4PsOALQE9VHAAsCaT9iHAKkQwzS+Vxbxz8WrS7gaW3wfq0tXp
 boDxPLIjRI4RbyfV5u7g1D8KdqQ62qHjONDDQmToia0CSgdVSg0MQ6fyZimjI5rHWZsF
 7n+utcudaxtoHTOB6NqYbdo27nWRaWkaY7ucD9/28aNV2pxrhYoJb+FeQ8GMeIy9Yonh
 YTA0QtSZjL9ePOsM6pzfPj7SU33qMd5cgGkggvTgSLHvfSZNbBrI8ihhnRR6c1Oaz0Cj
 gEwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkVzfsflZRBMCOrh69DE4SjXT9JN8LuiRdFsboCpi/cfbwJLlZNgnib6IHES+PBCXS0hWKdvc4yoc/@nongnu.org
X-Gm-Message-State: AOJu0Yz8n6xYcuLsbKUPY4qno0r5KwRiLA8Zey2Lj1wPBstvcW5ftuK9
 e9XuMnq0jplcc01K6AU2Q3nbxwzuxk38VA4NokZg12B+00Xc1K58hqSRkChIc5raIG9NKvPu8fh
 1at+GySWgaQOp5lldxdCtSEM+uGBEyruxkZvr4dBCRyI9osS8HtcX
X-Gm-Gg: ASbGncvDgUc86Ne/4wowcNYBgk2KcQ84WwfjkwaNDr4wEfjQXR3vUT0VFz62FBqU7SJ
 GImoISfJI3/D7Ychq5ZbvHXk9jIV81CjEo9546LpDlqe6P/YtvfV4xbB9l0oz4WbkB80lgBEKtk
 aqZS/d5wkG+YOz/6stPiCyNiHyEeS6JZ3LdooU8UNGOWqSf7mL4B5ayIB6zKI1M2tNEJLuJVEmy
 V1t49CoIQjsFgUj56QncMljatF1YTZhRiZnRhjIZPN259imZ7rQW27gas2sW/agEQ7atXafLpmG
 6VvyNJvpOJsKS8ZzIyDqsGTcNd3uqJ4hs3fcPenmw7TvuHvTzbfr
X-Received: by 2002:a5d:598f:0:b0:38d:e250:d960 with SMTP id
 ffacd0b85a97d-38de250dc0emr424872f8f.8.1739177155151; 
 Mon, 10 Feb 2025 00:45:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0qpbZ2jFGvlJqCJgVCpnBZanGKNY2oFBXXXRj8l5aLrHhUwpWuIBYgoGcYy+GTfK3bxaJiQ==
X-Received: by 2002:a5d:598f:0:b0:38d:e250:d960 with SMTP id
 ffacd0b85a97d-38de250dc0emr424844f8f.8.1739177154764; 
 Mon, 10 Feb 2025 00:45:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcf35b15bsm8084129f8f.64.2025.02.10.00.45.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 00:45:53 -0800 (PST)
Message-ID: <b08cee40-a726-498e-af28-bf677e41464b@redhat.com>
Date: Mon, 10 Feb 2025 09:45:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix vIOMMU reset order
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, imammedo@redhat.com,
 alex.williamson@redhat.com, clg@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, ddutile@redhat.com
References: <20250206142307.921070-1-eric.auger@redhat.com>
 <Z6Y6sf064FBWT5G1@x1.local>
 <CAFEAcA9ETg2+Xa+e3quJhGG3KsNuH+DW3puuWaJi-q1psUdw6A@mail.gmail.com>
 <Z6ZDf2K0YsqVRE5T@x1.local>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z6ZDf2K0YsqVRE5T@x1.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


Hi,

On 2/7/25 6:31 PM, Peter Xu wrote:
> On Fri, Feb 07, 2025 at 05:06:20PM +0000, Peter Maydell wrote:
>> On Fri, 7 Feb 2025 at 16:54, Peter Xu <peterx@redhat.com> wrote:
>>> On Thu, Feb 06, 2025 at 03:21:51PM +0100, Eric Auger wrote:
>>>> This is a follow-up of Peter's attempt to fix the fact that
>>>> vIOMMUs are likely to be reset before the device they protect:
>>>>
>>>> [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of devices
>>>> https://lore.kernel.org/all/20240117091559.144730-1-peterx@redhat.com/
>>>>
>>>> This is especially observed with virtio devices when a qmp system_reset
>>>> command is sent but also with VFIO devices.
>>>>
>>>> This series puts the vIOMMU reset in the 3-phase exit callback.
>>>>
>>>> This scheme was tested successful with virtio-devices and some
>>>> VFIO devices. Nevertheless not all the topologies have been
>>>> tested yet.
>>> Eric,
>>>
>>> It's great to know that we seem to be able to fix everything in such small
>>> changeset!
>>>
>>> I would like to double check two things with you here:
>>>
>>>   - For VFIO's reset hook, looks like we have landed more changes so that
>>>     vfio's reset function is now a TYPE_LEGACY_RESET, and it always do the
>>>     reset during "hold" phase only (via legacy_reset_hold()).  That part
>>>     will make sure vIOMMU (if switching to exit()-only reset) will order
>>>     properly with VFIO.  Is my understanding correct here?
>> Yes, we now do a reset of the whole system as a three-phase setup,
>> and the old pre-three-phase reset APIs like qemu_register_reset() and
>> device_class_set_legacy_reset() all happen during the "hold" phase.
>>
>>>   - Is it possible if some PCIe devices that will provide its own
>>>     phase.exit(), would it matter on the order of PCIe device's
>>>     phase.exit() and vIOMMU's phase.exit() (if vIOMMUs switch to use
>>>     exit()-only approach like this one)?
>> It's certainly possible for a PCIe device to implement
>> a three-phase reset which does things in the exit phase. However
>> I think I would say that such a device which didn't cancel all
>> outstanding DMA operations during either 'enter' or 'hold'
>> phases would be broken. If it did some other things during
>> the 'exit' phase I don't think the ordering of those vs the
>> iommu 'exit' handling should matter.
> Yes, this sounds fair.
>
>> (To some extent the splitting into three phases is trying
>> to set up a consistent model as outlined in docs/devel/reset.rst
>> and to some extent it's just a convenient way to get a basic
>> "this reset thing I need to do must happen after some other
>> device has done its reset things" which you can achieve
>> by ad-hoc putting them in different phases. Ideally we get
>> mostly the former and a little pragmatic dose of the latter,
>> but the consistent model is not very solidly nailed down
>> so I have a feeling the proportions may not be quite as
>> lopsided as we'd like :-) )
> Yes, it's a good move that we can have other ways to fix all the problems
> without major surgery, and it also looks solid and clean if we have plan to
> fix any outlier PCIe devices.
>
> If there will be a repost after all, not sure if Eric would like to add
> some of above discussions into either some commit messages or cover letter.
> Or some comment in the code might be even better.
Yes I will definitively augment commit msgs/cover letter with all those
considerations. Thank you very much for this rich discussion!

Eric
>
> Thanks!
>


