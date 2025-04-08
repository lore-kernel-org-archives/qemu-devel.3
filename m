Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC24C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 12:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u28UJ-0005Gt-TU; Tue, 08 Apr 2025 08:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u28UI-0005GD-91
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:55:34 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1u28UG-00055s-Fx
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 08:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=0eGpBF3Bf0KwDoZoM7qHkQQq+pKz/0BVl/Emq1n+jsI=; b=hJZ2TS4z1DtAHK3tyI1G3tbvtT
 IWJGjn6IREXqDuhpzh4DbtgenoM4DeEmZ5VErsD8Tv7GLje1rabRFf2vy9PNTUZ86InL8qKrWrnan
 LFzmOfH35cgCu7v2xhI1Rr6lTNDTGDaWQzH+D+yZCvajFnjYm5ADHVWs5yN7vvcI/EFfuPwSQ+fMr
 GoXaNowp+9p8a0jTzgQfzZduyMw7U+Jjd2gxgLyJTfVpfs+3AXBi7RzpPQ/QV/TXHhuZf+xCDSK34
 L/M09OBwO9qNdrdz98NTJ79tuszxc+ZRl2eBWVPUer75xKcgL169qpxTymNh3+AUZLDPFcYBHCBAY
 8vj8bekZc2y76m4tXzka9Oli9rjagEKSX7CzlEQRzdS8xZM2lAg/1yuKHcccNZNj2Ln/K6iEy6IBG
 dVNPL6LCEGRnPp+eoV+NWAiuuXQzRXxXRBulxTjuw81YHeBxGg0o8Hkjt8052jfJqQ6qK/9kS+ez0
 l/+jY93S5STx61j0mkoceGpBZ/1A4ZxAJzadXPoNq57OT3/3v4ea4DvZQMNxMbhBDj2tsrp+N5K/b
 3n6GtPFEDQbjal5h035BlPLOehU89X9oLtIE7tLg+1zLZiEXOBUTj1pawIcyz1ZJGYVLCuPYFYBBp
 gwJ+1TeCuY3fRRFpvJYKxME9bdKxvzI58qrJnD58U=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Volker Ruemelin <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
Date: Tue, 08 Apr 2025 14:55:27 +0200
Message-ID: <2024817.RjeAs2xCtm@silver>
In-Reply-To: <abecc55b-f032-03e3-a9f3-628b1f8f7e5d@eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
 <37909074.vkC8U9mzk0@silver>
 <abecc55b-f032-03e3-a9f3-628b1f8f7e5d@eik.bme.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, April 4, 2025 1:34:27 PM CEST BALATON Zoltan wrote:
> On Fri, 4 Apr 2025, Christian Schoenebeck wrote:
> > On Monday, March 31, 2025 3:05:24 PM CEST BALATON Zoltan wrote:
> >> On Sun, 23 Mar 2025, Christian Schoenebeck wrote:
> >>> On Sunday, March 16, 2025 1:20:46 AM CET BALATON Zoltan wrote:
> >>>> Quoting Volker R=FCmelin: "try-poll=3Don tells the ALSA backend to t=
ry to
> >>>> use an event loop instead of the audio timer. This works most of the
> >>>> time. But the poll event handler in the ALSA backend has a bug. For
> >>>> example, if the guest can't provide enough audio frames in time, the
> >>>> ALSA buffer is only partly full and the event handler will be called
> >>>> again and again on every iteration of the main loop. This increases
> >>>> the processor load and the guest has less processor time to provide
> >>>> new audio frames in time. I have two examples where a guest can't
> >>>> recover from this situation and the guest seems to hang."
> >>>>
> >>>> One reproducer I've found is booting MorphOS demo iso on
> >>>> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
> >>>> startup sound but instead it freezes. Even when it does not hang it
> >>>> plays choppy sound. Volker suggested using command line to set
> >>>> try-poll=3Doff saying: "The try-poll=3Doff arguments are typically
> >>>> necessary, because the alsa backend has a design issue with
> >>>> try-poll=3Don. If the guest can't provide enough audio frames, it's
> >>>> really unhelpful to ask for new audio frames on every main loop
> >>>> iteration until the guest can provide enough audio frames. Timer bas=
ed
> >>>> playback doesn't have that problem."
> >>>>
> >>>> But users cannot easily find this option and having a non-working
> >>>> default is really unhelpful so to make life easier just set it to
> >>>> false by default which works until the issue with the alsa backend c=
an
> >>>> be fixed.
> >>>>
> >>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>> ---
> >>>> This fixes my issue but if somebody has a better fix I'm open to that
> >>>> too.
> >>>>
> >>>>  audio/alsaaudio.c | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> >>>> index cacae1ea59..9b6c01c0ef 100644
> >>>> --- a/audio/alsaaudio.c
> >>>> +++ b/audio/alsaaudio.c
> >>>> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool e=
nable)
> >>>>  static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions=
 *apdo)
> >>>>  {
> >>>>      if (!apdo->has_try_poll) {
> >>>> -        apdo->try_poll =3D true;
> >>>> +        apdo->try_poll =3D false;
> >>>>          apdo->has_try_poll =3D true;
> >>>>      }
> >>>>  }
> >>>>
> >>>
> >>> Correct me if I am wrong, but AFAICS if polling is not used then no s=
tate
> >>> changes would be handled, no? At least I don't see any snd_pcm_state(=
) call
> >>> outside of alsa_poll_handler().
> >>
> >> I have no idea but this fixes the problem (and does the same that can =
be
> >> also done from command line but nobody can find that command line opti=
on)
> >> so unless somebody has a better idea could this be merged as a fix for
> >> now?
> >
> > Well, I understand that if fixes the misbehaviour you encountered. But =
how
> > helpful would it be if it then breaks behaviour for other people instea=
d?
>=20
> What behaviour would it break and how?

There are only a bunch of ALSA states handled right now in the QEMU Alsa
driver (see alsa_poll_handler()):

    state =3D snd_pcm_state (hlp->handle);
    switch (state) {
    case SND_PCM_STATE_SETUP:
        alsa_recover (hlp->handle);
        break;

    case SND_PCM_STATE_XRUN:
        alsa_recover (hlp->handle);
        break;

    case SND_PCM_STATE_SUSPENDED:
        alsa_resume (hlp->handle);
        break;

    case SND_PCM_STATE_PREPARED:
        audio_run(hlp->s, "alsa run (prepared)");
        break;

    case SND_PCM_STATE_RUNNING:
        audio_run(hlp->s, "alsa run (running)");
        break;

=46or instance in poll mode it recovers in case of an xrun, which happens on
audio output if the audio output data was not delivered by the application =
in
time.

The other case is when the system was suspended (standby). It should also
recover the audio session here.

Now I haven't tested whether these would work in callback mode right now, b=
ut
looking at the code suggests that they might not.

> > I think it would be better to add a 2nd patch that would handle state c=
hanges
> > in callback mode. That would satisfy both groups of people. AFAICS
> > snd_pcm_state() can be called both in polling mode and callback mode.
>=20
> I can't do that because I don't quite know neither alsa nor audio in QEMU=
=20
> so I have no idea what to do. Can you give more clues?

Well, as a starting point you might try whether these cases described above
would still work in callback mode. Maybe it is even working, who knows.

/Christian

> > Just my 2 cents. Of course it's up to Gerd to decide.
>=20
> If you know it would break something I agree it should be fixed and I can=
=20
> try but I could not reproduce any breakage and most people likely use=20
> other audio backends so unlikely to encounter problems with alsa.
>=20
> Regards,
> BALATON Zoltan



