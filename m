Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D6ACCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 16:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDmeZ-0008CN-Qz; Tue, 28 Oct 2025 12:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDmeM-00086m-LG; Tue, 28 Oct 2025 12:34:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDmeC-0003Wt-0S; Tue, 28 Oct 2025 12:34:22 -0400
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59SGXfdJ078437
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 29 Oct 2025 01:33:41 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GycpbXY4fYRdDDh3FM9iiNwRlSs+QbvSmpcEVTygCN8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1761669221; v=1;
 b=aOtaeHh4wDXfgLrf/GvWYMWpkHzFRXsrFCyDhScSv2S3r6T0uTJriYQA3VeNJSb/
 En0lB8qeFvSeqFx+25vPIjE0ykWrfzCP50z5GTwmqAZMhQpztLJXeh3uF4MSzOrI
 oXEYiz4vpK/uFuRZdgPpGstQpWbK4Lb76leJXUI7UT9D5Y2L9mOtDZbEzVG5WHjz
 T8l7XPbMG4FO8EraOLObRn92dWYo/+iXoaI3uNrycZBKrCjYtyynN1vy9OsoPShz
 KQPRcL79EwnbysUSuYxw53QTPKQyJInD1LLQpG/zk/YYH7QOl02x3orSSPtlm4ek
 bMxmVGtwNA2QuKExwWS+FQ==
Message-ID: <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 29 Oct 2025 01:33:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/10/28 21:59, BALATON Zoltan wrote:
> On Tue, 28 Oct 2025, Philippe Mathieu-Daudé wrote:
>> On 27/10/25 20:47, BALATON Zoltan wrote:
>>> On Mon, 27 Oct 2025, Philippe Mathieu-Daudé wrote:
>>>> On 25/10/25 01:31, BALATON Zoltan wrote:
>>>>> These memory windows are a result of the address decoding in the
>>>>> Articia S north bridge so better model it there and not in board code.
>>>>>
>>>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>>> ---
>>>>>   hw/pci-host/articia.c | 15 ++++++++++++++-
>>>>>   hw/ppc/amigaone.c     | 28 +++++-----------------------
>>>>>   hw/ppc/pegasos2.c     | 13 -------------
>>>>>   3 files changed, 19 insertions(+), 37 deletions(-)
>>>>
>>>>
>>>>> @@ -169,6 +174,7 @@ static void articia_realize(DeviceState *dev, 
>>>>> Error **errp)
>>>>>   {
>>>>>       ArticiaState *s = ARTICIA(dev);
>>>>>       PCIHostState *h = PCI_HOST_BRIDGE(dev);
>>>>> +    MemoryRegion *mr;
>>>>>       PCIDevice *pdev;
>>>>>         bitbang_i2c_init(&s->smbus, i2c_init_bus(dev, "smbus"));
>>>>> @@ -180,6 +186,14 @@ static void articia_realize(DeviceState *dev, 
>>>>> Error **errp)
>>>>>       memory_region_init_io(&s->reg, OBJECT(s), &articia_reg_ops, s,
>>>>>                             TYPE_ARTICIA, 0x1000000);
>>>>>       memory_region_add_subregion_overlap(&s->reg, 0, &s->io, 1);
>>>>> +    mr = g_new(MemoryRegion, 1);
>>>>
>>>> Won't Coverity or other analysis tools complain about the leak?
>>>> (this is why we usually keep a reference in the device state, here
>>>> ArticiaState). Otherwise:
>>>
>>> According to https://www.qemu.org/docs/master/devel/ 
>>> memory.html#region- lifecycle
>>> there should be no leak and keeping a reference should not be 
>>> necessary as the lifetime is managed by attaching it to the owner 
>>> object so no need to keep a reference when it's not needed otherwise. 
>>> Not littering the state struct with unneded references makes it 
>>> easier to comprehend so I'd only keep things there that are necessary.
>>
>> IIUC this doc is about what happens within the allocated MemoryRegion,
>> regardless of where it is allocated.
> 
> That doc explicitely says:
> 
> "Destruction of a memory region happens automatically when the owner 
> object dies. When there are multiple memory regions under the same owner 
> object, the memory API will guarantee all memory regions will be 
> properly detached and finalized one by one. The order in which memory 
> regions will be finalized is not guaranteed."

Destruction in this context does not imply freeing the storage.

The documentation describes destruction in QOM. QOM performs the 
following steps during destruction:
1. Delete properties
2. Call finalization callbacks
3. Free the storage

However, 3 will not happen in this case since you allocate the storage 
by yourself and it is not managed by QOM.

Please also note that the documentation also says:
 > If however the memory region is part of a dynamically allocated data
 > structure, you should free the memory region in the instance_finalize
 > callback.  For an example see VFIOMSIXInfo and VFIOQuirk in
 > hw/vfio/pci.c.

> 
> (and these pci-host objects are created once at machine init and never 
> die so the question seems quite theoretical). I'd like to keep object 
> state simple and not keep around references in it that nothing uses and 
> should be managed automatically. I'd only add fields to the state struct 
> that other methods need.

It is indeed theoretical. That said, I prefer the memory region to be 
embedded into the device state struct as it will clarify that the 
lifetime of the memory region is bound to the device.

Regards,
Akihiko Odaki

