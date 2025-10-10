Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6F0CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 12:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CXG-0001UI-Vg; Fri, 10 Oct 2025 08:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7CXF-0001U7-79
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v7CX7-0006iC-G5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 08:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760100448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=ZEjvalNo2M1LrpcT35JfZAI12Md4s8l53dRmza1sqWc=;
 b=drrpxgjD55p+cO96gyQnWTIkVI7GXwfKu2xwuOSEI/9vttefod+9InJgNtgeBIprxcvCqn
 Qar6dEudJPthMGr/s2gt3Bo7ISqC9GEIs7bqm6W7L5BlcKDJloe6Psm8D712MQpwQ6YNsJ
 I4pmPPaPKNz17Dhl6v98mtAseIGoxjI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-o3t7oSl8MR-I2mKvnb9Khg-1; Fri,
 10 Oct 2025 08:47:26 -0400
X-MC-Unique: o3t7oSl8MR-I2mKvnb9Khg-1
X-Mimecast-MFC-AGG-ID: o3t7oSl8MR-I2mKvnb9Khg_1760100445
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61A35180057D; Fri, 10 Oct 2025 12:47:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EBF218004D8; Fri, 10 Oct 2025 12:47:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B160D21E6A27; Fri, 10 Oct 2025 14:47:21 +0200 (CEST)
Resent-To: alex.bennee@linaro.org, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, mads@ynddal.dk
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Fri, 10 Oct 2025 14:47:21 +0200
Resent-Message-ID: <87zf9yhqjq.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  John Snow
 <jsnow@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH 0/6] tracetool: add mypy --strict checking [AI
 discussion ahead!]
In-Reply-To: <aOY-PFGNPY7aOwkJ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 8 Oct 2025 11:34:36 +0100")
References: <20251008063546.376603-1-pbonzini@redhat.com>
 <87ikgpn9oz.fsf@pond.sub.org> <aOY-PFGNPY7aOwkJ@redhat.com>
Date: Fri, 10 Oct 2025 14:38:09 +0200
Message-ID: <87cy6vhqz2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 08, 2025 at 09:18:04AM +0200, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>=20
>> > [People in Cc are a mix of Python people, tracing people, and people
>> >  who followed the recent AI discussions. - Paolo]
>> >
>> > This series adds type annotations to tracetool. While useful on its ow=
n,=20
>> > it also served as an experiment in whether AI tools could be useful and
>> > appropriate for mechanical code transformations that may not involve
>> > copyrightable expression.
>> >
>> > In this version, the types were added mostly with the RightTyper tool
>> > (https://github.com/RightTyper/RightTyper), which uses profiling to de=
tect
>> > the types of arguments and return types at run time.  However, because
>> > adding type annotations is such a narrow and verifiable task, I also d=
eveloped
>> > a parallel version using an LLM, to provide some data on topics such a=
s:
>> >
>> > - how much choice/creativity is there in writing type annotations?
>> >   Is it closer to writing functional code or to refactoring?
>>=20
>> Based on my work with John Snow on typing of the QAPI generator: there
>> is some choice.
>>=20
>> Consider typing a function's argument.  Should we pick it based on what
>> the function requires from its argument?  Or should the type reflect how
>> the function is used?
>>=20
>> Say the function iterates over the argument.  So we make the argument
>> Iterable[...], right?  But what if all callers pass a list?  Making it
>> List[...] could be clearer then.  It's a choice.
>>=20
>> I think the choice depends on context and taste.  At some library's
>> external interface, picking a more general type can make the function
>> more generally useful.  But for some internal helper, I'd pick the
>> actual type.
>>=20
>> My point isn't that an LLM could not possibly do the right thing based
>> on context, and maybe even "taste" distilled from its training data.  My
>> point is that this isn't entirely mechanical with basically one correct
>> output.
>>
>> Once we have such judgement calls, there's the question how an LLM's
>> choice depends on its training data (first order approximation today:
>> nobody knows), and whether and when that makes the LLM's output a
>> derived work of its training data (to be settled in court).
>
> There's perhaps a missing step here. The work first has to be considered
> eligible for copyright protection, before we get onto questions wrt
> derivative works, but that opens a can of worms....
>
>
> The big challenge is that traditionally projects did not really have
> to think much about where the "threshold of originality"[1] came into
> play for a work to be considered eligible for copyright.
>
> It was fine to take the conservative view that any patch benefits
> from copyright protection for the individual (or more often their
> employer). There was rarely any compelling need for the project to
> understand if something failed to meet the threshold. We see this
> in cases where a project re-licenses code - it is simpler/cheaper
> just to contact all contributors for permission, than to evaluate
> which subset held copyright.
>
> This is a very good thing. Understanding where that threshold applies
> is an challenging intellectual task that consumes time better spent
> on other tasks. Especially notable though is that threshold varies
> across countries in the world, and some places have at times even
> considered merely expending labour to make a work eligible.

Moreover, having software developers apply copyright law is about as
smart as having copyright lawyers write mission-critical code.  Both
tasks require education and experience.

> In trying to create an policy that permits AI contributions in some
> narrow scenarios, we're trying to thread the needle and as a global
> project that implies satisfying a wide variety of interpretations
> for the copyright threshold. There's no clear cut answer to that,
> the only option is to mitigate risk to a tolerable level.

Yes!

The boundary between legal and illegal is a superposition of fuzzy,
squiggly lines, one per jurisdiction.

We can only try to approximate it from the legal side.

The tighter we try to approximate, the more risk we take on.

In addition, tighter approximations can be difficult to understand and
apply.

> That's something all projects already do. For example when choosing
> between a CLA, vs a DCO signup, vs implicitly expecting contributors
> to be good, we're making a risk/cost tradeoff.

A tradeoff made with competent legal advice.  In addition, it's easy to
understand and apply.

[Strong argument why type annotations are low risk snipped...]

> The problem I have remaining is around the practicality of expressing
> this in a policy and having contributors & maintainers apply it well
> in practice.
>
> There's a definite "slippery slope" situation. The incentive for
> contributors will be to search out reasons to justify why a work
> matches the AI exception,

=E2=80=9ELibenter homines id quod volunt credunt.=E2=80=9C

>                           while overworked maintainers probably
> aren't going to spend much (any) mental energy on objectively
> analysing the situation, unless the proposal looks terribly out
> of line with expectations.

Yup.  Code review takes so much brain capacity that it can impair my
spelling.  Legal reasoning is right out.

> I'm not saying we shouldn't have an exception. I think the mypy case
> is an fairly compelling example of a low risk activity. We will need
> to become comfortable with the implications around the incentives
> for contributors & maintainers when applying it though.

Makes sense.

> With regards,
> Daniel
>
> [1] https://en.wikipedia.org/wiki/Threshold_of_originality


