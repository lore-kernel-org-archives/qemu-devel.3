Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409C0C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEpX-0001Lz-Fe; Mon, 31 Mar 2025 09:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1tzEpU-0001Lg-Eo
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:05:29 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1tzEpS-0002GJ-Qs
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 09:05:28 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 2EE9BA0147; Mon, 31 Mar 2025 15:05:24 +0200 (CEST)
Date: Mon, 31 Mar 2025 15:05:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
cc: qemu-devel@nongnu.org, Volker Ruemelin <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
In-Reply-To: <2118992.kbFERA6akJ@silver>
Message-ID: <alpine.LMD.2.03.2503311503200.6402@eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
 <2118992.kbFERA6akJ@silver>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1117279078-386748862-1743426324=:6402"
Received-SPF: pass client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1117279078-386748862-1743426324=:6402
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 23 Mar 2025, Christian Schoenebeck wrote:
> On Sunday, March 16, 2025 1:20:46 AM CET BALATON Zoltan wrote:
>> Quoting Volker R=FCmelin: "try-poll=3Don tells the ALSA backend to try t=
o
>> use an event loop instead of the audio timer. This works most of the
>> time. But the poll event handler in the ALSA backend has a bug. For
>> example, if the guest can't provide enough audio frames in time, the
>> ALSA buffer is only partly full and the event handler will be called
>> again and again on every iteration of the main loop. This increases
>> the processor load and the guest has less processor time to provide
>> new audio frames in time. I have two examples where a guest can't
>> recover from this situation and the guest seems to hang."
>>
>> One reproducer I've found is booting MorphOS demo iso on
>> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
>> startup sound but instead it freezes. Even when it does not hang it
>> plays choppy sound. Volker suggested using command line to set
>> try-poll=3Doff saying: "The try-poll=3Doff arguments are typically
>> necessary, because the alsa backend has a design issue with
>> try-poll=3Don. If the guest can't provide enough audio frames, it's
>> really unhelpful to ask for new audio frames on every main loop
>> iteration until the guest can provide enough audio frames. Timer based
>> playback doesn't have that problem."
>>
>> But users cannot easily find this option and having a non-working
>> default is really unhelpful so to make life easier just set it to
>> false by default which works until the issue with the alsa backend can
>> be fixed.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> This fixes my issue but if somebody has a better fix I'm open to that
>> too.
>>
>>  audio/alsaaudio.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
>> index cacae1ea59..9b6c01c0ef 100644
>> --- a/audio/alsaaudio.c
>> +++ b/audio/alsaaudio.c
>> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enabl=
e)
>>  static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *ap=
do)
>>  {
>>      if (!apdo->has_try_poll) {
>> -        apdo->try_poll =3D true;
>> +        apdo->try_poll =3D false;
>>          apdo->has_try_poll =3D true;
>>      }
>>  }
>>
>
> Correct me if I am wrong, but AFAICS if polling is not used then no state
> changes would be handled, no? At least I don't see any snd_pcm_state() ca=
ll
> outside of alsa_poll_handler().

I have no idea but this fixes the problem (and does the same that can be=20
also done from command line but nobody can find that command line option)=
=20
so unless somebody has a better idea could this be merged as a fix for=20
now?

Regards,
BALATON Zoltan
--1117279078-386748862-1743426324=:6402--

