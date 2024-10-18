Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2368BD30007
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1n51-0002xF-5k; Fri, 18 Oct 2024 09:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1n4y-0002jd-8q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1n4w-0008Dr-Ce
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 09:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729258301;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+gmtm/O3HwNMVlM6XVnxpZorunulEMWieBBsnBuSNsw=;
 b=UQ0TTsZWgurPDwt6nPZQ7MH5bRnTKEWO3cFqyJMw7tm5hw/pWiC6LVboGwTco7ut/5h9n+
 iG4NnAfSaT7r/P8BoqEoQlwEVCrfjkTyzlXJuj4ITAB11eEV7vwG7i6IsLcOJO8RJ9MWTK
 oyGzyVF+1a9Ko43suDyRfKGQzRNZorA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-BG_h4o2EM9WpE3BdvS3gUw-1; Fri,
 18 Oct 2024 09:31:40 -0400
X-MC-Unique: BG_h4o2EM9WpE3BdvS3gUw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E21918E6582
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 13:31:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9473196586C; Fri, 18 Oct 2024 13:31:30 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:31:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 00/16] rust: allow older versions of rustc and bindgen
Message-ID: <ZxJjLpDe0-A_6PEL@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 15, 2024 at 03:17:18PM +0200, Paolo Bonzini wrote:
> On top of this, the required version of bindgen is still too new
> for Debian 12 and Ubuntu 22.04.  This is fixed by the last four patches.
> 
> This is an RFC for two reasons.  First, because it would be a valid
> decision to delay enabling of Rust until at least some of these
> features are available in all supported distros.

Lets say we maximise our back compatibility today, and have to
carry some sub-optimal code patterns.

1, 2, 3, 4 years down the lines, we can gradually eliminate
those undesired code patterns / workarounds, as older distros
naturally age-out of our matrix.  After 4 years our entire
matrix will have cycled, so we're not needing to carry this
debt for very long (4 years is not long in the context of a
project like QEMU which has been going several decades)

IOW, we're deciding between

 * creating a bit of rust technical debt in the immediate
   term, in order to enable rust by default sooner

vs

 * avoiding Rust technical debt, but delaying ability to
   enable rust by default.

We could consider all C code to be technical debt though,
and if we don't have Rust by default we'll continue  adding
yet more C code. IOW, option is just moving the debt from
Rust back to C, which is arguably worse on balance.

Personally I tend towards quicker adoption of Rust, despite
the need for short term workarounds, as they'll disappear
again reasonably quickly.

>                                                  Another possibility
> could be to accept Rust 1.64.0 but require installing a newer bindgen
> (0.66.x for example) on those two distros with an older release.

How difficult is it to get newer 'bindgen' installed on these
platforms ? The audience here is not so much distros trying to
package new QEMU, as that's ony relevant for new distro, but
rather it is end usrs/contributors building QEMU for themslves.

Can it be done automagically in the same way we "do the right thing"
with the 3rd party crates we depend on, or is bindgen special in
some way that makes it more inconvenient for users ?

>                                                                   Second,
> because the series is missing the CI updates to actually ensure that
> these minimum versions keep working.

On the last point, see

  https://lists.nongnu.org/archive/html/qemu-devel/2024-10/msg02688.html

with that series, it should be just a matter of adding '--enable-rust'
in a few key jobs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


