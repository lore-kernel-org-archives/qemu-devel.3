Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BDACA0EDB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 18:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ultxw-0003WK-4Q; Tue, 12 Aug 2025 14:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ultxv-0003WA-0l
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 14:43:19 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ultxp-0005KT-1W
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 14:43:18 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71a38e35674so40182857b3.3
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755024188; x=1755628988; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ASu/EcgNo0PPrgDbUsAm/4oXgjrYVlPdG6h39Z6aCtc=;
 b=U9ptFhqjZiBMZ5BD0rG8fSaZnFvDWfWQPHD/OIHcULo/rCCSXJ0IXY2J3q/hz+kecT
 J7R245QhTwC9URp3N6spFkBJiBHTkIkavEOBga6gyRNkc9n1hTa+MPIEZl/mqRWLTjWk
 0LGeGATXD7JBDZ6g8pq3lhgvrk8hjhGLvBQg4mXCuDDlHwucIFY33FY/KzJoiKlJCoP1
 HbwcNQyu1Dp3TGDaCHb6JE+/Wi15mzkl6VFkf1agic2VsIhtDbssS1Q6Ea7PKLHXwmLg
 h2GyliZtJjV00JyhhsXFm3aHuU0/13WzwskjJuRoVkEOwZh3Yt0nTEUINT2oNc/OzvGs
 94aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755024188; x=1755628988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASu/EcgNo0PPrgDbUsAm/4oXgjrYVlPdG6h39Z6aCtc=;
 b=o6axqhNZYk4l0Hp3Kjt0K7cc4rnWulb5YwQoPCShK/zMPTbcr9z+gkU1RGonz9M3tm
 VVPakBJbAoIZZYh8bzxUvZq5/VgE8IlOVDcVzcRw10qOvxgAif2gcwchIOl2yzwzQEkD
 FzRQuB2ql0Q5HC6bQ6ZqGXK48lLRTpqF5JWdYMcbAuW9xtRHv0M0N/4vp+BO74HLQaM+
 z1LWALD/fnErnSsgDgq8+6sY99ye++YC7IEQKBG/Yi6DXRInI9EP9ruGUznYCSfQ1dEw
 mvmso7+9mzf5LMfJP+pRQynWRJtDRemEQ2U0RGmvFK6J2WsV1eyO3z6LKr+quxiMPFjv
 8sxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdSw0M1pIIAh3VgYFk6T53lnr0I7VZaDxuolg5LZyOovXdilVGPUzNF7+EoTxFoO5FeQk4vpAvSxCD@nongnu.org
X-Gm-Message-State: AOJu0Yw5OjhfjIbGev/GFStZhrFivNluwmDu00w9r1whbXYO/O+aIJkd
 iTBMBFhSwhumY8Cw73wsBfPBPzMQ803snY9Adhx8fBdVTr3fgntjuhHljq43/mbfvKOvEEbUe2p
 sN4IO00qYY7CB41WUFYlZ9/qDvRR5gNpUeT3D7iTpXg==
X-Gm-Gg: ASbGncsUzIVyfsXZnWfK73muX6eMBPq4xj4v7IuqNiLYjePp0zvfUqHwWXUCxYON9pX
 DmiQxVGIcq1IcWdEQZo9e0gvWz17X2DUnbOwecdFQ3CpZm77whLj1JWk9Mb/bWzveW7pnPvjOCL
 PeibNWTCzBell0tBh1RBuS9CUM2dLjo0Cy4bqYjt7EpBNfh5y8R+16TaHqoBvbqdnPLpQ2kEEKr
 UtogszP
X-Google-Smtp-Source: AGHT+IG5fBhgDj5GIBdKf+D3E62Fl95jLpMspYa6rd2qzXdpmJcf7yc/UCkF4Z3tKKo1N6qdZGLrURE3Lg47X4iUOqs=
X-Received: by 2002:a05:690c:64c9:b0:71c:1142:f9ba with SMTP id
 00721157ae682-71d4e3f3955mr2813937b3.4.1755024188350; Tue, 12 Aug 2025
 11:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-5-tangtao1634@phytium.com.cn>
 <0b38d386-9d8b-46bd-a981-718cc7281eb6@linaro.org>
 <f74b4d64-893f-4b39-aa95-4e9ff52edebd@phytium.com.cn>
 <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
