Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4950ECA5FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKlu-0006Mx-4n; Thu, 01 Oct 2026 13:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCKlm-0006Lk-Sk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCKlk-0000Wk-2v
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790876430;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hQteB3kBMoO7KsS+Tc28DxMqgveZesjJsm/gNAhL+xM=;
 b=MJddEV/E+pm+u340ew7Pw55zQ9uY44+Z/lXCA3tnmOSrJuLHtc6E9L8sRk55A2S1vqLNYT
 NswKq1QYKpuIpZEiR+NUufl4LVdnCHlqbC3hlrjXy4v/PytgW/ExVGlJVuXgLSjrQuyT6T
 Mk3vKSStnkfeVVWclWAsUpdB05n7Xi0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-5alCn65zPlab27ND3B_pLQ-1; Thu,
 01 Oct 2026 13:40:27 -0400
X-MC-Unique: 5alCn65zPlab27ND3B_pLQ-1
X-Mimecast-MFC-AGG-ID: 5alCn65zPlab27ND3B_pLQ_1790876424
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7AB5E1955EAC; Thu,  1 Oct 2026 17:40:23 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5238030000E4; Thu,  1 Oct 2026 17:40:17 +0000 (UTC)
Date: Thu, 1 Oct 2026 18:40:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stafford Horne <shorne@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Song Gao <17746591750@163.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 01/10] machine: allow -M name to differ from QOM type
Message-ID: <ar6a_uDw9OeLng6c@redhat.com>
References: <20260926081551.29-1-luoyonggang@gmail.com>
 <20260926081551.29-2-luoyonggang@gmail.com>
 <82250296-78bc-4345-9e57-1fcac485d18a@oss.qualcomm.com>
 <CAE2XoE_+nhj58M9_yx6wf532qCSVcERpTw7F4AU7PXN7prhpzg@mail.gmail.com>
 <74853ef8-7315-466a-99ac-41c8182f9b13@oss.qualcomm.com>
 <ar4TQtKqfXX5Ul9O@redhat.com>
 <CAE2XoE8q3LYJ-JCTbRBk4iPdUQdRE8zzmOgiZ=HEXDL78iw8UQ@mail.gmail.com>
 <26b0d44d-0322-4ceb-a47b-747fc52c61b7@oss.qualcomm.com>
 <CAE2XoE8VyCpPCqRVFArBn_dDsyMw8vrSJxWMhKq17btZvO2n6A@mail.gmail.com>
 <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b02db9e2-b348-4011-a98d-122e9d9f17e5@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 36
