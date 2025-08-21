Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45850CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up5Qx-0005vo-R2; Thu, 21 Aug 2025 09:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up5Qv-0005uc-Kx
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:34:25 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up5Qk-0007WC-PU
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 09:34:23 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e932ded97easo950742276.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 06:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755783251; x=1756388051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NA8UuRK7Z8vFSoVZJv/ETYK9qWmnvctPtmXZp4pFYko=;
 b=SV7AfYPsZWNw1hDjrrLxHSauDDQOP90yzsNdYMUD8kK2o85bKzT7zpX/ocftIF0X+/
 EFRVy9JEv95vqdJEw/XoT9cohkDogdhHctzcrLPRm5tBzWxujxNlUvvH/TcsNObdHMLQ
 WOahVd1kkIWkR6zQPbLlRyOwXCfBXViSXYPKoC0OM6F9AVGqlPxWSgPeLPbdcUCZX10V
 lU4Np1FvsWdSEJ20VhHPzKkezymMIZL+jIkJqCsfeJoeVh2hKfVDEqf8a5/7nbmOdLW+
 Vw4u9+zJHM7J3He/tIRVMrRjt9sVrc55DMkdqhTsxnaEBGXIetfaKruj7hWN1LATyMpW
 fbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755783251; x=1756388051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NA8UuRK7Z8vFSoVZJv/ETYK9qWmnvctPtmXZp4pFYko=;
 b=rgpbyF9ocqK+02lf19IkwPecgaNRY2iHdkVKIPhiafteAV2RJqzLwEwQngVjfHF7E5
 l2W76/D+J9lWInDIgWDKDzqsg+RThwzEv/HX3+7/Duf0Cz+5/qH026KtYzSGJ4UYdreA
 DYyTy+acboYe1iDoHrWi1zgO19H4fajOPzOqOLtASQlWgDNLgt943v988a5US+82mTTR
 UAg4zEoV8tjwAo6yI1nHMLRHhV1eeSoEzA5mNtNTIcCp2fkS4akpXfm8JYEW+ZaGoZu7
 k/SbHa+x/fiV2jScYnP7XBS9OF7O3wfkY/iD8/vNES800nkMoDDHY+d18y64F08j9QVp
 +0CQ==
X-Gm-Message-State: AOJu0Yy0xa7jqOszfm1tJRHtAq43jFgXWucaN84lAFthzAriTb+j2e0L
 7bunXt1ap3Vqzn6ZYEB4hmzL0Ozg7LQvT0WSZGqUmnutFYq/lVap0wRXBJzeP3Sxxyxx5dyHOyp
 BD2+Jdadb5o50a2B5xG97BOZFYecUa3zaN6Xr+7/lRw==
X-Gm-Gg: ASbGncseB5DQ01S5l1o9pUbOa0azHGXTeyaB7AWOfvTwMclEujsYjgWb+osHljMwaY7
 bg5eiAFBfuE1IvGl7lNVHX2530ybIW3sVAB5vbVx5jC3G/XdpuQXWDrDfcS9woHuPcqV5P9cV0F
 84jmzi2GA9GhbcZo4fJCPGNERKYPA/bdCRz2N5VdG+BqlwpXSSjqBVU68bOodo9Qza0I3/2aFqC
 iQLE52s
X-Google-Smtp-Source: AGHT+IFph+fuA14X7mTMyKtF93GC1qA7HNa1A5shgDlsysZ71bYlqOJ2jffoA2ntrPYqjnAiz3D/0KQ7FL9AtLgD/G8=
X-Received: by 2002:a05:6902:2689:b0:e93:46dc:41f2 with SMTP id
 3f1490d57ef6-e9509a831f8mr2776167276.47.1755783250932; Thu, 21 Aug 2025
 06:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-17-philmd@linaro.org>
In-Reply-To: <20240216110313.17039-17-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Aug 2025 14:33:59 +0100
X-Gm-Features: Ac12FXwGwOTkFp-IDxMtSb_SwGpeJUw61kCK6Ylt6WVhAINpl-CeU5xZrb54e1U
Message-ID: <CAFEAcA-aR5Hhd5uJUtptBa4wnyLUDPqbwLWdgNMfrGxo-SfDVg@mail.gmail.com>
Subject: Re: [PATCH 16/21] hw/net/can/versal: Prefer object_initialize_child
 over object_initialize
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, 16 Feb 2024 at 11:08, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When the QOM parent is available, prefer object_initialize_child()
> over object_initialize(), since it create the parent relationship.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/net/can/xlnx-versal-canfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canf=
d.c
> index 47a14cfe63..f8e4bd75e4 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1900,7 +1900,7 @@ static int canfd_populate_regarray(XlnxVersalCANFDS=
tate *s,
>          int index =3D rae[i].addr / 4;
>          RegisterInfo *r =3D &s->reg_info[index];
>
> -        object_initialize(r, sizeof(*r), TYPE_REGISTER);
> +        object_initialize_child(OBJECT(s), "reg[*]", r, TYPE_REGISTER);
>
>          *r =3D (RegisterInfo) {
>              .data =3D &s->regs[index],
> --

Hi -- I was just looking at this function since ASAN
reports a leak in it. I notice that this patch never got
applied -- any reason why?

Also, though, we call object_initialize(r, ...) and then
we immediately do "*r =3D { some struct }" which entirely
overwrites the initialization we just did. I guess that
should instead be initializing the individual fields...

-- PMM

