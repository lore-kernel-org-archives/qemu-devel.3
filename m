Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FFDC5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWzM-0003CY-2r; Mon, 24 Aug 2026 11:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWzK-0003Bp-Dl
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:53:30 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wyWzH-0000Y1-KT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:53:30 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a144c8eea2so6708720a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787586806; x=1788191606; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=86xh+S/ZKc9aeRZHKG5S4+38sEi0XNLBzt4Trs+dF1k=;
 b=z8v5djszKTyE+svjCz6+umfO9UN5s2I2e2nUOCcQMZz4+tj4QyJsrzLe0c4TqCQQa3
 w9Pf8TLAwecWlcllYJPdrMQHARuELrju3uKj2/iAfgse+M1fDr+BuH6iqz1+C01KRdOQ
 PixTDU4xGXx5tHSLs+yy5bFA4aySysO6JQ9hAJ0UuTsuS6JB8w84YO/lw2cbV/GkUBG0
 xMa2vy2Bfxuv5tVTOvGYfN+DZOqt8dXgu91X/JpgT9p/l9t2ZEvYtQ6NoLsH73UOdEIi
 yD2rVodoXEgzAjQAuHpQTpHpe1LZ7g9nujg2AUaXcEM9LKgWLkUPYlxOA2V6T6qDwYnQ
 GDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787586806; x=1788191606;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=86xh+S/ZKc9aeRZHKG5S4+38sEi0XNLBzt4Trs+dF1k=;
 b=UqR36t3qYQACEIVLWt5hDpqut6Q1SG08y1yNlt5bQHT8BgKj7/ORSnpg9qNh4GXjTP
 Z3YcTdNJfkJjBP9C+2jalxXJZlfTnKgyNOUMnMV9cVnXTLfqAWYd0mMQdrRMVJl+ueTC
 7/iPzQb6dLZKcXt1KGBZnkCz6yUIb7HD8511zVu+9MB0G6MdZj6EJGYrcSqkN54Mpxi/
 RcN7jnu7XL3XnRHzJoCiIT7bu370ABL6oIwl1gUWZLprbj1owaa2nmJuEZZScCrjehvT
 UvGRPJiyi2KuNR9ysR8WKXPv5y/GDX/KzF2I4tgTEHvqiy7Rz2bfhIo9+UgkdRWKy/Z5
 rGWw==
X-Gm-Message-State: AFuF++mPWxZ4MFreqeL7xRfG4gSsXkBDemSSVUJGOeIYUH5TsuapihR+
 PQRBj2zMvbGzL7OHMXcXbKJfL82gI7WNB1F7bDzs7jTpcuKnBuxHriFiCagunpVPjE0=
X-Gm-Gg: AR+sD126SHsCi7dPev0rkdk+0JbY+QXgx46WXKHcjDyq6RlBaZLlFaSUSCS03xCo1TR
 fMxXBLdvJNcgnkQjjEfkRLQ6CfrOrLVhbnOKiPOJJuHXDBbmHI1X1Ro+aeZpETT23XSHKJ7lS7f
 gc8WTbq4ih04z7B1UXw24Lyu2TAS3SplLvA0MgqPbez+TcQctnClQeEISr/CfAUklITyxWZriIZ
 pTol1x/vvQ5AFBDhD5d8rlkGUdi/tWr+wYyap0GmvrApD9NnG7trapSKO9FnXMrVQC++x94BZ+g
 1AU0U45K62pwaRbR1w/FHWqVAzaa++pldhN+qh4CSCQhTdN9Cc6/CcyvM5k1tomnhMATpBIHU94
 cHIH1/VWPzqy5KDc1QgP74CSZetISDH8VyuYyXOdH/QsDzyRLIVg7s4NNJdZglv4BLMwnWbQi1w
 RWgMJSnQrr02uygJxUuYjSfi9CtRmP0yi+CZWKsG3OTxyYaT1MnZVVx/heaubn
X-Received: by 2002:a05:6402:2402:b0:6a1:854:e75e with SMTP id
 4fb4d7f45d1cf-6a582b8ebc4mr23841554a12.15.1787586805706; 
 Mon, 24 Aug 2026 08:53:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2e2826sm9264063a12.31.2026.08.24.08.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:53:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B23E45F7F5;
 Mon, 24 Aug 2026 16:53:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH v2 03/14] hw/sd/sdhci: complete non-interrupt ADMA
 descriptor chains in one pass
In-Reply-To: <20260820124824.618671-4-wafgo01@gmail.com> (Wadim Mueller's
 message of "Thu, 20 Aug 2026 14:48:03 +0200")
References: <20260820124824.618671-1-wafgo01@gmail.com>
 <20260820124824.618671-4-wafgo01@gmail.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Mon, 24 Aug 2026 16:53:23 +0100
Message-ID: <87v78zqzv0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Wadim Mueller <wafgo01@gmail.com> writes:

> sdhci_do_adma() returns to the main loop after every descriptor and relies
> on a timer re-entry to pick up the next one. For a descriptor chain whose
> entries do not request an interrupt this makes the transfer rate depend
> from the virtual clock rather than on the guest's programming, which
> significantly slows down large transfers and makes guest-visible timing
> depend on host timer behaviour.
>
> Keep processing the chain in the same invocation while no descriptor asks
> for an interrupt and the transfer has not finished, and only fall back to
> the deferred path when the guest actually requested a notification.
>
> A qtest reproducer is added later in this series.
>
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
> This patch can be dropped once Bin Meng's SDHCI series
> https://patchwork.ozlabs.org/project/qemu-devel/list/?series=3D515264
> (which needs series=3D513930 applied first) is merged - it covers the
> same AM64x failure, see
> https://lore.kernel.org/qemu-devel/20260810124519.34501-1-wafgo01@gmail.c=
om/
> It is included here only so that the series works on actual master.
>
>  hw/sd/sdhci-internal.h |  9 +++++++++
>  hw/sd/sdhci.c          | 23 +++++++++++++++++++++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
> index 4aeed120bf..e6ce12617e 100644
> --- a/hw/sd/sdhci-internal.h
> +++ b/hw/sd/sdhci-internal.h
> @@ -277,6 +277,15 @@ FIELD(SDHC_MAXCURR, V18_VDD2,         32, 8); /* sin=
ce v4.20 */
>  #define SDHC_INSERTION_DELAY            (NANOSECONDS_PER_SECOND)
>  #define SDHC_TRANSFER_DELAY             100
>  #define SDHC_ADMA_DESCS_PER_DELAY       5
> +/*
> + * Upper bound on ADMA2 descriptors handled in a single sdhci_do_adma()
> + * call, as a safety valve against a malformed or circular descriptor
> + * list. A well-formed transfer terminates far below this via END or
> + * blkcnt =3D=3D 0 (even a 4 GiB transfer built from 64 KiB TRAN descrip=
tors
> + * is only ~64K descriptors); the bound merely guarantees the loop makes
> + * a decision instead of spinning forever.
> + */
> +#define SDHC_ADMA_MAX_DESCRIPTORS       (1 << 20)
>  #define SDHC_CMD_RESPONSE               (3 << 0)
>=20=20
>  enum {
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index e58a610397..9a5dd1d93f 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -780,7 +780,6 @@ static void sdhci_do_adma(SDHCIState *s)
>      const MemTxAttrs attrs =3D { .memory =3D true };
>      ADMADescr dscr =3D {};
>      MemTxResult res =3D MEMTX_ERROR;
> -    int i;
>=20=20
>      if (s->trnmod & SDHC_TRNS_BLK_CNT_EN && !s->blkcnt) {
>          /* Stop Multiple Transfer */
> @@ -788,7 +787,27 @@ static void sdhci_do_adma(SDHCIState *s)
>          return;
>      }
>=20=20
> -    for (i =3D 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
> +    /*
> +     * Process the descriptor chain to completion (END or blkcnt =3D=3D =
0),
> +     * yielding to the guest only for a descriptor carrying the INT
> +     * attribute (a DMA-boundary interrupt, handled at the end of the lo=
op).
> +     *
> +     * Historically at most SDHC_ADMA_DESCS_PER_DELAY descriptors were
> +     * handled per call before rescheduling SDHC_TRANSFER_DELAY ns later=
 on
> +     * QEMU_CLOCK_VIRTUAL. That pacing is only needed so a guest can obs=
erve
> +     * the intermediate DMA-interrupt state; a bulk transfer that reques=
ts
> +     * no interrupt does not need slicing, and throttling it across many
> +     * virtual-clock round-trips can make it race a guest-side transfer
> +     * timeout. Run such chains to completion in one call instead.
> +     *
> +     * SDHC_ADMA_MAX_DESCRIPTORS bounds the loop so a malformed or circu=
lar
> +     * chain cannot spin here forever; on overflow, break to the resched=
ule
> +     * path so the main loop stays responsive.

Hmm SDHC_ADMA_MAX_DESCRIPTORS is (1 << 20) which seems an awful lot to
handle in dma session especially if this is a guest controlled thing.

> +     */
> +    for (unsigned int adma_descs =3D 0; ; adma_descs++) {
> +        if (adma_descs >=3D SDHC_ADMA_MAX_DESCRIPTORS) {
> +            break;
> +        }

Seems an odd formulation when you have the for loop construct already.
Although I see sdhci_do_adma already has multiple exit paths that skip
the final timer reset so it is hard to follow the control flow anyway.

I wonder if there is a better way to structure this logic so its easier
to see where irq's are set, transfers ended and timers scheduled for
continuation?

>          s->admaerr &=3D ~SDHC_ADMAERR_LENGTH_MISMATCH;
>=20=20
>          get_adma_description(s, &dscr);

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

