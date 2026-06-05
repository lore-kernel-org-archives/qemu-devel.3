Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F839CD6E5D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVRnB-0007q1-Bx; Fri, 05 Jun 2026 06:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVRn9-0007pY-41
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wVRn6-0005m8-Up
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 06:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780655319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ap9Pc1Vr6LFufahlklu1oC/FfELF/Cok7kFrDrdr3/c=;
 b=dmBSyzyhAJqcCspZeJbPQwHRWR+hc9m9nUoVEYaf/aQScVelQgQLSVGPwNTA62od2h7CUy
 8inwGPv1/yfrqiOrOMXy0IXzjCv1NKSUJhPwrj0tEi6usvZs4mbNiE/V2en562250P5j4i
 BQ3dfs+9xVP4AlC1JRP5yoEYqbrSJOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-BwUYdleuNJuyNn6-AAm9TQ-1; Fri, 05 Jun 2026 06:28:38 -0400
X-MC-Unique: BwUYdleuNJuyNn6-AAm9TQ-1
X-Mimecast-MFC-AGG-ID: BwUYdleuNJuyNn6-AAm9TQ_1780655317
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45efa12a788so1204800f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 03:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780655317; x=1781260117; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ap9Pc1Vr6LFufahlklu1oC/FfELF/Cok7kFrDrdr3/c=;
 b=RlzsouNpGFxAKtTv0XgpPcj8Unr5Q76nfYKNg7TyjBMXnXgF2x1wWehSMrK3KjMkGp
 oud+YkGX5Tvmpw/TK7dz/UL+yPH8MumkBFPUfJtdHajIRmyAB5u1m9Occ8Zz1DHw9Gj9
 fmCB2NGTRyzRLwbqou03muvoV+9XyPO3D2vcUYEs3qOyWT2i982cTvp5HxoqUkrWcyKE
 JyG72BRRV0lz8gf8kBXfyMM0+REOMTT16pzB5YZayFoVZei2Okp0HG4x04IPsdDyTfQX
 G1kw73MsA/U5982Ltdqab0NhHgcPCpg395Cn9WoXBAcINIDhtYQzX3MiTwy5b2I9QQuq
 Z38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780655317; x=1781260117;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ap9Pc1Vr6LFufahlklu1oC/FfELF/Cok7kFrDrdr3/c=;
 b=dTOsIjRpASPG95r5BYymopsHv17w6Q/3kT6AW7pM2YDH6/+OagtVfe8mvcsay2GiUr
 Pr3nma67+OpA0rfUlOeODCGnWvF5r+ZBXCHopP/MqCc6v0IE0oGpjphcoDx23qXMRIP4
 7tmPXLlFGhzlBZM0euqO9L+ODafBgkHNzD79OrvEi1K5l5fD1rIpa4C6xHqLv1IkCKo+
 qwV9PyP3O4xZHx0tpPutwyADzhxO+0igyDtUo/Ctbt46VUo/mTjKjz7SNezjXVbp88JS
 g1b7LHXtBgFXxfYuzFtpCDmWeihsnlsQNY8zEdJdsETGer6kbjs77xq53pdyavlmv/7W
 r30A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nv4blQkngrpWTzde5NwbI52ZRevCQawMOeEFdO9q6zbfZqjKrcGYgi0jWs/2Qef2VWu4CaIW5pMJT@nongnu.org
X-Gm-Message-State: AOJu0YzWzNt9dE6q899zdN3aVWWuPDRkDT/blnvCt5xM2WBeKtSESDIR
 YRc7BJKwEfL4vGTNrqG6vxJCI61Ra38R3bqPosquJz/t7KU9U4HPkJpvuMLxmGqvT/BKR8qcVri
 Uq1wg6acklB/CZftljx8NyMIfKBz+hyCfwqonxJVW1e9PKX9FJ/qozL9Y
X-Gm-Gg: Acq92OGLzEpTjEYuGF+Tcl+JMztpMrgMQs+51OQyAHyHPEgaWi+PB9zrJNJzyK1DpKD
 t895wHBZzlQPE5D5jrtvO0Jhzl0aMvJb2dkuFKwfGh3aKzi3e7RmTISMMognQb1uiksGt65f7jK
 CBEjxoH4gKHDy29nypuC6IWmbm6pBb6tlAivmacVvAbIcH9WCK6E62APlWNT+0rZTdjTS4YXgZ9
 4nJNbBQiXk5XSXNOXKpo6nw/qmcYg+kiknaAqgpVRLudoZ1UB+f3K1nJBiMzPo3VdJ6vGz0y+1S
 eE/MJBGPDJAMaiR/Z+0w46WA2y+/Qd1fVVzeJWxbq0QuxIHS3zKGz2km8H9W1BBfNWveWUe2VM/
 lR815ztAQ3IIn42bc6XToSjM2nFgB2ZSphWKx1bjTMVtIthfyfDRoGaU=
