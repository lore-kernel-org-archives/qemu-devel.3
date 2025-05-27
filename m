Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B8EC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJs5f-0008Rn-I3; Tue, 27 May 2025 07:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJs5S-0008RF-Sy
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:03:15 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uJs5P-0005Yc-8h
 for qemu-devel@nongnu.org; Tue, 27 May 2025 07:03:14 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7376e311086so2933901b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 04:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748343788; x=1748948588;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dhBAGDy5ge1xAxqK0/JlkV+qIGKgfocICelKGqAniqY=;
 b=jOSqBZrDEAoVn/WJifrrHEa9AXJWvq7pndDqSd3NX+CQ07X0Q+nJhHljEc7L4ocLaU
 qfGjEAk3MJhgDN/C1RQcVAtGxm74MqaqOM/ejiRQA3BgK9ZoNjhh7IR3CDaLBbAIPdoN
 EXjC5LbPxVSO82f0yq1IkuvD5s+/EprSKxLKpI9r8s0ygylsKLRxqhyk6Ndn0rX9e+F2
 /SWADGhFnPI21jM9Uz/RfdbXJ/tM9JquKZ/ovs+Ul37ixwuw5I2bGlwblnf0PkzFp0ot
 6imhevoP5vUvY9mXCCcCutxsovkjTWrEalVxozRTcGB6l+arI68H0XQWB+Efa+M2RXcw
 lEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748343788; x=1748948588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dhBAGDy5ge1xAxqK0/JlkV+qIGKgfocICelKGqAniqY=;
 b=JpZ7ct0Wdn0cyQMirvIyZMklGU0KusPedltKW8u1ir9qTMugPNtm3twOas3aaCV4uw
 ziR5v/U/smlE9k14RWF982TIMGpn8yKRlWGM5qYsZX0rfuPeCzck1/I+wgSLWsEOb5A6
 7zn2DjXN0xJWULXhXROtvJZiu+S2Q6gJ6251+fchzOl8kdiF9LVRKfaHsqpxziYoDuwa
 U2EJmBx9Ef8Mqout+JKBfZHu3lxpuFQVLgghV9qUnT9oo/7qycZp/n4bf9YauU/xhTIo
 71f5z53tbO2D2kmXllosWrqkVTB2D6mcGitqzFNRb3Do7QfE1GFM89+Dh6QLU5hMN8g8
 reiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULlhJ2uXUlDQSNMyrOCfWQIreZmmJX+Ic/EItnnhDH4NqxyMLkBHjaq8rPk/0zv5pIGZfzQy277Trw@nongnu.org
X-Gm-Message-State: AOJu0YxVCZOYDz24bpoLVvf11MMxCLX4jNU8kYoDx3iedjOEpY+7dyYf
 TGnyOgLfcRX4JFh7bf5VsmyfhIoUw76lSuP8tcntC1C17dBxgzD45N+LjYVCXA83dR8=
X-Gm-Gg: ASbGncsVTN1dYomV4WHnSQ1xOjWBXA6I9gutPQE3sumHNJRxQsmAIUaNgtRb0KvoL+P
 tA75Q21aPeaVNGHSyceK9rS7Nsh/KHAq8i93PQSf9MPWRlk9LyAc7QbZTRvaSXbkbNtIlawghlT
 BDBPLhhwEZI8DtI0FN04PCBXzXFsVjW2HOz/UAYfJrzfT8zwmwwHAB6lB+oDXkwjdPlo4zKfdl/
 UXI1WrBPTacD9e8zM1L4VUyVNORJg30QbSsG6O114m0/u1UUXSQDn9AgXJ8c3ypmTGXTy5sKU5z
 fFNQFU34RVabtkxpU6Vcbyqx1+HTDSt4gMmD9IFkMzSFBMAWxltEcHt9Z3OGmsX4lUWu57cGqWU
 XjExXBYgoNcRT5mgaZLLQwL9TO3+0YA==
