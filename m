Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF39C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 10:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMrT-0003Dp-Fd; Fri, 09 Aug 2024 06:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1scMrQ-0003Co-WB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:28:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1scMrN-0008KM-Ei
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:28:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so15869535ad.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 03:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723199316; x=1723804116;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZiCTyhyOBF2ClKBX22VFDlLE95cVdhGPduTYb53dq8Y=;
 b=lh3o6GZCfCG/FJTbKTaIDuVP87gKtgZ3ygpX2H07/GQXvJSZndTAVuNaJZyy11mnPO
 Sc601CrpOGenlT0+EK4L23SjLK0WCVjwN8BTNVuHy08c4JDgKayN0Mp5V09VQoXpZO+Y
 8TTQUTUNDG/TTi7DW7qq07yv+4QRai0aS5adT5T19CSFJ7OGkQYi79b0cWE6yo0IqhaQ
 LEqGK+o9x1FDbUyOuMMpsKlqGtgsqiGI5du3efTt4XdVjBqSHDWaSjrjByHGFeRJ8gqQ
 ynykwBkfaaPunc3NIGiwUIH6qeLziDrrsSeVRL793RUdDC9Q9btxH1gqWTpmWztp3cAQ
 6DaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723199316; x=1723804116;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiCTyhyOBF2ClKBX22VFDlLE95cVdhGPduTYb53dq8Y=;
 b=ZP5Qlvwb9PNx5FMg4VI4ZLN8eD9C62hL9wzONLgD69eqkQJ4+2BmT8RSa8bD6vUDpl
 8zeuh6l0Ganz0WMT9znAADzOjjiRi5EnlPyQtsh5Gggjcyu6k/j3kN4wYIBmNWD5g7eM
 SUiPaB9OMbWcu5V7AK1/yamVY6zFS8v7griV985YNR7h1y0L0oYPfhTqcOYsLG3d9m3j
 57ZxDNkLj5tkypVWV6DUOFEfxmjJk23gjbeprSGlKMGAvdPZuOlnqD6kpAgycYbJq9aO
 +vIIZkdpTCbyhPw1Pong9bzObWXaeOrIih5noBRnkajepB6raEiP/9Uyz8H95XiZv1bh
 rZww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU31chRLqcXTo6lBL7i3xrNlvMQtJbwjlkixrL9Wzd28MQs+nAWaSKxxOKijkhaMg8xbEWw1k84lSS3AEkHwBl8gOGF2eU=
X-Gm-Message-State: AOJu0YwAdp5EZ0d9bh3S3vMkjGQnd0mrJ7ttLVkoKGh5Cy/943pAF2kQ
 wRIkFvFtKHU4mYeSOwWWhks7cTSPjjjhiIpEnZfMu9LaH0DtMw7s6J8bsi8M1vA=
X-Google-Smtp-Source: AGHT+IGBWpQZ6mrMjuFB+1wXji8kz17AIkgyp3KQE6xoYb61pujLPlyOZye+CgQzmYyTAHw0iakX5w==
X-Received: by 2002:a17:902:ef51:b0:1fa:fc74:4c04 with SMTP id
 d9443c01a7336-200ae5a414emr10238095ad.35.1723199315720; 
 Fri, 09 Aug 2024 03:28:35 -0700 (PDT)
Received: from [157.82.207.214] ([157.82.207.214])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f6d80csm139194455ad.119.2024.08.09.03.28.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 03:28:35 -0700 (PDT)
Message-ID: <807be9a6-7d71-4f3e-9f77-f8befff4aae0@daynix.com>
Date: Fri, 9 Aug 2024 19:28:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com> <Zqz1vvYqRuIAPnod@x1n>
 <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com> <Zq0IrhV-DgStpJtk@x1n>
 <8ad96f43-83ae-49ae-abc1-1e17ee15f24d@daynix.com> <Zq99NcMkDMkDKBLv@x1n>
 <d94e8fda-23bb-4905-b656-3e1cb247079d@daynix.com> <ZrKKl2uxzGfl6SEA@x1n>
 <830e10d4-594b-40ec-a405-0f04988b7d4d@daynix.com> <ZrTOZbYisrcljFU4@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZrTOZbYisrcljFU4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/08/08 22:55, Peter Xu wrote:
