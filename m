Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14733C83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqpe-0005LU-0D; Thu, 10 Jul 2025 08:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZqop-0004za-EY
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uZqon-0006o0-43
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752152163;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7F4Kge51iGjEp/NV4So7vHdEbSTwiDx/VoJUEKxVkfM=;
 b=b2z/hj++KAVaLiadul3BB+BTYkRba73NRrEjFIoes10b8D9JQXwFz3ZMaSMlhgYU0IJ81E
 Sj4etjPGZZgB3gZfrRIVyoGPHsnwubggU3L5SOfHzy2DJRZFTGpc4p/5TYNxx28DKHPYtN
 6mJ82AL33VqjssByX5p2yTZyM9y7IAU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-gwL7pfHxOFOdAvx25d4Jcw-1; Thu,
 10 Jul 2025 08:56:00 -0400
X-MC-Unique: gwL7pfHxOFOdAvx25d4Jcw-1
X-Mimecast-MFC-AGG-ID: gwL7pfHxOFOdAvx25d4Jcw_1752152159
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FC7E19560A3; Thu, 10 Jul 2025 12:55:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.76])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66C671956094; Thu, 10 Jul 2025 12:55:56 +0000 (UTC)
Date: Thu, 10 Jul 2025 13:55:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PULL 19/23] util/qemu-sockets: Refactor success and failure
 paths in inet_listen_saddr()
Message-ID: <aG-4WAG8HZWNHGhY@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-20-berrange@redhat.com>
 <CAFEAcA9jxiazMKEyoPQQdqRBKydgkbKQobtLPyszSHT1M-LHGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9jxiazMKEyoPQQdqRBKydgkbKQobtLPyszSHT1M-LHGA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 10, 2025 at 01:17:40PM +0100, Peter Maydell wrote:
> On Thu, 22 May 2025 at 11:33, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > From: Juraj Marcin <jmarcin@redhat.com>
> >
> > To get a listening socket, we need to first create a socket, try binding
> > it to a certain port, and lastly starting listening to it. Each of these
> > operations can fail due to various reasons, one of them being that the
> > requested address/port is already in use. In such case, the function
> > tries the same process with a new port number.
> >
> > This patch refactors the port number loop, so the success path is no
> > longer buried inside the 'if' statements in the middle of the loop. Now,
> > the success path is not nested and ends at the end of the iteration
> > after successful socket creation, binding, and listening. In case any of
> > the operations fails, it either continues to the next iteration (and the
> > next port) or jumps out of the loop to handle the error and exits the
> > function.
> >
> > Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  util/qemu-sockets.c | 51 ++++++++++++++++++++++++---------------------
> >  1 file changed, 27 insertions(+), 24 deletions(-)
> >
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 4a878e0527..329fdbfd97 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> 
> 
> Hi; Coverity complains about this code (CID 1610306):
> 
> > @@ -303,11 +303,20 @@ static int inet_listen_saddr(InetSocketAddress *saddr,
> >          port_min = inet_getport(e);
> >          port_max = saddr->has_to ? saddr->to + port_offset : port_min;
> >          for (p = port_min; p <= port_max; p++) {
> > +            if (slisten >= 0) {
> > +                /*
> > +                 * We have a socket we tried with the previous port. It cannot
> > +                 * be rebound, we need to close it and create a new one.
> > +                 */
> > +                close(slisten);
> > +                slisten = -1;
> 
> Here we set slisten to -1 ...
> 
> > +            }
> >              inet_setport(e, p);
> 
> ...but then two lines later we unconditionally set slisten to
> something else, so the -1 assignment is overwritten without being
> used.
> 
> >              slisten = create_fast_reuse_socket(e);
> 
> What was the intention here ?

The overwriting is correct and intentional - it is best practice
to never leave a variable initialized to an FD number that is now
invalid. IMHO that best practice applies, even if we are going
to re-initialize the variable a short while later, because this
mitigates risk from later code refactoring.

TL;DR: coverity is correctly identifying a redundant assignment,
but the assignment is none the less justified.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


