Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C82C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 08:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzBS1-0003HO-7T; Tue, 23 Apr 2024 04:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzBRz-0003Gt-08
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:24:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzBRw-0006Gy-I7
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 04:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713860661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BiWzJ2fPVbJ4Ds1q1Obo5m77pRQgUwWtQfm1xuwNtQI=;
 b=JTgFA5H6gGNvOzdL7hDnPlIo+hHAAAyjAO3gtEK9LTj5fSuCPdbAp85dR9i7KA+fFAxI47
 satmT0SFY+HuszpCX/ZE8iysriVpWC4WW8migy3dWCzhaPGn/DKyFBJgYhuTe6uEMulrK1
 riYq+OW8U5wfCv5xMLL/caad6PQK1pc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-kaynH772Pl2zOYlQLMNudg-1; Tue,
 23 Apr 2024 04:24:20 -0400
X-MC-Unique: kaynH772Pl2zOYlQLMNudg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4EAB29ABA11;
 Tue, 23 Apr 2024 08:24:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A90F344046;
 Tue, 23 Apr 2024 08:24:18 +0000 (UTC)
Date: Tue, 23 Apr 2024 09:24:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 pbonzini@redhat.com, eduardo@habkost.net, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
Message-ID: <ZidwMKx7pE1N2yAN@redhat.com>
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
 <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
 <3ff9df0d-6465-45a3-bb62-0db17ed9210c@ilande.co.uk>
 <d84e246a-fb43-4bb9-ad61-5ebfea4e323f@t-online.de>
 <24c60165-80b6-453b-8fe0-44df563e34be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24c60165-80b6-453b-8fe0-44df563e34be@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Apr 23, 2024 at 10:15:57AM +0200, Philippe Mathieu-Daudé wrote:
> On 22/4/24 21:03, Volker Rümelin wrote:
> > Am 20.04.24 um 07:40 schrieb Mark Cave-Ayland:
> > > On 20/04/2024 02:21, Richard Henderson wrote:
> > > 
> > > > On 4/19/24 12:51, Mark Cave-Ayland wrote:
> > > > > The various Intel CPU manuals claim that SGDT and SIDT can write
> > > > > either 24-bits
> > > > > or 32-bits depending upon the operand size, but this is incorrect.
> > > > > Not only do
> > > > > the Intel CPU manuals give contradictory information between processor
> > > > > revisions, but this information doesn't even match real-life behaviour.
> > > > > 
> > > > > In fact, tests on real hardware show that the CPU always writes
> > > > > 32-bits for SGDT
> > > > > and SIDT, and this behaviour is required for at least OS/2 Warp and
> > > > > WFW 3.11 with
> > > > > Win32s to function correctly. Remove the masking applied due to the
> > > > > operand size
> > > > > for SGDT and SIDT so that the TCG behaviour matches the behaviour on
> > > > > real
> > > > > hardware.
> > > > > 
> > > > > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
> > > > > 
> > > > > -- 
> > > > > MCA: Whilst I don't have a copy of OS/2 Warp handy, I've confirmed
> > > > > that this
> > > > > patch fixes the issue in WFW 3.11 with Win32s. For more technical
> > > > > information I
> > > > > highly recommend the excellent write-up at
> > > > > https://www.os2museum.com/wp/sgdtsidt-fiction-and-reality/.
> > > > > ---
> > > > >    target/i386/tcg/translate.c | 14 ++++++++------
> > > > >    1 file changed, 8 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> > > > > index 76a42c679c..3026eb6774 100644
> > > > > --- a/target/i386/tcg/translate.c
> > > > > +++ b/target/i386/tcg/translate.c
> > > > > @@ -5846,9 +5846,10 @@ static bool disas_insn(DisasContext *s,
> > > > > CPUState *cpu)
> > > > >                gen_op_st_v(s, MO_16, s->T0, s->A0);
> > > > >                gen_add_A0_im(s, 2);
> > > > >                tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State,
> > > > > gdt.base));
> > > > > -            if (dflag == MO_16) {
> > > > > -                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
> > > > > -            }
> > > > > +            /*
> > > > > +             * NB: Despite claims to the contrary in Intel CPU
> > > > > documentation,
> > > > > +             *     all 32-bits are written regardless of operand size.
> > > > > +             */
> > > > 
> > > > Current documentation agrees that all 32 bits are written, so I don't
> > > > think you need this comment:
> > > 
> > > Ah that's good to know the docs are now correct. I added the comment
> > > as there was a lot of conflicting information around for older CPUs so
> > > I thought it was worth an explicit mention.
> > > 
> > > If everyone agrees a version without comments is preferable, I can
> > > re-send an updated version without them included.
> > > 
> > 
> > Hi Mark,
> > 
> > I wouldn't remove the comment.
> > 
> > Quote from the Intel® 64 and IA-32 Architectures Software Developer’s
> > Manual Volume 2B: Instruction Set Reference, M-U March 2024:
> > 
> > IA-32 Architecture Compatibility
> > The 16-bit form of SGDT is compatible with the Intel 286 processor if
> > the upper 8 bits are not referenced. The Intel 286 processor fills these
> > bits with 1s; processor generations later than the Intel 286 processor
> > fill these bits with 0s.
> 
> Is that that OS/2 Warp and WFW 3.11 expect a 286 CPU? QEMU starts
> modelling the 486, do we want to consider down to the 286?

Depends on the versions you're talking about. From what I can gather,
OS/2 1.x targetted i286, OS/2 2.x & 3.x targetted i386, and OS/2 4.0
Warp targetted i486, while WFW 3.11 was i386.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


