Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF79C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OU3-0005cP-Es; Sat, 29 Aug 2026 15:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OU2-0005cC-Jp
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:12:54 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OU1-0006jt-4j
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:12:54 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b4af730f8aso2244071e87.1
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788030771; cv=none;
 d=google.com; s=arc-20260327;
 b=Tzcm4sNgEGd6uCdN8RGp4PuNYS+bcbEmyTCQvnYVUJZe0EZaZ/LpvGW4Fn0ZrzoM6Y
 scPRQ76zctOOtYWHmpt7/1XUQxdhiwKSkQJZBQ1vSqkhExLd66QzTIZ16FMYqQ2s+4UW
 J82hWsZ13OWJb5Ek666Ghsxmon4ZVJQIysh47jday+HLnwbNeEVbnumH5RF5sDVeywpu
 yEkf3qv+8BSSTgWwZkxDAV/4IgDPAYHBSpzk5ijAsfgjYNop6AfdBirFkhUxM84Mabjw
 HLqz8os/YeLMk2BBF1gS8dlSvyhYie97CieQVakOyda51/4q8e7XOjOn/s5RjEW+3LMK
 TvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BrcR/Q2VixOPbJlArSJDkxDz0NN1B7fbQec9LePT8xg=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=EybZKGofFOg+VtUbuOJgnpTspp8Z9NQAv8H6yYo5+O3wwY4pJD3gukAswCS/g1cocO
 nTY5e9X/EwlE5hU4oGf5h+WD3emWdHvdJ8vdsV+MwTPw8waRKA6z4m6JtrFjCG+DrIJ8
 XRmXzKRwgE2nNg7Hq5cB9j7/G8pUaR50sGZXUga6aDNuOU+3qQWXqgwAKKL6DRzZ+Or3
 /XBuA76J94cyw9saXPqanJrWOpQliIk/sKLl0c9gXjRFDrKwNLHLHHFCmSq7IjNyys3r
 99SI582IbiKxIliS8f7fBZEnerTvMQ2uKSMq5GHOWeG/nFjqABM7Vc4/sJH+lFNDzuPI
 uuIA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788030771; x=1788635571; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BrcR/Q2VixOPbJlArSJDkxDz0NN1B7fbQec9LePT8xg=;
 b=oGzuP5vWnjaolPnmYLcV3RxRiwHrPvdy5g1f7F19jQOezwwepNEXRJW9qsym3tf1BQ
 QnZ8kk2mmJDYOA5UtzBb5uerj9nTjMDAdjXXQqECwfjeHiqE/P71iQll2bh2tvvdIBIt
 bYpuAXULzKYklRqafKyP9ERraq7BxVhzODhIYP1FvoRNqe8GAljjVDuSn52sbiFKzB/q
 ifK71QxhquJdXrPPokALJB8k1htk2PbCiosjBV1stcSIcMPFbbcpKPzbEqohwuwVtyDI
 0RqyBilyD21gAAEWwZ2rnvlWae/Mx2uXhve5oZrOSP5FcwG8rCij01gpWtnD97s8y25D
 uI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788030771; x=1788635571;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BrcR/Q2VixOPbJlArSJDkxDz0NN1B7fbQec9LePT8xg=;
 b=dys+6fBBBLTbrkHo2D8pzS876dk6JSUedd3rydGJ1kMNO5ig+oPNwVE+8jq+H6Ryq+
 HJAvLcqbZaFzEXKNMM/j7jjcS3TYhAOJlB0bbiNXr6cT+6Nc4sMrYHEkS5NIcMWut5xl
 3y0rFJOHXUVTdMFM43QbSy7XHRT/Ryb+txfbzC85xrJl45idi6tq0BDSqXXt17OtDkJO
 jjgEbzumiL+kUVnzGqquuqen65VWAZ9PyA3lkf2R/ZXPWljgE7W0Vki/Kkf4WOkiBdAN
 l3WnV38kbp3fzatA8rqcZuxzkwc0kVHIdL1ZCLmDJl7T9NlwQBx9AIc3YDgZ3sV9dTnG
 HOwQ==
