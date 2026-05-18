Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C74CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqBg-0002xS-9Q; Mon, 18 May 2026 01:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOqBR-0002w4-EQ
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:06:31 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOqBL-000540-Vp
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:06:29 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd85ebb368fso31906766b.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779080782; cv=none;
 d=google.com; s=arc-20240605;
 b=aDRQFoSGj1kKzeIT+cfQggGL2/kQxZiOY1kUJIpjx3zPMoQIPx+SJkcewDLqc5Tf23
 VEyTSO73h+W11PT9IPUq9dTsJTMXPrXl7w9aimtDGg8Ky+uYk3rFell1F0tv6whP2v3/
 wNyGBg9d1NSSAAym8LohGzLhMZTTVxC9f1psnl0r5P48F2Y2b6VINgICbG4O0aeYPoSP
 CsiEW7tfPlxxU8UjonqiMAJmoEel3dVyAdpIVScKSYSqsPFWi1VYdBzrUCFweJIWUSiY
 zLZbwLq7gKdYUbR/MbYHRwmNDKoSm9asj6z5ibrpkIDYhe/r97fvCq5oZeroRSyvokTp
 J7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3bykSsnRwW13pK4J3w4731v1FUdcYA9X2U+HFGNKB3s=;
 fh=mlu/rwcbLTJ6NOKEPShSMQL5j1Nxw4EitIiL7lEEXxM=;
 b=Ey4oitODk/JuaZ28Re0JxUMgkq0zFh1P1Bnc9yUV2dJGXVCt3ukdum7AEBg923ovWa
 TcBm2FDy7z0hUnNKtEbUjflddV8RJwRGlS5XfDpy7rLUj6eMiKy99XdrljyJUPSzGKA3
 lvpkgKbq4GBtxGF+5OLGzdoZohTMwtlI2+gkPjxjSmZ2JQOrCZRPqucxwb5VOffMbOt4
 Uoa8ibPxTsyxTKjLPvi1tObywMOOUCs+DLuGKM6qauQaBDILKkLs+cm6xqha5QNanDVE
 cyOxemH16ONW4K4XDrvXi0jJkc56r0MnScYW3wOAc/ybe3ScRonlEvrIAOlMj+jthuYv
 tmMQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779080782; x=1779685582; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bykSsnRwW13pK4J3w4731v1FUdcYA9X2U+HFGNKB3s=;
 b=UgVYIkyWb2P4PzaaxXk76viVo3nrbP/D7nd/tmaKnDITqpdM/tiRyeqjxyEoNbi+op
 czzH3Cr7I62p4RXOe5tWQaD5eE5l/m6a0z1hN7Xzbtg3moNVLCcKfHL4txVdtnQT284O
 zF3W2wXfxpxqEpXJdp8YMFyRflZCmAB8LnhbuHi04mHekI4u08ElDlnOHCA9gM+SgQeA
 r+LdiAv8mEmfTUZiT56Gn2kSfR8zEMNxh/acD8NLkfY+nTF7/13s/fOctglhF+hMH+JY
 3UM1p95M3G0DUOwBmx0J4SKYmSJdfujOZAfqO40drf09GyAgl52fjdUTlsfGyqBweZRo
 1S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779080782; x=1779685582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3bykSsnRwW13pK4J3w4731v1FUdcYA9X2U+HFGNKB3s=;
 b=T+WCTw2jxZGErwjqx4kn77w8uPmszXcN9NbdvJVqkc/5BBDMJ20REi4cYrqjnXUM2c
 rT9SSErSffUgf4mV6Ur7lBoIo8FD4AuYBlPiViiSQaUSIQVcIuwB268N74a9u7woSvUr
 WPJfuJaKsiCf7ZQgZz9VjBktXm0fdKK0Bq4WluTky0Isx1exhBYF3JHjG09mMudtASp/
 JaG/7ktEBY0PvssHQSvBq+K6vNbRa/XcmSa3PUMsjK6xTpmTvDm5y9Bq2dpmO/eCD0Lv
 SPBs3QEHaLnnaxSCwQOQo5T328Avac5b6F/FuQsj3CXAoij/De29kHyANfB0U96pZr0H
 plbQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GPX7BTit+OEsripE/7rNcKULW+zDr3iT33BrNfGMXadej+bxVjWlKPvUPsDBzmGnNCS2HoljM0Rzl@nongnu.org
X-Gm-Message-State: AOJu0YwGtYEXxxMsKjd3209yPlUwksjRwFy58d92icUZ8Z4wqVVSkgQP
 x4KeYb/eAiASSv2FOXQEIWw1kWLvYpkLb19OX23UHAVyPeABu69U66QjbTdXEGykjm9+7xCBYVb
 y+q15jo+AhNEDntuUV66ChfVFSefgz8s=
