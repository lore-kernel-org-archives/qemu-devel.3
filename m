Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9518FD65C53
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 17:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVvFS-0006n4-IY; Wed, 17 Dec 2025 12:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vVvF8-0006m6-Ra
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:23:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vVvF6-0007pJ-MD
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 12:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765992195;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KErRrw8HoSMIEg7dGk5gpxPR/xd1fk0v71TFQqAWP+U=;
 b=iP6ADy4zpM+Ozo12TfX8v6/e8fuP2kZYmgmKuizkSx95ZhhD6U1Q/skzjnXhc8kuCzpxk5
 AJ3Uc+6bsUM/K/5eVWefR6qZGoxhYoXaO/7AxGSxD5szc7WqCcBnH3lfuQvqQbIFLqn+X1
 pvhuzmAjj+ANj1M2rPspt9qvY3IRxzI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-h2EFjx79Pu2r9Bi9eiLnWQ-1; Wed,
 17 Dec 2025 12:23:13 -0500
X-MC-Unique: h2EFjx79Pu2r9Bi9eiLnWQ-1
X-Mimecast-MFC-AGG-ID: h2EFjx79Pu2r9Bi9eiLnWQ_1765992191
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6403C195FCDD; Wed, 17 Dec 2025 17:23:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.217])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9699180045B; Wed, 17 Dec 2025 17:23:07 +0000 (UTC)
Date: Wed, 17 Dec 2025 17:23:04 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 devel@lists.libvirt.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] hw/arm: Deprecate legacy VirtIO devices on big-endian
 guests
Message-ID: <aULm-Eia0EW3xzEk@redhat.com>
References: <20251217140658.89715-1-philmd@linaro.org>
 <aUK9f3qG78Plwmgh@redhat.com> <8734592frz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734592frz.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Dec 17, 2025 at 05:13:04PM +0000, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Dec 17, 2025 at 03:06:57PM +0100, Philippe Mathieu-Daudé wrote:
> >> We couldn't find a way (guest OS with VirtIO drivers) to test
> >> a legacy VirtIO device on a ARM vCPU running in big-endian.
> >> 
> >> Deprecate for the v11.0 release, giving 1 year to users who
> >> really care to contribute functional tests.
> >> 
> >> Suggested-by: Alex Bennée <alex.bennee@linaro.org>
> >> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >> ---
> >>  docs/about/deprecated.rst | 11 +++++++++++
> >>  1 file changed, 11 insertions(+)
> >> 
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index ac31a2bce42..3a69facb0f1 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -515,6 +515,17 @@ It was implemented as a no-op instruction in TCG up to QEMU 9.0, but
> >>  only with ``-cpu max`` (which does not guarantee migration compatibility
> >>  across versions).
> >>  
> >> +VirtIO devices
> >> +''''''''''''''
> >> +
> >> +Legacy VirtIO devices on Big-Endian ARM architecture (since 11.0)
> >> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >> +
> >> +There are no functional tests for legacy virtio devices used by ARM
> >> +machines running in big-endian order, which makes harder to maintain
> >> +the code path while the code base evolve.
> >
> > Lack of test coverage is not a reason to deprecate something.
> >
> > We deprecate things we intend to intentionally remove or intentionally
> > change in an incompatible manner.
> 
> We also deprecate things that stop us moving the code forward. c.f. the
> long process to deprecate 32 bit hosts.

IIUC we're intending to actively block the ability to build on 32 bit
hosts. IOW, that's still an example of a deprecation where we will
intentionally remove some functionality, rather than just an untested
usage scenario.

> > If something is not tested, that merely means it has lesser quality
> > guarantees, and is liable to unintenionally get broken at times.
> >
> > If we're planning to *intentionally*  remove the ability to use
> > legacy virtio on big endian, that would be a reason to deprecate.
> > If so the deprecation message should say this, not talk about
> > missing functional testing.
> 
> As far as I'm aware BE Arm is a very small niche and I'm not even sure
> anyone runs BE Arm systems with VirtIO - let alone legacy VirtIO. If
> there are people that need this functionality they need to at least make
> themselves known.

Is there some technical change we're intending to make that will intentionally
impact virtio legacy on BE ? ie, if we add the deprecation, then 2 releases
later, what is the code change that means we move it from deprecated.rst into
removed-features.rst ? 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


