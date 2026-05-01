Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678DCCD13DE
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 01:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIcjW-0006Zd-HU; Thu, 30 Apr 2026 21:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIcjV-0006ZC-1k
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:31:57 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wIcjT-0001Pd-JO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 21:31:56 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ba6b39871a3so449951066b.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 18:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777599114; cv=none;
 d=google.com; s=arc-20240605;
 b=fWMRCAyy6uXn1YlOFNhaWDvs3BRXEXnpSb5/Ri1uUAnHStKO0bAMnWREqyBsOgoW4W
 oH0nHtcmTWnfsQNS80V5dsPw3zVf3gyYMfnzJoWd+JcDGL5xRTShgVgjypu1I3f6ao0D
 iutxE+lZPe+/O6MdNfZPw3QBn3mgjBMGsMNeukYwsWvLeGr3VrUsLnvNZb4cMIgjwR5I
 Ckzi9stDX/Be3vNKaiY5DWbLqmZNlgWBDOuWdfYabMoUr96sSjPWlWDw8zCxMj9RjBla
 aFf4ZXhhM5NoqhovRvCGF5dwNZs+SuZCG489ERRWmvqus9TrNEbukZ0eP4fQjOaIlo6z
 QrLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xEsGfIXQMhexoIldeZaSqiA87NLtTOOFi6Zpm/WnPDo=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=OFZLw1a8//2F95YPXgM5aCg756C6GargtXmY3poaCjsifXP04qo86ckWDkI7Lcnvww
 JFA1503p/iVFv+DnzhMgsZ2vdEI8ebnWoNwZOGD4+mhQQt+/LxKj7RE6YYainXcQR4RS
 C/Ku8xbQo2idwKjHdlIYFw5Fn+li94YvAwi+xdg1w9ctKw4V8Mh/XF2zTIe9ew26QVlj
 dbxfDVWai7qKMMqLs4O3VEqmKbEjUsGiJ7EzIo4/BZ3TqzS60vXhIjBBc0vhmvS3evqe
 YE2jJvDZ+7QAOspT7QckwLWJKb33W0hEZrPTDzDqe8NKlIl9EIuC5qn19bFSV0tpAxyW
 vrcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777599114; x=1778203914; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xEsGfIXQMhexoIldeZaSqiA87NLtTOOFi6Zpm/WnPDo=;
 b=i/A02kDcx1n6DUeYCyL9odlpSqALxr6OFDKK1WiYSq2eKwXHw6pEdQH4UzK7aiL7UV
 aJ+T02NO+tq6MLHI5OxyCZDUPoXp6RvyaTx5rLCUrCFohh+6Il6We4rqD/XLDM+yStUt
 yg5nj29PoWFZ3mN5BES77NCUmRRu7HAyCAUwt+sWLWl5lxK5/gl8PHAwyoCPtanGJ2v/
 FWfknLCjIpo+WteCZz6iZFX0wT21eKcZozi3Cg2gz7lFqmtdbF9C0ZpQiDEAbZPlKsE7
 0Wnq8BldeIUezE7J9BeVRJxvdWcVwVldp24NFyUh1MEOsXYlTlz2Zug36XtvjhDU89VX
 YuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777599114; x=1778203914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xEsGfIXQMhexoIldeZaSqiA87NLtTOOFi6Zpm/WnPDo=;
 b=TsZXt8JEYVda69y9JffZErTykwMqUinb1N5KliJmlHdaNLsTWVZIFrxCDblw3Z/bsY
 1v5W1lm3aopf48/QHe2Uza6oUFRytxZl0HmOKpkCtx5poDmQAlC0j+yu6vr0qVfe+Vta
 oHb6Mn5oHF9J5RfN8wsyocg/P3guPmP8sU9A4ISwaz1Fz4vwfVONT521jt/F+wze+EMS
 gLyb1lGJ/6h8HW+hh1rGbEkoaTnH/QlZTg5wUJ9SnzdjfP2NODMnucbeTfP7GXoezF3u
 vmnc7Xve0sRPAESxTan+6XYXARhg4Qm9An6AOCDW6gM/zI1JZra484kNHwoo7RdMDGMv
 uydQ==
X-Gm-Message-State: AOJu0YwJDFjJTWgQzIMEXroJ9Ank1r5qV0OOYRsweq7XbnUxHUH5j+Q8
 4gV90LGtJMa1gmANgzPCuGJNOMrXYKATlUcANoieHCzWA5SNAl4thehvEHG1cTiSiTGdi0+DDoT
 WskUEPzWPu2dCCVqFnZMhjY9Bw97hkXw=
X-Gm-Gg: AeBDievPOt3ohs1wDz/TTR0KCAyOQ5eXiTMk4IfEtKmMxwQm5ExRXGz9UMDmGH4+B6x
 TJck5Dgn+kS/yjGhSeyA78Nh9kVxusm+aaYzT0bDUvFjD9q2G2N+P937pRoDxdomRGdBdSchOrh
 VX7FdIECMs2/QBSPc1N4tCtOOAI3AYcLTY3sOIMe0gN57GFkZneXhBm2PzZUONF7Yturwdmd47P
 oP0vnlmGFiVUwBNbQGdr/tJQFnHA1fnv4GcGlzmikJ9mEY3/ZVgCdhkFcpw47ISSIrXYlbwyH9a
 8XWOPjYYvXrXuNI0RgXKNtPe2vK5hR9+jx0vKUB1O1Kzx6XU
X-Received: by 2002:a17:907:2da3:b0:b9c:617b:4a36 with SMTP id
 a640c23a62f3a-bbb97f823c8mr260132166b.21.1777599113345; Thu, 30 Apr 2026
 18:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260430090534.841894-1-pbonzini@redhat.com>
 <20260430090534.841894-3-pbonzini@redhat.com>
In-Reply-To: <20260430090534.841894-3-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 1 May 2026 11:31:26 +1000
X-Gm-Features: AVHnY4Le4tW3vCdYSTT-wwbnInlamIR6_ypKvk6YVcROPfTZPdBpRjut9r1G1hI
Message-ID: <CAKmqyKOFnkrkAmAOV-NXOjFE1RfwQw0fpfKvG+LLEFUGzoCNdg@mail.gmail.com>
Subject: Re: [PATCH 02/13] kconfig: remove duplicate declaration of
 CONFIG_MIPS_BOSTON_AIA
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Thu, Apr 30, 2026 at 7:09=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/misc/Kconfig  | 8 --------
>  hw/riscv/Kconfig | 4 ++++
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index f4d49248c08..99bdf09219a 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -135,14 +135,6 @@ config RISCV_MIPS_CPC
>  config RISCV_MIPS_CPS
>      bool
>
> -config MIPS_BOSTON_AIA
> -    bool
> -    default y
> -    depends on RISCV64
> -    select RISCV_MIPS_CMGCR
> -    select RISCV_MIPS_CPC
> -    select RISCV_MIPS_CPS
> -
>  config MPS2_FPGAIO
>      bool
>      select LED
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index 0222c93f878..2518b04175f 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -132,5 +132,9 @@ config XIANGSHAN_KUNMINGHU
>  config MIPS_BOSTON_AIA
>      bool
>      default y
> +    depends on RISCV64
>      select PCI_EXPRESS
>      select PCI_EXPRESS_XILINX
> +    select RISCV_MIPS_CMGCR
> +    select RISCV_MIPS_CPC
> +    select RISCV_MIPS_CPS
> --
> 2.54.0
>
>

