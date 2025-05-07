Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F48FC3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 17:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCig9-0005Sf-Ov; Wed, 07 May 2025 13:35:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uCig7-0005SE-3w
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:35:31 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uCig4-0004kU-A8
 for qemu-devel@nongnu.org; Wed, 07 May 2025 13:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=7fjQ1F50vt+iILYVvHUINYVL8D9Fmr7zr2Fp2yiCoWw=; b=X8+5rgstwMAvFzQ9F3/K2sf2Hc
 OFamHlwvAuSj/x0L7079H0ZUr1MIPSIWjwGAEvk1zLhh7/vOvoydET5kxdYMxtxKHglASGyL9qhdO
 MXMZKCcaZb6p0HNXZ68h9biP4TVJyxV2EU983Lko4nZ+xlUeq7nEBed3eObNVUAyZ+InOu9jGlWeg
 BsoJRX91tfB89nh3llH3QiHjR96NyWXKyVaVs/b7ng8zKWWFtZKNEli+TCKIWXG6HXsTf7C/GBTgf
 coJPaV6zmDa0umUFfuL1zrH++6Tvdg31WvbScdh+Rtf0XOWxUUvYsT3Ace4dsWpfGRmsMi1iYIVM+
 8vD6emqFis2uOdnGXfofaN6GDTUmOnnRg/BQshgiY4IRHJNJrAntK6XmLjIJMCrrJewpYvx1TpSId
 m+OEcCStdYMpK4XFOSex+6iSHG5qgDUgdUePsJWZIHkQhv9QuQRry5THoSiN/l5X6c4NWiQqUcisP
 xk2fEnkofs/erPoKsKtc7s8JV25cxjgEzccE5XHfHoyND6oSMJiKlLKegSCKZJHWCHs1/Pr1xL4sM
 Sywo9ENhY/ePvVOpeZ6/+DIZtIyR91KGH0RNd7+WVF1MmtZSAyWC1ZcCY3xdJj5OmDUg50MZAXUTK
 VDGYxF2j4VuDMYTHYId1an4CHuTjRmeaSTN1kY/E4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Volker =?ISO-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
Date: Wed, 07 May 2025 19:35:22 +0200
Message-ID: <2163115.5cHhE5mxgb@silver>
In-Reply-To: <e16231fd-85bb-dde6-7e29-689f04238f19@eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
 <6911d5c1-fe46-4f6e-9165-b16fd23da2c8@t-online.de>
 <e16231fd-85bb-dde6-7e29-689f04238f19@eik.bme.hu>
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

