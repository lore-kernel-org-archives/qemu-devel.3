Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E696CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 03:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLBua-0007FO-Mh; Thu, 07 May 2026 23:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wLBuY-0007Ea-QI
 for qemu-devel@nongnu.org; Thu, 07 May 2026 23:29:58 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wLBuW-0004G7-T4
 for qemu-devel@nongnu.org; Thu, 07 May 2026 23:29:58 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so263993566b.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 20:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778210994; cv=none;
 d=google.com; s=arc-20240605;
 b=IPsSwegupsgc2rdd/dN2f58dQJkU7WyayWVnBxCLw5h8hT495lOYOIfyXkjwAWXybI
 Eydzu+Ce/pyRcP/YNwyzBkBefVRSuudUbZmPH9ugKIsWhuxZITyUjwrPGa8qjO0g/KDK
 dLwqLVrE/aC7HdiOkTj7/X+gpmzswvvMnm6+6JG876DoTHNzDwlCzBy4YY16DwTJ6O25
 8Nl4fiYQ+zL2DAgMF+8TivlASZWZUfXlNrQt6M4Y9lIUK4GmzR6M9KPuzCPH1ki/Snuc
 64tdgWdlUpA7/ka4bTupwG9mDDE5HlmkYD09Mdt9pzQp9T7z2DdGtF0ApOjl0kCojEwU
 HAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lJmhjOsKwlhumjah92E6QoOuFpBkBkboZyPtw6rFI6c=;
 fh=SC1L93LGCKc+D+prAgBzcGhZSGZK00BC1EfkABOzKA0=;
 b=jgQQB0QCtHbQj1j3iyxesVkIs1DbVQbsKaSjnUQl+Dm4icVs6uQ7sSHFwlzlWPnoWr
 VNKNCiDy5wf9WbrLvdJ6hYwh0b3wa+gx4Ujsd0miAfbCDnpSJgVUo7jpCbqAkh2LCnY4
 uIlC7Qbn1KVlaxHxrmRUMfUNvzTtPOUi+91oNPjXp0kpXf0lNXttpBtD1KfgToPFO3cN
 ZxMGarH2o+4WeDbZfC+3DZ5qblchyqGeGymB2vTc6KaBGdSSKZz3zJGYm1zldPt7BJjo
 PgtVjm5jEo44uTN7sNlJIq8M5gkApg70K76DnwCSCYZFQZxG6iPHvdm3466iqtIkYZZj
 EdrQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778210994; x=1778815794; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJmhjOsKwlhumjah92E6QoOuFpBkBkboZyPtw6rFI6c=;
 b=W4I8JPIDyqaUmSxRYhgLplewUizAsOOB6+/dU788o4voZLvOH7fLBARwyqS3chZzSj
 CB24sTgiYsz2rW3SOiC5yiuZVZJ2235D/QeoN99NXUlfT69oxqf2xSqX5zdvlq7b/+fW
 LmKzne9SMloxbzpEmcN51BojiUeW5akHb9q63BrFe6fD7euX+jDE3ckLl6OxGMnWKmU3
 DTaGJ8unu+9++HrVC1zfM5mygi94VUxoX7MpDaheWIUh0CEeAwjyWYm0rUMIGGeDISzE
 yzsTZFczGEQSmo+8W/taUjB68Jx8lz/WCPVjcc7l8RbOHEEXRTWNoPp5Yg4fuCvxow1T
 49jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778210994; x=1778815794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lJmhjOsKwlhumjah92E6QoOuFpBkBkboZyPtw6rFI6c=;
 b=RVyhV3a0QpXi9seob8EdRnNnZOQnujqbM3fb5+vO0AiEN3BG52k6/Bu4rxpm71USi2
 xOjqtymwYCGc3bXoVuSQWmJrJYGY+3I6LclHK9JGEMPicnpMcKoW7QniYUqB5AdJgVka
 hC36HsRF2LH7g/K7EvlbQUU/1dYzNh1AmGkbLaobC2LGnepnOWGd47WGQudh4S8TLdNU
 9I9ICuYxEZK3EU36qm3ZgLUbiy1FoSRkFahgHDIR9IzG3vwhJuNr2QnuSzYq7xePq84t
 OINawwrzE40dF+8XoNKDHhj6WQ0KeLQFpcBAj0UJmP99Ghy78OT+/lUQmJ45XC4GVrls
 daug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/a2Zd/5zcCE40Ow7dkFvizlSs75KwFAdkNP5l9tYr0Xr5U6aHPkBTNWuZL37nhv1pnn47m2DWw31TC@nongnu.org
