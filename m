Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACBCEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNT8-0000HE-Eb; Fri, 06 Feb 2026 10:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voNSz-0000Gx-BY
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:09:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voNSw-0001pY-5S
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:09:53 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6yCl0cVZzJ46Ck;
 Fri,  6 Feb 2026 23:08:51 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 645DB40086;
 Fri,  6 Feb 2026 23:09:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 15:09:42 +0000
Date: Fri, 6 Feb 2026 15:09:41 +0000
To: Gregory Price <gourry@gourry.net>
CC: Andrew Morton <akpm@linux-foundation.org>, Cui Chao
 <cuichao1753@phytium.com.cn>, <dan.j.williams@intel.com>, Mike Rapoport
 <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <qemu-devel@nongnu.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <20260206150941.000028ae@huawei.com>
In-Reply-To: <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
References: <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
 <20260206110305.00001fbb@huawei.com>
 <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 6 Feb 2026 08:31:09 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Fri, Feb 06, 2026 at 11:03:05AM +0000, Jonathan Cameron wrote:
> > On Thu, 5 Feb 2026 18:10:55 -0500
> > Gregory Price <gourry@gourry.net> wrote:
> > 
> > I disagree. There is nothing in the specification to say it should do that and
> > we have very intentionally not done so in QEMU - this is far from the first
> > time this has come up!. We won't be doing so any time soon unless someone
> > convinces me with clear spec references and tight reasoning for why it is the
> > right thing to do.
> >   
> 
> Interestingly I've had this exact conversation - in reverse - with other
> platform folks, who think CFMWS w/o SRAT is broken.  It was a zealous
> enough opinion that I may have over-indexed on it (plus i've read the
> numa mapping code and making this more dynamic seems difficult).

I'd be curious to why they thought it was broken.  What info did they
think SRAT conveyed in this case?  Or was this, today's OS doesn't get
this right therefore it's broken?  It's only relative recently that
everything (perf reporting etc) has been in place without the SRAT
entries and associated SLIT + HMAT, so maybe that was their usecase.

