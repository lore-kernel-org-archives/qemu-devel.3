Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5B5C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 10:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ6bV-0006HX-EH; Wed, 31 Jul 2024 06:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZ6bT-00069H-CF; Wed, 31 Jul 2024 06:30:43 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZ6bQ-0006vH-9w; Wed, 31 Jul 2024 06:30:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 30E8862299;
 Wed, 31 Jul 2024 10:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00FEC116B1;
 Wed, 31 Jul 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722421837;
 bh=oA/KJPRimoyaFLj/Zbtii0ZoV2tsjH6+qF9/B0/68+k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=nfvSrJwdLszRqfpL4rbrGEtaBdJgTB5+QcLHTcIHDIHp+qbaBBtYE4rgksUIAVgT/
 Ku3VEN0gHxmtYe7lNVEl+ZqUHykv6KGs0FfP1NZ2v5uYjtiJSWMzcx0PKgK1jaUYdy
 dLgCwV9m29WN+oC/IQEnYYLwnOCbxayVwuZkvHEYxxqLU29DZu0L3JiRfJ3FNdPerz
 psHqaRmWDCysTPcIRwu17sgkMhViOt/eH7ODffwxZ6bO1hbYPLKgA0vJMtszsafWd8
 ZR8wIoBAx5U6lCQWThCtL8aE2DO5XFZzVBeMMmMLgQfn2+CNVRbl1hWuFyCoNUPKRG
 +JGZUhvRRB37A==
Date: Wed, 31 Jul 2024 12:30:31 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240731122545.22b51457@foz.lan>
In-Reply-To: <20240731095719.000004dc@Huawei.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
 <20240731091133.07ddd58c@foz.lan>
 <20240731095719.000004dc@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

Em Wed, 31 Jul 2024 09:57:19 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> escreveu:

> On Wed, 31 Jul 2024 09:11:33 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Em Tue, 30 Jul 2024 13:17:09 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >   
> > > On Mon, 22 Jul 2024 08:45:56 +0200
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > 
> > > that's quite a bit of code that in 99% won't ever be used
> > > (assuming error injection testing scenario),
> > > not to mention it's a hw depended one and governed by different specs.
> > >
> > > Essentially we would need to create _whole_ lot of QAPI
> > > commands to cover possible errors for no benefit to QEMU.  
> 
> Fair point.  A 'few' error types might be helpful to general
> users like the original memory error injection this is built
> on which is reduce blast radius of a real error (and used in
> production VMM cases), but most are about testing the rest
> of the stack, not really QEMU.

My concern is that we may end needing QAPI for querying stuff
that will be used on such script.

On a more concrete example, let's suppose we want to produce a
HEST record for a CXL source, using the layout given by a QEMU
command line like this:

./qemu-system-aarch64 -M virt,nvdimm=on,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 \
 -cpu max -smp 4 -kernel Image -drive if=none,file=debian.qcow2,format=qcow2,id=hd \
 -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd \
 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off \
 -device virtio-net-pci,netdev=mynet,id=bob -nographic -no-reboot \
 -append 'earlycon root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4' \
 -monitor telnet:127.0.0.1:1234,server,nowait -bios QEMU_EFI.fd \
 -object memory-backend-ram,size=4G,id=mem0 -numa node,nodeid=0,cpus=0-3,memdev=mem0 \
 -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem2,share=on,mem-path=/tmp/cxltest2.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem3,share=on,mem-path=/tmp/cxltest3.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem4,share=on,mem-path=/tmp/cxltest4.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa2,share=on,mem-path=/tmp/lsa2.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa3,share=on,mem-path=/tmp/lsa3.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa4,share=on,mem-path=/tmp/lsa4.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-mem5,share=on,mem-path=/tmp/cxltest5.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem6,share=on,mem-path=/tmp/cxltest6.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem7,share=on,mem-path=/tmp/cxltest7.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-mem8,share=on,mem-path=/tmp/cxltest8.raw,size=256M,align=256M \
 -object memory-backend-file,id=cxl-lsa5,share=on,mem-path=/tmp/lsa5.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa6,share=on,mem-path=/tmp/lsa6.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa7,share=on,mem-path=/tmp/lsa7.raw,size=1M,align=1M \
 -object memory-backend-file,id=cxl-lsa8,share=on,mem-path=/tmp/lsa8.raw,size=1M,align=1M \
 -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
 -device cxl-rp,port=0,bus=cxl.1,id=root_port0,chassis=0,slot=2 \
 -device cxl-rp,port=1,bus=cxl.1,id=root_port2,chassis=0,slot=3 \
 -device virtio-rng-pci,bus=root_port2 \
 -device cxl-upstream,port=33,bus=root_port0,id=us0,multifunction=on,addr=0.0 \
 -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
 -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
 -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
 -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
 -device cxl-type3,bus=swport0,memdev=cxl-mem1,id=cxl-pmem0,lsa=cxl-lsa1,sn=3 \
 -device cxl-type3,bus=swport1,memdev=cxl-mem2,id=cxl-pmem1,lsa=cxl-lsa2,sn=4 \
 -device cxl-type3,bus=swport2,memdev=cxl-mem3,id=cxl-pmem2,lsa=cxl-lsa3,sn=5 \
 -device cxl-type3,bus=swport3,memdev=cxl-mem4,id=cxl-pmem3,lsa=cxl-lsa4,sn=6 \
 -machine cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=1k \
 -machine ras=on

