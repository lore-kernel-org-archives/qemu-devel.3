Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C84FAD3F0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 02:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjjZ-0001ot-OB; Wed, 22 Apr 2026 22:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjjR-0001oT-QN
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:23:59 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wFjjP-0000ur-AU
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 22:23:57 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-79885f4a8ffso65446987b3.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 19:23:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776911033; cv=none;
 d=google.com; s=arc-20240605;
 b=fwhvACtcNj9SYJzdCEB97J1wskJuFrsnreDNl1+xp6E/iK2DkaU5HqB0q3E5MI9Fy5
 5RvB0RlfZAWLx0FKTMtyuvQ4tzXeIHrqFnUE7Mj452TiLKCUazIJkotV/+Nk6OxqMZ3P
 +MmG9l5J3F/Qf6KR5IJy2e9Lhjtc7mpOkD8Im6CR/f2QfJNkzMb/awl2lLbrxVUkPTOs
 IfeSa/ImnDHRm2EElO4KogJUXQs0zxO4N+0DogpLC3DpSd6f9QhIPQYX5QOaPtO0Lrdl
 rd99GrQilnzIoXdQJf/CD0dmSQ42qikaMoRC5A3iyBTY5myNZGGORgj6KkzVHrS517O8
 zBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a7CuCakoGxzeAIS8gozKH2+RGkp8kPxcBVq3hh+6O90=;
 fh=Oi7/q8LTYXnhar7Jxtpphz6tzu2ZEVH8OxycppvdTcw=;
 b=bgywRsUVuu4C7Pp2qzangAsXNKTyxLL9O2Dv3ZUvGO4TsvGJsJOLWfbZxvAuwiHnZ0
 h9cYkEDDYm0VUaeUGLr/62njVdoDUmrPl27O9a+n4aqLffirxpuqVhEb+9xxW6h+5h8J
 w1PMuONanPD2GAk1tNW5cpRRSw9N3xMPBPw83v2zaTPl3VTMDoeRPFqv31yJ7Zhqa/MA
 fwWwmMA3o1O/EJDSJv3vzUlYQft3XEbnWkr/E9nYapOa2qC3GKkKzB06mSQFEu3U5SVL
 NUEiO4FmFf5NbosKWhQYnR/dqDqeo1Y9Cxfw+FdFH60bkwURCbsF23kuiDm4YiP6565U
 Cn8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1776911033; x=1777515833; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7CuCakoGxzeAIS8gozKH2+RGkp8kPxcBVq3hh+6O90=;
 b=kbYWbYjkXCh29EpmCJ0s8+oLxCKEFU5M+nVzCiiBBBp2Ztw8oxzntKXzbLkqkUkbjw
 i/AwarNPv3H4FJoBZaBnQeJZC8HX5vWQKILZOCUyH4m6RxKsuJRWaxABb4oABoAk19qW
 d7Rk1TzxqOjtSTVtxOd8oOVnmOWPAfg57dlmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776911033; x=1777515833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7CuCakoGxzeAIS8gozKH2+RGkp8kPxcBVq3hh+6O90=;
 b=ZuFHYRwVOaG+qIcDd24S71NKcmtiHg3WgCGm5DEP/G5v3V7noAd/lxzJ1GG7cmec/R
 Hq3ishmTl1THEQAtYgNw0zpt6oZP24xJdety3o+wiCZwJiqAMHe9A85ev6dhFSg61EOb
 LdRaIJ9pcACafB5OPwerlOD6k0VliYlqf8p0FgaYKttoVCw75C2BUeGxqFD+eaZVPKzs
 1X3hl8I416u30lYTMl1CpzpDALrMfNqjBWh9kpi+8YqGlDA3Rp4SkEz+haDkIWEAP5kE
 r9SD/KSdbZgsVsZjAoMcMN9QpAGKoFgfgXw4PScL2pyX1ehRLzxgPO3Hnsld4sTEs2d6
 61qw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80aXPg+rgrIQhOJN32VQmC5vTNbLs7m9/265vAtolemjgB0H3wJ15suXwEFJe7ed2K8sZc/AUQWRr9@nongnu.org
X-Gm-Message-State: AOJu0YwXl1cxpbGpNvA0Pwf6J1BYUGNuXUa/hlTdC62tm+oOvE/9lU3V
 nCpvj1FDbZCpr2grt4LRuHFeZSbYGpGEaJO0WctXc469O0k2lw+07GyUE2vdAxBehnhCX8qdNmo
 sf0BVVVQ19rB4M6TlnjitAZUWQmSouSs=
X-Gm-Gg: AeBDiesKc10IQBaUA/8PpVIxoS7cTklzTQXAiBhF9BmELFctNVepXHAFPclx2mhy+T6
 GvOI//UJVOoxJ3bgwPsKriFRkQwwSEsDULy3CkrLrAmyqMa1MUcL6uWctZlP0STI7NLAtTkH3SU
 XCZMfvKrcpEzCFl15+of7vpx0fbx90/7hAvJjYOFKbAcBfGjVH59rbcHvT2clCaVy4gmTqVLh5Z
 5xZDaXCcMEksxiDzTynO0Welr0TJBiMttTag2axQhymE3lZ9GmHmqdYIRWctK4vQx3WgsoHfLhg
 odNpsxJ+TkL6Jm5iMMWD0HJAcVBHJpDNYETMqfdnNj/M5nQlRq6eeSNEUzkMYyMwhjzmvjfSfkT
 Bk4BMg6EO0hs=
X-Received: by 2002:a05:690c:e3c5:b0:79a:4419:71bb with SMTP id
 00721157ae682-7b9ecef09e3mr267698817b3.21.1776911033458; Wed, 22 Apr 2026
 19:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260421053140.752059-1-joel@jms.id.au>
 <20260421053140.752059-14-joel@jms.id.au>
 <42263811-2d99-4d2a-aba7-a19dda3b5047@linaro.org>
In-Reply-To: <42263811-2d99-4d2a-aba7-a19dda3b5047@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Apr 2026 12:23:41 +1000
X-Gm-Features: AQROBzDr3C1c1P1c-g3yc_v4eM9yf41F6oJRcoRn8Z37FU1Ez4tGL0G5rhSzXMs
Message-ID: <CACPK8Xcnac2nWu6_KqU4oEtxwNhVzrndF1baj9PbtoFeZMiUKw@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] hw/riscv/atlantis: Add some i2c peripherals
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Michael Ellerman <mpe@kernel.org>, 
 Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Tue, 21 Apr 2026 at 16:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 21/4/26 07:31, Joel Stanley wrote:
> > Add an I2C RTC device and a temperature sensor. These are not present
> > on the board but help for testing.
> >
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > v3: Use HWADDR_PRIX in i2c device string consistent
> > ---
> >   hw/riscv/tt_atlantis.c | 18 ++++++++++++++++++
> >   hw/riscv/Kconfig       |  2 ++
> >   2 files changed, 20 insertions(+)
>
>
> > @@ -542,6 +555,9 @@ static void finalize_fdt(TTAtlantisState *s)
> >                          TT_ATL_I2C0_IRQ + i,
> >                          aplic_s_phandle, periph_clk_phandle);
> >       }
> > +
>
> Worth mentioning /* QEMU specific */ ?
>
> > +    create_fdt_i2c_device(s, 0, "national,lm75", 0x48);
> > +    create_fdt_i2c_device(s, 0, "dallas,ds1338", 0x6f);
>
> Maybe use another bus to extend coverage, like #4.

Both good ideas, thanks.

