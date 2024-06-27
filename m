Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE58C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsI2-0007pS-Bw; Thu, 27 Jun 2024 12:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sMsGv-0006Y8-8j; Thu, 27 Jun 2024 12:47:00 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1sMsGs-0000V2-Hv; Thu, 27 Jun 2024 12:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=odkanXfrPw63vz4sKB+Q4JKAVIo0yPDND0DCfJzeHQw=; b=Poekx9w2Vy/ZjfL4
 xwNU9VMr3n00i4Hzx7sGBDkrN4kEcKK4ixcFs3Nv52TUS0Zc8SPx3FcPBs4T5d5my9iluQ8InzjAw
 f/tsMF/GWGhSKF6o1KR/J+48GuB02fXxMN6cb5BItQ1olGKw8ZinmVGLicZ1/2ISSGf/2WND63BQh
 7tkhiQ3YCH8jSK1zQ4aPMa5zO0KGrTNTkmBoDfPsxAM3h7k+8P7aJX1KH/+ue7tLGwmo0Rs+tc8mB
 j5mxGFF/c+Hv++K0HeGRo3iJSTwaHfpxA/fbaYQSwrPx+cJ3+rn9sKsUG4pjTiF+sRgRXplK9GEFm
 gYZcJ8m7JxG/fa/hXw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sMsGj-008iwA-0R;
 Thu, 27 Jun 2024 16:46:45 +0000
Date: Thu, 27 Jun 2024 16:46:45 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 qemu-s390x@nongnu.org, devel@lists.libvirt.org,
 Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH 0/4] hw/s390x: Alias @dump-skeys -> @dump-s390-skey and
 deprecate
Message-ID: <Zn2XdXo-HPihHPum@gallifrey>
References: <20240530074544.25444-1-philmd@linaro.org>
 <cb4028fc-9596-47f3-9468-f8912dd48aed@redhat.com>
 <Zl20rAjHLJlZkwxE@redhat.com> <Zl4tgFuAdjU2bst6@gallifrey>
 <87y17lcni7.fsf@pond.sub.org>
 <fcb6ff5d-fcad-4eb1-9b64-0a8477954a0d@linaro.org>
 <875xup81u9.fsf@pond.sub.org> <ZmBPhxW85fqQWGSE@gallifrey>
 <87zfrts7a3.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfrts7a3.fsf@pond.sub.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:46:03 up 50 days, 4:00, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> 
