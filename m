Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994C4C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 00:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0r7L-0004Fm-Pq; Fri, 04 Apr 2025 20:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u0r6z-0004E3-TE; Fri, 04 Apr 2025 20:10:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u0r6t-0001cJ-WE; Fri, 04 Apr 2025 20:10:13 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5170E4E6010;
 Sat, 05 Apr 2025 02:09:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id vTsKuTI0HdaY; Sat,  5 Apr 2025 02:09:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3EF044E6004; Sat, 05 Apr 2025 02:09:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3AF3374577D;
 Sat, 05 Apr 2025 02:09:57 +0200 (CEST)
Date: Sat, 5 Apr 2025 02:09:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/vof: Make nextprop behave more like Open Firmware
In-Reply-To: <d8d883c3-afcd-44bd-aa71-6ca23d1dd9c3@app.fastmail.com>
Message-ID: <e12b9999-d51a-91ec-a778-e1bdfec2404b@eik.bme.hu>
References: <20250331142627.BAA2F4E6029@zero.eik.bme.hu>
 <d8d883c3-afcd-44bd-aa71-6ca23d1dd9c3@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 4 Apr 2025, Alexey Kardashevskiy wrote:
> On Tue, 1 Apr 2025, at 01:26, BALATON Zoltan wrote:
>> The FDT does not normally store name properties but reconstructs it
>> from path but each node in Open Firmware should at least have this
>> property. This is correctly handled in getprop but nextprop should
>> also return it even if not present as a property. This patch fixes
>> that and also skips phandle which does not appear in Open Firmware
>> and only added for internal use by VOF.
>>
>> Explicit name properties are still allowed because they are needed
>> e.g. on the root node that guests expect to have specific names as
>> seen on real machines instead of being empty so sometimes the node
>> name may need to be overriden.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> I've tested this with pegasos2 but don't know how to test spapr.
>> v2:
>> Fixed a typo in commit message
>> Simplified loop to get next property name
>>
>> hw/ppc/vof.c | 51 ++++++++++++++++++++++++++++++++++-----------------
>> 1 file changed, 34 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>> index 09cb77de93..790d67c096 100644
>> --- a/hw/ppc/vof.c
>> +++ b/hw/ppc/vof.c
>> @@ -353,34 +353,51 @@ static uint32_t vof_nextprop(const void *fdt, uint32_t phandle,
>> {
>>      int offset, nodeoff = fdt_node_offset_by_phandle(fdt, phandle);
>>      char prev[OF_PROPNAME_LEN_MAX + 1];
>> -    const char *tmp;
>> +    const char *tmp = NULL;
>> +    bool match = false;
>>
>>      if (readstr(prevaddr, prev, sizeof(prev))) {
>>          return PROM_ERROR;
>>      }
>> -
>> -    fdt_for_each_property_offset(offset, fdt, nodeoff) {
>> -        if (!fdt_getprop_by_offset(fdt, offset, &tmp, NULL)) {
>> -            return 0;
>> +    /*
>> +     * "name" may or may not be present in fdt but we should still return it.
>
> yeah we should, at least, to match "getprop". I also wonder if VOF does 
> not add "name", then what would do so, do we really expect to see such 
> properties anywhere? Because if not, then we do not need to skip it as 
> we won't find it.

I have to add it to fdt where needed. For example on pegasos MorphOS 
checks the name of "/" and expects to find bplan,Pegasos2 which is how it 
identifies the machine. So we need a specific name property there which is 
one example when there will be explicit name property in the fdt. Maybe 
it's needed on some other nodes sometimes but normally the default will be 
sufficient but not always.

>> +     * Do that first and then skip it if seen later. Also skip phandle which is
>
> (a nit) appears to me that if handling of a missing "name" was done 
> after the last property, the patch would look simpler, but not sure and 
> do not insist.

I put name first to match what OpenFirmware does which returns name first. 
SLOF seems to do everything backwards (maybe a result of parsing the fdt 
to build the device tree) and returns properties with inverted order so 
name is last on SLOF but even then the order is matched by putting name 
first when we return properties in the normal order otherwise it would not 
be in same order when reversed. I don't know if it's significant, some 
guests may expect to get a name first but most would probably look for the 
name not its position. The order now matches OpenFirmware and pegasos2 
SmartFirmware and SLOF backwards so I think name is now where it should be 
so I'd leave it first. The loop may become simpler if we don't skip 
phandle only name, the complexity is mostly from sometimes we need to skip 
both in a row.

>> +     * an internal value we added in vof_build_dt but should not appear here.
>
> I would not hide anything though, unless it breaks something. Thanks,

I did some tests with SLOF. This is what I get from SLOF:

package 0x1e64a890 /vdevice/v-scsi@71000003:
         slof,from-fdt          0
         reg                    71000003
         device_type            "vscsi"
         compatible             "IBM,v-scsi"
         interrupts             [0x8 bytes, 2 cells]
         [000] 00001103 00000000
         ibm,#dma-address-cells 2
         ibm,#dma-size-cells    2
         ibm,my-dma-window      "q"
         #address-cells         2
         #size-cells            0
         name                   "v-scsi"

This is VOF before patch:

package 0x00001122 /vdevice/v-scsi@71000003:
         phandle                1122
         #size-cells            0
         #address-cells         2
         ibm,my-dma-window      "q"
         ibm,#dma-size-cells    2
         ibm,#dma-address-cells 2
         interrupts             [0x8 bytes, 2 cells]
         [000] 00001103 00000000
         compatible             "IBM,v-scsi"
         device_type            "vscsi"
         reg                    71000003

and this is VOF after patch:

package 0x00001122 /vdevice/v-scsi@71000003:
         name                   "v-scsi"
         #size-cells            0
         #address-cells         2
         ibm,my-dma-window      "q"
         ibm,#dma-size-cells    2
         ibm,#dma-address-cells 2
         interrupts             [0x8 bytes, 2 cells]
         [000] 00001103 00000000
         compatible             "IBM,v-scsi"
         device_type            "vscsi"
         reg                    71000003

Apart from SLOF returning properties backwards this now matches better. 
SLOF or other Open Firmware implementations don't return phandle property 
because that's what you pass to nextprop or getprop to get the property in 
the first place (listed next to package above) and it is returned by 
finddevice so not normally stored as a property. But if Linux would add it 
and it helps Linux to have it there already we can keep it, it did not 
break OSes on pegasos as they only parse properties they need and ignore 
the rest. So I can skip skipping phandle and add that back if it would be 
better for Linux but didn't removing it fixed a warning about it too?

By the way, phandle is identifying the node so can't we use the fdt offset 
for it so we don't have to add phandle properties? Or does offset change 
when editing the fdt? I think libfdt also uses offsets to identify nodes 
so maybe these should be somewhat stable.

Regards,
BALATON Zoltan

