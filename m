Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E907CC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wod8F-0002Cx-9z; Tue, 28 Jul 2026 04:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wod8D-0002Cj-SM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wod8C-0008Q0-0D
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785227142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cm4K6QB8razArBdngg04caXe+fwUS7QRZLVF0seNBZY=;
 b=SoZ8+SCKp0GGvTo/3bX9CrcmIixVvw5ssAPElClMi9iSG/IE2xyJprxShRg2Htfsq8ElDB
 25oOS88WGJwVj0wJgcsUBkgh6byScTvE2Sr8NJjbW7eXh6/ov8vzK0Pk3ciiVzK0pT6/Xt
 pDeXBlDQdBrPHm7eQj05VuoCAsnhi5E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-L1v8dsUROgy0jBDVMh-rPQ-1; Tue, 28 Jul 2026 04:25:41 -0400
X-MC-Unique: L1v8dsUROgy0jBDVMh-rPQ-1
X-Mimecast-MFC-AGG-ID: L1v8dsUROgy0jBDVMh-rPQ_1785227140
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-496b61bd846so25508395e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785227140; x=1785831940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cm4K6QB8razArBdngg04caXe+fwUS7QRZLVF0seNBZY=;
 b=MCwV6x6UJ92ByuJxvPJp0zRJW3Oco3J851MjyXVpxtJMx73iyqtGG7nRLTU4Js6lRq
 gEEVkviiRqgYOy4TycIfZpRe/TM0yVJl6D1VsqfxBjARdW5Vx8cOAANWefc9XwE+rq9i
 wisaSdGODTUQMwJ25uJCM1gsbilC87kBQ4P2UsmVKMqDaK0G+mVx+IUC99XZ5dzYhuOk
 V9RC8hU+Qj1qQVjkni/0P0AozJr8V5NXNrLT8Rfcc+f0jSGVsRuXVJVdQXcmKqpcwIDe
 UT0UIc+A/SaM/hzeM1m+zwCb7BmS9gxuzrivXhYqsDd+EM0gtGvfyWZIiqwwvZjWI4ba
 b62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785227140; x=1785831940;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cm4K6QB8razArBdngg04caXe+fwUS7QRZLVF0seNBZY=;
 b=boKOQxS7+8C9SVMo8zzD3onYPCvuI76sRYUKENXSbY7WsCb+s69FlvwfC+n1yGAirW
 43zlrBtsk2IA+tsu0T58wFmQgFk4Tsm2v0B+54yhRLEPtO5ppLgXkN4n4j+cEijXaTcH
 l5G5NokxnLYOvrGg8WSOXI4XEIHOdau0wJq7nGC6vSUruzK/9VBvm4QB6dKi5rm3KEuP
 2/jn9oQ2KIA1YddWj5K4Y6mn3HmNz+cGScSuDFtUppjyYiyht+Vkrl64HyYhSMfvKL3p
 I3/ZNeQlfCDcGF+aubCbd6SZnrSDCeLJwrqRtlycl4vKEUyBbXNMBYjjJkw8Y7Im2J/N
 2C3g==
X-Gm-Message-State: AOJu0YzHGHxyDjsdW4sibf8UULR9xj2/Jb234hwq3SVEXZf3FWgZvCCx
 00Ae5gukXjnJyur/y3Zi3pJoIas/QUNQv6vC2MUMb9FEhtWFLKp1orHvrwaWLmpkbdKKBdUoq0O
 zjjB0YpljkbetHJobtcxS1guXIBoBq7amoFgqwXYNY6BNMFSnBstXbylr
X-Gm-Gg: AR+sD12gjNeU2bnjRuDIIwT0slQ3sJC8Ika6MHaVSrWn+l+8T+F3Y7pS7G02ZyriC6U
 8LKxix0tfPmimbD5ol8uQMJrBGX8alZUpK895/kt87B6CRwIP86+WYH2pZxmRRPidvXgYJusqUC
 AL5+3NLw12LWgMTVhxRzIR//B80A13qXmI0VraNazAR6K0V8MnHyRcuUO1wD50ExVfQScJJZNTn
 8YmdDHfnvYsg8t9d+rT8h3jIFWKFWz44/pVZQ9cMpXXBCZpnstEywUFDVcBXOcwjUquzp3IXuEI
 64G/imMvWrgpu1oovOoCyL1q09iI35hYm0qxFX8Opmkko41ud7bJJXcEMk1dg9aYP5C9BOKrywT
 +bV3zrVeFayPTbvPgyPsbxcrNECQPlxT5o91Knew=
