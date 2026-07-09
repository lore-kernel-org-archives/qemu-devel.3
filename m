Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7A8C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpKs-0005Iz-6C; Thu, 09 Jul 2026 10:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whpKm-0005Hm-9z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whpKh-00028r-Ul
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 10:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783605750;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8WPIi0SgceB10SmalaBhT4PIQYdKlWIgidy8jS1ieY=;
 b=b5TKw9t95Elh1lbX9omGRSDuetWXjD1+5Sw1hP7dEm2sZj3/BaXsDw1n5TmugNKVPVztDh
 3eAx01r1euyO9EoBPKL8t3UCJcIXjhk+eqHaDFKDZ8OEr6aiwzYukyBAqAfgAse99RMyGP
 vNYu5xub4amgPac9QQUKB5I/cedwcz0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-DOWb8VSFM9uCxO1_k6oj6w-1; Thu,
 09 Jul 2026 10:02:26 -0400
X-MC-Unique: DOWb8VSFM9uCxO1_k6oj6w-1
X-Mimecast-MFC-AGG-ID: DOWb8VSFM9uCxO1_k6oj6w_1783605744
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0517718009D0; Thu,  9 Jul 2026 14:02:24 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.59])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E23136933; Thu,  9 Jul 2026 14:02:18 +0000 (UTC)
Date: Thu, 9 Jul 2026 15:02:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: A few Machines crash when "no default audio driver available"
Message-ID: <ak-p56pwFPq9omMz@redhat.com>
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 <87zf00cn7m.fsf@pond.sub.org> <ak-i1dNY_RrGNHAM@redhat.com>
 <CAFEAcA_=rz22ZqPr77REQa5BJRZVuEkriq-gJ9xGg4E46JPUxQ@mail.gmail.com>
 <CAJ+F1C+BiqriKhDO-vY15z5iQECVarJN-NoemiaW3w93c3EpNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+BiqriKhDO-vY15z5iQECVarJN-NoemiaW3w93c3EpNg@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 09, 2026 at 05:54:30PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jul 9, 2026 at 5:44 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 9 Jul 2026 at 14:32, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >
> > > On Thu, Jul 09, 2026 at 03:22:05PM +0200, Markus Armbruster wrote:
> > > > Cc: mainainters for "Overall Audio backends"
> > > > Peter Maydell <peter.maydell@linaro.org> writes:
> > > >
> > > > > On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> wrote:
> > > > >>
> > > > >> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos2,
> > > > >> and MIPS machine fuloong2e crashes.
> > > > >>
> > > > >> I run them like this:
> > > > >>
> > > > >> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -monitor stdio
> > > > >
> > > > >> Died when device_set_realized() tried to propagate a "no default audio
> > > > >> driver available" error to &error_abort.
> > > > >
> > > > > Is this something we want to have be a possibility the devices
> > > > > have to cope with? Can we have the "ignores all audio data"
> > > > > backend be always available instead?
> > > >
> > > > There's plenty of precedence for /dev/null-like backends.
> > > >
> > > > > Otherwise every audio device needs to cope with "there is no
> > > > > audio backend available" and implement "do nothing with the
> > > > > audio data" itself.
> > > >
> > > > Yes.
> > >
> > > We've got a bit of tension between "no defaults" and "builtin audio
> > > devices" here.
> > >
> > > Cnosider if I had instead done
> > >
> > >   qemu-system-x86_64 -M pc -device ac97 -nodefaults
> > >
> > > It is not unreasonable to expect to see an error because you asked
> > > explicitly for 'ac97'  and forgot to wire up the required audio
> > > backend, and asked to NOT have any defaults.
> > >
> > > But with your 'musicpal' machine example, you never asked for the
> > > frontend device, so you should be forgiven for also not asking
> > > for a audio backend.
> >
> > Ah, so this is because of -nodefaults, not because QEMU was
> > somehow built with no audio backends in it.
> >
> > > If we guarantee a /dev/null audio backend always exists, we help
> > > the second case but degrade the first case
> >
> > As a possible analogy, for network devices we just warn in
> > the analogous "device created but no backend wired up":
> >
> >  ./build/x86/qemu-system-x86_64 -nodefaults -device e1000 -display none
> > qemu-system-x86_64: warning: nic e1000.0 has no peer
> >
> > and the effective behaviour is that output packets are dropped.
> >
> > We could make audio devices do that (which would be basically
> > equivalent to "if we need an audio backend and we don't have
> > one, warn and create the null backend").
> >
> 
> Note that we don't have a real "null" backend. The "none" backend does
> mixing/resampling/volume before dropping the audio (its parent is
> MIXENG_BACKEND). I think it would be worth to add (so one day we can
> compile qemu without the whole audio/ engine)

Rather than adding "null" backend, IMHO, we should make "none" do
what its name suggests, by removing the MIGENG_BACKEND from it.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


