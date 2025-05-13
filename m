Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED76C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 12:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEoJ0-0004pT-6a; Tue, 13 May 2025 08:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEoIu-0004oD-U7; Tue, 13 May 2025 08:00:13 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uEoIs-0003ZG-AS; Tue, 13 May 2025 08:00:12 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0B5DF55CA5C;
 Tue, 13 May 2025 14:00:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XT7LZgVRll34; Tue, 13 May 2025 14:00:03 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CDE7C55CA61; Tue, 13 May 2025 14:00:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CBC60745682;
 Tue, 13 May 2025 14:00:03 +0200 (CEST)
Date: Tue, 13 May 2025 14:00:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3] ppc/vof: Make nextprop behave more like Open Firmware
In-Reply-To: <2bdfcf77-ff5d-4c26-839e-23f831f4abe1@app.fastmail.com>
Message-ID: <a947a1c1-c4cc-d2bd-9a59-f5ce97c6ea1d@eik.bme.hu>
References: <20250423101931.A0A6B55D23A@zero.eik.bme.hu>
 <cacfd877-8a93-1a1f-21c6-43743cc1bfc4@eik.bme.hu>
 <2bdfcf77-ff5d-4c26-839e-23f831f4abe1@app.fastmail.com>
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

On Tue, 13 May 2025, Alexey Kardashevskiy wrote:
> On Wed, 30 Apr 2025, at 21:21, BALATON Zoltan wrote:
>> On Wed, 23 Apr 2025, BALATON Zoltan wrote:
>>> The FDT does not normally store name properties but reconstructs it
>>> from path but Open Firmware specification says each node should at
>>> least have this property. This is correctly handled in getprop but
>>> nextprop should also return it even if not present as a property.
>>>
>>> Explicit name properties are still allowed because they are needed
>>> e.g. on the root node that guests expect to have specific names as
>>> seen on real machines instead of being empty so sometimes the node
>>> name may need to be overriden. For example on pegasos MorphOS checks
>>> the name of "/" and expects to find bplan,Pegasos2 which is how it
>>> identifies the machine.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> v3:
>>> Keep phandle properties
>>> Changed commit message
>>
>> Ping?
>>
>
> sorry for the delay, looks okay to me but (probably was answered but I 
> forgot because I am slow) I still do not understand what is adding the 
> explicit property called "name" so vof_nextprop() needs to check if it 
> is the actual property. Thanks,

Look at this series where this is used (I also included this patch there 
as patch 2 which is identical to this v3 standalone patch):

https://patchew.org/QEMU/cover.1746139668.git.balaton@eik.bme.hu/

This patch allows removing explicit name properties in patch 3 and move 
the static parts into a dtb file in patch 4. Dtb does not allow to set 
name property and will use the path name for it but e.g. the root of the 
device tree on some machines must have a specific name. On Apple it's 
called device-tree and on pegasos it's bPlan,Pegasos and some guests (e.g. 
MorphOS) checks this to detect what machine they run on so will fail it we 
return / or no name for the name of the root node. Therefore in patch 4 I 
still have a

qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");

to make this work, and for some nodes it may still be needed although for 
most the path name from dtb will be correct so no need to add a name 
property for those. But becuase of these nodes that need a name different 
from their path we still need to allow explicit name properties.

Regards,
BALATON Zoltan