There is a complex set of CXL devices there. Doing error injection
will need to know exactly how such devices were created and the
memory got allocated, as, when testing an userspace application
running at the guest OS (like rasdaemon), we need an address that
makes sense, otherwise the memory poison of rasdaemon won't be
disabling the right address set.

So, while a HEST QAPI raw interface will have a very trivial API,
and the ghes code being also simpler, we'll need a QAPI interface
good enough to describe all CXL specific details for the error
injection script to produce a proper HEST record, if this ends
being mapped using such QAPI.

> 
> So it's very helpful for a smallish group of users.
> 

My end goal is to be able to use QEMU to validate and identify 
regressions at the Linux Kernel RAS subsystem and at the userspace 
daemon responsible to receive, log and take actions based on the 
error information (on other words, rasdaemon). Not only for
ARM, but also for x86 (and maybe in the future for other archs,
depending on how they end implementing RAS features).

At the end of the day, I'd like to have a github action running QEMU
to check  rasdaemon proposed patches against a docker container with
the latest version of Linux and QEMU.

> > > Let take for example very simple _OST status reporting,
> > > QEMU of cause can decode values and present it to users in
> > > more 'presentable' form. However instead of translating
> > > numbers (aka. spec language) into a made up QEMU language,
> > > QEMU just passes values up the stack and users can use
> > > well defined spec to interpret its meaning.
> > > 
> > > benefits are: QEMU doesn't have to maintain translation
> > > code and QAPI ABI is limited to passing raw values.
> > > 
> > > Can we do similar thing here as well?
> > > i.e. simplify error injection commands to
> > > a command that takes raw value and passes it
> > > to guest (QEMU here acts as proxy, if I'm not
> > > mistaken)?
> > > 
> > > Preferably make it generic enough to handle
> > > not only ARM but other error formats HEST is
> > > able to handle.    
> > 
> > A too generic interface doesn't sound feasible to me, as the
> > EINJ code needs to check QEMU implementation details before
> > doing the error inject.  
> 
> To be clear we are talking here about a script that
> generates 'similar' stuff to ACPI EINJ does and injects
> via qapi, not guest injection (which is almost always locked
> down on production machines / distros because of the footgun
> aspect).  + ACPI EINJ interface suffers exactly the same
> problems with state discoverability we have with a raw interface here.
> (I checked with Mauro offline that I'd interpreted this
> comment correctly!)

Yes, the end goal is to inject GHESv2 errors using a generic
event device, e. g.:

	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#generic-hardware-error-source-version-2-ghesv2-type-10

> > See, processor is probably the simplest error injection
> > source, as most of the fields there aren't related to how
> > the hardware simulation is done.
> > 
> > Yet, if you see patch 7 of this series, you'll notice that some
> > fields should actually be filled based on the emulation.
> > 
> > On ARM, we have some IDs that depend on the emulation
> > (MIDR, MPIDR, power state). Doing that on userspace may require
> > a QAPI to query them.  
> 
> We could strip back the QAPI part to only the bits that are
> not dependent on state. 

Works for me.

> However, the kicker to that is we'd
> need to make sure all that state is available to an external
> tool (or fully controllable from initial launch command line).
> I'm not sure where the gaps are but, I'm fairly sure there
> will be some.  Doesn't save much code other than documentation
> of the QAPI.

For CPU error injection, certainly the amount of code for the error
injection won't change much. The code will be split into QEMU C code 
and Python's code (inside a qemu-einj.py script). As raw data won't
be validated, some code may actually be removed.

On the other hand, some new query QAPI interfaces will be needed,
specially when handling memory-related HEST data, as the memory 
layout with enough details for the script to properly produce errors
will be needed.

So, we're talking on adding a couple of additional QAPIs. The
advantage is that such QAPIs will be independent of the ghes
driver, but some may be arch-specific, like the ones reporting fields
like ARM mpidr, midr, power_state, for instance. On an initial
implementation, we can live without those, but for the ARM processor
error injection.