In-Reply-To: <4ff26d30-3b0d-4392-8bac-698ecb0fbdde@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Aug 2025 19:42:57 +0100
X-Gm-Features: Ac12FXw8S2eKy3NNE7LqpBxSg8Fp_hjo_dW78xP0Okb2fZqEX_H-WlwB-wpsGsg
Message-ID: <CAFEAcA-imgF9NLPWeXfE1JRL0gaKpVyfbbNKxojHDVz0t7EBKw@mail.gmail.com>
Subject: Re: [RFC 04/11] hw/arm/smmuv3: Enable command processing for the
 Secure state
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Tao Tang <tangtao1634@phytium.com.cn>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>, Chen Baozi <chenbaozi@phytium.com.cn>,
 smostafa@google.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 11 Aug 2025 at 11:34, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi,
>
> On 10/8/25 18:59, Tao Tang wrote:
> > On 2025/8/7 05:55, Pierrick Bouvier wrote:
> >> On 8/6/25 8:11 AM, Tao Tang wrote:
> >>> This patch enables the secure command queue, providing a dedicated
> >>> interface for secure software to issue commands to the SMMU. Based on
> >>> the SMMU_S_CMDQ_BASE configuration, the SMMU now fetches command
> >>> entries directly from the Secure PA space so that we need to pass the
> >>> memory transaction attributes when reading the command queue.
> >>>
> >>> This provides a parallel command mechanism to the non-secure world.
> >>>
> >>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> >>> ---
> >>>   hw/arm/smmuv3-internal.h |  8 ++++--
> >>>   hw/arm/smmuv3.c          | 55 +++++++++++++++++++++++++------------=
---
> >>>   hw/arm/trace-events      |  2 +-
> >>>   3 files changed, 41 insertions(+), 24 deletions(-)
> >>>
> >>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> >>> index 1a8b1cb204..5b2ca00832 100644
> >>> --- a/hw/arm/smmuv3-internal.h
> >>> +++ b/hw/arm/smmuv3-internal.h
> >>> @@ -319,9 +319,13 @@ static inline void queue_cons_incr(SMMUQueue *q)
> >>>       q->cons =3D deposit32(q->cons, 0, q->log2size + 1, q->cons + 1)=
;
> >>>   }
> >>>   -static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
> >>> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s, bool is_secur=
e)
> >>>   {
> >>> -    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
> >>> +    if (is_secure) {
> >>> +        return FIELD_EX32(s->secure_cr[0], S_CR0, CMDQEN);
> >>> +    } else {
> >>> +        return FIELD_EX32(s->cr[0], CR0, CMDQEN);
> >>> +    }
> >>>   }
>
>
> >> This looks like a reasonable and readable approach to support secure
> >> and non secure accesses.
> >
> > Hi Pierrick,
> >
> > Thank you so much for taking the time to review and for the very
> > positive feedback.
> >
> > I'm very relieved to hear you find the approach "reasonable and
> > readable". I was hoping that explicitly passing the parameter was the
> > right way to avoid issues with global state or code duplication, and
> > your confirmation is the best encouragement I could ask for.
>
> An alternative (also suggested in patch #1) is to use index for banked
> registers.

This is often how we handle S/NS banked registers, yes.
Other examples:

include/hw/intc/arm_gicv3_common.h: the S/NS banked registers
ICC_CTLR_EL1, GICD_STATUSR, GICR_STATUSR are implemented as
uint32_t icc_ctlr_el1[2] etc. (The GICv3 also has some
group-related registers which is why it also has 3-element arrays)

The banked AArch32 system registers in cpu.h are a bit
more complicated, and there we have some macros
A32_BANKED_REG_GET/SET which access the right fields.
This lets us define the mapping between the NS and S
registers and the AArch32 ELx views. (I'm not sure I'd
go down this path again if we did it now: our AArch32
design here pre-dates AArch64. The AArch64 views use
an array that they index by EL.)

Sometimes when there are only a few registers that need
to be banked S/NS we give them names, as with the
GICv2 where we have separate apr[][] and nsapr[][] arrays.

I think I would say that it depends mostly on how many
registers there are, and whether you wind up wanting to do
a lot of "the logic is the same for both S and NS, it
just operates on the other register in the bank". It
can make the code a lot easier to read in that case if
you have functions that take the is_secure parameter
and just use it all the way through to index into the
register array. Even in the simple example above of
smmuv3_cmdq_enabled(), you can see that

  return FIELD_EX32(s->cr[is_secure][0], CR0, CMDQEN);

is more succinct than the if-else version.

I have not looked closely enough the SMMUv3 code or spec to
be certain which side of the line it falls, but a glance
at the register overview does suggest that the design
has registers for all of normal, secure, realm and root.
Using an array will probably make our lives easier
if/when we have to implement the RME support in the SMMU.

thanks
-- PMM

