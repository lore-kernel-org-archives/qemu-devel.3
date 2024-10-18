Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67718D3DEA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 17:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1qQR-0002db-0h; Fri, 18 Oct 2024 13:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1qQJ-0002c7-CX
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 13:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1qQE-0001bd-Im
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 13:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729271152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNs3jxj3h+ZtoWTf8ds5Q5Wd4AYh/FhFgJvB4iHhF4A=;
 b=IEJTBOqi6i+qEcbqkr3Bf2quq4neQaeJTvFEbSpKM5noyBtAe7qU15qnzL7gab4gsaBztt
 VFpmp2NADdhYxcybPww6s9Aoh4XuaCGLBkgqlHVGMT7NifBjEGORpNsKcz+20odWBMGF2q
 woB5wckHfVaABT6h4eGVpxFCUiRzrAU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-i93OVWj4OOCuYEcQg4a7Kg-1; Fri,
 18 Oct 2024 13:05:50 -0400
X-MC-Unique: i93OVWj4OOCuYEcQg4a7Kg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D70B519560B4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 17:05:49 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2096619560A2; Fri, 18 Oct 2024 17:05:47 +0000 (UTC)
Date: Fri, 18 Oct 2024 19:05:39 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 00/16] rust: allow older versions of rustc and bindgen
Message-ID: <ZxKVY_5pfP3cAlcP@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <ZxJjLpDe0-A_6PEL@redhat.com>
 <2f34640b-77ad-4267-975e-7898b6f8e38d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f34640b-77ad-4267-975e-7898b6f8e38d@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Am 18.10.2024 um 17:43 hat Paolo Bonzini geschrieben:
> On 10/18/24 15:31, Daniel P. Berrangé wrote:
> > On Tue, Oct 15, 2024 at 03:17:18PM +0200, Paolo Bonzini wrote:
> > > On top of this, the required version of bindgen is still too new
> > > for Debian 12 and Ubuntu 22.04.  This is fixed by the last four patches.
> > > 
> > > This is an RFC for two reasons.  First, because it would be a valid
> > > decision to delay enabling of Rust until at least some of these
> > > features are available in all supported distros.
> > 
> > Lets say we maximise our back compatibility today, and have to
> > carry some sub-optimal code patterns.
> > 
> > 1, 2, 3, 4 years down the lines, we can gradually eliminate
> > those undesired code patterns / workarounds, as older distros
> > naturally age-out of our matrix.  After 4 years our entire
> > matrix will have cycled, so we're not needing to carry this
> > debt for very long (4 years is not long in the context of a
> > project like QEMU which has been going several decades)
> 
> I agree, for what it's worth.
> 
> > Personally I tend towards quicker adoption of Rust, despite
> > the need for short term workarounds, as they'll disappear
> > again reasonably quickly.
> 
> Yes, especially since (as Kevin pointed out) most of the workarounds are
> okay in terms of maintainability.  If the worst is "if let", and it only
> occurs in a dependency, we're in a good place overall.

s/if let/let else/

"only occurs in a dependency" is probably not the right argument while
we haven't really started writing our own Rust code. If it were
available, we would probably use it in new code. But even without that,
the conclusion is the same, of course: This doesn't prevent implementing
anything and is far from being a show stopper.

I'm in favour of anything that lets up keep the phase of duplication as
short as possible if it doesn't severly limit what we can do. And I
don't see anything in this series that would do that.

> > >                                                   Another possibility
> > > could be to accept Rust 1.64.0 but require installing a newer bindgen
> > > (0.66.x for example) on those two distros with an older release.
> > 
> > How difficult is it to get newer 'bindgen' installed on these
> > platforms ? The audience here is not so much distros trying to
> > package new QEMU, as that's ony relevant for new distro, but
> > rather it is end usrs/contributors building QEMU for themslves.
> 
> Very simple - "cargo install bindgen-cli", as already seen in the
> fedora-rust-nightly container's Dockerfile (note: building QEMU does _not_
> need cargo).  In fact we could in fact do it via libvirt-ci, and it's quite
> possible that MacOS or some BSDs will need it.
> 
> Personally I'd be okay with allowing Debian 12 but not Ubuntu 22.04, for
> various reasons:
> 
> - Ubuntu 22.04 has a new rustc and an old bindgen---so it's really just
> laziness.
> 
> - any workarounds for Debian 12 would last shorter, and anyway
> 
> - Debian 12 has the really important feature (--allowlist-file), whereas the
> lack of --generate-cstr is only annoying.
> 
> > Can it be done automagically in the same way we "do the right thing"
> > with the 3rd party crates we depend on, or is bindgen special in
> > some way that makes it more inconvenient for users ?
> 
> bindgen is special in that it has a metric ton of indirect dependencies,
> which we'd all have to write a meson.build for (by hand). :/

If configure errors out with a message "Please run 'cargo install
bindgen-cli'" and that is really enough to make it build, I think that
should be enough to be counted as supporting the distro.

Kevin


