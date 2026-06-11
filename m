Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23465CD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXebq-0000jA-Sb; Thu, 11 Jun 2026 08:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXebn-0000iw-L7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wXebk-00036i-R3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 08:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781181241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Egoe91X1T7zQgLpUJw350Jnl9lZZVQrlpCJ+OqMgeIw=;
 b=FGz6a9kmDSEh8XEWi56iTxuCNsQgzo4GYJmQDRco7/Tigh+WRLX02NXEpTjXddK1O+DDRM
 PnQAhD1hvc7sEx2MiJKGZrS65FEonHZ3v+qzyP9Ijy+aosPunfwunB3N0927cvW0KdqHeL
 N/0sc0udR5IWOudPlzitoZOsP5vEAoI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-Aa9277GkPsGyt2W3hBsNJw-1; Thu, 11 Jun 2026 08:33:59 -0400
X-MC-Unique: Aa9277GkPsGyt2W3hBsNJw-1
X-Mimecast-MFC-AGG-ID: Aa9277GkPsGyt2W3hBsNJw_1781181239
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0c272e532so79924775ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781181238; x=1781786038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Egoe91X1T7zQgLpUJw350Jnl9lZZVQrlpCJ+OqMgeIw=;
 b=Ge/RKVOnLmqqJx+iHVtxYMPf4ELUILsR1Dn1h+8ypsamjtMVZkj3nkSbHrR8Fc9KsU
 ydrMq70Z9M1b6Wn4wpvrfp8AJcE4iojWwsqgBxEI4yPF3zaZsTczsAsZvC6n7elkHIYZ
 sPpqRLPJp3GGYsqNB0DnLdjJqfF4n9PVpW3usMazrYmLcMtDVIMNXrPST8clmimOI4rp
 P2fxGsI5KWxtoKsnFcrG1nEJYR5wL0B3VSRTBckbTrvP02u3JdWek64aTQJVe4RbPQkO
 SOdTeH35vjjtYTPwn6AuJdPOXCaQ39/7KM2iBYCWJDYVPd7+TwWkXxW0T/vZunOvYUtD
 b8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181238; x=1781786038;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Egoe91X1T7zQgLpUJw350Jnl9lZZVQrlpCJ+OqMgeIw=;
 b=pvbO4Wi9uTYz3zufqsRCMBPiDYHleh5Sbjmivv44K1zhF3rhOTlHnagH7o9VLTp4Uv
 EIKjI6cxpL5SoPz3uqzBjBHYvaRTkYHQK8nysCxyppbRkA+y/zSmMFN3xVcHrkJUQyZF
 kTC2wnzxEoqLBz68sEJ5TVDMghbGZcTA5OU/iNX343CbAX59mzcJeccKnWUKeg9NJJiG
 IFYEEWcR+Y0a9U6890acxHKc98ydnxMQdIsZCmPBRWUENEpn+ml+mEfCKwbK8gNhGYMI
 kO2J9IgFX+uXNRDOzz5CPEGDXkkXPmF3F59CF7ZxaoEJ0sQKB9h6CbSPY5T/Pi/5E2ka
 FZ+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SyDPO6SKOBMiHHVYl8UlC3IO0iae654HvMnNn+XlR3HcmprdDKx+ExL6yDIsuEyITg8bZZZDU6yWv@nongnu.org
X-Gm-Message-State: AOJu0Yz9WU4yPWfxjM+9N5bfmb7vTT97IYGW03qjdDs52o59dsp5fNkO
 WgEnS1P6Ln0ZiXBoH1ltZNnuBEz26cyUUfNv24aAWOowmT5rNhNaYoXa6O8dbMosVTiWUQreahM
 hfIj7EdokcowOUW4Ftbg9+WalQUdWScgSYKBd6dQ5t+jLpAQHJkc8qiJ4
X-Gm-Gg: Acq92OEKyPvd58idsSxHYosZNWqyHOLDWnKq0ZD9BV+C6jPo9S/VwFLBNRRqVwXilQU
 CLpZ9tmpKZFx8BZUOg7fLGe1AzAK+SXCvwJs9yGmX1eb4dAW5AZdQ3EI4I/fjgov8tahBfzwRwi
 tXfGxmDvCml0X9r4kURXnuBBBenuTjXZkZzJZwrlc/Sb+nQKnI1PMxG6AUMo+EQx57mYvaX+Pyt
 lKidSnULa6KD9YzK7gGL0bc6REfDuJX/8uPjgSM/yT0/DEPQzUe0ou8wffKsEWnWbBm4kbN2EWR
 gENCaqBpklIo1HORExFtKyvBwr18EMj+/HslQnk8bRgCK6G0Jvf0fzLWfGHi16fGS2S2nPnPJcc
 R25MeFtOnkyMFZgkk1BMrubj3sRLy7LWyhCjGwYux+q4BZN+f4pLCAUTmO8QuUBi//v0WQfXoPZ
 c=
