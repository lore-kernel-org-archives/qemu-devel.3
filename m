Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FB2CD98C5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 01:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXU5d-0000Cy-BN; Wed, 10 Jun 2026 21:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXU5b-0000CG-Tf
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:20:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXU5Y-0006x2-QV
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 21:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781140806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Dib+nvxx7dhI24Xtk5OtCYThsTAz12g/c4r/JdGJmI=;
 b=BchByijvQHNUc4ysRytTeDkvRaI4kNl5nM2CmUplgd5o1d2Cjyachtt5cMYKaL2oDPJWTz
 5c06493nTyairb/pN34Z2YJ5TQafeywwKK/5acUmyWuW0621ZjaVX2nII2UIDiM0680RBA
 OE7bYLYYPYATDr9feuIX/yyKR8PL56I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-rq6y2nNEN12U43XlUNW-QA-1; Wed, 10 Jun 2026 21:20:04 -0400
X-MC-Unique: rq6y2nNEN12U43XlUNW-QA-1
X-Mimecast-MFC-AGG-ID: rq6y2nNEN12U43XlUNW-QA_1781140804
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a2c665easo6717724a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781140804; x=1781745604; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Dib+nvxx7dhI24Xtk5OtCYThsTAz12g/c4r/JdGJmI=;
 b=FOBlPUNjZ8eDeNNgc2i9FQL4Iw0fEcknS9J5R+hTiRioeZAm7aVFzZA+M3uGC6P1Iq
 Q3r+19hRrYf4+WT90ToW82ptRsovtLoGkqkrLUNwMD+KUnzrnuxC/LRLEWVA0tI1aXks
 JES/8Fo0nHtRH+1Cc1HCwwRkUrModpaN9CaGCQ4Pl9zXnbB2s1lLiCf79zdBXtHakDY0
 pwINFtnGNGWvPQdeDoqNTbxs1OGxezEV8OluFUfeREy7WjQ1oyg2+MB7DVOxe67tLBio
 y8HEaP3ocujmxKfWu9D3vM9o8VfN61CkdZixM8XhmNtvAVvP7kiHI8SxXboOQaYwzX4v
 4mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781140804; x=1781745604;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2Dib+nvxx7dhI24Xtk5OtCYThsTAz12g/c4r/JdGJmI=;
 b=WxTXm8EGSXfrVSpiU6Dh6oEWpzxt9nDqj9UpwfbkeFExmjBGrXLIjeawAChyyJ+AgW
 1+wdcMYwRg1j12JWPc11n29AL3tpiZnVr9z8GbFQJWHwIA1PJBjdRfAbwtadMbnkVTos
 sjP1XjebX26Ko90fhSXHsHavGrwF13TeYc4HqArEvosrqQMPaanTu0kweLKUbh7P+Uze
 pxLVKTkco6DjKBmDXL/jWVHwPYutTnrYLUNhgTVM4Z3Mp3JOa0+lvTu8QWGtJKnnNsF0
 fH1NCWtsWlJZ+pspmIY98FdqcPDDwuaTG/oFieBEZeo6LOO12T/atKfd2sHFQ/i59BeW
 AKew==
X-Gm-Message-State: AOJu0Yz1cbOpWTR2KVWgsck86ry4+q1sf71u5uflo48xx0wPfZN2gaDE
 MLd9rDKyHZqSQTW91Ux98swEvS+w1TEOvd8ChUX+3VfVCGj97rwwxT7retYQkYeYccBqO3tqCO+
 U5T6Qpi0xHIC/EiCtxMSPtHmUMw92x5SpSpxHUp3U1lk1Vm1O5xtbcI7B
X-Gm-Gg: Acq92OHorqqfP0R219wCmzNfKgfUAz0fu13mU8dZ6O5ClrCJU/3Qg9o6icgHqh4T04J
 FPCkfvjY/UXuIvLrrGlnTxa34HG+sM/5z+BBDFui/d2Iw1MH3ypQKMxgUKfmhrikhLnaqEL8kP+
 NcBcooNhHn4l3vjilUv+rxB0vzSef4NFAX8J6TraBG3EldL89MvcqNcbtuVTUwEplbPoAnpWPi6
 VysIY5eaU+I6qEAldKGJ2hov5H6S1wiNvxW6n4o57EN2TFF33QwYOuOdJzEZvI2y6ljzpXyvY2E
 voqU3b5zcmSYsnNZjdwhzftFHg7KWjmMSBMYc9LKdsEhscD0ROpUH42hvg9fi/1qR6GhgOiYOnu
 RAJH8m1cDJgwPUMH6v83CEnC7/va8MM1UEA1u86/eXl2oygBpz7eVDMi34rcVkwXLULWcxANQqx
 8=
X-Received: by 2002:a05:6a21:9148:b0:3b4:85db:1bed with SMTP id
 adf61e73a8af0-3b5e33785c6mr353693637.45.1781140803622; 
 Wed, 10 Jun 2026 18:20:03 -0700 (PDT)
