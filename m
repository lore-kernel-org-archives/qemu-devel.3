Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0FDD44142
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 11:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDME4-00031a-TM; Tue, 19 Nov 2024 06:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDME3-00031A-Cf
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:16:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDME0-00013V-9B
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732015010;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RlI2dHnTdLwiGWENeaqW5TiYa4TbToOJ94Qr4o13BN4=;
 b=JnTpsSKhjPWhZ0wcCoWlsMqfT/TqOIFxG+OcXxXYLXx1JoEVmhT9djLHx2b4JS9pJeE6o4
 PMW5I+HsaIL5Bp7nzTVh8Dli90hBBvALWYxVd/VNVY52pK7pKkjA1inQxp8WWKBGN7I8h6
 pLy4QXtjJHtHfjtHz6l6dheGpH7y+7A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-32y2_H6sOzCj-eLwpvLJRw-1; Tue,
 19 Nov 2024 06:16:46 -0500
X-MC-Unique: 32y2_H6sOzCj-eLwpvLJRw-1
X-Mimecast-MFC-AGG-ID: 32y2_H6sOzCj-eLwpvLJRw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67BFE1956048; Tue, 19 Nov 2024 11:16:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.110])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ABDB1955F40; Tue, 19 Nov 2024 11:16:37 +0000 (UTC)
Date: Tue, 19 Nov 2024 11:16:34 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 4/7] docs/devel: add information on how to setup build
 environments
Message-ID: <ZzxzkiKX5-qQS_iU@redhat.com>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-5-pierrick.bouvier@linaro.org>
 <ZzxZRwXAIlMt6SNA@redhat.com> <87mshvqy5f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mshvqy5f.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 19, 2024 at 11:08:12AM +0000, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Mon, Nov 18, 2024 at 09:23:54AM -0800, Pierrick Bouvier wrote:
> >> MacOS and Linux are straightforward, but Windows needs a bit more
> >> details.
> >> 
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >> ---
> >>  docs/about/build-platforms.rst   |   4 +-
> >>  docs/devel/build-environment.rst | 114 +++++++++++++++++++++++++++++++
> >>  docs/devel/index-build.rst       |   1 +
> >>  3 files changed, 118 insertions(+), 1 deletion(-)
> >>  create mode 100644 docs/devel/build-environment.rst
> >> 
> <snip>
> >> +Fedora
> >> +++++++
> >> +
> >> +::
> >> +
> >> +    sudo dnf update && sudo dnf builddep qemu
> >> +
> >> +Debian/Ubuntu
> >> ++++++++++++++
> >> +
> >> +You first need to enable `Sources List <https://wiki.debian.org/SourcesList>`_.
> >> +Then, use apt to install dependencies:
> >> +
> >> +::
> >> +
> >> +    sudo apt update && sudo apt build-dep qemu
> >> +
> >> +MacOS
> >> +-----
> >> +
> >> +You first need to install `Homebrew <https://brew.sh/>`_. Then, use it to
> >> +install dependencies:
> >> +
> >> +::
> >> +
> >> +    brew update && brew install $(brew deps --include-build qemu)
> >
> >
> > The downside in recommending the 'build dep' approach is that it misses
> > out on deps that have been newly introduced in qemu.git, since whatever
> > old version of QEMU the distros are shipping.  It also misses deps for
> > any features the distro vendor has decided to exclude.
> >
> > Can we put a caveat describing this limitation at the top, so that users
> > have pointer if things don't quite go the way we expected.
> 
> At a recent QEMU workshop I presented I pointed to lcitool as a way to
> list the minimal dependencies QEMU needs:
> 
>   ./tests/lcitool/libvirt-ci/bin/lcitool variables -f yaml debian-12 ./tests/lcitool/projects/qemu-minimal.yml
> 
> It wouldn't be the hardest thing to extend lcitool to generate a pkg
> install line instead of a list. Although I notice it fails with the full
> set of dependancies:
> 
>   ✗  ./tests/lcitool/libvirt-ci/bin/lcitool -d tests/lcitool variables -f shell debian-12 ./tests/lcitool/projects/qemu.yml
>   Package generic name resolution error: Package libcbor not present in mappings

I think your libvirt-ci git submodule might be out of date. The current
generated Dockerfiles include libcbor and its in the mappings.

> I note there is already an "install" action but I'm wary of what it does.

That's related to lcitool functionality for provisioning VMs - kinda like
QEMUs tests/vm/ stuff.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


