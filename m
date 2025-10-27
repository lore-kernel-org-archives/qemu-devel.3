Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35850CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKJa-0006nB-Jg; Mon, 27 Oct 2025 06:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDKJY-0006mS-VZ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:19:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vDKJW-00056o-7X
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761560335;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0I7Il8PGSe1NIostIwQs+k8+quOSKAZMu2O9qzR0lkc=;
 b=FrSEbN8rLw4ZjRPfqfwN+1d/f9lrj5HhEFZtAHX3I2ULBiQAwUEQoqYTaKSd9SroZV9VVU
 7+3jnA5i+oiz0Q5DL14OJSjUo1/ti1ajfsCGd64h/fezCiCSJcHjG9d5R5dSggPR987L2Q
 ougV8FzRt8vHoixzNtox6BNjLIFHCJQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-ozkl54mtO82lqpq9WuYqAA-1; Mon,
 27 Oct 2025 06:18:51 -0400
X-MC-Unique: ozkl54mtO82lqpq9WuYqAA-1
X-Mimecast-MFC-AGG-ID: ozkl54mtO82lqpq9WuYqAA_1761560330
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E815B1954210; Mon, 27 Oct 2025 10:18:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.35])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 437443000223; Mon, 27 Oct 2025 10:18:46 +0000 (UTC)
Date: Mon, 27 Oct 2025 10:18:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Grant Millar | Cylo <rid@cylo.io>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2 0/3] io: fix crash in VNC websock server when client
 quits early
Message-ID: <aP9HAtXK1HJlKzbO@redhat.com>
References: <20251003150245.3510069-1-berrange@redhat.com>
 <6f06c770-d66a-4520-8646-30b30c990235@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6f06c770-d66a-4520-8646-30b30c990235@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 26, 2025 at 11:02:48AM +0300, Michael Tokarev wrote:
> On 10/3/25 18:02, Daniel P. Berrangé wrote:
> > See patch 3 for the description of the problem and reproducer
> > 
> > Changes in v2:
> > 
> >   - Improve finalizer robustness of TLS source
> >   - Keep cleanup in finalizer of websock, just augment
> >     it in the close method
> >   - Fix resetting of hs_ioc_tag value when callback
> >     is complete
> >   - Add CVE assignemnt in 3rd patch
> > 
> > Daniel P. Berrangé (3):
> >    io: release active GSource in TLS channel finalizer
> >    io: move websock resource release to close method
> >    io: fix use after free in websocket handshake code
> > 
> >   include/io/channel-websock.h |  3 ++-
> >   io/channel-tls.c             | 10 ++++++++++
> >   io/channel-websock.c         | 33 ++++++++++++++++++++++++++-------
> >   3 files changed, 38 insertions(+), 8 deletions(-)
> 
> Hi Daniel!
> 
> Is this patchset not supposed to go to the stable qemu series?
> I think it should?

Yes, it is applicable to all active stable branches - the bug has been
present since 2.6.0 AFAICT.

I've just sent a pull request for master

  https://lists.nongnu.org/archive/html/qemu-devel/2025-10/msg06571.html

these three websock related patches will probably cherry-pick without
trouble.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


