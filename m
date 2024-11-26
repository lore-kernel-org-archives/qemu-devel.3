Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8846D3B9A4
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 15:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFxhL-0000S3-7z; Tue, 26 Nov 2024 10:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFxhI-0000Re-Op
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:41:52 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weichenforschung@gmail.com>)
 id 1tFxhG-0002FU-GK
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 10:41:52 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-724fee568aaso2879666b3a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 07:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732635709; x=1733240509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9K0alLy9fzccwp+8DAJhz4jpwmITbDygZxJTdid8B3Q=;
 b=jezIIZ8L7uuesoyyjpDV3ltgVSSTOI7bg6UYlmKbT37DLWDTytimJxLnqYmI/onZWL
 h/0c5xk0X/c+iRNI2cobVE1P8S03rbQd2jMp3NW4YSwt+ryU/bzquCE13iihKSeRBu08
 uHY2F4CcXMUf/YBXNET6yqjm5sdBEll9vWzglM75qWvqeZoJPOpfM0N3hnYuLL+I+oqw
 N8nGsk8R3Q/TOH7bxgGow4AVa/F+VxQ2SKo2xENoby1jh0VLFQRavuZBRljTplsm1CLD
 uHq27hh0YMlk/TBarR/uTprZhpB03wJO3Va0CKcZWYyPZnejZ3RpEteZmdf+uxcNcaar
 5rCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635709; x=1733240509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9K0alLy9fzccwp+8DAJhz4jpwmITbDygZxJTdid8B3Q=;
 b=GbxrkeQZcjskVhHFZDeRtXDuaCWSAVxqmo5OQ2ntBI26bNMeoiQezoe7CPYPgZCATF
 djY6QO82bh09EA9OUqYhFwbzsfT8fNmZqmpJWL+QiLofQ5Yre5x8xYErGGY20VLM4o5V
 WQeuhwqJ2VkxCJ/m9n4Vwjr6WzzOFN1Xd1eHHn/DIvBIlZmTrAZVK9tP/x7Szi25Iz3Q
 GRscW8MY3AbaZSbVUjgeyhHG8T8qpxFfa+6Wn/nsM2Rl/f4OuaptCgi2ZWq7evVmBd9h
 55QLzili6VueUywvm7gwi4SR6w3jDOoES3gOECst0d+AOnOGTMbNWise1veXUuwNpIWS
 X/jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAyOp+XHt7PyjSwj/5hd0UjsBRgUniAvPFHifTdN2gB7qKWm1CMG8u9nD36s8AK3UV2nVPds15nEQQ@nongnu.org
X-Gm-Message-State: AOJu0YwwtXYWbwGtBRRYfKNuxF4SCTcujwoSXxnMwUm2PhFAe/kZQxLI
 wDIGRTi2NXx31jYLCStV3MgQC2jV4cAsuu9j043zJq7zP3LPf4Va
X-Gm-Gg: ASbGncsuAP6iLPbhOIUAuFDjpzACe+88uhep3DTrAzjz2GEBFj6kyAdvO5vFSwjzyW5
 yvtWPLMfRIWveqlgpOVQHjlJIOdTyrsDglmbOZZkROA1Yzfb0QPvfLu/HTtFZkjVm3bOsjehL8i
 9hgNGujSDGOmglLEL72708ozPHYOV0P2uU+gacJZRBI8Y56RqQmSeqXubr6yKCoAXS/FN0SH4fd
 sHiDeMN/obfDhkTD3Zybmc0Tjbrc+353qvJpwytmRQlV5s5dmYxqj4oyrsEUtKV
X-Google-Smtp-Source: AGHT+IH6ctZwNhWGbtwCA0tdrymfLRQguhQ+YTv0ADZwQd+V7FFctjgH2Q6mqdyeEYYBHkY064GIZw==
X-Received: by 2002:a17:903:22ca:b0:212:6573:a275 with SMTP id
 d9443c01a7336-2129f611537mr251421115ad.46.1732635708656; 
 Tue, 26 Nov 2024 07:41:48 -0800 (PST)
Received: from [192.168.5.232] ([212.107.30.68])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dba353bsm85975185ad.104.2024.11.26.07.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 07:41:48 -0800 (PST)
Message-ID: <0a3b9e0b-6725-44f8-8599-ae868a3fc864@gmail.com>
Date: Tue, 26 Nov 2024 23:41:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/virtio/virtio-mem: Prohibit unplugging when size <=
 requested_size
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, yuval.yarom@rub.de, genkin@gatech.edu,
 Zhi Zhang <zzhangphd@gmail.com>
References: <20241126080213.248-1-weichenforschung@gmail.com>
 <2ac194a7-9790-4aa7-bb41-65f8bb21f616@redhat.com>
 <f02565f6-c584-44d0-944f-26c062cc2be9@gmail.com>
 <553cf07a-a603-402d-8e86-b4ada42a2dcd@redhat.com>
 <79c4ed2c-2ac8-43b5-ad90-2b91f6e7fd8f@redhat.com>
 <d75f20d9-dd4a-4439-a261-612766b7cfba@redhat.com>
From: Wei Chen <weichenforschung@gmail.com>
In-Reply-To: <d75f20d9-dd4a-4439-a261-612766b7cfba@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=weichenforschung@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Thanks for the information! I will try to come up with V2 that does not
impact virtio-mem's functionality.


Best regards,
Wei Chen

