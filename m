Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B99CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 12:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDla-0004m7-4V; Thu, 18 Sep 2025 08:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzDlY-0004ly-F3
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzDlW-0000fZ-86
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 08:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758198572;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gImWZOr8Kh1w7ErQKtvQn0O3z5fnVCWrGqIatE/OETE=;
 b=MLqMx48HDAhvZ9e5iOm3mmNDt1CFGYLuz2j0HWuAt9I4rRogqGPo8CSL1vp4Sj8ofEe4gh
 x6SGd8JE8atln2YicDURTRjk0mBsIe7HLdcq4kIWiRBEVxRHY+yld6X2Zi8VNbHIxaVUQw
 Xt09wKgfBxlhbf3C/m+dvKcPS9VbMQY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-DHjhwDk3N6K8rGWgMqVqwg-1; Thu,
 18 Sep 2025 08:29:30 -0400
X-MC-Unique: DHjhwDk3N6K8rGWgMqVqwg-1
X-Mimecast-MFC-AGG-ID: DHjhwDk3N6K8rGWgMqVqwg_1758198570
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D79DB19560B0; Thu, 18 Sep 2025 12:29:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45AB21955F19; Thu, 18 Sep 2025 12:29:27 +0000 (UTC)
Date: Thu, 18 Sep 2025 13:29:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH <RFC> 00/15] Encode object type security status in code
Message-ID: <aMv7JMkeCo6QGVRV@redhat.com>
References: <20250909165726.3814465-1-berrange@redhat.com>
 <87jz1wat7n.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jz1wat7n.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
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

On Thu, Sep 18, 2025 at 01:35:56PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:

> > It starts with QOM, adding "bool secure" and "bool insecure"
> > properties to the TypeInfo struct, which get turned into flags
> > on the Type struct. This enables querying any ObjectClass to
> > ask whether or not it is declared secure or insecure.
> 
> We should clearly document what "declared secure" actually means.
> Here's my attempt at it: supported for use cases that require certain
> security boundaries.



> 
> > By default no statement will be made about whether a class is
> > secure or insecure, reflecting our historical defaults. Over
> > time we should annotate as many classes as possible with an
> > explicit statement.
> >
> > The "-machine" argument gains two new parameters
> >
> >   * prohibit-insecure=yes|no  - a weak security boundary, only
> >     excluding stuff that is explicitly declared insecure,
> >     permiting stuff that is secure & anything without a stetement
> 
> This isn't what users need.
> 
> >   * require-secure=yes|no - a strong security boundary, only
> >     permitting stuff that is explicitly declared secure,
> >     excluding insecure stuff & anything without a statement
> 
> This would be, if it covered everything accessible at the security
> boundaries.  It doesn't for now: only QOM.
> 
> It might still be better than nothing.
> 
> However, it may well be unusable until enough of QOM is declared secure.

Right, the problem is that for a while we'll have 3 buckets of
stuff (insecure, secure and "not sure yet"), when ideally we would
only have two buckets (insecure, secure).

I agree that for people running VMs, ideally require-secure=yes is
what they should be using.

The "not sure yet" bucket is a bit like schrodinger's cat in a box.

If we only had require-secure=yes, and that was insufficient for
the user, they'd be left with no way to exclude stuff that is
/definitely/ insecure. The prohibit-insecure=yes is at least
telling them they're not using something that is a terribly
bad idea.

In practice most of the stuff in the 'not sure yet' bucket will
be stuff that you'll only want to use in combniation with TCG,
and thus your VM will be in the 'insecure' bucket anyway.

There is a 2nd less critical use case for prohibit-insecure=yes
in relation to security report triage.

If someone submits a security report and it relies on a config
that is blocked by prohibit-insecure=yes, then we can categorically
declare it out of scope for CVE handling.

Similarly the require-secure=yes is categorically in-scope.

The 'do not bucket' is where we have to do case-by-case
analysis of the reoprt to decide whether it is in scope or
not.

> What would our advice to users be?  I'm afraid something complicated and
> impermanent like "try require-secure=yes, and if you can't make it work
> because parts of QOM you can't do without are still undeclared, fall
> back to prohibit-insecure=yes, and be aware this avoids only some, but
> not all security boundary death traps in either case."
> 
> This is an awful user interface.  But it's also a step towards the user
> interface we want: a single, unchanging switch that ensures you're
> running something that's fully supported for use cases that require
> certain security boundaries.
> 
> A next step could be getting enough of QOM declared so we can move to a
> single switch, with the (hopefully temporary) caveat about "only QOM".

Maybe the right answer is to just declare everything insecure
by default and focus on just annotating stuff for the secure
bucket as quickly as possible.

The lazy option would be to take everything that is built in
a RHEL distro build and label it as secure. We know Red Hat
is already on the hook for fixing CVEs in any such component
and sending fixes upstream. So by following the RHEL allow
list initially we should be implying any new burden for the
upstream. 

That would enable require-secure=yes for a useful amount of
code needed for secure KVM guests on x86, s390x, aarch64,
ppc64 and perhaps riscv. 


> > Some questions....
> >
> >   * Is using '-machine' the right place to express the policy ?
> 
> Not sure.  The guest boundary is just one of several security boundaries
> listed in docs/system/security.rst.  Some of them aren't really about
> the guest / the machine.
> 
> Maybe -compat?  It lets you exclude unstable or deprecated bits from the
> user interface.  Feels similar to excluding insecure bits.

Oh I forgot about -compat entirely. That does indeed feel like
a better place.

> >   * Can we change '-accel help' to report 'secure' / 'insecure'
> >     as we did for '-machine help' and '-device help'.
> 
> No idea, guess it's at worst a matter of shaving the yak?
> 
> >   * Should we have 'query-devices' for QMP to allow the 'secure'
> >     or 'insecure' status to be queried for every device.
> >
> >   * Should we have 'query-accel' for QMP to allow the 'secure'
> >     or 'insecure' status to be queried for every accelerator.
> 
> I recommend qom-list-types.  Covers all of QOM, not just devices and
> accelerators.

Yep that works, and is already reporting the 'abstract' property
so putting a'secure' property alongside fits nicely.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


