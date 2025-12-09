Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAED6D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 08:34:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSt9y-0002Kz-JH; Tue, 09 Dec 2025 03:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSt9x-0002Kq-9G
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:33:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vSt9u-0005mJ-ML
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 03:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765269200;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gqc6g49t7qmRrKnz4lO0l1sckttjFL5/yWrfvbjuFzU=;
 b=LOkZrpn8F5EgLMcwmyXCErzyqtvxNaCitLbNwBsoquaubjuuZarq9VvIIHyvshX3cBkJ/R
 UEV88fEhRA3ldXfGJ3dsR7MqGKZa3BHDDTkktMSLtco7A/22AlFaSm1dHcM2TBZothdeI6
 KCbLEBsBR/mqYkus0WdMZfEF550vesM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-QP97zEufOQSi7Vd9c1Gmrg-1; Tue,
 09 Dec 2025 03:33:17 -0500
X-MC-Unique: QP97zEufOQSi7Vd9c1Gmrg-1
X-Mimecast-MFC-AGG-ID: QP97zEufOQSi7Vd9c1Gmrg_1765269196
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C36D19560A7; Tue,  9 Dec 2025 08:33:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5A9219560AD; Tue,  9 Dec 2025 08:33:14 +0000 (UTC)
Date: Tue, 9 Dec 2025 08:33:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric K <erickra@cs.utexas.edu>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] char-udp: Fix initial backend open status
Message-ID: <aTfetmPB8MsNa3kv@redhat.com>
References: <20251208225849.705554-1-erickra@cs.utexas.edu>
 <CAJ+F1C+-v-O=avgRPD7HO_E4hWFkET3FjzG0Jb8k6fdfk=FLPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+-v-O=avgRPD7HO_E4hWFkET3FjzG0Jb8k6fdfk=FLPA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 09, 2025 at 12:02:10PM +0400, Marc-André Lureau wrote:
> Hi Eric
> 
> On Tue, Dec 9, 2025 at 5:18 AM Eric K <erickra@cs.utexas.edu> wrote:
> >
> > This patch removes the `*be_opened = false` override for the UDP chardev
> > backend. Since UDP is connectionless it never sends a `CHR_EVENT_OPENED`
> > so it is never marked open. This causes some frontends (e.g. virtio-serial)
> > to never perform any operations on the socket.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2993
> > Signed-off-by: Eric K <erickra@cs.utexas.edu>
> 
> UDP is connection-less, so it will not be notified when a client is
> ready to receive. If we make the chardev always open, the device may
> send data too early though.
> 
> At the same time, a chardev that only reads isn't very useful.

Loosing data due to no client in the receive end is the price users
willing accept when they choose to use the UDP backend.

If they need reliable data transfer we have better chardev backends
than UDP available to use.

> I don't think we need to introduce a property for the change of behaviour.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> > ---
> >  chardev/char-udp.c     | 2 --
> >  tests/unit/test-char.c | 2 ++
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> > index 572fab0ad1..1025f577a0 100644
> > --- a/chardev/char-udp.c
> > +++ b/chardev/char-udp.c
> > @@ -215,8 +215,6 @@ static void qmp_chardev_open_udp(Chardev *chr,
> >      g_free(name);
> >
> >      s->ioc = QIO_CHANNEL(sioc);
> > -    /* be isn't opened until we get a connection */
> > -    *be_opened = false;
> >  }
> >
> >  static void char_udp_class_init(ObjectClass *oc, const void *data)
> > diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> > index 8a98e42cad..2869c4e09d 100644
> > --- a/tests/unit/test-char.c
> > +++ b/tests/unit/test-char.c
> > @@ -1012,6 +1012,8 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
> >          qemu_chr_fe_init(fe, chr, &error_abort);
> >      }
> >
> > +    g_assert(chr->be_open);
> > +
> >      d.chr = chr;
> >      qemu_chr_fe_set_handlers(fe, socket_can_read_hello, socket_read_hello,
> >                               NULL, NULL, &d, NULL, true);
> > --
> > 2.52.0
> >
> >
> 
> 
> -- 
> Marc-André Lureau
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