X-Received: by 2002:a05:600c:46d5:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-496c642de41mr14933315e9.3.1785227139944; 
 Tue, 28 Jul 2026 01:25:39 -0700 (PDT)
X-Received: by 2002:a05:600c:46d5:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-496c642de41mr14933015e9.3.1785227139463; 
 Tue, 28 Jul 2026 01:25:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44b84edsm92283105e9.5.2026.07.28.01.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:25:38 -0700 (PDT)
Message-ID: <7451ffe7-7ef6-49b8-9f52-ef1a7c7e9f95@redhat.com>
Date: Tue, 28 Jul 2026 10:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/11] igb: Add experimental VF live migration support
To: Alex Williamson <alex@shazbot.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
 <20260727143641.66b3799a@shazbot.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260727143641.66b3799a@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/27/26 22:36, Alex Williamson wrote:
> On Mon, 27 Jul 2026 07:39:24 +0200
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Hello,
>>
>> Live migration of VFIO-passthrough devices - SR-IOV VFs, vGPUs - is a
>> growing requirement, but real hardware with migration support is
>> scarce and hard to debug. An emulated device provides a fully
>> controlled testbed for developing and validating the entire software
>> stack - vfio-pci variant drivers, VFIO core migration v2 framework,
>> QEMU, libvirt - and for tuning complex migration policies such as
>> downtime convergence. It also serves as an educational reference for
>> understanding VFIO migration end-to-end, from device state
>> serialization to dirty page tracking.
>>
>> This series adds an experimental VF live migration interface to the
>> emulated igb (82576) device. It enables a vfio-pci variant driver
>> (igb-vfio-pci) to migrate VFs using the standard VFIO migration v2
>> protocol with stop-copy and pre-copy support.
>>
>> The target scenario is nested virtualization:
>>
>>    L0 QEMU (these patches)
>>      igb PF with x-vf-migration=on
>>      └── VFs with migration BAR + vendor cap
>>
>>    L1 kernel
>>      igb-vfio-pci variant driver [1]
>>      translates VFIO migration v2 ioctls → BAR2 MMIO
>>
>>    L1 QEMU (stock, unmodified)
>>      vfio-pci device model, standard migration fd
>>
>>    L2 guest
>>      standard igbvf driver, unaware of migration
>>
>> The L1 QEMU is completely unmodified -- it sees a standard VFIO
>> migratable device and uses the normal migration fd path.
>>
>> * Design
>>
>> The migration interface is exposed through a hidden 64KB PCI BAR
>> (BAR2) on each VF, discovered via a vendor-specific PCI capability
>> ("MIGB", PCI_CAP_ID_VNDR). The BAR exposes a register-based state
>> machine that mirrors VFIO migration states (RUNNING, STOP, STOP_COPY,
>> RESUMING, PRE_COPY).
> 
> I think you're placing the migration BAR on the VF in order to
> implement this in a small footprint, QEMU + vfio-pci variant driver,
> without PF guest driver changes.  

yes.

> A model that better matches real
> world hardware might be to put the migration BAR on the PF, segmented
> per VF, and then have the PF driver vend those segments out to the VF
> drivers.  

True.

On the migration topic, I saw that the SR-IOV specs had "VF Migration
State Array" feature, which was deprecated.

> That would remove the BAR always mapped problem, 

That's the main problem today.

> but expands
> the footprint to include the PF driver.  However, we're not exactly
> clean with respect to the PF driver as implemented here when we're
> going around the PF driver's back to setup DMA mappings.

That's not uncommon today. The PDS vfio-pci variant driver setups DMA
mappings in the PF to migrate the VF. But yes, given that the IGB PF
has no idea that a VF could be migrated, it's a bit of a resource hijack.

