Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E57E98FB0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAhl0-0000fR-BN; Thu, 09 Apr 2026 01:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAhkx-0000f0-VJ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:16:43 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wAhkw-0007yi-De
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 01:16:43 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso81449366b.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 22:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775711801; cv=none;
 d=google.com; s=arc-20240605;
 b=k93GuvirIwMlozITXSABo1guIE2NKVltqM6CCfq5X9jmC3Gxz1JcciyC8a11ZcNmOE
 /caqu0QKziZg+uaC2DTMO9BBM3FtvRzaNpyNxJf4JeN4ctBdspnL/JVc5WBO80wtzcS9
 zbDXOwC+ySqq7xtSMxWc6OVVfT5uWJcqPNfw8RY8G5+8QaK88snGma0YzOHqEHH1ED7l
 jTeeggsZ/BzyVcSefaHVJInlF/jwUsSJb9ISwNXxtY0tbbed56dvt720yh3k7RzQCkd2
 rxTk+Pr44YC0/o92mSKp8htXkF9GW6O3Mikq1D0+Ef0ZEtlMwQ/cGMUcHXkNHT12sIdy
 8VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dP5uBhD4kNgDn8CMcJifnA/2h3xLQK0BqtMF9uzugus=;
 fh=EepXk2OmHnRC1HWocdc0alziOF9x5TpT4Q6SNJHadeQ=;
 b=QoLRszvmmkH3KK/8RvInPVrn6P0mscM9nD7v/9+UPMRAWGyW0mGR/sz94gxwiUF9Tc
 COWxl3v9GQR+KVC1tELQ9sO87Xjvl3OGJcyL/dxi3gBhpeRtJp+9aZQqvC4UvDsVXQSP
 1mEzrpNKZ2dRm9X3mc36PLCITicgMNTWZsZTgygwodaZk27u+bt0f1kPz0+wJTA4D18d
 K9ytKT/wQc0JYqO23MIHPgRbHUPd1bSTS0etFqbhI7394wwub+4hYkuP4iEEMhwV2eqG
 03mpAVvGswUQbhLqvkkXZTknkKJCO2Z8RDdYaFeqmWQrXcKQoPwT7i3mZRwCzHPfAI6v
 PAGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775711801; x=1776316601; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dP5uBhD4kNgDn8CMcJifnA/2h3xLQK0BqtMF9uzugus=;
 b=pYLNC0g3D21qGsxoTv0/lCazEpkrxbVRS232Flof/UBuR+AOkU4p7M36qdzDHnaMte
 9zYUjZGxGWwmDUzapO/ybAkv2ncKguyMXI8SEJZnyCqPzCzoZi9R3LcwNG2TYfrjDx9e
 DMyijfYVg7WU0hQHix0yrX4RHkVAji6U/DONSB1IsIuC05gKjXnWKQF5tBD/IlyOc0VV
 zfpp35C4Q4QJwM/Lyj7SmXKVCcHfLP/4JTEaB0k0DbQZB2iZF/j+GYstZzmCnB1vd8lM
 sB7a++Tx5IdR4FwBKWL6g0Ixnue6jUFBE4DkydQteEiuFy+sFTp6tbs6c1bL29GyGK97
 hV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775711801; x=1776316601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dP5uBhD4kNgDn8CMcJifnA/2h3xLQK0BqtMF9uzugus=;
 b=c3DAJA3qam2vwQY3aVmB4/gN6zVqM4+bN8NePJjkd/aXNClYcMf+mRYT2FyZ7Y8SS3
 7AtiPrrVNh/JhxsevnWFg4Jx6KTW1ikScmU0bsisWtxby43lIzpLlGOOh8aKHFb0yuQZ
 5AxPprE+7tyPaCd0QxGaCDDbx14WrZhtnfa38LXa28XYU07fSFnq+ZGiUjMpJb7GSxr9
 Zv2G3arQO+MCEslB3dsoVL73PYvjhbK7kD5vNvJ8yaNnr8iSxJGU26Y9TBiwDqQe67vr
 jNcVGSgBHEDfq+caII7xED+MsGrog8cGpLjK7C4DTzKL0crMpyTURg/8f71vw3mvkwa6
 Jrvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9KnUrktcxCSLxaJerSWrmfAC2AqqELNhUPHA9M3eMEz3SuwY5Ur3Z9vBYLZbJPs37DzzDjMEk5xTo@nongnu.org
X-Gm-Message-State: AOJu0YwRSPH3l/oV6izQZxdHvjZdcIIw9wMbkd1LuM1bpW28JSdhm6vO
 1072QPmkWapyQ/UA/7P0SnH6bzJqjuIaJtItZo4JrUCfpaIcn/qhH5RVtW4A5EHb/jl7CIVewNd
 hvnmRwJ/jcm70cndSr3Sy6ZC0U9PA1rfa5x2i