On 2024/11/26 23:14, David Hildenbrand wrote:
> On 26.11.24 16:08, David Hildenbrand wrote:
>> On 26.11.24 15:46, David Hildenbrand wrote:
>>> On 26.11.24 15:20, Wei Chen wrote:
>>>>     > Please provide more information how this is supposed to work
>>>>
>>>
>>> Thanks for the information. A lot of what you wrote belongs into the
>>> patch description. Especially, that this might currently only be
>>> relevant with device passthrough + viommu.
>>>
>>>> We initially discovered that virtio-mem could be used by a malicious
>>>> agent to trigger the Rowhammer vulnerability and further achieve a VM
>>>> escape.
>>>>
>>>> Simply speaking, Rowhammer is a DRAM vulnerability where frequent 
>>>> access
>>>> to a memory location might cause voltage leakage to adjacent 
>>>> locations,
>>>> effectively flipping bits in these locations. In other words, with
>>>> Rowhammer, an adversary can modify the data stored in the memory.
>>>>
>>>> For a complete attack, an adversary needs to: a) determine which parts
>>>> of the memory are prone to bit flips, b) trick the system to store
>>>> important data on those parts of memory and c) trigger bit flips to
>>>> tamper important data.
>>>>
>>>> Now, for an attacker who only has access to their VM but not to the
>>>> hypervisor, one important challenge among the three is b), i.e., to 
>>>> give
>>>> back the memory they determine as vulnerable to the hypervisor. 
>>>> This is
>>>> where the pitfall for virtio-mem lies: the attacker can modify the
>>>> virtio-mem driver in the VM's kernel and unplug memory proactively.
>>>
>>> But b), as you write, is not only about giving back that memory to the
>>> hypervisor. How can you be sure (IOW trigger) that the system will 
>>> store
>>> "important data" like EPTs?
>>>
>>>>
>>>> The current impl of virtio-mem in qemu does not check if it is 
>>>> valid for
>>>> the VM to unplug memory. Therefore, as is proved by our experiments,
>>>> this method works in practice.
>>>>
>>>>     > whether this is a purely theoretical case, and how relevant 
>>>> this is in
>>>>     > practice.
>>>>
>>>> In our design, on a host machine equipped with certain Intel 
>>>> processors
>>>> and inside a VM that a) has a passed-through PCI device, b) has a 
>>>> vIOMMU
>>>> and c) has a virtio-mem device, an attacker can force the EPT to use
>>>> pages that are prone to Rowhammer bit flips and thus modify the EPT to
>>>> gain read and write privileges to an arbitrary memory location.
>>>>
>>>> Our efforts involved conducting end-to-end attacks on two separate
>>>> machines with the Core i3-10100 and the Xeon E2124 processors
>>>> respectively, and has achieved successful VM escapes.
>>>
>>> Out of curiosity, are newer CPUs no longer affected?
>>>
>>>>
>>>>     > Further, what about virtio-balloon, which does not even support
>>>>     > rejecting requests?
>>>>
>>>> virtio-balloon does not work with device passthrough currently, so we
>>>> have yet to produce a feasible attack with it.
>>>
>>> So is one magic bit really that for your experiments, one needs a 
>>> viommu?
>>>
>>> The only mentioning of rohammer+memory ballooning I found is:
>>> https://www.whonix.org/pipermail/whonix-devel/2016-September/000746.html 
>>>
>>>
>>>>
>>>>     > I recall that that behavior was desired once the driver would 
>>>> support
>>>>     > de-fragmenting unplugged memory blocks.
>>>>
>>>> By "that behavior" do you mean to unplug memory when size <=
>>>> requested_size? I am not sure how that is to be implemented.
>>>
>>> To defragment, the idea was to unplug one additional block, so we can
>>> plug another block.
>>>
>>>>
>>>>     > Note that VIRTIO_MEM_REQ_UNPLUG_ALL would still always be 
>>>> allowed
>>>>
>>>> That is true, but the attacker will want the capability to release a
>>>> specific sub-block.
>>>
>>> So it won't be sufficient to have a single sub-block plugged and then
>>> trigger VIRTIO_MEM_REQ_UNPLUG_ALL?
>>>
>>>>
>>>> In fact, a sub-block is still somewhat coarse, because most likely 
>>>> there
>>>> is only one page in a sub-block that contains potential bit flips. 
>>>> When
>>>> the attacker spawns EPTEs, they have to spawn enough to make sure the
>>>> target page is used to store the EPTEs.
>>>>
>>>> A 2MB sub-block can store 2MB/4KB*512=262,144 EPTEs, equating to at
>>>> least 1GB of memory. In other words, the attack program exhausts 
>>>> 1GB of
>>>> memory just for the possibility that KVM uses the target page to store
>>>> EPTEs.
>>>
>>> Ah, that makes sense.
>>>
>>> Can you compress what you wrote into the patch description? Further, I
>>> assume we want to add a Fixes: tag and Cc: QEMU Stable
>>> <qemu-stable@nongnu.org>
>>
>> I just recalled another scenario where we unplug memory: see
>> virtio_mem_cleanup_pending_mb() in the Linux driver as one example.
>>
>> We first plug memory, then add the memory to Linux. If that adding
>> fails, we unplug the memory again.
>>
>> So this change can turn the virtio_mem driver in Linux non-functional,
>> unfortunately.
>
> Further, the Linux driver does not expect a NACK on unplug requests, 
> see virtio_mem_send_unplug_request().
>
> So this change won't work.
>
> We could return VIRTIO_MEM_RESP_BUSY, but to handle what I raised 
> above, we would still have to make it work every now and then 
> (ratelimit), to not break the driver.
>
> The alternative is to delay freeing of the memory in case we run into 
> this condition. Hm ...
>

