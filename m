Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EBCCD98E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 02:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZg7e-0004nP-3Z; Tue, 16 Jun 2026 22:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZg7a-0004l7-3E
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 22:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZg7W-0000e8-VN
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 22:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781663713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0YsPLZDqOSWTOIwzN42DKqcLgXKaDpe37nvfBLI+I3Y=;
 b=M6Q+RoSLTRGE1gYTVVJabIWIGP2eRqk4Uul7DPHyoz11Xf9L5EF+IDyDz5JTWh9AxzaLcy
 JSWtjuOAKk/KVNMUnHvY55iZv8Jmy82oGRt9GSKz3NIZJoGuZfSd8opHzS26/kHieDrdAF
 9OjOhwtB9xvH9861g+aOBZLYG9DAq88=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-pAOAonfUNiSqHf7jFn3TBQ-1; Tue, 16 Jun 2026 22:35:11 -0400
X-MC-Unique: pAOAonfUNiSqHf7jFn3TBQ-1
X-Mimecast-MFC-AGG-ID: pAOAonfUNiSqHf7jFn3TBQ_1781663710
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c2b64850easo50585535ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 19:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781663710; x=1782268510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0YsPLZDqOSWTOIwzN42DKqcLgXKaDpe37nvfBLI+I3Y=;
 b=TWjCm2hz1CRDW96IQdd1nYSLOe1j5WdSfLfRuakP4XtXDwlC1FZJyCUgPCzFH1P/as
 aoveyGmqdVzljF9diRfqtnK0tYdzV+6xUh4ENyNOuBINlReFtdKEpuWqrycnV8L1BuDg
 blcdo8QIwwpo/MtLrRpOXGJOGs9uv5Df8ZFZXwo/vFRSxlMy0xeocJA3i90qY2acL/sE
 oS46v/iIAKU5u/iT6b6dZ6fH2tmI+394vyt1I+xawLU7I5aeTCAvYZk/Q3n5m2lI6T5N
 7uDZTthZpAiDWLd62CtgHcubDCEci/532qlvYCEnXsaudPu5k+2JekVPHuXQh4VskH7S
 vAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781663710; x=1782268510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0YsPLZDqOSWTOIwzN42DKqcLgXKaDpe37nvfBLI+I3Y=;
 b=Tt9wt2oGvEkIw35XUBwnkVyTTmd6+qPNh0etktDjmijNSW+3DqykbPivbaqz7KMP65
 66oMdeX2YMWsEL/W4Gmnb7b6hmZhoOIeTCiDKRIiheRY7OQhZ3c0ovqTgVA0+oR30XW1
 hmq3IKkaL7aJRDCrWeItN4H3qzcZGLobRRrM5ZhhoOmGFiDhQslo6zkcNaIy+Gtc+pPT
 IBBMjRmKcjJJ1pS44c0PBuiym8M12ua4ziqcNsO+C3DS+NHw1eA10E4CNPFn00k452B+
 Fjft3D428bkTuZvdBiFy426hYENxXN7zcwhghlA1bIbap5yoQzNsN0spYOPLbkrvzyXX
 dEWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9f5QUIy1893xD4caf4dbotEKR/n8etwSlYgCqYGGIV/x2H0Py8TyGSYwn0RkkXj2vQO+bu3MDrrQUE@nongnu.org
X-Gm-Message-State: AOJu0YzKqy5yRPo6q1DubbsK8ObH8BBTxa6ugKqLRog0q952MDKWzZ7E
 xq5sVGHj4rvTckPs6dnA/j7+Pu636tmsuxSXjFgh+DevRdEHkK3gHIpuKbe/hny01Td9Pr9jxk9
 ALYEM1HRgu7OV3AKaCiF08eJufMHILnS7dC+Dmgi3Rg6EGKOBpj+G/hw4
