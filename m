Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F180C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpTs-0003FG-Pu; Wed, 21 Feb 2024 11:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcpTr-0003EQ-9J
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:29:59 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcpTp-0001Gi-Nv
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:29:59 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d204e102a9so87555631fa.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708532996; x=1709137796; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TZ6EER/jCAtt+oNuek37bQpi7ljvlPvpzpMylBPLFE4=;
 b=oI/YOtG/ZFt9dYyHKb9IpiKbWGGpUSQvcxEtqiLov80KQYiQayZcQ5oK7PRwIhNA9z
 ahJIUpCJHJTXeie2tde0ggQMceTcPecAPuPUt1P5WMXdTR9xaCDUFRVTvjulIxm6AqOu
 rxM5aWPjKBx/PrARCVDI3rOJ2GC4cWauzLuYbFK4cp0aWw9PrlX7u5sajIyi23RHYnbt
 pFeT+UpPrUzVzkCGBcJN/TsvogZupLhixB1dAzmcvxL8CUoqlGFxLrNRRarHJHut0J9A
 yWiV54OSZWK05YuNeDsLJr907vuH1/tJE0dBK3wtMY1xj9bhj6vDQMH1Q7UQ/bBa6Tnq
 QVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708532996; x=1709137796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZ6EER/jCAtt+oNuek37bQpi7ljvlPvpzpMylBPLFE4=;
 b=EOIB8AJSdvBt9zUlRmQO8ZXswjaf8OXj+Aj6mHAUPgAYMsfdQc4l/pIaDoWqVrvhyE
 WUo6vh+qxHBIqM83X/BM+N0oN+8cFu2GHU+47xDg7Rv2kKkGGXA9024lCcIAN5Xo5dem
 2IwhfubzHFe7bts/mmWlq7Fkiimt8Hlz6tYSKj31rUtjRnT7fx+GqZ6HGHlUaCK7ELtG
 8RjcSzCei0Mu3DJksFZEWCqy1CdKFG5+utF/9vbfeUZnQIVfAfPJEapP0LpbIc6eoazj
 WnI0lP6YvqFKTVnQBTK21FjC2WDOQcgL0/qKkzjalYzKN6q1VYuVR0NUq0eTK75b/BKj
 tGxQ==
X-Gm-Message-State: AOJu0Yw1WA7pii0+vWycdefkNRtrxqr3FkgLUotgv4gGJpAv6jj88Lbx
 KTtJP846GCELRVN9fb/jTYr4y+m7tOkqB/SRGVCbvNPtsUACiKQ+IPCOSyZUl/rgtu2onP2Ape6
 8jTZDRlcIwqWn2rSCCgXjbthKJcCt9TA11OOXlQ==
X-Google-Smtp-Source: AGHT+IHJZFIMKfFV9ZvJhBHpXnoc16BL7h0acjbAjZFU07YFh5/Zs6cTt/dLRTt+WpePNlzQ6zgYRLVxqCzdrxVtHpA=
X-Received: by 2002:a2e:b6d4:0:b0:2d2:56d8:3dd4 with SMTP id
 m20-20020a2eb6d4000000b002d256d83dd4mr1341175ljo.23.1708532995825; Wed, 21
 Feb 2024 08:29:55 -0800 (PST)
MIME-Version: 1.0
References: <20240221162636.173136-1-thuth@redhat.com>
 <20240221162636.173136-2-thuth@redhat.com>
In-Reply-To: <20240221162636.173136-2-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Feb 2024 16:29:44 +0000
Message-ID: <CAFEAcA-xOme3gDx_iwO7S2vSmS8ktG0Lw1UVA5s4LViQZiKRAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/ppc/kvm: Replace variable length array in
 kvmppc_save_htab()
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 21 Feb 2024 at 16:26, Thomas Huth <thuth@redhat.com> wrote:
>
> To be able to compile QEMU with -Wvla (to prevent potential security
> issues), we need to get rid of the variable length array in the
> kvmppc_save_htab() function. Replace it with a heap allocation instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/ppc/kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 26fa9d0575..e7e39c3091 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2688,7 +2688,7 @@ int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp)
>  int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
>  {
>      int64_t starttime = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> -    uint8_t buf[bufsize];
> +    g_autofree uint8_t *buf = g_malloc(bufsize);
>      ssize_t rc;
>

This works, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but you could also drop the bufsize argument, because there are only
two callers and they both pass MAX_KVM_BUF_SIZE, and then declare the
array as fixed size with "uint8_t buf[MAX_KVM_BUF_SIZE]".

thanks
-- PMM

