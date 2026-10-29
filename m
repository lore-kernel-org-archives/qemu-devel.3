Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15109606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OLmCgbF0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUsA-000411-Qf; Thu, 29 Oct 2026 14:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMUs8-000404-GZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:29:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMUs5-00004s-Gv
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793298544;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ma+spjrdCac2D9DiipuyuGatBn5G1f8ukYXiQJKClIc=;
 b=OLmCgbF0BgM+L2c6AcP716a+Tfxj5KmBXePWoY1ff00XB+8T2tp+FiyS+iwLEH4/RoUxEV
 gAH6vYYdxrCDJs1yeKE1nhVcJ0edv2d6hWQm6oH9BxZ7JPZ0UtTOIUoZc/PIv/1AuqeYSH
 Esh5I+BYFdNzsQsOi63KUjbegM5Jlmg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-SV-IHwJrPH6EDwgYFI_01g-1; Thu,
 29 Oct 2026 14:28:59 -0400
X-MC-Unique: SV-IHwJrPH6EDwgYFI_01g-1
X-Mimecast-MFC-AGG-ID: SV-IHwJrPH6EDwgYFI_01g_1793298538
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4A691945CAF; Thu, 29 Oct 2026 18:28:37 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1348F472; Thu, 29 Oct 2026 18:28:34 +0000 (UTC)
Date: Thu, 29 Oct 2026 18:28:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
Message-ID: <auOQT9WYbNU1Y7X9@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
 <179206655287.744241.865023521920859070.b4-review@b4>
 <atDHwThz_5XPY9Yx@redhat.com>
 <CAMxuvayG8mPvVSagb6EyEH-hhA094qw3LPUWdeL_PJ5qeEk3=g@mail.gmail.com>
 <auODPFwxQ0Bc0oi-@redhat.com>
 <CAJ+F1CJJEX8TDQLS9okRNYQ2RU64YBnWOAqTG3K9PGnCjS8_Yg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJJEX8TDQLS9okRNYQ2RU64YBnWOAqTG3K9PGnCjS8_Yg@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 10:15:46PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Oct 29, 2026 at 9:33 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Oct 16, 2026 at 11:20:11AM +0400, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Thu, Oct 15, 2026 at 4:32 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 15, 2026 at 04:15:52PM +0400, marcandre.lureau@redhat.com wrote:
> > > > > > This series introduces a new facility called 'tldr' which is a
> > > > > > live data recorder. This is intended to aid support of production
> > > > > > QEMU deployments, by providing a data collection facility that
> > > > > > can be left "always on", such that in the event of a QEMU crash
> > > > > > or guest OS crash, certain important information will be recorded.
> > > > > >
> > > > > > The data recorder has to be enabled by adding a "tldr-config"
> > > > > > object instance with -object / object_add.
> > > > > >
> > > > > > With this series, the data recorder collects
> > > > > >
> > > > > >  * error_report/warn_report/error_printf messages
> > > > > >  * QMP events
> > > > >
> > > > > It should probably be recorded at emission, not per monitor
> > > >
> > > > Opps.
> > > >
> > > > > >  * QMP errors
> > > > > >  * QMP commands, which are not query-XXX/qom-list,
> > > > > >    or any command associated with a QMP error.
> > > > > >  * qemu_log output
> > > > > >
> > > > > > The last item is intended primarily to be used in combination
> > > > > > with tracing and its 'log' backend, to have continuous
> > > > > > recording of certain interesting probes.
> > > > > >
> > > > > > Each type of data is collected in a distinct circular
> > > > > > buffer, such that high volumes of one type of data, does
> > > > > > not result in overwriting other types of low volume data.
> > > > > >
> > > > > > The data recorder is set to trigger on SIGBUS, SIGSEGV,
> > > > > > SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> > > > >
> > > > > Instead of allocating and dumping by a signal handler, why not use a file-backed
> > > > > mmap or a memfd? We would need to define a small fixed header for the file
> > > > > layout/buckets.  This would avoid all the issues with signal handlers.
> > > >
> > > > That would impose a continuous I/O workload on data recording, which
> > > > is something I wanted to explicitly avoid, until the time the data is
> > >
> > > Yes, a file-backed mapping shouldn't be the default, but memfd/tmpfs
> > > should have the same performance.
> > >
> > > > needed to be preserved. This only persists the final data, not any
> > > > intermediate data that is overwritten as the circular buffer wraps.
> > >
> > > Same design, the reader would handle the ring data
> > >
> > > > Coupling the in-memory layout to the on-disk layout also means that
> > > > dumps would always be the max size, since we would not have grow-on
> > > > demand buffers.
> > >
> > > The dump output would not be the raw data, a reader would emit the
> > > same text format, skipping the unused parts.
> >
> > IMHO that reader has to be QEMU owned code, as otherwise we're
> > exposing a private data structure to a 3rd party and that makes
> > it public ABI/API which is highly undesirable for this.
> 
> The resulting data will be ABI/API anyway, no?

I was considering it human targetted data, not machine
targetted data, so not API and subject to change.

> 
> >
> > > mapping reserves address space only, pages are allocated on first write.
> > >
> > > The benefits:
> > > - no signal handler, no conflict with MCE, ASAN etc
> >
> > A signal handler is integral to some extent, as captured info about
> > the signal is itself is an important part of the data record. IOW,
> > even if moving writing of the dump out of the signal handler in some
> > manner, I still want to be able to capture several siginfo_t fields.
> >
> > You can get that info from a core dump, but the working premise
> > is that a core dump is not guaranteed available, whereas the data
> > record dumps are something we can more easily acquire.
> 
> right.. this is something you don't touch in the cover letter. I
> assume most systems have a core dump handler already (perhaps
> differently on Windows), thus we could also rely on the dumped data
> instead of a signal handler. We should be explicit about why we don't
> follow that path
> 
> systemd/coredumpctl does store siginfo_t of the process too

We often can't get at those core dump records when inside a container.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


