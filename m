Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E41C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZWll-0002vg-U0; Thu, 01 Aug 2024 10:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZWlk-0002pN-4Y; Thu, 01 Aug 2024 10:27:04 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZWlg-00059a-Tj; Thu, 01 Aug 2024 10:27:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id ECACCCE19AF;
 Thu,  1 Aug 2024 14:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE43C32786;
 Thu,  1 Aug 2024 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722522416;
 bh=rDxYwbBlVpDK1JuWRuGnNLHkJWYCXiccTbJEbCBu9FM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ld27awUm8k35yn4pUWyoXEhV7XNUBGGhIgrgocUuDgQ4aUOz3/4t4wgD76m3Et+rz
 Huar1PiuT4Vi8hzXnxX1Ty/HdehxFGZ+4ht80m7Fi0dI8RNDV7BrDIjmf9omJdTb/r
 GjhNEJ520ck/IX7papOAxQ4nSbS41mBtTelrCiG6GD0+7InBq7OeYjzNoE/CalEEt7
 7+u/cao34kgFabG+djoXCwODoe4AAlhVsZy8mi+6DeO+WW6R8PmW3yhYuYGasNUeB+
 WbeA64VlLN4MZp2KwNg/oI009cV67Dc7V7GuzxQcKnYo+je6f5iB+Btk8GdnUCwjwM
 CLsM/PNaSRPpA==
Date: Thu, 1 Aug 2024 16:26:50 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240801162650.3dcbd24e@foz.lan>
In-Reply-To: <20240801103623.2a74012e@imammedo.users.ipa.redhat.com>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
 <20240731091133.07ddd58c@foz.lan>
 <20240731095719.000004dc@Huawei.com>
 <20240801103623.2a74012e@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Em Thu, 1 Aug 2024 10:36:23 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Wed, 31 Jul 2024 09:57:19 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 31 Jul 2024 09:11:33 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Em Tue, 30 Jul 2024 13:17:09 +0200
> > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > >     
> > > > On Mon, 22 Jul 2024 08:45:56 +0200
> > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:  
> [...]
> > > > Preferably make it generic enough to handle
> > > > not only ARM but other error formats HEST is
> > > > able to handle.      
> > > 
> > > A too generic interface doesn't sound feasible to me, as the
> > > EINJ code needs to check QEMU implementation details before
> > > doing the error inject.    
> > 
> > To be clear we are talking here about a script that
> > generates 'similar' stuff to ACPI EINJ does and injects
> > via qapi, not guest injection (which is almost always locked
> > down on production machines / distros because of the footgun
> > aspect).  + ACPI EINJ interface suffers exactly the same
> > problems with state discoverability we have with a raw interface here.
> > (I checked with Mauro offline that I'd interpreted this
> > comment correctly!)
> >   
> > > 
> > > See, processor is probably the simplest error injection
> > > source, as most of the fields there aren't related to how
> > > the hardware simulation is done.
> > > 
> > > Yet, if you see patch 7 of this series, you'll notice that some
> > > fields should actually be filled based on the emulation.
> > > 
> > > On ARM, we have some IDs that depend on the emulation
> > > (MIDR, MPIDR, power state). Doing that on userspace may require
> > > a QAPI to query them.    
> 
> QEMU has qmp commands to query QOM tree, device properties is
> likely what you'd be interested with.
> Adding new QAPI might be not necessary as long as needed
> data point are exposed via device's properties.
> 
> And additional properties are relatively cheap, especially if their
> names prefixed with 'x-' which by convention means
> /internal use, not stable, not ABI/
> 
> Well whole qmp tree structure hasn't been declared as ABI (as far as I know),
> but it's relatively stable and we try not to mess with it much
> (especially for mainstream virt machines), as some external users
> might (ab)use it anyway (no promises on QEMU side though).
> 
> On contrary QAPI is mostly considered as ABI QEMU provides
> to its users with burden to maintain it stability.
> 
> If injection script is internal tool to QEMU, it should be fine
> for it to use qom introspection to get data and limit QAPI
> necessary minimum only.

OK, good. Anyway, after sleeping on it, I decided to not focus at
the query for now, as my goal is to validate Linux Kernel and 
rasdaemon. So, I'll just fill them when calling the error inject
script.

As a reference, for ARM Processor error injection, there are just 4
fields that would benefit for a query to fill the default values:

	- mpidr-el1
	- midr-el1
	- power_state
	- ARM context registers and its type

