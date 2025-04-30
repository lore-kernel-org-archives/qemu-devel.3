Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FEDC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5Qo-0003XO-Bz; Wed, 30 Apr 2025 07:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA5Qa-0003Um-7q
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uA5QX-00009v-OJ
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746011792;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aTdI0eXcHL+/EB0i8qpArKPzXZkLK5tj67K3mmoyHo=;
 b=PC8Les/NNA+gulEkDLHJFEgQW7U+GHfpsRA30wsg0ovcBBDQP6FY1QopgfwYiIwllVDOfq
 KhpEpnXT3DLEjd5y7ptOX0FyZ6k8MHisAsEDaziLLRRewPo+AHFdRjGugPmWXLqJvlffKP
 9ujtxbmZPcUy9j6JBXrqW2jnKba8O9M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-kCOjktBiM0WyWYNRPDrKiQ-1; Wed,
 30 Apr 2025 07:16:28 -0400
X-MC-Unique: kCOjktBiM0WyWYNRPDrKiQ-1
X-Mimecast-MFC-AGG-ID: kCOjktBiM0WyWYNRPDrKiQ_1746011783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9603319560A0; Wed, 30 Apr 2025 11:16:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B034F18001D5; Wed, 30 Apr 2025 11:16:08 +0000 (UTC)
Date: Wed, 30 Apr 2025 12:16:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Brian Cain <bcain@quicinc.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Neo Jia <cjia@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
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
Message-ID: <aBIGdQab_PufZ2X6@redhat.com>
References: <874iy85yx2.fsf@draig.linaro.org>
 <eefb308b-5cd8-4b30-bc32-e37f601cb07b@linaro.org>
 <CABgObfYmm2RgFUuViDJA_cuqeCUOh_DV5Qar8YLnrbfYVV39VQ@mail.gmail.com>
 <87a57ydj8y.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a57ydj8y.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 30, 2025 at 12:41:17PM +0200, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Il lun 28 apr 2025, 14:58 Philippe Mathieu-Daudé <philmd@linaro.org> ha
> > scritto:
> >
> >> On 28/4/25 13:05, Alex Bennée wrote:
> >> >
> >> > Hi,
> >> >
> >> > The KVM/QEMU community call is at:
> >> >
> >> > https://meet.jit.si/kvmcallmeeting
> >> > @
> >> > 29/04/2025 14:00 UTC
> >> >
> >> > Are there any agenda items for the sync-up?
> >> >
> >>
> >> For single binary / heterogeneous emulation, we'd like QAPI to
> >> be "feature-agnostic". In particular, using the example of KVM
> >> accelerator, whether a binary can run with it built-in or not
> >> should be is irrelevant for management applications: they should
> >> only check if it is used (enabled).
> >>
> >> The following series is adding KVM specific structures and commands:
> >>
> >> https://lore.kernel.org/qemu-devel/20250409082649.14733-2-zhao1.liu@intel.com/
> >> It could be interesting to discuss if this can be avoided. But this
> >> can also be discussed on the mailing list (as it is still currently).
> >>
> >
> > Would it be possible to just mark the commands as "do not autoregister" and
> > then do the registration (for example) at machine/accelerator/CPU creation?
> >
> > I think qemu-ga already has a similar run-time registration model but I
> > don't know why QEMU does not use it.
> 
> I think we covered this to a degree in
> 
>     Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
>     Message-ID: <87a584b69n.fsf@pond.sub.org>
>     https://lore.kernel.org/qemu-devel/87a584b69n.fsf@pond.sub.org/
> 
> But let me try to give you a shorter argument.

snip

> Another example: the KVM PMU filter series linked above wants to define
> 
>     { 'enum': 'KvmPmuEventFormat',
>       'data': ['raw', 'x86-select-umask', 'x86-masked-entry'] }
> 
> The enum makes sense only when we have CONFIG_KVM.  Member @raw makes
> sense regardless of target then.  The other two only for TARGET_I386.

NB, ...makes sense only when we have CONFIG_KVM **and** the QEMU
process was launched with '-accel kvm'.

It feels strange that we want our reported schema show a difference when
we launch "qemu-system-x86_64 -accel tcg" between two builds one with
and without CONFIG_KVM, when KVM is not in use ? 

Or to reverse the question, why does it matter if we report existence
of KvmPmuEventFormat unconditionally ?

> We could elect to forgo such conditionals.  The main disadvantage is
> loss of precision in query-qmp-schema.  Which may or may not matter, and
> may or may not box us into corners.

Is the precision we have justifiable ?

When it comes to runtime configuration QMP is already imprecise.

eg set-cpu-topology on x390 is KVM only but still there
   when running with TCG

eg reporting query-hotpluggable-cpus on machine types that
   lack hotplug

eg reporting set-numa-node on arches/machines that lack NUMA

eg reporting query-balloon when no balloon device is present

eg reporting various xen- commands when either the target
   or machine type lack Xen support

eg reporting many cxl-* commands when either the target
   or machine type lacks CXL support.

IOW the use of TARGET_ conditionals are only addressing a very
narrow area of (im)precision, whose rationale is largely an
artifact of our historical separate binary / multiple builds
choice. The only real justification for continuing with this
is that we've always done it.

Creating a general runtime conditional mechanism in QAPI feels
like opening a pandora's box.

We'll have a mechanism but it will be impractical to use it fully
enough to be able to claim we are actually precise. The scope of
runtime choices/conditions is too huge.

It risks creating a mechanism that requires a never ending stream
of patches to address continually reported gaps. A potentially
significant maintainer burden.

By comparison the CONFIG_ conditionals in QAPI, both the scope
and semantics clear and it is a fairly tractable problem, although
even there we miss them eg lack of CONFIG_XEN conditions on xen
commands.

> Pierrick volunteered to explore evaluating target-specific QAPI-Schem
> conditionals at run-time instead of compile-time.  This would preserve
> the value of query-qmp-schema, unlike conditional command registration.
> 
> Finally, syntax isn't everything.  We need to preserve behavior, too.
> But that's a separate topic.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


