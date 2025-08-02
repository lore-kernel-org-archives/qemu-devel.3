Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DF3C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 11:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiABA-0005uZ-4o; Sat, 02 Aug 2025 07:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiAB7-0005TD-1Z
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 07:13:30 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiAB5-0006Jo-6a
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 07:13:28 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71840959355so30268387b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754133206; x=1754738006; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a3VXNhNHWC6vZXISOU/6Jypw6J+NQs/f2KNOaSUTbDk=;
 b=iNFAnR0nqpPrDW+jZ7L+21FCwHbY08LR82G2FeI4xuKTmW9mce3i+URblwVbLhop+m
 T//7GH1RZy7EmLVr0ic9KEbNStG95ZxYRR62GXd4dhaf7gPjpIui7UWt4uySvFjNp6K0
 LlNhgGgGzGDI84yxf6IzfxOIzypkO8WckeZfbmNdBVhSIxrap59SS3cXvEbjIHwqEQNJ
 3ZdDigJmhE/xpFkxPB8AgdaLjGkKrWD842S35BeM1/cag+hiXk3HFAc/9H0+fMiOcgGd
 aNo7dEsFsGHp0Berur2CrgRole3v3un3rulKkEh5hFoNSlqsPfNd4YfuF+YcOeKsoXEc
 RCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754133206; x=1754738006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3VXNhNHWC6vZXISOU/6Jypw6J+NQs/f2KNOaSUTbDk=;
 b=fjQ7VfQUqKDbSKqeJyuRuq89fkGPSkPb0JGaoCSWBKLnX4EHBInMBYp8K3dDqf9vmA
 dpW3YW94viuzUD9FZU3LxV5VZQaVXKp3GO/Q/8yI2Xy84ilRTf/XGXiFS7yMk4jjnNWE
 b5AMExsPJSnUVbTMlw++e5p3kd0Sh9bNYS5+CtZG+8ltg5oFbI9dsUmz75Mxkq2Zt8e4
 5JUKRzrAmAeysRZFkA+TORJtfXE24i0u2V6Bzpl6aYWIOhZQTemmxpcbbuILBEg1ZQb+
 Mq8Gj6eTPw1UnaKYaRdczE4J0vwzhbnT6+/H3In5FFJqeg16vZPhzpRLxMHXF+0soG9o
 j82g==
X-Gm-Message-State: AOJu0YycaS0EDtN1OzyD/Qp0P4OreYJ+V7Z4RG+bd8i0tUXZ5CUNlEst
 cLY8A64zLhuS6Mt4TwfCv+dpb6eq7EIJl9yFxOS0c/fBRIZP9oR2OGO+IsetkTJqX58SST8AmUM
 vvIwq3qFCbjo+6kFyLjXFM9/OB7DE1ehIdi5DlLArpA==
X-Gm-Gg: ASbGnct8ifDdBACatrbnk8v/KgNzP1Pu7mwWZ8psBmbF8P173TDcYDnfqiuFTo0qimj
 kNxipNtij7f/WCUGfyh/+GLBmEMENH81dThk6d/KUyOoWatvTPpP0G/E6OzS3TH7hBSCSOwqbnW
 VwsgHbBc8o4BvDrqqxB3mbJwOBlZ19Sp8tLPpTYjMmLKDguor7hBSze/vGRYrs3Ns3UhghenZae
 69N6ka07L4+115QTlY=
X-Google-Smtp-Source: AGHT+IHlt+n4R2+z+Fm2PpJCTY4WGQxvULFyWIo01C7xhmSmD3BqJumhsozZ1tLfmknowF8ZDjiy8aUQ/t0V1o6iv7g=
X-Received: by 2002:a05:690c:1b:b0:71a:2299:f0e2 with SMTP id
 00721157ae682-71b7ed70f84mr37075867b3.5.1754133205663; Sat, 02 Aug 2025
 04:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-42-richard.henderson@linaro.org>
 <CAFEAcA_FtS6_vXXWNb2DrwmHuTODMpK_awnYGCaTdn+wbFuoyQ@mail.gmail.com>
 <7e3616d3-2811-4be6-b4f6-de22840d1cc0@linaro.org>
In-Reply-To: <7e3616d3-2811-4be6-b4f6-de22840d1cc0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 12:13:14 +0100
X-Gm-Features: Ac12FXwle8_jrb4iJqZ8iYv-DRQu4yvLuwRQRfnw8RrbP4CvplkzIzkY0SpIaEk
Message-ID: <CAFEAcA-qkWSELRxWUM-2b44QKfC+6wajPx3A1nT3V7DQphiR9Q@mail.gmail.com>
Subject: Re: [PATCH 41/89] linux-user/x86_64: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Fri, 1 Aug 2025 at 22:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/2/25 03:45, Peter Maydell wrote:
> > On Wed, 30 Jul 2025 at 01:24, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   linux-user/elfload.c                    | 41 +-----------------------
> >>   linux-user/x86_64/target_coredump.c.inc | 42 +++++++++++++++++++++++++
> >>   2 files changed, 43 insertions(+), 40 deletions(-)
> >>   create mode 100644 linux-user/x86_64/target_coredump.c.inc
> >>
> >
> > Maybe we can come back to this at some point to convert the
> > .c.inc into a proper .c / .h file.
>
> Are you thinking of something like ELF_NREG + target_elf_gregset_t in the header and
> elf_core_copy_regs in the c file?
>
> I suppose there's no reason not to do that now, putting the function in the new
> target/elfload.c, and the one or two declarations in target_elf.h.

I hadn't looked closely enough at the details to have a concrete
idea; this was just my preference for avoiding .c.inc files
unless we really need them (e.g. we're including the same file
multiple times or it's just too painful to split a huge file
any other way).

If it's easy to put the function in the .c file and the declarations
in the .h file then I think that's better than the .c.inc approach.

-- PMM

