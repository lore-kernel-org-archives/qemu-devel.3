Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5928E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4Gq-0007gA-CF; Wed, 18 Dec 2024 19:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4Go-0007ek-8g; Wed, 18 Dec 2024 19:20:02 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4Gm-0005uR-M8; Wed, 18 Dec 2024 19:20:02 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21675fd60feso2801555ad.2; 
 Wed, 18 Dec 2024 16:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734567599; x=1735172399; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fesVFMYP/ga2PF+jiXtf9m5qHaTLSa2xdLSDe4CGdY=;
 b=jR8M5/RFlxdP8v99dt44A/eIzhCTjMSOCcYYk4fIsokX527Vqw6uJoxbjdXiCEksL2
 aYZRjjNMMobF5Nyb5zB8az9rznO4Ka6wQ65tObZgvuEh49ZbtbzWVUMMYIU6dsYnQ2ox
 mCiz7jEMzyOfLrbvY0yKY7AbVkl9yIzeyqa1g3DjCCBBBiv80HBjkGcztf2dvISXi9ZZ
 RuJxCKW1BnvXAjX9CPqoEadtC/26osF9p/j7mLSuYFJKdcE2Y9o+gGOG8xk9H3dkje7k
 MOt3ckHTGvWqZxcq++38cVHYE+JE159kbKTwZpIkRittZx84IewjvtcIse9fq5vTWkJ+
 cF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734567599; x=1735172399;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+fesVFMYP/ga2PF+jiXtf9m5qHaTLSa2xdLSDe4CGdY=;
 b=J5mwJxTi23233eKca+Ts5uWYBPomRtbTfVVqNxSWxKYwXjA81RaNTE5eNNrscOd05Z
 sop351Kaj6FvJxSKpGMk/U52DWLma0SZDRtfhwpT2yma8d3B8XyV6KnqJc8nlNICerC/
 wKtlp/uOkF8lHdgLQo9pHL8GV731MNVL4SCAmoJ75W55fKKgpiQbzzpGPEi44091SwNk
 D1lAfnIEV4E7LTqd2i6+UkNFpOtGmxQmO5VmToNtcJaFcontT9dAMVEx2GCJ2OuJGRHt
 tzTA4p35+hnErU0aQrU68fXnlYh9qnbUdWM1oDU87xBKNqB5ay1iI3/Z+tFa/8mXyzxu
 02KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZeEHTpz5kPhvBG7vQ+zHUxhBdMyBsrcYMBRLUFtJpqAIa2mSpK1kIUoyXy3d2SdZBaDZW6mL0UaxQ@nongnu.org,
 AJvYcCVmfHqwd1AIqGWf+8Jlg9Pr8f6mz7ynRi0otR5c54al2ixPTuFKylmHHsN61UUWoZb1+JmAxnP7SrU=@nongnu.org
X-Gm-Message-State: AOJu0YzvAHYSNKEOg/rhdLHo/fXptwlVbGfG2PwO0MZOZY0o5Tc0GQLy
 ZVpkIaPOuYE+iLTtt4kEhRoM5OLsrPJBbGpXry8tEm9oMYXqRNH0
X-Gm-Gg: ASbGncvlT24Dofm4zpP86dv1uTSWOGSUsYb5QQukEjls9X4jiU50ceEVuV8A5rsKfgK
 idA8sw/Hg9KiKjJRnM0BkWcUXqannpBnJeCtvnBBDoxbP9HahTHalHehBjNpYudo1BM+LNZiki8
 Q5TKqYYkBcqSGqqwDjeDvenke8xc7DUxwhUrcxsIuBXlBwM31rgU1sbhHu46c2t4faDHycVJ5i4
 Mph4wNFuPhTw5GhcOcQVad7tc+J7501PXd3CjAmz86OT6se/ztJObjyWGYbzNvB1cGxPpz/NWc=
X-Google-Smtp-Source: AGHT+IH0RvXCwh04CptehpsYV+vDP5afToniH09fZVSSLC6kei/9UTf3GFJRCbEcB0DZkdgM2oGh7g==
X-Received: by 2002:a17:903:944:b0:216:2bd7:1c36 with SMTP id
 d9443c01a7336-218d6fd79d7mr77130645ad.1.1734567598987; 
 Wed, 18 Dec 2024 16:19:58 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9f842esm1124185ad.218.2024.12.18.16.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:19:58 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:19:51 +1000
Message-Id: <D6F8W70TGUGH.6TOU7D1GI6Z9@gmail.com>
Cc: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "BALATON
 Zoltan" <balaton@eik.bme.hu>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 6/7] hw/ppc/spapr: Convert DIRTY_HPTE() macro as
 hpte_set_dirty() method
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-7-philmd@linaro.org>
In-Reply-To: <20241218182106.78800-7-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu Dec 19, 2024 at 4:21 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Convert DIRTY_HPTE() macro as hpte_set_dirty() method.
> Since sPAPR is in big endian configuration at reset,
> use the big endian LD/ST API to access the HPTEs.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/ppc/spapr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4e1fe832c29..dedf6fb2916 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1422,7 +1422,11 @@ static void hpte_set_clean(SpaprMachineState *s, u=
nsigned index)
>               ldq_be_p(hpte_get(s, index)) & ~HPTE64_V_HPTE_DIRTY);
>  }
> =20
> -#define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |=3D tswap64(HPTE64_V=
_HPTE_DIRTY))
> +static void hpte_set_dirty(SpaprMachineState *s, unsigned index)
> +{
> +    stq_be_p(hpte_get(s, index),
> +             ldq_be_p(hpte_get(s, index)) | HPTE64_V_HPTE_DIRTY);
> +}
> =20
>  /*
>   * Get the fd to access the kernel htab, re-opening it if necessary
> @@ -1633,7 +1637,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, =
int shift, Error **errp)
>          spapr->htab_shift =3D shift;
> =20
>          for (i =3D 0; i < size / HASH_PTE_SIZE_64; i++) {
> -            DIRTY_HPTE(hpte_get(spapr->htab, i));
> +            hpte_set_dirty(spapr->htab, i);
>          }
>      }
>      /* We're setting up a hash table, so that means we're not radix */


