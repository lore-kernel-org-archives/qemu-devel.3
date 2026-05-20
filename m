Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52602CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgFS-0002iv-M3; Wed, 20 May 2026 08:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wPgEz-0002c0-A5
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wPgEv-0007pf-Tx
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779280885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpllSz6Q1jEBAH+kmiienSkFxnYoNI7CuIlFZW5gcIY=;
 b=EFyA70nvm2oJY8zVTAMvfqrZSr4uFTa8ZDvdA1ix/u+RESmsfbNEo7vuZxXWJs4apX1LcJ
 vcYU9udVnjGJwHikYeY9JoozstHPHhJf2PUB0cUIUlJulkrx0wAJ5GsZ1hF/tNVIqX7nHb
 pHbmEczT7cxuiy8LIQERApK7e+/WqZU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-LDSLTbQmMjiRcsVpxiW6Wg-1; Wed, 20 May 2026 08:41:23 -0400
X-MC-Unique: LDSLTbQmMjiRcsVpxiW6Wg-1
X-Mimecast-MFC-AGG-ID: LDSLTbQmMjiRcsVpxiW6Wg_1779280882
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44bf1ac8893so3717770f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779280882; x=1779885682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpllSz6Q1jEBAH+kmiienSkFxnYoNI7CuIlFZW5gcIY=;
 b=ff2cAV4Qt41CpFvBYcTrDM2OjFLo+zRNX7fsMTBS9sHxhKg/lK5jcvC/Yk+3YHLiuW
 lAdiWDvXohIAuhqnlwOtQen1XYkTE+PvZ8uQpnH2GZe/Mme+H66Xz4KxdUweMlQ3/Z4w
 l9hug3Pb2/wcBsdezzJUMl3PaKTmsJes3G6xX4JGCiBfkkAd3ED78hvnu/66JpB42Qw5
 a+yhjSnvjqlCAqveH/uVt7CLhs/OK9aBuvTuBlaiI7p//aNhV5uofRt5Zl+dkkWSPOlz
 pN9DjPI/XdD2wGtv5CuDMxkY4xQpxg+vmfpuoNaVs23aMyygI3L8ZRmj3V4HGbyCKKJ0
 D61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779280882; x=1779885682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FpllSz6Q1jEBAH+kmiienSkFxnYoNI7CuIlFZW5gcIY=;
 b=VBq0iMlBLD2L/fxPiYjLCJ+pdHuooj5aF8/G7E2jIVKnV76VoOLedT9aBv+6P91Kyi
 sP+zna3fcRNFGmWxXeu/vjPS3kjEHREIaX4HokaGWJNB4gjEBq3Y+qjU0jiOXFIwVSdE
 oDgxTn0pZQzdNAN9J7VcQR8ovCR2E6jaY4vWw+PUe3+6xqhNFoBcKp99t21i+PYPLb/y
 /cVvq/6dZ82dw0YNLfbfJIY+NxrLyZvo+OBC7doTAZxhE2l/6kqn9qO53Pv9ekh5kxM6
 3AoQgkgY2AoYhkzGN8GXS88WYxgGCnlqJzG8//r4sQ1aCqKyp2JeMuHMVqNOG7AisKJV
 wCtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HUrJrn6t1xarH/0u/p4Rp2XJUbtfdZIxPJKAFpLiRHn6qMc5TUk4YkC2fB5PACkQjo4Q+PwcQ5IY/@nongnu.org
X-Gm-Message-State: AOJu0Ywa1YLvMq4SajuSBI6PYJfMuDVpbJEGSXQF+CuxbjVUjTjqHfmS
 NW0lhi+YI4uXvELc6R5IX+CjVimB2ipdYsl2I/yz2iYV7iT1QuK3G6o46KpfGCTaaqZhX/6nnso
 YtJCwov4WFExJ4AMM4g0uZv8oSqpAmO2/GzfMxRyvqhvOl2MkOo9qdsGi
