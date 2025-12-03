Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B960D116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 08:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQhsi-0004jo-CN; Wed, 03 Dec 2025 03:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1vQhse-0004Rf-64
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:06:32 -0500
Received: from vm3.arverb.com ([116.202.17.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@caoua.org>) id 1vQhsb-0001ab-J9
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 03:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=grK5DIPoLFqs
 +36O3braI7O93dr6WX2yNMzDDzsdunk=;
 h=in-reply-to:references:subject:cc:
 to:from:date; d=caoua.org; b=eaNksr7glGq75xTjVOs+gQJfhJXwY/MbQWeWTekJT
 h7LUsZHMJ8PzVjRxQ5CiZ/noB3WL8WZXfCLu+zi23PYlYIhI/BIFM001L2IXnATizm/hny
 BVi/vX3wrN1L9PfD2NY0Mufa4F2Vw/lqM0xN3My/UzEMo0rWIIzMzHqt6mm4=
Received: from localhost (vm3.arverb.com [local])
 by vm3.arverb.com (OpenSMTPD) with ESMTPA id 220155d7;
 Wed, 3 Dec 2025 09:06:25 +0100 (CET)
Date: Wed, 3 Dec 2025 09:06:25 +0100
From: Alexandre Ratchov <alex@caoua.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Geoffrey McRae <geoff@hostfission.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [RFC 00/24] audio: add GStreamer backend
Message-ID: <aS_vgYyOzZAQ2y1A@vm3.arverb.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
 <e6ada475-da8a-4643-4986-2ffc1d5b9c66@eik.bme.hu>
 <CAMxuvayr-qyjzsexWL1wt72mJA_-Dew9JAofjELhSVYC_w8SvA@mail.gmail.com>
 <aS4BZZnzQPUHzbaD@vm3.arverb.com>
 <3bb3606b-713c-456b-ab0f-31d14c6a6b99@redhat.com>
 <20e6b7a1-cc84-29ff-6570-94fed9520466@eik.bme.hu>
 <d63b9773727b546cea38b1f17e0babd0@hostfission.com>
 <CAMxuvayp1WiqWe40Ox69DQ+R0X3VrJ_ai001Z04KbEouFGwCjg@mail.gmail.com>
 <12d3c2d298399c0935edee8caa3e52aa@hostfission.com>
 <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+9eD_Qp7hGMjVHEbttbOxGpCZ4T8tVS+woAk7odWukHA@mail.gmail.com>
Received-SPF: pass client-ip=116.202.17.78; envelope-from=alex@caoua.org;
 helo=vm3.arverb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 02, 2025 at 06:14:48PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Dec 2, 2025 at 5:26 PM Geoffrey McRae <geoff@hostfission.com> wrote:
> >
> >
> >
> > On 2025-12-02 23:44, Marc-André Lureau wrote:
> > > Hi Geoffrey
> > >
> > > On Tue, Dec 2, 2025 at 4:31 PM Geoffrey McRae
> > > <geoff@hostfission.com> wrote:
> > >
> > >> The PipeWire and PulseAudio backends are used by a large number of
> > >> users
> > >> in the VFIO community. Removing these would be an enormous determent
> > >> to
> > >> QEMU.
> > >
> > > They come with GStreamer pulse/pipe elements.
> >
> > Yes, but through another layer of abstraction/complexity with no real
> > benefit.
> 
> The benefit is that QEMU would not have to maintain 10 backends and
> all the audio mixing/resampling.

Well, for open-source projects it depends on the maintainers: if they
all shift their interrest/efforts toward a single GStreamer backend it
will be a win (many devs maintaining a single backend). If they don't,
we'd end-up with one backend maintained by one person.

> The QEMU code would be simpler and
> more maintainable overall. GStreamer has a clear pipeline design,
> better suited (optimized code etc) and you can easily modify the
> pipeline settings.
> 

I don't know if it would be more maintainable.  The idea is appealing,
but to my experience, fixing audio glitches, timing issues, unexpected
latency, subtle differences between OSes and alike have been painful
compared to fixing similar code that uses the native APIs.

My 2 cents.