> To make sure it won't be broken silently by 'innocent' QEMU
> contributors, have a CI job to make sure that it still works
> as intended.
> 
> > We could strip back the QAPI part to only the bits that are
> > not dependent on state.  However, the kicker to that is we'd
> > need to make sure all that state is available to an external
> > tool (or fully controllable from initial launch command line).
> > I'm not sure where the gaps are but, I'm fairly sure there
> > will be some.  Doesn't save much code other than documentation
> > of the QAPI.
> >   
> > > 
> > > The memory layout, however, is the most complex one. Even for
> > > an ARM processor CPER (which is the simplest scenario), the 
> > > physical/virtual address need to be checked against the emulation
> > > environment.
> > > 
> > > Other error sources (like memory errors, CXL, etc) will require
> > > a deep knowledge about how QEMU mapped such devices.    
> > 
> > For CXL stuff we'll piggy back on native error injection interfaces
> > that are already there and couldn't be avoided because they
> > are writing a bunch of register state (that we elide in the FW
> > first path). 
> > https://lore.kernel.org/qemu-devel/20240205141940.31111-12-Jonathan.Cameron@huawei.com/
> > So we won't be adding new QAPI, but the error record generation logic
> > will be in QEMU.  For background, the CXL FW first error injection
> > has taken a back seat to the ARM errors because of the obvious
> > other factor that CXL isn't supported on ARM in upstream QEMU.
> > Once I escape a few near term deadlines I'll add the x86
> > support for GHESv2 / SCI interrupt signaling as you'd see on a
> > typical x86 server.
> >   
> > > 
> > > So, in practice, if we move this to an EINJ script, we'll need
> > > to add a probably more complex QAPI to allow querying the memory
> > > layout and other device and CPU specific bindings.
> > > 
> > > Also, we don't know what newer versions of ACPI spec will reserve
> > > us. See, even the HEST table contents is dependent of the HEST 
> > > revision number, as made clear at the ACPI 6.5 notes:
> > > 
> > > 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source
> > > 
> > > and at:
> > > 
> > > 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-source-structure-header-type-12-onward
> > > 
> > > So, if we're willing to add support for a more generic "raw data"
> > > QAPI, I would still do it per-type, and for the fields that won't
> > > require knowledge of the device-emulation details.    
> > 
> > Could blend the two options and provide no qapi for the bits
> > that are QEMU state dependent - if fuzzing, can inject
> > the full record raw as doesn't have to be valid state anyway.
> >   
> > > 
> > > Btw, my proposal on patch 7 of this series is to have raw data
> > > for:
> > > 	- the error-info field;
> > > 	- registers dump;
> > > 	- micro-architecture specific data.
> > > 
> > > I don't mind trying to have more raw data there as I see (marginal) 
> > > benefits of allowing to generate CPER invalid records [1], but some of
> > > those  fields need to be validated and/or filled internally at QEMU - if
> > > not forced to an specific value by the caller.
> > > 
> > > [1] a raw data EINJ can be useful for fuzzy logic fault detection to 
> > >     check if badly formed packages won't cause a Kernel panic or be
> > >     an exploit. Yet, not really a concern for APEI, as if the hardware
> > >     is faulty, a Kernel panic is not out of the table. Also, if the
> > >     the BIOS is already compromised and has malicious code on it, 
> > >     the EINJ interface is not the main concern.
> > >     
> > > > PS:
> > > > For user convenience, QEMU can carry a script that
> > > > could help generate this raw value in user friendly way
> > > > but at the same time it won't put maintenance
> > > > burden on QEMU itself.      
> > > 
> > > The script will still require reviews, and the same code will 
> > > be there. So, from maintenance burden, there won't be much
> > > difference.    
> 
> it makes a lot of difference if code is integral part qemu binary,
> (less people have to spend time on reviewing it, avoid increasing
> attack surface, ... (other made up reasons)).

I see.

> Implementing shim/proxy in QEMU and putting all error composing logic
> into a separate script (even if it's a part QEMU source), shifts
> most of the burden to whomever (I'd assume you'd volunteer yourself)
> would maintain the script.

Yes, I'll maintain it.

> If script breaks, it doesn't affect QEMU itself (nor I believe it
> should affect release process), script's maintainer(s) can have their
> own schedule/process on how to deal with it.

That's good.

> > Agreed. I'd also be very keen that the script is tightly coupled to
> > QEMU as doesn't make sense to carry with kernel or RAS daemon and
> > I'd want to ultimately get this stuff into all the appropriate
> > CI flows.  
> 
> Agreed, it makes much more sense to carry such script as a part of QEMU.

Ok, I'll be submitting a v4 using the CPER raw data plus script approach.
I'll be placing the script at the final patch.

I opted to make the simplest possible QAPI (keeping it marked as unstable),
as we might need/want to improve it to support other features.

Btw, as error injection is not trivial, and using the script is the best
way to do it, I would prefer to keep such QAPI always marked as unstable,
as it is preferred that QEMU users to use it (and submit patches improving
it) instead of manually crafting CPER records with their own scripts.

Thanks,
Mauro

