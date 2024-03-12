Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED21C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxvY-0007zI-P9; Tue, 12 Mar 2024 04:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxvS-0007wE-Bn; Tue, 12 Mar 2024 04:55:59 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjxvP-0006ug-C4; Tue, 12 Mar 2024 04:55:58 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5a1bd83d55dso2076615eaf.2; 
 Tue, 12 Mar 2024 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710233753; x=1710838553; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5esw4tNvb5auHbgZ/4nQS4xcFRaNBbal7bf8Cd4HTyY=;
 b=Mvby+lwyKaPNC5zyFltupTiCJDlirgHp+ybZg2+lWhMm8eoizJCbFgXGoXrQ9SdKyh
 MTZZVPY8s2ssl2OsSB/MS7GAAgl04C+0QCHCS4cVMgf3vQD+f3UT0/7+ZtJaeCepMER9
 ECSi2MTwybnRnmPpH3RUrpmPpMeCgxs1gboC2dH+JdA+oFk+DNUhRECSf+lWG4/9vfGj
 fVDYoADyTDEbFj37tK6fWypgBMa0u5chXmUpIlND9pCn1W06lQ+IXVICj/i4+eisICPN
 rnMm+DfUULPq3bsGcXgftn1CgBRMj5DawPB+GMi1tTVb14o6iM/lafGhLQ61qFGR87me
 3tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710233753; x=1710838553;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5esw4tNvb5auHbgZ/4nQS4xcFRaNBbal7bf8Cd4HTyY=;
 b=LxJgphZOl2oESIsTIZsjS1itnffixeisFF+pjT/7a8zE1FlrY8P9nusrfZzsbebxhD
 e8/MxJEhLrE3SaInrCaDbhABnWvjq21AeOPI72xMrqJtA3WpxExmH9fV0X2ZlM0owGI2
 krD4xOUVCK1lpqiw5UdLViTi8SVSRc3YNnhIJNQU86HthIegUZK7YiUjtAs58z18LCkv
 ElQcM5DuiV+5FZUGNefUnSL37api3o26ZDE52lHYaWJ+uanhkIG1vCwLlp8TN8eb3dvj
 TqSGjWyk4F/ja+O211EOwchwOBEHCG94VzChstv3QM3G2mViQLyDIHWcWSxwrwfkWPOH
 Dt1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUVNUpEzqFQISjeCAlsfGLH9q60bxrWvQJA55txFUjxCovpe4iY/cKoaAOwJg1mHZTvl4kWIWN1UgQamiMhDj/a+h7
X-Gm-Message-State: AOJu0Yyj5y4E2aG+Jhi6tzNHuygVDk1uvBHo95izG5JuIAtKTkJ3q16l
 +Vt5xMVQi4rUCEC9hEkORL6K2VzAOwh4h2qSmd0iOBdqWtUSpolq
X-Google-Smtp-Source: AGHT+IE3cNjJ4asQ09aTEmHiUZtsJSuvikF9mtVwBb+OaagcBNEqsHH4KCiWnxNSDAiRB7aPiCTXTA==
X-Received: by 2002:a05:6358:789:b0:17b:5c7b:2d24 with SMTP id
 n9-20020a056358078900b0017b5c7b2d24mr11534876rwj.1.1710233753453; 
 Tue, 12 Mar 2024 01:55:53 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 c8-20020a654208000000b005dc49afed53sm4885990pgq.55.2024.03.12.01.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:55:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 18:55:48 +1000
Message-Id: <CZRN9LQ7KX7O.3LVY9BPQCGK15@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 02/13] target/ppc: POWER10 does not have transactional
 memory
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-3-npiggin@gmail.com>
 <df3f326b-2519-4a0b-9734-f425a9ba0972@linux.ibm.com>
In-Reply-To: <df3f326b-2519-4a0b-9734-f425a9ba0972@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue Mar 12, 2024 at 6:10 PM AEST, Harsh Prateek Bora wrote:
> Hi Nick,
>
> One query/comment below:
>
> On 3/12/24 00:21, Nicholas Piggin wrote:
> > POWER10 hardware implements a degenerate transactional memory facility
> > in POWER8/9 PCR compatibility modes to permit migration from older
> > CPUs, but POWER10 / ISA v3.1 mode does not support it so the CPU model
> > should not support it.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/ppc/cpu_init.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> > index 572cbdf25f..d7e84a2f40 100644
> > --- a/target/ppc/cpu_init.c
> > +++ b/target/ppc/cpu_init.c
> > @@ -6573,7 +6573,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *da=
ta)
> >                           PPC2_FP_TST_ISA206 | PPC2_BCTAR_ISA207 |
> >                           PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> >                           PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 =
|
> > -                        PPC2_TM | PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA=
310 |
> > +                        PPC2_ISA300 | PPC2_PRCNTL | PPC2_ISA310 |
> >                           PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206;
> >       pcc->msr_mask =3D (1ull << MSR_SF) |
> >                       (1ull << MSR_HV) |
> > @@ -6617,7 +6617,7 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *da=
ta)
> >       pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |
> >                    POWERPC_FLAG_BE | POWERPC_FLAG_PMM |
> >                    POWERPC_FLAG_BUS_CLK | POWERPC_FLAG_CFAR |
> > -                 POWERPC_FLAG_VSX | POWERPC_FLAG_TM | POWERPC_FLAG_SCV=
;
> > +                 POWERPC_FLAG_VSX | POWERPC_FLAG_SCV;
> >       pcc->l1_dcache_size =3D 0x8000;
> >       pcc->l1_icache_size =3D 0x8000;
> >   }
>
> Shouldn't we also have below change included with this:
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index aac095e5fd..faefc0420e 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6641,7 +6641,6 @@ POWERPC_FAMILY(POWER10)(ObjectClass *oc, void *data=
)
>                           PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206 | PPC2_ATTN;
>       pcc->msr_mask =3D (1ull << MSR_SF) |
>                       (1ull << MSR_HV) |
> -                    (1ull << MSR_TM) |
>                       (1ull << MSR_VR) |
>                       (1ull << MSR_VSX) |
>                       (1ull << MSR_EE) |

I think you're probably right. I'll do some testing...

Thanks,
Nick

>
> Otherwise,
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>


