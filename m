Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D64EE208C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJcO-0002HJ-OP; Fri, 06 Feb 2026 06:03:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voJcM-0002H5-E1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:03:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1voJcI-0004q2-8W
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:03:18 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6rm75pTLzHnH53;
 Fri,  6 Feb 2026 19:03:03 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 198E540573;
 Fri,  6 Feb 2026 19:03:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 11:03:07 +0000
Date: Fri, 6 Feb 2026 11:03:05 +0000
To: Gregory Price <gourry@gourry.net>
CC: Andrew Morton <akpm@linux-foundation.org>, Cui Chao
 <cuichao1753@phytium.com.cn>, <dan.j.williams@intel.com>, Mike Rapoport
 <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <20260206110305.00001fbb@huawei.com>
In-Reply-To: <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
References: <20260106031042.1606729-1-cuichao1753@phytium.com.cn>
 <20260106031042.1606729-2-cuichao1753@phytium.com.cn>
 <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
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

On Thu, 5 Feb 2026 18:10:55 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Thu, Feb 05, 2026 at 02:58:42PM -0800, Andrew Morton wrote:
> > On Mon, 26 Jan 2026 17:06:52 +0800 Cui Chao <cuichao1753@phytium.com.cn> wrote:
> >   
> > > > All that said, this does look harmless, and seems reasonable - but the
> > > > changelog should reflect what the hardware is doing above.  
> > > This issue was discovered on the QEMU platform. I need to apologize for 
> > > my earlier imprecise statement (claiming it was hardware instead of 
> > > QEMU). My core point at the time was to emphasize that this is a problem 
> > > in the general code path when facing this scenario, not a QEMU-specific 
> > > emulation issue, and therefore it could theoretically affect real 
> > > hardware as well. I apologize for any confusion this may have caused.  
> > 
> > This patch doesn't sounds very urgent.  Perhaps we should do a v3 with
> > updated changelog and handle that in the next -rc cycle?  
> 
> Mostly QEMU just needs to add SRAT entries associated with the
> CEDT/CFMWS it adds.

HI Gregory,

I got a bit carried away - but the following basically says: No QEMU should not
add SRAT Memory Affinity Structures. As to Andrew's question: I'm fine with this
fix taking a little longer.

I disagree. There is nothing in the specification to say it should do that and
we have very intentionally not done so in QEMU - this is far from the first
time this has come up!. We won't be doing so any time soon unless someone
convinces me with clear spec references and tight reasoning for why it is the
right thing to do.

The only time providing SRAT Memory Affinity Structures for CEDT CXL Fixed
Memory Window  Structures (CFMWSs) is definitely the right thing to do is
if the BIOS has also programmed the full set of decoders etc. That is something
we could do in QEMU as an option. Only if we do that would it be valid
to provide SRAT Memory structures for the CXL memory. I'd suggest that's
probably a job for EDK2 rather than QEMU but that's an implementation detail
and there is a dance between EDK2 and QEMU for creating some of the tables
anyway. This configuration reflects the pre hotplug / early CXL deployment
situation. Now we have proper support in Linux we have moved beyond that.
We do need to solve the dynamic NUMA node cases though and I'm hoping your
current work will make that a bit easier.

Note that I give the same advice to our firmware folk I talk to. This stuff
is policy - it belongs in OS control, not in a bunch of config menus in the
BIOS or output of some unknown heuristic. BIOS authors are not clairvoyant.
They have no way to know (in a non trivial topology) what makes sense for a
given use case or what devices are going to be hotplugged later.
I'd increasingly expect shipping BIOSes to have a "hands off" option in which
they make not attempt to guess about what is beyond the host bridges.

One argument I have heard for why a BIOS could know an appropriate CFMWS to
SRAT memory structure mapping is the CFWMS / QTG (Quality of Service)
mapping implying a consistency of performance expectations in a given CFMWS.
However that's very specific to particular designs. For others PA space is
expensive thus they use one large CFMWS for everything and QoS handing in
the uarch relies on information derived from the host bridge decoders. Often
no one cares about cross host bridge interleave for same reason full system
DRAM interleave is a niche thing. PA space is too expensive to provide the
extra CFMWS to support it.

If we are looking at forwards looking systems, that are built to work with full
gamut of CXL then all that should be in SRAT for CXL topology is the Generic
Port Structures (provide a handle for perf data in HMAT to the edge
of the 'known world' - the host bridge / root ports). Nothing else.

If we do have BIOSes that are guessing what to put in SRAT and associated
HMAT etc then there is a fairly strong argument that a good OS
implementation should at most take such structures as a hint not a
rule (though obviously we don't do that today).

> 
> A system providing a CEDT/CFMWS entry without an SRAT entry is arguably
> bad BIOS.

I'd argue that if you aren't programming the decoder topology (and probably
locking everything down) and are providing SRAT then you are providing
a guess at best and that's a bad BIOS - not the other way around.

Note we've supported this from the first in Linux so it's not like there
is anything missing, just a corner case to tidy up.

> 
> But yeah, this is not urgent.

I'd like to see it fixed, but given we don't know of a system where
this applies today it doesn't need to be super rushed!

Jonathan

> 
> ~Gregory