X-Gm-Gg: Acq92OGmTX0aPbD4mRZJqq5NtmJ9uZI63e2OyX+rRp7ArzdZnahhqQgem0/SIgNeJtv
 wcEJrX2SCHBsuUvuqJzsHPCN5qwWWonTrpph1L04PpIryIgjfHQKu9NdmhImW5pWuVEr8faYaiR
 +ll4MxNr+LirD7ddRBqynW0lYzY6wZrZUHeoBKGSuK7mT9CXLRFS9J2UroHH6lffs7qBJ3Cr/Qn
 kxNIs0DeWu8Lz2BfjjZ551L9FlCQgysDSiuC4Ibkz07qul30+04lMCXmBsjY4yaoIx9HmNyoDZq
 0zXcFHFb94eWTqDPElFLl/8yDVOrIgefNpXc2tkFLLZbYgYFXFsJcYoAeCdLSLlBfddZ9kzrJDR
 lyGWhPw==
X-Received: by 2002:a5d:5d86:0:b0:45e:8547:f217 with SMTP id
 ffacd0b85a97d-45e8547f327mr16891610f8f.37.1779280881927; 
 Wed, 20 May 2026 05:41:21 -0700 (PDT)
X-Received: by 2002:a5d:5d86:0:b0:45e:8547:f217 with SMTP id
 ffacd0b85a97d-45e8547f327mr16891556f8f.37.1779280881368; 
 Wed, 20 May 2026 05:41:21 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm54460070f8f.8.2026.05.20.05.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 05:41:20 -0700 (PDT)
Date: Wed, 20 May 2026 14:41:19 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
Cc: gregory Price <gourry@gourry.net>, David Hildenbrand <david@kernel.org>,
 David Hildenbrand <david@redhat.com>, <qemu-devel@nongnu.org>,
 <jonathan.cameron@huawei.com>, <apopple@nvidia.com>,
 <dan.j.williams@intel.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v7 1/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <20260520144119.525b4ec8@imammedo>
In-Reply-To: <ab7ad06f-1f46-4e5a-9ade-a45f12170eb3@amd.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <20260306082735.1106690-2-FangSheng.Huang@amd.com>
 <20260514150559.3148f9dc@imammedo>
 <d26cfb4b-d70e-415c-8747-904d94f8ccb2@amd.com>
 <20260515150453.409e0e3e@imammedo>
 <4a3de73b-03bd-446e-8cbd-dedd5323e295@amd.com>
 <20260518163239.2fd73491@imammedo>
 <ab7ad06f-1f46-4e5a-9ade-a45f12170eb3@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 19 May 2026 12:18:19 +0800
"Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com> wrote:

[...] trimming point we agree upon, the rest is inline.

> > If we merge v7 approach, we are bound to support it for years
> > and if we later on we add device based variant, it will increase
> > support burden even more and complicate configuration, which
> > in turn will propagate up the stack.
> > 
> > Hence, I'd like possible options on the table explored 1st
> > before we commit to a particular approach.
> > 
> > I wouldn't object much is it were a fix that we had to rush in,
> > but this is not the case (are we in hurry to rush this in?).
> >  
> This is where I'd like to push back, on three connected points: the
> mixed-memory question that the v4 thread already converged on; the
> relationship between v7 and a future spm-memory device; and the
> review timeline.
> 
> (1) The mixed-memory question -- v4 thread carries directly over
> 
> In the v4 round, an -object/backend-property variant of this feature
> was set aside after pushback from Gregory and David on a single
> concern: allowing a single NUMA node to mix SPM and normal memory.
> The current memmap-type=[normal,spm,reserved] form was Gregory's
> suggestion in that same discussion, and v7 carries Acked-by from
> David and Reviewed-by from Gregory.
> 
> A -device spm-memory model reopens that question.  A memory device
> is plugged into a target NUMA node via its node= parameter; unless
> additional constraints are added, that node can also have normal
> memory attached via -numa node,memdev=.  Adding a runtime check
> that errors out on mixed-node configurations is possible, but it
> changes the failure mode from "read your command line and see which
> node is SPM" to "assemble a command line that looks fine, hit a
> realize-time error, edit, retry."  For users composing multi-node
> topologies on the CLI (or via libvirt-generated cmdlines), that's a
> meaningful UX regression.

