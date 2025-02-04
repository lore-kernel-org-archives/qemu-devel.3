Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8480C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKtr-0004mc-7o; Tue, 04 Feb 2025 10:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfKtp-0004mF-CS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:31:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfKtn-0003LC-AO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738683097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJnq3JFjx3K58zhz2FIbvJYV+17rLCHjtI+9kBrrtjw=;
 b=U06MJ2d4vfjz0HeQcVFvDPqTL+C1LK7vk3ZJpzPUDW/GAej0cM40Go3tgk9bt8/9KNCYA9
 7fd0et6R0D5XtfE20/4Qv9/neoYsozgt7W8suVVC0wAZxb1zzuC7DnV5bjVDVkk1D7PnC+
 4wV7KB36dUhL62cLj1MxfWYcD045oWc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-V4lG-Z2-OBOOFIJAZP9ADw-1; Tue, 04 Feb 2025 10:31:34 -0500
X-MC-Unique: V4lG-Z2-OBOOFIJAZP9ADw-1
X-Mimecast-MFC-AGG-ID: V4lG-Z2-OBOOFIJAZP9ADw
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6ecd22efbso973489785a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738683094; x=1739287894;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJnq3JFjx3K58zhz2FIbvJYV+17rLCHjtI+9kBrrtjw=;
 b=gCXOPSHMbgjPHVnHoOicraHeir8n1iLahARgw71RbADsdxRfGkpbxLFuYiUckqREvK
 ITcgzTJyluP84C6izNhsYd0XplcGEFmjPPXTDTOuAPBkFFn1Y21fxcFp/eFlhwd1UtWu
 hhd0ARweboUu56pk9YGuRaoNfpmiM23EwGlrJEpAPDvOOSr7RGI7daL40KV521mjVSLN
 RVZGfYA41h1ytrN+9E/bMomHhZPPKYG3/MiRjmziXyQCEPFhZfR9T+9g+kGxm5Iugsa0
 vrg4c8T9bM99JXkddtBqyUhdd2iZCZbS6vCpXMbSQt6VkiZK2T3ai9cErjKy6li+nvFQ
 18yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWrZLHwN5LZg2/re3BnCo7A04MPXxSBZ3Gt13yKe7oXwGOWX2L5C1qIzfGyMGIo4XTUO2BjwilQZke@nongnu.org
X-Gm-Message-State: AOJu0YyKrcoHxPYEuEBM1HWySpok19yrdmCow0spjD12AYhLZnX9K25u
 ud0/3W7+2O278q7BHjpwspzVFYSNqDcoNrCRdjFhfoDeSWGC91eryNkvPUj6cFbd2AGdMw+sd4d
 3MO2UMd2VQZhKK8VIcE31ftrHowDEItF7Lq09Q0kguvoLffUfI4Zn
X-Gm-Gg: ASbGncu8ZzbO+hbvzgIiHkJYwVK1DSYfmLzyqj4AcIWtL+Sc7hb8e1eWzDMa+7OdKCT
 TkdxarGoVFLfa7qpALo35kzN7O65ic+2+Whdl0oOnbroMGeXJAHjKSjXje5HODJDXcXkySY0pQg
 Oa8iO4Nued6XulSJ1fN8NoqWav2+943FrGAZUbIFw2JXCtUxuNsbH2FjvvfdWtLkH0JGrB5tRb6
 yvaFf59TvFGotV/P7JYrHYqaaWlWdILeywWAg0ite0daUXVnJdgVxd+0HnW79s1H+W2wee8SMPk
 1ajZQw9qYbciIrQO+Yc/V+UbDr+UC/ciOyamWC91InkN6cY+
X-Received: by 2002:a05:620a:2706:b0:7a9:9f44:3f8 with SMTP id
 af79cd13be357-7c02ec14812mr650764685a.5.1738683093656; 
 Tue, 04 Feb 2025 07:31:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcK4ltKhSOH4rnIH0xm7I+Aj7DyctsxJGaIRicYY2PiilMfN0h40Mfhl/5DhnKjBMvw51Yyg==
X-Received: by 2002:a05:620a:2706:b0:7a9:9f44:3f8 with SMTP id
 af79cd13be357-7c02ec14812mr650758885a.5.1738683093270; 
 Tue, 04 Feb 2025 07:31:33 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90ccdcsm642527985a.93.2025.02.04.07.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 07:31:32 -0800 (PST)
Date: Tue, 4 Feb 2025 10:31:31 -0500
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
Message-ID: <Z6Iy0wY-lsx3M71M@x1.local>
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <baf944c37ead5d30d7e268b2a4074d9acaac2db0.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6EI0V6Cg7aCbzQU@x1.local>
 <67a7c2ce-2391-4b8e-a5be-bce370fd2e66@maciej.szmigiero.name>
 <Z6ElIlavWHda8YcH@x1.local>
 <6b9b4c31-6598-4fd9-9ae2-dbef4cdd7089@maciej.szmigiero.name>
 <Z6FJuK2FVKhI0C2j@x1.local>
 <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b84071ab-ea49-4c2f-8f8c-6bb9a3d94342@maciej.szmigiero.name>
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

