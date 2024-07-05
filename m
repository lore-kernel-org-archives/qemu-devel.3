Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58001C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 00:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPWZB-0000dp-IA; Thu, 04 Jul 2024 20:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPWZ9-0000ca-5Q; Thu, 04 Jul 2024 20:12:43 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPWZ7-0005Nn-Eo; Thu, 04 Jul 2024 20:12:42 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70b09c2ade6so361350b3a.3; 
 Thu, 04 Jul 2024 17:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720138357; x=1720743157; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uasc17TAA4Jrrw9cfgtG0RfCtZeveAw/SK/AYpjogvs=;
 b=T79XLfvMli37USuD2n1xyVOMHdZbQewUAMERnpYQlaD5ynw97At3pf9WxWvb39XGoo
 2WYhpDTy3gQZk7fgbhY8tw0x+NDpbaHmy827VSxglyCqfcJYSoYEebuRtNuvKhOIVuYp
 D8z2Gs7gf3/EUlhmz8nCr02Y4HQP+B85Y8bbOG9B44CA7HJ9I/1+AJuJJ7NBiOqc9bJ1
 Ll+0qxehjviBQCdDZVTcRF/CJYaFW7e1H+++5QdTxj/EzauvoEwc0/D78H55047BOUzm
 +ESBrj2Kux3E2od48DrouQBHaEhuypMrkTdRbGMQ0zYhljEIDSVSKKcLBLJEc5C3he9b
 8qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720138357; x=1720743157;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Uasc17TAA4Jrrw9cfgtG0RfCtZeveAw/SK/AYpjogvs=;
 b=q4h08N5xKWtUSG8gKYlSvDlqbmYxKu3L3q0OU4NiN7M19USuyEX1vFa3yYay9zqZel
 ZtvEkT3qIi/MC7e1ajKH6mS4BAfIBlHhTqWnJ4+tKhyWEYmGPyuiX5mtDuVGunFVKUx2
 usN2ebkHvwbpIxJ2xlHdOnfzYCU/g4GIk77RdLbn+MNmXhoRwFWeJHVsjBebJCzOv8o5
 VBztcLYLkXUpUrm49O42x0ssq9vLxxNn4RnwWSshBT14U+SHgeoP1XljVDEgVPCDaq5+
 7vpwp4LYoT+FHDGV+Jjpb5KwGahn0QnnUa8zdmnxW9Mk0mHa4t1LmlM0C6F7y5PD6P+8
 L5yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP7SA5Wf/PDjYDgjNVbBSkcFHluTgrgPliSpPuDdFS6Ai7n0rl1UWIoSr03ZcJH/962KhXhDwHxbDrO3peeM4mPm8g
X-Gm-Message-State: AOJu0Yw34n9Dj1F8agI5ajaA41TPHR0QxeQuR522URIVvIIGcI7C6lSC
 e6gnOJCGJTMR7rZTB53Wf04Fvvqfmd2UlZUA8n/kgPFUtMCEmYqKb9sN8g==
X-Google-Smtp-Source: AGHT+IH04EQiGaGqaPLPKGdt6mFWBNAtpJc8X71XLbTayE+Fs6VcH2kPHAxYqvtywpS3BIGyPEM/GA==
X-Received: by 2002:a05:6a00:b54:b0:70a:f3de:3e7 with SMTP id
 d2e1a72fcca58-70b00b01fc3mr3514348b3a.32.1720138357437; 
 Thu, 04 Jul 2024 17:12:37 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b0b8d2da1sm425997b3a.133.2024.07.04.17.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 17:12:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Jul 2024 10:12:32 +1000
Message-Id: <D2H65LWAL3BP.6XTGYD3BEI5H@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 11/43] target/ppc/mmu_common.c: Remove pte_update_flags()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <87df776b2534cc0ad2523d17c99453edb5de3459.1716763435.git.balaton@eik.bme.hu>
 <D2GJ736YGATJ.2B6B20NSYPM4K@gmail.com>
 <8f2565ea-b02d-c1c9-0466-e4994a01b0b9@eik.bme.hu>
In-Reply-To: <8f2565ea-b02d-c1c9-0466-e4994a01b0b9@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

