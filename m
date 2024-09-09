Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2174ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snh7z-0003zP-LD; Mon, 09 Sep 2024 12:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snh7w-0003qC-H0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:20:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snh7v-0007U3-0i
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:20:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c26311c6f0so5459394a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898829; x=1726503629; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=B/BwuFHMJKNeqTcLpLg2oMdWzrcYxK83zX3fMgRJ3M0=;
 b=E4qVYnTr9zYZ9y06sVbkbfD9k/DbTgBOPPE03mpZzemFZEt5tLjYvHr9t5Ut+x+5jk
 n/9W+ceUGVL33U9MJd26qlsjrFwMZK6uFESAJp0mdUvWiy6b5UdbAVmp9wLwBoKdRILl
 x5CiQgCwqpHDsaJuLON9IcsqmdvVpPPTH5eNJSeGMAyaCOgS/PHbX5tjxvQ7ulMC2Fa2
 2SaqrEMDKWXf9csBwqHDc8X6UIgK7EkRCoYpVpsrqiV5cbZOVvcMz2rPWIIe3r7DTuYc
 GZDxxHJ/r9Aw2TP8k1KAZ9j9yp667WKb2eb/peDFxp2jFlRaqXVNVfd0xrbgcyLE953K
 kYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898829; x=1726503629;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B/BwuFHMJKNeqTcLpLg2oMdWzrcYxK83zX3fMgRJ3M0=;
 b=fvvp4QKR9DtvYkf0YJrH7tCiwTGNkH2OWg/9dVPpQa16a5TwiCe7ydQ2bGn2psp6SU
 xbNKqvJj1xGGeIQkNq1dzkFt92iljEV/6jeBz0BgfHF/TV57vgM6Qa5TuaBi/5h6WO+x
 I45F+qsph8UE4UoVKNqQ/v0Zp5jo/WjAZMI5FV4iKBHvWhs0A/NSy3HF0jZFdFiyfqzY
 IydgMF8QwluB7A5ZNJMwavn7Bk3j8Nl/lElj5BuOx7jb+hvUNy7Szjb7xrdwvVLMqmIu
 akNEMi9pci63OFJUTbND746plN+0GMAC55qQv+FaiMdQdqhqnDuUWajRMDJ0shMdyUvj
 t01g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBEPtsf4qqDPHmgaChBcnCXu/IbH+wZ2qOYsn6SXynet4sMYM/IiXM//LU97tQwIl6ShVBi1Vr0l3U@nongnu.org
X-Gm-Message-State: AOJu0YxGA2N4OMH7J3qZQmCUvTIYTygidHfBTL7aalhm+Q6fjgID5tTN
 T9VSqNrRQngCSprsGabrDD0C2F1TpY3lIrKqJ3Dzc3Y6DQDshyDilEgzvkIiq9fRSkosX6VucKQ
 FMgddhmw21VchCeKQxVmDEm3bhV5rk8g9rp87Yw==
X-Google-Smtp-Source: AGHT+IFc2in0twyejbqn9agpJ1y/Cb2+Jv/QTkGJEAf8iN+DwCCDRwF6lmDQ+rdGG5Dv3BwXevTJjoZno0D71RWfLFo=
X-Received: by 2002:a05:6402:2110:b0:5c2:2b1d:31e6 with SMTP id
 4fb4d7f45d1cf-5c3dc7c3e8emr7821139a12.29.1725898829174; Mon, 09 Sep 2024
 09:20:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240908071600.430410-1-mjt@tls.msk.ru>
 <08b5c803-cfcc-49bd-910b-61934fa2d1e6@linaro.org>
 <096e96cc-d126-4f71-a05f-eaef1f8f4a4f@tls.msk.ru>
 <95b74368-8e3b-43a2-8185-e95ae89c9f6c@linaro.org>
In-Reply-To: <95b74368-8e3b-43a2-8185-e95ae89c9f6c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Sep 2024 17:20:17 +0100
Message-ID: <CAFEAcA9cPxhM1b-3oEX9Mt8nNDpkV0tOuewEhFd3h4PpFPt7rQ@mail.gmail.com>
Subject: Re: [PATCH trvivial] linux-user/syscall.c: replace function pointers
 for flock64 fcntl with macros
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 9 Sept 2024 at 17:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/8/24 22:26, Michael Tokarev wrote:
> >> Why do you think this is an improvement?
> >
> > It just feels more natural, so to say.
> >
> >> What was wrong with the function pointers?
> >
> > Not exactly wrong.  It just hurts my eyes when I see an address
> > is taken of a function marked `inline`
>
> I'm certainly happy to fix that!
>
> > (though I understand well
> > this keyword is just a hint and the compiler is free to omit
> > inlining).  Also the typedefs are a bit ugly.
>
> I think the macro is uglier than the typedef.

This was my opinion also. Plus the compiler generates
reasonable code with our current source, and the
code path isn't a hot one.

thanks
-- PMM

