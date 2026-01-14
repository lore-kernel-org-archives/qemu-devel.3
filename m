Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A54ED29FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 11:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfyvh-0002vF-Hf; Wed, 14 Jan 2026 06:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfyvI-0002gQ-Av
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfyvG-00058p-7U
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 06:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768389621;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZxN4qlSuAsgdFGGeaTTomtCoLJk88bqi5H3ND7X1xU=;
 b=gZ1echt4C2BWoVYBjiIh+85qSsMtJghXhF/2Y77kTX36B3hj9XxXQKgrKwuHxee55dMuaT
 qSJDsaOEL345nC0fhOgcy/pDWdCt/J0v+H1WWn/xej3bx5/c/ZIlR96zoklbPixWFgK45b
 o0lrEFwl7utVldffzMZXll7HBsujPaw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-T5R0upUeNRaHZXKDklGjeg-1; Wed,
 14 Jan 2026 06:20:17 -0500
X-MC-Unique: T5R0upUeNRaHZXKDklGjeg-1
X-Mimecast-MFC-AGG-ID: T5R0upUeNRaHZXKDklGjeg_1768389616
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E556618005B5; Wed, 14 Jan 2026 11:20:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 690E130001A2; Wed, 14 Jan 2026 11:20:06 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:20:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:Rust-related patc..." <qemu-rust@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5 02/24] include: define constant for early constructor
 priority
Message-ID: <aWd74K3eQTf1y91E@redhat.com>
References: <20260108170338.2693853-1-berrange@redhat.com>
 <20260108170338.2693853-3-berrange@redhat.com>
 <d3ca3fb5-e972-4446-b32c-f20fd8825cca@redhat.com>
 <aWDqie0eYZ8GeQHF@redhat.com>
 <6e60a89f-6798-4ea5-bbd0-553130786cec@redhat.com>
 <87h5spc29h.fsf@pond.sub.org>
 <CABgObfZn753g5Ve4AHi4gX0DtKdDBWV8aCuRSha5ySv9Y_4OGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfZn753g5Ve4AHi4gX0DtKdDBWV8aCuRSha5ySv9Y_4OGg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 13, 2026 at 10:32:48AM +0100, Paolo Bonzini wrote:
> Il mar 13 gen 2026, 10:04 Markus Armbruster <armbru@redhat.com> ha scritto:
> 
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> >
> > > On 1/9/26 12:46, Daniel P. Berrangé wrote:
> > >> IMHO the root problem is that it is pretty dubious for us to be
> > >> spawning the RCU thread from a constructor. Constructors should
> > >> be limited to minimal initialization of state.
> >
> > Yes!  Discussed in review of v3:
> >
> >     https://lore.kernel.org/qemu-devel/87frck1dds.fsf@pond.sub.org/
> >     Message-ID: <87frck1dds.fsf@pond.sub.org>
> >
> > >>                                                Spawning threads
> > >> is outside the boundary of what I'd consider reasonable for
> > >> a constructor todo. I didn't want try to tackle refactoring the
> > >> RCU thread creation though, hence this gross workaround.
> > >
> > > I see.  Maybe we could (just as gross but smaller) do the RCU
> > constructor late.  Not something that you need to do now, of course.
> >
> > Could we use an old-fashioned initialization function instead of a
> > constructor for RCU?
> >
> 
> You have to do it in all main()s, which make it unwieldy for tests etc.
> 
> Another possibility is to do it lazily on first call_rcu, and just clear
> the flag in the atfork callbacks.

I'd be concerned that we would not be able to rationalize what thread is
starting the RCU thread. It will probably be the main thread, but proving
that will be difficult. A thread which is not the main thread may have
undesirable CPU affinity set which we don't have the RCU thread to inherit.

IMHO if we remove the constructor, then we need to have a strong guarantee
that it is spawned from the main() method and not from any other background
thread.

I wouldn't rule our doing it manually from every main() method. We could
probably come up with something to make it less of a burden for test
programs.

eg replace g_test_init() with q_test_init() which combines g_test_init
with RCU thread creation.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


