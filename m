Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C77D0E6DE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 13:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNt18-0004uk-Hb; Tue, 25 Nov 2025 08:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vNt17-0004s6-4t
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:23:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vNt15-0001M6-0T
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 08:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764077012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feLSS8xmQ8wpyH5IhvvP9eIyw+gMm6vVWVx5wD4zGBs=;
 b=LcahL7ws1wQP/o6N1gmx2yWhBbXrs+j7cacJPHiYVLuvnp2DQP7zYR+wAnHzQofJ0n9tnL
 1oer5use8k0oyLULdIpFXGTepCEUXuK4GUqq25fgvCRPEIReGY72lr8B4oh9nX9CmmdMJO
 gIh1dpjhmqq5z8osIJCaoFoWmCVYPjA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-I6dymSfqMxSUeFySjCcRUA-1; Tue,
 25 Nov 2025 08:23:27 -0500
X-MC-Unique: I6dymSfqMxSUeFySjCcRUA-1
X-Mimecast-MFC-AGG-ID: I6dymSfqMxSUeFySjCcRUA_1764077006
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53BEE180034F; Tue, 25 Nov 2025 13:23:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8697180049F; Tue, 25 Nov 2025 13:23:22 +0000 (UTC)
Date: Tue, 25 Nov 2025 13:23:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Moritz Haase <Moritz.Haase@bmw.de>, qemu-devel@nongnu.org,
 petrosagg@resin.io, nghiant2710@gmail.com, forumi0721@gmail.com,
 laurent@vivier.eu
Subject: Re: [PATCH] linux-user: add option to intercept execve() syscalls
Message-ID: <aSWtx_eqAXecxAYX@redhat.com>
References: <20251125103859.1449760-1-Moritz.Haase@bmw.de>
 <aSWe0_oaclL83ovL@redhat.com>
 <CAFEAcA9M4jpWnUuPuz8AxnSuPn2go3yL5eKBdzNd6UawXTaD8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9M4jpWnUuPuz8AxnSuPn2go3yL5eKBdzNd6UawXTaD8Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Nov 25, 2025 at 01:14:23PM +0000, Peter Maydell wrote:
> On Tue, 25 Nov 2025 at 12:20, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Tue, Nov 25, 2025 at 11:38:59AM +0100, Moritz Haase wrote:
> > > +        if (i_arg) {
> > > +            new_argv = g_alloca(sizeof(void *));
> > > +            new_argv[0] = i_arg;
> >
> > FYI, use of g_alloca() is no longer permitted in QEMU code.
> >
> > I thought we blocked that with -Walloca, but it seems we do not.
> > We ought to fix that gap.
> 
> We don't because we haven't yet eradicated all existing uses
> of alloca type functions. We did that for the system emulation
> code, but didn't find a way to add the -Walloca warning only
> for the non-linux-user code:
> 
> https://lore.kernel.org/qemu-devel/20250901132626.28639-1-philmd@linaro.org/
> 
> There are still a handful of alloca() calls in linux-user/
> and bsd-user/ which ideally we would convert but which haven't
> been very high priority to clean up (because a linux user
> guest can scribble all over QEMU memory anyway if it likes,
> so being able to overrun the stack by passing a large value
> into an alloca size doesn't let it do anything it couldn't
> do by other means).

I think we can fix that with a pragma.  eg Add -Walloca to meson.build
for everything, then add _Pragma("GCC diagnostic ignored -Walloca") to
only linux-user/syscall.c and bsd-user/os-syscall.c files.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


