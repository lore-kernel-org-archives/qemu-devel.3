Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E265C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 12:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzafC-0003Yw-A7; Tue, 01 Apr 2025 08:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tzaf4-0003YE-W1; Tue, 01 Apr 2025 08:24:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tzaez-0001dg-So; Tue, 01 Apr 2025 08:24:10 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DED684E6005;
 Tue, 01 Apr 2025 14:24:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id MXsGBs65XN8B; Tue,  1 Apr 2025 14:23:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D6EA14E600E; Tue, 01 Apr 2025 14:23:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D4F1674577C;
 Tue, 01 Apr 2025 14:23:59 +0200 (CEST)
Date: Tue, 1 Apr 2025 14:23:59 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v2] ppc/vof: Make nextprop behave more like Open Firmware
In-Reply-To: <D8UZF6NLQG6W.3IBC5MPZBFZ1J@gmail.com>
Message-ID: <7903877c-d442-fb9b-2233-2b848b114d73@eik.bme.hu>
References: <20250331142627.BAA2F4E6029@zero.eik.bme.hu>
 <D8UZF6NLQG6W.3IBC5MPZBFZ1J@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 1 Apr 2025, Nicholas Piggin wrote:
> On Tue Apr 1, 2025 at 12:26 AM AEST, BALATON Zoltan wrote:
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
>
> Boot a pseries machine with pseries (book3s 64-bit) Linux kernel
> with x-vof=on option.
>
> AFAIKS the two places Linux calls nextprop look like this
>
>               if (call_prom("nextprop", 3, 1, node, prev_name,
>                              pname) != 1)
>                        break;
>
>                /* skip "name" */
>                if (prom_strcmp(pname, "name") == 0) {
>                        prev_name = "name";
>                        continue;
>                }
>
> So, seems like skipping name is okay?

For Linux maybe OK to not have name but other OSes use it to identify 
devices so we need it. I tried to match what the real pegasos firmware 
returns but likely SLOF does the same if you do .properties in a node, I 
have not tried SLOF but I can try if that helps. I've seen some 
OpenFirmware output from Macs which also have name in property list and OF 
specification says each node should have a name property so I think it's 
not OK to skip it and not returning it from nextprop does not work for 
pegasos which now has to add explicit name properties in pegasos2.c to fix 
this.

> After iterating through properties it also has this:
>
>        /* Add a "phandle" property if none already exist */
>        if (!has_phandle) {
>                soff = dt_find_string("phandle");
>                if (soff == 0)
>                        prom_printf("WARNING: Can't find string index for <phandle> node %s\n", path);
>
> That warning does not seem to fire after your patch.

Is that good or bad? Was it firing before? If so, getting rid of it may be 
good but I can leave phandle there if it helps Linux. Other OSes don't 
seem to care but it does not seem to appear on real OF results that's why 
I also removed it but I could leave it in if you think it's better that 
way.

> spapr *seems* to be okay booting, but I would not be inclined to
> take this for 10.0 at least without review from someone who knows
> more than I do about OF since there can be subtle breakage.
>
> What actual problem is it causing for pegasos?

Sorry I did not make it clear this is for 10.1 not 10.0, that's why it 
does not say what does it fix. I want to clean up pegasos2.c a bit after 
the freeze and this allows me to remove all the explicit name properties 
which are now only needed because while the name property works with 
getprop, it is not queried due to missing from nextprop. I've just 
submitted this patch in advance to get it reviewed and hopefully merged 
after the freeze so I can submit the patches that depend on it later. I 
don't have any fixes for 10.0 so that should be fine for now, these are 
for after the freeze.

Regards,
BALATON Zoltan