On Thu Jul 4, 2024 at 10:34 PM AEST, BALATON Zoltan wrote:
> On Thu, 4 Jul 2024, Nicholas Piggin wrote:
> > On Mon May 27, 2024 at 9:12 AM AEST, BALATON Zoltan wrote:
> >> This function is used only once, its return value is ignored and one
> >> of its parameter is a return value from a previous call. It is better
> >> to inline it in the caller and remove it.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/mmu_common.c | 41 +++++++++++++---------------------------=
-
> >>  1 file changed, 13 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> >> index e3537c63c0..c4902b7632 100644
> >> --- a/target/ppc/mmu_common.c
> >> +++ b/target/ppc/mmu_common.c
> >> @@ -119,39 +119,14 @@ static int ppc6xx_tlb_pte_check(mmu_ctx_t *ctx, =
target_ulong pte0,
> >>      }
> >>  }
> >>
> >> -static int pte_update_flags(mmu_ctx_t *ctx, target_ulong *pte1p,
> >> -                            int ret, MMUAccessType access_type)
> >> -{
> >> -    int store =3D 0;
> >> -
> >> -    /* Update page flags */
> >> -    if (!(*pte1p & 0x00000100)) {
> >> -        /* Update accessed flag */
> >> -        *pte1p |=3D 0x00000100;
> >> -        store =3D 1;
> >> -    }
> >> -    if (!(*pte1p & 0x00000080)) {
> >> -        if (access_type =3D=3D MMU_DATA_STORE && ret =3D=3D 0) {
> >> -            /* Update changed flag */
> >> -            *pte1p |=3D 0x00000080;
> >> -            store =3D 1;
> >> -        } else {
> >> -            /* Force page fault for first write access */
> >> -            ctx->prot &=3D ~PAGE_WRITE;
> >> -        }
> >> -    }
> >> -
> >> -    return store;
> >> -}
> >> -
> >>  /* Software driven TLB helpers */
> >>
> >>  static int ppc6xx_tlb_check(CPUPPCState *env, mmu_ctx_t *ctx,
> >>                              target_ulong eaddr, MMUAccessType access_=
type)
> >>  {
> >>      ppc6xx_tlb_t *tlb;
> >> -    int nr, best, way;
> >> -    int ret;
> >> +    target_ulong *pte1p;
> >> +    int nr, best, way, ret;
> >>
> >>      best =3D -1;
> >>      ret =3D -1; /* No TLB found */
> >> @@ -204,7 +179,17 @@ done:
> >>                        " prot=3D%01x ret=3D%d\n",
> >>                        ctx->raddr & TARGET_PAGE_MASK, ctx->prot, ret);
> >>          /* Update page flags */
> >> -        pte_update_flags(ctx, &env->tlb.tlb6[best].pte1, ret, access_=
type);
> >> +        pte1p =3D &env->tlb.tlb6[best].pte1;
> >> +        *pte1p |=3D 0x00000100; /* Update accessed flag */
> >> +        if (!(*pte1p & 0x00000080)) {
> >> +            if (access_type =3D=3D MMU_DATA_STORE && ret =3D=3D 0) {
> >> +                /* Update changed flag */
> >> +                *pte1p |=3D 0x00000080;
> >> +            } else {
> >> +                /* Force page fault for first write access */
> >> +                ctx->prot &=3D ~PAGE_WRITE;
> >
> > Out of curiosity, I guess this unusual part is because ctx->prot can ge=
t
> > PAGE_WRITE set in the bat lookup, then it has to be cleared if the PTE
> > does not have changed bit?
>
> I have no idea. I was just trying to clean up this code to make it simple=
r=20

Yeah that's fine I wouldn't expect it to change here, just wondering
if you'd dug into it more. I *think* that is the reaon for it.

Thanks,
Nick

> with this series. I think historically there was a single function that=
=20
> handled all models but as these became too different it was split up by=
=20
> MMU models. It could be some of this are remnants of some old code where=
=20
> some other model needed it and not needed any more or this could be merge=
d=20
> with hash32 but I did not try to find that out, just try to make sure not=
=20
> to break it any more than it might already be broken.
>
> Regards,
> BALATON Zoltan
>
> >> +            }
> >> +        }
> >>      }
> >
> > Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >
> >>  #if defined(DUMP_PAGE_TABLES)
> >>      if (qemu_loglevel_mask(CPU_LOG_MMU)) {
> >
> >


