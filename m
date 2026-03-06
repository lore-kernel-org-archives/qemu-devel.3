Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E98F01812
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQzq-0005rB-Ah; Fri, 06 Mar 2026 03:57:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyQzn-0005qk-K4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:57:19 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyQzl-0006DN-2m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:57:19 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64ca1ba0089so8203061d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 00:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772787436; cv=none;
 d=google.com; s=arc-20240605;
 b=HHAl2s/B1Z/mOaCgG7gQoGxak+qg+rcxKWqYAszS2V/PAKS6oUNjJX+2WiYdBOri+m
 QooI2KN3aXYE/PB+/EFdQ87vwHpwDG1uRuR9V2yWJJk+sZUPd3WK2zQwSJ9nt+32xs46
 YKY/C0m088HEtiA587SZLih3q7ACU8rnhHMUofsHj21TnpWyM+B1luFNL4sZofZ3Qprg
 CZAvdozey37fJeyO7PoxwiZVGliKg3i50UemoNKDhKaS0nAo2VdrETnrxp9cQi9LVx4o
 nnHhQYt1a7xM7i5lmFsDklJiLyVuKYVQKRUGI74m7v/HnN794kMc4hwOQJxHbCg6+9Pu
 +O6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vtlvyEaseGYI2DouKjrAoEedVL5ukcJP4LPRroToS/s=;
 fh=J5OEquAEbUD1kPqiNU9bPy3BnQqt1RJCJbWBnXSbyRQ=;
 b=gyRqfOkgra1K2r/8CJe4gUidC9lW5tErnrtgy2jHEpNU5c8TWeBnhwqiv3ohCrQtxR
 om7V0q1BXY8+8oKNqVOMV9FvIKxU2EWuxY1nO1jY/4xYXcnnILe9ZdTHO9UdjsPBxve6
 j6OCix5Qb/M1OTzCdqfsDRHrW4V6JjzEzoU39wuot6FTfv2+kIHZCiN9Q908HWdEwr/j
 d1bInKshE2zyKS5MygdvKOmaL3B0Gp8+/VcY5ZsLdMZlkVqSqdxzP5LYM/56v5Aw+72m
 gFN+PEc3CmS1mKaE0/xN7MWuL6Wrg1tpFcOjmEGBbBUGOgoArLsw4U91120oJpL2oH9P
 EryA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772787436; x=1773392236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vtlvyEaseGYI2DouKjrAoEedVL5ukcJP4LPRroToS/s=;
 b=nauVuO/Ah/++xLNatjA6SmtFlVrcZB9YUXVO+spgHHsuLmGIWLLBVZ14I4mCv6CxXn
 q1xtP/IQDPxHtWiCZS0/GVmqkof2xAoA9Fgyn7RXv6ab4K1sML+58LvPjcm8cFpChohK
 MioYb5GG6STsVXMrG+FgR9ZR3ao3xSV+Iao50040fyuIOvG7sU5meGMPeUI10Pr+k6Ga
 QzYSmoSGWPpG9ZlC/mUpVgfGMJXpZB4BlpZPqtsarayHXX3IegGYSHjI8KQhTu89NwxL
 5jrDav8gc8+h2gDO9DSS3wceknFGHEJ+XE4OWqIANeSSB4xNBXAhrfyaT8EttFqNrN58
 whPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772787436; x=1773392236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtlvyEaseGYI2DouKjrAoEedVL5ukcJP4LPRroToS/s=;
 b=VPGtyH2u/+04GDXJ/2ZqQd6gRQDSDLVjJagxnCmxAvWDRG2LAloX7QPTFggmhvvhC/
 sqvgyJGwMTEODF/0qgezhxP8Wp+pEyadlZP707bZJlWHodHSfnjgWDe1XhGMeQSZAWDE
 ZpHxQvHDY/CeYObMuXL1h8oH/PS5i+/oFb+5h5/0OwGtqg1+O4fQxOHhmAvYuEzdc5xB
 XIuWjVeo42dLz52tmutiWDQX6HZHMafSPNTeVtw4hj9Nt68Hmt3N/uVFiB7AuGRkKzNH
 w4I7MNR4aiyVikipJcNZPQ92sbzzpBitfIGWpC/7BJSMQ4F8Ldodpueio26UNRIYxJpB
 ODZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQXgbBOLs7nejuiOGHnjDdNpsor3YRBflkFY5w82tvA7/FtuTooURMRkIwVVrnLurpMqYYag/jyqGP@nongnu.org