X-Google-Smtp-Source: AGHT+IHs5Us98HvdCfta1J00ev5HbDgyhC3CIgEoXZgBQq+zJM0yMXjmnz92SvIF/1THi05DsRUk6Q==
X-Received: by 2002:a05:6a00:21c2:b0:73e:5aa:4f64 with SMTP id
 d2e1a72fcca58-745fde9f3b7mr17828762b3a.10.1748343788221; 
 Tue, 27 May 2025 04:03:08 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:4952:3c52:120a:27e9?
 ([2400:4050:b783:b00:4952:3c52:120a:27e9])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2c47f887efsm581227a12.47.2025.05.27.04.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 04:03:07 -0700 (PDT)
Message-ID: <e9285843-0487-4754-a348-34f1a852b24c@daynix.com>
Date: Tue, 27 May 2025 20:03:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] virtio-gpu: fix hang under TCG when unmapping
 blob
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-13-alex.bennee@linaro.org>
 <4d300cca-3ac2-4072-a35c-0b6aef970b26@daynix.com>
 <87bjrl87p5.fsf@draig.linaro.org>
 <83945c43-bfb2-4469-90bd-e3a7c2ca5d89@daynix.com>
 <CAAjaMXZ8acKBSGHvcQOcOnzBDCjFU1SOjse7pHtHWxNeREc2gg@mail.gmail.com>
 <199e7486-7d05-459b-ad51-cb9b130f299f@daynix.com>
 <875xht805w.fsf@draig.linaro.org>
 <d5c429eb-d583-4b9d-85c1-b0636e789e9c@daynix.com>
 <871psanzbl.fsf@draig.linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <871psanzbl.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/27 19:05, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2025/05/22 18:28, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2025/05/22 16:31, Manos Pitsidianakis wrote:
>>>>> On Thu, May 22, 2025 at 10:03 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2025/05/22 15:45, Alex Bennée wrote:
>>>>>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>>>>>
>>>>>>>> On 2025/05/22 1:42, Alex Bennée wrote:
>>>>>>>>> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> <snip>
>>>>>> In such a case, a bug should be fixed minimizing the regression and the
>>>>>> documentation of the regression should be left in the code.
>>>>>>
>>>>>> In particular, this patch can cause use-after-free whether TCG is used
>>>>>> or not. Instead, I suggest to avoid freeing memory regions at all on
>>>>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>>>>> least and the other accelerators will be unaffected.
>>>>>>
>>>>>> Regards,
>>>>>> Akihiko Odaki
>>>>> We tested this fix with ASAN and didn't see anything. Do you have a
>>>>> test case in mind that can reproduce this use-after-free? It'd help
>>>>> make a certain decision on whether to drop this patch or not. I'm not
>>>>> doubting that this can cause a use-after-free by the way, it's just
>>>>> that it is hypothetical only. If it causes a use-after-free for sure
>>>>> we should definitely drop it.
>>>>
>>>> No, I don't have a test case and it should rarely occur. More
>>>> concretely, a UAF occurs if the guest accesses the memory region while
>>>> trying to unmap it. It is just a theory indeed, but the theory says
>>>> the UAF is possible.
>>> I have a test case this fixes which I think trumps a theoretical UAF
>>> without a test case.
>>> Why would the guest attempt to access after triggering the free
>>> itself?
>>> Wouldn't it be correct to fault the guest for violating its own memory
>>> safety rules?
>>
>> docs/devel/secure-coding-practices.rst says "Unexpected accesses must
>> not cause memory corruption or leaks in QEMU".
> 
> Agreed.
> 
>> I'm not completely sure whether it is safe without concurrent accesses
>> either. In particular, KVM does not immediately update the guest
>> memory mapping, so it may result in a time window where the guest
>> memory is mapped to an unmapped host memory region, and I suspect that
>> could cause a problem. That also motivates limiting the scope of the
>> change to TCG.
> 
> Surely it does:
> 
>          memory_region_set_enabled(mr, false);
>          memory_region_del_subregion(&b->hostmem, mr);
> 
> will trigger a rebuilding of the flatview - so after the memory region
> is deleted any guest access should trigger a fault to the guest. Only
> then do we unparent the memory region and finish the clean-up.

I wrongly assumed it waits for RCU, but I found it is not true.