X-Received: by 2002:a05:6a21:9148:b0:3b4:85db:1bed with SMTP id
 adf61e73a8af0-3b5e33785c6mr353663637.45.1781140803047; 
 Wed, 10 Jun 2026 18:20:03 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0a624fsm22299869a12.18.2026.06.10.18.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 18:20:02 -0700 (PDT)
Message-ID: <c1a590e1-05d3-4c96-9df4-4f82bd08c678@redhat.com>
Date: Thu, 11 Jun 2026 11:19:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, qemu-block@nongnu.org
References: <20260608001821.850921-1-gshan@redhat.com>
 <20260610041036-mutt-send-email-mst@kernel.org>
 <20260610183046.GB121666@fedora>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260610183046.GB121666@fedora>
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

On 6/11/26 4:30 AM, Stefan Hajnoczi wrote:
> On Wed, Jun 10, 2026 at 05:49:21AM -0400, Michael S. Tsirkin wrote:
>> On Mon, Jun 08, 2026 at 10:18:21AM +1000, Gavin Shan wrote:
>>> On the guest where a NVidia's GH100 card is passed from the host, the
>>> guest system hang can be observed on attempt to compile 'cuda-samples',
>>> as reported by Julia.
>>>
>>>     host$ lspci | grep GH100
>>>     0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
>>>     host$ /home/sandbox/gavin/qemu.main/build/qemu-system-aarch64 -accel kvm \
>>>           -machine virt,gic-version=host,ras=on,highmem-mmio-size=4T         \
>>>           -cpu host -smp cpus=32 -m size=8G                                  \
>>>           -drive file=/home/gavin/sandbox/images/disk.qcow2,if=none,id=d0    \
>>>           -device virtio-blk-pci,id=vb0,bus=pcie.0,drive=d0,num-queues=4     \
>>>           -device vfio-pci-nohotplug,host=0009:01:00.0,bus=pcie.1.0
>>>
>>>     guest$ cd cuda-samples/build
>>>     guest$ make -j 20 clean
>>>     guest$ make -j 20
>>>                 :
>>>     [ 54%] Linking CUDA executable graphMemoryNodes
>>>     [ 54%] Built target graphMemoryNodes
>>>     <no more output afterwards, guest becomes frozen here>
>>>
>>>     guest$ qemu-system-aarch64: virtio: bogus descriptor or out of resources
>>>     [  555.814025] virtio_blk virtio0: [vda] new size: 268435456 512-byte logical blocks (137 GB/128 GiB)
>>>
>>> When the GPU's driver (NVidia open driver) is loaded on guest bootup,
>>> the memory blocks residing in the PCI BAR can be presented to the guest
>>> through memory hot-add. The page cache can be allocated from the hot added
>>> memory blocks when cuda-samples is being built. Afterwards, he page cache
>>> is sent to QEMU's virtio-blk device as part of the DMA request, the bounce
>>> buffer is used to accomodate the request as the corresponding memory
>>> region (MemoryRegion) is a RAM DEVICE region in qemu. For this specific
>>> case, false is returned from memory_access_is_direct() in the path where
>>> the DMA request is handled.
>>>
>>>    QEMU
>>>    ====
>>>    virtio_blk_handle_output
>>>      virtio_blk_handle_vq
>>>        virtio_blk_get_request
>>>          virtqueue_pop
>>>            virtqueue_split_pop
>>>              virtqueue_map_desc
>>>                address_space_map
>>>                  memory_access_is_direct         # Return false
>>>                    memory_region_supports_direct_access
>>>
>>>    (qemu) info mtree
>>>            :
>>>    memory-region: pci_bridge_pci
>>>      0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
>>>        0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4
>>>          0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4
>>>            0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0]
>>>
>>> By default, the max bounce buffer size is only 4096 bytes, even less
>>> than one page when the guest page is 64KB. This tries to fix the issue
>>> by inheriting the customized max bounce buffer size of the virtio bus's
>>> parent through property 'x-max-bounce-buffer-size' when the customized
>>> size is a larger one. With this applied, no guest system hang is seen
>>> with '-device virtio-blk-pci,...,x-max-bounce-buffer-size=268435456'.
>>>
>>> Reported-by: Julia Graham <jugraham@redhat.com>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>   hw/virtio/virtio-bus.c | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>>> index cef944e015..e0933823f3 100644
>>> --- a/hw/virtio/virtio-bus.c
>>> +++ b/hw/virtio/virtio-bus.c
>>> @@ -42,6 +42,7 @@ do { printf("virtio_bus: " fmt , ## __VA_ARGS__); } while (0)
>>>   /* A VirtIODevice is being plugged */
>>>   void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>>>   {
>>> +    AddressSpace *as;
>>>       DeviceState *qdev = DEVICE(vdev);
>>>       BusState *qbus = BUS(qdev_get_parent_bus(qdev));
>>>       VirtioBusState *bus = VIRTIO_BUS(qbus);
>>> @@ -100,6 +101,19 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>>>                   return;
>>>               }
>>>           }
>>> +    } else {
>>> +        /*
>>> +         * The maximal bounce buffer size of the virtio bus's parent may
>>> +         * have been customized by property 'x-max-bounce-buffer-size'.
>>> +         * Lets inherit the customized size if it's larger than the
>>> +         * current one.
>>> +         */
>>> +        as = klass->get_dma_as ? klass->get_dma_as(qbus->parent) : NULL;
>>> +        if (as) {
>>> +            vdev->dma_as->max_bounce_buffer_size = MAX(
>>> +                    vdev->dma_as->max_bounce_buffer_size,
>>> +                    as->max_bounce_buffer_size);
>>> +        }
>>>       }
>>>   }
>>>   
>>> -- 
>>> 2.54.0
>>
>>
>> Problem with all this is, users would not know how to size this.
>>
>> So fundamentally, is not the issue that virtio blk (and scsi!) maps
>> all of the buffer all the time?
>>
>> It's not hard to add something like virtio_pop_unmapped that would not map,
>> then build QEMUSGLists out of addr/len pairs and submit these.
>>
>> Stefan, do you think doing it like this would be bad for perf? Good for
>> perf?
> 
> I'd like to first make sure that the BAR really cannot be mmapped.
> 
> A bounce buffer is necessary when QEMU has no way of mmapping the memory
> (e.g. it needs to invoke a device model's callback to read/write the
> MemoryRegion).
> 
> The reason why the bounce buffer size is low is because it's normally
> only used on emulated machines where MMIO registers or similar small
> MemoryRegions are accessed by DMA. If we ran into this on modern
> machines there would also be other consequences like vhost devices would
> be unable to access that memory since it cannot be shared/mmapped.
> 
> This is why I think we need to understand why this BAR is a RAM DEVICE.
> If it can support mmap then this issue, plus anything else like vhost,
> would work.
> 
> Gavin, can you share the output of `lspci -vv -s 0009:01:00.0`?
> 