I'll try to craft a proposal with a very minimal QAPI for GHESv2
injection, implementing it for ARM processor (and maybe for some other
type, to check if the interface will fit). Let's see how it goes.

> > The memory layout, however, is the most complex one. Even for
> > an ARM processor CPER (which is the simplest scenario), the 
> > physical/virtual address need to be checked against the emulation
> > environment.
> > 
> > Other error sources (like memory errors, CXL, etc) will require
> > a deep knowledge about how QEMU mapped such devices.  
> 
> For CXL stuff we'll piggy back on native error injection interfaces
> that are already there and couldn't be avoided because they
> are writing a bunch of register state (that we elide in the FW
> first path). 
> https://lore.kernel.org/qemu-devel/20240205141940.31111-12-Jonathan.Cameron@huawei.com/
> So we won't be adding new QAPI, but the error record generation logic
> will be in QEMU.  For background, the CXL FW first error injection
> has taken a back seat to the ARM errors because of the obvious
> other factor that CXL isn't supported on ARM in upstream QEMU.

Makes sense to me.

> Once I escape a few near term deadlines I'll add the x86
> support for GHESv2 / SCI interrupt signaling as you'd see on a
> typical x86 server.

Well, if we go to a generic GHESv2 QAPI interface, the arm/virt.c
will have everything in place to generate GHESv2. It could be used
to simulate a x86 processor event, as the changes will happen at
the script side. We'll still need to add the needed bits at x86
virt code, though, if we want the error injection to be tested
against a guest doing x86 emulation.

> > 
> > So, in practice, if we move this to an EINJ script, we'll need
> > to add a probably more complex QAPI to allow querying the memory
> > layout and other device and CPU specific bindings.
> > 
> > Also, we don't know what newer versions of ACPI spec will reserve
> > us. See, even the HEST table contents is dependent of the HEST 
> > revision number, as made clear at the ACPI 6.5 notes:
> > 
> > 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source
> > 
> > and at:
> > 
> > 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-source-structure-header-type-12-onward
> > 
> > So, if we're willing to add support for a more generic "raw data"
> > QAPI, I would still do it per-type, and for the fields that won't
> > require knowledge of the device-emulation details.  
> 
> Could blend the two options and provide no qapi for the bits
> that are QEMU state dependent - if fuzzing, can inject
> the full record raw as doesn't have to be valid state anyway.

Not sure. I guess it will depend if we'll be using a simple raw data
buffer for CPER record(s) or if we'll break it per CPER type.

The GHES interface for generic CPER records would be simpler, but it
may require some QEMU query QAPIs for the script to be able to get
what it is needed..

Let me try to code it and see how it goes.

> > Btw, my proposal on patch 7 of this series is to have raw data
> > for:
> > 	- the error-info field;
> > 	- registers dump;
> > 	- micro-architecture specific data.
> > 
> > I don't mind trying to have more raw data there as I see (marginal) 
> > benefits of allowing to generate CPER invalid records [1], but some of
> > those  fields need to be validated and/or filled internally at QEMU - if
> > not forced to an specific value by the caller.
> > 
> > [1] a raw data EINJ can be useful for fuzzy logic fault detection to 
> >     check if badly formed packages won't cause a Kernel panic or be
> >     an exploit. Yet, not really a concern for APEI, as if the hardware
> >     is faulty, a Kernel panic is not out of the table. Also, if the
> >     the BIOS is already compromised and has malicious code on it, 
> >     the EINJ interface is not the main concern.
> >   
> > > PS:
> > > For user convenience, QEMU can carry a script that
> > > could help generate this raw value in user friendly way
> > > but at the same time it won't put maintenance
> > > burden on QEMU itself.    
> > 
> > The script will still require reviews, and the same code will 
> > be there. So, from maintenance burden, there won't be much
> > difference.  
> 
> Agreed. I'd also be very keen that the script is tightly coupled to
> QEMU as doesn't make sense to carry with kernel or RAS daemon and
> I'd want to ultimately get this stuff into all the appropriate
> CI flows.

Agreed: placing it together with QEMU is indeed the best location.

> > 
> > Btw, I'm actually using myself a script to test it, currently
> > sitting together with rasdaemon - which is the Linux tool to detect
> > and handle hardware errors:
> > 
> > 	https://github.com/mchehab/rasdaemon/blob/master/contrib/qemu_einj.py
> > 
> > as it helps a lot when trying to simulate more complex errors.
> > 
> > Once QEMU gains support to inject processor errors, I can prepare a 
> > separate patch to move it to QEMU.
> > 
> > Thanks,
> > Mauro  
> 
> So tricky questions. I'm not sure which way is the least painful!

Agreed.

Thanks,
Mauro

