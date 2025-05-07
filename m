Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD3C3ABC6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 08:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCZki-0007iK-7g; Wed, 07 May 2025 04:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCZkh-0007fp-0A
 for qemu-devel@nongnu.org; Wed, 07 May 2025 04:03:39 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCZke-0002W0-G8
 for qemu-devel@nongnu.org; Wed, 07 May 2025 04:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746605016; x=1778141016;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=HpDrDECtQvcsHMVE+hPPlkdbyYlVcQroZZnd1WpB868=;
 b=IrX2rxhPiHu7u75k1iW0XHz5qt0GHRlb9BIdfzMwlO71tBnffRM7i2h1
 BK/r62dWuD6c8ijo/9/09v0E3VblqugGiFzmvZWagl+1SZyJc7eSNLyet
 4nn+GIMQYGTYtUstV94dTDkS2M2zUdyYCf4Msm1Qy3Di++9302VisFEKA
 BF9bnk0ZvKSGLJrYK0fqyc0MS8IV7kaljx8kjuHEmVRSlspON67pLfNLD
 Ina3Owl2n4iakjmAWSEilvrCoanwhyTpXSnTDTA6tfqtiTa4CdlzY+rM7
 8v2e4lte2I/4yMgAnRJx6rbon9iR8P4rTk+65siSeSfWmOdeBPuSnzt59 g==;
X-CSE-ConnectionGUID: JFoNyJ9tQ72qFxKOjKWUCA==
X-CSE-MsgGUID: CLtuzly4QxSr5B6eEw+8iA==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48467052"
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="48467052"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 01:03:32 -0700
X-CSE-ConnectionGUID: 03T1Qm4MQtSK7kjTRNd+ag==
X-CSE-MsgGUID: gVnonXNwSV2yo8rzbg+URQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,268,1739865600"; d="scan'208";a="135843911"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 07 May 2025 01:03:22 -0700
Date: Wed, 7 May 2025 16:24:23 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Brian Cain <bcain@quicinc.com>,
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
Message-ID: <aBsYt/nm/6+8tHtx@intel.com>
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
 <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
 <87a57ydj8y.fsf@pond.sub.org> <aBIGdQab_PufZ2X6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBIGdQab_PufZ2X6@redhat.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Ping Philippe?

> > Another example: the KVM PMU filter series linked above wants to define
> > 
> >     { 'enum': 'KvmPmuEventFormat',
> >       'data': ['raw', 'x86-select-umask', 'x86-masked-entry'] }
> > 
> > The enum makes sense only when we have CONFIG_KVM.  Member @raw makes
> > sense regardless of target then.  The other two only for TARGET_I386.
> 
> NB, ...makes sense only when we have CONFIG_KVM **and** the QEMU
> process was launched with '-accel kvm'.
> 
> It feels strange that we want our reported schema show a difference when
> we launch "qemu-system-x86_64 -accel tcg" between two builds one with
> and without CONFIG_KVM, when KVM is not in use ? 
> 
> Or to reverse the question, why does it matter if we report existence
> of KvmPmuEventFormat unconditionally ?
> 
> > We could elect to forgo such conditionals.  The main disadvantage is
> > loss of precision in query-qmp-schema.  Which may or may not matter, and
> > may or may not box us into corners.
> 
> Is the precision we have justifiable ?
> 
> When it comes to runtime configuration QMP is already imprecise.
> 
> eg set-cpu-topology on x390 is KVM only but still there
>    when running with TCG
> 
> eg reporting query-hotpluggable-cpus on machine types that
>    lack hotplug
> 
> eg reporting set-numa-node on arches/machines that lack NUMA
> 
> eg reporting query-balloon when no balloon device is present
> 
> eg reporting various xen- commands when either the target
>    or machine type lack Xen support
> 
> eg reporting many cxl-* commands when either the target
>    or machine type lacks CXL support.

Indeed, I think Daniel's examples are great. @Philipppe, are these cases
considered in the context of single binary/heterogeneous emulation?

> IOW the use of TARGET_ conditionals are only addressing a very
> narrow area of (im)precision, whose rationale is largely an
> artifact of our historical separate binary / multiple builds
> choice. The only real justification for continuing with this
> is that we've always done it.
> 
> Creating a general runtime conditional mechanism in QAPI feels
> like opening a pandora's box.
> 
> We'll have a mechanism but it will be impractical to use it fully
> enough to be able to claim we are actually precise. The scope of
> runtime choices/conditions is too huge.
> 
> It risks creating a mechanism that requires a never ending stream
> of patches to address continually reported gaps. A potentially
> significant maintainer burden.
> 
> By comparison the CONFIG_ conditionals in QAPI, both the scope
> and semantics clear and it is a fairly tractable problem, although
> even there we miss them eg lack of CONFIG_XEN conditions on xen
> commands.
> 