X-Gm-Message-State: AOJu0YyTT466Pz9d6C+6Y3SgnuCuFsHCaWRGqc+T2Uwr8VOCsQve7Iqu
 HFIdxNhk4UxT8fJUZniPfhwswOHrho3wc85zoXQtfuCU59vZTDSPZk6/2SxsNzEs+yku/wN6By6
 PuqsEu8x2GdOPy+5web+K0v8JJc+myDA=
X-Gm-Gg: AeBDievIf/sCYKo4W3LkPSMzYlqo8ISm23qQsct+CnizPHUYaypA+0JSrpvbdgq9mAb
 siJ6QU7k/2D7S94wrVGc+q9cMzrLTGG9Fc7WWlKvtffGjxH7Xkpq7WvY55XjN9EilNYdTedIpU5
 p9BBmMhU5zCQn0dmgNy1OJi0anBvKFP5uPlc66kGvBBpBA7C5zYX/60Icvm9jtgEb3TERrhBDZK
 4do2dJqq/EZFZ3k7LOu+gZz3wWT6B60dqQL9c6YOzd39EX9lQH4OmAvT2b5ZTVc8puyI6ciQswj
 pIL3J6KToHVKGIzc22y1uQyQFxPZRPrNQwGM6w==
X-Received: by 2002:a17:906:4792:b0:ba9:aeaa:fd18 with SMTP id
 a640c23a62f3a-bc56e5fd15cmr661531466b.28.1778210994193; Thu, 07 May 2026
 20:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260503180252.1122776-1-mohamedaymanworkspace@gmail.com>
In-Reply-To: <20260503180252.1122776-1-mohamedaymanworkspace@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 May 2026 13:29:27 +1000
X-Gm-Features: AVHnY4JvXhavkbfqajf0QWffoVFmxe7tksDL1KpCR-ZbJWrFvYQi1QtU5WNhF8Q
Message-ID: <CAKmqyKNtyqtHfyZDxZ-gAyJsw8fKTTLMSun6xM-d=gXrioO=tQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: virt: avoid RISCVCPU copy in PMU FDT setup
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Mon, May 4, 2026 at 4:04=E2=80=AFAM Mohamed Ayman
<mohamedaymanworkspace@gmail.com> wrote:
>
> Use a pointer to the hart instead of copying RISCVCPU when
> passing pmu_avail_ctrs to riscv_pmu_generate_fdt_node().
>
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a1c323e66d..085971eedc 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -722,11 +722,11 @@ static void create_fdt_pmu(RISCVVirtState *s)
>  {
>      g_autofree char *pmu_name =3D g_strdup_printf("/pmu");
>      MachineState *ms =3D MACHINE(s);
> -    RISCVCPU hart =3D s->soc[0].harts[0];
> +    RISCVCPU *hart =3D &s->soc[0].harts[0];
>
>      qemu_fdt_add_subnode(ms->fdt, pmu_name);
>      qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu"=
);
> -    riscv_pmu_generate_fdt_node(ms->fdt, hart.pmu_avail_ctrs, pmu_name);
> +    riscv_pmu_generate_fdt_node(ms->fdt, hart->pmu_avail_ctrs, pmu_name)=
;
>  }
>
>  static void create_fdt_sockets(RISCVVirtState *s,
> --
> 2.34.1
>
>

