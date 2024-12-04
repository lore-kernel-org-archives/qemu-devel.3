Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749D6E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIlDm-00087j-9e; Wed, 04 Dec 2024 03:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIlDg-00087C-ND
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIlDe-0007lV-6C
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733302727;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oz0CHp/g7LcfMMxQkjHBEWKwTD70Vh2TEYeJy5vrgOI=;
 b=NpmFOvbF9gFX5YahILCMOUZLw+rgr6mKzTZP+8uqoZsSzectoma5pm5GPM390wbiR5UYje
 N7WF4sFOgXPvUi9q76N8wBJhWoq+sS0Ae6VVm6bro+9MKLv2sCqzRR8L1M9NR+Vetw80F3
 7udmmHn7M9duOr/M1a15BFA3B2HDfCk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-mxoMLOZpMJaiKuXo4z-fsQ-1; Wed,
 04 Dec 2024 03:58:42 -0500
X-MC-Unique: mxoMLOZpMJaiKuXo4z-fsQ-1
X-Mimecast-MFC-AGG-ID: mxoMLOZpMJaiKuXo4z-fsQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC8A719560A5; Wed,  4 Dec 2024 08:58:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.92])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44EE31956089; Wed,  4 Dec 2024 08:58:30 +0000 (UTC)
Date: Wed, 4 Dec 2024 08:58:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
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
 gustavo.romero@linaro.org
Subject: Re: [PATCH 5/7] docs: add a codebase section
Message-ID: <Z1AZs50I-7oxGhlb@redhat.com>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-6-pierrick.bouvier@linaro.org>
 <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
 <87zflcbs0l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zflcbs0l.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Dec 03, 2024 at 05:22:50PM +0000, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Mon, 18 Nov 2024 at 17:24, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >>
> >> Present the various parts of QEMU and organization of codebase.
> >>
> >> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> >
> > I like this; it's something I've thought for a while would
> > be good to have, but which I never got round to trying to
> > put together. Thanks for doing this!
> >
> > Mostly my comments below are spelling/typo nits and
> > other minor stuff.
> >
> >> ---
> >>  docs/about/emulation.rst               |   2 +
> >>  docs/codebase/index.rst                | 211 +++++++++++++++++++++++++
> >>  docs/devel/decodetree.rst              |   2 +
> >>  docs/devel/ebpf_rss.rst                |   2 +
> >>  docs/devel/index-internals.rst         |   2 +
> >>  docs/devel/migration/main.rst          |   2 +
> >>  docs/devel/qapi-code-gen.rst           |   1 +
> >>  docs/devel/testing/main.rst            |   9 +-
> >>  docs/devel/testing/qtest.rst           |   2 +
> >>  docs/index.rst                         |   3 +
> >>  docs/interop/qemu-ga.rst               |   2 +
> >>  docs/system/qemu-block-drivers.rst.inc |   2 +
> >>  docs/tools/qemu-storage-daemon.rst     |   2 +
> >>  docs/user/main.rst                     |   6 +
> >>  14 files changed, 247 insertions(+), 1 deletion(-)
> >>  create mode 100644 docs/codebase/index.rst
> >>
> <snip>
> >> +  Block devices and `image formats<disk images>` implementation.
> >> +* `bsd-user <https://gitlab.com/qemu-project/qemu/-/tree/master/bsd-user>`_:
> >> +  `BSD User mode<bsd-user-mode>`.
> >> +* build: Where the code built goes!
> >
> > The built code doesn't have to be in 'build'. We could say:
> >
> >  * build: You can tell the QEMU build system to put the built code
> >    anywhere you like. By default it will go into a directory named
> >    ``build``. Sometimes documentation will assume this default
> >    for convenience when describing command lines; you can always
> >    replace it with the path to your build tree.
> >
> > ?
> 
> I always recommend creating a builds directory and having multiple build
> trees under it:

I can understand why you do that, but I'm doubtful the need to have
many parallel build directories is the common case. IOW, I expect
that for the majority of contributors the default single 'build'
directory is sufficient.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


