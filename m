Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C552E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4GV-0007aG-OL; Wed, 18 Dec 2024 19:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4GU-0007ZP-89; Wed, 18 Dec 2024 19:19:42 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4GS-0005rt-BM; Wed, 18 Dec 2024 19:19:41 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd17f2312bso103090a12.0; 
 Wed, 18 Dec 2024 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734567578; x=1735172378; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OhXldlveL1RWvpaLWu8+PBob84fohYEx35YIVHrRAQ=;
 b=iy8eD6sMtgMdFwv36dMtSsYWS+FlJXnUdYhSQ07HEC9rOrwAVzprYW4ZynVOJYYRzx
 DiV0UlNGDAQWtMeMGS0jQoCt1DYe1IvvS6lNy7cH7G3pa4O/BYWtfoocd/5FFtp6uuYO
 okDIbQLHZnrK7ynzm/rwOI8B9v9v1APOu/FWCw8s/i30Rd5S+eSTwbKKnj699B4E07g2
 cnJyL790ByM8lvKSOLtwxL5O6AWcJGdcWqYhLp+mA2NxxRmP3UejzB0HhqXeCBgGN+qO
 5fw9w56Vhz3iSKVJOMDvt0Fv4jxMgoeJaexjPC20/PYG+mvwfT4vKaB4HjZshF4/r8pk
 IC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734567578; x=1735172378;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2OhXldlveL1RWvpaLWu8+PBob84fohYEx35YIVHrRAQ=;
 b=v6V2tGqc3Qr6P87+2tEefmHifmCqQIf34ti+kCkRJj33NjiqgU1d1KcRXwB5NbvtHG
 5XVB8EHJ2PQwa83c+UtapUOn7ijZA3+YWg06z/SiRG4X15/S0fn8M4F8qgf1PUpKw84N
 lIxSTDMYezt2tT3dXT4RUtI8wb/DNg07OOj71UcElovC2DU5tr4KJHyIjoJINXJKYnEI
 8pBBTWNr9lQKqSM9mLGK0++WdtFzW08D3hXOwFjZATt57k0SGy2Kcz/LDTjglcdV2VNb
 48KrUY5sZQr2d9/l5C9K80tGuvR7TrPmT7k5bKuoG18KBzUsp5wfMUkLhFOSt4sAQ/Tu
 3Tjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT/FbB9tueb6YtAkhEf7XCokOEXYAU6F1k1BXTEehTHLLjHR46OwcdMimk5zilATyF0oo5LkGDKUI8@nongnu.org,
 AJvYcCWGVv8cUt+omlA+pThrzqd44LO+6UuU67j03iKLRtYTarmpPe3mVwvBTi2jLeqnQ8tyIWRKIKDYLzk=@nongnu.org
X-Gm-Message-State: AOJu0YyE7LXq1iEA6GDr4epq7C2R4TcM+GljUwv9elpM3atq23y9kNku
 TSpwLgo0X/yGZfdJ030OlpnXZ/Kzrpp7TL0CXKZ/FatvGZr02j5T
X-Gm-Gg: ASbGncv0FXttko9HV/7w5RE8nX+XsU83JA9sN8NpmZts0DF5UsXHgA6Q2/5XX4XP8cG
 puj13VlqO452jLFGBV9fF5CF7ZEdmBnPTqPk6z62iQtFENSl/Ji9olP9CFjkOJW8ZHGVt2pUnvg
 duwEfiJiz40lsQNCF04C4wBaR1jud+Rka1Ls7EpXdaYMj3JO97S0hlxXKHlhyVjpioWmWxZ+sxH
 wcGXZaYa94Xy7ZNRZ5o0teOHI38JfhVGl20pwcNJ9YERhnir1qJ+AQr2tWz+e3H4plgmuAOcbo=
X-Google-Smtp-Source: AGHT+IFT2xZ8xmF1WiC0PzUdQSR4ufjim5yJceT5qmSdP9l7hRkHm1kkZUNotoGYWuHwIqLagkELUw==
X-Received: by 2002:a17:90b:5488:b0:2ee:f687:6ad5 with SMTP id
 98e67ed59e1d1-2f2e91ae37emr6464554a91.2.1734567578369; 
 Wed, 18 Dec 2024 16:19:38 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ed0d8bb2sm2012445a91.0.2024.12.18.16.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:19:37 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:19:30 +1000
Message-Id: <D6F8VXA2IAHU.2UYVFKMDYZECY@gmail.com>
Cc: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "BALATON
 Zoltan" <balaton@eik.bme.hu>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 4/7] hw/ppc/spapr: Convert HPTE_DIRTY() macro as
 hpte_is_dirty() method
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-5-philmd@linaro.org>
In-Reply-To: <20241218182106.78800-5-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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
> Convert HPTE_DIRTY() macro as hpte_is_dirty() method.
> Since sPAPR is in big endian configuration at reset,
> use the big endian LD/ST API to access the HPTEs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

All the other helper changes look good +/- suggestions from the
first one.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/spapr.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b67ab1ee685..5bc49598a97 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1411,7 +1411,11 @@ static bool hpte_is_valid(SpaprMachineState *s, un=
signed index)
>      return ldq_be_p(hpte_get(s, index)) & HPTE64_V_VALID;
>  }
> =20
> -#define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_H=
PTE_DIRTY)
> +static bool hpte_is_dirty(SpaprMachineState *s, unsigned index)
> +{
> +    return ldq_be_p(hpte_get(s, index)) & HPTE64_V_HPTE_DIRTY;
> +}
> +
>  #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &=3D tswap64(~HPTE64_=
V_HPTE_DIRTY))
>  #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |=3D tswap64(HPTE64_V=
_HPTE_DIRTY))
> =20
> @@ -2257,7 +2261,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
> =20
>          /* Consume non-dirty HPTEs */
>          while ((index < htabslots)
> -               && !HPTE_DIRTY(hpte_get(spapr->htab, index))) {
> +               && !hpte_is_dirty(spapr->htab, index)) {
>              index++;
>              examined++;
>          }
> @@ -2265,7 +2269,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          chunkstart =3D index;
>          /* Consume valid dirty HPTEs */
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
> -               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && hpte_is_dirty(spapr->htab, index)
>                 && hpte_is_valid(spapr->htab, index)) {
>              CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
> @@ -2275,7 +2279,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          invalidstart =3D index;
>          /* Consume invalid dirty HPTEs */
>          while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
> -               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && hpte_is_dirty(spapr->htab, index)
>                 && !hpte_is_valid(spapr->htab, index)) {
>              CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;