It is still not true that any guest access will trigger a fault to the 
guest. QEMU's internal AddressSpace keeps the old FlatView until the RCU 
changes, and some device may still have a DMA mapping.

> 
> I don't think we want to have different paths for KVM and TCG here as it
> will further complicate already complicated code.

Complexity is not a problem here. Any concurrent code has complexity 
needed for correctness and reliability. We should add complexity if 
needed for reliablity; otherwise, we should remove it (even if it's 
already simple).

> 
>>>>>> Instead, I suggest to avoid freeing memory regions at all on
>>>>>> TCG. It will surely leak memory, but won't result in use-after-free at
>>>>>> least and the other accelerators will be unaffected.
>>>>> Leaking memory for blob objects is also not ideal, since they are
>>>>> frequently allocated. It's memory-safe but the leak can accumulate
>>>>> over time.
>>>>>
>>>>
>>>> Memory safety and leak free cannot be compatible unless RCU is fixed.
>>>> We need to choose either of them.
>>> How can the guest access something that is now unmapped? The RCU
>>> should
>>> only run after the flatview has been updated.
>>
>> This patch bypasses RCU. That's why it solves the hang even though the
>> RCU itself is not fixed.
>>
>> Let me summarize the theory and the actual behavior below:
>>
>> The theory is that RCU satisfies the common requirement of concurrent
>> algorithms. More concretely:
>> 1) It is race-free; for RCU, it means it prevents use-after-free.
>> 2) It does not prevent forward progress.
>>
>> The patch message suggests 2) is not satisfied. A proper fix would be
>> to change RCU to satisfy 2).
> 
> Its mutually incompatible with virglrenderer - we have to block all
> commands until the virgl resource is freed and we can't do that until
> the memory region is unplugged.
> 
> So yes we do bypass RCU for this but by explicitly un-parenting the
> resource once the mapping has been removed.

The problem is that RCU doesn't free the memory region when all commands 
are blocked.

If we fix RCU, RCU will free the memory region, the virgl resource will 
be freed then, and the commands will be unblocked.

> 
>> However, this patch workarounds the problem by circumventing RCU,
>> which solves 2) but it regresses 1).
> 
> I'm still not seeing how this happens and without a test case to
> demonstrate it happening I can't hold this patch in limbo forever.

Not a test case that runs on the guest, but adding the following change 
to QEMU will demonstrate the issue:

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 145a0b387956..c97cd2dfd7b3 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -182,7 +182,11 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
          /* memory region owns self res->mr object and frees it by 
itself */
          memory_region_set_enabled(mr, false);
          memory_region_del_subregion(&b->hostmem, mr);
+        memory_region_ref(OBJECT(mr));
+        int k = b->renderer_blocked;
          object_unparent(OBJECT(mr));
+        assert(k == b->renderer_blocked);
+        memory_region_unref(OBJECT(mr));
      }

      return 0;

memory_region_ref() and memory_region_unref() emulates the begin and end 
of a DMA operation on mr, respectively. In a real world scenario, 
address_space_map() and address_space_unmap() call these functions.

If the code is correct, object_unparent() should not free the memory 
region while the DMA operation is ongoing, so the renderer will be kept 
blocked. assert(k == b->renderer_blocked) checks that.

My proposal is to limit the impact of the regression as possible as we 
can and to document it, not to postpone the solution until figuring out 
the problem in RCU.

> 
>> My suggestion is to document and to limit the impact of 1) by:
>> a) Limiting the scope of the change to TCG.
>> b) Not freeing memory regions, which will prevent use-after-free while
>> leaking memory.
>>
>> Manos said b) can be problematic because mappings are frequently
>> created. Whether b) makes sense or not depends on the probability and
>> impact of UAF and memory leak
> 
> Not freeing memory regions would lead to a DoS attack instead. I don't
> think we can just accumulate region like that.

UAF also results in DoS, and it can have a bigger consequence due to 
memory corruption. Memory leak is usually safer than UAF.

The question is whether memory leak causes a practical problem; it makes 
sense to opt to UAF if the accumulation happens too quickly; we at least 
know that UAF is rare.

Regards,
Akihiko Odaki