X-Received: by 2002:a17:903:19e5:b0:2c0:b081:849a with SMTP id
 d9443c01a7336-2c2f3c051b4mr33967785ad.30.1781181238477; 
 Thu, 11 Jun 2026 05:33:58 -0700 (PDT)
X-Received: by 2002:a17:903:19e5:b0:2c0:b081:849a with SMTP id
 d9443c01a7336-2c2f3c051b4mr33967435ad.30.1781181237930; 
 Thu, 11 Jun 2026 05:33:57 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f87920sm283970815ad.24.2026.06.11.05.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 05:33:56 -0700 (PDT)
Message-ID: <0c3f1dba-3b2c-43c5-b181-1426f6da0951@redhat.com>
Date: Thu, 11 Jun 2026 22:33:50 +1000
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
References: <eb0f0da1-11dd-4437-94fd-a65af55851e1@redhat.com>
 <20260610082637-mutt-send-email-mst@kernel.org>
 <5d8cbd4b-3725-437e-88a3-e0af32164815@redhat.com>
 <e7cc9f2d-ccb4-442f-a1ed-7c5474395099@redhat.com>
 <20260610095712-mutt-send-email-mst@kernel.org> <aimEl9QQ_LTRPLtd@x1.local>
 <20260610121026-mutt-send-email-mst@kernel.org>
 <1e9515c9-7e32-4d95-9b73-aab8bf10bddc@redhat.com>
 <20260611012217-mutt-send-email-mst@kernel.org>
 <3726a607-6cac-41f1-b402-0eed7c4e3fe3@redhat.com>
 <20260611023428-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260611023428-mutt-send-email-mst@kernel.org>
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

On 6/11/26 4:34 PM, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2026 at 04:28:20PM +1000, Gavin Shan wrote:
>> On 6/11/26 3:31 PM, Michael S. Tsirkin wrote:
>>> On Thu, Jun 11, 2026 at 02:33:05PM +1000, Gavin Shan wrote:
>>>> On 6/11/26 2:18 AM, Michael S. Tsirkin wrote:
>>>>> On Wed, Jun 10, 2026 at 11:36:55AM -0400, Peter Xu wrote:
>>>>>> On Wed, Jun 10, 2026 at 10:06:24AM -0400, Michael S. Tsirkin wrote:
>>>>>>> On Wed, Jun 10, 2026 at 11:54:47PM +1000, Gavin Shan wrote:
>>
>> [...]
>>
>>>>>>>
>>>>>>> I do not think it has anything to do with host endian-ness.
>>>>>>>
>>>>>>>
>>>>>>> This is the change that broke it I think?
>>>>>>>
>>>>>>>
>>>>>>> commit 4a2e242bbb306ef5c16ce9e7bb2da3bd8a4eb098
>>>>>>> Author: Alex Williamson <alex@shazbot.org>
>>>>>>> Date:   Mon Oct 31 09:53:03 2016 -0600
>>>>>>>
>>>>>>>        memory: Don't use memcpy for ram_device regions
>>>>>>>
>>>>>>> Maybe Alex has an opinion on what to do.
>>>>>>
>>>>>> I can offer one idea here..
>>>>>>
>>>>>> IIUC the major issue was vector ops but the mr ops might be too heavy, then
>>>>>> another way to fix it is in memory API instead of using memcpy()/memmove(),
>>>>>> we always use a helper (say, memmove_no_vector()) to do the split and
>>>>>> properly aligned IOs as what ram_device_mem_ops does right now, this should
>>>>>> only applies to ram_device.
>>>>>>
>>>>>> With that, IIUC we can remove the current ram_device_mem_ops, then in
>>>>>> Gavin's case mmap() will go through and guest will not need to vmexit at
>>>>>> all.  Best perf, issue solve.
>>>>>>
>>>>>> We just need to be careful to trap all possible memcpy()/memmove() used in
>>>>>> memory core.. if I didn't miss any, IMO below four should needs to be
>>>>>> replaced by memmove_no_vector():
>>>>>>
>>>>>>      flatview_write_continue_step()
>>>>>>      flatview_read_continue_step()
>>>>>>      address_space_read()
>>>>>>      address_space_write_rom()
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> -- 
>>>>>> Peter Xu
>>>>>
>>>>> First, this is a nice idea.
>>>>> Second, the ideal thing is still just allowing direct access.
>>>>> And I think VFIO actually knows it's regular RAM.
>>>>> So something like the following small patch in linux, maybe?
>>>>>
>>>>
>>>> If I understood everything, Peter's proposal seems to move the logics covered
>>>> by ram_device_mem_ops to the upper layer.
>>>
>>>
>>> I think the basics of Peter's idea are really simple: if guest is doing
>>> DMA into a region then that access is treating that region as RAM and so
>>> any vectored etc instructions into it are fine.
>>>
>>> So we can fix specifically DMA into RAM DEVICE to bypass bounce buffering.
>>>
>>> It's at the low memory level, not the upper layer.
>>>
>>> He also apparently feels bounce buffering isn't needed
>>> generally and can be replaced with memmove_no_vector? And
>>> somehow virtio DMA can be done without kicking host? I'm not
>>> sure I understand these parts.
>>>
>>
>> For Peter's idea, I believe there is something I missed. Lets take our specific
>> case as an example where the DMA request is handled as the following calltrace
>> indicates.
>>
>>      virtio_blk_handle_output
>>        virtio_blk_handle_vq
>>          virtio_blk_get_request
>>            virtqueue_pop
>>              virtqueue_split_pop
>>                virtqueue_map_desc
>>                  address_space_map
>>          virtio_blk_handle_request
>>            iov_to_buf
>>              memcpy
>>
>> In address_space_map(), all RAM DEVICE regions treated as directly accessible
>> and the buffer (RAMBlock::host + offset) is returned. The buffer is passed on
>> to virtio_blk_handle_request() and iov_to_buf(), the data is then copied over
>> using memcpy(), which we're trying to avoid.
> 
> This is header copy why and how would we try to avoid that?
> 

