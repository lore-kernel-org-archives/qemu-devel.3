Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2698DE98FA9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgSH-0004FQ-42; Wed, 08 Apr 2026 23:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAgSF-0004Ef-FV
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:53:19 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAgSE-00040G-1g
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:53:19 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9c01854477so65841366b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 20:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775706796; cv=none;
 d=google.com; s=arc-20240605;
 b=QUuQj10sLYj9qhaCMCswMtf/zjlskefEvsJ+0lBYT+CAwWKDbPhETDiMAAbRrQJxgk
 SVvYlB8Yrn0TgwNIbTP+Fz8SFWLWD5D/7cGXtdMZZpHk41bxSYhZCHGlsoawl6I/jvGN
 hfuxETty7/Uvuyf+reqbYxBJ9c2oz+SKDaKcVIqcXw2FPs46/y6bg0EWOJUXan6ZHmt7
 jC3Ilkx+PF42ALDKEXKHJGWsoBRoLTECNy9JcfZXvk2y64GkctK4g3NzNVLNhXoUliRD
 AafA79ELileXZXifjr2uhf35QqSAPgIeJx7VVrfTO0w52mO2RxVkLwkhHerVWzm2b58h
 F/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VBu5mcWEbdjahiPvG7VdSBiV8AzB2z4BH34OFfg0hIk=;
 fh=02yfZO3MCi97EyXeoLg1BYIgpUdGEMk3Yh61+offrCA=;
 b=FO1ng+pQZecV92raiRdxLl7bQyR3Y2O6Pi0G0HsED5y/aNA85EwnEQN/MP9STeaxjG
 bbmF8fnldCEXmhhnM9Z+0KCXZy6F+POTSwOcIl24OYoNnkOprVuI4kNLXwYShYzYtTfF
 7k2/l13FDOJOecQ0LuNYp+4+ZbXh4O6g+EQdpkNdP1ClzMeOibpsHc/5lOeKvDYDjjyz
 o+OdFbBej782wyweQwAXyoQTribuXuadjcamazA0l8ZxMKGMFieuMtUh9sn0VbsNScSl
 aI5fitmrfHjwopRZ/XpFPb+uPJ2pDtt6/ETXTSM7yBCuexyJbUOfUCDMdIH+jLYWfadk
 4lxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775706796; x=1776311596; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBu5mcWEbdjahiPvG7VdSBiV8AzB2z4BH34OFfg0hIk=;
 b=mfFYNb6RehHefrhpl4NU8ADi6kJ18iO6X1RwkCfqTZ0+heZNTozz7B9WQCbGwN+Dvw
 4RrdbC+klRukuPLpiKhMvVfBYC64jJfLKt23G1fM3lTBP+GHNf/lSGCKSPKbgH3Z/Iku
 4KpxxzSbPFB7VqDcsq6ij5uOxU5deWDZudUdKyakRw6gxJbpOD50IAyH8wfs5ZZrZuFD
 Zrmr1z+w6/sWMKLF9oWT9/sEAM/j2NL7H5ixDVgo8OCKTKJj/sdvSvXhYhM/8NCvYeJT
 UuVYqozPPYmQMfJF5BEBwevdiSuk/d/MAPS8GBImmMQI2dEBZYowo5cl6N9MbdUmIya1
 0Aog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775706796; x=1776311596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VBu5mcWEbdjahiPvG7VdSBiV8AzB2z4BH34OFfg0hIk=;
 b=EsEbRG4XeI+HWN3EjnQaO2Jos6ONGVReJnqg3wkDLRjLq8O+CbsNZP4E0yPuUjffq9
 o3zykCmLRRtHRxhE8P8rDHY9/HWYE4ybrJXyg8bze+jQ5BqCEcB7OzWJBASBZufUxtG8
 O4bSC5WKXm3/2WshaRSISi3ga+ScvEYn84f0eh1saVUoNmcUfcdAaLXGSSk7D76DVSfO
 320a5PKUD/Aa1eAZpUt8yYit9fRCZEAlZFGtyDmWl5UOwm36ltHLYKTncarBhdyicKc7
 OF+lJYlfHgEkO59ZYG1RTqZHGHnSGeOw4QzkhT9zhRub9XaaFHmN0eiTR/yxifOyqmx7
 +fMw==
X-Gm-Message-State: AOJu0Yw3uaw/G7R4jARwv0MDZsU2HdVGSeaXxBIAnTwLyo1JRAn1fM8Y
 PYaq2K1SgGYrnbGYRzOUh8zVFBcxbjkYccLN1IkiTHjOVULlipcld5Zrc6YpMsVRqtd5adjXpyW
 T5CdrU97no57xloqAReLI3UC6hCQi1mHWqQ==
X-Gm-Gg: AeBDiesW1KenyP/HZ5Bi2gfPGkUXwJV2qbxujhNzGECzhOkfVBzioLDb/Yj5vchs86r
 eBTv6bVzHPQyEDUG4qOMZDoDNG5QeAgIWMO0OM8UKNfCIztpkN91W/LEC331rJqRVkETVs0hM9U
 96u9tvvnZiHE/HHEJXIDkENAlXWszqwfdudMz/raCFhEWIhCt1YPVQGEo7uJ4PWn8XBUs4R4gll
 6ZNc2sRB0cbrK+9iA1i5xXO+wRRzykLjizbVfY32AO0vEgazu98sHeJplfdsUMPOUin51Wq7+bv
 s4IoEIcJNG5uIhg3LWcL3P8uUYyzwfOPV5jT0A==
X-Received: by 2002:a17:907:6e8b:b0:b9c:a451:33cb with SMTP id
 a640c23a62f3a-b9ca4513bbdmr898792566b.22.1775706795462; Wed, 08 Apr 2026
 20:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-2-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260406154935.144674-2-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 13:52:49 +1000
X-Gm-Features: AQROBzBGwmg-7ateGZx7VM6GyJYjfqzEaFmYhKfaWSo54Az8I0RkdF6ALIWKdxY
Message-ID: <CAKmqyKOVXRHS35JsfJy=F+DZZG5LMa-aW4ZN__vxANqB7pjKZQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] target/riscv: Define MSTATUS_SBE and MSTATUS_MBE
 bit masks
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
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

On Tue, Apr 7, 2026 at 1:49=E2=80=AFAM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add the RISC-V privileged ISA defined bit positions for the Supervisor
> Big-Endian (SBE, bit 36) and Machine Big-Endian (MBE, bit 37) fields
> in the mstatus register. These are used alongside the existing
> MSTATUS_UBE (bit 6) to control data endianness at each privilege level.
>
> The MSTATUS_UBE definition was already present, but SBE and MBE were
> missing.
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index b62dd82fe7..c2a3ee4bf3 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -628,6 +628,8 @@
>  #define MSTATUS_TSR         0x00400000 /* since: priv-1.10 */
>  #define MSTATUS_SPELP       0x00800000 /* zicfilp */
>  #define MSTATUS_SDT         0x01000000
> +#define MSTATUS_SBE         0x1000000000ULL
> +#define MSTATUS_MBE         0x2000000000ULL
>  #define MSTATUS_MPELP       0x020000000000 /* zicfilp */
>  #define MSTATUS_GVA         0x4000000000ULL
>  #define MSTATUS_MPV         0x8000000000ULL
> --
> 2.34.1