> > * Markus Armbruster (armbru@redhat.com) wrote:
> >> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> >> 
> >> > Hi Daniel, Dave, Markus & Thomas.
> >> >
> >> > On 4/6/24 06:58, Markus Armbruster wrote:
> >> >> "Dr. David Alan Gilbert" <dave@treblig.org> writes:
> >> >>> * Daniel P. Berrangé (berrange@redhat.com) wrote:
> >> >>>> On Fri, May 31, 2024 at 06:47:45AM +0200, Thomas Huth wrote:
> >> >>>>> On 30/05/2024 09.45, Philippe Mathieu-Daudé wrote:
> >> >>>>>> We are trying to unify all qemu-system-FOO to a single binary.
> >> >>>>>> In order to do that we need to remove QAPI target specific code.
> >> >>>>>>
> >> >>>>>> @dump-skeys is only available on qemu-system-s390x. This series
> >> >>>>>> rename it as @dump-s390-skey, making it available on other
> >> >>>>>> binaries. We take care of backward compatibility via deprecation.
> >> >>>>>>
> >> >>>>>> Philippe Mathieu-Daudé (4):
> >> >>>>>>     hw/s390x: Introduce the @dump-s390-skeys QMP command
> >> >>>>>>     hw/s390x: Introduce the 'dump_s390_skeys' HMP command
> >> >>>>>>     hw/s390x: Deprecate the HMP 'dump_skeys' command
> >> >>>>>>     hw/s390x: Deprecate the QMP @dump-skeys command
> >> >>>>>
> >> >>>>> Why do we have to rename the command? Just for the sake of it? I think
> >> >>>>> renaming HMP commands is maybe ok, but breaking the API in QMP is something
> >> >>>>> you should consider twice.
> >> >
> >> > I'm looking at how to include this command in the new "single binary".
> >> >
> >> > Markus explained in an earlier series, just expanding this command as
> >> > stub to targets that don't implement it is not backward compatible and
> >> > breaks QMP introspection. Currently on s390x we get a result, on other
> >> > targets the command doesn't exist. If we add a stubs, then other targets
> >> > return something (even if it is an empty list), confusing management
> >> > interface.
> >> 
> >> Loss of introspection precision is a concern, not a hard "no".
> >> 
> >> We weigh all the concerns, and pick a solution we hate the least :)
> >> 
> >> > So this approach use to deprecate process to include a new command
> >> > which behaves differently on non-s390x targets.
> >> >
> >> > If we don't care for this particular case, better. However I'd still
> >> > like to discuss this approach for other target-specific commands.
> >> >
> >> >> PRO rename: the command's tie to S390 is them immediately obvious, which
> >> >> may be useful when the command becomes available in qemu-systems capable
> >> >> of running other targets.
> >> >>
> >> >> CON rename: users need to adapt.
> >> >>
> >> >> What are the users?  Not libvirt, as far as I can tell.
> >> >
> >> > Years ago we said, "all HMP must be based on QMP".
> >> 
> >> In practice, it's closer to "HMP must be base on QMP when the
> >> functionality does or should exist in QMP."
> >> 
> >> >                                                    Now we realize HMP
> >> > became stable because QMP-exposed, although not consumed externally...
> >> 
> >> I'm afraid I didn't get this part.
> >> 
> >> > Does the concept of "internal QMP commands" makes sense for HMP debug
> >> > ones? (Looking at a way to not expose them). We could use the "x-"
> >> > prefix to not care about stable / backward compat, but what is the point
> >> > of exposing to QMP commands that will never be accessed there?
> >> >
> >> >>>> That was going to be my question too. Seems like its possible to simply
> >> >>>> stub out the existing command for other targets.
> >> >>
> >> >> That's going to happen whether we rename the commands or not.
> >> >> 
> >> >>> Are these commands really supposed to be stable, or are they just debug
> >> >>> commands?  If they are debug, then add the x- and don't worry too much.
> >> >
> >> > OK.
> >> >
> >> >> docs/devel/qapi-code-gen.rst:
> >> >>
> >> >>      Names beginning with ``x-`` used to signify "experimental".  This
> >> >>      convention has been replaced by special feature "unstable".
> >> >>
> >> >> Feature "unstable" is what makes something unstable, and is what
> >> >> machines should check.
> >> >
> >> > What I mentioned earlier could be 'Feature "internal" or "debug"'.
> >> 
> >> What's the difference to "unstable"?
> >
> > It should be clear *why* something is marked x- - something that's
> > marked 'x-' because the feature is still in development is expected to shake
> > out at some point, and the interface designed so it can.
> > (and at some point the developer should get a prod to be asked whethere the
> > x- can be removed).
> > That's different from it permenantly being x- because it's expected to
> > change as the needs of the people debugging change.
> 
> When you add special feature 'unstable', the tooling insists you cover
> it in the doc comment.  Review should then ensure the doc comment
> explains why it is unstable.  Examples:
> 
>    # @unstable: Member @x-perf is experimental.
> 
>    # @unstable: This command is meant for debugging.

OK, that makes some sense.

Dave

> > Dave
> >
> >> >> An "x-" prefix may still be useful for humans.  Machines should *not*
> >> >> key on the prefix.  It's unreliable anyway: InputBarrierProperties
> >> >> member @x-origin is stable despite it's name.  Renames to gain or lose
> >> >> the prefix may or may not be worth the bother.
> >> >
> >> > Could follow the rules and be renamed as "origin-coordinate-x".
> >> 
> >> I don't think it's worth the trouble.  The "x-" prefix is now strictly
> >> for humans, and humans can figure out what the x- in @x-origin,
> >> @y-origin means.
> >> 
> >> [...]
> >> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

