Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7420C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 13:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whorZ-0005dq-Eg; Thu, 09 Jul 2026 09:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whorX-0005cq-4b
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:32:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whorV-0002Eu-81
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 09:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783603940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z2B0ey6QePN99dWe18NcPGr1fUj02GH2UjAxw3HoYuY=;
 b=eiMHTkZtB0VemfYOk5M8n8ustOaUFQaufVKp52huTY2WJJ24oCTmFWxbIMcA8D/1Fw4wsT
 mC2XWpDZFjsiAWQBWNXpBAP+jlxz+Kc0GCl4Nuqi5bjaveJK1VdW+0+Pk9XuzR9FpjLNHj
 +Hh8xbyN6J/IWlKKa71w7FGyCbsw+Io=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-9Q-OJY0IMsWOQVuGelrUag-1; Thu,
 09 Jul 2026 09:32:16 -0400
X-MC-Unique: 9Q-OJY0IMsWOQVuGelrUag-1
X-Mimecast-MFC-AGG-ID: 9Q-OJY0IMsWOQVuGelrUag_1783603934
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1897818052E0; Thu,  9 Jul 2026 13:32:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.59])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 220A83000C01; Thu,  9 Jul 2026 13:32:08 +0000 (UTC)
Date: Thu, 9 Jul 2026 14:32:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-arm@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: A few Machines crash when "no default audio driver available"
Message-ID: <ak-i1dNY_RrGNHAM@redhat.com>
References: <87o6gge6b0.fsf@pond.sub.org>
 <CAFEAcA9goRQuxw3VD7AqUOHHTdOXu8MSfCxdQMBviE3QgGD58w@mail.gmail.com>
 <87zf00cn7m.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zf00cn7m.fsf@pond.sub.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 09, 2026 at 03:22:05PM +0200, Markus Armbruster wrote:
> Cc: mainainters for "Overall Audio backends"
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > On Thu, 9 Jul 2026 at 12:44, Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> I stumbled over ARM machine musicpal, PPC machines pegasos1, pegasos2,
> >> and MIPS machine fuloong2e crashes.
> >>
> >> I run them like this:
> >>
> >> $ qemu-system-aarch64 -M musicpal -nodefaults -S -display none -monitor stdio
> >
> >> Died when device_set_realized() tried to propagate a "no default audio
> >> driver available" error to &error_abort.
> >
> > Is this something we want to have be a possibility the devices
> > have to cope with? Can we have the "ignores all audio data"
> > backend be always available instead?
> 
> There's plenty of precedence for /dev/null-like backends.
> 
> > Otherwise every audio device needs to cope with "there is no
> > audio backend available" and implement "do nothing with the
> > audio data" itself.
> 
> Yes.

We've got a bit of tension between "no defaults" and "builtin audio
devices" here.

Cnosider if I had instead done

  qemu-system-x86_64 -M pc -device ac97 -nodefaults

It is not unreasonable to expect to see an error because you asked
explicitly for 'ac97'  and forgot to wire up the required audio
backend, and asked to NOT have any defaults.

But with your 'musicpal' machine example, you never asked for the
frontend device, so you should be forgiven for also not asking
for a audio backend.

If we guarantee a /dev/null audio backend always exists, we help
the second case but degrade the first case

So we must pick the lesser evil :-(

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


