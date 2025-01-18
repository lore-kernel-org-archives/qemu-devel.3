Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193F6C02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 10:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZ5sO-0007HE-MI; Sat, 18 Jan 2025 05:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5sA-0007GK-AT
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:16:14 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tZ5s6-0000fe-Gp
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 05:16:10 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21675fd60feso65671135ad.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 02:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737195365; x=1737800165;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lv1ypNPQkhX5bqVknkTujMduz3WKKylFiTA1mr2JVmo=;
 b=QiT6NoiR2q1P0U8zwhn1qaLF8vNklUzF9YH8Sax227pkFtxN5Raj6eF49DfOYnyaa8
 EnhVmjdk8oMDowKx2EXq+PaAtTUj6m3VRQwwsHCuOivPAoOPr91YlyHXAX76EQ7ton2/
 AfPeK66H/WKnKoREhag8ngtzB6yiRhUOEAFKsE+jzDE758g2REhcYHpAmfU6up9kKrJ3
 q/cef1BkpyU9XcLRdpGUiGQfaWvF6enRQJ07iZhgfF2zAzdO67+szmxF3IvcCMb1rJEM
 lcYpixjlCMMMMWZPD8kGUvAfuL/eO3S0BgSGxY4oL55HAsd7t72P715pTI5w2DEnF0c6
 fGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737195365; x=1737800165;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lv1ypNPQkhX5bqVknkTujMduz3WKKylFiTA1mr2JVmo=;
 b=UdI+Jydi8r85MkgGiEaByejaY1qDccnk1OCtmX/b4XG+/nkVA56YG9ZY48rfqzYB3S
 wto/m5FPWjkgcGHuVRu4F6ot3EiHdeAechdc39Bxo4gRQQIVKdDVE8ykGpPr6DKCyzaq
 w65nEoq6OHGIG1v6i0ozfkuREvxANy8BXdzlxdcRQvcle36+I3PJTuOwnGf6GKGH9l0H
 XbLo2PsUJW8sl+bTJKcZm/Dh9ssVOJj8/QBpdScMPWaQmatZUE/N3ggjqImtVJJUxh6U
 e91wGIB0dEy9ZKsb1Thq1GhmMIA9RcPE+Svb8r7typO0l7UXw5W9jrwu4/WSuQNz1rMc
 2Mkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZb7fWWR2U04wbzforsCqNEcJs4ZEKeV3T7VTJx+CEHN2PIn98ebpX6Lvy2W7l6JS74TzDNcbztajB@nongnu.org
X-Gm-Message-State: AOJu0YzeFWGA1L1nR7kAx1krbMIyNHPSLHz8reICyI5qX83l2bPN9MXA
 1KeRVSsuB01cN2R3s4wNQ0nM311l51hlzuhX+RG9u9zLYqgYbrnLVGNfMVreU8A=
X-Gm-Gg: ASbGnctOkOhqv+XD8MqnO5iL9dNmlu4eRpoPfAByVKtxd4BYOcWurALy+w3uXNS7Khk
 htAfvgyep849+jIx8eYt4gLyUUCKbSg+G0222nndtvX0BdEznFO7nRJcOZhs4Cb6WwIjb8AWbUt
 fx1GEZCpZyOlVNryGeWpfaFcw75EJAK5bZngndmOfNHthNuDIrM961XpXuyib6Lu2eHMhCNw/vT
 SpuEagk35aMhdISrTgqBiiCPwoBdQiRo08RmWOJW/V8i0FIrXfWL04PwrXeGzNa4ZmtNHUd3V+N
 608=
X-Google-Smtp-Source: AGHT+IEkUrAaI3nw44wXSgalqfx0CnVQNg5yj1AjByx0uvcqH6agT2Q8DkLQ2jug9w3RU5ai080d9w==
X-Received: by 2002:a05:6a20:4303:b0:1e1:9fef:e975 with SMTP id
 adf61e73a8af0-1eb215815a0mr7962363637.26.1737195365125; 
 Sat, 18 Jan 2025 02:16:05 -0800 (PST)