> On Thu, Aug 08, 2024 at 08:43:22PM +0900, Akihiko Odaki wrote:
>> On 2024/08/07 5:41, Peter Xu wrote:
>>> On Mon, Aug 05, 2024 at 04:27:43PM +0900, Akihiko Odaki wrote:
>>>> On 2024/08/04 22:08, Peter Xu wrote:
>>>>> On Sun, Aug 04, 2024 at 03:49:45PM +0900, Akihiko Odaki wrote:
>>>>>> On 2024/08/03 1:26, Peter Xu wrote:
>>>>>>> On Sat, Aug 03, 2024 at 12:54:51AM +0900, Akihiko Odaki wrote:
>>>>>>>>>>> I'm not sure if I read it right.  Perhaps you meant something more generic
>>>>>>>>>>> than -platform but similar?
>>>>>>>>>>>
>>>>>>>>>>> For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
>>>>>>>>>>> "perf" or "compat", while by default to "compat"?
>>>>>>>>>>
>>>>>>>>>> "perf" would cover 4) and "compat" will cover 1). However neither of them
>>>>>>>>>> will cover 2) because an enum is not enough to know about all hosts. I
>>>>>>>>>> presented a design that will cover 2) in:
>>>>>>>>>> https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
>>>>>>>>>
>>>>>>>>> "-merge-platform" shouldn't be a QEMU parameter, but should be something
>>>>>>>>> separate.
>>>>>>>>
>>>>>>>> Do you mean merging platform dumps should be done with another command? I
>>>>>>>> think we will want to know the QOM tree is in use when implementing
>>>>>>>> -merge-platform. For example, you cannot define a "platform" when e.g., you
>>>>>>>> don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) is
>>>>>>>> connected to virtio-net devices. Of course we can include those information
>>>>>>>> in dumps, but we don't do so for VMState.
>>>>>>>
>>>>>>> What I was thinking is the generated platform dump shouldn't care about
>>>>>>> what is used as backend: it should try to probe whatever is specified in
>>>>>>> the qemu cmdline, and it's the user's job to make sure the exact same qemu
>>>>>>> cmdline is used in other hosts to dump this information.
>>>>>>>
>>>>>>> IOW, the dump will only contain the information that was based on the qemu
>>>>>>> cmdline.  E.g., if it doesn't include virtio device at all, and if we only
>>>>>>> support such dump for virtio, it should dump nothing.
>>>>>>>
>>>>>>> Then the -merge-platform will expect all dumps to look the same too,
>>>>>>> merging them with AND on each field.
>>>>>>
>>>>>> I think we will still need the QOM tree in that case. I think the platform
>>>>>> information will look somewhat similar to VMState, which requires the QOM
>>>>>> tree to interpret.
>>>>>
>>>>> Ah yes, I assume you meant when multiple devices can report different thing
>>>>> even if with the same frontend / device type.  QOM should work, or anything
>>>>> that can identify a device, e.g. with id / instance_id attached along with
>>>>> the device class.
>>>>>
>>>>> One thing that I still don't know how it works is how it interacts with new
>>>>> hosts being added.
>>>>>
>>>>> This idea is based on the fact that the cluster is known before starting
>>>>> any VM.  However in reality I think it can happen when VMs started with a
>>>>> small cluster but then cluster extended, when the -merge-platform has been
>>>>> done on the smaller set.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> Said that, I actually am still not clear on how / whether it should work at
>>>>>>> last.  At least my previous concern (1) didn't has a good answer yet, on
>>>>>>> what we do when profile collisions with qemu cmdlines.  So far I actually
>>>>>>> still think it more straightforward that in migration we handshake on these
>>>>>>> capabilities if possible.
>>>>>>>
>>>>>>> And that's why I was thinking (where I totally agree with you on this) that
>>>>>>> whether we should settle a short term plan first to be on the safe side
>>>>>>> that we start with migration always being compatible, then we figure the
>>>>>>> other approach.  That seems easier to me, and it's also a matter of whether
>>>>>>> we want to do something for 9.1, or leaving that for 9.2 for USO*.
>>>>>>
>>>>>> I suggest disabling all offload features of virtio-net with 9.2.
>>>>>>
>>>>>> I want to keep things consistent so I want to disable all at once. This
>>>>>> change will be very uncomfortable for us, who are implementing offload
>>>>>> features, but I hope it will motivate us to implement a proper solution.
>>>>>>
>>>>>> That said, it will be surely a breaking change so we should wait for 9.1
>>>>>> before making such a change.
>>>>>
>>>>> Personally I don't worry too much on other offload bits besides USO* so far
>>>>> if we have them ON for longer time.  My wish was that they're old good
>>>>> kernel features mostly supported everywhere who runs QEMU, then we're good.
>>>>
>>>> Unfortunately, we cannot expect everyone runs Linux, and the offload
>>>> features are provided by Linux. However, QEMU can run on other platforms,
>>>> and offload features may be provided by vhost-user or vhost-vdpa.
>>>
>>> I see.  I am not familiar with the status quo there, so I'll leave that to
>>> you and other experts that know better on this..
>>>
>>> Personally I do care more on Linux, as that's what we ship within RH..
>>>
>>>>
>>>>>
>>>>> And I definitely worry about future offload features, or any feature that
>>>>> may probe host like this and auto-OFF: I hope we can do them on the safe
>>>>> side starting from day1.
>>>>>
>>>>> So I don't know whether we should do that to USO* only or all.  But I agree
>>>>> with you that'll definitely be cleaner.
>>>>>
>>>>> On the details of how to turn them off properly..  Taking an example if we
>>>>> want to turn off all the offload features by default (or simply we replace
>>>>> that with USO-only)..
>>>>>
>>>>> Upstream machine type is flexible to all kinds of kernels, so we may not
>>>>> want to regress anyone using an existing machine type even on perf,
>>>>> especially if we want to turn off all.
>>>>>
>>>>> In that case we may need one more knob (I'm assuming this is virtio-net
>>>>> specific issue, but maybe not; using it as an example) to make sure the old
>>>>> machine types perfs as well, with:
>>>>>
>>>>>      - x-virtio-net-offload-enforce
>>>>>
>>>>>        When set, the offload features with value ON are enforced, so when
>>>>>        the host doesn't support a offload feature it will fail to boot,
>>>>>        showing the error that specific offload feature is not supported by the
>>>>>        virtio backend.
>>>>>
>>>>>        When clear, the offload features with value ON are not enforced, so
>>>>>        these features can be automatically turned OFF when it's detected the
>>>>>        backend doesn't support them.  This may bring best perf but has the
>>>>>        risk of breaking migration.
>>>>
>>>> "[PATCH v3 0/5] virtio-net: Convert feature properties to OnOffAuto" adds
>>>> "x-force-features-auto" compatibility property to virtio-net for this
>>>> purpose:
>>>> https://lore.kernel.org/r/20240714-auto-v3-0-e27401aabab3@daynix.com
>>>
>>> Ah ok.  But note that there's still a slight difference: we need to avoid
>>> AUTO being an option, at all, IMHO.
>>>
>>> It's about making qemu cmdline the ABI: when with AUTO it's still possible
>>> the user uses AUTO on both sides, then ABI may not be guaranteed.
>>>
>>> AUTO would be fine if: (1) the property doesn't affect guest ABI, or (2)
>>> the AUTO bit will always generate the same thing on both hosts.  However
>>> USO* isn't such case.. so the AUTO option is IMHO not wanted.
>>>
>>> What I mentioned above "x-virtio-net-offload-enforce" shouldn't add
>>> anything new to "uso"; it still can only be ON/OFF.  However it should
>>> affect "flip that to OFF automatically" or "fail the boot" behavior on
>>> missing features.
>>
>> My rationale for the OnOffAuto change is that "flipping ON to OFF
>> automatically" is more confusing than making users specify AUTO to allow
>> QEMU making the feature OFF. "ON" will always make the boot fail.
>>
>> The ABI guarantee will be gone anyway if x-virtio-net-offload-enforce=off.
>> AUTO is no different in that sense.
> 
> Hmm yes; I wished we can have device properties that user can never
> specify, but only set from internals.  It's just that applying a compat
> property so far require a generic device property.  Or say, it'll be nice
> that compat property can tweak a class variable too then no property to
> introduce.
> 
> We could even add a migration blocker for x-virtio-net-offload-enforce=ON,
> but again it could be too aggresive.  I think it might be better we bet
> nobody will even know there's the parameter, so it won't be used in manual
> setup.  OTOH, "guest_uso4" can be too easiy to find there's the AUTO
> option: I normally use ",guest_uso4=?" to just dump the possible values.

We can detect and reject AUTO when cross-migrate=on if desired, but I'm 
not sure it's worthwhile.

Regards,
Akihiko Odaki