This is a impl. detail, not a fundamental limitation of the
device-based approach.  A spm-memory device could own the entire
NUMA node's memory if desired.
Whether it must be the only memory on node is questionable,
it might be so atm, but in future it can change. I'd rather not
add limitation at interface level (CLI) to keep our options open.
It's plausible to have multiple SPMs on the same node, or a mixed
config from fundamental pov.

Also, realize-time errors are not a UX regression -- that's how
every other memory device in QEMU works today (pc-dimm, virtio-mem,
etc.). Users and management layers (libvirt) already handle those.


> The whole-node typing in v7 expresses the SPM-vs-normal property
> declaratively, on the same -numa line that already carries the
> node's other attributes -- which is the form the v4 review
> converged on, precisely to keep this kind of constraint visible at
> the configuration layer rather than at realize time.
> 
> (Gregory, David: this is exactly the regression you raised in v4
> that pushed the series away from -object form.  Would value your
> read on whether a -device spm-memory variant raises it again, and
> what an acceptable resolution would look like in that form.)

that's what we already do for devices that have numa awareness,
including some memory devices. (I'd say it's actually a preferable
approach instead extending -numa to support edge cases
(at this case a hack, since we have no idea/clue how to handle it
using CXL/vfio)).

More to the point: -numa node memory configuration exists
primarily for built-in RAM, and remains for legacy reasons.
There are no immediate plans to transition it to device-based
memory, but the long-term direction is clear.  SPM/HBM is
fundamentally a device memory -- it's a separate, distinct
memory resource, not part of the machine's built-in RAM.
Adding it to the -numa interface when a cleaner device-based
alternative exists doesn't make much sense from a technical pov. 
It would be forcing a device concept onto an interface that
wasn't designed for it, when we already have infrastructure
(memory-device) that is designed for it.

 
> (2) v7 and a future spm-memory device aren't mutually exclusive
> 
> I don't see anything in v7 that conflicts with the device-based
> direction you sketched.  v7 establishes the user-visible semantic
> (whole-node SPM, with E820 SOFT_RESERVED + SRAT memory-affinity
> emission) and the firmware-side compatibility (OVMF already
> upstream, SeaBIOS in flight).  A future spm-memory device built on
> memory-device infrastructure can target the same E820 + SRAT
> emission and either co-exist with v7 (different idioms for the same
> underlying semantic) or, if and when it proves out, subsume v7 via
> the standard QEMU deprecation flow.

This is exactly the pattern I want to avoid.

Once v7 lands, libvirt and other management layers will adopt the
-numa memmap-type= interface.  At that point, deprecating it
becomes practically impossible. We'd end up maintaining two parallel
interfaces for the same thing for a foreseeable future.

The "land now, deprecate later" argument sounds reasonable in theory,
but in practice we've seen how this plays out: 'temporary' interface
is hard to remove once genie is out of bottle.

 
> Three observations on the "merging v7 means committing to support
> burden for years" framing:
> 
> (A) On your own framing, the existing -numa node,memdev= interface
>      for attaching memory to NUMA nodes is itself on a long
>      deprecation arc toward memory-device.  v7's memmap-type= is a
>      sibling attribute on the same -numa node configuration, sharing
>      the same lifetime envelope; it doesn't create a new long-term
>      contract beyond what -numa node,memdev= already commits us to.

see above.
+
"Sharing the same lifetime envelope" is another way of saying
"adding to the technical debt.", and put burden on somebody else
to solve problem later.

> (B) v7 is the interim shape that a future spm-memory device can
>      subsume.  If the device-based variant lands later and proves
>      out, v7's memmap-type=spm can be marked deprecated under the
>      standard two-cycle policy and removed.  That's the same path
>      we'd take for any of the -numa node,memdev= family.  Treating
>      v7 as a permanent commitment overstates the contract.

See above.
I'm not overstating the contract, I'm being realistic about what
'deprecate later' means when management stacks have already adopted
the interface.

> (C) The marginal code surface of v7 is small: a single new -numa
>      node attribute that routes into the existing E820 plumbing in
>      machine-init.  The marginal maintenance cost is bounded by
>      that surface.  Compare against the cost of holding the in-tree
>      use case while a memory-device-based prototype is designed,
>      implemented, reviewed and stabilised.

