Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B19C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 21:14:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfmi6-0007Bm-VX; Wed, 05 Feb 2025 16:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfmi3-0007B5-7n
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfmhz-0005iF-DB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 16:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738789996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNxSYoldSwapE5IjZ5OkdfcO/gBLkgDNiWRh/POWT6I=;
 b=R4I7wFEYP2frOpz+Sv57U+ckwGU8G0gO6ELLgu0xMYLRv6UhDpL5MH8RV7wXTjK4jyfj4L
 tYaOz5va0xds5wWVEkdVmVgZeMjIrkV73U1GtZ0/ykD8eorYYG0QQ9UxBZr/XK+nIGxA72
 GTQpXTDGwE3/kBXXHN1RHpNl4l8+Jq0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-zRl52eNxMGuX96lfrPz8bA-1; Wed, 05 Feb 2025 16:13:14 -0500
X-MC-Unique: zRl52eNxMGuX96lfrPz8bA-1
X-Mimecast-MFC-AGG-ID: zRl52eNxMGuX96lfrPz8bA
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46792701b64so4182271cf.3
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 13:13:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738789994; x=1739394794;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BNxSYoldSwapE5IjZ5OkdfcO/gBLkgDNiWRh/POWT6I=;
 b=Z3mPOxtuu6odfXYcmFHi/D3QIVrKm98Vpw2Q5y9RVr0MGES+0DhRbTDcTwrpxjbWDR
 uHaYrLzlhhxGQAEXQF7I1B9+GU+Boeukng4Wtpjzy4yd8DxMtq/guUNFmXFYDLXXAl7n
 iGnzR/iElwYYVX7InDEagYhEOq8Y4+2FM8JKrxr/74em62PbceHJGAxXwdeEN+lMPuGS
 jMJv4c4d+jEe72YSeshsZzXjFmNpVxCuQDz0BoKxHznuEo3Euh7EMfBI/B6l/lxc6+jI
 KsKIGj49NgpelrnmUKUAvV5TMs24EaJyRwodleLp96O0GEUwIzTcPJO7VLJsnTn868lc
 3ZjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4G1JbcEAjI8GLCriAlVrnW0yi4Gn7aFFV49RnxqrSJXSuPZvn6F7cirOYjuQxp4/Zd8CADrDJBdqt@nongnu.org
X-Gm-Message-State: AOJu0YzdH5SvqHzTW8FJO9HeCJ9K7SvkFw1OlH5JodwYqPRMG3gFFe5h
 xmIm/GKiiQH/Z3ZuZscdbtjKIdiBEZ+ihO/npxHLpdZkBNrSNHGDlbObN9OpR7z5pTnLiRjuBed
 GDv13wT9ozAqzWRLK3c+zGB+ddx9yJWM1+8q73+wkj9osKW7eG0cd
X-Gm-Gg: ASbGncuPVbmRxpgA7/mvnaJM2VzrmfAqnoV2hUfk+bA+jG8/DvMawQCTmLInEnCAauD
 yhk+JrQRKpllFdVKs/AkXUgyXqFo0o7PyiNGbnKvn9E+DpkeqBkhjgrpgGxQwDByDQZCpeQxl0F
 O99eQ3DNn53pfvl1kuHYmgJpNrpubr4XxEbGMjLxyT3+Y5mPmWbH9ibom565onSfqCtEqr3Yy2E
 vGhfyKZOqiXhvekrPCTiSsXIFkSJPhscpIqh9AmdOHYvr6xSoLFYMuIDbIRD70oHbkVK3COemWA
 YpIuYzDV8C813V4sA6El4moZ0HtwOpRsldYdDHT5rr50xgP7
X-Received: by 2002:a05:622a:1353:b0:466:9197:b4fb with SMTP id
 d75a77b69052e-470282dec19mr58528391cf.47.1738789994332; 
 Wed, 05 Feb 2025 13:13:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPf2rIf7oj3+VPgTgzClBoQBeNAPM0x9PTzbU4XcBRKL5ToOI0/j9S08gGBWpLbcJcHm7H2Q==
X-Received: by 2002:a05:622a:1353:b0:466:9197:b4fb with SMTP id
 d75a77b69052e-470282dec19mr58528051cf.47.1738789993895; 
 Wed, 05 Feb 2025 13:13:13 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf18a602sm74261241cf.79.2025.02.05.13.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 13:13:12 -0800 (PST)
