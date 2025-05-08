Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD450C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 08:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCwaV-0006Vg-3S; Thu, 08 May 2025 04:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCwaT-0006SZ-Co
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:26:37 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCwaP-0007gM-UG
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746692794; x=1778228794;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=j9w5RAXLNqtonoshyUaBzo7N5QRsOFAt4LXyfk5+g+I=;
 b=kQ4M1q5wVgl0yg/LQV9KrYaQq4FMCrAHtrYKsgHLtMA+r2ABTkuJVFX9
 d2Cu+J9NtyFhb4sBWU63eiLXJdxfel3GJNpWyABuBkpYMZgd0hjalf35k
 u585WP6DFZlIW1FDB3vgv98Ez5B5VzQFapQfe5aQeDbVjFT3wfekCQWuI
 YgjRMIK03GEY00C8jv17YONM/NXK9YPfFLy5DFDPwdffsNdcTpH+nR3bi
 m2TcHdFVJN5qGOKIERSiCYzgBTdsMUMrIZ+kEsiBw1TqOpqyP3UDAsz3M
 f5RM1HsON6wlxqQsu0beBq3vaRX24p7Jl/wbQyzGQfOoF4v8VG6p6i7yH A==;
X-CSE-ConnectionGUID: rqnND+NuTXidxkQ8s2DqIw==
X-CSE-MsgGUID: pCf+L3CYQ3CA9rmfgXDgnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="59449480"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="59449480"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 01:26:29 -0700
X-CSE-ConnectionGUID: MgDNbu7aRKC2J+PMs/bmLA==
X-CSE-MsgGUID: 14H8LvYUSZicaY97HJYKnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; d="scan'208";a="140257621"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 08 May 2025 01:26:19 -0700
Date: Thu, 8 May 2025 16:47:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Neo Jia <cjia@nvidia.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 "Wedgwood, Chris" <cw@f00f.org>, dhedde@kalrayinc.com,
 Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Jidong Xiao <jidong.xiao@gmail.com>, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Meirav Dean <mdean@redhat.com>,
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Wu, Zhiyong" <zwu.kernel@gmail.com>
Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
Message-ID: <aBxvmV7F+lI6YDGn@intel.com>
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
 <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
 <87a57ydj8y.fsf@pond.sub.org>
 <5ce00003-4105-40c7-954b-63336a4325d5@linaro.org>
 <87plgkihg4.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87plgkihg4.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, May 07, 2025 at 05:11:39PM +0200, Markus Armbruster wrote:
> Date: Wed, 07 May 2025 17:11:39 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: KVM/QEMU Community call 29/04/2025 agenda items?
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > On 30/4/25 12:41, Markus Armbruster wrote:
> 
> [...]
> 
> >> Pierrick's stated goal is to have no noticable differences between the
> >> single binary and the qemu-system-<target> it covers.
> >> 
> >> We have two external interfaces to worry about: QMP and the command
> >> line.  Let's ignore the latter for now.
> >> 
> >> Target-specific differences in *syntax* come from QAPI schema
> >> conditionals with target-specific conditions.  Example:
> >> 
> >>      { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'],
> >>        'if': { 'any': [ 'TARGET_PPC',
> >>                         'TARGET_ARM',
> >>                         'TARGET_I386',
> >>                         'TARGET_S390X',
> >>                         'TARGET_MIPS',
> >>                         'TARGET_LOONGARCH64',
> >>                         'TARGET_RISCV' ] } }
> >> 
> >> This command is only defined for some targets.
> >> 
> >> The value of query-qmp-schema reflects this: it has
> >> query-cpu-definitions exactly when the condition is satisfied.  The
> >> condition is evaluated at compile-time, because that's how QAPI schema
> >> 'if' works.
> >> 
> >> Say we drop the condition and instead add an equivalent run-time
> >> condition to command registration.  This preserves behavior of command
> >> execution.  But query-qmp-schema now has query-cpu-definitions *always*.
> >> This is a noticable difference.  It may break management applications
> >> that use query-qmp-schema to probe for the command.
> >> 
> >> Moreover, conditionals aren't limited to commands.  Example:
> >> 
> >>      { 'struct': 'CpuModelExpansionInfo',
> >>        'data': { 'model': 'CpuModelInfo',
> >>                  'deprecated-props' : { 'type': ['str'],
> >> --->                                   'if': 'TARGET_S390X' } },
> >>        'if': { 'any': [ 'TARGET_S390X',
> >>                         'TARGET_I386',
> >>                         'TARGET_ARM',
> >>                         'TARGET_LOONGARCH64',
> >>                         'TARGET_RISCV' ] } }
> >> 
> >> Here we have a conditional member.
> 
> [...]
> 
> > IMHO conditionals should only depend on host / static configuration
> > features, not features modifiable from the command line.
> 
> This is how the QAPI schema works now.
> 
> >                                                          (I'm always
> > confused by KVM features published in the schema, but then you start
> > your binary with -accel=tcg and still can run KVM specific commands
> > via QMP, returning errors).
> 
> Not exactly a ringing endorsement for keeping the QAPI schema work the
> way it does now, isn't it?  ;)
> 
> The problem at hand is QAPI-generated files in a single binary.
> 
> Pierrick posted "[RFC PATCH 0/3] single-binary: make QAPI generated
> files common".  The patches are flawed, but that's alright for RFC.
> 
> In review, I pointed out three possible solutions, and discussed their
> pros and cons:
> 
> (1) Drop target-specific conditionals.
> 
> (2) Replace them by run-time checks.
> 
> (3) Have target-specific QAPI-generated code for multiple targets
>     coexist in the single binary.

Thank you Markus for your nice summary! I also apologize to you and
Philippe if I didn't understand correctly (I tried to look at
Pierrick's and Philippe's work, but still worry about I may have wrong
understanding :-) )

> Both (1) and (3) keep the QAPI schema work as it does now.
> 
> Pierrick's patches are an incomplete attempt at (2).

I see.

> Daniel made a case for (1).  You and I actually discussed (1) before,
> and I encouraged you to explore it.

And I notice Philippe has 2 patches:

(1) For QAPI, this is to drop target-specific cond:

https://lore.kernel.org/qemu-devel/20250429100419.20427-1-philmd@linaro.org/

I feel it's a smart way to make it optional.

(2) Not for QAPI, but this is try to add runtime check:

https://lore.kernel.org/qemu-devel/20250502214551.80401-5-philmd@linaro.org/

I am thinking about how kvm-pmu-filter could be aligned with these
current efforts in mail list.

I can drop all the target conditions for KvmPmuEventFormat:

    { 'enum': 'KvmPmuEventFormat',
      'data': ['raw', 'x86-select-umask', 'x86-masked-entry'] }

This is what you listed before and it is similar to the way in (1). But
only (1) is not enough because I can't make these formats as optional
(pls educate me if I'm wrong :-) ).

Therefore, I think I need run-time check like Philippe did in (2), in
my kvm-pmu.c file. Do you think so?

An additional question - about CONFIG_KVM - is that I see that it's all
currently focused on solving target-specific problems, and I understand
that it's not yet kvm-specific's turn.

But kvm-pmu-filter does (or, may :-) ) need CONFIG_KVM. My initial
thought is, is it possible to remove the CONFIG_KVM condition for
kvm-pmu-filter in QAPI and use the same runtime check? But this would
require accel-info as Philippe's work on target-info in [2]).

> We can certainly discuss this some more, but I'd prefer to review a
> working solution instead.

With so many options on the table, I'm a bit confused about the fate of
kvm-pmu-filter. Should this case wait for the most appropriate option to
come along, or could it move forward based on the status quo, and then
consider the refactoring later with the final optimal option?

Regards,
Zhao


