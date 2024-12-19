Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18386E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 00:20:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO4Gc-0007bZ-DD; Wed, 18 Dec 2024 19:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4Ga-0007aw-AN; Wed, 18 Dec 2024 19:19:48 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tO4GY-0005tJ-Pd; Wed, 18 Dec 2024 19:19:48 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2efe25558ddso154683a91.2; 
 Wed, 18 Dec 2024 16:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734567585; x=1735172385; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhIgTtZyrOmOecrGSqoZnbKty4Bie4r8MhD47NeUc9o=;
 b=H+8lwkiE9NdpY3w8DksMxI/2cPsOBVpJK8BCfcmjQqUu4kV/QQ9CsVXOQ2T1ETKiv3
 mUuR9wHtOfVBNtbEJ5LmTTbjYR7AZU4oXyOMxhAPCM5bRXYkyHp+RVbXxqaopoEwGAnV
 iWvj4JQTvhFntDaHHfBr0Mj/CaBh2Zj7oqtQsUGjiAZAftGzmCtBWATsz8prj929Qy7i
 f0FU/toPzMmg0U40jjoKNCK0RyNUrgkziB1g6sGqHvrH90g++EiLd3rWl7SsYeZmPSMn
 3s5cQ79DNYUzWraduFDH4k2F15fNj4HZx/+lKe8FxgEgEljPuvDb7VREWfpe6F/c8QHw
 1p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734567585; x=1735172385;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LhIgTtZyrOmOecrGSqoZnbKty4Bie4r8MhD47NeUc9o=;
 b=okJXBh1VmStn0yzfrGFyN4urNyNJWbb+zxQlwmsOvCkXkMOEtJ4fRzd9eiM7j8ZLLr
 pl9QQhy/bHeZdb/cg1A+bP5URJd90f2NzFhqDq0fM39Lwxfk5Tf6sovOeTVAnd9L1IBB
 FEXISmtB5S2CtzhwtIgPVIJDA8SltMZ6MZ+mkBB0fW9hiyyOUWm38X+/Jg9KLL292k5O
 HHD+CIhc6PsE5GblqkgApzbQDB+bMJoTtp6jtY0Dn+SJLsrIi/Sue+o7I5gv0/d9+5c4
 nh1cMpt+12k79EBx3gPQulwEpbSLeGmjcaaEsCuJBu5vfx1V6gmrVdIIXgcKJdViSdjq
 ioOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPhKvSTwpm5iWhD/fUTEEDoiEmp3asWSzzEwj+klMR5uVbGLAxJW6NENRKcH9tpBi78nRf85uieoo+@nongnu.org,
 AJvYcCWwlaLKqoIV4ZjXdZjjAisx9AJSXdxcTgFg//W5vMQchiqSYkpZt4bbd4fsGUFxCN1Vn7iUoHeFG0Q=@nongnu.org
X-Gm-Message-State: AOJu0Yya9RVuJunHCYz8GbYS7uTBQUXctPhy5/cCU4iQtZIrx6lumdVl
 HTJ+MTFS+UoWVgJeIln8fiBP/M6Btzpco8ETOeQtPKidMFWDoVTh
X-Gm-Gg: ASbGncvVIfFhN5oaLPUrx1WcayTWpZ0p2fWR5soiR6Uim7FbexDf13vBvqMskkyGoNW
 KLxdAMNtFjEKyz5En+unrvSI5v3pdEqFQkUdDYn7kA3MdSRh9Plp5NPy0wiuXlHL4yHWDxmxoKa
 CRwQCzG+/DHVd4DbixTUw6hpa6yzDzUwE8V2Rx5mu2PFAT4jTQPVp9BGmQtxXpRh/CBdq19riM3
 rcL4Ob9KUV5fopKessuFD6crct+H4vqWqW+QRNXp8ZsFYTaX2E/QDeh9xIQBSfYb29za60oP9E=
X-Google-Smtp-Source: AGHT+IHD5lSNnA0KFm2NP19l11Wgyrgyk3Aeps8NehAkIWs6KKEEE0ir+YWci5ID+ICF1p8bOZVftw==
X-Received: by 2002:a17:90b:4c47:b0:2ee:8031:cdbc with SMTP id
 98e67ed59e1d1-2f2e935564amr5553754a91.23.1734567584879; 
 Wed, 18 Dec 2024 16:19:44 -0800 (PST)
Received: from localhost (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm2211424a91.32.2024.12.18.16.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 16:19:44 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Dec 2024 10:19:37 +1000
Message-Id: <D6F8W0OQNXFJ.SZMJXYGHZL5Y@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "BALATON
 Zoltan" <balaton@eik.bme.hu>, <qemu-ppc@nongnu.org>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Peter Maydell" <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 5/7] hw/ppc/spapr: Convert CLEAN_HPTE() macro as
 hpte_set_clean() method
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241218182106.78800-1-philmd@linaro.org>
 <20241218182106.78800-6-philmd@linaro.org>
In-Reply-To: <20241218182106.78800-6-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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
> Convert CLEAN_HPTE() macro as hpte_set_clean() method.
> Since sPAPR is in big endian configuration at reset,
> use the big endian LD/ST API to access the HPTEs.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/ppc/spapr.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5bc49598a97..4e1fe832c29 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1416,7 +1416,12 @@ static bool hpte_is_dirty(SpaprMachineState *s, un=
signed index)
>      return ldq_be_p(hpte_get(s, index)) & HPTE64_V_HPTE_DIRTY;
>  }
> =20
> -#define CLEAN_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) &=3D tswap64(~HPTE64_=
V_HPTE_DIRTY))
> +static void hpte_set_clean(SpaprMachineState *s, unsigned index)
> +{
> +    stq_be_p(hpte_get(s, index),
> +             ldq_be_p(hpte_get(s, index)) & ~HPTE64_V_HPTE_DIRTY);
> +}
> +
>  #define DIRTY_HPTE(_hpte)  ((*(uint64_t *)(_hpte)) |=3D tswap64(HPTE64_V=
_HPTE_DIRTY))
> =20
>  /*
> @@ -2213,7 +2218,7 @@ static void htab_save_first_pass(QEMUFile *f, Spapr=
MachineState *spapr,
>          /* Consume invalid HPTEs */
>          while ((index < htabslots)
>                 && !hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);
>              index++;
>          }
> =20
> @@ -2221,7 +2226,7 @@ static void htab_save_first_pass(QEMUFile *f, Spapr=
MachineState *spapr,
>          chunkstart =3D index;
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
>                 && hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);
>              index++;
>          }
> =20
> @@ -2271,7 +2276,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          while ((index < htabslots) && (index - chunkstart < USHRT_MAX)
>                 && hpte_is_dirty(spapr->htab, index)
>                 && hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);
>              index++;
>              examined++;
>          }
> @@ -2281,7 +2286,7 @@ static int htab_save_later_pass(QEMUFile *f, SpaprM=
achineState *spapr,
>          while ((index < htabslots) && (index - invalidstart < USHRT_MAX)
>                 && hpte_is_dirty(spapr->htab, index)
>                 && !hpte_is_valid(spapr->htab, index)) {
> -            CLEAN_HPTE(hpte_get(spapr->htab, index));
> +            hpte_set_clean(spapr->htab, index);
>              index++;
>              examined++;
>          }