X-Gm-Gg: AfdE7cmhd9JmS8/fqGbJN7zEOGZ3AYAH41M0luNoeNH9YpLp9tXkO4cDMfAVg3UahFs
 QOBa0oyLWIjOEqqc/s0UwYWIl4HK1uu8eWQnOXa2mykuEPQ5rtGTaTk0irsg8kuD3mboiPeh45Y
 ZPpdosN2wi1/9eCa/uMoI/S8PAUY9aKj8iLMxewHw4irhfBQz+OvEd6X0U4M29poY6BQG/fH2+e
 FewHMleI2BCVTO986zjUAaQ3p/gYm2axOFxCe5xW/N7KGDWd+vpmOxjb1IlIt0aYyjfNyLf/oGC
 PyIsoAXs1RLwvlKKsdinFlWh5jUJdcicPzJiflQAdswqaEaiY9tW9Ma5v0qKDmdg+WTilHl2cbt
 lrln9/YjPWSnuyYb2jUrH6yC/b60G/2ujl0jvwTUQwcqvSbpUDMktwQ==
X-Received: by 2002:a17:903:2411:b0:2c6:9d3d:dfbd with SMTP id
 d9443c01a7336-2c6bc0c66famr15100915ad.16.1781663710316; 
 Tue, 16 Jun 2026 19:35:10 -0700 (PDT)
X-Received: by 2002:a17:903:2411:b0:2c6:9d3d:dfbd with SMTP id
 d9443c01a7336-2c6bc0c66famr15100695ad.16.1781663709817; 
 Tue, 16 Jun 2026 19:35:09 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac72asm154760255ad.38.2026.06.16.19.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 19:35:09 -0700 (PDT)
Message-ID: <2015405e-7839-4ab9-b5a0-712b644da3c8@redhat.com>
Date: Wed, 17 Jun 2026 12:35:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] system/memory: Make ram device region directly
 accessible
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 alex@shazbot.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
References: <20260616052552.389021-1-gshan@redhat.com>
 <ae17b5a6-eed8-4d4c-a798-cb92ffa6c915@redhat.com>
 <20260616014419-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260616014419-mutt-send-email-mst@kernel.org>
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

On 6/16/26 3:44 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 16, 2026 at 03:40:34PM +1000, Gavin Shan wrote:
>> On 6/16/26 3:25 PM, Gavin Shan wrote:
>>> All ram device regions was turned to be indirectly accessible by commit
>>> 4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
>>> to a hanged guest where a NVidia GH100 GPU is passed from host. The memory
>>> in its PCI BAR#4 can be allocated as DMA target buffer. qemu has to take
>>> DMA bounce buffer in address_space_map() to cover the DMA request. However,
>>> the bounce buffer size is 4096 bytes and we're overrunning it easily when
>>> the guest has significant disk activities on compiling 'cuda-samples'.
>>> The full log and problem description can be found from PATCH[1/2]'s commit
>>> log.
>>>
>>> Try to fix the issue handled in commit 4a2e242bbb by replacing memcopy()/
>>> memmove() with newly added helpers qemu_ram_{copy, move}() that works on
>>> top of __builtin_{memcpy, memmove} or unaligned access friendly memory
>>> movement in the accessors to the ram device regions. With this, we can
>>> basically revert that commit to make ram device region directly accessible
>>> again and bypass the bounce buffer in address_space_map() where the guest
>>> hang is caused.
>>>
>>> PATCH[1] uses qemu_ram_{copy, move}() in ram device region accessors
>>> PATCH[2] makes ram device region directly accessible again
>>>
>> Michael asked to include below context in the cover letter in v3, but I
>> didn't noticed that before I sent v3 series, appended with them.
>>

Looking at the list of issues (questions) raised by Michael, I don't understand
every one before I'm able to put more time to dig, but I feel this series has
too ambitious goal to cover accesses to all the directly accessible regions
with the newly introduced qemu_ram_{copy, move}. It causes too many behavior
changes and concerns, making this series impossible to land.

I would suggest to break down the goal and step back to apply the newly introduced
qemu_ram_{copy, move} to the ram device regions only? It's actually something
proposed by Peter Xu in the earlier replies. Taking address_space_write() as an
example, the indirectly accessible regions are covered by memory_region_dispatch_write()
in (1), the ram device region is covered by qemu_ram_move() in (2), and all other
directly accessible regions are covered by memmove() in (3).

   address_space_write
     flatview_write
       flatview_write_continue
         flatview_write_continue_step
           memory_access_size             // (1) indirectly accessible region
           memory_region_dispatch_write
             access_with_adjusted_size
               memory_region_write_accessor
                 mr->ops->write
           qemu_ram_move                  // (2) ram device region
           memmove                        // (3) all other directly accessible regions