Date: Wed, 5 Feb 2025 16:13:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6PUZmA9Tv3yOA8F@x1.local>
References: <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
 <Z6Iy0wY-lsx3M71M@x1.local> <Z6I0mzWEsl5y57Zj@redhat.com>
 <87zfj0mcmy.fsf@suse.de> <87wme4m8ci.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wme4m8ci.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 05, 2025 at 05:42:37PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> >
> >> On Tue, Feb 04, 2025 at 10:31:31AM -0500, Peter Xu wrote:
> >>> On Tue, Feb 04, 2025 at 03:39:00PM +0100, Maciej S. Szmigiero wrote:
> >>> > On 3.02.2025 23:56, Peter Xu wrote:
> >>> > > On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
> >>> > > > On 3.02.2025 21:20, Peter Xu wrote:
> >>> > > > > On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
> >>> > > > > > On 3.02.2025 19:20, Peter Xu wrote:
> >>> > > > > > > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> >>> > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> >>> > > > > > > > 
> >>> > > > > > > > Multifd send channels are terminated by calling
> >>> > > > > > > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> >>> > > > > > > > multifd_send_terminate_threads(), which in the TLS case essentially
> >>> > > > > > > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
> >>> > > > > > > > 
> >>> > > > > > > > Unfortunately, this does not terminate the TLS session properly and
> >>> > > > > > > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> >>> > > > > > > > 
> >>> > > > > > > > The only reason why this wasn't causing migration failures is because
> >>> > > > > > > > the current migration code apparently does not check for migration
> >>> > > > > > > > error being set after the end of the multifd receive process.
> >>> > > > > > > > 
> >>> > > > > > > > However, this will change soon so the multifd receive code has to be
> >>> > > > > > > > prepared to not return an error on such premature TLS session EOF.
> >>> > > > > > > > Use the newly introduced QIOChannelTLS method for that.
> >>> > > > > > > > 
> >>> > > > > > > > It's worth noting that even if the sender were to be changed to terminate
> >>> > > > > > > > the TLS connection properly the receive side still needs to remain
> >>> > > > > > > > compatible with older QEMU bit stream which does not do this.
> >>> > > > > > > 
> >>> > > > > > > If this is an existing bug, we could add a Fixes.
> >>> > > > > > 
> >>> > > > > > It is an existing issue but only uncovered by this patch set.
> >>> > > > > > 
> >>> > > > > > As far as I can see it was always there, so it would need some
> >>> > > > > > thought where to point that Fixes tag.
> >>> > > > > 
> >>> > > > > If there's no way to trigger a real functional bug anyway, it's also ok we
> >>> > > > > omit the Fixes.
> >>> > > > > 
> >>> > > > > > > Two pure questions..
> >>> > > > > > > 
> >>> > > > > > >      - What is the correct way to terminate the TLS session without this flag?
> >>> > > > > > 
> >>> > > > > > I guess one would need to call gnutls_bye() like in this GnuTLS example:
> >>> > > > > > https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
> >>> > > > > > 
> >>> > > > > > >      - Why this is only needed by multifd sessions?
> >>> > > > > > 
> >>> > > > > > What uncovered the issue was switching the load threads to using
> >>> > > > > > migrate_set_error() instead of their own result variable
> >>> > > > > > (load_threads_ret) which you had requested during the previous
> >>> > > > > > patch set version review:
> >>> > > > > > https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
> >>> > > > > > 
> >>> > > > > > Turns out that the multifd receive code always returned
> >>> > > > > > error in the TLS case, just nothing was previously checking for
> >>> > > > > > that error presence.
> >>> > > > > 
> >>> > > > > What I was curious is whether this issue also exists for the main migration
> >>> > > > > channel when with tls, especially when e.g. multifd not enabled at all.  As
> >>> > > > > I don't see anywhere that qemu uses gnutls_bye() for any tls session.
> >>> > > > > 
> >>> > > > > I think it's a good to find that we overlooked this before.. and IMHO it's
> >>> > > > > always good we could fix this.
> >>> > > > > 
> >>> > > > > Does it mean we need proper gnutls_bye() somewhere?
> >>> > > > > 
> >>> > > > > If we need an explicit gnutls_bye(), then I wonder if that should be done
> >>> > > > > on the main channel as well.
> >>> > > > 
> >>> > > > That's a good question and looking at the code qemu_loadvm_state_main() exits
> >>> > > > on receiving "QEMU_VM_EOF" section (that's different from receiving socket EOF)
> >>> > > > and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explicit size
> >>> > > > in qemu_loadvm_state() - so still not until channel EOF.
> >>> > > 
> >>> > > I had a closer look, I do feel like such pre-mature termination is caused
> >>> > > by explicit shutdown()s of the iochannels, looks like that can cause issue
> >>> > > even after everything is sent.  Then I noticed indeed multifd sender
> >>> > > iochannels will get explicit shutdown()s since commit 077fbb5942, while we
> >>> > > don't do that for the main channel.  Maybe that is a major difference.
> >>> > > 
> >>> > > Now I wonder whether we should shutdown() the channel at all if migration
> >>> > > succeeded, because looks like it can cause tls session to interrupt even if
> >>> > > the shutdown() is done after sent everything, and if so it'll explain why
> >>> > > you hit the issue with tls.
> >>> > > 
> >>> > > > 
> >>> > > > Then I can't see anything else reading the channel until it is closed in
> >>> > > > migration_incoming_state_destroy().
> >>> > > > 
> >>> > > > So most likely the main migration channel will never read far enough to
> >>> > > > reach that GNUTLS_E_PREMATURE_TERMINATION error.
> >>> > > > 
> >>> > > > > If we don't need gnutls_bye(), then should we always ignore pre-mature
> >>> > > > > termination of tls no matter if it's multifd or non-multifd channel (or
> >>> > > > > even a tls session that is not migration-related)?
> >>> > > > 
> >>> > > > So basically have this patch extended to calling
> >>> > > > qio_channel_tls_set_premature_eof_okay() also on the main migration channel?
> >>> > > 
> >>> > > If above theory can stand, then eof-okay could be a workaround papering
> >>> > > over the real problem that we shouldn't always shutdown()..
> >>> > > 
> >>> > > Could you have a look at below patch and see whether it can fix the problem
> >>> > > you hit too, in replace of these two patches (including the previous
> >>> > > iochannel change)?
> >>> > > 
> >>> > 
> >>> > Unfortunately, the patch below does not fix the problem:
> >>> > > qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> >>> > > qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> >>> > 
> >>> > I think that, even in the absence of shutdown(), if the sender does not
> >>> > call gnutls_bye() the TLS session is considered improperly terminated.
> >>> 
> >>> Ah..
> >>> 
> >>> How about one more change on top of above change to disconnect properly for
> >>> TLS?  Something like gnutls_bye() in qio_channel_tls_close(), would that
> >>> make sense to you?
> >>
> >> Calling gnutls_bye from qio_channel_tls_close is not viable for the
> >> API contract of qio_channel_close. gnutls_bye needs to be able to
> >> perform I/O, which means we need to be able to tell the caller
> >> whether it needs to perform an event loop wait for POLLIN or POLLOUT.
> >>
> >> This is the same API design scenario as the gnutls_handshake method.
> >> As such I tdon't think it is practical to abstract it inside any
> >> existing QIOChannel API call, it'll have to be standalone like
> >> qio_channel_tls_handshake() is.
> >>
> >
> > I implemented the call to gnutls_bye:
> > https://gitlab.com/farosas/qemu/-/commits/migration-tls-bye
> >
> > Then while testing it I realised we actually have a regression from 9.2:
> >
> > 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")
> >
> > It seems that patch somehow affected the ordering between src shutdown
> > vs. recv shutdown and now the recv channels are staying around to see
> > the connection being broken. Or something... I'm still looking into it.
> >
> 
> Ok, so the issue is that the recv side would previously be stuck at the
> sync semaphore and multifd_recv_terminate_threads() would kick it only
> after 'exiting' was set, so no further recv() would happen.
> 
> After the patch, there's no final sync anymore, so the recv thread loops
> around and waits at the recv() until multifd_send_terminate_threads()
> closes the connection.
> 
> Waiting on sem_sync as before would lead to a cleaner termination
> process IMO, but I don't think it's worth the extra complexity of
> introducing a sync to the device state migration.
> 
> So I think we'll have to go with one of the approaches suggested on this
> thread (gnutls_bye or premature_ok). I'm fine either way, but let's make
> sure we add a reference to the patch above and some words explaining the
> situation.
> 
> (let me know if anyone prefers the gnutls_bye approach I have implemented
> and I can send a proper series)

Good to know the progress.

If that doesn't take a lot of time to provide a formal patch, IMO you
should go for it at least with an RFC; RFC is less likely to be completely
forgotten from thread discussions in all cases.

Migration is not the only one using tls channels, so even if migration can
avoid depending on it, I wonder if gnutls_bye is a must if we want to make
sure QEMU is free from pre-mature termination attacks on other users.

Thanks,

-- 
Peter Xu


