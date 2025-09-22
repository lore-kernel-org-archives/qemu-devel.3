Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BD9CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0jXV-0005My-M8; Mon, 22 Sep 2025 12:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0jXT-0005MI-PD
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0jXJ-0002MI-NB
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758559026;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cNBfBvfV5NFbw39QvLROQHKaZm+WE00vbHXbFxTgh6M=;
 b=P1Eyjur/h3Lad1jmsWqrd7rN0TbJkEsmnX3eAzKBBtIQG7Mqq6aqEjNbQ6O67j+LkV9jUS
 VnV8L1zWBpdwRphI+DtYGouQ3shLsk2Juh1kg9o57tyJh3iDDCw3zjDHaNX42YScGg+rft
 5ZdqUu7Y2o2KeKUT+pmqgZNW3Jjn+eA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-WofBF9GzPgG-o15V5p4Gpw-1; Mon,
 22 Sep 2025 12:37:02 -0400
X-MC-Unique: WofBF9GzPgG-o15V5p4Gpw-1
X-Mimecast-MFC-AGG-ID: WofBF9GzPgG-o15V5p4Gpw_1758559021
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A4C9180057C; Mon, 22 Sep 2025 16:37:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38B4C1800578; Mon, 22 Sep 2025 16:36:58 +0000 (UTC)
Date: Mon, 22 Sep 2025 17:36:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 4/4] docs/code-provenance: make the exception process
 feasible
Message-ID: <aNF7J6jpviFhwJPX@redhat.com>
References: <20250922113219.32122-1-pbonzini@redhat.com>
 <20250922113219.32122-5-pbonzini@redhat.com>
 <CAFEAcA9Vr2rxeJ0P7Yohqt2+NWQ8CmmpKsB016CoKv8RchkDDQ@mail.gmail.com>
 <aNFJVrusgEUaLuDW@redhat.com>
 <CAFEAcA_rQhXdavAUCEt8atMhpZYEu0Lz6tVdu4+mfgPOK9iUuw@mail.gmail.com>
 <aNFXJtQu9gFkIwLg@redhat.com>
 <ffaf300c-4f41-4741-899d-f0fc148ab2a2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffaf300c-4f41-4741-899d-f0fc148ab2a2@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

On Mon, Sep 22, 2025 at 05:10:24PM +0200, Paolo Bonzini wrote:
> 
> I have no QEMU example at hand, but let's look at a commit like
> https://github.com/bonzini/meson/commit/09765594d.  Something like this
> could be plausibly created with AI.  What I care about is:

I'd agree it is something AI could likely come up with, given the
right prompt, but in terms of defining policy that conceptally
feels more like new functionality, mixed in with refactoring.

> * to what degree can I automate what I could do by hand.  An AI tool moves
> the break-even point more towards automation.  I would not bring up
> Coccinelle for a 10 line change, in fact I looked by hand at every
> occurrence of ".cfg" and relied on mypy to check if I missed something.
> Maybe an experienced AI user would have reached to AI as the first step?[1]

What matters is not whether Coccinelle was practical to use
or not, and also not whether it was possible to express the
concept in its particular language.

Rather I'm thinking about it as a conceptual guide for whether
a change might be expressible as a plain transformation or not.

I don't think the meson change satisfies that, because you
wouldn't express the new class level properties, or the new
get_or_create_cfg code as an algorithmic refactoring. Those
are a case of creative coding.

> * keeping people honest.  Between the two cases of "they don't tell and I
> don't realize it is AI-generated" and "they split the commit clearly into
> AI-generated and human-generated parts", an exception makes the latter more
> likely to happen.


> [1] I tried "I want to track the PackageConfiguration object per machine in
> mesonbuild/cargo/interpreter.py.  Make PackageState.cfg a PerMachine object.
> Initialize PackageState.cfg when the PackageState is created. The old
> pkg.cfg becomes pkg.cfg[MachineChoice.HOST]" and it did pretty much the same
> changes in a bit more than 2 minutes.  Including the time to write the
> prompt it's almost certainly more than it took me to do it by hand, but this
> time I was doing something else in the meanwhile. :)

When we talk about "limited / non-creative refactoring", my interpretation
would be that it conceptually applies to changes which could be describe as
an algorithmic transformation. This prompt and the resulting code feel like
more than that. The prompt is expressing a creative change, and while the
result includes some algorithmic refactoring it, includes other stuff too.

Describing a policy that allows your meson example, in a way that will be
interpreted in a reasonably consistent way by contributors looks like a
challenge to me.

On the flip side, you might have written the new property / getter method
manually and asked the agent to finish the conversion, and that would
have been acceptable. This is a can or worms to express in a policy.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