X-Gm-Message-State: AOJu0YwqO6zhLISOYDHzduIJ5nM73yjIp690xb1jnqatNJpWPyxCmw9Y
 MjrDnDBSb5EQFJMzXfs6c960F8yMMFhkXvUXQyeKiVbjjupnj1KUDLrhTnIQqY91Yt5clzgdMX7
 EvkwCUssRkLwtsV91odOXDPAsxzUrwFS0WJKv3N1VYg==
X-Gm-Gg: ATEYQzyphdUG1eCmB6oaTkpj5Ajl2vVM2tK8WmNsjsCAFf7a8N2uVHvHQ5bYR4GvJV9
 o8ubrhS+mYpI2/+UeH6peuJOtD45dsUcTZoLmLPzJ6+Z1gU5fbjz8AU/IBV3oSKvuVbN3ikNF0q
 MIU4XQu/kxWHkOxHEtfoVsEHgjfZRLIkfGGuCGZqxvD4+LQCn0kzILcj9VaOcEfSCxyT6IZmy2S
 IEjikUQHF+pWvr/6O9gnf2Fqv+QFUqYzEzj8xgTfMiTKcHOXwqC2YQBMCFT8Mou6cRMRddzNGNe
 zmkKinIRH7ibBWg2wzVD5uo/KC4h+B5vb0Roer7XFigA0vpUfnZg+epXiFWhCyWdjms=
X-Received: by 2002:a05:690e:b8a:b0:64a:e658:d2e with SMTP id
 956f58d0204a3-64d143b4652mr1263949d50.89.1772787435911; Fri, 06 Mar 2026
 00:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20260225081037.21990-1-shivangu@linux.ibm.com>
 <CAFEAcA9+-5=hVzRMu9n1YtcOazMLQDx65T=NLy9wxv5RNLwYAg@mail.gmail.com>
 <48b13f0b-bb53-4316-923d-77a20ffdfab1@linux.ibm.com>
 <aaFv56FZ6Z50G_T4@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <33d78dda-6df8-3825-7cf5-7bf7e21d010e@eik.bme.hu>
 <aaGoqt6B5fWQGNRh@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <648a3687-6356-8063-b4d4-a0bbc332dd0c@eik.bme.hu>
 <7yq2eac5yzsx2ve2nwbs7uhjguemravsimtm26dkgppeczqmix@wtrwux3aeswg>
 <aapz6OnPgmMevinB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
In-Reply-To: <aapz6OnPgmMevinB@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 08:57:04 +0000
X-Gm-Features: AaiRm51U4UZuZUanFayt-1GlkLMIqA0gAQrY4SLQDTN4JtQeUYpIvpMv5diwhW4
Message-ID: <CAFEAcA9wBVE7XcpdNfnz0xs=vQMj6jT1ce19o9TKAZeY_qKVQg@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: fix dumpdtb option
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org, 
 npiggin@gmail.com, milesg@linux.ibm.com, qemu-devel@nongnu.org, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 6 Mar 2026 at 06:32, Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> I have below suggestion for this, acknowledging peter's dead code
> suggestion and balaton's concern about things changing at runtime
> (would be possible if let's say adding/removing a phb is allowed from
> qemu console)
>
> This generates the fdt everytime on a pnv_reset, which might be same as
> previous fdt but takes care of the cases where any device changes
> between init and reset.

Do you intend this as a sketch of what to do later when the FDT
can change at runtime, or a plan for now?

I think that for now (i.e. fixing this bug) we should do the
simple thing, and generate the FDT once on startup.

We can design what to do for the "we really do need to
generate a new FDT on reset" case later, when we have the
requirement that motivates it.

thanks
-- PMM