Received: from [10.4.77.176] ([118.103.63.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab81336esm3414992b3a.38.2025.01.18.02.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2025 02:16:04 -0800 (PST)
Message-ID: <d8ab7a88-cf34-4989-909a-bf5fad502f15@daynix.com>
Date: Sat, 18 Jan 2025 19:15:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, devel@daynix.com
References: <Z4aYpo0VEgaQedKp@x1n>
 <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com> <Z4e7gFSqdhcmJPYb@x1n>
 <dbf863f8-6174-4c37-9553-a2d94f06de00@daynix.com> <Z4fW_rI7Mfrtc1Fg@x1n>
 <af018f8a-ce00-4ce2-9fe9-b6ba3f97bfa1@daynix.com> <Z4fezdR1ApN8ZLTS@x1n>
 <99016684-b5f9-446c-b85f-0dc21d1edae6@daynix.com> <Z4kYxLsIbzq7jWzz@x1n>
 <627beb0f-e6f7-4733-997b-038b70195485@daynix.com> <Z4qXfgJMAySLFeOm@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4qXfgJMAySLFeOm@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/01/18 2:46, Peter Xu wrote:
> On Fri, Jan 17, 2025 at 03:24:34PM +0900, Akihiko Odaki wrote:
>> On 2025/01/16 23:33, Peter Xu wrote:
>>> On Thu, Jan 16, 2025 at 02:37:38PM +0900, Akihiko Odaki wrote:
>>>> On 2025/01/16 1:14, Peter Xu wrote:
>>>>> On Thu, Jan 16, 2025 at 12:52:56AM +0900, Akihiko Odaki wrote:
>>>>>> Functionally, the ordering of container/subregion finalization matters if
>>>>>> some device tries to a container during finalization. In such a case,
>>>>>                          |
>>>>>                          ^ something is missing here, feel free to complete this.
>>>>
>>>> Oops, I meant: functionally, the ordering of container/subregion
>>>> finalization matters if some device tries to use a container during
>>>> finalization.
>>>
>>> This is true, though if we keep the concept of "all the MRs share the same
>>> lifecycle of the owner" idea, another fix of such is simply moving the
>>> container access before any detachment of MRs.
>>>
>>>>
>>>>>
>>>>>> removing subregions from the container at random timing can result in an
>>>>>> unexpected behavior. There is little chance to have such a scenario but we
>>>>>> should stay the safe side if possible.
>>>>>
>>>>> It sounds like a future feature, and I'm not sure we'll get there, so I
>>>>> don't worry that much.  Keeping refcount core idea simple is still very
>>>>> attractive to me.  I still prefer we have complete MR refcounting iff when
>>>>> necessary.  It's also possible it'll never happen to QEMU.
>>>>>
>>>>
>>>> It's not just about the future but also about compatibility with the current
>>>> device implementations. I will not be surprised even if the random ordering
>>>> of subregion finalization breaks one of dozens of devices we already have.
>>>> We should pay attention the details as we are touching the core
>>>> infrastructure.
>>>
>>> Yes, if we can find any such example that we must follow the order of MR
>>> destruction, I think that could justify your approach will be required but
>>> not optional.  It's just that per my understanding there should be none,
>>> and even if there're very few outliers, it can still be trivially fixed as
>>> mentioned above.
>>
>> It can be fixed but that means we need auditing the code of devices or wait
>> until we get a bug report.
> 
> We'd better have a solid example.
> 
> And for this specific question, IIUC we can have such problem even if
> internal-ref start to use MR refcounts.
> 
> It's because we have a not very straightforward way of finalize() an
> object, which is freeing all properties before its own finalize()..
> 
> static void object_finalize(void *data)
> {
>      ...
>      object_property_del_all(obj);
>      object_deinit(obj, ti);
>      ...
> }
> 
> I think it used to be the other way round (which will be easier to
> understand to me..), but changed after 76a6e1cc7cc.  It could boil down to
> two dependencies: (1) children's unparent() callback wanting to have the
> parent being present and valid, and (2) parent's finalize() callback
> wanting to have all children being present and valid.  I guess we chose (1)
> as of now.
> 
> So I suppose it means even with your patch, it won't help either as long as
> MRs are properties, and they can already all be gone in a device finalize()
> even with your new patch.

The owner can object_ref() to keep the memory region alive.

 > >  From that POV, qdev unrealize() could be a good place for such 
cleanups
> while making sure all properties are present.> >>
>>>
>>> My gut feeling is when we need serious MR refcounting (I'd expect due to
>>> the current heavy code base it might be easier to start a new project if
>>> that's required.. that's why I was thinking maybe it will not happen.. but
>>> if it will..), we'll do more than your change, and that also means
>>> memory_region_ref() must start to refcount MRs, because a serious MR
>>> separate refcounting should mean MR can go on the fly before the owner.
>>
>> Actually there is one example: virtio_gpu_virgl_map_resource_blob() in
>> hw/display/virtio-gpu-virgl.c creates a MR that can be removed before the
>> device. To make this possible, it specifies MRs themselves as their and let
>> them refcount without help of the device.
> 
> .. I am definitely surprised that we have code that assigns obj->parent to
> be itself.
> 
> Putting the self parenting aside.. and to the topic: I don't think this is
> an example for internal-MR use case?
> 
> When the owner is itself, then it's not sharing the owner of the parent MR
> (which is b->hostmem in this case, which should probably be owned by
> VirtIOGPU object instead).  So IIUC no matter which way we choose on the
> current discussion, it won't affect the result.
> 
> Not to mention, the MRs are always properly detached always when the
> resource is unmapped:
> 
> virtio_gpu_virgl_unmap_resource_blob():
>          /* memory region owns self res->mr object and frees it by itself */
>          memory_region_set_enabled(mr, false);
>          memory_region_del_subregion(&b->hostmem, mr);
> 
> So from that POV it's a very good citizen.. it doesn't need anything to be
> auto detached.
> 
> Below can be off topic, but since we're discussing this use case..
> 
> My gut feeling is that it can cause trouble at some point having MR itself
> as parent.
> 
> For example, I will not be surprised that some day QMP command
> qom-list-properties provide a --deep pararmeter, then this will hang that
> command trying to look at child forever in a loop.
> 
> It can easily break in other ways too, e.g. when we add an assertion
> anywhere for "obj->parent != obj" (which should really make sense.. from a
> object model POV), or when we want to take a ref to parent (for obj->parent
> reference) then it'll be a "real" circular reference, comparing to what
> we're discussing on auto-detach so far (which is IIUC a pretty "weak"
> circular ref; IOW, if del_subregion is always properly done, this patch not
> needed).
> 
> Meanwhile the other free() overwrite:
> 
>      OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
> 
> I suppose it can be error prone too whenever we want to provide a common
> free() for MRs and this one can be easily overlooked..
> 
> I'm not familiar with GPU stuff, but reading it closer I do feel like it's
> kind of a slight abuse on all above..
> 
> If to stick with "owner shares the same lifecycle for its MRs" idea and fix
> all above, IMHO we could make virtio_gpu_virgl_hostmem_region to be a QOM
> object, then it can be a proper parent for the MR.
> 