With the limitation, only the ram device regions in (2) are affected. We're
basically moving the accesses to the ram device region from (1) to (2). No
changes introduced to other types of regions. The goal is to make the ram device
region accessible so that the bounce buffer can be bypassed in DMA path.

>> ----
>>
>> The issues listed by Michael:
>>
>> 1. On x86, memcpy is different from __builtin_memcpy if one uses old 1.0
>>     force-headers from 2019. Likely no longer relevant.
>>
>> 2. variable length memcpy can translate 2,4,8 byte guest access into
>>     multiple byte accesses. doing this for mmio is guaranteed to break devices.
>>
>> 3. (theoretical concern) also on x86, unaligned accesses are possible on guest
>>     and host, so converting an unaligned access to a series of aligned ones can
>>     in theory break devices.
>>
>> 4. also on x86, vector instructions for large (>16 byte) writes into
>>     pgprot_noncached memory are safe and faster than multiple 8 byte ones.
>>
>> 5. also on x86 it so happens that if you write a fixed-size memcpy this gets
>>     optimized to a single store/load and it works for aligned and unaligned
>>     addresses on that architecture. How to ensure this keeps being correct
>>     is left as an excerise for the reader. But qemu already relies on this
>>     and did for years.
>>
>> 6. on non-x86 both unaligned accesses and vector instructions for accessing
>>     UC memory are illegal.
>>
>> 7. standard vfio gives KVM VM_ALLOW_ANY_UNCACHED, so even on non x86 guest can
>>     map the memory as as pgprot_noncached/ioremap or pgprot_writecombine/ioremap_uc.
>>     If it does the second then it can use unaligned or vector for access.
>>     This is why normal passthrough tends to work - it never traps to qemu at
>>     all. But for qemu, vfio uses  pgprot_noncached unconditionally so qemu
>>     can't use unaligned or vector instructions on non-x86.
>>
>>
>> 8. But for nvgrace RAM, vfio has a driver that uses pgprot_writecombine/ioremap_uc.
>>     so qemu could safely use unaligned/vector instructioons even on non-x86.
>>
>> 9. Except sadly, vfio currently does not tell qemu how it maps
>>     the memory, so qemu can not know what is safe on non-x86.
>>
> 
> And more:
> 
> 10. on x86 memcpy will sometimes do multiple overlapping stores when
> size is not a power of 2. for example, a 15 byte write is done with
> 2 8-byte stores. This is theoretically an issue
> if guest does something super clever with ordering,
> but does not seem to be in practice.
> 
> 10. on non-x86 memcpy will do multiple overlapping stores even
> for single byte writes. E.g. it does it to avoid extra branches.
> This is causing issues in practice.
> 
> 
> 
> 
> 
>> Now, what is to be done?
>>
>>
>> A. on x86, we must avoid converting 2,4,8 byte accesses into byte accesses.
>> At least for aligned, perferably for unaligned accesses too.
>> Fixed width memcpy seems to work for this. Whether we should bother with
>> __builtin to work around broken old fortify headers, I donnu.
>> I do not have any answer how to check that compiler does this correctly.
>> If anyone is motivated enough, adding a GCC builtin could be possible.
>> Given qemu did this for years, I think we can leave solving this for
>> another day.
>>
>> B. Also on x86, I do not see why we should not use memcpy for large
>> accesses if we can. Better perf.
>>
>> C. on non-x86, we currently must not memcpy since we do not know if it
>> is pgprot_noncached. yes, performance will be bad for DMA into device RAM.
>>
>> D. It goes without saying that casting an unaligned address to unint32_t
>> (be it for qatomic_set or whatever) is undefined behaviour in C
>> and so a bad idea on any architecture.
>>
>> E. also for non-x86, we really should teach vfio to tell qemu whether
>> it maps device pgprot_noncached or pgprot_writecombine.
>> we will then be able to use memcpy for >8 accesses.
>>
>> Anyone, correct me if I'm wrong? Maybe I should start a new thread with
>> this summary?
>>

Thanks,
Gavin


