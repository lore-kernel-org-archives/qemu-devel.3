Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBF6C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmo5f-0000Mr-Ns; Wed, 20 Mar 2024 01:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmo5e-0000M9-9N; Wed, 20 Mar 2024 01:02:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmo5b-0001ds-F6; Wed, 20 Mar 2024 01:02:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e0000cdf99so29145685ad.0; 
 Tue, 19 Mar 2024 22:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710910930; x=1711515730; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+7K0Md06lhwYdTHIPdZxgx+2diuhuPSbvAA08kGREY=;
 b=hR4W65AuYOQ1O4hxxv/ykPlsz6tgtbwxl362Gw5DMJyEkNDhZttE4GGbPGVqrEdMsq
 +LswmDVNQlH1+i47hlDCQKvitJGcYdYTSiNkbmxDDxtOLmTkZxwH2/1Lqwnmqjf23ypX
 k6nulucW+bN4cQYY8I35zAQaOxeVUNvAATqGjjAH9gA10Kcx2O2gG6yF18tuoSpnCkd9
 7FGUh1TRct0B1QJzKamRUSG2M5++aL48wBilNivaDg0oc/HngurMndEmAciqCEeRcIMT
 /VFcZ8qkAkaL2H4+3K2kSLCFazmA2Jqwt7FoDlbYTLhhZT+nFDFmJ7822KpuHB+DoA6t
 e8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710910930; x=1711515730;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M+7K0Md06lhwYdTHIPdZxgx+2diuhuPSbvAA08kGREY=;
 b=bgA4+LI2rqRD1TVgdS/LRoo+VHheh5aBSGy4Su/kJQHJbbnhoMXptxgDXJ1ef1sHzR
 /J6MnnbCON9hpgzds3lotFFLy+xNyFQpm56X/oNChugmNhVdcOBPSB5vjSa9lxJy/ZIx
 EsYgTHFtrgo3Sk6zWoBoIq/Ge1NI56uhXXCNR4mOMclz9DYggovwenwz6BXN/76GJtk9
 QuOeDRWS8/a1wZB4iCQe/7F03Xdfibng3M3uRBUYb2mRQ1EtcBPSh4ICXFVK4NpE/84t
 vpl+4ZUrUGkiv53EKKzALlDx95yK4Xn7GLg3vDanb3zA/T08w+2H/5mlLGUO/XBG5B8L
 7jag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVJW82wKFCnrQXksxVggfPTEpp1VaYFSNjHQU2uXqu/X1AGNuvmnfkSC6gnLVN5RsbAr33Q5d2p+n8R4m/OJx40oHQLg4=
X-Gm-Message-State: AOJu0YyEk0Z4myr1M2U5pFRtsVUar/3mZGL3EYtHGy3Ki4lXiHest/PM
 Lk3Tty94Vob8Y/j9TGseM7U/JY79t12CdNw1oFuzGZl0NdlpU4OZ
X-Google-Smtp-Source: AGHT+IFsdjpFe2cKfB/ida8cPqmszHBY+9L3cFyIpFB7kn9aDkkGoIvZAMptuuUPz6yvTRyUK4XbIw==
X-Received: by 2002:a17:902:ea04:b0:1df:fbc3:d131 with SMTP id
 s4-20020a170902ea0400b001dffbc3d131mr14979280plg.27.1710910929636; 
 Tue, 19 Mar 2024 22:02:09 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 t22-20020a170902b21600b001ddd5e158bdsm6673807plr.284.2024.03.19.22.02.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 22:02:08 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 15:02:04 +1000
Message-Id: <CZYBAZXPSNVO.2TEDFF2Z4H56R@wheely>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, "Anton Johansson" <anjo@rev.ng>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Leandro Lupori" <leandro.lupori@eldorado.org.br>
Subject: Re: [PATCH] target/ppc/mmu-radix64: Use correct string format in
 walk_tree()
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240319051021.6752-1-philmd@linaro.org>
 <5f94eca5-8606-43d4-8599-89316d951e7e@linaro.org>
In-Reply-To: <5f94eca5-8606-43d4-8599-89316d951e7e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

Thanks, I can put this in the ppc tree.

Thanks,
Nick

On Tue Mar 19, 2024 at 4:30 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> +Anton
>
> On 19/3/24 06:10, Philippe Mathieu-Daud=C3=A9 wrote:
> > 'mask', 'nlb' and 'base_addr' are all uin64_t types.
> > Use the corresponding PRIx64 format.
> >=20
> > Fixes: d2066bc50d ("target/ppc: Check page dir/table base alignment")
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   target/ppc/mmu-radix64.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> > index 5823e039e6..690dff7a49 100644
> > --- a/target/ppc/mmu-radix64.c
> > +++ b/target/ppc/mmu-radix64.c
> > @@ -300,8 +300,8 @@ static int ppc_radix64_next_level(AddressSpace *as,=
 vaddr eaddr,
> >  =20
> >           if (nlb & mask) {
> >               qemu_log_mask(LOG_GUEST_ERROR,
> > -                "%s: misaligned page dir/table base: 0x"TARGET_FMT_lx
> > -                " page dir size: 0x"TARGET_FMT_lx"\n",
> > +                "%s: misaligned page dir/table base: 0x%" PRIx64
> > +                " page dir size: 0x%" PRIx64 "\n",
> >                   __func__, nlb, mask + 1);
> >               nlb &=3D ~mask;
> >           }
> > @@ -324,8 +324,8 @@ static int ppc_radix64_walk_tree(AddressSpace *as, =
vaddr eaddr,
> >  =20
> >       if (base_addr & mask) {
> >           qemu_log_mask(LOG_GUEST_ERROR,
> > -            "%s: misaligned page dir base: 0x"TARGET_FMT_lx
> > -            " page dir size: 0x"TARGET_FMT_lx"\n",
> > +            "%s: misaligned page dir base: 0x%" PRIx64
> > +            " page dir size: 0x%" PRIx64 "\n",
> >               __func__, base_addr, mask + 1);
> >           base_addr &=3D ~mask;
> >       }


