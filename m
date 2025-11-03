Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97041CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 12:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFtlG-0000Qt-Mn; Mon, 03 Nov 2025 07:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFtlD-0000NA-6l; Mon, 03 Nov 2025 07:34:11 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vFtl9-0007Sk-Hx; Mon, 03 Nov 2025 07:34:10 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A7A525972E8;
 Mon, 03 Nov 2025 13:33:55 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id kHCVJlzfxVBv; Mon,  3 Nov 2025 13:33:53 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 896505972E3; Mon, 03 Nov 2025 13:33:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8787C5972E2;
 Mon, 03 Nov 2025 13:33:53 +0100 (CET)
Date: Mon, 3 Nov 2025 13:33:53 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] hw/ppc/pegasos: Fix memory leak
In-Reply-To: <078c2da0-ac1e-4f07-a777-d8615a4456bd@linux.ibm.com>
Message-ID: <5cabe3a8-77a0-b21d-8b73-bbbea049930c@eik.bme.hu>
References: <20251101165236.76E8B5972E3@zero.eik.bme.hu>
 <078c2da0-ac1e-4f07-a777-d8615a4456bd@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 3 Nov 2025, Harsh Prateek Bora wrote:
> Hi Balaton,
>
> Thanks for taking care of this ...
>
> On 11/1/25 22:22, BALATON Zoltan wrote:
>> Commit 9099b430a4 introduced an early return that caused a leak of a
>> GString. Allocate it later to avoid the leak.
>> 
>
> I think we also want to mention:
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>

You can add it on merge.

>> Fixes: 9099b430a4 (hw/ppc/pegasos2: Change device tree generation)
>> Resolves: Coverity CID 1642027
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/pegasos.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
>> index 3a498edd16..8ce185de3e 100644
>> --- a/hw/ppc/pegasos.c
>> +++ b/hw/ppc/pegasos.c
>> @@ -847,7 +847,7 @@ static struct {
>>   static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
>>   {
>>       FDTInfo *fi = opaque;
>> -    GString *node = g_string_new(NULL);
>> +    GString *node;
>
> Curious to know if there were any technical reasons for not using g_autoptr 
> which Peter initially suggested ?

Just thought it's simpler and more straight forward this way and saves a 
bit of unnecessary complication. We don't even allocate the string now 
when we exit, with g_autoptr it might do some additional operations 
unnecessarily. As this function otherwise does not have multiple exit 
points just one free at the end works.

> Anyways, it fixes the leak, so
>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

Thanks,
BALATON Zoltan

>
>>       uint32_t cells[(PCI_NUM_REGIONS + 1) * 5];
>>       int i, j;
>>       const char *name = NULL;
>> @@ -871,6 +871,7 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, 
>> void *opaque)
>>               break;
>>           }
>>       }
>> +    node = g_string_new(NULL);
>>       g_string_printf(node, "%s/%s@%x", fi->path, (name ?: pn),
>>                       PCI_SLOT(d->devfn));
>>       if (PCI_FUNC(d->devfn)) {
>
>