X-Gm-Message-State: AFuF++k3/FXs1zbUPfaHkGf6aI4I25A1iiOHYP8JLLknnL7kNQoi/YHc
 lqoFqJM/nJvL2sasqllCHX31X9qfJPQJFUvqWYuF+NsXl6jJ++7PjD2Co6QxcQiQoxzqoSgr8cY
 wlidy9WTkLy1pLLCg6X83NuLcdpIF948=
X-Gm-Gg: AYBFou3tBIeYYEnZUfsF3cy3OD8s3XV0roy+vxEMWbxy1IpIsvs6VjiHLCWRvVOER7n
 d6vlDoM/9KtzQLqfrkCy6h8lUweD+BaSbM4NWNHecROVw8HZiMZmjWouCD7J4aVrX25SdatSYiX
 7FlWavNMJLvZvYX378G/x6XcG4LxP5W3nEgn3n+796jY5eAHwV4pzPN+74+8DBcX3VSN4+HrC7A
 ylM+hzt3KvN0hOc2BCc093o7/faJj4/H6Bn/ndaCWXMVs2QElnoQrlyywZdWJu6spRHIAwaVaBQ
 06IhBEVhXcHoVxdZsVFTWn9LVqVUEVKcg3lK5mPc04stgTg4XStUxq4QDQ==
X-Received: by 2002:a05:6512:3052:b0:5ae:b01a:d213 with SMTP id
 2adb3069b0e04-5b5e68b197fmr4325760e87.3.1788030770996; Sat, 29 Aug 2026
 12:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-11-richard.henderson@linaro.org>
In-Reply-To: <20260828224451.1564072-11-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 29 Aug 2026 15:12:38 -0400
X-Gm-Features: AcwNN1X4R1R2hMJGx9atC3yEpY9Rw4PomXlLO5grld3MZmTFanPND9vw6mOeC_g
Message-ID: <CAEdQ38H7CwWbJYDKX6=AmzESjPTY=ZV+v+3O=+=y_cSrAMKaJg@mail.gmail.com>
Subject: Re: [PATCH 10/16] tcg/x86_64: Introduce TCG_REG_NONE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 28, 2026 at 6:45=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rather than hard-code -1, or compare < 0, use something
> more descriptive.  This also allows more use of TCGReg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/x86_64/tcg-target.h     |  1 +
>  tcg/x86_64/tcg-target.c.inc | 66 ++++++++++++++++++++-----------------
>  2 files changed, 36 insertions(+), 31 deletions(-)
>
> diff --git a/tcg/x86_64/tcg-target.h b/tcg/x86_64/tcg-target.h
> index 7ebae56a7d7..7109722f240 100644
> --- a/tcg/x86_64/tcg-target.h
> +++ b/tcg/x86_64/tcg-target.h
> @@ -31,6 +31,7 @@
>  #define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
>
>  typedef enum {
> +    TCG_REG_NONE =3D -1,
>      TCG_REG_EAX =3D 0,
>      TCG_REG_ECX,
>      TCG_REG_EDX,
> diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
> index 660350b963d..ec397e287c0 100644
> --- a/tcg/x86_64/tcg-target.c.inc
> +++ b/tcg/x86_64/tcg-target.c.inc
> @@ -210,7 +210,8 @@ static bool tcg_target_const_match(int64_t val, int c=
t,
>      return 0;
>  }
>
> -# define LOWREGMASK(x) ((x) & 7)
> +#define LOWREGMASK(x)   ((x) & 7)
> +#define REGOR0(x)       ((x) =3D=3D TCG_REG_NONE ? 0 : (x))

Could use a static inline to avoid evaluating `x` twice. Doesn't look
to be a big deal.