On Tue, Feb 04, 2025 at 03:39:00PM +0100, Maciej S. Szmigiero wrote:
> On 3.02.2025 23:56, Peter Xu wrote:
> > On Mon, Feb 03, 2025 at 10:41:32PM +0100, Maciej S. Szmigiero wrote:
> > > On 3.02.2025 21:20, Peter Xu wrote:
> > > > On Mon, Feb 03, 2025 at 07:53:00PM +0100, Maciej S. Szmigiero wrote:
> > > > > On 3.02.2025 19:20, Peter Xu wrote:
> > > > > > On Thu, Jan 30, 2025 at 11:08:29AM +0100, Maciej S. Szmigiero wrote:
> > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > 
> > > > > > > Multifd send channels are terminated by calling
> > > > > > > qio_channel_shutdown(QIO_CHANNEL_SHUTDOWN_BOTH) in
> > > > > > > multifd_send_terminate_threads(), which in the TLS case essentially
> > > > > > > calls shutdown(SHUT_RDWR) on the underlying raw socket.
> > > > > > > 
> > > > > > > Unfortunately, this does not terminate the TLS session properly and
> > > > > > > the receive side sees this as a GNUTLS_E_PREMATURE_TERMINATION error.
> > > > > > > 
> > > > > > > The only reason why this wasn't causing migration failures is because
> > > > > > > the current migration code apparently does not check for migration
> > > > > > > error being set after the end of the multifd receive process.
> > > > > > > 
> > > > > > > However, this will change soon so the multifd receive code has to be
> > > > > > > prepared to not return an error on such premature TLS session EOF.
> > > > > > > Use the newly introduced QIOChannelTLS method for that.
> > > > > > > 
> > > > > > > It's worth noting that even if the sender were to be changed to terminate
> > > > > > > the TLS connection properly the receive side still needs to remain
> > > > > > > compatible with older QEMU bit stream which does not do this.
> > > > > > 
> > > > > > If this is an existing bug, we could add a Fixes.
> > > > > 
> > > > > It is an existing issue but only uncovered by this patch set.
> > > > > 
> > > > > As far as I can see it was always there, so it would need some
> > > > > thought where to point that Fixes tag.
> > > > 
> > > > If there's no way to trigger a real functional bug anyway, it's also ok we
> > > > omit the Fixes.
> > > > 
> > > > > > Two pure questions..
> > > > > > 
> > > > > >      - What is the correct way to terminate the TLS session without this flag?
> > > > > 
> > > > > I guess one would need to call gnutls_bye() like in this GnuTLS example:
> > > > > https://gitlab.com/gnutls/gnutls/-/blob/2b8c3e4c71ad380bbbffb32e6003b34ecad596e3/doc/examples/ex-client-anon.c#L102
> > > > > 
> > > > > >      - Why this is only needed by multifd sessions?
> > > > > 
> > > > > What uncovered the issue was switching the load threads to using
> > > > > migrate_set_error() instead of their own result variable
> > > > > (load_threads_ret) which you had requested during the previous
> > > > > patch set version review:
> > > > > https://lore.kernel.org/qemu-devel/Z1DbH5fwBaxtgrvH@x1n/
> > > > > 
> > > > > Turns out that the multifd receive code always returned
> > > > > error in the TLS case, just nothing was previously checking for
> > > > > that error presence.
> > > > 
> > > > What I was curious is whether this issue also exists for the main migration
> > > > channel when with tls, especially when e.g. multifd not enabled at all.  As
> > > > I don't see anywhere that qemu uses gnutls_bye() for any tls session.
> > > > 
> > > > I think it's a good to find that we overlooked this before.. and IMHO it's
> > > > always good we could fix this.
> > > > 
> > > > Does it mean we need proper gnutls_bye() somewhere?
> > > > 
> > > > If we need an explicit gnutls_bye(), then I wonder if that should be done
> > > > on the main channel as well.
> > > 
> > > That's a good question and looking at the code qemu_loadvm_state_main() exits
> > > on receiving "QEMU_VM_EOF" section (that's different from receiving socket EOF)
> > > and then optionally "QEMU_VM_VMDESCRIPTION" section is read with explicit size
> > > in qemu_loadvm_state() - so still not until channel EOF.
> > 
> > I had a closer look, I do feel like such pre-mature termination is caused
> > by explicit shutdown()s of the iochannels, looks like that can cause issue
> > even after everything is sent.  Then I noticed indeed multifd sender
> > iochannels will get explicit shutdown()s since commit 077fbb5942, while we
> > don't do that for the main channel.  Maybe that is a major difference.
> > 
> > Now I wonder whether we should shutdown() the channel at all if migration
> > succeeded, because looks like it can cause tls session to interrupt even if
> > the shutdown() is done after sent everything, and if so it'll explain why
> > you hit the issue with tls.
> > 
> > > 
> > > Then I can't see anything else reading the channel until it is closed in
> > > migration_incoming_state_destroy().
> > > 
> > > So most likely the main migration channel will never read far enough to
> > > reach that GNUTLS_E_PREMATURE_TERMINATION error.
> > > 
> > > > If we don't need gnutls_bye(), then should we always ignore pre-mature
> > > > termination of tls no matter if it's multifd or non-multifd channel (or
> > > > even a tls session that is not migration-related)?
> > > 
> > > So basically have this patch extended to calling
> > > qio_channel_tls_set_premature_eof_okay() also on the main migration channel?
> > 
> > If above theory can stand, then eof-okay could be a workaround papering
> > over the real problem that we shouldn't always shutdown()..
> > 
> > Could you have a look at below patch and see whether it can fix the problem
> > you hit too, in replace of these two patches (including the previous
> > iochannel change)?
> > 
> 
> Unfortunately, the patch below does not fix the problem:
> > qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> > qemu-system-x86_64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> 
> I think that, even in the absence of shutdown(), if the sender does not
> call gnutls_bye() the TLS session is considered improperly terminated.

Ah..

How about one more change on top of above change to disconnect properly for
TLS?  Something like gnutls_bye() in qio_channel_tls_close(), would that
make sense to you?

In general, I think it'll be good we fix this from the source rather than
bypassing an error reported by gnutls facilities. We'll see what we can do
to help (this includes Fabiano), but the hope is we can figure out the
right way soon.

Thanks,

-- 
Peter Xu