X-Gm-Gg: Acq92OEGiVJgrAhOLFpjLgpchppWXMS1t/PHtnPo9Wpf5zbnSXqBMBXBOQBexWPWB+g
 xzHqLto2ZIx6+ZQIwdieTTIsry8q/cnDYEWKIv4a10c81aXLM8dq5+iICQiuupf10WMuaOHkQXn
 y2qlJAnTSxxCfgPU1jNEpx4SuUV2QwpyW0MriNq0rxxJWyHlyhLhVPVQRfC03VRrIfIfwSaBRK1
 /qI521EtMdeFA9r8Xzy3RqPON3si7mVYQIyJmW3o80EICpKw8tSmeGvBWh/1oFdleQ9PhcARAO7
 vZf7KQPYgDmBX111KsF1pqFe+ZXgRIvR2gYMoA==
X-Received: by 2002:a17:907:3944:b0:b9d:8697:73b8 with SMTP id
 a640c23a62f3a-bd5178c7d45mr657404366b.22.1779080781965; Sun, 17 May 2026
 22:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260106080520.28711-1-jay.chang@sifive.com>
 <a696a6c1-c1b0-40ed-8788-da7bd4d0d73d@ventanamicro.com>
 <CACNNAjMsNS4RUR+nR5aPhsb-w-QwUDNTNXYpim4fxRrqvNKW+A@mail.gmail.com>
In-Reply-To: <CACNNAjMsNS4RUR+nR5aPhsb-w-QwUDNTNXYpim4fxRrqvNKW+A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 15:05:55 +1000
X-Gm-Features: AVHnY4IApd3MN7HdkyibGlsQJS1IPVd5HgLH4ktyCWmiPErr9PJJVYaUEzws1uk
Message-ID: <CAKmqyKNSzXgHEQwxH9Jg9g=TCZ=COr6kveUtYeRALteZ7oTZHA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv: riscv-iommu: Re-process command queue after
 clearing CMD_ILL
To: Jay Chang <jay.chang@sifive.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
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

On Mon, May 18, 2026 at 12:55=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:
>
> Hi,
>
> Gentle ping on this patch.

Can you please resend the series, I lost this the first time around

Alistair


>
> Thanks,
> Jay Chang
>
> On Wed, Jan 7, 2026 at 9:52=E2=80=AFPM Daniel Henrique Barboza <dbarboza@=
ventanamicro.com> wrote:
>>
>>
>>
>> On 1/6/26 5:05 AM, Jay Chang wrote:
>> > When software clears CMD_ILL or CQMF error bits by writing 1 to CQCSR,
>> > the IOMMU should re-check the command queue and continue processing
>> > pending commands if head !=3D tail.
>> >
>> > Per RISC-V IOMMU specification, the software error recovery sequence:
>> >
>> >    1. Read the head pointer
>> >    2. Software has two options:
>> >       - Option 1: Set tail =3D head to re-start from an empty queue
>> >       - Option 2: Overwrite the illegal command with a valid one
>> >    3. Re-enable the command queue by writing 1 to cqcsr.cmd_ill
>> >
>> >    "At this point, IOMMU will start working on the first command
>> >     in the queue."
>> >
>> > Signed-off-by: Jay Chang <jay.chang@sifive.com>
>> > Reviewed-by: Frank Chang <frank.chang@sifive.com>
>> > ---
>>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>
>> >   hw/riscv/riscv-iommu.c | 10 ++++++++++
>> >   1 file changed, 10 insertions(+)
>> >
>> > diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
>> > index b46b337375..e89a262a63 100644
>> > --- a/hw/riscv/riscv-iommu.c
>> > +++ b/hw/riscv/riscv-iommu.c
>> > @@ -1992,6 +1992,16 @@ static void riscv_iommu_process_cq_control(RISC=
VIOMMUState *s)
>> >       }
>> >
>> >       riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_CQCSR, ctrl_set, ctrl_c=
lr);
>> > +
>> > +    /*
>> > +     * After clearing error bits (CMD_ILL, CQMF), if queue is still a=
ctive,
>> > +     * re-process pending command.
>> > +     */
>> > +    ctrl_set =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_CQCSR);
>> > +    if ((ctrl_set & RISCV_IOMMU_CQCSR_CQON) &&
>> > +        !(ctrl_set & (RISCV_IOMMU_CQCSR_CMD_ILL | RISCV_IOMMU_CQCSR_C=
QMF))) {
>> > +        riscv_iommu_process_cq_tail(s);
>> > +    }
>> >   }
>> >
>> >   static void riscv_iommu_process_fq_control(RISCVIOMMUState *s)
>>

