Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CB1099B2D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eJ2-0006FB-2i; Fri, 20 Mar 2026 14:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3eIx-0006El-I2
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:10:40 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1w3eIv-0003CQ-By
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:10:38 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-899fc265126so30115646d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030235; cv=none;
 d=google.com; s=arc-20240605;
 b=VOfdYkIdZg+rMhy6n7hB950aKryRnS8jHythhsVlX67a4B67bqd8erCtTX6Kcrpksn
 zezchkf8mE9kET3BVRx9jTrdWLziJJwAcmjZWRlij6kmwvk1vlFKcq8bU+UXr21HIgm3
 H96y9QlQ4uqfNBVdxo2MKSjwpBbuy9vG1dU3G5RDh1nW9Wtjriz4CLvZzn5E+SRinMSs
 KwFHyXMSSM/bPRFIRqSTEAx9xnjxu8ss2lLF2rHlLJoFCgj1jGE4ox2ZgWC+LCZ9ceoZ
 qIzj3nLo2aL/CAdggm5GkoWYdDDaOhoEi2gq69NCG4NiInQpkPVqFrK2kYd5vXLDak98
 c88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mm5qIjVvuv6wd0dE7fgugAWPg9uEwWj2rNETE+cgsXc=;
 fh=c0erNo+sJ29Z5IwzOrma4WhJmO9gKlXEZkjXKP7KWY8=;
 b=kMFXS39ZUG/GxiHdWrif0xKX3R6Goqze9yDGsMRK5QmyuuSQ8DvmwAHSyPonUJ3gYs
 uL6YPbeaEahI0v8NYdiZyM6ajEtCVIcPG72DpXzzPiLeRiroIAC5zmWR2FNiN00Ot0LV
 umosQ4rORUuEJH/AoWmZm7C7lIUmn3MMEqmkQs/gD+ZOYrmzXVMfBFYRCJ1c9gSzmbH3
 DT0lbZMrIaJcQgmJd3X5mGMYQbn8xjnlMIGYCSggjHnOcAayi/gVKXFJfgtOc9D4BZs2
 ynmZPnr9VQ33S37Sl5QJlc0Ra4qr4DvcC7nSgQ5anvLRHFpg/lueCqaRngb+6Te3rZOR
 C8Cw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030235; x=1774635035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm5qIjVvuv6wd0dE7fgugAWPg9uEwWj2rNETE+cgsXc=;
 b=Z7cIzWsN/+l9ybHT9f3HfN0glADGWO+3rGK4tiTIEmiml+dFWONFNxYFLdebxC4MEl
 q47oqDhXD5R5k9z3hPI/7MU1dxqISKL4AXG2nlMhaivPzR35OnyTyyo8Cmh9YlrO4n98
 hn4RwaieMYeMIjpbvDLZjRVFTztIAD0tShWa+udR8b2P5UHcmy30n5W9T+/PVfnKohsQ
 6dFFC7qC50kfhdk1qPN88DO5oCG8KWkjiAg1ADn+VnMlAALfHrhhKA1Wn4DwJ+dF7nbc
 CDzRb+wPf+jlCRymUyeKXHmAbS4N2xdhM1yMCfW8FqjvI0eh/wSo2PMm5RNpFVwNl7/B
 QVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030235; x=1774635035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mm5qIjVvuv6wd0dE7fgugAWPg9uEwWj2rNETE+cgsXc=;
 b=DkQZagWANaq6/JsOLctZe4xyZdomwfXTxAts8Lj7jHGHr7gc3M/wYYmkHFbt1e/ERA
 kqUIzvbPTc3gRAT6SUlDRymWBlhZZBoXf5wv8nJtwtv1nmKHTXu8NtQavV/Z7RUjO6lZ
 DyEcSzNx55l4EiZu6PtLqvWZ61N6t0VXJwzImpI2TKtk0fsWWxTHEANylMMjj+YE6H03
 sx2RNTX5sbRFcrjpUywJohA5AXFoDBhQk2+PD/HHB0nXr+TQfn2ba8i0VtS1wAmwz6cC
 rf6t9CTNYS63MXzOHc5dcgStHMPNHTZDIeUAEMEJp4hapqsR/sykKaV8iFpVWsdj0UZG
 4w8w==
X-Gm-Message-State: AOJu0YwRIn/xNLtxJ8sq5jj+t3ZuTf8NmXBo7vSb/JJd8Gl19jYVgHi9
 oW6vn5YBkmadNLYqvU23nuSAjjrfFT/747jFlhQpKNF+pP095PFu4H0KHC7rpOSQfsT39Z14Rbu
 MO3wMRWlsQ/K7gyD8qjg66gM+LOL9fZU=
X-Gm-Gg: ATEYQzxNuztgdSWKLStP6LbgrkvTl4zMyxRa2xCxsug9OjECjVxfbwA98OTp8pr0ZTV
 j3ttqESYqgAmVNeJvRFOWImOG9drJTbcRELMYXYLMPKRxFaWnWOmop1UJlOn6c8vCQPtysJp9EQ
 2dXvr++hzUWViErGQjSeN80e2GG8LrZZuIyqlUiMLFnklh1qWqo14vwjoz+voKubxRcO8+jPEDb
 hrvy5sLUWv/tUcNA7viIKNF9dT9okMq8ZMtxs1Rm4uz3sx8GpgsHcSm8/qLRApwFDPuWZm3r5vj
 fZsN51eIetgjxJDz8spBFmMCASabM1an8D58l4eISGODK78S/O5mXvQxvBcSU2i/jVw=
X-Received: by 2002:a05:6214:3d09:b0:89a:59c:34c0 with SMTP id
 6a1803df08f44-89c859d0832mr56186496d6.10.1774030235458; Fri, 20 Mar 2026
 11:10:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260320165021.39521-1-philmd@linaro.org>
 <20260320165021.39521-8-philmd@linaro.org>
In-Reply-To: <20260320165021.39521-8-philmd@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 20 Mar 2026 11:10:24 -0700
X-Gm-Features: AaiRm53peu8jPmq_NWQHPEtOQok4zSl8c9cIoIQ2-Sh9Z1bCocks6CrVGaMHV50
Message-ID: <CAMo8BfK-ZYbEk1DtDJRUh4vkVQGz=zPn96EexRUF9y7ouFcv4A@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 v2 7/7] target/xtensa: Rename dump_mmu() ->
 xtensa_monitor_dump_mmu()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Glenn Miles <milesg@linux.ibm.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 20, 2026 at 9:51=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Rename dump_mmu() to avoid a name clash with other targets:
>
>   $ git grep -w dump_mmu master | fgrep .h
>   target/m68k/cpu.h:610:void dump_mmu(CPUM68KState *env);
>   target/ppc/cpu.h:3083:void dump_mmu(CPUPPCState *env);
>   target/sparc/cpu.h:603:void dump_mmu(CPUSPARCState *env);
>   target/xtensa/cpu.h:697:void dump_mmu(CPUXtensaState *env);
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/cpu.h        | 2 +-
>  target/xtensa/mmu_helper.c | 2 +-
>  target/xtensa/monitor.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

