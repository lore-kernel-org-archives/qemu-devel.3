Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D41C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuP6-0008Uf-EX; Fri, 01 Aug 2025 14:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsml-0006lQ-Oy
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:39:32 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhsmk-0002kz-11
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 12:39:11 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8d96ff2dfaso2214824276.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754066348; x=1754671148; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3jwB5SndLxSLn3CLa2Zip2Nya51ZQdcQ0VG/1UijsEc=;
 b=tbcGf8x3cpei563iriQbOQng+9XGViv5qTf0zvoeKle3+hDkGVvcWqUnDszqJcBchx
 NXrG+qAshjXV2VEfyFTIzONbtv+TPHQHcuLcjECUHUCb4H8wz2hVXktWRwS+4BUjpQ3W
 urd0mtPs6kpXwQEFOjbQ5IkZGxXicjGTfsurpFYJBlVoByt6BK68QmXoL1ApHesLn84j
 CCO6kzLrNOfJcM4RibhCwpO39YCq8ev2bkNh5PfqxCPwWvBAge0iHiPjmVSTzkCVvfrS
 sOlY4HS2zDb46PPo22XL0DETFrrXsvd+gOIlqV3Dnvoxt3yP4wutJN+2CzDoC6W1w+S5
 P/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754066348; x=1754671148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3jwB5SndLxSLn3CLa2Zip2Nya51ZQdcQ0VG/1UijsEc=;
 b=DuomwOMjIoCm0xt9+AG9c0Yl3n5oTfw/kLcY7lNd3TZCYXbitL97ZXwTw4oSTGQPSD
 XCvfd1sgNGeSZcVwf8QnXfZgmvsbIkAGA555NaqF2MT0ruvXWNNFaBN5HRD33IZKiPI7
 cOLva1vlQV/XzPO4jxZnqW32qL9zWsMnUF0Ml+RN5CURWguY0M4zDfOnJa+MuX87/QNM
 3m6+P84e0y556gY57xlgpNN4Wrx6RJEnmEDTit3dxtOJGCsxLDutYeIrOTHUCo3zBnHi
 cdU9BB2kE69jFwyfqCZcB1wmv1Iy8kqN8N/zXksQhQe4ZehRqP9zXfjSmVI4oxi0XWpL
 szrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9N0iA7Emt2W7w5UdZ7H5dy+e56MI+7IXimpf5F98v9IE4QURjA+LFo9IET5fj85sSqLk7kttcHzWl@nongnu.org
X-Gm-Message-State: AOJu0YyAAgi8y4SlkPXgF45Kqsu/BZc49aR0u/9JdV2PmuBLVCLt2vkM
 D+0LtRGewCXguZpR6/2yaxSLP4rekf8oPu1Jpkln44OdorwA+BKDJjsRVRKJIzzHzYo43TyDNCo
 FUieziKjOr8MoaBnZaKxyTaz134aZg/dsrIdTboYa4w==
X-Gm-Gg: ASbGncv0mcpcAGbvAA+ObmM+jl1FTlpyDU8qQ0DLPbkxLrTEJw8SJanAfkycSkylx/p
 qlkiv67+Gc4qj/+B3dlEnHpmTku7ERAinDcPmXwgj84jtGeR9Dg1lDp+FeKN05MS2bVO5lp8C+H
 xs4XvQgxpWi1jD3t2zxNTlvg4xBZM1jVbVHT57IdZGiv3xRtAu7w65Di15tFnvs9lSmOnCNONv0
 FgYzM2H71oQf9z3Hks=
X-Google-Smtp-Source: AGHT+IHPmiIPWJavlcndnHVMaLRgwax8Bwr0A9pnQsMWSTfQB8X+Jlek3dkVq9+4ljBrBDOrq7o6kdd7Wr94S2KErJc=
X-Received: by 2002:a05:690c:2783:b0:71a:3c89:d132 with SMTP id
 00721157ae682-71b7f5f35c8mr4036697b3.37.1754066348358; Fri, 01 Aug 2025
 09:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250725201906.19533-1-pierrick.bouvier@linaro.org>
 <bfdd8821-a7f7-4648-a389-124426da6d15@linaro.org>
 <144f0930-af30-42b0-849c-99242d3f09ee@linaro.org>
 <CAFEAcA-ycO=AO8UO+X3f6pw34J=iFwW3dpPyMXKm5BzJ11dt5Q@mail.gmail.com>
 <25fe9c70-be00-4884-8d91-53dfff745cb6@linaro.org>
 <CAFEAcA8qHUT-0k6chAFZ61J=YZ7xLvhYgqsgtQiCgkfaxfFRxg@mail.gmail.com>
 <034c953f-dce6-4068-8f93-05e758e67703@linaro.org>
In-Reply-To: <034c953f-dce6-4068-8f93-05e758e67703@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 17:38:56 +0100
X-Gm-Features: Ac12FXwzMw2UMBpy09nEG-t1hw2KeO_0GDieial8QRGc_voE-8FInLNSetqqNpw
Message-ID: <CAFEAcA9H4WtVUuEX8kf8LiHQ3Z421Fq3ukbLnCRRfUKLyRF6QA@mail.gmail.com>
Subject: Re: [PATCH 0/3] single-binary: compile hw/intc/arm* files once
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 1 Aug 2025 at 17:31, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 8/1/25 1:34 AM, Peter Maydell wrote:
> > On Thu, 31 Jul 2025 at 19:30, Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >> Regarding the "modern" completion support, I recommend you take a look
> >> at it. Even though you wrote or reviewed most of the code you navigate
> >> in everyday, and thus don't need it, it has become a standard tool for
> >> any developer, like sanitizers or omniscient debugging. It's especially
> >> interesting since those tools are based on compilers (clangd is the
> >> standard for C/C++ nowadays) and not a bunch of clunky regexps.
> >> It's even more interesting when you learn a new language, like Rust.
> >
> > I do actually have clangd enabled at the moment in emacs:
> > but my experience is not good, because typically what happens
> > is that clangd runs itself out of memory and falls over
> > fairly frequently, or it produces obscure error messages like
> > "LSP :: Error from the Language Server: trying to get AST for
> > non-added document (Invalid Parameter)"...
> >
> > So I mostly continue to investigate code the way I always have
> > done, with grep.
> >
>
> By any chance, are you using an old version of clangd (or an old
> distro)? It has been a few years since I didn't run into any issue with
> it, and it's quite easy to update it using llvm apt repositories without
> updating your whole system [1].

I use the Ubuntu 24.04 version. In general I try to avoid
using tooling that isn't packaged by the distro: it
tends to result in headaches later on.

-- PMM

