Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B22EEE20AF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 15:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNlc-0003Pv-D1; Fri, 06 Feb 2026 10:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNla-0003P3-2V
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:29:06 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1voNlY-0004ox-As
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 10:29:05 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-790884840baso21904717b3.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 07:29:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770391743; cv=none;
 d=google.com; s=arc-20240605;
 b=dvNlCrGvUYctIoomO5chFX4z6+Ewk+FVvb2D+LLZaj0TbT94k2yUwxbC4iKOEIVIJ4
 SUnWRWhlbz86E0lmFGfaKtHYJ1Tnfp0Z3TsEwjsYgAk4rU8PkbCstLvSYLgIlc/SyBhW
 vgeuprCf8EiwN2edczrXoo8ELwbcA+SEHKG26ACAeMAta33VzpMxR7UY/gyyBKcCD0Ko
 QytQ9AHsSkcvOC274j1vKGQs+3A4f2Tsl6pxk6DoNY69eXapYNnnJriZggCznwqDuNDj
 v3fRJ+4xYJOCRYW0yFX5DeCcTP0dZvWtFJXuL3/dwafcULH58MenzvJPudYq2W7jQl2+
 AgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W/EC1oBs1ewzyTH+kZEMtwhXVAiWd9mTj1Nuyn37lIg=;
 fh=jFEzzJxDUju1ncw/X5l3FawkPgjsFK5/Ab3CZmCEtxA=;
 b=l3IVUFPMk7OQkBPnqG4jmroqBce6A4GzNLpcoqOzvkQbFTNekfo8CWNHpdZHdWeoYm
 +wxf9UnsOMIC0CNyG4znjn6HBU/CCfXSx0aMIRHgzB9f+x2VRkJt74mFzcHraSr+CyXF
 EjQpsUQBblp/O+nZpplkpS31RMZUpaD++++29ZwClwCSw8fCThSPlSfJFFcgIHCZVBMj
 i69MFbVecMzbg68jneFFX3TVl0bZGSMXYBT+SkJ9lObiQU4PNZKSKdpokr8DLKfT0g2d
 nYBv2ao0lK1oqWI3k+UNPG8IZ3aCF3xL8ixvZGkjWFJ3fWZOZrEXWRUv2NUCApm4kWkG
 3t6g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770391743; x=1770996543; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/EC1oBs1ewzyTH+kZEMtwhXVAiWd9mTj1Nuyn37lIg=;
 b=VYFACtZlAvEd3PXqvmrXfsPG1PZCf2fQ96OWfaQuwm4PIDBxDW3BXkJuBFMLTkMX7R
 3+bEzLj2MDJRg+mJ8Mt3NSsM/7kpC2FODUVXPj/73PZSi9JzZLHzS5kWGeMt8ARK8Mqv
 RSb1xRas1W0lsEe1vsVl64M/7a+5sG6oeGWx+CHVCvoG/Yn7ijgp/aX49iZSeyyReriN
 +91FxE1dmELQvJV3Q6negMPuvIzbYVuR6Z0/Zy908h3QhUpvq0BAHmENjNcepdWOWfcL
 LUfetTZwSXrit/0ZGB1hRPYk9WTlKN3nZL+zi00xRvw27JQr+eVe4okPF4e85Q5azy1y
 cC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770391743; x=1770996543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/EC1oBs1ewzyTH+kZEMtwhXVAiWd9mTj1Nuyn37lIg=;
 b=wNyxdwt/bN0Hd2uG6Gr6StWce4EUxfiD6OE5L/bmzqPgXnfELVAoLo+k1PhMu21QlZ
 +VGrBHM3BBjXpgE7Z6Rb3eny6kqumj2xceJnvhRfUdQ/+lBUBp8X7D2zsidRxcecghjN
 dff2/TMJLEmVVrD1Vof+f+/dzULAYZ4ZR+3NTigYlxsvqo1OFSzTQFqpjrnQhwXaJAFb
 hTkue5kFp8TrhQ/SvvnG2kwnFb2vYWkTF+/+XWh688gGXDOqiODcMIHgbo/oqGzrhqs4
 J7jDXmw+myO9Bl0nLgjmTbsvUw2Kq1EJAk36rsx5NfOpG5TIV1IAwqRMzXocmliukB5m
 tI+g==
