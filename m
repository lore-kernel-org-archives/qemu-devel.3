Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBD7E77188
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO46D-00056T-M0; Wed, 18 Dec 2024 19:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO46B-00056D-VP; Wed, 18 Dec 2024 19:09:03 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO46A-0003dW-AK; Wed, 18 Dec 2024 19:09:03 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-801986033f9so82693a12.1; 
 Wed, 18 Dec 2024 16:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734566940; x=1735171740; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAsxzxOr17lkrC4pQ7i71WO439rWRHpzOoMZLGMA1VM=;
 b=KliTkC9EcnDyt2e3f0Rtt9XZWwGjhS0aDIgem2+cSBt+UsrXXkI6MOylFcmc6eyKv3
 2JuFWKFUdObAJL2JuaedXGEMu3bG1bhJZ+7cLachIsr5xF9QWYYlgpz9ycHyQsWmX94X
 mtuHYhMLUP6l2Jpqo4iuayJcJFr4+EIglrkJbWXwAI3IMyESmM5z+7auYcqCaAU/uNun
 2xc/HlPVXkRPz00f0wCNywJzCMrQU1REQLHtbzGkF9FGeoea3AdajPxw18aj9AxRGW6y
 KXprb+p3NkNrsTxhlEkh9z9eJ7/r2U1yNuZ4PW2ljc2BT+AoOrQBeRoSURqzz4m3b0nL
 oEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734566940; x=1735171740;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aAsxzxOr17lkrC4pQ7i71WO439rWRHpzOoMZLGMA1VM=;
 b=SSeV06uuFoRdxm7L1ufSMoavlEGkAR2k0LrbVvcxcIoafNnem93piJbaCwQT6a3YGl
 eNRKfZrIlSjeoPSvDLLBPYRNYCcwwBvKEoxGW87QTs9wekBr+YqsX0UzaHnJDnmOrKMe
 fGkQA8YdNoZV1h+53iYHg1XYhS+XOu1VuouF9mM83DHeeqA23ebxSrVyRIpi/qjjhsD1
 f3dLM1N9n0gIDJWiikERZTtP4wcc9x/bqDUUq707ZzfcMK2rGQB126PWVol5BnhpTxrK
 poaCbxTPyMn8wkS5emCWgPtQTuBgPMUd4GN/xeBQvsLqR4ZWNrWt2zGqaKV9zrGaOZJj
 wxYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1EpTV9ybxCFY+IRhYh6NqJk2uNI4Rvg/9qsay/SqBiacY3mfbjZ5d8fzeSMO7TklS9M+W6YX646I=@nongnu.org,
 AJvYcCVxnLDdmnNruc6HkrdbM3zxp0h7mel4A9/J9ILb/1FeMbhjePiNk8032bcN4fZ68DBiQkAS/ZgN9q5M@nongnu.org
X-Gm-Message-State: AOJu0YynHQxBVFra7Sof9I4uvC+UX4xXvAHsAyrMur5gss3k9bW9shPg
 gTKOIbC6gZOnYKrPgrPx37aXCCaPcpeJnkp2L3TydMkeVOURjAPp
X-Gm-Gg: ASbGncsoim+VEUUM8zZoSDw3igTdrvP+dDY9Q5yCf50bPNs2tYPDQ6b2N8kJ9lKgNEJ
 Zz1kQjfWx2WLO404jOYfi6Xqt5/6ZqnNnWSxCvBQO1Y07KpHWBP1XX/0E+JCik3Dt6vFB61AWyw
 Gtf3e/t/PxbbFRhARt4rL6hXZ9rAQLhLRgebNaQ9W3ZEoZDF4v6e3ux1nQD/mWzojoyocvE18CG
 yNX2JjQreIClU/VxDKvu2Zmm+Kgl4Bt3nitq/crQrIGUQFnRfr1Jztzd6my1dI8HimhGQnioiE=
X-Google-Smtp-Source: AGHT+IEB3+em6TyMydKfOuBeF6NGXupdEyfVeace8OOsgAGwD6MMM5ke8K/90G7Ch/dJ6mMlU5dJ6w==
X-Received: by 2002:a17:90b:520d:b0:2ea:59e3:2d2e with SMTP id
 98e67ed59e1d1-2f2e91f039dmr7258567a91.10.1734566940388; 
 Wed, 18 Dec 2024 16:09:00 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f4477ec539sm95953a91.28.2024.12.18.16.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:08:59 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:08:53 +1000