Let me try to summarize what I understood. As VFIO is concerned, there
are multiple memory regions for one particular PCI BAR, and they're stacked
up. The memory regions for PCI BAR#4 of the GH100 card looks as below.

   (qemu) info mtree
              :
   address-space: pci_bridge_pci_mem
     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem

   (1) Its MemoryRegionOps is NULL. No data accesses are routed to this region
   (2) The data accesses routed to this region is handled by pread() and pwrite()
   (3) The data accesses routed to this region is handled by memcpy() before
       commit 4a2e242bbb.

There are identified PCI devices who have quirks, see vfio_bar_quirk_setup().
Accesses to part of the PCI BAR have to be emulated by the extra IO regions,
something like below for rtl8168 PCI device, where two extra IO regions are
stacked up for the quirks.

   address-space: pci_bridge_pci_mem
     0000000000000000-ffffffffffffffff (prio 0, container): pci_bridge_pci
       0000042000000000-0000043fffffffff (prio 1, i/o): 0009:01:00.0 base BAR 4          <---- (1) VFIOBAR::mr
         0000042000000000-0000043fffffffff (prio 0, i/o): 0009:01:00.0 BAR 4             <---- (2) VFIOBAR::VFIORegion::mem
           0000042000000000-000004379fffffff (prio 0, ramd): 0009:01:00.0 BAR 4 mmaps[0] <---- (3) VFIOBAR::VFIORegion::VFIOMap::mem
           0000042000000010-0000042000000014 (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[0]  <---- (4) quirk[0]
           0000042000000018-000004200000001c (prio 1, i/o): 0009:01:00.0 BAR 4 quirk[1]  <---- (5) quirk[1]

Access on 0000042000000010-0000042000000014 should be routed to region (4) quirk[0]
and access on 0000042000000018-000004200000001c should be routed to region (5) quirk[1].
However, accesses to 0000042000000000-0000042000000020 are routed to region (3) before
commit 4a2e242bbb and the data transfer is done by memcpy(), bypassing region (4) and
(5). It's not the expected behavior and why memcpy() isn't expected on device rtl8168's
PCI BAR due to the quirks, answering your question.

With commit 4a2e242bbb applied, the accesses will be routed to the correct region.
For example, accesses to 0000042000000000-0000042000000020 are routed to (3), (4)
and (5) based on their addresses. Region (4) and (5) aren't bypassed. It's what I
understood and hopefully nothing has been missed. It's why we're not expecting
memcpy() on region (3).

----

Back to our case (GH100 card), there are no quirks for the PCI BAR (0009:01:00.0 BAR 4)
so it's fine mark the RAM DEVICE region as directly accessible. We perhaps needn't host
to export the capability (VFIO_REGION_INFO_CAP_DIRECT_ACCESS) suggested by you. It's
safe to mark any PCI BARs as directly accessible if they have no quirks attached. All
the devices except those listed in vfio_bar_quirk_setup() are capable of this.

Again, I'm not sure if I understood every details. Alex is the best person to confirm,
but I believe Peter Xu understood this much better than me.

Thanks,
Gavin


