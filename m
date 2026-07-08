Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44739C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whUWn-0005r8-3r; Wed, 08 Jul 2026 11:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whUWl-0005nJ-WE
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:49:36 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1whUWj-0003Wk-Jl
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 11:49:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c124c3c876aso113799066b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 08:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525772; cv=none;
 d=google.com; s=arc-20260327;
 b=GucjDrIq22aiI7q9XITwsBCcGgY5mugTh5poKmpjD+XUdNf6Kkp1C+3EKu59kz9g/A
 oz6dzGkF36F8HQ9hs1NBnycBlhiiyC6+kS2WsKV/7HZp961yAsiYs3gj/7Un33djAUMt
 uhHVy93MHDfmYR0ggtxAz6w6/gg5262KGVLdqYA7OxAEymHXGKwu/3MDvJD8DNcaRc6K
 p4+OwX0drNs0bZOY1zrDfsjGxlF71sTrIA5vwk2VNOh9PXEfwPlB8DFXHyNlNYudN3YF
 peMcdmeCUfvXenIGM1/mUVHhJFXhR/BkVtj9GbEA2k231geTilflPlmSkGSNQqO6b2ze
 OBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EmfiO5RJPK2h+5fsERKLsblUR+UBqpkmNgc8gDU5DO8=;
 fh=2ahwR7CLXGke5PPc/jgbc/HPTLmPGQsxx30u61mk6Fw=;
 b=Bra1YuyDtlVC4+BHoSnC7HsaXcFxBM4ArZeTHBRw8ufAal/1yDcTbBzAxq80rIhTat
 y/axPJcE6bxe939BsfaOHmM6vcNXFQN6iVyp9qDFtjHOD1kXo79CAUy3eDs+359i7BWx
 Vee06qPapAjb0T5FmE4WMIo00PRC/xbyIRv+csjsyLoAJbIu+GI2UpWpsjk23pGeXmy1
 0wR+sniH7pTrTO21l45YdkrZc7iw1qvRz71gfY04g5a2W2iURtn3h7mp9IKgXNUO7TN8
 CpjN+HcwcaxG7eB3GylRKOlsRUrDxyI96Fs85r9vkPY7xh6cUEr56XtxUXiaWeBy5hD7
 NX5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783525772; x=1784130572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EmfiO5RJPK2h+5fsERKLsblUR+UBqpkmNgc8gDU5DO8=;
 b=dH3x0vf2E8mPVUgUfwzOufzpmpM/GgwBMwDEv6jCy5+jm6x1JwIeX0m3IyFsXjgmSS
 6SMg9Fv6+fyWcVc8wtQrJzzzokqqCt5dWUamXiNARw3QdB7oFvoSwaRMEkQ51M6vm+BA
 AfevpmMnFf6aDIkooZeJJ9uQrAlATstVN8OJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525772; x=1784130572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EmfiO5RJPK2h+5fsERKLsblUR+UBqpkmNgc8gDU5DO8=;
 b=gVhCp160plRBGyQXuq6bwLQri7jibTb6lUCo4P+jjGpgn9ARAWMivXZDSHRXZfowFg
 FTEc7rhAQZk3ej5s9pCJEKdhczbbIMvaJR24gnmW+3fZGHJBl9ZpzgpOJtWS+AkYZ6sA
 RnGJjCoQhrgnYlVfpaVkDBSbEqJhsV64hkd1x28nlEDxvwcLTAbwYJz4RVi0Hr0x+EA/
 JoDJ+98AZx0gDCkK4/S9rVilUEuo8m/NMBxH8gg1Xx6jZlLxrdZNY8pHSvKDgZ6JmlFT
 jEDkvq6lOTDUH5zzoVB4hY6v5nizIsStQq8EvXdDXVeaz8BN1P6cHhbE5AiwOjQK46G/
 Pr0g==
X-Gm-Message-State: AOJu0Yxmo9J/oJZqSEBYKcR+6PjqggLDct9T+Y+ElJnR41FLWoHwTBbr
 zEXYpqtApnthffi/MJ8WkpzlINUhc15/SRjEEFmUn35gou6xmzhDy3+bDa+f3cMtWtdv0cpGM2r
 mnRgLPjQWLVyYTnbNHJ+1Hc4PQ38sOYRm139b4vmXTWRCies9m5XyWOI=
X-Gm-Gg: AfdE7cnmePx0fE8cNDb+u5saU4C9YAARy4vraxPXpcRUlOBa563Nb7BbCuuGa0V/SZM
 LRdHj7f2QPcgzNeeoSeSBnX2qg9LnmzHl2b/W5yYnYFadq8pPCiJeaPUDG2aUiFmhlAvsa3srzb
 6Md4UqV96lj4/1ymogUlzbOIlZq35upFHVmtrP2YJijkcB9OWuveRPvuJ+6aMtCuRaaPoZ0aExa
 FQxJ7miyZ9VoaynTzV9mPqB1AA+fXEKqLfmsZSYZAe/FLOSoLwkYKrK5xtikFz4b0pxUXnVcco3
 BZUNkNeLiydckDiJL6MD6YrFxnoX
X-Received: by 2002:a17:907:9620:b0:c12:b277:c7de with SMTP id
 a640c23a62f3a-c15ce15d571mr132063366b.61.1783525771285; Wed, 08 Jul 2026
 08:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260708134744.169452-1-alexander@mihalicyn.com>
 <87ik6ptt2e.fsf@draig.linaro.org>
In-Reply-To: <87ik6ptt2e.fsf@draig.linaro.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Wed, 8 Jul 2026 17:49:19 +0200
X-Gm-Features: AVVi8CeF3SOv3l4HN48oJpFxckY7dFbRdL5qj-o1t4RJ3UnVnn5uIuNukBygHTE
Message-ID: <CAJqdLrqrMb9FQ7jqiGwZgs49LaRiyyTveFKT0Y-MZ4ZwABsD5w@mail.gmail.com>
Subject: Re: [PATCH] mailmap: add email mapping for Alexander Mikhalitsyn
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alexander@mihalicyn.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Am Mi., 8. Juli 2026 um 17:11 Uhr schrieb Alex Benn=C3=A9e <alex.bennee@lin=
aro.org>:
>
> Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:
>
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > I use my company's email to sign-off patches, but send them from my
> > personal email cause it's Gmail hosted and works much better than Outlo=
ok.
> >
> > It causes some misunderstanding and inconvenience for maintainers somet=
imes [1].
> > So I would like to add this email mapping to clear out all possible con=
fusion here.
> >
> > Link: https://lore.kernel.org/qemu-devel/CAAjaMXabXNmh1UZ5wnpX4wucnC+yW=
vMo2-jr2XBTby4zqf6CTA@mail.gmail.com/ [1]
> > Signed-off-by: Alexander Mikhalitsyn
> > <aleksandr.mikhalitsyn@futurfusion.io>
>
> Queued to gitdm/next, thanks.

Thank you ;)

Kind regards,
Alex

>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

