Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED295C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 12:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vitgg-0002Ov-4L; Thu, 22 Jan 2026 07:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vitgd-0002Mn-Nw
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 07:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vitgb-0007sb-9H
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 07:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769084475;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BpiBtLOdWVTpWByhDHQeX1GcKZ4QfO/E5LS4cIHPAdU=;
 b=XX0k1/T8eD/vY2OTIkLLJxsqNvsLdH+KCVtuWkBSPEmwCJxmH/sXh1l4iz2V+N0tLzAt84
 EpdotHNBWk2BB0rMkvbXxws3FBhy4zjwLmA/GTfYbWdAFDmIdDn4a6Cbff6G3YJdL9jQ43
 vdafDW4RSK9LY/ojfzy9JzOgWPUEMfY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-pzs1tc67P7etDYwxpUwpiA-1; Thu,
 22 Jan 2026 07:21:12 -0500
X-MC-Unique: pzs1tc67P7etDYwxpUwpiA-1
X-Mimecast-MFC-AGG-ID: pzs1tc67P7etDYwxpUwpiA_1769084470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 796931955D97; Thu, 22 Jan 2026 12:21:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.63])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F43A30002D1; Thu, 22 Jan 2026 12:21:05 +0000 (UTC)
Date: Thu, 22 Jan 2026 12:21:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: Modern HMP
Message-ID: <aXIWLi656H8VbrPE@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <871pjigf6z.fsf_-_@pond.sub.org> <aXH1ECZ1Nchui9ED@redhat.com>
 <87ikctg8a8.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikctg8a8.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Jan 22, 2026 at 01:07:43PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Jan 22, 2026 at 10:38:28AM +0100, Markus Armbruster wrote:
