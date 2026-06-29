Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B701DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdzhU-0003z6-Eo; Sun, 28 Jun 2026 20:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzhS-0003yG-Dm
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:18:10 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzhQ-0007sd-Po
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:18:10 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-697ebe536b6so4230236a12.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782692287; cv=none;
 d=google.com; s=arc-20260327;
 b=HV+A7IidIbcuiti/edJJzWeHHTkcHUPIXwaJGUmW21Z5zLE0kI2UKKrgzC171rI//4
 ifTC6rWa3hY4Ijuq5Jhqq3mqwrf6u0tkiIQoeDn5JQ14VrGkBUJJpkQWzGLsP4EUUH7i
 DvS0iJQmi8L0C+Xz/cjl1Rzn5WT2zL2OdFr/jJmv+dsSIc+sbl81Rt3f2G2aQqa1NHam
 pdUmwFfyxmQW4fYG/RW6R4iJR1nOnQHhFpXSKhglLC92vVF0QKO68onY5eZe6ys+EtYI
 Kur24btvYsbizdYudYoJMKV96NPqMq8+kLAeLhwB8gVaAGGZJLb6jw7pZ1mgrvPIMa8C
 agvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S5VdgrtrykuT2SBFFNPAvTpbA3okMDwxE/wj1fMTAsQ=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=KuOWAw2esirlVzAVvVpUTJOYUHnarjWpfFBRJws3GnxZw2UytBC61YF8//qPLUVCft
 WjfhsDg3EXYJLxpz7X3snzg+8LH5fpQlTws1gFUza3tg/bp4uZyHuczAVIKrSW7h+zUb
 TK/RdsWH5W5vrE0V2tXe/YoylkCWVMeqUxuYPt2kn9iFfsuV+9JoJf8gGR9Sz9P6W48T
 cVXcJCtHJugrPzU/TfYyL2KjphJMDpWQEAsyCCIyOV3TuzkVMZW/iAE5BHrKKGRhlxgr
 gX74Xd1Vygfa/4jMhJkkAC2X6nLw8GdTFsIoJgkgmDk5uTvKr90lvMZGodbopP/1hFBC
 Wumw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782692287; x=1783297087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S5VdgrtrykuT2SBFFNPAvTpbA3okMDwxE/wj1fMTAsQ=;
 b=n/eiqO39YKDcmXWkrAGnV5sDdiJqeGbXcC+WZ5y+VEau9DSPMiaGssbnbnaD+zJd2C
 W6DOe9fykvsz0tAVkdXJWGmCYwiKXAP2mSw93E7/5WQzMNZE/qS5RXfgtliTZd7bMjMh
 uKKQkZhuU9YNC40YGYUWOMcKuCBJn0kLq2DkRisdkwUpEvyOcgLEwOpa8KfqB1dguGlZ
 Yp+Vk+96HlS5OHfrvf3rLxyFv1WMhQgbEyMOQhS8pfeKoV6hnO6F1Vw/WGPn3o2c3Fcl
 gMvQ9SnSTdNIXK/EjQZ2dRCx0Ebjb3wJUd2EaudrulAsI0ggpZ0L/CZi03wgIIMSDB9W
 laFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782692287; x=1783297087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S5VdgrtrykuT2SBFFNPAvTpbA3okMDwxE/wj1fMTAsQ=;
 b=kIPOy70NTBVWLRExzoOZv7KIVb2tTUAwGZhBjY+4i+OY/22TAGQGsZ5JZLHsCPFNYw
 F1SsAgK1Sjjf2tzSzTlcSQJzre98OgdX4ydYc7HTW2EbaXOJrloDmWzHtlI5ZCbjnZtM
 ouDONX6khWg6TDfQCYPe5hkvFpTbNf9LtvP4xsiTe7ezsiIA3WsDBF/4le2eLQ+Z8nD9
 HYVHF2deH3hueAxbmMbe0G4vVGBlljfXsNLTCf4BxBb8/8hNSNC4yVtxTsQT3e6VwbrK
 U/wZ0JEbyUyChFKrjZJiwgyXVNViyG5+jYEtVF1TPspg7y4boDd1CXptmcL+2lc/Sao/
 jc/Q==
X-Gm-Message-State: AOJu0YwOivDaljl5KY4hioTrObhqx/m9VAvtb6h1js9+FZeqgNwMZTbJ
 r18M3ZJn1WbeafP28TmiLT5FMQAsHkJnc4wK1GhvoB+pfEGYNBrKbd9U5WPHCbhnn6q18zseRYS
 eK0ggYXfxG103Ega7zl1q25ch8SuC9xQ=
X-Gm-Gg: AfdE7cmn+vHAMsi8mebMXlJ01z4Hizp6jgUsM13VgwB/EyuFenpHdIIUN27mn00d7rH
 oCNHxxie1jfXIgo9+6AsifZPyuVlY5GXU7x2lcXKnX62EBMSoOnt4Rk0ilvsQ7cnw2mgiuswNnL
 /KJG2AwjUSOmGER8NaKYAJnK/kwBxd2JRdZmHQtk6SgkaFfxPN+o/1M0RLiY79if/4QqnYxFo6e
 7VYuj9q/lPxJrKRPPZRaVscVLPYGRRxOJmWpkHPqYM09VHSeky7ESz3QtElAwyZdRM4r17wLxci
 hZR0kC8GgSuX7tCfKpz5XYEnWD0=
X-Received: by 2002:a05:6402:26c3:b0:697:eece:eae0 with SMTP id
 4fb4d7f45d1cf-69835e1da6cmr3388367a12.6.1782692286898; Sun, 28 Jun 2026
 17:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260626170533.3562484-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260626170533.3562484-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:17:40 +1000
X-Gm-Features: AVVi8Cf2lUIVqH7LanLq-83E7Wby7lcUHLbQfQDmvpG2exUufxdhQB7YAgpzV7I
Message-ID: <CAKmqyKN_TtWVqj=92FtUa8y6bcdhziBsP3TpbY0ytoDFnNRvjA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are
 set
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52d.google.com
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

On Sat, Jun 27, 2026 at 3:06=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We're not setting RISCV_IOMMU_CQCSR_CMD_ILL if a reserved bit happens to
> be set in an IOFENCE.C command.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3575
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 1 +
>  hw/riscv/riscv-iommu.c      | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index a938fd3eb4..60256ad9b8 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -344,6 +344,7 @@ struct riscv_iommu_command {
>  #define RISCV_IOMMU_CMD_IOFENCE_OPCODE          2
>  #define RISCV_IOMMU_CMD_IOFENCE_FUNC_C          0
>  #define RISCV_IOMMU_CMD_IOFENCE_AV      BIT_ULL(10)
> +#define RISCV_IOMMU_CMD_IOFENCE_RESERVED GENMASK_ULL(31, 14)
>  #define RISCV_IOMMU_CMD_IOFENCE_DATA    GENMASK_ULL(63, 32)
>
>  #define RISCV_IOMMU_CMD_IODIR_OPCODE            3
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..d47abf9eb3 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1876,6 +1876,10 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMU=
State *s)
>          switch (cmd_opcode) {
>          case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
>                               RISCV_IOMMU_CMD_IOFENCE_OPCODE):
> +            if (cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_RESERVED) {
> +                goto cmd_ill;
> +            }
> +
>              res =3D riscv_iommu_iofence(s,
>                  cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1 << 2=
,
>                  get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
> --
> 2.43.0
>
>

