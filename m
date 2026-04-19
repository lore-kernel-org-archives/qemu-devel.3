Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2634BEA71AD
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 23:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEbNp-0008LE-5V; Sun, 19 Apr 2026 19:16:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wEbNZ-0008KB-Oo
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 19:16:43 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wEbNX-0006MG-T7
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 19:16:41 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b9c3e2cf3c0so440471566b.1
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 16:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776640596; cv=none;
 d=google.com; s=arc-20240605;
 b=Ns5PhiVpPqKe1pAFynbZAVDys5XZHMCNY9bW4ew0XXrCitUm2MUzyFGRcof00CHaR0
 FSiQJ5LLsVnsBalx6LCdraH4mvES9EELTz19YoppHyEGn1DrbF3LObkB/Ye+nom+jVDY
 LoRwx4Inh7HMXCuY+Mpm9AwXuZRpjtvb3bnGwLmghsWy16WMJXqNSexZpPgAxedKzsrb
 0AJ/2SHTS/f5FMhqaK8T8fzx0LeZaXlaZ1hGuaVYQMbQxEhBnB7CfAE/a8put1Zh3UFT
 hz0mzIFn1oxBwidvsa/jMj8DgiNsYovx5y+zTzBjpAPTgK4LGEVOUbF7aLSsBbtewaIq
 PTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ilblzKWlGehiWYksYnCQFwxpQ3KR07H0oa4paPci7mw=;
 fh=eeIPVNr8dfmzuwGdFeNhhW7c/aAeJK+FICTmvFvUhb0=;
 b=LRX1b3QO080sHKjw5cOc9Fmoa77Xx7SFo3Ib6ca8jEi0FRsmj4dy+aojBfPe73xKjH
 GWAwmNXLp630b7Cc/5L414FzxwnD//ItcDqIzy1ukoTTmp72+1rdWcspioEMa8bbXNmI
 utfznNxqpM+gHIPB+NO/mrSzzztZpREU/eSnhfDjyG/zrupVImqxS5yBiCzA6UOj/Mx9
 NLlQgs+nfx5q7NIRQ3uyxMb/o4hWlr7O2ytztP70wj2yWVbvChS98zIzcf4Ta/tzEHZz
 wlcXrAoCqv3D9w3V1BGlhJOAmIW97+es/YIrO8mbTfsOV1lltEjlpGdJtw5e2MYEq4JT
 ORLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776640596; x=1777245396; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilblzKWlGehiWYksYnCQFwxpQ3KR07H0oa4paPci7mw=;
 b=qi005Rj3WPkKAVlKm1rF4saUujwMG6qbu4WJP+aZ+R5CeQI6SdYV3EZqz4QPtswraL
 FyPLR44sSTVNfn3QkrGHeNRMZSGJwQqIIjDjXPe44uk4ZiZA030UfOoZqfzryYwdSu96
 BPGTpR8ZyX6mwXDUSf1abRpp2v+X2JxbM5SLlmcN9tfD/WhFvP+kYaC/Ldj86X5R1X5G
 dhzfO7pFBamPA2JuoroklXftQqNYdOJZ3Hocx97+2LV5uTXl6haX6NM7JwBgdjpUGwv+
 UAUeOtsM4oN2wXS31NIKjHMBERh4ac+qH1AgOOQ3AP5vEWbKN4tZ6TiYgsM7g2Qmncq9
 r+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776640596; x=1777245396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ilblzKWlGehiWYksYnCQFwxpQ3KR07H0oa4paPci7mw=;
 b=WDNfqIH3LkEa+UsXE0owhRtq3DQF63JcZsewSH4gXE20RXNq60SlZt2hv0CrWc/7zA
 0pWRrC3z3Te1uAAtxfj3I1JmROiarS0oHlCSlg+w/kmY0IGn1snlgB4nnJcvYZrGgY0G
 CZxFPmChU8m5GY1mVEWsLVBqPKzTdRE+wVdcVzqdanQQ+vMfMKAy0hz7k5vjONsI+utC
 MWzCWK2L7lizp1Ny3BrCFEeyXbFaBZungaXJmnI0YqDAUP25rzOuPVYbru5lY0D+gxYj
 0Zl+9AEy7PFQ+SNhr/pHIewTOxbZ6vCOqj6e2i+gyX2JDJMDjSnX+l8pLHEIskgok/rx
 VWjA==
