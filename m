Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C13C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQA9-0006ly-8x; Fri, 21 Feb 2025 05:21:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tlQA4-0006hf-PP; Fri, 21 Feb 2025 05:21:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tlQA2-0006jn-4R; Fri, 21 Feb 2025 05:21:36 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YzmMm39xkz67QqC;
 Fri, 21 Feb 2025 18:19:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 7629D140257;
 Fri, 21 Feb 2025 18:21:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 21 Feb
 2025 11:21:28 +0100
Date: Fri, 21 Feb 2025 10:21:27 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>, John Snow
 <jsnow@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Markus
 Armbruster" <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250221102127.000059e6@huawei.com>
In-Reply-To: <20250221073823.061a1039@foz.lan>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <20250203110934.000038d8@huawei.com>
 <20250203162236.7d5872ff@imammedo.users.ipa.redhat.com>
 <20250221073823.061a1039@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 21 Feb 2025 07:38:23 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 3 Feb 2025 16:22:36 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Mon, 3 Feb 2025 11:09:34 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > On Fri, 31 Jan 2025 18:42:41 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Now that the ghes preparation patches were merged, let's add support
> > > > for error injection.
> > > > 
> > > > On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> > > > table and hardware_error firmware file, together with its migration code. Migration tested
> > > > with both latest QEMU released kernel and upstream, on both directions.
> > > > 
> > > > The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
> > > >    to inject ARM Processor Error records.
> > > > 
> > > > If I'm counting well, this is the 19th submission of my error inject patches.      
> > > 
> > > Looks good to me. All remaining trivial things are in the category
> > > of things to consider only if you are doing another spin.  The code
> > > ends up how I'd like it at the end of the series anyway, just
> > > a question of the precise path to that state!    
> > 
> > if you look at series as a whole it's more or less fine (I guess you
> > and me got used to it)
> > 
> > however if you take it patch by patch (as if you've never seen it)
> > ordering is messed up (the same would apply to everyone after a while
> > when it's forgotten)
> > 
> > So I'd strongly suggest to restructure the series (especially 2-6/14).
> > re sum up my comments wrt ordering:
> > 
> > 0  add testcase for HEST table with current HEST as expected blob
> >    (currently missing), so that we can be sure that we haven't messed
> >    existing tables during refactoring.  

To potentially save time I think Igor is asking that before you do anything
at all you plug the existing test hole which is that we don't test HEST
at all.   Even after this series I think we don't test HEST.  You add
a stub hest and exclusion but then in patch 12 the HEST stub is deleted whereas
it should be replaced with the example data for the test.

That indeed doesn't address testing the error data storage which would be
a different problem.
> 
> Not sure if I got this one. The HEST table is part of etc/acpi/tables,
> which is already tested, as you pointed at the previous reviews. Doing
> changes there is already detected. That's basically why we added patches
> 10 and 12:
> 
> 	[PATCH v3 10/14] tests/acpi: virt: allow acpi table changes for a new table: HEST
> 	[PATCH v3 12/14] tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
> 
> What tests don't have is a check for etc/hardware_errors firmware inside 
> tests/data/acpi/aarch64/virt/, but, IMO, we shouldn't add it there.
> 
> See, hardware_errors table contains only some skeleton space to
> store:
> 
> 	- 1 or more error block address offsets;
> 	- 1 or more read ack register;
> 	- 1 or more HEST source entries containing CPER blocks.
> 
> There's nothing there to be actually checked: it is just some
> empty spaces with a variable number of fields.
> 
> With the new code, the actual number of CPER blocks and their
> corresponding offsets and read ack registers can be different on 
> different architectures. So, for instance, when we add x86 support,
> we'll likely start with just one error source entry, while arm will
> have two after this changeset.
> 
> Also, one possibility to address the issues reported by Gavin Shan at
> https://lore.kernel.org/qemu-devel/20250214041635.608012-1-gshan@redhat.com/
> would be to have one entry per each CPU. So, the size of such firmware
> could be dependent on the number of CPUs.
> 
> So, adding any validation to it would just cause pain and probably
> won't detect any problems.

If we did do this the test would use a fixed number of CPUs so
would just verify we didn't break a small number of variants. Useful
but to me a follow up to this series not something that needs to
be part of it - particularly as Gavin's work may well change that!

> 
> What could be done instead is to have a different type of tests that
> would use the error injection script to check if regressions are 
> introduced after QEMU 10.0. Such new kind of test would require
> this series to be merged first. It would also require the usage of
> an OSPM image with some testing tools on it. This is easier said 
> than done, as besides the complexity of having an OSPM test image,
> such kind of tests would require extra logic, specially if it would
> check regressions for SEA and other notification sources.
> 
Agreed that a more end to end test is even better, but those are
quite a bit more complex so definitely a follow up.

J
> Thanks,
> Mauro
> 


