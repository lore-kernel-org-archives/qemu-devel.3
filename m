Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40516C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUuK-0005BH-NU; Tue, 05 Mar 2024 08:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUuI-0005AQ-Nj
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:32:34 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUuH-0001zO-5l
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:32:34 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d204e102a9so60653891fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645551; x=1710250351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E38r6/jg4YgFWKsIXJzdzue2mLMIBhN94Dtxgql2ZdI=;
 b=BaN6EbLWJ0StV9VcbkihVX7Gi/XiUonp2PNoc20M2bWUQVD1kirSpqVWNJaLF9Y+48
 oyRGnvWHCI3AeqsA1UePkJyoJzBHldVV4ggkXF0AyQmHAlP14BUsIStw0EruEb3U9duj
 K93LuvW6NXyQW7G012DjT+E49m9swfMFlfJEPcJNNZnNPn6Myr1mdujPsJAdZpTwDrti
 JKMsAFENQE/J6utdHUj/ebTt0tIOuPTgNslMRUWZI8zniHOPfeDQ/WziwMdUhPWlYJeu
 kVAFoJdfWAjG3GENULHbxJXUdv69yIpqurJ/NI9f/OzPbzt3ZqRiN2ZD3AHQLNOu3IG6
 FIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645551; x=1710250351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E38r6/jg4YgFWKsIXJzdzue2mLMIBhN94Dtxgql2ZdI=;
 b=Uhx4f8NqMyOr2TsC8LJAGUTehTMBYOY+rSzvGtlsGwKTyzbu0mkeVVYvjo1Xw+su4G
 Sg4xf7sVr7XXZlgM0Le5+EbZfGs9ppHFUaZdgob8Ny2N4wckJLyRwF34rK2g2Ntq3szh
 i5OWcZOOJq58IekQX4g3a2xlyfMM0FdE8VTi4Rx5KhRtf3fRJ3essSrMsDXG8xTP7w+G
 lRq4TZ7vuxMrX7yR9isSUVeN8iIrvt8n2ab+FYQg0zI/Pge70wqtGcDVqFFLMOdrjM66
 fqx8X1iAOfSbLVL6JzxHeLn2fvh9/UTYGFD1PaYtJ4ejjoh7d0KYog7YXgWNe80MzsVQ
 VZ/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR8OhP9LlPoF6J8o5dKNVwaLWMdtcvbGQ4L208a/NmpbZy1QU3yetO7+76XCFa8NrnODNsgBv+KRRqdYj/g+g/n0VVAMc=
X-Gm-Message-State: AOJu0Yxs+SeaSHvLc8Fb2t0Qdvh6A3FnGRvUSHAtSDYos50HVmH7vREC
 b69PAE0aSGjJeAmDkAB7qBz9HcmlFsiwtrvHg25b1zUpW3JpU4wfObB0/LNDN32NELOMEgioZVG
 1Eef0NKraheeVw5wL9hCKEZhA9fSNXiqrdht1mA==
X-Google-Smtp-Source: AGHT+IERZ3YeHmx4sCh845y5swxbtIvWdAd08aezbQgCiBdR4hTlyr8b8JY2wstQ5mIJF3fpSVAFt9QRgA8qBAnwOsY=
X-Received: by 2002:a05:651c:4d2:b0:2d2:b929:9388 with SMTP id
 e18-20020a05651c04d200b002d2b9299388mr1767180lji.22.1709645551299; Tue, 05
 Mar 2024 05:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-8-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-8-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:32:20 +0000
Message-ID: <CAFEAcA-e8UFY7OFF3tvFE_Uo_i77n5a_qbZQtV4tEBz6ca5Vag@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] contrib/elf2dmp: Use lduw_le_p() to read PDB
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> This resolved UBSan warnings.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/pdb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
> index 1c5051425185..492aca4434c8 100644
> --- a/contrib/elf2dmp/pdb.c
> +++ b/contrib/elf2dmp/pdb.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/bswap.h"
>
>  #include "pdb.h"
>  #include "err.h"
> @@ -186,7 +187,7 @@ static bool pdb_init_symbols(struct pdb_reader *r)
>
>      r->symbols = symbols;
>
> -    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
> +    r->segments = lduw_le_p((const char *)symbols + sizeof(PDB_SYMBOLS) +
>              symbols->module_size + symbols->offset_size +
>              symbols->hash_size + symbols->srcmodule_size +
>              symbols->pdbimport_size + symbols->unknown2_size +

Same comment still applies as on v1 version of this patch.

thanks
-- PMM