The maintenance cost isn't just the code in QEMU, it's the
interface contract with the rest of the stack. And that quickly
becomes nightmare if you try to change it later on.

> 
> (3) The review timeline
> 
> I want to be transparent about this rather than leave it implied.
> This series has been in upstream review for roughly 1.5 years.  The
> v5, v6 and v7 cycles went through with Acked-by from David and
> Reviewed-by from Gregory; your previous engagement on this thread
> was on the v4 round in January.  v7 was posted with the QEMU 11.1
> window in mind, and the soft freeze is 7 July.
> 
> I'm raising this not to dismiss the technical questions you've put
> on the table -- those are worth a separate RFC and I'd be glad to
> take part -- but because gating v7 on prototyping a memory-device-
> based variant first effectively pushes this past 11.1, and the
> production deployment timeline that this series enables doesn't
> accommodate that.  If the in-tree review on v7 itself had surfaced
> this direction earlier, we'd be in a different place; at this point
> in the cycle, the cleanest path is to land v7 as it stands (with
> the tags it already carries) and pursue the device-based variant as
> its own RFC.

I understand it's annoying when something takes a long time to
converge and I appreciate the patience and effort you've put
into iterating on this series. 
But designing interfaces is hard, and on occasion it does take a long time. 
You're not the only one, others including myself have been there. And likely
will be there again when topic warrants it. I'd suggest keep exploring
the suggested direction, until it converges.

Upstream doesn't have release deadlines that override design concerns,
and production deployment timelines are downstream constraints, not upstream's.
The focus should be on getting a sustainable, maintainable design, not on
fitting a release window. The length of a review cycle doesn't entitle
a merge if the design direction isn't settled.
  
I'm not asking for a fully polished device-based implementation before
anything can land. I have suggested it at v4 review but that was dismissed.
What I'm asking is that we explore the device-based approach enough to understand
whether it works before we commit to an interface that will be hard to walk away.
An RFC with a rough prototype would go a long way.

> > My hunch is that memory device based approach will end-up with
> > more straightforward and cleaner code, not to mention proper
> > backend/frontend modeling.
> > 
> > (also related to long term: ideally existing -numa 'some memory' interface,
> > should go away and be replaced by memory devices.
> > Adding more similar '-numa' options, doesn't help that case and only
> > increases out technical debt).
> > 
> >  
> On the cleaner-code hunch -- agreed in principle for a green-field
> design.  On the -numa-should-go-away point -- agreed as a long-term
> direction; that's exactly why v7 sits within the existing -numa
> node,memdev= lifetime envelope rather than committing us to a new
> one (point 2A above).
> 
> I'd be glad to take part in the spm-memory RFC and in the wider
> migration of the -numa node,memdev= interface family to
> memory-device that you sketched.  Realistically, there are
> architecture-level questions still open on our side that pace what
> we can take on -- and landing v7 in 11.1 helps here by giving us a
> stable in-tree baseline to iterate forward from.
> 
> My ask on this thread is: that v7 lands for 11.1 on the tags it
> already carries, and that the device-based direction proceeds as
> separate, parallel work.

My position is: let's do the exploration first, then decide which interface
to commit to.  If the device-based approach turns out to have fundamental problems,
I'm open to revisiting. But let's find that out before we merge, not after.

PS:
After all, I'm not asking to rewrite half QEMU before doing your own thing,
as is customary here (someone has to work on existing tech debt).

IMHO, It really not worth fighting for memmap-type option approach. The time
is better spent on respiring it as memory device.

PS2:
Quick prototype based on dimm yields a usable experiment at half of size
of this patch (i.e. easier to read/reason about). A dedicated spm-memory based
memory-device will likely be a bit more due to boilerplate to create a new
device but SPM specific parts will be rather compact and self contained.

On firmware side, one would need to make it pass-through soft-reserved from
QEMU's E820 to OSPM but that's it, no need to deal with where memory ends
nor with reserved-end. It's all already accounted for by existing code base.

PS3:
I'd suggest to drop RESERVED as it's unused. All we need for device drivers
is SOFT memory, isn't it?

PS4:
I can put v8 on top of my review queue to follow up while problem is
still fresh in memory

> Best regards,
> FangSheng Huang (Jerry)
> 


