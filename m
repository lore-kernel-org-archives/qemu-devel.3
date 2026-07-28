Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6014BC54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolMN-0006Qc-Bf; Tue, 28 Jul 2026 13:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wolMM-0006QR-9B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wolMK-0001oN-59
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785258771;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SSAEeQtSOqPdFzfXMzdEgGNaiHTbl2dLun87S48Rs0I=;
 b=BkeEPIbLDUFOHOug+XluYpgI9HJWOiSAOUuS9Hv1gwo1LFzybD5wTDMCTe8+/fCyEIpsJS
 yyJqyHzwTs3yEvrdq8dweYE9JUbmjZS1778xL72/DvpW/PurpzKU8KKrEUFmpA81AFBPvx
 ZCK7SHQAZzMpYVfvzn97RFOoVxj/toM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-JSz3ziEIPEqARY_FMntNTg-1; Tue,
 28 Jul 2026 13:12:49 -0400
X-MC-Unique: JSz3ziEIPEqARY_FMntNTg-1
X-Mimecast-MFC-AGG-ID: JSz3ziEIPEqARY_FMntNTg_1785258768
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95A9318004AD; Tue, 28 Jul 2026 17:12:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.113])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B1CF180049F; Tue, 28 Jul 2026 17:12:46 +0000 (UTC)
Date: Tue, 28 Jul 2026 18:12:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH 4/5] migration: Fix rare hang of
 migration_channel_read_peek()
Message-ID: <amjjCstVcrgvtgQP@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-5-peterx@redhat.com>
 <amjXxDH73ah-dUGE@redhat.com> <amjiLyOJF92okvik@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amjiLyOJF92okvik@x1.local>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 28, 2026 at 01:09:03PM -0400, Peter Xu wrote:
> On Tue, Jul 28, 2026 at 05:24:36PM +0100, Daniel P. Berrangé wrote:
> > On Tue, Jul 28, 2026 at 11:52:46AM -0400, Peter Xu wrote:
> > > In an unlikely case, when a migration stream is attached to the destination
> > > QEMU and only send <4 bytes to the channel as magic, it's possible that
> > > migration_channel_read_peek() may spin forever without yielding in the main
> > > thread causing two unwanted consequences:
> > > 
> > > - CPU will spin 100% waiting for the rest bytes until it reaches 4
> > > - (more importantly..) Main thread is stuck during this process as the qio
> > >   operation won't really yield the coroutine
> > > 
> > > Fix it by consuming the bytes that arrived.
> > > 
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
> > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > Reported-by: Feifan Qian <bea1e@proton.me>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/channel.c | 26 +++++++++++++++++++++++---
> > >  1 file changed, 23 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/migration/channel.c b/migration/channel.c
> > > index 1e2935f926..28fe1d2906 100644
> > > --- a/migration/channel.c
> > > +++ b/migration/channel.c
> > > @@ -294,11 +294,31 @@ int migration_channel_read_peek(QIOChannel *ioc,
> > >              return -1;
> > >          }
> > >  
> > > -        if (len == buflen) {
> > > +        if (len == iov.iov_len) {
> > >              break;
> > > -        }
> > > +        } else if (len == 0) {
> > > +            qio_channel_wait_cond(ioc, G_IO_IN);
> > > +        } else {
> > > +            ssize_t received = len;
> > >  
> > > -        qio_channel_wait_cond(ioc, G_IO_IN);
> > > +            /*
> > > +             * Partially arrived, read out to make qio_channel_wait_cond()
> > > +             * won't return immediately, causing an unwanted spin on this
> > > +             * CPU.
> > > +             */
> > > +            iov.iov_len = len;
> > > +            len = qio_channel_readv_full(ioc, &iov, 1, NULL, NULL, 0, errp);
> > 
> > Sure this breaks the API behaviour that the caller is expecting to
> > see.
> > 
> > migration_channel_identify will call migration_channel_read_peek
> > to match the magic bytes.
> > 
> > But something later in the flow will actually try to read the magic
> > bytes.  By consuming them in this migration_channel_read_peek
> > method, surely we're breaking the code that wants to read the bytes
> > later.
> 
> Ah right, stupid me.  The best then is for partial read we apply a manual
> wait.
> 
> I can also revert 604bb1badc ("migration: Properly wait on G_IO_IN when
> peeking messages"), looping with 1ms interval for data isn't too bad.  But
> the best is we only do that for partial, so:
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 1e2935f926..88f89521f8 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -296,9 +296,19 @@ int migration_channel_read_peek(QIOChannel *ioc,
> 
>          if (len == buflen) {
>              break;
> +        } else if (len == 0) {
> +            qio_channel_wait_cond(ioc, G_IO_IN);
> +        } else {
> +            /*
> +             * When partially ready, we can't use qio_channel_wait_cond()
> +             * because it will return immediately.  Apply a manual wait.
> +             */
> +            if (qemu_in_coroutine()) {
> +                qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
> +            } else {
> +                g_usleep(1000);
> +            }
>          }
> -
> -        qio_channel_wait_cond(ioc, G_IO_IN);
>      }

This approach looks best - a "normal" QEMU will never hit the sleep
loop, so we'll only get this spin if the client is intentionally
playing games by sending short packets.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


