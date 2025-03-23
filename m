Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD7AC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 13:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twLLQ-0008WC-NC; Sun, 23 Mar 2025 09:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1twLLK-0008Vc-EF
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 09:26:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1twLLI-00067W-NY
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 09:26:22 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 09EAF4E6013;
 Sun, 23 Mar 2025 14:26:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id BYSeV_D5f2Ym; Sun, 23 Mar 2025 14:26:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0BE264E601A; Sun, 23 Mar 2025 14:26:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A36074577C;
 Sun, 23 Mar 2025 14:26:17 +0100 (CET)
Date: Sun, 23 Mar 2025 14:26:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Volker Ruemelin <vr_qemu@t-online.de>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] alsaaudio: Set try-poll to false by default
In-Reply-To: <20250316002046.D066A4E6004@zero.eik.bme.hu>
Message-ID: <27664957-709e-e8fe-48c4-0b3abd4f4a79@eik.bme.hu>
References: <20250316002046.D066A4E6004@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-932217852-1742736377=:79916"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-932217852-1742736377=:79916
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 16 Mar 2025, BALATON Zoltan wrote:
> Quoting Volker Rümelin: "try-poll=on tells the ALSA backend to try to
> use an event loop instead of the audio timer. This works most of the
> time. But the poll event handler in the ALSA backend has a bug. For
> example, if the guest can't provide enough audio frames in time, the
> ALSA buffer is only partly full and the event handler will be called
> again and again on every iteration of the main loop. This increases
> the processor load and the guest has less processor time to provide
> new audio frames in time. I have two examples where a guest can't
> recover from this situation and the guest seems to hang."
>
> One reproducer I've found is booting MorphOS demo iso on
> qemu-system-ppc -machine pegasos2 -audio alsa which should play a
> startup sound but instead it freezes. Even when it does not hang it
> plays choppy sound. Volker suggested using command line to set
> try-poll=off saying: "The try-poll=off arguments are typically
> necessary, because the alsa backend has a design issue with
> try-poll=on. If the guest can't provide enough audio frames, it's
> really unhelpful to ask for new audio frames on every main loop
> iteration until the guest can provide enough audio frames. Timer based
> playback doesn't have that problem."
>
> But users cannot easily find this option and having a non-working
> default is really unhelpful so to make life easier just set it to
> false by default which works until the issue with the alsa backend can
> be fixed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> This fixes my issue but if somebody has a better fix I'm open to that
> too.

Ping?

> audio/alsaaudio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index cacae1ea59..9b6c01c0ef 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
> static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
> {
>     if (!apdo->has_try_poll) {
> -        apdo->try_poll = true;
> +        apdo->try_poll = false;
>         apdo->has_try_poll = true;
>     }
> }
>
--3866299591-932217852-1742736377=:79916--