> >> Let's start the discussion with your nicely written Wiki page:
> >> 
> >>     === External HMP Implementation via QMP ===
> >> 
> >>     '''Summary:''' Implement a standalone HMP-compatible monitor as an
> >>     external binary (Python or Rust) that communicates with QEMU
> >>     exclusively through QMP, enabling future decoupling of the built-in
> >>     HMP from QEMU core.
> >> 
> >>     QEMU provides two monitor interfaces:
> >>     * '''QMP''' (QEMU Machine Protocol): A JSON-based machine-readable
> >>       protocol for programmatic control
> >>     * '''HMP''' (Human Monitor Protocol): A text-based interactive
> >>       interface for human operators
> >> 
> >>     Currently, HMP is tightly integrated into QEMU, with commands
> >>     defined in `hmp-commands.hx` and `hmp-commands-info.hx`. Most HMP
> >>     commands already delegate to QMP internally (e.g., `hmp_quit()`
> >>     calls `qmp_quit()`), but HMP parsing, formatting, and command
> >>     dispatch are compiled into the QEMU binary.
> >
> > First of all, I love the idea. An external HMP impl that consumes
> > QMP from outside QEMU so a concept I've suggested many times over
> > 10+ years hoping someone would take the bait and impl it :-)
> >
> >> Also line editing and completion.
> >> 
> >> Most HMP commands cleanly wrap around QMP command handlers such as
> >> qmp_quit().  Wrapping them around QMP commands instead is a
> >> straightforward problem.  I'm more concerned about HMP stuff that uses
> >> other internal interfaces.  Replacing them may require new QMP
> >> interfaces, or maybe a careful culling of inessential HMP features.
> >> Known such stuff: completion does not wrap around QMP command handlers.
> >> It is provided by the HMP core.
> >> 
> >> Risk: this can easily become the 10% that take the other 90% of the
> >> time, or even the 5% that sink the project.
> >
> > IMHO this is essentially guaranteed.
> >
> > 4 years ago I tried to move us closer to this world by introducing
> > "HumanReadableText" and documenting that all remaining & future
> > "info xxx" commands should be backed by a QMP command that just
> > returns human formatted text. The intent was to eliminate the
> > roadblock of having to define formal QAPI types for all the
> > complex data.
> >
> > I converted a bunch of commands, but that indeed became do 90%
> > of the work, leave the other 90% of the work for later victim^H^H^H
> > contributor.
> >
> > None of this means that the GSoc project idea is invalid. We just
> > have to figure out a credible end goal is for the project, ideally
> > with staged delivery.
> 
> Makes sense.
> 
> If we see the GSoC project as a first step towards replacing the
> built-in HMP by an standalone program talking QMP ("Modern HMP"), we
> better scope it carefully, so it (1) has achievable success criteria,
> and (2) makes real progress towards the actual finish line.
> 
> >> Risk: serious code duplication until we can get rid of built-in HMP.
> >> Fine if the goal is to explore and learn by building a prototype, and we
> >> simply throw away the prototype afterwards.
> >
> > IMHO that isn't a risk, that's a guarantee. I can't imagine converting
> > all remaining HMP commands to have a QMP backing, AND doing an external
> > HMP impl all within the GSoc timeline.  That's two largely independent
> > projects, each of which are probably longer than the GSoC time wnidow.
> >
> > Again that doesn't mean the idea is invalid for GSoc, just that we must
> > be honest about likely deliverables, and how follow up work will happen
> > after GSoc to maximise benefit for QEMU.
> >
> > What I would not want to see is a bunch of work done that is then
> > abandoned because it couldn't get used as it wasn't feature complete.
> > Whatever subset is achieved ought to be intended as a stepping stone
> > we can integrate and carry on working with.
> 
> Does the GSoC project make sense without a firm commitment to followup
> work to finish the job?
> 
> Specifically, commitment by whom to do what?
> 
> >>     '''Add `CONFIG_HMP` build option''':
> >>     * Create a new Meson configuration option to disable built-in HMP
> >>     * Allow QEMU to be built without HMP
> >>     * Facilitate testing of external HMP as a replacement
> >> 
> >>     '''Create an external HMP implementation''' in Python or Rust that:
> >>     * Connects to QEMU via QMP socket
> >>     * Parses HMP command syntax and translates to QMP calls
> >>     * Formats QMP responses as human-readable HMP output
> >>     * Supports command completion and help text
> >> 
> >>     '''Use `hmp-commands.hx` for code generation''':
> >>     * Parse the existing `.hx` files to extract command definitions
> >>     * Generate boilerplate code (command tables, argument parsing, help
> >>       text)
> >>     * Produce a report of implemented vs. unimplemented commands
> >>     * Enable tracking of HMP/QMP parity
> >> 
> >> .hx is C source code with ReST snippets.  scripts/hxtool strips out the
> >> ReST.  docs/sphinx/hxtool.py ignores the C source code, and processes
> >> the ReST.  It works.  Not a fan.
> >> 
> >> If we succeed in replacing built-in HMP by an external one, and the
> >> external one isn't written in C, then having C source code in .hx no
> >> longer makes sense.  Parsing it will be wasted effort.  It may still
> >> make sense initially.
> >
> > Indeed, we should clarify language intended as it would influence
> > the approach for the project.  If it is a clean room Rust impl,
> > then it would be completely independent of existing HMP C code.
> > More work initially to ensure we retain the same data formatting
> > of each command, but likely nicer long term, and saying Rust will
> > probably attract more candidates to the idea.
> 
> In theory, we could make the same HMP code work in both contexts,
> built-in HMP and standaline HMP.  I doubt this is feasible, at least not
> at reasonable cost.  Too much disentangling.  I could be wrong.
> 
> If we use separate HMP code, i.e. accept code duplication until we
> retire built-in HMP, then picking a different language for the new copy
> won't add all that much to the bother of having to maintain two copies.
> 
> HMP is not a stable interface.  We make reasonable efforts not to change
> the output without a good reason.  I don't think identical data
> formatting is a requirement.  Just make a reasonable effort.
> 
> Marc-André proposed Python or Rust.  Anyone got a preference backed by
> reasons?

My suggestion would be Rust, as it allows the possibility to embed
that Rust impl inside the current QEMU binaries, to fully replace
the C code and retain broadly the same functionality.

We might never do it, but it feels like a good idea to keep the
door option.  Python rules that out entirely meaning we keep the
current C code forever, unless we do a full break with command
line compatibility at some point.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