> Can we take advantage of the fact that this is a virtual device to
> avoid all these warts?
> 
> For example, do we really need MMIO BAR space for the register set
> exposed or can we prune that down to some key registers and doorbells
> and move the rest to memory?  We can put the vendor capability in
> extended config space to give ourselves more room to work with if
> necessary.  

There is plenty of space in the extended config space. The required
register set is relatively small.

> We also don't really need to play by the physical rules for
> access, the variant driver in the L1 kernel can allocate contiguous
> ranges and write GPAs into config space registers.  

yes.

> L0 QEMU can just
> write migration data and dirty bitmaps directly to those GPAs,
> bypassing any pretense of DMA mapping.

yes that works.

A previous implementation of this proposal was allocating GPAs.
I then preferred a solution that was more PCI friendly. Anyhow,
it's not a problem to change it again, once we agree on the
HW interface.

> There might be some tricks we can steal from virtio as it seems to
> optionally honor things like vIOMMUs as well. 

Yes. That's where the PCI DMAs mapping were interesting. I will
look at it.

> Anyway, if we want to
> confine the implementation to the virtual VF, avoiding dependencies on
> the PF driver, both at the cross-driver API and device DMA state, I
> think we can probably lean harder on QEMU being able to push data into
> an arbitrary GPA regardless of the IO topology we're exposing.  

So, the extra PCI BAR is indeed a problem and we should switch to
extended config space to avoid it. I have been exploring several
ideas and this proposal is an hybrid MMIO/shared buffer solution.


Here are my plans for the next.

Reduce the register set to a minimum and use a shared buffer for
all commands. The driver would allocate a single large enough buffer
for the largest command payload (DIRTY_QUERY with bitmap) and write
its GPA into BUF_ADDR once at init. Each operation is: fill buffer,
kick CTRL, poll STATUS.


Registers in extended config space :

   0x00    Header        Cap ID
   0x04    CAPS          Features, max_ranges, pgsizes
   0x08    CTRL          Doorbell (state transitions, dirty ops)
   0x0C    STATUS        Completion + error code
   0x10    BUF_ADDR_LO   Shared buffer GPA low
   0x14    BUF_ADDR_HI   Shared buffer GPA high

Commands and payload :

   1. SET_STATE
   0x00    target_state    driver      Requested VFIO state

   2. SAVE
   0x00    data_size       device      Bytes written  (32-bit)
   0x04    reserved        -           May be more reserved bytes to align data
                                       on 32bits
   0x08    data[]          device      State blob

   3. LOAD
   0x00    data_size       driver      Bytes to load (32-bit)
   0x04    reserved        -           May be more reserved
   0x08    data[]          driver      State blob

   4. DIRTY_ENABLE
   0x00    iova            driver      Range start (64-bit)
   0x08    size            driver      Range size (64-bit)
   0x10    pgsize          driver      Page granularity
   0x14    reserved        -

   5. DIRTY_DISABLE

   6. DIRTY_QUERY
   Request (driver):
   0x00    iova            driver      Query range start (64-bit)
   0x08    size            driver      Query range size (64-bit)
   0x10    pgsize          driver      Page granularity (for queries)
   0x14    reserved        -

   Response (device):
   0x18    bitmap_size     device      Bytes in bitmap
   0x1C    dirty_pages     device      Set bits count
   0x20    dma_writes      device      DMA writes since enable (64-bit)
   0x28    reserved        -
   0x30    bitmap[]        device      Dirty page bitmap

   7. GET_STATS
   0x00    dma_writes      device      (32-bit)
   0x04    dma_bytes       device      (64-bit)
   0x0C    dirty_pages_set device
   0x10    dirty_pages_clr device
   0x14    dirty_page_count device
   0x18    dirty_query_cnt device


We could add a shared buffer header (not sure this is useful though)

   0x00    command         driver      Operation to perform
   0x04    status          device      Completion + error code
   0x08    payload_size    both        Size of payload following header
   0x0C    reserved        -           Alignment

Do we want 'flags' anywhere ?

Thanks,

C.


