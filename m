Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B839C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 15:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX0xN-00063B-Br; Mon, 05 Feb 2024 10:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX0xL-00062x-T5
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:32:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX0xF-0001nP-Nz
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 10:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707147136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcGvF4CiRqkrvhQo0qax7ZIbEIw8axF8JAjmXkUTnFY=;
 b=AqaerwnjO0BAkHpJVAaZsDyptEfBtGFQVGTNuyT0humd6+Lga7QtA9MXap3YR83uNHHPFV
 hKurv7jm9tNdRsUBXemihHQDD8HbUwX6yywgHeuz/v69R5NyExvXHI6z/CEI7d533E0u4+
 ytOS6KSW/ueg6GqpW4Q9KZPthUfZe2w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-Tb-K5RSfNFSwZ5WbaWrpFQ-1; Mon,
 05 Feb 2024 10:32:11 -0500
X-MC-Unique: Tb-K5RSfNFSwZ5WbaWrpFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 008DF2806406;
 Mon,  5 Feb 2024 15:32:03 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37F9E1C060B2;
 Mon,  5 Feb 2024 15:32:00 +0000 (UTC)
Date: Mon, 5 Feb 2024 15:31:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] meson: Disable CONFIG_NOTIFY1 on FreeBSD
Message-ID: <ZcD_bnSRD2XSLIp5@redhat.com>
References: <20240125194840.1564-1-iii@linux.ibm.com>
 <20240125194840.1564-4-iii@linux.ibm.com>
 <33c9ccef-fa8f-41e4-a7a1-17c3dffb9d9d@linaro.org>
 <Zbp4ekYJLQB-BIFo@redhat.com>
 <CANCZdfotNMgPadLA0o9+POcLeTN-rGoR+XkbqBHtjd+cZMy0Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfotNMgPadLA0o9+POcLeTN-rGoR+XkbqBHtjd+cZMy0Fg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 05, 2024 at 08:23:41AM -0700, Warner Losh wrote:
> On Wed, Jan 31, 2024 at 9:42 AM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Wed, Jan 31, 2024 at 05:24:10PM +0100, Philippe Mathieu-Daudé wrote:
> > > Hi,
> > >
> > > Warner, do you remember what this is about?
> > >
> > > (
> > https://cgit.freebsd.org/ports/commit/emulators/qemu-devel/files/patch-util_meson.build?id=2ab482e2c8f51eae7ffd747685b7f181fe1b3809
> > > isn't very verbose).
> >
> > That's simply going to workaround our incomplete feature
> > check. We look for sys/inotify.h and if present, we
> > assume that is in the C library. That's true on Linux,
> > but not true on *BSD, hence the undefined symbol.
> >
> > We need to augment the header file check with a linker
> > symbol check for the C library.
> >
> > If we wanted to also check for -linotify that'd make
> > it portable to BSD, but not the behaviour difference
> > mentioned below.
> >
> > >
> > > On 25/1/24 20:48, Ilya Leoshkevich wrote:
> > > > make vm-build-freebsd fails with:
> > > >
> > > >      ld: error: undefined symbol: inotify_init1
> > > >      >>> referenced by filemonitor-inotify.c:183
> > (../src/util/filemonitor-inotify.c:183)
> > > >      >>>
> >  util_filemonitor-inotify.c.o:(qemu_file_monitor_new) in archive
> > libqemuutil.a
> > > >
> > > > On FreeBSD inotify functions are defined in libinotify.so, so it might
> > > > be tempting to add it to the dependencies. Doing so, however, reveals
> > > > that this library handles rename events differently from Linux:
> > > >
> > > >      $ FILEMONITOR_DEBUG=1 build/tests/unit/test-util-filemonitor
> > > >      Rename /tmp/test-util-filemonitor-K13LI2/fish/one.txt ->
> > /tmp/test-util-filemonitor-K13LI2/two.txt
> > > >      Event id=200000000 event=2 file=one.txt
> > > >      Queue event id 200000000 event 2 file one.txt
> > > >      Queue event id 100000000 event 2 file two.txt
> > > >      Queue event id 100000002 event 2 file two.txt
> > > >      Queue event id 100000000 event 0 file two.txt
> > > >      Queue event id 100000002 event 0 file two.txt
> > > >      Event id=100000000 event=0 file=two.txt
> > > >      Expected event 0 but got 2
> >
> > Interesting. So In the "Rename" test, the destination already exists.
> >
> > BSD is thus reporting that 'two.txt' is deleted, before being (re)created
> > Linux is only reporting 'two.txt' is created.
> >
> > I don't think we can easily paper over this difference. The easiest is
> > probably to conditionalize the test
> >
> >  git diff
> > diff --git a/tests/unit/test-util-filemonitor.c
> > b/tests/unit/test-util-filemonitor.c
> > index a22de27595..c3b2006365 100644
> > --- a/tests/unit/test-util-filemonitor.c
> > +++ b/tests/unit/test-util-filemonitor.c
> > @@ -281,6 +281,14 @@ test_file_monitor_events(void)
> >          { .type = QFILE_MONITOR_TEST_OP_EVENT,
> >            .filesrc = "one.txt", .watchid = &watch1,
> >            .eventid = QFILE_MONITOR_EVENT_DELETED },
> > +#ifdef __FreeBSD__
> > +        { .type = QFILE_MONITOR_TEST_OP_EVENT,
> > +          .filesrc = "two.txt", .watchid = &watch0,
> > +          .eventid = QFILE_MONITOR_EVENT_DELETED },
> > +        { .type = QFILE_MONITOR_TEST_OP_EVENT,
> > +          .filesrc = "two.txt", .watchid = &watch2,
> > +          .eventid = QFILE_MONITOR_EVENT_DELETED },
> > +#endif
> >          { .type = QFILE_MONITOR_TEST_OP_EVENT,
> >            .filesrc = "two.txt", .watchid = &watch0,
> >            .eventid = QFILE_MONITOR_EVENT_CREATED },
> >
> 
> I agree this is likely the best course of action. Has anybody filed a bug
> at https://bugs.freebsd.org?

I've not, and I'm not even sure I would class it a FreeBSD bug. Other
than the fact that it differs from Linux behaviour, it feels like it
is reasonble semantics to emit a 'delete' event in this scenario so
that an event consumer can detect replacement of an existing file.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