root@nvidia-grace-hopper-01:/home/gavin/sandbox/qemu.main# lspci -vv -s 0009:01:00.0
0009:01:00.0 3D controller: NVIDIA Corporation GH100 [GH200 120GB / 480GB] (rev a1)
	Subsystem: NVIDIA Corporation Device 1809
	Physical Slot: 9
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 170
	NUMA node: 0
	IOMMU group: 12
	Region 0: Memory at 661ffd000000 (64-bit, prefetchable) [size=16M]
	Region 2: Memory at 662000000000 (64-bit, prefetchable) [size=128G]
	Region 4: Memory at 661ffe000000 (64-bit, prefetchable) [size=32M]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [48] MSI: Enable- Count=1/16 Maskable+ 64bit+
		Address: 0000000000000000  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [60] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 32GT/s, Width x1, ASPM L1, Exit Latency L1 <4us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 128 bytes, LnkDisable- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 16GT/s (downgraded), Width x1
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range AB, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp+ 10BitTagReq+ OBFF Via message, ExtFmt- EETLPPrefix+, MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq+ OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5-32GT/s, Crosslink- Retimer+ 2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 32GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete+ EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [9c] Vendor Specific Information: Len=14 <?>
	Capabilities: [b0] MSI-X: Enable- Count=9 Masked-
		Vector table: BAR=0 offset=00b90000
		PBA: BAR=0 offset=00ba0000
	Capabilities: [100 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [12c v1] Latency Tolerance Reporting
		Max snoop latency: 0ns
		Max no snoop latency: 0ns
	Capabilities: [14c v1] Data Link Feature <?>
	Capabilities: [158 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [188 v1] Physical Layer 32.0 GT/s <?>
	Capabilities: [1b8 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
			ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
			PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr+ HeaderOF+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 04000001 0000000f 01080000 00000000
	Capabilities: [200 v1] Lane Margining at the Receiver
		PortCap: Uses Driver+
		PortSta: MargReady- MargSoftReady-
	Capabilities: [248 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [250 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration- 10BitTagReq+ IntMsgNum 0
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+ 10BitTagReq-
		IOVSta:	Migration-
		Initial VFs: 24, Total VFs: 24, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 2, stride: 1, Device ID: 2342
		Supported Page Size: 00000573, System Page Size: 00000001
		Region 0: Memory at 0000661ffca00000 (64-bit, prefetchable)
		Region 2: Memory at 0000000000000000 (64-bit, prefetchable)
		Region 4: Memory at 0000000000000000 (64-bit, prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Capabilities: [2a4 v1] Vendor Specific Information: ID=0001 Rev=1 Len=014 <?>
	Capabilities: [2b8 v1] Power Budgeting <?>
	Capabilities: [2c8 v1] Data Object Exchange
		DOECap: IntSup+
			IntMsgNum 0
		DOECtl: IntEn-
		DOESta: Busy- IntSta- Error- ObjectReady-
	Capabilities: [2e0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable+, Smallest Translation Unit: 00
	Capabilities: [2e8 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable+ Exec- Priv-
	Capabilities: [2f0 v1] Device Serial Number c5-c5-17-ff-f6-2d-b0-48
	Kernel driver in use: nvgrace_gpu_vfio_pci
	Kernel modules: nouveau


> Thanks,
> Stefan

Thanks,
Gavin


