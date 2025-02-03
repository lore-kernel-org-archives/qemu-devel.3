Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA14BC02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 20:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf2wR-0005YL-Fr; Mon, 03 Feb 2025 15:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf2wK-0005UZ-Pr
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:21:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tf2wF-0005wd-CB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738614056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qj55R2ox7iX6vbT7q8zR8R1uJaTB0waXOajDePqxAtY=;
 b=BKMT9MKtrnj+v6H3fR3H8JFa3IkdYGKqT99CEjpum11vAzSspKNKhGNrrQU9Xe/MCM0llB
 mlNbJ2YcCLjnkul+k40kUuK4d3HVfJs5hMDTUcBn0denOo/voknP+ABpgKIMXxWEARU1rr
 NU3sruOZR4rSrXuaZnYf9aW2Byi4pjA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-CjHzhs2eM6WH4rMMsd88Pw-1; Mon, 03 Feb 2025 15:20:54 -0500
X-MC-Unique: CjHzhs2eM6WH4rMMsd88Pw-1
X-Mimecast-MFC-AGG-ID: CjHzhs2eM6WH4rMMsd88Pw
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-46dd301a429so102649681cf.1
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 12:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738614054; x=1739218854;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qj55R2ox7iX6vbT7q8zR8R1uJaTB0waXOajDePqxAtY=;
 b=lHNunxTObjHIl4TgdQXfcbt4WVpD2BMiJ3FxmUDWtiugADyKR1W+AqiCiP407Bkr9y
 jNnJ9NVKJd3Aijm4wHQlA5IwXX2plpZdsD4LByxGaq/nXIfJAJOCZwjJRXLXx6fi6COH
 IoyeF3VQ2GNrBAUcomp5vWsC5Yqj0yMoFO23yOKdPOSUlo9l0cXyql5LPqCTBUZrJMJy
 OS3mCfvXkhp/E/HoYzyx3uVnegCQTehegIRYLkLOA3mPvU49LUq+M1CGBuRK4hcc2BvY
 krlb4+auS+WL3xR/40yIHWtbNvwrA+U1zDXlAX3xnMmr9VAfbhhOESunzVCqMPoCaJXh
 pKBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFbJqDcXVjt+nmkvirmKoYvVOwfNH29eKao9xzJkBHFXoUnEDTMXcV3HCYdcuYO+1yr9P0OFtQXI5b@nongnu.org
X-Gm-Message-State: AOJu0YyB4M7V9ZtBHT1kMbUxXVycHvG3BLJf8heiCA7+81cBZ+N/JpIr
 l4bpTxhsonPstZzZZDjqeJIxkwkcHVGlffoZZYOe78t1sCQ4Xn/Okjo6qoVxycni7OuQ5+1CdsE
 72Y27Or3YeRtiDjYLYR+3lSJis4z67L4rYyapt6mqJAAiyYDWEObD
X-Gm-Gg: ASbGncu0bLVYVjUYuYJDt6ScSRCLyxXAgyH2ut0YU+7BfTKnf3MhYGvxXPSuTGE/6U/
 mpyzdBcIHThqMyNfnjhBj7lSrF3SDfbcSA0Aij6zvtQkWup3mS65GUROC6U7WgNp0UBOygPHlJu
 7qHEEnQy6WRVD+JoSb98/QYu9Di3RvdErP9HPwOgGYpANrcmM28k8gPRx9Vc+RnLqefTOePdei2
 C+DXAzgU5K5g7oSJBjAeJVFDPCwSC26F9S4vpEG6aBMSO7npIWEVlpUU/TgfkQUEQfXImQ7F/Id
 TUxdOXlNSmJu7oAJbMuCx+ueoqrx+7NMu29n8eUQhWNU6LUv
X-Received: by 2002:ac8:5893:0:b0:467:5eaf:7d1f with SMTP id
 d75a77b69052e-46fd0b45623mr379229721cf.50.1738614053829; 
 Mon, 03 Feb 2025 12:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvWnOQkotEe7o9TLEOE9XxRH/BMavclbjka/VU006GBvQm2+e8VWPBFWR3/cRO90Z4NfAi5g==
X-Received: by 2002:ac8:5893:0:b0:467:5eaf:7d1f with SMTP id
 d75a77b69052e-46fd0b45623mr379229311cf.50.1738614053476; 
 Mon, 03 Feb 2025 12:20:53 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fe407195asm49526271cf.0.2025.02.03.12.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:20:52 -0800 (PST)
Date: Mon, 3 Feb 2025 15:20:50 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 08/33] migration/multifd: Allow premature EOF on TLS
 incoming channels
Message-ID: <Z6ElIlavWHda8YcH@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
> On 3.02.2025 19:20, Peter Xu wrote:
> > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > 
> > > Multifd send channels are terminated by calling
> > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> > > multifd_send_terminate_threads(), which in the TLS case essentially
> > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
> > > 
> > > Unfortunately, this does not terminate the TLS session properly and
> > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> > > 
> > > The only reason why this wasn't causing migration failures is because
> > > the current migration code apparently does not check for migration
> > > error being set after the end of the multifd receive process.
> > > 
> > > However, this will change soon so the multifd receive code has to be
> > > prepared to not return an error on such premature TLS session EOF.
> > > Use the newly introduced QIOChannelTLS method for that.
> > > 
> > > It's worth noting that even if the sender were to be changed to terminate
> > > the TLS connection properly the receive side still needs to remain
> > > compatible with older QEMU bit stream which does not do this.
> > 
> > If this is an existing bug, we could add a Fixes.
> 
> It is an existing issue but only uncovered by this patch set.
> 
> As far as I can see it was always there, so it would need some
> thought where to point that Fixes tag.

If there's no way to trigger a real functional bug anyway, it's also ok we
omit the Fixes.

> > Two pure questions..
> > 
> >    - What is the correct way to terminate the TLS session without this flag?
> 
> I guess one would need to call gnutls_bye() like in this GnuTLS example:
> https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
> 
> >    - Why this is only needed by multifd sessions?
> 
> What uncovered the issue was switching the load threads to using
> migrate_set_error() instead of their own result variable
> (load_threads_ret) which you had requested during the previous
> patch set version review:
> https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
> 
> Turns out that the multifd receive code always returned
> error in the TLS case, just nothing was previously checking for
> that error presence.

What I was curious is whether this issue also exists for the main migration
channel when with tls, especially when e.g. multifd not enabled at all.  As
I don't see anywhere that qemu uses gnutls_bye() for any tls session.

I think it's a good to find that we overlooked this before.. and IMHO it's
always good we could fix this.

Does it mean we need proper gnutls_bye() somewhere?

If we need an explicit gnutls_bye(), then I wonder if that should be done
on the main channel as well.

If we don't need gnutls_bye(), then should we always ignore pre-mature
termination of tls no matter if it's multifd or non-multifd channel (or
even a tls session that is not migration-related)?

Thanks,

> 
> Another option would be to simply return to using
> load_threads_ret like the previous versions did and not
> experiment with touching global migration state because
> as we can see other places can unintentionally break.
> 
> If we go this route then these TLS EOF patches could be
> dropped.
> 
> > Thanks,
> > 
> 
> Thanks,
> Maciej
> 

-- 
Peter Xu


