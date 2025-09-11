Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D09CA1016
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 10:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uweAI-0008LU-AF; Thu, 11 Sep 2025 06:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uweAG-0008LA-CB
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:04:28 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uweAD-0006gZ-Af
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 06:04:28 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-5fe42994547so188011d50.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757585061; x=1758189861; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=90Hq1/SkzrOr12kzW5mjFU3ZDT8bRGSr2u7/iNn9v10=;
 b=w7hf6IoFpDD3b7cmTx+Ev135GoftK5LkQ+5X9ZLlAd6nbeESBdBoTCOERV4rOPaxQa
 8OBt+aX8eGCSXJr3n4ZZGk1j3semGgyY5tjM4uowe6nBq1WQMFBRoagZdMCgNQLGRE82
 0IHfYpp2BRl6kRDFnnLIcSFSWnVw1IGMT+Lic073m0N9Q3BYMroAyZySI/te/zP/NdcF
 xdktbaaCKDlHKDQnwbBzkZE3iJaHNAm4D+iDut3R13//IdPajfXvUEX6WJm9pNjOpMGv
 MbiqtOMq/n4+F6JvKwyow4otDazLWy/HXsMHz2vsQZ8wKtw1z3CgyKMljuAsUTzoT43t
 Whyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757585061; x=1758189861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=90Hq1/SkzrOr12kzW5mjFU3ZDT8bRGSr2u7/iNn9v10=;
 b=TfsimdWzZd5LMyWPWZqylTbF1v6LwSYvJI1U2gPptOWhd+0gV0dv91SbD4JyJSe0cY
 dinp6c5RN3X1gkMx8o9JlXyjVE3ZsEtR9LNXDEfjyJtVh66yoSuzk45TOQUFN0R36/rF
 dYsXw9o+bOb/Ob/qS+rHumTjyQF64bUyo9/xvoOt4W7aeCkdZyiwN2Ary1Ej4OArDmX9
 haanRdabs3De4Wva41QWDU1sNcj6otJm7R41TiKaEKlbY11pZH4oZ/HaUou9MRSSjkKc
 Wp3tJMb3uCgBukOLSaPiEN3zrSk8VbFU2HOfO1KBjsp0lJlZLI+IOxAOWWfWqkFKzALj
 54Nw==
X-Gm-Message-State: AOJu0YxxrAQ1LKD0FRLJcLJs98dgr5s1Oc+IM6UxYJRB8/CHGag9Q27o
 xXT5kvpAwEi+DtBdv29dQakBjGipEVCxknj+JAeyeuquLZDfgMfu/v4bfSdt3QoeAPpH7K+3jDG
 paVqBnB1u+dOXJhgqCtPNoM/Gb2GYzoLboxcWnkLv1/ayRvwo9z0b
X-Gm-Gg: ASbGncvMiUJxGk0LZz51fcl9ZWaOIXAk6ZLUk5Q1avRj5DER1PgWxcUs3w/bCn5FITs
 DoLPSieMhN3kaDOnkDVizegGG4X0ZWAbUkrnfyoHy1YH1h1IzGXnbkQM7t7i9eZ0KPMS+GsdWHB
 utayv3yDEUIbViuBWZA6TcldfLccg7Y5xsslD0kg1DdTZ2cTMXPsnQrVNPCONrJs5InoofzJhsA
 Xe+yZiKFoYcBc+eMfE=
X-Google-Smtp-Source: AGHT+IGmq8Aq6iskIyTm4ls7gp6FJRYP497Ovkq7K/pSzn28jbRoyuFnTkQRly5P69A8gkXQbrXSEp+Td84ektfxEFI=
X-Received: by 2002:a53:d010:0:b0:5fc:f3a:58b3 with SMTP id
 956f58d0204a3-6103602c465mr11449643d50.36.1757585061215; Thu, 11 Sep 2025
 03:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250908105005.2119297-1-pbonzini@redhat.com>
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Sep 2025 11:04:09 +0100
X-Gm-Features: Ac12FXx__Gdlp_HGN1M7neeZPDPF0L9fZenRW7Eb2HDsHU4uwET_BGeQYHmkAUI
Message-ID: <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 8 Sept 2025 at 11:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> This includes:
> - bumping MSRV to 1.83.0 to support const_refs_to_static
> - Zhao's safe, builder-based implementation of migration callbacks
> - Manos's qdev properties macro.  While bit-based properties are
>   not yet supported, that's a small change overall.
> - the Rust crate split from Marc-Andr=C3=A9
> - adding proc macro aliases in individual crates, also from Marc-Andr=C3=
=A9
>
> I'm still not convinced about having "bql" depend on "migration",
> but I am convinced by the crate split between "util" and "bql",
> so we can move the implementation of VMState from "bql" to
> "migration" later if needed.
>
> For the purpose of getting this in as an easy-to-use base for future
> development, I'm disabling CI from Debian and Ubuntu.  The plan is:
> - that Debian will require trixie to enable Rust usage
> - that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
>   (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318)
> - that Marc-Andr=C3=A9 or someone else will add Rust to other CI jobs

How far into the future does moving to 1.83.0 push our
"we can enable rust and make it mandatory" point? I was
hoping we would be able to do that sometime soon but this
sounds like we're going to be still a long way out from that :-(

-- PMM

