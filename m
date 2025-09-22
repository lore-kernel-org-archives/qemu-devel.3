Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC35CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0gEv-0007G1-NI; Mon, 22 Sep 2025 09:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0gEl-0007Cx-PX
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:05:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0gEc-0002Pi-9A
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:05:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758546335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=m43nyM5m2RQig7T5fTNUPFrhUg6tI/+XJ2l9C4NLT+g=;
 b=YuYx0BwuAO4I8z8YHnyc9sT5CSBwpD61YRrtqzPC3fRrrmH1212Qt3ERpxMEr6GxDwTMd8
 0RCtRQowYDwFqz/sGYGFcMtgNuMCr0cNHZzFR4GceWyOEOjfYTjI205DnRbIQoCCq3X4KK
 AUSn5T9DUQaAIRp36eEl/+K1QRrTbtQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-PN3_FowsPNucC-uhBQnsog-1; Mon,
 22 Sep 2025 09:05:25 -0400
X-MC-Unique: PN3_FowsPNucC-uhBQnsog-1
X-Mimecast-MFC-AGG-ID: PN3_FowsPNucC-uhBQnsog_1758546324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58D6F1921EFE; Mon, 22 Sep 2025 13:05:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 203DB1800678; Mon, 22 Sep 2025 13:04:25 +0000 (UTC)
Date: Mon, 22 Sep 2025 14:04:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
Message-ID: <aNFJVrusgEUaLuDW@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
 <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 22, 2025 at 12:46:51PM +0100, Peter Maydell wrote:
> On Mon, 22 Sept 2025 at 12:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > I do not think that anyone knows how to demonstrate "clarity of the
> > copyright status in relation to training".
> 
> Yes; to me this is the whole driving force behind the policy.
> 
> > On the other hand, AI tools can be used as a natural language refactoring
> > engine for simple tasks such as modifying all callers of a given function
> > or even less simple ones such as adding Python type annotations.
> > These tasks have a very low risk of introducing training material in
> > the code base, and can provide noticeable time savings because they are
> > easily tested and reviewed; for the lack of a better term, I will call
> > these "tasks with limited or non-existing creative content".
> 
> Does anybody know how to demonstrate "limited or non-existing
> creative content", which I assume is a standin here for
> "not copyrightable" ?

That was something we aimed to intentionally avoid specifying in the
policy. It is very hard to define it in a way that will be clearly
understood by all contributors.

Furthermore by defining it explicitly QEMU also weakens its legal
position should any issues arise, because it has pre-emptively
documented its acceptance of certain scenearios. This has the effect
of directing risk away from contributors and back onto the project.

We want to be very clear that the burden / requirement for determining
legal / license compliance of contributions rests on the contributor,
not the project, whether AI is involve or not.

In terms of historical practice, when contributors have come to us
with legal questions about whether they can contribute something or
the legality of cerati nchange, as a general rule we will avoid
giving any clear legal guidance from the project's POV.

Especially with any corporate contributor the rule is to refer that
person back to their own organization's legal department. This makes
it clear where the responsibility is and avoids the QEMU project
pre-emptively setting out its legal interpretation.

TL;DR: I don't think we should attempt to define whether the boundary
is between copyrightable and non-copyrightable code changes. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


