Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9EBC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp6Nc-0005Es-Ao; Wed, 29 Jul 2026 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp6Na-0005DM-N8
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wp6NY-0001e4-1F
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 11:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785339570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkKK1kzKTi7FWkDyvxrelfwwnkETa8SMI+h6Y5+NxYM=;
 b=hYQ8s8wfsqqIoGRIhrqqJIa6+Ih46x09ClTPiAe80UBqtgIuRPF8rcMUWdRQyed8X8jaoV
 V53GlOo81MaMPvjSTGm1NWLVpKWkbfBMe8K/A/w2pJy9/1qnJC0iC+oJMrkLpVI70G4csx
 uHeeRdFdVpYjhh8AdPvnLcssI341XU4=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-WZabgAxJMzKp4GIoxKSnQg-1; Wed, 29 Jul 2026 11:39:29 -0400
X-MC-Unique: WZabgAxJMzKp4GIoxKSnQg-1
X-Mimecast-MFC-AGG-ID: WZabgAxJMzKp4GIoxKSnQg_1785339568
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5bfc75c9fbfso1103553e0c.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 08:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785339568; x=1785944368; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZkKK1kzKTi7FWkDyvxrelfwwnkETa8SMI+h6Y5+NxYM=;
 b=Kd4M8/9hq8cnL/sqBNPVPCJeV5kP4MCGYjTtzV0NFo/Q9I1zN5OvcZZNfVcLgRElnS
 SLmZ57+EoTTMRZuu4xxJm6cHnkVh3NQzzVxYyRmswags5kbNEOudS27JORGQlij+3Tx1
 r/fn/PCu32ZTCRIA5cl5ZwTSbd/ITnp+XQ2DoPGl0LnFNfdOr+1yS2WBS6LCImQfcAyq
 eIvZCwLuizFRN+qhLYS99ESwC9DZs3Ft67iYI4szOEAEs7aYY7kaFgJmo2HEInntHRvb
 KK6bjfSR/9/8ugjQCckMKUZIVDgcvMCKabGbC+VZH6+JyKvDh5hZyCA+Iq7A1f5JiH9g
 2qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785339568; x=1785944368;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZkKK1kzKTi7FWkDyvxrelfwwnkETa8SMI+h6Y5+NxYM=;
 b=KPjewoZxirpJEohlSXvVnmpWa1C2u7gz7RMkWMAV7q2OVv6e2hK6DzV5rSldKF6dMh
 4uXfd1fhSKe+/0miHKlvoyOZDDMgfzUldxVO68M5u/cFJ4W0IL6as61HX5svs5D8le59
 y4Kg6O3coDLgfAydAdMkbwmr7RYNPHumIfr9mKatmp69FYNxDv1eP7SehQtICuI1c2RN
 9tbFVsNGmEPE9tVzap+GNdVRbIs9AnNGxJUyPtkgpxpYriQnvkzdmcOjR7tVsSpxCZRi
 S41svTi4sb0YHeC9a8ROiDGRgnI1MwYPstYwsEthr/OjbkzTiyEqgN6LmorriuhqH7cn
 W1yw==
X-Gm-Message-State: AOJu0YyvsK39mFwgiyr92IFjlpfv5DtF3yA7yfa9TUnWlR1FQbdyGTxf
 CJWvUsCzTRhjV1Hq6qnU46KcglRhalRtN2xJq5PR/0n4Rn/BW4YDUO1yNMnakR2tcJKWVx1jSC2
 F4q33lh5z56SmpaNAfXKtSsr18F10BmftSRGt/MhpY17/Ly8NYUFtKROa
X-Gm-Gg: AR+sD13ne0JsubGgdXxjDatYhuORwjzd91P08CPO2rmv/iaITg+PfH8bOBge2XNhUt1
 1TY6ni5S9izlF7U2DmzUbm9qvg0qkw3XOzO7jy69W/2BwuoiN9RrF3PdrHhCZ3oMHU4dP5DgZZl
 1MwumgQ7Zo14NNuX/MAvKKmpp7GqksSa4h1c4a/Ci4cq/joX+rWo1fF1lt+iLfRUsZQhTD12YH7
 ih8RJ0un1F/yZlMdUOr8hTYF2b3vgK4fvU6PpBhDxtLzdx1h9OgxrFjGmSAD3VIZWI5Cl6hpb8D
 lQ0AFoMeC0y71BeCzVUK7Ykh62ugru+gQt3cM6ZJJyC875LWzo9r+Yx8wDlVSZNls4GZ