X-Spam_score: 3.6
X-Spam_bar: +++
X-Spam_report: (3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 THIS_AD=2.699 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 01, 2026 at 09:19:48AM -0700, Pierrick Bouvier wrote:
> On 10/1/2026 9:14 AM, Yonggang Luo wrote:
> > On Thu, Oct 1, 2026 at 4:44 PM Philippe Mathieu-Daudé
> > <philmd@oss.qualcomm.com> wrote:
> >>
> >> On 1/10/26 10:13, Yonggang Luo wrote:
> >>> On Thu, Oct 1, 2026 at 4:01 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >>>>
> >>>> On Wed, Sep 30, 2026 at 09:23:50PM -0700, Pierrick Bouvier wrote:
> >>>>> On 9/30/26 6:55 PM, Yonggang Luo wrote:
> >>>>>> On Thu, Oct 1, 2026 at 2:19 AM Pierrick Bouvier
> >>>>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>>>>
> >>>>>>> On 9/26/26 1:15 AM, Yonggang Luo wrote:
> >>>>>>>> - Add machine_class_set_name() so boards can keep a stable -M name
> >>>>>>>>      when the QOM type is uniquified. machine_class_base_init still
> >>>>>>>>      defaults the name to the QOM type without -machine.
> >>>>>>>> - Document that MachineClass::name is the -M name, not the QOM type.
> >>>>>>>> - Sort -M help by MachineClass::name so order matches the printed names
> >>>>>>>>      when QOM types are prefixed (arm-virt-11.1-machine vs virt-11.1).
> >>>>>>>>
> >>>>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> >>>>>>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >>>>>>>> ---
> >>>>>>>>     hw/core/machine.c        |  6 ++++++
> >>>>>>>>     include/hw/core/boards.h | 12 +++++++++++-
> >>>>>>>>     system/vl.c              |  8 +++-----
> >>>>>>>>     3 files changed, 20 insertions(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> First, I'm not opposed to this series, and if anyone wants to pull this,
> >>>>>>> I'm ok with that decision. It's just unclear for me what will be
> >>>>>>> direction after this step.
> >>>>>>>
> >>>>>>> If I understand correctly, the goal here is to allow to register
> >>>>>>> multiple "virt" machines, while still having distinct QOM types behind
> >>>>>>> the hood, which does no affect behavior of current binaries who have
> >>>>>>> only a single "virt" type at most.
> >>>>>>>
> >>>>>>> That said, if we project in the future where we have a binary with
> >>>>>>> multiple of those "virt" machines, how will the current series help? The
> >>>>>>> situation we'll have is distinct QOM types, that all answer to the name
> >>>>>>> "virt", so we have no way to select them individually.
> >>>>>>>
> >>>>>>> Slightly worse, find_machine() will just pick the first machine name
> >>>>>>> virt, which is a non-deterministic order at the moment.
> >>>>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/system/vl.c?ref_type=heads#L846
> >>>>>>
> >>>>>> That will handle it properly. For single-target binary qemu-system-$arch.exe,
> >>>>>> this won't be an issue, as there is no conflict as they won't be compiled in.
> >>>>>> For multi-target binary qemu-system.exe, we will choose the target through
> >>>>>> -M $arch:$machine, and when no $arch is specified, the default to arch
> >>>>>> to be "none",
> >>>>>> so still won't be non-deterministic.
> >>>>>>
> >>>>>
> >>>>>> "when no $arch is specified, the default to arch to be "none",so still >
> >>>>> won't be non-deterministic.
> >>>>>
> >>>>> That's my point, the current abstraction will create something ambiguous by
> >>>>> design. When people will specify -M virt, without $arch:, a random machine
> >>>>> will be selected. At least, maybe this series should ensure there is only
> >>>>> one virt alias, or make it forbidden and uses unambiguous names only.
> >>>>
> >>>> Yes, if there are multiple choices, we should not pick an arbitrary one
> >>>> non-deterministically, we must require the user to narrow the choice
> >>>> explicitly in some manner.
> >>>>
> >>>>> "$arch:" is just a workaround to not add -target option, except that it
> >>>>> comes with additional problems, creating inconsistent command lines.
> >>>>> I already expressed my skepticism about the "machine prefix" based approach,
> >>>>> being more in favor to strongly filter types per target with an unambiguous
> >>>>> -target option. I'll accept the community's choice on this, but just wanted
> >>>>> to see this explained before someone hits the pull button on this series, so
> >>>>> they know what will come down the road.
> >>>>
> >>>> Historically, QEMU do alot of things like this where we invented magic
> >>>> syntax that needed custom parsing of the command line. Over time we
> >>>> came to the conclusion this ad-hoc parsing was a bad idea, and we
> >>>> should always explicitly model things, even if it is more verbose.
> >>>>
> >>>> Thus I would not want to see "$target:$machine" as something that is
> >>>> parsed into two pieces.
> >>>>
> >>>> IOW, "aarch64-virt" would be OK as a unique name which treated as an
> >>>> opaque string, but "aarch64:virt" as something split into "aarch64"
> >>>> (target) and "virt" (machine) would be a bad idea.
> >>>>
> >>>> An acceptable way of modelling the latter would be to use
> >>>>
> >>>>    '-machine name=virt,target=aarch64'
> >>
> >> Why mix target information parsing at machine level when the
> >> machine already know it is target specific? People wanting to
> >> use the ARM virt machine don't want to know (and don't care)
> >> about the M68k virt machine.
> >>
> >>>
> >>>>
> >>>> or
> >>>>
> >>>>    -machine virt -target aarch64
> >>>
> >>>
> >>> That's made me confused, as different people propose different ways to
> >>> handle it.
> >>> Can we just choose one first?
> >>> '-machine name=virt,target=aarch64' is introducing new options, so is
> >>> '-machine virt -target aarch64'
> >>> I can not argue which is better, my suggestion may land one first. Both
> >>> "-machine virt -target aarch64" and "-machine $arch:$name" I have
> >>> already implemented. And currently I chose
> >>> "-machine $arch:$name" according to
> >>> https://patchwork.ozlabs.org/project/qemu-devel/cover/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/#3749257
> >>
> >> You still did not explained what you are trying to achieve
> >> with all your contributions, so my view is surely biased by
> >> what we envisioned 3 years ago when we started to pave our
> >> way for heterogenous emulation.
> >>
> >> My options so far for a single binary:
> >>
> >> - infer from argv[]
> > This can be easy to implement and can be defer till the qemu-system-$arch
> > is symbolic link to qemu-system.
> > 
> >> - enforce with CLI -target
> > 
> > I want to post my personal options, I'll prefer the -target options as
> > it's far easier to implement than "-machine $arch:$machine".
> > -machine $arch:$machine is very complicated to implement correct.
> > 
> >> - not expose any machine
> > 
> > I think not exposing any machine in the command line is a good option,
> > as it's easier to
> > implement and clean for the user. But I think this series is still needed.
> > As we want the means to inspect all machines and devices for all
> > targets(that need all of them
> > to be registered into the QOM type hash table).
> 
> It's not strictly needed to expose all types. -target can be parsed
> first, and influence what is visible from help (including -M help) also.
> 
> Also, if we go down the -target option, we should decide if we expose
> all types or not, which means if we implement filtering or not. If we
> expose all the types, I'm not sure what -target is supposed to choose.
> 
> Daniel, what do you think about this one?

*If* we take the starting assumption that the new multi-target
binary does not need to be a perfect replica of the existing
binaries, then filtering devices is creating extra work for
ourselves, to solve a problem that isn't especially important.

Even with the current per-target binaries there are countless
devices linked in which are incompatible / not usable with
certain machine types. A new multi-target binary with a union
of all devices will just be a bigger example of a scenario that
already has to be dealt with for today's binaries.

So if we have that assumption that we don't need to do device
filtering, at that point, a --target option doesn't have as
big of a role to play. The machine type code knows what target(s)
it wants (1 or 2 targets depending on if there are 32 + 64 bit
varaints. The CPU model the user requests (if the CPU is not
hardcoded by the machine), determines 32 bit vs 64 bit.

A --target option (or similar -machine name,target=xxx) could
be used to dis-ambiguate between 'virt' machines if keeping
their user facing machine names as-is, or it could be used as
a way to be more explicit about the 32-bit vs 64-bit choice
and sanity checked against the CPU model choice.

So overall "device filtering" or not is the key question to
decide IMHO.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


