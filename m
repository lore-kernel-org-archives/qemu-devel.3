Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A333CAC5A8
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 14:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0h8m-0000UN-2s; Mon, 22 Sep 2025 10:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0h8i-0000Te-PC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:03:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0h8b-0003eP-TJ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 10:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758549806;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDxRqIuaCUlv11HAD0ofcALtwxVxpT5FIuBJNnPwPWg=;
 b=iT5T0CQTn07pgXp9q2lnz4O+A8Sk2YbtT4cdERb1WUP75t7839DIXwEDhoXq71DjSQ+OJ9
 imUm5ZgWlePHzmk4AMghWJy1gVF/4qhfoPjZ7yAdgS1LImNwlWnF2aAVKUTlveLLkk2GqL
 qwH3VQ3pJJ3C0QmxAQKWXSNBel/PYec=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-pB-Nh4s-N1qBqwoqn3d1tg-1; Mon,
 22 Sep 2025 10:03:25 -0400
X-MC-Unique: pB-Nh4s-N1qBqwoqn3d1tg-1
X-Mimecast-MFC-AGG-ID: pB-Nh4s-N1qBqwoqn3d1tg_1758549804
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C2371800589; Mon, 22 Sep 2025 14:03:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C0A830002CA; Mon, 22 Sep 2025 14:03:21 +0000 (UTC)
Date: Mon, 22 Sep 2025 15:03:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
Message-ID: <aNFXJtQu9gFkIwLg@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
 <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
 <aNFJVrusgEUaLuDW@redhat.com>
 <CAFEAcA_rQhXdavAUCEt8atMhpZYEu0Lz6tVdu4+mfgPOK9iUuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_rQhXdavAUCEt8atMhpZYEu0Lz6tVdu4+mfgPOK9iUuw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 22, 2025 at 02:26:00PM +0100, Peter Maydell wrote:
> On Mon, 22 Sept 2025 at 14:05, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Mon, Sep 22, 2025 at 12:46:51PM +0100, Peter Maydell wrote:
> > > On Mon, 22 Sept 2025 at 12:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > >
> > > > I do not think that anyone knows how to demonstrate "clarity of the
> > > > copyright status in relation to training".
> > >
> > > Yes; to me this is the whole driving force behind the policy.
> > >
> > > > On the other hand, AI tools can be used as a natural language refactoring
> > > > engine for simple tasks such as modifying all callers of a given function
> > > > or even less simple ones such as adding Python type annotations.
> > > > These tasks have a very low risk of introducing training material in
> > > > the code base, and can provide noticeable time savings because they are
> > > > easily tested and reviewed; for the lack of a better term, I will call
> > > > these "tasks with limited or non-existing creative content".
> > >
> > > Does anybody know how to demonstrate "limited or non-existing
> > > creative content", which I assume is a standin here for
> > > "not copyrightable" ?
> >
> > That was something we aimed to intentionally avoid specifying in the
> > policy. It is very hard to define it in a way that will be clearly
> > understood by all contributors.
> 
> > TL;DR: I don't think we should attempt to define whether the boundary
> > is between copyrightable and non-copyrightable code changes.
> 
> Well, this is why I think a policy that just says "no" is
> more easily understandable and followable. As soon as we
> start defining and granting exceptions then we're effectively
> in the position of making judgements and defining the boundary.

Whether we have our AI policy or not, contributors are still required
to abide by the terms of the DCO, which requires them to understand
the legal situation of any contribution.

Our policy is effectively saying that most use of AI is such that we
don't think it is possible for contributions to claim DCO compliance.

If we think there are situations where it might be credible for a
contributor to claim DCO compliance, we can try to find a way to
describe that situation, without having to explicitly state our
legal interpretation of the "copyrightable vs non-copyrightable"
boundary.


At KVM Forum what was notably raised as the topic fo code
refactoring and whether it is practical to allow some such
usage.


We have historically allowed machine refactoring done by Coccinelle
for example. Someone could asks an AI agent to write a Coccinelle
script for a given task, and then tells the AI to run that script
across the code base. I think that might be a situation where it
would be reasonable to accept the AI driven refactoring, as the
substance of the comit is clearly defined by the Coccinelle
script.

Could that be summarized by saying that we'll allow refactoring
if driven via an intermediate script ? That is still quite a
strict definition that could frustrate much usage, but it at
least feels like something that should have greatl]y reduced
risk compared to direct refactoring by an opaque agent.


As an example though, we have the scripts/clean-includes.pl script
that Markus wrote for manipulating code into our preferred style
for headers.

Whether the headers change is done manually by a human, automated
with Markus' perl script or automated by an AI agent, the end
result should be identical, as there is only one possible end
point and you can describe what that end point should look like.

That said there is  still a questionmark over complexity. Getting
to the end point may be a trival & mundane exercise in some cases,
while requiring considerable intellectual thought in other cases.
The latter is perhaps especially true if wanting simple, easily
bisected series of small steps rather than a big bang conversion.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