Note I've run into a bunch of cases over the years of the 'correct'
description for a system in ACPI not working in Linux. Often
no one fixes that, they just lie in ACPI instead. :(

> 
> > This configuration reflects the pre hotplug / early CXL deployment
> > situation. Now we have proper support in Linux we have moved beyond that.
> > We do need to solve the dynamic NUMA node cases though and I'm hoping your
> > current work will make that a bit easier.  
> 
> If we want flexibility to ship HPAs around to different nodes at
> runtime, that might cause issues. The page-to-nid / pa-to-nid mapping
> code is somewhat expected to be immutable after __init, so there could
> be nasty assumptions sprinkled all over the kernel.

Why?  The numa-memblk stuff makes that assumption but the keeping that around
after initial boot is mostly just about 'where' to put the memory if we have
no other way of knowing. The node assignment for tradition memory
hotplug doesn't even look at numa-memblk - it uses the node provided
in the ACPI blob for the DIMM that is arriving.

The following is from the school of 'what if I' + 'what could possibly go
wrong?' - and a vague recollection of how this works in practice.

To do this with QEMU just spin up with something like (hand typed from
wrong machine so beware silly errors):

Now a fun corner is that a node isn't created unless there is something
in it - the whole SRAT is the source of truth for what nodes exist
- so we need 'something' in it - a cpu will do, or a GI, probably a GP.
Otherwise memory ends up in node0.  However, fallback lists etc happen
as normal when first mem in a node is added.

qemu-system-aarch64 -M virt,gic-verson=3 -m 4g,maxmem=8g,slots=4 -cpu max \
-smp 4 ... \
-monitor telnet:127.0.0.1:1234 \
-object memory-backend-ram,size=4G,id=mem0 \
-numa node,nodeid=0,cpus=0,memdev=mem0 \
-numa node,nodeid=1,cpus=1 \
-numa node,nodeid=2,cpus=2 \
-numa node,nodeid=3,cpus=3 

.. hmat stuff if you like.

Then from the monitor via telnet

object_add memory-backend-ram,id=mema,size=1G
object_add memory-backend-ram,id=memb,size=1G
object_add memory-backend-ram,id=memc,size=1G
object_add memory-backend-ram,id=memd,size=1G
device_add pc-dimm,id=dimm1,memdev=mema,node=0
device_add pc-dimm,id=dimm2,memdev=memb,node=1
device_add pc-dimm,id=dimm3,memdev=memc,node=2
device_add pc-dimm,id=dimm4,memdev=memd,node=3

and you'll get 1G added to the first node and 1G added to the 2nd one

SRAT has:

[078h 0120 001h]               Subtable Type : 01 [Memory Affinity]
[079h 0121 001h]                      Length : 28

[07Ah 0122 004h]            Proximity Domain : 00000000
[07Eh 0126 002h]                   Reserved1 : 0000
[080h 0128 008h]                Base Address : 0000000040000000
[088h 0136 008h]              Address Length : 0000000100000000
[090h 0144 004h]                   Reserved2 : 00000000
[094h 0148 004h]       Flags (decoded below) : 00000001
                                     Enabled : 1
                               Hot Pluggable : 0
                                Non-Volatile : 0
[098h 0152 008h]                   Reserved3 : 0000000000000000

[0A0h 0160 001h]               Subtable Type : 01 [Memory Affinity]
[0A1h 0161 001h]                      Length : 28

[0A2h 0162 004h]            Proximity Domain : 00000003
[0A6h 0166 002h]                   Reserved1 : 0000
[0A8h 0168 008h]                Base Address : 0000000140000000
[0B0h 0176 008h]              Address Length : 0000000200000000
[0B8h 0184 004h]                   Reserved2 : 00000000
[0BCh 0188 004h]       Flags (decoded below) : 00000003
                                     Enabled : 1
                               Hot Pluggable : 1
                                Non-Volatile : 0
[0C0h 0192 008h]                   Reserved3 : 0000000000000000

So it thought the extra space in SRAT was in PXM 3...
A fun question for another day is why that is twice as big as it should be
given the presence of 4G at boot on domain 0 (which is taken into account
when you try to hotplug anything!)

Resulting kernel log:

memblock_add_node: [0x0000000140000000-0x000000017fffffff] nid=0 flags=0 add_memory_resource+0x110/0x5a0
memblock_add_node: [0x0000000180000000-0x00000001bfffffff] nid=1 flags=0 add_memory_resource+0x110/0x5a0
memblock_add_node: [0x00000001c0000000-0x00000001ffffffff] nid=2 flags=0 add_memory_resource+0x110/0x5a0
memblock_add_node: [0x0000000200000000-0x000000023fffffff] nid=3 flags=0 add_memory_resource+0x110/0x5a0

I ran some brief stress tests - basic stuff all looks fine.

FWIW before numa-memblk got fixed up on Arm CXL memory always showed up on
node 0 even if we had CFWMS entries and had instantiated nodes for them.
I don't recall anything functionally breaking (other than obvious
performance issue of it appearing to have much better performance than
it actually did).

It will take more work to make this stuff as dynamic as we'd like but at
least from dumb testing it looks like there is nothing fundamental.
(I'm too lazy to spin a test up on x86 just to check if it's different ;)

For now I 'suspect' we could hack things to provide lots of waiting numa nodes
and merrily assign HPA into them as we like whatever SRAT provides
in the way of 'hints' :) 



> 
> That will take some time.
> ---
> 
> Andrew if Jonathan is good with it then with changelog updates this can
> go in, otherwise I don't think this warrants a backport or anything.

Wait and see if anyone hits it on a real machine (or even non creative QEMU
setup!)  So for now no need to backport.

Jonathan

> 
> ~Gregory


