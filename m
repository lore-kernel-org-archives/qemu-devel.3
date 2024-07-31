Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17155C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ59O-0003ER-J4; Wed, 31 Jul 2024 04:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sZ59K-0003DF-A8; Wed, 31 Jul 2024 04:57:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sZ59H-0006FS-6w; Wed, 31 Jul 2024 04:57:33 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WYmBG5cv2z6K9Dq;
 Wed, 31 Jul 2024 16:54:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 16F911408F9;
 Wed, 31 Jul 2024 16:57:21 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 31 Jul
 2024 09:57:20 +0100
Date: Wed, 31 Jul 2024 09:57:19 +0100
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 4/7] acpi/ghes: Add a logic to handle block addresses
 and FW first ARM processor error injection
Message-ID: <20240731095719.000004dc@Huawei.com>
In-Reply-To: <20240731091133.07ddd58c@foz.lan>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <6a3542a7d8acfbf88c906ec6f6dc5a697257b461.1721630625.git.mchehab+huawei@kernel.org>
 <20240730131709.10e72c7d@imammedo.users.ipa.redhat.com>
 <20240731091133.07ddd58c@foz.lan>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 31 Jul 2024 09:11:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 30 Jul 2024 13:17:09 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Mon, 22 Jul 2024 08:45:56 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > 
> > that's quite a bit of code that in 99% won't ever be used
> > (assuming error injection testing scenario),
> > not to mention it's a hw depended one and governed by different specs.
> >
> > Essentially we would need to create _whole_ lot of QAPI
> > commands to cover possible errors for no benefit to QEMU.

Fair point.  A 'few' error types might be helpful to general
users like the original memory error injection this is built
on which is reduce blast radius of a real error (and used in
production VMM cases), but most are about testing the rest
of the stack, not really QEMU.

So it's very helpful for a smallish group of users.

> > 
> > Let take for example very simple _OST status reporting,
> > QEMU of cause can decode values and present it to users in
> > more 'presentable' form. However instead of translating
> > numbers (aka. spec language) into a made up QEMU language,
> > QEMU just passes values up the stack and users can use
> > well defined spec to interpret its meaning.
> > 
> > benefits are: QEMU doesn't have to maintain translation
> > code and QAPI ABI is limited to passing raw values.
> > 
> > Can we do similar thing here as well?
> > i.e. simplify error injection commands to
> > a command that takes raw value and passes it
> > to guest (QEMU here acts as proxy, if I'm not
> > mistaken)?
> > 
> > Preferably make it generic enough to handle
> > not only ARM but other error formats HEST is
> > able to handle.  
> 
> A too generic interface doesn't sound feasible to me, as the
> EINJ code needs to check QEMU implementation details before
> doing the error inject.

To be clear we are talking here about a script that
generates 'similar' stuff to ACPI EINJ does and injects
via qapi, not guest injection (which is almost always locked
down on production machines / distros because of the footgun
aspect).  + ACPI EINJ interface suffers exactly the same
problems with state discoverability we have with a raw interface here.
(I checked with Mauro offline that I'd interpreted this
comment correctly!)

> 
> See, processor is probably the simplest error injection
> source, as most of the fields there aren't related to how
> the hardware simulation is done.
> 
> Yet, if you see patch 7 of this series, you'll notice that some
> fields should actually be filled based on the emulation.
> 
> On ARM, we have some IDs that depend on the emulation
> (MIDR, MPIDR, power state). Doing that on userspace may require
> a QAPI to query them.

We could strip back the QAPI part to only the bits that are
not dependent on state.  However, the kicker to that is we'd
need to make sure all that state is available to an external
tool (or fully controllable from initial launch command line).
I'm not sure where the gaps are but, I'm fairly sure there
will be some.  Doesn't save much code other than documentation
of the QAPI.

> 
> The memory layout, however, is the most complex one. Even for
> an ARM processor CPER (which is the simplest scenario), the 
> physical/virtual address need to be checked against the emulation
> environment.
> 
> Other error sources (like memory errors, CXL, etc) will require
> a deep knowledge about how QEMU mapped such devices.

For CXL stuff we'll piggy back on native error injection interfaces
that are already there and couldn't be avoided because they
are writing a bunch of register state (that we elide in the FW
first path). 
https://lore.kernel.org/qemu-devel/20240205141940.31111-12-Jonathan.Cameron@huawei.com/
So we won't be adding new QAPI, but the error record generation logic
will be in QEMU.  For background, the CXL FW first error injection
has taken a back seat to the ARM errors because of the obvious
other factor that CXL isn't supported on ARM in upstream QEMU.
Once I escape a few near term deadlines I'll add the x86
support for GHESv2 / SCI interrupt signaling as you'd see on a
typical x86 server.

> 
> So, in practice, if we move this to an EINJ script, we'll need
> to add a probably more complex QAPI to allow querying the memory
> layout and other device and CPU specific bindings.
> 
> Also, we don't know what newer versions of ACPI spec will reserve
> us. See, even the HEST table contents is dependent of the HEST 
> revision number, as made clear at the ACPI 6.5 notes:
> 
> 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#acpi-error-source
> 
> and at:
> 
> 	https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-source-structure-header-type-12-onward
> 
> So, if we're willing to add support for a more generic "raw data"
> QAPI, I would still do it per-type, and for the fields that won't
> require knowledge of the device-emulation details.

Could blend the two options and provide no qapi for the bits
that are QEMU state dependent - if fuzzing, can inject
the full record raw as doesn't have to be valid state anyway.

> 
> Btw, my proposal on patch 7 of this series is to have raw data
> for:
> 	- the error-info field;
> 	- registers dump;
> 	- micro-architecture specific data.
> 
> I don't mind trying to have more raw data there as I see (marginal) 
> benefits of allowing to generate CPER invalid records [1], but some of
> those  fields need to be validated and/or filled internally at QEMU - if
> not forced to an specific value by the caller.
> 
> [1] a raw data EINJ can be useful for fuzzy logic fault detection to 
>     check if badly formed packages won't cause a Kernel panic or be
>     an exploit. Yet, not really a concern for APEI, as if the hardware
>     is faulty, a Kernel panic is not out of the table. Also, if the
>     the BIOS is already compromised and has malicious code on it, 
>     the EINJ interface is not the main concern.
> 
> > PS:
> > For user convenience, QEMU can carry a script that
> > could help generate this raw value in user friendly way
> > but at the same time it won't put maintenance
> > burden on QEMU itself.  
> 
> The script will still require reviews, and the same code will 
> be there. So, from maintenance burden, there won't be much
> difference.

Agreed. I'd also be very keen that the script is tightly coupled to
QEMU as doesn't make sense to carry with kernel or RAS daemon and
I'd want to ultimately get this stuff into all the appropriate
CI flows.

> 
> Btw, I'm actually using myself a script to test it, currently
> sitting together with rasdaemon - which is the Linux tool to detect
> and handle hardware errors:
> 
> 	https://github.com/mchehab/rasdaemon/blob/master/contrib/qemu_einj.py
> 
> as it helps a lot when trying to simulate more complex errors.
> 
> Once QEMU gains support to inject processor errors, I can prepare a 
> separate patch to move it to QEMU.
> 
> Thanks,
> Mauro

So tricky questions. I'm not sure which way is the least painful!

Jonathan