On Tuesday, May 6, 2025 4:34:42 PM CEST BALATON Zoltan wrote:
> On Tue, 8 Apr 2025, Volker R=FCmelin wrote:
> > Am 08.04.25 um 14:55 schrieb Christian Schoenebeck:
> >> On Friday, April 4, 2025 1:34:27 PM CEST BALATON Zoltan wrote:
> >>> On Fri, 4 Apr 2025, Christian Schoenebeck wrote:
> >>>> On Monday, March 31, 2025 3:05:24 PM CEST BALATON Zoltan wrote:
> >>>>> On Sun, 23 Mar 2025, Christian Schoenebeck wrote:
> >>>>>> On Sunday, March 16, 2025 1:20:46 AM CET BALATON Zoltan wrote:
> >>>>>>> Quoting Volker R=FCmelin: "try-poll=3Don tells the ALSA backend t=
o try to
> >>>>>>> use an event loop instead of the audio timer. This works most of =
the
> >>>>>>> time. But the poll event handler in the ALSA backend has a bug. F=
or
> >>>>>>> example, if the guest can't provide enough audio frames in time, =
the
> >>>>>>> ALSA buffer is only partly full and the event handler will be cal=
led
> >>>>>>> again and again on every iteration of the main loop. This increas=
es
> >>>>>>> the processor load and the guest has less processor time to provi=
de
> >>>>>>> new audio frames in time. I have two examples where a guest can't
> >>>>>>> recover from this situation and the guest seems to hang."
> >>>>>>>
> >>>>>>> One reproducer I've found is booting MorphOS demo iso on
> >>>>>>> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
> >>>>>>> startup sound but instead it freezes. Even when it does not hang =
it
> >>>>>>> plays choppy sound. Volker suggested using command line to set
> >>>>>>> try-poll=3Doff saying: "The try-poll=3Doff arguments are typically
> >>>>>>> necessary, because the alsa backend has a design issue with
> >>>>>>> try-poll=3Don. If the guest can't provide enough audio frames, it=
's
> >>>>>>> really unhelpful to ask for new audio frames on every main loop
> >>>>>>> iteration until the guest can provide enough audio frames. Timer =
based
> >>>>>>> playback doesn't have that problem."
> >>>>>>>
> >>>>>>> But users cannot easily find this option and having a non-working
> >>>>>>> default is really unhelpful so to make life easier just set it to
> >>>>>>> false by default which works until the issue with the alsa backen=
d can
> >>>>>>> be fixed.
> >>>>>>>
> >>>>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>>>>> ---
> >>>>>>> This fixes my issue but if somebody has a better fix I'm open to =
that
> >>>>>>> too.
> >>>>>>>
> >>>>>>>  audio/alsaaudio.c | 2 +-
> >>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> >>>>>>> index cacae1ea59..9b6c01c0ef 100644
> >>>>>>> --- a/audio/alsaaudio.c
> >>>>>>> +++ b/audio/alsaaudio.c
> >>>>>>> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, boo=
l enable)
> >>>>>>>  static void alsa_init_per_direction(AudiodevAlsaPerDirectionOpti=
ons *apdo)
> >>>>>>>  {
> >>>>>>>      if (!apdo->has_try_poll) {
> >>>>>>> -        apdo->try_poll =3D true;
> >>>>>>> +        apdo->try_poll =3D false;
> >>>>>>>          apdo->has_try_poll =3D true;
> >>>>>>>      }
> >>>>>>>  }
> >>>>>>>
> >>>>>> Correct me if I am wrong, but AFAICS if polling is not used then n=
o state
> >>>>>> changes would be handled, no? At least I don't see any snd_pcm_sta=
te() call
> >>>>>> outside of alsa_poll_handler().
> >>>>> I have no idea but this fixes the problem (and does the same that c=
an be
> >>>>> also done from command line but nobody can find that command line o=
ption)
> >>>>> so unless somebody has a better idea could this be merged as a fix =
for
> >>>>> now?
> >>>> Well, I understand that if fixes the misbehaviour you encountered. B=
ut how
> >>>> helpful would it be if it then breaks behaviour for other people ins=
tead?
> >>> What behaviour would it break and how?
> >> There are only a bunch of ALSA states handled right now in the QEMU Al=
sa
> >> driver (see alsa_poll_handler()):
> >>
> >>     state =3D snd_pcm_state (hlp->handle);
> >>     switch (state) {
> >>     case SND_PCM_STATE_SETUP:
> >>         alsa_recover (hlp->handle);
> >>         break;
> >>
> >>     case SND_PCM_STATE_XRUN:
> >>         alsa_recover (hlp->handle);
> >>         break;
> >>
> >>     case SND_PCM_STATE_SUSPENDED:
> >>         alsa_resume (hlp->handle);
> >>         break;
> >>
> >>     case SND_PCM_STATE_PREPARED:
> >>         audio_run(hlp->s, "alsa run (prepared)");
> >>         break;
> >>
> >>     case SND_PCM_STATE_RUNNING:
> >>         audio_run(hlp->s, "alsa run (running)");
> >>         break;
> >>
> >> For instance in poll mode it recovers in case of an xrun, which happen=
s on
> >> audio output if the audio output data was not delivered by the applica=
tion in
> >> time.
> >>
> >> The other case is when the system was suspended (standby). It should a=
lso
> >> recover the audio session here.
> >
> > Hi Christian,
> >
> > I think the timer based mode works fine. snd_pcm_readi() and
> > snd_pcm_writei() return -EPIPE in case of a xrun and -ESTRPIPE if a
> > suspend event occurred. Both cases are handled in alsa_write().

Yeah, I think you are right Volker. The already existing -EPIPE and -ESTRPI=
PE
error cases should handle the "xrun" and "suspended" conditions equivalently
in poll mode.

> > The -ESTRPIPE case is missing in alsa_read(), which may be a mistake. I
> > don't think it's possible alsa_read() and alsa_write() get called if the
> > ALSA system is in state SND_PCM_STATE_SETUP.

Agreed, -ESTRPIPE is missing in alsa_read(), and -EBADF (audio device in
invalid state) is missing in both alsa_read() and alsa_write(). That could
probably happen when you unplug an USB audio device. On macOS applications
also need to recover when plugging in/out headphones, but IIRC that's not
necessary with ALSA.

> > The write_loop() example code at
> > https://www.alsa-project.org/alsa-doc/alsa-lib/examples.html in file
> > test/pcm.c also doesn't use the snd_pcm_state() function. Please have a
> > look at write_loop() in test/pcm.c and compare it with
> > write_and_poll_loop() in the same file.
> >
> > With best regards
> > Volker
>=20
> Could we get back to this and either accept this patch or find another=20
> solution? From the above, it looks like this could be an acceptable fix=20
> unless we can prove it would break something (but then it's already=20
> possible to break it from the command line option so it's preexisting=20
> problem).

Well, I wouldn't say it's exactly the same thing to experience a misbehavio=
ur
with a specific, custom supplied option vs. experiencing the misbehaviour w=
hen
running with default options. And I am pretty sure you know why. ;-)

But anyway, I won't object this change:

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

> >> Now I haven't tested whether these would work in callback mode right n=
ow, but
> >> looking at the code suggests that they might not.
> >>
> >>>> I think it would be better to add a 2nd patch that would handle stat=
e changes
> >>>> in callback mode. That would satisfy both groups of people. AFAICS
> >>>> snd_pcm_state() can be called both in polling mode and callback mode.
> >>> I can't do that because I don't quite know neither alsa nor audio in =
QEMU
> >>> so I have no idea what to do. Can you give more clues?
> >> Well, as a starting point you might try whether these cases described =
above
> >> would still work in callback mode. Maybe it is even working, who knows.
>=20
> Can you suggest how can I test that? I'm not sure what to try and sound=20
> works with this patch for the cases I use.

A suspend condition is simply putting the host machine asleep, i.e. closing
the lid of your Linux notebook, or selecting suspend from the menu of your
desktop environment.

=46or testing for xruns (a.k.a. buffer overrun / buffer underrun) you could
simply insert a short sleep in the render code to simulate the audio render
function to take too long to deliver the audio data to the ALSA subsystem.

In both cases QEMU should recover audio. If it doesn't, you will simply
continue to hear silence with QEMU for good.

/Christian