X-Gm-Message-State: AOJu0YwUDcBKWAYgLd4vy16voZjO+cyPDtprYFAu99ytdUXacH4BhrO5
 g7sVcZVYBjMaMMl8t6ZGvE9EYCsG7igvF6DYDgTgUG0cidOIVkRirzJwtm4UFZltlRk5jp6Wb5x
 OsiPZZQxs4EoT6ETl5xB1mxPkqGYYmOwAHzoClEcvEw==
X-Gm-Gg: AZuq6aICq2z+xj1NDJqTPqmW5qBuHlgDxtv1uJv8UXd3X1071NgbNCx5X56UspjCl3c
 WhIwLg3FKaAbyvS2XPJc8vYnWdvoapCLuH2tBTXlBKnoyLVTX97V0MIMxV3navDxeUu4VG7sVhJ
 QwkvzEtIwW38xa3O8a+BexE1Vrr4Fqgx/nmg7m7lkdiJkC0Utgk0v4GB/7KaJx25CzpecbepPxo
 DxafDnn+LSoNrdTvANzrv+MfINleUiFk2rb6q/ku64zVHlu64unYWR6g0EJvKo7eiNGPf+YMg7K
 vw3IBWaFgD9+ZQUetdhmoTzIabSILEk0pVuHeNp+llEFj99p23MLuW4=
X-Received: by 2002:a05:690c:f81:b0:795:1f65:4154 with SMTP id
 00721157ae682-7952ab7c6d9mr29299997b3.64.1770391742901; Fri, 06 Feb 2026
 07:29:02 -0800 (PST)
MIME-Version: 1.0
References: <20260202153618.78675-1-philmd@linaro.org>
 <20260202153618.78675-2-philmd@linaro.org>
In-Reply-To: <20260202153618.78675-2-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Feb 2026 15:28:51 +0000
X-Gm-Features: AZwV_Qg_0BcctXaQStDMgnJhrLIefby8I9YJsgSPR5ZP0MwknPs1oZ83uyNgsuU
Message-ID: <CAFEAcA8CtzzyWQxeV+zBZMU0JEacctMGvC5dezR+n3J7xKYiNQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/arm: Remove dead code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, devel@lists.libvirt.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 2 Feb 2026 at 15:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Since commit a0032cc5427 ("target/arm: Make 'any' CPU just
> an alias for 'max'") the 'any' entry is never used (we use
> 'max' instead): remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu32.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
> index 0b0bc96bac2..2127d456ad6 100644
> --- a/target/arm/tcg/cpu32.c
> +++ b/target/arm/tcg/cpu32.c
> @@ -897,9 +897,6 @@ static const ARMCPUInfo arm_tcg_cpus[] =3D {
>  #ifndef TARGET_AARCH64
>      { .name =3D "max",         .initfn =3D arm_max_initfn },
>  #endif
> -#ifdef CONFIG_USER_ONLY
> -    { .name =3D "any",         .initfn =3D arm_max_initfn },
> -#endif
>  };

This is not entirely dead, because it's what causes
"qemu-arm -cpu help" to include "any" in its list.
But we already don't list "any" for the qemu-aarch64 help
output, so it's not really a problem to drop it from the
qemu-arm equivalent list.

I've applied this patch to target-arm.next with the
commit message adjusted accordingly:

=3D=3D=3Dbegin=3D=3D=3D
target/arm: Remove entry for "any" from cpu32 arm_tcg_cpus[] list

Since commit a0032cc5427 ("target/arm: Make 'any' CPU just an alias
for 'max'") the 'any' CPU QOM type is never used, because we change
"any" to "max" before creating the object.  The array entry means we
have an unnecessary type in the system, and the only user-visible
effect is that "any" is listed in the "-cpu help" output for
qemu-arm.  (System emulation already doesn't include this array
entry.)

Since qemu-aarch64 already doesn't include "any" in its "-cpu help"
output, we can reasonably drop it for qemu-arm also; remove the
not-very-useful array entry.
=3D=3D=3Dendit=3D=3D=3D

-- PMM

