Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A018CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 00:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHWiv-0008R7-0j; Fri, 07 Nov 2025 19:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vHWis-0008Ph-NV; Fri, 07 Nov 2025 19:22:30 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vHWiq-0001if-9B; Fri, 07 Nov 2025 19:22:30 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4AB2A5972FE;
 Sat, 08 Nov 2025 01:22:23 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id kk2bx18pE7vx; Sat,  8 Nov 2025 01:22:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 00FB85972E8; Sat, 08 Nov 2025 01:22:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F34EA5972E7;
 Sat, 08 Nov 2025 01:22:20 +0100 (CET)
Date: Sat, 8 Nov 2025 01:22:20 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/audio/lm4549: Don't try to open a zero-frequency
 audio voice
In-Reply-To: <20251107154116.1396769-1-peter.maydell@linaro.org>
Message-ID: <5da4fd2b-6c5b-e2f4-b421-0a440718af7b@eik.bme.hu>
References: <20251107154116.1396769-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 7 Nov 2025, Peter Maydell wrote:
> If the guest incorrectly programs the lm4549 audio chip with a zero
> frequency, we will pass this to AUD_open_out(), which will complain:
>
>   A bug was just triggered in AUD_open_out
>   Save all your work and restart without audio
>   I am sorry
>   Context:
>   audio: frequency=0 nchannels=2 fmt=S16 endianness=little
>
> The datasheet doesn't say what we should do here, only that the valid
> range for the freqency is 8000 to 48000 Hz; we choose to log the
> guest error and ignore an attempt to change the DAC rate to something
> outside the valid range.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/410
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This bug has been around for so long and is a weird edge case whose
> only effect is to print a debug message, so it doesn't really seem
> worth cc'ing stable on.
> ---
> hw/audio/lm4549.c | 17 ++++++++++++++++-
> 1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
> index 745441bd790..bf711c49c04 100644
> --- a/hw/audio/lm4549.c
> +++ b/hw/audio/lm4549.c
> @@ -15,6 +15,7 @@
>
> #include "qemu/osdep.h"
> #include "hw/hw.h"
> +#include "qemu/log.h"
> #include "qemu/audio.h"
> #include "lm4549.h"
> #include "migration/vmstate.h"
> @@ -179,9 +180,23 @@ void lm4549_write(lm4549_state *s,
>         break;
>
>     case LM4549_PCM_Front_DAC_Rate:
> -        regfile[LM4549_PCM_Front_DAC_Rate] = value;
>         DPRINTF("DAC rate change = %i\n", value);
>
> +        /*
> +         * Valid sample rates are 4kHz to 48kHz.

Commit message says minimum is 8kHz. One of these is likely incorrect.
Maybe a typo in commit message?

Regards,
BALATON Zoltan

> +         * The datasheet doesn't say what happens if you try to
> +         * set the frequency to zero. AUD_open_out() will print
> +         * a bug message if we pass it a zero frequency, so just
> +         * ignore attempts to set the DAC frequency to zero.
> +         */
> +        if (value < 4000 || value > 48000) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: DAC sample rate %d Hz is invalid, ignoring it\n",
> +                          __func__, value);
> +            break;
> +        }
> +        regfile[LM4549_PCM_Front_DAC_Rate] = value;
> +
>         /* Re-open a voice with the new sample rate */
>         struct audsettings as;
>         as.freq = value;
>