X-Received: by 2002:adf:ef88:0:b0:460:1e9d:31a5 with SMTP id
 ffacd0b85a97d-46030631ba3mr3605683f8f.35.1780655316977; 
 Fri, 05 Jun 2026 03:28:36 -0700 (PDT)
X-Received: by 2002:adf:ef88:0:b0:460:1e9d:31a5 with SMTP id
 ffacd0b85a97d-46030631ba3mr3605622f8f.35.1780655316259; 
 Fri, 05 Jun 2026 03:28:36 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda3651sm11764303f8f.32.2026.06.05.03.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:28:35 -0700 (PDT)
Date: Fri, 5 Jun 2026 06:28:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260605062540-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <aiBBV48wyDF57vUi@redhat.com>
 <CABgObfZNX2rLnB=FosVopFmLB_S_5V48UPLjNTTtn543d9RfHg@mail.gmail.com>
 <aiBqT1KfI-qowr4L@redhat.com>
 <CAHFMJ7veDE+i89Kh-SaQOL3019W2YC9_o7DeQtDL-YKGxGGHVQ@mail.gmail.com>
 <aiKUHBiQNqvhqxr8@redhat.com>
 <20260605051949-mutt-send-email-mst@kernel.org>
 <aiKZQ2VVnERuUKt0@redhat.com>
 <20260605054212-mutt-send-email-mst@kernel.org>
 <aiKjupJNo5wLB4Du@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aiKjupJNo5wLB4Du@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Fri, Jun 05, 2026 at 11:23:54AM +0100, Daniel P. Berrangé wrote:
> On Fri, Jun 05, 2026 at 05:48:37AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Jun 05, 2026 at 10:39:15AM +0100, Daniel P. Berrangé wrote:
> > > On Fri, Jun 05, 2026 at 05:25:36AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Jun 05, 2026 at 10:17:16AM +0100, Daniel P. Berrangé wrote:
> > > > > On Thu, Jun 04, 2026 at 12:37:58PM +0200, Paolo Bonzini wrote:
> > > > > > Il mer 3 giu 2026, 19:54 Daniel P. Berrangé <berrange@redhat.com> ha
> > > > > > scritto:
> > > > > > 
> > > > > > > The AI policy should just
> > > > > > > make a point that we expect to be communicating with people not
> > > > > > > bots pretending to be people.
> > > > > > >
> > > > > > 
> > > > > > Yes, it's better to have that stated clearly.
> > > > > > 
> > > > > > > True but we also need a rule. The spirit is better explained elsewhere
> > > > > > > > (and also, building consensus on spirit vs. a rule are two different
> > > > > > > > things).
> > > > > > >
> > > > > > > Do we have a better elsewhere in this case ?  It is a point specifically
> > > > > > > about intent of the AI policy rule.
> > > > > > 
> > > > > > 
> > > > > > The rule in this draft says 20 lines, tests, mechanical changes and docs.
> > > > > > The spirit is what is in the commit message, basically to maximize the
> > > > > > benefit and limit the possible damage?
> > > > > 
> > > > > Putting "the spirit" in the commit message is essentially /dev/null to
> > > > > anyone reading the policy later.
> > > > > 
> > > > > > > See my reply to Peter elsewhere in the thread. I agree with your
> > > > > > > > concerns for both docs and discretion, but I had specific uses in mind
> > > > > > > > that I'd like to allow.
> > > > > > > >
> > > > > > > > For docs:
> > > > > > > > - create tutorials and/or feature documentation based on functional tests
> > > > > > >
> > > > > > > That doesn't sound too appealing to me. Reverse engineering docs or
> > > > > > > tutorials from our functional tests is exactly the kind of thing that feels
> > > > > > > likely to result in volumous text of marginal value which will have a large
> > > > > > > burden on reviewers.
> > > > > > >
> > > > > > 
> > > > > > At the same time this can be helpful for maintainers themselves? Let's also
> > > > > > look at this from the point of view of producing better output, not just
> > > > > > from that of being on the receiving end of slop. Especially for docs I have
> > > > > > a hard time imagining people sending out whole new "manuals"... The
> > > > > > bugfixes rule ironically seems the most dangerous to me from the
> > > > > > Dunning-Krueger point of view.
> > > > > > 
> > > > > > My question is: do we want disclosure for anything is created with the help
> > > > > > of LLMs, even if only small parts survive untouched? I think so, because a
> > > > > > lot more, even if edited, would still be originally from AI. But then it's
> > > > > > important to have rules allowing it and a way to track it.
> > > > > 
> > > > > IMHO need unconditional disclosure, because the use of the LLM impacts
> > > > > the license of the code. QEMU is traditionally expected to be GPLv2+
> > > > > licensed for all new code, but there's the train of thought that LLM
> > > > > code is public domain.
> > > > > If it gets human editting afterwards we can
> > > > > consider that the human edits are GPLv2+ licensed, but IMHO we still
> > > > > want to know the origins.
> > > > 
> > > > Wait that's a big ask.
> > > > 
> > > > DOC explicitly does not ask if code might be available anywhere else
> > > > under any other license. Just that contributor can contribute under GPL.
> > > > If it's public domain then the human can license is under GPL.
> > > 
> > > For new files, in checkpatch we validate that SPDX-License-Identifier
> > > is explicitly set as GPL-2.0-or-later. Contributors are expected to
> > > justify any divergence in the commit message.
> > > 
> > > I've seen guidance that SPDX-License-Identifier for AI output code
> > > should NOT state a license, under the theory it is public domain.
> > 
> > Not state a license? Recommended by a lawyer? Seen where? Why?
> 
> https://www.redhat.com/en/blog/ai-assisted-development-and-open-source-navigating-legal-issues
> 
>   "The harder case is when an entire source file, or even
>    an entire repository, is generated by AI. Here, adding
>    a copyright and license notice may be inappropriate
>    unless and until human contributions transform the file
>    into a copyrightable work. "
> 
> I interpret that to suggest we should not automatically use
> SPDX-License-Identifier: GPL-2.0-or-later on LLM generated
> code, unless subsequent human editting was non-trivial.
> > > Ultimately QEMU is a copyleft project as a whole and IMHO we should
> > > prioritize retaining that for as large a portion of the codebase is
> > > is practical.
> > 
> > But of course. We can make this explicit too: that
> > contributing it should be under GPL and/or implies licensing it under GPL.
> 
> The subtlety is that generally when changing an existing file, you assume
> the edits are under the same licence as the initial code being editted.
> 
> If the initial code is LLM generated & thus presumed public domain, it
> might be inferred that human edits are public domain too. I don't think
> we want to have that interpretation and should be explicit that human
> edits to LLM code in code are assumed to be GPL-2.0-or-later licensed
> unless explicitly stated to the contrary.

Oh intresting! Thanks! So maybe we should decline whole new files
for now unless it's a reorg of existing code so it inherits SPDX.

> 
> 
> > 
> > 
> > > > > > It would definitely be intended for merge. There's a lot of boilerplate
> > > > > > code in the Rust bindings, for example, that is voluminous but *mostly*
> > > > > > lacks creativity---the creative part basically can be described by the
> > > > > > spec/docs and should already clear the low bar required for originality,
> > > > > > even if the code is automatically generated. I included a couple examples
> > > > > > in my reply to Peter.
> > > > > 
> > > > > So we know there are examples which are probably low risk from a license
> > > > > POV, but which are massively larger than 20 lines of code. This just
> > > > > makes me more uncomfortable with the 20 line rule as the definition of
> > > > > the policy - we know that rule is wrong / undesirable from the start and
> > > > > needs this exception to make it viable.
> > > > 
> > > > So 20 lines or mechanical changes? what is considered mechanical will be
> > > > decided by maintainers, contributor should check with them up front.
> > > 
> > > If we are wanting to allow mechanical changes / boilerplate, then we
> > > should express that in the policy such that the policy can be reasonably
> > > understood without having to ask permission / questions ahead of time. 
> > 
> > Indeed but what is mechanical is a matter of taste.
> 
> I really don't think it can/should be left to a matter of personal
> taste.
> 
> Something is "mechanical" if it can be assumed that any reasonable
> contributor / maintainer would look at it and agree with that idea.

Oh I agree. So "clearly mechanical" or "obviously mechanical".
And some examples.

> If there is any significant (liklihood of) disagreement on whether
> it is mechanical or not, then IMHO we should assume it is NOT
> mechanical.

Right.

> With regards,
> Daniel
> -- 
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


