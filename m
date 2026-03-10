Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA2CFD2D62
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 12:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzvos-0000W8-6T; Tue, 10 Mar 2026 08:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzvoX-0000UY-SJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vzvoU-0005Nb-QB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 08:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773144229;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBt5Iy8ztffOPis5Okh5iP2Xcaj6SaWEjYbFjrWy5SU=;
 b=ZsvkheBR/Lnnd6ROsVKB2WSrOs7kVTyCfQeeE3WXVqxq4K1FYP777AOi6d75yjNHeNBxcO
 8pF0cXoCExk4euG1s+RRwHdoe7nUPv+ziGwCha4BdLDsAkhYgLiXaIn4eLACzsfBzI61yi
 oiW1XVeQ37SrHYepWgf3SHFA9ymJeiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-UkRM6e3nNymCqCNK744TCg-1; Tue,
 10 Mar 2026 08:03:45 -0400
X-MC-Unique: UkRM6e3nNymCqCNK744TCg-1
X-Mimecast-MFC-AGG-ID: UkRM6e3nNymCqCNK744TCg_1773144225
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8DC1195608D; Tue, 10 Mar 2026 12:03:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.213])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E186E1956095; Tue, 10 Mar 2026 12:03:42 +0000 (UTC)
Date: Tue, 10 Mar 2026 12:03:39 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/functional: fix log placement when run directly
Message-ID: <abAImyumsgC6igqQ@redhat.com>
References: <20260309133633.3619913-1-berrange@redhat.com>
 <412d6508-7c30-4580-81e2-cfc69fb279e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <412d6508-7c30-4580-81e2-cfc69fb279e4@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Mon, Mar 09, 2026 at 06:46:28PM +0100, Thomas Huth wrote:
> On 09/03/2026 14.36, Daniel P. Berrangé wrote:
> > When running functional tests directly there are some heuristics
> > to figure out where the build directory lives, along with the
> > possibility to override the logic by setting the QEMU_BUILD_DIR
> > env variable. This env var is set as part of the test env when
> > run via Meson but not when run directly.
> > 
> > A particular flaw with the currently logic is that it silently
> > uses the wrong location when the build directory is a sub-dir
> > under "./build", which is a common usage scenario for some devs.
> > 
> > With the recent introduction of the 'run' script, we now have
> > the MESON_BUILD_DIR env variable set unconditionally, so we
> 
> s/MESON_BUILD_DIR/MESON_BUILD_ROOT/
> 
> > can rely on that from the functional tests to get the correct
> > location in all scenarios.
> 
> That's a good idea!
> 
> > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   tests/functional/meson.build         | 2 +-
> >   tests/functional/qemu_test/config.py | 4 ++--
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> > index b979cff2b9..d34aefa8b0 100644
> > --- a/tests/functional/meson.build
> > +++ b/tests/functional/meson.build
> > @@ -74,7 +74,7 @@ foreach speed : ['quick', 'thorough']
> >         test_deps += [qemu_img]
> >       endif
> >       test_env.set('QEMU_TEST_QEMU_BINARY', test_emulator.full_path())
> > -    test_env.set('QEMU_BUILD_ROOT', meson.project_build_root())
> > +    test_env.set('MESON_BUILD_ROOT', meson.project_build_root())
> 
> I think you could even completely remove this line now completely - if I've
> got that right, meson also sets this environment variable for tests
> automatically.

No, meson does not set MESON_BUILD_ROOT by default - that's something
we have to do ourselves. For the 'run' script we define it in the
'devenv' environment, but for tests we need to define it here.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