X-Gm-Message-State: AOJu0YzP2xfoQaRQ1OE1qSoDuAezAk1TZc1m2+TnCP2gmoVnNiVglK4e
 MgPWu/auaogclNLDfPdrBaFxPaP7bKFxvZsb2j6aGycBapWvhagQqX1xlanS6gdTo7jYQr6NzHF
 BjXdklbnB2RBSV/Z/y9GqWHwbuMBq0kE=
X-Gm-Gg: AeBDietQRLvroAh5obYXHUbh4pY2NIsI0xwMKVgW+vp+Ual1EgFKlQZf++9D9tPFtjt
 yk0zMKI4eZCs6oLLo7HRkcKcHnH42+acMFKuh+4o4yXC//VVGyT0L1kTFhnmmjZxvNV1ugd1zUJ
 9ryv0wvZepvSBjiFQ3fwif/MPzMU/308PTH74FJa9UJ62ODKkZQBw9jOFtzy5mZNuKHVX9nKy6B
 p3Ehc9iU+VkQXZ/N9jorqz3ymCXUQWzeG32DN3c98gmQexDW9OdWgUcGkhUgWLr395wG3/ie+7o
 A1Jk/vuDd2xarBuREDUIe76WSuzTYDyacks/CbUfVHSUfZLu
X-Received: by 2002:a17:907:3f12:b0:ba7:f5fd:ede0 with SMTP id
 a640c23a62f3a-ba7f5fdf234mr41965266b.6.1776640595538; Sun, 19 Apr 2026
 16:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260417110550.70068-1-philmd@linaro.org>
 <20260417110550.70068-4-philmd@linaro.org>
In-Reply-To: <20260417110550.70068-4-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2026 09:16:09 +1000
X-Gm-Features: AQROBzAYm-8WeBvUoPiAcQdyMHUYPq_ZbhSNBjOY-Q9_ejsnzYIrAek0KQptskw
Message-ID: <CAKmqyKP=oW0=-zz2LTcAFNGBRV=YJnooE_zre_4D-xukGMtfzQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] MAINTAINERS: Merge PCIe DOE section within SPDM
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>,
 Gustavo Romero <gustavo.romero@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 17, 2026 at 9:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> SPDM depends on PCIe DOE, so it makes sense to cover
> these files there. Cover the spdm.rst document. Add
> Tao Tang who volunteered to be designated reviewer:
> https://lore.kernel.org/qemu-devel/44abaece-6a6f-43c6-b29a-53d6eb08033c@p=
hytium.com.cn/
>
> Cc: Tao Tang <tangtao1634@phytium.com.cn>
> Cc: Gustavo Romero <gustavo.romero@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  MAINTAINERS | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 11bf50a9ecf..eccc0d64331 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2150,11 +2150,6 @@ F: docs/pci*
>  F: docs/specs/*pci*
>  F: docs/system/sriov.rst
>
> -PCIE DOE
> -S: Orphan
> -F: include/hw/pci/pcie_doe.h
> -F: hw/pci/pcie_doe.c
> -
>  ARM PCI Hotplug
>  M: Gustavo Romero <gustavo.romero@linaro.org>
>  L: qemu-arm@nongnu.org
> @@ -3693,11 +3688,15 @@ F: tests/qtest/*tpm*
>  F: docs/specs/tpm.rst
>  T: git https://github.com/stefanberger/qemu-tpm.git tpm-next
>
> -SPDM
> +SPDM, PCIe DOE
>  M: Alistair Francis <alistair.francis@wdc.com>
> +R: Tao Tang <tangtao1634@phytium.com.cn>
>  S: Maintained
>  F: backends/spdm-socket.c
>  F: include/system/spdm-socket.h
> +F: include/hw/pci/pcie_doe.h
> +F: hw/pci/pcie_doe.c
> +F: docs/specs/spdm.rst
>
>  Checkpatch
>  S: Odd Fixes
> --
> 2.53.0
>
>

