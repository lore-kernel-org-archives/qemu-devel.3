Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C46C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDODa-0007DB-GS; Fri, 09 May 2025 09:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDODX-0007Ct-2i
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uDODP-0003pW-Fo
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746798995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJTgjBH1sQgQiugoRW8zsK2poEQBZoj6J6pMz+Aofz0=;
 b=FsrB5H082DruJet35owaE41JRrYFoq64k2wE/SNwJU1I5uP2J0osymOwB+FE61o8YZameU
 hcQUtVP9Sh7DJKGuT2K5U1V7lUF3TG0mbujDo8ItlCh9E/wQhQf1EllVjp1KZn55tCbNUQ
 7zptSoMClzcyYefMkQUC7lEDZJfw7aQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-an9J818AMR-F5AHLb1DHUw-1; Fri,
 09 May 2025 09:56:31 -0400
X-MC-Unique: an9J818AMR-F5AHLb1DHUw-1
X-Mimecast-MFC-AGG-ID: an9J818AMR-F5AHLb1DHUw_1746798990
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EF721801A17; Fri,  9 May 2025 13:56:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.100])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A748218018B2; Fri,  9 May 2025 13:56:27 +0000 (UTC)
Date: Fri, 9 May 2025 14:56:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from
 the schema
Message-ID: <aB4JiDnVE8XrVfax@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
 <c7623b1c-01c1-46c0-bfa6-dc34aa4e722d@linaro.org>
 <aB3EpKu0iafLtgVT@redhat.com> <874ixt6gsd.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ixt6gsd.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
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

On Fri, May 09, 2025 at 03:43:30PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, May 08, 2025 at 02:09:37PM -0700, Pierrick Bouvier wrote:
> >> On 5/8/25 6:58 AM, Daniel P. Berrangé wrote:
> >> > Pierrick has proposed a series that introduces a concept of runtime
> >> > conditionals to the QAPI schema, in order to adapt the TARGET_*
> >> > conditionals currently used at build time:
> >> > 
> >> >    https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01699.html
> >> > 
> >> > For the sake of comparison & evaluation, this series illustrates the
> >> > alternative approach that we've discussed of entirely removing any
> >> > concept of TARGET_* conditionals.
> >> > 
> >> > With this the QAPI schema varies solely based on CONFIG_* conditionals,
> >> > and is thus invariant across different target emulators.
> >> > 
> >> > In this PoC I've taken the minimal effort approach to the problem.
> >> > 
> >> > The QAPI schema has removed the TARGET_* conditionals and in order to
> >> > make all the emulators then compile, the stubs/ directory is populated
> >> > with a bunch of files to provide dummy impls of the target specific QMP
> >> > commands.
> >> > 
> >> > This is sufficient to make the current QEMU binaries build successfully.
> >> > 
> >> > To make the "single binary" concept work, however, would require
> >> > additional followup work to eliminate the stubs.
> >> > 
> >> > Instead of having stubs we would need to de-couple the QMP command
> >> > impl from the machine internals. This would likely require greater
> >> > use of interfaces and/or virtual method dispatchers on the machine
> >> > class. This would enable the 'qmp_XXXXX' command impls to exist
> >> > once. Then they call out to virtual methods on the machine to provide
> >> > the real impl, and/or generate an error if the virtual method is not
> >> > implemented for the machine.
> >> > 
> >> 
> >> Thanks for posting it Daniel.
> >> 
> >> I think your approach is pretty neat, and yes, it's much simpler than having
> >> any compile time or runtime conditional to deal with that.
> >> 
> >> When we talked about that on previous thread, I thought the idea was to
> >> expose *all* the commands to *all* the targets, which I didn't really
> >> understand, considering we have target specific commands by design.
> >> I understand better where you wanted to go, by extracting concerned commands
> >> in dedicated files.
> >> 
> >> The only downside I can see is that some commands have to be there, but
> >> return an "error, not implemented" at runtime. Fine for me, but some people
> >> may argue against it.
> >> 
> >> A concern I might have as well is about how we'll deal if we want to hide
> >> some commands in the future, based on various criterias
> >> (is_heterogenenous()?). The mantra "define all, and let the build system
> >> hide things" mantra means you can only have a single definition existing in
> >> the binary, by design. But maybe it's not even a real concern, and I
> >> definitely prefer to see problems before fixing them, so it's definitely not
> >> blocking this approach.
> >
> > I think we have to distinguish between what made sense in the context
> > of our original design, from what makes sense for our future design(s)
> > and plans.
> 
> No argument.
> 
> The original design idea is simple: #ifdef CONFIG_FOO for QAPI schema,
> to not generate dead code, and to not have silly stubs.  Even if you
> don't care about wasting disk and address space, you probably care about
> wasting developer time on writing silly stubs and waiting for dead code
> to compile.
> 
> Initially, target-specific macros did not work in conditions.  That was
> easy enough to fix, so we did.

Ah, yes, forgot that bit of history.

> > I can understand why we took the direction we did historically, but I
> > think we have unwittingly created problems for ourselves that are
> > looking increasingly worse than the problems we considered solved.
> >
> >
> > In the other thread I pointed out my dislike for QAPI schema not being
> > fully self-describing when we have conditionals present, even today,
> > but there are other aspects that trouble me more wrt conditionals.
> 
> I'm not sure I have all this present in my mind...  Can you summarize
> what troubles you?  Or point me to the message(s)?

Oppps, sorry, should have cross-linked to:

  https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg01947.html

> > Since the schema is currently target specific, a mgmt app has to probe
> > for QEMU capabilities once for every target binary. QEMU has ~30 system
> > binaries, and if querying capabilities takes 250 milliseconds, then
> > querying all binaries is ~ 7 seconds of work. Libvirt mitigates this
> > overhead by caching the results of capabilities probes. We periodically
> > suffer delays when we must invalidate our cache though, typically on
> > software upgrades, and this is unpleasant for users who think we've
> > got stuck or just have bad slow code.
> 
> How does cache invalidation work?  Timestamp of binary?

ctime of libvirt itself and ctime of QEMU binary are the two
primary factors.

We had to throw in other factors on top for various edge cases
over time. So we also check the mtime of the directory containing
QEMU loadable modules, as features reported can vary if the user
installs new device/backend modules. Also check kernel version,
microcode version, CPUID signature, because that can affect
availability of some features.

NB, this is caching more than just the QMP schema - we issue
many 'query-xxxx' commands when probing QEMU.

https://gitlab.com/libvirt/libvirt/-/blame/master/src/qemu/qemu_capabilities.c#L5406

> > Even if we had a QAPI schema that didn't vary per target, this is
> > repeated probing is tricky to avoid when we have completely independant
> > binaries. We would need QEMU to have some internal "build id", so that
> > we could detect that all binaries came from the same build, to let us
> > avoid re-probing each binary.
> 
> Back when I created QAPI/QMP introspection, I floated the idea to put
> something into the QMP greeting to enable safe caching.  Libvirt
> developers told me they didn't need that.  I don't remember the details,
> but I guess the cache invalidation they already had was deemed good
> enough.

I don't recall that discussion, but I would think the problem is
that we probe much more than just QMP schema. Actually thinking
about it, the fact that we probe more than just QMP schema means
my idea of probing once and getting the answer for all targets
may not be practical. Some of the query-xxx  commands we run will
likely need to know the target.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