X-Gm-Gg: AeBDieuQHBbZKnslh08bmro/03H79dx+Re/uY3yVGSNDzLv9s4AM5sNgHhYpEhTFzSG
 9aYEW/xsgoCSE4otihhmXYI8HEH3fbkh+G8ksNjNVkOWEohmrINzq8th0ZTKpmUl2Quy2P+9TMw
 D6ThgW+9/W2ajJ6rgWUE8qQWB/zplQEzmEw2RvcMbvmMyeq0OQ3y2kV/QwS2J34Vu1xNaQwdr4v
 wOxZFCLZrM+7Qh7OLPyNIlE4N21rRILUrlDxxkUr3FakdrLTknTwhJkahRr7F79kspOzIM3mdvt
 QJbq78dclZrDUFGA4Cfmv4s+Q/6YCOlUh5KeV/agZHRHT4E2
X-Received: by 2002:a17:907:960d:b0:b9b:207c:f7e4 with SMTP id
 a640c23a62f3a-b9d460a0ff0mr106527566b.13.1775711800285; Wed, 08 Apr 2026
 22:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
 <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
 <CAKmqyKPZRQ6djtJU2w5y=5i6Bt3Nkr7yOe+K0vnj-m_XKvG=Kg@mail.gmail.com>
 <55bf85d3-3b62-4dab-9b21-ec1ca193dd15@linaro.org>
In-Reply-To: <55bf85d3-3b62-4dab-9b21-ec1ca193dd15@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Apr 2026 15:16:12 +1000
X-Gm-Features: AQROBzA56eju3UOAgddFSVZOPHgSw8vorV7eE1wtdYJDEpkMzLMeMdKaFYEg2QY
Message-ID: <CAKmqyKN=pn997tWzN+-7rFT5ksN6hq7ae3nLW2yDczcCqCWhnw@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "thuth@redhat.com" <thuth@redhat.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Thu, Apr 9, 2026 at 3:04=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 9/4/26 06:00, Alistair Francis wrote:
> > On Wed, Apr 8, 2026 at 12:17=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >>
> >> On 6/4/26 17:49, Djordje Todorovic wrote:
> >>> Add a "big-endian" boolean property to the RISC-V CPU configuration,
> >>> defaulting to false (little-endian). This property allows machine
> >>> models to configure individual HARTs for big-endian data operation.
> >>>
> >>> The RISC-V ISA supports big-endian data accesses via the mstatus
> >>> SBE/MBE/UBE bits, while instructions remain always little-endian.
> >>> This property provides the configuration interface; subsequent
> >>> patches will connect it to the CPU state and translation logic.
> >>>
> >>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> >>> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> >>> ---
> >>>    target/riscv/cpu.c                | 1 +
> >>>    target/riscv/cpu_cfg_fields.h.inc | 1 +
> >>>    2 files changed, 2 insertions(+)
> >>
> >>
> >>> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg=
_fields.h.inc
> >>> index 70ec650abf..51436daabf 100644
> >>> --- a/target/riscv/cpu_cfg_fields.h.inc
> >>> +++ b/target/riscv/cpu_cfg_fields.h.inc
> >>> @@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
> >>>    BOOL_FIELD(ext_xmipscmov)
> >>>    BOOL_FIELD(ext_xmipslsp)
> >>>
> >>> +BOOL_FIELD(big_endian)
> >>
> >> Since it is runtime it doesn't belong to RISCVCPUConfig.
> >
> > I think the idea is that a user can set the `big-endian` property
> > (from the command line or machine) and then MBE, SBE and UBE are
> > always 1 and big endian is always enabled. Basically to model
> > big-endian only hardware
> >
> > So in that context it isn't runtime, but it's not clear from the
> > commit description. Also if we are adding a property the property
> > should be exposed last, as in once all of the functionality is
> > supported. That way we don't have a property that doesn't do anything.
> > We would also need documentation added.
>
> Reading "3.1.6.3 Memory Privilege in mstatus Register" it is not
> clear to me whether MBE and SBE are hard-wired, I'd have expected

They don't have to be hard-wired. There is a note in section 3.1.6.5 that s=
ays:

"""
An implementation supports only little-endian memory accesses if
fields MBE, SBE, and UBE
are all read-only 0. An implementation supports only big-endian memory
accesses (aside from
instruction fetches) if MBE is read-only 1 and SBE and UBE are each
read-only 1 when S-mode
and U-mode are supported.
"""

> a HART to be able to reset itself in a different endianness, and
> in that case the current riscv_cpu_reset_hold() would overwrite that.

I suspect a lot of big-endian harts are just always big-endian.
Swapping at runtime seems tricky, although something we can support.

This should all be made clear in the commit message and some documentation

Alistair