Message-Id: <D6F8NSF9LK8J.BSJRM1NJJJ9G@gmail.com>
Subject: Re: [PATCH v3 2/7] hw/ppc/spapr: Convert HPTE() macro as hpte_get()
 method
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "BALATON
 Zoltan" <balaton@eik.bme.hu>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>
X-Mailer: aerc 0.18.2
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-3-philmd@linaro.org>
In-Reply-To: <20241218182106.78800-3-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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
> Convert HPTE() macro as hpte_get() method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Nitpick, could we call this hpte_ptr() or hpte_get_ptr()?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/spapr.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3b022e8da9e..4845bf3244b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1399,7 +1399,13 @@ static bool spapr_get_pate(PPCVirtualHypervisor *v=
hyp, PowerPCCPU *cpu,
>      }
>  }
> =20
> -#define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
> +static uint64_t *hpte_get(SpaprMachineState *s, unsigned index)
> +{
> +    uint64_t *table =3D s->htab;
> +
> +    return &table[2 * index];
> +}
> +
>  #define HPTE_VALID(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_V=
ALID)
>  #define HPTE_DIRTY(_hpte)  (tswap64(*((uint64_t *)(_hpte))) & HPTE64_V_H=
PTE_DIRTY)
>  #define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &=3D tswap64(~HPTE64_=
V_HPTE_DIRTY))
> @@ -1614,7 +1620,7 @@ int spapr_reallocate_hpt(SpaprMachineState *spapr, =
int shift, Error **errp)
>          spapr->htab_shift =3D shift;
> =20
>          for (i =3D 0; i < size / HASH_PTE_SIZE_64; i++) {
> -            DIRTY_HPTE(HPTE(spapr->htab, i));
> +            DIRTY_HPTE(hpte_get(spapr->htab, i));
>          }
>      }
>      /* We're setting up a hash table, so that means we're not radix */
> @@ -2172,7 +2178,7 @@ static void htab_save_chunk(QEMUFile *f, SpaprMachi=
neState *spapr,
>      qemu_put_be32(f, chunkstart);
>      qemu_put_be16(f, n_valid);
>      qemu_put_be16(f, n_invalid);
> -    qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
> +    qemu_put_buffer(f, (void *)hpte_get(spapr->htab, chunkstart),
>                      HASH_PTE_SIZE_64 * n_valid);
>  }
> =20
> @@ -2198,16 +2204,16 @@ static void htab_save_first_pass(QEMUFile *f, Spa=
prMachineState *spapr,
> =20
>          /* Consume invalid HPTEs */
>          while ((index < htabslots)
> -               && !HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>          }
> =20
>          /* Consume valid HPTEs */
>          chunkstart =3D index;
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
> -               && HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>          }
> =20
> @@ -2247,7 +2253,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
> =20
>          /* Consume non-dirty HPTEs */
>          while ((index < htabslots)
> -               && !HPTE_DIRTY(HPTE(spapr->htab, index))) {
> +               && !HPTE_DIRTY(hpte_get(spapr->htab, index))) {
>              index++;
>              examined++;
>          }
> @@ -2255,9 +2261,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          chunkstart =3D index;
>          /* Consume valid dirty HPTEs */
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
> -               && HPTE_DIRTY(HPTE(spapr->htab, index))
> -               && HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>              examined++;
>          }
> @@ -2265,9 +2271,9 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          invalidstart =3D index;
>          /* Consume invalid dirty HPTEs */
>          while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
> -               && HPTE_DIRTY(HPTE(spapr->htab, index))
> -               && !HPTE_VALID(HPTE(spapr->htab, index))) {
> -            CLEAN_HPTE(HPTE(spapr->htab, index));
> +               && HPTE_DIRTY(hpte_get(spapr->htab, index))
> +               && !HPTE_VALID(hpte_get(spapr->htab, index))) {
> +            CLEAN_HPTE(hpte_get(spapr->htab, index));
>              index++;
>              examined++;
>          }
> @@ -2449,11 +2455,11 @@ static int htab_load(QEMUFile *f, void *opaque, i=
nt version_id)
> =20
>          if (spapr->htab) {
>              if (n_valid) {
> -                qemu_get_buffer(f, HPTE(spapr->htab, index),
> +                qemu_get_buffer(f, (void *)hpte_get(spapr->htab, index),
>                                  HASH_PTE_SIZE_64 * n_valid);
>              }
>              if (n_invalid) {
> -                memset(HPTE(spapr->htab, index + n_valid), 0,
> +                memset(hpte_get(spapr->htab, index + n_valid), 0,
>                         HASH_PTE_SIZE_64 * n_invalid);
>              }
>          } else {


