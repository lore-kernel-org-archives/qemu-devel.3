Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC98C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 01:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgYJ1-0000m4-LE; Sun, 05 Jul 2026 21:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYIw-0000k5-4A
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:39:26 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgYIu-0005cM-B1
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 21:39:25 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c126f9c9567so285830966b.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 18:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783301962; cv=none;
 d=google.com; s=arc-20260327;
 b=iGDDQbT7wscwk1piujLFsiIpes4M7UkhW350lBtp718Mxr+J9LnHXKH7z1CtxKNSt3
 QY1mIqxcZawZkeKgNH4c7vN1IAZcGEZqbeIYaRFuKeuQjXKV8v8Cix2LcCYFNcYmEu3v
 ysdkmMPAn+aJvRFcmTeEwJYaDJsJimqlZVovR0fTOmdwVXugYf4zoaIsF2DQkU59/KFe
 zdlvi3RoUwcwr5xQjEfoYYnWML7F99OmjWi+uE6K3lQqjQU3i5AYe+4cnyGgoicDvHmB
 rdKOPtkgys1z4GBBFB4gvrlqJv31v4oTYnx4vzhjSgb1CiO8wgJhfPeTESZw7jN0B7hy
 dIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y5SuvtEFpJ2k/+XJpFH8bILzQ9D96TvC1AL2pGYpWPM=;
 fh=1E/NiP9vHe3YwUql4eml1OsMxtsZZHuAeFvc6r0wbzU=;
 b=S0K8EST/TiXegzk+rzZ9v7ZyePxw64Uun8oJQZR5ja7b69T0XqD/o/Byr20cAUDkKx
 SB1n6P5fou6uqfOYkbtiz2bQ+d0AKmGJS8mgV3EQsWRClAIHvp1C87Yt6FpgFJ7JBn+F
 S3MJfsS9fDxpqXXqYosKuXuXE3wu7PZFuddrnSnBS8ct3dadHqSQO9ZvOYJQtatFu0DS
 M1zLbdYoJ4OgvC31neeHB0N5qDigeSWZy7juWkEiEObtiM0yBLRxXYqeSh7OxGjEgQHJ
 lGZgMJlR0SD3be9llPeETS8D3QEbJsady+Du67W13jB7zerOKn4yFe0c1VS9BRE7Ivkr
 7yAw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783301962; x=1783906762; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5SuvtEFpJ2k/+XJpFH8bILzQ9D96TvC1AL2pGYpWPM=;
 b=jiitXlZw2UcE2Hle6ASXD7coUwsu6NScejVUqOphkim5PU5skrfgJFnb8I5art3MFI
 iUJdJb6iwDz+xnMGJmYtpafMw8fSSEnJElSr//EKisWdrrlHE2fDq8CsBf35tosLmoU/
 V5gCgMcewgF+UYJ55jKIqyav92gV9RnjowS0Bn7IvAbk1O73u+u5UkIw0MgtvVb3ksZy
 6s9gqKy3ZZSZHt6oXGtYdX9DfgzoTai5UR9NgtbMMNLXq1LoWgXwNbVLVFSENlIiwlKD
 u7Sq79CHqzNxCm7jgA5nUj1frt9jU9H0h10sxYm/mHeZw8Rf00lsBQYapElJC3BnWc3R
 O1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783301962; x=1783906762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y5SuvtEFpJ2k/+XJpFH8bILzQ9D96TvC1AL2pGYpWPM=;
 b=JlbNWV+YG3ccuDQYKn0jY8vCdF+6CDzfSR272dFQh9tKhxyxt+9s0CwsFMCewOWlIj
 Kkd74TvRQoE8/4DKl5wSix+n/SHX6NsixTK7RZuMVBNhAcygQZ4JqOZ/nr+5uVW1QXno
 ih/Qwz5UJxRHiIX4qF500jc/9gG/0SRiW5nWniBDg1H8mNgRznVpHU2Ksc4BQ5xxuyd0
 Q3UYPNFHf3RKuezb9uvHr8IuyNYapgKbUz0WJd2MEM818GGzKhGfM9F4pjQV1i5CtjBx
 4qZj0/TMU08+X29X9ULc2057brUjQxiXyflpHtut0JH9B+MgR45f69iHyfew3mVuCpeP
 kHig==