X-Received: by 2002:a05:6122:4f9c:b0:5bf:853c:937e with SMTP id
 71dfb90a1353d-5c33fae07b1mr3543274e0c.13.1785339568079; 
 Wed, 29 Jul 2026 08:39:28 -0700 (PDT)
X-Received: by 2002:a05:6122:4f9c:b0:5bf:853c:937e with SMTP id
 71dfb90a1353d-5c33fae07b1mr3543233e0c.13.1785339567342; 
 Wed, 29 Jul 2026 08:39:27 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c34ec44bb6sm2430344e0c.0.2026.07.29.08.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:39:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:39:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH v2 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amoeq7TEbjF1wkZX@x1.local>
References: <20260728210417.1925078-1-peterx@redhat.com>
 <20260728210417.1925078-5-peterx@redhat.com>
 <amkfP-dtwmxzg_TC@x1.local> <amoRn1-uqUWjXlsc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amoRn1-uqUWjXlsc@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 29, 2026 at 03:43:43PM +0100, Daniel P. Berrangé wrote:
> On Tue, Jul 28, 2026 at 05:29:35PM -0400, Peter Xu wrote:
> > On Tue, Jul 28, 2026 at 05:04:16PM -0400, Peter Xu wrote:
> > > In an unlikely case, when a migration stream is attached to the destination
> > > QEMU and only send <4 bytes to the channel as magic, it's possible that
> > > migration_channel_read_peek() may spin forever.
> > > 
> > > Fix it by adding a manual sleep for partial read.
> > > 
> > > Since the path isn't attached to a coroutine, it means when partial read
> > > happens, there's yet not much we can do but hang the main thread, it will
> > > happen even for len==0 case.  It means monitors can hang due to this,
> > > either partial read or no data arrived (but connection established).
> > > 
> > > Leave this for later, the hope is this is extremely rare in production.
> > > 
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> > > Reported-by: Feifan Qian <bea1e@proton.me>
> > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/channel.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/migration/channel.c b/migration/channel.c
> > > index 1e2935f926..f446561b59 100644
> > > --- a/migration/channel.c
> > > +++ b/migration/channel.c
> > > @@ -296,9 +296,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
> > >  
> > >          if (len == buflen) {
> > >              break;
> > > +        } else if (len == 0) {
> > 
> > I think this should be QIO_CHANNEL_ERR_BLOCK, not 0..  I'll fix it when I
> > post v3, and I'll do some more tests.
> 
> Yep, 0 == EOF, so you'll need ERR_BLOCK.
> 
> > 
> > > +            qio_channel_wait_cond(ioc, G_IO_IN);
> > > +        } else {
> > > +            /*
> > > +             * When partially ready, we can't use qio_channel_wait_cond()
> > > +             * because it will return immediately.  Apply a manual wait.
> > > +             */
> > > +            assert(!qemu_in_coroutine());
> > > +            g_usleep(1000);
> 
> So this will block the main loop, but this is OK because
> 
>  * If the network is untrusted, migration should have been configured
>    to use TLS with a certificate allow-list. This peek takes place
>    after the TLS handshake so is protected
>  * On the dest host, it doesn't hugely matter that we block the main
>    loop as there's no running guest yet that will stall. Just any
>    use of QMP commands on the dest will stall.

Yes, it's more about hanging the monitors.  I think that's indeed an
unwanted behavior, it's just that such behavior existed since the read peek
was merged so it's a while, and it won't happen in normal cases.

To fix it, we can consider creating the coroutine early, but my gut feeling
is it'll be hard because we can have quite some assumptions that all things
will be serialized during establishing all channels, so I suspect we're not
ready having >1 coroutines each on setting up some channel.

A better way might be that if we can land the threadify loadvm series:

https://lore.kernel.org/r/20251022192612.2737648-1-peterx@redhat.com

Then we can offload all channel operations into the thread and I think it's
easier creating the thread early instead, since everything will still be
serialized in that thread with no worry of half-processed coroutines. The
main thread should forward each new iochannel to the thread and continue
the event loop.

Thanks,

-- 
Peter Xu


