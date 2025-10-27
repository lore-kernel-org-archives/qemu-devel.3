Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9957BCCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDR20-0001iZ-Kj; Mon, 27 Oct 2025 13:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDR1x-0001hp-0s
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:29:18 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vDR1m-0005rL-K4
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:29:16 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-783fa3aa122so60739137b3.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761586139; x=1762190939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=INZxKXORbBCMoXc1lgrc8dzHD7uXhAg2JhqJTdk2J5o=;
 b=SfUghv6LpoYmwkBcNVdOLPJCf8uFwj7VkAgyXOdv5QsMBocTrjL5GFqvQNte/4T3Bh
 ExO/Ba6YGWFiJisG4mlPU+q/zGETHMdCwXDlxdzKMBtGIZZte4+hH6y8SbZeUoAHN0XU
 tc3dzUzI1jypbh9zamCFqEe7x93xCozQ9K5LWD1ellxWGVC2ARPffOg++1gfR5oq9ejN
 mSxv8a8TjQksgKE3+iyUeqT0uuot0SK9iDkXxqEotjG3UowannHY+4ZsjRcsn8xr4ihN
 9i5yL2Co5BrgEkzwdq02mQPgz3WtwqFJr7EyytxPt4Fj/7RI0GNxmQv+sAhIeemzZ9mf
 DGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761586139; x=1762190939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=INZxKXORbBCMoXc1lgrc8dzHD7uXhAg2JhqJTdk2J5o=;
 b=SXrDPmLsP5l22Pus9w3QuX8gylmyFEYwZ4x/qfsxmY+i94L4gyByxn3SZHG1icSEhI
 jdDmKoSs0C2EB5i3/XmOy1jBxma/3WvTMbsFnDR/8kJgVUOfW3IHQzgszJAMOLOCQRnU
 6S7BI6ji0O1eDnCfTTKWHxtZRsVKj3CYebJ2Sc8avWfSUfnWrRd+yFY3Ko5pWYNcIOSF
 DMkAWj2lOPbLNDsfKIASkTRU8QPMnWbg+j7s6jHAfXgYm07HtlPwO7Giq+MvOfYvSJSt
 P18adGPA3+oEFIxBUZrCWkO6V2ef9VdmxLzhMAkZPw0e/jwyxWtX+qHJyc+Ea5kkSz8w
 NGQw==
X-Gm-Message-State: AOJu0Yy45Di7k9dbJTUYrXURDa5GXtOYJctdjcnxHXSv6IIuP/aQyxSy
 n3nRZxVel1qnnup2ub1Vrq2eT7OzOa8dMfBKqapZKPoDf4sfA3IdFooz78DWDEg8o23TWQBnxBg
 zZV6XJsnhBMUQFwiegvj6ykFNH1uq1fHfx/CAynSJvw==
X-Gm-Gg: ASbGncts8SrXaFBS2fPWvsvS9FivgGaQTnGBwJAMTYv8DHbFOPkntl/dzDUBEt62ZYt
 YYQL7/CVwrn1bUbL+UFJbwlKemGYe/Jejwk66sz1ZbuV6Whu8+WGgZ37qzziFuDdfBi3wqhjulU
 YgobZzqEx5So1VXexLGXDbM4lFU88M7ZNykN2Pyp9rZTB3mPCr6oN+hJdzMCMsyEnPV0N7Lzhry
 P6nRarr3a9AsUJzc8RYsanc42ra6ZNTV7mvrZljfaisbQ2KgJ87eqcZRu66HN9OGiNa1y2h
X-Google-Smtp-Source: AGHT+IGW5g6yIAcZ8AnOlOitoNnidGxixqtCOTnyGFJVecQ/ja8nQV9cYTlFtFnGNK9cKJBxxc8PEU9t5cKyVByoUKQ=
X-Received: by 2002:a05:690c:8691:10b0:785:be06:1d54 with SMTP id
 00721157ae682-78619161e83mr2030937b3.18.1761586138601; Mon, 27 Oct 2025
 10:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251027165304.98296-1-philmd@linaro.org>
 <20251027165304.98296-2-philmd@linaro.org>
In-Reply-To: <20251027165304.98296-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Oct 2025 17:28:47 +0000
X-Gm-Features: AWmQ_bk_oHxsM-oUwSt3Djx72KQBlXsw0UXYh0V7QLR7hzdQr_p2FAkH_yrkm54
Message-ID: <CAFEAcA-=cT_2JX+-D0_nHMrr_fgpRtXA2WqvY66unNAUhwkVkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] hw/pci/pci_host: Add 'config-reg-check-high-bit'
 property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Mon, 27 Oct 2025 at 16:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> In order to have more PCI host bridges to re-use the
> generic pci_host_data_le_ops MemoryRegionOps, add the
> 'config-reg-check-high-bit' property (%true by default).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

> diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
> index b5c624e12e8..d6db365e327 100644
> --- a/hw/pci/pci_host.c
> +++ b/hw/pci/pci_host.c
> @@ -184,8 +184,10 @@ static void pci_host_data_write(void *opaque, hwaddr=
 addr,
>  {
>      PCIHostState *s =3D opaque;
>
> -    if (s->config_reg & (1u << 31))
> -        pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
> +    if (s->config_reg_check_high_bit && !(s->config_reg & (1U << 31))) {
> +        return;
> +    }
> +    pci_data_write(s->bus, s->config_reg | (addr & 3), val, len);
>  }
>
>  static uint64_t pci_host_data_read(void *opaque,
> @@ -193,7 +195,7 @@ static uint64_t pci_host_data_read(void *opaque,
>  {
>      PCIHostState *s =3D opaque;
>
> -    if (!(s->config_reg & (1U << 31))) {
> +    if (s->config_reg_check_high_bit && !(s->config_reg & (1U << 31))) {
>          return 0xffffffff;
>      }
>      return pci_data_read(s->bus, s->config_reg | (addr & 3), len);
> @@ -235,6 +237,8 @@ const VMStateDescription vmstate_pcihost =3D {
>  };
>
>  static const Property pci_host_properties_common[] =3D {
> +    DEFINE_PROP_BOOL("config-reg-check-high-bit", PCIHostState,
> +                     config_reg_check_high_bit, true),

I think it might be useful to name and document this
property at a slightly higher level of abstraction.

Specifically, this code is handling the behaviour of
the CONFIG_ADDRESS register which is part of the PCI
Configuration Access Method (CAM). For x86 the top bit of
CONFIG_ADDRESS is an Enable bit, which must be set to
cause accesses to CONFIG_DATA to actually do something.
For PCI controllers like Dino there is no Enable bit
defined in CONFIG_ADDRESS[*] and CONFIG_DATA accesses always
take effect.

[*] http://ftp.parisc-linux.org/docs/chips/dino_ers.pdf page 49

So perhaps we could call this "config-address-reg-has-enable-bit" ?

A documentation comment about its purpose and noting that
the expectation is that this is set by the subclass,
not by end-users, might also be helpful.

thanks
-- PMM