X-Forwarded-Encrypted: i=1;
 AFNElJ94PFeBY0mbad3QMfPpFHCziNXMMczV6fu2f4Nmo3qnSfPHh8yUWvSjhNx3zj+wYOAC6A7FZZ0XP34c@nongnu.org
X-Gm-Message-State: AOJu0Yzv7cPQMqpf/6CI3Dt67X+bIaPlduuglDtTWom7vtWTxtxG8YAX
 eaK2zfiRhN4nrYJbWDy8xuOt5CRJNNEh19jtyQ9Z7HNsL5W51Hlo6A7cW6opKp8irFPOQfu5F9h
 yzluEPx4fcdpDAhKrlaMa2AN8Zgc8hNg=
X-Gm-Gg: AfdE7ckJ5yQ7pnuNe3vuMymvXok/FLIS+Ji4It5XAzyqVTn4Bbic7VR1iofpgh+ifP+
 L2FIT47m1VAACJhx/SNXHwPhRn2Y3hgSHc5qUL4KSHrQr5JCWtd2x7t6PIePtRzExVM109LKvHa
 P78oH8C0J1sMRZAbX4uS8/+HW3SBNNwR6HyuNEnmlg7Mx8JIXV9Vjlp81PN2eXjpbyxjaqhCByL
 4FJZ+XD8YuWGoriTjEGp1Csyne3WYBhMYSSjMl3Nzr0sLM9+Y25QwHF/vuNARoWiKPgeHrHoRwP
 luQ0lHHCJ87Psqg3obGszSRkkPQ=
X-Received: by 2002:a17:907:a03:b0:c12:7e24:a76f with SMTP id
 a640c23a62f3a-c12e6959c14mr317990066b.20.1783301962358; Sun, 05 Jul 2026
 18:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260705063147.199732-1-heinrich.schuchardt@canonical.com>
 <20260705063147.199732-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260705063147.199732-3-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 11:38:55 +1000
X-Gm-Features: AVVi8Ce92797Kr2Ay-vwHrugxVa5VRq5Jn-MUz4OpiTbLyMUg9GKHvPWizJAOsw
Message-ID: <CAKmqyKO=WL98F0onFxE4wfazek2VcCu7zS4Vo8ZQGDmp4O56Vw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] hw/acpi: correct field sequence in SPCR table
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
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

On Sun, Jul 5, 2026 at 4:31=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On LoongArch and RISC-V invalid SPCR tables are created:
>
>     Terminal Type : 00
>     Language : 03
>
> The correct values are:
>
>     Terminal Type : 03
>     Language : 00
>
> This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
> SPCR creation to common location") that swapped the fields.
>
> See the specification of the table in
> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial=
-port-console-redirection-table
>
> This page shows version 1.10. But the sequence of the fields was not chan=
ged
> since version 1.0.
>
> Our LoongArch and ARM code uses version 1.07 of the specification.
> Our RISC-V code uses version 1.10 of the specification.
>
> Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to =
common location")
> Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> v5:
>         no change
> v4:
>         Reproduce the test data changes using rebuild-expected-aml.sh
>         creating the same diff as v3 but in two separate patches.
> v3:
>         Update test data
> v2:
>         Mention the different specification versions used by our code
>         https://lore.kernel.org/qemu-devel/20260326144835.67911-1-heinric=
h.schuchardt@canonical.com/
> v1:
>         https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinric=
h.schuchardt@canonical.com/T/#u
> ---
>  hw/acpi/aml-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 9b3cdd3781..990abc64cd 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2144,10 +2144,10 @@ void build_spcr(GArray *table_data, BIOSLinker *l=
inker,
>      build_append_int_noprefix(table_data, f->stop_bits, 1);
>      /* Flow Control */
>      build_append_int_noprefix(table_data, f->flow_control, 1);
> -    /* Language */
> -    build_append_int_noprefix(table_data, f->language, 1);
>      /* Terminal Type */
>      build_append_int_noprefix(table_data, f->terminal_type, 1);
> +    /* Language */
> +    build_append_int_noprefix(table_data, f->language, 1);
>      /* PCI Device ID  */
>      build_append_int_noprefix(table_data, f->pci_device_id, 2);
>      /* PCI Vendor ID */
> --
> 2.53.0
>

