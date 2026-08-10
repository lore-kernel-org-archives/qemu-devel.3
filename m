Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641DBC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtT5V-0006FM-FJ; Mon, 10 Aug 2026 12:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtT5U-0006FC-AL
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtT5S-0000ER-C8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786380172;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NZsupCdYiRYcjNIoQ6sFaT7HONWxRtvhUhw/t0ofR9Y=;
 b=S1hgWdKq7GzQQ7QSRy9eMC5n3W+JReZGBkkPn94w43O3mZCGIAiSC5KI8eYLaX75dpk3vT
 GIRylna8HhcFmWGL5ShlrC+9QrsxFoXBoVMnw18+Vdr9FNJ6vbKwwtfdcClil0L5qDOh1F
 LRW1vo1x4CqzLOIKHkGdV6nZhvZkdJ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-pKR8e-yMMbWZugZq85WGwg-1; Mon,
 10 Aug 2026 12:42:49 -0400
X-MC-Unique: pKR8e-yMMbWZugZq85WGwg-1
X-Mimecast-MFC-AGG-ID: pKR8e-yMMbWZugZq85WGwg_1786380167
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B53180066A; Mon, 10 Aug 2026 16:42:46 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 933013001DAF; Mon, 10 Aug 2026 16:42:43 +0000 (UTC)
Date: Mon, 10 Aug 2026 17:42:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
Message-ID: <ann_gBWxOzGI94Xz@redhat.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <CAFEAcA_h7t7hF=i0xSh1DLq9Dmy-VL+fBa09R5RS6BOTFXLj=g@mail.gmail.com>
 <e4f25ac5-2817-456e-9ea7-f03ff8f625f3@oss.qualcomm.com>
 <CAFEAcA85VMpWbi1y_P7ScSLBRar4AnjVAzi1KLyk8GKH0jNUYQ@mail.gmail.com>
 <070898c1-3ba5-4e7f-afa6-0ba2099badfd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <070898c1-3ba5-4e7f-afa6-0ba2099badfd@oss.qualcomm.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 10, 2026 at 09:14:49AM -0700, Pierrick Bouvier wrote:
> On 8/10/2026 9:00 AM, Peter Maydell wrote:
> > On Mon, 10 Aug 2026 at 16:55, Pierrick Bouvier
> > <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>
> >> On 8/10/2026 8:46 AM, Peter Maydell wrote:
> >>> On Fri, 24 Jul 2026 at 01:09, Pierrick Bouvier
> >>> <pierrick.bouvier@oss.qualcomm.com> wrote:
> >>>>
> >>>> Now that we can link a single-binary with at least two targets (arm, aarch64),
> >>>> we want to make sure that we expose the same set of machines (later devices and
> >>>> cpus) than target binaries. For that, we implemented a static filtering based on
> >>>> target interfaces that each machine will implement to declare which targets have
> >>>> this machine.
> >>>>
> >>>> However, we discovered that this static filtering is not enough. Indeed, some
> >>>> machines and devices do not depend only on target, and their presence can depend
> >>>> on Kconfig or host/target combination. Thus, our static approach can't work, and
> >>>> we need something more flexible.
> >>>
> >>> Do you have some specific examples of where the static filtering isn't
> >>> sufficient? I can certainly believe that we have some at the moment,
> >>> but I'm curious about how much of that is "just by accident because
> >>> ifdefs were the easy thing to do" versus when the filtering makes
> >>> sense for avoiding showing the user things that won't work.
> > 
> >> As you can see in the series, machines nitro and x-remote are concerned
> >> (they depend on host/guest combination - summarized by a target config
> >> entry). There are additional devices I found also (igpd bus, plus nitro
> >> devices), but I wanted to validate approach on machines first.
> >> I didn't observe any cpu (yet) that needs this extra flexibility.
> >> This is only for arm/aarch64 combination, I expect we'll have other
> >> cases as we add new archs in single-binary.
> >>
> >> Also, there is a benefit to register *all* types and filter them
> >> afterward: we can identify conflicting QOM types with any combination,
> >> and not only depending on which targets gets enabled.
> >> Finally, this approach is much less verbose than adding an if (cond) {}
> >> on every type_register_static location.
> >>
> >> Do you have an alternative suggestion that would retain all those
> >> benefits, but would be better in your option?
> > 
> > No, I'm not particularly strongly opinionated about the approach,
> > I was just trying to understand the background motivation for it.
> >
> 
> It would be more easy if we could expose the patches we have to enable
> the single-binary itself, so people can test and see what is the value
> of current series. However, given reception of such patches in the past,
> we decided to present them as the last piece of puzzle, and not before.

This is the big challege of large work like this.

Saving everything up until a complete solution is done leads to giant
patch series that no one likes reviewing, and potentially wastes effort
if the design took a poor direction before being shared.

Drip-feeding though means the reviewers are evaluating patches without
being able to fully understand how it all goes together, or even how it
interacts with the next incremental chunk of work. Each small series in
isolation may look ok but put together may look undesirable. So it is a
bit like reviewing with a blindfold on.

Doing arm + aarch64 may be simple but also doesn't expose the full
scope of the complexity that two fully separate arches would
experiance given their commonality.

I see there are patches related to riscv64 in flight. Is there a
buildable single binary covering risc64 + aarch64, as that would
be a more compelling demonstration of edge cases and the possible
final state.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


